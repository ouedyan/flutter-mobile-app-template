import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_mobile_template/widgets/scaffold/page_scaffold.dart';

import '../../../services/api/api_service.dart';
import '../../../utils/data/hooks/use_query.dart';
import '../../../widgets/scaffold/main_root_scaffold.dart';
import '../../../widgets/snackbars.dart';
import '../data/models/product.dto.dart';
import '../widgets/product_card.dart';

class DemoInfiniteQueryScreen extends HookConsumerWidget {
  const DemoInfiniteQueryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsQuery = useInfiniteQuery<ProductsResponseDto>(
      ['getProducts'],
      (pageParam) => ref.read(apiServiceProvider).demo.getProducts(skip: pageParam, limit: 10),
      ref,
      options: QueryOptions(
        onError: (e) {
          SnackBarUtils.handleError(context, e);
        },
      ),
      initialPageParam: 0,
      getNextPageParam: (lastPage, allPages) {
        if (lastPage.skip + lastPage.limit >= lastPage.total) return null;
        return lastPage.skip + lastPage.limit;
      },
    );

    final products = useMemoized(() => productsQuery.data?.pages.expand((page) => page.products).toList() ?? [], [
      productsQuery.data,
    ]);

    return PageScaffold<MainRootScaffold>(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('useInfiniteQuery Demo'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Invalidate the query to trigger a full refresh
          invalidateQueries(['getProducts']);
        },

        /// Using CustomScrollView with slivers to have a single scrollable view
        /// that includes both the header and the list content
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.all(16.w),
              sliver: SliverToBoxAdapter(
                child: Text('Products List (Infinite Scroll)', style: Theme.of(context).textTheme.titleLarge),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.all(16.w),
              sliver: Builder(
                builder: (context) {
                  if (productsQuery.isLoading) {
                    return const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()));
                  }

                  if (productsQuery.error != null) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              'Error loading products',
                              style: TextStyle(color: Theme.of(context).colorScheme.error),
                            ),
                            Gap(8.h),
                            FilledButton(onPressed: productsQuery.refetch, child: const Text('Retry')),
                          ],
                        ),
                      ),
                    );
                  }

                  /// Using SliverList for infinite scrolling because its lazy building of items
                  /// is crucial for our end-reached detection strategy, avoiding the need for scroll controllers
                  return SliverList.separated(
                    itemCount: products.length + 1,
                    separatorBuilder: (context, index) => Gap(16.h),
                    itemBuilder: (context, index) {
                      if (index == products.length) {
                        if (productsQuery.isFetching) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            child: const Center(child: CircularProgressIndicator()),
                          );
                        }

                        if (productsQuery.hasNextPage) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            productsQuery.fetchNextPage();
                          });
                        }

                        return const SizedBox.shrink();
                      }

                      final product = products[index];
                      return ProductCard(product: product);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
