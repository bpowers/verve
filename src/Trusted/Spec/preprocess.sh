#!/bin/sh
set -e

if [ $# == 0 ]; then
    echo "USAGE: $0 [--cp|--ms] FILENAME"
    exit 1
fi

case $1 in
-cp)
    GcVars='CurrentStack, \$gcSlice, BF, BT, HeapLo, Fi, Fk, Fl, Ti, Tj, Tk, Tl'
    ;;
-ms)
    GcVars='CurrentStack, \$gcSlice, \$color, StackTop, \$fs, \$fn, CachePtr, CacheSize, ColorBase, HeapLo, HeapHi, ReserveMin'
    ;;
*)
    echo "error: first argument must be either --cp or --ms"
    exit 1
    ;;
esac

shift

if [ $# == 0 ]; then
    FILENAME=/dev/stdin
else
    FILENAME="$@"
fi


AllGcVars='GcVars, \$stackState, \$r1, \$r2, \$freshAbs, \$Time'
FrameVars='\$FrameCounts, \$FrameAddrs, \$FrameLayouts, \$FrameSlices, \$FrameAbss, \$FrameOffsets'
_memVars='\$sMem, \$dMem, \$pciMem, \$tMems, \$fMems, \$gcMem'
__MemVars='SLo, DLo, PciLo, TLo, FLo, GcLo, GcHi'
MemVars="\\\$Mem, $_memVars, $__MemVars"
IoVars='\$IoMmuEnabled, \$PciConfigState, DmaAddr'

cat $FILENAME |
    sed -e "s/AllGcVars/$AllGcVars/g" |
    sed -e "s/GcVars/$GcVars/g" |
    sed -e "s/\$FrameVars/$FrameVars/g" |
    sed -e "s/\$memVars/$_memVars/g" |
    sed -e "s/\$MemVars/$MemVars/g" |
    sed -e "s/MemVars/$__MemVars/g" |
    sed -e "s/\$IoVars/$IoVars/g" |
    cat
