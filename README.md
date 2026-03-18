# 📚 Boookz Exchange
**Sustainable Reading through Peer-to-Peer Exchange**

Boookz Exchange is a full-stack web application designed for students and book lovers to catalogue, search, and swap physical books within a localized network.

---

## ⚡ Quick Start (Docker)
The entire application is containerized for a "Zero-Setup" experience.

1.  **Clone & Enter:**
    ```bash
    git clone [repo-url] && cd repo
    ```
2.  **Deploy (Production-like):**
    ```bash
    make deploy
    ```
    *This builds all containers, runs migrations, and creates demo users automatically.*

3.  **Development Mode (Optional):**
    ```bash
    make dev
    ```

4.  **Access:**
    - **Frontend:** [http://localhost:3000](http://localhost:3000)
    - **API Docs:** [http://localhost:8000/api/docs](http://localhost:8000/api/docs)

---

## 🔐 Demo Credentials
The following users are **automatically created** when you run `make deploy`. You can use them to log in immediately.

| Username | Password |
| :--- | :--- |
| **root** | `toor` |
| **dina** | `password!@#` |
| **yaroslav** | `password!@#` |
| **asser** | `password!@#` |
| **youssef** | `password!@#` |
| **andrii** | `password!@#` |

---

## 🛠️ Tech Stack

### Core Architecture
- **Frontend:** [Nuxt.js 3](https://nuxt.com/) (Vue.js Framework) - Server-Side Rendered (SSR) for SEO and performance.
- **Backend:** [Django REST Framework](https://www.django-rest-framework.org/) - Robust API engine with JWT Authentication.
- **Database:** [PostgreSQL](https://www.postgresql.org/) - ACID-compliant relational storage.
- **Infrastructure:** [Docker](https://www.docker.com/) & [Docker Compose](https://docs.docker.com/compose/) - Multi-container orchestration.

### Key Integrations
- **Google Books API:** Real-time metadata fetching (Authors, Covers, Descriptions) while typing.
- **Tailwind CSS:** Premium, responsive UI design system with custom glassmorphism.
- **Pinia:** Centralized state management for seamless user transitions.

## 🆘 Troubleshooting
If you encounter any issues, refer to the [Troubleshooting section in the Guidelines](./.docs/guidelines.md#troubleshooting) or run `make logs` to see real-time server errors.



