class RequestResolution {
  int? resolutionId;
  String? resolution;

  RequestResolution({this.resolutionId, this.resolution});

  factory RequestResolution.fromJson(Map<String, dynamic> json) => RequestResolution(
        resolutionId: json['resolutionId'],
        resolution: json['resolution'],
      );

  Map<String, dynamic> toJson() => {
        'resolutionId': resolutionId,
        'resolution': resolution,
      };
}
