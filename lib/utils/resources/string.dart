//COMMON CLASS FOR ACCESSING STRING
class AppString{
  AppString._internal();
  // FACTORY CONSTRUCTOR TO CREATE AN INSTANCE OF APPSTRING USING THE _APPSTRING SINGLETON.
  factory AppString(){
    return _appString;
  }

  static final AppString _appString = AppString._internal();

  get greetingString => "Hi, Ankita";
  get searchString => "Search";
  get categoryString => "Featured categories";
  get categoryType1 => "Yoga";
  get categoryType2 => "Gym";
  get categoryType3 => "Fitness";
  get categoryType4 => "Run";
  get todayPlan => "Today plan";

}
// CREATE A GLOBAL INSTANCE OF APP STRING FOR EASY ACCESS THROUGHOUT THE APPLICATION.
AppString appString = AppString();