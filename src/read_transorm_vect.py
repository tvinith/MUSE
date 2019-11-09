import numpy as np
import os
import io
import sys
import argparse
# import torch
import joblib

parser = argparse.ArgumentParser(description='Transform Languages')
parser.add_argument("--vect_path", type=str, default="", help="path of all embeddings")
parser.add_argument("--trans_mat", type=str, default="", help="np file rotation and translation")
parser.add_argument("--save_path", type=str, default="", help="dictionary path")

params = parser.parse_args()


class Embeddings(object):

    def __init__(self,name,load_path,rot,trans,save_path):
        self.name = name
        self.load_path = load_path
        self.save_path = save_path
        self.rot  = rot
        self.trans = trans
        self.embedd = None
        self.id2word = None
        self.word2id = None

    def load_vec(self):
        """Read vector from file and store vect,id and word

        Returns
        -------
        type
            Description of returned object.

        """

        vectors = []
        self.word2id = {}
        with io.open(self.load_path, 'r', encoding='utf-8', newline='\n', errors='ignore') as f:
            next(f)
            for i, line in enumerate(f):
                word, vect = line.rstrip().split(' ', 1)
                vect = np.fromstring(vect, sep=' ')
                assert word not in self.word2id, 'word found twice'
                vectors.append(vect)
                self.word2id[word] = len(self.word2id)
                if i==200:
                    break
        self.id2word = {v: k for k, v in self.word2id.items()}
        self.embedd= np.vstack(vectors)
        print("Shape of embeddings : {}".format(self.embedd.shape))

    def save_vec(self):
        """Write vectors to file

        Returns
        -------
        type
            Description of returned object.

        """
        with io.open(self.save_path, 'w', encoding='utf-8') as f:
            for i in range(len(self.embedd)):
                f.write(u"%s %s\n" % (self.id2word[i], " ".join('%.5f' % x for x in self.embedd[i])))

    def transform(self):
        # import pdb;pdb.set_trace()
        dim=self.embedd[0].shape[0]
        self.embedd=(np.add(np.matmul(self.rot,self.embedd.T),self.trans.reshape(dim,1))).T


def main():
    # e=Embeddings()
    trans_param = joblib.load(params.trans_mat)
    print(trans_param)
    vect_files={}
    for files in os.listdir(params.vect_path):
        if files.endswith(".vec"):
            lang_name=files.split('.')[1]
            load_file_ = os.path.join(params.vect_path,files)
            save_path = os.path.join(params.save_path,"{}_trans.vec_t".format(lang_name))
            e=Embeddings(name=lang_name,load_path=load_file_,rot=trans_param[lang_name]['rot'], \
                         trans=trans_param[lang_name]['trans'],save_path=save_path)

            e.load_vec()
            e.transform()
            e.save_vec()
            del e







if __name__ == '__main__':
    main()
