import { writable } from "svelte/store";

// https://stackoverflow.com/a/56489832
export const family = writable(
  JSON.parse(localStorage.getItem("family") || "{}")
);
family.subscribe((val) => localStorage.setItem("family", JSON.stringify(val)));

export const schedule = writable(
  JSON.parse(localStorage.getItem("schedule") || "{}")
);
schedule.subscribe((val) =>
  localStorage.setItem("schedule", JSON.stringify(val))
);

export const current_user = writable(
  localStorage.getItem("current_user") || ""
);
current_user.subscribe((val) => localStorage.setItem("current_user", val));
