import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'colors.dart';

class Toggle extends StatefulWidget {
  Toggle({Key? key, required this.location}) : super(key: key);
  String location;
  @override
  State<Toggle> createState() => _ToggleState();
}

class _ToggleState extends State<Toggle> {
  List<String> toggleLabelList = ['Delivery', 'Pick up'];
  final int selectedSwitchIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        width: double.infinity,
        height: 110,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: ToggleSwitch(
                    radiusStyle: true,
                    dividerMargin: 10,
                    animate: true,
                    animationDuration: 200,
                    minHeight: 40,
                    minWidth: 140,
                    cornerRadius: 15,
                    activeBgColor: [Colors.white],
                    activeFgColor: Colors.black,
                    inactiveBgColor: Colors.grey,
                    inactiveFgColor: Colors.grey[900],
                    initialLabelIndex: 0,
                    totalSwitches: 2,
                    labels: toggleLabelList,
                    onToggle: (index) {
                      _pageController.animateToPage(index!,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn);
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                children: [
                  ToggleDeliveryPage(
                    location: 'Giza',
                  ),
                  TogglePickUpPage(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ToggleDeliveryPage extends StatelessWidget {
  ToggleDeliveryPage({Key? key, required this.location}) : super(key: key);
  String location;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.delivery_dining,
              color: Colors.blue[900],
            ),
            Text(' to ${location}'),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Select Different Location? ',
              style: TextStyle(color: scheme.secondary),
            ),
            GestureDetector(
              child: Text(
                'Open Map ',
                style: TextStyle(color: scheme.primaryContainer),
              ),
            ),
            Icon(
              Icons.location_on_outlined,
              color: Colors.black,
              size: 18,
            )
          ],
        )
      ],
    );
  }
}

class TogglePickUpPage extends StatelessWidget {
  const TogglePickUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Pick up from the restaurant ?'),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              child: Text(
                'Directions ',
                style: TextStyle(
                  color: Colors.red[900],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
