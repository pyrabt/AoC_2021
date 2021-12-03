import sequtils, strutils, sugar, parseutils 
let mask: uint = 4095
var gammaBinStr: string 
var matrix = readFile("input.txt").splitlines().map(bin => toSeq(bin.items))

for col in 0..matrix[0].len-1:
    var posBits = 0
    for row in matrix:
        if row[col] == '1':
            posBits += 1 
    if posBits > (matrix.len-posBits):
        gammaBinStr.add('1')
    else:
        gammaBinStr.add('0')

var gammaRate: uint64
var success = parseBin(gammaBinStr, gammaRate) > 0

if success:
    let epsilonRate = gammaRate xor mask 
    echo gammaRate, "*", epsilonRate, " = ", gammaRate*epsilonRate