'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "main.dart.js": "1434598a7c1c98fbfce87c72c17a4d36",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"google4da79dcd48434722.html": "722253e27d6c47a56ab104afb5fcf354",
"assets/NOTICES": "1e303590d3cddefb191faa1a8ffdea6d",
"assets/fonts/MaterialIcons-Regular.otf": "1288c9e28052e028aba623321f7826ac",
"assets/FontManifest.json": "4377ece436e334612d20deebe0b7b9fc",
"assets/AssetManifest.json": "2cbe00aa9da8f92b88d96034be78c652",
"assets/assets/fishes.json": "89bd3030f9dbe1724d52a938c81a8b66",
"assets/assets/fonts/PressStart2P-Regular.ttf": "2c404fd06cd67770807d242b2d2e5a16",
"assets/assets/atlases/fishes.fa": "0a19f561da5976f039d72b82bb85cd05",
"assets/assets/atlases/ui.fa": "eb4fab64703ef34958066d09c5bccc8c",
"assets/assets/atlases/background.fa": "744c6b11e54ae5eff2cb9f89777652c6",
"assets/assets/images/wood_medal48.png": "a9e1010c11040931d5e10810dce84801",
"assets/assets/images/gear.png": "cae03643fd37d8c8ded4fbfba607e537",
"assets/assets/images/button.png": "279d50296977b52794318e1fb80b29ef",
"assets/assets/images/user_image_panel_empty.png": "9205f385a2ad2b755336d0650ba75d49",
"assets/assets/images/closeButton48.png": "24d0e2c19933386098d71cc2daa86454",
"assets/assets/images/user_image_panel_filled.png": "b71aee56afaea5bd8019be66396b219d",
"assets/assets/images/gold_medal.png": "6c2fce54d8b76e1033e9237daea38775",
"assets/assets/images/ranking_panel.png": "dfbef42a557e951736bca04bc20bf325",
"assets/assets/images/silver_medal33.png": "fdd56ca4fb91014504c54cc2aba58d20",
"assets/assets/images/google_logo.png": "055dd1242be2997c23ce9cfc37bbbd92",
"assets/assets/images/bronze_medal48.png": "b88c598f4d51f0a0b2cfad4cae7f8f4f",
"assets/assets/images/silver_medal48.png": "481bb2c4920a3d6f7e970990a15cbd32",
"assets/assets/images/close.png": "1fcd19876a669565d38626471efa4a30",
"assets/assets/images/panel.png": "f70665730af09b410ed3b7f284214a44",
"assets/assets/images/acceptButton32.png": "ce3126a474894c542c30dbc8e24edf93",
"assets/assets/images/bubble.png": "6e113bf47b46a75da8d4209ed5919024",
"assets/assets/images/logoutButton32.png": "be3168ffffa97b0610208ee98cab58ca",
"assets/assets/images/panel_shadow.png": "7905f607234ef7023dbd6cf1a264f8d1",
"assets/assets/images/add_button.png": "14ffde8c1e0b650e3735ee42e55d5fb8",
"assets/assets/images/closeButton32.png": "b99ec4bc3771f785f3d23bcf9c98e085",
"assets/assets/images/button_shadow.png": "7905f607234ef7023dbd6cf1a264f8d1",
"assets/assets/images/fish_green.png": "e6d4e2a62d2b90c4a1f815749033a304",
"assets/assets/images/bronze_medal33.png": "f116f2727a64237e9f5d6cfeee8da67c",
"assets/packages/fluttertoast/assets/toastify.css": "8beb4c67569fb90146861e66d94163d7",
"assets/packages/fluttertoast/assets/toastify.js": "8f5ac78dd0b9b5c9959ea1ade77f68ae",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"version.json": "13fe212b32fd927a3841cc2fbafb4766",
"manifest.json": "5dc2ae44d30e6bf11567fc7fa01bac5e",
"favicon.png": "388974a863b41c3fe5ba3df150893e07",
"index.html": "8e1a3711a81e07d97f84f3da80bf2221",
"/": "8e1a3711a81e07d97f84f3da80bf2221"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value + '?revision=' + RESOURCES[value], {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
