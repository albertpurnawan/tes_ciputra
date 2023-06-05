import 'package:tes_ciputra/Model/elixirs.dart';

class parentelixirs {
  String id;
  String firstName;
  String lastName;
  List<elixirs> detail;

  parentelixirs(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.detail});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  factory parentelixirs.fromMap(Map<String, dynamic> map) {
    return parentelixirs(
        id: map['id'] ?? '',
        firstName: map['firstName'] ?? '',
        lastName: map['lastName'] ?? '',
        detail: getElixir(map));
  }

  static List<elixirs> getElixir(Map<String, dynamic> map) {
    List<elixirs> list = [];
    var substores = map['elixirs'];
    final sublength = substores.length;
    for (var j = 0; j < sublength; j++) {
      list.add(elixirs.fromMap(substores[j]));
    }
    return list;
  }
}
