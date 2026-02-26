import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {

  TextEditingController controller = TextEditingController();

  String reply = "";

  bool showAgent = false;

  /// AI Help
  void solveProblem(){

    String text = controller.text.toLowerCase();

    showAgent=false;

    if(text.contains("map")){

      reply = "Check GPS and Internet.";

    }

    else if(text.contains("login")){

      reply = "Restart app and login again.";

    }

    else if(text.contains("tracking")){

      reply = "Driver tracking must be ON.";

    }

    else{

      reply =
      "AI could not solve problem.\nContact Agent.";

      showAgent=true;

    }

    setState(() {});

  }

  /// Agent Call
  void callAgent() async {

    final Uri phone =
    Uri.parse("tel:9876543210"); // apna number

    await launchUrl(phone);

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("AI Help Center"),
      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            const Text(
              "Describe Problem",
              style: TextStyle(fontSize:18),
            ),

            const SizedBox(height:20),

            TextField(

              controller: controller,

              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Type problem...",
              ),

            ),

            const SizedBox(height:20),

            ElevatedButton(

              onPressed: solveProblem,

              child: const Text("Solve with AI"),

            ),

            const SizedBox(height:20),

            Text(reply),

            const SizedBox(height:30),

            /// Agent Button only if AI fails

            if(showAgent)

            ElevatedButton(

              onPressed: callAgent,

              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red
              ),

              child: const Text("Call Agent"),

            )

          ],

        ),

      ),

    );

  }

}