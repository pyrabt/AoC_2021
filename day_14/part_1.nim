import strutils, sequtils, tables 

proc getPairRuleTable(rawPairs: seq[string]): Table[string, string] =
    var rulesTable = initTable[string, string]()
    var splitRules = rawPairs.mapIt(it.split(" ").filterIt(it != "->"))
    for rule in splitRules:
        rulesTable[rule[0]] = rule[1]
    return rulesTable

proc getPolymerPairs(polymer: string): seq[string] =
    var pairs: seq[string]
    var pairCount = 0
    while paircount != polymer.len-1:
        pairs.add(polymer[pairCount..pairCount+1])
        pairCount += 1
    return pairs
    
var input = readFile("input.txt").splitLines
var startingPolymer = input[0]
var pairRules =  getPairRuleTable(input[1..^1])

for round in 1..10:
    var polymerPairs = getPolymerPairs(startingPolymer)
    var pairIndex = 1
    for pair in polymerPairs:
        startingPolymer.insert(pairRules[pair], pairIndex)
        pairIndex += 2

var countedElments = startingPolymer.toCountTable
var minElement = countedElments.smallest
var maxElement = countedElments.largest

echo maxElement[1] - minElement[1]