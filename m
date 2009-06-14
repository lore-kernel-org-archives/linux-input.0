From: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: 2.6.{28,30} Keyboard not working on oldish machine
Date: Sun, 14 Jun 2009 09:27:18 +0300
Message-ID: <84144f020906132327n51db29dfgc05dad98587d9f41@mail.gmail.com>
References: <20090613230842.GA18347@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f213.google.com ([209.85.220.213]:34709 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551AbZFNG1S convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 14 Jun 2009 02:27:18 -0400
In-Reply-To: <20090613230842.GA18347@gallifrey>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

(Adding some cc's.)

On Sun, Jun 14, 2009 at 2:08 AM, Dr. David Alan
Gilbert<linux@treblig.org> wrote:
> Hi,
> =A0I've got an old Pentium 90 machine that's been running a 2.4.x
> kernel for a long time, seems to work OK on a 2.6.18 kernel
> but doesn't seem to like anything newer.
>
> 2.6.30 no keyboard - but otherwise OK
> 2.6.28 no keyboard - but otherwise OK
> 2.6.26 reboots just after parsing ELF (maybe one more line)
> 2.6.25 reboots almost immediately
> 2.6.18 works OK
>
> The 2.6.18 and 26 are Debian kernels (etch and lenny), the
> rest are vanilla from git.
>
> So it looks like something got fixed between 26 and 28 that
> stops the early reboot.
>
> Attached is the .config from the 2.6.30 and a dmesg from that boot.
> /proc/interrupts shows 8 interrupts on interrupt 1 from the i8042
> but it doesn't go up if I type. =A0I've tried a couple of different
> keyboards, so I don't think it's just a dislike for the keyboard.
>
> I can see a /sys entry for the i8042 - I just don't get any input.
>
> It has an ISA VGA card (Trident 1M) (I needed the PCI slots
> for another net card!).
>
> I compiled it on a 64bit Ubuntu machine.
>
> Suggestions welcome,
>
> Dave
>
> lspci
> -----
> 00:00.0 Host bridge: Intel Corporation 82434LX/NX [Mercury/Neptune] P=
rocessor to PCI bridge (rev 11)
> 00:01.0 IDE interface: Micron PC Tech RZ1000 (rev 01)
> 00:02.0 Non-VGA unclassified device: Intel Corporation 82378ZB/IB, 82=
379AB (SIO, SIO.A) PCI to ISA Bridge (rev 03)
> 00:06.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139=
/8139C/8139C+ (rev 10)
> 00:0c.0 Ethernet controller: Intel Corporation 82557/8/9/0/1 Ethernet=
 Pro 100 (rev 08)
> 00:0e.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado=
] (rev 74)
>
> interrupts
> ----------
> =A0 =A0 =A0 =A0 =A0 CPU0
> =A00: =A0 =A0 279289 =A0 =A0XT-PIC-XT =A0 =A0 =A0 =A0timer
> =A01: =A0 =A0 =A0 =A0 =A08 =A0 =A0XT-PIC-XT =A0 =A0 =A0 =A0i8042
> =A02: =A0 =A0 =A0 =A0 =A00 =A0 =A0XT-PIC-XT =A0 =A0 =A0 =A0cascade
> =A06: =A0 =A0 =A0 =A0 =A03 =A0 =A0XT-PIC-XT =A0 =A0 =A0 =A0floppy
> =A07: =A0 =A0 =A0 =A0 =A02 =A0 =A0XT-PIC-XT
> =A08: =A0 =A0 =A0 =A0 =A02 =A0 =A0XT-PIC-XT =A0 =A0 =A0 =A0rtc0
> =A011: =A0 =A0 =A0 1385 =A0 =A0XT-PIC-XT =A0 =A0 =A0 =A0eth1, eth0, e=
th2
> =A012: =A0 =A0 =A0 =A0 =A00 =A0 =A0XT-PIC-XT =A0 =A0 =A0 =A0i8042
> =A014: =A0 =A0 =A0 4256 =A0 =A0XT-PIC-XT =A0 =A0 =A0 =A0ide0
> =A015: =A0 =A0 =A0 =A0 =A00 =A0 =A0XT-PIC-XT =A0 =A0 =A0 =A0ide1
> NMI: =A0 =A0 =A0 =A0 =A00 =A0 Non-maskable interrupts
> ERR: =A0 =A0 =A0 =A0 =A00
>
> dmesg
> -----
> [ =A0 =A00.000000] Linux version 2.6.302.6.30gort1 (dg@davros) (gcc v=
ersion 4.4.0 (Ubuntu 4.4.0-5ubuntu1) ) #2 Sat Jun 13 18:18:17 BST 2009
> [ =A0 =A00.000000] KERNEL supported cpus:
> [ =A0 =A00.000000] =A0 Intel GenuineIntel
> [ =A0 =A00.000000] =A0 AMD AuthenticAMD
> [ =A0 =A00.000000] =A0 NSC Geode by NSC
> [ =A0 =A00.000000] =A0 Cyrix CyrixInstead
> [ =A0 =A00.000000] =A0 Centaur CentaurHauls
> [ =A0 =A00.000000] =A0 Transmeta GenuineTMx86
> [ =A0 =A00.000000] =A0 Transmeta TransmetaCPU
> [ =A0 =A00.000000] =A0 UMC UMC UMC UMC
> [ =A0 =A00.000000] BIOS-provided physical RAM map:
> [ =A0 =A00.000000] =A0BIOS-88: 0000000000000000 - 000000000009f000 (u=
sable)
> [ =A0 =A00.000000] =A0BIOS-88: 0000000000100000 - 0000000004000000 (u=
sable)
> [ =A0 =A00.000000] DMI not present or invalid.
> [ =A0 =A00.000000] last_pfn =3D 0x4000 max_arch_pfn =3D 0x100000
> [ =A0 =A00.000000] e820 update range: 0000000000001000 - 000000000001=
0000 (usable) =3D=3D> (reserved)
> [ =A0 =A00.000000] Scanning 1 areas for low memory corruption
> [ =A0 =A00.000000] modified physical RAM map:
> [ =A0 =A00.000000] =A0modified: 0000000000000000 - 0000000000001000 (=
usable)
> [ =A0 =A00.000000] =A0modified: 0000000000001000 - 0000000000010000 (=
reserved)
> [ =A0 =A00.000000] =A0modified: 0000000000010000 - 000000000009f000 (=
usable)
> [ =A0 =A00.000000] =A0modified: 0000000000100000 - 0000000004000000 (=
usable)
> [ =A0 =A00.000000] init_memory_mapping: 0000000000000000-000000000400=
0000
> [ =A0 =A00.000000] =A00000000000 - 0000400000 page 4k
> [ =A0 =A00.000000] =A00000400000 - 0004000000 page 2M
> [ =A0 =A00.000000] kernel direct mapping tables up to 4000000 @ 10000=
-14000
> [ =A0 =A00.000000] 64MB LOWMEM available.
> [ =A0 =A00.000000] =A0 mapped low ram: 0 - 04000000
> [ =A0 =A00.000000] =A0 low ram: 0 - 04000000
> [ =A0 =A00.000000] =A0 node 0 low ram: 00000000 - 04000000
> [ =A0 =A00.000000] =A0 node 0 bootmap 00010000 - 00010800
> [ =A0 =A00.000000] (5 early reservations) =3D=3D> bootmem [0000000000=
 - 0004000000]
> [ =A0 =A00.000000] =A0 #0 [0000000000 - 0000001000] =A0 BIOS data pag=
e =3D=3D> [0000000000 - 0000001000]
> [ =A0 =A00.000000] =A0 #1 [0000200000 - 0000659c1c] =A0 =A0TEXT DATA =
BSS =3D=3D> [0000200000 - 0000659c1c]
> [ =A0 =A00.000000] =A0 #2 [000009fc00 - 0000100000] =A0 =A0BIOS reser=
ved =3D=3D> [000009fc00 - 0000100000]
> [ =A0 =A00.000000] =A0 #3 [000065a000 - 000065c000] =A0 =A0 =A0 =A0 =A0=
 =A0 =A0BRK =3D=3D> [000065a000 - 000065c000]
> [ =A0 =A00.000000] =A0 #4 [0000010000 - 0000011000] =A0 =A0 =A0 =A0 =A0=
BOOTMAP =3D=3D> [0000010000 - 0000011000]
> [ =A0 =A00.000000] Zone PFN ranges:
> [ =A0 =A00.000000] =A0 DMA =A0 =A0 =A00x00000000 -> 0x00001000
> [ =A0 =A00.000000] =A0 Normal =A0 0x00001000 -> 0x00004000
> [ =A0 =A00.000000] Movable zone start PFN for each node
> [ =A0 =A00.000000] early_node_map[3] active PFN ranges
> [ =A0 =A00.000000] =A0 =A0 0: 0x00000000 -> 0x00000001
> [ =A0 =A00.000000] =A0 =A0 0: 0x00000010 -> 0x0000009f
> [ =A0 =A00.000000] =A0 =A0 0: 0x00000100 -> 0x00004000
> [ =A0 =A00.000000] On node 0 totalpages: 16272
> [ =A0 =A00.000000] free_area_init_node: node 0, pgdat c059a814, node_=
mem_map c1000000
> [ =A0 =A00.000000] =A0 DMA zone: 32 pages used for memmap
> [ =A0 =A00.000000] =A0 DMA zone: 0 pages reserved
> [ =A0 =A00.000000] =A0 DMA zone: 3952 pages, LIFO batch:0
> [ =A0 =A00.000000] =A0 Normal zone: 96 pages used for memmap
> [ =A0 =A00.000000] =A0 Normal zone: 12192 pages, LIFO batch:1
> [ =A0 =A00.000000] Allocating PCI resources starting at 10000000 (gap=
: 4000000:fc000000)
> [ =A0 =A00.000000] Built 1 zonelists in Zone order, mobility grouping=
 on. =A0Total pages: 16144
> [ =A0 =A00.000000] Kernel command line: root=3D/dev/hda3 ro
> [ =A0 =A00.000000] Initializing CPU#0
> [ =A0 =A00.000000] NR_IRQS:16
> [ =A0 =A00.000000] PID hash table entries: 256 (order: 8, 1024 bytes)
> [ =A0 =A00.000000] Fast TSC calibration using PIT
> [ =A0 =A00.000000] Detected 90.194 MHz processor.
> [ =A0 =A00.004000] Console: colour VGA+ 80x25
> [ =A0 =A00.004000] console [tty0] enabled
> [ =A0 =A00.004000] Dentry cache hash table entries: 8192 (order: 3, 3=
2768 bytes)
> [ =A0 =A00.004000] Inode-cache hash table entries: 4096 (order: 2, 16=
384 bytes)
> [ =A0 =A00.004000] Memory: 60032k/65536k available (2565k kernel code=
, 5032k reserved, 1185k data, 220k init, 0k highmem)
> [ =A0 =A00.004000] virtual kernel memory layout:
> [ =A0 =A00.004000] =A0 =A0 fixmap =A0: 0xfffeb000 - 0xfffff000 =A0 ( =
=A080 kB)
> [ =A0 =A00.004000] =A0 =A0 vmalloc : 0xc4800000 - 0xfffe9000 =A0 ( 95=
1 MB)
> [ =A0 =A00.004000] =A0 =A0 lowmem =A0: 0xc0000000 - 0xc4000000 =A0 ( =
=A064 MB)
> [ =A0 =A00.004000] =A0 =A0 =A0 .init : 0xc05ac000 - 0xc05e3000 =A0 ( =
220 kB)
> [ =A0 =A00.004000] =A0 =A0 =A0 .data : 0xc0481560 - 0xc05a9ad4 =A0 (1=
185 kB)
> [ =A0 =A00.004000] =A0 =A0 =A0 .text : 0xc0200000 - 0xc0481560 =A0 (2=
565 kB)
> [ =A0 =A00.004000] Checking if this processor honours the WP bit even=
 in supervisor mode...Ok.
> [ =A0 =A00.004000] SLUB: Genslabs=3D13, HWalign=3D32, Order=3D0-3, Mi=
nObjects=3D0, CPUs=3D1, Nodes=3D1
> [ =A0 =A00.004105] Calibrating delay loop (skipped), value calculated=
 using timer frequency.. 180.38 BogoMIPS (lpj=3D360776)
> [ =A0 =A00.005249] Security Framework initialized
> [ =A0 =A00.005658] SELinux: =A0Disabled at boot.
> [ =A0 =A00.006136] Mount-cache hash table entries: 512
> [ =A0 =A00.009959] Intel Pentium with F0 0F bug - workaround enabled.
> [ =A0 =A00.010356]
> [ =A0 =A00.010925] CPU: Intel Pentium 75 - 200 stepping 04
> [ =A0 =A00.011597] Checking 'hlt' instruction... OK.
> [ =A0 =A00.037920] net_namespace: 560 bytes
> [ =A0 =A00.045603] NET: Registered protocol family 16
> [ =A0 =A00.063141] PCI: PCI BIOS revision 2.00 entry at 0xf3940, last=
 bus=3D0
> [ =A0 =A00.063555] PCI: Using configuration type 1 for base access
> [ =A0 =A00.203103] bio: create slab <bio-0> at 0
> [ =A0 =A00.224508] PCI: Probing PCI hardware
> [ =A0 =A00.224894] PCI: Probing PCI hardware (bus 00)
> [ =A0 =A00.227218] pci 0000:00:01.0: reg 10 io port: [0x1f0-0x1f7]
> [ =A0 =A00.227350] pci 0000:00:01.0: reg 14 io port: [0x3f4-0x3f7]
> [ =A0 =A00.227954] pci 0000:00:06.0: reg 10 io port: [0xfc80-0xfcff]
> [ =A0 =A00.228392] pci 0000:00:06.0: reg 14 32bit mmio: [0xffbfff80-0=
xffbfffff]
> [ =A0 =A00.228825] pci 0000:00:0c.0: reg 10 32bit mmio: [0xffbef000-0=
xffbeffff]
> [ =A0 =A00.228960] pci 0000:00:0c.0: reg 14 io port: [0xfc40-0xfc7f]
> [ =A0 =A00.229088] pci 0000:00:0c.0: reg 18 32bit mmio: [0xffa00000-0=
xffafffff]
> [ =A0 =A00.229251] pci 0000:00:0c.0: reg 30 32bit mmio: [0xfe000000-0=
xfe0fffff]
> [ =A0 =A00.229425] pci 0000:00:0c.0: supports D1 D2
> [ =A0 =A00.229514] pci 0000:00:0c.0: PME# supported from D0 D1 D2 D3h=
ot
> [ =A0 =A00.229926] pci 0000:00:0c.0: PME# disabled
> [ =A0 =A00.230498] pci 0000:00:0e.0: reg 10 io port: [0xf880-0xf8ff]
> [ =A0 =A00.230634] pci 0000:00:0e.0: reg 14 32bit mmio: [0xffbdff80-0=
xffbdffff]
> [ =A0 =A00.230811] pci 0000:00:0e.0: reg 30 32bit mmio: [0xfe000000-0=
xfe01ffff]
> [ =A0 =A00.230976] pci 0000:00:0e.0: supports D1 D2
> [ =A0 =A00.231064] pci 0000:00:0e.0: PME# supported from D0 D1 D2 D3h=
ot
> [ =A0 =A00.231462] pci 0000:00:0e.0: PME# disabled
> [ =A0 =A00.250198] NetLabel: Initializing
> [ =A0 =A00.250567] NetLabel: =A0domain hash size =3D 128
> [ =A0 =A00.250904] NetLabel: =A0protocols =3D UNLABELED CIPSOv4
> [ =A0 =A00.251685] NetLabel: =A0unlabeled traffic allowed by default
> [ =A0 =A00.254639] Slow work thread pool: Starting up
> [ =A0 =A00.256856] Slow work thread pool: Ready
> [ =A0 =A00.257403] FS-Cache: Loaded
> [ =A0 =A00.259569] CacheFiles: Loaded
> [ =A0 =A00.278072] pci_bus 0000:00: resource 0 io: =A0[0x00-0xffff]
> [ =A0 =A00.278186] pci_bus 0000:00: resource 1 mem: [0x000000-0xfffff=
fff]
> [ =A0 =A00.278982] NET: Registered protocol family 2
> [ =A0 =A00.282180] IP route cache hash table entries: 1024 (order: 0,=
 4096 bytes)
> [ =A0 =A00.289678] TCP established hash table entries: 2048 (order: 2=
, 16384 bytes)
> [ =A0 =A00.290702] TCP bind hash table entries: 2048 (order: 1, 8192 =
bytes)
> [ =A0 =A00.291383] TCP: Hash tables configured (established 2048 bind=
 2048)
> [ =A0 =A00.291775] TCP reno registered
> [ =A0 =A00.293865] NET: Registered protocol family 1
> [ =A0 =A00.302847] platform rtc_cmos: registered platform RTC device =
(no PNP device found)
> [ =A0 =A00.305094] Scanning for low memory corruption every 60 second=
s
> [ =A0 =A00.314357] audit: initializing netlink socket (disabled)
> [ =A0 =A00.314956] type=3D2000 audit(1244914801.311:1): initialized
> [ =A0 =A00.453503] NTFS driver 2.1.29 [Flags: R/O].
> [ =A0 =A00.461983] msgmni has been set to 117
> [ =A0 =A00.468627] alg: No test for cipher_null (cipher_null-generic)
> [ =A0 =A00.469986] alg: No test for ecb(cipher_null) (ecb-cipher_null=
)
> [ =A0 =A00.471314] alg: No test for digest_null (digest_null-generic)
> [ =A0 =A00.472751] alg: No test for compress_null (compress_null-gene=
ric)
> [ =A0 =A00.545552] alg: No test for stdrng (krng)
> [ =A0 =A00.546900] alg: No test for stdrng (ansi_cprng)
> [ =A0 =A00.547678] io scheduler noop registered
> [ =A0 =A00.548283] io scheduler deadline registered (default)
> [ =A0 =A00.549881] isapnp: Scanning for PnP cards...
> [ =A0 =A00.906676] isapnp: No Plug & Play device found
> [ =A0 =A01.042776] lp: driver loaded but no devices found
> [ =A0 =A01.045360] Non-volatile memory driver v1.3
> [ =A0 =A01.047261] ppdev: user-space parallel port driver
> [ =A0 =A01.047673] Hangcheck: starting hangcheck timer 0.9.0 (tick is=
 180 seconds, margin is 60 seconds).
> [ =A0 =A01.048339] Hangcheck: Using get_cycles().
> [ =A0 =A01.048766] Serial: 8250/16550 driver, 4 ports, IRQ sharing en=
abled
> [ =A0 =A01.051655] serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16=
550A
> [ =A0 =A01.054528] serial8250: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16=
550A
> [ =A0 =A01.057112] serial8250: ttyS2 at I/O 0x3e8 (irq =3D 4) is a 16=
550A
> [ =A0 =A01.059625] serial8250: ttyS3 at I/O 0x2e8 (irq =3D 3) is a 16=
550A
> [ =A0 =A01.076882] parport0: PC-style at 0x378 [PCSPP,EPP]
> [ =A0 =A01.177517] lp0: using parport0 (polling).
> [ =A0 =A01.179798] parport1: PC-style at 0x278 (0x678) [PCSPP,TRISTAT=
E]
> [ =A0 =A01.309938] parport1: irq 7 detected
> [ =A0 =A01.409631] lp1: using parport1 (polling).
> [ =A0 =A01.417488] Floppy drive(s): fd0 is 1.44M, fd1 is 1.2M
> [ =A0 =A01.436665] FDC 0 is a post-1991 82077
> [ =A0 =A01.481588] loop: module loaded
> [ =A0 =A01.481946] Uniform Multi-Platform E-IDE driver
> [ =A0 =A01.485696] 0000:00:01.0: disabled chipset read-ahead (buggy R=
Z1000/RZ1001)
> [ =A0 =A01.486169] rz1000 0000:00:01.0: IDE controller (0x1042:0x1000=
 rev 0x01)
> [ =A0 =A01.486991] rz1000 0000:00:01.0: not 100% native mode: will pr=
obe irqs later
> [ =A0 =A01.487458] Probing IDE interface ide0...
> [ =A0 =A01.776529] hda: IBM-DCAA-33610, ATA DISK drive
> [ =A0 =A02.280441] hdb: GCD-R542B, ATAPI CD/DVD-ROM drive
> [ =A0 =A02.282829] Probing IDE interface ide1...
> [ =A0 =A02.850533] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> [ =A0 =A02.851548] ide1 at 0x170-0x177,0x376 on irq 15
> [ =A0 =A02.858113] ide-gd driver 1.18
> [ =A0 =A02.859043] hda: max request size: 128KiB
> [ =A0 =A02.859427] hda: 7056000 sectors (3612 MB) w/96KiB Cache, CHS=3D=
7000/16/63
> [ =A0 =A02.860045] hda: cache flushes not supported
> [ =A0 =A02.861373] =A0hda: hda1 hda2 < hda5 > hda3
> [ =A0 =A02.919259] ide-cd driver 5.00
> [ =A0 =A02.924195] ide-cd: hdb: ATAPI 4X CD-ROM drive, 256kB Cache
> [ =A0 =A02.925339] Uniform CD-ROM driver Revision: 3.20
> [ =A0 =A02.944818] 3c59x: Donald Becker and others.
> [ =A0 =A02.945334] 0000:00:0e.0: 3Com PCI 3c905C Tornado at c48f0f80.
> [ =A0 =A02.979186] e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-N=
API
> [ =A0 =A02.979598] e100: Copyright(c) 1999-2006 Intel Corporation
> [ =A0 =A03.008016] e100 0000:00:0c.0: PME# disabled
> [ =A0 =A03.017088] e100: eth1: e100_probe: addr 0xffbef000, irq 11, M=
AC addr 00:d0:b7:bf:81:57
> [ =A0 =A03.074566] Fixed MDIO Bus: probed
> [ =A0 =A03.110073] 8139cp: 10/100 PCI Ethernet driver v1.3 (Mar 22, 2=
004)
> [ =A0 =A03.110542] 8139cp 0000:00:06.0: This (id 10ec:8139 rev 10) is=
 not an 8139C+ compatible chip, use 8139too
> [ =A0 =A03.113076] 8139too Fast Ethernet driver 0.9.28
> [ =A0 =A03.124933] eth2: RealTek RTL8139 at 0xfc80, 00:20:18:88:7a:c1=
, IRQ 11
> [ =A0 =A03.125361] eth2: =A0Identified 8139 chip type 'RTL-8139 rev K=
'
> [ =A0 =A03.127080] tun: Universal TUN/TAP device driver, 1.6
> [ =A0 =A03.127464] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.=
com>
> [ =A0 =A03.129775] dmfe: Davicom DM9xxx net driver, version 1.36.4 (2=
002-01-17)
> [ =A0 =A03.131792] winbond-840.c:v1.01-e (2.4 port) Sep-11-2006 =A0Do=
nald Becker <becker@scyld.com>
> [ =A0 =A03.131866] =A0 http://www.scyld.com/network/drivers.html
> [ =A0 =A03.139302] uli526x: ULi M5261/M5263 net driver, version 0.9.3=
 (2005-7-29)
> [ =A0 =A03.147416] PNP: No PS/2 controller found. Probing ports direc=
tly.
> [ =A0 =A03.174456] serio: i8042 KBD port at 0x60,0x64 irq 1
> [ =A0 =A03.174961] serio: i8042 AUX port at 0x60,0x64 irq 12
> [ =A0 =A03.186312] mice: PS/2 mouse device common for all mice
> [ =A0 =A03.194043] input: PC Speaker as /devices/platform/pcspkr/inpu=
t/input0
> [ =A0 =A03.196976] evbug.c: Connected device: input0 (PC Speaker at i=
sa0061/input0)
> [ =A0 =A03.203133] rtc_cmos rtc_cmos: rtc core: registered rtc_cmos a=
s rtc0
> [ =A0 =A03.203722] rtc0: alarms up to one day, 114 bytes nvram
> [ =A0 =A03.215553] input: AT Translated Set 2 keyboard as /devices/pl=
atform/i8042/serio0/input/input1
> [ =A0 =A03.219608] evbug.c: Connected device: input1 (AT Translated S=
et 2 keyboard at isa0060/serio0/input0)
> [ =A0 =A03.249229] rtc-test rtc-test.0: rtc core: registered test as =
rtc1
> [ =A0 =A03.253953] rtc-test rtc-test.1: rtc core: registered test as =
rtc2
> [ =A0 =A03.257647] Driver for 1-wire Dallas network protocol.
> [ =A0 =A03.262943] 1-Wire driver for the DS2760 battery monitor =A0ch=
ip =A0- (c) 2004-2005, Szabolcs Gyurko
> [ =A0 =A03.263566] cpuidle: using governor ladder
> [ =A0 =A03.263920] cpuidle: using governor menu
> [ =A0 =A03.267648] NET: Registered protocol family 26
> [ =A0 =A03.272750] GACT probability on
> [ =A0 =A03.273085] Mirror/redirect action on
> [ =A0 =A03.273426] Simple TC action Loaded
> [ =A0 =A03.285515] netem: version 1.2
> [ =A0 =A03.285870] u32 classifier
> [ =A0 =A03.286174] =A0 =A0 Actions configured
> [ =A0 =A03.286541] Netfilter messages via NETLINK v0.30.
> [ =A0 =A03.287376] nf_conntrack version 0.5.0 (1024 buckets, 4096 max=
)
> [ =A0 =A03.294582] CONFIG_NF_CT_ACCT is deprecated and will be remove=
d soon. Please use
> [ =A0 =A03.295145] nf_conntrack.acct=3D1 kernel paramater, acct=3D1 n=
f_conntrack module option or
> [ =A0 =A03.295686] sysctl net.netfilter.nf_conntrack_acct=3D1 to enab=
le it.
> [ =A0 =A03.303380] ctnetlink v0.93: registering with nfnetlink.
> [ =A0 =A03.304032] NF_TPROXY: Transparent proxy support initialized, =
version 4.1.0
> [ =A0 =A03.304442] NF_TPROXY: Copyright (c) 2006-2007 BalaBit IT Ltd.
> [ =A0 =A03.305711] xt_time: kernel timezone is -0000
> [ =A0 =A03.309307] IPVS: Registered protocols (TCP, UDP, AH, ESP)
> [ =A0 =A03.310231] IPVS: Connection hash table configured (size=3D409=
6, memory=3D32Kbytes)
> [ =A0 =A03.312122] IPVS: ipvs loaded.
> [ =A0 =A03.312470] IPVS: [rr] scheduler registered.
> [ =A0 =A03.312936] IPVS: [wrr] scheduler registered.
> [ =A0 =A03.313300] IPVS: [lc] scheduler registered.
> [ =A0 =A03.313652] IPVS: [wlc] scheduler registered.
> [ =A0 =A03.314562] IPVS: [lblc] scheduler registered.
> [ =A0 =A03.315414] IPVS: [lblcr] scheduler registered.
> [ =A0 =A03.315784] IPVS: [dh] scheduler registered.
> [ =A0 =A03.316137] IPVS: [sh] scheduler registered.
> [ =A0 =A03.316491] IPVS: [sed] scheduler registered.
> [ =A0 =A03.316951] IPVS: [nq] scheduler registered.
> [ =A0 =A03.317365] IPVS: ftp: loaded support on port[0] =3D 21
> [ =A0 =A03.337415] IPv4 over IPv4 tunneling driver
> [ =A0 =A03.368805] ip_tables: (C) 2000-2006 Netfilter Core Team
> [ =A0 =A03.369907] ClusterIP Version 0.8 loaded successfully
> [ =A0 =A03.370885] arp_tables: (C) 2002 David S. Miller
> [ =A0 =A03.372316] TCP bic registered
> [ =A0 =A03.372788] TCP cubic registered
> [ =A0 =A03.373130] TCP westwood registered
> [ =A0 =A03.373465] TCP highspeed registered
> [ =A0 =A03.373800] TCP hybla registered
> [ =A0 =A03.374127] TCP htcp registered
> [ =A0 =A03.374448] TCP vegas registered
> [ =A0 =A03.374768] TCP veno registered
> [ =A0 =A03.375091] TCP scalable registered
> [ =A0 =A03.375423] TCP lp registered
> [ =A0 =A03.375746] TCP yeah registered
> [ =A0 =A03.376071] TCP illinois registered
> [ =A0 =A03.376420] NET: Registered protocol family 17
> [ =A0 =A03.379007] Bridge firewalling registered
> [ =A0 =A03.379446] Ebtables v2.0 registered
> [ =A0 =A03.380415] ebt_ulog: out of memory trying to call netlink_ker=
nel_create
> [ =A0 =A03.384957] NET: Registered protocol family 33
> [ =A0 =A03.387113] SCTP: Hash tables configured (established 2048 bin=
d 4096)
> [ =A0 =A03.405089] rtc_cmos rtc_cmos: setting system clock to 2009-06=
-13 17:40:04 UTC (1244914804)
> [ =A0 =A03.672471] kjournald starting. =A0Commit interval 5 seconds
> [ =A0 =A03.673126] EXT3-fs: mounted filesystem with writeback data mo=
de.
> [ =A0 =A03.673707] VFS: Mounted root (ext3 filesystem) readonly on de=
vice 3:3.
> [ =A0 =A03.675074] Freeing unused kernel memory: 220k freed
> [ =A0 =A03.684853] Write protecting the kernel text: 2568k
> [ =A0 =A03.685603] Write protecting the kernel read-only data: 944k
> [ =A0 48.003003] Adding 176672k swap on /dev/hda5. =A0Priority:-1 ext=
ents:1 across:176672k
> [ =A0 49.531291] EXT3 FS on hda3, internal journal
> [ =A0 57.529885] kjournald starting. =A0Commit interval 5 seconds
> [ =A0 57.531941] EXT3 FS on hda1, internal journal
> [ =A0 57.532428] EXT3-fs: mounted filesystem with writeback data mode=
=2E
> [ =A0 66.173547] e100 0000:00:0c.0: firmware: using built-in firmware=
 e100/d101m_ucode.bin
> [ =A0 66.579827] eth0: link down
> [ =A0 68.844244] e100: eth1 NIC Link is Up 100 Mbps Full Duplex
> [ =A0 75.741037] eth2: =A0setting full-duplex.
> [ =A0130.761741] warning: `ntpd' uses 32-bit capabilities (legacy sup=
port in use)
> [ =A0650.173418] eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
>
> config
> ------
> #
> # Automatically generated make config: don't edit
> # Linux kernel version: 2.6.30
> # Sat Jun 13 18:11:36 2009
> #
> # CONFIG_64BIT is not set
> CONFIG_X86_32=3Dy
> # CONFIG_X86_64 is not set
> CONFIG_X86=3Dy
> CONFIG_ARCH_DEFCONFIG=3D"arch/x86/configs/i386_defconfig"
> CONFIG_GENERIC_TIME=3Dy
> CONFIG_GENERIC_CMOS_UPDATE=3Dy
> CONFIG_CLOCKSOURCE_WATCHDOG=3Dy
> CONFIG_GENERIC_CLOCKEVENTS=3Dy
> CONFIG_LOCKDEP_SUPPORT=3Dy
> CONFIG_STACKTRACE_SUPPORT=3Dy
> CONFIG_HAVE_LATENCYTOP_SUPPORT=3Dy
> CONFIG_FAST_CMPXCHG_LOCAL=3Dy
> CONFIG_MMU=3Dy
> CONFIG_ZONE_DMA=3Dy
> CONFIG_GENERIC_ISA_DMA=3Dy
> CONFIG_GENERIC_IOMAP=3Dy
> CONFIG_GENERIC_BUG=3Dy
> CONFIG_GENERIC_HWEIGHT=3Dy
> CONFIG_ARCH_MAY_HAVE_PC_FDC=3Dy
> # CONFIG_RWSEM_GENERIC_SPINLOCK is not set
> CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
> CONFIG_ARCH_HAS_CPU_IDLE_WAIT=3Dy
> CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
> # CONFIG_GENERIC_TIME_VSYSCALL is not set
> CONFIG_ARCH_HAS_CPU_RELAX=3Dy
> CONFIG_ARCH_HAS_DEFAULT_IDLE=3Dy
> CONFIG_ARCH_HAS_CACHE_LINE_SIZE=3Dy
> CONFIG_HAVE_SETUP_PER_CPU_AREA=3Dy
> CONFIG_HAVE_DYNAMIC_PER_CPU_AREA=3Dy
> # CONFIG_HAVE_CPUMASK_OF_CPU_MAP is not set
> CONFIG_ARCH_HIBERNATION_POSSIBLE=3Dy
> CONFIG_ARCH_SUSPEND_POSSIBLE=3Dy
> # CONFIG_ZONE_DMA32 is not set
> CONFIG_ARCH_POPULATES_NODE_MAP=3Dy
> # CONFIG_AUDIT_ARCH is not set
> CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=3Dy
> CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=3Dy
> CONFIG_GENERIC_HARDIRQS=3Dy
> CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=3Dy
> CONFIG_GENERIC_IRQ_PROBE=3Dy
> CONFIG_KTIME_SCALAR=3Dy
> CONFIG_DEFCONFIG_LIST=3D"/lib/modules/$UNAME_RELEASE/.config"
>
> #
> # General setup
> #
> CONFIG_EXPERIMENTAL=3Dy
> CONFIG_BROKEN_ON_SMP=3Dy
> CONFIG_INIT_ENV_ARG_LIMIT=3D32
> CONFIG_LOCALVERSION=3D"2.6.30gort1"
> # CONFIG_LOCALVERSION_AUTO is not set
> CONFIG_HAVE_KERNEL_GZIP=3Dy
> CONFIG_HAVE_KERNEL_BZIP2=3Dy
> CONFIG_HAVE_KERNEL_LZMA=3Dy
> CONFIG_KERNEL_GZIP=3Dy
> # CONFIG_KERNEL_BZIP2 is not set
> # CONFIG_KERNEL_LZMA is not set
> CONFIG_SWAP=3Dy
> CONFIG_SYSVIPC=3Dy
> CONFIG_SYSVIPC_SYSCTL=3Dy
> CONFIG_POSIX_MQUEUE=3Dy
> CONFIG_POSIX_MQUEUE_SYSCTL=3Dy
> # CONFIG_BSD_PROCESS_ACCT is not set
> # CONFIG_TASKSTATS is not set
> CONFIG_AUDIT=3Dy
> CONFIG_AUDITSYSCALL=3Dy
> CONFIG_AUDIT_TREE=3Dy
>
> #
> # RCU Subsystem
> #
> CONFIG_CLASSIC_RCU=3Dy
> # CONFIG_TREE_RCU is not set
> # CONFIG_PREEMPT_RCU is not set
> # CONFIG_TREE_RCU_TRACE is not set
> # CONFIG_PREEMPT_RCU_TRACE is not set
> # CONFIG_IKCONFIG is not set
> CONFIG_LOG_BUF_SHIFT=3D17
> CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=3Dy
> # CONFIG_GROUP_SCHED is not set
> # CONFIG_CGROUPS is not set
> # CONFIG_SYSFS_DEPRECATED_V2 is not set
> CONFIG_RELAY=3Dy
> CONFIG_NAMESPACES=3Dy
> CONFIG_UTS_NS=3Dy
> CONFIG_IPC_NS=3Dy
> # CONFIG_USER_NS is not set
> # CONFIG_PID_NS is not set
> CONFIG_NET_NS=3Dy
> # CONFIG_BLK_DEV_INITRD is not set
> CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy
> CONFIG_SYSCTL=3Dy
> CONFIG_ANON_INODES=3Dy
> # CONFIG_EMBEDDED is not set
> CONFIG_UID16=3Dy
> CONFIG_SYSCTL_SYSCALL=3Dy
> CONFIG_KALLSYMS=3Dy
> CONFIG_KALLSYMS_ALL=3Dy
> # CONFIG_KALLSYMS_EXTRA_PASS is not set
> # CONFIG_STRIP_ASM_SYMS is not set
> CONFIG_HOTPLUG=3Dy
> CONFIG_PRINTK=3Dy
> CONFIG_BUG=3Dy
> CONFIG_ELF_CORE=3Dy
> CONFIG_PCSPKR_PLATFORM=3Dy
> CONFIG_BASE_FULL=3Dy
> CONFIG_FUTEX=3Dy
> CONFIG_EPOLL=3Dy
> CONFIG_SIGNALFD=3Dy
> CONFIG_TIMERFD=3Dy
> CONFIG_EVENTFD=3Dy
> CONFIG_SHMEM=3Dy
> CONFIG_AIO=3Dy
> CONFIG_VM_EVENT_COUNTERS=3Dy
> CONFIG_PCI_QUIRKS=3Dy
> CONFIG_SLUB_DEBUG=3Dy
> # CONFIG_COMPAT_BRK is not set
> # CONFIG_SLAB is not set
> CONFIG_SLUB=3Dy
> # CONFIG_SLOB is not set
> # CONFIG_PROFILING is not set
> CONFIG_TRACEPOINTS=3Dy
> CONFIG_MARKERS=3Dy
> CONFIG_HAVE_OPROFILE=3Dy
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=3Dy
> CONFIG_HAVE_IOREMAP_PROT=3Dy
> CONFIG_HAVE_KPROBES=3Dy
> CONFIG_HAVE_KRETPROBES=3Dy
> CONFIG_HAVE_ARCH_TRACEHOOK=3Dy
> CONFIG_HAVE_DMA_API_DEBUG=3Dy
> CONFIG_SLOW_WORK=3Dy
> CONFIG_HAVE_GENERIC_DMA_COHERENT=3Dy
> CONFIG_SLABINFO=3Dy
> CONFIG_RT_MUTEXES=3Dy
> CONFIG_BASE_SMALL=3D0
> # CONFIG_MODULES is not set
> CONFIG_BLOCK=3Dy
> # CONFIG_LBD is not set
> # CONFIG_BLK_DEV_BSG is not set
> # CONFIG_BLK_DEV_INTEGRITY is not set
>
> #
> # IO Schedulers
> #
> CONFIG_IOSCHED_NOOP=3Dy
> # CONFIG_IOSCHED_AS is not set
> CONFIG_IOSCHED_DEADLINE=3Dy
> # CONFIG_IOSCHED_CFQ is not set
> # CONFIG_DEFAULT_AS is not set
> CONFIG_DEFAULT_DEADLINE=3Dy
> # CONFIG_DEFAULT_CFQ is not set
> # CONFIG_DEFAULT_NOOP is not set
> CONFIG_DEFAULT_IOSCHED=3D"deadline"
> # CONFIG_FREEZER is not set
>
> #
> # Processor type and features
> #
> CONFIG_TICK_ONESHOT=3Dy
> CONFIG_NO_HZ=3Dy
> CONFIG_HIGH_RES_TIMERS=3Dy
> CONFIG_GENERIC_CLOCKEVENTS_BUILD=3Dy
> # CONFIG_SMP is not set
> # CONFIG_X86_EXTENDED_PLATFORM is not set
> CONFIG_SCHED_OMIT_FRAME_POINTER=3Dy
> # CONFIG_PARAVIRT_GUEST is not set
> # CONFIG_MEMTEST is not set
> # CONFIG_M386 is not set
> # CONFIG_M486 is not set
> # CONFIG_M586 is not set
> CONFIG_M586TSC=3Dy
> # CONFIG_M586MMX is not set
> # CONFIG_M686 is not set
> # CONFIG_MPENTIUMII is not set
> # CONFIG_MPENTIUMIII is not set
> # CONFIG_MPENTIUMM is not set
> # CONFIG_MPENTIUM4 is not set
> # CONFIG_MK6 is not set
> # CONFIG_MK7 is not set
> # CONFIG_MK8 is not set
> # CONFIG_MCRUSOE is not set
> # CONFIG_MEFFICEON is not set
> # CONFIG_MWINCHIPC6 is not set
> # CONFIG_MWINCHIP3D is not set
> # CONFIG_MGEODEGX1 is not set
> # CONFIG_MGEODE_LX is not set
> # CONFIG_MCYRIXIII is not set
> # CONFIG_MVIAC3_2 is not set
> # CONFIG_MVIAC7 is not set
> # CONFIG_MPSC is not set
> # CONFIG_MCORE2 is not set
> # CONFIG_GENERIC_CPU is not set
> CONFIG_X86_GENERIC=3Dy
> CONFIG_X86_CPU=3Dy
> CONFIG_X86_L1_CACHE_BYTES=3D64
> CONFIG_X86_INTERNODE_CACHE_BYTES=3D64
> CONFIG_X86_CMPXCHG=3Dy
> CONFIG_X86_L1_CACHE_SHIFT=3D5
> CONFIG_X86_XADD=3Dy
> # CONFIG_X86_PPRO_FENCE is not set
> CONFIG_X86_F00F_BUG=3Dy
> CONFIG_X86_WP_WORKS_OK=3Dy
> CONFIG_X86_INVLPG=3Dy
> CONFIG_X86_BSWAP=3Dy
> CONFIG_X86_POPAD_OK=3Dy
> CONFIG_X86_ALIGNMENT_16=3Dy
> CONFIG_X86_INTEL_USERCOPY=3Dy
> CONFIG_X86_TSC=3Dy
> CONFIG_X86_MINIMUM_CPU_FAMILY=3D4
> CONFIG_CPU_SUP_INTEL=3Dy
> CONFIG_CPU_SUP_CYRIX_32=3Dy
> CONFIG_CPU_SUP_AMD=3Dy
> CONFIG_CPU_SUP_CENTAUR=3Dy
> CONFIG_CPU_SUP_TRANSMETA_32=3Dy
> CONFIG_CPU_SUP_UMC_32=3Dy
> CONFIG_HPET_TIMER=3Dy
> CONFIG_HPET_EMULATE_RTC=3Dy
> CONFIG_DMI=3Dy
> # CONFIG_IOMMU_HELPER is not set
> # CONFIG_IOMMU_API is not set
> CONFIG_NR_CPUS=3D1
> CONFIG_PREEMPT_NONE=3Dy
> # CONFIG_PREEMPT_VOLUNTARY is not set
> # CONFIG_PREEMPT is not set
> # CONFIG_X86_UP_APIC is not set
> # CONFIG_X86_MCE is not set
> CONFIG_VM86=3Dy
> # CONFIG_TOSHIBA is not set
> # CONFIG_I8K is not set
> # CONFIG_X86_REBOOTFIXUPS is not set
> # CONFIG_MICROCODE is not set
> # CONFIG_X86_MSR is not set
> # CONFIG_X86_CPUID is not set
> # CONFIG_X86_CPU_DEBUG is not set
> CONFIG_NOHIGHMEM=3Dy
> # CONFIG_HIGHMEM4G is not set
> # CONFIG_HIGHMEM64G is not set
> CONFIG_PAGE_OFFSET=3D0xC0000000
> # CONFIG_X86_PAE is not set
> # CONFIG_ARCH_PHYS_ADDR_T_64BIT is not set
> CONFIG_ARCH_FLATMEM_ENABLE=3Dy
> CONFIG_ARCH_SPARSEMEM_ENABLE=3Dy
> CONFIG_ARCH_SELECT_MEMORY_MODEL=3Dy
> CONFIG_SELECT_MEMORY_MODEL=3Dy
> CONFIG_FLATMEM_MANUAL=3Dy
> # CONFIG_DISCONTIGMEM_MANUAL is not set
> # CONFIG_SPARSEMEM_MANUAL is not set
> CONFIG_FLATMEM=3Dy
> CONFIG_FLAT_NODE_MEM_MAP=3Dy
> CONFIG_SPARSEMEM_STATIC=3Dy
> CONFIG_PAGEFLAGS_EXTENDED=3Dy
> CONFIG_SPLIT_PTLOCK_CPUS=3D4
> # CONFIG_PHYS_ADDR_T_64BIT is not set
> CONFIG_ZONE_DMA_FLAG=3D1
> CONFIG_BOUNCE=3Dy
> CONFIG_VIRT_TO_BUS=3Dy
> CONFIG_UNEVICTABLE_LRU=3Dy
> CONFIG_HAVE_MLOCK=3Dy
> CONFIG_HAVE_MLOCKED_PAGE_BIT=3Dy
> CONFIG_X86_CHECK_BIOS_CORRUPTION=3Dy
> CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=3Dy
> CONFIG_X86_RESERVE_LOW_64K=3Dy
> # CONFIG_MATH_EMULATION is not set
> CONFIG_MTRR=3Dy
> CONFIG_MTRR_SANITIZER=3Dy
> CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=3D0
> CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=3D1
> # CONFIG_X86_PAT is not set
> CONFIG_SECCOMP=3Dy
> CONFIG_CC_STACKPROTECTOR_ALL=3Dy
> CONFIG_CC_STACKPROTECTOR=3Dy
> # CONFIG_HZ_100 is not set
> CONFIG_HZ_250=3Dy
> # CONFIG_HZ_300 is not set
> # CONFIG_HZ_1000 is not set
> CONFIG_HZ=3D250
> CONFIG_SCHED_HRTICK=3Dy
> # CONFIG_KEXEC is not set
> CONFIG_PHYSICAL_START=3D0x100000
> CONFIG_RELOCATABLE=3Dy
> CONFIG_PHYSICAL_ALIGN=3D0x200000
> # CONFIG_COMPAT_VDSO is not set
> # CONFIG_CMDLINE_BOOL is not set
>
> #
> # Power management and ACPI options
> #
> # CONFIG_PM is not set
>
> #
> # CPU Frequency scaling
> #
> # CONFIG_CPU_FREQ is not set
> CONFIG_CPU_IDLE=3Dy
> CONFIG_CPU_IDLE_GOV_LADDER=3Dy
> CONFIG_CPU_IDLE_GOV_MENU=3Dy
>
> #
> # Bus options (PCI etc.)
> #
> CONFIG_PCI=3Dy
> # CONFIG_PCI_GOBIOS is not set
> # CONFIG_PCI_GOMMCONFIG is not set
> # CONFIG_PCI_GODIRECT is not set
> # CONFIG_PCI_GOOLPC is not set
> CONFIG_PCI_GOANY=3Dy
> CONFIG_PCI_BIOS=3Dy
> CONFIG_PCI_DIRECT=3Dy
> CONFIG_PCI_DOMAINS=3Dy
> # CONFIG_PCIEPORTBUS is not set
> # CONFIG_ARCH_SUPPORTS_MSI is not set
> CONFIG_PCI_LEGACY=3Dy
> # CONFIG_PCI_DEBUG is not set
> # CONFIG_PCI_STUB is not set
> # CONFIG_PCI_IOV is not set
> CONFIG_ISA_DMA_API=3Dy
> CONFIG_ISA=3Dy
> # CONFIG_EISA is not set
> # CONFIG_MCA is not set
> # CONFIG_SCx200 is not set
> # CONFIG_OLPC is not set
> # CONFIG_PCCARD is not set
> # CONFIG_HOTPLUG_PCI is not set
>
> #
> # Executable file formats / Emulations
> #
> CONFIG_BINFMT_ELF=3Dy
> # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
> CONFIG_HAVE_AOUT=3Dy
> # CONFIG_BINFMT_AOUT is not set
> # CONFIG_BINFMT_MISC is not set
> CONFIG_HAVE_ATOMIC_IOMAP=3Dy
> CONFIG_NET=3Dy
>
> #
> # Networking options
> #
> CONFIG_PACKET=3Dy
> CONFIG_PACKET_MMAP=3Dy
> CONFIG_UNIX=3Dy
> # CONFIG_NET_KEY is not set
> CONFIG_INET=3Dy
> CONFIG_IP_MULTICAST=3Dy
> CONFIG_IP_ADVANCED_ROUTER=3Dy
> CONFIG_ASK_IP_FIB_HASH=3Dy
> # CONFIG_IP_FIB_TRIE is not set
> CONFIG_IP_FIB_HASH=3Dy
> CONFIG_IP_MULTIPLE_TABLES=3Dy
> CONFIG_IP_ROUTE_MULTIPATH=3Dy
> CONFIG_IP_ROUTE_VERBOSE=3Dy
> # CONFIG_IP_PNP is not set
> CONFIG_NET_IPIP=3Dy
> # CONFIG_NET_IPGRE is not set
> CONFIG_IP_MROUTE=3Dy
> CONFIG_IP_PIMSM_V1=3Dy
> CONFIG_IP_PIMSM_V2=3Dy
> # CONFIG_ARPD is not set
> CONFIG_SYN_COOKIES=3Dy
> # CONFIG_INET_AH is not set
> # CONFIG_INET_ESP is not set
> # CONFIG_INET_IPCOMP is not set
> # CONFIG_INET_XFRM_TUNNEL is not set
> CONFIG_INET_TUNNEL=3Dy
> # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
> # CONFIG_INET_XFRM_MODE_TUNNEL is not set
> # CONFIG_INET_XFRM_MODE_BEET is not set
> CONFIG_INET_LRO=3Dy
> CONFIG_INET_DIAG=3Dy
> CONFIG_INET_TCP_DIAG=3Dy
> CONFIG_TCP_CONG_ADVANCED=3Dy
> CONFIG_TCP_CONG_BIC=3Dy
> CONFIG_TCP_CONG_CUBIC=3Dy
> CONFIG_TCP_CONG_WESTWOOD=3Dy
> CONFIG_TCP_CONG_HTCP=3Dy
> CONFIG_TCP_CONG_HSTCP=3Dy
> CONFIG_TCP_CONG_HYBLA=3Dy
> CONFIG_TCP_CONG_VEGAS=3Dy
> CONFIG_TCP_CONG_SCALABLE=3Dy
> CONFIG_TCP_CONG_LP=3Dy
> CONFIG_TCP_CONG_VENO=3Dy
> CONFIG_TCP_CONG_YEAH=3Dy
> CONFIG_TCP_CONG_ILLINOIS=3Dy
> # CONFIG_DEFAULT_BIC is not set
> CONFIG_DEFAULT_CUBIC=3Dy
> # CONFIG_DEFAULT_HTCP is not set
> # CONFIG_DEFAULT_VEGAS is not set
> # CONFIG_DEFAULT_WESTWOOD is not set
> # CONFIG_DEFAULT_RENO is not set
> CONFIG_DEFAULT_TCP_CONG=3D"cubic"
> CONFIG_TCP_MD5SIG=3Dy
> # CONFIG_IPV6 is not set
> CONFIG_NETLABEL=3Dy
> CONFIG_NETWORK_SECMARK=3Dy
> CONFIG_NETFILTER=3Dy
> # CONFIG_NETFILTER_DEBUG is not set
> CONFIG_NETFILTER_ADVANCED=3Dy
> CONFIG_BRIDGE_NETFILTER=3Dy
>
> #
> # Core Netfilter Configuration
> #
> CONFIG_NETFILTER_NETLINK=3Dy
> CONFIG_NETFILTER_NETLINK_QUEUE=3Dy
> CONFIG_NETFILTER_NETLINK_LOG=3Dy
> CONFIG_NF_CONNTRACK=3Dy
> CONFIG_NF_CT_ACCT=3Dy
> CONFIG_NF_CONNTRACK_MARK=3Dy
> CONFIG_NF_CONNTRACK_SECMARK=3Dy
> CONFIG_NF_CONNTRACK_EVENTS=3Dy
> # CONFIG_NF_CT_PROTO_DCCP is not set
> CONFIG_NF_CT_PROTO_GRE=3Dy
> CONFIG_NF_CT_PROTO_SCTP=3Dy
> CONFIG_NF_CT_PROTO_UDPLITE=3Dy
> CONFIG_NF_CONNTRACK_AMANDA=3Dy
> CONFIG_NF_CONNTRACK_FTP=3Dy
> CONFIG_NF_CONNTRACK_H323=3Dy
> CONFIG_NF_CONNTRACK_IRC=3Dy
> CONFIG_NF_CONNTRACK_NETBIOS_NS=3Dy
> CONFIG_NF_CONNTRACK_PPTP=3Dy
> # CONFIG_NF_CONNTRACK_SANE is not set
> CONFIG_NF_CONNTRACK_SIP=3Dy
> CONFIG_NF_CONNTRACK_TFTP=3Dy
> CONFIG_NF_CT_NETLINK=3Dy
> CONFIG_NETFILTER_TPROXY=3Dy
> CONFIG_NETFILTER_XTABLES=3Dy
> CONFIG_NETFILTER_XT_TARGET_CLASSIFY=3Dy
> CONFIG_NETFILTER_XT_TARGET_CONNMARK=3Dy
> CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=3Dy
> CONFIG_NETFILTER_XT_TARGET_DSCP=3Dy
> CONFIG_NETFILTER_XT_TARGET_HL=3Dy
> CONFIG_NETFILTER_XT_TARGET_MARK=3Dy
> CONFIG_NETFILTER_XT_TARGET_NFLOG=3Dy
> CONFIG_NETFILTER_XT_TARGET_NFQUEUE=3Dy
> CONFIG_NETFILTER_XT_TARGET_NOTRACK=3Dy
> CONFIG_NETFILTER_XT_TARGET_RATEEST=3Dy
> CONFIG_NETFILTER_XT_TARGET_TPROXY=3Dy
> CONFIG_NETFILTER_XT_TARGET_TRACE=3Dy
> CONFIG_NETFILTER_XT_TARGET_SECMARK=3Dy
> CONFIG_NETFILTER_XT_TARGET_TCPMSS=3Dy
> # CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP is not set
> CONFIG_NETFILTER_XT_MATCH_CLUSTER=3Dy
> CONFIG_NETFILTER_XT_MATCH_COMMENT=3Dy
> CONFIG_NETFILTER_XT_MATCH_CONNBYTES=3Dy
> CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=3Dy
> CONFIG_NETFILTER_XT_MATCH_CONNMARK=3Dy
> CONFIG_NETFILTER_XT_MATCH_CONNTRACK=3Dy
> CONFIG_NETFILTER_XT_MATCH_DCCP=3Dy
> CONFIG_NETFILTER_XT_MATCH_DSCP=3Dy
> CONFIG_NETFILTER_XT_MATCH_ESP=3Dy
> CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=3Dy
> CONFIG_NETFILTER_XT_MATCH_HELPER=3Dy
> CONFIG_NETFILTER_XT_MATCH_HL=3Dy
> CONFIG_NETFILTER_XT_MATCH_IPRANGE=3Dy
> CONFIG_NETFILTER_XT_MATCH_LENGTH=3Dy
> CONFIG_NETFILTER_XT_MATCH_LIMIT=3Dy
> CONFIG_NETFILTER_XT_MATCH_MAC=3Dy
> CONFIG_NETFILTER_XT_MATCH_MARK=3Dy
> CONFIG_NETFILTER_XT_MATCH_MULTIPORT=3Dy
> CONFIG_NETFILTER_XT_MATCH_OWNER=3Dy
> CONFIG_NETFILTER_XT_MATCH_PHYSDEV=3Dy
> CONFIG_NETFILTER_XT_MATCH_PKTTYPE=3Dy
> CONFIG_NETFILTER_XT_MATCH_QUOTA=3Dy
> CONFIG_NETFILTER_XT_MATCH_RATEEST=3Dy
> CONFIG_NETFILTER_XT_MATCH_REALM=3Dy
> CONFIG_NETFILTER_XT_MATCH_RECENT=3Dy
> # CONFIG_NETFILTER_XT_MATCH_RECENT_PROC_COMPAT is not set
> CONFIG_NETFILTER_XT_MATCH_SCTP=3Dy
> CONFIG_NETFILTER_XT_MATCH_SOCKET=3Dy
> CONFIG_NETFILTER_XT_MATCH_STATE=3Dy
> CONFIG_NETFILTER_XT_MATCH_STATISTIC=3Dy
> CONFIG_NETFILTER_XT_MATCH_STRING=3Dy
> CONFIG_NETFILTER_XT_MATCH_TCPMSS=3Dy
> CONFIG_NETFILTER_XT_MATCH_TIME=3Dy
> CONFIG_NETFILTER_XT_MATCH_U32=3Dy
> CONFIG_IP_VS=3Dy
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
>
> #
> # IPVS scheduler
> #
> CONFIG_IP_VS_RR=3Dy
> CONFIG_IP_VS_WRR=3Dy
> CONFIG_IP_VS_LC=3Dy
> CONFIG_IP_VS_WLC=3Dy
> CONFIG_IP_VS_LBLC=3Dy
> CONFIG_IP_VS_LBLCR=3Dy
> CONFIG_IP_VS_DH=3Dy
> CONFIG_IP_VS_SH=3Dy
> CONFIG_IP_VS_SED=3Dy
> CONFIG_IP_VS_NQ=3Dy
>
> #
> # IPVS application helper
> #
> CONFIG_IP_VS_FTP=3Dy
>
> #
> # IP: Netfilter Configuration
> #
> CONFIG_NF_DEFRAG_IPV4=3Dy
> CONFIG_NF_CONNTRACK_IPV4=3Dy
> CONFIG_NF_CONNTRACK_PROC_COMPAT=3Dy
> CONFIG_IP_NF_QUEUE=3Dy
> CONFIG_IP_NF_IPTABLES=3Dy
> CONFIG_IP_NF_MATCH_ADDRTYPE=3Dy
> CONFIG_IP_NF_MATCH_AH=3Dy
> CONFIG_IP_NF_MATCH_ECN=3Dy
> CONFIG_IP_NF_MATCH_TTL=3Dy
> CONFIG_IP_NF_FILTER=3Dy
> CONFIG_IP_NF_TARGET_REJECT=3Dy
> CONFIG_IP_NF_TARGET_LOG=3Dy
> CONFIG_IP_NF_TARGET_ULOG=3Dy
> CONFIG_NF_NAT=3Dy
> CONFIG_NF_NAT_NEEDED=3Dy
> CONFIG_IP_NF_TARGET_MASQUERADE=3Dy
> CONFIG_IP_NF_TARGET_NETMAP=3Dy
> CONFIG_IP_NF_TARGET_REDIRECT=3Dy
> CONFIG_NF_NAT_SNMP_BASIC=3Dy
> CONFIG_NF_NAT_PROTO_GRE=3Dy
> CONFIG_NF_NAT_PROTO_UDPLITE=3Dy
> CONFIG_NF_NAT_PROTO_SCTP=3Dy
> CONFIG_NF_NAT_FTP=3Dy
> CONFIG_NF_NAT_IRC=3Dy
> CONFIG_NF_NAT_TFTP=3Dy
> CONFIG_NF_NAT_AMANDA=3Dy
> CONFIG_NF_NAT_PPTP=3Dy
> CONFIG_NF_NAT_H323=3Dy
> CONFIG_NF_NAT_SIP=3Dy
> CONFIG_IP_NF_MANGLE=3Dy
> CONFIG_IP_NF_TARGET_CLUSTERIP=3Dy
> CONFIG_IP_NF_TARGET_ECN=3Dy
> CONFIG_IP_NF_TARGET_TTL=3Dy
> CONFIG_IP_NF_RAW=3Dy
> CONFIG_IP_NF_SECURITY=3Dy
> CONFIG_IP_NF_ARPTABLES=3Dy
> CONFIG_IP_NF_ARPFILTER=3Dy
> CONFIG_IP_NF_ARP_MANGLE=3Dy
> CONFIG_BRIDGE_NF_EBTABLES=3Dy
> CONFIG_BRIDGE_EBT_BROUTE=3Dy
> CONFIG_BRIDGE_EBT_T_FILTER=3Dy
> CONFIG_BRIDGE_EBT_T_NAT=3Dy
> CONFIG_BRIDGE_EBT_802_3=3Dy
> CONFIG_BRIDGE_EBT_AMONG=3Dy
> CONFIG_BRIDGE_EBT_ARP=3Dy
> CONFIG_BRIDGE_EBT_IP=3Dy
> CONFIG_BRIDGE_EBT_LIMIT=3Dy
> CONFIG_BRIDGE_EBT_MARK=3Dy
> CONFIG_BRIDGE_EBT_PKTTYPE=3Dy
> CONFIG_BRIDGE_EBT_STP=3Dy
> CONFIG_BRIDGE_EBT_VLAN=3Dy
> CONFIG_BRIDGE_EBT_ARPREPLY=3Dy
> CONFIG_BRIDGE_EBT_DNAT=3Dy
> CONFIG_BRIDGE_EBT_MARK_T=3Dy
> CONFIG_BRIDGE_EBT_REDIRECT=3Dy
> CONFIG_BRIDGE_EBT_SNAT=3Dy
> CONFIG_BRIDGE_EBT_LOG=3Dy
> CONFIG_BRIDGE_EBT_ULOG=3Dy
> CONFIG_BRIDGE_EBT_NFLOG=3Dy
> # CONFIG_IP_DCCP is not set
> CONFIG_IP_SCTP=3Dy
> # CONFIG_SCTP_DBG_MSG is not set
> # CONFIG_SCTP_DBG_OBJCNT is not set
> # CONFIG_SCTP_HMAC_NONE is not set
> # CONFIG_SCTP_HMAC_SHA1 is not set
> CONFIG_SCTP_HMAC_MD5=3Dy
> # CONFIG_TIPC is not set
> # CONFIG_ATM is not set
> CONFIG_STP=3Dy
> CONFIG_BRIDGE=3Dy
> # CONFIG_NET_DSA is not set
> # CONFIG_VLAN_8021Q is not set
> # CONFIG_DECNET is not set
> CONFIG_LLC=3Dy
> CONFIG_LLC2=3Dy
> # CONFIG_IPX is not set
> # CONFIG_ATALK is not set
> # CONFIG_X25 is not set
> # CONFIG_LAPB is not set
> # CONFIG_ECONET is not set
> # CONFIG_WAN_ROUTER is not set
> # CONFIG_PHONET is not set
> CONFIG_NET_SCHED=3Dy
>
> #
> # Queueing/Scheduling
> #
> CONFIG_NET_SCH_CBQ=3Dy
> CONFIG_NET_SCH_HTB=3Dy
> CONFIG_NET_SCH_HFSC=3Dy
> CONFIG_NET_SCH_PRIO=3Dy
> CONFIG_NET_SCH_MULTIQ=3Dy
> CONFIG_NET_SCH_RED=3Dy
> CONFIG_NET_SCH_SFQ=3Dy
> CONFIG_NET_SCH_TEQL=3Dy
> CONFIG_NET_SCH_TBF=3Dy
> CONFIG_NET_SCH_GRED=3Dy
> CONFIG_NET_SCH_DSMARK=3Dy
> CONFIG_NET_SCH_NETEM=3Dy
> CONFIG_NET_SCH_DRR=3Dy
> CONFIG_NET_SCH_INGRESS=3Dy
>
> #
> # Classification
> #
> CONFIG_NET_CLS=3Dy
> CONFIG_NET_CLS_BASIC=3Dy
> CONFIG_NET_CLS_TCINDEX=3Dy
> CONFIG_NET_CLS_ROUTE4=3Dy
> CONFIG_NET_CLS_ROUTE=3Dy
> CONFIG_NET_CLS_FW=3Dy
> CONFIG_NET_CLS_U32=3Dy
> # CONFIG_CLS_U32_PERF is not set
> CONFIG_CLS_U32_MARK=3Dy
> CONFIG_NET_CLS_RSVP=3Dy
> CONFIG_NET_CLS_RSVP6=3Dy
> # CONFIG_NET_CLS_FLOW is not set
> CONFIG_NET_EMATCH=3Dy
> CONFIG_NET_EMATCH_STACK=3D32
> CONFIG_NET_EMATCH_CMP=3Dy
> CONFIG_NET_EMATCH_NBYTE=3Dy
> CONFIG_NET_EMATCH_U32=3Dy
> CONFIG_NET_EMATCH_META=3Dy
> CONFIG_NET_EMATCH_TEXT=3Dy
> CONFIG_NET_CLS_ACT=3Dy
> CONFIG_NET_ACT_POLICE=3Dy
> CONFIG_NET_ACT_GACT=3Dy
> CONFIG_GACT_PROB=3Dy
> CONFIG_NET_ACT_MIRRED=3Dy
> CONFIG_NET_ACT_IPT=3Dy
> CONFIG_NET_ACT_NAT=3Dy
> CONFIG_NET_ACT_PEDIT=3Dy
> CONFIG_NET_ACT_SIMP=3Dy
> CONFIG_NET_ACT_SKBEDIT=3Dy
> # CONFIG_NET_CLS_IND is not set
> CONFIG_NET_SCH_FIFO=3Dy
> # CONFIG_DCB is not set
>
> #
> # Network testing
> #
> # CONFIG_NET_PKTGEN is not set
> # CONFIG_NET_DROP_MONITOR is not set
> # CONFIG_HAMRADIO is not set
> # CONFIG_CAN is not set
> # CONFIG_IRDA is not set
> # CONFIG_BT is not set
> CONFIG_AF_RXRPC=3Dy
> # CONFIG_AF_RXRPC_DEBUG is not set
> # CONFIG_RXKAD is not set
> CONFIG_FIB_RULES=3Dy
> # CONFIG_WIRELESS is not set
> # CONFIG_WIMAX is not set
> # CONFIG_RFKILL is not set
> # CONFIG_NET_9P is not set
>
> #
> # Device Drivers
> #
>
> #
> # Generic Driver Options
> #
> CONFIG_UEVENT_HELPER_PATH=3D"/sbin/hotplug"
> # CONFIG_STANDALONE is not set
> CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
> CONFIG_FW_LOADER=3Dy
> CONFIG_FIRMWARE_IN_KERNEL=3Dy
> CONFIG_EXTRA_FIRMWARE=3D""
> # CONFIG_DEBUG_DRIVER is not set
> # CONFIG_DEBUG_DEVRES is not set
> # CONFIG_SYS_HYPERVISOR is not set
> CONFIG_CONNECTOR=3Dy
> CONFIG_PROC_EVENTS=3Dy
> # CONFIG_MTD is not set
> CONFIG_PARPORT=3Dy
> CONFIG_PARPORT_PC=3Dy
> CONFIG_PARPORT_SERIAL=3Dy
> CONFIG_PARPORT_PC_FIFO=3Dy
> # CONFIG_PARPORT_PC_SUPERIO is not set
> # CONFIG_PARPORT_GSC is not set
> CONFIG_PARPORT_AX88796=3Dy
> CONFIG_PARPORT_1284=3Dy
> CONFIG_PARPORT_NOT_PC=3Dy
> CONFIG_PNP=3Dy
> CONFIG_PNP_DEBUG_MESSAGES=3Dy
>
> #
> # Protocols
> #
> CONFIG_ISAPNP=3Dy
> # CONFIG_PNPBIOS is not set
> # CONFIG_PNPACPI is not set
> CONFIG_BLK_DEV=3Dy
> CONFIG_BLK_DEV_FD=3Dy
> # CONFIG_BLK_DEV_XD is not set
> # CONFIG_PARIDE is not set
> # CONFIG_BLK_CPQ_DA is not set
> # CONFIG_BLK_CPQ_CISS_DA is not set
> # CONFIG_BLK_DEV_DAC960 is not set
> # CONFIG_BLK_DEV_UMEM is not set
> # CONFIG_BLK_DEV_COW_COMMON is not set
> CONFIG_BLK_DEV_LOOP=3Dy
> CONFIG_BLK_DEV_CRYPTOLOOP=3Dy
> # CONFIG_BLK_DEV_NBD is not set
> # CONFIG_BLK_DEV_SX8 is not set
> # CONFIG_BLK_DEV_RAM is not set
> # CONFIG_CDROM_PKTCDVD is not set
> # CONFIG_ATA_OVER_ETH is not set
> # CONFIG_BLK_DEV_HD is not set
> CONFIG_MISC_DEVICES=3Dy
> # CONFIG_IBM_ASM is not set
> # CONFIG_PHANTOM is not set
> # CONFIG_SGI_IOC4 is not set
> CONFIG_TIFM_CORE=3Dy
> # CONFIG_TIFM_7XX1 is not set
> # CONFIG_ICS932S401 is not set
> # CONFIG_ENCLOSURE_SERVICES is not set
> # CONFIG_HP_ILO is not set
> # CONFIG_ISL29003 is not set
> # CONFIG_C2PORT is not set
>
> #
> # EEPROM support
> #
> # CONFIG_EEPROM_AT24 is not set
> # CONFIG_EEPROM_LEGACY is not set
> # CONFIG_EEPROM_93CX6 is not set
> CONFIG_HAVE_IDE=3Dy
> CONFIG_IDE=3Dy
>
> #
> # Please see Documentation/ide/ide.txt for help/info on IDE drives
> #
> CONFIG_IDE_ATAPI=3Dy
> # CONFIG_BLK_DEV_IDE_SATA is not set
> CONFIG_IDE_GD=3Dy
> CONFIG_IDE_GD_ATA=3Dy
> # CONFIG_IDE_GD_ATAPI is not set
> CONFIG_BLK_DEV_IDECD=3Dy
> CONFIG_BLK_DEV_IDECD_VERBOSE_ERRORS=3Dy
> # CONFIG_BLK_DEV_IDETAPE is not set
> # CONFIG_IDE_TASK_IOCTL is not set
> CONFIG_IDE_PROC_FS=3Dy
>
> #
> # IDE chipset support/bugfixes
> #
> # CONFIG_IDE_GENERIC is not set
> # CONFIG_BLK_DEV_PLATFORM is not set
> # CONFIG_BLK_DEV_CMD640 is not set
> # CONFIG_BLK_DEV_IDEPNP is not set
>
> #
> # PCI IDE chipsets support
> #
> CONFIG_BLK_DEV_IDEPCI=3Dy
> CONFIG_IDEPCI_PCIBUS_ORDER=3Dy
> # CONFIG_BLK_DEV_GENERIC is not set
> # CONFIG_BLK_DEV_OPTI621 is not set
> CONFIG_BLK_DEV_RZ1000=3Dy
> # CONFIG_BLK_DEV_AEC62XX is not set
> # CONFIG_BLK_DEV_ALI15X3 is not set
> # CONFIG_BLK_DEV_AMD74XX is not set
> # CONFIG_BLK_DEV_ATIIXP is not set
> # CONFIG_BLK_DEV_CMD64X is not set
> # CONFIG_BLK_DEV_TRIFLEX is not set
> # CONFIG_BLK_DEV_CS5520 is not set
> # CONFIG_BLK_DEV_CS5530 is not set
> # CONFIG_BLK_DEV_CS5535 is not set
> # CONFIG_BLK_DEV_CS5536 is not set
> # CONFIG_BLK_DEV_HPT366 is not set
> # CONFIG_BLK_DEV_JMICRON is not set
> # CONFIG_BLK_DEV_SC1200 is not set
> # CONFIG_BLK_DEV_PIIX is not set
> # CONFIG_BLK_DEV_IT8172 is not set
> # CONFIG_BLK_DEV_IT8213 is not set
> # CONFIG_BLK_DEV_IT821X is not set
> # CONFIG_BLK_DEV_NS87415 is not set
> # CONFIG_BLK_DEV_PDC202XX_OLD is not set
> # CONFIG_BLK_DEV_PDC202XX_NEW is not set
> # CONFIG_BLK_DEV_SVWKS is not set
> # CONFIG_BLK_DEV_SIIMAGE is not set
> # CONFIG_BLK_DEV_SIS5513 is not set
> # CONFIG_BLK_DEV_SLC90E66 is not set
> # CONFIG_BLK_DEV_TRM290 is not set
> # CONFIG_BLK_DEV_VIA82CXXX is not set
> # CONFIG_BLK_DEV_TC86C001 is not set
>
> #
> # Other IDE chipsets support
> #
>
> #
> # Note: most of these also require special kernel boot parameters
> #
> # CONFIG_BLK_DEV_4DRIVES is not set
> # CONFIG_BLK_DEV_ALI14XX is not set
> # CONFIG_BLK_DEV_DTC2278 is not set
> # CONFIG_BLK_DEV_HT6560B is not set
> # CONFIG_BLK_DEV_QD65XX is not set
> # CONFIG_BLK_DEV_UMC8672 is not set
> # CONFIG_BLK_DEV_IDEDMA is not set
>
> #
> # SCSI device support
> #
> # CONFIG_RAID_ATTRS is not set
> # CONFIG_SCSI is not set
> # CONFIG_SCSI_DMA is not set
> # CONFIG_SCSI_NETLINK is not set
> # CONFIG_ATA is not set
> # CONFIG_MD is not set
> # CONFIG_FUSION is not set
>
> #
> # IEEE 1394 (FireWire) support
> #
>
> #
> # Enable only one of the two stacks, unless you know what you are doi=
ng
> #
> # CONFIG_FIREWIRE is not set
> # CONFIG_IEEE1394 is not set
> # CONFIG_I2O is not set
> # CONFIG_MACINTOSH_DRIVERS is not set
> CONFIG_NETDEVICES=3Dy
> CONFIG_COMPAT_NET_DEV_OPS=3Dy
> CONFIG_IFB=3Dy
> CONFIG_DUMMY=3Dy
> # CONFIG_BONDING is not set
> # CONFIG_MACVLAN is not set
> # CONFIG_EQUALIZER is not set
> CONFIG_TUN=3Dy
> # CONFIG_VETH is not set
> # CONFIG_NET_SB1000 is not set
> # CONFIG_ARCNET is not set
> CONFIG_PHYLIB=3Dy
>
> #
> # MII PHY device drivers
> #
> CONFIG_MARVELL_PHY=3Dy
> CONFIG_DAVICOM_PHY=3Dy
> CONFIG_QSEMI_PHY=3Dy
> CONFIG_LXT_PHY=3Dy
> CONFIG_CICADA_PHY=3Dy
> CONFIG_VITESSE_PHY=3Dy
> CONFIG_SMSC_PHY=3Dy
> CONFIG_BROADCOM_PHY=3Dy
> CONFIG_ICPLUS_PHY=3Dy
> # CONFIG_REALTEK_PHY is not set
> CONFIG_NATIONAL_PHY=3Dy
> CONFIG_STE10XP=3Dy
> CONFIG_LSI_ET1011C_PHY=3Dy
> CONFIG_FIXED_PHY=3Dy
> CONFIG_MDIO_BITBANG=3Dy
> CONFIG_NET_ETHERNET=3Dy
> CONFIG_MII=3Dy
> # CONFIG_HAPPYMEAL is not set
> # CONFIG_SUNGEM is not set
> # CONFIG_CASSINI is not set
> CONFIG_NET_VENDOR_3COM=3Dy
> # CONFIG_EL1 is not set
> # CONFIG_EL2 is not set
> # CONFIG_ELPLUS is not set
> # CONFIG_EL16 is not set
> # CONFIG_EL3 is not set
> # CONFIG_3C515 is not set
> CONFIG_VORTEX=3Dy
> # CONFIG_TYPHOON is not set
> # CONFIG_LANCE is not set
> # CONFIG_NET_VENDOR_SMC is not set
> # CONFIG_ETHOC is not set
> # CONFIG_NET_VENDOR_RACAL is not set
> # CONFIG_DNET is not set
> CONFIG_NET_TULIP=3Dy
> CONFIG_DE2104X=3Dy
> CONFIG_TULIP=3Dy
> # CONFIG_TULIP_MWI is not set
> # CONFIG_TULIP_MMIO is not set
> # CONFIG_TULIP_NAPI is not set
> CONFIG_DE4X5=3Dy
> CONFIG_WINBOND_840=3Dy
> CONFIG_DM9102=3Dy
> CONFIG_ULI526X=3Dy
> # CONFIG_AT1700 is not set
> # CONFIG_DEPCA is not set
> # CONFIG_HP100 is not set
> # CONFIG_NET_ISA is not set
> # CONFIG_IBM_NEW_EMAC_ZMII is not set
> # CONFIG_IBM_NEW_EMAC_RGMII is not set
> # CONFIG_IBM_NEW_EMAC_TAH is not set
> # CONFIG_IBM_NEW_EMAC_EMAC4 is not set
> # CONFIG_IBM_NEW_EMAC_NO_FLOW_CTRL is not set
> # CONFIG_IBM_NEW_EMAC_MAL_CLR_ICINTSTAT is not set
> # CONFIG_IBM_NEW_EMAC_MAL_COMMON_ERR is not set
> CONFIG_NET_PCI=3Dy
> # CONFIG_PCNET32 is not set
> # CONFIG_AMD8111_ETH is not set
> # CONFIG_ADAPTEC_STARFIRE is not set
> # CONFIG_AC3200 is not set
> # CONFIG_APRICOT is not set
> # CONFIG_B44 is not set
> # CONFIG_FORCEDETH is not set
> # CONFIG_CS89x0 is not set
> CONFIG_E100=3Dy
> # CONFIG_FEALNX is not set
> # CONFIG_NATSEMI is not set
> CONFIG_NE2K_PCI=3Dy
> CONFIG_8139CP=3Dy
> CONFIG_8139TOO=3Dy
> CONFIG_8139TOO_PIO=3Dy
> # CONFIG_8139TOO_TUNE_TWISTER is not set
> CONFIG_8139TOO_8129=3Dy
> # CONFIG_8139_OLD_RX_RESET is not set
> # CONFIG_R6040 is not set
> # CONFIG_SIS900 is not set
> # CONFIG_EPIC100 is not set
> # CONFIG_SMSC9420 is not set
> # CONFIG_SUNDANCE is not set
> # CONFIG_TLAN is not set
> # CONFIG_VIA_RHINE is not set
> # CONFIG_SC92031 is not set
> # CONFIG_NET_POCKET is not set
> # CONFIG_ATL2 is not set
> # CONFIG_NETDEV_1000 is not set
> # CONFIG_NETDEV_10000 is not set
> # CONFIG_TR is not set
>
> #
> # Wireless LAN
> #
> # CONFIG_WLAN_PRE80211 is not set
> # CONFIG_WLAN_80211 is not set
>
> #
> # Enable WiMAX (Networking options) to see the WiMAX drivers
> #
> # CONFIG_WAN is not set
> # CONFIG_FDDI is not set
> # CONFIG_HIPPI is not set
> # CONFIG_PLIP is not set
> # CONFIG_PPP is not set
> # CONFIG_SLIP is not set
> # CONFIG_NETCONSOLE is not set
> # CONFIG_NETPOLL is not set
> # CONFIG_NET_POLL_CONTROLLER is not set
> # CONFIG_ISDN is not set
> # CONFIG_PHONE is not set
>
> #
> # Input device support
> #
> CONFIG_INPUT=3Dy
> # CONFIG_INPUT_FF_MEMLESS is not set
> CONFIG_INPUT_POLLDEV=3Dy
>
> #
> # Userland interfaces
> #
> CONFIG_INPUT_MOUSEDEV=3Dy
> CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
> # CONFIG_INPUT_JOYDEV is not set
> CONFIG_INPUT_EVDEV=3Dy
> CONFIG_INPUT_EVBUG=3Dy
>
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=3Dy
> CONFIG_KEYBOARD_ATKBD=3Dy
> # CONFIG_KEYBOARD_SUNKBD is not set
> # CONFIG_KEYBOARD_LKKBD is not set
> CONFIG_KEYBOARD_XTKBD=3Dy
> # CONFIG_KEYBOARD_NEWTON is not set
> # CONFIG_KEYBOARD_STOWAWAY is not set
> # CONFIG_INPUT_MOUSE is not set
> # CONFIG_INPUT_JOYSTICK is not set
> # CONFIG_INPUT_TABLET is not set
> # CONFIG_INPUT_TOUCHSCREEN is not set
> CONFIG_INPUT_MISC=3Dy
> CONFIG_INPUT_PCSPKR=3Dy
> # CONFIG_INPUT_WISTRON_BTNS is not set
> # CONFIG_INPUT_UINPUT is not set
>
> #
> # Hardware I/O ports
> #
> CONFIG_SERIO=3Dy
> CONFIG_SERIO_I8042=3Dy
> CONFIG_SERIO_SERPORT=3Dy
> CONFIG_SERIO_CT82C710=3Dy
> # CONFIG_SERIO_PARKBD is not set
> CONFIG_SERIO_PCIPS2=3Dy
> CONFIG_SERIO_LIBPS2=3Dy
> CONFIG_SERIO_RAW=3Dy
> # CONFIG_GAMEPORT is not set
>
> #
> # Character devices
> #
> CONFIG_VT=3Dy
> CONFIG_CONSOLE_TRANSLATIONS=3Dy
> CONFIG_VT_CONSOLE=3Dy
> CONFIG_HW_CONSOLE=3Dy
> CONFIG_VT_HW_CONSOLE_BINDING=3Dy
> # CONFIG_DEVKMEM is not set
> # CONFIG_SERIAL_NONSTANDARD is not set
> # CONFIG_NOZOMI is not set
>
> #
> # Serial drivers
> #
> CONFIG_SERIAL_8250=3Dy
> CONFIG_SERIAL_8250_CONSOLE=3Dy
> CONFIG_FIX_EARLYCON_MEM=3Dy
> CONFIG_SERIAL_8250_PCI=3Dy
> CONFIG_SERIAL_8250_PNP=3Dy
> CONFIG_SERIAL_8250_NR_UARTS=3D48
> CONFIG_SERIAL_8250_RUNTIME_UARTS=3D4
> CONFIG_SERIAL_8250_EXTENDED=3Dy
> # CONFIG_SERIAL_8250_MANY_PORTS is not set
> CONFIG_SERIAL_8250_SHARE_IRQ=3Dy
> # CONFIG_SERIAL_8250_DETECT_IRQ is not set
> # CONFIG_SERIAL_8250_RSA is not set
>
> #
> # Non-8250 serial port support
> #
> CONFIG_SERIAL_CORE=3Dy
> CONFIG_SERIAL_CORE_CONSOLE=3Dy
> CONFIG_CONSOLE_POLL=3Dy
> # CONFIG_SERIAL_JSM is not set
> CONFIG_UNIX98_PTYS=3Dy
> CONFIG_DEVPTS_MULTIPLE_INSTANCES=3Dy
> CONFIG_LEGACY_PTYS=3Dy
> CONFIG_LEGACY_PTY_COUNT=3D0
> CONFIG_PRINTER=3Dy
> # CONFIG_LP_CONSOLE is not set
> CONFIG_PPDEV=3Dy
> # CONFIG_IPMI_HANDLER is not set
> CONFIG_HW_RANDOM=3Dy
> # CONFIG_HW_RANDOM_TIMERIOMEM is not set
> # CONFIG_HW_RANDOM_INTEL is not set
> # CONFIG_HW_RANDOM_AMD is not set
> # CONFIG_HW_RANDOM_GEODE is not set
> # CONFIG_HW_RANDOM_VIA is not set
> CONFIG_NVRAM=3Dy
> # CONFIG_DTLK is not set
> # CONFIG_R3964 is not set
> # CONFIG_APPLICOM is not set
> # CONFIG_SONYPI is not set
> # CONFIG_MWAVE is not set
> # CONFIG_PC8736x_GPIO is not set
> # CONFIG_NSC_GPIO is not set
> # CONFIG_CS5535_GPIO is not set
> # CONFIG_RAW_DRIVER is not set
> CONFIG_HANGCHECK_TIMER=3Dy
> # CONFIG_TCG_TPM is not set
> # CONFIG_TELCLOCK is not set
> CONFIG_DEVPORT=3Dy
> CONFIG_I2C=3Dy
> CONFIG_I2C_BOARDINFO=3Dy
> # CONFIG_I2C_CHARDEV is not set
> # CONFIG_I2C_HELPER_AUTO is not set
>
> #
> # I2C Algorithms
> #
> CONFIG_I2C_ALGOBIT=3Dy
> CONFIG_I2C_ALGOPCF=3Dy
> CONFIG_I2C_ALGOPCA=3Dy
>
> #
> # I2C Hardware Bus support
> #
>
> #
> # PC SMBus host controller drivers
> #
> # CONFIG_I2C_ALI1535 is not set
> # CONFIG_I2C_ALI1563 is not set
> # CONFIG_I2C_ALI15X3 is not set
> # CONFIG_I2C_AMD756 is not set
> # CONFIG_I2C_AMD8111 is not set
> # CONFIG_I2C_I801 is not set
> # CONFIG_I2C_ISCH is not set
> # CONFIG_I2C_PIIX4 is not set
> # CONFIG_I2C_NFORCE2 is not set
> # CONFIG_I2C_SIS5595 is not set
> # CONFIG_I2C_SIS630 is not set
> # CONFIG_I2C_SIS96X is not set
> # CONFIG_I2C_VIA is not set
> # CONFIG_I2C_VIAPRO is not set
>
> #
> # I2C system bus drivers (mostly embedded / system-on-chip)
> #
> # CONFIG_I2C_OCORES is not set
> # CONFIG_I2C_SIMTEC is not set
>
> #
> # External I2C/SMBus adapter drivers
> #
> # CONFIG_I2C_PARPORT is not set
> # CONFIG_I2C_PARPORT_LIGHT is not set
> # CONFIG_I2C_TAOS_EVM is not set
>
> #
> # Graphics adapter I2C/DDC channel drivers
> #
> # CONFIG_I2C_VOODOO3 is not set
>
> #
> # Other I2C/SMBus bus drivers
> #
> # CONFIG_I2C_ELEKTOR is not set
> # CONFIG_I2C_PCA_ISA is not set
> # CONFIG_I2C_PCA_PLATFORM is not set
> # CONFIG_SCx200_ACB is not set
>
> #
> # Miscellaneous I2C Chip support
> #
> # CONFIG_DS1682 is not set
> # CONFIG_SENSORS_PCF8574 is not set
> # CONFIG_PCF8575 is not set
> # CONFIG_SENSORS_PCA9539 is not set
> # CONFIG_SENSORS_MAX6875 is not set
> # CONFIG_SENSORS_TSL2550 is not set
> # CONFIG_I2C_DEBUG_CORE is not set
> # CONFIG_I2C_DEBUG_ALGO is not set
> # CONFIG_I2C_DEBUG_BUS is not set
> # CONFIG_I2C_DEBUG_CHIP is not set
> # CONFIG_SPI is not set
> CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=3Dy
> # CONFIG_GPIOLIB is not set
> CONFIG_W1=3Dy
> # CONFIG_W1_CON is not set
>
> #
> # 1-wire Bus Masters
> #
> # CONFIG_W1_MASTER_MATROX is not set
> # CONFIG_W1_MASTER_DS2482 is not set
>
> #
> # 1-wire Slaves
> #
> # CONFIG_W1_SLAVE_THERM is not set
> # CONFIG_W1_SLAVE_SMEM is not set
> # CONFIG_W1_SLAVE_DS2431 is not set
> # CONFIG_W1_SLAVE_DS2433 is not set
> CONFIG_W1_SLAVE_DS2760=3Dy
> # CONFIG_W1_SLAVE_BQ27000 is not set
> # CONFIG_POWER_SUPPLY is not set
> # CONFIG_HWMON is not set
> # CONFIG_THERMAL is not set
> CONFIG_THERMAL_HWMON=3Dy
> # CONFIG_WATCHDOG is not set
> CONFIG_SSB_POSSIBLE=3Dy
>
> #
> # Sonics Silicon Backplane
> #
> # CONFIG_SSB is not set
>
> #
> # Multifunction device drivers
> #
> # CONFIG_MFD_CORE is not set
> # CONFIG_MFD_SM501 is not set
> # CONFIG_HTC_PASIC3 is not set
> # CONFIG_TWL4030_CORE is not set
> # CONFIG_MFD_TMIO is not set
> # CONFIG_PMIC_DA903X is not set
> # CONFIG_MFD_WM8400 is not set
> # CONFIG_MFD_WM8350_I2C is not set
> # CONFIG_MFD_PCF50633 is not set
> # CONFIG_REGULATOR is not set
>
> #
> # Multimedia devices
> #
>
> #
> # Multimedia core support
> #
> # CONFIG_VIDEO_DEV is not set
> # CONFIG_DVB_CORE is not set
> # CONFIG_VIDEO_MEDIA is not set
>
> #
> # Multimedia drivers
> #
> # CONFIG_DAB is not set
>
> #
> # Graphics support
> #
> # CONFIG_AGP is not set
> # CONFIG_DRM is not set
> # CONFIG_VGASTATE is not set
> # CONFIG_VIDEO_OUTPUT_CONTROL is not set
> # CONFIG_FB is not set
> CONFIG_BACKLIGHT_LCD_SUPPORT=3Dy
> # CONFIG_LCD_CLASS_DEVICE is not set
> CONFIG_BACKLIGHT_CLASS_DEVICE=3Dy
> # CONFIG_BACKLIGHT_GENERIC is not set
> # CONFIG_BACKLIGHT_PROGEAR is not set
> # CONFIG_BACKLIGHT_MBP_NVIDIA is not set
> # CONFIG_BACKLIGHT_SAHARA is not set
>
> #
> # Display device support
> #
> # CONFIG_DISPLAY_SUPPORT is not set
>
> #
> # Console display driver support
> #
> CONFIG_VGA_CONSOLE=3Dy
> # CONFIG_VGACON_SOFT_SCROLLBACK is not set
> # CONFIG_MDA_CONSOLE is not set
> CONFIG_DUMMY_CONSOLE=3Dy
> # CONFIG_SOUND is not set
> CONFIG_HID_SUPPORT=3Dy
> CONFIG_HID=3Dy
> CONFIG_HID_DEBUG=3Dy
> # CONFIG_HIDRAW is not set
> CONFIG_HID_PID=3Dy
>
> #
> # Special HID drivers
> #
> # CONFIG_USB_SUPPORT is not set
> # CONFIG_UWB is not set
> # CONFIG_MMC is not set
> # CONFIG_MEMSTICK is not set
> # CONFIG_NEW_LEDS is not set
> # CONFIG_ACCESSIBILITY is not set
> # CONFIG_INFINIBAND is not set
> # CONFIG_EDAC is not set
> CONFIG_RTC_LIB=3Dy
> CONFIG_RTC_CLASS=3Dy
> CONFIG_RTC_HCTOSYS=3Dy
> CONFIG_RTC_HCTOSYS_DEVICE=3D"rtc0"
> # CONFIG_RTC_DEBUG is not set
>
> #
> # RTC interfaces
> #
> CONFIG_RTC_INTF_SYSFS=3Dy
> CONFIG_RTC_INTF_PROC=3Dy
> CONFIG_RTC_INTF_DEV=3Dy
> CONFIG_RTC_INTF_DEV_UIE_EMUL=3Dy
> CONFIG_RTC_DRV_TEST=3Dy
>
> #
> # I2C RTC drivers
> #
> CONFIG_RTC_DRV_DS1307=3Dy
> CONFIG_RTC_DRV_DS1374=3Dy
> CONFIG_RTC_DRV_DS1672=3Dy
> CONFIG_RTC_DRV_MAX6900=3Dy
> CONFIG_RTC_DRV_RS5C372=3Dy
> CONFIG_RTC_DRV_ISL1208=3Dy
> CONFIG_RTC_DRV_X1205=3Dy
> CONFIG_RTC_DRV_PCF8563=3Dy
> CONFIG_RTC_DRV_PCF8583=3Dy
> CONFIG_RTC_DRV_M41T80=3Dy
> CONFIG_RTC_DRV_M41T80_WDT=3Dy
> # CONFIG_RTC_DRV_S35390A is not set
> CONFIG_RTC_DRV_FM3130=3Dy
> CONFIG_RTC_DRV_RX8581=3Dy
>
> #
> # SPI RTC drivers
> #
>
> #
> # Platform RTC drivers
> #
> CONFIG_RTC_DRV_CMOS=3Dy
> CONFIG_RTC_DRV_DS1286=3Dy
> # CONFIG_RTC_DRV_DS1511 is not set
> CONFIG_RTC_DRV_DS1553=3Dy
> CONFIG_RTC_DRV_DS1742=3Dy
> CONFIG_RTC_DRV_STK17TA8=3Dy
> CONFIG_RTC_DRV_M48T86=3Dy
> CONFIG_RTC_DRV_M48T35=3Dy
> CONFIG_RTC_DRV_M48T59=3Dy
> CONFIG_RTC_DRV_BQ4802=3Dy
> CONFIG_RTC_DRV_V3020=3Dy
>
> #
> # on-CPU RTC drivers
> #
> # CONFIG_DMADEVICES is not set
> # CONFIG_AUXDISPLAY is not set
> # CONFIG_UIO is not set
> # CONFIG_STAGING is not set
> CONFIG_X86_PLATFORM_DEVICES=3Dy
>
> #
> # Firmware Drivers
> #
> # CONFIG_EDD is not set
> CONFIG_FIRMWARE_MEMMAP=3Dy
> # CONFIG_DELL_RBU is not set
> # CONFIG_DCDBAS is not set
> # CONFIG_DMIID is not set
> # CONFIG_ISCSI_IBFT_FIND is not set
>
> #
> # File systems
> #
> CONFIG_EXT2_FS=3Dy
> CONFIG_EXT2_FS_XATTR=3Dy
> CONFIG_EXT2_FS_POSIX_ACL=3Dy
> CONFIG_EXT2_FS_SECURITY=3Dy
> # CONFIG_EXT2_FS_XIP is not set
> CONFIG_EXT3_FS=3Dy
> # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
> CONFIG_EXT3_FS_XATTR=3Dy
> CONFIG_EXT3_FS_POSIX_ACL=3Dy
> CONFIG_EXT3_FS_SECURITY=3Dy
> # CONFIG_EXT4_FS is not set
> CONFIG_JBD=3Dy
> # CONFIG_JBD_DEBUG is not set
> CONFIG_FS_MBCACHE=3Dy
> # CONFIG_REISERFS_FS is not set
> # CONFIG_JFS_FS is not set
> CONFIG_FS_POSIX_ACL=3Dy
> CONFIG_FILE_LOCKING=3Dy
> # CONFIG_XFS_FS is not set
> # CONFIG_OCFS2_FS is not set
> # CONFIG_BTRFS_FS is not set
> CONFIG_DNOTIFY=3Dy
> CONFIG_INOTIFY=3Dy
> CONFIG_INOTIFY_USER=3Dy
> # CONFIG_QUOTA is not set
> # CONFIG_AUTOFS_FS is not set
> # CONFIG_AUTOFS4_FS is not set
> # CONFIG_FUSE_FS is not set
> CONFIG_GENERIC_ACL=3Dy
>
> #
> # Caches
> #
> CONFIG_FSCACHE=3Dy
> # CONFIG_FSCACHE_STATS is not set
> # CONFIG_FSCACHE_HISTOGRAM is not set
> # CONFIG_FSCACHE_DEBUG is not set
> CONFIG_CACHEFILES=3Dy
> # CONFIG_CACHEFILES_DEBUG is not set
> # CONFIG_CACHEFILES_HISTOGRAM is not set
>
> #
> # CD-ROM/DVD Filesystems
> #
> CONFIG_ISO9660_FS=3Dy
> CONFIG_JOLIET=3Dy
> CONFIG_ZISOFS=3Dy
> CONFIG_UDF_FS=3Dy
> CONFIG_UDF_NLS=3Dy
>
> #
> # DOS/FAT/NT Filesystems
> #
> CONFIG_FAT_FS=3Dy
> CONFIG_MSDOS_FS=3Dy
> CONFIG_VFAT_FS=3Dy
> CONFIG_FAT_DEFAULT_CODEPAGE=3D437
> CONFIG_FAT_DEFAULT_IOCHARSET=3D"iso8859-1"
> CONFIG_NTFS_FS=3Dy
> # CONFIG_NTFS_DEBUG is not set
> # CONFIG_NTFS_RW is not set
>
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=3Dy
> CONFIG_PROC_KCORE=3Dy
> CONFIG_PROC_SYSCTL=3Dy
> CONFIG_PROC_PAGE_MONITOR=3Dy
> CONFIG_SYSFS=3Dy
> CONFIG_TMPFS=3Dy
> CONFIG_TMPFS_POSIX_ACL=3Dy
> # CONFIG_HUGETLBFS is not set
> # CONFIG_HUGETLB_PAGE is not set
> CONFIG_CONFIGFS_FS=3Dy
> # CONFIG_MISC_FILESYSTEMS is not set
> # CONFIG_NETWORK_FILESYSTEMS is not set
>
> #
> # Partition Types
> #
> # CONFIG_PARTITION_ADVANCED is not set
> CONFIG_MSDOS_PARTITION=3Dy
> CONFIG_NLS=3Dy
> CONFIG_NLS_DEFAULT=3D"cp437"
> CONFIG_NLS_CODEPAGE_437=3Dy
> # CONFIG_NLS_CODEPAGE_737 is not set
> # CONFIG_NLS_CODEPAGE_775 is not set
> # CONFIG_NLS_CODEPAGE_850 is not set
> # CONFIG_NLS_CODEPAGE_852 is not set
> # CONFIG_NLS_CODEPAGE_855 is not set
> # CONFIG_NLS_CODEPAGE_857 is not set
> # CONFIG_NLS_CODEPAGE_860 is not set
> # CONFIG_NLS_CODEPAGE_861 is not set
> # CONFIG_NLS_CODEPAGE_862 is not set
> # CONFIG_NLS_CODEPAGE_863 is not set
> # CONFIG_NLS_CODEPAGE_864 is not set
> # CONFIG_NLS_CODEPAGE_865 is not set
> # CONFIG_NLS_CODEPAGE_866 is not set
> # CONFIG_NLS_CODEPAGE_869 is not set
> # CONFIG_NLS_CODEPAGE_936 is not set
> # CONFIG_NLS_CODEPAGE_950 is not set
> # CONFIG_NLS_CODEPAGE_932 is not set
> # CONFIG_NLS_CODEPAGE_949 is not set
> # CONFIG_NLS_CODEPAGE_874 is not set
> # CONFIG_NLS_ISO8859_8 is not set
> # CONFIG_NLS_CODEPAGE_1250 is not set
> # CONFIG_NLS_CODEPAGE_1251 is not set
> CONFIG_NLS_ASCII=3Dy
> CONFIG_NLS_ISO8859_1=3Dy
> # CONFIG_NLS_ISO8859_2 is not set
> # CONFIG_NLS_ISO8859_3 is not set
> # CONFIG_NLS_ISO8859_4 is not set
> # CONFIG_NLS_ISO8859_5 is not set
> # CONFIG_NLS_ISO8859_6 is not set
> # CONFIG_NLS_ISO8859_7 is not set
> # CONFIG_NLS_ISO8859_9 is not set
> # CONFIG_NLS_ISO8859_13 is not set
> # CONFIG_NLS_ISO8859_14 is not set
> CONFIG_NLS_ISO8859_15=3Dy
> # CONFIG_NLS_KOI8_R is not set
> # CONFIG_NLS_KOI8_U is not set
> CONFIG_NLS_UTF8=3Dy
> # CONFIG_DLM is not set
>
> #
> # Kernel hacking
> #
> CONFIG_TRACE_IRQFLAGS_SUPPORT=3Dy
> CONFIG_PRINTK_TIME=3Dy
> # CONFIG_ENABLE_WARN_DEPRECATED is not set
> # CONFIG_ENABLE_MUST_CHECK is not set
> CONFIG_FRAME_WARN=3D1024
> CONFIG_MAGIC_SYSRQ=3Dy
> CONFIG_UNUSED_SYMBOLS=3Dy
> CONFIG_DEBUG_FS=3Dy
> # CONFIG_HEADERS_CHECK is not set
> CONFIG_DEBUG_KERNEL=3Dy
> # CONFIG_DEBUG_SHIRQ is not set
> CONFIG_DETECT_SOFTLOCKUP=3Dy
> # CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
> CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=3D0
> CONFIG_DETECT_HUNG_TASK=3Dy
> # CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
> CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=3D0
> CONFIG_SCHED_DEBUG=3Dy
> CONFIG_SCHEDSTATS=3Dy
> CONFIG_TIMER_STATS=3Dy
> # CONFIG_DEBUG_OBJECTS is not set
> # CONFIG_SLUB_DEBUG_ON is not set
> # CONFIG_SLUB_STATS is not set
> # CONFIG_DEBUG_RT_MUTEXES is not set
> # CONFIG_RT_MUTEX_TESTER is not set
> # CONFIG_DEBUG_SPINLOCK is not set
> # CONFIG_DEBUG_MUTEXES is not set
> # CONFIG_DEBUG_LOCK_ALLOC is not set
> # CONFIG_PROVE_LOCKING is not set
> # CONFIG_LOCK_STAT is not set
> # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
> # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
> CONFIG_STACKTRACE=3Dy
> # CONFIG_DEBUG_KOBJECT is not set
> CONFIG_DEBUG_BUGVERBOSE=3Dy
> CONFIG_DEBUG_INFO=3Dy
> # CONFIG_DEBUG_VM is not set
> # CONFIG_DEBUG_VIRTUAL is not set
> # CONFIG_DEBUG_WRITECOUNT is not set
> CONFIG_DEBUG_MEMORY_INIT=3Dy
> # CONFIG_DEBUG_LIST is not set
> # CONFIG_DEBUG_SG is not set
> # CONFIG_DEBUG_NOTIFIERS is not set
> CONFIG_ARCH_WANT_FRAME_POINTERS=3Dy
> CONFIG_FRAME_POINTER=3Dy
> # CONFIG_BOOT_PRINTK_DELAY is not set
> # CONFIG_RCU_TORTURE_TEST is not set
> # CONFIG_RCU_CPU_STALL_DETECTOR is not set
> # CONFIG_BACKTRACE_SELF_TEST is not set
> # CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
> # CONFIG_FAULT_INJECTION is not set
> CONFIG_LATENCYTOP=3Dy
> CONFIG_SYSCTL_SYSCALL_CHECK=3Dy
> # CONFIG_DEBUG_PAGEALLOC is not set
> CONFIG_USER_STACKTRACE_SUPPORT=3Dy
> CONFIG_NOP_TRACER=3Dy
> CONFIG_HAVE_FUNCTION_TRACER=3Dy
> CONFIG_HAVE_FUNCTION_GRAPH_TRACER=3Dy
> CONFIG_HAVE_FUNCTION_TRACE_MCOUNT_TEST=3Dy
> CONFIG_HAVE_DYNAMIC_FTRACE=3Dy
> CONFIG_HAVE_FTRACE_MCOUNT_RECORD=3Dy
> CONFIG_HAVE_FTRACE_SYSCALLS=3Dy
> CONFIG_RING_BUFFER=3Dy
> CONFIG_TRACING=3Dy
> CONFIG_TRACING_SUPPORT=3Dy
>
> #
> # Tracers
> #
> # CONFIG_FUNCTION_TRACER is not set
> # CONFIG_IRQSOFF_TRACER is not set
> # CONFIG_SYSPROF_TRACER is not set
> # CONFIG_SCHED_TRACER is not set
> CONFIG_CONTEXT_SWITCH_TRACER=3Dy
> # CONFIG_EVENT_TRACER is not set
> # CONFIG_FTRACE_SYSCALLS is not set
> # CONFIG_BOOT_TRACER is not set
> # CONFIG_TRACE_BRANCH_PROFILING is not set
> # CONFIG_POWER_TRACER is not set
> # CONFIG_STACK_TRACER is not set
> # CONFIG_KMEMTRACE is not set
> # CONFIG_WORKQUEUE_TRACER is not set
> CONFIG_BLK_DEV_IO_TRACE=3Dy
> # CONFIG_FTRACE_STARTUP_TEST is not set
> # CONFIG_MMIOTRACE is not set
> # CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
> # CONFIG_DYNAMIC_DEBUG is not set
> # CONFIG_DMA_API_DEBUG is not set
> # CONFIG_SAMPLES is not set
> CONFIG_HAVE_ARCH_KGDB=3Dy
> CONFIG_KGDB=3Dy
> CONFIG_KGDB_SERIAL_CONSOLE=3Dy
> # CONFIG_KGDB_TESTS is not set
> CONFIG_STRICT_DEVMEM=3Dy
> # CONFIG_X86_VERBOSE_BOOTUP is not set
> CONFIG_EARLY_PRINTK=3Dy
> # CONFIG_EARLY_PRINTK_DBGP is not set
> # CONFIG_DEBUG_STACKOVERFLOW is not set
> # CONFIG_DEBUG_STACK_USAGE is not set
> # CONFIG_X86_PTDUMP is not set
> CONFIG_DEBUG_RODATA=3Dy
> # CONFIG_DEBUG_RODATA_TEST is not set
> # CONFIG_4KSTACKS is not set
> CONFIG_DOUBLEFAULT=3Dy
> CONFIG_HAVE_MMIOTRACE_SUPPORT=3Dy
> CONFIG_IO_DELAY_TYPE_0X80=3D0
> CONFIG_IO_DELAY_TYPE_0XED=3D1
> CONFIG_IO_DELAY_TYPE_UDELAY=3D2
> CONFIG_IO_DELAY_TYPE_NONE=3D3
> # CONFIG_IO_DELAY_0X80 is not set
> CONFIG_IO_DELAY_0XED=3Dy
> # CONFIG_IO_DELAY_UDELAY is not set
> # CONFIG_IO_DELAY_NONE is not set
> CONFIG_DEFAULT_IO_DELAY_TYPE=3D1
> # CONFIG_DEBUG_BOOT_PARAMS is not set
> # CONFIG_CPA_DEBUG is not set
> CONFIG_OPTIMIZE_INLINING=3Dy
>
> #
> # Security options
> #
> CONFIG_KEYS=3Dy
> # CONFIG_KEYS_DEBUG_PROC_KEYS is not set
> CONFIG_SECURITY=3Dy
> CONFIG_SECURITYFS=3Dy
> CONFIG_SECURITY_NETWORK=3Dy
> CONFIG_SECURITY_PATH=3Dy
> CONFIG_SECURITY_FILE_CAPABILITIES=3Dy
> CONFIG_SECURITY_DEFAULT_MMAP_MIN_ADDR=3D65536
> CONFIG_SECURITY_SELINUX=3Dy
> CONFIG_SECURITY_SELINUX_BOOTPARAM=3Dy
> CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE=3D0
> CONFIG_SECURITY_SELINUX_DISABLE=3Dy
> CONFIG_SECURITY_SELINUX_DEVELOP=3Dy
> CONFIG_SECURITY_SELINUX_AVC_STATS=3Dy
> CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=3D1
> # CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX is not set
> CONFIG_SECURITY_SMACK=3Dy
> # CONFIG_SECURITY_TOMOYO is not set
> CONFIG_CRYPTO=3Dy
>
> #
> # Crypto core or helper
> #
> CONFIG_CRYPTO_FIPS=3Dy
> CONFIG_CRYPTO_ALGAPI=3Dy
> CONFIG_CRYPTO_ALGAPI2=3Dy
> CONFIG_CRYPTO_AEAD=3Dy
> CONFIG_CRYPTO_AEAD2=3Dy
> CONFIG_CRYPTO_BLKCIPHER=3Dy
> CONFIG_CRYPTO_BLKCIPHER2=3Dy
> CONFIG_CRYPTO_HASH=3Dy
> CONFIG_CRYPTO_HASH2=3Dy
> CONFIG_CRYPTO_RNG=3Dy
> CONFIG_CRYPTO_RNG2=3Dy
> CONFIG_CRYPTO_PCOMP=3Dy
> CONFIG_CRYPTO_MANAGER=3Dy
> CONFIG_CRYPTO_MANAGER2=3Dy
> CONFIG_CRYPTO_GF128MUL=3Dy
> CONFIG_CRYPTO_NULL=3Dy
> CONFIG_CRYPTO_WORKQUEUE=3Dy
> CONFIG_CRYPTO_CRYPTD=3Dy
> # CONFIG_CRYPTO_AUTHENC is not set
>
> #
> # Authenticated Encryption with Associated Data
> #
> # CONFIG_CRYPTO_CCM is not set
> # CONFIG_CRYPTO_GCM is not set
> CONFIG_CRYPTO_SEQIV=3Dy
>
> #
> # Block modes
> #
> CONFIG_CRYPTO_CBC=3Dy
> # CONFIG_CRYPTO_CTR is not set
> # CONFIG_CRYPTO_CTS is not set
> # CONFIG_CRYPTO_ECB is not set
> # CONFIG_CRYPTO_LRW is not set
> # CONFIG_CRYPTO_PCBC is not set
> # CONFIG_CRYPTO_XTS is not set
>
> #
> # Hash modes
> #
> CONFIG_CRYPTO_HMAC=3Dy
> # CONFIG_CRYPTO_XCBC is not set
>
> #
> # Digest
> #
> CONFIG_CRYPTO_CRC32C=3Dy
> # CONFIG_CRYPTO_CRC32C_INTEL is not set
> # CONFIG_CRYPTO_MD4 is not set
> CONFIG_CRYPTO_MD5=3Dy
> # CONFIG_CRYPTO_MICHAEL_MIC is not set
> # CONFIG_CRYPTO_RMD128 is not set
> # CONFIG_CRYPTO_RMD160 is not set
> # CONFIG_CRYPTO_RMD256 is not set
> # CONFIG_CRYPTO_RMD320 is not set
> CONFIG_CRYPTO_SHA1=3Dy
> # CONFIG_CRYPTO_SHA256 is not set
> # CONFIG_CRYPTO_SHA512 is not set
> # CONFIG_CRYPTO_TGR192 is not set
> # CONFIG_CRYPTO_WP512 is not set
>
> #
> # Ciphers
> #
> CONFIG_CRYPTO_AES=3Dy
> # CONFIG_CRYPTO_AES_586 is not set
> # CONFIG_CRYPTO_ANUBIS is not set
> # CONFIG_CRYPTO_ARC4 is not set
> # CONFIG_CRYPTO_BLOWFISH is not set
> # CONFIG_CRYPTO_CAMELLIA is not set
> # CONFIG_CRYPTO_CAST5 is not set
> # CONFIG_CRYPTO_CAST6 is not set
> CONFIG_CRYPTO_DES=3Dy
> # CONFIG_CRYPTO_FCRYPT is not set
> # CONFIG_CRYPTO_KHAZAD is not set
> # CONFIG_CRYPTO_SALSA20 is not set
> # CONFIG_CRYPTO_SALSA20_586 is not set
> # CONFIG_CRYPTO_SEED is not set
> # CONFIG_CRYPTO_SERPENT is not set
> # CONFIG_CRYPTO_TEA is not set
> # CONFIG_CRYPTO_TWOFISH is not set
> # CONFIG_CRYPTO_TWOFISH_586 is not set
>
> #
> # Compression
> #
> CONFIG_CRYPTO_DEFLATE=3Dy
> CONFIG_CRYPTO_ZLIB=3Dy
> CONFIG_CRYPTO_LZO=3Dy
>
> #
> # Random Number Generation
> #
> CONFIG_CRYPTO_ANSI_CPRNG=3Dy
> # CONFIG_CRYPTO_HW is not set
> CONFIG_HAVE_KVM=3Dy
> CONFIG_HAVE_KVM_IRQCHIP=3Dy
> # CONFIG_VIRTUALIZATION is not set
> CONFIG_BINARY_PRINTF=3Dy
>
> #
> # Library routines
> #
> CONFIG_BITREVERSE=3Dy
> CONFIG_GENERIC_FIND_FIRST_BIT=3Dy
> CONFIG_GENERIC_FIND_NEXT_BIT=3Dy
> CONFIG_GENERIC_FIND_LAST_BIT=3Dy
> CONFIG_CRC_CCITT=3Dy
> CONFIG_CRC16=3Dy
> CONFIG_CRC_T10DIF=3Dy
> CONFIG_CRC_ITU_T=3Dy
> CONFIG_CRC32=3Dy
> CONFIG_CRC7=3Dy
> CONFIG_LIBCRC32C=3Dy
> CONFIG_AUDIT_GENERIC=3Dy
> CONFIG_ZLIB_INFLATE=3Dy
> CONFIG_ZLIB_DEFLATE=3Dy
> CONFIG_LZO_COMPRESS=3Dy
> CONFIG_LZO_DECOMPRESS=3Dy
> CONFIG_TEXTSEARCH=3Dy
> CONFIG_TEXTSEARCH_KMP=3Dy
> CONFIG_TEXTSEARCH_BM=3Dy
> CONFIG_TEXTSEARCH_FSM=3Dy
> CONFIG_HAS_IOMEM=3Dy
> CONFIG_HAS_IOPORT=3Dy
> CONFIG_HAS_DMA=3Dy
> CONFIG_NLATTR=3Dy
> --
> =A0-----Open up your eyes, open up your mind, open up your code -----=
--
> / Dr. David Alan Gilbert =A0 =A0| Running GNU/Linux on Alpha,68K| Hap=
py =A0\
> \ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex =
/
> =A0\ _________________________|_____ http://www.treblig.org =A0 |____=
___/
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
