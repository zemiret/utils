from bs4 import BeautifulSoup
import requests

html =  requests \
    .get('http://www.erasmusplus.agh.edu.pl/umowy-miedzyinstytucjonalne-erasmus/wykaz-umow-erasmus-2014-2020/') \
    .text

soup = BeautifulSoup(html, 'html.parser')
trs = soup.find_all('tr')[5:]

country_unis = []
for tr in trs:
    tds = tr.find_all('td')
    if 'pracownik' not in tds[0].text.strip():  # we are not appending 'wyjazdy dla pracowników'
        if tds[0].text.strip() != '':   # country has changed
            for uni in set(country_unis):
                print(uni)
            country_unis = []
            print()
            print(tds[0].text.strip())
            print('-----------')
        
        if ('wieit' in tds[7].text.lower()) or ('wiet' in tds[7].text.lower()) or ('wieiit' in tds[7].text.lower()):
            country_unis.append(tds[3].text)


for uni in set(country_unis):
    print(uni)
