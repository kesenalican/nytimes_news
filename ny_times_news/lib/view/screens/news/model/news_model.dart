import 'dart:convert';

NewsModel newsModelFromJson(String str) => NewsModel.fromJson(json.decode(str));

String newsModelToJson(NewsModel data) => json.encode(data.toJson());

class NewsModel {
  final String status;
  final String copyright;
  final int numResults;
  final List<Result> results;

  NewsModel({
    required this.status,
    required this.copyright,
    required this.numResults,
    required this.results,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        status: json["status"],
        copyright: json["copyright"],
        numResults: json["num_results"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "copyright": copyright,
        "num_results": numResults,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  final String uri;
  final String url;
  final int id;
  final int assetId;
  final String source;
  final DateTime publishedDate;
  final DateTime updated;
  final String section;
  final String subsection;
  final String nytdsection;
  final String adxKeywords;
  final dynamic column;
  final String byline;
  final String type;
  final String title;
  final String resultAbstract;
  final List<String> desFacet;
  final List<dynamic> orgFacet;
  final List<dynamic> perFacet;
  final List<String> geoFacet;
  final List<Media> media;
  final int etaId;

  Result({
    required this.uri,
    required this.url,
    required this.id,
    required this.assetId,
    required this.source,
    required this.publishedDate,
    required this.updated,
    required this.section,
    required this.subsection,
    required this.nytdsection,
    required this.adxKeywords,
    required this.column,
    required this.byline,
    required this.type,
    required this.title,
    required this.resultAbstract,
    required this.desFacet,
    required this.orgFacet,
    required this.perFacet,
    required this.geoFacet,
    required this.media,
    required this.etaId,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        uri: json["uri"],
        url: json["url"],
        id: json["id"],
        assetId: json["asset_id"],
        source: json["source"],
        publishedDate: DateTime.parse(json["published_date"]),
        updated: DateTime.parse(json["updated"]),
        section: json["section"],
        subsection: json["subsection"],
        nytdsection: json["nytdsection"],
        adxKeywords: json["adx_keywords"],
        column: json["column"],
        byline: json["byline"],
        type: json["type"],
        title: json["title"],
        resultAbstract: json["abstract"],
        desFacet: List<String>.from(json["des_facet"].map((x) => x)),
        orgFacet: List<dynamic>.from(json["org_facet"].map((x) => x)),
        perFacet: List<dynamic>.from(json["per_facet"].map((x) => x)),
        geoFacet: List<String>.from(json["geo_facet"].map((x) => x)),
        media: List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
        etaId: json["eta_id"],
      );

  Map<String, dynamic> toJson() => {
        "uri": uri,
        "url": url,
        "id": id,
        "asset_id": assetId,
        "source": source,
        "published_date":
            "${publishedDate.year.toString().padLeft(4, '0')}-${publishedDate.month.toString().padLeft(2, '0')}-${publishedDate.day.toString().padLeft(2, '0')}",
        "updated": updated.toIso8601String(),
        "section": section,
        "subsection": subsection,
        "nytdsection": nytdsection,
        "adx_keywords": adxKeywords,
        "column": column,
        "byline": byline,
        "type": type,
        "title": title,
        "abstract": resultAbstract,
        "des_facet": List<dynamic>.from(desFacet.map((x) => x)),
        "org_facet": List<dynamic>.from(orgFacet.map((x) => x)),
        "per_facet": List<dynamic>.from(perFacet.map((x) => x)),
        "geo_facet": List<dynamic>.from(geoFacet.map((x) => x)),
        "media": List<dynamic>.from(media.map((x) => x.toJson())),
        "eta_id": etaId,
      };
}

class Media {
  final String type;
  final String subtype;
  final String caption;
  final String copyright;
  final int approvedForSyndication;
  final List<MediaMetadatum> mediaMetadata;

  Media({
    required this.type,
    required this.subtype,
    required this.caption,
    required this.copyright,
    required this.approvedForSyndication,
    required this.mediaMetadata,
  });

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        type: json["type"],
        subtype: json["subtype"],
        caption: json["caption"],
        copyright: json["copyright"],
        approvedForSyndication: json["approved_for_syndication"],
        mediaMetadata: List<MediaMetadatum>.from(
            json["media-metadata"].map((x) => MediaMetadatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "subtype": subtype,
        "caption": caption,
        "copyright": copyright,
        "approved_for_syndication": approvedForSyndication,
        "media-metadata":
            List<dynamic>.from(mediaMetadata.map((x) => x.toJson())),
      };
}

class MediaMetadatum {
  final String url;
  final String format;
  final int height;
  final int width;

  MediaMetadatum({
    required this.url,
    required this.format,
    required this.height,
    required this.width,
  });

  factory MediaMetadatum.fromJson(Map<String, dynamic> json) => MediaMetadatum(
        url: json["url"],
        format: json["format"],
        height: json["height"],
        width: json["width"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "format": format,
        "height": height,
        "width": width,
      };
}
