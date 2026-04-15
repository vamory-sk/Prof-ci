import 'package:flutter/material.dart';

import 'SinscrireEntant.dart';


class Seconnecter extends StatefulWidget {
  Seconnecter({super.key});

  @override
  State<Seconnecter> createState() => _SeconnecterState();
}

class _SeconnecterState extends State<Seconnecter> {
  final _formkey = GlobalKey<FormState>();

  final EMAILController = TextEditingController();
  final MOTDEPASSEController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void dispose() {
    EMAILController.dispose();
    MOTDEPASSEController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1F5C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1F5C),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Se Connecter",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'poppins',
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: -60,
            right: -60,
            child: Container(
              width: 250,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),
          // Blob bas gauche
          Positioned(
            bottom: 100,
            left: -50,
            child: Container(
              width: 250,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.04),
              ),
            ),
          ),


          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),

                    // Titre
                    Text(
                      "Bienvenue",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'poppins',
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Connectez-vous à votre compte",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontFamily: 'poppins',
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 50),

                    // Champ EMAIL
                    TextFormField(
                      controller: EMAILController,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'poppins',
                      ),
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Entrez votre adresse email',
                        labelStyle: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontFamily: 'poppins',
                        ),
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.2),
                          fontFamily: 'poppins',
                        ),
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.white.withOpacity(0.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: Colors.white.withOpacity(0.2),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 1.5,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(color: Colors.redAccent),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(color: Colors.redAccent),
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.07),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Tu dois remplir le champ vide";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    // MOT DE PASSE
                    TextFormField(
                      controller: MOTDEPASSEController,
                      obscureText: _obscurePassword,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'poppins',
                      ),
                      decoration: InputDecoration(
                        labelText: 'Mot de passe',
                        hintText: 'Entrez votre mot de passe',
                        labelStyle: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontFamily: 'poppins',
                        ),
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.3),
                          fontFamily: 'poppins',
                        ),
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: Colors.white.withOpacity(0.5),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: Colors.white.withOpacity(0.5),
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(
                            color: Colors.white.withOpacity(0.2),
                          ),

                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 1.5,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(color: Colors.redAccent),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(color: Colors.redAccent),
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.07),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Tu dois remplir le champ vide";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 48),

                    // Bouton Envoyer
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF1A1F5C),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            final EMAIL = EMAILController.text;
                            final MOTDEPASSE = MOTDEPASSEController.text;
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Envoi en cours...")),
                            );
                            FocusScope.of(context).requestFocus(FocusNode());
                            print("Ajout de l'email $EMAIL et du mot de passe $MOTDEPASSE");
                          }
                        },
                        child: const Text(
                          "Envoyer",
                          style: TextStyle(
                            fontFamily: 'poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Bouton S'inscrire
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(
                              color: Colors.white.withOpacity(0.3),
                              width: 1.5,
                            ),
                          ),
                          elevation: 0,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SinscrireEnTant(),
                            ),
                          );
                        },
                        child: const Text(
                          "S'inscrire",
                          style: TextStyle(
                            fontFamily: 'poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}