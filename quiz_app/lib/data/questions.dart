import 'package:quiz_app/models/quiz_question.dart';

// Note: The first answer is always the correct one
// The model handling the data shuffles the order of the answers before displaying them in the UI
// Modify the int constant in the quiz file to specify how many questions to randomly pull from this set for a quiz

const questions = [
  QuizQuestion(
    'What are the main building blocks of Flutter UIs?',
    [
      'Widgets',
      'Components',
      'Blocks',
      'Functions',
    ],
  ),
  QuizQuestion('How are Flutter UIs built?', [
    'By combining widgets in code',
    'By combining widgets in a visual editor',
    'By defining widgets in config files',
    'By using XCode for iOS and Android Studio for Android',
  ]),
  QuizQuestion(
    'What\'s the purpose of a StatefulWidget?',
    [
      'Update UI as data changes',
      'Update data as UI changes',
      'Ignore data changes',
      'Render UI that does not depend on data',
    ],
  ),
  QuizQuestion(
    'Which widget should you try to use more often: StatelessWidget or StatefulWidget?',
    [
      'StatelessWidget',
      'StatefulWidget',
      'Both are equally good',
      'None of the above',
    ],
  ),
  QuizQuestion(
    'What happens if you change data in a StatelessWidget?',
    [
      'The UI is not updated',
      'The UI is updated',
      'The closest StatefulWidget is updated',
      'Any nested StatefulWidgets are updated',
    ],
  ),
  QuizQuestion(
    'How should you update data inside of StatefulWidgets?',
    [
      'By calling setState()',
      'By calling updateData()',
      'By calling updateUI()',
      'By calling updateState()',
    ],
  ),
  QuizQuestion(
    'Which programming language is used to build Flutter applications?',
    [
      'Dart',
      'Kotlin',
      'Java',
      'Go',
    ]
  ),
  QuizQuestion(
    'How many types of widgets are there in Flutter?',
    [
      '2',
      '4',
      '7',
      'As many as you want',
    ],
  ),
  QuizQuestion(
    'A sequence of asynchronous Flutter events is known as what?',
    [
      'Stream',
      'Flow',
      'Current',
      'Series',
    ],
  ),
  QuizQuestion(
    'Access to a cloud database through Flutter is available through which service?',
    [
      'Firebase',
      'MongoDB',
      'SQLite',
      'MySQL',
    ],
  ),
  QuizQuestion(
    'What are some key advantages of Flutter over alternate frameworks?',
    [
      'All of these are correct',
      'Rapid cross-platform application development and debugging tools',
      'Future-proofed technologies and UI resources',
      'Strong supporting tools for application development and launch',
    ],
  ),
  QuizQuestion(
    'What element is used as an identifier for components when programming in Flutter?',
    [
      'Keys',
      'Widgets',
      'Elements',
      'Serial',
    ],
  ),
  QuizQuestion(
    'What type of test can examine your code as a complete system?',
    [
      'Integration Test',
      'Unit Test',
      'Widget Test',
      'All of these are correct',
    ],
  ),
  QuizQuestion(
    'What command would you use to compile your Flutter app in release mode?',
    [
      'Flutter run --release',
      'Flutter --release',
      'Flutter run \$release',
      'Flutter build --release',
    ],
  ),
  QuizQuestion(
    'Which function will return the widgets attached to the screen as a root of the widget tree to be rendered on screen?', 
    [
      'runApp()',
      'main()',
      'container()',
      'root()',
    ],
  ),
  QuizQuestion(
    'What is the key configuration file used when building a Flutter project?',
    [
      'pubspec.yaml',
      'config.json',
      'root.xml',
      'AndroidManifest.xml',
    ],
  ),
  QuizQuestion(
    'Which component allows us to specify the distance between widgets on the screen?',
    [
      'SizedBox',
      'SafeArea',
      'Padding',
      'AppBar',
    ],
  ),
  QuizQuestion(
    'What command would you run to verify your Flutter install and ensure your environment is set up correctly?',
    [
      'Flutter doctor',
      'Flutter build',
      'Flutter help',
      'Flutter run'
    ],
  ),
  QuizQuestion(
    'Which release mode will not contain any debugging data when run?',
    [
      'Release',
      'Debug',
      'Test',
      'Profile',
    ],
  ),
  QuizQuestion(
    'What language is Flutter\'s rendering engine primarily written in?',
    [
      'C++',
      'Kotlin',
      'Dart',
      'Java',
    ],
  ),
  QuizQuestion(
    'What is a drawback of Flutter that might lead you to choose another solution?',
    [
      'All are correct',
      'Non-native looking application UI',
      'Large application footprint',
      'A relatively unproven framework and language',
    ],
  ),
  QuizQuestion(
    'What type of application development does Flutter support?', 
    [
      'All are correct',
      'Mobile (Android/iOS)',
      'Web',
      'Desktop',
    ],
  ),
  QuizQuestion(
    'What widget would you use for repeating content in Flutter?', 
    [
      'ListView',
      'ExpandedView',
      'Stack',
      'ArrayView',
    ],
  ),
  QuizQuestion(
    'Which State method is called exactly once, when the State object is first inserted into the widget tree?',
    [
      'initState()',
      'build()',
      'didUpdateWidget()',
      'setState()',
    ],
  ),
    QuizQuestion(
    'In which State method should you release resources such as controllers and stream subscriptions?',
    [
      'dispose()',
      'deactivate()',
      'initState()',
      'build()',
    ],
  ),
  QuizQuestion(
    'What type of object does a build() method return?',
    [
      'A Widget',
      'An Element',
      'A RenderObject',
      'A BuildContext',
    ],
  ),
  QuizQuestion(
    'Where does a StatefulWidget keep the data that can change while the app is running?',
    [
      'In its State object',
      'In its BuildContext',
      'In its constructor arguments',
      'In its Key',
    ],
  ),
   QuizQuestion(
    'What does calling setState() cause Flutter to do?',
    [
      'Schedule a new call to build() for that State object',
      'Rebuild every widget in the whole app immediately',
      'Create a brand new State object for the widget',
      'Call initState() again for that State object',
    ],
  ),
   QuizQuestion(
    'What does a BuildContext represent?',
    [
      'The location of a widget in the widget tree',
      'The data currently held by a StatefulWidget',
      'The size and position of a widget on screen',
      'The list of screens the user has opened',
    ],
  ),
  QuizQuestion(
    'What does the mounted property of a State object tell you?',
    [
      'Whether the State is currently in the widget tree',
      'Whether the widget is currently visible on screen',
      'Whether the build() method has finished running',
      'Whether the app is running in the foreground',
    ],
  ),
  QuizQuestion(
    'Why are the fields of a widget class declared as final?',
    [
      'Because widgets are immutable once they have been created',
      'Because widgets are stored on disk between app launches',
      'Because final fields can only be read by the widget itself',
      'Because final fields trigger a rebuild when they change',
    ],
  ),
   QuizQuestion(
    'What is the main benefit of creating a widget with the const keyword?',
    [
      'The widget is created once and reused instead of being rebuilt every time',
      'The widget is allowed to change its own fields after it has been built',
      'The widget is drawn on a background thread to keep the UI smooth',
      'The widget is saved to disk and restored the next time the app starts',
    ],
  ),
  QuizQuestion(
    'How does a child widget usually pass an event or value up to its parent?',
    [
      'By calling a callback function that the parent passed to it',
      'By calling setState() directly on the parent widget',
      'By changing one of the final fields of the parent',
      'By returning the value from its build() method',
    ],
  ),
  QuizQuestion(
    'Which class is designed to efficiently pass data down the tree to any descendant that needs it?',
    [
      'InheritedWidget',
      'GlobalKey',
      'Builder',
      'Container',
    ],
  ),
   QuizQuestion(
    'Which method does a ChangeNotifier call to tell its listeners that its data has changed?',
    [
      'notifyListeners()',
      'setState()',
      'addListener()',
      'markNeedsBuild()',
    ],
  ),
  QuizQuestion(
    'In which situation is giving widgets a Key most useful?',
    [
      'When a list of stateful widgets of the same type is reordered',
      'When a widget should rebuild more often than its parent does',
      'When a widget is the only child of its parent widget',
      'When a widget is created with a const constructor',
    ],
  ),
   QuizQuestion(
    'In a Column, what does crossAxisAlignment control?',
    [
      'How the children are positioned horizontally',
      'How the children are positioned vertically',
      'The order in which the children are drawn',
      'How much free space each child takes up',
    ],
  ),
  QuizQuestion(
    'In a Row, which property controls how the children are spaced along the horizontal axis?',
    [
      'mainAxisAlignment',
      'crossAxisAlignment',
      'mainAxisSize',
      'verticalDirection',
    ],
  ),
  QuizQuestion(
    'Which widget lets its children overlap, layering them on top of each other?',
    [
      'Stack',
      'Column',
      'Wrap',
      'Row',
    ],
  ),
  QuizQuestion(
    'Which widget makes a child of a Row or Column fill the remaining free space?',
    [
      'Expanded',
      'Center',
      'Padding',
      'Align',
    ],
  ),
  QuizQuestion(
    'Which widget automatically keeps its child clear of notches, status bars and other system intrusions?',
    [
      'SafeArea',
      'Padding',
      'Align',
      'Expanded',
    ],
  ),
  QuizQuestion(
    'Which widget provides the basic Material page layout, with slots such as appBar, body and floatingActionButton?',
    [
      'Scaffold',
      'MaterialApp',
      'Container',
      'AppBar',
    ],
  ),
    QuizQuestion(
    'Which option is best suited to a very long list, because it only creates items as they scroll into view?',
    [
      'ListView.builder',
      'ListView with a children list',
      'Column',
      'SingleChildScrollView wrapping a Column',
    ],
  ),
  QuizQuestion(
    'During layout, what does a parent widget pass down to its children?',
    [
      'Constraints',
      'Sizes',
      'Colors',
      'Keys',
    ],
  ),
   QuizQuestion(
    'In debug mode, what does Flutter show when the children of a Row do not fit in the available width?',
    [
      'A yellow and black striped overflow warning',
      'A red screen with the details of the exception',
      'A horizontal scrollbar underneath the Row',
      'An extra line that holds the remaining children',
    ],
  ),
   QuizQuestion(
    'Which data structure best describes how Navigator manages screens?',
    [
      'A stack',
      'A queue',
      'A tree',
      'A set',
    ],
  ),
   QuizQuestion(
    'Which call closes the current screen and returns to the previous one?',
    [
      'Navigator.pop()',
      'Navigator.push()',
      'Navigator.back()',
      'Navigator.close()',
    ],
  ),
   QuizQuestion(
    'How can a screen send a result back to the screen that opened it?',
    [
      'By passing the value to Navigator.pop()',
      'By passing the value to Navigator.push()',
      'By saving the value in the BuildContext',
      'By returning the value from build()',
    ],
  ),
  QuizQuestion(
    'Which widget usually sits at the root of a Material Design app and sets up its theme and navigation?',
    [
      'MaterialApp',
      'Scaffold',
      'Material',
      'Theme',
    ],
  ),
  QuizQuestion(
    'What does Theme.of(context) return?',
    [
      'The ThemeData of the closest Theme that wraps the widget',
      'A brand new ThemeData with the default Flutter colors',
      'The light or dark mode setting of the operating system',
      'The TextStyle used by the closest Text widget',
    ],
  ),
   QuizQuestion(
    'Which class gives you information about the device screen, such as its size and orientation?',
    [
      'MediaQuery',
      'LayoutBuilder',
      'Theme',
      'Scaffold',
    ],
  ),
   QuizQuestion(
    'What does the final keyword mean for a Dart variable?',
    [
      'It can only be assigned once',
      'Its value must be known at compile time',
      'It can only be used inside its own class',
      'It can hold either a value or null',
    ],
  ),
  QuizQuestion(
    'Which keyword declares a compile-time constant in Dart?',
    [
      'const',
      'final',
      'static',
      'late',
    ],
  ),
  QuizQuestion(
    'How do you make a class member private to its library in Dart?',
    [
      'Start its name with an underscore',
      'Mark it with the private keyword',
      'Add the @private annotation to it',
      'Declare it inside a private block',
    ],
  ),
   QuizQuestion(
    'What does the type String? mean in Dart?',
    [
      'The variable can hold a String or null',
      'The variable type is decided at runtime',
      'The variable can be left out when calling a function',
      'The variable will be given a String later',
    ],
  ),
  QuizQuestion(
    'What does the expression a ?? b evaluate to?',
    [
      'a if a is not null, otherwise b',
      'b if a is not null, otherwise a',
      'true if both a and b are null',
      'null if either a or b is null',
    ],
  ),
  QuizQuestion(
    'What is the result of the expression user?.name when user is null?',
    [
      'null',
      'false',
      'An empty String',
      'A thrown exception',
    ],
  ),
  QuizQuestion(
    'In Dart, what does the ! do in the expression user!.name?',
    [
      'Asserts that user is not null',
      'Checks that user is equal to false',
      'Skips the access when user is null',
      'Declares user as a nullable variable',
    ],
  ),
    QuizQuestion(
    'What does the late modifier allow for a non-nullable variable?',
    [
      'Initializing it later instead of at its declaration',
      'Holding null until a value has been assigned to it',
      'Changing its type after it has been declared',
      'Reading it from more than one isolate at once',
    ],
  ),
  QuizQuestion(
    'Which kind of parameters are declared inside curly braces in a Dart function or constructor?',
    [
      'Named parameters',
      'Optional positional parameters',
      'Generic type parameters',
      'Private parameters',
    ],
  ),
   QuizQuestion(
    'What does marking a named parameter as required do?',
    [
      'Callers must provide a value for it',
      'Its value can never be null',
      'It can no longer be passed by name',
      'It is given a default value automatically',
    ],
  ),
   QuizQuestion(
    'What does the spread operator (...) do inside a list literal?',
    [
      'Inserts all the elements of another collection into the list',
      'Repeats the previous element until the list is full',
      'Marks the remaining elements of the list as optional',
      'Copies the list to a background isolate',
    ],
  ),
  QuizQuestion(
    'What does an if inside a list literal do, as in [a, if (show) b]?',
    [
      'Adds the element only when the condition is true',
      'Adds null in place of the element when the condition is false',
      'Stops building the list when the condition is false',
      'Throws an error when the condition is false',
    ],
  ),
  QuizQuestion(
    'What does the cascade operator (..) let you do?',
    [
      'Make several calls on the same object in a row',
      'Join two lists together into a single new list',
      'Create a range of numbers between two values',
      'Access a member only if the object is not null',
    ],
  ),
  QuizQuestion(
    'What does calling shuffle() on a List do?',
    [
      'Randomly reorders the elements of that same list',
      'Returns a shuffled copy and leaves the original unchanged',
      'Sorts the elements of the list in ascending order',
      'Removes one random element from the list',
    ],
  ),
  QuizQuestion(
    'What does calling map() on a List return?',
    [
      'A lazy Iterable of the transformed elements',
      'A new List of the transformed elements',
      'A Map with the list indexes as keys',
      'Nothing, it changes the list in place',
    ],
  ),
   QuizQuestion(
    'Which syntax inserts the value of a variable called name into a Dart string?',
    [
      '\$name',
      '{name}',
      '%name',
      '#{name}',
    ],
  ),
  QuizQuestion(
    'Which keyword applies a mixin to a class in Dart?',
    [
      'with',
      'extends',
      'implements',
      'using',
    ],
  ),
  QuizQuestion(
    'Which Dart type represents a single value that will be available at some later time?',
    [
      'Future',
      'Stream',
      'Promise',
      'Task',
    ],
  ),
   QuizQuestion(
    'Which keyword pauses an async function until a Future completes?',
    [
      'await',
      'async',
      'yield',
      'then',
    ],
  ),
  QuizQuestion(
    'What does a Dart function marked async* return?',
    [
      'A Stream',
      'A Future',
      'An Iterable',
      'A List',
    ],
  ),
  QuizQuestion(
    'Which widget rebuilds its UI based on the latest result of a Future?',
    [
      'FutureBuilder',
      'StreamBuilder',
      'LayoutBuilder',
      'Builder',
    ],
  ),
   QuizQuestion(
    'What does Dart use to run code in parallel without sharing memory?',
    [
      'Isolates',
      'Goroutines',
      'Coroutines',
      'Fibers',
    ],
  ),
   QuizQuestion(
    'What does hot reload do?',
    [
      'Injects updated code into the running app and keeps its state',
      'Restarts the app from scratch and resets its state',
      'Rebuilds the app in release mode and reinstalls it',
      'Deletes the build folder and downloads all packages again',
    ],
  ),
  QuizQuestion(
    'Which command downloads the packages listed in pubspec.yaml?',
    [
      'flutter pub get',
      'flutter pub install',
      'flutter pub fetch',
      'flutter pub download',
    ],
  ),
   QuizQuestion(
    'Which command creates a new Flutter project?',
    [
      'flutter create',
      'flutter new',
      'flutter init',
      'flutter start',
    ],
  ),
  QuizQuestion(
    'Which command checks your code for errors, warnings and lint issues without running the app?',
    [
      'flutter analyze',
      'flutter doctor',
      'flutter clean',
      'flutter test',
    ],
  ),
   QuizQuestion(
    'Which file is the default entry point of a Flutter app?',
    [
      'lib/main.dart',
      'lib/app.dart',
      'src/index.dart',
      'bin/start.dart',
    ],
  ),
  QuizQuestion(
    'What is the official package repository for Dart and Flutter?',
    [
      'pub.dev',
      'npmjs.com',
      'crates.io',
      'Maven Central',
    ],
  ),
   QuizQuestion(
    'What is the purpose of the pubspec.lock file?',
    [
      'It records the exact package versions resolved for the project',
      'It stops other developers from editing pubspec.yaml',
      'It stores the API keys and passwords used by the app',
      'It lists the devices the app is allowed to run on',
    ],
  ),
  QuizQuestion(
    'In which section of pubspec.yaml do you list packages that are only needed for development and testing?',
    [
      'dev_dependencies',
      'dependencies',
      'dependency_overrides',
      'environment',
    ],
  ),
   QuizQuestion(
    'Where do you declare image files so that Flutter bundles them with the app?',
    [
      'In the assets section of pubspec.yaml',
      'In the main() function of main.dart',
      'In AndroidManifest.xml and Info.plist',
      'Nowhere, every file in the project is bundled automatically',
    ],
  ),
  QuizQuestion(
    'How is Dart code compiled for a release build of a mobile app?',
    [
      'Ahead of time, into native machine code',
      'Just in time, while the app is running',
      'Into JavaScript that runs inside a WebView',
      'Into Java bytecode that runs on the JVM',
    ],
  ),
  QuizQuestion(
    'Which widget can you wrap around another widget to detect taps and other gestures?',
    [
      'GestureDetector',
      'IgnorePointer',
      'Opacity',
      'Padding',
    ],
  ),
  QuizQuestion(
    'Which class lets you read and change the text inside a TextField?',
    [
      'TextEditingController',
      'FocusNode',
      'InputDecoration',
      'TextStyle',
    ],
  ),
   QuizQuestion(
    'How do you disable an ElevatedButton?',
    [
      'Set its onPressed callback to null',
      'Set its enabled property to false',
      'Wrap it in a DisabledButton widget',
      'Remove its child widget',
    ],
  ),
  QuizQuestion(
    'Which constructor displays an image loaded from a URL?',
    [
      'Image.network',
      'Image.asset',
      'Image.file',
      'Image.memory',
    ],
  ),
  QuizQuestion(
    'Which widget groups several input fields so that they can be validated together?',
    [
      'Form',
      'TextField',
      'Column',
      'FocusScope',
    ],
  ),
  QuizQuestion(
    'What should the validator of a TextFormField return when the input is valid?',
    [
      'null',
      'true',
      'An empty String',
      'The text that was entered',
    ],
  ),
   QuizQuestion(
    'What do you call showSnackBar() on in order to display a SnackBar?',
    [
      'ScaffoldMessenger.of(context)',
      'Navigator.of(context)',
      'Theme.of(context)',
      'MediaQuery.of(context)',
    ],
  ),
   QuizQuestion(
    'Which widget automatically animates changes to properties such as its width, color and padding?',
    [
      'AnimatedContainer',
      'AnimatedBuilder',
      'Container',
      'Transform',
    ],
  ),
  QuizQuestion(
    'Which class controls an explicit animation, letting you start, stop and reverse it?',
    [
      'AnimationController',
      'Tween',
      'CurvedAnimation',
      'AnimatedBuilder',
    ],
  ),
  QuizQuestion(
    'Which widget animates a shared element flying from one screen to the next during navigation?',
    [
      'Hero',
      'AnimatedSwitcher',
      'PageView',
      'Transform',
    ],
  ),
   QuizQuestion(
    'Which three trees does Flutter maintain to render the UI?',
    [
      'Widget, Element and RenderObject trees',
      'Widget, State and Layout trees',
      'Component, DOM and Render trees',
      'Model, View and Controller trees',
    ],
  ),
   QuizQuestion(
    'How does Flutter draw its widgets on screen?',
    [
      'With its own rendering engine, which paints every pixel',
      'With the native UI components of each platform',
      'With a hidden WebView that displays HTML and CSS',
      'With XML layout files compiled for each platform',
    ],
  ),
  QuizQuestion(
    'What is the name of the mechanism Flutter uses to call platform-specific code written in Kotlin or Swift?',
    [
      'Platform channels',
      'Isolates',
      'WebViews',
      'Build flavors',
    ],
  ),
  QuizQuestion(
    'Which function from flutter_test defines a widget test?',
    [
      'testWidgets()',
      'test()',
      'widgetTest()',
      'runApp()',
    ],
  ),
   QuizQuestion(
    'In a widget test, which call builds and renders a widget so you can interact with it?',
    [
      'tester.pumpWidget()',
      'tester.render()',
      'tester.build()',
      'tester.runApp()',
    ],
  ),
  QuizQuestion(
    'Which command runs the unit and widget tests in a Flutter project?',
    [
      'flutter test',
      'flutter analyze',
      'flutter check',
      'flutter run --test',
    ],
  ),
  QuizQuestion(
    'What do packages such as Provider, Riverpod and Bloc primarily help with?',
    [
      'Managing and sharing app state across widgets',
      'Sending HTTP requests to a backend server',
      'Saving data to a local on-device database',
      'Running automated tests on physical devices',
    ],
  ),
];
