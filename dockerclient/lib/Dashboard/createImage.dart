import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';


class CreateImage extends StatefulWidget{
  String value;
  CreateImage({required this.value});

  @override
  _CreateImageState createState() => _CreateImageState(value);
}


class _CreateImageState extends State<CreateImage> {
  String value;
  _CreateImageState(this.value);
  String imagename='';
  String tagname='latest';
  
  void createimage() async {
        print(value);
        String url='$value/images/create?fromImage=$imagename:$tagname';
        print(imagename);
        final response = await http.post(        
          url,
          headers: <String,String>{
               'Content-Type': 'application/json',
          }, 
          body: jsonEncode(<String,String>{
             'repo': '$imagename',
          
          }
          ),
          );
          if(response.statusCode == 200) {
                   Fluttertoast.showToast(
                      msg: "Image created successfully",
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
                      msg: "Image created unsuccessfully",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                     textColor: Colors.white,
                     fontSize: 16.0
                );
        
        }
          Navigator.pop(context);

            
       }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        centerTitle: true,
        title: Text("Pull New Image"),
        
        
       
          
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
                       imagename = value;
                    
                    },
                    autocorrect: false,
                    decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "eg: centos",
                    labelText: "Image Name",
                  
                  ),
                  ),
                  ),
                  SizedBox(height:2),
                  Card(
                  child: TextField(
                    onChanged: (value){
                       tagname  = value;
                    
                    },
                    autocorrect: false,
                    decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "eg: latest",
                    labelText: "Tag",
                  
                  ),
                  ),
                  ),
  
                  SizedBox(height:15),
                  ElevatedButton(
                  onPressed:()=>[createimage(),Navigator.pop(context)],
                  child: Text('Create New Image'),
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
