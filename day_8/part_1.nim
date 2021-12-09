import strutils, sequtils, math, sugar

var signals = readFile("input.txt").splitLines.mapIt(it.split('|')[
    1].strip.split(' ')).mapIt(it.filterIt((2..4).contains(it.len) or it.len ==
    7)).mapIt(it.len)
echo sum(signals)