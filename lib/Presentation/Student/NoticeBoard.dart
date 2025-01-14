import 'package:Ess_test/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pdfdownload/pdfdownload.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../Application/StudentProviders/NoticProvider.dart';
import '../../Constants.dart';
import '../../utils/LoadingIndication.dart';
import '../../utils/TextWrap(moreOption).dart';
import '../../utils/constants.dart';

class NoticeBoard extends StatelessWidget {
  const NoticeBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<NoticeProvider>(context, listen: false).getnoticeList();
    });

    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    const Color background = Colors.white;
    final Color fill1 = Color.fromARGB(255, 79, 97, 197);
    final Color fill2 = Color.fromARGB(255, 180, 103, 216);
    final List<Color> gradient = [
      fill1,
      fill2,
      background,
      background,
    ];
    const double fillPercent = 35;
    const double fillStop = (100 - fillPercent) / 100;
    final List<double> stops = [0.0, fillStop, fillStop, 1.0];
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notice Board',
        ),
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        backgroundColor: UIGuide.light_Purple,
      ),
      body: Consumer<NoticeProvider>(builder: (_, value, child) {
        return value.loading
            ? spinkitLoader()
            : AnimationLimiter(
                child: ListView.builder(
                  //  padding: EdgeInsets.all(width / 30),
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemCount:
                      noticeresponse == null ? 0 : noticeresponse!.length,
                  itemBuilder: (BuildContext context, int index) {
                    var noticeattach = noticeresponse![index]['noticeId'];
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      delay: Duration(milliseconds: 100),
                      child: SlideAnimation(
                        duration: Duration(milliseconds: 2500),
                        curve: Curves.fastLinearToSlowEaseIn,
                        child: FadeInAnimation(
                          curve: Curves.fastLinearToSlowEaseIn,
                          duration: Duration(milliseconds: 2500),
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: width,
                                  //   height: 200,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 243, 243, 252),
                                      border: Border.all(
                                          color: UIGuide.light_Purple,
                                          width: .5),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Row(
                                          children: [
                                            kWidth,
                                            Text('📌  '),
                                            Flexible(
                                              child: RichText(
                                                overflow: TextOverflow.ellipsis,
                                                strutStyle:
                                                    StrutStyle(fontSize: 14.0),
                                                text: TextSpan(
                                                    style: const TextStyle(
                                                        color: UIGuide
                                                            .light_Purple,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    text: noticeresponse![index]
                                                                ['title'] ==
                                                            null
                                                        ? '---'
                                                        : noticeresponse![index]
                                                                ['title']
                                                            .toString()),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Container(
                                          width: width - 15,
                                          decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 236, 237, 245),
                                              border: Border.all(
                                                  color: const Color.fromARGB(
                                                      255, 215, 207, 236)),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4))),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TextWrapper(
                                                  text: noticeresponse![index]
                                                              ['matter'] ==
                                                          null
                                                      ? '------'
                                                      : noticeresponse![index]
                                                              ['matter']
                                                          .toString())
                                            ],
                                          ),
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          kWidth,
                                          Text(
                                            noticeresponse![index]
                                                        ['entryDate'] ==
                                                    null
                                                ? '--'
                                                : noticeresponse![index]
                                                        ['entryDate']
                                                    .toString(),
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          Spacer(),
                                          kWidth,
                                          kWidth,
                                          kWidth,
                                          kWidth,
                                          Text(
                                            noticeresponse![index]
                                                        ['staffName'] ==
                                                    null
                                                ? '--'
                                                : noticeresponse![index]
                                                        ['staffName']
                                                    .toString(),
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          Spacer(),
                                          GestureDetector(
                                              onTap: () async {
                                                var newProvider = await Provider
                                                        .of<NoticeProvider>(
                                                            context,
                                                            listen: false)
                                                    .noticeAttachement(
                                                        noticeattach);
                                                if (value.extension
                                                        .toString() ==
                                                    '.pdf') {
                                                  final result =
                                                      value.url.toString();
                                                  final name =
                                                      value.name.toString();

                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            PDFDownload()),
                                                  );
                                                } else {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            PdfViewPage()),
                                                  );
                                                }
                                              },
                                              child: const Icon(
                                                  Icons.remove_red_eye)),
                                          kWidth,
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
      }),
    );
  }
}

class PDFDownload extends StatelessWidget {
  PDFDownload({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NoticeProvider>(
      builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            title: Text(''),
            titleSpacing: 00.0,
            centerTitle: true,
            toolbarHeight: 50.2,
            toolbarOpacity: 0.8,
            backgroundColor: UIGuide.light_Purple,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: DownloandPdf(
                  isUseIcon: true,
                  pdfUrl: value.url.toString().isEmpty
                      ? '--'
                      : value.url.toString(),
                  fileNames: value.name.toString().isEmpty
                      ? '---'
                      : value.name.toString(),
                  color: Colors.white,
                ),
              ),
            ],
          ),
          body: SfPdfViewer.network(
            value.url.toString().isEmpty ? '--' : value.url.toString(),
          )),
    );
  }
}

class PdfViewPage extends StatelessWidget {
  PdfViewPage({Key? key}) : super(key: key);

  bool isLoading = false;

  imageview(String result) {
    return Scaffold(
      body: isLoading
          ? LoadingIcon()
          : Center(
              child: Container(
                  child: PhotoView(
                loadingBuilder: (context, event) {
                  return LoadingIcon();
                },
                imageProvider: NetworkImage(
                  result == null
                      ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSlmeGlXoJwwpbCE9jGgHgZ2XaE5nnPUSomkZz_vZT7&s'
                      : result,
                ),
              )),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoticeProvider>(builder: (context, provider, _) {
      if (provider.extension.toString() == '.jpg') {
        final imgResult = provider.url.toString();
        return imageview(imgResult);
      } else if (provider.extension.toString() == '.png') {
        final imgResult2 = provider.url.toString();
        return imageview(imgResult2);
      } else if (provider.extension.toString() == '.jpeg') {
        final imgResult3 = provider.url.toString();
        return imageview(imgResult3);
      } else {
        return const Scaffold(
          body: Center(
            child: Text(
              'No Attachment ',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
        );
      }
    });
  }
}
