class LiveData<T> {

  T? currentValue;
  void Function()? onChange;

  LiveData(this.currentValue);

  T? get value {
    return currentValue;
  }

  void observe(void Function() onChange) {
    this.onChange = onChange;
  }

}