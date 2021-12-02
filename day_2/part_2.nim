var horizontal, depth, aim = 0

proc down(amount: int) = aim += amount
proc up(amount: int) = aim -= amount
proc forward(amount: int) = 
    horizontal += amount
    depth += amount*aim

include input

echo horizontal*depth