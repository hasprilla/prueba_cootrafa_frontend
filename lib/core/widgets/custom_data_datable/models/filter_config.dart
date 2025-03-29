class FilterConfig {
  final String field;
  final String label;
  final List<String> options;
  final String initialValue;

  const FilterConfig({
    required this.field,
    required this.label,
    required this.options,
    this.initialValue = 'All',
  });
}
