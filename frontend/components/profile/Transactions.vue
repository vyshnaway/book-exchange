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
        <!-- Visual Stepper (Simplified to 3 steps) -->
        <div class="w-full mb-8">
          <div v-if="transaction.transaction_status === 'Declined'" class="w-full p-3 bg-red-50 border border-red-100 rounded-xl flex items-center justify-center gap-2 text-red-500 font-bold text-xs uppercase tracking-widest">
            <font-awesome-icon icon="fa-solid fa-ban" />
            <span>Transaction Declined</span>
          </div>
          
          <div v-else class="relative flex justify-between items-center w-full">
            <!-- Progress Line -->
            <div class="absolute left-0 top-1/2 -translate-y-1/2 w-full h-1 bg-slate-100 rounded-full z-0"></div>
            <div 
              class="absolute left-0 top-1/2 -translate-y-1/2 h-1 bg-primary transition-all duration-500 rounded-full z-0"
              :style="{ width: `${(getStepIndex(transaction.transaction_status) / 2) * 100}%` }"
            ></div>

            <!-- Steps: Pending → Accepted → Completed -->
            <div 
              v-for="(step, i) in ['Pending', 'Accepted', 'Completed']" 
              :key="step"
              class="relative z-10 flex flex-col items-center gap-2 group"
            >
              <div 
                class="w-8 h-8 rounded-full flex items-center justify-center text-[10px] font-black border-2 transition-all duration-300"
                :class="i <= getStepIndex(transaction.transaction_status) 
                  ? 'bg-primary border-primary text-white shadow-lg shadow-primary/30 scale-110' 
                  : 'bg-white border-slate-200 text-slate-300'"
              >
                <font-awesome-icon v-if="i < getStepIndex(transaction.transaction_status)" icon="fa-solid fa-check" />
                <span v-else>{{ i + 1 }}</span>
              </div>
              <span 
                class="absolute -bottom-6 text-[9px] font-bold uppercase tracking-wider whitespace-nowrap transition-colors duration-300"
                :class="i <= getStepIndex(transaction.transaction_status) ? 'text-primary' : 'text-slate-300'"
              >
                {{ step }}
              </span>
            </div>
          </div>
        </div>

        <!-- Exchange Visualization -->
        <div class="grid grid-cols-1 md:grid-cols-[1fr,auto,1fr] items-center gap-6 md:gap-12 relative mt-4">
          <!-- Item 1 -->
          <div class="flex flex-col items-center md:items-end text-center md:text-right gap-3 p-4 bg-white/50 rounded-2xl border border-white/60">
            <span class="text-[10px] font-black uppercase tracking-widest text-slate-400">Initiator</span>
            <NuxtLink :to="`/books/${transaction.initiator_book.pk}`" class="hover:text-primary transition-colors">
              <h4 class="text-lg font-bold text-dark">{{ transaction.initiator_book.title }}</h4>
            </NuxtLink>
            <NuxtLink :to="`/profile/${transaction.book_reader_initiator.username}`" class="flex items-center gap-2 text-primary font-bold text-sm hover:underline">
              <font-awesome-icon icon="fa-solid fa-user" class="text-[10px]" />
              {{ transaction.book_reader_initiator.username }}
            </NuxtLink>
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
            <NuxtLink :to="`/books/${transaction.receiver_book.pk}`" class="hover:text-secondary transition-colors">
              <h4 class="text-lg font-bold text-dark">{{ transaction.receiver_book.title }}</h4>
            </NuxtLink>
            <NuxtLink :to="`/profile/${transaction.book_reader_receiver.username}`" class="flex items-center gap-2 text-secondary font-bold text-sm hover:underline">
              <font-awesome-icon icon="fa-solid fa-user" class="text-[10px]" />
              {{ transaction.book_reader_receiver.username }}
            </NuxtLink>
          </div>
        </div>

        <!-- Actions Footer (Hidden for other profiles) -->
        <div v-if="editable" class="mt-10 pt-8 border-t border-slate-100/50 flex flex-wrap justify-center md:justify-end gap-4">
          <!-- Pending: Only receiver can accept/decline -->
          <template v-if="isPending(transaction) && isReceiver(transaction)">
            <button @click="acceptTransaction(transaction.token)" class="btn-primary !py-2.5 !px-8 !text-xs !rounded-xl">
              <font-awesome-icon icon="fa-solid fa-check" class="mr-2" />
              Accept Trade
            </button>
            <button @click="declineTransaction(transaction.token)" class="btn-outline !py-2.5 !px-8 !text-xs !rounded-xl !text-red-500 !border-red-100 hover:!bg-red-50">
              <font-awesome-icon icon="fa-solid fa-times" class="mr-2" />
              Decline
            </button>
          </template>

          <!-- Pending: Initiator sees waiting message -->
          <div v-else-if="isPending(transaction) && !isReceiver(transaction)" class="flex items-center gap-3 px-6 py-3 bg-amber-50 border border-amber-100 rounded-xl text-amber-700">
            <font-awesome-icon icon="fa-solid fa-clock" class="text-lg animate-pulse" />
            <span class="font-semibold text-sm">Waiting for Response...</span>
          </div>

          <!-- Accepted: Both users can mark as completed -->
          <button 
            v-if="isAccepted(transaction)"
            @click="confirmBookRecieved(transaction.token)" 
            class="btn-primary !py-2.5 !px-8 !text-xs !rounded-xl bg-emerald-600 hover:bg-emerald-700 shadow-emerald-200"
          >
            <font-awesome-icon icon="fa-solid fa-box-check" class="mr-2" />
            Mark as Completed
          </button>

          <!-- Rating Action -->
          <button 
            v-if="isCompleted(transaction.transaction_status)" 
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

  const { editable = false } = defineProps({
    editable: {
      type: Boolean,
      default: false
    }
  });

  const route = useRoute().params;
  // Fallback to route check if editable is not strictly set (or trust prop)
  const store = !route.id ? useUserStore() : useProfileStore();
  const commentShown = ref(false);
  const transactionIndex = ref(null);
  
  const form = reactive({
    rating: 5,
    comment: '',
  });

  // SIMPLIFIED: Helper functions for 3-state system
  function isPending(transaction) {
    return transaction.transaction_status === 'Initiated';
  }

  function isAccepted(transaction) {
    return transaction.transaction_status === 'Accepted';
  }

  function isReceiver(transaction) {
    const receiverName = transaction.book_reader_receiver?.username || transaction.book_reader_receiver;
    return receiverName === store.userName;
  }

  function isCompleted(status) {
    return status?.toLowerCase().trim() === 'completed';
  }

  // SIMPLIFIED: 3-state step mapping
  function getStepIndex(status) {
    switch(status) {
      case 'Initiated': return 0;  // Pending
      case 'Accepted': return 1;   // Accepted
      case 'Completed': return 2;  // Completed
      default: return 0;
    }
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
