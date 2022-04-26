import 'dart:io';
import 'dart:math';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_project2/firebase_service/firebase_auth_service.dart';
import 'package:new_project2/home_scr.dart';
import 'package:new_project2/ts.dart';
import 'package:sizer/sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'firebase_service/constant.dart';

class User_Profile_Scr extends StatefulWidget {
  const User_Profile_Scr({Key? key}) : super(key: key);

  @override
  State<User_Profile_Scr> createState() => _User_Profile_ScrState();
}

class _User_Profile_ScrState extends State<User_Profile_Scr> {
  TextEditingController? _first;
  TextEditingController? _last;
  TextEditingController? _email;
  TextEditingController? _mob;
  TextEditingController? _password;
  final _formKey = GlobalKey<FormState>();
  bool visable = true;

  String _selectedGender = 'male';
  bool selectHobbies = true;
  bool selectHobbies1 = false;

  File? _image;
  final picker = ImagePicker();

  Future pickedImage() async {
    final imagePicked = await picker.getImage(source: ImageSource.gallery);

    if (imagePicked != null) {
      setState(() {
        _image = File(imagePicked.path);
      });
    }
  }

  Future<String?> uploadFile({File? file, String? filename}) async {
    print("file path===>>$file");
    try {
      var response = await storage.ref("filename==>>$filename").putFile(file!);

      return response.storage.ref("filename==>>$filename").getDownloadURL();
    } on firebase_storage.FirebaseException catch (e) {
      print(e);
    }
  } //upload file mate(2nd step)

  Future addUser() async {
    String? imageUrl = await uploadFile(
        file: _image!,
        filename:
            "${Random().nextInt(1000)}${kFirebaseAuth.currentUser!.email}");

    userCollection.doc(kFirebaseAuth.currentUser!.uid).set({
      'first_name': _first!.text,
      'last_name': _last!.text,
      'mobile_num': _mob!.text,
      'password': _password!.text,
      'hobbies': selectHobbies && selectHobbies1
          ? 'Singing' 'Dancing'
          : selectHobbies
              ? 'Singing'
              : 'Dancing',
      'gender': _selectedGender,
      'email': _email!.text,
      'image': imageUrl,
    }).catchError((e) {
      print("ERROR==>>>$e");
    });
  } // userdata add karavva

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
          )),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.sp,
                    ),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        GestureDetector(
                          onTap: () {
                            pickedImage();
                          },
                          child: Container(
                            height: 120.sp,
                            width: 120.sp,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                border:
                                    Border.all(color: Colors.white, width: 3),
                                borderRadius: BorderRadius.circular(20)),
                            child: _image == null
                                ? const Icon(Icons.person)
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.file(
                                      _image!,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                          ),
                        ),
                        Positioned(
                          bottom: -8,
                          right: -8,
                          child: GestureDetector(
                            onTap: () {
                              pickedImage();
                            },
                            child: Container(
                              height: 35.sp,
                              width: 35.sp,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey,
                                border:
                                    Border.all(color: Colors.white, width: 3),
                              ),
                              child: const Icon(Icons.camera_alt),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.sp,
                    ),
                    Ts(
                      text: 'Set Up Your Profile',
                      color: Colors.grey,
                      weight: FontWeight.w900,
                    ),
                    SizedBox(
                      height: 8.sp,
                    ),
                    Ts(
                      text: 'Update your profile to connect your doctor with',
                      color: Colors.grey,
                      size: 13.0,
                    ),
                    Ts(
                      text: 'better impression.',
                      color: Colors.grey,
                      size: 13.0,
                    ),
                    SizedBox(
                      height: 18.sp,
                    ),
                    Row(
                      children: [
                        Ts(
                          text: 'Registration',
                          size: 18.0,
                          weight: FontWeight.w900,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12.sp,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _first,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              counter: const Offstage(),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'First Name',
                              hintStyle: const TextStyle(color: Colors.grey),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.lightBlueAccent, width: 3),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.shade100, width: 1.5),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "First Name can't be Empty";
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          width: 10.sp,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _last,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              counter: const Offstage(),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'Last Name',
                              hintStyle: const TextStyle(color: Colors.grey),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.lightBlueAccent, width: 3),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.shade100, width: 1.5),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Last Name can't be Empty";
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      controller: _email,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        counter: const Offstage(),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Email',
                        hintStyle: const TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.lightBlueAccent, width: 3),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey.shade100, width: 1.5),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Last Name can't be Empty";
                        }
                      },
                    ),
                    TextFormField(
                      controller: _mob,
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        counter: const Offstage(),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Mobile Number',
                        hintStyle: const TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.lightBlueAccent, width: 3),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey.shade100, width: 1.5),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Last Name can't be Empty";
                        }
                      },
                    ),
                    SizedBox(
                      height: 12.sp,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Ts(
                          text: 'Gender',
                          size: 15.sp,
                          color: Colors.grey,
                          weight: FontWeight.w900,
                        ),
                        const Gender(),
                      ],
                    ),
                    SizedBox(
                      height: 12.sp,
                    ),
                    const City(),
                    SizedBox(
                      height: 12.sp,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Ts(
                          text: 'Hobbies',
                          size: 15.sp,
                          color: Colors.grey,
                          weight: FontWeight.w900,
                        ),
                        const Hobbies(),
                      ],
                    ),
                    SizedBox(
                      height: 12.sp,
                    ),
                    TextFormField(
                      controller: _password,
                      obscureText: visable,
                      decoration: InputDecoration(
                        counter: const Offstage(),
                        suffixIcon: IconButton(
                            splashRadius: 20,
                            onPressed: () {
                              setState(() {
                                visable = !visable;
                              });
                            },
                            icon: visable == false
                                ? const Icon(
                                    Icons.visibility,
                                    color: Colors.grey,
                                  )
                                : const Icon(
                                    Icons.visibility_off,
                                    color: Colors.grey,
                                  )),
                        border: InputBorder.none,
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Password',
                        hintStyle: const TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.lightBlueAccent, width: 3),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey.shade100, width: 1.5),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password can not be Empty";
                        }
                      },
                    ),
                    SizedBox(
                      height: 12.sp,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          SharedPreferences email =
                              await SharedPreferences.getInstance();
                          bool? status = await FirebaseAuthServices.signUp(
                            password: _password!.text,
                            email: _email!.text,
                          );
                          if (status == true) {
                            email.setString('email', _email!.text);
                            await addUser().whenComplete(
                              () => Get.to(
                                () => const Home(),
                              ),
                            );
                          }
                        }
                      },
                      child: Container(
                        height: 50.sp,
                        width: 100.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.sp),
                            color: Colors.lightBlueAccent),
                        child: Center(
                          child: Ts(
                            text: 'Submit',
                            weight: FontWeight.w900,
                            color: Colors.white,
                            size: 18.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Gender extends StatefulWidget {
  const Gender({Key? key}) : super(key: key);

  @override
  State<Gender> createState() => _GenderState();
}

class _GenderState extends State<Gender> {
  int isSwitch = 0;

  List<String> gender1 = ['Male', 'Female'];
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...List.generate(
          gender1.length,
          (index) => Row(
            children: [
              GestureDetector(
                  onTap: () {
                    setState(() {
                      isSwitch = index;
                    });
                  },
                  child: Container(
                    height: 15.sp,
                    width: 15.sp,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                        border: Border.all(
                            color: isSwitch == index
                                ? Colors.black
                                : Colors.transparent,
                            width: 5)),
                  )),
              SizedBox(
                width: 8.sp,
              ),
              Ts(
                text: gender1[index],
                color: Colors.grey,
                size: 15.sp,
              ),
              SizedBox(
                width: 18.sp,
              ),
            ],
          ),
        )
      ],
    );
  }
}

class Hobbies extends StatefulWidget {
  const Hobbies({Key? key}) : super(key: key);

  @override
  State<Hobbies> createState() => _HobbiesState();
}

class _HobbiesState extends State<Hobbies> {
  bool isCheckBox = false;
  bool isCheckBox1 = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            Checkbox(
              value: isCheckBox,
              onChanged: (value) {
                setState(() {
                  isCheckBox = value!;
                });
              },
            ),
            Ts(
              text: 'Singing',
              color: Colors.grey,
              size: 15.sp,
            )
          ],
        ),
        Row(
          children: [
            Checkbox(
              value: isCheckBox1,
              onChanged: (value) {
                setState(() {
                  isCheckBox1 = value!;
                });
              },
            ),
            // SizedBox(
            //   width: 8.sp,
            // ),
            Ts(
              text: 'Dancing',
              color: Colors.grey,
              size: 15.sp,
            )
          ],
        ),
      ],
    );
  }
}

class City extends StatefulWidget {
  const City({Key? key}) : super(key: key);

  @override
  State<City> createState() => _CityState();
}

class _CityState extends State<City> {
  List<String> city = ['Surat', 'Rajkot', 'Vadodara', 'Ahmedabad'];
  dynamic selectCity = 'Surat';
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {},
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade100),
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          width: double.infinity,
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              value: selectCity,
              onChanged: (value) {
                setState(
                  () {
                    selectCity = value;
                  },
                );
              },
              items: city
                  .map((e) => DropdownMenuItem(
                        child: Text(e),
                        value: e,
                      ))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
