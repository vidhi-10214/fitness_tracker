import '../utils/resources/images.dart';
import 'all_fitness_data.dart';
// DEFINE A CLASS NAMED ALLFITNESSDATALIST RESPONSIBLE FOR HOLDING A STATIC LIST OF ALLFITNESSDATA INSTANCES.
class AllFitnessDataList{
  static List<AllFitnessData> allFitnessData = [
    AllFitnessData(id:1,exerciseName: "5 mph running",image:appImages.runImage,calories: 0,time: "0",distance: 0),
    AllFitnessData(id:2,exerciseName: "Yoga warm-up",image:appImages.yogaImage,calories: 0,time: "0",distance: 0),
    AllFitnessData(id:3,exerciseName: "Stretching",image:appImages.stretchImage,calories: 0,time: "0",distance: 0),
  ];
}