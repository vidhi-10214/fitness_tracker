import 'package:fitness_tracker_app/bloc/fitness_tracker/fitness_tracker_event.dart';
import 'package:fitness_tracker_app/bloc/fitness_tracker/fitness_tracker_state.dart';
import 'package:fitness_tracker_app/data/all_fitness_data_list.dart';
import 'package:fitness_tracker_app/data/featured_category.dart';
import 'package:fitness_tracker_app/data/featured_category_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/all_fitness_data.dart';

// DEFINE A BLOC CLASS FOR THE FITNESS TRACKER

class FitnessTrackerBloc extends Bloc<AllFitnessTrackerEvent,AllFitnessTrackerState> {

  FitnessTrackerBloc() : super(AllFitnessTrackerState()) {
    on<GetFitnessListDataEvent>((
        event,
        emit,
        ) async {
      await _getFitnessListDataEvent(event, emit);
     });on<UpdateFitnessDataEvent>((
        event,
        emit,
        ) async {
      await _updateFitnessDataEvent(event, emit);
    });;on<FilterFitnessDataEvent>((
        event,
        emit,
        ) async {
      await _filterFitnessDataEventt(event, emit);
    });
  }
  // PRIVATE METHOD TO HANDLE THE 'GETFITNESSLISTDATAEVENT'

  _getFitnessListDataEvent(GetFitnessListDataEvent event, Emitter<AllFitnessTrackerState> emit) {
    try{
      emit(state.copyWith(allFitnessDataList: AllFitnessDataList.allFitnessData));
      emit(state.copyWith(allFeaturedCategoryDataList: FeaturedCategoryList.featuredCategoryList));
    }catch(e){
      if (kDebugMode) {
        print("Something went wrong $e");
      }
    }
  }
  // PRIVATE METHOD TO HANDLE THE 'UPDATEFITNESSDATAEVENT'

  _updateFitnessDataEvent(UpdateFitnessDataEvent event, Emitter<AllFitnessTrackerState> emit) {
    try{
      for(int i = 0 ;i<AllFitnessDataList.allFitnessData.length ; i++){
        if(AllFitnessDataList.allFitnessData[i].id == event.id){
          AllFitnessDataList.allFitnessData[i].time = event.time;
          AllFitnessDataList.allFitnessData[i].calories = event.calorie;
          AllFitnessDataList.allFitnessData[i].distance = event.distance;
        }
      }
      emit(state.copyWith(allFitnessDataList: AllFitnessDataList.allFitnessData));
    }catch(e){
      if (kDebugMode) {
        print("Something went wrong $e");
      }
    }
  }
  // PRIVATE METHOD TO HANDLE THE 'FILTERFITNESSDATAEVENT'
  _filterFitnessDataEventt(FilterFitnessDataEvent event, Emitter<AllFitnessTrackerState> emit) {
    try {
      // Filter the today plan list based on the entered text
      List<AllFitnessData> filteredList = AllFitnessDataList.allFitnessData
          .where((fitnessData) =>
          (fitnessData.exerciseName?.toLowerCase() ?? "").contains(
              event.searchText.toLowerCase()))
          .toList();
      // Filter the category on the entered text
      List<FeaturedCategory> filteredCategoryList = FeaturedCategoryList.featuredCategoryList
          .where((featuredCategory) =>
          (featuredCategory.categoryName?.toLowerCase() ?? "").contains(
              event.searchText.toLowerCase()))
          .toList();
      emit(state.copyWith(allFitnessDataList: filteredList));
      emit(state.copyWith(allFeaturedCategoryDataList: filteredCategoryList));
    } catch (e) {
      if (kDebugMode) {
        print("Something went wrong $e");
      }
    }
  }
}