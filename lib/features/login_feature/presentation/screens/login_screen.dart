import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ok_task/core/utils/prefs_manager.dart';
import 'package:ok_task/features/login_feature/domain/entities/login_entity.dart';
import 'package:ok_task/features/login_feature/presentation/bloc/login_bloc.dart';
import 'package:ok_task/features/product_feature/presentation/screens/home_screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:ok_task/locator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _form = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Initially password is obscure
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    super.initState();

    //Checks if the user is logged in to auto login
    _handleLoggedIn();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  // Login form validation function
  bool _saveForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return false;
    }
    _form.currentState!.save();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /// Handling loadindg and error states of LoginBloc
    /// Login event is triggered in Login elevated button
    final loginMessage =
        BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      if (state is LoginLodingState) {
        return LoadingAnimationWidget.prograssiveDots(
            color: Colors.red, size: 50);
      } else if (state is LoginErrorState) {
        return Text(
          state.message,
          style: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        );
      }
      return Container();
    });

    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName,
                ModalRoute.withName('home_screen'));
          }
        },
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Column(
                children: [
                  SizedBox(height: 0.06 * size.height),
                  Form(
                    key: _form,
                    child: Column(
                      children: [
                        _emailTextField(),
                        SizedBox(height: 0.03 * size.height),
                        _passwordTextField(),
                      ],
                    ),
                  ),
                  SizedBox(height: 0.04 * size.height),
                  _loginButton(size),
                  SizedBox(height: 0.04 * size.height),
                  loginMessage,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _emailTextField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(
          10,
        ),
        child: TextFormField(
          controller: emailController,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 6.0,
            ),
            border: InputBorder.none,
            labelText: 'Email',
            prefixIcon: Icon(
              Icons.email,
              color: Colors.black,
            ),
          ),
          validator: (value) {
            if (!EmailValidator.validate(value!)) {
              return 'Please enter a valid email address';
            }
            if (value.isEmpty) {
              return 'This field can\'t be empty';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _passwordTextField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(
          10,
        ),
        child: TextFormField(
          controller: passwordController,
          obscureText: _obscureText,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 6.0,
            ),
            border: InputBorder.none,
            labelText: 'Password',
            prefixIcon: const Icon(
              Icons.lock,
              color: Colors.black,
            ),
            suffixIcon: IconButton(
                onPressed: _toggle,
                icon: const Icon(
                  Icons.remove_red_eye_outlined,
                  color: Colors.black,
                )),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter the password';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _loginButton(Size size) {
    return SizedBox(
      width: double.infinity,
      height: 0.08 * size.height,
      child: ElevatedButton(
        onPressed: () async {
          if (_saveForm()) {
            BlocProvider.of<LoginBloc>(context).add(
              LoginButtonPressedEvent(
                LoginEntity(
                  email: emailController.text,
                  password: passwordController.text,
                ),
              ),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Login',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: 0.01 * size.width,
            ),
            const Icon(
              Icons.arrow_forward,
            ),
          ],
        ),
      ),
    );
  }

  void _handleLoggedIn() async {
    PrefsManager prefsManager = locator<PrefsManager>();

    if (await prefsManager.isLoggedIn()) {
      Navigator.pushNamedAndRemoveUntil(
          context, HomeScreen.routeName, ModalRoute.withName('home_screen'));
    }
  }
}
