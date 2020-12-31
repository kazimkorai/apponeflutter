// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter_material_pickers/helpers/show_checkbox_picker.dart';
//
// class MyTestInersetPick extends StatefulWidget {
//   @override
//   _MyTestInersetPickState createState() => _MyTestInersetPickState();
// }
//
// class _MyTestInersetPickState extends State<MyTestInersetPick> {
//   List<String> iceCreamToppings = <String>[
//     'Hot Fudge',
//     'Sprinkles',
//     'Caramel',
//     'Oreos',
//   ];
//   List<String> selectedIceCreamToppings = <String>[
//     'Hot Fudge',
//     'Sprinkles',
//   ];
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }
//
//   void onPresedButton() {
//     showMaterialCheckboxPicker(
//         context: context,
//         title: "Pick Your Interest Upto 8",
//         items: iceCreamToppings,
//         onConfirmed: () {
//           print("onConfirmed");
//         },
//         selectedItems: selectedIceCreamToppings,
//         onChanged: (value) {
//           setState(() {
//             selectedIceCreamToppings = value;
//             print(selectedIceCreamToppings.length);
//           });
//         });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Container(
//             child: RaisedButton(
//               child: Text("Show List"),
//               onPressed: () {
//                 onPresedButton();
//               },
//             ),
//           ),
//           getList()
//         ],
//       ),
//     );
//   }
//
//   Widget getList() {
//     return GridView.builder(
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 4,
//         ),
//         shrinkWrap: true,
//         itemCount: selectedIceCreamToppings.length,
//         itemBuilder: (BuildContext context, int index) {
//           return Container(
//             margin: EdgeInsets.only(left: 10, right: 10,top: 10),
//             height: 50,
//             width: 200,
//             child: Card(
//                 margin: EdgeInsets.only(left: 10, right: 10),
//                 child: Column(
//                   children: [
//                     Text(selectedIceCreamToppings[index]),
//
//                   ],
//                 )),
//           );
//         });
//   }
// }
