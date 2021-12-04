import 'Post.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Containers{
   static Future<List<Post>?> getPosts(String value) async{
   final response = await http.get('$value/containers/json?all=1');
   final List<Post> listPosts=postFromJson(response.body);
   print(listPosts);
   return listPosts;  
   }
}
