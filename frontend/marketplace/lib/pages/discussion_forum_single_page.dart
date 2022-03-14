import 'package:flutter/material.dart';
import 'package:marketplace/constants/route_names.dart';

import '../constants/page_titles.dart';
import '../widgets/app_scaffold.dart';
import '../constants/constants.dart' as Constants;

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
  var _sampleForumQuestions = Constants.SAMPLE_ANSWERS_DF2;

  @override
  Widget build(BuildContext context) {
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
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                    )),
                Row(
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton.icon(
                          label: Text('New answer'),
                          icon: Icon(Icons.add),
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                        ))
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 60.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width * 0.6,
              child: ListView.builder(
                itemCount: _sampleForumQuestions.length,
                itemBuilder: (context, index) {
                  return SingleQuestionCard2(
                    _sampleForumQuestions[index]['questionId'],
                    _sampleForumQuestions[index]['questionTitle'],
                    _sampleForumQuestions[index]['questionDescription'],
                    _sampleForumQuestions[index]['questionUserName'],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget SingleQuestionCard2(int questionId, var questionTitle,
      var questionDescription, var questionUserName) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          elevation: 10,
          child: Container(
            height: 100,
            child: Expanded(
              child: Container(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Expanded(
                      flex: 4,
                      child: ListTile(
                        title: Text(questionTitle),
                        subtitle: Text(questionDescription),
                        isThreeLine: false,
                        // onTap: () {
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => DiscussionForumSinglePage(
                        //             questionTitle,
                        //             questionDescription,
                        //             questionId,
                        //             questionUserName)),
                        //   );
                        // },
                      ),
                    ),
                  ],
                ),
              ),
              flex: 8,
            ),
          )),
    );
  }
}
