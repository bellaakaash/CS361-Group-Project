<!-- MealPlan.svelte -->
<script>
  import { onMount } from 'svelte';
  let recipes = [];
  let date = '';
  let mealType = '';
  let recipeId = '';

  onMount(async () => {
    // Fetch recipes from backend
    recipes = await fetchRecipes();
  });

  async function addMeal() {
    // Call backend function to add meal plan
    const response = await fetch('/add-meal', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ date, mealType, recipeId })
    });
    if (response.ok) {
      // Handle success
    } else {
      // Handle error
    }
  }

  // Mock function to fetch recipes (replace with actual backend call)
  async function fetchRecipes() {
    return [
      { id: 1, title: 'Recipe 1' },
      { id: 2, title: 'Recipe 2' }
      // Add more recipes
    ];
  }
</script>

<form on:submit|preventDefault={addMeal}>
  <input type="date" bind:value={date} />
  <select bind:value={mealType}>
    <option value="breakfast">Breakfast</option>
    <option value="lunch">Lunch</option>
    <option value="dinner">Dinner</option>
  </select>
  <select bind:value={recipeId}>
    {#each recipes as recipe}
      <option value={recipe.id}>{recipe.title}</option>
    {/each}
  </select>
  <button type="submit">Add Meal</button>
</form>
