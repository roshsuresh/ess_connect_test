import 'package:Ess_test/Application/AdminProviders/GalleryProviders.dart';
import 'package:Ess_test/Application/Staff_Providers/GallerySendProviderStaff.dart';
import 'package:Ess_test/Application/StudentProviders/GalleryProvider.dart';
import 'package:Ess_test/Constants.dart';
import 'package:Ess_test/utils/LoadingIndication.dart';
import 'package:Ess_test/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';

class StaffGalleryView extends StatelessWidget {
  const StaffGalleryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var p = Provider.of<GallerySendProvider_Stf>(context, listen: false);
      p.galleryReceived.clear();
      p.getGalleyReceived();
    });
    return Consumer<GallerySendProvider_Stf>(
      builder: (context, value, child) => value.loading
          ? spinkitLoader()
          : ListView(
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: value.galleryReceived.length == null
                        ? 0
                        : value.galleryReceived.length,
                    itemBuilder: ((context, index) {
                      var idd = value.galleryReceived[index].galleryId ?? '--';
                      return Consumer<GallerySendProvider_Stf>(
                        builder: (context, value, child) {
                          return Column(
                            children: [
                              kheight20,
                              GestureDetector(
                                child: Container(
                                  height: 120,
                                  width: size.width - 30,
                                  decoration: const BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(2, 6),
                                        blurRadius: 20,
                                        color: Color.fromRGBO(0, 0, 0, 0.16),
                                      )
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(0),
                                        bottomRight: Radius.circular(40.0),
                                        topLeft: Radius.circular(40.0),
                                        bottomLeft: Radius.circular(0.0)),
                                  ),
                                  child: Row(
                                    children: [
                                      kWidth,
                                      Center(
                                          child: Container(
                                        width: 120,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                value.galleryReceived[index]
                                                        .url ??
                                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQgOinP1I4DJR8UXKbif9pXj4UTa1dar-CfGBr4mmSXNfOySMXxPfwa023_n0gvkdK4mig&usqp=CAU',
                                              ),
                                              fit: BoxFit.fill),
                                          color: Colors.white12,
                                          border: Border.all(
                                              color: const Color.fromARGB(
                                                  255, 219, 215, 215)),
                                          borderRadius: const BorderRadius.only(
                                              topRight: Radius.circular(0),
                                              bottomRight:
                                                  Radius.circular(40.0),
                                              topLeft: Radius.circular(40.0),
                                              bottomLeft: Radius.circular(0.0)),
                                        ),
                                      )),
                                      kWidth,
                                      Expanded(
                                        child: Container(
                                            // color: Colors.black26,
                                            height: 110,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  value.galleryReceived[index]
                                                          .title ??
                                                      '---',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12),
                                                  maxLines: 2,
                                                ),
                                                kheight10,
                                                Text(
                                                  value.galleryReceived[index]
                                                          .caption ??
                                                      '---',
                                                  maxLines: 3,
                                                  style: TextStyle(),
                                                ),
                                                kheight10,
                                              ],
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                                onTap: () async {
                                  await Provider.of<GallerySendProvider_Stf>(
                                          context,
                                          listen: false)
                                      .galleyAttachment(idd);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            GalleryonTapStaff(id: idd)),
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      );
                    })),
              ],
            ),
    );
  }
}

class GalleryonTapStaff extends StatelessWidget {
  GalleryonTapStaff({Key? key, required String id}) : super(key: key);
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<GallerySendProvider_Stf>(
          builder: (context, value, child) => value.load
              ? spinkitLoader()
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 4,
                    children: List.generate(
                        value.galleryAttachResponse == null
                            ? 0
                            : value.galleryAttachResponse!.length, (index) {
                      return GestureDetector(
                        child: isLoading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : Container(
                                height: 100,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            value.galleryAttachResponse![index]
                                                    ['url'] ??
                                                const AssetImage(
                                                    'assets/noimages.png')))),
                              ),
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewImageOntapStaff(
                                      inde: index,
                                    )),
                          );
                        },
                      );
                    }),
                  ),
                ),
        ),
      ),
    );
  }
}

class ViewImageOntapStaff extends StatelessWidget {
  ViewImageOntapStaff({Key? key, required int inde}) : super(key: key);
  bool isLoading = false;
  int? indee;
  @override
  Widget build(BuildContext context) {
    return Consumer<GallerySendProvider_Stf>(
      builder: (context, value, child) => PhotoViewGallery.builder(
          scrollPhysics: const BouncingScrollPhysics(),
          enableRotation: false,
          itemCount: value.galleryAttachResponse == null
              ? 0
              : value.galleryAttachResponse!.length,
          builder: ((context, inde) {
            final imgUrl = value.galleryAttachResponse![inde]['url'];
            return PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(
                    imgUrl ?? const AssetImage('assets/noimages.png')),
                initialScale: PhotoViewComputedScale.contained * 0.8,
                heroAttributes: PhotoViewHeroAttributes(
                    tag: value.galleryAttachResponse![inde]['url']));
          }),
          loadingBuilder: (context, event) => const LoadingIcon()),
    );
  }
}
