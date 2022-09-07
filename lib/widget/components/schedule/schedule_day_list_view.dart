import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:schetify/model/entity/schedule_candidate.dart';
import 'package:schetify/widget/components/schedule/schedule_day_list_tile.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../provider/event_update_provider.dart';

class ScheduleDayListView extends HookConsumerWidget {
  ScheduleDayListView({Key? key, required this.scheduleCandidates, required this.scrollController, required this.eventId}) : super(key: key);

  final SplayTreeSet<ScheduleCandidate> scheduleCandidates;
  final ItemScrollController scrollController;
  final ItemPositionsListener positionsListener = ItemPositionsListener.create();
  final int? eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(eventUpdateProvider.notifier);
    return ScrollablePositionedList.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemBuilder: (context, index) {
        return Dismissible(
          key: UniqueKey(),
          onDismissed: (direction) => notifier.removePeriod(scheduleCandidates.elementAt(index)),
          background: Container(
            color: Colors.red,
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          child: Column(
            children: [
              Container( // SizedBoxにした方がいいというWarningが出るが、パッケージの挙動がおかしくなるのでContainerのままにした
                height: 30,
                child: ScheduleDayListTile(scheduleCandidates: scheduleCandidates, index: index, eventId: eventId,),
              ),
              const Divider()
            ],
          ),
        );
      },
      itemScrollController: scrollController,
      itemPositionsListener: positionsListener,
      itemCount: scheduleCandidates.length);
  }
}