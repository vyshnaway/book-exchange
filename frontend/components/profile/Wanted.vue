<template>
  <div class="flex flex-col gap-8 w-full">
    <!-- Shelf Header -->
    <div class="flex flex-col sm:flex-row justify-between items-end sm:items-center gap-4 border-b border-slate-100 pb-6">
      <div>
        <h2 class="text-2xl font-black text-dark tracking-tight">
          {{ route.id ? `${store.userName}'s Wishlist` : 'My Wanted Shelf' }}
        </h2>
        <p class="text-slate-500 text-sm font-medium mt-1">
          Books you're looking to acquire or exchange for
        </p>
      </div>
      
      <NuxtLink
        v-if="!route.id"
        to="/user/addbook"
        class="btn-primary !py-2.5 !px-5 !text-xs !rounded-xl shadow-lg shadow-primary/20 flex items-center gap-2 group"
      >
        <font-awesome-icon icon="fa-solid fa-plus" class="group-hover:rotate-90 transition-transform" />
        <span>Add Book</span>
      </NuxtLink>
    </div>

    <!-- Books Grid -->
    <div v-if="store.userWantedBooks.length" class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5 gap-6">
      <div
        v-for="book in store.userWantedBooks"
        :key="book.pk"
        class="flex flex-col gap-4 animate-in fade-in zoom-in-95 duration-300"
      >
        <NuxtLink
          @click="dataStore.setClickedBook(book)"
          :to="`/books/${book.title.replaceAll('/', '-')}`"
          class="block h-full"
        >
          <ProfileBookCard :book="book" />
        </NuxtLink>
        
        <div v-if="!route.id" class="flex justify-center">
          <button
            @click="deleteBook(book)"
            class="text-[10px] font-black uppercase tracking-widest text-slate-300 hover:text-red-500 transition-colors flex items-center gap-2 px-3 py-1.5 rounded-lg hover:bg-red-50"
          >
            <font-awesome-icon icon="fa-solid fa-trash-can" />
            <span>Remove</span>
          </button>
        </div>
      </div>
    </div>

    <!-- Empty State -->
    <div v-else class="py-20">
      <LazyProfilePlaceHolder />
    </div>
  </div>
</template>

<script setup>
  import { useUserStore } from '~/stores/userStore';
  import { useProfileStore } from '~/stores/profileStore';
  import { useDataStore } from '~/stores/dataStore';
  
  const route = useRoute().params;
  const store = !route.id ? useUserStore() : useProfileStore();
  const dataStore = useDataStore();

  function deleteBook(book) {
    if (confirm(`Are you sure you want to remove "${book.title}" from your wishlist?`)) {
      store.deleteBook(book);
    }
  }
</script>

<style scoped></style>
