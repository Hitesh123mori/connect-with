import 'package:connectwith/providers/current_user_provider.dart';
import 'package:connectwith/screens/home_screens/profile_screen/profile_screen.dart';
import 'package:connectwith/side_transitions/left_right.dart';
import 'package:connectwith/utils/helper_functions/helper_functions.dart';
import 'package:connectwith/utils/widgets/buttons/auth_buttons/button_1.dart';
import 'package:connectwith/utils/widgets/text_feilds/text_feild_1.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../apis/auth_apis/fetch_user_info.dart';
import '../../../main.dart';
import '../../../utils/theme/colors.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _headline;
  String? _about;
  bool isLoading = false;

  // Additional toggles
  bool showExperience = false;
  bool showEducation = false;
  bool showProjects = false;
  bool showSkills = false;
  bool showScores = false;
  bool showLanguage = false;

  Future<void> _saveProfile(AppUserProvider appUserProvider) async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      bool success = await UserProfile.updateUserProfile(
        appUserProvider.user?.userID,
        {
          'headLine': _headline,
          'about': _about,
          'showExperience': showExperience,
          'showEducation': showEducation,
          'showProject': showProjects,
          'showSkill': showSkills,
          'showScore': showScores,
          'showLanguage': showLanguage,
        },
      );

      await Future.delayed(Duration(seconds: 1));

      if (success) {
        HelperFunctions.showToast("Profile updated successfully!");
      } else {
        HelperFunctions.showToast("Profile not updated!");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Consumer<AppUserProvider>(builder: (context, appUserProvider, child) {

      showExperience = appUserProvider.user?.showExperience ?? false;
      showEducation = appUserProvider.user?.showEducation ?? false;
      showProjects = appUserProvider.user?.showProject ?? false;
      showSkills = appUserProvider.user?.showSkill ?? false;
      showScores = appUserProvider.user?.showScore ?? false;
      showLanguage = appUserProvider.user?.showLanguage ?? false;



      return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            backgroundColor: AppColors.theme['secondaryColor'],
            appBar: AppBar(
              title: Text(
                "Edit Profile",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              backgroundColor: AppColors.theme['primaryColor'],
              toolbarHeight: 50,
              leading: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context, LeftToRight(ProfileScreen()));
                },
                icon: Icon(
                  Icons.keyboard_arrow_left_rounded,
                  size: 35,
                  color: Colors.white,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Edit Profile",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),

                      // Headline field
                      Text(
                        "Headline",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextFeild1(
                        hintText: "Enter Headline",
                        isNumber: false,
                        prefixicon: Icon(Icons.text_format_outlined),
                        obsecuretext: false,
                        initialText: appUserProvider.user?.headLine,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Headline cannot be empty";
                          }
                          return null;
                        },
                        onSaved: (value) => _headline = value,
                      ),
                      SizedBox(height: 20),

                      // About field
                      Text(
                        "About",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextFeild1(
                        hintText: "Enter About",
                        isNumber: false,
                        prefixicon: Icon(Icons.info_outline),
                        obsecuretext: false,
                        initialText: appUserProvider.user?.about,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "About cannot be empty";
                          }
                          return null;
                        },
                        onSaved: (value) => _about = value,
                      ),
                      SizedBox(height: 20),

                      // Toggle options
                      _buildToggleOption(
                          "Show Experience", showExperience, (value) {
                        setState(() => showExperience = value);
                      }),
                      _buildToggleOption(
                          "Show Education", showEducation, (value) {
                        setState(() => showEducation = value);
                      }),
                      _buildToggleOption(
                          "Show Projects", showProjects, (value) {
                        setState(() => showProjects = value);
                      }),
                      _buildToggleOption("Show Skills", showSkills, (value) {
                        setState(() => showSkills = value);
                      }),
                      _buildToggleOption("Show Scores", showScores, (value) {
                        setState(() => showScores = value);
                      }),
                      _buildToggleOption(
                          "Show Language", showLanguage, (value) {
                        setState(() => showLanguage = value);
                      }),

                      SizedBox(height: 30),

                      // Save button
                      Center(
                        child: Button1(
                          isLoading: isLoading,
                          height: 50,
                          loadWidth: mq.width * 0.5,
                          width: mq.width * 1,
                          textColor: AppColors.theme['secondaryColor'],
                          bgColor: AppColors.theme['primaryColor'],
                          onTap: () async {
                            setState(() {
                              isLoading = true;
                            });
                            await _saveProfile(appUserProvider);
                            setState(() {
                              isLoading = false;
                            });

                            await appUserProvider.initUser();

                            await Future.delayed(Duration(seconds: 4));
                            Navigator.pop(context);
                          },
                          title: "Save Profile",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  // Helper method for toggle UI
  Widget _buildToggleOption(
      String label, bool value, void Function(bool) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.theme['primaryColor'],
        ),
      ],
    );
  }
}
