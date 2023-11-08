# CS361-Group-Project
CS 361 (Software Engineering) Course Group Project

## Development Setup
### Dependencies
- [Node](https://nodejs.org/en/) (Tested with v21.1.0)
    - I'm using [Node Version Manager](https://github.com/coreybutler/nvm-windows) with
    `nvm install latest` and `nvm use latest`
- `npm` (Tested with v10.2.3)
    - Update to the latest version with `npm install -g npm@latest`
- `yarn` (Tested with v1.22.19)
    - Update to the latest version with `npm install -g yarn@latest`

### Suggestions
#### VS Code Extensions
- [Svelte for VS Code](https://marketplace.visualstudio.com/items?itemName=svelte.svelte-vscode)
- [Svelte Intellisense](https://marketplace.visualstudio.com/items?itemName=ardenivanov.svelte-intellisense)

### Before you start
Open this GitHub repo in VS Code and start a new terminal. 
Run `npm install` or `yarn` to install the project dependencies.

## Developing
I've included a `.vscode` folder which contains scripts for debugging and building that should work out of the box.
Just press `F5` or go to Run->Start Debugging. 
This can also be done from the terminal using `yarn run dev` or `yarn run bundle` for bundling to an executable. 
Electron will hot reload any changes made to the Svelte files/web stuff automatically, but you'll need to rebuild for changes that interact with the system (Electron stuff). 

### Electron ([Docs](https://www.electronjs.org/docs/latest))
For the most part we shouldn't need to touch it, but Electron's configuration is under `./electron/`.

### Svelte ([Docs](https://svelte.dev/docs/introduction))
Everything Svelte-related is located in `./src/` and `./public/`. 
The way we should develop is by making individual "components" of all the things we need. 
I've provided an example of how these would be integrated into the Svelte sample page.

### Everything else
Config files are located in the root directory `./` 
- [UI Library Docs](https://www.melt-ui.com/docs/introduction)
- [Tailwind CSS Docs](https://tailwindcss.com/docs/installation)

## Notes
Built from this [Svelte/Electron/Tailwind template](https://github.com/feernandobraga/vitesvelctron)