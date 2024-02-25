import 'package:flutter/cupertino.dart';

class ImageSlider extends StatelessWidget {
  final Function(int) onChange;
  final int currentImage;
  final List<String> image;
  const ImageSlider({
    super.key,
    required this.onChange,
    required this.currentImage,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: MediaQuery.of(context).size.width,
      child: PageView.builder(
        itemCount: image.length,
        onPageChanged: onChange,
        itemBuilder: (context, index) {
          return Container(
            height: 250,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(image:NetworkImage(image[index],),fit:BoxFit.contain)
            ),
          );
        },
      ),
    );
  }
}