
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/core/constants.dart';
import 'package:eshop/features/authentification/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nomController = TextEditingController();
  TextEditingController _nomutilController = TextEditingController();
  TextEditingController _telController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addUserToFirestore(String userId, String email, String nom,
      String username, String telephone, String role) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'email': email,
        'nom': nom,
        'username': username,
        'telephone': telephone,
        'role': role,
      });
    } catch (e) {
      print("Erreur lors de l'ajout de l'utilisateur à Firestore : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
       
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 100),
                Padding(
                  padding: const EdgeInsets.only(left: 1),
                  child: Center(
                    child: Text(
                      "      S'inscire comme un client      ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 1),
                  child: Center(
                    child: Text(
                      "Veuillez introduire ces informations",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                CustomTextField(
                  controller: _nomController,
                  label: 'Nom et Prénom(*)',
                  isPassword: false,
                  prefixIcon: Icons.person,
                ),
                CustomTextField(
                  controller: _emailController,
                  label: 'Email(*)',
                  isPassword: false,
                  prefixIcon: Icons.email,
                ),
                CustomTextField(
                  controller: _telController,
                  label: 'Telephone(*)',
                  isPassword: false,
                  prefixIcon: Icons.call,
                ),
                CustomTextField(
                  controller: _nomutilController,
                  label: "Nom d'utilisateur(*)",
                  isPassword: false,
                  prefixIcon: Icons.person,
                ),
                CustomTextField(
                  controller: _passwordController,
                  label: 'Mot de passe(*)',
                  isPassword: true,
                  prefixIcon: Icons.lock,
                ),
                SizedBox(height: 30),
               MyyButton(
  onTap: () async {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _nomController.text.isNotEmpty &&
        _nomutilController.text.isNotEmpty &&
        _telController.text.isNotEmpty) {
      if (_passwordController.text.length < 6) {
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Le mot de passe doit contenir au moins 6 caractères'),
          ),
        );
        return; 
      }

      try {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        print("User registered: ${userCredential.user?.uid}");

      
        await addUserToFirestore(
          userCredential.user!.uid,
          _emailController.text,
          _nomController.text,
          _nomutilController.text,
          _telController.text,
          'user',
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      } catch (e) {
     
        if (e is FirebaseAuthException) {
          print("Error during registration - ${e.message}");
          if (e.code == 'email-already-in-use') {
           
            print("Email is already in use");
        
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Cet e-mail est déjà utilisé, veuillez en choisir un autre.'),
              ),
            );
          } else {
          
            print("Autre erreur d'authentification");
           
          }
        } else {
      
          print("Erreur inattendue: $e");
        }
      }
    } else {
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Veuillez remplir tous les champs'),
        ),
      );
    }
  },
),

                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                  child: Center(
                    child: Text(
                      "Vous avez un compte? Connectez-vous",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 9,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatefulWidget {
  final String label;
  final bool isPassword;
  final IconData? prefixIcon;
  final TextEditingController controller;

  const CustomTextField({
    required this.label,
    this.isPassword = false,
    this.prefixIcon,
    required this.controller,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1),
      padding: EdgeInsets.symmetric(horizontal: 1),
      child: TextField(
        obscureText: widget.isPassword,
        style: TextStyle(color: Colors.black),
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: TextStyle(
            color: Colors.grey,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          prefixIcon: widget.prefixIcon != null
              ? Icon(widget.prefixIcon, color: Colors.black)
              : null,
        ),
      ),
    );
  }
}
