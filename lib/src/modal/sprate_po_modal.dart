class SeprateProductionOrderModal {
  String? id;
  String? isPrinted;
  bool? isMTS;
  String? orderNumber;
  String? materialId;
  Material? material;
  double? quantity;
  String? plantId;
  String? storageLocation;
  String? batch;
  String? salesOrderItem;
  String? job;
  List<ProductionOrderItems>? productionOrderItems;

  SeprateProductionOrderModal({
    this.id,
    this.isPrinted,
    this.isMTS,
    this.orderNumber,
    this.materialId,
    this.material,
    this.quantity,
    this.plantId,
    this.storageLocation,
    this.batch,
    this.salesOrderItem,
    this.job,
    this.productionOrderItems,
  });

  SeprateProductionOrderModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isPrinted = json['is_printed'];
    isMTS = json['is_MTS'];
    orderNumber = json['order_number'];
    materialId = json['material_id'];
    material =
        json['material'] != null
            ? new Material.fromJson(json['material'])
            : null;
    quantity = json['quantity'];
    plantId = json['plant_id'];
    storageLocation = json['storage_location'];
    batch = json['batch'];
    salesOrderItem = json['sales_order_item'];
    job = json['job'];
    if (json['production_order_items'] != null) {
      productionOrderItems = <ProductionOrderItems>[];
      json['production_order_items'].forEach((v) {
        productionOrderItems!.add(new ProductionOrderItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['is_printed'] = this.isPrinted;
    data['is_MTS'] = this.isMTS;
    data['order_number'] = this.orderNumber;
    data['material_id'] = this.materialId;
    if (this.material != null) {
      data['material'] = this.material!.toJson();
    }
    data['quantity'] = this.quantity;
    data['plant_id'] = this.plantId;
    data['storage_location'] = this.storageLocation;
    data['batch'] = this.batch;
    data['sales_order_item'] = this.salesOrderItem;
    data['job'] = this.job;
    if (this.productionOrderItems != null) {
      data['production_order_items'] =
          this.productionOrderItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Material {
  String? id;
  String? code;
  String? name;
  int? qrSize;
  String? type;

  Material({this.id, this.code, this.name, this.qrSize, this.type});

  Material.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    qrSize = json['qr_size'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['qr_size'] = this.qrSize;
    data['type'] = this.type;

    return data;
  }
}

class ProductionOrderItems {
  String? id;
  double? quantity;
  Material? material;
  List<MaterialDetails>? materialDetails;

  ProductionOrderItems({
    this.id,
    this.quantity,
    this.material,
    this.materialDetails,
  });

  ProductionOrderItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    material =
        json['material'] != null
            ? new Material.fromJson(json['material'])
            : null;
    if (json['material_details'] != null) {
      materialDetails = <MaterialDetails>[];
      json['material_details'].forEach((v) {
        materialDetails!.add(new MaterialDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    if (this.material != null) {
      data['material'] = this.material!.toJson();
    }
    if (this.materialDetails != null) {
      data['material_details'] =
          this.materialDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Company {
  String? id;
  String? code;
  String? name;
  String? address;

  Company({this.id, this.code, this.name, this.address});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['address'] = this.address;
    return data;
  }
}

class Plant {
  String? id;
  String? name;
  String? code;
  Company? company;
  bool? isGrnSync;

  Plant({this.id, this.name, this.code, this.company, this.isGrnSync});

  Plant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    company =
        json['company'] != null ? new Company.fromJson(json['company']) : null;
    isGrnSync = json['is_grn_sync'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    data['is_grn_sync'] = this.isGrnSync;
    return data;
  }
}

class UnitOfMeasure {
  String? id;
  String? name;

  UnitOfMeasure({this.id, this.name});

  UnitOfMeasure.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class MaterialDetails {
  String? id;
  double? quantity;
  Plant? plant;
  String? storageLocation;
  String? batch;

  MaterialDetails({
    this.id,
    this.quantity,
    this.plant,
    this.storageLocation,
    this.batch,
  });

  MaterialDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    plant = json['plant'] != null ? new Plant.fromJson(json['plant']) : null;
    storageLocation = json['storage_location'];
    batch = json['batch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    if (this.plant != null) {
      data['plant'] = this.plant!.toJson();
    }
    data['storage_location'] = this.storageLocation;
    data['batch'] = this.batch;
    return data;
  }
}
