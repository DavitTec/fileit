const express = require("express");
const path = require("path");
const port = 3000;
const app = express();

// setup static and middleware
app.use(express.static("./public"));

app.get("/", (req, res) => {
  res.sendFile(path.resolve(__dirname, "./public/index.html"));
});

app.all("*", (req, res) => {
  res.status(404).send("resource not found");
});

app.listen(port, () => {
  console.log("server is listening on http://localhost:" + port + " .....");
});
