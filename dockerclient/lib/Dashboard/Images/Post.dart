// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

List<Post> postFromJson(String str) => List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postToJson(List<Post> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
    Post({
       required   this.containers,
       required   this.created,
       required   this.id,
       required   this.labels,
       required   this.parentId,
       required   this.repoDigests,
       required   this.repoTags,
       required   this.sharedSize,
       required   this.size,
       required   this.virtualSize,
    });

    int containers;
    int created;
    String id;
    dynamic labels;
    String parentId;
    List<String> repoDigests;
    List<String> repoTags;
    int sharedSize;
    int size;
    int virtualSize;

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        containers: json["Containers"],
        created: json["Created"],
        id: json["Id"],
        labels: json["Labels"],
        parentId: json["ParentId"],
        repoDigests: List<String>.from(json["RepoDigests"].map((x) => x)),
        repoTags: List<String>.from(json["RepoTags"].map((x) => x)),
        sharedSize: json["SharedSize"],
        size: json["Size"],
        virtualSize: json["VirtualSize"],
    );

    Map<String, dynamic> toJson() => {
        "Containers": containers,
        "Created": created,
        "Id": id,
        "Labels": labels,
        "ParentId": parentId,
        "RepoDigests": List<dynamic>.from(repoDigests.map((x) => x)),
        "RepoTags": List<dynamic>.from(repoTags.map((x) => x)),
        "SharedSize": sharedSize,
        "Size": size,
        "VirtualSize": virtualSize,
    };
}
