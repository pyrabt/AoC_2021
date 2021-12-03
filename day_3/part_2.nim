import strutils, parseutils, sequtils

func getOxGenRating(reports: seq[string], evalIndex: int): uint =
    if evalIndex == reports[0].len and reports.len > 1:
        return 0
    if reports.len == 1:
        var rating: uint
        var success = parseBin(reports[0], rating)
        return (if success > 0: rating else: 0)

    var posBits = 0
    for reading in reports:
        if reading[evalIndex] == '1': inc(posBits)
    if posBits > (reports.len-posBits) or posBits == (reports.len-posBits):
        return getOxGenRating(reports.filterIt(it[evalIndex] == '1'), evalIndex+1)
    else:
        return getOxGenRating(reports.filterIt(it[evalIndex] == '0'), evalIndex+1)

func getCO2ScrubRating(reports: seq[string], evalIndex: int): uint =
    if evalIndex == reports[0].len and reports.len > 1:
        return 0
    if reports.len == 1:
        var rating: uint
        var success = parseBin(reports[0], rating)
        return (if success > 0: rating else: 0)

    var posBits = 0
    for reading in reports:
        if reading[evalIndex] == '1': inc(posBits)
    if posBits > (reports.len-posBits) or posBits == (reports.len-posBits):
        return getCO2ScrubRating(reports.filterIt(it[evalIndex] == '0'), evalIndex+1)
    else:
        return getCO2ScrubRating(reports.filterIt(it[evalIndex] == '1'), evalIndex+1)


let report = readFile("input.txt").splitLines()
let oxGen = getOxGenRating(report, 0)
let co2Scrub = getCO2ScrubRating(report,0)
echo oxGen, "*", co2Scrub, " = ", oxGen*co2Scrub