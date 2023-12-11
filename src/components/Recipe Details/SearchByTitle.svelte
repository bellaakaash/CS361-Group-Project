<!-- SearchByTitle.svelte -->
<script>
  let title = '';
  let searchResults = [];

  async function search() {
    // Call backend function to search recipes by title
    const response = await fetch(`/search-recipes?title=${title}`);
    if (response.ok) {
      searchResults = await response.json();
    } else {
      // Handle error
      searchResults = [];
    }
  }
</script>

<div>
  <input type="text" bind:value={title} placeholder="Enter a title" />
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