import sequtils, strutils, math 

proc generatePaper(x: int, y: int, startingDots: seq[seq[string]]): seq[seq[string]] =
    var paper = newSeqWith[y, newSeq[string](x)]
    for yIndex in 0..<y:
        for xIndex in 0..<x:
            paper[yIndex][xIndex] = "."
    for dot in startingDots:
        var dotX = parseInt(dot[0])
        var dotY = parseInt(dot[1])
        paper[dotY][dotX] = "#"
    return paper

proc foldUp(paper: seq[seq[string]], foldIndex: int): seq[seq[string]] =
    var foldedPaper = paper[0..<foldIndex]
    for y in countDown(paper.len-1, foldIndex+1):
        for x in 0..<paper[0].len: 
            var foldedY = abs(y-(paper.len-1))
            if paper[y][x] == "#":
                foldedPaper[foldedY][x] = "#"
    return foldedPaper

proc foldLeft(paper: seq[seq[string]], foldIndex: int): seq[seq[string]] =
    var foldedPaper = paper.mapIt(it[0..<foldIndex])
    for y in 0..<paper.len:
        for x in countDown(paper[0].len-1, foldIndex+1):
            var foldedX = abs(x-(paper[0].len-1))
            if paper[y][x] == "#":
                foldedPaper[y][foldedX] = "#"
    return foldedPaper

proc printPaper(paper: seq[seq[string]]) =
    for line in paper:
        var lineStr: string
        for x in line:
            lineStr.add(x)
        echo lineStr

var input = readFile("input.txt").splitLines
var dots = input.filterIt(it.contains(",")).mapIt(it.split(","))
var folds = input.filterIt(it.contains("=")).mapIt(it.split(" ")[2].split("="))
let maxX: int = dots.mapIt(parseInt(it[0])).max + 1
let maxY: int = dots.mapIt(parseInt(it[1])).max + 1

# PART 1
var partOnePaper = generatePaper(maxX, maxY, dots)
if folds[0][0] == "x":
    partOnePaper = foldLeft(partOnePaper, parseInt(folds[0][1]))
else:
    partOnePaper = foldUp(partOnePaper, parseInt(folds[0][1]))

echo "Part 1: ", sum(partOnePaper.mapIt(it.filterIt(it == "#").len))

# Part 2
var paper = generatePaper(maxX, maxY, dots)
for fold in folds:
    case fold[0]:
        of "x":
            paper = foldLeft(paper, parseInt(fold[1]))
        of "y":
            paper = foldUp(paper, parseInt(fold[1]))
echo "Part 2:"
printPaper(paper)