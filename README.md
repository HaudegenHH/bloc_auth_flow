# Flutter bloc auth project

## Getting Started

- create a Login Page with Username & Password Field (TextFormField because it comes with the option to add a validator)
- define the actions/events (class LoginEvent)
  - username and password can change and the button can be clicked
  - lets call these events: LoginUsernameChanged, LoginPasswordChanged, LoginSubmitted
  - The first 2 events hold onto the values of their related Inputfields, that they are responsible for watching, whereas the LoginSubmitted is just an event that you can add, and nothing needs to be passed in to the constructor, because you will be actually able to keep track of the username and password from the state.
- Next create the LoginState which is kind of the counter part that essentially gonna takes the event be mapped to the state.
  so consider: whenever you update the username, you dont want to go back to fetch the password and vice versa
  - copyWith() constructor
    ..which allows to update one value without needing to pass in the other value
    And 2nd part of the State is the Submission for which you can create a separate (abstract) class to keep track of the 4 "FormSubmissionStatus" (initial, formsubmitting, submit success, submit failure)
  - after defining those, create a 3rd parameter in the LoginState class "formStatus" of Type FormSubmissionStatus (and assign InitialFormStatus to it in the constructor)
- now create the LoginBloc that is interacting with those 2 objects (the event and the state)
- create the auth repository to simulate (for now) the login with a Future.delayed and get this loading state
- pass this auth repo to the LoginBloc constructor (so that you can call login() on the LoginSubmitted event)
- supplying the repository in main.dart so that it can be accessed further down the widget tree
  in other word: wrap the LoginView in the "RepositoryProvider"
- in login_view wrap the \_loginForm() with a BlocProvider and access the AuthRepo via the context
- wrap usernameField() and passwordField() with a BlocBuilder
- you could do the validation inside loginState instead of determine whether a value (username or password) is valid or not directly in the UI (inside the TextFormField)
  You can achieve that by simply adding additional boolean fields like:

```sh
bool get isValidUsername => usernmae.length > 6
```

or with the help of a little extension..

```sh
extension StringValidators on String {
  bool get containsUppercase => contains(RegExp(r'[A-Z]'));
  bool get containsLowercase => contains(RegExp(r'[a-z]'));
}
```

```sh
 final String password;
bool get isValidPassword => password.length >= 6 &&
                            password.containsUppercase &&
                            password.containsLower;
```

- next wrap the login Button in a blocBuilder too and then watch for the state to make sure whether to show the button or (when in submitting state) a circularProgressIndicator..
