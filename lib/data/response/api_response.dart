import 'package:quick_slot_app/data/response/status.dart';

class ApiResponse<T> {
  Status? state;
  T? data;
  String? message;

  ApiResponse(this.state, this.message, this.data);
  ApiResponse.loading() : state = Status.loading;
  ApiResponse.completed(this.data) : state = Status.completed;
  ApiResponse.error(this.message) : state = Status.error;

  @override
  String toString() {
    return "Status : $state \n Message : $message \n Data: $data";
  }
}
