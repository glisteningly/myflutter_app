import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path_provider/path_provider.dart';

//void main() {
//  runApp(
//    Center(
//      child: Text(
//        'Hello, world!',
//        textDirection: TextDirection.ltr,
//      ),
//    ),
//  );
//}

void main() {
  Future test() async {
    Directory appDocDirectory = await getApplicationDocumentsDirectory();
    print(appDocDirectory.path);

    Database db = await databaseFactoryIo.openDatabase(
//        join(".dart_tool", "sembast", "example", "record_demo.db"));
        join(appDocDirectory.path, "record_demo.db"));
    Store store = db.getStore("my_store");
    Record record = Record(store, {"name": "ugl_arex"});
    record = await db.putRecord(record);
    record = await store.getRecord(record.key);
    record = (await store.findRecords(Finder(filter: Filter.byKey(record.key)))).first;
    record = await store.getRecord(record.key);
    print(record);
    var records = (await store.findRecords(Finder(filter: Filter.matches("name", "^ugl"))));
    print(records);
//    var records1 = (await store.deleteAll([1,2,3]));
  }

//  test() async {
//    Directory appDocDirectory = await getApplicationDocumentsDirectory();
//    print(appDocDirectory.path);
//
////    new Directory(appDocDirectory.path + '/' + 'dir').create(recursive: true)
////// The created directory is returned as a Future.
////        .then((Directory directory) {
////      print('Path of New Dir: ' + directory.path);
////    });
//  }

  test();

  runApp(
    Center(
      child: Container(
        // grey box
        child: Center(
          child: Text(
            "Lorem ipsum",
            textDirection: TextDirection.ltr,
          ),
        ),
        width: 320.0,
        height: 120.0,
        color: Colors.grey[300],
      ),
    ),
  );
}
