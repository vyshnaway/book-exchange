# Installation & Setup Guidelines

This project uses **Docker** to ensure it runs exactly the same on every computer. Follow the instructions for your Operating System below.

---

## Linux (Ubuntu / Debian / Mint)
*Recommended for College Labs*

1.  **Open Terminal** (`Ctrl` + `Alt` + `T`).
2.  **Navigate** to the project folder.
3.  **Run the Setup Script** (installs Docker/Make/Git):
    ```bash
    chmod +x scripts/setup_env.sh
    sudo ./scripts/setup_env.sh
    ```
    *Note: If it asks you to log out, calculate `logout` or restart your computer.*
4.  **Start Services**:
    ```bash
    make dev
    ```
    *This starts the DB, Backend, and Frontend in the background.*

---

## Windows (10/11)
*Requires WSL2 (Windows Subsystem for Linux)*

1.  **Install Docker Desktop**:
    *   Download from [docker.com](https://www.docker.com/products/docker-desktop/).
    *   During install, ensure **"Use WSL 2 based engine"** is checked.
2.  **Install Ubuntu on Windows**:
    *   Open PowerShell as Admin and run: `wsl --install`
    *   Restart your computer.
    *   Open the "Ubuntu" app from your Start Menu.
3.  **Setup within Ubuntu**:
    *   Inside the Ubuntu terminal, git clone your project.
    *   Run the Linux setup script (from the Linux section above) to get `make`.
    *   **Start Services**:
        ```bash
        make dev
        ```
    *   *Access the site at `localhost:3000` in your Windows browser.*

---

## macOS (Intel or Silicon)

1.  **Install Docker Desktop**:
    *   Download from [docker.com](https://www.docker.com/products/docker-desktop/).
    *   Open the app and let it run in the background.
2.  **Install Command Line Tools**:
    *   Open Terminal and run: `xcode-select --install`
3.  **Start Services**:
    ```bash
    make dev
    ```

---

## Useful Commands

| Command | Action |
| :--- | :--- |
| `make dev` | Standard way to start the project (DB + Web + Frontend). |
| `make deploy` | Rebuilds everything and starts (best for final testing). |
| `make down` | Stops and removes all containers. |
| `make logs` | Shows real-time errors from the server. |
| `make restart` | Quickly restarts the web server. |

---

## Troubleshooting

### "Permission Denied" (Linux)
Run `sudo ./scripts/setup_env.sh` again, and **Restart your computer**.

### "Port 3000 or 8000 already in use"
Another program (or an old version of this app) is stuck.
1.  Run `make down`.
2.  If that doesn't work, run `docker system prune` (Warning: deletes unused data).
3.  Try `make dev` again.

### "Make command not found" (Windows)
You are likely using PowerShell. Please switch to the **WSL2 (Ubuntu)** terminal.
