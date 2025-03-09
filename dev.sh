#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Starting Healthyfied theme development environment...${NC}"

# Check if ghost-local directory exists
if [ ! -d "ghost-local" ]; then
    echo -e "${YELLOW}Local Ghost instance not found. Running setup script...${NC}"
    ./setup-local-ghost.sh
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
cd ..

# Start theme development server
echo -e "${YELLOW}Starting theme development server...${NC}"
echo -e "${GREEN}Your local Ghost instance is running at: http://localhost:2368${NC}"
echo -e "${GREEN}Admin panel: http://localhost:2368/ghost/${NC}"
echo -e "${YELLOW}Press Ctrl+C to stop the theme development server (Ghost will continue running)${NC}"
echo -e "${YELLOW}To stop Ghost, run: cd ghost-local && ghost stop${NC}"

# Start the theme development server
yarn dev 