import 'package:flutter/material.dart';
import 'package:restaurant/view/screens/menu_screen.dart';

class SelectCity extends StatefulWidget {
  SelectCity({Key? key}) : super(key: key);

  @override
  State<SelectCity> createState() => _SelectCityState();
}

class _SelectCityState extends State<SelectCity> {
  int selectedCityIndex = 0;
  List<String> citynames = List.generate(20, (index) => 'city');
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * .25,
              color: Colors.white,
              child: Column(
                children: [
                  const SizedBox(
                    height: 7,
                  ),
                  const Text('Select a city to view the menu'),
                  const SizedBox(
                    height: 7,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.only(left: 5),
                            primary: Colors.white,
                            elevation: 0,
                            textStyle: const TextStyle(color: Colors.orange),
                          ),
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Icon(
                                Icons.arrow_back_ios,
                                color: Colors.orange,
                                size: 16,
                              ),
                              Text(
                                'Countries',
                                style: TextStyle(color: Colors.orange),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(color: Colors.orange),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        contentPadding: const EdgeInsets.only(left: 15),
                        fillColor: Colors.grey[400],
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            )),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey[300],
                        ),
                        hintText: 'City Name',
                        hintStyle: TextStyle(color: Colors.grey[300]),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    color: Colors.grey,
                  )
                ],
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * .70,
                  child: ListView.builder(
                    itemCount: 30,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        setState(
                          () {
                            selectedCityIndex = index;
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MenuScreen()),
                              (route) => true,
                            );
                          },
                        );
                      },
                      child: SizedBox(
                        height: 40,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('City'),
                                selectedCityIndex == index
                                    ? Icon(
                                        Icons.check,
                                        color: Colors.orange,
                                        size: 18,
                                      )
                                    : SizedBox()
                              ],
                            ),
                            Divider(
                              color: Colors.grey,
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
