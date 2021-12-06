import strutils, sequtils, tables

var fish = {0: 0, 1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0, 7: 0, 8: 0}.toOrderedTable
var fishInput: seq[int] = readFile("input.txt").split(",").mapIt(parseInt(it))
for f in fishInput:
    inc(fish[f])
let days = 256

for day in 1..days:
    var newFish = fish[0]
    for f in 1..8:
        fish[f-1] = fish[f]
        if f == 8:
            fish[f] = 0
    fish[6] += newFish
    fish[8] += newFish

var numFish = 0
for c in 0..8:
    numFish += fish[c]

echo numFish