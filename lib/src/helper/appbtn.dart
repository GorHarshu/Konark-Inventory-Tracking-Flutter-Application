import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

// ignore: must_be_immutable
class AppButton extends StatelessWidget {
  String btnText;
  Color? backgroundColor, textColor, borderColor;
  double? textSize, height, width, borderRadius;
  VoidCallback? voidCallBack;
  FontWeight? boldfont;

  AppButton({
    super.key,
    required this.btnText,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.textSize,
    this.height,
    this.width,
    this.voidCallBack,
    this.boldfont,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor ?? Color(0xfff223e6d),
      borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 4)),
      child: InkWell(
        onTap: voidCallBack,
        highlightColor: ColorsRes.white.withOpacity(0.4),
        splashColor: ColorsRes.white.withOpacity(0.1),
        borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 4)),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: backgroundColor ?? Color(0xFFFFed6508),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 4)),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(top: 15, bottom: 15),
              child: Text(
                btnText,
                style: GoogleFonts.inter(
                  color: textColor ?? ColorsRes.white,
                  fontSize: textSize ?? 12,
                  fontWeight: boldfont ?? FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
