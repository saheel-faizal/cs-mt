import 'package:cached_network_image/cached_network_image.dart';
import 'package:cs_mt/constants/colors.dart';
import 'package:cs_mt/model/image_hits_model.dart';
import 'package:cs_mt/provider/image_hit_provider.dart';
import 'package:cs_mt/screens/full_screen_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Hit> mainHit=[];
  bool isLoadingVertical = false;
  int page=1;
  String keyword = "",imageType = "";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ImageHitProvider>(context,listen: false).getImages("",1,"");


  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        elevation: 0.01,
        backgroundColor: kWhite,
        centerTitle: true,
        title:  Text("Dashboard",style: TextStyle(color: Colors.blueGrey[900]),),),
      body: Consumer<ImageHitProvider>(
        builder: (context,imageModel,child) {
          List<Hit> hits = imageModel.mainHit;
          var distinctIds = [...{...hits}];
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration:  BoxDecoration(
                    color: kWhite,
                    boxShadow: [
                      BoxShadow(color: Colors.grey,offset: Offset.fromDirection(45))
                    ],


                  ),
                  child: TextFormField(
                    onChanged: (value){

                      keyword = value;
                      if(keyword.contains("illustration")){
                        imageType = "illustration";
                      }
                      else if(keyword.contains("vector")){
                        imageType = "vector";
                      }
                      else if(keyword.contains("photo")){
                        imageType = "photo";
                      }else{
                        imageType = "";
                      }
                      page = 1;
                      imageModel.clearList();
                      Future.delayed(const Duration(seconds: 2));
                      imageModel.getImages(keyword, page,imageType);
                    },
                    // onFieldSubmitted: (value){
                    //
                    //   if(keyword.contains("illustration")){
                    //     imageType = "illustration";
                    //   }
                    //   else if(keyword.contains("vector")){
                    //     imageType = "vector";
                    //   }
                    //   else if(keyword.contains("photo")){
                    //     imageType = "photo";
                    //   }else{
                    //     imageType = "";
                    //   }
                    //   keyword = value;
                    //   page = 1;
                    //   imageModel.clearList();
                    //
                    //   imageModel.getImages(keyword, page,imageType);
                    // },
                    decoration:  const InputDecoration(
                      contentPadding: EdgeInsets.all(15),
                      fillColor: kWhite,
                      focusColor: kWhite,
                      hintText: "    Enter you keyword",
                      border: InputBorder.none

                    ),
                  ),
                ),
              ),

                  LazyLoadScrollView(
                    isLoading:isLoadingVertical,
                    onEndOfPage: () async{
                      page++;
                      imageModel.getImages(keyword, page,imageType);
                    },
                    child: Expanded(
                      child: Scrollbar(
                        thickness: 10,
                        child: GridView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                          ),
                          itemCount: distinctIds.length,
                            itemBuilder: (context,index){
                            return GestureDetector(
                              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> ImageViewFullScreen(image: hits[index].largeImageUrl,))),
                              child: CachedNetworkImage(
                                  imageUrl:distinctIds[index].previewUrl,
                                fit: BoxFit.cover,
                                placeholder: (context,url){
                                    return  Center(child: CircularProgressIndicator(
                                      color: Colors.blueGrey,
                                      backgroundColor: Colors.grey[300],),);
                                },
                                errorWidget: (context,url , error){
                                    return Container();
                                },
                              ),
                            );

                        }),
                      ),
                    ),
                  )
            ],
          );
        }
      ),
    );
  }
}
