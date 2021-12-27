import strutils, sequtils

var octopiGrid = readFile("puzzleInput.txt").splitLines.mapIt(it.items.toSeq.mapIt(parseInt($it)))
var numOcto = octopiGrid.len*octopiGrid[0].len
proc increaseEnergyLevels() =
    for row in 0 ..< octopiGrid.len:
        for octopus in 0 ..< octopiGrid[row].len:
            inc(octopiGrid[row][octopus])

proc getNeighbors(position: (int, int)): seq[(int,int)] =
    var neighbors = newSeq[(int,int)]()
    #ALR
    if position[0] > 0:
        neighbors.add((position[0]-1, position[1]))
        if position[1] > 0:
            neighbors.add((position[0]-1, position[1]-1))
        if position[1] < octopiGrid[0].len-1:
            neighbors.add((position[0]-1, position[1]+1))
    #L
    if position[1] > 0:
            neighbors.add((position[0], position[1]-1))
    #R
    if position[1] < octopiGrid[0].len-1:
            neighbors.add((position[0], position[1]+1))
    #BLR
    if position[0] < octopiGrid.len-1:
        neighbors.add((position[0]+1, position[1]))
        if position[1] > 0:
            neighbors.add((position[0]+1, position[1]-1))
        if position[1] < octopiGrid[0].len-1:
            neighbors.add((position[0]+1, position[1]+1))
    return neighbors

proc processFlashes(): int =
    var finished = false
    var flashed = newSeq[(int,int)]()
    var flashCount = 0
    while finished != true:
        finished = true
        for row in 0 ..< octopiGrid.len:
            for col in 0 ..< octopiGrid[0].len:
                if octopiGrid[row][col] > 9 and not flashed.contains((row, col)):
                    #flash
                    inc(flashCount)
                    finished = false
                    flashed.add((row, col))
                    var neighbors = getNeighbors((row, col))
                    for nb in neighbors:
                        inc(octopiGrid[nb[0]][nb[1]])
    for row in 0 ..< octopiGrid.len:
        octopiGrid[row] = octopiGrid[row].mapIt(if it > 9: 0 else: it)
    return flashCount

var steps = 0
var roundFlashes = 0
while roundFlashes != numOcto:    
    increaseEnergyLevels()
    roundFlashes = processFlashes()
    inc(steps)

echo steps 
