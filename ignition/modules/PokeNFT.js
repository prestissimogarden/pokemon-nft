const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

module.exports = buildModule("PokeNFT", (m) => {
  const pokenft = m.contract("PokeNFT");
  return { pokenft };
});