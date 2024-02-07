import 'package:flutter/material.dart';
import 'package:green_circle/constants.dart';
import 'package:badges/badges.dart'as badges;
import 'package:green_circle/services/share_link.dart';
import 'package:share_plus/share_plus.dart';

class ProductAppBar extends StatefulWidget {
  final int cart;
  const ProductAppBar({super.key,required this.cart});
  @override
  State<ProductAppBar> createState() => _ProductAppBarState();
}

class _ProductAppBarState extends State<ProductAppBar>with SingleTickerProviderStateMixin{
  bool isFav = false;
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _colorAnimation = ColorTween(begin: mediumGray, end: Colors.red).animate(_controller);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          isFav = true;
        });
      }
      if (status == AnimationStatus.dismissed) {
        setState(() {
          isFav = false;
        });
      }
    });
  }

  // dismiss the animation when widgit exits screen
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: IconButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.only(left:10),
            ),
            icon: const Icon(Icons.chevron_left,size:40,),
          ),
          const Spacer(),
          IconButton(
            onPressed: ()async{
              Uri link=await DynamicLinkService.instance.createDynamicLink();
              Share.share("Shopping product:$link");
            },
            style: IconButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.all(15),
            ),
            icon: const Icon(Icons.share,size:30,),
          ),
          const SizedBox(width: 5),
          AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, _){
                return IconButton(
                  icon: Icon(
                    isFav?Icons.favorite:Icons.favorite_border_rounded,
                    color: _colorAnimation.value,
                    size: 30,
                  ),
                  onPressed: () {
                    isFav ? _controller.reverse() : _controller.forward();
                  },
                );
              }
          ),
          const SizedBox(width: 5),
          badges.Badge(
            position: badges.BadgePosition.topEnd(top: 0, end: 2),
            badgeAnimation: const badges.BadgeAnimation.slide(
              // disappearanceFadeAnimationDuration: Duration(milliseconds: 200),
              // curve: Curves.easeInCubic,
            ),
            showBadge: true,
            badgeStyle: const badges.BadgeStyle(
              badgeColor: green1,
            ),
            badgeContent: Text(
              widget.cart.toString(),
              style: const TextStyle(color: Colors.white),
            ),
            child: IconButton(icon: const Icon(Icons.shopping_cart), onPressed: () {}),
          )],
      ),
    );
  }
}