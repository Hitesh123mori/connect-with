import 'dart:developer';

import 'package:connectwith/models/user/user.dart';
import 'package:connectwith/providers/current_user_provider.dart';
import 'package:connectwith/screens/auth_screens/login_screen.dart';
import 'package:connectwith/screens/home_screens/tabs/create_post/create_post_screen.dart';
import 'package:connectwith/screens/home_screens/tabs/jobs/job_screen.dart';
import 'package:connectwith/screens/home_screens/tabs/network/network_screen.dart';
import 'package:connectwith/screens/home_screens/tabs/notification/notification_screen.dart';
import 'package:connectwith/screens/home_screens/tabs/post/post_screen.dart';
import 'package:connectwith/side_transitions/right_left.dart';
import 'package:connectwith/utils/helper_functions/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../apis/auth_apis/fetch_user_info.dart';
import '../../apis/init/config.dart';
import '../../utils/theme/colors.dart';
import '../../utils/widgets/custom_containers/drawer_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> children = [
    PostScreen(),
    NetWorkScreen(),
    CreatePostScreen(),
    NotificationScreen(),
    JobScreen(),
  ];

  final List<String> titles = [
    'Posts',
    'Network',
    'Create Post',
    'Notifications',
    'Jobs',
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<AppUserProvider>(builder: (context,appUserProvider,child){
      return  Scaffold(
        drawer: Drawer(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:20),
            child: SafeArea(
              child: Column(
                children: [
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10) ,
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(),
                        SizedBox(width: 10,),
                        Text(appUserProvider.user?.userName ?? "Name",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
                      ],
                    )
                  ),
                  Divider(),
                  DrawerContainer(data: appUserProvider.user?.followers.toString() ?? "0", label: 'Followers',) ,
                  DrawerContainer(data: appUserProvider.user?.following.toString() ?? "0", label: 'Followings',) ,
                  DrawerContainer(data: appUserProvider.user?.searchCount.toString() ?? "0", label: 'Search Count',) ,
                  DrawerContainer(data: appUserProvider.user?.profileViews.toString() ?? "0", label: 'Profile Views',) ,
                  Expanded(child: Container()) ,
                  InkWell(
                    onTap: ()async{
                      await appUserProvider.logOut() ;
                      HelperFunctions.showToast("Logout successfully") ;
                      await Navigator.pushReplacement(context, RightToLeft(LoginScreen())) ;
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: AppColors.theme['primaryColor'].withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10) ,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Row(
                          children: [
                            Icon(Icons.logout),
                            SizedBox(width: 10,),
                            Text("L O G O U T",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                ],
              ),
            ),
          ),



        ),
        appBar: AppBar(
          leading: Builder(
              builder: (context) =>InkWell(
                onTap:(){
                  Scaffold.of(context).openDrawer();
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: CircleAvatar(
                    backgroundColor: AppColors.theme['primaryColor'],
                    radius: 30,
                    child: Center(child: Icon(Icons.person,color: AppColors.theme['secondaryColor'],)),
                  ),
                ),
              )
          ),
          backgroundColor: AppColors.theme['primaryColor']!.withOpacity(0.3),
          centerTitle: true,
          title: Text(
            titles[_currentIndex],
            style: TextStyle(
              color: AppColors.theme['tertiaryColor'],
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        body: _buildBody(),
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          selectedItemColor: AppColors.theme['primaryColor'],
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_outline_sharp),
              label: 'Network',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_box_rounded),
              label: 'Post',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_active_outlined),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.all_inbox_outlined),
              label: 'Jobs',
            ),
          ],
        ),
      );
    }) ;
  }

  Widget _buildBody() {
    return children[_currentIndex];
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

