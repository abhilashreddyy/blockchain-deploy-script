var solc = require('solc');
var fs = require('fs');
let Web3 = require('web3');
let web3 = new Web3();

var inputFilePath = process.argv[2];
var outputPath = process.argv[3];

var contractSolidity = fs.readFileSync(inputFilePath , 'utf-8');
if (!contractSolidity)
    return console.error('unable to read file: ' + inputFilePath );

var output = solc.compile(contractSolidity, 1);
//console.log("out : ",output);
//console.log("cont : ",  output.contracts);
for (var contractName in output.contracts) {
    //console.log(contractName.slice(1));
    var temp_abi = output.contracts[contractName].interface;
    var temp_code = output.contracts[contractName].bytecode;
    console.log("out : ",outputPath + '/' + contractName.slice(1) + '.abi');
    fs.writeFileSync(outputPath + '/' + contractName.slice(1) + '.abi', temp_abi, 'utf-8');
    fs.writeFileSync(outputPath + '/' + contractName.slice(1) + '.code', temp_code, 'utf-8');
}
