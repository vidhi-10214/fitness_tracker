import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

// DEFINE AN ABSTRACT CLASS FOR ALL EVENTS RELATED TO THE FITNESS TRACKER
abstract class AllFitnessTrackerEvent extends Equatable{
  const AllFitnessTrackerEvent();
}

// EVENT TO REQUEST FITNESS LIST DATA
class GetFitnessListDataEvent extends AllFitnessTrackerEvent{
  final BuildContext? context;
   const GetFitnessListDataEvent({this.context});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

// EVENT TO TRIGGER THE UPDATE OF FITNESS DATA
class UpdateFitnessDataEvent extends AllFitnessTrackerEvent{
  final BuildContext? context;
  final int? id;
  final String? time;
  final double? calorie;
  final double? distance;

  const UpdateFitnessDataEvent({this.context,this.id,this.time,this.calorie,this.distance});
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

//EVENT TO UPDATE LIST ACCORDING TO THE SEARCH TEXT
class FilterFitnessDataEvent extends AllFitnessTrackerEvent {
  final String searchText;
  final BuildContext? context;

  const FilterFitnessDataEvent({this.context,required this.searchText});

  @override
  List<Object?> get props => [searchText];
}