import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class Utils {
  static Future<bool> dialogCommon(BuildContext context, String title,
      String message, bool isSingle, onPress,
      [String confirmButtonText = ""]) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        if (Platform.isIOS) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              if (!isSingle)
                TextButton(
                  child: const Text("Отмена"),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
              TextButton(
                onPressed: onPress,
                child: Text(
                  confirmButtonText.isEmpty
                      ? "Подтверждать"
                      : confirmButtonText,
                ),
              )
            ],
          );
        } else {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              if (!isSingle)
                TextButton(
                  child: const Text(
                    "Отмена",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
              TextButton(
                onPressed: onPress,
                child: Text(
                  confirmButtonText.isEmpty
                      ? "Подтверждать"
                      : confirmButtonText,
                  style: TextStyle(
                    color: confirmButtonText.isEmpty ? Colors.blue : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }

  static ReadMoreText readMoreText(String definition) {
    return ReadMoreText(
      definition,
      style: const TextStyle(color: Colors.black, fontSize: 15),
      moreStyle: const TextStyle(color: Colors.blue, fontSize: 14),
      trimLines: 2,
      colorClickableText: Colors.blue,
      trimMode: TrimMode.Line,
      trimCollapsedText: 'Читать далее',
      trimExpandedText: ' Показать меньше',
    );
  }
}

extension ElevationOffsetWidgets on Widget {
  Container putElevationOffset({elevation, radius, x, y}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
              offset: Offset(x, y), color: Colors.grey, blurRadius: elevation),
        ],
      ),
      child: this,
    );
  }
}

extension OnTapWidgets on Widget {
  GestureDetector putTap(Function() function) {
    return GestureDetector(
      onTap: function,
      child: this,
    );
  }
}
