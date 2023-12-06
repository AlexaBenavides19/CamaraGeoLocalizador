import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Camara extends StatefulWidget {
  @override
 _CamaraState createState() => _CamaraState();
}

class _CamaraState extends State<Camara>{
List<File> imagenes =[];
File? imagen;
final picker=ImagePicker();

Future selImagen(op) async{

  var pickerFile;

  if(op==1){
    pickerFile= await picker.pickImage(source:ImageSource.camera);
  }else{
    pickerFile=await picker.pickMedia();
  }
  setState((){
    if(pickerFile != null){
      imagen= File(pickerFile.path);
      imagenes.add(imagen!);
    }else{
    }
  });
  Navigator.of(context).pop();
  
}

void eliminarImagen(int index) {
    setState(() {
      imagenes.removeAt(index);
    });
  }

opciones(context){
    showDialog(
      context:context,
      builder:(BuildContext context){
        return  AlertDialog(
          contentPadding: const EdgeInsets.all(0),
          content: SingleChildScrollView(
            child: Column(
              children: [
                InkWell(
                  onTap: (){
                    selImagen(1);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                    ),
                    child: const Row(
                      children: [
                        Expanded(
                          child: Text('Cámara',style: TextStyle(
                            fontSize: 16
                          ),),
                        ),
                        Icon(Icons.camera_alt,color: Colors.pink)
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    selImagen(2);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      border: Border(bottom:BorderSide(width: 10,color: Colors.grey))
                    ),
                    child: const Row(
                      children: [
                        Expanded(
                          child: Text('Galería',style: TextStyle(
                            fontSize: 16
                          ),),
                        ),
                        Icon(Icons.image,color: Colors.pink,)
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Colors.pink
                    ),
                    child: const Row(
                      children: [
                        Expanded(
                          child: Text('Salir',style: TextStyle(
                            fontSize: 16,
                            color: Colors.black
                          ),textAlign:TextAlign.center,),
                        ),
                        Icon(Icons.exit_to_app)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
    }


@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fotografías'),
        centerTitle: true,
        backgroundColor: Colors.pink,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: (){
                    opciones(context);
                  },
                  child: const Text('Imagen',style: TextStyle(color: Colors.pink),),
                ),
                const SizedBox(height: 30,),
                imagen == null 
                ?  const Center()
                : Image.file(imagen!),
                const SizedBox(
                  height: 100,
                ),
                const Text('Imágenes anteriores: '),
                for (int i = 0; i < imagenes.length; i++)
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Card(
                    child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            Image.file(imagenes[i],height: 200,width: 200,
                            ),
                          IconButton(
                            icon: const Icon(Icons.delete,color:Colors.pink,size: 50,),
                            onPressed: () {
                              eliminarImagen(i);
                            },
                          ),
                        ]
                        )
                        ],
                      ),
                  ),
                ),
            ]),
          )
        ],
      ),
    );
  }
}