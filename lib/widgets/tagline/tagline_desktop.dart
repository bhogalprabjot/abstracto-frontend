import 'package:flutter/material.dart';

class TaglineDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 127,
      decoration: BoxDecoration(
        color: Colors.grey[700],
        border: Border.symmetric(
            vertical: BorderSide.none,
            horizontal: BorderSide(color: Colors.cyan, width: 3.0)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Select input type, click on",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              Text(
                " « ABSTRACTO » ",
                style: TextStyle(
                  color: Colors.cyan[600],
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     Text(
          //       "To scrape a url and summarize it, click on",
          //       style: TextStyle(
          //         color: Colors.white,
          //         fontSize: 20.0,
          //       ),
          //     ),
          //     Text(
          //       " « SCRAPPER » ",
          //       style: TextStyle(
          //         color: Colors.cyan[600],
          //         fontSize: 20.0,
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
