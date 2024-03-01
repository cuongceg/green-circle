import 'package:flutter/material.dart';
import 'package:green_circle/constants.dart';
import 'package:green_circle/models/production.dart';
import 'package:hive/hive.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var box = Hive.box<CartItems>('cart_items');
  bool onSelected= false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon:const Icon(Icons.arrow_back),
          onPressed:(){
              Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body:box.isNotEmpty?
      ListView.builder(
          itemCount: box.length,
          itemBuilder: (context, index) {
            return ListTile(
                leading: Checkbox(
                  value: onSelected,
                  onChanged: (bool? value) {},
                  checkColor: green1,
                  activeColor: Colors.white,
                ),
                onTap:(){
                  setState(() {
                    onSelected=!onSelected;
                  });
                },
                title: Text(box.getAt(index)!.title,style:body1Black,),
                subtitle: Text("${box.getAt(index)!.price.toStringAsFixed(0)} 000",style: subTitleFonts,),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          if (box.getAt(index)!.quantity > 1) {
                            box.getAt(index)!.quantity--;
                          }
                        });
                      },
                    ),
                    Text('${box.getAt(index)!.quantity}'),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          box.getAt(index)!.quantity++;
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          box.deleteAt(index);
                        });
                      },
                    ),
                  ],
                )
            );
          }
          ):
      const Center(
        child: Text("Cart Items is empty"),
      ),
    );
  }
}

//
//
// class CartScreen extends StatefulWidget {
//   const CartScreen({super.key});
//   @override
//   State<CartScreen> createState() => _CartScreenState();
// }
//
// class _CartScreenState extends State<CartScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         centerTitle: true,
//         title: const Text(
//           "My Cart",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         leadingWidth: 60,
//         leading: Padding(
//           padding: const EdgeInsets.only(left: 5),
//           child: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             style: IconButton.styleFrom(
//               backgroundColor: Colors.white,
//             ),
//             icon: const Icon(Icons.chevron_left),
//           ),
//         ),
//       ),
//       bottomSheet: CheckOutBox(
//         items: cartItems,
//       ),
//       body: ListView.separated(
//         padding: const EdgeInsets.all(20),
//         itemBuilder: (context, index) => CartTile(
//           item: cartItems[index],
//           onRemove: () {
//             if (cartItems[index].quantity != 1) {
//               setState(() {
//                 cartItems[index].quantity--;
//               });
//             }
//           },
//           onAdd: () {
//             setState(() {
//               cartItems[index].quantity++;
//             });
//           },
//         ),
//         separatorBuilder: (context, index) => const SizedBox(height: 20),
//         itemCount: cartItems.length,
//       ),
//     );
//   }
// }