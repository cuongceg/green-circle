class Category {
  final String title,image;
  String? location;

  Category({
    required this.title,
    required this.image,
    this.location,
  });
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      title: json['title'],
      image: json['image'],
      location: json['location']
    );
  }
  Map<String,dynamic> toJson(){
    return{
      "title":title,
      "image":image,
      "location":location
    };
  }
  Map<String, dynamic> toMap() {
    return {
      "title":title,
      "image":image,
      "location":location
    };
  }
}

final List<Category> categories = [
  Category(title: "Green Circle Support Agency",image:"assets/images/logo.png",location:"" ),
  Category(title: "Shoes", image: "assets/images/shoes.png",location:"In Ha noi"),
  Category(title: "Beauty", image: "assets/images/beauty.png",location:"In Ha noi"),
  Category(title: "PC", image: "assets/images/pc.png",location:"In Ha noi"),
  Category(title: "Mobile", image: "assets/images/mobile.png",location:"In Ha noi"),
  Category(title: "Watch", image: "assets/images/watch.png",location:"In Ha noi"),
  Category(title: "Wireless", image: "assets/images/wireless.png",location:"In Ha noi"),
  Category(title: "VNPT", image: "assets/images/vnpay.png",location:"In Ha noi"),
  Category(title: "Mi band", image: "assets/images/miband.png",location:"In Ha noi"),
];
// class Prediction {
//   final String classLabel;
//   final int classId;
//   final double confidence;
//
//   Prediction({required this.classLabel, required this.classId, required this.confidence});
//
//   factory Prediction.fromJson(Map<String, dynamic> json) {
//     return Prediction(
//       classLabel: json['class'],
//       classId: json['class_id'],
//       confidence: json['confidence'],
//     );
//   }
// }
//
// class ImageData {
//   final int width;
//   final int height;
//
//   ImageData({required this.width,required this.height});
//
//   factory ImageData.fromJson(Map<String, dynamic> json) {
//     return ImageData(
//       width: json['width'],
//       height: json['height'],
//     );
//   }
// }
//
// class ClassificationResult {
//   final double time;
//   final ImageData image;
//   final List<Prediction> predictions;
//   final String top;
//   final double confidence;
//
//   ClassificationResult({
//     required this.time,
//     required this.image,
//     required this.predictions,
//     required this.top,
//     required this.confidence,
//   });
//
//   factory ClassificationResult.fromJson(Map<String, dynamic> json) {
//     return ClassificationResult(
//       time: json['time'],
//       image: ImageData.fromJson(json['image']),
//       predictions: List<Prediction>.from(
//           json['predictions'].map((prediction) => Prediction.fromJson(prediction))),
//       top: json['top'],
//       confidence: json['confidence'],
//     );
//   }
// }
