import 'package:Ess_test/utils/spinkit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Application/StudentProviders/ProfileProvider.dart';
import '../../Constants.dart';
import '../../utils/constants.dart';

class Profile_Info extends StatelessWidget {
  Profile_Info({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<ProfileProvider>(context, listen: false).profileData();
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    const Color background = Colors.white;
    const Color fill1 = Color.fromARGB(255, 109, 128, 236);
    const Color fill2 = UIGuide.light_Purple;
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
      body: Consumer<ProfileProvider>(
        builder: (_, provider, child) {
          return provider.loading
              ? const spinkitLoader()
              : ListView(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 260,
                          width: width,
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              width: width - 50,
                              height: 170,
                              child: Column(
                                children: [
                                  kheight20,
                                  kheight20,
                                  kheight20,
                                  kheight10,
                                  Text(
                                    provider.studName == null
                                        ? '--'
                                        : provider.studName.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  ),
                                  kheight10,
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Table(
                                      border: TableBorder.all(
                                          color: UIGuide.light_Purple,
                                          style: BorderStyle.solid,
                                          width: .5),
                                      children: [
                                        TableRow(children: [
                                          Column(
                                            children: [
                                              const Text('Class',
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.grey)),
                                              Text(
                                                  provider.division == null
                                                      ? '--'
                                                      : provider.division
                                                          .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 16.0)),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              const Text('Roll No',
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.grey)),
                                              Text(
                                                  provider.rollNo == null
                                                      ? '--'
                                                      : provider.rollNo
                                                          .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 16.0)),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              const Text('Adm No',
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.grey)),
                                              Text(
                                                  provider.admissionNo == null
                                                      ? '--'
                                                      : provider.admissionNo
                                                          .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 16.0)),
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
                            backgroundImage: NetworkImage(
                              provider.studPhoto == null
                                  ? 'https://png.pngtree.com/element_our/png/20181129/male-student-icon-png_251938.jpg'
                                  : provider.studPhoto.toString(),
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
                        width: width,
                        height: 370,
                        color: Color.fromARGB(255, 240, 243, 247),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                kWidth,
                                Icon(Icons.person_outline_outlined),
                                kWidth,
                                Text(
                                  'Personal Info',
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                            Container(
                                margin: const EdgeInsets.only(
                                    left: 10.0, right: 20.0),
                                child: const Divider(
                                  color: Colors.black,
                                )),
                            Table(
                              defaultColumnWidth: const FixedColumnWidth(200.0),
                              children: [
                                TableRow(
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.cake_outlined,
                                              size: 22,
                                            ),
                                            kWidth,
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  provider.dob.toString() ==
                                                          null
                                                      ? '--'
                                                      : provider.dob.toString(),
                                                  style: const TextStyle(
                                                      color:
                                                          UIGuide.light_Purple),
                                                ),
                                                const Text(
                                                  'Birthday',
                                                  style: TextStyle(
                                                      color: Colors.black38,
                                                      fontSize: 12),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        kheight10,
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.person_outlined,
                                                  size: 22,
                                                ),
                                                kWidth,
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      provider.gender
                                                          .toString(),
                                                      style: const TextStyle(
                                                        color: UIGuide
                                                            .light_Purple,
                                                      ),
                                                    ),
                                                    const Text(
                                                      'Gender',
                                                      style: TextStyle(
                                                          color: Colors.black38,
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        kheight10,
                                      ],
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.bloodtype_outlined,
                                              size: 22,
                                            ),
                                            kWidth,
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  provider.bloodGroup == null
                                                      ? '--'
                                                      : provider.bloodGroup
                                                          .toString(),
                                                  style: const TextStyle(
                                                    color: UIGuide.light_Purple,
                                                  ),
                                                ),
                                                const Text(
                                                  'Blood Group',
                                                  style: TextStyle(
                                                      color: Colors.black38,
                                                      fontSize: 12),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        kheight10,
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.flag_outlined,
                                                  size: 22,
                                                ),
                                                kWidth,
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      provider.houseGroup ==
                                                              null
                                                          ? '--'
                                                          : provider.houseGroup
                                                              .toString(),
                                                      style: const TextStyle(
                                                        color: UIGuide
                                                            .light_Purple,
                                                      ),
                                                    ),
                                                    const Text(
                                                      'House Group',
                                                      style: TextStyle(
                                                          color: Colors.black38,
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        kheight10,
                                      ],
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.height_outlined,
                                              size: 22,
                                            ),
                                            kWidth,
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  provider.height == null
                                                      ? '0.00'
                                                      : provider.height
                                                          .toString(),
                                                  style: const TextStyle(
                                                    color: UIGuide.light_Purple,
                                                  ),
                                                ),
                                                const Text(
                                                  'Height',
                                                  style: TextStyle(
                                                      color: Colors.black38,
                                                      fontSize: 12),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        kheight10,
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.line_weight_outlined,
                                                  size: 22,
                                                ),
                                                kWidth,
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      provider.weight == null
                                                          ? '0.00'
                                                          : provider.weight
                                                              .toString(),
                                                      style: const TextStyle(
                                                        color: UIGuide
                                                            .light_Purple,
                                                      ),
                                                    ),
                                                    const Text(
                                                      'Weight',
                                                      style: TextStyle(
                                                          color: Colors.black38,
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        kheight10,
                                      ],
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.sticky_note_2_outlined,
                                              size: 22,
                                            ),
                                            kWidth,
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  provider.classTeacher == null
                                                      ? '--'
                                                      : provider.classTeacher
                                                          .toString(),
                                                  style: const TextStyle(
                                                    color: UIGuide.light_Purple,
                                                  ),
                                                ),
                                                const Text(
                                                  'Class Teacher',
                                                  style: TextStyle(
                                                      color: Colors.black38,
                                                      fontSize: 12),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        kheight10,
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.location_on,
                                                  size: 22,
                                                ),
                                                kWidth,
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: const [
                                                    Text(
                                                      '--',
                                                      style: TextStyle(
                                                        color: UIGuide
                                                            .light_Purple,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Birthplace',
                                                      style: TextStyle(
                                                          color: Colors.black38,
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        kheight10,
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Color.fromARGB(255, 230, 237, 245),
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                width: width,
                                height: 115,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        ' Permenent Address',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Flexible(
                                        child: RichText(
                                          overflow: TextOverflow.ellipsis,
                                          strutStyle:
                                              const StrutStyle(fontSize: 13),
                                          maxLines: 4,
                                          text: TextSpan(
                                              style: const TextStyle(
                                                fontSize: 15,
                                                color: UIGuide.light_Purple,
                                              ),
                                              text: provider.address == null
                                                  ? '---'
                                                  : provider.address
                                                      .toString()),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    CarouselSlider(
                      items: [
                        Container(
                          width: width,
                          margin: const EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: UIGuide.light_Purple, width: .5),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5))),
                          child: Column(
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Father (Guardian)',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.black),
                              ),
                              //kheight10,
                              Center(
                                  child: Text(
                                provider.fatherName == null
                                    ? '---'
                                    : provider.fatherName.toString(),
                                style: const TextStyle(
                                    color: UIGuide.light_Purple,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12),
                              )),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.email_outlined,
                                    size: 14,
                                  ),
                                  Flexible(
                                    //overflow
                                    child: RichText(
                                      overflow: TextOverflow.ellipsis,
                                      strutStyle:
                                          const StrutStyle(fontSize: 12.0),
                                      text: TextSpan(
                                          style: const TextStyle(
                                            color: UIGuide.light_Purple,
                                          ),
                                          text: provider.fatherMail == null
                                              ? '--'
                                              : provider.fatherMail),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 60,
                                      height: 80,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: UIGuide.light_Purple,
                                              width: .2),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5))),
                                      child: Image.network(
                                        provider.fatherPhoto == null
                                            ? 'https://cdn1.iconfinder.com/data/icons/instagram-ui-glyph/48/Sed-09-512.png'
                                            : provider.fatherPhoto.toString(),
                                        // color: Color.fromARGB(255, 151, 148, 148)
                                        //     .withOpacity(0.8),
                                        // fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      kheight10,
                                      kheight10,
                                      Row(
                                        children: [
                                          Icon(Icons.phone_android_outlined),
                                          Text(provider.fatherMobileno == null
                                              ? '----'
                                              : '+91 ${provider.fatherMobileno.toString()}')
                                        ],
                                      ),
                                      kheight10,
                                      Row(
                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                        // mainAxisAlignment: MainAxisAlignment.start,
                                        children: const [
                                          Icon(Icons.phone_android_outlined),
                                          Text('+91 ----')
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: width,
                          margin: EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                width: .5,
                                color: UIGuide.light_Purple,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5))),
                          child: Column(
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Mother',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.black),
                              ),
                              //kheight10,
                              Center(
                                  child: Text(
                                provider.motherName == null
                                    ? '---'
                                    : provider.motherName.toString(),
                                style: const TextStyle(
                                    color: UIGuide.light_Purple,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12),
                              )),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.email_outlined,
                                    size: 14,
                                  ),
                                  // Text(
                                  //   'Ravidranath@gmail.com',
                                  //   textAlign: TextAlign.center,
                                  //   style: TextStyle(fontSize: 12),
                                  // )

                                  Flexible(
                                    child: RichText(
                                      overflow: TextOverflow.ellipsis,
                                      strutStyle:
                                          const StrutStyle(fontSize: 12.0),
                                      text: TextSpan(
                                          style: TextStyle(
                                            color: UIGuide.light_Purple,
                                          ),
                                          text: provider.motherMailId == null
                                              ? '---'
                                              : provider.motherMailId
                                                  .toString()),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 60,
                                      height: 80,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: UIGuide.light_Purple,
                                              width: .2),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5))),
                                      child: Image.network(
                                        provider.motherPhoto == null
                                            ? 'https://cdn1.iconfinder.com/data/icons/instagram-ui-glyph/48/Sed-09-512.png'
                                            : provider.motherPhoto.toString(),
                                        // color:
                                        //     const Color.fromARGB(255, 151, 148, 148)
                                        //         .withOpacity(0.8),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      kheight10,
                                      kheight10,
                                      Row(
                                        children: [
                                          const Icon(
                                              Icons.phone_android_outlined),
                                          Text(provider.motherMobileno == null
                                              ? '+91 ----'
                                              : '+91 ${provider.motherMobileno.toString()}')
                                        ],
                                      ),
                                      kheight10,
                                      Row(
                                        children: const [
                                          Icon(Icons.phone_android_outlined),
                                          Text('+91 ----')
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: const DecorationImage(
                              image: NetworkImage(
                                  "https://cdn.vectorstock.com/i/1000x1000/50/63/people-human-together-family-logo-icon-vector-32705063.webp"),
                              //   fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                      ],
                      options: CarouselOptions(
                        height: 180.0,
                        enlargeCenterPage: false,
                        autoPlay: true,
                        aspectRatio: 16 / 9,
                        //  autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        viewportFraction: 0.8,
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
