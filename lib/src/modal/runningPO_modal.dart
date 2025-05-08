class ProductionOrderModal {
  String? productionOrderId;
  String? salesOrderItemId;
  String? mappingStatus;
  String? orderNumber;
  int? complete;
  int? pending;
  int? error;
  String? isDispatch;
  AssemblyLine? assemblyLine;

  ProductionOrderModal({
    this.productionOrderId,
    this.salesOrderItemId,
    this.mappingStatus,
    this.isDispatch,
    this.assemblyLine,
    this.orderNumber,
    this.complete,
    this.pending,
    this.error,
  });

  ProductionOrderModal.fromJson(Map<String, dynamic> json) {
    productionOrderId = json['production_order_id'];
    salesOrderItemId = json['sales_order_item_id'];
    mappingStatus = json['mapping_status'];
    isDispatch = json['is_dispatch'];
    assemblyLine =
        json['assembly_line'] != null
            ? new AssemblyLine.fromJson(json['assembly_line'])
            : null;
    orderNumber = json['order_number'];
    complete = json['completed'];
    pending = json['pending'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['production_order_id'] = this.productionOrderId;
    data['sales_order_item_id'] = this.salesOrderItemId;
    data['mapping_status'] = this.mappingStatus;
    data['is_dispatch'] = this.isDispatch;
    if (this.assemblyLine != null) {
      data['assembly_line'] = this.assemblyLine!.toJson();
    }
    data['order_number'] = this.orderNumber;
    data['completed'] = this.complete;
    data['pending'] = this.pending;
    data['error'] = this.error;
    return data;
  }
}

class AssemblyLine {
  String? id;
  String? name;
  Plant? plant;
  LineStage? lineStage;

  AssemblyLine({this.id, this.name, this.plant, this.lineStage});

  AssemblyLine.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    plant = json['plant'] != null ? new Plant.fromJson(json['plant']) : null;
    lineStage =
        json['line_stage'] != null
            ? new LineStage.fromJson(json['line_stage'])
            : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.plant != null) {
      data['plant'] = this.plant!.toJson();
    }
    if (this.lineStage != null) {
      data['line_stage'] = this.lineStage!.toJson();
    }
    return data;
  }
}

class Plant {
  String? id;
  String? name;
  String? code;

  Plant({this.id, this.name, this.code});

  Plant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    return data;
  }
}

class LineStage {
  String? id;
  String? name;
  bool? isObjectDetection;
  bool? isRejectedItemQr;
  List<String>? productionOrderItemId;

  LineStage({
    this.id,
    this.name,
    this.isObjectDetection,
    this.isRejectedItemQr,
    this.productionOrderItemId,
  });

  LineStage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isObjectDetection = json['is_object_detection'];
    isRejectedItemQr = json['is_rejected_item_qr'];
    productionOrderItemId = json['production_order_item_id'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['is_object_detection'] = this.isObjectDetection;
    data['is_rejected_item_qr'] = this.isRejectedItemQr;
    data['production_order_item_id'] = this.productionOrderItemId;
    return data;
  }
}
