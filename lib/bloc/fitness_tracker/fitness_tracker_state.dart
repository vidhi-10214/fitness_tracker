import 'package:fitness_tracker_app/data/featured_category.dart';

import '../../data/all_fitness_data.dart';

// REPRESENTS THE STATE OF THE FITNESS TRACKER APPLICATION.
// THIS CLASS HOLDS THE LIST OF FITNESS DATA THAT CAN BE DISPLAYED IN THE UI.
class AllFitnessTrackerState{
  final List<AllFitnessData>? allFitnessDataList;
  final List<FeaturedCategory>? allFeaturedCategoryDataList;
  AllFitnessTrackerState({this.allFitnessDataList,this.allFeaturedCategoryDataList});
  AllFitnessTrackerState copyWith({final List<AllFitnessData>? allFitnessDataList,final List<FeaturedCategory>? allFeaturedCategoryDataList}){

    // COPY CONSTRUCTOR THAT ALLOWS CREATING A NEW INSTANCE OF ALLFITNESSTRACKERSTATE
    // WITH UPDATED VALUES WHILE MAINTAINING THE IMMUTABILITY OF THE CLASS.
    return AllFitnessTrackerState(
        allFitnessDataList: allFitnessDataList ?? this.allFitnessDataList,
        allFeaturedCategoryDataList: allFeaturedCategoryDataList ?? this.allFeaturedCategoryDataList,
    );
}
}