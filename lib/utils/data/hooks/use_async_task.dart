import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Watch https://riverpod.dev/docs/essentials/side_effects#going-further-showing-a-spinner--error-handling

class AsyncTaskCallbacks<T> {
  final void Function(T data)? onSuccess;
  final void Function(Object error)? onError;
  final void Function()? onStart;

  const AsyncTaskCallbacks({
    this.onSuccess,
    this.onError,
    this.onStart,
  });
}

class ParameterizedAsyncTaskCallbacks<T, P> {
  final void Function(T data, P params)? onSuccess;
  final void Function(Object error, P params)? onError;
  final void Function(P params)? onStart;

  const ParameterizedAsyncTaskCallbacks({
    this.onSuccess,
    this.onError,
    this.onStart,
  });
}

typedef ParameterizedAsyncTask<T, P> = ({
  Future<T> Function(P params) execute,
  AsyncSnapshot<T> snapshot,
});

typedef AsyncTask<T> = ({
  Future<T> Function() execute,
  AsyncSnapshot<T> snapshot,
});

ParameterizedAsyncTask<T, P> useAsyncTaskWithParams<T, P>(
  Future<T> Function(P params) taskFunction, {
  ParameterizedAsyncTaskCallbacks<T, P>? callbacks,
}) {
  final future = useState<Future<T>?>(null);
  final snapshot = useFuture(future.value);

  final execute = useCallback((P params) {
    callbacks?.onStart?.call(params);
    final newFuture = taskFunction(params);
    future.value = newFuture;

    newFuture.then((value) {
      callbacks?.onSuccess?.call(value, params);
    }).catchError((error) {
      callbacks?.onError?.call(error, params);
    });

    return newFuture;
  }, [taskFunction, callbacks]);

  return (
    execute: execute,
    snapshot: snapshot,
  );
}

AsyncTask<T> useAsyncTask<T>(
  Future<T> Function() taskFunction, {
  AsyncTaskCallbacks<T>? callbacks,
}) {
  final parameterizedTask = useAsyncTaskWithParams(
    (void _) => taskFunction(),
    callbacks: ParameterizedAsyncTaskCallbacks<T, void>(
      onSuccess: (data, _) => callbacks?.onSuccess?.call(data),
      onError: (error, _) => callbacks?.onError?.call(error),
      onStart: (_) => callbacks?.onStart?.call(),
    ),
  );

  return (
    execute: () => parameterizedTask.execute(null),
    snapshot: parameterizedTask.snapshot,
  );
}
