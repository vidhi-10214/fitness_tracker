/// [AllChallengesList] is a StatefulWidget representing the list of all challenges.
/// It is responsible for managing the state ans showing all activities associated with the challenges list.

import 'package:fitness_tracker_app/bloc/fitness_tracker/fitness_tracker_event.dart';
import 'package:fitness_tracker_app/presentation/track_challenges_screen.dart';
import 'package:fitness_tracker_app/utils/resources/colors.dart';
import 'package:fitness_tracker_app/utils/resources/images.dart';
import 'package:fitness_tracker_app/utils/resources/string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/fitness_tracker/fitness_tracker_bloc.dart';
import '../bloc/fitness_tracker/fitness_tracker_state.dart';
import '../data/all_fitness_data.dart';
import '../data/featured_category.dart';
import 'challenges_details_screen.dart';

class AllChallengesList extends StatefulWidget {
  const AllChallengesList({Key? key}) : super(key: key);

  @override
  State<AllChallengesList> createState() => _AllChallengesListState();
}

class _AllChallengesListState extends State<AllChallengesList> {
  //VARIABLE DECLARATION
  List<AllFitnessData> todayFitnessData = [];
  List<FeaturedCategory> featuredCategory = [];
  double? progressBarValue;

  // ADDS THE GIVEN [EVENT] TO THE [FITNESSTRACKERBLOC] USING THE CURRENT [CONTEXT].
  addEvent(AllFitnessTrackerEvent event) {
    context.read<FitnessTrackerBloc>().add(event);
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //GETTING THE LIST OF FITNESS DATA
    addEvent(GetFitnessListDataEvent(context: context));
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
        //COPY THE FITNESS LIST DATA FROM STATE
        todayFitnessData = state.allFitnessDataList ?? [];
        featuredCategory = state.allFeaturedCategoryDataList ?? [];

        print("todayFitnessData $todayFitnessData");
        return  Scaffold(
          body: SafeArea(
            child: Container(
              padding: const EdgeInsets.only(left:20,right:20,top: 10),
              child: Column(
                children: [
                  //MENU AND PROFILE ROW
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      createStyledIconItem(appColors.grey, appImages.menuIcon,55,55,20),
                      GestureDetector(onTap:(){
                        //NAVIGATION TO TRACK CHALLENGES SCREEN
                        Navigator.push(context, MaterialPageRoute(builder: (context) => TrackChallenges()));

                      },child: createStyledIconItem(appColors.lightPink, appImages.girlIcon,55,55,20)),
                    ],
                  ),
                  const SizedBox(height:35),
                  //GREETING ROW
                  Row(
                    children: [
                      Text(appString.greetingString,style: const TextStyle(fontSize: 30,fontWeight: FontWeight.w500),),
                      const SizedBox(width: 5,),
                      Image.asset(appImages.helloImage,height:30,width: 30,color: Colors.amber,),
                    ],
                  ),
                  const SizedBox(height:20),
                  //SEARCH BAR AND FILTER ROW
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 280,
                        height: 55,
                        padding: const EdgeInsets.only(left:10,right: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(appColors.grey),
                        ),
                        child:  Row(
                          children: [
                            const Icon(Icons.search,color: Colors.grey,),
                            const SizedBox(width: 5,),
                            Container(
                              padding: EdgeInsets.only(top:2),
                              width: 230,
                              height: 55,
                              child: TextField(
                                style: TextStyle(color: Colors.black45),
                                decoration: InputDecoration(
                                  hintText: appString.searchString,
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                ),
                                onChanged: (val){
                                  addEvent(FilterFitnessDataEvent(searchText: val , context: context));
                                },

                              ),
                            )
                          ],
                        ),
                      ),
                      createStyledIconItem(appColors.black, appImages.filterImage,55,55,100),
                    ],
                  ),
                  const SizedBox(height:25),
                  //FEATURED CATEGORIES
                  Align(alignment:Alignment.topLeft,child: Text(appString.categoryString, style: const TextStyle(fontSize: 20),)),
                  const SizedBox(height:10),
                  Container(
                    height: 110,
                   // color: Colors.amber,
                    child: featuredCategory.isEmpty ?
                        const Center(child: Text("No matched categories",style: TextStyle(color: Colors.grey),),)
                        : ListView.builder(
                        itemCount: featuredCategory.length,
                        scrollDirection: Axis.horizontal,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, i){
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  createStyledIconItem(appColors.grey, featuredCategory[i].categoryImage ?? "", 60, 55, 100),
                                  const SizedBox(height:10),
                                  categoryName(featuredCategory[i].categoryName ?? ""),
                                ],
                              ),
                              SizedBox(width: 30,)
                            ],
                          );
                        }),
                  ),
                 // const SizedBox(height:25),
                  //ALL ACTIVITIES UNDER TODAY PLAN
                  Align(alignment:Alignment.topLeft,child: Text(appString.todayPlan, style: const TextStyle(fontSize: 20),)),
                  const SizedBox(height:15),
                  //SHOWING ALL ACTIVITIES
                  if(todayFitnessData.isNotEmpty)
                  Expanded(child:
                  ListView.builder(
                    itemCount: todayFitnessData.length,
                    itemBuilder: (context, i){
                      //FOR CALCULATING THE VALUE OF PROGRESS BAR ACCORDING TO MINUTES
                      progressBarValue = int.parse(todayFitnessData[i].time ?? "0")/60;

                      return GestureDetector(
                        onTap: (){
                          //NAVIGATION TO CHALLENGES DETAILS SCREEN
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ChallengesDetailsScreen(oneFitnessData: todayFitnessData[i],)));
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          height:100,
                          child: Row(
                            children: [
                              ClipRRect(borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(todayFitnessData[i].image ?? "",fit: BoxFit.cover,height: 100,width: 120,)),
                              const SizedBox(width: 15,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  SizedBox(width:200,child: Text(todayFitnessData[i].exerciseName ?? "", style: TextStyle(fontSize: 16),)),
                                  const SizedBox(height: 5),
                                  SizedBox(width:200,child: Text("${todayFitnessData[i].time ?? ""} minutes", style: TextStyle(color: Colors.grey),)),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    width:200,
                                    child: LinearProgressIndicator(
                                      value: progressBarValue ?? 0.0,
                                      minHeight: 4,
                                      // Set the minimum height of the progress bar
                                      backgroundColor: Color(appColors.grey),
                                      color:Color(appColors.grey),// Set background color
                                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.red), // Set progress color
                                    ),
                                  ),
                                ],)
                            ],
                          ),
                        ),
                      );
                    },
                  ))
                  else
                     SizedBox(
                      height: h * 0.25,
                      child: const Center(child: Text("No matched activities",style: TextStyle(color: Colors.grey),)),
                    )
                  ,
                  const SizedBox(height:25),
                  //TAB BAR
                  Container(
                    height:60,
                    padding: EdgeInsets.only(left:40,right:40),
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        tabBarIcon(Icons.home_outlined),
                        tabBarIcon(Icons.calendar_month),
                        tabBarIcon(Icons.change_circle_outlined),
                        tabBarIcon(Icons.settings),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }

    );
  }

  //COMMON WIDGET FOR SHOWING ICONS
  Widget createStyledIconItem(int color, String image,double height, double width, double borderRadius ){
    return Container(
      height: height,
      width: width,
      padding: image == appImages.filterImage ? const EdgeInsets.all(20):const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(color),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: image == appImages.filterImage ?Image.asset(image,height: 30,width: 30,color: Colors.white,):Image.asset(image,height: 50,width: 50,),
    );
  }

  //COMMON WIDGET TO RETURN FEATURED CATEGORY NAME
  Widget categoryName(String text){
    return Container(width: 60, alignment: Alignment.center ,child: Text(text, style: const TextStyle(color: Colors.grey,),));
  }

  //COMMON WIDGET TAB BAR ICONS
  Widget tabBarIcon(IconData icon){
    return IconButton(icon:Icon(icon),color: Color(appColors.grey),onPressed: (){},);
  }


}


