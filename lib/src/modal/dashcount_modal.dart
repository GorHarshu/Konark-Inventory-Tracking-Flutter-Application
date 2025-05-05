class DashboardCountModal {
  int? finishProduct;
  int? openSalesOrder;
  int? disptachedSalesOrder;
  int? openProductionOrders;
  int? partiallyConfirmedProductionOrders;
  int? completedConfirmedProductionOrders;
  int? totalAssemblyLinesAvailable;
  int? assemblyLinesInRunning;
  int? assemblyLineInQueue;
  int? availableAssemblyLines;
  int? skuScannedByPortal;
  int? finalGoodScannedByPortal;
  int? customers;

  DashboardCountModal(
      {this.finishProduct,
      this.openSalesOrder,
      this.disptachedSalesOrder,
      this.openProductionOrders,
      this.partiallyConfirmedProductionOrders,
      this.completedConfirmedProductionOrders,
      this.totalAssemblyLinesAvailable,
      this.assemblyLinesInRunning,
      this.assemblyLineInQueue,
      this.availableAssemblyLines,
      this.skuScannedByPortal,
      this.finalGoodScannedByPortal,
      this.customers});

  DashboardCountModal.fromJson(Map<String, dynamic> json) {
    finishProduct = json['finish_product'];
    openSalesOrder = json['open_sales_order'];
    disptachedSalesOrder = json['disptached_sales_order'];
    openProductionOrders = json['open_production_orders'];
    partiallyConfirmedProductionOrders =
        json['partially_confirmed_production_orders'];
    completedConfirmedProductionOrders =
        json['completed_confirmed_production_orders'];
    totalAssemblyLinesAvailable = json['total_assembly_lines_available'];
    assemblyLinesInRunning = json['assembly_lines_in_running'];
    assemblyLineInQueue = json['assembly_line_in_queue'];
    availableAssemblyLines = json['available_assembly_lines'];
    skuScannedByPortal = json['sku_scanned_by_portal'];
    finalGoodScannedByPortal = json['final_good_scanned_by_portal'];
    customers = json['customers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['finish_product'] = this.finishProduct;
    data['open_sales_order'] = this.openSalesOrder;
    data['disptached_sales_order'] = this.disptachedSalesOrder;
    data['open_production_orders'] = this.openProductionOrders;
    data['partially_confirmed_production_orders'] =
        this.partiallyConfirmedProductionOrders;
    data['completed_confirmed_production_orders'] =
        this.completedConfirmedProductionOrders;
    data['total_assembly_lines_available'] = this.totalAssemblyLinesAvailable;
    data['assembly_lines_in_running'] = this.assemblyLinesInRunning;
    data['assembly_line_in_queue'] = this.assemblyLineInQueue;
    data['available_assembly_lines'] = this.availableAssemblyLines;
    data['sku_scanned_by_portal'] = this.skuScannedByPortal;
    data['final_good_scanned_by_portal'] = this.finalGoodScannedByPortal;
    data['customers'] = this.customers;
    return data;
  }
}
