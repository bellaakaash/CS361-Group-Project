<script lang="ts">
  import { current_user, family } from "../stores";

  import { createSelect, melt } from "@melt-ui/svelte";
  import { Check, ChevronDown } from "lucide-svelte";
  import { fade } from "svelte/transition";

  const {
    elements: { trigger, menu, option, group, groupLabel, label },
    states: { selectedLabel, open },
    helpers: { isSelected },
  } = createSelect({
    forceVisible: true,
    positioning: {
      placement: "bottom",
      fitViewport: true,
      sameWidth: true,
    },
  });

  function SelectMember(member: string) {
    current_user.set(member);
  }
</script>

<div class="flex flex-col gap-1">
  <!-- svelte-ignore a11y-label-has-associated-control - $label contains the 'for' attribute -->
  <label class="block text-magnum-900" use:melt={$label}
    >Select family member</label
  >
  <button
    class="flex h-10 min-w-[220px] items-center justify-between rounded-lg bg-white px-3 py-2
    text-magnum-700 shadow transition-opacity hover:opacity-90"
    use:melt={$trigger}
    aria-label="Family"
  >
    {$selectedLabel || $current_user}
    <ChevronDown class="square-5" />
  </button>
  {#if $open}
    <div
      class="z-10 flex max-h-[300px] flex-col
      overflow-y-auto rounded-lg bg-white p-1
      shadow focus:!ring-0"
      use:melt={$menu}
      transition:fade={{ duration: 150 }}
    >
      {#each Object.entries($family) as [index, member]}
        <button
          class="relative cursor-pointer rounded-lg py-1 pl-8 pr-4 text-neutral-800
                hover:bg-magnum-100 focus:z-10
                focus:text-magnum-700
                data-[highlighted]:bg-magnum-200 data-[highlighted]:text-magnum-900
                data-[disabled]:opacity-50 text-left"
          use:melt={$option({ value: member, label: member.toString() })}
          on:click={() => SelectMember(member.toString())}
        >
          <div class="check {$isSelected(member) ? 'block' : 'hidden'}">
            <Check class="square-4" />
          </div>
          {member}
        </button>
      {/each}
    </div>
  {/if}
</div>

<style lang="postcss">
  .check {
    position: absolute;
    left: theme(spacing.2);
    top: 50%;
    z-index: theme(zIndex.20);
    translate: 0 calc(-50% + 1px);
    color: theme(colors.magnum.500);
  }
</style>
