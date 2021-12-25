import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:student/model/student.dart';

class AnimatedLiquidCustomProgressIndicator extends StatefulWidget {
  final int curman;
  AnimatedLiquidCustomProgressIndicator({Key key, this.curman})
      : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _AnimatedLiquidCustomProgressIndicatorState();
}

class _AnimatedLiquidCustomProgressIndicatorState
    extends State<AnimatedLiquidCustomProgressIndicator>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(student.acgame4.valuelifespaceman);
    return Center(
        child: Stack(
      children: [
        LiquidCustomProgressIndicator(
          value: student.acgame4.valuelifespaceman[widget.curman],
          direction: Axis.vertical,
          backgroundColor: Colors.white,
          valueColor: AlwaysStoppedAnimation(Colors.green),
          shapePath: _buildHeartPath(),
        ),
        Image.asset("assets/images/spacescore.png",
            height: student.playgroundheight * 40 / 500,
            width: student.playgroundheight * 40 / 500),
      ],
    ));
  }

  Path _buildHeartPath() {
    return Path()
      ..moveTo(9 / 460 * student.playgroundheight * 40 / 500,
          397 / 460 * student.playgroundheight * 40 / 500)
      ..cubicTo(
          9 / 460 * student.playgroundheight * 40 / 500,
          397 / 460 * student.playgroundheight * 40 / 500,
          20 / 460 * student.playgroundheight * 40 / 500,
          360 / 460 * student.playgroundheight * 40 / 500,
          32 / 460 * student.playgroundheight * 40 / 500,
          321 / 460 * student.playgroundheight * 40 / 500)
      ..lineTo(32 / 460 * student.playgroundheight * 40 / 500,
          110 / 460 * student.playgroundheight * 40 / 500)
      ..cubicTo(
          32 / 460 * student.playgroundheight * 40 / 500,
          110 / 460 * student.playgroundheight * 40 / 500,
          50 / 460 * student.playgroundheight * 40 / 500,
          100 / 460 * student.playgroundheight * 40 / 500,
          70 / 460 * student.playgroundheight * 40 / 500,
          95 / 460 * student.playgroundheight * 40 / 500)
      ..cubicTo(
          70 / 460 * student.playgroundheight * 40 / 500,
          85 / 460 * student.playgroundheight * 40 / 500,
          200 / 460 * student.playgroundheight * 40 / 500,
          3 / 460 * student.playgroundheight * 40 / 500,
          353 / 460 * student.playgroundheight * 40 / 500,
          80 / 460 * student.playgroundheight * 40 / 500)
      ..cubicTo(
          353 / 460 * student.playgroundheight * 40 / 500,
          90 / 460 * student.playgroundheight * 40 / 500,
          370 / 460 * student.playgroundheight * 40 / 500,
          120 / 460 * student.playgroundheight * 40 / 500,
          400 / 460 * student.playgroundheight * 40 / 500,
          138 / 460 * student.playgroundheight * 40 / 500)
      ..lineTo(397 / 460 * student.playgroundheight * 40 / 500,
          309 / 460 * student.playgroundheight * 40 / 500)
      ..cubicTo(
          397 / 460 * student.playgroundheight * 40 / 500,
          309 / 460 * student.playgroundheight * 40 / 500,
          405 / 460 * student.playgroundheight * 40 / 500,
          340 / 460 * student.playgroundheight * 40 / 500,
          416 / 460 * student.playgroundheight * 40 / 500,
          398 / 460 * student.playgroundheight * 40 / 500)
      ..cubicTo(
          416 / 460 * student.playgroundheight * 40 / 500,
          398 / 460 * student.playgroundheight * 40 / 500,
          210 / 460 * student.playgroundheight * 40 / 500,
          460 / 460 * student.playgroundheight * 40 / 500,
          9 / 460 * student.playgroundheight * 40 / 500,
          397 / 460 * student.playgroundheight * 40 / 500)
      ..close();
  }
}

class AnimatedLiquidCustomProgressIndicator2 extends StatefulWidget {
  final int curman;
  AnimatedLiquidCustomProgressIndicator2({Key key, this.curman})
      : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _AnimatedLiquidCustomProgressIndicatorState2();
}

class _AnimatedLiquidCustomProgressIndicatorState2
    extends State<AnimatedLiquidCustomProgressIndicator2>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(student.acgame4.valuelifespaceman);
    return Center(
        child: Stack(
      children: [
        LiquidCustomProgressIndicator(
          value: student.acgame3.valuelifespaceman[widget.curman],
          direction: Axis.vertical,
          backgroundColor: Colors.white,
          valueColor: AlwaysStoppedAnimation(Colors.green),
          shapePath: _buildHeartPath(),
        ),
        Image.asset("assets/images/spacescore.png",
            height: student.playgroundheight * 40 / 500,
            width: student.playgroundheight * 40 / 500),
      ],
    ));
  }

  Path _buildHeartPath() {
    return Path()
      ..moveTo(9 / 460 * student.playgroundheight * 40 / 500,
          397 / 460 * student.playgroundheight * 40 / 500)
      ..cubicTo(
          9 / 460 * student.playgroundheight * 40 / 500,
          397 / 460 * student.playgroundheight * 40 / 500,
          20 / 460 * student.playgroundheight * 40 / 500,
          360 / 460 * student.playgroundheight * 40 / 500,
          32 / 460 * student.playgroundheight * 40 / 500,
          321 / 460 * student.playgroundheight * 40 / 500)
      ..lineTo(32 / 460 * student.playgroundheight * 40 / 500,
          110 / 460 * student.playgroundheight * 40 / 500)
      ..cubicTo(
          32 / 460 * student.playgroundheight * 40 / 500,
          110 / 460 * student.playgroundheight * 40 / 500,
          50 / 460 * student.playgroundheight * 40 / 500,
          100 / 460 * student.playgroundheight * 40 / 500,
          70 / 460 * student.playgroundheight * 40 / 500,
          95 / 460 * student.playgroundheight * 40 / 500)
      ..cubicTo(
          70 / 460 * student.playgroundheight * 40 / 500,
          85 / 460 * student.playgroundheight * 40 / 500,
          200 / 460 * student.playgroundheight * 40 / 500,
          3 / 460 * student.playgroundheight * 40 / 500,
          353 / 460 * student.playgroundheight * 40 / 500,
          80 / 460 * student.playgroundheight * 40 / 500)
      ..cubicTo(
          353 / 460 * student.playgroundheight * 40 / 500,
          90 / 460 * student.playgroundheight * 40 / 500,
          370 / 460 * student.playgroundheight * 40 / 500,
          120 / 460 * student.playgroundheight * 40 / 500,
          400 / 460 * student.playgroundheight * 40 / 500,
          138 / 460 * student.playgroundheight * 40 / 500)
      ..lineTo(397 / 460 * student.playgroundheight * 40 / 500,
          309 / 460 * student.playgroundheight * 40 / 500)
      ..cubicTo(
          397 / 460 * student.playgroundheight * 40 / 500,
          309 / 460 * student.playgroundheight * 40 / 500,
          405 / 460 * student.playgroundheight * 40 / 500,
          340 / 460 * student.playgroundheight * 40 / 500,
          416 / 460 * student.playgroundheight * 40 / 500,
          398 / 460 * student.playgroundheight * 40 / 500)
      ..cubicTo(
          416 / 460 * student.playgroundheight * 40 / 500,
          398 / 460 * student.playgroundheight * 40 / 500,
          210 / 460 * student.playgroundheight * 40 / 500,
          460 / 460 * student.playgroundheight * 40 / 500,
          9 / 460 * student.playgroundheight * 40 / 500,
          397 / 460 * student.playgroundheight * 40 / 500)
      ..close();
  }
}
