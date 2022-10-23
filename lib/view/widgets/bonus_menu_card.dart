import 'package:flutter/material.dart';

class BonusMenuCard extends StatelessWidget {
  const BonusMenuCard({Key? key}) : super(key: key);
  Widget _buildPanelHeader(context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          children: [
            Center(
              child: Image.asset(
                  fit: BoxFit.cover,
                  height: 70,
                  width: 80,
                  'assets/images/pizza.jpg'),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 24,
                          child: Text(
                        'tomato sauce',
                            style: Theme.of(context).textTheme.headline5,
                            softWrap: true,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 55,
                    child: Text(
                      'tomato sauce',
                      style: Theme.of(context).textTheme.headline5,
                      softWrap: true,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(child: Chip(label: Text('50 \$\$',),backgroundColor: Colors.orangeAccent,),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Card(child:_buildPanelHeader(context),);
  }
}
