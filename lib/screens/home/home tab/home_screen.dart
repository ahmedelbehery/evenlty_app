import 'package:evenlty_app/common/widgets/custom_main_button.dart';
import 'package:evenlty_app/provider/event_provider.dart';
import 'package:evenlty_app/screens/home/home%20tab/view/events_list.dart';
import 'package:evenlty_app/screens/home/home%20tab/view/home_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<EventProvider>(context, listen: false).getEvents(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const HomeHeader(),
            Expanded(
              child: Consumer<EventProvider>(
                builder: (context, provider, _) {
                  if (provider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
    
                  if (provider.errorMessage != null) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            provider.errorMessage!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.red),
                          ),
                          const SizedBox(height: 12),
                          CustomMainButton(
                            text: "Retry",
                            onPressed: provider.getEvents,
                          ),
                        ],
                      ),
                    );
                  }
    
                  if (provider.events.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("No events yet"),
                          const SizedBox(height: 12),
                          CustomMainButton(
                            text: "Reload",
                            onPressed: provider.getEvents,
                          ),
                        ],
                      ),
                    );
                  }
    
                  return RefreshIndicator(
                    onRefresh: provider.getEvents,
                    child: EventsListView(events: provider.events),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
