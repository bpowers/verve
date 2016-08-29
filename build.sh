#!/bin/sh
set -x
set -e

SPEC_INCLUDE_DIR="src\\Trusted\\Spec\\Tal"

BUILD="./build"

CSC="$BUILD/csc.exe"
BARTOK="./tools/Bartok/bartok.exe"
MANAGED_DIR="obj\\Checked\\Kernel"
MANAGED_KERNEL_EXE="$MANAGED_DIR\\kernel.exe"

mkdir -p "$(echo $MANAGED_DIR | sed -e 's/\\/\//g')"

KSRC=$(echo src/Checked/Kernel/*.cs \
     src/Checked/Kernel/Stubs/Stubs.cs \
     src/Checked/Libraries/System/*.cs \
     src/Checked/Libraries/System/Runtime/CompilerServices/*.cs \
     src/Checked/Libraries/System/Runtime/InteropServices/*.cs \
     src/Checked/Libraries/System/Collections/*.cs \
     src/Checked/Libraries/System/Text/*.cs \
     src/Checked/Libraries/System/IO/*.cs \
     src/Checked/Libraries/System/Globalization/*.cs \
     src/Checked/Libraries/System/Net/IP/*.cs \
     src/Checked/Libraries/System/Net/Sockets/*.cs \
     src/Checked/Libraries/System/Net/*.cs \
     src/Checked/Libraries/NetStack/Lib/*.cs \
     src/Checked/Libraries/NetStack/Common/*.cs \
     src/Checked/Libraries/NetStack/Events/*.cs \
     src/Checked/Libraries/NetStack2/*.cs \
     src/Checked/Libraries/NetStack2/TCP/*.cs \
     src/Checked/Libraries/NetStack2/Protocol/*.cs \
     src/Checked/Libraries/NetStack2/NetDrivers/*.cs \
     src/Checked/Libraries/NetStack2/Nic/*.cs \
     src/Checked/Libraries/NetStack2/Private/*.cs \
     src/Checked/Drivers/Network/Intel/*.cs | sed -e 's/\//\\/g')

wine $CSC /main:Kernel /nostdlib /debug /optimize /nowarn:169 /nowarn:649 /nowarn:3021 /nowarn:626 /nowarn:414 /out:$MANAGED_KERNEL_EXE $KSRC

wine $BARTOK \
     /Tal=true /CompileOnly=true /GenObjFile=false /NullRuntime=true \
     /StdLibName=kernel /VerifiedRuntime=true /StackOverflowChecks=true \
     /LazyTypeInits=false /ABCD=false /SsaArraySimple=false \
     /IrImproveTypes=false /IrInitTypeInliner=false /IrFindConcrete=false \
     /DevirtualizeCall=false /ConvertUseJumpTablesForSwitch=false \
     /NoCalleeSaveRegs=true /ThrowOnInternalError=true /nullgc /centralpt \
     /WholeProgram=true /outdir: $MANAGED_DIR $MANAGED_KERNEL_EXE

AS="$BUILD/x86_x86/ml.exe"
LINK="$BUILD/x86_x86/link.exe"
NUCLEUS_MS="obj/iso_ms/safeos/nucleus.exe"
NUCLEUS_CP="obj/iso_cp/safeos/nucleus.exe"

mkdir -p $(dirname $NUCLEUS_MS)
mkdir -p $(dirname $NUCLEUS_CP)

wine $AS /c /Fo$MANAGED_DIR\\Kernel.000000.obj $MANAGED_DIR\\Kernel.000000.asm
wine $AS /c /Fo$MANAGED_DIR\\Kernel.000001.obj $MANAGED_DIR\\Kernel.000001.asm
wine $AS /c /Fo$MANAGED_DIR\\Kernel.000002.obj $MANAGED_DIR\\Kernel.000002.asm
KERNEL_OBJS="$MANAGED_DIR\\Kernel.000000.obj $MANAGED_DIR\\Kernel.000001.obj $MANAGED_DIR\\Kernel.000002.obj"
wine $AS /c /Fo$MANAGED_DIR\\labels.obj src\\Trusted\\Spec\\labels.asm

#run $AS /c "/I$SPEC_INCLUDE_DIR" /Foobj\\Checked\\Nucleus\\nucleus_ms.obj obj\\Checked\\Nucleus\\nucleus_ms.asm
wine $AS /c "/I$SPEC_INCLUDE_DIR" /Foobj\\Checked\\Nucleus\\nucleus_cp.obj obj\\Checked\\Nucleus\\nucleus_cp.asm
#run $LINK $KERNEL_OBJS obj\\Checked\\Nucleus\\nucleus_ms.obj $MANAGED_DIR\\labels.obj "/out:$NUCLEUS_MS" "/entry:?NucleusEntryPoint" /subsystem:native /nodefaultlib /base:0x300000 /LARGEADDRESSAWARE /driver /fixed
wine $LINK $KERNEL_OBJS obj\\Checked\\Nucleus\\nucleus_cp.obj $MANAGED_DIR\\labels.obj "/out:$NUCLEUS_CP" "/entry:?NucleusEntryPoint" /subsystem:native /nodefaultlib /base:0x300000 /LARGEADDRESSAWARE /driver /fixed

#mkdir -p obj/iso_ms/safeos
mkdir -p obj/iso_cp/safeos

#cp obj/Trusted/BootLoader/loader obj/iso_ms/
cp obj/Trusted/BootLoader/loader obj/iso_cp/

#echo "Size=$(wc -c $NUCLEUS_MS)   Path=/safeos/nucleus.exe" >obj/iso_ms/safeos/boot.ini
echo "Size=$(wc -c $NUCLEUS_CP)   Path=/safeos/nucleus.exe" >obj/iso_cp/safeos/boot.ini
unix2dos obj/iso_cp/safeos/boot.ini

#wine build/cdimage.exe -j1 -lSafeOS -bobj/Trusted/BootLoader/etfs.bin obj/iso_ms bin/safeos_ms.iso
wine build/cdimage.exe -j1 -lSafeOS -bobj\\Trusted\\BootLoader\\etfs.bin obj\\iso_cp bin\\safeos_cp.iso
