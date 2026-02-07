<template>
  <div class="relative" ref="menuContainer">
    <!-- Activator -->
    <button 
      @click="isOpen = !isOpen"
      class="relative w-10 h-10 flex items-center justify-center rounded-full hover:bg-slate-100 transition-all group outline-none"
      title="Notifications"
    >
      <font-awesome-icon 
        icon="fa-regular fa-bell" 
        class="text-xl transition-colors"
        :class="store.notifications?.length > 0 ? 'text-red-500' : 'text-slate-400 group-hover:text-primary'"
      />
      
      <!-- Notification Badge -->
      <span 
        v-if="store.notifications?.length > 0"
        class="absolute top-2 right-2 w-2.5 h-2.5 bg-red-500 border-2 border-white rounded-full shadow-sm animate-pulse"
      ></span>
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
        class="absolute right-0 mt-3 w-80 bg-white/90 backdrop-blur-xl rounded-[32px] shadow-premium border border-white/40 overflow-hidden z-[100]"
      >
        <!-- Header -->
        <div class="p-5 border-b border-slate-100 flex justify-between items-center bg-gradient-to-br from-indigo-50/30 to-purple-50/30">
          <h3 class="text-sm font-black text-dark tracking-tight uppercase">Notifications</h3>
          <span 
            v-if="store.notifications?.length > 0"
            class="px-2 py-0.5 bg-red-100 text-red-600 text-[10px] font-black rounded-full"
          >
            {{ store.notifications.length }} New
          </span>
        </div>

        <!-- Notification Items -->
        <div class="max-h-[400px] overflow-y-auto custom-scrollbar">
          <div v-if="store.notifications?.length > 0" class="p-2 flex flex-col gap-1">
            <button
              v-for="(item, index) in store.notifications"
              :key="index"
              @click="handleNotification(item.pk)"
              class="w-full text-left p-4 rounded-2xl hover:bg-primary/5 transition-all group flex gap-4"
            >
              <div class="w-10 h-10 rounded-full bg-indigo-50 flex-shrink-0 flex items-center justify-center text-primary group-hover:bg-primary/10 transition-colors">
                 <font-awesome-icon icon="fa-solid fa-circle-info" class="text-sm" />
              </div>
              <div class="flex flex-col gap-1 min-w-0">
                <p class="text-xs font-medium text-slate-600 leading-normal line-clamp-2">
                  {{ item.content }}
                </p>
                <span class="text-[9px] font-bold text-slate-300 uppercase tracking-widest">Just now</span>
              </div>
            </button>
          </div>

          <!-- Empty State -->
          <div v-else class="p-12 flex flex-col items-center justify-center text-center gap-4">
             <div class="w-16 h-16 bg-slate-50 rounded-full flex items-center justify-center text-slate-200">
                <font-awesome-icon icon="fa-solid fa-bell-slash" class="text-2xl" />
             </div>
             <p class="text-xs font-bold text-slate-400 uppercase tracking-[0.2em]">All clear!</p>
          </div>
        </div>

        <!-- Footer / Clear All -->
        <div v-if="store.notifications?.length > 0" class="p-3 border-t border-slate-100 bg-slate-50/50">
          <button
            @click="clearNotifications"
            class="w-full py-3 rounded-2xl text-[10px] font-black uppercase tracking-[0.2em] text-slate-400 hover:text-dark hover:bg-white hover:shadow-sm transition-all"
          >
            Dismiss All Notifications
          </button>
        </div>
      </div>
    </transition>
  </div>
</template>

<script setup>
  import { ref, onMounted, onUnmounted } from 'vue';
  import { useUserStore } from '~/stores/userStore';

  const store = useUserStore();
  const isOpen = ref(false);
  const menuContainer = ref(null);

  function handleNotification(notificationPK) {
    store.deleteNotification(notificationPK);
  }

  function clearNotifications() {
    store.clearNotifications();
    isOpen.value = false;
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

<style scoped>
.custom-scrollbar::-webkit-scrollbar {
  width: 4px;
}
.custom-scrollbar::-webkit-scrollbar-track {
  background: transparent;
}
.custom-scrollbar::-webkit-scrollbar-thumb {
  background: #f1f5f9;
  border-radius: 10px;
}
</style>
