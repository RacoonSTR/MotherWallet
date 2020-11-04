class Pay {
  int id;
  int value;
  DateTime startDate, endDate;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{'value': value};

    if (id != null) map['id'] = id;
    if (startDate != null) map['start_date'] = startDate.toString();
    if (endDate != null) map['end_date'] = endDate.toString();

    return map;
  }

  Pay({this.id, this.value, this.startDate, this.endDate});

  Pay.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    value = map['value'];
    startDate =
        map['start_date'] != null ? DateTime.parse(map['start_date']) : null;
    endDate = map['end_date'] != null ? DateTime.parse(map['end_date']) : null;
  }
}
