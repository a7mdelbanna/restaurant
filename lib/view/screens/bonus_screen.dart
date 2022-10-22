import 'package:flutter/material.dart';
import 'package:restaurant/view/widgets/main_bonus_card.dart';

class BonusScreen extends StatelessWidget {
  const BonusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
     padding: EdgeInsets.symmetric(horizontal:20),
         decoration:  BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/purpleBG.png',),fit: BoxFit.fill )),
        child: Column(children: [SizedBox(height: 80,),Row(
          children: [Text('Bonus amount: 360',style: Theme.of(context).textTheme.headline4), Image(image: AssetImage('assets/images/coin.png'),height: 20,width: 20,)],),
          SizedBox(height: 15,),
          Row(children: [
            Text('Order more to get more!..',style: Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 12,fontWeight: FontWeight.w300),)
          ],),
          SizedBox(height: 40,),
          Container(height: 220,child: ListView.builder(physics: ScrollPhysics(),scrollDirection: Axis.horizontal,shrinkWrap: true,itemCount: 5,itemBuilder: (context,index)=> BonusCard()),),

          SizedBox(height: 40,),
          Row(children: [Icon(Icons.info_outline,color: Colors.white,size: 18,),SizedBox(width: 10,),Text('Terms and conditions!',style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 15),),Spacer(),Icon(Icons.arrow_forward_ios,color: Colors.white,size: 12,),],),
          SizedBox(height: 30,),
          Row(children: [Icon(Icons.info_outline,color: Colors.white,size: 18,),SizedBox(width: 10,),Text('Terms and conditions!',style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 15),),Spacer(),Icon(Icons.arrow_forward_ios,color: Colors.white,size: 12,),],),
          // ListTile(horizontalTitleGap: 0,leading: Icon(Icons.info_outline,color: Colors.white,size: 15,),title: Text('Terms and conditions!',style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 12),),trailing: Icon(Icons.arrow_forward_ios,color: Colors.white,size: 15,),),
          // ListTile(horizontalTitleGap: 0,leading: Icon(Icons.info_outline,color: Colors.white,size: 15,),title: Text('Terms and conditions!',style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 12),),trailing: Icon(Icons.arrow_forward_ios,color: Colors.white,size: 15,),),
        ],),
      ),
    );
  }
}
