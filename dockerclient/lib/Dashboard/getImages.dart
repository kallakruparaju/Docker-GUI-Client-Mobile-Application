
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'Images/Images.dart';
import 'Images/Post.dart';
import 'createImage.dart';



class GetImages extends StatefulWidget{
  String value;
  GetImages({required this.value});

  @override
  _GetImagesState createState() => _GetImagesState(value);
}

var refreshKey = GlobalKey<RefreshIndicatorState>();

class _GetImagesState extends State<GetImages> {
  String value;
  _GetImagesState(this.value);
  List<Post> getImages=[];
  bool loading=false;

       
        void deleteimage(String id) async {
        
        String url='$value/images/$id?force=true';
        print(url);
        
        final response = await http.delete(        
          url,
          headers: <String,String>{
               'Content-Type': 'application/json',
          }, 

          );
          if (response.statusCode == 200) {
                   Fluttertoast.showToast(
                      msg: "Image deleted successfully",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                     textColor: Colors.white,
                     fontSize: 16.0
                );
   
        }

            
       }
  
  @override
    void initState(){
         super.initState();
         loading=true;
         Images.getPosts(value).then((list){
            setState((){
              getImages = list!;
              loading=false;
            });
         });
         }
         
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Images"),
         actions: [
               IconButton(
               onPressed: () {
                  Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CreateImage(value: value)),
                        );
               },
               icon: Icon(Icons.add),
              ),
             ],  
      ),
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: refreshList,
        child: loading ? Text(" ") : ListView.separated(
          separatorBuilder: (context, index) => Divider(
                color: Colors.black,
              ),
          itemCount: getImages.length,
          itemBuilder: (context, int index) {
            Post post=getImages[index];

            return Slidable(
             
              
              secondaryActions: <Widget>[
                IconSlideAction(
                  icon: Icons.clear,
                  color: Colors.red,
                  caption: 'Delete',
                  onTap: () {
                           deleteimage("${post.id}");
                       }
                ),
                
              ],
              child: ListTile(
                
                title: Text("${post.repoTags}",
                       style: TextStyle(
                        // color: Colors.white,
                         fontWeight: FontWeight.bold,
                        fontSize: 20
                      ),
                      ),
                subtitle: Text("${post.id}"),
                /*leading: Text("${post.repoTags}",
                         style: TextStyle(
                        // color: Colors.white,
                         fontWeight: FontWeight.bold,
                        fontSize: 10
                      ),
                ),*/
               // trailing: Text("${post.id}"),
                
              ),
              actionPane: SlidableDrawerActionPane(),
            );
          }),
          ),
    );
  } 
  
 Future<void> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      loading=true;
         Images.getPosts(value).then((list){
            setState((){
              getImages = list!;
              loading=false;
            });
         });
    });
  }
}



/*
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'Images/Images.dart';
import 'Images/Post.dart';
import 'createImage.dart';

class GetImages extends StatefulWidget{
  String value;
  GetImages({required this.value});

  @override
  _GetImagesState createState() => _GetImagesState(value);
}

var refreshKey = GlobalKey<RefreshIndicatorState>();

class _GetImagesState extends State<GetImages> {
  String value;
  _GetImagesState(this.value);
  List<Post> getImages=[];
  bool loading=false;
  
   void deleteimage(String id) async {
        
        String url='$value/images/$id?force=true';
        print(url);
        
        final response = await http.delete(        
          url,
          headers: <String,String>{
               'Content-Type': 'application/json',
          }, 

          );

            
       }
  
  
  @override
    void initState(){
         super.initState();
         loading=true;
         Images.getPosts(value).then((list){
            setState((){
              getImages = list!;
              loading=false;
            });
         });
         }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Images"),
         actions: [
               IconButton(
               onPressed: () {
                  Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CreateImage(value: value)),
                        );
               },
               icon: Icon(Icons.add),
              ),
             ],  
      ),
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: refreshList,
        child: loading ? Text("No Data") : ListView.separated(
          separatorBuilder: (context, index) => Divider(
                color: Colors.black,
              ),
          itemCount: getImages.length,
          itemBuilder: (context, int index) {
            Post post=getImages[index];

            return Slidable(
             
              
              secondaryActions: <Widget>[
                IconSlideAction(
                  icon: Icons.clear,
                  color: Colors.red,
                  caption: 'Delete',
                  onTap: () {
                           deleteimage("${post.id}");
                       }
                ),
                
              ],
              child: ListTile(
                
              //  title: Text("${post.command}"),
               // subtitle: Text("${post.id}"),
                leading: Text("${post.repoTags}",
                         style: TextStyle(
                        // color: Colors.white,
                         fontWeight: FontWeight.bold,
                        fontSize: 10
                      ),
                ),
                trailing: Text("${post.id}"),
                
              ),
              actionPane: SlidableDrawerActionPane(),
            );
          }),
          
          ),
    );
    
    
  }
         
   Future<void> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      loading=true;
         Images.getPosts(value).then((list){
            setState((){
              getImages = list!;
              loading=false;
            });
         });
    });
  }
  
}

  
*/
