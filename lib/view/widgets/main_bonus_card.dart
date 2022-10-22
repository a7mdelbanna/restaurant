import 'package:flutter/material.dart';

class BonusCard extends StatelessWidget {
  const BonusCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: (){print('tapped');},
      child: Container(height: 220,
        width: 170,
        child: Stack(
          children: [
            Column(mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(height:200,
                width: 170,
                child: Card(
                  child: Column(
                    children: [SizedBox(height: 105,),
                    Text('sauces',style: Theme.of(context).textTheme.headline5,),
                    SizedBox(height: 15,),
                      Text('50\$\$',style: Theme.of(context).textTheme.bodyText1,)],
                  ),
                ),),
              ],
            ),
            Positioned(left:0,right: 0, bottom: 90,child: Image(fit: BoxFit.cover,image: AssetImage('assets/images/pizzaBC.png',),height: 130,width: 120),)

          ],
        ),
      ),
    );
  }
}
