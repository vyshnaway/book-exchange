<template>
  <div class="relative" ref="menuContainer">
    <!-- Activator -->
    <button 
      @click="isOpen = !isOpen"
      class="flex items-center gap-2 p-1 rounded-full hover:bg-slate-50 transition-all outline-none"
    >
      <div class="relative">
        <img
          :src="store.userProfileImage || avatarPlaceholder"
          alt="User Profile"
          class="w-10 h-10 rounded-full border-2 border-white shadow-sm object-cover"
        />
        <div class="absolute bottom-0 right-0 w-3 h-3 bg-emerald-500 border-2 border-white rounded-full"></div>
      </div>
      <font-awesome-icon 
        icon="fa-solid fa-chevron-down" 
        class="text-[10px] text-slate-400 transition-transform duration-300 mr-1"
        :class="{ 'rotate-180': isOpen }"
      />
    </button>

    <!-- Dropdown Menu -->
    <transition
      enter-active-class="transition duration-200 ease-out"
      enter-from-class="transform scale-95 opacity-0 -translate-y-2"
      enter-to-class="transform scale-100 opacity-100 translate-y-0"
      leave-active-class="transition duration-150 ease-in"
      leave-from-class="transform scale-100 opacity-100 translate-y-0"
      leave-to-class="transform scale-95 opacity-0 -translate-y-2"
    >
      <div 
        v-if="isOpen"
        class="absolute right-0 mt-3 w-64 bg-white/90 backdrop-blur-xl rounded-3xl shadow-premium border border-white/40 overflow-hidden z-[100]"
      >
        <!-- Header/Profile Info -->
        <div class="p-5 bg-gradient-to-br from-indigo-50/50 to-purple-50/50 border-b border-slate-100">
          <p class="text-[10px] font-black uppercase tracking-[0.2em] text-slate-400 mb-1">Signed in as</p>
          <p class="text-sm font-bold text-dark truncate">{{ store.userName }}</p>
        </div>

        <div class="p-2">
          <button 
            @click="navigateAndClose('/profile')"
            class="w-full flex items-center gap-3 px-4 py-3 text-sm font-medium text-slate-600 hover:text-primary hover:bg-primary/5 rounded-2xl transition-all group"
          >
            <div class="w-8 h-8 rounded-xl bg-slate-50 group-hover:bg-primary/10 flex items-center justify-center transition-colors">
              <font-awesome-icon icon="fa-solid fa-user" />
            </div>
            My Profile
          </button>

          <button 
            @click="navigateAndClose('/user/settings')"
            class="w-full flex items-center gap-3 px-4 py-3 text-sm font-medium text-slate-600 hover:text-primary hover:bg-primary/5 rounded-2xl transition-all group"
          >
            <div class="w-8 h-8 rounded-xl bg-slate-50 group-hover:bg-primary/10 flex items-center justify-center transition-colors">
              <font-awesome-icon icon="fa-solid fa-gear" />
            </div>
            Account Settings
          </button>

          <button 
            @click="navigateAndClose('/support')"
            class="w-full flex items-center gap-3 px-4 py-3 text-sm font-medium text-slate-600 hover:text-primary hover:bg-primary/5 rounded-2xl transition-all group"
          >
            <div class="w-8 h-8 rounded-xl bg-slate-50 group-hover:bg-primary/10 flex items-center justify-center transition-colors">
              <font-awesome-icon icon="fa-solid fa-circle-question" />
            </div>
            Help & Support
          </button>
        </div>

        <div class="p-2 border-t border-slate-100">
          <button 
            @click="handleLogout"
            class="w-full flex items-center gap-3 px-4 py-3 text-sm font-bold text-red-500 hover:bg-red-50 rounded-2xl transition-all group"
          >
            <div class="w-8 h-8 rounded-xl bg-red-50 group-hover:bg-red-100/50 flex items-center justify-center transition-colors">
              <font-awesome-icon icon="fa-solid fa-right-from-bracket" />
            </div>
            Log Out
          </button>
        </div>
      </div>
    </transition>
  </div>
</template>

<script setup>
  import { ref, onMounted, onUnmounted } from 'vue';
  import { useUserStore } from '~/stores/userStore';
  import { useDataStore } from '~/stores/dataStore';
  import avatarPlaceholder from '~/assets/img/avatar.png';

  const store = useUserStore();
  const dataStore = useDataStore();
  const { $toast } = useNuxtApp();
  
  const isOpen = ref(false);
  const menuContainer = ref(null);

  async function navigateAndClose(path) {
    isOpen.value = false;
    await navigateTo(path);
  }

  async function handleLogout() {
    isOpen.value = false;
    store.logOut();
    await dataStore.updateData();
    $toast.success('Securely logged out. See you soon!');
    await navigateTo('/');
  }

  // Close menu on click outside
  const handleClickOutside = (event) => {
    if (menuContainer.value && !menuContainer.value.contains(event.target)) {
      isOpen.value = false;
    }
  };

  onMounted(() => {
    document.addEventListener('click', handleClickOutside);
  });

  onUnmounted(() => {
    document.removeEventListener('click', handleClickOutside);
  });
</script>
