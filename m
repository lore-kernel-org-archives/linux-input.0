From: Egor Starkov <eastarkov@gmail.com>
Subject: Re: [Asus K501UW] Focaltech touchpad detected as mouse
Date: Mon, 12 Sep 2016 16:07:21 -0500
Message-ID: <CAAm8XAZWSOfWpTJybqD9HWbkeyb_6Y9_PSpPhfu6gTJoAJqmgg@mail.gmail.com>
References: <CAAm8XAZ4mX77jyQ3DVi8c3w=HJkqDfJYkrcmcOQjUgFJJn-+TA@mail.gmail.com>
 <20160912192357.wg3xbzj46mrtoexs@lantern>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:33117 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932266AbcILVH3 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 12 Sep 2016 17:07:29 -0400
Received: by mail-oi0-f44.google.com with SMTP id y2so336422646oie.0
        for <linux-input@vger.kernel.org>; Mon, 12 Sep 2016 14:07:23 -0700 (PDT)
In-Reply-To: <20160912192357.wg3xbzj46mrtoexs@lantern>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: ulrik.debie-os@e2big.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Hi Ulrik,

1) firmware_id:
PNP: ATK3001 PNP030b

2) content of /proc/bus/input/devices (touchpad is the last one;
pasting everything just in case):
I: Bus=0011 Vendor=0001 Product=0001 Version=ab41
N: Name="AT Translated Set 2 keyboard"
P: Phys=isa0060/serio0/input0
S: Sysfs=/devices/platform/i8042/serio0/input/input0
U: Uniq=
H: Handlers=sysrq kbd leds event0
B: PROP=0
B: EV=120013
B: KEY=402000000 3803078f800d001 feffffdfffefffff fffffffffffffffe
B: MSC=10
B: LED=7

I: Bus=0019 Vendor=0000 Product=0005 Version=0000
N: Name="Lid Switch"
P: Phys=PNP0C0D/button/input0
S: Sysfs=/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input1
U: Uniq=
H: Handlers=event1
B: PROP=0
B: EV=21
B: SW=1

I: Bus=0019 Vendor=0000 Product=0003 Version=0000
N: Name="Sleep Button"
P: Phys=PNP0C0E/button/input0
S: Sysfs=/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input2
U: Uniq=
H: Handlers=kbd event2
B: PROP=0
B: EV=3
B: KEY=4000 0 0

I: Bus=0019 Vendor=0000 Product=0001 Version=0000
N: Name="Power Button"
P: Phys=LNXPWRBN/button/input0
S: Sysfs=/devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
U: Uniq=
H: Handlers=kbd event3
B: PROP=0
B: EV=3
B: KEY=10000000000000 0

I: Bus=0019 Vendor=0000 Product=0006 Version=0000
N: Name="Video Bus"
P: Phys=LNXVIDEO/video/input0
S: Sysfs=/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input4
U: Uniq=
H: Handlers=kbd event4
B: PROP=0
B: EV=3
B: KEY=3e000b00000000 0 0 0

I: Bus=0019 Vendor=0000 Product=0006 Version=0000
N: Name="Video Bus"
P: Phys=LNXVIDEO/video/input0
S: Sysfs=/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:22/LNXVIDEO:01/input/input5
U: Uniq=
H: Handlers=kbd event5
B: PROP=0
B: EV=3
B: KEY=3e000b00000000 0 0 0

I: Bus=0003 Vendor=09da Product=054f Version=0111
N: Name="A4TECH USB Device"
P: Phys=usb-0000:00:14.0-2/input0
S: Sysfs=/devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.0/0003:09DA:054F.0001/input/input6
U: Uniq=
H: Handlers=sysrq kbd leds event6 js0
B: PROP=0
B: EV=12001f
B: KEY=3007f 0 0 4c3ffff17aff32d bf54445600000000 c00000000000001
130c130b17c007 ffa67bfad951dfff febeffdfffefffff fffffffffffffffe
B: REL=40
B: ABS=ffffff01000701ff
B: MSC=10
B: LED=1f

I: Bus=0003 Vendor=09da Product=054f Version=0111
N: Name="A4TECH USB Device"
P: Phys=usb-0000:00:14.0-2/input1
S: Sysfs=/devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.1/0003:09DA:054F.0002/input/input7
U: Uniq=
H: Handlers=mouse0 event7
B: PROP=0
B: EV=17
B: KEY=ffff0000 0 0 0 0
B: REL=143
B: MSC=10

I: Bus=0019 Vendor=1043 Product=0000 Version=0000
N: Name="Asus Wireless Radio Control"
P: Phys=asus-wireless/input0
S: Sysfs=/devices/LNXSYSTM:00/LNXSYBUS:00/ATK4002:00/input/input8
U: Uniq=
H: Handlers=kbd event8 rfkill
B: PROP=0
B: EV=3
B: KEY=80000000000000 0 0 0

I: Bus=0001 Vendor=14f1 Product=510f Version=0001
N: Name="HDA Digital PCBeep"
P: Phys=card0/codec#0/beep0
S: Sysfs=/devices/pci0000:00/0000:00:1f.3/sound/card0/input9
U: Uniq=
H: Handlers=kbd event9
B: PROP=0
B: EV=40001
B: SND=6

I: Bus=0000 Vendor=0000 Product=0000 Version=0000
N: Name="HDA Intel PCH Mic"
P: Phys=ALSA
S: Sysfs=/devices/pci0000:00/0000:00:1f.3/sound/card0/input10
U: Uniq=
H: Handlers=event10
B: PROP=0
B: EV=21
B: SW=10

I: Bus=0000 Vendor=0000 Product=0000 Version=0000
N: Name="HDA Intel PCH Headphone"
P: Phys=ALSA
S: Sysfs=/devices/pci0000:00/0000:00:1f.3/sound/card0/input11
U: Uniq=
H: Handlers=event11
B: PROP=0
B: EV=21
B: SW=4

I: Bus=0000 Vendor=0000 Product=0000 Version=0000
N: Name="HDA Intel PCH HDMI/DP,pcm=3"
P: Phys=ALSA
S: Sysfs=/devices/pci0000:00/0000:00:1f.3/sound/card0/input12
U: Uniq=
H: Handlers=event12
B: PROP=0
B: EV=21
B: SW=140

I: Bus=0000 Vendor=0000 Product=0000 Version=0000
N: Name="HDA Intel PCH HDMI/DP,pcm=7"
P: Phys=ALSA
S: Sysfs=/devices/pci0000:00/0000:00:1f.3/sound/card0/input13
U: Uniq=
H: Handlers=event13
B: PROP=0
B: EV=21
B: SW=140

I: Bus=0000 Vendor=0000 Product=0000 Version=0000
N: Name="HDA Intel PCH HDMI/DP,pcm=8"
P: Phys=ALSA
S: Sysfs=/devices/pci0000:00/0000:00:1f.3/sound/card0/input14
U: Uniq=
H: Handlers=event14
B: PROP=0
B: EV=21
B: SW=140

I: Bus=0019 Vendor=0000 Product=0000 Version=0000
N: Name="Asus WMI hotkeys"
P: Phys=asus-nb-wmi/input0
S: Sysfs=/devices/platform/asus-nb-wmi/input/input15
U: Uniq=
H: Handlers=kbd event15 rfkill
B: PROP=0
B: EV=100013
B: KEY=1000000080000 0 800000000000 0 0 a1606f00900000
8200027800501000 e000000000000 0
B: MSC=10

I: Bus=0003 Vendor=0bda Product=57ed Version=0001
N: Name="USB2.0 VGA UVC WebCam"
P: Phys=usb-0000:00:14.0-6/button
S: Sysfs=/devices/pci0000:00/0000:00:14.0/usb1/1-6/1-6:1.0/input/input16
U: Uniq=
H: Handlers=kbd event16
B: PROP=0
B: EV=3
B: KEY=100000 0 0 0

I: Bus=0018 Vendor=0b05 Product=0101 Version=0100
N: Name="FTE1001:00 0B05:0101"
P: Phys=i2c-FTE1001:00
S: Sysfs=/devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-5/i2c-FTE1001:00/0018:0B05:0101.0003/input/input17
U: Uniq=
H: Handlers=mouse1 event17
B: PROP=0
B: EV=17
B: KEY=30000 0 0 0 0
B: REL=103
B: MSC=10


3) dmesg after startup:
[    0.000000] Linux version 4.8.0-040800rc6-generic (kernel@gloin)
(gcc version 6.2.0 20160901 (Ubuntu 6.2.0-3ubuntu11) ) #201609121119
SMP Mon Sep 12 15:21:03 UTC 2016
[    0.000000] Command line:
BOOT_IMAGE=/boot/vmlinuz-4.8.0-040800rc6-generic
root=UUID=826cac6a-2d18-4d8d-a9ee-85299d3cac91 ro quiet splash
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating
point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.000000] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.000000] x86/fpu: Enabled xstate features 0x1f, context size is
960 bytes, using 'compacted' format.
[    0.000000] x86/fpu: Using 'eager' FPU context switches.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000057fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000058000-0x0000000000058fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000059000-0x000000000009dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009e000-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000690cbfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000690cc000-0x00000000690ccfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000690cd000-0x00000000690f6fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000690f7000-0x0000000075207fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000075208000-0x0000000075ee4fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000075ee5000-0x000000007657dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000007657e000-0x000000007711dfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000007711e000-0x0000000077f87fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000077f88000-0x0000000077ffdfff] type 20
[    0.000000] BIOS-e820: [mem 0x0000000077ffe000-0x0000000077ffefff] usable
[    0.000000] BIOS-e820: [mem 0x0000000078000000-0x00000000780fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x0000000281ffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.40 by American Megatrends
[    0.000000] efi:  ESRT=0x77ec7e18  ACPI=0x76682000  ACPI
2.0=0x76682000  SMBIOS=0x776e1000  SMBIOS 3.0=0x776e0000
[    0.000000] esrt: Reserving ESRT space from 0x0000000077ec7e18 to
0x0000000077ec7e50.
[    0.000000] SMBIOS 3.0.0 present.
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x282000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: write-back
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 0080000000 mask 7F80000000 uncachable
[    0.000000]   1 base 007C000000 mask 7FFC000000 uncachable
[    0.000000]   2 base 007A000000 mask 7FFE000000 uncachable
[    0.000000]   3 base 0079000000 mask 7FFF000000 uncachable
[    0.000000]   4 base 0078800000 mask 7FFF800000 uncachable
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000]   8 disabled
[    0.000000]   9 disabled
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- WT
[    0.000000] e820: last_pfn = 0x77fff max_arch_pfn = 0x400000000
[    0.000000] Base memory trampoline at [ffff94b7c0098000] 98000 size 24576
[    0.000000] Using GB pages for direct mapping
[    0.000000] BRK [0x1ea802000, 0x1ea802fff] PGTABLE
[    0.000000] BRK [0x1ea803000, 0x1ea803fff] PGTABLE
[    0.000000] BRK [0x1ea804000, 0x1ea804fff] PGTABLE
[    0.000000] BRK [0x1ea805000, 0x1ea805fff] PGTABLE
[    0.000000] BRK [0x1ea806000, 0x1ea806fff] PGTABLE
[    0.000000] BRK [0x1ea807000, 0x1ea807fff] PGTABLE
[    0.000000] BRK [0x1ea808000, 0x1ea808fff] PGTABLE
[    0.000000] BRK [0x1ea809000, 0x1ea809fff] PGTABLE
[    0.000000] BRK [0x1ea80a000, 0x1ea80afff] PGTABLE
[    0.000000] BRK [0x1ea80b000, 0x1ea80bfff] PGTABLE
[    0.000000] BRK [0x1ea80c000, 0x1ea80cfff] PGTABLE
[    0.000000] RAMDISK: [mem 0x33e50000-0x35f1ffff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x0000000076682000 000024 (v02 _ASUS_)
[    0.000000] ACPI: XSDT 0x00000000766820B0 0000E4 (v01 _ASUS_
Notebook 01072009 AMI  00010013)
[    0.000000] ACPI: FACP 0x00000000766A83B0 00010C (v05 _ASUS_
Notebook 01072009 AMI  00010013)
[    0.000000] ACPI: DSDT 0x0000000076682228 026183 (v02 _ASUS_
Notebook 01072009 INTL 20120913)
[    0.000000] ACPI: FACS 0x000000007711CF80 000040
[    0.000000] ACPI: APIC 0x00000000766A84C0 000084 (v03 _ASUS_
Notebook 01072009 AMI  00010013)
[    0.000000] ACPI: FPDT 0x00000000766A8548 000044 (v01 _ASUS_
Notebook 01072009 AMI  00010013)
[    0.000000] ACPI: FIDT 0x00000000766A8590 00009C (v01 _ASUS_
Notebook 01072009 AMI  00010013)
[    0.000000] ACPI: MCFG 0x00000000766A8630 00003C (v01 _ASUS_
Notebook 01072009 MSFT 00000097)
[    0.000000] ACPI: HPET 0x00000000766A8670 000038 (v01 _ASUS_
Notebook 01072009 AMI. 0005000B)
[    0.000000] ACPI: SSDT 0x00000000766A86A8 000315 (v01 SataRe
SataTabl 00001000 INTL 20120913)
[    0.000000] ACPI: ECDT 0x00000000766A89C0 0000C1 (v01 _ASUS_
Notebook 01072009 AMI. 00000005)
[    0.000000] ACPI: LPIT 0x00000000766A8A88 000094 (v01 INTEL
SKL-ULT  00000000 MSFT 0000005F)
[    0.000000] ACPI: SSDT 0x00000000766A8B20 000248 (v02 INTEL
sensrhub 00000000 INTL 20120913)
[    0.000000] ACPI: DBGP 0x00000000766A8D68 000034 (v01 INTEL
  00000000 MSFT 0000005F)
[    0.000000] ACPI: DBG2 0x00000000766A8DA0 000054 (v00 INTEL
  00000000 MSFT 0000005F)
[    0.000000] ACPI: SSDT 0x00000000766A8DF8 003D5F (v02 DptfTa
DptfTabl 00001000 INTL 20120913)
[    0.000000] ACPI: SSDT 0x00000000766ACB58 005882 (v02 SaSsdt SaSsdt
  00003000 INTL 20120913)
[    0.000000] ACPI: UEFI 0x00000000766B23E0 000042 (v01
  00000000      00000000)
[    0.000000] ACPI: SSDT 0x00000000766B2428 000E73 (v02 CpuRef
CpuSsdt  00003000 INTL 20120913)
[    0.000000] ACPI: BGRT 0x00000000766B32A0 000038 (v01 _ASUS_
Notebook 01072009 AMI  00010013)
[    0.000000] ACPI: SSDT 0x00000000766B32D8 0007B3 (v02 SgRef  SgPch
  00001000 INTL 20120913)
[    0.000000] ACPI: DMAR 0x00000000766B3A90 0000F0 (v01 INTEL  SKL
  00000001 INTL 00000001)
[    0.000000] ACPI: UEFI 0x00000000766B3B80 00063A (v01 INTEL
RstSataE 00000000 ??   00000000)
[    0.000000] ACPI: UEFI 0x00000000766B41C0 00005C (v01 INTEL
RstSataV 00000000 ??   00000000)
[    0.000000] ACPI: TPM2 0x00000000766B4220 000034 (v03
Tpm2Tabl 00000001 AMI  00000000)
[    0.000000] ACPI: SSDT 0x00000000766B4258 001A7D (v01 OptRef
OptTabl  00001000 INTL 20120913)
[    0.000000] ACPI: MSDM 0x0000000075CA6F18 000055 (v03 _ASUS_
Notebook 00000000 ASUS 00000001)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x0000000281ffffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x281ffb000-0x281ffffff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x0000000281ffffff]
[    0.000000]   Device   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x0000000000057fff]
[    0.000000]   node   0: [mem 0x0000000000059000-0x000000000009dfff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x00000000690cbfff]
[    0.000000]   node   0: [mem 0x00000000690f7000-0x0000000075207fff]
[    0.000000]   node   0: [mem 0x0000000075ee5000-0x000000007657dfff]
[    0.000000]   node   0: [mem 0x0000000077ffe000-0x0000000077ffefff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x0000000281ffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x0000000281ffffff]
[    0.000000] On node 0 totalpages: 2062355
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 22 pages reserved
[    0.000000]   DMA zone: 3996 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 7458 pages used for memmap
[    0.000000]   DMA32 zone: 477303 pages, LIFO batch:31
[    0.000000]   Normal zone: 24704 pages used for memmap
[    0.000000]   Normal zone: 1581056 pages, LIFO batch:31
[    0.000000] Reserving Intel graphics memory at
0x0000000079000000-0x000000007cffffff
[    0.000000] ACPI: PM-Timer IO Port: 0x1808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.000000] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x00058000-0x00058fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009e000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0x690cc000-0x690ccfff]
[    0.000000] PM: Registered nosave memory: [mem 0x690cd000-0x690f6fff]
[    0.000000] PM: Registered nosave memory: [mem 0x75208000-0x75ee4fff]
[    0.000000] PM: Registered nosave memory: [mem 0x7657e000-0x7711dfff]
[    0.000000] PM: Registered nosave memory: [mem 0x7711e000-0x77f87fff]
[    0.000000] PM: Registered nosave memory: [mem 0x77f88000-0x77ffdfff]
[    0.000000] PM: Registered nosave memory: [mem 0x77fff000-0x77ffffff]
[    0.000000] PM: Registered nosave memory: [mem 0x78000000-0x780fffff]
[    0.000000] PM: Registered nosave memory: [mem 0x78100000-0x78ffffff]
[    0.000000] PM: Registered nosave memory: [mem 0x79000000-0x7cffffff]
[    0.000000] PM: Registered nosave memory: [mem 0x7d000000-0xdfffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xe0000000-0xefffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xf0000000-0xfdffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfe000000-0xfe010fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfe011000-0xfebfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec01000-0xfedfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee01000-0xfeffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xff000000-0xffffffff]
[    0.000000] e820: [mem 0x7d000000-0xdfffffff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff
max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.000000] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:4
nr_cpu_ids:4 nr_node_ids:1
[    0.000000] percpu: Embedded 35 pages/cpu @ffff94ba41c00000 s102808
r8192 d32360 u524288
[    0.000000] pcpu-alloc: s102808 r8192 d32360 u524288 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.
Total pages: 2030107
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line:
BOOT_IMAGE=/boot/vmlinuz-4.8.0-040800rc6-generic
root=UUID=826cac6a-2d18-4d8d-a9ee-85299d3cac91 ro quiet splash
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 7789260K/8249420K available (6279K kernel code,
1359K rwdata, 2880K rodata, 1528K init, 1180K bss, 460160K reserved,
0K cma-reserved)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] Build-time adjustment of leaf fanout to 64.
[    0.000000] RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=4.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=4
[    0.000000] NR_IRQS:524544 nr_irqs:1024 16
[    0.000000] spurious 8259A interrupt: IRQ7.
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 79635855245 ns
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Detected 2600.000 MHz processor
[    0.000022] Calibrating delay loop (skipped), value calculated
using timer frequency.. 5184.00 BogoMIPS (lpj=10368000)
[    0.000024] pid_max: default: 32768 minimum: 301
[    0.000036] ACPI: Core revision 20160422
[    0.049431] ACPI: 8 ACPI AML tables successfully acquired and loaded

[    0.051137] Security Framework initialized
[    0.051139] Yama: becoming mindful.
[    0.051146] AppArmor: AppArmor initialized
[    0.051504] Dentry cache hash table entries: 1048576 (order: 11,
8388608 bytes)
[    0.053451] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.054337] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.054344] Mountpoint-cache hash table entries: 16384 (order: 5,
131072 bytes)
[    0.054614] CPU: Physical Processor ID: 0
[    0.054615] CPU: Processor Core ID: 0
[    0.054619] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.054619] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[    0.054624] mce: CPU supports 8 MCE banks
[    0.054633] CPU0: Thermal monitoring enabled (TM1)
[    0.054648] process: using mwait in idle threads
[    0.054650] numa_add_cpu cpu 0 node 0: mask now 0
[    0.054652] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[    0.054653] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    0.055516] Freeing SMP alternatives memory: 24K (ffffffff872d3000
- ffffffff872d9000)
[    0.065494] ftrace: allocating 25473 entries in 100 pages
[    0.075624] smpboot: APIC(0) Converting physical 0 to logical package 0
[    0.075625] smpboot: Max logical packages: 2
[    0.075629] DMAR: Host address width 39
[    0.075631] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.075639] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap
1c0000c40660462 ecap 7e3ff0505e
[    0.075640] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.075644] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap
d2008c40660462 ecap f050da
[    0.075645] DMAR: RMRR base: 0x00000075c86000 end: 0x00000075ca5fff
[    0.075646] DMAR: RMRR base: 0x00000078800000 end: 0x0000007cffffff
[    0.075647] DMAR: ANDD device: 1 name: \_SB.PCI0.I2C0
[    0.075648] DMAR: ANDD device: 2 name: \_SB.PCI0.I2C1
[    0.075649] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    0.075650] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.075651] DMAR-IR: x2apic is disabled because BIOS sets x2apic opt out bit.
[    0.075651] DMAR-IR: Use 'intremap=no_x2apic_optout' to override
the BIOS setting.
[    0.077183] DMAR-IR: Enabled IRQ remapping in xapic mode
[    0.077183] x2apic: IRQ remapping doesn't support X2APIC mode
[    0.081131] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.120824] TSC deadline timer enabled
[    0.120829] smpboot: CPU0: Intel(R) Core(TM) i7-6500U CPU @ 2.50GHz
(family: 0x6, model: 0x4e, stepping: 0x3)
[    0.120832] Performance Events: PEBS fmt3+, Skylake events, 32-deep
LBR, full-width counters, Intel PMU driver.
[    0.120861] ... version:                4
[    0.120861] ... bit width:              48
[    0.120862] ... generic registers:      4
[    0.120862] ... value mask:             0000ffffffffffff
[    0.120863] ... max period:             0000ffffffffffff
[    0.120863] ... fixed-purpose events:   3
[    0.120864] ... event mask:             000000070000000f
[    0.121385] NMI watchdog: enabled on all CPUs, permanently consumes
one hw-PMU counter.
[    0.121467] x86: Booting SMP configuration:
[    0.121468] .... node  #0, CPUs:      #1
[    0.121997] numa_add_cpu cpu 1 node 0: mask now 0-1
[    0.203000]  #2
[    0.203539] numa_add_cpu cpu 2 node 0: mask now 0-2
[    0.283033]  #3
[    0.283550] numa_add_cpu cpu 3 node 0: mask now 0-3
[    0.362956] x86: Booted up 1 node, 4 CPUs
[    0.362958] smpboot: Total of 4 processors activated (20739.34 BogoMIPS)
[    0.383329] devtmpfs: initialized
[    0.383386] x86/mm: Memory block size: 128MB
[    0.399234] PM: Registering ACPI NVS region [mem
0x690cc000-0x690ccfff] (4096 bytes)
[    0.399235] PM: Registering ACPI NVS region [mem
0x7657e000-0x7711dfff] (12189696 bytes)
[    0.399489] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.415159] pinctrl core: initialized pinctrl subsystem
[    0.436313] NET: Registered protocol family 16
[    0.451185] cpuidle: using governor ladder
[    0.467206] cpuidle: using governor menu
[    0.467324] ACPI FADT declares the system doesn't support PCIe
ASPM, so disable it
[    0.467325] ACPI: bus type PCI registered
[    0.467326] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.499388] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem
0xe0000000-0xefffffff] (base 0xe0000000)
[    0.499389] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
[    0.499399] PCI: Using configuration type 1 for base access
[    0.515449] HugeTLB registered 1 GB page size, pre-allocated 0 pages
[    0.515450] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.559457] ACPI: Added _OSI(Module Device)
[    0.559458] ACPI: Added _OSI(Processor Device)
[    0.559459] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.559459] ACPI: Added _OSI(Processor Aggregator Device)
[    0.559461] ACPI : EC: EC description table is found, configuring boot EC
[    0.559461] ACPI : EC: EC started
[    0.562258] ACPI Error: [_SB_.PCI0.RP01.PXSX] Namespace lookup
failure, AE_NOT_FOUND (20160422/psargs-359)
[    0.562261] ACPI Error: Method parse/execution failed [\] (Node
ffffffff873e5180), AE_NOT_FOUND (20160422/psparse-542)
[    0.562265] ACPI: Executed 22 blocks of module-level executable AML code
[    0.573782] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.589129] ACPI: Dynamic OEM Table Load:
[    0.589139] ACPI: SSDT 0xFFFF94BA37932800 000660 (v02 PmRef
Cpu0Ist  00003000 INTL 20120913)
[    0.590130] ACPI: \_PR_.CPU0: _OSC native thermal LVT Acked
[    0.591517] ACPI: Dynamic OEM Table Load:
[    0.591521] ACPI: SSDT 0xFFFF94BA37955800 00037F (v02 PmRef
Cpu0Cst  00003001 INTL 20120913)
[    0.593122] ACPI: Dynamic OEM Table Load:
[    0.593126] ACPI: SSDT 0xFFFF94BA37932000 0005AA (v02 PmRef  ApIst
  00003000 INTL 20120913)
[    0.594343] ACPI: Dynamic OEM Table Load:
[    0.594347] ACPI: SSDT 0xFFFF94BA37953E00 000119 (v02 PmRef  ApCst
  00003000 INTL 20120913)
[    0.597214] ACPI : EC: EC stopped
[    0.597368] ACPI : EC: EC started
[    0.597517] ACPI: Interpreter enabled
[    0.597559] ACPI: (supports S0 S3 S4 S5)
[    0.597560] ACPI: Using IOAPIC for interrupt routing
[    0.597596] PCI: Using host bridge windows from ACPI; if necessary,
use "pci=nocrs" and report a bug
[    0.600469] ACPI: Power Resource [WRST] (off)
[    0.600631] ACPI: Power Resource [WRST] (off)
[    0.600792] ACPI: Power Resource [WRST] (off)
[    0.600951] ACPI: Power Resource [WRST] (off)
[    0.601109] ACPI: Power Resource [WRST] (off)
[    0.601159] ACPI: Power Resource [PC09] (on)
[    0.602113] ACPI: Power Resource [WRST] (off)
[    0.602275] ACPI: Power Resource [WRST] (off)
[    0.602434] ACPI: Power Resource [WRST] (off)
[    0.602596] ACPI: Power Resource [WRST] (off)
[    0.602807] ACPI: Power Resource [WRST] (off)
[    0.602995] ACPI: Power Resource [WRST] (off)
[    0.603153] ACPI: Power Resource [WRST] (off)
[    0.603315] ACPI: Power Resource [WRST] (off)
[    0.603475] ACPI: Power Resource [WRST] (off)
[    0.603634] ACPI: Power Resource [WRST] (off)
[    0.603794] ACPI: Power Resource [WRST] (off)
[    0.603953] ACPI: Power Resource [WRST] (off)
[    0.604111] ACPI: Power Resource [WRST] (off)
[    0.604269] ACPI: Power Resource [WRST] (off)
[    0.612682] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
[    0.612687] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM
ClockPM Segments MSI]
[    0.614146] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME
AER PCIeCapability]
[    0.614146] acpi PNP0A08:00: FADT indicates ASPM is unsupported,
using BIOS configuration
[    0.614714] PCI host bridge to bus 0000:00
[    0.614716] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.614717] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.614718] pci_bus 0000:00: root bus resource [mem
0x000a0000-0x000bffff window]
[    0.614719] pci_bus 0000:00: root bus resource [mem
0x000c0000-0x000c3fff window]
[    0.614720] pci_bus 0000:00: root bus resource [mem
0x000c4000-0x000c7fff window]
[    0.614721] pci_bus 0000:00: root bus resource [mem
0x000c8000-0x000cbfff window]
[    0.614721] pci_bus 0000:00: root bus resource [mem
0x000cc000-0x000cffff window]
[    0.614722] pci_bus 0000:00: root bus resource [mem
0x000d0000-0x000d3fff window]
[    0.614723] pci_bus 0000:00: root bus resource [mem
0x000d4000-0x000d7fff window]
[    0.614724] pci_bus 0000:00: root bus resource [mem
0x000d8000-0x000dbfff window]
[    0.614725] pci_bus 0000:00: root bus resource [mem
0x000dc000-0x000dffff window]
[    0.614726] pci_bus 0000:00: root bus resource [mem
0x000e0000-0x000e3fff window]
[    0.614726] pci_bus 0000:00: root bus resource [mem
0x000e4000-0x000e7fff window]
[    0.614727] pci_bus 0000:00: root bus resource [mem
0x000e8000-0x000ebfff window]
[    0.614728] pci_bus 0000:00: root bus resource [mem
0x000ec000-0x000effff window]
[    0.614729] pci_bus 0000:00: root bus resource [mem
0x7d000000-0xdfffffff window]
[    0.614730] pci_bus 0000:00: root bus resource [mem
0xfd000000-0xfe7fffff window]
[    0.614731] pci_bus 0000:00: root bus resource [bus 00-fe]
[    0.614738] pci 0000:00:00.0: [8086:1904] type 00 class 0x060000
[    0.614854] pci 0000:00:02.0: [8086:1916] type 00 class 0x030000
[    0.614863] pci 0000:00:02.0: reg 0x10: [mem 0xdd000000-0xddffffff 64bit]
[    0.614870] pci 0000:00:02.0: reg 0x18: [mem 0xb0000000-0xbfffffff
64bit pref]
[    0.614874] pci 0000:00:02.0: reg 0x20: [io  0xf000-0xf03f]
[    0.615004] pci 0000:00:04.0: [8086:1903] type 00 class 0x118000
[    0.615016] pci 0000:00:04.0: reg 0x10: [mem 0xdf320000-0xdf327fff 64bit]
[    0.615220] pci 0000:00:14.0: [8086:9d2f] type 00 class 0x0c0330
[    0.615239] pci 0000:00:14.0: reg 0x10: [mem 0xdf310000-0xdf31ffff 64bit]
[    0.615315] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.615417] pci 0000:00:14.0: System wakeup disabled by ACPI
[    0.615454] pci 0000:00:14.2: [8086:9d31] type 00 class 0x118000
[    0.615473] pci 0000:00:14.2: reg 0x10: [mem 0xdf338000-0xdf338fff 64bit]
[    0.615720] pci 0000:00:15.0: [8086:9d60] type 00 class 0x118000
[    0.615929] pci 0000:00:15.0: reg 0x10: [mem 0xdf337000-0xdf337fff 64bit]
[    0.616887] pci 0000:00:15.1: [8086:9d61] type 00 class 0x118000
[    0.617096] pci 0000:00:15.1: reg 0x10: [mem 0xdf336000-0xdf336fff 64bit]
[    0.617990] pci 0000:00:16.0: [8086:9d3a] type 00 class 0x078000
[    0.618012] pci 0000:00:16.0: reg 0x10: [mem 0xdf335000-0xdf335fff 64bit]
[    0.618094] pci 0000:00:16.0: PME# supported from D3hot
[    0.618232] pci 0000:00:17.0: [8086:282a] type 00 class 0x010400
[    0.618247] pci 0000:00:17.0: reg 0x10: [mem 0xdf330000-0xdf331fff]
[    0.618255] pci 0000:00:17.0: reg 0x14: [mem 0xdf334000-0xdf3340ff]
[    0.618263] pci 0000:00:17.0: reg 0x18: [io  0xf090-0xf097]
[    0.618271] pci 0000:00:17.0: reg 0x1c: [io  0xf080-0xf083]
[    0.618279] pci 0000:00:17.0: reg 0x20: [io  0xf060-0xf07f]
[    0.618287] pci 0000:00:17.0: reg 0x24: [mem 0xdf333000-0xdf3337ff]
[    0.618331] pci 0000:00:17.0: PME# supported from D3hot
[    0.618469] pci 0000:00:1c.0: [8086:9d10] type 01 class 0x060400
[    0.618535] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.618656] pci 0000:00:1c.0: System wakeup disabled by ACPI
[    0.618697] pci 0000:00:1c.4: [8086:9d14] type 01 class 0x060400
[    0.618763] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.618909] pci 0000:00:1c.5: [8086:9d15] type 01 class 0x060400
[    0.618974] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
[    0.619134] pci 0000:00:1f.0: [8086:9d48] type 00 class 0x060100
[    0.619362] pci 0000:00:1f.2: [8086:9d21] type 00 class 0x058000
[    0.619374] pci 0000:00:1f.2: reg 0x10: [mem 0xdf32c000-0xdf32ffff]
[    0.619551] pci 0000:00:1f.3: [8086:9d70] type 00 class 0x040300
[    0.619576] pci 0000:00:1f.3: reg 0x10: [mem 0xdf328000-0xdf32bfff 64bit]
[    0.619611] pci 0000:00:1f.3: reg 0x20: [mem 0xdf300000-0xdf30ffff 64bit]
[    0.619664] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    0.619830] pci 0000:00:1f.3: System wakeup disabled by ACPI
[    0.619868] pci 0000:00:1f.4: [8086:9d23] type 00 class 0x0c0500
[    0.619914] pci 0000:00:1f.4: reg 0x10: [mem 0xdf332000-0xdf3320ff 64bit]
[    0.619983] pci 0000:00:1f.4: reg 0x20: [io  0xf040-0xf05f]
[    0.620228] pci 0000:01:00.0: [10de:139b] type 00 class 0x030200
[    0.620242] pci 0000:01:00.0: reg 0x10: [mem 0xde000000-0xdeffffff]
[    0.620255] pci 0000:01:00.0: reg 0x14: [mem 0xc0000000-0xcfffffff
64bit pref]
[    0.620267] pci 0000:01:00.0: reg 0x1c: [mem 0xd0000000-0xd1ffffff
64bit pref]
[    0.620276] pci 0000:01:00.0: reg 0x24: [io  0xe000-0xe07f]
[    0.620284] pci 0000:01:00.0: reg 0x30: [mem 0xdf000000-0xdf07ffff pref]
[    0.620415] pci 0000:01:00.0: System wakeup disabled by ACPI
[    0.631388] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.631398] pci 0000:00:1c.0:   bridge window [io  0xe000-0xefff]
[    0.631409] pci 0000:00:1c.0:   bridge window [mem 0xde000000-0xdf0fffff]
[    0.631424] pci 0000:00:1c.0:   bridge window [mem
0xc0000000-0xd1ffffff 64bit pref]
[    0.631547] pci 0000:02:00.0: [10ec:8168] type 00 class 0x020000
[    0.631566] pci 0000:02:00.0: reg 0x10: [io  0xd000-0xd0ff]
[    0.631594] pci 0000:02:00.0: reg 0x18: [mem 0xdf204000-0xdf204fff 64bit]
[    0.631611] pci 0000:02:00.0: reg 0x20: [mem 0xdf200000-0xdf203fff 64bit]
[    0.631710] pci 0000:02:00.0: supports D1 D2
[    0.631711] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.643405] pci 0000:00:1c.4: PCI bridge to [bus 02]
[    0.643415] pci 0000:00:1c.4:   bridge window [io  0xd000-0xdfff]
[    0.643426] pci 0000:00:1c.4:   bridge window [mem 0xdf200000-0xdf2fffff]
[    0.643592] pci 0000:03:00.0: [8086:095a] type 00 class 0x028000
[    0.643630] pci 0000:03:00.0: reg 0x10: [mem 0xdf100000-0xdf101fff 64bit]
[    0.643836] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
[    0.655469] pci 0000:00:1c.5: PCI bridge to [bus 03]
[    0.655484] pci 0000:00:1c.5:   bridge window [mem 0xdf100000-0xdf1fffff]
[    0.657677] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.657726] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *10 11 12 14 15)
[    0.657773] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.657820] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.657866] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.657913] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.657959] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.658005] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.658491] ACPI: Enabled 5 GPEs in block 00 to 7F
[    0.658553] ACPI : EC: EC stopped
[    0.658666] ACPI : EC: GPE = 0x50, I/O: command/status = 0x66, data = 0x62
[    0.658667] ACPI : EC: EC started
[    0.658881] vgaarb: setting as boot device: PCI:0000:00:02.0
[    0.658882] vgaarb: device added:
PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
[    0.658884] vgaarb: loaded
[    0.658885] vgaarb: bridge control possible 0000:00:02.0
[    0.662275] PCI: Using ACPI for IRQ routing
[    0.690268] PCI: pci_cache_line_size set to 64 bytes
[    0.690393] e820: reserve RAM buffer [mem 0x00058000-0x0005ffff]
[    0.690394] e820: reserve RAM buffer [mem 0x0009e000-0x0009ffff]
[    0.690395] e820: reserve RAM buffer [mem 0x690cc000-0x6bffffff]
[    0.690396] e820: reserve RAM buffer [mem 0x75208000-0x77ffffff]
[    0.690397] e820: reserve RAM buffer [mem 0x7657e000-0x77ffffff]
[    0.690398] e820: reserve RAM buffer [mem 0x77fff000-0x77ffffff]
[    0.690399] e820: reserve RAM buffer [mem 0x282000000-0x283ffffff]
[    0.690492] NetLabel: Initializing
[    0.690493] NetLabel:  domain hash size = 128
[    0.690493] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.690505] NetLabel:  unlabeled traffic allowed by default
[    0.690580] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.690583] hpet0: 8 comparators, 64-bit 24.000000 MHz counter
[    0.692620] clocksource: Switched to clocksource hpet
[    0.698789] VFS: Disk quotas dquot_6.6.0
[    0.712676] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.728802] AppArmor: AppArmor Filesystem Enabled
[    0.728835] pnp: PnP ACPI init
[    0.729151] system 00:00: [io  0x0680-0x069f] has been reserved
[    0.729154] system 00:00: [io  0xffff] has been reserved
[    0.729155] system 00:00: [io  0xffff] has been reserved
[    0.729156] system 00:00: [io  0xffff] has been reserved
[    0.729157] system 00:00: [io  0x1800-0x18fe] has been reserved
[    0.729158] system 00:00: [io  0x164e-0x164f] has been reserved
[    0.729161] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.729261] pnp 00:01: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.729296] system 00:02: [io  0x1854-0x1857] has been reserved
[    0.729298] system 00:02: Plug and Play ACPI device, IDs INT3f0d
PNP0c02 (active)
[    0.729422] system 00:03: [io  0x0240-0x0259] has been reserved
[    0.729423] system 00:03: [io  0x0380-0x038f] has been reserved
[    0.729425] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.729463] pnp 00:04: Plug and Play ACPI device, IDs ATK3001
PNP030b (active)
[    0.729641] system 00:05: [mem 0xfed10000-0xfed17fff] has been reserved
[    0.729642] system 00:05: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.729643] system 00:05: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.729644] system 00:05: [mem 0xe0000000-0xefffffff] has been reserved
[    0.729645] system 00:05: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.729647] system 00:05: [mem 0xfed90000-0xfed93fff] could not be reserved
[    0.729648] system 00:05: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.729649] system 00:05: [mem 0xff000000-0xffffffff] has been reserved
[    0.729650] system 00:05: [mem 0xfee00000-0xfeefffff] could not be reserved
[    0.729652] system 00:05: [mem 0xdffe0000-0xdfffffff] has been reserved
[    0.729653] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.729692] system 00:06: [mem 0xfd000000-0xfdabffff] has been reserved
[    0.729693] system 00:06: [mem 0xfdad0000-0xfdadffff] has been reserved
[    0.729694] system 00:06: [mem 0xfdb00000-0xfdffffff] has been reserved
[    0.729695] system 00:06: [mem 0xfe000000-0xfe01ffff] could not be reserved
[    0.729696] system 00:06: [mem 0xfe036000-0xfe03bfff] has been reserved
[    0.729697] system 00:06: [mem 0xfe03d000-0xfe3fffff] has been reserved
[    0.729698] system 00:06: [mem 0xfe410000-0xfe7fffff] has been reserved
[    0.729700] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.730017] system 00:07: [io  0xff00-0xfffe] has been reserved
[    0.730019] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.731202] system 00:08: [mem 0xfdaf0000-0xfdafffff] has been reserved
[    0.731203] system 00:08: [mem 0xfdae0000-0xfdaeffff] has been reserved
[    0.731204] system 00:08: [mem 0xfdac0000-0xfdacffff] has been reserved
[    0.731206] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.732101] pnp: PnP ACPI: found 9 devices
[    0.740594] clocksource: acpi_pm: mask: 0xffffff max_cycles:
0xffffff, max_idle_ns: 2085701024 ns
[    0.740644] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.740647] pci 0000:00:1c.0:   bridge window [io  0xe000-0xefff]
[    0.740656] pci 0000:00:1c.0:   bridge window [mem 0xde000000-0xdf0fffff]
[    0.740661] pci 0000:00:1c.0:   bridge window [mem
0xc0000000-0xd1ffffff 64bit pref]
[    0.740671] pci 0000:00:1c.4: PCI bridge to [bus 02]
[    0.740676] pci 0000:00:1c.4:   bridge window [io  0xd000-0xdfff]
[    0.740679] pci 0000:00:1c.4:   bridge window [mem 0xdf200000-0xdf2fffff]
[    0.740685] pci 0000:00:1c.5: PCI bridge to [bus 03]
[    0.740688] pci 0000:00:1c.5:   bridge window [mem 0xdf100000-0xdf1fffff]
[    0.740695] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.740696] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.740697] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.740697] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000c3fff window]
[    0.740698] pci_bus 0000:00: resource 8 [mem 0x000c4000-0x000c7fff window]
[    0.740699] pci_bus 0000:00: resource 9 [mem 0x000c8000-0x000cbfff window]
[    0.740700] pci_bus 0000:00: resource 10 [mem 0x000cc000-0x000cffff window]
[    0.740701] pci_bus 0000:00: resource 11 [mem 0x000d0000-0x000d3fff window]
[    0.740702] pci_bus 0000:00: resource 12 [mem 0x000d4000-0x000d7fff window]
[    0.740703] pci_bus 0000:00: resource 13 [mem 0x000d8000-0x000dbfff window]
[    0.740703] pci_bus 0000:00: resource 14 [mem 0x000dc000-0x000dffff window]
[    0.740704] pci_bus 0000:00: resource 15 [mem 0x000e0000-0x000e3fff window]
[    0.740705] pci_bus 0000:00: resource 16 [mem 0x000e4000-0x000e7fff window]
[    0.740706] pci_bus 0000:00: resource 17 [mem 0x000e8000-0x000ebfff window]
[    0.740707] pci_bus 0000:00: resource 18 [mem 0x000ec000-0x000effff window]
[    0.740708] pci_bus 0000:00: resource 19 [mem 0x7d000000-0xdfffffff window]
[    0.740708] pci_bus 0000:00: resource 20 [mem 0xfd000000-0xfe7fffff window]
[    0.740709] pci_bus 0000:01: resource 0 [io  0xe000-0xefff]
[    0.740710] pci_bus 0000:01: resource 1 [mem 0xde000000-0xdf0fffff]
[    0.740711] pci_bus 0000:01: resource 2 [mem 0xc0000000-0xd1ffffff
64bit pref]
[    0.740712] pci_bus 0000:02: resource 0 [io  0xd000-0xdfff]
[    0.740713] pci_bus 0000:02: resource 1 [mem 0xdf200000-0xdf2fffff]
[    0.740714] pci_bus 0000:03: resource 1 [mem 0xdf100000-0xdf1fffff]
[    0.820651] NET: Registered protocol family 2
[    0.836802] TCP established hash table entries: 65536 (order: 7,
524288 bytes)
[    0.836929] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.837151] TCP: Hash tables configured (established 65536 bind 65536)
[    0.837173] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    0.837205] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[    0.837264] NET: Registered protocol family 1
[    0.837274] pci 0000:00:02.0: Video device with shadowed ROM at
[mem 0x000c0000-0x000dffff]
[    0.837574] PCI: CLS 0 bytes, default 64
[    0.837610] Unpacking initramfs...
[    1.360336] Freeing initrd memory: 33600K (ffff94b7f3e50000 -
ffff94b7f5f20000)
[    1.376735] DMAR: ACPI device "device:6b" under DMAR at fed91000 as 00:15.0
[    1.376748] DMAR: ACPI device "device:6c" under DMAR at fed91000 as 00:15.1
[    1.376806] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    1.376809] software IO TLB [mem 0x64015000-0x68015000] (64MB)
mapped at [ffff94b824015000-ffff94b828014fff]
[    1.377190] simple-framebuffer simple-framebuffer.0: framebuffer at
0xb0000000, 0x1d5000 bytes, mapped to 0xffffac6f41000000
[    1.377191] simple-framebuffer simple-framebuffer.0:
format=a8r8g8b8, mode=800x600x32, linelength=3200
[    1.378230] Console: switching to colour frame buffer device 100x37
[    1.379131] simple-framebuffer simple-framebuffer.0: fb0: simplefb
registered!
[    1.396890] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    1.412662] audit: initializing netlink subsys (disabled)
[    1.412714] audit: type=2000 audit(1473713247.408:1): initialized
[    1.413157] Initialise system trusted keyrings
[    1.413378] workingset: timestamp_bits=40 max_order=21 bucket_order=0
[    1.413396] zbud: loaded
[    1.465603] Key type asymmetric registered
[    1.465604] Asymmetric key parser 'x509' registered
[    1.488710] Block layer SCSI generic (bsg) driver version 0.4
loaded (major 251)
[    1.488827] io scheduler noop registered
[    1.488828] io scheduler deadline registered
[    1.488832] io scheduler cfq registered (default)
[    1.489498] aer 0000:00:1c.0:pcie002: service driver aer loaded
[    1.489521] aer 0000:00:1c.4:pcie002: service driver aer loaded
[    1.489545] aer 0000:00:1c.5:pcie002: service driver aer loaded
[    1.489556] pcieport 0000:00:1c.0: Signaling PME through PCIe PME interrupt
[    1.489557] pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
[    1.489559] pcie_pme 0000:00:1c.0:pcie001: service driver pcie_pme loaded
[    1.489566] pcieport 0000:00:1c.4: Signaling PME through PCIe PME interrupt
[    1.489567] pci 0000:02:00.0: Signaling PME through PCIe PME interrupt
[    1.489569] pcie_pme 0000:00:1c.4:pcie001: service driver pcie_pme loaded
[    1.489576] pcieport 0000:00:1c.5: Signaling PME through PCIe PME interrupt
[    1.489577] pci 0000:03:00.0: Signaling PME through PCIe PME interrupt
[    1.489579] pcie_pme 0000:00:1c.5:pcie001: service driver pcie_pme loaded
[    1.489586] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    1.489589] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    1.489602] intel_idle: MWAIT substates: 0x11142120
[    1.489603] intel_idle: v0.4.1 model 0x4E
[    1.489798] intel_idle: lapic_timer_reliable_states 0xffffffff
[    1.489919] GHES: HEST is not enabled!
[    1.489973] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.490444] Linux agpgart interface v0.103
[    1.490479] AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
[    1.490480] AMD IOMMUv2 functionality not available on this system
[    1.490780] i8042: PNP: PS/2 Controller [PNP030b:PS2K] at 0x60,0x64 irq 1
[    1.490781] i8042: PNP: PS/2 appears to have AUX port disabled, if
this is incorrect please boot with i8042.nopnp
[    1.492715] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.492857] mousedev: PS/2 mouse device common for all mice
[    1.492898] rtc_cmos 00:01: RTC can wake from S4
[    1.493297] rtc_cmos 00:01: rtc core: registered rtc_cmos as rtc0
[    1.493377] rtc_cmos 00:01: alarms up to one month, y3k, 242 bytes
nvram, hpet irqs
[    1.493382] intel_pstate: Intel P-state driver initializing
[    1.493580] intel_pstate: HWP enabled
[    1.493712] ledtrig-cpu: registered to indicate activity on CPUs
[    1.506101] input: AT Translated Set 2 keyboard as
/devices/platform/i8042/serio0/input/input0
[    1.565338] NET: Registered protocol family 10
[    1.581444] mip6: Mobile IPv6
[    1.581446] NET: Registered protocol family 17
[    1.581449] mpls_gso: MPLS GSO support
[    1.581701] microcode: sig=0x406e3, pf=0x80, revision=0x74
[    1.581805] microcode: Microcode Update Driver: v2.01
<tigran@aivazian.fsnet.co.uk>, Peter Oruba
[    1.582012] registered taskstats version 1
[    1.582013] Loading compiled-in X.509 certificates
[    1.583815] alg: No test for pkcs1pad(rsa,sha512)
(pkcs1pad(rsa-generic,sha512))
[    1.584401] Loaded X.509 cert 'Build time autogenerated kernel key:
9414c1666aca968a3b610d6267bb4cab58588713'
[    1.584413] zswap: loaded using pool lzo/zbud
[    1.584906] AppArmor: AppArmor sha1 policy hashing enabled
[    1.586101] rtc_cmos 00:01: setting system clock to 2016-09-12
20:47:28 UTC (1473713248)
[    1.586150] PM: Hibernation image not present or could not be loaded.
[    1.587009] Freeing unused kernel memory: 1528K (ffffffff87155000 -
ffffffff872d3000)
[    1.587010] Write protecting the kernel read-only data: 12288k
[    1.587495] Freeing unused kernel memory: 1896K (ffff94b9a9e26000 -
ffff94b9aa000000)
[    1.589226] Freeing unused kernel memory: 1216K (ffff94b9aa2d0000 -
ffff94b9aa400000)
[    1.592399] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.601813] random: systemd-udevd: uninitialized urandom read (16 bytes read)
[    1.601862] random: systemd-udevd: uninitialized urandom read (16 bytes read)
[    1.601869] random: systemd-udevd: uninitialized urandom read (16 bytes read)
[    1.602171] random: udevadm: uninitialized urandom read (16 bytes read)
[    1.602191] random: udevadm: uninitialized urandom read (16 bytes read)
[    1.603041] random: udevadm: uninitialized urandom read (16 bytes read)
[    1.603050] random: udevadm: uninitialized urandom read (16 bytes read)
[    1.603277] random: udevadm: uninitialized urandom read (16 bytes read)
[    1.603304] random: udevadm: uninitialized urandom read (16 bytes read)
[    1.603331] random: udevadm: uninitialized urandom read (16 bytes read)
[    1.618776] FUJITSU Extended Socket Network Device Driver - version
1.1 - Copyright (c) 2015 FUJITSU LIMITED
[    1.622144] input: Lid Switch as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input1
[    1.623594] ACPI: Lid Switch [LID]
[    1.623989] input: Sleep Button as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input2
[    1.623991] ACPI: Sleep Button [SLPB]
[    1.624038] input: Power Button as
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[    1.624039] ACPI: Power Button [PWRF]
[    1.671270] hidraw: raw HID events driver (C) Jiri Kosina
[    1.675035] thermal LNXTHERM:00: registered as thermal_zone0
[    1.675037] ACPI: Thermal Zone [THRM] (39 C)
[    1.682835] SCSI subsystem initialized
[    1.684990] ACPI: bus type USB registered
[    1.685010] usbcore: registered new interface driver usbfs
[    1.685019] usbcore: registered new interface driver hub
[    1.685038] usbcore: registered new device driver usb
[    1.690541] libata version 3.00 loaded.
[    1.690767] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.690773] xhci_hcd 0000:00:14.0: new USB bus registered, assigned
bus number 1
[    1.691877] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci
version 0x100 quirks 0x00109810
[    1.691884] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
[    1.692106] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    1.692107] usb usb1: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    1.692108] usb usb1: Product: xHCI Host Controller
[    1.692109] usb usb1: Manufacturer: Linux 4.8.0-040800rc6-generic xhci-hcd
[    1.692110] usb usb1: SerialNumber: 0000:00:14.0
[    1.692239] hub 1-0:1.0: USB hub found
[    1.692253] hub 1-0:1.0: 12 ports detected
[    1.693351] [drm] Initialized drm 1.1.0 20060810
[    1.693471] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.693474] xhci_hcd 0000:00:14.0: new USB bus registered, assigned
bus number 2
[    1.693822] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003
[    1.693824] usb usb2: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    1.693825] usb usb2: Product: xHCI Host Controller
[    1.693826] usb usb2: Manufacturer: Linux 4.8.0-040800rc6-generic xhci-hcd
[    1.693827] usb usb2: SerialNumber: 0000:00:14.0
[    1.694356] hub 2-0:1.0: USB hub found
[    1.694370] hub 2-0:1.0: 6 ports detected
[    1.695237] ahci 0000:00:17.0: version 3.0
[    1.705564] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 2 ports 6
Gbps 0x5 impl RAID mode
[    1.705566] ahci 0000:00:17.0: flags: 64bit ncq pm led clo only pio
slum part deso sadm sds apst
[    1.708003] scsi host0: ahci
[    1.712318] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[    1.712326] r8169 0000:02:00.0: can't disable ASPM; OS doesn't have
ASPM control
[    1.712974] scsi host1: ahci
[    1.714467] scsi host2: ahci
[    1.714523] ata1: SATA max UDMA/133 abar m2048@0xdf333000 port
0xdf333100 irq 126
[    1.714524] ata2: DUMMY
[    1.714525] ata3: SATA max UDMA/133 abar m2048@0xdf333000 port
0xdf333200 irq 126
[    1.725780] r8169 0000:02:00.0 eth0: RTL8168g/8111g at
0xffffac6f4002c000, 34:97:f6:11:ee:89, XID 10900800 IRQ 127
[    1.725782] r8169 0000:02:00.0 eth0: jumbo features [frames: 9200
bytes, tx checksumming: ko]
[    1.733030] [drm] Memory usable by graphics device = 4096M
[    1.733033] checking generic (b0000000 1d5000) vs hw (b0000000 10000000)
[    1.733033] fb: switching to inteldrmfb from simple
[    1.733053] Console: switching to colour dummy device 80x25
[    1.733120] [drm] Replacing VGA console driver
[    1.738824] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    1.738825] [drm] Driver supports precise vblank timestamp query.
[    1.747591] [drm] Finished loading i915/skl_dmc_ver1_26.bin (v1.26)
[    1.747994] vgaarb: device changed decodes:
PCI:0000:00:02.0,olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    1.767231] [drm] GuC firmware load skipped
[    1.775350] r8169 0000:02:00.0 enp2s0: renamed from eth0
[    1.929982] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[    1.932149] input: Video Bus as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input4
[    1.932190] ACPI: Video Device [PEGP] (multi-head: no  rom: yes  post: no)
[    1.932215] input: Video Bus as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:22/LNXVIDEO:01/input/input5
[    2.021169] usb 1-2: new full-speed USB device number 2 using xhci_hcd
[    2.025303] ata1: SATA link down (SStatus 4 SControl 300)
[    2.031073] ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    2.031938] ata3.00: ATA-8: HFS512G39MND-3510A, 20400P00, max UDMA/133
[    2.031940] ata3.00: 1000215216 sectors, multi 16: LBA48 NCQ (depth
31/32), AA
[    2.033215] ata3.00: configured for UDMA/133
[    2.033831] scsi 2:0:0:0: Direct-Access     ATA
HFS512G39MND-351 0P00 PQ: 0 ANSI: 5
[    2.098520] fbcon: inteldrmfb (fb0) is primary device
[    2.165679] usb 1-2: New USB device found, idVendor=09da, idProduct=054f
[    2.165680] usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.165682] usb 1-2: Product: USB Device
[    2.165682] usb 1-2: Manufacturer: A4TECH
[    2.172940] usbcore: registered new interface driver usbhid
[    2.172940] usbhid: USB HID core driver
[    2.175756] input: A4TECH USB Device as
/devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.0/0003:09DA:054F.0001/input/input6
[    2.233736] hid-generic 0003:09DA:054F.0001: input,hiddev0,hidraw0:
USB HID v1.11 Keyboard [A4TECH USB Device] on
usb-0000:00:14.0-2/input0
[    2.233925] input: A4TECH USB Device as
/devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.1/0003:09DA:054F.0002/input/input7
[    2.234191] hid-generic 0003:09DA:054F.0002: input,hidraw1: USB HID
v1.11 Mouse [A4TECH USB Device] on usb-0000:00:14.0-2/input1
[    2.285356] usb 1-6: new high-speed USB device number 3 using xhci_hcd
[    2.401351] tsc: Refined TSC clocksource calibration: 2592.000 MHz
[    2.401360] clocksource: tsc: mask: 0xffffffffffffffff max_cycles:
0x255cb6cc5db, max_idle_ns: 440795203504 ns
[    2.451114] usb 1-6: New USB device found, idVendor=0bda, idProduct=57ed
[    2.451115] usb 1-6: New USB device strings: Mfr=3, Product=1, SerialNumber=2
[    2.451116] usb 1-6: Product: USB2.0 VGA UVC WebCam
[    2.451117] usb 1-6: Manufacturer: 04081-0005490016091001857
[    2.451117] usb 1-6: SerialNumber: 200901010001
[    2.573347] usb 1-8: new full-speed USB device number 4 using xhci_hcd
[    2.717839] usb 1-8: New USB device found, idVendor=8087, idProduct=0a2a
[    2.717841] usb 1-8: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.817592] [drm] RC6 on
[    3.168520] Console: switching to colour frame buffer device 240x67
[    3.188698] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
[    3.212540] sd 2:0:0:0: [sda] 1000215216 512-byte logical blocks:
(512 GB/477 GiB)
[    3.212541] sd 2:0:0:0: [sda] 4096-byte physical blocks
[    3.212725] sd 2:0:0:0: [sda] Write Protect is off
[    3.212727] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    3.212753] sd 2:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    3.213987]  sda: sda1 sda2 sda3 sda4 sda5
[    3.214645] sd 2:0:0:0: [sda] Attached SCSI disk
[    3.428926] clocksource: Switched to clocksource tsc
[    3.483908] random: fast init done
[    3.513565] EXT4-fs (sda5): mounted filesystem with ordered data
mode. Opts: (null)
[    3.618727] systemd[1]: systemd 229 running in system mode. (+PAM
+AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP
+GCRYPT +GNUTLS +ACL +XZ -LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN)
[    3.618830] systemd[1]: Detected architecture x86-64.
[    3.619007] systemd[1]: Set hostname to <Mattingly>.
[    3.665405] systemd[1]: Set up automount Arbitrary Executable File
Formats File System Automount Point.
[    3.665425] systemd[1]: Reached target Encrypted Volumes.
[    3.665447] systemd[1]: Listening on udev Control Socket.
[    3.665461] systemd[1]: Listening on Syslog Socket.
[    3.665472] systemd[1]: Listening on udev Kernel Socket.
[    3.665483] systemd[1]: Listening on fsck to fsckd communication Socket.
[    3.665535] systemd[1]: Created slice User and Session Slice.
[    3.699234] lp: driver loaded but no devices found
[    3.705923] ppdev: user-space parallel port driver
[    3.748112] EXT4-fs (sda5): re-mounted. Opts: errors=remount-ro
[    3.757177] systemd-journald[835]: Received request to flush
runtime journal from PID 1
[    3.847270] input: Asus Wireless Radio Control as
/devices/LNXSYSTM:00/LNXSYBUS:00/ATK4002:00/input/input8
[    3.892963] tpm_crb MSFT0101:00: can't request region for resource
[mem 0xfed40080-0xfed40fff]
[    3.893014] tpm_crb: probe of MSFT0101:00 failed with error -16
[    3.893114] wmi: Mapper loaded
[    3.893793] ACPI: AC Adapter [AC0] (off-line)
[    3.904921] ACPI: Battery Slot [BAT0] (battery present)
[    3.913152] Bluetooth: Core ver 2.21
[    3.913162] NET: Registered protocol family 31
[    3.913163] Bluetooth: HCI device and connection manager initialized
[    3.913166] Bluetooth: HCI socket layer initialized
[    3.913168] Bluetooth: L2CAP socket layer initialized
[    3.913172] Bluetooth: SCO socket layer initialized
[    3.954576] Bluetooth: HCI UART driver ver 2.3
[    3.954578] Bluetooth: HCI UART protocol H4 registered
[    3.954578] Bluetooth: HCI UART protocol BCSP registered
[    3.954579] Bluetooth: HCI UART protocol LL registered
[    3.954580] Bluetooth: HCI UART protocol ATH3K registered
[    3.954580] Bluetooth: HCI UART protocol Three-wire (H5) registered
[    3.954605] Bluetooth: HCI UART protocol Intel registered
[    3.954616] Bluetooth: HCI UART protocol BCM registered
[    3.954616] Bluetooth: HCI UART protocol QCA registered
[    3.963420] intel-lpss 0000:00:15.0: enabling device (0000 -> 0002)
[    3.973695] idma64 idma64.0: Found Intel integrated DMA 64-bit
[    3.974440] intel-lpss 0000:00:15.1: enabling device (0000 -> 0002)
[    3.974651] idma64 idma64.1: Found Intel integrated DMA 64-bit
[    3.979575] mei_me 0000:00:16.0: enabling device (0000 -> 0002)
[    3.989532] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    3.989543] sd 2:0:0:0: Attached scsi generic sg0 type 0
[    4.009346] EFI Variables Facility v0.08 2004-May-17
[    4.020660] pstore: using zlib compression
[    4.020675] pstore: Registered efi as persistent store backend
[    4.034128] Intel(R) Wireless WiFi driver for Linux
[    4.034129] Copyright(c) 2003- 2015 Intel Corporation
[    4.036504] iwlwifi 0000:03:00.0: Unsupported splx structure
[    4.039671] iwlwifi 0000:03:00.0: Direct firmware load for
iwlwifi-7265D-24.ucode failed with error -2
[    4.039888] iwlwifi 0000:03:00.0: Direct firmware load for
iwlwifi-7265D-23.ucode failed with error -2
[    4.039902] iwlwifi 0000:03:00.0: Direct firmware load for
iwlwifi-7265D-22.ucode failed with error -2
[    4.040256] iwlwifi 0000:03:00.0: Direct firmware load for
iwlwifi-7265D-21.ucode failed with error -2
[    4.040284] iwlwifi 0000:03:00.0: Direct firmware load for
iwlwifi-7265D-20.ucode failed with error -2
[    4.040293] iwlwifi 0000:03:00.0: Direct firmware load for
iwlwifi-7265D-19.ucode failed with error -2
[    4.040301] iwlwifi 0000:03:00.0: Direct firmware load for
iwlwifi-7265D-18.ucode failed with error -2
[    4.040310] iwlwifi 0000:03:00.0: Direct firmware load for
iwlwifi-7265D-17.ucode failed with error -2
[    4.047683] iwlwifi 0000:03:00.0: loaded firmware version
16.242414.0 op_mode iwlmvm
[    4.048892] RAPL PMU: API unit is 2^-32 Joules, 5 fixed counters,
655360 ms ovfl timer
[    4.048893] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    4.048894] RAPL PMU: hw unit of domain package 2^-14 Joules
[    4.048894] RAPL PMU: hw unit of domain dram 2^-14 Joules
[    4.048895] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[    4.048895] RAPL PMU: hw unit of domain psys 2^-14 Joules
[    4.079802] iwlwifi 0000:03:00.0: Detected Intel(R) Dual Band
Wireless AC 7265, REV=0x210
[    4.081862] iwlwifi 0000:03:00.0: L1 Enabled - LTR Enabled
[    4.082094] iwlwifi 0000:03:00.0: L1 Enabled - LTR Enabled
[    4.084949] AVX2 version of gcm_enc/dec engaged.
[    4.084949] AES CTR mode by8 optimization enabled
[    4.091267] pcieport 0000:00:1c.5: AER: Corrected error received: id=00e5
[    4.091275] pcieport 0000:00:1c.5: PCIe Bus Error:
severity=Corrected, type=Physical Layer, id=00e5(Receiver ID)
[    4.091332] pcieport 0000:00:1c.5:   device [8086:9d15] error
status/mask=00000001/00002000
[    4.091375] pcieport 0000:00:1c.5:    [ 0] Receiver Error         (First)
[    4.121867] Adding 8391676k swap on /dev/sda4.  Priority:-1
extents:1 across:8391676k SSFS
[    4.158693] EXT4-fs (sda3): mounted filesystem with ordered data
mode. Opts: (null)
[    4.167531] ieee80211 phy0: Selected rate control algorithm 'iwl-mvm-rs'
[    4.207227] FAT-fs (sda1): utf8 is not a recommended IO charset for
FAT filesystems, filesystem will be case sensitive!
[    4.226109] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops
i915_audio_component_bind_ops [i915])
[    4.259333] snd_hda_codec_conexant hdaudioC0D0: CX20751/2: BIOS auto-probing.
[    4.259636] snd_hda_codec_conexant hdaudioC0D0: autoconfig for
CX20751/2: line_outs=1 (0x17/0x0/0x0/0x0/0x0) type:speaker
[    4.259638] snd_hda_codec_conexant hdaudioC0D0:    speaker_outs=0
(0x0/0x0/0x0/0x0/0x0)
[    4.259640] snd_hda_codec_conexant hdaudioC0D0:    hp_outs=1
(0x16/0x0/0x0/0x0/0x0)
[    4.259641] snd_hda_codec_conexant hdaudioC0D0:    mono: mono_out=0x0
[    4.259641] snd_hda_codec_conexant hdaudioC0D0:    inputs:
[    4.259643] snd_hda_codec_conexant hdaudioC0D0:      Internal Mic=0x1a
[    4.259644] snd_hda_codec_conexant hdaudioC0D0:      Mic=0x19
[    4.260417] snd_hda_codec_conexant hdaudioC0D0: Enable sync_write
for stable communication
[    4.265659] random: crng init done
[    4.267833] input: HDA Digital PCBeep as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input9
[    4.268439] input: HDA Intel PCH Mic as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input10
[    4.268494] input: HDA Intel PCH Headphone as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input11
[    4.268548] input: HDA Intel PCH HDMI/DP,pcm=3 as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input12
[    4.268604] input: HDA Intel PCH HDMI/DP,pcm=7 as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input13
[    4.268772] input: HDA Intel PCH HDMI/DP,pcm=8 as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input14
[    4.295938] asus_wmi: ASUS WMI generic driver loaded
[    4.298984] audit: type=1400 audit(1473713251.206:2):
apparmor="STATUS" operation="profile_load"
name="/usr/lib/snapd/snap-confine" pid=1946 comm="apparmor_parser"
[    4.299315] asus_wmi: Initialization: 0x1
[    4.299347] asus_wmi: BIOS WMI version: 7.9
[    4.299381] asus_wmi: SFUN value: 0xa0065
[    4.299627] audit: type=1400 audit(1473713251.206:3):
apparmor="STATUS" operation="profile_load" name="/sbin/dhclient"
pid=1944 comm="apparmor_parser"
[    4.299632] audit: type=1400 audit(1473713251.206:4):
apparmor="STATUS" operation="profile_load"
name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=1944
comm="apparmor_parser"
[    4.299635] audit: type=1400 audit(1473713251.206:5):
apparmor="STATUS" operation="profile_load"
name="/usr/lib/NetworkManager/nm-dhcp-helper" pid=1944
comm="apparmor_parser"
[    4.299638] audit: type=1400 audit(1473713251.206:6):
apparmor="STATUS" operation="profile_load"
name="/usr/lib/connman/scripts/dhclient-script" pid=1944
comm="apparmor_parser"
[    4.300548] input: Asus WMI hotkeys as
/devices/platform/asus-nb-wmi/input/input15
[    4.302432] audit: type=1400 audit(1473713251.210:7):
apparmor="STATUS" operation="profile_load"
name="/usr/sbin/cups-browsed" pid=1949 comm="apparmor_parser"
[    4.302494] audit: type=1400 audit(1473713251.210:8):
apparmor="STATUS" operation="profile_load"
name="/usr/lib/lightdm/lightdm-guest-session" pid=1943
comm="apparmor_parser"
[    4.302497] audit: type=1400 audit(1473713251.210:9):
apparmor="STATUS" operation="profile_load"
name="/usr/lib/lightdm/lightdm-guest-session//chromium" pid=1943
comm="apparmor_parser"
[    4.302815] intel_rapl: Found RAPL domain package
[    4.302816] intel_rapl: Found RAPL domain core
[    4.302817] intel_rapl: Found RAPL domain uncore
[    4.302818] intel_rapl: Found RAPL domain dram
[    4.305720] audit: type=1400 audit(1473713251.214:10):
apparmor="STATUS" operation="profile_load"
name="/usr/lib/cups/backend/cups-pdf" pid=1950 comm="apparmor_parser"
[    4.312900] asus_wmi: Number of fans: 1
[    4.332877] usb 1-8: USB disconnect, device number 4
[    4.438455] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    4.438456] Bluetooth: BNEP filters: protocol multicast
[    4.438459] Bluetooth: BNEP socket layer initialized
[    4.475199] Non-volatile memory driver v1.3
[    4.525135] usbcore: registered new interface driver btusb
[    4.529967] iwlwifi 0000:03:00.0 wlp3s0: renamed from wlan0
[    4.548952] ahci 0000:00:17.0: port does not support device sleep
[    4.560930] IPv6: ADDRCONF(NETDEV_UP): enp2s0: link is not ready
[    4.612855] r8169 0000:02:00.0 enp2s0: link down
[    4.613173] IPv6: ADDRCONF(NETDEV_UP): enp2s0: link is not ready
[    4.623898] IPv6: ADDRCONF(NETDEV_UP): wlp3s0: link is not ready
[    4.625994] iwlwifi 0000:03:00.0: L1 Enabled - LTR Enabled
[    4.626190] iwlwifi 0000:03:00.0: L1 Enabled - LTR Enabled
[    4.633237] pcieport 0000:00:1c.5: AER: Corrected error received: id=00e5
[    4.633244] pcieport 0000:00:1c.5: PCIe Bus Error:
severity=Corrected, type=Physical Layer, id=00e5(Receiver ID)
[    4.633247] pcieport 0000:00:1c.5:   device [8086:9d15] error
status/mask=00000001/00002000
[    4.633249] pcieport 0000:00:1c.5:    [ 0] Receiver Error         (First)
[    4.693906] iwlwifi 0000:03:00.0: L1 Enabled - LTR Enabled
[    4.694105] iwlwifi 0000:03:00.0: L1 Enabled - LTR Enabled
[    4.703853] pcieport 0000:00:1c.5: AER: Corrected error received: id=00e5
[    4.703878] pcieport 0000:00:1c.5: PCIe Bus Error:
severity=Corrected, type=Physical Layer, id=00e5(Receiver ID)
[    4.703880] pcieport 0000:00:1c.5:   device [8086:9d15] error
status/mask=00000001/00002000
[    4.703882] pcieport 0000:00:1c.5:    [ 0] Receiver Error         (First)
[    4.711471] IPv6: ADDRCONF(NETDEV_UP): wlp3s0: link is not ready
[    4.772812] pcieport 0000:00:1c.5: AER: Corrected error received: id=00e5
[    4.772819] pcieport 0000:00:1c.5: PCIe Bus Error:
severity=Corrected, type=Physical Layer, id=00e5(Receiver ID)
[    4.772821] pcieport 0000:00:1c.5:   device [8086:9d15] error
status/mask=00000001/00002000
[    4.772823] pcieport 0000:00:1c.5:    [ 0] Receiver Error         (First)
[    4.778021] IPv6: ADDRCONF(NETDEV_UP): wlp3s0: link is not ready
[    4.860637] usb 1-8: new full-speed USB device number 5 using xhci_hcd
[    5.008931] usb 1-8: New USB device found, idVendor=8087, idProduct=0a2a
[    5.008932] usb 1-8: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    5.025136] Bluetooth: hci0: read Intel version: 370810011003110e00
[    5.027146] Bluetooth: hci0: Intel Bluetooth firmware file:
intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq
[    5.040401] media: Linux media interface: v0.10
[    5.045088] Linux video capture interface: v2.00
[    5.168770] uvcvideo: Found UVC 1.00 device USB2.0 VGA UVC WebCam (0bda:57ed)
[    5.169578] uvcvideo 1-6:1.0: Entity type for entity Extension 4
was not initialized!
[    5.169599] uvcvideo 1-6:1.0: Entity type for entity Processing 2
was not initialized!
[    5.169600] uvcvideo 1-6:1.0: Entity type for entity Camera 1 was
not initialized!
[    5.169680] input: USB2.0 VGA UVC WebCam as
/devices/pci0000:00/0000:00:14.0/usb1/1-6/1-6:1.0/input/input16
[    5.169757] usbcore: registered new interface driver uvcvideo
[    5.169758] USB Video Class driver (1.1.1)
[    5.335805] Bluetooth: hci0: Intel Bluetooth firmware patch
completed and activated
[    5.420897] fuse init (API version 7.25)
[    9.697379] i2c_hid i2c-FTE1001:00: failed to reset device.
[   10.743833] i2c_hid i2c-FTE1001:00: error in i2c_hid_init_report
size:633 / ret_size:0
[   10.747364] i2c_hid i2c-FTE1001:00: error in i2c_hid_init_report
size:131 / ret_size:0
[   10.747406] input: FTE1001:00 0B05:0101 as
/devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-5/i2c-FTE1001:00/0018:0B05:0101.0003/input/input17
[   10.747607] hid-generic 0018:0B05:0101.0003: input,hidraw2: I2C HID
v1.00 Mouse [FTE1001:00 0B05:0101] on i2c-FTE1001:00
[   15.218281] wlp3s0: authenticate with 00:90:a9:13:b7:e6
[   15.225204] pcieport 0000:00:1c.5: AER: Corrected error received: id=00e5
[   15.225211] pcieport 0000:00:1c.5: PCIe Bus Error:
severity=Corrected, type=Physical Layer, id=00e5(Receiver ID)
[   15.225215] pcieport 0000:00:1c.5:   device [8086:9d15] error
status/mask=00000001/00002000
[   15.225217] pcieport 0000:00:1c.5:    [ 0] Receiver Error         (First)
[   15.228057] wlp3s0: send auth to 00:90:a9:13:b7:e6 (try 1/3)
[   15.230082] wlp3s0: authenticated
[   15.236644] wlp3s0: associate with 00:90:a9:13:b7:e6 (try 1/3)
[   15.240967] wlp3s0: RX AssocResp from 00:90:a9:13:b7:e6
(capab=0x431 status=0 aid=3)
[   15.242181] wlp3s0: associated
[   15.242215] IPv6: ADDRCONF(NETDEV_CHANGE): wlp3s0: link becomes ready
[   15.495932] Bluetooth: RFCOMM TTY layer initialized
[   15.495939] Bluetooth: RFCOMM socket layer initialized
[   15.495944] Bluetooth: RFCOMM ver 1.11
[   31.010435] pcieport 0000:00:1c.5: AER: Corrected error received: id=00e5
[   31.010441] pcieport 0000:00:1c.5: PCIe Bus Error:
severity=Corrected, type=Physical Layer, id=00e5(Receiver ID)
[   31.010443] pcieport 0000:00:1c.5:   device [8086:9d15] error
status/mask=00000001/00002000
[   31.010445] pcieport 0000:00:1c.5:    [ 0] Receiver Error         (First)

Thanks,
Egor

On Mon, Sep 12, 2016 at 2:23 PM,  <ulrik.debie-os@e2big.org> wrote:
> Hi Egor,
>
> Looking at the code of focaltech, the first check is for pnp firmware id.
> Can you provide the following:
> 1) output of grep . /sys/bus/serio/devices/serio*/firmware_id
> 2) content of /proc/bus/input/devices
> 3) dmesg after startup
>
> Thanks,
> Ulrik
> On Sun, Sep 11, 2016 at 09:18:26PM -0500, Egor Starkov wrote:
>> Date:   Sun, 11 Sep 2016 21:18:26 -0500
>> From: Egor Starkov <eastarkov@gmail.com>
>> To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> Cc: linux-input@vger.kernel.org
>> Subject: [Asus K501UW] Focaltech touchpad detected as mouse
>> X-Mailing-List: linux-input@vger.kernel.org
>>
>> Hi,
>>
>> The Focaltech touchpad on Asus K501UW laptop is detected as a mouse
>> (moving the cursor, tapping and pressing physical touchpad buttons
>> works, but touchpad-specific features like two-finger scrolling or
>> two-finger tap do not).
>>
>> The touchpad is recognized in xinput-list as "FTE1001:00 0B05:0101".
>>
>> Latest kernel version tested: "Linux version 4.8.0-040800rc5-generic
>> (kernel@tangerine) (gcc version 6.2.0 20160830 (Ubuntu
>> 6.2.0-2ubuntu11) ) #201609041832 SMP Sun Sep 4 22:34:01 UTC 2016"
>>
>> This bug at Launchpad:
>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1620811
>>
>> Best,
>> Egor
>>
>> [resending the letter since my first one contained html despite my
>> best efforts. Sorry for the repetition, if any.]
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-input" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
