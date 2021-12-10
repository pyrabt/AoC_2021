import sequtils, strutils, sets

var tubeMap = readFile("input.txt").splitLines.mapIt(toseq(it.items))

var numRows = tubeMap.len
var numCols = tubeMap[0].len
var total = 0
for row in 0..numRows-1:
    for col in 0..numCols-1:
        var current = tubeMap[row][col]
        if col > 0 and tubeMap[row][col-1] <= current:
            continue
        elif col < numCols-1 and tubeMap[row][col+1] <= current:
            continue
        elif row > 0 and tubeMap[row-1][col] <= current:
            continue
        elif row < numRows-1 and tubeMap[row+1][col] <= current:
            continue
        else:
            total += parseInt($current) + 1

echo total

var x = toHashSet([(1,1)])
x = x.union(toHashSet([(1,1)]))
echo x
echo x.contains((1,1))