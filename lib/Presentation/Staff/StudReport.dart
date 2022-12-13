import 'package:Ess_test/Presentation/Staff/Searchstudent.dart';
import 'package:Ess_test/utils/spinkit.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Application/Staff_Providers/StudListProvider.dart';
import '../../Constants.dart';
import '../../utils/constants.dart';

class StudReport extends StatelessWidget {
  const StudReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Student Report'),
              titleSpacing: 20.0,
              centerTitle: true,
              toolbarHeight: 40.2,
              // toolbarOpacity: 0.8,
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
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchStudent_stf()),
                      );
                    },
                    icon: Icon(Icons.search))
              ],
            ),
            body: const TabBarView(children: [
              StudCurrentStudying(),
              StudRelievedStaff(),
              StudentReportBoth_Staff(),
            ])));
  }
}

class StudCurrentStudying extends StatefulWidget {
  const StudCurrentStudying({Key? key}) : super(key: key);

  @override
  State<StudCurrentStudying> createState() => _StudCurrentStudyingState();
}

class _StudCurrentStudyingState extends State<StudCurrentStudying> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var p = Provider.of<StudReportListProvider_stf>(context, listen: false);
      p.stdReportSectionStaff();
      p.clearAllFilters();
      p.removeSectionAll();
      p.courseClear();
      p.divisionClear();
      p.sectionClear();
      p.removeSectionAll();
      p.removeDivisionAll();
      p.removeCourseAll();
      p.clearViewList();
    });
  }

  String? phn;
  String sectionId = '';
  String courseId = '';
  String divisionId = '';
  final studReportInitialValuesController = TextEditingController();
  final studReportInitialValuesController1 = TextEditingController();
  final studReportcourseController = TextEditingController();
  final studReportcourseController1 = TextEditingController();
  final studReportDivisionController = TextEditingController();
  final studReportDivisionController1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<StudReportListProvider_stf>(
      builder: (context, value, child) => ListView(
        children: [
          kheight10,
          Row(
            children: [
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.49,
                child: Consumer<StudReportListProvider_stf>(
                    builder: (context, snapshot, child) {
                  return InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                                child: LimitedBox(
                              maxHeight: size.height - 300,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: studReportinitvalues_stf!.length,
                                  itemBuilder: (context, index) {
                                    // print(snapshot

                                    //     .attendenceInitialValues.length);

                                    value.removeSectionAll();
                                    return ListTile(
                                      selectedTileColor: Colors.blue.shade100,
                                      selectedColor: UIGuide.PRIMARY2,
                                      // selected:
                                      //     studReportinitvalues_stf![index],
                                      onTap: () async {
                                        print(
                                            'guh.....${studReportinitvalues_stf![index]}');
                                        studReportInitialValuesController.text =
                                            await studReportinitvalues_stf![
                                                    index]['value'] ??
                                                '--';
                                        studReportInitialValuesController1
                                                .text =
                                            await studReportinitvalues_stf![
                                                    index]['text'] ??
                                                '--';
                                        sectionId =
                                            studReportInitialValuesController
                                                .text
                                                .toString();

                                        // snapshot.addSelectedCourse(
                                        //     attendecourse![index]);
                                        print(sectionId);
                                        await Provider.of<
                                                    StudReportListProvider_stf>(
                                                context,
                                                listen: false)
                                            .courseClear();
                                        await Provider.of<
                                                    StudReportListProvider_stf>(
                                                context,
                                                listen: false)
                                            .getCourseList(sectionId);
                                        Navigator.of(context).pop();
                                      },
                                      title: Text(
                                        studReportinitvalues_stf![index]
                                                ['text'] ??
                                            '--',
                                        textAlign: TextAlign.center,
                                      ),
                                    );
                                  }),
                            ));
                          });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: UIGuide.light_Purple, width: 1),
                            ),
                            height: 40,
                            child: TextField(
                              textAlign: TextAlign.center,
                              controller: studReportInitialValuesController1,
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(left: 1, top: 0),
                                filled: true,
                                fillColor: UIGuide.light_black,
                                border: OutlineInputBorder(),
                                labelText: "  Select Section",
                                hintText: "Section",
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                              ),
                              enabled: false,
                            ),
                          ),
                          SizedBox(
                            height: 0,
                            child: TextField(
                              textAlign: TextAlign.center,
                              controller: studReportInitialValuesController,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: UIGuide.light_black,
                                border: OutlineInputBorder(),
                                labelText: "",
                                hintText: "",
                              ),
                              enabled: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
              Spacer(),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.49,
                child: Consumer<StudReportListProvider_stf>(
                    builder: (context, snapshot, child) {
                  return InkWell(
                    onTap: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                                child: Container(
                              child: LimitedBox(
                                maxHeight: size.height - 300,
                                // mainAxisSize: MainAxisSize.min,

                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.courselist.length,
                                    itemBuilder: (context, index) {
                                      print(snapshot.courselist.length);
                                      // value.removeDivisionAll();
                                      return ListTile(
                                        // selectedTileColor: Colors.blue.shade100,
                                        // selectedColor: UIGuide.PRIMARY2,
                                        selected: snapshot.isCourseSelected(
                                            snapshot.courselist[index]),
                                        onTap: () async {
                                          print(snapshot.courselist.length);
                                          studReportcourseController.text =
                                              snapshot.courselist[index]
                                                      .value ??
                                                  '---';
                                          studReportcourseController1.text =
                                              snapshot.courselist[index].text ==
                                                      null
                                                  ? '---'
                                                  : snapshot
                                                      .courselist[index].text;
                                          snapshot.addSelectedCourse(
                                              snapshot.courselist[index]);
                                          courseId = studReportcourseController
                                              .text
                                              .toString();
                                          print(
                                              studReportcourseController.text);
                                          sectionId =
                                              studReportInitialValuesController
                                                  .text
                                                  .toString();
                                          await Provider.of<
                                                      StudReportListProvider_stf>(
                                                  context,
                                                  listen: false)
                                              .divisionClear();

                                          await Provider.of<
                                                      StudReportListProvider_stf>(
                                                  context,
                                                  listen: false)
                                              .getDivisionList(sectionId);

                                          Navigator.of(context).pop();
                                        },
                                        title: Text(
                                          snapshot.courselist[index].text ==
                                                  null
                                              ? '---'
                                              : snapshot.courselist[index].text,
                                          textAlign: TextAlign.center,
                                        ),
                                      );
                                    }),
                              ),
                            ));
                          });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: UIGuide.light_Purple, width: 1),
                            ),
                            height: 40,
                            child: TextField(
                              textAlign: TextAlign.center,
                              controller: studReportcourseController1,
                              decoration: const InputDecoration(
                                filled: true,
                                contentPadding:
                                    EdgeInsets.only(left: 1, top: 0),
                                fillColor: UIGuide.light_black,
                                border: OutlineInputBorder(),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                labelText: "  Select Course",
                                hintText: "Course",
                              ),
                              enabled: false,
                            ),
                          ),
                          SizedBox(
                            height: 0,
                            child: TextField(
                              controller: studReportcourseController,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: UIGuide.light_black,
                                border: OutlineInputBorder(),
                                labelText: "",
                                hintText: "",
                              ),
                              enabled: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.49,
                child: Consumer<StudReportListProvider_stf>(
                    builder: (context, snapshot, child) {
                  return InkWell(
                    onTap: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                                child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: LimitedBox(
                                maxHeight: size.height - 300,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.divisionlist.length,
                                    itemBuilder: (context, index) {
                                      print(snapshot.divisionlist.length);
                                      // value.removeDivisionAll();
                                      return Column(
                                        children: [
                                          ListTile(
                                            // selectedTileColor:
                                            //     Colors.blue.shade100,
                                            // selectedColor: UIGuide.PRIMARY2,
                                            selected: snapshot
                                                .isDivisionSelected(snapshot
                                                    .divisionlist[index]),
                                            onTap: () async {
                                              print(
                                                  snapshot.divisionlist.length);
                                              studReportDivisionController
                                                  .text = snapshot
                                                      .divisionlist[index]
                                                      .value ??
                                                  '---';
                                              studReportDivisionController1
                                                  .text = snapshot
                                                      .divisionlist[index]
                                                      .text ??
                                                  '---';
                                              snapshot.addSelectedDivision(
                                                  snapshot.divisionlist[index]);

                                              print(studReportDivisionController
                                                  .text);
                                              divisionId =
                                                  studReportDivisionController
                                                      .text
                                                      .toString();
                                              Navigator.of(context).pop();
                                            },
                                            title: Text(
                                              snapshot.divisionlist[index]
                                                      .text ??
                                                  '---',
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                              ),
                            ));
                          });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: UIGuide.light_Purple, width: 1),
                            ),
                            height: 40,
                            child: TextField(
                              textAlign: TextAlign.center,
                              controller: studReportDivisionController1,
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(left: 1, top: 0),
                                filled: true,
                                fillColor: UIGuide.light_black,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                border: OutlineInputBorder(),
                                labelText: "  Select Division",
                                hintText: "Division",
                              ),
                              enabled: false,
                            ),
                          ),
                          SizedBox(
                            height: 0,
                            child: TextField(
                              controller: studReportDivisionController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: UIGuide.light_black,
                                border: OutlineInputBorder(),
                                labelText: "",
                                hintText: "",
                              ),
                              enabled: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
              const Spacer(),
              MaterialButton(
                child: const Text('View'),
                color: UIGuide.THEME_LIGHT,
                onPressed: (() async {
                  if (studReportDivisionController.text.isEmpty &&
                      studReportInitialValuesController.text.isEmpty &&
                      studReportDivisionController.text.isEmpty) {
                    return AwesomeDialog(
                            context: context,
                            dialogType: DialogType.warning,
                            animType: AnimType.rightSlide,
                            headerAnimationLoop: false,
                            title: 'Warning',
                            desc: 'Select mandatory fields',
                            btnOkOnPress: () {
                              return;
                            },
                            btnOkIcon: Icons.cancel,
                            btnOkColor: Colors.red)
                        .show();
                  }
                  courseId = studReportcourseController.text.toString();
                  print(courseId);
                  divisionId = studReportDivisionController.text.toString();
                  print(divisionId);
                  print(sectionId);
                  sectionId = studReportInitialValuesController.text.toString();
                  await Provider.of<StudReportListProvider_stf>(context,
                          listen: false)
                      .sectionClear();
                  await Provider.of<StudReportListProvider_stf>(context,
                          listen: false)
                      .removeSectionAll();
                  await Provider.of<StudReportListProvider_stf>(context,
                          listen: false)
                      .courseClear();
                  await Provider.of<StudReportListProvider_stf>(context,
                          listen: false)
                      .removeCourseAll();
                  await Provider.of<StudReportListProvider_stf>(context,
                          listen: false)
                      .divisionClear();
                  await Provider.of<StudReportListProvider_stf>(context,
                          listen: false)
                      .removeDivisionAll();
                  await Provider.of<StudReportListProvider_stf>(context,
                          listen: false)
                      .clearViewList();
                  await Provider.of<StudReportListProvider_stf>(context,
                          listen: false)
                      .viewStudentReportList(sectionId, courseId, divisionId);
                }),
              ),
              Spacer()
              // kWidth,
            ],
          ),
          ViewStaffReport(size: size),
          LimitedBox(
            maxHeight: size.height - 230,
            child: Consumer<StudReportListProvider_stf>(
              builder: (context, provider, child) => provider.loading
                  ? spinkitLoader()
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: provider.viewStudReportListt.length == null
                          ? 0
                          : provider.viewStudReportListt.length,
                      itemBuilder: (context, index) {
                        String status = provider
                            .viewStudReportListt[index].terminationStatus
                            .toString();
                        //  print(status);

                        if (status.toString() == false.toString()) {
                          return Column(
                            children: [
                              kheight10,
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            StudProfileView_Staff(
                                              indexx: index,
                                            )),
                                  );
                                },
                                child: Container(
                                  width: size.width - 10,
                                  height: 90,
                                  decoration: const BoxDecoration(
                                      color: UIGuide.light_black,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      kWidth,
                                      Center(
                                        child: Container(
                                          width: 70,
                                          height: 70,
                                          decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 236, 233, 233),
                                              image: DecorationImage(
                                                  image: NetworkImage(provider
                                                          .viewStudReportListt[
                                                              index]
                                                          .studentPhoto ??
                                                      'https://c8.alamy.com/zooms/9/52c3ea49892f4e5789b31cadac8aa969/2gefnr1.jpg')),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10))),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                const Text(
                                                  'Name : ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 13),
                                                ),
                                                RichText(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  strutStyle: const StrutStyle(
                                                      fontSize: 8.0),
                                                  text: TextSpan(
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black,
                                                      ),
                                                      text: provider
                                                              .viewStudReportListt[
                                                                  index]
                                                              .name ??
                                                          '---'),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  'Roll No : ',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 13),
                                                ),
                                                RichText(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  strutStyle: const StrutStyle(
                                                      fontSize: 8.0),
                                                  text: TextSpan(
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                    ),
                                                    text: provider
                                                                .viewStudReportListt[
                                                                    index]
                                                                .rollNo ==
                                                            null
                                                        ? '---'
                                                        : provider
                                                            .viewStudReportListt[
                                                                index]
                                                            .rollNo
                                                            .toString(),
                                                  ),
                                                ),
                                                kWidth,
                                                kWidth,
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Division : ',
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 13),
                                                    ),
                                                    RichText(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      strutStyle:
                                                          const StrutStyle(
                                                              fontSize: 8.0),
                                                      text: TextSpan(
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black,
                                                        ),
                                                        text: provider
                                                                .viewStudReportListt[
                                                                    index]
                                                                .division ??
                                                            '---',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  'Adm No : ',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 13),
                                                ),
                                                RichText(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  strutStyle: const StrutStyle(
                                                      fontSize: 8.0),
                                                  text: TextSpan(
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                    ),
                                                    text: provider
                                                            .viewStudReportListt[
                                                                index]
                                                            .admnNo ??
                                                        '---',
                                                  ),
                                                ),
                                              ],
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                phn = provider
                                                            .viewStudReportListt[
                                                                index]
                                                            .mobNo ==
                                                        null
                                                    ? '--'
                                                    : provider
                                                        .viewStudReportListt[
                                                            index]
                                                        .mobNo
                                                        .toString();

                                                _makingPhoneCall(
                                                    phn.toString());
                                              },
                                              child: Row(
                                                children: [
                                                  const Text(
                                                    'Phone : ',
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 13),
                                                  ),
                                                  RichText(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    strutStyle:
                                                        const StrutStyle(
                                                            fontSize: 8.0),
                                                    text: TextSpan(
                                                      style: const TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black,
                                                      ),
                                                      text: provider
                                                              .viewStudReportListt[
                                                                  index]
                                                              .mobNo ??
                                                          '---',
                                                    ),
                                                  ),
                                                  const Icon(
                                                    Icons.phone,
                                                    size: 17,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Container(
                            width: 0,
                            height: 0,
                          );
                        }
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  _makingPhoneCall(String phn) async {
    var url = Uri.parse("tel:$phn");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class ViewStaffReport extends StatelessWidget {
  const ViewStaffReport({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      maxHeight: size.height - 200,
    );
  }
}

class StudProfileView_Staff extends StatelessWidget {
  StudProfileView_Staff({Key? key, required this.indexx}) : super(key: key);
  final int indexx;
  String? phn;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    const Color background = Colors.white;
    final Color fill1 = Color.fromARGB(255, 79, 97, 197);
    final Color fill2 = Color.fromARGB(255, 180, 103, 216);
    final List<Color> gradient = [
      fill1,
      fill2,
      background,
      background,
    ];
    final double fillPercent = 35;
    final double fillStop = (100 - fillPercent) / 100;
    final List<double> stops = [0.0, fillStop, fillStop, 1.0];

    return SafeArea(
        child: Scaffold(
      body: Consumer<StudReportListProvider_stf>(
        builder: (context, value, child) => ListView(
          children: [
            Stack(
              children: [
                Container(
                  height: 260,
                  width: size.width,
                  // color: UIGuide.WHITE,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: gradient,
                      stops: stops,
                      end: Alignment.bottomCenter,
                      begin: Alignment.topCenter,
                    ),
                  ),
                ),
                Positioned(
                  top: 70,
                  left: 30,
                  right: 30,
                  child: Container(
                      decoration: const BoxDecoration(
                          color: UIGuide.WHITE,
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 128, 125, 125),
                              offset: Offset(
                                2,
                                5.0,
                              ),
                              blurRadius: 5.0,
                              spreadRadius: 2.0,
                            ),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      width: size.width - 50,
                      height: 170,
                      child: Column(
                        children: [
                          kheight20,
                          kheight20,
                          kheight20,
                          kheight10,
                          Text(
                            value.viewStudReportListt[indexx].name ?? '---',
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 13),
                          ),
                          kheight10,
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Table(
                              // defaultColumnWidth: FixedColumnWidth(120.0),
                              border: TableBorder.all(
                                  color:
                                      const Color.fromARGB(255, 213, 213, 243),
                                  style: BorderStyle.solid,
                                  width: 2),
                              children: [
                                TableRow(children: [
                                  Column(
                                    children: [
                                      const Text('Division',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.grey)),
                                      Text(
                                          value.viewStudReportListt[indexx]
                                                  .division ??
                                              '---',
                                          style:
                                              const TextStyle(fontSize: 16.0)),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Text('Roll No',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.grey)),
                                      Text(
                                          value.viewStudReportListt[indexx]
                                                      .rollNo ==
                                                  null
                                              ? '---'
                                              : value
                                                  .viewStudReportListt[indexx]
                                                  .rollNo
                                                  .toString(),
                                          style:
                                              const TextStyle(fontSize: 16.0)),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Text('Adm No',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.grey)),
                                      Text(
                                          value.viewStudReportListt[indexx]
                                                  .admnNo ??
                                              '---',
                                          style:
                                              const TextStyle(fontSize: 16.0)),
                                    ],
                                  ),
                                ])
                              ],
                            ),
                          )
                        ],
                      )),
                ),
                Center(
                  child: CircleAvatar(
                    foregroundColor: Colors.white,
                    foregroundImage: NetworkImage(
                      value.viewStudReportListt[indexx].studentPhoto ??
                          'https://png.pngtree.com/element_our/png/20181129/male-student-icon-png_251938.jpg',
                    ),
                    radius: 65,
                    backgroundColor: UIGuide.WHITE,
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 170,
                width: size.width,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 238, 234, 234),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 238, 234, 234),
                      ),
                      width: size.width,
                      height: 85,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Permenent Address',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Flexible(
                            child: RichText(
                              overflow: TextOverflow.ellipsis,
                              strutStyle: const StrutStyle(fontSize: 13),
                              maxLines: 3,
                              text: TextSpan(
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 44, 43, 43)),
                                text:
                                    value.viewStudReportListt[indexx].address ??
                                        '---',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        const Text(
                          'Bus Name : ',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 13),
                        ),
                        Flexible(
                          child: Text(
                            value.viewStudReportListt[indexx].bus ?? '---',
                            overflow: TextOverflow.clip,
                            style: const TextStyle(fontSize: 12),
                          ),
                        )
                      ],
                    ),
                    kheight10,
                    Row(
                      children: [
                        const Text(
                          'Bus Stop : ',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 13),
                        ),
                        Flexible(
                          child: Text(
                            value.viewStudReportListt[indexx].stop ?? '---',
                            overflow: TextOverflow.clip,
                            style: const TextStyle(fontSize: 12),
                          ),
                        )
                      ],
                    ),
                    kheight10,
                    GestureDetector(
                      onTap: () {
                        _makingPhoneCall(phn.toString());
                      },
                      child: Row(
                        children: [
                          const Text(
                            'Phone No : ',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 13),
                          ),
                          Flexible(
                            child: Text(
                              phn = value.viewStudReportListt[indexx].mobNo ??
                                  '---',
                              overflow: TextOverflow.clip,
                              style: const TextStyle(fontSize: 12),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }

  _makingPhoneCall(String phn) async {
    var url = Uri.parse("tel:$phn");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class StudRelievedStaff extends StatefulWidget {
  const StudRelievedStaff({Key? key}) : super(key: key);

  @override
  State<StudRelievedStaff> createState() => _StudRelievedStaffState();
}

class _StudRelievedStaffState extends State<StudRelievedStaff> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var p = Provider.of<StudReportListProvider_stf>(context, listen: false);
      p.stdReportSectionStaff();
      p.clearAllFilters();
      p.removeSectionAll();
      p.courseClear();
      p.divisionClear();
      p.sectionClear();
      p.removeSectionAll();
      p.removeDivisionAll();
      p.removeCourseAll();
      p.clearViewList();
      //p.viewStudentReportList();
    });
  }

  String? phn;
  String sectionId = '';
  String courseId = '';
  String divisionId = '';
  final studReportInitialValuesController = TextEditingController();
  final studReportInitialValuesController1 = TextEditingController();
  final StudReportcourseController = TextEditingController();
  final StudReportcourseController1 = TextEditingController();
  final StudReportDivisionController = TextEditingController();
  final StudReportDivisionController1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<StudReportListProvider_stf>(
      builder: (context, value, child) => ListView(
        children: [
          kheight10,
          Row(
            children: [
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.49,
                child: Consumer<StudReportListProvider_stf>(
                    builder: (context, snapshot, child) {
                  return InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                                child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: studReportinitvalues_stf!.length,
                                    itemBuilder: (context, index) {
                                      // print(snapshot

                                      //     .attendenceInitialValues.length);

                                      value.removeSectionAll();
                                      return ListTile(
                                        // selectedTileColor: Colors.blue.shade100,
                                        // selectedColor: UIGuide.PRIMARY2,
                                        // selected:
                                        //     studReportinitvalues_stf![index],
                                        onTap: () async {
                                          print(
                                              'guh.....${studReportinitvalues_stf![index]}');
                                          studReportInitialValuesController
                                                  .text =
                                              await studReportinitvalues_stf![
                                                      index]['value'] ??
                                                  '--';
                                          studReportInitialValuesController1
                                                  .text =
                                              await studReportinitvalues_stf![
                                                      index]['text'] ??
                                                  '--';
                                          sectionId =
                                              studReportInitialValuesController
                                                  .text
                                                  .toString();

                                          // snapshot.addSelectedCourse(
                                          //     attendecourse![index]);
                                          print(sectionId);
                                          await Provider.of<
                                                      StudReportListProvider_stf>(
                                                  context,
                                                  listen: false)
                                              .courseClear();

                                          await Provider.of<
                                                      StudReportListProvider_stf>(
                                                  context,
                                                  listen: false)
                                              .getCourseList(sectionId);
                                          Navigator.of(context).pop();
                                        },
                                        title: Text(
                                          studReportinitvalues_stf![index]
                                                  ['text'] ??
                                              '--',
                                          textAlign: TextAlign.center,
                                        ),
                                      );
                                    }),
                              ],
                            ));
                          });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: UIGuide.light_Purple, width: 1),
                            ),
                            height: 40,
                            child: TextField(
                              textAlign: TextAlign.center,
                              controller: studReportInitialValuesController1,
                              decoration: const InputDecoration(
                                filled: true,
                                contentPadding:
                                    EdgeInsets.only(left: 0, top: 0),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                fillColor: Color.fromARGB(255, 238, 237, 237),
                                border: OutlineInputBorder(),
                                labelText: "  Select Section",
                                hintText: "Section",
                              ),
                              enabled: false,
                            ),
                          ),
                          SizedBox(
                            height: 0,
                            child: TextField(
                              textAlign: TextAlign.center,
                              controller: studReportInitialValuesController,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(255, 238, 237, 237),
                                border: OutlineInputBorder(),
                                labelText: "",
                                hintText: "",
                              ),
                              enabled: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
              Spacer(),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.49,
                child: Consumer<StudReportListProvider_stf>(
                    builder: (context, snapshot, child) {
                  return InkWell(
                    onTap: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                                child: Container(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: snapshot.courselist.length,
                                        itemBuilder: (context, index) {
                                          print(snapshot.courselist.length);
                                          // value.removeDivisionAll();
                                          return ListTile(
                                            // selectedTileColor:
                                            //     Colors.blue.shade100,
                                            // selectedColor: UIGuide.PRIMARY2,
                                            selected: snapshot.isCourseSelected(
                                                snapshot.courselist[index]),
                                            onTap: () async {
                                              print(snapshot.courselist.length);
                                              StudReportcourseController.text =
                                                  snapshot.courselist[index]
                                                          .value ??
                                                      '---';
                                              StudReportcourseController1.text =
                                                  snapshot.courselist[index]
                                                              .text ==
                                                          null
                                                      ? '---'
                                                      : snapshot
                                                          .courselist[index]
                                                          .text;
                                              snapshot.addSelectedCourse(
                                                  snapshot.courselist[index]);

                                              print(StudReportcourseController
                                                  .text);
                                              sectionId =
                                                  studReportInitialValuesController
                                                      .text
                                                      .toString();
                                              courseId =
                                                  StudReportcourseController
                                                      .text
                                                      .toString();
                                              await Provider.of<
                                                          StudReportListProvider_stf>(
                                                      context,
                                                      listen: false)
                                                  .divisionClear();

                                              await Provider.of<
                                                          StudReportListProvider_stf>(
                                                      context,
                                                      listen: false)
                                                  .getDivisionList(sectionId);

                                              Navigator.of(context).pop();
                                            },
                                            title: Text(
                                              snapshot.courselist[index].text ==
                                                      null
                                                  ? '---'
                                                  : snapshot
                                                      .courselist[index].text,
                                              textAlign: TextAlign.center,
                                            ),
                                          );
                                        }),
                                  ],
                                ),
                              ),
                            ));
                          });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: UIGuide.light_Purple, width: 1),
                            ),
                            height: 40,
                            child: TextField(
                              textAlign: TextAlign.center,
                              controller: StudReportcourseController1,
                              decoration: InputDecoration(
                                filled: true,
                                contentPadding:
                                    EdgeInsets.only(left: 0, top: 0),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                fillColor: Color.fromARGB(255, 238, 237, 237),
                                border: OutlineInputBorder(),
                                labelText: "  Select Course",
                                hintText: "Course",
                              ),
                              enabled: false,
                            ),
                          ),
                          SizedBox(
                            height: 0,
                            child: TextField(
                              controller: StudReportcourseController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(255, 238, 237, 237),
                                border: OutlineInputBorder(),
                                labelText: "",
                                hintText: "",
                              ),
                              enabled: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.49,
                child: Consumer<StudReportListProvider_stf>(
                    builder: (context, snapshot, child) {
                  return InkWell(
                    onTap: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                                child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: snapshot.divisionlist.length,
                                      itemBuilder: (context, index) {
                                        print(snapshot.divisionlist.length);
                                        // value.removeDivisionAll();
                                        return ListTile(
                                          // selectedTileColor:
                                          //     Colors.blue.shade100,
                                          // selectedColor: UIGuide.PRIMARY2,
                                          selected: snapshot.isDivisionSelected(
                                              snapshot.divisionlist[index]),
                                          onTap: () async {
                                            print(snapshot.divisionlist.length);
                                            StudReportDivisionController.text =
                                                snapshot.divisionlist[index]
                                                        .value ??
                                                    '---';

                                            divisionId =
                                                StudReportDivisionController
                                                    .text
                                                    .toString();
                                            StudReportDivisionController1.text =
                                                snapshot.divisionlist[index]
                                                        .text ??
                                                    '---';
                                            snapshot.addSelectedDivision(
                                                snapshot.divisionlist[index]);

                                            print(StudReportDivisionController
                                                .text);

                                            Navigator.of(context).pop();
                                          },
                                          title: Text(
                                            snapshot.divisionlist[index].text ??
                                                '---',
                                            textAlign: TextAlign.center,
                                          ),
                                        );
                                      }),
                                ],
                              ),
                            ));
                          });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: UIGuide.light_Purple, width: 1),
                            ),
                            height: 40,
                            child: TextField(
                              textAlign: TextAlign.center,
                              controller: StudReportDivisionController1,
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(left: 0, top: 0),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                filled: true,
                                fillColor: Color.fromARGB(255, 238, 237, 237),
                                border: OutlineInputBorder(),
                                labelText: "  Select Division",
                                hintText: "Division",
                              ),
                              enabled: false,
                            ),
                          ),
                          SizedBox(
                            height: 0,
                            child: TextField(
                              controller: StudReportDivisionController,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(255, 238, 237, 237),
                                border: OutlineInputBorder(),
                                labelText: "",
                                hintText: "",
                              ),
                              enabled: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
              Spacer(),
              MaterialButton(
                child: const Text('View'),
                color: UIGuide.THEME_LIGHT,
                onPressed: (() async {
                  if (StudReportDivisionController.text.isEmpty &&
                      studReportInitialValuesController.text.isEmpty &&
                      StudReportDivisionController.text.isEmpty) {
                    return AwesomeDialog(
                            context: context,
                            dialogType: DialogType.warning,
                            animType: AnimType.rightSlide,
                            headerAnimationLoop: false,
                            title: 'Warning',
                            desc: 'Select mandatory fields',
                            btnOkOnPress: () {
                              return;
                            },
                            btnOkIcon: Icons.cancel,
                            btnOkColor: Colors.red)
                        .show();
                  }
                  sectionId = studReportInitialValuesController.text.toString();
                  courseId = StudReportcourseController.text.toString();
                  divisionId = StudReportDivisionController.text.toString();
                  await Provider.of<StudReportListProvider_stf>(context,
                          listen: false)
                      .sectionClear();
                  await Provider.of<StudReportListProvider_stf>(context,
                          listen: false)
                      .removeSectionAll();
                  await Provider.of<StudReportListProvider_stf>(context,
                          listen: false)
                      .courseClear();
                  await Provider.of<StudReportListProvider_stf>(context,
                          listen: false)
                      .removeCourseAll();
                  await Provider.of<StudReportListProvider_stf>(context,
                          listen: false)
                      .divisionClear();
                  await Provider.of<StudReportListProvider_stf>(context,
                          listen: false)
                      .removeDivisionAll();
                  await Provider.of<StudReportListProvider_stf>(context,
                          listen: false)
                      .clearViewList();
                  await Provider.of<StudReportListProvider_stf>(context,
                          listen: false)
                      .viewStudentReportList(sectionId, courseId, divisionId);
                }),
              ),
              Spacer()
            ],
          ),
          ViewStaffReport(size: size),
          LimitedBox(
            maxHeight: size.height - 230,
            child: Consumer<StudReportListProvider_stf>(
              builder: (context, provider, child) => provider.loading
                  ? const spinkitLoader()
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: provider.viewStudReportListt.length,
                      itemBuilder: (context, index) {
                        String status = provider
                            .viewStudReportListt[index].terminationStatus
                            .toString();
                        print(status);

                        if (status.toString() == true.toString()) {
                          return Column(
                            children: [
                              kheight10,
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            StudProfileView_Staff(
                                              indexx: index,
                                            )),
                                  );
                                },
                                child: Container(
                                  width: size.width - 10,
                                  height: 90,
                                  decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 236, 233, 233),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      kWidth,
                                      Center(
                                        child: Container(
                                          width: 70,
                                          height: 70,
                                          decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 236, 233, 233),
                                              image: DecorationImage(
                                                  image: NetworkImage(provider
                                                          .viewStudReportListt[
                                                              index]
                                                          .studentPhoto ??
                                                      'https://c8.alamy.com/zooms/9/52c3ea49892f4e5789b31cadac8aa969/2gefnr1.jpg')),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10))),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                const Text(
                                                  'Name : ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 13),
                                                ),
                                                RichText(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  strutStyle: const StrutStyle(
                                                      fontSize: 8.0),
                                                  text: TextSpan(
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black,
                                                      ),
                                                      text: provider
                                                              .viewStudReportListt[
                                                                  index]
                                                              .name ??
                                                          '---'),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  'Roll No : ',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 13),
                                                ),
                                                RichText(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  strutStyle: const StrutStyle(
                                                      fontSize: 8.0),
                                                  text: TextSpan(
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                    ),
                                                    text: provider
                                                                .viewStudReportListt[
                                                                    index]
                                                                .rollNo ==
                                                            null
                                                        ? '---'
                                                        : provider
                                                            .viewStudReportListt[
                                                                index]
                                                            .rollNo
                                                            .toString(),
                                                  ),
                                                ),
                                                kWidth,
                                                kWidth,
                                                Row(
                                                  children: [
                                                    const Text(
                                                      'Division : ',
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 13),
                                                    ),
                                                    RichText(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      strutStyle:
                                                          const StrutStyle(
                                                              fontSize: 8.0),
                                                      text: TextSpan(
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black,
                                                        ),
                                                        text: provider
                                                                .viewStudReportListt[
                                                                    index]
                                                                .division ??
                                                            '---',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  'Adm No : ',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 13),
                                                ),
                                                RichText(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  strutStyle: const StrutStyle(
                                                      fontSize: 8.0),
                                                  text: TextSpan(
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                    ),
                                                    text: provider
                                                            .viewStudReportListt[
                                                                index]
                                                            .admnNo ??
                                                        '---',
                                                  ),
                                                ),
                                              ],
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                phn = provider
                                                            .viewStudReportListt[
                                                                index]
                                                            .mobNo ==
                                                        null
                                                    ? '--'
                                                    : provider
                                                        .viewStudReportListt[
                                                            index]
                                                        .mobNo
                                                        .toString();

                                                _makingPhoneCall(
                                                    phn.toString());
                                              },
                                              child: Row(
                                                //mainAxisAlignment: MainAxisAlignment.center,
                                                //crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  const Text(
                                                    'Phone : ',
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 13),
                                                  ),
                                                  RichText(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    strutStyle:
                                                        const StrutStyle(
                                                            fontSize: 8.0),
                                                    text: TextSpan(
                                                      style: const TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black,
                                                      ),
                                                      text: provider
                                                              .viewStudReportListt[
                                                                  index]
                                                              .mobNo ??
                                                          '---',
                                                    ),
                                                  ),
                                                  const Icon(
                                                    Icons.phone,
                                                    size: 17,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Container(
                            height: 0,
                            width: 0,
                          );
                        }
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  _makingPhoneCall(String phn) async {
    var url = Uri.parse("tel:$phn");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class StudentReportBoth_Staff extends StatefulWidget {
  const StudentReportBoth_Staff({Key? key}) : super(key: key);

  @override
  State<StudentReportBoth_Staff> createState() =>
      _StudentReportBoth_StaffState();
}

class _StudentReportBoth_StaffState extends State<StudentReportBoth_Staff> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var p = Provider.of<StudReportListProvider_stf>(context, listen: false);
      p.stdReportSectionStaff();
      p.clearAllFilters();
      p.removeSectionAll();
      p.courseClear();
      p.divisionClear();
      p.sectionClear();
      p.removeSectionAll();
      p.removeDivisionAll();
      p.removeCourseAll();
      p.clearViewList();
      // p.viewStudentReportList();
    });
  }

  String? phn;
  String sectionId = '';
  String courseId = '';
  String divisionId = '';
  final studReportInitialValuesController = TextEditingController();
  final studReportInitialValuesController1 = TextEditingController();
  final StudReportcourseController = TextEditingController();
  final StudReportcourseController1 = TextEditingController();
  final StudReportDivisionController = TextEditingController();
  final StudReportDivisionController1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<StudReportListProvider_stf>(
      builder: (context, value, child) => ListView(
        children: [
          kheight10,
          Row(
            children: [
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.49,
                child: Consumer<StudReportListProvider_stf>(
                    builder: (context, snapshot, child) {
                  return InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                                child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: studReportinitvalues_stf!.length,
                                    itemBuilder: (context, index) {
                                      // print(snapshot

                                      //     .attendenceInitialValues.length);

                                      value.removeSectionAll();
                                      return ListTile(
                                        // selectedTileColor: Colors.blue.shade100,
                                        // selectedColor: UIGuide.PRIMARY2,
                                        // selected:
                                        //     studReportinitvalues_stf![index],
                                        onTap: () async {
                                          print(
                                              'guh.....${studReportinitvalues_stf![index]}');
                                          studReportInitialValuesController
                                                  .text =
                                              await studReportinitvalues_stf![
                                                      index]['value'] ??
                                                  '--';
                                          studReportInitialValuesController1
                                                  .text =
                                              await studReportinitvalues_stf![
                                                      index]['text'] ??
                                                  '--';
                                          sectionId =
                                              studReportInitialValuesController
                                                  .text
                                                  .toString();

                                          // snapshot.addSelectedCourse(
                                          //     attendecourse![index]);
                                          print(sectionId);
                                          await Provider.of<
                                                      StudReportListProvider_stf>(
                                                  context,
                                                  listen: false)
                                              .courseClear();

                                          await Provider.of<
                                                      StudReportListProvider_stf>(
                                                  context,
                                                  listen: false)
                                              .getCourseList(sectionId);
                                          Navigator.of(context).pop();
                                        },
                                        title: Text(
                                          studReportinitvalues_stf![index]
                                                  ['text'] ??
                                              '--',
                                          textAlign: TextAlign.center,
                                        ),
                                      );
                                    }),
                              ],
                            ));
                          });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: UIGuide.light_Purple, width: 1),
                            ),
                            height: 40,
                            child: TextField(
                              textAlign: TextAlign.center,
                              controller: studReportInitialValuesController1,
                              decoration: const InputDecoration(
                                filled: true,
                                contentPadding:
                                    EdgeInsets.only(left: 0, top: 0),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                fillColor: Color.fromARGB(255, 238, 237, 237),
                                border: OutlineInputBorder(),
                                labelText: "  Select Section",
                                hintText: "Section",
                              ),
                              enabled: false,
                            ),
                          ),
                          SizedBox(
                            height: 0,
                            child: TextField(
                              textAlign: TextAlign.center,
                              controller: studReportInitialValuesController,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(255, 238, 237, 237),
                                border: OutlineInputBorder(),
                                labelText: "",
                                hintText: "",
                              ),
                              enabled: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
              Spacer(),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.49,
                child: Consumer<StudReportListProvider_stf>(
                    builder: (context, snapshot, child) {
                  return InkWell(
                    onTap: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                                child: Container(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: snapshot.courselist.length,
                                        itemBuilder: (context, index) {
                                          print(snapshot.courselist.length);
                                          return ListTile(
                                            // selectedTileColor:
                                            //     Colors.blue.shade100,
                                            // selectedColor: UIGuide.PRIMARY2,
                                            selected: snapshot.isCourseSelected(
                                                snapshot.courselist[index]),
                                            onTap: () async {
                                              print(snapshot.courselist.length);
                                              StudReportcourseController.text =
                                                  snapshot.courselist[index]
                                                          .value ??
                                                      '---';
                                              StudReportcourseController1.text =
                                                  snapshot.courselist[index]
                                                          .text.isEmpty
                                                      ? '---'
                                                      : snapshot
                                                          .courselist[index]
                                                          .text;
                                              snapshot.addSelectedCourse(
                                                  snapshot.courselist[index]);

                                              print(StudReportcourseController
                                                  .text);
                                              courseId =
                                                  StudReportcourseController
                                                      .text
                                                      .toString();
                                              sectionId =
                                                  studReportInitialValuesController
                                                      .text
                                                      .toString();
                                              await Provider.of<
                                                          StudReportListProvider_stf>(
                                                      context,
                                                      listen: false)
                                                  .divisionClear();

                                              await Provider.of<
                                                          StudReportListProvider_stf>(
                                                      context,
                                                      listen: false)
                                                  .getDivisionList(sectionId);

                                              Navigator.of(context).pop();
                                            },
                                            title: Text(
                                              snapshot.courselist[index].text ==
                                                      null
                                                  ? '---'
                                                  : snapshot
                                                      .courselist[index].text,
                                              textAlign: TextAlign.center,
                                            ),
                                          );
                                        }),
                                  ],
                                ),
                              ),
                            ));
                          });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: UIGuide.light_Purple, width: 1),
                            ),
                            height: 40,
                            child: TextField(
                              textAlign: TextAlign.center,
                              controller: StudReportcourseController1,
                              decoration: const InputDecoration(
                                filled: true,
                                contentPadding:
                                    EdgeInsets.only(left: 0, top: 0),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                fillColor: Color.fromARGB(255, 238, 237, 237),
                                border: OutlineInputBorder(),
                                labelText: "  Select Course",
                                hintText: "Course",
                              ),
                              enabled: false,
                            ),
                          ),
                          SizedBox(
                            height: 0,
                            child: TextField(
                              controller: StudReportcourseController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(255, 238, 237, 237),
                                border: OutlineInputBorder(),
                                labelText: "",
                                hintText: "",
                              ),
                              enabled: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.49,
                child: Consumer<StudReportListProvider_stf>(
                    builder: (context, snapshot, child) {
                  return InkWell(
                    onTap: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                                child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: snapshot.divisionlist.length,
                                      itemBuilder: (context, index) {
                                        print(snapshot.divisionlist.length);

                                        return ListTile(
                                          // selectedTileColor:
                                          //     Colors.blue.shade100,
                                          // selectedColor: UIGuide.PRIMARY2,
                                          selected: snapshot.isDivisionSelected(
                                              snapshot.divisionlist[index]),
                                          onTap: () async {
                                            print(snapshot.divisionlist.length);
                                            StudReportDivisionController.text =
                                                snapshot.divisionlist[index]
                                                        .value ??
                                                    '---';
                                            StudReportDivisionController1.text =
                                                snapshot.divisionlist[index]
                                                        .text ??
                                                    '---';
                                            divisionId =
                                                StudReportDivisionController
                                                    .text
                                                    .toString();
                                            snapshot.addSelectedDivision(
                                                snapshot.divisionlist[index]);

                                            print(StudReportDivisionController
                                                .text);

                                            Navigator.of(context).pop();
                                          },
                                          title: Text(
                                            snapshot.divisionlist[index].text ??
                                                '---',
                                            textAlign: TextAlign.center,
                                          ),
                                        );
                                      }),
                                ],
                              ),
                            ));
                          });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: UIGuide.light_Purple, width: 1),
                            ),
                            height: 40,
                            child: TextField(
                              textAlign: TextAlign.center,
                              controller: StudReportDivisionController1,
                              decoration: const InputDecoration(
                                filled: true,
                                contentPadding:
                                    EdgeInsets.only(left: 0, top: 0),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                fillColor: Color.fromARGB(255, 238, 237, 237),
                                border: OutlineInputBorder(),
                                labelText: " Select Division",
                                hintText: "Division",
                              ),
                              enabled: false,
                            ),
                          ),
                          SizedBox(
                            height: 0,
                            child: TextField(
                              controller: StudReportDivisionController,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(255, 238, 237, 237),
                                border: OutlineInputBorder(),
                                labelText: "",
                                hintText: "",
                              ),
                              enabled: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
              Spacer(),
              MaterialButton(
                child: const Text('View'),
                color: UIGuide.THEME_LIGHT,
                onPressed: (() async {
                  if (StudReportDivisionController.text.isEmpty &&
                      studReportInitialValuesController.text.isEmpty &&
                      StudReportDivisionController.text.isEmpty) {
                    return AwesomeDialog(
                            context: context,
                            dialogType: DialogType.warning,
                            animType: AnimType.rightSlide,
                            headerAnimationLoop: false,
                            title: 'Warning',
                            desc: 'Select mandatory fields',
                            btnOkOnPress: () {
                              return;
                            },
                            btnOkIcon: Icons.cancel,
                            btnOkColor: Colors.red)
                        .show();
                  }
                  sectionId = studReportInitialValuesController.text.toString();
                  courseId = StudReportcourseController.text.toString();
                  divisionId = StudReportDivisionController.text.toString();

                  await Provider.of<StudReportListProvider_stf>(context,
                          listen: false)
                      .sectionClear();
                  await Provider.of<StudReportListProvider_stf>(context,
                          listen: false)
                      .removeSectionAll();
                  await Provider.of<StudReportListProvider_stf>(context,
                          listen: false)
                      .courseClear();
                  await Provider.of<StudReportListProvider_stf>(context,
                          listen: false)
                      .removeCourseAll();
                  await Provider.of<StudReportListProvider_stf>(context,
                          listen: false)
                      .divisionClear();
                  await Provider.of<StudReportListProvider_stf>(context,
                          listen: false)
                      .removeDivisionAll();
                  await Provider.of<StudReportListProvider_stf>(context,
                          listen: false)
                      .clearViewList();
                  await Provider.of<StudReportListProvider_stf>(context,
                          listen: false)
                      .viewStudentReportList(sectionId, courseId, divisionId);
                }),
              ),
              Spacer()
            ],
          ),
          ViewStaffReport(size: size),
          LimitedBox(
            maxHeight: size.height - 230,
            child: Consumer<StudReportListProvider_stf>(
              builder: (context, provider, child) => provider.loading
                  ? spinkitLoader()
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: provider.viewStudReportListt.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            kheight10,
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          StudProfileView_Staff(
                                            indexx: index,
                                          )),
                                );
                              },
                              child: Container(
                                width: size.width - 10,
                                height: 90,
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 236, 233, 233),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    kWidth,
                                    Center(
                                      child: Container(
                                        width: 70,
                                        height: 70,
                                        decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 236, 233, 233),
                                            image: DecorationImage(
                                                image: NetworkImage(provider
                                                        .viewStudReportListt[
                                                            index]
                                                        .studentPhoto ??
                                                    'https://c8.alamy.com/zooms/9/52c3ea49892f4e5789b31cadac8aa969/2gefnr1.jpg')),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10))),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              const Text(
                                                'Name : ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 13),
                                              ),
                                              RichText(
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                strutStyle: const StrutStyle(
                                                    fontSize: 8.0),
                                                text: TextSpan(
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                    ),
                                                    text: provider
                                                            .viewStudReportListt[
                                                                index]
                                                            .name ??
                                                        '---'),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                'Roll No : ',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 13),
                                              ),
                                              RichText(
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                strutStyle: const StrutStyle(
                                                    fontSize: 8.0),
                                                text: TextSpan(
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black,
                                                  ),
                                                  text: provider
                                                              .viewStudReportListt[
                                                                  index]
                                                              .rollNo ==
                                                          null
                                                      ? '---'
                                                      : provider
                                                          .viewStudReportListt[
                                                              index]
                                                          .rollNo
                                                          .toString(),
                                                ),
                                              ),
                                              kWidth,
                                              kWidth,
                                              Row(
                                                children: [
                                                  const Text(
                                                    'Division : ',
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 13),
                                                  ),
                                                  RichText(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    strutStyle:
                                                        const StrutStyle(
                                                            fontSize: 8.0),
                                                    text: TextSpan(
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black,
                                                      ),
                                                      text: provider
                                                              .viewStudReportListt[
                                                                  index]
                                                              .division ??
                                                          '---',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                'Adm No : ',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 13),
                                              ),
                                              RichText(
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                strutStyle: const StrutStyle(
                                                    fontSize: 8.0),
                                                text: TextSpan(
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black,
                                                  ),
                                                  text: provider
                                                          .viewStudReportListt[
                                                              index]
                                                          .admnNo ??
                                                      '---',
                                                ),
                                              ),
                                            ],
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              phn = provider
                                                          .viewStudReportListt[
                                                              index]
                                                          .mobNo ==
                                                      null
                                                  ? '--'
                                                  : provider
                                                      .viewStudReportListt[
                                                          index]
                                                      .mobNo
                                                      .toString();

                                              _makingPhoneCall(phn.toString());
                                            },
                                            child: Row(
                                              children: [
                                                const Text(
                                                  'Phone : ',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 13),
                                                ),
                                                RichText(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  strutStyle: const StrutStyle(
                                                      fontSize: 8.0),
                                                  text: TextSpan(
                                                    style: const TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.black,
                                                    ),
                                                    text: provider
                                                            .viewStudReportListt[
                                                                index]
                                                            .mobNo ??
                                                        '---',
                                                  ),
                                                ),
                                                const Icon(
                                                  Icons.phone,
                                                  size: 17,
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  _makingPhoneCall(String phn) async {
    var url = Uri.parse("tel:$phn");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
