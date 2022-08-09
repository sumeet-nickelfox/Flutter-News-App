import 'package:flutter/cupertino.dart';
import 'package:flutter_news_app/res/Resources.dart';

extension AppContext on BuildContext {
  Resources get resources => Resources.of(this);
}
