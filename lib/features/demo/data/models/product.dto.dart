// ignore_for_file: annotate_overrides

import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.dto.freezed.dart';
part 'product.dto.g.dart';

@freezed
@JsonSerializable()
class ProductDto with _$ProductDto {
  const ProductDto({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    this.brand,
    required this.images,
    required this.thumbnail,
  });

  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final String? brand;
  final List<String> images;
  final String thumbnail;

  factory ProductDto.fromJson(Map<String, Object?> json) => _$ProductDtoFromJson(json);
  Map<String, Object?> toJson() => _$ProductDtoToJson(this);
}

@freezed
@JsonSerializable()
class ProductsResponseDto with _$ProductsResponseDto {
  const ProductsResponseDto({required this.products, required this.total, required this.skip, required this.limit});

  final List<ProductDto> products;
  final int total;
  final int skip;
  final int limit;

  factory ProductsResponseDto.fromJson(Map<String, Object?> json) => _$ProductsResponseDtoFromJson(json);
  Map<String, Object?> toJson() => _$ProductsResponseDtoToJson(this);
}
