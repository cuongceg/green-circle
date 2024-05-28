import 'package:flutter/material.dart';
import 'package:green_circle/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:green_circle/screen/user%20shop/finish_sign_in.dart';

class ShopInfoScreen extends StatefulWidget {
  const ShopInfoScreen({Key? key}) : super(key: key);

  @override
  ShopInfoScreenState createState() => ShopInfoScreenState();
}

class ShopInfoScreenState extends State<ShopInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _shopNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  int activeStep = 0;

  @override
  void dispose() {
    _shopNameController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Tạo cửa hàng',style: title2Black,),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 0),
          child: ListView(
            children: [
              EasyStepper(
                activeStep: activeStep,
                lineStyle: const LineStyle(
                    lineLength: 80,
                  lineWidth: 2,
                  progressColor: green1,
                  progress: 1
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
                    title: 'Thông tin cơ bản',
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
                    title: 'Thông tin vận chuyển',
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
                    title: 'Tài khoản ngân hàng',
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
                    title: 'Hoàn tất',
                    topTitle: true
                  )
                ],
              ),
              TextFormField(
                controller: _shopNameController,
                decoration: inputDecoration('Tên shop'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tên shop';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40.0),
              TextFormField(
                controller: _addressController,
                decoration: inputDecoration('Địa chỉ lấy hàng'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập địa chỉ lấy hàng';
                  }
                  return null;
                },

              ),
              const SizedBox(height: 40.0),
              TextFormField(
                controller: _emailController,
                decoration: inputDecoration('Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập email';
                  }
                  if (!RegExp(r'^[a-z0-9]+@[a-z]+\.[a-z]+$').hasMatch(value)) {
                    return 'Email không hợp lệ';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40.0),
              TextFormField(
                controller: _phoneController,
                decoration: inputDecoration('Số điện thoại'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập số điện thoại';
                  }
                  if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                    return 'Số điện thoại không hợp lệ';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30,horizontal:60),
                child: Container(
                  height: 50,
                  width:width,
                  decoration:BoxDecoration(
                      color: green1,
                      borderRadius: BorderRadius.circular(50)
                  ),
                  child: Center(
                      child: TextButton(
                        child: Text("Tiếp tục",style:GoogleFonts.almarai(color:Colors.white,fontSize:20,fontWeight: FontWeight.w700),),
                        onPressed:(){
                           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const FinishSignIn()));
                        },
                      )),
                ),
              ),
            ],
          ),
        ),
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
        labelStyle:const TextStyle(fontSize:15,color:Colors.black,fontWeight:FontWeight.w500)
    );
  }
}