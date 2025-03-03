import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_mobile_template/widgets/scaffold/page_scaffold.dart';

import '../../../widgets/scaffold/main_root_scaffold.dart';

class DemoNavigationScreen extends HookConsumerWidget {
  const DemoNavigationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageScaffold<MainRootScaffold>(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary, title: const Text('Features Demo')),
      body: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          Text('UI Components', style: Theme.of(context).textTheme.titleLarge),
          Gap(16.h),
          FilledButton(
            onPressed: () {
              context.push('/demo/components');
            },
            child: const Text('Snackbars, Alerts & Dialogs'),
          ),
          Gap(8.h),
          FilledButton(
            onPressed: () {
              context.push('/demo/i18n');
            },
            child: const Text('i18n & Translations'),
          ),

          Gap(24.h),
          Text('Data Fetching', style: Theme.of(context).textTheme.titleLarge),
          Gap(16.h),
          FilledButton(
            onPressed: () {
              context.push('/demo/query');
            },
            child: const Text('useQuery Hook'),
          ),

          Gap(8.h),
          FilledButton(
            onPressed: () {
              context.push('/demo/infinite-query');
            },
            child: const Text('useInfiniteQuery Hook'),
          ),
          Gap(8.h),
          FilledButton(onPressed: () => context.go('/demo/infinite-provider'), child: const Text('Infinite Provider')),
          Gap(8.h),
          FilledButton(
            onPressed: () {
              context.push('/demo/mutations');
            },
            child: const Text('Mutations (CRUD Operations)'),
          ),
        ],
      ),
    );
  }
}
