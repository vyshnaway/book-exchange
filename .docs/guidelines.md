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
4.  **Deploy**:
    ```bash
    make deploy
    ```

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
    *   **Deploy**:
        ```bash
        make deploy
        ```
    *   *Access the site at `localhost:3000` in your Windows Chrome browser.*

---

## macOS (Intel or M1/M2/M3)

1.  **Install Docker Desktop**:
    *   Download from [docker.com](https://www.docker.com/products/docker-desktop/) (Choose "Apple Chip" for M1/M2/M3).
    *   Open the app and let it run in the background.
2.  **Install Command Line Tools**:
    *   Open Terminal and run: `xcode-select --install`
    *   (This gives you `git` and `make`).
3.  **Deploy**:
    ```bash
    make deploy
    ```

---

## Troubleshooting

### "Permission Denied" (Linux)
Run `sudo ./scripts/setup_env.sh` again, and **Restart your computer**.

### "Port 8000/3000 already in use"
Another program (or an old version of this app) is running.
1.  Run `make down` (or `docker-compose down`).
2.  Try `make deploy` again.

### "Make command not found" (Windows)
You are likely using PowerShell. Please switch to **WSL2 (Ubuntu)** terminal as described in the Windows section.
