class AssistantConfig {
  int assistantConfigId;
  String endpoint;
  String apiKey;
  String assistantId;
  String instructions;
  int tenantId;
  List<String>? vectorStoreIds;

  AssistantConfig({
    required this.assistantConfigId,
    required this.endpoint,
    required this.apiKey,
    required this.assistantId,
    required this.instructions,
    required this.tenantId,
    this.vectorStoreIds,
  });

  factory AssistantConfig.fromJson(Map<String, dynamic> json) {
    return AssistantConfig(
      assistantConfigId: json['assistantConfigId'],
      endpoint: json['endpoint'],
      apiKey: json['apiKey'],
      assistantId: json['assistantId'],
      instructions: json['instructions'],
      tenantId: json['tenantId'],
      vectorStoreIds: json['vectorStoreIds'] != null ? List<String>.from(json['vectorStoreIds']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'assistantConfigId': assistantConfigId,
      'endpoint': endpoint,
      'apiKey': apiKey,
      'assistantId': assistantId,
      'instructions': instructions,
      'tenantId': tenantId,
      'vectorStoreIds': vectorStoreIds,
    };
  }
}
