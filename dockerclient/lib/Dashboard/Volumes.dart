import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'createVolume.dart';


class Volumes extends StatefulWidget {
  String value;
  Volumes({required this.value});
  @override
  _VolumesState createState() => _VolumesState(value);
}
var refreshKey = GlobalKey<RefreshIndicatorState>();

class _VolumesState extends State<Volumes> {
  String value;
  _VolumesState(this.value);
  Future<Map<String, dynamic>> getData() async {
    final response = await http.get(Uri.parse("$value/volumes"));
    return json.decode(response.body);
  }
  
   void cgi(String volumesdelete) async {
       
        String url='$value/volumes/$volumesdelete?force=true';
      
        final response = await http.delete(        
          url,
          headers: <String,String>{
               'Content-Type': 'application/json',
          }, 

          );
          if (response.statusCode != 200) {
                   Fluttertoast.showToast(
                      msg: "Volume deleted successfully",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                     textColor: Colors.white,
                     fontSize: 16.0
                );
   
        }
          
          
            
       }

  late Map<String, dynamic> data;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getData().then((data) {
      setState(() {
        this.data = data;
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Volumes"),
        centerTitle: true,
         actions: [
               IconButton(
               onPressed: () {
                  Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CreateVolume(value: value)),
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
          itemCount: data["Volumes"].length,
          itemBuilder: (context, int index) {

            return Slidable(
              
              secondaryActions: <Widget>[
                IconSlideAction(
                  icon: Icons.clear,
                  color: Colors.red,
                  caption: 'Delete',
                  onTap: () {
                           cgi("${data["Volumes"][index]["Name"]}");
                       }
                )
              ],
              child: ListTile(
                //leading: Icon(Icons.message),
                title: Text(data["Volumes"][index]["Name"],
                       style: TextStyle(
                        // color: Colors.white,
                         fontWeight: FontWeight.bold,
                        fontSize: 20
                      ),
                ),
                subtitle: Text(data["Volumes"][0]["Driver"]),
                //trailing: Icon(Icons.arrow_back),
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
         getData().then((data) {
            setState((){
                this.data = data;
                loading = false;
            });
         });
    });
  }

}
