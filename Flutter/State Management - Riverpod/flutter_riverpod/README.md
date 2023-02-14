# Flutter & Riverpod

[**Great Reference HERE**](https://developermemos.com/posts/different-providers-riverpod)

Flutter has several state management solutions - Provider, Bloc, and Riverpod. This is a note on how to use Riverpod.

---
<br>

## **1. Setting Up**

To start setting up Riverpod is very simple. First, add the `flutter_riverpod` dependency.

```
dart pub add flutter_riverpod
```

To use Riverpod, you need to wrap your app with `ProviderScope` widget.

```dart
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderScope(
      child: MaterialApp(
        //...
      ),
    );
  }
}
```

---
<br>

## **2. Type of Providers**

Riverpod comes with several Provider types:

- `Provider` - Simpliest type provider. The state cannot be changed outside (but can be changed from inside the provider though)


- `StateProvider` - The state can be changed from outside. 

- `StateNotifierProvider` - Returns a subclass of `StateNotifier` object that contains the state. Since you will write the logic to manipulate the state in the `StateNotifier`, business logic is separated from the UI. This is suitable for more complex state.

- `ChangeNotifierProvider` - Returns a subclass of `ChangeNotifier` object that is also the state and contains the logic to manipulate the state. The logic inside the `ChangeNotifier` has to invoke `notifyListeners()` manually.

- `FutureProvider` - Returns a `Future` object. Usually used for async operations such as API calls.

- `StreamProvider` - Returns a `Stream` object. Similar to `FutureProvider` but it doesn't execute once and end - it is continuous. Good for use cases like chat app.


## **3. `Provider`**

Start by creating a `Provider` that returns the state object. In this example, the state is simply a `String`.

```dart
final provider = Provider<String>((ref) {
  return "AdmiJW";
});
```

You need the `ref` (`WidgetRef`) object in order to access all the providers from the riverpod. To get the `ref` object, you have to use `ConsumerWidget` for stateless widgets, and `ConsumerStatefulWidget` + `ConsumerState` for stateful widgets. 

```dart
class MyWidget extends ConsumerWidget {
  const MyWidget({super.key});

  // ConsumerWidget's build() method has additionally a ref parameter.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(provider);
    return Text(state);
  }
}



class MyStatefulWidget extends ConsumerStatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  ConsumerState<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

// Different from ConsumerWidget, ref object is an property of ConsumerState class.
class _MyStatefulWidgetState extends ConsumerState<MyStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(provider);
    return Text(state);
  }
}
```

- Use `ref.watch()` to get the state from the provider. If the state changes, the widget will rebuild. Best used inside widget's `build()` method.

- Use `ref.read()` to get the state from the provider without listening to the state changes and rebuilding. It is commonly used inside functions triggered by user interactions like `onTap`, `onChanged`, etc. Only `ref.read()` should also be used inside lifecycle methods like `initState()`.

- Use `ref.listen()` to get the state and listen to the state changes. Instead of rebuilding, it will execute the callback function when the state changes. That can be useful for performing actions when a certain change happens, such as showing a snackbar when an error happens (without rebuilding). The `ref.listen()` method can be used inside the body of a provider to listen to the state changes of another provider!

---
<br>



## **4. `StateProvider`**

Start by creating a `StateProvider` that returns the state object. In this example, the state is simply a `int`.

```dart
final stateProvider = StateProvider<int>((ref) {
  return 0;
});
```

To change the state, you can use `ref.read()` to get the state's notifier and change it.

```dart
// We are reading provider.notifier, and manipulating the state from the notifier.
ref.read(stateProvider.notifier).state = count + 1;
```

or if you need to access the previous state:

```dart
ref.read(stateProvider.notifier).update((state) => state + 1);
```

To reset the state back to initial value, use:

```dart
// Return value is void
ref.invalidate(stateProvider);
// Or if you need it to return the resetted state
ref.refresh(stateProvider);
```


---
<br>



## **5. `StateNotifierProvider`**

`StateProvider` works well for simple state, but you can see that we are updating the state directly from the widget. This is not ideal as state manipulation logic should be separated from the UI.

In `StateNotifierProvider`, you can create a `StateNotifier<T>` class that contains the state of type `T` and encapsulate logic to manipulate the state. 

Start by creating the `StateNotifier` subclass. In this example, the state is simply a `String`.

```dart
class BmiStatusState extends StateNotifier<String> {
  BmiStatusState() : super('Keep Going');

  void updateBmiStatus(double bmi) {
    if (bmi >= 25) {
      state = 'You are overweight';
    } else if (bmi >= 18.5) {
      state = 'You are normal';
    } else {
      state = 'You are underweight';
    }
  }
}
```

As usual, create the `StateNotifierProvider` that returns the `StateNotifier` object.

```dart
final counterStatusProvider = StateNotifierProvider<BmiStatusState, String>((ref) {
  return BmiStatusState();
});
```

Now, you can manipulate using the logic you wrote in the `StateNotifier` class.

```dart
ref.read(counterStatusProvider.notifier).updateBmiStatus(20.0);
```