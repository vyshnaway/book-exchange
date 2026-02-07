# 📚 Boookz Exchange
**Sustainable Reading through Peer-to-Peer Exchange**

Boookz Exchange is a premium, full-stack web application designed for students and book lovers to catalogue, search, and swap physical books within a localized network.

![welcome section](./assets/home_page.gif)

---

## ⚡ Quick Start (Docker)
The entire application is containerized for a "Zero-Setup" experience.

1.  **Clone & Enter:**
    ```bash
    git clone [repo-url] && cd repo
    ```
2.  **Launch:**
    ```bash
    make dev
    ```
3.  **Access:**
    - **Frontend:** [http://localhost:3000](http://localhost:3000)
    - **API Docs:** [http://localhost:8000/api/docs](http://localhost:8000/api/docs)

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

---

## ✨ New Features
- **In-Page Inventory Management:** Owners can now **Edit** or **Remove** books directly from the details page.
- **Interactive Exchange History:** A visual stepper to track the progress of book swaps (Initiated → Accepted → Completed).
- **Responsive Hamburger Menu:** Fully optimized navigation for mobile devices.

---

## 📖 Student Documentation
We have prepared a comprehensive documentation suite for your project presentation:

| Document | Description |
| :--- | :--- |
| [**System Design**](./.docs/system-design.md) | High-level architecture, "Chef/Waiter" analogy, and ER diagrams. |
| [**Setup Guidelines**](./.docs/guidelines.md) | Detailed installation steps for Linux, Windows (WSL2), and macOS. |
| [**Viva Questions**](./.docs/viva_questions.md) | 20+ anticipated technical questions and professional answers. |
| [**Presentation Guide**](./.docs/presentation_guide.md) | A 5-minute scripted demo guide for a flawless live presentation. |
| [**Learning Material**](./.docs/learning_material.md) | Technical deep-dives into JWT, SSR, and Docker choices. |

---

## 📜 Academic Attribution
Developed as a **Software Engineering University Project** using Agile methodologies. This version has been refined for modern deployment standards and premium UI/UX.

---

## 🆘 Troubleshooting
If you encounter any issues, refer to the [Troubleshooting section in the Guidelines](./.docs/guidelines.md#troubleshooting) or run `make logs` to see real-time server errors.



