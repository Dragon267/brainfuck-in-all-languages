import java.io.FileReader

var data = IntArray(30000)
var p = 0
lateinit var s: String

fun process(loc: Int): Int {
    var t = loc
    while (t < s.length) {
        val c = s[t]
        if (c == '+') data[p]++
        if (c == '-') data[p]--
        if (c == '>') p++
        if (c == '<') p--
        if (c == ',') {
            val cc = readLine()!!.get(0)
            data[p] = cc.toInt()
        }
        if (c == '.') print(data[p].toChar())
        if (c == '[') t = process(t + 1)
        if (c == ']' && data[p] != 0) {
            if (data[p] != 0) return process(loc)
            return t
        }
        t++
    }
    return s.length
}

fun main(args: Array<String>) {
    data.fill(0)
    val fileName = args[0]
    val file = FileReader(fileName)

    s = file.readText()
    process(0)
    file.close()
}

