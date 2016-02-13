
# coding: utf-8

# ### Project 2 
# This explanation are mainly from different sections of the scikit-learn tutorial on text classification available at http://scikit-learn.org.

# ### Dataset
# 1. In this project we work with “20 Newsgroups” dataset. It is a collection of approximately 20,000 newsgroup documents, partitioned (nearly) evenly across 20 different newsgroups, each corresponding to a different topic.
# 2. To manually load the data, you need to run this python code.<a href="https://www.dropbox.com/s/5oek8qbsge1y64b/fetch_data.py?dl=0">link to fetch_data.py</a>
# 3. Easiest way to load the data is to use the built-in dataset loader for 20 newsgroups from scikit-learn package.
# 

# In[38]:

from sklearn.datasets import fetch_20newsgroups
categories = [ 'comp.graphics', 'comp.sys.mac.hardware']
twenty_train = fetch_20newsgroups(subset='train', categories=categories, shuffle=True, random_state=42)
twenty_test = fetch_20newsgroups(subset='test', categories=categories, shuffle=True, random_state=42)


# In[39]:

print type(twenty_train)
#Use help() command to know more about your object
#print help(twenty_train)
print twenty_train.keys()


# In[40]:

print twenty_train.data[0]
print twenty_train.target[0]
print twenty_train.target_names[twenty_train.target[0]]


# In[32]:

print twenty_train.target_names


# The files themselves are loaded in memory in the data attribute.

# In[33]:

print len(twenty_train.data)
print len(twenty_train.filenames)
print len(twenty_train.target)
print len(twenty_train.target_names)


# ### Extracting features from text files

# ### CountVectorizer
# Convert a collection of text documents to a matrix of token counts

# In[34]:

from sklearn.feature_extraction.text import CountVectorizer

vectorizer = CountVectorizer(min_df=1)
vectorizer  


# In[35]:

from sklearn.feature_extraction import text
stop_words = text.ENGLISH_STOP_WORDS
print stop_words
print len(stop_words)


# In[36]:

corpus = [
    'This is the first document.',
    'This is the second second document.',
    'And the third one.',
    'Is this the first document?',
]
X = vectorizer.fit_transform(corpus)
X 


# In[37]:

#help(vectorizer)


# In[14]:

vectorizer.get_feature_names() == (
    ['and', 'document', 'first', 'is', 'one',
     'second', 'the', 'third', 'this'])


X.toarray()   


# The converse mapping from feature name to column index is stored in the vocabulary_ attribute of the vectorizer:

# In[15]:

vectorizer.vocabulary_.get('document')


# In[16]:

count_vect = CountVectorizer()
X_train_counts = count_vect.fit_transform(twenty_train.data)
X_train_counts.shape


# In[17]:

from itertools import islice

def take(n, iterable):
    "Return first n items of the iterable as a list"
    return list(islice(iterable, n))


print count_vect.vocabulary_.keys()[0:10]
print take(5,count_vect.vocabulary_.iteritems())
print count_vect.vocabulary_.get('3ds2scn')


# In[18]:

from sklearn.feature_extraction.text import TfidfTransformer
tfidf_transformer = TfidfTransformer()
X_train_tfidf = tfidf_transformer.fit_transform(X_train_counts)
X_train_tfidf.shape
X_train_tfidf.toarray()[:30,:10]


# ### Training a classifier
# 
# Let's train a classifier to predict the category of a post.

# In[19]:

from sklearn.naive_bayes import MultinomialNB
clf = MultinomialNB().fit(X_train_tfidf, twenty_train.target)


# In[20]:

docs_new = ['He is an OS developer', 'OpenGL on the GPU is fast']
X_new_counts = count_vect.transform(docs_new)
X_new_tfidf = tfidf_transformer.transform(X_new_counts)

predicted = clf.predict(X_new_tfidf)

for doc, category in zip(docs_new, predicted):
    print('%r => %s' % (doc, twenty_train.target_names[category]))


# ### Building a pipeline
# In order to make the vectorizer => transformer => classifier easier to work with, scikit-learn provides a Pipeline class that behaves like a compound classifier:

# In[21]:

from sklearn.pipeline import Pipeline
text_clf = Pipeline([('vect', CountVectorizer()),
                     ('tfidf', TfidfTransformer()),
                     ('clf', MultinomialNB()),
])


# In[22]:

text_clf = text_clf.fit(twenty_train.data, twenty_train.target)


# In[23]:

import numpy as np
twenty_test = fetch_20newsgroups(subset='test',
    categories=categories, shuffle=True, random_state=42)
docs_test = twenty_test.data
predicted = text_clf.predict(docs_test)
np.mean(predicted == twenty_test.target) 


# In[24]:

from sklearn import metrics
print(metrics.classification_report(twenty_test.target, predicted,
    target_names=twenty_test.target_names))

metrics.confusion_matrix(twenty_test.target, predicted)

