From: "Jory A. Pratt" <geekypenguin@gmail.com>
Subject: Re: [PATCH] Asus G1S noloop exception V2
Date: Wed, 29 Jul 2009 22:17:33 -0500
Message-ID: <4A7110CD.9090405@gmail.com>
References: <20090730031946.C7F1F526EC9@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030009020307040002000100"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f188.google.com ([209.85.210.188]:41356 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753862AbZG3DWv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jul 2009 23:22:51 -0400
Received: by yxe26 with SMTP id 26so2133218yxe.4
        for <linux-input@vger.kernel.org>; Wed, 29 Jul 2009 20:22:51 -0700 (PDT)
In-Reply-To: <20090730031946.C7F1F526EC9@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>

This is a multi-part message in MIME format.
--------------030009020307040002000100
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

As requested here is the dmesg of a failed connection between kernel and 
synaptics touchpad. Minute I added i8042.noloop=1 back to boot options 
so I can have my mouse back everything works as expected.


On 07/29/09 21:45, Dmitry Torokhov wrote:
> Hi Jory,
>
> On Tue, Jul 28, 2009 at 10:11:46PM -0500, Jory A. Pratt wrote:
>> After further testing I realized there was a mistake in the patch. The
>> DMI_BOARD_VENDOR should have been
>> ASUSTeK Computer Inc. instead of ASUSTeK Computer INC. Patch has been
>> fully tested with 20+ reboots and cold
>> boots to ensure it is working properly.
>>
>
> Since you are saying that AUX loop detection usually works on your
> laptop simply disabling it is not the best solution. Could you please
> provide me with dmesg of booting with i8042.debug=1 when touchpad
> is not detected?
>

--------------030009020307040002000100
Content-Type: text/plain;
 name="dmesg-i8042.debug=1.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg-i8042.debug=1.txt"

Linux version 2.6.30-gentoo-r4 (root@pepsi) (gcc version 4.4.1 (Gentoo 4.4.1 p1.0) ) #1 SMP Wed Jul 29 22:03:25 CDT 2009
Command line: root=/dev/sda3 vga=0x369 i8042.debug=1
KERNEL supported cpus:
  Intel GenuineIntel
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000bffb0000 (usable)
 BIOS-e820: 00000000bffb0000 - 00000000bffbe000 (ACPI data)
 BIOS-e820: 00000000bffbe000 - 00000000bfff0000 (ACPI NVS)
 BIOS-e820: 00000000bfff0000 - 00000000c0000000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000140000000 (usable)
DMI 2.4 present.
AMI BIOS detected: BIOS may corrupt low RAM, working around it.
e820 update range: 0000000000000000 - 0000000000010000 (usable) ==> (reserved)
last_pfn = 0x140000 max_arch_pfn = 0x100000000
MTRR default type: uncachable
MTRR fixed ranges enabled:
  00000-9FFFF write-back
  A0000-BFFFF uncachable
  C0000-CFFFF write-protect
  D0000-DFFFF uncachable
  E0000-EFFFF write-through
  F0000-FFFFF write-protect
MTRR variable ranges enabled:
  0 base 0C0000000 mask FC0000000 uncachable
  1 base 000000000 mask F00000000 write-back
  2 base 100000000 mask FC0000000 write-back
  3 disabled
  4 disabled
  5 disabled
  6 disabled
  7 disabled
x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
e820 update range: 00000000c0000000 - 0000000100000000 (usable) ==> (reserved)
last_pfn = 0xbffb0 max_arch_pfn = 0x100000000
Scanning 0 areas for low memory corruption
modified physical RAM map:
 modified: 0000000000000000 - 0000000000010000 (reserved)
 modified: 0000000000010000 - 000000000009fc00 (usable)
 modified: 000000000009fc00 - 00000000000a0000 (reserved)
 modified: 00000000000e4000 - 0000000000100000 (reserved)
 modified: 0000000000100000 - 00000000bffb0000 (usable)
 modified: 00000000bffb0000 - 00000000bffbe000 (ACPI data)
 modified: 00000000bffbe000 - 00000000bfff0000 (ACPI NVS)
 modified: 00000000bfff0000 - 00000000c0000000 (reserved)
 modified: 00000000fee00000 - 00000000fee01000 (reserved)
 modified: 00000000ffb00000 - 0000000100000000 (reserved)
 modified: 0000000100000000 - 0000000140000000 (usable)
init_memory_mapping: 0000000000000000-00000000bffb0000
 0000000000 - 00bfe00000 page 2M
 00bfe00000 - 00bffb0000 page 4k
kernel direct mapping tables up to bffb0000 @ 10000-15000
init_memory_mapping: 0000000100000000-0000000140000000
 0100000000 - 0140000000 page 2M
kernel direct mapping tables up to 140000000 @ 13000-19000
ACPI: RSDP 00000000000f81d0 00024 (v02 ACPIAM)
ACPI: XSDT 00000000bffb0100 0007C (v01 _ASUS_ Notebook 12000725 MSFT 00000097)
ACPI: FACP 00000000bffb0290 000F4 (v03 A_M_I_ OEMFACP  12000725 MSFT 00000097)
ACPI: DSDT 00000000bffb0680 0ADF0 (v01  G1S00 G1S00000 00000000 INTL 20061109)
ACPI: FACS 00000000bffbe000 00040
ACPI: APIC 00000000bffb0390 0005C (v01 A_M_I_ OEMAPIC  12000725 MSFT 00000097)
ACPI: MCFG 00000000bffb0430 0003C (v01 A_M_I_ OEMMCFG  12000725 MSFT 00000097)
ACPI: SLIC 00000000bffb0470 00176 (v01 _ASUS_ Notebook 12000725 MSFT 00000097)
ACPI: DBGP 00000000bffb03f0 00034 (v01 A_M_I_ OEMDBGP  12000725 MSFT 00000097)
ACPI: BOOT 00000000bffb05f0 00028 (v01 A_M_I_ OEMBOOT  12000725 MSFT 00000097)
ACPI: ECDT 00000000bffb0620 00054 (v01 A_M_I_ OEMECDT  12000725 MSFT 00000097)
ACPI: OEMB 00000000bffbe040 00060 (v01 A_M_I_ AMI_OEM  12000725 MSFT 00000097)
ACPI: HPET 00000000bffbb490 00038 (v01 A_M_I_ OEMHPET  12000725 MSFT 00000097)
ACPI: ATKG 00000000bffbe2a0 08024 (v01 A_M_I_  OEMATKG 05000702 MSFT 00000097)
ACPI: SSDT 00000000bffc6de0 004E6 (v01  PmRef    CpuPm 00003000 INTL 20051117)
ACPI: Local APIC address 0xfee00000
(7 early reservations) ==> bootmem [0000000000 - 0140000000]
  #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 - 0000001000]
  #1 [0000006000 - 0000008000]       TRAMPOLINE ==> [0000006000 - 0000008000]
  #2 [0001000000 - 0001830cd8]    TEXT DATA BSS ==> [0001000000 - 0001830cd8]
  #3 [000009fc00 - 0000100000]    BIOS reserved ==> [000009fc00 - 0000100000]
  #4 [0001831000 - 0001831240]              BRK ==> [0001831000 - 0001831240]
  #5 [0000010000 - 0000013000]          PGTABLE ==> [0000010000 - 0000013000]
  #6 [0000013000 - 0000014000]          PGTABLE ==> [0000013000 - 0000014000]
 [ffffe20000000000-ffffe200045fffff] PMD -> [ffff880028200000-ffff88002c7fffff] on node 0
Zone PFN ranges:
  DMA      0x00000010 -> 0x00001000
  DMA32    0x00001000 -> 0x00100000
  Normal   0x00100000 -> 0x00140000
Movable zone start PFN for each node
early_node_map[3] active PFN ranges
    0: 0x00000010 -> 0x0000009f
    0: 0x00000100 -> 0x000bffb0
    0: 0x00100000 -> 0x00140000
On node 0 totalpages: 1048383
  DMA zone: 56 pages used for memmap
  DMA zone: 103 pages reserved
  DMA zone: 3824 pages, LIFO batch:0
  DMA32 zone: 14280 pages used for memmap
  DMA32 zone: 767976 pages, LIFO batch:31
  Normal zone: 3584 pages used for memmap
  Normal zone: 258560 pages, LIFO batch:31
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 0, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Using ACPI (MADT) for SMP configuration information
ACPI: HPET id: 0x8086a201 base: 0xfed00000
SMP: Allowing 2 CPUs, 0 hotplug CPUs
nr_irqs_gsi: 24
PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
PM: Registered nosave memory: 00000000000a0000 - 00000000000e4000
PM: Registered nosave memory: 00000000000e4000 - 0000000000100000
PM: Registered nosave memory: 00000000bffb0000 - 00000000bffbe000
PM: Registered nosave memory: 00000000bffbe000 - 00000000bfff0000
PM: Registered nosave memory: 00000000bfff0000 - 00000000c0000000
PM: Registered nosave memory: 00000000c0000000 - 00000000fee00000
PM: Registered nosave memory: 00000000fee00000 - 00000000fee01000
PM: Registered nosave memory: 00000000fee01000 - 00000000ffb00000
PM: Registered nosave memory: 00000000ffb00000 - 0000000100000000
Allocating PCI resources starting at c4000000 (gap: c0000000:3ee00000)
NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:2 nr_node_ids:1
PERCPU: Embedded 25 pages at ffff880028022000, static data 71840 bytes
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 1030360
Kernel command line: root=/dev/sda3 vga=0x369 i8042.debug=1
Initializing CPU#0
Experimental hierarchical RCU implementation.
Experimental hierarchical RCU init done.
NR_IRQS:2304
PID hash table entries: 4096 (order: 12, 32768 bytes)
Extended CMOS year: 2000
Fast TSC calibration using PIT
Detected 2194.656 MHz processor.
Console: colour dummy device 80x25
console [tty0] enabled
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Checking aperture...
No AGP bridge found
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
Placing 64MB software IO TLB between ffff880020000000 - ffff880024000000
software IO TLB at phys 0x20000000 - 0x24000000
Memory: 4039964k/5242880k available (4636k kernel code, 1049348k absent, 152588k reserved, 1861k data, 360k init)
SLUB: Genslabs=13, HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
hpet clockevent registered
HPET: 3 timers in total, 0 timers will be used for per-cpu timer
Calibrating delay loop (skipped), value calculated using timer frequency.. 4389.31 BogoMIPS (lpj=2194656)
Mount-cache hash table entries: 256
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU0: Thermal monitoring handled by SMI
using mwait in idle threads.
ACPI: Core revision 20090320
Setting APIC routing to flat
..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
CPU0: Intel(R) Core(TM)2 Duo CPU     T7500  @ 2.20GHz stepping 0b
Booting processor 1 APIC 0x1 ip 0x6000
Initializing CPU#1
Calibrating delay using timer specific routine.. 4388.78 BogoMIPS (lpj=2194390)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU1: Thermal monitoring enabled (TM2)
x86 PAT enabled: cpu 1, old 0x7040600070406, new 0x7010600070106
CPU1: Intel(R) Core(TM)2 Duo CPU     T7500  @ 2.20GHz stepping 0b
checking TSC synchronization [CPU#0 -> CPU#1]: passed.
Brought up 2 CPUs
Total of 2 processors activated (8778.09 BogoMIPS).
net_namespace: 560 bytes
NET: Registered protocol family 16
ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
ACPI: bus type pci registered
PCI: MCFG configuration 0: base c0000000 segment 0 buses 0 - 255
PCI: Not using MMCONFIG.
PCI: Using configuration type 1 for base access
bio: create slab <bio-0> at 0
ACPI: EC: EC description table is found, configuring boot EC
ACPI: EC: Look up EC in DSDT
ACPI: Interpreter enabled
ACPI: (supports S0 S1 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
PCI: MCFG configuration 0: base c0000000 segment 0 buses 0 - 255
PCI: MCFG area at c0000000 reserved in ACPI motherboard resources
PCI: Using MMCONFIG at c0000000 - cfffffff
ACPI: EC: GPE = 0x1c, I/O: command/status = 0x66, data = 0x62
ACPI: EC: driver started in poll mode
ACPI Warning (tbutils-0246): Incorrect checksum in table [ATKG] - 2A, should be 59 [20090320]
ACPI: No dock devices found.
ACPI: PCI Root Bridge [PCI0] (0000:00)
pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
pci 0000:00:01.0: PME# disabled
pci 0000:00:1a.0: reg 20 io port: [0xe080-0xe09f]
pci 0000:00:1a.1: reg 20 io port: [0xe000-0xe01f]
pci 0000:00:1a.7: reg 10 32bit mmio: [0xfebff400-0xfebff7ff]
pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
pci 0000:00:1a.7: PME# disabled
pci 0000:00:1b.0: reg 10 64bit mmio: [0xfebf8000-0xfebfbfff]
pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1b.0: PME# disabled
pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.0: PME# disabled
pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.1: PME# disabled
pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.2: PME# disabled
pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.3: PME# disabled
pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.4: PME# disabled
pci 0000:00:1d.0: reg 20 io port: [0xdc00-0xdc1f]
pci 0000:00:1d.1: reg 20 io port: [0xd880-0xd89f]
pci 0000:00:1d.2: reg 20 io port: [0xd800-0xd81f]
pci 0000:00:1d.7: reg 10 32bit mmio: [0xfebff000-0xfebff3ff]
pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
pci 0000:00:1d.7: PME# disabled
pci 0000:00:1f.0: quirk: region 0800-087f claimed by ICH6 ACPI/GPIO/TCO
pci 0000:00:1f.0: quirk: region 0500-053f claimed by ICH6 GPIO
pci 0000:00:1f.0: ICH7 LPC Generic IO decode 3 PIO at 0250 (mask 000f)
pci 0000:00:1f.1: reg 10 io port: [0x00-0x07]
pci 0000:00:1f.1: reg 14 io port: [0x00-0x03]
pci 0000:00:1f.1: reg 18 io port: [0x8f0-0x8f7]
pci 0000:00:1f.1: reg 1c io port: [0x8f8-0x8fb]
pci 0000:00:1f.1: reg 20 io port: [0xffa0-0xffaf]
pci 0000:00:1f.2: reg 10 io port: [0xec00-0xec07]
pci 0000:00:1f.2: reg 14 io port: [0xe880-0xe883]
pci 0000:00:1f.2: reg 18 io port: [0xe800-0xe807]
pci 0000:00:1f.2: reg 1c io port: [0xe480-0xe483]
pci 0000:00:1f.2: reg 20 io port: [0xe400-0xe41f]
pci 0000:00:1f.2: reg 24 32bit mmio: [0xfebff800-0xfebfffff]
pci 0000:00:1f.2: PME# supported from D3hot
pci 0000:00:1f.2: PME# disabled
pci 0000:01:00.0: reg 10 32bit mmio: [0xfc000000-0xfcffffff]
pci 0000:01:00.0: reg 14 64bit mmio: [0xe0000000-0xefffffff]
pci 0000:01:00.0: reg 1c 64bit mmio: [0xfa000000-0xfbffffff]
pci 0000:01:00.0: reg 24 io port: [0x9c00-0x9c7f]
pci 0000:01:00.0: reg 30 32bit mmio: [0xfdee0000-0xfdefffff]
pci 0000:00:01.0: bridge io port: [0x9000-0x9fff]
pci 0000:00:01.0: bridge 32bit mmio: [0xf7e00000-0xfdefffff]
pci 0000:00:01.0: bridge 64bit mmio pref: [0xd5d00000-0xf5cfffff]
pci 0000:02:00.0: reg 10 io port: [0xa800-0xa8ff]
pci 0000:02:00.0: reg 18 64bit mmio: [0xfdfff000-0xfdffffff]
pci 0000:02:00.0: reg 30 32bit mmio: [0xfdfc0000-0xfdfdffff]
pci 0000:02:00.0: supports D1 D2
pci 0000:02:00.0: PME# supported from D1 D2 D3hot D3cold
pci 0000:02:00.0: PME# disabled
pci 0000:00:1c.0: bridge io port: [0xa000-0xafff]
pci 0000:00:1c.0: bridge 32bit mmio: [0xfdf00000-0xfdffffff]
pci 0000:03:00.0: reg 10 64bit mmio: [0xfe0fe000-0xfe0fffff]
pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
pci 0000:03:00.0: PME# disabled
pci 0000:00:1c.1: bridge 32bit mmio: [0xfe000000-0xfe0fffff]
pci 0000:00:1c.2: bridge io port: [0xb000-0xbfff]
pci 0000:00:1c.2: bridge 32bit mmio: [0xfe100000-0xfe8fffff]
pci 0000:00:1c.2: bridge 64bit mmio pref: [0xf5d00000-0xf7cfffff]
pci 0000:07:00.0: reg 10 io port: [0xcc00-0xcc07]
pci 0000:07:00.0: reg 14 io port: [0xc880-0xc883]
pci 0000:07:00.0: reg 18 io port: [0xc800-0xc807]
pci 0000:07:00.0: reg 1c io port: [0xc480-0xc483]
pci 0000:07:00.0: reg 20 io port: [0xc400-0xc40f]
pci 0000:07:00.0: reg 24 32bit mmio: [0xfe9fe000-0xfe9fffff]
pci 0000:07:00.0: PME# supported from D3hot
pci 0000:07:00.0: PME# disabled
pci 0000:00:1c.4: bridge io port: [0xc000-0xcfff]
pci 0000:00:1c.4: bridge 32bit mmio: [0xfe900000-0xfe9fffff]
pci 0000:08:01.0: reg 10 32bit mmio: [0xfeaff800-0xfeafffff]
pci 0000:08:01.0: PME# supported from D0 D3hot D3cold
pci 0000:08:01.0: PME# disabled
pci 0000:08:01.1: reg 10 32bit mmio: [0xfeaff400-0xfeaff4ff]
pci 0000:08:01.1: supports D1 D2
pci 0000:08:01.1: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:08:01.1: PME# disabled
pci 0000:08:01.2: reg 10 32bit mmio: [0xfeaff000-0xfeaff0ff]
pci 0000:08:01.2: supports D1 D2
pci 0000:08:01.2: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:08:01.2: PME# disabled
pci 0000:08:01.3: reg 10 32bit mmio: [0xfeafec00-0xfeafecff]
pci 0000:08:01.3: supports D1 D2
pci 0000:08:01.3: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:08:01.3: PME# disabled
pci 0000:00:1e.0: transparent bridge
pci 0000:00:1e.0: bridge 32bit mmio: [0xfea00000-0xfeafffff]
pci_bus 0000:00: on NUMA node 0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P3._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P5._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P6._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P9._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 10 12)
ACPI: PCI Interrupt Link [LNKC] (IRQs *3)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 *7 10 12)
ACPI: PCI Interrupt Link [LNKE] (IRQs *6)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 *4 5 6 7 10 12)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 *10 12)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 6 7 10 12)
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
ACPI: WMI: Mapper loaded
PCI: Using ACPI for IRQ routing
Bluetooth: Core ver 2.15
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
cfg80211: Calling CRDA to update world regulatory domain
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
hpet0: 3 comparators, 64-bit 14.318180 MHz counter
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 13 devices
ACPI: ACPI bus type pnp unregistered
system 00:01: iomem range 0xfed14000-0xfed19fff has been reserved
system 00:08: ioport range 0x4d0-0x4d1 has been reserved
system 00:08: ioport range 0x800-0x87f has been reserved
system 00:08: ioport range 0x400-0x41f has been reserved
system 00:08: ioport range 0x500-0x53f has been reserved
system 00:08: iomem range 0xfed1c000-0xfed1ffff has been reserved
system 00:08: iomem range 0xfed20000-0xfed3ffff has been reserved
system 00:08: iomem range 0xfed45000-0xfed89fff has been reserved
system 00:08: iomem range 0xffb00000-0xffbfffff has been reserved
system 00:08: iomem range 0xfff00000-0xffffffff has been reserved
system 00:0a: ioport range 0x250-0x253 has been reserved
system 00:0a: ioport range 0x256-0x25f has been reserved
system 00:0a: iomem range 0xfec00000-0xfec00fff has been reserved
system 00:0a: iomem range 0xfee00000-0xfee00fff has been reserved
system 00:0b: iomem range 0xc0000000-0xcfffffff has been reserved
system 00:0c: iomem range 0x0-0x9ffff could not be reserved
system 00:0c: iomem range 0xc0000-0xcffff has been reserved
system 00:0c: iomem range 0xe0000-0xfffff could not be reserved
system 00:0c: iomem range 0x100000-0xbfffffff could not be reserved
pci 0000:00:01.0: PCI bridge, secondary bus 0000:01
pci 0000:00:01.0:   IO window: 0x9000-0x9fff
pci 0000:00:01.0:   MEM window: 0xf7e00000-0xfdefffff
pci 0000:00:01.0:   PREFETCH window: 0x000000d5d00000-0x000000f5cfffff
pci 0000:00:1c.0: PCI bridge, secondary bus 0000:02
pci 0000:00:1c.0:   IO window: 0xa000-0xafff
pci 0000:00:1c.0:   MEM window: 0xfdf00000-0xfdffffff
pci 0000:00:1c.0:   PREFETCH window: disabled
pci 0000:00:1c.1: PCI bridge, secondary bus 0000:03
pci 0000:00:1c.1:   IO window: disabled
pci 0000:00:1c.1:   MEM window: 0xfe000000-0xfe0fffff
pci 0000:00:1c.1:   PREFETCH window: disabled
pci 0000:00:1c.2: PCI bridge, secondary bus 0000:04
pci 0000:00:1c.2:   IO window: 0xb000-0xbfff
pci 0000:00:1c.2:   MEM window: 0xfe100000-0xfe8fffff
pci 0000:00:1c.2:   PREFETCH window: 0x000000f5d00000-0x000000f7cfffff
pci 0000:00:1c.3: PCI bridge, secondary bus 0000:06
pci 0000:00:1c.3:   IO window: disabled
pci 0000:00:1c.3:   MEM window: disabled
pci 0000:00:1c.3:   PREFETCH window: disabled
pci 0000:00:1c.4: PCI bridge, secondary bus 0000:07
pci 0000:00:1c.4:   IO window: 0xc000-0xcfff
pci 0000:00:1c.4:   MEM window: 0xfe900000-0xfe9fffff
pci 0000:00:1c.4:   PREFETCH window: disabled
pci 0000:00:1e.0: PCI bridge, secondary bus 0000:08
pci 0000:00:1e.0:   IO window: disabled
pci 0000:00:1e.0:   MEM window: 0xfea00000-0xfeafffff
pci 0000:00:1e.0:   PREFETCH window: disabled
pci 0000:00:01.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
pci 0000:00:01.0: setting latency timer to 64
pci 0000:00:1c.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
pci 0000:00:1c.0: setting latency timer to 64
pci 0000:00:1c.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
pci 0000:00:1c.1: setting latency timer to 64
pci 0000:00:1c.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
pci 0000:00:1c.2: setting latency timer to 64
pci 0000:00:1c.3: PCI INT D -> GSI 19 (level, low) -> IRQ 19
pci 0000:00:1c.3: setting latency timer to 64
pci 0000:00:1c.4: PCI INT A -> GSI 16 (level, low) -> IRQ 16
pci 0000:00:1c.4: setting latency timer to 64
pci 0000:00:1e.0: setting latency timer to 64
pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
pci_bus 0000:00: resource 1 mem: [0x000000-0xffffffffffffffff]
pci_bus 0000:01: resource 0 io:  [0x9000-0x9fff]
pci_bus 0000:01: resource 1 mem: [0xf7e00000-0xfdefffff]
pci_bus 0000:01: resource 2 pref mem [0xd5d00000-0xf5cfffff]
pci_bus 0000:02: resource 0 io:  [0xa000-0xafff]
pci_bus 0000:02: resource 1 mem: [0xfdf00000-0xfdffffff]
pci_bus 0000:03: resource 1 mem: [0xfe000000-0xfe0fffff]
pci_bus 0000:04: resource 0 io:  [0xb000-0xbfff]
pci_bus 0000:04: resource 1 mem: [0xfe100000-0xfe8fffff]
pci_bus 0000:04: resource 2 pref mem [0xf5d00000-0xf7cfffff]
pci_bus 0000:07: resource 0 io:  [0xc000-0xcfff]
pci_bus 0000:07: resource 1 mem: [0xfe900000-0xfe9fffff]
pci_bus 0000:08: resource 1 mem: [0xfea00000-0xfeafffff]
pci_bus 0000:08: resource 3 io:  [0x00-0xffff]
pci_bus 0000:08: resource 4 mem: [0x000000-0xffffffffffffffff]
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
NET: Registered protocol family 1
Simple Boot Flag at 0x52 set to 0x1
Microcode Update Driver: v2.00 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
Scanning for low memory corruption every 60 seconds
audit: initializing netlink socket (disabled)
type=2000 audit(1248905526.323:1): initialized
SGI XFS with security attributes, large block/inode numbers, no debug enabled
msgmni has been set to 7892
alg: No test for stdrng (krng)
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
pci 0000:01:00.0: Boot video device
pcieport-driver 0000:00:01.0: irq 24 for MSI/MSI-X
pcieport-driver 0000:00:01.0: setting latency timer to 64
pcieport-driver 0000:00:1c.0: irq 25 for MSI/MSI-X
pcieport-driver 0000:00:1c.0: setting latency timer to 64
pcieport-driver 0000:00:1c.1: irq 26 for MSI/MSI-X
pcieport-driver 0000:00:1c.1: setting latency timer to 64
pcieport-driver 0000:00:1c.2: irq 27 for MSI/MSI-X
pcieport-driver 0000:00:1c.2: setting latency timer to 64
pcieport-driver 0000:00:1c.3: irq 28 for MSI/MSI-X
pcieport-driver 0000:00:1c.3: setting latency timer to 64
pcieport-driver 0000:00:1c.4: irq 29 for MSI/MSI-X
pcieport-driver 0000:00:1c.4: setting latency timer to 64
Non-volatile memory driver v1.3
Linux agpgart interface v0.103
vesafb: framebuffer at 0xfb000000, mapped to 0xffffc20010100000, using 13781k, total 14336k
vesafb: mode is 1680x1050x32, linelength=6720, pages=1
vesafb: scrolling: redraw
vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0
Switched to high resolution mode on CPU 1
Switched to high resolution mode on CPU 0
Console: switching to colour frame buffer device 210x65
fb0: VESA VGA frame buffer device
ACPI: AC Adapter [AC0] (on-line)
input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
ACPI: Power Button [PWRF]
input: Sleep Button as /devices/LNXSYSTM:00/device:00/PNP0C0E:00/input/input1
ACPI: Sleep Button [SLPB]
input: Lid Switch as /devices/LNXSYSTM:00/device:00/PNP0C0D:00/input/input2
ACPI: EC: non-query interrupt received, switching to interrupt mode
ACPI: Lid Switch [LID]
acpi device:07: registered as cooling_device0
input: Video Bus as /devices/LNXSYSTM:00/device:00/PNP0A08:00/device:02/device:03/input/input3
ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
ACPI: SSDT 00000000bffc63a0 00286 (v01  PmRef  Cpu0Ist 00003000 INTL 20051117)
ACPI: SSDT 00000000bffc66c0 00712 (v01  PmRef  Cpu0Cst 00003001 INTL 20051117)
Monitor-Mwait will be used to enter C-1 state
Monitor-Mwait will be used to enter C-2 state
Marking TSC unstable due to TSC halts in idle
ACPI: CPU0 (power states: C1[C1] C2[C2])
processor ACPI_CPU:00: registered as cooling_device1
ACPI: Processor [P001] (supports 8 throttling states)
ACPI: SSDT 00000000bffc62d0 000C8 (v01  PmRef  Cpu1Ist 00003000 INTL 20051117)
ACPI: SSDT 00000000bffc6630 00085 (v01  PmRef  Cpu1Cst 00003000 INTL 20051117)
ACPI: CPU1 (power states: C1[C1] C2[C2])
processor ACPI_CPU:01: registered as cooling_device2
ACPI: Processor [P002] (supports 8 throttling states)
thermal LNXTHERM:01: registered as thermal_zone0
ACPI: Thermal Zone [THRM] (76 C)
ACPI: Battery Slot [BAT0] (battery present)
floppy0: no floppy controllers found
loop: module loaded
Uniform Multi-Platform E-IDE driver
piix 0000:00:1f.1: IDE controller (0x8086:0x2850 rev 0x03)
PIIX_IDE 0000:00:1f.1: PCI INT A -> GSI 18 (level, low) -> IRQ 18
piix 0000:00:1f.1: IDE port disabled
piix 0000:00:1f.1: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7
Probing IDE interface ide0...
hda: HL-DT-ST DVDRAM GSA-T20L, ATAPI CD/DVD-ROM drive
hda: host max PIO4 wanted PIO255(auto-tune) selected PIO4
hda: UDMA/33 mode selected
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide-cd driver 5.00
ide-cd: hda: ATAPI 24X DVD-ROM DVD-R/RAM CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
Driver 'sd' needs updating - please use bus_type methods
Driver 'sr' needs updating - please use bus_type methods
ahci 0000:00:1f.2: version 3.0
ahci 0000:00:1f.2: PCI INT B -> GSI 20 (level, low) -> IRQ 20
ahci 0000:00:1f.2: irq 30 for MSI/MSI-X
ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 3 ports 3 Gbps 0x7 impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq sntf pm led clo pio slum part ems 
ahci 0000:00:1f.2: setting latency timer to 64
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
ata1: SATA max UDMA/133 abar m2048@0xfebff800 port 0xfebff900 irq 30
ata2: SATA max UDMA/133 abar m2048@0xfebff800 port 0xfebff980 irq 30
ata3: SATA max UDMA/133 abar m2048@0xfebff800 port 0xfebffa00 irq 30
ahci 0000:07:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
ahci 0000:07:00.0: AHCI 0001.0000 32 slots 1 ports 3 Gbps 0x1 impl SATA mode
ahci 0000:07:00.0: flags: 64bit ncq pm led clo pmp pio slum part 
ahci 0000:07:00.0: setting latency timer to 64
scsi3 : ahci
ata4: SATA max UDMA/133 abar m8192@0xfe9fe000 port 0xfe9fe100 irq 16
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
r8169 0000:02:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
r8169 0000:02:00.0: setting latency timer to 64
r8169 0000:02:00.0: irq 31 for MSI/MSI-X
eth0: RTL8168b/8111b at 0xffffc2000004e000, 00:1d:60:6b:6a:5e, XID 38000000 IRQ 31
iwlagn: Intel(R) Wireless WiFi Link AGN driver for Linux, 1.3.27k
iwlagn: Copyright(c) 2003-2009 Intel Corporation
iwlagn 0000:03:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
iwlagn 0000:03:00.0: setting latency timer to 64
iwlagn 0000:03:00.0: Detected Intel Wireless WiFi Link 4965AGN REV=0x4
ata2: SATA link down (SStatus 0 SControl 300)
ata3: SATA link down (SStatus 0 SControl 300)
iwlagn 0000:03:00.0: Tunable channels: 11 802.11bg, 13 802.11a channels
iwlagn 0000:03:00.0: irq 32 for MSI/MSI-X
phy0: Selected rate control algorithm 'iwl-agn-rs'
firewire_ohci 0000:08:01.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
firewire_ohci: Added fw-ohci device 0000:08:01.0, OHCI version 1.0
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci_hcd 0000:00:1a.7: PCI INT C -> GSI 18 (level, low) -> IRQ 18
ehci_hcd 0000:00:1a.7: setting latency timer to 64
ehci_hcd 0000:00:1a.7: EHCI Host Controller
ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1a.7: debug port 1
ehci_hcd 0000:00:1a.7: cache line size of 32 is not supported
ehci_hcd 0000:00:1a.7: irq 18, io mem 0xfebff400
ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.30-gentoo-r4 ehci_hcd
usb usb1: SerialNumber: 0000:00:1a.7
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
ehci_hcd 0000:00:1d.7: PCI INT A -> GSI 23 (level, low) -> IRQ 23
ehci_hcd 0000:00:1d.7: setting latency timer to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 2
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: cache line size of 32 is not supported
ehci_hcd 0000:00:1d.7: irq 23, io mem 0xfebff000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00
usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: EHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.30-gentoo-r4 ehci_hcd
usb usb2: SerialNumber: 0000:00:1d.7
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 6 ports detected
uhci_hcd: USB Universal Host Controller Interface driver
uhci_hcd 0000:00:1a.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
uhci_hcd 0000:00:1a.0: setting latency timer to 64
uhci_hcd 0000:00:1a.0: UHCI Host Controller
uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1a.0: irq 16, io base 0x0000e080
usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: UHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.30-gentoo-r4 uhci_hcd
usb usb3: SerialNumber: 0000:00:1a.0
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:1a.1: PCI INT B -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:1a.1: setting latency timer to 64
uhci_hcd 0000:00:1a.1: UHCI Host Controller
uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1a.1: irq 21, io base 0x0000e000
usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: Product: UHCI Host Controller
usb usb4: Manufacturer: Linux 2.6.30-gentoo-r4 uhci_hcd
usb usb4: SerialNumber: 0000:00:1a.1
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 23 (level, low) -> IRQ 23
uhci_hcd 0000:00:1d.0: setting latency timer to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.0: irq 23, io base 0x0000dc00
usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb5: Product: UHCI Host Controller
usb usb5: Manufacturer: Linux 2.6.30-gentoo-r4 uhci_hcd
usb usb5: SerialNumber: 0000:00:1d.0
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
uhci_hcd 0000:00:1d.1: setting latency timer to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 6
uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000d880
usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb6: Product: UHCI Host Controller
usb usb6: Manufacturer: Linux 2.6.30-gentoo-r4 uhci_hcd
usb usb6: SerialNumber: 0000:00:1d.1
usb usb6: configuration #1 chosen from 1 choice
hub 6-0:1.0: USB hub found
hub 6-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
uhci_hcd 0000:00:1d.2: setting latency timer to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 7
uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000d800
usb usb7: New USB device found, idVendor=1d6b, idProduct=0001
usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb7: Product: UHCI Host Controller
usb usb7: Manufacturer: Linux 2.6.30-gentoo-r4 uhci_hcd
usb usb7: SerialNumber: 0000:00:1d.2
usb usb7: configuration #1 chosen from 1 choice
hub 7-0:1.0: USB hub found
hub 7-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
usbcore: registered new interface driver libusual
usbcore: registered new interface driver berry_charge
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
drivers/input/serio/i8042.c: 20 -> i8042 (command) [1]
drivers/input/serio/i8042.c: 45 <- i8042 (return) [1]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [1]
drivers/input/serio/i8042.c: 54 -> i8042 (parameter) [1]
drivers/input/serio/i8042.c: d3 -> i8042 (command) [1]
drivers/input/serio/i8042.c: 5a -> i8042 (parameter) [1]
drivers/input/serio/i8042.c: 5a <- i8042 (return) [1]
drivers/input/serio/i8042.c: a7 -> i8042 (command) [1]
drivers/input/serio/i8042.c: 20 -> i8042 (command) [1]
drivers/input/serio/i8042.c: 74 <- i8042 (return) [1]
drivers/input/serio/i8042.c: a8 -> i8042 (command) [2]
drivers/input/serio/i8042.c: 20 -> i8042 (command) [2]
drivers/input/serio/i8042.c: 54 <- i8042 (return) [2]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [2]
drivers/input/serio/i8042.c: 56 -> i8042 (parameter) [2]
drivers/input/serio/i8042.c: d3 -> i8042 (command) [2]
drivers/input/serio/i8042.c: a5 -> i8042 (parameter) [2]
drivers/input/serio/i8042.c: a5 <- i8042 (flush, aux) [252]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [252]
drivers/input/serio/i8042.c: 74 -> i8042 (parameter) [252]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [252]
drivers/input/serio/i8042.c: 65 -> i8042 (parameter) [252]
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
drivers/input/serio/i8042.c: f2 -> i8042 (kbd-data) [253]
rtc_cmos 00:03: RTC can wake from S4
rtc_cmos 00:03: rtc core: registered rtc_cmos as rtc0
rtc0: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
Linux video capture interface: v2.00
usbcore: registered new interface driver uvcvideo
USB Video Class driver (v0.1.0)
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [255]
drivers/input/serio/i8042.c: ab <- i8042 (interrupt, 0, 1) [2194]
usb 1-1: new high speed USB device using ehci_hcd and address 2
ata4: SATA link down (SStatus 0 SControl 300)
ata1.00: ACPI cmd f5/00:00:00:00:00:a0 filtered out
drivers/input/serio/i8042.c: 41 <- i8042 (interrupt, 0, 1) [2194]
drivers/input/serio/i8042.c: ed -> i8042 (kbd-data) [2194]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [2257]
drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) [2257]
ata1.00: ACPI cmd ef/10:06:00:00:00:a0 succeeded
ata1.00: ACPI cmd ef/10:03:00:00:00:a0 filtered out
Bluetooth: Generic Bluetooth USB driver ver 0.5
usbcore: registered new interface driver btusb
cpuidle: using governor ladder
sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
sdhci-pci 0000:08:01.1: SDHCI controller found [1180:0822] (rev 22)
sdhci-pci 0000:08:01.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [2260]
Registered led device: mmc0::
mmc0: SDHCI controller on PCI [0000:08:01.1] using PIO
ricoh-mmc: Ricoh MMC Controller disabling driver
ricoh-mmc: Copyright(c) Philip Langdale
usbcore: registered new interface driver usbhid
usbhid: v2.6:USB HID core driver
usbcore: registered new interface driver asus-oled
asus-laptop: Asus Laptop Support version 0.42
asus-laptop:   G1S model detected
asus-laptop: Brightness ignored, must be controlled by ACPI video driver
input: Asus Laptop extra buttons as /devices/virtual/input/input4
Registered led device: asus::mail
Registered led device: asus::touchpad
Registered led device: asus::gaming
Advanced Linux Sound Architecture Driver Version 1.0.20.
HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
HDA Intel 0000:00:1b.0: setting latency timer to 64
drivers/input/serio/i8042.c: f3 -> i8042 (kbd-data) [2762]
firewire_core: created device fw0: GUID 00e0180003a482f6, S400
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [2764]
drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) [2764]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [2765]
drivers/input/serio/i8042.c: f4 -> i8042 (kbd-data) [2784]
ata1.00: ATA-8: Hitachi HTS722016K9SA00, DCDOC54P, max UDMA/133
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [2806]
ata1.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata1.00: ACPI cmd f5/00:00:00:00:00:a0 filtered out
input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input5
ata1.00: ACPI cmd ef/10:06:00:00:00:a0 succeeded
ata1.00: ACPI cmd ef/10:03:00:00:00:a0 filtered out
ata1.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      Hitachi HTS72201 DCDO PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors: (160 GB/149 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda:<5>sd 0:0:0:0: Attached scsi generic sg0 type 0
 sda1 sda2 sda3 sda4 <<6>ALSA device list:
usb 1-1: New USB device found, idVendor=04f2, idProduct=b012
usb 1-1: New USB device strings: Mfr=2, Product=1, SerialNumber=3
usb 1-1: Product: USB2.0 1.3M UVC WebCam 
usb 1-1: Manufacturer: Chicony Electronics Co., Ltd.
usb 1-1: SerialNumber: SN0001
usb 1-1: configuration #1 chosen from 1 choice
  #0: HDA Intel at 0xfebf8000 irq 22
uvcvideo: Found UVC 1.00 device USB2.0 1.3M UVC WebCam  (04f2:b012)
TCP cubic registered
NET: Registered protocol family 17
Bluetooth: L2CAP ver 2.13
Bluetooth: L2CAP socket layer initialized
input: USB2.0 1.3M UVC WebCam  as /devices/pci0000:00/0000:00:1a.7/usb1/1-1/1-1:1.0/input/input6
 sda5<6>Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.11
lib80211: common routines for IEEE802.11 drivers
lib80211_crypt: registered algorithm 'NULL'
usb 1-2: new high speed USB device using ehci_hcd and address 3
rtc_cmos 00:03: setting system clock to 2009-07-29 22:12:17 UTC (1248905537)
mmc0: new SD card at address b368
 sda6<6>mmcblk0: mmc0:b368 SD01G 958 MiB 
 mmcblk0: p1
 sda7 >
sd 0:0:0:0: [sda] Attached SCSI disk
usb 1-2: config 1 interface 0 altsetting 0 endpoint 0x81 has an invalid bInterval 0, changing to 9
usb 1-2: config 1 interface 0 altsetting 0 endpoint 0x2 has an invalid bInterval 0, changing to 9
usb 1-2: New USB device found, idVendor=0b05, idProduct=1726
usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
usb 1-2: Product: LCM
usb 1-2: Manufacturer: ASUS
usb 1-2: configuration #1 chosen from 1 choice
asus-oled 1-2:1.0: Attached Asus OLED device: G1/G2 [width 128, pack_mode 0]
UDF-fs: No partition found (1)
XFS mounting filesystem sda3
usb 2-3: new high speed USB device using ehci_hcd and address 2
Ending clean XFS mount for filesystem: sda3
VFS: Mounted root (xfs filesystem) readonly on device 8:3.
Freeing unused kernel memory: 360k freed
usb 2-3: New USB device found, idVendor=0781, idProduct=5406
usb 2-3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 2-3: Product: U3 Cruzer Micro
usb 2-3: Manufacturer: SanDisk
usb 2-3: SerialNumber: 173870168F82862A
usb 2-3: configuration #1 chosen from 1 choice
scsi4 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 2
usb-storage: waiting for device to settle before scanning
usb 7-2: new full speed USB device using uhci_hcd and address 2
Clocksource tsc unstable (delta = -169025684 ns)
usb 7-2: New USB device found, idVendor=0b05, idProduct=1712
usb 7-2: New USB device strings: Mfr=0, Product=0, SerialNumber=3
usb 7-2: SerialNumber: 0194E8-5B-0002
usb 7-2: configuration #1 chosen from 1 choice
udev: starting version 141
udev: renamed network interface eth0 to lan0
nvidia: module license 'NVIDIA' taints kernel.
Disabling lock debugging due to kernel taint
nvidia 0000:01:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
nvidia 0000:01:00.0: setting latency timer to 64
NVRM: loading NVIDIA UNIX x86_64 Kernel Module  185.18.29  Wed Jul 22 23:04:30 PDT 2009
scsi 4:0:0:0: Direct-Access     SanDisk  Cruzer           7.01 PQ: 0 ANSI: 0 CCS
sd 4:0:0:0: Attached scsi generic sg1 type 0
usb-storage: device scan complete
sd 4:0:0:0: [sdb] 31306239 512-byte hardware sectors: (16.0 GB/14.9 GiB)
sd 4:0:0:0: [sdb] Write Protect is off
sd 4:0:0:0: [sdb] Mode Sense: 45 00 00 08
sd 4:0:0:0: [sdb] Assuming drive cache: write through
sd 4:0:0:0: [sdb] Assuming drive cache: write through
 sdb: sdb1
sd 4:0:0:0: [sdb] Attached SCSI removable disk
XFS mounting filesystem sda5
Ending clean XFS mount for filesystem: sda5
XFS mounting filesystem sda6
Ending clean XFS mount for filesystem: sda6
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
microcode: CPU0 updated from revision 0xb3 to 0xb6, date = 2007-07-13 
microcode: CPU1 updated from revision 0xb3 to 0xb6, date = 2007-07-13 
Adding 1959920k swap on /dev/sda2.  Priority:-1 extents:1 across:1959920k 
r8169: lan0: link down
iwlagn 0000:03:00.0: firmware: requesting iwlwifi-4965-2.ucode
iwlagn 0000:03:00.0: loaded firmware version 228.57.2.23
Registered led device: iwl-phy0::radio
Registered led device: iwl-phy0::assoc
Registered led device: iwl-phy0::RX
Registered led device: iwl-phy0::TX
drivers/input/serio/i8042.c: 1d <- i8042 (interrupt, 0, 1) [27034]
drivers/input/serio/i8042.c: 38 <- i8042 (interrupt, 0, 1) [27162]
drivers/input/serio/i8042.c: 38 <- i8042 (interrupt, 0, 1) [27403]
drivers/input/serio/i8042.c: 38 <- i8042 (interrupt, 0, 1) [27437]
drivers/input/serio/i8042.c: 3b <- i8042 (interrupt, 0, 1) [27456]
drivers/input/serio/i8042.c: bb <- i8042 (interrupt, 0, 1) [27599]
drivers/input/serio/i8042.c: 9d <- i8042 (interrupt, 0, 1) [27682]
drivers/input/serio/i8042.c: b8 <- i8042 (interrupt, 0, 1) [27716]
wlan0: authenticate with AP 00:1d:7e:f8:d9:8a
wlan0: authenticated
wlan0: associate with AP 00:1d:7e:f8:d9:8a
wlan0: RX AssocResp from 00:1d:7e:f8:d9:8a (capab=0x411 status=0 aid=2)
wlan0: associated
drivers/input/serio/i8042.c: 1e <- i8042 (interrupt, 0, 1) [29563]
drivers/input/serio/i8042.c: 9e <- i8042 (interrupt, 0, 1) [29686]
drivers/input/serio/i8042.c: 31 <- i8042 (interrupt, 0, 1) [29738]
drivers/input/serio/i8042.c: 1e <- i8042 (interrupt, 0, 1) [29817]
drivers/input/serio/i8042.c: b1 <- i8042 (interrupt, 0, 1) [29861]
drivers/input/serio/i8042.c: 13 <- i8042 (interrupt, 0, 1) [29944]
drivers/input/serio/i8042.c: 9e <- i8042 (interrupt, 0, 1) [30013]
drivers/input/serio/i8042.c: 93 <- i8042 (interrupt, 0, 1) [30062]
drivers/input/serio/i8042.c: 2e <- i8042 (interrupt, 0, 1) [30183]
drivers/input/serio/i8042.c: 23 <- i8042 (interrupt, 0, 1) [30275]
drivers/input/serio/i8042.c: ae <- i8042 (interrupt, 0, 1) [30349]
drivers/input/serio/i8042.c: a3 <- i8042 (interrupt, 0, 1) [30384]
drivers/input/serio/i8042.c: 15 <- i8042 (interrupt, 0, 1) [30441]
drivers/input/serio/i8042.c: 95 <- i8042 (interrupt, 0, 1) [30534]
drivers/input/serio/i8042.c: 1c <- i8042 (interrupt, 0, 1) [30657]
drivers/input/serio/i8042.c: 9c <- i8042 (interrupt, 0, 1) [30794]
drivers/input/serio/i8042.c: 2a <- i8042 (interrupt, 0, 1) [30826]
drivers/input/serio/i8042.c: 2a <- i8042 (interrupt, 0, 1) [31066]
drivers/input/serio/i8042.c: 21 <- i8042 (interrupt, 0, 1) [31071]
drivers/input/serio/i8042.c: aa <- i8042 (interrupt, 0, 1) [31203]
drivers/input/serio/i8042.c: a1 <- i8042 (interrupt, 0, 1) [31213]
drivers/input/serio/i8042.c: 16 <- i8042 (interrupt, 0, 1) [31228]
drivers/input/serio/i8042.c: 96 <- i8042 (interrupt, 0, 1) [31340]
drivers/input/serio/i8042.c: 2e <- i8042 (interrupt, 0, 1) [31346]
drivers/input/serio/i8042.c: ae <- i8042 (interrupt, 0, 1) [31468]
drivers/input/serio/i8042.c: 25 <- i8042 (interrupt, 0, 1) [31514]
drivers/input/serio/i8042.c: 12 <- i8042 (interrupt, 0, 1) [31631]
drivers/input/serio/i8042.c: a5 <- i8042 (interrupt, 0, 1) [31656]
drivers/input/serio/i8042.c: 13 <- i8042 (interrupt, 0, 1) [31685]
drivers/input/serio/i8042.c: 92 <- i8042 (interrupt, 0, 1) [31768]
drivers/input/serio/i8042.c: 1c <- i8042 (interrupt, 0, 1) [31828]
drivers/input/serio/i8042.c: 93 <- i8042 (interrupt, 0, 1) [31862]
drivers/input/serio/i8042.c: 9c <- i8042 (interrupt, 0, 1) [31974]
drivers/input/serio/i8042.c: 2e <- i8042 (interrupt, 0, 1) [32271]
drivers/input/serio/i8042.c: ae <- i8042 (interrupt, 0, 1) [32422]
drivers/input/serio/i8042.c: 26 <- i8042 (interrupt, 0, 1) [32448]
drivers/input/serio/i8042.c: 12 <- i8042 (interrupt, 0, 1) [32576]
drivers/input/serio/i8042.c: a6 <- i8042 (interrupt, 0, 1) [32580]
drivers/input/serio/i8042.c: 1e <- i8042 (interrupt, 0, 1) [32659]
drivers/input/serio/i8042.c: 92 <- i8042 (interrupt, 0, 1) [32698]
drivers/input/serio/i8042.c: 13 <- i8042 (interrupt, 0, 1) [32757]
drivers/input/serio/i8042.c: 9e <- i8042 (interrupt, 0, 1) [32845]
drivers/input/serio/i8042.c: 1c <- i8042 (interrupt, 0, 1) [32884]
drivers/input/serio/i8042.c: 93 <- i8042 (interrupt, 0, 1) [32889]
drivers/input/serio/i8042.c: 9c <- i8042 (interrupt, 0, 1) [33017]
drivers/input/serio/i8042.c: 20 <- i8042 (interrupt, 0, 1) [33289]
drivers/input/serio/i8042.c: a0 <- i8042 (interrupt, 0, 1) [33446]
drivers/input/serio/i8042.c: 32 <- i8042 (interrupt, 0, 1) [33456]
drivers/input/serio/i8042.c: b2 <- i8042 (interrupt, 0, 1) [33583]
drivers/input/serio/i8042.c: 12 <- i8042 (interrupt, 0, 1) [33934]
drivers/input/serio/i8042.c: 1f <- i8042 (interrupt, 0, 1) [34032]
drivers/input/serio/i8042.c: 92 <- i8042 (interrupt, 0, 1) [34062]
drivers/input/serio/i8042.c: 9f <- i8042 (interrupt, 0, 1) [34164]
drivers/input/serio/i8042.c: 22 <- i8042 (interrupt, 0, 1) [34236]
drivers/input/serio/i8042.c: 39 <- i8042 (interrupt, 0, 1) [34345]
drivers/input/serio/i8042.c: a2 <- i8042 (interrupt, 0, 1) [34369]
drivers/input/serio/i8042.c: b9 <- i8042 (interrupt, 0, 1) [34467]
drivers/input/serio/i8042.c: 36 <- i8042 (interrupt, 0, 1) [35248]
drivers/input/serio/i8042.c: 36 <- i8042 (interrupt, 0, 1) [35488]
drivers/input/serio/i8042.c: 36 <- i8042 (interrupt, 0, 1) [35522]
drivers/input/serio/i8042.c: 36 <- i8042 (interrupt, 0, 1) [35556]
drivers/input/serio/i8042.c: 34 <- i8042 (interrupt, 0, 1) [35562]
drivers/input/serio/i8042.c: b4 <- i8042 (interrupt, 0, 1) [35660]
drivers/input/serio/i8042.c: 34 <- i8042 (interrupt, 0, 1) [35718]
drivers/input/serio/i8042.c: b4 <- i8042 (interrupt, 0, 1) [35846]
drivers/input/serio/i8042.c: b6 <- i8042 (interrupt, 0, 1) [35870]
drivers/input/serio/i8042.c: 39 <- i8042 (interrupt, 0, 1) [36062]
drivers/input/serio/i8042.c: b9 <- i8042 (interrupt, 0, 1) [36204]
drivers/input/serio/i8042.c: 20 <- i8042 (interrupt, 0, 1) [36230]
drivers/input/serio/i8042.c: 32 <- i8042 (interrupt, 0, 1) [36352]
drivers/input/serio/i8042.c: a0 <- i8042 (interrupt, 0, 1) [36362]
drivers/input/serio/i8042.c: 12 <- i8042 (interrupt, 0, 1) [36465]
drivers/input/serio/i8042.c: b2 <- i8042 (interrupt, 0, 1) [36495]
drivers/input/serio/i8042.c: 1f <- i8042 (interrupt, 0, 1) [36534]
drivers/input/serio/i8042.c: 92 <- i8042 (interrupt, 0, 1) [36608]
drivers/input/serio/i8042.c: 9f <- i8042 (interrupt, 0, 1) [36686]
drivers/input/serio/i8042.c: 22 <- i8042 (interrupt, 0, 1) [36761]
drivers/input/serio/i8042.c: 34 <- i8042 (interrupt, 0, 1) [36874]
drivers/input/serio/i8042.c: a2 <- i8042 (interrupt, 0, 1) [36893]
drivers/input/serio/i8042.c: b4 <- i8042 (interrupt, 0, 1) [37021]
drivers/input/serio/i8042.c: 14 <- i8042 (interrupt, 0, 1) [37104]
drivers/input/serio/i8042.c: 94 <- i8042 (interrupt, 0, 1) [37226]
drivers/input/serio/i8042.c: 2d <- i8042 (interrupt, 0, 1) [37374]
drivers/input/serio/i8042.c: ad <- i8042 (interrupt, 0, 1) [37497]
drivers/input/serio/i8042.c: 14 <- i8042 (interrupt, 0, 1) [37605]
drivers/input/serio/i8042.c: 94 <- i8042 (interrupt, 0, 1) [37718]
drivers/input/serio/i8042.c: 1c <- i8042 (interrupt, 0, 1) [37739]

--------------030009020307040002000100--
