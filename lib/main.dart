import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/bloc_observer.dart';
import 'bloc/bloc_provider.dart';
import 'presentation/challenges_list_screen.dart';
import 'package:fitness_tracker_app/injection_container.dart' as di;
// MAIN FUNCTION TO RUN THE FLUTTER APPLICATION.
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = CustomBlocObserver();
  di.init();
  runApp(const MyApp());
}

// MYAPP CLASS, REPRESENTING THE ROOT OF THE APPLICATION.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // WRAP THE MATERIALAPP WITH A CUSTOMBLOCPROVIDER FOR BLOC MANAGEMENT.
    return  CustomBlocProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Poppins',
        ),
        home: const AllChallengesList(),
      ),
    );
  }
}

