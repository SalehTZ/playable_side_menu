import 'package:flutter/material.dart';
import 'package:playable_side_menu/components/side_bar_Item.dart';
import 'package:playable_side_menu/constants.dart';
import 'package:playable_side_menu/models/list_item_model.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ScrollController scrollController;

  double get itemHeight =>
      Constants.toolbarWidth - (Constants.toolbarHorizontalPadding * 2);

  void scrollListener() {
    if (scrollController.hasClients) {
      _updateItemsScrollData(
        scrollPosition: scrollController.position.pixels,
      );
    }
  }

  List<bool> longPressedItemsFlags = [];

  void _updateLongPressedItemsFlags({double longPressYLocation = 0}) {
    List<bool> _longPressedItemsFlags = [];
    for (int i = 0; i <= toolbarItems.length - 1; i++) {
      bool isLongPressed = itemYPositions[i] >= 0 &&
          longPressYLocation > itemYPositions[i] &&
          longPressYLocation <
              (itemYPositions.length > i + 1
                  ? itemYPositions[i + 1]
                  : Constants.toolbarHeight);
      _longPressedItemsFlags.add(isLongPressed);
    }
    setState(() {
      longPressedItemsFlags = _longPressedItemsFlags;
    });
  }

  List<double> itemScrollScaleValues = [];
  List<double> itemYPositions = [];

  void _updateItemsScrollData({double scrollPosition = 0}) {
    List<double> _itemScrollScaleValues = [];
    List<double> _itemYPositions = [];
    for (int i = 0; i <= toolbarItems.length - 1; i++) {
      double itemTopPosition = i * (itemHeight + Constants.itemsGutter);
      _itemYPositions.add(itemTopPosition - scrollPosition);

      double itemBottomPosition =
          (i + 1) * (itemHeight + Constants.itemsGutter);
      double distanceToMaxScrollExtent =
          Constants.toolbarHeight + scrollPosition - itemTopPosition;
      bool itemIsOutOfView =
          distanceToMaxScrollExtent < 0 || scrollPosition > itemBottomPosition;
      _itemScrollScaleValues.add(itemIsOutOfView ? 0.4 : 1);
    }
    setState(() {
      itemScrollScaleValues = _itemScrollScaleValues;
      itemYPositions = _itemYPositions;
    });
  }

  //! useless data
  final double _dBottomWidth = 50;
  double _bottomWidth = 50;
  int numberOfButtons = 5;
  int _expandedIndex = -1;
  List<Color?> btnColors = [
    Colors.red[100],
    Colors.green[100],
    Colors.yellow[100],
    Colors.blue[100],
    Colors.purple[100]
  ];
  //! useless data

  @override
  void initState() {
    super.initState();
    _updateItemsScrollData();
    _updateLongPressedItemsFlags();
    scrollController = ScrollController();
    scrollController.addListener(scrollListener);
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white.withOpacity(0.9),
        appBar: AppBar(
          backgroundColor: Colors.white.withOpacity(0.9),
          centerTitle: true,
          title: const Text(
            'Slidable Side Bar',
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0,
        ),
        body: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            height: Constants.toolbarHeight,
            margin:
                const EdgeInsets.only(left: Constants.toolbarHorizontalPadding),
            child: Stack(
              children: [
                Positioned(
                  child: Container(
                    width: Constants.toolbarWidth,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 20,
                          color: Colors.black.withOpacity(0.2),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onLongPressStart: (details) {
                    _updateLongPressedItemsFlags(
                      longPressYLocation: details.localPosition.dy,
                    );
                  },
                  onLongPressMoveUpdate: (details) {
                    _updateLongPressedItemsFlags(
                      longPressYLocation: details.localPosition.dy,
                    );
                  },
                  onLongPressEnd: (LongPressEndDetails details) {
                    _updateLongPressedItemsFlags(longPressYLocation: 0);
                  },
                  onLongPressCancel: () {
                    _updateLongPressedItemsFlags(longPressYLocation: 0);
                  },
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: toolbarItems.length,
                    padding: const EdgeInsets.all(10),
                    itemBuilder: (context, index) {
                      return SideBarItem(
                        toolbarItems[index],
                        height: itemHeight,
                        scrollScale: itemScrollScaleValues[index],
                        isLongPressed: longPressedItemsFlags[index],
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Align oldToolbar() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        // width: 70,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        // alignment: Alignment.centerLeft,
        decoration: const BoxDecoration(
          color: Colors.white38,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            toolbarItems.length,
            (index) {
              return GestureDetector(
                // onLongPress: () {
                //   setState(() {
                //     _bottomWidth *= 2.5;
                //     _expandedIndex = index;
                //   });
                //   print('onLongPress');
                // },
                onLongPressStart: (details) {
                  setState(() {
                    _bottomWidth *= 2.5;
                    _expandedIndex = index;
                  });
                  print('onLongPressStart');
                },
                onLongPressEnd: (details) {
                  setState(() {
                    _bottomWidth = _dBottomWidth;
                    _expandedIndex = -1;
                  });
                  print('onLongPressEnd');
                },
                onLongPressCancel: () {
                  setState(() {
                    _bottomWidth = _dBottomWidth;
                    _expandedIndex = -1;
                  });
                  print('onLongPressCancel');
                },
                child: AnimatedContainer(
                  decoration: BoxDecoration(
                    color: toolbarItems[index].color,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.symmetric(vertical: 4.0),
                  alignment:
                      (_bottomWidth > _dBottomWidth) && _expandedIndex == index
                          ? Alignment.centerRight
                          : Alignment.center,
                  curve: Curves.ease,
                  width: _expandedIndex == index ? _bottomWidth : _dBottomWidth,
                  height: _dBottomWidth,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(toolbarItems[index].icon),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
