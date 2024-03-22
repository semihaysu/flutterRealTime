import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutterrealtime/Api/Api.dart';
import 'package:flutterrealtime/Pages/HomePage.dart';
import 'package:flutterrealtime/Providers/Providers/UserProvider.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import 'dart:async';

import 'package:http/http.dart' as http;

import '../Constant/ShareFunctions.dart';
import '../Widgets/DropDown.dart';

bool isLoginLoad = false;

String email = '';
String password = '';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passEditingController = TextEditingController();
  bool _isChecked = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? dropdownSelectedValue;

  @override
  void initState() {
    super.initState();
    _loadSavedLoginCredentials();
  }

  void _loadSavedLoginCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? remail = prefs.getString('email');
    String? rpassword = prefs.getString('password');
    if (remail != null && rpassword != null) {
      setState(() {
        email = remail;
        password = rpassword;
        _emailEditingController.text = remail;
        _passEditingController.text = rpassword;
        _isChecked = true;
      });
    }
  }

  void _saveLoginCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_isChecked) {
      await prefs.setString('email', _emailEditingController.text);
      await prefs.setString('password', _passEditingController.text);
    } else {
      await prefs.remove('email');
      await prefs.remove('password');
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return MaterialApp(
        home: Container(
      decoration: const BoxDecoration(
          /*gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Colors.blue,
          Colors.deepOrangeAccent,
        ],
      )*/
          ),
      child: Scaffold(

          //backgroundColor: Colors.transparent,
          body: SafeArea(child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
        final double maxWidth = constraints.maxWidth;
        final double maxHeight = constraints.maxHeight;

        return Center(
          child: Form(
            key: _formKey,
            child: AnimateGradient(
              primaryBegin: Alignment.topLeft,
              primaryEnd: Alignment.bottomLeft,
              secondaryBegin: Alignment.bottomLeft,
              secondaryEnd: Alignment.topRight,
              primaryColors: const [
                Colors.deepOrange,
                Colors.deepOrangeAccent,
                Colors.grey,
              ],
              secondaryColors: const [
                Colors.grey,
                Colors.blueAccent,
                Colors.blue,
              ],
              child: SafeArea(
                child: Center(
                  child: Card(
                    color: Colors.white.withOpacity(0.4),
                    elevation: 20,
                    shadowColor: Colors.black,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: SizedBox(
                      width: maxWidth * 0.9,
                      height: maxHeight * 0.95,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage('assets/easylogo.png'),
                            height: maxHeight * 0.1,
                          ),
                          SizedBox(
                            height: maxHeight * 0.01,
                          ),
                          const Text('Hoş Geldiniz',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 36)),
                          SizedBox(
                            height: maxHeight * 0.01,
                          ),
                          const Text(
                            "Lütfen kullanıcı girişi yapınız",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: maxHeight * 0.01,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: _emailEditingController,
                                  onChanged: (value) {
                                    email = value;
                                  },
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Kullanıcı Adınız',
                                      hintStyle: TextStyle(
                                        fontSize: 14,
                                      )),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: _passEditingController,
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: true,
                                  onChanged: (value) {
                                    password = value;
                                  },
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Şifreniz',
                                      hintStyle: TextStyle(
                                        fontSize: 14,
                                      )),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: DropdownItem(
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownSelectedValue = newValue;
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 35),
                            child: CheckboxListTile(
                              title: const Text('Beni Hatırla'),
                              value: _isChecked,
                              onChanged: (value) {
                                setState(() {
                                  _isChecked = value!;
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Container(
                              margin: const EdgeInsets.only(
                                  left: 0, bottom: 10, right: 0, top: 20),
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Colors.deepOrange,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: TextButton(
                                child: isLoginLoad
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : const Text('Giriş',
                                        style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.white,
                                        )),
                                onPressed: () async {
                                  setState(() {
                                    isLoginLoad = true;
                                    _saveLoginCredentials();
                                  });
                                  try {
                                    if (dropdownSelectedValue == null) {
                                      shareFunction().showAlertSimple(context,
                                          " ", "İşletme Seçiniz", "Tamam");
                                      setState(() {
                                        isLoginLoad = false;
                                      });
                                      return;
                                    }
                                    String gelenbody = await Api()
                                        .fetchloginkontrol(email, password,
                                            dropdownSelectedValue);
                                    // ignore: use_build_context_synchronously
                                    Provider.of<UserProvider>(context,
                                            listen: false)
                                        .setGelenBody(gelenbody);
                                    // ignore: use_build_context_synchronously
                                    Provider.of<UserProvider>(context,
                                            listen: false)
                                        .setIsletme(dropdownSelectedValue!);
                                    Provider.of<UserProvider>(context,
                                            listen: false)
                                        .setEmail(email);
                                    Provider.of<UserProvider>(context,
                                            listen: false)
                                        .setPassword(password);
                                    Provider.of<UserProvider>(context,
                                            listen: false)
                                        .setUserDealer(dropdownSelectedValue!);
//düzenle
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage(
                                              isletmeadi: (dropdownSelectedValue !=
                                                          null &&
                                                      dropdownSelectedValue!
                                                              .length >=
                                                          1)
                                                  ? (dropdownSelectedValue!
                                                              .toString() ==
                                                          "http://sb.saloonburger.com.tr"
                                                      ? "Saloon Burger"
                                                      : (dropdownSelectedValue!
                                                                  .toString() ==
                                                              "someValue"
                                                          ? "Pizza Lazza "
                                                          : "Pizza V"))
                                                  : "Pizza V")),
                                    );
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomePage(
                                            isletmeadi: (dropdownSelectedValue !=
                                                        null &&
                                                    dropdownSelectedValue!
                                                            .length >=
                                                        1)
                                                ? (dropdownSelectedValue!
                                                            .toString() ==
                                                        "http://sb.saloonburger.com.tr"
                                                    ? "Saloon Burger"
                                                    : (dropdownSelectedValue!
                                                                .toString() ==
                                                            "someValue"
                                                        ? "Pizza Lazza "
                                                        : "Pizza V"))
                                                : "Pizza V"),
                                      ),
                                      (route) => false, // Tüm sayfaları kapat
                                    );
                                  } catch (error) {
                                    shareFunction().showAlertSimple(
                                        context,
                                        "hata",
                                        "Kullanıcı Başarılı Değil",
                                        "Tamam");
                                    setState(() {
                                      isLoginLoad = false;
                                    });
                                    print("HataCath: $error");
                                    // Hata durumunu kullanıcıya bildirebilir veya başka bir işlem yapabilirsiniz.
                                  }
                                },
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
          ),
        );
      }))),
    ));
  }
}
