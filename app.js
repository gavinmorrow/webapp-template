const express = require("express");
const app = express();
const PORT = 8080;

app.get("/", (_req, res) => res.send("Hello World!"));

app.listen(PORT, () => console.log(`Listening on localhost:${PORT}!`));

const db = require("./db/db");
db.one("SELECT now()").then(data => console.log(data.now));
