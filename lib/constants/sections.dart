import 'package:flutter/material.dart';

/// direction: 가로(Row) or 세로(Column)
/// ratios: [2,6,2] → 20%, 60%, 20%
/// children 길이와 ratios 길이는 같아야 합니다.
class Sections extends StatelessWidget {
  final Axis direction;
  final List<int> ratios;
  final List<Widget>? children;
  final double gap; // 섹션 사이 간격(비율이 아닌 px)

  const Sections({
    super.key,
    required this.direction,
    required this.ratios,
    this.children,
    this.gap = 0,
  });

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[];
    for (int i = 0; i < ratios.length; i++) {
      final Widget child = (children != null && i < children!.length)
          ? children![i]
          : Container();

      items.add(Expanded(flex: ratios[i], child: child));

      if (gap > 0 && i != ratios.length - 1) {
        items.add(
          direction == Axis.horizontal
              ? SizedBox(width: gap)
              : SizedBox(height: gap),
        );
      }
    }
    return direction == Axis.horizontal
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: items,
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: items,
          );
  }
}
