import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';

class MovieListing extends StatefulWidget {
  const MovieListing({super.key});

  @override
  State<MovieListing> createState() => _MovieListingState();
}

class _MovieListingState extends State<MovieListing> {
  int selectedTickets = 1;
  String bookingMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle, style: cinemaHeaderStyle),
        backgroundColor: cinemaSurface,
        iconTheme: const IconThemeData(color: cinemaBrand),
        elevation: 0,
      ),
      drawer: const NavDrawer(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isWide = constraints.maxWidth > 600;
          final movieInfo =
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Emma (2020) (U)',
                style: TextStyle(
                  color: cinemaFontWhite,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 24),
            const Text(
                "Emma. (2020) is a visually vibrant, witty period romantic comedy directed by Autumn de Wilde and based on Jane Austen's 1815 novel.",
                style: TextStyle(
                  color: cinemaFontWhite,
                  fontSize: 16,
                )),
            const SizedBox(height: 24),
            const Text('Friday 2nd October 2026, 18:00 - ends at 19:24.',
                style: TextStyle(
                  color: cinemaFontWhite,
                  fontSize: 16,
                )),
            const SizedBox(height: 24),
            Text(
                'Please note that Discounts/Membership benefits will be applied once you have selected your tickets.',
                style: TextStyle(
                  color: cinemaFontWhite,
                  fontSize: 16,
                )),
            const SizedBox(height: 24),
            Text('Select Quantities(Up to 5 in total)',
                style: TextStyle(
                  color: cinemaFontMuted,
                  fontSize: 20,
                )),
            const SizedBox(height: 24),
          ]);
          final ticketControls = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Ticket(s)',
                style: TextStyle(
                    color: cinemaFontWhite,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              DropdownMenu<int>(
                  initialSelection: selectedTickets,
                  dropdownMenuEntries: const [
                    DropdownMenuEntry(value: 1, label: 'One ticket'),
                    DropdownMenuEntry(value: 2, label: 'Two tickets'),
                    DropdownMenuEntry(value: 3, label: 'Three tickets'),
                    DropdownMenuEntry(value: 4, label: 'Four tickets'),
                    DropdownMenuEntry(value: 5, label: 'Five tickets')
                  ],
                  onSelected: (int? value) {
                    if (value != null) {
                      setState(() {
                        selectedTickets = value;
                      });
                    }
                  }),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    bookingMessage =
                        '$selectedTickets ticket(s) added to order';
                  }); //elevated button
                  const SizedBox(
                    height: 12,
                  );
                },
                child: const Text('Add to Order'),
              ),
              Text(bookingMessage, style: TextStyle(color: cinemaBrandLight))
            ],
          );

          return Container(
            padding: const EdgeInsets.all(24),
            child: isWide
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: movieInfo),
                      const SizedBox(width: 32),
                      ticketControls,
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      movieInfo,
                      const SizedBox(height: 32),
                      ticketControls,
                    ],
                  ),
          );
        },
      ),
    );
  }
}
