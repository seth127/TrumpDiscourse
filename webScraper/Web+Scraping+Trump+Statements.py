
# coding: utf-8

# In[31]:

from urllib.request import urlopen
from bs4 import BeautifulSoup
import re
import pandas as pd
import numpy as np
import time

def wtf(stringToWrite, saveFileName = 'sample.txt'):
    with open(saveFileName, "w") as text_file:
        text_file.write(str(stringToWrite))


# In[2]:

#Save website that has urls that I want
page = urlopen('http://www.presidency.ucsb.edu/2016_election_speeches.php?candidate=45&campaign=2016TRUMP&doctype=5001')
#http://www.presidency.ucsb.edu/ws/index.php?pid=110306

soup = BeautifulSoup(page, "lxml") 


#with open("soup.txt", "w") as text_file:
#    text_file.write(str(soup))
#
#print("PRINTED soup.txt")

#Create empty list to store links
links = []

#Find all links on page and store in a list
for link in soup.findAll('a', attrs={'href': re.compile("^../ws")}):    
    links.append(link.get('href'))
 
# replace the .. with the address
for i in range(0,len(links)):
    links[i] = links[i].replace('..', 'http://www.presidency.ucsb.edu')

print(str(len(links)) + ' links on this page.')

##### get docs
for link in links:
    print('$$$$$$$$$$$')
    print(link)
    print('...')

    soup = BeautifulSoup(urlopen(link), "lxml") 

    soup.prettify()

    #wtf(str(soup))

    #Print Article Title
    title = soup.title.string

    #Print Date Published
    date = soup.find('span', attrs={'class':"docdate"}).string

    #print(title+' - '+date)

    #Get Content of Article
    text= soup.find('span', attrs ={'class': 'displaytext'})

    text = str(text)

    # Remove extraneous HTML Tags
    text = re.sub('<p>', ' ', text)

    text = re.sub('<.+?>', '', text)

    text = re.sub('\xa0|[     \\n]+', ' ', text)

    #print(text)

    # Write To File
    saveName = 'TrumpStatements/raw/'+title+' - '+date+'.txt'
    wtf(text, saveName)

    # sleep for a few seconds (not sure why, but Tom had this in there)
    print('finished ' + saveName)
    print('sleeping for a second...')
    time.sleep(10+np.random.uniform(-2,2))

