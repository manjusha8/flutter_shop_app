import 'package:flutter/material.dart';

import 'package:flutter_app/providers/product.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();

  var editedProduct = Product(
      id: null, title: null, description: null, imageUrl: null, price: null);

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    print('init state');
    _imageUrlFocusNode.addListener(updateImageUrl);
    super.initState();
  }

  void updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    final _isValid = _form.currentState.validate();
    if (!_isValid) {
      return;
    }
    _form.currentState.save();
    print(editedProduct.title);
    print(editedProduct.price);
    print(editedProduct.description);
    print(editedProduct.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Products'),
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                _saveForm();
              })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'title',
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide a title';
                  }
                  return null;
                },
                onSaved: (value) {
                  editedProduct = Product(
                      id: null,
                      title: value,
                      description: editedProduct.description,
                      imageUrl: editedProduct.imageUrl,
                      price: editedProduct.price);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                onSaved: (value) {
                  editedProduct = Product(
                      id: null,
                      title: editedProduct.title,
                      description: editedProduct.description,
                      imageUrl: editedProduct.imageUrl,
                      price: double.parse(value));
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
                textInputAction: TextInputAction.next,
                maxLines: 3,
                focusNode: _descriptionFocusNode,
                onSaved: (value) {
                  editedProduct = Product(
                      id: null,
                      title: editedProduct.title,
                      description: value,
                      imageUrl: editedProduct.imageUrl,
                      price: editedProduct.price);
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 8, right: 12),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? Text('Enter a Url')
                        : FittedBox(
                            fit: BoxFit.cover,
                            child: Image.network(_imageUrlController.text),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Image Url'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      onSaved: (value) {
                        editedProduct = Product(
                            id: null,
                            title: editedProduct.title,
                            description: editedProduct.description,
                            imageUrl: value,
                            price: editedProduct.price);
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
