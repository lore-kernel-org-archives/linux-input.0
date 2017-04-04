From: Nikolaus Rath <Nikolaus@rath.org>
Subject: Re: [PATCH 1/2] Alps HID I2C T4 device support
Date: Tue, 04 Apr 2017 10:08:38 -0700
Message-ID: <8760ik6qy1.fsf@thinkpad.rath.org>
References: <20170330025317.4093-2-masaki.ota@jp.alps.com>
        <87zifw7tti.fsf_-_@vostro.rath.org>
        <KAWPR01MB10924EBEDC42F952DFFBD205C70B0@KAWPR01MB1092.jpnprd01.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <linux-input-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:49823 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753188AbdDDRIl (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 4 Apr 2017 13:08:41 -0400
In-Reply-To: <KAWPR01MB10924EBEDC42F952DFFBD205C70B0@KAWPR01MB1092.jpnprd01.prod.outlook.com>
        (Masaki Ota's message of "Tue, 4 Apr 2017 06:55:00 +0000")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Masaki Ota <masaki.ota@jp.alps.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Masaki,

Yes, I think I have a 044E:120C. Is there a way to find out for sure?
It's not listed by e.g. lspci.

The touchpad is definitely not reacting to anything. evemu-record does
not show any events either.

I have attached the dmesg output.

Best,
-Nikolaus


On Apr 04 2017, Masaki Ota <masaki.ota@jp.alps.com> wrote:
> Hi, Nikolaus,
>
> Your Touchpad is 044E:120C, right?
>
> PATCH 1/2 supports 044E:120C Touchpad device.
> I think you can use all features of this Touchpad.
>
> PATCH 2/2 supports 044E:1215 Touchpad device.
> You don't need to care about this.
>
> If Touchpad does not work completely, there is something an error.
> What does dmesg show?
>
> Best Regards,
> Masaki Ota
> -----Original Message-----
> From: Nikolaus Rath [mailto:Nikolaus@rath.org]=20
> Sent: Tuesday, April 04, 2017 12:09 PM
> To: =E5=A4=AA=E7=94=B0 =E7=9C=9F=E5=96=9C Masaki Ota <masaki.ota@jp.alps.=
com>; linux-kernel <linux-kernel@vger.kernel.org>; linux-input@vger.kernel.=
org
> Subject: Re: [PATCH 1/2] Alps HID I2C T4 device support
>
> Hi Ota,
>
>> -Support Alps HID I2C T4 Touchpad device.
>> -Laptop names that use this Touchpad:HP Zbook Studio, Elitebook Folio=20
>> G1, Elitebook 1030 G1, Elitebook 1040 G3
>>
>> Signed-off-by: Masaki Ota <masaki.ota@xxxxxxxxxxx>
>> ---
>>  drivers/hid/hid-alps.c | 500 +++++++++++++++++++++++++++++++++++++++---=
-------
>>  drivers/hid/hid-core.c |   3 +-
>>  drivers/hid/hid-ids.h  |   1 +
>>  3 files changed, 403 insertions(+), 101 deletions(-)
>=20=20
> I tried your patch on an HP Elitebook, but with rather limited success. B=
efore, I was able to use the touchpad in limited fashion (https://bugs.free=
desktop.org/show_bug.cgi?id=3D100345). With your patch (applied on top of 4=
.10), the touchpad no longer reacts at all.
>
> That said, I didn't find a patch 2/2 anywhere.. is there something missin=
g?
>
> Thanks,
> -Nikolaus
>
> --
> GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F
>
>              =C2=BBTime flies like an arrow, fruit flies like a Banana.=
=C2=AB


--=20
GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

             =C2=BBTime flies like an arrow, fruit flies like a Banana.=C2=
=AB

--=-=-=
Content-Type: text/plain
Content-Disposition: inline; filename=dmesg.txt

[    0.000000] microcode: microcode updated early to revision 0x9e, date = 2016-06-22
[    0.000000] Linux version 4.10.0+ (nikratio@thinkpad) (gcc version 4.9.2 (Debian 4.9.2-10) ) #1 SMP Mon Apr 3 15:52:58 PDT 2017
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-4.10.0+ root=/dev/mapper/vg0-debian ro quiet splash
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
[    0.000000] BIOS-e820: [mem 0x0000000000059000-0x000000000009dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009e000-0x000000000009efff] reserved
[    0.000000] BIOS-e820: [mem 0x000000000009f000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000b71fafff] usable
[    0.000000] BIOS-e820: [mem 0x00000000b71fb000-0x00000000b76fafff] type 20
[    0.000000] BIOS-e820: [mem 0x00000000b76fb000-0x00000000b7d7efff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000b7d7f000-0x00000000b7f7efff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000b7f7f000-0x00000000b7ffefff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000b7fff000-0x00000000b7ffffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000b8000000-0x00000000c67fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f80fa000-0x00000000f80fafff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f80fd000-0x00000000f80fdfff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x00000002377fffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.40 by HP
[    0.000000] efi:  ACPI=0xb7ffe000  ACPI 2.0=0xb7ffe014  SMBIOS=0xb79db000  MPS=0xb7a3b000  ESRT=0xb7173660 
[    0.000000] SMBIOS 2.7 present.
[    0.000000] DMI: HP HP EliteBook Folio 1040 G3/80FA, BIOS N83 Ver. 01.09 11/01/2016
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x237800 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: write-back
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 00E0000000 mask 7FE0000000 uncachable
[    0.000000]   1 base 00D0000000 mask 7FF0000000 uncachable
[    0.000000]   2 base 00C8000000 mask 7FF8000000 uncachable
[    0.000000]   3 base 00C4000000 mask 7FFC000000 uncachable
[    0.000000]   4 base 00C2000000 mask 7FFE000000 uncachable
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000]   8 disabled
[    0.000000]   9 disabled
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- WT  
[    0.000000] e820: last_pfn = 0xb8000 max_arch_pfn = 0x400000000
[    0.000000] efi: requested map not found.
[    0.000000] esrt: ESRT header is not in the memory map.
[    0.000000] Base memory trampoline at [ffff912fc0097000] 97000 size 24576
[    0.000000] Using GB pages for direct mapping
[    0.000000] BRK [0x15b44000, 0x15b44fff] PGTABLE
[    0.000000] BRK [0x15b45000, 0x15b45fff] PGTABLE
[    0.000000] BRK [0x15b46000, 0x15b46fff] PGTABLE
[    0.000000] BRK [0x15b47000, 0x15b47fff] PGTABLE
[    0.000000] BRK [0x15b48000, 0x15b48fff] PGTABLE
[    0.000000] BRK [0x15b49000, 0x15b49fff] PGTABLE
[    0.000000] RAMDISK: [mem 0x36ef8000-0x37773fff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000B7FFE014 000024 (v02 HPQOEM)
[    0.000000] ACPI: XSDT 0x00000000B7FBB188 0000D4 (v01 HPQOEM SLIC-BPC 00000000      01000013)
[    0.000000] ACPI: FACP 0x00000000B7FEF000 0000F4 (v05 HPQOEM SLIC-BPC 00000000 HP   00000001)
[    0.000000] ACPI: DSDT 0x00000000B7FC5000 026078 (v02 HPQOEM 80FA     00000000 INTL 20121018)
[    0.000000] ACPI: FACS 0x00000000B7F68000 000040
[    0.000000] ACPI: SSDT 0x00000000B7FFC000 000108 (v02 HP     ShmTable 00000001 INTL 20121018)
[    0.000000] ACPI: TCPA 0x00000000B7FFA000 000032 (v02 HPQOEM EDK2     00000002      01000013)
[    0.000000] ACPI: SSDT 0x00000000B7FF9000 0003B8 (v02 HPQOEM TcgTable 00001000 INTL 20121018)
[    0.000000] ACPI: UEFI 0x00000000B7F7A000 000042 (v01 HPQOEM EDK2     00000002      01000013)
[    0.000000] ACPI: SSDT 0x00000000B7FF3000 0051FA (v02 SaSsdt SaSsdt   00003000 INTL 20121018)
[    0.000000] ACPI: SSDT 0x00000000B7FF2000 0005B1 (v01 Intel  PerfTune 00001000 INTL 20121018)
[    0.000000] ACPI: MSDM 0x00000000B7FF1000 000055 (v03 HPQOEM SLIC-BPC 00000000 HP   00000001)
[    0.000000] ACPI: SLIC 0x00000000B7FF0000 000176 (v01 HPQOEM SLIC-BPC 00000001 HP   00000001)
[    0.000000] ACPI: HPET 0x00000000B7FEE000 000038 (v01 HPQOEM 80FA     00000001 HP   00000001)
[    0.000000] ACPI: APIC 0x00000000B7FED000 0000BC (v01 HPQOEM 80FA     00000001 HP   00000001)
[    0.000000] ACPI: MCFG 0x00000000B7FEC000 00003C (v01 HPQOEM 80FA     00000001 HP   00000001)
[    0.000000] ACPI: SSDT 0x00000000B7FC4000 00019A (v02 HPQOEM Sata0Ide 00001000 INTL 20121018)
[    0.000000] ACPI: SSDT 0x00000000B7FC3000 000729 (v01 HPQOEM PtidDevc 00001000 INTL 20121018)
[    0.000000] ACPI: SSDT 0x00000000B7FC2000 000E73 (v02 CpuRef CpuSsdt  00003000 INTL 20121018)
[    0.000000] ACPI: SSDT 0x00000000B7FC0000 001B5C (v01 HP     LAPTOPPC 00001000 INTL 20121018)
[    0.000000] ACPI: DMAR 0x00000000B7FBF000 0000F0 (v01 INTEL  SKL      00000001 INTL 00000001)
[    0.000000] ACPI: NHLT 0x00000000B7FBE000 00002D (v00 INTEL  EDK2     00000002      01000013)
[    0.000000] ACPI: ASF! 0x00000000B7FBD000 0000A5 (v32 HPQOEM  UYA     00000001 TFSM 000F4240)
[    0.000000] ACPI: FPDT 0x00000000B7FBC000 000044 (v01 HPQOEM EDK2     00000002      01000013)
[    0.000000] ACPI: BGRT 0x00000000B7FFD000 000038 (v01 HPQOEM EDK2     00000002      01000013)
[    0.000000] ACPI: SSDT 0x00000000B7FFB000 000260 (v02 HP     PwrCtlEv 00000001 INTL 20121018)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x00000002377fffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x2377f9000-0x2377fdfff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x00000002377fffff]
[    0.000000]   Device   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x0000000000057fff]
[    0.000000]   node   0: [mem 0x0000000000059000-0x000000000009dfff]
[    0.000000]   node   0: [mem 0x000000000009f000-0x000000000009ffff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x00000000b71fafff]
[    0.000000]   node   0: [mem 0x00000000b7fff000-0x00000000b7ffffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x00000002377fffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x00000002377fffff]
[    0.000000] On node 0 totalpages: 2025881
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 89 pages reserved
[    0.000000]   DMA zone: 3997 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 11656 pages used for memmap
[    0.000000]   DMA32 zone: 745980 pages, LIFO batch:31
[    0.000000]   Normal zone: 19936 pages used for memmap
[    0.000000]   Normal zone: 1275904 pages, LIFO batch:31
[    0.000000] Reserving Intel graphics memory at 0x00000000c2800000-0x00000000c67fffff
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
[    0.000000] PM: Registered nosave memory: [mem 0x0009e000-0x0009efff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xb71fb000-0xb76fafff]
[    0.000000] PM: Registered nosave memory: [mem 0xb76fb000-0xb7d7efff]
[    0.000000] PM: Registered nosave memory: [mem 0xb7d7f000-0xb7f7efff]
[    0.000000] PM: Registered nosave memory: [mem 0xb7f7f000-0xb7ffefff]
[    0.000000] PM: Registered nosave memory: [mem 0xb8000000-0xc67fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xc6800000-0xf80f9fff]
[    0.000000] PM: Registered nosave memory: [mem 0xf80fa000-0xf80fafff]
[    0.000000] PM: Registered nosave memory: [mem 0xf80fb000-0xf80fcfff]
[    0.000000] PM: Registered nosave memory: [mem 0xf80fd000-0xf80fdfff]
[    0.000000] PM: Registered nosave memory: [mem 0xf80fe000-0xfdffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfe000000-0xfe010fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfe011000-0xffffffff]
[    0.000000] e820: [mem 0xc6800000-0xf80f9fff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.000000] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:4 nr_node_ids:1
[    0.000000] percpu: Embedded 35 pages/cpu @ffff9131f7400000 s104920 r8192 d30248 u524288
[    0.000000] pcpu-alloc: s104920 r8192 d30248 u524288 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 1994136
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-4.10.0+ root=/dev/mapper/vg0-debian ro quiet splash
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 7651564K/8103524K available (6245K kernel code, 1209K rwdata, 2684K rodata, 1408K init, 688K bss, 451960K reserved, 0K cma-reserved)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 64.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=4.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=4
[    0.000000] NR_IRQS:33024 nr_irqs:1024 16
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635855245 ns
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Detected 2800.000 MHz processor
[    0.000023] Calibrating delay loop (skipped), value calculated using timer frequency.. 5616.00 BogoMIPS (lpj=11232000)
[    0.000025] pid_max: default: 32768 minimum: 301
[    0.000038] ACPI: Core revision 20160930
[    0.034398] ACPI: 10 ACPI AML tables successfully acquired and loaded
[    0.034737] Security Framework initialized
[    0.034737] Yama: becoming mindful.
[    0.034741] AppArmor: AppArmor disabled by boot time parameter
[    0.035127] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.036611] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.037312] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.037319] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.037562] CPU: Physical Processor ID: 0
[    0.037563] CPU: Processor Core ID: 0
[    0.037567] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.037567] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[    0.037572] mce: CPU supports 8 MCE banks
[    0.037581] CPU0: Thermal monitoring enabled (TM1)
[    0.037596] process: using mwait in idle threads
[    0.037598] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[    0.037599] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    0.037695] Freeing SMP alternatives memory: 24K
[    0.046102] ftrace: allocating 25236 entries in 99 pages
[    0.056614] smpboot: Max logical packages: 2
[    0.056623] DMAR: Host address width 39
[    0.056624] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.056631] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c40660462 ecap 7e3ff0505e
[    0.056632] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.056636] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c40660462 ecap f050da
[    0.056637] DMAR: RMRR base: 0x000000b7d37000 end: 0x000000b7d56fff
[    0.056637] DMAR: RMRR base: 0x000000c2000000 end: 0x000000c67fffff
[    0.056638] DMAR: ANDD device: 1 name: \_SB.PCI0.I2C0
[    0.056639] DMAR: ANDD device: 2 name: \_SB.PCI0.I2C1
[    0.056640] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    0.056641] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.056642] DMAR-IR: x2apic is disabled because BIOS sets x2apic opt out bit.
[    0.056642] DMAR-IR: Use 'intremap=no_x2apic_optout' to override the BIOS setting.
[    0.058081] DMAR-IR: Enabled IRQ remapping in xapic mode
[    0.058081] x2apic: IRQ remapping doesn't support X2APIC mode
[    0.062179] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.101885] TSC deadline timer enabled
[    0.101889] smpboot: CPU0: Intel(R) Core(TM) i7-6600U CPU @ 2.60GHz (family: 0x6, model: 0x4e, stepping: 0x3)
[    0.101939] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.
[    0.101968] ... version:                4
[    0.101968] ... bit width:              48
[    0.101968] ... generic registers:      4
[    0.101969] ... value mask:             0000ffffffffffff
[    0.101969] ... max period:             00007fffffffffff
[    0.101970] ... fixed-purpose events:   3
[    0.101970] ... event mask:             000000070000000f
[    0.102428] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
[    0.102439] smp: Bringing up secondary CPUs ...
[    0.102515] x86: Booting SMP configuration:
[    0.102516] .... node  #0, CPUs:      #1 #2 #3
[    0.341997] smp: Brought up 1 node, 4 CPUs
[    0.341999] smpboot: Total of 4 processors activated (22467.50 BogoMIPS)
[    0.346175] devtmpfs: initialized
[    0.346240] x86/mm: Memory block size: 128MB
[    0.348357] PM: Registering ACPI NVS region [mem 0xb7d7f000-0xb7f7efff] (2097152 bytes)
[    0.348447] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.348455] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.348496] pinctrl core: initialized pinctrl subsystem
[    0.348581] NET: Registered protocol family 16
[    0.362042] cpuidle: using governor ladder
[    0.378065] cpuidle: using governor menu
[    0.378066] PCCT header not found.
[    0.378090] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    0.378091] ACPI: bus type PCI registered
[    0.378092] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.378147] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.378169] PCI: not using MMCONFIG
[    0.378170] PCI: Using configuration type 1 for base access
[    0.394200] HugeTLB registered 1 GB page size, pre-allocated 0 pages
[    0.394201] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.394368] ACPI: Added _OSI(Module Device)
[    0.394369] ACPI: Added _OSI(Processor Device)
[    0.394370] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.394370] ACPI: Added _OSI(Processor Aggregator Device)
[    0.395604] ACPI: Executed 17 blocks of module-level executable AML code
[    0.404919] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.409674] ACPI: Dynamic OEM Table Load:
[    0.409707] ACPI: SSDT 0xFFFF9131EDB40000 0006A2 (v02 PmRef  Cpu0Ist  00003000 INTL 20121018)
[    0.409919] ACPI: \_PR_.CPU0: _OSC native thermal LVT Acked
[    0.410961] ACPI: Dynamic OEM Table Load:
[    0.410967] ACPI: SSDT 0xFFFF9131ED4A8800 00037F (v02 PmRef  Cpu0Cst  00003001 INTL 20121018)
[    0.411219] ACPI: Dynamic OEM Table Load:
[    0.411224] ACPI: SSDT 0xFFFF9131EDB416C0 00008E (v02 PmRef  Cpu0Hwp  00003000 INTL 20121018)
[    0.411387] ACPI: Dynamic OEM Table Load:
[    0.411392] ACPI: SSDT 0xFFFF9131ED4C7000 000130 (v02 PmRef  HwpLvt   00003000 INTL 20121018)
[    0.411966] ACPI: Dynamic OEM Table Load:
[    0.411972] ACPI: SSDT 0xFFFF9131ED4C6800 0005AA (v02 PmRef  ApIst    00003000 INTL 20121018)
[    0.412423] ACPI: Dynamic OEM Table Load:
[    0.412428] ACPI: SSDT 0xFFFF9131ED4C7200 000119 (v02 PmRef  ApHwp    00003000 INTL 20121018)
[    0.412673] ACPI: Dynamic OEM Table Load:
[    0.412678] ACPI: SSDT 0xFFFF9131ED4C7600 000119 (v02 PmRef  ApCst    00003000 INTL 20121018)
[    0.414289] ACPI : EC: EC started
[    1.063111] ACPI: \_SB_.PCI0.LPCB.EC0_: Used as first EC
[    1.063112] ACPI: \_SB_.PCI0.LPCB.EC0_: GPE=0x6e, EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    1.063113] ACPI: \_SB_.PCI0.LPCB.EC0_: Used as boot DSDT EC to handle transactions
[    1.063114] ACPI: Interpreter enabled
[    1.063158] ACPI: (supports S0 S3 S4 S5)
[    1.063159] ACPI: Using IOAPIC for interrupt routing
[    1.063193] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
[    1.065576] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in ACPI motherboard resources
[    1.065582] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    1.066767] ACPI: Power Resource [PG01] (on)
[    1.067113] ACPI: Power Resource [PG02] (on)
[    1.067466] ACPI: Power Resource [PG00] (on)
[    1.072921] ACPI: Power Resource [WRST] (on)
[    1.073346] ACPI: Power Resource [WRST] (on)
[    1.073770] ACPI: Power Resource [WRST] (on)
[    1.074289] ACPI: Power Resource [WRST] (on)
[    1.074713] ACPI: Power Resource [WRST] (on)
[    1.075170] ACPI: Power Resource [WRST] (on)
[    1.075592] ACPI: Power Resource [WRST] (on)
[    1.076015] ACPI: Power Resource [WRST] (on)
[    1.076437] ACPI: Power Resource [WRST] (on)
[    1.076863] ACPI: Power Resource [WRST] (on)
[    1.077289] ACPI: Power Resource [WRST] (on)
[    1.077714] ACPI: Power Resource [WRST] (on)
[    1.078105] ACPI: Power Resource [WRST] (on)
[    1.078496] ACPI: Power Resource [WRST] (on)
[    1.078886] ACPI: Power Resource [WRST] (on)
[    1.079285] ACPI: Power Resource [WRST] (on)
[    1.079677] ACPI: Power Resource [WRST] (on)
[    1.080070] ACPI: Power Resource [WRST] (on)
[    1.080462] ACPI: Power Resource [WRST] (on)
[    1.080857] ACPI: Power Resource [WRST] (on)
[    1.086743] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
[    1.086749] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    1.089929] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]
[    1.089930] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
[    1.091996] PCI host bridge to bus 0000:00
[    1.091997] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    1.091998] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    1.091999] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    1.092000] pci_bus 0000:00: root bus resource [mem 0xc6800000-0xf7ffffff window]
[    1.092001] pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7fffff window]
[    1.092002] pci_bus 0000:00: root bus resource [bus 00-3e]
[    1.092011] pci 0000:00:00.0: [8086:1904] type 00 class 0x060000
[    1.092769] pci 0000:00:02.0: [8086:1916] type 00 class 0x030000
[    1.092778] pci 0000:00:02.0: reg 0x10: [mem 0xe0000000-0xe0ffffff 64bit]
[    1.092784] pci 0000:00:02.0: reg 0x18: [mem 0xd0000000-0xdfffffff 64bit pref]
[    1.092788] pci 0000:00:02.0: reg 0x20: [io  0x3000-0x303f]
[    1.093607] pci 0000:00:14.0: [8086:9d2f] type 00 class 0x0c0330
[    1.093624] pci 0000:00:14.0: reg 0x10: [mem 0xe1120000-0xe112ffff 64bit]
[    1.093687] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    1.094463] pci 0000:00:14.0: System wakeup disabled by ACPI
[    1.094501] pci 0000:00:14.2: [8086:9d31] type 00 class 0x118000
[    1.094518] pci 0000:00:14.2: reg 0x10: [mem 0xe114b000-0xe114bfff 64bit]
[    1.095400] pci 0000:00:15.0: [8086:9d60] type 00 class 0x118000
[    1.095583] pci 0000:00:15.0: reg 0x10: [mem 0xe114c000-0xe114cfff 64bit]
[    1.097019] pci 0000:00:15.1: [8086:9d61] type 00 class 0x118000
[    1.097178] pci 0000:00:15.1: reg 0x10: [mem 0xe114d000-0xe114dfff 64bit]
[    1.098548] pci 0000:00:16.0: [8086:9d3a] type 00 class 0x078000
[    1.098569] pci 0000:00:16.0: reg 0x10: [mem 0xe114e000-0xe114efff 64bit]
[    1.098636] pci 0000:00:16.0: PME# supported from D3hot
[    1.099393] pci 0000:00:16.3: [8086:9d3d] type 00 class 0x070002
[    1.099404] pci 0000:00:16.3: reg 0x10: [io  0x3080-0x3087]
[    1.099410] pci 0000:00:16.3: reg 0x14: [mem 0xe114a000-0xe114afff]
[    1.100190] pci 0000:00:17.0: [8086:9d03] type 00 class 0x010601
[    1.100204] pci 0000:00:17.0: reg 0x10: [mem 0xe1148000-0xe1149fff]
[    1.100212] pci 0000:00:17.0: reg 0x14: [mem 0xe1151000-0xe11510ff]
[    1.100219] pci 0000:00:17.0: reg 0x18: [io  0x3088-0x308f]
[    1.100226] pci 0000:00:17.0: reg 0x1c: [io  0x3090-0x3093]
[    1.100234] pci 0000:00:17.0: reg 0x20: [io  0x3040-0x305f]
[    1.100241] pci 0000:00:17.0: reg 0x24: [mem 0xe114f000-0xe114f7ff]
[    1.100285] pci 0000:00:17.0: PME# supported from D3hot
[    1.101056] pci 0000:00:1c.0: [8086:9d13] type 01 class 0x060400
[    1.101120] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    1.101868] pci 0000:00:1c.0: System wakeup disabled by ACPI
[    1.101933] pci 0000:00:1f.0: [8086:9d48] type 00 class 0x060100
[    1.102754] pci 0000:00:1f.2: [8086:9d21] type 00 class 0x058000
[    1.102763] pci 0000:00:1f.2: reg 0x10: [mem 0xe1140000-0xe1143fff]
[    1.103558] pci 0000:00:1f.3: [8086:9d70] type 00 class 0x040380
[    1.103578] pci 0000:00:1f.3: reg 0x10: [mem 0xe1144000-0xe1147fff 64bit]
[    1.103602] pci 0000:00:1f.3: reg 0x20: [mem 0xe1130000-0xe113ffff 64bit]
[    1.103653] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    1.104414] pci 0000:00:1f.3: System wakeup disabled by ACPI
[    1.104457] pci 0000:00:1f.4: [8086:9d23] type 00 class 0x0c0500
[    1.104496] pci 0000:00:1f.4: reg 0x10: [mem 0xe1150000-0xe11500ff 64bit]
[    1.104546] pci 0000:00:1f.4: reg 0x20: [io  0xefa0-0xefbf]
[    1.105361] pci 0000:00:1f.6: [8086:156f] type 00 class 0x020000
[    1.105378] pci 0000:00:1f.6: reg 0x10: [mem 0xe1100000-0xe111ffff]
[    1.105463] pci 0000:00:1f.6: PME# supported from D0 D3hot D3cold
[    1.106196] pci 0000:00:1f.6: System wakeup disabled by ACPI
[    1.106343] pci 0000:01:00.0: [8086:24f3] type 00 class 0x028000
[    1.106375] pci 0000:01:00.0: reg 0x10: [mem 0xe1000000-0xe1001fff 64bit]
[    1.106629] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    1.106777] pci 0000:01:00.0: System wakeup disabled by ACPI
[    1.115122] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    1.115126] pci 0000:00:1c.0:   bridge window [mem 0xe1000000-0xe10fffff]
[    1.118643] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 *11 12 14 15)
[    1.118698] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *10 11 12 14 15)
[    1.118752] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 *11 12 14 15)
[    1.118804] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 *11 12 14 15)
[    1.118857] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 *11 12 14 15)
[    1.118911] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 *11 12 14 15)
[    1.118961] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 *11 12 14 15)
[    1.119015] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 *11 12 14 15)
[    1.119417] ACPI: Enabled 5 GPEs in block 00 to 7F
[    1.119469] ACPI : EC: event unblocked
[    1.119476] ACPI: \_SB_.PCI0.LPCB.EC0_: GPE=0x6e, EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    1.119477] ACPI: \_SB_.PCI0.LPCB.EC0_: Used as boot DSDT EC to handle transactions and events
[    1.119578] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    1.119579] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    1.119581] pci 0000:00:02.0: vgaarb: bridge control possible
[    1.119581] vgaarb: loaded
[    1.119610] Registered efivars operations
[    1.150412] PCI: Using ACPI for IRQ routing
[    1.157379] PCI: pci_cache_line_size set to 64 bytes
[    1.157567] e820: reserve RAM buffer [mem 0x00058000-0x0005ffff]
[    1.157568] e820: reserve RAM buffer [mem 0x0009e000-0x0009ffff]
[    1.157569] e820: reserve RAM buffer [mem 0xb71fb000-0xb7ffffff]
[    1.157570] e820: reserve RAM buffer [mem 0x237800000-0x237ffffff]
[    1.157742] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    1.157745] hpet0: 8 comparators, 64-bit 24.000000 MHz counter
[    1.160798] clocksource: Switched to clocksource hpet
[    1.166228] VFS: Disk quotas dquot_6.6.0
[    1.166252] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.166316] pnp: PnP ACPI init
[    1.166432] system 00:00: [mem 0xfd000000-0xfdabffff] has been reserved
[    1.166433] system 00:00: [mem 0xfdad0000-0xfdadffff] has been reserved
[    1.166434] system 00:00: [mem 0xfdb00000-0xfdffffff] has been reserved
[    1.166435] system 00:00: [mem 0xfe000000-0xfe01ffff] could not be reserved
[    1.166436] system 00:00: [mem 0xfe03d000-0xfe3fffff] has been reserved
[    1.166438] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.166714] system 00:01: [io  0x2000-0x20fe] has been reserved
[    1.166716] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.166923] system 00:02: [io  0x0680-0x069f] has been reserved
[    1.166924] system 00:02: [io  0xffff] has been reserved
[    1.166925] system 00:02: [io  0xffff] has been reserved
[    1.166926] system 00:02: [io  0xffff] has been reserved
[    1.166927] system 00:02: [io  0x1800-0x18fe] has been reserved
[    1.166928] system 00:02: [io  0x164e-0x164f] has been reserved
[    1.166929] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.167017] pnp 00:03: Plug and Play ACPI device, IDs PNP0b00 (active)
[    1.167047] system 00:04: [io  0x1854-0x1857] has been reserved
[    1.167048] system 00:04: Plug and Play ACPI device, IDs INT3f0d PNP0c02 (active)
[    1.167064] pnp 00:05: Plug and Play ACPI device, IDs HPQ8002 PNP0303 (active)
[    1.167081] pnp 00:06: Plug and Play ACPI device, IDs ALP010d ALP0002 PNP0f13 (active)
[    1.167129] system 00:07: [io  0x0200-0x023f] has been reserved
[    1.167130] system 00:07: [mem 0xfedf0000-0xfedfffff] has been reserved
[    1.167131] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.168155] system 00:08: [mem 0xfe031000-0xfe031fff] has been reserved
[    1.168156] system 00:08: [mem 0xfe030008-0xfe030fff] has been reserved
[    1.168158] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.168555] system 00:09: [mem 0xfe030000-0xfe030007] has been reserved
[    1.168557] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.168791] system 00:0a: [mem 0xfed10000-0xfed17fff] has been reserved
[    1.168792] system 00:0a: [mem 0xfed18000-0xfed18fff] has been reserved
[    1.168793] system 00:0a: [mem 0xfed19000-0xfed19fff] has been reserved
[    1.168794] system 00:0a: [mem 0xf8000000-0xfbffffff] could not be reserved
[    1.168795] system 00:0a: [mem 0xfed20000-0xfed3ffff] has been reserved
[    1.168796] system 00:0a: [mem 0xfed90000-0xfed93fff] could not be reserved
[    1.168818] system 00:0a: [mem 0xfed45000-0xfed8ffff] has been reserved
[    1.168820] system 00:0a: [mem 0xff000000-0xffffffff] has been reserved
[    1.168820] system 00:0a: [mem 0xfee00000-0xfeefffff] has been reserved
[    1.168821] system 00:0a: [mem 0xc6800000-0xc681ffff] has been reserved
[    1.168823] system 00:0a: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.169070] pnp 00:0b: Plug and Play ACPI device, IDs IFX0102 PNP0c31 (active)
[    1.169205] pnp: PnP ACPI: found 12 devices
[    1.176324] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    1.176339] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    1.176342] pci 0000:00:1c.0:   bridge window [mem 0xe1000000-0xe10fffff]
[    1.176348] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    1.176349] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    1.176349] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    1.176350] pci_bus 0000:00: resource 7 [mem 0xc6800000-0xf7ffffff window]
[    1.176351] pci_bus 0000:00: resource 8 [mem 0xfd000000-0xfe7fffff window]
[    1.176352] pci_bus 0000:01: resource 1 [mem 0xe1000000-0xe10fffff]
[    1.176497] NET: Registered protocol family 2
[    1.176612] TCP established hash table entries: 65536 (order: 7, 524288 bytes)
[    1.176702] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    1.176854] TCP: Hash tables configured (established 65536 bind 65536)
[    1.176870] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    1.176889] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[    1.176941] NET: Registered protocol family 1
[    1.176955] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    1.177279] PCI: CLS 0 bytes, default 64
[    1.177309] Unpacking initramfs...
[    1.302251] Freeing initrd memory: 8688K
[    1.302305] DMAR: ACPI device "device:6f" under DMAR at fed91000 as 00:15.0
[    1.302307] DMAR: ACPI device "device:70" under DMAR at fed91000 as 00:15.1
[    1.302328] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    1.302330] software IO TLB [mem 0xa414f000-0xa814f000] (64MB) mapped at [ffff91306414f000-ffff91306814efff]
[    1.302350] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2879c5f06f2, max_idle_ns: 440795220049 ns
[    1.302681] audit: initializing netlink subsys (disabled)
[    1.302782] audit: type=2000 audit(1491325422.296:1): initialized
[    1.303062] Initialise system trusted keyrings
[    1.303174] workingset: timestamp_bits=40 max_order=21 bucket_order=0
[    1.303234] zbud: loaded
[    1.337299] Key type asymmetric registered
[    1.337300] Asymmetric key parser 'x509' registered
[    1.337325] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[    1.337371] io scheduler noop registered
[    1.337372] io scheduler deadline registered
[    1.337382] io scheduler cfq registered (default)
[    1.337727] pcieport 0000:00:1c.0: AER enabled with IRQ 274
[    1.337739] pcieport 0000:00:1c.0: Signaling PME with IRQ 274
[    1.337759] efifb: probing for efifb
[    1.337769] efifb: framebuffer at 0xd0000000, using 3072k, total 3072k
[    1.337770] efifb: mode is 1024x768x32, linelength=4096, pages=1
[    1.337770] efifb: scrolling: redraw
[    1.337771] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    1.339172] Console: switching to colour frame buffer device 128x48
[    1.340467] fb0: EFI VGA frame buffer device
[    1.340472] intel_idle: MWAIT substates: 0x11142120
[    1.340473] intel_idle: v0.4.1 model 0x4E
[    1.340680] intel_idle: lapic_timer_reliable_states 0xffffffff
[    1.341421] GHES: HEST is not enabled!
[    1.341473] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.341774] serial 0000:00:16.3: enabling device (0000 -> 0003)
[    1.362314] 0000:00:16.3: ttyS0 at I/O 0x3080 (irq = 19, base_baud = 115200) is a 16550A
[    1.362602] Linux agpgart interface v0.103
[    1.362629] AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
[    1.362629] AMD IOMMUv2 functionality not available on this system
[    1.363043] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    1.364607] i8042: Detected active multiplexing controller, rev 1.1
[    1.364987] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.364989] serio: i8042 AUX0 port at 0x60,0x64 irq 12
[    1.365009] serio: i8042 AUX1 port at 0x60,0x64 irq 12
[    1.365026] serio: i8042 AUX2 port at 0x60,0x64 irq 12
[    1.365041] serio: i8042 AUX3 port at 0x60,0x64 irq 12
[    1.365422] mousedev: PS/2 mouse device common for all mice
[    1.365470] rtc_cmos 00:03: RTC can wake from S4
[    1.365909] rtc_cmos 00:03: rtc core: registered rtc_cmos as rtc0
[    1.365992] rtc_cmos 00:03: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
[    1.365998] intel_pstate: Intel P-state driver initializing
[    1.366399] intel_pstate: HWP enabled
[    1.366620] ledtrig-cpu: registered to indicate activity on CPUs
[    1.366914] NET: Registered protocol family 10
[    1.367116] Segment Routing with IPv6
[    1.367125] mip6: Mobile IPv6
[    1.367126] NET: Registered protocol family 17
[    1.367127] mpls_gso: MPLS GSO support
[    1.367357] microcode: sig=0x406e3, pf=0x80, revision=0x9e
[    1.367400] microcode: Microcode Update Driver: v2.2.
[    1.367519] registered taskstats version 1
[    1.367520] Loading compiled-in X.509 certificates
[    1.367529] zswap: loaded using pool lzo/zbud
[    1.368647] rtc_cmos 00:03: setting system clock to 2017-04-04 17:03:42 UTC (1491325422)
[    1.368687] PM: Hibernation image not present or could not be loaded.
[    1.369346] Freeing unused kernel memory: 1408K
[    1.369347] Write protecting the kernel read-only data: 12288k
[    1.369701] Freeing unused kernel memory: 1932K
[    1.371680] Freeing unused kernel memory: 1412K
[    1.375735] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.389885] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[    1.400328] systemd-udevd[91]: starting version 215
[    1.400594] random: systemd-udevd: uninitialized urandom read (16 bytes read)
[    1.406098] button: module verification failed: signature and/or required key missing - tainting kernel
[    1.406327] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input5
[    1.406342] ACPI: Sleep Button [SLPB]
[    1.406465] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input6
[    1.406504] ACPI: Lid Switch [LID]
[    1.406550] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input7
[    1.406551] ACPI: Power Button [PWRF]
[    1.407290] FUJITSU Extended Socket Network Device Driver - version 1.2 - Copyright (c) 2015 FUJITSU LIMITED
[    1.417663] hidraw: raw HID events driver (C) Jiri Kosina
[    1.422297] ACPI: bus type USB registered
[    1.422299] [drm] Initialized
[    1.422317] usbcore: registered new interface driver usbfs
[    1.422326] usbcore: registered new interface driver hub
[    1.422369] usbcore: registered new device driver usb
[    1.422464] SCSI subsystem initialized
[    1.424320] libata version 3.00 loaded.
[    1.424510] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.424518] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    1.425643] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x00109810
[    1.425651] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
[    1.425758] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    1.425759] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.425761] usb usb1: Product: xHCI Host Controller
[    1.425762] usb usb1: Manufacturer: Linux 4.10.0+ xhci-hcd
[    1.425763] usb usb1: SerialNumber: 0000:00:14.0
[    1.425901] hub 1-0:1.0: USB hub found
[    1.425941] hub 1-0:1.0: 12 ports detected
[    1.429435] (NULL device *): hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
[    1.431070] thermal LNXTHERM:00: registered as thermal_zone0
[    1.431071] ACPI: Thermal Zone [CPUZ] (29 C)
[    1.434850] AVX2 version of gcm_enc/dec engaged.
[    1.434851] AES CTR mode by8 optimization enabled
[    1.437337] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.437340] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[    1.437373] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003
[    1.437374] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.437375] usb usb2: Product: xHCI Host Controller
[    1.437376] usb usb2: Manufacturer: Linux 4.10.0+ xhci-hcd
[    1.437376] usb usb2: SerialNumber: 0000:00:14.0
[    1.437503] hub 2-0:1.0: USB hub found
[    1.437514] hub 2-0:1.0: 6 ports detected
[    1.441608] usb: port power management may be unreliable
[    1.442732] ahci 0000:00:17.0: version 3.0
[    1.442933] ahci 0000:00:17.0: SSS flag set, parallel bus scan disabled
[    1.448160] thermal LNXTHERM:01: registered as thermal_zone1
[    1.448161] ACPI: Thermal Zone [GFXZ] (0 C)
[    1.453037] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 1 ports 6 Gbps 0x4 impl SATA mode
[    1.453039] ahci 0000:00:17.0: flags: 64bit ncq stag pm led clo only pio slum part deso sadm sds apst 
[    1.453603] scsi host0: ahci
[    1.453753] scsi host1: ahci
[    1.453877] scsi host2: ahci
[    1.453919] ata1: DUMMY
[    1.453919] ata2: DUMMY
[    1.453925] ata3: SATA max UDMA/133 abar m2048@0xe114f000 port 0xe114f200 irq 276
[    1.454451] [drm] Memory usable by graphics device = 4096M
[    1.454452] checking generic (d0000000 300000) vs hw (d0000000 10000000)
[    1.454453] fb: switching to inteldrmfb from EFI VGA
[    1.454468] Console: switching to colour dummy device 80x25
[    1.454527] [drm] Replacing VGA console driver
[    1.458900] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    1.458901] [drm] Driver supports precise vblank timestamp query.
[    1.461584] [drm] Finished loading i915/skl_dmc_ver1_26.bin (v1.26)
[    1.461961] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    1.469097] [drm] GuC firmware load skipped
[    1.477021] thermal LNXTHERM:02: registered as thermal_zone2
[    1.477022] ACPI: Thermal Zone [EXTZ] (0 C)
[    1.491128] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[    1.491406] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input11
[    1.491464] [drm] Initialized i915 1.6.0 20161121 for 0000:00:02.0 on minor 0
[    1.495443] thermal LNXTHERM:03: registered as thermal_zone3
[    1.495444] ACPI: Thermal Zone [LOCZ] (32 C)
[    1.514671] fbcon: inteldrmfb (fb0) is primary device
[    1.519220] thermal LNXTHERM:04: registered as thermal_zone4
[    1.519221] ACPI: Thermal Zone [BATZ] (27 C)
[    1.519549] thermal LNXTHERM:05: registered as thermal_zone5
[    1.519550] ACPI: Thermal Zone [PCHZ] (127 C)
[    1.765046] usb 1-1: new full-speed USB device number 2 using xhci_hcd
[    1.766893] ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.767587] ata3.00: ACPI cmd f5/00:00:00:00:00:e0 (SECURITY FREEZE LOCK) filtered out
[    1.767592] ata3.00: supports DRM functions and may not be fully accessible
[    1.769122] ata3.00: ATA-10: MTFDDAV256MBF-1AN15ABHA, M6T3, max UDMA/133
[    1.769126] ata3.00: 500118192 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    1.771187] ata3.00: ACPI cmd f5/00:00:00:00:00:e0 (SECURITY FREEZE LOCK) filtered out
[    1.771192] ata3.00: supports DRM functions and may not be fully accessible
[    1.773976] ata3.00: configured for UDMA/133
[    1.774580] scsi 2:0:0:0: Direct-Access     ATA      MTFDDAV256MBF-1A M6T3 PQ: 0 ANSI: 5
[    1.910002] usb 1-1: New USB device found, idVendor=04f2, idProduct=0976
[    1.910005] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    1.910008] usb 1-1: Product: Wireless Device
[    1.910010] usb 1-1: Manufacturer: Chicony
[    1.918153] usbcore: registered new interface driver usbhid
[    1.918155] usbhid: USB HID core driver
[    1.919743] input: Chicony Wireless Device as /devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.0/0003:04F2:0976.0001/input/input12
[    1.977435] hid-generic 0003:04F2:0976.0001: input,hidraw0: USB HID v1.11 Keyboard [Chicony Wireless Device] on usb-0000:00:14.0-1/input0
[    1.979959] input: Chicony Wireless Device as /devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.1/0003:04F2:0976.0002/input/input13
[    2.025157] random: fast init done
[    2.025179] usb 2-2: new SuperSpeed USB device number 2 using xhci_hcd
[    2.037553] hid-generic 0003:04F2:0976.0002: input,hiddev0,hidraw1: USB HID v1.11 Device [Chicony Wireless Device] on usb-0000:00:14.0-1/input1
[    2.037939] input: Chicony Wireless Device as /devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.2/0003:04F2:0976.0003/input/input14
[    2.038211] hid-generic 0003:04F2:0976.0003: input,hidraw2: USB HID v1.11 Mouse [Chicony Wireless Device] on usb-0000:00:14.0-1/input2
[    2.050570] usb 2-2: New USB device found, idVendor=1058, idProduct=10b8
[    2.050573] usb 2-2: New USB device strings: Mfr=1, Product=2, SerialNumber=5
[    2.050576] usb 2-2: Product: Elements 10B8
[    2.050578] usb 2-2: Manufacturer: Western Digital
[    2.050579] usb 2-2: SerialNumber: 575844314132354C45433633
[    2.054061] usb-storage 2-2:1.0: USB Mass Storage device detected
[    2.054359] scsi host3: usb-storage 2-2:1.0
[    2.054525] usbcore: registered new interface driver usb-storage
[    2.055239] usbcore: registered new interface driver uas
[    2.168861] usb 1-7: new full-speed USB device number 3 using xhci_hcd
[    2.305252] clocksource: Switched to clocksource tsc
[    2.310673] usb 1-7: New USB device found, idVendor=8087, idProduct=0a2b
[    2.310676] usb 1-7: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.452172] input: AlpsPS/2 ALPS GlidePoint as /devices/platform/i8042/serio3/input/input10
[    2.488939] usb 1-8: new full-speed USB device number 4 using xhci_hcd
[    2.608145] Console: switching to colour frame buffer device 240x67
[    2.630286] usb 1-8: New USB device found, idVendor=138a, idProduct=003f
[    2.630287] usb 1-8: New USB device strings: Mfr=0, Product=0, SerialNumber=1
[    2.630288] usb 1-8: SerialNumber: 00b068de109d
[    2.632008] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
[    2.647011] sd 2:0:0:0: [sda] 500118192 512-byte logical blocks: (256 GB/238 GiB)
[    2.647014] sd 2:0:0:0: [sda] 4096-byte physical blocks
[    2.647024] sd 2:0:0:0: [sda] Write Protect is off
[    2.647026] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.647036] sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.647459]  sda: sda1 sda2 sda3 sda4
[    2.647745] sd 2:0:0:0: [sda] Attached SCSI disk
[    2.648239] sd 2:0:0:0: Attached scsi generic sg0 type 0
[    2.752876] usb 1-9: new high-speed USB device number 5 using xhci_hcd
[    2.764167] device-mapper: uevent: version 1.0.3
[    2.764318] device-mapper: ioctl: 4.35.0-ioctl (2016-06-23) initialised: dm-devel@redhat.com
[    2.849369] [drm] RC6 on
[    2.936455] usb 1-9: New USB device found, idVendor=05c8, idProduct=0386
[    2.936459] usb 1-9: New USB device strings: Mfr=3, Product=1, SerialNumber=2
[    2.936462] usb 1-9: Product: HP HD Camera
[    2.936464] usb 1-9: Manufacturer: Generic
[    2.936466] usb 1-9: SerialNumber: 200901010001
[    3.074179] scsi 3:0:0:0: Direct-Access     WD       Elements 10B8    1012 PQ: 0 ANSI: 6
[    3.075558] sd 3:0:0:0: Attached scsi generic sg1 type 0
[    3.075681] sd 3:0:0:0: [sdb] 1953458176 512-byte logical blocks: (1.00 TB/931 GiB)
[    3.076002] sd 3:0:0:0: [sdb] Write Protect is off
[    3.076006] sd 3:0:0:0: [sdb] Mode Sense: 47 00 10 08
[    3.076318] sd 3:0:0:0: [sdb] No Caching mode page found
[    3.076451] sd 3:0:0:0: [sdb] Assuming drive cache: write through
[    3.180265]  sdb: sdb1 sdb2 sdb3
[    3.181732] sd 3:0:0:0: [sdb] Attached SCSI disk
[    6.273705] NET: Registered protocol family 38
[    6.623501] random: crng init done
[    7.460805] raid6: sse2x1   gen()  7004 MB/s
[    7.528800] raid6: sse2x1   xor()  9041 MB/s
[    7.596800] raid6: sse2x2   gen() 14667 MB/s
[    7.664802] raid6: sse2x2   xor() 10283 MB/s
[    7.732802] raid6: sse2x4   gen() 15438 MB/s
[    7.800800] raid6: sse2x4   xor() 10571 MB/s
[    7.868801] raid6: avx2x1   gen() 20217 MB/s
[    7.936800] raid6: avx2x1   xor() 14970 MB/s
[    8.004802] raid6: avx2x2   gen() 22742 MB/s
[    8.072801] raid6: avx2x2   xor() 16317 MB/s
[    8.140801] raid6: avx2x4   gen() 23775 MB/s
[    8.208799] raid6: avx2x4   xor() 18851 MB/s
[    8.208800] raid6: using algorithm avx2x4 gen() 23775 MB/s
[    8.208800] raid6: .... xor() 18851 MB/s, rmw enabled
[    8.208801] raid6: using avx2x2 recovery algorithm
[    8.209027] xor: automatically using best checksumming function   avx       
[    8.212614] Btrfs loaded, crc32c=crc32c-intel
[    8.783060] BTRFS: device label srv devid 1 transid 1634 /dev/mapper/vg0-srv
[    8.787178] PM: Starting manual resume from disk
[    8.787183] PM: Hibernation image partition 254:1 present
[    8.787185] PM: Looking for hibernation image.
[    8.797165] PM: Image not found (code -22)
[    8.797167] PM: Hibernation image not present or could not be loaded.
[    8.976541] EXT4-fs (dm-3): mounted filesystem with ordered data mode. Opts: (null)
[    9.566162] systemd[1]: systemd 215 running in system mode. (+PAM +AUDIT +SELINUX +IMA +SYSVINIT +LIBCRYPTSETUP +GCRYPT +ACL +XZ -SECCOMP -APPARMOR)
[    9.566501] systemd[1]: Detected architecture 'x86-64'.
[    9.810693] systemd[1]: Inserted module 'autofs4'
[    9.816521] systemd[1]: Set hostname to <thinkpad>.
[   10.972064] systemd[1]: Starting Forward Password Requests to Wall Directory Watch.
[   10.972251] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[   10.972279] systemd[1]: Starting Remote File Systems (Pre).
[   10.972388] systemd[1]: Reached target Remote File Systems (Pre).
[   10.972448] systemd[1]: Starting Arbitrary Executable File Formats File System Automount Point.
[   10.972970] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[   11.213764] lp: driver loaded but no devices found
[   11.351484] ppdev: user-space parallel port driver
[   11.457069] fuse init (API version 7.26)
[   11.821120] systemd-udevd[342]: starting version 215
[   12.838798] (NULL device *): hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
[   12.849703] intel-lpss 0000:00:15.0: enabling device (0000 -> 0002)
[   12.953753] idma64 idma64.0: Found Intel integrated DMA 64-bit
[   12.954465] intel-lpss 0000:00:15.1: enabling device (0000 -> 0002)
[   12.955157] idma64 idma64.1: Found Intel integrated DMA 64-bit
[   12.955432] i801_smbus 0000:00:1f.4: enabling device (0000 -> 0003)
[   12.955841] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[   12.963087] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   12.978256] snd_hda_intel 0000:00:1f.3: enabling device (0000 -> 0002)
[   12.978424] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops i915_audio_component_bind_ops [i915])
[   13.000866] tpm_tis 00:0b: 1.2 TPM (device-id 0x1B, rev-id 16)
[   13.084093] Bluetooth: Core ver 2.22
[   13.084102] NET: Registered protocol family 31
[   13.084103] Bluetooth: HCI device and connection manager initialized
[   13.084105] Bluetooth: HCI socket layer initialized
[   13.084106] Bluetooth: L2CAP socket layer initialized
[   13.084112] Bluetooth: SCO socket layer initialized
[   13.126950] snd_hda_codec_conexant hdaudioC0D0: CX20724: BIOS auto-probing.
[   13.127596] snd_hda_codec_conexant hdaudioC0D0: autoconfig for CX20724: line_outs=1 (0x17/0x0/0x0/0x0/0x0) type:speaker
[   13.127598] snd_hda_codec_conexant hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   13.127599] snd_hda_codec_conexant hdaudioC0D0:    hp_outs=1 (0x1d/0x0/0x0/0x0/0x0)
[   13.127600] snd_hda_codec_conexant hdaudioC0D0:    mono: mono_out=0x0
[   13.127601] snd_hda_codec_conexant hdaudioC0D0:    inputs:
[   13.127602] snd_hda_codec_conexant hdaudioC0D0:      Internal Mic=0x1a
[   13.127604] snd_hda_codec_conexant hdaudioC0D0:      Mic=0x19
[   13.128737] snd_hda_codec_conexant hdaudioC0D0: Enable sync_write for stable communication
[   13.146181] Initializing HPQ6001 module
[   13.146279] input: HP Wireless hotkeys as /devices/virtual/input/input19
[   13.181565] ACPI: AC Adapter [AC] (off-line)
[   13.213162] mei_me 0000:00:16.0: enabling device (0000 -> 0002)
[   13.240872] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1f.3/sound/card0/input16
[   13.241447] input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input17
[   13.241484] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1f.3/sound/card0/input18
[   13.241520] input: HDA Intel PCH HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input20
[   13.241555] input: HDA Intel PCH HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input21
[   13.241590] input: HDA Intel PCH HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input22
[   13.260012] wmi: Mapper loaded
[   13.260909] tpm tpm0: A TPM error (7) occurred attempting to read a pcr value
[   13.262273] tpm tpm0: TPM is disabled/deactivated (0x7)
[   13.262276] tpm tpm0: tpm_read_log_acpi: TCPA log area empty
[   13.262290] tpm_tis: probe of 00:0b failed with error -5
[   13.263240] tpm_inf_pnp 00:0b: Found TPM with ID IFX0102
[   13.296543] ACPI: Battery Slot [BAT0] (battery present)
[   13.313006] EFI Variables Facility v0.08 2004-May-17
[   13.435357] Intel(R) Wireless WiFi driver for Linux
[   13.435358] Copyright(c) 2003- 2015 Intel Corporation
[   13.435437] iwlwifi 0000:01:00.0: enabling device (0000 -> 0002)
[   13.460689] iwlwifi 0000:01:00.0: Direct firmware load for iwlwifi-8000C-26.ucode failed with error -2
[   13.460702] iwlwifi 0000:01:00.0: Direct firmware load for iwlwifi-8000C-25.ucode failed with error -2
[   13.461025] iwlwifi 0000:01:00.0: Direct firmware load for iwlwifi-8000C-24.ucode failed with error -2
[   13.461036] iwlwifi 0000:01:00.0: Direct firmware load for iwlwifi-8000C-23.ucode failed with error -2
[   13.555095] RAPL PMU: API unit is 2^-32 Joules, 5 fixed counters, 655360 ms ovfl timer
[   13.555096] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[   13.555096] RAPL PMU: hw unit of domain package 2^-14 Joules
[   13.555097] RAPL PMU: hw unit of domain dram 2^-14 Joules
[   13.555097] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[   13.555097] RAPL PMU: hw unit of domain psys 2^-14 Joules
[   13.567388] pstore: using zlib compression
[   13.567426] pstore: Registered efi as persistent store backend
[   13.596281] Bluetooth: HCI UART driver ver 2.3
[   13.596282] Bluetooth: HCI UART protocol H4 registered
[   13.596282] Bluetooth: HCI UART protocol BCSP registered
[   13.596283] Bluetooth: HCI UART protocol LL registered
[   13.596283] Bluetooth: HCI UART protocol ATH3K registered
[   13.596284] Bluetooth: HCI UART protocol Three-wire (H5) registered
[   13.596303] Bluetooth: HCI UART protocol Intel registered
[   13.596311] Bluetooth: HCI UART protocol Broadcom registered
[   13.596312] Bluetooth: HCI UART protocol QCA registered
[   13.596312] Bluetooth: HCI UART protocol AG6XX registered
[   13.596312] Bluetooth: HCI UART protocol Marvell registered
[   13.732765] iwlwifi 0000:01:00.0: loaded firmware version 22.361476.0 op_mode iwlmvm
[   13.781287] usbcore: registered new interface driver btusb
[   13.782314] Bluetooth: hci0: Bootloader revision 0.0 build 2 week 52 2014
[   13.788308] Bluetooth: hci0: Device revision is 5
[   13.788309] Bluetooth: hci0: Secure boot is enabled
[   13.788309] Bluetooth: hci0: OTP lock is enabled
[   13.788310] Bluetooth: hci0: API lock is enabled
[   13.788310] Bluetooth: hci0: Debug lock is disabled
[   13.788311] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[   13.812218] Bluetooth: hci0: Found device firmware: intel/ibt-11-5.sfi
[   13.860904] iTCO_vendor_support: vendor-support=0
[   13.874818] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[   13.874940] iTCO_wdt: unable to reset NO_REBOOT flag, device disabled by hardware/BIOS
[   14.355584] iwlwifi 0000:01:00.0: Detected Intel(R) Dual Band Wireless AC 8260, REV=0x208
[   14.356984] iwlwifi 0000:01:00.0: L1 Enabled - LTR Enabled
[   14.357711] iwlwifi 0000:01:00.0: L1 Enabled - LTR Enabled
[   14.732154] ieee80211 phy0: Selected rate control algorithm 'iwl-mvm-rs'
[   14.733147] (NULL device *): hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
[   14.733220] thermal thermal_zone7: failed to read out thermal zone (-5)
[   15.041731] ACPI Error: Needed [Buffer/String/Package], found [Integer] ffff9131eb314870 (20160930/exresop-594)
[   15.042569] ACPI Exception: AE_AML_OPERAND_TYPE, While resolving operands for [OpcodeName unavailable] (20160930/dswexec-461)
[   15.043413] ACPI Error: Method parse/execution failed [\_SB.WMIV.WVPO] (Node ffff9131eecb0348), AE_AML_OPERAND_TYPE (20160930/psparse-543)
[   15.044276] ACPI Error: Method parse/execution failed [\_SB.WMIV.WMPV] (Node ffff9131eecb07f8), AE_AML_OPERAND_TYPE (20160930/psparse-543)
[   15.045874] ACPI Error: Needed [Buffer/String/Package], found [Integer] ffff9131ed4c0678 (20160930/exresop-594)
[   15.046747] ACPI Exception: AE_AML_OPERAND_TYPE, While resolving operands for [OpcodeName unavailable] (20160930/dswexec-461)
[   15.047974] ACPI Error: Method parse/execution failed [\_SB.WMIV.WVPO] (Node ffff9131eecb0348), AE_AML_OPERAND_TYPE (20160930/psparse-543)
[   15.049127] ACPI Error: Method parse/execution failed [\_SB.WMIV.WMPV] (Node ffff9131eecb07f8), AE_AML_OPERAND_TYPE (20160930/psparse-543)
[   15.051364] ACPI Error: Needed [Buffer/String/Package], found [Integer] ffff9131eb314ea0 (20160930/exresop-594)
[   15.052699] ACPI Exception: AE_AML_OPERAND_TYPE, While resolving operands for [OpcodeName unavailable] (20160930/dswexec-461)
[   15.054019] ACPI Error: Method parse/execution failed [\_SB.WMIV.WVPO] (Node ffff9131eecb0348), AE_AML_OPERAND_TYPE (20160930/psparse-543)
[   15.055122] ACPI Error: Method parse/execution failed [\_SB.WMIV.WMPV] (Node ffff9131eecb07f8), AE_AML_OPERAND_TYPE (20160930/psparse-543)
[   15.056154] input: HP WMI hotkeys as /devices/virtual/input/input23
[   15.058882] ACPI Error: Attempt to CreateField of length zero (20160930/dsopcode-168)
[   15.059813] ACPI Error: Method parse/execution failed [\_SB.WMIV.WVPI] (Node ffff9131eecb01b8), AE_AML_OPERAND_VALUE (20160930/psparse-543)
[   15.060855] ACPI Error: Method parse/execution failed [\_SB.WMIV.WMPV] (Node ffff9131eecb07f8), AE_AML_OPERAND_VALUE (20160930/psparse-543)
[   15.195516] Bluetooth: hci0: Waiting for firmware download to complete
[   15.196286] Bluetooth: hci0: Firmware loaded in 1381825 usecs
[   15.196310] Bluetooth: hci0: Waiting for device to boot
[   15.207328] Bluetooth: hci0: Device booted in 10762 usecs
[   15.252984] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-11-5.ddc
[   15.253331] Bluetooth: hci0: Failed to send Intel_Write_DDC (-22)
[   15.343776] iwlwifi 0000:01:00.0 wlan1: renamed from wlan0
[   15.357189] systemd-udevd[372]: renamed network interface wlan0 to wlan1
[   15.369654] EXT4-fs (dm-3): re-mounted. Opts: discard,errors=remount-ro
[   15.459268] media: Linux media interface: v0.10
[   15.466603] intel_rapl: Found RAPL domain package
[   15.466609] intel_rapl: Found RAPL domain core
[   15.466614] intel_rapl: Found RAPL domain uncore
[   15.723849] Linux video capture interface: v2.00
[   16.079823] uvcvideo: Found UVC 1.00 device HP HD Camera (05c8:0386)
[   16.084796] uvcvideo 1-9:1.0: Entity type for entity Extension 4 was not initialized!
[   16.084834] uvcvideo 1-9:1.0: Entity type for entity Processing 2 was not initialized!
[   16.084843] uvcvideo 1-9:1.0: Entity type for entity Camera 1 was not initialized!
[   16.085105] input: HP HD Camera as /devices/pci0000:00/0000:00:14.0/usb1/1-9/1-9:1.0/input/input24
[   16.085321] usbcore: registered new interface driver uvcvideo
[   16.085322] USB Video Class driver (1.1.1)
[   17.612105] Adding 8388604k swap on /dev/mapper/vg0-swap.  Priority:-1 extents:1 across:8388604k FS
[   18.354760] BTRFS info (device dm-4): use zlib compression
[   18.354768] BTRFS info (device dm-4): disk space caching is enabled
[   19.029741] EXT4-fs (sdb1): mounted filesystem with ordered data mode. Opts: (null)
[   19.030112] EXT4-fs (dm-2): mounted filesystem with ordered data mode. Opts: (null)
[   19.893949] systemd-journald[339]: Received request to flush runtime journal from PID 1
[   29.044880] systemd[1]: Got automount request for /proc/sys/fs/binfmt_misc, triggered by 1466 (update-binfmts)
[   34.280891] systemd[1]: Received SIGRTMIN+21 from PID 191 (plymouthd).
[   34.652001] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   34.652005] Bluetooth: BNEP filters: protocol multicast
[   34.652016] Bluetooth: BNEP socket layer initialized
[   35.088242] ahci 0000:00:17.0: port does not support device sleep
[   35.287908] tun: Universal TUN/TAP device driver, 1.6
[   35.287910] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[   35.460185] EXT4-fs (sdb1): re-mounted. Opts: data=ordered,commit=600
[   35.484510] EXT4-fs (dm-2): re-mounted. Opts: data=ordered,commit=600
[   37.120930] iwlwifi 0000:01:00.0: L1 Enabled - LTR Enabled
[   37.121337] iwlwifi 0000:01:00.0: L1 Enabled - LTR Enabled
[   37.249317] iwlwifi 0000:01:00.0: L1 Enabled - LTR Enabled
[   37.249718] iwlwifi 0000:01:00.0: L1 Enabled - LTR Enabled
[   41.351313] wlan1: authenticate with 0c:51:01:e7:3b:53
[   41.361238] wlan1: send auth to 0c:51:01:e7:3b:53 (try 1/3)
[   41.366788] wlan1: authenticated
[   41.368951] wlan1: associate with 0c:51:01:e7:3b:53 (try 1/3)
[   41.370365] wlan1: RX AssocResp from 0c:51:01:e7:3b:53 (capab=0x1011 status=0 aid=17)
[   41.372098] wlan1: associated
[   41.427908] wlan1: Limiting TX power to 30 (30 - 0) dBm as advertised by 0c:51:01:e7:3b:53

--=-=-=--
