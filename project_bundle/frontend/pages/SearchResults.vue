<template>
  <div class="max-w-7xl mx-auto px-4 py-12 md:py-20 animate-in fade-in duration-700">
    <!-- Results Header -->
    <div class="mb-12 border-b border-slate-100 pb-8 flex flex-col md:flex-row md:items-end justify-between gap-4">
      <div class="space-y-2">
        <h1 class="text-3xl md:text-4xl font-black text-dark tracking-tight">Search Results</h1>
        <p v-if="dataStore.searchResults.length" class="text-slate-500 font-medium">
          Found <span class="text-primary font-bold">{{ dataStore.searchResults.length }}</span> treasures matching your query
        </p>
      </div>
      
      <div v-if="dataStore.searchResults.length" class="flex items-center gap-2 text-xs font-black uppercase tracking-widest text-slate-400">
         <font-awesome-icon icon="fa-solid fa-sort" />
         <span>Matching by relevance</span>
      </div>
    </div>

    <!-- Results Grid -->
    <div 
      v-if="dataStore.searchResults.length"
      class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-8 md:gap-10"
    >
      <div 
        v-for="book in dataStore.searchResults"
        :key="book.pk"
        class="animate-in slide-in-from-bottom-4 duration-500 fill-mode-both"
        :style="{ animationDelay: `${(index % 4) * 100}ms` }"
      >
        <BookCard :book="book" />
      </div>
    </div>

    <!-- Empty State -->
    <div
      v-else 
      class="flex flex-col items-center justify-center py-32 px-4 text-center glass rounded-[40px] border border-white/40 shadow-premium"
    >
      <div class="relative mb-8">
        <div class="absolute inset-0 bg-red-500/5 rounded-full scale-150 blur-2xl"></div>
        <div class="w-24 h-24 bg-white rounded-full flex items-center justify-center shadow-premium relative z-10 border border-slate-50">
          <font-awesome-icon icon="fa-solid fa-magnifying-glass" class="text-4xl text-slate-200" />
        </div>
        <font-awesome-icon icon="fa-solid fa-xmark" class="absolute -top-1 -right-1 text-red-500 text-xl" />
      </div>
      
      <div class="max-w-md space-y-4">
        <h3 class="text-2xl font-black text-dark tracking-tight leading-tight">No books found, unfortunately</h3>
        <p class="text-slate-500 font-medium leading-relaxed">
          We couldn't find any books matching your search. Try checking your spelling or using more general terms.
        </p>
        <div class="pt-4">
           <NuxtLink to="/" class="btn-primary !px-10 !py-3.5 !rounded-xl !text-xs !bg-slate-800 hover:!bg-dark shadow-xl shadow-slate-200">
             Return to Library
           </NuxtLink>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
  import { useDataStore } from '~/stores/dataStore';
  const dataStore = useDataStore();
</script>

<style  scoped>

</style>