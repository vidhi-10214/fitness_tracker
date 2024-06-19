import 'package:fitness_tracker_app/bloc/fitness_tracker/fitness_tracker_bloc.dart';
import 'package:get_it/get_it.dart';

// CREATE A SINGLETON INSTANCE OF GETIT NAMED SERVICELOCATOR FOR DEPENDENCY MANAGEMENT.
final serviceLocator = GetIt.instance;
// ASYNCHRONOUS FUNCTION FOR INITIALIZING THE SERVICELOCATOR WITH REGISTERED FACTORIES.
Future<void> init() async{
  // REGISTER THE FITNESSTRACKERBLOC FACTORY WITH THE SERVICELOCATOR.
  serviceLocator.registerFactory(() => FitnessTrackerBloc());

}