abstract class AccountEvent {

}

class AddAccountEvent extends AccountEvent{
final String? email;
final String password;
AddAccountEvent({required this.email,required this.password});



}
class ChangeAccountEvent extends AccountEvent{}
