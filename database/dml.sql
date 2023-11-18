-- Add a new user
INSERT INTO users (username, email) VALUES (?, ?, ?);

-- Add a new recipe
INSERT INTO recipes (user_id, title, cuisine_type, preparation_time, servings, instructions) 
VALUES (?, ?, ?, ?, ?, ?);

-- Add a new ingredient
INSERT INTO ingredients (name, quantity, unit) VALUES (?, ?, ?);

-- Add a new entry in recipe_ingredients
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, unit, required) 
VALUES (?, ?, ?, ?, ?);

-- Add a new meal plan
INSERT INTO meal_plans (user_id, date, meal_type, recipe_id) VALUES (?, ?, ?, ?);

-- Add a new inventory item
INSERT INTO inventory_items (user_id, ingredient_id, expiry_date, in_stock_quantity) 
VALUES (?, ?, ?, ?);

-- Add a new item to the shopping list
INSERT INTO shopping_list (user_id, ingredient_id, required_quantity) 
VALUES (?, ?, ?);

-- Add a new recipe review
INSERT INTO recipe_reviews (recipe_id, user_id, rating, review) VALUES (?, ?, ?, ?);

-- Add nutrition information for a recipe
INSERT INTO nutrition_info (recipe_id, calories, protein, carbohydrates, fat, sodium, sugar) 
VALUES (?, ?, ?, ?, ?, ?, ?);

-- Add a recipe to the user's favorite list
INSERT INTO user_favorite_recipes (user_id, recipe_id) VALUES (?, ?);

-- Add media information for a recipe
INSERT INTO recipe_media (recipe_id, media_type, media_url) VALUES (?, ?, ?);

-- Update user details by user_id
UPDATE users 
SET username = ?, email = ?, updated_at = CURRENT_TIMESTAMP 
WHERE id = ?;

-- Update recipe details by recipe_id
UPDATE recipes 
SET user_id = ?, title = ?, cuisine_type = ?, 
    preparation_time = ?, servings = ?, instructions = ?, updated_at = CURRENT_TIMESTAMP 
WHERE id = ?;

-- Update ingredient details by ingredient_id
UPDATE ingredients 
SET name = ?, quantity = ?, unit = ? 
WHERE id = ?;

-- Update recipe_ingredients details by recipe_id and ingredient_id
UPDATE recipe_ingredients 
SET quantity = ?, unit = ?, required = ? 
WHERE recipe_id = ? AND ingredient_id = ?;

-- Update meal plan details by id
UPDATE meal_plans 
SET user_id = ?, date = ?, meal_type = ?, recipe_id = ? 
WHERE id = ?;

-- Update inventory item details by id
UPDATE inventory_items 
SET user_id = ?, ingredient_id = ?, expiry_date = ?, in_stock_quantity = ? 
WHERE id = ?;

-- Update shopping list item details by id
UPDATE shopping_list 
SET user_id = ?, ingredient_id = ?, required_quantity = ? 
WHERE id = ?;

-- Update recipe review details by id
UPDATE recipe_reviews 
SET recipe_id = ?, user_id = ?, rating = ?, review = ? 
WHERE id = ?;

-- Update nutrition information for a recipe by recipe_id
UPDATE nutrition_info 
SET calories = ?, protein = ?, carbohydrates = ?, fat = ?, sodium = ?, sugar = ? 
WHERE recipe_id = ?;

-- Delete a user by id
DELETE FROM users WHERE id = ?;

-- Delete a recipe by id
DELETE FROM recipes WHERE id = ?;

-- Delete an ingredient by id
DELETE FROM ingredients WHERE id = ?;

-- Delete a recipe_ingredients entry by recipe_id and ingredient_id
DELETE FROM recipe_ingredients WHERE recipe_id = ? AND ingredient_id = ?;

-- Delete a meal plan by id
DELETE FROM meal_plans WHERE id = ?;

-- Delete an inventory item by id
DELETE FROM inventory_items WHERE id = ?;

-- Delete a shopping list item by id
DELETE FROM shopping_list WHERE id = ?;

-- Delete a recipe review by id
DELETE FROM recipe_reviews WHERE id = ?;

-- Delete nutrition information for a recipe by recipe_id
DELETE FROM nutrition_info WHERE recipe_id = ?;

-- Delete a recipe from the user's favorite list by user_id and recipe_id
DELETE FROM user_favorite_recipes WHERE user_id = ? AND recipe_id = ?;

-- Delete media information for a recipe by id
DELETE FROM recipe_media WHERE id = ?;

-- Search for specific user details by id
SELECT id, username, email, created_at, updated_at FROM users WHERE id = ?;

-- Search for specific recipe details by id
SELECT id, user_id, title, cuisine_type, preparation_time, servings, instructions, created_at, updated_at 
FROM recipes WHERE id = ?;

-- Search for specific ingredient details by id
SELECT id, name, quantity, unit FROM ingredients WHERE id = ?;

-- Search for specific recipe_ingredients details by recipe_id and ingredient_id
SELECT recipe_id, ingredient_id, quantity, unit, required FROM recipe_ingredients 
WHERE recipe_id = ? AND ingredient_id = ?;

-- Search for specific meal plan details by id
SELECT id, user_id, date, meal_type, recipe_id FROM meal_plans WHERE id = ?;

-- Search for specific inventory item details by id
SELECT id, user_id, ingredient_id, expiry_date, in_stock_quantity FROM inventory_items WHERE id = ?;

-- Search for specific shopping list item details by id
SELECT id, user_id, ingredient_id, required_quantity FROM shopping_list WHERE id = ?;

-- Search for specific recipe review details by id
SELECT id, recipe_id, user_id, rating, review, created_at FROM recipe_reviews WHERE id = ?;

-- Search for nutrition information for a recipe by recipe_id
SELECT recipe_id, calories, protein, carbohydrates, fat, sodium, sugar FROM nutrition_info WHERE recipe_id = ?;

-- Search for recipes in a user's favorite list by user_id
SELECT user_id, recipe_id, created_at FROM user_favorite_recipes WHERE user_id = ?;

-- Search for media information for a recipe by id
SELECT id, recipe_id, media_type, media_url FROM recipe_media WHERE id = ?;