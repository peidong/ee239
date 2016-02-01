import csv
import math

from pybrain.datasets import SupervisedDataSet
from pybrain.tools.neuralnets import NNregression
from pybrain.tools.customxml.networkwriter import NetworkWriter
from pybrain.tools.customxml.networkreader import NetworkReader
import numpy as np


def run():
    # Preprocess data
    featuresMatrix = []
    targetList = []
    with open('network_backup_dataset.csv', 'rU') as f:
        filereader = csv.reader(f, delimiter=',')
        dow = dict(zip('Monday Tuesday Wednesday Thursday Friday Saturday Sunday'.split(),
           range(7)))

        rowNum = 0
        for row in filereader:
            if rowNum > 0:
                # weekId, dayOfWeek, backupStart, workflowId, fileName 
                features = [int(row[0]), int(dow[row[1]]), int(row[2]), int(row[3][-1:])]
                features.append(int(row[4].split("File_",1)[1]))
                featuresMatrix.append(features)
                # backupSize
                target = [float(row[5])]
                targetList.append(target)

                # print(features)
                # print(target)
            rowNum += 1

    X = np.matrix(featuresMatrix)
    y = np.matrix(targetList)

    num = len(X)
    oneTenth = int(num / 10)
    error = []

    # 10-fold cross validation
    for i in range(10):
        # Partition data
        start = i * oneTenth
        end = (i + 1) * oneTenth
        trainingData = np.concatenate((X[0:start, :], X[end:, :]), axis=0)
        trainingTargets = np.concatenate((y[0:start, :], y[end:, :]), axis=0)
        testingData = X[start:end, :]
        testingTargets = y[start:end, :]
        # print(X)
        # print(trainingData)
        # print(y)
        # print(trainingTargets)

        # Train data
        model = NeuralNetwork(generate=True)
        model.train(trainingData, trainingTargets)

        # Evaluate NN model performance in RMSE        
        for i in range(0, len(testingData)):
            diff = np.subtract(model.predict(testingData[i]),testingTargets[i])
            error.append(math.pow(diff, 2))
            # print(math.sqrt(np.mean(error)))

    RMSE = math.sqrt(np.mean(error))
    print("Root Mean Squared Error (RMSE) is %s " % RMSE)


def train_network(train,target):
    print("Number of features: %s; Number of targets: %s" % (train.shape[1], target.shape[0]))
    data = SupervisedDataSet(train.shape[1], 1) # declare number of dimensions of inputs and targets for the dataset
    data.setField('input', train)
    data.setField('target', target)
    print("Number of training inputs: %s" % len(data))

    n = NNregression(data)
    n.setupNN() # 3-layer FNN by default
    n.runTraining()
    return n.Trainer.module


class NeuralNetwork:
    """ """
    def __init__(self, layers=1, generate=False):
        self._layers = layers
        self._generate = generate
        self._filename = 'neuralnets.xml'

    def train(self, X, y):
        if self._generate:
            self._model = train_network(X, y)
            NetworkWriter.writeToFile(self._model, self._filename)
        else:
            self._model = NetworkReader.readFrom(self._filename)

    def predict(self, x):
        new_x = np.asarray(x).flatten()
        return self._model.activate(new_x)

run()
