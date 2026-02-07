<template>
  <div class="relative overflow-hidden rounded-[40px] shadow-premium">
    <!-- Background Design Elements -->
    <div class="absolute inset-0 bg-gradient-to-br from-indigo-600 to-purple-700"></div>
    <div class="absolute top-0 right-0 w-96 h-96 bg-white/10 rounded-full -translate-y-1/2 translate-x-1/2 blur-3xl"></div>
    <div class="absolute bottom-0 left-0 w-64 h-64 bg-purple-500/20 rounded-full translate-y-1/2 -translate-x-1/2 blur-2xl"></div>

    <div class="relative p-8 md:p-12 lg:p-16 flex flex-col items-center gap-10">
      <div class="self-start">
        <span class="px-4 py-2 bg-white/20 backdrop-blur-md rounded-full text-indigo-100 text-xs font-bold uppercase tracking-widest shadow-lg border border-white/10">
          # Suggested for You
        </span>
      </div>

      <div class="flex flex-col lg:flex-row items-center justify-between gap-12 w-full">
        <!-- Book Cover with Premium Shadow -->
        <div class="relative group perspective-1000">
          <NuxtLink
            :to="`/books/${book.title}`"
            @click="store.setClickedBook(book)"
            class="block transition-transform duration-500 transform-gpu group-hover:rotate-y-12"
          >
            <div class="relative overflow-hidden rounded-2xl shadow-2xl border-4 border-white/10">
               <img
                v-if="book.images"
                class="w-full min-w-[200px] max-w-[280px] h-auto object-cover transition-transform duration-700 group-hover:scale-110"
                :src="book.images.at(0)"
                alt="Book cover"
              />
              <div class="absolute inset-0 bg-black/20 group-hover:bg-transparent transition-colors"></div>
            </div>
          </NuxtLink>
        </div>

        <!-- Book Info -->
        <div class="flex flex-col gap-6 flex-1 text-center lg:text-left">
          <div class="space-y-2">
            <h3 class="text-4xl md:text-5xl font-black text-white tracking-tight leading-tight">
              {{ book.title }}
            </h3>
            <div class="flex flex-wrap justify-center lg:justify-start items-center gap-2">
              <span class="text-indigo-200 font-medium">By</span>
              <span 
                v-for="(author, index) in book.author" 
                :key="author" 
                class="text-white font-bold"
              >
                {{ author }}{{ index < book.author.length - 1 ? ',' : '' }}
              </span>
            </div>
          </div>

          <p class="text-indigo-100/90 text-lg md:text-xl font-medium leading-relaxed max-w-2xl line-clamp-3 italic">
            "{{ book.description }}"
          </p>

          <div class="pt-4 flex flex-wrap justify-center lg:justify-start gap-4">
            <NuxtLink :to="`/books/${book.title}`" @click="store.setClickedBook(book)" class="btn-light !bg-white !text-indigo-600 !px-8 !py-4 !text-base !font-black !rounded-2xl transition-all hover:scale-105 active:scale-95 shadow-xl">
              Explore Now
            </NuxtLink>
            <button class="btn-outline !border-white/30 !text-white !px-8 !py-4 hover:!bg-white/10 !rounded-2xl">
              Add to Wishlist
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
  import { useDataStore } from '~/stores/dataStore';
  const store = useDataStore();

  const { book } = defineProps(['book']);
</script>

<style scoped>
.perspective-1000 {
  perspective: 1000px;
}
.rotate-y-12 {
  transform: rotateY(-12deg);
}
</style>
