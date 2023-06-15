// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorTaskDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$TaskDatabaseBuilder databaseBuilder(String name) =>
      _$TaskDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$TaskDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$TaskDatabaseBuilder(null);
}

class _$TaskDatabaseBuilder {
  _$TaskDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$TaskDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$TaskDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<TaskDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$TaskDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$TaskDatabase extends TaskDatabase {
  _$TaskDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  TaskDao? _taskDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Task` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT NOT NULL, `description` TEXT NOT NULL, `priority` INTEGER NOT NULL, `tags` TEXT NOT NULL, `status` TEXT NOT NULL, `due_date_time` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  TaskDao get taskDao {
    return _taskDaoInstance ??= _$TaskDao(database, changeListener);
  }
}

class _$TaskDao extends TaskDao {
  _$TaskDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _taskInsertionAdapter = InsertionAdapter(
            database,
            'Task',
            (Task item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description,
                  'priority': item.priority,
                  'tags': item.tags,
                  'status': item.status,
                  'due_date_time': _dateTimeConverter.encode(item.dueDateTime)
                }),
        _taskUpdateAdapter = UpdateAdapter(
            database,
            'Task',
            ['id'],
            (Task item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description,
                  'priority': item.priority,
                  'tags': item.tags,
                  'status': item.status,
                  'due_date_time': _dateTimeConverter.encode(item.dueDateTime)
                }),
        _taskDeletionAdapter = DeletionAdapter(
            database,
            'Task',
            ['id'],
            (Task item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description,
                  'priority': item.priority,
                  'tags': item.tags,
                  'status': item.status,
                  'due_date_time': _dateTimeConverter.encode(item.dueDateTime)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Task> _taskInsertionAdapter;

  final UpdateAdapter<Task> _taskUpdateAdapter;

  final DeletionAdapter<Task> _taskDeletionAdapter;

  @override
  Future<List<Task>> getTasksInChronologicalOrder() async {
    return _queryAdapter.queryList('SELECT * FROM Task ORDER BY due_date_time',
        mapper: (Map<String, Object?> row) => Task(
            id: row['id'] as int?,
            title: row['title'] as String,
            description: row['description'] as String,
            priority: row['priority'] as int,
            dueDateTime: _dateTimeConverter.decode(row['due_date_time'] as int),
            tags: row['tags'] as String,
            status: row['status'] as String));
  }

  @override
  Future<List<Task>> getTasksLowInPriorityOrder() async {
    return _queryAdapter.queryList('SELECT * FROM Task ORDER BY priority',
        mapper: (Map<String, Object?> row) => Task(
            id: row['id'] as int?,
            title: row['title'] as String,
            description: row['description'] as String,
            priority: row['priority'] as int,
            dueDateTime: _dateTimeConverter.decode(row['due_date_time'] as int),
            tags: row['tags'] as String,
            status: row['status'] as String));
  }

  @override
  Future<List<Task>> getOngoingTasks(DateTime now) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Event WHERE due_date_time > ?1',
        mapper: (Map<String, Object?> row) => Task(
            id: row['id'] as int?,
            title: row['title'] as String,
            description: row['description'] as String,
            priority: row['priority'] as int,
            dueDateTime: _dateTimeConverter.decode(row['due_date_time'] as int),
            tags: row['tags'] as String,
            status: row['status'] as String),
        arguments: [_dateTimeConverter.encode(now)]);
  }

  @override
  Future<List<Task>> getTasksInHighPriorityOrder() async {
    return _queryAdapter.queryList('SELECT * FROM Task ORDER BY priority DESC',
        mapper: (Map<String, Object?> row) => Task(
            id: row['id'] as int?,
            title: row['title'] as String,
            description: row['description'] as String,
            priority: row['priority'] as int,
            dueDateTime: _dateTimeConverter.decode(row['due_date_time'] as int),
            tags: row['tags'] as String,
            status: row['status'] as String));
  }

  @override
  Future<List<Task>> getTasksByTag(String tag) async {
    return _queryAdapter.queryList('SELECT * FROM Task WHERE tags LIKE ?1',
        mapper: (Map<String, Object?> row) => Task(
            id: row['id'] as int?,
            title: row['title'] as String,
            description: row['description'] as String,
            priority: row['priority'] as int,
            dueDateTime: _dateTimeConverter.decode(row['due_date_time'] as int),
            tags: row['tags'] as String,
            status: row['status'] as String),
        arguments: [tag]);
  }

  @override
  Future<List<Task>> getTasksByStatus(String status) async {
    return _queryAdapter.queryList('SELECT * FROM Task WHERE status LIKE ?1',
        mapper: (Map<String, Object?> row) => Task(
            id: row['id'] as int?,
            title: row['title'] as String,
            description: row['description'] as String,
            priority: row['priority'] as int,
            dueDateTime: _dateTimeConverter.decode(row['due_date_time'] as int),
            tags: row['tags'] as String,
            status: row['status'] as String),
        arguments: [status]);
  }

  @override
  Future<List<Task>> getTodayTasks() async {
    return _queryAdapter.queryList(
        'SELECT * FROM Task WHERE due_date_time = DATE(\"now\")',
        mapper: (Map<String, Object?> row) => Task(
            id: row['id'] as int?,
            title: row['title'] as String,
            description: row['description'] as String,
            priority: row['priority'] as int,
            dueDateTime: _dateTimeConverter.decode(row['due_date_time'] as int),
            tags: row['tags'] as String,
            status: row['status'] as String));
  }

  @override
  Future<List<Task>> getThisWeekTasks() async {
    return _queryAdapter.queryList(
        'SELECT * FROM Task WHERE due_date_time >= DATE(\"now\", \"weekday 0\", \"-6 days\") AND due_date_time <= DATE(\"now\", \"weekday 0\")',
        mapper: (Map<String, Object?> row) => Task(
            id: row['id'] as int?,
            title: row['title'] as String,
            description: row['description'] as String,
            priority: row['priority'] as int,
            dueDateTime: _dateTimeConverter.decode(row['due_date_time'] as int),
            tags: row['tags'] as String,
            status: row['status'] as String));
  }

  @override
  Future<List<Task>> getThisMonthTasks() async {
    return _queryAdapter.queryList(
        'SELECT * FROM Task WHERE due_date_time >= DATE(\"now\", \"start of month\") AND due_date_time <= DATE(\"now\", \"start of month\", \"+1 month\", \"-1 day\")',
        mapper: (Map<String, Object?> row) => Task(
            id: row['id'] as int?,
            title: row['title'] as String,
            description: row['description'] as String,
            priority: row['priority'] as int,
            dueDateTime: _dateTimeConverter.decode(row['due_date_time'] as int),
            tags: row['tags'] as String,
            status: row['status'] as String));
  }

  @override
  Future<void> insertTask(Task task) async {
    await _taskInsertionAdapter.insert(task, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateTask(Task task) async {
    await _taskUpdateAdapter.update(task, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteTask(Task task) async {
    await _taskDeletionAdapter.delete(task);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
