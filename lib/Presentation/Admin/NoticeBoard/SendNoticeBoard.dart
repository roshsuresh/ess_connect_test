import 'package:Ess_test/Application/AdminProviders/NoticeBoardadmin.dart';
import 'package:Ess_test/Constants.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';

import '../../../Application/Staff_Providers/NoticeboardSend.dart';
import '../../../Domain/Admin/Course&DivsionList.dart';
import '../../../utils/constants.dart';

class SendNoticeBoardAdmin extends StatefulWidget {
  const SendNoticeBoardAdmin({Key? key}) : super(key: key);

  @override
  State<SendNoticeBoardAdmin> createState() => _SendNoticeBoardAdminState();
}

class _SendNoticeBoardAdminState extends State<SendNoticeBoardAdmin> {
  String? datee;
  String division = '';
  String course = '';
  DateTime? _mydatetimeFrom;
  DateTime? _mydatetimeTo;
  String time = '--';
  String timeNow = '--';
  String? checkname;
  List courseData = [];
  List divisionData = [];
  final categoryvalueController = TextEditingController();
  final categoryvalueController1 = TextEditingController();
  final titleController = TextEditingController();
  final mattercontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var p = Provider.of<NoticeBoardAdminProvider>(context, listen: false);
      p.getCourseList();
      p.noticeboardCategory();
      p.courseDropDown.clear();
      p.courseList.clear();
      p.divisionList.clear();
      p.divisionDropDown.clear();
      titleController.clear();
    });
  }

  String? attachmentid;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    datee = DateFormat('dd/MMM/yyyy').format(DateTime.now());

    return ListView(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
                minWidth: size.width - 250,
                color: Colors.white70,
                child: Text('Date: ${datee.toString()}'),
                onPressed: () async {
                  return;
                }),
            Spacer(),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.49,
              child: Consumer<NoticeBoardAdminProvider>(
                  builder: (context, snapshot, child) {
                return InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                              child: Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: noticeCategoryAdmin!.length,
                                    itemBuilder: (context, index) {
                                      // print(snapshot

                                      //     .attendenceInitialValues.length);

                                      // value.removeCourseAll();
                                      return ListTile(
                                        selectedTileColor: Colors.blue.shade100,
                                        selectedColor: UIGuide.PRIMARY2,

                                        // selected: snapshot.isCourseSelected(
                                        //     attendecourse![index]),

                                        onTap: () async {
                                          print({noticeCategoryAdmin![index]});
                                          categoryvalueController.text =
                                              await noticeCategoryAdmin![index]
                                                      ['value'] ??
                                                  '--';
                                          categoryvalueController1.text =
                                              await noticeCategoryAdmin![index]
                                                      ['text'] ??
                                                  '--';

                                          Navigator.of(context).pop();
                                        },
                                        title: Text(
                                          noticeCategoryAdmin![index]['text'] ??
                                              '--',
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
                        SizedBox(
                          height: 40,
                          child: TextField(
                            textAlign: TextAlign.center,
                            controller: categoryvalueController1,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color.fromARGB(255, 238, 237, 237),
                              border: OutlineInputBorder(),
                              labelText: "Select Category",
                              hintText: "Category",
                            ),
                            enabled: false,
                          ),
                        ),
                        SizedBox(
                          height: 0,
                          child: TextField(
                            textAlign: TextAlign.center,
                            controller: categoryvalueController,
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: titleController,
            minLines: 1,
            maxLines: 1,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              labelText: 'Title*',
              hintText: 'Enter Title',
              hintStyle: TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: mattercontroller,
            minLines: 1,
            maxLines: 5,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              labelText: 'Matter*',
              hintText: 'Enter Matter',
              hintStyle: TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
          ),
        ),
        Center(
          child: SizedBox(
            width: 120,
            child: MaterialButton(
              // minWidth: size.width - 200,
              child: Text(
                  checkname == null ? 'Choose File' : checkname.toString()),

              color: Colors.white70,
              onPressed: (() async {
                final result = await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['pdf', 'png', 'jpeg', 'jpg']);
                if (result == null) {
                  return;
                }
                final file = result.files.first;
                print('Name: ${file.name}');
                print('Path: ${file.path}');
                print('Extension: ${file.extension}');
                await Provider.of<NoticeBoardAdminProvider>(context,
                        listen: false)
                    .noticeImageSave(file.path.toString());
                //openFile(file);
                if (file.name.length >= 6) {
                  setState(() {
                    checkname = file.name.replaceRange(6, file.name.length, '');
                  });

                  print(checkname);
                }
              }),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              // height: 30,
              // width: MediaQuery.of(context).size.width * 0.47,
              child: MaterialButton(
                minWidth: size.width - 216,
                child: Center(child: Text('From  $time')),
                color: Colors.white,
                onPressed: (() async {
                  _mydatetimeFrom = await showDatePicker(
                      context: context,
                      initialDate: _mydatetimeFrom ?? DateTime.now(),
                      firstDate:
                          DateTime.now().subtract(const Duration(days: 0)),
                      lastDate: DateTime(2030));
                  setState(() {
                    time = DateFormat('dd/MMM/yyyy').format(_mydatetimeFrom!);
                    print(time);
                  });
                }),
              ),
            ),
            Spacer(),
            //  kWidth, kWidth,
            SizedBox(
              // height: 30,
              // width: MediaQuery.of(context).size.width * 0.47,
              child: MaterialButton(
                minWidth: size.width - 216,
                child: Center(child: Text('To  ${timeNow}')),
                color: Colors.white,
                onPressed: (() async {
                  _mydatetimeTo = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(const Duration(days: 0)),
                    lastDate: DateTime(2100),
                  );
                  // _mydatetimeTo = await showDatePicker(
                  //     context: context,
                  //     initialDate: _mydatetimeTo ?? DateTime.now(),
                  //     firstDate: DateTime(2022),
                  //     lastDate: DateTime(2030));
                  setState(() {
                    timeNow = DateFormat('dd/MMM/yyyy').format(_mydatetimeTo!);
                    print(timeNow);
                  });
                }),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Consumer<NoticeBoardAdminProvider>(
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: size.width * .43,
                  height: 50,
                  child: MultiSelectDialogField(
                    // height: 200,
                    items: value.courseDropDown,
                    listType: MultiSelectListType.CHIP,
                    title: const Text(
                      "Select Course",
                      style: TextStyle(color: Colors.black),
                    ),
                    // selectedColor: Color.fromARGB(255, 157, 232, 241),
                    selectedItemsTextStyle: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: UIGuide.light_Purple),
                    confirmText: Text(
                      'OK',
                      style: TextStyle(color: UIGuide.light_Purple),
                    ),
                    cancelText: Text(
                      'Cancel',
                      style: TextStyle(color: UIGuide.light_Purple),
                    ),
                    separateSelectedItems: true,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                        color: Colors.grey,
                        width: 2,
                      ),
                    ),
                    buttonIcon: const Icon(
                      Icons.arrow_drop_down_outlined,
                      color: Colors.grey,
                    ),
                    buttonText: Text(
                      "Select Course",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    chipDisplay: MultiSelectChipDisplay.none(),
                    onConfirm: (results) async {
                      courseData = [];
                      for (var i = 0; i < results.length; i++) {
                        CourseListModel data = results[i] as CourseListModel;
                        print(data.name);
                        print(data.courseId);
                        courseData.add(data.courseId);
                        courseData.map((e) => data.courseId);
                        print("${courseData.map((e) => data.courseId)}");
                      }
                      print("courseData${courseData}");
                      course = courseData.join(',');
                      await Provider.of<NoticeBoardAdminProvider>(context,
                              listen: false)
                          .getDivisionList(course);
                      // print(courseData.join('","'));
                    },
                  ),
                ),
              ),
            ),
            Spacer(),
            Consumer<NoticeBoardAdminProvider>(
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: size.width * .43,
                  height: 50,
                  child: MultiSelectDialogField(
                    // height: 200,
                    items: value.divisionDropDown,
                    listType: MultiSelectListType.CHIP,
                    title: const Text(
                      "Select Division",
                      style: TextStyle(color: Colors.black),
                    ),
                    // selectedColor: Color.fromARGB(255, 157, 232, 241),
                    selectedItemsTextStyle: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: UIGuide.light_Purple),
                    confirmText: Text(
                      'OK',
                      style: TextStyle(color: UIGuide.light_Purple),
                    ),
                    cancelText: Text(
                      'Cancel',
                      style: TextStyle(color: UIGuide.light_Purple),
                    ),
                    separateSelectedItems: true,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                        color: Colors.grey,
                        width: 2,
                      ),
                    ),
                    buttonIcon: const Icon(
                      Icons.arrow_drop_down_outlined,
                      color: Colors.grey,
                    ),
                    buttonText: Text(
                      "Select Division",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    chipDisplay: MultiSelectChipDisplay.none(),
                    onConfirm: (results) async {
                      divisionData = [];
                      for (var i = 0; i < results.length; i++) {
                        DivisionListModel data =
                            results[i] as DivisionListModel;
                        print(data.text);
                        print(data.value);
                        divisionData.add(data.value);
                        divisionData.map((e) => data.value);
                        print("${divisionData.map((e) => data.value)}");
                      }
                      division = divisionData.join(',');

                      print(divisionData.join(','));
                      attachmentid = value.id.toString();
                    },
                  ),
                ),
              ),
            )
          ],
        ),
        kheight20,
        kheight20,
        Center(
          child: SizedBox(
            width: 150,
            child: MaterialButton(
              minWidth: size.width - 150,
              child: const Text(
                'Save',
                textAlign: TextAlign.center,
              ),
              color: Color.fromARGB(179, 145, 143, 143),
              onPressed: (() async {
                if (titleController.text.isEmpty &&
                    mattercontroller.text.isEmpty &&
                    categoryvalueController.text.isEmpty) {
                  return await AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          headerAnimationLoop: false,
                          title: 'Error',
                          desc: 'Select mandatory fields',
                          btnOkOnPress: () {
                            return;
                          },
                          btnOkIcon: Icons.cancel,
                          btnOkColor: Colors.red)
                      .show();
                } else {
                  await Provider.of<NoticeBoardAdminProvider>(context,
                          listen: false)
                      .noticeBoardSave(
                          context,
                          datee.toString(),
                          time,
                          timeNow,
                          titleController.text,
                          mattercontroller.text,
                          courseData,
                          divisionData,
                          categoryvalueController.text,
                          attachmentid!);

                  print(datee);
                  print(time);
                  print(timeNow);
                  print(titleController);
                  print(mattercontroller);

                  print(categoryvalueController);
                  print(attachmentid);

                  titleController.clear();
                  mattercontroller.clear();

                  categoryvalueController.clear();

                  categoryvalueController1.clear();
                }
              }),
            ),
          ),
        ),
      ],
    );
  }
}