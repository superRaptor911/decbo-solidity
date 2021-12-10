const config = require("./test/config.json")
console.log("Executing minimising script");

const fs = require('fs-extra');
const files = fs.readdirSync("./build/contracts/");

console.log("Creating folder")
try {
  fs.mkdirSync("./build/contracts/contracts/");
} catch (e) {
  /* handle error */
  console.log("Failed to create folder")
}
files.forEach((file) => {
  console.log("file is ", file)
  if (file !== "contracts") {

    let data =  fs.readFileSync(`./build/contracts/${file}`);
    const databases = JSON.parse(data);
    let minContract = {
      abi: databases.abi,
      networks: databases.networks
    }

    data = JSON.stringify(minContract);
    fs.writeFileSync(`./build/contracts/contracts/${file}`, data, 'utf8', (err) => {
      if (err) {
        console.log(`Error writing file: ${err}`);
      } else {
        console.log(`${file} is written successfully!`);
      }
    });
  }
});


console.log("Coping contracts ..")

// fs.rmdirSync(config.frontendPath + "src/contracts")
fs.copySync("./build/contracts/contracts", config.frontendPath + "src/contracts");
