<template>
  <div class="space-y-32 md:space-y-48 mb-32">
    <!-- Slide 1: Hero (The Hook) -->
    <section class="min-h-[85vh] flex flex-col items-center justify-center text-center px-4 relative overflow-hidden">
      <!-- Background Glows -->
      <div class="absolute -top-40 left-1/2 -translate-x-1/2 w-[1000px] h-[600px] bg-primary/10 rounded-full blur-[160px] -z-10"></div>
      <div class="absolute bottom-0 right-0 w-[400px] h-[400px] bg-indigo-500/5 rounded-full blur-[100px] -z-10"></div>
      
      <div class="inline-flex items-center gap-2 px-6 py-3 rounded-full bg-primary/5 border border-primary/10 text-primary text-sm font-black uppercase tracking-[0.3em] animate-in fade-in slide-in-from-top-4 duration-1000">
        <font-awesome-icon icon="fa-solid fa-star" />
        <span>The Future of Shared Reading</span>
      </div>

      <h1 class="text-7xl md:text-[10rem] font-black text-dark tracking-tighter leading-[0.85] mt-10 animate-in fade-in slide-in-from-bottom-12 duration-1000 delay-150">
        Exchange <br/> 
        <span class="text-transparent bg-clip-text bg-gradient-to-r from-primary via-indigo-600 to-secondary drop-shadow-sm">Stories.</span>
      </h1>

      <p class="text-2xl md:text-3xl text-slate-500 font-medium max-w-3xl mx-auto leading-tight mt-12 animate-in fade-in slide-in-from-bottom-12 duration-1000 delay-300">
        A sustainable, community-driven ecosystem <br class="hidden md:block" /> where every book finds a second journey.
      </p>

      <div class="flex flex-wrap justify-center gap-6 mt-16 animate-in fade-in slide-in-from-bottom-12 duration-1000 delay-500">
        <NuxtLink to="/library" class="btn-primary !px-12 !py-6 !rounded-[2rem] text-xl shadow-2xl shadow-primary/30 hover:scale-105 active:scale-95 transition-all flex items-center gap-3">
          <span>Enter the Library</span>
          <font-awesome-icon icon="fa-solid fa-arrow-right" class="text-sm opacity-60" />
        </NuxtLink>
      </div>
    </section>

    <!-- Slide 2: The Problem & Vision (Mission) -->
    <section class="max-w-7xl mx-auto px-6 grid grid-cols-1 lg:grid-cols-2 gap-24 items-center">
      <div class="space-y-12 animate-in fade-in slide-in-from-left-12 duration-1000">
        <div class="space-y-4">
          <h3 class="text-primary font-black uppercase tracking-[0.25em] text-sm">The Vision</h3>
          <h2 class="text-5xl md:text-7xl font-black text-dark leading-[0.95] tracking-tight">
            Why <br/> <span class="text-primary">Boookz?</span>
          </h2>
        </div>
        
        <p class="text-2xl text-slate-600 font-medium leading-relaxed">
          Millions of books sit unread on shelves. We connect local readers to create a <span class="text-primary font-bold">circular economy of knowledge</span> that costs nothing and saves the planet.
        </p>

        <div class="grid grid-cols-1 gap-8">
          <div v-for="item in benefits" :key="item.title" class="flex gap-8 p-8 rounded-[2.5rem] bg-white border border-slate-100 shadow-sm hover:shadow-xl hover:-translate-y-1 transition-all group">
            <div class="w-16 h-16 shrink-0 rounded-2xl bg-indigo-50 text-primary flex items-center justify-center text-3xl group-hover:bg-primary group-hover:text-white transition-all shadow-inner">
              <font-awesome-icon :icon="item.icon" />
            </div>
            <div class="space-y-2">
              <h4 class="text-2xl font-black text-dark">{{ item.title }}</h4>
              <p class="text-slate-500 font-medium leading-relaxed">{{ item.desc }}</p>
            </div>
          </div>
        </div>
      </div>

      <div class="relative group animate-in fade-in slide-in-from-right-12 duration-1000">
        <div class="absolute inset-0 bg-gradient-to-tr from-primary/30 to-secondary/20 rounded-[4rem] rotate-3 blur-3xl opacity-40"></div>
        <div class="relative aspect-[4/5] rounded-[4rem] overflow-hidden shadow-premium border-[12px] border-white">
          <img src="https://images.unsplash.com/photo-1646294963497-582d4d54edb5?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDE3fHx8ZW58MHx8fHx8" alt="Sustainability" class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-1000" />
          <div class="absolute inset-0 bg-gradient-to-t from-dark/80 via-transparent to-transparent"></div>
          <div class="absolute bottom-12 left-12 right-12">
            <p class="text-4xl font-black text-white leading-tight">"Turning dusty shelves into shared experiences."</p>
          </div>
        </div>
      </div>
    </section>

    <!-- Slide 3: Live Ecosystem (Featured Books) -->
    <section v-if="featuredBooks.length" class="max-w-7xl mx-auto space-y-20 px-6">
      <div class="text-center space-y-6 max-w-3xl mx-auto">
        <h3 class="text-primary font-black uppercase tracking-[0.25em] text-sm">Live Demo</h3>
        <h2 class="text-5xl md:text-7xl font-black text-dark leading-none tracking-tight">The Living Library</h2>
        <p class="text-xl text-slate-500 font-medium leading-relaxed">
          Real-time data synchronization across our community. These treasures were just listed by users like you.
        </p>
      </div>

      <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-10">
        <LazyBookCard 
          v-for="(book, i) in featuredBooks" 
          :key="book.pk" 
          :book="book" 
          class="animate-in fade-in zoom-in-95 duration-1000"
          :style="{ transitionDelay: `${i * 150}ms` }"
        />
      </div>

      <div class="flex justify-center pt-8">
        <NuxtLink to="/library" class="text-sm font-black uppercase tracking-[0.2em] text-slate-400 hover:text-primary transition-colors flex items-center gap-3 group">
          <span>Browse Complete Archive</span>
          <font-awesome-icon icon="fa-solid fa-arrow-right-long" class="group-hover:translate-x-2 transition-transform" />
        </NuxtLink>
      </div>
    </section>

    <!-- Slide 4: Simple Workflow (How it Works) -->
    <section class="max-w-7xl mx-auto px-6 space-y-24">
      <div class="flex flex-col md:flex-row justify-between items-center gap-10">
        <div class="space-y-4 text-center md:text-left">
          <h3 class="text-primary font-black uppercase tracking-[0.25em] text-sm">Seamless Process</h3>
          <h2 class="text-5xl md:text-7xl font-black text-dark tracking-tight leading-none">How it Works</h2>
        </div>
        <div class="max-w-md text-center md:text-right">
          <p class="text-xl text-slate-500 font-medium italic leading-relaxed">"A platform designed for simplicity, security, and the joy of discovery."</p>
        </div>
      </div>
      
      <div class="grid grid-cols-1 md:grid-cols-3 gap-8 relative">
        <div v-for="(step, i) in steps" :key="step.title" class="relative group">
          <div class="relative flex flex-col items-center text-center p-10 rounded-[3rem] bg-white border border-slate-100 shadow-sm group-hover:shadow-xl group-hover:-translate-y-2 transition-all duration-500 overflow-hidden h-full">
            <div class="absolute top-0 right-0 w-32 h-32 bg-primary/5 rounded-full translate-x-1/2 -translate-y-1/2"></div>
            
            <div class="w-20 h-20 rounded-2xl bg-indigo-50 text-primary flex items-center justify-center text-3xl font-black mb-8 group-hover:bg-primary group-hover:text-white transition-colors duration-500">
              {{ i + 1 }}
            </div>
            
            <div class="space-y-4">
              <h4 class="text-2xl font-black text-dark transition-colors">{{ step.title }}</h4>
              <p class="text-slate-500 font-medium leading-relaxed">{{ step.desc }}</p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Slide 5: The Tech Stack (College Presentation Special) -->
    <section class="max-w-6xl mx-auto px-6 py-24 rounded-[4rem] bg-slate-900 relative overflow-hidden shadow-2xl">
      <div class="absolute top-0 right-0 w-[600px] h-[600px] bg-primary/20 rounded-full blur-[120px] -translate-y-1/2 translate-x-1/3"></div>
      <div class="absolute bottom-0 left-0 w-[400px] h-[400px] bg-indigo-600/10 rounded-full blur-[100px] translate-y-1/2 -translate-x-1/4"></div>
      
      <div class="relative z-10 space-y-20">
        <div class="text-center space-y-4">
          <h3 class="text-primary font-black uppercase tracking-[0.3em] text-xs">Technical Overview</h3>
          <h2 class="text-5xl md:text-6xl font-black text-white tracking-tight">Built with Modern Tech</h2>
        </div>

        <div class="grid grid-cols-2 md:grid-cols-4 gap-6 md:gap-8">
          <div v-for="tech in techStack" :key="tech.name" class="flex flex-col items-center gap-6 p-10 rounded-[2.5rem] bg-white/80 backdrop-blur-md border border-white/20 hover:bg-white/15 transition-all hover:-translate-y-2 group shadow-xl">
            <div class="w-16 h-16 flex items-center justify-center text-primary text-4xl group-hover:scale-110 transition-transform">
              <font-awesome-icon :icon="tech.icon" />
            </div>
            <div class="text-center">
              <h5 class="text-primary font-black text-xl mb-1">{{ tech.name }}</h5>
              <div class="px-3 py-1 bg-primary/20 rounded-full inline-block border border-primary/30">
                <span class="text-primary text-[10px] font-black uppercase tracking-widest">{{ tech.role }}</span>
              </div>
            </div>
          </div>
        </div>

        <!-- Features list -->
        <div class="grid grid-cols-1 md:grid-cols-3 gap-8 pt-10 border-t border-white/10">
          <div v-for="feat in techFeatures" :key="feat" class="flex items-center gap-4 text-indigo-100/70 font-medium">
            <div class="w-2 h-2 rounded-full bg-primary shadow-[0_0_10px_rgba(var(--primary-rgb),0.5)]"></div>
            <span>{{ feat }}</span>
          </div>
        </div>
      </div>
    </section>

    <!-- Slide 6: Conclusion (CTA) -->
    <section class="max-w-6xl mx-auto px-4 pb-24">
      <div class="p-16 md:p-32 bg-gradient-to-br from-primary to-indigo-900 rounded-[5rem] text-center space-y-12 relative overflow-hidden shadow-[0_30px_100px_-20px_rgba(99,102,241,0.5)]">
        <div class="absolute inset-0 bg-[url('https://www.transparenttextures.com/patterns/cubes.png')] opacity-10"></div>
        
        <div class="relative z-10 space-y-10">
          <div class="space-y-6">
            <h2 class="text-5xl md:text-8xl font-black text-white leading-[0.9] tracking-tighter">Start your <br/> legacy today.</h2>
            <p class="text-indigo-100/70 font-medium text-xl md:text-2xl max-w-2xl mx-auto leading-relaxed">
              Join the movement that's redefining what it means to own a book.
            </p>
          </div>
          
          <div class="flex flex-wrap justify-center gap-6 pt-4">
            <ClientOnly>
              <NuxtLink v-if="!userStore.userIsLoggedIn" to="/register" class="bg-white text-dark !px-16 !py-6 !rounded-[2.5rem] text-xl font-black hover:scale-105 active:scale-95 transition-all shadow-2xl">Create Account</NuxtLink>
            </ClientOnly>
            <NuxtLink to="/library" class="bg-indigo-500/20 backdrop-blur-md border border-white/20 text-white !px-16 !py-6 !rounded-[2.5rem] text-xl font-bold hover:bg-white/10 transition-all">Explore Platform</NuxtLink>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>
<script setup>
import { computed, onMounted } from 'vue';
import { useUserStore } from '~/stores/userStore';
import { useDataStore } from '~/stores/dataStore';

const userStore = useUserStore();
const dataStore = useDataStore();

onMounted(async () => {
  await dataStore.getOfferedBooksFromDB();
});

const featuredBooks = computed(() => {
  return dataStore.giveAwayBooks.slice(0, 4);
});

const techStack = [
  { name: 'Nuxt 3', role: 'Frontend Framework', icon: 'fa-solid fa-bolt' },
  { name: 'Django', role: 'Backend API', icon: 'fa-solid fa-server' },
  { name: 'Docker', role: 'Orchestration', icon: 'fa-solid fa-box-archive' },
  { name: 'Postgres', role: 'Database', icon: 'fa-solid fa-database' }
];

const techFeatures = [
  'RESTful API Architecture',
  'Google Books API Integration',
  'Dockerized Microservices',
  'PostgreSQL Data Persistence',
  'Real-time Store Management',
  'Responsive Glassmorphic UI'
];

const benefits = [
  { 
    title: 'Zero-Cost Exchange', 
    desc: 'Trade books freely with other members. No hidden fees, just pure literacy sharing.',
    icon: 'fa-solid fa-gift'
  },
  { 
    title: 'Eco-Friendly Reading', 
    desc: 'Reduce your carbon footprint by giving physical books a second, third, or fourth life.',
    icon: 'fa-solid fa-leaf'
  },
  { 
    title: 'Local Connections', 
    desc: 'Connect with fellow readers in your neighborhood and foster real-world communities.',
    icon: 'fa-solid fa-users'
  }
];

const steps = [
  { title: 'List Your Collection', desc: 'Catalog the books you\'re ready to share with our easy Google-powered lookup tool.' },
  { title: 'Discover Matches', desc: 'Browse our growing library and find the titles you\'ve been dreaming of.' },
  { title: 'Propose a Swap', desc: 'Connect with owners and coordinate a secure exchange at your convenience.' }
];
</script>
