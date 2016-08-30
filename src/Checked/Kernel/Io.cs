//
// Copyright (c) Microsoft Corporation.  All rights reserved.
//

using System.Runtime.CompilerServices;
using kernel;

namespace kernel
{

internal class IoThread: ThreadStart
{
    public override void Run()
    {
        System.DebugStub.Print(" PLASMA Verve.  ");
        System.DebugStub.Print("IoThread@" + Kernel.CurrentThread + ". ");
        byte[] pciDmaBuffer;
        try {
            CompilerIntrinsics.Cli();
            pciDmaBuffer = NucleusCalls.PciDmaBuffer();
        } finally {
            CompilerIntrinsics.Sti();
        }

        if (pciDmaBuffer == null)
        {
            System.DebugStub.Print("No IO-MMU. ");
            Kernel.kernel.NewSemaphore(0).Wait();
            return;
        }

        // Establish DMA buffer area
        Microsoft.Singularity.Io.DmaMemory.Setup();

        // Enumerate and initialize PCI devices
        for (uint id = 0; id < 65536; id += 8) {
            uint v;
            try {
                CompilerIntrinsics.Cli();
                v = NucleusCalls.PciConfigRead32(id, 0);
            } finally {
                CompilerIntrinsics.Sti();
            }
            if (v == 0x107c8086) {
                // Intel NIC
                System.DebugStub.Print("Found Intel NIC. ");
            }
        }
        System.DebugStub.Print("IoThread done. ");
        Kernel.kernel.NewSemaphore(0).Wait();
    }
}

} // kernel
