class Category {
  final String title;
  final String image;

  Category({
    required this.title,
    required this.image,
  });
}

final List<Category> categories = [
  Category(title: "Shoes", image: "assets/images/shoes.png"),
  Category(title: "Beauty", image: "assets/images/beauty.png"),
  Category(title: "PC", image: "assets/images/pc.png"),
  Category(title: "Mobile", image: "assets/images/mobile.png"),
  Category(title: "Watch", image: "assets/images/watch.png"),
];