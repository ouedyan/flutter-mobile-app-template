T? tryOr<T>(T Function() fn, {T? Function(dynamic e)? orElse}) {
  try {
    return fn();
  } catch (e) {
    return orElse != null ? orElse(e) : null;
  }
}
