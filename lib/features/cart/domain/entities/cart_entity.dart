import 'package:equatable/equatable.dart';

class CartEntity extends Equatable {
  final String id;

  const CartEntity({required this.id});

  @override
  List<Object?> get props => [id];
}
