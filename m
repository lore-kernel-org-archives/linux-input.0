From: Colin Johnstone <johnstone.colin@gmail.com>
Subject: Re: PROBLEM: i2c_hid: probe of i2c-ELAN0732:00 failed with error -61
Date: Tue, 06 Sep 2016 18:14:16 -0400
Message-ID: <1473200056.6178.1.camel@gmail.com>
References: <CABgo8p4OPGzbezWde_s2p467YGtFSemFqxfUY9J6B-3GH4+1iQ@mail.gmail.com>
         <CAN+gG=EiFgVKdwc0J-UBDtAg2SkGqJQB9--CL7BL8ZDn7dXD7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33825 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932110AbcIFWOU (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 6 Sep 2016 18:14:20 -0400
Received: by mail-oi0-f66.google.com with SMTP id v82so10550617oie.1
        for <linux-input@vger.kernel.org>; Tue, 06 Sep 2016 15:14:20 -0700 (PDT)
In-Reply-To: <CAN+gG=EiFgVKdwc0J-UBDtAg2SkGqJQB9--CL7BL8ZDn7dXD7g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>

On Mon, 2016-09-05 at 12:19 +0200, Benjamin Tissoires wrote:
> Hi Colin,
> 
> On Sat, Sep 3, 2016 at 8:33 PM, Colin Johnstone
> <johnstone.colin@gmail.com> wrote:
> > 
> > [1.] One line summary of the problem: Touchscreen does not work,
> > dmesg
> > shows errors "i2c_hid i2c-ELAN0732:00: failed to reset device",
> > "i2c_hid i2c-ELAN0732:00: can't add hid device: -61", and "i2c_hid:
> > probe of i2c-ELAN0732:00 failed with error -61" occur during boot.
> 
> -61 is -ENODATA, which is raised when we timed-out when waiting for
> the interrupt line.
> 
> To confirm this, please provide a dmesg from the boot with
> i2c_hid.debug=1 appended to the kernel command line.
> 
> > 
> > 
> > [2.] Full description of the problem/report: This is on an HP Eny
> > x360
> > M6-AR004DX laptop with 7th-generation AMD FX CPU. The touchscreen
> > is
> > not recognized at all; it appears the screen is using GPIO
> > interrupts
> > as I have to build with AMD GPIO support to receive these errors,
> > otherwise I see a "failed to get GPIO interrupt" error.
> > 
> 
> So this is more likely either a failure of us retrieving the GPIO, or
> a misconfiguration of those. I'd be interested if you could share the
> output of acpidump (as root) as well.
> 
> Cheers,
> Benjamin

My apologies, the previous dmesg output was incorrect. I had an issue
with my grub config and was booting the wrong kernel build. Here's the
correct output, with AMD GPIO support:

[    0.000000] Linux version 4.8.0-rc5-custom (colin@Masaq) (gcc
version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.2) ) #2 SMP Mon Sep
5 19:05:55 EDT 2016
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-4.8.0-rc5-custom
root=/dev/mapper/ubuntu--gnome--vg-root ro quiet splash i2c_hid.debug=1
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Centaur CentaurHauls
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating
point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is
832 bytes, using 'standard' format.
[    0.000000] x86/fpu: Using 'eager' FPU context switches.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000086fff]
usable
[    0.000000] BIOS-e820: [mem 0x0000000000087000-0x0000000000087fff]
reserved
[    0.000000] BIOS-e820: [mem 0x0000000000088000-0x000000000009ffff]
usable
[    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000bffff]
reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000def8efff]
usable
[    0.000000] BIOS-e820: [mem 0x00000000def8f000-0x00000000df88efff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000df88f000-0x00000000dfb8efff]
ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000dfb8f000-0x00000000dfbfefff]
ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000dfbff000-0x00000000dfbfffff]
usable
[    0.000000] BIOS-e820: [mem 0x00000000dfc00000-0x00000000dfffffff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000f0800000-0x00000000f08fffff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec10000-0x00000000fec10fff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed80fff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff800000-0x00000000ffffffff]
reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x00000001feffffff]
usable
[    0.000000] BIOS-e820: [mem 0x00000001ff000000-0x000000021effffff]
reserved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] e820: update [mem 0xd3509018-0xd3518c57] usable ==>
usable
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000000000-
0x0000000000086fff] usable
[    0.000000] reserve setup_data: [mem 0x0000000000087000-
0x0000000000087fff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000088000-
0x000000000009ffff] usable
[    0.000000] reserve setup_data: [mem 0x00000000000a0000-
0x00000000000bffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000100000-
0x00000000d3509017] usable
[    0.000000] reserve setup_data: [mem 0x00000000d3509018-
0x00000000d3518c57] usable
[    0.000000] reserve setup_data: [mem 0x00000000d3518c58-
0x00000000def8efff] usable
[    0.000000] reserve setup_data: [mem 0x00000000def8f000-
0x00000000df88efff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000df88f000-
0x00000000dfb8efff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x00000000dfb8f000-
0x00000000dfbfefff] ACPI data
[    0.000000] reserve setup_data: [mem 0x00000000dfbff000-
0x00000000dfbfffff] usable
[    0.000000] reserve setup_data: [mem 0x00000000dfc00000-
0x00000000dfffffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000f0800000-
0x00000000f08fffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000f8000000-
0x00000000fbffffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fec00000-
0x00000000fec00fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fec10000-
0x00000000fec10fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fed80000-
0x00000000fed80fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fee00000-
0x00000000fee00fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000ff800000-
0x00000000ffffffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000100000000-
0x00000001feffffff] usable
[    0.000000] reserve setup_data: [mem 0x00000001ff000000-
0x000000021effffff] reserved
[    0.000000] efi: EFI v2.50 by INSYDE Corp.
[    0.000000] efi:  ESRT=0xdf23a4d8  ACPI
2.0=0xdfbfe014  SMBIOS=0xdf234000  PROP=0xd37a92d8 
[    0.000000] esrt: Reserving ESRT space from 0x00000000df23a4d8 to
0x00000000df23a510.
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: HP HP ENVY x360 m6 Convertible/81AA, BIOS F.10
06/29/2016
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==>
reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x1ff000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-through
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000000 mask FFFF80000000 write-back
[    0.000000]   1 base 000080000000 mask FFFFC0000000 write-back
[    0.000000]   2 base 0000C0000000 mask FFFFE0000000 write-back
[    0.000000]   3 base 0000FF800000 mask FFFFFF800000 write-protect
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] TOM2: 000000021f000000 aka 8688M
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC-
UC  WB  WC  UC- WT  
[    0.000000] e820: last_pfn = 0xdfc00 max_arch_pfn = 0x400000000
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] Base memory trampoline at [ffff90c200099000] 99000 size
24576
[    0.000000] Using GB pages for direct mapping
[    0.000000] BRK [0xb324b000, 0xb324bfff] PGTABLE
[    0.000000] BRK [0xb324c000, 0xb324cfff] PGTABLE
[    0.000000] BRK [0xb324d000, 0xb324dfff] PGTABLE
[    0.000000] BRK [0xb324e000, 0xb324efff] PGTABLE
[    0.000000] BRK [0xb324f000, 0xb324ffff] PGTABLE
[    0.000000] BRK [0xb3250000, 0xb3250fff] PGTABLE
[    0.000000] RAMDISK: [mem 0x3db04000-0x3fffafff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000DFBFE014 000024 (v02 HPQOEM)
[    0.000000] ACPI: XSDT 0x00000000DFBBF188 0000EC (v01 HPQOEM SLIC-
MPC 00000001 HP   01000013)
[    0.000000] ACPI: FACP 0x00000000DFBF9000 00010C (v05 HPQOEM SLIC-
MPC 00000001 HP   00040000)
[    0.000000] ACPI: DSDT 0x00000000DFBE5000 00D7F2 (v01 HPQOEM SLIC-
MPC 00040000 ACPI 00040000)
[    0.000000] ACPI: FACS 0x00000000DFB58000 000040
[    0.000000] ACPI: UEFI 0x00000000DFBFD000 000236 (v01 HPQOEM
INSYDE   00000001 HP   00040000)
[    0.000000] ACPI: MSDM 0x00000000DFBFC000 000055 (v03 HPQOEM SLIC-
MPC 00000001 HP   00040000)
[    0.000000] ACPI: ASF! 0x00000000DFBFB000 0000A5 (v32 HPQOEM
INSYDE   00000001 HP   00040000)
[    0.000000] ACPI: BOOT 0x00000000DFBFA000 000028 (v01 HPQOEM
INSYDE   00000001 HP   00040000)
[    0.000000] ACPI: HPET 0x00000000DFBF8000 000038 (v01 HPQOEM
INSYDE   00000001 HP   00040000)
[    0.000000] ACPI: APIC 0x00000000DFBF7000 000090 (v03 HPQOEM SLIC-
MPC 00000001 HP   00040000)
[    0.000000] ACPI: MCFG 0x00000000DFBF6000 00003C (v01 HPQOEM
INSYDE   00000001 HP   00040000)
[    0.000000] ACPI: SPCR 0x00000000DFBF5000 000050 (v01 HPQOEM
INSYDE   00000001 HP   00040000)
[    0.000000] ACPI: WDAT 0x00000000DFBF4000 00017C (v01 HPQOEM
INSYDE   00000001 HP   00040000)
[    0.000000] ACPI: WDRT 0x00000000DFBF3000 000047 (v01 HPQOEM
INSYDE   00000000 HP   00040000)
[    0.000000] ACPI: UEFI 0x00000000DFBE4000 000042 (v01 HPQOEM
INSYDE   00000000 HP   00000000)
[    0.000000] ACPI: SSDT 0x00000000DFBDF000 004522 (v01 HPQOEM
INSYDE   00001000 INTL 20130117)
[    0.000000] ACPI: SSDT 0x00000000DFBDE000 0009F8 (v01 HPQOEM
INSYDE   00000001 AMD  00000001)
[    0.000000] ACPI: SSDT 0x00000000DFBD5000 0087BF (v02 HPQOEM
INSYDE   00000002 MSFT 04000000)
[    0.000000] ACPI: IVRS 0x00000000DFBD4000 0000D0 (v02 HPQOEM
INSYDE   00000001 HP   00000000)
[    0.000000] ACPI: CRAT 0x00000000DFBD3000 000528 (v01 HPQOEM
INSYDE   00000001 HP   00000001)
[    0.000000] ACPI: VFCT 0x00000000DFBC3000 00FC84 (v01 HPQOEM
INSYDE   00000001 HP   31504F47)
[    0.000000] ACPI: SSDT 0x00000000DFBC2000 000482 (v01 HPQOEM
INSYDE   00001000 INTL 20130117)
[    0.000000] ACPI: TPM2 0x00000000DFBC1000 000034 (v03 HPQOEM
INSYDE   00000002 HP   01000013)
[    0.000000] ACPI: SSDT 0x00000000DFBC0000 000692 (v01 HPQOEM
INSYDE   00000001 INTL 20130117)
[    0.000000] ACPI: SSDT 0x00000000DFBBD000 001492 (v01 HPQOEM
INSYDE   00000001 INTL 20130117)
[    0.000000] ACPI: SSDT 0x00000000DFBBB000 001654 (v01 HPQOEM
INSYDE   00000001 INTL 20130117)
[    0.000000] ACPI: FPDT 0x00000000DFBBA000 000044 (v01 HPQOEM SLIC-
MPC 00000002 HP   01000013)
[    0.000000] ACPI: BGRT 0x00000000DFBB9000 000038 (v01 HPQOEM
INSYDE   00000001 HP   00040000)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-
0x00000001feffffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x1feff9000-0x1feffdfff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x00000001feffffff]
[    0.000000]   Device   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x0000000000086fff]
[    0.000000]   node   0: [mem 0x0000000000088000-0x000000000009ffff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x00000000def8efff]
[    0.000000]   node   0: [mem 0x00000000dfbff000-0x00000000dfbfffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x00000001feffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-
0x00000001feffffff]
[    0.000000] On node 0 totalpages: 1957678
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 22 pages reserved
[    0.000000]   DMA zone: 3998 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 14207 pages used for memmap
[    0.000000]   DMA32 zone: 909200 pages, LIFO batch:31
[    0.000000]   Normal zone: 16320 pages used for memmap
[    0.000000]   Normal zone: 1044480 pages, LIFO batch:31
[    0.000000] tboot: non-0 tboot_addr but it is not of type
E820_RESERVED
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 4, version 33, address 0xfec00000,
GSI 0-23
[    0.000000] IOAPIC[1]: apic_id 5, version 33, address 0xfec01000,
GSI 24-55
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low
level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x10228210 base: 0xfed00000
[    0.000000] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-
0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x00087000-
0x00087fff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-
0x000bffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000c0000-
0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xd3509000-
0xd3509fff]
[    0.000000] PM: Registered nosave memory: [mem 0xd3518000-
0xd3518fff]
[    0.000000] PM: Registered nosave memory: [mem 0xdef8f000-
0xdf88efff]
[    0.000000] PM: Registered nosave memory: [mem 0xdf88f000-
0xdfb8efff]
[    0.000000] PM: Registered nosave memory: [mem 0xdfb8f000-
0xdfbfefff]
[    0.000000] PM: Registered nosave memory: [mem 0xdfc00000-
0xdfffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xe0000000-
0xf07fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xf0800000-
0xf08fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xf0900000-
0xf7ffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xf8000000-
0xfbffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfc000000-
0xfebfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec00000-
0xfec00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec01000-
0xfec0ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec10000-
0xfec10fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec11000-
0xfed7ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed80000-
0xfed80fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed81000-
0xfedfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee00000-
0xfee00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee01000-
0xff7fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xff800000-
0xffffffff]
[    0.000000] e820: [mem 0xe0000000-0xf07fffff] available for PCI
devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff
max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.000000] setup_percpu: NR_CPUS:256 nr_cpumask_bits:256
nr_cpu_ids:4 nr_node_ids:1
[    0.000000] percpu: Embedded 36 pages/cpu @ffff90c3fec00000 s107544
r8192 d31720 u524288
[    0.000000] pcpu-alloc: s107544 r8192 d31720 u524288 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 
[    0.000000] Built 1 zonelists in Node order, mobility grouping
on.  Total pages: 1927065
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-4.8.0-rc5-
custom root=/dev/mapper/ubuntu--gnome--vg-root ro quiet splash
i2c_hid.debug=1
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA -
bailing!
[    0.000000] Memory: 7533492K/7830712K available (8599K kernel code,
1421K rwdata, 3788K rodata, 1536K init, 1392K bss, 297220K reserved, 0K
cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4,
Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 64.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=256 to
nr_cpu_ids=4.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=64,
nr_cpu_ids=4
[    0.000000] NR_IRQS:16640 nr_irqs:1000 16
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 133484873504 ns
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2694.988 MHz processor
[    0.000024] Calibrating delay loop (skipped), value calculated using
timer frequency.. 5389.97 BogoMIPS (lpj=10779952)
[    0.000027] pid_max: default: 32768 minimum: 301
[    0.000034] ACPI: Core revision 20160422
[    0.012899] ACPI: 8 ACPI AML tables successfully acquired and loaded

[    0.021402] Security Framework initialized
[    0.021404] Yama: becoming mindful.
[    0.021417] AppArmor: AppArmor initialized
[    0.021771] Dentry cache hash table entries: 1048576 (order: 11,
8388608 bytes)
[    0.024742] Inode-cache hash table entries: 524288 (order: 10,
4194304 bytes)
[    0.026231] Mount-cache hash table entries: 16384 (order: 5, 131072
bytes)
[    0.026239] Mountpoint-cache hash table entries: 16384 (order: 5,
131072 bytes)
[    0.026604] [Firmware Info]: CPU: Re-enabling disabled Topology
Extensions Support.
[    0.026611] CPU: Physical Processor ID: 0
[    0.026611] CPU: Processor Core ID: 0
[    0.026624] mce: CPU supports 7 MCE banks
[    0.026632] LVT offset 1 assigned for vector 0xf9
[    0.026640] Last level iTLB entries: 4KB 512, 2MB 1024, 4MB 512
[    0.026641] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 512,
1GB 0
[    0.027695] Freeing SMP alternatives memory: 32K (ffffffffb00e5000 -
ffffffffb00ed000)
[    0.039338] ftrace: allocating 32806 entries in 129 pages
[    0.052660] smpboot: APIC(10) Converting physical 1 to logical
package 0
[    0.052662] smpboot: Max logical packages: 2
[    0.156327] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.301731] smpboot: CPU0: AMD FX-9800P RADEON R7, 12 COMPUTE CORES
4C+8G (family: 0x15, model: 0x65, stepping: 0x1)
[    0.301735] Performance Events: Fam15h core perfctr, AMD PMU driver.
[    0.301741] ... version:                0
[    0.301741] ... bit width:              48
[    0.301742] ... generic registers:      6
[    0.301742] ... value mask:             0000ffffffffffff
[    0.301743] ... max period:             00007fffffffffff
[    0.301743] ... fixed-purpose events:   0
[    0.301744] ... event mask:             000000000000003f
[    0.302672] NMI watchdog: enabled on all CPUs, permanently consumes
one hw-PMU counter.
[    0.302785] x86: Booting SMP configuration:
[    0.302787] .... node  #0, CPUs:      #1 #2 #3
[    0.440069] x86: Booted up 1 node, 4 CPUs
[    0.440073] smpboot: Total of 4 processors activated (21507.73
BogoMIPS)
[    0.441660] devtmpfs: initialized
[    0.441772] x86/mm: Memory block size: 128MB
[    0.444140] evm: security.selinux
[    0.444141] evm: security.SMACK64
[    0.444141] evm: security.SMACK64EXEC
[    0.444142] evm: security.SMACK64TRANSMUTE
[    0.444142] evm: security.SMACK64MMAP
[    0.444142] evm: security.ima
[    0.444143] evm: security.capability
[    0.444272] PM: Registering ACPI NVS region [mem 0xdf88f000-
0xdfb8efff] (3145728 bytes)
[    0.444390] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.444464] pinctrl core: initialized pinctrl subsystem
[    0.444632] RTC time: 21:41:37, date: 09/06/16
[    0.444979] NET: Registered protocol family 16
[    0.457899] cpuidle: using governor ladder
[    0.473899] cpuidle: using governor menu
[    0.473902] PCCT header not found.
[    0.474164] Simple Boot Flag at 0x44 set to 0x80
[    0.474190] ACPI FADT declares the system doesn't support PCIe ASPM,
so disable it
[    0.474192] ACPI: bus type PCI registered
[    0.474194] acpiphp: ACPI Hot Plug PCI Controller Driver version:
0.5
[    0.474283] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem
0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.474285] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in
E820
[    0.474288] PCI: Using configuration type 1 for base access
[    0.490307] HugeTLB registered 1 GB page size, pre-allocated 0 pages
[    0.490309] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.490681] ACPI: Added _OSI(Module Device)
[    0.490682] ACPI: Added _OSI(Processor Device)
[    0.490683] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.490684] ACPI: Added _OSI(Processor Aggregator Device)
[    0.490852] ACPI: Executed 1 blocks of module-level executable AML
code
[    0.502061] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.505371] ACPI : EC: EC started
[    0.690028] ACPI: Interpreter enabled
[    0.690054] ACPI: (supports S0 S3 S4 S5)
[    0.690055] ACPI: Using IOAPIC for interrupt routing
[    0.690189] PCI: Using host bridge windows from ACPI; if necessary,
use "pci=nocrs" and report a bug
[    0.690497] [Firmware Bug]: ACPI: No _BQC method, cannot determine
initial brightness
[    0.690954] [Firmware Bug]: ACPI: No _BQC method, cannot determine
initial brightness
[    0.691353] ACPI: Power Resource [P0U2] (off)
[    0.691378] ACPI: Power Resource [P3U2] (off)
[    0.691568] ACPI: Power Resource [P0U3] (off)
[    0.691593] ACPI: Power Resource [P3U3] (off)
[    0.692684] ACPI: Power Resource [P0ST] (on)
[    0.692710] ACPI: Power Resource [P3ST] (on)
[    0.692778] ACPI: Power Resource [P0SA] (off)
[    0.692800] ACPI: Power Resource [P3SA] (off)
[    0.693210] ACPI: Power Resource [P0SD] (off)
[    0.693235] ACPI: Power Resource [P3SD] (off)
[    0.695478] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.695484] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM
ClockPM Segments MSI]
[    0.695626] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME
AER PCIeCapability]
[    0.695627] acpi PNP0A08:00: FADT indicates ASPM is unsupported,
using BIOS configuration
[    0.695638] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain
0000 [bus 00-3f] only partially covers this bridge
[    0.695896] PCI host bridge to bus 0000:00
[    0.695898] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7
window]
[    0.695899] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff
window]
[    0.695901] pci_bus 0000:00: root bus resource [mem 0x000a0000-
0x000bffff window]
[    0.695902] pci_bus 0000:00: root bus resource [mem 0x000c0000-
0x000c3fff window]
[    0.695903] pci_bus 0000:00: root bus resource [mem 0x000c4000-
0x000c7fff window]
[    0.695905] pci_bus 0000:00: root bus resource [mem 0x000c8000-
0x000cbfff window]
[    0.695906] pci_bus 0000:00: root bus resource [mem 0x000cc000-
0x000cffff window]
[    0.695907] pci_bus 0000:00: root bus resource [mem 0x000d0000-
0x000d3fff window]
[    0.695908] pci_bus 0000:00: root bus resource [mem 0x000d4000-
0x000d7fff window]
[    0.695909] pci_bus 0000:00: root bus resource [mem 0x000d8000-
0x000dbfff window]
[    0.695910] pci_bus 0000:00: root bus resource [mem 0x000dc000-
0x000dffff window]
[    0.695911] pci_bus 0000:00: root bus resource [mem 0x000e0000-
0x000e3fff window]
[    0.695912] pci_bus 0000:00: root bus resource [mem 0x000e4000-
0x000e7fff window]
[    0.695913] pci_bus 0000:00: root bus resource [mem 0x000e8000-
0x000ebfff window]
[    0.695915] pci_bus 0000:00: root bus resource [mem 0x000ec000-
0x000effff window]
[    0.695916] pci_bus 0000:00: root bus resource [mem 0xe0000000-
0xf7ffffff window]
[    0.695917] pci_bus 0000:00: root bus resource [mem 0xfc000000-
0xfed3ffff window]
[    0.695919] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.695929] pci 0000:00:00.0: [1022:1576] type 00 class 0x060000
[    0.696035] pci 0000:00:00.2: [1022:1577] type 00 class 0x080600
[    0.696146] pci 0000:00:01.0: [1002:9874] type 00 class 0x030000
[    0.696158] pci 0000:00:01.0: reg 0x10: [mem 0xe0000000-0xefffffff
64bit pref]
[    0.696167] pci 0000:00:01.0: reg 0x18: [mem 0xf0000000-0xf07fffff
64bit pref]
[    0.696172] pci 0000:00:01.0: reg 0x20: [io  0x2000-0x20ff]
[    0.696178] pci 0000:00:01.0: reg 0x24: [mem 0xf0c00000-0xf0c3ffff]
[    0.696184] pci 0000:00:01.0: reg 0x30: [mem 0xfffe0000-0xffffffff
pref]
[    0.696219] pci 0000:00:01.0: supports D1 D2
[    0.696220] pci 0000:00:01.0: PME# supported from D1 D2 D3hot
[    0.696304] pci 0000:00:01.1: [1002:9840] type 00 class 0x040300
[    0.696316] pci 0000:00:01.1: reg 0x10: [mem 0xf0c60000-0xf0c63fff
64bit]
[    0.696366] pci 0000:00:01.1: supports D1 D2
[    0.696429] pci 0000:00:02.0: [1022:157b] type 00 class 0x060000
[    0.696515] pci 0000:00:02.2: [1022:157c] type 01 class 0x060400
[    0.696579] pci 0000:00:02.2: PME# supported from D0 D3hot D3cold
[    0.696659] pci 0000:00:02.2: System wakeup disabled by ACPI
[    0.696690] pci 0000:00:02.3: [1022:157c] type 01 class 0x060400
[    0.696749] pci 0000:00:02.3: PME# supported from D0 D3hot D3cold
[    0.696784] pci 0000:00:02.3: System wakeup disabled by ACPI
[    0.696815] pci 0000:00:03.0: [1022:157b] type 00 class 0x060000
[    0.696897] pci 0000:00:08.0: [1022:1578] type 00 class 0x108000
[    0.696908] pci 0000:00:08.0: reg 0x10: [mem 0xf0c40000-0xf0c5ffff
64bit pref]
[    0.696912] pci 0000:00:08.0: reg 0x18: [mem 0xf0900000-0xf09fffff]
[    0.696917] pci 0000:00:08.0: reg 0x1c: [mem 0xf0c6f000-0xf0c6ffff]
[    0.696924] pci 0000:00:08.0: reg 0x24: [mem 0xf0c6a000-0xf0c6bfff]
[    0.696994] pci 0000:00:09.0: [1022:157d] type 00 class 0x060000
[    0.697062] pci 0000:00:09.2: [1022:157a] type 00 class 0x040300
[    0.697070] pci 0000:00:09.2: reg 0x10: [mem 0xf0c64000-0xf0c67fff]
[    0.697106] pci 0000:00:09.2: PME# supported from D0 D3hot D3cold
[    0.697180] pci 0000:00:10.0: [1022:7914] type 00 class 0x0c0330
[    0.697201] pci 0000:00:10.0: reg 0x10: [mem 0xf0c68000-0xf0c69fff
64bit]
[    0.697296] pci 0000:00:10.0: PME# supported from D0 D3hot D3cold
[    0.697334] pci 0000:00:10.0: System wakeup disabled by ACPI
[    0.697365] pci 0000:00:11.0: [1022:7904] type 00 class 0x010601
[    0.697380] pci 0000:00:11.0: reg 0x10: [io  0x2118-0x211f]
[    0.697388] pci 0000:00:11.0: reg 0x14: [io  0x2124-0x2127]
[    0.697396] pci 0000:00:11.0: reg 0x18: [io  0x2110-0x2117]
[    0.697403] pci 0000:00:11.0: reg 0x1c: [io  0x2120-0x2123]
[    0.697411] pci 0000:00:11.0: reg 0x20: [io  0x2100-0x210f]
[    0.697419] pci 0000:00:11.0: reg 0x24: [mem 0xf0c6c000-0xf0c6c3ff]
[    0.697455] pci 0000:00:11.0: PME# supported from D3hot
[    0.697513] pci 0000:00:12.0: [1022:7908] type 00 class 0x0c0320
[    0.698270] pci 0000:00:12.0: reg 0x10: [mem 0xf0c6d000-0xf0c6d0ff]
[    0.701827] pci 0000:00:12.0: supports D1 D2
[    0.701828] pci 0000:00:12.0: PME# supported from D0 D1 D2 D3hot
D3cold
[    0.701866] pci 0000:00:12.0: System wakeup disabled by ACPI
[    0.701903] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500
[    0.702025] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100
[    0.702155] pci 0000:00:18.0: [1022:1570] type 00 class 0x060000
[    0.702225] pci 0000:00:18.1: [1022:1571] type 00 class 0x060000
[    0.702291] pci 0000:00:18.2: [1022:1572] type 00 class 0x060000
[    0.702366] pci 0000:00:18.3: [1022:1573] type 00 class 0x060000
[    0.702445] pci 0000:00:18.4: [1022:1574] type 00 class 0x060000
[    0.702542] pci 0000:00:18.5: [1022:1575] type 00 class 0x060000
[    0.702663] pci 0000:01:00.0: [10ec:5229] type 00 class 0xff0000
[    0.702680] pci 0000:01:00.0: reg 0x10: [mem 0xf0b00000-0xf0b00fff]
[    0.702797] pci 0000:01:00.0: supports D1 D2
[    0.702798] pci 0000:01:00.0: PME# supported from D1 D2 D3hot
[    0.713904] pci 0000:00:02.2: PCI bridge to [bus 01]
[    0.713913] pci 0000:00:02.2:   bridge window [mem 0xf0b00000-
0xf0bfffff]
[    0.714018] pci 0000:02:00.0: [8086:095a] type 00 class 0x028000
[    0.714055] pci 0000:02:00.0: reg 0x10: [mem 0xf0a00000-0xf0a01fff
64bit]
[    0.714241] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.725908] pci 0000:00:02.3: PCI bridge to [bus 02]
[    0.725916] pci 0000:00:02.3:   bridge window [mem 0xf0a00000-
0xf0afffff]
[    0.726185] ACPI: IRQ 7 override to edge, high
[    0.726585] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 5 6 10 11) *0,
disabled.
[    0.726638] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 5 6 10 11) *0,
disabled.
[    0.726679] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 5 6 10 11) *0,
disabled.
[    0.726729] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 5 6 10 11) *0,
disabled.
[    0.726776] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 5 6 10 11) *0,
disabled.
[    0.726813] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 5 6 10 11) *0,
disabled.
[    0.726850] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 5 6 10 11) *0,
disabled.
[    0.726887] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 5 6 10 11) *0,
disabled.
[    0.748538] ACPI : EC: EC stopped
[    0.748578] ACPI : EC: GPE = 0x3, I/O: command/status = 0x66, data =
0x62
[    0.748579] ACPI : EC: EC started
[    0.934599] vgaarb: setting as boot device: PCI:0000:00:01.0
[    0.934602] vgaarb: device added:
PCI:0000:00:01.0,decodes=io+mem,owns=io+mem,locks=none
[    0.934608] vgaarb: loaded
[    0.934609] vgaarb: bridge control possible 0000:00:01.0
[    0.934799] SCSI subsystem initialized
[    0.934933] libata version 3.00 loaded.
[    0.934977] ACPI: bus type USB registered
[    0.934997] usbcore: registered new interface driver usbfs
[    0.935007] usbcore: registered new interface driver hub
[    0.935031] usbcore: registered new device driver usb
[    0.968407] PCI: Using ACPI for IRQ routing
[    0.970342] PCI: pci_cache_line_size set to 64 bytes
[    0.970408] e820: reserve RAM buffer [mem 0x00087000-0x0008ffff]
[    0.970409] e820: reserve RAM buffer [mem 0xd3509018-0xd3ffffff]
[    0.970410] e820: reserve RAM buffer [mem 0xdef8f000-0xdfffffff]
[    0.970410] e820: reserve RAM buffer [mem 0xdfc00000-0xdfffffff]
[    0.970411] e820: reserve RAM buffer [mem 0x1ff000000-0x1ffffffff]
[    0.970528] NetLabel: Initializing
[    0.970528] NetLabel:  domain hash size = 128
[    0.970529] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.970541] NetLabel:  unlabeled traffic allowed by default
[    0.971208] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.971213] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.974430] clocksource: Switched to clocksource hpet
[    0.981883] VFS: Disk quotas dquot_6.6.0
[    0.981922] VFS: Dquot-cache hash table entries: 512 (order 0, 4096
bytes)
[    0.982069] AppArmor: AppArmor Filesystem Enabled
[    0.982142] pnp: PnP ACPI init
[    0.982330] system 00:00: [mem 0xfec00000-0xfec01fff] could not be
reserved
[    0.982332] system 00:00: [mem 0xfee00000-0xfee00fff] has been
reserved
[    0.982333] system 00:00: [mem 0xf0800000-0xf08fffff] has been
reserved
[    0.982337] system 00:00: Plug and Play ACPI device, IDs PNP0c02
(active)
[    0.982449] pnp 00:01: Plug and Play ACPI device, IDs PNP0b00
(active)
[    0.982488] system 00:02: [io  0x0400-0x04cf] has been reserved
[    0.982489] system 00:02: [io  0x04d0-0x04d1] has been reserved
[    0.982490] system 00:02: [io  0x04d6] has been reserved
[    0.982491] system 00:02: [io  0x0c00-0x0c01] has been reserved
[    0.982492] system 00:02: [io  0x0c14] has been reserved
[    0.982493] system 00:02: [io  0x0c50-0x0c52] has been reserved
[    0.982494] system 00:02: [io  0x0c6c] has been reserved
[    0.982495] system 00:02: [io  0x0c6f] has been reserved
[    0.982496] system 00:02: [io  0x0cd0-0x0cdb] has been reserved
[    0.982498] system 00:02: Plug and Play ACPI device, IDs PNP0c02
(active)
[    0.982548] system 00:03: [mem 0x000e0000-0x000fffff] could not be
reserved
[    0.982549] system 00:03: [mem 0xff800000-0xffffffff] has been
reserved
[    0.982551] system 00:03: Plug and Play ACPI device, IDs PNP0c01
(active)
[    0.982607] pnp 00:04: Plug and Play ACPI device, IDs HPQ8001
PNP0303 (active)
[    0.982629] pnp 00:05: Plug and Play ACPI device, IDs SYN321b
SYN1e00 SYN0002 PNP0f13 (active)
[    0.983024] pnp: PnP ACPI: found 6 devices
[    1.025698] clocksource: acpi_pm: mask: 0xffffff max_cycles:
0xffffff, max_idle_ns: 2085701024 ns
[    1.025708] pci 0000:00:01.0: can't claim BAR 6 [mem 0xfffe0000-
0xffffffff pref]: no compatible bridge window
[    1.025742] pci 0000:00:01.0: BAR 6: assigned [mem 0xf0c80000-
0xf0c9ffff pref]
[    1.025745] pci 0000:00:02.2: PCI bridge to [bus 01]
[    1.025749] pci 0000:00:02.2:   bridge window [mem 0xf0b00000-
0xf0bfffff]
[    1.025755] pci 0000:00:02.3: PCI bridge to [bus 02]
[    1.025758] pci 0000:00:02.3:   bridge window [mem 0xf0a00000-
0xf0afffff]
[    1.025766] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    1.025767] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    1.025768] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff
window]
[    1.025769] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000c3fff
window]
[    1.025770] pci_bus 0000:00: resource 8 [mem 0x000c4000-0x000c7fff
window]
[    1.025770] pci_bus 0000:00: resource 9 [mem 0x000c8000-0x000cbfff
window]
[    1.025771] pci_bus 0000:00: resource 10 [mem 0x000cc000-0x000cffff
window]
[    1.025772] pci_bus 0000:00: resource 11 [mem 0x000d0000-0x000d3fff
window]
[    1.025773] pci_bus 0000:00: resource 12 [mem 0x000d4000-0x000d7fff
window]
[    1.025774] pci_bus 0000:00: resource 13 [mem 0x000d8000-0x000dbfff
window]
[    1.025775] pci_bus 0000:00: resource 14 [mem 0x000dc000-0x000dffff
window]
[    1.025776] pci_bus 0000:00: resource 15 [mem 0x000e0000-0x000e3fff
window]
[    1.025776] pci_bus 0000:00: resource 16 [mem 0x000e4000-0x000e7fff
window]
[    1.025777] pci_bus 0000:00: resource 17 [mem 0x000e8000-0x000ebfff
window]
[    1.025778] pci_bus 0000:00: resource 18 [mem 0x000ec000-0x000effff
window]
[    1.025779] pci_bus 0000:00: resource 19 [mem 0xe0000000-0xf7ffffff
window]
[    1.025780] pci_bus 0000:00: resource 20 [mem 0xfc000000-0xfed3ffff
window]
[    1.025781] pci_bus 0000:01: resource 1 [mem 0xf0b00000-0xf0bfffff]
[    1.025782] pci_bus 0000:02: resource 1 [mem 0xf0a00000-0xf0afffff]
[    1.025817] NET: Registered protocol family 2
[    1.026050] TCP established hash table entries: 65536 (order: 7,
524288 bytes)
[    1.026256] TCP bind hash table entries: 65536 (order: 8, 1048576
bytes)
[    1.026667] TCP: Hash tables configured (established 65536 bind
65536)
[    1.026736] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    1.026787] UDP-Lite hash table entries: 4096 (order: 5, 131072
bytes)
[    1.026906] NET: Registered protocol family 1
[    1.026936] pci 0000:00:01.0: Video device with shadowed ROM at [mem
0x000c0000-0x000dffff]
[    1.050766] PCI: CLS 64 bytes, default 64
[    1.050839] Trying to unpack rootfs image as initramfs...
[    1.580373] Freeing initrd memory: 37852K (ffff90c23db04000 -
ffff90c23fffb000)
[    1.580393] AMD-Vi: IOMMU performance counters supported
[    1.580544] pci 0000:00:00.2: can't derive routing for PCI INT A
[    1.580545] pci 0000:00:00.2: PCI INT A: not connected
[    1.580755] iommu: Adding device 0000:00:01.0 to group 0
[    1.580816] iommu: Using direct mapping for device 0000:00:01.0
[    1.580848] iommu: Adding device 0000:00:01.1 to group 0
[    1.580890] iommu: Adding device 0000:00:02.0 to group 1
[    1.580904] iommu: Adding device 0000:00:02.2 to group 1
[    1.580919] iommu: Adding device 0000:00:02.3 to group 1
[    1.580970] iommu: Adding device 0000:00:03.0 to group 2
[    1.581026] iommu: Adding device 0000:00:08.0 to group 3
[    1.581085] iommu: Adding device 0000:00:09.0 to group 4
[    1.581098] iommu: Adding device 0000:00:09.2 to group 4
[    1.581152] iommu: Adding device 0000:00:10.0 to group 5
[    1.581201] iommu: Adding device 0000:00:11.0 to group 6
[    1.581252] iommu: Adding device 0000:00:12.0 to group 7
[    1.581310] iommu: Adding device 0000:00:14.0 to group 8
[    1.581324] iommu: Adding device 0000:00:14.3 to group 8
[    1.581397] iommu: Adding device 0000:00:18.0 to group 9
[    1.581410] iommu: Adding device 0000:00:18.1 to group 9
[    1.581424] iommu: Adding device 0000:00:18.2 to group 9
[    1.581437] iommu: Adding device 0000:00:18.3 to group 9
[    1.581450] iommu: Adding device 0000:00:18.4 to group 9
[    1.581464] iommu: Adding device 0000:00:18.5 to group 9
[    1.581480] iommu: Adding device 0000:01:00.0 to group 1
[    1.581498] iommu: Adding device 0000:02:00.0 to group 1
[    1.582186] AMD-Vi: Found IOMMU at 0000:00:00.2 cap 0x40
[    1.582187] AMD-Vi:  Extended features:  PPR NX GT IA GA PC
[    1.582190] AMD-Vi: Interrupt remapping enabled
[    1.582526] AMD-Vi: Lazy IO/TLB flushing enabled
[    1.583850] perf: AMD NB counters detected
[    1.584241] AMD Power PMU detected
[    1.584246] LVT offset 0 assigned for vector 0x400
[    1.584294] perf: AMD IBS detected (0x000007ff)
[    1.584300] perf: amd_iommu: Detected. (0 banks, 0 counters/bank)
[    1.584368] Scanning for low memory corruption every 60 seconds
[    1.584977] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    1.585005] audit: initializing netlink subsys (disabled)
[    1.585026] audit: type=2000 audit(1473198097.368:1): initialized
[    1.585349] Initialise system trusted keyrings
[    1.585645] workingset: timestamp_bits=40 max_order=21
bucket_order=0
[    1.587198] zbud: loaded
[    1.587505] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    1.587928] fuse init (API version 7.25)
[    1.588069] Key type big_key registered
[    1.588746] Key type asymmetric registered
[    1.588747] Asymmetric key parser 'x509' registered
[    1.588779] Block layer SCSI generic (bsg) driver version 0.4 loaded
(major 248)
[    1.588828] io scheduler noop registered
[    1.588829] io scheduler deadline registered (default)
[    1.588837] io scheduler cfq registered
[    1.590058] pcieport 0000:00:02.2: Signaling PME through PCIe PME
interrupt
[    1.590061] pci 0000:01:00.0: Signaling PME through PCIe PME
interrupt
[    1.590064] pcie_pme 0000:00:02.2:pcie001: service driver pcie_pme
loaded
[    1.590083] pcieport 0000:00:02.3: Signaling PME through PCIe PME
interrupt
[    1.590084] pci 0000:02:00.0: Signaling PME through PCIe PME
interrupt
[    1.590087] pcie_pme 0000:00:02.3:pcie001: service driver pcie_pme
loaded
[    1.590090] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    1.590094] pciehp: PCI Express Hot Plug Controller Driver version:
0.4
[    1.590120] efifb: probing for efifb
[    1.590144] efifb: framebuffer at 0xe0000000, using 8100k, total
8100k
[    1.590145] efifb: mode is 1920x1080x32, linelength=7680, pages=1
[    1.590145] efifb: scrolling: redraw
[    1.590147] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    1.593841] Console: switching to colour frame buffer device 240x67
[    1.596985] fb0: EFI VGA frame buffer device
[    1.597125] ACPI: AC Adapter [ADP1] (off-line)
[    1.597177] input: Power Button as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    1.597180] ACPI: Power Button [PWRB]
[    1.597218] input: Lid Switch as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input1
[    1.597232] ACPI: Lid Switch [LID0]
[    1.597261] input: Power Button as
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[    1.597263] ACPI: Power Button [PWRF]
[    1.602765] thermal LNXTHERM:00: registered as thermal_zone0
[    1.602768] ACPI: Thermal Zone [TZS0] (71 C)
[    1.602977] thermal LNXTHERM:01: registered as thermal_zone1
[    1.602977] ACPI: Thermal Zone [TZS1] (45 C)
[    1.603036] GHES: HEST is not enabled!
[    1.603579] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    1.605257] ACPI: Battery Slot [BAT0] (battery present)
[    1.606216] Linux agpgart interface v0.103
[    1.612095] brd: module loaded
[    1.613523] loop: module loaded
[    1.613829] libphy: Fixed MDIO Bus: probed
[    1.613830] tun: Universal TUN/TAP device driver, 1.6
[    1.613830] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    1.614142] PPP generic driver version 2.4.2
[    1.614205] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI)
Driver
[    1.614209] ehci-pci: EHCI PCI platform driver
[    1.614497] ehci-pci 0000:00:12.0: EHCI Host Controller
[    1.614504] ehci-pci 0000:00:12.0: new USB bus registered, assigned
bus number 1
[    1.614528] ehci-pci 0000:00:12.0: debug port 2
[    1.614581] ehci-pci 0000:00:12.0: irq 18, io mem 0xf0c6d000
[    1.630685] ehci-pci 0000:00:12.0: USB 2.0 started, EHCI 1.00
[    1.630758] usb usb1: New USB device found, idVendor=1d6b,
idProduct=0002
[    1.630760] usb usb1: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    1.630761] usb usb1: Product: EHCI Host Controller
[    1.630762] usb usb1: Manufacturer: Linux 4.8.0-rc5-custom ehci_hcd
[    1.630763] usb usb1: SerialNumber: 0000:00:12.0
[    1.630969] hub 1-0:1.0: USB hub found
[    1.630975] hub 1-0:1.0: 2 ports detected
[    1.631153] ehci-platform: EHCI generic platform driver
[    1.631179] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.631189] ohci-pci: OHCI PCI platform driver
[    1.631201] ohci-platform: OHCI generic platform driver
[    1.631211] uhci_hcd: USB Universal Host Controller Interface driver
[    1.631349] xhci_hcd 0000:00:10.0: xHCI Host Controller
[    1.631354] xhci_hcd 0000:00:10.0: new USB bus registered, assigned
bus number 2
[    1.631613] xhci_hcd 0000:00:10.0: hcc params 0x014040c3 hci version
0x100 quirks 0x00000410
[    1.631808] usb usb2: New USB device found, idVendor=1d6b,
idProduct=0002
[    1.631809] usb usb2: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    1.631810] usb usb2: Product: xHCI Host Controller
[    1.631811] usb usb2: Manufacturer: Linux 4.8.0-rc5-custom xhci-hcd
[    1.631812] usb usb2: SerialNumber: 0000:00:10.0
[    1.632108] hub 2-0:1.0: USB hub found
[    1.632118] hub 2-0:1.0: 4 ports detected
[    1.632300] xhci_hcd 0000:00:10.0: xHCI Host Controller
[    1.632302] xhci_hcd 0000:00:10.0: new USB bus registered, assigned
bus number 3
[    1.638482] usb usb3: We don't know the algorithms for LPM for this
host, disabling LPM.
[    1.638514] usb usb3: New USB device found, idVendor=1d6b,
idProduct=0003
[    1.638515] usb usb3: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    1.638516] usb usb3: Product: xHCI Host Controller
[    1.638517] usb usb3: Manufacturer: Linux 4.8.0-rc5-custom xhci-hcd
[    1.638518] usb usb3: SerialNumber: 0000:00:10.0
[    1.638697] hub 3-0:1.0: USB hub found
[    1.638706] hub 3-0:1.0: 4 ports detected
[    1.638952] i8042: PNP: PS/2 Controller [PNP0303:KBD0,PNP0f13:PS2M]
at 0x60,0x64 irq 1,12
[    1.645211] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.645215] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.645555] mousedev: PS/2 mouse device common for all mice
[    1.645737] rtc_cmos 00:01: RTC can wake from S4
[    1.645847] rtc_cmos 00:01: rtc core: registered rtc_cmos as rtc0
[    1.645878] rtc_cmos 00:01: alarms up to one month, 114 bytes nvram,
hpet irqs
[    1.645883] i2c /dev entries driver
[    1.645948] device-mapper: uevent: version 1.0.3
[    1.646020] device-mapper: ioctl: 4.35.0-ioctl (2016-06-23)
initialised: dm-devel@redhat.com
[    1.646098] ledtrig-cpu: registered to indicate activity on CPUs
[    1.646099] EFI Variables Facility v0.08 2004-May-17
[    1.655340] input: AT Translated Set 2 keyboard as
/devices/platform/i8042/serio0/input/input3
[    1.685432] NET: Registered protocol family 10
[    1.685754] NET: Registered protocol family 17
[    1.685767] Key type dns_resolver registered
[    1.686131] microcode: CPU0: patch_level=0x06006113
[    1.686137] microcode: CPU1: patch_level=0x06006113
[    1.686146] microcode: CPU2: patch_level=0x06006113
[    1.686154] microcode: CPU3: patch_level=0x06006113
[    1.686201] microcode: Microcode Update Driver: v2.01 <tigran@aivazi
an.fsnet.co.uk>, Peter Oruba
[    1.686355] registered taskstats version 1
[    1.686360] Loading compiled-in X.509 certificates
[    1.690188] Loaded X.509 cert 'Build time autogenerated kernel key:
5915b196fb118f5f2b98a65b68125e0130265a40'
[    1.690228] zswap: loaded using pool lzo/zbud
[    1.713409] Key type trusted registered
[    1.716157] Key type encrypted registered
[    1.716163] AppArmor: AppArmor sha1 policy hashing enabled
[    1.716166] ima: No TPM chip found, activating TPM-bypass!
[    1.716198] evm: HMAC attrs: 0x1
[    1.716499]   Magic number: 0:829:701
[    1.716627] rtc_cmos 00:01: setting system clock to 2016-09-06
21:41:38 UTC (1473198098)
[    1.716810] acpi_cpufreq: overriding BIOS provided _PSD data
[    1.716994] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[    1.716995] EDD information not available.
[    1.717088] PM: Hibernation image not present or could not be
loaded.
[    1.718598] Freeing unused kernel memory: 1536K (ffffffffaff65000 -
ffffffffb00e5000)
[    1.718601] Write protecting the kernel read-only data: 14336k
[    1.719472] Freeing unused kernel memory: 1624K (ffff90c2b286a000 -
ffff90c2b2a00000)
[    1.720192] Freeing unused kernel memory: 308K (ffff90c2b2db3000 -
ffff90c2b2e00000)
[    1.746458] random: systemd-udevd: uninitialized urandom read (16
bytes read)
[    1.746573] random: systemd-udevd: uninitialized urandom read (16
bytes read)
[    1.746593] random: systemd-udevd: uninitialized urandom read (16
bytes read)
[    1.746618] random: systemd-udevd: uninitialized urandom read (16
bytes read)
[    1.747551] random: udevadm: uninitialized urandom read (16 bytes
read)
[    1.747607] random: udevadm: uninitialized urandom read (16 bytes
read)
[    1.750039] random: udevadm: uninitialized urandom read (16 bytes
read)
[    1.750122] random: udevadm: uninitialized urandom read (16 bytes
read)
[    1.750145] random: udevadm: uninitialized urandom read (16 bytes
read)
[    1.750252] random: udevadm: uninitialized urandom read (16 bytes
read)
[    1.806776] FUJITSU Extended Socket Network Device Driver - version
1.1 - Copyright (c) 2015 FUJITSU LIMITED
[    1.807570] ACPI: Video Device [VGA] (multi-head: yes  rom:
no  post: no)
[    1.807606] [Firmware Bug]: ACPI: No _BQC method, cannot determine
initial brightness
[    1.807930] acpi device:00: registered as cooling_device4
[    1.807995] input: Video Bus as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input5
[    1.813925] hidraw: raw HID events driver (C) Jiri Kosina
[    1.862527] wmi: Mapper loaded
[    1.872466] [drm] Initialized drm 1.1.0 20060810
[    1.873342] ahci 0000:00:11.0: version 3.0
[    1.873574] ahci 0000:00:11.0: AHCI 0001.0300 32 slots 1 ports 6
Gbps 0x1 impl SATA mode
[    1.873579] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo
pmp fbs pio slum part 
[    1.874255] scsi host0: ahci
[    1.874365] ata1: SATA max UDMA/133 abar m1024@0xf0c6c000 port
0xf0c6c100 irq 19
[    1.880334] rtsx_pci 0000:01:00.0: rtsx_pci_acquire_irq: pcr->msi_en 
= 1, pci->irq = 226
[    1.911490] [drm] amdgpu kernel modesetting enabled.
[    1.915568] AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
[    1.920329] Found CRAT image with size=1320
[    1.920331] Parsing CRAT table with 1 nodes
[    1.920334] Found CU entry in CRAT table with proximity_domain=0
caps=0
[    1.920335] CU CPU: cores=4 id_base=16
[    1.920336] Found CU entry in CRAT table with proximity_domain=0
caps=0
[    1.920336] CU GPU: simds=40 id_base=-2147483648
[    1.920338] Found memory entry in CRAT table with proximity_domain=0
[    1.920338] Found cache entry in CRAT table with processor_id=16
[    1.920339] Found cache entry in CRAT table with processor_id=16
[    1.920340] Found cache entry in CRAT table with processor_id=16
[    1.920341] Found cache entry in CRAT table with processor_id=17
[    1.920341] Found cache entry in CRAT table with processor_id=18
[    1.920342] Found cache entry in CRAT table with processor_id=18
[    1.920342] Found cache entry in CRAT table with processor_id=18
[    1.920343] Found cache entry in CRAT table with processor_id=19
[    1.920343] Found TLB entry in CRAT table (not processing)
[    1.920343] Found TLB entry in CRAT table (not processing)
[    1.920344] Found TLB entry in CRAT table (not processing)
[    1.920345] Found TLB entry in CRAT table (not processing)
[    1.920345] Found TLB entry in CRAT table (not processing)
[    1.920346] Found TLB entry in CRAT table (not processing)
[    1.920346] Found TLB entry in CRAT table (not processing)
[    1.920346] Found TLB entry in CRAT table (not processing)
[    1.920347] Found TLB entry in CRAT table (not processing)
[    1.920347] Found TLB entry in CRAT table (not processing)
[    1.920348] Creating topology SYSFS entries
[    1.920371] Finished initializing topology ret=0
[    1.920397] kfd kfd: Initialized module
[    1.920678] checking generic (e0000000 7e9000) vs hw (e0000000
10000000)
[    1.920680] fb: switching to amdgpudrmfb from EFI VGA
[    1.920731] Console: switching to colour dummy device 80x25
[    1.921393] [drm] initializing kernel modesetting (CARRIZO
0x1002:0x9874 0x103C:0x81AA 0xC8).
[    1.921415] [drm] register mmio base: 0xF0C00000
[    1.921415] [drm] register mmio size: 262144
[    1.921425] [drm] doorbell mmio base: 0xF0000000
[    1.921426] [drm] doorbell mmio size: 8388608
[    1.921443] [drm] UVD is enabled in physical mode
[    1.921450] [drm] ACPI VFCT contains a BIOS for 00:01.0 1002:9874,
size 64512
[    1.921499] ATOM BIOS: CARRIZO
[    1.922232] amdgpu 0000:00:01.0: VRAM: 512M 0x0000000000000000 -
0x000000001FFFFFFF (512M used)
[    1.922234] amdgpu 0000:00:01.0: GTT: 1024M 0x0000000020000000 -
0x000000005FFFFFFF
[    1.922236] [drm] Detected VRAM RAM=512M, BAR=256M
[    1.922237] [drm] RAM width 64bits UNKNOWN
[    1.923960] [TTM] Zone  kernel: Available graphics memory: 3845720
kiB
[    1.923961] [TTM] Zone   dma32: Available graphics memory: 2097152
kiB
[    1.923962] [TTM] Initializing pool allocator
[    1.923969] [TTM] Initializing DMA pool allocator
[    1.924009] [drm] amdgpu: 512M of VRAM memory ready
[    1.924010] [drm] amdgpu: 1024M of GTT memory ready.
[    1.924044] [drm] GART: num cpu pages 262144, num gpu pages 262144
[    1.925229] [drm] PCIE GART of 1024M enabled (table at
0x0000000000040000).
[    1.925273] [drm] Supports vblank timestamp caching Rev 2
(21.10.2013).
[    1.925273] [drm] Driver supports precise vblank timestamp query.
[    1.925334] amdgpu 0000:00:01.0: amdgpu: using MSI.
[    1.925363] [drm] amdgpu: irq initialized.
[    1.925372] [drm] amdgpu: dpm initialized
[    1.926775] [drm] amdgpu atom DIG backlight initialized
[    1.926778] [drm] AMDGPU Display Connectors
[    1.926780] [drm] Connector 0:
[    1.926781] [drm]   eDP-1
[    1.926782] [drm]   HPD1
[    1.926784] [drm]   DDC: 0x4868 0x4868 0x4869 0x4869 0x486a 0x486a
0x486b 0x486b
[    1.926785] [drm]   Encoders:
[    1.926786] [drm]     LCD1: INTERNAL_UNIPHY
[    1.926786] [drm] Connector 1:
[    1.926787] [drm]   HDMI-A-1
[    1.926788] [drm]   HPD2
[    1.926789] [drm]   DDC: 0x486c 0x486c 0x486d 0x486d 0x486e 0x486e
0x486f 0x486f
[    1.926790] [drm]   Encoders:
[    1.926790] [drm]     DFP1: INTERNAL_UNIPHY
[    1.927545] amdgpu 0000:00:01.0: fence driver on ring 0 use gpu addr
0x0000000020000010, cpu addr 0xffff90c3ed50c010
[    1.927611] amdgpu 0000:00:01.0: fence driver on ring 1 use gpu addr
0x0000000020000020, cpu addr 0xffff90c3ed50c020
[    1.927645] amdgpu 0000:00:01.0: fence driver on ring 2 use gpu addr
0x0000000020000030, cpu addr 0xffff90c3ed50c030
[    1.927686] amdgpu 0000:00:01.0: fence driver on ring 3 use gpu addr
0x0000000020000040, cpu addr 0xffff90c3ed50c040
[    1.927718] amdgpu 0000:00:01.0: fence driver on ring 4 use gpu addr
0x0000000020000050, cpu addr 0xffff90c3ed50c050
[    1.927755] amdgpu 0000:00:01.0: fence driver on ring 5 use gpu addr
0x0000000020000060, cpu addr 0xffff90c3ed50c060
[    1.927796] amdgpu 0000:00:01.0: fence driver on ring 6 use gpu addr
0x0000000020000070, cpu addr 0xffff90c3ed50c070
[    1.927829] amdgpu 0000:00:01.0: fence driver on ring 7 use gpu addr
0x0000000020000080, cpu addr 0xffff90c3ed50c080
[    1.927856] amdgpu 0000:00:01.0: fence driver on ring 8 use gpu addr
0x0000000020000090, cpu addr 0xffff90c3ed50c090
[    1.927962] amdgpu 0000:00:01.0: fence driver on ring 9 use gpu addr
0x00000000200000a0, cpu addr 0xffff90c3ed50c0a0
[    1.927993] amdgpu 0000:00:01.0: fence driver on ring 10 use gpu
addr 0x00000000200000b0, cpu addr 0xffff90c3ed50c0b0
[    1.928206] [drm] Found UVD firmware Version: 1.80 Family ID: 11
[    1.930019] amdgpu 0000:00:01.0: fence driver on ring 11 use gpu
addr 0x0000000000293ac0, cpu addr 0xffffbb3f41c40ac0
[    1.930256] [drm] Found VCE firmware Version: 50.17 Binary ID: 3
[    1.930433] amdgpu 0000:00:01.0: fence driver on ring 12 use gpu
addr 0x00000000200000d0, cpu addr 0xffff90c3ed50c0d0
[    1.931880] amdgpu 0000:00:01.0: fence driver on ring 13 use gpu
addr 0x00000000200000e0, cpu addr 0xffff90c3ed50c0e0
[    1.937269] [drm] ring test on 0 succeeded in 8 usecs
[    1.937510] [drm] ring test on 1 succeeded in 20 usecs
[    1.937542] [drm] ring test on 2 succeeded in 15 usecs
[    1.937554] [drm] ring test on 3 succeeded in 5 usecs
[    1.937560] [drm] ring test on 4 succeeded in 2 usecs
[    1.937567] [drm] ring test on 5 succeeded in 2 usecs
[    1.937573] [drm] ring test on 6 succeeded in 2 usecs
[    1.937578] [drm] ring test on 7 succeeded in 2 usecs
[    1.937586] [drm] ring test on 8 succeeded in 3 usecs
[    1.937630] [drm] ring test on 9 succeeded in 3 usecs
[    1.937635] [drm] ring test on 10 succeeded in 3 usecs
[    1.955199] AVX2 version of gcm_enc/dec engaged.
[    1.955203] AES CTR mode by8 optimization enabled
[    1.962770] usb 1-1: new high-speed USB device number 2 using ehci-
pci
[    1.963491] [drm] ring test on 11 succeeded in 1 usecs
[    1.963493] [drm] UVD initialized successfully.
[    2.110787] usb 1-1: New USB device found, idVendor=0438,
idProduct=7900
[    2.110790] usb 1-1: New USB device strings: Mfr=0, Product=0,
SerialNumber=0
[    2.111063] hub 1-1:1.0: USB hub found
[    2.111153] hub 1-1:1.0: 4 ports detected
[    2.162817] [drm] ring test on 12 succeeded in 14 usecs
[    2.162840] [drm] ring test on 13 succeeded in 2 usecs
[    2.162841] [drm] VCE initialized successfully.
[    2.168781] amdgpu 0000:00:01.0: SMC Failed to send Message.
[    2.354430] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.355939] ata1.00: ATA-9: HGST HTS721010A9E630, JB0OA3T0, max
UDMA/133
[    2.355940] ata1.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth
31/32), AA
[    2.357556] ata1.00: configured for UDMA/133
[    2.357774] scsi 0:0:0:0: Direct-Access     ATA      HGST
HTS721010A9 A3T0 PQ: 0 ANSI: 5
[    2.410413] usb 1-1.1: new full-speed USB device number 3 using
ehci-pci
[    2.536959] usb 1-1.1: New USB device found, idVendor=8087,
idProduct=0a2a
[    2.536961] usb 1-1.1: New USB device strings: Mfr=0, Product=0,
SerialNumber=0
[    2.622449] usb 1-1.2: new full-speed USB device number 4 using
ehci-pci
[    2.632092] psmouse serio1: synaptics: queried max coordinates: x
[..5636], y [..4634]
[    2.659862] psmouse serio1: synaptics: queried min coordinates: x
[1360..], y [1298..]
[    2.713946] random: fast init done
[    2.713974] psmouse serio1: synaptics: Touchpad model: 1, fw: 8.1,
id: 0x1e2b1, caps: 0xf00123/0x840300/0x12e800/0x0, board id: 3114, fw
id: 1805562
[    2.745384] usb 1-1.2: New USB device found, idVendor=0483,
idProduct=91d1
[    2.745386] usb 1-1.2: New USB device strings: Mfr=1, Product=2,
SerialNumber=3
[    2.745387] usb 1-1.2: Product: ST_SENSOR_HUB
[    2.745388] usb 1-1.2: Manufacturer: STMicroelectronics
[    2.745389] usb 1-1.2: SerialNumber: ST_SENSOR_HUB
[    2.748602] input: SynPS/2 Synaptics TouchPad as
/devices/platform/i8042/serio1/input/input6
[    2.761536] usbcore: registered new interface driver usbhid
[    2.761538] usbhid: USB HID core driver
[    2.826424] usb 1-1.3: new high-speed USB device number 5 using
ehci-pci
[    2.849183] tsc: Refined TSC clocksource calibration: 2694.942 MHz
[    2.849187] clocksource: tsc: mask: 0xffffffffffffffff max_cycles:
0x26d89433e1f, max_idle_ns: 440795210727 ns
[    2.864642] [drm] fb mappable at 0xE0614000
[    2.864643] [drm] vram apper at 0xE0000000
[    2.864644] [drm] size 8294400
[    2.864644] [drm] fb depth is 24
[    2.864645] [drm]    pitch is 7680
[    2.864805] fbcon: amdgpudrmfb (fb0) is primary device
[    3.579006] usb 1-1.3: New USB device found, idVendor=04f2,
idProduct=b56d
[    3.579009] usb 1-1.3: New USB device strings: Mfr=1, Product=2,
SerialNumber=0
[    3.579012] usb 1-1.3: Product: HP Wide Vision HD
[    3.579014] usb 1-1.3: Manufacturer: Chicony Electronics Co.,Ltd.
[    4.221102] clocksource: Switched to clocksource tsc
[    4.230791] sd 0:0:0:0: [sda] 1953525168 512-byte logical blocks:
(1.00 TB/932 GiB)
[    4.230794] sd 0:0:0:0: [sda] 4096-byte physical blocks
[    4.230822] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    4.230827] sd 0:0:0:0: [sda] Write Protect is off
[    4.230829] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    4.230843] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    4.250942] Console: switching to colour frame buffer device 240x67
[    4.255947] amdgpu 0000:00:01.0: fb0: amdgpudrmfb frame buffer
device
[    4.275065] [drm] ib test on ring 0 succeeded
[    4.275196] [drm] ib test on ring 1 succeeded
[    4.275243] [drm] ib test on ring 2 succeeded
[    4.275277] [drm] ib test on ring 3 succeeded
[    4.275324] [drm] ib test on ring 4 succeeded
[    4.275363] [drm] ib test on ring 5 succeeded
[    4.275396] [drm] ib test on ring 6 succeeded
[    4.275433] [drm] ib test on ring 7 succeeded
[    4.275472] [drm] ib test on ring 8 succeeded
[    4.275510] [drm] ib test on ring 9 succeeded
[    4.275540] [drm] ib test on ring 10 succeeded
[    4.276118] [drm] ib test on ring 11 succeeded
[    4.276763] [drm] ib test on ring 12 succeeded
[    4.289628]  sda: sda1 sda2 sda3
[    4.290225] sd 0:0:0:0: [sda] Attached SCSI disk
[    5.112729] kfd kfd: Allocated 3944480 bytes on gart for
device(1002:9874)
[    5.112744] amdkfd: adding doorbell packet type capability
[    5.112870] kfd kfd: added device (1002:9874)
[    5.112876] [drm] Initialized amdgpu 3.3.0 20150101 for 0000:00:01.0
on minor 0
[   11.140477] random: crng init done
[   14.664439] NET: Registered protocol family 38
[   16.313269] EXT4-fs (dm-1): mounted filesystem with ordered data
mode. Opts: (null)
[   17.469247] systemd[1]: systemd 229 running in system mode. (+PAM
+AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP
+GCRYPT +GNUTLS +ACL +XZ -LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN)
[   17.469571] systemd[1]: Detected architecture x86-64.
[   17.478202] systemd[1]: Set hostname to <Masaq>.
[   18.428629] systemd[1]: Started Forward Password Requests to Wall
Directory Watch.
[   18.428720] systemd[1]: Listening on udev Control Socket.
[   18.428750] systemd[1]: Listening on udev Kernel Socket.
[   18.428942] systemd[1]: Set up automount Arbitrary Executable File
Formats File System Automount Point.
[   18.429069] systemd[1]: Created slice User and Session Slice.
[   18.429111] systemd[1]: Listening on Device-mapper event daemon
FIFOs.
[   18.429123] systemd[1]: Reached target Remote File Systems (Pre).
[   19.436509] lp: driver loaded but no devices found
[   19.537908] ppdev: user-space parallel port driver
[   20.627493] EXT4-fs (dm-1): re-mounted. Opts: errors=remount-ro
[   20.752260] systemd-journald[1071]: Received request to flush
runtime journal from PID 1
[   21.276114] tpm_crb MSFT0101:00: can't request region for resource
[mem 0xdfb89000-0xdfb8cfff]
[   21.276123] tpm_crb: probe of MSFT0101:00 failed with error -16
[   21.321460] piix4_smbus 0000:00:14.0: SMBus Host Controller at
0xb00, revision 0
[   21.321463] piix4_smbus 0000:00:14.0: Using register 0x2e for SMBus
port selection
[   21.338369] AMD0020:00: ttyS4 at MMIO 0xfedc6000 (irq = 10,
base_baud = 3000000) is a 16550A
[   21.341266] i2c_hid i2c-ELAN0732:00: Fetching the HID descriptor
[   21.341270] i2c_hid i2c-ELAN0732:00: __i2c_hid_command: cmd=01 00
[   21.342843] i2c_hid i2c-ELAN0732:00: HID Descriptor: 1e 00 00 01 31
02 02 00 03 00 43 00 04 00 ff 00 05 00 06 00 f3 04 28 2b 04 11 00 00 00
00
[   21.343154] i2c_hid i2c-ELAN0732:00: entering i2c_hid_parse
[   21.343156] i2c_hid i2c-ELAN0732:00: i2c_hid_hwreset
[   21.343158] i2c_hid i2c-ELAN0732:00: i2c_hid_set_power
[   21.343160] i2c_hid i2c-ELAN0732:00: __i2c_hid_command: cmd=05 00 00
08
[   21.343335] i2c_hid i2c-ELAN0732:00: resetting...
[   21.343337] i2c_hid i2c-ELAN0732:00: __i2c_hid_command: cmd=05 00 00
01
[   21.343771] i2c_hid i2c-ELAN0732:00: __i2c_hid_command: waiting...
[   21.416022] Initializing HPQ6001 module
[   21.416199] input: HP Wireless hotkeys as
/devices/virtual/input/input7
[   21.473463] shpchp: Standard Hot Plug PCI Controller Driver version:
0.4
[   21.661031] hp_accel: laptop model unknown, using default axes
configuration
[   21.673529] lis3lv02d: unknown sensor type 0x0
[   21.673546] hp_accel: probe of HPQ6007:00 failed with error -22
[   21.796673] kvm: Nested Virtualization enabled
[   21.796676] kvm: Nested Paging enabled
[   22.167777] snd_hda_intel 0000:00:01.1: Force to non-snoop mode
[   22.335897] input: HDA ATI HDMI HDMI/DP,pcm=3 as
/devices/pci0000:00/0000:00:01.1/sound/card0/input8
[   22.390093] Intel(R) Wireless WiFi driver for Linux
[   22.390094] Copyright(c) 2003- 2015 Intel Corporation
[   22.420976] snd_hda_codec_conexant hdaudioC1D0: CX8200: BIOS auto-
probing.
[   22.421516] snd_hda_codec_conexant hdaudioC1D0: autoconfig for
CX8200: line_outs=1 (0x17/0x0/0x0/0x0/0x0) type:speaker
[   22.421519] snd_hda_codec_conexant hdaudioC1D0:    speaker_outs=0
(0x0/0x0/0x0/0x0/0x0)
[   22.421522] snd_hda_codec_conexant hdaudioC1D0:    hp_outs=1
(0x16/0x0/0x0/0x0/0x0)
[   22.421524] snd_hda_codec_conexant hdaudioC1D0:    mono:
mono_out=0x0
[   22.421526] snd_hda_codec_conexant hdaudioC1D0:    inputs:
[   22.421529] snd_hda_codec_conexant hdaudioC1D0:      Internal
Mic=0x1a
[   22.421532] snd_hda_codec_conexant hdaudioC1D0:      Mic=0x19
[   22.425910] input: HD-Audio Generic Mic as
/devices/pci0000:00/0000:00:09.2/sound/card1/input9
[   22.425994] input: HD-Audio Generic Headphone as
/devices/pci0000:00/0000:00:09.2/sound/card1/input10
[   22.623318] iwlwifi 0000:02:00.0: Direct firmware load for iwlwifi-
7265D-24.ucode failed with error -2
[   22.623350] iwlwifi 0000:02:00.0: Direct firmware load for iwlwifi-
7265D-23.ucode failed with error -2
[   22.623782] iwlwifi 0000:02:00.0: Direct firmware load for iwlwifi-
7265D-22.ucode failed with error -2
[   22.640588] iwlwifi 0000:02:00.0: Direct firmware load for iwlwifi-
7265D-21.ucode failed with error -2
[   22.641096] iwlwifi 0000:02:00.0: Direct firmware load for iwlwifi-
7265D-20.ucode failed with error -2
[   22.641309] iwlwifi 0000:02:00.0: Direct firmware load for iwlwifi-
7265D-19.ucode failed with error -2
[   22.646502] iwlwifi 0000:02:00.0: Direct firmware load for iwlwifi-
7265D-18.ucode failed with error -2
[   22.646562] iwlwifi 0000:02:00.0: Direct firmware load for iwlwifi-
7265D-17.ucode failed with error -2
[   22.904078] iwlwifi 0000:02:00.0: loaded firmware version
16.242414.0 op_mode iwlmvm
[   23.280944] input: HP WMI hotkeys as /devices/virtual/input/input11
[   23.859577] iwlwifi 0000:02:00.0: Detected Intel(R) Dual Band
Wireless AC 7265, REV=0x210
[   23.861784] iwlwifi 0000:02:00.0: L1 Disabled - LTR Disabled
[   23.861937] iwlwifi 0000:02:00.0: L1 Disabled - LTR Disabled
[   23.885947] Bluetooth: Core ver 2.21
[   23.885974] NET: Registered protocol family 31
[   23.885975] Bluetooth: HCI device and connection manager initialized
[   23.885980] Bluetooth: HCI socket layer initialized
[   23.885983] Bluetooth: L2CAP socket layer initialized
[   23.885990] Bluetooth: SCO socket layer initialized
[   23.892871] Adding 7831548k swap on /dev/mapper/ubuntu--gnome--vg-
swap_1.  Priority:-1 extents:1 across:7831548k FS
[   24.140998] ieee80211 phy0: Selected rate control algorithm 'iwl-
mvm-rs'
[   24.167687] iwlwifi 0000:02:00.0 wlo1: renamed from wlan0
[   24.290907] usbcore: registered new interface driver btusb
[   24.306591] Bluetooth: hci0: read Intel version: 370810011003110e00
[   24.366418] media: Linux media interface: v0.10
[   24.495233] Bluetooth: hci0: Intel Bluetooth firmware file:
intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq
[   24.625193] Linux video capture interface: v2.00
[   24.815730] Bluetooth: hci0: Intel Bluetooth firmware patch
completed and activated
[   25.106613] EXT4-fs (sda2): mounting ext2 file system using the ext4
subsystem
[   25.118526] uvcvideo: Found UVC 1.00 device HP Wide Vision HD
(04f2:b56d)
[   25.126709] uvcvideo 1-1.3:1.0: Entity type for entity Extension 4
was not initialized!
[   25.126714] uvcvideo 1-1.3:1.0: Entity type for entity Extension 3
was not initialized!
[   25.126717] uvcvideo 1-1.3:1.0: Entity type for entity Processing 2
was not initialized!
[   25.126719] uvcvideo 1-1.3:1.0: Entity type for entity Camera 1 was
not initialized!
[   25.127800] input: HP Wide Vision HD as
/devices/pci0000:00/0000:00:12.0/usb1/1-1/1-1.3/1-1.3:1.0/input/input12
[   25.127926] usbcore: registered new interface driver uvcvideo
[   25.127927] USB Video Class driver (1.1.1)
[   25.211758] EXT4-fs (sda2): mounted filesystem without journal.
Opts: (null)
[   26.546175] i2c_hid i2c-ELAN0732:00: __i2c_hid_command: finished.
[   26.546178] i2c_hid i2c-ELAN0732:00: failed to reset device.
[   26.546184] i2c_hid i2c-ELAN0732:00: i2c_hid_set_power
[   26.546186] i2c_hid i2c-ELAN0732:00: __i2c_hid_command: cmd=05 00 01
08
[   26.989045] audit: type=1400 audit(1473198123.768:2):
apparmor="STATUS" operation="profile_load" name="/usr/lib/snapd/snap-
confine" pid=2643 comm="apparmor_parser"
[   26.990578] audit: type=1400 audit(1473198123.772:3):
apparmor="STATUS" operation="profile_load" name="/usr/lib/libvirt/virt-
aa-helper" pid=2642 comm="apparmor_parser"
[   27.030487] audit: type=1400 audit(1473198123.812:4):
apparmor="STATUS" operation="profile_load" name="/usr/sbin/cups-
browsed" pid=2647 comm="apparmor_parser"
[   27.032139] audit: type=1400 audit(1473198123.812:5):
apparmor="STATUS" operation="profile_load" name="/sbin/dhclient"
pid=2639 comm="apparmor_parser"
[   27.032170] audit: type=1400 audit(1473198123.812:6):
apparmor="STATUS" operation="profile_load"
name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=2639
comm="apparmor_parser"
[   27.032178] audit: type=1400 audit(1473198123.812:7):
apparmor="STATUS" operation="profile_load"
name="/usr/lib/NetworkManager/nm-dhcp-helper" pid=2639
comm="apparmor_parser"
[   27.032204] audit: type=1400 audit(1473198123.812:8):
apparmor="STATUS" operation="profile_load"
name="/usr/lib/connman/scripts/dhclient-script" pid=2639
comm="apparmor_parser"
[   27.057521] audit: type=1400 audit(1473198123.836:9):
apparmor="STATUS" operation="profile_load" name="/usr/sbin/ippusbxd"
pid=2649 comm="apparmor_parser"
[   27.061687] audit: type=1400 audit(1473198123.840:10):
apparmor="STATUS" operation="profile_load"
name="/usr/lib/telepathy/mission-control-5" pid=2646
comm="apparmor_parser"
[   27.061697] audit: type=1400 audit(1473198123.840:11):
apparmor="STATUS" operation="profile_load"
name="/usr/lib/telepathy/telepathy-*" pid=2646 comm="apparmor_parser"
[   27.570140] i2c_hid i2c-ELAN0732:00: i2c_hid_hwreset
[   27.570145] i2c_hid i2c-ELAN0732:00: i2c_hid_set_power
[   27.570148] i2c_hid i2c-ELAN0732:00: __i2c_hid_command: cmd=05 00 00
08
[   27.570567] i2c_hid i2c-ELAN0732:00: resetting...
[   27.570572] i2c_hid i2c-ELAN0732:00: __i2c_hid_command: cmd=05 00 00
01
[   27.570876] i2c_hid i2c-ELAN0732:00: __i2c_hid_command: waiting...
[   27.738854] cgroup: new mount options do not match the existing
superblock, will be ignored
[   32.689984] i2c_hid i2c-ELAN0732:00: __i2c_hid_command: finished.
[   32.689987] i2c_hid i2c-ELAN0732:00: failed to reset device.
[   32.689994] i2c_hid i2c-ELAN0732:00: i2c_hid_set_power
[   32.689997] i2c_hid i2c-ELAN0732:00: __i2c_hid_command: cmd=05 00 01
08
[   33.714038] i2c_hid i2c-ELAN0732:00: i2c_hid_hwreset
[   33.714042] i2c_hid i2c-ELAN0732:00: i2c_hid_set_power
[   33.714046] i2c_hid i2c-ELAN0732:00: __i2c_hid_command: cmd=05 00 00
08
[   33.714466] i2c_hid i2c-ELAN0732:00: resetting...
[   33.714471] i2c_hid i2c-ELAN0732:00: __i2c_hid_command: cmd=05 00 00
01
[   33.714778] i2c_hid i2c-ELAN0732:00: __i2c_hid_command: waiting...
[   33.865660] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   33.865663] Bluetooth: BNEP filters: protocol multicast
[   33.865670] Bluetooth: BNEP socket layer initialized
[   36.319779] IPv6: ADDRCONF(NETDEV_UP): wlo1: link is not ready
[   36.322060] iwlwifi 0000:02:00.0: L1 Disabled - LTR Disabled
[   36.322227] iwlwifi 0000:02:00.0: L1 Disabled - LTR Disabled
[   36.389587] iwlwifi 0000:02:00.0: L1 Disabled - LTR Disabled
[   36.389749] iwlwifi 0000:02:00.0: L1 Disabled - LTR Disabled
[   36.407985] IPv6: ADDRCONF(NETDEV_UP): wlo1: link is not ready
[   37.285713] IPv6: ADDRCONF(NETDEV_UP): wlo1: link is not ready
[   37.658666] NET: Registered protocol family 24
[   37.811957] l2tp_core: L2TP core driver, V2.0
[   37.841305] l2tp_netlink: L2TP netlink interface
[   37.845653] l2tp_ppp: PPPoL2TP kernel driver, V2.0
[   38.833994] i2c_hid i2c-ELAN0732:00: __i2c_hid_command: finished.
[   38.833998] i2c_hid i2c-ELAN0732:00: failed to reset device.
[   38.834006] i2c_hid i2c-ELAN0732:00: i2c_hid_set_power
[   38.834009] i2c_hid i2c-ELAN0732:00: __i2c_hid_command: cmd=05 00 01
08
[   39.857976] i2c_hid i2c-ELAN0732:00: i2c_hid_hwreset
[   39.857979] i2c_hid i2c-ELAN0732:00: i2c_hid_set_power
[   39.857983] i2c_hid i2c-ELAN0732:00: __i2c_hid_command: cmd=05 00 00
08
[   39.858397] i2c_hid i2c-ELAN0732:00: resetting...
[   39.858402] i2c_hid i2c-ELAN0732:00: __i2c_hid_command: cmd=05 00 00
01
[   39.858707] i2c_hid i2c-ELAN0732:00: __i2c_hid_command: waiting...
[   40.180095] ip_tables: (C) 2000-2006 Netfilter Core Team
[   40.254401] ip6_tables: (C) 2000-2006 Netfilter Core Team
[   40.434115] Ebtables v2.0 registered
[   40.681861] wlo1: authenticate with c4:04:15:42:11:9a
[   40.689052] wlo1: send auth to c4:04:15:42:11:9a (try 1/3)
[   40.692129] wlo1: authenticated
[   40.694187] wlo1: associate with c4:04:15:42:11:9a (try 1/3)
[   40.698034] wlo1: RX AssocResp from c4:04:15:42:11:9a (capab=0x411
status=0 aid=2)
[   40.699901] wlo1: associated
[   40.699993] IPv6: ADDRCONF(NETDEV_CHANGE): wlo1: link becomes ready
[   41.495522] bridge: automatic filtering via arp/ip/ip6tables has
been deprecated. Update your scripts to load br_netfilter if you need
this.
[   41.557933] virbr0: port 1(virbr0-nic) entered blocking state
[   41.557935] virbr0: port 1(virbr0-nic) entered disabled state
[   41.558059] device virbr0-nic entered promiscuous mode
[   42.606682] nf_conntrack version 0.5.0 (65536 buckets, 262144 max)
[   43.275707] virbr0: port 1(virbr0-nic) entered blocking state
[   43.275711] virbr0: port 1(virbr0-nic) entered listening state
[   43.778125] virbr0: port 1(virbr0-nic) entered disabled state
[   43.781520] device virbr0-nic left promiscuous mode
[   43.781547] virbr0: port 1(virbr0-nic) entered disabled state
[   44.977866] i2c_hid i2c-ELAN0732:00: __i2c_hid_command: finished.
[   44.977870] i2c_hid i2c-ELAN0732:00: failed to reset device.
[   44.977879] i2c_hid i2c-ELAN0732:00: i2c_hid_set_power
[   44.977884] i2c_hid i2c-ELAN0732:00: __i2c_hid_command: cmd=05 00 01
08
[   46.001795] i2c_hid i2c-ELAN0732:00: can't add hid device: -61
[   46.025868] i2c_hid: probe of i2c-ELAN0732:00 failed with error -61
[   51.076315] Bluetooth: RFCOMM TTY layer initialized
[   51.076324] Bluetooth: RFCOMM socket layer initialized
[   51.076338] Bluetooth: RFCOMM ver 1.11
[   59.159699] show_signal_msg: 42 callbacks suppressed
[   59.159704] gnome-shell[3382]: segfault at 10 ip 00007f4e71fb7352 sp
00007ffd010f5d50 error 4 in amdgpu_dri.so[7f4e710bd000+28a9000]
[   60.659184] Non-volatile memory driver v1.3
[   62.097720] gnome-shell[3555]: segfault at 10 ip 00007f347934f352 sp
00007ffea6e457a0 error 4 in amdgpu_dri.so[7f3478455000+28a9000]
