import 'package:flutter/material.dart';

import '../widgets/bonus_menu_card.dart';
class BonusMenu extends StatelessWidget {
  const BonusMenu({Key? key}) : super(key: key);
_buildCategory(context){
  return Column(children: [Text('sauces',style: Theme.of(context).textTheme.headline4,),
   SizedBox(height: 20,),
    Text('get what u need for only 50\$\$',style: Theme.of(context).textTheme.subtitle1,),
    SizedBox(height: 30,),
    Column(children: List.generate(5, (index) => BonusMenuCard()),),
  ],);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal:20),
      decoration:  BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/purpleBG.png',),fit: BoxFit.fill )),
      child: SingleChildScrollView(child: Column(children:List.generate(5, (index) => _buildCategory(context),),),),
    ),);
  }
}
