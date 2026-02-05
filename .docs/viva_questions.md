# Viva Questions & Answers (Comprehensive Guide)

## Domain & Methodology

### Q1: What is the core value proposition of this project?
**Answer:** "The project addresses the economic and environmental cost of reading. By enabling a localized peer-to-peer exchange network, we extend the lifecycle of physical books, reducing waste and making knowledge accessible without the cost of purchasing new copies."

### Q2: Explain your SDLC (Software Development Life Cycle).
**Answer:** "We utilized the **Agile Methodology**. We structured development into iterative sprints. We started with the MVP (Minimum Viable Product) focusing on core Auth and Book Listing features, then iteratively added complex features like the Google Books integration and Transaction system based on internal testing feedback."

---

## Backend Architecture (Django & Python)

### Q3: Why did you choose Django over lightweight frameworks like Flask?
**Answer:** "While Flask offers flexibility, Django provides a 'batteries-included' approach that is superior for this project's scope. Its built-in **ORM (Object-Relational Mapper)**, robust **Authentication User Model**, and admin interface allowed us to focus on business logic rather than reinventing boilerplate code. Security features like CSRF protection are also configured by default."

### Q4: Explain the role of the REST API in your architecture.
**Answer:** "The REST API serves as the interface between our decoupled frontend and backend. It adheres to stateless client-server usage. We use standard HTTP methods:
*   **GET** for retrieving resource representations (JSON).
*   **POST** for creating new resources.
*   **PUT/PATCH** for updating existing resources.
This separation allows the backend to potentially serve mobile apps or other clients in the future without modification."

### Q5: How do you handle Password Security?
**Answer:** "We strictly avoid storing plaintext passwords. We utilize Django's default authentication system which uses **PBKDF2** (Password-Based Key Derivation Function 2) with a SHA-256 hash. This incorporates a random **salt** for each user to protect against Rainbow Table attacks."

### Q6: What is the purpose of Database Migrations?
**Answer:** "Migrations are version control for our database schema. They are Python files that describe changes to the database structure (like adding a table or modifying a column). Running a migration translates these Python instructions into the specific SQL commands (DDL) required by PostgreSQL, ensuring the database schema evolves consistency with our codebase."

---

## Frontend Architecture (Nuxt.js & Vue)

### Q7: Differentiate between Client-Side Rendering (CSR) and Server-Side Rendering (SSR). Why use Nuxt?
**Answer:**
*   **CSR:** The browser downloads a minimal HTML file and JavaScript builds the UI. This can lead to slow initial load and poor SEO.
*   **SSR (Nuxt):** The server generates the full HTML page before sending it to the client.
*   **Choice:** We used Nuxt for SSR to ensure faster First Contentful Paint (FCP) and better indexability by search engines."

### Q8: Explain the concept of 'State Management' with Pinia.
**Answer:** "Pinia provides a centralized store for all the components in our application. It addresses the issue of 'prop drilling' (passing data through multiple layers of components). For example, the `UserStore` holds the authentication state (`isLoggedIn`, `token`). Any component, whether it's the Navbar or a Profile page, can access this state directly and reactively update if the state changes."

### Q9: How did you implement Mobile Responsiveness?
**Answer:** "We utilized **Tailwind CSS**, a utility-first framework. We used its breakpoint prefix system (e.g., `lg:flex`, `hidden`) to create a layout that adapts. For the Navbar specifically, we implemented a reactive state toggle that switches the layout from a horizontal row on desktop to a collapsible hamburger menu on mobile devices."

---

## Deployment & Infrastructure

### Q10: Why is Containerization (Docker) critical for this project?
**Answer:** "Docker resolves environment dependency issues. It encapsulates the application logic, runtime (Python/Node), and system libraries into a single **Image**. This ensures the application behaves identically in development, testing, and production environments, regardless of the underlying host OS."

### Q11: Explain the Relationship in your Database Schema.
**Answer:** "We utilize a Relational Schema:
*   **Users to Books:** A **One-to-Many** relationship (One user can own multiple books).
*   **Transactions:** A **Many-to-Many** logic enforced through a link table, connecting a Buyer ID and Seller ID to a specific Book ID, with a status field to track the exchange lifecycle."

---

## Advanced / "Distinction" Questions

### Q12: How does the Google Books API integration handle data inconsistency?
**Answer:** "External APIs can be unpredictable. We implement defensive programming: we request data based on ISBN or Title, but we check for key fields (like thumbnail availability) before saving. If the API returns incomplete data, we fallback to default placeholders to ensure the UI doesn't break."

### Q13: If this app scales to 100,000 users, what would break first?
**Answer:** "Likely the database read operations or the search functionality. To solve this, we would:
1.  Implement **Caching** (e.g., Redis) for frequently accessed data like the 'Featured Books'.
    2.  Offload search to a dedicated engine like **Elasticsearch** instead of relying on simple SQL database queries."

---

## Code-Specific / "Black Belt" Questions (The "Gotchas")
*These are questions specific to YOUR code that an examiner might ask if they look at your screen.*

### Q14: Why do you use `Pipfile` instead of `requirements.txt`?
**Answer:** "We use **Pipenv**. It manages dependencies more securely by creating a `Pipfile.lock`. This lock file ensures that every developer (and the production server) installs the EXACT same version of every library, preventing 'dependency hell'."

### Q15: In `authentication/models.py`, why use a Signal (`post_save`)?
**Answer:** "We automatically want to create a `BookReader` profile whenever a new `User` registers. The `post_save` signal listens for the User creation event and triggers the profile creation immediately. This prevents us from having to manually call `create_profile` in every view where a user might be created."

### Q16: What is `VersatileImageField` used for?
**Answer:** "It's a Django library that helps us handle images. It allows us to resize and crop images on-the-fly (e.g., creating a small thumbnail for the list view and a large cover for the detail view) without storing multiple files manually."

### Q17: In `nuxt.config.ts`, what is `runtimeConfig` doing?
**Answer:** "It solves the Docker networking issue. It allows us to define API URLs that change depending on where the code is running (e.g., `http://web:8000` inside the container vs `http://localhost:8000` in the browser). It hydrates these values at runtime so we don't need to rebuild the app just to change a URL."

### Q18: Your `Transaction` model has a `token` field. What is it?
**Answer:** "That is a unique identifier (UUID) for the transaction. We use it in URLs (e.g., `/transaction/<token>`) instead of the sequential ID (like `/transaction/1`). This prevents potential attackers from guessing other transaction IDs by simply incrementing the number (Enumeration Attack)."

### Q19: What is CORS and why did you configure it?
**Answer:** "CORS (Cross-Origin Resource Sharing) is a browser security feature. Since our Frontend runs on port `3000` and Backend on `8000`, browsers block requests by default. We installed `django-cors-headers` to explicitly allow our frontend domain to fetch data from our backend API."

### Q20: How would you automate testing for this project?
**Answer:** "We would verify the backend logic using **Django's TestCase** (Unit Tests) to check models and views. For the frontend, we could use **Cypress** or **Selenium** for End-to-End (E2E) testing, which simulates a real user clicking buttons and filling forms to ensure the full flow works."
