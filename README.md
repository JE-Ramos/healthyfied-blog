# Healthyfied Blog

A customized Ghost theme for the Healthyfied blog, based on the Ruby theme. This theme features a multi-column layout with a unique card design to organize content effectively.

**Website: https://healthyfied.me**

## About

Healthyfied is a blog focused on healthy living, nutrition, and wellness. This repository contains the custom Ghost theme used for the blog.

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
