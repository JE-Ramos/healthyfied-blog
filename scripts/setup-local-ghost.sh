#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Setting up local Ghost instance for Healthyfied theme development...${NC}"

# Check if Ghost CLI is installed
if ! command -v ghost &> /dev/null; then
    echo -e "${YELLOW}Ghost CLI not found. Installing...${NC}"
    npm install ghost-cli@latest -g
fi

# Create ghost-local directory if it doesn't exist
if [ ! -d "ghost-local" ]; then
    echo -e "${YELLOW}Creating ghost-local directory...${NC}"
    mkdir ghost-local
fi

# Navigate to ghost-local directory
cd ghost-local

# Check if Ghost is already installed
if [ ! -f "config.production.json" ]; then
    echo -e "${YELLOW}Installing Ghost in local mode...${NC}"
    ghost install local --no-prompt
else
    echo -e "${YELLOW}Ghost is already installed. Starting...${NC}"
    ghost start
fi

# Get the Ghost port from the running instance
GHOST_PORT=$(ghost ls | grep "running" | grep -oE "http://localhost:[0-9]+" | grep -oE "[0-9]+")
if [ -z "$GHOST_PORT" ]; then
    GHOST_PORT=2370  # Default fallback port
fi

# Create symbolic link to theme if it doesn't exist
if [ ! -L "content/themes/healthyfied" ]; then
    echo -e "${YELLOW}Creating symbolic link to theme...${NC}"
    ln -sf "$(cd .. && pwd)" content/themes/healthyfied
    
    # Restart Ghost to recognize the new theme
    echo -e "${YELLOW}Restarting Ghost to recognize the theme...${NC}"
    ghost restart
fi

# Build the theme
echo -e "${YELLOW}Building the theme...${NC}"
cd ..
yarn build

# Modify the Ghost database to activate our theme
cd ghost-local
echo -e "${YELLOW}Activating the Healthyfied theme...${NC}"

# Get the path to the SQLite database
DB_PATH="content/data/ghost-local.db"

if [ -f "$DB_PATH" ]; then
    # Check if sqlite3 is installed
    if command -v sqlite3 &> /dev/null; then
        # Update the active_theme setting in the settings table
        sqlite3 "$DB_PATH" "UPDATE settings SET value='healthyfied' WHERE key='active_theme';"
        
        # Restart Ghost to apply the theme change
        echo -e "${YELLOW}Restarting Ghost to apply theme changes...${NC}"
        ghost restart
        
        echo -e "${GREEN}Theme activated successfully!${NC}"
    else
        echo -e "${RED}SQLite3 command not found. Please install it to automatically activate the theme.${NC}"
        echo -e "${YELLOW}You'll need to manually activate the theme in the Ghost admin panel.${NC}"
    fi
else
    echo -e "${RED}Database file not found. You'll need to manually activate the theme in the Ghost admin panel.${NC}"
fi

cd ..

echo -e "${GREEN}Setup complete!${NC}"
echo -e "${GREEN}Your local Ghost instance is running at: http://localhost:${GHOST_PORT}${NC}"
echo -e "${GREEN}Admin panel: http://localhost:${GHOST_PORT}/ghost/${NC}"
echo -e "${YELLOW}To stop Ghost, run: cd ghost-local && ghost stop${NC}"
echo -e "${YELLOW}To start Ghost, run: cd ghost-local && ghost start${NC}" 