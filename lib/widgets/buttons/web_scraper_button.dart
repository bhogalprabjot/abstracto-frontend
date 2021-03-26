import 'dart:io';

import 'package:flutter/material.dart';

class WebScraperButton extends StatelessWidget {
  // Function scrapeURL, getSummary;
  // WebScraperButton(this.scrapeURL, this.getSummary);
  Function _runUrl;

  WebScraperButton(this._runUrl);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      // onPressed: () {
      //   // scrapeURL();
      //   // getSummary();
      // },
      onPressed: _runUrl,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "SCRAPPER",
            style: TextStyle(
              color: Colors.cyan[600],
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
