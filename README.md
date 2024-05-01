# ga-samu
Genetic algorithm with Matlab to find the best location for a SAMU (Emergency Medical Service) station in a hypothetical city  for the Artificial Intelligence discipline.

## Problem

There is a hypothetical city measuring 8 km by 7 km that is divided into neighborhoods. In each neighborhood, a number of emergency calls are recorded. Then, the genetic algorithm must find the most well-located point to install the SAMU (Emergency Medical Service) station.

![image](https://github.com/hugodiasg/ga-samu/assets/80465879/08d3a6d0-09e1-4dd6-b091-d717b9fbd1d4)

The fitness function should be:

![image](https://github.com/hugodiasg/ga-samu/assets/80465879/c16a5e0c-6efa-4c46-bcad-ed0c20236f18)

## About the Genetic Algorithm

Here are some pieces of information about the genetic algorithm:
- There is Elitism, and it keeps the best individual for the next generations;
- Natural selection with biased roulette;
- Mutation rate = 1% (just one coordinate X or Y is changed by the mutation);
- The crossover creates three children "c" between two parents "p1" and "p2" and selects the best one to move on to the next generation:
![image](https://github.com/hugodiasg/ga-samu/assets/80465879/92157a48-9eba-4914-a526-b0f2a709e928)
 
## Running the Genetic Algorithm

![image](https://github.com/hugodiasg/ga-samu/assets/80465879/a3182b59-8c1c-4fb3-9aa3-75a75fb0cd96)

![image](https://github.com/hugodiasg/ga-samu/assets/80465879/3485e5bb-fdfd-4306-92fa-0d2e348d9271)

