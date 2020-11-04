class Spending {
  int id;
  int value;
  String comment;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{
      'value': value,
    };

    if (id != null) map['id'] = id;
    if (comment != null) map['comment'] = comment;

    return map;
  }

  Spending();

  Spending.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    value = map['value'];
    comment = map['comment'];
  }
}
