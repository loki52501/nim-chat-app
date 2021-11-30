import json

type  # defines a new Message type
  Message* = object # the * symbol indicates that the modules can be exported
    username*: string
    message*: string
proc parseMessage*(data:string):Message=
    let dataJson=parseJson(data) #[parseJson procedure accepts a string 
                                  and returns a value of the JsonNode type]#
    result.username=dataJson["username"].getStr # gets the value under the username key
    result.message=dataJson["message"].getStr
    #[ the result variable is implicitily defined for you, 
    so that there is no need for return]#
proc createMessage*(username,message:string):string =
    result = $(%{
      "username": %username,
      "message" : %message
      }) & "\c\l"
       #[1 The $ converts the JsonNode 
    returned by the % operator into a string.
    the % is used to convertstrings, integers, floats, 
    and more into the appropriate JsonNodes]#  