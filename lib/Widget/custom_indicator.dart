import 'package:flutter/material.dart';
import '../Utils/app_color.dart';

class TopIndicator extends Decoration {
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _TopIndicatorBox();
  }
}

class _TopIndicatorBox extends BoxPainter {
  @override
  void paint(
    Canvas canvas,
    Offset offset,
    ImageConfiguration cfg,
  ) {
    Paint paint = Paint()
      ..color = CustomColor.btnSelect
      ..strokeWidth = 2
      ..isAntiAlias = true;

    canvas.drawLine(
      offset,
      Offset(
        cfg.size!.width + offset.dx,
        0,
      ),
      paint,
    );
  }
}
