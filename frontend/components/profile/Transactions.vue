<template>
  <div class="flex flex-col gap-8">
    <!-- Header -->
    <div class="border-b border-slate-100 pb-6">
      <h2 class="text-2xl font-black text-dark tracking-tight">Exchange History</h2>
      <p class="text-slate-500 text-sm font-medium mt-1">Track your past and ongoing book trades</p>
    </div>

    <!-- Transactions List -->
    <div v-if="store.userTransactions.length" class="flex flex-col gap-8">
      <div
        v-for="(transaction, index) in store.userTransactions"
        :key="transaction.token"
        class="glass p-6 md:p-8 rounded-[32px] shadow-premium hover:shadow-2xl transition-all duration-300 border border-white/40"
      >
        <!-- Date & Status Badge -->
        <div class="flex justify-between items-center mb-8">
          <div class="flex items-center gap-2 text-slate-400 font-bold text-[10px] uppercase tracking-widest">
            <font-awesome-icon icon="fa-solid fa-calendar-days" />
            <span>{{ transaction.created }}</span>
          </div>
          
          <div 
            class="px-4 py-1.5 rounded-full text-[10px] font-black uppercase tracking-widest shadow-sm"
            :class="{
              'bg-amber-100 text-amber-600 shadow-amber-100/50': transaction.transaction_status === 'Initiated',
              'bg-blue-100 text-blue-600 shadow-blue-100/50': transaction.transaction_status === 'Accepted',
              'bg-emerald-100 text-emerald-600 shadow-emerald-100/50': transaction.transaction_status === 'Completed',
              'bg-slate-100 text-slate-500': transaction.transaction_status === 'Declined'
            }"
          >
            {{ transaction.transaction_status }}
          </div>
        </div>

        <!-- Exchange Visualization -->
        <div class="grid grid-cols-1 md:grid-cols-[1fr,auto,1fr] items-center gap-6 md:gap-12 relative">
          <!-- Item 1 -->
          <div class="flex flex-col items-center md:items-end text-center md:text-right gap-3 p-4 bg-white/50 rounded-2xl border border-white/60">
            <span class="text-[10px] font-black uppercase tracking-widest text-slate-400">Initiator</span>
            <h4 class="text-lg font-bold text-dark">{{ transaction.initiator_book }}</h4>
            <div class="flex items-center gap-2 text-primary font-bold text-sm">
              <font-awesome-icon icon="fa-solid fa-user" class="text-[10px]" />
              {{ transaction.book_reader_initiator }}
            </div>
          </div>

          <!-- Arrow -->
          <div class="flex flex-col items-center gap-2">
            <div class="w-12 h-12 bg-primary/10 text-primary rounded-full flex items-center justify-center shadow-inner">
               <font-awesome-icon 
                icon="fa-solid fa-right-left" 
                class="text-xl"
              />
            </div>
            <span class="text-[10px] font-black uppercase tracking-widest text-slate-300">Exchanged With</span>
          </div>

          <!-- Item 2 -->
          <div class="flex flex-col items-center md:items-start text-center md:text-left gap-3 p-4 bg-white/50 rounded-2xl border border-white/60">
            <span class="text-[10px] font-black uppercase tracking-widest text-slate-400">Receiver</span>
            <h4 class="text-lg font-bold text-dark">{{ transaction.receiver_book }}</h4>
            <div class="flex items-center gap-2 text-secondary font-bold text-sm">
              <font-awesome-icon icon="fa-solid fa-user" class="text-[10px]" />
              {{ transaction.book_reader_receiver }}
            </div>
          </div>
        </div>

        <!-- Actions Footer -->
        <div class="mt-10 pt-8 border-t border-slate-100/50 flex flex-wrap justify-center md:justify-end gap-4">
          <!-- Initiated Actions -->
          <template v-if="transaction.transaction_status === 'Initiated' && transaction.book_reader_initiator !== store.userName">
            <button @click="acceptTransaction(transaction.token)" class="btn-primary !py-2.5 !px-8 !text-xs !rounded-xl">Accept Trade</button>
            <button @click="declineTransaction(transaction.token)" class="btn-outline !py-2.5 !px-8 !text-xs !rounded-xl !text-red-500 !border-red-100 hover:!bg-red-50">Decline</button>
          </template>

          <!-- Recieved Action -->
          <button 
            v-if="shouldShowReceived(transaction)"
            @click="confirmBookRecieved(transaction.token)" 
            class="btn-primary !py-2.5 !px-8 !text-xs !rounded-xl bg-emerald-600 hover:bg-emerald-700 shadow-emerald-200"
          >
            I've Received the Book
          </button>

          <!-- Rating Action -->
          <button 
            v-if="transaction.transaction_status === 'Completed'" 
            @click="showComment(index)"
            class="btn-outline !py-2.5 !px-8 !text-xs !rounded-xl flex items-center gap-2"
          >
            <font-awesome-icon icon="fa-solid fa-star" class="text-amber-400" />
            Rate This Transaction
          </button>
        </div>

        <!-- Rating Form Expansion -->
        <div 
          v-if="commentShown && index === transactionIndex" 
          class="mt-6 p-6 bg-slate-50/80 rounded-2xl animate-in slide-in-from-top-4 duration-300"
        >
          <form @submit.prevent="rateTransaction(transaction.token)" class="flex flex-col gap-6">
            <div class="grid grid-cols-1 md:grid-cols-[1fr,200px] gap-6">
              <div class="flex flex-col gap-2">
                <label class="text-xs font-bold uppercase tracking-widest text-slate-400 ml-1">Your Feedback</label>
                <textarea
                  v-model="form.comment"
                  placeholder="How was the exchange experience? Was the book in good condition?"
                  class="input-field min-h-[100px] !py-4"
                />
              </div>
              <div class="flex flex-col gap-2">
                <label class="text-xs font-bold uppercase tracking-widest text-slate-400 ml-1">Rating (1-5)</label>
                <div class="flex items-center gap-3 h-[52px]">
                   <input
                    v-model="form.rating"
                    type="number"
                    max="5"
                    min="1"
                    class="input-field !w-20 text-center font-bold"
                  />
                  <div class="flex gap-1 text-amber-400">
                    <font-awesome-icon v-for="i in 5" :key="i" icon="fa-solid fa-star" :class="i <= (form.rating || 0) ? 'opacity-100' : 'opacity-20'" />
                  </div>
                </div>
              </div>
            </div>
            <div class="flex justify-end">
              <button type="submit" class="btn-primary !py-3 !px-10 !rounded-xl !text-xs">Submit Rating</button>
            </div>
          </form>
        </div>
      </div>
    </div>

    <!-- Empty State -->
    <div v-else class="py-20">
      <LazyProfilePlaceHolder />
    </div>
  </div>
</template>

<script setup>
  import { useUserStore } from '~/stores/userStore';
  import { useProfileStore } from '~/stores/profileStore';
  import { ref, reactive } from 'vue';

  const route = useRoute().params;
  const store = !route.id ? useUserStore() : useProfileStore();
  const commentShown = ref(false);
  const transactionIndex = ref(null);
  
  const form = reactive({
    rating: 5,
    comment: '',
  });

  function shouldShowReceived(transaction) {
    const status = transaction.transaction_status;
    const isInitiator = transaction.book_reader_initiator === store.userName;
    
    if (status === 'Accepted') return true;
    if (status === 'Received by initiating user' && !isInitiator) return true;
    if (status === 'Received by receiving user' && isInitiator) return true;
    
    return false;
  }

  function acceptTransaction(token) {
    store.acceptTransaction(token);
  }

  function declineTransaction(token) {
    store.declineTransaction(token);
  }

  function confirmBookRecieved(token) {
    store.confirmBookRecieved(token);
  }

  function showComment(index) {
    transactionIndex.value = index;
    commentShown.value = !commentShown.value;
  }

  async function rateTransaction(token) {
    await store.rateTransaction(token, form);
    commentShown.value = false;
  }
</script>
