import 'package:dio/dio.dart' as dio;
import 'package:image_picker/image_picker.dart';

import '../config/api_constant.dart';

String getFormatedProfileUrl(String path) {
  return '${ApiConstant.SERVER_IP_PORT}/uploads/$path';
}


String getFormatedGroupProfileUrl(String path) {
  return '${ApiConstant.SERVER_IP_PORT}/uploads/group/$path';
}


String getFormatedStoryUrl(String path) {
  return '${ApiConstant.SERVER_IP_PORT}/uploads/story/$path';
}

String getFormatedPostUrl(String path) {
  return '${ApiConstant.SERVER_IP_PORT}/uploads/posts/$path';
}

const allImgageType = [
  'jpg',
  'jpeg',
  'jfif',
  'pjpeg',
  'pjp',
  'gif',
  'png',
  'svg',
  'bmp'
];
const allVideoType = [
  'ogg',
  'webm',
  'mp4',
  'avi',
  'mov',
  'wmv',
  'mkv',
];

bool isImageUrl(String url) {
  String extension = url.split('.').last;
  for (String imageType in allImgageType) {
    if (imageType == extension) {
      return true;
    }
  }
  return false;
}

Future<List<dio.MultipartFile>> getMultipartFilesFromXfiles(
    List<XFile> xfiles) async {
  List<dio.MultipartFile> multiPartFileList = [];

  for (XFile file in xfiles) {
    multiPartFileList.add(dio.MultipartFile.fromBytes(
      await file.readAsBytes(),
      filename: file.path.split('/').last,
    ));
  }
  return multiPartFileList;
}
