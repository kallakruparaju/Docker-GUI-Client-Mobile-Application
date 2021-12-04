// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

List<Post> postFromJson(String str) => List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postToJson(List<Post> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
    Post({
       required   this.name,
       required   this.id,
       required   this.created,
       required   this.scope,
       required   this.driver,
       required   this.enableIPv6,
       required   this.ipam,
       required   this.internal,
       required   this.attachable,
       required   this.ingress,
       required   this.configFrom,
       required   this.configOnly,
       required   this.containers,
       required   this.options,
       required   this.labels,
    });

    String name;
    String id;
    DateTime created;
    String scope;
    String driver;
    bool enableIPv6;
    Ipam ipam;
    bool internal;
    bool attachable;
    bool ingress;
    ConfigFrom configFrom;
    bool configOnly;
    Containers containers;
    Options options;
    Containers labels;

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        name: json["Name"],
        id: json["Id"],
        created: DateTime.parse(json["Created"]),
        scope: json["Scope"],
        driver: json["Driver"],
        enableIPv6: json["EnableIPv6"],
        ipam: Ipam.fromJson(json["IPAM"]),
        internal: json["Internal"],
        attachable: json["Attachable"],
        ingress: json["Ingress"],
        configFrom: ConfigFrom.fromJson(json["ConfigFrom"]),
        configOnly: json["ConfigOnly"],
        containers: Containers.fromJson(json["Containers"]),
        options: Options.fromJson(json["Options"]),
        labels: Containers.fromJson(json["Labels"]),
    );

    Map<String, dynamic> toJson() => {
        "Name": name,
        "Id": id,
        "Created": created.toIso8601String(),
        "Scope": scope,
        "Driver": driver,
        "EnableIPv6": enableIPv6,
        "IPAM": ipam.toJson(),
        "Internal": internal,
        "Attachable": attachable,
        "Ingress": ingress,
        "ConfigFrom": configFrom.toJson(),
        "ConfigOnly": configOnly,
        "Containers": containers.toJson(),
        "Options": options.toJson(),
        "Labels": labels.toJson(),
    };
}

class ConfigFrom {
    ConfigFrom({
       required   this.network,
    });

    String network;

    factory ConfigFrom.fromJson(Map<String, dynamic> json) => ConfigFrom(
        network: json["Network"],
    );

    Map<String, dynamic> toJson() => {
        "Network": network,
    };
}

class Containers {
    Containers();

    factory Containers.fromJson(Map<String, dynamic> json) => Containers(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Ipam {
    Ipam({
       required   this.driver,
       required   this.options,
       required   this.config,
    });

    String driver;
    dynamic options;
    List<Config> config;

    factory Ipam.fromJson(Map<String, dynamic> json) => Ipam(
        driver: json["Driver"],
        options: json["Options"],
        config: List<Config>.from(json["Config"].map((x) => Config.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Driver": driver,
        "Options": options,
        "Config": List<dynamic>.from(config.map((x) => x.toJson())),
    };
}

class Config {
    Config({
       required   this.subnet,
       required   this.gateway,
    });

    String subnet;
    String gateway;

    factory Config.fromJson(Map<String, dynamic> json) => Config(
        subnet: json["Subnet"],
        gateway: json["Gateway"],
    );

    Map<String, dynamic> toJson() => {
        "Subnet": subnet,
        "Gateway": gateway,
    };
}

class Options {
    Options({
       required   this.comDockerNetworkBridgeDefaultBridge,
       required   this.comDockerNetworkBridgeEnableIcc,
       required   this.comDockerNetworkBridgeEnableIpMasquerade,
       required   this.comDockerNetworkBridgeHostBindingIpv4,
       required   this.comDockerNetworkBridgeName,
       required   this.comDockerNetworkDriverMtu,
    });

    String comDockerNetworkBridgeDefaultBridge;
    String comDockerNetworkBridgeEnableIcc;
    String comDockerNetworkBridgeEnableIpMasquerade;
    String comDockerNetworkBridgeHostBindingIpv4;
    String comDockerNetworkBridgeName;
    String comDockerNetworkDriverMtu;

    factory Options.fromJson(Map<String, dynamic> json) => Options(
        comDockerNetworkBridgeDefaultBridge: json["com.docker.network.bridge.default_bridge"] == null ? null : json["com.docker.network.bridge.default_bridge"],
        comDockerNetworkBridgeEnableIcc: json["com.docker.network.bridge.enable_icc"] == null ? null : json["com.docker.network.bridge.enable_icc"],
        comDockerNetworkBridgeEnableIpMasquerade: json["com.docker.network.bridge.enable_ip_masquerade"] == null ? null : json["com.docker.network.bridge.enable_ip_masquerade"],
        comDockerNetworkBridgeHostBindingIpv4: json["com.docker.network.bridge.host_binding_ipv4"] == null ? null : json["com.docker.network.bridge.host_binding_ipv4"],
        comDockerNetworkBridgeName: json["com.docker.network.bridge.name"] == null ? null : json["com.docker.network.bridge.name"],
        comDockerNetworkDriverMtu: json["com.docker.network.driver.mtu"] == null ? null : json["com.docker.network.driver.mtu"],
    );

    Map<String, dynamic> toJson() => {
        "com.docker.network.bridge.default_bridge": comDockerNetworkBridgeDefaultBridge == null ? null : comDockerNetworkBridgeDefaultBridge,
        "com.docker.network.bridge.enable_icc": comDockerNetworkBridgeEnableIcc == null ? null : comDockerNetworkBridgeEnableIcc,
        "com.docker.network.bridge.enable_ip_masquerade": comDockerNetworkBridgeEnableIpMasquerade == null ? null : comDockerNetworkBridgeEnableIpMasquerade,
        "com.docker.network.bridge.host_binding_ipv4": comDockerNetworkBridgeHostBindingIpv4 == null ? null : comDockerNetworkBridgeHostBindingIpv4,
        "com.docker.network.bridge.name": comDockerNetworkBridgeName == null ? null : comDockerNetworkBridgeName,
        "com.docker.network.driver.mtu": comDockerNetworkDriverMtu == null ? null : comDockerNetworkDriverMtu,
    };
}
