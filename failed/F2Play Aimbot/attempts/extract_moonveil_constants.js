const fs = require("fs");
const path = require("path");

const artifactRoot = __dirname;
const inputPath = path.join(artifactRoot, "Loader.lua");
const outputPath = path.join(artifactRoot, "decoded_constants.txt");
const summaryPath = path.join(artifactRoot, "constant_extract.log");
const source = fs.readFileSync(inputPath, "utf8");

function readLuaString(raw) {
  let out = "";
  for (let i = 0; i < raw.length; i += 1) {
    const ch = raw[i];
    if (ch !== "\\") {
      out += ch;
      continue;
    }

    const next = raw[i + 1];
    if (/[0-9]/.test(next || "")) {
      let digits = "";
      let j = i + 1;
      while (j < raw.length && digits.length < 3 && /[0-9]/.test(raw[j])) {
        digits += raw[j];
        j += 1;
      }
      out += String.fromCharCode(Number(digits));
      i = j - 1;
      continue;
    }

    const escapes = {
      a: "\x07",
      b: "\b",
      f: "\f",
      n: "\n",
      r: "\r",
      t: "\t",
      v: "\x0b",
      "\\": "\\",
      "'": "'",
      '"': '"',
    };
    out += Object.prototype.hasOwnProperty.call(escapes, next) ? escapes[next] : next;
    i += 1;
  }
  return out;
}

function moonveilDecode(value, key) {
  let out = "";
  for (let i = 0; i < value.length; i += 1) {
    out += String.fromCharCode(value.charCodeAt(i) ^ key.charCodeAt(i % key.length));
  }
  return out;
}

const stringLiteral = String.raw`(?:"((?:\\.|[^"\\])*)"|'((?:\\.|[^'\\])*)')`;
const callPattern = new RegExp(String.raw`Ia\(\s*${stringLiteral}\s*,\s*${stringLiteral}\s*\)`, "g");

const decoded = [];
for (const match of source.matchAll(callPattern)) {
  const valueRaw = match[1] ?? match[2];
  const keyRaw = match[3] ?? match[4];
  const value = readLuaString(valueRaw);
  const key = readLuaString(keyRaw);
  decoded.push(moonveilDecode(value, key));
}

const unique = [...new Set(decoded)].sort((a, b) => a.localeCompare(b));
const printable = unique.filter((item) => /^[\x09\x0a\x0d\x20-\x7e]+$/.test(item));
const urls = printable.filter((item) => /https?:\/\/|githubusercontent|HttpGet|loadstring/i.test(item));

fs.writeFileSync(outputPath, printable.join("\n"));
fs.writeFileSync(
  summaryPath,
  [
    `Input: ${inputPath}`,
    `Ia calls decoded: ${decoded.length}`,
    `Unique printable constants: ${printable.length}`,
    `URL/loadstring-looking constants: ${urls.length}`,
    "",
    ...urls,
  ].join("\n")
);

console.log(fs.readFileSync(summaryPath, "utf8"));
