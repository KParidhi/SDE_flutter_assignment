import 'package:flutter/material.dart';
class Description extends StatefulWidget {
  final String text;
  const Description({super.key, required this.text});

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  late String first;
  late String second;
  bool hidden = true;
  double textHeight = 200.0;
  @override
  void initState(){
    super.initState();
    if(widget.text.length>textHeight){
      first = widget.text.substring(0,textHeight.toInt());
      second= widget.text.substring(textHeight.toInt()+1,widget.text.length);
    }else{
      first=widget.text;
      second="";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: second.isEmpty?Text(first):Column(
          children: [
            Text(
                hidden?(first+"..."):(first+second),
                    style: const TextStyle(
                      height: 1.5
                    ),),
            InkWell(
              onTap: (){
                 setState(() {
                   hidden=!hidden;
                 });
              },
              child:Row(
                children: [
                  Text(hidden?"Read More":"Read Less",
                    style: const TextStyle(color: Colors.blue),),
                  Icon(hidden?Icons.arrow_drop_down:Icons.arrow_drop_up,
                    color: Colors.black,),

                ],
              ) ,
            )
          ],
        ),
      ),
    );
  }
}
