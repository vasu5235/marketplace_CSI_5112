import 'package:flutter/material.dart';

import '../constants/page_titles.dart';
import '../widgets/app_scaffold.dart';
import '../constants/constants.dart' as Constants;
import 'discussion_forum_single_page.dart';

class DiscussionForumPage extends StatefulWidget {
  const DiscussionForumPage({Key key}) : super(key: key);

  @override
  State<DiscussionForumPage> createState() => _DiscussionForumPageState();
}

class _DiscussionForumPageState extends State<DiscussionForumPage> {
  var _sampleForumQuestions = Constants.SAMPLE_QUESTIONS;

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
                      label: Text('New question'),
                      icon: Icon(Icons.add),
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(primary: Colors.red),
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
                itemCount: _sampleForumQuestions.length,
                itemBuilder: (context, index) {
                  return SingleQuestionCard(
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

  Widget SingleQuestionCard(int questionId, var questionTitle,
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
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DiscussionForumSinglePage(
                                    questionId,
                                    questionTitle,
                                    questionDescription,
                                    questionUserName)),
                          );
                        },
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
