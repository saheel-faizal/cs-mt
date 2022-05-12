import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:flutter/material.dart';

class ImageViewFullScreen extends StatelessWidget {
  String image;

  ImageViewFullScreen({Key? key,required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();
    return Container(
        child: PhotoViewGallery.builder(
          scrollPhysics: const BouncingScrollPhysics(),
          builder: (BuildContext context, int index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: NetworkImage(image),
              maxScale: PhotoViewComputedScale.contained * 1.3,
              minScale: PhotoViewComputedScale.contained * 0.45,
              initialScale: PhotoViewComputedScale.contained * 1,
              heroAttributes: PhotoViewHeroAttributes(tag: image),
            );
          },
          itemCount: 1,
          loadingBuilder: (context, event) => const Center(
            child: SizedBox(
              width: 20.0,
              height: 20.0,
              child: CircularProgressIndicator(color: Colors.grey,),
            ),
          ),
          pageController: pageController,
        )
    );
  }
}
