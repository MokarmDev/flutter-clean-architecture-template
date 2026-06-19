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

  // --- NEW: Page splitting helpers ---

  /// Splits this (batch) response into a list of individual pages.
  ///
  /// Each returned [PaginatedResponse] represents one page of size [pageSize],
  /// with correct `skip`, `limit = pageSize`, and the same `total`.
  List<PaginatedResponse<T>> toPages(int pageSize) {
    final pages = <PaginatedResponse<T>>[];
    for (int i = 0; i < data.length; i += pageSize) {
      final end = (i + pageSize).clamp(0, data.length);
      final pageData = data.sublist(i, end);
      pages.add(
        PaginatedResponse<T>(
          data: pageData,
          total: total,
          limit: pageSize,
          skip: skip + i,
        ),
      );
    }
    return pages;
  }

  /// Returns a single page from this batch by its absolute page index.
  ///
  /// [pageIndex] is the 0‑based index of the desired page **within the whole collection**.
  /// [pageSize]  must match the intended page size.
  PaginatedResponse<T> pageAt(int pageIndex, int pageSize) {
    final batchStartPage = skip ~/ pageSize; // first page index in this batch
    final offsetInsideBatch = (pageIndex - batchStartPage) * pageSize;
    final end = (offsetInsideBatch + pageSize).clamp(0, data.length);
    return PaginatedResponse<T>(
      data: data.sublist(offsetInsideBatch, end),
      total: total,
      limit: pageSize,
      skip: pageIndex * pageSize,
    );
  }

  // Convenience: total number of pages
  int totalPages(int pageSize) => (total / pageSize).ceil();
}
