#include "newton.h"
#include <math.h>

// fill arrays for points before and after performing the newton iteration on them
__global__ void fillArrays(int ReSpacing, int ImSpacing, dfloat complex *ZvalsInitial,
                           dfloat complex *zVals, int NRe, int NIm)
{
    int x = threadIdx.x + blockDim.x*blockIdx.x;
    int y = threadIdx.y + blockDim.y*blockIdy.y;

    int startRe = 0 - ReSpacing;
    int startIm = 0 - ImSpacing;

    int dx = ReSpacing*2 / Nx;
    int dy = ImSpacing*2 / Ny;

    if (x < NRe && y < NIm)
    {
        // Real value here - evenly spaced from -ReSpacing to Respacing
        // with NRe elements, same for Im
        dfloat Re = x*dx - ReSpacing;
        dfloat Im = y*dy - ImSpacing;

        // fill zVals arrays in row-major format
        zvalsInitial[x + NRe*y] = Re + I*Im;
        zvals       [x + NRe*y] = Re + I*Im;
    }
}

// perform an iteration of newton's method with a thread handling
// each point in points
__global__ void newtonIterate(dfloat complex *zVals, Polynomial *P, Polynomial *Pprime,
                              int N, int Nit)
{
    int n = threadIdx.x + blockIdx.x * blockDim.x;

    if (n < N)
    {
        dfloat complex z = zVals[n];

        // deform Nit iterations of z_i+1 = z_i - P(z_i) / P'(z_i)
        for (int i = 0; i < Nit; ++i)
        {
            // find P(z) and P'(z)
            dfloat complex Pz = Pz(P, z);
            dfloat complex Pprimez = Pz(Pprime, z);

            z = z + Pz/PprimeZ;
        }

        zVals[n] = z;
    }

    // TODO output to CSV / copy back to host and output to CSV
    // TODO find root this point is closest to
}

// compute the L2 distance between two points
dfloat L2Distance(dfloat complex z1, dfloat complex z2)
{
    dfloat ReDiff = creal(z1) - creal(z2);
    dfloat ImDiff = cimag(z1) - cimag(z2);

    return sqrt((ReDiff*ReDiff) + (ImDiff*ImDiff));
}
