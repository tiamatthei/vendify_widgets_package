class AssistantMessage {
  final String id;
  final String object;
  final int createdAt;
  final String? assistantId;
  final String threadId;
  final String? runId;
  final String role;
  final List<Map<String, dynamic>> content;
  final List<dynamic> attachments;
  final Map<String, dynamic> metadata;

  AssistantMessage({
    required this.id,
    required this.object,
    required this.createdAt,
    this.assistantId,
    required this.threadId,
    this.runId,
    required this.role,
    required this.content,
    required this.attachments,
    required this.metadata,
  });

  factory AssistantMessage.fromJson(Map<String, dynamic> json) {
    return AssistantMessage(
      id: json['id'],
      object: json['object'],
      createdAt: json['created_at'],
      assistantId: json['assistant_id'],
      threadId: json['thread_id'],
      runId: json['run_id'],
      role: json['role'],
      content: List<Map<String, dynamic>>.from(json['content']),
      attachments: List<dynamic>.from(json['attachments']),
      metadata: json['metadata'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'object': object,
      'created_at': createdAt,
      'assistant_id': assistantId,
      'thread_id': threadId,
      'run_id': runId,
      'role': role,
      'content': content,
      'attachments': attachments,
      'metadata': metadata,
    };
  }
}
