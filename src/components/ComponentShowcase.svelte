<script lang="ts">
  import Calendar from "./Calendar/Calendar.svelte";
  import File from "./Recipe Details/Details.svelte";

  import { createAccordion, melt } from "@melt-ui/svelte";
  import { slide } from "svelte/transition";

  const {
    elements: { content, item, trigger, root },
    helpers: { isSelected },
  } = createAccordion({
    defaultValue: "2",
  });

  const items = [
    {
      id: "1",
      title: "Calendar",
      component: Calendar,
    },
    {
      id: "2",
      title: "Recipe Details",
      component: File,
    },
  ];

  function ComponentGenerator(node, params) {
    const new_component = new params[0]({
      target: document.querySelector(`#comp-${params[1]}`),
    });
  }
</script>

<div {...$root}>
  {#each items as { id, title, component }}
    <div
      use:melt={$item(id)}
      class="overflow-hidden transition-colors first:rounded-t-xl
              last:rounded-b-xl"
    >
      <h2 class="flex">
        <button use:melt={$trigger(id)}>
          {title}
        </button>
      </h2>
      {#if $isSelected(id)}
        <div use:melt={$content(id)} transition:slide>
          <div
            id="comp-{id}"
            class="px-5 py-4"
            use:ComponentGenerator={[component, id]}
          />
        </div>
      {/if}
    </div>
  {/each}
</div>

<style lang="postcss">
  .content {
    box-shadow: inset 0px 1px 0px theme("colors.neutral.300");
  }

  h2 {
    color: #ff3e00;
    text-transform: uppercase;
    font-size: 3em;
    font-weight: 100;
    background-color: #fff9ed;
    padding-left: 1rem;
  }
</style>
