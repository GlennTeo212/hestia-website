import '../../core/constants/app_constants.dart';

class Task {
  final String id;
  final String projectId;
  final String title;
  final String? description;
  final String? assigneeId;
  final String priority;
  final String status;
  final DateTime? dueDate;
  final DateTime createdAt;
  
  // New fields for enhanced features
  final String? category;
  final double? quantity;
  final String? unit;
  final List<TaskMaterial>? materials;
  final int? alarmDays;

  Task({
    required this.id,
    required this.projectId,
    required this.title,
    this.description,
    this.assigneeId,
    required this.priority,
    required this.status,
    this.dueDate,
    required this.createdAt,
    this.category,
    this.quantity,
    this.unit,
    this.materials,
    this.alarmDays,
  });

  bool get isPending => status == AppConstants.statusPending;
  bool get isInProgress => status == AppConstants.statusInProgress;
  bool get isCompleted => status == AppConstants.statusCompleted;
  bool get isBlocked => status == AppConstants.statusBlocked;

  bool get isUrgent => priority == AppConstants.priorityUrgent;
  bool get isHighPriority => priority == AppConstants.priorityHigh;

  bool get needsAlarm => alarmDays != null && alarmDays! > 0;

  factory Task.fromJson(Map<String, dynamic> json) {
    List<TaskMaterial>? materials;
    if (json['materials'] != null) {
      materials = (json['materials'] as List)
          .map((m) => TaskMaterial.fromJson(m))
          .toList();
    }
    
    return Task(
      id: json['id'] as String,
      projectId: json['project_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      assigneeId: json['assignee_id'] as String?,
      priority: json['priority'] as String,
      status: json['status'] as String,
      dueDate: json['due_date'] != null 
          ? DateTime.parse(json['due_date'] as String) 
          : null,
      createdAt: DateTime.parse(json['created_at'] as String),
      category: json['category'] as String?,
      quantity: (json['quantity'] as num?)?.toDouble(),
      unit: json['unit'] as String?,
      materials: materials,
      alarmDays: json['alarm_days'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'project_id': projectId,
      'title': title,
      'description': description,
      'assignee_id': assigneeId,
      'priority': priority,
      'status': status,
      'due_date': dueDate?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'category': category,
      'quantity': quantity,
      'unit': unit,
      'materials': materials?.map((m) => m.toJson()).toList(),
      'alarm_days': alarmDays,
    };
  }

  Task copyWith({
    String? id,
    String? projectId,
    String? title,
    String? description,
    String? assigneeId,
    String? priority,
    String? status,
    DateTime? dueDate,
    DateTime? createdAt,
    String? category,
    double? quantity,
    String? unit,
    List<TaskMaterial>? materials,
    int? alarmDays,
  }) {
    return Task(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      title: title ?? this.title,
      description: description ?? this.description,
      assigneeId: assigneeId ?? this.assigneeId,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      dueDate: dueDate ?? this.dueDate,
      createdAt: createdAt ?? this.createdAt,
      category: category ?? this.category,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      materials: materials ?? this.materials,
      alarmDays: alarmDays ?? this.alarmDays,
    );
  }
}

class TaskMaterial {
  final String name;
  final double quantity;
  final bool isSelected;

  TaskMaterial({
    required this.name,
    required this.quantity,
    this.isSelected = true,
  });

  factory TaskMaterial.fromJson(Map<String, dynamic> json) {
    return TaskMaterial(
      name: json['name'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      isSelected: json['is_selected'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'is_selected': isSelected,
    };
  }

  TaskMaterial copyWith({
    String? name,
    double? quantity,
    bool? isSelected,
  }) {
    return TaskMaterial(
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}