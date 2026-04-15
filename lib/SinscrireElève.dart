import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'SinscrireEntant.dart';


class SinscrireEleve extends StatefulWidget {
  const SinscrireEleve({super.key});

  @override
  State<SinscrireEleve> createState() => _SinscrireEleveState();
}

class _SinscrireEleveState extends State<SinscrireEleve> {

  final _formkey = GlobalKey<FormState>();
  final NOMController = TextEditingController();
  final PRENOMcontroller = TextEditingController();
  final NVEController = TextEditingController();
  final EMAILController = TextEditingController();
  final MOTDEPASSEController = TextEditingController();
  final CONFIRMController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    NOMController.dispose();
    PRENOMcontroller.dispose();
    NVEController.dispose();
    EMAILController.dispose();
    MOTDEPASSEController.dispose();
    CONFIRMController.dispose();
  }

  Future<void> _inscrire() async {
    if (!_formkey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    FocusScope.of(context).unfocus();

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: EMAILController.text.trim(),
        password: MOTDEPASSEController.text.trim(),
      );

      String uid = userCredential.user!.uid;

      await FirebaseFirestore.instance
          .collection('Apprenants')
          .doc(uid)
          .set({
        'nom': NOMController.text.trim(),
        'prenom': PRENOMcontroller.text.trim(),
        'niveau': NVEController.text.trim(),
        'email': EMAILController.text.trim(),
        'dateInscription': Timestamp.now(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Compte créé avec succès !"),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SinscrireEnTant()),
      );

    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'email-already-in-use':
          message = "Cet email est déjà utilisé";
          break;
        case 'weak-password':
          message = "Mot de passe trop faible (6 caractères min)";
          break;
        case 'invalid-email':
          message = "Email invalide";
          break;
        case 'network-request-failed':
          message = "Pas de connexion internet";
          break;
        default:
          message = "Erreur Firebase : ${e.code} - ${e.message}";
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.redAccent,
          duration: const Duration(seconds: 6),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Erreur : ${e.toString()}"),
          backgroundColor: Colors.orange,
          duration: const Duration(seconds: 6),
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
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
          "Inscription Apprenant",
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
                      "Creer votre compte",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontFamily: 'poppins',
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 50),

                    // NOM
                    TextFormField(
                      controller: NOMController,
                      keyboardType: TextInputType.name,
                      style: const TextStyle(color: Colors.white, fontFamily: 'poppins'),
                      decoration: _buildDecoration('Nom', 'Entrez votre nom', Icons.person_2_outlined),
                      validator: (value) => value == null || value.isEmpty ? "Champ obligatoire" : null,
                    ),
                    const SizedBox(height: 20),

                    // PRENOM
                    TextFormField(
                      controller: PRENOMcontroller,
                      keyboardType: TextInputType.name,
                      style: const TextStyle(color: Colors.white, fontFamily: 'poppins'),
                      decoration: _buildDecoration('Prenom', 'Entrez votre prenom', Icons.person),
                      validator: (value) => value == null || value.isEmpty ? "Champ obligatoire" : null,
                    ),
                    const SizedBox(height: 20),

                    // NIVEAU
                    TextFormField(
                      controller: NVEController,
                      keyboardType: TextInputType.url,
                      style: const TextStyle(color: Colors.white, fontFamily: 'poppins'),
                      decoration: _buildDecoration('Niveau', 'Entrez votre niveau d\'etude', Icons.school),
                      validator: (value) => value == null || value.isEmpty ? "Champ obligatoire" : null,
                    ),
                    const SizedBox(height: 20),

                    // EMAIL
                    TextFormField(
                      controller: EMAILController,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(color: Colors.white, fontFamily: 'poppins'),
                      decoration: _buildDecoration('Email', 'Entrez votre adresse email', Icons.email_outlined),
                      validator: (value) => value == null || value.isEmpty ? "Champ obligatoire" : null,
                    ),
                    const SizedBox(height: 20),

                    // MOT DE PASSE
                    TextFormField(
                      controller: MOTDEPASSEController,
                      obscureText: _obscurePassword,
                      style: const TextStyle(color: Colors.white, fontFamily: 'poppins'),
                      decoration: _buildDecoration(
                        'Mot de passe', 'Entrez votre mot de passe', Icons.lock_outline,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                            color: Colors.white.withOpacity(0.5),
                          ),
                          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) return "Champ obligatoire";
                        if (value.length < 6) return "Minimum 6 caractères";
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // CONFIRMATION MOT DE PASSE ← nouveau
                    TextFormField(
                      controller: CONFIRMController,
                      obscureText: _obscureConfirm,
                      style: const TextStyle(color: Colors.white, fontFamily: 'poppins'),
                      decoration: _buildDecoration(
                        'Confirmer le mot de passe', 'Répétez votre mot de passe', Icons.lock_outline,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirm ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                            color: Colors.white.withOpacity(0.5),
                          ),
                          onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) return "Champ obligatoire";
                        if (value != MOTDEPASSEController.text) {
                          return "Les mots de passe ne correspondent pas"; // ← vérification
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),

                    // BOUTON
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF1A1F5C),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          elevation: 0,
                        ),
                        onPressed: _isLoading ? null : _inscrire,
                        child: _isLoading
                            ? const CircularProgressIndicator(color: Color(0xFF1A1F5C))
                            : const Text(
                          "Creer un compte",
                          style: TextStyle(
                            fontFamily: 'poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _buildDecoration(String label, String hint, IconData icon, {Widget? suffixIcon}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      labelStyle: TextStyle(color: Colors.white.withOpacity(0.6), fontFamily: 'poppins'),
      hintStyle: TextStyle(color: Colors.white.withOpacity(0.2), fontFamily: 'poppins'),
      prefixIcon: Icon(icon, color: Colors.white.withOpacity(0.5)),
      suffixIcon: suffixIcon,
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.white.withOpacity(0.2))),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Colors.white, width: 1.5)),
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Colors.redAccent)),
      focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Colors.redAccent)),
      filled: true,
      fillColor: Colors.white.withOpacity(0.07),
    );
  }
}