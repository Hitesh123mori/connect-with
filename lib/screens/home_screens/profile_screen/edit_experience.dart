import 'package:connectwith/providers/current_user_provider.dart';
import 'package:connectwith/screens/home_screens/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../side_transitions/left_right.dart';
import '../../../utils/theme/colors.dart';
import '../../../utils/widgets/custom_containers/profile_screen_container/experience_card.dart';

class EditExperience extends StatefulWidget {
  const EditExperience({super.key});

  @override
  State<EditExperience> createState() => _EditExperienceState();
}

class _EditExperienceState extends State<EditExperience> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppUserProvider>(
        builder: (context, appUserProvider, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: AppColors.theme['secondaryColor'],
          appBar: AppBar(
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
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: appUserProvider.user?.experiences != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Edit Experience",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text("Tap anyone and edit"),
                        SizedBox(
                          height: 20,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: appUserProvider.user?.experiences?.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: (){
                                print("jsjdf");
                              },
                              child: Container(
                                child: ExperienceCard(
                                    experience: appUserProvider
                                        .user!.experiences![index]),
                              ),
                            );
                          },
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                            child: Text(
                          "Please add experience first",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.grey),
                        )),
                      ],
                    ),
            ),
          ),
        ),
      );
    });
  }
}
