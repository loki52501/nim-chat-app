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

proc `$` (client:Client):string=
   $client.id & "(" & client.netAddr & ")"

proc processMessages(server:Server,client:Client) {.async.} =
   while(true):
      let line=await client.socket.recvLine() # waiting for input from the user
      if line.len==0: # different servers return empty string, socket disconnects from that server
         echo client.netAddr," disconnected!"
         client.connected=false
         client.socket.close() #stops the client's socket as its disconnected
         return
      else:
         echo client.netAddr," sent: ",line
         for c in server.clients: # to send message to every client
            if c.id!=client.id and c.connected:
               await c.socket.send(line & "\c\l")      

proc loop(server: Server, port=8000){.async.}=
   server.socket.bindAddr(port.Port) #[ Sets up the server socket by binding it to a port and calling listen. 
   The integer port param needs to be cast to a Port type that the bindAddr procedure 
   expects.]#
   server.socket.listen() 
   while true:
      let (netAddr,clientSocket)=await server.socket.acceptAddr()#  acceptAddr returns a tuple[string, AsyncSocket] type. The tuple is unpacked into two variables
      echo("Accepted connection! from ",netAddr)
      let client=Client(
         socket:clientSocket,
         netAddr:netAddr,
         id:server.clients.len,
         connected:true
      )
      server.clients.add(client) #Adds the new instance of the client to the clients sequence
      asyncCheck processMessages(server,client)   
var server=newServer()
echo "listening.."
waitFor server.loop()
      