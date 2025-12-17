# G-Shell: Persistent Google Cloud Shell Environment

**G-Shell** is a robust framework designed to create a persistent, powerful development environment within the ephemeral constraints of Google Cloud Shell. It ensures that your tools, configurations, and shell history survive session resets.

## 🚀 The Core Problem & Solution

Google Cloud Shell resets its underlying VM for every session. While your `$HOME` directory persists, system packages (installed via `apt`) and global configurations do not.

**G-Shell** solves this with a two-part architecture:

1.  **Persistent Layer (`install.sh`)**: Runs **once**.
    *   Installs static binaries (Neovim, Lazygit, Yazi, Fastfetch, etc.) to `~/.local/bin`.
    *   Sets up `nvm` and Node.js in `~/.nvm`.
    *   Deploys dotfiles (`.bashrc`, `.tmux.conf`, etc.) to `$HOME`.
    *   Installs Python tools (`termdown`) via `pip --user`.
2.  **Ephemeral Layer (`~/.customize_environment`)**: Runs **on every startup**.
    *   Automatically restored by `install.sh` (copied from `dotfiles/`).
    *   Executed by Cloud Shell as `root` at boot.
    *   Re-installs missing system dependencies (`ripgrep`, `tty-clock`) via `apt`.
    *   Sources your environment variables to ensure a seamless experience.

## 🛠️ Installed Tools

The environment comes pre-configured with modern CLI tools:

| Tool | Type | Location | Persistence |
| :--- | :--- | :--- | :--- |
| **Neovim** | Editor | `~/.local/bin/nvim` | ✅ Persistent (Static Binary) |
| **Lazygit** | Git Client | `~/.local/bin/lazygit` | ✅ Persistent (Static Binary) |
| **Yazi** | File Manager | `~/.local/bin/yazi` | ✅ Persistent (Static Binary) |
| **Fastfetch** | Sys Info | `~/.local/bin/fastfetch` | ✅ Persistent (Static Binary) |
| **Resterm** | API Client | `~/.local/bin/resterm` | ✅ Persistent (Static Binary) |
| **7zip** | Archiver | `~/.local/bin/7zz` | ✅ Persistent (Static Binary) |
| **Termdown** | Timer | `~/.local/bin/termdown` | ✅ Persistent (Pip User) |
| **Node.js** | Runtime | `~/.nvm` | ✅ Persistent (NVM) |
| **Ripgrep** | Search | `/usr/bin/rg` | 🔄 Re-installed on boot |
| **TTY-Clock** | Clock | `/usr/bin/tty-clock` | 🔄 Re-installed on boot |

## 📦 Installation

1.  **Clone the repository**:
    ```bash
    git clone https://github.com/your-username/perma-shell.git ~/perma-shell
    ```
2.  **Run the setup script**:
    ```bash
    cd ~/perma-shell
    ./install.sh
    ```
3.  **Restart Cloud Shell**:
    *   Close the session or run `exec bash --login` (though a full restart is recommended to test the boot script).

## 📂 Repository Structure

*   **`install.sh`**: Main entry point. User-space setup.
*   **`dotfiles/`**: Configuration files copied to `$HOME`. Includes the `.customize_environment` logic.
*   **`packages/binaries.list`**: Source URLs for version-pinned binary downloads.
*   **`bin/`**: Local cache for specific binaries (e.g., Neovim, Fastfetch) to ensure availability.
*   **`scripts/`**: Helper scripts.
*   **`GEMINI.md`**: Context memory for the AI assistant.
