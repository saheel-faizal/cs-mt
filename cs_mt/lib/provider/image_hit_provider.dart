import 'package:cs_mt/model/image_hits_model.dart';
import 'package:cs_mt/services/web_services.dart';
import 'package:flutter/material.dart';

class ImageHitProvider extends ChangeNotifier{
  late ImageHitsModel imageHitsModel = ImageHitsModel(total: 0, totalHits: 0, hits: []);
  late WebService webService=WebService();
  List<Hit> mainHit=[];
  bool isLoading = true;

  Future getImages(String keyword,int page,String imageType) async{
    print("..."+imageType.toString());

    imageHitsModel = await webService.getImagesHits(keyword,page,imageType);
    debugPrint(imageHitsModel.totalHits.toString());
    isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));
    mainHit.addAll(imageHitsModel.hits);
    isLoading = false;
    notifyListeners();
  }

   clearList() {
     mainHit.clear();
     notifyListeners();
   }



}