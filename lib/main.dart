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
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
  await Hive.initFlutter();
  Hive.registerAdapter(FavorProductsAdapter());
  await Hive.openBox<FavorProducts>('favourite_products');
  Hive.registerAdapter(CartItemsAdapter());
  await Hive.openBox<CartItems>('cart_items');
  await dotenv.load(fileName: ".env");
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
      ],
      child:const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: WelcomePage(),
      ),
    );
  }
}

