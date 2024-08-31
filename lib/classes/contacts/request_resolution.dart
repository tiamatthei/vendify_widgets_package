class RequestResolution {
  int? resolutionId;
  String? resolution;
  bool? isAccepted;
  int? tenantId;

  RequestResolution({this.resolutionId, this.resolution, this.isAccepted, this.tenantId});

  factory RequestResolution.fromJson(Map<String, dynamic> json) => RequestResolution(
        resolutionId: json['resolutionId'],
        resolution: json['resolution'],
        isAccepted: json['isAccepted'],
        tenantId: json['tenantId'],
      );

  Map<String, dynamic> toJson() => {
        'resolutionId': resolutionId,
        'resolution': resolution,
        'isAccepted': isAccepted,
        'tenantId': tenantId,
      };
}
