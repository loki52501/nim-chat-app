import asyncdispatch, asyncfile
var file=openAsync("tests/Fits/hi.txt")
let dataF=file.readAll()
dataF.callback=
  proc (future:Future[string])=
      echo(future.read())
asyncdispatch.runForever()