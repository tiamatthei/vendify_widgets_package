class RequestResolution {
  int? resolutionId;
  String? resolution;
  bool? isAccepted;
  int? tenantId;
  int? request_type_id;

  RequestResolution({this.resolutionId, this.resolution, this.isAccepted, this.tenantId, this.request_type_id});

  factory RequestResolution.fromJson(Map<String, dynamic> json) => RequestResolution(
        resolutionId: json['resolutionId'],
        resolution: json['resolution'],
        isAccepted: json['isAccepted'],
        tenantId: json['tenantId'],
        request_type_id: json['request_type_id'],
      );

  Map<String, dynamic> toJson() => {
        'resolutionId': resolutionId,
        'resolution': resolution,
        'isAccepted': isAccepted,
        'tenantId': tenantId,
        'request_type_id': request_type_id,
      };
}
