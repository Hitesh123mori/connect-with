import 'package:connectwith/screens/auth_screens/login_screen.dart';
import 'package:connectwith/screens/home_screens/tabs/create_post/create_post_screen.dart';
import 'package:connectwith/screens/home_screens/tabs/jobs/job_screen.dart';
import 'package:connectwith/screens/home_screens/tabs/network/network_screen.dart';
import 'package:connectwith/screens/home_screens/tabs/notification/notification_screen.dart';
import 'package:connectwith/screens/home_screens/tabs/post/post_screen.dart';
import 'package:connectwith/side_transitions/right_left.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/theme/colors.dart';

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
    return Scaffold(
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal:10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ListTile(
                title: Text("name here"),
                leading: CircleAvatar(),
              ),
              InkWell(
                onTap: (){
                  Navigator.pushReplacement(context, RightToLeft(LoginScreen())) ;
                },
                child: Row(
                  children: [
                    Icon(Icons.logout),
                    Text("L O G O U T")
                  ],
                ),
              )
            ],
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
