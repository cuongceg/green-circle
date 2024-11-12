import 'package:flutter/material.dart';
import 'package:green_circle/screen/e_commerce/main_screen.dart';
import 'create_shop.dart';
import 'package:green_circle/constants.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:google_fonts/google_fonts.dart';

class FinishSignIn extends StatefulWidget {
  const FinishSignIn({super.key});

  @override
  State<FinishSignIn> createState() => _FinishSignInState();
}

class _FinishSignInState extends State<FinishSignIn> {
  int activeStep = 3;
  bool onTapped = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Complete Registration'),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black,),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ShopInfoScreen()));
            },
          ),),
        body: ListView(
          children: [
            EasyStepper(
              activeStep: activeStep,
              lineStyle: const LineStyle(
                  lineLength: 80,
                  lineWidth: 2,
                  progressColor: green1,
                  progress: 0
              ),
              activeStepTextColor: Colors.black87,
              finishedStepTextColor: Colors.black87,
              internalPadding: 0,
              showLoadingAnimation: false,
              stepRadius: 8,
              showStepBorder: false,
              steps: [
                EasyStep(
                  customStep: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 7,
                      backgroundColor:
                      activeStep == 0 ? green1 : Colors.grey.shade400,
                    ),
                  ),
                  title: 'Basic Information',
                ),
                EasyStep(
                    customStep: CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 7,
                        backgroundColor:
                        activeStep == 1 ? green1 : Colors.grey.shade400,
                      ),
                    ),
                    title: 'Shipping Information',
                    topTitle: true
                ),
                EasyStep(
                  customStep: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 7,
                      backgroundColor:
                      activeStep == 2 ? green1 : Colors.grey.shade400,
                    ),
                  ),
                  title: 'Bank Account',
                ),
                EasyStep(
                    customStep: CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 7,
                        backgroundColor:
                        activeStep == 3 ? green1 : Colors.grey.shade400,
                      ),
                    ),
                    title: 'Complete',
                    topTitle: true
                )
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Text('Check your shop information to complete registration',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            information('Shop Name: **********'),
            information('Email: **********'),
            information('Phone Number: **********'),
            information('Shipping Address: **********'),
            information('Shipping Method: **********'),
            information('Bank Account Number: **********'),
            CheckboxListTile(
              value: onTapped,
              checkColor: green1,
              activeColor: Colors.white,
              onChanged: (bool? value) {
                setState(() {
                  onTapped = value!;
                });
              },
              title: const Text('By clicking the register button, you agree to the information and terms of Green Circle'),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
              child: GestureDetector(
                onTap: (){showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Colors.white,
                        title: const Text('Sign up successfully!', style: TextStyle(color: green1, fontWeight: FontWeight.bold)),
                        content: const Text('We will send an email to verify your bank card information. Thank you for registering with Green Circle!'),
                        actions: <Widget>[
                          TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainScreen()));
                              },
                              child: const Text('Back to Home', style: TextStyle(color: green1, fontWeight: FontWeight.bold))
                          ),
                        ],
                      );
                    }
                );
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: green1,
                      borderRadius: BorderRadius.circular(50)
                  ),
                  child: Center(
                      child: Text("Register", style: GoogleFonts.almarai(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),)),
                ),
              ),
            ),
          ],
        )
    );
  }

  Widget information(String content) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Container(
          height: 45,
          width: 350,
          decoration: BoxDecoration(
            color: lightGray,
            border: Border.all(color: Colors.black87),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
              children: [
                const SizedBox(width: 15,),
                Text(content, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), textAlign: TextAlign.start,)
              ]
          ),
        )
    );
  }
}