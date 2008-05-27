From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] Input: Add i8042.nopnp for Intel D845PESV
Date: Tue, 27 May 2008 17:25:54 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0805271724470.6718@jikos.suse.cz>
References: <Pine.LNX.4.64.0805271710240.6718@jikos.suse.cz>
 <20080527112145.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:55024 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755743AbYE0PZ4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 27 May 2008 11:25:56 -0400
In-Reply-To: <20080527112145.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Tue, 27 May 2008, Dmitry Torokhov wrote:

> Hmm, could I see a dmesg for it by any chance?

Here it is, extracted it from Novell bugzilla (it's public bug, #386952):

  <5>Linux version 2.6.25-26-pae (geeko@buildhost) (gcc version 4.3.1 20080425 (prerelease) [gcc-4_3-branch revision 134659] (SUSE Linux) ) #1 SMP 2008-04-30 07:56:05 +0200
  <6>BIOS-provided physical RAM map:
  <4> BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  <4> BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  <4> BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
  <4> BIOS-e820: 0000000000100000 - 000000003ff40000 (usable)
  <4> BIOS-e820: 000000003ff40000 - 000000003ff50000 (ACPI data)
  <4> BIOS-e820: 000000003ff50000 - 0000000040000000 (ACPI NVS)
  <5>127MB HIGHMEM available.
  <5>896MB LOWMEM available.
  <6>Scan SMP from c0000000 for 1024 bytes.
  <6>Scan SMP from c009fc00 for 1024 bytes.
  <6>Scan SMP from c00f0000 for 65536 bytes.
  <6>found SMP MP-table at [c00ff780] 000ff780
  <7>Entering add_active_range(0, 0, 261952) 0 entries of 256 used
  <4>Zone PFN ranges:
  <4>  DMA             0 ->     4096
  <4>  Normal       4096 ->   229376
  <4>  HighMem    229376 ->   261952
  <4>Movable zone start PFN for each node
  <4>early_node_map[1] active PFN ranges
  <4>    0:        0 ->   261952
  <7>On node 0 totalpages: 261952
  <7>  DMA zone: 32 pages used for memmap
  <7>  DMA zone: 0 pages reserved
  <7>  DMA zone: 4064 pages, LIFO batch:0
  <7>  Normal zone: 1760 pages used for memmap
  <7>  Normal zone: 223520 pages, LIFO batch:31
  <7>  HighMem zone: 254 pages used for memmap
  <7>  HighMem zone: 32322 pages, LIFO batch:7
  <7>  Movable zone: 0 pages used for memmap
  <6>DMI 2.3 present.
  <6>Using APIC driver default
  <4>ACPI: RSDP 000F7370, 0014 (r0 ACPIAM)
  <4>ACPI: RSDT 3FF40000, 0030 (r1 INTEL  D845PESV 20030425 MSFT       97)
  <4>ACPI: FACP 3FF40200, 0074 (r1 INTEL  D845PESV 20030425 MSFT       97)
  <4>ACPI: DSDT 3FF40370, 3FEC (r1 INTEL  D845PESV      10A MSFT  100000D)
  <4>ACPI: FACS 3FF50000, 0040
  <4>ACPI: APIC 3FF40300, 0068 (r1 INTEL  D845PESV 20030425 MSFT       97)
  <4>ACPI: ASF! 3FF44360, 0084 (r16 AMIASF I845GASF        1 MSFT  100000D)
  <6>ACPI: PM-Timer IO Port: 0x408
  <7>ACPI: Local APIC address 0xfee00000
  <6>ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
  <4>Processor #0 15:2 APIC version 20
  <6>ACPI: LAPIC (acpi_id[0x02] lapic_id[0x81] disabled)
  <6>ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
  <6>ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
  <6>ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
  <4>IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
  <6>ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
  <6>ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
  <7>ACPI: IRQ0 used by override.
  <7>ACPI: IRQ2 used by override.
  <7>ACPI: IRQ9 used by override.
  <4>Enabling APIC mode:  Flat.  Using 1 I/O APICs
  <6>Using ACPI (MADT) for SMP configuration information
  <4>Allocating PCI resources starting at 50000000 (gap: 40000000:c0000000)
  <6>PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
  <6>PM: Registered nosave memory: 00000000000a0000 - 00000000000e0000
  <6>PM: Registered nosave memory: 00000000000e0000 - 0000000000100000
  <4>Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 259906
  <5>Kernel command line: root=/dev/disk/by-id/scsi-SATA_WDC_WD800JB-00CWD-WCA8E5506866-part2 resume=/dev/sda1 splash=silent vga=0x317
  <6>bootsplash: silent mode.
  <7>mapped APIC to ffffb000 (fee00000)
  <7>mapped IOAPIC to ffffa000 (fec00000)
  <6>Enabling fast FPU save and restore... done.
  <6>Enabling unmasked SIMD FPU exception support... done.
  <6>Initializing CPU#0
  <4>PID hash table entries: 4096 (order: 12, 16384 bytes)
  <4>Detected 2400.121 MHz processor.
  <4>Console: colour dummy device 80x25
  <6>console [tty0] enabled
  <6>Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
  <6>Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
  <6>Memory: 1029188k/1047808k available (1955k kernel code, 17848k reserved, 1678k data, 264k init, 130304k highmem)
  <6>virtual kernel memory layout:
  <4>    fixmap  : 0xff8b2000 - 0xfffff000   (7476 kB)
  <4>    pkmap   : 0xff400000 - 0xff600000   (2048 kB)
  <4>    vmalloc : 0xf8800000 - 0xff3fe000   ( 107 MB)
  <4>    lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
  <4>      .init : 0xc0495000 - 0xc04d7000   ( 264 kB)
  <4>      .data : 0xc02e8c2a - 0xc048c784   (1678 kB)
  <4>      .text : 0xc0100000 - 0xc02e8c2a   (1955 kB)
  <6>Checking if this processor honours the WP bit even in supervisor mode...Ok.
  <7>CPA: page pool initialized 1 of 1 pages preallocated
  <4>Calibrating delay using timer specific routine.. 4805.28 BogoMIPS (lpj=9610562)
  <6>Security Framework initialized
  <6>AppArmor: AppArmor initialized <NULL>
  <6>AppArmor: Registered secondary security module capability
  <6>Capability LSM initialized as secondary
  <4>Mount-cache hash table entries: 512
  <6>CPU: Trace cache: 12K uops, L1 D cache: 8K
  <6>CPU: L2 cache: 512K
  <6>CPU: Hyper-Threading is disabled
  <6>Intel machine check architecture supported.
  <6>Intel machine check reporting enabled on CPU#0.
  <6>CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
  <6>CPU0: Thermal monitoring enabled
  <4>Compat vDSO mapped to ffffe000.
  <6>Checking 'hlt' instruction... OK.
  <6>SMP alternatives: switching to UP code
  <6>Freeing SMP alternatives: 18k freed
  <6>ACPI: Core revision 20070126
  <4>Parsing all Control Methods:
  <4>Table [DSDT](id 0001) - 592 Objects with 46 Devices 164 Methods 21 Regions
  <4> tbxface-0598 [00] tb_load_namespace     : ACPI Tables successfully acquired
  <4>evxfevnt-0091 [00] enable                : Transition to ACPI mode successful
  <4>CPU0: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 04
  <6>Total of 1 processors activated (4805.28 BogoMIPS).
  <4>ENABLING IO-APIC IRQs
  <6>..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
  <6>Brought up 1 CPUs
  <7>CPU0 attaching sched-domain:
  <7> domain 0: span 00000000,00000000,00000000,00000001
  <7>  groups: 00000000,00000000,00000000,00000001
  <6>net_namespace: 548 bytes
  <6>Booting paravirtualized kernel on bare hardware
  <6>NET: Registered protocol family 16
  <6>ACPI: bus type pci registered
  <6>PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=2
  <6>PCI: Using configuration type 1
  <6>Setting up standard PCI resources
  <4>evgpeblk-0956 [00] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs on int 0x9
  <4>evgpeblk-1052 [00] ev_initialize_gpe_bloc: Found 7 Wake, Enabled 0 Runtime GPEs in this block
  <7>ACPI: EC: Look up EC in DSDT
  <4>Completing Region/Field/Buffer/Package initialization:.............................................................................................................
  <4>Initialized 18/21 Regions 29/29 Fields 48/48 Buffers 14/14 Packages (601 nodes)
  <4>Initializing Device/Processor/Thermal objects by executing _INI methods:.
  <4>Executed 1 _INI methods requiring 0 _STA executions (examined 50 objects)
  <6>ACPI: Interpreter enabled
  <6>ACPI: (supports S0 S1 S4 S5)
  <6>ACPI: Using IOAPIC for interrupt routing
  <6>ACPI: PCI Root Bridge [PCI0] (0000:00)
  <4>* The chipset may have PM-Timer Bug. Due to workarounds for a bug,
  <4>* this clock source is slow. If you are sure your timer does not have
  <4>* this bug, please use "acpi_pm_good" to disable the workaround
  <6>pci 0000:00:1f.0: quirk: region 0400-047f claimed by ICH4 ACPI/GPIO/TCO
  <6>pci 0000:00:1f.0: quirk: region 0480-04bf claimed by ICH4 GPIO
  <6>PCI: Transparent bridge - 0000:00:1e.0
  <7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
  <7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
  <6>ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 *11 12 14 15)
  <6>ACPI: PCI Interrupt Link [LNKB] (IRQs *3 4 5 7 9 10 11 12 14 15)
  <6>ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 *9 10 11 12 14 15)
  <6>ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 7 9 10 11 12 14 15)
  <6>ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
  <6>ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
  <6>ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
  <6>ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
  <6>ACPI: Power Resource [URP1] (off)
  <6>ACPI: Power Resource [FDDP] (off)
  <6>ACPI: Power Resource [LPTP] (off)
  <6>Linux Plug and Play Support v0.97 (c) Adam Belay
  <6>pnp: PnP ACPI init
  <6>ACPI: bus type pnp registered
  <6>pnp: PnP ACPI: found 13 devices
  <6>ACPI: ACPI bus type pnp unregistered
  <6>PnPBIOS: Disabled by ACPI PNP
  <6>PCI: Using ACPI for IRQ routing
  <6>PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
  <6>AppArmor: AppArmor Filesystem Enabled 
  <4>ACPI: RTC can wake from S4
  <6>system 00:05: ioport range 0x4d0-0x4d1 has been reserved
  <6>system 00:0b: ioport range 0x400-0x47f has been reserved
  <6>system 00:0b: ioport range 0x680-0x6ff has been reserved
  <6>system 00:0b: ioport range 0x480-0x4bf has been reserved
  <6>system 00:0b: iomem range 0xfec00000-0xfec00fff has been reserved
  <6>system 00:0b: iomem range 0xfee00000-0xfee00fff has been reserved
  <6>system 00:0c: iomem range 0x0-0x9ffff could not be reserved
  <6>system 00:0c: iomem range 0xc0000-0xdffff could not be reserved
  <6>system 00:0c: iomem range 0xe0000-0xfffff could not be reserved
  <6>system 00:0c: iomem range 0x100000-0x3fffffff could not be reserved
  <6>system 00:0c: iomem range 0x0-0x0 could not be reserved
  <6>PCI: Bridge: 0000:00:01.0
  <6>  IO window: disabled.
  <6>  MEM window: 0xfa900000-0xfe9fffff
  <6>  PREFETCH window: 0x00000000d2600000-0x00000000f26fffff
  <6>PCI: Bridge: 0000:00:1e.0
  <6>  IO window: d000-dfff
  <6>  MEM window: 0xfea00000-0xfeafffff
  <6>  PREFETCH window: 0x00000000f2700000-0x00000000f27fffff
  <7>PCI: Setting latency timer of device 0000:00:1e.0 to 64
  <6>NET: Registered protocol family 2
  <6>IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
  <6>TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
  <6>TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
  <6>TCP: Hash tables configured (established 131072 bind 65536)
  <6>TCP reno registered
  <6>Unpacking initramfs... done
  <6>Freeing initrd memory: 4307k freed
  <6>Machine check exception polling timer started.
  <6>audit: initializing netlink socket (disabled)
  <5>type=2000 audit(1210053185.448:1): initialized
  <4>highmem bounce pool size: 64 pages
  <4>Total HugeTLB memory allocated, 0
  <5>VFS: Disk quotas dquot_6.5.1
  <4>Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
  <6>Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
  <6>io scheduler noop registered
  <6>io scheduler anticipatory registered
  <6>io scheduler deadline registered
  <6>io scheduler cfq registered (default)
  <7>pci 0000:01:00.0: Boot video device
  <4>pci 0000:02:08.0: Firmware left e100 interrupts enabled; disabling
  <6>vesafb: framebuffer at 0xe0000000, mapped to 0xf8880000, using 6144k, total 262144k
  <6>vesafb: mode is 1024x768x16, linelength=2048, pages=1
  <6>vesafb: protected mode interface info at c000:d3a0
  <6>vesafb: pmi: set display start = c00cd3d6, set palette = c00cd440
  <6>vesafb: pmi: ports = 3b4 3b5 3ba 3c0 3c1 3c4 3c5 3c6 3c7 3c8 3c9 3cc 3ce 3cf 3d0 3d1 3d2 3d3 3d4 3d5 3da 
  <6>vesafb: scrolling: redraw
  <6>vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
  <6>bootsplash 3.1.6-2004/03/31: looking for picture...
  <6>bootsplash: silentjpeg size 78436 bytes
  <6>bootsplash: ...found (1024x768, 28133 bytes, v3).
  <4>Console: switching to colour frame buffer device 124x44
  <6>fb0: VESA VGA frame buffer device
  <6>isapnp: Scanning for PnP cards...
  <7>Switched to high resolution mode on CPU 0
  <6>isapnp: No Plug & Play device found
  <6>Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
  <6>serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
  <6>00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
  <6>Floppy drive(s): fd0 is 1.44M
  <6>FDC 0 is a post-1991 82077
  <6>PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
  <4>PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
  <6>serio: i8042 KBD port at 0x60,0x64 irq 1
  <6>mice: PS/2 mouse device common for all mice
  <6>input: PC Speaker as /devices/platform/pcspkr/input/input0
  <6>cpuidle: using governor ladder
  <6>cpuidle: using governor menu
  <6>NET: Registered protocol family 1
  <4>Using IPI No-Shortcut mode
  <4>registered taskstats version 1
  <6>Freeing unused kernel memory: 264k freed
  <6>Write protecting the kernel read-only data: 1436k
  <6>input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
  <6>ACPI: ACPI0007:00 is registered as cooling_device0
  <6>ACPI: Processor [CPU1] (supports 8 throttling states)
  <6>No dock devices found.
  <5>SCSI subsystem initialized
  <7>libata version 3.00 loaded.
  <7>ata_piix 0000:00:1f.1: version 2.12
  <4>PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
  <6>ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
  <7>PCI: Setting latency timer of device 0000:00:1f.1 to 64
  <6>scsi0 : ata_piix
  <6>scsi1 : ata_piix
  <6>ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xffa0 irq 14
  <6>ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xffa8 irq 15
  <6>ata1.00: ATA-5: WDC WD800JB-00CRA1, 17.07W17, max UDMA/100
  <6>ata1.00: 156301488 sectors, multi 16: LBA 
  <6>ata1.00: configured for UDMA/100
  <6>ata2.00: ATAPI: Memorex DVD+/-DLRWL1 F16, BWSE, max UDMA/66
  <6>ata2.01: ATAPI: DVD-ROM DDU1621, VER S2.9, max UDMA/33
  <4>ata2.00: limited to UDMA/33 due to 40-wire cable
  <6>ata2.00: configured for UDMA/33
  <6>ata2.01: configured for UDMA/33
  <5>scsi 0:0:0:0: Direct-Access     ATA      WDC WD800JB-00CR 17.0 PQ: 0 ANSI: 5
  <5>scsi 1:0:0:0: CD-ROM            Memorex  DVD+/-DLRWL1 F16 BWSE PQ: 0 ANSI: 5
  <5>scsi 1:0:1:0: CD-ROM            SONY     DVD-ROM DDU1621  S2.9 PQ: 0 ANSI: 5
  <6>BIOS EDD facility v0.16 2004-Jun-25, 6 devices found
  <6>usbcore: registered new interface driver usbfs
  <6>usbcore: registered new interface driver hub
  <6>usbcore: registered new device driver usb
  <6>USB Universal Host Controller Interface driver v3.0
  <6>ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
  <7>PCI: Setting latency timer of device 0000:00:1d.0 to 64
  <6>uhci_hcd 0000:00:1d.0: UHCI Host Controller
  <6>uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
  <6>uhci_hcd 0000:00:1d.0: irq 16, io base 0x0000e800
  <6>usb usb1: configuration #1 chosen from 1 choice
  <6>hub 1-0:1.0: USB hub found
  <6>hub 1-0:1.0: 2 ports detected
  <4>Driver 'sd' needs updating - please use bus_type methods
  <5>sd 0:0:0:0: [sda] 156301488 512-byte hardware sectors (80026 MB)
  <5>sd 0:0:0:0: [sda] Write Protect is off
  <7>sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
  <5>sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
  <5>sd 0:0:0:0: [sda] 156301488 512-byte hardware sectors (80026 MB)
  <5>sd 0:0:0:0: [sda] Write Protect is off
  <7>sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
  <5>sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
  <6>usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
  <6>usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
  <6>usb usb1: Product: UHCI Host Controller
  <6>usb usb1: Manufacturer: Linux 2.6.25-26-pae uhci_hcd
  <6>usb usb1: SerialNumber: 0000:00:1d.0
  <6>ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
  <7>PCI: Setting latency timer of device 0000:00:1d.7 to 64
  <6>ehci_hcd 0000:00:1d.7: EHCI Host Controller
  <6>ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 2
  <6>ehci_hcd 0000:00:1d.7: debug port 1
  <7>PCI: cache line size of 128 is not supported by device 0000:00:1d.7
  <6>ehci_hcd 0000:00:1d.7: irq 23, io mem 0xfebffc00
  <6> sda:<6>ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
  <6>usb usb2: configuration #1 chosen from 1 choice
  <4> sda1 sda2 sda3
  <5>sd 0:0:0:0: [sda] Attached SCSI disk
  <6>hub 2-0:1.0: USB hub found
  <6>hub 2-0:1.0: 6 ports detected
  <6>usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
  <6>usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
  <6>usb usb2: Product: EHCI Host Controller
  <6>usb usb2: Manufacturer: Linux 2.6.25-26-pae ehci_hcd
  <6>usb usb2: SerialNumber: 0000:00:1d.7
  <6>ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
  <7>PCI: Setting latency timer of device 0000:00:1d.1 to 64
  <6>uhci_hcd 0000:00:1d.1: UHCI Host Controller
  <6>uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
  <6>uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000e880
  <6>usb usb3: configuration #1 chosen from 1 choice
  <6>hub 3-0:1.0: USB hub found
  <6>hub 3-0:1.0: 2 ports detected
  <6>usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
  <6>usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
  <6>usb usb3: Product: UHCI Host Controller
  <6>usb usb3: Manufacturer: Linux 2.6.25-26-pae uhci_hcd
  <6>usb usb3: SerialNumber: 0000:00:1d.1
  <6>ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
  <7>PCI: Setting latency timer of device 0000:00:1d.2 to 64
  <6>uhci_hcd 0000:00:1d.2: UHCI Host Controller
  <6>uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
  <6>uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000ec00
  <6>usb usb4: configuration #1 chosen from 1 choice
  <6>hub 4-0:1.0: USB hub found
  <6>hub 4-0:1.0: 2 ports detected
  <6>usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
  <6>usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
  <6>usb usb4: Product: UHCI Host Controller
  <6>usb usb4: Manufacturer: Linux 2.6.25-26-pae uhci_hcd
  <6>usb usb4: SerialNumber: 0000:00:1d.2
  <6>usb 3-1: new low speed USB device using uhci_hcd and address 2
  <6>PM: Starting manual resume from disk
  <6>usb 3-1: configuration #1 chosen from 1 choice
  <6>usb 3-1: New USB device found, idVendor=0553, idProduct=0a02
  <6>usb 3-1: New USB device strings: Mfr=1, Product=3, SerialNumber=0
  <6>usb 3-1: Product: 5 button optical mouse with scroll wheel
  <6>usb 3-1: Manufacturer: 5 button optical mouse with scroll wheel
  <6>usbcore: registered new interface driver hiddev
  <6>input: 5 button optical mouse with scroll wheel 5 button optical mouse with scroll wheel as /devices/pci0000:00/0000:00:1d.1/usb3/3-1/3-1:1.0/input/input2
  <6>input,hidraw0: USB HID v1.10 Mouse [5 button optical mouse with scroll wheel 5 button optical mouse with scroll wheel] on usb-0000:00:1d.1-1
  <6>usbcore: registered new interface driver usbhid
  <6>drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
  <6>kjournald starting.  Commit interval 5 seconds
  <6>EXT3 FS on sda2, internal journal
  <6>EXT3-fs: mounted filesystem with ordered data mode.
  <5>sd 0:0:0:0: Attached scsi generic sg0 type 0
  <5>scsi 1:0:0:0: Attached scsi generic sg1 type 5
  <5>scsi 1:0:1:0: Attached scsi generic sg2 type 5
  <6>pci_hotplug: PCI Hot Plug PCI Core version: 0.5
  <4>intel_rng: Firmware space is locked read-only. If you can't or
  <4>intel_rng: don't want to disable this in firmware setup, and if
  <4>intel_rng: you are certain that your system has a functional
  <4>intel_rng: RNG, try using the 'no_fwh_detect' option.
  <4>Driver 'sr' needs updating - please use bus_type methods
  <4>sr0: scsi3-mmc drive: 48x/48x writer cd/rw xa/form2 cdda tray
  <6>Uniform CD-ROM driver Revision: 3.20
  <7>sr 1:0:0:0: Attached scsi CD-ROM sr0
  <4>sr1: scsi3-mmc drive: 6x/40x cd/rw xa/form2 cdda tray
  <7>sr 1:0:1:0: Attached scsi CD-ROM sr1
  <6>Linux agpgart interface v0.103
  <6>shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
  <6>ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 17 (level, low) -> IRQ 17
  <6>input: Power Button (FF) as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
  <3>end_request: I/O error, dev fd0, sector 0
  <6>ACPI: Power Button (FF) [PWRF]
  <6>input: Sleep Button (CM) as /devices/LNXSYSTM:00/device:00/PNP0C0E:00/input/input4
  <6>ACPI: Sleep Button (CM) [SLPB]
  <6>iTCO_vendor_support: vendor-support=0
  <6>agpgart: Detected an Intel 830M Chipset.
  <6>agpgart: AGP aperture is 64M @ 0xf4000000
  <6>iTCO_wdt: Intel TCO WatchDog Timer Driver v1.02 (26-Jul-2007)
  <6>iTCO_wdt: Found a ICH4 TCO device (Version=1, TCOBASE=0x0460)
  <6>iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
  <6>ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 17
  <7>PCI: Setting latency timer of device 0000:00:1f.5 to 64
  <6>e100: Intel(R) PRO/100 Network Driver, 3.5.23-k4-NAPI
  <6>e100: Copyright(c) 1999-2006 Intel Corporation
  <6>rtc_cmos 00:02: rtc core: registered rtc_cmos as rtc0
  <6>rtc0: alarms up to one month
  <6>parport_pc 00:09: reported by Plug and Play ACPI
  <6>intel8x0_measure_ac97_clock: measured 55447 usecs
  <6>intel8x0: clocking to 48000
  <6>ACPI: PCI Interrupt 0000:02:04.0[A] -> GSI 17 (level, low) -> IRQ 17
  <6>gameport: EMU10K1 is pci0000:02:04.1/gameport0, io 0xdc00, speed 1028kHz
  <6>ACPI: PCI Interrupt 0000:02:08.0[A] -> GSI 20 (level, low) -> IRQ 20
  <6>e100: eth0: e100_probe: addr 0xfeaff000, irq 20, MAC addr 00:07:e9:d2:37:c0
  <6>parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE,EPP]
  <6>ppdev: user-space parallel port driver
  <6>Adding 2104472k swap on /dev/sda1.  Priority:-1 extents:1 across:2104472k
  <6>device-mapper: uevent: version 1.0.3
  <6>device-mapper: ioctl: 4.13.0-ioctl (2007-10-18) initialised: dm-devel@redhat.com
  <6>loop: module loaded
  <6>kjournald starting.  Commit interval 5 seconds

-- 
Jiri Kosina
SUSE Labs
