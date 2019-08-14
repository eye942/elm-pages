const workboxBuild = require("workbox-build");

module.exports = { buildSW };

function buildSW() {
  // This will return a Promise
  return workboxBuild.generateSW({
    globDirectory: "dist/",
    globPatterns: ["index.html", "**/*.js"],

    navigateFallback: "index.html",
    swDest: "dist/service-worker.js",
    runtimeCaching: [
      {
        // urlPattern: /^https:\/\/fonts\.googleapis\.com/,
        urlPattern: /^https:\/\/fonts\.gstatic\.com/,
        handler: "CacheFirst",
        options: {
          cacheName: "fonts"
        }
      },
      {
        urlPattern: /\.(?:png|gif|jpg|jpeg|svg)$/,
        handler: "CacheFirst",
        options: {
          cacheName: "images"
        }
      }
    ]
  });
}