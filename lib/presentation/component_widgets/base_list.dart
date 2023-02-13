import 'package:flutter/material.dart';

class BaseList extends StatelessWidget {
  const BaseList({Key? key,this.gridWidget, this.direction = Axis.vertical,
    this.shrinkWrap = false, this.itemCount,this.isListView = true, this.crossAxisCount = 2,
    this.mainAxisSpacing = 0.0, this.crossAxisSpacing = 0.0, this.childAspectRatio = 1,
    this.itemBuilder}) : super(key: key);
  final List<Widget>? gridWidget;
  final Axis direction;
  final bool shrinkWrap;
  final int? itemCount;
  final bool isListView;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double childAspectRatio;
  final IndexedWidgetBuilder? itemBuilder;
  @override
  Widget build(BuildContext context) {
    //double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return isListView ? ListView.builder(
      itemBuilder: itemBuilder!,
      itemCount: itemCount,
      scrollDirection: direction,
      padding: EdgeInsets.only(left: screenWidth * 0.07,right: screenWidth * 0.07),
      physics: const BouncingScrollPhysics(),
      shrinkWrap: shrinkWrap,
    ) : GridView.count(
      padding: const EdgeInsets.only(top: 30,bottom: 30),
      shrinkWrap: shrinkWrap,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: mainAxisSpacing,
      crossAxisSpacing: crossAxisSpacing,
      childAspectRatio: childAspectRatio,
      children: gridWidget!,
    );
  }
}
