import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';


class CreateContainer extends StatefulWidget{
  String value;
  CreateContainer({required this.value});

  @override
  _CreateContainerState createState() => _CreateContainerState(value);
}


class _CreateContainerState extends State<CreateContainer> {
  String value;
  _CreateContainerState(this.value);
  String containername='';
  String image='';
  
  
  
  void createcontainer() async {
        print(value);
        String url='$value/containers/create?name=$containername';

        final response = await http.post(        
          url,
          headers: <String,String>{
               'Content-Type': 'application/json',
          }, 
          body: jsonEncode(<String,String>{
             'Image': '$image',
             
             
          
          }
          ),
          );
          String data1 = json.decode(response.body).toString();
          String data2 = data1.substring(5, 15);
          startcontainer(data2);
          if(response.statusCode == 201) {
                   Fluttertoast.showToast(
                      msg: "Container created successfully",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                     textColor: Colors.white,
                     fontSize: 16.0
                );
   
        }
        else{
                Fluttertoast.showToast(
                      msg: "Container created unsuccessfully",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                     textColor: Colors.white,
                     fontSize: 16.0
                );
        
        }
   

            
       }
       void startcontainer(String id) async {
        
        String url='$value/containers/$id/start';
        print(url);
        
        final response = await http.post(        
          url,
          headers: <String,String>{
               'Content-Type': 'application/json',
          }, 

          );

            
       }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        centerTitle: true,
        title: Text("Create New container"),
        
        
       
          
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
                       containername = value;
                    
                    },
                    autocorrect: false,
                    decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "eg: mycontainer",
                    labelText: "Container Name",
                  
                  ),
                  ),
                  ),
                  SizedBox(height:2),
                  Card(
                  child: TextField(
                    onChanged: (value){
                       image  = value;
                    
                    },
                    autocorrect: false,
                    decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "eg: centos:7",
                    labelText: "Image",
                  
                  ),
                  ),
                  ),


                  SizedBox(height:15),
                  ElevatedButton(
                  onPressed:()=>[createcontainer(),Navigator.pop(context)],
                  child: Text('Create Container'),
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
