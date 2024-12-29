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
      assistantConfigId: json['assistant_config_id'],
      endpoint: json['endpoint'],
      apiKey: json['api_key'],
      assistantId: json['assistant_id'],
      instructions: json['instructions'],
      tenantId: json['tenant_id'],
      vectorStoreIds: json['vector_store_ids'] != null ? List<String>.from(json['vector_store_ids']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'assistant_config_id': assistantConfigId,
      'endpoint': endpoint,
      'api_key': apiKey,
      'assistant_id': assistantId,
      'instructions': instructions,
      'tenant_id': tenantId,
      'vector_store_ids': vectorStoreIds,
    };
  }
}
