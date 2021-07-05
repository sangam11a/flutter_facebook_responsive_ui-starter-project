import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/config/palette.dart';
import 'package:flutter_facebook_responsive_ui/data/data.dart';
import 'package:flutter_facebook_responsive_ui/screens/ViewStory.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: Home(),
    ),
  ));
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          children: [
            SizedBox(width: 10),
            Text(
              "facebook",
              style: TextStyle(
                color: Palette.facebookBlue,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 280),
            circleButton(
                icon: Icons.messenger_outline_sharp,
                color: Colors.grey.shade300),
            SizedBox(width: 20),
            circleButton(
              icon: Icons.search,
              color: Colors.grey.shade300,
            ),
          ],
        ),
        Container(
          height: 70,
          color: Colors.grey.shade200,
          child: Row(
            children: [
              _circleImage(url: currentUser.imageUrl),
              SizedBox(width: 10),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    enabled: true,
                    hintText: "What's in your mind?",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 40,
          color: Colors.grey.shade200,
          child: Row(
            children: [
              _attached(icon: Icons.video_camera_front, str: "Live", x: 1),
              _attached(icon: Icons.photo_album, str: "Photo", x: 1),
              _attached(
                  icon: Icons.video_camera_back_sharp, str: "Rooms", x: 1),
            ],
          ),
        ),
        // Container(
        //   color: Colors.white,
        //   child: SizedBox(
        //     height: 4,
        //   ),
        // ),
        Container(
          height: 60,
          margin: EdgeInsets.symmetric(vertical: 4),
          color: Colors.grey.shade200,
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(4),
                margin: EdgeInsets.symmetric(horizontal: 6),
                width: 80,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.lightBlueAccent),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.video_call),
                    Text("Rooms"),
                  ],
                ),
              ),
              Expanded(child: Container(height: 40, child: _foto())),
            ],
          ),
        ),
        Container(
            height: 280,
            // margin: EdgeInsets.symmetric(vertical: 4),

            child: _story() // _newsList(),
            ),
        for (int i = 0; i < posts.length; i++) _newsFeed(index: i),
      ],
    );
  }
}

Widget circleButton({@required IconData icon, @required Color color}) {
  return GestureDetector(
    child: CircleAvatar(
      child: Icon(icon),
      backgroundColor: color,
      foregroundColor: Colors.black,
    ),
  );
}

Widget _circleImage({@required String url}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 2),
    height: 40,
    width: 40,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      image: DecorationImage(
        image: NetworkImage(currentUser.imageUrl),
        fit: BoxFit.cover,
      ),
    ),
  );
}

Widget _attached(
    {@required IconData icon, @required String str, @required int x}) {
  return Expanded(
      flex: x,
      child: Row(
        children: [
          Icon(icon),
          Text(str),
        ],
      ));
}

// Widget _listOnline() {
//   return Expanded(
//     child: Container(
//       height: 40,
//       child: Row(
//         children: [
//           for (int i = 0; i < posts.length; i++) _foto(index: i),
//           // Expanded(
//           //   child: for (int i=0;i<posts.length;i++) _foto(),
//           // ),
//         ],
//       ),
//     ),
//   );
// }

Widget _foto() {
  return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: onlineUsers.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(right: 7),
          padding: EdgeInsets.symmetric(vertical: 2),
          width: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: NetworkImage(onlineUsers[index].imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        );
      });
}

Widget _story() {
  return Container(
    height: 260,
    decoration: BoxDecoration(
      color: Colors.grey.shade200,
    ),
    child: Row(
      children: [
        Expanded(
          child: Container(
            height: 240,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: stories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewStory(
                                    story: stories[index],
                                  )));
                      // print("$index");
                    },
                    child: Stack(children: [
                      Container(
                        width: 150,
                        margin: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(stories[index].imageUrl),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        left: 20,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                    NetworkImage(onlineUsers[index].imageUrl),
                              ),
                              borderRadius: BorderRadius.circular(20),
                              border: stories[index].isViewed != true
                                  ? Border.all(color: Colors.blue, width: 2)
                                  : Border.all(color: Colors.white)),
                        ),
                      ),
                      Positioned(top: 38, left: 47, child: _greenColor()),
                    ]),
                  );
                }),
          ),
        ),
      ],
    ),
  );
}

// Widget _newsList() {
//   return ListView.builder(
//       itemCount: posts.length,
//       itemBuilder: (context, index) {
//         return Container(
//           padding: EdgeInsets.all(8),
//           height: 600,
//           width: 500,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   _circleImage(url: posts[index].imageUrl),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         posts[index].user.name,
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                       Text(
//                         posts[1].timeAgo,
//                         style: TextStyle(
//                           color: Colors.grey.shade600,
//                           fontSize: 8,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Text(posts[index].caption),
//               SizedBox(
//                 height: 10,
//               ),
//               Container(
//                 height: 400,
//                 width: 500,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: NetworkImage(posts[index].imageUrl),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               Row(
//                 children: [
//                   _aboveLike(
//                       icon: Icons.thumb_up_alt,
//                       str1: posts[index].likes.toString(),
//                       str2: " Likes"),
//                   _aboveLike(
//                       icon: Icons.share_sharp,
//                       str1: posts[index].comments.toString(),
//                       str2: " comments"),
//                   _aboveLike(
//                       icon: Icons.share,
//                       str1: posts[index].shares.toString(),
//                       str2: " Shares"),
//                 ],
//               ),
//               Divider(
//                 color: Colors.white54,
//               ),
//               SizedBox(height: 10),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _expandedLike(icons: Icons.thumb_up, str: "Like"),
//                   _expandedLike(icons: Icons.comment_sharp, str: "Comment"),
//                   _expandedLike(icons: Icons.share_outlined, str: "Share")
//                 ],
//               ),
//             ],
//           ),
//         );
//       });
// }

Widget _newsFeed({@required final int index}) {
  return Container(
    margin: EdgeInsets.only(top: 5),
    padding: EdgeInsets.all(6),
    height: 630,
    width: 500,
    color: Colors.grey.shade200,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _circleImage(url: posts[index].imageUrl),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  posts[1].user.name,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  posts[1].timeAgo,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 8,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Text(posts[index].caption),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 400,
          width: 500,
          decoration: BoxDecoration(
            color: Colors.red,
            image: DecorationImage(
              image: NetworkImage(posts[index].imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Row(
          children: [
            _aboveLike(
                icon: Icons.thumb_up_alt,
                str1: posts[index].likes.toString(),
                str2: " Likes"),
            _aboveLike(
                icon: Icons.message_sharp,
                str1: posts[index].comments.toString(),
                str2: " comments"),
            _aboveLike(
                icon: Icons.share,
                str1: posts[index].shares.toString(),
                str2: " Shares"),
          ],
        ),
        Divider(
          color: Colors.white54,
        ),
        SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _expandedLike(icons: Icons.thumb_up, str: "Like"),
            _expandedLike(icons: Icons.comment_sharp, str: "Comment"),
            _expandedLike(icons: Icons.share_outlined, str: "Share")
          ],
        ),
      ],
    ),
  );
}

Widget _expandedLike(
    {@required final String str, @required final IconData icons}) {
  return Expanded(
    flex: 1,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icons,
          color: Colors.white,
          size: 28,
        ),
        SizedBox(width: 10),
        Text(str, style: TextStyle(fontSize: 10, color: Colors.white)),
        //Text(str),
      ],
    ),
  );
}

Widget _aboveLike(
    {@required final IconData icon,
    @required final String str1,
    @required final String str2}) {
  return Expanded(
    flex: 1,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon),
        Text(" " + str1 + " " + str2),
      ],
    ),
  );
}

Widget _greenColor() {
  return Container(
    height: 10,
    width: 10,
    decoration: BoxDecoration(
      color: Colors.green,
      borderRadius: BorderRadius.circular(5),
    ),
  );
}
