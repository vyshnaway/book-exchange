<template>
  <div class="min-h-[90vh] flex items-center justify-center p-4">
    <div class="max-w-6xl w-full grid grid-cols-1 lg:grid-cols-2 bg-white rounded-[40px] shadow-premium overflow-hidden border border-slate-100">
      
      <!-- Left: Illustration & Value Prop -->
      <div class="hidden lg:flex flex-col justify-center items-center bg-indigo-50/50 p-16">
        <div class="mb-12 text-center">
          <h2 class="text-4xl font-extrabold text-dark tracking-tight">Start Your Journey</h2>
          <p class="text-slate-500 mt-3 font-medium text-lg">Exchanging stories has never been more elegant.</p>
        </div>
        <img
          src="../assets/img/register-img.png"
          alt="Start your journey"
          class="w-full max-w-md drop-shadow-2xl animate-in slide-in-from-left duration-700"
        />
        <div class="mt-12 grid grid-cols-2 gap-6 w-full">
          <div class="flex items-center gap-3 text-slate-600 font-bold text-sm">
            <div class="w-8 h-8 rounded-full bg-primary/10 flex items-center justify-center text-primary">
              <font-awesome-icon icon="fa-solid fa-check" />
            </div>
            Free Forever
          </div>
          <div class="flex items-center gap-3 text-slate-600 font-bold text-sm">
            <div class="w-8 h-8 rounded-full bg-secondary/10 flex items-center justify-center text-secondary">
              <font-awesome-icon icon="fa-solid fa-users" />
            </div>
            Active Community
          </div>
        </div>
      </div>

      <!-- Right: Form -->
      <div class="p-8 lg:p-16 flex flex-col justify-center gap-10">
        <div class="text-center lg:text-left">
          <h1 class="text-4xl font-extrabold text-dark tracking-tight">Join Boookz</h1>
          <p class="text-slate-500 mt-3 font-medium">Create your account and start discovering treasures.</p>
        </div>

        <form @submit.prevent="register" @input="store.resetErrors" class="flex flex-col gap-5">
          <!-- Name Row -->
          <div class="grid grid-cols-1 sm:grid-cols-2 gap-5">
            <div class="flex flex-col gap-2">
              <label for="firstname" class="text-xs font-bold uppercase tracking-widest text-slate-400 ml-1">First Name</label>
              <input
                id="firstname"
                v-model="form.first_name"
                required
                type="text"
                placeholder="Jane"
                class="input-field"
              />
            </div>
            <div class="flex flex-col gap-2">
              <label for="lastname" class="text-xs font-bold uppercase tracking-widest text-slate-400 ml-1">Last Name</label>
              <input
                id="lastname"
                v-model="form.last_name"
                required
                type="text"
                placeholder="Doe"
                class="input-field"
              />
            </div>
          </div>

          <!-- Country Selection -->
          <div class="flex flex-col gap-2">
            <label for="country" class="text-xs font-bold uppercase tracking-widest text-slate-400 ml-1">Country Code</label>
            <input
              id="country"
              v-model="form.country"
              required
              type="text"
              placeholder="Ex: US, PL, GB"
              maxlength="2"
              class="input-field uppercase"
            />
          </div>

          <!-- Username & Email -->
          <div class="grid grid-cols-1 sm:grid-cols-2 gap-5">
             <div class="flex flex-col gap-2">
              <label for="username" class="text-xs font-bold uppercase tracking-widest text-slate-400 ml-1">Username</label>
              <input
                id="username"
                v-model="form.username"
                required
                type="text"
                placeholder="janedoe"
                class="input-field"
              />
              <p v-if="store.registerError.username" class="text-[10px] text-red-500 font-bold uppercase ml-1">
                {{ store.registerError.username[0] }}
              </p>
            </div>
            <div class="flex flex-col gap-2">
              <label for="email" class="text-xs font-bold uppercase tracking-widest text-slate-400 ml-1">Email</label>
              <input
                id="email"
                v-model="form.email"
                required
                type="email"
                placeholder="jane@example.com"
                class="input-field"
              />
              <p v-if="store.registerError.email" class="text-[10px] text-red-500 font-bold uppercase ml-1">
                {{ store.registerError.email[0] }}
              </p>
            </div>
          </div>

          <!-- Passwords -->
          <div class="grid grid-cols-1 sm:grid-cols-2 gap-5">
            <div class="flex flex-col gap-2">
              <label for="password" class="text-xs font-bold uppercase tracking-widest text-slate-400 ml-1">Password</label>
              <input
                id="password"
                v-model="form.password"
                required
                type="password"
                placeholder="••••••••"
                class="input-field"
              />
               <p v-if="store.registerError.password" class="text-[10px] text-red-500 font-bold uppercase ml-1">
                {{ store.registerError.password[0] }}
              </p>
            </div>
            <div class="flex flex-col gap-2">
              <label for="password2" class="text-xs font-bold uppercase tracking-widest text-slate-400 ml-1">Confirm Password</label>
              <input
                id="password2"
                v-model="form.password2"
                required
                type="password"
                placeholder="••••••••"
                class="input-field"
              />
              <p v-if="store.registerError.password2" class="text-[10px] text-red-500 font-bold uppercase ml-1">
                {{ store.registerError.password2[0] }}
              </p>
            </div>
          </div>

          <div class="flex items-center gap-2 mt-2">
            <input 
              type="checkbox" 
              id="remember" 
              v-model="form.remember" 
              class="w-4 h-4 rounded border-slate-300 text-primary focus:ring-primary transition-all" 
            />
            <label for="remember" class="text-sm font-medium text-slate-500 cursor-pointer">Agree to Terms & Privacy</label>
          </div>

          <button class="btn-primary w-full !py-4 !rounded-2xl shadow-xl shadow-primary/20 mt-4 active:scale-95 transition-all">
            Initialize My Account
          </button>
        </form>

        <p class="text-center text-slate-500 font-medium italic">
          Already a member? 
          <NuxtLink to="/signin" class="text-primary font-bold hover:underline not-italic ml-1">Sign in here</NuxtLink>
        </p>
      </div>
    </div>
  </div>
</template>

<script setup>
  import { useUserStore } from '~/stores/userStore';
  import { reactive, ref } from 'vue';

  const store = useUserStore();
  const remember = ref(false);
  const form = reactive({
    username: '',
    first_name: '',
    last_name: '',
    email: '',
    password: '',
    password2: '',
    country: '',
    remember: remember
  });

  const { $toast } = useNuxtApp();

  async function register() {
    store.resetErrors();
    await store.register(form);
    if (store.registerSuccess) {
      $toast.success("Welcome to Boookz! Your account is ready.");
      await navigateTo('/signin');
    }
  }
</script>
