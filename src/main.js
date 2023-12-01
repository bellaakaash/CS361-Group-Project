import "./app.css";
import App from "./App.svelte";

const app = new App({
  target: document.body,
});

export default app;

import {
  schedules as schedules,
  recipes,
  reviews,
  family,
  saved_recipes,
  current_user,
} from "./stores";

current_user.set("Bob"); // temporary until user selection workflow is set

// temporary data until connected to database
family.set(["Alice", "Bob", "Timmy", "Tommy"]);

//recipes.set({
//  1: {
//    ID: 1,
//    Title: "Title 1",
//    Author: "Author 1",
//    Description: "Description 1",
//    Ingredients: ["Ingredients 1"],
//    Instructions: [
//      { heading: "Heading 1", details: ["Details 1 1", "Details 1 2"] },
//    ],
//  },
//  2: {
//    ID: 2,
//    Title: "Title 2",
//    Author: "Author 2",
//    Description: "Description 2",
//    Ingredients: ["Ingredients 2"],
//    Instructions: [
//      { heading: "Heading 2", details: ["Details 2 1", "Details 2 2"] },
//    ],
//  },
//  3: {
//    ID: 3,
//    Title: "Title 3",
//    Author: "Author 3",
//    Description: "Description 3",
//    Ingredients: ["Ingredients 3"],
//    Instructions: [
//      { heading: "Heading 3", details: ["Details 3 1", "Details 3 2"] },
//    ],
//  },
//});
//console.log({
//  1: {
//    ID: 1,
//    Title: "Title 1",
//    Author: "Author 1",
//    Description: "Description 1",
//    Ingredients: ["Ingredients 1"],
//    Instructions: [
//      { heading: "Heading 1", details: ["Details 1 1", "Details 1 2"] },
//      ],
//  },
//  2: {
//    ID: 2,
//    Title: "Title 2",
//    Author: "Author 2",
//    Description: "Description 2",
//    Ingredients: ["Ingredients 2"],
//    Instructions: [
//      { heading: "Heading 2", details: ["Details 2 1", "Details 2 2"] },
//      ],
//  },
//  3: {
//    ID: 3,
//    Title: "Title 3",
//    Author: "Author 3",
//    Description: "Description 3",
//    Ingredients: ["Ingredients 3"],
//    Instructions: [
//      { heading: "Heading 3", details: ["Details 3 1", "Details 3 2"] },
//      ],
//  },
//})

// database not filled enough to return an array to this turns it into one
let temp = db.query("SELECT * FROM recipes")
let temp2 = Object();
temp2[temp.id] = temp;
recipes.set(temp2)

reviews.set({
  1: { average: 3.5, reviews: ["Review 1"] },
  2: { average: 3.5, reviews: ["Review 1"] },
  3: { average: 3.5, reviews: ["Review 1"] },
  4: { average: 3.5, reviews: ["Review 1"] },
  5: { average: 3.5, reviews: ["Review 1"] },
});

schedules.set({ Bob: [] });

saved_recipes.set([1, 2, 3, 4, 5]);
