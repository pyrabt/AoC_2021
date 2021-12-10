import sequtils, strutils, sets, heapqueue, algorithm, math

var tubeMap = readFile("input.txt").splitLines.mapIt(toseq(it.items).mapIt(parseInt($it)))

proc getBasinSize(column: int, row: int): int =
    var points = initHashSet[(int,int)]()
    var q = [(column,row)].toHeapQueue
    while q.len > 0:
        var current = q.pop()
        points.incl(current)
        var curCol = current[0]
        var curRow = current[1]
        if curCol > 0 and tubeMap[curRow][curCol-1] < 9 and not points.contains((curCol-1, curRow)):
            q.push((curCol-1, curRow))
        if curCol < tubeMap[0].len-1 and tubeMap[curRow][curCol+1] < 9 and not points.contains((curCol+1, curRow)):
            q.push((curCol+1, curRow))
        if curRow > 0 and tubeMap[curRow-1][curCol] < 9 and not points.contains((curCol, curRow-1)):
            q.push((curCol, curRow-1))
        if curRow < tubeMap.len-1 and tubeMap[curRow+1][curCol] < 9 and not points.contains((curCol, curRow+1)) :
            q.push((curCol, curRow+1))
    return points.len

var numRows = tubeMap.len
var numCols = tubeMap[0].len
var basins: seq[int]
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
            basins.add(getBasinSize(col, row))

basins.sort(SortOrder.Descending)
echo  prod(basins[0..2])