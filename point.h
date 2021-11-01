#ifndef __POINT_H__
#define __POINT_H__

#define dfloat float

// an xy point
typedef struct Point
{
    // TODO some kind of check for imaginary or not?
    // TODO update calls to p->x
    dfloat Re;
    dfloat Im;
} Point;

// store points before and after performing the newton iteration on them
typedef struct PointChange
{
    Point *before;
    Point *after;
} PointChange;

// L2 distance between two points
dfloat L2Distance(Point *z1, Point *z2);

#endif
