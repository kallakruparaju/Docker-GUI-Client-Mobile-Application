import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'Containers/Containers.dart';
import 'Containers/Post.dart';
import 'createContainer.dart';



class GetContainers extends StatefulWidget{
  String value;
  GetContainers({required this.value});

  @override
  _GetContainersState createState() => _GetContainersState(value);
}

var refreshKey = GlobalKey<RefreshIndicatorState>();

class _GetContainersState extends State<GetContainers> {
  String value;
  _GetContainersState(this.value);
  List<Post> getContainers=[];
  bool loading=false;
  
  void startcontainer(String id) async {
        
        String url='$value/containers/$id/start';
        print(url);
        
        final response = await http.post(        
          url,
          headers: <String,String>{
               'Content-Type': 'application/json',
          }, 

          );
	if (response.statusCode == 204) {
                   Fluttertoast.showToast(
                      msg: "Container started successfully",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                     textColor: Colors.white,
                     fontSize: 16.0
                );
   
        }
        else {
                   Fluttertoast.showToast(
                      msg: "Container started unsuccessfully",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                     textColor: Colors.white,
                     fontSize: 16.0
                );
   
        }
            
       }
   void stopcontainer(String id) async {
        
        String url='$value/containers/$id/stop';
        print(url);
        
        final response = await http.post(        
          url,
          headers: <String,String>{
               'Content-Type': 'application/json',
          }, 

          );
          if (response.statusCode == 204) {
                   Fluttertoast.showToast(
                      msg: "Container stopped successfully",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                     textColor: Colors.white,
                     fontSize: 16.0
                );
   
        }
        else {
                   Fluttertoast.showToast(
                      msg: "Container stoped unsuccessfully",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                     textColor: Colors.white,
                     fontSize: 16.0
                );
   
        }
            
       }
       
        void deletecontainer(String id) async {
        
        String url='$value/containers/$id?force=true';
        print(url);
        
        final response = await http.delete(        
          url,
          headers: <String,String>{
               'Content-Type': 'application/json',
          }, 

          );
        if (response.statusCode == 204) {
                   Fluttertoast.showToast(
                      msg: "Container deleted successfully",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                     textColor: Colors.white,
                     fontSize: 16.0
                );
   
        }
        else {
                   Fluttertoast.showToast(
                      msg: "Container deleted unsuccessfully",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                     textColor: Colors.white,
                     fontSize: 16.0
                );
   
        }
        
            
       }
  
  @override
    void initState(){
         super.initState();
         loading=true;
         Containers.getPosts(value).then((list){
            setState((){
              getContainers = list!;
              loading=false;
            });
         });
         }
         
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Containers"),
        centerTitle: true,
                 actions: [
               IconButton(
               onPressed: () {
                  Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CreateContainer(value: value)),
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
          itemCount: getContainers.length,
          itemBuilder: (context, int index) {
            Post post=getContainers[index];

            return Slidable(
              actions: <Widget>[
                IconSlideAction(
                  icon: Icons.not_started,
                  caption: 'Start',
                  color: Colors.green,
                  onTap: () {
                         startcontainer("${post.id}");
                  }
                ),
                IconSlideAction(
                  icon: Icons.stop,
                  caption: 'Stop',
                  color: Colors.red,
                  onTap: () {
                         stopcontainer("${post.id}");
                  }
                ),
              ],
              
              secondaryActions: <Widget>[
                IconSlideAction(
                  icon: Icons.clear,
                  color: Colors.red,
                  caption: 'Delete',
                  onTap: () {
                           deletecontainer("${post.id}");
                       }
                ),
                
              ],
              child: ListTile(
                
                title: Text("${post.names}",
                       style: TextStyle(
                        // color: Colors.white,
                         fontWeight: FontWeight.bold,
                        fontSize: 20
                      ),
                ),
                subtitle: Text("${post.image}"),
               //leading: Text("${post.names}"),
                trailing: Text("${post.state}"),
                
                
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
         Containers.getPosts(value).then((list){
            setState((){
              getContainers = list!;
              loading=false;
            });
         });
    });
  }
  
}

