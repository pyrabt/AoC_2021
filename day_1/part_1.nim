import strutils, sequtils, sugar

var readings = readFile("input_1.txt").splitlines().map(value => parseInt(value))
echo zip(readings, readings[1..^1]).filterIt(it[1] > it[0]).len