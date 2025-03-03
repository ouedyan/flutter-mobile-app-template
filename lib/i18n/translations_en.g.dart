///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

part of 'translations.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	// Translations
	late final TranslationsApiEn api = TranslationsApiEn.internal(_root);
	late final TranslationsAuthEn auth = TranslationsAuthEn.internal(_root);
	late final TranslationsCommonEn common = TranslationsCommonEn.internal(_root);
	late final TranslationsDemoEn demo = TranslationsDemoEn.internal(_root);
}

// Path: api
class TranslationsApiEn {
	TranslationsApiEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get email_already_registered => 'This email is already registered.';
	String get system_error_occurred => 'A system error occurred, please try again later.';
}

// Path: auth
class TranslationsAuthEn {
	TranslationsAuthEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get login => 'Login';
	String get logout => 'Logout';
	String get register => 'Register';
}

// Path: common
class TranslationsCommonEn {
	TranslationsCommonEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get email => 'Email';
	String get language => 'Language';
	String get home => 'Home';
	String get demo => 'Demo';
}

// Path: demo
class TranslationsDemoEn {
	TranslationsDemoEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String welcome({required Object name}) => 'Welcome ${name}!';
	String items({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count,
		zero: 'No items',
		one: 'One item',
		two: 'Two items',
		few: 'A few items',
		many: 'Many items',
		other: '${count} items',
	);
	String apples({required num appleCount}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(appleCount,
		zero: 'no apples',
		one: 'one apple',
		other: '${appleCount} apples',
	);
	String bananas({required num bananaCount}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(bananaCount,
		zero: 'no bananas',
		one: 'one banana',
		other: '${bananaCount} bananas',
	);
	String fruits({required num appleCount, required num bananaCount}) => 'I have ${_root.demo.apples(appleCount: appleCount)} and ${_root.demo.bananas(bananaCount: bananaCount)}';
	String gender({required Gender context, required Object name}) {
		switch (context) {
			case Gender.male:
				return 'He is ${name}';
			case Gender.female:
				return 'She is ${name}';
			case Gender.other:
				return 'They are ${name}';
		}
	}
	TextSpan rich_welcome({required InlineSpan name}) => TextSpan(children: [
		const TextSpan(text: 'Welcome back '),
		name,
		const TextSpan(text: '!'),
	]);
	String last_login({required DateTime date}) => 'Last login: ${DateFormat.yMd().add_jm().format(date)}';
	late final TranslationsDemoStepsEn steps = TranslationsDemoStepsEn.internal(_root);
	late final TranslationsDemoErrorsEn errors = TranslationsDemoErrorsEn.internal(_root);
}

// Path: demo.steps
class TranslationsDemoStepsEn {
	TranslationsDemoStepsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	List<String> get titles => [
		'Welcome',
		'Profile',
		'Preferences',
		'Done',
	];
}

// Path: demo.errors
class TranslationsDemoErrorsEn {
	TranslationsDemoErrorsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsDemoErrorsTypesEn types = TranslationsDemoErrorsTypesEn.internal(_root);
}

// Path: demo.errors.types
class TranslationsDemoErrorsTypesEn {
	TranslationsDemoErrorsTypesEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get warning => 'Warning';
	String get error => 'Error';
	String get info => 'Info';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'api.email_already_registered': return 'This email is already registered.';
			case 'api.system_error_occurred': return 'A system error occurred, please try again later.';
			case 'auth.login': return 'Login';
			case 'auth.logout': return 'Logout';
			case 'auth.register': return 'Register';
			case 'common.email': return 'Email';
			case 'common.language': return 'Language';
			case 'common.home': return 'Home';
			case 'common.demo': return 'Demo';
			case 'demo.welcome': return ({required Object name}) => 'Welcome ${name}!';
			case 'demo.items': return ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count,
				zero: 'No items',
				one: 'One item',
				two: 'Two items',
				few: 'A few items',
				many: 'Many items',
				other: '${count} items',
			);
			case 'demo.apples': return ({required num appleCount}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(appleCount,
				zero: 'no apples',
				one: 'one apple',
				other: '${appleCount} apples',
			);
			case 'demo.bananas': return ({required num bananaCount}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(bananaCount,
				zero: 'no bananas',
				one: 'one banana',
				other: '${bananaCount} bananas',
			);
			case 'demo.fruits': return ({required num appleCount, required num bananaCount}) => 'I have ${_root.demo.apples(appleCount: appleCount)} and ${_root.demo.bananas(bananaCount: bananaCount)}';
			case 'demo.gender': return ({required Gender context, required Object name}) {
				switch (context) {
					case Gender.male:
						return 'He is ${name}';
					case Gender.female:
						return 'She is ${name}';
					case Gender.other:
						return 'They are ${name}';
				}
			};
			case 'demo.rich_welcome': return ({required InlineSpan name}) => TextSpan(children: [
				const TextSpan(text: 'Welcome back '),
				name,
				const TextSpan(text: '!'),
			]);
			case 'demo.last_login': return ({required DateTime date}) => 'Last login: ${DateFormat.yMd().add_jm().format(date)}';
			case 'demo.steps.titles.0': return 'Welcome';
			case 'demo.steps.titles.1': return 'Profile';
			case 'demo.steps.titles.2': return 'Preferences';
			case 'demo.steps.titles.3': return 'Done';
			case 'demo.errors.types.warning': return 'Warning';
			case 'demo.errors.types.error': return 'Error';
			case 'demo.errors.types.info': return 'Info';
			default: return null;
		}
	}
}

