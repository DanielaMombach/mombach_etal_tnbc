import ViennaRNA
import random
import numpy as np

# Duplex fold
sense_seq = """ATG"""
antisense_seq = """ATG"""

fc = ViennaRNA.duplexfold(sense_seq, antisense_seq)

structure = fc.structure
energy = fc.energy

n_shuffles = 100
random_energies = []
sense_list = list(sense_seq)
antisense_list = list(antisense_seq)

for i in range(n_shuffles):
    random.shuffle(sense_list)
    random.shuffle(antisense_list)
    shuffled_sense = ''.join(sense_list)
    shuffled_antisense = ''.join(antisense_list)
    fc_random = ViennaRNA.duplexfold(shuffled_sense, shuffled_antisense)
    random_energies.append(fc_random.energy)

mean_energy = np.mean(random_energies)
std_energy = np.std(random_energies)
z_score = (energy - mean_energy) / std_energy


# Fold compound (RNAfold)
transcript_seq = "ATG"

fc = ViennaRNA.fold_compound(transcript_seq)

(structure, energy) = fc.mfe()

random_energies = []
seq_list = list(transcript_seq)

for i in range(n_shuffles):
    random.shuffle(seq_list)
    shuffled_seq = ''.join(seq_list)
    fc_random = ViennaRNA.fold_compound(shuffled_seq)
    (_, random_energy) = fc_random.mfe()
    random_energies.append(random_energy)

mean_energy = np.mean(random_energies)
std_energy = np.std(random_energies)
z_score = (energy - mean_energy) / std_energy
