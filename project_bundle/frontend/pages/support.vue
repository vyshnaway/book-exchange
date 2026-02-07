<template>
  <div class="max-w-4xl mx-auto px-4 py-20 animate-in fade-in duration-700">
    <div class="text-center mb-16 space-y-4">
      <h1 class="text-4xl md:text-5xl font-black text-dark tracking-tight">How can we help?</h1>
      <p class="text-slate-500 font-medium max-w-lg mx-auto">
        Have a question about an exchange or a suggestion for the community? Our team is here to support your reading journey.
      </p>
    </div>

    <div class="glass p-8 md:p-12 rounded-[40px] shadow-premium border border-white/40">
      <form @submit.prevent="sendToSupport" class="space-y-8">
        <div class="space-y-2">
          <label class="text-xs font-black uppercase tracking-[0.2em] text-slate-400 ml-1">Your Message</label>
          <div class="relative group">
            <textarea
              v-model="message"
              rows="6"
              class="input-field !py-6 !px-8 min-h-[200px] bg-white/50 group-hover:bg-white transition-all outline-none"
              placeholder="Tell us what's on your mind..."
            ></textarea>
            <div class="absolute bottom-4 right-4 text-slate-300 pointer-events-none">
               <font-awesome-icon icon="fa-solid fa-pen-nib" class="text-xl" />
            </div>
          </div>
        </div>

        <div class="flex flex-col sm:flex-row items-center justify-between gap-6 pt-4">
          <div class="flex items-center gap-4 text-slate-400 text-sm font-medium">
             <div class="w-10 h-10 rounded-full bg-emerald-50 flex items-center justify-center text-emerald-500">
                <font-awesome-icon icon="fa-solid fa-bolt-lightning" />
             </div>
             <span>Average response time: 24h</span>
          </div>
          
          <button
            type="submit"
            class="btn-primary w-full sm:w-auto !px-12 !py-4 !rounded-2xl shadow-xl shadow-primary/20 active:scale-95 transition-all flex items-center justify-center gap-3 font-black"
          >
            <span>Send Message</span>
            <font-awesome-icon icon="fa-solid fa-paper-plane" class="text-xs" />
          </button>
        </div>
      </form>
    </div>

    <!-- Alternative Contact -->
    <div class="mt-16 grid grid-cols-1 sm:grid-cols-2 gap-6">
       <div class="p-6 rounded-3xl bg-slate-50 border border-slate-100 flex items-center gap-4">
          <div class="w-12 h-12 rounded-2xl bg-white shadow-sm flex items-center justify-center text-primary">
             <font-awesome-icon icon="fa-solid fa-envelope" />
          </div>
          <div>
             <p class="text-[10px] font-black uppercase tracking-widest text-slate-400">Email us at</p>
             <p class="font-bold text-dark">support@boookz.com</p>
          </div>
       </div>
       <div class="p-6 rounded-3xl bg-slate-50 border border-slate-100 flex items-center gap-4">
          <div class="w-12 h-12 rounded-2xl bg-white shadow-sm flex items-center justify-center text-primary">
             <font-awesome-icon icon="fa-solid fa-comments" />
          </div>
          <div>
             <p class="text-[10px] font-black uppercase tracking-widest text-slate-400">Community</p>
             <p class="font-bold text-dark">Join our Discord</p>
          </div>
       </div>
    </div>
  </div>
</template>

<script setup>
  import { ref } from 'vue';
  import { useUserStore } from '~/stores/userStore';

  const userStore = useUserStore();
  const message = ref('');
  const { $toast } = useNuxtApp();

  function sendToSupport() {
    if (!message.value.trim()) {
      $toast.error('Please enter a message before sending.');
      return;
    }
    
    userStore.sendToSupport(message.value);
    message.value = '';
    $toast.success('Your message has been sent to our support team!');
  }
</script>
