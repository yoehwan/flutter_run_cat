import 'package:flutter_run_cat/databases/local_box.dart';

class RunnerBox extends LocalBox {
  @override
  String get boxID => "RunnerBox";

  List loadRunner() {
    return box.values.toList();
  }

  Future updateRunner(int index, Map<String, dynamic> data) async {
    await box.put(index, data);
  }
}
