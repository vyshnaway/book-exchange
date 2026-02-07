<template>
  <div class="flex flex-col gap-8">
    <!-- Header -->
    <div class="border-b border-slate-100 pb-6">
      <h2 class="text-2xl font-black text-dark tracking-tight">
        {{ route.id ? `${store.userName}'s Reviews` : 'My Community Feedback' }}
      </h2>
      <p class="text-slate-500 text-sm font-medium mt-1">What others are saying about their exchange experience</p>
    </div>

    <!-- Ratings List -->
    <div v-if="store.userRatings.length" class="grid grid-cols-1 md:grid-cols-2 gap-6">
      <div
        v-for="rating in store.userRatings"
        :key="rating.pk"
        class="bg-white p-6 rounded-[28px] shadow-premium border border-slate-50 flex flex-col gap-4 group hover:shadow-2xl transition-all duration-300"
      >
        <!-- Reviewer Header -->
        <div class="flex items-center justify-between">
          <div class="flex items-center gap-3">
             <div class="relative">
              <img
                :src="rating.book_reader.profile_image || '/_nuxt/assets/img/avatar-placeholder.png'"
                alt="Reviewer avatar"
                class="w-12 h-12 rounded-full object-cover border-2 border-white shadow-sm ring-1 ring-slate-100"
              />
              <div class="absolute -bottom-1 -right-1 w-4 h-4 bg-emerald-500 border-2 border-white rounded-full"></div>
            </div>
            <div class="flex flex-col">
              <h4 class="text-sm font-bold text-dark">{{ rating.book_reader.username }}</h4>
              <span class="text-[10px] text-slate-400 font-medium tracking-wider uppercase">{{ rating.modified }}</span>
            </div>
          </div>

          <!-- Star Rating -->
          <div class="flex gap-1 text-amber-400">
            <font-awesome-icon v-for="i in 5" :key="i" icon="fa-solid fa-star" :class="i <= rating.rating ? 'opacity-100' : 'opacity-20'" class="text-xs" />
          </div>
        </div>

        <!-- Feedback Content -->
        <div class="relative pt-2">
          <font-awesome-icon icon="fa-solid fa-quote-left" class="absolute -top-1 -left-1 text-slate-100 text-3xl z-0" />
          <p class="text-slate-600 text-sm leading-relaxed italic relative z-10">
             "{{ rating.comment }}"
          </p>
        </div>
        
        <!-- Subtle Footer Tag -->
        <div class="mt-2 pt-4 border-t border-slate-50 flex justify-end">
           <span class="text-[9px] font-black uppercase tracking-[0.2em] text-slate-300">Verified Exchange</span>
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
  import { useUserStore } from "~/stores/userStore";
  import { useProfileStore } from "~/stores/profileStore";
  
  const route = useRoute().params;
  const store = !route.id ? useUserStore() : useProfileStore();
</script>
