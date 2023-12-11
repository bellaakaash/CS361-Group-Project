<!-- SearchByIngredient.svelte -->
<script>
  let ingredient = '';
  let searchResults = [];

  async function search() {
    // Call backend function to search recipes
    const response = await fetch(`/search-recipes?ingredient=${ingredient}`);
    if (response.ok) {
      searchResults = await response.json();
    } else {
      // Handle error
      searchResults = [];
    }
  }
</script>

<div>
  <input type="text" bind:value={ingredient} placeholder="Enter an ingredient" />
  <button on:click={search}>Search</button>
</div>

{#if searchResults.length > 0}
  <ul>
    {#each searchResults as recipe}
      <li>{recipe.title}</li>
    {/each}
  </ul>
{:else}
  <p>No recipes found.</p>
{/if}