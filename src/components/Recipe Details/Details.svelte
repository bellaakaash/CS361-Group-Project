<script lang="ts">
  // @ts-nocheck

  import { recipes, saved_recipes, reviews } from "../../stores";

  import {
    createSeparator,
    createTableOfContents,
    melt,
    type CreateSeparatorProps,
  } from "@melt-ui/svelte";
  import DetailsTree from "./DetailsTree.svelte";
  import { Heart, Star, StarHalf } from "lucide-svelte";

  export let RecipeID = 1;
  const recipeDetails = $recipes[RecipeID];
  const recipeReviews = $reviews[RecipeID];

  const {
    elements: { root: horizontal },
  } = createSeparator({
    orientation: "horizontal",
    decorative: true,
  });

  const {
    elements: { item },
    states: { activeHeadingIdxs, headingsTree },
  } = createTableOfContents({
    selector: "#toc",
    exclude: ["h1", "h4", "h5", "h6"],
    activeType: "all",
    headingFilterFn: (heading) => !heading.hasAttribute("data-toc-ignore"),
    scrollFn: (id) => {
      /**
       * Here we're overwriting the default scroll function
       * so that we only scroll within the ToC preview
       * container, instead of the entire page.
       */
      const container = document.getElementById("toc");
      const element = document.getElementById(id);

      if (container && element) {
        container.scrollTo({
          top: element.offsetTop - container.offsetTop - 16,
          behavior: "smooth",
        });
      }
    },
  });

  let saved = false;
  $saved_recipes.forEach((RID: number) => {
    if (RID == RecipeID) {
      saved = true;
    }
  });

  function toggleSavedRecipe(RID: number) {
    let new_saved_recipes = $saved_recipes;

    // check if recipe is already saved
    for (let i = 0; i < $saved_recipes.length; i++) {
      if (new_saved_recipes[i] == RID) {
        new_saved_recipes.splice(i, 1); // if found, remove it
        saved_recipes.set(new_saved_recipes);
        // update saved
        saved = false;
        return;
      }
    }
    // if recipe wasn't removed, add it
    new_saved_recipes.push(RID);
    saved_recipes.set(new_saved_recipes);
    // update saved
    saved = true;
  }
</script>

<section class="text-left">
  <div class="flex flex-row gap-2">
    <h1 class="grow">{recipeDetails.Title}</h1>
    <button
      class="rounded-full ring ring-inset ring-magnum-400 flex flex-row items-center gap-2 p-2 px-3"
    >
      <p>Rated</p>
      <div class="flex flex-row static">
        {#each { length: Math.floor(recipeReviews.average) } as _, i}
          <Star size={20} fill="#f7b155" />
        {/each}
        {#if recipeReviews.average % 1 != 0}
          <Star size={20} />
          <StarHalf
            size={20}
            fill="#f7b155"
            class="relative right-[20px] mr-[-20px]"
          />
        {/if}
        {#each { length: 4 - Math.floor(recipeReviews.average) } as _, i}
          <Star size={20} />
        {/each}
      </div>
    </button>
    <button
      on:click={() => {
        toggleSavedRecipe(RecipeID);
      }}
      class="rounded-full bg-magnum-400 flex flex-row items-center gap-2 p-2 px-3"
    >
      <p>Save this recipe</p>
      <Heart size={20} fill="#FFFFFF{saved ? 'FF' : '00'}" />
    </button>
  </div>
  <div class="flex flex-row static">
    <p class="grow">{recipeDetails.Description}</p>
    <h2>{recipeDetails.Author}</h2>
  </div>
  <div use:melt={$horizontal} class="my-3.5 h-[1px] w-full bg-magnum-900" />
  <div class="flex flex-row max-h-96">
    <div
      id="toc"
      class="space-y-2 overflow-y-auto rounded-lg bg-white p-4 text-neutral-900 grow"
    >
      {#each recipeDetails.Instructions as { heading, details }}
        <h2>{heading}</h2>
        {#each details as detail}
          <p>{detail}</p>
        {/each}
      {/each}
    </div>

    <div
      class="rounded-lg bg-white p-4 min-w-max place-self-start top-0 sticky"
    >
      <p class="font-semibold text-neutral-900">On This Page</p>
      <nav>
        {#key $headingsTree}
          <DetailsTree
            tree={$headingsTree}
            activeHeadingIdxs={$activeHeadingIdxs}
            {item}
          />
        {/key}
      </nav>
    </div>
  </div>
</section>

<style lang="postcss">
  h1 {
    @apply text-xl font-bold;
  }

  #toc > h2 {
    @apply text-xl font-bold;
  }

  #toc > h3 {
    @apply text-lg font-bold;
  }

  #toc > h4 {
    @apply text-lg font-semibold;
  }

  .hide-heading {
    display: inline-flex;
    height: theme(spacing.8);
    cursor: default;
    align-items: center;
    justify-content: center;
    border-radius: theme(borderRadius.md);
    background-color: theme(colors.magnum.200);
    padding-inline: theme(spacing.4);
    line-height: 1;
    font-weight: theme(fontWeight.semibold);
    color: theme(colors.magnum.900);
    @apply transition;

    &:hover {
      opacity: 0.75;
    }
  }
</style>
