import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/themes/app_colors.dart';

class CustomTextField extends StatefulWidget {
  //step1 -->>  Class variables :
  final String hintText;
  final String validatorText;
  final TextEditingController myController;
  final int? maxLines;
  final String titleText;
  final Widget? suffix;
  final bool obscureText;

  //step2 -->> Constructor :
  const CustomTextField({
    super.key,
    required this.titleText,
    required this.hintText,
    required this.myController,
    required this.validatorText,
    this.maxLines = 1,
    this.suffix,
    this.obscureText = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isVisible = false;

  //step3 -->> call a build function :
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.titleText,
          style: TextStyle(
            color: AppColors.textThirdColor,
            fontSize: AppSizes.font18,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.start,
        ),

        SizedBox(height: AppSizes.h8),

        TextFormField(
          maxLines: widget.maxLines,
          controller: widget.myController,

          obscureText: widget.obscureText && !_isVisible,

          style: TextStyle(
            color: AppColors.blackText,
            fontSize: AppSizes.font18,
            fontWeight: FontWeight.w400,
          ),

          validator: (String? value) {
            if (value == null || value.trim().isEmpty) {
              return widget.validatorText;
            }
            return null;
          },

          decoration: InputDecoration(
            hintText: widget.hintText,

            hintStyle: TextStyle(
              color: AppColors.secondary,
              fontSize: AppSizes.font18,
              fontWeight: FontWeight.w400,
            ),

            filled: true,
            fillColor: AppColors.background,

            contentPadding: EdgeInsets.symmetric(
              horizontal: AppSizes.w22,
              vertical: AppSizes.h22,
            ),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
            ),

            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(color: Colors.red, width: 1),
            ),

            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(color: Colors.red, width: 1),
            ),

            suffixIcon: widget.obscureText
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _isVisible = !_isVisible;
                      });
                    },
                    icon: _isVisible
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off),
                  )
                : null,
            suffixIconColor: AppColors.secondary,
          ),
        ),
      ],
    );
  }
}
