class PaginatedResponse<T> {
  final List<T> data;
  final int total;
  final int limit;
  final int skip;

  const PaginatedResponse({
    required this.data,
    required this.total,
    required this.limit,
    required this.skip,
  });

  bool get hasNextPage => skip + limit < total;

  bool get isEmpty => data.isEmpty;
  bool get isNotEmpty => data.isNotEmpty;

  /// Helper map function to convert a PaginatedResponse of one type (Models)
  /// into another type (Entities), commonly used in the Data layer.
  PaginatedResponse<E> map<E>(E Function(T e) mapper) {
    return PaginatedResponse<E>(
      data: data.map(mapper).toList(),
      total: total,
      limit: limit,
      skip: skip,
    );
  }
}
