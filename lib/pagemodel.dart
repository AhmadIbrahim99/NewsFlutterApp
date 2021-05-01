import 'package:flutter/material.dart';

class PageModel {
  String _title;
  String _desc;
  Color _color;
  IconData _iconData;

  PageModel(this._title, this._desc, this._color, this._iconData);

  set iconData(IconData value) {
    _iconData = value;
  }

  set color(Color value) {
    _color = value;
  }

  set desc(String value) {
    _desc = value;
  }

  set title(String value) {
    _title = value;
  }

  IconData get iconData => _iconData;

  Color get color => _color;

  String get desc => _desc;

  String get title => _title;
}
