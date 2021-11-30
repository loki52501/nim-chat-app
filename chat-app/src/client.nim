import os,threadpool,asyncdispatch,asyncnet,protocol

let serverAddr = paramStr(1) # read the server address from command line input
let name = paramStr(2)#  get the username for the chat application

proc connect(socket:AsyncSocket,serverAddr:string) {.async.}=
    echo("connecting to",serverAddr)
    await socket.connect(serverAddr,8000.Port) # connects to server address supplied, on the default port 8000
    echo "connected!"
    while true: 
        let line= await socket.recvLine() 
        let parsed =parseMessage(line)#continuously attempting to read message from client
        echo(parsed.username, " said ",parsed.message)
   
if paramCount()!=2:
  quit ("Please specify the server address and the username, e.g. ./client localhost Alice")



var socket = newAsyncSocket() # create a socket to connect to the server
asyncCheck connect(socket, serverAddr) # connect to the server and start listening


var messageFlowVar = spawn stdin.readLine() # use spawn to create a new thread, message is of type FlowVar[string] holding the string returned by readLine
while true:
  if messageFlowVar.isReady(): # once user types a message
    let message1 = createMessage(name, ^messageFlowVar) # creates the string representation of the message
    echo ("sending ",message1) # message is of FlowVar[T] type and can be accessed by ^ operator
    asyncCheck socket.send(message1)
    messageFlowVar = spawn stdin.readLine() # keep waiting for the next user input
  asyncdispatch.poll()