import scala.io.Source
import java.io.File

object Main {
  var data = new Array[Int](30000)
  var p = 0
  var s = ""

  def process(loc: Int): Int = {
    var t = loc
    while (t < s.length) {
      val c = s(t)
      if (c == '+') data(p) += 1
      if (c == '-') data(p) -= 1
      if (c == '>') p += 1
      if (c == '<') p -= 1
      if (c == ',') {
        val cc = scala.io.StdIn.readChar()
        data(p) = cc.toInt
      }
      if (c == '.') print(data(p).toChar)
      if (c == '[') t = process(t + 1)
      if (c == ']' && data(p) != 0) {
        if (data(p) != 0) return process(loc)
        return t
      }
      t += 1
    }
    s.length
  }

  def main(args: Array[String]): Unit = {
    if (args.length >= 1) {
      val fileName = args(0)
      val file = new File(fileName)

      if (file.exists() && file.isFile) {
        val source = Source.fromFile(file)
        s = source.mkString
        process(0)
        source.close()
      } else println("Failed to open the file.")
    } else {
      println("Missing file argument.")
    }
  }
}

