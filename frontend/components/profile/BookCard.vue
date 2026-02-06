<template>
  <div class="card-premium h-full min-h-[320px] group">
    <div class="p-3 h-full flex flex-col gap-4">
      <!-- Image Container -->
      <div class="relative overflow-hidden rounded-xl aspect-[3/4] shadow-sm">
        <img
          v-if="book.images && book.images.length > 0"
          :src="book.images.at(0)"
          :alt="book.title"
          class="w-full h-full object-cover transition-transform duration-500 group-hover:scale-110"
        />
        <div v-else class="w-full h-full bg-slate-100 flex items-center justify-center text-slate-300">
           <font-awesome-icon icon="fa-solid fa-book-open" class="text-4xl" />
        </div>
        
        <!-- Subtle Overlay -->
        <div class="absolute inset-0 bg-gradient-to-t from-black/20 via-transparent to-transparent opacity-0 group-hover:opacity-100 transition-opacity"></div>
      </div>

      <!-- Book Info -->
      <div class="flex-grow flex flex-col justify-between pt-1">
        <h4 class="text-dark font-bold text-sm leading-snug line-clamp-2 group-hover:text-primary transition-colors">
          {{ book.title }}
        </h4>
        
        <div class="flex items-center justify-between mt-3 pt-3 border-t border-slate-50">
          <span class="text-[10px] font-black uppercase tracking-widest text-slate-400">
            {{ book.book_shelf || 'Library' }}
          </span>
          <div class="w-2 h-2 rounded-full bg-emerald-400 shadow-sm shadow-emerald-200"></div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
const { book } = defineProps(["book"]);
</script>
