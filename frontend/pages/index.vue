<template>
  <div class="flex flex-col gap-10 pb-20">
    <!-- Filter Bar -->
    <div class="sticky top-24 z-20 bg-white/80 backdrop-blur-md p-4 rounded-2xl shadow-sm border border-white/20 flex flex-row justify-between items-center gap-4 transition-all">
      
      <!-- Location Filter -->
      <div class="flex items-center gap-3 w-full md:w-auto">
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
            <option value="">World</option>
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

    <!-- Hero Section Removed -->

    <!-- Offered Books Section -->
    <section class="flex flex-col gap-8">
      <div class="flex flex-col md:flex-row justify-between gap-4 px-4">
        <div>
           <h2 class="text-3xl font-bold text-dark tracking-tight">
             Featured Books
           </h2>
          <p class="text-slate-500 mt-2 font-medium">Discover stories waiting for a new home.</p>
        </div>
      </div>

      <!-- Books Grid -->
      <div v-if="dataStore.giveAwayBooks.length > 0" class="flex flex-col gap-12">
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 xl:grid-cols-5 gap-8 px-4">
          <BookCard
            v-for="book in loadedGiveawayBooks"
            :key="book.pk"
            :book="book"
          />
        </div>

        <!-- Load More -->
        <button 
          v-if="dataStore.giveAwayBooks.length > giveawayBooksEnd"
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
        <p class="text-slate-600 font-semibold text-lg">No books found in your area yet.</p>
        <p class="text-slate-400 text-sm">Be the first to offer a book!</p>
      </div>
    </section>

    <!-- Wanted Books Section -->
    <section class="flex flex-col gap-8">
      <div class="flex flex-col md:flex-row justify-between gap-4 px-4">
        <div>
          <h2 class="text-3xl font-bold text-dark tracking-tight">
            {{ userStore.userIsLoggedIn ? 'Books People are Searching For' : 'Wanted Books' }}
          </h2>
          <p class="text-slate-500 mt-2 font-medium">Have these? Start an exchange today.</p>
        </div>
      </div>

      <div v-if="dataStore.wantedBooks.length > 0" class="flex flex-col gap-12">
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 xl:grid-cols-5 gap-8 px-4">
          <BookCard
            v-for="book in loadedWantedBooks"
            :key="book.pk"
            :book="book"
          />
        </div>

        <button 
          v-if="dataStore.wantedBooks.length > wantedBooksEnd"
          @click="showMoreWantedBooks"
          class="btn-outline self-center"
        >
          See All Wanted Books
        </button>
      </div>

      <div v-else class="flex flex-col items-center justify-center py-20 bg-slate-50 rounded-3xl mx-4">
        <div class="w-16 h-16 bg-slate-100 rounded-full flex items-center justify-center text-slate-400 mb-4">
          <font-awesome-icon icon="fa-solid fa-face-sad-tear" class="text-2xl" />
        </div>
        <p class="text-slate-600 font-semibold text-lg">No one is searching for books right now.</p>
      </div>
    </section>
  </div>
</template>

<script setup>
import { useDataStore } from '~/stores/dataStore';
import { useUserStore } from '~/stores/userStore';
import { useCountryStore } from '~/stores/countryStore';
import { ref, computed, onMounted } from 'vue';

const dataStore = useDataStore();
const userStore = useUserStore();
const countryStore = useCountryStore();

const countries = countryStore.getAllCountries();
const selectedCountry = ref('');
const showOwnBooks = ref(true);

// Initial Data Load
await dataStore.getWantedBooksFromDB();
await dataStore.getOfferedBooksFromDB();

// Removed auto-selection of user's region to default to 'World'
// onMounted(() => {
//   if (userStore.userIsLoggedIn && userStore.region) {
//     countryStore.setCountryByCode(userStore.region);
//     selectedCountry.value = countryStore.chosenCountryName;
//   }
// });

const giveawayBooksEnd = ref(10);
const wantedBooksEnd = ref(10);

const loadedGiveawayBooks = computed(() => {
  return dataStore.giveAwayBooks.slice(0, giveawayBooksEnd.value);
});

const loadedWantedBooks = computed(() => {
  return dataStore.wantedBooks.slice(0, wantedBooksEnd.value);
});

function showMoreGiveawayBooks() {
  giveawayBooksEnd.value += 10;
}

function showMoreWantedBooks() {
  wantedBooksEnd.value += 10;
}

async function onCountryChange(event) {
  const countryName = event.target.value;
  countryStore.chooseCountry(countryName);
  const code = countryStore.chosenCountryCode;
  
  await dataStore.getWantedBooksFromDB(code, showOwnBooks.value);
  await dataStore.getOfferedBooksFromDB(code, showOwnBooks.value);
}

async function onShowOwnBooksChange() {
  const code = countryStore.chosenCountryCode;
  await dataStore.getWantedBooksFromDB(code, showOwnBooks.value);
  await dataStore.getOfferedBooksFromDB(code, showOwnBooks.value);
}
</script>
