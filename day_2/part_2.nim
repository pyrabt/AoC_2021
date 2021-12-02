import strutils

var horizontal, depth, aim = 0

var course = readFile("input_1.txt").splitLines()
for input in course:
    var direction = input.split(" ")[0] 
    var amount = parseInt(input.split(" ")[1]) 
    case direction:
      of "forward":
          horizontal += amount
          depth += amount*aim
      of "down":
          aim += amount
      of "up":
          aim -= amount

echo horizontal, " * ", depth, " = ",horizontal*depth