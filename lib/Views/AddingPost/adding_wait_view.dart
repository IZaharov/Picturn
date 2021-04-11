import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddingWaitView extends StatelessWidget {
  double _height;

  AddingWaitView(this._height);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, _height * 0.4, 0, 0),
      child: Center(
        child: Column(
          children: [
            Text(
              'Отправляем пост',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: CircularProgressIndicator(
                strokeWidth: 6.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
