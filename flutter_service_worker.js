'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/images/recent_images/01.jpeg": "bea0e1b21a591663467311d3808afa59",
"assets/images/recent_images/05.jpeg": "8da78048ae6e6f65283a45211d8790b6",
"assets/images/recent_images/02.jpeg": "e8f0498f18e57e484a6e1d8efac0fc50",
"assets/images/recent_images/03.jpeg": "f938d22750011d2bc9886f59f7b5f75a",
"assets/images/recent_images/06.jpeg": "d8cfde6c59aa87b7e48fc9fb3c106659",
"assets/images/recent_images/04.jpeg": "8ac8df46844dcdfe6502605b2b8ce267",
"assets/images/carousel_images/01.jpeg": "354ba0af3d616d4f66cb6bbad9a02fb0",
"assets/images/carousel_images/04-t.jpeg": "cb24670c13e3f6aebf2e839121b6e1c9",
"assets/images/carousel_images/03-t.jpeg": "f562fb5c101ab059ddc1cb00e22ebe0c",
"assets/images/carousel_images/02.jpeg": "24cb419ba10488196e27af2ef6b2dab9",
"assets/images/carousel_images/03.jpeg": "f24e642a65ab83729b81279144d710eb",
"assets/images/carousel_images/02-t.jpeg": "1b0b2cd30aea0449c9e6f3c303c9ffcb",
"assets/images/carousel_images/04.jpeg": "dce51c494addd948798d6a15e5dd6c3a",
"assets/images/carousel_images/01-old.jpeg": "f1aa1cb36d8b869ab5bca2dcfeb89aae",
"assets/images/category_images/05.png": "d050937a2f644315e042d1314bdc5185",
"assets/images/category_images/08.png": "145f3dc6fd1835b7edc716a0108c744b",
"assets/images/category_images/01.png": "89d4e1f6c34c707b058ca753e26d292d",
"assets/images/category_images/02.png": "57499a3f446ff8e073cca3e5294215db",
"assets/images/category_images/03.png": "aa3f890fc4bba14336aef5bb98c29f78",
"assets/images/category_images/07.png": "12c178102826d97f1887299f41cea0f1",
"assets/images/category_images/04.png": "b657bee133cd0edb34bcb4f949507e25",
"assets/images/category_images/06.png": "185a99b7eb3874ed2f940aad8cf98d84",
"assets/images/product_images/iphone13.png": "fe000edc723cdde1b44c34bc18ee937b",
"assets/images/product_images/oatmeal.jpg": "87b48a99f56bde4ef428424b4d9723b7",
"assets/images/product_images/iphone.jpg": "278e006fef9eb23a040db5bb806e5eca",
"assets/AssetManifest.json": "612aec683971726bd7165ce85347f209",
"assets/NOTICES": "8da76a666a47bf7850724a584ce9c65e",
"assets/fonts/MaterialIcons-Regular.otf": "7e7a6cccddf6d7b20012a548461d5d81",
"index.html": "dc4bcee0d251f5bbe0bb9858f6bc4cd5",
"/": "dc4bcee0d251f5bbe0bb9858f6bc4cd5",
"version.json": "b07421f69d245996e47fbe6d359625d1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"main.dart.js": "b81079116b2c7d16b823da90cc73e58f",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"manifest.json": "53d7b9f21d58801507530920c105b0fc",
"canvaskit/profiling/canvaskit.js": "411ee45f5abb57975ee5243310c6953e",
"canvaskit/profiling/canvaskit.wasm": "c6681b1a749ad902eefcba11fed1cb3f",
"canvaskit/canvaskit.js": "f00de1f742223b7cf4cec1c2a0cd9764",
"canvaskit/canvaskit.wasm": "efe4a5da0205bb8d8c5aca7dad981abd"
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
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
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
