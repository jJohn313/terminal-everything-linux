#!/usr/bin/env bash
set -euo pipefail

# ==============================================================================
# Terminal Everything Linux (TEL) - Unified Installer & Workspace Manager
# ==============================================================================

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_DIR="${HOME}/.local/bin"

BOLD="\033[1m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
CYAN="\033[1;36m"
RED="\033[1;31m"
RESET="\033[0m"

print_banner() {
    echo -e "${CYAN}${BOLD}"
    echo "  ╔═══════════════════════════════════════════════════════════════╗"
    echo "  ║                TERMINAL EVERYTHING LINUX (TEL)                ║"
    echo "  ║        Unified Suite for Headless & TUI-First Workstations    ║"
    echo "  ╚═══════════════════════════════════════════════════════════════╝"
    echo -e "${RESET}"
}

usage() {
    echo "Usage: ./install.sh [OPTION]"
    echo ""
    echo "Options:"
    echo "  --install        Initialize submodules and symlink all tools to ~/.local/bin (default)"
    echo "  --update         Pull latest changes for all submodule tools"
    echo "  --status         Check installation status and symlink targets"
    echo "  --uninstall      Remove symlinks from ~/.local/bin"
    echo "  --help           Show this help message"
    echo ""
}

init_submodules() {
    echo -e "${CYAN}▶ Initializing and updating submodules...${RESET}"
    git -C "${REPO_DIR}" submodule update --init --recursive
    echo -e "${GREEN}✔ Submodules ready.${RESET}"
}

update_submodules() {
    echo -e "${CYAN}▶ Pulling latest upstream updates for all tools...${RESET}"
    git -C "${REPO_DIR}" submodule update --remote --merge
    echo -e "${GREEN}✔ All tools updated to latest upstream commits.${RESET}"
}

install_tools() {
    mkdir -p "${BIN_DIR}"
    init_submodules

    echo -e "\n${CYAN}▶ Linking tools to ${BIN_DIR}...${RESET}"

    # 1. Steam TUI
    if [[ -d "${REPO_DIR}/tools/steam-tui/bin" ]]; then
        echo -e "  [steam-tui]"
        ln -sfn "${REPO_DIR}/tools/steam-tui/bin/steam" "${BIN_DIR}/steam"
        ln -sfn "${REPO_DIR}/tools/steam-tui/bin/steam-tui-backend" "${BIN_DIR}/steam-tui-backend"
        echo -e "    ${GREEN}✔${RESET} steam -> ${REPO_DIR}/tools/steam-tui/bin/steam"
        echo -e "    ${GREEN}✔${RESET} steam-tui-backend -> ${REPO_DIR}/tools/steam-tui/bin/steam-tui-backend"
    fi

    # 2. Browser Audio
    if [[ -d "${REPO_DIR}/tools/browser-audio/bin" ]]; then
        echo -e "  [browser-audio]"
        ln -sfn "${REPO_DIR}/tools/browser-audio/bin/browser-audio" "${BIN_DIR}/browser-audio"
        echo -e "    ${GREEN}✔${RESET} browser-audio -> ${REPO_DIR}/tools/browser-audio/bin/browser-audio"
    fi

    echo -e "\n${GREEN}${BOLD}✔ Terminal Everything Linux successfully installed!${RESET}"
    echo -e "Ensure ${BOLD}${BIN_DIR}${RESET} is in your \$PATH."
}

uninstall_tools() {
    echo -e "${YELLOW}▶ Removing TEL tool symlinks from ${BIN_DIR}...${RESET}"
    for tool in steam steam-tui-backend browser-audio; do
        target="${BIN_DIR}/${tool}"
        if [[ -L "${target}" ]]; then
            rm -f "${target}"
            echo -e "  ${RED}✖${RESET} Removed ${target}"
        fi
    done
    echo -e "${GREEN}✔ Uninstall complete.${RESET}"
}

check_status() {
    echo -e "${CYAN}${BOLD}Tool Installation Status:${RESET}"
    for tool in steam steam-tui-backend browser-audio; do
        target="${BIN_DIR}/${tool}"
        if [[ -L "${target}" ]]; then
            dest=$(readlink -f "${target}")
            echo -e "  ${GREEN}●${RESET} ${BOLD}${tool}${RESET} -> ${dest}"
        elif [[ -f "${target}" ]]; then
            echo -e "  ${YELLOW}▲${RESET} ${BOLD}${tool}${RESET} (regular file, not managed by TEL)"
        else
            echo -e "  ${RED}○${RESET} ${BOLD}${tool}${RESET} (not installed)"
        fi
    done
}

ACTION="${1:---install}"
print_banner

case "${ACTION}" in
    --install)
        install_tools
        ;;
    --update)
        update_submodules
        ;;
    --status)
        check_status
        ;;
    --uninstall)
        uninstall_tools
        ;;
    --help|-h)
        usage
        ;;
    *)
        echo -e "${RED}Unknown option: ${ACTION}${RESET}\n"
        usage
        exit 1
        ;;
esac
