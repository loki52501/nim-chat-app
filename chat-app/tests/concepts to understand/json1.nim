import json
let data ="""
{"username":"Dominik"}
"""
let obj=parseJson(data)
assert obj.kind==JObject
assert obj["username"].kind==JString
assert obj["username"].str=="Dominik"