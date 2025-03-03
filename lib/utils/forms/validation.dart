import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:reactive_forms/reactive_forms.dart';

typedef FormBuilderValidatorDelegateError<T> = ({BaseValidator<T> validator, T? value});

Validator delegateToFormBuilderValidator<T>(BaseValidator<T> validator, String validationName) {
  return Validators.delegate((control) {
    return validator.validate(control.value) != null
        ? {validationName: (validator: validator, value: control.value)}
        : null;
  });
}

extension FormBuilderValidatorDelegateErrorX<T> on FormBuilderValidatorDelegateError<T> {
  String get localizedErrorMessage => validator.validate(value) ?? '';
}
