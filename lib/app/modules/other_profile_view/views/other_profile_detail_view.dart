



import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:quantum_possibilities_flutter/app/components/work_tile.dart';
import 'package:quantum_possibilities_flutter/app/modules/other_profile_view/controller/other_profile_controller.dart';

import '../../../utils/color.dart';

class OtherProfileDetailView extends GetView<OthersProfileController>{
  const OtherProfileDetailView({super.key});


  @override
  Widget build(BuildContext context) {


    //ProfileController profileController=Get.put(ProfileController());
   // controller.getUserData();
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text('About', style: TextStyle(
            color: Colors.black
        ),),
        backgroundColor: Colors.white,
      ),
      body:  ListView(
        shrinkWrap: true,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [




          Obx(() => controller.profileModel.value?.userWorkplaces.length!=0?Container(
            margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Work',style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),),


                Row(
                  children: [
                    Text('Add Workplace',style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: PRIMARY_COLOR
                    ),),

                    SizedBox(width: 3,),
                    Icon(Icons.add_circle,color: PRIMARY_COLOR,size: 19,)
                  ],
                ),




              ],
            ),
          ):Container()),



          Obx(() => ListView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.profileModel.value?.userWorkplaces?.length,
              itemBuilder: (context, index){
                return WorkTile(
                  companyName: '${controller.profileModel.value?.userWorkplaces?[index].org_name}',
                  timeDuration: '${controller.profileModel.value?.userWorkplaces?[index].from_date.toString().split('T')[0]} to ${controller.profileModel.value?.userWorkplaces?[index].to_date.toString().split('T')[0]}',
                  privacy: controller.profileModel.value?.userWorkplaces?[index].from_date!=null? '${controller.profileModel.value?.userWorkplaces?[index].from_date.toString().split('T')[0]} ':'Present',
                  tileIcon: Icon(Icons.business_center,size: 40,color: Colors.grey,),);
              }),),



          Obx(() => controller.profileModel.value?.educationWorkplaces.length!=0? Container(
            margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Education',style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),),


                Row(
                  children: [
                    Text('Add Education',style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: PRIMARY_COLOR
                    ),),

                    SizedBox(width: 3,),
                    Icon(Icons.add_circle,color: PRIMARY_COLOR,size: 19,)
                  ],
                ),

              ],
            ),
          ):Container()),





          ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: controller.profileModel.value?.educationWorkplaces?.length,
              itemBuilder: (context, index){
                return WorkTile(companyName: '${controller.profileModel.value?.educationWorkplaces?[index].institute_name}',
                  timeDuration: '${controller.profileModel.value!.educationWorkplaces?[index].start_at}',
                  privacy:  controller.profileModel.value!.educationWorkplaces?[index].start_at!=null? '${controller.profileModel.value!.educationWorkplaces?[index].start_at}':'',
                  tileIcon: Icon(Icons.school,size: 40,color: Colors.grey,),);
              }),





          Obx(() => controller.profileModel.value?.present_town!=null&&controller.profileModel.value?.home_town!=null?Container(
            margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            child: Text('Places Lived',style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),),
          ):Container()),


          Obx(() => controller.profileModel.value?.present_town!=null?WorkTile(companyName: '${controller.profileModel.value?.present_town}', timeDuration: 'Current City', privacy: 'Current City', tileIcon: Icon(Icons.home,size: 40,color: Colors.grey,),):Container()),



          Obx(() => controller.profileModel.value?.home_town!=null?WorkTile(companyName: '${controller.profileModel.value?.home_town}', timeDuration: 'Home City', privacy: 'Home City', tileIcon: Icon(Icons.location_on,size: 40,color: Colors.grey,),):Container()),



          Container(
            margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            child: Text('Contact Info',style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),),
          ),

          WorkTile(companyName: '${controller.profileModel.value?.phone}', timeDuration: 'Mobile', privacy: 'Mobile', tileIcon: Icon(Icons.phone,size: 40,color: Colors.grey,),),
          WorkTile(companyName: '${controller.profileModel.value?.email}', timeDuration: 'Email', privacy: 'Email', tileIcon: Icon(Icons.mail,size: 40,color: Colors.grey,),),



          Container(
            margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            child: Text('Basic Info',style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),),
          ),

          WorkTile(companyName: '${controller.profileModel.value?.date_of_birth.toString().split('T').first}', timeDuration: 'Birthday', privacy: 'Birthday', tileIcon: Icon(Icons.card_giftcard,size: 40,color: Colors.grey,),),

          controller.profileModel.value?.language!=null? WorkTile(companyName: '${controller.profileModel.value?.language}', timeDuration: 'Language', privacy: 'Language', tileIcon: Icon(Icons.import_contacts,size: 40,color: Colors.grey,),):Container(),






        ],
      )



      // ListView(
      //   shrinkWrap: true,
      //   // crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //
      //
      //
      //
      //     Obx(() => controller.profileModel.value?.userWorkplaces.length!=0?Container(
      //       margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      //       child: Text('Work',style: TextStyle(
      //           fontSize: 20,
      //           fontWeight: FontWeight.bold
      //       ),),
      //     ):Container()),
      //
      //
      //
      //     Obx(() => ListView.builder(
      //       physics: ScrollPhysics(),
      //         shrinkWrap: true,
      //         itemCount: controller.profileModel.value?.userWorkplaces?.length,
      //         itemBuilder: (context, index){
      //           return WorkTile(companyName: '${controller.profileModel.value?.userWorkplaces?[index].org_name}', timeDuration: '${controller.profileModel.value?.userWorkplaces?[index].from_date.toString().split('T')[0]} to ${controller.profileModel.value?.userWorkplaces?[index].to_date.toString().split('T')[0]}', privacy: 'Public',tileIcon: Icon(Icons.business_center,size: 40,color: Colors.grey,),);
      //         }),),
      //
      //
      //
      //     Obx(() => controller.profileModel.value?.educationWorkplaces.length!=0? Container(
      //       margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      //       child: Text('Education',style: TextStyle(
      //           fontSize: 20,
      //           fontWeight: FontWeight.bold
      //       ),),
      //     ):Container()),
      //
      //
      //
      //
      //
      //     ListView.builder(
      //         shrinkWrap: true,
      //         itemCount: controller.profileModel.value?.educationWorkplaces?.length,
      //         itemBuilder: (context, index){
      //           return WorkTile(companyName: '${controller.profileModel.value?.educationWorkplaces?[index].institute_name}', timeDuration: '${controller.profileModel.value!.educationWorkplaces?[index].start_at}', privacy: 'public', tileIcon: Icon(Icons.school,size: 40,color: Colors.grey,),);
      //         }),
      //
      //
      //
      //
      //
      //     Obx(() => controller.profileModel.value?.present_town!=null&&controller.profileModel.value?.home_town!=null?Container(
      //       margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      //       child: Text('Places Lived',style: TextStyle(
      //           fontSize: 20,
      //           fontWeight: FontWeight.bold
      //       ),),
      //     ):Container()),
      //
      //
      //      Obx(() => controller.profileModel.value?.present_town!=null?WorkTile(companyName: '${controller.profileModel.value?.present_town}', timeDuration: 'Current City', privacy: 'Current City', tileIcon: Icon(Icons.home,size: 40,color: Colors.grey,),):Container()),
      //
      //
      //
      //      Obx(() => controller.profileModel.value?.home_town!=null?WorkTile(companyName: '${controller.profileModel.value?.home_town}', timeDuration: 'Home City', privacy: 'Home City', tileIcon: Icon(Icons.location_on,size: 40,color: Colors.grey,),):Container()),
      //
      //
      //
      //     Container(
      //       margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      //       child: Text('Contact Info',style: TextStyle(
      //           fontSize: 20,
      //           fontWeight: FontWeight.bold
      //       ),),
      //     ),
      //
      //     WorkTile(companyName: '${controller.profileModel.value?.phone}', timeDuration: 'Mobile', privacy: 'Mobile', tileIcon: Icon(Icons.phone,size: 40,color: Colors.grey,),),
      //     WorkTile(companyName: '${controller.profileModel.value?.email}', timeDuration: 'Email', privacy: 'Email', tileIcon: Icon(Icons.mail,size: 40,color: Colors.grey,),),
      //
      //
      //
      //     Container(
      //       margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      //       child: Text('Basic Info',style: TextStyle(
      //           fontSize: 20,
      //           fontWeight: FontWeight.bold
      //       ),),
      //     ),
      //
      //     WorkTile(companyName: '${controller.profileModel.value?.date_of_birth.toString().split('T').first}', timeDuration: 'Birthday', privacy: 'Birthday', tileIcon: Icon(Icons.phone,size: 40,color: Colors.grey,),),
      //
      //     controller.profileModel.value?.language!=null? WorkTile(companyName: '${controller.profileModel.value?.language}', timeDuration: 'Language', privacy: 'Language', tileIcon: Icon(Icons.mail,size: 40,color: Colors.grey,),):Container(),
      //
      //
      //
      //
      //
      //
      //   ],
      // ),





    );
  }

}