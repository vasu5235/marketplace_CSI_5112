import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:marketplace/constants/api_url.dart';
import 'package:marketplace/constants/route_names.dart';

import '../constants/page_titles.dart';
import '../widgets/app_scaffold.dart';
import 'discussion_forum_single_page.dart';
import 'package:http/http.dart' as http;

class DiscussionForumPage extends StatefulWidget {
  const DiscussionForumPage({Key key}) : super(key: key);

  @override
  State<DiscussionForumPage> createState() => _DiscussionForumPageState();
}

class CustomFormField extends StatelessWidget {
  CustomFormField({
    Key key,
    this.hintText,
    this.inputFormatters,
    this.validator,
  }) : super(key: key);
  final String hintText;
  final List<TextInputFormatter> inputFormatters;
  final String Function(String) validator;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        inputFormatters: inputFormatters,
        validator: validator,
        decoration: InputDecoration(hintText: hintText),
      ),
    );
  }
}

class _DiscussionForumPageState extends State<DiscussionForumPage> {
  int _userId = -1;
  var _userName = "default user";

  Future getAllQuestions() async {
    _loadSession();
    var response = await http.get(Uri.parse(ApiUrl.get_questions));
    var jsonData = jsonDecode(response.body);
    return jsonData;
  }

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

  // var _sampleForumQuestions = Constants.SAMPLE_QUESTIONS;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAllQuestions(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Transform.scale(
              scale: 0.2,
              child: CircularProgressIndicator(),
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
                              label: Text('New question'),
                              icon: Icon(Icons.add),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      addNewQuestion(context),
                                );
                              },
                              style:
                                  ElevatedButton.styleFrom(primary: Colors.red),
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 60.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: ListView.builder(
                        reverse: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return SingleQuestionCard(
                            snapshot.data[index]['id'],
                            snapshot.data[index]['title'],
                            snapshot.data[index]['description'],
                            snapshot.data[index]['userName'],
                          );
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

  Widget SingleQuestionCard(int questionId, var questionTitle,
      var questionDescription, var questionUserName) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DiscussionForumSinglePage(questionId,
                  questionTitle, questionDescription, questionUserName)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            elevation: 10,
            child: Container(
              height: 125,
              child: Container(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text(questionUserName[0]),
                      ),
                      title: Text(questionTitle),
                      subtitle: Text("User: ${questionUserName}"),
                      isThreeLine: false,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 8.0, 8.0, 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            questionDescription,
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
    );
  }

  final _title = TextEditingController();
  final _description = TextEditingController();

  String get _errorValidation {
    // at any time, we can get the text from _controller.value.text
    final text = _title.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    // return null if the text is valid
    return null;
  }

  Widget addNewQuestion(BuildContext context) {
    return AlertDialog(
      title:  Text("New Question"),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _title,
            decoration:  InputDecoration(
              hintText: 'Question title',
              labelText: 'Question Title',
              errorText: _errorValidation
              // errorText:_errorValidation,
            ),
          ),
          Divider(),
          TextFormField(
              controller: _description,
              decoration:  InputDecoration(
                hintText: 'Question description',
                labelText: 'Description',
                errorText: _errorValidation
              ))
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.red, shape: const RoundedRectangleBorder()),
          onPressed: () async {
            var qTitle = await _title.text;
            var qDescription = await _description.text;

            int randomId = Random().nextInt(99999);

            Map bodyData = {
              "id": randomId,
              "title": qTitle,
              "description": qDescription,
              "userName": _userName,
            };

            var body = json.encode(bodyData);

            String uri = ApiUrl.envUrl;
            final url = Uri.encodeFull("${uri}/question");

            var response = await http.post(url,
                headers: {'Content-Type': 'application/json'}, body: body);

            Navigator.pop(context);
            await Navigator.pushNamed(context, RouteNames.discussion_forum);
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
