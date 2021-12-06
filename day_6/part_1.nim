import sequtils, strutils

proc mapDay(fishSeq: seq[int]): seq[int] = 
    for fish in fishSeq:
        if fish == 0:
            result.add(6)
        else:
            result.add(fish-1)

var fish: seq[int] = readFile("input.txt").split(",").mapIt(parseInt(it))
let days = 80

for day in 1..days:
    var newFish = fish.filterIt(it == 0).len
    fish = fish.mapDay()
    for n in 1..newFish:
        fish.add(8)

echo fish.len," lanterfish on day 80"