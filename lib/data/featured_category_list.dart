import '../utils/resources/images.dart';
import '../utils/resources/string.dart';
import 'featured_category.dart';
// DEFINE A CLASS NAMED FEATUREDCATEGORYLIST RESPONSIBLE FOR HOLDING A STATIC LIST OF FEATUREDCATEGORY INSTANCES.
class FeaturedCategoryList{
  static List<FeaturedCategory> featuredCategoryList = [
    FeaturedCategory(categoryName: appString.categoryType1,categoryImage:appImages.lotusYogaImage),
    FeaturedCategory(categoryName: appString.categoryType2,categoryImage:appImages.gymImage),
    FeaturedCategory(categoryName: appString.categoryType3,categoryImage:appImages.heartImage),
    FeaturedCategory(categoryName: appString.categoryType4,categoryImage:appImages.runningImage),
  ];
}