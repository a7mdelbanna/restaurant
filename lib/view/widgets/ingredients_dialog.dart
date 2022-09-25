import 'package:flutter/material.dart';

import '../../data/model/meal.dart';

class IngredientsDialog extends StatefulWidget {
  IngredientsDialog(
      {Key? key,
      required this.meal,
      required this.removeTemp,
      required this.removedIngredientsIndex})
      : super(key: key);
  Meal meal;

  List<bool> removeTemp;
  List<bool> removedIngredientsIndex;
  @override
  State<IngredientsDialog> createState() => _IngredientsDialogState();
}

class _IngredientsDialogState extends State<IngredientsDialog> {
  @override
  void initState() {
    super.initState();
  }

  clearRemoved() {
    widget.removedIngredientsIndex = widget.removeTemp;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        height: widget.meal.mealIngredients.length * 53.4 + 60,
        width: 300,
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: List.generate(
                  widget.meal.mealIngredients.length,
                  (index) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                softWrap: true,
                                widget.meal.mealIngredients[index],
                                style: TextStyle(
                                    color: widget.removedIngredientsIndex[index]
                                        ? Colors.grey
                                        : Colors.black,
                                    decorationStyle: TextDecorationStyle.solid,
                                    decorationColor: Colors.black,
                                    fontSize: 16,
                                    decoration:
                                        widget.removedIngredientsIndex[index]
                                            ? TextDecoration.lineThrough
                                            : TextDecoration.none),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                print(widget.removedIngredientsIndex[index]);
                                print(widget.removeTemp[index]);
                                setState(() {
                                  widget.removedIngredientsIndex[index] =
                                      !widget.removedIngredientsIndex[index];
                                });
                              },
                              child: Icon(
                                Icons.close,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          indent: 15,
                          endIndent: 15,
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(10),
                    primary: Colors.amber,
                    minimumSize: Size(150, 50),
                    maximumSize: Size(200, 50),
                  ),
                  onPressed: () {
                    Navigator.pop(context, widget.removedIngredientsIndex);
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(10),
                    primary: Colors.grey,
                    minimumSize: Size(100, 40),
                    maximumSize: Size(150, 40),
                  ),
                  onPressed: () {
                    Navigator.pop(context, null);
                  },
                  child: Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class InfoDialog extends StatelessWidget {
  InfoDialog({Key? key, required this.meal}) : super(key: key);
  Meal meal;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 160,
        width: 250,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              meal.mealTitle,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  decoration: TextDecoration.none),
              softWrap: true,
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              'Nutritional value per 100g: ',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  decoration: TextDecoration.none),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Energy kcal',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      decoration: TextDecoration.none),
                ),
                Text('76 calories',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        decoration: TextDecoration.none))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Protein',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      decoration: TextDecoration.none),
                ),
                Text('55',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        decoration: TextDecoration.none))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Fat',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      decoration: TextDecoration.none),
                ),
                Text('89',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        decoration: TextDecoration.none))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Saturates',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      decoration: TextDecoration.none),
                ),
                Text('120',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        decoration: TextDecoration.none))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
