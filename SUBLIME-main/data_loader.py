import warnings
import pickle as pkl
import sys, os

import scipy.sparse as sp
import networkx as nx
import torch
import numpy as np

import scipy.io as scio

# from sklearn import datasets
# from sklearn.preprocessing import LabelBinarizer, scale
# from sklearn.model_selection import train_test_split
# from ogb.nodeproppred import DglNodePropPredDataset
# import copy

from utils import sparse_mx_to_torch_sparse_tensor #, dgl_graph_to_torch_sparse

warnings.simplefilter("ignore")


def parse_index_file(filename):
    """Parse index file."""
    index = []
    for line in open(filename):
        index.append(int(line.strip()))
    return index


def sample_mask(idx, l):
    """Create mask."""
    mask = np.zeros(l)
    mask[idx] = 1
    return np.array(mask, dtype=np.bool)


def load_citation_network(dataset_str, sparse=None):
    names = ['x', 'y', 'tx', 'ty', 'allx', 'ally', 'graph']
    objects = []
    for i in range(len(names)):
        with open("data/ind.{}.{}".format(dataset_str, names[i]), 'rb') as f:
            if sys.version_info > (3, 0):
                objects.append(pkl.load(f, encoding='latin1'))
            else:
                objects.append(pkl.load(f))

    x, y, tx, ty, allx, ally, graph = tuple(objects)
    test_idx_reorder = parse_index_file("data/ind.{}.test.index".format(dataset_str))
    test_idx_range = np.sort(test_idx_reorder)

    if dataset_str == 'citeseer':
        # Fix citeseer dataset (there are some isolated nodes in the graph)
        # Find isolated nodes, add them as zero-vecs into the right position
        test_idx_range_full = range(min(test_idx_reorder), max(test_idx_reorder) + 1)
        tx_extended = sp.lil_matrix((len(test_idx_range_full), x.shape[1]))
        tx_extended[test_idx_range - min(test_idx_range), :] = tx
        tx = tx_extended
        ty_extended = np.zeros((len(test_idx_range_full), y.shape[1]))
        ty_extended[test_idx_range - min(test_idx_range), :] = ty
        ty = ty_extended

    features = sp.vstack((allx, tx)).tolil()
    features[test_idx_reorder, :] = features[test_idx_range, :]

    adj = nx.adjacency_matrix(nx.from_dict_of_lists(graph))
    if not sparse:
        adj = np.array(adj.todense(),dtype='float32')
    else:
        adj = sparse_mx_to_torch_sparse_tensor(adj)

    labels = np.vstack((ally, ty))
    labels[test_idx_reorder, :] = labels[test_idx_range, :]
    idx_test = test_idx_range.tolist()
    idx_train = range(len(y))
    idx_val = range(len(y), len(y) + 500)

    train_mask = sample_mask(idx_train, labels.shape[0])
    val_mask = sample_mask(idx_val, labels.shape[0])
    test_mask = sample_mask(idx_test, labels.shape[0])

    features = torch.FloatTensor(features.todense())
    labels = torch.LongTensor(labels)
    train_mask = torch.BoolTensor(train_mask)
    val_mask = torch.BoolTensor(val_mask)
    test_mask = torch.BoolTensor(test_mask)

    nfeats = features.shape[1]
    for i in range(labels.shape[0]):
        sum_ = torch.sum(labels[i])
        if sum_ != 1:
            labels[i] = torch.tensor([1, 0, 0, 0, 0, 0])
    labels = (labels == 1).nonzero()[:, 1]
    nclasses = torch.max(labels).item() + 1

    return features, nfeats, labels, nclasses, train_mask, val_mask, test_mask, adj


def load_data(args):
    return load_citation_network(args.dataset, args.sparse)



def load_data2(args, fold):
    return load_citation_network2(args.dataset, fold, args.sparse)


def load_citation_network2(dataset_str, fold, sparse=None):

    data_File = './data/'+dataset_str+'_data_fold5.mat'
    data = scio.loadmat(data_File)
    #print(data['Yeast_f'+fold+'_test_feature'])
    features_train = data['Yeast_f'+fold+'_train_feature']  
    features_test = data['Yeast_f' + fold + '_test_feature'] 
    features = np.row_stack((features_train, features_test))  
    ntrain = features_train.shape[0]  
    ntest = features_test.shape[0]  

    labels_train = data['Yeast_f' + fold + '_train_label']  
    labels_train = labels_train.transpose()  
    labels_test = data['Yeast_f' + fold + '_test_label'] 
    labels_test = labels_test.transpose()  
    labels = np.column_stack((labels_train, labels_test))  
    labels = labels[0] 


    for i in range(labels.shape[0]):
        if labels[i] == -1:
            labels[i] = 2


    adj = np.zeros(ntrain+ntest)

    idx_train = range(ntrain)
    idx_val = range(ntrain, ntrain+ntest)
    idx_test = range(ntrain, ntrain+ntest)

    train_mask = sample_mask(idx_train, features.shape[0])
    val_mask = sample_mask(idx_val, features.shape[0])
    test_mask = sample_mask(idx_test, features.shape[0])

    features = torch.FloatTensor(features)
    labels = torch.LongTensor(labels)
    train_mask = torch.BoolTensor(train_mask)
    val_mask = torch.BoolTensor(val_mask)
    test_mask = torch.BoolTensor(test_mask)

    nfeats = features.shape[1]
    nclasses = torch.max(labels).item()


    return features, nfeats, labels, nclasses, train_mask, val_mask, test_mask, adj

#load_citation_network2('CircR2Disease', '1')