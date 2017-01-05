import pandas as pd
import numpy as np
import os

import math
from itertools import repeat



def newDocsToDF(rawPath, bin=5, tt="tt"): ### rawPath is where you folders of documemnts are, organized as [groupName]/raw/...
	# get groups in 
	groups = os.listdir(rawPath)

	# remove these red herrings if necessary
	naw = ['.DS_Store', 'test_train', 'norun', 'fake_data', 'ref']
	[groups.remove(x) for x in groups if x in naw]
	#
	rawFileList=[]
	for groupId in groups:
		for dirpath, dirnames, filenames in os.walk(rawPath+groupId+'/raw'):
			## clean out non .txt files
			filenames = [filename for filename in filenames if ".txt" in filename]
			## create subgroups
			filecount = len(filenames) # how many files are there in this groupId
			print(filecount)
			bincount = math.ceil(filecount/float(bin)) # how many bins do we need
			# create bin labels
			if tt == 'test':
				subgroups = ['test' + str(num) for num in range(0,int(bincount))] # create bins
				sglist = [x for item in subgroups for x in repeat(item, bin)] # make list of bins (copy each option 5x (or whatever you put in the bin=))
				sglist = sglist[:filecount] # trim to the number of files you have
				np.random.shuffle(sglist) # shuffle them before assigning (CHANGE THIS IF WE MAKE IT TEMPORAL)
			elif tt == 'train':
				subgroups = ['train' + str(num) for num in range(0,int(bincount))] # create bins
				sglist = [x for item in subgroups for x in repeat(item, bin)] # make list of bins (copy each option 5x (or whatever you put in the bin=))
				sglist = sglist[:filecount] # trim to the number of files you have
				np.random.shuffle(sglist) # shuffle them before assigning (CHANGE THIS IF WE MAKE IT TEMPORAL)
			elif tt == 'tt':
				subgroupsNums = [str(num) for num in range(0,int(bincount))] # create bins
				# create testing and training labels
				testLabels = [x for x in repeat('test', int(math.ceil(bincount * 0.3)))]
				trainLabels = [x for x in repeat('train', int(math.floor(bincount * 0.7)))]
				ttLabels = testLabels + trainLabels
				# concatenate test and training labels with numbers
				subgroups = [ttLabels[i] + str(subgroupsNums[i]) for i in range(0,len(subgroupsNums))]
				# make list of bins (copy each option 5x (or whatever you put in the bin=))
				sglist = [x for item in subgroups for x in repeat(item, bin)] 
				sglist = sglist[:filecount] # trim to the number of files you have
				np.random.shuffle(sglist) # shuffle them before assigning (CHANGE THIS IF WE MAKE IT TEMPORAL)

			else:
				print('ERROR: Argument tt must be either "train" "test" or "tt" ')
				print('ERROR NOTE: Use "tt" for randomized testing and training')
				return

			## append to rawFileList
			#for filename in filenames:
			#    rawFileList.append([groupId,os.path.join(dirpath, filename), 't'])
			for i in range(0,filecount):
				rawFileList.append([groupId,os.path.join(dirpath, filenames[i]), sglist[i]])

    # create data frame
	newDocsDF = pd.DataFrame(rawFileList, columns=["group","filepath","subgroup"])
	#print(newDocsDF)
	return newDocsDF
	

#newDocsToDF('./data_dsicap/fake_data/')