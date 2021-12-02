import strutils, sequtils

var readings = readFile("input_1.txt").splitlines().map(parseInt)
echo zip(readings, readings[3..^1]).filterIt(it[1] > it[0]).len