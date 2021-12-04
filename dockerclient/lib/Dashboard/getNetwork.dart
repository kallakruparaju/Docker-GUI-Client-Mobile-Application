import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'Network/Network.dart';
import 'Network/Post.dart';
import 'createNetwork.dart';

class GetNetwork extends StatefulWidget{
  String value;
  GetNetwork({required this.value});

  @override
  _GetNetworkState createState() => _GetNetworkState(value);
}

var refreshKey = GlobalKey<RefreshIndicatorState>();


class _GetNetworkState extends State<GetNetwork> {
  String value;
  _GetNetworkState(this.value);
  List<Post> getNetwork=[];
  bool loading=false;

       
        void deletenetwork(String id) async {
        
        String url='$value/networks/$id';
        print(url);
        
        final response = await http.delete(        
          url,
          headers: <String,String>{
               'Content-Type': 'application/json',
          }, 

          );
         if (response.statusCode == 204) {
                   Fluttertoast.showToast(
                      msg: "Network deleted successfully",
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
         Network.getPosts(value).then((list){
            setState((){
              getNetwork = list!;
              loading=false;
            });
         });
         }
         
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Networks"),
        actions: [
               IconButton(
               onPressed: () {
                  Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CreateNetwork(value: value)),
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
          itemCount: getNetwork.length,
          itemBuilder: (context, int index) {
            Post post=getNetwork[index];

            return Slidable(
             
              
              secondaryActions: <Widget>[
                IconSlideAction(
                  icon: Icons.clear,
                  color: Colors.red,
                  caption: 'Delete',
                  onTap: () {
                           deletenetwork("${post.id}");
                       }
                ),
                
              ],
              child: ListTile(
                
                title: Text("${post.name}",
                         style: TextStyle(
                        // color: Colors.white,
                         fontWeight: FontWeight.bold,
                        fontSize: 20
                      ),
                
                ),
                subtitle: Text("${post.id}"),
             //   leading: Text("${post.name}"),
             //   trailing: Text("${post.status}"),
                
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
         Network.getPosts(value).then((list){
            setState((){
              getNetwork = list!;
              loading=false;
            });
         });
    });
  }
}





















/*import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'Network/Network.dart';
import 'Network/Post.dart';



class GetNetwork extends StatefulWidget{
  String value;
  GetNetwork({required this.value});

  @override
  _GetNetworkState createState() => _GetNetworkState(value);
}


class _GetNetworkState extends State<GetNetwork> {
  String value;
  _GetNetworkState(this.value);
  List<Post> getNetwork=[];
  bool loading=false;

       
        void deletenetwork(String id) async {
        
        String url='$value/networks/$id';
        print(url);
        
        final response = await http.delete(        
          url,
          headers: <String,String>{
               'Content-Type': 'application/json',
          }, 

          );
          if (response.statusCode != 200) {
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
            
       }
  
  @override
    void initState(){
         super.initState();
         loading=true;
         Network.getPosts(value).then((list){
            setState((){
              getNetwork = list!;
              loading=false;
            });
         });
         }
         
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Network"),
      ),
      body: loading ? Text("No Data") : ListView.separated(
          separatorBuilder: (context, index) => Divider(
                color: Colors.black,
              ),
          itemCount: getNetwork.length,
          itemBuilder: (context, int index) {
            Post post=getNetwork[index];

            return Slidable(
             
              
              secondaryActions: <Widget>[
                IconSlideAction(
                  icon: Icons.clear,
                  color: Colors.red,
                  caption: 'Delete',
                  onTap: () {
                           deletenetwork("${post.id}");
                       }
                ),
                
              ],
              child: ListTile(
                
              //  title: Text("${post.command}"),
                subtitle: Text("${post.id}"),
                leading: Text("${post.name}",
                         style: TextStyle(
                        // color: Colors.white,
                         fontWeight: FontWeight.bold,
                        fontSize: 20
                      ),
                ),
             //   trailing: Text("${post.status}"),
                
              ),
              actionPane: SlidableDrawerActionPane(),
            );
          }),
    );
  } 
  
  
}
*/
