import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_mobile_template/widgets/scaffold/page_scaffold.dart';

import '../../../utils/data/hooks/use_async_task.dart';
import '../../../widgets/snackbars.dart';
import '../data/products_provider.dart';
import '../widgets/product_card.dart';

class DemoInfiniteProviderScreen extends HookConsumerWidget {
  const DemoInfiniteProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final infiniteProductsProviderQuery = infiniteProductsProvider(size: 10);
    final productsAsync = ref.watch(infiniteProductsProviderQuery);

    final refreshTask = useAsyncTask(
      () => ref.read(infiniteProductsProviderQuery.notifier).refreshAll(),
      callbacks: AsyncTaskCallbacks(
        onError: (error) {
          SnackBarUtils.handleError(context, error);
        },
      ),
    );

    final fetchNextPage = useAsyncTask(
      () => ref.read(infiniteProductsProviderQuery.notifier).fetchNextPage(),
      callbacks: AsyncTaskCallbacks(
        onError: (error) {
          SnackBarUtils.handleError(context, error);
        },
      ),
    );

    final products = useMemoized(
      () => productsAsync.valueOrNull?.expand((element) => element.products).toList() ?? [],
      [productsAsync.valueOrNull],
    );

    return PageScaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Infinite Provider Demo'),
      ),
      body: RefreshIndicator(
        onRefresh: refreshTask.execute,

        /// Using CustomScrollView with slivers to have a single scrollable view
        /// that includes both the header and the list content
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.all(16.w),
              sliver: SliverToBoxAdapter(
                child: Text('Products List (Class Provider)', style: Theme.of(context).textTheme.titleLarge),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.all(16.w),
              sliver: Builder(
                builder: (context) {
                  if (productsAsync.isLoading) {
                    return const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()));
                  }

                  if (productsAsync.hasError) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              'Error loading products',
                              style: TextStyle(color: Theme.of(context).colorScheme.error),
                            ),
                            Gap(8.h),
                            FilledButton(onPressed: refreshTask.execute, child: const Text('Retry')),
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
                        if (fetchNextPage.snapshot.isLoading) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            child: const Center(child: CircularProgressIndicator()),
                          );
                        }

                        if (productsAsync.hasValue && productsAsync.value!.last.products.isNotEmpty) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            fetchNextPage.execute();
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
