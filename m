From: Damjan Georgievski <gdamjan@gmail.com>
Subject: Re: [git pull] Input updates for v4.12-rc4
Date: Mon, 26 Jun 2017 11:14:55 +0200
Message-ID: <CAEk1YH6Z1xfAY_GQGQO+Zt+GfQspr=JSMyqphkP7h7gNr99tCQ@mail.gmail.com>
References: <20170610003346.GA35678@dtor-ws> <CAEk1YH6SNmCGxBh8i-1PhU=g_fekQ4K=6fnj326b+zTfWC7aWg@mail.gmail.com>
 <20170620025550.GE21379@dtor-ws> <CAEk1YH6b1BZ95y46ycXstv1gYS-E2Y5EEvfcUYXtw8AOvk+phg@mail.gmail.com>
 <CAEk1YH6RA6WBtx-M928--2vUSRr2tmF7Hp-yDK8+EyXZL2Wbdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37270 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751353AbdFZJO7 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 26 Jun 2017 05:14:59 -0400
Received: by mail-wm0-f47.google.com with SMTP id i127so2088332wma.0
        for <linux-input@vger.kernel.org>; Mon, 26 Jun 2017 02:14:58 -0700 (PDT)
In-Reply-To: <CAEk1YH6RA6WBtx-M928--2vUSRr2tmF7Hp-yDK8+EyXZL2Wbdg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On 25 June 2017 at 20:04, Damjan Georgievski <gdamjan@gmail.com> wrote:
> On 25 June 2017 at 17:23, Damjan Georgievski <gdamjan@gmail.com> wrote:
>> On 20 June 2017 at 04:55, Dmitry Torokhov <dmitry.torokhov@gmail.com> wr=
ote:
>>> On Sat, Jun 10, 2017 at 12:42:13PM +0200, Damjan Georgievski wrote:
>>>> >
>>>> > - mark "guest" RMI device as pass-through port to avoid "phantom" AL=
PS
>>>> >   toouchpad on newer Lenovo Carbons
>>>>
>>>> What's the end game for supporting these devices?
>>>>
>>>> With the latest HEAD of Linus, first I get:
>>>> =C2=BB Jun 10 12:19:17 cambrian kernel: psmouse serio1: synaptics: You=
r
>>>> touchpad (PNP: LEN0072 PNP0f13) says it can support a different bus.
>>>> If i2c-hid and hid-rmi are not used, you might want to try setting
>>>> psmouse.synaptics_intertouch to 1 and report this to
>>>> linux-input@vger.kernel.org.
>>>>
>>>> Then if I patch drivers/input/mouse/synaptics.c and add "LEN0072" to
>>>> smbus_pnp_ids, this strange thing happens:
>>>>
>>>> [    8.526635] psmouse serio1: synaptics: queried max coordinates: x
>>>> [..5676], y [..4760]
>>>> [    8.555746] psmouse serio1: synaptics: queried min coordinates: x
>>>> [1266..], y [1094..]
>>>> [    8.555750] psmouse serio1: synaptics: Trying to set up SMBus acces=
s
>>>> [    8.615774] rmi4_f01 rmi4-00.fn01: found RMI device, manufacturer:
>>>> Synaptics, product: TM3289-002, fw id: 2492434
>>>> [    8.679863] input: Synaptics TM3289-002 as /devices/rmi4-00/input/i=
nput18
>>>> [    8.682660] mousedev: PS/2 mouse device common for all mice
>>>> =E2=80=A6 snipped =E2=80=A6
>>>> [  107.225549] input: ImPS/2 Generic Wheel Mouse as
>>>> /devices/rmi4-00/rmi4-00.fn03/serio2/input/input20
>>>>
>>>> Notice how the trackpoint only appeared 100 seconds after boot (X was
>>>> already started and initially the trackpoint was not listed in xinput)
>>>
>>> 100 seconds is quire ridiculous. Could you please post your entire boot
>>> log so we can understand what happened there.
>>
>> Sorry for the delay, I was travelling and couldn't put more time into it=
 =E2=80=A6
>>
>> There was nothing happening in-between (at least nothing in the logs).
>> Just to make this clear,
>> I'm running the lastest linus 4.12 tree, with this[1] one-liner patch
>> to add the X1 Carbon to smbus_pnp_ids.
>
> after suspend and resume the trackpoint device does show up.
>
> [   40.124861] input: ImPS/2 Generic Wheel Mouse as
> /devices/rmi4-00/rmi4-00.fn03/serio2/input/input20

and one more data point, kernel 4.12-rc7 (with the afore mentioned
patch), the trackpoint appeared spontaneuosly at the  ~155 seconds
mark,
full dmesg follows:

[    0.000000] Linux version 4.12.0-rc7+ (damjan@archless) (gcc
version 7.1.1 20170528 (GCC) ) #1 SMP PREEMPT Mon Jun 26 10:03:41 CEST
2017
[    0.000000] Command line: initrd=3D\intel-ucode.img
initrd=3D\initramfs-linux.img
cryptdevice=3DUUID=3D7b411dfd-9d7f-48bb-95fa-1ca52d67de57:root:allow-discar=
ds
root=3D/dev/mapper/root rw quiet

[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating
point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registe=
rs'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.000000] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.000000] x86/fpu: Enabled xstate features 0x1f, context size is
960 bytes, using 'compacted' format.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000057fff] usabl=
e
[    0.000000] BIOS-e820: [mem 0x0000000000058000-0x0000000000058fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000059000-0x000000000009cfff] usabl=
e
[    0.000000] BIOS-e820: [mem 0x000000000009d000-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000050b2efff] usabl=
e
[    0.000000] BIOS-e820: [mem 0x0000000050b2f000-0x0000000050b2ffff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x0000000050b30000-0x0000000050b30fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000050b31000-0x000000005a472fff] usabl=
e
[    0.000000] BIOS-e820: [mem 0x000000005a473000-0x000000005b52bfff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000005b52c000-0x000000005b54cfff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x000000005b54d000-0x000000005b54dfff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000005b54e000-0x000000005b599fff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x000000005b59a000-0x000000005b5fefff] ACPI =
data
[    0.000000] BIOS-e820: [mem 0x000000005b5ff000-0x000000005b5fffff] usabl=
e
[    0.000000] BIOS-e820: [mem 0x000000005b600000-0x000000005f7fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000f0000000-0x00000000f7ffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fe010000-0x00000000fe010fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000049f7fffff] usabl=
e
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.50 by Lenovo
[    0.000000] efi:  SMBIOS=3D0x5a6fe000  SMBIOS 3.0=3D0x5a6fb000
ACPI=3D0x5b5fe000  ACPI 2.0=3D0x5b5fe014  ESRT=3D0x5a576000
MEMATTR=3D0x55400018
[    0.000000] SMBIOS 3.0.0 present.
[    0.000000] DMI: LENOVO 20HQS0LV00/20HQS0LV00, BIOS N1MET35W (1.20
) 05/17/2017
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn =3D 0x49f800 max_arch_pfn =3D 0x400000000
[    0.000000] MTRR default type: write-back
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 0080000000 mask 7F80000000 uncachable
[    0.000000]   1 base 0060000000 mask 7FE0000000 uncachable
[    0.000000]   2 base 005E000000 mask 7FFE000000 uncachable
[    0.000000]   3 base 005D000000 mask 7FFF000000 uncachable
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000]   8 disabled
[    0.000000]   9 disabled
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- WT
[    0.000000] e820: last_pfn =3D 0x5b600 max_arch_pfn =3D 0x400000000
[    0.000000] esrt: Reserving ESRT space from 0x000000005a576000 to
0x000000005a576088.
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] Base memory trampoline at [ffff880000097000] 97000 size 2457=
6
[    0.000000] Using GB pages for direct mapping
[    0.000000] BRK [0x01d60000, 0x01d60fff] PGTABLE
[    0.000000] BRK [0x01d61000, 0x01d61fff] PGTABLE
[    0.000000] BRK [0x01d62000, 0x01d62fff] PGTABLE
[    0.000000] BRK [0x01d63000, 0x01d63fff] PGTABLE
[    0.000000] BRK [0x01d64000, 0x01d64fff] PGTABLE
[    0.000000] BRK [0x01d65000, 0x01d65fff] PGTABLE
[    0.000000] Secure boot could not be determined
[    0.000000] RAMDISK: [mem 0x4b081000-0x4bc73fff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x000000005B5FE014 000024 (v02 LENOVO)
[    0.000000] ACPI: XSDT 0x000000005B5C3188 0000FC (v01 LENOVO TP-N1M
  00001200 PTEC 00000002)
[    0.000000] ACPI: FACP 0x000000005B5F5000 0000F4 (v05 LENOVO TP-N1M
  00001200 PTEC 00000002)
[    0.000000] ACPI: DSDT 0x000000005B5D0000 0206BC (v02 LENOVO SKL
  00000000 INTL 20160527)
[    0.000000] ACPI: FACS 0x000000005B53C000 000040
[    0.000000] ACPI: SSDT 0x000000005B5FC000 0003CC (v02 LENOVO
Tpm2Tabl 00001000 INTL 20160527)
[    0.000000] ACPI: TPM2 0x000000005B5FB000 000034 (v03 LENOVO TP-N1M
  00001200 PTEC 00000002)
[    0.000000] ACPI: UEFI 0x000000005B553000 000042 (v01 LENOVO TP-N1M
  00001200 PTEC 00000002)
[    0.000000] ACPI: SSDT 0x000000005B5F7000 003252 (v02 LENOVO SaSsdt
  00003000 INTL 20160527)
[    0.000000] ACPI: SSDT 0x000000005B5F6000 0005B6 (v02 LENOVO
PerfTune 00001000 INTL 20160527)
[    0.000000] ACPI: HPET 0x000000005B5F4000 000038 (v01 LENOVO TP-N1M
  00001200 PTEC 00000002)
[    0.000000] ACPI: APIC 0x000000005B5F3000 0000BC (v03 LENOVO TP-N1M
  00001200 PTEC 00000002)
[    0.000000] ACPI: MCFG 0x000000005B5F2000 00003C (v01 LENOVO TP-N1M
  00001200 PTEC 00000002)
[    0.000000] ACPI: ECDT 0x000000005B5F1000 000053 (v01 LENOVO TP-N1M
  00001200 PTEC 00000002)
[    0.000000] ACPI: SSDT 0x000000005B5CE000 001627 (v02 LENOVO
ProjSsdt 00000010 INTL 20160527)
[    0.000000] ACPI: BOOT 0x000000005B5CD000 000028 (v01 LENOVO TP-N1M
  00001200 PTEC 00000002)
[    0.000000] ACPI: BATB 0x000000005B5CC000 00004A (v02 LENOVO TP-N1M
  00001200 PTEC 00000002)
[    0.000000] ACPI: SSDT 0x000000005B5CB000 000EDE (v02 LENOVO
CpuSsdt  00003000 INTL 20160527)
[    0.000000] ACPI: SSDT 0x000000005B5CA000 00050D (v02 LENOVO CtdpB
  00001000 INTL 20160527)
[    0.000000] ACPI: SSDT 0x000000005B5C9000 000678 (v02 LENOVO
UsbCTabl 00001000 INTL 20160527)
[    0.000000] ACPI: WSMT 0x000000005B5C8000 000028 (v01 LENOVO TP-N1M
  00001200 PTEC 00000002)
[    0.000000] ACPI: SSDT 0x000000005B5C7000 000141 (v02 LENOVO HdaDsp
  00000000 INTL 20160527)
[    0.000000] ACPI: SSDT 0x000000005B5C6000 00050D (v02 LENOVO
TbtTypeC 00000000 INTL 20160527)
[    0.000000] ACPI: DBGP 0x000000005B5C5000 000034 (v01 LENOVO TP-N1M
  00001200 PTEC 00000002)
[    0.000000] ACPI: DBG2 0x000000005B5C4000 000054 (v00 LENOVO TP-N1M
  00001200 PTEC 00000002)
[    0.000000] ACPI: POAT 0x000000005B5FD000 000055 (v03 LENOVO TP-N1M
  00001200 PTEC 00000002)
[    0.000000] ACPI: DMAR 0x000000005B5C2000 0000A8 (v01 LENOVO TP-N1M
  00001200 PTEC 00000002)
[    0.000000] ACPI: ASF! 0x000000005B5C1000 0000A0 (v32 LENOVO TP-N1M
  00001200 PTEC 00000002)
[    0.000000] ACPI: FPDT 0x000000005B5C0000 000044 (v01 LENOVO TP-N1M
  00001200 PTEC 00000002)
[    0.000000] ACPI: BGRT 0x000000005B5BF000 000038 (v01 LENOVO TP-N1M
  00001200 PTEC 00000002)
[    0.000000] ACPI: UEFI 0x000000005B539000 00013E (v01 LENOVO TP-N1M
  00001200 PTEC 00000002)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000049f7fffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x49f7f9000-0x49f7fdfff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000049f7fffff]
[    0.000000]   Device   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x0000000000057fff]
[    0.000000]   node   0: [mem 0x0000000000059000-0x000000000009cfff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x0000000050b2efff]
[    0.000000]   node   0: [mem 0x0000000050b31000-0x000000005a472fff]
[    0.000000]   node   0: [mem 0x000000005b5ff000-0x000000005b5fffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000049f7fffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000049f7ff=
fff]
[    0.000000] On node 0 totalpages: 4168717
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 21 pages reserved
[    0.000000]   DMA zone: 3995 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 5714 pages used for memmap
[    0.000000]   DMA32 zone: 365682 pages, LIFO batch:31
[    0.000000]   Normal zone: 59360 pages used for memmap
[    0.000000]   Normal zone: 3799040 pages, LIFO batch:31
[    0.000000] Reserving Intel graphics memory at
0x000000005d800000-0x000000005f7fffff
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
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-=
119
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x00058000-0x00058fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009d000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0x50b2f000-0x50b2ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x50b30000-0x50b30fff]
[    0.000000] PM: Registered nosave memory: [mem 0x5a473000-0x5b52bfff]
[    0.000000] PM: Registered nosave memory: [mem 0x5b52c000-0x5b54cfff]
[    0.000000] PM: Registered nosave memory: [mem 0x5b54d000-0x5b54dfff]
[    0.000000] PM: Registered nosave memory: [mem 0x5b54e000-0x5b599fff]
[    0.000000] PM: Registered nosave memory: [mem 0x5b59a000-0x5b5fefff]
[    0.000000] PM: Registered nosave memory: [mem 0x5b600000-0x5f7fffff]
[    0.000000] PM: Registered nosave memory: [mem 0x5f800000-0xefffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xf0000000-0xf7ffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xf8000000-0xfe00ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfe010000-0xfe010fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfe011000-0xffffffff]
[    0.000000] e820: [mem 0x5f800000-0xefffffff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff
max_cycles: 0xffffffff, max_idle_ns: 6370452778343963 ns
[    0.000000] setup_percpu: NR_CPUS:128 nr_cpumask_bits:128
nr_cpu_ids:4 nr_node_ids:1
[    0.000000] percpu: Embedded 37 pages/cpu @ffff88049f400000 s114456
r8192 d28904 u524288
[    0.000000] pcpu-alloc: s114456 r8192 d28904 u524288 alloc=3D1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.
Total pages: 4103558
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: initrd=3D\intel-ucode.img
initrd=3D\initramfs-linux.img
cryptdevice=3DUUID=3D7b411dfd-9d7f-48bb-95fa-1ca52d67de57:root:allow-discar=
ds
root=3D/dev/mapper/root rw quiet

[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing=
!
[    0.000000] Memory: 16234908K/16674868K available (6424K kernel
code, 1115K rwdata, 2016K rodata, 1340K init, 912K bss, 439960K
reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D4, N=
odes=3D1
[    0.000000] ftrace: allocating 27586 entries in 108 pages
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000]     RCU restricting CPUs from NR_CPUS=3D128 to nr_cpu_ids=3D=
4.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D4
[    0.000000] NR_IRQS:8448 nr_irqs:1024 16
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 79635855245 ns
[    0.000000] hpet clockevent registered
[    0.003333] tsc: Detected 2900.000 MHz processor
[    0.003333] Calibrating delay loop (skipped), value calculated
using timer frequency.. 5810.00 BogoMIPS (lpj=3D9680000)
[    0.003333] pid_max: default: 32768 minimum: 301
[    0.003333] ACPI: Core revision 20170303
[    0.067442] ACPI: 10 ACPI AML tables successfully acquired and loaded
[    0.068322] Security Framework initialized
[    0.068323] Yama: becoming mindful.
[    0.069323] Dentry cache hash table entries: 2097152 (order: 12,
16777216 bytes)
[    0.073293] Inode-cache hash table entries: 1048576 (order: 11,
8388608 bytes)
[    0.075065] Mount-cache hash table entries: 32768 (order: 6, 262144 byte=
s)
[    0.075082] Mountpoint-cache hash table entries: 32768 (order: 6,
262144 bytes)
[    0.075409] CPU: Physical Processor ID: 0
[    0.075410] CPU: Processor Core ID: 0
[    0.075417] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.075418] ENERGY_PERF_BIAS: View and update with x86_energy_perf_polic=
y(8)
[    0.075425] mce: CPU supports 8 MCE banks
[    0.075438] CPU0: Thermal monitoring enabled (TM1)
[    0.075461] process: using mwait in idle threads
[    0.075464] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[    0.075465] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    0.075614] Freeing SMP alternatives memory: 24K
[    0.080778] smpboot: Max logical packages: 2
[    0.080787] DMAR: Host address width 39
[    0.080789] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.080797] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap
1c0000c40660462 ecap 19e2ff0505e
[    0.080799] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.080807] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap
d2008c40660462 ecap f050da
[    0.080809] DMAR: RMRR base: 0x0000005aa9f000 end: 0x0000005aabefff
[    0.080810] DMAR: RMRR base: 0x0000005d000000 end: 0x0000005f7fffff
[    0.080813] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    0.080814] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.080815] DMAR-IR: Queued invalidation will be enabled to support
x2apic and Intr-remapping.
[    0.082352] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.082353] x2apic enabled
[    0.082367] Switched APIC routing to cluster x2apic.
[    0.086651] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.116363] TSC deadline timer enabled
[    0.116371] smpboot: CPU0: Intel(R) Core(TM) i7-7500U CPU @ 2.70GHz
(family: 0x6, model: 0x8e, stepping: 0x9)
[    0.126700] Performance Events: PEBS fmt3+, Skylake events, 32-deep
LBR, full-width counters, Intel PMU driver.
[    0.126742] ... version:                4
[    0.126743] ... bit width:              48
[    0.126744] ... generic registers:      4
[    0.126745] ... value mask:             0000ffffffffffff
[    0.126745] ... max period:             00007fffffffffff
[    0.126746] ... fixed-purpose events:   3
[    0.126747] ... event mask:             000000070000000f
[    0.146787] NMI watchdog: enabled on all CPUs, permanently consumes
one hw-PMU counter.
[    0.153343] smp: Bringing up secondary CPUs ...
[    0.180044] x86: Booting SMP configuration:
[    0.180045] .... node  #0, CPUs:      #1 #2 #3
[    0.483391] smp: Brought up 1 node, 4 CPUs
[    0.483391] smpboot: Total of 4 processors activated (23250.04 BogoMIPS)
[    0.486842] sched_clock: Marking stable (486666618, 0)->(494398766, -773=
2148)
[    0.487453] devtmpfs: initialized
[    0.487526] x86/mm: Memory block size: 128MB
[    0.493166] PM: Registering ACPI NVS region [mem
0x50b2f000-0x50b2ffff] (4096 bytes)
[    0.493167] PM: Registering ACPI NVS region [mem
0x5b52c000-0x5b54cfff] (135168 bytes)
[    0.493170] PM: Registering ACPI NVS region [mem
0x5b54e000-0x5b599fff] (311296 bytes)
[    0.493260] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 6370867519511994 ns
[    0.493273] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.493367] pinctrl core: initialized pinctrl subsystem
[    0.493488] RTC time:  9:05:04, date: 06/26/17
[    0.493606] NET: Registered protocol family 16
[    0.493874] cpuidle: using governor ladder
[    0.493925] cpuidle: using governor menu
[    0.493928] PCCT header not found.
[    0.493993] Simple Boot Flag at 0x47 set to 0x1
[    0.494018] ACPI FADT declares the system doesn't support PCIe
ASPM, so disable it
[    0.494020] ACPI: bus type PCI registered
[    0.494021] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.494250] PCI: MMCONFIG for domain 0000 [bus 00-7f] at [mem
0xf0000000-0xf7ffffff] (base 0xf0000000)
[    0.494291] PCI: MMCONFIG at [mem 0xf0000000-0xf7ffffff] reserved in E82=
0
[    0.494301] PCI: Using configuration type 1 for base access
[    0.496866] HugeTLB registered 1 GB page size, pre-allocated 0 pages
[    0.496867] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.497155] ACPI: Added _OSI(Module Device)
[    0.497156] ACPI: Added _OSI(Processor Device)
[    0.497158] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.497159] ACPI: Added _OSI(Processor Aggregator Device)
[    0.497167] ACPI : EC: EC started
[    0.497168] ACPI : EC: interrupt blocked
[    0.499941] ACPI: \: Used as first EC
[    0.499943] ACPI: \: GPE=3D0x16, EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.499944] ACPI: \: Used as boot ECDT EC to handle transactions
[    0.502380] ACPI: Executed 25 blocks of module-level executable AML code
[    0.516615] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.530466] ACPI: Dynamic OEM Table Load:
[    0.530553] ACPI: SSDT 0xFFFF88048CAC3000 0006F6 (v02 PmRef
Cpu0Ist  00003000 INTL 20160527)
[    0.530795] ACPI: Executed 1 blocks of module-level executable AML code
[    0.530925] ACPI: \_PR_.CPU0: _OSC native thermal LVT Acked
[    0.532469] ACPI: Dynamic OEM Table Load:
[    0.532483] ACPI: SSDT 0xFFFF88048C49D800 0003FF (v02 PmRef
Cpu0Cst  00003001 INTL 20160527)
[    0.532690] ACPI: Executed 1 blocks of module-level executable AML code
[    0.532969] ACPI: Dynamic OEM Table Load:
[    0.532981] ACPI: SSDT 0xFFFF88048C4A0800 000115 (v02 PmRef
Cpu0Hwp  00003000 INTL 20160527)
[    0.533153] ACPI: Executed 1 blocks of module-level executable AML code
[    0.533276] ACPI: Dynamic OEM Table Load:
[    0.533287] ACPI: SSDT 0xFFFF88048C4A1A00 0001A4 (v02 PmRef  HwpLvt
  00003000 INTL 20160527)
[    0.533452] ACPI: Executed 1 blocks of module-level executable AML code
[    0.534052] ACPI: Dynamic OEM Table Load:
[    0.534066] ACPI: SSDT 0xFFFF88048CAC4000 00065C (v02 PmRef  ApIst
  00003000 INTL 20160527)
[    0.534608] ACPI: Executed 1 blocks of module-level executable AML code
[    0.534874] ACPI: Dynamic OEM Table Load:
[    0.534886] ACPI: SSDT 0xFFFF88048C4A1800 000197 (v02 PmRef  ApHwp
  00003000 INTL 20160527)
[    0.535093] ACPI: Executed 1 blocks of module-level executable AML code
[    0.535366] ACPI: Dynamic OEM Table Load:
[    0.535378] ACPI: SSDT 0xFFFF88048C4A1E00 00018A (v02 PmRef  ApCst
  00003000 INTL 20160527)
[    0.535580] ACPI: Executed 1 blocks of module-level executable AML code
[    0.537663] ACPI : EC: EC stopped
[    0.537664] ACPI : EC: EC started
[    0.537665] ACPI : EC: interrupt blocked
[    0.537913] ACPI: \_SB_.PCI0.LPCB.EC__: Used as first EC
[    0.537915] ACPI: \_SB_.PCI0.LPCB.EC__: GPE=3D0x16,
EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.537917] ACPI: \_SB_.PCI0.LPCB.EC__: Used as boot DSDT EC to
handle transactions
[    0.537918] ACPI: Interpreter enabled
[    0.537997] ACPI: (supports S0 S3 S4 S5)
[    0.537998] ACPI: Using IOAPIC for interrupt routing
[    0.538065] PCI: Using host bridge windows from ACPI; if necessary,
use "pci=3Dnocrs" and report a bug
[    0.543907] ACPI: Power Resource [PUBS] (on)
[    0.564678] ACPI: Power Resource [WRST] (on)
[    0.564888] ACPI: Power Resource [WRST] (on)
[    0.584870] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-7e])
[    0.584878] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM
ClockPM Segments MSI]
[    0.585048] acpi PNP0A08:00: _OSC: platform does not support
[PCIeHotplug PME AER PCIeCapability]
[    0.585050] acpi PNP0A08:00: _OSC: not requesting control; platform
does not support [PCIeCapability]
[    0.585052] acpi PNP0A08:00: _OSC: OS requested [PCIeHotplug PME
AER PCIeCapability]
[    0.585053] acpi PNP0A08:00: _OSC: platform willing to grant []
[    0.585055] acpi PNP0A08:00: _OSC failed (AE_SUPPORT); disabling ASPM
[    0.588027] PCI host bridge to bus 0000:00
[    0.588030] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window=
]
[    0.588032] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window=
]
[    0.588033] pci_bus 0000:00: root bus resource [mem
0x000a0000-0x000bffff window]
[    0.588035] pci_bus 0000:00: root bus resource [mem
0x000c0000-0x000c3fff window]
[    0.588036] pci_bus 0000:00: root bus resource [mem
0x000c4000-0x000c7fff window]
[    0.588037] pci_bus 0000:00: root bus resource [mem
0x000c8000-0x000cbfff window]
[    0.588039] pci_bus 0000:00: root bus resource [mem
0x000cc000-0x000cffff window]
[    0.588040] pci_bus 0000:00: root bus resource [mem
0x000d0000-0x000d3fff window]
[    0.588041] pci_bus 0000:00: root bus resource [mem
0x000d4000-0x000d7fff window]
[    0.588043] pci_bus 0000:00: root bus resource [mem
0x000d8000-0x000dbfff window]
[    0.588044] pci_bus 0000:00: root bus resource [mem
0x000dc000-0x000dffff window]
[    0.588045] pci_bus 0000:00: root bus resource [mem
0x000e0000-0x000e3fff window]
[    0.588047] pci_bus 0000:00: root bus resource [mem
0x000e4000-0x000e7fff window]
[    0.588048] pci_bus 0000:00: root bus resource [mem
0x000e8000-0x000ebfff window]
[    0.588049] pci_bus 0000:00: root bus resource [mem
0x000ec000-0x000effff window]
[    0.588051] pci_bus 0000:00: root bus resource [mem
0x000f0000-0x000fffff window]
[    0.588052] pci_bus 0000:00: root bus resource [mem
0x5f800000-0xefffffff window]
[    0.588054] pci_bus 0000:00: root bus resource [mem
0xfd000000-0xfe7fffff window]
[    0.588055] pci_bus 0000:00: root bus resource [bus 00-7e]
[    0.588068] pci 0000:00:00.0: [8086:5904] type 00 class 0x060000
[    0.589234] pci 0000:00:02.0: [8086:5916] type 00 class 0x030000
[    0.589250] pci 0000:00:02.0: reg 0x10: [mem 0xeb000000-0xebffffff 64bit=
]
[    0.589260] pci 0000:00:02.0: reg 0x18: [mem 0x60000000-0x6fffffff
64bit pref]
[    0.589266] pci 0000:00:02.0: reg 0x20: [io  0xe000-0xe03f]
[    0.590449] pci 0000:00:08.0: [8086:1911] type 00 class 0x088000
[    0.590465] pci 0000:00:08.0: reg 0x10: [mem 0xec348000-0xec348fff 64bit=
]
[    0.591649] pci 0000:00:14.0: [8086:9d2f] type 00 class 0x0c0330
[    0.591674] pci 0000:00:14.0: reg 0x10: [mem 0xec320000-0xec32ffff 64bit=
]
[    0.591763] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.592993] pci 0000:00:14.0: System wakeup disabled by ACPI
[    0.593046] pci 0000:00:14.2: [8086:9d31] type 00 class 0x118000
[    0.593071] pci 0000:00:14.2: reg 0x10: [mem 0xec349000-0xec349fff 64bit=
]
[    0.594265] pci 0000:00:16.0: [8086:9d3a] type 00 class 0x078000
[    0.594293] pci 0000:00:16.0: reg 0x10: [mem 0xec34a000-0xec34afff 64bit=
]
[    0.594386] pci 0000:00:16.0: PME# supported from D3hot
[    0.595608] pci 0000:00:1c.0: [8086:9d10] type 01 class 0x060400
[    0.595704] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.596857] pci 0000:00:1c.0: System wakeup disabled by ACPI
[    0.596908] pci 0000:00:1c.2: [8086:9d12] type 01 class 0x060400
[    0.597000] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    0.598207] pci 0000:00:1c.4: [8086:9d14] type 01 class 0x060400
[    0.598317] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.599468] pci 0000:00:1c.4: System wakeup disabled by ACPI
[    0.599528] pci 0000:00:1d.0: [8086:9d18] type 01 class 0x060400
[    0.599623] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.600770] pci 0000:00:1d.0: System wakeup disabled by ACPI
[    0.600846] pci 0000:00:1f.0: [8086:9d58] type 00 class 0x060100
[    0.602150] pci 0000:00:1f.2: [8086:9d21] type 00 class 0x058000
[    0.602165] pci 0000:00:1f.2: reg 0x10: [mem 0xec344000-0xec347fff]
[    0.603395] pci 0000:00:1f.3: [8086:9d71] type 00 class 0x040300
[    0.603426] pci 0000:00:1f.3: reg 0x10: [mem 0xec340000-0xec343fff 64bit=
]
[    0.603467] pci 0000:00:1f.3: reg 0x20: [mem 0xec330000-0xec33ffff 64bit=
]
[    0.603533] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    0.604706] pci 0000:00:1f.3: System wakeup disabled by ACPI
[    0.604758] pci 0000:00:1f.4: [8086:9d23] type 00 class 0x0c0500
[    0.604803] pci 0000:00:1f.4: reg 0x10: [mem 0xec34b000-0xec34b0ff 64bit=
]
[    0.604861] pci 0000:00:1f.4: reg 0x20: [io  0xefa0-0xefbf]
[    0.606111] pci 0000:00:1f.6: [8086:15d8] type 00 class 0x020000
[    0.606137] pci 0000:00:1f.6: reg 0x10: [mem 0xec300000-0xec31ffff]
[    0.606257] pci 0000:00:1f.6: PME# supported from D0 D3hot D3cold
[    0.607409] pci 0000:00:1f.6: System wakeup disabled by ACPI
[    0.607596] pci 0000:02:00.0: [10ec:525a] type 00 class 0xff0000
[    0.607626] pci 0000:02:00.0: reg 0x14: [mem 0xec200000-0xec200fff]
[    0.607806] pci 0000:02:00.0: supports D1 D2
[    0.607808] pci 0000:02:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.614917] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.614923] pci 0000:00:1c.0:   bridge window [mem 0xec200000-0xec2fffff=
]
[    0.615374] pci 0000:04:00.0: [8086:24fd] type 00 class 0x028000
[    0.615464] pci 0000:04:00.0: reg 0x10: [mem 0xec100000-0xec101fff 64bit=
]
[    0.616006] pci 0000:04:00.0: PME# supported from D0 D3hot D3cold
[    0.625131] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.625137] pci 0000:00:1c.2:   bridge window [mem 0xec100000-0xec1fffff=
]
[    0.625435] pci 0000:05:00.0: [144d:a804] type 00 class 0x010802
[    0.625463] pci 0000:05:00.0: reg 0x10: [mem 0xec000000-0xec003fff 64bit=
]
[    0.635070] pci 0000:00:1c.4: PCI bridge to [bus 05]
[    0.635075] pci 0000:00:1c.4:   bridge window [mem 0xec000000-0xec0fffff=
]
[    0.635145] pci 0000:00:1d.0: PCI bridge to [bus 06-70]
[    0.635153] pci 0000:00:1d.0:   bridge window [mem 0xbc000000-0xea0fffff=
]
[    0.635159] pci 0000:00:1d.0:   bridge window [mem
0x70000000-0xb9ffffff 64bit pref]
[    0.637399] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 *11 12 14 1=
5)
[    0.637483] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *10 11 12 14 1=
5)
[    0.637563] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 *11 12 14 1=
5)
[    0.637642] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 *11 12 14 1=
5)
[    0.637721] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 *11 12 14 1=
5)
[    0.637799] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 *11 12 14 1=
5)
[    0.637877] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 *11 12 14 1=
5)
[    0.637955] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 *11 12 14 1=
5)
[    0.638644] ACPI: Enabled 4 GPEs in block 00 to 7F
[    0.638736] ACPI : EC: interrupt unblocked
[    0.638758] ACPI : EC: event unblocked
[    0.638773] ACPI: \_SB_.PCI0.LPCB.EC__: GPE=3D0x16,
EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.638775] ACPI: \_SB_.PCI0.LPCB.EC__: Used as boot DSDT EC to
handle transactions and events
[    0.638897] pci 0000:00:02.0: vgaarb: VGA device added:
decodes=3Dio+mem,owns=3Dmem,locks=3Dnone
[    0.638902] pci 0000:00:02.0: vgaarb: setting as boot device
[    0.638903] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.638904] vgaarb: loaded
[    0.638971] EDAC MC: Ver: 3.0.0
[    0.639650] Registered efivars operations
[    0.668228] PCI: Using ACPI for IRQ routing
[    0.674515] PCI: pci_cache_line_size set to 64 bytes
[    0.675676] e820: reserve RAM buffer [mem 0x00058000-0x0005ffff]
[    0.675678] e820: reserve RAM buffer [mem 0x0009d000-0x0009ffff]
[    0.675679] e820: reserve RAM buffer [mem 0x50b2f000-0x53ffffff]
[    0.675681] e820: reserve RAM buffer [mem 0x5a473000-0x5bffffff]
[    0.675683] e820: reserve RAM buffer [mem 0x5b600000-0x5bffffff]
[    0.675684] e820: reserve RAM buffer [mem 0x49f800000-0x49fffffff]
[    0.675798] NetLabel: Initializing
[    0.675799] NetLabel:  domain hash size =3D 128
[    0.675800] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    0.675823] NetLabel:  unlabeled traffic allowed by default
[    0.676305] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.676313] hpet0: 8 comparators, 64-bit 24.000000 MHz counter
[    0.679394] clocksource: Switched to clocksource hpet
[    0.691666] VFS: Disk quotas dquot_6.6.0
[    0.691691] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    0.691782] pnp: PnP ACPI init
[    0.692015] system 00:00: [mem 0xfd000000-0xfdabffff] has been reserved
[    0.692017] system 00:00: [mem 0xfdad0000-0xfdadffff] has been reserved
[    0.692019] system 00:00: [mem 0xfdb00000-0xfdffffff] has been reserved
[    0.692021] system 00:00: [mem 0xfe000000-0xfe01ffff] could not be reser=
ved
[    0.692023] system 00:00: [mem 0xfe036000-0xfe03bfff] has been reserved
[    0.692025] system 00:00: [mem 0xfe03d000-0xfe3fffff] has been reserved
[    0.692027] system 00:00: [mem 0xfe410000-0xfe7fffff] has been reserved
[    0.692032] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active=
)
[    0.692528] system 00:01: [io  0xff00-0xfffe] has been reserved
[    0.692532] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active=
)
[    0.693018] system 00:02: [io  0x0680-0x069f] has been reserved
[    0.693020] system 00:02: [io  0xffff] has been reserved
[    0.693022] system 00:02: [io  0xffff] has been reserved
[    0.693024] system 00:02: [io  0xffff] has been reserved
[    0.693026] system 00:02: [io  0x1800-0x18fe] has been reserved
[    0.693027] system 00:02: [io  0x164e-0x164f] has been reserved
[    0.693031] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active=
)
[    0.693193] pnp 00:03: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.693249] system 00:04: [io  0x1854-0x1857] has been reserved
[    0.693253] system 00:04: Plug and Play ACPI device, IDs INT3f0d
PNP0c02 (active)
[    0.693281] pnp 00:05: Plug and Play ACPI device, IDs LEN0071
PNP0303 (active)
[    0.693307] pnp 00:06: Plug and Play ACPI device, IDs LEN0072
PNP0f13 (active)
[    0.693454] system 00:07: [io  0x1800-0x189f] could not be reserved
[    0.693456] system 00:07: [io  0x0800-0x087f] has been reserved
[    0.693458] system 00:07: [io  0x0880-0x08ff] has been reserved
[    0.693460] system 00:07: [io  0x0900-0x097f] has been reserved
[    0.693462] system 00:07: [io  0x0980-0x09ff] has been reserved
[    0.693464] system 00:07: [io  0x0a00-0x0a7f] has been reserved
[    0.693466] system 00:07: [io  0x0a80-0x0aff] has been reserved
[    0.693468] system 00:07: [io  0x0b00-0x0b7f] has been reserved
[    0.693470] system 00:07: [io  0x0b80-0x0bff] has been reserved
[    0.693472] system 00:07: [io  0x15e0-0x15ef] has been reserved
[    0.693474] system 00:07: [io  0x1600-0x167f] could not be reserved
[    0.693476] system 00:07: [io  0x1640-0x165f] could not be reserved
[    0.693478] system 00:07: [mem 0xf0000000-0xf7ffffff] has been reserved
[    0.693481] system 00:07: [mem 0xfed10000-0xfed13fff] has been reserved
[    0.693483] system 00:07: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.693485] system 00:07: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.693486] system 00:07: [mem 0xfeb00000-0xfebfffff] has been reserved
[    0.693488] system 00:07: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.693491] system 00:07: [mem 0xfed90000-0xfed93fff] could not be reser=
ved
[    0.693493] system 00:07: [mem 0xeffe0000-0xefffffff] has been reserved
[    0.693496] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active=
)
[    0.695498] system 00:08: [mem 0xfdaf0000-0xfdafffff] has been reserved
[    0.695500] system 00:08: [mem 0xfdae0000-0xfdaeffff] has been reserved
[    0.695502] system 00:08: [mem 0xfdac0000-0xfdacffff] has been reserved
[    0.695505] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active=
)
[    0.696388] system 00:09: [mem 0xfed10000-0xfed17fff] could not be reser=
ved
[    0.696390] system 00:09: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.696392] system 00:09: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.696394] system 00:09: [mem 0xf0000000-0xf7ffffff] has been reserved
[    0.696395] system 00:09: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.696397] system 00:09: [mem 0xfed90000-0xfed93fff] could not be reser=
ved
[    0.696399] system 00:09: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.696401] system 00:09: [mem 0xff000000-0xffffffff] has been reserved
[    0.696403] system 00:09: [mem 0xfee00000-0xfeefffff] has been reserved
[    0.696405] system 00:09: [mem 0xeffe0000-0xefffffff] has been reserved
[    0.696408] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (active=
)
[    0.696817] system 00:0a: [mem 0x00000000-0x0009ffff] could not be reser=
ved
[    0.696819] system 00:0a: [mem 0x000f0000-0x000fffff] could not be reser=
ved
[    0.696821] system 00:0a: [mem 0x00100000-0x5f7fffff] could not be reser=
ved
[    0.696823] system 00:0a: [mem 0xfec00000-0xfed3ffff] could not be reser=
ved
[    0.696825] system 00:0a: [mem 0xfed4c000-0xffffffff] could not be reser=
ved
[    0.696827] system 00:0a: Plug and Play ACPI device, IDs PNP0c01 (active=
)
[    0.697002] pnp: PnP ACPI: found 11 devices
[    0.705826] clocksource: acpi_pm: mask: 0xffffff max_cycles:
0xffffff, max_idle_ns: 2085701024 ns
[    0.705882] pci 0000:00:1d.0: bridge window [io  0x1000-0x0fff] to
[bus 06-70] add_size 1000
[    0.705889] pci 0000:00:1d.0: BAR 13: assigned [io  0x2000-0x2fff]
[    0.705892] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.705904] pci 0000:00:1c.0:   bridge window [mem 0xec200000-0xec2fffff=
]
[    0.705915] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    0.705922] pci 0000:00:1c.2:   bridge window [mem 0xec100000-0xec1fffff=
]
[    0.705932] pci 0000:00:1c.4: PCI bridge to [bus 05]
[    0.705947] pci 0000:00:1c.4:   bridge window [mem 0xec000000-0xec0fffff=
]
[    0.705957] pci 0000:00:1d.0: PCI bridge to [bus 06-70]
[    0.705963] pci 0000:00:1d.0:   bridge window [io  0x2000-0x2fff]
[    0.705968] pci 0000:00:1d.0:   bridge window [mem 0xbc000000-0xea0fffff=
]
[    0.705975] pci 0000:00:1d.0:   bridge window [mem
0x70000000-0xb9ffffff 64bit pref]
[    0.705984] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.705986] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.705988] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff windo=
w]
[    0.705989] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000c3fff windo=
w]
[    0.705991] pci_bus 0000:00: resource 8 [mem 0x000c4000-0x000c7fff windo=
w]
[    0.705992] pci_bus 0000:00: resource 9 [mem 0x000c8000-0x000cbfff windo=
w]
[    0.705994] pci_bus 0000:00: resource 10 [mem 0x000cc000-0x000cffff wind=
ow]
[    0.705995] pci_bus 0000:00: resource 11 [mem 0x000d0000-0x000d3fff wind=
ow]
[    0.705997] pci_bus 0000:00: resource 12 [mem 0x000d4000-0x000d7fff wind=
ow]
[    0.705998] pci_bus 0000:00: resource 13 [mem 0x000d8000-0x000dbfff wind=
ow]
[    0.706000] pci_bus 0000:00: resource 14 [mem 0x000dc000-0x000dffff wind=
ow]
[    0.706001] pci_bus 0000:00: resource 15 [mem 0x000e0000-0x000e3fff wind=
ow]
[    0.706003] pci_bus 0000:00: resource 16 [mem 0x000e4000-0x000e7fff wind=
ow]
[    0.706004] pci_bus 0000:00: resource 17 [mem 0x000e8000-0x000ebfff wind=
ow]
[    0.706006] pci_bus 0000:00: resource 18 [mem 0x000ec000-0x000effff wind=
ow]
[    0.706007] pci_bus 0000:00: resource 19 [mem 0x000f0000-0x000fffff wind=
ow]
[    0.706009] pci_bus 0000:00: resource 20 [mem 0x5f800000-0xefffffff wind=
ow]
[    0.706010] pci_bus 0000:00: resource 21 [mem 0xfd000000-0xfe7fffff wind=
ow]
[    0.706012] pci_bus 0000:02: resource 1 [mem 0xec200000-0xec2fffff]
[    0.706014] pci_bus 0000:04: resource 1 [mem 0xec100000-0xec1fffff]
[    0.706016] pci_bus 0000:05: resource 1 [mem 0xec000000-0xec0fffff]
[    0.706017] pci_bus 0000:06: resource 0 [io  0x2000-0x2fff]
[    0.706019] pci_bus 0000:06: resource 1 [mem 0xbc000000-0xea0fffff]
[    0.706020] pci_bus 0000:06: resource 2 [mem 0x70000000-0xb9ffffff
64bit pref]
[    0.706264] NET: Registered protocol family 2
[    0.706501] TCP established hash table entries: 131072 (order: 8,
1048576 bytes)
[    0.706779] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.706939] TCP: Hash tables configured (established 131072 bind 65536)
[    0.706997] UDP hash table entries: 8192 (order: 6, 262144 bytes)
[    0.707060] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes)
[    0.707153] NET: Registered protocol family 1
[    0.707173] pci 0000:00:02.0: Video device with shadowed ROM at
[mem 0x000c0000-0x000dffff]
[    0.708190] PCI: CLS 0 bytes, default 64
[    0.708233] Unpacking initramfs...
[    0.985445] Freeing initrd memory: 12236K
[    0.985496] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.985499] software IO TLB [mem 0x47081000-0x4b081000] (64MB)
mapped at [ffff880047081000-ffff88004b080fff]
[    0.985703] clocksource: tsc: mask: 0xffffffffffffffff max_cycles:
0x29dc05e54fc, max_idle_ns: 440795291716 ns
[    0.985871] Scanning for low memory corruption every 60 seconds
[    0.986684] Initialise system trusted keyrings
[    0.986808] workingset: timestamp_bits=3D40 max_order=3D22 bucket_order=
=3D0
[    0.988169] zbud: loaded
[    0.989677] Key type asymmetric registered
[    0.989694] Block layer SCSI generic (bsg) driver version 0.4
loaded (major 248)
[    0.989756] io scheduler noop registered
[    0.989757] io scheduler deadline registered
[    0.989794] io scheduler cfq registered (default)
[    0.989795] io scheduler mq-deadline registered
[    0.989796] io scheduler kyber registered
[    0.990889] efifb: probing for efifb
[    0.990905] efifb: framebuffer at 0x60000000, using 8100k, total 8100k
[    0.990906] efifb: mode is 1920x1080x32, linelength=3D7680, pages=3D1
[    0.990907] efifb: scrolling: redraw
[    0.990909] efifb: Truecolor: size=3D8:8:8:8, shift=3D24:16:8:0
[    0.997036] Console: switching to colour frame buffer device 240x67
[    1.002991] fb0: EFI VGA frame buffer device
[    1.003000] intel_idle: MWAIT substates: 0x11142120
[    1.003001] intel_idle: v0.4.1 model 0x8E
[    1.003307] intel_idle: lapic_timer_reliable_states 0xffffffff
[    1.004189] GHES: HEST is not enabled!
[    1.004283] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.004943] Linux agpgart interface v0.103
[    1.005363] rtc_cmos 00:03: RTC can wake from S4
[    1.005778] rtc_cmos 00:03: rtc core: registered rtc_cmos as rtc0
[    1.005879] rtc_cmos 00:03: alarms up to one month, y3k, 242 bytes
nvram, hpet irqs
[    1.005902] intel_pstate: Intel P-state driver initializing
[    1.006475] intel_pstate: HWP enabled
[    1.006692] ledtrig-cpu: registered to indicate activity on CPUs
[    1.006724] intel_pmc_core 0000:00:1f.2: enabling device (0000 -> 0002)
[    1.006891] NET: Registered protocol family 10
[    1.009380] Segment Routing with IPv6
[    1.009420] NET: Registered protocol family 17
[    1.009662] microcode: sig=3D0x806e9, pf=3D0x80, revision=3D0x5e
[    1.009736] microcode: Microcode Update Driver: v2.2.
[    1.009877] registered taskstats version 1
[    1.009882] Loading compiled-in X.509 certificates
[    1.009891] zswap: loaded using pool lzo/zbud
[    1.011279]   Magic number: 5:420:71
[    1.011333] memory memory99: hash matches
[    1.011481] rtc_cmos 00:03: setting system clock to 2017-06-26
09:05:04 UTC (1498467904)
[    1.011504] PM: Hibernation image not present or could not be loaded.
[    1.012310] Freeing unused kernel memory: 1340K
[    1.012311] Write protecting the kernel read-only data: 10240k
[    1.012651] Freeing unused kernel memory: 1752K
[    1.012745] Freeing unused kernel memory: 32K
[    1.073136] random: systemd-tmpfile: uninitialized urandom read (16
bytes read)
[    1.073196] random: systemd-tmpfile: uninitialized urandom read (16
bytes read)
[    1.074309] random: systemd-udevd: uninitialized urandom read (16 bytes =
read)
[    1.074339] random: systemd-udevd: uninitialized urandom read (16 bytes =
read)
[    1.074343] random: systemd-udevd: uninitialized urandom read (16 bytes =
read)
[    1.074792] random: udevadm: uninitialized urandom read (16 bytes read)
[    1.074802] random: udevadm: uninitialized urandom read (16 bytes read)
[    1.076311] random: systemd-udevd: uninitialized urandom read (16 bytes =
read)
[    1.076320] random: systemd-udevd: uninitialized urandom read (16 bytes =
read)
[    1.076323] random: systemd-udevd: uninitialized urandom read (16 bytes =
read)
[    1.101835] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU]
at 0x60,0x64 irq 1,12
[    1.104062] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.104090] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.114055] ACPI: bus type USB registered
[    1.114084] usbcore: registered new interface driver usbfs
[    1.114090] rtsx_pci 0000:02:00.0: enabling device (0000 -> 0002)
[    1.114091] usbcore: registered new interface driver hub
[    1.114110] usbcore: registered new device driver usb
[    1.115119] nvme nvme0: pci function 0000:05:00.0
[    1.116024] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.116027] xhci_hcd 0000:00:14.0: new USB bus registered, assigned
bus number 1
[    1.117184] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci
version 0x100 quirks 0x00109810
[    1.117189] xhci_hcd 0000:00:14.0: cache line size of 64 is not supporte=
d
[    1.117370] hub 1-0:1.0: USB hub found
[    1.117393] hub 1-0:1.0: 12 ports detected
[    1.120120] AVX2 version of gcm_enc/dec engaged.
[    1.120120] AES CTR mode by8 optimization enabled
[    1.124632] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.124636] xhci_hcd 0000:00:14.0: new USB bus registered, assigned
bus number 2
[    1.124775] hub 2-0:1.0: USB hub found
[    1.124796] hub 2-0:1.0: 6 ports detected
[    1.125782] usb: port power management may be unreliable
[    1.139462] input: AT Translated Set 2 keyboard as
/devices/platform/i8042/serio0/input/input0
[    1.151013] device-mapper: uevent: version 1.0.3
[    1.151086] device-mapper: ioctl: 4.35.0-ioctl (2016-06-23)
initialised: dm-devel@redhat.com
[    1.362257]  nvme0n1: p1 p2 p3 p4
[    1.502838] usb 1-6: new high-speed USB device number 2 using xhci_hcd
[    1.693099] usb 1-6: config 1 has an invalid interface number: 12
but max is 1
[    1.693103] usb 1-6: config 1 has an invalid interface number: 13
but max is 1
[    1.693105] usb 1-6: config 1 has an invalid interface number: 13
but max is 1
[    1.693108] usb 1-6: config 1 has no interface number 0
[    1.693110] usb 1-6: config 1 has no interface number 1
[    1.862967] usb 1-7: new full-speed USB device number 3 using xhci_hcd
[    1.999923] clocksource: Switched to clocksource tsc
[    2.219603] usb 1-8: new high-speed USB device number 4 using xhci_hcd
[    2.586264] usb 1-9: new full-speed USB device number 5 using xhci_hcd
[    6.494108] NET: Registered protocol family 38
[    6.769168] random: fast init done
[    6.798865] EXT4-fs (dm-0): mounted filesystem with ordered data
mode. Opts: (null)
[    6.871234] ip_tables: (C) 2000-2006 Netfilter Core Team
[    6.877635] systemd[1]: systemd 233 running in system mode. (+PAM
-AUDIT -SELINUX -IMA -APPARMOR +SMACK -SYSVINIT +UTMP +LIBCRYPTSETUP
+GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN
default-hierarchy=3Dhybrid)
[    6.877839] systemd[1]: Detected architecture x86-64.
[    6.878379] systemd[1]: Set hostname to <cambrian>.
[    6.956705] systemd[1]: Listening on LVM2 metadata daemon socket.
[    6.956797] systemd[1]: Listening on udev Control Socket.
[    6.956860] systemd[1]: Started Dispatch Password Requests to
Console Directory Watch.
[    6.957748] systemd[1]: Set up automount boot.automount.
[    6.957787] systemd[1]: Listening on udev Kernel Socket.
[    6.957833] systemd[1]: Listening on Journal Socket (/dev/log).
[    6.957872] systemd[1]: Listening on /dev/initctl Compatibility Named Pi=
pe.
[    6.976343] usbip_core: USB/IP Core v1.0.0
[    6.977538] EXT4-fs (dm-0): re-mounted. Opts: data=3Dordered,discard
[    6.977750] usbcore: registered new device driver usbip-host
[    6.977752] usbip_host: USB/IP Host Driver v1.0.0
[    7.012547] systemd-journald[230]: Received request to flush
runtime journal from PID 1
[    7.114115] random: crng init done
[    7.216346] thermal LNXTHERM:00: registered as thermal_zone0
[    7.216349] ACPI: Thermal Zone [THM0] (51 C)
[    7.221695] hidraw: raw HID events driver (C) Jiri Kosina
[    7.249576] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0x1B, rev-id 16)
[    7.250308] Bluetooth: Core ver 2.22
[    7.250321] NET: Registered protocol family 31
[    7.250321] Bluetooth: HCI device and connection manager initialized
[    7.250324] Bluetooth: HCI socket layer initialized
[    7.250326] Bluetooth: L2CAP socket layer initialized
[    7.250330] Bluetooth: SCO socket layer initialized
[    7.256074] ACPI: AC Adapter [AC] (off-line)
[    7.256354] Bluetooth: HCI UART driver ver 2.3
[    7.256355] Bluetooth: HCI UART protocol H4 registered
[    7.256356] Bluetooth: HCI UART protocol BCSP registered
[    7.256367] Bluetooth: HCI UART protocol LL registered
[    7.256367] Bluetooth: HCI UART protocol ATH3K registered
[    7.256368] Bluetooth: HCI UART protocol Three-wire (H5) registered
[    7.256389] Bluetooth: HCI UART protocol Intel registered
[    7.256399] Bluetooth: HCI UART protocol Broadcom registered
[    7.256400] Bluetooth: HCI UART protocol QCA registered
[    7.256400] Bluetooth: HCI UART protocol AG6XX registered
[    7.256401] Bluetooth: HCI UART protocol Marvell registered
[    7.262271] Non-volatile memory driver v1.3
[    7.269064] ACPI: Battery Slot [BAT0] (battery present)
[    7.276667] thinkpad_acpi: ThinkPad ACPI Extras v0.25
[    7.276667] thinkpad_acpi: http://ibm-acpi.sf.net/
[    7.276668] thinkpad_acpi: ThinkPad BIOS N1MET35W (1.20 ), EC unknown
[    7.276669] thinkpad_acpi: Lenovo ThinkPad X1 Carbon 5th, model 20HQS0LV=
00
[    7.276947] thinkpad_acpi: radio switch found; radios are enabled
[    7.277128] thinkpad_acpi: This ThinkPad has standard ACPI
backlight brightness control, supported by the ACPI video driver
[    7.277128] thinkpad_acpi: Disabling thinkpad-acpi brightness
events by default...
[    7.278785] thinkpad_acpi: rfkill switch tpacpi_bluetooth_sw: radio
is unblocked
[    7.280148] thinkpad_acpi: rfkill switch tpacpi_wwan_sw: radio is unbloc=
ked
[    7.282953] thinkpad_acpi: Standard ACPI backlight interface
available, not loading native one
[    7.285001] input: ThinkPad Extra Buttons as
/devices/platform/thinkpad_acpi/input/input2
[    7.828293] input: Sleep Button as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input3
[    7.828304] ACPI: Sleep Button [SLPB]
[    7.828944] input: Lid Switch as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input4
[    7.829268] ACPI: Lid Switch [LID]
[    7.829371] input: Power Button as
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input5
[    7.829377] ACPI: Power Button [PWRF]
[    7.830266] wmi: Mapper loaded
[    7.844085] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    7.846164] mei_me 0000:00:16.0: enabling device (0000 -> 0002)
[    7.859963] i801_smbus 0000:00:1f.4: enabling device (0000 -> 0003)
[    7.860110] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[    7.860156] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    7.872899] usbcore: registered new interface driver btusb
[    7.874058] Bluetooth: hci0: Firmware revision 0.1 build 103 week 50 201=
6
[    7.889186] pps_core: LinuxPPS API ver. 1 registered
[    7.889187] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
Rodolfo Giometti <giometti@linux.it>
[    7.889971] PTP clock support registered
[    7.889986] media: Linux media interface: v0.10
[    7.896329] usbcore: registered new interface driver usbserial
[    7.896337] usbcore: registered new interface driver usbserial_generic
[    7.896343] usbserial: USB Serial support registered for generic
[    7.896943] usbcore: registered new interface driver cdc_ncm
[    7.897564] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    7.897565] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    7.897810] e1000e 0000:00:1f.6: Interrupt Throttling Rate
(ints/sec) set to dynamic conservative mode
[    7.898465] usbcore: registered new interface driver cdc_wdm
[    7.898588] Linux video capture interface: v2.00
[    7.902458] usbcore: registered new interface driver qcserial
[    7.903998] usbserial: USB Serial support registered for Qualcomm USB mo=
dem
[    7.909291] Intel(R) Wireless WiFi driver for Linux
[    7.909293] Copyright(c) 2003- 2015 Intel Corporation
[    7.909944] iwlwifi 0000:04:00.0: enabling device (0000 -> 0002)
[    7.916125] RAPL PMU: API unit is 2^-32 Joules, 5 fixed counters,
655360 ms ovfl timer
[    7.916141] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    7.916141] RAPL PMU: hw unit of domain package 2^-14 Joules
[    7.916142] RAPL PMU: hw unit of domain dram 2^-14 Joules
[    7.916142] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[    7.916143] RAPL PMU: hw unit of domain psys 2^-14 Joules
[    7.916308] iwlwifi 0000:04:00.0: Direct firmware load for
iwlwifi-8265-30.ucode failed with error -2
[    7.916324] iwlwifi 0000:04:00.0: Direct firmware load for
iwlwifi-8265-29.ucode failed with error -2
[    7.916343] iwlwifi 0000:04:00.0: Direct firmware load for
iwlwifi-8265-28.ucode failed with error -2
[    7.921046] iwlwifi 0000:04:00.0: capa flags index 3 larger than
supported by driver
[    7.921647] iwlwifi 0000:04:00.0: loaded firmware version
27.455470.0 op_mode iwlmvm
[    7.926958] cdc_mbim 1-6:1.12: cdc-wdm0: USB WDM device
[    7.927093] cdc_mbim 1-6:1.12 wwan0: register 'cdc_mbim' at
usb-0000:00:14.0-6, CDC MBIM, 1a:fc:6b:bc:22:68
[    7.927117] usbcore: registered new interface driver cdc_mbim
[    7.936370] uvcvideo: Found UVC 1.00 device Integrated Camera (04f2:b5ce=
)
[    7.951536] uvcvideo 1-8:1.0: Entity type for entity Extension 4
was not initialized!
[    7.951538] uvcvideo 1-8:1.0: Entity type for entity Extension 3
was not initialized!
[    7.951539] uvcvideo 1-8:1.0: Entity type for entity Processing 2
was not initialized!
[    7.951540] uvcvideo 1-8:1.0: Entity type for entity Camera 1 was
not initialized!
[    7.951597] input: Integrated Camera as
/devices/pci0000:00/0000:00:14.0/usb1/1-8/1-8:1.0/input/input7
[    7.951650] usbcore: registered new interface driver uvcvideo
[    7.951651] USB Video Class driver (1.1.1)
[    7.975906] intel_rapl: Found RAPL domain package
[    7.975908] intel_rapl: Found RAPL domain core
[    7.975908] intel_rapl: Found RAPL domain uncore
[    7.975909] intel_rapl: Found RAPL domain dram
[    7.978761] iwlwifi 0000:04:00.0: Detected Intel(R) Dual Band
Wireless AC 8265, REV=3D0x230
[    7.981171] iwlwifi 0000:04:00.0: L1 Enabled - LTR Enabled
[    7.982129] iwlwifi 0000:04:00.0: L1 Enabled - LTR Enabled
[    8.052350] iTCO_vendor_support: vendor-support=3D0
[    8.055375] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[    8.055527] iTCO_wdt: Found a Intel PCH TCO device (Version=3D4,
TCOBASE=3D0x0400)
[    8.057172] iTCO_wdt: initialized. heartbeat=3D30 sec (nowayout=3D0)
[    8.074159] cdc_mbim 1-6:1.12 wwp0s20f0u6i12: renamed from wwan0
[    8.107448] Adding 8388604k swap on /dev/mapper/swap.  Priority:-1
extents:1 across:8388604k SSFS
[    8.123433] ieee80211 phy0: Selected rate control algorithm 'iwl-mvm-rs'
[    8.123663] thermal thermal_zone3: failed to read out thermal zone (-5)
[    8.125372] iwlwifi 0000:04:00.0 wlp4s0: renamed from wlan0
[    8.172837] input: PC Speaker as /devices/platform/pcspkr/input/input8
[    8.185828] e1000e 0000:00:1f.6 0000:00:1f.6 (uninitialized):
registered PHC clock
[    8.269609] e1000e 0000:00:1f.6 eth0: (PCI Express:2.5GT/s:Width
x1) c8:5b:76:fd:3f:25
[    8.269613] e1000e 0000:00:1f.6 eth0: Intel(R) PRO/1000 Network Connecti=
on
[    8.269686] e1000e 0000:00:1f.6 eth0: MAC: 12, PHY: 12, PBA No: 1000FF-0=
FF
[    8.270448] i915 0000:00:02.0: enabling device (0006 -> 0007)
[    8.272826] [drm] Memory usable by graphics device =3D 4096M
[    8.272828] checking generic (60000000 7e9000) vs hw (60000000 10000000)
[    8.272829] fb: switching to inteldrmfb from EFI VGA
[    8.272847] Console: switching to colour dummy device 80x25
[    8.272913] [drm] Replacing VGA console driver
[    8.274096] e1000e 0000:00:1f.6 enp0s31f6: renamed from eth0
[    8.278152] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    8.278154] [drm] Driver supports precise vblank timestamp query.
[    8.285306] i915 0000:00:02.0: vgaarb: changed VGA decodes:
olddecodes=3Dio+mem,decodes=3Dio+mem:owns=3Dmem
[    8.287670] [drm] Finished loading DMC firmware
i915/kbl_dmc_ver1_01.bin (v1.1)
[    8.291619] [drm] Initialized i915 1.6.0 20170403 for 0000:00:02.0 on mi=
nor 0
[    8.293390] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: n=
o)
[    8.293537] input: Video Bus as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input9
[    8.293682] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops
i915_audio_component_bind_ops [i915])
[    8.305771] fbcon: inteldrmfb (fb0) is primary device
[    8.315343] snd_hda_codec_conexant hdaudioC0D0: CX8200: BIOS auto-probin=
g.
[    8.315850] snd_hda_codec_conexant hdaudioC0D0: autoconfig for
CX8200: line_outs=3D1 (0x17/0x0/0x0/0x0/0x0) type:speaker
[    8.315851] snd_hda_codec_conexant hdaudioC0D0:    speaker_outs=3D0
(0x0/0x0/0x0/0x0/0x0)
[    8.315852] snd_hda_codec_conexant hdaudioC0D0:    hp_outs=3D1
(0x16/0x0/0x0/0x0/0x0)
[    8.315853] snd_hda_codec_conexant hdaudioC0D0:    mono: mono_out=3D0x0
[    8.315854] snd_hda_codec_conexant hdaudioC0D0:    inputs:
[    8.315855] snd_hda_codec_conexant hdaudioC0D0:      Internal Mic=3D0x1a
[    8.315856] snd_hda_codec_conexant hdaudioC0D0:      Mic=3D0x19
[    8.316813] snd_hda_codec_conexant hdaudioC0D0: Enable sync_write
for stable communication
[    8.327363] input: HDA Digital PCBeep as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input10
[    8.327926] input: HDA Intel PCH Mic as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input11
[    8.327964] input: HDA Intel PCH Headphone as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input12
[    8.328000] input: HDA Intel PCH HDMI/DP,pcm=3D3 as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input13
[    8.328040] input: HDA Intel PCH HDMI/DP,pcm=3D7 as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input14
[    8.328077] input: HDA Intel PCH HDMI/DP,pcm=3D8 as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input15
[    8.328111] input: HDA Intel PCH HDMI/DP,pcm=3D9 as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input16
[    8.328145] input: HDA Intel PCH HDMI/DP,pcm=3D10 as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input17
[    8.674479] psmouse serio1: synaptics: queried max coordinates: x
[..5676], y [..4760]
[    8.704311] psmouse serio1: synaptics: queried min coordinates: x
[1266..], y [1094..]
[    8.704315] psmouse serio1: synaptics: Trying to set up SMBus access
[    8.711483] rmi4_smbus 0-002c: registering SMbus-connected sensor
[    8.764038] rmi4_f01 rmi4-00.fn01: found RMI device, manufacturer:
Synaptics, product: TM3289-002, fw id: 2492434
[    8.825158] input: Synaptics TM3289-002 as /devices/rmi4-00/input/input1=
8
[    8.827968] mousedev: PS/2 mouse device common for all mice
[    9.333261] [drm] RC6 on
[    9.464910] Console: switching to colour frame buffer device 240x67
[    9.486298] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
[   12.760153] EXT4-fs (dm-2): mounted filesystem with ordered data
mode. Opts: data=3Dordered,discard
[   12.950582] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   12.950583] Bluetooth: BNEP filters: protocol multicast
[   12.950586] Bluetooth: BNEP socket layer initialized
[   13.148737] IPv6: ADDRCONF(NETDEV_UP): enp0s31f6: link is not ready
[   13.363200] IPv6: ADDRCONF(NETDEV_UP): enp0s31f6: link is not ready
[   13.370282] IPv6: ADDRCONF(NETDEV_UP): wlp4s0: link is not ready
[   13.372674] iwlwifi 0000:04:00.0: L1 Enabled - LTR Enabled
[   13.373204] iwlwifi 0000:04:00.0: L1 Enabled - LTR Enabled
[   13.490158] iwlwifi 0000:04:00.0: L1 Enabled - LTR Enabled
[   13.490755] iwlwifi 0000:04:00.0: L1 Enabled - LTR Enabled
[   13.570096] IPv6: ADDRCONF(NETDEV_UP): wlp4s0: link is not ready
[   13.578635] iwlwifi 0000:04:00.0: L1 Enabled - LTR Enabled
[   13.579769] iwlwifi 0000:04:00.0: L1 Enabled - LTR Enabled
[   13.695047] iwlwifi 0000:04:00.0: L1 Enabled - LTR Enabled
[   13.695596] iwlwifi 0000:04:00.0: L1 Enabled - LTR Enabled
[   13.774872] IPv6: ADDRCONF(NETDEV_UP): wlp4s0: link is not ready
[   13.855549] IPv6: ADDRCONF(NETDEV_UP): wlp4s0: link is not ready
[   15.372101] thinkpad_acpi: unknown possible thermal alarm or
keyboard event received
[   15.372106] thinkpad_acpi: unhandled HKEY event 0x60b0
[   15.372108] thinkpad_acpi: please report the conditions when this
event happened to ibm-acpi-devel@lists.sourceforge.net
[   17.302993] IPv6: ADDRCONF(NETDEV_UP): wlp4s0: link is not ready
[   17.306313] IPv6: ADDRCONF(NETDEV_UP): wlp4s0: link is not ready
[   17.313075] IPv6: ADDRCONF(NETDEV_UP): wlp4s0: link is not ready
[   18.051667] Bluetooth: RFCOMM TTY layer initialized
[   18.051671] Bluetooth: RFCOMM socket layer initialized
[   18.051674] Bluetooth: RFCOMM ver 1.11
[   18.897816] thinkpad_acpi: unknown possible thermal alarm or
keyboard event received
[   18.897818] thinkpad_acpi: unhandled HKEY event 0x60b1
[   18.897819] thinkpad_acpi: please report the conditions when this
event happened to ibm-acpi-devel@lists.sourceforge.net
[   19.269612] IPv6: ADDRCONF(NETDEV_UP): wlp4s0: link is not ready
[   21.411918] wlp4s0: authenticate with 00:01:38:a4:90:58
[   21.420640] wlp4s0: send auth to 00:01:38:a4:90:58 (try 1/3)
[   21.450859] wlp4s0: authenticated
[   21.452851] wlp4s0: associate with 00:01:38:a4:90:58 (try 1/3)
[   21.482861] wlp4s0: RX AssocResp from 00:01:38:a4:90:58
(capab=3D0x421 status=3D0 aid=3D3)
[   21.513448] wlp4s0: associated
[   21.513549] IPv6: ADDRCONF(NETDEV_CHANGE): wlp4s0: link becomes ready
[   38.461301] thinkpad_acpi: unknown possible thermal alarm or
keyboard event received
[   38.461305] thinkpad_acpi: unhandled HKEY event 0x60b0
[   38.461307] thinkpad_acpi: please report the conditions when this
event happened to ibm-acpi-devel@lists.sourceforge.net
[   41.669255] thinkpad_acpi: unknown possible thermal alarm or
keyboard event received
[   41.669260] thinkpad_acpi: unhandled HKEY event 0x60b1
[   41.669262] thinkpad_acpi: please report the conditions when this
event happened to ibm-acpi-devel@lists.sourceforge.net
[   98.489423] thinkpad_acpi: unknown possible thermal alarm or
keyboard event received
[   98.489427] thinkpad_acpi: unhandled HKEY event 0x60b0
[   98.489429] thinkpad_acpi: please report the conditions when this
event happened to ibm-acpi-devel@lists.sourceforge.net
[  106.567957] thinkpad_acpi: unknown possible thermal alarm or
keyboard event received
[  106.567962] thinkpad_acpi: unhandled HKEY event 0x60b1
[  106.567963] thinkpad_acpi: please report the conditions when this
event happened to ibm-acpi-devel@lists.sourceforge.net
[  155.973901] input: ImPS/2 Generic Wheel Mouse as
/devices/rmi4-00/rmi4-00.fn03/serio2/input/input20
[  253.389646] thinkpad_acpi: unknown possible thermal alarm or
keyboard event received
[  253.389653] thinkpad_acpi: unhandled HKEY event 0x60b0
[  253.389655] thinkpad_acpi: please report the conditions when this
event happened to ibm-acpi-devel@lists.sourceforge.net
[  256.262063] CPU0: Core temperature above threshold, cpu clock
throttled (total events =3D 1)
[  256.262063] CPU2: Core temperature above threshold, cpu clock
throttled (total events =3D 1)
[  256.262064] CPU3: Package temperature above threshold, cpu clock
throttled (total events =3D 1)
[  256.262065] CPU1: Package temperature above threshold, cpu clock
throttled (total events =3D 1)
[  256.262067] CPU2: Package temperature above threshold, cpu clock
throttled (total events =3D 1)
[  256.262071] CPU0: Package temperature above threshold, cpu clock
throttled (total events =3D 1)
[  256.263068] CPU2: Core temperature/speed normal
[  256.263068] CPU1: Package temperature/speed normal
[  256.263069] CPU0: Core temperature/speed normal
[  256.263070] CPU3: Package temperature/speed normal
[  256.263070] CPU0: Package temperature/speed normal
[  256.263071] CPU2: Package temperature/speed normal
[  258.420774] thinkpad_acpi: unknown possible thermal alarm or
keyboard event received
[  258.420779] thinkpad_acpi: unhandled HKEY event 0x60b1
[  258.420781] thinkpad_acpi: please report the conditions when this
event happened to ibm-acpi-devel@lists.sourceforge.net
[  296.806410] thinkpad_acpi: unknown possible thermal alarm or
keyboard event received
[  296.806415] thinkpad_acpi: unhandled HKEY event 0x60b0
[  296.806418] thinkpad_acpi: please report the conditions when this
event happened to ibm-acpi-devel@lists.sourceforge.net
[  297.194775] thinkpad_acpi: unknown possible thermal alarm or
keyboard event received
[  297.194780] thinkpad_acpi: unhandled HKEY event 0x60b1
[  297.194783] thinkpad_acpi: please report the conditions when this
event happened to ibm-acpi-devel@lists.sourceforge.net
[  297.772645] thinkpad_acpi: unknown possible thermal alarm or
keyboard event received
[  297.772651] thinkpad_acpi: unhandled HKEY event 0x60b0
[  297.772653] thinkpad_acpi: please report the conditions when this
event happened to ibm-acpi-devel@lists.sourceforge.net
[  301.757720] thinkpad_acpi: unknown possible thermal alarm or
keyboard event received
[  301.757726] thinkpad_acpi: unhandled HKEY event 0x60b1
[  301.757729] thinkpad_acpi: please report the conditions when this
event happened to ibm-acpi-devel@lists.sourceforge.net

--=20
damjan
