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

## Channel models

* AWGN channel: `h = ones(K, V, N)`

* Uplink, Rayleigh channel without diversity: `h = 1/sqrt(2)*(repmat(randn(1, V, N), K, 1)+1j*repmat(randn(1, V, N), K, 1))`

* Rayleigh channel with diversity: `h = 1/sqrt(2)*(randn(K, V, N)+1j*randn(K, V, N))`

* Downlink, Rayleigh channel without diversity: `h = 1/sqrt(2)*(repmat(repmat(randn(1, 1, N),K, 1), 1, V)+1j*(repmat(repmat(randn(1, 1, N), K, 1), 1, V)))`

* Downlink, Rayleigh channel with diversity: `h = 1/sqrt(2)*(repmat(randn(K, 1, N), 1, V)+1j*repmat(randn(K, 1, N), 1, V))`

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

* [Error probability bounds for SCMA signals](http://ieeexplore.ieee.org/document/7910519/)

* [SCMA Codebooks Optimization Based on Genetic Algorithm](http://ieeexplore.ieee.org/document/8011314/)
