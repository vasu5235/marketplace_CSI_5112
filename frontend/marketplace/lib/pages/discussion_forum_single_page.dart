import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:marketplace/constants/api_url.dart';
import 'package:marketplace/constants/route_names.dart';

import '../constants/page_titles.dart';
import '../widgets/app_scaffold.dart';
import 'package:http/http.dart' as http;

class DiscussionForumSinglePage extends StatefulWidget {
  final int questionId;
  final String questionTitle;
  final String questionDescription;
  final String questionUserName;

  const DiscussionForumSinglePage(this.questionId, this.questionTitle,
      this.questionDescription, this.questionUserName,
      {Key key})
      : super(key: key);

  @override
  State<DiscussionForumSinglePage> createState() =>
      _DiscussionForumSinglePageState();
}

class _DiscussionForumSinglePageState extends State<DiscussionForumSinglePage> {
  int _userId = -1;
  var _userName = "default user";

  Future<dynamic> _loadSession() async {
    var session = FlutterSession();

    _userId = await session.get("user_id");
    _userName = await session.get("user_name");

    if (_userId == null) {
      _userId = -1;
    }
    print("_loadSession called userId = " + _userId.toString());
    print("_loadSession called userName = " + _userName.toString());
  }

  Future getAllAnswers(int questionId) async {
    _loadSession();
    String uri = ApiUrl.get_answers;
    final url = Uri.encodeFull("${uri}/${questionId}");

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    print(jsonData);
    return jsonData;
  }

  // var _sampleForumQuestions = Constants.SAMPLE_ANSWERS_DF2;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAllAnswers(widget.questionId),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return AppScaffold(
              pageTitle: PageTitles.discussion_forum,
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton.icon(
                              label: Text('Back'),
                              icon: Icon(Icons.navigate_before),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, RouteNames.discussion_forum);
                              },
                              style:
                              ElevatedButton.styleFrom(primary: Colors.red),
                            )),
                        Row(
                          children: <Widget>[
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton.icon(
                                  label: Text('New answer'),
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          addNewAnswer(context),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.red),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 60.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.18,
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          elevation: 10,
                          child: Container(
                            height: 100,
                            child: Container(
                              alignment: Alignment.topLeft,
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: CircleAvatar(
                                      child: Text(widget.questionUserName[0]),
                                    ),
                                    title: Text(widget.questionTitle),
                                    subtitle: Text(
                                        "User: ${widget.questionUserName}"),
                                    isThreeLine: false,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        15.0, 8.0, 8.0, 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          widget.questionDescription,
                                          style: TextStyle(height: 2.0),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return AppScaffold(
              pageTitle: PageTitles.discussion_forum,
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton.icon(
                              label: Text('Back'),
                              icon: Icon(Icons.navigate_before),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, RouteNames.discussion_forum);
                              },
                              style:
                                  ElevatedButton.styleFrom(primary: Colors.red),
                            )),
                        Row(
                          children: <Widget>[
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton.icon(
                                  label: Text('New answer'),
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          addNewAnswer(context),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.red),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 60.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.18,
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          elevation: 10,
                          child: Container(
                            height: 100,
                            child: Container(
                              alignment: Alignment.topLeft,
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: CircleAvatar(
                                      child: Text(widget.questionUserName[0]),
                                    ),
                                    title: Text(widget.questionTitle),
                                    subtitle: Text(
                                        "User: ${widget.questionUserName}"),
                                    isThreeLine: false,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        15.0, 8.0, 8.0, 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          widget.questionDescription,
                                          style: TextStyle(height: 2.0),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 60.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.6,
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: ListView.builder(
                        // reverse: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return BuildAnswerCard(
                              snapshot.data[index]["userName"],
                              snapshot.data[index]["description"]);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        });
  }

  // Widget BuildAnswerCard(int questionId, var questionTitle,
  //     var questionDescription, var questionUserName) {
  Widget BuildAnswerCard(var userName, var description) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          elevation: 10,
          child: Container(
            height: 80,
            child: Container(
              alignment: Alignment.topLeft,
              child: Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      child: Text(userName[0]),
                    ),
                    title: Text("Answer: ${description}"),
                    subtitle: Text("User: ${userName}"),
                    isThreeLine: false,
                  ),
                ],
              ),
            ),
          )),
    );
  }

  final _description = TextEditingController();

  String get _errorValidation {
    // at any time, we can get the text from _controller.value.text
    final text = _description.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    // return null if the text is valid
    return null;
  }

  Widget addNewAnswer(BuildContext context) {


    return AlertDialog(
      title: const Text("New Answer"),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _description,
            decoration:  InputDecoration(
              hintText: 'Answer Text',
              labelText: 'Answer Text',
              errorText: _errorValidation,
            ),

          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.red, shape: const RoundedRectangleBorder()),
          onPressed: () async {
            var aDescription = await _description.text;

            int randomId = Random().nextInt(99999);

            Map bodyData = {
              "id": randomId,
              "questionId": widget.questionId,
              "description": aDescription,
              "userName": _userName,
            };

            var body = json.encode(bodyData);

            String uri = ApiUrl.envUrl;
            final url = Uri.encodeFull("${uri}/answer");

            var response = await http.post(url,
                headers: {'Content-Type': 'application/json'}, body: body);
            print(response.body);

            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DiscussionForumSinglePage(
                      widget.questionId,
                      widget.questionTitle,
                      widget.questionDescription,
                      widget.questionUserName)),
            );
          },
          child: const Text('Submit'),
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.indigo, shape: const RoundedRectangleBorder()),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close')),
      ],
    );
  }
}
