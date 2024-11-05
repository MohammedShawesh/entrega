import 'package:entrega/screens/admin_screens/new_flight/components/cubit/new_flight_card_cubit.dart';
import 'package:entrega/screens/admin_screens/new_flight/cubit/new_flight_cubit.dart';
import 'package:entrega/screens/admin_screens/widgets/button.dart';
import 'package:entrega/screens/admin_screens/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewDestinationCard extends StatelessWidget {
  const NewDestinationCard({super.key});

  @override
  Widget build(BuildContext context) {
    final newController = context.read<NewFlightCubit>();
    return BlocProvider(
      create: (context) => NewFlightCardCubit(),
      child: BlocBuilder<NewFlightCardCubit, NewFlightCardState>(
        builder: (context, state) {
          final controller = context.read<NewFlightCardCubit>();
          return Form(
            key: controller.key,
            child: Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text('Add destination'),
                    const SizedBox(height: 6),
                    inputField(controller.tripTitle, 'Destination'),
                    const SizedBox(height: 12),
                    const Text('Price'),
                    const SizedBox(height: 6),
                    inputField(controller.price, 'Price',
                        keyboard: TextInputType.number),
                    const SizedBox(height: 12),
                    const Text('Seats'),
                    const SizedBox(height: 6),
                    inputField(controller.seats, 'Seats',
                        keyboard: TextInputType.number),
                    const SizedBox(height: 12),
                    const Text('Times'),
                    const SizedBox(height: 6),
                    Column(
                      children: controller.departureTimes.map((time) {
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ListTile(
                                  title: Text('Day: ${time.day}'),
                                  subtitle: Text(
                                    'Departure Time: ${time.departureTime.join(', ')}',
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {
                                      controller.removeTime(time);
                                    },
                                    icon: const Icon(Icons.delete),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButton<String>(
                            value: controller.selectedDay,
                            isExpanded: true,
                            dropdownColor: Colors.white,
                            items: [
                              for (var day in controller.days)
                                DropdownMenuItem(
                                  value: day,
                                  key: Key(day),
                                  child: Text(day),
                                ),
                            ],
                            onChanged: (value) {
                              controller.selectDay(value);
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: InkWell(
                            radius: 8,
                            borderRadius: BorderRadius.circular(8),
                            onTap: () async {
                              await controller.selectTime(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.all(12),
                              child: Text(
                                controller.departureTime.isNotEmpty
                                    ? controller.departureTime
                                    : 'Select Time',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        IconButton.filled(
                          onPressed: () {
                            controller.addTime();
                          },
                          icon: const Icon(
                            Icons.add,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    button(
                      'Add Destination',
                      () {
                        controller.addDestination(newController);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
