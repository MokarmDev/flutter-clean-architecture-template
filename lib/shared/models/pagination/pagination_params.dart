class PaginationParams {
  final int limit;
  final int skip;

  const PaginationParams({this.limit = 10, this.skip = 0});

  Map<String, dynamic> toJson() => {'limit': limit, 'skip': skip};

  // --- NEW: Batch helpers ---

  /// Creates params to fetch a full batch of pages.
  ///
  /// [batchIndex] – 0‑based index of the batch (batch 0 = pages 0..n-1).
  /// [pageSize]   – items per individual page.
  /// [pagesPerBatch] – how many pages to fetch in one request.
  factory PaginationParams.forBatch({
    required int batchIndex,
    int pageSize = 10,
    int pagesPerBatch = 5,
  }) {
    final batchStart = batchIndex * pageSize * pagesPerBatch;
    return PaginationParams(skip: batchStart, limit: pageSize * pagesPerBatch);
  }

  /// Creates params for the next batch after the user has viewed page [currentPageIndex].
  factory PaginationParams.forNextBatch({
    required int currentPageIndex,
    int pageSize = 10,
    int pagesPerBatch = 5,
  }) {
    final nextBatchIndex = (currentPageIndex ~/ pagesPerBatch) + 1;
    return PaginationParams.forBatch(
      batchIndex: nextBatchIndex,
      pageSize: pageSize,
      pagesPerBatch: pagesPerBatch,
    );
  }

  // Optional copyWith for flexibility
  PaginationParams copyWith({int? limit, int? skip}) =>
      PaginationParams(limit: limit ?? this.limit, skip: skip ?? this.skip);
}
