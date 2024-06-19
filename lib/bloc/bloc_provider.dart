import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'fitness_tracker/fitness_tracker_bloc.dart';
import 'package:fitness_tracker_app/injection_container.dart' as di;
// DEFINE A CUSTOM BLOC PROVIDER WIDGET RESPONSIBLE FOR PROVIDING THE FITNESSTRACKERBLOC TO ITS DESCENDANTS.
class CustomBlocProvider extends StatelessWidget {
  final Widget child;
  const CustomBlocProvider({Key? key,required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // USE THE MULTIBLOCPROVIDER TO PROVIDE MULTIPLE BLOCS TO ITS DESCENDANTS.
    return MultiBlocProvider(
      // DEFINE A LIST OF BLOC PROVIDERS.
    providers: [
      // PROVIDE AN INSTANCE OF FITNESSTRACKERBLOC USING BLOCPROVIDER.
      BlocProvider<FitnessTrackerBloc>(create: (context) => di.serviceLocator())
        ],
        child: child);
  }
}
