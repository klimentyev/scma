# Sparse Code Multiple Access (SCMA) scheme demonstration

Bit error rate (BER) simulation of **SCMA** scheme (based on [presentation](http://www.innovateasia.com/5g/images/pdf/1st%205G%20Algorithm%20Innovation%20Competition-ENV1.0%20-%20SCMA.pdf) from [1st 5G Algorithm Innovation Competition](http://www.innovateasia.com/5g/en/)) in **Matlab**/**Octave**.

## Objectives

To provide implementations of **SCMA** encoding/decoding algorithms for use in the researches of new schemes for 5G telecommunication standard.

## Description

This project demonstrates BER simulation of **SCMA** scheme.

The main features of project:

* codebooks are from [presentation](http://www.innovateasia.com/5g/images/pdf/1st%205G%20Algorithm%20Innovation%20Competition-ENV1.0%20-%20SCMA.pdf)

* Log-MPA algorithm is used

* current version is only demonstration and  works with the next SCMA codebooks parameters: *M* = 4, *d_f* = 3 and the number of non-zero elements in codewords is equal 2 (notes from paper [M. Taherzadeh, H. Nikopour, A. Bayesteh and Hadi Baligh. SCMA Codebook Design](https://arxiv.org/pdf/1408.3653v1.pdf)).

The code is written in **Matlab**, but fully compatible with **Octave**.
Unfortunately, the program executions very slow in **Octave**.

The mex function generation in **Matlab** increases the speed of execution approximately in 15 times.

## Running

Run script `simulation.m`.

## Future work

Implementation of decoder for arbitrary **SCMA** codebooks parameters.

## Contact

Vyacheslav P. Klimentyev, vklimentyev@gmail.com

## Contributions

Thanks to Alexander B. Sergienko, PhD, Saint Petersburg Electrotechnical University "LETI", Saint Petersburg, Russia.

## Our publications (SCMA investigation)

* [Detection of SCMA signal with channel estimation error](http://ieeexplore.ieee.org/document/7561515/)

* [SCMA detection with channel estimation error and resource block diversity](http://ieeexplore.ieee.org/document/7491765/)

* [A low-complexity SCMA detector for AWGN channel based on solving overdetermined systems of linear equations](http://ieeexplore.ieee.org/document/7779331/)