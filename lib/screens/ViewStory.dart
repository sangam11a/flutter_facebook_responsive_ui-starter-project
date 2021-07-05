import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/models/story_model.dart';

class ViewStory extends StatelessWidget {
  final Story story;
  ViewStory({@required this.story});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(story.imageUrl),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
