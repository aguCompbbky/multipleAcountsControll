import 'package:multiple_accounts/bloc/account_event.dart';
import 'package:multiple_accounts/bloc/account_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multiple_accounts/services/account_services.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountServices accountServices;

  AccountBloc(this.accountServices) : super(AccountState()) {
    on<AddAccountEvent>((event, emit) {
      try {
        emit(AccountState());
        print(event.email);
        accountServices.addNewAccount(event.email ?? "", event.password);
      } on Exception catch (e) {
        emit(ErrorState(error: e.toString()) as AccountState);
        print(e.toString());
      }
    });

  }
}
