<template>
  <div class="max-w-5xl mx-auto px-4 py-12">
    <div class="grid grid-cols-1 lg:grid-cols-3 gap-12">
      <!-- Sidebar Info -->
      <div class="lg:col-span-1 border-r border-slate-100 pr-8 hidden lg:block">
        <h1 class="text-3xl font-extrabold text-dark tracking-tight">Account Settings</h1>
        <p class="text-slate-500 mt-2 font-medium">Manage your profile, personal data and privacy settings.</p>
        
        <div class="mt-12 flex flex-col gap-4">
          <div class="p-4 bg-indigo-50 rounded-2xl flex items-center gap-4 text-primary">
            <font-awesome-icon icon="fa-solid fa-user-gear" />
            <span class="font-bold text-sm uppercase tracking-wider">General</span>
          </div>
          <div class="p-4 hover:bg-slate-50 rounded-2xl flex items-center gap-4 text-slate-400 transition-colors cursor-pointer">
            <font-awesome-icon icon="fa-solid fa-shield-halved" />
            <span class="font-bold text-sm uppercase tracking-wider">Privacy</span>
          </div>
        </div>
      </div>

      <!-- Main Content -->
      <div class="lg:col-span-2 flex flex-col gap-12">

        <!-- Personal Data Section -->
        <section class="glass p-8 rounded-3xl shadow-premium">
          <h2 class="text-xl font-bold text-dark mb-8">Personal Details</h2>
          <form @submit.prevent="updateData" class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div class="flex flex-col gap-2">
              <label class="text-xs font-bold uppercase tracking-widest text-slate-400 ml-1">First Name</label>
              <input v-model="userForm.name" type="text" :placeholder="userStore.firstName || 'Your name'" class="input-field" />
            </div>
            <div class="flex flex-col gap-2">
              <label class="text-xs font-bold uppercase tracking-widest text-slate-400 ml-1">Last Name</label>
              <input v-model="userForm.surname" type="text" :placeholder="userStore.lastName || 'Your surname'" class="input-field" />
            </div>
            <div class="flex flex-col gap-2 md:col-span-2">
              <label class="text-xs font-bold uppercase tracking-widest text-slate-400 ml-1">Residential Country</label>
              <input v-model="userForm.country" type="text" :placeholder="userStore.region || 'Enter country'" class="input-field" />
            </div>
            
            <div class="md:col-span-2 pt-4">
              <button type="submit" class="btn-primary w-full md:w-auto !px-8 shadow-lg">Save Personal Data</button>
            </div>
          </form>
        </section>

        <!-- Privacy Section -->
        <section class="glass p-8 rounded-3xl shadow-premium">
          <h2 class="text-xl font-bold text-dark mb-8">Security & Privacy</h2>
          <form @submit.prevent="updatePrivacy" class="flex flex-col gap-6">
            <div class="flex flex-col gap-2">
              <label class="text-xs font-bold uppercase tracking-widest text-slate-400 ml-1">Current Password</label>
              <input v-model="userForm.password" type="password" class="input-field" placeholder="••••••••" />
            </div>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
              <div class="flex flex-col gap-2">
                <label class="text-xs font-bold uppercase tracking-widest text-slate-400 ml-1">New Password</label>
                <input v-model="userForm.newPassword" type="password" class="input-field" placeholder="••••••••" />
              </div>
              <div class="flex flex-col gap-2">
                <label class="text-xs font-bold uppercase tracking-widest text-slate-400 ml-1">Confirm New Password</label>
                <input v-model="userForm.passwordConfirm" type="password" class="input-field" placeholder="••••••••" />
              </div>
            </div>
            
            <div class="pt-4 border-slate-50">
              <button type="submit" class="btn-primary w-full md:w-auto !px-8 shadow-lg">Update Security</button>
            </div>
          </form>
        </section>
      </div>
    </div>
  </div>
</template>

<script setup>
import { reactive } from "vue";
import { useUserStore } from "~/stores/userStore";
import avatarPlaceholder from "~/assets/img/avatar.png";

const { $toast } = useNuxtApp();
const userStore = useUserStore();

const userForm = reactive({
  name: "",
  surname: "",
  country: "",
  password: "",
  newPassword: "",
  passwordConfirm: "",
});

function updateData() {
  $toast.success("Personal data updated successfully");
}

function updatePrivacy() {
  if (userForm.newPassword !== userForm.passwordConfirm) {
    $toast.error("Passwords do not match");
    return;
  }
  $toast.success("Security settings updated");
}

function removePicture() {
  console.log("remove picture");
  $toast.info("Avatar removed");
}

function changePicture() {
  console.log("change picture");
  $toast.info("Select a new picture from your device");
}
</script>

//add email 
// split forms 
// add validation
