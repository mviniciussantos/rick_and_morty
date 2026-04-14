/// A generic wrapper for paginated API responses.
///
/// Captures both the [results] list and pagination metadata
/// from the Rick and Morty API's `info` block.
class PaginatedResponse<T> {
  /// The items returned for the current page.
  final List<T> results;

  /// Total number of items across all pages.
  final int count;

  /// Total number of pages available.
  final int pages;

  /// Whether there is a next page to fetch.
  final bool hasNext;

  const PaginatedResponse({
    required this.results,
    required this.count,
    required this.pages,
    required this.hasNext,
  });
}
