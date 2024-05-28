import 'package:flutter/material.dart';
import 'package:green_circle/screen/e_commerce/main_screen.dart';
import 'login_screen.dart';
import 'package:green_circle/models/user.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user=Provider.of<MyUser?>(context);
    if(user!=null){
      return const MainScreen();
    }
    else {
      return const Login();
    }
  }
}