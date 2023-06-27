import std/[random, strutils, sequtils, strformat, sugar]

proc roll(sides: int): int =
  rand(sides - 1) + 1

proc d(amount, sides: int): seq[int] =
  result = @[]
  for i in 0..(amount-1):
    result.add(roll(sides))

proc adv(sides: int): int =
  max(roll(sides), roll(sides))

proc dis(sides: int): int =
  min(roll(sides), roll(sides))

proc test(dice: seq[(int, int)], target: int, numOfSucc: int): bool =
  var metTarget = 0
  for pair in dice:
    metTarget += (pair[0].d pair[1]).countIt(it >= target)
  result = metTarget >= numOfSucc

proc testChance(numOfTest: int, test: () -> bool): int =
  result = 0
  for i in 0..numOfTest:
    if test(): result += 1

proc printTest(numOfDice, target, numOfSucc: int) =
  var totalPasses = 0
  let numOfTests = 100_000
  
  for i in 0..5:
    let passes = testChance(numOfTests, () => test(@[(numOfDice, 6)], target, numOfSucc)) 
    totalPasses += passes
  echo &"Total passes dc{target}/{numOfSucc} {numOfDice}d6: {totalPasses}/{numOfTests * 6} = {totalPasses / (numOfTests * 6) * 100} %"

when isMainModule:
  randomize()

  var numOfSucc = 1
  printTest(1, 4, numOfSucc)
  printTest(2, 4, numOfSucc)
  printTest(3, 4, numOfSucc)
  printTest(4, 4, numOfSucc)
  printTest(5, 4, numOfSucc)
  printTest(6, 4, numOfSucc)

  numOfSucc = 2
  printTest(1, 4, numOfSucc)
  printTest(2, 4, numOfSucc)
  printTest(3, 4, numOfSucc)
  printTest(4, 4, numOfSucc)
  printTest(5, 4, numOfSucc)
  printTest(6, 4, numOfSucc)

  numOfSucc = 3
  printTest(1, 4, numOfSucc)
  printTest(2, 4, numOfSucc)
  printTest(3, 4, numOfSucc)
  printTest(4, 4, numOfSucc)
  printTest(5, 4, numOfSucc)
  printTest(6, 4, numOfSucc)

  numOfSucc = 4
  printTest(1, 4, numOfSucc)
  printTest(2, 4, numOfSucc)
  printTest(3, 4, numOfSucc)
  printTest(4, 4, numOfSucc)
  printTest(5, 4, numOfSucc)
  printTest(6, 4, numOfSucc)
