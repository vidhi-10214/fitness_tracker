/// [TrackChallenges] is a StatefulWidget representing the weekly data.
/// It is responsible for tracking data.

import 'package:fitness_tracker_app/data/all_fitness_data_list.dart';
import 'package:fitness_tracker_app/utils/resources/colors.dart';
import 'package:fitness_tracker_app/utils/resources/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/fitness_tracker/fitness_tracker_bloc.dart';
import '../bloc/fitness_tracker/fitness_tracker_event.dart';
import '../bloc/fitness_tracker/fitness_tracker_state.dart';
import '../data/all_fitness_data.dart';

class TrackChallenges extends StatefulWidget {
  const TrackChallenges({Key? key}) : super(key: key);

  @override
  State<TrackChallenges> createState() => _TrackChallengesState();
}

class _TrackChallengesState extends State<TrackChallenges> {
  List<String> day = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  int? weekDay;
  double? totalCalorieBurnt = 0.0;
  int? totalTime = 0;
  double? totalDistance = 0.0;
  List<AllFitnessData> todayFitnessData = [];

// ADDS THE GIVEN [EVENT] TO THE [FITNESSTRACKERBLOC] USING THE CURRENT [CONTEXT].
  addEvent(AllFitnessTrackerEvent event) {
    context.read<FitnessTrackerBloc>().add(event);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addEvent(GetFitnessListDataEvent(context: context));
    DateTime dateTime = DateTime.now();
    weekDay = dateTime.weekday;
    print("weekday $weekDay");
  }

  //CALCULATING THE TOTAL BURNT CALORIE, TOTAL TIME AND TOTAL DISTANCE DONE BY USER WITH ALL ACTIVITY
  totalBurntCalorie(List<AllFitnessData> todayFitnessData){
    for(int i = 0;i<todayFitnessData.length;i++){
      totalCalorieBurnt = (todayFitnessData[i].calories ?? 0.0) + totalCalorieBurnt!;
      totalTime = int.parse(todayFitnessData[i].time ?? "0.0") + totalTime!;
      totalDistance = (todayFitnessData[i].distance ?? 0.0) + totalDistance!;
    }
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery
        .of(context)
        .size
        .width;
    var h = MediaQuery
        .of(context)
        .size
        .height;
    return BlocBuilder<FitnessTrackerBloc, AllFitnessTrackerState>(
      builder: (context, state){
        //ADDING THE DATA AND CALCULATE TOTAL CALORIE AND TIME AND DISTANCE.
        if(todayFitnessData.isEmpty){
          todayFitnessData = state.allFitnessDataList ?? [];
          totalBurntCalorie(todayFitnessData ?? []);
        }
      return Scaffold(
        body: SafeArea(
          child: Container(
            width: w,
            padding: const EdgeInsets.all(10),
            height: h,
            child: Column(
              children: [

                //PROFILE SECTION
                Stack(
                  children: [
                    Container(
                    height: h*0.35,
                    width: w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(appColors.lightPink),
                    ),
                  ),
                    Positioned(
                      top:20,
                      child: Container(
                        width: w - 60,
                        margin: const EdgeInsets.only(left:20),
                        child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(onTap:(){Navigator.of(context).pop();},child: styledIconItem(Icons.arrow_back_ios,55,55,20)),
                            //SizedBox(width: w * 0.55,),
                            styledIconItem(CupertinoIcons.ellipsis,55,55,20),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: EdgeInsets.only(top: 70),
                        child: Column(
                          children: [
                            Container(height:100,width: 100,
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.red.withOpacity(0.3),
                            ),

                              child: Image.asset(appImages.girlIcon,height: 50,width: 50,),

                            ),
                            const SizedBox(height:20),
                            const Text("Ankita Saxena",style: TextStyle(color: Colors.black,fontSize: 25),),
                            const SizedBox(height:10),
                            const Text("23 year old, Female",style: TextStyle(color: Colors.grey,fontSize: 15),),

                          ],
                        ),
                      ),
                    )


                  ]
                ),

               const SizedBox(height: 10,),

                //BAR GRAPH SECTION
                Container(
                  height: h*0.5,
                  width: w,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(appColors.red),
                  ),
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Your Activity",style: TextStyle(color: Colors.white,fontSize: 20),),
                      SizedBox(height:40),
                      Container(
                        height:190,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            for(int i =1;i<8;i++)
                            timeGraph(weekDay == i && totalTime != 0 ?true:false, weekDay == i? double.parse(totalTime.toString()) : 2,i),
                            ],
                        ),
                      ),
                      const SizedBox(height:10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for(int i = 0;i<day.length;i++)
                            Container(width: 46,alignment:Alignment.center,child: Text("${day[i]}",style: TextStyle(color: Colors.white.withOpacity(0.5)),))
                        ],
                      ),
                      const SizedBox(height:25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          bottomData(totalCalorieBurnt?.toStringAsFixed(2),"Calories"),
                          bottomData("00:${totalTime.toString()}","Times"),
                          bottomData(totalDistance?.toStringAsFixed(2),"Kilometers"),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );}
    );
  }

  //COMMON WIDGET TO MAKE ICON WITH BACKGROUND
  Widget styledIconItem(IconData? icon, double? height, double? width,
      double? borderRadius) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius ?? 0.0),
      ),
      child: Icon(icon, color: Colors.black,size: 20,),
    );
  }

  //WIDGET FOR MAKING BAR GRAPH
  Widget timeGraph(
      bool visible,double? timeValue, int index) {
    print(weekDay);
    return SizedBox(
      width:46,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Visibility(visible :visible,child: Stack(
            children: [
              SizedBox(height:40,width: 40,child: Image.asset(appImages.popUp ,fit: BoxFit.cover, )),
              Positioned(
                top: 7,
                  left: 3,
                  child: Text("${timeValue?.toStringAsFixed(0)} min", style: const TextStyle(color: Colors.white,fontSize: 9),)),

            ],
          )),
          SizedBox(height:5),
          Container(
            height:timeValue == 0.0?2:timeValue,
            width: 30,
            decoration: BoxDecoration(
              color: weekDay == index?Colors.white:Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ],
      ),
    );
  }

  //COMMON WIDGET FOR SHOWING BOTTOM DATA
  Widget bottomData(String? text1, String? text2){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text1 ?? "",style: TextStyle(color: Colors.white,fontSize: 20),),
        Text(text2 ?? "",style: TextStyle(color: Colors.white.withOpacity(0.5),fontSize: 12),),

      ],
    );
  }
}
