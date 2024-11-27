import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:green_circle/models/production.dart';
import 'package:green_circle/screen/e_commerce/welcome_screen.dart';
import 'package:green_circle/models/user.dart';
import 'package:green_circle/services/auth_services.dart';
import 'package:green_circle/services/database.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'models/cart_item.dart';

void main() async{
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white, // status bar color
    statusBarIconBrightness: Brightness.dark// black icon status bar
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if(!kDebugMode) {// check mode is debug or release
    await FirebaseAppCheck.instance.activate(
      androidProvider: AndroidProvider.playIntegrity,
      appleProvider: AppleProvider.appAttest,
      webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    );
  } else {
    await FirebaseAppCheck.instance.activate(
      androidProvider: AndroidProvider.debug,
      appleProvider: AppleProvider.debug,
    );
  }
  await dotenv.load(fileName: "assets/.env");
  if(dotenv.env['GEMINI_TOKEN']!=null){
    Gemini.init(apiKey: dotenv.env['GEMINI_TOKEN']??"");
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<MyUser?>.value(value: AuthService().user, initialData:null),
        StreamProvider<List<UserInformation>?>.value(value: Database().authData, initialData:null),
        StreamProvider<List<Product>?>.value(value: Database().productData, initialData:null),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartItemProvider()),
      ],
      child: Consumer<List<Product>?>(
        builder: (context, products, child) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (products != null) {
              Provider.of<ProductProvider>(context, listen: false).setProducts(products);
            }
          });
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: WelcomePage(),
          );
        },
      ),
    );
  }
}


