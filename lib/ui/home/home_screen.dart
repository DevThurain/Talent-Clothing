import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home_screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var enoughSpace = true;
  var scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(() {
      print('opacity ' + (scrollController.offset * 0.1).toString());

      if (scrollController.offset < 50.0) {
        setState(() {
          enoughSpace = true;
        });
      } else {
        setState(() {
          enoughSpace = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverAppBar(
            collapsedHeight: 100,
            expandedHeight: 150,
            pinned: true,
            stretch: true,
            flexibleSpace: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100,
                    height: 50,
                    color: Colors.red,
                  ),
                  enoughSpace
                      ? Opacity(
                          opacity: scrollController.hasClients ? 1.0 : 1.0,
                          child: Container(
                            width: 100,
                            height: scrollController.hasClients ? 50 - scrollController.offset : 50,
                            color: Colors.green,
                          ),
                        )
                      : SizedBox(),
                  Container(
                    width: 100,
                    height: 50,
                    color: Colors.purple,
                  )
                ],
              ),
            ),
            stretchTriggerOffset: 150,
            onStretchTrigger: () async {
              setState(() {
                enoughSpace = true;
              });
            },
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 1000,
            ),
          )
        ],
      ),
    );
  }
}
