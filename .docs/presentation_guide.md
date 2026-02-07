# Presentation Script: The Live Demo Guide

**Goal:** Show the project working perfectly in 5 minutes without crashing.

**Pre-Requisites (Do this BEFORE the presentation starts):**
1.  Run `make dev` to start the server.
2.  Open the browser to `localhost:3000`.
3.  **Clear your browser cache** or open an **Incognito Window** (to avoid weird autofill issues).
4.  Make sure you have a "Scripted User" ready (or rely on creating one live, as shown below).

---

## Phase 1: The Intro (0:00 - 1:00)
**Speaker:** "Good morning. We present **Boookz Exchange**, a platform to promote sustainable reading."
**Action:** Show the **Landing Page**.
*   **Say:** "As you can see, our landing page is fully responsive. It instantly shows books available for exchange."
*   **Action:** Scroll down slowly to show the "How it works" section or featured books.
*   **Action:** Resize the window to mobile width (if asked) to show the **Hamburger Menu** functionality.

## Phase 2: Registration & Onboarding (1:00 - 2:00)
**Say:** "Let's onboard a new user."
**Action:** Click **Sign Up**.
1.  **Fill Form:**
    *   **Name:** "John Doe"
    *   **Country:** **"US"** (CRITICAL: Type "US", not "USA").
    *   **Username:** "student_demo_1"
    *   **Email:** "demo1@example.com"
    *   **Password:** "Password123!"
2.  **Clear Autofill:** If your browser tries to autofill, delete it!
3.  **Click Register.**

**Say:** "We use secure Authentication. The user is now redirected to login."

## Phase 3: The "Wow" Factor (2:00 - 3:30)
**Action:** Log in with the user you just created.
**Say:** "Now logged in, I want to list a book I own."
**Action:** Go to **Profile** -> **Add Book** (or standard "Add Book" button if on nav).
1.  **Type:** "Harry Potter".
2.  **Wait:** Point at the screen.
3.  **Say:** "Notice the system automatically suggests titles. This connects to Google Books API."
4.  **Select:** "Harry Potter and the Philosopher's Stone".
5.  **Show:** "It automatically fetched the cover and author."
6.  **Click:** "Add Book".

## Phase 4: Browsing & Exchanging (3:30 - 4:30)
**Action:** Go to **Home Page**.
**Say:** "I can search for books I want."
1.  **Search:** Type "Great Gatsby".
2.  **Show:** "The search is instantaneous."
3.  **Click:** A book card.
4.  **Say:** "I can see details here. I can propose an exchange or, as the owner, I can manage the book."
5.  **Action:** Navigate to the book *you just added*.
6.  **Say:** "For books I own, I have **Edit** and **Remove** buttons directly on the page for easy management."

## Phase 5: Conclusion (4:30 - 5:00)
**Action:** Minimize browser, show **Terminal** (logs running).
**Say:** "Everything you saw is running locally on Docker containers, orchestrating a Django backend and Nuxt frontend alongside a Postgres database. Thank you."

---

## Emergency Troubleshooting (If things break)
*   **"System Error 500" on Register:** You probably typed "USA" instead of "US". Just reload and try again.
*   **"Login Failed":** Did you verify the email? (If running locally, check terminal logs for the link). *Pro Tip: Use a pre-verified account for the main demo to be safe.*

---

## Appendix: Test User Credentials
*Use these if you don't want to create a new user during the demo.*

| Username | Password |
| :--- | :--- |
| **root** | `toor` |
| **dina** | `password!@#` |
| **yaroslav** | `password!@#` |
| **asser** | `password!@#` |
| **youssef** | `password!@#` |
| **andrii** | `password!@#` |
