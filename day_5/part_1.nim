import sequtils, strutils, math

var grid: seq[seq[int]] =  toSeq(0..999).mapIt(toSeq(0..999).mapIt(it*0))
var lines = readFile("input.txt").splitLines().mapIt(it.split("->").mapIt(it.split(",").mapIt(it.strip).mapIt(parseInt(it))))

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

var sum = sum(grid.mapIt(it.filterIt(it >= 2).len))
echo sum