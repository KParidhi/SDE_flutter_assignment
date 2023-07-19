import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class MyCupertinoButton extends StatefulWidget {
  const MyCupertinoButton({super.key,});

  @override
  State<MyCupertinoButton> createState() => _MyCupertinoButtonState();
}

class _MyCupertinoButtonState extends State<MyCupertinoButton> {
  @override
  Widget build(BuildContext context) {
     return Container(
          height: 50,
                decoration: BoxDecoration(color: Colors.blue.shade400,
                borderRadius: BorderRadius.circular(20)),
                child: SizedBox(
                    height: 50,
                    width: 200,
                 child: CupertinoButton(
                          onPressed:( ){},
                          child: Row(
                            children: [
                           const Expanded(child: Text(
                              "BOOK NOW",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),)),
                              Container(
                                decoration: BoxDecoration(

                                  color: Colors.blue.shade600,
                                  shape: BoxShape.circle,
                                ),
                                child:const Icon(Icons.arrow_forward,
                                  color: Colors.white,

                                ),
                              ),
                            ],
                          )


                      ),
                    ),





     );
  }
}
