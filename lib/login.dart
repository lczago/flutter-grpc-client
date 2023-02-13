import 'package:first_project/grpc/pb/login_message.pbgrpc.dart';
import 'package:first_project/my_home_page.dart';
import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hello World!"),
      ),
      body: const Body(),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController controller = TextEditingController();

  final channel = ClientChannel(
    '192.168.1.102',
    port: 50051,
    options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
  );

  Future<bool> grpc() async {
    final stub = LoginServiceClient(channel);
    var response = await stub.login(LoginRequest()..name = controller.text);
    await channel.shutdown();
    if (!response.authenticated) {
      return false;
    }

    return true;
  }

  void click() {
    var authenticated = grpc();
    authenticated.then((value) => value
        ? Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyHomePage(controller.text)))
        : null);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.person),
            labelText: "Type Your Name:",
            border: const OutlineInputBorder(
                borderSide: BorderSide(width: 5, color: Colors.black)),
            suffixIcon: IconButton(
              icon: const Icon(Icons.done),
              splashColor: Colors.blueGrey,
              splashRadius: 22.0,
              tooltip: "Submit",
              onPressed: click,
            ),
          ),
        ),
      ),
    );
  }
}
