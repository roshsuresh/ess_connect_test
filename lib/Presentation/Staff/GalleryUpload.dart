import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';

import '../../Constants.dart';
import '../../utils/constants.dart';

class StaffGallery extends StatelessWidget {
  const StaffGallery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Gallery'),
              titleSpacing: 20.0,
              centerTitle: true,
              toolbarHeight: 40,
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
              StaffGalleryUPload(),
              StaffGalleryView(),
            ])));
  }
}

class StaffGalleryUPload extends StatefulWidget {
  const StaffGalleryUPload({Key? key}) : super(key: key);

  @override
  State<StaffGalleryUPload> createState() => _StaffGalleryUPloadState();
}

class _StaffGalleryUPloadState extends State<StaffGalleryUPload> {
  DateTime? _mydatetime;

  String? date;

  DateTime? _mydatetimeFrom;

  DateTime? _mydatetimeTo;

  String time = '--';

  String timeNow = '--';

  String? checkname;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    date = DateFormat('dd-MM-yyyy').format(DateTime.now());
    return ListView(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
                minWidth: size.width - 200,
                color: Colors.white70,
                child: Text('Date: ${date.toString()}'),
                onPressed: () async {
                  _mydatetime = await showDatePicker(
                      context: context,
                      initialDate: _mydatetime ?? DateTime.now(),
                      firstDate: DateTime.now().subtract(Duration(days: 0)),
                      lastDate: DateTime(2030));
                }),
            Spacer(),
            MaterialButton(
              minWidth: size.width - 200,
              child: Row(
                children: [
                  const Text('Select Category'),
                ],
              ),
              color: Colors.white70,
              onPressed: (() {}),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            minLines: 1,
            maxLines: 3,
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
                    allowedExtensions: ['png', 'jpeg', 'jpg']);
                if (result == null) {
                  return;
                }
                final file = result.files.first;
                print('Name: ${file.name}');
                print('Path: ${file.path}');
                print('Extension: ${file.extension}');
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
          children: [
            MaterialButton(
              minWidth: size.width - 200,
              child: Center(child: Text('From  ${time}')),
              color: Colors.white,
              onPressed: (() async {
                _mydatetimeFrom = await showDatePicker(
                    context: context,
                    initialDate: _mydatetimeFrom ?? DateTime.now(),
                    firstDate: DateTime.now().subtract(Duration(days: 0)),
                    lastDate: DateTime(2030));
                setState(() {
                  time = DateFormat('dd-MM-yy').format(_mydatetimeFrom!);
                  print(_mydatetimeFrom);
                });
              }),
            ),
            Spacer(),
            MaterialButton(
              minWidth: size.width - 200,
              child: Center(child: Text('To  ${timeNow}')),
              color: Colors.white,
              onPressed: (() async {
                _mydatetimeTo = await showDatePicker(
                    context: context,
                    initialDate: _mydatetimeTo ?? DateTime.now(),
                    firstDate: DateTime.now().subtract(Duration(days: 0)),
                    lastDate: DateTime(2030));
                setState(() {
                  timeNow = DateFormat('dd-MM-yy').format(_mydatetimeTo!);
                  print(_mydatetimeTo);
                });
              }),
            ),
          ],
        ),
        Row(
          children: [
            MaterialButton(
              minWidth: size.width - 200,
              child: Row(
                children: [
                  Text('Select Course'),
                ],
              ),
              color: Colors.white70,
              onPressed: (() {}),
            ),
            Spacer(),
            MaterialButton(
              minWidth: size.width - 200,
              child: Row(
                children: [
                  const Text('Select Division'),
                ],
              ),
              color: Colors.white70,
              onPressed: (() {}),
            ),
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
              onPressed: (() {}),
            ),
          ),
        ),
      ],
    );
  }

  void openFile(PlatformFile file) {
    OpenFile.open(file.path);
  }
}

class StaffGalleryView extends StatelessWidget {
  const StaffGalleryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}