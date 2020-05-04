import 'package:activities/sql/entity.dart';
import 'dart:convert' as convert;

class Activity extends Entity {
  int id;
  String description;
  bool done;
  String date_hour_done;
  bool daily;

  Activity({
    this.id,
    this.description,
    this.done,
    this.date_hour_done,
    this.daily
  }); 

  Activity.fromMap(Map<String,dynamic> map) {
    id = map['id'];
    description = map['description'];
    done = map['done']==1?true:false;
    date_hour_done = map['date_hour_done'];
    daily = map['daily']==1?true:false;
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['description'] = this.description;
    data['done'] = this.done;
    data['date_hour_done'] = this.date_hour_done;
    data['daily'] = this.daily;

    return data;
  }

  @override
  String toJson() {
    String json = convert.json.encode(toMap());
    return json;
  }

}