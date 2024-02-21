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
}

final List<Category> categories = [
  Category(title: "Shoes", image: "assets/images/shoes.png",location:"In Ha noi"),
  Category(title: "Beauty", image: "assets/images/beauty.png",location:"In Ha noi"),
  Category(title: "PC", image: "assets/images/pc.png",location:"In Ha noi"),
  Category(title: "Mobile", image: "assets/images/mobile.png",location:"In Ha noi"),
  Category(title: "Watch", image: "assets/images/watch.png",location:"In Ha noi"),
];