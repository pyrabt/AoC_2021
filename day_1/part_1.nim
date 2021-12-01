import std/strutils

proc getReadings(): seq[int] =
    let inputFile = open("input_1.txt")
    defer: inputFile.close()

    while not inputFile.endOfFile:
        result.add(parseInt(inputFile.readLine()))

var readings = getReadings()

var increases: int = 0
for i in 1..readings.len-1:
  if readings[i] > readings[i-1]:
    increases += 1

echo increases