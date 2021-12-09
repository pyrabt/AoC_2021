import sequtils, strutils, tables, algorithm

proc numSeqContainsSeg(evaluated: string, inner: string): bool =
    for c in inner:
        if not evaluated.contains(c):
            return false
    return true

proc getMask(base: string, modifier: string): string =
    var mask = base
    for c in 0..modifier.len-1:
        mask = mask.replace(modifier[c..c])
    return mask

proc getSegTranslations(segReadings: seq[string]): Table[string, string] =
    var fiveSegs = segReadings.filterIt(it.len == 5)
    var sixSegs = segReadings.filterIt(it.len == 6)
    var one = segReadings.filterIt(it.len == 2)[0]
    var four = segReadings.filterIt(it.len == 4)[0]
    var three = fiveSegs.filterIt(numSeqContainsSeg(it, one))[0]
    fiveSegs.del(fiveSegs.find(three))
    three.sort()
    var five = fiveSegs.filterIt(numSeqContainsSeg(it, getMask(four, one)))[0]
    fiveSegs.del(fiveSegs.find(five))
    five.sort()
    var two = fiveSegs[0]
    two.sort()
    var nine = sixSegs.filterIt(it.len == 6 and numSeqContainsSeg(it, three))[0]
    sixSegs.del(sixSegs.find(nine))
    nine.sort()
    var zero = sixSegs.filterIt(getMask(it, five).len == 2)[0]
    sixSegs.del(sixSegs.find(zero))
    zero.sort()
    var six = sixSegs[0]
    six.sort()
    return {zero: "0", two: "2", three: "3", five: "5", six: "6", nine: "9"}.toTable

    
var sigLines = readFile("input.txt").splitLines.mapIt(it.split('|').mapIt(it.strip.split(" ")))
var total = 0
for line in sigLines:
    var keys = line[0]
    var output = line[1]
    var keyTranslations = getSegTranslations(keys)
    var outputStr: string
    for key in output:
        var sortedKey = key
        sortedKey.sort()
        case key.len:
            of 2:
                outputStr.add("1")
            of 3:
                outputStr.add("7")
            of 4:
                outputStr.add("4")
            of 5:
                outputStr.add(keyTranslations[sortedKey])
            of 6:
                outputStr.add(keyTranslations[sortedKey])
            of 7:
                outputStr.add("8")
            else:
                echo "Unable to translate key: ", key
    total += parseInt(outputStr)
echo total