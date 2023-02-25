import 'dart:io';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pmsna1/widgets/login_modal_widget.dart';
import 'package:path/path.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  File? _image;
  Future getImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imagePermanent = await saveFilePermanently(image.path);

      setState(() {
        this._image = imagePermanent;
      });

      final imageTemporary = File(image.path);

      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Error al elegir imagen: $e');
    }
  }

  Future<File> saveFilePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');

    return File(imagePath).copy(image.path);
  }

  set image(File image) {}

  @override
  Widget build(BuildContext context) {
    final txtNombre = TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor escriba su nombre';
        }
        return null;
      },
      decoration: const InputDecoration(
          label: Text('Nombre completo'), border: OutlineInputBorder()),
    );

    final txtCorreo = TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor escriba su correo electrónico';
        }
        if (!EmailValidator.validate(value)) {
          return 'Por favor escriba un correo válido';
        }
        return null;
      },
      decoration: const InputDecoration(
          label: Text('Correo electrónico'), border: OutlineInputBorder()),
    );

    final txtPassword = TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor escriba su contraseña';
        }
        return null;
      },
      decoration: const InputDecoration(
          label: Text('Contraseña'), border: OutlineInputBorder()),
    );

    final spaceHorizontal = const SizedBox(
      height: 10,
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                txtNombre,
                spaceHorizontal,
                txtCorreo,
                spaceHorizontal,
                txtPassword,
                const SizedBox(
                  height: 40,
                ),
                _image != null
                    ? Image.file(
                        _image!,
                        width: 250,
                        height: 250,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        'data:image/png;base64,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'),
                const SizedBox(
                  height: 40,
                ),
                spaceHorizontal,
                CustomButton(
                  title: 'Elegir de la galería',
                  icon: Icons.image_outlined,
                  onClick: () => getImage(ImageSource.gallery),
                ),
                spaceHorizontal,
                CustomButton(
                  title: 'Tomar una foto',
                  icon: Icons.camera,
                  onClick: () => getImage(ImageSource.camera),
                ),
                spaceHorizontal,
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Registrando espere un momento.')),
                      );
                    }
                  },
                  child: const Text('Registrarse'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget CustomButton({
  required String title,
  required IconData icon,
  required VoidCallback onClick,
}) {
  return Container(
    width: 280,
    child: ElevatedButton(
      onPressed: onClick,
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(
            width: 20,
          ),
          Text(title)
        ],
      ),
    ),
  );
}
