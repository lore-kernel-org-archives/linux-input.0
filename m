From: Yanko Kaneti <yaneti@declera.com>
Subject: Re: 2.6.25-rc5.git4 regression PS/2 mouse not detected/working
Date: Mon, 17 Mar 2008 20:58:43 +0200
Message-ID: <1205780323.25146.13.camel@indigo.declera.com>
References: <1205775229.25146.11.camel@indigo.declera.com>
	 <20080317145429.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-rIEHgKv960V9PbHKGs05"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from indigo.declera.com ([212.116.131.21]:33354 "HELO
	indigo.declera.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751188AbYCQS6s (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Mar 2008 14:58:48 -0400
In-Reply-To: <20080317145429.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org


--=-rIEHgKv960V9PbHKGs05
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Mon, 2008-03-17 at 14:55 -0400, Dmitry Torokhov wrote:
> Hi,
> 
> On Mon, Mar 17, 2008 at 07:33:49PM +0200, Yanko Kaneti wrote:
> > Hi
> > 
> > My PS/2 mouse stops being detected between kernels 2.6.24.3-12.fc8 and
> > 2.6.25-0.121.rc5.git4.fc9 (which I believe do not carry any patches in
> > that area). Its an ASUS P5E-VM DO motherboard , bios revision 0506. The
> > PS/2 keyboard still works.
> > 
> > Attached are both dmesg logs with i8042.debug=1, dmidecode, lspci -vvnn
> > Tried i8042.noloop and both the mouse and keyboard stop working.
> > 
> 
> Could you please send me dmesg from booting with i8042.noloop. I would
> expect this option to help in your case so I am curious what went wrong.

Attached



--=-rIEHgKv960V9PbHKGs05
Content-Disposition: attachment; filename=dmesg-2.6.25-0.121.rc5.git4.fc9-i8042.noloop.debug
Content-Type: text/plain; name=dmesg-2.6.25-0.121.rc5.git4.fc9-i8042.noloop.debug; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Initializing cgroup subsys cpuset
Initializing cgroup subsys cpu
Linux version 2.6.25-0.121.rc5.git4.fc9 (mockbuild@) (gcc version 4.3.0 20080314 (Red Hat 4.3.0-3) (GCC) ) #1 SMP Fri Mar 14 23:14:20 EDT 2008
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003e650000 (usable)
 BIOS-e820: 000000003e650000 - 000000003e65e000 (ACPI data)
 BIOS-e820: 000000003e65e000 - 000000003e6e0000 (ACPI NVS)
 BIOS-e820: 000000003e6e0000 - 000000003e700000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffc00000 - 0000000100000000 (reserved)
102MB HIGHMEM available.
896MB LOWMEM available.
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
found SMP MP-table at [c00ff780] 000ff780
Using x86 segment limits to approximate NX protection
Entering add_active_range(0, 0, 255568) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   229376
  HighMem    229376 ->   255568
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:        0 ->   255568
On node 0 totalpages: 255568
  DMA zone: 56 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4040 pages, LIFO batch:0
  Normal zone: 3080 pages used for memmap
  Normal zone: 222200 pages, LIFO batch:31
  HighMem zone: 358 pages used for memmap
  HighMem zone: 25834 pages, LIFO batch:7
  Movable zone: 0 pages used for memmap
DMI 2.4 present.
Using APIC driver default
ACPI: RSDP 000F9A80, 0014 (r0 ACPIAM)
ACPI: RSDT 3E650000, 0040 (r1 A_M_I_ OEMRSDT  12000720 MSFT       97)
ACPI: FACP 3E650200, 0084 (r2 A_M_I_ OEMFACP  12000720 MSFT       97)
ACPI: DSDT 3E6505C0, 843B (r1  A0869 A0869001        1 INTL 20060113)
ACPI: FACS 3E65E000, 0040
ACPI: APIC 3E650390, 006C (r1 A_M_I_ OEMAPIC  12000720 MSFT       97)
ACPI: MCFG 3E650400, 003C (r1 A_M_I_ OEMMCFG  12000720 MSFT       97)
ACPI: OEMB 3E65E040, 0081 (r1 A_M_I_ AMI_OEM  12000720 MSFT       97)
ACPI: HPET 3E658A00, 0038 (r1 A_M_I_ OEMHPET  12000720 MSFT       97)
ACPI: GSCI 3E65E0D0, 2024 (r1 A_M_I_ GMCHSCI  12000720 MSFT       97)
ACPI: iEIT 3E660100, 00B0 (r1 A_M_I_ EITTABLE 12000720 MSFT       97)
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:15 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 6:15 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
ACPI: HPET id: 0xffffffff base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 40000000 (gap: 3e700000:c0700000)
PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
PM: Registered nosave memory: 00000000000a0000 - 00000000000e4000
PM: Registered nosave memory: 00000000000e4000 - 0000000000100000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 252074
Kernel command line: ro root=/dev/VolGroup00/LogVol00 i8042.noloop=1 i8042.debug=1
mapped APIC to ffffb000 (fee00000)
mapped IOAPIC to ffffa000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c081c000 soft=c07fc000
PID hash table entries: 4096 (order: 12, 16384 bytes)
Detected 1600.101 MHz processor.
Console: colour VGA+ 80x25
console [tty0] enabled
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:    8
... MAX_LOCK_DEPTH:          48
... MAX_LOCKDEP_KEYS:        2048
... CLASSHASH_SIZE:           1024
... MAX_LOCKDEP_ENTRIES:     8192
... MAX_LOCKDEP_CHAINS:      16384
... CHAINHASH_SIZE:          8192
 memory used by lock dependency info: 1024 kB
 per task-struct memory footprint: 2688 bytes
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 995836k/1022272k available (2292k kernel code, 25744k reserved, 1177k data, 576k init, 104768k highmem)
virtual kernel memory layout:
    fixmap  : 0xffc53000 - 0xfffff000   (3760 kB)
    pkmap   : 0xff400000 - 0xff800000   (4096 kB)
    vmalloc : 0xf8800000 - 0xff3fe000   ( 107 MB)
    lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
      .init : 0xc0769000 - 0xc07f9000   ( 576 kB)
      .data : 0xc063d28c - 0xc07639f0   (1177 kB)
      .text : 0xc0400000 - 0xc063d28c   (2292 kB)
Checking if this processor honours the WP bit even in supervisor mode...Ok.
CPA: page pool initialized 1 of 1 pages preallocated
SLUB: Genslabs=12, HWalign=64, Order=0-1, MinObjects=4, CPUs=2, Nodes=1
hpet clockevent registered
Calibrating delay using timer specific routine.. 3204.21 BogoMIPS (lpj=1602105)
Security Framework initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
Initializing cgroup subsys ns
Initializing cgroup subsys cpuacct
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
checking if image is initramfs... it is
Freeing initrd memory: 3241k freed
ACPI: Core revision 20070126
ACPI: Checking initramfs for custom DSDT
CPU0: Intel(R) Celeron(R) CPU        E1200  @ 1.60GHz stepping 0d
lockdep: fixing up alternatives.
Booting processor 1/1 ip 4000
CPU 1 irqstacks, hard=c081d000 soft=c07fd000
Initializing CPU#1
Calibrating delay using timer specific routine.. 3200.11 BogoMIPS (lpj=1600057)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel(R) Celeron(R) CPU        E1200  @ 1.60GHz stepping 0d
Total of 2 processors activated (6404.32 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization [CPU#0 -> CPU#1]: passed.
Brought up 2 CPUs
sizeof(vma)=84 bytes
sizeof(page)=56 bytes
sizeof(inode)=608 bytes
sizeof(dentry)=160 bytes
sizeof(ext3inode)=860 bytes
sizeof(buffer_head)=56 bytes
sizeof(skbuff)=176 bytes
sizeof(task_struct)=6544 bytes
CPU0 attaching sched-domain:
 domain 0: span 00000003
  groups: 00000001 00000002
  domain 1: span 00000003
   groups: 00000003
CPU1 attaching sched-domain:
 domain 0: span 00000003
  groups: 00000002 00000001
  domain 1: span 00000003
   groups: 00000003
khelper used greatest stack depth: 2828 bytes left
net_namespace: 620 bytes
Booting paravirtualized kernel on bare hardware
Time: 11:33:39  Date: 03/16/08
NET: Registered protocol family 16
No dock devices found.
ACPI: bus type pci registered
PCI: BIOS Bug: MCFG area at e0000000 is not E820-reserved
PCI: Not using MMCONFIG.
PCI: PCI BIOS revision 3.00 entry at 0xf0031, last bus=1
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: EC: Look up EC in DSDT
ACPI: Interpreter enabled
ACPI: (supports S0 S1 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
khelper used greatest stack depth: 2792 bytes left
ACPI: PCI Root Bridge [PCI0] (0000:00)
pci 0000:00:1f.0: quirk: region 0800-087f claimed by ICH6 ACPI/GPIO/TCO
pci 0000:00:1f.0: quirk: region 0480-04bf claimed by ICH6 GPIO
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 *15)
ACPI: PCI Interrupt Link [LNKF] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11 12 *14 15)
ACPI Warning (tbutils-0217): Incorrect checksum in table [OEMB] -  45, should be 40 [20070126]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
khelper used greatest stack depth: 2656 bytes left
pnp: PnP ACPI: found 16 devices
ACPI: ACPI bus type pnp unregistered
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 11, 12
hpet0: 4 64-bit timers, 14318180 Hz
ACPI: RTC can wake from S4
Time: tsc clocksource has been installed.
Switched to high resolution mode on CPU 0
Switched to high resolution mode on CPU 1
system 00:01: iomem range 0xfed14000-0xfed19fff has been reserved
system 00:07: ioport range 0x290-0x297 has been reserved
system 00:08: ioport range 0x4d0-0x4d1 has been reserved
system 00:08: ioport range 0x800-0x87f has been reserved
system 00:08: ioport range 0x480-0x4bf has been reserved
system 00:08: iomem range 0xfed1c000-0xfed1ffff has been reserved
system 00:08: iomem range 0xfed20000-0xfed3ffff has been reserved
system 00:08: iomem range 0xfed50000-0xfed8ffff has been reserved
system 00:08: iomem range 0xfed08000-0xfed08fff has been reserved
system 00:08: iomem range 0xff800000-0xffbfffff has been reserved
system 00:08: iomem range 0xffe80000-0xffefffff could not be reserved
system 00:08: iomem range 0xffc00000-0xffffffff could not be reserved
system 00:0b: iomem range 0xfec00000-0xfec00fff has been reserved
system 00:0b: iomem range 0xfee00000-0xfee00fff could not be reserved
system 00:0e: iomem range 0xe0000000-0xefffffff has been reserved
system 00:0f: iomem range 0x0-0x9ffff could not be reserved
system 00:0f: iomem range 0xc0000-0xcffff could not be reserved
system 00:0f: iomem range 0xe0000-0xfffff could not be reserved
system 00:0f: iomem range 0x100000-0x3e6fffff could not be reserved
system 00:0f: iomem range 0x0-0x0 could not be reserved
PCI: Bridge: 0000:00:1e.0
  IO window: e000-efff
  MEM window: 0xfeb00000-0xfebfffff
  PREFETCH window: disabled.
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 9, 2359296 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: disabled - APM is not SMP safe.
audit: initializing netlink socket (disabled)
type=2000 audit(1205667218.854:1): initialized
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
pci 0000:00:02.0: Boot video device
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: SSDT 3E6601B0, 01D2 (r1    AMI   CPU1PM        1 INTL 20060113)
ACPI: ACPI0007:00 is registered as cooling_device0
ACPI: SSDT 3E660390, 0143 (r1    AMI   CPU2PM        1 INTL 20060113)
ACPI: ACPI0007:01 is registered as cooling_device1
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
hpet_resources: 0xfed00000 is busy
Non-volatile memory driver v1.2
Linux agpgart interface v0.103
agpgart: Detected an Intel Q35 Chipset.
agpgart: Detected 7164K stolen memory.
agpgart: AGP aperture is 256M @ 0xd0000000
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:0a: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
khelper used greatest stack depth: 2580 bytes left
brd: module loaded
input: Macintosh mouse button emulation as /devices/virtual/input/input0
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
drivers/input/serio/i8042.c: 20 -> i8042 (command) [1]
drivers/input/serio/i8042.c: 65 <- i8042 (return) [1]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [1]
drivers/input/serio/i8042.c: 74 -> i8042 (parameter) [1]
drivers/input/serio/i8042.c: a9 -> i8042 (command) [1]
drivers/input/serio/i8042.c: 00 <- i8042 (return) [1]
drivers/input/serio/i8042.c: a7 -> i8042 (command) [1]
drivers/input/serio/i8042.c: 20 -> i8042 (command) [2]
drivers/input/serio/i8042.c: 74 <- i8042 (return) [2]
drivers/input/serio/i8042.c: a8 -> i8042 (command) [2]
drivers/input/serio/i8042.c: 20 -> i8042 (command) [2]
drivers/input/serio/i8042.c: 54 <- i8042 (return) [2]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [2]
drivers/input/serio/i8042.c: 74 -> i8042 (parameter) [2]
drivers/input/serio/i8042.c: Interrupt 12, without any data [2]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [2]
drivers/input/serio/i8042.c: 56 -> i8042 (parameter) [2]
drivers/input/serio/i8042.c: Interrupt 1, without any data [2]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [2]
drivers/input/serio/i8042.c: 47 -> i8042 (parameter) [3]
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
drivers/input/serio/i8042.c: f2 -> i8042 (kbd-data) [7]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [10]
drivers/input/serio/i8042.c: ab <- i8042 (interrupt, 0, 1) [12]
drivers/input/serio/i8042.c: 41 <- i8042 (interrupt, 0, 1) [13]
drivers/input/serio/i8042.c: ed -> i8042 (kbd-data) [13]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [17]
drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) [17]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [20]
drivers/input/serio/i8042.c: f3 -> i8042 (kbd-data) [20]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [28]
drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) [28]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [31]
drivers/input/serio/i8042.c: f4 -> i8042 (kbd-data) [31]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [38]
input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
drivers/input/serio/i8042.c: d4 -> i8042 (command) [42]
drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [42]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [242]
drivers/input/serio/i8042.c: ed -> i8042 (parameter) [242]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [442]
drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [442]
rtc_cmos 00:03: rtc core: registered rtc_cmos as rtc0
rtc0: alarms up to one month, y3k
cpuidle: using governor ladder
cpuidle: using governor menu
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI No-Shortcut mode
registered taskstats version 1
  Magic number: 0:378:580
  hash matches device 0000:01
Freeing unused kernel memory: 576k freed
Write protecting the kernel read-only data: 940k
ACPI: PCI Interrupt 0000:00:1a.7[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1a.7 to 64
ehci_hcd 0000:00:1a.7: EHCI Host Controller
ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1a.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1a.7
ehci_hcd 0000:00:1a.7: irq 18, io mem 0xfea7b800
ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.25-0.121.rc5.git4.fc9 ehci_hcd
usb usb1: SerialNumber: 0000:00:1a.7
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 2
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 23, io mem 0xfea7b400
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 6 ports detected
usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: EHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.25-0.121.rc5.git4.fc9 ehci_hcd
usb usb2: SerialNumber: 0000:00:1d.7
modprobe used greatest stack depth: 2064 bytes left
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1a.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1a.0 to 64
uhci_hcd 0000:00:1a.0: UHCI Host Controller
uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1a.0: irq 16, io base 0x0000d400
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: UHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.25-0.121.rc5.git4.fc9 uhci_hcd
usb usb3: SerialNumber: 0000:00:1a.0
ACPI: PCI Interrupt 0000:00:1a.1[B] -> GSI 21 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1a.1 to 64
uhci_hcd 0000:00:1a.1: UHCI Host Controller
uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1a.1: irq 21, io base 0x0000d480
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: Product: UHCI Host Controller
usb usb4: Manufacturer: Linux 2.6.25-0.121.rc5.git4.fc9 uhci_hcd
usb usb4: SerialNumber: 0000:00:1a.1
ACPI: PCI Interrupt 0000:00:1a.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1a.2 to 64
uhci_hcd 0000:00:1a.2: UHCI Host Controller
uhci_hcd 0000:00:1a.2: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1a.2: irq 18, io base 0x0000d800
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb5: Product: UHCI Host Controller
usb usb5: Manufacturer: Linux 2.6.25-0.121.rc5.git4.fc9 uhci_hcd
usb usb5: SerialNumber: 0000:00:1a.2
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 6
uhci_hcd 0000:00:1d.0: irq 23, io base 0x0000cc00
usb usb6: configuration #1 chosen from 1 choice
hub 6-0:1.0: USB hub found
hub 6-0:1.0: 2 ports detected
usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb6: Product: UHCI Host Controller
usb usb6: Manufacturer: Linux 2.6.25-0.121.rc5.git4.fc9 uhci_hcd
usb usb6: SerialNumber: 0000:00:1d.0
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 7
uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000d000
usb usb7: configuration #1 chosen from 1 choice
hub 7-0:1.0: USB hub found
hub 7-0:1.0: 2 ports detected
usb usb7: New USB device found, idVendor=1d6b, idProduct=0001
usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb7: Product: UHCI Host Controller
usb usb7: Manufacturer: Linux 2.6.25-0.121.rc5.git4.fc9 uhci_hcd
usb usb7: SerialNumber: 0000:00:1d.1
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 8
uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000d080
usb usb8: configuration #1 chosen from 1 choice
hub 8-0:1.0: USB hub found
hub 8-0:1.0: 2 ports detected
usb usb8: New USB device found, idVendor=1d6b, idProduct=0001
usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb8: Product: UHCI Host Controller
usb usb8: Manufacturer: Linux 2.6.25-0.121.rc5.git4.fc9 uhci_hcd
usb usb8: SerialNumber: 0000:00:1d.2
SCSI subsystem initialized
Driver 'sd' needs updating - please use bus_type methods
libata version 3.00 loaded.
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 22 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ACPI: PCI interrupt for device 0000:00:1f.2 disabled
ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 22 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:1f.5 to 64
ACPI: PCI interrupt for device 0000:00:1f.5 disabled
ata_piix 0000:00:1f.2: version 2.12
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 22 (level, low) -> IRQ 22
ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
PCI: Setting latency timer of device 0000:00:1f.2 to 64
scsi0 : ata_piix
scsi1 : ata_piix
ata1: SATA max UDMA/133 cmd 0xb880 ctl 0xb800 bmdma 0xb080 irq 22
ata2: SATA max UDMA/133 cmd 0xb480 ctl 0xb400 bmdma 0xb088 irq 22
ata1: SATA link down (SStatus 0 SControl 300)
ata2: SATA link down (SStatus 0 SControl 300)
ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 22 (level, low) -> IRQ 22
ata_piix 0000:00:1f.5: MAP [ P0 -- P1 -- ]
PCI: Setting latency timer of device 0000:00:1f.5 to 64
scsi2 : ata_piix
scsi3 : ata_piix
ata3: SATA max UDMA/133 cmd 0xc880 ctl 0xc800 bmdma 0xc080 irq 22
ata4: SATA max UDMA/133 cmd 0xc480 ctl 0xc400 bmdma 0xc088 irq 22
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata3.00: ATA-7: ST380215AS, 3.AAD, max UDMA/133
ata3.00: 156301488 sectors, multi 16: LBA48 NCQ (depth 0/32)
ata3.00: configured for UDMA/133
ata4: SATA link down (SStatus 0 SControl 300)
scsi 2:0:0:0: Direct-Access     ATA      ST380215AS       3.AA PQ: 0 ANSI: 5
sd 2:0:0:0: [sda] 156301488 512-byte hardware sectors (80026 MB)
sd 2:0:0:0: [sda] Write Protect is off
sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 2:0:0:0: [sda] 156301488 512-byte hardware sectors (80026 MB)
sd 2:0:0:0: [sda] Write Protect is off
sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2
sd 2:0:0:0: [sda] Attached SCSI disk
modprobe used greatest stack depth: 1168 bytes left
device-mapper: uevent: version 1.0.3
device-mapper: ioctl: 4.13.0-ioctl (2007-10-18) initialised: dm-devel@redhat.com
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
awk used greatest stack depth: 1132 bytes left
sd 2:0:0:0: Attached scsi generic sg0 type 0
ACPI: PCI Interrupt 0000:00:1f.3[C] -> GSI 18 (level, low) -> IRQ 18
e1000e: Intel(R) PRO/1000 Network Driver - 0.2.0
e1000e: Copyright (c) 1999-2007 Intel Corporation.
ACPI: PCI Interrupt 0000:00:19.0[A] -> GSI 20 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:19.0 to 64
Linux Tulip driver version 1.1.15 (Feb 27, 2007)
input: Power Button (FF) as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
ACPI: Power Button (FF) [PWRF]
input: Power Button (CM) as /devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input3
ACPI: Power Button (CM) [PWRB]
eth0: (PCI Express:2.5GB/s:Width x1) 00:1e:8c:55:86:9b
eth0: Intel(R) PRO/1000 Network Connection
eth0: MAC: 5, PHY: 6, PBA No: ffffff-0ff
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
tulip0:  MII transceiver #1 config 1000 status 786d advertising 05e1.
eth1: ADMtek Comet rev 17 at MMIO 0xfebffc00, 00:00:e8:00:01:75, IRQ 16.
ACPI: PCI Interrupt 0000:01:01.0[A] -> GSI 17 (level, low) -> IRQ 17
3c59x: Donald Becker and others.
0000:01:01.0: 3Com PCI 3c905C Tornado at f8af4800.
[drm] Initialized drm 1.1.0 20060810
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:02.0 to 64
[drm] Initialized i915 1.12.0 20071122 on minor 0
input: PC Speaker as /devices/platform/pcspkr/input/input4
parport_pc 00:06: reported by Plug and Play ACPI
parport0: PC-style at 0x378, irq 7 [PCSPP]
udev: renamed network interface eth2 to eth1
udev: renamed network interface eth1_rename to eth2
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:1b.0 to 64
ALSA sound/pci/hda/hda_intel.c:1810: chipset global capabilities = 0x4401
ALSA sound/pci/hda/hda_intel.c:749: codec_mask = 0x1
hda_codec: Unknown model for ALC883, trying auto-probe from BIOS...
ALSA sound/pci/hda/hda_codec.c:2857: autoconfig: line_outs=4 (0x14/0x15/0x16/0x17/0x0)
ALSA sound/pci/hda/hda_codec.c:2861:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
ALSA sound/pci/hda/hda_codec.c:2865:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
ALSA sound/pci/hda/hda_codec.c:2866:    mono: mono_out=0x0
ALSA sound/pci/hda/hda_codec.c:2874:    inputs: mic=0x18, fmic=0x19, line=0x1a, fline=0x0, cd=0x0, aux=0x0
ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Headphone Playback Volume, skipped
ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Speaker Playback Volume, skipped
ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Mono Playback Volume, skipped
ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Line-Out Playback Volume, skipped
ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Speaker Playback Switch, skipped
ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Mono Playback Switch, skipped
device-mapper: multipath: version 1.0.5 loaded
EXT3 FS on dm-0, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 1048568k swap on /dev/mapper/VolGroup00-LogVol01.  Priority:-1 extents:1 across:1048568k

--=-rIEHgKv960V9PbHKGs05--

