import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter_php/chatprovider.dart';
import 'package:provider/provider.dart';

class ChatDetailScreen extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ChatDetailScreen> {
  FocusNode _focusNode = FocusNode();
  final myController = TextEditingController();
  var iconsender = Icons.mic;
  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;
    double px = 1 / pixelRatio;
    BubbleStyle styleSomebody = BubbleStyle(
      nip: BubbleNip.leftTop,
      color: Colors.white,
      elevation: 1 * px,
      margin: BubbleEdges.only(top: 8.0, right: 50.0),
      alignment: Alignment.topLeft,
    );
    BubbleStyle styleMe = BubbleStyle(
      nip: BubbleNip.rightTop,
      color: Color.fromARGB(255, 225, 255, 199),
      elevation: 1 * px,
      margin: BubbleEdges.only(top: 8.0, left: 50.0),
      alignment: Alignment.topRight,
    );
    var chatprovider = Provider.of<ChatModel>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.videocam),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.call),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.more_vert),
            ),
          ],
          title: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.brown.shade800,
              child: Icon(Icons.person),
            ),
            title: Text(
              "Name",
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              "subtitle",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        body: Form(
          autovalidate: true,
          child: Stack(children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 4 / 3,
              color: Colors.yellow.withAlpha(64),
              child: ListView.builder(
                itemCount: chatprovider.allmsg.length,
                itemBuilder: (context, index) {
                  return Bubble(
                    style: styleMe,
                    nip: BubbleNip.no,
                    margin: BubbleEdges.only(top: 2.0),
                    child: Stack(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 48.0),
                          child: Text(chatprovider.allmsg[index].message),
                        ),
                        Positioned(
                          bottom: 0.0,
                          right: 0.0,
                          child: Row(
                            children: <Widget>[
                              Text("1.23",
                                  style: TextStyle(
                                    color: Colors.black38,
                                    fontSize: 10.0,
                                  )),
                              SizedBox(width: 3.0),
                              Icon(
                                Icons.done_all,
                                size: 12.0,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
              // Bubble(
              //   alignment: Alignment.center,
              //   color: Color.fromARGB(255, 212, 234, 244),
              //   elevation: 1 * px,
              //   margin: BubbleEdges.only(top: 8.0),
              //   child: Text('TODAY', style: TextStyle(fontSize: 10)),
              // ),
              // Bubble(
              //   style: styleSomebody,
              //   child: Text(
              //       'Hi Jason. Sorry to bother you. I have a queston for you.'),
              // ),
              // Bubble(
              //   style: styleMe,
              //   child: Text('Whats\'up?'),
              // ),
              // Bubble(
              //   style: styleSomebody,
              //   child:
              //       Text('I\'ve been having a problem with my computer.'),
              // ),
              // Bubble(
              //   style: styleSomebody,
              //   margin: BubbleEdges.only(top: 2.0),
              //   nip: BubbleNip.no,
              //   child: Text('Can you help me?'),
              // ),
              // Bubble(
              //   style: styleMe,
              //   child: Text('Ok'),
              // ),
              // Bubble(
              //   style: styleMe,
              //   nip: BubbleNip.no,
              //   margin: BubbleEdges.only(top: 2.0),
              //   child: Stack(
              //     children: <Widget>[
              //       Padding(
              //         padding: EdgeInsets.only(right: 48.0),
              //         child: Text("message"),
              //       ),
              //       Positioned(
              //         bottom: 0.0,
              //         right: 0.0,
              //         child: Row(
              //           children: <Widget>[
              //             Text("1.23",
              //                 style: TextStyle(
              //                   color: Colors.black38,
              //                   fontSize: 10.0,
              //                 )),
              //             SizedBox(width: 3.0),
              //             Icon(
              //               Icons.done_all,
              //               size: 12.0,
              //               color: Colors.blue,
              //             )
              //           ],
              //         ),
              //       )
              //     ],
              //   ),
              // ),
            ),
            Positioned(
                bottom: 0,
                child: Container(
                  color: Colors.yellow.withAlpha(30),
                  height: 60.0,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          flex: 6,
                          child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.white, width: 4.0),
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: TextFormField(
                                  autovalidate: true,
                                  maxLines: null,
                                  validator: (value) {
                                    if (value.contains('\n')) {
                                      Provider.of<ChatModel>(context,
                                              listen: false)
                                          .add(myController.text);
                                      _focusNode.unfocus();
                                      myController.text = "";
                                      iconsender = Icons.mic;
                                    }
                                  },
                                  controller: myController,
                                  onChanged: (String value) async {
                                    if (value != null) {
                                      //print("if");
                                      setState(() {
                                        iconsender = Icons.send;
                                      });
                                    } else {
                                      //print("else");
                                      setState(() {
                                        iconsender = Icons.mic;
                                      });
                                    }
                                  },
                                  autocorrect: false,
                                  focusNode: _focusNode,
                                  style: TextStyle(color: Colors.grey),
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    border: InputBorder.none,
                                    filled: true,
                                    contentPadding: EdgeInsets.only(
                                        bottom: 10.0, left: 10.0, right: 10.0),
                                    labelText: "Type a message",
                                    prefixIcon: Icon(Icons.insert_emoticon),
                                    suffixIcon: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween, // added line
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(Icons.attach_file),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(Icons.camera_enhance),
                                        ),
                                      ],
                                    ),
                                  ),
                                  //validator: widget.validator,
                                  onSaved: (String) {},
                                  //decoration: null,
                                ),
                              ))),
                      FlatButton(
                        onPressed: () {
                          Provider.of<ChatModel>(context, listen: false)
                              .add(myController.text);
                          _focusNode.unfocus();
                          myController.text = "";
                          iconsender = Icons.mic;
                        },
                        child: Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.teal,
                                child: Icon(
                                  iconsender,
                                  color: Colors.white,
                                ),
                              ),
                            )),
                      ),
                    ],
                  ),
                )),
          ]),
        ));
  }
}
