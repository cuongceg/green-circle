import 'package:flutter/material.dart';
import 'package:green_circle/models/user.dart';
import 'login_screen.dart';
import 'package:green_circle/services/auth_services.dart';
import 'package:green_circle/services/database.dart';
import 'package:green_circle/constants.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatefulWidget{
  const SignUp({super.key});
  @override
  State<StatefulWidget> createState() {
    return MySignupState();
  }
}

class MySignupState extends State<SignUp>{
  final AuthService auth=AuthService();
  final _formKey =GlobalKey<FormState>();
  String? fullName,confirmPassword;
  String _email='',password='';
  final fullNameEditingController=TextEditingController();
  final emailEditingController=TextEditingController();
  final passwordEditingController=TextEditingController();
  final confirmPasswordEditingController=TextEditingController();
  bool hint=true;
  @override
  Widget build(BuildContext context){
    double widthR=MediaQuery.of(context).size.width;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value:const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
      ),
      child:SafeArea(
        child: Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.white,
              forceMaterialTransparency: true,
              leading: Builder(
                  builder: (BuildContext context) {
                    return IconButton(
                        icon: const Icon(
                          Icons.arrow_back_rounded, size: 30, color: Colors.black,),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const Login()));
                        }
                    );
                  }
              ),
              title: Text("Sign up", style:GoogleFonts.outfit(fontSize:30,color: Colors.black))
          ),
          backgroundColor: Colors.white,
          body: Center(
              child:Form(
                key:_formKey,
                child:ListView(
                  children:<Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                            'Already have account?',
                            style:GoogleFonts.outfit(fontSize:15,fontWeight:FontWeight.w400,color:greenGray)
                        ),
                        TextButton(
                          onPressed:() =>
                              Navigator.pop(context),
                          child:Text(
                            "Sign in",
                            style:GoogleFonts.outfit(fontSize:16,fontWeight:FontWeight.w400,color:green1,decoration:TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                    inputNameText(),
                    inputEmail(),
                    inputPassword(),
                    inputConfirmPassword(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20,horizontal:60),
                      child: Container(
                        height: 50,
                        width:widthR,
                        decoration:BoxDecoration(
                            color: green1,
                            borderRadius: BorderRadius.circular(50)
                        ),
                        child: TextButton(
                          onPressed:()async{
                            if(_formKey.currentState!.validate()){
                              dynamic result=await auth.signUpEmail(_email, password);
                              if(result == null){
                                //check sign up successfully or not
                                final snackBar = SnackBar(
                                  backgroundColor:red,
                                  content: Text('Enter a valid email and try again',style:snackBarFonts,),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              }
                              else{
                                // // create a profile base on unique uid
                                await Database(uid:result.uid).updateData(UserInformation(name: fullName??"", voucherId:[],cartItems:[],boughtProduct:[],likedProduct:[],soldProduct:[]));
                                final snackBar = SnackBar(
                                  backgroundColor:green1,
                                  content: Text('Sign up successfully',style:snackBarFonts,),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                Future.delayed(const Duration(milliseconds: 1000), () {
                                  // Navigate to the next screen after the delay
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => const Login()),
                                  );
                                });
                              }
                            }
                          },
                          child:Text(
                            "Sign up",
                            style: GoogleFonts.almarai(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.white),
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
                          Text("Or sign up with",style:GoogleFonts.almarai(fontWeight:FontWeight.w400,color:greenGray,fontSize:14),),
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
                  ],
                ),
              )
          ),
        ),
      ),
    );
  }

  Widget inputNameText(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:30,vertical:20),
      child: TextFormField(
          validator: (val) {
            if(val==null||val.isEmpty){
              return 'Enter your name';
            }
            else
            {return null;}
          },
          controller: fullNameEditingController,
          onChanged: (text){
            setState(() {
              fullName=text;
            });
          },
          decoration:inputDecoration('Your name')
      ),
    );
  }
  Widget inputEmail(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:30,vertical:20),
      child: TextFormField(
          validator: (val) {
            if(val==null||val.isEmpty){
              return 'Enter a valid email';
            }
            else
            {return null;}
          },
          controller:emailEditingController,
          onChanged: (text){
            setState(() {
              _email=text;
            });
          },
          decoration:inputDecoration('Your email')
      ),
    );
  }
  Widget inputPassword(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:30,vertical:20),
      child: TextFormField(
        validator: (val) {
          if(val==null||val.length<6){
            return 'Enter password has more 6 letters';
          }
          else
          {return null;}
        },
        obscureText: hint,
        controller: passwordEditingController,
        onChanged: (text){
          setState(() {
            password=text;
          });
        },
        decoration: inputPasswordDecoration('Your password'),
      ),
    );
  }
  Widget inputConfirmPassword(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:30,vertical:20),
      child: TextFormField(
        validator: (val) {
          if(val==null||val!=password){
            return 'Check out your master password and try again';
          }
          else
          {return null;}
        },
        obscureText: hint,
        controller: confirmPasswordEditingController,
        onChanged: (text){
          setState(() {
            confirmPassword=text;
          });
        },
        decoration: inputPasswordDecoration('Confirm your password'),
      ),
    );
  }
  InputDecoration? inputDecoration(String label){
    return InputDecoration(
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
        labelText:label,
        labelStyle:GoogleFonts.outfit(fontSize:15,color:Colors.black,fontWeight:FontWeight.w500)
    );
  }
  InputDecoration? inputPasswordDecoration(String label){
    return InputDecoration(
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
      labelText:label,
      labelStyle:GoogleFonts.outfit(fontSize:15,color:Colors.black,fontWeight:FontWeight.w500),
      suffix: InkWell(
          child:hint?const Icon(Icons.remove_red_eye_outlined):const Icon(Icons.visibility_off_sharp),
          onTap:()async{
            setState(() {
              hint=!hint;
            });
          }
      ),
    );
  }
}