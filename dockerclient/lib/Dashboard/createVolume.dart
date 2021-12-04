import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';


class CreateVolume extends StatefulWidget{
  String value;
  CreateVolume({required this.value});

  @override
  _CreateVolumeState createState() => _CreateVolumeState(value);
}


class _CreateVolumeState extends State<CreateVolume> {
  String value;
  _CreateVolumeState(this.value);
  String volumename='';
  String driver='';
  
  void createvolume() async {

        String url='$value/volumes/create';

        final response = await http.post(        
          url,
          headers: <String,String>{
               'Content-Type': 'application/json',
          }, 
          body: jsonEncode(<String,String>{
             
             "Name": "$volumename",
             "Driver":"$driver",
             
          
          }
          ),
          );
          print(response.statusCode);
        if(response.statusCode == 201) {
                   Fluttertoast.showToast(
                      msg: "Volume created successfully",
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
                      msg: "Volume created unsuccessfully",
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
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        centerTitle: true,
        title: Text("Create New Volume"),
        
        
       
          
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
                       volumename = value;
                    
                    },
                    autocorrect: false,
                    decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "eg: Myvolume",
                    labelText: "Volume Name",
                  
                  ),
                  ),
                  ),
                  SizedBox(height:2),
                  Card(
                  child: TextField(
                    onChanged: (value){
                       driver  = value;
                    
                    },
                    autocorrect: false,
                    decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "eg: local",
                    labelText: "Driver",
                  
                  ),
                  ),
                  ),
  
                  SizedBox(height:15),
                  ElevatedButton(
                  onPressed:()=>[createvolume(),Navigator.pop(context)],
                  child: Text('Create New Volume'),
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
