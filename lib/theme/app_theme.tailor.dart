// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_theme.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$AppThemeTailorMixin on ThemeExtension<AppTheme> {
  Color get primaryColor;
  Color get errorColor;
  TextStyle get h1;
  ButtonStyle get button;
  ButtonStyle get smallButton;
  TextStyle get link;

  @override
  AppTheme copyWith({
    Color? primaryColor,
    Color? errorColor,
    TextStyle? h1,
    ButtonStyle? button,
    ButtonStyle? smallButton,
    TextStyle? link,
  }) {
    return AppTheme(
      primaryColor: primaryColor ?? this.primaryColor,
      errorColor: errorColor ?? this.errorColor,
      h1: h1 ?? this.h1,
      button: button ?? this.button,
      smallButton: smallButton ?? this.smallButton,
      link: link ?? this.link,
    );
  }

  @override
  AppTheme lerp(covariant ThemeExtension<AppTheme>? other, double t) {
    if (other is! AppTheme) return this as AppTheme;
    return AppTheme(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
      errorColor: Color.lerp(errorColor, other.errorColor, t)!,
      h1: TextStyle.lerp(h1, other.h1, t)!,
      button: t < 0.5 ? button : other.button,
      smallButton: t < 0.5 ? smallButton : other.smallButton,
      link: TextStyle.lerp(link, other.link, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AppTheme &&
            const DeepCollectionEquality().equals(
              primaryColor,
              other.primaryColor,
            ) &&
            const DeepCollectionEquality().equals(
              errorColor,
              other.errorColor,
            ) &&
            const DeepCollectionEquality().equals(h1, other.h1) &&
            const DeepCollectionEquality().equals(button, other.button) &&
            const DeepCollectionEquality().equals(
              smallButton,
              other.smallButton,
            ) &&
            const DeepCollectionEquality().equals(link, other.link));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(primaryColor),
      const DeepCollectionEquality().hash(errorColor),
      const DeepCollectionEquality().hash(h1),
      const DeepCollectionEquality().hash(button),
      const DeepCollectionEquality().hash(smallButton),
      const DeepCollectionEquality().hash(link),
    );
  }
}

extension AppThemeBuildContextProps on BuildContext {
  AppTheme get appTheme => Theme.of(this).extension<AppTheme>()!;
  Color get primaryColor => appTheme.primaryColor;
  Color get errorColor => appTheme.errorColor;
  TextStyle get h1 => appTheme.h1;
  ButtonStyle get button => appTheme.button;
  ButtonStyle get smallButton => appTheme.smallButton;
  TextStyle get link => appTheme.link;
}
