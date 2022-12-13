import 'package:Ess_test/Presentation/Admin/NoticeBoard/NoticeList.dart';
import 'package:Ess_test/Presentation/Admin/NoticeBoard/SendNoticeBoard.dart';
import 'package:Ess_test/utils/constants.dart';
import 'package:flutter/material.dart';

class NoticeBoardAdnin extends StatelessWidget {
  const NoticeBoardAdnin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  Spacer(),
                  const Text('Notice Board'),
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NoticeBoardAdnin()));
                      },
                      icon: Icon(Icons.refresh_outlined))
                ],
              ),
              titleSpacing: 20.0,
              centerTitle: true,
              toolbarHeight: 30.2,
              toolbarOpacity: 0.8,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25)),
              ),
              bottom: const TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Colors.white,
                indicatorWeight: 5,
                tabs: [
                  Tab(
                    text: "Send",
                  ),
                  Tab(text: "Received"),
                ],
              ),
              backgroundColor: UIGuide.light_Purple,
            ),
            body: TabBarView(children: [
              SendNoticeBoardAdmin(),
              NoticeBoardListAdmin(),
            ])));
  }
}
