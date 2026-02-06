<template>
  <div class="card-premium h-full flex flex-col group">
    <!-- Book Image & Link -->
    <NuxtLink
      @click="dataStore.setClickedBook(book)"
      :to="`/books/${book.title.replaceAll('/', '-')}`"
      class="relative aspect-[3/4] overflow-hidden"
    >
      <img
        v-if="book.images?.length > 0"
        :src="book.images[0]"
        :alt="book.title"
        class="w-full h-full object-cover transition-transform duration-500 group-hover:scale-110"
        @error="$event.target.src = '/_nuxt/assets/img/book-placeholder.png'"
      />
      <img
        v-else
        src="~/assets/img/book-placeholder.png"
        :alt="book.title"
        class="w-full h-full object-cover transition-transform duration-500 group-hover:scale-110"
      />
      
      <!-- Condition Badge -->
      <div v-if="book.condition" class="absolute top-4 left-4">
        <span class="px-3 py-1 bg-white/90 backdrop-blur-sm text-[10px] font-bold uppercase tracking-widest text-primary rounded-full shadow-sm">
          {{ book.condition }}
        </span>
      </div>
    </NuxtLink>

    <!-- Card Content -->
    <div class="p-5 flex flex-col flex-grow gap-2">
      <div class="flex-grow">
        <h4 class="font-bold text-lg leading-tight text-dark group-hover:text-primary transition-colors line-clamp-2">
          {{ book.title }}
        </h4>
        <p v-if="book.author" class="text-xs font-medium text-slate-400 mt-1">
          by {{ book.author }}
        </p>
      </div>

      <!-- Owner Info -->
      <div class="flex items-center justify-between mt-4 pt-4 border-t border-slate-50">
        <NuxtLink 
          :to="`/profile/${book.book_owner.username.replaceAll(' ', '-')}`"
          class="flex items-center gap-3 group/owner min-w-0"
        >
          <img
            :src="book.book_owner.profile_image || avatarPlaceholder"
            :alt="book.book_owner.username"
            class="w-8 h-8 rounded-full object-cover border-2 border-white ring-1 ring-slate-100 shadow-sm shrink-0"
          />
          <div class="flex flex-col min-w-0">
            <span class="text-sm font-semibold text-slate-600 group-hover/owner:text-primary transition-colors truncate">
              {{ book.book_owner.username }}
            </span>
            <span class="text-[10px] font-medium text-slate-400 flex items-center gap-1 truncate">
              <font-awesome-icon icon="fa-solid fa-location-dot" class="text-[9px]" />
              {{ getCountryName(book.book_owner.country) }}
            </span>
          </div>
        </NuxtLink>
        
        <!-- Shelf Badge -->
        <span class="shrink-0 text-[10px] font-bold text-indigo-500 bg-indigo-50 px-2 py-1 rounded-lg ml-2">
          {{ book.shelf || 'Giveaway' }}
        </span>
      </div>
    </div>
  </div>
</template>

<script setup>
import { useUserStore } from "~/stores/userStore";
import { useDataStore } from "~/stores/dataStore";
import avatarPlaceholder from "~/assets/img/avatar.png";
import { getName } from 'country-list';

const { book } = defineProps(["book"]);
const store = useUserStore();
const dataStore = useDataStore();

function getCountryName(code) {
  if (!code) return 'Unknown';
  return getName(code) || code;
}
</script>
