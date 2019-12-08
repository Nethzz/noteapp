import 'package:flutter/material.dart';

class FabButton extends StatefulWidget {
  final Function() onPressed;
  final String tooltip;
  final IconData icon;

  FabButton({Key key, this.onPressed, this.tooltip, this.icon})
      : super(key: key);

  @override
  _FabButtonState createState() => _FabButtonState();
}

class _FabButtonState extends State<FabButton>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;
 
  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });

    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(animationController);

    _buttonColor = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.00, 1.00, curve: Curves.linear)));

    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  void dispose() {
   animationController.dispose();
    super.dispose();
  }

  animate(){
    if(!isOpened){
      animationController.forward();
    }
    else{
      animationController.reverse();
    }
    isOpened = !isOpened;
  }

    Widget add() {
    return Container(
      child: FloatingActionButton(
        heroTag: "btn2",
        onPressed: null,
        tooltip: 'map',
        child: Icon(Icons.map),
      ),
    );
  }

  Widget image() {
    return Container(
      child: FloatingActionButton(
        heroTag: "btn3",
        onPressed: null,
        tooltip: 'contact',
        child: Icon(Icons.contact_phone),
      ),
    );
  }

  Widget inbox() {
    return Container(
      child: FloatingActionButton(
        heroTag: "btn1",
        onPressed: null,
        tooltip: 'reminder',
        child: Icon(Icons.alarm),
      ),
    );
  }

  Widget toggle(){
    return Container(
      child: FloatingActionButton(
        heroTag: "btn4",
        backgroundColor: _buttonColor.value,
      onPressed: animate,
      tooltip: 'Toogle',
      child: AnimatedIcon(icon: AnimatedIcons.menu_close,
      progress: _animateIcon,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 3.0,
            0.0,
          ),
          child: add(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 2.0,
            0.0,
          ),
          child: image(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value,
            0.0,
          ),
          child: inbox(),
        ),
        toggle(),
      ],
    );
  }
}
