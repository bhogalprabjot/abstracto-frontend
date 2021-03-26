import 'package:flutter/material.dart';

class AbstractoButton extends StatelessWidget {
  // Function getSummary, postArticle;
  // AbstractoButton(this.getSummary, this.postArticle);
  Function _abstracto;
  AbstractoButton(this._abstracto);
  @override
  Widget build(BuildContext context) {
    return TextButton(
      // onPressed: () {
      //   postArticle();
      //   getSummary();
      // },
      onPressed: _abstracto,
      child: Tooltip(
        height: 50,
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(),
            borderRadius: BorderRadius.circular(5)),
        message: "Press this button to get summary.",
        textStyle: TextStyle(
          color: Colors.cyan[600],
          fontSize: 18,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            // color: Colors.cyan,
            border: Border.all(),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
              child: Text(
                "ABSTRACTO",
                style: TextStyle(
                  color: Colors.cyan[600],
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
