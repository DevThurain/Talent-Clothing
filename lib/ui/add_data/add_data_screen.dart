import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:talent_clothing/persistent/daos/user_data_dao.dart';
import 'package:talent_clothing/persistent/hive_constants.dart';
import 'package:talent_clothing/persistent/models/user_data.dart';

class AddDataScreen extends StatefulWidget {
  static const routeName = '/add_data_screen';
  const AddDataScreen({Key? key}) : super(key: key);

  @override
  State<AddDataScreen> createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  late final UserDataDao userDataDao;
  List<UserData> userList = [];

  @override
  void initState() {
    userDataDao = UserDataDao();
    setState(() {
      userList = userDataDao.getUserDataList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Data"),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  userList = userDataDao.getUserDataList();
                });
              },
              icon: Icon(Icons.refresh)),
          IconButton(
              onPressed: () {
                userDataDao.deleteAllUserData();

                setState(() {
                  userList = userDataDao.getUserDataList();
                });
              },
              icon: Icon(Icons.close)),
          IconButton(
              onPressed: () {
                createBackup();
              },
              icon: Icon(Icons.archive)),
          IconButton(
              onPressed: () {
                restoreBackup();
              },
              icon: Icon(Icons.unarchive)),
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
            itemCount: userList.length,
            itemBuilder: ((context, index) {
              return Text(userList[index].number + " ::::::::: " + userList[index].dateTime);
            })),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var now = DateTime.now();
          userDataDao.addUserData(
              UserData(number: DateTime.now().toString(), dateTime: "${now.hour}:${now.minute}:${now.second}"));
          setState(() {
            userList = userDataDao.getUserDataList();
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> createBackup() async {
    if (Hive.box<UserData>(HiveConstants.BOX_NAME_USER_DATA).isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No UserDatas Stored.')),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Creating backup...')),
    );
    Map<String, dynamic> map = Hive.box<UserData>(HiveConstants.BOX_NAME_USER_DATA)
        .toMap()
        .map((key, value) => MapEntry(key.toString(), value));
    String json = jsonEncode(map);
    if (await Permission.storage.request().isGranted) {
      Directory dir = await _getDirectory();
      String formattedDate = DateTime.now().toString().replaceAll('.', '-').replaceAll(' ', '-').replaceAll(':', '-');
      String path =
          '${dir.path}$formattedDate.json'; //Change .json to your desired file format(like .barbackup or .hive).
      File backupFile = File(path);
      await backupFile.writeAsString(json);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Backup saved in folder Barcodes')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No Permissions.')),
      );
    }
  }

  Future<void> restoreBackup() async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Restoring backup...')),
    );
    FilePickerResult? file = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );
    if (file != null) {
      File files = File(file.files.single.path.toString());
      Hive.box<UserData>(HiveConstants.BOX_NAME_USER_DATA).clear();
      Map<String, dynamic> map = jsonDecode(await files.readAsString());
      for (var i = 0; i < map.length; i++) {
        print(map.toString());
        UserData product = UserData.fromJson(i,map);
        Hive.box<UserData>(HiveConstants.BOX_NAME_USER_DATA).add(product);
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Restored Successfully...')),
      );
    }
  }

  Future<Directory> _getDirectory() async {
    const String pathExt = '/UserData/';
    var external = await getExternalStorageDirectory(); //This is the name of the folder where the backup is stored
    Directory newDirectory =
        Directory(external!.path + pathExt); //Change this to any desired location where the folder will be created

    print(newDirectory.path);
    if (await newDirectory.exists() == false) {
      return newDirectory.create(recursive: true);
    }
    return newDirectory;
  }
}
