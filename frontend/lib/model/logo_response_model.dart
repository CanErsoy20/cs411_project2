class LogoResponse {
  String? name;
  String? domain;
  bool? claimed;
  String? description;
  String? longDescription;
  List<Links>? links;
  List<Logos>? logos;

  LogoResponse({
    this.name,
    this.domain,
    this.claimed,
    this.description,
    this.longDescription,
    this.links,
    this.logos,
  });

  LogoResponse.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    domain = json['domain'];
    claimed = json['claimed'];
    description = json['description'];
    longDescription = json['longDescription'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    if (json['logos'] != null) {
      logos = <Logos>[];
      json['logos'].forEach((v) {
        logos!.add(Logos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['domain'] = domain;
    data['claimed'] = claimed;
    data['description'] = description;
    data['longDescription'] = longDescription;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    if (logos != null) {
      data['logos'] = logos!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Links {
  String? name;
  String? url;

  Links({this.name, this.url});

  Links.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['url'] = url;
    return data;
  }
}

class Logos {
  String? theme;
  List<Formats>? formats;
  String? type;

  Logos({this.theme, this.formats, this.type});

  Logos.fromJson(Map<String, dynamic> json) {
    theme = json['theme'];
    if (json['formats'] != null) {
      formats = <Formats>[];
      json['formats'].forEach((v) {
        formats!.add(Formats.fromJson(v));
      });
    }
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['theme'] = theme;
    if (formats != null) {
      data['formats'] = formats!.map((v) => v.toJson()).toList();
    }
    data['type'] = type;
    return data;
  }
}

class Formats {
  String? src;
  String? format;

  Formats({
    this.src,
    this.format,
  });

  Formats.fromJson(Map<String, dynamic> json) {
    src = json['src'];

    format = json['format'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['src'] = src;
    data['format'] = format;
    return data;
  }
}
