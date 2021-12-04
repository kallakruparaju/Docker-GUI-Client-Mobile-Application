// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

List<Post> postFromJson(String str) => List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postToJson(List<Post> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
    Post({
       required   this.id,
       required   this.names,
       required   this.image,
       required   this.imageId,
       required   this.command,
       required   this.created,
       required   this.ports,
       required   this.labels,
       required   this.state,
       required   this.status,
       required   this.hostConfig,
       required   this.networkSettings,
       required   this.mounts,
    });

    String id;
    List<String> names;
    String image;
    String imageId;
    String command;
    int created;
    List<dynamic> ports;
    Labels labels;
    String state;
    String status;
    HostConfig hostConfig;
    NetworkSettings networkSettings;
    List<dynamic> mounts;

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["Id"],
        names: List<String>.from(json["Names"].map((x) => x)),
        image: json["Image"],
        imageId: json["ImageID"],
        command: json["Command"],
        created: json["Created"],
        ports: List<dynamic>.from(json["Ports"].map((x) => x)),
        labels: Labels.fromJson(json["Labels"]),
        state: json["State"],
        status: json["Status"],
        hostConfig: HostConfig.fromJson(json["HostConfig"]),
        networkSettings: NetworkSettings.fromJson(json["NetworkSettings"]),
        mounts: List<dynamic>.from(json["Mounts"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Names": List<dynamic>.from(names.map((x) => x)),
        "Image": image,
        "ImageID": imageId,
        "Command": command,
        "Created": created,
        "Ports": List<dynamic>.from(ports.map((x) => x)),
        "Labels": labels.toJson(),
        "State": state,
        "Status": status,
        "HostConfig": hostConfig.toJson(),
        "NetworkSettings": networkSettings.toJson(),
        "Mounts": List<dynamic>.from(mounts.map((x) => x)),
    };
}

class HostConfig {
    HostConfig({
       required   this.networkMode,
    });

    String networkMode;

    factory HostConfig.fromJson(Map<String, dynamic> json) => HostConfig(
        networkMode: json["NetworkMode"],
    );

    Map<String, dynamic> toJson() => {
        "NetworkMode": networkMode,
    };
}

class Labels {
    Labels({
       required   this.orgLabelSchemaBuildDate,
       required   this.orgLabelSchemaLicense,
       required   this.orgLabelSchemaName,
       required   this.orgLabelSchemaSchemaVersion,
       required   this.orgLabelSchemaVendor,
     //  required   this.orgOpencontainersImageCreated,
       required   this.orgOpencontainersImageLicenses,
       required   this.orgOpencontainersImageTitle,
       required   this.orgOpencontainersImageVendor,
    });

    String orgLabelSchemaBuildDate;
    String orgLabelSchemaLicense;
    String orgLabelSchemaName;
    String orgLabelSchemaSchemaVersion;
    String orgLabelSchemaVendor;
    //DateTime orgOpencontainersImageCreated = ;
    String orgOpencontainersImageLicenses;
    String orgOpencontainersImageTitle;
    String orgOpencontainersImageVendor;

    factory Labels.fromJson(Map<String, dynamic> json) => Labels(
        orgLabelSchemaBuildDate: json["org.label-schema.build-date"] == null ? null : json["org.label-schema.build-date"],
        orgLabelSchemaLicense: json["org.label-schema.license"] == null ? null : json["org.label-schema.license"],
        orgLabelSchemaName: json["org.label-schema.name"] == null ? null : json["org.label-schema.name"],
        orgLabelSchemaSchemaVersion: json["org.label-schema.schema-version"] == null ? null : json["org.label-schema.schema-version"],
        orgLabelSchemaVendor: json["org.label-schema.vendor"] == null ? null : json["org.label-schema.vendor"],
        //orgOpencontainersImageCreated: json["org.opencontainers.image.created"] == null ? null : DateTime.parse(json["org.opencontainers.image.created"]),
        orgOpencontainersImageLicenses: json["org.opencontainers.image.licenses"] == null ? null : json["org.opencontainers.image.licenses"],
        orgOpencontainersImageTitle: json["org.opencontainers.image.title"] == null ? null : json["org.opencontainers.image.title"],
        orgOpencontainersImageVendor: json["org.opencontainers.image.vendor"] == null ? null : json["org.opencontainers.image.vendor"],
    );

    Map<String, dynamic> toJson() => {
        "org.label-schema.build-date": orgLabelSchemaBuildDate == null ? null : orgLabelSchemaBuildDate,
        "org.label-schema.license": orgLabelSchemaLicense == null ? null : orgLabelSchemaLicense,
        "org.label-schema.name": orgLabelSchemaName == null ? null : orgLabelSchemaName,
        "org.label-schema.schema-version": orgLabelSchemaSchemaVersion == null ? null : orgLabelSchemaSchemaVersion,
        "org.label-schema.vendor": orgLabelSchemaVendor == null ? null : orgLabelSchemaVendor,
      //  "org.opencontainers.image.created": orgOpencontainersImageCreated == null ? null : orgOpencontainersImageCreated.toIso8601String(),
        "org.opencontainers.image.licenses": orgOpencontainersImageLicenses == null ? null : orgOpencontainersImageLicenses,
        "org.opencontainers.image.title": orgOpencontainersImageTitle == null ? null : orgOpencontainersImageTitle,
        "org.opencontainers.image.vendor": orgOpencontainersImageVendor == null ? null : orgOpencontainersImageVendor,
    };
}

class NetworkSettings {
    NetworkSettings({
       required   this.networks,
    });

    Networks networks;

    factory NetworkSettings.fromJson(Map<String, dynamic> json) => NetworkSettings(
        networks: Networks.fromJson(json["Networks"]),
    );

    Map<String, dynamic> toJson() => {
        "Networks": networks.toJson(),
    };
}

class Networks {
    Networks({
       required   this.bridge,
    });

    Bridge bridge;

    factory Networks.fromJson(Map<String, dynamic> json) => Networks(
        bridge: Bridge.fromJson(json["bridge"]),
    );

    Map<String, dynamic> toJson() => {
        "bridge": bridge.toJson(),
    };
}

class Bridge {
    Bridge({
       required   this.ipamConfig,
       required   this.links,
       required   this.aliases,
       required   this.networkId,
       required   this.endpointId,
       required   this.gateway,
       required   this.ipAddress,
       required   this.ipPrefixLen,
       required   this.iPv6Gateway,
       required   this.globalIPv6Address,
       required   this.globalIPv6PrefixLen,
       required   this.macAddress,
       required   this.driverOpts,
    });

    dynamic ipamConfig;
    dynamic links;
    dynamic aliases;
    String networkId;
    String endpointId;
    String gateway;
    String ipAddress;
    int ipPrefixLen;
    String iPv6Gateway;
    String globalIPv6Address;
    int globalIPv6PrefixLen;
    String macAddress;
    dynamic driverOpts;

    factory Bridge.fromJson(Map<String, dynamic> json) => Bridge(
        ipamConfig: json["IPAMConfig"],
        links: json["Links"],
        aliases: json["Aliases"],
        networkId: json["NetworkID"],
        endpointId: json["EndpointID"],
        gateway: json["Gateway"],
        ipAddress: json["IPAddress"],
        ipPrefixLen: json["IPPrefixLen"],
        iPv6Gateway: json["IPv6Gateway"],
        globalIPv6Address: json["GlobalIPv6Address"],
        globalIPv6PrefixLen: json["GlobalIPv6PrefixLen"],
        macAddress: json["MacAddress"],
        driverOpts: json["DriverOpts"],
    );

    Map<String, dynamic> toJson() => {
        "IPAMConfig": ipamConfig,
        "Links": links,
        "Aliases": aliases,
        "NetworkID": networkId,
        "EndpointID": endpointId,
        "Gateway": gateway,
        "IPAddress": ipAddress,
        "IPPrefixLen": ipPrefixLen,
        "IPv6Gateway": iPv6Gateway,
        "GlobalIPv6Address": globalIPv6Address,
        "GlobalIPv6PrefixLen": globalIPv6PrefixLen,
        "MacAddress": macAddress,
        "DriverOpts": driverOpts,
    };
}

