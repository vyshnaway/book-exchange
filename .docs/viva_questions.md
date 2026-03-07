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
**Answer:** "Docker resolves the 'it works on my machine' problem. It encapsulates the app logic, runtime (Python/Node), and OS libraries into container **Images**. We use a **Multi-Container Architecture** (Frontend, Backend, and Database) which ensures the entire system behaves identically in development and production, regardless of the host OS."

### Q11: Explain the Relationship in your Database Schema.
**Answer:** "We utilize a Relational Schema:
*   **Users to BookReader:** A **One-to-One** relationship (Every user has exactly one profile).
*   **BookReader to Books:** A **One-to-Many** relationship (A user can list multiple books).
*   **Transactions:** Connects a **Buyer**, **Seller**, and **specific Books**. It uses a status field (`Initiated`, `Accepted`, `Completed`) to track the exchange lifecycle."

---

## Advanced Questions

### Q12: How does the Google Books API integration handle data inconsistency?
**Answer:** "External APIs can be unpredictable. We implement defensive programming: we request data based on the title, but we check for key fields (like images or authors) before saving. If the API returns incomplete data, we fallback to default placeholders or allow manual input to ensure the UI doesn't break."

### Q13: If this app scales to 100,000 users, what would break first?
**Answer:** "Likely the database read operations or the search functionality. To solve this, we would:
1.  Implement **Caching** (e.g., Redis) for frequently accessed data.
2.  Offload search to a dedicated engine like **Elasticsearch** instead of relying on simple SQL queries.
3.  Use **Load Balancers** to distribute traffic across multiple container instances."

---

## Code-Specific Questions

### Q14: Why do you use `Pipfile` instead of `requirements.txt`?
**Answer:** "We use **Pipenv**. It manages dependencies more securely by creating a `Pipfile.lock`. This ensures every developer (and the Docker container) installs the EXACT same version of every library, preventing 'dependency hell'."

### Q15: In `authentication/models.py`, why use a Signal (`post_save`)?
**Answer:** "We automatically want to create a `BookReader` profile whenever a new `User` registers. The `post_save` signal listens for the User creation event and triggers the profile creation immediately. It ensures every user always has a corresponding profile without manual intervention."

### Q16: What is `VersatileImageField` used for?
**Answer:** "It's a Django library that helps us handle images efficiently. It allows us to manage PPOI (Primary Point of Interest) and can be used to generate different sizes/crops of images on-the-fly if needed, ensuring the UI always looks clean regardless of the original image aspect ratio."

### Q17: In `nuxt.config.ts`, what is `runtimeConfig` doing?
**Answer:** "It handles environment-specific variables. It allows us to define API URLs that change depending on the context (e.g., internal Docker networking vs. external browser access). Crucially, `public.apiBase` is used by the browser to talk to the Backend at `localhost:8000`."

### Q18: Your `Transaction` model has a `token` field. What is it?
**Answer:** "That is a **UUID** (Universally Unique Identifier). We use it as the primary key for transactions in the frontend. It's much more secure than a sequential ID (like `1`, `2`, `3`) because it's virtually impossible to guess, protecting user transaction data from enumeration attacks."

### Q19: What is CORS and why did you configure it?
**Answer:** "CORS (Cross-Origin Resource Sharing) is a browser security feature. Since our Frontend (`3000`) and Backend (`8000`) run on different ports, the browser blocks requests by default. We configured `django-cors-headers` to explicitly allow our frontend to communicate with our API."

### Q20: How did you implement "Edit" and "Remove" for books?
**Answer:** "We added action buttons to the **Book Details** page that only appear for the book's owner. 'Edit' redirects to a pre-filled form in the AddBook view using a query parameter, while 'Remove' triggers a DELETE request to our API after a user confirmation, ensuring users can manage their inventory seamlessly."

---

## Specialized Features

### Q21: You encountered a "Hydration Mismatch" error with the Country Selector. How did you fix it?
**Answer:** "The issue was that the server (SSR) rendered the initial HTML differrently than the client (CSR) because the user's local storage (needed to pre-fill the country) wasn't available on the server. To fix this, we wrapped the component in a `<ClientOnly>` tag. this tells Nuxt to skip rendering that specific part on the server and only render it once the page is fully loaded in the browser."

### Q22: Why did you use Mermaid JS for your diagrams instead of drawing them?
**Answer:** "Mermaid is a **Internal Domain-Specific Language (DSL)**. By writing our diagrams as code, we can version control them just like our source code. If we change the database schema, we simply update the text file, and the diagram automatically rebuilds. It ensures our documentation never gets 'stale' or out of sync with the actual implementation."

### Q23: What is the purpose of the `Makefile` you added?
**Answer:** "The `Makefile` simplifies complex Docker commands into simple shortcuts. Instead of typing `docker-compose -f docker-compose.yml up --build`, a developer simply types `make dev`. This reduces cognitive load, minimizes typing errors, and standardizes the development workflow across the entire team."

### Q24: In your Database, why are Authors a Many-to-Many relationship?
**Answer:** "A single book can have multiple authors (e.g., 'Good Omens' by Pratchett & Gaiman), and a single author writes multiple books. Using a simple ForeignKey would be incorrect because it would limit a book to one author. We use a **Many-to-Many** field which creates a hidden intermediate table in the database to link books and authors flexibly."

### Q25: How does your deployment strategy work?
**Answer:** "We use a `make deploy` command that orchestrates the production build. It pulls the latest code, builds optimized Docker images (stripping out dev dependencies), and restarts the containers. This ensures that the production environment is always running the exact same version of the code that we tested locally."
