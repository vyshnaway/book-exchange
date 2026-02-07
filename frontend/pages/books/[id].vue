<template>
  <div v-if="book && book.title" class="max-w-7xl mx-auto px-4 py-8 md:py-16 animate-in fade-in duration-700">
    <!-- Hero / Main Book Info Section -->
    <div class="grid grid-cols-1 lg:grid-cols-2 gap-12 lg:gap-20 items-start">
      
      <!-- Gallery Column -->
      <div class="space-y-6">
        <div class="relative glass rounded-[40px] overflow-hidden shadow-premium group">
          <swiper
            :modules="swiperModules"
            :slides-per-view="1"
            :pagination="{ clickable: true }"
            navigation
            class="aspect-square md:aspect-[4/5] w-full"
          >
            <swiper-slide v-for="(image, index) in book.images" :key="index" class="flex items-center justify-center p-8 bg-white/40">
              <img
                :src="image"
                alt="Book image"
                class="w-full h-full object-contain drop-shadow-2xl cursor-zoom-in group-hover:scale-[1.02] transition-transform duration-700"
                @click="openModal(image)"
              />
            </swiper-slide>
          </swiper>

          <!-- Floating Category Badge -->
          <div class="absolute top-6 left-6 z-10">
            <span class="px-4 py-2 bg-primary/20 backdrop-blur-md rounded-full text-primary text-[10px] font-black uppercase tracking-widest border border-white/40 shadow-lg">
              {{ book.category?.[0] || 'Library' }}
            </span>
          </div>
        </div>

        <!-- Thumbnail Indicator (Conceptual) -->
        <div class="flex justify-center gap-3">
          <div v-for="n in book.images.length" :key="n" class="w-2 h-2 rounded-full bg-slate-200"></div>
        </div>
      </div>

      <!-- Content Column -->
      <div class="flex flex-col gap-10">
        <div class="space-y-4">
          <div class="flex items-center gap-2 text-primary font-black text-xs uppercase tracking-[0.3em]">
             <font-awesome-icon icon="fa-solid fa-book-open" />
             <span>{{ book.condition }} Condition</span>
          </div>
          <h1 class="text-4xl md:text-6xl font-black text-dark tracking-tight leading-tight">
            {{ book.title }}
          </h1>
          <div class="flex flex-wrap items-center gap-4 pt-2">
            <p class="text-xl md:text-2xl text-slate-500 font-medium italic">
              By <span class="text-primary font-bold not-italic">{{ book.author.join(', ') }}</span>
            </p>
            <span class="w-1.5 h-1.5 rounded-full bg-slate-300 hidden md:block"></span>
            <span class="px-3 py-1 bg-slate-100 rounded-lg text-xs font-bold text-slate-500 uppercase tracking-widest">{{ book.language }}</span>
          </div>
        </div>

        <!-- Metadata Grid -->
        <div class="grid grid-cols-2 md:grid-cols-3 gap-6 p-8 bg-slate-50/50 rounded-3xl border border-slate-100">
          <div class="flex flex-col gap-1">
            <span class="text-[10px] font-black text-slate-400 uppercase tracking-widest">Shelf</span>
            <span class="font-bold text-dark capitalize">{{ book.book_shelf }}</span>
          </div>
          <div class="flex flex-col gap-1">
            <span class="text-[10px] font-black text-slate-400 uppercase tracking-widest">Quality</span>
            <span class="font-bold text-emerald-600">{{ book.condition }}</span>
          </div>
          <div class="flex flex-col gap-1 col-span-2 md:col-span-1">
            <span class="text-[10px] font-black text-slate-400 uppercase tracking-widest">Tags</span>
            <div class="flex flex-wrap gap-1.5 mt-1">
              <span v-for="cat in book.category" :key="cat" class="px-2.5 py-1 bg-white text-[10px] font-bold text-slate-500 rounded-md border border-slate-100">{{ cat }}</span>
            </div>
          </div>
        </div>

        <div class="space-y-4">
          <h3 class="text-xl font-bold text-dark tracking-tight">From the Back Cover</h3>
          <p class="text-lg text-slate-600 leading-relaxed font-medium">
            {{ book.description }}
          </p>
        </div>

        <!-- Actions / Owner -->
        <div class="pt-8 border-t border-slate-100 flex flex-col sm:flex-row items-center justify-between gap-8">
          <NuxtLink
            v-if="username !== book.book_owner.username"
            :to="`/profile/${book.book_owner.username.replaceAll(' ', '-')}`"
            class="flex items-center gap-4 group hover:bg-slate-50 p-2 rounded-2xl transition-all"
          >
            <div class="relative">
              <img
                :src="book.book_owner.profile_image || avatarPlaceholder"
                class="w-14 h-14 rounded-full object-cover border-4 border-white shadow-md ring-1 ring-slate-100"
              />
              <div class="absolute -bottom-1 -right-1 w-4 h-4 bg-emerald-500 border-2 border-white rounded-full"></div>
            </div>
            <div>
              <p class="text-[10px] font-black text-slate-400 uppercase tracking-widest">Owner</p>
              <div class="flex flex-col">
                <p class="text-lg font-bold text-dark group-hover:text-primary transition-colors">
                  {{ book.book_owner.username }}
                </p>
                <div class="flex items-center gap-1.5 text-slate-400">
                  <font-awesome-icon icon="fa-solid fa-location-dot" class="text-xs" />
                  <span class="text-xs font-bold">{{ getCountryName(book.book_owner.country) }}</span>
                </div>
              </div>
            </div>
          </NuxtLink>

          <div v-if="userStore.userIsLoggedIn && userCanTradeBook && username !== book.book_owner.username" class="w-full sm:w-auto">
             <button
              @click="setShowTrade"
              class="btn-primary w-full sm:w-auto !px-12 !py-4 !rounded-2xl shadow-xl shadow-primary/30 flex items-center justify-center gap-3 active:scale-95 transition-all"
            >
              <font-awesome-icon icon="fa-solid fa-right-left" />
              Propose Exchange
            </button>
          </div>

          <!-- Management Actions for Owner -->
          <div v-if="username === book.book_owner.username" class="flex items-center gap-3 w-full sm:w-auto">
            <NuxtLink
              :to="`/user/addbook?edit=${book.pk}`"
              class="flex-1 sm:flex-none text-xs font-black uppercase tracking-widest text-slate-400 hover:text-primary transition-colors flex items-center justify-center gap-2 px-6 py-4 rounded-2xl border border-slate-100 hover:bg-primary/5"
            >
              <font-awesome-icon icon="fa-solid fa-pen-to-square" />
              <span>Edit Book</span>
            </NuxtLink>
            <button
              @click="deleteBook"
              class="flex-1 sm:flex-none text-xs font-black uppercase tracking-widest text-slate-400 hover:text-red-500 transition-colors flex items-center justify-center gap-2 px-6 py-4 rounded-2xl border border-slate-100 hover:bg-red-50"
            >
              <font-awesome-icon icon="fa-solid fa-trash-can" />
              <span>Remove</span>
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- Trade Reveal -->
    <div v-if="showTrade" class="mt-20 pt-20 border-t border-slate-100" ref="tradeSection">
      <LazyTrade />
    </div>

    <!-- Image Lighting Modal -->
    <transition
      enter-active-class="transition duration-300 ease-out"
      enter-from-class="opacity-0 backdrop-blur-0"
      enter-to-class="opacity-100 backdrop-blur-xl"
      leave-active-class="transition duration-200 ease-in"
      leave-from-class="opacity-100 backdrop-blur-xl"
      leave-to-class="opacity-0 backdrop-blur-0"
    >
      <div v-if="showModal" class="fixed inset-0 z-[200] flex items-center justify-center p-4 bg-black/80 backdrop-blur-md" @click="showModal = false">
        <button class="absolute top-8 right-8 text-white/50 hover:text-white transition-colors">
          <font-awesome-icon icon="fa-solid fa-xmark" class="text-4xl" />
        </button>
        <img :src="modalImage" class="max-w-full max-h-[90vh] object-contain drop-shadow-2xl rounded-lg animate-in zoom-in-95 duration-300 shadow-2xl border-4 border-white/10" />
      </div>
    </transition>
  </div>
</template>

<script setup>
  import { ref, onMounted, computed } from 'vue';
  import { Navigation, Pagination, A11y } from 'swiper';
  import { Swiper, SwiperSlide } from 'swiper/vue';
  import { useDataStore } from '~/stores/dataStore';
  import { useUserStore } from '~/stores/userStore';
  import avatarPlaceholder from '~/assets/img/avatar.png';
  import { getName } from 'country-list';

  // Swiper styles
  import 'swiper/css';
  import 'swiper/css/navigation';
  import 'swiper/css/pagination';

  const store = useDataStore();
  const userStore = useUserStore();
  const book = computed(() => store.clickedBook);
  const username = computed(() => userStore.userName);
  const { $toast } = useNuxtApp();

  const showModal = ref(false);
  const showTrade = ref(false);
  const modalImage = ref('');
  const userCanTradeBook = ref(false);
  const swiperModules = [Navigation, Pagination, A11y];

  const tradeSection = ref(null);

  function getCountryName(code) {
    if (!code) return 'Unknown';
    return getName(code) || code;
  }

  function openModal(image) {
    modalImage.value = image;
    showModal.value = true;
  }

  function setShowTrade() {
    showTrade.value = true;
    setTimeout(() => {
      tradeSection.value?.scrollIntoView({ behavior: 'smooth' });
    }, 100);
  }

  async function deleteBook() {
    if (confirm(`Are you sure you want to remove "${book.value.title}"?`)) {
      try {
        await userStore.deleteBook(book.value);
        $toast.success('Book removed successfully');
        await navigateTo('/profile');
      } catch (error) {
        console.error('Deletion error:', error);
        $toast.error('Failed to delete book. Please try again.');
      }
    }
  }

  const route = useRoute();

  onMounted(async () => {
    // If book data is missing (e.g. page refresh), try to find it
    if (!book.value || !book.value.title) {
        // Ensure we have the latest data
        if (store.giveAwayBooks.length === 0 && store.wantedBooks.length === 0) {
            await store.updateData();
        }

        const paramId = route.params.id;
        // Search in both lists
        const allBooks = [...store.giveAwayBooks, ...store.wantedBooks];
        // Match logic: title in URL matches book.title (handling / vs - replacement)
        const foundBook = allBooks.find(b => b.title.replaceAll('/', '-') === paramId || b.title === paramId);
        
        if (foundBook) {
            store.setClickedBook(foundBook);
        }
    }

    if (!book.value || !book.value.title) return; // Still no book found

    if (book.value.book_shelf === "wanted") {
      const match = userStore.userGiveAwayBooks.find(b => b.title === book.value.title);
      if (match) {
        userStore.chosenBookForATrade = match;
        userCanTradeBook.value = true;
      }
    } else {
      userCanTradeBook.value = true;
    }
  });
</script>
