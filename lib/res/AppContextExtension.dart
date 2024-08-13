import 'package:flutter/cupertino.dart';
import 'package:itune/res/Resources.dart';

extension AppContextExtension on BuildContext {
  Resources get resources => Resources.of(this);
}
