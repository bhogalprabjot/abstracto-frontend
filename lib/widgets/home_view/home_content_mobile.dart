import 'dart:async';
import 'dart:convert';

import 'package:abstracto_frontend/models/summary.dart';
import 'package:abstracto_frontend/widgets/buttons/abstracto_button.dart';
import 'package:abstracto_frontend/widgets/buttons/web_scraper_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class HomeContentMobile extends StatefulWidget {
  @override
  _HomeContentMobileState createState() => _HomeContentMobileState();
}

class _HomeContentMobileState extends State<HomeContentMobile> {
  //to store the current value of summary
  Summary _currentSummary;
  int _value = 1;
  final inputController = TextEditingController();

  void dispose() {
    // Clean up the controller when the widget is disposed.
    inputController.dispose();
    super.dispose();
  }

  //to handle the get request
  _handleGetSummary() async {
    try {
      var url = Uri.https('127.0.0.1:5000', '/summary');
      //use http version 0.12.2
      http.Response response = await http.get(
        url,
      );
      // print(response);
      if (response.statusCode == 200) {
        // Summary summary = Summary.fromJson(response.body);
        Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
        Summary responseSummary = Summary.fromMap(jsonResponse);
        // print(jsonResponse['summary']);
        // print(summary.responseSummary);
        setState(() {
          _currentSummary = responseSummary;
        });
      }
    } catch (err, stacktrace) {
      print(err);
      print(stacktrace);
    }
  }

  _handlePostUrl() async {
    try {
      // print(inputController.text);
      var url = Uri.https('127.0.0.1:5000', '/scrapper');

      final responseUrl = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'url': inputController.text}),
        // if(responseUrl)
      );
    } catch (err, stacktrace) {
      print(err);
      print(stacktrace);
    }
  }

  _handlePostArticle() async {
    try {
      // print(inputController.text);
      var url = Uri.https('127.0.0.1:5000', '/article');

      final responseArticle = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'article': inputController.text}),
      );
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
      default:
        _runArticle();
    }
  }

  _runArticle() {
    _handlePostArticle();
    Timer(Duration(seconds: 1), () {
      _handleGetSummary();
    });
  }

  _runURL() {
    _handlePostUrl();
    Timer(Duration(seconds: 1), () {
      _handleGetSummary();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[700],
              borderRadius: BorderRadius.circular(10),
            ),
            width: 650,
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
                      Row(
                        children: [
                          // WebScraperButton(_runURL),
                          AbstractoButton(_abstracto),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
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
                            hintText: 'Enter an article to summarize',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
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
            // width: 0.4 * MediaQuery.of(context).size.width,
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
                      mainAxisSize: MainAxisSize.max,
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
                      width: 0.9 * MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          _currentSummary != null
                              ? _currentSummary.summary
                              : "Output Screen",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
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
