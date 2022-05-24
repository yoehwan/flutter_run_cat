import 'dart:io';

class Runner {
  Runner(this.entity);
  final FileSystemEntity entity;

  String get title => entity.path.split("/").last;
}
