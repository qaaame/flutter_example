import 'package:beautiful_list/database_helper.dart';
//import 'package:beautiful_list/model/ItemHeader.dart';
import 'package:beautiful_list/model/header.dart';
import 'package:flutter/material.dart';
import 'package:beautiful_list/detail_list.dart';
import 'package:beautiful_list/header_entry_dialog.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
          primaryColor: Color.fromRGBO(58, 66, 86, 1.0), fontFamily: 'Raleway'),
      home: new ListPage(title: 'Item Header Lists'),
      // home: DetailPage(),
    );
  }
}

class ListPage extends StatefulWidget {
  ListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List itemHeaders;
  Future<List<Header>> hoge;

  @override
  void initState() {
//    itemHeaders = getItemHeaders();




//    hoge = db.getHeader();


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var db = new DatabaseHelper();
//    FutureBuilder(
//        future: db.getHeader(),
//        builder: (context, future) {
//          if (!future.hasData) {
//            return Center(child: CircularProgressIndicator());
//          }
//
//          print('++++++ debug  ++++++');
//          print(future.data.body);
//        }
//    );



//    ListTile makeListTile(ItemHeader header) => ListTile(
        ListTile makeListTile(Header header) => ListTile(
      contentPadding:
      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Container(
        padding: EdgeInsets.only(right: 12.0),
        decoration: new BoxDecoration(
            border: new Border(
                right: new BorderSide(width: 1.0, color: Colors.white24))),
        child: Icon(Icons.autorenew, color: Colors.white),
      ),

      title: Text(
        header.title,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      subtitle: Row(
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Container(
                // tag: 'hero',
                child: LinearProgressIndicator(
                    backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
                    value: header.indicatorValue,
                    valueColor: AlwaysStoppedAnimation(Colors.green)),
              )),
          Expanded(
            flex: 4,
            child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(header.level,
                    style: TextStyle(color: Colors.white))),
          )
        ],
      ),
      trailing:
      Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
// TODO  一旦コメントアウト。タップした際に遷移するところ
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
//                builder: (context) => DetailList(ItemHeader: header)));
        builder: (context) => DetailList(header: header)));
      },
    );

//    Card makeCard(ItemHeader lesson) => Card(
    Card makeCard(Header lesson) => Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: makeListTile(lesson),
      ),
    );

//    final makeBody = Container(
//      // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
//      child: ListView.builder(
//        scrollDirection: Axis.vertical,
//        shrinkWrap: true,
//        itemCount: itemHeaders.length,
////        itemCount: hoge.length,
//
//        itemBuilder: (BuildContext context, int index) {
//          return makeCard(itemHeaders[index]);
//        },
//      ),
//    );


//    body: FutureBuilder<List<Header>>(
    final makeBody =FutureBuilder<List<Header>>(
      future: db.getHeader(),
      builder: (BuildContext context, AsyncSnapshot<List<Header>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {

              Header header = snapshot.data[index];

              return makeCard(header);

//        itemBuilder: (BuildContext context, int index) {
//          return makeCard(itemHeaders[index]);
//        },
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );





    final makeBottom = Container(
      height: 55.0,
      child: BottomAppBar(
        color: Color.fromRGBO(58, 66, 86, 1.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.blur_on, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.hotel, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.account_box, color: Colors.white),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
    final topAppBar = AppBar(
      elevation: 0.1,
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      title: Text(widget.title),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.list),
          onPressed: () {},
        )
      ],
    );


    Future _openAddEntryDialog() async {
      Navigator.of(context).push(new MaterialPageRoute<Null>(
          builder: (BuildContext context) {
            return new AddEntryDialog();
          },
          fullscreenDialog: true
      ));
    }

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: topAppBar,
      body: makeBody,
      bottomNavigationBar: makeBottom,

      floatingActionButton: FloatingActionButton(
        onPressed: _openAddEntryDialog,
        child: new Icon(Icons.add),
      ),
    );
  }
}

//List getItemHeaders() {
//  return [
//    ItemHeader(
//        title: "Introduction to Driving",
//        level: "Beginner",
//        indicatorValue: 0.33,
//        price: 20,
//        content:
//        "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
//    ItemHeader(
//        title: "Observation at Junctions",
//        level: "Beginner",
//        indicatorValue: 0.33,
//        price: 50,
//        content:
//        "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
//    ItemHeader(
//        title: "Reverse parallel Parking",
//        level: "Intermidiate",
//        indicatorValue: 0.66,
//        price: 30,
//        content:
//        "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
//    ItemHeader(
//        title: "Reversing around the corner",
//        level: "Intermidiate",
//        indicatorValue: 0.66,
//        price: 30,
//        content:
//        "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
//    ItemHeader(
//        title: "Incorrect Use of Signal",
//        level: "Advanced",
//        indicatorValue: 1.0,
//        price: 50,
//        content:
//        "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
//    ItemHeader(
//        title: "Engine Challenges",
//        level: "Advanced",
//        indicatorValue: 1.0,
//        price: 50,
//        content:
//        "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
//    ItemHeader(
//        title: "Self Driving Car",
//        level: "Advanced",
//        indicatorValue: 1.0,
//        price: 50,
//        content:
//        "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed.  ")
//  ];
//}