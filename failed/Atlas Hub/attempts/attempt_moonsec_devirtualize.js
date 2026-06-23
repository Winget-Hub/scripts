const fs = require("fs");
const path = require("path");

const artifactRoot = __dirname;
const toolRoot = path.resolve(artifactRoot, "../tools/Lua-Deobfuscator");

process.chdir(toolRoot);

const luamin = require(path.join(toolRoot, "utility/luamin"));
const analyze = require(path.join(toolRoot, "obfuscators/moonsec/analyze"));
const deserialize = require(path.join(toolRoot, "obfuscators/moonsec/deserialize"));
const devirtualize = require(path.join(toolRoot, "obfuscators/moonsec/devirtualize"));
const moonsec = require(path.join(toolRoot, "obfuscators/moonsec/deobfuscate"));

const inputPath = path.join(artifactRoot, "redliner.lua");
const logPath = path.join(artifactRoot, "moonsec_attempt.log");
const input = fs.readFileSync(inputPath, "utf8");

const log = [];
function write(line) {
  log.push(line);
  console.log(line);
}

try {
  write(`Input: ${inputPath}`);
  write(`Bytes: ${Buffer.byteLength(input, "utf8")}`);
  write(`MoonSec detector: ${moonsec.detect(input) ? "matched" : "not matched"}`);

  const ast = luamin.BeautifyAst(luamin.Parse(input), {
    RenameVariables: true,
    Format: true,
  });
  write("Luau parser: parsed and beautified successfully");

  const analyzed = analyze(ast.StatementList, false);
  write("MoonSec analyze: completed");

  const vmdata = deserialize(analyzed, false);
  write("MoonSec deserialize: completed");

  const devirtualized = devirtualize(vmdata, false);
  write("MoonSec devirtualize: completed");

  fs.writeFileSync(
    path.join(artifactRoot, "moonsec_devirtualized_model.json"),
    JSON.stringify(devirtualized, null, 2)
  );
  write("Wrote moonsec_devirtualized_model.json");
} catch (error) {
  write("Attempt failed:");
  write(error && error.stack ? error.stack : String(error));
}

fs.writeFileSync(logPath, log.join("\n"));
