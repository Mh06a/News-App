import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/themes/app_colors.dart';
import 'package:news_app/features/profile/cubit/profile_cubit.dart';

class ProfileHeader extends StatelessWidget {
  final VoidCallback onCameraTap;

  const ProfileHeader({super.key, required this.onCameraTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Center(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: AppSizes.r60,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage: state.user.imagePath != null
                        ? FileImage(File(state.user.imagePath!))
                        : const AssetImage("assets/images/me.jpg")
                              as ImageProvider,
                  ),

                  InkWell(
                    onTap: onCameraTap,
                    borderRadius: BorderRadius.circular(AppSizes.r60),
                    child: Container(
                      width: AppSizes.w34,
                      height: AppSizes.h34,
                      decoration: BoxDecoration(
                        color: AppColors.appBarBackground,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Icon(
                        Icons.camera_alt_outlined,
                        size: AppSizes.r18,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: AppSizes.h12),

              Text(
                state.user.userName,
                style: TextStyle(
                  fontSize: AppSizes.font18,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blackText,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
