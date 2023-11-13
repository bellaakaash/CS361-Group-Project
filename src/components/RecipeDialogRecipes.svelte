<script lang="ts">
  import { schedule } from "../stores";
  import type { Recipe } from "../types";

  import {
    createCombobox,
    createToolbar,
    melt,
    type ComboboxOptionProps,
  } from "@melt-ui/svelte";

  // Icons
  import {
    Check,
    ChevronDown,
    ChevronUp,
    ListOrdered,
    Trash,
  } from "lucide-svelte";
  import { fly } from "svelte/transition";
  import RecipeDialogContent from "./RecipeDialogContent.svelte";

  const {
    elements: { root, button, link, separator },
    builders: { createToolbarGroup },
  } = createToolbar();
  const {
    elements: { group: fontGroup, item: fontItem },
  } = createToolbarGroup({
    type: "multiple",
  });
  const {
    elements: { group: alignGroup, item: alignItem },
  } = createToolbarGroup();

  const {
    elements: { menu, input, option, label },
    states: { open, inputValue, touchedInput, selected },
    helpers: { isSelected },
  } = createCombobox<Recipe>({
    forceVisible: true,
  });

  const toOption = (recipe: Recipe): ComboboxOptionProps<Recipe> => ({
    value: recipe,
    label: recipe.title,
  });

  $: if (!$open) {
    $inputValue = $selected?.label ?? "";
  }

  $: filteredRecipes = $touchedInput
    ? $schedule.filter(({ recipe, date }) => {
        const normalizedInput = $inputValue.toLowerCase();
        return (
          recipe.title.toLowerCase().includes(normalizedInput) ||
          recipe.author.toLowerCase().includes(normalizedInput)
        );
      })
    : $schedule;

  schedule.set([ // temporary until recipe database is set properly
    {
      recipe: {
        title: "Title 1",
        author: "Author 1",
        decription: "Description 1",
        ingredients: ["Ingredients 1"],
      },
      date: Date.now().toString(),
    },
    {
      recipe: {
        title: "Title 2",
        author: "Author 2",
        decription: "Description 2",
        ingredients: ["Ingredients 2"],
      },
      date: Date.now().toString(),
    },
    {
      recipe: {
        title: "Title 3",
        author: "Author 3",
        decription: "Description 3",
        ingredients: ["Ingredients 3"],
      },
      date: Date.now().toString(),
    },
  ]);
  console.log($schedule);
</script>

{#if $open}
  <ul
    class="z-10 flex max-h-[300px] flex-col overflow-hidden rounded-lg"
    use:melt={$menu}
    transition:fly={{ duration: 150, y: -5 }}
  >
    <!-- svelte-ignore a11y-no-noninteractive-tabindex -->
    <div
      class="flex max-h-full flex-col gap-0 overflow-y-auto bg-white px-2 py-2 text-black"
      tabindex="0"
    >
      {#each filteredRecipes as { recipe, date }}
        <li
          use:melt={$option(toOption(recipe))}
          class="relative cursor-pointer scroll-my-2 rounded-md py-2 pl-4 pr-4
        hover:bg-magnum-100
        data-[highlighted]:bg-magnum-200 data-[highlighted]:text-magnum-900
          data-[disabled]:opacity-50"
        >
          {#if $isSelected(recipe)}
            <div class="check absolute left-2 top-1/2 z-10 text-magnum-900">
              <Check class="square-4" />
            </div>
          {/if}
          <div class="pl-4">
            <span class="font-medium">{recipe.title}</span>
            <span class="block text-sm opacity-75">{recipe.author}</span>
          </div>
        </li>
      {:else}
        <li class="relative cursor-pointer rounded-md py-1 pl-8 pr-4">
          No results found
        </li>
      {/each}
    </div>
  </ul>
{/if}

<div
  use:melt={$root}
  class="flex items-center gap-4 rounded-md bg-white px-3 pb-3 text-neutral-700 lg:w-[35rem]"
>
  <div class="flex flex-col gap-1">
    <!-- svelte-ignore a11y-label-has-associated-control - $label contains the 'for' attribute -->
    <div class="relative min-w-full">
      <input
        use:melt={$input}
        class="flex h-10 w-200 items-center justify-between rounded-lg bg-white
            px-3 pr-6 text-black"
        placeholder="Add a recipe"
      />
      <div
        class="absolute right-2 top-1/2 z-10 -translate-y-1/2 text-magnum-900"
      >
        {#if $open}
          <ChevronUp class="square-4" />
        {:else}
          <ChevronDown class="square-4" />
        {/if}
      </div>
    </div>
  </div>
</div>

<section>
  <div
    use:melt={$root}
    class="flex min-w-max items-center gap-4 rounded-md bg-slate-100 px-3 py-3 text-neutral-700 lg:w-[35rem]"
  >
    <p class="grow">Recipe Name</p>
    <div class="separator" use:melt={$separator} />
    <div class="flex items-center gap-1" use:melt={$fontGroup}>
      <button class="item" aria-label="bold" use:melt={$fontItem("bold")}>
        <ListOrdered class="square-5" />
      </button>
      <button class="item" aria-label="italic" use:melt={$fontItem("italic")}>
        <Trash class="square-5" />
      </button>
    </div>
  </div>
</section>

<style lang="postcss">
  .item {
    padding: theme("spacing.1");
    border-radius: theme("borderRadius.md");

    &:hover {
      background-color: theme("colors.magnum.100");
    }

    &[data-state="on"] {
      background-color: theme("colors.magnum.200");
      color: theme("colors.magnum.900");
    }

    &:focus {
      @apply ring-2 ring-magnum-400;
    }
  }

  .separator {
    width: 1px;
    background-color: theme("colors.neutral.300");
    align-self: stretch;
  }
</style>
