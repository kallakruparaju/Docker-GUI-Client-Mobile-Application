import 'package:flutter/material.dart';
import 'Dashboard/Dashboard.dart';
import 'package:url_launcher/url_launcher.dart';




void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Docker Client',
    theme: ThemeData(fontFamily: 'Raleway'),
    home: MyApp(),
    
    )
    
  );
}

_launchURL() async {
  const url = 'https://youtu.be/yAWMV4nEyLg';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
class MyApp extends StatelessWidget {
  @override

  String endpoint='';
  String port='';
  String url='';
  
  Widget build(BuildContext context){
        return Scaffold(
             
             appBar: AppBar(
               title: Text('Docker Server'),
               actions: [
               IconButton(
               onPressed: _launchURL,
               icon: Icon(Icons.help),
              ),
             ],
               
             ),
              body:  SingleChildScrollView(
              
              
               child: Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.stretch,
                 children: <Widget>[
                 
                 Container(
                     
                     margin: EdgeInsets.all(10),
                     padding: EdgeInsets.all(10),
                child: Column(
                 children: <Widget>[
                 

                  SizedBox(height:2),
                  Card(
                  child: TextField(
                    onChanged: (value){
                       endpoint = value;
                    
                    },
                    autocorrect: false,
                    decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "(eg: http://192.168.43.18) ",
                    labelText: "Server Endpoint",
                  
                  ),
                  ),
                  ),
                  SizedBox(height:2),
                  Card(
                  child: TextField(
                    onChanged: (value){
                       port  = value;
                    
                    },
                    autocorrect: false,
                    decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "(eg: 1234) ",
                    labelText: "Server port",
                  
                  ),
                  ),
                  ),
  
                  SizedBox(height:15),
                  ElevatedButton(
                  onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Dashboard(value: "$endpoint:$port")),
            );
          },
                  child: Text('View Dashboard'),
                  style: ElevatedButton.styleFrom(
                      
                      padding: EdgeInsets.symmetric(horizontal: 80, vertical: 20),
                  ),
                  ),
                  ],
                  ),
                  
                  ),

               
               ],
             ),
             ),
             
       
        );
    }
}
