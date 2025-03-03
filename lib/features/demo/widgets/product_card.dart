import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../data/models/product.dto.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product, this.onDelete});

  final ProductDto product;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: CachedNetworkImage(
                imageUrl: product.thumbnail,
                width: 80.w,
                height: 80.w,
                fit: BoxFit.cover,
                placeholder:
                    (context, url) => Container(
                      color: Theme.of(context).colorScheme.surfaceContainerHighest,
                      child: Center(child: CircularProgressIndicator(strokeWidth: 2.w)),
                    ),
                errorWidget:
                    (context, url, error) => Container(
                      color: Theme.of(context).colorScheme.surfaceContainerHighest,
                      child: Icon(Icons.error, size: 24.w),
                    ),
              ),
            ),
            Gap(16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(product.title, style: Theme.of(context).textTheme.titleMedium),
                            Gap(4.h),
                            Text(product.brand ?? 'No Brand', style: Theme.of(context).textTheme.bodyMedium),
                          ],
                        ),
                      ),
                      if (onDelete != null)
                        IconButton(
                          onPressed: onDelete,
                          icon: const Icon(Icons.delete),
                          color: Theme.of(context).colorScheme.error,
                        )
                      else
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('\$${product.price}', style: Theme.of(context).textTheme.titleMedium),
                            if (product.discountPercentage > 0)
                              Text(
                                '${product.discountPercentage}% OFF',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                          ],
                        ),
                    ],
                  ),
                  Gap(8.h),
                  Text(
                    product.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Gap(8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Rating: ${product.rating}', style: Theme.of(context).textTheme.bodyMedium),
                      Text('Stock: ${product.stock}', style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
