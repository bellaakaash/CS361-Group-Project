import "./app.css";
import App from "./App.svelte";

const app = new App({
  target: document.body,
});

export default app;

import {
  schedules as schedules,
  recipes,
  family,
  current_user,
} from "./stores";

current_user.set("Bob"); // temporary until user selection workflow is set

// temporary data until connected to database
family.set(["Alice", "Bob", "Timmy", "Tommy"]);

recipes.set({
  1: {
    ID: 1,
    Title: "Title 1",
    Author: "Author 1",
    Decription: "Description 1",
    Ingredients: ["Ingredients 1"],
  },
  2: {
    ID: 2,
    Title: "Title 2",
    Author: "Author 2",
    Decription: "Description 2",
    Ingredients: ["Ingredients 2"],
  },
  3: {
    ID: 3,
    Title: "Title 3",
    Author: "Author 3",
    Decription: "Description 3",
    Ingredients: ["Ingredients 3"],
  },
});

schedules.set({ Bob: [] });
