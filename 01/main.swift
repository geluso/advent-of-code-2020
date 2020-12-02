import Foundation

let Target = 2020

func main() {
  let filepath = "./input"
  let fileManager = FileManager()

  if fileManager.fileExists(atPath: filepath) {
    if let contents = fileManager.contents(atPath: filepath) {
      let contentsStr = String(decoding: contents, as: UTF8.self)
      let lines = contentsStr.split(separator: "\n")

      // Part 1: Find the product of two numbers that sum to 2020
      var numbers: Set<Int> = []
      for line in lines {
        let number = Int(line) ?? 0
        let diff = Target - number
        if numbers.contains(diff) {
          print(number, "*", diff, "=", number * diff)
          break
        }

        numbers.insert(number)
      }
      
      // Part 2: Find the product of three numbers that sum to 2020.
      for i in 0...lines.count-3 {
        for j in i+1...lines.count-2 {
          for k in j+1...lines.count-1 {
            let first = Int(lines[i]) ?? 0
            let second = Int(lines[j]) ?? 0
            let third = Int(lines[k]) ?? 0
            if first + second + third == Target {
              print(first, "*", second, "*", third, "=", first * second * third)
              return
            }
          }
        }
      }
    }
  }
}

main()