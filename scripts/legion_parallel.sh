#!/bin/bash -l
#$ -S /bin/bash
#$ -l h_rt=6:0:0
#$ -l mem=1G

# Run jobs on specific nodes reserved only for this job, so that we can compare benchmark results.
# XYZ for more available nodes, U to use the RSDG paid ones
#$ -ac allow=U
#$ -ac exclusive
# Use RSDG paid nodes only
#$ -P RCSoftDev
#$ -l paid=1

# Request TMPDIR space (default is 10 GB)
#$ -l tmpfs=1G

# Set the working directory to somewhere in your scratch space.  This is
# a necessary step as compute nodes cannot write to $HOME.
#$ -wd /home/ucapgui/Scratch/purify

# Set the name of the job.
#$ -N purify_WLO_benchmark

# Select the MPI parallel environment and number of cores.
# Has to be multiple of 12 for XYZ nodes, 16 for U nodes
# To request MPI processes simply run multiples of the number
# of threads per nodes i.e. here each node supports 16 threads
# therefore requesting 32 threads will run on two MPI processes
# hence two nodes
#$ -pe mpi 144

#Automatically set threads to processes per node: eg. if on X nodes = 12 OMP threads
export OMP_NUM_THREADS=$(ppn)

#Run our MPI job with the default modules. Gerun is a wrapper script for mpirun. 
## gerun $HOME/purify/build/cpp/benchmarks/mpi_benchmark_MO > $HOME/Scratch/purify/parallelBenchmarkMO.01.$JOB_ID.out
gerun $HOME/BICO/purify/build/cpp/benchmarks/mpi_benchmark_WLO > $HOME/Scratch/purify/parallelBenchmarkWLO.09.$JOB_ID.out
