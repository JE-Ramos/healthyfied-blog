# Healthyfied Blog

A customized Ghost theme for the Healthyfied blog, based on the Ruby theme. This theme features a multi-column layout with a unique card design to organize content effectively.

**Website: https://healthyfied.me**

## About

Healthyfied is a blog focused on healthy living, nutrition, and wellness. This repository contains the custom Ghost theme used for the blog.

## Local Development

To develop and test this theme locally before deploying to the live site, follow these steps:

### Prerequisites

- [Node.js](https://nodejs.org/) (v16 or higher)
- [Yarn](https://yarnpkg.com/) or npm
- [Ghost CLI](https://ghost.org/docs/ghost-cli/) (`npm install ghost-cli@latest -g`)

### Setting Up Local Ghost Instance

1. Create a directory for your local Ghost installation:
   ```bash
   mkdir ghost-local
   cd ghost-local
   ```

2. Install Ghost in development mode:
   ```bash
   ghost install local
   ```

3. After installation, Ghost will be running at http://localhost:2368 with the admin panel at http://localhost:2368/ghost/

### Working with the Theme

1. Clone this repository:
   ```bash
   git clone https://github.com/JE-Ramos/healthyfied-blog.git
   cd healthyfied-blog
   ```

2. Install dependencies:
   ```bash
   yarn install
   ```

3. Build the theme and create a zip file:
   ```bash
   yarn zip
   ```
   This will create a `healthyfied.zip` file in the `dist/` directory.

4. Upload the theme to your local Ghost instance:
   - Go to http://localhost:2368/ghost/#/settings/design/change-theme
   - Click "Upload a theme"
   - Select the `dist/healthyfied.zip` file
   - Activate the theme

5. For active development with live reloading:
   ```bash
   yarn dev
   ```
   This will watch for changes to your theme files and automatically rebuild them.

### Notes

- If you add any new files to your theme during development, you'll need to restart Ghost to see the changes take effect.
- The local Ghost instance uses SQLite for the database, which is stored in the `content/data/` directory.
- You can stop the local Ghost instance with `ghost stop` and start it again with `ghost start`.

## Development

Styles are compiled using Gulp/PostCSS to polyfill future CSS spec. You'll need [Node](https://nodejs.org/), [Yarn](https://yarnpkg.com/) and [Gulp](https://gulpjs.com) installed globally. After that, from the theme's root directory:

```bash
# Install
yarn

# Run build & watch for changes
yarn dev
```

Now you can edit `/assets/css/` files, which will be compiled to `/assets/built/` automatically.

The `zip` Gulp task packages the theme files into `dist/healthyfied.zip`, which you can then upload to your Ghost site.

```bash
yarn zip
```

## Deployment

This theme is designed to work with Ghost's cloud hosting. After making changes:

1. Create a zip file using `yarn zip`
2. Log into your Ghost admin panel
3. Go to Settings > Design
4. Upload the zip file

## License

Based on the Ruby theme by Ghost Foundation - Released under the [MIT license](LICENSE).
