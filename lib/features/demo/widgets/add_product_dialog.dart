import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../services/api/api_service.dart';
import '../../../utils/data/hooks/use_async_task.dart';
import '../../../utils/data/hooks/use_query.dart';
import '../../../widgets/snackbars.dart';
import '../data/models/product.dto.dart';

class AddProductDialog extends HookConsumerWidget {
  const AddProductDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = useMemoized(
      () => FormGroup({
        'title': FormControl<String>(validators: [Validators.required]),
        'description': FormControl<String>(validators: [Validators.required]),
        'price': FormControl<double>(validators: [Validators.required, Validators.min(0)]),
      }),
    );

    final addProductTask = useAsyncTaskWithParams<ProductDto, ProductDto>(
      (product) => ref.read(apiServiceProvider).demo.addProduct(product),
      callbacks: ParameterizedAsyncTaskCallbacks(
        onSuccess: (response, params) {
          SnackBarUtils.showSuccessSnackBar(context, 'Product "${response.title}" added successfully');
          invalidateQueries(['getProducts']);
          Navigator.of(context, rootNavigator: true).pop();
        },
        onError: (error, params) {
          SnackBarUtils.handleError(context, error);
        },
      ),
    );

    return ReactiveForm(
      formGroup: form,
      child: ListView(
        shrinkWrap: true,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          Text('Add New Product', style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.center),
          Gap(24.h),
          ReactiveTextField(
            formControlName: 'title',
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          Gap(16.h),
          ReactiveTextField(
            formControlName: 'description',
            textInputAction: TextInputAction.next,
            minLines: 3,
            maxLines: null,
            decoration: const InputDecoration(labelText: 'Description'),
          ),
          Gap(16.h),
          ReactiveTextField(
            formControlName: 'price',
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(labelText: 'Price', prefixText: '\$'),
          ),
          Gap(31.h),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  child: const Text('Cancel'),
                ),
              ),
              Gap(24.w),
              ReactiveFormConsumer(
                builder: (context, formGroup, child) {
                  return Expanded(
                    child: FilledButton(
                      onPressed:
                          formGroup.valid && !addProductTask.snapshot.isLoading
                              ? () {
                                addProductTask.execute(
                                  ProductDto(
                                    id: 0, // Will be set by the server
                                    title: form.control('title').value,
                                    description: form.control('description').value,
                                    price: form.control('price').value,
                                    discountPercentage: 0,
                                    rating: 0,
                                    stock: 0,
                                    brand: 'Demo Brand',
                                    category: 'demo',
                                    thumbnail: 'https://via.placeholder.com/150',
                                    images: const ['https://via.placeholder.com/150'],
                                  ),
                                );
                              }
                              : null,
                      child: const Text('Add'),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
