import protocol,json
when isMainModule:
  block:
    let data = """{ "username": "Dominik", "message":"What did you do for the weekend?" } """
    let msg = parseMessage(data)
    assert msg.message == "What did you do for the weekend?"
    doAssert msg.username == "Dominik"
  block:
    let data = "invalid json"
    try:
      let msg = parseMessage(data)
      doAssert false
    except JsonParsingError:
      doAssert true
    except:
      doAssert false
  block:
    let expected = """{"username":"dom","message":"hello"}""" & "\c\l"
    doAssert createMessage("dom", "hello") == expected