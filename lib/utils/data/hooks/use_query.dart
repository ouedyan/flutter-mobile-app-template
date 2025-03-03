import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Represents a query key as a list of objects.
/// This allows for complex, hierarchical query keys.
typedef QueryKey = List<Object?>;

/// Converts a QueryKey to a string for use as a map key.
String _queryKeyToString(QueryKey queryKey) {
  return queryKey.map((e) => e.toString()).join('|');
}

// useQuery

/// Represents the result of a query, including its data, error state, and loading status.
class QueryResult<T> {
  /// The data returned by the query.
  /// It's null if the query hasn't completed successfully yet.
  /// When `keepPreviousData` is true in QueryOptions, this field may contain
  /// data from a previous successful query while a new query is in progress.
  /// In such cases, `isPreviousData` will be true.
  final T? data;

  /// The error that occurred during the query execution.
  /// It's null if no error occurred.
  final Object? error;

  /// Indicates whether the query is in its initial loading state.
  /// True when the query is first run and there's no cached data.
  /// If `keepPreviousData` is true and we have data from a previous query,
  /// this will be false even when fetching new data.
  final bool isLoading;

  /// Indicates whether the query is currently fetching data.
  /// This can be true even if we already have data from a previous query.
  /// Use this to show loading indicators while refreshing data.
  final bool isFetching;

  /// Indicates whether the current data is from a previous successful query
  /// while a new query is in progress.
  /// This is true when `keepPreviousData` is set to true in QueryOptions,
  /// we have data from a previous query, and a new query is in progress.
  /// Use this flag to detect if the current data is potentially outdated.
  final bool isPreviousData;

  /// Indicates whether the current data is considered stale.
  /// This is set to true when the query is invalidated or when the stale time has passed.
  final bool isStale;

  /// The timestamp of when the data was last successfully updated.
  /// Useful for determining if the data is stale.
  /// This is updated whenever new data is successfully fetched.
  final DateTime? lastUpdated;

  /// A function to manually refetch the query data.
  /// This allows users to refresh the data on demand.
  /// When called, it will set `isFetching` to true and execute the query function again.
  final Future<void> Function() refetch;

  QueryResult({
    this.data,
    this.error,
    this.isLoading = true,
    this.isFetching = false,
    this.isPreviousData = false,
    this.isStale = false,
    this.lastUpdated,
    required this.refetch,
  });

  QueryResult<T> copyWith({
    T? data,
    Object? error,
    bool? isLoading,
    bool? isFetching,
    bool? isPreviousData,
    bool? isStale,
    DateTime? lastUpdated,
    Future<void> Function()? refetch,
  }) {
    return QueryResult<T>(
      data: data ?? this.data,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      isFetching: isFetching ?? this.isFetching,
      isPreviousData: isPreviousData ?? this.isPreviousData,
      isStale: isStale ?? this.isStale,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      refetch: refetch ?? this.refetch,
    );
  }
}

/// Type definition for the query function
typedef QueryFn<T> = Future<T> Function();

/// Configuration options for a query
class QueryOptions<T> {
  /// Whether the query should automatically run
  final bool enabled;

  /// Duration until the data is considered stale
  final Duration staleTime;

  /// Duration until the cache is invalidated
  final Duration cacheTime;

  /// Whether to keep the previous data while fetching new data
  final bool keepPreviousData;

  /// Number of times to retry the query on failure
  final int retryCount;

  /// Delay between retry attempts
  final Duration retryDelay;

  /// Callback function called when the query successfully fetches data
  final void Function(T data)? onSuccess;

  /// Callback function called when the query encounters an error
  final void Function(Object error)? onError;

  /// Callback function called when the query settles (either success or error)
  final void Function()? onSettled;

  const QueryOptions({
    this.enabled = true,
    this.staleTime = Duration.zero,
    this.cacheTime = const Duration(minutes: 5),
    this.keepPreviousData = false,
    this.retryCount = 3,
    this.retryDelay = const Duration(seconds: 1),
    this.onSuccess,
    this.onError,
    this.onSettled,
  });
}

/// Manages the state of a single query.
class QueryNotifier<T> extends StateNotifier<QueryResult<T>> {
  QueryNotifier(QueryFn<T> queryFn, QueryOptions<T> options)
    : super(QueryResult<T>(isLoading: true, refetch: () => Future.value())) {
    _queryFn = queryFn;
    _options = options;
    state = state.copyWith(refetch: runQuery);
  }

  late QueryFn<T> _queryFn;
  late QueryOptions<T> _options;
  int _retryCount = 0;
  late bool _isActive;

  /// Executes the query, handling retries and invoking callbacks
  Future<void> runQuery({bool isRecursiveErrorRetry = false}) async {
    // if (!_isActive) return;

    // debugPrint('----------state is already fetching: ${state.isFetching}');

    if (!isRecursiveErrorRetry) {
      // TODO: problematic, check
      // if (state.isFetching) return;

      state = state.copyWith(
        data: _options.keepPreviousData ? state.data : null,
        isFetching: true,
        isPreviousData: _options.keepPreviousData && state.data != null,
        isStale: false,
      );
    }

    try {
      final data = await _queryFn();
      state = QueryResult<T>(
        data: data,
        isLoading: false,
        isFetching: false,
        isPreviousData: false,
        isStale: false,
        lastUpdated: DateTime.now(),
        refetch: runQuery,
      );

      // To avoid catching callbacks error
      Future(() {
        _options.onSuccess?.call(data);
        _options.onSettled?.call();
      });
      _retryCount = 0;
    } catch (e) {
      debugPrint('----------useQuery error ! $e');
      debugPrint('----------useQuery _retryCount ! $_retryCount');

      if (_retryCount < _options.retryCount) {
        _retryCount++;
        await Future.delayed(_options.retryDelay);
        return await runQuery(isRecursiveErrorRetry: true);
      }

      state = QueryResult<T>(
        data: _options.keepPreviousData ? state.data : null,
        error: e,
        isLoading: false,
        isFetching: false,
        isPreviousData: _options.keepPreviousData && state.data != null,
        isStale: true,
        refetch: runQuery,
      );
      _options.onError?.call(e);
      _options.onSettled?.call();
    }
  }

  bool _isDataStale() {
    final now = DateTime.now();
    return state.lastUpdated == null || now.difference(state.lastUpdated!) > _options.staleTime;
  }

  void checkAndUpdateStaleState() {
    // debugPrint("----------checkAndUpdateStaleState starting");
    // debugPrint("----------_isDataStale(): ${_isDataStale()}");
    // debugPrint("----------state.isStale: ${state.isStale}");
    // debugPrint("----------_isActive : $_isActive");

    if (_isDataStale() && !state.isStale) {
      state = state.copyWith(isStale: true);
      if (_isActive) {
        runQuery();
      }
    }
  }

  /// Invalidates the current query state
  void invalidate() {
    state = state.copyWith(isStale: true);
    if (_isActive) {
      runQuery();
    }
  }

  /// Updates the active state of the notifier
  void updateActive(bool active) {
    _isActive = active;
  }

  /// Updates the query function
  void updateQueryFn(QueryFn<T> newQueryFn) {
    _queryFn = newQueryFn;
  }

  /// Updates the query options
  void updateOptions(QueryOptions<T> newOptions) {
    _options = newOptions;
  }
}

/// Global map to store query notifiers, allowing for centralized query management.
final _queryNotifiers = <String, QueryNotifier>{};

/// A custom hook that provides React Query-like functionality in Flutter.
///
/// [queryKey] is a unique identifier for the query, used for caching and invalidation.
/// [queryFn] is an asynchronous function that fetches the data.
/// [ref] is the WidgetRef, used for state management with Riverpod.
/// [options] is a QueryOptions object that configures the behavior of the query.
/// The [options.keepPreviousData] setting affects how `data` and `isPreviousData`
/// behave in the returned QueryResult.
QueryResult<T> useQuery<T>(
  QueryKey queryKey,
  QueryFn<T> queryFn,
  WidgetRef ref, {
  QueryOptions<T> options = const QueryOptions(),
}) {
  final queryKeyString = _queryKeyToString(queryKey);

  final provider = useMemoized(
    () => StateNotifierProvider<QueryNotifier<T>, QueryResult<T>>((ref) {
      return _queryNotifiers.putIfAbsent(queryKeyString, () => QueryNotifier<T>(queryFn, options)) as QueryNotifier<T>;
    }),
  );

  final queryNotifier = ref.read(provider.notifier);
  final queryState = ref.watch(provider);

  useEffect(() {
    queryNotifier.updateQueryFn(queryFn);
    queryNotifier.updateOptions(options);
    queryNotifier.updateActive(true);

    if (options.enabled) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        queryNotifier.checkAndUpdateStaleState();
      });
    }

    return () {
      final removeDelay = options.cacheTime - options.staleTime;
      if (removeDelay > Duration.zero) {
        Future.delayed(removeDelay, () {
          _queryNotifiers.remove(queryKeyString);
        });
      }
    };
  }, [queryKeyString, options.enabled]);

  useEffect(() {
    return () {
      queryNotifier.updateActive(false);
    };
  }, []);

  return queryState;
}

// useInfiniteQuery

class InfiniteQueryResult<TData> extends QueryResult<InfiniteData<TData>> {
  final bool hasNextPage;
  final Future<void> Function() fetchNextPage;

  InfiniteQueryResult({
    super.data,
    super.error,
    super.isLoading,
    super.isFetching,
    super.isPreviousData,
    super.isStale,
    super.lastUpdated,
    required super.refetch,
    required this.hasNextPage,
    required this.fetchNextPage,
  });

  @override
  InfiniteQueryResult<TData> copyWith({
    InfiniteData<TData>? data,
    Object? error,
    bool? isLoading,
    bool? isFetching,
    bool? isPreviousData,
    bool? isStale,
    DateTime? lastUpdated,
    Future<void> Function()? refetch,
    bool? hasNextPage,
    Future<void> Function()? fetchNextPage,
  }) {
    return InfiniteQueryResult<TData>(
      data: data ?? this.data,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      isFetching: isFetching ?? this.isFetching,
      isPreviousData: isPreviousData ?? this.isPreviousData,
      isStale: isStale ?? this.isStale,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      refetch: refetch ?? this.refetch,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      fetchNextPage: fetchNextPage ?? this.fetchNextPage,
    );
  }
}

class InfiniteData<T> {
  final List<T> pages;
  final List<dynamic> pageParams;

  InfiniteData({required this.pages, required this.pageParams});
}

typedef InfiniteQueryFn<TData> = Future<TData> Function(dynamic pageParam);

class InfiniteQueryNotifier<TData> extends StateNotifier<InfiniteQueryResult<TData>> {
  InfiniteQueryNotifier(
    InfiniteQueryFn<TData> queryFn,
    QueryOptions<InfiniteData<TData>> options,
    dynamic initialPageParam,
    dynamic Function(TData lastPage, List<TData> allPages)? getNextPageParam,
  ) : super(
        InfiniteQueryResult<TData>(
          isLoading: true,
          refetch: () => Future.value(),
          hasNextPage: true,
          fetchNextPage: () => Future.value(),
        ),
      ) {
    _queryFn = queryFn;
    _options = options;
    _currentPageParam = initialPageParam;
    _getNextPageParam = getNextPageParam;
    state = state.copyWith(refetch: runQuery, fetchNextPage: fetchNextPage);
  }

  late InfiniteQueryFn<TData> _queryFn;
  late QueryOptions<InfiniteData<TData>> _options;
  late dynamic _currentPageParam;
  late dynamic Function(TData lastPage, List<TData> allPages)? _getNextPageParam;
  final List<TData> _pages = [];
  final List<dynamic> _pageParams = [];
  int _retryCount = 0;
  late bool _isActive;

  Future<void> runQuery({bool isRecursiveErrorRetry = false}) async {
    if (!isRecursiveErrorRetry) {
      state = state.copyWith(
        data: _options.keepPreviousData ? state.data : null,
        isFetching: true,
        isPreviousData: _options.keepPreviousData && state.data != null,
        isStale: false,
      );
    }

    try {
      final newPage = await _queryFn(_currentPageParam);
      _pages.add(newPage);
      _pageParams.add(_currentPageParam);

      final nextPageParam = _getNextPageParam?.call(newPage, _pages);
      final hasNextPage = nextPageParam != null;

      state = state.copyWith(
        data: InfiniteData(pages: _pages, pageParams: _pageParams),
        isLoading: false,
        isFetching: false,
        isPreviousData: false,
        isStale: false,
        lastUpdated: DateTime.now(),
        hasNextPage: hasNextPage,
      );

      _currentPageParam = nextPageParam;

      Future(() {
        _options.onSuccess?.call(state.data!);
        _options.onSettled?.call();
      });
      _retryCount = 0;
    } catch (e) {
      debugPrint('----------useInfiniteQuery error ! $e');
      debugPrint('----------useInfiniteQuery _retryCount ! $_retryCount');

      if (_retryCount < _options.retryCount) {
        _retryCount++;
        await Future.delayed(_options.retryDelay);
        return await runQuery(isRecursiveErrorRetry: true);
      }

      state = state.copyWith(
        data: _options.keepPreviousData ? state.data : null,
        error: e,
        isLoading: false,
        isFetching: false,
        isPreviousData: _options.keepPreviousData && state.data != null,
        isStale: true,
        hasNextPage: false,
      );
      _options.onError?.call(e);
      _options.onSettled?.call();
    }
  }

  Future<void> fetchNextPage() async {
    if (!state.hasNextPage || state.isFetching) return;
    await runQuery();
  }

  bool _isDataStale() {
    final now = DateTime.now();
    return state.lastUpdated == null || now.difference(state.lastUpdated!) > _options.staleTime;
  }

  void checkAndUpdateStaleState() {
    if (_isDataStale() && !state.isStale) {
      state = state.copyWith(isStale: true);
      if (_isActive) {
        runQuery();
      }
    }
  }

  /// Invalidates the current query state
  void invalidate() {
    state = state.copyWith(isStale: true);
    if (_isActive) {
      _pages.clear();
      _pageParams.clear();
      _currentPageParam = 0;
      runQuery();
    }
  }

  /// Updates the active state of the notifier
  void updateActive(bool active) {
    _isActive = active;
  }

  /// Updates the query function
  void updateQueryFn(InfiniteQueryFn<TData> newQueryFn) {
    _queryFn = newQueryFn;
  }

  /// Updates the query options
  void updateOptions(QueryOptions<InfiniteData<TData>> newOptions) {
    _options = newOptions;
  }
}

final _infiniteQueryNotifiers = <String, InfiniteQueryNotifier>{};

InfiniteQueryResult<TData> useInfiniteQuery<TData>(
  QueryKey queryKey,
  InfiniteQueryFn<TData> queryFn,
  WidgetRef ref, {
  QueryOptions<InfiniteData<TData>> options = const QueryOptions(),
  dynamic initialPageParam,
  dynamic Function(TData lastPage, List<TData> allPages)? getNextPageParam,
}) {
  final queryKeyString = _queryKeyToString(queryKey);

  final provider = useMemoized(
    () => StateNotifierProvider<InfiniteQueryNotifier<TData>, InfiniteQueryResult<TData>>((ref) {
      return _infiniteQueryNotifiers.putIfAbsent(
            queryKeyString,
            () => InfiniteQueryNotifier<TData>(queryFn, options, initialPageParam, getNextPageParam),
          )
          as InfiniteQueryNotifier<TData>;
    }),
  );

  final queryNotifier = ref.read(provider.notifier);
  final queryState = ref.watch(provider);

  useEffect(() {
    queryNotifier.updateQueryFn(queryFn);
    queryNotifier.updateOptions(options);
    queryNotifier.updateActive(true);

    if (options.enabled) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        queryNotifier.checkAndUpdateStaleState();
      });
    }

    return () {
      final removeDelay = options.cacheTime - options.staleTime;
      if (removeDelay > Duration.zero) {
        Future.delayed(removeDelay, () {
          _infiniteQueryNotifiers.remove(queryKeyString);
        });
      }
    };
  }, [queryKeyString, options.enabled]);

  useEffect(() {
    return () {
      queryNotifier.updateActive(false);
    };
  }, []);

  return queryState;
}

// Query invalidation functions

/// Invalidates a specific query, forcing it to refetch on the next render.
///
/// [queryKey] is the unique identifier of the query to invalidate.
void invalidateQuery(QueryKey queryKey) {
  final queryKeyString = _queryKeyToString(queryKey);
  final queryNotifier = _queryNotifiers[queryKeyString];
  final infiniteQueryNotifier = _infiniteQueryNotifiers[queryKeyString];

  if (queryNotifier != null) {
    queryNotifier.invalidate();
  }

  if (infiniteQueryNotifier != null) {
    infiniteQueryNotifier.invalidate();
  }
}

/// Invalidates all queries that match the given partial key.
///
/// [partialQueryKey] is a partial key used to match multiple queries.
void invalidateQueries(QueryKey partialQueryKey) {
  final partialKeyString = _queryKeyToString(partialQueryKey);

  _queryNotifiers.forEach((key, notifier) {
    if (key.startsWith(partialKeyString)) {
      notifier.invalidate();
    }
  });

  _infiniteQueryNotifiers.forEach((key, notifier) {
    if (key.startsWith(partialKeyString)) {
      notifier.invalidate();
    }
  });
}

/// Invalidates all active queries.
void invalidateAllQueries() {
  for (var notifier in _queryNotifiers.values) {
    notifier.invalidate();
  }

  for (var notifier in _infiniteQueryNotifiers.values) {
    notifier.invalidate();
  }
}
