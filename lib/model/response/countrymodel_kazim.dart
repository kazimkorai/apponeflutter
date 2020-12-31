class  CountryKazim
{
  String _id;
  String _name;

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  CountryKazim(this._id, this._name);

  String get name => _name;

  set name(String value) {
    _name = value;
  }
}