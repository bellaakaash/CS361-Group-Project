const { contextBridge } = require('electron')
const path = require("path");
const db = require('better-sqlite3')(path.resolve(__dirname, '../database/recipeManager.db'));

db.pragma('journal_mode = WAL');

const api = {
    node: () => process.versions.node,
    chrome: () => process.versions.chrome,
    electron: () => process.versions.electron,
}

const db_funcs = {
    query: (str) => db.prepare(str).get()
}

contextBridge.exposeInMainWorld('api', api)
contextBridge.exposeInMainWorld('db', db_funcs)