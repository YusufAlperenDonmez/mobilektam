import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

enum ShapeType { circle, rectangle }

class Shape {
  final Offset offset;
  final double width;
  final double height;
  final Color color;
  final ShapeType type;

  Shape({
    required this.offset,
    required this.width,
    required this.height,
    required this.color,
    required this.type,
  });
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 215, 233, 241), //
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(10.0),
        child: Stack(
          children: [
            CustomPaint(
              painter: ShapePainter(
                shapes: [
                  Shape(
                    offset: Offset(50, 50),
                    width: 300,
                    height: 300,
                    color: const Color.fromARGB(255, 91, 77, 173),
                    type: ShapeType.circle,
                  ),
                  Shape(
                    offset: Offset(MediaQuery.of(context).size.width, 0),
                    width: 500,
                    height: 500,
                    color: const Color.fromARGB(255, 67, 78, 177),
                    type: ShapeType.circle,
                  ),
                  Shape(
                    offset: Offset(0, MediaQuery.of(context).size.height),
                    width: 200,
                    height: 200,
                    color: const Color.fromARGB(255, 67, 78, 177),
                    type: ShapeType.circle,
                  ),

                  Shape(
                    offset: Offset(
                      100,
                      MediaQuery.of(context).size.height - 100,
                    ),
                    width: 50,
                    height: 50,
                    color: const Color.fromARGB(255, 67, 78, 177),
                    type: ShapeType.circle,
                  ),
                ],
              ),
              size: Size.infinite,
            ),
            // Place your image at the center (or use Positioned for custom placement)
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 120),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/ektamlogo.jpg',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: 250, // Reduced width
                    child: TextFormField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Kullanıcı Adı',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white, // Make background white
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 12,
                        ),
                      ),
                      style: const TextStyle(fontSize: 14), // Smaller font
                    ),
                  ),
                  const SizedBox(height: 12), // Slightly reduced vertical space
                  SizedBox(
                    width: 250, // Reduced width
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Şifre',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white, // Make background white
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 12,
                        ),
                      ),
                      style: const TextStyle(fontSize: 14), // Smaller font
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: 150,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 67, 78, 177),
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        if (usernameController.text.isEmpty ||
                            passwordController.text.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Hata'),
                              content: const Text(
                                'Lütfen tüm alanları doldurun.',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text('Tamam'),
                                ),
                              ],
                            ),
                          );
                        } else {
                          // TODO: Implement login logic
                        }
                      },
                      child: const Text(
                        'GİRİŞ',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShapePainter extends CustomPainter {
  final List<Shape> shapes;

  ShapePainter({required this.shapes});

  @override
  void paint(Canvas canvas, Size size) {
    for (final shape in shapes) {
      final paint = Paint()
        ..color = shape.color
        ..style = PaintingStyle.fill;

      if (shape.type == ShapeType.rectangle) {
        final rect = Rect.fromCenter(
          center: shape.offset,
          width: shape.width,
          height: shape.height,
        );
        // Draw shadow for rectangle
        canvas.drawShadow(
          Path()..addRect(rect),
          Colors.black.withOpacity(0.3),
          8.0,
          false,
        );
        canvas.drawRect(rect, paint);
      } else if (shape.type == ShapeType.circle) {
        final radius = shape.width < shape.height
            ? shape.width / 2
            : shape.height / 2;
        // Draw shadow for circle
        canvas.drawShadow(
          Path()
            ..addOval(Rect.fromCircle(center: shape.offset, radius: radius)),
          Colors.black.withOpacity(0.5),
          8.0,
          false,
        );
        canvas.drawCircle(shape.offset, radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant ShapePainter oldDelegate) {
    return shapes != oldDelegate.shapes;
  }
}
