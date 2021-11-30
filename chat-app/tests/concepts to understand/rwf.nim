import asyncdispatch, asyncfile
proc readFiles() {.async.} =
    var file= openAsync("tests/Fits/hi.txt",fmReadWriteExisting)
    let data= await file.readAll
    echo(data)
    let writeSomething=readLine(stdin)
    await file.write( "\n"&writeSomething & "\n")
    file.close()

waitFor readFiles()