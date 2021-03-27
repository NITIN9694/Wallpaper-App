
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart'as http;
import 'package:wallpaper/Screen/SetWallpaper.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
 List data =[];
 bool _isShowdata =false;
 List<String> imageurl =[];

Future getdata()async{
http.Response response = await http.get("https://api.unsplash.com/photos?client_id=EmYdgZTJ1dIpfUhrWf58mWORErJBcYQTNUgXqwoUu8w");
data =json.decode(response.body);
setState(() {
  _isShowdata =true;
});
return jsonDecode(response.body);

}

_assgin(){
  for(var i=0; i<data.length;i++){
    imageurl.add(data.elementAt(i)["urls"]["row"]);
  }}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }
@override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
       Container(child:
      FutureBuilder<dynamic>(
        future: getdata(),
       builder: (BuildContext context,AsyncSnapshot snapshot){
         if(snapshot.hasData){
           List<dynamic> list=snapshot.data;
           print(snapshot.data.length);
           try {
             return SingleChildScrollView(
              child: Stack(
                          children:[ Column(
                   children: [
                     ListView.builder(
                       physics: ClampingScrollPhysics(),
                       itemCount: list.length,
                       shrinkWrap: true,
                       itemBuilder: (context,index ){
                         print(list[index]["urls"]["raw"]);
                         print("Hey");
                         return 
                               GestureDetector(
                                 onTap: (){
                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>LarggeScree(
                                   imageurl: list[index]["urls"]["raw"],
                                   )));
                                 },
                             child: GridView.count(
                               
                                   physics: ClampingScrollPhysics(),
                                       crossAxisCount: 2,
                                       mainAxisSpacing: 10.0,
                                       crossAxisSpacing: 10.0,
                                       shrinkWrap: true,
                                       children:List.generate(list.length, (index){
                                         return
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: GridTile(
                                            
                                                child: Container(
                                                  height: 500,
                                                  width: 700,
                                              decoration: BoxDecoration(
                                               borderRadius: BorderRadius.circular(20)
                                              ),
                                              child: ClipRRect(
                                                
                                                borderRadius: BorderRadius.circular(20),
                                             child:  CachedNetworkImage(
                                               imageUrl: list[index]["urls"]["raw"],fit:BoxFit.cover,
                                               height: 500,
                                               width:700 ,
                                            ),
                                              ),
                                          )));
                                        
                                       
                                       })
                                  
                                 ),
                               );
                               
                         
                       }),
                   ],
                 ),
              ],
              ),
             );
             
           } catch (e) {
             print(e);
           }
           
         }else{
           CircularProgressIndicator();
         }
       },
       )
      ));
  }
}