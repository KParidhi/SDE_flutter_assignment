

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gfglogin/models/postsModel.dart';
import 'package:gfglogin/widgets/MyCupertinoButton.dart';
import 'package:gfglogin/widgets/description.dart';
import 'package:gfglogin/pages/homePage.dart';
import 'package:intl/intl.dart';
class eventDetails extends StatefulWidget {
  final Data event;

  const eventDetails ({Key? key, required this.event}) : super(key: key);

  @override
  State<eventDetails > createState() => _eventDetailsState();
}

class _eventDetailsState extends State<eventDetails > {
  



  @override
  Widget build(BuildContext context) {
    DateTime eventDateTime = DateTime.parse(widget.event.dateTime!);
    String formattedDate = formatDate(eventDateTime);
    String formattedTime = formatTime(eventDateTime);
    //String? organizerIconUrl = widget.event.organiserIcon;
    return Scaffold(
      body:
              Stack(
                children: [
                  Positioned(
                      left: 0,
                      right: 0,
                      child:Container(
                        child: Image(
                            image: NetworkImage(
                              widget.event.bannerImage!,
                            ),
                            fit: BoxFit.cover
                        ),
                      )
                  ),
                  Positioned(
                      left: 15,
                      right: 15,
                      top: 35,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>const  homePage(),
                                ),
                              );
                            }
                            ,child:const  Icon(Icons.arrow_back,
                                color: Colors.white,
                                size: 35,
                              ),
                          ),
                          const   SizedBox(width: 10,),
                          const  Text(
                              "Event Details",
                                  style:TextStyle(
                                    fontSize: 30,
                                    color: Colors.white
                                  )
                          ),
                          const   Spacer(),
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color:const  Color.fromARGB(50, 22, 44, 33),
                                borderRadius: BorderRadius.circular(8)
                            ),
                            child:const  Icon(Icons.bookmark,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                        ],
                      )),
                  Positioned(
                    top: 240,
                      left: 20,
                      child: Text(widget.event.title!,
                      style:const  TextStyle(
                        color: Colors.black,
                        fontSize: 40
                      ),)),
                  Positioned(
                    top:300,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20,top: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Container(
                              height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                        //color: Color.fromARGB(100, 22, 44, 33),
                          borderRadius: BorderRadius.circular(8)
                    ),
                                child: loadIcon(
                                widget.event.organiserIcon,
                                )),
                            const     SizedBox(width: 8,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.event.organiserName!,
                                style:const  TextStyle(
                                  color: Colors.black,
                                  fontSize:15
                                ),),
                                const   SizedBox(height: 8,),
                                const  Text("Organizer",
                                  style: TextStyle(
                                 color: Colors.grey,
                           ),)
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top:380,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20,top: 20,),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Container(
                              height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(15)
                                ),
                                child: Icon(
                                  Icons.calendar_month_outlined,
                                  size: 35,
                                  color: Colors.blue.shade400,)),
                            const  SizedBox(width: 8,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  formattedDate
                                  ,style:const  TextStyle(
                                      color: Colors.black,
                                      fontSize:18
                                  ),),
                                const  SizedBox(height: 8,),
                                Text(formattedTime,
                                  style:const  TextStyle(
                                    color: Colors.grey,
                                  ),)
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top:460,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20,top: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Container(
                              height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(15)
                                ),
                                child: Icon(
                                  Icons.location_on,
                                  size: 35,
                                  color: Colors.blue.shade400,)),
                            const  SizedBox(width: 8,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.event.venueName!
                                  ,style:const  TextStyle(
                                      color: Colors.black,
                                      fontSize:20
                                  ),),
                                const   SizedBox(height: 8,),
                                Text(widget.event.venueCity!+", "+widget.event.venueCountry!,
                                  style:const  TextStyle(
                                    color: Colors.grey,
                                  ),)
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                  ,Positioned(
                    left: 0, right: 0, top: 530,
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                              padding:const  EdgeInsets.only(
                                  top: 5, bottom: 5,right: 250),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const  SizedBox(height: 20,),
                                  const   Text("About Event ",
                                    style:  TextStyle(
                                        fontSize: 20
                                    ),)
                                ],
                              )
                          ),
                          Stack(
                            children:[ Container(
                              padding:const  EdgeInsets.only(left: 15,right: 8,top: 10),

                                child: SingleChildScrollView(
                                    child: Description(
                                        text: widget.event.description!)
                                ),
                              ),


                           ]
                          ),
                        ],
                      ),
                    ),
                  ),
                  const  Positioned(
                        top: 740,left: 70,right: 70,bottom: 8,
                        child: MyCupertinoButton()),

        ]

    ),
      );

  }

  Widget loadIcon(String? iconUrl) {
    if (iconUrl != null && iconUrl.isNotEmpty) {
      if (iconUrl.toLowerCase().endsWith('.svg')) {
        return SvgPicture.network(
          iconUrl,
          fit: BoxFit.cover,
        );
      } else {
        return Image.network(
          iconUrl,
          fit: BoxFit.cover,
        );
      }
    } else {
      // If the organizerIconUrl is null or empty, show a placeholder container.
      return Container(
        color: Colors.grey, // Placeholder color or any other indicator.
      );
    }
  }




  String formatDate(DateTime dateTime) {
    String formattedDate = DateFormat('dd MMMM, yyyy').format(dateTime);
    return formattedDate ;
  }

  String formatTime(DateTime dateTime) {
    String formattedDate = DateFormat("EEEE, "+'hh:mm a').format(dateTime);
    return formattedDate ;
  }
}
