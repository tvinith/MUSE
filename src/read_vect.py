import numpy as np
import os
import io
import sys
import argparse
import torch
import joblib

parser = argparse.ArgumentParser(description='GRET training')
parser.add_argument("--src_lang", type=str, default="", help="source language")
parser.add_argument("--tgt_lang", type=str, default="", help="target language")
parser.add_argument("--src_path", type=str, default="", help="source embeddings path")
parser.add_argument("--tgt_path", type=str, default="", help="target embeddigns path")
parser.add_argument("--dico_path", type=str, default="", help="dictionary path")

params = parser.parse_args()



def load_vec(emb_path):
    vectors = []
    word2id = {}
    with io.open(emb_path, 'r', encoding='utf-8', newline='\n', errors='ignore') as f:
        next(f)
        for i, line in enumerate(f):
            word, vect = line.rstrip().split(' ', 1)
            vect = np.fromstring(vect, sep=' ')
            assert word not in word2id, 'word found twice'
            vectors.append(vect)
            word2id[word] = len(word2id)

    id2word = {v: k for k, v in word2id.items()}
    embeddings = np.vstack(vectors)
    return embeddings, id2word, word2id

def load_dictionary(path, word2id1, word2id2,src_embed,tgt_embed):
    """
    Return a torch tensor of size (n, 2) where n is the size of the
    loader dictionary, and sort it by source word frequency.
    """
    print("Read Dictionary")
    assert os.path.isfile(path)

    pairs = []
    not_found = 0
    not_found1 = 0
    not_found2 = 0

    with io.open(path, 'r', encoding='utf-8') as f:
        for _, line in enumerate(f):
            assert line == line.lower()
            word1, word2 = line.rstrip().split()
            if word1 in word2id1 and word2 in word2id2:
                pairs.append((word1, word2))
            else:
                not_found += 1
                not_found1 += int(word1 not in word2id1)
                not_found2 += int(word2 not in word2id2)

    # sort the dictionary by source word frequencies
    pairs = sorted(pairs, key=lambda x: word2id1[x[0]])
    # dico = torch.LongTensor(len(pairs), 2)
    dico_src={}
    dico_tgt={}
    for i, (word1, word2) in enumerate(pairs):
        dico_src[i] = src_embed[word2id1[word1]]
        dico_tgt[i = tgt_embed[word2id2[word2]]
        import pdb;pdb.set_trace()

    dico=[dico_src,dico_tgt]
    return dico


def main():
    src_embed,id2word1, word2id1 = load_vec(params.src_path)
    tgt_embed,id2word2, word2id2 = load_vec(params.tgt_path)
    dico = load_dictionary(params.dico_path,word2id1,word2id2,src_embed,tgt_embed)
    joblib.dump(dico,"test_lib.jlb")


if __name__ == "__main__":
    print("Running extract vect")
    main()
