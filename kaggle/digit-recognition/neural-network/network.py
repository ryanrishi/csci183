#   THEANO_FLAGS='nvcc.fastmath=True,floatX=float32,device=gpu,cuda.root=/usr/local/cuda'  python <myscript>.py

import numpy
import csv

# might not need all of these
import numpy as np, pickle,scipy.ndimage , glob, skimage.color, skimage.transform, skimage.util
from sklearn.metrics import mean_squared_error
from skimage.filters.rank import subtract_mean
from skimage.morphology import disk
import matplotlib.pyplot as plt
import matplotlib.cm as cm
import pandas as pd
# import theanets
from zodbpickle import pickle #Optional. Because big pickles fail sometimes if using the normal python version
# import climate
import math
import theano.tensor as TT
import theano.sparse as SS
import theano
from mlp import HiddenLayer
from theano.tensor.signal import downsample
from theano.tensor.nnet import conv
import theano.tensor as T
import lasagne
from lasagne import layers
from lasagne.updates import nesterov_momentum
from nolearn.lasagne import NeuralNet
from nolearn.lasagne import BatchIterator
from lasagne.init import Constant, Glorot, GlorotUniform
import random

train = []

train = numpy.loadtxt(open('../train.csv', 'r'), delimiter=',', skiprows=1)
features = numpy.delete(train, 0, 1)
labels = train[:, 0]
labels.reshape(labels, (-1, 1))

test = numpy.loadtxt(open('../test.csv', 'r'), delimiteer=',', skiprows=1)



with open('submission_neural-network.csv','w') as f:

    f.write("ImageID,Label")

    towrite= ""
    for id,pred in zip(submit_ids,submit_predictions):

        towrite+="%s"%id
        for p in pred:
            towrite+=",%s"%p

        towrite+="\n"
    f.write(towrite[:-1])
