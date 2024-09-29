// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantum_possibilities_flutter/app/utils/color.dart';

class MultipleMyDayDetail extends StatefulWidget {
  final String imageURL;
  final String profileImage;
  final String userName;
  final String createdAt;
  final String title;

  const MultipleMyDayDetail(
      {super.key,
      required this.imageURL,
      required this.profileImage,
      required this.userName,
      required this.createdAt,
      required this.title});

  @override
  State<MultipleMyDayDetail> createState() => _MultipleMyDayDetailState();
}

class _MultipleMyDayDetailState extends State<MultipleMyDayDetail>
    with TickerProviderStateMixin {
  RxBool isTap = false.obs;

  late AnimationController animationController;
  List<Icon> iconList = [
    const Icon(
      Icons.thumb_up,
      color: Colors.blue,
    ),
    const Icon(
      Icons.favorite,
      color: Colors.red,
    ),
    const Icon(
      Icons.emoji_emotions_rounded,
      color: Colors.amber,
    ),
    const Icon(
      Icons.sentiment_satisfied,
      color: Colors.green,
    ),
    const Icon(
      Icons.sentiment_dissatisfied,
      color: Colors.red,
    ),
  ];

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 5))
          ..addListener(() {
            if (animationController.value >= 0.99) {
              animationController.stop();
              Get.back();
            }

            setState(() {});
          });

    animationController.repeat(reverse: false);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTapDown: (tapDetail) {
          //if(isTap.value==false){
          animationController.stop();
          isTap.value = true;
          //}
          // else{
          //   animationController.repeat();
          //   isTap.value=false;
          // }
        },
        onTapUp: (tapDetail) {
          animationController.repeat();
          isTap.value = false;
        },
        child: Container(
          height: Get.height,
          width: Get.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              fit: BoxFit.fitWidth,
              image: NetworkImage(
                widget.imageURL,
                //'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fHww'
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  LinearProgressIndicator(
                    color: PRIMARY_COLOR,
                    value: animationController.value,
                    // semanticsLabel: 'Linear progress indicator',
                  ),
                  SizedBox(
                    width: Get.width,
                    //margin: EdgeInsets.symmetric(vertical: 40),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                          widget.profileImage,
                          //'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fHww',
                        ),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: Get.width / 3 - 10,
                                child: Text(
                                  widget.userName,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              Text(
                                ' ${widget.createdAt}',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.more_horiz,
                                    color: Colors.white,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                        ],
                      ),
                      subtitle: Text(
                        widget.title,
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    // padding: EdgeInsets.all(10),
                    // alignment: Alignment.center,
                    height: 38,
                    width: 38,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Icon(Icons.share),
                  ),
                  Container(
                    height: 40,
                    width: Get.width - 170,
                    padding: const EdgeInsets.all(5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(
                            0.5), //Color.fromARGB(135, 238, 238, 238),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          isCollapsed: true,
                          hintText: 'Send message',
                          hintStyle: TextStyle(fontSize: 15),
                          border: InputBorder.none),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      width: Get.width / 3.8,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: iconList.length,
                          itemBuilder: (context, index) {
                            return iconList[index];
                          }),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
