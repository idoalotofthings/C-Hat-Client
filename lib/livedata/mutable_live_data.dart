import 'live_data.dart';

class MutableLiveData<T> extends LiveData<T> {

  MutableLiveData([super.currentValue]);

  set value(T? newValue) {
    
    if((newValue != currentValue) && (onChange != null)) {
      onChange!();
    }

    currentValue = newValue;

  }

}