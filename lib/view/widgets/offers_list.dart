import 'package:flutter/material.dart';

import '../../data/model/dummy_meals.dart';
import '../../data/model/meal.dart';

class OffersList extends StatelessWidget {
  OffersList({Key? key, required this.meals}) : super(key: key);
  Meals meals;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            'Order Offers',
          ),
          SizedBox(
            height: 4,
          ),
          Container(
            width: 400,
            height: 100,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: meals.offers.length,
                itemBuilder: (context, index) {
                  Meal meal = meals.offers[index];
                  return ItemCard(meal: meal);
                }),
          ),
        ],
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  ItemCard({Key? key, required this.meal}) : super(key: key);
  Meal meal;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 1,
      child: Container(
        width: 230,
        height: 100,
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 85,
                  width: 85,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(85),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(meal.mealImageUrl),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(meal.mealTitle),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.orangeAccent[100],
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Text(
                          150.toString(),
                          style: TextStyle(color: Colors.deepOrange),
                        ),
                      ),
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}
