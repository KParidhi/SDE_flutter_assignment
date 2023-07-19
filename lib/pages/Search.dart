import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:gfglogin/models/postsModel.dart';
import 'package:gfglogin/pages/eventDetals.dart';
import 'package:gfglogin/pages/homePage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';


class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {

  Future<PostsModel> getPostsApi () async {
    final response = await http.get(Uri.parse("https://sde-007.api.assignment.theinternetfolks.works/v1/event"));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode==200){
      return PostsModel.fromJson(data);
    }else
    {
      return PostsModel.fromJson(data);
    }
  }

  String searchedVal="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading:
        InkWell(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>const  homePage(),
                ),
              );

            },
            child:const  Icon(Icons.keyboard_backspace,color: Colors.black,size: 30,)),
        title:Column(
          children: [
            const   Text(
              "Search",style: TextStyle(color: Colors.black,fontSize: 25),
            ),
          ],
        ),
      ),
      body: Column(
          children:[
            Padding(
               padding: const EdgeInsets.only(top: 10),
      child: Container(
          height: 60,
          width: 390,
          child: Card(
            elevation: 0,
            child: TextFormField(
                decoration: InputDecoration(
                  prefixIcon:Icon(Icons.search,color: Colors.blue.shade600
                  ),
                  border: InputBorder.none,
                  hintText: "|    Type Event Name",
                hintStyle:const  TextStyle(fontSize: 20)),
                onChanged: (val){
                  setState(() {
                    searchedVal=val;
                  });

                }),
          )
      ),
    ),
    Expanded(child:
    FutureBuilder<PostsModel>(
      future: getPostsApi(),
      builder: (context,snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
            return const  Center(child: CircularProgressIndicator());
          }
        if (snapshot.hasError) {
         // print("neha.....");
         // print(snapshot.error);
         // print("kaushik.....");
          return const Center(child: CircularProgressIndicator());
        }
          List<Widget> searchResults = [];


          for (var eventData in snapshot.data!.content!.data!) {
            DateTime dateTime = DateTime.parse(eventData.dateTime!);
            String formattedDateTime = formatDate(dateTime);
            String? organizerIconUrl = eventData.organiserIcon;

            if (searchedVal.isEmpty ||
                eventData.title!.toString().toLowerCase()
                    .contains(searchedVal.toLowerCase())) {
              searchResults.add(
                  Padding(padding:const  EdgeInsets.only(left: 8, right: 8),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  eventDetails(
                                      event: eventData),
                            ),
                          );
                        },
                        child: Card(
                            child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius
                                            .circular(8),
                                        child: Container(
                                          height: 110,
                                          width: 100,
                                          child:loadIcon(organizerIconUrl),
                                          // Image(
                                          //     image: NetworkImage(
                                          //       eventData.organiserIcon!,
                                          //     ),
                                          //     fit: BoxFit.cover
                                          // ),
                                        )
                                    ),
                                  ),
                                  const    SizedBox(width: 8,),

                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("1st   " +
                                            formattedDateTime,
                                          style: TextStyle(
                                              color: Colors.blue.shade700
                                          ),
                                        ),
                                        const     SizedBox(height: 5),
                                        Text(
                                          eventData.title!,
                                          style:const  TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 19
                                          ),
                                        ),
                                        const   SizedBox(height: 8,),
                                      ],
                                    ),
                                  ),
                                ]
                            )
                        ),
                      ),


                  )
              );
            }
          }

          return ListView(
            children: searchResults,
          );
        }
        
    )


    )
          ]
      )
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
    }
    else {
      //If the organizerIconUrl is null or empty, show a placeholder container.
      return const  Icon(
        Icons.person, // Replace this with the default icon you want to display.
        size: 50,
      );
    }
  }


    String formatDate(DateTime dateTime) {
      String formattedDate = DateFormat('MMMM - EEE').format(dateTime);
      String formattedTime = DateFormat(' - hh:mm a').format(dateTime);
      return '$formattedDate  $formattedTime';
    }

}
