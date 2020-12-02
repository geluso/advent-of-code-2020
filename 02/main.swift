import Foundation

func main() {
  let filepath = "./input"
  let fileManager = FileManager()

  if fileManager.fileExists(atPath: filepath) {
    if let contents = fileManager.contents(atPath: filepath) {
      let contentsStr = String(decoding: contents, as: UTF8.self)
      let lines = contentsStr.split(separator: "\n")

      // Part 1: Count the number of valid passwords.
      // 1-3 a: abcde
      // 1-3 b: cdefg
      // 2-9 c: ccccccccc
      var validPasswords = 0
      var validPart2Passwords = 0
      for line in lines {
        let cells = line.split(separator: " ")
        let range = cells[0]
        let letter = cells[1].split(separator: ":")[0]
        let password = cells[2]

        let minmax = range.split(separator: "-")
        let min = Int(minmax[0]) ?? 0
        let max = Int(minmax[1]) ?? 0

        var occurences = 0
        for char in password {
          if String(char) == letter {
            occurences += 1
          }
        }

        if min <= occurences && occurences <= max {
          validPasswords += 1
          print("  valid", line)
        } else {
          print("invalid", line)
        }

        let firstIndex = password.index(password.startIndex, offsetBy: min - 1)
        let secondIndex = password.index(password.startIndex, offsetBy: max - 1)

        let firstLetter = String(password[firstIndex])
        let secondLetter = String(password[secondIndex])
        let isValid = firstLetter == letter && secondLetter != letter ||
                      firstLetter != letter && secondLetter == letter
        if isValid {
          print("  valid", line)
          validPart2Passwords += 1
        } else {
          print("invalid", line)
        }
        print()
      }

      print(validPasswords, "valid part 1 passwords")
      print(validPart2Passwords, "valid part 2 passwords")
    }
  }
}

main()