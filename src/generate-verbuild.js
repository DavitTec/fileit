//global variable
const metadatafile = "src/metadata.json";
const packagefile = "package.json";

const { readFile, writeFile } = require("fs");
console.log("Updating Version Number");

function increaseVersion() {
  console.log("..Incrementing Version number");
  readFile(metadatafile, (err, content) => {
    if (err) {
      console.log(err);
      return;
    }
    const metadata = JSON.parse(content);
    metadata.buildRevision = metadata.buildRevision + 1;
    readFile(packagefile, (err, content) => {
      if (err) {
        console.log(err);
        return;
      }
      const packagedata = JSON.parse(content);
      let newVersion =
        metadata.buildMajor +
        "." +
        metadata.buildMinor +
        "." +
        metadata.buildRevision +
        "-" +
        metadata.buildTag;
      packagedata.version = newVersion;
      writeFile(metadatafile, JSON.stringify(metadata), (err, result) => {
        if (err) {
          console.log(err);
          return;
        }
        writeFile(packagefile, JSON.stringify(packagedata), (err, result) => {
          if (err) {
            console.log(err);
            return;
          }
        });
        console.log(
          `New Version: ${metadata.buildMajor}.${metadata.buildMinor}.${metadata.buildRevision} ${metadata.buildTag}`
        );
      });
    });
  });
  console.log("starting next task");
}

// let version = "0.0.1"; //global variable
increaseVersion();
