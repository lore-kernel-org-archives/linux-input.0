From: Pascal Wichmann <pascal.wichmann@pa-w.de>
Subject: Re: [4.12 regression] Thinkpad X250 Touchpad and Trackpoint not
 recognized anymore; commit e839ffa: "Input: synaptics - add support for
 Intertouch devices"
Date: Fri, 19 May 2017 22:35:59 +0200
Message-ID: <a345b319-5d8c-e9ac-a9ef-dd4fdd45047a@pa-w.de>
References: <41de7f92-8d98-3266-5d28-28ba48c5da38@pa-w.de>
 <C88AA3FF-8943-417D-AFC5-57CFFB3CA74E@gmail.com>
 <d9419ab0-8b77-7902-b048-c3eaab559c32@pa-w.de>
 <20170519202303.GA19281@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RjA92gf1Hr1LEJ5suHSGmspAI1djoxbuI"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170519202303.GA19281@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RjA92gf1Hr1LEJ5suHSGmspAI1djoxbuI
Content-Type: multipart/mixed; boundary="3uJBPrtTRFWmpoDNeaEglQ7FvJap5QTdm";
 protected-headers="v1"
From: Pascal Wichmann <pascal.wichmann@pa-w.de>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <a345b319-5d8c-e9ac-a9ef-dd4fdd45047a@pa-w.de>
Subject: Re: [4.12 regression] Thinkpad X250 Touchpad and Trackpoint not
 recognized anymore; commit e839ffa: "Input: synaptics - add support for
 Intertouch devices"
References: <41de7f92-8d98-3266-5d28-28ba48c5da38@pa-w.de>
 <C88AA3FF-8943-417D-AFC5-57CFFB3CA74E@gmail.com>
 <d9419ab0-8b77-7902-b048-c3eaab559c32@pa-w.de>
 <20170519202303.GA19281@dtor-ws>
In-Reply-To: <20170519202303.GA19281@dtor-ws>

--3uJBPrtTRFWmpoDNeaEglQ7FvJap5QTdm
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

> Hmm, what about rmi_core and rmi_smbus? It might be quicker if you send=

> your dmesg, .config and lsmod...

dmesg:

> [    0.000000] Linux version 4.12.0-rc1 (wichmannpas@ppropc01) (gcc
version 6.3.1 20170109 (GCC) ) #1 SMP PREEMPT Fri May 19 20:07:12 CEST 20=
17
> [    0.000000] Command line: BOOT_IMAGE=3D../vmlinuz-linux
cryptdevice=3DUUID=3D07f41359-3293-4c36-9fc9-b11b9944795b:lvm:allow-disca=
rds
root=3D/dev/mapper/pporpc01stor01-root rw initrd=3D../initramfs-linux.img=

> [    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating
point registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'=

> [    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'=

> [    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
> [    0.000000] x86/fpu: Enabled xstate features 0x7, context size is
832 bytes, using 'standard' format.
> [    0.000000] e820: BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009cfff]
usable
> [    0.000000] BIOS-e820: [mem 0x000000000009d000-0x000000000009ffff]
reserved
> [    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff]
reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000000fffffff]
usable
> [    0.000000] BIOS-e820: [mem 0x0000000010000000-0x000000001000afff]
reserved
> [    0.000000] BIOS-e820: [mem 0x000000001000b000-0x00000000bf068fff]
usable
> [    0.000000] BIOS-e820: [mem 0x00000000bf069000-0x00000000ccbfefff]
reserved
> [    0.000000] BIOS-e820: [mem 0x00000000ccbff000-0x00000000ccd7efff]
ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x00000000ccd7f000-0x00000000ccdfefff]
ACPI data
> [    0.000000] BIOS-e820: [mem 0x00000000ccdff000-0x00000000cfffffff]
reserved
> [    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff]
reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff]
reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fed08000-0x00000000fed08fff]
reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fed10000-0x00000000fed19fff]
reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff]
reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff]
reserved
> [    0.000000] BIOS-e820: [mem 0x00000000ffa00000-0x00000000ffffffff]
reserved
> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000022dffffff]
usable
> [    0.000000] tsc: Fast TSC calibration using PIT
> [    0.000000] NX (Execute Disable) protection: active
> [    0.000000] SMBIOS 2.7 present.
> [    0.000000] DMI: LENOVO 20CLS41500/20CLS41500, BIOS N10ET36W (1.15
) 06/19/2015
> [    0.000000] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D>
reserved
> [    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
> [    0.000000] e820: last_pfn =3D 0x22e000 max_arch_pfn =3D 0x400000000=

> [    0.000000] MTRR default type: write-back
> [    0.000000] MTRR fixed ranges enabled:
> [    0.000000]   00000-9FFFF write-back
> [    0.000000]   A0000-BFFFF uncachable
> [    0.000000]   C0000-FFFFF write-protect
> [    0.000000] MTRR variable ranges enabled:
> [    0.000000]   0 base 00E0000000 mask 7FF0000000 uncachable
> [    0.000000]   1 base 00D0000000 mask 7FF0000000 uncachable
> [    0.000000]   2 base 00CE000000 mask 7FFE000000 uncachable
> [    0.000000]   3 base 00CD000000 mask 7FFF000000 uncachable
> [    0.000000]   4 base 00CCE00000 mask 7FFFE00000 uncachable
> [    0.000000]   5 base 00F0000000 mask 7FF0000000 uncachable
> [    0.000000]   6 disabled
> [    0.000000]   7 disabled
> [    0.000000]   8 disabled
> [    0.000000]   9 disabled
> [    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WC
UC- WT
> [    0.000000] e820: last_pfn =3D 0xbf069 max_arch_pfn =3D 0x400000000
> [    0.000000] found SMP MP-table at [mem 0x000f0100-0x000f010f]
mapped at [ffff8800000f0100]
> [    0.000000] Scanning 1 areas for low memory corruption
> [    0.000000] Base memory trampoline at [ffff880000097000] 97000 size
24576
> [    0.000000] Using GB pages for direct mapping
> [    0.000000] BRK [0x020fd000, 0x020fdfff] PGTABLE
> [    0.000000] BRK [0x020fe000, 0x020fefff] PGTABLE
> [    0.000000] BRK [0x020ff000, 0x020fffff] PGTABLE
> [    0.000000] BRK [0x02100000, 0x02100fff] PGTABLE
> [    0.000000] BRK [0x02101000, 0x02101fff] PGTABLE
> [    0.000000] BRK [0x02102000, 0x02102fff] PGTABLE
> [    0.000000] RAMDISK: [mem 0x7f25c000-0x7fffffff]
> [    0.000000] ACPI: Early table checksum verification disabled
> [    0.000000] ACPI: RSDP 0x00000000000F0120 000024 (v02 LENOVO)
> [    0.000000] ACPI: XSDT 0x00000000CCDFE1C0 0000E4 (v01 LENOVO TP-N10
  00001150 PTEC 00000002)
> [    0.000000] ACPI: FACP 0x00000000CCDF9000 00010C (v05 LENOVO TP-N10
  00001150 PTEC 00000002)
> [    0.000000] ACPI: DSDT 0x00000000CCDE4000 010E04 (v01 LENOVO TP-N10
  00001150 INTL 20120711)
> [    0.000000] ACPI: FACS 0x00000000CCD68000 000040
> [    0.000000] ACPI: ASF! 0x00000000CCDFD000 0000A5 (v32 LENOVO TP-N10
  00001150 PTEC 00000002)
> [    0.000000] ACPI: HPET 0x00000000CCDFC000 000038 (v01 LENOVO TP-N10
  00001150 PTEC 00000002)
> [    0.000000] ACPI: ECDT 0x00000000CCDFB000 000052 (v01 LENOVO TP-N10
  00001150 PTEC 00000002)
> [    0.000000] ACPI: APIC 0x00000000CCDF8000 000098 (v01 LENOVO TP-N10
  00001150 PTEC 00000002)
> [    0.000000] ACPI: MCFG 0x00000000CCDF7000 00003C (v01 LENOVO TP-N10
  00001150 PTEC 00000002)
> [    0.000000] ACPI: SSDT 0x00000000CCDF6000 000033 (v01 LENOVO
TP-SSDT1 00000100 INTL 20120711)
> [    0.000000] ACPI: SSDT 0x00000000CCDF5000 000486 (v01 LENOVO
TP-SSDT2 00000200 INTL 20120711)
> [    0.000000] ACPI: SSDT 0x00000000CCDE3000 0009CB (v01 LENOVO
SataAhci 00001000 INTL 20120711)
> [    0.000000] ACPI: SSDT 0x00000000CCDE2000 000152 (v01 LENOVO
Rmv_Batt 00001000 INTL 20120711)
> [    0.000000] ACPI: SSDT 0x00000000CCDE1000 000691 (v01 LENOVO
Cpu0Ist  00003000 INTL 20120711)
> [    0.000000] ACPI: SSDT 0x00000000CCDE0000 000B74 (v02 LENOVO
CpuSsdt  00003000 INTL 20120711)
> [    0.000000] ACPI: SSDT 0x00000000CCDDF000 000369 (v02 LENOVO CtdpB
  00001000 INTL 20120711)
> [    0.000000] ACPI: SSDT 0x00000000CCDDD000 001475 (v01 LENOVO SaSsdt
  00003000 INTL 20120711)
> [    0.000000] ACPI: SSDT 0x00000000CCDDC000 000394 (v02 LENOVO
CppcTabl 00001000 INTL 20120711)
> [    0.000000] ACPI: PCCT 0x00000000CCDDB000 00006E (v05 LENOVO TP-N10
  00001150 PTEC 00000002)
> [    0.000000] ACPI: SSDT 0x00000000CCDDA000 000AC4 (v02 LENOVO
Cpc_Tabl 00001000 INTL 20120711)
> [    0.000000] ACPI: TCPA 0x00000000CCDD9000 000032 (v02 PTL    LENOVO
  06040000 LNVO 00000001)
> [    0.000000] ACPI: SSDT 0x00000000CCDD8000 0006A3 (v01 Intel_
TpmTable 00001000 INTL 20120711)
> [    0.000000] ACPI: UEFI 0x00000000CCDD7000 000042 (v01 LENOVO TP-N10
  00001150 PTEC 00000002)
> [    0.000000] ACPI: POAT 0x00000000CCCB1000 000055 (v03 LENOVO TP-N10
  00001150 PTEC 00000002)
> [    0.000000] ACPI: BATB 0x00000000CCDD6000 000046 (v01 LENOVO TP-N10
  00001150 PTEC 00000002)
> [    0.000000] ACPI: FPDT 0x00000000CCDD5000 000064 (v01 LENOVO TP-N10
  00001150 PTEC 00000002)
> [    0.000000] ACPI: UEFI 0x00000000CCDD4000 0002F6 (v01 LENOVO TP-N10
  00001150 PTEC 00000002)
> [    0.000000] ACPI: Local APIC address 0xfee00000
> [    0.000000] No NUMA configuration found
> [    0.000000] Faking a node at [mem
0x0000000000000000-0x000000022dffffff]
> [    0.000000] NODE_DATA(0) allocated [mem 0x22dffa000-0x22dffefff]
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> [    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
> [    0.000000]   Normal   [mem 0x0000000100000000-0x000000022dffffff]
> [    0.000000]   Device   empty
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009cfff]
> [    0.000000]   node   0: [mem 0x0000000000100000-0x000000000fffffff]
> [    0.000000]   node   0: [mem 0x000000001000b000-0x00000000bf068fff]
> [    0.000000]   node   0: [mem 0x0000000100000000-0x000000022dffffff]
> [    0.000000] Initmem setup node 0 [mem
0x0000000000001000-0x000000022dffffff]
> [    0.000000] On node 0 totalpages: 2019322
> [    0.000000]   DMA zone: 64 pages used for memmap
> [    0.000000]   DMA zone: 21 pages reserved
> [    0.000000]   DMA zone: 3996 pages, LIFO batch:0
> [    0.000000]   DMA32 zone: 12162 pages used for memmap
> [    0.000000]   DMA32 zone: 778334 pages, LIFO batch:31
> [    0.000000]   Normal zone: 19328 pages used for memmap
> [    0.000000]   Normal zone: 1236992 pages, LIFO batch:31
> [    0.000000] Reserving Intel graphics memory at
0x00000000ce000000-0x00000000cfffffff
> [    0.000000] ACPI: PM-Timer IO Port: 0x1808
> [    0.000000] ACPI: Local APIC address 0xfee00000
> [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
> [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
> [    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000,
GSI 0-39
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)=

> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high lev=
el)
> [    0.000000] ACPI: IRQ0 used by override.
> [    0.000000] ACPI: IRQ9 used by override.
> [    0.000000] Using ACPI (MADT) for SMP configuration information
> [    0.000000] ACPI: HPET id: 0x8086a301 base: 0xfed00000
> [    0.000000] smpboot: Allowing 8 CPUs, 4 hotplug CPUs
> [    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff=
]
> [    0.000000] PM: Registered nosave memory: [mem 0x0009d000-0x0009ffff=
]
> [    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000dffff=
]
> [    0.000000] PM: Registered nosave memory: [mem 0x000e0000-0x000fffff=
]
> [    0.000000] PM: Registered nosave memory: [mem 0x10000000-0x1000afff=
]
> [    0.000000] PM: Registered nosave memory: [mem 0xbf069000-0xccbfefff=
]
> [    0.000000] PM: Registered nosave memory: [mem 0xccbff000-0xccd7efff=
]
> [    0.000000] PM: Registered nosave memory: [mem 0xccd7f000-0xccdfefff=
]
> [    0.000000] PM: Registered nosave memory: [mem 0xccdff000-0xcfffffff=
]
> [    0.000000] PM: Registered nosave memory: [mem 0xd0000000-0xf7ffffff=
]
> [    0.000000] PM: Registered nosave memory: [mem 0xf8000000-0xfbffffff=
]
> [    0.000000] PM: Registered nosave memory: [mem 0xfc000000-0xfebfffff=
]
> [    0.000000] PM: Registered nosave memory: [mem 0xfec00000-0xfec00fff=
]
> [    0.000000] PM: Registered nosave memory: [mem 0xfec01000-0xfed07fff=
]
> [    0.000000] PM: Registered nosave memory: [mem 0xfed08000-0xfed08fff=
]
> [    0.000000] PM: Registered nosave memory: [mem 0xfed09000-0xfed0ffff=
]
> [    0.000000] PM: Registered nosave memory: [mem 0xfed10000-0xfed19fff=
]
> [    0.000000] PM: Registered nosave memory: [mem 0xfed1a000-0xfed1bfff=
]
> [    0.000000] PM: Registered nosave memory: [mem 0xfed1c000-0xfed1ffff=
]
> [    0.000000] PM: Registered nosave memory: [mem 0xfed20000-0xfedfffff=
]
> [    0.000000] PM: Registered nosave memory: [mem 0xfee00000-0xfee00fff=
]
> [    0.000000] PM: Registered nosave memory: [mem 0xfee01000-0xff9fffff=
]
> [    0.000000] PM: Registered nosave memory: [mem 0xffa00000-0xffffffff=
]
> [    0.000000] e820: [mem 0xd0000000-0xf7ffffff] available for PCI devi=
ces
> [    0.000000] Booting paravirtualized kernel on bare hardware
> [    0.000000] clocksource: refined-jiffies: mask: 0xffffffff
max_cycles: 0xffffffff, max_idle_ns: 6370452778343963 ns
> [    0.000000] setup_percpu: NR_CPUS:128 nr_cpumask_bits:128
nr_cpu_ids:8 nr_node_ids:1
> [    0.000000] percpu: Embedded 37 pages/cpu @ffff88022dc00000 s113816
r8192 d29544 u262144
> [    0.000000] pcpu-alloc: s113816 r8192 d29544 u262144 alloc=3D1*20971=
52
> [    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 6 7
> [    0.000000] Built 1 zonelists in Node order, mobility grouping on.
Total pages: 1987747
> [    0.000000] Policy zone: Normal
> [    0.000000] Kernel command line: BOOT_IMAGE=3D../vmlinuz-linux
cryptdevice=3DUUID=3D07f41359-3293-4c36-9fc9-b11b9944795b:lvm:allow-disca=
rds
root=3D/dev/mapper/pporpc01stor01-root rw initrd=3D../initramfs-linux.img=

> [    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
> [    0.000000] Calgary: detecting Calgary via BIOS EBDA area
> [    0.000000] Calgary: Unable to locate Rio Grande table in EBDA -
bailing!
> [    0.000000] Memory: 7851616K/8077288K available (8099K kernel code,
1172K rwdata, 2636K rodata, 1392K init, 2452K bss, 225672K reserved, 0K
cma-reserved)
> [    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D=
8, Nodes=3D1
> [    0.000000] ftrace: allocating 32135 entries in 126 pages
> [    0.000000] Preemptible hierarchical RCU implementation.
> [    0.000000] 	RCU restricting CPUs from NR_CPUS=3D128 to nr_cpu_ids=3D=
8.
> [    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=3D16,
nr_cpu_ids=3D8
> [    0.000000] NR_IRQS:8448 nr_irqs:760 16
> [    0.000000] Console: colour VGA+ 80x25
> [    0.000000] console [tty0] enabled
> [    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 133484882848 ns
> [    0.000000] hpet clockevent registered
> [    0.000000] tsc: Fast TSC calibration using PIT
> [    0.003333] tsc: Detected 2594.090 MHz processor
> [    0.003333] Calibrating delay loop (skipped), value calculated
using timer frequency.. 5190.35 BogoMIPS (lpj=3D8646966)
> [    0.003333] pid_max: default: 32768 minimum: 301
> [    0.003333] ACPI: Core revision 20170303
> [    0.048426] ACPI: 12 ACPI AML tables successfully acquired and loade=
d
> [    0.048612] Security Framework initialized
> [    0.048727] Yama: becoming mindful.
> [    0.049890] Dentry cache hash table entries: 1048576 (order: 11,
8388608 bytes)
> [    0.054217] Inode-cache hash table entries: 524288 (order: 10,
4194304 bytes)
> [    0.056147] Mount-cache hash table entries: 16384 (order: 5, 131072
bytes)
> [    0.056288] Mountpoint-cache hash table entries: 16384 (order: 5,
131072 bytes)
> [    0.056996] CPU: Physical Processor ID: 0
> [    0.057110] CPU: Processor Core ID: 0
> [    0.057229] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
> [    0.057348] ENERGY_PERF_BIAS: View and update with
x86_energy_perf_policy(8)
> [    0.057479] mce: CPU supports 7 MCE banks
> [    0.057614] CPU0: Thermal monitoring enabled (TM1)
> [    0.057757] process: using mwait in idle threads
> [    0.057876] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
> [    0.059168] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
> [    0.059561] Freeing SMP alternatives memory: 24K
> [    0.061997] smpboot: Max logical packages: 4
> [    0.062254] x2apic: IRQ remapping doesn't support X2APIC mode
> [    0.063101] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin=
2=3D-1
> [    0.096243] TSC deadline timer enabled
> [    0.096247] smpboot: CPU0: Intel(R) Core(TM) i7-5600U CPU @ 2.60GHz
(family: 0x6, model: 0x3d, stepping: 0x4)
> [    0.106683] Performance Events: PEBS fmt2+, Broadwell events,
16-deep LBR, full-width counters, Intel PMU driver.
> [    0.106922] ... version:                3
> [    0.107034] ... bit width:              48
> [    0.107146] ... generic registers:      4
> [    0.107258] ... value mask:             0000ffffffffffff
> [    0.107375] ... max period:             00007fffffffffff
> [    0.107491] ... fixed-purpose events:   3
> [    0.107603] ... event mask:             000000070000000f
> [    0.127045] NMI watchdog: enabled on all CPUs, permanently consumes
one hw-PMU counter.
> [    0.133351] smp: Bringing up secondary CPUs ...
> [    0.160040] x86: Booting SMP configuration:
> [    0.160156] .... node  #0, CPUs:      #1 #2 #3
> [    0.463422] smp: Brought up 1 node, 4 CPUs
> [    0.463571] smpboot: Total of 4 processors activated (20778.21
BogoMIPS)
> [    0.466918] sched_clock: Marking stable (466666620, 0)->(472533044,
-5866424)
> [    0.467623] devtmpfs: initialized
> [    0.467841] x86/mm: Memory block size: 128MB
> [    0.476679] PM: Registering ACPI NVS region [mem
0xccbff000-0xccd7efff] (1572864 bytes)
> [    0.477037] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 6370867519511994 ns
> [    0.477246] futex hash table entries: 2048 (order: 5, 131072 bytes)
> [    0.477501] pinctrl core: initialized pinctrl subsystem
> [    0.477690] RTC time: 20:30:16, date: 05/19/17
> [    0.478000] NET: Registered protocol family 16
> [    0.478544] cpuidle: using governor ladder
> [    0.478743] cpuidle: using governor menu
> [    0.478875] Error parsing PCC subspaces from PCCT
> [    0.479073] ACPI FADT declares the system doesn't support PCIe
ASPM, so disable it
> [    0.479251] ACPI: bus type PCI registered
> [    0.479365] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.=
5
> [    0.479778] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem
0xf8000000-0xfbffffff] (base 0xf8000000)
> [    0.479982] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved
in E820
> [    0.480115] PCI: Using configuration type 1 for base access
> [    0.506230] HugeTLB registered 1 GB page size, pre-allocated 0 pages=

> [    0.506353] HugeTLB registered 2 MB page size, pre-allocated 0 pages=

> [    0.507027] ACPI: Added _OSI(Module Device)
> [    0.507145] ACPI: Added _OSI(Processor Device)
> [    0.507260] ACPI: Added _OSI(3.0 _SCP Extensions)
> [    0.507375] ACPI: Added _OSI(Processor Aggregator Device)
> [    0.507503] ACPI : EC: EC started
> [    0.507614] ACPI : EC: interrupt blocked
> [    0.510372] ACPI: \: Used as first EC
> [    0.510486] ACPI: \: GPE=3D0x25, EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62=

> [    0.510607] ACPI: \: Used as boot ECDT EC to handle transactions
> [    0.519729] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
> [    0.531844] ACPI Error: Needed type [Reference], found [Integer]
ffff88022421db88 (20170303/exresop-103)
> [    0.532041] ACPI Exception: AE_AML_OPERAND_TYPE, While resolving
operands for [OpcodeName unavailable] (20170303/dswexec-461)
> [    0.532238] ACPI Error: Method parse/execution failed
[\_PR.CPU0._PDC] (Node ffff880225575230), AE_AML_OPERAND_TYPE
(20170303/psparse-543)
> [    0.533136] ACPI: Dynamic OEM Table Load:
> [    0.533271] ACPI: SSDT 0xFFFF880224150800 0005AA (v01 PmRef  ApIst
  00003000 INTL 20120711)
> [    0.534546] ACPI: Dynamic OEM Table Load:
> [    0.534677] ACPI: SSDT 0xFFFF880224160400 000119 (v02 PmRef  ApCst
  00003000 INTL 20120711)
> [    0.537192] ACPI : EC: EC stopped
> [    0.537313] ACPI : EC: EC started
> [    0.537424] ACPI : EC: interrupt blocked
> [    0.537946] ACPI: \_SB_.PCI0.LPC_.EC__: Used as first EC
> [    0.538066] ACPI: \_SB_.PCI0.LPC_.EC__: GPE=3D0x25,
EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
> [    0.538246] ACPI: \_SB_.PCI0.LPC_.EC__: Used as boot DSDT EC to
handle transactions
> [    0.538424] ACPI: Interpreter enabled
> [    0.538622] ACPI: (supports S0 S3 S4 S5)
> [    0.538734] ACPI: Using IOAPIC for interrupt routing
> [    0.538916] PCI: Using host bridge windows from ACPI; if necessary,
use "pci=3Dnocrs" and report a bug
> [    0.545594] ACPI: Power Resource [PUBS] (on)
> [    0.546933] acpi PNP0C0A:01: ACPI dock station (docks/bays count: 1)=

> [    0.547825] ACPI: Power Resource [NVP3] (on)
> [    0.548002] ACPI: Power Resource [NVP2] (on)
> [    0.557294] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11=
)
> [    0.557602] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *9 10 11=
)
> [    0.557891] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 *10 11=
)
> [    0.558177] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 *6 7 9 10 11=
)
> [    0.558462] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11=
)
> [    0.558712] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10
11) *0, disabled.
> [    0.559057] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 *10 11=
)
> [    0.559341] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 *7 9 10 11=
)
> [    0.559693] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3f])
> [    0.559822] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM
ClockPM Segments MSI]
> [    0.560266] acpi PNP0A08:00: _OSC: platform does not support
[PCIeCapability]
> [    0.560501] acpi PNP0A08:00: _OSC: not requesting control; platform
does not support [PCIeCapability]
> [    0.560687] acpi PNP0A08:00: _OSC: OS requested [PCIeHotplug PME
AER PCIeCapability]
> [    0.560873] acpi PNP0A08:00: _OSC: platform willing to grant
[PCIeHotplug PME AER]
> [    0.561053] acpi PNP0A08:00: _OSC failed (AE_SUPPORT); disabling ASP=
M
> [    0.561571] PCI host bridge to bus 0000:00
> [    0.561689] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7
window]
> [    0.561814] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff
window]
> [    0.561937] pci_bus 0000:00: root bus resource [mem
0x000a0000-0x000bffff window]
> [    0.562116] pci_bus 0000:00: root bus resource [mem
0xd0000000-0xfebfffff window]
> [    0.562295] pci_bus 0000:00: root bus resource [mem
0xfed40000-0xfed4bfff window]
> [    0.562475] pci_bus 0000:00: root bus resource [bus 00-3f]
> [    0.562608] pci 0000:00:00.0: [8086:1604] type 00 class 0x060000
> [    0.562800] pci 0000:00:02.0: [8086:1616] type 00 class 0x030000
> [    0.562825] pci 0000:00:02.0: reg 0x10: [mem 0xf0000000-0xf0ffffff
64bit]
> [    0.562841] pci 0000:00:02.0: reg 0x18: [mem 0xe0000000-0xefffffff
64bit pref]
> [    0.562852] pci 0000:00:02.0: reg 0x20: [io  0x3000-0x303f]
> [    0.563038] pci 0000:00:03.0: [8086:160c] type 00 class 0x040300
> [    0.563058] pci 0000:00:03.0: reg 0x10: [mem 0xf1230000-0xf1233fff
64bit]
> [    0.563281] pci 0000:00:14.0: [8086:9cb1] type 00 class 0x0c0330
> [    0.563309] pci 0000:00:14.0: reg 0x10: [mem 0xf1220000-0xf122ffff
64bit]
> [    0.563409] pci 0000:00:14.0: PME# supported from D3hot D3cold
> [    0.563484] pci 0000:00:14.0: System wakeup disabled by ACPI
> [    0.563674] pci 0000:00:16.0: [8086:9cba] type 00 class 0x078000
> [    0.563704] pci 0000:00:16.0: reg 0x10: [mem 0xf1239000-0xf123901f
64bit]
> [    0.563815] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
> [    0.563953] pci 0000:00:19.0: [8086:15a2] type 00 class 0x020000
> [    0.563977] pci 0000:00:19.0: reg 0x10: [mem 0xf1200000-0xf121ffff]
> [    0.563990] pci 0000:00:19.0: reg 0x14: [mem 0xf123e000-0xf123efff]
> [    0.564003] pci 0000:00:19.0: reg 0x18: [io  0x3080-0x309f]
> [    0.564097] pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
> [    0.564168] pci 0000:00:19.0: System wakeup disabled by ACPI
> [    0.564363] pci 0000:00:1b.0: [8086:9ca0] type 00 class 0x040300
> [    0.564391] pci 0000:00:1b.0: reg 0x10: [mem 0xf1234000-0xf1237fff
64bit]
> [    0.564490] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
> [    0.564620] pci 0000:00:1c.0: [8086:9c9a] type 01 class 0x060400
> [    0.564732] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
> [    0.564971] pci 0000:00:1c.1: [8086:9c94] type 01 class 0x060400
> [    0.565090] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
> [    0.565245] pci 0000:00:1c.1: System wakeup disabled by ACPI
> [    0.565447] pci 0000:00:1d.0: [8086:9ca6] type 00 class 0x0c0320
> [    0.565474] pci 0000:00:1d.0: reg 0x10: [mem 0xf123d000-0xf123d3ff]
> [    0.565607] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
> [    0.565682] pci 0000:00:1d.0: System wakeup disabled by ACPI
> [    0.565868] pci 0000:00:1f.0: [8086:9cc3] type 00 class 0x060100
> [    0.566145] pci 0000:00:1f.2: [8086:9c83] type 00 class 0x010601
> [    0.566168] pci 0000:00:1f.2: reg 0x10: [io  0x30a8-0x30af]
> [    0.566181] pci 0000:00:1f.2: reg 0x14: [io  0x30bc-0x30bf]
> [    0.566193] pci 0000:00:1f.2: reg 0x18: [io  0x30a0-0x30a7]
> [    0.566205] pci 0000:00:1f.2: reg 0x1c: [io  0x30b8-0x30bb]
> [    0.566218] pci 0000:00:1f.2: reg 0x20: [io  0x3060-0x307f]
> [    0.566230] pci 0000:00:1f.2: reg 0x24: [mem 0xf123c000-0xf123c7ff]
> [    0.566292] pci 0000:00:1f.2: PME# supported from D3hot
> [    0.566417] pci 0000:00:1f.3: [8086:9ca2] type 00 class 0x0c0500
> [    0.566441] pci 0000:00:1f.3: reg 0x10: [mem 0xf1238000-0xf12380ff
64bit]
> [    0.566474] pci 0000:00:1f.3: reg 0x20: [io  0xefa0-0xefbf]
> [    0.566638] pci 0000:00:1f.6: [8086:9ca4] type 00 class 0x118000
> [    0.566677] pci 0000:00:1f.6: reg 0x10: [mem 0xf123b000-0xf123bfff
64bit]
> [    0.567048] pci 0000:02:00.0: [10ec:5227] type 00 class 0xff0000
> [    0.567127] pci 0000:02:00.0: reg 0x10: [mem 0xf1100000-0xf1100fff]
> [    0.567625] pci 0000:02:00.0: supports D1 D2
> [    0.567635] pci 0000:02:00.0: PME# supported from D1 D2 D3hot D3cold=

> [    0.577731] pci 0000:00:1c.0: PCI bridge to [bus 02]
> [    0.577856] pci 0000:00:1c.0:   bridge window [mem
0xf1100000-0xf11fffff]
> [    0.578196] pci 0000:03:00.0: [8086:095b] type 00 class 0x028000
> [    0.578445] pci 0000:03:00.0: reg 0x10: [mem 0xf1000000-0xf1001fff
64bit]
> [    0.579254] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
> [    0.587964] pci 0000:00:1c.1: PCI bridge to [bus 03]
> [    0.588088] pci 0000:00:1c.1:   bridge window [mem
0xf1000000-0xf10fffff]
> [    0.590330] ACPI: Enabled 4 GPEs in block 00 to 7F
> [    0.590634] ACPI : EC: interrupt unblocked
> [    0.590757] ACPI : EC: event unblocked
> [    0.590879] ACPI: \_SB_.PCI0.LPC_.EC__: GPE=3D0x25,
EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
> [    0.591070] ACPI: \_SB_.PCI0.LPC_.EC__: Used as boot DSDT EC to
handle transactions and events
> [    0.591436] pci 0000:00:02.0: vgaarb: setting as boot VGA device
> [    0.591559] pci 0000:00:02.0: vgaarb: VGA device added:
decodes=3Dio+mem,owns=3Dio+mem,locks=3Dnone
> [    0.591746] pci 0000:00:02.0: vgaarb: bridge control possible
> [    0.591864] vgaarb: loaded
> [    0.592054] EDAC MC: Ver: 3.0.0
> [    0.592531] PCI: Using ACPI for IRQ routing
> [    0.594863] PCI: pci_cache_line_size set to 64 bytes
> [    0.595214] e820: reserve RAM buffer [mem 0x0009d000-0x0009ffff]
> [    0.595218] e820: reserve RAM buffer [mem 0xbf069000-0xbfffffff]
> [    0.595220] e820: reserve RAM buffer [mem 0x22e000000-0x22fffffff]
> [    0.595409] NetLabel: Initializing
> [    0.595521] NetLabel:  domain hash size =3D 128
> [    0.595634] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
> [    0.595785] NetLabel:  unlabeled traffic allowed by default
> [    0.596066] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
> [    0.596198] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
> [    0.598359] clocksource: Switched to clocksource hpet
> [    0.617931] VFS: Disk quotas dquot_6.6.0
> [    0.618085] VFS: Dquot-cache hash table entries: 512 (order 0, 4096
bytes)
> [    0.618386] pnp: PnP ACPI init
> [    0.619411] system 00:00: [mem 0x00000000-0x0009ffff] could not be
reserved
> [    0.619538] system 00:00: [mem 0x000c0000-0x000c3fff] could not be
reserved
> [    0.619662] system 00:00: [mem 0x000c4000-0x000c7fff] could not be
reserved
> [    0.619786] system 00:00: [mem 0x000c8000-0x000cbfff] could not be
reserved
> [    0.619910] system 00:00: [mem 0x000cc000-0x000cffff] could not be
reserved
> [    0.620035] system 00:00: [mem 0x000d0000-0x000d3fff] has been reser=
ved
> [    0.620157] system 00:00: [mem 0x000d4000-0x000d7fff] has been reser=
ved
> [    0.620280] system 00:00: [mem 0x000d8000-0x000dbfff] has been reser=
ved
> [    0.620403] system 00:00: [mem 0x000dc000-0x000dffff] has been reser=
ved
> [    0.620527] system 00:00: [mem 0x000e0000-0x000e3fff] could not be
reserved
> [    0.620652] system 00:00: [mem 0x000e4000-0x000e7fff] could not be
reserved
> [    0.620777] system 00:00: [mem 0x000e8000-0x000ebfff] could not be
reserved
> [    0.620902] system 00:00: [mem 0x000ec000-0x000effff] could not be
reserved
> [    0.621027] system 00:00: [mem 0x000f0000-0x000fffff] could not be
reserved
> [    0.621152] system 00:00: [mem 0x00100000-0xcfffffff] could not be
reserved
> [    0.621277] system 00:00: [mem 0xfec00000-0xfed3ffff] could not be
reserved
> [    0.621402] system 00:00: [mem 0xfed4c000-0xffffffff] could not be
reserved
> [    0.621532] system 00:00: Plug and Play ACPI device, IDs PNP0c01
(active)
> [    0.621757] pnp 00:01: [Firmware Bug]: PNP resource [mem
0xfed10000-0xfed13fff] covers only part of 0000:00:00.0 Intel MCH;
extending to [mem 0xfed10000-0xfed17fff]
> [    0.622057] system 00:01: [io  0x1800-0x189f] has been reserved
> [    0.622179] system 00:01: [io  0x0800-0x087f] has been reserved
> [    0.622300] system 00:01: [io  0x0880-0x08ff] has been reserved
> [    0.622421] system 00:01: [io  0x0900-0x097f] has been reserved
> [    0.622542] system 00:01: [io  0x0980-0x09ff] has been reserved
> [    0.622663] system 00:01: [io  0x0a00-0x0a7f] has been reserved
> [    0.622785] system 00:01: [io  0x0a80-0x0aff] has been reserved
> [    0.622906] system 00:01: [io  0x0b00-0x0b7f] has been reserved
> [    0.623027] system 00:01: [io  0x0b80-0x0bff] has been reserved
> [    0.623148] system 00:01: [io  0x15e0-0x15ef] has been reserved
> [    0.623270] system 00:01: [io  0x1600-0x167f] has been reserved
> [    0.623391] system 00:01: [io  0x1640-0x165f] has been reserved
> [    0.623514] system 00:01: [mem 0xf8000000-0xfbffffff] has been reser=
ved
> [    0.623637] system 00:01: [mem 0xfed1c000-0xfed1ffff] has been reser=
ved
> [    0.624960] system 00:01: [mem 0xfed10000-0xfed17fff] has been reser=
ved
> [    0.625093] system 00:01: [mem 0xfed18000-0xfed18fff] has been reser=
ved
> [    0.625217] system 00:01: [mem 0xfed19000-0xfed19fff] has been reser=
ved
> [    0.625341] system 00:01: [mem 0xfed45000-0xfed4bfff] has been reser=
ved
> [    0.625467] system 00:01: Plug and Play ACPI device, IDs PNP0c02
(active)
> [    0.625617] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (activ=
e)
> [    0.625661] pnp 00:03: Plug and Play ACPI device, IDs LEN0071
PNP0303 (active)
> [    0.625705] pnp 00:04: Plug and Play ACPI device, IDs LEN0046
PNP0f13 (active)
> [    0.626275] pnp 00:05: Plug and Play ACPI device, IDs SMO1200
PNP0c31 (active)
> [    0.626696] system 00:06: [mem 0xd0010000-0xd001ffff] has been reser=
ved
> [    0.626822] system 00:06: [mem 0xd0000000-0xd000ffff] has been reser=
ved
> [    0.626948] system 00:06: Plug and Play ACPI device, IDs PNP0c02
(active)
> [    0.627026] pnp: PnP ACPI: found 7 devices
> [    0.635027] clocksource: acpi_pm: mask: 0xffffff max_cycles:
0xffffff, max_idle_ns: 2085701024 ns
> [    0.635248] pci 0000:00:1c.0: PCI bridge to [bus 02]
> [    0.635372] pci 0000:00:1c.0:   bridge window [mem
0xf1100000-0xf11fffff]
> [    0.635506] pci 0000:00:1c.1: PCI bridge to [bus 03]
> [    0.635628] pci 0000:00:1c.1:   bridge window [mem
0xf1000000-0xf10fffff]
> [    0.635764] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
> [    0.635767] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
> [    0.635770] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff
window]
> [    0.635773] pci_bus 0000:00: resource 7 [mem 0xd0000000-0xfebfffff
window]
> [    0.635776] pci_bus 0000:00: resource 8 [mem 0xfed40000-0xfed4bfff
window]
> [    0.635779] pci_bus 0000:02: resource 1 [mem 0xf1100000-0xf11fffff]
> [    0.635782] pci_bus 0000:03: resource 1 [mem 0xf1000000-0xf10fffff]
> [    0.636014] NET: Registered protocol family 2
> [    0.636497] TCP established hash table entries: 65536 (order: 7,
524288 bytes)
> [    0.636955] TCP bind hash table entries: 65536 (order: 8, 1048576
bytes)
> [    0.637334] TCP: Hash tables configured (established 65536 bind 6553=
6)
> [    0.637530] UDP hash table entries: 4096 (order: 5, 131072 bytes)
> [    0.637706] UDP-Lite hash table entries: 4096 (order: 5, 131072 byte=
s)
> [    0.637948] NET: Registered protocol family 1
> [    0.638088] pci 0000:00:02.0: Video device with shadowed ROM at
[mem 0x000c0000-0x000dffff]
> [    0.639112] PCI: CLS 64 bytes, default 64
> [    0.639200] Unpacking initramfs...
> [    1.283076] Freeing initrd memory: 13968K
> [    1.283199] PCI-DMA: Using software bounce buffering for IO (SWIOTLB=
)
> [    1.283325] software IO TLB [mem 0xbb069000-0xbf069000] (64MB)
mapped at [ffff8800bb069000-ffff8800bf068fff]
> [    1.283937] Scanning for low memory corruption every 60 seconds
> [    1.285465] Initialise system trusted keyrings
> [    1.285668] workingset: timestamp_bits=3D40 max_order=3D21 bucket_or=
der=3D0
> [    1.288410] zbud: loaded
> [    1.288854] SPL: Loaded module v0.7.0-rc4_1_g8f87971
> [    1.289108] SPLAT: Loaded module v0.7.0-rc4_1_g8f87971
> [    2.291658] tsc: Refined TSC clocksource calibration: 2593.995 MHz
> [    2.291794] clocksource: tsc: mask: 0xffffffffffffffff max_cycles:
0x256413873f2, max_idle_ns: 440795261455 ns
> [    3.305373] clocksource: Switched to clocksource tsc
> [    3.362046] ZFS: Loaded module v0.7.0-rc4_17_ga32df59e1, ZFS pool
version 5000, ZFS filesystem version 5
> [    3.362276] ZPIOS: Loaded module v0.7.0-rc4_17_ga32df59e1
> [    3.363387] Key type asymmetric registered
> [    3.363530] Block layer SCSI generic (bsg) driver version 0.4
loaded (major 249)
> [    3.363767] io scheduler noop registered
> [    3.363880] io scheduler deadline registered
> [    3.364055] io scheduler cfq registered (default)
> [    3.364171] io scheduler mq-deadline registered
> [    3.364285] io scheduler kyber registered
> [    3.365164] intel_idle: MWAIT substates: 0x11142120
> [    3.365166] intel_idle: v0.4.1 model 0x3D
> [    3.365587] intel_idle: lapic_timer_reliable_states 0xffffffff
> [    3.365935] GHES: HEST is not enabled!
> [    3.366170] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> [    3.366987] Linux agpgart interface v0.103
> [    3.367724] rtc_cmos 00:02: RTC can wake from S4
> [    3.368018] rtc_cmos 00:02: rtc core: registered rtc_cmos as rtc0
> [    3.368178] rtc_cmos 00:02: alarms up to one month, y3k, 114 bytes
nvram, hpet irqs
> [    3.368393] intel_pstate: Intel P-state driver initializing
> [    3.369048] ledtrig-cpu: registered to indicate activity on CPUs
> [    3.369664] NET: Registered protocol family 10
> [    3.370267] Segment Routing with IPv6
> [    3.370414] NET: Registered protocol family 17
> [    3.371237] microcode: sig=3D0x306d4, pf=3D0x40, revision=3D0x21
> [    3.371499] microcode: Microcode Update Driver: v2.2.
> [    3.372027] registered taskstats version 1
> [    3.372273] Loading compiled-in X.509 certificates
> [    3.372420] zswap: loaded using pool lzo/zbud
> [    3.373446]   Magic number: 1:23:549
> [    3.373576] clockevents clockevent0: hash matches
> [    3.373733] acpi PNP0C0F:00: hash matches
> [    3.373911] rtc_cmos 00:02: setting system clock to 2017-05-19
20:30:19 UTC (1495225819)
> [    3.374185] PM: Hibernation image not present or could not be loaded=
=2E
> [    3.377369] Freeing unused kernel memory: 1392K
> [    3.377486] Write protecting the kernel read-only data: 12288k
> [    3.377988] Freeing unused kernel memory: 76K
> [    3.383430] Freeing unused kernel memory: 1460K
> [    3.389172] random: systemd-tmpfile: uninitialized urandom read (16
bytes read)
> [    3.389347] random: systemd-tmpfile: uninitialized urandom read (16
bytes read)
> [    3.390710] random: systemd-udevd: uninitialized urandom read (16
bytes read)
> [    3.390830] random: systemd-udevd: uninitialized urandom read (16
bytes read)
> [    3.390913] random: systemd-udevd: uninitialized urandom read (16
bytes read)
> [    3.393013] random: udevadm: uninitialized urandom read (16 bytes re=
ad)
> [    3.393109] random: udevadm: uninitialized urandom read (16 bytes re=
ad)
> [    3.395289] random: systemd-udevd: uninitialized urandom read (16
bytes read)
> [    3.395385] random: systemd-udevd: uninitialized urandom read (16
bytes read)
> [    3.395469] random: systemd-udevd: uninitialized urandom read (16
bytes read)
> [    3.413889] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU]
at 0x60,0x64 irq 1,12
> [    3.415839] serio: i8042 KBD port at 0x60,0x64 irq 1
> [    3.415952] serio: i8042 AUX port at 0x60,0x64 irq 12
> [    3.417479] ACPI: bus type USB registered
> [    3.417636] usbcore: registered new interface driver usbfs
> [    3.417719] usbcore: registered new interface driver hub
> [    3.417819] usbcore: registered new device driver usb
> [    3.418218] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driv=
er
> [    3.418474] ehci-pci: EHCI PCI platform driver
> [    3.418702] ehci-pci 0000:00:1d.0: EHCI Host Controller
> [    3.418786] ehci-pci 0000:00:1d.0: new USB bus registered, assigned
bus number 1
> [    3.418910] ehci-pci 0000:00:1d.0: debug port 2
> [    3.419624] SCSI subsystem initialized
> [    3.422892] ehci-pci 0000:00:1d.0: cache line size of 64 is not
supported
> [    3.422906] ehci-pci 0000:00:1d.0: irq 23, io mem 0xf123d000
> [    3.423043] libata version 3.00 loaded.
> [    3.425272] AVX2 version of gcm_enc/dec engaged.
> [    3.425355] AES CTR mode by8 optimization enabled
> [    3.430696] input: AT Translated Set 2 keyboard as
/devices/platform/i8042/serio0/input/input0
> [    3.434930] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
> [    3.435147] hub 1-0:1.0: USB hub found
> [    3.435228] hub 1-0:1.0: 3 ports detected
> [    3.435522] ahci 0000:00:1f.2: version 3.0
> [    3.445766] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 3 ports 6
Gbps 0x1 impl SATA mode
> [    3.445889] ahci 0000:00:1f.2: flags: 64bit ncq pm led clo only pio
slum part deso sadm sds apst
> [    3.446361] scsi host0: ahci
> [    3.446544] scsi host1: ahci
> [    3.446708] scsi host2: ahci
> [    3.446818] ata1: SATA max UDMA/133 abar m2048@0xf123c000 port
0xf123c100 irq 41
> [    3.446936] ata2: DUMMY
> [    3.447011] ata3: DUMMY
> [    3.447222] xhci_hcd 0000:00:14.0: xHCI Host Controller
> [    3.447314] xhci_hcd 0000:00:14.0: new USB bus registered, assigned
bus number 2
> [    3.448504] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci
version 0x100 quirks 0x0004b810
> [    3.448628] xhci_hcd 0000:00:14.0: cache line size of 64 is not
supported
> [    3.448816] hub 2-0:1.0: USB hub found
> [    3.448913] hub 2-0:1.0: 11 ports detected
> [    3.453178] xhci_hcd 0000:00:14.0: xHCI Host Controller
> [    3.453263] xhci_hcd 0000:00:14.0: new USB bus registered, assigned
bus number 3
> [    3.453537] hub 3-0:1.0: USB hub found
> [    3.453630] hub 3-0:1.0: 4 ports detected
> [    3.754993] usb 1-1: new high-speed USB device number 2 using ehci-p=
ci
> [    3.759255] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [    3.759808] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES)
succeeded
> [    3.759812] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE
LOCK) filtered out
> [    3.760074] ata1.00: ACPI cmd ef/10:09:00:00:00:a0 (SET FEATURES)
succeeded
> [    3.760987] ata1.00: ATA-9: SAMSUNG MZ7LN512HCHP-000L1, EMT03L0Q,
max UDMA/133
> [    3.761151] ata1.00: 1000215216 sectors, multi 16: LBA48 NCQ (depth
31/32), AA
> [    3.761980] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES)
succeeded
> [    3.761985] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE
LOCK) filtered out
> [    3.762187] ata1.00: ACPI cmd ef/10:09:00:00:00:a0 (SET FEATURES)
succeeded
> [    3.763133] ata1.00: configured for UDMA/133
> [    3.763753] scsi 0:0:0:0: Direct-Access     ATA      SAMSUNG
MZ7LN512 3L0Q PQ: 0 ANSI: 5
> [    3.771657] usb 2-5: new full-speed USB device number 2 using xhci_h=
cd
> [    3.801412] sd 0:0:0:0: [sda] 1000215216 512-byte logical blocks:
(512 GB/477 GiB)
> [    3.801674] sd 0:0:0:0: [sda] Write Protect is off
> [    3.801805] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [    3.801835] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
> [    3.802949]  sda: sda1 sda2
> [    3.803553] sd 0:0:0:0: [sda] Attached SCSI disk
> [    3.830658] device-mapper: uevent: version 1.0.3
> [    3.830806] device-mapper: ioctl: 4.35.0-ioctl (2016-06-23)
initialised: dm-devel@redhat.com
> [    3.896253] hub 1-1:1.0: USB hub found
> [    3.896537] hub 1-1:1.0: 8 ports detected
> [    4.024986] usb 2-6: new full-speed USB device number 3 using xhci_h=
cd
> [    4.271655] usb 2-7: new full-speed USB device number 4 using xhci_h=
cd
> [    4.571645] usb 2-8: new high-speed USB device number 5 using xhci_h=
cd
> [    7.943907] random: crng init done
> [   11.088804] NET: Registered protocol family 38
> [   11.597379] EXT4-fs (dm-1): mounted filesystem with ordered data
mode. Opts: (null)
> [   11.692375] ip_tables: (C) 2000-2006 Netfilter Core Team
> [   11.698252] systemd[1]: systemd 232 running in system mode. (+PAM
-AUDIT -SELINUX -IMA -APPARMOR +SMACK -SYSVINIT +UTMP +LIBCRYPTSETUP
+GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
> [   11.698522] systemd[1]: Detected architecture x86-64.
> [   11.699222] systemd[1]: Set hostname to <pporpc01>.
> [   11.761881] systemd[1]: Started Dispatch Password Requests to
Console Directory Watch.
> [   11.762444] systemd[1]: Listening on Device-mapper event daemon FIFO=
s.
> [   11.763115] systemd[1]: Set up automount Arbitrary Executable File
Formats File System Automount Point.
> [   11.763635] systemd[1]: Listening on /dev/initctl Compatibility
Named Pipe.
> [   11.764090] systemd[1]: Listening on udev Kernel Socket.
> [   11.764528] systemd[1]: Listening on LVM2 metadata daemon socket.
> [   11.765014] systemd[1]: Started Forward Password Requests to Wall
Directory Watch.
> [   11.787702] sd 0:0:0:0: Attached scsi generic sg0 type 0
> [   11.798253] EXT4-fs (dm-1): re-mounted. Opts: discard
> [   11.821481] systemd-journald[264]: File
/var/log/journal/c9bcd16f57c04d31920dbd24f5a65d81/system.journal
corrupted or uncleanly shut down, renaming and replacing.
> [   11.895479] systemd-journald[264]: Received request to flush
runtime journal from PID 1
> [   12.013192] input: Lid Switch as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input2
> [   12.013974] (NULL device *): hwmon_device_register() is deprecated.
Please convert the driver to use hwmon_device_register_with_info().
> [   12.014346] thermal LNXTHERM:00: registered as thermal_zone0
> [   12.014424] ACPI: Thermal Zone [THM0] (50 C)
> [   12.027978] ACPI: Lid Switch [LID]
> [   12.028005] tpm_tis 00:05: 1.2 TPM (device-id 0x0, rev-id 78)
> [   12.028315] input: Sleep Button as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input3
> [   12.031659] ACPI: Battery Slot [BAT0] (battery present)
> [   12.035073] Non-volatile memory driver v1.3
> [   12.038982] ACPI: Battery Slot [BAT1] (battery present)
> [   12.039211] ACPI: AC Adapter [AC] (off-line)
> [   12.044615] ACPI: Sleep Button [SLPB]
> [   12.044757] input: Power Button as
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input4
> [   12.054141] thinkpad_acpi: ThinkPad ACPI Extras v0.25
> [   12.054228] thinkpad_acpi: http://ibm-acpi.sf.net/
> [   12.054306] thinkpad_acpi: ThinkPad BIOS N10ET36W (1.15 ), EC unknow=
n
> [   12.054386] thinkpad_acpi: Lenovo ThinkPad X250, model 20CLS41500
> [   12.054882] thinkpad_hwmon thinkpad_hwmon: hwmon_device_register()
is deprecated. Please convert the driver to use
hwmon_device_register_with_info().
> [   12.055347] thinkpad_acpi: radio switch found; radios are enabled
> [   12.055502] thinkpad_acpi: This ThinkPad has standard ACPI
backlight brightness control, supported by the ACPI video driver
> [   12.055619] thinkpad_acpi: Disabling thinkpad-acpi brightness
events by default...
> [   12.056918] thinkpad_acpi: rfkill switch tpacpi_bluetooth_sw: radio
is unblocked
> [   12.058145] ACPI: Power Button [PWRF]
> [   12.087730] tpm tpm0: A TPM error (6) occurred attempting to read a
pcr value
> [   12.087820] tpm tpm0: TPM is disabled/deactivated (0x6)
> [   12.089982] snd_hda_codec_realtek hdaudioC1D0: autoconfig for
ALC3232: line_outs=3D1 (0x14/0x0/0x0/0x0/0x0) type:speaker
> [   12.090109] snd_hda_codec_realtek hdaudioC1D0:    speaker_outs=3D0
(0x0/0x0/0x0/0x0/0x0)
> [   12.090225] snd_hda_codec_realtek hdaudioC1D0:    hp_outs=3D2
(0x16/0x15/0x0/0x0/0x0)
> [   12.090338] snd_hda_codec_realtek hdaudioC1D0:    mono: mono_out=3D0=
x0
> [   12.090419] snd_hda_codec_realtek hdaudioC1D0:    inputs:
> [   12.090498] snd_hda_codec_realtek hdaudioC1D0:      Dock Mic=3D0x19
> [   12.090579] snd_hda_codec_realtek hdaudioC1D0:      Mic=3D0x1a
> [   12.090658] snd_hda_codec_realtek hdaudioC1D0:      Internal Mic=3D0=
x12
> [   12.095862] input: ThinkPad Extra Buttons as
/devices/platform/thinkpad_acpi/input/input5
> [   12.098413] [drm] Memory usable by graphics device =3D 4096M
> [   12.098530] [drm] Replacing VGA console driver
> [   12.099488] Console: switching to colour dummy device 80x25
> [   12.099613] wmi: Mapper loaded
> [   12.117574] input: HDA Digital PCBeep as
/devices/pci0000:00/0000:00:1b.0/sound/card1/input6
> [   12.117697] input: HDA Intel PCH Dock Mic as
/devices/pci0000:00/0000:00:1b.0/sound/card1/input7
> [   12.117730] input: HDA Intel PCH Mic as
/devices/pci0000:00/0000:00:1b.0/sound/card1/input8
> [   12.117763] input: HDA Intel PCH Dock Headphone as
/devices/pci0000:00/0000:00:1b.0/sound/card1/input9
> [   12.117796] input: HDA Intel PCH Headphone as
/devices/pci0000:00/0000:00:1b.0/sound/card1/input10
> [   12.117880] [drm] Supports vblank timestamp caching Rev 2 (21.10.201=
3).
> [   12.117887] [drm] Driver supports precise vblank timestamp query.
> [   12.118145] pps_core: LinuxPPS API ver. 1 registered
> [   12.118150] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
Rodolfo Giometti <giometti@linux.it>
> [   12.118212] i915 0000:00:02.0: vgaarb: changed VGA decodes:
olddecodes=3Dio+mem,decodes=3Dio+mem:owns=3Dio+mem
> [   12.119650] PTP clock support registered
> [   12.127275] [drm] Initialized i915 1.6.0 20170403 for 0000:00:02.0
on minor 0
> [   12.127912] ACPI: Video Device [VID] (multi-head: yes  rom: no
post: no)
> [   12.128204] input: Video Bus as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input11
> [   12.158855] input: PC Speaker as /devices/platform/pcspkr/input/inpu=
t12
> [   12.159221] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
> [   12.159225] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
> [   12.168088] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters,
655360 ms ovfl timer
> [   12.168098] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
> [   12.168125] RAPL PMU: hw unit of domain package 2^-14 Joules
> [   12.168130] RAPL PMU: hw unit of domain dram 2^-14 Joules
> [   12.168134] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
> [   12.213344] EXT4-fs (sda1): mounted filesystem with ordered data
mode. Opts: (null)
> [   12.220116] intel_rapl: Found RAPL domain package
> [   12.220124] intel_rapl: Found RAPL domain core
> [   12.220128] intel_rapl: Found RAPL domain uncore
> [   12.220133] intel_rapl: Found RAPL domain dram
> [   12.242116] media: Linux media interface: v0.10
> [   12.247101] Linux video capture interface: v2.00
> [   12.260614] uvcvideo: Found UVC 1.00 device Integrated Camera
(5986:0366)
> [   12.268124] usb 2-7: USB disconnect, device number 4
> [   12.273923] uvcvideo 2-8:1.0: Entity type for entity Extension 4
was not initialized!
> [   12.273933] uvcvideo 2-8:1.0: Entity type for entity Extension 3
was not initialized!
> [   12.273941] uvcvideo 2-8:1.0: Entity type for entity Processing 2
was not initialized!
> [   12.274287] uvcvideo 2-8:1.0: Entity type for entity Camera 1 was
not initialized!
> [   12.274363] input: Integrated Camera as
/devices/pci0000:00/0000:00:14.0/usb2/2-8/2-8:1.0/input/input14
> [   12.280555] usbcore: registered new interface driver uvcvideo
> [   12.280563] USB Video Class driver (1.1.1)
> [   12.298049] snd_hda_intel 0000:00:03.0: bound 0000:00:02.0 (ops
i915_audio_component_bind_ops [i915])
> [   12.298067] [drm] Initialized i915 1.6.0 20170403 for 0000:00:02.0
on minor 0
> [   12.298120] shpchp: Standard Hot Plug PCI Controller Driver
version: 0.4
> [   12.298306] i801_smbus 0000:00:1f.3: SPD Write Disable is set
> [   12.298379] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
> [   12.300185] Adding 17244156k swap on
/dev/mapper/pporpc01stor01-swap.  Priority:-1 extents:1 across:17244156k
SSFS
> [   12.304151] (NULL device *): hwmon_device_register() is deprecated.
Please convert the driver to use hwmon_device_register_with_info().
> [   12.304587] e1000e 0000:00:19.0: Interrupt Throttling Rate
(ints/sec) set to dynamic conservative mode
> [   12.322372] Intel(R) Wireless WiFi driver for Linux
> [   12.322378] Copyright(c) 2003- 2015 Intel Corporation
> [   12.324224] iwlwifi 0000:03:00.0: Direct firmware load for
iwlwifi-7265D-29.ucode failed with error -2
> [   12.324242] iwlwifi 0000:03:00.0: Direct firmware load for
iwlwifi-7265D-28.ucode failed with error -2
> [   12.330667] iwlwifi 0000:03:00.0: capa flags index 3 larger than
supported by driver
> [   12.331153] iwlwifi 0000:03:00.0: loaded firmware version
27.455470.0 op_mode iwlmvm
> [   12.344403] iTCO_vendor_support: vendor-support=3D0
> [   12.344902] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
> [   12.344950] iTCO_wdt: Found a Wildcat Point_LP TCO device
(Version=3D2, TCOBASE=3D0x1860)
> [   12.345369] iTCO_wdt: initialized. heartbeat=3D30 sec (nowayout=3D0)=

> [   12.349318] iwlwifi 0000:03:00.0: Detected Intel(R) Dual Band
Wireless AC 7265, REV=3D0x210
> [   12.352568] iwlwifi 0000:03:00.0: L1 Enabled - LTR Enabled
> [   12.353117] iwlwifi 0000:03:00.0: L1 Enabled - LTR Enabled
> [   12.425613] ieee80211 phy0: Selected rate control algorithm
'iwl-mvm-rs'
> [   12.425950] (NULL device *): hwmon_device_register() is deprecated.
Please convert the driver to use hwmon_device_register_with_info().
> [   12.425995] thermal thermal_zone3: failed to read out thermal zone (=
-5)
> [   12.428036] iwlwifi 0000:03:00.0 wlp3s0: renamed from wlan0
> [   12.472180] fbcon: inteldrmfb (fb0) is primary device
> [   12.514555] e1000e 0000:00:19.0 0000:00:19.0 (uninitialized):
registered PHC clock
> [   12.597048] e1000e 0000:00:19.0 eth0: (PCI Express:2.5GT/s:Width
x1) 68:f7:28:e7:af:97
> [   12.597050] e1000e 0000:00:19.0 eth0: Intel(R) PRO/1000 Network
Connection
> [   12.597076] e1000e 0000:00:19.0 eth0: MAC: 11, PHY: 12, PBA No:
1000FF-0FF
> [   12.597644] e1000e 0000:00:19.0 enp0s25: renamed from eth0
> [   12.944519] psmouse serio1: synaptics: queried max coordinates: x
[..5712], y [..4780]
> [   12.975692] psmouse serio1: synaptics: queried min coordinates: x
[1232..], y [1074..]
> [   13.036464] psmouse serio1: synaptics: Touchpad model: 1, fw: 8.1,
id: 0x1e2b1, caps: 0xf002a3/0x943300/0x12e800/0x10000, board id: 3075,
fw id: 2560
> [   13.036480] psmouse serio1: synaptics: serio: Synaptics
pass-through port at isa0060/serio1/input0
> [   13.075182] input: SynPS/2 Synaptics TouchPad as
/devices/platform/i8042/serio1/input/input13
> [   13.078710] mousedev: PS/2 mouse device common for all mice
> [   13.575988] Console: switching to colour frame buffer device 240x67
> [   13.603808] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
> [   13.616969] EXT4-fs (dm-2): mounted filesystem with ordered data
mode. Opts: discard
> [   13.625045] input: HDA Intel HDMI HDMI/DP,pcm=3D3 as
/devices/pci0000:00/0000:00:03.0/sound/card0/input16
> [   13.625162] input: HDA Intel HDMI HDMI/DP,pcm=3D7 as
/devices/pci0000:00/0000:00:03.0/sound/card0/input17
> [   13.625310] input: HDA Intel HDMI HDMI/DP,pcm=3D8 as
/devices/pci0000:00/0000:00:03.0/sound/card0/input18
> [   13.625426] input: HDA Intel HDMI HDMI/DP,pcm=3D9 as
/devices/pci0000:00/0000:00:03.0/sound/card0/input19
> [   13.625527] input: HDA Intel HDMI HDMI/DP,pcm=3D10 as
/devices/pci0000:00/0000:00:03.0/sound/card0/input20
> [   13.700782] psmouse serio2: trackpoint: IBM TrackPoint firmware:
0x0e, buttons: 3/3
> [   13.815759] nf_conntrack version 0.5.0 (65536 buckets, 262144 max)
> [   13.896413] input: TPPS/2 IBM TrackPoint as
/devices/platform/i8042/serio1/serio2/input/input15
> [   13.950739] iwlwifi 0000:03:00.0: L1 Enabled - LTR Enabled
> [   13.952378] iwlwifi 0000:03:00.0: L1 Enabled - LTR Enabled
> [   14.020650] iwlwifi 0000:03:00.0: L1 Enabled - LTR Enabled
> [   14.024283] iwlwifi 0000:03:00.0: L1 Enabled - LTR Enabled
> [   14.057281] IPv6: ADDRCONF(NETDEV_UP): wlp3s0: link is not ready
> [   17.810158] wlp3s0: authenticate with 74:da:38:80:18:8c
> [   17.819038] wlp3s0: send auth to 74:da:38:80:18:8c (try 1/3)
> [   17.822184] wlp3s0: authenticated
> [   17.824455] wlp3s0: associate with 74:da:38:80:18:8c (try 1/3)
> [   17.828962] wlp3s0: RX AssocResp from 74:da:38:80:18:8c
(capab=3D0x411 status=3D0 aid=3D3)
> [   17.833323] wlp3s0: associated
> [   17.833409] IPv6: ADDRCONF(NETDEV_CHANGE): wlp3s0: link becomes read=
y
> [   18.227992] thinkpad_acpi: docked into hotplug port replicator
> [   19.151239] usb 3-3: new SuperSpeed USB device number 2 using xhci_h=
cd
> [   19.405730] hub 3-3:1.0: USB hub found
> [   19.406206] hub 3-3:1.0: 4 ports detected
> [   19.571040] usb 2-3: new high-speed USB device number 6 using xhci_h=
cd
> [   19.705123] hub 2-3:1.0: USB hub found
> [   19.705461] hub 2-3:1.0: 4 ports detected
> [   19.758718] thinkpad_acpi: EC reports that Thermal Table has changed=

> [   19.787965] usb 3-3.1: new SuperSpeed USB device number 3 using
xhci_hcd
> [   19.819396] hub 3-3.1:1.0: USB hub found
> [   19.820248] hub 3-3.1:1.0: 4 ports detected
> [   20.004419] usb 2-3.1: new high-speed USB device number 7 using
xhci_hcd
> [   20.119785] hub 2-3.1:1.0: USB hub found
> [   20.120496] hub 2-3.1:1.0: 4 ports detected
> [   20.184706] usb 3-3.1.4: new SuperSpeed USB device number 4 using
xhci_hcd
> [   20.216322] hub 3-3.1.4:1.0: USB hub found
> [   20.217294] hub 3-3.1.4:1.0: 4 ports detected
> [   20.291120] usb 2-3.4: new high-speed USB device number 8 using
xhci_hcd
> [   20.395701] hub 2-3.4:1.0: USB hub found
> [   20.395843] hub 2-3.4:1.0: 3 ports detected
> [   20.467777] usb 2-3.1.4: new high-speed USB device number 9 using
xhci_hcd
> [   20.569339] hub 2-3.1.4:1.0: USB hub found
> [   20.569986] hub 2-3.1.4:1.0: 4 ports detected
> [   20.674404] usb 2-3.4.2: new full-speed USB device number 10 using
xhci_hcd
> [   20.795154] hidraw: raw HID events driver (C) Jiri Kosina
> [   20.803497] usbcore: registered new interface driver usbhid
> [   20.803540] usbhid: USB HID core driver
> [   20.805531] logitech-djreceiver 0003:046D:C52B.0003:
hiddev0,hidraw0: USB HID v1.11 Device [Logitech USB Receiver] on
usb-0000:00:14.0-3.4.2/input2
> [   20.929406] input: Logitech M705 as
/devices/pci0000:00/0000:00:14.0/usb2/2-3/2-3.4/2-3.4.2/2-3.4.2:1.2/0003:=
046D:C52B.0003/0003:046D:101B.0004/input/input21
> [   20.929631] logitech-hidpp-device 0003:046D:101B.0004:
input,hidraw1: USB HID v1.11 Mouse [Logitech M705] on
usb-0000:00:14.0-3.4.2:1
> [   20.935478] input: Logitech K360 as
/devices/pci0000:00/0000:00:14.0/usb2/2-3/2-3.4/2-3.4.2/2-3.4.2:1.2/0003:=
046D:C52B.0003/0003:046D:4004.0005/input/input22
> [   20.935756] logitech-hidpp-device 0003:046D:4004.0005:
input,hidraw2: USB HID v1.11 Keyboard [Logitech K360] on
usb-0000:00:14.0-3.4.2:2
> [   37.434904] logitech-hidpp-device 0003:046D:4004.0005: HID++ 2.0
device connected.
> [   40.571838] systemd-journald[264]: File
/var/log/journal/c9bcd16f57c04d31920dbd24f5a65d81/user-1000.journal
corrupted or uncleanly shut down, renaming and replacing.
> [   42.336234] ACPI : button: The lid device is not compliant to SW_LID=
=2E
> [   43.224123] fuse init (API version 7.26)
> [   43.420288] IPv6: ADDRCONF(NETDEV_UP): enp0s25: link is not ready
> [   43.634232] snd_hda_intel 0000:00:03.0: IRQ timing workaround is
activated for card #0. Suggest a bigger bdl_pos_adj.
> [   43.664527] logitech-hidpp-device 0003:046D:101B.0004: HID++ 1.0
device connected.
> [   43.755682] snd_hda_intel 0000:00:1b.0: IRQ timing workaround is
activated for card #1. Suggest a bigger bdl_pos_adj.
> [   44.226448] wlp3s0: deauthenticating from 74:da:38:80:18:8c by
local choice (Reason: 3=3DDEAUTH_LEAVING)
> [   44.233910] iwlwifi 0000:03:00.0: Failed to find station
> [   44.233917] wlp3s0: failed to remove key (1, ff:ff:ff:ff:ff:ff)
from hardware (-22)
> [   46.865421] e1000e: enp0s25 NIC Link is Up 1000 Mbps Full Duplex,
Flow Control: Rx/Tx
> [   46.865453] IPv6: ADDRCONF(NETDEV_CHANGE): enp0s25: link becomes rea=
dy

lsmod:

> Module                  Size  Used by
> fuse                   98304  2
> hid_logitech_hidpp     32768  0
> hid_logitech_dj        20480  0
> usbhid                 45056  0
> hid                   110592  3 usbhid,hid_logitech_dj,hid_logitech_hid=
pp
> ctr                    16384  0
> ccm                    20480  0
> ipt_REJECT             16384  3
> nf_reject_ipv4         16384  1 ipt_REJECT
> nf_conntrack_ipv4      16384  5
> nf_defrag_ipv4         16384  1 nf_conntrack_ipv4
> xt_tcpudp              16384  4
> xt_conntrack           16384  5
> nf_conntrack          110592  2 nf_conntrack_ipv4,xt_conntrack
> libcrc32c              16384  1 nf_conntrack
> crc32c_generic         16384  0
> xt_iprange             16384  1
> iptable_filter         16384  1
> snd_hda_codec_hdmi     49152  1
> joydev                 20480  0
> mousedev               20480  0
> arc4                   16384  2
> iwlmvm                299008  0
> mei_wdt                16384  0
> iTCO_wdt               16384  0
> iTCO_vendor_support    16384  1 iTCO_wdt
> mac80211              688128  1 iwlmvm
> iwlwifi               208896  1 iwlmvm
> rtsx_pci_ms            20480  0
> cfg80211              524288  3 iwlmvm,iwlwifi,mac80211
> memstick               16384  1 rtsx_pci_ms
> uvcvideo               86016  0
> videobuf2_vmalloc      16384  1 uvcvideo
> videobuf2_memops       16384  1 videobuf2_vmalloc
> videobuf2_v4l2         20480  1 uvcvideo
> videobuf2_core         36864  2 uvcvideo,videobuf2_v4l2
> videodev              151552  3 uvcvideo,videobuf2_core,videobuf2_v4l2
> media                  32768  2 uvcvideo,videodev
> intel_rapl             20480  0
> x86_pkg_temp_thermal    16384  0
> intel_powerclamp       16384  0
> coretemp               16384  0
> kvm_intel             192512  0
> kvm                   516096  1 kvm_intel
> irqbypass              16384  1 kvm
> intel_cstate           16384  0
> intel_rapl_perf        16384  0
> evdev                  24576  31
> input_leds             16384  0
> pcspkr                 16384  0
> psmouse               131072  0
> mac_hid                16384  0
> e1000e                225280  0
> lpc_ich                24576  0
> intel_pch_thermal      16384  0
> i2c_i801               24576  0
> mei_me                 36864  1
> ptp                    20480  1 e1000e
> mei                    81920  3 mei_me,mei_wdt
> shpchp                 32768  0
> pps_core               20480  1 ptp
> wmi                    16384  0
> i915                 1449984  4
> snd_hda_codec_realtek    73728  1
> snd_hda_codec_generic    69632  1 snd_hda_codec_realtek
> snd_hda_intel          36864  7
> snd_hda_codec         106496  4
snd_hda_intel,snd_hda_codec_hdmi,snd_hda_codec_generic,snd_hda_codec_real=
tek
> drm_kms_helper        126976  1 i915
> thinkpad_acpi          77824  1
> snd_hda_core           65536  5
snd_hda_intel,snd_hda_codec,snd_hda_codec_hdmi,snd_hda_codec_generic,snd_=
hda_codec_realtek
> nvram                  16384  1 thinkpad_acpi
> drm                   299008  5 i915,drm_kms_helper
> snd_hwdep              16384  1 snd_hda_codec
> snd_pcm                90112  5
snd_hda_intel,snd_hda_codec,snd_hda_core,snd_hda_codec_hdmi
> rfkill                 20480  3 thinkpad_acpi,cfg80211
> intel_gtt              20480  1 i915
> snd_timer              28672  2 snd_pcm
> syscopyarea            16384  1 drm_kms_helper
> sysfillrect            16384  1 drm_kms_helper
> sysimgblt              16384  1 drm_kms_helper
> snd                    65536  21
snd_hda_intel,snd_hwdep,snd_hda_codec,snd_timer,thinkpad_acpi,snd_hda_cod=
ec_hdmi,snd_hda_codec_generic,snd_hda_codec_realtek,snd_pcm
> fb_sys_fops            16384  1 drm_kms_helper
> led_class              16384  3 iwlmvm,input_leds,thinkpad_acpi
> i2c_algo_bit           16384  1 i915
> ac                     16384  0
> soundcore              16384  1 snd
> battery                20480  0
> tpm_tis                16384  0
> tpm_tis_core           20480  1 tpm_tis
> video                  36864  2 thinkpad_acpi,i915
> thermal                20480  0
> button                 16384  1 i915
> tpm                    49152  2 tpm_tis,tpm_tis_core
> sch_fq_codel           20480  6
> sg                     36864  0
> ip_tables              24576  1 iptable_filter
> x_tables               28672  6
ipt_REJECT,ip_tables,iptable_filter,xt_tcpudp,xt_iprange,xt_conntrack
> ext4                  536576  3
> crc16                  16384  1 ext4
> jbd2                   90112  1 ext4
> fscrypto               24576  1 ext4
> mbcache                16384  1 ext4
> algif_skcipher         20480  0
> af_alg                 16384  1 algif_skcipher
> dm_crypt               36864  1
> dm_mod                106496  12 dm_crypt
> dax                    20480  1 dm_mod
> sd_mod                 45056  3
> crct10dif_pclmul       16384  0
> crc32_pclmul           16384  0
> crc32c_intel           24576  1
> ghash_clmulni_intel    16384  0
> pcbc                   16384  0
> rtsx_pci_sdmmc         24576  0
> serio_raw              16384  0
> mmc_core              122880  1 rtsx_pci_sdmmc
> atkbd                  24576  0
> libps2                 16384  2 atkbd,psmouse
> aesni_intel           167936  2
> xhci_pci               16384  0
> ahci                   36864  2
> xhci_hcd              184320  1 xhci_pci
> libahci                28672  1 ahci
> aes_x86_64             20480  1 aesni_intel
> crypto_simd            16384  1 aesni_intel
> glue_helper            16384  1 aesni_intel
> cryptd                 20480  4
crypto_simd,ghash_clmulni_intel,aesni_intel
> libata                204800  2 ahci,libahci
> scsi_mod              155648  3 sd_mod,libata,sg
> ehci_pci               16384  0
> ehci_hcd               73728  1 ehci_pci
> rtsx_pci               49152  2 rtsx_pci_sdmmc,rtsx_pci_ms
> usbcore               208896  6
uvcvideo,usbhid,ehci_hcd,xhci_pci,xhci_hcd,ehci_pci
> usb_common             16384  1 usbcore
> i8042                  24576  0
> serio                  20480  7 serio_raw,atkbd,psmouse,i8042

Config:

> #
> # Automatically generated file; DO NOT EDIT.
> # Linux/x86 4.12.0-rc1 Kernel Configuration
> #
> CONFIG_64BIT=3Dy
> CONFIG_X86_64=3Dy
> CONFIG_X86=3Dy
> CONFIG_INSTRUCTION_DECODER=3Dy
> CONFIG_OUTPUT_FORMAT=3D"elf64-x86-64"
> CONFIG_ARCH_DEFCONFIG=3D"arch/x86/configs/x86_64_defconfig"
> CONFIG_LOCKDEP_SUPPORT=3Dy
> CONFIG_STACKTRACE_SUPPORT=3Dy
> CONFIG_MMU=3Dy
> CONFIG_ARCH_MMAP_RND_BITS_MIN=3D28
> CONFIG_ARCH_MMAP_RND_BITS_MAX=3D32
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=3D8
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=3D16
> CONFIG_NEED_DMA_MAP_STATE=3Dy
> CONFIG_NEED_SG_DMA_LENGTH=3Dy
> CONFIG_GENERIC_ISA_DMA=3Dy
> CONFIG_GENERIC_BUG=3Dy
> CONFIG_GENERIC_BUG_RELATIVE_POINTERS=3Dy
> CONFIG_GENERIC_HWEIGHT=3Dy
> CONFIG_ARCH_MAY_HAVE_PC_FDC=3Dy
> CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
> CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
> CONFIG_ARCH_HAS_CPU_RELAX=3Dy
> CONFIG_ARCH_HAS_CACHE_LINE_SIZE=3Dy
> CONFIG_HAVE_SETUP_PER_CPU_AREA=3Dy
> CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=3Dy
> CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=3Dy
> CONFIG_ARCH_HIBERNATION_POSSIBLE=3Dy
> CONFIG_ARCH_SUSPEND_POSSIBLE=3Dy
> CONFIG_ARCH_WANT_HUGE_PMD_SHARE=3Dy
> CONFIG_ARCH_WANT_GENERAL_HUGETLB=3Dy
> CONFIG_ZONE_DMA32=3Dy
> CONFIG_AUDIT_ARCH=3Dy
> CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=3Dy
> CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=3Dy
> CONFIG_HAVE_INTEL_TXT=3Dy
> CONFIG_X86_64_SMP=3Dy
> CONFIG_ARCH_SUPPORTS_UPROBES=3Dy
> CONFIG_FIX_EARLYCON_MEM=3Dy
> CONFIG_PGTABLE_LEVELS=3D4
> CONFIG_DEFCONFIG_LIST=3D"/lib/modules/$UNAME_RELEASE/.config"
> CONFIG_IRQ_WORK=3Dy
> CONFIG_BUILDTIME_EXTABLE_SORT=3Dy
> CONFIG_THREAD_INFO_IN_TASK=3Dy
>
> #
> # General setup
> #
> CONFIG_INIT_ENV_ARG_LIMIT=3D32
> CONFIG_CROSS_COMPILE=3D""
> # CONFIG_COMPILE_TEST is not set
> CONFIG_LOCALVERSION=3D""
> # CONFIG_LOCALVERSION_AUTO is not set
> CONFIG_HAVE_KERNEL_GZIP=3Dy
> CONFIG_HAVE_KERNEL_BZIP2=3Dy
> CONFIG_HAVE_KERNEL_LZMA=3Dy
> CONFIG_HAVE_KERNEL_XZ=3Dy
> CONFIG_HAVE_KERNEL_LZO=3Dy
> CONFIG_HAVE_KERNEL_LZ4=3Dy
> CONFIG_KERNEL_GZIP=3Dy
> # CONFIG_KERNEL_BZIP2 is not set
> # CONFIG_KERNEL_LZMA is not set
> # CONFIG_KERNEL_XZ is not set
> # CONFIG_KERNEL_LZO is not set
> # CONFIG_KERNEL_LZ4 is not set
> CONFIG_DEFAULT_HOSTNAME=3D"(none)"
> CONFIG_SWAP=3Dy
> CONFIG_SYSVIPC=3Dy
> CONFIG_SYSVIPC_SYSCTL=3Dy
> CONFIG_POSIX_MQUEUE=3Dy
> CONFIG_POSIX_MQUEUE_SYSCTL=3Dy
> CONFIG_CROSS_MEMORY_ATTACH=3Dy
> CONFIG_FHANDLE=3Dy
> # CONFIG_USELIB is not set
> # CONFIG_AUDIT is not set
> CONFIG_HAVE_ARCH_AUDITSYSCALL=3Dy
>
> #
> # IRQ subsystem
> #
> CONFIG_GENERIC_IRQ_PROBE=3Dy
> CONFIG_GENERIC_IRQ_SHOW=3Dy
> CONFIG_GENERIC_PENDING_IRQ=3Dy
> CONFIG_IRQ_DOMAIN=3Dy
> CONFIG_IRQ_DOMAIN_HIERARCHY=3Dy
> CONFIG_GENERIC_MSI_IRQ=3Dy
> CONFIG_GENERIC_MSI_IRQ_DOMAIN=3Dy
> # CONFIG_IRQ_DOMAIN_DEBUG is not set
> CONFIG_IRQ_FORCED_THREADING=3Dy
> CONFIG_SPARSE_IRQ=3Dy
> CONFIG_CLOCKSOURCE_WATCHDOG=3Dy
> CONFIG_ARCH_CLOCKSOURCE_DATA=3Dy
> CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=3Dy
> CONFIG_GENERIC_TIME_VSYSCALL=3Dy
> CONFIG_GENERIC_CLOCKEVENTS=3Dy
> CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=3Dy
> CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=3Dy
> CONFIG_GENERIC_CMOS_UPDATE=3Dy
>
> #
> # Timers subsystem
> #
> CONFIG_TICK_ONESHOT=3Dy
> CONFIG_NO_HZ_COMMON=3Dy
> # CONFIG_HZ_PERIODIC is not set
> CONFIG_NO_HZ_IDLE=3Dy
> # CONFIG_NO_HZ_FULL is not set
> # CONFIG_NO_HZ is not set
> CONFIG_HIGH_RES_TIMERS=3Dy
>
> #
> # CPU/Task time and stats accounting
> #
> CONFIG_TICK_CPU_ACCOUNTING=3Dy
> # CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
> # CONFIG_IRQ_TIME_ACCOUNTING is not set
> CONFIG_BSD_PROCESS_ACCT=3Dy
> CONFIG_BSD_PROCESS_ACCT_V3=3Dy
> CONFIG_TASKSTATS=3Dy
> CONFIG_TASK_DELAY_ACCT=3Dy
> CONFIG_TASK_XACCT=3Dy
> CONFIG_TASK_IO_ACCOUNTING=3Dy
>
> #
> # RCU Subsystem
> #
> CONFIG_PREEMPT_RCU=3Dy
> # CONFIG_RCU_EXPERT is not set
> CONFIG_SRCU=3Dy
> CONFIG_TREE_SRCU=3Dy
> CONFIG_TASKS_RCU=3Dy
> CONFIG_RCU_STALL_COMMON=3Dy
> CONFIG_RCU_NEED_SEGCBLIST=3Dy
> # CONFIG_TREE_RCU_TRACE is not set
> CONFIG_BUILD_BIN2C=3Dy
> CONFIG_IKCONFIG=3Dy
> CONFIG_IKCONFIG_PROC=3Dy
> CONFIG_LOG_BUF_SHIFT=3D19
> CONFIG_LOG_CPU_MAX_BUF_SHIFT=3D12
> CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=3D13
> CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=3Dy
> CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=3Dy
> CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=3Dy
> CONFIG_ARCH_SUPPORTS_INT128=3Dy
> CONFIG_NUMA_BALANCING=3Dy
> CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=3Dy
> CONFIG_CGROUPS=3Dy
> CONFIG_PAGE_COUNTER=3Dy
> CONFIG_MEMCG=3Dy
> CONFIG_MEMCG_SWAP=3Dy
> CONFIG_MEMCG_SWAP_ENABLED=3Dy
> CONFIG_BLK_CGROUP=3Dy
> # CONFIG_DEBUG_BLK_CGROUP is not set
> CONFIG_CGROUP_WRITEBACK=3Dy
> CONFIG_CGROUP_SCHED=3Dy
> CONFIG_FAIR_GROUP_SCHED=3Dy
> CONFIG_CFS_BANDWIDTH=3Dy
> # CONFIG_RT_GROUP_SCHED is not set
> CONFIG_CGROUP_PIDS=3Dy
> # CONFIG_CGROUP_RDMA is not set
> CONFIG_CGROUP_FREEZER=3Dy
> # CONFIG_CGROUP_HUGETLB is not set
> CONFIG_CPUSETS=3Dy
> CONFIG_PROC_PID_CPUSET=3Dy
> CONFIG_CGROUP_DEVICE=3Dy
> CONFIG_CGROUP_CPUACCT=3Dy
> CONFIG_CGROUP_PERF=3Dy
> # CONFIG_CGROUP_BPF is not set
> # CONFIG_CGROUP_DEBUG is not set
> CONFIG_SOCK_CGROUP_DATA=3Dy
> # CONFIG_CHECKPOINT_RESTORE is not set
> CONFIG_NAMESPACES=3Dy
> CONFIG_UTS_NS=3Dy
> CONFIG_IPC_NS=3Dy
> CONFIG_USER_NS=3Dy
> CONFIG_PID_NS=3Dy
> CONFIG_NET_NS=3Dy
> CONFIG_SCHED_AUTOGROUP=3Dy
> # CONFIG_SYSFS_DEPRECATED is not set
> CONFIG_RELAY=3Dy
> CONFIG_BLK_DEV_INITRD=3Dy
> CONFIG_INITRAMFS_SOURCE=3D""
> CONFIG_RD_GZIP=3Dy
> CONFIG_RD_BZIP2=3Dy
> CONFIG_RD_LZMA=3Dy
> CONFIG_RD_XZ=3Dy
> CONFIG_RD_LZO=3Dy
> CONFIG_RD_LZ4=3Dy
> CONFIG_INITRAMFS_COMPRESSION=3D".gz"
> CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=3Dy
> # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> CONFIG_SYSCTL=3Dy
> CONFIG_ANON_INODES=3Dy
> CONFIG_HAVE_UID16=3Dy
> CONFIG_SYSCTL_EXCEPTION_TRACE=3Dy
> CONFIG_HAVE_PCSPKR_PLATFORM=3Dy
> CONFIG_BPF=3Dy
> # CONFIG_EXPERT is not set
> CONFIG_UID16=3Dy
> CONFIG_MULTIUSER=3Dy
> CONFIG_SGETMASK_SYSCALL=3Dy
> CONFIG_SYSFS_SYSCALL=3Dy
> # CONFIG_SYSCTL_SYSCALL is not set
> CONFIG_POSIX_TIMERS=3Dy
> CONFIG_KALLSYMS=3Dy
> # CONFIG_KALLSYMS_ALL is not set
> CONFIG_KALLSYMS_ABSOLUTE_PERCPU=3Dy
> CONFIG_KALLSYMS_BASE_RELATIVE=3Dy
> CONFIG_PRINTK=3Dy
> CONFIG_PRINTK_NMI=3Dy
> CONFIG_BUG=3Dy
> CONFIG_ELF_CORE=3Dy
> CONFIG_PCSPKR_PLATFORM=3Dy
> CONFIG_BASE_FULL=3Dy
> CONFIG_FUTEX=3Dy
> CONFIG_EPOLL=3Dy
> CONFIG_SIGNALFD=3Dy
> CONFIG_TIMERFD=3Dy
> CONFIG_EVENTFD=3Dy
> CONFIG_BPF_SYSCALL=3Dy
> CONFIG_SHMEM=3Dy
> CONFIG_AIO=3Dy
> CONFIG_ADVISE_SYSCALLS=3Dy
> CONFIG_USERFAULTFD=3Dy
> CONFIG_PCI_QUIRKS=3Dy
> CONFIG_MEMBARRIER=3Dy
> # CONFIG_EMBEDDED is not set
> CONFIG_HAVE_PERF_EVENTS=3Dy
> # CONFIG_PC104 is not set
>
> #
> # Kernel Performance Events And Counters
> #
> CONFIG_PERF_EVENTS=3Dy
> # CONFIG_DEBUG_PERF_USE_VMALLOC is not set
> CONFIG_VM_EVENT_COUNTERS=3Dy
> CONFIG_SLUB_DEBUG=3Dy
> # CONFIG_SLUB_MEMCG_SYSFS_ON is not set
> # CONFIG_COMPAT_BRK is not set
> # CONFIG_SLAB is not set
> CONFIG_SLUB=3Dy
> CONFIG_SLAB_FREELIST_RANDOM=3Dy
> CONFIG_SLUB_CPU_PARTIAL=3Dy
> # CONFIG_SYSTEM_DATA_VERIFICATION is not set
> CONFIG_PROFILING=3Dy
> CONFIG_TRACEPOINTS=3Dy
> CONFIG_CRASH_CORE=3Dy
> CONFIG_KEXEC_CORE=3Dy
> CONFIG_OPROFILE=3Dm
> # CONFIG_OPROFILE_EVENT_MULTIPLEX is not set
> CONFIG_HAVE_OPROFILE=3Dy
> CONFIG_OPROFILE_NMI_TIMER=3Dy
> CONFIG_KPROBES=3Dy
> CONFIG_JUMP_LABEL=3Dy
> # CONFIG_STATIC_KEYS_SELFTEST is not set
> CONFIG_KPROBES_ON_FTRACE=3Dy
> CONFIG_UPROBES=3Dy
> # CONFIG_HAVE_64BIT_ALIGNED_ACCESS is not set
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=3Dy
> CONFIG_ARCH_USE_BUILTIN_BSWAP=3Dy
> CONFIG_KRETPROBES=3Dy
> CONFIG_USER_RETURN_NOTIFIER=3Dy
> CONFIG_HAVE_IOREMAP_PROT=3Dy
> CONFIG_HAVE_KPROBES=3Dy
> CONFIG_HAVE_KRETPROBES=3Dy
> CONFIG_HAVE_OPTPROBES=3Dy
> CONFIG_HAVE_KPROBES_ON_FTRACE=3Dy
> CONFIG_HAVE_NMI=3Dy
> CONFIG_HAVE_ARCH_TRACEHOOK=3Dy
> CONFIG_HAVE_DMA_CONTIGUOUS=3Dy
> CONFIG_GENERIC_SMP_IDLE_THREAD=3Dy
> CONFIG_ARCH_HAS_SET_MEMORY=3Dy
> CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=3Dy
> CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=3Dy
> CONFIG_HAVE_CLK=3Dy
> CONFIG_HAVE_DMA_API_DEBUG=3Dy
> CONFIG_HAVE_HW_BREAKPOINT=3Dy
> CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=3Dy
> CONFIG_HAVE_USER_RETURN_NOTIFIER=3Dy
> CONFIG_HAVE_PERF_EVENTS_NMI=3Dy
> CONFIG_HAVE_PERF_REGS=3Dy
> CONFIG_HAVE_PERF_USER_STACK_DUMP=3Dy
> CONFIG_HAVE_ARCH_JUMP_LABEL=3Dy
> CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=3Dy
> CONFIG_HAVE_ALIGNED_STRUCT_PAGE=3Dy
> CONFIG_HAVE_CMPXCHG_LOCAL=3Dy
> CONFIG_HAVE_CMPXCHG_DOUBLE=3Dy
> CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=3Dy
> CONFIG_ARCH_WANT_OLD_COMPAT_IPC=3Dy
> CONFIG_HAVE_ARCH_SECCOMP_FILTER=3Dy
> CONFIG_SECCOMP_FILTER=3Dy
> CONFIG_HAVE_GCC_PLUGINS=3Dy
> # CONFIG_GCC_PLUGINS is not set
> CONFIG_HAVE_CC_STACKPROTECTOR=3Dy
> CONFIG_CC_STACKPROTECTOR=3Dy
> # CONFIG_CC_STACKPROTECTOR_NONE is not set
> # CONFIG_CC_STACKPROTECTOR_REGULAR is not set
> CONFIG_CC_STACKPROTECTOR_STRONG=3Dy
> CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=3Dy
> CONFIG_HAVE_CONTEXT_TRACKING=3Dy
> CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=3Dy
> CONFIG_HAVE_IRQ_TIME_ACCOUNTING=3Dy
> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=3Dy
> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=3Dy
> CONFIG_HAVE_ARCH_HUGE_VMAP=3Dy
> CONFIG_HAVE_ARCH_SOFT_DIRTY=3Dy
> CONFIG_MODULES_USE_ELF_RELA=3Dy
> CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=3Dy
> CONFIG_ARCH_HAS_ELF_RANDOMIZE=3Dy
> CONFIG_HAVE_ARCH_MMAP_RND_BITS=3Dy
> CONFIG_HAVE_EXIT_THREAD=3Dy
> CONFIG_ARCH_MMAP_RND_BITS=3D28
> CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=3Dy
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS=3D8
> CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=3Dy
> CONFIG_HAVE_COPY_THREAD_TLS=3Dy
> CONFIG_HAVE_STACK_VALIDATION=3Dy
> CONFIG_HAVE_RELIABLE_STACKTRACE=3Dy
> # CONFIG_HAVE_ARCH_HASH is not set
> # CONFIG_ISA_BUS_API is not set
> CONFIG_OLD_SIGSUSPEND3=3Dy
> CONFIG_COMPAT_OLD_SIGACTION=3Dy
> # CONFIG_CPU_NO_EFFICIENT_FFS is not set
> CONFIG_HAVE_ARCH_VMAP_STACK=3Dy
> CONFIG_VMAP_STACK=3Dy
> # CONFIG_ARCH_OPTIONAL_KERNEL_RWX is not set
> # CONFIG_ARCH_OPTIONAL_KERNEL_RWX_DEFAULT is not set
> CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=3Dy
> CONFIG_STRICT_KERNEL_RWX=3Dy
> CONFIG_ARCH_HAS_STRICT_MODULE_RWX=3Dy
> CONFIG_STRICT_MODULE_RWX=3Dy
>
> #
> # GCOV-based kernel profiling
> #
> # CONFIG_GCOV_KERNEL is not set
> CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=3Dy
> # CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
> CONFIG_SLABINFO=3Dy
> CONFIG_RT_MUTEXES=3Dy
> CONFIG_BASE_SMALL=3D0
> CONFIG_MODULES=3Dy
> CONFIG_MODULE_FORCE_LOAD=3Dy
> CONFIG_MODULE_UNLOAD=3Dy
> CONFIG_MODULE_FORCE_UNLOAD=3Dy
> CONFIG_MODVERSIONS=3Dy
> # CONFIG_MODULE_SRCVERSION_ALL is not set
> # CONFIG_MODULE_SIG is not set
> CONFIG_MODULE_COMPRESS=3Dy
> CONFIG_MODULE_COMPRESS_GZIP=3Dy
> # CONFIG_MODULE_COMPRESS_XZ is not set
> CONFIG_MODULES_TREE_LOOKUP=3Dy
> CONFIG_BLOCK=3Dy
> CONFIG_BLK_SCSI_REQUEST=3Dy
> CONFIG_BLK_DEV_BSG=3Dy
> CONFIG_BLK_DEV_BSGLIB=3Dy
> CONFIG_BLK_DEV_INTEGRITY=3Dy
> # CONFIG_BLK_DEV_ZONED is not set
> CONFIG_BLK_DEV_THROTTLING=3Dy
> # CONFIG_BLK_DEV_THROTTLING_LOW is not set
> # CONFIG_BLK_CMDLINE_PARSER is not set
> # CONFIG_BLK_WBT is not set
> CONFIG_BLK_DEBUG_FS=3Dy
> # CONFIG_BLK_SED_OPAL is not set
>
> #
> # Partition Types
> #
> CONFIG_PARTITION_ADVANCED=3Dy
> # CONFIG_ACORN_PARTITION is not set
> CONFIG_AIX_PARTITION=3Dy
> # CONFIG_OSF_PARTITION is not set
> # CONFIG_AMIGA_PARTITION is not set
> # CONFIG_ATARI_PARTITION is not set
> CONFIG_MAC_PARTITION=3Dy
> CONFIG_MSDOS_PARTITION=3Dy
> CONFIG_BSD_DISKLABEL=3Dy
> CONFIG_MINIX_SUBPARTITION=3Dy
> CONFIG_SOLARIS_X86_PARTITION=3Dy
> # CONFIG_UNIXWARE_DISKLABEL is not set
> CONFIG_LDM_PARTITION=3Dy
> # CONFIG_LDM_DEBUG is not set
> # CONFIG_SGI_PARTITION is not set
> # CONFIG_ULTRIX_PARTITION is not set
> # CONFIG_SUN_PARTITION is not set
> CONFIG_KARMA_PARTITION=3Dy
> CONFIG_EFI_PARTITION=3Dy
> # CONFIG_SYSV68_PARTITION is not set
> # CONFIG_CMDLINE_PARTITION is not set
> CONFIG_BLOCK_COMPAT=3Dy
> CONFIG_BLK_MQ_PCI=3Dy
> CONFIG_BLK_MQ_VIRTIO=3Dy
>
> #
> # IO Schedulers
> #
> CONFIG_IOSCHED_NOOP=3Dy
> CONFIG_IOSCHED_DEADLINE=3Dy
> CONFIG_IOSCHED_CFQ=3Dy
> CONFIG_CFQ_GROUP_IOSCHED=3Dy
> # CONFIG_DEFAULT_DEADLINE is not set
> CONFIG_DEFAULT_CFQ=3Dy
> # CONFIG_DEFAULT_NOOP is not set
> CONFIG_DEFAULT_IOSCHED=3D"cfq"
> CONFIG_MQ_IOSCHED_DEADLINE=3Dy
> CONFIG_MQ_IOSCHED_KYBER=3Dy
> # CONFIG_IOSCHED_BFQ is not set
> CONFIG_PREEMPT_NOTIFIERS=3Dy
> CONFIG_PADATA=3Dy
> CONFIG_ASN1=3Dm
> CONFIG_UNINLINE_SPIN_UNLOCK=3Dy
> CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=3Dy
> CONFIG_MUTEX_SPIN_ON_OWNER=3Dy
> CONFIG_RWSEM_SPIN_ON_OWNER=3Dy
> CONFIG_LOCK_SPIN_ON_OWNER=3Dy
> CONFIG_ARCH_USE_QUEUED_SPINLOCKS=3Dy
> CONFIG_QUEUED_SPINLOCKS=3Dy
> CONFIG_ARCH_USE_QUEUED_RWLOCKS=3Dy
> CONFIG_QUEUED_RWLOCKS=3Dy
> CONFIG_FREEZER=3Dy
>
> #
> # Processor type and features
> #
> CONFIG_ZONE_DMA=3Dy
> CONFIG_SMP=3Dy
> CONFIG_X86_FEATURE_NAMES=3Dy
> CONFIG_X86_FAST_FEATURE_TESTS=3Dy
> CONFIG_X86_X2APIC=3Dy
> CONFIG_X86_MPPARSE=3Dy
> # CONFIG_GOLDFISH is not set
> # CONFIG_INTEL_RDT_A is not set
> # CONFIG_X86_EXTENDED_PLATFORM is not set
> CONFIG_X86_INTEL_LPSS=3Dy
> CONFIG_X86_AMD_PLATFORM_DEVICE=3Dy
> CONFIG_IOSF_MBI=3Dy
> # CONFIG_IOSF_MBI_DEBUG is not set
> CONFIG_X86_SUPPORTS_MEMORY_FAILURE=3Dy
> CONFIG_SCHED_OMIT_FRAME_POINTER=3Dy
> CONFIG_HYPERVISOR_GUEST=3Dy
> CONFIG_PARAVIRT=3Dy
> # CONFIG_PARAVIRT_DEBUG is not set
> CONFIG_PARAVIRT_SPINLOCKS=3Dy
> # CONFIG_QUEUED_LOCK_STAT is not set
> CONFIG_XEN=3Dy
> CONFIG_XEN_PV=3Dy
> CONFIG_XEN_PV_SMP=3Dy
> CONFIG_XEN_DOM0=3Dy
> CONFIG_XEN_PVHVM=3Dy
> CONFIG_XEN_PVHVM_SMP=3Dy
> CONFIG_XEN_512GB=3Dy
> CONFIG_XEN_SAVE_RESTORE=3Dy
> # CONFIG_XEN_DEBUG_FS is not set
> CONFIG_XEN_PVH=3Dy
> CONFIG_KVM_GUEST=3Dy
> # CONFIG_KVM_DEBUG_FS is not set
> CONFIG_PARAVIRT_TIME_ACCOUNTING=3Dy
> CONFIG_PARAVIRT_CLOCK=3Dy
> CONFIG_NO_BOOTMEM=3Dy
> # CONFIG_MK8 is not set
> # CONFIG_MPSC is not set
> # CONFIG_MCORE2 is not set
> # CONFIG_MATOM is not set
> CONFIG_GENERIC_CPU=3Dy
> CONFIG_X86_INTERNODE_CACHE_SHIFT=3D6
> CONFIG_X86_L1_CACHE_SHIFT=3D6
> CONFIG_X86_TSC=3Dy
> CONFIG_X86_CMPXCHG64=3Dy
> CONFIG_X86_CMOV=3Dy
> CONFIG_X86_MINIMUM_CPU_FAMILY=3D64
> CONFIG_X86_DEBUGCTLMSR=3Dy
> CONFIG_CPU_SUP_INTEL=3Dy
> CONFIG_CPU_SUP_AMD=3Dy
> CONFIG_CPU_SUP_CENTAUR=3Dy
> CONFIG_HPET_TIMER=3Dy
> CONFIG_HPET_EMULATE_RTC=3Dy
> CONFIG_DMI=3Dy
> CONFIG_GART_IOMMU=3Dy
> CONFIG_CALGARY_IOMMU=3Dy
> CONFIG_CALGARY_IOMMU_ENABLED_BY_DEFAULT=3Dy
> CONFIG_SWIOTLB=3Dy
> CONFIG_IOMMU_HELPER=3Dy
> # CONFIG_MAXSMP is not set
> CONFIG_NR_CPUS=3D128
> CONFIG_SCHED_SMT=3Dy
> CONFIG_SCHED_MC=3Dy
> CONFIG_SCHED_MC_PRIO=3Dy
> # CONFIG_PREEMPT_NONE is not set
> # CONFIG_PREEMPT_VOLUNTARY is not set
> CONFIG_PREEMPT=3Dy
> CONFIG_PREEMPT_COUNT=3Dy
> CONFIG_X86_LOCAL_APIC=3Dy
> CONFIG_X86_IO_APIC=3Dy
> CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=3Dy
> CONFIG_X86_MCE=3Dy
> # CONFIG_X86_MCELOG_LEGACY is not set
> CONFIG_X86_MCE_INTEL=3Dy
> CONFIG_X86_MCE_AMD=3Dy
> CONFIG_X86_MCE_THRESHOLD=3Dy
> CONFIG_X86_THERMAL_VECTOR=3Dy
>
> #
> # Performance monitoring
> #
> CONFIG_PERF_EVENTS_INTEL_UNCORE=3Dy
> CONFIG_PERF_EVENTS_INTEL_RAPL=3Dm
> CONFIG_PERF_EVENTS_INTEL_CSTATE=3Dm
> CONFIG_PERF_EVENTS_AMD_POWER=3Dm
> # CONFIG_VM86 is not set
> CONFIG_X86_16BIT=3Dy
> CONFIG_X86_ESPFIX64=3Dy
> CONFIG_X86_VSYSCALL_EMULATION=3Dy
> CONFIG_I8K=3Dm
> CONFIG_MICROCODE=3Dy
> CONFIG_MICROCODE_INTEL=3Dy
> CONFIG_MICROCODE_AMD=3Dy
> CONFIG_MICROCODE_OLD_INTERFACE=3Dy
> CONFIG_X86_MSR=3Dm
> CONFIG_X86_CPUID=3Dm
> CONFIG_ARCH_PHYS_ADDR_T_64BIT=3Dy
> CONFIG_ARCH_DMA_ADDR_T_64BIT=3Dy
> CONFIG_X86_DIRECT_GBPAGES=3Dy
> CONFIG_NUMA=3Dy
> CONFIG_AMD_NUMA=3Dy
> CONFIG_X86_64_ACPI_NUMA=3Dy
> CONFIG_NODES_SPAN_OTHER_NODES=3Dy
> # CONFIG_NUMA_EMU is not set
> CONFIG_NODES_SHIFT=3D6
> CONFIG_ARCH_SPARSEMEM_ENABLE=3Dy
> CONFIG_ARCH_SPARSEMEM_DEFAULT=3Dy
> CONFIG_ARCH_SELECT_MEMORY_MODEL=3Dy
> CONFIG_ARCH_MEMORY_PROBE=3Dy
> CONFIG_ARCH_PROC_KCORE_TEXT=3Dy
> CONFIG_ILLEGAL_POINTER_VALUE=3D0xdead000000000000
> CONFIG_SELECT_MEMORY_MODEL=3Dy
> CONFIG_SPARSEMEM_MANUAL=3Dy
> CONFIG_SPARSEMEM=3Dy
> CONFIG_NEED_MULTIPLE_NODES=3Dy
> CONFIG_HAVE_MEMORY_PRESENT=3Dy
> CONFIG_SPARSEMEM_EXTREME=3Dy
> CONFIG_SPARSEMEM_VMEMMAP_ENABLE=3Dy
> CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER=3Dy
> CONFIG_SPARSEMEM_VMEMMAP=3Dy
> CONFIG_HAVE_MEMBLOCK=3Dy
> CONFIG_HAVE_MEMBLOCK_NODE_MAP=3Dy
> CONFIG_ARCH_DISCARD_MEMBLOCK=3Dy
> CONFIG_MEMORY_ISOLATION=3Dy
> # CONFIG_MOVABLE_NODE is not set
> CONFIG_HAVE_BOOTMEM_INFO_NODE=3Dy
> CONFIG_MEMORY_HOTPLUG=3Dy
> CONFIG_MEMORY_HOTPLUG_SPARSE=3Dy
> CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=3Dy
> CONFIG_MEMORY_HOTREMOVE=3Dy
> CONFIG_SPLIT_PTLOCK_CPUS=3D4
> CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=3Dy
> CONFIG_MEMORY_BALLOON=3Dy
> CONFIG_BALLOON_COMPACTION=3Dy
> CONFIG_COMPACTION=3Dy
> CONFIG_MIGRATION=3Dy
> CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=3Dy
> CONFIG_PHYS_ADDR_T_64BIT=3Dy
> CONFIG_BOUNCE=3Dy
> CONFIG_VIRT_TO_BUS=3Dy
> CONFIG_MMU_NOTIFIER=3Dy
> CONFIG_KSM=3Dy
> CONFIG_DEFAULT_MMAP_MIN_ADDR=3D65536
> CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=3Dy
> CONFIG_MEMORY_FAILURE=3Dy
> CONFIG_HWPOISON_INJECT=3Dm
> CONFIG_TRANSPARENT_HUGEPAGE=3Dy
> CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=3Dy
> # CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
> CONFIG_TRANSPARENT_HUGE_PAGECACHE=3Dy
> CONFIG_CLEANCACHE=3Dy
> CONFIG_FRONTSWAP=3Dy
> # CONFIG_CMA is not set
> CONFIG_ZSWAP=3Dy
> CONFIG_ZPOOL=3Dy
> CONFIG_ZBUD=3Dy
> CONFIG_Z3FOLD=3Dy
> CONFIG_ZSMALLOC=3Dy
> # CONFIG_PGTABLE_MAPPING is not set
> # CONFIG_ZSMALLOC_STAT is not set
> CONFIG_GENERIC_EARLY_IOREMAP=3Dy
> CONFIG_ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT=3Dy
> # CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
> # CONFIG_IDLE_PAGE_TRACKING is not set
> CONFIG_ZONE_DEVICE=3Dy
> CONFIG_FRAME_VECTOR=3Dy
> CONFIG_ARCH_USES_HIGH_VMA_FLAGS=3Dy
> CONFIG_ARCH_HAS_PKEYS=3Dy
> CONFIG_X86_PMEM_LEGACY_DEVICE=3Dy
> CONFIG_X86_PMEM_LEGACY=3Dy
> CONFIG_X86_CHECK_BIOS_CORRUPTION=3Dy
> CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=3Dy
> CONFIG_X86_RESERVE_LOW=3D64
> CONFIG_MTRR=3Dy
> CONFIG_MTRR_SANITIZER=3Dy
> CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=3D0
> CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=3D1
> CONFIG_X86_PAT=3Dy
> CONFIG_ARCH_USES_PG_UNCACHED=3Dy
> CONFIG_ARCH_RANDOM=3Dy
> CONFIG_X86_SMAP=3Dy
> CONFIG_X86_INTEL_MPX=3Dy
> CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=3Dy
> CONFIG_EFI=3Dy
> CONFIG_EFI_STUB=3Dy
> CONFIG_EFI_MIXED=3Dy
> CONFIG_SECCOMP=3Dy
> # CONFIG_HZ_100 is not set
> # CONFIG_HZ_250 is not set
> CONFIG_HZ_300=3Dy
> # CONFIG_HZ_1000 is not set
> CONFIG_HZ=3D300
> CONFIG_SCHED_HRTICK=3Dy
> CONFIG_KEXEC=3Dy
> CONFIG_CRASH_DUMP=3Dy
> CONFIG_KEXEC_JUMP=3Dy
> CONFIG_PHYSICAL_START=3D0x1000000
> CONFIG_RELOCATABLE=3Dy
> # CONFIG_RANDOMIZE_BASE is not set
> CONFIG_PHYSICAL_ALIGN=3D0x1000000
> CONFIG_HOTPLUG_CPU=3Dy
> # CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
> # CONFIG_DEBUG_HOTPLUG_CPU0 is not set
> # CONFIG_COMPAT_VDSO is not set
> # CONFIG_LEGACY_VSYSCALL_NATIVE is not set
> CONFIG_LEGACY_VSYSCALL_EMULATE=3Dy
> # CONFIG_LEGACY_VSYSCALL_NONE is not set
> # CONFIG_CMDLINE_BOOL is not set
> CONFIG_MODIFY_LDT_SYSCALL=3Dy
> CONFIG_HAVE_LIVEPATCH=3Dy
> CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=3Dy
> CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=3Dy
> CONFIG_USE_PERCPU_NUMA_NODE_ID=3Dy
>
> #
> # Power management and ACPI options
> #
> CONFIG_ARCH_HIBERNATION_HEADER=3Dy
> CONFIG_SUSPEND=3Dy
> CONFIG_SUSPEND_FREEZER=3Dy
> CONFIG_HIBERNATE_CALLBACKS=3Dy
> CONFIG_HIBERNATION=3Dy
> CONFIG_PM_STD_PARTITION=3D""
> CONFIG_PM_SLEEP=3Dy
> CONFIG_PM_SLEEP_SMP=3Dy
> CONFIG_PM_AUTOSLEEP=3Dy
> CONFIG_PM_WAKELOCKS=3Dy
> CONFIG_PM_WAKELOCKS_LIMIT=3D100
> CONFIG_PM_WAKELOCKS_GC=3Dy
> CONFIG_PM=3Dy
> CONFIG_PM_DEBUG=3Dy
> CONFIG_PM_ADVANCED_DEBUG=3Dy
> # CONFIG_PM_TEST_SUSPEND is not set
> CONFIG_PM_SLEEP_DEBUG=3Dy
> CONFIG_PM_TRACE=3Dy
> CONFIG_PM_TRACE_RTC=3Dy
> CONFIG_PM_CLK=3Dy
> CONFIG_PM_GENERIC_DOMAINS=3Dy
> CONFIG_WQ_POWER_EFFICIENT_DEFAULT=3Dy
> CONFIG_PM_GENERIC_DOMAINS_SLEEP=3Dy
> CONFIG_ACPI=3Dy
> CONFIG_ACPI_LEGACY_TABLES_LOOKUP=3Dy
> CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=3Dy
> CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=3Dy
> # CONFIG_ACPI_DEBUGGER is not set
> CONFIG_ACPI_SLEEP=3Dy
> # CONFIG_ACPI_PROCFS_POWER is not set
> # CONFIG_ACPI_REV_OVERRIDE_POSSIBLE is not set
> CONFIG_ACPI_EC_DEBUGFS=3Dm
> CONFIG_ACPI_AC=3Dm
> CONFIG_ACPI_BATTERY=3Dm
> CONFIG_ACPI_BUTTON=3Dm
> CONFIG_ACPI_VIDEO=3Dm
> CONFIG_ACPI_FAN=3Dm
> CONFIG_ACPI_DOCK=3Dy
> CONFIG_ACPI_CPU_FREQ_PSS=3Dy
> CONFIG_ACPI_PROCESSOR_CSTATE=3Dy
> CONFIG_ACPI_PROCESSOR_IDLE=3Dy
> CONFIG_ACPI_CPPC_LIB=3Dy
> CONFIG_ACPI_PROCESSOR=3Dy
> CONFIG_ACPI_IPMI=3Dm
> CONFIG_ACPI_HOTPLUG_CPU=3Dy
> CONFIG_ACPI_PROCESSOR_AGGREGATOR=3Dm
> CONFIG_ACPI_THERMAL=3Dm
> CONFIG_ACPI_NUMA=3Dy
> # CONFIG_ACPI_CUSTOM_DSDT is not set
> CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=3Dy
> CONFIG_ACPI_TABLE_UPGRADE=3Dy
> # CONFIG_ACPI_DEBUG is not set
> CONFIG_ACPI_PCI_SLOT=3Dy
> CONFIG_X86_PM_TIMER=3Dy
> CONFIG_ACPI_CONTAINER=3Dy
> CONFIG_ACPI_HOTPLUG_MEMORY=3Dy
> CONFIG_ACPI_HOTPLUG_IOAPIC=3Dy
> CONFIG_ACPI_SBS=3Dm
> CONFIG_ACPI_HED=3Dy
> CONFIG_ACPI_CUSTOM_METHOD=3Dm
> CONFIG_ACPI_BGRT=3Dy
> # CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
> CONFIG_ACPI_NFIT=3Dm
> CONFIG_HAVE_ACPI_APEI=3Dy
> CONFIG_HAVE_ACPI_APEI_NMI=3Dy
> CONFIG_ACPI_APEI=3Dy
> CONFIG_ACPI_APEI_GHES=3Dy
> CONFIG_ACPI_APEI_PCIEAER=3Dy
> CONFIG_ACPI_APEI_MEMORY_FAILURE=3Dy
> CONFIG_ACPI_APEI_EINJ=3Dm
> CONFIG_ACPI_APEI_ERST_DEBUG=3Dm
> CONFIG_DPTF_POWER=3Dm
> CONFIG_ACPI_WATCHDOG=3Dy
> CONFIG_ACPI_EXTLOG=3Dm
> CONFIG_PMIC_OPREGION=3Dy
> CONFIG_CRC_PMIC_OPREGION=3Dy
> CONFIG_ACPI_CONFIGFS=3Dm
> CONFIG_SFI=3Dy
>
> #
> # CPU Frequency scaling
> #
> CONFIG_CPU_FREQ=3Dy
> CONFIG_CPU_FREQ_GOV_ATTR_SET=3Dy
> CONFIG_CPU_FREQ_GOV_COMMON=3Dy
> CONFIG_CPU_FREQ_STAT=3Dy
> # CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
> CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL=3Dy
> CONFIG_CPU_FREQ_GOV_PERFORMANCE=3Dy
> CONFIG_CPU_FREQ_GOV_POWERSAVE=3Dm
> CONFIG_CPU_FREQ_GOV_USERSPACE=3Dm
> CONFIG_CPU_FREQ_GOV_ONDEMAND=3Dm
> CONFIG_CPU_FREQ_GOV_CONSERVATIVE=3Dm
> CONFIG_CPU_FREQ_GOV_SCHEDUTIL=3Dy
>
> #
> # CPU frequency scaling drivers
> #
> CONFIG_X86_INTEL_PSTATE=3Dy
> CONFIG_X86_PCC_CPUFREQ=3Dm
> CONFIG_X86_ACPI_CPUFREQ=3Dm
> CONFIG_X86_ACPI_CPUFREQ_CPB=3Dy
> CONFIG_X86_POWERNOW_K8=3Dm
> CONFIG_X86_AMD_FREQ_SENSITIVITY=3Dm
> # CONFIG_X86_SPEEDSTEP_CENTRINO is not set
> CONFIG_X86_P4_CLOCKMOD=3Dm
>
> #
> # shared options
> #
> CONFIG_X86_SPEEDSTEP_LIB=3Dm
>
> #
> # CPU Idle
> #
> CONFIG_CPU_IDLE=3Dy
> CONFIG_CPU_IDLE_GOV_LADDER=3Dy
> CONFIG_CPU_IDLE_GOV_MENU=3Dy
> # CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set
> CONFIG_INTEL_IDLE=3Dy
>
> #
> # Bus options (PCI etc.)
> #
> CONFIG_PCI=3Dy
> CONFIG_PCI_DIRECT=3Dy
> CONFIG_PCI_MMCONFIG=3Dy
> CONFIG_PCI_XEN=3Dy
> CONFIG_PCI_DOMAINS=3Dy
> CONFIG_PCIEPORTBUS=3Dy
> CONFIG_HOTPLUG_PCI_PCIE=3Dy
> CONFIG_PCIEAER=3Dy
> # CONFIG_PCIE_ECRC is not set
> # CONFIG_PCIEAER_INJECT is not set
> CONFIG_PCIEASPM=3Dy
> # CONFIG_PCIEASPM_DEBUG is not set
> CONFIG_PCIEASPM_DEFAULT=3Dy
> # CONFIG_PCIEASPM_POWERSAVE is not set
> # CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
> # CONFIG_PCIEASPM_PERFORMANCE is not set
> CONFIG_PCIE_PME=3Dy
> CONFIG_PCIE_DPC=3Dy
> CONFIG_PCIE_PTM=3Dy
> CONFIG_PCI_BUS_ADDR_T_64BIT=3Dy
> CONFIG_PCI_MSI=3Dy
> CONFIG_PCI_MSI_IRQ_DOMAIN=3Dy
> # CONFIG_PCI_DEBUG is not set
> CONFIG_PCI_REALLOC_ENABLE_AUTO=3Dy
> CONFIG_PCI_STUB=3Dm
> CONFIG_XEN_PCIDEV_FRONTEND=3Dm
> CONFIG_HT_IRQ=3Dy
> CONFIG_PCI_ATS=3Dy
> CONFIG_PCI_IOV=3Dy
> CONFIG_PCI_PRI=3Dy
> CONFIG_PCI_PASID=3Dy
> CONFIG_PCI_LABEL=3Dy
> CONFIG_PCI_HYPERV=3Dm
> CONFIG_HOTPLUG_PCI=3Dy
> CONFIG_HOTPLUG_PCI_ACPI=3Dy
> CONFIG_HOTPLUG_PCI_ACPI_IBM=3Dm
> CONFIG_HOTPLUG_PCI_CPCI=3Dy
> CONFIG_HOTPLUG_PCI_CPCI_ZT5550=3Dm
> CONFIG_HOTPLUG_PCI_CPCI_GENERIC=3Dm
> CONFIG_HOTPLUG_PCI_SHPC=3Dm
>
> #
> # DesignWare PCI Core Support
> #
> # CONFIG_PCIE_DW_PLAT is not set
>
> #
> # PCI host controller drivers
> #
> CONFIG_VMD=3Dm
>
> #
> # PCI Endpoint
> #
> # CONFIG_PCI_ENDPOINT is not set
>
> #
> # PCI switch controller drivers
> #
> # CONFIG_PCI_SW_SWITCHTEC is not set
> CONFIG_ISA_DMA_API=3Dy
> CONFIG_AMD_NB=3Dy
> CONFIG_PCCARD=3Dm
> CONFIG_PCMCIA=3Dm
> CONFIG_PCMCIA_LOAD_CIS=3Dy
> CONFIG_CARDBUS=3Dy
>
> #
> # PC-card bridges
> #
> CONFIG_YENTA=3Dm
> CONFIG_YENTA_O2=3Dy
> CONFIG_YENTA_RICOH=3Dy
> CONFIG_YENTA_TI=3Dy
> CONFIG_YENTA_ENE_TUNE=3Dy
> CONFIG_YENTA_TOSHIBA=3Dy
> CONFIG_PD6729=3Dm
> CONFIG_I82092=3Dm
> CONFIG_PCCARD_NONSTATIC=3Dy
> # CONFIG_RAPIDIO is not set
> # CONFIG_X86_SYSFB is not set
>
> #
> # Executable file formats / Emulations
> #
> CONFIG_BINFMT_ELF=3Dy
> CONFIG_COMPAT_BINFMT_ELF=3Dy
> CONFIG_ELFCORE=3Dy
> CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=3Dy
> CONFIG_BINFMT_SCRIPT=3Dy
> # CONFIG_HAVE_AOUT is not set
> CONFIG_BINFMT_MISC=3Dy
> CONFIG_COREDUMP=3Dy
> CONFIG_IA32_EMULATION=3Dy
> # CONFIG_IA32_AOUT is not set
> # CONFIG_X86_X32 is not set
> CONFIG_COMPAT_32=3Dy
> CONFIG_COMPAT=3Dy
> CONFIG_COMPAT_FOR_U64_ALIGNMENT=3Dy
> CONFIG_SYSVIPC_COMPAT=3Dy
> CONFIG_KEYS_COMPAT=3Dy
> CONFIG_X86_DEV_DMA_OPS=3Dy
> CONFIG_NET=3Dy
> CONFIG_COMPAT_NETLINK_MESSAGES=3Dy
> CONFIG_NET_INGRESS=3Dy
> CONFIG_NET_EGRESS=3Dy
>
> #
> # Networking options
> #
> CONFIG_PACKET=3Dy
> CONFIG_PACKET_DIAG=3Dm
> CONFIG_UNIX=3Dy
> CONFIG_UNIX_DIAG=3Dm
> CONFIG_XFRM=3Dy
> CONFIG_XFRM_ALGO=3Dm
> CONFIG_XFRM_USER=3Dm
> # CONFIG_XFRM_SUB_POLICY is not set
> # CONFIG_XFRM_MIGRATE is not set
> # CONFIG_XFRM_STATISTICS is not set
> CONFIG_XFRM_IPCOMP=3Dm
> CONFIG_NET_KEY=3Dm
> # CONFIG_NET_KEY_MIGRATE is not set
> # CONFIG_SMC is not set
> CONFIG_INET=3Dy
> CONFIG_IP_MULTICAST=3Dy
> CONFIG_IP_ADVANCED_ROUTER=3Dy
> CONFIG_IP_FIB_TRIE_STATS=3Dy
> CONFIG_IP_MULTIPLE_TABLES=3Dy
> CONFIG_IP_ROUTE_MULTIPATH=3Dy
> CONFIG_IP_ROUTE_VERBOSE=3Dy
> CONFIG_IP_ROUTE_CLASSID=3Dy
> # CONFIG_IP_PNP is not set
> CONFIG_NET_IPIP=3Dm
> CONFIG_NET_IPGRE_DEMUX=3Dm
> CONFIG_NET_IP_TUNNEL=3Dm
> CONFIG_NET_IPGRE=3Dm
> # CONFIG_NET_IPGRE_BROADCAST is not set
> CONFIG_IP_MROUTE=3Dy
> CONFIG_IP_MROUTE_MULTIPLE_TABLES=3Dy
> CONFIG_IP_PIMSM_V1=3Dy
> CONFIG_IP_PIMSM_V2=3Dy
> CONFIG_SYN_COOKIES=3Dy
> CONFIG_NET_IPVTI=3Dm
> CONFIG_NET_UDP_TUNNEL=3Dm
> CONFIG_NET_FOU=3Dm
> CONFIG_NET_FOU_IP_TUNNELS=3Dy
> CONFIG_INET_AH=3Dm
> CONFIG_INET_ESP=3Dm
> # CONFIG_INET_ESP_OFFLOAD is not set
> CONFIG_INET_IPCOMP=3Dm
> CONFIG_INET_XFRM_TUNNEL=3Dm
> CONFIG_INET_TUNNEL=3Dm
> CONFIG_INET_XFRM_MODE_TRANSPORT=3Dm
> CONFIG_INET_XFRM_MODE_TUNNEL=3Dm
> CONFIG_INET_XFRM_MODE_BEET=3Dm
> CONFIG_INET_DIAG=3Dm
> CONFIG_INET_TCP_DIAG=3Dm
> CONFIG_INET_UDP_DIAG=3Dm
> # CONFIG_INET_RAW_DIAG is not set
> CONFIG_INET_DIAG_DESTROY=3Dy
> CONFIG_TCP_CONG_ADVANCED=3Dy
> CONFIG_TCP_CONG_BIC=3Dm
> CONFIG_TCP_CONG_CUBIC=3Dy
> CONFIG_TCP_CONG_WESTWOOD=3Dm
> CONFIG_TCP_CONG_HTCP=3Dm
> CONFIG_TCP_CONG_HSTCP=3Dm
> CONFIG_TCP_CONG_HYBLA=3Dm
> CONFIG_TCP_CONG_VEGAS=3Dm
> CONFIG_TCP_CONG_NV=3Dm
> CONFIG_TCP_CONG_SCALABLE=3Dm
> CONFIG_TCP_CONG_LP=3Dm
> CONFIG_TCP_CONG_VENO=3Dm
> CONFIG_TCP_CONG_YEAH=3Dm
> CONFIG_TCP_CONG_ILLINOIS=3Dm
> CONFIG_TCP_CONG_DCTCP=3Dm
> CONFIG_TCP_CONG_CDG=3Dm
> CONFIG_TCP_CONG_BBR=3Dm
> CONFIG_DEFAULT_CUBIC=3Dy
> # CONFIG_DEFAULT_RENO is not set
> CONFIG_DEFAULT_TCP_CONG=3D"cubic"
> CONFIG_TCP_MD5SIG=3Dy
> CONFIG_IPV6=3Dy
> CONFIG_IPV6_ROUTER_PREF=3Dy
> CONFIG_IPV6_ROUTE_INFO=3Dy
> CONFIG_IPV6_OPTIMISTIC_DAD=3Dy
> CONFIG_INET6_AH=3Dm
> CONFIG_INET6_ESP=3Dm
> # CONFIG_INET6_ESP_OFFLOAD is not set
> CONFIG_INET6_IPCOMP=3Dm
> CONFIG_IPV6_MIP6=3Dm
> CONFIG_IPV6_ILA=3Dm
> CONFIG_INET6_XFRM_TUNNEL=3Dm
> CONFIG_INET6_TUNNEL=3Dm
> CONFIG_INET6_XFRM_MODE_TRANSPORT=3Dm
> CONFIG_INET6_XFRM_MODE_TUNNEL=3Dm
> CONFIG_INET6_XFRM_MODE_BEET=3Dm
> CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION=3Dm
> CONFIG_IPV6_VTI=3Dm
> CONFIG_IPV6_SIT=3Dm
> CONFIG_IPV6_SIT_6RD=3Dy
> CONFIG_IPV6_NDISC_NODETYPE=3Dy
> CONFIG_IPV6_TUNNEL=3Dm
> CONFIG_IPV6_GRE=3Dm
> CONFIG_IPV6_FOU=3Dm
> CONFIG_IPV6_FOU_TUNNEL=3Dm
> CONFIG_IPV6_MULTIPLE_TABLES=3Dy
> CONFIG_IPV6_SUBTREES=3Dy
> CONFIG_IPV6_MROUTE=3Dy
> CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=3Dy
> CONFIG_IPV6_PIMSM_V2=3Dy
> # CONFIG_IPV6_SEG6_LWTUNNEL is not set
> # CONFIG_IPV6_SEG6_HMAC is not set
> CONFIG_NETLABEL=3Dy
> CONFIG_NETWORK_SECMARK=3Dy
> CONFIG_NET_PTP_CLASSIFY=3Dy
> CONFIG_NETWORK_PHY_TIMESTAMPING=3Dy
> CONFIG_NETFILTER=3Dy
> # CONFIG_NETFILTER_DEBUG is not set
> CONFIG_NETFILTER_ADVANCED=3Dy
> CONFIG_BRIDGE_NETFILTER=3Dm
>
> #
> # Core Netfilter Configuration
> #
> CONFIG_NETFILTER_INGRESS=3Dy
> CONFIG_NETFILTER_NETLINK=3Dm
> CONFIG_NETFILTER_NETLINK_ACCT=3Dm
> CONFIG_NETFILTER_NETLINK_QUEUE=3Dm
> CONFIG_NETFILTER_NETLINK_LOG=3Dm
> CONFIG_NF_CONNTRACK=3Dm
> CONFIG_NF_LOG_COMMON=3Dm
> # CONFIG_NF_LOG_NETDEV is not set
> CONFIG_NF_CONNTRACK_MARK=3Dy
> CONFIG_NF_CONNTRACK_SECMARK=3Dy
> CONFIG_NF_CONNTRACK_ZONES=3Dy
> CONFIG_NF_CONNTRACK_PROCFS=3Dy
> CONFIG_NF_CONNTRACK_EVENTS=3Dy
> CONFIG_NF_CONNTRACK_TIMEOUT=3Dy
> CONFIG_NF_CONNTRACK_TIMESTAMP=3Dy
> CONFIG_NF_CONNTRACK_LABELS=3Dy
> CONFIG_NF_CT_PROTO_DCCP=3Dy
> CONFIG_NF_CT_PROTO_GRE=3Dm
> CONFIG_NF_CT_PROTO_SCTP=3Dy
> CONFIG_NF_CT_PROTO_UDPLITE=3Dy
> CONFIG_NF_CONNTRACK_AMANDA=3Dm
> CONFIG_NF_CONNTRACK_FTP=3Dm
> CONFIG_NF_CONNTRACK_H323=3Dm
> CONFIG_NF_CONNTRACK_IRC=3Dm
> CONFIG_NF_CONNTRACK_BROADCAST=3Dm
> CONFIG_NF_CONNTRACK_NETBIOS_NS=3Dm
> CONFIG_NF_CONNTRACK_SNMP=3Dm
> CONFIG_NF_CONNTRACK_PPTP=3Dm
> CONFIG_NF_CONNTRACK_SANE=3Dm
> CONFIG_NF_CONNTRACK_SIP=3Dm
> CONFIG_NF_CONNTRACK_TFTP=3Dm
> CONFIG_NF_CT_NETLINK=3Dm
> CONFIG_NF_CT_NETLINK_TIMEOUT=3Dm
> CONFIG_NF_CT_NETLINK_HELPER=3Dm
> CONFIG_NETFILTER_NETLINK_GLUE_CT=3Dy
> CONFIG_NF_NAT=3Dm
> CONFIG_NF_NAT_NEEDED=3Dy
> CONFIG_NF_NAT_PROTO_DCCP=3Dy
> CONFIG_NF_NAT_PROTO_UDPLITE=3Dy
> CONFIG_NF_NAT_PROTO_SCTP=3Dy
> CONFIG_NF_NAT_AMANDA=3Dm
> CONFIG_NF_NAT_FTP=3Dm
> CONFIG_NF_NAT_IRC=3Dm
> CONFIG_NF_NAT_SIP=3Dm
> CONFIG_NF_NAT_TFTP=3Dm
> CONFIG_NF_NAT_REDIRECT=3Dm
> CONFIG_NETFILTER_SYNPROXY=3Dm
> CONFIG_NF_TABLES=3Dm
> CONFIG_NF_TABLES_INET=3Dm
> CONFIG_NF_TABLES_NETDEV=3Dm
> CONFIG_NFT_EXTHDR=3Dm
> CONFIG_NFT_META=3Dm
> # CONFIG_NFT_RT is not set
> CONFIG_NFT_NUMGEN=3Dm
> CONFIG_NFT_CT=3Dm
> CONFIG_NFT_SET_RBTREE=3Dm
> CONFIG_NFT_SET_HASH=3Dm
> # CONFIG_NFT_SET_BITMAP is not set
> CONFIG_NFT_COUNTER=3Dm
> CONFIG_NFT_LOG=3Dm
> CONFIG_NFT_LIMIT=3Dm
> CONFIG_NFT_MASQ=3Dm
> CONFIG_NFT_REDIR=3Dm
> CONFIG_NFT_NAT=3Dm
> # CONFIG_NFT_OBJREF is not set
> CONFIG_NFT_QUEUE=3Dm
> CONFIG_NFT_QUOTA=3Dm
> CONFIG_NFT_REJECT=3Dm
> CONFIG_NFT_REJECT_INET=3Dm
> CONFIG_NFT_COMPAT=3Dm
> CONFIG_NFT_HASH=3Dm
> CONFIG_NF_DUP_NETDEV=3Dm
> CONFIG_NFT_DUP_NETDEV=3Dm
> CONFIG_NFT_FWD_NETDEV=3Dm
> CONFIG_NETFILTER_XTABLES=3Dm
>
> #
> # Xtables combined modules
> #
> CONFIG_NETFILTER_XT_MARK=3Dm
> CONFIG_NETFILTER_XT_CONNMARK=3Dm
> CONFIG_NETFILTER_XT_SET=3Dm
>
> #
> # Xtables targets
> #
> CONFIG_NETFILTER_XT_TARGET_CHECKSUM=3Dm
> CONFIG_NETFILTER_XT_TARGET_CLASSIFY=3Dm
> CONFIG_NETFILTER_XT_TARGET_CONNMARK=3Dm
> CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=3Dm
> CONFIG_NETFILTER_XT_TARGET_CT=3Dm
> CONFIG_NETFILTER_XT_TARGET_DSCP=3Dm
> CONFIG_NETFILTER_XT_TARGET_HL=3Dm
> CONFIG_NETFILTER_XT_TARGET_HMARK=3Dm
> CONFIG_NETFILTER_XT_TARGET_IDLETIMER=3Dm
> CONFIG_NETFILTER_XT_TARGET_LED=3Dm
> CONFIG_NETFILTER_XT_TARGET_LOG=3Dm
> CONFIG_NETFILTER_XT_TARGET_MARK=3Dm
> CONFIG_NETFILTER_XT_NAT=3Dm
> CONFIG_NETFILTER_XT_TARGET_NETMAP=3Dm
> CONFIG_NETFILTER_XT_TARGET_NFLOG=3Dm
> CONFIG_NETFILTER_XT_TARGET_NFQUEUE=3Dm
> CONFIG_NETFILTER_XT_TARGET_NOTRACK=3Dm
> CONFIG_NETFILTER_XT_TARGET_RATEEST=3Dm
> CONFIG_NETFILTER_XT_TARGET_REDIRECT=3Dm
> CONFIG_NETFILTER_XT_TARGET_TEE=3Dm
> CONFIG_NETFILTER_XT_TARGET_TPROXY=3Dm
> CONFIG_NETFILTER_XT_TARGET_TRACE=3Dm
> CONFIG_NETFILTER_XT_TARGET_SECMARK=3Dm
> CONFIG_NETFILTER_XT_TARGET_TCPMSS=3Dm
> CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=3Dm
>
> #
> # Xtables matches
> #
> CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=3Dm
> CONFIG_NETFILTER_XT_MATCH_BPF=3Dm
> CONFIG_NETFILTER_XT_MATCH_CGROUP=3Dm
> CONFIG_NETFILTER_XT_MATCH_CLUSTER=3Dm
> CONFIG_NETFILTER_XT_MATCH_COMMENT=3Dm
> CONFIG_NETFILTER_XT_MATCH_CONNBYTES=3Dm
> CONFIG_NETFILTER_XT_MATCH_CONNLABEL=3Dm
> CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=3Dm
> CONFIG_NETFILTER_XT_MATCH_CONNMARK=3Dm
> CONFIG_NETFILTER_XT_MATCH_CONNTRACK=3Dm
> CONFIG_NETFILTER_XT_MATCH_CPU=3Dm
> CONFIG_NETFILTER_XT_MATCH_DCCP=3Dm
> CONFIG_NETFILTER_XT_MATCH_DEVGROUP=3Dm
> CONFIG_NETFILTER_XT_MATCH_DSCP=3Dm
> CONFIG_NETFILTER_XT_MATCH_ECN=3Dm
> CONFIG_NETFILTER_XT_MATCH_ESP=3Dm
> CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=3Dm
> CONFIG_NETFILTER_XT_MATCH_HELPER=3Dm
> CONFIG_NETFILTER_XT_MATCH_HL=3Dm
> CONFIG_NETFILTER_XT_MATCH_IPCOMP=3Dm
> CONFIG_NETFILTER_XT_MATCH_IPRANGE=3Dm
> CONFIG_NETFILTER_XT_MATCH_IPVS=3Dm
> CONFIG_NETFILTER_XT_MATCH_L2TP=3Dm
> CONFIG_NETFILTER_XT_MATCH_LENGTH=3Dm
> CONFIG_NETFILTER_XT_MATCH_LIMIT=3Dm
> CONFIG_NETFILTER_XT_MATCH_MAC=3Dm
> CONFIG_NETFILTER_XT_MATCH_MARK=3Dm
> CONFIG_NETFILTER_XT_MATCH_MULTIPORT=3Dm
> CONFIG_NETFILTER_XT_MATCH_NFACCT=3Dm
> CONFIG_NETFILTER_XT_MATCH_OSF=3Dm
> CONFIG_NETFILTER_XT_MATCH_OWNER=3Dm
> CONFIG_NETFILTER_XT_MATCH_POLICY=3Dm
> CONFIG_NETFILTER_XT_MATCH_PHYSDEV=3Dm
> CONFIG_NETFILTER_XT_MATCH_PKTTYPE=3Dm
> CONFIG_NETFILTER_XT_MATCH_QUOTA=3Dm
> CONFIG_NETFILTER_XT_MATCH_RATEEST=3Dm
> CONFIG_NETFILTER_XT_MATCH_REALM=3Dm
> CONFIG_NETFILTER_XT_MATCH_RECENT=3Dm
> CONFIG_NETFILTER_XT_MATCH_SCTP=3Dm
> CONFIG_NETFILTER_XT_MATCH_STATE=3Dm
> CONFIG_NETFILTER_XT_MATCH_STATISTIC=3Dm
> CONFIG_NETFILTER_XT_MATCH_STRING=3Dm
> CONFIG_NETFILTER_XT_MATCH_TCPMSS=3Dm
> CONFIG_NETFILTER_XT_MATCH_TIME=3Dm
> CONFIG_NETFILTER_XT_MATCH_U32=3Dm
> CONFIG_IP_SET=3Dm
> CONFIG_IP_SET_MAX=3D256
> CONFIG_IP_SET_BITMAP_IP=3Dm
> CONFIG_IP_SET_BITMAP_IPMAC=3Dm
> CONFIG_IP_SET_BITMAP_PORT=3Dm
> CONFIG_IP_SET_HASH_IP=3Dm
> CONFIG_IP_SET_HASH_IPMARK=3Dm
> CONFIG_IP_SET_HASH_IPPORT=3Dm
> CONFIG_IP_SET_HASH_IPPORTIP=3Dm
> CONFIG_IP_SET_HASH_IPPORTNET=3Dm
> # CONFIG_IP_SET_HASH_IPMAC is not set
> CONFIG_IP_SET_HASH_MAC=3Dm
> CONFIG_IP_SET_HASH_NETPORTNET=3Dm
> CONFIG_IP_SET_HASH_NET=3Dm
> CONFIG_IP_SET_HASH_NETNET=3Dm
> CONFIG_IP_SET_HASH_NETPORT=3Dm
> CONFIG_IP_SET_HASH_NETIFACE=3Dm
> CONFIG_IP_SET_LIST_SET=3Dm
> CONFIG_IP_VS=3Dm
> CONFIG_IP_VS_IPV6=3Dy
> # CONFIG_IP_VS_DEBUG is not set
> CONFIG_IP_VS_TAB_BITS=3D12
>
> #
> # IPVS transport protocol load balancing support
> #
> CONFIG_IP_VS_PROTO_TCP=3Dy
> CONFIG_IP_VS_PROTO_UDP=3Dy
> CONFIG_IP_VS_PROTO_AH_ESP=3Dy
> CONFIG_IP_VS_PROTO_ESP=3Dy
> CONFIG_IP_VS_PROTO_AH=3Dy
> CONFIG_IP_VS_PROTO_SCTP=3Dy
>
> #
> # IPVS scheduler
> #
> CONFIG_IP_VS_RR=3Dm
> CONFIG_IP_VS_WRR=3Dm
> CONFIG_IP_VS_LC=3Dm
> CONFIG_IP_VS_WLC=3Dm
> CONFIG_IP_VS_FO=3Dm
> CONFIG_IP_VS_OVF=3Dm
> CONFIG_IP_VS_LBLC=3Dm
> CONFIG_IP_VS_LBLCR=3Dm
> CONFIG_IP_VS_DH=3Dm
> CONFIG_IP_VS_SH=3Dm
> CONFIG_IP_VS_SED=3Dm
> CONFIG_IP_VS_NQ=3Dm
>
> #
> # IPVS SH scheduler
> #
> CONFIG_IP_VS_SH_TAB_BITS=3D8
>
> #
> # IPVS application helper
> #
> CONFIG_IP_VS_FTP=3Dm
> CONFIG_IP_VS_NFCT=3Dy
> CONFIG_IP_VS_PE_SIP=3Dm
>
> #
> # IP: Netfilter Configuration
> #
> CONFIG_NF_DEFRAG_IPV4=3Dm
> CONFIG_NF_CONNTRACK_IPV4=3Dm
> # CONFIG_NF_SOCKET_IPV4 is not set
> CONFIG_NF_TABLES_IPV4=3Dm
> CONFIG_NFT_CHAIN_ROUTE_IPV4=3Dm
> CONFIG_NFT_REJECT_IPV4=3Dm
> CONFIG_NFT_DUP_IPV4=3Dm
> # CONFIG_NFT_FIB_IPV4 is not set
> CONFIG_NF_TABLES_ARP=3Dm
> CONFIG_NF_DUP_IPV4=3Dm
> CONFIG_NF_LOG_ARP=3Dm
> CONFIG_NF_LOG_IPV4=3Dm
> CONFIG_NF_REJECT_IPV4=3Dm
> CONFIG_NF_NAT_IPV4=3Dm
> CONFIG_NFT_CHAIN_NAT_IPV4=3Dm
> CONFIG_NF_NAT_MASQUERADE_IPV4=3Dm
> CONFIG_NFT_MASQ_IPV4=3Dm
> CONFIG_NFT_REDIR_IPV4=3Dm
> CONFIG_NF_NAT_SNMP_BASIC=3Dm
> CONFIG_NF_NAT_PROTO_GRE=3Dm
> CONFIG_NF_NAT_PPTP=3Dm
> CONFIG_NF_NAT_H323=3Dm
> CONFIG_IP_NF_IPTABLES=3Dm
> CONFIG_IP_NF_MATCH_AH=3Dm
> CONFIG_IP_NF_MATCH_ECN=3Dm
> CONFIG_IP_NF_MATCH_RPFILTER=3Dm
> CONFIG_IP_NF_MATCH_TTL=3Dm
> CONFIG_IP_NF_FILTER=3Dm
> CONFIG_IP_NF_TARGET_REJECT=3Dm
> CONFIG_IP_NF_TARGET_SYNPROXY=3Dm
> CONFIG_IP_NF_NAT=3Dm
> CONFIG_IP_NF_TARGET_MASQUERADE=3Dm
> CONFIG_IP_NF_TARGET_NETMAP=3Dm
> CONFIG_IP_NF_TARGET_REDIRECT=3Dm
> CONFIG_IP_NF_MANGLE=3Dm
> CONFIG_IP_NF_TARGET_CLUSTERIP=3Dm
> CONFIG_IP_NF_TARGET_ECN=3Dm
> CONFIG_IP_NF_TARGET_TTL=3Dm
> CONFIG_IP_NF_RAW=3Dm
> CONFIG_IP_NF_SECURITY=3Dm
> CONFIG_IP_NF_ARPTABLES=3Dm
> CONFIG_IP_NF_ARPFILTER=3Dm
> CONFIG_IP_NF_ARP_MANGLE=3Dm
>
> #
> # IPv6: Netfilter Configuration
> #
> CONFIG_NF_DEFRAG_IPV6=3Dm
> CONFIG_NF_CONNTRACK_IPV6=3Dm
> # CONFIG_NF_SOCKET_IPV6 is not set
> CONFIG_NF_TABLES_IPV6=3Dm
> CONFIG_NFT_CHAIN_ROUTE_IPV6=3Dm
> CONFIG_NFT_REJECT_IPV6=3Dm
> CONFIG_NFT_DUP_IPV6=3Dm
> # CONFIG_NFT_FIB_IPV6 is not set
> CONFIG_NF_DUP_IPV6=3Dm
> CONFIG_NF_REJECT_IPV6=3Dm
> CONFIG_NF_LOG_IPV6=3Dm
> CONFIG_NF_NAT_IPV6=3Dm
> CONFIG_NFT_CHAIN_NAT_IPV6=3Dm
> CONFIG_NF_NAT_MASQUERADE_IPV6=3Dm
> CONFIG_NFT_MASQ_IPV6=3Dm
> CONFIG_NFT_REDIR_IPV6=3Dm
> CONFIG_IP6_NF_IPTABLES=3Dm
> CONFIG_IP6_NF_MATCH_AH=3Dm
> CONFIG_IP6_NF_MATCH_EUI64=3Dm
> CONFIG_IP6_NF_MATCH_FRAG=3Dm
> CONFIG_IP6_NF_MATCH_OPTS=3Dm
> CONFIG_IP6_NF_MATCH_HL=3Dm
> CONFIG_IP6_NF_MATCH_IPV6HEADER=3Dm
> CONFIG_IP6_NF_MATCH_MH=3Dm
> CONFIG_IP6_NF_MATCH_RPFILTER=3Dm
> CONFIG_IP6_NF_MATCH_RT=3Dm
> CONFIG_IP6_NF_TARGET_HL=3Dm
> CONFIG_IP6_NF_FILTER=3Dm
> CONFIG_IP6_NF_TARGET_REJECT=3Dm
> CONFIG_IP6_NF_TARGET_SYNPROXY=3Dm
> CONFIG_IP6_NF_MANGLE=3Dm
> CONFIG_IP6_NF_RAW=3Dm
> CONFIG_IP6_NF_SECURITY=3Dm
> CONFIG_IP6_NF_NAT=3Dm
> CONFIG_IP6_NF_TARGET_MASQUERADE=3Dm
> CONFIG_IP6_NF_TARGET_NPT=3Dm
> CONFIG_NF_TABLES_BRIDGE=3Dm
> CONFIG_NFT_BRIDGE_META=3Dm
> CONFIG_NFT_BRIDGE_REJECT=3Dm
> CONFIG_NF_LOG_BRIDGE=3Dm
> CONFIG_BRIDGE_NF_EBTABLES=3Dm
> CONFIG_BRIDGE_EBT_BROUTE=3Dm
> CONFIG_BRIDGE_EBT_T_FILTER=3Dm
> CONFIG_BRIDGE_EBT_T_NAT=3Dm
> CONFIG_BRIDGE_EBT_802_3=3Dm
> CONFIG_BRIDGE_EBT_AMONG=3Dm
> CONFIG_BRIDGE_EBT_ARP=3Dm
> CONFIG_BRIDGE_EBT_IP=3Dm
> CONFIG_BRIDGE_EBT_IP6=3Dm
> CONFIG_BRIDGE_EBT_LIMIT=3Dm
> CONFIG_BRIDGE_EBT_MARK=3Dm
> CONFIG_BRIDGE_EBT_PKTTYPE=3Dm
> CONFIG_BRIDGE_EBT_STP=3Dm
> CONFIG_BRIDGE_EBT_VLAN=3Dm
> CONFIG_BRIDGE_EBT_ARPREPLY=3Dm
> CONFIG_BRIDGE_EBT_DNAT=3Dm
> CONFIG_BRIDGE_EBT_MARK_T=3Dm
> CONFIG_BRIDGE_EBT_REDIRECT=3Dm
> CONFIG_BRIDGE_EBT_SNAT=3Dm
> CONFIG_BRIDGE_EBT_LOG=3Dm
> CONFIG_BRIDGE_EBT_NFLOG=3Dm
> CONFIG_IP_DCCP=3Dm
> CONFIG_INET_DCCP_DIAG=3Dm
>
> #
> # DCCP CCIDs Configuration
> #
> # CONFIG_IP_DCCP_CCID2_DEBUG is not set
> CONFIG_IP_DCCP_CCID3=3Dy
> # CONFIG_IP_DCCP_CCID3_DEBUG is not set
> CONFIG_IP_DCCP_TFRC_LIB=3Dy
>
> #
> # DCCP Kernel Hacking
> #
> # CONFIG_IP_DCCP_DEBUG is not set
> CONFIG_NET_DCCPPROBE=3Dm
> CONFIG_IP_SCTP=3Dm
> CONFIG_NET_SCTPPROBE=3Dm
> # CONFIG_SCTP_DBG_OBJCNT is not set
> # CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
> CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=3Dy
> # CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
> CONFIG_SCTP_COOKIE_HMAC_MD5=3Dy
> CONFIG_SCTP_COOKIE_HMAC_SHA1=3Dy
> CONFIG_INET_SCTP_DIAG=3Dm
> # CONFIG_RDS is not set
> # CONFIG_TIPC is not set
> CONFIG_ATM=3Dm
> CONFIG_ATM_CLIP=3Dm
> # CONFIG_ATM_CLIP_NO_ICMP is not set
> CONFIG_ATM_LANE=3Dm
> CONFIG_ATM_MPOA=3Dm
> CONFIG_ATM_BR2684=3Dm
> # CONFIG_ATM_BR2684_IPFILTER is not set
> CONFIG_L2TP=3Dm
> # CONFIG_L2TP_DEBUGFS is not set
> CONFIG_L2TP_V3=3Dy
> CONFIG_L2TP_IP=3Dm
> CONFIG_L2TP_ETH=3Dm
> CONFIG_STP=3Dm
> CONFIG_MRP=3Dm
> CONFIG_BRIDGE=3Dm
> CONFIG_BRIDGE_IGMP_SNOOPING=3Dy
> CONFIG_BRIDGE_VLAN_FILTERING=3Dy
> CONFIG_HAVE_NET_DSA=3Dy
> CONFIG_NET_DSA=3Dm
> CONFIG_NET_DSA_TAG_DSA=3Dy
> CONFIG_NET_DSA_TAG_EDSA=3Dy
> CONFIG_NET_DSA_TAG_TRAILER=3Dy
> CONFIG_NET_DSA_TAG_QCA=3Dy
> CONFIG_VLAN_8021Q=3Dm
> # CONFIG_VLAN_8021Q_GVRP is not set
> CONFIG_VLAN_8021Q_MVRP=3Dy
> # CONFIG_DECNET is not set
> CONFIG_LLC=3Dm
> CONFIG_LLC2=3Dm
> # CONFIG_IPX is not set
> # CONFIG_ATALK is not set
> # CONFIG_X25 is not set
> # CONFIG_LAPB is not set
> CONFIG_PHONET=3Dm
> CONFIG_6LOWPAN=3Dm
> # CONFIG_6LOWPAN_DEBUGFS is not set
> CONFIG_6LOWPAN_NHC=3Dm
> CONFIG_6LOWPAN_NHC_DEST=3Dm
> CONFIG_6LOWPAN_NHC_FRAGMENT=3Dm
> CONFIG_6LOWPAN_NHC_HOP=3Dm
> CONFIG_6LOWPAN_NHC_IPV6=3Dm
> CONFIG_6LOWPAN_NHC_MOBILITY=3Dm
> CONFIG_6LOWPAN_NHC_ROUTING=3Dm
> CONFIG_6LOWPAN_NHC_UDP=3Dm
> CONFIG_6LOWPAN_GHC_EXT_HDR_HOP=3Dm
> CONFIG_6LOWPAN_GHC_UDP=3Dm
> CONFIG_6LOWPAN_GHC_ICMPV6=3Dm
> CONFIG_6LOWPAN_GHC_EXT_HDR_DEST=3Dm
> CONFIG_6LOWPAN_GHC_EXT_HDR_FRAG=3Dm
> CONFIG_6LOWPAN_GHC_EXT_HDR_ROUTE=3Dm
> CONFIG_IEEE802154=3Dm
> CONFIG_IEEE802154_NL802154_EXPERIMENTAL=3Dy
> CONFIG_IEEE802154_SOCKET=3Dm
> CONFIG_IEEE802154_6LOWPAN=3Dm
> CONFIG_MAC802154=3Dm
> CONFIG_NET_SCHED=3Dy
>
> #
> # Queueing/Scheduling
> #
> CONFIG_NET_SCH_CBQ=3Dm
> CONFIG_NET_SCH_HTB=3Dm
> CONFIG_NET_SCH_HFSC=3Dm
> CONFIG_NET_SCH_ATM=3Dm
> CONFIG_NET_SCH_PRIO=3Dm
> CONFIG_NET_SCH_MULTIQ=3Dm
> CONFIG_NET_SCH_RED=3Dm
> CONFIG_NET_SCH_SFB=3Dm
> CONFIG_NET_SCH_SFQ=3Dm
> CONFIG_NET_SCH_TEQL=3Dm
> CONFIG_NET_SCH_TBF=3Dm
> CONFIG_NET_SCH_GRED=3Dm
> CONFIG_NET_SCH_DSMARK=3Dm
> CONFIG_NET_SCH_NETEM=3Dm
> CONFIG_NET_SCH_DRR=3Dm
> CONFIG_NET_SCH_MQPRIO=3Dm
> CONFIG_NET_SCH_CHOKE=3Dm
> CONFIG_NET_SCH_QFQ=3Dm
> CONFIG_NET_SCH_CODEL=3Dm
> CONFIG_NET_SCH_FQ_CODEL=3Dm
> CONFIG_NET_SCH_FQ=3Dm
> CONFIG_NET_SCH_HHF=3Dm
> CONFIG_NET_SCH_PIE=3Dm
> CONFIG_NET_SCH_INGRESS=3Dm
> CONFIG_NET_SCH_PLUG=3Dm
> # CONFIG_NET_SCH_DEFAULT is not set
>
> #
> # Classification
> #
> CONFIG_NET_CLS=3Dy
> CONFIG_NET_CLS_BASIC=3Dm
> CONFIG_NET_CLS_TCINDEX=3Dm
> CONFIG_NET_CLS_ROUTE4=3Dm
> CONFIG_NET_CLS_FW=3Dm
> CONFIG_NET_CLS_U32=3Dm
> # CONFIG_CLS_U32_PERF is not set
> # CONFIG_CLS_U32_MARK is not set
> CONFIG_NET_CLS_RSVP=3Dm
> CONFIG_NET_CLS_RSVP6=3Dm
> CONFIG_NET_CLS_FLOW=3Dm
> CONFIG_NET_CLS_CGROUP=3Dm
> CONFIG_NET_CLS_BPF=3Dm
> CONFIG_NET_CLS_FLOWER=3Dm
> CONFIG_NET_CLS_MATCHALL=3Dm
> CONFIG_NET_EMATCH=3Dy
> CONFIG_NET_EMATCH_STACK=3D32
> CONFIG_NET_EMATCH_CMP=3Dm
> CONFIG_NET_EMATCH_NBYTE=3Dm
> CONFIG_NET_EMATCH_U32=3Dm
> CONFIG_NET_EMATCH_META=3Dm
> CONFIG_NET_EMATCH_TEXT=3Dm
> CONFIG_NET_EMATCH_CANID=3Dm
> CONFIG_NET_EMATCH_IPSET=3Dm
> CONFIG_NET_CLS_ACT=3Dy
> CONFIG_NET_ACT_POLICE=3Dm
> CONFIG_NET_ACT_GACT=3Dm
> CONFIG_GACT_PROB=3Dy
> CONFIG_NET_ACT_MIRRED=3Dm
> # CONFIG_NET_ACT_SAMPLE is not set
> CONFIG_NET_ACT_IPT=3Dm
> CONFIG_NET_ACT_NAT=3Dm
> CONFIG_NET_ACT_PEDIT=3Dm
> CONFIG_NET_ACT_SIMP=3Dm
> CONFIG_NET_ACT_SKBEDIT=3Dm
> CONFIG_NET_ACT_CSUM=3Dm
> CONFIG_NET_ACT_VLAN=3Dm
> CONFIG_NET_ACT_BPF=3Dm
> CONFIG_NET_ACT_CONNMARK=3Dm
> CONFIG_NET_ACT_SKBMOD=3Dm
> CONFIG_NET_ACT_IFE=3Dm
> CONFIG_NET_ACT_TUNNEL_KEY=3Dm
> CONFIG_NET_IFE_SKBMARK=3Dm
> CONFIG_NET_IFE_SKBPRIO=3Dm
> CONFIG_NET_IFE_SKBTCINDEX=3Dm
> CONFIG_NET_CLS_IND=3Dy
> CONFIG_NET_SCH_FIFO=3Dy
> # CONFIG_DCB is not set
> CONFIG_DNS_RESOLVER=3Dm
> CONFIG_BATMAN_ADV=3Dm
> CONFIG_BATMAN_ADV_BATMAN_V=3Dy
> CONFIG_BATMAN_ADV_BLA=3Dy
> CONFIG_BATMAN_ADV_DAT=3Dy
> CONFIG_BATMAN_ADV_NC=3Dy
> CONFIG_BATMAN_ADV_MCAST=3Dy
> CONFIG_BATMAN_ADV_DEBUGFS=3Dy
> # CONFIG_BATMAN_ADV_DEBUG is not set
> CONFIG_OPENVSWITCH=3Dm
> CONFIG_OPENVSWITCH_GRE=3Dm
> CONFIG_OPENVSWITCH_VXLAN=3Dm
> CONFIG_OPENVSWITCH_GENEVE=3Dm
> CONFIG_VSOCKETS=3Dm
> CONFIG_VMWARE_VMCI_VSOCKETS=3Dm
> CONFIG_VIRTIO_VSOCKETS=3Dm
> CONFIG_VIRTIO_VSOCKETS_COMMON=3Dm
> CONFIG_NETLINK_DIAG=3Dm
> CONFIG_MPLS=3Dy
> CONFIG_NET_MPLS_GSO=3Dm
> CONFIG_MPLS_ROUTING=3Dm
> CONFIG_MPLS_IPTUNNEL=3Dm
> CONFIG_HSR=3Dm
> CONFIG_NET_SWITCHDEV=3Dy
> CONFIG_NET_L3_MASTER_DEV=3Dy
> CONFIG_NET_NCSI=3Dy
> CONFIG_RPS=3Dy
> CONFIG_RFS_ACCEL=3Dy
> CONFIG_XPS=3Dy
> # CONFIG_CGROUP_NET_PRIO is not set
> CONFIG_CGROUP_NET_CLASSID=3Dy
> CONFIG_NET_RX_BUSY_POLL=3Dy
> CONFIG_BQL=3Dy
> CONFIG_BPF_JIT=3Dy
> CONFIG_NET_FLOW_LIMIT=3Dy
>
> #
> # Network testing
> #
> CONFIG_NET_PKTGEN=3Dm
> CONFIG_NET_TCPPROBE=3Dm
> CONFIG_NET_DROP_MONITOR=3Dm
> CONFIG_HAMRADIO=3Dy
>
> #
> # Packet Radio protocols
> #
> CONFIG_AX25=3Dm
> CONFIG_AX25_DAMA_SLAVE=3Dy
> CONFIG_NETROM=3Dm
> CONFIG_ROSE=3Dm
>
> #
> # AX.25 network device drivers
> #
> CONFIG_MKISS=3Dm
> CONFIG_6PACK=3Dm
> CONFIG_BPQETHER=3Dm
> CONFIG_BAYCOM_SER_FDX=3Dm
> CONFIG_BAYCOM_SER_HDX=3Dm
> CONFIG_BAYCOM_PAR=3Dm
> CONFIG_YAM=3Dm
> CONFIG_CAN=3Dm
> CONFIG_CAN_RAW=3Dm
> CONFIG_CAN_BCM=3Dm
> CONFIG_CAN_GW=3Dm
>
> #
> # CAN Device Drivers
> #
> CONFIG_CAN_VCAN=3Dm
> # CONFIG_CAN_VXCAN is not set
> CONFIG_CAN_SLCAN=3Dm
> CONFIG_CAN_DEV=3Dm
> CONFIG_CAN_CALC_BITTIMING=3Dy
> CONFIG_CAN_LEDS=3Dy
> CONFIG_CAN_C_CAN=3Dm
> CONFIG_CAN_C_CAN_PLATFORM=3Dm
> CONFIG_CAN_C_CAN_PCI=3Dm
> CONFIG_CAN_CC770=3Dm
> # CONFIG_CAN_CC770_ISA is not set
> CONFIG_CAN_CC770_PLATFORM=3Dm
> CONFIG_CAN_IFI_CANFD=3Dm
> CONFIG_CAN_M_CAN=3Dm
> # CONFIG_CAN_PEAK_PCIEFD is not set
> CONFIG_CAN_SJA1000=3Dm
> # CONFIG_CAN_SJA1000_ISA is not set
> CONFIG_CAN_SJA1000_PLATFORM=3Dm
> # CONFIG_CAN_EMS_PCMCIA is not set
> CONFIG_CAN_EMS_PCI=3Dm
> # CONFIG_CAN_PEAK_PCMCIA is not set
> CONFIG_CAN_PEAK_PCI=3Dm
> CONFIG_CAN_PEAK_PCIEC=3Dy
> CONFIG_CAN_KVASER_PCI=3Dm
> CONFIG_CAN_PLX_PCI=3Dm
> CONFIG_CAN_SOFTING=3Dm
> # CONFIG_CAN_SOFTING_CS is not set
>
> #
> # CAN SPI interfaces
> #
> # CONFIG_CAN_HI311X is not set
> # CONFIG_CAN_MCP251X is not set
>
> #
> # CAN USB interfaces
> #
> CONFIG_CAN_EMS_USB=3Dm
> CONFIG_CAN_ESD_USB2=3Dm
> CONFIG_CAN_GS_USB=3Dm
> CONFIG_CAN_KVASER_USB=3Dm
> CONFIG_CAN_PEAK_USB=3Dm
> CONFIG_CAN_8DEV_USB=3Dm
> # CONFIG_CAN_MCBA_USB is not set
> # CONFIG_CAN_DEBUG_DEVICES is not set
> CONFIG_IRDA=3Dm
>
> #
> # IrDA protocols
> #
> CONFIG_IRLAN=3Dm
> CONFIG_IRNET=3Dm
> CONFIG_IRCOMM=3Dm
> CONFIG_IRDA_ULTRA=3Dy
>
> #
> # IrDA options
> #
> CONFIG_IRDA_CACHE_LAST_LSAP=3Dy
> CONFIG_IRDA_FAST_RR=3Dy
> # CONFIG_IRDA_DEBUG is not set
>
> #
> # Infrared-port device drivers
> #
>
> #
> # SIR device drivers
> #
> CONFIG_IRTTY_SIR=3Dm
>
> #
> # Dongle support
> #
> CONFIG_DONGLE=3Dy
> CONFIG_ESI_DONGLE=3Dm
> CONFIG_ACTISYS_DONGLE=3Dm
> CONFIG_TEKRAM_DONGLE=3Dm
> CONFIG_TOIM3232_DONGLE=3Dm
> CONFIG_LITELINK_DONGLE=3Dm
> CONFIG_MA600_DONGLE=3Dm
> CONFIG_GIRBIL_DONGLE=3Dm
> CONFIG_MCP2120_DONGLE=3Dm
> CONFIG_OLD_BELKIN_DONGLE=3Dm
> CONFIG_ACT200L_DONGLE=3Dm
> CONFIG_KINGSUN_DONGLE=3Dm
> CONFIG_KSDAZZLE_DONGLE=3Dm
> CONFIG_KS959_DONGLE=3Dm
>
> #
> # FIR device drivers
> #
> CONFIG_USB_IRDA=3Dm
> CONFIG_SIGMATEL_FIR=3Dm
> CONFIG_NSC_FIR=3Dm
> CONFIG_WINBOND_FIR=3Dm
> CONFIG_SMC_IRCC_FIR=3Dm
> CONFIG_ALI_FIR=3Dm
> CONFIG_VLSI_FIR=3Dm
> CONFIG_VIA_FIR=3Dm
> CONFIG_MCS_FIR=3Dm
> CONFIG_BT=3Dm
> CONFIG_BT_BREDR=3Dy
> CONFIG_BT_RFCOMM=3Dm
> CONFIG_BT_RFCOMM_TTY=3Dy
> CONFIG_BT_BNEP=3Dm
> CONFIG_BT_BNEP_MC_FILTER=3Dy
> CONFIG_BT_BNEP_PROTO_FILTER=3Dy
> CONFIG_BT_CMTP=3Dm
> CONFIG_BT_HIDP=3Dm
> CONFIG_BT_HS=3Dy
> CONFIG_BT_LE=3Dy
> CONFIG_BT_6LOWPAN=3Dm
> CONFIG_BT_LEDS=3Dy
> # CONFIG_BT_SELFTEST is not set
> CONFIG_BT_DEBUGFS=3Dy
>
> #
> # Bluetooth device drivers
> #
> CONFIG_BT_INTEL=3Dm
> CONFIG_BT_BCM=3Dm
> CONFIG_BT_RTL=3Dm
> CONFIG_BT_QCA=3Dm
> CONFIG_BT_HCIBTUSB=3Dm
> CONFIG_BT_HCIBTUSB_BCM=3Dy
> CONFIG_BT_HCIBTUSB_RTL=3Dy
> CONFIG_BT_HCIBTSDIO=3Dm
> CONFIG_BT_HCIUART=3Dm
> CONFIG_BT_HCIUART_H4=3Dy
> CONFIG_BT_HCIUART_BCSP=3Dy
> CONFIG_BT_HCIUART_ATH3K=3Dy
> CONFIG_BT_HCIUART_LL=3Dy
> CONFIG_BT_HCIUART_3WIRE=3Dy
> CONFIG_BT_HCIUART_INTEL=3Dy
> CONFIG_BT_HCIUART_BCM=3Dy
> CONFIG_BT_HCIUART_QCA=3Dy
> CONFIG_BT_HCIUART_AG6XX=3Dy
> CONFIG_BT_HCIUART_MRVL=3Dy
> CONFIG_BT_HCIBCM203X=3Dm
> CONFIG_BT_HCIBPA10X=3Dm
> CONFIG_BT_HCIBFUSB=3Dm
> CONFIG_BT_HCIDTL1=3Dm
> CONFIG_BT_HCIBT3C=3Dm
> CONFIG_BT_HCIBLUECARD=3Dm
> CONFIG_BT_HCIBTUART=3Dm
> CONFIG_BT_HCIVHCI=3Dm
> CONFIG_BT_MRVL=3Dm
> CONFIG_BT_MRVL_SDIO=3Dm
> CONFIG_BT_ATH3K=3Dm
> CONFIG_BT_WILINK=3Dm
> CONFIG_AF_RXRPC=3Dm
> CONFIG_AF_RXRPC_IPV6=3Dy
> # CONFIG_AF_RXRPC_INJECT_LOSS is not set
> # CONFIG_AF_RXRPC_DEBUG is not set
> CONFIG_RXKAD=3Dy
> CONFIG_AF_KCM=3Dm
> CONFIG_STREAM_PARSER=3Dm
> CONFIG_FIB_RULES=3Dy
> CONFIG_WIRELESS=3Dy
> CONFIG_WIRELESS_EXT=3Dy
> CONFIG_WEXT_CORE=3Dy
> CONFIG_WEXT_PROC=3Dy
> CONFIG_WEXT_SPY=3Dy
> CONFIG_WEXT_PRIV=3Dy
> CONFIG_CFG80211=3Dm
> # CONFIG_NL80211_TESTMODE is not set
> # CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
> CONFIG_CFG80211_DEFAULT_PS=3Dy
> # CONFIG_CFG80211_DEBUGFS is not set
> # CONFIG_CFG80211_INTERNAL_REGDB is not set
> CONFIG_CFG80211_CRDA_SUPPORT=3Dy
> CONFIG_CFG80211_WEXT=3Dy
> CONFIG_CFG80211_WEXT_EXPORT=3Dy
> CONFIG_LIB80211=3Dm
> CONFIG_LIB80211_CRYPT_WEP=3Dm
> CONFIG_LIB80211_CRYPT_CCMP=3Dm
> CONFIG_LIB80211_CRYPT_TKIP=3Dm
> # CONFIG_LIB80211_DEBUG is not set
> CONFIG_MAC80211=3Dm
> CONFIG_MAC80211_HAS_RC=3Dy
> CONFIG_MAC80211_RC_MINSTREL=3Dy
> CONFIG_MAC80211_RC_MINSTREL_HT=3Dy
> # CONFIG_MAC80211_RC_MINSTREL_VHT is not set
> CONFIG_MAC80211_RC_DEFAULT_MINSTREL=3Dy
> CONFIG_MAC80211_RC_DEFAULT=3D"minstrel_ht"
> CONFIG_MAC80211_MESH=3Dy
> CONFIG_MAC80211_LEDS=3Dy
> CONFIG_MAC80211_DEBUGFS=3Dy
> # CONFIG_MAC80211_MESSAGE_TRACING is not set
> # CONFIG_MAC80211_DEBUG_MENU is not set
> CONFIG_MAC80211_STA_HASH_MAX_SIZE=3D0
> CONFIG_WIMAX=3Dm
> CONFIG_WIMAX_DEBUG_LEVEL=3D8
> CONFIG_RFKILL=3Dm
> CONFIG_RFKILL_LEDS=3Dy
> CONFIG_RFKILL_INPUT=3Dy
> CONFIG_RFKILL_GPIO=3Dm
> CONFIG_NET_9P=3Dm
> CONFIG_NET_9P_VIRTIO=3Dm
> # CONFIG_NET_9P_XEN is not set
> # CONFIG_NET_9P_RDMA is not set
> # CONFIG_NET_9P_DEBUG is not set
> CONFIG_CAIF=3Dm
> # CONFIG_CAIF_DEBUG is not set
> CONFIG_CAIF_NETDEV=3Dm
> CONFIG_CAIF_USB=3Dm
> CONFIG_CEPH_LIB=3Dm
> # CONFIG_CEPH_LIB_PRETTYDEBUG is not set
> # CONFIG_CEPH_LIB_USE_DNS_RESOLVER is not set
> CONFIG_NFC=3Dm
> CONFIG_NFC_DIGITAL=3Dm
> CONFIG_NFC_NCI=3Dm
> # CONFIG_NFC_NCI_SPI is not set
> # CONFIG_NFC_NCI_UART is not set
> CONFIG_NFC_HCI=3Dm
> # CONFIG_NFC_SHDLC is not set
>
> #
> # Near Field Communication (NFC) devices
> #
> CONFIG_NFC_TRF7970A=3Dm
> CONFIG_NFC_MEI_PHY=3Dm
> CONFIG_NFC_SIM=3Dm
> CONFIG_NFC_PORT100=3Dm
> CONFIG_NFC_FDP=3Dm
> CONFIG_NFC_FDP_I2C=3Dm
> CONFIG_NFC_PN544=3Dm
> CONFIG_NFC_PN544_MEI=3Dm
> CONFIG_NFC_PN533=3Dm
> CONFIG_NFC_PN533_USB=3Dm
> CONFIG_NFC_PN533_I2C=3Dm
> CONFIG_NFC_MICROREAD=3Dm
> CONFIG_NFC_MICROREAD_MEI=3Dm
> CONFIG_NFC_MRVL=3Dm
> CONFIG_NFC_MRVL_USB=3Dm
> CONFIG_NFC_MRVL_I2C=3Dm
> CONFIG_NFC_ST_NCI=3Dm
> CONFIG_NFC_ST_NCI_I2C=3Dm
> # CONFIG_NFC_ST_NCI_SPI is not set
> # CONFIG_NFC_NXP_NCI is not set
> # CONFIG_NFC_S3FWRN5_I2C is not set
> # CONFIG_NFC_ST95HF is not set
> # CONFIG_PSAMPLE is not set
> CONFIG_NET_IFE=3Dm
> CONFIG_LWTUNNEL=3Dy
> CONFIG_LWTUNNEL_BPF=3Dy
> CONFIG_DST_CACHE=3Dy
> CONFIG_GRO_CELLS=3Dy
> CONFIG_NET_DEVLINK=3Dm
> CONFIG_MAY_USE_DEVLINK=3Dm
> CONFIG_HAVE_EBPF_JIT=3Dy
>
> #
> # Device Drivers
> #
>
> #
> # Generic Driver Options
> #
> # CONFIG_UEVENT_HELPER is not set
> CONFIG_DEVTMPFS=3Dy
> # CONFIG_DEVTMPFS_MOUNT is not set
> CONFIG_STANDALONE=3Dy
> CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
> CONFIG_FW_LOADER=3Dy
> # CONFIG_FIRMWARE_IN_KERNEL is not set
> CONFIG_EXTRA_FIRMWARE=3D""
> CONFIG_FW_LOADER_USER_HELPER=3Dy
> # CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
> CONFIG_WANT_DEV_COREDUMP=3Dy
> CONFIG_ALLOW_DEV_COREDUMP=3Dy
> CONFIG_DEV_COREDUMP=3Dy
> # CONFIG_DEBUG_DRIVER is not set
> # CONFIG_DEBUG_DEVRES is not set
> # CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
> # CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
> CONFIG_SYS_HYPERVISOR=3Dy
> # CONFIG_GENERIC_CPU_DEVICES is not set
> CONFIG_GENERIC_CPU_AUTOPROBE=3Dy
> CONFIG_REGMAP=3Dy
> CONFIG_REGMAP_I2C=3Dy
> CONFIG_REGMAP_SPI=3Dy
> CONFIG_REGMAP_MMIO=3Dy
> CONFIG_REGMAP_IRQ=3Dy
> CONFIG_DMA_SHARED_BUFFER=3Dy
> # CONFIG_DMA_FENCE_TRACE is not set
>
> #
> # Bus devices
> #
> CONFIG_CONNECTOR=3Dy
> CONFIG_PROC_EVENTS=3Dy
> CONFIG_MTD=3Dm
> CONFIG_MTD_TESTS=3Dm
> CONFIG_MTD_REDBOOT_PARTS=3Dm
> CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=3D-1
> # CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
> # CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
> CONFIG_MTD_CMDLINE_PARTS=3Dm
> CONFIG_MTD_AR7_PARTS=3Dm
>
> #
> # User Modules And Translation Layers
> #
> CONFIG_MTD_BLKDEVS=3Dm
> CONFIG_MTD_BLOCK=3Dm
> CONFIG_MTD_BLOCK_RO=3Dm
> CONFIG_FTL=3Dm
> CONFIG_NFTL=3Dm
> CONFIG_NFTL_RW=3Dy
> CONFIG_INFTL=3Dm
> CONFIG_RFD_FTL=3Dm
> CONFIG_SSFDC=3Dm
> # CONFIG_SM_FTL is not set
> CONFIG_MTD_OOPS=3Dm
> CONFIG_MTD_SWAP=3Dm
> # CONFIG_MTD_PARTITIONED_MASTER is not set
>
> #
> # RAM/ROM/Flash chip drivers
> #
> CONFIG_MTD_CFI=3Dm
> CONFIG_MTD_JEDECPROBE=3Dm
> CONFIG_MTD_GEN_PROBE=3Dm
> # CONFIG_MTD_CFI_ADV_OPTIONS is not set
> CONFIG_MTD_MAP_BANK_WIDTH_1=3Dy
> CONFIG_MTD_MAP_BANK_WIDTH_2=3Dy
> CONFIG_MTD_MAP_BANK_WIDTH_4=3Dy
> # CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
> # CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
> # CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
> CONFIG_MTD_CFI_I1=3Dy
> CONFIG_MTD_CFI_I2=3Dy
> # CONFIG_MTD_CFI_I4 is not set
> # CONFIG_MTD_CFI_I8 is not set
> CONFIG_MTD_CFI_INTELEXT=3Dm
> CONFIG_MTD_CFI_AMDSTD=3Dm
> CONFIG_MTD_CFI_STAA=3Dm
> CONFIG_MTD_CFI_UTIL=3Dm
> CONFIG_MTD_RAM=3Dm
> CONFIG_MTD_ROM=3Dm
> CONFIG_MTD_ABSENT=3Dm
>
> #
> # Mapping drivers for chip access
> #
> CONFIG_MTD_COMPLEX_MAPPINGS=3Dy
> # CONFIG_MTD_PHYSMAP is not set
> # CONFIG_MTD_SBC_GXX is not set
> # CONFIG_MTD_AMD76XROM is not set
> # CONFIG_MTD_ICHXROM is not set
> # CONFIG_MTD_ESB2ROM is not set
> # CONFIG_MTD_CK804XROM is not set
> CONFIG_MTD_SCB2_FLASH=3Dm
> # CONFIG_MTD_NETtel is not set
> # CONFIG_MTD_L440GX is not set
> CONFIG_MTD_PCI=3Dm
> CONFIG_MTD_PCMCIA=3Dm
> # CONFIG_MTD_PCMCIA_ANONYMOUS is not set
> # CONFIG_MTD_GPIO_ADDR is not set
> # CONFIG_MTD_INTEL_VR_NOR is not set
> CONFIG_MTD_PLATRAM=3Dm
> # CONFIG_MTD_LATCH_ADDR is not set
>
> #
> # Self-contained MTD device drivers
> #
> CONFIG_MTD_PMC551=3Dm
> # CONFIG_MTD_PMC551_BUGFIX is not set
> # CONFIG_MTD_PMC551_DEBUG is not set
> # CONFIG_MTD_DATAFLASH is not set
> # CONFIG_MTD_SST25L is not set
> CONFIG_MTD_SLRAM=3Dm
> CONFIG_MTD_PHRAM=3Dm
> CONFIG_MTD_MTDRAM=3Dm
> CONFIG_MTDRAM_TOTAL_SIZE=3D4096
> CONFIG_MTDRAM_ERASE_SIZE=3D128
> CONFIG_MTD_BLOCK2MTD=3Dm
>
> #
> # Disk-On-Chip Device Drivers
> #
> # CONFIG_MTD_DOCG3 is not set
> # CONFIG_MTD_NAND is not set
> # CONFIG_MTD_ONENAND is not set
>
> #
> # LPDDR & LPDDR2 PCM memory drivers
> #
> CONFIG_MTD_LPDDR=3Dm
> CONFIG_MTD_QINFO_PROBE=3Dm
> # CONFIG_MTD_SPI_NOR is not set
> CONFIG_MTD_UBI=3Dm
> CONFIG_MTD_UBI_WL_THRESHOLD=3D4096
> CONFIG_MTD_UBI_BEB_LIMIT=3D20
> # CONFIG_MTD_UBI_FASTMAP is not set
> # CONFIG_MTD_UBI_GLUEBI is not set
> CONFIG_MTD_UBI_BLOCK=3Dy
> # CONFIG_OF is not set
> CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=3Dy
> CONFIG_PARPORT=3Dm
> CONFIG_PARPORT_PC=3Dm
> CONFIG_PARPORT_SERIAL=3Dm
> # CONFIG_PARPORT_PC_FIFO is not set
> # CONFIG_PARPORT_PC_SUPERIO is not set
> CONFIG_PARPORT_PC_PCMCIA=3Dm
> # CONFIG_PARPORT_GSC is not set
> CONFIG_PARPORT_AX88796=3Dm
> CONFIG_PARPORT_1284=3Dy
> CONFIG_PARPORT_NOT_PC=3Dy
> CONFIG_PNP=3Dy
> # CONFIG_PNP_DEBUG_MESSAGES is not set
>
> #
> # Protocols
> #
> CONFIG_PNPACPI=3Dy
> CONFIG_BLK_DEV=3Dy
> # CONFIG_BLK_DEV_NULL_BLK is not set
> CONFIG_BLK_DEV_FD=3Dm
> # CONFIG_PARIDE is not set
> CONFIG_BLK_DEV_PCIESSD_MTIP32XX=3Dm
> CONFIG_ZRAM=3Dm
> CONFIG_BLK_CPQ_CISS_DA=3Dm
> # CONFIG_CISS_SCSI_TAPE is not set
> CONFIG_BLK_DEV_DAC960=3Dm
> # CONFIG_BLK_DEV_UMEM is not set
> # CONFIG_BLK_DEV_COW_COMMON is not set
> CONFIG_BLK_DEV_LOOP=3Dm
> CONFIG_BLK_DEV_LOOP_MIN_COUNT=3D8
> CONFIG_BLK_DEV_CRYPTOLOOP=3Dm
> CONFIG_BLK_DEV_DRBD=3Dm
> # CONFIG_DRBD_FAULT_INJECTION is not set
> CONFIG_BLK_DEV_NBD=3Dm
> CONFIG_BLK_DEV_SKD=3Dm
> CONFIG_BLK_DEV_SX8=3Dm
> CONFIG_BLK_DEV_RAM=3Dm
> CONFIG_BLK_DEV_RAM_COUNT=3D16
> CONFIG_BLK_DEV_RAM_SIZE=3D16384
> CONFIG_CDROM_PKTCDVD=3Dm
> CONFIG_CDROM_PKTCDVD_BUFFERS=3D8
> # CONFIG_CDROM_PKTCDVD_WCACHE is not set
> CONFIG_ATA_OVER_ETH=3Dm
> CONFIG_XEN_BLKDEV_FRONTEND=3Dm
> CONFIG_XEN_BLKDEV_BACKEND=3Dm
> CONFIG_VIRTIO_BLK=3Dm
> # CONFIG_VIRTIO_BLK_SCSI is not set
> CONFIG_BLK_DEV_RBD=3Dm
> CONFIG_BLK_DEV_RSXX=3Dm
> CONFIG_NVME_CORE=3Dm
> CONFIG_BLK_DEV_NVME=3Dm
> # CONFIG_BLK_DEV_NVME_SCSI is not set
> CONFIG_NVME_FABRICS=3Dm
> CONFIG_NVME_RDMA=3Dm
> # CONFIG_NVME_FC is not set
> CONFIG_NVME_TARGET=3Dm
> CONFIG_NVME_TARGET_LOOP=3Dm
> CONFIG_NVME_TARGET_RDMA=3Dm
> # CONFIG_NVME_TARGET_FC is not set
>
> #
> # Misc devices
> #
> CONFIG_SENSORS_LIS3LV02D=3Dm
> CONFIG_AD525X_DPOT=3Dm
> CONFIG_AD525X_DPOT_I2C=3Dm
> # CONFIG_AD525X_DPOT_SPI is not set
> # CONFIG_DUMMY_IRQ is not set
> # CONFIG_IBM_ASM is not set
> CONFIG_PHANTOM=3Dm
> CONFIG_SGI_IOC4=3Dm
> CONFIG_TIFM_CORE=3Dm
> CONFIG_TIFM_7XX1=3Dm
> CONFIG_ICS932S401=3Dm
> CONFIG_ENCLOSURE_SERVICES=3Dm
> CONFIG_HP_ILO=3Dm
> CONFIG_APDS9802ALS=3Dm
> CONFIG_ISL29003=3Dm
> CONFIG_ISL29020=3Dm
> CONFIG_SENSORS_TSL2550=3Dm
> CONFIG_SENSORS_BH1770=3Dm
> CONFIG_SENSORS_APDS990X=3Dm
> CONFIG_HMC6352=3Dm
> CONFIG_DS1682=3Dm
> # CONFIG_TI_DAC7512 is not set
> CONFIG_VMWARE_BALLOON=3Dm
> CONFIG_USB_SWITCH_FSA9480=3Dm
> # CONFIG_LATTICE_ECP3_CONFIG is not set
> # CONFIG_SRAM is not set
> # CONFIG_PCI_ENDPOINT_TEST is not set
> CONFIG_C2PORT=3Dm
> CONFIG_C2PORT_DURAMAR_2150=3Dm
>
> #
> # EEPROM support
> #
> CONFIG_EEPROM_AT24=3Dm
> # CONFIG_EEPROM_AT25 is not set
> CONFIG_EEPROM_LEGACY=3Dm
> CONFIG_EEPROM_MAX6875=3Dm
> CONFIG_EEPROM_93CX6=3Dm
> # CONFIG_EEPROM_93XX46 is not set
> # CONFIG_EEPROM_IDT_89HPESX is not set
> CONFIG_CB710_CORE=3Dm
> # CONFIG_CB710_DEBUG is not set
> CONFIG_CB710_DEBUG_ASSUMPTIONS=3Dy
>
> #
> # Texas Instruments shared transport line discipline
> #
> CONFIG_TI_ST=3Dm
> CONFIG_SENSORS_LIS3_I2C=3Dm
>
> #
> # Altera FPGA firmware download module
> #
> CONFIG_ALTERA_STAPL=3Dm
> CONFIG_INTEL_MEI=3Dm
> CONFIG_INTEL_MEI_ME=3Dm
> CONFIG_INTEL_MEI_TXE=3Dm
> CONFIG_VMWARE_VMCI=3Dm
>
> #
> # Intel MIC Bus Driver
> #
> CONFIG_INTEL_MIC_BUS=3Dm
>
> #
> # SCIF Bus Driver
> #
> CONFIG_SCIF_BUS=3Dm
>
> #
> # VOP Bus Driver
> #
> CONFIG_VOP_BUS=3Dm
>
> #
> # Intel MIC Host Driver
> #
> CONFIG_INTEL_MIC_HOST=3Dm
>
> #
> # Intel MIC Card Driver
> #
> CONFIG_INTEL_MIC_CARD=3Dm
>
> #
> # SCIF Driver
> #
> CONFIG_SCIF=3Dm
>
> #
> # Intel MIC Coprocessor State Management (COSM) Drivers
> #
> CONFIG_MIC_COSM=3Dm
>
> #
> # VOP Driver
> #
> CONFIG_VOP=3Dm
> CONFIG_VHOST_RING=3Dm
> CONFIG_GENWQE=3Dm
> CONFIG_GENWQE_PLATFORM_ERROR_RECOVERY=3D0
> CONFIG_ECHO=3Dm
> # CONFIG_CXL_BASE is not set
> # CONFIG_CXL_AFU_DRIVER_OPS is not set
> CONFIG_HAVE_IDE=3Dy
> # CONFIG_IDE is not set
>
> #
> # SCSI device support
> #
> CONFIG_SCSI_MOD=3Dm
> CONFIG_RAID_ATTRS=3Dm
> CONFIG_SCSI=3Dm
> CONFIG_SCSI_DMA=3Dy
> CONFIG_SCSI_NETLINK=3Dy
> # CONFIG_SCSI_MQ_DEFAULT is not set
> CONFIG_SCSI_PROC_FS=3Dy
>
> #
> # SCSI support type (disk, tape, CD-ROM)
> #
> CONFIG_BLK_DEV_SD=3Dm
> CONFIG_CHR_DEV_ST=3Dm
> CONFIG_CHR_DEV_OSST=3Dm
> CONFIG_BLK_DEV_SR=3Dm
> CONFIG_BLK_DEV_SR_VENDOR=3Dy
> CONFIG_CHR_DEV_SG=3Dm
> CONFIG_CHR_DEV_SCH=3Dm
> CONFIG_SCSI_ENCLOSURE=3Dm
> # CONFIG_SCSI_CONSTANTS is not set
> # CONFIG_SCSI_LOGGING is not set
> CONFIG_SCSI_SCAN_ASYNC=3Dy
>
> #
> # SCSI Transports
> #
> CONFIG_SCSI_SPI_ATTRS=3Dm
> CONFIG_SCSI_FC_ATTRS=3Dm
> CONFIG_SCSI_ISCSI_ATTRS=3Dm
> CONFIG_SCSI_SAS_ATTRS=3Dm
> CONFIG_SCSI_SAS_LIBSAS=3Dm
> CONFIG_SCSI_SAS_ATA=3Dy
> CONFIG_SCSI_SAS_HOST_SMP=3Dy
> CONFIG_SCSI_SRP_ATTRS=3Dm
> CONFIG_SCSI_LOWLEVEL=3Dy
> CONFIG_ISCSI_TCP=3Dm
> CONFIG_ISCSI_BOOT_SYSFS=3Dm
> CONFIG_SCSI_CXGB3_ISCSI=3Dm
> CONFIG_SCSI_CXGB4_ISCSI=3Dm
> CONFIG_SCSI_BNX2_ISCSI=3Dm
> CONFIG_SCSI_BNX2X_FCOE=3Dm
> CONFIG_BE2ISCSI=3Dm
> CONFIG_BLK_DEV_3W_XXXX_RAID=3Dm
> CONFIG_SCSI_HPSA=3Dm
> CONFIG_SCSI_3W_9XXX=3Dm
> CONFIG_SCSI_3W_SAS=3Dm
> CONFIG_SCSI_ACARD=3Dm
> CONFIG_SCSI_AACRAID=3Dm
> CONFIG_SCSI_AIC7XXX=3Dm
> CONFIG_AIC7XXX_CMDS_PER_DEVICE=3D32
> CONFIG_AIC7XXX_RESET_DELAY_MS=3D15000
> # CONFIG_AIC7XXX_DEBUG_ENABLE is not set
> CONFIG_AIC7XXX_DEBUG_MASK=3D0
> CONFIG_AIC7XXX_REG_PRETTY_PRINT=3Dy
> CONFIG_SCSI_AIC79XX=3Dm
> CONFIG_AIC79XX_CMDS_PER_DEVICE=3D32
> CONFIG_AIC79XX_RESET_DELAY_MS=3D15000
> # CONFIG_AIC79XX_DEBUG_ENABLE is not set
> CONFIG_AIC79XX_DEBUG_MASK=3D0
> CONFIG_AIC79XX_REG_PRETTY_PRINT=3Dy
> CONFIG_SCSI_AIC94XX=3Dm
> # CONFIG_AIC94XX_DEBUG is not set
> CONFIG_SCSI_MVSAS=3Dm
> # CONFIG_SCSI_MVSAS_DEBUG is not set
> CONFIG_SCSI_MVSAS_TASKLET=3Dy
> CONFIG_SCSI_MVUMI=3Dm
> CONFIG_SCSI_DPT_I2O=3Dm
> CONFIG_SCSI_ADVANSYS=3Dm
> CONFIG_SCSI_ARCMSR=3Dm
> CONFIG_SCSI_ESAS2R=3Dm
> CONFIG_MEGARAID_NEWGEN=3Dy
> CONFIG_MEGARAID_MM=3Dm
> CONFIG_MEGARAID_MAILBOX=3Dm
> CONFIG_MEGARAID_LEGACY=3Dm
> CONFIG_MEGARAID_SAS=3Dm
> CONFIG_SCSI_MPT3SAS=3Dm
> CONFIG_SCSI_MPT2SAS_MAX_SGE=3D128
> CONFIG_SCSI_MPT3SAS_MAX_SGE=3D128
> CONFIG_SCSI_MPT2SAS=3Dm
> CONFIG_SCSI_SMARTPQI=3Dm
> CONFIG_SCSI_UFSHCD=3Dm
> CONFIG_SCSI_UFSHCD_PCI=3Dm
> # CONFIG_SCSI_UFS_DWC_TC_PCI is not set
> CONFIG_SCSI_UFSHCD_PLATFORM=3Dm
> # CONFIG_SCSI_UFS_DWC_TC_PLATFORM is not set
> CONFIG_SCSI_HPTIOP=3Dm
> CONFIG_SCSI_BUSLOGIC=3Dm
> CONFIG_SCSI_FLASHPOINT=3Dy
> CONFIG_VMWARE_PVSCSI=3Dm
> # CONFIG_XEN_SCSI_FRONTEND is not set
> CONFIG_HYPERV_STORAGE=3Dm
> CONFIG_LIBFC=3Dm
> CONFIG_LIBFCOE=3Dm
> CONFIG_FCOE=3Dm
> CONFIG_FCOE_FNIC=3Dm
> CONFIG_SCSI_SNIC=3Dm
> # CONFIG_SCSI_SNIC_DEBUG_FS is not set
> CONFIG_SCSI_DMX3191D=3Dm
> CONFIG_SCSI_EATA=3Dm
> # CONFIG_SCSI_EATA_TAGGED_QUEUE is not set
> # CONFIG_SCSI_EATA_LINKED_COMMANDS is not set
> CONFIG_SCSI_EATA_MAX_TAGS=3D16
> CONFIG_SCSI_FUTURE_DOMAIN=3Dm
> CONFIG_SCSI_GDTH=3Dm
> CONFIG_SCSI_ISCI=3Dm
> CONFIG_SCSI_IPS=3Dm
> CONFIG_SCSI_INITIO=3Dm
> CONFIG_SCSI_INIA100=3Dm
> CONFIG_SCSI_PPA=3Dm
> CONFIG_SCSI_IMM=3Dm
> # CONFIG_SCSI_IZIP_EPP16 is not set
> # CONFIG_SCSI_IZIP_SLOW_CTR is not set
> CONFIG_SCSI_STEX=3Dm
> CONFIG_SCSI_SYM53C8XX_2=3Dm
> CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=3D1
> CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=3D16
> CONFIG_SCSI_SYM53C8XX_MAX_TAGS=3D64
> CONFIG_SCSI_SYM53C8XX_MMIO=3Dy
> CONFIG_SCSI_IPR=3Dm
> # CONFIG_SCSI_IPR_TRACE is not set
> # CONFIG_SCSI_IPR_DUMP is not set
> CONFIG_SCSI_QLOGIC_1280=3Dm
> CONFIG_SCSI_QLA_FC=3Dm
> CONFIG_TCM_QLA2XXX=3Dm
> # CONFIG_TCM_QLA2XXX_DEBUG is not set
> CONFIG_SCSI_QLA_ISCSI=3Dm
> # CONFIG_QEDI is not set
> # CONFIG_QEDF is not set
> CONFIG_SCSI_LPFC=3Dm
> # CONFIG_SCSI_LPFC_DEBUG_FS is not set
> CONFIG_SCSI_DC395x=3Dm
> CONFIG_SCSI_AM53C974=3Dm
> CONFIG_SCSI_WD719X=3Dm
> # CONFIG_SCSI_DEBUG is not set
> CONFIG_SCSI_PMCRAID=3Dm
> CONFIG_SCSI_PM8001=3Dm
> CONFIG_SCSI_BFA_FC=3Dm
> CONFIG_SCSI_VIRTIO=3Dm
> CONFIG_SCSI_CHELSIO_FCOE=3Dm
> CONFIG_SCSI_LOWLEVEL_PCMCIA=3Dy
> CONFIG_PCMCIA_AHA152X=3Dm
> CONFIG_PCMCIA_FDOMAIN=3Dm
> CONFIG_PCMCIA_QLOGIC=3Dm
> CONFIG_PCMCIA_SYM53C500=3Dm
> CONFIG_SCSI_DH=3Dy
> CONFIG_SCSI_DH_RDAC=3Dm
> CONFIG_SCSI_DH_HP_SW=3Dm
> CONFIG_SCSI_DH_EMC=3Dm
> CONFIG_SCSI_DH_ALUA=3Dm
> CONFIG_SCSI_OSD_INITIATOR=3Dm
> CONFIG_SCSI_OSD_ULD=3Dm
> CONFIG_SCSI_OSD_DPRINT_SENSE=3D0
> # CONFIG_SCSI_OSD_DEBUG is not set
> CONFIG_ATA=3Dm
> # CONFIG_ATA_NONSTANDARD is not set
> CONFIG_ATA_VERBOSE_ERROR=3Dy
> CONFIG_ATA_ACPI=3Dy
> CONFIG_SATA_ZPODD=3Dy
> CONFIG_SATA_PMP=3Dy
>
> #
> # Controllers with non-SFF native interface
> #
> CONFIG_SATA_AHCI=3Dm
> CONFIG_SATA_AHCI_PLATFORM=3Dm
> CONFIG_SATA_INIC162X=3Dm
> CONFIG_SATA_ACARD_AHCI=3Dm
> CONFIG_SATA_SIL24=3Dm
> CONFIG_ATA_SFF=3Dy
>
> #
> # SFF controllers with custom DMA interface
> #
> CONFIG_PDC_ADMA=3Dm
> CONFIG_SATA_QSTOR=3Dm
> CONFIG_SATA_SX4=3Dm
> CONFIG_ATA_BMDMA=3Dy
>
> #
> # SATA SFF controllers with BMDMA
> #
> CONFIG_ATA_PIIX=3Dm
> CONFIG_SATA_DWC=3Dm
> # CONFIG_SATA_DWC_OLD_DMA is not set
> # CONFIG_SATA_DWC_DEBUG is not set
> CONFIG_SATA_MV=3Dm
> CONFIG_SATA_NV=3Dm
> CONFIG_SATA_PROMISE=3Dm
> CONFIG_SATA_SIL=3Dm
> CONFIG_SATA_SIS=3Dm
> CONFIG_SATA_SVW=3Dm
> CONFIG_SATA_ULI=3Dm
> CONFIG_SATA_VIA=3Dm
> CONFIG_SATA_VITESSE=3Dm
>
> #
> # PATA SFF controllers with BMDMA
> #
> CONFIG_PATA_ALI=3Dm
> CONFIG_PATA_AMD=3Dm
> CONFIG_PATA_ARTOP=3Dm
> CONFIG_PATA_ATIIXP=3Dm
> CONFIG_PATA_ATP867X=3Dm
> CONFIG_PATA_CMD64X=3Dm
> CONFIG_PATA_CYPRESS=3Dm
> CONFIG_PATA_EFAR=3Dm
> CONFIG_PATA_HPT366=3Dm
> CONFIG_PATA_HPT37X=3Dm
> CONFIG_PATA_HPT3X2N=3Dm
> CONFIG_PATA_HPT3X3=3Dm
> # CONFIG_PATA_HPT3X3_DMA is not set
> CONFIG_PATA_IT8213=3Dm
> CONFIG_PATA_IT821X=3Dm
> CONFIG_PATA_JMICRON=3Dm
> CONFIG_PATA_MARVELL=3Dm
> CONFIG_PATA_NETCELL=3Dm
> CONFIG_PATA_NINJA32=3Dm
> CONFIG_PATA_NS87415=3Dm
> CONFIG_PATA_OLDPIIX=3Dm
> CONFIG_PATA_OPTIDMA=3Dm
> CONFIG_PATA_PDC2027X=3Dm
> CONFIG_PATA_PDC_OLD=3Dm
> CONFIG_PATA_RADISYS=3Dm
> CONFIG_PATA_RDC=3Dm
> CONFIG_PATA_SCH=3Dm
> CONFIG_PATA_SERVERWORKS=3Dm
> CONFIG_PATA_SIL680=3Dm
> CONFIG_PATA_SIS=3Dm
> CONFIG_PATA_TOSHIBA=3Dm
> CONFIG_PATA_TRIFLEX=3Dm
> CONFIG_PATA_VIA=3Dm
> CONFIG_PATA_WINBOND=3Dm
>
> #
> # PIO-only SFF controllers
> #
> CONFIG_PATA_CMD640_PCI=3Dm
> CONFIG_PATA_MPIIX=3Dm
> CONFIG_PATA_NS87410=3Dm
> CONFIG_PATA_OPTI=3Dm
> CONFIG_PATA_PCMCIA=3Dm
> CONFIG_PATA_RZ1000=3Dm
>
> #
> # Generic fallback / legacy drivers
> #
> CONFIG_PATA_ACPI=3Dm
> CONFIG_ATA_GENERIC=3Dm
> CONFIG_PATA_LEGACY=3Dm
> CONFIG_MD=3Dy
> CONFIG_BLK_DEV_MD=3Dm
> CONFIG_MD_LINEAR=3Dm
> CONFIG_MD_RAID0=3Dm
> CONFIG_MD_RAID1=3Dm
> CONFIG_MD_RAID10=3Dm
> CONFIG_MD_RAID456=3Dm
> CONFIG_MD_MULTIPATH=3Dm
> CONFIG_MD_FAULTY=3Dm
> # CONFIG_MD_CLUSTER is not set
> CONFIG_BCACHE=3Dm
> # CONFIG_BCACHE_DEBUG is not set
> # CONFIG_BCACHE_CLOSURES_DEBUG is not set
> CONFIG_BLK_DEV_DM_BUILTIN=3Dy
> CONFIG_BLK_DEV_DM=3Dm
> # CONFIG_DM_MQ_DEFAULT is not set
> # CONFIG_DM_DEBUG is not set
> CONFIG_DM_BUFIO=3Dm
> # CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
> CONFIG_DM_BIO_PRISON=3Dm
> CONFIG_DM_PERSISTENT_DATA=3Dm
> CONFIG_DM_CRYPT=3Dm
> CONFIG_DM_SNAPSHOT=3Dm
> CONFIG_DM_THIN_PROVISIONING=3Dm
> CONFIG_DM_CACHE=3Dm
> CONFIG_DM_CACHE_SMQ=3Dm
> CONFIG_DM_ERA=3Dm
> CONFIG_DM_MIRROR=3Dm
> CONFIG_DM_LOG_USERSPACE=3Dm
> CONFIG_DM_RAID=3Dm
> CONFIG_DM_ZERO=3Dm
> CONFIG_DM_MULTIPATH=3Dm
> CONFIG_DM_MULTIPATH_QL=3Dm
> CONFIG_DM_MULTIPATH_ST=3Dm
> CONFIG_DM_DELAY=3Dm
> CONFIG_DM_UEVENT=3Dy
> CONFIG_DM_FLAKEY=3Dm
> CONFIG_DM_VERITY=3Dm
> CONFIG_DM_VERITY_FEC=3Dy
> CONFIG_DM_SWITCH=3Dm
> CONFIG_DM_LOG_WRITES=3Dm
> # CONFIG_DM_INTEGRITY is not set
> CONFIG_TARGET_CORE=3Dm
> CONFIG_TCM_IBLOCK=3Dm
> CONFIG_TCM_FILEIO=3Dm
> CONFIG_TCM_PSCSI=3Dm
> CONFIG_TCM_USER2=3Dm
> CONFIG_LOOPBACK_TARGET=3Dm
> CONFIG_TCM_FC=3Dm
> CONFIG_ISCSI_TARGET=3Dm
> CONFIG_ISCSI_TARGET_CXGB4=3Dm
> CONFIG_SBP_TARGET=3Dm
> CONFIG_FUSION=3Dy
> CONFIG_FUSION_SPI=3Dm
> CONFIG_FUSION_FC=3Dm
> CONFIG_FUSION_SAS=3Dm
> CONFIG_FUSION_MAX_SGE=3D128
> CONFIG_FUSION_CTL=3Dm
> # CONFIG_FUSION_LOGGING is not set
>
> #
> # IEEE 1394 (FireWire) support
> #
> CONFIG_FIREWIRE=3Dm
> CONFIG_FIREWIRE_OHCI=3Dm
> CONFIG_FIREWIRE_SBP2=3Dm
> CONFIG_FIREWIRE_NET=3Dm
> CONFIG_FIREWIRE_NOSY=3Dm
> CONFIG_MACINTOSH_DRIVERS=3Dy
> CONFIG_MAC_EMUMOUSEBTN=3Dm
> CONFIG_NETDEVICES=3Dy
> CONFIG_MII=3Dm
> CONFIG_NET_CORE=3Dy
> CONFIG_BONDING=3Dm
> CONFIG_DUMMY=3Dm
> CONFIG_EQUALIZER=3Dm
> # CONFIG_NET_FC is not set
> CONFIG_IFB=3Dm
> CONFIG_NET_TEAM=3Dm
> CONFIG_NET_TEAM_MODE_BROADCAST=3Dm
> CONFIG_NET_TEAM_MODE_ROUNDROBIN=3Dm
> CONFIG_NET_TEAM_MODE_RANDOM=3Dm
> CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=3Dm
> CONFIG_NET_TEAM_MODE_LOADBALANCE=3Dm
> CONFIG_MACVLAN=3Dm
> CONFIG_MACVTAP=3Dm
> CONFIG_IPVLAN=3Dm
> # CONFIG_IPVTAP is not set
> CONFIG_VXLAN=3Dm
> CONFIG_GENEVE=3Dm
> CONFIG_GTP=3Dm
> CONFIG_MACSEC=3Dm
> CONFIG_NETCONSOLE=3Dm
> CONFIG_NETCONSOLE_DYNAMIC=3Dy
> CONFIG_NETPOLL=3Dy
> CONFIG_NET_POLL_CONTROLLER=3Dy
> CONFIG_TUN=3Dm
> CONFIG_TAP=3Dm
> # CONFIG_TUN_VNET_CROSS_LE is not set
> CONFIG_VETH=3Dm
> CONFIG_VIRTIO_NET=3Dm
> CONFIG_NLMON=3Dm
> CONFIG_NET_VRF=3Dm
> # CONFIG_VSOCKMON is not set
> CONFIG_SUNGEM_PHY=3Dm
> # CONFIG_ARCNET is not set
> CONFIG_ATM_DRIVERS=3Dy
> # CONFIG_ATM_DUMMY is not set
> CONFIG_ATM_TCP=3Dm
> CONFIG_ATM_LANAI=3Dm
> CONFIG_ATM_ENI=3Dm
> # CONFIG_ATM_ENI_DEBUG is not set
> # CONFIG_ATM_ENI_TUNE_BURST is not set
> CONFIG_ATM_FIRESTREAM=3Dm
> CONFIG_ATM_ZATM=3Dm
> # CONFIG_ATM_ZATM_DEBUG is not set
> CONFIG_ATM_NICSTAR=3Dm
> # CONFIG_ATM_NICSTAR_USE_SUNI is not set
> # CONFIG_ATM_NICSTAR_USE_IDT77105 is not set
> CONFIG_ATM_IDT77252=3Dm
> # CONFIG_ATM_IDT77252_DEBUG is not set
> # CONFIG_ATM_IDT77252_RCV_ALL is not set
> CONFIG_ATM_IDT77252_USE_SUNI=3Dy
> CONFIG_ATM_AMBASSADOR=3Dm
> # CONFIG_ATM_AMBASSADOR_DEBUG is not set
> CONFIG_ATM_HORIZON=3Dm
> # CONFIG_ATM_HORIZON_DEBUG is not set
> CONFIG_ATM_IA=3Dm
> # CONFIG_ATM_IA_DEBUG is not set
> CONFIG_ATM_FORE200E=3Dm
> # CONFIG_ATM_FORE200E_USE_TASKLET is not set
> CONFIG_ATM_FORE200E_TX_RETRY=3D16
> CONFIG_ATM_FORE200E_DEBUG=3D0
> CONFIG_ATM_HE=3Dm
> # CONFIG_ATM_HE_USE_SUNI is not set
> CONFIG_ATM_SOLOS=3Dm
>
> #
> # CAIF transport drivers
> #
> CONFIG_CAIF_TTY=3Dm
> CONFIG_CAIF_SPI_SLAVE=3Dm
> CONFIG_CAIF_SPI_SYNC=3Dy
> CONFIG_CAIF_HSI=3Dm
> CONFIG_CAIF_VIRTIO=3Dm
>
> #
> # Distributed Switch Architecture drivers
> #
> CONFIG_NET_DSA_MV88E6060=3Dm
> CONFIG_B53=3Dm
> CONFIG_B53_SPI_DRIVER=3Dm
> CONFIG_B53_MDIO_DRIVER=3Dm
> CONFIG_B53_MMAP_DRIVER=3Dm
> CONFIG_B53_SRAB_DRIVER=3Dm
> CONFIG_NET_DSA_MV88E6XXX=3Dm
> CONFIG_NET_DSA_MV88E6XXX_GLOBAL2=3Dy
> CONFIG_NET_DSA_QCA8K=3Dm
> # CONFIG_NET_DSA_LOOP is not set
> # CONFIG_NET_DSA_MT7530 is not set
> # CONFIG_NET_DSA_SMSC_LAN9303_I2C is not set
> # CONFIG_NET_DSA_SMSC_LAN9303_MDIO is not set
> CONFIG_ETHERNET=3Dy
> CONFIG_MDIO=3Dm
> CONFIG_NET_VENDOR_3COM=3Dy
> CONFIG_PCMCIA_3C574=3Dm
> CONFIG_PCMCIA_3C589=3Dm
> CONFIG_VORTEX=3Dm
> CONFIG_TYPHOON=3Dm
> CONFIG_NET_VENDOR_ADAPTEC=3Dy
> CONFIG_ADAPTEC_STARFIRE=3Dm
> CONFIG_NET_VENDOR_AGERE=3Dy
> CONFIG_ET131X=3Dm
> CONFIG_NET_VENDOR_ALACRITECH=3Dy
> CONFIG_SLICOSS=3Dm
> CONFIG_NET_VENDOR_ALTEON=3Dy
> CONFIG_ACENIC=3Dm
> # CONFIG_ACENIC_OMIT_TIGON_I is not set
> CONFIG_ALTERA_TSE=3Dm
> CONFIG_NET_VENDOR_AMAZON=3Dy
> CONFIG_ENA_ETHERNET=3Dm
> CONFIG_NET_VENDOR_AMD=3Dy
> CONFIG_AMD8111_ETH=3Dm
> CONFIG_PCNET32=3Dm
> CONFIG_PCMCIA_NMCLAN=3Dm
> # CONFIG_AMD_XGBE is not set
> # CONFIG_AMD_XGBE_HAVE_ECC is not set
> CONFIG_NET_VENDOR_AQUANTIA=3Dy
> # CONFIG_AQTION is not set
> CONFIG_NET_VENDOR_ARC=3Dy
> CONFIG_NET_VENDOR_ATHEROS=3Dy
> CONFIG_ATL2=3Dm
> CONFIG_ATL1=3Dm
> CONFIG_ATL1E=3Dm
> CONFIG_ATL1C=3Dm
> CONFIG_ALX=3Dm
> CONFIG_NET_VENDOR_AURORA=3Dy
> CONFIG_AURORA_NB8800=3Dm
> CONFIG_NET_CADENCE=3Dy
> CONFIG_MACB=3Dm
> # CONFIG_MACB_PCI is not set
> CONFIG_NET_VENDOR_BROADCOM=3Dy
> CONFIG_B44=3Dm
> CONFIG_B44_PCI_AUTOSELECT=3Dy
> CONFIG_B44_PCICORE_AUTOSELECT=3Dy
> CONFIG_B44_PCI=3Dy
> CONFIG_BCMGENET=3Dm
> CONFIG_BNX2=3Dm
> CONFIG_CNIC=3Dm
> CONFIG_TIGON3=3Dm
> CONFIG_TIGON3_HWMON=3Dy
> CONFIG_BNX2X=3Dm
> CONFIG_BNX2X_SRIOV=3Dy
> CONFIG_BNXT=3Dm
> CONFIG_BNXT_SRIOV=3Dy
> CONFIG_NET_VENDOR_BROCADE=3Dy
> CONFIG_BNA=3Dm
> # CONFIG_NET_VENDOR_CAVIUM is not set
> CONFIG_NET_VENDOR_CHELSIO=3Dy
> CONFIG_CHELSIO_T1=3Dm
> CONFIG_CHELSIO_T1_1G=3Dy
> CONFIG_CHELSIO_T3=3Dm
> CONFIG_CHELSIO_T4=3Dm
> CONFIG_CHELSIO_T4VF=3Dm
> CONFIG_CHELSIO_LIB=3Dm
> CONFIG_NET_VENDOR_CISCO=3Dy
> CONFIG_ENIC=3Dm
> CONFIG_CX_ECAT=3Dm
> CONFIG_DNET=3Dm
> CONFIG_NET_VENDOR_DEC=3Dy
> CONFIG_NET_TULIP=3Dy
> CONFIG_DE2104X=3Dm
> CONFIG_DE2104X_DSL=3D0
> CONFIG_TULIP=3Dm
> # CONFIG_TULIP_MWI is not set
> # CONFIG_TULIP_MMIO is not set
> # CONFIG_TULIP_NAPI is not set
> CONFIG_DE4X5=3Dm
> CONFIG_WINBOND_840=3Dm
> CONFIG_DM9102=3Dm
> CONFIG_ULI526X=3Dm
> CONFIG_PCMCIA_XIRCOM=3Dm
> CONFIG_NET_VENDOR_DLINK=3Dy
> CONFIG_DL2K=3Dm
> CONFIG_SUNDANCE=3Dm
> # CONFIG_SUNDANCE_MMIO is not set
> CONFIG_NET_VENDOR_EMULEX=3Dy
> CONFIG_BE2NET=3Dm
> CONFIG_BE2NET_HWMON=3Dy
> # CONFIG_NET_VENDOR_EZCHIP is not set
> CONFIG_NET_VENDOR_EXAR=3Dy
> CONFIG_S2IO=3Dm
> CONFIG_VXGE=3Dm
> # CONFIG_VXGE_DEBUG_TRACE_ALL is not set
> CONFIG_NET_VENDOR_FUJITSU=3Dy
> CONFIG_PCMCIA_FMVJ18X=3Dm
> CONFIG_NET_VENDOR_HP=3Dy
> CONFIG_HP100=3Dm
> CONFIG_NET_VENDOR_INTEL=3Dy
> CONFIG_E100=3Dm
> CONFIG_E1000=3Dm
> CONFIG_E1000E=3Dm
> CONFIG_E1000E_HWTS=3Dy
> CONFIG_IGB=3Dm
> CONFIG_IGB_HWMON=3Dy
> CONFIG_IGB_DCA=3Dy
> CONFIG_IGBVF=3Dm
> CONFIG_IXGB=3Dm
> CONFIG_IXGBE=3Dm
> CONFIG_IXGBE_HWMON=3Dy
> CONFIG_IXGBE_DCA=3Dy
> CONFIG_IXGBEVF=3Dm
> CONFIG_I40E=3Dm
> CONFIG_I40EVF=3Dm
> CONFIG_FM10K=3Dm
> CONFIG_NET_VENDOR_I825XX=3Dy
> CONFIG_JME=3Dm
> CONFIG_NET_VENDOR_MARVELL=3Dy
> CONFIG_MVMDIO=3Dm
> CONFIG_SKGE=3Dm
> # CONFIG_SKGE_DEBUG is not set
> CONFIG_SKGE_GENESIS=3Dy
> CONFIG_SKY2=3Dm
> # CONFIG_SKY2_DEBUG is not set
> CONFIG_NET_VENDOR_MELLANOX=3Dy
> CONFIG_MLX4_EN=3Dm
> CONFIG_MLX4_CORE=3Dm
> CONFIG_MLX4_DEBUG=3Dy
> CONFIG_MLX5_CORE=3Dm
> CONFIG_MLX5_CORE_EN=3Dy
> # CONFIG_MLX5_CORE_IPOIB is not set
> CONFIG_MLXSW_CORE=3Dm
> CONFIG_MLXSW_CORE_HWMON=3Dy
> CONFIG_MLXSW_CORE_THERMAL=3Dy
> CONFIG_MLXSW_PCI=3Dm
> CONFIG_MLXSW_I2C=3Dm
> CONFIG_MLXSW_SWITCHIB=3Dm
> CONFIG_MLXSW_SWITCHX2=3Dm
> CONFIG_MLXSW_SPECTRUM=3Dm
> CONFIG_MLXSW_MINIMAL=3Dm
> CONFIG_NET_VENDOR_MICREL=3Dy
> CONFIG_KS8842=3Dm
> CONFIG_KS8851=3Dm
> CONFIG_KS8851_MLL=3Dm
> CONFIG_KSZ884X_PCI=3Dm
> CONFIG_NET_VENDOR_MICROCHIP=3Dy
> CONFIG_ENC28J60=3Dm
> # CONFIG_ENC28J60_WRITEVERIFY is not set
> CONFIG_ENCX24J600=3Dm
> CONFIG_NET_VENDOR_MYRI=3Dy
> CONFIG_MYRI10GE=3Dm
> CONFIG_MYRI10GE_DCA=3Dy
> CONFIG_FEALNX=3Dm
> CONFIG_NET_VENDOR_NATSEMI=3Dy
> CONFIG_NATSEMI=3Dm
> CONFIG_NS83820=3Dm
> CONFIG_NET_VENDOR_NETRONOME=3Dy
> # CONFIG_NFP is not set
> CONFIG_NET_VENDOR_8390=3Dy
> CONFIG_PCMCIA_AXNET=3Dm
> CONFIG_NE2K_PCI=3Dm
> CONFIG_PCMCIA_PCNET=3Dm
> CONFIG_NET_VENDOR_NVIDIA=3Dy
> CONFIG_FORCEDETH=3Dm
> CONFIG_NET_VENDOR_OKI=3Dy
> CONFIG_ETHOC=3Dm
> CONFIG_NET_PACKET_ENGINE=3Dy
> CONFIG_HAMACHI=3Dm
> CONFIG_YELLOWFIN=3Dm
> CONFIG_NET_VENDOR_QLOGIC=3Dy
> CONFIG_QLA3XXX=3Dm
> CONFIG_QLCNIC=3Dm
> CONFIG_QLCNIC_SRIOV=3Dy
> CONFIG_QLCNIC_HWMON=3Dy
> CONFIG_QLGE=3Dm
> CONFIG_NETXEN_NIC=3Dm
> CONFIG_QED=3Dm
> CONFIG_QED_SRIOV=3Dy
> CONFIG_QEDE=3Dm
> CONFIG_NET_VENDOR_QUALCOMM=3Dy
> CONFIG_QCOM_EMAC=3Dm
> CONFIG_NET_VENDOR_REALTEK=3Dy
> CONFIG_ATP=3Dm
> CONFIG_8139CP=3Dm
> CONFIG_8139TOO=3Dm
> # CONFIG_8139TOO_PIO is not set
> CONFIG_8139TOO_TUNE_TWISTER=3Dy
> CONFIG_8139TOO_8129=3Dy
> # CONFIG_8139_OLD_RX_RESET is not set
> CONFIG_R8169=3Dm
> # CONFIG_NET_VENDOR_RENESAS is not set
> CONFIG_NET_VENDOR_RDC=3Dy
> CONFIG_R6040=3Dm
> CONFIG_NET_VENDOR_ROCKER=3Dy
> CONFIG_ROCKER=3Dm
> CONFIG_NET_VENDOR_SAMSUNG=3Dy
> CONFIG_SXGBE_ETH=3Dm
> CONFIG_NET_VENDOR_SEEQ=3Dy
> CONFIG_NET_VENDOR_SILAN=3Dy
> CONFIG_SC92031=3Dm
> CONFIG_NET_VENDOR_SIS=3Dy
> CONFIG_SIS900=3Dm
> CONFIG_SIS190=3Dm
> CONFIG_NET_VENDOR_SOLARFLARE=3Dy
> CONFIG_SFC=3Dm
> CONFIG_SFC_MTD=3Dy
> CONFIG_SFC_MCDI_MON=3Dy
> CONFIG_SFC_SRIOV=3Dy
> CONFIG_SFC_MCDI_LOGGING=3Dy
> # CONFIG_SFC_FALCON is not set
> CONFIG_NET_VENDOR_SMSC=3Dy
> CONFIG_PCMCIA_SMC91C92=3Dm
> CONFIG_EPIC100=3Dm
> CONFIG_SMSC911X=3Dm
> # CONFIG_SMSC911X_ARCH_HOOKS is not set
> CONFIG_SMSC9420=3Dm
> CONFIG_NET_VENDOR_STMICRO=3Dy
> CONFIG_STMMAC_ETH=3Dm
> # CONFIG_STMMAC_PLATFORM is not set
> CONFIG_STMMAC_PCI=3Dm
> CONFIG_NET_VENDOR_SUN=3Dy
> CONFIG_HAPPYMEAL=3Dm
> CONFIG_SUNGEM=3Dm
> CONFIG_CASSINI=3Dm
> CONFIG_NIU=3Dm
> CONFIG_NET_VENDOR_TEHUTI=3Dy
> CONFIG_TEHUTI=3Dm
> CONFIG_NET_VENDOR_TI=3Dy
> CONFIG_TI_CPSW_ALE=3Dm
> CONFIG_TLAN=3Dm
> CONFIG_NET_VENDOR_VIA=3Dy
> CONFIG_VIA_RHINE=3Dm
> # CONFIG_VIA_RHINE_MMIO is not set
> CONFIG_VIA_VELOCITY=3Dm
> CONFIG_NET_VENDOR_WIZNET=3Dy
> CONFIG_WIZNET_W5100=3Dm
> CONFIG_WIZNET_W5300=3Dm
> # CONFIG_WIZNET_BUS_DIRECT is not set
> # CONFIG_WIZNET_BUS_INDIRECT is not set
> CONFIG_WIZNET_BUS_ANY=3Dy
> CONFIG_WIZNET_W5100_SPI=3Dm
> CONFIG_NET_VENDOR_XIRCOM=3Dy
> CONFIG_PCMCIA_XIRC2PS=3Dm
> CONFIG_NET_VENDOR_SYNOPSYS=3Dy
> # CONFIG_DWC_XLGMAC is not set
> # CONFIG_FDDI is not set
> # CONFIG_HIPPI is not set
> CONFIG_NET_SB1000=3Dm
> CONFIG_MDIO_DEVICE=3Dm
> CONFIG_MDIO_BITBANG=3Dm
> CONFIG_MDIO_CAVIUM=3Dm
> # CONFIG_MDIO_GPIO is not set
> CONFIG_MDIO_OCTEON=3Dm
> # CONFIG_MDIO_THUNDER is not set
> CONFIG_PHYLIB=3Dm
> CONFIG_SWPHY=3Dy
> # CONFIG_LED_TRIGGER_PHY is not set
>
> #
> # MII PHY device drivers
> #
> CONFIG_AMD_PHY=3Dm
> CONFIG_AQUANTIA_PHY=3Dm
> CONFIG_AT803X_PHY=3Dm
> CONFIG_BCM7XXX_PHY=3Dm
> CONFIG_BCM87XX_PHY=3Dm
> CONFIG_BCM_NET_PHYLIB=3Dm
> CONFIG_BROADCOM_PHY=3Dm
> CONFIG_CICADA_PHY=3Dm
> CONFIG_DAVICOM_PHY=3Dm
> CONFIG_DP83848_PHY=3Dm
> CONFIG_DP83867_PHY=3Dm
> CONFIG_FIXED_PHY=3Dm
> CONFIG_ICPLUS_PHY=3Dm
> CONFIG_INTEL_XWAY_PHY=3Dm
> CONFIG_LSI_ET1011C_PHY=3Dm
> CONFIG_LXT_PHY=3Dm
> CONFIG_MARVELL_PHY=3Dm
> CONFIG_MICREL_PHY=3Dm
> CONFIG_MICROCHIP_PHY=3Dm
> CONFIG_MICROSEMI_PHY=3Dm
> CONFIG_NATIONAL_PHY=3Dm
> CONFIG_QSEMI_PHY=3Dm
> CONFIG_REALTEK_PHY=3Dm
> CONFIG_SMSC_PHY=3Dm
> CONFIG_STE10XP=3Dm
> CONFIG_TERANETICS_PHY=3Dm
> CONFIG_VITESSE_PHY=3Dm
> CONFIG_XILINX_GMII2RGMII=3Dm
> # CONFIG_MICREL_KS8995MA is not set
> CONFIG_PLIP=3Dm
> CONFIG_PPP=3Dm
> CONFIG_PPP_BSDCOMP=3Dm
> CONFIG_PPP_DEFLATE=3Dm
> CONFIG_PPP_FILTER=3Dy
> CONFIG_PPP_MPPE=3Dm
> CONFIG_PPP_MULTILINK=3Dy
> CONFIG_PPPOATM=3Dm
> CONFIG_PPPOE=3Dm
> CONFIG_PPTP=3Dm
> CONFIG_PPPOL2TP=3Dm
> CONFIG_PPP_ASYNC=3Dm
> CONFIG_PPP_SYNC_TTY=3Dm
> CONFIG_SLIP=3Dm
> CONFIG_SLHC=3Dm
> # CONFIG_SLIP_COMPRESSED is not set
> # CONFIG_SLIP_SMART is not set
> # CONFIG_SLIP_MODE_SLIP6 is not set
>
> #
> # Host-side USB support is needed for USB Network Adapter support
> #
> CONFIG_USB_NET_DRIVERS=3Dm
> CONFIG_USB_CATC=3Dm
> CONFIG_USB_KAWETH=3Dm
> CONFIG_USB_PEGASUS=3Dm
> CONFIG_USB_RTL8150=3Dm
> CONFIG_USB_RTL8152=3Dm
> CONFIG_USB_LAN78XX=3Dm
> CONFIG_USB_USBNET=3Dm
> CONFIG_USB_NET_AX8817X=3Dm
> CONFIG_USB_NET_AX88179_178A=3Dm
> CONFIG_USB_NET_CDCETHER=3Dm
> CONFIG_USB_NET_CDC_EEM=3Dm
> CONFIG_USB_NET_CDC_NCM=3Dm
> CONFIG_USB_NET_HUAWEI_CDC_NCM=3Dm
> CONFIG_USB_NET_CDC_MBIM=3Dm
> CONFIG_USB_NET_DM9601=3Dm
> CONFIG_USB_NET_SR9700=3Dm
> CONFIG_USB_NET_SR9800=3Dm
> CONFIG_USB_NET_SMSC75XX=3Dm
> CONFIG_USB_NET_SMSC95XX=3Dm
> CONFIG_USB_NET_GL620A=3Dm
> CONFIG_USB_NET_NET1080=3Dm
> CONFIG_USB_NET_PLUSB=3Dm
> CONFIG_USB_NET_MCS7830=3Dm
> CONFIG_USB_NET_RNDIS_HOST=3Dm
> CONFIG_USB_NET_CDC_SUBSET_ENABLE=3Dm
> CONFIG_USB_NET_CDC_SUBSET=3Dm
> CONFIG_USB_ALI_M5632=3Dy
> CONFIG_USB_AN2720=3Dy
> CONFIG_USB_BELKIN=3Dy
> CONFIG_USB_ARMLINUX=3Dy
> CONFIG_USB_EPSON2888=3Dy
> CONFIG_USB_KC2190=3Dy
> CONFIG_USB_NET_ZAURUS=3Dm
> CONFIG_USB_NET_CX82310_ETH=3Dm
> CONFIG_USB_NET_KALMIA=3Dm
> CONFIG_USB_NET_QMI_WWAN=3Dm
> CONFIG_USB_HSO=3Dm
> CONFIG_USB_NET_INT51X1=3Dm
> CONFIG_USB_CDC_PHONET=3Dm
> CONFIG_USB_IPHETH=3Dm
> CONFIG_USB_SIERRA_NET=3Dm
> CONFIG_USB_VL600=3Dm
> CONFIG_USB_NET_CH9200=3Dm
> CONFIG_WLAN=3Dy
> CONFIG_WLAN_VENDOR_ADMTEK=3Dy
> CONFIG_ADM8211=3Dm
> CONFIG_ATH_COMMON=3Dm
> CONFIG_WLAN_VENDOR_ATH=3Dy
> # CONFIG_ATH_DEBUG is not set
> CONFIG_ATH5K=3Dm
> # CONFIG_ATH5K_DEBUG is not set
> # CONFIG_ATH5K_TRACER is not set
> CONFIG_ATH5K_PCI=3Dy
> CONFIG_ATH9K_HW=3Dm
> CONFIG_ATH9K_COMMON=3Dm
> CONFIG_ATH9K_COMMON_DEBUG=3Dy
> CONFIG_ATH9K_BTCOEX_SUPPORT=3Dy
> CONFIG_ATH9K=3Dm
> CONFIG_ATH9K_PCI=3Dy
> CONFIG_ATH9K_AHB=3Dy
> CONFIG_ATH9K_DEBUGFS=3Dy
> CONFIG_ATH9K_STATION_STATISTICS=3Dy
> # CONFIG_ATH9K_DYNACK is not set
> CONFIG_ATH9K_WOW=3Dy
> CONFIG_ATH9K_RFKILL=3Dy
> # CONFIG_ATH9K_CHANNEL_CONTEXT is not set
> CONFIG_ATH9K_PCOEM=3Dy
> CONFIG_ATH9K_HTC=3Dm
> # CONFIG_ATH9K_HTC_DEBUGFS is not set
> # CONFIG_ATH9K_HWRNG is not set
> CONFIG_CARL9170=3Dm
> CONFIG_CARL9170_LEDS=3Dy
> # CONFIG_CARL9170_DEBUGFS is not set
> CONFIG_CARL9170_WPC=3Dy
> # CONFIG_CARL9170_HWRNG is not set
> CONFIG_ATH6KL=3Dm
> CONFIG_ATH6KL_SDIO=3Dm
> CONFIG_ATH6KL_USB=3Dm
> # CONFIG_ATH6KL_DEBUG is not set
> # CONFIG_ATH6KL_TRACING is not set
> CONFIG_AR5523=3Dm
> CONFIG_WIL6210=3Dm
> CONFIG_WIL6210_ISR_COR=3Dy
> # CONFIG_WIL6210_TRACING is not set
> CONFIG_ATH10K=3Dm
> CONFIG_ATH10K_PCI=3Dm
> # CONFIG_ATH10K_DEBUG is not set
> CONFIG_ATH10K_DEBUGFS=3Dy
> # CONFIG_ATH10K_TRACING is not set
> CONFIG_WCN36XX=3Dm
> # CONFIG_WCN36XX_DEBUGFS is not set
> CONFIG_WLAN_VENDOR_ATMEL=3Dy
> CONFIG_ATMEL=3Dm
> CONFIG_PCI_ATMEL=3Dm
> CONFIG_PCMCIA_ATMEL=3Dm
> CONFIG_AT76C50X_USB=3Dm
> CONFIG_WLAN_VENDOR_BROADCOM=3Dy
> CONFIG_B43=3Dm
> CONFIG_B43_BCMA=3Dy
> CONFIG_B43_SSB=3Dy
> CONFIG_B43_BUSES_BCMA_AND_SSB=3Dy
> # CONFIG_B43_BUSES_BCMA is not set
> # CONFIG_B43_BUSES_SSB is not set
> CONFIG_B43_PCI_AUTOSELECT=3Dy
> CONFIG_B43_PCICORE_AUTOSELECT=3Dy
> CONFIG_B43_SDIO=3Dy
> CONFIG_B43_BCMA_PIO=3Dy
> CONFIG_B43_PIO=3Dy
> CONFIG_B43_PHY_G=3Dy
> CONFIG_B43_PHY_N=3Dy
> CONFIG_B43_PHY_LP=3Dy
> CONFIG_B43_PHY_HT=3Dy
> CONFIG_B43_LEDS=3Dy
> CONFIG_B43_HWRNG=3Dy
> # CONFIG_B43_DEBUG is not set
> CONFIG_B43LEGACY=3Dm
> CONFIG_B43LEGACY_PCI_AUTOSELECT=3Dy
> CONFIG_B43LEGACY_PCICORE_AUTOSELECT=3Dy
> CONFIG_B43LEGACY_LEDS=3Dy
> CONFIG_B43LEGACY_HWRNG=3Dy
> # CONFIG_B43LEGACY_DEBUG is not set
> CONFIG_B43LEGACY_DMA=3Dy
> CONFIG_B43LEGACY_PIO=3Dy
> CONFIG_B43LEGACY_DMA_AND_PIO_MODE=3Dy
> # CONFIG_B43LEGACY_DMA_MODE is not set
> # CONFIG_B43LEGACY_PIO_MODE is not set
> CONFIG_BRCMUTIL=3Dm
> CONFIG_BRCMSMAC=3Dm
> CONFIG_BRCMFMAC=3Dm
> CONFIG_BRCMFMAC_PROTO_BCDC=3Dy
> CONFIG_BRCMFMAC_PROTO_MSGBUF=3Dy
> CONFIG_BRCMFMAC_SDIO=3Dy
> CONFIG_BRCMFMAC_USB=3Dy
> CONFIG_BRCMFMAC_PCIE=3Dy
> # CONFIG_BRCM_TRACING is not set
> # CONFIG_BRCMDBG is not set
> CONFIG_WLAN_VENDOR_CISCO=3Dy
> CONFIG_AIRO=3Dm
> CONFIG_AIRO_CS=3Dm
> CONFIG_WLAN_VENDOR_INTEL=3Dy
> CONFIG_IPW2100=3Dm
> CONFIG_IPW2100_MONITOR=3Dy
> # CONFIG_IPW2100_DEBUG is not set
> CONFIG_IPW2200=3Dm
> CONFIG_IPW2200_MONITOR=3Dy
> CONFIG_IPW2200_RADIOTAP=3Dy
> CONFIG_IPW2200_PROMISCUOUS=3Dy
> CONFIG_IPW2200_QOS=3Dy
> # CONFIG_IPW2200_DEBUG is not set
> CONFIG_LIBIPW=3Dm
> # CONFIG_LIBIPW_DEBUG is not set
> CONFIG_IWLEGACY=3Dm
> CONFIG_IWL4965=3Dm
> CONFIG_IWL3945=3Dm
>
> #
> # iwl3945 / iwl4965 Debugging Options
> #
> # CONFIG_IWLEGACY_DEBUG is not set
> # CONFIG_IWLEGACY_DEBUGFS is not set
> CONFIG_IWLWIFI=3Dm
> CONFIG_IWLWIFI_LEDS=3Dy
> CONFIG_IWLDVM=3Dm
> CONFIG_IWLMVM=3Dm
> CONFIG_IWLWIFI_OPMODE_MODULAR=3Dy
> # CONFIG_IWLWIFI_BCAST_FILTERING is not set
>
> #
> # Debugging Options
> #
> # CONFIG_IWLWIFI_DEBUG is not set
> # CONFIG_IWLWIFI_DEBUGFS is not set
> CONFIG_IWLWIFI_DEVICE_TRACING=3Dy
> CONFIG_WLAN_VENDOR_INTERSIL=3Dy
> CONFIG_HOSTAP=3Dm
> CONFIG_HOSTAP_FIRMWARE=3Dy
> # CONFIG_HOSTAP_FIRMWARE_NVRAM is not set
> CONFIG_HOSTAP_PLX=3Dm
> CONFIG_HOSTAP_PCI=3Dm
> CONFIG_HOSTAP_CS=3Dm
> CONFIG_HERMES=3Dm
> CONFIG_HERMES_PRISM=3Dy
> CONFIG_HERMES_CACHE_FW_ON_INIT=3Dy
> CONFIG_PLX_HERMES=3Dm
> CONFIG_TMD_HERMES=3Dm
> CONFIG_NORTEL_HERMES=3Dm
> CONFIG_PCI_HERMES=3Dm
> CONFIG_PCMCIA_HERMES=3Dm
> CONFIG_PCMCIA_SPECTRUM=3Dm
> CONFIG_ORINOCO_USB=3Dm
> CONFIG_P54_COMMON=3Dm
> CONFIG_P54_USB=3Dm
> CONFIG_P54_PCI=3Dm
> CONFIG_P54_SPI=3Dm
> # CONFIG_P54_SPI_DEFAULT_EEPROM is not set
> CONFIG_P54_LEDS=3Dy
> CONFIG_PRISM54=3Dm
> CONFIG_WLAN_VENDOR_MARVELL=3Dy
> CONFIG_LIBERTAS=3Dm
> CONFIG_LIBERTAS_USB=3Dm
> CONFIG_LIBERTAS_CS=3Dm
> CONFIG_LIBERTAS_SDIO=3Dm
> CONFIG_LIBERTAS_SPI=3Dm
> # CONFIG_LIBERTAS_DEBUG is not set
> CONFIG_LIBERTAS_MESH=3Dy
> CONFIG_LIBERTAS_THINFIRM=3Dm
> # CONFIG_LIBERTAS_THINFIRM_DEBUG is not set
> CONFIG_LIBERTAS_THINFIRM_USB=3Dm
> CONFIG_MWIFIEX=3Dm
> CONFIG_MWIFIEX_SDIO=3Dm
> CONFIG_MWIFIEX_PCIE=3Dm
> CONFIG_MWIFIEX_USB=3Dm
> CONFIG_MWL8K=3Dm
> CONFIG_WLAN_VENDOR_MEDIATEK=3Dy
> CONFIG_MT7601U=3Dm
> CONFIG_WLAN_VENDOR_RALINK=3Dy
> CONFIG_RT2X00=3Dm
> CONFIG_RT2400PCI=3Dm
> CONFIG_RT2500PCI=3Dm
> CONFIG_RT61PCI=3Dm
> CONFIG_RT2800PCI=3Dm
> CONFIG_RT2800PCI_RT33XX=3Dy
> CONFIG_RT2800PCI_RT35XX=3Dy
> CONFIG_RT2800PCI_RT53XX=3Dy
> CONFIG_RT2800PCI_RT3290=3Dy
> CONFIG_RT2500USB=3Dm
> CONFIG_RT73USB=3Dm
> CONFIG_RT2800USB=3Dm
> CONFIG_RT2800USB_RT33XX=3Dy
> CONFIG_RT2800USB_RT35XX=3Dy
> CONFIG_RT2800USB_RT3573=3Dy
> CONFIG_RT2800USB_RT53XX=3Dy
> CONFIG_RT2800USB_RT55XX=3Dy
> CONFIG_RT2800USB_UNKNOWN=3Dy
> CONFIG_RT2800_LIB=3Dm
> CONFIG_RT2800_LIB_MMIO=3Dm
> CONFIG_RT2X00_LIB_MMIO=3Dm
> CONFIG_RT2X00_LIB_PCI=3Dm
> CONFIG_RT2X00_LIB_USB=3Dm
> CONFIG_RT2X00_LIB=3Dm
> CONFIG_RT2X00_LIB_FIRMWARE=3Dy
> CONFIG_RT2X00_LIB_CRYPTO=3Dy
> CONFIG_RT2X00_LIB_LEDS=3Dy
> # CONFIG_RT2X00_LIB_DEBUGFS is not set
> # CONFIG_RT2X00_DEBUG is not set
> CONFIG_WLAN_VENDOR_REALTEK=3Dy
> CONFIG_RTL8180=3Dm
> CONFIG_RTL8187=3Dm
> CONFIG_RTL8187_LEDS=3Dy
> CONFIG_RTL_CARDS=3Dm
> CONFIG_RTL8192CE=3Dm
> CONFIG_RTL8192SE=3Dm
> CONFIG_RTL8192DE=3Dm
> CONFIG_RTL8723AE=3Dm
> CONFIG_RTL8723BE=3Dm
> CONFIG_RTL8188EE=3Dm
> CONFIG_RTL8192EE=3Dm
> CONFIG_RTL8821AE=3Dm
> CONFIG_RTL8192CU=3Dm
> CONFIG_RTLWIFI=3Dm
> CONFIG_RTLWIFI_PCI=3Dm
> CONFIG_RTLWIFI_USB=3Dm
> # CONFIG_RTLWIFI_DEBUG is not set
> CONFIG_RTL8192C_COMMON=3Dm
> CONFIG_RTL8723_COMMON=3Dm
> CONFIG_RTLBTCOEXIST=3Dm
> CONFIG_RTL8XXXU=3Dm
> CONFIG_RTL8XXXU_UNTESTED=3Dy
> CONFIG_WLAN_VENDOR_RSI=3Dy
> CONFIG_RSI_91X=3Dm
> # CONFIG_RSI_DEBUGFS is not set
> CONFIG_RSI_SDIO=3Dm
> CONFIG_RSI_USB=3Dm
> CONFIG_WLAN_VENDOR_ST=3Dy
> CONFIG_CW1200=3Dm
> CONFIG_CW1200_WLAN_SDIO=3Dm
> CONFIG_CW1200_WLAN_SPI=3Dm
> CONFIG_WLAN_VENDOR_TI=3Dy
> CONFIG_WL1251=3Dm
> # CONFIG_WL1251_SPI is not set
> CONFIG_WL1251_SDIO=3Dm
> CONFIG_WL12XX=3Dm
> CONFIG_WL18XX=3Dm
> CONFIG_WLCORE=3Dm
> CONFIG_WLCORE_SDIO=3Dm
> CONFIG_WILINK_PLATFORM_DATA=3Dy
> CONFIG_WLAN_VENDOR_ZYDAS=3Dy
> CONFIG_USB_ZD1201=3Dm
> CONFIG_ZD1211RW=3Dm
> # CONFIG_ZD1211RW_DEBUG is not set
> CONFIG_PCMCIA_RAYCS=3Dm
> CONFIG_PCMCIA_WL3501=3Dm
> # CONFIG_MAC80211_HWSIM is not set
> CONFIG_USB_NET_RNDIS_WLAN=3Dm
>
> #
> # WiMAX Wireless Broadband devices
> #
> CONFIG_WIMAX_I2400M=3Dm
> CONFIG_WIMAX_I2400M_USB=3Dm
> CONFIG_WIMAX_I2400M_DEBUG_LEVEL=3D8
> # CONFIG_WAN is not set
> CONFIG_IEEE802154_DRIVERS=3Dm
> CONFIG_IEEE802154_FAKELB=3Dm
> CONFIG_IEEE802154_AT86RF230=3Dm
> # CONFIG_IEEE802154_AT86RF230_DEBUGFS is not set
> # CONFIG_IEEE802154_MRF24J40 is not set
> # CONFIG_IEEE802154_CC2520 is not set
> CONFIG_IEEE802154_ATUSB=3Dm
> # CONFIG_IEEE802154_ADF7242 is not set
> # CONFIG_IEEE802154_CA8210 is not set
> CONFIG_XEN_NETDEV_FRONTEND=3Dm
> CONFIG_XEN_NETDEV_BACKEND=3Dm
> CONFIG_VMXNET3=3Dm
> CONFIG_FUJITSU_ES=3Dm
> CONFIG_HYPERV_NET=3Dm
> CONFIG_ISDN=3Dy
> CONFIG_ISDN_I4L=3Dm
> CONFIG_ISDN_PPP=3Dy
> CONFIG_ISDN_PPP_VJ=3Dy
> CONFIG_ISDN_MPP=3Dy
> CONFIG_IPPP_FILTER=3Dy
> CONFIG_ISDN_PPP_BSDCOMP=3Dm
> CONFIG_ISDN_AUDIO=3Dy
> CONFIG_ISDN_TTY_FAX=3Dy
>
> #
> # ISDN feature submodules
> #
> CONFIG_ISDN_DIVERSION=3Dm
>
> #
> # ISDN4Linux hardware drivers
> #
>
> #
> # Passive cards
> #
> CONFIG_ISDN_DRV_HISAX=3Dm
>
> #
> # D-channel protocol features
> #
> CONFIG_HISAX_EURO=3Dy
> CONFIG_DE_AOC=3Dy
> # CONFIG_HISAX_NO_SENDCOMPLETE is not set
> # CONFIG_HISAX_NO_LLC is not set
> # CONFIG_HISAX_NO_KEYPAD is not set
> CONFIG_HISAX_1TR6=3Dy
> CONFIG_HISAX_NI1=3Dy
> CONFIG_HISAX_MAX_CARDS=3D8
>
> #
> # HiSax supported cards
> #
> CONFIG_HISAX_16_3=3Dy
> CONFIG_HISAX_TELESPCI=3Dy
> CONFIG_HISAX_S0BOX=3Dy
> CONFIG_HISAX_FRITZPCI=3Dy
> CONFIG_HISAX_AVM_A1_PCMCIA=3Dy
> CONFIG_HISAX_ELSA=3Dy
> CONFIG_HISAX_DIEHLDIVA=3Dy
> CONFIG_HISAX_SEDLBAUER=3Dy
> CONFIG_HISAX_NETJET=3Dy
> CONFIG_HISAX_NETJET_U=3Dy
> CONFIG_HISAX_NICCY=3Dy
> CONFIG_HISAX_BKM_A4T=3Dy
> CONFIG_HISAX_SCT_QUADRO=3Dy
> CONFIG_HISAX_GAZEL=3Dy
> CONFIG_HISAX_HFC_PCI=3Dy
> CONFIG_HISAX_W6692=3Dy
> CONFIG_HISAX_HFC_SX=3Dy
> CONFIG_HISAX_ENTERNOW_PCI=3Dy
> # CONFIG_HISAX_DEBUG is not set
>
> #
> # HiSax PCMCIA card service modules
> #
> CONFIG_HISAX_SEDLBAUER_CS=3Dm
> CONFIG_HISAX_ELSA_CS=3Dm
> CONFIG_HISAX_AVM_A1_CS=3Dm
> CONFIG_HISAX_TELES_CS=3Dm
>
> #
> # HiSax sub driver modules
> #
> CONFIG_HISAX_ST5481=3Dm
> CONFIG_HISAX_HFCUSB=3Dm
> CONFIG_HISAX_HFC4S8S=3Dm
> CONFIG_HISAX_FRITZ_PCIPNP=3Dm
> CONFIG_ISDN_CAPI=3Dm
> CONFIG_CAPI_TRACE=3Dy
> CONFIG_ISDN_CAPI_CAPI20=3Dm
> CONFIG_ISDN_CAPI_MIDDLEWARE=3Dy
> CONFIG_ISDN_CAPI_CAPIDRV=3Dm
> # CONFIG_ISDN_CAPI_CAPIDRV_VERBOSE is not set
>
> #
> # CAPI hardware drivers
> #
> CONFIG_CAPI_AVM=3Dy
> CONFIG_ISDN_DRV_AVMB1_B1PCI=3Dm
> CONFIG_ISDN_DRV_AVMB1_B1PCIV4=3Dy
> CONFIG_ISDN_DRV_AVMB1_B1PCMCIA=3Dm
> CONFIG_ISDN_DRV_AVMB1_AVM_CS=3Dm
> CONFIG_ISDN_DRV_AVMB1_T1PCI=3Dm
> CONFIG_ISDN_DRV_AVMB1_C4=3Dm
> CONFIG_CAPI_EICON=3Dy
> CONFIG_ISDN_DIVAS=3Dm
> CONFIG_ISDN_DIVAS_BRIPCI=3Dy
> CONFIG_ISDN_DIVAS_PRIPCI=3Dy
> CONFIG_ISDN_DIVAS_DIVACAPI=3Dm
> CONFIG_ISDN_DIVAS_USERIDI=3Dm
> CONFIG_ISDN_DIVAS_MAINT=3Dm
> CONFIG_ISDN_DRV_GIGASET=3Dm
> CONFIG_GIGASET_CAPI=3Dy
> # CONFIG_GIGASET_I4L is not set
> # CONFIG_GIGASET_DUMMYLL is not set
> CONFIG_GIGASET_BASE=3Dm
> CONFIG_GIGASET_M105=3Dm
> CONFIG_GIGASET_M101=3Dm
> # CONFIG_GIGASET_DEBUG is not set
> CONFIG_HYSDN=3Dm
> CONFIG_HYSDN_CAPI=3Dy
> CONFIG_MISDN=3Dm
> CONFIG_MISDN_DSP=3Dm
> CONFIG_MISDN_L1OIP=3Dm
>
> #
> # mISDN hardware drivers
> #
> CONFIG_MISDN_HFCPCI=3Dm
> CONFIG_MISDN_HFCMULTI=3Dm
> CONFIG_MISDN_HFCUSB=3Dm
> CONFIG_MISDN_AVMFRITZ=3Dm
> CONFIG_MISDN_SPEEDFAX=3Dm
> CONFIG_MISDN_INFINEON=3Dm
> CONFIG_MISDN_W6692=3Dm
> CONFIG_MISDN_NETJET=3Dm
> CONFIG_MISDN_IPAC=3Dm
> CONFIG_MISDN_ISAR=3Dm
> CONFIG_ISDN_HDLC=3Dm
> # CONFIG_NVM is not set
>
> #
> # Input device support
> #
> CONFIG_INPUT=3Dy
> CONFIG_INPUT_LEDS=3Dm
> CONFIG_INPUT_FF_MEMLESS=3Dm
> CONFIG_INPUT_POLLDEV=3Dm
> CONFIG_INPUT_SPARSEKMAP=3Dm
> CONFIG_INPUT_MATRIXKMAP=3Dm
>
> #
> # Userland interfaces
> #
> CONFIG_INPUT_MOUSEDEV=3Dm
> CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
> CONFIG_INPUT_JOYDEV=3Dm
> CONFIG_INPUT_EVDEV=3Dm
> # CONFIG_INPUT_EVBUG is not set
>
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=3Dy
> # CONFIG_KEYBOARD_ADC is not set
> CONFIG_KEYBOARD_ADP5588=3Dm
> CONFIG_KEYBOARD_ADP5589=3Dm
> CONFIG_KEYBOARD_ATKBD=3Dm
> CONFIG_KEYBOARD_QT1070=3Dm
> CONFIG_KEYBOARD_QT2160=3Dm
> # CONFIG_KEYBOARD_LKKBD is not set
> CONFIG_KEYBOARD_GPIO=3Dm
> # CONFIG_KEYBOARD_GPIO_POLLED is not set
> CONFIG_KEYBOARD_TCA6416=3Dm
> CONFIG_KEYBOARD_TCA8418=3Dm
> CONFIG_KEYBOARD_MATRIX=3Dm
> # CONFIG_KEYBOARD_LM8323 is not set
> CONFIG_KEYBOARD_LM8333=3Dm
> # CONFIG_KEYBOARD_MAX7359 is not set
> CONFIG_KEYBOARD_MCS=3Dm
> CONFIG_KEYBOARD_MPR121=3Dm
> # CONFIG_KEYBOARD_NEWTON is not set
> # CONFIG_KEYBOARD_OPENCORES is not set
> # CONFIG_KEYBOARD_SAMSUNG is not set
> # CONFIG_KEYBOARD_STOWAWAY is not set
> # CONFIG_KEYBOARD_SUNKBD is not set
> # CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
> # CONFIG_KEYBOARD_XTKBD is not set
> # CONFIG_KEYBOARD_CROS_EC is not set
> CONFIG_INPUT_MOUSE=3Dy
> CONFIG_MOUSE_PS2=3Dm
> CONFIG_MOUSE_PS2_ALPS=3Dy
> CONFIG_MOUSE_PS2_BYD=3Dy
> CONFIG_MOUSE_PS2_LOGIPS2PP=3Dy
> CONFIG_MOUSE_PS2_SYNAPTICS=3Dy
> CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=3Dy
> CONFIG_MOUSE_PS2_CYPRESS=3Dy
> CONFIG_MOUSE_PS2_LIFEBOOK=3Dy
> CONFIG_MOUSE_PS2_TRACKPOINT=3Dy
> CONFIG_MOUSE_PS2_ELANTECH=3Dy
> CONFIG_MOUSE_PS2_SENTELIC=3Dy
> CONFIG_MOUSE_PS2_TOUCHKIT=3Dy
> CONFIG_MOUSE_PS2_FOCALTECH=3Dy
> CONFIG_MOUSE_PS2_VMMOUSE=3Dy
> CONFIG_MOUSE_PS2_SMBUS=3Dy
> CONFIG_MOUSE_SERIAL=3Dm
> CONFIG_MOUSE_APPLETOUCH=3Dm
> CONFIG_MOUSE_BCM5974=3Dm
> CONFIG_MOUSE_CYAPA=3Dm
> CONFIG_MOUSE_ELAN_I2C=3Dm
> CONFIG_MOUSE_ELAN_I2C_I2C=3Dy
> CONFIG_MOUSE_ELAN_I2C_SMBUS=3Dy
> CONFIG_MOUSE_VSXXXAA=3Dm
> # CONFIG_MOUSE_GPIO is not set
> CONFIG_MOUSE_SYNAPTICS_I2C=3Dm
> CONFIG_MOUSE_SYNAPTICS_USB=3Dm
> CONFIG_INPUT_JOYSTICK=3Dy
> CONFIG_JOYSTICK_ANALOG=3Dm
> CONFIG_JOYSTICK_A3D=3Dm
> CONFIG_JOYSTICK_ADI=3Dm
> CONFIG_JOYSTICK_COBRA=3Dm
> CONFIG_JOYSTICK_GF2K=3Dm
> CONFIG_JOYSTICK_GRIP=3Dm
> CONFIG_JOYSTICK_GRIP_MP=3Dm
> CONFIG_JOYSTICK_GUILLEMOT=3Dm
> CONFIG_JOYSTICK_INTERACT=3Dm
> CONFIG_JOYSTICK_SIDEWINDER=3Dm
> CONFIG_JOYSTICK_TMDC=3Dm
> CONFIG_JOYSTICK_IFORCE=3Dm
> CONFIG_JOYSTICK_IFORCE_USB=3Dy
> CONFIG_JOYSTICK_IFORCE_232=3Dy
> CONFIG_JOYSTICK_WARRIOR=3Dm
> CONFIG_JOYSTICK_MAGELLAN=3Dm
> CONFIG_JOYSTICK_SPACEORB=3Dm
> CONFIG_JOYSTICK_SPACEBALL=3Dm
> CONFIG_JOYSTICK_STINGER=3Dm
> CONFIG_JOYSTICK_TWIDJOY=3Dm
> CONFIG_JOYSTICK_ZHENHUA=3Dm
> CONFIG_JOYSTICK_DB9=3Dm
> CONFIG_JOYSTICK_GAMECON=3Dm
> CONFIG_JOYSTICK_TURBOGRAFX=3Dm
> CONFIG_JOYSTICK_AS5011=3Dm
> CONFIG_JOYSTICK_JOYDUMP=3Dm
> CONFIG_JOYSTICK_XPAD=3Dm
> CONFIG_JOYSTICK_XPAD_FF=3Dy
> CONFIG_JOYSTICK_XPAD_LEDS=3Dy
> CONFIG_JOYSTICK_WALKERA0701=3Dm
> # CONFIG_JOYSTICK_PSXPAD_SPI is not set
> CONFIG_INPUT_TABLET=3Dy
> CONFIG_TABLET_USB_ACECAD=3Dm
> CONFIG_TABLET_USB_AIPTEK=3Dm
> CONFIG_TABLET_USB_GTCO=3Dm
> CONFIG_TABLET_USB_HANWANG=3Dm
> CONFIG_TABLET_USB_KBTAB=3Dm
> CONFIG_TABLET_USB_PEGASUS=3Dm
> CONFIG_TABLET_SERIAL_WACOM4=3Dm
> CONFIG_INPUT_TOUCHSCREEN=3Dy
> CONFIG_TOUCHSCREEN_PROPERTIES=3Dy
> # CONFIG_TOUCHSCREEN_ADS7846 is not set
> # CONFIG_TOUCHSCREEN_AD7877 is not set
> CONFIG_TOUCHSCREEN_AD7879=3Dm
> CONFIG_TOUCHSCREEN_AD7879_I2C=3Dm
> # CONFIG_TOUCHSCREEN_AD7879_SPI is not set
> CONFIG_TOUCHSCREEN_ATMEL_MXT=3Dm
> CONFIG_TOUCHSCREEN_ATMEL_MXT_T37=3Dy
> CONFIG_TOUCHSCREEN_AUO_PIXCIR=3Dm
> CONFIG_TOUCHSCREEN_BU21013=3Dm
> CONFIG_TOUCHSCREEN_CY8CTMG110=3Dm
> CONFIG_TOUCHSCREEN_CYTTSP_CORE=3Dm
> CONFIG_TOUCHSCREEN_CYTTSP_I2C=3Dm
> # CONFIG_TOUCHSCREEN_CYTTSP_SPI is not set
> CONFIG_TOUCHSCREEN_CYTTSP4_CORE=3Dm
> CONFIG_TOUCHSCREEN_CYTTSP4_I2C=3Dm
> CONFIG_TOUCHSCREEN_CYTTSP4_SPI=3Dm
> CONFIG_TOUCHSCREEN_DYNAPRO=3Dm
> CONFIG_TOUCHSCREEN_HAMPSHIRE=3Dm
> CONFIG_TOUCHSCREEN_EETI=3Dm
> CONFIG_TOUCHSCREEN_EGALAX_SERIAL=3Dm
> CONFIG_TOUCHSCREEN_FUJITSU=3Dm
> CONFIG_TOUCHSCREEN_GOODIX=3Dm
> CONFIG_TOUCHSCREEN_ILI210X=3Dm
> CONFIG_TOUCHSCREEN_GUNZE=3Dm
> CONFIG_TOUCHSCREEN_EKTF2127=3Dm
> CONFIG_TOUCHSCREEN_ELAN=3Dm
> CONFIG_TOUCHSCREEN_ELO=3Dm
> CONFIG_TOUCHSCREEN_WACOM_W8001=3Dm
> CONFIG_TOUCHSCREEN_WACOM_I2C=3Dm
> CONFIG_TOUCHSCREEN_MAX11801=3Dm
> CONFIG_TOUCHSCREEN_MCS5000=3Dm
> CONFIG_TOUCHSCREEN_MMS114=3Dm
> CONFIG_TOUCHSCREEN_MELFAS_MIP4=3Dm
> CONFIG_TOUCHSCREEN_MTOUCH=3Dm
> CONFIG_TOUCHSCREEN_INEXIO=3Dm
> CONFIG_TOUCHSCREEN_MK712=3Dm
> CONFIG_TOUCHSCREEN_PENMOUNT=3Dm
> CONFIG_TOUCHSCREEN_EDT_FT5X06=3Dm
> CONFIG_TOUCHSCREEN_TOUCHRIGHT=3Dm
> CONFIG_TOUCHSCREEN_TOUCHWIN=3Dm
> CONFIG_TOUCHSCREEN_TI_AM335X_TSC=3Dm
> CONFIG_TOUCHSCREEN_UCB1400=3Dm
> CONFIG_TOUCHSCREEN_PIXCIR=3Dm
> CONFIG_TOUCHSCREEN_WDT87XX_I2C=3Dm
> CONFIG_TOUCHSCREEN_WM97XX=3Dm
> CONFIG_TOUCHSCREEN_WM9705=3Dy
> CONFIG_TOUCHSCREEN_WM9712=3Dy
> CONFIG_TOUCHSCREEN_WM9713=3Dy
> CONFIG_TOUCHSCREEN_USB_COMPOSITE=3Dm
> CONFIG_TOUCHSCREEN_MC13783=3Dm
> CONFIG_TOUCHSCREEN_USB_EGALAX=3Dy
> CONFIG_TOUCHSCREEN_USB_PANJIT=3Dy
> CONFIG_TOUCHSCREEN_USB_3M=3Dy
> CONFIG_TOUCHSCREEN_USB_ITM=3Dy
> CONFIG_TOUCHSCREEN_USB_ETURBO=3Dy
> CONFIG_TOUCHSCREEN_USB_GUNZE=3Dy
> CONFIG_TOUCHSCREEN_USB_DMC_TSC10=3Dy
> CONFIG_TOUCHSCREEN_USB_IRTOUCH=3Dy
> CONFIG_TOUCHSCREEN_USB_IDEALTEK=3Dy
> CONFIG_TOUCHSCREEN_USB_GENERAL_TOUCH=3Dy
> CONFIG_TOUCHSCREEN_USB_GOTOP=3Dy
> CONFIG_TOUCHSCREEN_USB_JASTEC=3Dy
> CONFIG_TOUCHSCREEN_USB_ELO=3Dy
> CONFIG_TOUCHSCREEN_USB_E2I=3Dy
> CONFIG_TOUCHSCREEN_USB_ZYTRONIC=3Dy
> CONFIG_TOUCHSCREEN_USB_ETT_TC45USB=3Dy
> CONFIG_TOUCHSCREEN_USB_NEXIO=3Dy
> CONFIG_TOUCHSCREEN_USB_EASYTOUCH=3Dy
> CONFIG_TOUCHSCREEN_TOUCHIT213=3Dm
> CONFIG_TOUCHSCREEN_TSC_SERIO=3Dm
> CONFIG_TOUCHSCREEN_TSC200X_CORE=3Dm
> CONFIG_TOUCHSCREEN_TSC2004=3Dm
> # CONFIG_TOUCHSCREEN_TSC2005 is not set
> CONFIG_TOUCHSCREEN_TSC2007=3Dm
> # CONFIG_TOUCHSCREEN_TSC2007_IIO is not set
> CONFIG_TOUCHSCREEN_RM_TS=3Dm
> CONFIG_TOUCHSCREEN_SILEAD=3Dm
> CONFIG_TOUCHSCREEN_SIS_I2C=3Dm
> CONFIG_TOUCHSCREEN_ST1232=3Dm
> CONFIG_TOUCHSCREEN_SUR40=3Dm
> CONFIG_TOUCHSCREEN_SURFACE3_SPI=3Dm
> # CONFIG_TOUCHSCREEN_SX8654 is not set
> CONFIG_TOUCHSCREEN_TPS6507X=3Dm
> # CONFIG_TOUCHSCREEN_ZET6223 is not set
> CONFIG_TOUCHSCREEN_ZFORCE=3Dm
> CONFIG_TOUCHSCREEN_ROHM_BU21023=3Dm
> CONFIG_INPUT_MISC=3Dy
> CONFIG_INPUT_AD714X=3Dm
> CONFIG_INPUT_AD714X_I2C=3Dm
> CONFIG_INPUT_AD714X_SPI=3Dm
> # CONFIG_INPUT_ARIZONA_HAPTICS is not set
> CONFIG_INPUT_BMA150=3Dm
> CONFIG_INPUT_E3X0_BUTTON=3Dm
> CONFIG_INPUT_PCSPKR=3Dm
> CONFIG_INPUT_MC13783_PWRBUTTON=3Dm
> CONFIG_INPUT_MMA8450=3Dm
> CONFIG_INPUT_APANEL=3Dm
> CONFIG_INPUT_GP2A=3Dm
> # CONFIG_INPUT_GPIO_BEEPER is not set
> # CONFIG_INPUT_GPIO_TILT_POLLED is not set
> # CONFIG_INPUT_GPIO_DECODER is not set
> CONFIG_INPUT_ATLAS_BTNS=3Dm
> CONFIG_INPUT_ATI_REMOTE2=3Dm
> CONFIG_INPUT_KEYSPAN_REMOTE=3Dm
> CONFIG_INPUT_KXTJ9=3Dm
> # CONFIG_INPUT_KXTJ9_POLLED_MODE is not set
> CONFIG_INPUT_POWERMATE=3Dm
> CONFIG_INPUT_YEALINK=3Dm
> CONFIG_INPUT_CM109=3Dm
> CONFIG_INPUT_RETU_PWRBUTTON=3Dm
> CONFIG_INPUT_TPS65218_PWRBUTTON=3Dm
> CONFIG_INPUT_UINPUT=3Dm
> CONFIG_INPUT_PCF50633_PMU=3Dm
> CONFIG_INPUT_PCF8574=3Dm
> CONFIG_INPUT_GPIO_ROTARY_ENCODER=3Dm
> CONFIG_INPUT_ADXL34X=3Dm
> CONFIG_INPUT_ADXL34X_I2C=3Dm
> CONFIG_INPUT_ADXL34X_SPI=3Dm
> # CONFIG_INPUT_IMS_PCU is not set
> CONFIG_INPUT_CMA3000=3Dm
> CONFIG_INPUT_CMA3000_I2C=3Dm
> CONFIG_INPUT_XEN_KBDDEV_FRONTEND=3Dm
> CONFIG_INPUT_IDEAPAD_SLIDEBAR=3Dm
> CONFIG_INPUT_SOC_BUTTON_ARRAY=3Dm
> # CONFIG_INPUT_DRV260X_HAPTICS is not set
> # CONFIG_INPUT_DRV2665_HAPTICS is not set
> # CONFIG_INPUT_DRV2667_HAPTICS is not set
> CONFIG_RMI4_CORE=3Dm
> CONFIG_RMI4_I2C=3Dm
> CONFIG_RMI4_SPI=3Dm
> # CONFIG_RMI4_SMB is not set
> CONFIG_RMI4_F03=3Dy
> CONFIG_RMI4_F03_SERIO=3Dm
> CONFIG_RMI4_2D_SENSOR=3Dy
> CONFIG_RMI4_F11=3Dy
> CONFIG_RMI4_F12=3Dy
> CONFIG_RMI4_F30=3Dy
> # CONFIG_RMI4_F34 is not set
> CONFIG_RMI4_F54=3Dy
> CONFIG_RMI4_F55=3Dy
>
> #
> # Hardware I/O ports
> #
> CONFIG_SERIO=3Dm
> CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=3Dy
> CONFIG_SERIO_I8042=3Dm
> CONFIG_SERIO_SERPORT=3Dm
> CONFIG_SERIO_CT82C710=3Dm
> CONFIG_SERIO_PARKBD=3Dm
> CONFIG_SERIO_PCIPS2=3Dm
> CONFIG_SERIO_LIBPS2=3Dm
> CONFIG_SERIO_RAW=3Dm
> CONFIG_SERIO_ALTERA_PS2=3Dm
> CONFIG_SERIO_PS2MULT=3Dm
> CONFIG_SERIO_ARC_PS2=3Dm
> CONFIG_HYPERV_KEYBOARD=3Dm
> # CONFIG_USERIO is not set
> CONFIG_GAMEPORT=3Dm
> CONFIG_GAMEPORT_NS558=3Dm
> CONFIG_GAMEPORT_L4=3Dm
> CONFIG_GAMEPORT_EMU10K1=3Dm
> CONFIG_GAMEPORT_FM801=3Dm
>
> #
> # Character devices
> #
> CONFIG_TTY=3Dy
> CONFIG_VT=3Dy
> CONFIG_CONSOLE_TRANSLATIONS=3Dy
> CONFIG_VT_CONSOLE=3Dy
> CONFIG_VT_CONSOLE_SLEEP=3Dy
> CONFIG_HW_CONSOLE=3Dy
> CONFIG_VT_HW_CONSOLE_BINDING=3Dy
> CONFIG_UNIX98_PTYS=3Dy
> # CONFIG_LEGACY_PTYS is not set
> CONFIG_SERIAL_NONSTANDARD=3Dy
> CONFIG_ROCKETPORT=3Dm
> CONFIG_CYCLADES=3Dm
> # CONFIG_CYZ_INTR is not set
> # CONFIG_MOXA_INTELLIO is not set
> # CONFIG_MOXA_SMARTIO is not set
> CONFIG_SYNCLINK=3Dm
> CONFIG_SYNCLINKMP=3Dm
> # CONFIG_SYNCLINK_GT is not set
> CONFIG_NOZOMI=3Dm
> # CONFIG_ISI is not set
> CONFIG_N_HDLC=3Dm
> CONFIG_N_GSM=3Dm
> CONFIG_TRACE_ROUTER=3Dm
> CONFIG_TRACE_SINK=3Dm
> CONFIG_DEVMEM=3Dy
> # CONFIG_DEVKMEM is not set
>
> #
> # Serial drivers
> #
> CONFIG_SERIAL_EARLYCON=3Dy
> CONFIG_SERIAL_8250=3Dy
> # CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
> CONFIG_SERIAL_8250_PNP=3Dy
> # CONFIG_SERIAL_8250_FINTEK is not set
> CONFIG_SERIAL_8250_CONSOLE=3Dy
> CONFIG_SERIAL_8250_DMA=3Dy
> CONFIG_SERIAL_8250_PCI=3Dy
> CONFIG_SERIAL_8250_EXAR=3Dy
> CONFIG_SERIAL_8250_CS=3Dm
> CONFIG_SERIAL_8250_NR_UARTS=3D32
> CONFIG_SERIAL_8250_RUNTIME_UARTS=3D4
> CONFIG_SERIAL_8250_EXTENDED=3Dy
> CONFIG_SERIAL_8250_MANY_PORTS=3Dy
> CONFIG_SERIAL_8250_SHARE_IRQ=3Dy
> # CONFIG_SERIAL_8250_DETECT_IRQ is not set
> CONFIG_SERIAL_8250_RSA=3Dy
> # CONFIG_SERIAL_8250_FSL is not set
> CONFIG_SERIAL_8250_DW=3Dm
> CONFIG_SERIAL_8250_RT288X=3Dy
> CONFIG_SERIAL_8250_LPSS=3Dy
> CONFIG_SERIAL_8250_MID=3Dy
> CONFIG_SERIAL_8250_MOXA=3Dm
>
> #
> # Non-8250 serial port support
> #
> # CONFIG_SERIAL_MAX3100 is not set
> # CONFIG_SERIAL_MAX310X is not set
> # CONFIG_SERIAL_UARTLITE is not set
> CONFIG_SERIAL_CORE=3Dy
> CONFIG_SERIAL_CORE_CONSOLE=3Dy
> CONFIG_SERIAL_JSM=3Dm
> CONFIG_SERIAL_SCCNXP=3Dm
> CONFIG_SERIAL_SC16IS7XX_CORE=3Dm
> CONFIG_SERIAL_SC16IS7XX=3Dm
> CONFIG_SERIAL_SC16IS7XX_I2C=3Dy
> # CONFIG_SERIAL_SC16IS7XX_SPI is not set
> CONFIG_SERIAL_ALTERA_JTAGUART=3Dm
> CONFIG_SERIAL_ALTERA_UART=3Dm
> CONFIG_SERIAL_ALTERA_UART_MAXPORTS=3D4
> CONFIG_SERIAL_ALTERA_UART_BAUDRATE=3D115200
> # CONFIG_SERIAL_IFX6X60 is not set
> CONFIG_SERIAL_ARC=3Dm
> CONFIG_SERIAL_ARC_NR_PORTS=3D1
> CONFIG_SERIAL_RP2=3Dm
> CONFIG_SERIAL_RP2_NR_UARTS=3D32
> CONFIG_SERIAL_FSL_LPUART=3Dm
> # CONFIG_SERIAL_DEV_BUS is not set
> CONFIG_PRINTER=3Dm
> # CONFIG_LP_CONSOLE is not set
> CONFIG_PPDEV=3Dm
> CONFIG_HVC_DRIVER=3Dy
> CONFIG_HVC_IRQ=3Dy
> CONFIG_HVC_XEN=3Dy
> CONFIG_HVC_XEN_FRONTEND=3Dy
> CONFIG_VIRTIO_CONSOLE=3Dm
> CONFIG_IPMI_HANDLER=3Dm
> # CONFIG_IPMI_PANIC_EVENT is not set
> CONFIG_IPMI_DEVICE_INTERFACE=3Dm
> CONFIG_IPMI_SI=3Dm
> CONFIG_IPMI_SSIF=3Dm
> CONFIG_IPMI_WATCHDOG=3Dm
> CONFIG_IPMI_POWEROFF=3Dm
> CONFIG_HW_RANDOM=3Dm
> CONFIG_HW_RANDOM_TIMERIOMEM=3Dm
> CONFIG_HW_RANDOM_INTEL=3Dm
> CONFIG_HW_RANDOM_AMD=3Dm
> CONFIG_HW_RANDOM_VIA=3Dm
> CONFIG_HW_RANDOM_VIRTIO=3Dm
> CONFIG_HW_RANDOM_TPM=3Dm
> CONFIG_NVRAM=3Dm
> CONFIG_R3964=3Dm
> CONFIG_APPLICOM=3Dm
>
> #
> # PCMCIA character devices
> #
> CONFIG_SYNCLINK_CS=3Dm
> CONFIG_CARDMAN_4000=3Dm
> CONFIG_CARDMAN_4040=3Dm
> # CONFIG_SCR24X is not set
> CONFIG_IPWIRELESS=3Dm
> CONFIG_MWAVE=3Dm
> CONFIG_RAW_DRIVER=3Dm
> CONFIG_MAX_RAW_DEVS=3D256
> CONFIG_HPET=3Dy
> CONFIG_HPET_MMAP=3Dy
> CONFIG_HPET_MMAP_DEFAULT=3Dy
> CONFIG_HANGCHECK_TIMER=3Dm
> CONFIG_TCG_TPM=3Dm
> CONFIG_TCG_TIS_CORE=3Dm
> CONFIG_TCG_TIS=3Dm
> # CONFIG_TCG_TIS_SPI is not set
> CONFIG_TCG_TIS_I2C_ATMEL=3Dm
> CONFIG_TCG_TIS_I2C_INFINEON=3Dm
> CONFIG_TCG_TIS_I2C_NUVOTON=3Dm
> CONFIG_TCG_NSC=3Dm
> CONFIG_TCG_ATMEL=3Dm
> CONFIG_TCG_INFINEON=3Dm
> CONFIG_TCG_XEN=3Dm
> CONFIG_TCG_CRB=3Dm
> # CONFIG_TCG_VTPM_PROXY is not set
> # CONFIG_TCG_TIS_ST33ZP24_I2C is not set
> # CONFIG_TCG_TIS_ST33ZP24_SPI is not set
> CONFIG_TELCLOCK=3Dm
> CONFIG_DEVPORT=3Dy
> # CONFIG_XILLYBUS is not set
>
> #
> # I2C support
> #
> CONFIG_I2C=3Dy
> CONFIG_ACPI_I2C_OPREGION=3Dy
> CONFIG_I2C_BOARDINFO=3Dy
> CONFIG_I2C_COMPAT=3Dy
> CONFIG_I2C_CHARDEV=3Dm
> CONFIG_I2C_MUX=3Dm
>
> #
> # Multiplexer I2C Chip support
> #
> # CONFIG_I2C_MUX_GPIO is not set
> # CONFIG_I2C_MUX_LTC4306 is not set
> CONFIG_I2C_MUX_PCA9541=3Dm
> CONFIG_I2C_MUX_PCA954x=3Dm
> # CONFIG_I2C_MUX_PINCTRL is not set
> # CONFIG_I2C_MUX_REG is not set
> # CONFIG_I2C_MUX_MLXCPLD is not set
> CONFIG_I2C_HELPER_AUTO=3Dy
> CONFIG_I2C_SMBUS=3Dm
> CONFIG_I2C_ALGOBIT=3Dm
> CONFIG_I2C_ALGOPCA=3Dm
>
> #
> # I2C Hardware Bus support
> #
>
> #
> # PC SMBus host controller drivers
> #
> CONFIG_I2C_ALI1535=3Dm
> CONFIG_I2C_ALI1563=3Dm
> CONFIG_I2C_ALI15X3=3Dm
> CONFIG_I2C_AMD756=3Dm
> CONFIG_I2C_AMD756_S4882=3Dm
> CONFIG_I2C_AMD8111=3Dm
> CONFIG_I2C_I801=3Dm
> CONFIG_I2C_ISCH=3Dm
> CONFIG_I2C_ISMT=3Dm
> CONFIG_I2C_PIIX4=3Dm
> CONFIG_I2C_NFORCE2=3Dm
> CONFIG_I2C_NFORCE2_S4985=3Dm
> CONFIG_I2C_SIS5595=3Dm
> CONFIG_I2C_SIS630=3Dm
> CONFIG_I2C_SIS96X=3Dm
> CONFIG_I2C_VIA=3Dm
> CONFIG_I2C_VIAPRO=3Dm
>
> #
> # ACPI drivers
> #
> CONFIG_I2C_SCMI=3Dm
>
> #
> # I2C system bus drivers (mostly embedded / system-on-chip)
> #
> # CONFIG_I2C_CBUS_GPIO is not set
> CONFIG_I2C_DESIGNWARE_CORE=3Dm
> CONFIG_I2C_DESIGNWARE_PLATFORM=3Dm
> CONFIG_I2C_DESIGNWARE_PCI=3Dm
> CONFIG_I2C_DESIGNWARE_BAYTRAIL=3Dy
> # CONFIG_I2C_EMEV2 is not set
> # CONFIG_I2C_GPIO is not set
> CONFIG_I2C_OCORES=3Dm
> CONFIG_I2C_PCA_PLATFORM=3Dm
> # CONFIG_I2C_PXA_PCI is not set
> CONFIG_I2C_SIMTEC=3Dm
> CONFIG_I2C_XILINX=3Dm
>
> #
> # External I2C/SMBus adapter drivers
> #
> CONFIG_I2C_DIOLAN_U2C=3Dm
> CONFIG_I2C_PARPORT=3Dm
> CONFIG_I2C_PARPORT_LIGHT=3Dm
> CONFIG_I2C_ROBOTFUZZ_OSIF=3Dm
> CONFIG_I2C_TAOS_EVM=3Dm
> CONFIG_I2C_TINY_USB=3Dm
> CONFIG_I2C_VIPERBOARD=3Dm
>
> #
> # Other I2C/SMBus bus drivers
> #
> # CONFIG_I2C_MLXCPLD is not set
> # CONFIG_I2C_CROS_EC_TUNNEL is not set
> # CONFIG_I2C_STUB is not set
> CONFIG_I2C_SLAVE=3Dy
> CONFIG_I2C_SLAVE_EEPROM=3Dm
> # CONFIG_I2C_DEBUG_CORE is not set
> # CONFIG_I2C_DEBUG_ALGO is not set
> # CONFIG_I2C_DEBUG_BUS is not set
> CONFIG_SPI=3Dy
> # CONFIG_SPI_DEBUG is not set
> CONFIG_SPI_MASTER=3Dy
>
> #
> # SPI Master Controller Drivers
> #
> CONFIG_SPI_ALTERA=3Dm
> # CONFIG_SPI_AXI_SPI_ENGINE is not set
> CONFIG_SPI_BITBANG=3Dm
> CONFIG_SPI_BUTTERFLY=3Dm
> # CONFIG_SPI_CADENCE is not set
> CONFIG_SPI_DESIGNWARE=3Dm
> CONFIG_SPI_DW_PCI=3Dm
> # CONFIG_SPI_DW_MID_DMA is not set
> CONFIG_SPI_DW_MMIO=3Dm
> CONFIG_SPI_GPIO=3Dm
> CONFIG_SPI_LM70_LLP=3Dm
> CONFIG_SPI_OC_TINY=3Dm
> CONFIG_SPI_PXA2XX=3Dm
> CONFIG_SPI_PXA2XX_PCI=3Dm
> CONFIG_SPI_ROCKCHIP=3Dm
> CONFIG_SPI_SC18IS602=3Dm
> CONFIG_SPI_XCOMM=3Dm
> CONFIG_SPI_XILINX=3Dm
> CONFIG_SPI_ZYNQMP_GQSPI=3Dm
>
> #
> # SPI Protocol Masters
> #
> CONFIG_SPI_SPIDEV=3Dm
> # CONFIG_SPI_LOOPBACK_TEST is not set
> CONFIG_SPI_TLE62X0=3Dm
> CONFIG_SPMI=3Dm
> # CONFIG_HSI is not set
>
> #
> # PPS support
> #
> CONFIG_PPS=3Dm
> # CONFIG_PPS_DEBUG is not set
>
> #
> # PPS clients support
> #
> CONFIG_PPS_CLIENT_KTIMER=3Dm
> CONFIG_PPS_CLIENT_LDISC=3Dm
> CONFIG_PPS_CLIENT_PARPORT=3Dm
> CONFIG_PPS_CLIENT_GPIO=3Dm
>
> #
> # PPS generators support
> #
>
> #
> # PTP clock support
> #
> CONFIG_PTP_1588_CLOCK=3Dm
> CONFIG_DP83640_PHY=3Dm
> CONFIG_PTP_1588_CLOCK_KVM=3Dm
> CONFIG_PINCTRL=3Dy
>
> #
> # Pin controllers
> #
> CONFIG_PINMUX=3Dy
> CONFIG_PINCONF=3Dy
> CONFIG_GENERIC_PINCONF=3Dy
> # CONFIG_DEBUG_PINCTRL is not set
> # CONFIG_PINCTRL_AMD is not set
> # CONFIG_PINCTRL_SX150X is not set
> CONFIG_PINCTRL_BAYTRAIL=3Dy
> CONFIG_PINCTRL_CHERRYVIEW=3Dy
> CONFIG_PINCTRL_INTEL=3Dy
> CONFIG_PINCTRL_BROXTON=3Dy
> # CONFIG_PINCTRL_GEMINILAKE is not set
> CONFIG_PINCTRL_SUNRISEPOINT=3Dy
> CONFIG_GPIOLIB=3Dy
> CONFIG_GPIO_ACPI=3Dy
> CONFIG_GPIOLIB_IRQCHIP=3Dy
> # CONFIG_DEBUG_GPIO is not set
> CONFIG_GPIO_SYSFS=3Dy
>
> #
> # Memory mapped GPIO drivers
> #
> # CONFIG_GPIO_AMDPT is not set
> # CONFIG_GPIO_DWAPB is not set
> # CONFIG_GPIO_EXAR is not set
> # CONFIG_GPIO_GENERIC_PLATFORM is not set
> CONFIG_GPIO_ICH=3Dm
> CONFIG_GPIO_LYNXPOINT=3Dy
> # CONFIG_GPIO_MOCKUP is not set
> # CONFIG_GPIO_VX855 is not set
>
> #
> # Port-mapped I/O GPIO drivers
> #
> # CONFIG_GPIO_F7188X is not set
> # CONFIG_GPIO_IT87 is not set
> CONFIG_GPIO_SCH=3Dm
> CONFIG_GPIO_SCH311X=3Dm
>
> #
> # I2C GPIO expanders
> #
> # CONFIG_GPIO_ADP5588 is not set
> # CONFIG_GPIO_MAX7300 is not set
> # CONFIG_GPIO_MAX732X is not set
> # CONFIG_GPIO_PCA953X is not set
> # CONFIG_GPIO_PCF857X is not set
> # CONFIG_GPIO_SX150X is not set
> # CONFIG_GPIO_TPIC2810 is not set
>
> #
> # MFD GPIO expanders
> #
> # CONFIG_GPIO_ARIZONA is not set
> CONFIG_GPIO_CRYSTAL_COVE=3Dy
> # CONFIG_GPIO_LP3943 is not set
> # CONFIG_GPIO_TPS65218 is not set
> # CONFIG_GPIO_UCB1400 is not set
>
> #
> # PCI GPIO expanders
> #
> CONFIG_GPIO_AMD8111=3Dm
> # CONFIG_GPIO_ML_IOH is not set
> # CONFIG_GPIO_PCI_IDIO_16 is not set
> # CONFIG_GPIO_RDC321X is not set
>
> #
> # SPI GPIO expanders
> #
> # CONFIG_GPIO_MAX7301 is not set
> # CONFIG_GPIO_MC33880 is not set
> # CONFIG_GPIO_PISOSR is not set
>
> #
> # SPI or I2C GPIO expanders
> #
>
> #
> # USB GPIO expanders
> #
> CONFIG_GPIO_VIPERBOARD=3Dm
> # CONFIG_W1 is not set
> CONFIG_POWER_AVS=3Dy
> CONFIG_POWER_RESET=3Dy
> # CONFIG_POWER_RESET_RESTART is not set
> CONFIG_POWER_SUPPLY=3Dy
> # CONFIG_POWER_SUPPLY_DEBUG is not set
> CONFIG_PDA_POWER=3Dm
> # CONFIG_GENERIC_ADC_BATTERY is not set
> CONFIG_TEST_POWER=3Dm
> # CONFIG_BATTERY_DS2780 is not set
> # CONFIG_BATTERY_DS2781 is not set
> # CONFIG_BATTERY_DS2782 is not set
> # CONFIG_BATTERY_SBS is not set
> # CONFIG_CHARGER_SBS is not set
> # CONFIG_BATTERY_BQ27XXX is not set
> # CONFIG_BATTERY_MAX17040 is not set
> # CONFIG_BATTERY_MAX17042 is not set
> # CONFIG_CHARGER_PCF50633 is not set
> # CONFIG_CHARGER_ISP1704 is not set
> # CONFIG_CHARGER_MAX8903 is not set
> # CONFIG_CHARGER_LP8727 is not set
> # CONFIG_CHARGER_GPIO is not set
> # CONFIG_CHARGER_BQ2415X is not set
> # CONFIG_CHARGER_BQ24190 is not set
> # CONFIG_CHARGER_BQ24257 is not set
> CONFIG_CHARGER_BQ24735=3Dm
> # CONFIG_CHARGER_BQ25890 is not set
> # CONFIG_CHARGER_SMB347 is not set
> # CONFIG_CHARGER_TPS65217 is not set
> # CONFIG_BATTERY_GAUGE_LTC2941 is not set
> # CONFIG_BATTERY_RT5033 is not set
> # CONFIG_CHARGER_RT9455 is not set
> CONFIG_HWMON=3Dy
> CONFIG_HWMON_VID=3Dm
> # CONFIG_HWMON_DEBUG_CHIP is not set
>
> #
> # Native drivers
> #
> CONFIG_SENSORS_ABITUGURU=3Dm
> CONFIG_SENSORS_ABITUGURU3=3Dm
> CONFIG_SENSORS_AD7314=3Dm
> CONFIG_SENSORS_AD7414=3Dm
> CONFIG_SENSORS_AD7418=3Dm
> CONFIG_SENSORS_ADM1021=3Dm
> CONFIG_SENSORS_ADM1025=3Dm
> CONFIG_SENSORS_ADM1026=3Dm
> CONFIG_SENSORS_ADM1029=3Dm
> CONFIG_SENSORS_ADM1031=3Dm
> CONFIG_SENSORS_ADM9240=3Dm
> CONFIG_SENSORS_ADT7X10=3Dm
> CONFIG_SENSORS_ADT7310=3Dm
> CONFIG_SENSORS_ADT7410=3Dm
> CONFIG_SENSORS_ADT7411=3Dm
> CONFIG_SENSORS_ADT7462=3Dm
> CONFIG_SENSORS_ADT7470=3Dm
> CONFIG_SENSORS_ADT7475=3Dm
> CONFIG_SENSORS_ASC7621=3Dm
> CONFIG_SENSORS_K8TEMP=3Dm
> CONFIG_SENSORS_K10TEMP=3Dm
> CONFIG_SENSORS_FAM15H_POWER=3Dm
> CONFIG_SENSORS_APPLESMC=3Dm
> CONFIG_SENSORS_ASB100=3Dm
> # CONFIG_SENSORS_ASPEED is not set
> CONFIG_SENSORS_ATXP1=3Dm
> CONFIG_SENSORS_DS620=3Dm
> CONFIG_SENSORS_DS1621=3Dm
> CONFIG_SENSORS_DELL_SMM=3Dm
> CONFIG_SENSORS_I5K_AMB=3Dm
> CONFIG_SENSORS_F71805F=3Dm
> CONFIG_SENSORS_F71882FG=3Dm
> CONFIG_SENSORS_F75375S=3Dm
> CONFIG_SENSORS_MC13783_ADC=3Dm
> CONFIG_SENSORS_FSCHMD=3Dm
> CONFIG_SENSORS_FTSTEUTATES=3Dm
> CONFIG_SENSORS_GL518SM=3Dm
> CONFIG_SENSORS_GL520SM=3Dm
> CONFIG_SENSORS_G760A=3Dm
> CONFIG_SENSORS_G762=3Dm
> CONFIG_SENSORS_GPIO_FAN=3Dm
> CONFIG_SENSORS_HIH6130=3Dm
> CONFIG_SENSORS_IBMAEM=3Dm
> CONFIG_SENSORS_IBMPEX=3Dm
> # CONFIG_SENSORS_IIO_HWMON is not set
> CONFIG_SENSORS_I5500=3Dm
> CONFIG_SENSORS_CORETEMP=3Dm
> CONFIG_SENSORS_IT87=3Dm
> CONFIG_SENSORS_JC42=3Dm
> CONFIG_SENSORS_POWR1220=3Dm
> CONFIG_SENSORS_LINEAGE=3Dm
> CONFIG_SENSORS_LTC2945=3Dm
> CONFIG_SENSORS_LTC2990=3Dm
> CONFIG_SENSORS_LTC4151=3Dm
> CONFIG_SENSORS_LTC4215=3Dm
> CONFIG_SENSORS_LTC4222=3Dm
> CONFIG_SENSORS_LTC4245=3Dm
> CONFIG_SENSORS_LTC4260=3Dm
> CONFIG_SENSORS_LTC4261=3Dm
> CONFIG_SENSORS_MAX1111=3Dm
> CONFIG_SENSORS_MAX16065=3Dm
> CONFIG_SENSORS_MAX1619=3Dm
> CONFIG_SENSORS_MAX1668=3Dm
> CONFIG_SENSORS_MAX197=3Dm
> CONFIG_SENSORS_MAX31722=3Dm
> CONFIG_SENSORS_MAX6639=3Dm
> CONFIG_SENSORS_MAX6642=3Dm
> CONFIG_SENSORS_MAX6650=3Dm
> CONFIG_SENSORS_MAX6697=3Dm
> CONFIG_SENSORS_MAX31790=3Dm
> CONFIG_SENSORS_MCP3021=3Dm
> # CONFIG_SENSORS_TC654 is not set
> CONFIG_SENSORS_ADCXX=3Dm
> CONFIG_SENSORS_LM63=3Dm
> CONFIG_SENSORS_LM70=3Dm
> CONFIG_SENSORS_LM73=3Dm
> CONFIG_SENSORS_LM75=3Dm
> CONFIG_SENSORS_LM77=3Dm
> CONFIG_SENSORS_LM78=3Dm
> CONFIG_SENSORS_LM80=3Dm
> CONFIG_SENSORS_LM83=3Dm
> CONFIG_SENSORS_LM85=3Dm
> CONFIG_SENSORS_LM87=3Dm
> CONFIG_SENSORS_LM90=3Dm
> CONFIG_SENSORS_LM92=3Dm
> CONFIG_SENSORS_LM93=3Dm
> CONFIG_SENSORS_LM95234=3Dm
> CONFIG_SENSORS_LM95241=3Dm
> CONFIG_SENSORS_LM95245=3Dm
> CONFIG_SENSORS_PC87360=3Dm
> CONFIG_SENSORS_PC87427=3Dm
> CONFIG_SENSORS_NTC_THERMISTOR=3Dm
> CONFIG_SENSORS_NCT6683=3Dm
> CONFIG_SENSORS_NCT6775=3Dm
> CONFIG_SENSORS_NCT7802=3Dm
> CONFIG_SENSORS_NCT7904=3Dm
> CONFIG_SENSORS_PCF8591=3Dm
> CONFIG_PMBUS=3Dm
> CONFIG_SENSORS_PMBUS=3Dm
> CONFIG_SENSORS_ADM1275=3Dm
> CONFIG_SENSORS_LM25066=3Dm
> CONFIG_SENSORS_LTC2978=3Dm
> CONFIG_SENSORS_LTC3815=3Dm
> CONFIG_SENSORS_MAX16064=3Dm
> CONFIG_SENSORS_MAX20751=3Dm
> CONFIG_SENSORS_MAX34440=3Dm
> CONFIG_SENSORS_MAX8688=3Dm
> CONFIG_SENSORS_TPS40422=3Dm
> CONFIG_SENSORS_UCD9000=3Dm
> CONFIG_SENSORS_UCD9200=3Dm
> CONFIG_SENSORS_ZL6100=3Dm
> CONFIG_SENSORS_SHT15=3Dm
> CONFIG_SENSORS_SHT21=3Dm
> CONFIG_SENSORS_SHT3x=3Dm
> CONFIG_SENSORS_SHTC1=3Dm
> CONFIG_SENSORS_SIS5595=3Dm
> CONFIG_SENSORS_DME1737=3Dm
> CONFIG_SENSORS_EMC1403=3Dm
> CONFIG_SENSORS_EMC2103=3Dm
> CONFIG_SENSORS_EMC6W201=3Dm
> CONFIG_SENSORS_SMSC47M1=3Dm
> CONFIG_SENSORS_SMSC47M192=3Dm
> CONFIG_SENSORS_SMSC47B397=3Dm
> CONFIG_SENSORS_SCH56XX_COMMON=3Dm
> CONFIG_SENSORS_SCH5627=3Dm
> CONFIG_SENSORS_SCH5636=3Dm
> # CONFIG_SENSORS_STTS751 is not set
> CONFIG_SENSORS_SMM665=3Dm
> CONFIG_SENSORS_ADC128D818=3Dm
> CONFIG_SENSORS_ADS1015=3Dm
> CONFIG_SENSORS_ADS7828=3Dm
> CONFIG_SENSORS_ADS7871=3Dm
> CONFIG_SENSORS_AMC6821=3Dm
> CONFIG_SENSORS_INA209=3Dm
> CONFIG_SENSORS_INA2XX=3Dm
> CONFIG_SENSORS_INA3221=3Dm
> CONFIG_SENSORS_TC74=3Dm
> CONFIG_SENSORS_THMC50=3Dm
> CONFIG_SENSORS_TMP102=3Dm
> CONFIG_SENSORS_TMP103=3Dm
> # CONFIG_SENSORS_TMP108 is not set
> CONFIG_SENSORS_TMP401=3Dm
> CONFIG_SENSORS_TMP421=3Dm
> CONFIG_SENSORS_VIA_CPUTEMP=3Dm
> CONFIG_SENSORS_VIA686A=3Dm
> CONFIG_SENSORS_VT1211=3Dm
> CONFIG_SENSORS_VT8231=3Dm
> CONFIG_SENSORS_W83781D=3Dm
> CONFIG_SENSORS_W83791D=3Dm
> CONFIG_SENSORS_W83792D=3Dm
> CONFIG_SENSORS_W83793=3Dm
> CONFIG_SENSORS_W83795=3Dm
> # CONFIG_SENSORS_W83795_FANCTRL is not set
> CONFIG_SENSORS_W83L785TS=3Dm
> CONFIG_SENSORS_W83L786NG=3Dm
> CONFIG_SENSORS_W83627HF=3Dm
> CONFIG_SENSORS_W83627EHF=3Dm
> # CONFIG_SENSORS_XGENE is not set
>
> #
> # ACPI drivers
> #
> CONFIG_SENSORS_ACPI_POWER=3Dm
> CONFIG_SENSORS_ATK0110=3Dm
> CONFIG_THERMAL=3Dy
> CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=3D0
> CONFIG_THERMAL_HWMON=3Dy
> CONFIG_THERMAL_WRITABLE_TRIPS=3Dy
> CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=3Dy
> # CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
> # CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
> # CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
> CONFIG_THERMAL_GOV_FAIR_SHARE=3Dy
> CONFIG_THERMAL_GOV_STEP_WISE=3Dy
> CONFIG_THERMAL_GOV_BANG_BANG=3Dy
> CONFIG_THERMAL_GOV_USER_SPACE=3Dy
> # CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
> # CONFIG_THERMAL_EMULATION is not set
> CONFIG_INTEL_POWERCLAMP=3Dm
> CONFIG_X86_PKG_TEMP_THERMAL=3Dm
> CONFIG_INTEL_SOC_DTS_IOSF_CORE=3Dm
> CONFIG_INTEL_SOC_DTS_THERMAL=3Dm
>
> #
> # ACPI INT340X thermal drivers
> #
> CONFIG_INT340X_THERMAL=3Dm
> CONFIG_ACPI_THERMAL_REL=3Dm
> CONFIG_INT3406_THERMAL=3Dm
> CONFIG_INTEL_PCH_THERMAL=3Dm
> CONFIG_GENERIC_ADC_THERMAL=3Dm
> CONFIG_WATCHDOG=3Dy
> CONFIG_WATCHDOG_CORE=3Dy
> # CONFIG_WATCHDOG_NOWAYOUT is not set
> CONFIG_WATCHDOG_SYSFS=3Dy
>
> #
> # Watchdog Device Drivers
> #
> CONFIG_SOFT_WATCHDOG=3Dm
> # CONFIG_SOFT_WATCHDOG_PRETIMEOUT is not set
> CONFIG_WDAT_WDT=3Dm
> CONFIG_XILINX_WATCHDOG=3Dm
> CONFIG_ZIIRAVE_WATCHDOG=3Dm
> # CONFIG_CADENCE_WATCHDOG is not set
> CONFIG_DW_WATCHDOG=3Dm
> # CONFIG_MAX63XX_WATCHDOG is not set
> CONFIG_RETU_WATCHDOG=3Dm
> CONFIG_ACQUIRE_WDT=3Dm
> CONFIG_ADVANTECH_WDT=3Dm
> CONFIG_ALIM1535_WDT=3Dm
> CONFIG_ALIM7101_WDT=3Dm
> CONFIG_F71808E_WDT=3Dm
> CONFIG_SP5100_TCO=3Dm
> CONFIG_SBC_FITPC2_WATCHDOG=3Dm
> CONFIG_EUROTECH_WDT=3Dm
> CONFIG_IB700_WDT=3Dm
> CONFIG_IBMASR=3Dm
> CONFIG_WAFER_WDT=3Dm
> CONFIG_I6300ESB_WDT=3Dm
> CONFIG_IE6XX_WDT=3Dm
> CONFIG_ITCO_WDT=3Dm
> CONFIG_ITCO_VENDOR_SUPPORT=3Dy
> CONFIG_IT8712F_WDT=3Dm
> CONFIG_IT87_WDT=3Dm
> CONFIG_HP_WATCHDOG=3Dm
> CONFIG_HPWDT_NMI_DECODING=3Dy
> CONFIG_SC1200_WDT=3Dm
> CONFIG_PC87413_WDT=3Dm
> CONFIG_NV_TCO=3Dm
> CONFIG_60XX_WDT=3Dm
> CONFIG_CPU5_WDT=3Dm
> CONFIG_SMSC_SCH311X_WDT=3Dm
> CONFIG_SMSC37B787_WDT=3Dm
> CONFIG_VIA_WDT=3Dm
> CONFIG_W83627HF_WDT=3Dm
> CONFIG_W83877F_WDT=3Dm
> CONFIG_W83977F_WDT=3Dm
> CONFIG_MACHZ_WDT=3Dm
> CONFIG_SBC_EPX_C3_WATCHDOG=3Dm
> CONFIG_INTEL_MEI_WDT=3Dm
> CONFIG_NI903X_WDT=3Dm
> # CONFIG_NIC7018_WDT is not set
> CONFIG_MEN_A21_WDT=3Dm
> CONFIG_XEN_WDT=3Dm
>
> #
> # PCI-based Watchdog Cards
> #
> CONFIG_PCIPCWATCHDOG=3Dm
> CONFIG_WDTPCI=3Dm
>
> #
> # USB-based Watchdog Cards
> #
> CONFIG_USBPCWATCHDOG=3Dm
>
> #
> # Watchdog Pretimeout Governors
> #
> CONFIG_WATCHDOG_PRETIMEOUT_GOV=3Dy
> # CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP is not set
> CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC=3Dy
> CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP=3Dm
> CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC=3Dy
> CONFIG_SSB_POSSIBLE=3Dy
>
> #
> # Sonics Silicon Backplane
> #
> CONFIG_SSB=3Dm
> CONFIG_SSB_SPROM=3Dy
> CONFIG_SSB_BLOCKIO=3Dy
> CONFIG_SSB_PCIHOST_POSSIBLE=3Dy
> CONFIG_SSB_PCIHOST=3Dy
> CONFIG_SSB_B43_PCI_BRIDGE=3Dy
> CONFIG_SSB_PCMCIAHOST_POSSIBLE=3Dy
> CONFIG_SSB_PCMCIAHOST=3Dy
> CONFIG_SSB_SDIOHOST_POSSIBLE=3Dy
> CONFIG_SSB_SDIOHOST=3Dy
> # CONFIG_SSB_DEBUG is not set
> CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=3Dy
> CONFIG_SSB_DRIVER_PCICORE=3Dy
> CONFIG_SSB_DRIVER_GPIO=3Dy
> CONFIG_BCMA_POSSIBLE=3Dy
>
> #
> # Broadcom specific AMBA
> #
> CONFIG_BCMA=3Dm
> CONFIG_BCMA_BLOCKIO=3Dy
> CONFIG_BCMA_HOST_PCI_POSSIBLE=3Dy
> CONFIG_BCMA_HOST_PCI=3Dy
> # CONFIG_BCMA_HOST_SOC is not set
> CONFIG_BCMA_DRIVER_PCI=3Dy
> CONFIG_BCMA_DRIVER_GMAC_CMN=3Dy
> CONFIG_BCMA_DRIVER_GPIO=3Dy
> # CONFIG_BCMA_DEBUG is not set
>
> #
> # Multifunction device drivers
> #
> CONFIG_MFD_CORE=3Dy
> # CONFIG_MFD_AS3711 is not set
> # CONFIG_PMIC_ADP5520 is not set
> # CONFIG_MFD_AAT2870_CORE is not set
> CONFIG_MFD_BCM590XX=3Dm
> # CONFIG_MFD_AXP20X_I2C is not set
> CONFIG_MFD_CROS_EC=3Dm
> CONFIG_MFD_CROS_EC_I2C=3Dm
> # CONFIG_MFD_CROS_EC_SPI is not set
> # CONFIG_PMIC_DA903X is not set
> # CONFIG_MFD_DA9052_SPI is not set
> # CONFIG_MFD_DA9052_I2C is not set
> # CONFIG_MFD_DA9055 is not set
> # CONFIG_MFD_DA9062 is not set
> # CONFIG_MFD_DA9063 is not set
> # CONFIG_MFD_DA9150 is not set
> # CONFIG_MFD_DLN2 is not set
> CONFIG_MFD_MC13XXX=3Dm
> # CONFIG_MFD_MC13XXX_SPI is not set
> CONFIG_MFD_MC13XXX_I2C=3Dm
> CONFIG_HTC_PASIC3=3Dm
> # CONFIG_HTC_I2CPLD is not set
> # CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
> CONFIG_LPC_ICH=3Dm
> CONFIG_LPC_SCH=3Dm
> CONFIG_INTEL_SOC_PMIC=3Dy
> # CONFIG_INTEL_SOC_PMIC_BXTWC is not set
> CONFIG_MFD_INTEL_LPSS=3Dm
> CONFIG_MFD_INTEL_LPSS_ACPI=3Dm
> CONFIG_MFD_INTEL_LPSS_PCI=3Dm
> # CONFIG_MFD_JANZ_CMODIO is not set
> # CONFIG_MFD_KEMPLD is not set
> # CONFIG_MFD_88PM800 is not set
> # CONFIG_MFD_88PM805 is not set
> # CONFIG_MFD_88PM860X is not set
> # CONFIG_MFD_MAX14577 is not set
> # CONFIG_MFD_MAX77693 is not set
> # CONFIG_MFD_MAX77843 is not set
> # CONFIG_MFD_MAX8907 is not set
> # CONFIG_MFD_MAX8925 is not set
> # CONFIG_MFD_MAX8997 is not set
> # CONFIG_MFD_MAX8998 is not set
> # CONFIG_MFD_MT6397 is not set
> # CONFIG_MFD_MENF21BMC is not set
> # CONFIG_EZX_PCAP is not set
> CONFIG_MFD_VIPERBOARD=3Dm
> CONFIG_MFD_RETU=3Dm
> CONFIG_MFD_PCF50633=3Dm
> CONFIG_PCF50633_ADC=3Dm
> CONFIG_PCF50633_GPIO=3Dm
> CONFIG_UCB1400_CORE=3Dm
> CONFIG_MFD_RDC321X=3Dm
> CONFIG_MFD_RTSX_PCI=3Dm
> CONFIG_MFD_RT5033=3Dm
> CONFIG_MFD_RTSX_USB=3Dm
> # CONFIG_MFD_RC5T583 is not set
> # CONFIG_MFD_SEC_CORE is not set
> CONFIG_MFD_SI476X_CORE=3Dm
> CONFIG_MFD_SM501=3Dm
> CONFIG_MFD_SM501_GPIO=3Dy
> # CONFIG_MFD_SKY81452 is not set
> # CONFIG_MFD_SMSC is not set
> CONFIG_ABX500_CORE=3Dy
> # CONFIG_AB3100_CORE is not set
> CONFIG_MFD_SYSCON=3Dy
> CONFIG_MFD_TI_AM335X_TSCADC=3Dm
> CONFIG_MFD_LP3943=3Dm
> # CONFIG_MFD_LP8788 is not set
> # CONFIG_MFD_TI_LMU is not set
> # CONFIG_MFD_PALMAS is not set
> # CONFIG_TPS6105X is not set
> CONFIG_TPS65010=3Dm
> CONFIG_TPS6507X=3Dm
> # CONFIG_MFD_TPS65086 is not set
> # CONFIG_MFD_TPS65090 is not set
> CONFIG_MFD_TPS65217=3Dm
> # CONFIG_MFD_TI_LP873X is not set
> CONFIG_MFD_TPS65218=3Dm
> # CONFIG_MFD_TPS6586X is not set
> # CONFIG_MFD_TPS65910 is not set
> # CONFIG_MFD_TPS65912_I2C is not set
> # CONFIG_MFD_TPS65912_SPI is not set
> # CONFIG_MFD_TPS80031 is not set
> # CONFIG_TWL4030_CORE is not set
> # CONFIG_TWL6040_CORE is not set
> CONFIG_MFD_WL1273_CORE=3Dm
> CONFIG_MFD_LM3533=3Dm
> # CONFIG_MFD_TMIO is not set
> CONFIG_MFD_VX855=3Dm
> CONFIG_MFD_ARIZONA=3Dy
> CONFIG_MFD_ARIZONA_I2C=3Dm
> # CONFIG_MFD_ARIZONA_SPI is not set
> # CONFIG_MFD_CS47L24 is not set
> CONFIG_MFD_WM5102=3Dy
> CONFIG_MFD_WM5110=3Dy
> # CONFIG_MFD_WM8997 is not set
> # CONFIG_MFD_WM8998 is not set
> # CONFIG_MFD_WM8400 is not set
> # CONFIG_MFD_WM831X_I2C is not set
> # CONFIG_MFD_WM831X_SPI is not set
> # CONFIG_MFD_WM8350_I2C is not set
> # CONFIG_MFD_WM8994 is not set
> # CONFIG_REGULATOR is not set
> CONFIG_MEDIA_SUPPORT=3Dm
>
> #
> # Multimedia core support
> #
> CONFIG_MEDIA_CAMERA_SUPPORT=3Dy
> CONFIG_MEDIA_ANALOG_TV_SUPPORT=3Dy
> CONFIG_MEDIA_DIGITAL_TV_SUPPORT=3Dy
> CONFIG_MEDIA_RADIO_SUPPORT=3Dy
> CONFIG_MEDIA_SDR_SUPPORT=3Dy
> CONFIG_MEDIA_RC_SUPPORT=3Dy
> # CONFIG_MEDIA_CEC_SUPPORT is not set
> CONFIG_MEDIA_CONTROLLER=3Dy
> # CONFIG_MEDIA_CONTROLLER_DVB is not set
> CONFIG_VIDEO_DEV=3Dm
> CONFIG_VIDEO_V4L2_SUBDEV_API=3Dy
> CONFIG_VIDEO_V4L2=3Dm
> # CONFIG_VIDEO_ADV_DEBUG is not set
> # CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
> # CONFIG_VIDEO_PCI_SKELETON is not set
> CONFIG_VIDEO_TUNER=3Dm
> CONFIG_V4L2_MEM2MEM_DEV=3Dm
> # CONFIG_V4L2_FLASH_LED_CLASS is not set
> CONFIG_VIDEOBUF_GEN=3Dm
> CONFIG_VIDEOBUF_DMA_SG=3Dm
> CONFIG_VIDEOBUF_VMALLOC=3Dm
> CONFIG_VIDEOBUF_DVB=3Dm
> CONFIG_VIDEOBUF2_CORE=3Dm
> CONFIG_VIDEOBUF2_MEMOPS=3Dm
> CONFIG_VIDEOBUF2_DMA_CONTIG=3Dm
> CONFIG_VIDEOBUF2_VMALLOC=3Dm
> CONFIG_VIDEOBUF2_DMA_SG=3Dm
> CONFIG_VIDEOBUF2_DVB=3Dm
> CONFIG_DVB_CORE=3Dm
> CONFIG_DVB_NET=3Dy
> CONFIG_TTPCI_EEPROM=3Dm
> CONFIG_DVB_MAX_ADAPTERS=3D8
> # CONFIG_DVB_DYNAMIC_MINORS is not set
> # CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
>
> #
> # Media drivers
> #
> CONFIG_RC_CORE=3Dm
> CONFIG_RC_MAP=3Dm
> CONFIG_RC_DECODERS=3Dy
> CONFIG_LIRC=3Dm
> CONFIG_IR_LIRC_CODEC=3Dm
> CONFIG_IR_NEC_DECODER=3Dm
> CONFIG_IR_RC5_DECODER=3Dm
> CONFIG_IR_RC6_DECODER=3Dm
> CONFIG_IR_JVC_DECODER=3Dm
> CONFIG_IR_SONY_DECODER=3Dm
> CONFIG_IR_SANYO_DECODER=3Dm
> CONFIG_IR_SHARP_DECODER=3Dm
> CONFIG_IR_MCE_KBD_DECODER=3Dm
> CONFIG_IR_XMP_DECODER=3Dm
> CONFIG_RC_DEVICES=3Dy
> CONFIG_RC_ATI_REMOTE=3Dm
> CONFIG_IR_ENE=3Dm
> CONFIG_IR_HIX5HD2=3Dm
> CONFIG_IR_IMON=3Dm
> CONFIG_IR_MCEUSB=3Dm
> CONFIG_IR_ITE_CIR=3Dm
> CONFIG_IR_FINTEK=3Dm
> CONFIG_IR_NUVOTON=3Dm
> CONFIG_IR_REDRAT3=3Dm
> # CONFIG_IR_SPI is not set
> CONFIG_IR_STREAMZAP=3Dm
> CONFIG_IR_WINBOND_CIR=3Dm
> CONFIG_IR_IGORPLUGUSB=3Dm
> CONFIG_IR_IGUANA=3Dm
> CONFIG_IR_TTUSBIR=3Dm
> CONFIG_RC_LOOPBACK=3Dm
> CONFIG_IR_GPIO_CIR=3Dm
> # CONFIG_IR_SERIAL is not set
> # CONFIG_IR_SIR is not set
> CONFIG_MEDIA_USB_SUPPORT=3Dy
>
> #
> # Webcam devices
> #
> CONFIG_USB_VIDEO_CLASS=3Dm
> CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=3Dy
> CONFIG_USB_GSPCA=3Dm
> CONFIG_USB_M5602=3Dm
> CONFIG_USB_STV06XX=3Dm
> CONFIG_USB_GL860=3Dm
> CONFIG_USB_GSPCA_BENQ=3Dm
> CONFIG_USB_GSPCA_CONEX=3Dm
> CONFIG_USB_GSPCA_CPIA1=3Dm
> CONFIG_USB_GSPCA_DTCS033=3Dm
> CONFIG_USB_GSPCA_ETOMS=3Dm
> CONFIG_USB_GSPCA_FINEPIX=3Dm
> CONFIG_USB_GSPCA_JEILINJ=3Dm
> CONFIG_USB_GSPCA_JL2005BCD=3Dm
> CONFIG_USB_GSPCA_KINECT=3Dm
> CONFIG_USB_GSPCA_KONICA=3Dm
> CONFIG_USB_GSPCA_MARS=3Dm
> CONFIG_USB_GSPCA_MR97310A=3Dm
> CONFIG_USB_GSPCA_NW80X=3Dm
> CONFIG_USB_GSPCA_OV519=3Dm
> CONFIG_USB_GSPCA_OV534=3Dm
> CONFIG_USB_GSPCA_OV534_9=3Dm
> CONFIG_USB_GSPCA_PAC207=3Dm
> CONFIG_USB_GSPCA_PAC7302=3Dm
> CONFIG_USB_GSPCA_PAC7311=3Dm
> CONFIG_USB_GSPCA_SE401=3Dm
> CONFIG_USB_GSPCA_SN9C2028=3Dm
> CONFIG_USB_GSPCA_SN9C20X=3Dm
> CONFIG_USB_GSPCA_SONIXB=3Dm
> CONFIG_USB_GSPCA_SONIXJ=3Dm
> CONFIG_USB_GSPCA_SPCA500=3Dm
> CONFIG_USB_GSPCA_SPCA501=3Dm
> CONFIG_USB_GSPCA_SPCA505=3Dm
> CONFIG_USB_GSPCA_SPCA506=3Dm
> CONFIG_USB_GSPCA_SPCA508=3Dm
> CONFIG_USB_GSPCA_SPCA561=3Dm
> CONFIG_USB_GSPCA_SPCA1528=3Dm
> CONFIG_USB_GSPCA_SQ905=3Dm
> CONFIG_USB_GSPCA_SQ905C=3Dm
> CONFIG_USB_GSPCA_SQ930X=3Dm
> CONFIG_USB_GSPCA_STK014=3Dm
> CONFIG_USB_GSPCA_STK1135=3Dm
> CONFIG_USB_GSPCA_STV0680=3Dm
> CONFIG_USB_GSPCA_SUNPLUS=3Dm
> CONFIG_USB_GSPCA_T613=3Dm
> CONFIG_USB_GSPCA_TOPRO=3Dm
> CONFIG_USB_GSPCA_TOUPTEK=3Dm
> CONFIG_USB_GSPCA_TV8532=3Dm
> CONFIG_USB_GSPCA_VC032X=3Dm
> CONFIG_USB_GSPCA_VICAM=3Dm
> CONFIG_USB_GSPCA_XIRLINK_CIT=3Dm
> CONFIG_USB_GSPCA_ZC3XX=3Dm
> CONFIG_USB_PWC=3Dm
> # CONFIG_USB_PWC_DEBUG is not set
> CONFIG_USB_PWC_INPUT_EVDEV=3Dy
> CONFIG_VIDEO_CPIA2=3Dm
> CONFIG_USB_ZR364XX=3Dm
> CONFIG_USB_STKWEBCAM=3Dm
> CONFIG_USB_S2255=3Dm
> CONFIG_VIDEO_USBTV=3Dm
>
> #
> # Analog TV USB devices
> #
> CONFIG_VIDEO_PVRUSB2=3Dm
> CONFIG_VIDEO_PVRUSB2_SYSFS=3Dy
> CONFIG_VIDEO_PVRUSB2_DVB=3Dy
> # CONFIG_VIDEO_PVRUSB2_DEBUGIFC is not set
> CONFIG_VIDEO_HDPVR=3Dm
> CONFIG_VIDEO_USBVISION=3Dm
> CONFIG_VIDEO_STK1160_COMMON=3Dm
> CONFIG_VIDEO_STK1160=3Dm
> CONFIG_VIDEO_GO7007=3Dm
> CONFIG_VIDEO_GO7007_USB=3Dm
> CONFIG_VIDEO_GO7007_LOADER=3Dm
> # CONFIG_VIDEO_GO7007_USB_S2250_BOARD is not set
>
> #
> # Analog/digital TV USB devices
> #
> CONFIG_VIDEO_AU0828=3Dm
> CONFIG_VIDEO_AU0828_V4L2=3Dy
> CONFIG_VIDEO_AU0828_RC=3Dy
> CONFIG_VIDEO_CX231XX=3Dm
> CONFIG_VIDEO_CX231XX_RC=3Dy
> CONFIG_VIDEO_CX231XX_ALSA=3Dm
> CONFIG_VIDEO_CX231XX_DVB=3Dm
> CONFIG_VIDEO_TM6000=3Dm
> CONFIG_VIDEO_TM6000_ALSA=3Dm
> CONFIG_VIDEO_TM6000_DVB=3Dm
>
> #
> # Digital TV USB devices
> #
> CONFIG_DVB_USB=3Dm
> # CONFIG_DVB_USB_DEBUG is not set
> CONFIG_DVB_USB_DIB3000MC=3Dm
> CONFIG_DVB_USB_A800=3Dm
> CONFIG_DVB_USB_DIBUSB_MB=3Dm
> CONFIG_DVB_USB_DIBUSB_MB_FAULTY=3Dy
> CONFIG_DVB_USB_DIBUSB_MC=3Dm
> CONFIG_DVB_USB_DIB0700=3Dm
> CONFIG_DVB_USB_UMT_010=3Dm
> CONFIG_DVB_USB_CXUSB=3Dm
> CONFIG_DVB_USB_M920X=3Dm
> CONFIG_DVB_USB_DIGITV=3Dm
> CONFIG_DVB_USB_VP7045=3Dm
> CONFIG_DVB_USB_VP702X=3Dm
> CONFIG_DVB_USB_GP8PSK=3Dm
> CONFIG_DVB_USB_NOVA_T_USB2=3Dm
> CONFIG_DVB_USB_TTUSB2=3Dm
> CONFIG_DVB_USB_DTT200U=3Dm
> CONFIG_DVB_USB_OPERA1=3Dm
> CONFIG_DVB_USB_AF9005=3Dm
> CONFIG_DVB_USB_AF9005_REMOTE=3Dm
> CONFIG_DVB_USB_PCTV452E=3Dm
> CONFIG_DVB_USB_DW2102=3Dm
> CONFIG_DVB_USB_CINERGY_T2=3Dm
> CONFIG_DVB_USB_DTV5100=3Dm
> CONFIG_DVB_USB_FRIIO=3Dm
> CONFIG_DVB_USB_AZ6027=3Dm
> CONFIG_DVB_USB_TECHNISAT_USB2=3Dm
> CONFIG_DVB_USB_V2=3Dm
> CONFIG_DVB_USB_AF9015=3Dm
> CONFIG_DVB_USB_AF9035=3Dm
> CONFIG_DVB_USB_ANYSEE=3Dm
> CONFIG_DVB_USB_AU6610=3Dm
> CONFIG_DVB_USB_AZ6007=3Dm
> CONFIG_DVB_USB_CE6230=3Dm
> CONFIG_DVB_USB_EC168=3Dm
> CONFIG_DVB_USB_GL861=3Dm
> CONFIG_DVB_USB_LME2510=3Dm
> CONFIG_DVB_USB_MXL111SF=3Dm
> CONFIG_DVB_USB_RTL28XXU=3Dm
> CONFIG_DVB_USB_DVBSKY=3Dm
> # CONFIG_DVB_USB_ZD1301 is not set
> CONFIG_DVB_TTUSB_BUDGET=3Dm
> CONFIG_DVB_TTUSB_DEC=3Dm
> CONFIG_SMS_USB_DRV=3Dm
> CONFIG_DVB_B2C2_FLEXCOP_USB=3Dm
> # CONFIG_DVB_B2C2_FLEXCOP_USB_DEBUG is not set
> CONFIG_DVB_AS102=3Dm
>
> #
> # Webcam, TV (analog/digital) USB devices
> #
> CONFIG_VIDEO_EM28XX=3Dm
> CONFIG_VIDEO_EM28XX_V4L2=3Dm
> CONFIG_VIDEO_EM28XX_ALSA=3Dm
> CONFIG_VIDEO_EM28XX_DVB=3Dm
> CONFIG_VIDEO_EM28XX_RC=3Dm
>
> #
> # Software defined radio USB devices
> #
> CONFIG_USB_AIRSPY=3Dm
> CONFIG_USB_HACKRF=3Dm
> CONFIG_USB_MSI2500=3Dm
> CONFIG_MEDIA_PCI_SUPPORT=3Dy
>
> #
> # Media capture support
> #
> CONFIG_VIDEO_MEYE=3Dm
> CONFIG_VIDEO_SOLO6X10=3Dm
> CONFIG_VIDEO_TW5864=3Dm
> CONFIG_VIDEO_TW68=3Dm
> CONFIG_VIDEO_TW686X=3Dm
> CONFIG_VIDEO_ZORAN=3Dm
> CONFIG_VIDEO_ZORAN_DC30=3Dm
> CONFIG_VIDEO_ZORAN_ZR36060=3Dm
> CONFIG_VIDEO_ZORAN_BUZ=3Dm
> CONFIG_VIDEO_ZORAN_DC10=3Dm
> CONFIG_VIDEO_ZORAN_LML33=3Dm
> CONFIG_VIDEO_ZORAN_LML33R10=3Dm
> CONFIG_VIDEO_ZORAN_AVS6EYES=3Dm
>
> #
> # Media capture/analog TV support
> #
> CONFIG_VIDEO_IVTV=3Dm
> # CONFIG_VIDEO_IVTV_DEPRECATED_IOCTLS is not set
> CONFIG_VIDEO_IVTV_ALSA=3Dm
> CONFIG_VIDEO_FB_IVTV=3Dm
> CONFIG_VIDEO_HEXIUM_GEMINI=3Dm
> CONFIG_VIDEO_HEXIUM_ORION=3Dm
> CONFIG_VIDEO_MXB=3Dm
> CONFIG_VIDEO_DT3155=3Dm
>
> #
> # Media capture/analog/hybrid TV support
> #
> CONFIG_VIDEO_CX18=3Dm
> CONFIG_VIDEO_CX18_ALSA=3Dm
> CONFIG_VIDEO_CX23885=3Dm
> CONFIG_MEDIA_ALTERA_CI=3Dm
> CONFIG_VIDEO_CX25821=3Dm
> CONFIG_VIDEO_CX25821_ALSA=3Dm
> CONFIG_VIDEO_CX88=3Dm
> CONFIG_VIDEO_CX88_ALSA=3Dm
> CONFIG_VIDEO_CX88_BLACKBIRD=3Dm
> CONFIG_VIDEO_CX88_DVB=3Dm
> CONFIG_VIDEO_CX88_ENABLE_VP3054=3Dy
> CONFIG_VIDEO_CX88_VP3054=3Dm
> CONFIG_VIDEO_CX88_MPEG=3Dm
> CONFIG_VIDEO_BT848=3Dm
> CONFIG_DVB_BT8XX=3Dm
> CONFIG_VIDEO_SAA7134=3Dm
> CONFIG_VIDEO_SAA7134_ALSA=3Dm
> CONFIG_VIDEO_SAA7134_RC=3Dy
> CONFIG_VIDEO_SAA7134_DVB=3Dm
> CONFIG_VIDEO_SAA7134_GO7007=3Dm
> CONFIG_VIDEO_SAA7164=3Dm
> CONFIG_VIDEO_COBALT=3Dm
>
> #
> # Media digital TV PCI Adapters
> #
> CONFIG_DVB_AV7110_IR=3Dy
> CONFIG_DVB_AV7110=3Dm
> CONFIG_DVB_AV7110_OSD=3Dy
> CONFIG_DVB_BUDGET_CORE=3Dm
> CONFIG_DVB_BUDGET=3Dm
> CONFIG_DVB_BUDGET_CI=3Dm
> CONFIG_DVB_BUDGET_AV=3Dm
> CONFIG_DVB_BUDGET_PATCH=3Dm
> CONFIG_DVB_B2C2_FLEXCOP_PCI=3Dm
> # CONFIG_DVB_B2C2_FLEXCOP_PCI_DEBUG is not set
> CONFIG_DVB_PLUTO2=3Dm
> CONFIG_DVB_DM1105=3Dm
> CONFIG_DVB_PT1=3Dm
> CONFIG_DVB_PT3=3Dm
> CONFIG_MANTIS_CORE=3Dm
> CONFIG_DVB_MANTIS=3Dm
> CONFIG_DVB_HOPPER=3Dm
> CONFIG_DVB_NGENE=3Dm
> CONFIG_DVB_DDBRIDGE=3Dm
> CONFIG_DVB_SMIPCIE=3Dm
> CONFIG_DVB_NETUP_UNIDVB=3Dm
> # CONFIG_V4L_PLATFORM_DRIVERS is not set
> CONFIG_V4L_MEM2MEM_DRIVERS=3Dy
> CONFIG_VIDEO_MEM2MEM_DEINTERLACE=3Dm
> CONFIG_VIDEO_SH_VEU=3Dm
> CONFIG_V4L_TEST_DRIVERS=3Dy
> # CONFIG_VIDEO_VIMC is not set
> # CONFIG_VIDEO_VIVID is not set
> # CONFIG_VIDEO_VIM2M is not set
> # CONFIG_DVB_PLATFORM_DRIVERS is not set
>
> #
> # Supported MMC/SDIO adapters
> #
> CONFIG_SMS_SDIO_DRV=3Dm
> CONFIG_RADIO_ADAPTERS=3Dy
> CONFIG_RADIO_TEA575X=3Dm
> CONFIG_RADIO_SI470X=3Dy
> CONFIG_USB_SI470X=3Dm
> CONFIG_I2C_SI470X=3Dm
> CONFIG_RADIO_SI4713=3Dm
> CONFIG_USB_SI4713=3Dm
> CONFIG_PLATFORM_SI4713=3Dm
> CONFIG_I2C_SI4713=3Dm
> CONFIG_RADIO_SI476X=3Dm
> CONFIG_USB_MR800=3Dm
> CONFIG_USB_DSBR=3Dm
> CONFIG_RADIO_MAXIRADIO=3Dm
> CONFIG_RADIO_SHARK=3Dm
> CONFIG_RADIO_SHARK2=3Dm
> CONFIG_USB_KEENE=3Dm
> CONFIG_USB_RAREMONO=3Dm
> CONFIG_USB_MA901=3Dm
> CONFIG_RADIO_TEA5764=3Dm
> CONFIG_RADIO_SAA7706H=3Dm
> CONFIG_RADIO_TEF6862=3Dm
> CONFIG_RADIO_WL1273=3Dm
>
> #
> # Texas Instruments WL128x FM driver (ST based)
> #
> CONFIG_RADIO_WL128X=3Dm
>
> #
> # Supported FireWire (IEEE 1394) Adapters
> #
> CONFIG_DVB_FIREDTV=3Dm
> CONFIG_DVB_FIREDTV_INPUT=3Dy
> CONFIG_MEDIA_COMMON_OPTIONS=3Dy
>
> #
> # common driver options
> #
> CONFIG_VIDEO_CX2341X=3Dm
> CONFIG_VIDEO_TVEEPROM=3Dm
> CONFIG_CYPRESS_FIRMWARE=3Dm
> CONFIG_DVB_B2C2_FLEXCOP=3Dm
> CONFIG_VIDEO_SAA7146=3Dm
> CONFIG_VIDEO_SAA7146_VV=3Dm
> CONFIG_SMS_SIANO_MDTV=3Dm
> CONFIG_SMS_SIANO_RC=3Dy
> # CONFIG_SMS_SIANO_DEBUGFS is not set
>
> #
> # Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
> #
> CONFIG_MEDIA_SUBDRV_AUTOSELECT=3Dy
> CONFIG_MEDIA_ATTACH=3Dy
> CONFIG_VIDEO_IR_I2C=3Dm
>
> #
> # Audio decoders, processors and mixers
> #
> CONFIG_VIDEO_TVAUDIO=3Dm
> CONFIG_VIDEO_TDA7432=3Dm
> CONFIG_VIDEO_TDA9840=3Dm
> CONFIG_VIDEO_TEA6415C=3Dm
> CONFIG_VIDEO_TEA6420=3Dm
> CONFIG_VIDEO_MSP3400=3Dm
> CONFIG_VIDEO_CS3308=3Dm
> CONFIG_VIDEO_CS5345=3Dm
> CONFIG_VIDEO_CS53L32A=3Dm
> CONFIG_VIDEO_UDA1342=3Dm
> CONFIG_VIDEO_WM8775=3Dm
> CONFIG_VIDEO_WM8739=3Dm
> CONFIG_VIDEO_VP27SMPX=3Dm
> CONFIG_VIDEO_SONY_BTF_MPX=3Dm
>
> #
> # RDS decoders
> #
> CONFIG_VIDEO_SAA6588=3Dm
>
> #
> # Video decoders
> #
> CONFIG_VIDEO_ADV7604=3Dm
> CONFIG_VIDEO_ADV7842=3Dm
> CONFIG_VIDEO_BT819=3Dm
> CONFIG_VIDEO_BT856=3Dm
> CONFIG_VIDEO_BT866=3Dm
> CONFIG_VIDEO_KS0127=3Dm
> CONFIG_VIDEO_SAA7110=3Dm
> CONFIG_VIDEO_SAA711X=3Dm
> CONFIG_VIDEO_TVP5150=3Dm
> CONFIG_VIDEO_TW2804=3Dm
> CONFIG_VIDEO_TW9903=3Dm
> CONFIG_VIDEO_TW9906=3Dm
> CONFIG_VIDEO_VPX3220=3Dm
>
> #
> # Video and audio decoders
> #
> CONFIG_VIDEO_SAA717X=3Dm
> CONFIG_VIDEO_CX25840=3Dm
>
> #
> # Video encoders
> #
> CONFIG_VIDEO_SAA7127=3Dm
> CONFIG_VIDEO_SAA7185=3Dm
> CONFIG_VIDEO_ADV7170=3Dm
> CONFIG_VIDEO_ADV7175=3Dm
> CONFIG_VIDEO_ADV7511=3Dm
>
> #
> # Camera sensor devices
> #
> CONFIG_VIDEO_OV2640=3Dm
> CONFIG_VIDEO_OV7640=3Dm
> CONFIG_VIDEO_MT9V011=3Dm
>
> #
> # Flash devices
> #
>
> #
> # Video improvement chips
> #
> CONFIG_VIDEO_UPD64031A=3Dm
> CONFIG_VIDEO_UPD64083=3Dm
>
> #
> # Audio/Video compression chips
> #
> CONFIG_VIDEO_SAA6752HS=3Dm
>
> #
> # Miscellaneous helper chips
> #
> CONFIG_VIDEO_M52790=3Dm
>
> #
> # Sensors used on soc_camera driver
> #
> CONFIG_MEDIA_TUNER=3Dm
> CONFIG_MEDIA_TUNER_SIMPLE=3Dm
> CONFIG_MEDIA_TUNER_TDA8290=3Dm
> CONFIG_MEDIA_TUNER_TDA827X=3Dm
> CONFIG_MEDIA_TUNER_TDA18271=3Dm
> CONFIG_MEDIA_TUNER_TDA9887=3Dm
> CONFIG_MEDIA_TUNER_TEA5761=3Dm
> CONFIG_MEDIA_TUNER_TEA5767=3Dm
> CONFIG_MEDIA_TUNER_MSI001=3Dm
> CONFIG_MEDIA_TUNER_MT20XX=3Dm
> CONFIG_MEDIA_TUNER_MT2060=3Dm
> CONFIG_MEDIA_TUNER_MT2063=3Dm
> CONFIG_MEDIA_TUNER_MT2266=3Dm
> CONFIG_MEDIA_TUNER_MT2131=3Dm
> CONFIG_MEDIA_TUNER_QT1010=3Dm
> CONFIG_MEDIA_TUNER_XC2028=3Dm
> CONFIG_MEDIA_TUNER_XC5000=3Dm
> CONFIG_MEDIA_TUNER_XC4000=3Dm
> CONFIG_MEDIA_TUNER_MXL5005S=3Dm
> CONFIG_MEDIA_TUNER_MXL5007T=3Dm
> CONFIG_MEDIA_TUNER_MC44S803=3Dm
> CONFIG_MEDIA_TUNER_MAX2165=3Dm
> CONFIG_MEDIA_TUNER_TDA18218=3Dm
> CONFIG_MEDIA_TUNER_FC0011=3Dm
> CONFIG_MEDIA_TUNER_FC0012=3Dm
> CONFIG_MEDIA_TUNER_FC0013=3Dm
> CONFIG_MEDIA_TUNER_TDA18212=3Dm
> CONFIG_MEDIA_TUNER_E4000=3Dm
> CONFIG_MEDIA_TUNER_FC2580=3Dm
> CONFIG_MEDIA_TUNER_M88RS6000T=3Dm
> CONFIG_MEDIA_TUNER_TUA9001=3Dm
> CONFIG_MEDIA_TUNER_SI2157=3Dm
> CONFIG_MEDIA_TUNER_IT913X=3Dm
> CONFIG_MEDIA_TUNER_R820T=3Dm
> CONFIG_MEDIA_TUNER_MXL301RF=3Dm
> CONFIG_MEDIA_TUNER_QM1D1C0042=3Dm
>
> #
> # Multistandard (satellite) frontends
> #
> CONFIG_DVB_STB0899=3Dm
> CONFIG_DVB_STB6100=3Dm
> CONFIG_DVB_STV090x=3Dm
> CONFIG_DVB_STV6110x=3Dm
> CONFIG_DVB_M88DS3103=3Dm
>
> #
> # Multistandard (cable + terrestrial) frontends
> #
> CONFIG_DVB_DRXK=3Dm
> CONFIG_DVB_TDA18271C2DD=3Dm
> CONFIG_DVB_SI2165=3Dm
> CONFIG_DVB_MN88472=3Dm
> CONFIG_DVB_MN88473=3Dm
>
> #
> # DVB-S (satellite) frontends
> #
> CONFIG_DVB_CX24110=3Dm
> CONFIG_DVB_CX24123=3Dm
> CONFIG_DVB_MT312=3Dm
> CONFIG_DVB_ZL10036=3Dm
> CONFIG_DVB_ZL10039=3Dm
> CONFIG_DVB_S5H1420=3Dm
> CONFIG_DVB_STV0288=3Dm
> CONFIG_DVB_STB6000=3Dm
> CONFIG_DVB_STV0299=3Dm
> CONFIG_DVB_STV6110=3Dm
> CONFIG_DVB_STV0900=3Dm
> CONFIG_DVB_TDA8083=3Dm
> CONFIG_DVB_TDA10086=3Dm
> CONFIG_DVB_TDA8261=3Dm
> CONFIG_DVB_VES1X93=3Dm
> CONFIG_DVB_TUNER_ITD1000=3Dm
> CONFIG_DVB_TUNER_CX24113=3Dm
> CONFIG_DVB_TDA826X=3Dm
> CONFIG_DVB_TUA6100=3Dm
> CONFIG_DVB_CX24116=3Dm
> CONFIG_DVB_CX24117=3Dm
> CONFIG_DVB_CX24120=3Dm
> CONFIG_DVB_SI21XX=3Dm
> CONFIG_DVB_TS2020=3Dm
> CONFIG_DVB_DS3000=3Dm
> CONFIG_DVB_MB86A16=3Dm
> CONFIG_DVB_TDA10071=3Dm
>
> #
> # DVB-T (terrestrial) frontends
> #
> CONFIG_DVB_SP8870=3Dm
> CONFIG_DVB_SP887X=3Dm
> CONFIG_DVB_CX22700=3Dm
> CONFIG_DVB_CX22702=3Dm
> CONFIG_DVB_DRXD=3Dm
> CONFIG_DVB_L64781=3Dm
> CONFIG_DVB_TDA1004X=3Dm
> CONFIG_DVB_NXT6000=3Dm
> CONFIG_DVB_MT352=3Dm
> CONFIG_DVB_ZL10353=3Dm
> CONFIG_DVB_DIB3000MB=3Dm
> CONFIG_DVB_DIB3000MC=3Dm
> CONFIG_DVB_DIB7000M=3Dm
> CONFIG_DVB_DIB7000P=3Dm
> CONFIG_DVB_TDA10048=3Dm
> CONFIG_DVB_AF9013=3Dm
> CONFIG_DVB_EC100=3Dm
> CONFIG_DVB_STV0367=3Dm
> CONFIG_DVB_CXD2820R=3Dm
> CONFIG_DVB_CXD2841ER=3Dm
> CONFIG_DVB_RTL2830=3Dm
> CONFIG_DVB_RTL2832=3Dm
> CONFIG_DVB_RTL2832_SDR=3Dm
> CONFIG_DVB_SI2168=3Dm
> CONFIG_DVB_AS102_FE=3Dm
> CONFIG_DVB_GP8PSK_FE=3Dm
>
> #
> # DVB-C (cable) frontends
> #
> CONFIG_DVB_VES1820=3Dm
> CONFIG_DVB_TDA10021=3Dm
> CONFIG_DVB_TDA10023=3Dm
> CONFIG_DVB_STV0297=3Dm
>
> #
> # ATSC (North American/Korean Terrestrial/Cable DTV) frontends
> #
> CONFIG_DVB_NXT200X=3Dm
> CONFIG_DVB_OR51211=3Dm
> CONFIG_DVB_OR51132=3Dm
> CONFIG_DVB_BCM3510=3Dm
> CONFIG_DVB_LGDT330X=3Dm
> CONFIG_DVB_LGDT3305=3Dm
> CONFIG_DVB_LGDT3306A=3Dm
> CONFIG_DVB_LG2160=3Dm
> CONFIG_DVB_S5H1409=3Dm
> CONFIG_DVB_AU8522=3Dm
> CONFIG_DVB_AU8522_DTV=3Dm
> CONFIG_DVB_AU8522_V4L=3Dm
> CONFIG_DVB_S5H1411=3Dm
>
> #
> # ISDB-T (terrestrial) frontends
> #
> CONFIG_DVB_S921=3Dm
> CONFIG_DVB_DIB8000=3Dm
> CONFIG_DVB_MB86A20S=3Dm
>
> #
> # ISDB-S (satellite) & ISDB-T (terrestrial) frontends
> #
> CONFIG_DVB_TC90522=3Dm
>
> #
> # Digital terrestrial only tuners/PLL
> #
> CONFIG_DVB_PLL=3Dm
> CONFIG_DVB_TUNER_DIB0070=3Dm
> CONFIG_DVB_TUNER_DIB0090=3Dm
>
> #
> # SEC control devices for DVB-S
> #
> CONFIG_DVB_DRX39XYJ=3Dm
> CONFIG_DVB_LNBH25=3Dm
> CONFIG_DVB_LNBP21=3Dm
> CONFIG_DVB_LNBP22=3Dm
> CONFIG_DVB_ISL6405=3Dm
> CONFIG_DVB_ISL6421=3Dm
> CONFIG_DVB_ISL6423=3Dm
> CONFIG_DVB_A8293=3Dm
> CONFIG_DVB_SP2=3Dm
> CONFIG_DVB_LGS8GXX=3Dm
> CONFIG_DVB_ATBM8830=3Dm
> CONFIG_DVB_TDA665x=3Dm
> CONFIG_DVB_IX2505V=3Dm
> CONFIG_DVB_M88RS2000=3Dm
> CONFIG_DVB_AF9033=3Dm
> CONFIG_DVB_HORUS3A=3Dm
> CONFIG_DVB_ASCOT2E=3Dm
> CONFIG_DVB_HELENE=3Dm
>
> #
> # Tools to develop new frontends
> #
> # CONFIG_DVB_DUMMY_FE is not set
>
> #
> # Graphics support
> #
> CONFIG_AGP=3Dy
> CONFIG_AGP_AMD64=3Dm
> CONFIG_AGP_INTEL=3Dm
> CONFIG_AGP_SIS=3Dm
> CONFIG_AGP_VIA=3Dm
> CONFIG_INTEL_GTT=3Dm
> CONFIG_VGA_ARB=3Dy
> CONFIG_VGA_ARB_MAX_GPUS=3D16
> CONFIG_VGA_SWITCHEROO=3Dy
> CONFIG_DRM=3Dm
> CONFIG_DRM_MIPI_DSI=3Dy
> CONFIG_DRM_DP_AUX_CHARDEV=3Dy
> # CONFIG_DRM_DEBUG_MM_SELFTEST is not set
> CONFIG_DRM_KMS_HELPER=3Dm
> CONFIG_DRM_KMS_FB_HELPER=3Dy
> CONFIG_DRM_FBDEV_EMULATION=3Dy
> CONFIG_DRM_FBDEV_OVERALLOC=3D100
> CONFIG_DRM_LOAD_EDID_FIRMWARE=3Dy
> CONFIG_DRM_TTM=3Dm
> CONFIG_DRM_VM=3Dy
>
> #
> # I2C encoder or helper chips
> #
> CONFIG_DRM_I2C_CH7006=3Dm
> CONFIG_DRM_I2C_SIL164=3Dm
> CONFIG_DRM_I2C_NXP_TDA998X=3Dm
> CONFIG_DRM_RADEON=3Dm
> CONFIG_DRM_RADEON_USERPTR=3Dy
> CONFIG_DRM_AMDGPU=3Dm
> CONFIG_DRM_AMDGPU_SI=3Dy
> CONFIG_DRM_AMDGPU_CIK=3Dy
> CONFIG_DRM_AMDGPU_USERPTR=3Dy
> # CONFIG_DRM_AMDGPU_GART_DEBUGFS is not set
>
> #
> # ACP (Audio CoProcessor) Configuration
> #
> CONFIG_DRM_AMD_ACP=3Dy
> CONFIG_DRM_NOUVEAU=3Dm
> CONFIG_NOUVEAU_DEBUG=3D5
> CONFIG_NOUVEAU_DEBUG_DEFAULT=3D3
> CONFIG_DRM_NOUVEAU_BACKLIGHT=3Dy
> CONFIG_DRM_I915=3Dm
> # CONFIG_DRM_I915_ALPHA_SUPPORT is not set
> CONFIG_DRM_I915_CAPTURE_ERROR=3Dy
> CONFIG_DRM_I915_COMPRESS_ERROR=3Dy
> CONFIG_DRM_I915_USERPTR=3Dy
> CONFIG_DRM_I915_GVT=3Dy
> CONFIG_DRM_VGEM=3Dm
> CONFIG_DRM_VMWGFX=3Dm
> CONFIG_DRM_VMWGFX_FBCON=3Dy
> CONFIG_DRM_GMA500=3Dm
> CONFIG_DRM_GMA600=3Dy
> CONFIG_DRM_GMA3600=3Dy
> CONFIG_DRM_UDL=3Dm
> CONFIG_DRM_AST=3Dm
> CONFIG_DRM_MGAG200=3Dm
> CONFIG_DRM_CIRRUS_QEMU=3Dm
> CONFIG_DRM_QXL=3Dm
> CONFIG_DRM_BOCHS=3Dm
> CONFIG_DRM_VIRTIO_GPU=3Dm
> CONFIG_DRM_PANEL=3Dy
>
> #
> # Display Panels
> #
> CONFIG_DRM_BRIDGE=3Dy
>
> #
> # Display Interface Bridges
> #
> CONFIG_DRM_ANALOGIX_ANX78XX=3Dm
> CONFIG_HSA_AMD=3Dm
> # CONFIG_DRM_HISI_HIBMC is not set
> # CONFIG_DRM_TINYDRM is not set
> # CONFIG_DRM_LEGACY is not set
> # CONFIG_DRM_LIB_RANDOM is not set
>
> #
> # Frame buffer Devices
> #
> CONFIG_FB=3Dy
> CONFIG_FIRMWARE_EDID=3Dy
> CONFIG_FB_CMDLINE=3Dy
> CONFIG_FB_NOTIFY=3Dy
> # CONFIG_FB_DDC is not set
> CONFIG_FB_BOOT_VESA_SUPPORT=3Dy
> CONFIG_FB_CFB_FILLRECT=3Dy
> CONFIG_FB_CFB_COPYAREA=3Dy
> CONFIG_FB_CFB_IMAGEBLIT=3Dy
> # CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
> CONFIG_FB_SYS_FILLRECT=3Dm
> CONFIG_FB_SYS_COPYAREA=3Dm
> CONFIG_FB_SYS_IMAGEBLIT=3Dm
> # CONFIG_FB_PROVIDE_GET_FB_UNMAPPED_AREA is not set
> # CONFIG_FB_FOREIGN_ENDIAN is not set
> CONFIG_FB_SYS_FOPS=3Dm
> CONFIG_FB_DEFERRED_IO=3Dy
> # CONFIG_FB_SVGALIB is not set
> # CONFIG_FB_MACMODES is not set
> CONFIG_FB_BACKLIGHT=3Dy
> CONFIG_FB_MODE_HELPERS=3Dy
> CONFIG_FB_TILEBLITTING=3Dy
>
> #
> # Frame buffer hardware drivers
> #
> # CONFIG_FB_CIRRUS is not set
> # CONFIG_FB_PM2 is not set
> # CONFIG_FB_CYBER2000 is not set
> # CONFIG_FB_ARC is not set
> # CONFIG_FB_ASILIANT is not set
> # CONFIG_FB_IMSTT is not set
> CONFIG_FB_VGA16=3Dm
> CONFIG_FB_UVESA=3Dm
> CONFIG_FB_VESA=3Dy
> CONFIG_FB_EFI=3Dy
> # CONFIG_FB_N411 is not set
> # CONFIG_FB_HGA is not set
> CONFIG_FB_OPENCORES=3Dm
> # CONFIG_FB_S1D13XXX is not set
> # CONFIG_FB_NVIDIA is not set
> # CONFIG_FB_RIVA is not set
> # CONFIG_FB_I740 is not set
> # CONFIG_FB_LE80578 is not set
> # CONFIG_FB_MATROX is not set
> # CONFIG_FB_RADEON is not set
> # CONFIG_FB_ATY128 is not set
> # CONFIG_FB_ATY is not set
> # CONFIG_FB_S3 is not set
> # CONFIG_FB_SAVAGE is not set
> # CONFIG_FB_SIS is not set
> CONFIG_FB_VIA=3Dm
> CONFIG_FB_VIA_DIRECT_PROCFS=3Dy
> CONFIG_FB_VIA_X_COMPATIBILITY=3Dy
> # CONFIG_FB_NEOMAGIC is not set
> # CONFIG_FB_KYRO is not set
> # CONFIG_FB_3DFX is not set
> CONFIG_FB_VOODOO1=3Dm
> # CONFIG_FB_VT8623 is not set
> # CONFIG_FB_TRIDENT is not set
> # CONFIG_FB_ARK is not set
> # CONFIG_FB_PM3 is not set
> # CONFIG_FB_CARMINE is not set
> # CONFIG_FB_SM501 is not set
> # CONFIG_FB_SMSCUFX is not set
> CONFIG_FB_UDL=3Dm
> # CONFIG_FB_IBM_GXT4500 is not set
> CONFIG_FB_VIRTUAL=3Dm
> CONFIG_XEN_FBDEV_FRONTEND=3Dm
> # CONFIG_FB_METRONOME is not set
> # CONFIG_FB_MB862XX is not set
> # CONFIG_FB_BROADSHEET is not set
> # CONFIG_FB_AUO_K190X is not set
> CONFIG_FB_HYPERV=3Dm
> # CONFIG_FB_SIMPLE is not set
> # CONFIG_FB_SM712 is not set
> CONFIG_BACKLIGHT_LCD_SUPPORT=3Dy
> CONFIG_LCD_CLASS_DEVICE=3Dm
> # CONFIG_LCD_L4F00242T03 is not set
> # CONFIG_LCD_LMS283GF05 is not set
> # CONFIG_LCD_LTV350QV is not set
> # CONFIG_LCD_ILI922X is not set
> # CONFIG_LCD_ILI9320 is not set
> # CONFIG_LCD_TDO24M is not set
> # CONFIG_LCD_VGG2432A4 is not set
> CONFIG_LCD_PLATFORM=3Dm
> # CONFIG_LCD_S6E63M0 is not set
> # CONFIG_LCD_LD9040 is not set
> # CONFIG_LCD_AMS369FG06 is not set
> # CONFIG_LCD_LMS501KF03 is not set
> # CONFIG_LCD_HX8357 is not set
> CONFIG_BACKLIGHT_CLASS_DEVICE=3Dy
> # CONFIG_BACKLIGHT_GENERIC is not set
> CONFIG_BACKLIGHT_LM3533=3Dm
> CONFIG_BACKLIGHT_APPLE=3Dm
> # CONFIG_BACKLIGHT_PM8941_WLED is not set
> # CONFIG_BACKLIGHT_SAHARA is not set
> # CONFIG_BACKLIGHT_ADP8860 is not set
> # CONFIG_BACKLIGHT_ADP8870 is not set
> CONFIG_BACKLIGHT_PCF50633=3Dm
> # CONFIG_BACKLIGHT_LM3639 is not set
> # CONFIG_BACKLIGHT_TPS65217 is not set
> # CONFIG_BACKLIGHT_GPIO is not set
> # CONFIG_BACKLIGHT_LV5207LP is not set
> # CONFIG_BACKLIGHT_BD6107 is not set
> # CONFIG_BACKLIGHT_ARCXCNN is not set
> CONFIG_VGASTATE=3Dm
> CONFIG_HDMI=3Dy
>
> #
> # Console display driver support
> #
> CONFIG_VGA_CONSOLE=3Dy
> CONFIG_VGACON_SOFT_SCROLLBACK=3Dy
> CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=3D64
> # CONFIG_VGACON_SOFT_SCROLLBACK_PERSISTENT_ENABLE_BY_DEFAULT is not set=

> CONFIG_DUMMY_CONSOLE=3Dy
> CONFIG_DUMMY_CONSOLE_COLUMNS=3D80
> CONFIG_DUMMY_CONSOLE_ROWS=3D25
> CONFIG_FRAMEBUFFER_CONSOLE=3Dy
> CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=3Dy
> CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=3Dy
> # CONFIG_LOGO is not set
> CONFIG_SOUND=3Dm
> CONFIG_SOUND_OSS_CORE=3Dy
> # CONFIG_SOUND_OSS_CORE_PRECLAIM is not set
> CONFIG_SND=3Dm
> CONFIG_SND_TIMER=3Dm
> CONFIG_SND_PCM=3Dm
> CONFIG_SND_PCM_ELD=3Dy
> CONFIG_SND_PCM_IEC958=3Dy
> CONFIG_SND_DMAENGINE_PCM=3Dm
> CONFIG_SND_HWDEP=3Dm
> CONFIG_SND_RAWMIDI=3Dm
> CONFIG_SND_COMPRESS_OFFLOAD=3Dm
> CONFIG_SND_JACK=3Dy
> CONFIG_SND_JACK_INPUT_DEV=3Dy
> CONFIG_SND_SEQUENCER=3Dm
> CONFIG_SND_SEQ_DUMMY=3Dm
> CONFIG_SND_OSSEMUL=3Dy
> CONFIG_SND_MIXER_OSS=3Dm
> CONFIG_SND_PCM_OSS=3Dm
> CONFIG_SND_PCM_OSS_PLUGINS=3Dy
> CONFIG_SND_PCM_TIMER=3Dy
> CONFIG_SND_SEQUENCER_OSS=3Dy
> CONFIG_SND_HRTIMER=3Dm
> CONFIG_SND_SEQ_HRTIMER_DEFAULT=3Dy
> CONFIG_SND_DYNAMIC_MINORS=3Dy
> CONFIG_SND_MAX_CARDS=3D32
> # CONFIG_SND_SUPPORT_OLD_API is not set
> CONFIG_SND_PROC_FS=3Dy
> CONFIG_SND_VERBOSE_PROCFS=3Dy
> # CONFIG_SND_VERBOSE_PRINTK is not set
> # CONFIG_SND_DEBUG is not set
> CONFIG_SND_VMASTER=3Dy
> CONFIG_SND_DMA_SGBUF=3Dy
> CONFIG_SND_RAWMIDI_SEQ=3Dm
> CONFIG_SND_OPL3_LIB_SEQ=3Dm
> # CONFIG_SND_OPL4_LIB_SEQ is not set
> # CONFIG_SND_SBAWE_SEQ is not set
> CONFIG_SND_EMU10K1_SEQ=3Dm
> CONFIG_SND_MPU401_UART=3Dm
> CONFIG_SND_OPL3_LIB=3Dm
> CONFIG_SND_VX_LIB=3Dm
> CONFIG_SND_AC97_CODEC=3Dm
> CONFIG_SND_DRIVERS=3Dy
> # CONFIG_SND_PCSP is not set
> CONFIG_SND_DUMMY=3Dm
> CONFIG_SND_ALOOP=3Dm
> CONFIG_SND_VIRMIDI=3Dm
> CONFIG_SND_MTPAV=3Dm
> CONFIG_SND_MTS64=3Dm
> CONFIG_SND_SERIAL_U16550=3Dm
> CONFIG_SND_MPU401=3Dm
> CONFIG_SND_PORTMAN2X4=3Dm
> CONFIG_SND_AC97_POWER_SAVE=3Dy
> CONFIG_SND_AC97_POWER_SAVE_DEFAULT=3D0
> CONFIG_SND_SB_COMMON=3Dm
> CONFIG_SND_PCI=3Dy
> CONFIG_SND_AD1889=3Dm
> CONFIG_SND_ALS300=3Dm
> CONFIG_SND_ALS4000=3Dm
> CONFIG_SND_ALI5451=3Dm
> CONFIG_SND_ASIHPI=3Dm
> CONFIG_SND_ATIIXP=3Dm
> CONFIG_SND_ATIIXP_MODEM=3Dm
> CONFIG_SND_AU8810=3Dm
> CONFIG_SND_AU8820=3Dm
> CONFIG_SND_AU8830=3Dm
> CONFIG_SND_AW2=3Dm
> CONFIG_SND_AZT3328=3Dm
> CONFIG_SND_BT87X=3Dm
> # CONFIG_SND_BT87X_OVERCLOCK is not set
> CONFIG_SND_CA0106=3Dm
> CONFIG_SND_CMIPCI=3Dm
> CONFIG_SND_OXYGEN_LIB=3Dm
> CONFIG_SND_OXYGEN=3Dm
> CONFIG_SND_CS4281=3Dm
> CONFIG_SND_CS46XX=3Dm
> CONFIG_SND_CS46XX_NEW_DSP=3Dy
> CONFIG_SND_CTXFI=3Dm
> CONFIG_SND_DARLA20=3Dm
> CONFIG_SND_GINA20=3Dm
> CONFIG_SND_LAYLA20=3Dm
> CONFIG_SND_DARLA24=3Dm
> CONFIG_SND_GINA24=3Dm
> CONFIG_SND_LAYLA24=3Dm
> CONFIG_SND_MONA=3Dm
> CONFIG_SND_MIA=3Dm
> CONFIG_SND_ECHO3G=3Dm
> CONFIG_SND_INDIGO=3Dm
> CONFIG_SND_INDIGOIO=3Dm
> CONFIG_SND_INDIGODJ=3Dm
> CONFIG_SND_INDIGOIOX=3Dm
> CONFIG_SND_INDIGODJX=3Dm
> CONFIG_SND_EMU10K1=3Dm
> CONFIG_SND_EMU10K1X=3Dm
> CONFIG_SND_ENS1370=3Dm
> CONFIG_SND_ENS1371=3Dm
> CONFIG_SND_ES1938=3Dm
> CONFIG_SND_ES1968=3Dm
> CONFIG_SND_ES1968_INPUT=3Dy
> CONFIG_SND_ES1968_RADIO=3Dy
> CONFIG_SND_FM801=3Dm
> CONFIG_SND_FM801_TEA575X_BOOL=3Dy
> CONFIG_SND_HDSP=3Dm
> CONFIG_SND_HDSPM=3Dm
> CONFIG_SND_ICE1712=3Dm
> CONFIG_SND_ICE1724=3Dm
> CONFIG_SND_INTEL8X0=3Dm
> CONFIG_SND_INTEL8X0M=3Dm
> CONFIG_SND_KORG1212=3Dm
> CONFIG_SND_LOLA=3Dm
> CONFIG_SND_LX6464ES=3Dm
> CONFIG_SND_MAESTRO3=3Dm
> CONFIG_SND_MAESTRO3_INPUT=3Dy
> CONFIG_SND_MIXART=3Dm
> CONFIG_SND_NM256=3Dm
> CONFIG_SND_PCXHR=3Dm
> CONFIG_SND_RIPTIDE=3Dm
> CONFIG_SND_RME32=3Dm
> CONFIG_SND_RME96=3Dm
> CONFIG_SND_RME9652=3Dm
> CONFIG_SND_SONICVIBES=3Dm
> CONFIG_SND_TRIDENT=3Dm
> CONFIG_SND_VIA82XX=3Dm
> CONFIG_SND_VIA82XX_MODEM=3Dm
> CONFIG_SND_VIRTUOSO=3Dm
> CONFIG_SND_VX222=3Dm
> CONFIG_SND_YMFPCI=3Dm
>
> #
> # HD-Audio
> #
> CONFIG_SND_HDA=3Dm
> CONFIG_SND_HDA_INTEL=3Dm
> CONFIG_SND_HDA_HWDEP=3Dy
> CONFIG_SND_HDA_RECONFIG=3Dy
> CONFIG_SND_HDA_INPUT_BEEP=3Dy
> CONFIG_SND_HDA_INPUT_BEEP_MODE=3D1
> CONFIG_SND_HDA_PATCH_LOADER=3Dy
> CONFIG_SND_HDA_CODEC_REALTEK=3Dm
> CONFIG_SND_HDA_CODEC_ANALOG=3Dm
> CONFIG_SND_HDA_CODEC_SIGMATEL=3Dm
> CONFIG_SND_HDA_CODEC_VIA=3Dm
> CONFIG_SND_HDA_CODEC_HDMI=3Dm
> CONFIG_SND_HDA_CODEC_CIRRUS=3Dm
> CONFIG_SND_HDA_CODEC_CONEXANT=3Dm
> CONFIG_SND_HDA_CODEC_CA0110=3Dm
> CONFIG_SND_HDA_CODEC_CA0132=3Dm
> CONFIG_SND_HDA_CODEC_CA0132_DSP=3Dy
> CONFIG_SND_HDA_CODEC_CMEDIA=3Dm
> CONFIG_SND_HDA_CODEC_SI3054=3Dm
> CONFIG_SND_HDA_GENERIC=3Dm
> CONFIG_SND_HDA_POWER_SAVE_DEFAULT=3D0
> CONFIG_SND_HDA_CORE=3Dm
> CONFIG_SND_HDA_DSP_LOADER=3Dy
> CONFIG_SND_HDA_I915=3Dy
> CONFIG_SND_HDA_EXT_CORE=3Dm
> CONFIG_SND_HDA_PREALLOC_SIZE=3D4096
> CONFIG_SND_SPI=3Dy
> CONFIG_SND_USB=3Dy
> CONFIG_SND_USB_AUDIO=3Dm
> CONFIG_SND_USB_UA101=3Dm
> CONFIG_SND_USB_USX2Y=3Dm
> CONFIG_SND_USB_CAIAQ=3Dm
> CONFIG_SND_USB_CAIAQ_INPUT=3Dy
> CONFIG_SND_USB_US122L=3Dm
> CONFIG_SND_USB_6FIRE=3Dm
> CONFIG_SND_USB_HIFACE=3Dm
> CONFIG_SND_BCD2000=3Dm
> CONFIG_SND_USB_LINE6=3Dm
> CONFIG_SND_USB_POD=3Dm
> CONFIG_SND_USB_PODHD=3Dm
> CONFIG_SND_USB_TONEPORT=3Dm
> CONFIG_SND_USB_VARIAX=3Dm
> CONFIG_SND_FIREWIRE=3Dy
> CONFIG_SND_FIREWIRE_LIB=3Dm
> CONFIG_SND_DICE=3Dm
> CONFIG_SND_OXFW=3Dm
> CONFIG_SND_ISIGHT=3Dm
> CONFIG_SND_FIREWORKS=3Dm
> CONFIG_SND_BEBOB=3Dm
> CONFIG_SND_FIREWIRE_DIGI00X=3Dm
> CONFIG_SND_FIREWIRE_TASCAM=3Dm
> # CONFIG_SND_FIREWIRE_MOTU is not set
> # CONFIG_SND_FIREFACE is not set
> CONFIG_SND_PCMCIA=3Dy
> CONFIG_SND_VXPOCKET=3Dm
> CONFIG_SND_PDAUDIOCF=3Dm
> CONFIG_SND_SOC=3Dm
> CONFIG_SND_SOC_AC97_BUS=3Dy
> CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=3Dy
> CONFIG_SND_SOC_COMPRESS=3Dy
> CONFIG_SND_SOC_TOPOLOGY=3Dy
> CONFIG_SND_SOC_AMD_ACP=3Dm
> # CONFIG_SND_ATMEL_SOC is not set
> CONFIG_SND_DESIGNWARE_I2S=3Dm
> # CONFIG_SND_DESIGNWARE_PCM is not set
>
> #
> # SoC Audio for Freescale CPUs
> #
>
> #
> # Common SoC Audio options for Freescale CPUs:
> #
> # CONFIG_SND_SOC_FSL_ASRC is not set
> # CONFIG_SND_SOC_FSL_SAI is not set
> # CONFIG_SND_SOC_FSL_SSI is not set
> # CONFIG_SND_SOC_FSL_SPDIF is not set
> # CONFIG_SND_SOC_FSL_ESAI is not set
> # CONFIG_SND_SOC_IMX_AUDMUX is not set
> # CONFIG_SND_I2S_HI6210_I2S is not set
> # CONFIG_SND_SOC_IMG is not set
> CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=3Dm
> CONFIG_SND_SST_IPC=3Dm
> CONFIG_SND_SST_IPC_ACPI=3Dm
> CONFIG_SND_SOC_INTEL_SST=3Dm
> CONFIG_SND_SOC_INTEL_SST_FIRMWARE=3Dm
> CONFIG_SND_SOC_INTEL_SST_ACPI=3Dm
> CONFIG_SND_SOC_INTEL_SST_MATCH=3Dm
> CONFIG_SND_SOC_INTEL_HASWELL=3Dm
> CONFIG_SND_SOC_INTEL_HASWELL_MACH=3Dm
> CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH=3Dm
> CONFIG_SND_SOC_INTEL_BXT_RT298_MACH=3Dm
> CONFIG_SND_SOC_INTEL_BDW_RT5677_MACH=3Dm
> CONFIG_SND_SOC_INTEL_BROADWELL_MACH=3Dm
> CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH=3Dm
> CONFIG_SND_SOC_INTEL_BYTCR_RT5651_MACH=3Dm
> CONFIG_SND_SOC_INTEL_CHT_BSW_RT5672_MACH=3Dm
> CONFIG_SND_SOC_INTEL_CHT_BSW_RT5645_MACH=3Dm
> CONFIG_SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH=3Dm
> # CONFIG_SND_SOC_INTEL_BYT_CHT_DA7213_MACH is not set
> # CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH is not set
> CONFIG_SND_SOC_INTEL_SKYLAKE=3Dm
> CONFIG_SND_SOC_INTEL_SKL_RT286_MACH=3Dm
> CONFIG_SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH=3Dm
> CONFIG_SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH=3Dm
> # CONFIG_SND_SOC_XTFPGA_I2S is not set
> # CONFIG_ZX_TDM is not set
> CONFIG_SND_SOC_I2C_AND_SPI=3Dm
>
> #
> # CODEC drivers
> #
> CONFIG_SND_SOC_AC97_CODEC=3Dm
> # CONFIG_SND_SOC_ADAU1701 is not set
> # CONFIG_SND_SOC_ADAU1761_I2C is not set
> # CONFIG_SND_SOC_ADAU1761_SPI is not set
> # CONFIG_SND_SOC_ADAU7002 is not set
> # CONFIG_SND_SOC_AK4104 is not set
> # CONFIG_SND_SOC_AK4554 is not set
> # CONFIG_SND_SOC_AK4613 is not set
> # CONFIG_SND_SOC_AK4642 is not set
> # CONFIG_SND_SOC_AK5386 is not set
> # CONFIG_SND_SOC_ALC5623 is not set
> # CONFIG_SND_SOC_BT_SCO is not set
> # CONFIG_SND_SOC_CS35L32 is not set
> # CONFIG_SND_SOC_CS35L33 is not set
> # CONFIG_SND_SOC_CS35L34 is not set
> # CONFIG_SND_SOC_CS35L35 is not set
> # CONFIG_SND_SOC_CS42L42 is not set
> # CONFIG_SND_SOC_CS42L51_I2C is not set
> # CONFIG_SND_SOC_CS42L52 is not set
> # CONFIG_SND_SOC_CS42L56 is not set
> # CONFIG_SND_SOC_CS42L73 is not set
> # CONFIG_SND_SOC_CS4265 is not set
> # CONFIG_SND_SOC_CS4270 is not set
> # CONFIG_SND_SOC_CS4271_I2C is not set
> # CONFIG_SND_SOC_CS4271_SPI is not set
> # CONFIG_SND_SOC_CS42XX8_I2C is not set
> # CONFIG_SND_SOC_CS4349 is not set
> # CONFIG_SND_SOC_CS53L30 is not set
> CONFIG_SND_SOC_DA7219=3Dm
> # CONFIG_SND_SOC_DIO2125 is not set
> CONFIG_SND_SOC_DMIC=3Dm
> CONFIG_SND_SOC_HDMI_CODEC=3Dm
> # CONFIG_SND_SOC_ES7134 is not set
> # CONFIG_SND_SOC_ES8328_I2C is not set
> # CONFIG_SND_SOC_ES8328_SPI is not set
> # CONFIG_SND_SOC_GTM601 is not set
> CONFIG_SND_SOC_HDAC_HDMI=3Dm
> # CONFIG_SND_SOC_INNO_RK3036 is not set
> CONFIG_SND_SOC_MAX98090=3Dm
> CONFIG_SND_SOC_MAX98357A=3Dm
> # CONFIG_SND_SOC_MAX98504 is not set
> # CONFIG_SND_SOC_MAX98927 is not set
> # CONFIG_SND_SOC_MAX9860 is not set
> # CONFIG_SND_SOC_MSM8916_WCD_ANALOG is not set
> # CONFIG_SND_SOC_MSM8916_WCD_DIGITAL is not set
> # CONFIG_SND_SOC_PCM1681 is not set
> # CONFIG_SND_SOC_PCM179X_I2C is not set
> # CONFIG_SND_SOC_PCM179X_SPI is not set
> # CONFIG_SND_SOC_PCM3168A_I2C is not set
> # CONFIG_SND_SOC_PCM3168A_SPI is not set
> # CONFIG_SND_SOC_PCM512x_I2C is not set
> # CONFIG_SND_SOC_PCM512x_SPI is not set
> CONFIG_SND_SOC_RL6231=3Dm
> CONFIG_SND_SOC_RL6347A=3Dm
> CONFIG_SND_SOC_RT286=3Dm
> CONFIG_SND_SOC_RT298=3Dm
> # CONFIG_SND_SOC_RT5616 is not set
> # CONFIG_SND_SOC_RT5631 is not set
> CONFIG_SND_SOC_RT5640=3Dm
> CONFIG_SND_SOC_RT5645=3Dm
> CONFIG_SND_SOC_RT5651=3Dm
> CONFIG_SND_SOC_RT5670=3Dm
> CONFIG_SND_SOC_RT5677=3Dm
> CONFIG_SND_SOC_RT5677_SPI=3Dm
> # CONFIG_SND_SOC_SGTL5000 is not set
> CONFIG_SND_SOC_SI476X=3Dm
> # CONFIG_SND_SOC_SIRF_AUDIO_CODEC is not set
> CONFIG_SND_SOC_SPDIF=3Dm
> # CONFIG_SND_SOC_SSM2602_SPI is not set
> # CONFIG_SND_SOC_SSM2602_I2C is not set
> CONFIG_SND_SOC_SSM4567=3Dm
> # CONFIG_SND_SOC_STA32X is not set
> # CONFIG_SND_SOC_STA350 is not set
> # CONFIG_SND_SOC_STI_SAS is not set
> # CONFIG_SND_SOC_TAS2552 is not set
> # CONFIG_SND_SOC_TAS5086 is not set
> # CONFIG_SND_SOC_TAS571X is not set
> # CONFIG_SND_SOC_TAS5720 is not set
> # CONFIG_SND_SOC_TFA9879 is not set
> # CONFIG_SND_SOC_TLV320AIC23_I2C is not set
> # CONFIG_SND_SOC_TLV320AIC23_SPI is not set
> # CONFIG_SND_SOC_TLV320AIC31XX is not set
> # CONFIG_SND_SOC_TLV320AIC3X is not set
> CONFIG_SND_SOC_TS3A227E=3Dm
> # CONFIG_SND_SOC_WM8510 is not set
> # CONFIG_SND_SOC_WM8523 is not set
> # CONFIG_SND_SOC_WM8580 is not set
> # CONFIG_SND_SOC_WM8711 is not set
> # CONFIG_SND_SOC_WM8728 is not set
> # CONFIG_SND_SOC_WM8731 is not set
> # CONFIG_SND_SOC_WM8737 is not set
> # CONFIG_SND_SOC_WM8741 is not set
> # CONFIG_SND_SOC_WM8750 is not set
> # CONFIG_SND_SOC_WM8753 is not set
> # CONFIG_SND_SOC_WM8770 is not set
> # CONFIG_SND_SOC_WM8776 is not set
> # CONFIG_SND_SOC_WM8804_I2C is not set
> # CONFIG_SND_SOC_WM8804_SPI is not set
> # CONFIG_SND_SOC_WM8903 is not set
> # CONFIG_SND_SOC_WM8960 is not set
> # CONFIG_SND_SOC_WM8962 is not set
> # CONFIG_SND_SOC_WM8974 is not set
> # CONFIG_SND_SOC_WM8978 is not set
> # CONFIG_SND_SOC_WM8985 is not set
> # CONFIG_SND_SOC_NAU8540 is not set
> # CONFIG_SND_SOC_NAU8810 is not set
> # CONFIG_SND_SOC_NAU8824 is not set
> CONFIG_SND_SOC_NAU8825=3Dm
> # CONFIG_SND_SOC_TPA6130A2 is not set
> CONFIG_SND_SIMPLE_CARD_UTILS=3Dm
> CONFIG_SND_SIMPLE_CARD=3Dm
> CONFIG_SND_X86=3Dy
> # CONFIG_HDMI_LPE_AUDIO is not set
> CONFIG_AC97_BUS=3Dm
>
> #
> # HID support
> #
> CONFIG_HID=3Dm
> CONFIG_HID_BATTERY_STRENGTH=3Dy
> CONFIG_HIDRAW=3Dy
> CONFIG_UHID=3Dm
> CONFIG_HID_GENERIC=3Dm
>
> #
> # Special HID drivers
> #
> CONFIG_HID_A4TECH=3Dm
> # CONFIG_HID_ACCUTOUCH is not set
> CONFIG_HID_ACRUX=3Dm
> CONFIG_HID_ACRUX_FF=3Dy
> CONFIG_HID_APPLE=3Dm
> CONFIG_HID_APPLEIR=3Dm
> CONFIG_HID_ASUS=3Dm
> CONFIG_HID_AUREAL=3Dm
> CONFIG_HID_BELKIN=3Dm
> CONFIG_HID_BETOP_FF=3Dm
> CONFIG_HID_CHERRY=3Dm
> CONFIG_HID_CHICONY=3Dm
> CONFIG_HID_CORSAIR=3Dm
> CONFIG_HID_PRODIKEYS=3Dm
> CONFIG_HID_CMEDIA=3Dm
> CONFIG_HID_CP2112=3Dm
> CONFIG_HID_CYPRESS=3Dm
> CONFIG_HID_DRAGONRISE=3Dm
> CONFIG_DRAGONRISE_FF=3Dy
> CONFIG_HID_EMS_FF=3Dm
> CONFIG_HID_ELECOM=3Dm
> CONFIG_HID_ELO=3Dm
> CONFIG_HID_EZKEY=3Dm
> CONFIG_HID_GEMBIRD=3Dm
> CONFIG_HID_GFRM=3Dm
> CONFIG_HID_HOLTEK=3Dm
> CONFIG_HOLTEK_FF=3Dy
> CONFIG_HID_GT683R=3Dm
> CONFIG_HID_KEYTOUCH=3Dm
> CONFIG_HID_KYE=3Dm
> CONFIG_HID_UCLOGIC=3Dm
> CONFIG_HID_WALTOP=3Dm
> CONFIG_HID_GYRATION=3Dm
> CONFIG_HID_ICADE=3Dm
> CONFIG_HID_TWINHAN=3Dm
> CONFIG_HID_KENSINGTON=3Dm
> CONFIG_HID_LCPOWER=3Dm
> CONFIG_HID_LED=3Dm
> CONFIG_HID_LENOVO=3Dm
> CONFIG_HID_LOGITECH=3Dm
> CONFIG_HID_LOGITECH_DJ=3Dm
> CONFIG_HID_LOGITECH_HIDPP=3Dm
> CONFIG_LOGITECH_FF=3Dy
> CONFIG_LOGIRUMBLEPAD2_FF=3Dy
> CONFIG_LOGIG940_FF=3Dy
> CONFIG_LOGIWHEELS_FF=3Dy
> CONFIG_HID_MAGICMOUSE=3Dm
> # CONFIG_HID_MAYFLASH is not set
> CONFIG_HID_MICROSOFT=3Dm
> CONFIG_HID_MONTEREY=3Dm
> CONFIG_HID_MULTITOUCH=3Dm
> # CONFIG_HID_NTI is not set
> CONFIG_HID_NTRIG=3Dm
> CONFIG_HID_ORTEK=3Dm
> CONFIG_HID_PANTHERLORD=3Dm
> CONFIG_PANTHERLORD_FF=3Dy
> CONFIG_HID_PENMOUNT=3Dm
> CONFIG_HID_PETALYNX=3Dm
> CONFIG_HID_PICOLCD=3Dm
> CONFIG_HID_PICOLCD_FB=3Dy
> CONFIG_HID_PICOLCD_BACKLIGHT=3Dy
> CONFIG_HID_PICOLCD_LCD=3Dy
> CONFIG_HID_PICOLCD_LEDS=3Dy
> CONFIG_HID_PICOLCD_CIR=3Dy
> CONFIG_HID_PLANTRONICS=3Dm
> CONFIG_HID_PRIMAX=3Dm
> CONFIG_HID_ROCCAT=3Dm
> CONFIG_HID_SAITEK=3Dm
> CONFIG_HID_SAMSUNG=3Dm
> CONFIG_HID_SONY=3Dm
> CONFIG_SONY_FF=3Dy
> CONFIG_HID_SPEEDLINK=3Dm
> CONFIG_HID_STEELSERIES=3Dm
> CONFIG_HID_SUNPLUS=3Dm
> CONFIG_HID_RMI=3Dm
> CONFIG_HID_GREENASIA=3Dm
> CONFIG_GREENASIA_FF=3Dy
> CONFIG_HID_HYPERV_MOUSE=3Dm
> CONFIG_HID_SMARTJOYPLUS=3Dm
> CONFIG_SMARTJOYPLUS_FF=3Dy
> CONFIG_HID_TIVO=3Dm
> CONFIG_HID_TOPSEED=3Dm
> CONFIG_HID_THINGM=3Dm
> CONFIG_HID_THRUSTMASTER=3Dm
> CONFIG_THRUSTMASTER_FF=3Dy
> # CONFIG_HID_UDRAW_PS3 is not set
> CONFIG_HID_WACOM=3Dm
> CONFIG_HID_WIIMOTE=3Dm
> CONFIG_HID_XINMO=3Dm
> CONFIG_HID_ZEROPLUS=3Dm
> CONFIG_ZEROPLUS_FF=3Dy
> CONFIG_HID_ZYDACRON=3Dm
> CONFIG_HID_SENSOR_HUB=3Dm
> # CONFIG_HID_SENSOR_CUSTOM_SENSOR is not set
> CONFIG_HID_ALPS=3Dm
>
> #
> # USB HID support
> #
> CONFIG_USB_HID=3Dm
> CONFIG_HID_PID=3Dy
> CONFIG_USB_HIDDEV=3Dy
>
> #
> # I2C HID support
> #
> CONFIG_I2C_HID=3Dm
>
> #
> # Intel ISH HID support
> #
> CONFIG_INTEL_ISH_HID=3Dm
> CONFIG_USB_OHCI_LITTLE_ENDIAN=3Dy
> CONFIG_USB_SUPPORT=3Dy
> CONFIG_USB_COMMON=3Dm
> CONFIG_USB_ARCH_HAS_HCD=3Dy
> CONFIG_USB=3Dm
> CONFIG_USB_PCI=3Dy
> # CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set
>
> #
> # Miscellaneous USB options
> #
> CONFIG_USB_DEFAULT_PERSIST=3Dy
> CONFIG_USB_DYNAMIC_MINORS=3Dy
> # CONFIG_USB_OTG is not set
> # CONFIG_USB_OTG_WHITELIST is not set
> CONFIG_USB_LEDS_TRIGGER_USBPORT=3Dm
> CONFIG_USB_MON=3Dm
> CONFIG_USB_WUSB=3Dm
> CONFIG_USB_WUSB_CBAF=3Dm
> # CONFIG_USB_WUSB_CBAF_DEBUG is not set
>
> #
> # USB Host Controller Drivers
> #
> CONFIG_USB_C67X00_HCD=3Dm
> CONFIG_USB_XHCI_HCD=3Dm
> CONFIG_USB_XHCI_PCI=3Dm
> # CONFIG_USB_XHCI_PLATFORM is not set
> CONFIG_USB_EHCI_HCD=3Dm
> CONFIG_USB_EHCI_ROOT_HUB_TT=3Dy
> CONFIG_USB_EHCI_TT_NEWSCHED=3Dy
> CONFIG_USB_EHCI_PCI=3Dm
> # CONFIG_USB_EHCI_HCD_PLATFORM is not set
> CONFIG_USB_OXU210HP_HCD=3Dm
> CONFIG_USB_ISP116X_HCD=3Dm
> CONFIG_USB_ISP1362_HCD=3Dm
> # CONFIG_USB_FOTG210_HCD is not set
> CONFIG_USB_MAX3421_HCD=3Dm
> CONFIG_USB_OHCI_HCD=3Dm
> CONFIG_USB_OHCI_HCD_PCI=3Dm
> # CONFIG_USB_OHCI_HCD_SSB is not set
> # CONFIG_USB_OHCI_HCD_PLATFORM is not set
> CONFIG_USB_UHCI_HCD=3Dm
> CONFIG_USB_U132_HCD=3Dm
> CONFIG_USB_SL811_HCD=3Dm
> # CONFIG_USB_SL811_HCD_ISO is not set
> CONFIG_USB_SL811_CS=3Dm
> CONFIG_USB_R8A66597_HCD=3Dm
> CONFIG_USB_WHCI_HCD=3Dm
> CONFIG_USB_HWA_HCD=3Dm
> # CONFIG_USB_HCD_BCMA is not set
> # CONFIG_USB_HCD_SSB is not set
> # CONFIG_USB_HCD_TEST_MODE is not set
>
> #
> # USB Device Class drivers
> #
> CONFIG_USB_ACM=3Dm
> CONFIG_USB_PRINTER=3Dm
> CONFIG_USB_WDM=3Dm
> CONFIG_USB_TMC=3Dm
>
> #
> # NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
> #
>
> #
> # also be needed; see USB_STORAGE Help for more info
> #
> CONFIG_USB_STORAGE=3Dm
> # CONFIG_USB_STORAGE_DEBUG is not set
> CONFIG_USB_STORAGE_REALTEK=3Dm
> CONFIG_REALTEK_AUTOPM=3Dy
> CONFIG_USB_STORAGE_DATAFAB=3Dm
> CONFIG_USB_STORAGE_FREECOM=3Dm
> CONFIG_USB_STORAGE_ISD200=3Dm
> CONFIG_USB_STORAGE_USBAT=3Dm
> CONFIG_USB_STORAGE_SDDR09=3Dm
> CONFIG_USB_STORAGE_SDDR55=3Dm
> CONFIG_USB_STORAGE_JUMPSHOT=3Dm
> CONFIG_USB_STORAGE_ALAUDA=3Dm
> CONFIG_USB_STORAGE_ONETOUCH=3Dm
> CONFIG_USB_STORAGE_KARMA=3Dm
> CONFIG_USB_STORAGE_CYPRESS_ATACB=3Dm
> CONFIG_USB_STORAGE_ENE_UB6250=3Dm
> CONFIG_USB_UAS=3Dm
>
> #
> # USB Imaging devices
> #
> CONFIG_USB_MDC800=3Dm
> CONFIG_USB_MICROTEK=3Dm
> CONFIG_USBIP_CORE=3Dm
> CONFIG_USBIP_VHCI_HCD=3Dm
> CONFIG_USBIP_VHCI_HC_PORTS=3D8
> CONFIG_USBIP_VHCI_NR_HCS=3D1
> CONFIG_USBIP_HOST=3Dm
> # CONFIG_USBIP_DEBUG is not set
> CONFIG_USB_MUSB_HDRC=3Dm
> CONFIG_USB_MUSB_HOST=3Dy
>
> #
> # Platform Glue Layer
> #
>
> #
> # MUSB DMA mode
> #
> CONFIG_MUSB_PIO_ONLY=3Dy
> # CONFIG_USB_DWC3 is not set
> # CONFIG_USB_DWC2 is not set
> # CONFIG_USB_CHIPIDEA is not set
> # CONFIG_USB_ISP1760 is not set
>
> #
> # USB port drivers
> #
> CONFIG_USB_USS720=3Dm
> CONFIG_USB_SERIAL=3Dm
> CONFIG_USB_SERIAL_GENERIC=3Dy
> CONFIG_USB_SERIAL_SIMPLE=3Dm
> CONFIG_USB_SERIAL_AIRCABLE=3Dm
> CONFIG_USB_SERIAL_ARK3116=3Dm
> CONFIG_USB_SERIAL_BELKIN=3Dm
> CONFIG_USB_SERIAL_CH341=3Dm
> CONFIG_USB_SERIAL_WHITEHEAT=3Dm
> CONFIG_USB_SERIAL_DIGI_ACCELEPORT=3Dm
> CONFIG_USB_SERIAL_CP210X=3Dm
> CONFIG_USB_SERIAL_CYPRESS_M8=3Dm
> CONFIG_USB_SERIAL_EMPEG=3Dm
> CONFIG_USB_SERIAL_FTDI_SIO=3Dm
> CONFIG_USB_SERIAL_VISOR=3Dm
> CONFIG_USB_SERIAL_IPAQ=3Dm
> CONFIG_USB_SERIAL_IR=3Dm
> CONFIG_USB_SERIAL_EDGEPORT=3Dm
> CONFIG_USB_SERIAL_EDGEPORT_TI=3Dm
> CONFIG_USB_SERIAL_F81232=3Dm
> # CONFIG_USB_SERIAL_F8153X is not set
> CONFIG_USB_SERIAL_GARMIN=3Dm
> CONFIG_USB_SERIAL_IPW=3Dm
> CONFIG_USB_SERIAL_IUU=3Dm
> CONFIG_USB_SERIAL_KEYSPAN_PDA=3Dm
> CONFIG_USB_SERIAL_KEYSPAN=3Dm
> CONFIG_USB_SERIAL_KLSI=3Dm
> CONFIG_USB_SERIAL_KOBIL_SCT=3Dm
> CONFIG_USB_SERIAL_MCT_U232=3Dm
> CONFIG_USB_SERIAL_METRO=3Dm
> CONFIG_USB_SERIAL_MOS7720=3Dm
> CONFIG_USB_SERIAL_MOS7715_PARPORT=3Dy
> CONFIG_USB_SERIAL_MOS7840=3Dm
> CONFIG_USB_SERIAL_MXUPORT=3Dm
> CONFIG_USB_SERIAL_NAVMAN=3Dm
> CONFIG_USB_SERIAL_PL2303=3Dm
> CONFIG_USB_SERIAL_OTI6858=3Dm
> CONFIG_USB_SERIAL_QCAUX=3Dm
> CONFIG_USB_SERIAL_QUALCOMM=3Dm
> CONFIG_USB_SERIAL_SPCP8X5=3Dm
> CONFIG_USB_SERIAL_SAFE=3Dm
> # CONFIG_USB_SERIAL_SAFE_PADDED is not set
> CONFIG_USB_SERIAL_SIERRAWIRELESS=3Dm
> CONFIG_USB_SERIAL_SYMBOL=3Dm
> CONFIG_USB_SERIAL_TI=3Dm
> CONFIG_USB_SERIAL_CYBERJACK=3Dm
> CONFIG_USB_SERIAL_XIRCOM=3Dm
> CONFIG_USB_SERIAL_WWAN=3Dm
> CONFIG_USB_SERIAL_OPTION=3Dm
> CONFIG_USB_SERIAL_OMNINET=3Dm
> CONFIG_USB_SERIAL_OPTICON=3Dm
> CONFIG_USB_SERIAL_XSENS_MT=3Dm
> CONFIG_USB_SERIAL_WISHBONE=3Dm
> CONFIG_USB_SERIAL_SSU100=3Dm
> CONFIG_USB_SERIAL_QT2=3Dm
> # CONFIG_USB_SERIAL_UPD78F0730 is not set
> # CONFIG_USB_SERIAL_DEBUG is not set
>
> #
> # USB Miscellaneous drivers
> #
> CONFIG_USB_EMI62=3Dm
> CONFIG_USB_EMI26=3Dm
> CONFIG_USB_ADUTUX=3Dm
> CONFIG_USB_SEVSEG=3Dm
> CONFIG_USB_RIO500=3Dm
> CONFIG_USB_LEGOTOWER=3Dm
> CONFIG_USB_LCD=3Dm
> CONFIG_USB_CYPRESS_CY7C63=3Dm
> CONFIG_USB_CYTHERM=3Dm
> CONFIG_USB_IDMOUSE=3Dm
> CONFIG_USB_FTDI_ELAN=3Dm
> CONFIG_USB_APPLEDISPLAY=3Dm
> CONFIG_USB_SISUSBVGA=3Dm
> # CONFIG_USB_SISUSBVGA_CON is not set
> CONFIG_USB_LD=3Dm
> CONFIG_USB_TRANCEVIBRATOR=3Dm
> CONFIG_USB_IOWARRIOR=3Dm
> CONFIG_USB_TEST=3Dm
> # CONFIG_USB_EHSET_TEST_FIXTURE is not set
> CONFIG_USB_ISIGHTFW=3Dm
> CONFIG_USB_YUREX=3Dm
> CONFIG_USB_EZUSB_FX2=3Dm
> # CONFIG_USB_HUB_USB251XB is not set
> CONFIG_USB_HSIC_USB3503=3Dm
> CONFIG_USB_HSIC_USB4604=3Dm
> CONFIG_USB_LINK_LAYER_TEST=3Dm
> CONFIG_USB_CHAOSKEY=3Dm
> CONFIG_UCSI=3Dm
> CONFIG_USB_ATM=3Dm
> CONFIG_USB_SPEEDTOUCH=3Dm
> CONFIG_USB_CXACRU=3Dm
> CONFIG_USB_UEAGLEATM=3Dm
> CONFIG_USB_XUSBATM=3Dm
>
> #
> # USB Physical Layer drivers
> #
> CONFIG_USB_PHY=3Dy
> CONFIG_NOP_USB_XCEIV=3Dm
> # CONFIG_USB_GPIO_VBUS is not set
> CONFIG_TAHVO_USB=3Dm
> # CONFIG_TAHVO_USB_HOST_BY_DEFAULT is not set
> CONFIG_USB_ISP1301=3Dm
> # CONFIG_USB_GADGET is not set
>
> #
> # USB Power Delivery and Type-C drivers
> #
> CONFIG_USB_LED_TRIG=3Dy
> # CONFIG_USB_ULPI_BUS is not set
> CONFIG_UWB=3Dm
> CONFIG_UWB_HWA=3Dm
> CONFIG_UWB_WHCI=3Dm
> CONFIG_UWB_I1480U=3Dm
> CONFIG_MMC=3Dm
> # CONFIG_MMC_DEBUG is not set
> CONFIG_MMC_BLOCK=3Dm
> CONFIG_MMC_BLOCK_MINORS=3D8
> CONFIG_MMC_BLOCK_BOUNCE=3Dy
> CONFIG_SDIO_UART=3Dm
> # CONFIG_MMC_TEST is not set
>
> #
> # MMC/SD/SDIO Host Controller Drivers
> #
> CONFIG_MMC_SDHCI=3Dm
> CONFIG_MMC_SDHCI_PCI=3Dm
> CONFIG_MMC_RICOH_MMC=3Dy
> CONFIG_MMC_SDHCI_ACPI=3Dm
> CONFIG_MMC_SDHCI_PLTFM=3Dm
> CONFIG_MMC_WBSD=3Dm
> CONFIG_MMC_TIFM_SD=3Dm
> CONFIG_MMC_SPI=3Dm
> CONFIG_MMC_SDRICOH_CS=3Dm
> CONFIG_MMC_CB710=3Dm
> CONFIG_MMC_VIA_SDMMC=3Dm
> CONFIG_MMC_VUB300=3Dm
> CONFIG_MMC_USHC=3Dm
> CONFIG_MMC_USDHI6ROL0=3Dm
> CONFIG_MMC_REALTEK_PCI=3Dm
> CONFIG_MMC_REALTEK_USB=3Dm
> CONFIG_MMC_TOSHIBA_PCI=3Dm
> CONFIG_MMC_MTK=3Dm
> # CONFIG_MMC_SDHCI_XENON is not set
> CONFIG_MEMSTICK=3Dm
> # CONFIG_MEMSTICK_DEBUG is not set
>
> #
> # MemoryStick drivers
> #
> # CONFIG_MEMSTICK_UNSAFE_RESUME is not set
> CONFIG_MSPRO_BLOCK=3Dm
> CONFIG_MS_BLOCK=3Dm
>
> #
> # MemoryStick Host Controller Drivers
> #
> CONFIG_MEMSTICK_TIFM_MS=3Dm
> CONFIG_MEMSTICK_JMICRON_38X=3Dm
> CONFIG_MEMSTICK_R592=3Dm
> CONFIG_MEMSTICK_REALTEK_PCI=3Dm
> CONFIG_MEMSTICK_REALTEK_USB=3Dm
> CONFIG_NEW_LEDS=3Dy
> CONFIG_LEDS_CLASS=3Dm
> CONFIG_LEDS_CLASS_FLASH=3Dm
> # CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set
>
> #
> # LED drivers
> #
> CONFIG_LEDS_LM3530=3Dm
> CONFIG_LEDS_LM3533=3Dm
> CONFIG_LEDS_LM3642=3Dm
> CONFIG_LEDS_PCA9532=3Dm
> # CONFIG_LEDS_PCA9532_GPIO is not set
> CONFIG_LEDS_GPIO=3Dm
> CONFIG_LEDS_LP3944=3Dm
> CONFIG_LEDS_LP3952=3Dm
> # CONFIG_LEDS_LP5521 is not set
> # CONFIG_LEDS_LP5523 is not set
> # CONFIG_LEDS_LP5562 is not set
> # CONFIG_LEDS_LP8501 is not set
> CONFIG_LEDS_LP8860=3Dm
> CONFIG_LEDS_CLEVO_MAIL=3Dm
> CONFIG_LEDS_PCA955X=3Dm
> CONFIG_LEDS_PCA963X=3Dm
> CONFIG_LEDS_DAC124S085=3Dm
> CONFIG_LEDS_BD2802=3Dm
> CONFIG_LEDS_INTEL_SS4200=3Dm
> CONFIG_LEDS_LT3593=3Dm
> CONFIG_LEDS_MC13783=3Dm
> CONFIG_LEDS_TCA6507=3Dm
> CONFIG_LEDS_TLC591XX=3Dm
> CONFIG_LEDS_LM355x=3Dm
>
> #
> # LED driver for blink(1) USB RGB LED is under Special HID drivers
(HID_THINGM)
> #
> CONFIG_LEDS_BLINKM=3Dm
> CONFIG_LEDS_MLXCPLD=3Dm
> # CONFIG_LEDS_USER is not set
> # CONFIG_LEDS_NIC78BX is not set
>
> #
> # LED Triggers
> #
> CONFIG_LEDS_TRIGGERS=3Dy
> CONFIG_LEDS_TRIGGER_TIMER=3Dm
> CONFIG_LEDS_TRIGGER_ONESHOT=3Dm
> CONFIG_LEDS_TRIGGER_DISK=3Dy
> CONFIG_LEDS_TRIGGER_MTD=3Dy
> CONFIG_LEDS_TRIGGER_HEARTBEAT=3Dm
> CONFIG_LEDS_TRIGGER_BACKLIGHT=3Dm
> CONFIG_LEDS_TRIGGER_CPU=3Dy
> CONFIG_LEDS_TRIGGER_GPIO=3Dm
> CONFIG_LEDS_TRIGGER_DEFAULT_ON=3Dm
>
> #
> # iptables trigger is under Netfilter config (LED target)
> #
> CONFIG_LEDS_TRIGGER_TRANSIENT=3Dm
> CONFIG_LEDS_TRIGGER_CAMERA=3Dm
> CONFIG_LEDS_TRIGGER_PANIC=3Dy
> CONFIG_ACCESSIBILITY=3Dy
> CONFIG_A11Y_BRAILLE_CONSOLE=3Dy
> CONFIG_INFINIBAND=3Dm
> CONFIG_INFINIBAND_USER_MAD=3Dm
> CONFIG_INFINIBAND_USER_ACCESS=3Dm
> CONFIG_INFINIBAND_USER_MEM=3Dy
> CONFIG_INFINIBAND_ON_DEMAND_PAGING=3Dy
> CONFIG_INFINIBAND_ADDR_TRANS=3Dy
> CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=3Dy
> CONFIG_INFINIBAND_MTHCA=3Dm
> CONFIG_INFINIBAND_MTHCA_DEBUG=3Dy
> CONFIG_INFINIBAND_QIB=3Dm
> # CONFIG_INFINIBAND_QIB_DCA is not set
> CONFIG_INFINIBAND_CXGB3=3Dm
> # CONFIG_INFINIBAND_CXGB3_DEBUG is not set
> CONFIG_INFINIBAND_CXGB4=3Dm
> CONFIG_INFINIBAND_I40IW=3Dm
> CONFIG_MLX4_INFINIBAND=3Dm
> CONFIG_MLX5_INFINIBAND=3Dm
> CONFIG_INFINIBAND_NES=3Dm
> # CONFIG_INFINIBAND_NES_DEBUG is not set
> CONFIG_INFINIBAND_OCRDMA=3Dm
> # CONFIG_INFINIBAND_VMWARE_PVRDMA is not set
> CONFIG_INFINIBAND_USNIC=3Dm
> CONFIG_INFINIBAND_IPOIB=3Dm
> CONFIG_INFINIBAND_IPOIB_CM=3Dy
> CONFIG_INFINIBAND_IPOIB_DEBUG=3Dy
> # CONFIG_INFINIBAND_IPOIB_DEBUG_DATA is not set
> CONFIG_INFINIBAND_SRP=3Dm
> CONFIG_INFINIBAND_SRPT=3Dm
> CONFIG_INFINIBAND_ISER=3Dm
> CONFIG_INFINIBAND_ISERT=3Dm
> # CONFIG_INFINIBAND_OPA_VNIC is not set
> CONFIG_INFINIBAND_RDMAVT=3Dm
> CONFIG_RDMA_RXE=3Dm
> CONFIG_INFINIBAND_HFI1=3Dm
> # CONFIG_HFI1_DEBUG_SDMA_ORDER is not set
> CONFIG_HFI1_VERBS_31BIT_PSN=3Dy
> # CONFIG_SDMA_VERBOSITY is not set
> # CONFIG_INFINIBAND_QEDR is not set
> CONFIG_EDAC_ATOMIC_SCRUB=3Dy
> CONFIG_EDAC_SUPPORT=3Dy
> CONFIG_EDAC=3Dy
> CONFIG_EDAC_LEGACY_SYSFS=3Dy
> # CONFIG_EDAC_DEBUG is not set
> CONFIG_EDAC_DECODE_MCE=3Dm
> # CONFIG_EDAC_GHES is not set
> CONFIG_EDAC_AMD64=3Dm
> # CONFIG_EDAC_AMD64_ERROR_INJECTION is not set
> CONFIG_EDAC_E752X=3Dm
> CONFIG_EDAC_I82975X=3Dm
> CONFIG_EDAC_I3000=3Dm
> CONFIG_EDAC_I3200=3Dm
> CONFIG_EDAC_IE31200=3Dm
> CONFIG_EDAC_X38=3Dm
> CONFIG_EDAC_I5400=3Dm
> CONFIG_EDAC_I7CORE=3Dm
> CONFIG_EDAC_I5000=3Dm
> CONFIG_EDAC_I5100=3Dm
> CONFIG_EDAC_I7300=3Dm
> CONFIG_EDAC_SBRIDGE=3Dm
> CONFIG_EDAC_SKX=3Dm
> # CONFIG_EDAC_PND2 is not set
> CONFIG_RTC_LIB=3Dy
> CONFIG_RTC_MC146818_LIB=3Dy
> CONFIG_RTC_CLASS=3Dy
> CONFIG_RTC_HCTOSYS=3Dy
> CONFIG_RTC_HCTOSYS_DEVICE=3D"rtc0"
> CONFIG_RTC_SYSTOHC=3Dy
> CONFIG_RTC_SYSTOHC_DEVICE=3D"rtc0"
> # CONFIG_RTC_DEBUG is not set
>
> #
> # RTC interfaces
> #
> CONFIG_RTC_INTF_SYSFS=3Dy
> CONFIG_RTC_INTF_PROC=3Dy
> CONFIG_RTC_INTF_DEV=3Dy
> CONFIG_RTC_INTF_DEV_UIE_EMUL=3Dy
> CONFIG_RTC_DRV_TEST=3Dm
>
> #
> # I2C RTC drivers
> #
> # CONFIG_RTC_DRV_ABB5ZES3 is not set
> CONFIG_RTC_DRV_ABX80X=3Dm
> CONFIG_RTC_DRV_DS1307=3Dm
> CONFIG_RTC_DRV_DS1307_HWMON=3Dy
> # CONFIG_RTC_DRV_DS1307_CENTURY is not set
> CONFIG_RTC_DRV_DS1374=3Dm
> CONFIG_RTC_DRV_DS1374_WDT=3Dy
> CONFIG_RTC_DRV_DS1672=3Dm
> CONFIG_RTC_DRV_MAX6900=3Dm
> CONFIG_RTC_DRV_RS5C372=3Dm
> CONFIG_RTC_DRV_ISL1208=3Dm
> CONFIG_RTC_DRV_ISL12022=3Dm
> CONFIG_RTC_DRV_X1205=3Dm
> CONFIG_RTC_DRV_PCF8523=3Dm
> CONFIG_RTC_DRV_PCF85063=3Dm
> CONFIG_RTC_DRV_PCF8563=3Dm
> CONFIG_RTC_DRV_PCF8583=3Dm
> CONFIG_RTC_DRV_M41T80=3Dm
> CONFIG_RTC_DRV_M41T80_WDT=3Dy
> CONFIG_RTC_DRV_BQ32K=3Dm
> CONFIG_RTC_DRV_S35390A=3Dm
> CONFIG_RTC_DRV_FM3130=3Dm
> CONFIG_RTC_DRV_RX8010=3Dm
> CONFIG_RTC_DRV_RX8581=3Dm
> CONFIG_RTC_DRV_RX8025=3Dm
> CONFIG_RTC_DRV_EM3027=3Dm
> # CONFIG_RTC_DRV_RV8803 is not set
>
> #
> # SPI RTC drivers
> #
> # CONFIG_RTC_DRV_M41T93 is not set
> # CONFIG_RTC_DRV_M41T94 is not set
> # CONFIG_RTC_DRV_DS1302 is not set
> # CONFIG_RTC_DRV_DS1305 is not set
> # CONFIG_RTC_DRV_DS1343 is not set
> # CONFIG_RTC_DRV_DS1347 is not set
> # CONFIG_RTC_DRV_DS1390 is not set
> CONFIG_RTC_DRV_MAX6916=3Dm
> # CONFIG_RTC_DRV_R9701 is not set
> # CONFIG_RTC_DRV_RX4581 is not set
> # CONFIG_RTC_DRV_RX6110 is not set
> # CONFIG_RTC_DRV_RS5C348 is not set
> # CONFIG_RTC_DRV_MAX6902 is not set
> # CONFIG_RTC_DRV_PCF2123 is not set
> # CONFIG_RTC_DRV_MCP795 is not set
> CONFIG_RTC_I2C_AND_SPI=3Dy
>
> #
> # SPI and I2C RTC drivers
> #
> CONFIG_RTC_DRV_DS3232=3Dm
> CONFIG_RTC_DRV_PCF2127=3Dm
> CONFIG_RTC_DRV_RV3029C2=3Dm
> CONFIG_RTC_DRV_RV3029_HWMON=3Dy
>
> #
> # Platform RTC drivers
> #
> CONFIG_RTC_DRV_CMOS=3Dy
> CONFIG_RTC_DRV_DS1286=3Dm
> CONFIG_RTC_DRV_DS1511=3Dm
> CONFIG_RTC_DRV_DS1553=3Dm
> CONFIG_RTC_DRV_DS1685_FAMILY=3Dm
> CONFIG_RTC_DRV_DS1685=3Dy
> # CONFIG_RTC_DRV_DS1689 is not set
> # CONFIG_RTC_DRV_DS17285 is not set
> # CONFIG_RTC_DRV_DS17485 is not set
> # CONFIG_RTC_DRV_DS17885 is not set
> # CONFIG_RTC_DS1685_PROC_REGS is not set
> CONFIG_RTC_DS1685_SYSFS_REGS=3Dy
> CONFIG_RTC_DRV_DS1742=3Dm
> CONFIG_RTC_DRV_DS2404=3Dm
> CONFIG_RTC_DRV_STK17TA8=3Dm
> CONFIG_RTC_DRV_M48T86=3Dm
> CONFIG_RTC_DRV_M48T35=3Dm
> CONFIG_RTC_DRV_M48T59=3Dm
> CONFIG_RTC_DRV_MSM6242=3Dm
> CONFIG_RTC_DRV_BQ4802=3Dm
> CONFIG_RTC_DRV_RP5C01=3Dm
> CONFIG_RTC_DRV_V3020=3Dm
> CONFIG_RTC_DRV_PCF50633=3Dm
>
> #
> # on-CPU RTC drivers
> #
> CONFIG_RTC_DRV_MC13XXX=3Dm
>
> #
> # HID Sensor RTC drivers
> #
> # CONFIG_RTC_DRV_HID_SENSOR_TIME is not set
> CONFIG_DMADEVICES=3Dy
> # CONFIG_DMADEVICES_DEBUG is not set
>
> #
> # DMA Devices
> #
> CONFIG_DMA_ENGINE=3Dy
> CONFIG_DMA_VIRTUAL_CHANNELS=3Dy
> CONFIG_DMA_ACPI=3Dy
> CONFIG_INTEL_IDMA64=3Dm
> CONFIG_INTEL_IOATDMA=3Dm
> CONFIG_INTEL_MIC_X100_DMA=3Dm
> # CONFIG_QCOM_HIDMA_MGMT is not set
> # CONFIG_QCOM_HIDMA is not set
> CONFIG_DW_DMAC_CORE=3Dy
> CONFIG_DW_DMAC=3Dy
> CONFIG_DW_DMAC_PCI=3Dy
> CONFIG_HSU_DMA=3Dy
>
> #
> # DMA Clients
> #
> CONFIG_ASYNC_TX_DMA=3Dy
> # CONFIG_DMATEST is not set
> CONFIG_DMA_ENGINE_RAID=3Dy
>
> #
> # DMABUF options
> #
> CONFIG_SYNC_FILE=3Dy
> # CONFIG_SW_SYNC is not set
> CONFIG_DCA=3Dm
> CONFIG_AUXDISPLAY=3Dy
> # CONFIG_HD44780 is not set
> CONFIG_KS0108=3Dm
> CONFIG_KS0108_PORT=3D0x378
> CONFIG_KS0108_DELAY=3D2
> CONFIG_CFAG12864B=3Dm
> CONFIG_CFAG12864B_RATE=3D20
> # CONFIG_IMG_ASCII_LCD is not set
> # CONFIG_PANEL is not set
> CONFIG_UIO=3Dm
> CONFIG_UIO_CIF=3Dm
> CONFIG_UIO_PDRV_GENIRQ=3Dm
> # CONFIG_UIO_DMEM_GENIRQ is not set
> CONFIG_UIO_AEC=3Dm
> CONFIG_UIO_SERCOS3=3Dm
> CONFIG_UIO_PCI_GENERIC=3Dm
> CONFIG_UIO_NETX=3Dm
> CONFIG_UIO_PRUSS=3Dm
> # CONFIG_UIO_MF624 is not set
> # CONFIG_UIO_HV_GENERIC is not set
> CONFIG_VFIO_IOMMU_TYPE1=3Dm
> CONFIG_VFIO_VIRQFD=3Dm
> CONFIG_VFIO=3Dm
> # CONFIG_VFIO_NOIOMMU is not set
> CONFIG_VFIO_PCI=3Dm
> CONFIG_VFIO_PCI_VGA=3Dy
> CONFIG_VFIO_PCI_MMAP=3Dy
> CONFIG_VFIO_PCI_INTX=3Dy
> CONFIG_VFIO_PCI_IGD=3Dy
> # CONFIG_VFIO_MDEV is not set
> CONFIG_IRQ_BYPASS_MANAGER=3Dm
> CONFIG_VIRT_DRIVERS=3Dy
> CONFIG_VIRTIO=3Dm
>
> #
> # Virtio drivers
> #
> CONFIG_VIRTIO_PCI=3Dm
> CONFIG_VIRTIO_PCI_LEGACY=3Dy
> CONFIG_VIRTIO_BALLOON=3Dm
> CONFIG_VIRTIO_INPUT=3Dm
> CONFIG_VIRTIO_MMIO=3Dm
> CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=3Dy
>
> #
> # Microsoft Hyper-V guest support
> #
> CONFIG_HYPERV=3Dm
> CONFIG_HYPERV_TSCPAGE=3Dy
> CONFIG_HYPERV_UTILS=3Dm
> CONFIG_HYPERV_BALLOON=3Dm
>
> #
> # Xen driver support
> #
> CONFIG_XEN_BALLOON=3Dy
> # CONFIG_XEN_SELFBALLOONING is not set
> CONFIG_XEN_BALLOON_MEMORY_HOTPLUG=3Dy
> CONFIG_XEN_BALLOON_MEMORY_HOTPLUG_LIMIT=3D512
> CONFIG_XEN_SCRUB_PAGES=3Dy
> CONFIG_XEN_DEV_EVTCHN=3Dm
> CONFIG_XEN_BACKEND=3Dy
> CONFIG_XENFS=3Dm
> CONFIG_XEN_COMPAT_XENFS=3Dy
> CONFIG_XEN_SYS_HYPERVISOR=3Dy
> CONFIG_XEN_XENBUS_FRONTEND=3Dy
> CONFIG_XEN_GNTDEV=3Dm
> CONFIG_XEN_GRANT_DEV_ALLOC=3Dm
> CONFIG_SWIOTLB_XEN=3Dy
> CONFIG_XEN_TMEM=3Dm
> CONFIG_XEN_PCIDEV_BACKEND=3Dm
> CONFIG_XEN_SCSI_BACKEND=3Dm
> CONFIG_XEN_PRIVCMD=3Dm
> CONFIG_XEN_ACPI_PROCESSOR=3Dm
> # CONFIG_XEN_MCE_LOG is not set
> CONFIG_XEN_HAVE_PVMMU=3Dy
> CONFIG_XEN_EFI=3Dy
> CONFIG_XEN_AUTO_XLATE=3Dy
> CONFIG_XEN_ACPI=3Dy
> CONFIG_XEN_SYMS=3Dy
> CONFIG_XEN_HAVE_VPMU=3Dy
> CONFIG_STAGING=3Dy
> CONFIG_PRISM2_USB=3Dm
> CONFIG_COMEDI=3Dm
> # CONFIG_COMEDI_DEBUG is not set
> CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=3D2048
> CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=3D20480
> CONFIG_COMEDI_MISC_DRIVERS=3Dy
> CONFIG_COMEDI_BOND=3Dm
> CONFIG_COMEDI_TEST=3Dm
> CONFIG_COMEDI_PARPORT=3Dm
> CONFIG_COMEDI_SERIAL2002=3Dm
> # CONFIG_COMEDI_ISA_DRIVERS is not set
> CONFIG_COMEDI_PCI_DRIVERS=3Dm
> CONFIG_COMEDI_8255_PCI=3Dm
> CONFIG_COMEDI_ADDI_WATCHDOG=3Dm
> CONFIG_COMEDI_ADDI_APCI_1032=3Dm
> CONFIG_COMEDI_ADDI_APCI_1500=3Dm
> CONFIG_COMEDI_ADDI_APCI_1516=3Dm
> CONFIG_COMEDI_ADDI_APCI_1564=3Dm
> CONFIG_COMEDI_ADDI_APCI_16XX=3Dm
> CONFIG_COMEDI_ADDI_APCI_2032=3Dm
> CONFIG_COMEDI_ADDI_APCI_2200=3Dm
> CONFIG_COMEDI_ADDI_APCI_3120=3Dm
> CONFIG_COMEDI_ADDI_APCI_3501=3Dm
> CONFIG_COMEDI_ADDI_APCI_3XXX=3Dm
> CONFIG_COMEDI_ADL_PCI6208=3Dm
> CONFIG_COMEDI_ADL_PCI7X3X=3Dm
> CONFIG_COMEDI_ADL_PCI8164=3Dm
> CONFIG_COMEDI_ADL_PCI9111=3Dm
> CONFIG_COMEDI_ADL_PCI9118=3Dm
> CONFIG_COMEDI_ADV_PCI1710=3Dm
> CONFIG_COMEDI_ADV_PCI1720=3Dm
> CONFIG_COMEDI_ADV_PCI1723=3Dm
> CONFIG_COMEDI_ADV_PCI1724=3Dm
> CONFIG_COMEDI_ADV_PCI1760=3Dm
> CONFIG_COMEDI_ADV_PCI_DIO=3Dm
> CONFIG_COMEDI_AMPLC_DIO200_PCI=3Dm
> CONFIG_COMEDI_AMPLC_PC236_PCI=3Dm
> CONFIG_COMEDI_AMPLC_PC263_PCI=3Dm
> CONFIG_COMEDI_AMPLC_PCI224=3Dm
> CONFIG_COMEDI_AMPLC_PCI230=3Dm
> CONFIG_COMEDI_CONTEC_PCI_DIO=3Dm
> CONFIG_COMEDI_DAS08_PCI=3Dm
> CONFIG_COMEDI_DT3000=3Dm
> CONFIG_COMEDI_DYNA_PCI10XX=3Dm
> CONFIG_COMEDI_GSC_HPDI=3Dm
> CONFIG_COMEDI_MF6X4=3Dm
> CONFIG_COMEDI_ICP_MULTI=3Dm
> CONFIG_COMEDI_DAQBOARD2000=3Dm
> CONFIG_COMEDI_JR3_PCI=3Dm
> CONFIG_COMEDI_KE_COUNTER=3Dm
> CONFIG_COMEDI_CB_PCIDAS64=3Dm
> CONFIG_COMEDI_CB_PCIDAS=3Dm
> CONFIG_COMEDI_CB_PCIDDA=3Dm
> CONFIG_COMEDI_CB_PCIMDAS=3Dm
> CONFIG_COMEDI_CB_PCIMDDA=3Dm
> CONFIG_COMEDI_ME4000=3Dm
> CONFIG_COMEDI_ME_DAQ=3Dm
> CONFIG_COMEDI_NI_6527=3Dm
> CONFIG_COMEDI_NI_65XX=3Dm
> CONFIG_COMEDI_NI_660X=3Dm
> CONFIG_COMEDI_NI_670X=3Dm
> CONFIG_COMEDI_NI_LABPC_PCI=3Dm
> CONFIG_COMEDI_NI_PCIDIO=3Dm
> CONFIG_COMEDI_NI_PCIMIO=3Dm
> CONFIG_COMEDI_RTD520=3Dm
> CONFIG_COMEDI_S626=3Dm
> CONFIG_COMEDI_MITE=3Dm
> CONFIG_COMEDI_NI_TIOCMD=3Dm
> CONFIG_COMEDI_PCMCIA_DRIVERS=3Dm
> CONFIG_COMEDI_CB_DAS16_CS=3Dm
> CONFIG_COMEDI_DAS08_CS=3Dm
> CONFIG_COMEDI_NI_DAQ_700_CS=3Dm
> CONFIG_COMEDI_NI_DAQ_DIO24_CS=3Dm
> CONFIG_COMEDI_NI_LABPC_CS=3Dm
> CONFIG_COMEDI_NI_MIO_CS=3Dm
> CONFIG_COMEDI_QUATECH_DAQP_CS=3Dm
> CONFIG_COMEDI_USB_DRIVERS=3Dm
> CONFIG_COMEDI_DT9812=3Dm
> CONFIG_COMEDI_NI_USB6501=3Dm
> CONFIG_COMEDI_USBDUX=3Dm
> CONFIG_COMEDI_USBDUXFAST=3Dm
> CONFIG_COMEDI_USBDUXSIGMA=3Dm
> CONFIG_COMEDI_VMK80XX=3Dm
> CONFIG_COMEDI_8254=3Dm
> CONFIG_COMEDI_8255=3Dm
> CONFIG_COMEDI_8255_SA=3Dm
> CONFIG_COMEDI_KCOMEDILIB=3Dm
> CONFIG_COMEDI_AMPLC_DIO200=3Dm
> CONFIG_COMEDI_AMPLC_PC236=3Dm
> CONFIG_COMEDI_DAS08=3Dm
> CONFIG_COMEDI_NI_LABPC=3Dm
> CONFIG_COMEDI_NI_TIO=3Dm
> CONFIG_RTL8192U=3Dm
> CONFIG_RTLLIB=3Dm
> CONFIG_RTLLIB_CRYPTO_CCMP=3Dm
> CONFIG_RTLLIB_CRYPTO_TKIP=3Dm
> CONFIG_RTLLIB_CRYPTO_WEP=3Dm
> CONFIG_RTL8192E=3Dm
> # CONFIG_RTL8723BS is not set
> CONFIG_R8712U=3Dm
> CONFIG_R8188EU=3Dm
> CONFIG_88EU_AP_MODE=3Dy
> CONFIG_RTS5208=3Dm
> CONFIG_VT6655=3Dm
> CONFIG_VT6656=3Dm
>
> #
> # IIO staging drivers
> #
>
> #
> # Accelerometers
> #
> # CONFIG_ADIS16201 is not set
> # CONFIG_ADIS16203 is not set
> # CONFIG_ADIS16209 is not set
> # CONFIG_ADIS16240 is not set
>
> #
> # Analog to digital converters
> #
> # CONFIG_AD7606 is not set
> # CONFIG_AD7780 is not set
> # CONFIG_AD7816 is not set
> # CONFIG_AD7192 is not set
> # CONFIG_AD7280 is not set
>
> #
> # Analog digital bi-direction converters
> #
> # CONFIG_ADT7316 is not set
>
> #
> # Capacitance to digital converters
> #
> # CONFIG_AD7150 is not set
> # CONFIG_AD7152 is not set
> # CONFIG_AD7746 is not set
>
> #
> # Direct Digital Synthesis
> #
> # CONFIG_AD9832 is not set
> # CONFIG_AD9834 is not set
>
> #
> # Digital gyroscope sensors
> #
> # CONFIG_ADIS16060 is not set
>
> #
> # Network Analyzer, Impedance Converters
> #
> # CONFIG_AD5933 is not set
>
> #
> # Light sensors
> #
> # CONFIG_SENSORS_ISL29028 is not set
> # CONFIG_TSL2x7x is not set
>
> #
> # Active energy metering IC
> #
> # CONFIG_ADE7753 is not set
> # CONFIG_ADE7754 is not set
> # CONFIG_ADE7758 is not set
> # CONFIG_ADE7759 is not set
> # CONFIG_ADE7854 is not set
>
> #
> # Resolver to digital converters
> #
> # CONFIG_AD2S90 is not set
> # CONFIG_AD2S1200 is not set
> # CONFIG_AD2S1210 is not set
>
> #
> # Triggers - standalone
> #
> # CONFIG_FB_SM750 is not set
> CONFIG_FB_XGI=3Dm
>
> #
> # Speakup console speech
> #
> CONFIG_SPEAKUP=3Dm
> CONFIG_SPEAKUP_SYNTH_ACNTSA=3Dm
> CONFIG_SPEAKUP_SYNTH_APOLLO=3Dm
> CONFIG_SPEAKUP_SYNTH_AUDPTR=3Dm
> CONFIG_SPEAKUP_SYNTH_BNS=3Dm
> CONFIG_SPEAKUP_SYNTH_DECTLK=3Dm
> CONFIG_SPEAKUP_SYNTH_DECEXT=3Dm
> CONFIG_SPEAKUP_SYNTH_LTLK=3Dm
> CONFIG_SPEAKUP_SYNTH_SOFT=3Dm
> CONFIG_SPEAKUP_SYNTH_SPKOUT=3Dm
> CONFIG_SPEAKUP_SYNTH_TXPRT=3Dm
> CONFIG_SPEAKUP_SYNTH_DUMMY=3Dm
> CONFIG_STAGING_MEDIA=3Dy
> # CONFIG_INTEL_ATOMISP is not set
> CONFIG_I2C_BCM2048=3Dm
> CONFIG_DVB_CXD2099=3Dm
> CONFIG_LIRC_STAGING=3Dy
> CONFIG_LIRC_ZILOG=3Dm
>
> #
> # Android
> #
> CONFIG_LTE_GDM724X=3Dm
> CONFIG_FIREWIRE_SERIAL=3Dm
> CONFIG_FWTTY_MAX_TOTAL_PORTS=3D64
> CONFIG_FWTTY_MAX_CARD_PORTS=3D32
> CONFIG_LNET=3Dm
> CONFIG_LNET_MAX_PAYLOAD=3D1048576
> CONFIG_LNET_SELFTEST=3Dm
> CONFIG_LNET_XPRT_IB=3Dm
> CONFIG_LUSTRE_FS=3Dm
> CONFIG_LUSTRE_OBD_MAX_IOCTL_BUFFER=3D8192
> # CONFIG_LUSTRE_DEBUG_EXPENSIVE_CHECK is not set
> CONFIG_DGNC=3Dm
> CONFIG_GS_FPGABOOT=3Dm
> # CONFIG_CRYPTO_SKEIN is not set
> # CONFIG_UNISYSSPAR is not set
> # CONFIG_FB_TFT is not set
> # CONFIG_WILC1000_SDIO is not set
> # CONFIG_WILC1000_SPI is not set
> # CONFIG_MOST is not set
> # CONFIG_KS7010 is not set
> # CONFIG_GREYBUS is not set
>
> #
> # USB Power Delivery and Type-C drivers
> #
> # CONFIG_TYPEC_TCPM is not set
> CONFIG_X86_PLATFORM_DEVICES=3Dy
> CONFIG_ACER_WMI=3Dm
> CONFIG_ACERHDF=3Dm
> CONFIG_ALIENWARE_WMI=3Dm
> CONFIG_ASUS_LAPTOP=3Dm
> CONFIG_DELL_SMBIOS=3Dm
> CONFIG_DELL_LAPTOP=3Dm
> CONFIG_DELL_WMI=3Dm
> CONFIG_DELL_WMI_AIO=3Dm
> # CONFIG_DELL_WMI_LED is not set
> CONFIG_DELL_SMO8800=3Dm
> CONFIG_DELL_RBTN=3Dm
> CONFIG_FUJITSU_LAPTOP=3Dm
> # CONFIG_FUJITSU_LAPTOP_DEBUG is not set
> CONFIG_FUJITSU_TABLET=3Dm
> CONFIG_AMILO_RFKILL=3Dm
> CONFIG_HP_ACCEL=3Dm
> CONFIG_HP_WIRELESS=3Dm
> CONFIG_HP_WMI=3Dm
> CONFIG_MSI_LAPTOP=3Dm
> CONFIG_PANASONIC_LAPTOP=3Dm
> CONFIG_COMPAL_LAPTOP=3Dm
> CONFIG_SONY_LAPTOP=3Dm
> # CONFIG_SONYPI_COMPAT is not set
> CONFIG_IDEAPAD_LAPTOP=3Dm
> # CONFIG_SURFACE3_WMI is not set
> CONFIG_THINKPAD_ACPI=3Dm
> CONFIG_THINKPAD_ACPI_ALSA_SUPPORT=3Dy
> # CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
> # CONFIG_THINKPAD_ACPI_DEBUG is not set
> # CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
> CONFIG_THINKPAD_ACPI_VIDEO=3Dy
> CONFIG_THINKPAD_ACPI_HOTKEY_POLL=3Dy
> CONFIG_SENSORS_HDAPS=3Dm
> CONFIG_INTEL_MENLOW=3Dm
> CONFIG_EEEPC_LAPTOP=3Dm
> CONFIG_ASUS_WMI=3Dm
> CONFIG_ASUS_NB_WMI=3Dm
> CONFIG_EEEPC_WMI=3Dm
> CONFIG_ASUS_WIRELESS=3Dm
> CONFIG_ACPI_WMI=3Dm
> CONFIG_MSI_WMI=3Dm
> CONFIG_TOPSTAR_LAPTOP=3Dm
> CONFIG_ACPI_TOSHIBA=3Dm
> CONFIG_TOSHIBA_BT_RFKILL=3Dm
> CONFIG_TOSHIBA_HAPS=3Dm
> CONFIG_TOSHIBA_WMI=3Dm
> CONFIG_ACPI_CMPC=3Dm
> # CONFIG_INTEL_CHT_INT33FE is not set
> CONFIG_INTEL_HID_EVENT=3Dm
> CONFIG_INTEL_VBTN=3Dm
> CONFIG_INTEL_IPS=3Dm
> CONFIG_INTEL_PMC_CORE=3Dy
> CONFIG_IBM_RTL=3Dm
> CONFIG_SAMSUNG_LAPTOP=3Dm
> CONFIG_MXM_WMI=3Dm
> CONFIG_INTEL_OAKTRAIL=3Dm
> CONFIG_SAMSUNG_Q10=3Dm
> CONFIG_APPLE_GMUX=3Dm
> CONFIG_INTEL_RST=3Dm
> CONFIG_INTEL_SMARTCONNECT=3Dm
> CONFIG_PVPANIC=3Dm
> CONFIG_INTEL_PMC_IPC=3Dm
> CONFIG_SURFACE_PRO3_BUTTON=3Dm
> # CONFIG_SURFACE_3_BUTTON is not set
> CONFIG_INTEL_PUNIT_IPC=3Dm
> CONFIG_INTEL_TELEMETRY=3Dm
> # CONFIG_MLX_PLATFORM is not set
> # CONFIG_MLX_CPLD_PLATFORM is not set
> # CONFIG_INTEL_TURBO_MAX_3 is not set
> # CONFIG_SILEAD_DMI is not set
> CONFIG_PMC_ATOM=3Dy
> CONFIG_CHROME_PLATFORMS=3Dy
> CONFIG_CHROMEOS_LAPTOP=3Dm
> CONFIG_CHROMEOS_PSTORE=3Dm
> CONFIG_CROS_EC_CHARDEV=3Dm
> CONFIG_CROS_EC_LPC=3Dm
> CONFIG_CROS_EC_PROTO=3Dy
> CONFIG_CROS_KBD_LED_BACKLIGHT=3Dm
> CONFIG_CLKDEV_LOOKUP=3Dy
> CONFIG_HAVE_CLK_PREPARE=3Dy
> CONFIG_COMMON_CLK=3Dy
>
> #
> # Common Clock Framework
> #
> # CONFIG_COMMON_CLK_SI5351 is not set
> # CONFIG_COMMON_CLK_CDCE706 is not set
> # CONFIG_COMMON_CLK_CS2000_CP is not set
> # CONFIG_COMMON_CLK_NXP is not set
> # CONFIG_COMMON_CLK_PXA is not set
> # CONFIG_COMMON_CLK_PIC32 is not set
>
> #
> # Hardware Spinlock drivers
> #
>
> #
> # Clock Source drivers
> #
> CONFIG_CLKEVT_I8253=3Dy
> CONFIG_I8253_LOCK=3Dy
> CONFIG_CLKBLD_I8253=3Dy
> # CONFIG_ATMEL_PIT is not set
> # CONFIG_SH_TIMER_CMT is not set
> # CONFIG_SH_TIMER_MTU2 is not set
> # CONFIG_SH_TIMER_TMU is not set
> # CONFIG_EM_TIMER_STI is not set
> CONFIG_MAILBOX=3Dy
> CONFIG_PCC=3Dy
> # CONFIG_ALTERA_MBOX is not set
> CONFIG_IOMMU_API=3Dy
> CONFIG_IOMMU_SUPPORT=3Dy
>
> #
> # Generic IOMMU Pagetable Support
> #
> CONFIG_IOMMU_IOVA=3Dy
> CONFIG_AMD_IOMMU=3Dy
> CONFIG_AMD_IOMMU_V2=3Dm
> CONFIG_DMAR_TABLE=3Dy
> CONFIG_INTEL_IOMMU=3Dy
> CONFIG_INTEL_IOMMU_SVM=3Dy
> # CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
> CONFIG_INTEL_IOMMU_FLOPPY_WA=3Dy
> CONFIG_IRQ_REMAP=3Dy
>
> #
> # Remoteproc drivers
> #
> CONFIG_REMOTEPROC=3Dm
>
> #
> # Rpmsg drivers
> #
>
> #
> # SOC (System On Chip) specific Drivers
> #
>
> #
> # Broadcom SoC drivers
> #
>
> #
> # i.MX SoC drivers
> #
> # CONFIG_SUNXI_SRAM is not set
> # CONFIG_SOC_TI is not set
> # CONFIG_SOC_ZTE is not set
> CONFIG_PM_DEVFREQ=3Dy
>
> #
> # DEVFREQ Governors
> #
> CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=3Dm
> CONFIG_DEVFREQ_GOV_PERFORMANCE=3Dm
> CONFIG_DEVFREQ_GOV_POWERSAVE=3Dm
> CONFIG_DEVFREQ_GOV_USERSPACE=3Dm
> CONFIG_DEVFREQ_GOV_PASSIVE=3Dm
>
> #
> # DEVFREQ Drivers
> #
> # CONFIG_PM_DEVFREQ_EVENT is not set
> CONFIG_EXTCON=3Dm
>
> #
> # Extcon Device Drivers
> #
> # CONFIG_EXTCON_ADC_JACK is not set
> # CONFIG_EXTCON_ARIZONA is not set
> CONFIG_EXTCON_GPIO=3Dm
> # CONFIG_EXTCON_INTEL_INT3496 is not set
> # CONFIG_EXTCON_MAX3355 is not set
> # CONFIG_EXTCON_QCOM_SPMI_MISC is not set
> # CONFIG_EXTCON_RT8973A is not set
> CONFIG_EXTCON_SM5502=3Dm
> # CONFIG_EXTCON_USB_GPIO is not set
> CONFIG_MEMORY=3Dy
> CONFIG_IIO=3Dm
> CONFIG_IIO_BUFFER=3Dy
> CONFIG_IIO_BUFFER_CB=3Dm
> CONFIG_IIO_KFIFO_BUF=3Dm
> CONFIG_IIO_TRIGGERED_BUFFER=3Dm
> CONFIG_IIO_CONFIGFS=3Dm
> CONFIG_IIO_TRIGGER=3Dy
> CONFIG_IIO_CONSUMERS_PER_TRIGGER=3D2
> CONFIG_IIO_SW_DEVICE=3Dm
> CONFIG_IIO_SW_TRIGGER=3Dm
>
> #
> # Accelerometers
> #
> # CONFIG_BMA180 is not set
> # CONFIG_BMA220 is not set
> # CONFIG_BMC150_ACCEL is not set
> # CONFIG_DA280 is not set
> # CONFIG_DA311 is not set
> # CONFIG_DMARD09 is not set
> # CONFIG_DMARD10 is not set
> CONFIG_HID_SENSOR_ACCEL_3D=3Dm
> CONFIG_IIO_ST_ACCEL_3AXIS=3Dm
> CONFIG_IIO_ST_ACCEL_I2C_3AXIS=3Dm
> CONFIG_IIO_ST_ACCEL_SPI_3AXIS=3Dm
> # CONFIG_KXSD9 is not set
> CONFIG_KXCJK1013=3Dm
> # CONFIG_MC3230 is not set
> # CONFIG_MMA7455_I2C is not set
> # CONFIG_MMA7455_SPI is not set
> CONFIG_MMA7660=3Dm
> # CONFIG_MMA8452 is not set
> # CONFIG_MMA9551 is not set
> # CONFIG_MMA9553 is not set
> # CONFIG_MXC4005 is not set
> # CONFIG_MXC6255 is not set
> # CONFIG_SCA3000 is not set
> # CONFIG_STK8312 is not set
> # CONFIG_STK8BA50 is not set
>
> #
> # Analog to digital converters
> #
> # CONFIG_AD7266 is not set
> # CONFIG_AD7291 is not set
> # CONFIG_AD7298 is not set
> # CONFIG_AD7476 is not set
> # CONFIG_AD7766 is not set
> # CONFIG_AD7791 is not set
> # CONFIG_AD7793 is not set
> # CONFIG_AD7887 is not set
> # CONFIG_AD7923 is not set
> # CONFIG_AD799X is not set
> # CONFIG_HI8435 is not set
> # CONFIG_HX711 is not set
> # CONFIG_INA2XX_ADC is not set
> # CONFIG_LTC2485 is not set
> # CONFIG_LTC2497 is not set
> # CONFIG_MAX1027 is not set
> # CONFIG_MAX11100 is not set
> # CONFIG_MAX1118 is not set
> # CONFIG_MAX1363 is not set
> # CONFIG_MAX9611 is not set
> # CONFIG_MCP320X is not set
> # CONFIG_MCP3422 is not set
> # CONFIG_NAU7802 is not set
> # CONFIG_QCOM_SPMI_IADC is not set
> # CONFIG_QCOM_SPMI_VADC is not set
> # CONFIG_TI_ADC081C is not set
> # CONFIG_TI_ADC0832 is not set
> # CONFIG_TI_ADC12138 is not set
> # CONFIG_TI_ADC128S052 is not set
> # CONFIG_TI_ADC161S626 is not set
> # CONFIG_TI_ADS1015 is not set
> # CONFIG_TI_ADS7950 is not set
> # CONFIG_TI_AM335X_ADC is not set
> # CONFIG_TI_TLC4541 is not set
> # CONFIG_VIPERBOARD_ADC is not set
>
> #
> # Amplifiers
> #
> # CONFIG_AD8366 is not set
>
> #
> # Chemical Sensors
> #
> # CONFIG_ATLAS_PH_SENSOR is not set
> # CONFIG_IAQCORE is not set
> # CONFIG_VZ89X is not set
> # CONFIG_IIO_CROS_EC_SENSORS_CORE is not set
>
> #
> # Hid Sensor IIO Common
> #
> CONFIG_HID_SENSOR_IIO_COMMON=3Dm
> CONFIG_HID_SENSOR_IIO_TRIGGER=3Dm
>
> #
> # SSP Sensor Common
> #
> # CONFIG_IIO_SSP_SENSORHUB is not set
> CONFIG_IIO_ST_SENSORS_I2C=3Dm
> CONFIG_IIO_ST_SENSORS_SPI=3Dm
> CONFIG_IIO_ST_SENSORS_CORE=3Dm
>
> #
> # Counters
> #
>
> #
> # Digital to analog converters
> #
> # CONFIG_AD5064 is not set
> # CONFIG_AD5360 is not set
> # CONFIG_AD5380 is not set
> # CONFIG_AD5421 is not set
> # CONFIG_AD5446 is not set
> # CONFIG_AD5449 is not set
> # CONFIG_AD5592R is not set
> # CONFIG_AD5593R is not set
> # CONFIG_AD5504 is not set
> # CONFIG_AD5624R_SPI is not set
> # CONFIG_LTC2632 is not set
> # CONFIG_AD5686 is not set
> # CONFIG_AD5755 is not set
> # CONFIG_AD5761 is not set
> # CONFIG_AD5764 is not set
> # CONFIG_AD5791 is not set
> # CONFIG_AD7303 is not set
> # CONFIG_AD8801 is not set
> # CONFIG_M62332 is not set
> # CONFIG_MAX517 is not set
> # CONFIG_MCP4725 is not set
> # CONFIG_MCP4922 is not set
>
> #
> # IIO dummy driver
> #
> # CONFIG_IIO_SIMPLE_DUMMY is not set
>
> #
> # Frequency Synthesizers DDS/PLL
> #
>
> #
> # Clock Generator/Distribution
> #
> # CONFIG_AD9523 is not set
>
> #
> # Phase-Locked Loop (PLL) frequency synthesizers
> #
> # CONFIG_ADF4350 is not set
>
> #
> # Digital gyroscope sensors
> #
> # CONFIG_ADIS16080 is not set
> # CONFIG_ADIS16130 is not set
> # CONFIG_ADIS16136 is not set
> # CONFIG_ADIS16260 is not set
> # CONFIG_ADXRS450 is not set
> # CONFIG_BMG160 is not set
> CONFIG_HID_SENSOR_GYRO_3D=3Dm
> # CONFIG_MPU3050_I2C is not set
> CONFIG_IIO_ST_GYRO_3AXIS=3Dm
> CONFIG_IIO_ST_GYRO_I2C_3AXIS=3Dm
> CONFIG_IIO_ST_GYRO_SPI_3AXIS=3Dm
> # CONFIG_ITG3200 is not set
>
> #
> # Health Sensors
> #
>
> #
> # Heart Rate Monitors
> #
> # CONFIG_AFE4403 is not set
> # CONFIG_AFE4404 is not set
> CONFIG_MAX30100=3Dm
> # CONFIG_MAX30102 is not set
>
> #
> # Humidity sensors
> #
> # CONFIG_AM2315 is not set
> # CONFIG_DHT11 is not set
> # CONFIG_HDC100X is not set
> # CONFIG_HID_SENSOR_HUMIDITY is not set
> # CONFIG_HTS221 is not set
> # CONFIG_HTU21 is not set
> # CONFIG_SI7005 is not set
> # CONFIG_SI7020 is not set
>
> #
> # Inertial measurement units
> #
> # CONFIG_ADIS16400 is not set
> # CONFIG_ADIS16480 is not set
> # CONFIG_BMI160_I2C is not set
> # CONFIG_BMI160_SPI is not set
> # CONFIG_KMX61 is not set
> # CONFIG_INV_MPU6050_I2C is not set
> # CONFIG_INV_MPU6050_SPI is not set
> # CONFIG_IIO_ST_LSM6DSX is not set
>
> #
> # Light sensors
> #
> CONFIG_ACPI_ALS=3Dm
> # CONFIG_ADJD_S311 is not set
> # CONFIG_AL3320A is not set
> # CONFIG_APDS9300 is not set
> # CONFIG_APDS9960 is not set
> CONFIG_BH1750=3Dm
> CONFIG_BH1780=3Dm
> # CONFIG_CM32181 is not set
> # CONFIG_CM3232 is not set
> # CONFIG_CM3323 is not set
> # CONFIG_CM36651 is not set
> # CONFIG_GP2AP020A00F is not set
> # CONFIG_SENSORS_ISL29018 is not set
> # CONFIG_ISL29125 is not set
> CONFIG_HID_SENSOR_ALS=3Dm
> # CONFIG_HID_SENSOR_PROX is not set
> # CONFIG_JSA1212 is not set
> CONFIG_RPR0521=3Dm
> # CONFIG_SENSORS_LM3533 is not set
> # CONFIG_LTR501 is not set
> # CONFIG_MAX44000 is not set
> CONFIG_OPT3001=3Dm
> CONFIG_PA12203001=3Dm
> # CONFIG_SI1145 is not set
> CONFIG_STK3310=3Dm
> # CONFIG_TCS3414 is not set
> # CONFIG_TCS3472 is not set
> # CONFIG_SENSORS_TSL2563 is not set
> # CONFIG_TSL2583 is not set
> # CONFIG_TSL4531 is not set
> # CONFIG_US5182D is not set
> # CONFIG_VCNL4000 is not set
> # CONFIG_VEML6070 is not set
> # CONFIG_VL6180 is not set
>
> #
> # Magnetometer sensors
> #
> # CONFIG_AK8975 is not set
> # CONFIG_AK09911 is not set
> # CONFIG_BMC150_MAGN_I2C is not set
> # CONFIG_BMC150_MAGN_SPI is not set
> # CONFIG_MAG3110 is not set
> CONFIG_HID_SENSOR_MAGNETOMETER_3D=3Dm
> # CONFIG_MMC35240 is not set
> CONFIG_IIO_ST_MAGN_3AXIS=3Dm
> CONFIG_IIO_ST_MAGN_I2C_3AXIS=3Dm
> CONFIG_IIO_ST_MAGN_SPI_3AXIS=3Dm
> CONFIG_SENSORS_HMC5843=3Dm
> CONFIG_SENSORS_HMC5843_I2C=3Dm
> CONFIG_SENSORS_HMC5843_SPI=3Dm
>
> #
> # Inclinometer sensors
> #
> CONFIG_HID_SENSOR_INCLINOMETER_3D=3Dm
> CONFIG_HID_SENSOR_DEVICE_ROTATION=3Dm
>
> #
> # Triggers - standalone
> #
> # CONFIG_IIO_HRTIMER_TRIGGER is not set
> CONFIG_IIO_INTERRUPT_TRIGGER=3Dm
> CONFIG_IIO_TIGHTLOOP_TRIGGER=3Dm
> # CONFIG_IIO_SYSFS_TRIGGER is not set
>
> #
> # Digital potentiometers
> #
> # CONFIG_DS1803 is not set
> # CONFIG_MAX5481 is not set
> # CONFIG_MAX5487 is not set
> # CONFIG_MCP4131 is not set
> # CONFIG_MCP4531 is not set
> # CONFIG_TPL0102 is not set
>
> #
> # Digital potentiostats
> #
> # CONFIG_LMP91000 is not set
>
> #
> # Pressure sensors
> #
> # CONFIG_ABP060MG is not set
> # CONFIG_BMP280 is not set
> # CONFIG_HID_SENSOR_PRESS is not set
> # CONFIG_HP03 is not set
> # CONFIG_MPL115_I2C is not set
> # CONFIG_MPL115_SPI is not set
> # CONFIG_MPL3115 is not set
> # CONFIG_MS5611 is not set
> # CONFIG_MS5637 is not set
> # CONFIG_IIO_ST_PRESS is not set
> # CONFIG_T5403 is not set
> # CONFIG_HP206C is not set
> # CONFIG_ZPA2326 is not set
>
> #
> # Lightning sensors
> #
> # CONFIG_AS3935 is not set
>
> #
> # Proximity and distance sensors
> #
> # CONFIG_LIDAR_LITE_V2 is not set
> # CONFIG_SRF04 is not set
> # CONFIG_SX9500 is not set
> # CONFIG_SRF08 is not set
>
> #
> # Temperature sensors
> #
> # CONFIG_MAXIM_THERMOCOUPLE is not set
> # CONFIG_HID_SENSOR_TEMP is not set
> # CONFIG_MLX90614 is not set
> # CONFIG_TMP006 is not set
> # CONFIG_TMP007 is not set
> # CONFIG_TSYS01 is not set
> # CONFIG_TSYS02D is not set
> # CONFIG_NTB is not set
> # CONFIG_VME_BUS is not set
> # CONFIG_PWM is not set
> CONFIG_ARM_GIC_MAX_NR=3D1
> CONFIG_IPACK_BUS=3Dm
> CONFIG_BOARD_TPCI200=3Dm
> CONFIG_SERIAL_IPOCTAL=3Dm
> CONFIG_RESET_CONTROLLER=3Dy
> # CONFIG_RESET_ATH79 is not set
> # CONFIG_RESET_BERLIN is not set
> # CONFIG_RESET_IMX7 is not set
> # CONFIG_RESET_LPC18XX is not set
> # CONFIG_RESET_MESON is not set
> # CONFIG_RESET_PISTACHIO is not set
> # CONFIG_RESET_SOCFPGA is not set
> # CONFIG_RESET_STM32 is not set
> # CONFIG_RESET_SUNXI is not set
> # CONFIG_TI_SYSCON_RESET is not set
> # CONFIG_RESET_ZYNQ is not set
> # CONFIG_RESET_TEGRA_BPMP is not set
> CONFIG_FMC=3Dm
> CONFIG_FMC_FAKEDEV=3Dm
> CONFIG_FMC_TRIVIAL=3Dm
> CONFIG_FMC_WRITE_EEPROM=3Dm
> CONFIG_FMC_CHARDEV=3Dm
>
> #
> # PHY Subsystem
> #
> CONFIG_GENERIC_PHY=3Dy
> # CONFIG_PHY_PXA_28NM_HSIC is not set
> # CONFIG_PHY_PXA_28NM_USB2 is not set
> CONFIG_BCM_KONA_USB2_PHY=3Dm
> CONFIG_POWERCAP=3Dy
> CONFIG_INTEL_RAPL=3Dm
> # CONFIG_MCB is not set
>
> #
> # Performance monitor support
> #
> CONFIG_RAS=3Dy
> # CONFIG_MCE_AMD_INJ is not set
> # CONFIG_RAS_CEC is not set
> CONFIG_THUNDERBOLT=3Dm
>
> #
> # Android
> #
> # CONFIG_ANDROID is not set
> CONFIG_LIBNVDIMM=3Dy
> CONFIG_BLK_DEV_PMEM=3Dm
> CONFIG_ND_BLK=3Dm
> CONFIG_ND_CLAIM=3Dy
> CONFIG_ND_BTT=3Dm
> CONFIG_BTT=3Dy
> CONFIG_ND_PFN=3Dm
> CONFIG_NVDIMM_PFN=3Dy
> CONFIG_NVDIMM_DAX=3Dy
> CONFIG_DAX=3Dm
> CONFIG_DEV_DAX=3Dm
> CONFIG_DEV_DAX_PMEM=3Dm
> CONFIG_NVMEM=3Dm
> CONFIG_STM=3Dm
> # CONFIG_STM_DUMMY is not set
> CONFIG_STM_SOURCE_CONSOLE=3Dm
> CONFIG_STM_SOURCE_HEARTBEAT=3Dm
> # CONFIG_STM_SOURCE_FTRACE is not set
> CONFIG_INTEL_TH=3Dm
> CONFIG_INTEL_TH_PCI=3Dm
> CONFIG_INTEL_TH_GTH=3Dm
> CONFIG_INTEL_TH_STH=3Dm
> CONFIG_INTEL_TH_MSU=3Dm
> CONFIG_INTEL_TH_PTI=3Dm
> # CONFIG_INTEL_TH_DEBUG is not set
>
> #
> # FPGA Configuration Support
> #
> # CONFIG_FPGA is not set
>
> #
> # FSI support
> #
> # CONFIG_FSI is not set
> # CONFIG_TEE is not set
>
> #
> # Firmware Drivers
> #
> CONFIG_EDD=3Dm
> # CONFIG_EDD_OFF is not set
> CONFIG_FIRMWARE_MEMMAP=3Dy
> CONFIG_DELL_RBU=3Dm
> CONFIG_DCDBAS=3Dm
> CONFIG_DMIID=3Dy
> CONFIG_DMI_SYSFS=3Dm
> CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=3Dy
> CONFIG_ISCSI_IBFT_FIND=3Dy
> CONFIG_ISCSI_IBFT=3Dm
> CONFIG_FW_CFG_SYSFS=3Dm
> # CONFIG_FW_CFG_SYSFS_CMDLINE is not set
> # CONFIG_GOOGLE_FIRMWARE is not set
>
> #
> # EFI (Extensible Firmware Interface) Support
> #
> # CONFIG_EFI_VARS is not set
> CONFIG_EFI_ESRT=3Dy
> CONFIG_EFI_RUNTIME_MAP=3Dy
> # CONFIG_EFI_FAKE_MEMMAP is not set
> CONFIG_EFI_RUNTIME_WRAPPERS=3Dy
> CONFIG_EFI_CAPSULE_LOADER=3Dm
> # CONFIG_EFI_TEST is not set
> CONFIG_APPLE_PROPERTIES=3Dy
> CONFIG_UEFI_CPER=3Dy
> CONFIG_EFI_DEV_PATH_PARSER=3Dy
>
> #
> # Tegra firmware driver
> #
>
> #
> # File systems
> #
> CONFIG_DCACHE_WORD_ACCESS=3Dy
> CONFIG_ZFS=3Dy
> CONFIG_FS_IOMAP=3Dy
> # CONFIG_EXT2_FS is not set
> # CONFIG_EXT3_FS is not set
> CONFIG_EXT4_FS=3Dm
> CONFIG_EXT4_USE_FOR_EXT2=3Dy
> CONFIG_EXT4_FS_POSIX_ACL=3Dy
> CONFIG_EXT4_FS_SECURITY=3Dy
> CONFIG_EXT4_ENCRYPTION=3Dy
> CONFIG_EXT4_FS_ENCRYPTION=3Dy
> # CONFIG_EXT4_DEBUG is not set
> CONFIG_JBD2=3Dm
> # CONFIG_JBD2_DEBUG is not set
> CONFIG_FS_MBCACHE=3Dm
> CONFIG_REISERFS_FS=3Dm
> # CONFIG_REISERFS_CHECK is not set
> CONFIG_REISERFS_PROC_INFO=3Dy
> CONFIG_REISERFS_FS_XATTR=3Dy
> CONFIG_REISERFS_FS_POSIX_ACL=3Dy
> CONFIG_REISERFS_FS_SECURITY=3Dy
> CONFIG_JFS_FS=3Dm
> CONFIG_JFS_POSIX_ACL=3Dy
> CONFIG_JFS_SECURITY=3Dy
> # CONFIG_JFS_DEBUG is not set
> CONFIG_JFS_STATISTICS=3Dy
> CONFIG_XFS_FS=3Dm
> CONFIG_XFS_QUOTA=3Dy
> CONFIG_XFS_POSIX_ACL=3Dy
> CONFIG_XFS_RT=3Dy
> # CONFIG_XFS_WARN is not set
> # CONFIG_XFS_DEBUG is not set
> CONFIG_GFS2_FS=3Dm
> CONFIG_GFS2_FS_LOCKING_DLM=3Dy
> CONFIG_OCFS2_FS=3Dm
> CONFIG_OCFS2_FS_O2CB=3Dm
> CONFIG_OCFS2_FS_USERSPACE_CLUSTER=3Dm
> CONFIG_OCFS2_FS_STATS=3Dy
> # CONFIG_OCFS2_DEBUG_MASKLOG is not set
> # CONFIG_OCFS2_DEBUG_FS is not set
> CONFIG_BTRFS_FS=3Dm
> CONFIG_BTRFS_FS_POSIX_ACL=3Dy
> # CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
> # CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
> # CONFIG_BTRFS_DEBUG is not set
> # CONFIG_BTRFS_ASSERT is not set
> CONFIG_NILFS2_FS=3Dm
> CONFIG_F2FS_FS=3Dm
> CONFIG_F2FS_STAT_FS=3Dy
> CONFIG_F2FS_FS_XATTR=3Dy
> CONFIG_F2FS_FS_POSIX_ACL=3Dy
> CONFIG_F2FS_FS_SECURITY=3Dy
> CONFIG_F2FS_CHECK_FS=3Dy
> CONFIG_F2FS_FS_ENCRYPTION=3Dy
> # CONFIG_F2FS_IO_TRACE is not set
> # CONFIG_F2FS_FAULT_INJECTION is not set
> # CONFIG_FS_DAX is not set
> CONFIG_FS_POSIX_ACL=3Dy
> CONFIG_EXPORTFS=3Dy
> CONFIG_EXPORTFS_BLOCK_OPS=3Dy
> CONFIG_FILE_LOCKING=3Dy
> # CONFIG_MANDATORY_FILE_LOCKING is not set
> CONFIG_FS_ENCRYPTION=3Dm
> CONFIG_FSNOTIFY=3Dy
> CONFIG_DNOTIFY=3Dy
> CONFIG_INOTIFY_USER=3Dy
> CONFIG_FANOTIFY=3Dy
> CONFIG_FANOTIFY_ACCESS_PERMISSIONS=3Dy
> CONFIG_QUOTA=3Dy
> CONFIG_QUOTA_NETLINK_INTERFACE=3Dy
> # CONFIG_PRINT_QUOTA_WARNING is not set
> # CONFIG_QUOTA_DEBUG is not set
> CONFIG_QUOTA_TREE=3Dm
> CONFIG_QFMT_V1=3Dm
> CONFIG_QFMT_V2=3Dm
> CONFIG_QUOTACTL=3Dy
> CONFIG_QUOTACTL_COMPAT=3Dy
> CONFIG_AUTOFS4_FS=3Dy
> CONFIG_FUSE_FS=3Dm
> CONFIG_CUSE=3Dm
> CONFIG_OVERLAY_FS=3Dm
> # CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
>
> #
> # Caches
> #
> CONFIG_FSCACHE=3Dm
> CONFIG_FSCACHE_STATS=3Dy
> CONFIG_FSCACHE_HISTOGRAM=3Dy
> # CONFIG_FSCACHE_DEBUG is not set
> # CONFIG_FSCACHE_OBJECT_LIST is not set
> CONFIG_CACHEFILES=3Dm
> # CONFIG_CACHEFILES_DEBUG is not set
> # CONFIG_CACHEFILES_HISTOGRAM is not set
>
> #
> # CD-ROM/DVD Filesystems
> #
> CONFIG_ISO9660_FS=3Dm
> CONFIG_JOLIET=3Dy
> CONFIG_ZISOFS=3Dy
> CONFIG_UDF_FS=3Dm
> CONFIG_UDF_NLS=3Dy
>
> #
> # DOS/FAT/NT Filesystems
> #
> CONFIG_FAT_FS=3Dm
> CONFIG_MSDOS_FS=3Dm
> CONFIG_VFAT_FS=3Dm
> CONFIG_FAT_DEFAULT_CODEPAGE=3D437
> CONFIG_FAT_DEFAULT_IOCHARSET=3D"iso8859-1"
> # CONFIG_FAT_DEFAULT_UTF8 is not set
> CONFIG_NTFS_FS=3Dm
> # CONFIG_NTFS_DEBUG is not set
> CONFIG_NTFS_RW=3Dy
>
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=3Dy
> CONFIG_PROC_KCORE=3Dy
> CONFIG_PROC_VMCORE=3Dy
> CONFIG_PROC_SYSCTL=3Dy
> CONFIG_PROC_PAGE_MONITOR=3Dy
> CONFIG_PROC_CHILDREN=3Dy
> CONFIG_KERNFS=3Dy
> CONFIG_SYSFS=3Dy
> CONFIG_TMPFS=3Dy
> CONFIG_TMPFS_POSIX_ACL=3Dy
> CONFIG_TMPFS_XATTR=3Dy
> CONFIG_HUGETLBFS=3Dy
> CONFIG_HUGETLB_PAGE=3Dy
> CONFIG_ARCH_HAS_GIGANTIC_PAGE=3Dy
> CONFIG_CONFIGFS_FS=3Dy
> CONFIG_EFIVAR_FS=3Dy
> CONFIG_MISC_FILESYSTEMS=3Dy
> CONFIG_ORANGEFS_FS=3Dm
> # CONFIG_ADFS_FS is not set
> CONFIG_AFFS_FS=3Dm
> CONFIG_ECRYPT_FS=3Dm
> # CONFIG_ECRYPT_FS_MESSAGING is not set
> CONFIG_HFS_FS=3Dm
> CONFIG_HFSPLUS_FS=3Dm
> CONFIG_HFSPLUS_FS_POSIX_ACL=3Dy
> CONFIG_BEFS_FS=3Dm
> # CONFIG_BEFS_DEBUG is not set
> # CONFIG_BFS_FS is not set
> # CONFIG_EFS_FS is not set
> CONFIG_JFFS2_FS=3Dm
> CONFIG_JFFS2_FS_DEBUG=3D0
> CONFIG_JFFS2_FS_WRITEBUFFER=3Dy
> # CONFIG_JFFS2_FS_WBUF_VERIFY is not set
> # CONFIG_JFFS2_SUMMARY is not set
> # CONFIG_JFFS2_FS_XATTR is not set
> # CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
> CONFIG_JFFS2_ZLIB=3Dy
> # CONFIG_JFFS2_LZO is not set
> CONFIG_JFFS2_RTIME=3Dy
> # CONFIG_JFFS2_RUBIN is not set
> CONFIG_UBIFS_FS=3Dm
> # CONFIG_UBIFS_FS_ADVANCED_COMPR is not set
> CONFIG_UBIFS_FS_LZO=3Dy
> CONFIG_UBIFS_FS_ZLIB=3Dy
> CONFIG_UBIFS_ATIME_SUPPORT=3Dy
> # CONFIG_UBIFS_FS_ENCRYPTION is not set
> CONFIG_UBIFS_FS_SECURITY=3Dy
> CONFIG_CRAMFS=3Dm
> CONFIG_SQUASHFS=3Dm
> # CONFIG_SQUASHFS_FILE_CACHE is not set
> CONFIG_SQUASHFS_FILE_DIRECT=3Dy
> # CONFIG_SQUASHFS_DECOMP_SINGLE is not set
> # CONFIG_SQUASHFS_DECOMP_MULTI is not set
> CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=3Dy
> CONFIG_SQUASHFS_XATTR=3Dy
> CONFIG_SQUASHFS_ZLIB=3Dy
> CONFIG_SQUASHFS_LZ4=3Dy
> CONFIG_SQUASHFS_LZO=3Dy
> CONFIG_SQUASHFS_XZ=3Dy
> # CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
> # CONFIG_SQUASHFS_EMBEDDED is not set
> CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3D3
> # CONFIG_VXFS_FS is not set
> CONFIG_MINIX_FS=3Dm
> CONFIG_OMFS_FS=3Dm
> # CONFIG_HPFS_FS is not set
> # CONFIG_QNX4FS_FS is not set
> # CONFIG_QNX6FS_FS is not set
> CONFIG_ROMFS_FS=3Dm
> CONFIG_ROMFS_BACKED_BY_BLOCK=3Dy
> # CONFIG_ROMFS_BACKED_BY_MTD is not set
> # CONFIG_ROMFS_BACKED_BY_BOTH is not set
> CONFIG_ROMFS_ON_BLOCK=3Dy
> CONFIG_PSTORE=3Dy
> CONFIG_PSTORE_ZLIB_COMPRESS=3Dy
> # CONFIG_PSTORE_LZO_COMPRESS is not set
> # CONFIG_PSTORE_LZ4_COMPRESS is not set
> # CONFIG_PSTORE_CONSOLE is not set
> # CONFIG_PSTORE_PMSG is not set
> # CONFIG_PSTORE_FTRACE is not set
> CONFIG_PSTORE_RAM=3Dy
> # CONFIG_SYSV_FS is not set
> CONFIG_UFS_FS=3Dm
> # CONFIG_UFS_FS_WRITE is not set
> # CONFIG_UFS_DEBUG is not set
> CONFIG_EXOFS_FS=3Dm
> # CONFIG_EXOFS_DEBUG is not set
> CONFIG_ORE=3Dm
> CONFIG_NETWORK_FILESYSTEMS=3Dy
> CONFIG_NFS_FS=3Dm
> CONFIG_NFS_V2=3Dm
> CONFIG_NFS_V3=3Dm
> CONFIG_NFS_V3_ACL=3Dy
> CONFIG_NFS_V4=3Dm
> CONFIG_NFS_SWAP=3Dy
> CONFIG_NFS_V4_1=3Dy
> CONFIG_NFS_V4_2=3Dy
> CONFIG_PNFS_FILE_LAYOUT=3Dm
> CONFIG_PNFS_BLOCK=3Dm
> CONFIG_PNFS_FLEXFILE_LAYOUT=3Dm
> CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN=3D"kernel.org"
> CONFIG_NFS_V4_1_MIGRATION=3Dy
> CONFIG_NFS_V4_SECURITY_LABEL=3Dy
> CONFIG_NFS_FSCACHE=3Dy
> # CONFIG_NFS_USE_LEGACY_DNS is not set
> CONFIG_NFS_USE_KERNEL_DNS=3Dy
> CONFIG_NFS_DEBUG=3Dy
> CONFIG_NFSD=3Dm
> CONFIG_NFSD_V2_ACL=3Dy
> CONFIG_NFSD_V3=3Dy
> CONFIG_NFSD_V3_ACL=3Dy
> CONFIG_NFSD_V4=3Dy
> CONFIG_NFSD_PNFS=3Dy
> CONFIG_NFSD_BLOCKLAYOUT=3Dy
> CONFIG_NFSD_SCSILAYOUT=3Dy
> # CONFIG_NFSD_FLEXFILELAYOUT is not set
> CONFIG_NFSD_V4_SECURITY_LABEL=3Dy
> # CONFIG_NFSD_FAULT_INJECTION is not set
> CONFIG_GRACE_PERIOD=3Dm
> CONFIG_LOCKD=3Dm
> CONFIG_LOCKD_V4=3Dy
> CONFIG_NFS_ACL_SUPPORT=3Dm
> CONFIG_NFS_COMMON=3Dy
> CONFIG_SUNRPC=3Dm
> CONFIG_SUNRPC_GSS=3Dm
> CONFIG_SUNRPC_BACKCHANNEL=3Dy
> CONFIG_SUNRPC_SWAP=3Dy
> CONFIG_RPCSEC_GSS_KRB5=3Dm
> CONFIG_SUNRPC_DEBUG=3Dy
> CONFIG_SUNRPC_XPRT_RDMA=3Dm
> CONFIG_CEPH_FS=3Dm
> CONFIG_CEPH_FSCACHE=3Dy
> CONFIG_CEPH_FS_POSIX_ACL=3Dy
> CONFIG_CIFS=3Dm
> CONFIG_CIFS_STATS=3Dy
> # CONFIG_CIFS_STATS2 is not set
> # CONFIG_CIFS_WEAK_PW_HASH is not set
> CONFIG_CIFS_UPCALL=3Dy
> CONFIG_CIFS_XATTR=3Dy
> CONFIG_CIFS_POSIX=3Dy
> CONFIG_CIFS_ACL=3Dy
> # CONFIG_CIFS_DEBUG is not set
> CONFIG_CIFS_DFS_UPCALL=3Dy
> CONFIG_CIFS_SMB2=3Dy
> CONFIG_CIFS_SMB311=3Dy
> CONFIG_CIFS_FSCACHE=3Dy
> # CONFIG_NCP_FS is not set
> CONFIG_CODA_FS=3Dm
> CONFIG_AFS_FS=3Dm
> # CONFIG_AFS_DEBUG is not set
> CONFIG_AFS_FSCACHE=3Dy
> CONFIG_9P_FS=3Dm
> CONFIG_9P_FSCACHE=3Dy
> CONFIG_9P_FS_POSIX_ACL=3Dy
> CONFIG_9P_FS_SECURITY=3Dy
> CONFIG_NLS=3Dy
> CONFIG_NLS_DEFAULT=3D"utf8"
> CONFIG_NLS_CODEPAGE_437=3Dm
> CONFIG_NLS_CODEPAGE_737=3Dm
> CONFIG_NLS_CODEPAGE_775=3Dm
> CONFIG_NLS_CODEPAGE_850=3Dm
> CONFIG_NLS_CODEPAGE_852=3Dm
> CONFIG_NLS_CODEPAGE_855=3Dm
> CONFIG_NLS_CODEPAGE_857=3Dm
> CONFIG_NLS_CODEPAGE_860=3Dm
> CONFIG_NLS_CODEPAGE_861=3Dm
> CONFIG_NLS_CODEPAGE_862=3Dm
> CONFIG_NLS_CODEPAGE_863=3Dm
> CONFIG_NLS_CODEPAGE_864=3Dm
> CONFIG_NLS_CODEPAGE_865=3Dm
> CONFIG_NLS_CODEPAGE_866=3Dm
> CONFIG_NLS_CODEPAGE_869=3Dm
> CONFIG_NLS_CODEPAGE_936=3Dm
> CONFIG_NLS_CODEPAGE_950=3Dm
> CONFIG_NLS_CODEPAGE_932=3Dm
> CONFIG_NLS_CODEPAGE_949=3Dm
> CONFIG_NLS_CODEPAGE_874=3Dm
> CONFIG_NLS_ISO8859_8=3Dm
> CONFIG_NLS_CODEPAGE_1250=3Dm
> CONFIG_NLS_CODEPAGE_1251=3Dm
> CONFIG_NLS_ASCII=3Dm
> CONFIG_NLS_ISO8859_1=3Dm
> CONFIG_NLS_ISO8859_2=3Dm
> CONFIG_NLS_ISO8859_3=3Dm
> CONFIG_NLS_ISO8859_4=3Dm
> CONFIG_NLS_ISO8859_5=3Dm
> CONFIG_NLS_ISO8859_6=3Dm
> CONFIG_NLS_ISO8859_7=3Dm
> CONFIG_NLS_ISO8859_9=3Dm
> CONFIG_NLS_ISO8859_13=3Dm
> CONFIG_NLS_ISO8859_14=3Dm
> CONFIG_NLS_ISO8859_15=3Dm
> CONFIG_NLS_KOI8_R=3Dm
> CONFIG_NLS_KOI8_U=3Dm
> CONFIG_NLS_MAC_ROMAN=3Dm
> CONFIG_NLS_MAC_CELTIC=3Dm
> CONFIG_NLS_MAC_CENTEURO=3Dm
> CONFIG_NLS_MAC_CROATIAN=3Dm
> CONFIG_NLS_MAC_CYRILLIC=3Dm
> CONFIG_NLS_MAC_GAELIC=3Dm
> CONFIG_NLS_MAC_GREEK=3Dm
> CONFIG_NLS_MAC_ICELAND=3Dm
> CONFIG_NLS_MAC_INUIT=3Dm
> CONFIG_NLS_MAC_ROMANIAN=3Dm
> CONFIG_NLS_MAC_TURKISH=3Dm
> CONFIG_NLS_UTF8=3Dm
> CONFIG_DLM=3Dm
> # CONFIG_DLM_DEBUG is not set
>
> #
> # Kernel hacking
> #
> CONFIG_TRACE_IRQFLAGS_SUPPORT=3Dy
>
> #
> # printk and dmesg options
> #
> CONFIG_PRINTK_TIME=3Dy
> CONFIG_CONSOLE_LOGLEVEL_DEFAULT=3D7
> CONFIG_MESSAGE_LOGLEVEL_DEFAULT=3D4
> # CONFIG_BOOT_PRINTK_DELAY is not set
> CONFIG_DYNAMIC_DEBUG=3Dy
>
> #
> # Compile-time checks and compiler options
> #
> # CONFIG_DEBUG_INFO is not set
> # CONFIG_ENABLE_WARN_DEPRECATED is not set
> # CONFIG_ENABLE_MUST_CHECK is not set
> CONFIG_FRAME_WARN=3D2048
> CONFIG_STRIP_ASM_SYMS=3Dy
> # CONFIG_READABLE_ASM is not set
> CONFIG_UNUSED_SYMBOLS=3Dy
> # CONFIG_PAGE_OWNER is not set
> CONFIG_DEBUG_FS=3Dy
> # CONFIG_HEADERS_CHECK is not set
> # CONFIG_DEBUG_SECTION_MISMATCH is not set
> CONFIG_SECTION_MISMATCH_WARN_ONLY=3Dy
> CONFIG_ARCH_WANT_FRAME_POINTERS=3Dy
> CONFIG_FRAME_POINTER=3Dy
> CONFIG_STACK_VALIDATION=3Dy
> # CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
> CONFIG_MAGIC_SYSRQ=3Dy
> CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=3D0x0
> CONFIG_MAGIC_SYSRQ_SERIAL=3Dy
> CONFIG_DEBUG_KERNEL=3Dy
>
> #
> # Memory Debugging
> #
> # CONFIG_PAGE_EXTENSION is not set
> # CONFIG_DEBUG_PAGEALLOC is not set
> # CONFIG_PAGE_POISONING is not set
> # CONFIG_DEBUG_PAGE_REF is not set
> # CONFIG_DEBUG_RODATA_TEST is not set
> # CONFIG_DEBUG_OBJECTS is not set
> # CONFIG_SLUB_DEBUG_ON is not set
> # CONFIG_SLUB_STATS is not set
> CONFIG_HAVE_DEBUG_KMEMLEAK=3Dy
> # CONFIG_DEBUG_KMEMLEAK is not set
> # CONFIG_DEBUG_STACK_USAGE is not set
> # CONFIG_DEBUG_VM is not set
> CONFIG_ARCH_HAS_DEBUG_VIRTUAL=3Dy
> # CONFIG_DEBUG_VIRTUAL is not set
> CONFIG_DEBUG_MEMORY_INIT=3Dy
> # CONFIG_DEBUG_PER_CPU_MAPS is not set
> CONFIG_HAVE_DEBUG_STACKOVERFLOW=3Dy
> # CONFIG_DEBUG_STACKOVERFLOW is not set
> CONFIG_HAVE_ARCH_KMEMCHECK=3Dy
> CONFIG_HAVE_ARCH_KASAN=3Dy
> # CONFIG_KASAN is not set
> CONFIG_ARCH_HAS_KCOV=3Dy
> # CONFIG_KCOV is not set
> # CONFIG_DEBUG_SHIRQ is not set
>
> #
> # Debug Lockups and Hangs
> #
> CONFIG_LOCKUP_DETECTOR=3Dy
> CONFIG_HARDLOCKUP_DETECTOR=3Dy
> # CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set
> CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=3D0
> # CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
> CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=3D0
> CONFIG_DETECT_HUNG_TASK=3Dy
> CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=3D120
> # CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
> CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=3D0
> # CONFIG_WQ_WATCHDOG is not set
> # CONFIG_PANIC_ON_OOPS is not set
> CONFIG_PANIC_ON_OOPS_VALUE=3D0
> CONFIG_PANIC_TIMEOUT=3D0
> CONFIG_SCHED_DEBUG=3Dy
> CONFIG_SCHED_INFO=3Dy
> CONFIG_SCHEDSTATS=3Dy
> # CONFIG_SCHED_STACK_END_CHECK is not set
> # CONFIG_DEBUG_TIMEKEEPING is not set
> # CONFIG_DEBUG_PREEMPT is not set
>
> #
> # Lock Debugging (spinlocks, mutexes, etc...)
> #
> # CONFIG_DEBUG_RT_MUTEXES is not set
> # CONFIG_DEBUG_SPINLOCK is not set
> # CONFIG_DEBUG_MUTEXES is not set
> # CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
> # CONFIG_DEBUG_LOCK_ALLOC is not set
> # CONFIG_PROVE_LOCKING is not set
> # CONFIG_LOCK_STAT is not set
> # CONFIG_DEBUG_ATOMIC_SLEEP is not set
> # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
> # CONFIG_LOCK_TORTURE_TEST is not set
> # CONFIG_WW_MUTEX_SELFTEST is not set
> CONFIG_STACKTRACE=3Dy
> # CONFIG_DEBUG_KOBJECT is not set
> CONFIG_DEBUG_BUGVERBOSE=3Dy
> # CONFIG_DEBUG_LIST is not set
> # CONFIG_DEBUG_PI_LIST is not set
> # CONFIG_DEBUG_SG is not set
> # CONFIG_DEBUG_NOTIFIERS is not set
> # CONFIG_DEBUG_CREDENTIALS is not set
>
> #
> # RCU Debugging
> #
> # CONFIG_PROVE_RCU is not set
> # CONFIG_SPARSE_RCU_POINTER is not set
> # CONFIG_TORTURE_TEST is not set
> # CONFIG_RCU_PERF_TEST is not set
> # CONFIG_RCU_TORTURE_TEST is not set
> CONFIG_RCU_CPU_STALL_TIMEOUT=3D60
> # CONFIG_RCU_TRACE is not set
> # CONFIG_RCU_EQS_DEBUG is not set
> # CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
> # CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
> # CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
> # CONFIG_NOTIFIER_ERROR_INJECTION is not set
> # CONFIG_FAULT_INJECTION is not set
> # CONFIG_LATENCYTOP is not set
> CONFIG_USER_STACKTRACE_SUPPORT=3Dy
> CONFIG_NOP_TRACER=3Dy
> CONFIG_HAVE_FUNCTION_TRACER=3Dy
> CONFIG_HAVE_FUNCTION_GRAPH_TRACER=3Dy
> CONFIG_HAVE_DYNAMIC_FTRACE=3Dy
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=3Dy
> CONFIG_HAVE_FTRACE_MCOUNT_RECORD=3Dy
> CONFIG_HAVE_SYSCALL_TRACEPOINTS=3Dy
> CONFIG_HAVE_FENTRY=3Dy
> CONFIG_HAVE_C_RECORDMCOUNT=3Dy
> CONFIG_TRACER_MAX_TRACE=3Dy
> CONFIG_TRACE_CLOCK=3Dy
> CONFIG_RING_BUFFER=3Dy
> CONFIG_EVENT_TRACING=3Dy
> CONFIG_CONTEXT_SWITCH_TRACER=3Dy
> CONFIG_RING_BUFFER_ALLOW_SWAP=3Dy
> CONFIG_TRACING=3Dy
> CONFIG_GENERIC_TRACER=3Dy
> CONFIG_TRACING_SUPPORT=3Dy
> CONFIG_FTRACE=3Dy
> CONFIG_FUNCTION_TRACER=3Dy
> CONFIG_FUNCTION_GRAPH_TRACER=3Dy
> # CONFIG_IRQSOFF_TRACER is not set
> # CONFIG_PREEMPT_TRACER is not set
> CONFIG_SCHED_TRACER=3Dy
> CONFIG_HWLAT_TRACER=3Dy
> CONFIG_FTRACE_SYSCALLS=3Dy
> CONFIG_TRACER_SNAPSHOT=3Dy
> # CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
> CONFIG_BRANCH_PROFILE_NONE=3Dy
> # CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
> # CONFIG_PROFILE_ALL_BRANCHES is not set
> CONFIG_STACK_TRACER=3Dy
> CONFIG_BLK_DEV_IO_TRACE=3Dy
> CONFIG_KPROBE_EVENTS=3Dy
> CONFIG_UPROBE_EVENTS=3Dy
> CONFIG_BPF_EVENTS=3Dy
> CONFIG_PROBE_EVENTS=3Dy
> CONFIG_DYNAMIC_FTRACE=3Dy
> CONFIG_DYNAMIC_FTRACE_WITH_REGS=3Dy
> CONFIG_FUNCTION_PROFILER=3Dy
> CONFIG_FTRACE_MCOUNT_RECORD=3Dy
> # CONFIG_FTRACE_STARTUP_TEST is not set
> CONFIG_MMIOTRACE=3Dy
> # CONFIG_HIST_TRIGGERS is not set
> # CONFIG_MMIOTRACE_TEST is not set
> # CONFIG_TRACEPOINT_BENCHMARK is not set
> CONFIG_RING_BUFFER_BENCHMARK=3Dm
> # CONFIG_RING_BUFFER_STARTUP_TEST is not set
> # CONFIG_TRACE_ENUM_MAP_FILE is not set
> # CONFIG_TRACING_EVENTS_GPIO is not set
>
> #
> # Runtime Testing
> #
> CONFIG_LKDTM=3Dm
> # CONFIG_TEST_LIST_SORT is not set
> # CONFIG_TEST_SORT is not set
> # CONFIG_KPROBES_SANITY_TEST is not set
> # CONFIG_BACKTRACE_SELF_TEST is not set
> # CONFIG_RBTREE_TEST is not set
> # CONFIG_INTERVAL_TREE_TEST is not set
> CONFIG_PERCPU_TEST=3Dm
> # CONFIG_ATOMIC64_SELFTEST is not set
> CONFIG_ASYNC_RAID6_TEST=3Dm
> # CONFIG_TEST_HEXDUMP is not set
> # CONFIG_TEST_STRING_HELPERS is not set
> CONFIG_TEST_KSTRTOX=3Dm
> # CONFIG_TEST_PRINTF is not set
> # CONFIG_TEST_BITMAP is not set
> # CONFIG_TEST_UUID is not set
> # CONFIG_TEST_RHASHTABLE is not set
> # CONFIG_TEST_HASH is not set
> # CONFIG_TEST_PARMAN is not set
> # CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
> # CONFIG_DMA_API_DEBUG is not set
> # CONFIG_TEST_LKM is not set
> # CONFIG_TEST_USER_COPY is not set
> # CONFIG_TEST_BPF is not set
> # CONFIG_TEST_FIRMWARE is not set
> # CONFIG_TEST_UDELAY is not set
> # CONFIG_MEMTEST is not set
> # CONFIG_TEST_STATIC_KEYS is not set
> # CONFIG_BUG_ON_DATA_CORRUPTION is not set
> # CONFIG_SAMPLES is not set
> CONFIG_HAVE_ARCH_KGDB=3Dy
> # CONFIG_KGDB is not set
> CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=3Dy
> # CONFIG_ARCH_WANTS_UBSAN_NO_NULL is not set
> # CONFIG_UBSAN is not set
> CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=3Dy
> CONFIG_STRICT_DEVMEM=3Dy
> CONFIG_IO_STRICT_DEVMEM=3Dy
> # CONFIG_X86_VERBOSE_BOOTUP is not set
> CONFIG_EARLY_PRINTK=3Dy
> # CONFIG_EARLY_PRINTK_DBGP is not set
> CONFIG_EARLY_PRINTK_EFI=3Dy
> # CONFIG_EARLY_PRINTK_USB_XDBC is not set
> # CONFIG_X86_PTDUMP_CORE is not set
> # CONFIG_X86_PTDUMP is not set
> # CONFIG_EFI_PGT_DUMP is not set
> # CONFIG_DEBUG_WX is not set
> CONFIG_DOUBLEFAULT=3Dy
> # CONFIG_DEBUG_TLBFLUSH is not set
> # CONFIG_IOMMU_DEBUG is not set
> # CONFIG_IOMMU_STRESS is not set
> CONFIG_HAVE_MMIOTRACE_SUPPORT=3Dy
> # CONFIG_X86_DECODER_SELFTEST is not set
> CONFIG_IO_DELAY_TYPE_0X80=3D0
> CONFIG_IO_DELAY_TYPE_0XED=3D1
> CONFIG_IO_DELAY_TYPE_UDELAY=3D2
> CONFIG_IO_DELAY_TYPE_NONE=3D3
> CONFIG_IO_DELAY_0X80=3Dy
> # CONFIG_IO_DELAY_0XED is not set
> # CONFIG_IO_DELAY_UDELAY is not set
> # CONFIG_IO_DELAY_NONE is not set
> CONFIG_DEFAULT_IO_DELAY_TYPE=3D0
> # CONFIG_DEBUG_BOOT_PARAMS is not set
> # CONFIG_CPA_DEBUG is not set
> # CONFIG_OPTIMIZE_INLINING is not set
> # CONFIG_DEBUG_ENTRY is not set
> # CONFIG_DEBUG_NMI_SELFTEST is not set
> # CONFIG_X86_DEBUG_FPU is not set
> # CONFIG_PUNIT_ATOM_DEBUG is not set
>
> #
> # Security options
> #
> CONFIG_KEYS=3Dy
> CONFIG_PERSISTENT_KEYRINGS=3Dy
> CONFIG_TRUSTED_KEYS=3Dm
> CONFIG_ENCRYPTED_KEYS=3Dm
> CONFIG_KEY_DH_OPERATIONS=3Dy
> # CONFIG_SECURITY_DMESG_RESTRICT is not set
> CONFIG_SECURITY=3Dy
> # CONFIG_SECURITY_WRITABLE_HOOKS is not set
> CONFIG_SECURITYFS=3Dy
> # CONFIG_SECURITY_NETWORK is not set
> CONFIG_SECURITY_PATH=3Dy
> # CONFIG_INTEL_TXT is not set
> CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=3Dy
> CONFIG_HARDENED_USERCOPY=3Dy
> # CONFIG_STATIC_USERMODEHELPER is not set
> # CONFIG_SECURITY_SMACK is not set
> # CONFIG_SECURITY_TOMOYO is not set
> # CONFIG_SECURITY_APPARMOR is not set
> # CONFIG_SECURITY_LOADPIN is not set
> CONFIG_SECURITY_YAMA=3Dy
> CONFIG_INTEGRITY=3Dy
> # CONFIG_INTEGRITY_SIGNATURE is not set
> # CONFIG_IMA is not set
> # CONFIG_EVM is not set
> CONFIG_DEFAULT_SECURITY_DAC=3Dy
> CONFIG_DEFAULT_SECURITY=3D""
> CONFIG_XOR_BLOCKS=3Dm
> CONFIG_ASYNC_CORE=3Dm
> CONFIG_ASYNC_MEMCPY=3Dm
> CONFIG_ASYNC_XOR=3Dm
> CONFIG_ASYNC_PQ=3Dm
> CONFIG_ASYNC_RAID6_RECOV=3Dm
> CONFIG_CRYPTO=3Dy
>
> #
> # Crypto core or helper
> #
> CONFIG_CRYPTO_ALGAPI=3Dy
> CONFIG_CRYPTO_ALGAPI2=3Dy
> CONFIG_CRYPTO_AEAD=3Dm
> CONFIG_CRYPTO_AEAD2=3Dy
> CONFIG_CRYPTO_BLKCIPHER=3Dy
> CONFIG_CRYPTO_BLKCIPHER2=3Dy
> CONFIG_CRYPTO_HASH=3Dy
> CONFIG_CRYPTO_HASH2=3Dy
> CONFIG_CRYPTO_RNG=3Dm
> CONFIG_CRYPTO_RNG2=3Dy
> CONFIG_CRYPTO_RNG_DEFAULT=3Dm
> CONFIG_CRYPTO_AKCIPHER2=3Dy
> CONFIG_CRYPTO_AKCIPHER=3Dm
> CONFIG_CRYPTO_KPP2=3Dy
> CONFIG_CRYPTO_KPP=3Dm
> CONFIG_CRYPTO_ACOMP2=3Dy
> CONFIG_CRYPTO_RSA=3Dm
> CONFIG_CRYPTO_DH=3Dm
> CONFIG_CRYPTO_ECDH=3Dm
> CONFIG_CRYPTO_MANAGER=3Dy
> CONFIG_CRYPTO_MANAGER2=3Dy
> CONFIG_CRYPTO_USER=3Dm
> CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=3Dy
> CONFIG_CRYPTO_GF128MUL=3Dm
> CONFIG_CRYPTO_NULL=3Dm
> CONFIG_CRYPTO_NULL2=3Dy
> CONFIG_CRYPTO_PCRYPT=3Dm
> CONFIG_CRYPTO_WORKQUEUE=3Dy
> CONFIG_CRYPTO_CRYPTD=3Dm
> CONFIG_CRYPTO_MCRYPTD=3Dm
> CONFIG_CRYPTO_AUTHENC=3Dm
> CONFIG_CRYPTO_TEST=3Dm
> CONFIG_CRYPTO_ABLK_HELPER=3Dm
> CONFIG_CRYPTO_SIMD=3Dm
> CONFIG_CRYPTO_GLUE_HELPER_X86=3Dm
> CONFIG_CRYPTO_ENGINE=3Dm
>
> #
> # Authenticated Encryption with Associated Data
> #
> CONFIG_CRYPTO_CCM=3Dm
> CONFIG_CRYPTO_GCM=3Dm
> CONFIG_CRYPTO_CHACHA20POLY1305=3Dm
> CONFIG_CRYPTO_SEQIV=3Dm
> CONFIG_CRYPTO_ECHAINIV=3Dm
>
> #
> # Block modes
> #
> CONFIG_CRYPTO_CBC=3Dm
> CONFIG_CRYPTO_CTR=3Dm
> CONFIG_CRYPTO_CTS=3Dm
> CONFIG_CRYPTO_ECB=3Dy
> CONFIG_CRYPTO_LRW=3Dm
> CONFIG_CRYPTO_PCBC=3Dm
> CONFIG_CRYPTO_XTS=3Dm
> CONFIG_CRYPTO_KEYWRAP=3Dm
>
> #
> # Hash modes
> #
> CONFIG_CRYPTO_CMAC=3Dm
> CONFIG_CRYPTO_HMAC=3Dm
> CONFIG_CRYPTO_XCBC=3Dm
> CONFIG_CRYPTO_VMAC=3Dm
>
> #
> # Digest
> #
> CONFIG_CRYPTO_CRC32C=3Dm
> CONFIG_CRYPTO_CRC32C_INTEL=3Dm
> CONFIG_CRYPTO_CRC32=3Dm
> CONFIG_CRYPTO_CRC32_PCLMUL=3Dm
> CONFIG_CRYPTO_CRCT10DIF=3Dy
> CONFIG_CRYPTO_CRCT10DIF_PCLMUL=3Dm
> CONFIG_CRYPTO_GHASH=3Dm
> CONFIG_CRYPTO_POLY1305=3Dm
> CONFIG_CRYPTO_POLY1305_X86_64=3Dm
> CONFIG_CRYPTO_MD4=3Dm
> CONFIG_CRYPTO_MD5=3Dy
> CONFIG_CRYPTO_MICHAEL_MIC=3Dm
> CONFIG_CRYPTO_RMD128=3Dm
> CONFIG_CRYPTO_RMD160=3Dm
> CONFIG_CRYPTO_RMD256=3Dm
> CONFIG_CRYPTO_RMD320=3Dm
> CONFIG_CRYPTO_SHA1=3Dm
> CONFIG_CRYPTO_SHA1_SSSE3=3Dm
> CONFIG_CRYPTO_SHA256_SSSE3=3Dm
> CONFIG_CRYPTO_SHA512_SSSE3=3Dm
> CONFIG_CRYPTO_SHA1_MB=3Dm
> CONFIG_CRYPTO_SHA256_MB=3Dm
> CONFIG_CRYPTO_SHA512_MB=3Dm
> CONFIG_CRYPTO_SHA256=3Dm
> CONFIG_CRYPTO_SHA512=3Dm
> CONFIG_CRYPTO_SHA3=3Dm
> CONFIG_CRYPTO_TGR192=3Dm
> CONFIG_CRYPTO_WP512=3Dm
> CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=3Dm
>
> #
> # Ciphers
> #
> CONFIG_CRYPTO_AES=3Dy
> # CONFIG_CRYPTO_AES_TI is not set
> CONFIG_CRYPTO_AES_X86_64=3Dm
> CONFIG_CRYPTO_AES_NI_INTEL=3Dm
> CONFIG_CRYPTO_ANUBIS=3Dm
> CONFIG_CRYPTO_ARC4=3Dm
> CONFIG_CRYPTO_BLOWFISH=3Dm
> CONFIG_CRYPTO_BLOWFISH_COMMON=3Dm
> CONFIG_CRYPTO_BLOWFISH_X86_64=3Dm
> CONFIG_CRYPTO_CAMELLIA=3Dm
> CONFIG_CRYPTO_CAMELLIA_X86_64=3Dm
> CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=3Dm
> CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=3Dm
> CONFIG_CRYPTO_CAST_COMMON=3Dm
> CONFIG_CRYPTO_CAST5=3Dm
> CONFIG_CRYPTO_CAST5_AVX_X86_64=3Dm
> CONFIG_CRYPTO_CAST6=3Dm
> CONFIG_CRYPTO_CAST6_AVX_X86_64=3Dm
> CONFIG_CRYPTO_DES=3Dm
> CONFIG_CRYPTO_DES3_EDE_X86_64=3Dm
> CONFIG_CRYPTO_FCRYPT=3Dm
> CONFIG_CRYPTO_KHAZAD=3Dm
> CONFIG_CRYPTO_SALSA20=3Dm
> CONFIG_CRYPTO_SALSA20_X86_64=3Dm
> CONFIG_CRYPTO_CHACHA20=3Dm
> CONFIG_CRYPTO_CHACHA20_X86_64=3Dm
> CONFIG_CRYPTO_SEED=3Dm
> CONFIG_CRYPTO_SERPENT=3Dm
> CONFIG_CRYPTO_SERPENT_SSE2_X86_64=3Dm
> CONFIG_CRYPTO_SERPENT_AVX_X86_64=3Dm
> CONFIG_CRYPTO_SERPENT_AVX2_X86_64=3Dm
> CONFIG_CRYPTO_TEA=3Dm
> CONFIG_CRYPTO_TWOFISH=3Dm
> CONFIG_CRYPTO_TWOFISH_COMMON=3Dm
> CONFIG_CRYPTO_TWOFISH_X86_64=3Dm
> CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=3Dm
> CONFIG_CRYPTO_TWOFISH_AVX_X86_64=3Dm
>
> #
> # Compression
> #
> CONFIG_CRYPTO_DEFLATE=3Dm
> CONFIG_CRYPTO_LZO=3Dy
> CONFIG_CRYPTO_842=3Dm
> CONFIG_CRYPTO_LZ4=3Dm
> CONFIG_CRYPTO_LZ4HC=3Dm
>
> #
> # Random Number Generation
> #
> CONFIG_CRYPTO_ANSI_CPRNG=3Dm
> CONFIG_CRYPTO_DRBG_MENU=3Dm
> CONFIG_CRYPTO_DRBG_HMAC=3Dy
> CONFIG_CRYPTO_DRBG_HASH=3Dy
> CONFIG_CRYPTO_DRBG_CTR=3Dy
> CONFIG_CRYPTO_DRBG=3Dm
> CONFIG_CRYPTO_JITTERENTROPY=3Dm
> CONFIG_CRYPTO_USER_API=3Dm
> CONFIG_CRYPTO_USER_API_HASH=3Dm
> CONFIG_CRYPTO_USER_API_SKCIPHER=3Dm
> CONFIG_CRYPTO_USER_API_RNG=3Dm
> CONFIG_CRYPTO_USER_API_AEAD=3Dm
> CONFIG_CRYPTO_HASH_INFO=3Dy
> CONFIG_CRYPTO_HW=3Dy
> CONFIG_CRYPTO_DEV_PADLOCK=3Dm
> CONFIG_CRYPTO_DEV_PADLOCK_AES=3Dm
> CONFIG_CRYPTO_DEV_PADLOCK_SHA=3Dm
> # CONFIG_CRYPTO_DEV_FSL_CAAM_CRYPTO_API_DESC is not set
> CONFIG_CRYPTO_DEV_CCP=3Dy
> CONFIG_CRYPTO_DEV_CCP_DD=3Dm
> CONFIG_CRYPTO_DEV_CCP_CRYPTO=3Dm
> CONFIG_CRYPTO_DEV_QAT=3Dm
> CONFIG_CRYPTO_DEV_QAT_DH895xCC=3Dm
> CONFIG_CRYPTO_DEV_QAT_C3XXX=3Dm
> CONFIG_CRYPTO_DEV_QAT_C62X=3Dm
> CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=3Dm
> CONFIG_CRYPTO_DEV_QAT_C3XXXVF=3Dm
> CONFIG_CRYPTO_DEV_QAT_C62XVF=3Dm
> CONFIG_CRYPTO_DEV_CHELSIO=3Dm
> CONFIG_CRYPTO_DEV_VIRTIO=3Dm
> CONFIG_ASYMMETRIC_KEY_TYPE=3Dy
> CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=3Dm
> CONFIG_X509_CERTIFICATE_PARSER=3Dm
> CONFIG_PKCS7_MESSAGE_PARSER=3Dm
>
> #
> # Certificates for signature checking
> #
> CONFIG_SYSTEM_TRUSTED_KEYRING=3Dy
> CONFIG_SYSTEM_TRUSTED_KEYS=3D""
> # CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
> CONFIG_SECONDARY_TRUSTED_KEYRING=3Dy
> # CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
> CONFIG_HAVE_KVM=3Dy
> CONFIG_HAVE_KVM_IRQCHIP=3Dy
> CONFIG_HAVE_KVM_IRQFD=3Dy
> CONFIG_HAVE_KVM_IRQ_ROUTING=3Dy
> CONFIG_HAVE_KVM_EVENTFD=3Dy
> CONFIG_KVM_MMIO=3Dy
> CONFIG_KVM_ASYNC_PF=3Dy
> CONFIG_HAVE_KVM_MSI=3Dy
> CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=3Dy
> CONFIG_KVM_VFIO=3Dy
> CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=3Dy
> CONFIG_KVM_COMPAT=3Dy
> CONFIG_HAVE_KVM_IRQ_BYPASS=3Dy
> CONFIG_VIRTUALIZATION=3Dy
> CONFIG_KVM=3Dm
> CONFIG_KVM_INTEL=3Dm
> CONFIG_KVM_AMD=3Dm
> CONFIG_KVM_MMU_AUDIT=3Dy
> CONFIG_VHOST_NET=3Dm
> CONFIG_VHOST_SCSI=3Dm
> CONFIG_VHOST_VSOCK=3Dm
> CONFIG_VHOST=3Dm
> # CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set
> CONFIG_BINARY_PRINTF=3Dy
>
> #
> # Library routines
> #
> CONFIG_RAID6_PQ=3Dm
> CONFIG_BITREVERSE=3Dy
> # CONFIG_HAVE_ARCH_BITREVERSE is not set
> CONFIG_RATIONAL=3Dy
> CONFIG_GENERIC_STRNCPY_FROM_USER=3Dy
> CONFIG_GENERIC_STRNLEN_USER=3Dy
> CONFIG_GENERIC_NET_UTILS=3Dy
> CONFIG_GENERIC_FIND_FIRST_BIT=3Dy
> CONFIG_GENERIC_PCI_IOMAP=3Dy
> CONFIG_GENERIC_IOMAP=3Dy
> CONFIG_GENERIC_IO=3Dy
> CONFIG_ARCH_USE_CMPXCHG_LOCKREF=3Dy
> CONFIG_ARCH_HAS_FAST_MULTIPLIER=3Dy
> CONFIG_CRC_CCITT=3Dy
> CONFIG_CRC16=3Dm
> CONFIG_CRC_T10DIF=3Dy
> CONFIG_CRC_ITU_T=3Dm
> CONFIG_CRC32=3Dy
> # CONFIG_CRC32_SELFTEST is not set
> CONFIG_CRC32_SLICEBY8=3Dy
> # CONFIG_CRC32_SLICEBY4 is not set
> # CONFIG_CRC32_SARWATE is not set
> # CONFIG_CRC32_BIT is not set
> CONFIG_CRC7=3Dm
> CONFIG_LIBCRC32C=3Dm
> CONFIG_CRC8=3Dm
> # CONFIG_AUDIT_ARCH_COMPAT_GENERIC is not set
> # CONFIG_RANDOM32_SELFTEST is not set
> CONFIG_842_COMPRESS=3Dm
> CONFIG_842_DECOMPRESS=3Dm
> CONFIG_ZLIB_INFLATE=3Dy
> CONFIG_ZLIB_DEFLATE=3Dy
> CONFIG_LZO_COMPRESS=3Dy
> CONFIG_LZO_DECOMPRESS=3Dy
> CONFIG_LZ4_COMPRESS=3Dm
> CONFIG_LZ4HC_COMPRESS=3Dm
> CONFIG_LZ4_DECOMPRESS=3Dy
> CONFIG_XZ_DEC=3Dy
> CONFIG_XZ_DEC_X86=3Dy
> CONFIG_XZ_DEC_POWERPC=3Dy
> CONFIG_XZ_DEC_IA64=3Dy
> CONFIG_XZ_DEC_ARM=3Dy
> CONFIG_XZ_DEC_ARMTHUMB=3Dy
> CONFIG_XZ_DEC_SPARC=3Dy
> CONFIG_XZ_DEC_BCJ=3Dy
> # CONFIG_XZ_DEC_TEST is not set
> CONFIG_DECOMPRESS_GZIP=3Dy
> CONFIG_DECOMPRESS_BZIP2=3Dy
> CONFIG_DECOMPRESS_LZMA=3Dy
> CONFIG_DECOMPRESS_XZ=3Dy
> CONFIG_DECOMPRESS_LZO=3Dy
> CONFIG_DECOMPRESS_LZ4=3Dy
> CONFIG_GENERIC_ALLOCATOR=3Dy
> CONFIG_REED_SOLOMON=3Dy
> CONFIG_REED_SOLOMON_ENC8=3Dy
> CONFIG_REED_SOLOMON_DEC8=3Dy
> CONFIG_TEXTSEARCH=3Dy
> CONFIG_TEXTSEARCH_KMP=3Dm
> CONFIG_TEXTSEARCH_BM=3Dm
> CONFIG_TEXTSEARCH_FSM=3Dm
> CONFIG_BTREE=3Dy
> CONFIG_INTERVAL_TREE=3Dy
> CONFIG_RADIX_TREE_MULTIORDER=3Dy
> CONFIG_ASSOCIATIVE_ARRAY=3Dy
> CONFIG_HAS_IOMEM=3Dy
> CONFIG_HAS_IOPORT_MAP=3Dy
> CONFIG_HAS_DMA=3Dy
> # CONFIG_DMA_NOOP_OPS is not set
> CONFIG_DMA_VIRT_OPS=3Dy
> CONFIG_CHECK_SIGNATURE=3Dy
> CONFIG_CPU_RMAP=3Dy
> CONFIG_DQL=3Dy
> CONFIG_GLOB=3Dy
> # CONFIG_GLOB_SELFTEST is not set
> CONFIG_NLATTR=3Dy
> CONFIG_LRU_CACHE=3Dm
> CONFIG_CLZ_TAB=3Dy
> CONFIG_CORDIC=3Dm
> CONFIG_DDR=3Dy
> CONFIG_IRQ_POLL=3Dy
> CONFIG_MPILIB=3Dy
> CONFIG_OID_REGISTRY=3Dm
> CONFIG_UCS2_STRING=3Dy
> CONFIG_FONT_SUPPORT=3Dy
> CONFIG_FONTS=3Dy
> # CONFIG_FONT_8x8 is not set
> CONFIG_FONT_8x16=3Dy
> # CONFIG_FONT_6x11 is not set
> # CONFIG_FONT_7x14 is not set
> # CONFIG_FONT_PEARL_8x8 is not set
> # CONFIG_FONT_ACORN_8x8 is not set
> # CONFIG_FONT_MINI_4x6 is not set
> # CONFIG_FONT_6x10 is not set
> # CONFIG_FONT_10x18 is not set
> # CONFIG_FONT_SUN8x16 is not set
> # CONFIG_FONT_SUN12x22 is not set
> CONFIG_FONT_AUTOSELECT=3Dy
> # CONFIG_SG_SPLIT is not set
> CONFIG_SG_POOL=3Dy
> CONFIG_ARCH_HAS_SG_CHAIN=3Dy
> CONFIG_ARCH_HAS_PMEM_API=3Dy
> CONFIG_ARCH_HAS_MMIO_FLUSH=3Dy
> CONFIG_SBITMAP=3Dy
> CONFIG_PARMAN=3Dm
> CONFIG_SPL=3Dy



--3uJBPrtTRFWmpoDNeaEglQ7FvJap5QTdm--

--RjA92gf1Hr1LEJ5suHSGmspAI1djoxbuI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE/gJ8Tpn0OtJz8hxD6+YIa34W/zYFAlkfVzQACgkQ6+YIa34W
/zbVBA//WfCw8x9len+ImKj21MO/DfHmoaJW8stm3elXwMGK34M5xplUdWhVkdD2
sokUDH//X9kISMZZPmRFZCMCA0NgzyKnB1gXmLoiRl0RxuSF9ZkZL5VYmfkgXGJ2
sPmbv095hloK78+thyP7xIATTWU30In+wvfgYtDKo3ytozkNls6rCTLy+gor7x31
+sJKBL+g+noTy+RsGkZNK3briUjNRu6ZV2x4vdHEbgz9Hov8eJPlOK57uAaDFUTc
xfYpIrMqSiWcBwDcfNVW8uWHSzDOu+4finxXIZFicNSP96rotUcIG9ezWdgx9oTV
AW3I9j54auQ4dgqxMC+75xXZAo3rPsyp1XxmZDcEME1HDo1N5PCUj8t+74IU8fu6
bj6yF7yXxEzHYQeG/Ix9OYlivqRX7ngxifPHg7X4yyvAxWGHqpKDXpjfn/SJjKQD
+bIPAAzkD2V1yLDeO1G22NY91VJFQnTKAYlnI+0XbeFpCY+l8Lv3jFa1soc8KHxk
HrQMbzii1DcyVrTJ6tuYNiev9IVcIpY8i2y75PsPQdBaO/o0aOoqRxPRNzmz0oUC
MgZ8MUUK01q3F1B6o23FKieW0jHKK8ENlUfBWXj+MC+/xJGEgIgoOXbttoiC4zHZ
9IDk90pvXXtJ+xLwCZU6YCjQHh7jhi6iVTYM2Sp9jFbjmS8N1nA=
=Ognr
-----END PGP SIGNATURE-----

--RjA92gf1Hr1LEJ5suHSGmspAI1djoxbuI--
