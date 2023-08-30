import 'package:flutter/material.dart';


 
class HomePage extends StatefulWidget {
  const HomePage({super.key});


  @override
  State<HomePage> createState() =>_HomePageState();
}

class _HomePageState extends State<HomePage> {
  
 
  List<Map<String,dynamic>> QandA=[
    {
      "questions":"waht is your favorite sport",
      "answers" : [
        "football",
        "tennis",
        "basketball",
        "volleyball"
      ]

    },
    {
      "questions":"waht is your favorite color",
      "answers" : [
        "green",
        "blue",
        "red",
        "white"
      ]

    },
    {
      "questions":"waht is your favorite animal",
      "answers" : [
        "camel",
        "horse",
        "dog",
        "cat"
      ]

    }
  ];
  List <List> icon=[
    ["assets/image/football.png","assets/image/tennis-ball.png","assets/image/basketball-ball-variant.png","assets/image/volleyball.png"],
    ["assets/image/stain.png","assets/image/blue.png","assets/image/splash.png","assets/image/splash (2).png"],
    ["assets/image/camel.png","assets/image/horse.png","assets/image/dog.png","assets/image/cat.png"]
  ];
  
  List<String> correct_answers=[ "tennis","white", "camel"];
  void resetQuiz(){
    setState(() {
      index=0;
      step=0;
    correct_answers_count=0; 
    shwoResultMessage=false;     
    });
    
  }
  int index=0,step=0;
  int? yourChoiceIndex;
  int correct_answers_count=0;
  bool shwoResultMessage=false;
  late String answer;
  @override
  Widget build(BuildContext context) {
     final  qa =QandA[index];
    return Scaffold(     
      body:SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width*0.02),
          
          child: shwoResultMessage!=true?Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
                      
            children: [
           
            SizedBox(height: MediaQuery.of(context).size.height*0.09,),
            
           

             Text(qa["questions"].toString(),
             style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
             ),
             ),
             const SizedBox(height: 16.0,),
             const Text("Answer and get points",
             style: TextStyle(
              fontSize: 18,
              color: Colors.black54,
             ),
             ),
              SizedBox(height: MediaQuery.of(context).size.height*0.09,),
              Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                LinearProgressIndicator(
                  backgroundColor: Colors.green[300],
                  value: step/QandA.length,
                  valueColor: AlwaysStoppedAnimation(Colors.green),
                  
                ),
                Text("${index+1}/${QandA.length}"),
              ],
            ),
              SizedBox(height: MediaQuery.of(context).size.height*0.09,),
              for(int i=0;i<qa["answers"].length;i++,)
                Padding(
                  padding: EdgeInsets.only(bottom:16.0 ),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        yourChoiceIndex=i;
                      });                      
                    },
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        color:i!=yourChoiceIndex? Colors.white:Colors.green,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.3) 
                        )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Image(image: AssetImage(icon[index][i])),
                            
                            SizedBox(width: 16.0,),
                            Text(
                              qa["answers"][i],
                              style: TextStyle(
                                color:i==yourChoiceIndex? Colors.white:Colors.green,
                            ),),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () { 
                      setState(() {
                        if(yourChoiceIndex!=null){
                          step++;
                          if(qa["answers"][yourChoiceIndex]==correct_answers[index])
                           correct_answers_count++;
                          if (index<QandA.length-1) index++; 
                          else 
                           shwoResultMessage=true; ;
                         
                        }  
                        else
                         ScaffoldMessenger.of(context).showSnackBar(
                           const SnackBar(
                            showCloseIcon: true,
                            padding: EdgeInsets.all(20),
                            backgroundColor: Colors.grey,
                            width: double.infinity,
                            behavior: SnackBarBehavior.floating,
                            duration: Duration(
                              seconds: 3,
                            ),
                            content: Text(
                              "You must choose one of the answers",
                            style:TextStyle(
                              color: Colors.black
                              ) ,
                            ),
                            )
                         );
                         
                        
                        yourChoiceIndex=null;                  
                      });
                       
                     },
                  child: Text("Next"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)
                    )
                  ),
                
                  ),
                ),
                ]
                ):Center(
                  child: Column(
                    
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                              const Text("the quiz is ended"),
                              SizedBox(height:MediaQuery.of(context).size.height*0.01 ,),
                              Text("your score $correct_answers_count/${QandA.length}"),
                              IconButton(
                                onPressed: resetQuiz,
                                 icon:const Icon(
                                  Icons.replay_circle_filled_rounded,
                                 )
                                  ),
                                 
                              
                     ] ),
                ) 
          
                     
          
          
            
        
          
            
          ),
      )
            
      
    );
  }
}