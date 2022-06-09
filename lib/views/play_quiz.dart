import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_app/models/question_model.dart';
import 'package:flutter_project_app/services/database.dart';
import 'package:flutter_project_app/views/result.dart';
import 'package:flutter_project_app/widgets/quiz_play_widgets.dart';
 
import '../widgets/widgets.dart';

class PlayQuiz extends StatefulWidget {

  final String quizId;
  PlayQuiz(this.quizId);
  @override
  _PlayQuizState createState() => _PlayQuizState();
}

int total = 0;
int _correct = 0;
int _incorrect = 0;
int _notAttempted = 0;

class _PlayQuizState extends State<PlayQuiz> {
  late QuerySnapshot qstSnapShot;
  DatabaseService databaseService = new DatabaseService();

  @override
  void initState(){
    print("${widget.quizId}");
    //initData();
    //await
    databaseService.getQuizData(widget.quizId).then((value){
      qstSnapShot = value;
      _notAttempted = 0;
      _correct = 0;
      _incorrect = 0;
      total = qstSnapShot.docs.length;
      setState(() {});
    }
    );
    super.initState();
  }


  QuestionModel getQuestionModelFromDatasnapshot (DocumentSnapshot<Map<String,dynamic>> questionSnapshot) {
    QuestionModel questionModel = new QuestionModel();
    questionModel.question = questionSnapshot.data()!["question"];
    List<String> options = [
      questionSnapshot.data()!["option1"],
      questionSnapshot.data()!["option2"],
      questionSnapshot.data()!["option3"],
      questionSnapshot.data()!["option4"]
    ];
    options.shuffle();

    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];
    questionModel.correctOption = questionSnapshot.data()!["option1"];
    questionModel.answered = false;
    return questionModel;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.black54
        ),
        brightness: Brightness.light,
      ),
      body: Container(
        child: ListView(
          children: [
            if (qstSnapShot.docs == null)
              Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            else ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 24),
                  shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: qstSnapShot.docs.length,
                  itemBuilder: (context, index){
                      return QuizPlayTile(
                        questionModel : getQuestionModelFromDatasnapshot(qstSnapShot.docs[index] as DocumentSnapshot<Map<String,dynamic>>),
                        index: index,
                      );
                  },
                )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: (){
          int correct;
          int incorrect;

          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => Results(
                  correct = _correct,
                  incorrect = _incorrect,
                  total = total)
          ));
        },
      ),
    );
  }
}

class QuizPlayTile extends StatefulWidget {
  final QuestionModel questionModel;
  final int index;
  QuizPlayTile({required this.questionModel, required this.index});

  @override
  _QuizPlayTileState createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {
  String optionSelected = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Q${widget.index+1} ${widget.questionModel.question}", style: TextStyle(fontSize: 18,color:Colors.black87),),
          SizedBox(height: 12,),
            //Add this to the child//
            GestureDetector(
              onTap: (){
                if(!widget.questionModel.answered){
                  ///correct
                  if(widget.questionModel.option1 == widget.questionModel.correctOption){
                    optionSelected = widget.questionModel.option1;
                    widget.questionModel.answered = true;
                    _correct = _correct +1;
                    _notAttempted = _notAttempted -1;
                    setState((){
                    });
                  }else{
                    optionSelected = widget.questionModel.option1;
                    widget.questionModel.answered = true;
                    _incorrect = _incorrect+1;
                    _notAttempted = _notAttempted-1;
                  }
                }
              },
              child: OptionTile(
                  option: "A",
                  description: widget.questionModel.option1,
                  correctAnswer: widget.questionModel.correctOption,
                  optionSelected: optionSelected
              ),
            ),
            SizedBox(height: 4,),
            GestureDetector(
              onTap: (){
                if(!widget.questionModel.answered){
                  ///correct
                  if(widget.questionModel.option2 == widget.questionModel.correctOption){
                    optionSelected = widget.questionModel.option2;
                    widget.questionModel.answered = true;
                    _correct = _correct +1;
                    _notAttempted = _notAttempted -1;
                    setState((){
                    });
                  }else{
                    optionSelected = widget.questionModel.option2;
                    widget.questionModel.answered = true;
                    _incorrect = _incorrect+1;
                    _notAttempted = _notAttempted-1;
                  }
                }
              },
              child: OptionTile(
                  option: "B",
                  description: widget.questionModel.option2,
                  correctAnswer: widget.questionModel.correctOption,
                  optionSelected: optionSelected
              ),
            ),
          SizedBox(height: 4,),
          GestureDetector(
            onTap: (){
              if(!widget.questionModel.answered){
                ///correct
                if(widget.questionModel.option3 == widget.questionModel.correctOption){
                  optionSelected = widget.questionModel.option3;
                  widget.questionModel.answered = true;
                  _correct = _correct +1;
                  _notAttempted = _notAttempted -1;
                  setState((){
                  });
                }else{
                  optionSelected = widget.questionModel.option3;
                  widget.questionModel.answered = true;
                  _incorrect = _incorrect+1;
                  _notAttempted = _notAttempted-1;
                }
              }
            },
            child: OptionTile(
                  option: "C",
                  description: widget.questionModel.option3 ,
                  correctAnswer: widget.questionModel.correctOption,
                  optionSelected: optionSelected
              ),
          ),
          SizedBox(height: 4,),
              GestureDetector(
                onTap: (){
                  if(!widget.questionModel.answered){
                    ///correct
                    if(widget.questionModel.option4 == widget.questionModel.correctOption){
                      optionSelected = widget.questionModel.option4;
                      widget.questionModel.answered = true;
                      _correct = _correct +1;
                      _notAttempted = _notAttempted -1;
                      setState((){
                      });
                    }else{
                      optionSelected = widget.questionModel.option4;
                      widget.questionModel.answered = true;
                      _incorrect = _incorrect+1;
                      _notAttempted = _notAttempted-1;
                    }
                  }
                },
                child: OptionTile(
                  option: "D",
                  description: widget.questionModel.option4 ,
                  correctAnswer: widget.questionModel.correctOption,
                  optionSelected: optionSelected
            ),
              ),
          SizedBox(height: 20,)
        ],
      ),
    );
  }
}





