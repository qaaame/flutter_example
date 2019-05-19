class Header {

  int id;
//  String _firstName;
//  String _lastName;
//  String _dob;

  String _title;
  String _level;
  double _indicatorValue;
  int _price;
  String _content;

  Header(
//      this._firstName, this._lastName, this._dob ,
      this._title, this._level, this._indicatorValue, this._price, this._content);

  Header.map(dynamic obj) {
//    this._firstName = obj["firstname"];
//    this._lastName = obj["lastname"];
//    this._dob = obj["dob"];

    this._title = obj["title"];
    this._level = obj["level"];
    this._indicatorValue = obj["indicatorValue"];
    this._price= obj["price"];
    this._content= obj["content"];

  }

//  String get firstName => _firstName;
//  String get lastName => _lastName;
//  String get dob => _dob;
  String get title => _title;
  String get level => _level;
  double get indicatorValue => _indicatorValue;
  int get price => _price;
  String get content => _content;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
//    map["firstname"] = _firstName;
//    map["lastname"] = _lastName;
//    map["dob"] = _dob;
    map["title"] = _title;
    map["level"] = _level;
    map["indicatorValue"] = _indicatorValue;
    map["price"] = _price;
    map["content"] = _content;
    return map;
  }
  void setUserId(int id) {
    this.id = id;
  }
}