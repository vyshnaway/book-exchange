<template>
  <nav class="flex items-center justify-between w-full h-16">
    <!-- Left Side: Logo & Navigation -->
    <div class="flex items-center gap-10">
      <!-- Logo -->
      <NuxtLink to="/" class="flex items-center gap-3 active:scale-95 transition-transform">
        <AppLogo class="w-8 h-8" />
        <span class="font-bold text-2xl tracking-tight text-primary">Boookz</span>
      </NuxtLink>

      <!-- Navigation Links -->
      <div class="hidden sm:flex items-center gap-8">
        <!-- <NuxtLink to="/" class="text-sm font-bold text-slate-600 hover:text-primary transition-colors">Home</NuxtLink> -->
        <NuxtLink to="/library" class="text-sm font-bold text-slate-600 hover:text-primary transition-colors">Library</NuxtLink>
        <NuxtLink v-if="userStore.userIsLoggedIn" to="/profile" class="text-sm font-bold text-slate-600 hover:text-primary transition-colors">Profile</NuxtLink>
      </div>
    </div>

    <!-- Right Side Actions -->
    <div class="flex items-center gap-2 lg:gap-6">
      <!-- Auth Action (Always Visible) -->
      <ClientOnly>
        <div v-if="!userStore.userIsLoggedIn" class="flex items-center gap-2 lg:gap-6">
          <NuxtLink to="/signin" class="text-sm font-semibold text-slate-600 hover:text-indigo-600 transition-colors hidden sm:block">Sign in</NuxtLink>
          <NuxtLink to="/register" class="btn-primary !py-2 !px-4 !text-xs sm:!text-sm !rounded-xl">Sign up</NuxtLink>
        </div>

        <!-- User Menu (Always Visible) -->
        <div v-else class="flex items-center gap-1 lg:gap-4">
          <ProfileNotificationMenu />
          <ProfileSettingMenu />
        </div>
      </ClientOnly>
    </div>
  </nav>
</template>

<script setup>
import { useUserStore } from '~/stores/userStore';

const userStore = useUserStore();
</script>

<style scoped>
</style>
