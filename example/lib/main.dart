import 'package:flutter/material.dart';
import 'package:text_span_field/text_span_field.dart';
import 'package:text_span_field/range_style.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /// 输入的文本内容如
  String text = "";

  /// 话题正则
  RegExp topicReg = new RegExp(r"#([^#]{1,})#");

  /// 用户提醒(@开头,以空格、冒号、斜杠/ 结束，不以@结束)
  RegExp accountRemindReg = new RegExp(r"@([^\s|\/|:|@]+)");

  @override
  void initState() {
    super.initState();
  }

  /// 获得文本输入框样式
  List<RangeStyle> getTextFieldStyle() {
    List<RangeStyle> result = [];

    // 匹配话题
    for (Match m in topicReg.allMatches(text)) {
      result.add(
        RangeStyle(
          range: TextRange(start: m.start, end: m.end),
          style: TextStyle(color: Color(0xFF9C7BFF)),
        ),
      );
    }

    // 匹配@
    for (Match m in accountRemindReg.allMatches(text)) {
      result.add(
        RangeStyle(
          range: TextRange(start: m.start, end: m.end),
          style: TextStyle(color: Color(0xFF5BA2FF)),
        ),
      );
    }
    return result.length == 0 ? null : result;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: TextSpanField(
            maxLines: null,
            onChanged: (value) => this.setState(() => text = value),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(20),
              hintText: '分享你的点滴，记录这一刻...',
            ),
            rangeStyles: this.getTextFieldStyle(),
          ),
        ),
      ),
    );
  }
}
