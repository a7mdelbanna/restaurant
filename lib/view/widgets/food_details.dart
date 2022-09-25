import 'package:flutter/material.dart';

import '../../data/model/meal.dart';
import 'widgets.dart';

class FoodDetails extends StatefulWidget {
  const FoodDetails({Key? key, required this.meal}) : super(key: key);
  final Meal meal;

  @override
  State<FoodDetails> createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetails> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.meal.mealTitle,
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
                CustomIconButton(
                  boxShape: BoxShape.circle,
                  size: 20,
                  icon: Icons.info_outline_rounded,
                  onTap: () {},
                  backgroundColor: Colors.white,
                  iconColor: Colors.grey,
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    widget.meal.mealDescription,
                    softWrap: true,
                    overflow: TextOverflow.fade,
                    maxLines: 4,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),

            //
          ],
        ),
      ),
    );
  }
}
//Container(
//   height: 40,
//   width: double.infinity,
//   child: Row(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       Text(
//         widget.meal.mealPrice.toString(),
//       ),
//       SizedBox(
//         width: 10,
//       ),
// Container(
//   height: double.infinity,
//   width: 120,
//   decoration: BoxDecoration(
//     color: Colors.orange,
//     borderRadius: BorderRadius.circular(30),
//   ),
//   child: Row(
//     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//     children: [
//       Text(
//         '-',
//         style: TextStyle(fontSize: 20),
//       ),
//       Container(
//         padding: EdgeInsets.all(12),
//         decoration: BoxDecoration(
//             shape: BoxShape.circle, color: Colors.white),
//         child: Text(
//           quantity.toString(),
//         ),
//       ),
//       Text(
//         '+',
//         style: TextStyle(fontSize: 20),
//       ),
//     ],
//   ),
// ),

//     ],
//   ),
// )
