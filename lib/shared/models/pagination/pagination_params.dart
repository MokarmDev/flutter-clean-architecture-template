class PaginationParams {
  final int limit;
  final int skip;

  const PaginationParams({this.limit = 10, this.skip = 0});

  Map<String, dynamic> toJson() => {'limit': limit, 'skip': skip};
}
