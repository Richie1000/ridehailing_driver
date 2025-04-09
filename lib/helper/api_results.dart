sealed class ApiResult<T> {
  const ApiResult();

  void when({
    required void Function(T data) success,
    required void Function(String error) failure,
  }) {
    if (this is ApiSuccess<T>) {
      success((this as ApiSuccess<T>).data);
    } else if (this is ApiFailure<T>) {
      failure((this as ApiFailure<T>).message);
    }
  }

  R map<R>({
    required R Function(T data) success,
    required R Function(String error) failure,
  }) {
    if (this is ApiSuccess<T>) {
      return success((this as ApiSuccess<T>).data);
    } else {
      return failure((this as ApiFailure<T>).message);
    }
  }
}

class ApiSuccess<T> extends ApiResult<T> {
  final T data;
  const ApiSuccess(this.data);
}

class ApiFailure<T> extends ApiResult<T> {
  final String message;
  const ApiFailure(this.message);
}
