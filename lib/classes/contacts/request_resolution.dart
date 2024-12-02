class RequestResolution {
  int? resolutionId;
  String? resolution;
  bool? isAccepted;
  int? tenantId;
  int? requestTypeId;

  RequestResolution({this.resolutionId, this.resolution, this.isAccepted, this.tenantId, this.requestTypeId});

  factory RequestResolution.fromJson(Map<String, dynamic> json) => RequestResolution(
        resolutionId: json['resolutionId'],
        resolution: json['resolution'],
        isAccepted: json['isAccepted'],
        tenantId: json['tenantId'],
        requestTypeId: json['request_type_id'],
      );

  Map<String, dynamic> toJson() => {
        'resolutionId': resolutionId,
        'resolution': resolution,
        'isAccepted': isAccepted,
        'tenantId': tenantId,
        'request_type_id': requestTypeId,
      };
}
