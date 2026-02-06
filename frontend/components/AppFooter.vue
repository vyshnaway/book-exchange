<template>
  <footer class="mt-20 border-t border-indigo-100 bg-white/80 backdrop-blur-xl transition-colors duration-300">
    <div class="max-w-7xl mx-auto px-6 py-12">
      <div class="flex flex-col md:flex-row justify-between items-center gap-8">
        <!-- Logo/Brand -->
        <div class="flex flex-col items-center md:items-start gap-3">
          <NuxtLink to="/" class="flex items-center gap-3 group">
            <AppLogo class="w-8 h-8 group-hover:scale-105 transition-transform duration-300" />
            <span class="font-bold text-2xl tracking-tight text-primary">Boookz</span>
          </NuxtLink>
          <p class="text-sm font-medium text-slate-500 max-w-xs text-center md:text-left">
            Connecting readers worldwide, exchanging stories one book at a time.
          </p>
        </div>

        <!-- Copyright -->
        <div class="flex flex-col items-center md:items-end gap-1 text-xs font-semibold text-slate-400">
          <p>&copy; {{ new Date().getFullYear() }} Boookz Platform.</p>
        </div>
      </div>
    </div>
  </footer>
</template>
