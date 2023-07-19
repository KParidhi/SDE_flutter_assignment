import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gfglogin/models/postsModel.dart';
import 'package:gfglogin/pages/Search.dart';
import 'package:gfglogin/pages/eventDetals.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {

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




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
     title:
       const Text("Events",
          style:TextStyle(
            color: Colors.black,
            fontSize: 25
          ) ,),

     // ),
        actions: [
          InkWell(child: Image.asset("lib/widgets/img_1.png",width: 28,height: 28,),
            onTap:(){Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>const Search(),
              ),
            );
          }
          ),
         const SizedBox(width: 10,),
          IconButton(onPressed:(){}
              , icon:const Icon(
                  Icons.more_vert,
                color: Colors.black,
                size: 30,
              )),
        ],
    ),
      body: Column(
        children: [
          Expanded(
              child:FutureBuilder<PostsModel>(
                future:getPostsApi(),
                builder: (context,snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.content!.data!.length,
                        itemBuilder: (context, index) {

                          DateTime dateTime = DateTime.parse(snapshot.data!.content!.data![index].dateTime!);
                          String formattedDateTime = formatDate(dateTime);
                          String? organizerIconUrl = snapshot.data!.content!.data![index].organiserIcon;

                          return Padding(
                            padding:const EdgeInsets.only(left: 8,right: 8),
                            child: InkWell(
                              onTap:(){ Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => eventDetails(
                                      event: snapshot.data!.content!.data![index]),
                              ),
                              );
                              },
                              child: Card(
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: ClipRRect(
                                        borderRadius:BorderRadius.circular(8),
                                        child:Container(
                                          height:110,
                                            width: 100,
                                            child:loadIcon(organizerIconUrl),
                                        //     Image(
                                        // image: NetworkImage(
                                        //   snapshot.data!.content!.data![index].organiserIcon!,
                                        // ),
                                        //       fit: BoxFit.cover
                                        //     ),
                                        )
                                        ),
                                    ),
                                   const SizedBox(width: 8,),

                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                              Text(
                                                        formattedDateTime,
                                                        style: TextStyle(
                                                          color: Colors.blue.shade700
                                                        ),
                                                          ),

                                             const   SizedBox(height: 5),
                                                Text(
                                                  snapshot.data!.content!.data![index].title!,
                                                  style:const  TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                      fontSize: 19
                                                  ),
                                                ),
                                                const    SizedBox(height: 8,),
                                                  Row(
                              mainAxisAlignment: MainAxisAlignment.start
                                                    ,children: [
                                                    const    Icon(Icons.location_on_sharp,color: Colors.grey,
                                                      size: 18,),
                                                   //SizedBox(width: 4,),
                                                      Flexible(
                                                        child: Text(snapshot.data!.content!.data![index].venueName!,
                                                          style:const  TextStyle(color: Colors.grey,
                                                          ),),
                                                      ),
                                                      Flexible(
                                                          child:Text(
                                                            " • "+snapshot.data!.content!.data![index].venueCity!,
                                                          style:const  TextStyle(
                                                            color: Colors.grey
                                                          ),
                                                     )
                                                        )
                                                    ],
                                                  ),

                                              ],
                                            ),
                                          ),
                                ]
                                )
                              ),
                            ),
                          );
                        }
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }
              )
          )
        ],
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
    } else {
      // If the organizerIconUrl is null or empty, show a placeholder container.
      return Container(
        color: Colors.grey, // Placeholder color or any other indicator.
      );
    }
  }

  String formatDate(DateTime dateTime) {
    String formattedDate = DateFormat('EEE, MMM d').format(dateTime);
    String formattedTime = DateFormat('hh:mm a').format(dateTime);
    return '$formattedDate • $formattedTime';
  }

}

