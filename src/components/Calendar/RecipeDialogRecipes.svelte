<script lang="ts">
  // @ts-nocheck

  import { schedules, recipes, current_user } from "../../stores";
  import type { Recipe } from "../../types";

  import {
    createCombobox,
    createToolbar,
    melt,
    type ComboboxOptionProps,
    rangeCalendarIdParts,
  } from "@melt-ui/svelte";

  // Icons
  import { Check, ChevronDown, Plus, ListOrdered, Trash } from "lucide-svelte";
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
    $inputValue = "";
  }

  $: searchFilteredRecipes = $touchedInput
    ? Object.entries($recipes).filter(([ID, recipeDetails]) => {
        const normalizedInput = $inputValue.toLowerCase();
        return (
          recipeDetails.title.toLowerCase().includes(normalizedInput) ||
          recipeDetails.author.toLowerCase().includes(normalizedInput)
        );
      })
    : Object.entries($recipes);

  export let selectedDate = Date.now();
  $: scheduleRecipesFiltered = $schedules[$current_user].filter(
    ({ RecipeID, Date, TimeOfDay }) => {
      return Date == selectedDate && TimeOfDay == timeOfDay;
    }
  );

  function IDtoDetails({ RecipeID }) {
    return $recipes[RecipeID];
  }

  function removeFromSchedule(ID) {
    let new_schedules = $schedules;
    for (let i = 0; i < new_schedules[$current_user].length; ++i) {
      if (
        new_schedules[$current_user][i].RecipeID == ID &&
        new_schedules[$current_user][i].TimeOfDay == timeOfDay
      ) {
        new_schedules[$current_user].splice(i, 1);
      }
    }

    schedules.set(new_schedules);
  }

  export let timeOfDay = "";
  selected.subscribe((val) => {
    if (val != null) {
      let new_schedules = $schedules;
      new_schedules[$current_user].push({
        RecipeID: val.value["ID"],
        Date: selectedDate.toString(),
        TimeOfDay: timeOfDay,
      });
      schedules.set(new_schedules);
    }
  });
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
      {#each searchFilteredRecipes as [ID, recipeDetails]}
        <li
          use:melt={$option(toOption(recipeDetails))}
          class="relative cursor-pointer scroll-my-2 rounded-md py-2 pl-4 pr-4
        hover:bg-magnum-100
        data-[highlighted]:bg-magnum-200 data-[highlighted]:text-magnum-900
          data-[disabled]:opacity-50"
        >
          {#if $isSelected(recipeDetails)}
            <div class="check absolute left-2 top-1/2 z-10 text-magnum-900">
              <Check class="square-4" />
            </div>
          {/if}
          <div class="pl-4">
            <span class="font-medium">{recipeDetails.Title}</span>
            <span class="block text-sm opacity-75">{recipeDetails.Author}</span>
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
  class="flex items-center gap-4 rounded-md bg-white px-3 pb-3 text-neutral-700"
>
  <div class="flex flex-col gap-1 min-w-full">
    <!-- svelte-ignore a11y-label-has-associated-control - $label contains the 'for' attribute -->
    <div
      class="relative min-w-full outline outline-2 outline-offset-1 outline-magnum-400 rounded-lg"
    >
      <input
        use:melt={$input}
        class="flex h-10 min-w-full items-center justify-between rounded-lg bg-magnum-100
            px-3 pr-12 text-black"
        placeholder="Add a recipe"
      />
      <div
        class="absolute right-2 top-1/2 z-10 -translate-y-1/2 text-magnum-900"
      >
        {#if $open}
          <Plus class="square-4" />
        {:else}
          <ChevronDown class="square-4" />
        {/if}
      </div>
    </div>
  </div>
</div>

<table class="bg-neutral-50 min-w-full rounded-b-lg table-auto">
  {#each scheduleRecipesFiltered.map(IDtoDetails) as recipeDetails}
    <tr>
      <td
        use:melt={$root}
        class="flex min-w-max items-center gap-4 rounded-md bg-neutral-100 px-3 py-3 text-neutral-700"
      >
        <p class="grow">{recipeDetails.Title}</p>
        <div class="separator" use:melt={$separator} />
        <div class="flex items-center gap-1" use:melt={$fontGroup}>
          <a href="recipeInstructionsPage">
            <ListOrdered class="square-5" />
          </a>
          <button on:click={removeFromSchedule(recipeDetails.ID)}>
            <Trash class="square-5" />
          </button>
        </div>
      </td>
    </tr>
  {/each}
</table>

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
