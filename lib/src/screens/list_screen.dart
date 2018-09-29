import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import '../components/cat.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> with TickerProviderStateMixin {

  Animation<double> cardAnimation;
  AnimationController cardAnimController;

  @override
  initState() {
    super.initState();

    cardAnimController = AnimationController(
      duration: Duration(
        seconds: 2,
      ),
      vsync: this
    );

    // Range of values we want to animate over
    cardAnimation = Tween(
      begin: 0.0,
      end: 100.0
    ).animate(
      CurvedAnimation(
        parent: cardAnimController,
        curve: Curves.easeIn
      )
    );

  }


  Widget buildListWithAnim() {
    return AnimatedBuilder(
      animation: cardAnimation,
      builder: (context, child) {
        return Container(
          child: child,
          margin: EdgeInsets.only(top: cardAnimation.value),
        );
      },
      child: Cat(),
    );
  }

  _onCardTap() {
    if(cardAnimController.status == AnimationStatus.completed) {
      cardAnimController.reverse();
    } else if (cardAnimController.status == AnimationStatus.dismissed) {
      // Start it
      cardAnimController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(title: Text('Animation')),
        body: Center(
          child: GestureDetector(
            child: buildListWithAnim(),
            onTap: _onCardTap()
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {

          },
        ));
  }
}
