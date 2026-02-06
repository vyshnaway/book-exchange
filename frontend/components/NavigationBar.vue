<template>
  <nav class="flex items-center justify-between w-full h-16">
    <!-- Logo -->
    <NuxtLink to="/" class="flex items-center gap-3 active:scale-95 transition-transform">
      <AppLogo class="w-8 h-8" />
      <span class="font-bold text-2xl tracking-tight text-primary">Boookz</span>
    </NuxtLink>

    <!-- Right Side Actions -->
    <div class="flex items-center gap-2 lg:gap-6">
      <!-- Desktop Search -->
      <form @submit.prevent="search" class="relative group hidden lg:block">
        <input
          v-model="searchQuery"
          placeholder="Search offered books..."
          type="text"
          class="w-64 px-5 py-2 bg-slate-100/50 border-none rounded-2xl focus:w-80 focus:bg-white focus:ring-2 focus:ring-primary/20 outline-none transition-all duration-300 italic text-sm"
        />
        <button class="absolute right-4 top-1/2 -translate-y-1/2 opacity-40 group-focus-within:opacity-100 transition-opacity" type="submit">
          <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/></svg>
        </button>
      </form>

      <!-- Mobile Menu Button (Visible only on mobile, mainly for Search now) -->
      <button @click="isMenuOpen = !isMenuOpen" class="lg:hidden p-2 text-slate-600 hover:bg-slate-100 rounded-full transition-colors mr-1 w-10 h-10 flex items-center justify-center">
        <svg v-if="!isMenuOpen" class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/></svg>
        <svg v-else class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/></svg>
      </button>

      <!-- Auth Action (Always Visible) -->
      <div v-if="!userStore.userIsLoggedIn" class="flex items-center gap-2 lg:gap-6">
        <NuxtLink to="/signin" class="text-sm font-semibold text-slate-600 hover:text-indigo-600 transition-colors hidden sm:block">Sign in</NuxtLink>
        <NuxtLink to="/register" class="btn-primary !py-2 !px-4 !text-xs sm:!text-sm !rounded-xl">Sign up</NuxtLink>
      </div>

      <!-- User Menu (Always Visible) -->
      <div v-else class="flex items-center gap-2 lg:gap-4">
        <ProfileNotificationMenu />
        <ProfileSettingMenu />
      </div>
    </div>

    <!-- Mobile Menu Overlay -->
    <Transition name="fade">
      <div v-if="isMenuOpen" class="fixed inset-0 top-16 z-40 lg:hidden px-4 py-12 backdrop-blur-sm" @click.self="isMenuOpen = false">
        <div class="bg-white/95 backdrop-blur-xl border border-white/20 shadow-2xl rounded-3xl p-6 flex flex-col gap-6 animate-in slide-in-from-top-4 duration-300">
          <form @submit.prevent="search" class="relative group">
            <input
              v-model="searchQuery"
              placeholder="Search books..."
              type="text"
              class="w-full px-5 py-3 bg-slate-100 rounded-2xl outline-none focus:ring-2 focus:ring-primary/20 transition-all"
            />
            <button class="absolute right-4 top-1/2 -translate-y-1/2 text-slate-400" type="submit">
               <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/></svg>
            </button>
          </form>
          
          <div v-if="!userStore.userIsLoggedIn" class="sm:hidden flex flex-col gap-3 pt-2 border-t border-slate-100">
             <p class="text-xs font-bold uppercase text-slate-400 tracking-widest text-center mb-2">Account</p>
             <NuxtLink to="/signin" @click="isMenuOpen = false" class="btn-outline w-full justify-center !border-slate-200 !text-slate-600">Sign in</NuxtLink>
          </div>
        </div>
      </div>
    </Transition>
  </nav>
</template>

<script setup>
import { ref } from 'vue';
import { useUserStore } from '~/stores/userStore';
import { useDataStore } from '~/stores/dataStore';

const userStore = useUserStore();
const dataStore = useDataStore();

const isMenuOpen = ref(false);
const searchQuery = ref('');

const search = () => {
  if (!searchQuery.value.trim()) return;
  dataStore.searchForBook(searchQuery.value);
  searchQuery.value = '';
  isMenuOpen.value = false;
};
</script>

<style scoped>
.fade-enter-active, .fade-leave-active { transition: opacity 0.2s ease; }
.fade-enter-from, .fade-leave-to { opacity: 0; }
</style>
