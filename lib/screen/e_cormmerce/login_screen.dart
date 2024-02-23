import 'package:flutter/material.dart';
import 'package:green_circle/constants.dart';
import 'package:green_circle/screen/e_cormmerce/sign_up_screen.dart';
import 'package:green_circle/services/auth_services.dart';
import 'package:green_circle/models/user.dart';
import 'wrapper.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool hint=false;
  final AuthService authService=AuthService();
  final _formKey=GlobalKey<FormState>();
  String email='',password='';
  final emailController=TextEditingController();
  final passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top:100,bottom:10),
              child: Center(child: Text('Sign in',style:GoogleFonts.almarai(fontSize:40,fontWeight:FontWeight.w700),)),
            ),
            Center(child: Text('Hi! Welcome back, you’ve been missed',style:GoogleFonts.outfit(fontSize:15,fontWeight:FontWeight.w400,color:mediumGray),)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 50),
              child:TextFormField(
                validator:(val){
                  if(val==null||val.isEmpty){
                    return "Enter a valid email";
                  }
                  else {
                    return null;
                  }
                },
                controller: emailController,
                onChanged: (text){
                  email=text;
                },
                decoration:InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius:borderRadius,
                        borderSide:borderSideWhite
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius:borderRadius,
                        borderSide:borderSideGreen
                    ),
                    fillColor: lightGray,
                    filled: true,
                    labelText:"Email",
                    labelStyle:GoogleFonts.outfit(fontSize:15,color:Colors.black,fontWeight:FontWeight.w500)
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:30,vertical:0),
              child: TextFormField(
                validator:(val){
                  if(val==null||val.length<6){
                    return "Enter a valid password";
                  }
                  else{
                    return null;
                  }
                },
                onChanged:(text){
                  password=text;
                },
                obscureText: hint,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius:borderRadius,
                      borderSide:borderSideWhite
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: borderRadius,
                      borderSide:borderSideGreen
                  ),
                  fillColor: lightGray,
                  filled: true,
                  labelText:"Password",
                  labelStyle:GoogleFonts.outfit(fontSize:15,color:Colors.black,fontWeight:FontWeight.w500),
                  suffix: InkWell(
                      child:hint?const Icon(Icons.remove_red_eye_outlined):const Icon(Icons.visibility_off_sharp),
                      onTap:()async{
                        setState(() {
                          hint=!hint;
                        });
                      }
                  ),
                ),
              ),
            ),
            Padding(
              padding:const EdgeInsets.only(top: 10,left:250),
              child:TextButton(
                child:Text(
                  "Forgot password?",
                  style:GoogleFonts.almarai(
                      fontSize:14,
                      decoration: TextDecoration.underline,
                      color:green1,
                      fontWeight: FontWeight.w500),
                ),
                onPressed:(){},
              ),
            ),
            Padding(
              padding:const EdgeInsets.symmetric(vertical:5),
              child: Center(
                child: Container(
                  width: 285,
                  height: 55,
                  decoration: BoxDecoration(
                    color: green1,
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child: TextButton(
                    child:Text("Sign in",style:GoogleFonts.almarai(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.white),),
                    onPressed:()async{
                      if(_formKey.currentState!.validate()){
                        MyUser? result =await authService.signInEmailAndPassword(email, password);
                        debugPrint('$result');
                        if(result == null){
                          final snackBar = SnackBar(
                            backgroundColor:red,
                            content:Text('Unavailable account or wrong password!',style:snackBarFonts),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                        else{
                          Navigator.push(context,MaterialPageRoute(builder:(context)=>const Wrapper()));
                        }
                      }
                      else{
                        final snackBar = SnackBar(
                          backgroundColor:red,
                          content: Text('Invalid email or invalid password!',style:snackBarFonts),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical:20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(height:1,width:95,color:mediumGray,),
                  Text("Or sign in with",style:GoogleFonts.almarai(fontWeight:FontWeight.w400,color:greenGray,fontSize:14),),
                  Container(height:1,width:95,color:mediumGray,)
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: IconButton(
                    onPressed:(){},
                    icon: const Icon(Icons.apple,color:Colors.black,),
                    iconSize: 40,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: IconButton(
                      onPressed:(){},
                      icon:const CircleAvatar(
                        backgroundColor:Colors.white,
                        backgroundImage:AssetImage("assets/images/google.png"),
                        radius: 15,
                      )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: IconButton(
                    onPressed:(){},
                    icon: const Icon(Icons.facebook_outlined,color:Colors.blue,),
                    iconSize: 40,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don’t have an account?",style:GoogleFonts.outfit(fontSize:15,fontWeight:FontWeight.w400,color:greenGray)),
                TextButton(
                    onPressed: (){
                      Navigator.push(context,MaterialPageRoute(builder:(context)=>const SignUp()));
                    },
                    child: Text("Sign up",style:GoogleFonts.outfit(fontSize:16,fontWeight:FontWeight.w400,color:green1,decoration:TextDecoration.underline)))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
