<script lang="ts">
  import RecipeDialogRecipes from "./RecipeDialogRecipes.svelte";

  import { createTabs, melt } from "@melt-ui/svelte";
  import { cubicInOut } from "svelte/easing";
  import { crossfade } from "svelte/transition";

  export let selectedDate = Date.now();

  const {
    elements: { root, list, content, trigger },
    states: { value },
  } = createTabs({
    defaultValue: "tab-1",
  });

  const triggers = [
    { id: "tab-1", title: "Breakfast" },
    { id: "tab-2", title: "Lunch" },
    { id: "tab-3", title: "Dinner" },
  ];

  const [send, receive] = crossfade({
    duration: 250,
    easing: cubicInOut,
  });
</script>

<div class="p-0.5 shadow rounded-lg">
  <div use:melt={$root} class="rounded-lg">
    <div
      use:melt={$list}
      class="flex rounded-t-md shrink-0 overflow-x-auto bg-neutral-100
      data-[orientation=vertical]:flex-col data-[orientation=vertical]:border-r"
      aria-label="Meal time selection"
    >
      {#each triggers as triggerItem}
        <button use:melt={$trigger(triggerItem.id)} class="trigger relative">
          {triggerItem.title}
          {#if $value === triggerItem.id}
            <div
              in:send={{ key: "trigger" }}
              out:receive={{ key: "trigger" }}
              class="absolute bottom-1 left-1/2 h-1 w-6 -translate-x-1/2 rounded-full bg-magnum-400"
            />
          {/if}
        </button>
      {/each}
    </div>
    <div use:melt={$content("tab-1")} class="grow bg-white rounded-b-md p-5">
      <RecipeDialogRecipes {selectedDate} timeOfDay="B" />
    </div>
    <div use:melt={$content("tab-2")} class="grow bg-white rounded-b-md p-5">
      <RecipeDialogRecipes {selectedDate} timeOfDay="L" />
    </div>
    <div use:melt={$content("tab-3")} class="grow bg-white rounded-b-md p-5">
      <RecipeDialogRecipes {selectedDate} timeOfDay="D" />
    </div>
  </div>
</div>

<style lang="postcss">
  .trigger {
    display: flex;
    align-items: center;
    justify-content: center;

    cursor: default;
    user-select: none;

    border-radius: 0;
    background-color: theme("colors.magnum.100");

    color: theme(colors.neutral.900);
    font-weight: 500;
    line-height: 1;

    flex: 1;
    height: theme(spacing.12);
    padding-inline: theme(spacing.2);

    &:focus {
      position: relative;
    }

    &:focus-visible {
      @apply z-10 ring-2;
    }

    &[data-state="active"] {
      @apply focus:relative;
      background-color: white;
      color: theme("colors.magnum.900");
    }
  }

  .save {
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

    &:focus {
      @apply !ring-green-600;
    }
  }
</style>
