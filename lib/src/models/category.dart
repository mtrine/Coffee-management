class Category{
  late final String _id;
  late final String _name;

  Category(this._id, this._name);

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }
}