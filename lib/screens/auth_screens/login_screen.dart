import 'dart:convert';
import 'package:connectwith/screens/auth_screens/register_screen.dart';
import 'package:connectwith/screens/home_screens/home_main_screen.dart';
import 'package:connectwith/side_transitions/left_right.dart';
import 'package:connectwith/utils/theme/colors.dart';
import 'package:connectwith/utils/widgets/text_feilds/text_feild_1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../main.dart';
import '../../utils/helper_functions/helper_functions.dart';
import '../../utils/widgets/buttons/button_1.dart';
import '../../utils/widgets/custom_containers/auth_container.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // for login loading condition
  bool _isLoading = false;

  // For displaying messages
  String _message = '';

  // Controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Function for login
  Future<void> loginUser(String email, String password) async {
    final String url = 'http://192.168.75.92:5000/login';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          _message = 'Login successful!';
          HelperFunctions.showToast(_message);
          Navigator.pushReplacement(context, LeftToRight(HomeScreen()));
        });
      } else {
        setState(() {
          _message = '${jsonDecode(response.body)['message']}';
          HelperFunctions.showToast(_message);
        });
      }
    } catch (e) {
      setState(() {
        _message = 'Error: $e';
        print("#loginError : $_message");
        HelperFunctions.showToast("Something went wrong!");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size mq = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.theme['backgroundColor'],
        body: Center(
          child: Container(
            height: mq.height * 0.7,
            width: mq.width * 0.9,
            decoration: BoxDecoration(
              color: AppColors.theme['secondaryColor'],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: mq.width * 0.07),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/logo/logo_2.jpg",
                    height: 50,
                    width: 200,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Welcome Back!",
                    style: TextStyle(
                      color: AppColors.theme['primaryColor'],
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        TextFeild1(
                          hintText: "Enter Email",
                          isNumber: false,
                          prefixicon: Icon(Icons.email),
                          obsecuretext: false,
                          controller: _emailController,
                        ),
                        TextFeild1(
                          hintText: "Enter Password",
                          isNumber: false,
                          prefixicon: Icon(Icons.password),
                          obsecuretext: true,
                          controller: _passwordController,
                        ),
                        SizedBox(height: 20),
                        Button1(
                          height: 50,
                          width: 300,
                          textColor: AppColors.theme['secondaryColor'],
                          bgColor: AppColors.theme['primaryColor'],
                          onTap: () {
                              setState(() {
                                _isLoading = true;
                              });

                              loginUser(
                                _emailController.text,
                                _passwordController.text,
                              ).then((_) {
                                setState(() {
                                  _isLoading = false;
                                });
                              });

                          },
                          title: 'Login',
                          isLoading: _isLoading,
                          loadWidth: 200,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(context, LeftToRight(RegisterScreen()));
                              },
                              child: Text(
                                "Register",
                                style: TextStyle(color: AppColors.theme['primaryColor']),
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "Forget Password",
                                style: TextStyle(color: AppColors.theme['primaryColor']),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: AppColors.theme['tertiaryColor'].withOpacity(0.2),
                                thickness: 2,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "OR",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: AppColors.theme['tertiaryColor'].withOpacity(0.2),
                                thickness: 2,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        AuthContainer(
                          path: 'assets/other_images/google.png',
                          title: 'Continue with Google',
                          onTap: () {},
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
