import strutils, sequtils, algorithm

proc getTargetPos(crabPositions: seq[int]): int =
    var medianIndex: int
    if crabPositions.len mod 2 == 0:
        medianIndex = ((((crabPositions.len/2) + (
                crabPositions.len/2)+1))/2).toInt - 1
    else:
        medianIndex = ((crabPositions.len + 1)/2).toInt - 1
    return crabPositions[medianIndex]

var posSeq = readFile("input.txt").strip.split(",").mapIt(parseInt(it))
posSeq.sort
var targetPos = getTargetPos(posSeq)

var totalFuel = 0
for num in posSeq:
    totalFuel += abs(targetPos - num)

echo "Best position: ", targetPos, " -> ", totalFuel
