import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSvgPicture extends StatelessWidget {
  //step1 -->> class's variables :
  final String path;
  final Color? color;
  final double? height;
  final double? width;

  //step2 -->> Constructor :
  const CustomSvgPicture({
    super.key,
    required this.path,
    this.height,
    this.width,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      width: width,
      height: height,
      colorFilter: ColorFilter.mode(color ?? Colors.black, BlendMode.srcIn),
    );
  }
}
