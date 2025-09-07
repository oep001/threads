import 'package:flutter/material.dart';
import 'package:threads/constants/text_style.dart';

class TitleText extends Text {
  TitleText(
    super.data, {
    required BuildContext context,
    super.key,
    TextStyle? style,
    super.strutStyle,
    super.textAlign,
    super.textDirection,
    super.locale,
    super.softWrap,
    super.overflow,
    super.textScaler,
    super.maxLines,
    super.semanticsLabel,
    super.textWidthBasis,
    super.textHeightBehavior,
    super.selectionColor,
  }) : super(style: style ?? AppTextStyles.title(context));
}

class BoldText extends Text {
  BoldText(
    super.data, {
    required BuildContext context,
    super.key,
    TextStyle? style,
    super.strutStyle,
    super.textAlign,
    super.textDirection,
    super.locale,
    super.softWrap,
    super.overflow,
    super.textScaler,
    super.maxLines,
    super.semanticsLabel,
    super.textWidthBasis,
    super.textHeightBehavior,
    super.selectionColor,
  }) : super(style: style ?? AppTextStyles.bold(context));
}

class SemiBoldText extends Text {
  SemiBoldText(
    super.data, {
    required BuildContext context,
    super.key,
    TextStyle? style,
    super.strutStyle,
    super.textAlign,
    super.textDirection,
    super.locale,
    super.softWrap,
    super.overflow,
    super.textScaler,
    super.maxLines,
    super.semanticsLabel,
    super.textWidthBasis,
    super.textHeightBehavior,
    super.selectionColor,
  }) : super(style: style ?? AppTextStyles.semiBold(context));
}

class SemiLightText extends Text {
  SemiLightText(
    super.data, {
    required BuildContext context,
    super.key,
    TextStyle? style,
    super.strutStyle,
    super.textAlign,
    super.textDirection,
    super.locale,
    super.softWrap,
    super.overflow,
    super.textScaler,
    super.maxLines,
    super.semanticsLabel,
    super.textWidthBasis,
    super.textHeightBehavior,
    super.selectionColor,
  }) : super(style: style ?? AppTextStyles.semiLight(context));
}

class LightText extends Text {
  LightText(
    super.data, {
    required BuildContext context,
    super.key,
    TextStyle? style,
    super.strutStyle,
    super.textAlign,
    super.textDirection,
    super.locale,
    super.softWrap,
    super.overflow,
    super.textScaler,
    super.maxLines,
    super.semanticsLabel,
    super.textWidthBasis,
    super.textHeightBehavior,
    super.selectionColor,
  }) : super(style: style ?? AppTextStyles.light(context));
}
