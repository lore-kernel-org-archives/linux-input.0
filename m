From: Jiri Kosina <jikos@jikos.cz>
Subject: Re: [linux-usb-devel] Oops in khubd
Date: Mon, 4 Jun 2007 13:38:55 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0706041335320.29896@twin.jikos.cz>
References: <200706031240.43330.mb@bu3sch.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200706031240.43330.mb@bu3sch.de>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Michael Buesch <mb@bu3sch.de>
Cc: linux-usb-devel@lists.sourceforge.net, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

This is probably rather related to something in input. Some CCs added and 
original message preserved below.

I think that struct input_dev passed from hidinput_disconnect() should not 
be the corrupted one, as it is dereferenced sooner on the codepath and it 
doesn't go oops.

Thanks.

On Sun, 3 Jun 2007, Michael Buesch wrote:

> From time to time I get the following oops message after booting.
> I get this since quite some time. 2.6.21 also had this problem.
> I think earlier kernels, too.
> 
> I think that's a use-after-free bug or something like that. Look at
> the magic numbers
> [   76.480701] Unable to handle kernel paging request for data at address 0x6b6b6b6b
> 
> It doesn't happen on every boot and the machine still seems usable
> after it.
> 
> 
> [    0.000000] Using PowerMac machine description
> [    0.000000] Total memory = 512MB; using 1024kB for hash table (at cff00000)
> [    0.000000] Linux version 2.6.22-rc3-wldev (mb@pbook) (gcc version 4.1.2 20060928 (prerelease) (Ubuntu 4.1.1-13ubuntu5)) #43 PREEMPT Sat Jun 2 12:32:27 CEST 2007
> [    0.000000] Found UniNorth memory controller & host bridge @ 0xf8000000 revision: 0xd2
> [    0.000000] Mapped at 0xfdfc0000
> [    0.000000] Found a Intrepid mac-io controller, rev: 0, mapped at 0xfdf40000
> [    0.000000] Processor NAP mode on idle enabled.
> [    0.000000] PowerMac motherboard: PowerBook G4 15"
> [    0.000000] Entering add_active_range(0, 0, 131072) 0 entries of 256 used
> [    0.000000] Found UniNorth PCI host bridge at 0x00000000f0000000. Firmware bus number: 0->1
> [    0.000000] Found UniNorth PCI host bridge at 0x00000000f2000000. Firmware bus number: 0->1
> [    0.000000] Found UniNorth PCI host bridge at 0x00000000f4000000. Firmware bus number: 0->1
> [    0.000000] via-pmu: Server Mode is disabled
> [    0.000000] PMU driver v2 initialized for Core99, firmware: 0c
> [    0.000000] nvram: Checking bank 0...
> [    0.000000] nvram: gen0=478, gen1=479
> [    0.000000] nvram: Active bank is: 1
> [    0.000000] nvram: OF partition at 0x410
> [    0.000000] nvram: XP partition at 0x1020
> [    0.000000] nvram: NR partition at 0x1120
> [    0.000000] Top of RAM: 0x20000000, Total RAM: 0x20000000
> [    0.000000] Memory hole size: 0MB
> [    0.000000] Zone PFN ranges:
> [    0.000000]   DMA             0 ->   131072
> [    0.000000]   Normal     131072 ->   131072
> [    0.000000] early_node_map[1] active PFN ranges
> [    0.000000]     0:        0 ->   131072
> [    0.000000] On node 0 totalpages: 131072
> [    0.000000]   DMA zone: 1024 pages used for memmap
> [    0.000000]   DMA zone: 0 pages reserved
> [    0.000000]   DMA zone: 130048 pages, LIFO batch:31
> [    0.000000]   Normal zone: 0 pages used for memmap
> [    0.000000] Built 1 zonelists.  Total pages: 130048
> [    0.000000] Kernel command line: root=/dev/hda5 ro 
> [    0.000000] mpic: Setting up MPIC " MPIC 1   " version 1.2 at 80040000, max 4 CPUs
> [    0.000000] mpic: ISU size: 64, shift: 6, mask: 3f
> [    0.000000] mpic: Initializing for 64 sources
> [    0.000000] PID hash table entries: 2048 (order: 11, 8192 bytes)
> [    0.000000] GMT Delta read from XPRAM: 0 minutes, DST: off
> [    0.000000] time_init: decrementer frequency = 18.432000 MHz
> [    0.000000] time_init: processor frequency   = 1499.999994 MHz
> [   20.172436] Console: colour dummy device 80x25
> [   20.172954] console handover: boot [udbg0] -> real [tty0]
> [   20.173493] ------------------------
> [   20.173502] | Locking API testsuite:
> [   20.173509] ----------------------------------------------------------------------------
> [   20.173520]                                  | spin |wlock |rlock |mutex | wsem | rsem |
> [   20.173531]   --------------------------------------------------------------------------
> [   20.173546]                      A-A deadlock:failed|failed|  ok  |failed|failed|failed|
> [   20.173584]                  A-B-B-A deadlock:failed|failed|  ok  |failed|failed|failed|
> [   20.173619]              A-B-B-C-C-A deadlock:failed|failed|  ok  |failed|failed|failed|
> [   20.173653]              A-B-C-A-B-C deadlock:failed|failed|  ok  |failed|failed|failed|
> [   20.173688]          A-B-B-C-C-D-D-A deadlock:failed|failed|  ok  |failed|failed|failed|
> [   20.173724]          A-B-C-D-B-D-D-A deadlock:failed|failed|  ok  |failed|failed|failed|
> [   20.173760]          A-B-C-D-B-C-D-A deadlock:failed|failed|  ok  |failed|failed|failed|
> [   20.173797]                     double unlock:  ok  |  ok  |failed|  ok  |failed|failed|
> [   20.173827]                   initialize held:failed|failed|failed|failed|failed|failed|
> [   20.173864]                  bad unlock order:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
> [   20.173902]   --------------------------------------------------------------------------
> [   20.173920]               recursive read-lock:             |  ok  |             |failed|
> [   20.173948]            recursive read-lock #2:             |  ok  |             |failed|
> [   20.173976]             mixed read-write-lock:             |failed|             |failed|
> [   20.174003]             mixed write-read-lock:             |failed|             |failed|
> [   20.174032]   --------------------------------------------------------------------------
> [   20.174050]      hard-irqs-on + irq-safe-A/12:failed|failed|  ok  |
> [   20.174073]      soft-irqs-on + irq-safe-A/12:failed|failed|  ok  |
> [   20.174097]      hard-irqs-on + irq-safe-A/21:failed|failed|  ok  |
> [   20.174121]      soft-irqs-on + irq-safe-A/21:failed|failed|  ok  |
> [   20.174143]        sirq-safe-A => hirqs-on/12:failed|failed|  ok  |
> [   20.174167]        sirq-safe-A => hirqs-on/21:failed|failed|  ok  |
> [   20.174190]          hard-safe-A + irqs-on/12:failed|failed|  ok  |
> [   20.174213]          soft-safe-A + irqs-on/12:failed|failed|  ok  |
> [   20.174237]          hard-safe-A + irqs-on/21:failed|failed|  ok  |
> [   20.174260]          soft-safe-A + irqs-on/21:failed|failed|  ok  |
> [   20.174283]     hard-safe-A + unsafe-B #1/123:failed|failed|  ok  |
> [   20.174307]     soft-safe-A + unsafe-B #1/123:failed|failed|  ok  |
> [   20.174331]     hard-safe-A + unsafe-B #1/132:failed|failed|  ok  |
> [   20.174355]     soft-safe-A + unsafe-B #1/132:failed|failed|  ok  |
> [   20.174379]     hard-safe-A + unsafe-B #1/213:failed|failed|  ok  |
> [   20.174403]     soft-safe-A + unsafe-B #1/213:failed|failed|  ok  |
> [   20.174427]     hard-safe-A + unsafe-B #1/231:failed|failed|  ok  |
> [   20.174451]     soft-safe-A + unsafe-B #1/231:failed|failed|  ok  |
> [   20.174474]     hard-safe-A + unsafe-B #1/312:failed|failed|  ok  |
> [   20.174498]     soft-safe-A + unsafe-B #1/312:failed|failed|  ok  |
> [   20.174522]     hard-safe-A + unsafe-B #1/321:failed|failed|  ok  |
> [   20.174546]     soft-safe-A + unsafe-B #1/321:failed|failed|  ok  |
> [   20.174570]     hard-safe-A + unsafe-B #2/123:failed|failed|  ok  |
> [   20.174594]     soft-safe-A + unsafe-B #2/123:failed|failed|  ok  |
> [   20.174618]     hard-safe-A + unsafe-B #2/132:failed|failed|  ok  |
> [   20.174642]     soft-safe-A + unsafe-B #2/132:failed|failed|  ok  |
> [   20.174667]     hard-safe-A + unsafe-B #2/213:failed|failed|  ok  |
> [   20.174691]     soft-safe-A + unsafe-B #2/213:failed|failed|  ok  |
> [   20.174715]     hard-safe-A + unsafe-B #2/231:failed|failed|  ok  |
> [   20.174739]     soft-safe-A + unsafe-B #2/231:failed|failed|  ok  |
> [   20.174763]     hard-safe-A + unsafe-B #2/312:failed|failed|  ok  |
> [   20.174787]     soft-safe-A + unsafe-B #2/312:failed|failed|  ok  |
> [   20.174811]     hard-safe-A + unsafe-B #2/321:failed|failed|  ok  |
> [   20.174835]     soft-safe-A + unsafe-B #2/321:failed|failed|  ok  |
> [   20.174859]       hard-irq lock-inversion/123:failed|failed|  ok  |
> [   20.174883]       soft-irq lock-inversion/123:failed|failed|  ok  |
> [   20.174908]       hard-irq lock-inversion/132:failed|failed|  ok  |
> [   20.174931]       soft-irq lock-inversion/132:failed|failed|  ok  |
> [   20.174955]       hard-irq lock-inversion/213:failed|failed|  ok  |
> [   20.174979]       soft-irq lock-inversion/213:failed|failed|  ok  |
> [   20.175003]       hard-irq lock-inversion/231:failed|failed|  ok  |
> [   20.175027]       soft-irq lock-inversion/231:failed|failed|  ok  |
> [   20.175051]       hard-irq lock-inversion/312:failed|failed|  ok  |
> [   20.175075]       soft-irq lock-inversion/312:failed|failed|  ok  |
> [   20.175099]       hard-irq lock-inversion/321:failed|failed|  ok  |
> [   20.175123]       soft-irq lock-inversion/321:failed|failed|  ok  |
> [   20.175147]       hard-irq read-recursion/123:  ok  |
> [   20.175163]       soft-irq read-recursion/123:  ok  |
> [   20.175179]       hard-irq read-recursion/132:  ok  |
> [   20.175195]       soft-irq read-recursion/132:  ok  |
> [   20.175211]       hard-irq read-recursion/213:  ok  |
> [   20.175227]       soft-irq read-recursion/213:  ok  |
> [   20.175244]       hard-irq read-recursion/231:  ok  |
> [   20.175260]       soft-irq read-recursion/231:  ok  |
> [   20.175276]       hard-irq read-recursion/312:  ok  |
> [   20.175292]       soft-irq read-recursion/312:  ok  |
> [   20.175308]       hard-irq read-recursion/321:  ok  |
> [   20.175324]       soft-irq read-recursion/321:  ok  |
> [   20.175341] --------------------------------------------------------
> [   20.175355] 142 out of 218 testcases failed, as expected. |
> [   20.175368] ----------------------------------------------------
> [   20.175836] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
> [   20.176456] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
> [   20.202086] Memory: 512768k/524288k available (5032k kernel code, 11224k reserved, 236k data, 257k bss, 172k init)
> [   20.202759] Calibrating delay loop... 36.76 BogoMIPS (lpj=183808)
> [   20.392393] Mount-cache hash table entries: 512
> [   20.393144] device-tree: Duplicate name in /cpus/PowerPC,G4@0, renamed to "l2-cache#1"
> [   20.399557] NET: Registered protocol family 16
> [   20.401208] KeyWest i2c @0xf8001003 irq 42 /uni-n@f8000000/i2c@f8001000
> [   20.401233]  channel 1 bus /uni-n@f8000000/i2c@f8001000/i2c-bus@1
> [   20.401248]  channel 0 bus /uni-n@f8000000/i2c@f8001000/i2c-bus@0
> [   20.401300] KeyWest i2c @0x80018000 irq 26 /pci@f2000000/mac-io@17/i2c@18000
> [   20.401318]  channel 0 bus /pci@f2000000/mac-io@17/i2c@18000/i2c-bus@0
> [   20.401340] PMU i2c /pci@f2000000/mac-io@17/via-pmu@16000/pmu-i2c
> [   20.401356]  channel 1 bus <multibus>
> [   20.401369]  channel 2 bus <multibus>
> [   20.402022] PCI: Probing PCI hardware
> [   20.410017] Can't get bus-range for /pci@f2000000/cardbus@13, assuming it starts at 0
> [   20.410100] PCI: Cannot allocate resource region 0 of device 0001:10:19.0
> [   20.410138] Apple USB OHCI 0001:10:19.0 disabled by firmware
> [   20.426064] SCSI subsystem initialized
> [   20.426580] usbcore: registered new interface driver usbfs
> [   20.426937] usbcore: registered new interface driver hub
> [   20.427278] usbcore: registered new device driver usb
> [   20.427694] Bluetooth: Core ver 2.11
> [   20.427846] NET: Registered protocol family 31
> [   20.427859] Bluetooth: HCI device and connection manager initialized
> [   20.427875] Bluetooth: HCI socket layer initialized
> [   20.431526] PCI: Enabling device 0002:24:0e.0 (0000 -> 0002)
> [   20.483887] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[40]  MMIO=[f5000000-f50007ff]  Max Packet=[4096]  IR/IT contexts=[8/8]
> [   20.494010] NET: Registered protocol family 2
> [   20.572283] IP route cache hash table entries: 16384 (order: 4, 65536 bytes)
> [   20.572726] TCP established hash table entries: 65536 (order: 8, 1310720 bytes)
> [   20.576545] TCP bind hash table entries: 65536 (order: 8, 1310720 bytes)
> [   20.581325] TCP: Hash tables configured (established 65536 bind 65536)
> [   20.581349] TCP reno registered
> [   20.602573] Thermal assist unit not available
> [   20.603475] Registering PowerMac CPU frequency driver
> [   20.603495] Low: 749 Mhz, High: 1499 Mhz, Boot: 749 Mhz
> [   20.624077] Initializing RT-Tester: OK
> [   20.624730] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> [   20.625674] fuse init (API version 7.8)
> [   20.626188] io scheduler noop registered
> [   20.626231] io scheduler cfq registered (default)
> [   20.626698] PCI: Enabling device 0000:00:10.0 (0006 -> 0007)
> [   20.822314] radeonfb (0000:00:10.0): Invalid ROM signature 303 should be 0xaa55
> [   20.822323] radeonfb: Retrieved PLL infos from Open Firmware
> [   20.822334] radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=203.00 Mhz, System=392.00 MHz
> [   20.822344] radeonfb: PLL min 12000 max 35000
> [   20.965917] i2c-adapter i2c-2: unable to read EDID block.
> [   21.185913] i2c-adapter i2c-2: unable to read EDID block.
> [   21.405912] i2c-adapter i2c-2: unable to read EDID block.
> [   21.812689] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[001124fffed98036]
> [   21.873149] radeonfb: Monitor 1 type LCD found
> [   21.873158] radeonfb: EDID probed
> [   21.873164] radeonfb: Monitor 2 type no found
> [   21.873178] radeonfb: Using Firmware dividers 0x0002008e from PPLL 0
> [   21.873290] radeonfb: Dynamic Clock Power Management enabled
> [   21.914831] Console: switching to colour frame buffer device 160x53
> [   21.937856] radeonfb: Backlight initialized (radeonbl0)
> [   21.938049] radeonfb (0000:00:10.0): ATI Radeon NP 
> [   21.949477] Generic RTC Driver v1.07
> [   21.949807] Macintosh non-volatile memory driver v1.1
> [   21.950153] Linux agpgart interface v0.102 (c) Dave Jones
> [   21.950501] agpgart: Detected Apple UniNorth 2 chipset
> [   21.950818] agpgart: configuring for size idx: 8
> [   21.951175] agpgart: AGP aperture is 32M @ 0x0
> [   21.951440] [drm] Initialized drm 1.1.0 20060810
> [   21.951945] [drm] Initialized radeon 1.27.0 20060524 on minor 0
> [   21.952201] loop: module loaded
> [   21.952499] sungem.c:v0.98 8/24/03 David S. Miller (davem@redhat.com)
> [   22.032509] PHY ID: 1410cc2, addr: 0
> [   22.033220] eth0: Sun GEM (PCI) 10/100/1000BaseT Ethernet 00:11:24:d9:80:36 
> [   22.033642] eth0: Found Marvell 88E1111 PHY
> [   22.034292] MacIO PCI driver attached to Intrepid chipset
> [   22.037489] adb: starting probe task...
> [   22.037646] adb: finished probe task...
> [   22.037809] adt746x: version 1 (supported)
> [   22.037966] adt746x: Thermostat bus: 1, address: 0x2e, limit_adjust: 0, fan_speed: -1
> [   22.038233] sensor 0: CPU/INTREPID BOTTOMSIDE
> [   22.038395] sensor 1: CPU BOTTOMSIDE
> [   22.038531] sensor 2: PWR SUPPLY BOTTOMSIDE
> [   22.039182] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> [   22.039410] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> [   22.039931] PCI: Enabling device 0002:24:0d.0 (0000 -> 0002)
> [   23.062168] ide0: Found Apple UniNorth ATA-6 controller, bus ID 3, irq 39
> [   23.062412] Probing IDE interface ide0...
> [   23.362346] hda: Hitachi HTS541080G9AT00, ATA DISK drive
> [   24.082172] hda: Enabling Ultra DMA 5
> [   24.091949] ide0 at 0xe101a000-0xe101a007,0xe101a160 on irq 39
> [   25.122166] ide1: Found Apple KeyLargo ATA-3 controller, bus ID 0, irq 24
> [   25.130910] Probing IDE interface ide1...
> [   25.552343] hdc: MATSHITACD-RW CW-8123, ATAPI CD/DVD-ROM drive
> [   25.912168] hdc: Enabling MultiWord DMA 2
> [   25.921983] ide1 at 0xe101e000-0xe101e007,0xe101e160 on irq 24
> [   25.931217] hda: max request size: 512KiB
> [   25.954715] hda: 156301488 sectors (80026 MB) w/7539KiB Cache, CHS=16383/255/63, UDMA(100)
> [   25.964246] hda: cache flushes supported
> [   25.973316]  hda: [mac] hda1 hda2 hda3 hda4 hda5 hda6 hda7
> [   25.991318] hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, (U)DMA
> [   26.000672] Uniform CD-ROM driver Revision: 3.20
> [   26.012329] video1394: Installed video1394 module
> [   26.021620] ieee1394: raw1394: /dev/raw1394 device initialized
> [   26.031095] NOTE: The dv1394 driver is unsupported and may be removed in a future Linux release. Use raw1394 instead.
> [   26.041330] eth1394: eth1: IPv4 over IEEE 1394 (fw-host0)
> [   26.051406] Yenta: CardBus bridge found at 0001:10:13.0 [0000:0000]
> [   26.061019] PCI: Bus 17, cardbus bridge: 0001:10:13.0
> [   26.070524]   IO window: 00001000-000011ff
> [   26.080177]   IO window: 00001400-000015ff
> [   26.089832]   PREFETCH window: 90000000-9fffffff
> [   26.099420]   MEM window: f3000000-f33fffff
> [   26.109065] Yenta: Enabling burst memory read transactions
> [   26.118806] Yenta: Using CSCINT to route CSC interrupts to PCI
> [   26.128615] Yenta: Routing CardBus interrupts to PCI
> [   26.138376] Yenta TI: socket 0001:10:13.0, mfunc 0x00001002, devctl 0x60
> [   26.252187] Yenta: ISA IRQ mask 0x0000, PCI irq 53
> [   26.261989] Socket status: 30000087
> [   26.271777] pcmcia: parent PCI bridge I/O window: 0x0 - 0x7fffff
> [   26.281702] pcmcia: parent PCI bridge Memory window: 0xf3000000 - 0xf3ffffff
> [   26.291623] pcmcia: parent PCI bridge Memory window: 0x80000000 - 0xafffffff
> [   26.302024] PCI: Enabling device 0001:10:1b.2 (0004 -> 0006)
> [   26.311936] ehci_hcd 0001:10:1b.2: EHCI Host Controller
> [   26.322077] ehci_hcd 0001:10:1b.2: new USB bus registered, assigned bus number 1
> [   26.362179] ehci_hcd 0001:10:1b.2: irq 63, io mem 0xa0000000
> [   26.372216] ehci_hcd 0001:10:1b.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
> [   26.382814] usb usb1: configuration #1 chosen from 1 choice
> [   26.393089] hub 1-0:1.0: USB hub found
> [   26.403079] hub 1-0:1.0: 5 ports detected
> [   26.522602] USB Universal Host Controller Interface driver v3.0
> [   26.532785] sl811: driver sl811-hcd, 19 May 2005
> [   26.543052] usbcore: registered new interface driver cdc_acm
> [   26.553179] drivers/usb/class/cdc-acm.c: v0.25:USB Abstract Control Model driver for USB modems and ISDN adapters
> [   26.563776] usbcore: registered new interface driver usblp
> [   26.574235] drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
> [   26.584687] Initializing USB Mass Storage driver...
> [   26.595404] usbcore: registered new interface driver usb-storage
> [   26.606107] USB Mass Storage support registered.
> [   26.616890] mice: PS/2 mouse device common for all mice
> [   26.627483] I2O subsystem v1.325
> [   26.637939] i2o: max drivers = 8
> [   26.648654] I2O Configuration OSM v1.323
> [   26.659214] I2O Bus Adapter OSM v1.317
> [   26.669511] I2O Block Device OSM v1.325
> [   26.680411] I2O SCSI Peripheral OSM v1.316
> [   26.690553] I2O ProcFS OSM v1.316
> [   26.700537] i2c /dev entries driver
> [   26.711637] PowerMac i2c bus pmu 2 registered
> [   26.721666] PowerMac i2c bus pmu 1 registered
> [   26.731570] PowerMac i2c bus mac-io 0 registered
> [   26.741296] PowerMac i2c bus uni-n 0 registered
> [   26.751104] adt746x: ADT7467 initializing
> [   26.762424] adt746x: Lowering max temperatures from 81, 80, 87 to 70, 50, 70
> [   26.772983] PowerMac i2c bus uni-n 1 registered
> [   26.782387] device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
> [   26.791918] Bluetooth: HCI USB driver ver 2.9
> [   26.801531] usbcore: registered new interface driver hci_usb
> [   26.810997] usbcore: registered new interface driver hiddev
> [   26.820095] usbcore: registered new interface driver usbhid
> [   26.828941] drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
> [   26.837973] Advanced Linux Sound Architecture Driver Version 1.0.14rc4 (Wed May 16 09:45:46 2007 UTC).
> [   26.848906] snd-aoa-fabric-layout: found bus with layout 70
> [   26.858154] snd-aoa-fabric-layout: Using PMF GPIOs
> [   26.859220] snd-aoa-codec-tas: found tas3004
> [   26.859272] snd-aoa-fabric-layout: can use this codec
> [   26.955981] snd-aoa-codec-tas: tas found, addr 0x35 on /pci@f2000000/mac-io@17/i2c@18000/i2c-bus@0/codec@6a
> [   26.955996] snd-aoa: fabric didn't like codec toonie
> [   26.965221] ALSA device list:
> [   26.974334]   #0: SoundByLayout
> [   26.983426] oprofile: using ppc/7450 performance monitoring.
> [   26.983889] netem: version 1.2
> [   26.992849] u32 classifier
> [   27.001668]     Performance counters on
> [   27.010466]     input device check on 
> [   27.019274] TCP cubic registered
> [   27.027875] Bluetooth: L2CAP ver 2.8
> [   27.036487] Bluetooth: L2CAP socket layer initialized
> [   27.047246] Bluetooth: SCO (Voice Link) ver 0.5
> [   27.055911] Bluetooth: SCO socket layer initialized
> [   27.064453] Bluetooth: RFCOMM socket layer initialized
> [   27.072953] Bluetooth: RFCOMM TTY layer initialized
> [   27.081291] Bluetooth: RFCOMM ver 1.8
> [   27.089589] Bluetooth: BNEP (Ethernet Emulation) ver 1.2
> [   27.097772] Bluetooth: BNEP filters: protocol multicast
> [   27.105856] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
> [   27.114890] input: PMU as /class/input/input0
> [   27.137754] ReiserFS: hda5: found reiserfs format "3.6" with standard journal
> [   27.146053] ReiserFS: hda5: using ordered data mode
> [   27.165318] ReiserFS: hda5: journal params: device hda5, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
> [   27.184486] ReiserFS: hda5: checking transaction log (hda5)
> [   27.240336] ReiserFS: hda5: Using r5 hash to sort names
> [   27.248903] VFS: Mounted root (reiserfs filesystem) readonly.
> [   27.257494] Freeing unused kernel memory: 172k init
> [   27.864861] NET: Registered protocol family 1
> [   36.791973] ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
> [   36.792552] Apple USB OHCI 0001:10:19.0 disabled by firmware
> [   36.809642] PCI: Enabling device 0001:10:1a.0 (0000 -> 0002)
> [   36.818255] ohci_hcd 0001:10:1a.0: OHCI Host Controller
> [   36.827120] ohci_hcd 0001:10:1a.0: new USB bus registered, assigned bus number 2
> [   36.836068] ohci_hcd 0001:10:1a.0: irq 29, io mem 0xa0003000
> [   37.147057] usb usb2: configuration #1 chosen from 1 choice
> [   37.156257] hub 2-0:1.0: USB hub found
> [   37.165187] hub 2-0:1.0: 2 ports detected
> [   37.322676] PCI: Enabling device 0001:10:1b.0 (0000 -> 0002)
> [   37.331429] ohci_hcd 0001:10:1b.0: OHCI Host Controller
> [   37.340137] ohci_hcd 0001:10:1b.0: new USB bus registered, assigned bus number 3
> [   37.349109] ohci_hcd 0001:10:1b.0: irq 63, io mem 0xa0002000
> [   37.432263] usb usb3: configuration #1 chosen from 1 choice
> [   37.441347] hub 3-0:1.0: USB hub found
> [   37.450137] hub 3-0:1.0: 3 ports detected
> [   37.563068] PCI: Enabling device 0001:10:1b.1 (0000 -> 0002)
> [   37.571508] ohci_hcd 0001:10:1b.1: OHCI Host Controller
> [   37.580070] ohci_hcd 0001:10:1b.1: new USB bus registered, assigned bus number 4
> [   37.588724] ohci_hcd 0001:10:1b.1: irq 63, io mem 0xa0001000
> [   37.622191] usb 2-1: new full speed USB device using ohci_hcd and address 2
> [   37.672643] usb usb4: configuration #1 chosen from 1 choice
> [   37.681599] hub 4-0:1.0: USB hub found
> [   37.690519] hub 4-0:1.0: 2 ports detected
> [   37.848403] usb 2-1: configuration #1 chosen from 1 choice
> [   37.876771] input: HID 05ac:1000 as /class/input/input1
> [   37.885998] input: USB HID v1.11 Keyboard [HID 05ac:1000] on usb-0001:10:1a.0-1
> [   37.911775] input: HID 05ac:1000 as /class/input/input2
> [   37.921216] input: USB HID v1.11 Mouse [HID 05ac:1000] on usb-0001:10:1a.0-1
> [   38.242208] usb 2-2: new full speed USB device using ohci_hcd and address 3
> [   38.431429] usb 2-2: configuration #1 chosen from 1 choice
> [   38.447751] input: Apple Computer Apple Internal Keyboard/Trackpad as /class/input/input3
> [   38.457766] input: USB HID v1.10 Keyboard [Apple Computer Apple Internal Keyboard/Trackpad] on usb-0001:10:1a.0-2
> [   38.477283] input: Apple Computer Apple Internal Keyboard/Trackpad as /class/input/input4
> [   38.487560] input: USB HID v1.10 Device [Apple Computer Apple Internal Keyboard/Trackpad] on usb-0001:10:1a.0-2
> [   38.770727] NET: Registered protocol family 17
> [   39.152330] Adding 517568k swap on /dev/disk/by-uuid/5bf036c9-fa34-490c-88e6-3bf55a393f93.  Priority:-1 extents:1 across:517568k
> [   48.084799] device-mapper: table: 254:0: linear: dm-linear: Device lookup failed
> [   48.105118] device-mapper: ioctl: error adding target to table
> [   48.121486] device-mapper: table: 254:0: linear: dm-linear: Device lookup failed
> [   48.131981] device-mapper: ioctl: error adding target to table
> [   48.149123] device-mapper: table: 254:0: linear: dm-linear: Device lookup failed
> [   48.159694] device-mapper: ioctl: error adding target to table
> [   48.176189] device-mapper: table: 254:0: linear: dm-linear: Device lookup failed
> [   48.186793] device-mapper: ioctl: error adding target to table
> [   48.203331] device-mapper: table: 254:0: linear: dm-linear: Device lookup failed
> [   48.214097] device-mapper: ioctl: error adding target to table
> [   48.230734] device-mapper: table: 254:0: linear: dm-linear: Device lookup failed
> [   48.241489] device-mapper: ioctl: error adding target to table
> [   48.258212] device-mapper: table: 254:0: linear: dm-linear: Device lookup failed
> [   48.269020] device-mapper: ioctl: error adding target to table
> [   48.285890] device-mapper: table: 254:0: linear: dm-linear: Device lookup failed
> [   48.296706] device-mapper: ioctl: error adding target to table
> [   48.313403] device-mapper: table: 254:0: linear: dm-linear: Device lookup failed
> [   48.324135] device-mapper: ioctl: error adding target to table
> [   48.341063] device-mapper: table: 254:0: linear: dm-linear: Device lookup failed
> [   48.351902] device-mapper: ioctl: error adding target to table
> [   48.369331] device-mapper: table: 254:0: linear: dm-linear: Device lookup failed
> [   48.380149] device-mapper: ioctl: error adding target to table
> [   48.396844] device-mapper: table: 254:0: linear: dm-linear: Device lookup failed
> [   48.407676] device-mapper: ioctl: error adding target to table
> [   48.424259] device-mapper: table: 254:0: linear: dm-linear: Device lookup failed
> [   48.435416] device-mapper: ioctl: error adding target to table
> [   48.451968] device-mapper: table: 254:0: linear: dm-linear: Device lookup failed
> [   48.462558] device-mapper: ioctl: error adding target to table
> [   48.478959] device-mapper: table: 254:0: linear: dm-linear: Device lookup failed
> [   48.489385] device-mapper: ioctl: error adding target to table
> [   48.505462] device-mapper: table: 254:0: linear: dm-linear: Device lookup failed
> [   48.515724] device-mapper: ioctl: error adding target to table
> [   48.531951] device-mapper: table: 254:0: linear: dm-linear: Device lookup failed
> [   48.542359] device-mapper: ioctl: error adding target to table
> [   48.558729] device-mapper: table: 254:0: linear: dm-linear: Device lookup failed
> [   48.569164] device-mapper: ioctl: error adding target to table
> [   48.585645] device-mapper: table: 254:0: linear: dm-linear: Device lookup failed
> [   48.596253] device-mapper: ioctl: error adding target to table
> [   48.612772] device-mapper: table: 254:0: linear: dm-linear: Device lookup failed
> [   48.623379] device-mapper: ioctl: error adding target to table
> [   57.387438] ReiserFS: hda6: found reiserfs format "3.6" with standard journal
> [   57.397919] ReiserFS: hda6: using ordered data mode
> [   57.421119] ReiserFS: hda6: journal params: device hda6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
> [   57.444884] ReiserFS: hda6: checking transaction log (hda6)
> [   57.486486] ReiserFS: hda6: Using r5 hash to sort names
> [   75.699626] ondemand governor failed to load due to too long transition latency
> [   76.459118] usb 2-1: USB disconnect, address 2
> [   76.480701] Unable to handle kernel paging request for data at address 0x6b6b6b6b
> [   76.482087] Faulting instruction address: 0xc02c1cbc
> [   76.482909] Oops: Kernel access of bad area, sig: 11 [#1]
> [   76.483572] PREEMPT PowerMac
> [   76.484189] Modules linked in: af_packet ohci_hcd ssb pcmcia unix
> [   76.484982] NIP: c02c1cbc LR: c02c1ca8 CTR: c008961c
> [   76.485625] REGS: dff13d90 TRAP: 0300   Not tainted  (2.6.22-rc3-wldev)
> [   76.486320] MSR: 00009032 <EE,ME,IR,DR>  CR: 22008088  XER: 00000000
> [   76.487159] DAR: 6b6b6b6b, DSISR: 40000000
> [   76.487763] TASK = dff119f0[83] 'khubd' THREAD: dff12000
> [   76.487947] GPR00: c02c1ca8 dff13e40 dff119f0 c0536020 c04687e0 00000006 00000011 00000000 
> [   76.488930] GPR08: 00000002 6b6b6b6b 22004242 dff12000 00000000 00000000 00000000 00000000 
> [   76.489915] GPR16: 00000000 00000000 df0ea6c8 00000000 00000002 00000000 df0ea6e0 00000001 
> [   76.490931] GPR24: df642518 df64280c df642da0 df0ea098 df0ea080 6b6b675b dec5556c dec55550 
> [   76.492363] NIP [c02c1cbc] evdev_disconnect+0x94/0xf4
> [   76.493057] LR [c02c1ca8] evdev_disconnect+0x80/0xf4
> [   76.493725] Call Trace:
> [   76.494291] [dff13e40] [c02c1ca8] evdev_disconnect+0x80/0xf4 (unreliable)
> [   76.495063] [dff13e60] [c02be900] input_unregister_device+0x98/0x130
> [   76.495799] [dff13e70] [c02e2140] hidinput_disconnect+0x40/0x80
> [   76.496518] [dff13e90] [c02e6328] hid_disconnect+0x78/0xd4
> [   76.497220] [dff13eb0] [c0299c80] usb_unbind_interface+0x48/0x90
> [   76.497950] [dff13ed0] [c021e6e4] __device_release_driver+0x98/0xc4
> [   76.498686] [dff13ee0] [c021ec4c] device_release_driver+0x50/0x84
> [   76.499409] [dff13ef0] [c021deb0] bus_remove_device+0x84/0xb0
> [   76.500132] [dff13f00] [c021ba24] device_del+0x274/0x324
> [   76.500834] [dff13f20] [c02970c8] usb_disable_device+0x80/0x110
> [   76.501561] [dff13f40] [c029331c] usb_disconnect+0xc4/0x150
> [   76.502269] [dff13f70] [c0293a74] hub_thread+0x354/0xac4
> [   76.502965] [dff13fd0] [c00435ec] kthread+0x4c/0x88
> [   76.503656] [dff13ff0] [c001433c] kernel_thread+0x44/0x60
> [   76.504367] Instruction dump:
> [   76.504960] 7fc3f378 4bffb645 387f0040 38800001 38a00001 38c00000 4bd66b1d 813f005c 
> [   76.505905] 4800000c 4bdc5021 813d0410 3ba9fbf0 <801d0410> 2f800000 419e0008 7c00022c 
> 
> 

-- 
Jiri Kosina
