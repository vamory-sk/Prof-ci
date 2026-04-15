import 'package:flutter/material.dart';

import 'SinscrireProf2.dart';


class SinscrireProf extends StatefulWidget {
  const SinscrireProf({super.key});

  @override
  State<SinscrireProf> createState() => _SinscrireProfState();
}

class _SinscrireProfState extends State<SinscrireProf> {
  final _formkey = GlobalKey<FormState>();
  final NOMController = TextEditingController();
  final PRENOMController = TextEditingController();
  final EMAILController = TextEditingController();
  final MOTDEPASSEController = TextEditingController();
  final CONFIRMERMDPController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    NOMController.dispose();
    PRENOMController.dispose();
    EMAILController.dispose();
    MOTDEPASSEController.dispose();
    CONFIRMERMDPController.dispose();
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
          "Inscription Professeur",
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
                    const Text(
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
                      "Créer votre compte",
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
                      controller: PRENOMController,
                      keyboardType: TextInputType.name,
                      style: const TextStyle(color: Colors.white, fontFamily: 'poppins'),
                      decoration: _buildDecoration('Prénom', 'Entrez votre prénom', Icons.person),
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

                    // CONFIRMER MOT DE PASSE
                    TextFormField(
                      controller: CONFIRMERMDPController,
                      obscureText: _obscureConfirmPassword,
                      style: const TextStyle(color: Colors.white, fontFamily: 'poppins'),
                      decoration: _buildDecoration(
                        'Confirmer le mot de passe', 'Répétez votre mot de passe', Icons.lock_outline,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirmPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                            color: Colors.white.withOpacity(0.5),
                          ),
                          onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) return "Champ obligatoire";
                        if (value != MOTDEPASSEController.text) return "Les mots de passe ne correspondent pas";
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),

                    // BOUTON SUIVANT
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
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            FocusScope.of(context).unfocus();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Sinscrireprof2(
                                  nom: NOMController.text.trim(),
                                  prenom: PRENOMController.text.trim(),
                                  email: EMAILController.text.trim(),
                                  motdepasse: MOTDEPASSEController.text.trim(),
                                ),
                              ),
                            );
                          }
                        },
                        child: const Text(
                          "Suivant",
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