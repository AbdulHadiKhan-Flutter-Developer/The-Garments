class OrderModel {
  final String ProductId;
  final String CategoryId;
  final String ProductName;
  final String CategoryName;
  final String SalePrice;
  final String FullPrice;
  final String ProductImg;
  final String DeliveryTime;
  final bool issale;
  final String ProductDescription;
  final dynamic CreatedAt;
  final dynamic UpdatedAt;
  final int ProductQuantity;
  final double ProductTotalPrice;
  final String CustomerId;
  final bool Status;
  final String CustomerName;
  final String CustomerPhoneNumber;
  final String CustomerAddress;
  final String CustomerDeviceToken;

  OrderModel(
      {required this.ProductId,
      required this.CategoryId,
      required this.ProductName,
      required this.CategoryName,
      required this.SalePrice,
      required this.FullPrice,
      required this.ProductImg,
      required this.DeliveryTime,
      required this.issale,
      required this.ProductDescription,
      required this.CreatedAt,
      required this.UpdatedAt,
      required this.ProductQuantity,
      required this.ProductTotalPrice,
      required this.CustomerId,
      required this.Status,
      required this.CustomerName,
      required this.CustomerPhoneNumber,
      required this.CustomerAddress,
      required this.CustomerDeviceToken});

  Map<String, dynamic> toMap() {
    return {
      'ProductId': ProductId,
      'CategoryId': CategoryId,
      'ProductName': ProductName,
      'CategoryName': CategoryName,
      'SalePrice': SalePrice,
      'FullPrice': FullPrice,
      'ProductImg': ProductImg,
      'DeliveryTime': DeliveryTime,
      'issale': issale,
      'ProductDescription': ProductDescription,
      'CreatedAt': CreatedAt,
      'UpdatedAt': UpdatedAt,
      'ProductQuantity': ProductQuantity,
      'CustomerId': CustomerId,
      'Status': Status,
      'ProductTotalPrice': ProductTotalPrice,
      'CustomerName': CustomerName,
      'CustomerPhoneNumber': CustomerPhoneNumber,
      'CustomerAddress': CustomerAddress,
      'CustomerDeviceToken': CustomerDeviceToken,
    };
  }
}
