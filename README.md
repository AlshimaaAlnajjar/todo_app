# Tudee

A simple to-do mobile app built with **Flutter**, based on a Figma design.
Enter your name once, then add tasks, edit them, and mark them as done.

## Features

- **Welcome screen**: enter your name once. The app remembers it and opens straight to Home next time.
- **Home screen**: a welcome card with **Done** and **To Do** counters, and the list of tasks.
- **Add task**: tap the `+` button and write a new task.
- **Edit task**: tap a task card to change its title.
- **Change status**: tap the small label on a task card to switch between `TODO` (purple) and `Done` (green). The counters update automatically.
- **Saved on the device**: tasks are still there after closing the app.

## Tech Stack

| Package | Used for |
| [Flutter](https://flutter.dev) | Building the UI |
| [shared_preferences](https://pub.dev/packages/shared_preferences) | Saving the user name |
| [hive](https://pub.dev/packages/hive) / [hive_flutter](https://pub.dev/packages/hive_flutter) | Saving the tasks |

## Project Structure

```
lib/
├── main.dart                  # App start, opens Welcome or Home
├── database/
│   └── hive_service.dart      # All Hive code (getTasks, addTask, editTitle, toggleDone, ...)
├── screens/
│   ├── welcome.dart           # Enter your name
│   ├── home.dart              # Counters and tasks list
│   ├── add_task.dart          # Add a new task
│   └── edit_task.dart         # Edit a task title
└── widgets/
    ├── custom_app_bar.dart    # Blue app bar
    └── custom_form.dart       # Reusable form used by the screens
```

## How It Works

- The user name is saved with **SharedPreferences**. If a name exists, the app opens **Home**, otherwise it opens **Welcome**.
- Every task is saved in **Hive** as a small map: `{ title, done }`.
- All Hive code lives in `hive_service.dart`, so the screens only call simple functions:
    ```
    HiveService.getTasks();            // get all tasks
    HiveService.addTask('Study');      // add a task
    HiveService.editTitle(0, 'New');   // change the title of task 0
    HiveService.toggleDone(0);         // TODO <-> Done
    HiveService.deleteTask(0);         // delete a task
    HiveService.doneCount();           // number of done tasks
    ```

## Getting Started

1. Make sure Flutter is installed: [Install Flutter](https://docs.flutter.dev/get-started/install)
2. Clone the project:
   ```
   git clone <your-repo-link>
   cd tudee
   ```
3. Install the packages:
   ```
   flutter pub get
   ```
4. Run the app:
   ```
   flutter run
   ```

## Design

The screens follow a Figma design: Welcome, Home (empty and with tasks), Add Task, and Edit Task.

## Author

**Alshimaa Alnajjar**, Full-Stack Developer