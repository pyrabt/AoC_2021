var horizontal, depth = 0

proc down(amount: int) = depth += amount
proc up(amount: int) = depth -= amount
proc forward(amount: int) = horizontal += amount

include input

echo horizontal*depth