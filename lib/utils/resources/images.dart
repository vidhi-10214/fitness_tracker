//COMMON CLASS FOR ACCESSING IMAGES
class AppImages{
  AppImages._internal();

  factory AppImages(){
    return _appImages;
  }

  get menuIcon => 'assets/images/menu.png';
  get girlIcon => 'assets/images/girl.png';
  get girlIcon1 => 'assets/images/girl(1).png';
  get helloImage => 'assets/images/hello.png';
  get filterImage => 'assets/images/filter.png';
  get helloImage1 => 'assets/images/waving-hand.png';
  get runImage => 'assets/images/run.jpeg';
  get stretchImage => 'assets/images/stretch.jpg';
  get yogaImage => 'assets/images/yoga.jpeg';
  get lotusYogaImage => 'assets/images/lotus.png';
  get runningImage => 'assets/images/running.png';
  get gymImage => 'assets/images/gym.png';
  get heartImage => 'assets/images/heart.png';
  get fireImage => 'assets/images/fire.png';
  get alarmImage => 'assets/images/alarm.png';
  get popUp => 'assets/images/chat.png';

  static final AppImages _appImages = AppImages._internal();

}
// CREATE A GLOBAL INSTANCE OF APP IMAGES FOR EASY ACCESS THROUGHOUT THE APPLICATION.
AppImages appImages = AppImages();