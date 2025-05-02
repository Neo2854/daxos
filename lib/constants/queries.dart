final String CREATE_REMAINDERS_DB = '''
CREATE TABLE Remainder (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  description TEXT NOT NULL,
  startTs TEXT,
  endTs TEXT
);
''';