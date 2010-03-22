From: Anisse Astier <anisse@astier.eu>
Subject: Re: i8042: 10 second lag/timeout with no AUX
Date: Mon, 22 Mar 2010 14:45:14 +0100
Message-ID: <20100322144514.45391412@destiny.ordissimo>
References: <20100319103450.56c6e278@destiny.ordissimo>
	<20100322043924.GD31621@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:27655 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754742Ab0CVNph (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Mar 2010 09:45:37 -0400
Received: by ey-out-2122.google.com with SMTP id d26so451687eyd.19
        for <linux-input@vger.kernel.org>; Mon, 22 Mar 2010 06:45:35 -0700 (PDT)
In-Reply-To: <20100322043924.GD31621@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Sun, 21 Mar 2010 21:39:24 -0700, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote :

> Hi Anisse,
> 
> On Fri, Mar 19, 2010 at 10:34:50AM +0100, Anisse Astier wrote:
> > 
> > Is there a way to add a quirk of some sort for this computer? I didn't find
> > anything related to i8042.noaux in drivers/input/serio/i8042-x86ia64io.h.
> > 
> 
> Currently we do not have noaux quirks. Could I get full dmesg with i8042.debug?
> 
Sure, there you go. You'll notice that the timeout happens two times with
i8042.debug, giving a 20 second lag.

Anisse

--

[    0.000000] Linux version 2.6.34-rc2 (root@asterix) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)) #2 SMP Mon Mar 22 12:00:31 CET 2010
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
[    0.000000]  BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000006ffa0000 (usable)
[    0.000000]  BIOS-e820: 000000006ffa0000 - 000000006ffae000 (ACPI data)
[    0.000000]  BIOS-e820: 000000006ffae000 - 000000006fff0000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000006fff0000 - 0000000080000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000ff700000 - 0000000100000000 (reserved)
[    0.000000] Notice: NX (Execute Disable) protection cannot be enabled: non-PAE kernel!
[    0.000000] DMI present.
[    0.000000] e820 update range: 0000000000000000 - 0000000000001000 (usable) ==> (reserved)
[    0.000000] e820 remove range: 00000000000a0000 - 0000000000100000 (usable)
[    0.000000] last_pfn = 0x6ffa0 max_arch_pfn = 0x100000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-CFFFF write-protect
[    0.000000]   D0000-DFFFF uncachable
[    0.000000]   E0000-EFFFF write-through
[    0.000000]   F0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask F80000000 write-back
[    0.000000]   1 disabled
[    0.000000]   2 disabled
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[    0.000000] initial memory mapped : 0 - 01800000
[    0.000000] found SMP MP-table at [c00ff780] ff780
[    0.000000] init_memory_mapping: 0000000000000000-00000000377fe000
[    0.000000]  0000000000 - 0000400000 page 4k
[    0.000000]  0000400000 - 0037400000 page 2M
[    0.000000]  0037400000 - 00377fe000 page 4k
[    0.000000] kernel direct mapping tables up to 377fe000 @ 7000-c000
[    0.000000] RAMDISK: 00c95000 - 00effe37
[    0.000000] ACPI: RSDP 000fa610 00024 (v02 ACPIAM)
[    0.000000] ACPI: XSDT 6ffa0100 0006C (v01 MSI_NB MEGABOOK 20090922 MSFT 00000097)
[    0.000000] ACPI: FACP 6ffa0290 000F4 (v03 092209 FACP1729 20090922 MSFT 00000097)
[    0.000000] ACPI: DSDT 6ffa0620 0974D (v01  1AECV 1AECV100 00000000 INTL 20051117)
[    0.000000] ACPI: FACS 6ffae000 00040
[    0.000000] ACPI: APIC 6ffa0390 00080 (v01 092209 APIC1729 20090922 MSFT 00000097)
[    0.000000] ACPI: MCFG 6ffa0410 0003C (v01 092209 OEMMCFG  20090922 MSFT 00000097)
[    0.000000] ACPI: SLIC 6ffa0450 00176 (v01 MSI_NB MEGABOOK 20090922 MSFT 00000097)
[    0.000000] ACPI: WDRT 6ffa05d0 00047 (v01 092209 NV-WDRT  20090922 MSFT 00000097)
[    0.000000] ACPI: OEMB 6ffae040 0007A (v01 092209 OEMB1729 20090922 MSFT 00000097)
[    0.000000] ACPI: HPET 6ffaa620 00038 (v01 092209 OEMHPET0 20090922 MSFT 00000097)
[    0.000000] ACPI: NVHD 6ffae0c0 00284 (v01 092209  NVHDCP  20090922 MSFT 00000097)
[    0.000000] ACPI: SSDT 6ffae620 004F0 (v01  PmRef    CpuPm 00003000 INTL 20051117)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] 903MB HIGHMEM available.
[    0.000000] 887MB LOWMEM available.
[    0.000000]   mapped low ram: 0 - 377fe000
[    0.000000]   low ram: 0 - 377fe000
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000001 -> 0x00001000
[    0.000000]   Normal   0x00001000 -> 0x000377fe
[    0.000000]   HighMem  0x000377fe -> 0x0006ffa0
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[2] active PFN ranges
[    0.000000]     0: 0x00000001 -> 0x0000009e
[    0.000000]     0: 0x00000100 -> 0x0006ffa0
[    0.000000] On node 0 totalpages: 458557
[    0.000000] free_area_init_node: node 0, pgdat c139b800, node_mem_map c142d020
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 3965 pages, LIFO batch:0
[    0.000000]   Normal zone: 1744 pages used for memmap
[    0.000000]   Normal zone: 221486 pages, LIFO batch:31
[    0.000000]   HighMem zone: 1808 pages used for memmap
[    0.000000]   HighMem zone: 229522 pages, LIFO batch:31
[    0.000000] Using APIC driver default
[    0.000000] ACPI: PM-Timer IO Port: 0x4008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] ACPI: IRQ14 used by override.
[    0.000000] ACPI: IRQ15 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x10de8201 base: 0xfed00000
[    0.000000] SMP: Allowing 4 CPUs, 2 hotplug CPUs
[    0.000000] nr_irqs_gsi: 24
[    0.000000] early_res array is doubled to 64 at [8000 - 87ff]
[    0.000000] Allocating PCI resources starting at 80000000 (gap: 80000000:7ec00000)
[    0.000000] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:4 nr_node_ids:1
[    0.000000] PERCPU: Embedded 12 pages/cpu @c2400000 s27348 r0 d21804 u1048576
[    0.000000] pcpu-alloc: s27348 r0 d21804 u1048576 alloc=1*4194304
[    0.000000] pcpu-alloc: [0] 0 1 2 3 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 454973
[    0.000000] Kernel command line: BOOT_IMAGE=Ordissimo ro root=805 splash=silent log_buf_len=1M i8042.debug
[    0.000000] log_buf_len: 1048576
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Enabling fast FPU save and restore... done.
[    0.000000] Enabling unmasked SIMD FPU exception support... done.
[    0.000000] Initializing CPU#0
[    0.000000] xsave/xrstor: enabled xstate_bv 0x3, cntxt size 0x240
[    0.000000] Subtract (51 early reservations)
[    0.000000]   #1 [0000001000 - 0000002000]   EX TRAMPOLINE
[    0.000000]   #2 [0001000000 - 0001424f84]   TEXT DATA BSS
[    0.000000]   #3 [0000c95000 - 0000effe37]         RAMDISK
[    0.000000]   #4 [0001425000 - 000142b11f]             BRK
[    0.000000]   #5 [00000ff790 - 0000100000]   BIOS reserved
[    0.000000]   #6 [00000ff780 - 00000ff790]    MP-table mpf
[    0.000000]   #7 [000009e800 - 00000fcf50]   BIOS reserved
[    0.000000]   #8 [00000fd0ac - 00000ff780]   BIOS reserved
[    0.000000]   #9 [00000fcf50 - 00000fd0ac]    MP-table mpc
[    0.000000]   #10 [0000002000 - 0000003000]      TRAMPOLINE
[    0.000000]   #11 [0000003000 - 0000007000]     ACPI WAKEUP
[    0.000000]   #12 [0000007000 - 0000008000]         PGTABLE
[    0.000000]   #13 [000142c000 - 000142d000]         BOOTMEM
[    0.000000]   #14 [000142d000 - 000222d000]         BOOTMEM
[    0.000000]   #15 [0001424fc0 - 0001424fc4]         BOOTMEM
[    0.000000]   #16 [000142b140 - 000142b200]         BOOTMEM
[    0.000000]   #17 [000142b200 - 000142b254]         BOOTMEM
[    0.000000]   #18 [000222d000 - 0002230000]         BOOTMEM
[    0.000000]   #19 [000142b280 - 000142b2d8]         BOOTMEM
[    0.000000]   #20 [0002230000 - 0002233000]         BOOTMEM
[    0.000000]   #21 [000142b300 - 000142b325]         BOOTMEM
[    0.000000]   #22 [000142b340 - 000142b367]         BOOTMEM
[    0.000000]   #23 [000142b380 - 000142b4b4]         BOOTMEM
[    0.000000]   #24 [000142b4c0 - 000142b500]         BOOTMEM
[    0.000000]   #25 [000142b500 - 000142b540]         BOOTMEM
[    0.000000]   #26 [000142b540 - 000142b580]         BOOTMEM
[    0.000000]   #27 [000142b580 - 000142b5c0]         BOOTMEM
[    0.000000]   #28 [000142b5c0 - 000142b600]         BOOTMEM
[    0.000000]   #29 [000142b600 - 000142b640]         BOOTMEM
[    0.000000]   #30 [000142b640 - 000142b680]         BOOTMEM
[    0.000000]   #31 [000142b680 - 000142b6c0]         BOOTMEM
[    0.000000]   #32 [000142b6c0 - 000142b700]         BOOTMEM
[    0.000000]   #33 [000142b700 - 000142b740]         BOOTMEM
[    0.000000]   #34 [000142b740 - 000142b78a]         BOOTMEM
[    0.000000]   #35 [000142b7c0 - 000142b80a]         BOOTMEM
[    0.000000]   #36 [0002400000 - 000240c000]         BOOTMEM
[    0.000000]   #37 [0002500000 - 000250c000]         BOOTMEM
[    0.000000]   #38 [0002600000 - 000260c000]         BOOTMEM
[    0.000000]   #39 [0002700000 - 000270c000]         BOOTMEM
[    0.000000]   #40 [000142b840 - 000142b844]         BOOTMEM
[    0.000000]   #41 [000142b880 - 000142b884]         BOOTMEM
[    0.000000]   #42 [000142b8c0 - 000142b8d0]         BOOTMEM
[    0.000000]   #43 [000142b900 - 000142b910]         BOOTMEM
[    0.000000]   #44 [000142b940 - 000142b9e0]         BOOTMEM
[    0.000000]   #45 [000142ba00 - 000142ba48]         BOOTMEM
[    0.000000]   #46 [0002233000 - 0002333000]         BOOTMEM
[    0.000000]   #47 [0002333000 - 0002337000]         BOOTMEM
[    0.000000]   #48 [0002337000 - 00023b7000]         BOOTMEM
[    0.000000]   #49 [00023b7000 - 00023f7000]         BOOTMEM
[    0.000000]   #50 [000142ba80 - 000142bcc0]         BOOTMEM
[    0.000000]  8 20 - 80 9e
[    0.000000]  100 100 - c80 c95
[    0.000000]  f00 f00 - 1000 1000
[    0.000000]  23f7 - 2400
[    0.000000]  240c 2420 - 2500 2500
[    0.000000]  250c 2520 - 2600 2600
[    0.000000]  260c 2620 - 2700 2700
[    0.000000]  270c 2720 - 377e0 377fe
[    0.000000] Initializing HighMem for node 0 (000377fe:0006ffa0)
[    0.000000] Memory: 1811088k/1834624k available (2528k kernel code, 23140k reserved, 1177k data, 312k init, 925320k highmem)
[    0.000000] virtual kernel memory layout:
[    0.000000]     fixmap  : 0xfff1e000 - 0xfffff000   ( 900 kB)
[    0.000000]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
[    0.000000]     vmalloc : 0xf7ffe000 - 0xff7fe000   ( 120 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xf77fe000   ( 887 MB)
[    0.000000]       .init : 0xc139f000 - 0xc13ed000   ( 312 kB)
[    0.000000]       .data : 0xc12780fd - 0xc139e6c8   (1177 kB)
[    0.000000]       .text : 0xc1000000 - 0xc12780fd   (2528 kB)
[    0.000000] Checking if this processor honours the WP bit even in supervisor mode...Ok.
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:512
[    0.000000] Extended CMOS year: 2000
[    0.000000] spurious 8259A interrupt: IRQ7.
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] hpet clockevent registered
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 2099.655 MHz processor.
[    0.001005] Calibrating delay loop (skipped), value calculated using timer frequency.. 4199.31 BogoMIPS (lpj=2099655)
[    0.002041] Mount-cache hash table entries: 512
[    0.002162] CPU: Physical Processor ID: 0
[    0.002165] CPU: Processor Core ID: 0
[    0.002170] using mwait in idle threads.
[    0.002178] Performance Events: Core2 events, Intel PMU driver.
[    0.002187] ... version:                2
[    0.002191] ... bit width:              40
[    0.002194] ... generic registers:      2
[    0.002197] ... value mask:             000000ffffffffff
[    0.002200] ... max period:             000000007fffffff
[    0.002204] ... fixed-purpose events:   3
[    0.002207] ... event mask:             0000000700000003
[    0.002214] Checking 'hlt' instruction... OK.
[    0.006368] ACPI: Core revision 20100121
[    0.023984] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.024401] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.034412] CPU0: Intel Pentium(R) Dual-Core CPU       T4300  @ 2.10GHz stepping 0a
[    0.034999] Booting Node   0, Processors  #1
[    0.001999] Initializing CPU#1
[    0.106014] Brought up 2 CPUs
[    0.106022] Total of 2 processors activated (8399.01 BogoMIPS).
[    0.106754] NET: Registered protocol family 16
[    0.107093] ACPI: bus type pci registered
[    0.107193] PCI: MMCONFIG for domain 0000 [bus 00-1f] at [mem 0xfc000000-0xfdffffff] (base 0xfc000000)
[    0.107200] PCI: not using MMCONFIG
[    0.107435] PCI: PCI BIOS revision 3.00 entry at 0xf0031, last bus=9
[    0.107439] PCI: Using configuration type 1 for base access
[    0.109537] bio: create slab <bio-0> at 0
[    0.111676] ACPI: EC: Look up EC in DSDT
[    0.113617] ACPI: Executed 1 blocks of module-level executable AML code
[    0.123564] ACPI: SSDT 6ffae420 001FA (v01  PmRef  Cpu0Ist 00003000 INTL 20051117)
[    0.124444] ACPI: SSDT 6ffae350 000CC (v01  PmRef  Cpu1Ist 00003000 INTL 20051117)
[    0.125146] ACPI: Interpreter enabled
[    0.125163] ACPI: (supports S0 S3 S5)
[    0.125181] ACPI: Using IOAPIC for interrupt routing
[    0.125252] PCI: MMCONFIG for domain 0000 [bus 00-1f] at [mem 0xfc000000-0xfdffffff] (base 0xfc000000)
[    0.127341] PCI: MMCONFIG at [mem 0xfc000000-0xfdffffff] reserved in ACPI motherboard resources
[    0.127347] PCI: Using MMCONFIG for extended config space
[    0.156030] ACPI: EC: GPE = 0x10, I/O: command/status = 0x66, data = 0x62
[    0.156419] ACPI: No dock devices found.
[    0.156426] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.156967] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.157390] pci_root PNP0A03:00: host bridge window [io  0x0000-0x0cf7]
[    0.157396] pci_root PNP0A03:00: host bridge window [io  0x0d00-0xffff]
[    0.157401] pci_root PNP0A03:00: host bridge window [mem 0x000a0000-0x000bffff]
[    0.157406] pci_root PNP0A03:00: host bridge window [mem 0x000d0000-0x000dffff]
[    0.157412] pci_root PNP0A03:00: host bridge window [mem 0x80000000-0xfbffffff]
[    0.157418] pci_root PNP0A03:00: host bridge window [mem 0xfe000000-0xfebfffff]
[    0.157637] pci 0000:00:03.0: reg 10: [io  0x4f00-0x4fff]
[    0.157736] pci 0000:00:03.2: reg 10: [io  0x4900-0x493f]
[    0.157751] pci 0000:00:03.2: reg 20: [io  0x4d00-0x4d3f]
[    0.157756] pci 0000:00:03.2: reg 24: [io  0x4e00-0x4e3f]
[    0.157780] pci 0000:00:03.2: PME# supported from D3hot D3cold
[    0.157786] pci 0000:00:03.2: PME# disabled
[    0.157914] pci 0000:00:03.5: reg 10: [mem 0xfae80000-0xfaefffff]
[    0.158022] pci 0000:00:04.0: reg 10: [mem 0xfae7f000-0xfae7ffff]
[    0.158054] pci 0000:00:04.0: supports D1 D2
[    0.158057] pci 0000:00:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.158061] pci 0000:00:04.0: PME# disabled
[    0.158086] pci 0000:00:04.1: reg 10: [mem 0xfae7ec00-0xfae7ecff]
[    0.158124] pci 0000:00:04.1: supports D1 D2
[    0.158127] pci 0000:00:04.1: PME# supported from D0 D1 D2 D3hot D3cold
[    0.158131] pci 0000:00:04.1: PME# disabled
[    0.158162] pci 0000:00:06.0: reg 10: [mem 0xfae7d000-0xfae7dfff]
[    0.158194] pci 0000:00:06.0: supports D1 D2
[    0.158197] pci 0000:00:06.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.158201] pci 0000:00:06.0: PME# disabled
[    0.158226] pci 0000:00:06.1: reg 10: [mem 0xfae7e800-0xfae7e8ff]
[    0.158265] pci 0000:00:06.1: supports D1 D2
[    0.158267] pci 0000:00:06.1: PME# supported from D0 D1 D2 D3hot D3cold
[    0.158271] pci 0000:00:06.1: PME# disabled
[    0.158302] pci 0000:00:08.0: reg 10: [mem 0xfae78000-0xfae7bfff]
[    0.158335] pci 0000:00:08.0: PME# supported from D3hot D3cold
[    0.158338] pci 0000:00:08.0: PME# disabled
[    0.158397] pci 0000:00:0b.0: reg 10: [io  0xa080-0xa087]
[    0.158402] pci 0000:00:0b.0: reg 14: [io  0xa000-0xa003]
[    0.158407] pci 0000:00:0b.0: reg 18: [io  0x9c00-0x9c07]
[    0.158411] pci 0000:00:0b.0: reg 1c: [io  0x9880-0x9883]
[    0.158416] pci 0000:00:0b.0: reg 20: [io  0x9800-0x980f]
[    0.158421] pci 0000:00:0b.0: reg 24: [mem 0xfae76000-0xfae77fff]
[    0.158630] pci 0000:00:0c.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.158638] pci 0000:00:0c.0: PME# disabled
[    0.158712] pci 0000:00:10.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.158715] pci 0000:00:10.0: PME# disabled
[    0.158911] pci 0000:00:15.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.158919] pci 0000:00:15.0: PME# disabled
[    0.159138] pci 0000:00:16.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.159146] pci 0000:00:16.0: PME# disabled
[    0.159364] pci 0000:00:17.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.159372] pci 0000:00:17.0: PME# disabled
[    0.159588] pci 0000:00:18.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.159596] pci 0000:00:18.0: PME# disabled
[    0.159691] pci 0000:00:09.0: PCI bridge to [bus 01-01] (subtractive decode)
[    0.159698] pci 0000:00:09.0:   bridge window [io  f000 - 0000] reg reading
[    0.159702] pci 0000:00:09.0:   bridge window [mem 0xfff00000 - 0x000fffff] reg reading
[    0.159706] pci 0000:00:09.0:   bridge window [mem 0xfff00000 - 000fffff pref] reg reading
[    0.159708] pci 0000:00:09.0:   bridge window [io  0x0000-0x0cf7] (subtractive decode)
[    0.159711] pci 0000:00:09.0:   bridge window [io  0x0d00-0xffff] (subtractive decode)
[    0.159714] pci 0000:00:09.0:   bridge window [mem 0x000a0000-0x000bffff] (subtractive decode)
[    0.159716] pci 0000:00:09.0:   bridge window [mem 0x000d0000-0x000dffff] (subtractive decode)
[    0.159719] pci 0000:00:09.0:   bridge window [mem 0x80000000-0xfbffffff] (subtractive decode)
[    0.159721] pci 0000:00:09.0:   bridge window [mem 0xfe000000-0xfebfffff] (subtractive decode)
[    0.159862] pci 0000:00:0c.0: PCI bridge to [bus 02-02]
[    0.159878] pci 0000:00:0c.0:   bridge window [io  f000 - 0000] reg reading
[    0.159886] pci 0000:00:0c.0:   bridge window [mem 0xfff00000 - 0x000fffff] reg reading
[    0.159901] pci 0000:00:0c.0:   bridge window [mem 0xfff00000 - 000fffff pref] reg reading
[    0.159949] pci 0000:03:00.0: reg 10: [mem 0xfb000000-0xfbffffff]
[    0.159958] pci 0000:03:00.0: reg 14: [mem 0xe0000000-0xefffffff 64bit pref]
[    0.159967] pci 0000:03:00.0: reg 1c: [mem 0xf4000000-0xf5ffffff 64bit pref]
[    0.159973] pci 0000:03:00.0: reg 24: [io  0xbc00-0xbc7f]
[    0.159979] pci 0000:03:00.0: reg 30: [mem 0xfafe0000-0xfaffffff pref]
[    0.160037] pci 0000:00:10.0: PCI bridge to [bus 03-03]
[    0.160043] pci 0000:00:10.0:   bridge window [io  0xb000-0xbfff]
[    0.160047] pci 0000:00:10.0:   bridge window [mem 0xfaf00000-0xfbffffff]
[    0.160052] pci 0000:00:10.0:   bridge window [mem 0xe0000000-0xf5ffffff 64bit pref]
[    0.160191] pci 0000:00:15.0: PCI bridge to [bus 04-06]
[    0.160207] pci 0000:00:15.0:   bridge window [io  0xc000-0xcfff]
[    0.160216] pci 0000:00:15.0:   bridge window [mem 0xfe000000-0xfe9fffff]
[    0.160230] pci 0000:00:15.0:   bridge window [mem 0xf6000000-0xf9efffff 64bit pref]
[    0.160395] pci 0000:07:00.0: reg 10: [io  0xd800-0xd8ff]
[    0.160412] pci 0000:07:00.0: reg 18: [mem 0xfeaff000-0xfeafffff 64bit]
[    0.160425] pci 0000:07:00.0: reg 20: [mem 0xf9ffc000-0xf9ffffff 64bit pref]
[    0.160433] pci 0000:07:00.0: reg 30: [mem 0x00000000-0x0001ffff pref]
[    0.160467] pci 0000:07:00.0: supports D1 D2
[    0.160469] pci 0000:07:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.160474] pci 0000:07:00.0: PME# disabled
[    0.160493] pci 0000:00:16.0: PCI bridge to [bus 07-07]
[    0.160509] pci 0000:00:16.0:   bridge window [io  0xd000-0xdfff]
[    0.160518] pci 0000:00:16.0:   bridge window [mem 0xfea00000-0xfeafffff]
[    0.160532] pci 0000:00:16.0:   bridge window [mem 0xf9f00000-0xf9ffffff 64bit pref]
[    0.160697] pci 0000:08:00.0: reg 10: [io  0xe800-0xe8ff]
[    0.160705] pci 0000:08:00.0: reg 14: [mem 0xfebfc000-0xfebfffff]
[    0.160759] pci 0000:08:00.0: supports D1 D2
[    0.160761] pci 0000:08:00.0: PME# supported from D0 D1 D2 D3hot
[    0.160765] pci 0000:08:00.0: PME# disabled
[    0.160780] pci 0000:00:17.0: PCI bridge to [bus 08-08]
[    0.160797] pci 0000:00:17.0:   bridge window [io  0xe000-0xefff]
[    0.160805] pci 0000:00:17.0:   bridge window [mem 0xfeb00000-0xfebfffff]
[    0.160819] pci 0000:00:17.0:   bridge window [mem 0xfff00000 - 000fffff pref] reg reading
[    0.160961] pci 0000:00:18.0: PCI bridge to [bus 09-09]
[    0.160977] pci 0000:00:18.0:   bridge window [io  f000 - 0000] reg reading
[    0.160986] pci 0000:00:18.0:   bridge window [mem 0xfff00000 - 0x000fffff] reg reading
[    0.161001] pci 0000:00:18.0:   bridge window [mem 0xfff00000 - 000fffff pref] reg reading
[    0.161070] pci_bus 0000:00: on NUMA node 0
[    0.161075] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.161343] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PBB0._PRT]
[    0.161501] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.IXVE._PRT]
[    0.161582] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.XVR0._PRT]
[    0.161698] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P7._PRT]
[    0.161797] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P8._PRT]
[    0.161898] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P9._PRT]
[    0.162004] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.NUCR._PRT]
[    0.182044] ACPI: PCI Interrupt Link [LNKA] (IRQs 16 17 18 19) *0, disabled.
[    0.182364] ACPI: PCI Interrupt Link [LNKB] (IRQs 16 17 18 19) *0, disabled.
[    0.182680] ACPI: PCI Interrupt Link [LNKC] (IRQs 16 17 18 19) *0, disabled.
[    0.182992] ACPI: PCI Interrupt Link [LNKD] (IRQs 16 17 18 19) *0, disabled.
[    0.183314] ACPI: PCI Interrupt Link [LN0A] (IRQs 16 17 18 19) *0, disabled.
[    0.183628] ACPI: PCI Interrupt Link [LN0B] (IRQs 16 17 18 19) *0, disabled.
[    0.183943] ACPI: PCI Interrupt Link [LN0C] (IRQs 16 17 18 19) *0, disabled.
[    0.184259] ACPI: PCI Interrupt Link [LN0D] (IRQs 16 17 18 19) *0, disabled.
[    0.184573] ACPI: PCI Interrupt Link [LN1A] (IRQs 16 17 18 19) *0, disabled.
[    0.184886] ACPI: PCI Interrupt Link [LN1B] (IRQs 16 17 18 19) *0, disabled.
[    0.185203] ACPI: PCI Interrupt Link [LN1C] (IRQs 16 17 18 19) *0, disabled.
[    0.185517] ACPI: PCI Interrupt Link [LN1D] (IRQs 16 17 18 19) *0, disabled.
[    0.185831] ACPI: PCI Interrupt Link [LN2A] (IRQs 16 17 18 19) *0, disabled.
[    0.186150] ACPI: PCI Interrupt Link [LN2B] (IRQs 16 17 18 19) *0, disabled.
[    0.186465] ACPI: PCI Interrupt Link [LN2C] (IRQs 16 17 18 19) *0, disabled.
[    0.186779] ACPI: PCI Interrupt Link [LN2D] (IRQs 16 17 18 19) *0, disabled.
[    0.187099] ACPI: PCI Interrupt Link [LN3A] (IRQs 16 17 18 19) *0, disabled.
[    0.187412] ACPI: PCI Interrupt Link [LN3B] (IRQs 16 17 18 19) *0, disabled.
[    0.187726] ACPI: PCI Interrupt Link [LN3C] (IRQs 16 17 18 19) *0, disabled.
[    0.188061] ACPI: PCI Interrupt Link [LN3D] (IRQs 16 17 18 19) *0, disabled.
[    0.188378] ACPI: PCI Interrupt Link [LN4A] (IRQs 16 17 18 19) *10
[    0.188690] ACPI: PCI Interrupt Link [LN4B] (IRQs 16 17 18 19) *0, disabled.
[    0.189006] ACPI: PCI Interrupt Link [LN4C] (IRQs 16 17 18 19) *0, disabled.
[    0.189318] ACPI: PCI Interrupt Link [LN4D] (IRQs 16 17 18 19) *0, disabled.
[    0.189634] ACPI: PCI Interrupt Link [LN5A] (IRQs 16 17 18 19) *9
[    0.189948] ACPI: PCI Interrupt Link [LN5B] (IRQs 16 17 18 19) *0, disabled.
[    0.190265] ACPI: PCI Interrupt Link [LN5C] (IRQs 16 17 18 19) *0, disabled.
[    0.190580] ACPI: PCI Interrupt Link [LN5D] (IRQs 16 17 18 19) *0, disabled.
[    0.190895] ACPI: PCI Interrupt Link [LN6A] (IRQs 16 17 18 19) *0, disabled.
[    0.191213] ACPI: PCI Interrupt Link [LN6B] (IRQs 16 17 18 19) *0, disabled.
[    0.191526] ACPI: PCI Interrupt Link [LN6C] (IRQs 16 17 18 19) *0, disabled.
[    0.191839] ACPI: PCI Interrupt Link [LN6D] (IRQs 16 17 18 19) *0, disabled.
[    0.192162] ACPI: PCI Interrupt Link [LUB0] (IRQs 20 21 22 23) *11
[    0.192479] ACPI: PCI Interrupt Link [LUB2] (IRQs 20 21 22 23) *11
[    0.192792] ACPI: PCI Interrupt Link [LMAC] (IRQs 20 21 22 23) *0, disabled.
[    0.193117] ACPI: PCI Interrupt Link [LAZA] (IRQs 20 21 22 23) *14
[    0.193437] ACPI: PCI Interrupt Link [SGRU] (IRQs 20 21 22 23) *10
[    0.193754] ACPI: PCI Interrupt Link [LSMB] (IRQs 20 21 22 23) *9
[    0.194079] ACPI: PCI Interrupt Link [LPMU] (IRQs 20 21 22 23) *15
[    0.194395] ACPI: PCI Interrupt Link [LSA0] (IRQs 20 21 22 23) *5
[    0.194761] ACPI: PCI Interrupt Link [LATA] (IRQs 20 21 22 23) *0, disabled.
[    0.195086] ACPI: PCI Interrupt Link [UB11] (IRQs 20 21 22 23) *11
[    0.195405] ACPI: PCI Interrupt Link [UB12] (IRQs 20 21 22 23) *11
[    0.195725] ACPI: PCI Interrupt Link [LRP0] (IRQs 20 21 22 23) *10
[    0.196044] ACPI: PCI Interrupt Link [LRP1] (IRQs 20 21 22 23) *0, disabled.
[    0.196358] ACPI: PCI Interrupt Link [LRP2] (IRQs 20 21 22 23) *0, disabled.
[    0.196678] ACPI: PCI Interrupt Link [LRP3] (IRQs 20 21 22 23) *9
[    0.196996] ACPI: PCI Interrupt Link [LRP4] (IRQs 20 21 22 23) *15
[    0.197315] ACPI: PCI Interrupt Link [LRP5] (IRQs 20 21 22 23) *14
[    0.197635] ACPI: PCI Interrupt Link [LRP6] (IRQs 20 21 22 23) *7
[    0.197822] vgaarb: device added: PCI:0000:03:00.0,decodes=io+mem,owns=io+mem,locks=none
[    0.197830] vgaarb: loaded
[    0.198055] SCSI subsystem initialized
[    0.198093] libata version 3.00 loaded.
[    0.198270] PCI: Using ACPI for IRQ routing
[    0.198343] PCI: pci_cache_line_size set to 64 bytes
[    0.198461] reserve RAM buffer: 000000000009e800 - 000000000009ffff 
[    0.198464] reserve RAM buffer: 000000006ffa0000 - 000000006fffffff 
[    0.198583] HPET: 4 timers in total, 0 timers will be used for per-cpu timer
[    0.199093] Switching to clocksource tsc
[    0.199171] pnp: PnP ACPI init
[    0.199180] ACPI: bus type pnp registered
[    0.209887] pnp: PnP ACPI: found 11 devices
[    0.209892] ACPI: ACPI bus type pnp unregistered
[    0.209906] system 00:04: [io  0x04d0-0x04d1] has been reserved
[    0.209911] system 00:04: [io  0x0800-0x080f] has been reserved
[    0.209916] system 00:04: [io  0x4000-0x407f] has been reserved
[    0.209921] system 00:04: [io  0x4080-0x40ff] has been reserved
[    0.209925] system 00:04: [io  0x4400-0x447f] has been reserved
[    0.209930] system 00:04: [io  0x4480-0x44ff] has been reserved
[    0.209934] system 00:04: [io  0x4800-0x487f] has been reserved
[    0.209939] system 00:04: [io  0x4880-0x48ff] has been reserved
[    0.209944] system 00:04: [mem 0x000d0000-0x000d3fff window] has been reserved
[    0.209950] system 00:04: [mem 0x000d4000-0x000d7fff window] has been reserved
[    0.209955] system 00:04: [mem 0x000de000-0x000dffff window] has been reserved
[    0.209961] system 00:04: [mem 0xfefe2000-0xfefe3fff] has been reserved
[    0.209966] system 00:04: [mem 0xfefe1000-0xfefe1fff] has been reserved
[    0.209971] system 00:04: [mem 0xfee01000-0xfeefffff] has been reserved
[    0.209980] system 00:08: [mem 0xfec00000-0xfec00fff] could not be reserved
[    0.209985] system 00:08: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.209992] system 00:09: [mem 0xfc000000-0xfdffffff] has been reserved
[    0.209999] system 00:0a: [mem 0x00000000-0x0009ffff] could not be reserved
[    0.210004] system 00:0a: [mem 0x000c0000-0x000cffff] could not be reserved
[    0.210009] system 00:0a: [mem 0x000e0000-0x000fffff] could not be reserved
[    0.210014] system 00:0a: [mem 0x00100000-0x7fffffff] could not be reserved
[    0.210019] system 00:0a: [mem 0xfec00000-0xffffffff] could not be reserved
[    0.245066] PCI: max bus depth: 1 pci_try_num: 2
[    0.245170] pci 0000:00:09.0: PCI bridge to [bus 01-01]
[    0.245175] pci 0000:00:09.0:   bridge window [io  disabled]
[    0.245181] pci 0000:00:09.0:   bridge window [mem disabled]
[    0.245186] pci 0000:00:09.0:   bridge window [mem pref disabled]
[    0.245194] pci 0000:00:0c.0: PCI bridge to [bus 02-02]
[    0.245197] pci 0000:00:0c.0:   bridge window [io  disabled]
[    0.245209] pci 0000:00:0c.0:   bridge window [mem disabled]
[    0.245219] pci 0000:00:0c.0:   bridge window [mem pref disabled]
[    0.245234] pci 0000:00:10.0: PCI bridge to [bus 03-03]
[    0.245239] pci 0000:00:10.0:   bridge window [io  0xb000-0xbfff]
[    0.245245] pci 0000:00:10.0:   bridge window [mem 0xfaf00000-0xfbffffff]
[    0.245251] pci 0000:00:10.0:   bridge window [mem 0xe0000000-0xf5ffffff 64bit pref]
[    0.245259] pci 0000:00:15.0: PCI bridge to [bus 04-06]
[    0.245266] pci 0000:00:15.0:   bridge window [io  0xc000-0xcfff]
[    0.245279] pci 0000:00:15.0:   bridge window [mem 0xfe000000-0xfe9fffff]
[    0.245289] pci 0000:00:15.0:   bridge window [mem 0xf6000000-0xf9efffff 64bit pref]
[    0.245307] pci 0000:07:00.0: BAR 6: assigned [mem 0xf9f00000-0xf9f1ffff pref]
[    0.245313] pci 0000:00:16.0: PCI bridge to [bus 07-07]
[    0.245320] pci 0000:00:16.0:   bridge window [io  0xd000-0xdfff]
[    0.245333] pci 0000:00:16.0:   bridge window [mem 0xfea00000-0xfeafffff]
[    0.245343] pci 0000:00:16.0:   bridge window [mem 0xf9f00000-0xf9ffffff 64bit pref]
[    0.245359] pci 0000:00:17.0: PCI bridge to [bus 08-08]
[    0.245366] pci 0000:00:17.0:   bridge window [io  0xe000-0xefff]
[    0.245379] pci 0000:00:17.0:   bridge window [mem 0xfeb00000-0xfebfffff]
[    0.245389] pci 0000:00:17.0:   bridge window [mem pref disabled]
[    0.245404] pci 0000:00:18.0: PCI bridge to [bus 09-09]
[    0.245408] pci 0000:00:18.0:   bridge window [io  disabled]
[    0.245420] pci 0000:00:18.0:   bridge window [mem disabled]
[    0.245429] pci 0000:00:18.0:   bridge window [mem pref disabled]
[    0.245449] pci 0000:00:09.0: setting latency timer to 64
[    0.245930] ACPI: PCI Interrupt Link [LRP0] enabled at IRQ 23
[    0.245940] pci 0000:00:0c.0: PCI INT A -> Link[LRP0] -> GSI 23 (level, low) -> IRQ 23
[    0.245952] pci 0000:00:0c.0: setting latency timer to 64
[    0.245961] pci 0000:00:10.0: setting latency timer to 64
[    0.246399] ACPI: PCI Interrupt Link [LRP3] enabled at IRQ 22
[    0.246407] pci 0000:00:15.0: PCI INT A -> Link[LRP3] -> GSI 22 (level, low) -> IRQ 22
[    0.246418] pci 0000:00:15.0: setting latency timer to 64
[    0.246856] ACPI: PCI Interrupt Link [LRP4] enabled at IRQ 21
[    0.246864] pci 0000:00:16.0: PCI INT A -> Link[LRP4] -> GSI 21 (level, low) -> IRQ 21
[    0.246879] pci 0000:00:16.0: setting latency timer to 64
[    0.247317] ACPI: PCI Interrupt Link [LRP5] enabled at IRQ 20
[    0.247325] pci 0000:00:17.0: PCI INT A -> Link[LRP5] -> GSI 20 (level, low) -> IRQ 20
[    0.247336] pci 0000:00:17.0: setting latency timer to 64
[    0.247773] ACPI: PCI Interrupt Link [LRP6] enabled at IRQ 23
[    0.247780] pci 0000:00:18.0: PCI INT A -> Link[LRP6] -> GSI 23 (level, low) -> IRQ 23
[    0.247791] pci 0000:00:18.0: setting latency timer to 64
[    0.247797] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
[    0.247800] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
[    0.247802] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
[    0.247805] pci_bus 0000:00: resource 7 [mem 0x000d0000-0x000dffff]
[    0.247807] pci_bus 0000:00: resource 8 [mem 0x80000000-0xfbffffff]
[    0.247809] pci_bus 0000:00: resource 9 [mem 0xfe000000-0xfebfffff]
[    0.247812] pci_bus 0000:01: resource 4 [io  0x0000-0x0cf7]
[    0.247814] pci_bus 0000:01: resource 5 [io  0x0d00-0xffff]
[    0.247816] pci_bus 0000:01: resource 6 [mem 0x000a0000-0x000bffff]
[    0.247818] pci_bus 0000:01: resource 7 [mem 0x000d0000-0x000dffff]
[    0.247820] pci_bus 0000:01: resource 8 [mem 0x80000000-0xfbffffff]
[    0.247823] pci_bus 0000:01: resource 9 [mem 0xfe000000-0xfebfffff]
[    0.247825] pci_bus 0000:03: resource 0 [io  0xb000-0xbfff]
[    0.247827] pci_bus 0000:03: resource 1 [mem 0xfaf00000-0xfbffffff]
[    0.247830] pci_bus 0000:03: resource 2 [mem 0xe0000000-0xf5ffffff 64bit pref]
[    0.247832] pci_bus 0000:04: resource 0 [io  0xc000-0xcfff]
[    0.247834] pci_bus 0000:04: resource 1 [mem 0xfe000000-0xfe9fffff]
[    0.247837] pci_bus 0000:04: resource 2 [mem 0xf6000000-0xf9efffff 64bit pref]
[    0.247839] pci_bus 0000:07: resource 0 [io  0xd000-0xdfff]
[    0.247842] pci_bus 0000:07: resource 1 [mem 0xfea00000-0xfeafffff]
[    0.247844] pci_bus 0000:07: resource 2 [mem 0xf9f00000-0xf9ffffff 64bit pref]
[    0.247846] pci_bus 0000:08: resource 0 [io  0xe000-0xefff]
[    0.247849] pci_bus 0000:08: resource 1 [mem 0xfeb00000-0xfebfffff]
[    0.247883] NET: Registered protocol family 2
[    0.247916] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.248036] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.248475] TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
[    0.248798] TCP: Hash tables configured (established 131072 bind 65536)
[    0.248803] TCP reno registered
[    0.248808] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    0.248823] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    0.248959] NET: Registered protocol family 1
[    0.313105] pci 0000:03:00.0: Boot video device
[    0.313114] PCI: CLS 64 bytes, default 64
[    0.313168] Trying to unpack rootfs image as initramfs...
[    0.376118] Freeing initrd memory: 2475k freed
[    0.378378] highmem bounce pool size: 64 pages
[    0.378620] msgmni has been set to 1734
[    0.378647] io scheduler noop registered
[    0.378650] io scheduler deadline registered
[    0.378662] io scheduler cfq registered (default)
[    0.378789] pcieport 0000:00:0c.0: setting latency timer to 64
[    0.378927] pcieport 0000:00:0c.0: irq 24 for MSI/MSI-X
[    0.379108] pcieport 0000:00:15.0: setting latency timer to 64
[    0.379235] pcieport 0000:00:15.0: irq 25 for MSI/MSI-X
[    0.379405] pcieport 0000:00:16.0: setting latency timer to 64
[    0.379532] pcieport 0000:00:16.0: irq 26 for MSI/MSI-X
[    0.379703] pcieport 0000:00:17.0: setting latency timer to 64
[    0.379830] pcieport 0000:00:17.0: irq 27 for MSI/MSI-X
[    0.380020] pcieport 0000:00:18.0: setting latency timer to 64
[    0.380148] pcieport 0000:00:18.0: irq 28 for MSI/MSI-X
[    0.380825] vesafb: framebuffer at 0xf5000000, mapped to 0xf8080000, using 3072k, total 14336k
[    0.380833] vesafb: mode is 1024x768x16, linelength=2048, pages=1
[    0.380837] vesafb: protected mode interface info at c000:c950
[    0.380841] vesafb: pmi: set display start = c00cc9b3, set palette = c00cca0e
[    0.380846] vesafb: pmi: ports = 3b4 3b5 3ba 3c0 3c1 3c4 3c5 3c6 3c7 3c8 3c9 3cc 3ce 3cf 3d0 3d1 3d2 3d3 3d4 3d5 3da 
[    0.380863] vesafb: scrolling: redraw
[    0.380867] vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
[    0.393804] Console: switching to colour frame buffer device 128x48
[    0.406707] fb0: VESA VGA frame buffer device
[    0.410350] brd: module loaded
[    0.410587] ahci 0000:00:0b.0: version 3.0
[    0.411107] ACPI: PCI Interrupt Link [LSA0] enabled at IRQ 22
[    0.411254] ahci 0000:00:0b.0: PCI INT A -> Link[LSA0] -> GSI 22 (level, low) -> IRQ 22
[    0.411495] ahci 0000:00:0b.0: irq 29 for MSI/MSI-X
[    0.411584] ahci 0000:00:0b.0: AHCI 0001.0200 32 slots 6 ports 3 Gbps 0x7 impl SATA mode
[    0.411784] ahci 0000:00:0b.0: flags: 64bit ncq sntf led pmp pio slum part sxs 
[    0.412000] ahci 0000:00:0b.0: setting latency timer to 64
[    0.412392] scsi0 : ahci
[    0.412564] scsi1 : ahci
[    0.412686] scsi2 : ahci
[    0.412808] scsi3 : ahci
[    0.412937] scsi4 : ahci
[    0.413057] scsi5 : ahci
[    0.413306] ata1: SATA max UDMA/133 abar m8192@0xfae76000 port 0xfae76100 irq 29
[    0.413489] ata2: SATA max UDMA/133 abar m8192@0xfae76000 port 0xfae76180 irq 29
[    0.413671] ata3: SATA max UDMA/133 abar m8192@0xfae76000 port 0xfae76200 irq 29
[    0.413852] ata4: DUMMY
[    0.413918] ata5: DUMMY
[    0.413978] ata6: DUMMY
[    0.414471] sky2: driver version 1.27
[    0.414694] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[    0.415334] ACPI: PCI Interrupt Link [LN4A] enabled at IRQ 19
[    0.415483] r8169 0000:07:00.0: PCI INT A -> Link[LN4A] -> GSI 19 (level, low) -> IRQ 19
[    0.415715] r8169 0000:07:00.0: setting latency timer to 64
[    0.415758] r8169 0000:07:00.0: irq 30 for MSI/MSI-X
[    0.415899] r8169 0000:07:00.0: eth0: RTL8168d/8111d at 0xf803c000, 40:61:86:34:a7:05, XID 081000c0 IRQ 30
[    0.462998] video1394: Installed video1394 module
[    0.467614] ieee1394: raw1394: /dev/raw1394 device initialized
[    0.472360] PNP: No PS/2 controller found. Probing ports directly.
[    0.478993] drivers/input/serio/i8042.c: 20 -> i8042 (command) [2]
[    0.478993] drivers/input/serio/i8042.c: 65 <- i8042 (return) [2]
[    0.482998] drivers/input/serio/i8042.c: 20 -> i8042 (command) [3]
[    0.482998] drivers/input/serio/i8042.c: 65 <- i8042 (return) [3]
[    0.488026] drivers/input/serio/i8042.c: 60 -> i8042 (command) [5]
[    0.488026] drivers/input/serio/i8042.c: 74 -> i8042 (parameter) [5]
[    0.494001] drivers/input/serio/i8042.c: d3 -> i8042 (command) [8]
[    0.494001] drivers/input/serio/i8042.c: 5a -> i8042 (parameter) [8]
[    0.494001] drivers/input/serio/i8042.c: 5a <- i8042 (return) [8]
[    0.500931] drivers/input/serio/i8042.c: a7 -> i8042 (command) [9]
[    0.502950] drivers/input/serio/i8042.c: 20 -> i8042 (command) [10]
[    0.502950] drivers/input/serio/i8042.c:      -- i8042 (timeout) [10]
[   11.045100] Failed to disable AUX port, but continuing anyway... Is this a SiS?
[   11.049741] If AUX port is really absent please use the 'i8042.noaux' option.
[   11.055417] drivers/input/serio/i8042.c: a8 -> i8042 (command) [13]
[   11.057436] drivers/input/serio/i8042.c: 20 -> i8042 (command) [14]
[   11.057436] drivers/input/serio/i8042.c:      -- i8042 (timeout) [14]
[   21.595388] drivers/input/serio/i8042.c: 60 -> i8042 (command) [15]
[   21.595388] drivers/input/serio/i8042.c: 65 -> i8042 (parameter) [15]
[   21.599402] drivers/input/serio/i8042.c: 74 <- i8042 (interrupt, 0, 1) [16]
[   21.600360] serio: i8042 KBD port at 0x60,0x64 irq 1
[   21.605145] mice: PS/2 mouse device common for all mice
[   21.609900] drivers/input/serio/i8042.c: f2 -> i8042 (kbd-data) [20]
[   21.613078] drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [22]
[   21.614117] cpuidle: using governor ladder
[   21.618766] TCP cubic registered
[   21.623340] NET: Registered protocol family 17
[   21.627931] p4-clockmod: Warning: EST-capable CPU detected. The acpi-cpufreq module offers voltage scaling in addition of frequency scaling. You should use that instead of p4-clockmod, if possible.
[   21.637803] p4-clockmod: Warning: EST-capable CPU detected. The acpi-cpufreq module offers voltage scaling in addition of frequency scaling. You should use that instead of p4-clockmod, if possible.
[   21.648430] Using IPI No-Shortcut mode
[   21.881598] ata3: SATA link down (SStatus 0 SControl 300)
[   22.035842] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   22.041118] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   22.050598] ata2.00: ATAPI: HL-DT-STDVDRAM GT30N, AS02, max UDMA/100, ATAPI AN
[   22.059619] ata2.00: configured for UDMA/100
[   22.166140] drivers/input/serio/i8042.c: ed -> i8042 (kbd-data) [523]
[   22.168284] drivers/input/serio/i8042.c: ab <- i8042 (interrupt, 0, 1) [525]
[   22.227002] drivers/input/serio/i8042.c: 60 -> i8042 (command) [21806]
[   22.227002] drivers/input/serio/i8042.c: 64 -> i8042 (parameter) [21806]
[   22.231303] drivers/input/serio/i8042.c: 41 <- i8042 (interrupt, 0, 1) [21810]
[   22.232472] ata1.00: qc timeout (cmd 0xec)
[   22.233254] drivers/input/serio/i8042.c: 60 -> i8042 (command) [21812]
[   22.233254] drivers/input/serio/i8042.c: 65 -> i8042 (parameter) [21812]
[   22.237498] drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [21816]
[   22.244526] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[   22.707134] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   22.713043] ata1.00: ATA-8: WDC WD5000AAVS-22G9B1, 05.04C05, max UDMA/133
[   22.718268] ata1.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[   22.724209] ata1.00: configured for UDMA/133
[   22.729481] scsi 0:0:0:0: Direct-Access     ATA      WDC WD5000AAVS-2 05.0 PQ: 0 ANSI: 5
[   22.734919] sd 0:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/465 GiB)
[   22.740244] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   22.740271] sd 0:0:0:0: [sda] Write Protect is off
[   22.740273] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   22.740291] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   22.740394]  sda:
[   22.758637] scsi 1:0:0:0: CD-ROM            HL-DT-ST DVDRAM GT30N     AS02 PQ: 0 ANSI: 5
[   22.769398]  sda1 sda2 sda3 sda4 <sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
[   22.783500] Uniform CD-ROM driver Revision: 3.20
[   22.784132]  sda5
[   22.789463] sr 1:0:0:0: Attached scsi CD-ROM sr0
[   22.795301] sr 1:0:0:0: Attached scsi generic sg1 type 5
[   22.801130]  sda6 sda7 sda8 sda9 >
[   22.829519] sd 0:0:0:0: [sda] Attached SCSI disk
[   22.835504] Freeing unused kernel memory: 312k freed
[   22.841636] Write protecting the kernel text: 2532k
[   22.847716] Write protecting the kernel read-only data: 972k
[   23.408685] usbcore: registered new interface driver usbfs
[   23.414963] usbcore: registered new interface driver hub
[   23.421039] usbcore: registered new device driver usb
[   23.428807] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   23.430820] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   23.431469] ACPI: PCI Interrupt Link [LUB0] enabled at IRQ 21
[   23.431474] ohci_hcd 0000:00:04.0: PCI INT A -> Link[LUB0] -> GSI 21 (level, low) -> IRQ 21
[   23.431494] ohci_hcd 0000:00:04.0: setting latency timer to 64
[   23.431497] ohci_hcd 0000:00:04.0: OHCI Host Controller
[   23.431520] ohci_hcd 0000:00:04.0: new USB bus registered, assigned bus number 1
[   23.431544] ohci_hcd 0000:00:04.0: irq 21, io mem 0xfae7f000
[   23.469763] Warning! ehci_hcd should always be loaded before uhci_hcd and ohci_hcd, not after
[   23.484033] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
[   23.489538] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   23.494868] usb usb1: Product: OHCI Host Controller
[   23.500223] usb usb1: Manufacturer: Linux 2.6.34-rc2 ohci_hcd
[   23.505527] usb usb1: SerialNumber: 0000:00:04.0
[   23.511592] hub 1-0:1.0: USB hub found
[   23.517067] hub 1-0:1.0: 6 ports detected
[   23.523166] ACPI: PCI Interrupt Link [LUB2] enabled at IRQ 20
[   23.528602] ehci_hcd 0000:00:04.1: PCI INT B -> Link[LUB2] -> GSI 20 (level, low) -> IRQ 20
[   23.534213] ehci_hcd 0000:00:04.1: setting latency timer to 64
[   23.534217] ehci_hcd 0000:00:04.1: EHCI Host Controller
[   23.539615] ehci_hcd 0000:00:04.1: new USB bus registered, assigned bus number 2
[   23.544930] ehci_hcd 0000:00:04.1: debug port 1
[   23.550328] ehci_hcd 0000:00:04.1: cache line size of 64 is not supported
[   23.550346] ehci_hcd 0000:00:04.1: irq 20, io mem 0xfae7ec00
[   23.561131] ehci_hcd 0000:00:04.1: USB 2.0 started, EHCI 1.00
[   23.566426] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[   23.571561] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   23.576795] usb usb2: Product: EHCI Host Controller
[   23.582085] usb usb2: Manufacturer: Linux 2.6.34-rc2 ehci_hcd
[   23.587364] usb usb2: SerialNumber: 0000:00:04.1
[   23.592544] hub 2-0:1.0: USB hub found
[   23.597659] hub 2-0:1.0: 6 ports detected
[   23.603187] ACPI: PCI Interrupt Link [UB11] enabled at IRQ 23
[   23.608122] ohci_hcd 0000:00:06.0: PCI INT A -> Link[UB11] -> GSI 23 (level, low) -> IRQ 23
[   23.613171] ohci_hcd 0000:00:06.0: setting latency timer to 64
[   23.613174] ohci_hcd 0000:00:06.0: OHCI Host Controller
[   23.618210] ohci_hcd 0000:00:06.0: new USB bus registered, assigned bus number 3
[   23.623308] ohci_hcd 0000:00:06.0: irq 23, io mem 0xfae7d000
[   23.681149] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
[   23.686277] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   23.691306] usb usb3: Product: OHCI Host Controller
[   23.696257] usb usb3: Manufacturer: Linux 2.6.34-rc2 ohci_hcd
[   23.701248] usb usb3: SerialNumber: 0000:00:06.0
[   23.706311] hub 3-0:1.0: USB hub found
[   23.711396] hub 3-0:1.0: 6 ports detected
[   23.716964] ACPI: PCI Interrupt Link [UB12] enabled at IRQ 22
[   23.722186] ehci_hcd 0000:00:06.1: PCI INT B -> Link[UB12] -> GSI 22 (level, low) -> IRQ 22
[   23.730342] ehci_hcd 0000:00:06.1: setting latency timer to 64
[   23.730346] ehci_hcd 0000:00:06.1: EHCI Host Controller
[   23.735671] ehci_hcd 0000:00:06.1: new USB bus registered, assigned bus number 4
[   23.740841] ehci_hcd 0000:00:06.1: debug port 1
[   23.745912] ehci_hcd 0000:00:06.1: cache line size of 64 is not supported
[   23.745932] ehci_hcd 0000:00:06.1: irq 22, io mem 0xfae7e800
[   23.757131] ehci_hcd 0000:00:06.1: USB 2.0 started, EHCI 1.00
[   23.762136] usb usb4: New USB device found, idVendor=1d6b, idProduct=0002
[   23.767071] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   23.771969] usb usb4: Product: EHCI Host Controller
[   23.776832] usb usb4: Manufacturer: Linux 2.6.34-rc2 ehci_hcd
[   23.781687] usb usb4: SerialNumber: 0000:00:06.1
[   23.786569] hub 4-0:1.0: USB hub found
[   23.791512] hub 4-0:1.0: 6 ports detected
[   23.908062] usb 2-2: new high speed USB device using ehci_hcd and address 2
[   24.014932] kjournald starting.  Commit interval 5 seconds
[   24.014937] EXT3-fs (sda5): mounted filesystem with writeback data mode
[   24.220570] usb 2-2: New USB device found, idVendor=5986, idProduct=0241
[   24.225410] usb 2-2: New USB device strings: Mfr=3, Product=1, SerialNumber=0
[   24.230264] usb 2-2: Product: BisonCam, NB Pro
[   24.235039] usb 2-2: Manufacturer: BISON Corporation
[   24.633013] usb 3-1: new low speed USB device using ohci_hcd and address 2
[   24.781377] usb 3-1: New USB device found, idVendor=04d9, idProduct=2519
[   24.786343] usb 3-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[   25.026016] usb 3-2: new full speed USB device using ohci_hcd and address 3
[   25.287555] usb 3-2: New USB device found, idVendor=0408, idProduct=3001
[   25.293037] usb 3-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[   25.298764] usb 3-2: Product: Optical Touch Screen
[   25.304559] usb 3-2: Manufacturer: PixArt Imaging Inc.
[   26.168745] input: HID 04d9:2519 as /class/input/input0
[   26.175075] i2c-core: driver [dummy] registered
[   26.175208] generic-usb 0003:04D9:2519.0001: input: USB HID v1.10 Keyboard [HID 04d9:2519] on usb-0000:00:06.0-1/input0
[   26.236029] input: HID 04d9:2519 as /class/input/input1
[   26.255179] input: Power Button as /class/input/input2
[   26.265946] ACPI: Power Button [PWRB]
[   26.276115] i2c i2c-0: adapter [SMBus nForce2 adapter at 4d00] registered
[   26.276121] i2c i2c-0: nForce2 SMBus adapter at 0x4d00
[   26.282097] ACPI: I/O resource nForce2_smbus [0x4e00-0x4e3f] conflicts with ACPI region SM00 [0x4e00-0x4e3f]
[   26.288239] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[   26.294517] nForce2_smbus 0000:00:03.2: Error probing SMB2.
[   26.299681] Linux video capture interface: v2.00
[   26.302927] uvcvideo: Found UVC 1.00 device BisonCam, NB Pro (5986:0241)
[   26.306190] input: BisonCam, NB Pro as /class/input/input3
[   26.306230] usbcore: registered new interface driver uvcvideo
[   26.306232] USB Video Class driver (v0.1.0)
[   26.345098] input: Power Button as /class/input/input4
[   26.362216] generic-usb 0003:04D9:2519.0002: input: USB HID v1.10 Mouse [HID 04d9:2519] on usb-0000:00:06.0-1/input1
[   26.409068] ACPI: Power Button [PWRF]
[   26.423234] usbcore: registered new interface driver usbhid
[   26.430275] usbhid: USB HID core driver
[   26.580459] rtc_cmos 00:06: RTC can wake from S4
[   26.637176] ACPI: WMI: Skipping duplicate GUID 05901221-D566-11D1-B2F0-00A0C9062910
[   26.653866] rtc_cmos 00:06: rtc core: registered rtc_cmos as rtc0
[   26.674496] ACPI: WMI: Mapper loaded
[   26.713168] rtc0: alarms up to one year, y3k, 114 bytes nvram, hpet irqs
[   26.754994] [Firmware Bug]: ACPI(IGPU) defines _DOD but not _DOS
[   26.815169] HDA Intel 0000:00:08.0: power state changed by ACPI to D0
[   26.830206] input: Video Bus as /class/input/input5
[   26.888482] ACPI: PCI Interrupt Link [LAZA] enabled at IRQ 21
[   26.895450] HDA Intel 0000:00:08.0: PCI INT A -> Link[LAZA] -> GSI 21 (level, low) -> IRQ 21
[   26.917078] ACPI: Video Device [IGPU] (multi-head: yes  rom: no  post: no)
[   27.034044] hda_intel: Disable MSI for Nvidia chipset
[   27.053031] input: MSI WMI hotkeys as /class/input/input6
[   27.116052] HDA Intel 0000:00:08.0: setting latency timer to 64
[   27.138408] msi-wmi: get: Invalid brightness value: 0x6F
[   27.281219] input: MSI WMI hotkeys as /class/input/input7
[   27.296537] msi-wmi: get: Invalid brightness value: 0x6F
[   36.958077] drivers/hid/usbhid/hid-core.c: usb_submit_urb(ctrl) failed
[   36.965155] quanta-touch 0003:0408:3001.0003: timeout initializing reports
[   36.972308] input: PixArt Imaging Inc. Optical Touch Screen as /class/input/input8
[   36.979429] quanta-touch 0003:0408:3001.0003: input: USB HID v1.10 Device [PixArt Imaging Inc. Optical Touch Screen] on usb-0000:00:06.0-2/input0
[   37.301030] Adding 1020092k swap on /dev/sda6.  Priority:-1 extents:1 across:1020092k 
[   39.938478] usbcore: registered new interface driver snd-usb-audio
[   40.015486] device-mapper: ioctl: 4.17.0-ioctl (2010-03-05) initialised: dm-devel@redhat.com
[   40.358848] kjournald starting.  Commit interval 5 seconds
[   40.359007] EXT3-fs (sda7): using internal journal
[   40.359012] EXT3-fs (sda7): mounted filesystem with writeback data mode
[   40.375443] kjournald starting.  Commit interval 5 seconds
[   40.375603] EXT3-fs (sda8): using internal journal
[   40.375607] EXT3-fs (sda8): mounted filesystem with writeback data mode
[   40.384149] kjournald starting.  Commit interval 5 seconds
[   40.384390] EXT3-fs (sda9): using internal journal
[   40.384394] EXT3-fs (sda9): mounted filesystem with writeback data mode
[   40.868888] r8169 0000:07:00.0: eth0: link up
[   40.868893] r8169 0000:07:00.0: eth0: link up
[   46.775524] Bluetooth: Core ver 2.15
[   46.775570] NET: Registered protocol family 31
[   46.775572] Bluetooth: HCI device and connection manager initialized
[   46.775576] Bluetooth: HCI socket layer initialized
[   46.810160] Bluetooth: L2CAP ver 2.14
[   46.810163] Bluetooth: L2CAP socket layer initialized
[   46.817502] Bluetooth: RFCOMM TTY layer initialized
[   46.817506] Bluetooth: RFCOMM socket layer initialized
[   46.817508] Bluetooth: RFCOMM ver 1.11
