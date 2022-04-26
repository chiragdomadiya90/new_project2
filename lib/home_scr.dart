import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:new_project2/ts.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'model/user.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<UserModel> getData() async {
    http.Response response = await http.get(Uri.parse(
        'https://codelineinfotech.com/student_api/User/allusers.php'));
    print('Response ===> ${jsonDecode(response.body)}');
    return userModelFromJson(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: 100.h,
          width: 100.w,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.lightBlueAccent.shade100,
                Colors.white,
                Colors.white,
                Colors.white,
                Colors.lightBlueAccent.shade100,
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 20.h,
                    width: 100.w,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xff4DC6FD),
                            Color(0xff00CCCB),
                          ]),
                    ),
                    child: Center(
                      child: Ts(
                        text: ('Find Your Doctor'),
                        size: 25.sp,
                        color: Colors.white,
                        weight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const Positioned(
                    bottom: -35,
                    right: 0,
                    left: 0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: TextField(
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            counter: Offstage(),
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: Icon(Icons.search),
                            suffixIcon: Icon(Icons.close),
                            hintText: 'Search',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 30.sp,
              ),
              Service(),
              SizedBox(
                height: 20.sp,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Ts(
                  text: 'Popular Doctor',
                  weight: FontWeight.w900,
                ),
              ),
              SizedBox(
                height: 10.sp,
              ),
              FutureBuilder(
                future: getData(),
                builder: (context, AsyncSnapshot<UserModel> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Expanded(
                      child: GridView.builder(
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        itemCount: snapshot.data!.users!.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisExtent: 250,
                                mainAxisSpacing: 3,
                                crossAxisSpacing: 3),
                        itemBuilder: (context, index) {
                          final userinfo = snapshot.data!.users![index];

                          return Card(
                            child: Column(
                              children: [
                                Container(
                                  height: 164,
                                  width: 160,
                                  child: Image.network(
                                    "${userinfo.avatar}",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                SizedBox(
                                  height: 8.sp,
                                ),
                                Ts(
                                  text: '${userinfo.username}',
                                  size: 18.0,
                                  weight: FontWeight.w900,
                                ),
                                SizedBox(
                                  height: 5.sp,
                                ),
                                Ts(
                                  text: '${userinfo.lastName}',
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Service extends StatelessWidget {
  List<Map<String, dynamic>> service = [
    {
      'img': 'assets/photo/4.png',
      "color1": Color(0xff2753F3),
      "color2": Color(0xff765AFC),
      'name': 'Dental'
    },
    {
      'img': 'assets/photo/3.png',
      "color1": Color(0xff0EBE7E),
      "color2": Color(0xff07D9AD),
      'name': 'Cardiologist'
    },
    {
      'img': 'assets/photo/2.png',
      "color1": Color(0xffFE7F44),
      "color2": Color(0xffFFCF68),
      'name': 'Eye Specialist'
    },
    {
      'img': 'assets/photo/1.png',
      "color1": Color(0xffFF484C),
      "color2": Color(0xffFF6C60),
      'name': 'Skin Specialist'
    }
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          service.length,
          (index) => Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  height: 90,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        service[index]['color1'],
                        service[index]['color2']
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Image.asset(
                      service[index]['img'],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 7.sp,
              ),
              Ts(
                text: service[index]['name'],
                weight: FontWeight.w900,
                size: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
