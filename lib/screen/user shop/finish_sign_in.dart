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
      appBar: AppBar(
        title: const Text('Hoàn tất đăng ký'),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,color: Colors.black,),
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
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Text('Kiểm tra thông tin của cửa hàng bạn để hoàn tất đăng ký',
                style: TextStyle(fontSize: 16,fontWeight:FontWeight.bold),
                textAlign: TextAlign.center,
              ),
          ),
          const SizedBox(height: 10),
          information('Tên cửa hàng: **********'),
          information('Email: **********'),
          information('Số điện thoại: **********'),
          information('Địa chỉ nhận hàng: **********'),
          information('Phương thức vận chuyển: **********'),
          information('Số tài khoản ngân hàng: **********'),
          CheckboxListTile(
              value: onTapped,
            checkColor: green1,
            activeColor: Colors.white,
              onChanged: (bool? value) {
                setState(() {
                  onTapped = value!;
                });
              },
            title: const Text('Bằng cách ấn vào nút đăng ký bạn đã đồng ý với thông tin và điều khoản của Green Circle'),
            controlAffinity: ListTileControlAffinity.leading,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10,horizontal:60),
            child: Container(
              height: 50,
              width:MediaQuery.of(context).size.width,
              decoration:BoxDecoration(
                  color: green1,
                  borderRadius: BorderRadius.circular(50)
              ),
              child: Center(
                  child: TextButton(
                    child: Text("Đăng ký",style:GoogleFonts.almarai(color:Colors.white,fontSize:20,fontWeight: FontWeight.w700),),
                    onPressed:(){
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              title: const Text('Đăng ký thành công'),
                              content: const Text('Chúng tôi sẽ gửi lại email để xác nhận lại thông tin thẻ ngân hàng của bạn. Cảm ơn bạn đã đăng ký với Green Circle!'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainScreen()));
                                  },
                                  child: const Text('Quay lai trang chủ',style: TextStyle(color: green1,fontWeight: FontWeight.bold))
                                ),
                              ],
                            );
                          }
                      );
                    },
                  )),
            ),
          ),
        ],
      )
    );
  }

  Widget information(String content){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:30,vertical:15),
      child:Container(
        height:45,
        width: 350,
        decoration: BoxDecoration(
          color: lightGray,
          border: Border.all(color: Colors.black87),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const SizedBox(width: 15,),
            Text(content,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),textAlign: TextAlign.start,)
            ]
        ),
      )
    );
  }
}
