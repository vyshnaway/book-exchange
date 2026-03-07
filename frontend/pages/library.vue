<template>
  <div class="flex flex-col gap-8 pb-20">
    <!-- Filter Bar with Search -->
    <div class="sticky top-24 z-20 bg-white/80 backdrop-blur-md p-4 rounded-2xl shadow-sm border border-white/20 flex flex-col justify-between items-stretch gap-4 transition-all">
      
      <!-- Search Input -->
      <div class="flex items-center gap-3 flex-1">
        <div class="bg-indigo-50 p-2 rounded-lg text-indigo-500">
          <font-awesome-icon icon="fa-solid fa-magnifying-glass" />
        </div>
        <div class="flex flex-col flex-1">
          <label class="text-[10px] font-bold uppercase tracking-widest text-slate-400">Search Books</label>
          <input 
            v-model="searchQuery"
            @input="onSearchChange"
            type="text"
            placeholder="Search by title..."
            class="bg-transparent font-bold text-slate-700 outline-none w-full"
          />
        </div>
      </div>

      <div class="flex items-center gap-3 justify-between">
        <!-- Location Filter -->
        <div class="flex items-center gap-3">
          <div class="bg-indigo-50 p-2 rounded-lg text-indigo-500">
            <font-awesome-icon icon="fa-solid fa-location-dot" />
          </div>
          <div class="flex flex-col">
            <label class="text-[10px] font-bold uppercase tracking-widest text-slate-400">Browsing In</label>
            <select 
              v-model="selectedCountry" 
              @change="onCountryChange" 
              class="bg-transparent font-bold text-slate-700 outline-none cursor-pointer min-w-[150px]"
            >
              <option value="">[World]</option>
              <option v-for="country in countries" :key="country" :value="country">
                {{ country }}
              </option>
            </select>
          </div>
        </div>

        <!-- Show/Hide Own Books Toggle -->
        <div v-if="userStore.userIsLoggedIn" class="flex items-center gap-3 bg-slate-50 px-4 py-2 rounded-xl">
          <span class="text-sm font-medium text-slate-600">Show My Books</span>
          <label class="relative inline-flex items-center cursor-pointer">
            <input type="checkbox" v-model="showOwnBooks" @change="onShowOwnBooksChange" class="sr-only peer">
            <div class="w-11 h-6 bg-slate-200 peer-focus:outline-none peer-focus:ring-4 peer-focus:ring-indigo-300 rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-indigo-600"></div>
          </label>
        </div>
      </div>
      
    </div>

    <!-- Tab Navigation -->
    <div class="flex gap-2 px-4 border-b border-slate-200">
      <button
        @click="activeTab = 'public'"
        :class="[
          'px-6 py-3 font-bold text-sm transition-all relative',
          activeTab === 'public' 
            ? 'text-primary border-b-2 border-primary' 
            : 'text-slate-500 hover:text-slate-700'
        ]"
      >
        Public Shelf
      </button>
      <button
        @click="activeTab = 'wanted'"
        :class="[
          'px-6 py-3 font-bold text-sm transition-all relative',
          activeTab === 'wanted' 
            ? 'text-primary border-b-2 border-primary' 
            : 'text-slate-500 hover:text-slate-700'
        ]"
      >
        Wanted Shelf
      </button>
    </div>

    <!-- Public Shelf (Offered Books) -->
    <section v-show="activeTab === 'public'" class="flex flex-col gap-8">
      <div class="flex flex-col md:flex-row justify-between gap-4 px-4">
        <div>
          <h2 class="text-3xl font-bold text-dark tracking-tight">
            Public Shelf
          </h2>
          <p class="text-slate-500 mt-2 font-medium">Discover stories waiting for a new home.</p>
        </div>
      </div>

      <!-- Books Grid -->
      <div v-if="filteredGiveawayBooks.length > 0" class="flex flex-col gap-12">
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 xl:grid-cols-5 gap-8 px-4">
          <BookCard
            v-for="book in loadedGiveawayBooks"
            :key="book.pk"
            :book="book"
          />
        </div>

        <!-- Load More -->
        <button 
          v-if="filteredGiveawayBooks.length > giveawayBooksEnd"
          @click="showMoreGiveawayBooks"
          class="btn-outline self-center"
        >
          Explore More Offers
        </button>
      </div>

      <!-- Empty State -->
      <div v-else class="flex flex-col items-center justify-center py-20 bg-slate-50 rounded-3xl mx-4">
        <div class="w-16 h-16 bg-slate-100 rounded-full flex items-center justify-center text-slate-400 mb-4">
          <font-awesome-icon icon="fa-solid fa-face-sad-tear" class="text-2xl" />
        </div>
        <p class="text-slate-600 font-semibold text-lg">No books found.</p>
        <p class="text-slate-400 text-sm">Try adjusting your filters or be the first to offer a book!</p>
      </div>
    </section>

    <!-- Wanted Shelf (Wanted Books) -->
    <section v-show="activeTab === 'wanted'" class="flex flex-col gap-8">
      <div class="flex flex-col md:flex-row justify-between gap-4 px-4">
        <div>
          <h2 class="text-3xl font-bold text-dark tracking-tight">
            Wanted Shelf
          </h2>
          <p class="text-slate-500 mt-2 font-medium">Have these? Start an exchange today.</p>
        </div>
      </div>

      <div v-if="filteredWantedBooks.length > 0" class="flex flex-col gap-12">
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 xl:grid-cols-5 gap-8 px-4">
          <BookCard
            v-for="book in loadedWantedBooks"
            :key="book.pk"
            :book="book"
          />
        </div>

        <button 
          v-if="filteredWantedBooks.length > wantedBooksEnd"
          @click="showMoreWantedBooks"
          class="btn-outline self-center"
        >
          See More Requests
        </button>
      </div>

      <!-- Empty State -->
      <div v-else class="flex flex-col items-center justify-center py-20 bg-slate-50 rounded-3xl mx-4">
        <div class="w-16 h-16 bg-slate-100 rounded-full flex items-center justify-center text-slate-400 mb-4">
          <font-awesome-icon icon="fa-solid fa-magnifying-glass" class="text-2xl" />
        </div>
        <p class="text-slate-600 font-semibold text-lg">No one is searching for books right now.</p>
        <p class="text-slate-400 text-sm">Check back later or add your own wishlist!</p>
      </div>
    </section>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue';
import { useUserStore } from '~/stores/userStore';
import { useDataStore } from '~/stores/dataStore';
import { useCountryStore } from '~/stores/countryStore';

const userStore = useUserStore();
const dataStore = useDataStore();
const countryStore = useCountryStore();

const countries = countryStore.getAllCountries();
const selectedCountry = ref(''); // Default to "World"
const showOwnBooks = ref(false); // Default to hiding own books
const searchQuery = ref('');
const activeTab = ref('public'); // Default to Public Shelf

// Pagination
const giveawayBooksEnd = ref(20);
const wantedBooksEnd = ref(20);

// Initial Data Load - respect filter state
await dataStore.getWantedBooksFromDB(null, showOwnBooks.value);
await dataStore.getOfferedBooksFromDB(null, showOwnBooks.value);

// Filtered books based on search query
const filteredGiveawayBooks = computed(() => {
  if (!searchQuery.value.trim()) {
    return dataStore.giveAwayBooks;
  }
  return dataStore.giveAwayBooks.filter(book => 
    book.title.toLowerCase().includes(searchQuery.value.toLowerCase())
  );
});

const filteredWantedBooks = computed(() => {
  if (!searchQuery.value.trim()) {
    return dataStore.wantedBooks;
  }
  return dataStore.wantedBooks.filter(book => 
    book.title.toLowerCase().includes(searchQuery.value.toLowerCase())
  );
});

// Loaded books for pagination
const loadedGiveawayBooks = computed(() => {
  return filteredGiveawayBooks.value.slice(0, giveawayBooksEnd.value);
});

const loadedWantedBooks = computed(() => {
  return filteredWantedBooks.value.slice(0, wantedBooksEnd.value);
});

// Filter functions
async function onCountryChange(event) {
  const countryName = event.target.value;
  
  // Pass country name directly (empty string for "World")
  await dataStore.getWantedBooksFromDB(countryName || null, showOwnBooks.value);
  await dataStore.getOfferedBooksFromDB(countryName || null, showOwnBooks.value);
}

async function onShowOwnBooksChange() {
  // Pass the selected country name directly (empty string becomes null for "World")
  const countryName = selectedCountry.value || null;
  
  await dataStore.getWantedBooksFromDB(countryName, showOwnBooks.value);
  await dataStore.getOfferedBooksFromDB(countryName, showOwnBooks.value);
}

function onSearchChange() {
  // Search is handled by computed properties, no need to refetch
  // Reset pagination when search changes
  giveawayBooksEnd.value = 20;
  wantedBooksEnd.value = 20;
}

function showMoreGiveawayBooks() {
  giveawayBooksEnd.value += 20;
}

function showMoreWantedBooks() {
  wantedBooksEnd.value += 20;
}
</script>
