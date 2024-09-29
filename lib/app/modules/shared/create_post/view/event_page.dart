import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/event_tile.dart';
import '../controller/create_post_controller.dart';
import 'education_type_view.dart';
import 'event_type_view.dart';

class EventPage extends GetView<CreatePostController> {
  const EventPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: const Text(
          'Tag Friends',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Image.asset(
              'assets/icon/create_post/eventdashboard.png',
            ),
            const Text(
              'Share and remember important\nmoments from your life.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
                child: GridView.count(
              crossAxisCount: 2,
              children: [
                EventTile(
                  name: 'Work',
                  imageURL: 'assets/icon/create_post/work.png',
                  onPressed: () {
                    controller.eventType.value = 'work';
                    Get.to(() => EventTypeView());
                  },
                ),
                EventTile(
                  name: 'Education',
                  imageURL: 'assets/icon/create_post/education.png',
                  onPressed: () {
                    controller.eventType.value = 'education';
                    Get.to(() => EducationTypeView());
                  },
                ),

                // EventTile(name: 'Relationship', imageURL: 'assets/icon/create_post/love.png', onPressed: () {  },),
                // EventTile(name: 'Home &\nLiving', imageURL: 'assets/icon/create_post/home.png', onPressed: () {  },),
                // EventTile(name: 'Family', imageURL: 'assets/icon/create_post/family.png', onPressed: () {  },),
                // EventTile(name: 'Travel', imageURL: 'assets/icon/create_post/travel.png', onPressed: () {  },),
                // EventTile(name: 'Interests &\nActivities', imageURL: 'assets/icon/create_post/interest.png', onPressed: () {  },),
                // EventTile(name: 'Health &\nWellness', imageURL: 'assets/icon/create_post/health.png', onPressed: () {  },),
                // EventTile(name: 'Remembrance', imageURL: 'assets/icon/create_post/rememberence.png', onPressed: () {  },),
              ],
            )

                // GridView.builder(
                //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //     crossAxisCount: 3,
                //     mainAxisSpacing: 20,
                //     crossAxisSpacing: 1,
                //     childAspectRatio: 200 / (200 * 1.05),
                //   ),
                //   itemCount: 30,
                //   itemBuilder: (BuildContext context, int index) {
                //     return Container(
                //         margin: EdgeInsets.symmetric(horizontal: 10),
                //         height: 50,
                //         decoration: BoxDecoration(
                //
                //             image: DecorationImage(
                //                 fit: BoxFit.cover,
                //                 image: NetworkImage(
                //                     'https://i0.wp.com/www.galvanizeaction.org/wp-content/uploads/2022/06/Wow-gif.gif?fit=450%2C250&ssl=1'
                //                   // "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
                //                 )
                //
                //             )
                //         ));
                //     // child: NetworkCircleAvatar(
                //     //     imageUrl:
                //     //     "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"));
                //   },
                //
                //
                // ),

                )
          ],
        ),
      ),
    );
  }
}
