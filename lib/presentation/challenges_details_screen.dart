/// [ChallengesDetailsScreen] is a StatefulWidget representing an particular challenge.
/// It is responsible for picking the time estimation for size and updating calories on the behalf the time.

import 'package:fitness_tracker_app/bloc/fitness_tracker/fitness_tracker_state.dart';
import 'package:fitness_tracker_app/data/all_fitness_data.dart';
import 'package:fitness_tracker_app/data/all_fitness_data_list.dart';
import 'package:fitness_tracker_app/presentation/challenges_list_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/fitness_tracker/fitness_tracker_bloc.dart';
import '../bloc/fitness_tracker/fitness_tracker_event.dart';
import '../utils/resources/colors.dart';
import '../utils/resources/images.dart';
import '../utils/resources/string.dart';
import 'package:numberpicker/numberpicker.dart';

class ChallengesDetailsScreen extends StatefulWidget {
  AllFitnessData? oneFitnessData;
   ChallengesDetailsScreen({Key? key,this.oneFitnessData}) : super(key: key);

  @override
  State<ChallengesDetailsScreen> createState() => _ChallengesDetailsScreenState();
}

class _ChallengesDetailsScreenState extends State<ChallengesDetailsScreen> {

  // Adds the given [event] to the [FitnessTrackerBloc] using the current [context].
  addEvent(AllFitnessTrackerEvent event) {
    context.read<FitnessTrackerBloc>().add(event);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery
        .of(context)
        .size
        .height;
    var w = MediaQuery
        .of(context)
        .size
        .width;

    return BlocBuilder<FitnessTrackerBloc,AllFitnessTrackerState>(
        builder: (context, state){
          for(int i = 0 ;i< AllFitnessDataList.allFitnessData.length;i++){
            if(widget.oneFitnessData?.id == AllFitnessDataList.allFitnessData[i].id){
              widget.oneFitnessData = AllFitnessDataList.allFitnessData[i];
            }
          }

          return Scaffold(
            body: SafeArea(
              child: Container(
                color: Colors.black,
                width: w,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //FOR SHOWING IMAGE AND ICON
                    Stack(
                      children: [
                        ClipRRect(borderRadius: BorderRadius.circular(20),
                            child: Image.asset(widget.oneFitnessData?.image ?? "", fit: BoxFit.cover,
                              height: h * 0.45,
                              width: w,)),
                        Positioned(
                          top:20,
                          child: Container(
                            width: w- 80,
                            margin: const EdgeInsets.only(left:20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(onTap:(){
                                  Navigator.of(context).pop();},child: transparentIconItem(Icons.arrow_back_ios,55,55,20)),
                                //SizedBox(width: w * 0.52,),
                                transparentIconItem(Icons.favorite_border_outlined,55,55,20)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25,),
                    //ACTIVITY NAME
                    Container(margin:const EdgeInsets.only(left: 5),child: commonWhiteText(widget.oneFitnessData?.exerciseName,35,Colors.white)),
                    const SizedBox(height: 15,),

                    //ACTIVITY DESCRIPTION
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: h * 0.2,
                          width:w * 0.35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white.withOpacity(0.15),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(appImages.fireImage,height: 25,width: 25,),
                              const SizedBox(height:10),
                              commonWhiteText(widget.oneFitnessData?.calories?.toStringAsFixed(2), 26,Colors.white),
                              commonWhiteText("Calories", 13,Colors.grey),
                            ],
                          ),

                        ),
                        SizedBox(width:5),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap:(){
                                _selectDuration(context);
                              },
                              child: Container(
                                height: h * 0.09,
                                width:w * 0.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white.withOpacity(0.15),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(appImages.alarmImage,height:30,width:30),
                                    const SizedBox(width: 10,),
                                    commonWhiteText("${widget.oneFitnessData?.time}",23,Colors.white),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Container(
                              height: h * 0.1,
                              width:w * 0.5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white.withOpacity(0.15),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  commonWhiteText("Focus Zone",13,Colors.grey),
                                  commonWhiteText("Full body",23,Colors.white),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),

                    const SizedBox(height:25),

                    //TRACK BUTTON
                    SizedBox(width: w ,height:50,child: ElevatedButton(onPressed: (){
                      Navigator.of(context).pop();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AllChallengesList()));
                    }, style: ElevatedButton.styleFrom(
                      primary: Color(appColors.red), // Background color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0), // Border radius
                      ),
                    ),child: const Text("Track", style:TextStyle(color:Colors.white,fontWeight: FontWeight.w700,fontSize: 14)),)
                    ),

                  ],
                ),
              ),
            ),
          );
        }

    );
  }

  //COMMON WIDGET TO MAKE ICON WITH TRANSPARENT BACKGROUND
  Widget transparentIconItem(IconData? icon, double? height, double? width,
      double? borderRadius) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(borderRadius ?? 0.0),
      ),
      child: Icon(icon, color: Colors.white,size: 20,),
    );
  }

  //WIDGET FOR RETURNING COMMON WHITE TEXT
  Widget commonWhiteText(String? text, double? size, Color color){
    return Text(
      text ?? "",style:  TextStyle(fontSize: size,fontWeight: FontWeight.w500,color: color),
    );
  }

  Future<void> _selectDuration(BuildContext context) async {
    int? selectedMinutes = 30;

    // Default value
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 235.0,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.8), // Change background color
          ),
          child: StatefulBuilder(
            builder: (context,setState){
              return Column(
                children: [
                  const SizedBox(height:10),
                  const Text('Select Exercise Duration (1-60 minutes)',style: TextStyle(color: Colors.white),),
                  SizedBox(height:10),
                  NumberPicker(
                    value: selectedMinutes!,
                    minValue: 1,
                    maxValue: 60,
                    onChanged: (value) {
                      setState((){
                        selectedMinutes = value;
                      });
                    },
                    textStyle: TextStyle(color: Colors.white), // Change text color
                    selectedTextStyle: TextStyle(color: Colors.red,fontSize: 20), // Change selected text color
                  ),
                  SizedBox(height:10),
                  SizedBox(
                    height: 30,
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        double? burntCalorie;
                        double? totalDistance;
                        if(widget.oneFitnessData?.id == 1){
                          ///AS PER THE https://www.nutristrategy.com/caloriesburned.htm CALORIE BURNT IN 60 Min IN THE RUNNING 5MPH FOR 155 POUNDS
                          burntCalorie = calculateBurntCalories(selectedMinutes: selectedMinutes ?? 0,totalCaloriesFor60Min: 563);
                          //If 5 miles are covered in 60 minutes, we can set up a proportion to find out how many miles will be covered in X minutes.
                          totalDistance = (5/60) * (selectedMinutes ?? 30);
                        }else if(widget.oneFitnessData?.id == 2){
                          ///AS PER THE https://www.nutristrategy.com/caloriesburned.htm CALORIE BURNT IN 60 Min IN THE NORMAL YOGA FOR 155 POUNDS
                          burntCalorie = calculateBurntCalories(selectedMinutes: selectedMinutes ?? 0,totalCaloriesFor60Min: 281);
                          //IN YOGA DISTANCE WILL NOT CALCULATED
                          totalDistance = 0;
                        }else if(widget.oneFitnessData?.id == 3){
                          ///AS PER THE https://www.nutristrategy.com/caloriesburned.htm CALORIE BURNT IN 60 Min IN THE MILD STRETCHING FOR 155 POUNDS
                          burntCalorie = calculateBurntCalories(selectedMinutes: selectedMinutes ?? 0,totalCaloriesFor60Min: 176);
                          //IN STRETCHING DISTANCE WILL NOT CALCULATED
                          totalDistance = 0;
                        }
                        //EVENT CALLING FOR UPDATING THE LIST
                        addEvent(UpdateFitnessDataEvent(context:context,id: widget.oneFitnessData?.id,calorie: burntCalorie,time: selectedMinutes.toString(),distance: totalDistance));
                        Navigator.of(context).pop(selectedMinutes);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(appColors.red), // Background color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0), // Border radius
                        ),
                      ),
                      child: Text('OK'),
                    ),
                  ),
                ],
              );
            },

          ),
        );
      },
    );

    if (selectedMinutes != null) {
      if (kDebugMode) {
        print('Selected Duration: $selectedMinutes minutes');
      }
      // Do something with the selected duration
    }
  }

  //CALCULATING BURNT CALORIE FOR SELECTED TIME
  double? calculateBurntCalories({required int totalCaloriesFor60Min, required int selectedMinutes}) {
    double? burntCalorie;
    burntCalorie = (totalCaloriesFor60Min / 60) * selectedMinutes;
    return burntCalorie;
  }
}
