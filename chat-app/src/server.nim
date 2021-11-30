import asyncdispatch, asyncnet # implements asynchronous sockets
type
    Client = ref object 
       socket: AsyncSocket
       netAddr: string
       id: int
       connected: bool
    
    Server = ref object 
      socket: AsyncSocket
      clients: seq[Client]
proc newServer(): Server = Server(socket: newAsyncSocket(), clients: @[] )
var server=newServer()
proc loop(server: Server, port=8000){.async.}=
   server.socket.bindAddr(port.Port) #[ Sets up the server socket by binding it to a port and calling listen. 
   The integer port param needs to be cast to a Port type that the bindAddr procedure 
   expects.]#
   server.socket.listen() 
   while true:
      let clientSocket=await server.socket.accept()# waits till a new client is connected
      echo("Accepted connection!")
waitFor loop(server)
      
