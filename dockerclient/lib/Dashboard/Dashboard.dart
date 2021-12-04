import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http_parser/http_parser.dart';
import 'Containers/Post.dart';
import 'Images/Images.dart';
import 'Network/Network.dart';
import 'dart:convert';
import 'Volumes.dart';
import 'getContainers.dart';
import 'getImages.dart';
import 'getNetwork.dart';





class Dashboard extends StatefulWidget {
  String value;
  Dashboard({required this.value});

  @override
  _DashboardState createState() => _DashboardState(value);
}



class Services{
   static Future<List<Post>?> getPosts(String value) async{
   final response = await http.get('$value/containers/json?all=1');
   final List<Post> listPosts=postFromJson(response.body);
   print(listPosts);
   return listPosts;  
   }
}

   var refreshKey = GlobalKey<RefreshIndicatorState>();


class _DashboardState extends State<Dashboard> {
  String value;
  _DashboardState(this.value);
   List<Post> containers=[];
   List<Post> images=[];
   List<Post> network=[];
   Map<String, dynamic> data={" ": []};
   bool loading=false;
   
   Future<Map<String, dynamic>> getVolumes() async {
      final response = await http.get(Uri.parse("$value/volumes"));
      return json.decode(response.body);
   }
   




  @override
    void initState(){
         super.initState();
         loading=true;
         Services.getPosts(value).then((list){
            setState((){
              containers = list!;
              loading=false;
            });
         });
         Images.getPosts(value).then((list){
            setState((){
              images = list!.cast<Post>();
              loading=false;
            });
         });
         Network.getPosts(value).then((list){
            setState((){
              network = list!.cast<Post>();
              loading=false;
            });
         });
         getVolumes().then((data) {
      setState(() {
        this.data = data; 
        loading = false;
      });
    });

    }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Docker Server Dashboard',
                       style: TextStyle(
                       color: Colors.white,
                       fontWeight: FontWeight.bold,
                       fontSize: 20
                      ),
                    ),
                    elevation: 10,
      ),
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: refreshList,
        child: ListView(
          children: [
            for (int i = 0; i < 1; i++)
              Card(
                elevation: 5,
                child: SingleChildScrollView(
                child: Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.stretch,
                 children: <Widget>[
                 Container(
                //height: double.infinity,
                //color: Color.fromARGB(255, 4, 31, 48),
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.stretch,
                   
                   children: [
                     SizedBox(height: 30),
                     Center(
                     child: Text('Docker Dashboard',
                       style: TextStyle(
                       color: Colors.black,
                       fontWeight: FontWeight.bold,
                       fontSize: 30
                      ),
                    ),),
                     
                     SizedBox(height:60),
                     
                     ElevatedButton(onPressed: (){
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GetContainers(value: value)),
                        );
                       },
                       child: Text("Containers : ${containers.length}"),
                       style: ElevatedButton.styleFrom(
                       padding: EdgeInsets.symmetric(horizontal: 80, vertical: 20),
                      
                      textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        
                      ),
                      elevation:5,
                      ),
                      ),
                     
                     SizedBox(height:15),
                    ElevatedButton(onPressed: (){
                        
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GetImages(value: value)),
                        ); 
                       },
                       child: Text('Images : ${images.length}'),
                       style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 80, vertical: 20),
                      textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        
                      ),
                      ),
                      ),
                     SizedBox(height:15),
                     ElevatedButton(onPressed: (){
                         Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GetNetwork(value: value)),
                        );
                       },
                       child: Text('Network : ${network.length}'),
                       style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                      textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        
                      ),
                      ),
                      ),
                     SizedBox(height:15),
                    ElevatedButton(onPressed: (){
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Volumes(value: value)),
                        );
                       },
                       child: loading ? Text("Volumes : 0") : Text('Volumes : ${data["Volumes"].length}'),
                       //child: Text('Volumes : ${data["Volumes"].length}'),
                       style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                      textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        
                      ),
                      ),
                      ),
                     SizedBox(height:250),
                     
                   ],),

                 ),
            
               ],
             ),
              ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      loading=true;
         Services.getPosts(value).then((list){
            setState((){
              containers = list!;
              loading=false;
            });
         });
         Images.getPosts(value).then((list){
            setState((){
              images = list!.cast<Post>();
              loading=false;
            });
         });
         Network.getPosts(value).then((list){
            setState((){
              network = list!.cast<Post>();
              loading=false;
            });
         });
         getVolumes().then((data) {
      setState(() {
        this.data = data; 
        loading = false;
      });
    });
    });
  }
}
