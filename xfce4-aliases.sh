# XFCE4 Launcher Aliases and Functions
# Source this file in your ~/.bashrc or ~/.zshrc:
#   source ~/xfce4-aliases.sh

# Main launcher
alias xfce4='start-xfce4'
alias xfce4-start='start-xfce4'
alias xfce4-stop='start-xfce4 --kill'
alias xfce4-restart='start-xfce4 --restart'
alias xfce4-status='start-xfce4 --check'
alias xfce4-debug='start-xfce4 --debug'

# Quick start with common options
alias xfce4-wayland='start-xfce4 --wayland'
alias xfce4-display1='start-xfce4 --display :1'
alias xfce4-display2='start-xfce4 --display :2'
alias xfce4-nox='start-xfce4 --no-xserver'

# Function to start XFCE4 with custom X server
xfce4_custom() {
    start-xfce4 --xserver "$@"
}

# Function to list running XFCE4 sessions
xfce4_sessions() {
    echo "=== XFCE4 Sessions ==="
    pgrep -af "xfce4-session|startxfce4" 2>/dev/null || echo "No XFCE4 sessions found"
    echo ""
    echo "=== X Servers ==="
    pgrep -af "termux-x11|Xwayland|Xorg" 2>/dev/null || echo "No X servers found"
}

# Function to clean up all XFCE4 processes
xfce4_cleanup() {
    echo "Cleaning up XFCE4 processes..."
    pkill -f "xfce4-session|startxfce4|xfce4-panel|xfce4-terminal|xfce4-settings|xfwm4|xfdesktop|thunar" 2>/dev/null
    sleep 1
    pkill -9 -f "xfce4-session|startxfce4|xfce4-panel|xfce4-terminal|xfce4-settings|xfwm4|xfdesktop|thunar" 2>/dev/null
    echo "Done."
}

# Auto-completion for start-xfce4 (bash)
if [[ -n "${BASH_VERSION:-}" ]]; then
    _start_xfce4_completions() {
        local cur="${COMP_WORDS[COMP_CWORD]}"
        local opts="--help -h --check -c --display --xserver --no-xserver --wayland --with-ck --kill --restart --debug"
        COMPREPLY=( $(compgen -W "$opts" -- "$cur") )
    }
    complete -F _start_xfce4_completions start-xfce4
fi