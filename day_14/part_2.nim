import sequtils, strutils, tables

proc getPairRuleTable(rawPairs: seq[string]): Table[string, string] =
    var rulesTable = initTable[string, string]()
    var splitRules = rawPairs.mapIt(it.split(" ").filterIt(it != "->"))
    for rule in splitRules:
        rulesTable[rule[0]] = rule[1]
    return rulesTable

proc getPolymerPairs(polymer: string): OrderedTable[string, int] =
    var pairs: seq[string]
    var pairsTable = initOrderedTable[string, int]()
    var pairCount = 0
    while paircount != polymer.len-1:
        pairs.add(polymer[pairCount..pairCount+1])
        pairCount += 1

    for pair in pairs:
        if pairsTable.hasKey(pair):
            pairsTable[pair] += 1
        else:
            pairsTable[pair] = 1
    return pairsTable

proc getCharCounts(polymer: string): Table[string, int] =
    var counts = initTable[string, int]()
    for c in polymer:
        if counts.hasKey($c):
            inc(counts[$c])
        else:
            counts[$c] = 1
    return counts

var input = readFile("input.txt").splitLines
var startingPolymer = input[0]
var pairRules = getPairRuleTable(input[1..^1])
var polymerPairs = getPolymerPairs(startingPolymer)
var charCounts = getCharCounts(startingPolymer)

for i in 1..40:
    var newPairs = initOrderedTable[string, int]()
    for pair, count in polymerPairs:
        var insertChar = pairRules[pair]
        var newPairA = $pair[0] & insertChar
        var newPairB = insertChar & $pair[1]
        if charCounts.hasKey(insertChar): charCounts[insertChar] +=
                count else: charCounts[insertChar] = count
        if newPairs.hasKey(newPairA): newPairs[newPairA] += count else:
            newPairs[newPairA] = count
        if newPairs.hasKey(newPairB):
            newPairs[newPairB] += count
        else:
            newPairs[newPairB] = count
    polymerPairs = newPairs

echo max(charCounts.values.toSeq) - min(charCounts.values.toSeq)
