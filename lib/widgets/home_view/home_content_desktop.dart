import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'package:abstracto_frontend/models/summary.dart';
import 'package:abstracto_frontend/widgets/buttons/abstracto_button.dart';
import 'package:abstracto_frontend/widgets/buttons/web_scraper_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';

class HomeContentDesktop extends StatefulWidget {
  @override
  _HomeContentDesktopState createState() => _HomeContentDesktopState();
}

class _HomeContentDesktopState extends State<HomeContentDesktop> {
  Summary _currentSummary;
  String _error = null;

  final _storage = FirebaseStorage.instance;
  String _imgStatus = "";
  String _imageID = "";
  String _imgUrl;
  int _value = 1;
  String _deployedUrl = "127.0.0.1:5000";

  final inputController = TextEditingController();
  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  _handleGetSummary() async {
    try {
      var url = Uri.http(_deployedUrl, '/summary');
      http.Response response = await http.get(
        url,
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
        Summary responseSummary = Summary.fromMap(jsonResponse);

        setState(() {
          _currentSummary = responseSummary;
          _error = null;
        });
      } else {
        setState(() {
          _error = "Invalid text";
        });
      }
    } catch (err, stacktrace) {
      print(err);
      print(stacktrace);
    }
  }

  _handlePostUrl() async {
    try {
      var url = Uri.http(_deployedUrl, '/scrapper');
      final responseUrl = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, String>{'url': inputController.text, 'error': null}),
      );
      if (responseUrl.statusCode != 200) {
        setState(() {
          _error = "Invalid url";
        });
      }
      return responseUrl;
    } catch (err, stacktrace) {
      print(err);
      print(stacktrace);
    }
  }

  _handlePostArticle() async {
    try {
      var url = Uri.http(_deployedUrl, '/article');

      final responseArticle = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'article': inputController.text}),
      );
      // print(responseArticle.body);
      return responseArticle;
    } catch (err, stacktrace) {
      print(err);
      print(stacktrace);
    }
  }

  _handlePostImage() async {
    try {
      var url = Uri.http(_deployedUrl, '/image');

      final responseImage = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'imageUrl': _imgUrl}),
      );
      if (responseImage.statusCode != 200) {
        setState(() {
          _error = "Invalid image";
        });
      }
      return responseImage;
    } catch (err, stacktrace) {
      print(err);
      print(stacktrace);
    }
  }

  _abstracto() {
    switch (_value) {
      case 1:
        {
          _runArticle();
          break;
        }
      case 2:
        {
          _runURL();
          break;
        }
      case 3:
        {
          _runImage();
          break;
        }
      default:
        _runArticle();
    }
  }

  _runArticle() async {
    var res = await _handlePostArticle();
    if (res.statusCode == 201) _handleGetSummary();
  }

  _runURL() async {
    var res = await _handlePostUrl();
    if (res.statusCode == 201) _handleGetSummary();
  }

  _runImage() async {
    var res = await _handlePostImage();
    setState(() {
      _imgUrl = null;
    });
    if (res.statusCode == 201) _handleGetSummary();
  }

  _uploadToStorage() {
    InputElement input = FileUploadInputElement()..accept = 'image/*';
    input.click();
    input.onChange.listen((event) {
      final file = input.files.first;
      final reader = FileReader();
      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((event) async {
        Reference reference = FirebaseStorage.instance
            .ref('gs://abstracto-db.appspot.com')
            .child(Uuid().v1());
        final UploadTask uploadTask = reference.putBlob(file);
        uploadTask.whenComplete(() async {
          String imageUrl = await uploadTask.snapshot.ref.getDownloadURL();
          setState(() {
            _imgStatus = "Click Abstracto!";
            _imgUrl = imageUrl;
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[700],
              borderRadius: BorderRadius.circular(10),
            ),
            width: 0.4 * MediaQuery.of(context).size.width,
            height: 500,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          // color: Colors.cyan,
                          border: Border.all(),
                        ),
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: DropdownButtonHideUnderline(
                          child: Tooltip(
                            height: 50,
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(5)),
                            message: "Select input type.",
                            textStyle: TextStyle(
                              color: Colors.cyan[600],
                              fontSize: 18,
                            ),
                            child: DropdownButton(
                                dropdownColor: Colors.grey[700],
                                iconEnabledColor: Colors.cyan,
                                value: _value,
                                items: [
                                  DropdownMenuItem(
                                    child: Text(
                                      "Text",
                                      style: TextStyle(
                                        color: Colors.cyan[600],
                                        fontSize: 18,
                                      ),
                                    ),
                                    value: 1,
                                  ),
                                  DropdownMenuItem(
                                    child: Text(
                                      "Url",
                                      style: TextStyle(
                                        color: Colors.cyan[600],
                                        fontSize: 18,
                                      ),
                                    ),
                                    value: 2,
                                  ),
                                  DropdownMenuItem(
                                    child: Text(
                                      "Image",
                                      style: TextStyle(
                                        color: Colors.cyan[600],
                                        fontSize: 18,
                                      ),
                                    ),
                                    value: 3,
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _value = value;
                                  });
                                }),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          // WebScraperButton(_runURL),
                          // AbstractoButton(_runArticle),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                            child: AbstractoButton(_abstracto),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                _value != 3
                    ? Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 325,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.black,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: inputController,
                                maxLines: null,
                                // expands: true,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter an article or url.',
                                  hintMaxLines: 2,
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 325,
                            width: 0.4 * MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.black,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _imgUrl == null
                                    ? Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: ElevatedButton(
                                            onPressed: () {
                                              // _uploadImage();
                                              _uploadToStorage();
                                            },
                                            child: Text(
                                              "Upload",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Text(
                                        _imgStatus,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[700],
              borderRadius: BorderRadius.circular(10),
            ),
            width: 0.4 * MediaQuery.of(context).size.width,
            height: 500,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Summary :",
                          style: TextStyle(
                            color: Colors.cyan[600],
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 325,
                      width: 0.4 * MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black,
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _error == null
                              ? Text(
                                  _currentSummary != null
                                      ? _currentSummary.summary
                                      : "Output Screen",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  _error,
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
