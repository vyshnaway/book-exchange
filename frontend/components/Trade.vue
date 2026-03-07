<template>
  <div class="flex flex-col gap-10">
    <div v-if="books.length" class="flex flex-col gap-8">
      <div class="text-center md:text-left">
        <h2 class="text-2xl md:text-3xl font-black text-dark tracking-tight">
          {{ tradeMessage }}
        </h2>
        <p class="text-slate-500 mt-2 font-medium italic">Click a book to select it for the trade</p>
      </div>

      <!-- Books Grid -->
      <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
        <div
          v-for="book in books"
          :key="book.pk"
          class="relative group cursor-pointer"
          @click="toggleSelect(book)"
        >
          <!-- Selection Overlay/Indicator -->
          <div 
            v-if="book.selected" 
            class="absolute -inset-2 bg-primary/5 rounded-[28px] border-2 border-primary shadow-lg shadow-primary/20 z-10 pointer-events-none animate-in fade-in zoom-in-95 duration-200"
          >
            <div class="absolute -top-3 -right-3 w-8 h-8 bg-primary text-white rounded-full flex items-center justify-center shadow-lg border-4 border-white">
              <font-awesome-icon icon="fa-solid fa-check" class="text-xs" />
            </div>
          </div>

          <ProfileBookCard
            :book="book"
            class="transition-all duration-300"
            :class="book.selected ? 'scale-[0.98]' : 'hover:scale-[1.02]'"
          />
        </div>
      </div>

      <!-- Action Button -->
      <div class="flex flex-col items-center gap-4 pt-6 border-t border-slate-100">
        <div v-if="selectedBook" class="flex items-center gap-3 px-6 py-3 bg-indigo-50 rounded-2xl animate-in slide-in-from-bottom-2">
          <font-awesome-icon icon="fa-solid fa-book" class="text-primary" />
          <span class="text-sm font-bold text-dark">Selected: <span class="text-primary">{{ selectedBook.title }}</span></span>
        </div>
        
        <button
          @click="confirmChoice"
          :disabled="!selectedBook"
          class="btn-primary !px-12 !py-4 !rounded-2xl shadow-xl shadow-primary/30 transition-all disabled:opacity-30 disabled:grayscale disabled:cursor-not-allowed active:scale-95"
        >
          Confirm Book Choice
        </button>
      </div>
    </div>

    <!-- Empty State -->
    <div v-else class="flex flex-col items-center justify-center py-20 text-center gap-4">
      <div class="w-20 h-20 bg-slate-50 rounded-full flex items-center justify-center text-slate-300">
        <font-awesome-icon icon="fa-solid fa-box-open" class="text-3xl" />
      </div>
      <div>
        <h3 class="text-xl font-bold text-dark">No books available</h3>
        <p class="text-slate-500 max-w-xs mx-auto">This user doesn't have any books on their giveaway shelf yet.</p>
      </div>
    </div>
  </div>
</template>

<script setup>
  import { ref, onMounted } from 'vue';
  import { useUserStore } from '~/stores/userStore';
  import { useDataStore } from '~/stores/dataStore';
  import { useProfileStore } from '~/stores/profileStore';

  const { $toast } = useNuxtApp();
  const userStore = useUserStore();
  const profileStore = useProfileStore();
  const dataStore = useDataStore();
  
  const selectedBook = ref(null);
  const clickedBook = dataStore.clickedBook;
  const books = ref([]);
  const clickedBookShelf = clickedBook.book_shelf;
  const tradeMessage = ref('');

  onMounted(async () => {
    profileStore.userName = clickedBook.book_owner.username;
    
    if (clickedBookShelf === 'wanted') {
      await profileStore.getUserInfo();
      books.value = profileStore.userGiveAwayBooks.map(b => ({ ...b, selected: false }));
      tradeMessage.value = `Choose a book from ${profileStore.userName}'s collection`;
    } else {
      books.value = userStore.userGiveAwayBooks.map(b => ({ ...b, selected: false }));
      tradeMessage.value = 'Select one of your books to offer in exchange';
    }
  });

  function toggleSelect(book) {
    if (book.selected) {
      book.selected = false;
      selectedBook.value = null;
    } else {
      books.value.forEach(b => b.selected = false);
      book.selected = true;
      selectedBook.value = book;
    }
  }

  function confirmChoice() {
    if (!selectedBook.value) return;

    if (clickedBookShelf === 'giveaway') {
      userStore.startTransaction(selectedBook.value.pk, clickedBook.pk);
    } else {
      userStore.startTransaction(
        userStore.chosenBookForATrade.pk,
        selectedBook.value.pk
      );
    }

    $toast.success('Great choice! Transaction started.');
  }
</script>
