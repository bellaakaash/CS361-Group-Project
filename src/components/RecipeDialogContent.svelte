<script lang="ts">
  import RecipeDialogRecipes from "./RecipeDialogRecipes.svelte";

  import { createTabs, melt } from "@melt-ui/svelte";
  import { cubicInOut } from "svelte/easing";
  import { crossfade } from "svelte/transition";

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

<div use:melt={$root}>
  <div
    use:melt={$list}
    class="flex shrink-0 overflow-x-auto bg-neutral-100
      data-[orientation=vertical]:flex-col data-[orientation=vertical]:border-r"
    aria-label="Manage your account"
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
  <div use:melt={$content("tab-1")} class="grow bg-white p-5">
    <RecipeDialogRecipes />
  </div>
  <div use:melt={$content("tab-2")} class="grow bg-white p-5">
    <RecipeDialogRecipes />
  </div>
  <div use:melt={$content("tab-3")} class="grow bg-white p-5">
    <RecipeDialogRecipes />
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
    background-color: theme(colors.neutral.100);

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
