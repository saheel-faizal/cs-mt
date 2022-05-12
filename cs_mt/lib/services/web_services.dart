import '../model/image_hits_model.dart';
import 'package:dio/dio.dart';

class WebService{
  var dio = Dio();
  String apiKey = "27306516-3af0b1476cf07a347e9b9f7d6";

  Future <ImageHitsModel> getImagesHits(String keyword,int page,String imageType) async{
    String url = "https://pixabay.com/api/?key=$apiKey&page=$page&q=$keyword&image_type=$imageType";
    var response = await dio.get(url);
    // var result = response.data['hits'];

    return ImageHitsModel.fromJson(response.data);
  }

}