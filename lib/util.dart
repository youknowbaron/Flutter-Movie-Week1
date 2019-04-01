import 'const.dart';

class Utils {
  static String getLinkImageThumbnail(String file) {
    return '$BASE_URL_IMAGE$THUMBNAIL$file';
  }

  static String getLinkImageBigger(String file) {
    return '$BASE_URL_IMAGE$BIGGER_IMAGE$file';
  }
}