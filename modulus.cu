#include <CUDASieve/host.hpp>

#include <iostream>
#include <stdio.h>
#include <math.h>
#include <cinttypes>
#include <vector>
#include <ctime>

int main(int argc, char* argv[])
{
  uint64_t * primes = NULL;
  uint64_t size = 1000;
  // start the timer
  clock_t start_time = clock();
  float elapsed_time;

  KernelData * kerneldata = new KernelData;
  kerneldata->allocate();

  cudaMallocHost(&primes, size*sizeof(uint64_t));

  uint64_t count = 0;
  count = kerneldata->getCount();
  std::cout << "Kernel Size : " << count << std::endl;

  cudaFreeHost(primes);
  cudaFree(primes);

  kerneldata->deallocate();

  elapsed_time = (clock() - start_time)/((double) CLOCKS_PER_SEC);
  std::cout << "total time : " << elapsed_time << " seconds" << std::endl;

  cudaDeviceReset();
  return 0;
}
