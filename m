From: Jan-Hendrik Zab <jan@jhz.name>
Subject: Re: Add Sony Vaio VPCZ1 series to the nopnp table
Date: Tue, 30 Mar 2010 22:39:11 +0200
Message-ID: <20100330203911.GA89560@jhz.name>
References: <20100329233257.GA85504@jhz.name>
 <20100329233901.GF5864@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from red.unix-ag.uni-hannover.de ([130.75.176.204]:50152 "EHLO
	jhz.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755072Ab0C3UjZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Mar 2010 16:39:25 -0400
Content-Disposition: inline
In-Reply-To: <20100329233901.GF5864@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: torvalds@linux-foundation.org, linux-input@vger.kernel.org

On 29/03/10 16:39 -0700, Dmitry Torokhov wrote:
> Hi Jan-Hendrik,
> 
> On Tue, Mar 30, 2010 at 01:32:57AM +0200, Jan-Hendrik Zab wrote:
> > The entire Sony Vaio VPCZ1 series seems to need the nopnp option set to
> > get the touchpad working. This patch adds the laptops to the nopnp table
> > to automatically set it.
> > 
> > Signed-off-by: Jan-Hendrik Zab <jan@jhz.name>
> > 
> 
> In what way the PNP data is messed up? Can we get a dmesg of the boot
> without the patch?

Attached dmesg output below.

	-jhz


Linux version 2.6.34-rc2-ARCH-00392-g0e52d6f-dirty (jan@middleman) (gcc version 4.4.3 20100316 (prerelease) (GCC) ) #3 SMP PREEMPT Tue Mar 30 18:44:58 CEST 2010
Command line: root=/dev/sda2 ro usbcore.autosuspend=1
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 0000000000095c00 (usable)
 BIOS-e820: 0000000000095c00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000009363f000 (usable)
 BIOS-e820: 000000009363f000 - 00000000936bf000 (reserved)
 BIOS-e820: 00000000936bf000 - 00000000937bf000 (ACPI NVS)
 BIOS-e820: 00000000937bf000 - 00000000937ff000 (ACPI data)
 BIOS-e820: 00000000937ff000 - 0000000093800000 (usable)
 BIOS-e820: 0000000093800000 - 00000000a0000000 (reserved)
 BIOS-e820: 00000000f0000000 - 00000000f4000000 (reserved)
 BIOS-e820: 00000000feb00000 - 00000000feb04000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fed10000 - 00000000fed14000 (reserved)
 BIOS-e820: 00000000fed18000 - 00000000fed1a000 (reserved)
 BIOS-e820: 00000000fed1b000 - 00000000fed20000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffe00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000158000000 (usable)
NX (Execute Disable) protection: active
DMI 2.4 present.
e820 update range: 0000000000000000 - 0000000000001000 (usable) ==> (reserved)
e820 remove range: 00000000000a0000 - 0000000000100000 (usable)
No AGP bridge found
last_pfn = 0x158000 max_arch_pfn = 0x400000000
MTRR default type: uncachable
MTRR fixed ranges enabled:
  00000-9FFFF write-back
  A0000-BFFFF uncachable
  C0000-FFFFF write-protect
MTRR variable ranges enabled:
  0 base 000000000 mask F80000000 write-back
  1 base 0FFE00000 mask FFFE00000 write-protect
  2 base 080000000 mask FE0000000 write-back
  3 base 098000000 mask FF8000000 uncachable
  4 base 094000000 mask FFC000000 uncachable
  5 base 093800000 mask FFF800000 uncachable
  6 base 100000000 mask F80000000 write-back
  7 base 160000000 mask FE0000000 uncachable
x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
last_pfn = 0x93800 max_arch_pfn = 0x400000000
e820 update range: 0000000000001000 - 0000000000010000 (usable) ==> (reserved)
Scanning 1 areas for low memory corruption
modified physical RAM map:
 modified: 0000000000000000 - 0000000000010000 (reserved)
 modified: 0000000000010000 - 0000000000095c00 (usable)
 modified: 0000000000095c00 - 00000000000a0000 (reserved)
 modified: 00000000000e0000 - 0000000000100000 (reserved)
 modified: 0000000000100000 - 000000009363f000 (usable)
 modified: 000000009363f000 - 00000000936bf000 (reserved)
 modified: 00000000936bf000 - 00000000937bf000 (ACPI NVS)
 modified: 00000000937bf000 - 00000000937ff000 (ACPI data)
 modified: 00000000937ff000 - 0000000093800000 (usable)
 modified: 0000000093800000 - 00000000a0000000 (reserved)
 modified: 00000000f0000000 - 00000000f4000000 (reserved)
 modified: 00000000feb00000 - 00000000feb04000 (reserved)
 modified: 00000000fec00000 - 00000000fec01000 (reserved)
 modified: 00000000fed10000 - 00000000fed14000 (reserved)
 modified: 00000000fed18000 - 00000000fed1a000 (reserved)
 modified: 00000000fed1b000 - 00000000fed20000 (reserved)
 modified: 00000000fee00000 - 00000000fee01000 (reserved)
 modified: 00000000ffe00000 - 0000000100000000 (reserved)
 modified: 0000000100000000 - 0000000158000000 (usable)
initial memory mapped : 0 - 20000000
init_memory_mapping: 0000000000000000-0000000093800000
 0000000000 - 0093800000 page 2M
kernel direct mapping tables up to 93800000 @ 16000-1a000
init_memory_mapping: 0000000100000000-0000000158000000
 0100000000 - 0158000000 page 2M
kernel direct mapping tables up to 158000000 @ 18000-1f000
ACPI: RSDP 00000000000fe020 00024 (v02   Sony)
ACPI: XSDT 00000000937fe120 00074 (v01   Sony     VAIO 20100205      01000013)
ACPI: FACP 00000000937fc000 000F4 (v04   Sony     VAIO 20100205 MSFT 01000013)
ACPI: DSDT 00000000937ed000 0B086 (v02   Sony     VAIO 20100205 MSFT 01000013)
ACPI: FACS 000000009376f000 00040
ACPI: ASF! 00000000937fd000 000A5 (v32   Sony     VAIO 20100205 MSFT 01000013)
ACPI: HPET 00000000937fb000 00038 (v01   Sony     VAIO 20100205 MSFT 01000013)
ACPI: APIC 00000000937fa000 0008C (v02   Sony     VAIO 20100205 MSFT 01000013)
ACPI: MCFG 00000000937f9000 0003C (v01   Sony     VAIO 20100205 MSFT 01000013)
ACPI: SLIC 00000000937ec000 00176 (v01   Sony     VAIO 20100205 MSFT 01000013)
ACPI: BOOT 00000000937eb000 00028 (v01   Sony     VAIO 20100205 MSFT 01000013)
ACPI: SSDT 00000000937e9000 001B4 (v01   Sony     VAIO 20100205 INTL 20051117)
ACPI: ASPT 00000000937e6000 00034 (v04   Sony     VAIO 20100205 MSFT 01000013)
ACPI: SSDT 00000000937e5000 009F1 (v01   Sony     VAIO 20100205 INTL 20051117)
ACPI: Local APIC address 0xfee00000
No NUMA configuration found
Faking a node at 0000000000000000-0000000158000000
Initmem setup node 0 0000000000000000-0000000158000000
  NODE_DATA [0000000100000000 - 0000000100004fff]
 [ffffea0000000000-ffffea0004bfffff] PMD -> [ffff880100200000-ffff8801037fffff] on node 0
Zone PFN ranges:
  DMA      0x00000010 -> 0x00001000
  DMA32    0x00001000 -> 0x00100000
  Normal   0x00100000 -> 0x00158000
Movable zone start PFN for each node
early_node_map[4] active PFN ranges
    0: 0x00000010 -> 0x00000095
    0: 0x00000100 -> 0x0009363f
    0: 0x000937ff -> 0x00093800
    0: 0x00100000 -> 0x00158000
On node 0 totalpages: 964037
  DMA zone: 56 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 3917 pages, LIFO batch:0
  DMA32 zone: 14280 pages used for memmap
  DMA32 zone: 585336 pages, LIFO batch:31
  Normal zone: 4928 pages used for memmap
  Normal zone: 355520 pages, LIFO batch:31
ACPI: PM-Timer IO Port: 0x408
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x04] enabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x05] enabled)
ACPI: LAPIC (acpi_id[0x05] lapic_id[0x00] disabled)
ACPI: LAPIC (acpi_id[0x06] lapic_id[0x00] disabled)
ACPI: LAPIC (acpi_id[0x07] lapic_id[0x00] disabled)
ACPI: LAPIC (acpi_id[0x08] lapic_id[0x00] disabled)
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Using ACPI (MADT) for SMP configuration information
ACPI: HPET id: 0x8086a201 base: 0xfed00000
8 Processors exceeds NR_CPUS limit of 4
SMP: Allowing 4 CPUs, 0 hotplug CPUs
nr_irqs_gsi: 24
early_res array is doubled to 64 at [1a000 - 1a7ff]
PM: Registered nosave memory: 0000000000095000 - 0000000000096000
PM: Registered nosave memory: 0000000000096000 - 00000000000a0000
PM: Registered nosave memory: 00000000000a0000 - 00000000000e0000
PM: Registered nosave memory: 00000000000e0000 - 0000000000100000
PM: Registered nosave memory: 000000009363f000 - 00000000936bf000
PM: Registered nosave memory: 00000000936bf000 - 00000000937bf000
PM: Registered nosave memory: 00000000937bf000 - 00000000937ff000
PM: Registered nosave memory: 0000000093800000 - 00000000a0000000
PM: Registered nosave memory: 00000000a0000000 - 00000000f0000000
PM: Registered nosave memory: 00000000f0000000 - 00000000f4000000
PM: Registered nosave memory: 00000000f4000000 - 00000000feb00000
PM: Registered nosave memory: 00000000feb00000 - 00000000feb04000
PM: Registered nosave memory: 00000000feb04000 - 00000000fec00000
PM: Registered nosave memory: 00000000fec00000 - 00000000fec01000
PM: Registered nosave memory: 00000000fec01000 - 00000000fed10000
PM: Registered nosave memory: 00000000fed10000 - 00000000fed14000
PM: Registered nosave memory: 00000000fed14000 - 00000000fed18000
PM: Registered nosave memory: 00000000fed18000 - 00000000fed1a000
PM: Registered nosave memory: 00000000fed1a000 - 00000000fed1b000
PM: Registered nosave memory: 00000000fed1b000 - 00000000fed20000
PM: Registered nosave memory: 00000000fed20000 - 00000000fee00000
PM: Registered nosave memory: 00000000fee00000 - 00000000fee01000
PM: Registered nosave memory: 00000000fee01000 - 00000000ffe00000
PM: Registered nosave memory: 00000000ffe00000 - 0000000100000000
Allocating PCI resources starting at a0000000 (gap: a0000000:50000000)
Booting paravirtualized kernel on bare hardware
setup_percpu: NR_CPUS:4 nr_cpumask_bits:4 nr_cpu_ids:4 nr_node_ids:1
PERCPU: Embedded 26 pages/cpu @ffff880001800000 s77608 r8192 d20696 u524288
pcpu-alloc: s77608 r8192 d20696 u524288 alloc=1*2097152
pcpu-alloc: [0] 0 1 2 3 
early_res array is doubled to 128 at [1a800 - 1b7ff]
Built 1 zonelists in Node order, mobility grouping on.  Total pages: 944773
Policy zone: Normal
Kernel command line: root=/dev/sda2 ro usbcore.autosuspend=1
PID hash table entries: 4096 (order: 3, 32768 bytes)
Checking aperture...
No AGP bridge found
Subtract (60 early reservations)
  #1 [0001000000 - 00017009b8]   TEXT DATA BSS
  #2 [0000095c00 - 0000100000]   BIOS reserved
  #3 [0001701000 - 00017011fc]             BRK
  #4 [0000010000 - 0000012000]      TRAMPOLINE
  #5 [0000012000 - 0000016000]     ACPI WAKEUP
  #6 [0000016000 - 0000018000]         PGTABLE
  #7 [0000018000 - 000001a000]         PGTABLE
  #8 [0100000000 - 0100005000]       NODE_DATA
  #9 [0001701200 - 0001702200]         BOOTMEM
  #10 [00017009c0 - 0001700ba0]         BOOTMEM
  #11 [0100005000 - 0100006000]         BOOTMEM
  #12 [0100006000 - 0100007000]         BOOTMEM
  #13 [0100200000 - 0103800000]        MEMMAP 0
  #14 [0001700bc0 - 0001700d40]         BOOTMEM
  #15 [0001702200 - 000171a200]         BOOTMEM
  #16 [000171a200 - 0001726200]         BOOTMEM
  #17 [0001727000 - 0001728000]         BOOTMEM
  #18 [0001700d40 - 0001700d81]         BOOTMEM
  #19 [0001700dc0 - 0001700e03]         BOOTMEM
  #20 [0001726200 - 0001726628]         BOOTMEM
  #21 [0001700e40 - 0001700ea8]         BOOTMEM
  #22 [0001700ec0 - 0001700f28]         BOOTMEM
  #23 [0001700f40 - 0001700fa8]         BOOTMEM
  #24 [0001726640 - 00017266a8]         BOOTMEM
  #25 [00017266c0 - 0001726728]         BOOTMEM
  #26 [0001726740 - 00017267a8]         BOOTMEM
  #27 [00017267c0 - 0001726828]         BOOTMEM
  #28 [0001726840 - 00017268a8]         BOOTMEM
  #29 [00017268c0 - 0001726928]         BOOTMEM
  #30 [0001726940 - 00017269a8]         BOOTMEM
  #31 [00017269c0 - 0001726a28]         BOOTMEM
  #32 [0001726a40 - 0001726aa8]         BOOTMEM
  #33 [0001726ac0 - 0001726b28]         BOOTMEM
  #34 [0001726b40 - 0001726ba8]         BOOTMEM
  #35 [0001726bc0 - 0001726c28]         BOOTMEM
  #36 [0001726c40 - 0001726ca8]         BOOTMEM
  #37 [0001726cc0 - 0001726d28]         BOOTMEM
  #38 [0001726d40 - 0001726da8]         BOOTMEM
  #39 [0001700fc0 - 0001700fe0]         BOOTMEM
  #40 [0001726dc0 - 0001726de0]         BOOTMEM
  #41 [0001726e00 - 0001726e20]         BOOTMEM
  #42 [0001726e40 - 0001726e68]         BOOTMEM
  #43 [0001726e80 - 0001726ea8]         BOOTMEM
  #44 [0001800000 - 000181a000]         BOOTMEM
  #45 [0001880000 - 000189a000]         BOOTMEM
  #46 [0001900000 - 000191a000]         BOOTMEM
  #47 [0001980000 - 000199a000]         BOOTMEM
  #48 [0001726ec0 - 0001726ec8]         BOOTMEM
  #49 [0001726f00 - 0001726f08]         BOOTMEM
  #50 [0001726f40 - 0001726f50]         BOOTMEM
  #51 [0001726f80 - 0001726fa0]         BOOTMEM
  #52 [000172a000 - 000172a130]         BOOTMEM
  #53 [000172a140 - 000172a190]         BOOTMEM
  #54 [000172a1c0 - 000172a210]         BOOTMEM
  #55 [000172a240 - 0001732240]         BOOTMEM
  #56 [000199a000 - 000599a000]         BOOTMEM
  #57 [0001732240 - 0001752240]         BOOTMEM
  #58 [0001752240 - 0001792240]         BOOTMEM
  #59 [000001b800 - 0000023800]         BOOTMEM
Memory: 3727048k/5636096k available (4271k kernel code, 1779948k absent, 129100k reserved, 1840k data, 544k init)
SLUB: Genslabs=14, HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
Hierarchical RCU implementation.
NR_IRQS:384
Extended CMOS year: 2000
Console: colour VGA+ 80x25
console [tty0] enabled
hpet clockevent registered
Fast TSC calibration using PIT
Detected 2393.771 MHz processor.
Calibrating delay loop (skipped), value calculated using timer frequency.. 4789.02 BogoMIPS (lpj=7979236)
Security Framework initialized
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Mount-cache hash table entries: 256
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
mce: CPU supports 9 MCE banks
CPU0: Thermal monitoring handled by SMI
using mwait in idle threads.
Performance Events: Westmere events, Intel PMU driver.
... version:                3
... bit width:              48
... generic registers:      4
... value mask:             0000ffffffffffff
... max period:             000000007fffffff
... fixed-purpose events:   3
... event mask:             000000070000000f
ACPI: Core revision 20100121
Setting APIC routing to flat
..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
CPU0: Intel(R) Core(TM) i5 CPU       M 520  @ 2.40GHz stepping 02
Booting Node   0, Processors  #1
CPU1: Thermal monitoring handled by SMI
 #2
CPU2: Thermal monitoring handled by SMI
 #3 Ok.
CPU3: Thermal monitoring handled by SMI
Brought up 4 CPUs
Total of 4 processors activated (19158.33 BogoMIPS).
NET: Registered protocol family 16
ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
ACPI: bus type pci registered
PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf0000000-0xf3ffffff] (base 0xf0000000)
PCI: MMCONFIG at [mem 0xf0000000-0xf3ffffff] reserved in E820
PCI: Using configuration type 1 for base access
bio: create slab <bio-0> at 0
ACPI: EC: Look up EC in DSDT
ACPI: Executed 1 blocks of module-level executable AML code
ACPI: BIOS _OSI(Linux) query ignored
ACPI: SSDT 0000000093690918 003E2 (v01   Sony     VAIO 20100205 INTL 20051117)
ACPI: SSDT 000000009368e618 005CD (v01   Sony     VAIO 20100205 INTL 20051117)
ACPI: SSDT 000000009368fa98 00303 (v01   Sony     VAIO 20100205 INTL 20051117)
ACPI: SSDT 000000009368dd98 00119 (v01   Sony     VAIO 20100205 INTL 20051117)
ACPI: Interpreter enabled
ACPI: (supports S0 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: EC: GPE = 0x17, I/O: command/status = 0x66, data = 0x62
ACPI: Power Resource [DGPR] (on)
ACPI: Power Resource [MGPR] (on)
ACPI: No dock devices found.
PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
\_SB_.PCI0:_OSC invalid UUID
_OSC request data:1 8 1f 
ACPI: PCI Root Bridge [PCI0] (0000:00)
pci_root PNP0A08:00: host bridge window [io  0x0000-0x0cf7]
pci_root PNP0A08:00: host bridge window [io  0x0d00-0xffff]
pci_root PNP0A08:00: host bridge window [mem 0x000a0000-0x000bffff]
pci_root PNP0A08:00: host bridge window [mem 0xa0000000-0xfeafffff]
pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
pci 0000:00:01.0: PME# disabled
pci 0000:00:02.0: reg 10: [mem 0xd1400000-0xd17fffff 64bit]
pci 0000:00:02.0: reg 18: [mem 0xc0000000-0xcfffffff 64bit pref]
pci 0000:00:02.0: reg 20: [io  0x7078-0x707f]
pci 0000:00:16.0: reg 10: [mem 0xd7828100-0xd782810f 64bit]
pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
pci 0000:00:16.0: PME# disabled
pci 0000:00:19.0: reg 10: [mem 0xd7800000-0xd781ffff]
pci 0000:00:19.0: reg 14: [mem 0xd7825000-0xd7825fff]
pci 0000:00:19.0: reg 18: [io  0x7040-0x705f]
pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
pci 0000:00:19.0: PME# disabled
pci 0000:00:1a.0: reg 10: [mem 0xd7827c00-0xd7827fff]
pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1a.0: PME# disabled
pci 0000:00:1b.0: reg 10: [mem 0xd7820000-0xd7823fff 64bit]
pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1b.0: PME# disabled
pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.0: PME# disabled
pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.1: PME# disabled
pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.2: PME# disabled
pci 0000:00:1d.0: reg 10: [mem 0xd7827800-0xd7827bff]
pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1d.0: PME# disabled
pci 0000:00:1f.2: reg 10: [io  0x7068-0x706f]
pci 0000:00:1f.2: reg 14: [io  0x7084-0x7087]
pci 0000:00:1f.2: reg 18: [io  0x7060-0x7067]
pci 0000:00:1f.2: reg 1c: [io  0x7080-0x7083]
pci 0000:00:1f.2: reg 20: [io  0x7020-0x703f]
pci 0000:00:1f.2: reg 24: [mem 0xd7827000-0xd78277ff]
pci 0000:00:1f.2: PME# supported from D3hot
pci 0000:00:1f.2: PME# disabled
pci 0000:00:1f.3: reg 10: [mem 0xd7828000-0xd78280ff 64bit]
pci 0000:00:1f.3: reg 20: [io  0x7000-0x701f]
pci 0000:00:1f.6: reg 10: [mem 0xd7824000-0xd7824fff 64bit]
pci 0000:01:00.0: reg 10: [mem 0xd0000000-0xd0ffffff]
pci 0000:01:00.0: reg 14: [mem 0xa0000000-0xafffffff 64bit pref]
pci 0000:01:00.0: reg 1c: [mem 0xb0000000-0xb1ffffff 64bit pref]
pci 0000:01:00.0: reg 24: [io  0x6000-0x607f]
pci 0000:01:00.0: reg 30: [mem 0xfff80000-0xffffffff pref]
pci 0000:01:00.1: reg 10: [mem 0xd1000000-0xd1003fff]
pci 0000:00:01.0: PCI bridge to [bus 01-01]
pci 0000:00:01.0:   bridge window [io  0x6000-0x6fff]
pci 0000:00:01.0:   bridge window [mem 0xd0000000-0xd10fffff]
pci 0000:00:01.0:   bridge window [mem 0xa0000000-0xb1ffffff 64bit pref]
pci 0000:02:00.0: reg 10: [mem 0xd6800000-0xd6801fff 64bit]
pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
pci 0000:02:00.0: PME# disabled
pci 0000:00:1c.0: PCI bridge to [bus 02-02]
pci 0000:00:1c.0:   bridge window [io  0x5000-0x5fff]
pci 0000:00:1c.0:   bridge window [mem 0xd6800000-0xd77fffff]
pci 0000:00:1c.0:   bridge window [mem 0xd1800000-0xd27fffff 64bit pref]
pci 0000:03:00.0: reg 10: [mem 0xd5800a00-0xd5800aff]
pci 0000:03:00.0: supports D1 D2
pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:03:00.0: PME# disabled
pci 0000:03:00.1: reg 10: [mem 0xd5800900-0xd58009ff]
pci 0000:03:00.1: supports D1 D2
pci 0000:03:00.1: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:03:00.1: PME# disabled
pci 0000:03:00.3: reg 10: [mem 0xd5800000-0xd58007ff]
pci 0000:03:00.3: supports D1 D2
pci 0000:03:00.3: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:03:00.3: PME# disabled
pci 0000:03:00.4: reg 10: [mem 0xd5800800-0xd58008ff]
pci 0000:03:00.4: supports D1 D2
pci 0000:03:00.4: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:03:00.4: PME# disabled
pci 0000:00:1c.1: PCI bridge to [bus 03-03]
pci 0000:00:1c.1:   bridge window [io  0x4000-0x4fff]
pci 0000:00:1c.1:   bridge window [mem 0xd5800000-0xd67fffff]
pci 0000:00:1c.1:   bridge window [mem 0xd2800000-0xd37fffff 64bit pref]
pci 0000:00:1c.2: PCI bridge to [bus 04-0b]
pci 0000:00:1c.2:   bridge window [io  0x3000-0x3fff]
pci 0000:00:1c.2:   bridge window [mem 0xd4800000-0xd57fffff]
pci 0000:00:1c.2:   bridge window [mem 0xd3800000-0xd47fffff 64bit pref]
pci 0000:00:1e.0: PCI bridge to [bus 0c-0c] (subtractive decode)
pci 0000:00:1e.0:   bridge window [io  0xf000-0x0000] (disabled)
pci 0000:00:1e.0:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
pci 0000:00:1e.0:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7] (subtractive decode)
pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff] (subtractive decode)
pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff] (subtractive decode)
pci 0000:00:1e.0:   bridge window [mem 0xa0000000-0xfeafffff] (subtractive decode)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP03._PRT]
\_SB_.PCI0:_OSC invalid UUID
_OSC request data:1 19 1f 
ACPI: PCI Root Bridge [CPBG] (0000:3f)
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 *5 6 7 10 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 *10 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 *5 6 7 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 *10 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 7 *11 12 14 15)
vgaarb: device added: PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
vgaarb: device added: PCI:0000:01:00.0,decodes=io+mem,owns=none,locks=none
vgaarb: loaded
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: pci_cache_line_size set to 64 bytes
reserve RAM buffer: 0000000000095c00 - 000000000009ffff 
reserve RAM buffer: 000000009363f000 - 0000000093ffffff 
reserve RAM buffer: 0000000093800000 - 0000000093ffffff 
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
hpet0: 8 comparators, 64-bit 14.318180 MHz counter
Switching to clocksource tsc
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 10 devices
ACPI: ACPI bus type pnp unregistered
system 00:05: [io  0x0680-0x069f] has been reserved
system 00:05: [io  0x0800-0x080f] has been reserved
system 00:05: [io  0x0810-0x0813] has been reserved
system 00:05: [io  0xffff] has been reserved
system 00:05: [io  0x0400-0x047f] has been reserved
system 00:05: [io  0x0500-0x057f] has been reserved
system 00:05: [io  0x164e-0x164f] has been reserved
system 00:05: [io  0x2000] has been reserved
system 00:05: [io  0x2004] has been reserved
system 00:08: [mem 0xfed1c000-0xfed1ffff] has been reserved
system 00:08: [mem 0xfed10000-0xfed13fff] has been reserved
system 00:08: [mem 0xfed18000-0xfed18fff] has been reserved
system 00:08: [mem 0xfed19000-0xfed19fff] has been reserved
system 00:08: [mem 0xf0000000-0xf3ffffff] has been reserved
system 00:08: [mem 0xfed20000-0xfed3ffff] has been reserved
system 00:08: [mem 0xfed45000-0xfed8ffff] has been reserved
system 00:08: [mem 0xff000000-0xffffffff] could not be reserved
system 00:08: [mem 0xfee00000-0xfeefffff] could not be reserved
system 00:08: [mem 0xd7900000-0xd7900fff] has been reserved
pci 0000:01:00.0: no compatible bridge window for [mem 0xfff80000-0xffffffff pref]
PCI: max bus depth: 1 pci_try_num: 2
pci 0000:01:00.0: BAR 6: assigned [mem 0xd1080000-0xd10fffff pref]
pci 0000:00:01.0: PCI bridge to [bus 01-01]
pci 0000:00:01.0:   bridge window [io  0x6000-0x6fff]
pci 0000:00:01.0:   bridge window [mem 0xd0000000-0xd10fffff]
pci 0000:00:01.0:   bridge window [mem 0xa0000000-0xb1ffffff 64bit pref]
pci 0000:00:1c.0: PCI bridge to [bus 02-02]
pci 0000:00:1c.0:   bridge window [io  0x5000-0x5fff]
pci 0000:00:1c.0:   bridge window [mem 0xd6800000-0xd77fffff]
pci 0000:00:1c.0:   bridge window [mem 0xd1800000-0xd27fffff 64bit pref]
pci 0000:00:1c.1: PCI bridge to [bus 03-03]
pci 0000:00:1c.1:   bridge window [io  0x4000-0x4fff]
pci 0000:00:1c.1:   bridge window [mem 0xd5800000-0xd67fffff]
pci 0000:00:1c.1:   bridge window [mem 0xd2800000-0xd37fffff 64bit pref]
pci 0000:00:1c.2: PCI bridge to [bus 04-0b]
pci 0000:00:1c.2:   bridge window [io  0x3000-0x3fff]
pci 0000:00:1c.2:   bridge window [mem 0xd4800000-0xd57fffff]
pci 0000:00:1c.2:   bridge window [mem 0xd3800000-0xd47fffff 64bit pref]
pci 0000:00:1e.0: PCI bridge to [bus 0c-0c]
pci 0000:00:1e.0:   bridge window [io  disabled]
pci 0000:00:1e.0:   bridge window [mem disabled]
pci 0000:00:1e.0:   bridge window [mem pref disabled]
pci 0000:00:01.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
pci 0000:00:01.0: setting latency timer to 64
pci 0000:00:1c.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
pci 0000:00:1c.0: setting latency timer to 64
pci 0000:00:1c.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
pci 0000:00:1c.1: setting latency timer to 64
pci 0000:00:1c.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
pci 0000:00:1c.2: setting latency timer to 64
pci 0000:00:1e.0: setting latency timer to 64
pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
pci_bus 0000:00: resource 7 [mem 0xa0000000-0xfeafffff]
pci_bus 0000:01: resource 0 [io  0x6000-0x6fff]
pci_bus 0000:01: resource 1 [mem 0xd0000000-0xd10fffff]
pci_bus 0000:01: resource 2 [mem 0xa0000000-0xb1ffffff 64bit pref]
pci_bus 0000:02: resource 0 [io  0x5000-0x5fff]
pci_bus 0000:02: resource 1 [mem 0xd6800000-0xd77fffff]
pci_bus 0000:02: resource 2 [mem 0xd1800000-0xd27fffff 64bit pref]
pci_bus 0000:03: resource 0 [io  0x4000-0x4fff]
pci_bus 0000:03: resource 1 [mem 0xd5800000-0xd67fffff]
pci_bus 0000:03: resource 2 [mem 0xd2800000-0xd37fffff 64bit pref]
pci_bus 0000:04: resource 0 [io  0x3000-0x3fff]
pci_bus 0000:04: resource 1 [mem 0xd4800000-0xd57fffff]
pci_bus 0000:04: resource 2 [mem 0xd3800000-0xd47fffff 64bit pref]
pci_bus 0000:0c: resource 4 [io  0x0000-0x0cf7]
pci_bus 0000:0c: resource 5 [io  0x0d00-0xffff]
pci_bus 0000:0c: resource 6 [mem 0x000a0000-0x000bffff]
pci_bus 0000:0c: resource 7 [mem 0xa0000000-0xfeafffff]
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
TCP established hash table entries: 524288 (order: 11, 8388608 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 524288 bind 65536)
TCP reno registered
UDP hash table entries: 2048 (order: 4, 65536 bytes)
UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes)
NET: Registered protocol family 1
pci 0000:00:02.0: Boot video device
PCI: CLS 64 bytes, default 64
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
Placing 64MB software IO TLB between ffff88000199a000 - ffff88000599a000
software IO TLB at phys 0x199a000 - 0x599a000
Simple Boot Flag at 0x44 set to 0x1
Scanning for low memory corruption every 60 seconds
alg: skcipher: Failed to load transform for ecb-aes-aesni: -2
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
squashfs: version 4.0 (2009/01/31) Phillip Lougher
fuse init (API version 7.13)
msgmni has been set to 7279
alg: No test for stdrng (krng)
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
io scheduler noop registered
io scheduler cfq registered (default)
pcieport 0000:00:01.0: setting latency timer to 64
pcieport 0000:00:01.0: irq 24 for MSI/MSI-X
pcieport 0000:00:1c.0: setting latency timer to 64
pcieport 0000:00:1c.0: irq 25 for MSI/MSI-X
pcieport 0000:00:1c.1: setting latency timer to 64
pcieport 0000:00:1c.1: irq 26 for MSI/MSI-X
pcieport 0000:00:1c.2: setting latency timer to 64
pcieport 0000:00:1c.2: irq 27 for MSI/MSI-X
pcieport 0000:00:01.0: Requesting control of PCIe PME from ACPI BIOS
\_SB_.PCI0:_OSC invalid UUID
_OSC request data:1 0 1f 
pcieport 0000:00:01.0: Failed to receive control of PCIe PME service: ACPI _OSC failed
pcie_pme: probe of 0000:00:01.0:pcie01 failed with error -13
pcieport 0000:00:1c.0: Requesting control of PCIe PME from ACPI BIOS
\_SB_.PCI0:_OSC invalid UUID
_OSC request data:1 0 1f 
pcieport 0000:00:1c.0: Failed to receive control of PCIe PME service: ACPI _OSC failed
pcie_pme: probe of 0000:00:1c.0:pcie01 failed with error -13
pcieport 0000:00:1c.1: Requesting control of PCIe PME from ACPI BIOS
\_SB_.PCI0:_OSC invalid UUID
_OSC request data:1 0 1f 
pcieport 0000:00:1c.1: Failed to receive control of PCIe PME service: ACPI _OSC failed
pcie_pme: probe of 0000:00:1c.1:pcie01 failed with error -13
pcieport 0000:00:1c.2: Requesting control of PCIe PME from ACPI BIOS
\_SB_.PCI0:_OSC invalid UUID
_OSC request data:1 0 1f 
pcieport 0000:00:1c.2: Failed to receive control of PCIe PME service: ACPI _OSC failed
pcie_pme: probe of 0000:00:1c.2:pcie01 failed with error -13
Linux agpgart interface v0.103
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
loop: module loaded
ahci 0000:00:1f.2: version 3.0
ahci 0000:00:1f.2: PCI INT A -> GSI 22 (level, low) -> IRQ 22
ahci 0000:00:1f.2: irq 28 for MSI/MSI-X
ahci: SSS flag set, parallel bus scan disabled
ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 3 Gbps 0x1f impl RAID mode
ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo pio slum part apst 
ahci 0000:00:1f.2: setting latency timer to 64
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
scsi3 : ahci
scsi4 : ahci
scsi5 : ahci
ata1: SATA max UDMA/133 abar m2048@0xd7827000 port 0xd7827100 irq 28
ata2: SATA max UDMA/133 abar m2048@0xd7827000 port 0xd7827180 irq 28
ata3: SATA max UDMA/133 abar m2048@0xd7827000 port 0xd7827200 irq 28
ata4: SATA max UDMA/133 abar m2048@0xd7827000 port 0xd7827280 irq 28
ata5: SATA max UDMA/133 abar m2048@0xd7827000 port 0xd7827300 irq 28
ata6: DUMMY
e1000e: Intel(R) PRO/1000 Network Driver - 1.0.2-k2
e1000e: Copyright (c) 1999 - 2009 Intel Corporation.
e1000e 0000:00:19.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
e1000e 0000:00:19.0: setting latency timer to 64
e1000e 0000:00:19.0: irq 29 for MSI/MSI-X
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: ACPI cmd f5/00:00:00:00:00:00 (SECURITY FREEZE LOCK) filtered out
ata1.00: ATA-8: TOSHIBA MK3265GSX, GJ002H, max UDMA/100
ata1.00: 625142448 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
ata1.00: ACPI cmd f5/00:00:00:00:00:00 (SECURITY FREEZE LOCK) filtered out
ata1.00: configured for UDMA/100
scsi 0:0:0:0: Direct-Access     ATA      TOSHIBA MK3265GS GJ00 PQ: 0 ANSI: 5
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 0:0:0:0: [sda] 625142448 512-byte logical blocks: (320 GB/298 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
0000:00:19.0: eth0: (PCI Express:2.5GB/s:Width x1) 00:1d:ba:c0:9a:67
0000:00:19.0: eth0: Intel(R) PRO/1000 Network Connection
0000:00:19.0: eth0: MAC: 9, PHY: 10, PBA No: ffffff-0ff
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci_hcd 0000:00:1a.0: PCI INT A -> GSI 23 (level, low) -> IRQ 23
ehci_hcd 0000:00:1a.0: setting latency timer to 64
ehci_hcd 0000:00:1a.0: EHCI Host Controller
ehci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1a.0: debug port 2
ehci_hcd 0000:00:1a.0: cache line size of 64 is not supported
ehci_hcd 0000:00:1a.0: irq 23, io mem 0xd7827c00
 sda:
ehci_hcd 0000:00:1a.0: USB 2.0 started, EHCI 1.00
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ehci_hcd 0000:00:1d.0: PCI INT A -> GSI 20 (level, low) -> IRQ 20
ehci_hcd 0000:00:1d.0: setting latency timer to 64
ehci_hcd 0000:00:1d.0: EHCI Host Controller
ehci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
ehci_hcd 0000:00:1d.0: debug port 2
ehci_hcd 0000:00:1d.0: cache line size of 64 is not supported
ehci_hcd 0000:00:1d.0: irq 20, io mem 0xd7827800
ehci_hcd 0000:00:1d.0: USB 2.0 started, EHCI 1.00
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
device-mapper: ioctl: 4.17.0-ioctl (2010-03-05) initialised: dm-devel@redhat.com
cpuidle: using governor ladder
cpuidle: using governor menu
sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
sdhci-pci 0000:03:00.0: SDHCI controller found [1180:e822] (rev 0)
sdhci-pci 0000:03:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
sdhci-pci 0000:03:00.0: Will use DMA mode even though HW doesn't fully claim to support it.
sdhci-pci 0000:03:00.0: setting latency timer to 64
mmc0: SDHCI controller on PCI [0000:03:00.0] using DMA
sdhci-pci 0000:03:00.4: SDHCI controller found [1180:e822] (rev 0)
sdhci-pci 0000:03:00.4: PCI INT C -> GSI 19 (level, low) -> IRQ 19
sdhci-pci 0000:03:00.4: Will use DMA mode even though HW doesn't fully claim to support it.
sdhci-pci 0000:03:00.4: setting latency timer to 64
mmc1: SDHCI controller on PCI [0000:03:00.4] using DMA
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
TCP cubic registered
NET: Registered protocol family 17
SCTP: Hash tables configured (established 65536 bind 65536)
input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
 sda1 sda2 sda3 sda4
sd 0:0:0:0: [sda] Attached SCSI disk
mmc1: new SD card at address 9ff0
mmcblk0: mmc1:9ff0 SD02G 1.89 GiB (ro)
 mmcblk0: p1
ata2: SATA link down (SStatus 0 SControl 300)
usb 1-1: new high speed USB device using ehci_hcd and address 2
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 6 ports detected
usb 2-1: new high speed USB device using ehci_hcd and address 2
ata3: SATA link down (SStatus 0 SControl 300)
hub 2-1:1.0: USB hub found
hub 2-1:1.0: 8 ports detected
usb 1-1.2: new high speed USB device using ehci_hcd and address 3
usb 1-1.3: new high speed USB device using ehci_hcd and address 4
ata4: SATA link down (SStatus 0 SControl 300)
usb 1-1.3: config 1 has an invalid interface number: 1 but max is 0
usb 1-1.3: config 1 has no interface number 0
usb 1-1.6: new full speed USB device using ehci_hcd and address 5
hub 1-1:1.0: unable to enumerate USB device on port 6
ata5: SATA link down (SStatus 0 SControl 300)
EXT3-fs (sda2): error: couldn't mount because of unsupported optional features (240)
EXT2-fs (sda2): error: couldn't mount because of unsupported optional features (240)
EXT4-fs (sda2): mounted filesystem with ordered data mode
VFS: Mounted root (ext4 filesystem) readonly on device 8:2.
Freeing unused kernel memory: 544k freed
rtc_cmos 00:06: RTC can wake from S4
rtc_cmos 00:06: rtc core: registered rtc_cmos as rtc0
rtc0: alarms up to one year, y3k, 242 bytes nvram, hpet irqs
udev: starting version 151
Monitor-Mwait will be used to enter C-1 state
Monitor-Mwait will be used to enter C-2 state
Monitor-Mwait will be used to enter C-3 state
thermal LNXTHERM:01: registered as thermal_zone0
ACPI: Thermal Zone [DTS0] (57 C)
input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input1
ACPI: Lid Switch [LID0]
input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input2
ACPI: Power Button [PWRB]
input: PC Speaker as /devices/platform/pcspkr/input/input3
ACPI: AC Adapter [ADP1] (on-line)
i801_smbus 0000:00:1f.3: PCI INT B -> GSI 22 (level, low) -> IRQ 22
ACPI: I/O resource 0000:00:1f.3 [0x7000-0x701f] conflicts with ACPI region SMBI [0x7000-0x700f]
ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
ACPI: Battery Slot [BAT1] (battery present)
sony-laptop: Sony Notebook Control Driver v0.6.
input: Sony Vaio Keys as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:0a/SNY5001:00/input/input4
input: Sony Vaio Jogdial as /devices/virtual/input/input5
sony-laptop: brightness ignored, must be controlled by ACPI video driver
cfg80211: Calling CRDA to update world regulatory domain
agpgart-intel 0000:00:00.0: Intel HD Graphics Chipset
agpgart-intel 0000:00:00.0: detected 131068K stolen memory
agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0xc0000000
iwlagn: Intel(R) Wireless WiFi Link AGN driver for Linux, in-tree:
iwlagn: Copyright(c) 2003-2010 Intel Corporation
iwlagn 0000:02:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
iwlagn 0000:02:00.0: setting latency timer to 64
iwlagn 0000:02:00.0: Detected Intel Wireless WiFi Link 6000 Series 2x2 AGN REV=0x74
iwlagn 0000:02:00.0: Tunable channels: 13 802.11bg, 24 802.11a channels
iwlagn 0000:02:00.0: irq 30 for MSI/MSI-X
iwlagn 0000:02:00.0: firmware: requesting iwlwifi-6000-4.ucode
HDA Intel 0000:00:1b.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
HDA Intel 0000:00:1b.0: irq 31 for MSI/MSI-X
HDA Intel 0000:00:1b.0: setting latency timer to 64
iwlagn 0000:02:00.0: loaded firmware version 9.176.4.1
phy0: Selected rate control algorithm 'iwl-agn-rs'
hda_codec: ALC889: BIOS auto-probing.
input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/input/input6
HDA Intel 0000:01:00.1: PCI INT A -> GSI 16 (level, low) -> IRQ 16
hda_intel: Disable MSI for Nvidia chipset
HDA Intel 0000:01:00.1: setting latency timer to 64
iwlagn 0000:02:00.0: RF_KILL bit toggled to enable radio.
usb 1-1.6: new full speed USB device using ehci_hcd and address 6
EXT4-fs (sda3): mounted filesystem with ordered data mode
