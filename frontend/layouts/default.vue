<template>
  <div class="wrapper min-h-screen bg-background font-sans text-secondary">
    <div class="bg-white/90 backdrop-blur-md shadow-sm sticky top-0 z-50 flex justify-center py-2 transition-all">
      <NavigationBar class="max-w-7xl w-full px-4" />
    </div>
    <div class="content-wrapper max-w-7xl mx-auto px-4 py-8">
      <div class="content">
        <!-- this where the page components go -->
        <slot />
      </div>
    </div>
  </div>
</template>

<script setup>
import { useDataStore } from "~/stores/dataStore";
import { useUserStore } from "~/stores/userStore";
const store = useDataStore();
const userStore = useUserStore();
//running it here so it always runs and I dont have to call it inside each component/page
if (userStore.userIsLoggedIn) {
  await userStore.getUserInfo();
}
store.getOfferedBooksFromDB();
store.getWantedBooksFromDB();
</script>

<style>
html {
  font-family: 'Poppins', 'Mulish', sans-serif;
  box-sizing: border-box;
}

*,
*::before,
*::after {
  box-sizing: border-box;
  margin: 0;
}

/* exact link will show the primary color for only the exact matching link */
/*.router-link-exact-active {*/
/*background-color: #695ac9;*/
/*color: white;*/
/*box-shadow: 3px 3px 3px rgb(114, 114, 114);*/
/*}*/

.page-enter-active,
.page-leave-active {
  transition: all 0.4s;
}

.page-enter-from,
.page-leave-to {
  opacity: 0;
  filter: blur(1rem);
}
</style>
