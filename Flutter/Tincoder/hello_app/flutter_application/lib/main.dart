import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// Align Widgets: [Row, Column, Container, Stack, Expanded, Flexible, Align, Positioned, Center, Padding]
// Text, RichText, TextSpan, Button, Card
void main() {
  runApp(
    MaterialApp(
      // theme: ThemeData(fontFamily: "Dank Mono"),
      home: SafeArea(
          child: Scaffold(
        body: MyExpanded(),
        // appBar: AppBar(
        //     backgroundColor: Colors.lightBlue,
        //     title: const Text("App Bar")),
        // body: const Center(
        //   child: Text("Hello World"),
      )),
      debugShowCheckedModeBanner: false,
    ),
  );
}

// Row is similar change SizedBox prop to width
class MyExpanded extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                color: Colors.red,
              )),
          const SizedBox(height: 10),
          Expanded(
              flex: 2,
              child: Container(
                color: Colors.green,
              )),
          const SizedBox(height: 10),
          Expanded(
              flex: 1,
              child: Container(
                color: Colors.blue,
              ))
        ],
      ),
    );
  }
}

// similar with Column
class MyRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.purpleAccent,
      margin: const EdgeInsets.all(20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // oX
        crossAxisAlignment: CrossAxisAlignment.center, // oY
        children: [
          TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(10),
                  elevation: 20,
                  shadowColor: CupertinoColors.inactiveGray.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
              child: const Text(
                'Button 1',
                style: TextStyle(fontSize: 20, color: Colors.white),
              )),
          SizedBox(
            height: 200,
            child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(10),
                    elevation: 20,
                    maximumSize: const Size.fromHeight(200),
                    shadowColor: CupertinoColors.inactiveGray.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                child: const Text(
                  'Button 2',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )),
          ),
          TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(10),
                  elevation: 20,
                  shadowColor: CupertinoColors.inactiveGray.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
              child: const Text(
                'Button 3',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ))
        ],
      ),
    );
  }
}

// color
// size: width - height
// padding, margin
// alignment
// decoration: color, shape, border, borderRadius
// transform: xoay
class MyContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(50),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.blue,
          border: Border.all(width: 2, color: Colors.red),
          borderRadius: BorderRadius.circular(10),
          shape: BoxShape.rectangle),
      width: 200,
      transform: Matrix4.rotationZ(0.4),
      height: 200,
      child: const Text('Hello World',
          style: TextStyle(fontSize: 30, color: Colors.white)),
    );
  }
}

// text, color, click, size , padding, margin, shape, shadow, border, icon, disable
class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 20),
      child: TextButton.icon(
        onPressed: null,
        icon: Icon(Icons.add_box_sharp, size: 25),
        label: Text(
          'Button',
          style: TextStyle(fontSize: 25),
        ),
        style: TextButton.styleFrom(
          disabledBackgroundColor: Colors.grey,
          disabledForegroundColor: Colors.white,
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          shadowColor: Colors.blueGrey.withOpacity(0.5),
          elevation: 20,
          // side: BorderSide(width: 2, color: Colors.white) --> add border
        ),
      ),
    );
  }
}

class MarginPadding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(30),
      color: Colors.pink,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          'Hello card',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

// align
// direction
// overflow
// max lines
// style: color, font.., decoration..
class MyText extends StatelessWidget {
  MyText();

  @override
  Widget build(BuildContext context) {
    return const Text(
      "ea dico primis graeco usu. Diam consequuntur mel cu."
      "Sea ei nibh paulo. Sed eu prima mucius menandri, te vim "
      "agam habemus referrentur. Nec ei option adipiscing "
      "reprimique.Vix ad alii accusata adipiscing. "
      "Ex porro dicunt duo, populo repudiare sed ei, "
      "alii lucilius indoctum nam in. Mel at pericula "
      "comprehensam, eos id homero alienum placerat."
      "Labore discere quo in, vis an recusabo sensibus torquatos."
      "Vel ad tale propriae mentitum, eirmod perfecto mei et"
      "Cum nibh pertinacia disputando at, sed agam velit",
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.justify,
      maxLines: 10,
      overflow: TextOverflow.ellipsis,
      textScaler: TextScaler.linear(1),
      style: TextStyle(
        color: Colors.pink,
        // backgroundColor: Colors.blueAccent,
        // wordSpacing: 10,
        // letterSpacing: 5
        fontSize: 15,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w400,
        // fontFamily: "Times New Roman",
        // decoration: TextDecoration.underline,
        decorationStyle: TextDecorationStyle.dotted,
        decorationColor: Colors.pink,
      ),
    );
  }
}

class MyRichText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: const <TextSpan>[
          TextSpan(text: 'Hello'),
          TextSpan(text: 'Bold', style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(
              text: 'Italic',
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  decoration: TextDecoration.underline)),
        ]));
  }
}

class MyWidget2 extends StatefulWidget {
  final bool loading;

  MyWidget2(this.loading);

  @override
  State<StatefulWidget> createState() {
    return MyWidget2State();
  }
}

class MyWidget2State extends State<MyWidget2> {
  late bool _localLoading;

  @override
  void initState() {
    super.initState();
    _localLoading = widget.loading;
  }

  @override
  Widget build(BuildContext context) {
    return _localLoading
        ? const CircularProgressIndicator()
        : FloatingActionButton(onPressed: onPressed);
  }

  void onPressed() {
    setState(() {
      _localLoading = true;
    });
  }
}
