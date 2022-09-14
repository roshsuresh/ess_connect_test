import 'package:Ess_Conn/Constants.dart';
import 'package:Ess_Conn/Presentation/Admin/StudProfileView.dart';
import 'package:Ess_Conn/utils/constants.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class StudentReport extends StatefulWidget {
  const StudentReport({Key? key}) : super(key: key);

  @override
  State<StudentReport> createState() => _StudentReportState();
}

class _StudentReportState extends State<StudentReport> {
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Student Report'),
              titleSpacing: 00.0,
              centerTitle: true,
              toolbarHeight: 60.2,
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
                    text: "Studying",
                  ),
                  Tab(text: "Relieved"),
                  Tab(text: 'Both')
                ],
              ),
              backgroundColor: UIGuide.light_Purple,
            ),
            body: TabBarView(children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const StudProfileView()),
                  );
                },
                child: CurrentStudying(),
              ),
              CurrentStudying(),
              CurrentStudying(),
            ])));
  }
}

class CurrentStudying extends StatelessWidget {
  const CurrentStudying({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 2,
      itemBuilder: (context, index) {
        return Column(
          children: [
            kheight10,
            Container(
              width: size.width - 10,
              height: 110,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 236, 233, 233),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kWidth,
                  Center(
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 236, 233, 233),
                          image: DecorationImage(
                              image: AssetImage('assets/studentLogo.png')),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Name : ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 13),
                            ),
                            RichText(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              strutStyle: const StrutStyle(fontSize: 8.0),
                              text: TextSpan(
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                  text: "AADAM ISWAR AADHITHYA UNNI"),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Roll No : ',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 13),
                            ),
                            RichText(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              strutStyle: const StrutStyle(fontSize: 8.0),
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                                text: "214",
                              ),
                            ),
                            kWidth,
                            kWidth,
                            Row(
                              children: [
                                Text(
                                  'Division : ',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13),
                                ),
                                RichText(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  strutStyle: const StrutStyle(fontSize: 8.0),
                                  text: TextSpan(
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                    text: "VII",
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Adm No : ',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 13),
                            ),
                            RichText(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              strutStyle: const StrutStyle(fontSize: 8.0),
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                                text: "2154",
                              ),
                            ),
                          ],
                        ),
                        Row(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          //crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // Text(
                            //   'Phone : ',
                            //   textAlign: TextAlign.start,
                            //   style: TextStyle(
                            //       fontWeight: FontWeight.w500, fontSize: 13),
                            // ),
                            // RichText(
                            //   overflow: TextOverflow.ellipsis,
                            //   maxLines: 1,
                            //   strutStyle: const StrutStyle(fontSize: 8.0),
                            //   text: TextSpan(
                            //     style: const TextStyle(
                            //       fontSize: 12,
                            //       color: Colors.black,
                            //     ),
                            //     text: "9547812154",
                            //   ),
                            // ),

                            IconButton(
                                iconSize: 12,
                                onPressed: () {},
                                icon: Icon(Icons.phone))
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
