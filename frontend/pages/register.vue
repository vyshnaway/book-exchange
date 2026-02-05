<template>
  <div
    class="flex flex-col md:flex-row md:mt-32 mx-auto justify-around items-center gap-1"
  >
    <div class="hidden md:block w-1/2">
      <img
        src="../assets/img/register-img.png"
        alt="Start your journey"
        class="w-full h-auto object-cover rounded-lg shadow-xl"
      />
    </div>

    <div class="w-full md:w-1/3 bg-white p-8 rounded-lg shadow-2xl border border-gray-100 my-8">
      <form
        @submit.prevent="register"
        @input="store.resetErrors"
        class="flex flex-col gap-4"
      >
        <h1 class="text-4xl font-bold text-primary text-center mb-2">Join BoookZ</h1>

        <div class="grid grid-cols-2 gap-2">
            <div class="flex flex-col">
              <input
                required
                class="input w-full"
                type="text"
                name="firstname"
                id="firstname"
                placeholder="First Name"
                v-model="form.first_name"
              />
            </div>

            <div class="flex flex-col">
              <input
                required
                class="input w-full"
                type="text"
                name="lastname"
                id="lastname"
                placeholder="Last Name"
                v-model="form.last_name"
              />
            </div>
        </div>

        <div>
          <input
            required
            class="input w-full"
            type="text"
            name="country"
            id="country"
            placeholder="Country"
            v-model="form.country"
          />
        </div>

        <div>
          <input
            required
            class="input w-full"
            type="text"
            name="username"
            id="username"
            placeholder="Username"
            v-model="form.username"
          />
          <p
            v-if="store.registerError.username"
            v-for="error in store.registerError.username"
            class="text-xs text-red-500 mt-1"
          >
            {{ error }}
          </p>
        </div>

        <div>
           <input
            required
            class="input w-full"
            type="email"
            name="email"
            id="email"
            placeholder="Email Address"
            v-model="form.email"
          />
          <p
            v-if="store.registerError.email"
            v-for="error in store.registerError.email"
            class="text-xs text-red-500 mt-1"
          >
            {{ error }}
          </p>
        </div>

        <div>
          <input
            required
            class="input w-full"
            type="password"
            placeholder="Password"
            v-model="form.password"
          />
          <!-- DEBUG TEXT REMOVED -->
          <p
            v-if="store.registerError.password"
            v-for="error in store.registerError.password"
            class="text-xs text-red-500 mt-1"
          >
            {{ error }}
          </p>
        </div>

        <div>
          <input
            required
            class="input w-full"
            type="password"
            placeholder="Repeat Password"
            v-model="form.password2"
          />
           <p
            v-if="store.registerError.password2"
            v-for="error in store.registerError.password2"
            class="text-xs text-red-500 mt-1"
          >
            {{ error }}
          </p>
        </div>

        <div class="flex items-center gap-2 mt-2">
            <input
                type="checkbox"
                name="remember"
                id="remember"
                v-model="form.remember"
                class="w-4 h-4 text-accent rounded border-gray-300 focus:ring-accent"
            />
            <label for="remember" class="text-sm text-secondary cursor-pointer">Remember me</label>
        </div>

        <button type="submit" class="bg-slate-900 hover:bg-slate-800 text-white font-bold py-3 rounded-lg shadow-md hover:shadow-lg transition-all mt-4">
            Create Account
        </button>
        
        <div class="text-center text-sm text-secondary mt-2">
             <NuxtLink to="/signin" class="text-accent hover:text-orange-600 font-semibold hover:underline">
               Already have an account? Sign in
             </NuxtLink>
        </div>

      </form>
    </div>
  </div>
</template>

<script setup>
  import { useUserStore } from '~/stores/userStore';
  //data
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
  });

  const {$toast} = useNuxtApp();

  //functions
  async function register() {
    store.resetErrors();
    await store.register(form);
    if (store.registerSuccess) {
      $toast.success('Registration successful', {
        timeout: 3000,
      });
      await navigateTo('/signin');
    }
  }
</script>

<style scoped>
.input {
  @apply bg-gray-50 border border-gray-300 text-gray-900 rounded-lg p-3 outline-none focus:ring-2 focus:ring-accent focus:border-transparent transition-all;
}
</style>
