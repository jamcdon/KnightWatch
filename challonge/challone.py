import requests

url = "https://minindy:3akKsaAWtvhvgVBLBlUnfmp2eCDoqLA8E0vWD5Xd@api.challonge.com/v1/tournaments/knightWatchTourney/matches.json"

params = {
	"tournament": "knightWatchTourney", 
	"api_key": "3akKsaAWtvhvgVBLBlUnfmp2eCDoqLA8E0vWD5Xd"
}

req = requests.get(url, params = params)

data = req.text

print(data)
