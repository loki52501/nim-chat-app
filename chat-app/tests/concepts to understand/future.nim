import asyncdispatch
var fututre=newFuture[int]()
doAssert(not fututre.finished)

fututre.callback =
   proc (fututre:Future[int]) =
       echo ("Future is no longer empty, ",fututre.read)

       fututre.complete(42)