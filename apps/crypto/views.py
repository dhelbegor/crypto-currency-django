import requests
import json
from django.shortcuts import render


def home(request):
    # Grab crypto price data
    price_request = requests.get('https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,XRP,ETH,EOS,LTC,XLM&tsyms=USD')
    price = json.loads(price_request.content)

    # Grab crypto news
    api_request = requests.get('https://min-api.cryptocompare.com/data/v2/news/?lang=EN')
    api = json.loads(api_request.content)
    return render(request, 'home/index.html', {'api': api, 'price': price})


def prices(request):
    if request.method == 'POST':
        quote = request.POST['quote']
        return render(request, 'home/prices.html', {'quote': quote})
    else:
        return render(request, 'home/prices.html', {})
