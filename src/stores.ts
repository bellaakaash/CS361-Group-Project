import { writable } from "svelte/store";

// https://stackoverflow.com/a/56489832
export const family = writable(
  JSON.parse(localStorage.getItem("family") || "{}")
);
family.subscribe((val) => localStorage.setItem("family", JSON.stringify(val)));

export const schedules = writable(
  JSON.parse(localStorage.getItem("schedules") || "{}")
);
schedules.subscribe((val) =>
  localStorage.setItem("schedules", JSON.stringify(val))
);

export const reviews = writable(
  JSON.parse(localStorage.getItem("reviews") || "{}")
);
reviews.subscribe((val) =>
  localStorage.setItem("reviews", JSON.stringify(val))
);

export const saved_recipes = writable(
  JSON.parse(localStorage.getItem("saved_recipes") || "{}")
);
saved_recipes.subscribe((val) =>
  localStorage.setItem("saved_recipes", JSON.stringify(val))
);

export const recipes = writable(
  JSON.parse(localStorage.getItem("recipes") || "{}")
);
recipes.subscribe((val) =>
  localStorage.setItem("recipes", JSON.stringify(val))
);

export const current_user = writable(
  localStorage.getItem("current_user") || ""
);
current_user.subscribe((val) => localStorage.setItem("current_user", val));
