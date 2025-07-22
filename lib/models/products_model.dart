class ProductsModel {
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

  ProductsModel(
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
      required this.UpdatedAt});
}
