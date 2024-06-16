import 'package:connectwith/utils/theme/colors.dart';
import 'package:flutter/material.dart' ;


class AuthContainer extends StatelessWidget {
  final String path ;
  final String title ;
  final VoidCallback onTap ;

  const AuthContainer({super.key, required this.path, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 55,
        width: 350,
        decoration: BoxDecoration(
          color: AppColors.theme['primaryColor'],
          borderRadius: BorderRadius.circular(10),

        ),
        child: Row(
          children: [
            SizedBox(width: 20,),
            Image.asset(path,height: 40,width: 40,),
            SizedBox(width: 20,),
            Text(title,style: TextStyle(color: AppColors.theme['secondaryColor'],fontSize: 16,fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }
}
