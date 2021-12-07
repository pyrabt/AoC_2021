import strutils, sequtils, algorithm

proc fuelUsed(crabPos: int, targetPos: int): int =
    var n = abs(targetPos-crabPos)
    return (n * (n+1) / 2).toInt
        
proc getTargetPos(crabPositions: seq[int]): (int,int) =
    var targetCosts: seq[int]
    for targetPostion in 0..crabPositions[^1]:
        var sum = 0
        for currentPos in crabPositions: 
            sum += fuelUsed(currentPos, targetPostion)
        targetCosts.add(sum)
    return (targetCosts.minIndex, targetCosts.min)

var posSeq = readFile("input.txt").strip.split(",").mapIt(parseInt(it))
posSeq.sort
var targetPos = getTargetPos(posSeq)

echo "Best position: ", targetPos[0]," -> ",targetPos[1]