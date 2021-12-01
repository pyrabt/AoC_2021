import std/strutils
import std/math

proc getReadings(): seq[int] =
    let inputFile = open("input_1.txt")
    defer: inputFile.close()

    while not inputFile.endOfFile:
        result.add(parseInt(inputFile.readLine()))

var readings = getReadings()

var windowedReadings: seq[int]
for index in 0..readings.len-3:
    windowedReadings.add(sum(readings[index..index+2]))

var increases: int = 0
for i in 1..windowedReadings.len-1:
  if windowedReadings[i] > windowedReadings[i-1]:
    increases += 1

echo increases