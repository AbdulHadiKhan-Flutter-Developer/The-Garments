class CartModel {
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

  CartModel(
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
      required this.ProductTotalPrice});

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
      'ProductTotalPrice': ProductTotalPrice,
    };
  }
}
