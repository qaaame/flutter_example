import 'package:flutter/material.dart';
import 'package:beautiful_list/database_helper.dart';
import 'package:beautiful_list/model/detail.dart';


class AddEntryDialog extends StatefulWidget {
  @override
  AddEntryDialogState createState() => new AddEntryDialogState();
}

class AddEntryDialogState extends State<AddEntryDialog> {
  DatabaseHelper helper = DatabaseHelper();

  String _note;
  TextEditingController _textController;


  @override
  void initState() {
    super.initState();
    _textController = new TextEditingController(text: _note);
  }




  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('New entry'),
        actions: [
          new FlatButton(
              onPressed:
                  () {
                addRecord(true);
                //TODO: Handle save
              },
              child: new Text('SAVE',
                  style: Theme
                      .of(context)
                      .textTheme
                      .subhead
                      .copyWith(color: Colors.white))),
        ],
      ),
      body: new Column(
        children: [

          new ListTile(
            leading: new Icon(Icons.speaker_notes, color: Colors.grey[500]),
            title: new TextField(
              decoration: new InputDecoration(
                hintText: 'Title',
              ),
              controller: _textController,
              onChanged: (value) => _note = value,
            ),
          ),

          new ListTile(
            leading: new Icon(Icons.speaker_notes, color: Colors.grey[500]),
            title: new TextField(
              decoration: new InputDecoration(
                hintText: 'Detail',
              ),
              controller: _textController,
              onChanged: (value) => _note = value,
            ),
          ),

        ],
      ),
    );
  }

  Future addRecord(bool isEdit) async {
    var db = new DatabaseHelper();
//    var user = new User("hiroki", "kameyama", "huga");
    var detail = new Detail("hiroki", "kameyama", "huga");
      await db.saveDetail(detail);

    // ignore: illegal_assignment_to_non_assignable, missing_assignable_selector
//    <List<User>> = db.getUser();
    print("____________ ");
    db.getDetail();
  }

}
