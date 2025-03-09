#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
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
yarn zip

echo -e "${GREEN}Setup complete!${NC}"
echo -e "${GREEN}Your local Ghost instance is running at: http://localhost:2368${NC}"
echo -e "${GREEN}Admin panel: http://localhost:2368/ghost/${NC}"
echo -e "${GREEN}You can now upload your theme zip file from the dist/ directory.${NC}"
echo -e "${YELLOW}To stop Ghost, run: cd ghost-local && ghost stop${NC}"
echo -e "${YELLOW}To start Ghost, run: cd ghost-local && ghost start${NC}" 