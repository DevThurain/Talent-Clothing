import 'package:hive/hive.dart';
import 'package:talent_clothing/persistent/hive_constants.dart';
part 'user_data.g.dart';

@HiveType(typeId: HiveConstants.HIVE_TYPE_USER_DATA, adapterName: 'UserDataAdapter')
class UserData {
  @HiveField(0)
  late String number;

  @HiveField(1)
  late String dateTime;

  UserData({
    required this.number,
    required this.dateTime,
  });

  UserData.fromJson(int index,Map<String, dynamic> json) {
    var test = json.keys.toList()[index];
    number = json[test]['number'];
    dateTime = json[test]['dateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = this.number;
    data['dateTime'] = this.dateTime;
    return data;
  }
}
