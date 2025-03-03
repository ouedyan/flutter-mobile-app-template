import 'package:flutter/material.dart';
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

class DemoQueryScreen extends HookConsumerWidget {
  const DemoQueryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsQuery = useQuery<ProductsResponseDto>(
      ['getProducts'],
      ref.read(apiServiceProvider).demo.getProducts,
      ref,
      options: QueryOptions(
        onError: (e) {
          SnackBarUtils.handleError(context, e);
        },
      ),
    );

    final products = productsQuery.data?.products ?? [];

    return PageScaffold<MainRootScaffold>(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary, title: const Text('useQuery Demo')),
      body: RefreshIndicator(
        onRefresh: productsQuery.refetch,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Products List', style: Theme.of(context).textTheme.titleLarge),
              Gap(16.h),
              if (productsQuery.isLoading)
                const Center(child: CircularProgressIndicator())
              else if (productsQuery.error != null)
                Center(
                  child: Column(
                    children: [
                      Text('Error loading products', style: TextStyle(color: Theme.of(context).colorScheme.error)),
                      Gap(8.h),
                      FilledButton(onPressed: productsQuery.refetch, child: const Text('Retry')),
                    ],
                  ),
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: products.length,
                  separatorBuilder: (context, index) => Gap(16.h),
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ProductCard(product: product);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
