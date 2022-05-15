import 'package:hive/hive.dart';
import 'package:talent_clothing/persistent/hive_constants.dart';
import 'package:talent_clothing/persistent/models/user_data.dart';

class UserDataDao {
  // bool dataAlreadyExist(int videoId){
  //   return openVideoDataBox().containsKey(videoId);
  // }

  void addUserData(UserData userData) {
    openUserDataBox().put(userData.number, userData);
  }

  void deleteUserData(String number) {
    openUserDataBox().delete(number);
  }

  void deleteAllUserData() {
    openUserDataBox().clear();
  }

  List<UserData> getUserDataList() {
    return openUserDataBox().values.toList();
  }

  Box<UserData> openUserDataBox() {
    return Hive.box<UserData>(HiveConstants.BOX_NAME_USER_DATA);
  }
}
