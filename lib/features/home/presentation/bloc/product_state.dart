part of 'product_bloc.dart';



sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitialState extends ProductState {}

class GetProductListLoadingState extends ProductState {}

class GetProductListSuccessState extends ProductState {
  final List<ProductEntity> data;
  const GetProductListSuccessState(this.data);

  @override
  List<Object> get props => [data];
}

class GetProductListFailureState extends ProductState {
  final String message;
  const GetProductListFailureState(this.message);

  @override
  List<Object> get props => [message];
}

