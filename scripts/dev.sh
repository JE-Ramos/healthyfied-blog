#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Starting Healthyfied theme development environment...${NC}"

# Check if ghost-local directory exists
if [ ! -d "ghost-local" ]; then
    echo -e "${YELLOW}Local Ghost instance not found. Running setup script...${NC}"
    ./scripts/setup-local-ghost.sh
    exit 0
fi

# Start Ghost if it's not already running
cd ghost-local
if ! ghost ls | grep -q "running"; then
    echo -e "${YELLOW}Starting Ghost...${NC}"
    ghost start
else
    echo -e "${GREEN}Ghost is already running.${NC}"
fi

# Get the Ghost port from the running instance
GHOST_PORT=$(ghost ls | grep "running" | grep -oE "http://localhost:[0-9]+" | grep -oE "[0-9]+")
if [ -z "$GHOST_PORT" ]; then
    GHOST_PORT=2370  # Default fallback port
fi

# Check if the theme is activated
DB_PATH="content/data/ghost-local.db"
if [ -f "$DB_PATH" ] && command -v sqlite3 &> /dev/null; then
    ACTIVE_THEME=$(sqlite3 "$DB_PATH" "SELECT value FROM settings WHERE key='active_theme';")
    if [ "$ACTIVE_THEME" != "healthyfied" ]; then
        echo -e "${YELLOW}Activating the Healthyfied theme...${NC}"
        sqlite3 "$DB_PATH" "UPDATE settings SET value='healthyfied' WHERE key='active_theme';"
        echo -e "${YELLOW}Restarting Ghost to apply theme changes...${NC}"
        ghost restart
    fi
fi
cd ..

# Start theme development server
echo -e "${YELLOW}Starting theme development server...${NC}"
echo -e "${GREEN}Your local Ghost instance is running at: http://localhost:${GHOST_PORT}${NC}"
echo -e "${GREEN}Admin panel: http://localhost:${GHOST_PORT}/ghost/${NC}"
echo -e "${YELLOW}Press Ctrl+C to stop the theme development server (Ghost will continue running)${NC}"
echo -e "${YELLOW}To stop Ghost, run: cd ghost-local && ghost stop${NC}"
echo -e "${GREEN}Theme changes will be automatically applied - no need to upload the theme manually!${NC}"

# Start the theme development server
yarn dev 