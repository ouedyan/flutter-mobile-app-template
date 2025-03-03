import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_mobile_template/widgets/scaffold/page_scaffold.dart';

import '../../../services/api/api_service.dart';
import '../../../utils/data/hooks/use_async_task.dart';
import '../../../utils/data/hooks/use_query.dart';
import '../../../widgets/dialogs/utils.dart';
import '../../../widgets/scaffold/main_root_scaffold.dart';
import '../../../widgets/snackbars.dart';
import '../data/models/product.dto.dart';
import '../widgets/add_product_dialog.dart';
import '../widgets/product_card.dart';

class DemoMutationsScreen extends HookConsumerWidget {
  const DemoMutationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffoldMessengerKey = useRef(GlobalKey<ScaffoldMessengerState>());

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

    // Mutation to delete a product
    final deleteProductTask = useAsyncTaskWithParams<void, int>(
      (id) => ref.read(apiServiceProvider).demo.deleteProduct(id),
      callbacks: ParameterizedAsyncTaskCallbacks(
        onSuccess: (_, params) {
          SnackBarUtils.showSuccessSnackBar(context, 'Product deleted successfully');
          invalidateQueries(['getProducts']);
        },
        onError: (error, params) {
          SnackBarUtils.handleError(context, error);
        },
      ),
    );

    void showAddProductDialog() {
      DialogUtils.showDialog(context, (context) => const AddProductDialog());
    }

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scaffoldMessengerKey.value.currentState?.showMaterialBanner(
          MaterialBanner(
            content: const Text(
              'DummyJSON API: mutations (add/delete product) are simulated and won\'t persist on the server.',
              style: TextStyle(fontSize: 13),
            ),
            leading: Icon(Icons.info_outline, color: context.theme.colorScheme.error),
            backgroundColor: context.theme.colorScheme.errorContainer,
            actions: [
              TextButton(
                onPressed: () => scaffoldMessengerKey.value.currentState?.hideCurrentMaterialBanner(),
                child: const Text('DISMISS'),
              ),
            ],
          ),
        );
      });
      return null;
    }, const []);

    return ScaffoldMessenger(
      key: scaffoldMessengerKey.value,
      child: PageScaffold<MainRootScaffold>(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Mutations Demo'),
        ),
        floatingActionButton: FloatingActionButton(onPressed: showAddProductDialog, child: const Icon(Icons.add)),
        body: RefreshIndicator(
          onRefresh: productsQuery.refetch,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Products List (with mutations)', style: Theme.of(context).textTheme.titleLarge),
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
                      return ProductCard(product: product, onDelete: () => deleteProductTask.execute(product.id));
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
