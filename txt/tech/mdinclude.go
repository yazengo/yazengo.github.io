package main

import (
    "os"
    "fmt"
    "unicode"
    "strings"
    "bufio"
)

func dumpFile(from *os.File, to *os.File) {
    if from == nil || to == nil {
        return
    }

    buf := bufio.NewReader(from)
    line, err := buf.ReadString('\n')
    for err == nil {
        to.WriteString(line)
        line, err = buf.ReadString('\n')
    }
}

func incFileTrim(r rune) bool {
    if unicode.IsSpace(r) || r == '"' {
        return true
    }
    return false
}

func main() {
    if len(os.Args) != 3 {
        fmt.Println("Usage: mdinclude htmlfile outputfile")
        return
    }

    infile, err := os.Open(os.Args[1])
    if err != nil {
        fmt.Printf("\x1b[31;1mfile %s no exit\x1b[0m\n", os.Args[1])
        return
    }
    defer infile.Close()

    outfile, err := os.Create(os.Args[2])
    if err != nil {
        fmt.Printf("\x1b[31;1mfile %s no exit\x1b[0m\n", os.Args[2])
        return
    }
    defer outfile.Close()

    buf := bufio.NewReader(infile)
    line, err := buf.ReadString('\n')
    var incStrings []string
    for err == nil {
        if strings.HasPrefix(line, "#include") {
            // if find the mml file, dump it into the htmlfile
            incStrings = strings.Split(line, " ")
            if len(incStrings) != 2 {
                fmt.Println("#include filename")
                fmt.Print(line)
                return
            }

            incStrings[1] = strings.TrimFunc(incStrings[1], incFileTrim)
            mathFile, err := os.Open(incStrings[1])
            if err != nil {
                fmt.Printf("\x1b[31;1mfile %s no exit\x1b[0m\n", incStrings[1]);
                return
            }
            defer mathFile.Close()

            dumpFile(mathFile, outfile)
        } else {
            outfile.WriteString(line)
        }

        line, err = buf.ReadString('\n')
    }
}
