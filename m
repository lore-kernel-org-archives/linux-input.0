From: Sebastian Schmidt <yath@yath.de>
Subject: Re: PROBLEM: Changing speed on ThinkPad X1 Carbon 5th trackpoint
 causes "failed to enable mouse"
Date: Thu, 28 Dec 2017 15:28:55 +0100
Message-ID: <20171228142855.GA2007@marax.lan.yath.de>
References: <20171228091125.GA743@marax.lan.yath.de>
 <c6427787-112c-d6f7-4f77-ae44c6aebb2f@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from karr.yath.de ([144.76.4.50]:53530 "EHLO karr.yath.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751411AbdL1O3A (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 28 Dec 2017 09:29:00 -0500
Content-Disposition: inline
In-Reply-To: <c6427787-112c-d6f7-4f77-ae44c6aebb2f@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aaron Ma <aaron.ma@canonical.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

On Thu, Dec 28, 2017 at 06:56:36PM +0800, Aaron Ma wrote:
> I haven't met your issue on X1 Carbon 5th, but Lenovo did ship different
> touchapd/trackpoint on X1 Carbon 5th. And you didn't provide the whole
> dmesg with pnd ID in it. so I can't tell if the hardware or firmware is
> the same as I tested.

Sorry. I have attached a full dmesg below.

> Could you try smbus mode first on mainline kernel?
> 
> 1, download kernel package from:
> http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.15-rc5/
>    I am not sure if it can be installed and work well on debian.
>    It enabled RMI4_SMB and SYNAPTICS_SMBUS.
> 2, boot with this kernel with "psmouse.synaptics_intertouch=1" in your
> kernel cmdline.

I’ve re-built my kernel with RMI4_SMB set and booted with
psmouse.synaptics_intertouch=1, which gave the device a new sysfs path
and the Touchpad’s(!) name changed to “Synaptics TM3289-002”. I can’t
say that the pointer’s speed changed, and an attempt to re-set the speed
to 97 resulted in the same error (cf. dmesg). Just for clarification:
The trackpoint *does* work initially, albeit too fast for me. Setting
the speed to anything causes it to break.

> If trackpoint still can not work, please send me the dmesg.

I can’t attach a dmesg of the kernel-ppa, because, seriously, there is a
keylogger included?!?

[    0.666583] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input3
[   10.836870] evbug: Connected device: input3 (AT Translated Set 2 keyboard at isa0060/serio0/input0)

and then, for every keypress, a load of these in dmesg:
[   60.585982] evbug: Event. Dev: input3, Type: 4, Code: 4, Value: 20
[   60.585984] evbug: Event. Dev: input3, Type: 1, Code: 20, Value: 1
[   60.585985] evbug: Event. Dev: input3, Type: 0, Code: 0, Value: 0
[   60.586145] evbug: Event. Dev: input3, Type: 4, Code: 4, Value: 45
[   60.586147] evbug: Event. Dev: input3, Type: 1, Code: 45, Value: 0

I’m not convinced that my password can’t be reconstructed from this and
surprised that Ubuntu includes this, er, facility in the kernels
recommended by <https://wiki.ubuntu.com/Kernel/MainlineBuilds>. I only
have to go on and clean my log files now, but users with remote logging
not controlled by them (and crash reporting facilities that include a
dmesg output) don’t have this opportunity. But this is a separate
discussion I’ll have with the Ubuntu security folks.

Thanks,

Sebastian

Full dmesg:
[    0.000000] Linux version 4.15.0-rc5 (yath@marax) (gcc version 7.2.0 (Debian 7.2.0-18)) #1 SMP Thu Dec 28 13:34:19 CET 2017
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-4.15.0-rc5 root=/dev/mapper/vg0-root ro net.ifnames=0 psmouse.synaptics_intertouch=1
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.000000] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.000000] x86/fpu: Enabled xstate features 0x1f, context size is 960 bytes, using 'compacted' format.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000057fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000058000-0x0000000000058fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000059000-0x000000000008bfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000008c000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000045021fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000045022000-0x0000000045022fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000045023000-0x0000000045023fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000045024000-0x000000004e965fff] usable
[    0.000000] BIOS-e820: [mem 0x000000004e966000-0x000000004ea2dfff] type 20
[    0.000000] BIOS-e820: [mem 0x000000004ea2e000-0x000000004ff2cfff] reserved
[    0.000000] BIOS-e820: [mem 0x000000004ff2d000-0x000000004ff4cfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000004ff4d000-0x000000004ff4dfff] reserved
[    0.000000] BIOS-e820: [mem 0x000000004ff4e000-0x000000004ff99fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000004ff9a000-0x000000004fffefff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000004ffff000-0x000000004fffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000050000000-0x0000000057ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000058600000-0x000000005c7fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f0000000-0x00000000f7ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fe010000-0x00000000fe010fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x00000004a17fffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.50 by Lenovo
[    0.000000] efi:  SMBIOS=0x4f0c0000  SMBIOS 3.0=0x4f0bd000  ACPI=0x4fffe000  ACPI 2.0=0x4fffe014  MPS=0x4f469000  MEMATTR=0x49608018 
[    0.000000] random: fast init done
[    0.000000] SMBIOS 3.0.0 present.
[    0.000000] DMI: LENOVO 20HRCTO1WW/20HRCTO1WW, BIOS N1MET39W (1.24 ) 09/27/2017
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x4a1800 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: write-back
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 0080000000 mask 7F80000000 uncachable
[    0.000000]   1 base 0060000000 mask 7FE0000000 uncachable
[    0.000000]   2 base 005C000000 mask 7FFC000000 uncachable
[    0.000000]   3 base 005A000000 mask 7FFE000000 uncachable
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000]   8 disabled
[    0.000000]   9 disabled
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000000] e820: last_pfn = 0x50000 max_arch_pfn = 0x400000000
[    0.000000] Base memory trampoline at [        (ptrval)] 60000 size 24576
[    0.000000] Using GB pages for direct mapping
[    0.000000] BRK [0x13b603000, 0x13b603fff] PGTABLE
[    0.000000] BRK [0x13b604000, 0x13b604fff] PGTABLE
[    0.000000] BRK [0x13b605000, 0x13b605fff] PGTABLE
[    0.000000] BRK [0x13b606000, 0x13b606fff] PGTABLE
[    0.000000] BRK [0x13b607000, 0x13b607fff] PGTABLE
[    0.000000] BRK [0x13b608000, 0x13b608fff] PGTABLE
[    0.000000] BRK [0x13b609000, 0x13b609fff] PGTABLE
[    0.000000] BRK [0x13b60a000, 0x13b60afff] PGTABLE
[    0.000000] BRK [0x13b60b000, 0x13b60bfff] PGTABLE
[    0.000000] Secure boot could not be determined
[    0.000000] RAMDISK: [mem 0x34e6b000-0x3672cfff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x000000004FFFE014 000024 (v02 LENOVO)
[    0.000000] ACPI: XSDT 0x000000004FFC2188 0000FC (v01 LENOVO TP-N1M   00001240 PTEC 00000002)
[    0.000000] ACPI: FACP 0x000000004FFF5000 0000F4 (v05 LENOVO TP-N1M   00001240 PTEC 00000002)
[    0.000000] ACPI: DSDT 0x000000004FFD0000 020B92 (v02 LENOVO SKL      00000000 INTL 20160527)
[    0.000000] ACPI: FACS 0x000000004FF3C000 000040
[    0.000000] ACPI: SSDT 0x000000004FFFC000 0003CC (v02 LENOVO Tpm2Tabl 00001000 INTL 20160527)
[    0.000000] ACPI: TPM2 0x000000004FFFB000 000034 (v03 LENOVO TP-N1M   00001240 PTEC 00000002)
[    0.000000] ACPI: UEFI 0x000000004FF53000 000042 (v01 LENOVO TP-N1M   00001240 PTEC 00000002)
[    0.000000] ACPI: SSDT 0x000000004FFF7000 003235 (v02 LENOVO SaSsdt   00003000 INTL 20160527)
[    0.000000] ACPI: SSDT 0x000000004FFF6000 0005B6 (v02 LENOVO PerfTune 00001000 INTL 20160527)
[    0.000000] ACPI: HPET 0x000000004FFF4000 000038 (v01 LENOVO TP-N1M   00001240 PTEC 00000002)
[    0.000000] ACPI: APIC 0x000000004FFF3000 0000BC (v03 LENOVO TP-N1M   00001240 PTEC 00000002)
[    0.000000] ACPI: MCFG 0x000000004FFF2000 00003C (v01 LENOVO TP-N1M   00001240 PTEC 00000002)
[    0.000000] ACPI: ECDT 0x000000004FFF1000 000053 (v01 LENOVO TP-N1M   00001240 PTEC 00000002)
[    0.000000] ACPI: SSDT 0x000000004FFCE000 001627 (v02 LENOVO ProjSsdt 00000010 INTL 20160527)
[    0.000000] ACPI: BOOT 0x000000004FFCD000 000028 (v01 LENOVO TP-N1M   00001240 PTEC 00000002)
[    0.000000] ACPI: BATB 0x000000004FFCC000 00004A (v02 LENOVO TP-N1M   00001240 PTEC 00000002)
[    0.000000] ACPI: SLIC 0x000000004FFCB000 000176 (v01 LENOVO TP-N1M   00001240 PTEC 00000002)
[    0.000000] ACPI: SSDT 0x000000004FFC9000 0017AE (v02 LENOVO CpuSsdt  00003000 INTL 20160527)
[    0.000000] ACPI: SSDT 0x000000004FFC8000 00056D (v02 LENOVO CtdpB    00001000 INTL 20160527)
[    0.000000] ACPI: SSDT 0x000000004FFC7000 000678 (v02 LENOVO UsbCTabl 00001000 INTL 20160527)
[    0.000000] ACPI: WSMT 0x000000004FFC6000 000028 (v01 LENOVO TP-N1M   00001240 PTEC 00000002)
[    0.000000] ACPI: SSDT 0x000000004FFC5000 000141 (v02 LENOVO HdaDsp   00000000 INTL 20160527)
[    0.000000] ACPI: SSDT 0x000000004FFC4000 00050D (v02 LENOVO TbtTypeC 00000000 INTL 20160527)
[    0.000000] ACPI: DBGP 0x000000004FFC3000 000034 (v01 LENOVO TP-N1M   00001240 PTEC 00000002)
[    0.000000] ACPI: DBG2 0x000000004FFFD000 000054 (v00 LENOVO TP-N1M   00001240 PTEC 00000002)
[    0.000000] ACPI: MSDM 0x000000004FFC1000 000055 (v03 LENOVO TP-N1M   00001240 PTEC 00000002)
[    0.000000] ACPI: DMAR 0x000000004FFC0000 0000A8 (v01 LENOVO TP-N1M   00001240 PTEC 00000002)
[    0.000000] ACPI: ASF! 0x000000004FFBF000 0000A0 (v32 LENOVO TP-N1M   00001240 PTEC 00000002)
[    0.000000] ACPI: FPDT 0x000000004FFBE000 000044 (v01 LENOVO TP-N1M   00001240 PTEC 00000002)
[    0.000000] ACPI: UEFI 0x000000004FF39000 00013E (v01 LENOVO TP-N1M   00001240 PTEC 00000002)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x00000004a17fffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x4a17fb000-0x4a17fffff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x00000004a17fffff]
[    0.000000]   Device   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x0000000000057fff]
[    0.000000]   node   0: [mem 0x0000000000059000-0x000000000008bfff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x0000000045021fff]
[    0.000000]   node   0: [mem 0x0000000045024000-0x000000004e965fff]
[    0.000000]   node   0: [mem 0x000000004ffff000-0x000000004fffffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x00000004a17fffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x00000004a17fffff]
[    0.000000] On node 0 totalpages: 4129007
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 72 pages reserved
[    0.000000]   DMA zone: 3978 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 4966 pages used for memmap
[    0.000000]   DMA32 zone: 317797 pages, LIFO batch:31
[    0.000000]   Normal zone: 59488 pages used for memmap
[    0.000000]   Normal zone: 3807232 pages, LIFO batch:31
[    0.000000] Reserved but unavailable: 100 pages
[    0.000000] Reserving Intel graphics memory at 0x000000005a800000-0x000000005c7fffff
[    0.000000] ACPI: PM-Timer IO Port: 0x1808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x00058000-0x00058fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0008c000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0x45022000-0x45022fff]
[    0.000000] PM: Registered nosave memory: [mem 0x45023000-0x45023fff]
[    0.000000] PM: Registered nosave memory: [mem 0x4e966000-0x4ea2dfff]
[    0.000000] PM: Registered nosave memory: [mem 0x4ea2e000-0x4ff2cfff]
[    0.000000] PM: Registered nosave memory: [mem 0x4ff2d000-0x4ff4cfff]
[    0.000000] PM: Registered nosave memory: [mem 0x4ff4d000-0x4ff4dfff]
[    0.000000] PM: Registered nosave memory: [mem 0x4ff4e000-0x4ff99fff]
[    0.000000] PM: Registered nosave memory: [mem 0x4ff9a000-0x4fffefff]
[    0.000000] PM: Registered nosave memory: [mem 0x50000000-0x57ffffff]
[    0.000000] PM: Registered nosave memory: [mem 0x58000000-0x585fffff]
[    0.000000] PM: Registered nosave memory: [mem 0x58600000-0x5c7fffff]
[    0.000000] PM: Registered nosave memory: [mem 0x5c800000-0xefffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xf0000000-0xf7ffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xf8000000-0xfe00ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfe010000-0xfe010fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfe011000-0xffffffff]
[    0.000000] e820: [mem 0x5c800000-0xefffffff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.000000] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:4 nr_node_ids:1
[    0.000000] percpu: Embedded 40 pages/cpu @        (ptrval) s125592 r8192 d30056 u524288
[    0.000000] pcpu-alloc: s125592 r8192 d30056 u524288 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 4064417
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-4.15.0-rc5 root=/dev/mapper/vg0-root ro net.ifnames=0 psmouse.synaptics_intertouch=1
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 16062560K/16516028K available (6748K kernel code, 1153K rwdata, 3028K rodata, 1488K init, 692K bss, 453468K reserved, 0K cma-reserved)
[    0.000000] ftrace: allocating 29295 entries in 115 pages
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=4.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.000000] NR_IRQS: 33024, nr_irqs: 1024, preallocated irqs: 16
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] ACPI: Core revision 20170831
[    0.000000] ACPI: 10 ACPI AML tables successfully acquired and loaded
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635855245 ns
[    0.000000] hpet clockevent registered
[    0.004000] APIC: Switch to symmetric I/O mode setup
[    0.004000] DMAR: Host address width 39
[    0.004000] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.004000] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c40660462 ecap 19e2ff0505e
[    0.004000] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.004000] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c40660462 ecap f050da
[    0.004000] DMAR: RMRR base: 0x0000004f49f000 end: 0x0000004f4befff
[    0.004000] DMAR: RMRR base: 0x0000005a000000 end: 0x0000005c7fffff
[    0.004000] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    0.004000] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.004000] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
[    0.004000] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.004000] x2apic enabled
[    0.004000] Switched APIC routing to cluster x2apic.
[    0.008000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.028000] tsc: Detected 2900.000 MHz processor
[    0.028000] Calibrating delay loop (skipped), value calculated using timer frequency.. 5808.00 BogoMIPS (lpj=11616000)
[    0.028000] pid_max: default: 32768 minimum: 301
[    0.028000] Security Framework initialized
[    0.028000] Yama: becoming mindful.
[    0.028000] AppArmor: AppArmor initialized
[    0.028000] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes)
[    0.032411] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.032461] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes)
[    0.032501] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes)
[    0.032691] CPU: Physical Processor ID: 0
[    0.032693] CPU: Processor Core ID: 0
[    0.032699] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.032701] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[    0.032707] mce: CPU supports 8 MCE banks
[    0.032717] CPU0: Thermal monitoring enabled (TM1)
[    0.032732] process: using mwait in idle threads
[    0.032735] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[    0.032737] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    0.033536] Freeing SMP alternatives memory: 28K
[    0.037709] TSC deadline timer enabled
[    0.037717] smpboot: CPU0: Intel(R) Core(TM) i7-7600U CPU @ 2.80GHz (family: 0x6, model: 0x8e, stepping: 0x9)
[    0.037772] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.
[    0.037802] ... version:                4
[    0.037803] ... bit width:              48
[    0.037804] ... generic registers:      4
[    0.037805] ... value mask:             0000ffffffffffff
[    0.037807] ... max period:             00007fffffffffff
[    0.037808] ... fixed-purpose events:   3
[    0.037809] ... event mask:             000000070000000f
[    0.037844] Hierarchical SRCU implementation.
[    0.038264] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.038275] smp: Bringing up secondary CPUs ...
[    0.038352] x86: Booting SMP configuration:
[    0.038353] .... node  #0, CPUs:      #1 #2 #3
[    0.038829] smp: Brought up 1 node, 4 CPUs
[    0.038829] smpboot: Max logical packages: 1
[    0.038829] smpboot: Total of 4 processors activated (23232.00 BogoMIPS)
[    0.040445] devtmpfs: initialized
[    0.040445] x86/mm: Memory block size: 128MB
[    0.041085] PM: Registering ACPI NVS region [mem 0x45022000-0x45022fff] (4096 bytes)
[    0.041085] PM: Registering ACPI NVS region [mem 0x4ff2d000-0x4ff4cfff] (131072 bytes)
[    0.041085] PM: Registering ACPI NVS region [mem 0x4ff4e000-0x4ff99fff] (311296 bytes)
[    0.041085] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.041085] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.041085] pinctrl core: initialized pinctrl subsystem
[    0.041085] NET: Registered protocol family 16
[    0.041085] audit: initializing netlink subsys (disabled)
[    0.041085] audit: type=2000 audit(1514475578.040:1): state=initialized audit_enabled=0 res=1
[    0.041085] cpuidle: using governor ladder
[    0.041085] cpuidle: using governor menu
[    0.041085] Simple Boot Flag at 0x47 set to 0x1
[    0.041085] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    0.041085] ACPI: bus type PCI registered
[    0.041085] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.041085] PCI: MMCONFIG for domain 0000 [bus 00-7f] at [mem 0xf0000000-0xf7ffffff] (base 0xf0000000)
[    0.041085] PCI: MMCONFIG at [mem 0xf0000000-0xf7ffffff] reserved in E820
[    0.041085] PCI: Using configuration type 1 for base access
[    0.041085] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.041085] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.041085] ACPI: Added _OSI(Module Device)
[    0.041085] ACPI: Added _OSI(Processor Device)
[    0.041085] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.041085] ACPI: Added _OSI(Processor Aggregator Device)
[    0.041085] ACPI: EC: EC started
[    0.041085] ACPI: EC: interrupt blocked
[    0.044716] ACPI: \: Used as first EC
[    0.044719] ACPI: \: GPE=0x16, EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.044721] ACPI: \: Used as boot ECDT EC to handle transactions
[    0.045637] ACPI: Executed 25 blocks of module-level executable AML code
[    0.053599] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.063454] ACPI: Dynamic OEM Table Load:
[    0.063468] ACPI: SSDT 0xFFFF8EC38E8FF800 0006F6 (v02 PmRef  Cpu0Ist  00003000 INTL 20160527)
[    0.063599] ACPI: Executed 1 blocks of module-level executable AML code
[    0.063674] ACPI: \_PR_.PR00: _OSC native thermal LVT Acked
[    0.064538] ACPI: Dynamic OEM Table Load:
[    0.064546] ACPI: SSDT 0xFFFF8EC38E922C00 0003FF (v02 PmRef  Cpu0Cst  00003001 INTL 20160527)
[    0.064658] ACPI: Executed 1 blocks of module-level executable AML code
[    0.064816] ACPI: Dynamic OEM Table Load:
[    0.064822] ACPI: SSDT 0xFFFF8EC38E893180 0000BA (v02 PmRef  Cpu0Hwp  00003000 INTL 20160527)
[    0.064912] ACPI: Executed 1 blocks of module-level executable AML code
[    0.064996] ACPI: Dynamic OEM Table Load:
[    0.065002] ACPI: SSDT 0xFFFF8EC38E8FF000 000628 (v02 PmRef  HwpLvt   00003000 INTL 20160527)
[    0.065086] ACPI: Executed 1 blocks of module-level executable AML code
[    0.065459] ACPI: Dynamic OEM Table Load:
[    0.065469] ACPI: SSDT 0xFFFF8EC390D5A000 000D14 (v02 PmRef  ApIst    00003000 INTL 20160527)
[    0.066058] ACPI: Executed 1 blocks of module-level executable AML code
[    0.066208] ACPI: Dynamic OEM Table Load:
[    0.066214] ACPI: SSDT 0xFFFF8EC38E8A1800 000317 (v02 PmRef  ApHwp    00003000 INTL 20160527)
[    0.066354] ACPI: Executed 1 blocks of module-level executable AML code
[    0.066514] ACPI: Dynamic OEM Table Load:
[    0.066520] ACPI: SSDT 0xFFFF8EC38E8A1000 00030A (v02 PmRef  ApCst    00003000 INTL 20160527)
[    0.066661] ACPI: Executed 1 blocks of module-level executable AML code
[    0.067807] ACPI: Interpreter enabled
[    0.067853] ACPI: (supports S0 S3 S4 S5)
[    0.067854] ACPI: Using IOAPIC for interrupt routing
[    0.067888] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.068420] ACPI: Enabled 7 GPEs in block 00 to 7F
[    0.071611] ACPI: Power Resource [PUBS] (on)
[    0.094003] ACPI: Power Resource [WRST] (on)
[    0.094126] ACPI: Power Resource [WRST] (on)
[    0.106511] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-7e])
[    0.106518] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.106629] acpi PNP0A08:00: _OSC: platform does not support [PCIeHotplug PME AER PCIeCapability]
[    0.106631] acpi PNP0A08:00: _OSC: not requesting control; platform does not support [PCIeCapability]
[    0.106633] acpi PNP0A08:00: _OSC: OS requested [PCIeHotplug PME AER PCIeCapability]
[    0.106635] acpi PNP0A08:00: _OSC: platform willing to grant []
[    0.106637] acpi PNP0A08:00: _OSC failed (AE_SUPPORT); disabling ASPM
[    0.106637] PCI host bridge to bus 0000:00
[    0.106637] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.106637] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.106637] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.106637] pci_bus 0000:00: root bus resource [mem 0x5c800000-0xefffffff window]
[    0.106637] pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7fffff window]
[    0.106637] pci_bus 0000:00: root bus resource [bus 00-7e]
[    0.106637] pci 0000:00:00.0: [8086:5904] type 00 class 0x060000
[    0.106637] pci 0000:00:02.0: [8086:5916] type 00 class 0x030000
[    0.106637] pci 0000:00:02.0: reg 0x10: [mem 0xeb000000-0xebffffff 64bit]
[    0.106637] pci 0000:00:02.0: reg 0x18: [mem 0x60000000-0x6fffffff 64bit pref]
[    0.106637] pci 0000:00:02.0: reg 0x20: [io  0xe000-0xe03f]
[    0.106637] pci 0000:00:02.0: BAR 2: assigned to efifb
[    0.106637] pci 0000:00:08.0: [8086:1911] type 00 class 0x088000
[    0.106637] pci 0000:00:08.0: reg 0x10: [mem 0xec348000-0xec348fff 64bit]
[    0.106864] pci 0000:00:14.0: [8086:9d2f] type 00 class 0x0c0330
[    0.106884] pci 0000:00:14.0: reg 0x10: [mem 0xec320000-0xec32ffff 64bit]
[    0.106951] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.107713] pci 0000:00:14.2: [8086:9d31] type 00 class 0x118000
[    0.107732] pci 0000:00:14.2: reg 0x10: [mem 0xec349000-0xec349fff 64bit]
[    0.108468] pci 0000:00:16.0: [8086:9d3a] type 00 class 0x078000
[    0.108491] pci 0000:00:16.0: reg 0x10: [mem 0xec34a000-0xec34afff 64bit]
[    0.108547] pci 0000:00:16.0: PME# supported from D3hot
[    0.109296] pci 0000:00:1c.0: [8086:9d10] type 01 class 0x060400
[    0.109368] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.110103] pci 0000:00:1c.2: [8086:9d12] type 01 class 0x060400
[    0.110174] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    0.110914] pci 0000:00:1c.4: [8086:9d14] type 01 class 0x060400
[    0.110983] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.111723] pci 0000:00:1d.0: [8086:9d18] type 01 class 0x060400
[    0.111790] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.112547] pci 0000:00:1f.0: [8086:9d4e] type 00 class 0x060100
[    0.113365] pci 0000:00:1f.2: [8086:9d21] type 00 class 0x058000
[    0.113378] pci 0000:00:1f.2: reg 0x10: [mem 0xec344000-0xec347fff]
[    0.114134] pci 0000:00:1f.3: [8086:9d71] type 00 class 0x040300
[    0.114161] pci 0000:00:1f.3: reg 0x10: [mem 0xec340000-0xec343fff 64bit]
[    0.114192] pci 0000:00:1f.3: reg 0x20: [mem 0xec330000-0xec33ffff 64bit]
[    0.114239] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    0.114972] pci 0000:00:1f.4: [8086:9d23] type 00 class 0x0c0500
[    0.115026] pci 0000:00:1f.4: reg 0x10: [mem 0xec34b000-0xec34b0ff 64bit]
[    0.115077] pci 0000:00:1f.4: reg 0x20: [io  0xefa0-0xefbf]
[    0.115847] pci 0000:00:1f.6: [8086:15d7] type 00 class 0x020000
[    0.115869] pci 0000:00:1f.6: reg 0x10: [mem 0xec300000-0xec31ffff]
[    0.115958] pci 0000:00:1f.6: PME# supported from D0 D3hot D3cold
[    0.117003] pci 0000:02:00.0: [10ec:525a] type 00 class 0xff0000
[    0.117033] pci 0000:02:00.0: reg 0x14: [mem 0xec200000-0xec200fff]
[    0.117130] pci 0000:02:00.0: supports D1 D2
[    0.117130] pci 0000:02:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.128306] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.128312] pci 0000:00:1c.0:   bridge window [mem 0xec200000-0xec2fffff]
[    0.128647] pci 0000:04:00.0: [8086:24fd] type 00 class 0x028000
[    0.128695] pci 0000:04:00.0: reg 0x10: [mem 0xec100000-0xec101fff 64bit]
[    0.128950] pci 0000:04:00.0: PME# supported from D0 D3hot D3cold
[    0.144304] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.144309] pci 0000:00:1c.2:   bridge window [mem 0xec100000-0xec1fffff]
[    0.144583] pci 0000:05:00.0: [144d:a804] type 00 class 0x010802
[    0.144609] pci 0000:05:00.0: reg 0x10: [mem 0xec000000-0xec003fff 64bit]
[    0.160239] pci 0000:00:1c.4: PCI bridge to [bus 05]
[    0.160243] pci 0000:00:1c.4:   bridge window [mem 0xec000000-0xec0fffff]
[    0.160293] pci 0000:00:1d.0: PCI bridge to [bus 06-70]
[    0.160300] pci 0000:00:1d.0:   bridge window [mem 0xbc000000-0xea0fffff]
[    0.160304] pci 0000:00:1d.0:   bridge window [mem 0x70000000-0xb9ffffff 64bit pref]
[    0.161823] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.161888] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *10 11 12 14 15)
[    0.161950] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.162011] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.162072] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.162132] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.162193] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.162253] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.164000] ACPI: EC: interrupt unblocked
[    0.164000] ACPI: EC: event unblocked
[    0.164000] ACPI: \_SB_.PCI0.LPCB.EC__: GPE=0x16, EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.164000] ACPI: \_SB_.PCI0.LPCB.EC__: Used as boot DSDT EC to handle transactions and events
[    0.164013] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.164013] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.164013] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.164013] vgaarb: loaded
[    0.164043] EDAC MC: Ver: 3.0.0
[    0.164868] Registered efivars operations
[    0.192013] PCI: Using ACPI for IRQ routing
[    0.195301] PCI: pci_cache_line_size set to 64 bytes
[    0.196783] e820: reserve RAM buffer [mem 0x00058000-0x0005ffff]
[    0.196784] e820: reserve RAM buffer [mem 0x0008c000-0x0008ffff]
[    0.196785] e820: reserve RAM buffer [mem 0x45022000-0x47ffffff]
[    0.196786] e820: reserve RAM buffer [mem 0x4e966000-0x4fffffff]
[    0.196787] e820: reserve RAM buffer [mem 0x4a1800000-0x4a3ffffff]
[    0.200063] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.200068] hpet0: 8 comparators, 64-bit 24.000000 MHz counter
[    0.202121] clocksource: Switched to clocksource hpet
[    0.207898] VFS: Disk quotas dquot_6.6.0
[    0.207914] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.207998] AppArmor: AppArmor Filesystem Enabled
[    0.208041] pnp: PnP ACPI init
[    0.208190] system 00:00: [mem 0xfd000000-0xfdabffff] has been reserved
[    0.208192] system 00:00: [mem 0xfdad0000-0xfdadffff] has been reserved
[    0.208194] system 00:00: [mem 0xfdb00000-0xfdffffff] has been reserved
[    0.208196] system 00:00: [mem 0xfe000000-0xfe01ffff] could not be reserved
[    0.208199] system 00:00: [mem 0xfe036000-0xfe03bfff] has been reserved
[    0.208200] system 00:00: [mem 0xfe03d000-0xfe3fffff] has been reserved
[    0.208202] system 00:00: [mem 0xfe410000-0xfe7fffff] has been reserved
[    0.208207] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.208465] system 00:01: [io  0xff00-0xfffe] has been reserved
[    0.208468] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.208806] system 00:02: [io  0x0680-0x069f] has been reserved
[    0.208810] system 00:02: [io  0xffff] has been reserved
[    0.208812] system 00:02: [io  0xffff] has been reserved
[    0.208813] system 00:02: [io  0xffff] has been reserved
[    0.208815] system 00:02: [io  0x1800-0x18fe] has been reserved
[    0.208817] system 00:02: [io  0x164e-0x164f] has been reserved
[    0.208821] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.208908] pnp 00:03: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.208937] system 00:04: [io  0x1854-0x1857] has been reserved
[    0.208941] system 00:04: Plug and Play ACPI device, IDs INT3f0d PNP0c02 (active)
[    0.208957] pnp 00:05: Plug and Play ACPI device, IDs LEN0071 PNP0303 (active)
[    0.208971] pnp 00:06: Plug and Play ACPI device, IDs LEN0072 PNP0f13 (active)
[    0.209058] system 00:07: [io  0x1800-0x189f] could not be reserved
[    0.209061] system 00:07: [io  0x0800-0x087f] has been reserved
[    0.209063] system 00:07: [io  0x0880-0x08ff] has been reserved
[    0.209064] system 00:07: [io  0x0900-0x097f] has been reserved
[    0.209066] system 00:07: [io  0x0980-0x09ff] has been reserved
[    0.209068] system 00:07: [io  0x0a00-0x0a7f] has been reserved
[    0.209070] system 00:07: [io  0x0a80-0x0aff] has been reserved
[    0.209071] system 00:07: [io  0x0b00-0x0b7f] has been reserved
[    0.209073] system 00:07: [io  0x0b80-0x0bff] has been reserved
[    0.209075] system 00:07: [io  0x15e0-0x15ef] has been reserved
[    0.209077] system 00:07: [io  0x1600-0x167f] could not be reserved
[    0.209079] system 00:07: [io  0x1640-0x165f] could not be reserved
[    0.209081] system 00:07: [mem 0xf0000000-0xf7ffffff] has been reserved
[    0.209083] system 00:07: [mem 0xfed10000-0xfed13fff] has been reserved
[    0.209085] system 00:07: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.209087] system 00:07: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.209089] system 00:07: [mem 0xfeb00000-0xfebfffff] has been reserved
[    0.209091] system 00:07: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.209093] system 00:07: [mem 0xfed90000-0xfed93fff] could not be reserved
[    0.209096] system 00:07: [mem 0xeffe0000-0xefffffff] has been reserved
[    0.209099] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.210173] system 00:08: [mem 0xfdaf0000-0xfdafffff] has been reserved
[    0.210175] system 00:08: [mem 0xfdae0000-0xfdaeffff] has been reserved
[    0.210177] system 00:08: [mem 0xfdac0000-0xfdacffff] has been reserved
[    0.210180] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.210648] system 00:09: [mem 0xfed10000-0xfed17fff] could not be reserved
[    0.210650] system 00:09: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.210652] system 00:09: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.210654] system 00:09: [mem 0xf0000000-0xf7ffffff] has been reserved
[    0.210656] system 00:09: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.210658] system 00:09: [mem 0xfed90000-0xfed93fff] could not be reserved
[    0.210660] system 00:09: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.210662] system 00:09: [mem 0xff000000-0xffffffff] has been reserved
[    0.210664] system 00:09: [mem 0xfee00000-0xfeefffff] has been reserved
[    0.210666] system 00:09: [mem 0xeffe0000-0xefffffff] has been reserved
[    0.210669] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.210945] system 00:0a: [mem 0x00000000-0x0009ffff] could not be reserved
[    0.210947] system 00:0a: [mem 0x000c0000-0x000c3fff] could not be reserved
[    0.210949] system 00:0a: [mem 0x000c8000-0x000cbfff] could not be reserved
[    0.210951] system 00:0a: [mem 0x000d0000-0x000d3fff] could not be reserved
[    0.210953] system 00:0a: [mem 0x000d8000-0x000dbfff] could not be reserved
[    0.210955] system 00:0a: [mem 0x000e0000-0x000e3fff] could not be reserved
[    0.210957] system 00:0a: [mem 0x000e8000-0x000ebfff] could not be reserved
[    0.210958] system 00:0a: [mem 0x000f0000-0x000fffff] could not be reserved
[    0.210960] system 00:0a: [mem 0x00100000-0x5c7fffff] could not be reserved
[    0.210963] system 00:0a: [mem 0xfec00000-0xfed3ffff] could not be reserved
[    0.210965] system 00:0a: [mem 0xfed4c000-0xffffffff] could not be reserved
[    0.210968] system 00:0a: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.211072] pnp: PnP ACPI: found 11 devices
[    0.219515] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.219561] pci 0000:00:1d.0: bridge window [io  0x1000-0x0fff] to [bus 06-70] add_size 1000
[    0.219565] pci 0000:00:1d.0: BAR 13: assigned [io  0x2000-0x2fff]
[    0.219568] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.219581] pci 0000:00:1c.0:   bridge window [mem 0xec200000-0xec2fffff]
[    0.219590] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.219596] pci 0000:00:1c.2:   bridge window [mem 0xec100000-0xec1fffff]
[    0.219603] pci 0000:00:1c.4: PCI bridge to [bus 05]
[    0.219615] pci 0000:00:1c.4:   bridge window [mem 0xec000000-0xec0fffff]
[    0.219621] pci 0000:00:1d.0: PCI bridge to [bus 06-70]
[    0.219628] pci 0000:00:1d.0:   bridge window [io  0x2000-0x2fff]
[    0.219632] pci 0000:00:1d.0:   bridge window [mem 0xbc000000-0xea0fffff]
[    0.219635] pci 0000:00:1d.0:   bridge window [mem 0x70000000-0xb9ffffff 64bit pref]
[    0.219643] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.219644] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.219645] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.219646] pci_bus 0000:00: resource 7 [mem 0x5c800000-0xefffffff window]
[    0.219647] pci_bus 0000:00: resource 8 [mem 0xfd000000-0xfe7fffff window]
[    0.219648] pci_bus 0000:02: resource 1 [mem 0xec200000-0xec2fffff]
[    0.219648] pci_bus 0000:04: resource 1 [mem 0xec100000-0xec1fffff]
[    0.219649] pci_bus 0000:05: resource 1 [mem 0xec000000-0xec0fffff]
[    0.219650] pci_bus 0000:06: resource 0 [io  0x2000-0x2fff]
[    0.219651] pci_bus 0000:06: resource 1 [mem 0xbc000000-0xea0fffff]
[    0.219652] pci_bus 0000:06: resource 2 [mem 0x70000000-0xb9ffffff 64bit pref]
[    0.219777] NET: Registered protocol family 2
[    0.219900] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.220085] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.220222] TCP: Hash tables configured (established 131072 bind 65536)
[    0.220250] UDP hash table entries: 8192 (order: 6, 262144 bytes)
[    0.220293] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes)
[    0.220358] NET: Registered protocol family 1
[    0.220373] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.221407] PCI: CLS 0 bytes, default 64
[    0.221434] Unpacking initramfs...
[    0.605658] Freeing initrd memory: 25352K
[    0.605729] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.605734] software IO TLB [mem 0x49c1b000-0x4dc1b000] (64MB) mapped at [000000003516238a-0000000042f084bd]
[    0.605763] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x29dc05e54fc, max_idle_ns: 440795291716 ns
[    0.606405] Initialise system trusted keyrings
[    0.606519] workingset: timestamp_bits=40 max_order=22 bucket_order=0
[    0.606623] zbud: loaded
[    0.849648] Key type asymmetric registered
[    0.849651] Asymmetric key parser 'x509' registered
[    0.849664] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 249)
[    0.849730] io scheduler noop registered
[    0.849732] io scheduler deadline registered
[    0.849754] io scheduler cfq registered (default)
[    0.849756] io scheduler mq-deadline registered
[    0.850543] efifb: probing for efifb
[    0.850557] efifb: framebuffer at 0x60000000, using 8128k, total 8128k
[    0.850559] efifb: mode is 1920x1080x32, linelength=7680, pages=1
[    0.850560] efifb: scrolling: redraw
[    0.850562] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    0.854050] Console: switching to colour frame buffer device 240x67
[    0.857446] fb0: EFI VGA frame buffer device
[    0.857465] intel_idle: MWAIT substates: 0x11142120
[    0.857466] intel_idle: v0.4.1 model 0x8E
[    0.857728] intel_idle: lapic_timer_reliable_states 0xffffffff
[    0.858493] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.859100] Linux agpgart interface v0.103
[    0.865059] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0x0, rev-id 78)
[    0.890357] AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
[    0.890375] AMD IOMMUv2 functionality not available on this system
[    0.890874] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    0.893079] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.893097] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.893425] mousedev: PS/2 mouse device common for all mice
[    0.893499] rtc_cmos 00:03: RTC can wake from S4
[    0.894074] rtc_cmos 00:03: rtc core: registered rtc_cmos as rtc0
[    0.894184] rtc_cmos 00:03: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
[    0.894246] intel_pstate: Intel P-state driver initializing
[    0.894829] intel_pstate: HWP enabled
[    0.894969] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[    0.895266] ledtrig-cpu: registered to indicate activity on CPUs
[    0.895557] NET: Registered protocol family 10
[    0.895856] Segment Routing with IPv6
[    0.895879] mip6: Mobile IPv6
[    0.895890] NET: Registered protocol family 17
[    0.895906] mpls_gso: MPLS GSO support
[    0.896293] microcode: sig=0x806e9, pf=0x80, revision=0x70
[    0.896515] microcode: Microcode Update Driver: v2.2.
[    0.896522] sched_clock: Marking stable (896503403, 0)->(876333434, 20169969)
[    0.897010] registered taskstats version 1
[    0.897023] Loading compiled-in X.509 certificates
[    0.897050] zswap: loaded using pool lzo/zbud
[    0.897197] AppArmor: AppArmor sha1 policy hashing enabled
[    0.959806] rtc_cmos 00:03: setting system clock to 2017-12-28 15:39:39 UTC (1514475579)
[    0.962277] Freeing unused kernel memory: 1488K
[    0.962302] Write protecting the kernel read-only data: 12288k
[    0.962870] Freeing unused kernel memory: 1420K
[    0.965473] Freeing unused kernel memory: 1068K
[    0.972105] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.051653] hidraw: raw HID events driver (C) Jiri Kosina
[    1.065743] ACPI: bus type USB registered
[    1.065781] usbcore: registered new interface driver usbfs
[    1.065809] usbcore: registered new interface driver hub
[    1.065848] usbcore: registered new device driver usb
[    1.068201] nvme nvme0: pci function 0000:05:00.0
[    1.070136] rtsx_pci 0000:02:00.0: enabling device (0000 -> 0002)
[    1.071778] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.071971] (NULL device *): hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
[    1.074158] thermal LNXTHERM:00: registered as thermal_zone0
[    1.074159] ACPI: Thermal Zone [THM0] (60 C)
[    1.076417] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    1.078320] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x00109810
[    1.079065] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
[    1.079302] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    1.080032] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.080496] CPU1: Package temperature above threshold, cpu clock throttled (total events = 1)
[    1.080496] CPU3: Package temperature above threshold, cpu clock throttled (total events = 1)
[    1.080499] CPU0: Core temperature above threshold, cpu clock throttled (total events = 1)
[    1.080499] CPU0: Package temperature above threshold, cpu clock throttled (total events = 1)
[    1.080751] CPU2: Core temperature above threshold, cpu clock throttled (total events = 1)
[    1.080752] CPU2: Package temperature above threshold, cpu clock throttled (total events = 1)
[    1.085367] usb usb1: Product: xHCI Host Controller
[    1.086209] usb usb1: Manufacturer: Linux 4.15.0-rc5 xhci-hcd
[    1.087051] usb usb1: SerialNumber: 0000:00:14.0
[    1.088105] hub 1-0:1.0: USB hub found
[    1.088994] hub 1-0:1.0: 12 ports detected
[    1.090699] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.091531] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[    1.092437] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003
[    1.093354] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.094082] usb usb2: Product: xHCI Host Controller
[    1.094781] usb usb2: Manufacturer: Linux 4.15.0-rc5 xhci-hcd
[    1.095413] usb usb2: SerialNumber: 0000:00:14.0
[    1.096182] hub 2-0:1.0: USB hub found
[    1.096990] hub 2-0:1.0: 6 ports detected
[    1.097906] pps_core: LinuxPPS API ver. 1 registered
[    1.097915] usb: port power management may be unreliable
[    1.099155] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    1.099428] CPU0: Core temperature/speed normal
[    1.099429] CPU0: Package temperature/speed normal
[    1.099431] CPU2: Core temperature/speed normal
[    1.099432] CPU1: Package temperature/speed normal
[    1.099432] CPU2: Package temperature/speed normal
[    1.099794] CPU3: Package temperature/speed normal
[    1.104789] i801_smbus 0000:00:1f.4: enabling device (0000 -> 0003)
[    1.105661] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[    1.105857] PTP clock support registered
[    1.107186] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    1.107221] AVX2 version of gcm_enc/dec engaged.
[    1.107221] AES CTR mode by8 optimization enabled
[    1.109645] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    1.110488] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    1.111300] e1000e 0000:00:1f.6: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[    1.118149] alg: No test for pcbc(aes) (pcbc-aes-aesni)
[    1.243984] e1000e 0000:00:1f.6 0000:00:1f.6 (uninitialized): registered PHC clock
[    1.307258]  nvme0n1: p1 p2 p3 p4 p5 p6
[    1.329920] e1000e 0000:00:1f.6 eth0: (PCI Express:2.5GT/s:Width x1) c8:5b:76:d1:68:28
[    1.331791] e1000e 0000:00:1f.6 eth0: Intel(R) PRO/1000 Network Connection
[    1.333712] e1000e 0000:00:1f.6 eth0: MAC: 12, PHY: 12, PBA No: 1000FF-0FF
[    1.392326] device-mapper: uevent: version 1.0.3
[    1.393304] device-mapper: ioctl: 4.37.0-ioctl (2017-09-20) initialised: dm-devel@redhat.com
[    1.424209] usb 1-6: new high-speed USB device number 2 using xhci_hcd
[    1.575453] usb 1-6: config 1 has an invalid interface number: 12 but max is 1
[    1.575456] usb 1-6: config 1 has an invalid interface number: 13 but max is 1
[    1.575458] usb 1-6: config 1 has an invalid interface number: 13 but max is 1
[    1.575460] usb 1-6: config 1 has no interface number 0
[    1.575462] usb 1-6: config 1 has no interface number 1
[    1.576841] usb 1-6: New USB device found, idVendor=1199, idProduct=9079
[    1.576844] usb 1-6: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    1.576847] usb 1-6: Product: Sierra Wireless EM7455 Qualcomm Snapdragon X7 LTE-A
[    1.576849] usb 1-6: Manufacturer: Sierra Wireless, Incorporated
[    1.576851] usb 1-6: SerialNumber: LF70662577041020
[    1.628443] clocksource: Switched to clocksource tsc
[    1.704190] usb 1-7: new full-speed USB device number 3 using xhci_hcd
[    1.853723] usb 1-7: New USB device found, idVendor=8087, idProduct=0a2b
[    1.853727] usb 1-7: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    1.882340] psmouse serio1: synaptics: queried max coordinates: x [..5676], y [..4760]
[    1.914329] psmouse serio1: synaptics: queried min coordinates: x [1266..], y [1094..]
[    1.914333] psmouse serio1: synaptics: Trying to set up SMBus access
[    1.980206] usb 1-8: new high-speed USB device number 4 using xhci_hcd
[    2.138478] usb 1-8: New USB device found, idVendor=04f2, idProduct=b5ce
[    2.138483] usb 1-8: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.138486] usb 1-8: Product: Integrated Camera
[    2.138488] usb 1-8: Manufacturer: Chicony Electronics Co.,Ltd.
[    2.268208] usb 1-9: new full-speed USB device number 5 using xhci_hcd
[    2.418304] usb 1-9: New USB device found, idVendor=138a, idProduct=0097
[    2.418308] usb 1-9: New USB device strings: Mfr=0, Product=0, SerialNumber=1
[    2.418310] usb 1-9: SerialNumber: 2ff380531485
[    5.720051] random: crng init done
[   10.258276] NET: Registered protocol family 38
[   10.557342] EXT4-fs (dm-2): mounted filesystem with ordered data mode. Opts: (null)
[   10.659992] systemd[1]: RTC configured in localtime, applying delta of 60 minutes to system time.
[   10.674445] ip_tables: (C) 2000-2006 Netfilter Core Team
[   10.745553] systemd[1]: systemd 236 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN default-hierarchy=hybrid)
[   10.764117] systemd[1]: Detected architecture x86-64.
[   10.768542] systemd[1]: Set hostname to <marax>.
[   10.784564] systemd-fstab-generator[281]: x-systemd.device-timeout ignored for fate.yath.de:/data
[   10.800919] systemd[1]: File /lib/systemd/system/systemd-journald.service:35 configures an IP firewall (IPAddressDeny=any), but the local system does not support BPF/cgroup based firewalling.
[   10.801659] systemd[1]: Proceeding WITHOUT firewalling in effect! (This warning is only shown for the first loaded unit using IP firewalling.)
[   10.835096] systemd[1]: System is tainted: local-hwclock
[   10.836167] systemd[1]: Created slice System Slice.
[   10.838237] systemd[1]: Mounting Huge Pages File System...
[   10.840076] systemd[1]: Listening on Journal Socket.
[   10.841908] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[   10.853405] lp: driver loaded but no devices found
[   10.855538] ppdev: user-space parallel port driver
[   10.855567] RPC: Registered named UNIX socket transport module.
[   10.855567] RPC: Registered udp transport module.
[   10.855567] RPC: Registered tcp transport module.
[   10.855568] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   10.865314] SCSI subsystem initialized
[   10.867367] Loading iSCSI transport class v2.0-870.
[   10.870385] iscsi: registered transport (tcp)
[   10.880379] iscsi: registered transport (iser)
[   10.882043] EXT4-fs (dm-2): re-mounted. Opts: errors=remount-ro
[   10.942543] systemd-journald[321]: Received request to flush runtime journal from PID 1
[   10.969080] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input3
[   10.971294] ACPI: Sleep Button [SLPB]
[   10.972679] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input4
[   10.973681] ACPI: Lid Switch [LID]
[   10.975083] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input5
[   10.976861] ACPI: Power Button [PWRF]
[   11.017015] ACPI: AC Adapter [AC] (on-line)
[   11.018032] acpi PNP0C14:02: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:01)
[   11.018225] (NULL device *): hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
[   11.020028] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   11.021026] acpi PNP0C14:03: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:01)
[   11.024592] acpi PNP0C14:04: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:01)
[   11.030187] Non-volatile memory driver v1.3
[   11.051931] thinkpad_acpi: ThinkPad ACPI Extras v0.25
[   11.053153] thinkpad_acpi: http://ibm-acpi.sf.net/
[   11.054365] thinkpad_acpi: ThinkPad BIOS N1MET39W (1.24 ), EC unknown
[   11.055351] thinkpad_acpi: Lenovo ThinkPad X1 Carbon 5th, model 20HRCTO1WW
[   11.057752] thinkpad_acpi: radio switch found; radios are enabled
[   11.058987] thinkpad_acpi: This ThinkPad has standard ACPI backlight brightness control, supported by the ACPI video driver
[   11.059732] thinkpad_acpi: Disabling thinkpad-acpi brightness events by default...
[   11.060048] mei_me 0000:00:16.0: enabling device (0000 -> 0002)
[   11.062157] iTCO_vendor_support: vendor-support=0
[   11.063985] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[   11.065462] iTCO_wdt: Found a Intel PCH TCO device (Version=4, TCOBASE=0x0400)
[   11.068119] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[   11.074594] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[   11.078602] rmi4_smbus 0-002c: registering SMbus-connected sensor
[   11.105570] Bluetooth: Core ver 2.22
[   11.106692] NET: Registered protocol family 31
[   11.106693] Bluetooth: HCI device and connection manager initialized
[   11.106696] Bluetooth: HCI socket layer initialized
[   11.106698] Bluetooth: L2CAP socket layer initialized
[   11.106702] Bluetooth: SCO socket layer initialized
[   11.114162] usbcore: registered new interface driver btusb
[   11.115104] Bluetooth: hci0: Firmware revision 0.1 build 103 week 50 2016
[   11.118426] [drm] Memory usable by graphics device = 4096M
[   11.119696] checking generic (60000000 7f0000) vs hw (60000000 10000000)
[   11.119697] fb: switching to inteldrmfb from EFI VGA
[   11.122684] Console: switching to colour dummy device 80x25
[   11.122759] [drm] Replacing VGA console driver
[   11.126979] EFI Variables Facility v0.08 2004-May-17
[   11.131368] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   11.131371] [drm] Driver supports precise vblank timestamp query.
[   11.133391] usbcore: registered new interface driver usbserial_generic
[   11.133584] usbserial: USB Serial support registered for generic
[   11.134338] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
[   11.141636] [drm] Finished loading DMC firmware i915/kbl_dmc_ver1_01.bin (v1.1)
[   11.143877] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   11.143920] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[   11.143924] cfg80211: failed to load regulatory.db
[   11.145141] usbcore: registered new interface driver cdc_ncm
[   11.145841] usbcore: registered new interface driver cdc_wdm
[   11.149474] Intel(R) Wireless WiFi driver for Linux
[   11.149479] Copyright(c) 2003- 2015 Intel Corporation
[   11.152704] iwlwifi 0000:04:00.0: enabling device (0000 -> 0002)
[   11.154453] input: PC Speaker as /devices/platform/pcspkr/input/input7
[   11.156586] usbcore: registered new interface driver qcserial
[   11.156597] usbserial: USB Serial support registered for Qualcomm USB modem
[   11.158979] [drm] Initialized i915 1.6.0 20171023 for 0000:00:02.0 on minor 0
[   11.161975] Error: Driver 'pcspkr' is already registered, aborting...
[   11.165511] iwlwifi 0000:04:00.0: Direct firmware load for iwlwifi-8265-34.ucode failed with error -2
[   11.166044] iwlwifi 0000:04:00.0: Direct firmware load for iwlwifi-8265-33.ucode failed with error -2
[   11.166058] iwlwifi 0000:04:00.0: Direct firmware load for iwlwifi-8265-32.ucode failed with error -2
[   11.170427] ACPI: Battery Slot [BAT0] (battery present)
[   11.172810] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[   11.172974] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input8
[   11.174304] thinkpad_acpi: rfkill switch tpacpi_bluetooth_sw: radio is unblocked
[   11.174803] cdc_mbim 1-6:1.12: cdc-wdm0: USB WDM device
[   11.174948] cdc_mbim 1-6:1.12 wwan0: register 'cdc_mbim' at usb-0000:00:14.0-6, CDC MBIM, 0e:36:04:4f:d4:3a
[   11.174979] usbcore: registered new interface driver cdc_mbim
[   11.175420] thinkpad_acpi: rfkill switch tpacpi_wwan_sw: radio is unblocked
[   11.176383] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops i915_audio_component_bind_ops [i915])
[   11.180119] iwlwifi 0000:04:00.0: loaded firmware version 31.532993.0 op_mode iwlmvm
[   11.180529] EXT4-fs (nvme0n1p5): mounted filesystem with ordered data mode. Opts: (null)
[   11.185358] fbcon: inteldrmfb (fb0) is primary device
[   11.202241] media: Linux media interface: v0.10
[   11.202452] pstore: using zlib compression
[   11.202475] pstore: Registered efi as persistent store backend
[   11.209681] RAPL PMU: API unit is 2^-32 Joules, 5 fixed counters, 655360 ms ovfl timer
[   11.209682] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[   11.209682] RAPL PMU: hw unit of domain package 2^-14 Joules
[   11.209682] RAPL PMU: hw unit of domain dram 2^-14 Joules
[   11.209683] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[   11.209683] RAPL PMU: hw unit of domain psys 2^-14 Joules
[   11.218941] iwlwifi 0000:04:00.0: Detected Intel(R) Dual Band Wireless AC 8265, REV=0x230
[   11.219294] thinkpad_acpi: Standard ACPI backlight interface available, not loading native one
[   11.219536] Linux video capture interface: v2.00
[   11.223299] input: ThinkPad Extra Buttons as /devices/platform/thinkpad_acpi/input/input6
[   11.223715] rmi4_f01 rmi4-00.fn01: found RMI device, manufacturer: Synaptics, product: TM3289-002, fw id: 2492434
[   11.250788] uvcvideo: Found UVC 1.00 device Integrated Camera (04f2:b5ce)
[   11.255712] intel_rapl: Found RAPL domain package
[   11.255713] intel_rapl: Found RAPL domain core
[   11.255713] intel_rapl: Found RAPL domain uncore
[   11.255714] intel_rapl: Found RAPL domain dram
[   11.258215] uvcvideo 1-8:1.0: Entity type for entity Extension 4 was not initialized!
[   11.258217] uvcvideo 1-8:1.0: Entity type for entity Extension 3 was not initialized!
[   11.258218] uvcvideo 1-8:1.0: Entity type for entity Processing 2 was not initialized!
[   11.258219] uvcvideo 1-8:1.0: Entity type for entity Camera 1 was not initialized!
[   11.261401] input: Integrated Camera: Integrated C as /devices/pci0000:00/0000:00:14.0/usb1/1-8/1-8:1.0/input/input11
[   11.261464] usbcore: registered new interface driver uvcvideo
[   11.261464] USB Video Class driver (1.1.1)
[   11.285963] iwlwifi 0000:04:00.0: base HW address: 00:28:f8:26:30:8b
[   11.325732] input: Synaptics TM3289-002 as /devices/rmi4-00/input/input9
[   11.363339] ieee80211 phy0: Selected rate control algorithm 'iwl-mvm-rs'
[   11.363529] (NULL device *): hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
[   11.363544] thermal thermal_zone3: failed to read out thermal zone (-61)
[   12.346635] Console: switching to colour frame buffer device 240x67
[   12.370052] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
[   12.374742] psmouse serio2: trackpoint: failed to get extended button data, assuming 3 buttons
[   12.407324] snd_hda_codec_conexant hdaudioC0D0: CX8200: BIOS auto-probing.
[   12.407828] snd_hda_codec_conexant hdaudioC0D0: autoconfig for CX8200: line_outs=1 (0x17/0x0/0x0/0x0/0x0) type:speaker
[   12.407829] snd_hda_codec_conexant hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   12.407830] snd_hda_codec_conexant hdaudioC0D0:    hp_outs=1 (0x16/0x0/0x0/0x0/0x0)
[   12.407830] snd_hda_codec_conexant hdaudioC0D0:    mono: mono_out=0x0
[   12.407830] snd_hda_codec_conexant hdaudioC0D0:    inputs:
[   12.407831] snd_hda_codec_conexant hdaudioC0D0:      Internal Mic=0x1a
[   12.407832] snd_hda_codec_conexant hdaudioC0D0:      Mic=0x19
[   12.408768] snd_hda_codec_conexant hdaudioC0D0: Enable sync_write for stable communication
[   12.419279] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1f.3/sound/card0/input13
[   12.420446] input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input14
[   12.420490] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1f.3/sound/card0/input15
[   12.420530] input: HDA Intel PCH HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input16
[   12.420567] input: HDA Intel PCH HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input17
[   12.420602] input: HDA Intel PCH HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input18
[   12.420637] input: HDA Intel PCH HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input19
[   12.420670] input: HDA Intel PCH HDMI/DP,pcm=10 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input20
[   12.456201] EXT4-fs (dm-1): mounted filesystem with ordered data mode. Opts: (null)
[   12.726062] IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
[   12.796326] [drm] RC6 on
[   12.832585] Process accounting resumed
[   12.974424] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   12.975093] Bluetooth: BNEP filters: protocol multicast
[   12.975809] Bluetooth: BNEP socket layer initialized
[   14.571121] psmouse serio2: trackpoint: IBM TrackPoint firmware: 0x04, buttons: 3/3
[   14.619910] input: TPPS/2 IBM TrackPoint as /devices/rmi4-00/rmi4-00.fn03/serio2/input/input12
[   16.196183] wlan0: authenticate with f0:9f:c2:ab:9a:eb
[   16.205967] wlan0: send auth to f0:9f:c2:ab:9a:eb (try 1/3)
[   16.212251] wlan0: authenticated
[   16.216017] wlan0: associate with f0:9f:c2:ab:9a:eb (try 1/3)
[   16.220152] wlan0: RX AssocResp from f0:9f:c2:ab:9a:eb (capab=0x411 status=0 aid=3)
[   16.222223] wlan0: associated
[   16.245320] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
[   18.560839] Bluetooth: RFCOMM TTY layer initialized
[   18.560844] Bluetooth: RFCOMM socket layer initialized
[   18.560847] Bluetooth: RFCOMM ver 1.11
[   95.564115] psmouse serio2: Failed to enable mouse on synaptics-rmi4-pt/serio1
