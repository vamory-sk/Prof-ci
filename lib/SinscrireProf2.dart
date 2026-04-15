import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'SinscrireEntant.dart';


class Sinscrireprof2 extends StatefulWidget {
  final String nom;
  final String prenom;
  final String email;
  final String motdepasse;

  const Sinscrireprof2({
    super.key,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.motdepasse,
  });

  @override
  State<Sinscrireprof2> createState() => _Sinscrireprof2State();
}

class _Sinscrireprof2State extends State<Sinscrireprof2> {
  final _formkey = GlobalKey<FormState>();
  final TELController = TextEditingController();
  final TARIFController = TextEditingController();

  String? _selectedMatiere;
  String? _selectedVille;
  bool _isLoading = false;

  final List<String> matieres = [
    'Mathématiques', 'Physique-Chimie', 'Anglais', 'Français',
    'Informatique', 'SVT', 'Histoire-Géographie', 'Philosophie',
    'Économie', 'Espagnol', 'Tout niveau'
  ];

  final List<String> villes = [
    'Cocody', 'Yopougon', 'Plateau', 'Treichville', 'Abobo',
    'Adjamé', 'Marcory', 'Koumassi', 'Attécoubé', 'Port-Bouët',
    'Bingerville', 'Anyama', 'Grand-Bassam', 'Yamoussoukro',
    'San-Pedro', 'Man', 'Bouaké', 'Odienné', 'Korogho', 'Dabou',
  ];

  @override
  void dispose() {
    TELController.dispose();
    TARIFController.dispose();
    super.dispose();
  }

  Future<void> _terminerInscription() async {
    if (!_formkey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    FocusScope.of(context).unfocus();

    try {
      // 1. Créer le compte Firebase Auth
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: widget.email,
        password: widget.motdepasse,
      );

      String uid = userCredential.user!.uid;

      // 2. Sauvegarder dans Firestore
      await FirebaseFirestore.instance
          .collection('Professeurs')
          .doc(uid)
          .set({
        'nom': widget.nom,
        'prenom': widget.prenom,
        'email': widget.email,
        'tel': TELController.text.trim(),
        'matiere': _selectedMatiere,
        'ville': _selectedVille,
        'tarif': TARIFController.text.trim(),
        'dateInscription': Timestamp.now(),
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Compte créé avec succès !"),
          backgroundColor: Colors.green,
        ),
      );

      // 3. Rediriger
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
          message = "Erreur : ${e.code} - ${e.message}";
      }
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.redAccent),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur : ${e.toString()}"), backgroundColor: Colors.orange),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  OutlineInputBorder _border(double radius) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(radius),
    borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
  );
  OutlineInputBorder _focusedBorder() => OutlineInputBorder(
    borderRadius: BorderRadius.circular(14),
    borderSide: const BorderSide(color: Colors.white, width: 1.5),
  );
  OutlineInputBorder _errorBorder() => OutlineInputBorder(
    borderRadius: BorderRadius.circular(14),
    borderSide: const BorderSide(color: Colors.redAccent),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1F5C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1F5C),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Inscription Professeur",
          style: TextStyle(color: Colors.white, fontFamily: 'poppins', fontWeight: FontWeight.w600, fontSize: 20),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: -60, right: -60,
            child: Container(
              width: 250, height: 220,
              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withOpacity(0.05)),
            ),
          ),
          Positioned(
            bottom: 100, left: -50,
            child: Container(
              width: 250, height: 220,
              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withOpacity(0.04)),
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
                    const Text("Bienvenue",
                      style: TextStyle(color: Colors.white, fontFamily: 'poppins', fontSize: 28, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 6),
                    Text("Informations visibles par les apprenants",
                      style: TextStyle(color: Colors.white.withOpacity(0.5), fontFamily: 'poppins', fontSize: 14),
                    ),
                    const SizedBox(height: 40),

                    // TÉLÉPHONE
                    TextFormField(
                      controller: TELController,
                      keyboardType: TextInputType.phone,
                      style: const TextStyle(color: Colors.white, fontFamily: 'poppins'),
                      decoration: InputDecoration(
                        labelText: 'Téléphone', hintText: 'Ex: 07 00 00 00 00',
                        labelStyle: TextStyle(color: Colors.white.withOpacity(0.6), fontFamily: 'poppins'),
                        hintStyle: TextStyle(color: Colors.white.withOpacity(0.2), fontFamily: 'poppins'),
                        prefixIcon: Icon(Icons.phone, color: Colors.white.withOpacity(0.5)),
                        enabledBorder: _border(16), focusedBorder: _focusedBorder(),
                        errorBorder: _errorBorder(), focusedErrorBorder: _errorBorder(),
                        filled: true, fillColor: Colors.white.withOpacity(0.07),
                      ),
                      validator: (value) => value == null || value.isEmpty ? "Champ obligatoire" : null,
                    ),
                    const SizedBox(height: 20),

                    // MATIÈRE
                    DropdownButtonFormField<String>(
                      value: _selectedMatiere,
                      dropdownColor: const Color(0xFF1E2D72),
                      style: const TextStyle(color: Colors.white, fontFamily: 'poppins', fontSize: 16),
                      icon: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white.withOpacity(0.5)),
                      decoration: InputDecoration(
                        labelText: 'Matière enseignée',
                        labelStyle: TextStyle(color: Colors.white.withOpacity(0.6), fontFamily: 'poppins'),
                        prefixIcon: Icon(Icons.menu_book_rounded, color: Colors.white.withOpacity(0.5)),
                        enabledBorder: _border(16), focusedBorder: _focusedBorder(),
                        errorBorder: _errorBorder(), focusedErrorBorder: _errorBorder(),
                        filled: true, fillColor: Colors.white.withOpacity(0.07),
                      ),
                      hint: Text('Sélectionnez une matière',
                        style: TextStyle(color: Colors.white.withOpacity(0.3), fontFamily: 'poppins', fontSize: 14),
                      ),
                      items: matieres.map((m) => DropdownMenuItem(value: m, child: Text(m))).toList(),
                      onChanged: (val) => setState(() => _selectedMatiere = val),
                      validator: (value) => value == null ? "Champ obligatoire" : null,
                    ),
                    const SizedBox(height: 20),

                    // VILLE
                    DropdownButtonFormField<String>(
                      value: _selectedVille,
                      dropdownColor: const Color(0xFF1E2D72),
                      style: const TextStyle(color: Colors.white, fontFamily: 'poppins', fontSize: 16),
                      icon: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white.withOpacity(0.5)),
                      decoration: InputDecoration(
                        labelText: 'Commune / Ville',
                        labelStyle: TextStyle(color: Colors.white.withOpacity(0.6), fontFamily: 'poppins'),
                        prefixIcon: Icon(Icons.location_on_rounded, color: Colors.white.withOpacity(0.5)),
                        enabledBorder: _border(16), focusedBorder: _focusedBorder(),
                        errorBorder: _errorBorder(), focusedErrorBorder: _errorBorder(),
                        filled: true, fillColor: Colors.white.withOpacity(0.07),
                      ),
                      hint: Text('Sélectionnez votre commune',
                        style: TextStyle(color: Colors.white.withOpacity(0.3), fontFamily: 'poppins', fontSize: 14),
                      ),
                      items: villes.map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
                      onChanged: (val) => setState(() => _selectedVille = val),
                      validator: (value) => value == null ? "Champ obligatoire" : null,
                    ),
                    const SizedBox(height: 20),

                    // TARIF
                    TextFormField(
                      controller: TARIFController,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(color: Colors.white, fontFamily: 'poppins'),
                      decoration: InputDecoration(
                        labelText: 'Tarifs', hintText: '2000 FCFA/h',
                        labelStyle: TextStyle(color: Colors.white.withOpacity(0.6), fontFamily: 'poppins'),
                        hintStyle: TextStyle(color: Colors.white.withOpacity(0.2), fontFamily: 'poppins'),
                        prefixIcon: Icon(Icons.money, color: Colors.white.withOpacity(0.5)),
                        enabledBorder: _border(16), focusedBorder: _focusedBorder(),
                        errorBorder: _errorBorder(), focusedErrorBorder: _errorBorder(),
                        filled: true, fillColor: Colors.white.withOpacity(0.07),
                      ),
                      validator: (value) => value == null || value.isEmpty ? "Champ obligatoire" : null,
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
                        onPressed: _isLoading ? null : _terminerInscription,
                        child: _isLoading
                            ? const CircularProgressIndicator(color: Color(0xFF1A1F5C))
                            : const Text(
                          "Terminer l'inscription",
                          style: TextStyle(fontFamily: 'poppins', fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
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