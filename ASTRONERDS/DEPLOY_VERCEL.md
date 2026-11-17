# Deploying the browser build to Vercel

The desktop game is C++ and SDL2. The Vercel build compiles it to WebAssembly with Emscripten and serves the generated files as a static site.

1. Import this repository into Vercel.
2. Set **Root Directory** to `ASTRONERDS`.
3. Keep the commands from `vercel.json` (`bash scripts/build-web.sh`, output directory `dist`) and deploy.

The first build downloads the pinned Emscripten SDK, so it takes longer than later builds. To build locally, install Git, then run `bash scripts/build-web.sh` from this directory. The page and game controls are in `web/shell.html`.
