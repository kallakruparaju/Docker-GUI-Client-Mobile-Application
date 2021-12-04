import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';


class CreateNetwork extends StatefulWidget{
  String value;
  CreateNetwork({required this.value});

  @override
  _CreateNetworkState createState() => _CreateNetworkState(value);
}


class _CreateNetworkState extends State<CreateNetwork> {
  String value;
  _CreateNetworkState(this.value);
  String networkname='';
  String driver='';
  
  void createnetwork() async {

        String url='$value/networks/create';

        final response = await http.post(        
          url,
          headers: <String,String>{
               'Content-Type': 'application/json',
          }, 
          body: jsonEncode(<String,String>{
             
             "Name": "$networkname",
             "Driver":"$driver",
             
          
          }
          ),
          );
         if(response.statusCode == 201) {
                   Fluttertoast.showToast(
                      msg: "Network created successfully",
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
                      msg: "Network created unsuccessfully",
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
        title: Text("Create New Network"),
        
        
       
          
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
                       networkname = value;
                    
                    },
                    autocorrect: false,
                    decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "eg: MyNetwork",
                    labelText: "Network Name",
                  
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
                    hintText: "eg: bridge",
                    labelText: "Driver",
                  
                  ),
                  ),
                  ),
  
                  SizedBox(height:15),
                  ElevatedButton(
                  onPressed:()=>[createnetwork(),Navigator.pop(context)],
                  child: Text('Create New Network'),
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
