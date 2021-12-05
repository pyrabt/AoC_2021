import sequtils, strutils, math

var grid: seq[seq[int]] =  toSeq(0..999).mapIt(toSeq(0..999).mapIt(it*0))
var lines = readFile("input.txt").splitLines().mapIt(it.split("->").mapIt(it.split(",").mapIt(it.strip).mapIt(parseInt(it))))

proc writeDiagGridLine(pointA: (int,int), pointB: (int,int)) =
    var ydiff = pointB[1]-pointA[1]
    var currentX = pointA[0]
    var currentY = pointA[1] 
    if ydiff > 0:
        while currentX <= pointB[0]:
            inc(grid[currentY][currentX])
            inc(currentX)
            inc(currentY)
    else:
        while currentX <= pointB[0]:
            inc(grid[currentY][currentX])
            inc(currentX)
            dec(currentY)

for line in lines:
    var x1: int = line[0][0]
    var y1: int = line[0][1]
    var x2: int = line[1][0]
    var y2: int = line[1][1]

    if y1 == y2:
        var min = min(x1,x2)
        var max = max(x1,x2)
        for i in min..max:
            inc(grid[y1][i])
    elif x1 == x2:
        var min = min(y1,y2)
        var max = max(y1,y2)
        for i in min..max:
            inc(grid[i][x1])
    else:
        var xdiff = x2-x1
        if xdiff > 0:
            writeDiagGridLine((x1,y1), (x2,y2))
        else:
            writeDiagGridLine((x2,y2), (x1,y1))

var sum = sum(grid.mapIt(it.filterIt(it >= 2).len))
echo sum