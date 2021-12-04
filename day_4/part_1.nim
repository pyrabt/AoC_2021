import sequtils, strutils, sugar, math

var bingoCalls = readLines("input.txt", 1)[0].strip.split(",")

proc getBingoCards(): seq[seq[seq[string]]] =
    var bingoCards: seq[seq[seq[string]]]
    var inputLines = readFile("input.txt").splitLines()[2..^1].map(l => l.split(" ").filterIt(it > ""))
    var card: seq[seq[string]]
    for line in inputLines:
        if line.len == 0:
            bingoCards.add(card)
            card = newSeq[seq[string]]()
        else:
            card.add(line)
    return bingoCards

proc checkForWinner(bingoCards: seq[seq[seq[string]]]): int =
    for cardNumber, card in bingoCards.pairs:
        # check row
        for row in card:
            if row.filterIt(it == "X").len == 5:
                return cardNumber
    
    # check col
    for cardNumber, card in bingoCards.pairs:
        for col in 0..4:
            if @[card[0][col], card[1][col],card[2][col],card[3][col],card[4][col]].filterIt(it == "X").len == 5:
                return cardNumber
    
    return -1

proc getUncalledSum(card: seq[seq[string]]): int =
    var total = 0
    for line in card:
        total += sum(line.filter(x => x != "X").map(value => parseInt(value)))
    return total


var bingoCards = getBingoCards()
var callCount = 0
var winningCard: int
var winningCall: int
for call in bingoCalls:
    inc(callCount)

    # mark cards
    for card in 0..bingoCards.len-1:
        for row in 0..bingoCards[card].len-1:
            if bingoCards[card][row].contains(call):
                var matchIndex = bingoCards[card][row].find(call)
                bingoCards[card][row][matchIndex] = "X"

    if callcount < 5: continue

    # if call count >= 5 check cards
    var winnerCheck = checkForWinner(bingoCards)
    if winnerCheck != -1:
        winningCall = parseInt(call)
        winningCard = winnerCheck
        break
    
echo "Winning Card is #", winningCard+1, " with a score of: ", winningCall*getUncalledSum(bingoCards[winningCard])
