<template>
  <div class="flex flex-col md:flex-row md:mt-32 mx-auto justify-around items-center gap-1">
    <div class="hidden md:block w-1/2">
      <img
        src="../assets/img/sign-in-img.png"
        alt="Login Illustration"
        class="w-full h-auto object-cover rounded-lg shadow-xl"
      />
    </div>

    <div class="w-full md:w-1/3 bg-white p-8 rounded-lg shadow-2xl border border-gray-100">
      <form
        @submit.prevent="signIn"
        @input="store.resetErrors"
        class="flex flex-col justify-between gap-6"
      >
        <h1 class="text-4xl font-bold text-primary text-center mb-4">Welcome Back</h1>
        
        <div class="flex flex-col gap-1">
          <label for="email" class="text-sm font-semibold text-secondary ml-1">Username</label>
          <input
            class="input w-full focus:ring-2 focus:ring-accent focus:border-transparent transition-all"
            type="text"
            name="email"
            id="email"
            placeholder="johndoe"
            v-model="form.username"
          />
          <p v-if="store.loginError" class="text-sm text-red-500 mt-1">
            Username or password are invalid
          </p>
        </div>

        <div class="flex flex-col gap-1">
          <label for="password" class="text-sm font-semibold text-secondary ml-1">Password</label>
          <input
            class="input w-full focus:ring-2 focus:ring-accent focus:border-transparent transition-all"
            type="password"
            name="password"
            id="password"
            placeholder="••••••••"
            v-model="form.password"
          />
        </div>

        <div class="flex items-center gap-2">
          <input type="checkbox" name="remember" id="remember" v-model="form.remember" class="w-4 h-4 text-accent rounded border-gray-300 focus:ring-accent" />
          <label for="remember" class="text-sm text-secondary cursor-pointer">Remember me</label>
        </div>

        <div class="flex flex-col gap-4 mt-2">
          <button class="bg-slate-900 hover:bg-slate-800 text-white font-bold py-3 px-6 rounded-lg shadow-md hover:shadow-lg transition-all transform hover:-translate-y-0.5 active:translate-y-0">
            Sign In
          </button>
          
          <div class="text-center text-sm text-secondary">
             <NuxtLink to="/register" class="text-accent hover:text-orange-600 font-semibold hover:underline">
               Create an account
             </NuxtLink>
          </div>
        </div>

      </form>
    </div>
  </div>
</template>

<script setup>
import { v4 as uuidv4 } from "uuid";
import { useUserStore } from "~/stores/userStore";

//data
const store = useUserStore();
const remember = ref(false);
let id = uuidv4();
const form = reactive({
  id: id,
  username: "",
  password: "",
  remember: remember,
});
const {$toast} = useNuxtApp();

//functions
async function signIn() {
  await store.signIn(form);
  if (store.userIsLoggedIn) {
    $toast.success("You are logged in", {
      timeout: 3000,
      
    });
  }
}
</script>

<style scoped>
.input {
  @apply bg-gray-50 border border-gray-300 text-gray-900 rounded-lg p-3 outline-none;
}
</style>
