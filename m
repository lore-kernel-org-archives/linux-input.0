From: Stefan Assmann <sassmann@kpanic.de>
Subject: i2c_hid: probe of i2c-FTSC1000:00 failed with error -121
Date: Tue, 3 Jan 2017 09:11:42 +0100
Message-ID: <091ae052-a23b-9bed-db5a-d7545d2c084e@kpanic.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from policyd.app1.xlhost.de ([84.200.252.165]:35945 "EHLO
        app1b.xlhost.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933987AbdACNAQ (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 3 Jan 2017 08:00:16 -0500
Received: from [192.168.0.11] (p579E8A4C.dip0.t-ipconnect.de [87.158.138.76])
        (Authenticated sender: sassmann@kpanic.de)
        by app1b.xlhost.de (Postfix) with ESMTPSA id 53DB33048010
        for <linux-input@vger.kernel.org>; Tue,  3 Jan 2017 09:11:43 +0100 (CET)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

On a baytrail tablet with kernel 4.10-rc1 the touchscreen no longer
works, it still worked on 4.7. Looking at dmesg I spotted the following
[   25.482520] i2c_hid i2c-FTSC1000:00: Fetching the HID descriptor
[   25.482526] i2c_hid i2c-FTSC1000:00: __i2c_hid_command: cmd=00 00
[   25.485871] i2c_hid i2c-FTSC1000:00: HID Descriptor: 1e 00 00 01 1f 02 02 00 03 00 42 00 04 00 42 00 05 00 06 00 08 28 56 50 00 02 00 00 00 00
[   25.487297] i2c_hid i2c-FTSC1000:00: entering i2c_hid_parse
[   25.487301] i2c_hid i2c-FTSC1000:00: i2c_hid_hwreset
[   25.487304] i2c_hid i2c-FTSC1000:00: i2c_hid_set_power
[   25.487308] i2c_hid i2c-FTSC1000:00: __i2c_hid_command: cmd=05 00 00 08
[   25.488275] i2c_hid i2c-FTSC1000:00: resetting...
[   25.488281] i2c_hid i2c-FTSC1000:00: __i2c_hid_command: cmd=05 00 00 01
[   25.490851] i2c_hid i2c-FTSC1000:00: __i2c_hid_command: waiting...
[   30.743613] i2c_hid i2c-FTSC1000:00: __i2c_hid_command: finished.
[   30.743625] i2c_hid i2c-FTSC1000:00: failed to reset device.
[   30.764913] i2c_hid i2c-FTSC1000:00: i2c_hid_set_power
[   30.764926] i2c_hid i2c-FTSC1000:00: __i2c_hid_command: cmd=05 00 01 08
[   31.831588] i2c_hid i2c-FTSC1000:00: i2c_hid_hwreset
[   31.831601] i2c_hid i2c-FTSC1000:00: i2c_hid_set_power
[   31.831612] i2c_hid i2c-FTSC1000:00: __i2c_hid_command: cmd=05 00 00 08
[   31.831863] i2c_hid i2c-FTSC1000:00: failed to change power setting.
[   32.919634] i2c_hid i2c-FTSC1000:00: i2c_hid_hwreset
[   32.919647] i2c_hid i2c-FTSC1000:00: i2c_hid_set_power
[   32.919658] i2c_hid i2c-FTSC1000:00: __i2c_hid_command: cmd=05 00 00 08
[   32.919919] i2c_hid i2c-FTSC1000:00: failed to change power setting.
[   34.007589] i2c_hid i2c-FTSC1000:00: i2c_hid_hwreset
[   34.007603] i2c_hid i2c-FTSC1000:00: i2c_hid_set_power
[   34.007614] i2c_hid i2c-FTSC1000:00: __i2c_hid_command: cmd=05 00 00 08
[   34.007874] i2c_hid i2c-FTSC1000:00: failed to change power setting.
[   35.095585] i2c_hid i2c-FTSC1000:00: can't add hid device: -121
[   35.152943] i2c_hid: probe of i2c-FTSC1000:00 failed with error -121

Full dmesg with hiddebug below.

[    0.000000] Linux version 4.10.0-rc1+ (sassmann@w541) (gcc version 6.2.1 20160916 (Red Hat 6.2.1-2) (GCC) ) #2 SMP Mon Jan 2 11:39:05 CET 2017
[    0.000000] x86/fpu: Legacy x87 FPU detected.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000008efff] usable
[    0.000000] BIOS-e820: [mem 0x000000000008f000-0x000000000008ffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000000090000-0x000000000009dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009e000-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000001fffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000020000000-0x00000000201fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000020200000-0x0000000024a7ffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000024a80000-0x0000000024afffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000024b00000-0x000000003ba4dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000003ba4e000-0x000000003bc6dfff] reserved
[    0.000000] BIOS-e820: [mem 0x000000003bc6e000-0x000000003bc6efff] usable
[    0.000000] BIOS-e820: [mem 0x000000003bc6f000-0x000000003bc6ffff] reserved
[    0.000000] BIOS-e820: [mem 0x000000003bc70000-0x000000003bc71fff] usable
[    0.000000] BIOS-e820: [mem 0x000000003bc72000-0x000000003bc72fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000003bc73000-0x000000003c7fffff] usable
[    0.000000] BIOS-e820: [mem 0x000000003cc00000-0x000000003ccc2fff] usable
[    0.000000] BIOS-e820: [mem 0x000000003ccc3000-0x000000003cd46fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000003cd47000-0x000000003cdb6fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000003cdb7000-0x000000003cdf6fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000003cdf7000-0x000000003cdfffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000e00f8000-0x00000000e00f8fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed01000-0x00000000fed01fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fff60000-0x00000000ffffffff] reserved
[    0.000000] Notice: NX (Execute Disable) protection cannot be enabled: non-PAE kernel!
[    0.000000] efi: EFI v2.40 by INSYDE Corp.
[    0.000000] efi:  ACPI 2.0=0x3cdf6014  ESRT=0x3bb5e110  SMBIOS=0x3bc25000
[    0.000000] SMBIOS 2.7 present.
[    0.000000] DMI: AXDIA International GmbH Wintab Gen 8/Type2 - Board Product Name, BIOS AD890.1.02.022 09/25/2014
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x3ce00 max_arch_pfn = 0x100000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 0FFF60000 mask FFFC00000 write-protect
[    0.000000]   1 base 000000000 mask FC0000000 write-back
[    0.000000]   2 base 03E000000 mask FFE000000 uncachable
[    0.000000]   3 base 03D000000 mask FFF000000 uncachable
[    0.000000]   4 base 03CE00000 mask FFFE00000 uncachable
[    0.000000]   5 base 03C800000 mask FFFC00000 uncachable
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- WT
[    0.000000] esrt: Reserving ESRT space from 0x3bb5e110 to 0x3bb5e148.
[    0.000000] initial memory mapped: [mem 0x00000000-0x043fffff]
[    0.000000] Base memory trampoline at [c0099000] 99000 size 16384
[    0.000000] BRK [0x040c3000, 0x040c3fff] PGTABLE
[    0.000000] BRK [0x040c4000, 0x040c4fff] PGTABLE
[    0.000000] BRK [0x040c5000, 0x040c5fff] PGTABLE
[    0.000000] BRK [0x040c6000, 0x040c7fff] PGTABLE
[    0.000000] RAMDISK: [mem 0x238f9000-0x24a7ffff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x000000003CDF6014 000024 (v02 INSYDE)
[    0.000000] ACPI: XSDT 0x000000003CDCF188 0000CC (v01 INSYDE INSYDE   00000003      01000013)
[    0.000000] ACPI: FACP 0x000000003CDF0000 00010C (v05 INSYDE INSYDE   00000003 ACPI 00040000)
[    0.000000] ACPI: DSDT 0x000000003CDDC000 00EF31 (v02 INSYDE INSYDE   00000003 ACPI 00040000)
[    0.000000] ACPI: UEFI 0x000000003CDF5000 000236 (v01 INSYDE INSYDE   00000001 ACPI 00040000)
[    0.000000] ACPI: MSDM 0x000000003CDF4000 000055 (v03 INSYDE INSYDE   00000001 ACPI 00040000)
[    0.000000] ACPI: UEFI 0x000000003CDF3000 000042 (v01 INSYDE INSYDE   00000000 ACPI 00040000)
[    0.000000] ACPI: OEM0 0x000000003CDF2000 000084 (v05 INSYDE INSYDE   00000003 ACPI 00040000)
[    0.000000] ACPI: DBG2 0x000000003CDF1000 000072 (v00 INSYDE INSYDE   00000003 ACPI 00040000)
[    0.000000] ACPI: HPET 0x000000003CDEF000 000038 (v01 INSYDE INSYDE   00000003 ACPI 00040000)
[    0.000000] ACPI: LPIT 0x000000003CDEE000 000104 (v01 INSYDE INSYDE   00000003 ACPI 00040000)
[    0.000000] ACPI: APIC 0x000000003CDED000 00006C (v03 INSYDE INSYDE   00000003 ACPI 00040000)
[    0.000000] ACPI: MCFG 0x000000003CDEC000 00003C (v01 INSYDE INSYDE   00000003 ACPI 00040000)
[    0.000000] ACPI: SLIC 0x000000003CDEB000 000176 (v01 INSYDE INSYDE   00000003 ACPI 00040000)
[    0.000000] ACPI: SSDT 0x000000003CDDB000 0005DA (v01 INSYDE CpuDptf  00000003 ACPI 00040000)
[    0.000000] ACPI: SSDT 0x000000003CDD8000 0024BA (v01 INSYDE DptfTab  00000003 ACPI 00040000)
[    0.000000] ACPI: SSDT 0x000000003CDD7000 000058 (v01 INSYDE LowPwrM  00000003 ACPI 00040000)
[    0.000000] ACPI: SSDT 0x000000003CDD6000 0000FF (v01 INSYDE SoCDptf  00000003 ACPI 00040000)
[    0.000000] ACPI: SSDT 0x000000003CDD5000 000763 (v01 INSYDE CpuPm    00003000 ACPI 00040000)
[    0.000000] ACPI: SSDT 0x000000003CDD4000 000290 (v01 INSYDE Cpu0Tst  00003000 ACPI 00040000)
[    0.000000] ACPI: SSDT 0x000000003CDD3000 00017A (v01 INSYDE ApTst    00003000 ACPI 00040000)
[    0.000000] ACPI: FPDT 0x000000003CDD1000 000044 (v01 INSYDE INSYDE   00000002 ACPI 00040000)
[    0.000000] ACPI: CSRT 0x000000003CDD0000 00014C (v00 INSYDE INSYDE   00000005 ACPI 00040000)
[    0.000000] ACPI: BGRT 0x000000003CDD2000 000038 (v01 INSYDE INSYDE   00000001 ACPI 00040000)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] 90MB HIGHMEM available.
[    0.000000] 883MB LOWMEM available.
[    0.000000]   mapped low ram: 0 - 373fe000
[    0.000000]   low ram: 0 - 373fe000
[    0.000000] BRK [0x040c8000, 0x040c8fff] PGTABLE
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   Normal   [mem 0x0000000001000000-0x00000000373fdfff]
[    0.000000]   HighMem  [mem 0x00000000373fe000-0x000000003cdfffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000008efff]
[    0.000000]   node   0: [mem 0x0000000000090000-0x000000000009dfff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x000000001fffffff]
[    0.000000]   node   0: [mem 0x0000000020200000-0x0000000024a7ffff]
[    0.000000]   node   0: [mem 0x0000000024b00000-0x000000003ba4dfff]
[    0.000000]   node   0: [mem 0x000000003bc6e000-0x000000003bc6efff]
[    0.000000]   node   0: [mem 0x000000003bc70000-0x000000003bc71fff]
[    0.000000]   node   0: [mem 0x000000003bc73000-0x000000003c7fffff]
[    0.000000]   node   0: [mem 0x000000003cc00000-0x000000003ccc2fff]
[    0.000000]   node   0: [mem 0x000000003cdf7000-0x000000003cdfffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000003cdfffff]
[    0.000000] On node 0 totalpages: 246726
[    0.000000] free_area_init_node: node 0, pgdat c3ebf740, node_mem_map f6a76028
[    0.000000]   DMA zone: 40 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 3996 pages, LIFO batch:0
[    0.000000]   Normal zone: 2170 pages used for memmap
[    0.000000]   Normal zone: 221566 pages, LIFO batch:31
[    0.000000]   HighMem zone: 21164 pages, LIFO batch:3
[    0.000000] Using APIC driver default
[    0.000000] x86/hpet: Will disable the HPET for this platform because it's not reliable
[    0.000000] Reserving Intel graphics memory at 0x3d000000-0x3effffff
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-86
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0008f000-0x0008ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009e000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0x20000000-0x201fffff]
[    0.000000] PM: Registered nosave memory: [mem 0x24a80000-0x24afffff]
[    0.000000] e820: [mem 0x3f000000-0xe00f7fff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.000000] setup_percpu: NR_CPUS:32 nr_cpumask_bits:32 nr_cpu_ids:4 nr_node_ids:1
[    0.000000] percpu: Embedded 20 pages/cpu @f6a23000 s52044 r0 d29876 u81920
[    0.000000] pcpu-alloc: s52044 r0 d29876 u81920 alloc=20*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 244516
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-4.10.0-rc1+ root=/dev/root ro root=/dev/mmcblk1p2 tsc=reliable LANG=en_US.UTF-8 rd.timeout=10 rd.retry=10 i2c_hid.debug=1
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Initializing CPU#0
[    0.000000] ACPI Warning: Table c3f5bee0, Validation count is zero before decrement
[    0.000000]  (20160930/tbutils-455)
[    0.000000] Initializing HighMem for node 0 (000373fe:0003ce00)
[    0.000000] Initializing Movable for node 0 (00000000:00000000)
[    0.000000] Memory: 915024K/986904K available (7484K kernel code, 792K rwdata, 2888K rodata, 824K init, 960K bss, 71880K reserved, 0K cma-reserved, 72656K highmem)
[    0.000000] virtual kernel memory layout:
                   fixmap  : 0xffa96000 - 0xfffff000   (5540 kB)
                   pkmap   : 0xff400000 - 0xff800000   (4096 kB)
                   vmalloc : 0xf7bfe000 - 0xff3fe000   ( 120 MB)
                   lowmem  : 0xc0000000 - 0xf73fe000   ( 883 MB)
                     .init : 0xc3eeb000 - 0xc3fb9000   ( 824 kB)
                     .data : 0xc3b4f3a4 - 0xc3ee9100   (3687 kB)
                     .text : 0xc3400000 - 0xc3b4f3a4   (7484 kB)
[    0.000000] Checking if this processor honours the WP bit even in supervisor mode...Ok.
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 32.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=32 to nr_cpu_ids=4.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=32, nr_cpu_ids=4
[    0.000000] NR_IRQS:2304 nr_irqs:1024 0
[    0.000000] CPU 0 irqstacks, hard=f6480000 soft=f6482000
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] tsc: Detected 1332.800 MHz processor
[    0.000100] Calibrating delay loop (skipped), value calculated using timer frequency.. 2665.60 BogoMIPS (lpj=1332800)
[    0.000164] pid_max: default: 32768 minimum: 301
[    0.000305] ACPI: Core revision 20160930
[    0.085623] ACPI: 8 ACPI AML tables successfully acquired and loaded
[    0.087608] Security Framework initialized
[    0.087651] Yama: becoming mindful.
[    0.087694] SELinux:  Initializing.
[    0.087830] SELinux:  Starting in permissive mode
[    0.088100] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.088144] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.089529] CPU: Physical Processor ID: 0
[    0.089564] CPU: Processor Core ID: 0
[    0.089601] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.089632] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[    0.089674] mce: CPU supports 6 MCE banks
[    0.089720] CPU0: Thermal monitoring enabled (TM1)
[    0.089757] process: using mwait in idle threads
[    0.089802] Last level iTLB entries: 4KB 48, 2MB 0, 4MB 0
[    0.089835] Last level dTLB entries: 4KB 128, 2MB 16, 4MB 16, 1GB 0
[    0.090601] Freeing SMP alternatives memory: 32K
[    0.094193] efi: requested map not found.
[    0.094230] efi: Failed to lookup EFI memory descriptor for 0x26aa8000
[    0.094285] ftrace: allocating 29591 entries in 58 pages
[    0.168639] smpboot: Max logical packages: 1
[    0.168688] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.168831] TSC deadline timer enabled
[    0.168840] smpboot: CPU0: Intel(R) Atom(TM) CPU  Z3735G @ 1.33GHz (family: 0x6, model: 0x37, stepping: 0x8)
[    0.169307] Performance Events: PEBS fmt2+, 8-deep LBR, Silvermont events, 8-deep LBR, full-width counters, Intel PMU driver.
[    0.169417] ... version:                3
[    0.169444] ... bit width:              40
[    0.169470] ... generic registers:      2
[    0.169496] ... value mask:             000000ffffffffff
[    0.169524] ... max period:             0000007fffffffff
[    0.169551] ... fixed-purpose events:   3
[    0.169576] ... event mask:             0000000700000003
[    0.174367] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
[    0.174544] smp: Bringing up secondary CPUs ...
[    0.175403] CPU 1 irqstacks, hard=f6604000 soft=f6606000
[    0.175410] x86: Booting SMP configuration:
[    0.175444] .... node  #0, CPUs:      #1
[    0.175702] Initializing CPU#1
[    0.236995] CPU 2 irqstacks, hard=f6654000 soft=f6656000
[    0.237054]  #2
[    0.237167] Initializing CPU#2
[    0.298730] CPU 3 irqstacks, hard=f669a000 soft=f669c000
[    0.298782]  #3
[    0.298909] Initializing CPU#3
[    0.359171] Skipped synchronization checks as TSC is reliable.
[    0.359643] smp: Brought up 1 node, 4 CPUs
[    0.359678] smpboot: Total of 4 processors activated (10754.98 BogoMIPS)
[    0.362337] devtmpfs: initialized
[    0.364419] PM: Registering ACPI NVS region [mem 0x0008f000-0x0008ffff] (4096 bytes)
[    0.364473] PM: Registering ACPI NVS region [mem 0x3cd47000-0x3cdb6fff] (458752 bytes)
[    0.365029] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.365395] atomic64_test: passed for i586+ platform with CX8 and with SSE
[    0.365433] pinctrl core: initialized pinctrl subsystem
[    0.365643] RTC time: 16:23:00, date: 05/04/15
[    0.366350] NET: Registered protocol family 16
[    0.370247] cpuidle: using governor menu
[    0.371065] ACPI: bus type PCI registered
[    0.371102] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.371569] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xe0000000-0xe3ffffff] (base 0xe0000000)
[    0.371835] PCI: not using MMCONFIG
[    0.373578] PCI: Using configuration type 1 for base access
[    0.390254] HugeTLB registered 4 MB page size, pre-allocated 0 pages
[    0.391858] ACPI: Added _OSI(Module Device)
[    0.391895] ACPI: Added _OSI(Processor Device)
[    0.391926] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.391956] ACPI: Added _OSI(Processor Aggregator Device)
[    0.458581] ACPI: Dynamic OEM Table Load:
[    0.458670] ACPI: SSDT 0x00000000F640A800 000501 (v01 PmRef  Cpu0Ist  00003000 INTL 20130117)
[    0.460639] ACPI: Dynamic OEM Table Load:
[    0.460720] ACPI: SSDT 0x00000000F640B000 000433 (v01 PmRef  Cpu0Cst  00003001 INTL 20130117)
[    0.464475] ACPI: Dynamic OEM Table Load:
[    0.464552] ACPI: SSDT 0x00000000F670CE00 00015F (v01 PmRef  ApIst    00003000 INTL 20130117)
[    0.466326] ACPI: Dynamic OEM Table Load:
[    0.466402] ACPI: SSDT 0x00000000F66CAF00 00008D (v01 PmRef  ApCst    00003000 INTL 20130117)
[    0.478277] ACPI: Interpreter enabled
[    0.478479] ACPI: (supports S0 S5)
[    0.478512] ACPI: Using IOAPIC for interrupt routing
[    0.478762] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xe0000000-0xe3ffffff] (base 0xe0000000)
[    0.500271] [Firmware Info]: PCI: MMCONFIG at [mem 0xe0000000-0xe3ffffff] not reserved in ACPI motherboard resources
[    0.500330] PCI: not using MMCONFIG
[    0.500388] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.509417] ACPI: Power Resource [USBC] (on)
[    0.512001] ACPI: Power Resource [WWPR] (off)
[    0.534950] ACPI: Power Resource [PLPE] (on)
[    0.562572] ACPI: Power Resource [CLK0] (on)
[    0.563288] ACPI: Power Resource [P28P] (off)
[    0.563702] ACPI: Power Resource [P18P] (off)
[    0.572521] ACPI: Power Resource [CLK0] (on)
[    0.572958] ACPI: Power Resource [CLK1] (on)
[    0.595131] ACPI: Power Resource [P28X] (off)
[    0.595576] ACPI: Power Resource [P18X] (off)
[    0.596013] ACPI: Power Resource [P28T] (off)
[    0.596436] ACPI: Power Resource [P18T] (off)
[    0.596820] ACPI: Power Resource [P1XT] (off)
[    0.625008] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.625072] acpi PNP0A08:00: _OSC: OS supports [ASPM ClockPM Segments MSI]
[    0.625446] acpi PNP0A08:00: _OSC failed (AE_ERROR); disabling ASPM
[    0.625498] acpi PNP0A08:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.627561] PCI host bridge to bus 0000:00
[    0.627608] pci_bus 0000:00: root bus resource [io  0x0070-0x0077]
[    0.627647] pci_bus 0000:00: root bus resource [io  0x0000-0x006f window]
[    0.627685] pci_bus 0000:00: root bus resource [io  0x0078-0x0cf7 window]
[    0.627722] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.627759] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.627808] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff window]
[    0.627857] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000fffff window]
[    0.627907] pci_bus 0000:00: root bus resource [mem 0x50c00000-0x50ffffff window]
[    0.627956] pci_bus 0000:00: root bus resource [mem 0x3d000001-0x3f000000 window]
[    0.628005] pci_bus 0000:00: root bus resource [mem 0x40000000-0x508ffffe window]
[    0.628089] pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed40fff window]
[    0.628143] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.628209] pci 0000:00:00.0: [8086:0f00] type 00 class 0x060000
[    0.628766] pci 0000:00:02.0: [8086:0f31] type 00 class 0x030000
[    0.628813] pci 0000:00:02.0: reg 0x10: [mem 0x50000000-0x503fffff]
[    0.628850] pci 0000:00:02.0: reg 0x18: [mem 0x40000000-0x4fffffff pref]
[    0.628885] pci 0000:00:02.0: reg 0x20: [io  0x1000-0x1007]
[    0.629515] pci 0000:00:14.0: [8086:0f35] type 00 class 0x0c0330
[    0.629569] pci 0000:00:14.0: reg 0x10: [mem 0x50800000-0x5080ffff 64bit]
[    0.629729] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.630260] pci 0000:00:1a.0: [8086:0f18] type 00 class 0x108000
[    0.630316] pci 0000:00:1a.0: reg 0x10: [mem 0x50700000-0x507fffff]
[    0.630348] pci 0000:00:1a.0: reg 0x14: [mem 0x50600000-0x506fffff]
[    0.630552] pci 0000:00:1a.0: PME# supported from D0 D3hot
[    0.631053] pci 0000:00:1f.0: [8086:0f1c] type 00 class 0x060100
[    0.631681] pci_bus 0000:00: on NUMA node 0
[    0.634307] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.634894] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.635516] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.636090] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.636707] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.637279] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.637911] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.638567] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.692178] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.692228] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.692285] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.692315] vgaarb: loaded
[    0.692894] SCSI subsystem initialized
[    0.693181] libata version 3.00 loaded.
[    0.693390] ACPI: bus type USB registered
[    0.693562] usbcore: registered new interface driver usbfs
[    0.693666] usbcore: registered new interface driver hub
[    0.693868] usbcore: registered new device driver usb
[    0.694359] Registered efivars operations
[    0.708568] PCI: Using ACPI for IRQ routing
[    0.708612] PCI: pci_cache_line_size set to 64 bytes
[    0.708670] Expanded resource reserved due to conflict with PCI Bus 0000:00
[    0.708712] e820: reserve RAM buffer [mem 0x0008f000-0x0008ffff]
[    0.708722] e820: reserve RAM buffer [mem 0x0009e000-0x0009ffff]
[    0.708729] e820: reserve RAM buffer [mem 0x24a80000-0x27ffffff]
[    0.708736] e820: reserve RAM buffer [mem 0x3ba4e000-0x3bffffff]
[    0.708744] e820: reserve RAM buffer [mem 0x3bc6f000-0x3bffffff]
[    0.708753] e820: reserve RAM buffer [mem 0x3bc72000-0x3bffffff]
[    0.708759] e820: reserve RAM buffer [mem 0x3c800000-0x3fffffff]
[    0.708771] e820: reserve RAM buffer [mem 0x3ccc3000-0x3fffffff]
[    0.708780] e820: reserve RAM buffer [mem 0x3ce00000-0x3fffffff]
[    0.709549] NetLabel: Initializing
[    0.709583] NetLabel:  domain hash size = 128
[    0.709609] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.709744] NetLabel:  unlabeled traffic allowed by default
[    0.710682] clocksource: Switched to clocksource refined-jiffies
[    0.775286] VFS: Disk quotas dquot_6.6.0
[    0.775437] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.776038] pnp: PnP ACPI init
[    0.776461] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.776927] system 00:01: [io  0x0680-0x069f] has been reserved
[    0.776973] system 00:01: [io  0x0400-0x047f] has been reserved
[    0.777011] system 00:01: [io  0x0500-0x05fe] has been reserved
[    0.777084] system 00:01: [io  0x0600-0x061f] has been reserved
[    0.777127] system 00:01: [io  0x164e-0x164f] has been reserved
[    0.777177] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.777958] pnp 00:02: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.789520] pnp: PnP ACPI: found 3 devices
[    0.806406] pci_bus 0000:00: resource 4 [io  0x0070-0x0077]
[    0.806421] pci_bus 0000:00: resource 5 [io  0x0000-0x006f window]
[    0.806433] pci_bus 0000:00: resource 6 [io  0x0078-0x0cf7 window]
[    0.806444] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    0.806456] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff window]
[    0.806468] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff window]
[    0.806479] pci_bus 0000:00: resource 10 [mem 0x000e0000-0x000fffff window]
[    0.806491] pci_bus 0000:00: resource 11 [mem 0x50c00000-0x50ffffff window]
[    0.806502] pci_bus 0000:00: resource 12 [mem 0x3d000001-0x3f000000 window]
[    0.806513] pci_bus 0000:00: resource 13 [mem 0x40000000-0x508ffffe window]
[    0.806524] pci_bus 0000:00: resource 14 [mem 0xfed40000-0xfed40fff window]
[    0.807016] NET: Registered protocol family 2
[    0.808252] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    0.808385] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
[    0.808568] TCP: Hash tables configured (established 8192 bind 8192)
[    0.808683] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    0.808751] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    0.809066] NET: Registered protocol family 1
[    0.809172] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.810185] PCI: CLS 0 bytes, default 64
[    0.810576] Unpacking initramfs...
[    3.206994] Freeing initrd memory: 17948K
[    3.207699] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x133626f6b26, max_idle_ns: 440795214178 ns
[    3.207819] clocksource: Switched to clocksource tsc
[    3.211261] apm: BIOS version 115.85 Flags 0x616f (Driver version 1.16ac)
[    3.211305] apm: disabled - APM is not SMP safe.
[    3.214111] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    3.214289] audit: initializing netlink subsys (disabled)
[    3.214567] audit: type=2000 audit(1430756582.645:1): initialized
[    3.216007] Initialise system trusted keyrings
[    3.216561] workingset: timestamp_bits=14 max_order=18 bucket_order=4
[    3.229968] zbud: loaded
[    3.233467] SELinux:  Registering netfilter hooks
[   12.468232] NET: Registered protocol family 38
[   12.468280] Key type asymmetric registered
[   12.468311] Asymmetric key parser 'x509' registered
[   12.468439] bounce: pool size: 64 pages
[   12.468786] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[   12.469030] io scheduler noop registered
[   12.469064] io scheduler deadline registered
[   12.469602] io scheduler cfq registered (default)
[   12.471791] efifb: probing for efifb
[   12.471910] efifb: framebuffer at 0x40000000, using 4000k, total 4000k
[   12.471946] efifb: mode is 800x1280x32, linelength=3200, pages=1
[   12.471974] efifb: scrolling: redraw
[   12.472006] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[   12.515298] Console: switching to colour frame buffer device 100x80
[   12.556402] fb0: EFI VGA frame buffer device
[   12.556745] intel_idle: MWAIT substates: 0x33000020
[   12.556753] intel_idle: v0.4.1 model 0x37
[   12.558246] intel_idle: lapic_timer_reliable_states 0xffffffff
[   12.558811] ACPI: AC Adapter [ADP1] (off-line)
[   12.575783] [Firmware Bug]: No valid trip found
[   12.576376] GHES: HEST is not enabled!
[   12.577617] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[   12.598896] 00:02: ttyS0 at I/O 0x3f8 (irq = 201, base_baud = 115200) is a 16550A
[   12.629724] 80860F0A:00: ttyS4 at MMIO 0x5091b000 (irq = 191, base_baud = 2764800) is a 16550A
[   12.643225] 80860F0A:01: ttyS5 at MMIO 0x5091d000 (irq = 192, base_baud = 2764800) is a 16550A
[   12.646421] hpet: number irqs doesn't agree with number of timers
[   12.647441] Non-volatile memory driver v1.3
[   12.648185] Linux agpgart interface v0.103
[   12.653278] libphy: Fixed MDIO Bus: probed
[   12.654263] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   12.654713] ehci-pci: EHCI PCI platform driver
[   12.655083] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   12.655581] ohci-pci: OHCI PCI platform driver
[   12.655951] uhci_hcd: USB Universal Host Controller Interface driver
[   12.657194] xhci_hcd 0000:00:14.0: xHCI Host Controller
[   12.658042] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[   12.659779] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x00009810
[   12.660373] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
[   12.660884] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[   12.661370] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   12.661841] usb usb1: Product: xHCI Host Controller
[   12.662194] usb usb1: Manufacturer: Linux 4.10.0-rc1+ xhci-hcd
[   12.662578] usb usb1: SerialNumber: 0000:00:14.0
[   12.664039] hub 1-0:1.0: USB hub found
[   12.664397] hub 1-0:1.0: 6 ports detected
[   13.208348] xhci_hcd 0000:00:14.0: xHCI Host Controller
[   13.209261] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[   13.210302] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003
[   13.210752] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   13.211260] usb usb2: Product: xHCI Host Controller
[   13.211587] usb usb2: Manufacturer: Linux 4.10.0-rc1+ xhci-hcd
[   13.211966] usb usb2: SerialNumber: 0000:00:14.0
[   13.213478] hub 2-0:1.0: USB hub found
[   13.213794] hub 2-0:1.0: 1 port detected
[   13.215339] usbcore: registered new interface driver usbserial
[   13.215776] usbcore: registered new interface driver usbserial_generic
[   13.216289] usbserial: USB Serial support registered for generic
[   13.216866] i8042: PNP: No PS/2 controller found.
[   13.217597] mousedev: PS/2 mouse device common for all mice
[   13.218404] ACPI Warning: Could not enable fixed event - RealTimeClock (4) (20160930/evxface-654)
[   13.219638] rtc_cmos 00:00: rtc core: registered rtc_cmos as rtc0
[   13.220168] rtc_cmos 00:00: alarms up to one month, y3k, 242 bytes nvram
[   13.221265] device-mapper: uevent: version 1.0.3
[   13.222597] device-mapper: ioctl: 4.35.0-ioctl (2016-06-23) initialised: dm-devel@redhat.com
[   13.224199] intel_pstate: Intel P-state driver initializing
[   13.227200] hidraw: raw HID events driver (C) Jiri Kosina
[   13.227842] usbcore: registered new interface driver usbhid
[   13.228239] usbhid: USB HID core driver
[   13.248863] drop_monitor: Initializing network drop monitor service
[   13.254898] ip_tables: (C) 2000-2006 Netfilter Core Team
[   13.261316] Initializing XFRM netlink socket
[   13.267061] NET: Registered protocol family 10
[   13.274571] Segment Routing with IPv6
[   13.280856] mip6: Mobile IPv6
[   13.286212] NET: Registered protocol family 17
[   13.297432] microcode: sig=0x30678, pf=0x2, revision=0x0
[   13.317549] microcode: Microcode Update Driver: v2.2.
[   13.317558] Using IPI No-Shortcut mode
[   13.402628] registered taskstats version 1
[   13.422154] Loading compiled-in X.509 certificates
[   13.428182] zswap: loaded using pool lzo/zbud
[   13.480337] Key type big_key registered
[   13.498560]   Magic number: 15:811:387
[   13.504675] thermal cooling_device2: hash matches
[   13.510720] rtc_cmos 00:00: setting system clock to 2015-05-04 16:23:13 UTC (1430756593)
[   13.516779] PM: Hibernation image not present or could not be loaded.
[   13.517398] Freeing unused kernel memory: 824K
[   13.523141] Write protecting the kernel text: 7488k
[   13.529476] Write protecting the kernel read-only data: 2892k
[   13.540802] systemd[1]: System time before build time, advancing clock.
[   13.561525] random: systemd: uninitialized urandom read (16 bytes read)
[   13.567811] random: systemd: uninitialized urandom read (16 bytes read)
[   13.577893] systemd[1]: systemd 229 running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
[   13.604084] usb 1-1: new high-speed USB device number 2 using xhci_hcd
[   13.610398] systemd[1]: Detected architecture x86.
[   13.616006] systemd[1]: Running in initial RAM disk.
[   13.638299] systemd[1]: Set hostname to <wintab8>.
[   13.793713] usb 1-1: New USB device found, idVendor=0bda, idProduct=8187
[   13.803954] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[   13.811111] usb 1-1: Product: RTL8187B_WLAN_Adapter
[   13.818023] usb 1-1: Manufacturer: Manufacturer_Realtek
[   13.818856] random: systemd: uninitialized urandom read (16 bytes read)
[   13.818998] random: systemd: uninitialized urandom read (16 bytes read)
[   13.819275] random: systemd: uninitialized urandom read (16 bytes read)
[   13.831950] random: systemd: uninitialized urandom read (16 bytes read)
[   13.833297] random: systemd: uninitialized urandom read (16 bytes read)
[   13.836321] random: systemd: uninitialized urandom read (16 bytes read)
[   13.836397] random: systemd: uninitialized urandom read (16 bytes read)
[   13.839825] random: systemd: uninitialized urandom read (16 bytes read)
[   13.845247] systemd[1]: Listening on udev Control Socket.
[   13.871808] usb 1-1: SerialNumber: 00e04c000001
[   13.897072] systemd[1]: Reached target Timers.
[   13.908089] systemd[1]: Listening on Journal Socket.
[   13.918622] systemd[1]: Reached target Local File Systems.
[   13.929115] systemd[1]: Reached target Swap.
[   13.939583] systemd[1]: Listening on Journal Socket (/dev/log).
[   14.059939] audit: type=1130 audit(1455208080.517:2): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=kmod-static-nodes comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   14.087108] audit: type=1130 audit(1455208080.544:3): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-sysctl comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   14.115477] audit: type=1130 audit(1455208080.573:4): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-journald comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   14.153351] audit: type=1130 audit(1455208080.611:5): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-tmpfiles-setup-dev comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   14.210463] audit: type=1130 audit(1455208080.668:6): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-vconsole-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   14.337571] audit: type=1130 audit(1455208080.795:7): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-cmdline comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   14.476806] audit: type=1130 audit(1455208080.933:8): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-pre-udev comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   14.545865] audit: type=1130 audit(1455208081.003:9): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-udevd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   14.608225] audit: type=1130 audit(1455208081.066:10): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-pre-trigger comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   14.785192] sdhci: Secure Digital Host Controller Interface driver
[   14.785194] sdhci: Copyright(c) Pierre Ossman
[   14.788458] mmc0: SDHCI controller on ACPI [INT33BB:00] using ADMA
[   14.805095] mmc1: SDHCI controller on ACPI [80860F14:00] using ADMA
[   14.820964] mmc2: SDHCI controller on ACPI [80860F14:02] using ADMA
[   14.834397] audit: type=1130 audit(1455208081.292:11): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-udev-trigger comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   14.868109] FUJITSU Extended Socket Network Device Driver - version 1.2 - Copyright (c) 2015 FUJITSU LIMITED
[   14.925869] mmc0: new high speed SDIO card at address 0001
[   14.937930] [drm] Memory usable by graphics device = 2048M
[   14.948345] checking generic (40000000 3e8000) vs hw (40000000 10000000)
[   14.948348] fb: switching to inteldrmfb from EFI VGA
[   14.958909] Console: switching to colour dummy device 80x25
[   14.959156] [drm] Replacing VGA console driver
[   14.959528] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   14.959540] [drm] Driver supports precise vblank timestamp query.
[   14.962833] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
[   14.964726] [drm:pwm_setup_backlight [i915]] *ERROR* Failed to own the pwm chip
[   14.967414] mmc2: new high speed SDHC card at address 1234
[   14.988096] mmc1: new HS200 MMC card at address 0001
[   15.016054] mmcblk2: mmc2:1234 SA08G 7.41 GiB
[   15.018378]  mmcblk2: p1 p2
[   15.020484] mmcblk1: mmc1:0001 016GE2 14.7 GiB
[   15.020734] mmcblk1boot0: mmc1:0001 016GE2 partition 1 4.00 MiB
[   15.020952] mmcblk1boot1: mmc1:0001 016GE2 partition 2 4.00 MiB
[   15.021879] mmcblk1rpmb: mmc1:0001 016GE2 partition 3 4.00 MiB
[   15.024643]  mmcblk1: p1 p2
[   15.031003] random: fast init done
[   15.136542] [drm] Initialized i915 1.6.0 20161226 for 0000:00:02.0 on minor 0
[   15.138514] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[   15.139864] acpi device:21: registered as cooling_device4
[   15.140035] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input0
[   15.140314] [drm] Initialized i915 1.6.0 20161226 for 0000:00:02.0 on minor 0
[   15.296497] fbcon: inteldrmfb (fb0) is primary device
[   17.020717] Console: switching to colour frame buffer device 100x80
[   17.224728] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
[   22.699225] kauditd_printk_skb: 6 callbacks suppressed
[   22.699334] audit: type=1130 audit(1455208089.156:14): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-fsck-root comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   22.765600] EXT4-fs (mmcblk1p2): mounted filesystem with ordered data mode. Opts: (null)
[   23.085383] audit: type=1130 audit(1455208089.543:15): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=initrd-parse-etc comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   23.085772] audit: type=1131 audit(1455208089.543:16): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=initrd-parse-etc comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   23.385827] audit: type=1130 audit(1455208089.842:17): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-pre-pivot comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   23.413249] audit: type=1130 audit(1455208089.871:18): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=initrd-cleanup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   23.413937] audit: type=1131 audit(1455208089.871:19): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=initrd-cleanup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   23.422115] audit: type=1131 audit(1455208089.879:20): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-pre-pivot comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   23.424744] audit: type=1130 audit(1455208089.882:21): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-initqueue comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   23.425191] audit: type=1131 audit(1455208089.883:22): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-initqueue comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   23.446714] audit: type=1130 audit(1455208089.903:23): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-sysctl comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   23.694677] systemd-journald[167]: Received SIGTERM from PID 1 (systemd).
[   23.775514] systemd: 13 output lines suppressed due to ratelimiting
[   23.970525] SELinux:  Disabled at runtime.
[   23.990075] SELinux:  Unregistering netfilter hooks
[   24.021800] systemd[1]: System time before build time, advancing clock.
[   24.481262] RPC: Registered named UNIX socket transport module.
[   24.481264] RPC: Registered udp transport module.
[   24.481265] RPC: Registered tcp transport module.
[   24.481265] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   24.520411] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   24.632626] EXT4-fs (mmcblk1p2): re-mounted. Opts: (null)
[   24.823013] systemd-journald[450]: Received request to flush runtime journal from PID 1
[   25.030747] random: crng init done
[   25.316774] Bluetooth: Core ver 2.22
[   25.323380] NET: Registered protocol family 31
[   25.329879] Bluetooth: HCI device and connection manager initialized
[   25.336395] Bluetooth: HCI socket layer initialized
[   25.342933] Bluetooth: L2CAP socket layer initialized
[   25.349486] Bluetooth: SCO socket layer initialized
[   25.369079] Bluetooth: HCI UART driver ver 2.3
[   25.375631] Bluetooth: HCI UART protocol H4 registered
[   25.382105] Bluetooth: HCI UART protocol BCSP registered
[   25.388513] Bluetooth: HCI UART protocol LL registered
[   25.394865] Bluetooth: HCI UART protocol ATH3K registered
[   25.401116] Bluetooth: HCI UART protocol Three-wire (H5) registered
[   25.407457] Bluetooth: HCI UART protocol Intel registered
[   25.414172] Bluetooth: HCI UART protocol Broadcom registered
[   25.420353] Bluetooth: HCI UART protocol QCA registered
[   25.426544] Bluetooth: HCI UART protocol AG6XX registered
[   25.432844] dw_dmac INTL9C60:00: Missing DT data
[   25.451705] dw_dmac INTL9C60:00: DesignWare DMA Controller, 8 channels
[   25.482520] i2c_hid i2c-FTSC1000:00: Fetching the HID descriptor
[   25.482526] i2c_hid i2c-FTSC1000:00: __i2c_hid_command: cmd=00 00
[   25.485871] i2c_hid i2c-FTSC1000:00: HID Descriptor: 1e 00 00 01 1f 02 02 00 03 00 42 00 04 00 42 00 05 00 06 00 08 28 56 50 00 02 00 00 00 00
[   25.487297] i2c_hid i2c-FTSC1000:00: entering i2c_hid_parse
[   25.487301] i2c_hid i2c-FTSC1000:00: i2c_hid_hwreset
[   25.487304] i2c_hid i2c-FTSC1000:00: i2c_hid_set_power
[   25.487308] i2c_hid i2c-FTSC1000:00: __i2c_hid_command: cmd=05 00 00 08
[   25.488275] i2c_hid i2c-FTSC1000:00: resetting...
[   25.488281] i2c_hid i2c-FTSC1000:00: __i2c_hid_command: cmd=05 00 00 01
[   25.490851] i2c_hid i2c-FTSC1000:00: __i2c_hid_command: waiting...
[   25.775699] rtl8187: inconsistency between id with OEM info!
[   25.815992] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
[   25.816821] ieee80211 phy0: hwaddr 00:0e:2e:ec:ac:f0, RTL8187BvB(early) V0 + rtl8225z2, rfkill mask 2
[   25.844619] rtl8187: Customer ID is 0x00
[   25.845483] rtl8187: wireless switch is on
[   25.845548] usbcore: registered new interface driver rtl8187
[   30.743613] i2c_hid i2c-FTSC1000:00: __i2c_hid_command: finished.
[   30.743625] i2c_hid i2c-FTSC1000:00: failed to reset device.
[   30.764913] i2c_hid i2c-FTSC1000:00: i2c_hid_set_power
[   30.764926] i2c_hid i2c-FTSC1000:00: __i2c_hid_command: cmd=05 00 01 08
[   31.831588] i2c_hid i2c-FTSC1000:00: i2c_hid_hwreset
[   31.831601] i2c_hid i2c-FTSC1000:00: i2c_hid_set_power
[   31.831612] i2c_hid i2c-FTSC1000:00: __i2c_hid_command: cmd=05 00 00 08
[   31.831863] i2c_hid i2c-FTSC1000:00: failed to change power setting.
[   32.919634] i2c_hid i2c-FTSC1000:00: i2c_hid_hwreset
[   32.919647] i2c_hid i2c-FTSC1000:00: i2c_hid_set_power
[   32.919658] i2c_hid i2c-FTSC1000:00: __i2c_hid_command: cmd=05 00 00 08
[   32.919919] i2c_hid i2c-FTSC1000:00: failed to change power setting.
[   34.007589] i2c_hid i2c-FTSC1000:00: i2c_hid_hwreset
[   34.007603] i2c_hid i2c-FTSC1000:00: i2c_hid_set_power
[   34.007614] i2c_hid i2c-FTSC1000:00: __i2c_hid_command: cmd=05 00 00 08
[   34.007874] i2c_hid i2c-FTSC1000:00: failed to change power setting.
[   35.095585] i2c_hid i2c-FTSC1000:00: can't add hid device: -121
[   35.152943] i2c_hid: probe of i2c-FTSC1000:00 failed with error -121
[   35.199350] i2c_designware 80860F41:04: I2C bus managed by PUNIT
[   35.231685] ACPI: Battery Slot [BMBT] (battery present)
[   35.238216] [Firmware Bug]: No valid trip found
[   35.257208] dw_dmac INTL9C60:01: Missing DT data
[   35.276786] dw_dmac INTL9C60:01: DesignWare DMA Controller, 8 channels
[   35.296097] intel_sst_acpi 80860F28:00: Detected Baytrail-CR platform
[   35.303639] intel_sst_acpi 80860F28:00: LPE base: 0x50a00000 size:0x200000
[   35.310876] intel_sst_acpi 80860F28:00: IRAM base: 0x50ac0000
[   35.318075] intel_sst_acpi 80860F28:00: DRAM base: 0x50b00000
[   35.325753] intel_sst_acpi 80860F28:00: SHIM base: 0x50b40000
[   35.333279] intel_sst_acpi 80860F28:00: Mailbox base: 0x50b44000
[   35.340263] intel_sst_acpi 80860F28:00: DDR base: 0x20000000
[   35.348189] intel_sst_acpi 80860F28:00: Got drv data max stream 25
[   35.359189] input: PC Speaker as /devices/platform/pcspkr/input/input1
[   35.474199] (NULL device *): hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
[   35.495746] (NULL device *): hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
[   35.521898] intel_rapl: Found RAPL domain package
[   35.521900] intel_rapl: Found RAPL domain core
[   35.548075] genirq: Flags mismatch irq 8. 00000083 (volume_down) vs. 00000080 (rtc0)
[   35.548080] CPU: 2 PID: 499 Comm: systemd-udevd Not tainted 4.10.0-rc1+ #2
[   35.548082] Hardware name: AXDIA International GmbH Wintab Gen 8/Type2 - Board Product Name, BIOS AD890.1.02.022 09/25/2014
[   35.548083] Call Trace:
[   35.548096]  dump_stack+0x58/0x78
[   35.548103]  __setup_irq+0x53c/0x590
[   35.548111]  request_threaded_irq+0xed/0x1e0
[   35.548120]  ? get_n_events_by_type.part.4+0x10/0x10 [gpio_keys]
[   35.548123]  request_any_context_irq+0x46/0x80
[   35.548128]  ? get_n_events_by_type.part.4+0x10/0x10 [gpio_keys]
[   35.548131]  devm_request_any_context_irq+0x57/0xa0
[   35.548141]  gpio_keys_probe+0x217/0x830 [gpio_keys]
[   35.548146]  ? get_n_events_by_type.part.4+0x10/0x10 [gpio_keys]
[   35.548151]  platform_drv_probe+0x47/0xb0
[   35.548155]  driver_probe_device+0x291/0x470
[   35.548160]  ? acpi_driver_match_device+0x3b/0x55
[   35.548164]  __driver_attach+0xe9/0xf0
[   35.548169]  ? klist_next+0x1b/0xf0
[   35.548172]  ? kfree_const+0x25/0x30
[   35.548175]  ? driver_probe_device+0x470/0x470
[   35.548178]  bus_for_each_dev+0x57/0xa0
[   35.548182]  driver_attach+0x1e/0x20
[   35.548185]  ? driver_probe_device+0x470/0x470
[   35.548188]  bus_add_driver+0x17f/0x270
[   35.548192]  ? 0xf7f11000
[   35.548195]  driver_register+0x5d/0xf0
[   35.548199]  ? __wake_up+0x3f/0x50
[   35.548201]  ? 0xf7f11000
[   35.548205]  __platform_driver_register+0x2f/0x40
[   35.548209]  gpio_keys_init+0x12/0x1000 [gpio_keys]
[   35.548212]  do_one_initcall+0x46/0x1a0
[   35.548215]  ? 0xf82fa000
[   35.548220]  ? kmem_cache_alloc_trace+0x155/0x1c0
[   35.548224]  ? do_init_module+0x21/0x1c7
[   35.548227]  ? do_init_module+0x21/0x1c7
[   35.548230]  do_init_module+0x50/0x1c7
[   35.548240]  load_module+0x21c8/0x2820
[   35.548245]  ? vfs_read+0x117/0x150
[   35.548250]  SyS_finit_module+0xb0/0x100
[   35.548253]  ? syscall_trace_enter+0x237/0x260
[   35.548257]  do_fast_syscall_32+0x8a/0x150
[   35.548261]  entry_SYSENTER_32+0x4e/0x7c
[   35.548263] EIP: 0xb76e8ce5
[   35.548265] EFLAGS: 00000246 CPU: 2
[   35.548267] EAX: ffffffda EBX: 00000007 ECX: b7676121 EDX: 00000000
[   35.548269] ESI: 8164bff0 EDI: 8163e4d8 EBP: 8163e458 ESP: bfdd9eac
[   35.548272]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
[   35.548305] gpio-keys gpio-keys.0.auto: Unable to claim irq 8; error -16
[   35.548348] gpio-keys: probe of gpio-keys.0.auto failed with error -16
[   35.548525] input: gpio-keys as /devices/platform/gpio-keys.1.auto/input/input3
[   35.613979] iTCO_vendor_support: vendor-support=0
[   35.642560] bytcr_rt5640 bytcr_rt5640: BIOS Routing: AIF1 connected
[   35.642567] bytcr_rt5640 bytcr_rt5640: quirk IN1_MAP enabled
[   35.642570] bytcr_rt5640 bytcr_rt5640: quirk DIFF_MIC enabled
[   35.642572] bytcr_rt5640 bytcr_rt5640: quirk SSP0_AIF1 enabled
[   35.642575] bytcr_rt5640 bytcr_rt5640: quirk MCLK_EN enabled
[   35.642582] bytcr_rt5640 bytcr_rt5640: Failed to get MCLK from pmc_plt_clk_3: -2
[   35.642592] bytcr_rt5640: probe of bytcr_rt5640 failed with error -2
[   35.670476] rtl8187 1-1:1.0 wlp0s20u1: renamed from wlan0
[   35.671218] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[   35.671355] iTCO_wdt: Found a Bay Trail SoC TCO device (Version=3, TCOBASE=0x0460)
[   35.671689] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[   36.051302] kauditd_printk_skb: 126 callbacks suppressed
[   36.051309] audit: type=1130 audit(1469476199.027:66): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-rfkill comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   36.297968] audit: type=1130 audit(1469476199.272:67): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-udev-settle comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   36.391952] audit: type=1130 audit(1469476199.367:68): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=dmraid-activation comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   36.391973] audit: type=1131 audit(1469476199.368:69): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=dmraid-activation comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   36.550288] audit: type=1130 audit(1469476199.525:70): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=dracut-shutdown comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   36.575787] audit: type=1130 audit(1469476199.552:71): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=nfs-config comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   36.575798] audit: type=1131 audit(1469476199.552:72): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=nfs-config comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   36.624967] audit: type=1130 audit(1469476199.601:73): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=fedora-import-state comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   36.654873] audit: type=1130 audit(1469476199.631:74): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=plymouth-read-write comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   36.654895] audit: type=1131 audit(1469476199.631:75): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=plymouth-read-write comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   39.807427] ip6_tables: (C) 2000-2006 Netfilter Core Team
[   39.874753] Ebtables v2.0 registered
[   39.955057] nf_conntrack version 0.5.0 (15360 buckets, 61440 max)
[   40.115540] bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
[   40.170634] Netfilter messages via NETLINK v0.30.
[   40.185529] ip_set: protocol 6
[   40.276700] IPv6: ADDRCONF(NETDEV_UP): wlp0s20u1: link is not ready
[   42.814720] IPv6: ADDRCONF(NETDEV_UP): wlp0s20u1: link is not ready
[   43.983934] fuse init (API version 7.26)
[   45.739420] IPv6: ADDRCONF(NETDEV_UP): wlp0s20u1: link is not ready
[   45.885316] IPv6: ADDRCONF(NETDEV_UP): wlp0s20u1: link is not ready
[   46.111625] tun: Universal TUN/TAP device driver, 1.6
[   46.111633] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[   46.133765] virbr0: port 1(virbr0-nic) entered blocking state
[   46.133775] virbr0: port 1(virbr0-nic) entered disabled state
[   46.133951] device virbr0-nic entered promiscuous mode
[   46.506952] virbr0: port 1(virbr0-nic) entered blocking state
[   46.506964] virbr0: port 1(virbr0-nic) entered listening state
[   46.569734] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   46.569748] Bluetooth: BNEP filters: protocol multicast
[   46.569759] Bluetooth: BNEP socket layer initialized
[   46.588584] virbr0: port 1(virbr0-nic) entered disabled state
[   50.524866] IPv6: ADDRCONF(NETDEV_UP): wlp0s20u1: link is not ready
