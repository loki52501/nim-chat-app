import os
import threadpool

echo "chat application started"
if paramCount()==0: #checks if there is any parameters while executing
    quit("Please specify the server address")
let serverAdddr=paramStr(1)        #the parameter in cmd line is the server address, after connecting to server address it executes the echo command.
echo "connecting to ",serverAdddr
while true:
    let message=spawn stdin.readLine()# creating a new thread as not to block main thread using spawn, user enter message here
    echo "sending\"",^message,"\"" 
    #[The readLine procedure returns a string value, but when this 
    procedure is executed in another thread, its return value isn’t immediately available. 
    To deal with this, spawn returns a special type called FlowVar[T], which holds the value that the procedure you spawned returns.
    The ^ operator can be used to retrieve the value from a FlowVar[T] object]#
