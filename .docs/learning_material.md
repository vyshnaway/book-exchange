# Project Architecture & Technical Overview

## 1. Project Overview
**Boookz Exchange** is a peer-to-peer book exchange platform designed to promote sustainable reading. It functions as a specialized marketplace where users can list books they own and request books they wish to read, facilitating a direct exchange of resources.

### Core Functionality
1.  **Inventory Management:** Users catalogue their personal book collection.
2.  **Discovery Engine:** A search system to locate available books within the network.
3.  **Exchange Logic:** A transaction system to manage the lifecycle of a book swap (Request -> Accept -> Complete).

---

## 2. System Architecture

The application follows a **Decoupled Client-Server Architecture**, separating the user interface (Frontend) from the business logic and data management (Backend).

### A. The Frontend (Client-Side)
*   **Technology:** **Nuxt.js (Vue.js Framework)**
*   **Role:** Handles User Interface (UI) rendering, client-side routing, and state management.
*   **Why Nuxt.js?**
    *   **Server-Side Rendering (SSR):** Pre-renders pages on the server for faster initial load times and better SEO, crucial for a public-facing platform.
    *   **Automatic Routing:** Simplifies the creation of complex page structures.

### B. The Backend (Server-Side)
*   **Technology:** **Django (Python)** containing the **Django REST Framework (DRF)**.
*   **Role:** Acts as the central API provider. It processes business logic, enforces security policies, and manages database interactions.
*   **Why Django?**
    *   **Rapid Development:** Includes built-in authentication, an ORM (Object-Relational Mapping), and an admin interface.
    *   **Security:** Default protection against common vulnerabilities like SQL Injection and XSS (Cross-Site Scripting).

### C. The Database (Persistence Layer)
*   **Technology:** **PostgreSQL**.
*   **Role:** Relational database management system (RDBMS) storing all structured data.
*   **Schema Highlights:**
    *   `Users`: Authentication credentials.
    *   `BookReader`: User profiles, country, and notifications.
    *   `Books`: Metadata (Title, Author) and images gallery.
    *   `Transactions`: Linking Buyer, Seller, and Book state.

### D. The Interface (API)
*   **Protocol:** **REST (Representational State Transfer)** over HTTP.
*   **Format:** JSON (JavaScript Object Notation).
*   **Data Flow:**
    1.  **Request:** Frontend sends an HTTP `GET` request to `/api/data/giveaway/`.
    2.  **Processing:** Django queries the PostgreSQL database via ORM.
    3.  **Serialization:** Django REST Framework converts Python objects into JSON.
    4.  **Response:** Frontend receives JSON and renders the UI.

---

## 3. Key Technical Implementations

### Authentication & Authorization (JWT)
We implement Stateless Authentication using **JSON Web Tokens (JWT)**.
*   **Mechanism:** Upon login, the server issues an `access` token and a `refresh` token.
*   **Validation:** Every API request includes the `access` token in the header. The backend validates it without needing to check the database session, increasing performance.

### Third-Party Integration: Google Books API
To enhance user experience (UX), we integrated the **Google Books API**.
*   **Function:** When a user lists a book, the system queries Google's database using the title.
*   **Benefit:** Automatically populates images, authors, and categories, ensuring data consistency and saving time.

### Infrastructure: Multi-Container Docker Setup
The entire application is containerized for maximum reliability.
*   **Service Isolation:** The Frontend (Nuxt), Backend (Django), and Database (Postgres) run in separate, isolated containers.
*   **Network Orchestration:** Docker Compose manages the internal network, allowing the Nuxt server to talk to the Django API securely using internal container names.

---

## 4. Technology Stack Justification

| Technology | Technical Justification |
| :--- | :--- |
| **Python (Django)** | Robust ecosystem for rapid API development; strict MVT (Model-View-Template) pattern enforces code organization. |
| **Vue/Nuxt.js** | Component-based architecture allows for reusable UI elements; SSR capability improves performance on low-end devices. |
| **PostgreSQL** | ACID-compliant transactional database, essential for ensuring the integrity of exchange records. |
| **Tailwind CSS** | Utility-first CSS framework allowing for rapid, cohesive UI development without context-switching to CSS files. |
