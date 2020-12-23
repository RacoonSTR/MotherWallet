class Spending {
  int id;
  int value;
  DateTime date;
  String comment;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{
      'value': value,
    };

    if (id != null) map['id'] = id;
    if (date != null) map['date'] = date.toString();
    if (comment != null) map['comment'] = comment;

    return map;
  }

  Spending({
    this.id,
    this.value,
    this.date,
    this.comment,
  });

  Spending.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    date = map['date'] != null ? DateTime.parse(map['date']) : null;
    value = map['value'];
    comment = map['comment'];
  }
}
