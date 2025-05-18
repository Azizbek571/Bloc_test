import 'package:bloc_projects/bloc/counter_bloc.dart';
import 'package:bloc_projects/bloc/counter_event.dart';
import 'package:bloc_projects/bloc/counter_state.dart';
import 'package:bloc_projects/visibility_bloc/visibility_bloc.dart';
import 'package:bloc_projects/visibility_bloc/visibility_event.dart';
import 'package:bloc_projects/visibility_bloc/visibility_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: BlocProvider<CounterBloc>(
        create: (BuildContext context) => CounterBloc(),
        child: BlocProvider<VisibilityBloc>(
          create: (BuildContext context) => VisibilityBloc(),
          child: MyHomePage(title: 'Flutter demo'),
        ),
      ),
      //  MultiBlocProvider(
      //   providers: [
      //     BlocProvider(create: (context) => CounterBloc()),
      //     BlocProvider(create: (context) => VisibilityBloc()),
      //   ],
      //   child: const MyHomePage(title: 'Flutter Demo Home Page'),
      // ),
    );

    //   home: BlocProvider.value(
    //    value: context.read<BlocA>(),
    //     child: const MyHomePage(title: 'Flutter Demo Home Page'),
    //   ),
    // );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            BlocConsumer<CounterBloc, CounterState>(
            
               listener: (context, state) {
                if (state.count == 3) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Counter value is ${state.count}")),
                  );
                }
              },

            

              builder: (context, state) {
                return Text(
                  state.count.toString(),
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
            BlocBuilder<VisibilityBloc, VisibilityState>(
              builder: (context, state) {
                return Visibility(
                  visible: state.show,
                  child: Container(
                    color: Colors.purple,
                    width: 200,
                    height: 200,
                  ),
                );
              },
            ),
            BlocListener<CounterBloc, CounterState>(
              listenWhen: (prevState,currentState)=>true,
              listener: (context, state) {
                if (state.count == 3) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Counter value is ${state.count}")),
                  );
                }
              },
              child: Text("Bloc listener"),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: () {
              context.read<CounterBloc>().add(CounterIncrementEvent());
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),

          FloatingActionButton(
            onPressed: () {
              context.read<CounterBloc>().add(CounterDecrementEvent());
            },
            tooltip: 'Decrement',
            child: const Icon(Icons.minimize),
          ),
          FloatingActionButton(
            onPressed: () {
              context.read<VisibilityBloc>().add(VisibilityShowEvent());
            },
            child: Text("Show"),
          ),
          FloatingActionButton(
            onPressed: () {
              context.read<VisibilityBloc>().add(VisibilityHideEvent());
            },
            child: Text("Hide"),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
