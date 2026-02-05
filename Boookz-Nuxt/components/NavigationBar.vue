<template>
  <nav
    class="flex flex-wrap items-center justify-between w-full px-5 py-4 relative bg-white"
  >
    <!-- Logo -->
    <NuxtLink
      to="/"
      class="flex gap-2 justify-center items-center"
      active-class="inactive"
    >
      <AppLogo />
      <div class="flex flex-col justify-start">
        <h1 class="font-bold text-[33px] leading-10 h-9">Boookz</h1>
        <p class="leading-none">Book xchange website</p>
      </div>
    </NuxtLink>

    <!-- Hamburger Menu Button -->
    <button
      @click="toggleMenu"
      class="block lg:hidden p-2 rounded focus:outline-none hover:bg-gray-100"
    >
      <!-- Hamburger Icon -->
      <svg
        v-if="!isMenuOpen"
        class="w-8 h-8 text-violet-500"
        fill="none"
        stroke="currentColor"
        viewBox="0 0 24 24"
        xmlns="http://www.w3.org/2000/svg"
      >
        <path
          stroke-linecap="round"
          stroke-linejoin="round"
          stroke-width="2"
          d="M4 6h16M4 12h16M4 18h16"
        ></path>
      </svg>
      <!-- Close Icon -->
      <svg
        v-else
        class="w-8 h-8 text-violet-500"
        fill="none"
        stroke="currentColor"
        viewBox="0 0 24 24"
        xmlns="http://www.w3.org/2000/svg"
      >
        <path
          stroke-linecap="round"
          stroke-linejoin="round"
          stroke-width="2"
          d="M6 18L18 6M6 6l12 12"
        ></path>
      </svg>
    </button>

    <!-- Collapsible Content -->
    <div
      :class="[
        isMenuOpen ? 'flex' : 'hidden',
        'lg:flex flex-col lg:flex-row gap-4 w-full lg:w-auto items-center mt-4 lg:mt-0',
      ]"
    >
      <!-- Search -->
      <div class="w-full lg:w-auto flex justify-center">
        <form @submit.prevent="search" class="relative w-full max-w-sm">
          <input
            placeholder="Search offered books"
            type="text"
            class="bg-gray-100 rounded-lg px-3 w-full lg:w-96 h-10 lg:h-8"
            v-model="searchQuery"
          />
          <button class="absolute top-0 right-2 h-full flex items-center" type="submit">
            <img src="/MagnifyingGlass.png" alt="search icon" class="w-5 h-5" />
          </button>
        </form>
      </div>

      <!-- Links -->
      <div class="flex flex-col lg:flex-row gap-4 items-center">
        <NuxtLink to="/about" class="hover:text-violet-500 font-semibold"
          >About</NuxtLink
        >
        <NuxtLink to="/support" class="hover:text-violet-500 font-semibold"
          >Support</NuxtLink
        >
      </div>

      <!-- Auth / Profile -->
      <ul
        v-if="!store.userIsLoggedIn"
        class="flex flex-col lg:flex-row gap-4 lg:gap-2 w-full lg:w-auto items-center"
      >
        <NuxtLink class="btn-sm lg:btn w-full lg:w-auto text-center" to="/signin"
          >Sign in</NuxtLink
        >
        <NuxtLink class="btn-sm lg:btn w-full lg:w-auto text-center" to="/register"
          >Sign up</NuxtLink
        >
      </ul>

      <ul
        v-else
        class="flex gap-8 justify-center items-center w-full lg:w-auto"
      >
        <img
          v-if="store.userProfileImage"
          :src="store.userProfileImage"
          alt="profile avatar"
          class="w-10 h-10 lg:w-8 lg:h-8 rounded-full hover:cursor-pointer"
          @click="redirect"
        />
        <img
          v-else
          src="../assets/img/avatar.png"
          alt="profile avatar"
          class="w-10 h-10 lg:w-8 lg:h-8 rounded-full"
          @click="redirect"
        />
        <div class="flex gap-4 lg:gap-2">
            <ProfileSettingMenu />
            <ProfileNotificationMenu />
        </div>
      </ul>
    </div>
  </nav>
</template>

<script>
import { useGoogleAPIStore } from '~/stores/googleAPIStore';
import { useUserStore } from '~/stores/userStore';
import { useDataStore } from '~/stores/dataStore';

import 'vuetify/styles';
import { createVuetify } from 'vuetify';
import * as components from 'vuetify/components';
import * as directives from 'vuetify/directives';
import { ref } from 'vue'; // Import ref

export default {
  setup() {
    const vuetify = createVuetify({
      components,
      directives,
    });

    const googleAPIStore = useGoogleAPIStore();
    const dataStore = useDataStore();
    const store = useUserStore();

    const notificationshown = ref(false);
    const settingsshown = ref(false);
    const isMenuOpen = ref(false); // Mobile menu state

    const searchQuery = ref('');

    const search = () => {
      dataStore.searchForBook(searchQuery.value);
      searchQuery.value = '';
      isMenuOpen.value = false; // Close menu on search
    };

    const redirect = () => {
      isMenuOpen.value = false; // Close menu on redirect
      return navigateTo('/profile');
    };

    const toggleMenu = () => {
      isMenuOpen.value = !isMenuOpen.value;
    };

    const logOut = () => {
      store.logOut();
      isMenuOpen.value = false;
    };

    return {
      searchQuery,
      googleAPIStore,
      search,
      store,
      logOut,
      redirect,
      notificationshown,
      settingsshown,
      isMenuOpen,
      toggleMenu,
    };
  },
};
</script>

<style scoped></style>
