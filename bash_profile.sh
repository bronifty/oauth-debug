echo "~/.bash_profile"

# Set a basic PATH
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# Function to add to PATH only if not already there
add_to_path() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        export PATH="$PATH:$1"
    fi
}

# Add Homebrew paths manually
add_to_path "/usr/local/bin"
add_to_path "/usr/local/sbin"

# Setup fnm (Fast Node Manager)
# use .nvmrc or .node-version 
eval "$(fnm env --use-on-cd)"

# Add govm shim
add_to_path "$HOME/.govm/shim"


githubauth() {
  gh auth login
}
githubnew() {
  local repo_name="$1"
  if [ -z "$repo_name" ]; then
    echo "Usage: githubnew <repo-name>"
    echo "Example: githubnew my-awesome-project"
    return 1
  fi
  echo "Creating GitHub repository: $repo_name"
  gh repo create "$repo_name" --public --source=. --remote=origin
}
gitpushmain() {
  local commit_message="${1:-this}"
    git branch -M main && \
    git add . && \
    git commit -am "$commit_message" && \
    git push -u origin main
}


alias python="python3"
alias pip="pip3"

# Display PATH components with counts on shell startup
echo "PATH components with counts:"
echo "$PATH" | tr ':' '\n' | sort | uniq -c

# Function to run OAuth servers
run_oauth_servers() {
    DEBUG=express:* npx concurrently \
        "npx nodemon authorizationServer.js" \
        "npx nodemon client.js" \
        "npx nodemon protectedResource.js"
}
alias oauth=run_oauth_servers

# Function to recursively delete directories using rimraf
rimraf() {
    if [ $# -eq 0 ]; then
        echo "Usage: rimraf <directory1> [directory2 ...]"
        echo "Example: rimraf node_modules dist build"
        return 1
    fi
    
    # Loop through all arguments
    for dir in "$@"; do
        if [ ! -d "$dir" ]; then
            echo "Skipping: $dir (directory does not exist)"
            continue
        fi
        echo "Deleting: $dir"
        npx rimraf "$dir"
    done
}


addpnpm() {
corepack enable
corepack prepare pnpm@latest --activate
}

# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
# Ensure Nix is in PATH (fallback)
if [ -d '/nix/var/nix/profiles/default/bin' ] && [[ ":$PATH:" != *":/nix/var/nix/profiles/default/bin:"* ]]; then
    export PATH="/nix/var/nix/profiles/default/bin:$PATH"
fi
# End Nix



# Created by `pipx` on 2025-08-03 09:33:43
export PATH="$PATH:/Users/brotherniftymacbookair/.local/bin"

# opencode
export PATH=/Users/brotherniftymacbookair/.opencode/bin:$PATH
