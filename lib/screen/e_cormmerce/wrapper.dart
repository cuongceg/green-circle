import 'package:flutter/material.dart';
import 'package:green_circle/screen/screen_options.dart';
import 'login_screen.dart';
import 'package:green_circle/models/user.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user=Provider.of<MyUser?>(context);
    if(user!=null){
      return const ScreenOptions();
    }
    else {
      return const Login();
    }
  }
}