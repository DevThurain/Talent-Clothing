import 'package:flutter/material.dart';
import 'package:talent_clothing/ui/home/sections/app_bar_section.dart';

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
      // print('opacity ' + ((50 - scrollController.offset)/50).toString());

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
      backgroundColor: Colors.white,
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          AppBarSection(enoughSpace: enoughSpace, scrollController: scrollController),
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
