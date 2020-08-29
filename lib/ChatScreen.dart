import 'package:flutter/material.dart';
import 'package:flutter_php/ChatDetail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatScreen extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ChatScreen> {
  initState() {   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.teal[600],
            title: Text('WhatsApp'),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.search),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.more_vert),
              ),
            ],
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.camera_alt),
                ),
                Tab(text: "CHAT"),
                Tab(text: "STATUS"),
                Tab(text: "CALL")
              ],
              indicatorColor: Colors.white,
            ),
          ),
          body: TabBarView(
            children: [
              FirstScreen(),
              FirstScreen(),
              FirstScreen(),
              FirstScreen(),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Add your onPressed code here!
            },
            child: Icon(Icons.chat),
            backgroundColor: Colors.greenAccent[400],
          )),
    );
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 25,
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.brown.shade800,
            child: Icon(Icons.person),
          ),
          title: Text("Name"),
          subtitle: Text("subtitle"),
          trailing: Text("datetime"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatDetailScreen(),
              ),
            );
          },
        );
      },
    );
  }
}
