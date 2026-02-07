<template>
  <div class="flex flex-col gap-8">
    <!-- Profile Hero Header -->
    <header class="relative overflow-hidden rounded-3xl bg-indigo-600 px-6 py-12 md:py-20 shadow-premium">
      <!-- Decorative Elements -->
      <div class="absolute top-0 right-0 -translate-y-1/2 translate-x-1/2 w-64 h-64 bg-white/10 rounded-full blur-3xl"></div>
      <div class="absolute bottom-0 left-0 translate-y-1/2 -translate-x-1/2 w-96 h-96 bg-purple-500/20 rounded-full blur-3xl"></div>

      <div class="relative flex flex-col items-center text-center gap-6">
        <div class="relative group">
          <img
            :src="userStore.userProfileImage || avatarPlaceholder"
            alt="Profile Avatar"
            class="w-32 h-32 md:w-40 md:h-40 rounded-full object-cover border-4 border-white/20 shadow-2xl transition-transform duration-500 group-hover:scale-105"
          />
          <div class="absolute -bottom-2 -right-2 w-10 h-10 bg-white rounded-full flex items-center justify-center shadow-lg border-2 border-indigo-600">
            <font-awesome-icon icon="fa-solid fa-check" class="text-indigo-600 text-sm" />
          </div>
        </div>

        <div class="flex flex-col gap-2">
          <h2 class="text-3xl md:text-5xl font-extrabold text-white tracking-tight">
            {{ userStore.userName || 'Book Enthusiast' }}
          </h2>
          <div class="flex items-center justify-center gap-2 text-indigo-100/80 font-medium">
            <font-awesome-icon icon="fa-solid fa-location-dot" class="text-xs" />
            <span>{{ userStore.region || 'World Citizen' }}</span>
          </div>
        </div>
      </div>
    </header>

    <!-- Navigation Tabs -->
    <ClientOnly>
      <nav class="glass !bg-white/40 sticky top-24 z-30 p-2 rounded-2xl flex flex-wrap justify-between items-center gap-2">
        <div class="flex flex-wrap gap-2">
          <button
            v-for="tab in tabs"
            :key="tab.value"
            @click="activeTab = tab.value"
            class="flex items-center gap-3 px-6 py-3 rounded-xl font-bold text-sm tracking-wide transition-all duration-300"
            :class="activeTab === tab.value 
              ? 'bg-primary shadow-lg shadow-primary/30 scale-[1.02]' 
              : 'text-slate-500 hover:bg-white/60 hover:text-primary'"
          >
            <font-awesome-icon :icon="tab.icon" />
            <span>{{ tab.label }}</span>
            <span 
              v-if="tab.count !== undefined" 
              class="ml-1 px-2 py-0.5 rounded-full text-[10px] bg-white/20"
            >
              {{ tab.count }}
            </span>
          </button>
        </div>
      </nav>
    </ClientOnly>

    <!-- Tab Content -->
    <main class="animate-in fade-in slide-in-from-bottom-4 duration-500">
      <div class="bg-white/50 rounded-3xl p-6 min-h-[400px]">
        <LazyProfileGiveaway v-if="activeTab === 'Giveaway'" />
        <LazyProfileWanted v-if="activeTab === 'Wanted'" />
        <LazyProfileRatings v-if="activeTab === 'Ratings'" />
      </div>
    </main>
  </div>
</template>

<script setup>
import { ref, computed, onBeforeMount } from 'vue';
import { useProfileStore } from '~/stores/profileStore';
import { storeToRefs } from 'pinia';
import avatarPlaceholder from "~/assets/img/avatar.png";

definePageMeta({
  middleware: 'auth',
});

const route = useRoute();
const userStore = useProfileStore();

// Destructure from profileStore (which matches userStore structure mostly)
const { 
  userProfileImage, 
  userName, 
  region, 
  userGiveAwayBooks, 
  userWantedBooks, 
  userTransactions, 
  userRatings 
} = storeToRefs(userStore);

const activeTab = ref('Giveaway');

const tabs = computed(() => [
  { label: 'Giveaway', value: 'Giveaway', icon: 'fa-solid fa-gift', count: userGiveAwayBooks.value?.length || 0 },
  { label: 'Wanted', value: 'Wanted', icon: 'fa-solid fa-heart', count: userWantedBooks.value?.length || 0 },
  { label: 'Ratings', value: 'Ratings', icon: 'fa-solid fa-star', count: userRatings.value?.length || 0 },
]);

onBeforeMount(async () => {
    // Set the username from route params BEFORE fetching info
    if (route.params.id) {
        userStore.userName = route.params.id;
        await userStore.getUserInfo();
    }
});
</script>

<style scoped>
/* Placeholder for any custom styles if needed */
</style>
