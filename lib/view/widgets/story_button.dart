import 'package:flutter/material.dart';

import '../../data/model/story.dart';
import 'story_view.dart';

class MyStories extends StatelessWidget {
  MyStories({Key? key}) : super(key: key);
  Stories stories = Stories();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 105,
      child: ListView.builder(
        itemCount: stories.myStories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) =>
            StoryButton(stories.myStories[index], context),
      ),
    );
  }
}

Widget StoryButton(StoryData story, BuildContext context) {
  return Builder(
    builder: (context) => Padding(
      padding: EdgeInsets.only(right: 10, left: 10),
      child: Column(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StoryView(story: story),
                ),
              );
            },
            child: Container(
              width: 90,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.red, width: 2.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(1),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(story.avatarUrl),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}
