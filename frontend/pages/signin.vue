<template>
  <div class="min-h-[80vh] flex items-center justify-center p-4">
    <div class="max-w-5xl w-full grid grid-cols-1 lg:grid-cols-2 bg-white rounded-[32px] shadow-premium overflow-hidden border border-slate-100">
      <!-- Left: Illustration -->
      <div class="hidden lg:flex flex-col justify-center items-center bg-indigo-50/50 p-12">
        <div class="mb-10 text-center">
          <h2 class="text-3xl font-bold text-dark tracking-tight">Expand Your Shelf</h2>
          <p class="text-slate-500 mt-2">Join thousands of readers exchanging stories.</p>
        </div>
        <img
          src="../assets/img/sign-in-img.png"
          alt="Login Illustration"
          class="w-full max-w-sm drop-shadow-2xl animate-in fade-in zoom-in duration-700"
        />
      </div>

      <!-- Right: Form -->
      <div class="p-8 lg:p-16 flex flex-col justify-center gap-10">
        <div class="text-center lg:text-left">
          <h1 class="text-4xl font-extrabold text-dark tracking-tight">Welcome Back</h1>
          <p class="text-slate-500 mt-3 font-medium">Please enter your details to sign in.</p>
        </div>

        <form @submit.prevent="signIn" @input="store.resetErrors" class="flex flex-col gap-6">
          <div class="flex flex-col gap-2">
            <label for="username" class="text-xs font-bold uppercase tracking-widest text-slate-400 ml-1">Username</label>
            <div class="relative group">
               <div class="absolute left-4 top-1/2 -translate-y-1/2 text-slate-400 group-focus-within:text-primary transition-colors">
                 <font-awesome-icon icon="fa-solid fa-user" />
               </div>
               <input
                v-model="form.username"
                id="username"
                type="text"
                placeholder="johndoe"
                class="input-field !pl-12"
              />
            </div>
          </div>

          <div class="flex flex-col gap-2">
            <label for="password" class="text-xs font-bold uppercase tracking-widest text-slate-400 ml-1">Password</label>
            <div class="relative group">
               <div class="absolute left-4 top-1/2 -translate-y-1/2 text-slate-400 group-focus-within:text-primary transition-colors">
                 <font-awesome-icon icon="fa-solid fa-lock" />
               </div>
               <input
                v-model="form.password"
                id="password"
                type="password"
                placeholder="••••••••"
                class="input-field !pl-12"
              />
            </div>
            <p v-if="store.loginError" class="text-xs text-red-500 font-medium ml-1 mt-1 animate-in shake duration-300">
              Invalid username or password. Please try again.
            </p>
          </div>

          <div class="flex items-center justify-between">
            <label class="flex items-center gap-2 cursor-pointer group">
              <input 
                type="checkbox" 
                v-model="form.remember" 
                class="w-4 h-4 rounded border-slate-300 text-primary focus:ring-primary transition-all" 
              />
              <span class="text-sm font-medium text-slate-500 group-hover:text-dark transition-colors">Remember me</span>
            </label>
            <NuxtLink to="/forgot-password" class="text-sm font-semibold text-primary hover:underline">Forgot Password?</NuxtLink>
          </div>

          <button class="btn-primary w-full !py-4 !rounded-2xl shadow-xl shadow-primary/20 mt-4 active:scale-95">
            Sign In to My Account
          </button>
        </form>

        <p class="text-center text-slate-500 font-medium">
          Don't have an account? 
          <NuxtLink to="/register" class="text-primary font-bold hover:underline">Create one for free</NuxtLink>
        </p>
      </div>
    </div>
  </div>
</template>

<script setup>
import { v4 as uuidv4 } from "uuid";
import { useUserStore } from "~/stores/userStore";
import { reactive, ref } from "vue";

const store = useUserStore();
const remember = ref(false);
const id = uuidv4();
const form = reactive({
  id: id,
  username: "",
  password: "",
  remember: remember,
});
const { $toast } = useNuxtApp();

async function signIn() {
  await store.signIn(form);
  if (store.userIsLoggedIn) {
    $toast.success("Welcome back! You're now signed in.");
  }
}
</script>
