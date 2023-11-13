<script lang="ts">
  import { current_user } from "../stores";

  import UserSelect from "./UserSelect.svelte";

  import {
    createCalendar,
    createSeparator,
    createDialog,
    melt,
  } from "@melt-ui/svelte";
  import { ChevronRight, ChevronLeft, X } from "lucide-svelte";
  import { fade } from "svelte/transition";
  import RecipeDialogContent from "./RecipeDialogContent.svelte";

  const {
    elements: { calendar, heading, grid, cell, prevButton, nextButton },
    states: { months, headingValue, daysOfWeek },
    helpers: { isDateDisabled, isDateUnavailable },
  } = createCalendar();

  const {
    elements: {
      close,
      content,
      description,
      overlay,
      portalled,
      title,
      trigger,
    },
    states: { open },
  } = createDialog({ forceVisible: true });

  const {
    elements: { root: vertical },
  } = createSeparator({
    orientation: "vertical",
    decorative: true,
  });

  let selected_date = "##/##/##";

  function dialogDate(date: string) {
    selected_date = date;
  }

  current_user.set("Bob"); // temporary until user selection workflow is set
</script>

<div use:melt={$portalled}>
  {#if $open}
    <div
      use:melt={$overlay}
      class="fixed inset-0 z-50 bg-black/50"
      transition:fade={{ duration: 150 }}
    />
    <div
      class="fixed left-[50%] top-[50%] z-50 max-h-[85vh] w-[90vw]
            max-w-[450px] translate-x-[-50%] translate-y-[-50%] rounded-xl bg-white
            p-6 shadow-lg"
      transition:fade={{ duration: 150 }}
      use:melt={$content}
    >
      <div class="flex flex-row items-center space-x-2">
        <h2 use:melt={$title} class="m-0 text-lg font-medium text-black">
          Edit Meal Schedule
        </h2>
        <div use:melt={$vertical} class="h-4 w-[1px] bg-magnum-900" />
        <div role="doc-subtitle" class="text-sm">
          {$current_user}
        </div>
        <div use:melt={$vertical} class="h-4 w-[1px] bg-magnum-900" />
        <div role="doc-subtitle" class="text-sm">
          {selected_date}
        </div>
      </div>
      <p use:melt={$description} class="mb-5 mt-2 leading-normal text-zinc-600">
        Add or remove recipes from your schedule. Click save when you're done.
      </p>

      <RecipeDialogContent />

      <button
        use:melt={$close}
        aria-label="close"
        class="absolute right-4 top-4 inline-flex h-6 w-6 appearance-none
                items-center justify-center rounded-full p-1 text-magnum-800
                hover:bg-magnum-100 focus:shadow-magnum-400"
      >
        <X class="square-4" />
      </button>
    </div>
  {/if}
</div>

<section>
  <div>
    <UserSelect />
  </div>
  <div use:melt={$calendar}>
    <header>
      <button use:melt={$prevButton}>
        <ChevronLeft size={24} />
      </button>
      <div use:melt={$heading}>
        {$headingValue}
      </div>
      <button use:melt={$nextButton}>
        <ChevronRight size={24} />
      </button>
    </header>
    <div>
      {#each $months as month}
        <table use:melt={$grid}>
          <thead aria-hidden="true">
            <tr>
              {#each $daysOfWeek as day}
                <th>
                  <div>
                    {day}
                  </div>
                </th>
              {/each}
            </tr>
          </thead>
          <tbody>
            {#each month.weeks as weekDates}
              <tr>
                {#each weekDates as date}
                  <td
                    role="gridcell"
                    aria-disabled={$isDateDisabled(date) ||
                      $isDateUnavailable(date)}
                  >
                    <button
                      use:melt={$trigger}
                      use:melt={$cell(date, month.value)}
                      on:click={() => dialogDate(date.toString())}
                    >
                      {date.day}
                    </button>
                  </td>
                {/each}
              </tr>
            {/each}
          </tbody>
        </table>
      {/each}
    </div>
  </div>
</section>

<style lang="postcss">
  [data-melt-calendar] {
    @apply w-full rounded-lg bg-white p-3 text-magnum-800 shadow-sm;
  }

  header {
    @apply flex items-center justify-between pb-2;
  }

  header + div {
    @apply flex items-center gap-8;
  }

  [data-melt-calendar-prevbutton] {
    @apply rounded-lg p-1 transition-all hover:bg-magnum-100;
  }

  [data-melt-calendar-nextbutton] {
    @apply rounded-lg p-1 transition-all hover:bg-magnum-100;
  }

  [data-melt-calendar-heading] {
    @apply font-semibold text-magnum-800;
  }

  th {
    @apply text-sm font-semibold text-magnum-800;

    & div {
      @apply flex h-6 w-6 items-center justify-center p-4;
    }
  }

  [data-melt-calendar-grid] {
    @apply w-full;
  }

  [data-melt-calendar-cell] {
    @apply flex h-6 w-6 cursor-pointer select-none items-center justify-center rounded-lg p-4 hover:bg-magnum-100 focus:ring focus:ring-magnum-400 data-[outside-visible-months]:pointer-events-none data-[outside-visible-months]:cursor-default data-[range-highlighted]:bg-magnum-200 data-[selected]:bg-magnum-300 data-[selected]:text-magnum-900 data-[disabled]:opacity-40 data-[outside-visible-months]:opacity-40 data-[outside-visible-months]:hover:bg-transparent;
  }

  [data-melt-calendar-cell][data-outside-month="true"][data-outside-visible-months="true"] {
    @apply opacity-0;
  }
</style>
