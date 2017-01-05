
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
page = urlopen('http://www.presidency.ucsb.edu/2016_election_speeches.php?candidate=45&campaign=2016TRUMP&doctype=5000')
#http://www.presidency.ucsb.edu/ws/index.php?pid=110306

soup = BeautifulSoup(page) 

with open("soup.txt", "w") as text_file:
    text_file.write(str(soup))

print("PRINTED soup.txt")

#Create empty list to store links
links = []


# In[5]:

#Find all links on page and store in a list
#for link in soup.findAll('a', attrs={'href': re.compile("^http://")}):
for link in soup.findAll('a', attrs={'href': re.compile("^../ws")}):    
    links.append(link.get('href'))
 
# replace the .. with the address
for i in range(0,len(links)):
    links[i] = links[i].replace('..', 'http://www.presidency.ucsb.edu')

print(links)



# In[6]:

#The above list has some links that I don't want so now I will use RE to extract the ones I want into a new list
commentary = []


# In[7]:

for element in links:
    # Match if link contains "commentary-and-editorials" and append the link to commentary
    if (bool((re.findall("commentary-and-editorials", element))) == True):
        commentary.append(element)
    


# In[8]:

print(commentary)


'''

# 

# In[9]:

#Find out number of links
print(len(commentary))
unique= np.unique(commentary)
print(len(unique))
unique[1]
# In[10]:
'''
#Try Scraping One Webpage before trying iteration
editorial= urlopen(links[1])


# In[11]:

soup = BeautifulSoup(editorial) 
wtf(str(soup), 'pre-pretty.txt')

# In[12]:

soup.prettify()
wtf(str(soup), 'post-pretty.txt')
#print(soup.prettify())
#wtf(soup.prettify())

# In[42]:

#Print Article Title
print(soup.title.string)


# In[14]: span class="docdate"

#Print Date Published
dates = soup.find_all('span', attrs={'class':"docdate"})
for date in dates:
    print (date.string)

'''
# In[15]:

dates = soup.find_all('div', attrs={'class':"content2"})[0]

t = dates.prettify()

t.split("<!--",1)[0]
'''

# In[22]:

#Print Content of Article
#text= soup.find_all('div', attrs ={'class': 'content2'})
text= soup.find_all('span', attrs ={'class': 'displaytext'})
    
#print(text)

text = str(text)

#wtf(text)


# Remove extraneous HTML Tags
text = re.sub('<p>', ' ', text)

text = re.sub('<.+?>', '', text)

text = re.sub('\xa0|[     \\n]+', ' ', text)

print(text)



# In[48]:

'''
#Create Empty Data Frame to store documents and meta data
N= 743
SS = pd.DataFrame(pd.np.empty((N,4)) *pd.np.nan)


# In[58]:

SS.columns=['Title','Date','Author', 'Text']
SS


# In[32]:

print('test')
time.sleep(10+np.random.uniform(-5,5))
print('yes')



# In[59]:

for i in (range(len(unique))):
    editorial= urlopen(unique[i])
    soup = BeautifulSoup(editorial) 
    soup.prettify()
    SS['Title'][i] = soup.title.string
    texts = soup.find_all('div', attrs={'class':"content2"})
    for text in texts:   
        t = text.prettify()
        t.split("<!--",1)
        caption = soup.find_all('span', attrs={'class':"wf_caption"})
        for j in caption:
            t.replace(str(j), '')
        t1 = re.sub('<.*>', '', t)
        text = re.sub('\xa0|[     \\n]+', ' ', t1)
        SS['Text'][i] = text
    dates = soup.find_all('span', attrs={'class':"date_added"})
    for date in dates:
        SS['Date'][i] =  date.string
    time.sleep(10+np.random.uniform(-5,5))
    
SS


# In[60]:

SS


# In[ ]:

'''

