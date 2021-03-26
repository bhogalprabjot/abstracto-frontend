import 'package:flutter/material.dart';

class TaglineMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 127,
      decoration: BoxDecoration(
        color: Colors.grey[700],
        border: Border.symmetric(
            vertical: BorderSide.none,
            horizontal: BorderSide(color: Colors.cyan, width: 3.0)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "To summarize an article,  ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
              Text(
                "click on",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
              Text(
                "« ABSTRACTO » ",
                style: TextStyle(
                  color: Colors.cyan[600],
                  fontSize: 18.0,
                ),
              ),
              Text(
                "To scrape a url and ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
              Text(
                "summarize it, click on",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
              Text(
                "« SCRAPPER » ",
                style: TextStyle(
                  color: Colors.cyan[600],
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
