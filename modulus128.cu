#include <stdint.h>
#include <iostream>
#include <omp.h>
#include <cuda_runtime.h>           // cudaFreeHost()
#include <CUDASieve/cudasieve.hpp>  // CudaSieve::getHostPrimes()                   

#include "cuda_uint128.h"

int main(int argc, char ** argv)
{
  uint128_t x = (uint128_t) 1 << 120;

  if(argc >= 2)
    x = string_to_u128((std::string)argv[3]);

  std::size_t st;
  uint32_t bottom = std::stoul(argv[1], &st, 10);
  uint32_t top = std::stoul(argv[2], &st, 10);

  size_t len;
  uint64_t * primes = CudaSieve::getHostPrimes(bottom, top, len);

  for(uint32_t i = 0; i < len; i++){
	uint64_t r;	
	uint128_t y = uint128_t::div128to128(x, primes[i], &r);
	if(r == 0) std::cout << primes[i] << std::endl;
  }

  cudaFreeHost(primes);

  std::cout << x << std::endl;

  return 0;

}
