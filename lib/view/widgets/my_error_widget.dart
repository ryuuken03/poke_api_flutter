import 'package:flutter/material.dart';

class MyErrorWidget extends StatelessWidget {
  final Function() refreshCallBack;
  final bool isConnection;

  const MyErrorWidget({
    required this.refreshCallBack,
    this.isConnection = false,
    super.key
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '😔',
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 14.0),
            child: Text(
              '${getErrorText(context)}',
              textAlign: TextAlign.center,
              style: TextStyle(
                // color: Theme.of(context).textTheme.headline6.color,
                color: Colors.red,
                fontSize: 17.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            child: ElevatedButton(
              onPressed: refreshCallBack,
              // color: Theme.of(context).accentColor,
              // shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.circular(5.0),
              // ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              child: Text(
                'Try again',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  getErrorText(BuildContext context) {
    if (isConnection) {
      return 'Connection problems';
    } else {
      return 'An error occurred';
    }
  }
}