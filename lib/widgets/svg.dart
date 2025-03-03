import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../gen/assets.gen.dart';

class Svg extends StatelessWidget {
  final String assetName;
  final bool matchTextDirection;
  final AssetBundle? bundle;
  final String? package;
  final double? width;
  final double? height;
  final BoxFit fit;
  final AlignmentGeometry alignment;
  final bool allowDrawingOutsideViewBox;
  final Widget Function(BuildContext)? placeholderBuilder;
  final String? semanticsLabel;
  final bool excludeFromSemantics;
  final Clip clipBehavior;
  final SvgTheme? theme;
  final ColorFilter? colorFilter;
  final Color? color;
  final bool matchTheme;

  const Svg(
    this.assetName, {
    super.key,
    this.matchTextDirection = false,
    this.bundle,
    this.package,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.allowDrawingOutsideViewBox = false,
    this.placeholderBuilder,
    this.semanticsLabel,
    this.excludeFromSemantics = false,
    this.clipBehavior = Clip.hardEdge,
    this.theme,
    this.colorFilter,
    this.color,
    this.matchTheme = false,
  });

  @override
  Widget build(BuildContext context) {
    final iconTheme = IconTheme.of(context);

    return SizedBox(
      width: width ?? (matchTheme ? iconTheme.size : null),
      height: height ?? (matchTheme ? iconTheme.size : null),
      child: SvgPicture.asset(
        assetName,
        matchTextDirection: matchTextDirection,
        bundle: bundle,
        package: package,
        width: width ?? (matchTheme ? iconTheme.size : null),
        height: height ?? (matchTheme ? iconTheme.size : null),
        fit: fit,
        alignment: alignment,
        allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
        placeholderBuilder: placeholderBuilder,
        semanticsLabel: semanticsLabel,
        excludeFromSemantics: excludeFromSemantics,
        clipBehavior: clipBehavior,
        theme: theme,
        colorFilter: colorFilter ??
            (color != null
                ? ColorFilter.mode(color!, BlendMode.srcIn)
                : (matchTheme ? ColorFilter.mode(iconTheme.color!, BlendMode.srcIn) : null)),
      ),
    );
  }
}

extension SvgIconUtils on SvgGenImage {
  Widget Svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme? theme,
    ColorFilter? colorFilter,
    Color? color,
    Clip clipBehavior = Clip.hardEdge,
    bool matchTheme = false,
  }) {
    return Builder(builder: (context) {
      final iconTheme = IconTheme.of(context);

      return SizedBox(
        width: width ?? (matchTheme ? iconTheme.size : null),
        height: height ?? (matchTheme ? iconTheme.size : null),
        child: this.svg(
          matchTextDirection: matchTextDirection,
          bundle: bundle,
          package: package,
          width: width ?? (matchTheme ? iconTheme.size : null),
          height: height ?? (matchTheme ? iconTheme.size : null),
          fit: fit,
          alignment: alignment,
          allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
          placeholderBuilder: placeholderBuilder,
          semanticsLabel: semanticsLabel,
          excludeFromSemantics: excludeFromSemantics,
          clipBehavior: clipBehavior,
          theme: theme,
          colorFilter: colorFilter ??
              (color != null
                  ? ColorFilter.mode(color, BlendMode.srcIn)
                  : (matchTheme ? ColorFilter.mode(iconTheme.color!, BlendMode.srcIn) : null)),
        ),
      );
    });
  }
}
