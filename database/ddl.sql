
-- users table
CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT UNIQUE NOT NULL,
    email TEXT UNIQUE NOT NULL,
    dietary TEXT
);

-- recipes table
CREATE TABLE IF NOT EXISTS recipes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER,
    title TEXT NOT NULL,
    cuisine_type TEXT,
    preparation_time INTEGER,
    servings INTEGER,
    instructions TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

--  categories table
CREATE TABLE IF NOT EXISTS categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT UNIQUE NOT NULL
);

-- Add a category_id column to the 'recipes' table
ALTER TABLE recipes ADD COLUMN category_id INTEGER;

-- ingredients table
CREATE TABLE IF NOT EXISTS ingredients (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    quantity REAL,
    unit TEXT
);

-- recipe_ingredients table
CREATE TABLE IF NOT EXISTS recipe_ingredients (
    recipe_id INTEGER,
    ingredient_id INTEGER,
    quantity REAL,
    unit TEXT,
    required BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (recipe_id, ingredient_id),
    FOREIGN KEY (recipe_id) REFERENCES recipes(id) ON DELETE CASCADE,
    FOREIGN KEY (ingredient_id) REFERENCES ingredients(id) ON DELETE CASCADE
);

-- meal_plans table
CREATE TABLE IF NOT EXISTS meal_plans (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER,
    date DATE NOT NULL,
    meal_type TEXT NOT NULL,
    recipe_id INTEGER,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (recipe_id) REFERENCES recipes(id) ON DELETE SET NULL
);

-- inventory_items table
CREATE TABLE IF NOT EXISTS inventory_items (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER,
    ingredient_id INTEGER,
    expiry_date DATE,
    in_stock_quantity REAL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (ingredient_id) REFERENCES ingredients(id) ON DELETE CASCADE
);

-- shopping_list table
CREATE TABLE IF NOT EXISTS shopping_list (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER,
    ingredient_id INTEGER,
    required_quantity REAL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (ingredient_id) REFERENCES ingredients(id) ON DELETE CASCADE
);

-- recipe_reviews table
CREATE TABLE IF NOT EXISTS recipe_reviews (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    recipe_id INTEGER,
    user_id INTEGER,
    rating INTEGER,
    review TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (recipe_id) REFERENCES recipes(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- nutrition_info table
CREATE TABLE IF NOT EXISTS nutrition_info (
    recipe_id INTEGER PRIMARY KEY,
    calories REAL,
    protein REAL,
    carbohydrates REAL,
    fat REAL,
    sodium REAL,
    sugar REAL,
    FOREIGN KEY (recipe_id) REFERENCES recipes(id) ON DELETE CASCADE
);

-- user_favorite_recipes table
CREATE TABLE IF NOT EXISTS user_favorite_recipes (
    user_id INTEGER,
    recipe_id INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, recipe_id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (recipe_id) REFERENCES recipes(id) ON DELETE CASCADE
);

-- recipe_media table
CREATE TABLE IF NOT EXISTS recipe_media (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    recipe_id INTEGER,
    media_type TEXT NOT NULL,
    media_url TEXT NOT NULL,
    FOREIGN KEY (recipe_id) REFERENCES recipes(id) ON DELETE CASCADE
);

-- Insert sample data into 'users'
INSERT INTO users (username, email) VALUES
('john_doe', 'john@example.com'),
('jane_smith', 'jane@example.com');

-- Insert sample data into 'recipes'
INSERT INTO recipes (user_id, title, cuisine_type, preparation_time, servings, instructions) VALUES
(1, 'Spaghetti Carbonara', 'Italian', 30, 4, 'Boil pasta, fry pancetta, mix with eggs and cheese'),
(1, 'Classic Cheeseburger', 'American', 25, 2, 'Grill beef patties, place cheese on top, serve with buns and condiments'),
(2, 'Vegetable Stir Fry', 'Chinese', 20, 3, 'Stir fry vegetables with soy sauce and garlic, serve with rice');

-- Insert sample data into 'ingredients'
INSERT INTO ingredients (name, quantity, unit) VALUES
('Spaghetti', 500, 'g'),
('Pancetta', 100, 'g'),
('Parmesan Cheese', 50, 'g'),
('Ground Beef', 300, 'g'),
('Cheddar Cheese', 100, 'g'),
('Mixed Vegetables', 450, 'g'),
('Soy Sauce', 50, 'ml');

-- Insert sample data into 'recipe_ingredients'
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, unit) VALUES
(1, 1, 500, 'g'),
(1, 2, 100, 'g'),
(1, 3, 50, 'g'),
(2, 4, 300, 'g'),
(2, 5, 100, 'g'),
(3, 6, 450, 'g'),
(3, 7, 50, 'ml');

-- Insert sample data into 'meal_plans'
INSERT INTO meal_plans (user_id, date, meal_type, recipe_id) VALUES
(1, '2023-11-01', 'Dinner', 1),
(2, '2023-11-02', 'Lunch', 3);

-- Insert sample data into 'inventory_items'
INSERT INTO inventory_items (user_id, ingredient_id, expiry_date, in_stock_quantity) VALUES
(1, 1, '2023-12-01', 2),
(2, 6, '2023-11-15', 1);

-- Insert sample data into 'shopping_list'
INSERT INTO shopping_list (user_id, ingredient_id, required_quantity) VALUES
(1, 2, 200),
(2, 5, 150);

-- Insert sample data into 'recipe_reviews'
INSERT INTO recipe_reviews (recipe_id, user_id, rating, review) VALUES
(1, 2, 5, 'Delicious classic recipe with a twist.'),
(2, 1, 4, 'Tasty, but could use less spice.');

-- Insert sample data into 'nutrition_info'
INSERT INTO nutrition_info (recipe_id, calories, protein, carbohydrates, fat, sodium, sugar) VALUES
(1, 400, 10, 50, 10, 500, 5),
(2, 600, 30, 40, 20, 700, 10);

-- Insert sample data into 'user_favorite_recipes'
INSERT INTO user_favorite_recipes (user_id, recipe_id) VALUES
(1, 2),
(2, 1);