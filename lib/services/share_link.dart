import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class DynamicLinkService{
  static final DynamicLinkService _singleton = DynamicLinkService._internal();
  DynamicLinkService._internal();
  static DynamicLinkService get instance => _singleton;

  Future<Uri> createDynamicLink() async{
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse("https://greencircle.page.link.com/test1"),
      uriPrefix: "https://greencircle.page.link",
      androidParameters: const AndroidParameters(packageName: "com.example.green_circle"),
      //iosParameters: const IOSParameters(bundleId: "com.example.app.ios"),
    );
    final dynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
    return dynamicLink.shortUrl;
  }
}