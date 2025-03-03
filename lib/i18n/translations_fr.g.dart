///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'translations.g.dart';

// Path: <root>
class TranslationsFr extends Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsFr({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.fr,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <fr>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsFr _root = this; // ignore: unused_field

	// Translations
	@override late final TranslationsApiFr api = TranslationsApiFr._(_root);
	@override late final TranslationsAuthFr auth = TranslationsAuthFr._(_root);
	@override late final TranslationsCommonFr common = TranslationsCommonFr._(_root);
	@override late final TranslationsDemoFr demo = TranslationsDemoFr._(_root);
}

// Path: api
class TranslationsApiFr extends TranslationsApiEn {
	TranslationsApiFr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get email_already_registered => 'Cette adresse email est déjà enregistrée.';
	@override String get system_error_occurred => 'Une erreur système est survenue, veuillez réessayer plus tard.';
}

// Path: auth
class TranslationsAuthFr extends TranslationsAuthEn {
	TranslationsAuthFr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get login => 'Connexion';
	@override String get logout => 'Déconnexion';
	@override String get register => 'Inscription';
}

// Path: common
class TranslationsCommonFr extends TranslationsCommonEn {
	TranslationsCommonFr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get email => 'Email';
	@override String get language => 'Langue';
	@override String get home => 'Accueil';
	@override String get demo => 'Démo';
}

// Path: demo
class TranslationsDemoFr extends TranslationsDemoEn {
	TranslationsDemoFr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String welcome({required Object name}) => 'Bienvenue ${name} !';
	@override String items({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count,
		zero: 'Aucun élément',
		one: 'Un élément',
		two: 'Deux éléments',
		few: 'Quelques éléments',
		many: 'Beaucoup d\'éléments',
		other: '${count} éléments',
	);
	@override String apples({required num appleCount}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(appleCount,
		zero: 'pas de pommes',
		one: 'une pomme',
		other: '${appleCount} pommes',
	);
	@override String bananas({required num bananaCount}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(bananaCount,
		zero: 'pas de bananes',
		one: 'une banane',
		other: '${bananaCount} bananes',
	);
	@override String fruits({required num appleCount, required num bananaCount}) => 'J\'ai ${_root.demo.apples(appleCount: appleCount)} et ${_root.demo.bananas(bananaCount: bananaCount)}';
	@override String gender({required Gender context, required Object name}) {
		switch (context) {
			case Gender.male:
				return 'C\'est ${name}';
			case Gender.female:
				return 'C\'est ${name}';
			case Gender.other:
				return 'Ce sont ${name}';
		}
	}
	@override TextSpan rich_welcome({required InlineSpan name}) => TextSpan(children: [
		const TextSpan(text: 'Bon retour '),
		name,
		const TextSpan(text: ' !'),
	]);
	@override String last_login({required DateTime date}) => 'Dernière connexion : ${DateFormat.yMd().add_jm().format(date)}';
	@override late final TranslationsDemoStepsFr steps = TranslationsDemoStepsFr._(_root);
	@override late final TranslationsDemoErrorsFr errors = TranslationsDemoErrorsFr._(_root);
}

// Path: demo.steps
class TranslationsDemoStepsFr extends TranslationsDemoStepsEn {
	TranslationsDemoStepsFr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override List<String> get titles => [
		'Bienvenue',
		'Profil',
		'Préférences',
		'Terminé',
	];
}

// Path: demo.errors
class TranslationsDemoErrorsFr extends TranslationsDemoErrorsEn {
	TranslationsDemoErrorsFr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final TranslationsDemoErrorsTypesFr types = TranslationsDemoErrorsTypesFr._(_root);
}

// Path: demo.errors.types
class TranslationsDemoErrorsTypesFr extends TranslationsDemoErrorsTypesEn {
	TranslationsDemoErrorsTypesFr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get warning => 'Avertissement';
	@override String get error => 'Erreur';
	@override String get info => 'Info';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsFr {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'api.email_already_registered': return 'Cette adresse email est déjà enregistrée.';
			case 'api.system_error_occurred': return 'Une erreur système est survenue, veuillez réessayer plus tard.';
			case 'auth.login': return 'Connexion';
			case 'auth.logout': return 'Déconnexion';
			case 'auth.register': return 'Inscription';
			case 'common.email': return 'Email';
			case 'common.language': return 'Langue';
			case 'common.home': return 'Accueil';
			case 'common.demo': return 'Démo';
			case 'demo.welcome': return ({required Object name}) => 'Bienvenue ${name} !';
			case 'demo.items': return ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count,
				zero: 'Aucun élément',
				one: 'Un élément',
				two: 'Deux éléments',
				few: 'Quelques éléments',
				many: 'Beaucoup d\'éléments',
				other: '${count} éléments',
			);
			case 'demo.apples': return ({required num appleCount}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(appleCount,
				zero: 'pas de pommes',
				one: 'une pomme',
				other: '${appleCount} pommes',
			);
			case 'demo.bananas': return ({required num bananaCount}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(bananaCount,
				zero: 'pas de bananes',
				one: 'une banane',
				other: '${bananaCount} bananes',
			);
			case 'demo.fruits': return ({required num appleCount, required num bananaCount}) => 'J\'ai ${_root.demo.apples(appleCount: appleCount)} et ${_root.demo.bananas(bananaCount: bananaCount)}';
			case 'demo.gender': return ({required Gender context, required Object name}) {
				switch (context) {
					case Gender.male:
						return 'C\'est ${name}';
					case Gender.female:
						return 'C\'est ${name}';
					case Gender.other:
						return 'Ce sont ${name}';
				}
			};
			case 'demo.rich_welcome': return ({required InlineSpan name}) => TextSpan(children: [
				const TextSpan(text: 'Bon retour '),
				name,
				const TextSpan(text: ' !'),
			]);
			case 'demo.last_login': return ({required DateTime date}) => 'Dernière connexion : ${DateFormat.yMd().add_jm().format(date)}';
			case 'demo.steps.titles.0': return 'Bienvenue';
			case 'demo.steps.titles.1': return 'Profil';
			case 'demo.steps.titles.2': return 'Préférences';
			case 'demo.steps.titles.3': return 'Terminé';
			case 'demo.errors.types.warning': return 'Avertissement';
			case 'demo.errors.types.error': return 'Erreur';
			case 'demo.errors.types.info': return 'Info';
			default: return null;
		}
	}
}

