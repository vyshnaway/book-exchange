<template>
  <nav class="flex items-center justify-between w-full h-16 relative">
    <!-- Left Side: Logo & Navigation -->
    <div class="flex items-center gap-10">
      <!-- Logo -->
      <NuxtLink to="/" class="flex items-center gap-3 active:scale-95 transition-transform z-[60]">
        <AppLogo class="w-8 h-8 shrink-0" />
        <span class="font-bold text-2xl tracking-tight text-primary">Boookz</span>
      </NuxtLink>

      <!-- Desktop Navigation Links -->
      <div class="hidden md:flex items-center gap-8">
        <NuxtLink to="/library" class="nav-link">Library</NuxtLink>
        <NuxtLink v-if="userStore.userIsLoggedIn" to="/profile" class="nav-link">Profile</NuxtLink>
      </div>
    </div>

    <!-- Right Side Actions -->
    <div class="flex items-center gap-2 lg:gap-6 z-[60]">
      <!-- Auth Action (Desktop) -->
      <ClientOnly>
        <div v-if="!userStore.userIsLoggedIn" class="hidden md:flex items-center gap-6">
          <NuxtLink to="/signin" class="text-sm font-semibold text-slate-600 hover:text-primary transition-colors">Sign in</NuxtLink>
          <NuxtLink to="/register" class="btn-primary !py-2 !px-6 !rounded-xl text-sm">Sign up</NuxtLink>
        </div>

        <!-- User Menu (Desktop & Mobile) -->
        <div v-else class="flex items-center gap-1 lg:gap-4">
          <ProfileNotificationMenu />
          <ProfileSettingMenu />
        </div>
        
        <!-- Mobile Toggle -->
        <button 
          v-if="!userStore.userIsLoggedIn" 
          @click="isMenuOpen = !isMenuOpen"
          class="md:hidden w-10 h-10 flex items-center justify-center text-slate-600 hover:text-primary transition-colors focus:outline-none"
        >
          <font-awesome-icon :icon="isMenuOpen ? 'fa-solid fa-xmark' : 'fa-solid fa-bars'" class="text-xl" />
        </button>
      </ClientOnly>
    </div>

    <!-- Mobile Menu Drawer -->
    <Transition
      enter-active-class="transition duration-300 ease-out"
      enter-from-class="opacity-0 translate-x-full"
      enter-to-class="opacity-100 translate-x-0"
      leave-active-class="transition duration-200 ease-in"
      leave-from-class="opacity-100 translate-x-0"
      leave-to-class="opacity-0 translate-x-full"
    >
      <div v-if="isMenuOpen" class="fixed inset-0 z-50 md:hidden">
        <!-- Overlay -->
        <div class="absolute inset-0 bg-slate-900/20 backdrop-blur-sm" @click="isMenuOpen = false"></div>
        
        <!-- Drawer Content -->
        <div class="absolute right-0 top-0 bottom-0 w-72 bg-white shadow-2xl flex flex-col p-8 pt-24 gap-8">
          <div class="flex flex-col gap-6">
            <h3 class="text-[10px] font-black uppercase tracking-[0.2em] text-slate-400">Navigation</h3>
            <NuxtLink @click="isMenuOpen = false" to="/library" class="mobile-nav-link">
              <font-awesome-icon icon="fa-solid fa-book-open" class="w-5 text-primary/60" />
              Library
            </NuxtLink>
            <NuxtLink v-if="userStore.userIsLoggedIn" @click="isMenuOpen = false" to="/profile" class="mobile-nav-link">
              <font-awesome-icon icon="fa-solid fa-user" class="w-5 text-primary/60" />
              Profile
            </NuxtLink>
          </div>

          <div v-if="!userStore.userIsLoggedIn" class="mt-auto flex flex-col gap-4">
            <NuxtLink @click="isMenuOpen = false" to="/signin" class="btn-outline !py-3 !rounded-xl w-full text-center">Sign in</NuxtLink>
            <NuxtLink @click="isMenuOpen = false" to="/register" class="btn-primary !py-3 !rounded-xl w-full text-center">Join Boookz</NuxtLink>
          </div>
        </div>
      </div>
    </Transition>
  </nav>
</template>

<script setup>
import { ref } from 'vue';
import { useUserStore } from '~/stores/userStore';

const userStore = useUserStore();
const isMenuOpen = ref(false);

// Close menu on route change
const route = useRoute();
watch(() => route.path, () => {
  isMenuOpen.value = false;
});
</script>

<style scoped>
.nav-link {
  @apply text-sm font-bold text-slate-600 hover:text-primary transition-colors relative after:absolute after:-bottom-1 after:left-0 after:w-0 after:h-0.5 after:bg-primary after:transition-all hover:after:w-full;
}

.mobile-nav-link {
  @apply flex items-center gap-4 text-lg font-bold text-slate-700 hover:text-primary transition-all p-2 rounded-xl hover:bg-primary/5 active:scale-95;
}

.router-link-active.nav-link {
  @apply text-primary after:w-full;
}

.router-link-active.mobile-nav-link {
  @apply text-primary bg-primary/5;
}
</style>
