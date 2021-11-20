import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> items = <Widget>[
    Container(color: CupertinoColors.systemPink, height: 100.0),
    Container(color: CupertinoColors.systemOrange, height: 100.0),
    Container(color: CupertinoColors.systemYellow, height: 100.0),
  ];

  List<Color> colors = <Color>[
    CupertinoColors.systemYellow,
    CupertinoColors.systemOrange,
    CupertinoColors.systemPink
  ];
  var colorAndText = {
    'color': <Color>[CupertinoColors.white, CupertinoColors.black],
    'text': <Color>[
      CupertinoColors.black,
      CupertinoColors.white,
    ]
  };
  int colorIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: colorAndText['color']![colorIndex],
      navigationBar: CupertinoNavigationBar(
        backgroundColor: colorAndText['color']![colorIndex],
        border: null,
        automaticallyImplyLeading: true,
        middle: Text(
          "News and Weather",
          style: TextStyle(
            color: colorAndText['text']![colorIndex],
          ),
        ),
        trailing: CupertinoButton(
          child: Icon(
            CupertinoIcons.sun_max_fill,
            color: CupertinoColors.activeOrange,
          ),
          onPressed: () {
            setState(() {
              if (colorIndex == 0) {
                colorIndex = 1;
              } else {
                colorIndex = 0;
              }
            });
          },
        ),
      ),
      child: CustomScrollView(
        // physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          CupertinoSliverRefreshControl(
            refreshTriggerPullDistance: 100.0,
            refreshIndicatorExtent: 60.0,
            onRefresh: () async {
              await Future<void>.delayed(const Duration(milliseconds: 1000));
              setState(() {
                items.insert(0,
                    Container(color: colors[items.length % 3], height: 100.0));
              });
            },
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) => items[index],
                childCount: items.length),
          ),
        ],
      ),
    );
  }
}
