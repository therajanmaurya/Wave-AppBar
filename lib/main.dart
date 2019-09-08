import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wave AppBar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AppBarHomePage(title: 'Wave AppBar'),
    );
  }
}

class AppBarHomePage extends StatefulWidget {
  AppBarHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AppBarHomePageState createState() => _AppBarHomePageState();
}

class _AppBarHomePageState extends State<AppBarHomePage> {
  static IconData backIcon(BuildContext context) {
    switch (Theme.of(context).platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return Icons.arrow_back;
      case TargetPlatform.iOS:
        return Icons.arrow_back_ios;
    }
    assert(false);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        primary: false,
        appBar: PreferredSize(
          preferredSize: Size(null, 100),
          child: SafeArea(
              child: Container(
            color: Theme.of(context).primaryColor,
            width: MediaQuery.of(context).size.width,
            // Set Appbar wave height
            child: Container(
              height: 80,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Container(
                  color: Colors.white,
                  child: Stack(
                    children: <Widget>[
                      RotatedBox(
                          quarterTurns: 2,
                          child: WaveWidget(
                            config: CustomConfig(
                              colors: [Theme.of(context).primaryColor],
                              durations: [22000],
                              heightPercentages: [-0.1],
                            ),
                            size: Size(double.infinity, double.infinity),
                            waveAmplitude: 1,
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Builder(
                            builder: (context) => IconButton(
                              icon: new Icon(backIcon(context), color: Colors.white),
                              onPressed: () => print("It's Back Button"),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                widget.title,
                                style: TextStyle(fontSize: 20, color: Colors.white),
                              )),
                        ],
                      ),
                      Positioned(
                        top: 6.0,
                        right: 6.0,
                        child: Theme(
                            data: Theme.of(context).copyWith(
                              cardColor: Theme.of(context).primaryColor,
                            ),
                            child: PopupMenuButton(
                                elevation: 4.0,
                                initialValue: activePopMenu,
                                onSelected: (value) {},
                                itemBuilder: (context) {
                                  return getChildPopUpWidgets(context);
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: 10, left: 5),
                                        child: Icon(Icons.brightness_1, size: 12, color: Colors.white),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 10),
                                        child: Text(
                                          activePopMenu.title,
                                          style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w400),
                                        ),
                                      )
                                    ],
                                  ),
                                ))),
                      ),
                    ],
                  )),
            ),
          )),
        ),
        body: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Awesome Wave AppBar',
                  style: TextStyle(color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ));
  }
}

List<PopMenuItem> getPopMenus() {
  List<PopMenuItem> popMenus = new List();
  popMenus.add(PopMenuItem(title: "Awesome", id: 1));
  popMenus.add(PopMenuItem(title: "Wave", id: 2));
  return popMenus;
}

PopMenuItem activePopMenu = getPopMenus()[0];

List<PopupMenuEntry<Object>> getChildPopUpWidgets(BuildContext context) {
  var childrenPopMenu = List<PopupMenuEntry<Object>>();
  for (PopMenuItem popUpMenu in getPopMenus()) {
    childrenPopMenu.add(PopupMenuItem(
      value: popUpMenu.id,
      child: Padding(
        padding: EdgeInsets.all(6.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.brightness_1, size: 12, color: popUpMenu.id == activePopMenu.id ? Colors.white : Colors.transparent),
            ),
            Container(
              width: 90,
              child: Text(
                popUpMenu.title,
                style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    ));
  }
  return childrenPopMenu;
}

class PopMenuItem {
  String title;
  int id;

  PopMenuItem({this.title, this.id});

  PopMenuItem.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['id'] = this.id;
    return data;
  }
}
