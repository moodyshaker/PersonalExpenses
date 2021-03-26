class Tab {
  String name;
  bool isSelected;

  Tab({
    this.name,
    this.isSelected,
  });

  void toggle() {
    isSelected = !isSelected;
  }
}
