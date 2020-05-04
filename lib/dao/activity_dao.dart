import 'package:activities/dao/generic_dao.dart';
import 'package:activities/model/activity.dart';

class ActivityDao extends GenericDao<Activity> {
  @override
  String get tableName => "activity";

  @override
  Activity fromMap(Map<String, dynamic> map) {
    return Activity.fromMap(map);
  }

  Future<List<Activity>> findAllByDone(bool status) {
    int done = status ? 1 : 0;
    return query('select * from activity where done = ?', [done]);
  }

}