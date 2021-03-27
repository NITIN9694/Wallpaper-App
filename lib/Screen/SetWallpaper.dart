import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class LarggeScree extends StatefulWidget {
  String imageurl;
  LarggeScree({this.imageurl});
  @override
  _LarggeScreeState createState() => _LarggeScreeState();
}

class _LarggeScreeState extends State<LarggeScree> {
  _save() async {
   var response = await Dio().get(
           widget.imageurl,
           options: Options(responseType: ResponseType.bytes));
   final result = await ImageGallerySaver.saveImage(
           Uint8List.fromList(response.data),
           quality: 60,
           name: "hello");
   print(result);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(  

      body: Container(
                child:
            Stack(
              children:[
              Container(
                height: 850,
                width: 500,
                child: CachedNetworkImage(imageUrl: widget.imageurl,fit: BoxFit.cover,)),
              Align(
                alignment: Alignment.bottomCenter,
                   child: Container(
                  height: 50,
                  width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color:Colors.grey
                ),
                  child: Center(
                    child: Text("Set as Wallpaper",style:TextStyle(
                       color:Colors.white,
                      fontSize: 20
                    )),
                  ),),
              )
               ]),
           ),
        );
  }
}
