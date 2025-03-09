#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Validating Healthyfied theme...${NC}"

# Check if gscan is installed
if ! command -v npx &> /dev/null; then
    echo -e "${RED}Error: npx is not installed. Please install Node.js and npm.${NC}"
    exit 1
fi

# Build the theme first
echo -e "${YELLOW}Building the theme...${NC}"
yarn build

# Validate the theme directory
echo -e "${YELLOW}Validating theme directory...${NC}"
npx gscan .

# Create a zip file
echo -e "${YELLOW}Creating theme zip file...${NC}"
yarn zip

# Validate the zip file
echo -e "${YELLOW}Validating theme zip file...${NC}"
npx gscan -z dist/healthyfied.zip

echo -e "${GREEN}Validation complete!${NC}" 