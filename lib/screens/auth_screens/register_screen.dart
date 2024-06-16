import 'dart:convert';
import 'package:connectwith/screens/auth_screens/login_screen.dart';
import 'package:connectwith/screens/home_screens/home_main_screen.dart';
import 'package:connectwith/side_transitions/left_right.dart';
import 'package:connectwith/side_transitions/right_left.dart';
import 'package:connectwith/utils/helper_functions/helper_functions.dart';
import 'package:connectwith/utils/theme/colors.dart';
import 'package:connectwith/utils/widgets/text_feilds/text_feild_1.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../utils/widgets/buttons/button_1.dart';
import '../../utils/widgets/custom_containers/auth_container.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  // For register loading condition
  bool _isLoading = false;

  // For displaying messages
  String _message = '';

  // Controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();

  // Function for registering user
  Future<void> registerUser(String email, String password, String userName) async {
    final String url = 'http://192.168.75.92:5000/register';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userName': userName,
          'email': email,
          'password': password,

        }),
      );

      if (response.statusCode == 201) {
        setState(() {
          _message = '${jsonDecode(response.body)['message']}';
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
        print("#registerE : $_message") ;
        HelperFunctions.showToast("Something went wrong!");
      });
    }
  }

  // Email validator
  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  // Password validator
  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (!RegExp(r'^(?=.*[A-Z]).{8,}$').hasMatch(value)) {
      return 'Password must be at least 8 characters long and contain at least one capital letter';
    }
    return null;
  }

  // General validator
  String? notEmptyValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
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
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 50,),
                      Image.asset(
                        "assets/logo/logo_2.jpg",
                        height: 50,
                        width: 200,
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Create Account",
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
                              hintText: "Enter your name",
                              isNumber: false,
                              prefixicon: Icon(Icons.drive_file_rename_outline),
                              obsecuretext: false,
                              controller: _userNameController,
                              validator: notEmptyValidator,
                            ),
                            TextFeild1(
                              hintText: "Enter Email",
                              isNumber: false,
                              prefixicon: Icon(Icons.email),
                              obsecuretext: false,
                              controller: _emailController,
                              validator: emailValidator,
                            ),
                            TextFeild1(
                              hintText: "Enter Password",
                              isNumber: false,
                              prefixicon: Icon(Icons.password),
                              obsecuretext: true,
                              controller: _passwordController,
                              validator: passwordValidator,
                            ),
                            SizedBox(height: 20),
                            Button1(
                              height: 50,
                              width: 300,
                              textColor: AppColors.theme['secondaryColor'],
                              bgColor: AppColors.theme['primaryColor'],
                              onTap: () {
                                if (_formKey.currentState!.validate()) {

                                  setState(() {
                                    _isLoading = true;
                                  });
                  
                                  registerUser(
                                    _emailController.text,
                                    _passwordController.text,
                                    _userNameController.text,
                                  ).then((_) {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  });
                                } else {
                                  HelperFunctions.showToast("Please fill in all fields correctly");
                                }
                              },
                              title: 'Register',
                              isLoading: _isLoading,
                              loadWidth: 200,
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(context, RightToLeft(LoginScreen()));
                                  },
                                  child: Text(
                                    "Already have an account? Login",
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
                            ),
                            SizedBox(height: 20),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
