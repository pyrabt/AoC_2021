import strutils

var horizontal = 0
var depth = 0

var course = readFile("input_1.txt").splitLines()
for input in course:
    var direction = input.split(" ")[0] 
    var amount = parseInt(input.split(" ")[1]) 
    case direction:
      of "forward":
          horizontal += amount
      of "down":
          depth += amount
      of "up":
          depth -= amount

echo horizontal, " * ", depth, " = ",horizontal*depth