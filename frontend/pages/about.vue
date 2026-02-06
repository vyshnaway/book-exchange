<template>
  <div class="max-w-5xl mx-auto px-4 py-20">
    <!-- Hero Section -->
    <div class="text-center mb-20 space-y-6">
      <div class="inline-block px-4 py-2 bg-indigo-50 rounded-2xl text-primary text-xs font-black uppercase tracking-[0.2em] mb-4">
        Our Story
      </div>
      <h1 class="text-5xl md:text-7xl font-black text-dark tracking-tight leading-tight">
        Connecting Readers, <br/> 
        <span class="text-transparent bg-clip-text bg-gradient-to-r from-primary to-secondary">One Book at a Time.</span>
      </h1>
      <p class="text-xl text-slate-500 font-medium max-w-2xl mx-auto leading-relaxed italic">
        "We believe that every book deserves to be read again, and every reader deserves a treasure to discover."
      </p>
    </div>

    <!-- Mission & Vision -->
    <div class="grid grid-cols-1 md:grid-cols-2 gap-12 mb-32">
      <div class="glass p-10 rounded-[40px] shadow-premium border border-white/40">
        <div class="w-14 h-14 bg-indigo-50 text-primary rounded-2xl flex items-center justify-center text-2xl mb-6 shadow-inner">
          <font-awesome-icon icon="fa-solid fa-heart" />
        </div>
        <h3 class="text-2xl font-black text-dark mb-4">Our Mission</h3>
        <p class="text-slate-600 leading-relaxed font-medium">
          Boookz was born from a simple idea: why let great books gather dust when they could be starting new journeys? We're building a sustainable, community-driven platform where book lovers can exchange their treasures freely.
        </p>
      </div>

      <div class="glass p-10 rounded-[40px] shadow-premium border border-white/40">
        <div class="w-14 h-14 bg-purple-50 text-secondary rounded-2xl flex items-center justify-center text-2xl mb-6 shadow-inner">
          <font-awesome-icon icon="fa-solid fa-earth-americas" />
        </div>
        <h3 class="text-2xl font-black text-dark mb-4">Sustainable Reading</h3>
        <p class="text-slate-600 leading-relaxed font-medium">
          In an age of digital noise, we celebrate the tactile joy of physical books. By facilitating exchanges, we reduce waste, support literacy, and foster meaningful connections between strangers united by their love for the written word.
        </p>
      </div>
    </div>

    <!-- How it Works (Steps) -->
    <div class="space-y-16 text-center">
       <h2 class="text-3xl font-black text-dark tracking-tight">How the Magic Happens</h2>
       <div class="grid grid-cols-1 sm:grid-cols-3 gap-12">
          <div class="flex flex-col items-center gap-6">
             <div class="w-20 h-20 rounded-full bg-white shadow-premium flex items-center justify-center text-2xl font-black text-primary border border-slate-50">1</div>
             <div class="space-y-2">
                <h4 class="font-bold text-dark">List Your Books</h4>
                <p class="text-sm text-slate-500 font-medium">Share what's on your shelf and what you're looking for.</p>
             </div>
          </div>
          <div class="flex flex-col items-center gap-6">
             <div class="w-20 h-20 rounded-full bg-white shadow-premium flex items-center justify-center text-2xl font-black text-primary border border-slate-50">2</div>
             <div class="space-y-2">
                <h4 class="font-bold text-dark">Find a Match</h4>
                <p class="text-sm text-slate-500 font-medium">Our community library is filled with hidden gems.</p>
             </div>
          </div>
          <div class="flex flex-col items-center gap-6">
             <div class="w-20 h-20 rounded-full bg-white shadow-premium flex items-center justify-center text-2xl font-black text-primary border border-slate-50">3</div>
             <div class="space-y-2">
                <h4 class="font-bold text-dark">Exchange & Grow</h4>
                <p class="text-sm text-slate-500 font-medium">Coordinate a swap and start your next adventure.</p>
             </div>
          </div>
       </div>
    </div>

    <!-- Join CTA -->
    <div class="mt-32 p-12 bg-dark rounded-[40px] text-center space-y-8 relative overflow-hidden shadow-2xl">
      <div class="absolute top-0 right-0 w-64 h-64 bg-primary/20 rounded-full -translate-y-1/2 translate-x-1/2 blur-3xl"></div>
      <div class="relative z-10 space-y-6">
        <h2 class="text-3xl md:text-4xl font-black text-white px-4">Ready to start your next story?</h2>
        <div class="flex flex-wrap justify-center gap-4">
          <NuxtLink to="/register" class="btn-primary !bg-white !text-dark !px-10 !py-4 !rounded-2xl hover:scale-105 active:scale-95 transition-all shadow-xl shadow-white/10 font-black">Join the Library</NuxtLink>
          <NuxtLink to="/" class="btn-outline !border-white/20 !text-white !px-10 !py-4 !rounded-2xl hover:!bg-white/5 transition-all font-bold">Explore Books</NuxtLink>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
</script>
