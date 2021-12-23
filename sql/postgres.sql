CREATE TABLE IF NOT EXISTS listeners (
	id serial PRIMARY KEY,
	name VARCHAR ( 50 ) NOT NULL,
	age INTEGER NOT NULL
);
INSERT INTO listeners (name, age) VALUES
('Malte', 29),
('Frederic', 19),
('Andy', 28),
('Falk', 51),
('Florian', 42),
('Ulli', 14);
