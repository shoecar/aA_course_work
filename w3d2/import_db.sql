DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS questions;

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body TEXT NOT NULL,
  user_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_follows;

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

DROP TABLE IF EXISTS replies;

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  reply_id INTEGER,
  body TEXT NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (reply_id) REFERENCES replies(id)
);

DROP TABLE IF EXISTS question_likes;

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ('Joseph', 'Tibbertsma'), ('Tad', 'Schukar'), ('Bob', 'Johnson');

INSERT INTO
  questions (title, body, user_id)
VALUES
  ('What''s a good question?', 'TITLE', (SELECT id FROM users WHERE fname = 'Tad')),
  ('??', 'another pointless question', (SELECT id FROM users WHERE fname = 'Tad'));

INSERT INTO
  question_follows (user_id, question_id)
VALUES
  (1,1), (2,1), (1,2);

INSERT INTO
  question_likes (user_id, question_id)
VALUES
  (1,1), (2,1), (2,2);

INSERT INTO
  replies (user_id, question_id, reply_id, body)
VALUES
  (1,1, NULL, 'I don''t know'), (3,1,1, 'Come up with a better reply!');
