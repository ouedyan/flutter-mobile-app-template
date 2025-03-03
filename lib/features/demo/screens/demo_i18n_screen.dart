import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_mobile_template/i18n/locale_provider.dart';
import 'package:flutter_mobile_template/i18n/translations.g.dart';
import 'package:flutter_mobile_template/widgets/lang_selector.dart';
import 'package:flutter_mobile_template/widgets/scaffold/main_root_scaffold.dart';
import 'package:flutter_mobile_template/widgets/scaffold/page_scaffold.dart';

class DemoI18nScreen extends HookConsumerWidget {
  const DemoI18nScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final currentLocale = ref.watch(localeProvider);

    return PageScaffold<MainRootScaffold>(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary, title: const Text('i18n Demo')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Language Selector', style: Theme.of(context).textTheme.titleLarge),
            Gap(16.h),
            const LangSelector(width: 120),
            Gap(24.h),
            Text('Current Locale: ${currentLocale.languageTag}', style: Theme.of(context).textTheme.titleMedium),
            Gap(24.h),
            Text('String Interpolation', style: Theme.of(context).textTheme.titleLarge),
            Gap(16.h),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Simple: ${t.demo.welcome(name: 'John')}'),
                    Gap(8.h),
                    Text('With DateTime: ${t.demo.last_login(date: DateTime.now())}'),
                  ],
                ),
              ),
            ),
            Gap(24.h),
            Text('Pluralization', style: Theme.of(context).textTheme.titleLarge),
            Gap(16.h),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• ${t.demo.items(count: 0)}'),
                    Text('• ${t.demo.items(count: 1)}'),
                    Text('• ${t.demo.items(count: 2)}'),
                    Text('• ${t.demo.items(count: 5)}'),
                    Text('• ${t.demo.items(count: 20)}'),
                    Gap(16.h),
                    Text('Multiple plurals in one sentence (Linked Translations):'),
                    Text('• ${t.demo.fruits(appleCount: 1, bananaCount: 2)}'),
                    Text('• ${t.demo.fruits(appleCount: 0, bananaCount: 1)}'),
                  ],
                ),
              ),
            ),
            Gap(24.h),
            Text('Custom Context (Gender)', style: Theme.of(context).textTheme.titleLarge),
            Gap(16.h),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• ${t.demo.gender(name: 'John', context: Gender.male)}'),
                    Text('• ${t.demo.gender(name: 'Jane', context: Gender.female)}'),
                    Text('• ${t.demo.gender(name: 'Alex', context: Gender.other)}'),
                  ],
                ),
              ),
            ),
            Gap(24.h),
            Text('Lists & Maps', style: Theme.of(context).textTheme.titleLarge),
            Gap(16.h),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('List example (steps):'),
                    ...List.generate(4, (i) => Text('• ${t.demo.steps.titles[i]}')),
                    Gap(16.h),
                    Text('Map example (error types):'),
                    Text('• ${t.demo.errors.types.warning}'),
                    Text('• ${t.demo.errors.types.error}'),
                    Text('• ${t.demo.errors.types.info}'),
                  ],
                ),
              ),
            ),
            Gap(24.h),
            Text('RichText Support', style: Theme.of(context).textTheme.titleLarge),
            Gap(16.h),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      t.demo.rich_welcome(
                        name: TextSpan(
                          text: 'John',
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
