<template>
  <footer class="mt-20 border-t border-indigo-100 bg-white/80 backdrop-blur-xl transition-colors duration-300">
    <div class="max-w-7xl mx-auto px-6 py-12">
        <!-- Logo/Brand -->
        <div class="flex flex-col items-center gap-3">
          <NuxtLink to="/" class="flex items-center gap-3 group">
            <AppLogo class="w-8 h-8 group-hover:scale-105 transition-transform duration-300" />
            <span class="font-bold text-2xl tracking-tight text-primary">Boookz</span>
          </NuxtLink>
          <p class="text-sm font-medium text-slate-500 max-w-xs text-center">
            Connecting readers worldwide, exchanging stories one book at a time.
          </p>
        </div>
      </div>
  </footer>
</template>
