From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: Re: Crash caused by hid-rmi and no longer working touchscreen
Date: Mon, 10 Apr 2017 15:15:30 +0200
Message-ID: <29f37537-32d9-fc09-9e06-7369400d67bb@gmail.com>
References: <b79b88c8-770a-13f6-5668-c3a94254e5e0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36000 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752877AbdDJNPf (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 10 Apr 2017 09:15:35 -0400
In-Reply-To: <b79b88c8-770a-13f6-5668-c3a94254e5e0@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: aduggan@synaptics.com, jkosina@suse.cz, benjamin.tissoires@redhat.com
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

Here the full log showing the errors up to the crash:

Gabriele

[    0.000000] Linux version 4.11.0-rc6 (gabriele@xps13) (gcc version 6.3.0 20170406 (Debian 6.3.0-12) ) #3 SMP Mon Apr 10 14:54:58 CEST 2017
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-4.11.0-rc6 root=/dev/sda6 ro quiet rootfstype=ext4 resume=/dev/sda3 possible_cpus=4 i915.lvds_downclock=1 workqueue.power_efficient
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000057fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000058000-0x0000000000058fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000059000-0x000000000009cfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009d000-0x00000000000bffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000008034bfff] usable
[    0.000000] BIOS-e820: [mem 0x000000008034c000-0x000000008054dfff] reserved
[    0.000000] BIOS-e820: [mem 0x000000008054e000-0x00000000dad7dfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000dad7e000-0x00000000daf7dfff] type 20
[    0.000000] BIOS-e820: [mem 0x00000000daf7e000-0x00000000dceb5fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000dceb6000-0x00000000dcf9efff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000dcf9f000-0x00000000dcffefff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000dcfff000-0x00000000dcffffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000dd000000-0x00000000df9fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f80f8000-0x00000000f80f8fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fe101000-0x00000000fe112fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000021f5fffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.31 by Phoenix Technologies Ltd.
[    0.000000] efi:  ACPI=0xdcffe000  ACPI 2.0=0xdcffe014  SMBIOS=0xdcc0c000 
[    0.000000] efi: [Firmware Bug]: Invalid EFI memory map entries:
[    0.000000] efi: mem42: [Reserved           |   |  |  |  |  |  |  |   |  |  |  |  ] range=[0x0000000000000000-0x0000000000000000] (invalid)
[    0.000000] efi: mem43: [Reserved           |   |  |  |  |  |  |  |   |  |  |  |  ] range=[0x0000000000000000-0x0000000000000000] (invalid)
[    0.000000] efi: mem44: [Reserved           |   |  |  |  |  |  |  |   |  |  |  |  ] range=[0x0000000000000000-0x0000000000000000] (invalid)
[    0.000000] efi: mem45: [Reserved           |   |  |  |  |  |  |  |   |  |  |  |  ] range=[0x0000000000000000-0x0000000000000000] (invalid)
[    0.000000] efi: mem46: [Reserved           |   |  |  |  |  |  |  |   |  |  |  |  ] range=[0x0000000000000000-0x0000000000000000] (invalid)
[    0.000000] efi: Removing 5 invalid memory map entries.
[    0.000000] SMBIOS 2.7 present.
[    0.000000] DMI: Dell Inc. XPS13 9333/0HP75V, BIOS A07 03/27/2015
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x21f600 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: write-back
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 00E0000000 mask 7FE0000000 uncachable
[    0.000000]   1 base 00DE000000 mask 7FFE000000 uncachable
[    0.000000]   2 base 00DD000000 mask 7FFF000000 uncachable
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000]   8 disabled
[    0.000000]   9 disabled
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- WT  
[    0.000000] e820: last_pfn = 0xdd000 max_arch_pfn = 0x400000000
[    0.000000] Base memory trampoline at [ffff880000097000] 97000 size 24576
[    0.000000] Using GB pages for direct mapping
[    0.000000] BRK [0x0270f000, 0x0270ffff] PGTABLE
[    0.000000] BRK [0x02710000, 0x02710fff] PGTABLE
[    0.000000] BRK [0x02711000, 0x02711fff] PGTABLE
[    0.000000] BRK [0x02712000, 0x02712fff] PGTABLE
[    0.000000] BRK [0x02713000, 0x02713fff] PGTABLE
[    0.000000] BRK [0x02714000, 0x02714fff] PGTABLE
[    0.000000] Secure boot could not be determined
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000DCFFE014 000024 (v02 DELL  )
[    0.000000] ACPI: XSDT 0x00000000DCFFE170 0000C4 (v01 DELL   QA09     00000002 LOHR 00000002)
[    0.000000] ACPI: FACP 0x00000000DCFFB000 00010C (v05 DELL   QA09     00000002 LOHR 00000002)
[    0.000000] ACPI: DSDT 0x00000000DCFE6000 010655 (v02 DELL   HSW-LPT  00000000 INTL 20120711)
[    0.000000] ACPI: FACS 0x00000000DCF9C000 000040
[    0.000000] ACPI: ASF! 0x00000000DCFFD000 0000A5 (v32 DELL   QA09     00000002 LOHR 00000002)
[    0.000000] ACPI: HPET 0x00000000DCFFA000 000038 (v01 DELL   QA09     00000002 LOHR 00000002)
[    0.000000] ACPI: LPIT 0x00000000DCFF9000 000094 (v01 DELL   QA09     00000002 LOHR 00000002)
[    0.000000] ACPI: APIC 0x00000000DCFF8000 000098 (v01 DELL   QA09     00000002 LOHR 00000002)
[    0.000000] ACPI: MCFG 0x00000000DCFF7000 00003C (v01 DELL   QA09     00000002 LOHR 00000002)
[    0.000000] ACPI: SSDT 0x00000000DCFE5000 000228 (v01 DELL   sensrhub 00000000 INTL 20120711)
[    0.000000] ACPI: SSDT 0x00000000DCFE2000 002028 (v01 DELL   PtidDevc 00001000 INTL 20120711)
[    0.000000] ACPI: SSDT 0x00000000DCFE1000 000539 (v01 DELL   Cpu0Ist  00003000 INTL 20120711)
[    0.000000] ACPI: SSDT 0x00000000DCFE0000 000AD8 (v01 DELL   CpuPm    00003000 INTL 20120711)
[    0.000000] ACPI: SSDT 0x00000000DCFDC000 003688 (v01 DELL   SaSsdt   00003000 INTL 20120711)
[    0.000000] ACPI: UEFI 0x00000000DCFDB000 000042 (v01 DELL   QA09     00000002 LOHR 00000002)
[    0.000000] ACPI: POAT 0x00000000DCF77000 000055 (v03 DELL   QA09     00000002 LOHR 00000002)
[    0.000000] ACPI: BATB 0x00000000DCFDA000 000046 (v01 DELL   QA09     00000002 LOHR 00000002)
[    0.000000] ACPI: FPDT 0x00000000DCFD9000 000064 (v01 DELL   QA09     00000002 LOHR 00000002)
[    0.000000] ACPI: SLIC 0x00000000DCFD8000 000176 (v01 DELL   QA09     00000002 LOHR 00000002)
[    0.000000] ACPI: UEFI 0x00000000DCFD7000 0002A6 (v01 DELL   QA09     00000002 LOHR 00000002)
[    0.000000] ACPI: SSDT 0x00000000DCFD6000 0000D0 (v01 DELL   IffsAsl  00003000 INTL 20120711)
[    0.000000] ACPI: BGRT 0x00000000DCFD5000 000038 (v01 DELL   QA09     00000002 LOHR 00000002)
[    0.000000] ACPI: CSRT 0x00000000DCFD4000 0000C4 (v01 DELL   QA09     00000002 LOHR 00000002)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000021f5fffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x21f5f8000-0x21f5fbfff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000021f5fffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x0000000000057fff]
[    0.000000]   node   0: [mem 0x0000000000059000-0x000000000009cfff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x000000008034bfff]
[    0.000000]   node   0: [mem 0x000000008054e000-0x00000000dad7dfff]
[    0.000000]   node   0: [mem 0x00000000dcfff000-0x00000000dcffffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000021f5fffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000021f5fffff]
[    0.000000] On node 0 totalpages: 2072856
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 22 pages reserved
[    0.000000]   DMA zone: 3995 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 13934 pages used for memmap
[    0.000000]   DMA32 zone: 891773 pages, LIFO batch:31
[    0.000000]   Normal zone: 18392 pages used for memmap
[    0.000000]   Normal zone: 1177088 pages, LIFO batch:31
[    0.000000] Reserving Intel graphics memory at 0x00000000dda00000-0x00000000df9fffff
[    0.000000] ACPI: PM-Timer IO Port: 0x1808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-39
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a301 base: 0xfed00000
[    0.000000] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x00058000-0x00058fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009d000-0x000bffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000c0000-0x000dffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000e0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0x8034c000-0x8054dfff]
[    0.000000] PM: Registered nosave memory: [mem 0xdad7e000-0xdaf7dfff]
[    0.000000] PM: Registered nosave memory: [mem 0xdaf7e000-0xdceb5fff]
[    0.000000] PM: Registered nosave memory: [mem 0xdceb6000-0xdcf9efff]
[    0.000000] PM: Registered nosave memory: [mem 0xdcf9f000-0xdcffefff]
[    0.000000] PM: Registered nosave memory: [mem 0xdd000000-0xdf9fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xdfa00000-0xf80f7fff]
[    0.000000] PM: Registered nosave memory: [mem 0xf80f8000-0xf80f8fff]
[    0.000000] PM: Registered nosave memory: [mem 0xf80f9000-0xfe100fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfe101000-0xfe112fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfe113000-0xfed1bfff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed1c000-0xfed1ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed20000-0xffffffff]
[    0.000000] e820: [mem 0xdfa00000-0xf80f7fff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.000000] setup_percpu: NR_CPUS:4 nr_cpumask_bits:4 nr_cpu_ids:4 nr_node_ids:1
[    0.000000] percpu: Embedded 37 pages/cpu @ffff88021f200000 s113944 r8192 d29416 u524288
[    0.000000] pcpu-alloc: s113944 r8192 d29416 u524288 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 2040444
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-4.11.0-rc6 root=/dev/sda6 ro quiet rootfstype=ext4 resume=/dev/sda3 possible_cpus=4 i915.lvds_downclock=1 workqueue.power_efficient
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 8009944K/8291424K available (8205K kernel code, 1070K rwdata, 2596K rodata, 1452K init, 564K bss, 281480K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 64.
[    0.000000] NR_IRQS:4352 nr_irqs:728 16
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.004000] tsc: Detected 2394.382 MHz processor
[    0.004000] Calibrating delay loop (skipped), value calculated using timer frequency.. 4788.76 BogoMIPS (lpj=9577528)
[    0.004000] pid_max: default: 32768 minimum: 301
[    0.004000] ACPI: Core revision 20170119
[    0.020880] ACPI: 7 ACPI AML tables successfully acquired and loaded
[    0.028028] Security Framework initialized
[    0.028030] Yama: becoming mindful.
[    0.028037] AppArmor: AppArmor disabled by boot time parameter
[    0.028451] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.030342] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.031192] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.031200] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.031431] CPU: Physical Processor ID: 0
[    0.031431] CPU: Processor Core ID: 0
[    0.031436] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.031437] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[    0.031441] mce: CPU supports 7 MCE banks
[    0.031451] CPU0: Thermal monitoring enabled (TM1)
[    0.031465] process: using mwait in idle threads
[    0.031468] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 1024
[    0.031469] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 1024, 1GB 4
[    0.031633] Freeing SMP alternatives memory: 32K
[    0.034670] ftrace: allocating 31597 entries in 124 pages
[    0.044061] smpboot: Max logical packages: 4
[    0.044657] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.086889] TSC deadline timer enabled
[    0.086891] smpboot: CPU0: Intel(R) Core(TM) i7-4500U CPU @ 1.80GHz (family: 0x6, model: 0x45, stepping: 0x1)
[    0.086950] Performance Events: PEBS fmt2+, Haswell events, 16-deep LBR, full-width counters, Intel PMU driver.
[    0.086996] ... version:                3
[    0.086996] ... bit width:              48
[    0.086997] ... generic registers:      4
[    0.086998] ... value mask:             0000ffffffffffff
[    0.086998] ... max period:             00007fffffffffff
[    0.086999] ... fixed-purpose events:   3
[    0.087000] ... event mask:             000000070000000f
[    0.087210] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
[    0.087226] smp: Bringing up secondary CPUs ...
[    0.087291] x86: Booting SMP configuration:
[    0.087293] .... node  #0, CPUs:      #1 #2 #3
[    0.324021] smp: Brought up 1 node, 4 CPUs
[    0.324021] smpboot: Total of 4 processors activated (19159.64 BogoMIPS)
[    0.328110] sched_clock: Marking stable (328000000, 0)->(358544822, -30544822)
[    0.328382] devtmpfs: initialized
[    0.328430] x86/mm: Memory block size: 128MB
[    0.330934] PM: Registering ACPI NVS region [mem 0xdceb6000-0xdcf9efff] (954368 bytes)
[    0.331001] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.331010] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.331066] xor: automatically using best checksumming function   avx       
[    0.331070] pinctrl core: initialized pinctrl subsystem
[    0.331138] NET: Registered protocol family 16
[    0.331329] cpuidle: using governor ladder
[    0.331355] cpuidle: using governor menu
[    0.331357] PCCT header not found.
[    0.331403] ACPI: bus type PCI registered
[    0.331404] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.331447] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.331460] PCI: not using MMCONFIG
[    0.331461] PCI: Using configuration type 1 for base access
[    0.331471] dmi type 0xB1 record - unknown flag
[    0.331532] core: PMU erratum BJ122, BV98, HSD29 worked around, HT is on
[    0.333155] HugeTLB registered 1 GB page size, pre-allocated 0 pages
[    0.333156] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.400046] raid6: sse2x1   gen()  5513 MB/s
[    0.468064] raid6: sse2x1   xor()  4314 MB/s
[    0.536094] raid6: sse2x2   gen()  6916 MB/s
[    0.604122] raid6: sse2x2   xor()  4760 MB/s
[    0.672153] raid6: sse2x4   gen()  8079 MB/s
[    0.740181] raid6: sse2x4   xor()  5733 MB/s
[    0.808210] raid6: avx2x1   gen() 10816 MB/s
[    0.876234] raid6: avx2x1   xor()  8224 MB/s
[    0.944267] raid6: avx2x2   gen() 12456 MB/s
[    1.012295] raid6: avx2x2   xor()  8845 MB/s
[    1.080320] raid6: avx2x4   gen() 14597 MB/s
[    1.148343] raid6: avx2x4   xor() 11058 MB/s
[    1.148345] raid6: using algorithm avx2x4 gen() 14597 MB/s
[    1.148345] raid6: .... xor() 11058 MB/s, rmw enabled
[    1.148347] raid6: using avx2x2 recovery algorithm
[    1.148378] ACPI: Added _OSI(Module Device)
[    1.148379] ACPI: Added _OSI(Processor Device)
[    1.148379] ACPI: Added _OSI(3.0 _SCP Extensions)
[    1.148380] ACPI: Added _OSI(Processor Aggregator Device)
[    1.148612] ACPI: Executed 1 blocks of module-level executable AML code
[    1.154286] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    1.155402] ACPI: Dynamic OEM Table Load:
[    1.155412] ACPI: SSDT 0xFFFF8802154C5000 0003D3 (v01 PmRef  Cpu0Cst  00003001 INTL 20120711)
[    1.155800] ACPI: Dynamic OEM Table Load:
[    1.155808] ACPI: SSDT 0xFFFF880215510000 0005AA (v01 PmRef  ApIst    00003000 INTL 20120711)
[    1.156229] ACPI: Dynamic OEM Table Load:
[    1.156236] ACPI: SSDT 0xFFFF8802154F0E00 000119 (v01 PmRef  ApCst    00003000 INTL 20120711)
[    1.157220] ACPI : EC: EC started
[    1.157221] ACPI : EC: interrupt blocked
[    1.159508] ACPI: \_SB_.PCI0.LPCB.EC0_: Used as first EC
[    1.159510] ACPI: \_SB_.PCI0.LPCB.EC0_: GPE=0xa, EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    1.159512] ACPI: \_SB_.PCI0.LPCB.EC0_: Used as boot DSDT EC to handle transactions
[    1.159513] ACPI: Interpreter enabled
[    1.159547] ACPI: (supports S0 S1 S3 S4 S5)
[    1.159548] ACPI: Using IOAPIC for interrupt routing
[    1.159577] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
[    1.160137] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in ACPI motherboard resources
[    1.160146] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    1.173303] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
[    1.173308] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    1.173456] acpi PNP0A08:00: _OSC failed (AE_ERROR); disabling ASPM
[    1.173899] PCI host bridge to bus 0000:00
[    1.173901] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    1.173903] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    1.173904] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    1.173906] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000c3fff window]
[    1.173907] pci_bus 0000:00: root bus resource [mem 0x000c4000-0x000c7fff window]
[    1.173908] pci_bus 0000:00: root bus resource [mem 0x000c8000-0x000cbfff window]
[    1.173909] pci_bus 0000:00: root bus resource [mem 0x000cc000-0x000cffff window]
[    1.173910] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000d3fff window]
[    1.173912] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d7fff window]
[    1.173913] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000dbfff window]
[    1.173914] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000dffff window]
[    1.173915] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000e3fff window]
[    1.173916] pci_bus 0000:00: root bus resource [mem 0x000e4000-0x000e7fff window]
[    1.173917] pci_bus 0000:00: root bus resource [mem 0x000e8000-0x000ebfff window]
[    1.173919] pci_bus 0000:00: root bus resource [mem 0x000ec000-0x000effff window]
[    1.173920] pci_bus 0000:00: root bus resource [mem 0xdfa00000-0xfeafffff window]
[    1.173921] pci_bus 0000:00: root bus resource [bus 00-3e]
[    1.173929] pci 0000:00:00.0: [8086:0a04] type 00 class 0x060000
[    1.174134] pci 0000:00:02.0: [8086:0a16] type 00 class 0x030000
[    1.174147] pci 0000:00:02.0: reg 0x10: [mem 0xf0000000-0xf03fffff 64bit]
[    1.174154] pci 0000:00:02.0: reg 0x18: [mem 0xe0000000-0xefffffff 64bit pref]
[    1.174159] pci 0000:00:02.0: reg 0x20: [io  0x3000-0x303f]
[    1.174349] pci 0000:00:03.0: [8086:0a0c] type 00 class 0x040300
[    1.174359] pci 0000:00:03.0: reg 0x10: [mem 0xf0510000-0xf0513fff 64bit]
[    1.174574] pci 0000:00:14.0: [8086:9c31] type 00 class 0x0c0330
[    1.174591] pci 0000:00:14.0: reg 0x10: [mem 0xf0500000-0xf050ffff 64bit]
[    1.174652] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    1.174794] pci 0000:00:14.0: System wakeup disabled by ACPI
[    1.174828] pci 0000:00:16.0: [8086:9c3a] type 00 class 0x078000
[    1.174847] pci 0000:00:16.0: reg 0x10: [mem 0xf0519000-0xf051901f 64bit]
[    1.174918] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    1.175097] pci 0000:00:1b.0: [8086:9c20] type 00 class 0x040300
[    1.175112] pci 0000:00:1b.0: reg 0x10: [mem 0xf0514000-0xf0517fff 64bit]
[    1.175182] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    1.175325] pci 0000:00:1b.0: System wakeup disabled by ACPI
[    1.175363] pci 0000:00:1c.0: [8086:9c10] type 01 class 0x060400
[    1.175439] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    1.175623] pci 0000:00:1c.0: System wakeup disabled by ACPI
[    1.175663] pci 0000:00:1c.2: [8086:9c14] type 01 class 0x060400
[    1.175742] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    1.175922] pci 0000:00:1c.2: System wakeup disabled by ACPI
[    1.175960] pci 0000:00:1d.0: [8086:9c26] type 00 class 0x0c0320
[    1.175978] pci 0000:00:1d.0: reg 0x10: [mem 0xf051d000-0xf051d3ff]
[    1.176066] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    1.176224] pci 0000:00:1d.0: System wakeup disabled by ACPI
[    1.176259] pci 0000:00:1f.0: [8086:9c43] type 00 class 0x060100
[    1.176548] pci 0000:00:1f.2: [8086:9c03] type 00 class 0x010601
[    1.176561] pci 0000:00:1f.2: reg 0x10: [io  0x3088-0x308f]
[    1.176568] pci 0000:00:1f.2: reg 0x14: [io  0x3094-0x3097]
[    1.176575] pci 0000:00:1f.2: reg 0x18: [io  0x3080-0x3087]
[    1.176582] pci 0000:00:1f.2: reg 0x1c: [io  0x3090-0x3093]
[    1.176588] pci 0000:00:1f.2: reg 0x20: [io  0x3060-0x307f]
[    1.176595] pci 0000:00:1f.2: reg 0x24: [mem 0xf051c000-0xf051c7ff]
[    1.176632] pci 0000:00:1f.2: PME# supported from D3hot
[    1.176799] pci 0000:00:1f.3: [8086:9c22] type 00 class 0x0c0500
[    1.176813] pci 0000:00:1f.3: reg 0x10: [mem 0xf0518000-0xf05180ff 64bit]
[    1.176832] pci 0000:00:1f.3: reg 0x20: [io  0xefa0-0xefbf]
[    1.177069] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    1.177161] pci 0000:02:00.0: [8086:08b1] type 00 class 0x028000
[    1.177199] pci 0000:02:00.0: reg 0x10: [mem 0xf0400000-0xf0401fff 64bit]
[    1.177404] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    1.177463] pci 0000:02:00.0: System wakeup disabled by ACPI
[    1.188424] pci 0000:00:1c.2: PCI bridge to [bus 02]
[    1.188429] pci 0000:00:1c.2:   bridge window [mem 0xf0400000-0xf04fffff]
[    1.189989] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    1.190048] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    1.190104] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    1.190159] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    1.190214] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    1.190269] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    1.190325] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    1.190380] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    1.190678] ACPI: Enabled 5 GPEs in block 00 to 7F
[    1.190756] ACPI : EC: interrupt unblocked
[    1.190765] ACPI : EC: event unblocked
[    1.190783] ACPI: \_SB_.PCI0.LPCB.EC0_: GPE=0xa, EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    1.190785] ACPI: \_SB_.PCI0.LPCB.EC0_: Used as boot DSDT EC to handle transactions and events
[    1.190882] SCSI subsystem initialized
[    1.190919] libata version 3.00 loaded.
[    1.190948] Registered efivars operations
[    1.200760] PCI: Using ACPI for IRQ routing
[    1.202210] PCI: pci_cache_line_size set to 64 bytes
[    1.202272] e820: reserve RAM buffer [mem 0x00058000-0x0005ffff]
[    1.202274] e820: reserve RAM buffer [mem 0x0009d000-0x0009ffff]
[    1.202275] e820: reserve RAM buffer [mem 0x8034c000-0x83ffffff]
[    1.202276] e820: reserve RAM buffer [mem 0xdad7e000-0xdbffffff]
[    1.202277] e820: reserve RAM buffer [mem 0xdd000000-0xdfffffff]
[    1.202278] e820: reserve RAM buffer [mem 0x21f600000-0x21fffffff]
[    1.202447] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    1.202453] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    1.204473] clocksource: Switched to clocksource hpet
[    1.213104] VFS: Disk quotas dquot_6.6.0
[    1.213123] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.213196] pnp: PnP ACPI init
[    1.213336] system 00:00: [io  0x0680-0x069f] has been reserved
[    1.213338] system 00:00: [io  0xffff] has been reserved
[    1.213339] system 00:00: [io  0xffff] has been reserved
[    1.213341] system 00:00: [io  0xffff] has been reserved
[    1.213342] system 00:00: [io  0x1800-0x18fe] has been reserved
[    1.213343] system 00:00: [io  0x164e-0x164f] has been reserved
[    1.213347] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.213390] pnp 00:01: Plug and Play ACPI device, IDs PNP0b00 (active)
[    1.213435] system 00:02: [io  0x1854-0x1857] has been reserved
[    1.213438] system 00:02: Plug and Play ACPI device, IDs INT3f0d PNP0c02 (active)
[    1.213473] pnp 00:03: Plug and Play ACPI device, IDs PNP0303 (active)
[    1.213495] pnp 00:04: Plug and Play ACPI device, IDs SYN0608 PNP0f03 (active)
[    1.213623] system 00:05: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    1.213625] system 00:05: [mem 0xfed10000-0xfed17fff] has been reserved
[    1.213627] system 00:05: [mem 0xfed18000-0xfed18fff] has been reserved
[    1.213628] system 00:05: [mem 0xfed19000-0xfed19fff] has been reserved
[    1.213630] system 00:05: [mem 0xf8000000-0xfbffffff] could not be reserved
[    1.213631] system 00:05: [mem 0xfed20000-0xfed3ffff] has been reserved
[    1.213633] system 00:05: [mem 0xfed90000-0xfed93fff] has been reserved
[    1.213634] system 00:05: [mem 0xfed45000-0xfed8ffff] has been reserved
[    1.213636] system 00:05: [mem 0xff000000-0xffffffff] has been reserved
[    1.213637] system 00:05: [mem 0xfee00000-0xfeefffff] has been reserved
[    1.213638] system 00:05: [mem 0xdfa10000-0xdfa1ffff] has been reserved
[    1.213641] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.213951] system 00:06: [mem 0xfe102000-0xfe102fff] has been reserved
[    1.213953] system 00:06: [mem 0xfe104000-0xfe104fff] has been reserved
[    1.213955] system 00:06: [mem 0xfe106000-0xfe106fff] has been reserved
[    1.213957] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.214687] pnp: PnP ACPI: found 7 devices
[    1.220692] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    1.220720] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    1.220734] pci 0000:00:1c.2: PCI bridge to [bus 02]
[    1.220738] pci 0000:00:1c.2:   bridge window [mem 0xf0400000-0xf04fffff]
[    1.220747] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    1.220749] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    1.220750] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    1.220751] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000c3fff window]
[    1.220753] pci_bus 0000:00: resource 8 [mem 0x000c4000-0x000c7fff window]
[    1.220754] pci_bus 0000:00: resource 9 [mem 0x000c8000-0x000cbfff window]
[    1.220755] pci_bus 0000:00: resource 10 [mem 0x000cc000-0x000cffff window]
[    1.220756] pci_bus 0000:00: resource 11 [mem 0x000d0000-0x000d3fff window]
[    1.220757] pci_bus 0000:00: resource 12 [mem 0x000d4000-0x000d7fff window]
[    1.220759] pci_bus 0000:00: resource 13 [mem 0x000d8000-0x000dbfff window]
[    1.220760] pci_bus 0000:00: resource 14 [mem 0x000dc000-0x000dffff window]
[    1.220761] pci_bus 0000:00: resource 15 [mem 0x000e0000-0x000e3fff window]
[    1.220762] pci_bus 0000:00: resource 16 [mem 0x000e4000-0x000e7fff window]
[    1.220763] pci_bus 0000:00: resource 17 [mem 0x000e8000-0x000ebfff window]
[    1.220765] pci_bus 0000:00: resource 18 [mem 0x000ec000-0x000effff window]
[    1.220766] pci_bus 0000:00: resource 19 [mem 0xdfa00000-0xfeafffff window]
[    1.220768] pci_bus 0000:02: resource 1 [mem 0xf0400000-0xf04fffff]
[    1.220889] NET: Registered protocol family 2
[    1.221046] TCP established hash table entries: 65536 (order: 7, 524288 bytes)
[    1.221174] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    1.221302] TCP: Hash tables configured (established 65536 bind 65536)
[    1.221333] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    1.221359] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[    1.221410] NET: Registered protocol family 1
[    1.221423] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    1.221502] pci 0000:00:14.0: can't derive routing for PCI INT A
[    1.221503] pci 0000:00:14.0: PCI INT A: not connected
[    1.221727] PCI: CLS 64 bytes, default 64
[    1.221769] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    1.221771] software IO TLB [mem 0xd6862000-0xda862000] (64MB) mapped at [ffff8800d6862000-ffff8800da861fff]
[    1.221858] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
[    1.221859] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    1.221860] RAPL PMU: hw unit of domain package 2^-14 Joules
[    1.221861] RAPL PMU: hw unit of domain dram 2^-14 Joules
[    1.221862] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[    1.222376] simple-framebuffer simple-framebuffer.0: framebuffer at 0xe0000000, 0x7e9000 bytes, mapped to 0xffffc90001800000
[    1.222378] simple-framebuffer simple-framebuffer.0: format=a8r8g8b8, mode=1920x1080x32, linelength=7680
[    1.227919] Console: switching to colour frame buffer device 240x67
[    1.233357] simple-framebuffer simple-framebuffer.0: fb0: simplefb registered!
[    1.233508] audit: initializing netlink subsys (disabled)
[    1.233740] workingset: timestamp_bits=56 max_order=21 bucket_order=0
[    1.236729] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    1.236751] io scheduler noop registered
[    1.236752] io scheduler deadline registered (default)
[    1.236772] io scheduler cfq registered
[    1.236772] io scheduler mq-deadline registered
[    1.237114] intel_idle: MWAIT substates: 0x11142120
[    1.237115] intel_idle: v0.4.1 model 0x45
[    1.237310] intel_idle: lapic_timer_reliable_states 0xffffffff
[    1.237369] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    1.237372] ACPI: Power Button [PWRB]
[    1.258245] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input1
[    1.258253] ACPI: Lid Switch [LID0]
[    1.258295] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[    1.258298] ACPI: Power Button [PWRF]
[    1.258505] GHES: HEST is not enabled!
[    1.258572] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.258993] Linux agpgart interface v0.103
[    1.259226] [drm] Memory usable by graphics device = 2048M
[    1.259229] checking generic (e0000000 7e9000) vs hw (e0000000 10000000)
[    1.259230] fb: switching to inteldrmfb from simple
[    1.259251] Console: switching to colour dummy device 80x25
[    1.259310] [drm] Replacing VGA console driver
[    1.264533] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    1.264533] [drm] Driver supports precise vblank timestamp query.
[    1.277584] [drm] Initialized i915 1.6.0 20170123 for 0000:00:02.0 on minor 0
[    1.279156] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[    1.279444] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input3
[    1.279470] [drm] Initialized i915 1.6.0 20170123 for 0000:00:02.0 on minor 0
[    1.279900] ahci 0000:00:1f.2: version 3.0
[    1.290179] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 4 ports 6 Gbps 0x4 impl SATA mode
[    1.290182] ahci 0000:00:1f.2: flags: 64bit ncq pm led clo only pio slum part deso sadm sds apst 
[    1.290640] scsi host0: ahci
[    1.290870] scsi host1: ahci
[    1.291027] scsi host2: ahci
[    1.291116] scsi host3: ahci
[    1.291159] ata1: DUMMY
[    1.291160] ata2: DUMMY
[    1.291163] ata3: SATA max UDMA/133 abar m2048@0xf051c000 port 0xf051c200 irq 41
[    1.291164] ata4: DUMMY
[    1.291230] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
[    1.294844] fbcon: inteldrmfb (fb0) is primary device
[    1.296126] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.296131] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.296245] mousedev: PS/2 mouse device common for all mice
[    1.296379] rtc_cmos 00:01: RTC can wake from S4
[    1.296520] rtc_cmos 00:01: rtc core: registered rtc_cmos as rtc0
[    1.296546] rtc_cmos 00:01: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
[    1.296600] intel_pstate: Intel P-state driver initializing
[    1.296731] EFI Variables Facility v0.08 2004-May-17
[    1.303753] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input4
[    1.314401] pstore: using zlib compression
[    1.314403] pstore: Registered efi as persistent store backend
[    1.314442] intel_rapl: Found RAPL domain package
[    1.314442] intel_rapl: Found RAPL domain core
[    1.314443] intel_rapl: Found RAPL domain uncore
[    1.314444] intel_rapl: Found RAPL domain dram
[    1.314651] NET: Registered protocol family 10
[    1.314835] Segment Routing with IPv6
[    1.314846] mip6: Mobile IPv6
[    1.314847] NET: Registered protocol family 17
[    1.314849] mpls_gso: MPLS GSO support
[    1.315048] microcode: sig=0x40651, pf=0x40, revision=0x1c
[    1.315093] microcode: Microcode Update Driver: v2.2.
[    1.315175] registered taskstats version 1
[    1.315385] Btrfs loaded, crc32c=crc32c-generic
[    1.315658] Key type encrypted registered
[    1.315951] rtc_cmos 00:01: setting system clock to 2017-04-10 12:59:54 UTC (1491829194)
[    1.315953] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[    1.315953] EDD information not available.
[    1.315987] PM: Checking hibernation image partition /dev/sda3
[    1.604332] ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.604796] ata3.00: ATA-8: LITEONIT LMT-256M6M mSATA 256GB, DM8110F, max UDMA/133
[    1.604798] ata3.00: 500118192 sectors, multi 1: LBA48 NCQ (depth 31/32), AA
[    1.605332] ata3.00: configured for UDMA/133
[    2.236609] tsc: Refined TSC clocksource calibration: 2394.453 MHz
[    2.236623] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2283bf4e6f2, max_idle_ns: 440795216136 ns
[    2.442944] Console: switching to colour frame buffer device 240x67
[    2.453033] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
[    2.453270] scsi 2:0:0:0: Direct-Access     ATA      LITEONIT LMT-256 10F  PQ: 0 ANSI: 5
[    2.453703] sd 2:0:0:0: [sda] 500118192 512-byte logical blocks: (256 GB/238 GiB)
[    2.453716] sd 2:0:0:0: [sda] Write Protect is off
[    2.453717] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.453736] sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.455483]  sda: sda1 sda2 sda3 sda6
[    2.456271] sd 2:0:0:0: [sda] Attached SCSI disk
[    2.456284] PM: Hibernation image partition 8:3 present
[    2.456285] PM: Looking for hibernation image.
[    2.456417] PM: Image not found (code -22)
[    2.456418] PM: Hibernation image not present or could not be loaded.
[    2.460906] EXT4-fs (sda6): mounted filesystem with ordered data mode. Opts: (null)
[    2.460913] VFS: Mounted root (ext4 filesystem) readonly on device 8:6.
[    2.462003] Freeing unused kernel memory: 1452K
[    2.462004] Write protecting the kernel read-only data: 14336k
[    2.462414] Freeing unused kernel memory: 2020K
[    2.465043] Freeing unused kernel memory: 1500K
[    2.470272] random: fast init done
[    2.541815] ip_tables: (C) 2000-2006 Netfilter Core Team
[    2.573192] systemd[1]: systemd 232 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
[    2.573319] systemd[1]: Detected architecture x86-64.
[    2.573480] systemd[1]: Set hostname to <xps13>.
[    2.663701] systemd[1]: dundee.service: Cannot add dependency job, ignoring: Unit dundee.service is masked.
[    2.663769] systemd[1]: ofono.service: Cannot add dependency job, ignoring: Unit ofono.service is masked.
[    2.664696] systemd[1]: Listening on Journal Socket.
[    2.664773] systemd[1]: Listening on /dev/initctl Compatibility Named Pipe.
[    2.664878] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[    2.664912] systemd[1]: Listening on Syslog Socket.
[    2.664934] systemd[1]: Listening on fsck to fsckd communication Socket.
[    2.678354] lp: driver loaded but no devices found
[    2.680804] RPC: Registered named UNIX socket transport module.
[    2.680805] RPC: Registered udp transport module.
[    2.680806] RPC: Registered tcp transport module.
[    2.680807] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    2.682795] ppdev: user-space parallel port driver
[    2.694148] nf_conntrack version 0.5.0 (65536 buckets, 262144 max)
[    2.731723] EXT4-fs (sda6): re-mounted. Opts: errors=remount-ro
[    2.738442] systemd-journald[137]: Received request to flush runtime journal from PID 1
[    2.850286] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    2.854785] ACPI: bus type USB registered
[    2.854817] usbcore: registered new interface driver usbfs
[    2.854827] usbcore: registered new interface driver hub
[    2.854996] usbcore: registered new device driver usb
[    2.859586] sdhci: Secure Digital Host Controller Interface driver
[    2.859588] sdhci: Copyright(c) Pierre Ossman
[    2.860112] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.861039] ehci-pci: EHCI PCI platform driver
[    2.888953] xhci_hcd 0000:00:14.0: can't derive routing for PCI INT A
[    2.888956] xhci_hcd 0000:00:14.0: PCI INT A: no GSI
[    2.888978] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    2.888984] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    2.890056] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x0004b810
[    2.890061] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
[    2.890146] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    2.890148] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.890149] usb usb1: Product: xHCI Host Controller
[    2.890150] usb usb1: Manufacturer: Linux 4.11.0-rc6 xhci-hcd
[    2.890152] usb usb1: SerialNumber: 0000:00:14.0
[    2.890270] hub 1-0:1.0: USB hub found
[    2.890280] hub 1-0:1.0: 9 ports detected
[    2.893394] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    2.893398] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[    2.893434] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003
[    2.893436] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.893437] usb usb2: Product: xHCI Host Controller
[    2.893439] usb usb2: Manufacturer: Linux 4.11.0-rc6 xhci-hcd
[    2.893440] usb usb2: SerialNumber: 0000:00:14.0
[    2.893610] hub 2-0:1.0: USB hub found
[    2.893619] hub 2-0:1.0: 4 ports detected
[    2.895887] ehci-pci 0000:00:1d.0: EHCI Host Controller
[    2.895894] ehci-pci 0000:00:1d.0: new USB bus registered, assigned bus number 3
[    2.895905] ehci-pci 0000:00:1d.0: debug port 2
[    2.896717] (NULL device *): hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
[    2.896765] thermal LNXTHERM:00: registered as thermal_zone0
[    2.896766] ACPI: Thermal Zone [TZ00] (28 C)
[    2.897042] thermal LNXTHERM:01: registered as thermal_zone1
[    2.897043] ACPI: Thermal Zone [TZ01] (30 C)
[    2.899798] ehci-pci 0000:00:1d.0: cache line size of 64 is not supported
[    2.900169] ehci-pci 0000:00:1d.0: irq 23, io mem 0xf051d000
[    2.902049] hidraw: raw HID events driver (C) Jiri Kosina
[    2.916573] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    2.916609] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
[    2.916611] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.916612] usb usb3: Product: EHCI Host Controller
[    2.916614] usb usb3: Manufacturer: Linux 4.11.0-rc6 ehci_hcd
[    2.916615] usb usb3: SerialNumber: 0000:00:1d.0
[    2.916733] hub 3-0:1.0: USB hub found
[    2.916738] hub 3-0:1.0: 2 ports detected
[    2.916975] snd_hda_intel 0000:00:03.0: bound 0000:00:02.0 (ops 0xffffffff81aa8d00)
[    2.931419] snd_hda_codec_realtek hdaudioC1D0: autoconfig for ALC3661: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
[    2.931422] snd_hda_codec_realtek hdaudioC1D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    2.931424] snd_hda_codec_realtek hdaudioC1D0:    hp_outs=1 (0x15/0x0/0x0/0x0/0x0)
[    2.931425] snd_hda_codec_realtek hdaudioC1D0:    mono: mono_out=0x0
[    2.931426] snd_hda_codec_realtek hdaudioC1D0:    inputs:
[    2.931427] snd_hda_codec_realtek hdaudioC1D0:      Headphone Mic=0x19
[    2.931428] snd_hda_codec_realtek hdaudioC1D0:      Headset Mic=0x1b
[    2.931429] snd_hda_codec_realtek hdaudioC1D0:      Internal Mic=0x12
[    2.937171] input: HDA Intel HDMI HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:03.0/sound/card0/input7
[    2.937236] input: HDA Intel HDMI HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:03.0/sound/card0/input8
[    2.937297] input: HDA Intel HDMI HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:03.0/sound/card0/input9
[    2.937352] input: HDA Intel HDMI HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:03.0/sound/card0/input10
[    2.937411] input: HDA Intel HDMI HDMI/DP,pcm=10 as /devices/pci0000:00/0000:00:03.0/sound/card0/input11
[    2.943774] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/sound/card1/input6
[    2.943918] input: HDA Intel PCH Headphone Mic as /devices/pci0000:00/0000:00:1b.0/sound/card1/input12
[    2.949754] i801_smbus 0000:00:1f.3: SPD Write Disable is set
[    2.950433] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
[    2.954319] Intel(R) Wireless WiFi driver for Linux
[    2.954320] Copyright(c) 2003- 2015 Intel Corporation
[    2.960452] iwlwifi 0000:02:00.0: loaded firmware version 17.352738.0 op_mode iwlmvm
[    2.961692] sd 2:0:0:0: Attached scsi generic sg0 type 0
[    2.966651] AVX2 version of gcm_enc/dec engaged.
[    2.966652] AES CTR mode by8 optimization enabled
[    2.968619] ACPI: AC Adapter [ADP0] (on-line)
[    2.974761] iwlwifi 0000:02:00.0: Detected Intel(R) Dual Band Wireless AC 7260, REV=0x144
[    2.976579] iwlwifi 0000:02:00.0: L1 Enabled - LTR Enabled
[    2.976870] iwlwifi 0000:02:00.0: RF_KILL bit toggled to disable radio.
[    2.976909] iwlwifi 0000:02:00.0: L1 Enabled - LTR Enabled
[    2.980984] ACPI: Battery Slot [BAT0] (battery present)
[    2.981195] wmi: Mapper loaded
[    2.990553] dcdbas dcdbas: Dell Systems Management Base Driver (version 5.6.0-3.2)
[    3.010650] ieee80211 phy0: Selected rate control algorithm 'iwl-mvm-rs'
[    3.024272] iTCO_vendor_support: vendor-support=0
[    3.024741] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[    3.024782] iTCO_wdt: Found a Lynx Point_LP TCO device (Version=2, TCOBASE=0x1860)
[    3.025124] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[    3.108488] rmi4_f01 rmi4-00.fn01: found RMI device, manufacturer: Synaptics, product: s3203, fw id: 1522295
[    3.110556] dell_wmi: Detected Dell WMI interface version 0
[    3.110634] input: Dell WMI hotkeys as /devices/virtual/input/input15
[    3.178119] input: Synaptics s3203 as /devices/pci0000:00/INT33C3:00/i2c-8/i2c-DLL060A:00/0018:06CB:2734.0001/input/input14
[    3.178419] hid-rmi 0018:06CB:2734.0001: input,hidraw0: I2C HID v1.00 Pointer [DLL060A:00 06CB:2734] on i2c-DLL060A:00
[    3.194729] Adding 8388604k swap on /dev/sda3.  Priority:-1 extents:1 across:8388604k SSFS
[    3.232555] usb 1-3: new full-speed USB device number 2 using xhci_hcd
[    3.248562] usb 3-1: new high-speed USB device number 2 using ehci-pci
[    3.260598] clocksource: Switched to clocksource tsc
[    3.319119] ahci 0000:00:1f.2: port does not support device sleep
[    3.354662] FAT-fs (sda1): utf8 is not a recommended IO charset for FAT filesystems, filesystem will be case sensitive!
[    3.374836] usb 1-3: New USB device found, idVendor=06cb, idProduct=0af8
[    3.374838] usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.374840] usb 1-3: Product: Synaptics Large Touch Screen
[    3.374841] usb 1-3: Manufacturer: SYNAPTICS
[    3.404853] usb 3-1: New USB device found, idVendor=8087, idProduct=8000
[    3.404855] usb 3-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    3.405218] hub 3-1:1.0: USB hub found
[    3.405603] hub 3-1:1.0: 8 ports detected
[    3.419389] random: crng init done
[    3.492661] usb 1-5: new high-speed USB device number 3 using xhci_hcd
[    3.517967] new mount options do not match the existing superblock, will be ignored
[    3.537992] zram: Added device: zram0
[    3.538484] zram: Added device: zram1
[    3.539092] zram: Added device: zram2
[    3.539546] zram: Added device: zram3
[    3.545827] zram0: detected capacity change from 0 to 620634112
[    3.551010] Adding 606084k swap on /dev/zram0.  Priority:10 extents:1 across:606084k SSFS
[    3.551404] zram1: detected capacity change from 0 to 620634112
[    3.554046] Adding 606084k swap on /dev/zram1.  Priority:10 extents:1 across:606084k SSFS
[    3.554414] zram2: detected capacity change from 0 to 620634112
[    3.557025] Adding 606084k swap on /dev/zram2.  Priority:10 extents:1 across:606084k SSFS
[    3.557397] zram3: detected capacity change from 0 to 620634112
[    3.559961] Adding 606084k swap on /dev/zram3.  Priority:10 extents:1 across:606084k SSFS
[    3.630955] Process accounting resumed
[    3.673396] usb 1-5: New USB device found, idVendor=0bda, idProduct=5752
[    3.673398] usb 1-5: New USB device strings: Mfr=3, Product=1, SerialNumber=2
[    3.673400] usb 1-5: Product: Integrated_Webcam_HD
[    3.673401] usb 1-5: Manufacturer: CN0Y2TKG7248742EDBD6A00
[    3.673402] usb 1-5: SerialNumber: 200901010001
[    3.796572] usb 1-6: new full-speed USB device number 4 using xhci_hcd
[    3.819427] vnstatd[764]: segfault at c ip 00005651a4e6e9c5 sp 00007ffe914509d0 error 4 in vnstatd[5651a4e69000+13000]
[    3.937456] usb 1-6: New USB device found, idVendor=8087, idProduct=07dc
[    3.937458] usb 1-6: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    3.951421] Bluetooth: Core ver 2.22
[    3.951437] NET: Registered protocol family 31
[    3.951438] Bluetooth: HCI device and connection manager initialized
[    3.951441] Bluetooth: HCI socket layer initialized
[    3.951442] Bluetooth: L2CAP socket layer initialized
[    3.951447] Bluetooth: SCO socket layer initialized
[    3.955273] usbcore: registered new interface driver btusb
[    3.956442] media: Linux media interface: v0.10
[    3.960296] Linux video capture interface: v2.00
[    3.966991] uvcvideo: Found UVC 1.00 device Integrated_Webcam_HD (0bda:5752)
[    3.968406] Bluetooth: hci0: read Intel version: 370710018002030d00
[    3.969867] Bluetooth: hci0: Intel Bluetooth firmware file: intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
[    3.973143] uvcvideo 1-5:1.0: Entity type for entity Extension 4 was not initialized!
[    3.973145] uvcvideo 1-5:1.0: Entity type for entity Extension 7 was not initialized!
[    3.973146] uvcvideo 1-5:1.0: Entity type for entity Processing 2 was not initialized!
[    3.973148] uvcvideo 1-5:1.0: Entity type for entity Camera 1 was not initialized!
[    3.973889] input: Integrated_Webcam_HD as /devices/pci0000:00/0000:00:14.0/usb1/1-5/1-5:1.0/input/input17
[    3.974018] usbcore: registered new interface driver uvcvideo
[    3.974019] USB Video Class driver (1.1.1)
[    3.994009] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    3.994011] Bluetooth: BNEP filters: protocol multicast
[    3.994013] Bluetooth: BNEP socket layer initialized
[    4.012236] IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
[    4.109408] Bluetooth: hci0: Intel Bluetooth firmware patch completed and activated
[    5.020598] hid-rmi 0003:06CB:0AF8.0002: rmi_hid_read_block: timeout elapsed
[    6.044610] hid-rmi 0003:06CB:0AF8.0002: rmi_hid_read_block: timeout elapsed
[    7.068608] hid-rmi 0003:06CB:0AF8.0002: rmi_hid_read_block: timeout elapsed
[    8.092572] hid-rmi 0003:06CB:0AF8.0002: rmi_hid_read_block: timeout elapsed
[    9.116565] hid-rmi 0003:06CB:0AF8.0002: rmi_hid_read_block: timeout elapsed
[    9.116572] rmi4_physical rmi4-01: Read PDT entry at 0x00e9 failed, code: -11.
[    9.116652] rmi4_physical rmi4-01: RMI initial reset failed! Continuing in spite of this.
[   10.140558] hid-rmi 0003:06CB:0AF8.0002: rmi_hid_read_block: timeout elapsed
[   11.164546] hid-rmi 0003:06CB:0AF8.0002: rmi_hid_read_block: timeout elapsed
[   12.188527] hid-rmi 0003:06CB:0AF8.0002: rmi_hid_read_block: timeout elapsed
[   13.212601] hid-rmi 0003:06CB:0AF8.0002: rmi_hid_read_block: timeout elapsed
[   14.236592] hid-rmi 0003:06CB:0AF8.0002: rmi_hid_read_block: timeout elapsed
[   14.236601] rmi4_physical rmi4-01: Could not read PDT properties from 0x00ef (code -11). Assuming 0x00.
[   15.260501] hid-rmi 0003:06CB:0AF8.0002: rmi_hid_read_block: timeout elapsed
[   16.284454] hid-rmi 0003:06CB:0AF8.0002: rmi_hid_read_block: timeout elapsed
[   17.308557] hid-rmi 0003:06CB:0AF8.0002: rmi_hid_read_block: timeout elapsed
[   18.332545] hid-rmi 0003:06CB:0AF8.0002: rmi_hid_read_block: timeout elapsed
[   19.356534] hid-rmi 0003:06CB:0AF8.0002: rmi_hid_read_block: timeout elapsed
[   19.356542] rmi4_physical rmi4-01: Read PDT entry at 0x00e9 failed, code: -11.
[   19.359511] rmi4_physical rmi4-01: IRQ counting failed with code -11.
[   19.362563] rmi4_physical: probe of rmi4-01 failed with error -11
[   19.363031] input: SYNAPTICS Synaptics Large Touch Screen as /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3:1.0/0003:06CB:0AF8.0002/input/input16
[   19.363450] hid-rmi 0003:06CB:0AF8.0002: input,hiddev0,hidraw1: USB HID v1.11 Mouse [SYNAPTICS Synaptics Large Touch Screen] on usb-0000:00:14.0-3/input0
[   19.363547] usbcore: registered new interface driver usbhid
[   19.363549] usbhid: USB HID core driver
[   19.442906] ip6_tables: (C) 2000-2006 Netfilter Core Team
[   19.455445] Ebtables v2.0 registered
[   19.675392] bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
[   19.680196] tun: Universal TUN/TAP device driver, 1.6
[   19.744528] virbr0: port 1(virbr0-nic) entered blocking state
[   19.744531] virbr0: port 1(virbr0-nic) entered disabled state
[   19.744656] device virbr0-nic entered promiscuous mode
[   19.875330] device virbr0-nic left promiscuous mode
[   19.875332] virbr0: port 1(virbr0-nic) entered disabled state
[   21.980525] BUG: unable to handle kernel NULL pointer dereference at           (null)
[   21.983595] IP: rmi_driver_suspend+0x1a/0xb0
[   21.986607] PGD 0 

[   21.992538] Oops: 0000 [#1] SMP
[   21.995502] Modules linked in: iptable_nat nf_nat_ipv4 nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp tun bridge stp llc ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter bnep uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_core videodev media usbhid btusb btintel bluetooth lz4 lz4_compress zram binfmt_misc nls_utf8 nls_cp437 joydev dell_wmi sparse_keymap hid_rmi x86_pkg_temp_thermal intel_powerclamp coretemp iTCO_wdt iTCO_vendor_support kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel arc4 dell_laptop dell_smbios dcdbas iwlmvm aesni_intel mac80211 aes_x86_64 crypto_simd cryptd glue_helper sg psmouse serio_raw iwlwifi i2c_i801 cfg80211 rfkill snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_
 codec_generic
[   22.009157]  i2c_hid hid thermal wmi battery acpi_als kfifo_buf industrialio snd_hda_intel snd_hda_codec snd_hwdep snd_hda_core snd_pcm ehci_pci snd_timer sdhci_acpi ehci_hcd sdhci xhci_pci mmc_core i2c_designware_platform xhci_hcd i2c_designware_core evdev snd usbcore ac intel_rst soundcore usb_common lpc_ich mfd_core shpchp nf_nat_pptp nf_nat_proto_gre nf_conntrack_pptp nf_conntrack_proto_gre nf_nat nf_conntrack libcrc32c crc32c_intel parport_pc ppdev sunrpc lp parport ip_tables x_tables
[   22.020949] CPU: 2 PID: 235 Comm: kworker/2:2 Not tainted 4.11.0-rc6 #3
[   22.024941] Hardware name: Dell Inc. XPS13 9333/0HP75V, BIOS A07 03/27/2015
[   22.028979] Workqueue: pm pm_runtime_work
[   22.032935] task: ffff88021290c100 task.stack: ffffc900014b8000
[   22.036896] RIP: 0010:rmi_driver_suspend+0x1a/0xb0
[   22.040821] RSP: 0018:ffffc900014bbcb8 EFLAGS: 00010296
[   22.044726] RAX: 0000000000000000 RBX: ffff880200128000 RCX: 0000000000000004
[   22.048634] RDX: ffff880208a20018 RSI: 0000000000000000 RDI: ffff8802086c1400
[   22.052525] RBP: ffff8802086c1400 R08: ffff88020c674f70 R09: ffff88020c674f00
[   22.056400] R10: ffff88020e098020 R11: ffff88020e098020 R12: 0000000000000000
[   22.060273] R13: 0000000000000000 R14: 0000000000000402 R15: ffff8802128ffc00
[   22.064151] FS:  0000000000000000(0000) GS:ffff88021f300000(0000) knlGS:0000000000000000
[   22.068055] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   22.071963] CR2: 0000000000000000 CR3: 0000000002409000 CR4: 00000000001406e0
[   22.075887] Call Trace:
[   22.079750]  ? rmi_suspend+0x2b/0x60 [hid_rmi]
[   22.083571]  ? hid_suspend+0x16f/0x220 [usbhid]
[   22.087387]  ? usb_suspend_both+0x93/0x1c0 [usbcore]
[   22.091177]  ? usb_probe_interface+0x260/0x260 [usbcore]
[   22.094971]  ? usb_runtime_suspend+0x31/0x70 [usbcore]
[   22.098748]  ? __rpm_callback+0xc1/0x200
[   22.102513]  ? dequeue_entity+0xd9/0x210
[   22.106273]  ? rpm_callback+0x1f/0x70
[   22.110029]  ? usb_probe_interface+0x260/0x260 [usbcore]
[   22.113795]  ? rpm_suspend+0x119/0x620
[   22.117544]  ? __switch_to+0x20f/0x3e0
[   22.121280]  ? pm_runtime_work+0x6e/0x90
[   22.124989]  ? process_one_work+0x1f6/0x490
[   22.128674]  ? worker_thread+0x4a/0x4e0
[   22.132328]  ? kthread+0xf4/0x130
[   22.135931]  ? process_one_work+0x490/0x490
[   22.139562]  ? kthread_create_on_node+0x40/0x40
[   22.143197]  ? do_group_exit+0x3a/0xa0
[   22.146828]  ? ret_from_fork+0x26/0x40
[   22.150403] Code: 48 c7 c6 68 9a c1 81 48 89 ef e8 c2 fd f8 ff eb 9f 0f 1f 44 00 00 41 56 41 55 41 54 55 41 89 f4 53 4c 8b af 98 00 00 00 48 89 fd <49> 8b 45 00 49 39 c5 48 8d 98 08 fd ff ff 75 15 eb 78 48 8b 83 
[   22.154261] RIP: rmi_driver_suspend+0x1a/0xb0 RSP: ffffc900014bbcb8
[   22.158101] CR2: 0000000000000000
[   22.161893] ---[ end trace 574ac4af92a078af ]---
