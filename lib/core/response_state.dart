sealed class Response<T> {}

class Loading<T> extends Response<T> {}

class Success<T> extends Response<T>{
  final T data;
  Success(this.data);
}

class Error<T>extends Response<T>{
  final String message;
  Error(this.message);
}