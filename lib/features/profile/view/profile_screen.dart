import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/datasource/local_data/preferences_manager.dart';
import 'package:news_app/core/themes/app_colors.dart';
import 'package:news_app/features/profile/cubit/profile_cubit.dart';
import 'package:news_app/features/user/repository/user_repository.dart';
import 'package:news_app/shared/custom_svg_picture.dart';
import 'package:news_app/features/auth/view/login_screen.dart';
import 'package:news_app/features/profile/view/profile_info_bottom_sheet.dart';
import 'package:news_app/features/profile/widgets/profile_header.dart';
import 'package:news_app/features/profile/widgets/profile_item.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit(UserRepository())..init(),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(centerTitle: true, title: Text("Profile")),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(AppSizes.w16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileHeader(onCameraTap: () {}),

                    SizedBox(height: AppSizes.h16),

                    Text(
                      "Profile Info",
                      style: TextStyle(
                        fontSize: AppSizes.font18,
                        fontWeight: FontWeight.w400,
                        color: AppColors.fourthText,
                      ),
                    ),

                    SizedBox(height: AppSizes.h8),

                    ProfileItem(
                      title: "Personal Info",
                      leadingIcon: CustomSvgPicture(
                        path: "assets/icons/personal_info.svg",
                      ),
                      onTap: () async {
                        final result =
                            await showModalBottomSheet<Map<String, String>>(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (_) => ProfileInfoBottomSheet(
                                userName: state.user.userName,
                                email: state.user.email,
                              ),
                            );

                        if (result != null) {
                          await context.read<ProfileCubit>().updateUser(
                            userName: result["userName"]!,
                            email: result["email"]!,
                          );
                        }
                      },
                      color: AppColors.fourthText,
                    ),

                    ProfileItem(
                      title: "Language",
                      leadingIcon: CustomSvgPicture(
                        path: "assets/icons/language.svg",
                      ),
                      onTap: () {},
                      color: AppColors.fourthText,
                    ),

                    ProfileItem(
                      title: state.user.countryName ?? "Country",
                      leadingIcon: CustomSvgPicture(
                        path: "assets/icons/country.svg",
                      ),
                      onTap: () {
                        showCountryPicker(
                          context: context,
                          onSelect: (Country country) {
                            context.read<ProfileCubit>().changeCountry(country);
                          },
                        );
                      },
                      color: AppColors.fourthText,
                    ),

                    ProfileItem(
                      title: "Terms & Conditions",
                      leadingIcon: CustomSvgPicture(
                        path: "assets/icons/terms.svg",
                      ),
                      onTap: () {},
                      color: AppColors.fourthText,
                    ),

                    ProfileItem(
                      title: "Logout",
                      leadingIcon: CustomSvgPicture(
                        path: "assets/icons/logout.svg",
                        color: AppColors.primary,
                      ),
                      onTap: () async {
                        await PreferencesManager().clear();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return LoginScreen();
                            },
                          ),
                        );
                      },
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
