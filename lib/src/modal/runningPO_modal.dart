

class RunningAssemblyLines {
  String? assemblyLine;
  String? jobId;
  String? productionOrderId;
  String? plant;
  String? productionOrderNumber;
  String? finalGoods;
  int? completed;
  int? pending;
  int? error;

  RunningAssemblyLines({
    this.assemblyLine,
    this.jobId,
    this.productionOrderId,
    this.plant,
    this.productionOrderNumber,
    this.finalGoods,
    this.completed,
    this.pending,
    this.error,
  });

  RunningAssemblyLines.fromJson(Map<String, dynamic> json) {
    assemblyLine = json['assembly_line'];
    jobId = json['job_id'];
    productionOrderId = json['production_order_id'];
    plant = json['plant'];
    productionOrderNumber = json['production_order_number'];
    finalGoods = json['final_goods'];
    completed = json['completed'];
    pending = json['pending'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['assembly_line'] = this.assemblyLine;
    data['job_id'] = this.jobId;
    data['production_order_id'] = this.productionOrderId;
    data['plant'] = this.plant;
    data['production_order_number'] = this.productionOrderNumber;
    data['final_goods'] = this.finalGoods;
    data['completed'] = this.completed;
    data['pending'] = this.pending;
    data['error'] = this.error;
    return data;
  }
}
