import 'package:flutter/material.dart';

class CategoryPageView extends StatefulWidget {
  const CategoryPageView({Key? key}) : super(key: key);

  @override
  State<CategoryPageView> createState() => _CategoryPageViewState();
}

class _CategoryPageViewState extends State<CategoryPageView> {
  var selectedCategory = 0;

  var selectedChipIndex = 0;
  var isPressed = false;
  PageController _categoryPageController = PageController(initialPage: 0);
  var isSelected = false;
  var searchedText;
  double selectedIndex = 0.0;

  late TabController _tabController;
  @override
  void initState() {
    super.initState();
  }

  var selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 265,
      child: PageView(
        scrollDirection: Axis.vertical,
        onPageChanged: (index) {
          setState(() {
            selectedChipIndex = index;
          });
        },
        controller: _categoryPageController,
        children: [
          Container(
            height: 200,
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (contxt, index) => Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 5,
                child: Container(
                  width: 230,
                  height: 170,
                  child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.red,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Item 1'),
                              Expanded(
                                child: Row(children: [
                                  const Text(
                                    'Item 1',
                                    softWrap: true,
                                  ),
                                ]),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.orangeAccent[100],
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: const Text(
                                    '200 EGP',
                                    style: TextStyle(color: Colors.deepOrange),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      )),
                ),
              ),
            ),
          ),
          Container(
            height: 200,
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (contxt, index) => Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 5,
                child: Container(
                  width: 230,
                  height: 170,
                  child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.red,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Item 2'),
                              Expanded(
                                child: Row(children: [
                                  const Text(
                                    'Item 2',
                                    softWrap: true,
                                  ),
                                ]),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.orangeAccent[100],
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: const Text(
                                    '300 EGP',
                                    style: const TextStyle(
                                        color: Colors.deepOrange),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      )),
                ),
              ),
            ),
          ),
          Container(
            height: 200,
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (contxt, index) => Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 5,
                child: Container(
                  width: 230,
                  height: 170,
                  child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.red,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Item 3'),
                              Expanded(
                                child: Row(children: [
                                  const Text(
                                    'Item 3',
                                    softWrap: true,
                                  ),
                                ]),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.orangeAccent[100],
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: const Text(
                                    '400 EGP',
                                    style: TextStyle(color: Colors.deepOrange),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      )),
                ),
              ),
            ),
          ),
          Container(
            height: 200,
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (contxt, index) => Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 5,
                child: Container(
                  width: 230,
                  height: 170,
                  child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.red,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Item 3'),
                              Expanded(
                                child: Row(children: [
                                  const Text(
                                    'Item 3',
                                    softWrap: true,
                                  ),
                                ]),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.orangeAccent[100],
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: const Text(
                                    '400 EGP',
                                    style: TextStyle(color: Colors.deepOrange),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      )),
                ),
              ),
            ),
          ),
          Container(
            height: 200,
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (contxt, index) => Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 5,
                child: Container(
                  width: 230,
                  height: 170,
                  child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.red,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Item 3'),
                              Expanded(
                                child: Row(children: [
                                  const Text(
                                    'Item 3',
                                    softWrap: true,
                                  ),
                                ]),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.orangeAccent[100],
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: const Text(
                                    '400 EGP',
                                    style: TextStyle(color: Colors.deepOrange),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
