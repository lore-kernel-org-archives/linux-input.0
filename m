From: Vincent Jaubert <contact@vjaubert.com>
Subject: Re: Elantech touchpad on Fujitsu E554 not working at all
Date: Wed, 17 Dec 2014 23:26:21 +0100
Message-ID: <CANWhK-jhAqH25BFbjGrYDzOeko8etw1_p42i-6qzhGt8U1JSVQ@mail.gmail.com>
References: <CANWhK-ikUMJ8ZuX6VjoKgtb+o_OMKEU33y8ed=EQ9H-o2bOGLQ@mail.gmail.com>
	<20141217220956.GA3730@lantern>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:52107 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790AbaLQW0X convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Dec 2014 17:26:23 -0500
Received: by mail-lb0-f173.google.com with SMTP id z12so12431lbi.4
        for <linux-input@vger.kernel.org>; Wed, 17 Dec 2014 14:26:21 -0800 (PST)
In-Reply-To: <20141217220956.GA3730@lantern>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: ulrik.debie-os@e2big.org
Cc: linux-input@vger.kernel.org

The touchpad has two regular buttons under it.

Enjoy ski !


dmesg | grep -i mouse
[    0.976197] mousedev: PS/2 mouse device common for all mice
[    1.698332] usb 1-9: Product: USB Optical Mouse
[    1.704791] input: USB Optical Mouse as
/devices/pci0000:00/0000:00:14.0/usb1/1-9/1-9:1.0/0003:0461:4D22.0001/i=
nput/input10
[    1.704880] hid-generic 0003:0461:4D22.0001: input,hidraw0: USB HID
v1.11 Mouse [USB Optical Mouse] on usb-0000:00:14.0-9/input0
[    2.606437] psmouse serio2: elantech: assuming hardware version 4
(with firmware version 0x570f01)
[    2.641459] psmouse serio2: elantech: Synaptics capabilities query
result 0xc0, 0x14, 0x0c.
[  197.641817] psmouse serio2: Touchpad at isa0060/serio2/input0 lost
sync at byte 6
[  197.650024] psmouse serio2: Touchpad at isa0060/serio2/input0 lost
sync at byte 6
[  197.658131] psmouse serio2: Touchpad at isa0060/serio2/input0 lost
sync at byte 6
[  197.669019] psmouse serio2: Touchpad at isa0060/serio2/input0 lost
sync at byte 6
[  197.677251] psmouse serio2: Touchpad at isa0060/serio2/input0 lost
sync at byte 6
[  197.677262] psmouse serio2: issuing reconnect request


dmesg | grep -i elantech
[    2.606437] psmouse serio2: elantech: assuming hardware version 4
(with firmware version 0x570f01)
[    2.641459] psmouse serio2: elantech: Synaptics capabilities query
result 0xc0, 0x14, 0x0c.
[    2.810696] input: Elantech PS/2 TrackPoint as
/devices/platform/i8042/serio2/input/input11
[    2.851456] input: ETPS/2 Elantech Touchpad as
/devices/platform/i8042/serio2/input/input9




"Full" start of dmesg
[    0.373715] UDP-Lite hash table entries: 8192 (order: 6, 262144 byte=
s)
[    0.373780] NET: Registered protocol family 1
[    0.373793] pci 0000:00:02.0: Video device with shadowed ROM
[    0.373863] pci 0000:00:14.0: can't derive routing for PCI INT A
[    0.373864] pci 0000:00:14.0: PCI INT A: no GSI
[    0.373934] pci 0000:00:14.0: can't derive routing for PCI INT A
[    0.373981] PCI: CLS 64 bytes, default 64
[    0.374023] Trying to unpack rootfs image as initramfs...
[    0.642830] Freeing initrd memory: 19180K (ffff880035a7a000 -
ffff880036d35000)
[    0.642855] PCI-DMA: Using software bounce buffering for IO (SWIOTLB=
)
[    0.642857] software IO TLB [mem 0xd664f000-0xda64f000] (64MB)
mapped at [ffff8800d664f000-ffff8800da64efff]
[    0.643024] RAPL PMU detected, hw unit 2^-14 Joules, API unit is
2^-32 Joules, 4 fixed counters 655360 ms ovfl timer
[    0.643067] microcode: CPU0 sig=3D0x306c3, pf=3D0x10, revision=3D0x1=
c
[    0.643073] microcode: CPU1 sig=3D0x306c3, pf=3D0x10, revision=3D0x1=
c
[    0.643080] microcode: CPU2 sig=3D0x306c3, pf=3D0x10, revision=3D0x1=
c
[    0.643087] microcode: CPU3 sig=3D0x306c3, pf=3D0x10, revision=3D0x1=
c
[    0.643131] microcode: Microcode Update Driver: v2.00
<tigran@aivazian.fsnet.co.uk>, Peter Oruba
[    0.643154] Scanning for low memory corruption every 60 seconds
[    0.643450] futex hash table entries: 2048 (order: 5, 131072 bytes)
[    0.643473] Initialise system trusted keyring
[    0.643493] audit: initializing netlink subsys (disabled)
[    0.643503] audit: type=3D2000 audit(1418854538.644:1): initialized
[    0.643780] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.644938] zpool: loaded
[    0.644939] zbud: loaded
[    0.645096] VFS: Disk quotas dquot_6.5.2
[    0.645122] Dquot-cache hash table entries: 512 (order 0, 4096 bytes=
)
[    0.645486] fuse init (API version 7.23)
[    0.645557] msgmni has been set to 31888
[    0.645606] Key type big_key registered
[    0.645975] Key type asymmetric registered
[    0.645978] Asymmetric key parser 'x509' registered
[    0.646007] Block layer SCSI generic (bsg) driver version 0.4
loaded (major 252)
[    0.646042] io scheduler noop registered
[    0.646045] io scheduler deadline registered (default)
[    0.646068] io scheduler cfq registered
[    0.646501] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    0.646513] pciehp: PCI Express Hot Plug Controller Driver version: =
0.4
[    0.646554] vesafb: mode is 1920x1080x32, linelength=3D7680, pages=3D=
0
[    0.646554] vesafb: scrolling: redraw
[    0.646556] vesafb: Truecolor: size=3D8:8:8:8, shift=3D24:16:8:0
[    0.646573] vesafb: framebuffer at 0xe0000000, mapped to
0xffffc90005c00000, using 8128k, total 8128k
[    0.799811] Console: switching to colour frame buffer device 240x67
[    0.952426] fb0: VESA VGA frame buffer device
[    0.952448] intel_idle: MWAIT substates: 0x42120
[    0.952449] intel_idle: v0.4 model 0x3C
[    0.952450] intel_idle: lapic_timer_reliable_states 0xffffffff
[    0.952745] ACPI: AC Adapter [AC] (on-line)
[    0.952906] input: Lid Switch as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input0
[    0.952931] ACPI: Lid Switch [LID]
[    0.952959] input: Power Button as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
[    0.952961] ACPI: Power Button [PWRB]
[    0.952987] input: Sleep Button as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input2
[    0.952989] ACPI: Sleep Button [SLPB]
[    0.953142] GHES: HEST is not enabled!
[    0.953252] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.955483] Linux agpgart interface v0.103
[    0.956570] brd: module loaded
[    0.957058] loop: module loaded
[    0.957232] libphy: Fixed MDIO Bus: probed
[    0.957234] tun: Universal TUN/TAP device driver, 1.6
[    0.957235] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    0.957267] PPP generic driver version 2.4.2
[    0.957367] xhci_hcd 0000:00:14.0: can't derive routing for PCI INT =
A
[    0.957369] xhci_hcd 0000:00:14.0: PCI INT A: no GSI
[    0.957392] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.957397] xhci_hcd 0000:00:14.0: new USB bus registered, assigned
bus number 1
[    0.957486] xhci_hcd 0000:00:14.0: cache line size of 64 is not supp=
orted
[    0.957504] xhci_hcd 0000:00:14.0: irq 24 for MSI/MSI-X
[    0.957562] usb usb1: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0002
[    0.957564] usb usb1: New USB device strings: Mfr=3D3, Product=3D2,
SerialNumber=3D1
[    0.957565] usb usb1: Product: xHCI Host Controller
[    0.957566] usb usb1: Manufacturer: Linux 3.18.0-vanillaice xhci-hcd
[    0.957567] usb usb1: SerialNumber: 0000:00:14.0
[    0.957647] hub 1-0:1.0: USB hub found
[    0.957672] hub 1-0:1.0: 14 ports detected
[    0.962646] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.962650] xhci_hcd 0000:00:14.0: new USB bus registered, assigned
bus number 2
[    0.962706] usb usb2: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0003
[    0.962708] usb usb2: New USB device strings: Mfr=3D3, Product=3D2,
SerialNumber=3D1
[    0.962710] usb usb2: Product: xHCI Host Controller
[    0.962712] usb usb2: Manufacturer: Linux 3.18.0-vanillaice xhci-hcd
[    0.962713] usb usb2: SerialNumber: 0000:00:14.0
[    0.962848] hub 2-0:1.0: USB hub found
[    0.962859] hub 2-0:1.0: 4 ports detected
[    0.963994] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driv=
er
[    0.963999] ehci-pci: EHCI PCI platform driver
[    0.964006] ehci-platform: EHCI generic platform driver
[    0.964014] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.964016] ohci-pci: OHCI PCI platform driver
[    0.964023] ohci-platform: OHCI generic platform driver
[    0.964029] uhci_hcd: USB Universal Host Controller Interface driver
[    0.964067] i8042: PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:PS2M]
at 0x60,0x64 irq 1,12
[    0.972173] i8042: Detected active multiplexing controller, rev 1.1
[    0.976023] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.976026] serio: i8042 AUX0 port at 0x60,0x64 irq 12
[    0.976046] serio: i8042 AUX1 port at 0x60,0x64 irq 12
[    0.976060] serio: i8042 AUX2 port at 0x60,0x64 irq 12
[    0.976074] serio: i8042 AUX3 port at 0x60,0x64 irq 12
[    0.976197] mousedev: PS/2 mouse device common for all mice
[    0.976392] rtc_cmos 00:04: RTC can wake from S4
[    0.976515] rtc_cmos 00:04: rtc core: registered rtc_cmos as rtc0
[    0.976541] rtc_cmos 00:04: alarms up to one month, y3k, 242 bytes
nvram, hpet irqs
[    0.976598] device-mapper: uevent: version 1.0.3
[    0.976656] device-mapper: ioctl: 4.28.0-ioctl (2014-09-17)
initialised: dm-devel@redhat.com
[    0.976669] Intel P-state driver initializing.
[    0.976764] ledtrig-cpu: registered to indicate activity on CPUs
[    0.976838] TCP: cubic registered
[    0.976912] NET: Registered protocol family 10
[    0.977143] NET: Registered protocol family 17
[    0.977153] Key type dns_resolver registered
[    0.977443] Loading compiled-in X.509 certificates
[    0.978062] Loaded X.509 cert 'Magrathea: Glacier signing key:
564714df206debb3d65da7d25b1d5ce23f027ed0'
[    0.978071] registered taskstats version 1
[    0.979372] Key type trusted registered
[    0.980489] Key type encrypted registered
[    0.981598] AppArmor: AppArmor sha1 policy hashing enabled
[    0.981601] ima: No TPM chip found, activating TPM-bypass!
[    0.981617] evm: HMAC attrs: 0x1
[    0.981908]   Magic number: 10:369:300
[    0.982004] rtc_cmos 00:04: setting system clock to 2014-12-17
22:15:39 UTC (1418854539)
[    0.982055] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[    0.982056] EDD information not available.
[    0.982111] PM: Hibernation image not present or could not be loaded=
=2E
[    0.999276] input: AT Translated Set 2 keyboard as
/devices/platform/i8042/serio0/input/input3
[    1.047399] ACPI: Battery Slot [CMB1] (battery present)
[    1.048127] Freeing unused kernel memory: 1384K (ffffffff81d32000 -
ffffffff81e8c000)
[    1.048129] Write protecting the kernel read-only data: 12288k
[    1.048882] Freeing unused kernel memory: 356K (ffff8800017a7000 -
ffff880001800000)
[    1.049468] Freeing unused kernel memory: 384K (ffff880001ba0000 -
ffff880001c00000)
[    1.057395] systemd-udevd[117]: starting version 208
[    1.057717] random: systemd-udevd urandom read with 10 bits of
entropy available
[    1.076545] rtsx_pci 0000:04:00.0: irq 25 for MSI/MSI-X
[    1.076580] rtsx_pci 0000:04:00.0: rtsx_pci_acquire_irq:
pcr->msi_en =3D 1, pci->irq =3D 25
[    1.077254] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[    1.077259] r8169 0000:02:00.0: can't disable ASPM; OS doesn't have
ASPM control
[    1.078218] ahci 0000:00:1f.2: version 3.0
[    1.078316] ahci 0000:00:1f.2: irq 26 for MSI/MSI-X
[    1.078334] ahci 0000:00:1f.2: SSS flag set, parallel bus scan disab=
led
[    1.078357] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 4 ports 6
Gbps 0x15 impl SATA mode
[    1.078360] ahci 0000:00:1f.2: flags: 64bit ncq ilck stag pm led
clo pio slum part ems sxs apst
[    1.083286] r8169 0000:02:00.0: irq 27 for MSI/MSI-X
[    1.083737] r8169 0000:02:00.0 eth0: RTL8168g/8111g at
0xffffc900018d4000, e4:7f:b2:11:4a:02, XID 0c000800 IRQ 27
[    1.083740] r8169 0000:02:00.0 eth0: jumbo features [frames: 9200
bytes, tx checksumming: ko]
[    1.094803] scsi host0: ahci
[    1.095059] scsi host1: ahci
[    1.095144] scsi host2: ahci
[    1.095232] scsi host3: ahci
[    1.095309] scsi host4: ahci
[    1.095360] ata1: SATA max UDMA/133 abar m2048@0xf081c000 port
0xf081c100 irq 26
[    1.095362] ata2: DUMMY
[    1.095364] ata3: SATA max UDMA/133 abar m2048@0xf081c000 port
0xf081c200 irq 26
[    1.095365] ata4: DUMMY
[    1.095367] ata5: SATA max UDMA/133 abar m2048@0xf081c000 port
0xf081c300 irq 26
[    1.270930] usb 1-8: new full-speed USB device number 2 using xhci_h=
cd
[    1.400232] usb 1-8: New USB device found, idVendor=3D8087, idProduc=
t=3D07dc
[    1.400235] usb 1-8: New USB device strings: Mfr=3D0, Product=3D0, S=
erialNumber=3D0
[    1.415019] ata1: SATA link down (SStatus 0 SControl 300)
[    1.567113] usb 1-9: new low-speed USB device number 3 using xhci_hc=
d
[    1.643132] tsc: Refined TSC clocksource calibration: 2593.993 MHz
[    1.698327] usb 1-9: New USB device found, idVendor=3D0461, idProduc=
t=3D4d22
[    1.698330] usb 1-9: New USB device strings: Mfr=3D0, Product=3D2, S=
erialNumber=3D0
[    1.698332] usb 1-9: Product: USB Optical Mouse
[    1.698474] usb 1-9: ep 0x81 - rounding interval to 64 microframes,
ep desc says 80 microframes
[    1.701002] hidraw: raw HID events driver (C) Jiri Kosina
[    1.703651] usbcore: registered new interface driver usbhid
[    1.703653] usbhid: USB HID core driver
[    1.704791] input: USB Optical Mouse as
/devices/pci0000:00/0000:00:14.0/usb1/1-9/1-9:1.0/0003:0461:4D22.0001/i=
nput/input10
[    1.704880] hid-generic 0003:0461:4D22.0001: input,hidraw0: USB HID
v1.11 Mouse [USB Optical Mouse] on usb-0000:00:14.0-9/input0
[    1.739227] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    1.744479] ata3.00: ACPI cmd 00/00:00:00:00:00:a0 (NOP) rejected
by device (Stat=3D0x51 Err=3D0x04)
[    1.745219] ata3.00: ATAPI: TSSTcorp CDDVDW SU-208CB, FU01, max UDMA=
/100
[    1.753743] ata3.00: ACPI cmd 00/00:00:00:00:00:a0 (NOP) rejected
by device (Stat=3D0x51 Err=3D0x04)
[    1.753750] ata3.00: configured for UDMA/100
[    1.759123] scsi 2:0:0:0: CD-ROM            TSSTcorp CDDVDW
SU-208CB  FU01 PQ: 0 ANSI: 5
[    1.779142] sr 2:0:0:0: [sr0] scsi3-mmc drive: 24x/24x writer
dvd-ram cd/rw xa/form2 cdda tray
[    1.779146] cdrom: Uniform CD-ROM driver Revision: 3.20
[    1.779321] sr 2:0:0:0: Attached scsi CD-ROM sr0
[    1.779402] sr 2:0:0:0: Attached scsi generic sg0 type 5
[    1.863253] usb 1-11: new high-speed USB device number 4 using xhci_=
hcd
[    2.050443] usb 1-11: config 1 has an invalid interface number: 12
but max is 4
[    2.050447] usb 1-11: config 1 has an invalid interface number: 13
but max is 4
[    2.050448] usb 1-11: config 1 has an invalid interface number: 13
but max is 4
[    2.050449] usb 1-11: config 1 has no interface number 1
[    2.050450] usb 1-11: config 1 has no interface number 4
[    2.051548] usb 1-11: New USB device found, idVendor=3D1199, idProdu=
ct=3D9041
[    2.051551] usb 1-11: New USB device strings: Mfr=3D1, Product=3D2,
SerialNumber=3D3
[    2.051553] usb 1-11: Product: EM8805
[    2.051554] usb 1-11: Manufacturer: Sierra Wireless, Incorporated
[    2.099439] ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    2.101366] ata5.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE
LOCK) filtered out
[    2.101370] ata5.00: ACPI cmd b1/c1:00:00:00:00:a0 (DEVICE
CONFIGURATION OVERLAY) filtered out
[    2.101517] ata5.00: failed to get NCQ Send/Recv Log Emask 0x1
[    2.101519] ata5.00: ATA-9: SAMSUNG MZ7TE256HMHP-00004, EXT0200Q,
max UDMA/133
[    2.101520] ata5.00: 500118192 sectors, multi 16: LBA48 NCQ (depth 3=
1/32), AA
[    2.101832] ata5.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE
LOCK) filtered out
[    2.101835] ata5.00: ACPI cmd b1/c1:00:00:00:00:a0 (DEVICE
CONFIGURATION OVERLAY) filtered out
[    2.101969] ata5.00: failed to get NCQ Send/Recv Log Emask 0x1
[    2.102039] ata5.00: configured for UDMA/133
[    2.102180] scsi 4:0:0:0: Direct-Access     ATA      SAMSUNG
MZ7TE256 200Q PQ: 0 ANSI: 5
[    2.102393] sd 4:0:0:0: [sda] 500118192 512-byte logical blocks:
(256 GB/238 GiB)
[    2.102406] sd 4:0:0:0: Attached scsi generic sg1 type 0
[    2.102521] sd 4:0:0:0: [sda] Write Protect is off
[    2.102523] sd 4:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.102558] sd 4:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    2.103259]  sda: sda1 sda2 < sda5 sda6 sda7 sda8 > sda3
[    2.103736] sd 4:0:0:0: [sda] Attached SCSI disk
[    2.211876] EXT4-fs (sda8): mounted filesystem with ordered data
mode. Opts: (null)
[    2.219474] usb 1-12: new high-speed USB device number 5 using xhci_=
hcd
[    2.489092] usb 1-12: New USB device found, idVendor=3D04f2, idProdu=
ct=3Db413
[    2.489095] usb 1-12: New USB device strings: Mfr=3D2, Product=3D1,
SerialNumber=3D0
[    2.489097] usb 1-12: Product: FJ Camera
[    2.489098] usb 1-12: Manufacturer: Chicony Electronics Co., Ltd.
[    2.606437] psmouse serio2: elantech: assuming hardware version 4
(with firmware version 0x570f01)
[    2.641459] psmouse serio2: elantech: Synaptics capabilities query
result 0xc0, 0x14, 0x0c.
[    2.643828] Switched to clocksource tsc
[    2.810696] input: Elantech PS/2 TrackPoint as
/devices/platform/i8042/serio2/input/input11
[    2.851456] input: ETPS/2 Elantech Touchpad as
/devices/platform/i8042/serio2/input/input9
[    4.092627] floppy0: no floppy controllers found
[    4.175457] init: plymouth-upstart-bridge main process (190)
terminated with status 1
[    4.175463] init: plymouth-upstart-bridge main process ended, respaw=
ning
[    4.176404] init: plymouth-upstart-bridge main process (212)
terminated with status 1
[    4.176410] init: plymouth-upstart-bridge main process ended, respaw=
ning
[    4.225662] Adding 9357308k swap on /dev/sda7.  Priority:-1
extents:1 across:9357308k SSFS
[    4.270829] EXT4-fs (sda8): re-mounted. Opts: errors=3Dremount-ro
[    4.310924] systemd-udevd[363]: starting version 208
[    4.348961] lp: driver loaded but no devices found
[    4.357359] ppdev: user-space parallel port driver
[    4.399108] EDAC MC: Ver: 3.0.0
[    4.400840] input: Fujitsu FUJ02B1 as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:0a/FUJ02B1:00/input/=
input14
[    4.400883] fujitsu_laptop: ACPI: Fujitsu FUJ02B1 [FJEX] (on)
[    4.407596] EDAC ie31200: No ECC support
[    4.408001] shpchp: Standard Hot Plug PCI Controller Driver version:=
 0.4
[    4.411193] input: Fujitsu FUJ02E3 as
/devices/LNXSYSTM:00/LNXSYBUS:00/FUJ02E3:00/input/input15
[    4.411237] fujitsu_laptop: ACPI: Fujitsu FUJ02E3 [FEXT] (on)
[    4.415607] fujitsu_laptop: BTNI: [0x1010001]
[    4.415704] fujitsu_laptop: driver 0.6.0 successfully loaded
[    4.417255] mei_me 0000:00:16.0: irq 28 for MSI/MSI-X
[    4.422236] [drm] Initialized drm 1.1.0 20060810
[    4.440020] random: nonblocking pool is initialized
[    4.461620] [drm] Memory usable by graphics device =3D 2048M
[    4.461625] checking generic (e0000000 7f0000) vs hw (e0000000 10000=
000)
[    4.461627] fb: switching to inteldrmfb from VESA VGA
[    4.461646] Console: switching to colour dummy device 80x25
[    4.461714] [drm] Replacing VGA console driver
[    4.464797] cfg80211: Calling CRDA to update world regulatory domain
[    4.471542] Bluetooth: Core ver 2.19
[    4.471578] NET: Registered protocol family 31
[    4.471580] Bluetooth: HCI device and connection manager initialized
[    4.471586] Bluetooth: HCI socket layer initialized
[    4.471589] Bluetooth: L2CAP socket layer initialized
[    4.471597] Bluetooth: SCO socket layer initialized
[    4.475968] usbcore: registered new interface driver btusb
[    4.487835] Intel(R) Wireless WiFi driver for Linux, in-tree:
[    4.487838] Copyright(c) 2003- 2014 Intel Corporation
[    4.487869] i915 0000:00:02.0: irq 29 for MSI/MSI-X
[    4.487895] [drm] Supports vblank timestamp caching Rev 2 (21.10.201=
3).
[    4.487896] [drm] Driver supports precise vblank timestamp query.
[    4.487920] vgaarb: device changed decodes:
PCI:0000:00:02.0,olddecodes=3Dio+mem,decodes=3Dio+mem:owns=3Dio+mem
[    4.488022] iwlwifi 0000:03:00.0: irq 30 for MSI/MSI-X
[    4.490340] Bluetooth: hci0: read Intel version: 370710018002030d41
[    4.490342] Bluetooth: hci0: Intel device is already patched. patch =
num: 41
[    4.495886] iwlwifi 0000:03:00.0: Direct firmware load for
iwlwifi-7260-10.ucode failed with error -2
[    4.495890] iwlwifi 0000:03:00.0: Falling back to user helper
[    4.516118] media: Linux media interface: v0.10
[    4.526520] Linux video capture interface: v2.00
[    4.535198] AVX2 version of gcm_enc/dec engaged.
[    4.535201] AES CTR mode by8 optimization enabled
[    4.630461] uvcvideo: Found UVC 1.00 device FJ Camera (04f2:b413)
[    4.633171] usbcore: registered new interface driver usbserial
[    4.633193] usbcore: registered new interface driver usbserial_gener=
ic
[    4.633213] usbserial: USB Serial support registered for generic
[    4.670022] input: FJ Camera as
/devices/pci0000:00/0000:00:14.0/usb1/1-12/1-12:1.0/input/input16
[    4.670118] usbcore: registered new interface driver uvcvideo
[    4.670119] USB Video Class driver (1.1.1)
[    4.688098] usbcore: registered new interface driver qcserial
[    4.688114] usbserial: USB Serial support registered for Qualcomm US=
B modem
[    4.688893] usbcore: registered new interface driver cdc_ncm
[    4.689065] qcserial 1-11:1.0: Qualcomm USB modem converter detected
[    4.689178] usb 1-11: Qualcomm USB modem converter now attached to t=
tyUSB0
[    4.694403] qcserial 1-11:1.2: Qualcomm USB modem converter detected
[    4.698896] usbcore: registered new interface driver cdc_wdm
[    4.699042] usb 1-11: Qualcomm USB modem converter now attached to t=
tyUSB1
[    4.700552] audit: type=3D1400 audit(1418854543.208:2):
apparmor=3D"STATUS" operation=3D"profile_load" name=3D"/sbin/dhclient"
pid=3D434 comm=3D"apparmor_parser"
[    4.700646] audit: type=3D1400 audit(1418854543.208:3):
apparmor=3D"STATUS" operation=3D"profile_load"
name=3D"/usr/lib/NetworkManager/nm-dhcp-client.action" pid=3D434
comm=3D"apparmor_parser"
[    4.700710] audit: type=3D1400 audit(1418854543.208:4):
apparmor=3D"STATUS" operation=3D"profile_load"
name=3D"/usr/lib/connman/scripts/dhclient-script" pid=3D434
comm=3D"apparmor_parser"
[    4.701536] qcserial 1-11:1.3: Qualcomm USB modem converter detected
[    4.703809] usb 1-11: Qualcomm USB modem converter now attached to t=
tyUSB2
[    4.742337] audit: type=3D1400 audit(1418854543.252:5):
apparmor=3D"STATUS" operation=3D"profile_replace" name=3D"/sbin/dhclien=
t"
pid=3D500 comm=3D"apparmor_parser"
[    4.742481] audit: type=3D1400 audit(1418854543.252:6):
apparmor=3D"STATUS" operation=3D"profile_replace"
name=3D"/usr/lib/NetworkManager/nm-dhcp-client.action" pid=3D500
comm=3D"apparmor_parser"
[    4.742590] audit: type=3D1400 audit(1418854543.252:7):
apparmor=3D"STATUS" operation=3D"profile_replace"
name=3D"/usr/lib/connman/scripts/dhclient-script" pid=3D500
comm=3D"apparmor_parser"
[    4.766322] cdc_mbim 1-11:1.12: cdc-wdm0: USB WDM device
[    4.766490] cdc_mbim 1-11:1.12 wwan0: register 'cdc_mbim' at
usb-0000:00:14.0-11, CDC MBIM, 62:59:06:ee:34:a6
[    4.766519] usbcore: registered new interface driver cdc_mbim
[    4.810113] iwlwifi 0000:03:00.0: loaded firmware version
25.222.9.0 op_mode iwlmvm
[    4.836431] intel_rapl: Found RAPL domain package
[    4.836435] intel_rapl: Found RAPL domain core
[    4.836436] intel_rapl: Found RAPL domain uncore
[    4.836438] intel_rapl: Found RAPL domain dram
[    4.851269] iwlwifi 0000:03:00.0: Detected Intel(R) Wireless N
7260, REV=3D0x144
[    4.851378] iwlwifi 0000:03:00.0: L1 Enabled - LTR Enabled
[    4.851727] iwlwifi 0000:03:00.0: L1 Enabled - LTR Enabled
[    5.069919] ieee80211 phy0: Selected rate control algorithm 'iwl-mvm=
-rs'
[    5.280647] fbcon: inteldrmfb (fb0) is primary device
[    5.281721] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  pos=
t: no)
[    5.281789] input: Video Bus as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input17
[    5.281881] [drm] Initialized i915 1.6.0 20140905 for 0000:00:02.0 o=
n minor 0
[    5.283234] snd_hda_intel 0000:00:03.0: irq 31 for MSI/MSI-X
[    5.283283] snd_hda_intel 0000:00:1b.0: irq 32 for MSI/MSI-X
[    5.298094] sound hdaudioC1D0: ALC282: SKU not ready 0x909701f0
[    5.298509] sound hdaudioC1D0: autoconfig: line_outs=3D1
(0x21/0x0/0x0/0x0/0x0) type:line
[    5.298510] sound hdaudioC1D0:    speaker_outs=3D1 (0x14/0x0/0x0/0x0=
/0x0)
[    5.298512] sound hdaudioC1D0:    hp_outs=3D1 (0x1b/0x0/0x0/0x0/0x0)
[    5.298513] sound hdaudioC1D0:    mono: mono_out=3D0x0
[    5.298513] sound hdaudioC1D0:    inputs:
[    5.298515] sound hdaudioC1D0:      Mic=3D0x18
[    5.298516] sound hdaudioC1D0:      Dock Mic=3D0x1a
[    5.298517] sound hdaudioC1D0:      Internal Mic=3D0x12
[    5.302241] cfg80211: World regulatory domain updated:
[    5.302243] cfg80211:  DFS Master region: unset
[    5.302243] cfg80211:   (start_freq - end_freq @ bandwidth),
(max_antenna_gain, max_eirp), (dfs_cac_time)
[    5.302244] cfg80211:   (2402000 KHz - 2472000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm), (N/A)
[    5.302245] cfg80211:   (2457000 KHz - 2482000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm), (N/A)
[    5.302246] cfg80211:   (2474000 KHz - 2494000 KHz @ 20000 KHz),
(300 mBi, 2000 mBm), (N/A)
[    5.302247] cfg80211:   (5170000 KHz - 5250000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm), (N/A)
[    5.302248] cfg80211:   (5735000 KHz - 5835000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm), (N/A)
[    5.306481] input: HDA Intel HDMI HDMI/DP,pcm=3D3 as
/devices/pci0000:00/0000:00:03.0/sound/card0/input18
[    5.306673] input: HDA Intel HDMI HDMI/DP,pcm=3D7 as
/devices/pci0000:00/0000:00:03.0/sound/card0/input19
[    5.306724] input: HDA Intel HDMI HDMI/DP,pcm=3D8 as
/devices/pci0000:00/0000:00:03.0/sound/card0/input20
[    5.307386] input: HDA Intel PCH Mic as
/devices/pci0000:00/0000:00:1b.0/sound/card1/input21
[    5.307647] input: HDA Intel PCH Dock Mic as
/devices/pci0000:00/0000:00:1b.0/sound/card1/input22
[    5.307700] input: HDA Intel PCH Headphone as
/devices/pci0000:00/0000:00:1b.0/sound/card1/input23
[    5.307751] input: HDA Intel PCH Dock Headphone as
/devices/pci0000:00/0000:00:1b.0/sound/card1/input24
[    6.526173] Console: switching to colour frame buffer device 240x67
[    6.655641] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
[    6.655642] i915 0000:00:02.0: registered panic notifier
[    6.681261] init: Error while reading from descriptor: Broken pipe
[    6.683866] init: failsafe main process (705) killed by TERM signal
[    6.725753] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    6.725756] Bluetooth: BNEP filters: protocol multicast
[    6.725764] Bluetooth: BNEP socket layer initialized
[    6.731297] Bluetooth: RFCOMM TTY layer initialized
[    6.731307] Bluetooth: RFCOMM socket layer initialized
[    6.731311] Bluetooth: RFCOMM ver 1.11
[    6.979305] init: avahi-cups-reload main process (838) terminated
with status 1
[    7.161342] systemd-logind[795]: New seat seat0.
[    7.161869] systemd-logind[795]: Watching system buttons on
/dev/input/event8 (Fujitsu FUJ02E3)
[    7.161926] systemd-logind[795]: Watching system buttons on
/dev/input/event10 (Video Bus)
[    7.161978] systemd-logind[795]: Watching system buttons on
/dev/input/event7 (Fujitsu FUJ02B1)
[    7.162025] systemd-logind[795]: Watching system buttons on
/dev/input/event1 (Power Button)
[    7.162069] systemd-logind[795]: Watching system buttons on
/dev/input/event0 (Lid Switch)
[    7.162113] systemd-logind[795]: Watching system buttons on
/dev/input/event2 (Sleep Button)
[    7.176946] audit: type=3D1400 audit(1418854545.684:8):
apparmor=3D"STATUS" operation=3D"profile_load"
name=3D"/usr/lib/lightdm/lightdm-guest-session" pid=3D830
comm=3D"apparmor_parser"
[    7.177035] audit: type=3D1400 audit(1418854545.684:9):
apparmor=3D"STATUS" operation=3D"profile_load" name=3D"chromium" pid=3D=
830
comm=3D"apparmor_parser"
[    7.178114] audit: type=3D1400 audit(1418854545.684:10):
apparmor=3D"STATUS" operation=3D"profile_replace" name=3D"/sbin/dhclien=
t"
pid=3D830 comm=3D"apparmor_parser"
[    7.178118] audit: type=3D1400 audit(1418854545.684:11):
apparmor=3D"STATUS" operation=3D"profile_replace"
name=3D"/usr/lib/NetworkManager/nm-dhcp-client.action" pid=3D830
comm=3D"apparmor_parser"
[    7.178120] audit: type=3D1400 audit(1418854545.684:12):
apparmor=3D"STATUS" operation=3D"profile_replace"
name=3D"/usr/lib/connman/scripts/dhclient-script" pid=3D830
comm=3D"apparmor_parser"
[    7.239460] audit: type=3D1400 audit(1418854545.748:13):
apparmor=3D"STATUS" operation=3D"profile_load"
name=3D"/usr/lib/cups/backend/cups-pdf" pid=3D804 comm=3D"apparmor_pars=
er"
[    7.239622] audit: type=3D1400 audit(1418854545.748:14):
apparmor=3D"STATUS" operation=3D"profile_load" name=3D"/usr/sbin/cupsd"
pid=3D804 comm=3D"apparmor_parser"
[    7.239670] audit: type=3D1400 audit(1418854545.748:15):
apparmor=3D"STATUS" operation=3D"profile_load" name=3D"third_party" pid=
=3D804
comm=3D"apparmor_parser"
[    7.240657] r8169 0000:02:00.0 eth0: link down
[    7.241003] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[    7.242366] iwlwifi 0000:03:00.0: L1 Enabled - LTR Enabled
[    7.242645] iwlwifi 0000:03:00.0: L1 Enabled - LTR Enabled
[    7.254316] IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
[    7.430671] floppy0: no floppy controllers found
[    7.802017] wlan0: authenticate with fa:9c:d6:a8:7f:e0
[    7.803871] wlan0: send auth to fa:9c:d6:a8:7f:e0 (try 1/3)
[    7.805702] wlan0: authenticated
[    7.805837] iwlwifi 0000:03:00.0 wlan0: disabling HT as WMM/QoS is
not supported by the AP
[    7.805840] iwlwifi 0000:03:00.0 wlan0: disabling VHT as WMM/QoS is
not supported by the AP
[    7.806917] wlan0: associate with fa:9c:d6:a8:7f:e0 (try 1/3)
[    7.809302] wlan0: RX AssocResp from fa:9c:d6:a8:7f:e0 (capab=3D0x41=
1
status=3D0 aid=3D2)
[    7.810731] wlan0: associated
[    7.810749] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
[    7.835959] audit: type=3D1400 audit(1418854546.344:16):
apparmor=3D"STATUS" operation=3D"profile_load"
name=3D"/usr/sbin/cups-browsed" pid=3D870 comm=3D"apparmor_parser"
[    9.650575] audit: type=3D1400 audit(1418854548.156:17):
apparmor=3D"STATUS" operation=3D"profile_load" name=3D"/usr/bin/evince"
pid=3D830 comm=3D"apparmor_parser"
[   10.737631] init: plymouth-upstart-bridge main process ended, respaw=
ning
[   10.746571] init: plymouth-upstart-bridge main process ended, respaw=
ning
[   10.801280] systemd-logind[795]: Failed to start unit
user@112.service: Unknown unit: user@112.service
[   10.801286] systemd-logind[795]: Failed to start user service:
Unknown unit: user@112.service
[   10.803827] systemd-logind[795]: New session c1 of user lightdm.
[   10.803840] systemd-logind[795]: Linked /tmp/.X11-unix/X0 to
/run/user/112/X11-display.
[   14.197088] systemd-logind[795]: Failed to start unit
user@1000.service: Unknown unit: user@1000.service
[   14.197093] systemd-logind[795]: Failed to start user service:
Unknown unit: user@1000.service
[   14.199812] systemd-logind[795]: New session c2 of user vincent.
[   14.199829] systemd-logind[795]: Linked /tmp/.X11-unix/X0 to
/run/user/1000/X11-display.

On Wed, Dec 17, 2014 at 11:09 PM,  <ulrik.debie-os@e2big.org> wrote:
> Hi,
>
> could you provide the dmesg lines after startup (or at least those th=
at contain
> the word "elantech") ?
>
> Can you describe your mouse buttons please ? Are some located above/u=
nder
> the touchpad ?
>
> Maybe next week I'll find some time to look into it, I'm currently on=
 ski
> holidays.
>
> Ulrik
> On Wed, Dec 17, 2014 at 10:09:22PM +0100, Vincent Jaubert wrote:
>> Date: Wed, 17 Dec 2014 22:09:22 +0100
>> From: Vincent Jaubert <contact@vjaubert.com>
>> To: linux-input@vger.kernel.org
>> Subject: Elantech touchpad on Fujitsu E554 not working at all
>> X-Mailing-List:       linux-input@vger.kernel.org
>>
>> My touchpad on my brand new Fujitsu E554 doesn't work at all.
>> Bios flashed with latest version.
>> The touchpad works correctly under windows 7.
>>
>> Here is the partial output from "xinput -list" :
>>
>> Virtual core pointer                     id=3D2 [master pointer  (3)=
]
>> =E2=8E=9C   =E2=86=B3 Virtual core XTEST pointer               id=3D=
4 [slave  pointer  (2)]
>> =E2=8E=9C   =E2=86=B3 USB Optical Mouse                       id=3D1=
2 [slave  pointer  (2)]
>> =E2=8E=9C   =E2=86=B3 Elantech PS/2 TrackPoint                 id=3D=
14 [slave  pointer  (2)]
>> =E2=8E=9C   =E2=86=B3 ETPS/2 Elantech Touchpad                 id=3D=
15 [slave  pointer  (2)]
>>
>> The trackpoint is working correctly since 3.18.0.
>> The touchpad doen't work at all.
>>
>> With "dmesg | grep mouse", i got lot of :
>>
>> [  377.818193] psmouse serio2: Touchpad at isa0060/serio2/input0 los=
t
>> sync at byte 6
>> [  377.818204] psmouse serio2: issuing reconnect request
>>
>> I'm on Ubuntu 14.10 x86-64, with 3.18.0 kernel compiled from kernel.=
org sources.
>>
>>
>>
>> Output of cat /proc/info :
>> Linux version 3.18.0-vanillaice (root@vincent-LIFEBOOK-E554) (gcc
>> version 4.9.1 (Ubuntu 4.9.1-16ubuntu6) ) #1 SMP Wed Dec 17 19:54:23
>> CET 2014
>>
>> Outuput of lsb_release -rd  :
>> Description: Ubuntu 14.10
>> Release: 14.10
>>
>> Outuput of ver_linux :
>>
>> Linux vincent-LIFEBOOK-E554 3.18.0-vanillaice #1 SMP Wed Dec 17
>> 19:54:23 CET 2014 x86_64 x86_64 x86_64 GNU/Linux
>>
>> Gnu C                  4.9.1
>> Gnu make               4.0
>> binutils               2.24.90.20141014
>> util-linux             2.25.1
>> mount                  debug
>> module-init-tools      18
>> e2fsprogs              1.42.10
>> pcmciautils            018
>> PPP                    2.4.5
>> Linux C Library        2.19
>> Dynamic linker (ldd)   2.19
>> Procps                 3.3.9
>> Net-tools              1.60
>> Kbd                    1.15.5
>> Sh-utils               8.23
>> wireless-tools         30
>> Modules Loaded         isofs hid_generic usbhid hid ctr ccm arc4
>> snd_hda_codec_hdmi iwlmvm mac80211 snd_hda_codec_realtek
>> snd_hda_codec_generic iwlwifi rtsx_pci_ms memstick cfg80211 intel_ra=
pl
>> x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm
>> crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel
>> aes_x86_64 lrw gf128mul glue_helper ablk_helper cryptd snd_hda_intel
>> snd_hda_controller snd_hda_codec snd_hwdep joydev snd_pcm serio_raw
>> snd_seq_midi snd_seq_midi_event uvcvideo videobuf2_vmalloc snd_rawmi=
di
>> videobuf2_memops videobuf2_core snd_seq cdc_mbim qcserial cdc_wdm
>> v4l2_common cdc_ncm usb_wwan usbnet usbserial videodev media
>> snd_seq_device snd_timer snd btusb mei_me mei soundcore lpc_ich shpc=
hp
>> i915 mac_hid drm_kms_helper ie31200_edac drm video i2c_algo_bit
>> edac_core intel_rst fujitsu_laptop rfcomm bnep bluetooth parport_pc
>> ppdev lp parport binfmt_misc rtsx_pci_sdmmc ahci libahci psmouse r81=
69
>> rtsx_pci mii
>>
>> Output of cat /proc/cpuinfo
>> processor : 0
>> vendor_id : GenuineIntel
>> cpu family : 6
>> model : 60
>> model name : Intel(R) Core(TM) i5-4210M CPU @ 2.60GHz
>> stepping : 3
>> microcode : 0x1c
>> cpu MHz : 800.007
>> cache size : 3072 KB
>> physical id : 0
>> siblings : 4
>> core id : 0
>> cpu cores : 2
>> apicid : 0
>> initial apicid : 0
>> fpu : yes
>> fpu_exception : yes
>> cpuid level : 13
>> wp : yes
>> flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmo=
v
>> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
>> pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
>> xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monit=
or
>> ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 movbe
>> popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm ida
>> arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsba=
se
>> tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt
>> bugs :
>> bogomips : 5188.49
>> clflush size : 64
>> cache_alignment : 64
>> address sizes : 39 bits physical, 48 bits virtual
>> power management:
>>
>> processor : 1
>> vendor_id : GenuineIntel
>> cpu family : 6
>> model : 60
>> model name : Intel(R) Core(TM) i5-4210M CPU @ 2.60GHz
>> stepping : 3
>> microcode : 0x1c
>> cpu MHz : 800.312
>> cache size : 3072 KB
>> physical id : 0
>> siblings : 4
>> core id : 0
>> cpu cores : 2
>> apicid : 1
>> initial apicid : 1
>> fpu : yes
>> fpu_exception : yes
>> cpuid level : 13
>> wp : yes
>> flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmo=
v
>> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
>> pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
>> xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monit=
or
>> ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 movbe
>> popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm ida
>> arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsba=
se
>> tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt
>> bugs :
>> bogomips : 5188.49
>> clflush size : 64
>> cache_alignment : 64
>> address sizes : 39 bits physical, 48 bits virtual
>> power management:
>>
>> processor : 2
>> vendor_id : GenuineIntel
>> cpu family : 6
>> model : 60
>> model name : Intel(R) Core(TM) i5-4210M CPU @ 2.60GHz
>> stepping : 3
>> microcode : 0x1c
>> cpu MHz : 800.007
>> cache size : 3072 KB
>> physical id : 0
>> siblings : 4
>> core id : 1
>> cpu cores : 2
>> apicid : 2
>> initial apicid : 2
>> fpu : yes
>> fpu_exception : yes
>> cpuid level : 13
>> wp : yes
>> flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmo=
v
>> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
>> pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
>> xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monit=
or
>> ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 movbe
>> popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm ida
>> arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsba=
se
>> tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt
>> bugs :
>> bogomips : 5188.49
>> clflush size : 64
>> cache_alignment : 64
>> address sizes : 39 bits physical, 48 bits virtual
>> power management:
>>
>> processor : 3
>> vendor_id : GenuineIntel
>> cpu family : 6
>> model : 60
>> model name : Intel(R) Core(TM) i5-4210M CPU @ 2.60GHz
>> stepping : 3
>> microcode : 0x1c
>> cpu MHz : 800.109
>> cache size : 3072 KB
>> physical id : 0
>> siblings : 4
>> core id : 1
>> cpu cores : 2
>> apicid : 3
>> initial apicid : 3
>> fpu : yes
>> fpu_exception : yes
>> cpuid level : 13
>> wp : yes
>> flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmo=
v
>> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
>> pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
>> xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monit=
or
>> ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 movbe
>> popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm ida
>> arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsba=
se
>> tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt
>> bugs :
>> bogomips : 5188.49
>> clflush size : 64
>> cache_alignment : 64
>> address sizes : 39 bits physical, 48 bits virtual
>> power management:
>>
>> output of cat /proc/modules
>> isofs 39720 1 - Live 0x0000000000000000
>> hid_generic 12559 0 - Live 0x0000000000000000
>> usbhid 52565 0 - Live 0x0000000000000000
>> hid 110066 2 hid_generic,usbhid, Live 0x0000000000000000
>> ctr 13049 1 - Live 0x0000000000000000
>> ccm 17731 1 - Live 0x0000000000000000
>> arc4 12608 2 - Live 0x0000000000000000
>> snd_hda_codec_hdmi 51974 1 - Live 0x0000000000000000
>> iwlmvm 251094 0 - Live 0x0000000000000000
>> mac80211 674115 1 iwlmvm, Live 0x0000000000000000
>> snd_hda_codec_realtek 79613 1 - Live 0x0000000000000000
>> snd_hda_codec_generic 68875 1 snd_hda_codec_realtek, Live 0x00000000=
00000000
>> iwlwifi 186039 1 iwlmvm, Live 0x0000000000000000
>> rtsx_pci_ms 18168 0 - Live 0x0000000000000000
>> memstick 16966 1 rtsx_pci_ms, Live 0x0000000000000000
>> cfg80211 513009 3 iwlmvm,mac80211,iwlwifi, Live 0x0000000000000000
>> intel_rapl 18783 0 - Live 0x0000000000000000
>> x86_pkg_temp_thermal 14205 0 - Live 0x0000000000000000
>> intel_powerclamp 18786 0 - Live 0x0000000000000000
>> coretemp 13441 0 - Live 0x0000000000000000
>> kvm_intel 148273 0 - Live 0x0000000000000000
>> kvm 466035 1 kvm_intel, Live 0x0000000000000000
>> crct10dif_pclmul 14307 0 - Live 0x0000000000000000
>> crc32_pclmul 13133 0 - Live 0x0000000000000000
>> ghash_clmulni_intel 13230 0 - Live 0x0000000000000000
>> aesni_intel 169590 2 - Live 0x0000000000000000
>> aes_x86_64 17131 1 aesni_intel, Live 0x0000000000000000
>> lrw 13287 1 aesni_intel, Live 0x0000000000000000
>> gf128mul 14951 1 lrw, Live 0x0000000000000000
>> glue_helper 13944 1 aesni_intel, Live 0x0000000000000000
>> ablk_helper 13597 1 aesni_intel, Live 0x0000000000000000
>> cryptd 20360 3 ghash_clmulni_intel,aesni_intel,ablk_helper, Live
>> 0x0000000000000000
>> snd_hda_intel 30520 6 - Live 0x0000000000000000
>> snd_hda_controller 31872 1 snd_hda_intel, Live 0x0000000000000000
>> snd_hda_codec 139421 5
>> snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_h=
da_intel,snd_hda_controller,
>> Live 0x0000000000000000
>> snd_hwdep 17698 1 snd_hda_codec, Live 0x0000000000000000
>> joydev 17344 0 - Live 0x0000000000000000
>> snd_pcm 105335 5
>> snd_hda_codec_hdmi,snd_hda_intel,snd_hda_controller,snd_hda_codec,
>> Live 0x0000000000000000
>> serio_raw 13434 0 - Live 0x0000000000000000
>> snd_seq_midi 13564 0 - Live 0x0000000000000000
>> snd_seq_midi_event 14899 1 snd_seq_midi, Live 0x0000000000000000
>> uvcvideo 81109 0 - Live 0x0000000000000000
>> videobuf2_vmalloc 13216 1 uvcvideo, Live 0x0000000000000000
>> snd_rawmidi 30876 1 snd_seq_midi, Live 0x0000000000000000
>> videobuf2_memops 13362 1 videobuf2_vmalloc, Live 0x0000000000000000
>> videobuf2_core 47079 1 uvcvideo, Live 0x0000000000000000
>> snd_seq 67178 2 snd_seq_midi,snd_seq_midi_event, Live 0x000000000000=
0000
>> cdc_mbim 13400 0 - Live 0x0000000000000000
>> qcserial 17286 0 - Live 0x0000000000000000
>> cdc_wdm 23109 1 cdc_mbim, Live 0x0000000000000000
>> v4l2_common 15682 1 videobuf2_core, Live 0x0000000000000000
>> cdc_ncm 30903 1 cdc_mbim, Live 0x0000000000000000
>> usb_wwan 19865 1 qcserial, Live 0x0000000000000000
>> usbnet 43806 2 cdc_mbim,cdc_ncm, Live 0x0000000000000000
>> usbserial 45100 2 qcserial,usb_wwan, Live 0x0000000000000000
>> videodev 158682 3 uvcvideo,videobuf2_core,v4l2_common, Live 0x000000=
0000000000
>> media 21963 2 uvcvideo,videodev, Live 0x0000000000000000
>> snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x0000=
000000000000
>> snd_timer 29458 2 snd_pcm,snd_seq, Live 0x0000000000000000
>> snd 87611 22 snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_=
generic,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_s=
eq,snd_seq_device,snd_timer,
>> Live 0x0000000000000000
>> btusb 32336 0 - Live 0x0000000000000000
>> mei_me 19568 0 - Live 0x0000000000000000
>> mei 87928 1 mei_me, Live 0x0000000000000000
>> soundcore 15052 2 snd_hda_codec,snd, Live 0x0000000000000000
>> lpc_ich 21093 0 - Live 0x0000000000000000
>> shpchp 37040 0 - Live 0x0000000000000000
>> i915 997306 6 - Live 0x0000000000000000
>> mac_hid 13227 0 - Live 0x0000000000000000
>> drm_kms_helper 98384 1 i915, Live 0x0000000000000000
>> ie31200_edac 12728 0 - Live 0x0000000000000000
>> drm 317398 5 i915,drm_kms_helper, Live 0x0000000000000000
>> video 20205 1 i915, Live 0x0000000000000000
>> i2c_algo_bit 13406 1 i915, Live 0x0000000000000000
>> edac_core 51809 1 ie31200_edac, Live 0x0000000000000000
>> intel_rst 12900 0 - Live 0x0000000000000000
>> fujitsu_laptop 18743 0 - Live 0x0000000000000000
>> rfcomm 69427 8 - Live 0x0000000000000000
>> bnep 19543 2 - Live 0x0000000000000000
>> bluetooth 461507 22 btusb,rfcomm,bnep, Live 0x0000000000000000
>> parport_pc 32741 0 - Live 0x0000000000000000
>> ppdev 17635 0 - Live 0x0000000000000000
>> lp 17759 0 - Live 0x0000000000000000
>> parport 42264 3 parport_pc,ppdev,lp, Live 0x0000000000000000
>> binfmt_misc 17424 1 - Live 0x0000000000000000
>> rtsx_pci_sdmmc 23190 0 - Live 0x0000000000000000
>> ahci 34019 3 - Live 0x0000000000000000
>> libahci 32190 1 ahci, Live 0x0000000000000000
>> psmouse 111475 0 - Live 0x0000000000000000
>> r8169 84648 0 - Live 0x0000000000000000
>> rtsx_pci 46889 2 rtsx_pci_ms,rtsx_pci_sdmmc, Live 0x0000000000000000
>> mii 13934 2 usbnet,r8169, Live 0x0000000000000000
>>
>> cat /proc/ioports
>> 0000-0cf7 : PCI Bus 0000:00
>>   0000-001f : dma1
>>   0020-0021 : pic1
>>   0040-0043 : timer0
>>   0050-0053 : timer1
>>   0060-0060 : keyboard
>>   0061-0061 : PNP0800:00
>>   0062-0062 : PNP0C09:00
>>     0062-0062 : EC data
>>   0064-0064 : keyboard
>>   0066-0066 : PNP0C09:00
>>     0066-0066 : EC cmd
>>   0070-0077 : rtc0
>>   0080-008f : dma page reg
>>   00a0-00a1 : pic2
>>   00c0-00df : dma2
>>   00f0-00ff : fpu
>>     00f0-00f0 : PNP0C04:00
>>   03c0-03df : vesafb
>>   0410-0415 : ACPI CPU throttle
>>   04d0-04d1 : pnp 00:01
>>   0600-0603 : pnp 00:01
>>   0604-0607 : pnp 00:01
>>   0800-087f : pnp 00:01
>> 0cf8-0cff : PCI conf1
>> 0d00-ffff : PCI Bus 0000:00
>>   1640-164f : pnp 00:01
>>   1800-187f : pnp 00:01
>>     1800-1803 : ACPI PM1a_EVT_BLK
>>     1804-1805 : ACPI PM1a_CNT_BLK
>>     1808-180b : ACPI PM_TMR
>>     1820-182f : ACPI GPE0_BLK
>>     1830-1833 : iTCO_wdt
>>     1850-1850 : ACPI PM2_CNT_BLK
>>     1860-187f : iTCO_wdt
>>   1880-18ff : pnp 00:01
>>   2000-2003 : pnp 00:01
>>   2100-217f : pnp 00:01
>>   2180-21ff : pnp 00:01
>>   3000-3fff : PCI Bus 0000:02
>>     3000-30ff : 0000:02:00.0
>>       3000-30ff : r8169
>>   4000-403f : 0000:00:02.0
>>   4060-407f : 0000:00:1f.2
>>     4060-407f : ahci
>>   4080-4087 : 0000:00:1f.2
>>     4080-4087 : ahci
>>   4088-408f : 0000:00:1f.2
>>     4088-408f : ahci
>>   4090-4093 : 0000:00:1f.2
>>     4090-4093 : ahci
>>   4094-4097 : 0000:00:1f.2
>>     4094-4097 : ahci
>>   efa0-efbf : 0000:00:1f.3
>>   f800-f87f : pnp 00:01
>>   f880-f8ff : pnp 00:01
>>   fc00-fc7f : pnp 00:01
>>   fc80-fcff : pnp 00:01
>>   fd00-fd7f : pnp 00:01
>>
>>
>> cat /proc/iomem
>> 00000000-00000fff : reserved
>> 00001000-0009cfff : System RAM
>> 0009d000-0009ffff : reserved
>> 000a0000-000bffff : PCI Bus 0000:00
>> 000c0000-000cebff : Video ROM
>> 000e0000-000fffff : reserved
>>   000f0000-000fffff : System ROM
>> 00100000-c431bfff : System RAM
>>   01000000-017a4a44 : Kernel code
>>   017a4a45-01d302ff : Kernel data
>>   01e95000-01fdffff : Kernel bss
>> c431c000-c451dfff : reserved
>> c451e000-da64efff : System RAM
>> da64f000-dce3efff : reserved
>> dce3f000-dcf9efff : ACPI Non-volatile Storage
>> dcf9f000-dcffefff : ACPI Tables
>> dcfff000-dcffffff : System RAM
>> dd000000-df9fffff : reserved
>>   dda00000-df9fffff : Graphics Stolen Memory
>> dfa00000-feafffff : PCI Bus 0000:00
>>   dfa10000-dfa1ffff : pnp 00:00
>>   e0000000-efffffff : 0000:00:02.0
>>   f0000000-f03fffff : 0000:00:02.0
>>   f0400000-f04fffff : PCI Bus 0000:02
>>     f0400000-f0403fff : 0000:02:00.0
>>       f0400000-f0403fff : r8169
>>   f0500000-f05fffff : PCI Bus 0000:04
>>     f0500000-f0500fff : 0000:04:00.0
>>       f0500000-f0500fff : rtsx_pci
>>   f0600000-f06fffff : PCI Bus 0000:03
>>     f0600000-f0601fff : 0000:03:00.0
>>       f0600000-f0601fff : iwlwifi
>>   f0700000-f07fffff : PCI Bus 0000:02
>>     f0700000-f0700fff : 0000:02:00.0
>>       f0700000-f0700fff : r8169
>>   f0800000-f080ffff : 0000:00:14.0
>>     f0800000-f080ffff : xhci-hcd
>>   f0810000-f0813fff : 0000:00:03.0
>>     f0810000-f0813fff : ICH HD audio
>>   f0814000-f0817fff : 0000:00:1b.0
>>     f0814000-f0817fff : ICH HD audio
>>   f0818000-f08180ff : 0000:00:1f.3
>>   f0819000-f081900f : 0000:00:16.0
>>     f0819000-f081900f : mei_me
>>   f081c000-f081c7ff : 0000:00:1f.2
>>     f081c000-f081c7ff : ahci
>>   f8000000-fbffffff : PCI MMCONFIG 0000 [bus 00-3f]
>>     f8000000-fbffffff : reserved
>>       f8000000-fbffffff : pnp 00:00
>> fec00000-fec00fff : reserved
>>   fec00000-fec003ff : IOAPIC 0
>> fed00000-fed003ff : HPET 0
>>   fed00000-fed003ff : pnp 00:05
>> fed08000-fed08fff : reserved
>>   fed08000-fed08fff : pnp 00:00
>> fed10000-fed19fff : reserved
>>   fed10000-fed17fff : pnp 00:00
>>   fed18000-fed18fff : pnp 00:00
>>   fed19000-fed19fff : pnp 00:00
>> fed1c000-fed1ffff : reserved
>>   fed1c000-fed1ffff : pnp 00:00
>>     fed1f410-fed1f414 : iTCO_wdt
>> fed20000-fed3ffff : pnp 00:00
>> fed40000-fed44fff : pnp 00:00
>> fed45000-fed8ffff : pnp 00:00
>> fed90000-fed93fff : pnp 00:00
>> fee00000-fee00fff : Local APIC
>>   fee00000-fee00fff : reserved
>> fef00000-feffffff : pnp 00:00
>> ffa20000-ffffffff : reserved
>> 100000000-41f5fffff : System RAM
>> 41f600000-41fffffff : RAM buffer
>>
>> lspci -vvv
>>
>> 00:00.0 Host bridge: Intel Corporation Xeon E3-1200 v3/4th Gen Core
>> Processor DRAM Controller (rev 06)
>> Subsystem: Fujitsu Limited. Device 17a6
>> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>> Stepping- SERR- FastB2B- DisINTx-
>> Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-
>> <TAbort- <MAbort+ >SERR- <PERR- INTx-
>> Latency: 0
>> Capabilities: [e0] Vendor Specific Information: Len=3D0c <?>
>>
>> 00:02.0 VGA compatible controller: Intel Corporation 4th Gen Core
>> Processor Integrated Graphics Controller (rev 06) (prog-if 00 [VGA
>> controller])
>> Subsystem: Fujitsu Limited. Device 17af
>> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>> Stepping- SERR- FastB2B- DisINTx+
>> Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>> Latency: 0
>> Interrupt: pin A routed to IRQ 28
>> Region 0: Memory at f0000000 (64-bit, non-prefetchable) [size=3D4M]
>> Region 2: Memory at e0000000 (64-bit, prefetchable) [size=3D256M]
>> Region 4: I/O ports at 4000 [size=3D64]
>> Expansion ROM at <unassigned> [disabled]
>> Capabilities: [90] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
>> Address: fee0f00c  Data: 41b1
>> Capabilities: [d0] Power Management version 2
>> Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,=
D3cold-)
>> Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
>> Capabilities: [a4] PCI Advanced Features
>> AFCap: TP+ FLR+
>> AFCtrl: FLR-
>> AFStatus: TP-
>> Kernel driver in use: i915
>>
>> 00:03.0 Audio device: Intel Corporation Xeon E3-1200 v3/4th Gen Core
>> Processor HD Audio Controller (rev 06)
>> Subsystem: Fujitsu Limited. Device 17c6
>> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>> Stepping- SERR- FastB2B- DisINTx+
>> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>> Latency: 0, Cache Line Size: 64 bytes
>> Interrupt: pin A routed to IRQ 30
>> Region 0: Memory at f0810000 (64-bit, non-prefetchable) [size=3D16K]
>> Capabilities: [50] Power Management version 2
>> Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,=
D3cold-)
>> Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
>> Capabilities: [60] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
>> Address: fee0f00c  Data: 41d1
>> Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MS=
I 00
>> DevCap: MaxPayload 128 bytes, PhantFunc 0
>> ExtTag- RBE-
>> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>> RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>> MaxPayload 128 bytes, MaxReadReq 128 bytes
>> DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
>> Kernel driver in use: snd_hda_intel
>>
>> 00:14.0 USB controller: Intel Corporation 8 Series/C220 Series Chips=
et
>> Family USB xHCI (rev 04) (prog-if 30 [XHCI])
>> Subsystem: Fujitsu Limited. Device 17e1
>> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>> Stepping- SERR- FastB2B- DisINTx+
>> Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>> Latency: 0
>> Interrupt: pin A routed to IRQ 24
>> Region 0: Memory at f0800000 (64-bit, non-prefetchable) [size=3D64K]
>> Capabilities: [70] Power Management version 2
>> Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA PME(D0-,D1-,D2-,D3hot=
+,D3cold+)
>> Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
>> Capabilities: [80] MSI: Enable+ Count=3D1/8 Maskable- 64bit+
>> Address: 00000000fee0300c  Data: 4171
>> Kernel driver in use: xhci_hcd
>>
>> 00:16.0 Communication controller: Intel Corporation 8 Series/C220
>> Series Chipset Family MEI Controller #1 (rev 04)
>> Subsystem: Fujitsu Limited. Device 17dd
>> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>> Stepping- SERR- FastB2B- DisINTx+
>> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>> Latency: 0
>> Interrupt: pin A routed to IRQ 29
>> Region 0: Memory at f0819000 (64-bit, non-prefetchable) [size=3D16]
>> Capabilities: [50] Power Management version 3
>> Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,=
D3cold+)
>> Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
>> Capabilities: [8c] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
>> Address: 00000000fee0f00c  Data: 41c1
>> Kernel driver in use: mei_me
>>
>> 00:1b.0 Audio device: Intel Corporation 8 Series/C220 Series Chipset
>> High Definition Audio Controller (rev 04)
>> Subsystem: Fujitsu Limited. Device 17ff
>> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>> Stepping- SERR- FastB2B- DisINTx+
>> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>> Latency: 0, Cache Line Size: 64 bytes
>> Interrupt: pin A routed to IRQ 31
>> Region 0: Memory at f0814000 (64-bit, non-prefetchable) [size=3D16K]
>> Capabilities: [50] Power Management version 2
>> Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D55mA PME(D0+,D1-,D2-,D3hot+=
,D3cold+)
>> Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
>> Capabilities: [60] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
>> Address: 00000000fee0f00c  Data: 4122
>> Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MS=
I 00
>> DevCap: MaxPayload 128 bytes, PhantFunc 0
>> ExtTag- RBE-
>> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>> RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>> MaxPayload 128 bytes, MaxReadReq 128 bytes
>> DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
>> Capabilities: [100 v1] Virtual Channel
>> Caps: LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
>> Arb: Fixed- WRR32- WRR64- WRR128-
>> Ctrl: ArbSelect=3DFixed
>> Status: InProgress-
>> VC0: Caps: PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
>> Arb: Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
>> Ctrl: Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3D01
>> Status: NegoPending- InProgress-
>> VC1: Caps: PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
>> Arb: Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
>> Ctrl: Enable+ ID=3D2 ArbSelect=3DFixed TC/VC=3D04
>> Status: NegoPending- InProgress-
>> Kernel driver in use: snd_hda_intel
>>
>> 00:1c.0 PCI bridge: Intel Corporation 8 Series/C220 Series Chipset
>> Family PCI Express Root Port #1 (rev d4) (prog-if 00 [Normal decode]=
)
>> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>> Stepping- SERR- FastB2B- DisINTx-
>> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>> Latency: 0, Cache Line Size: 64 bytes
>> Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
>> I/O behind bridge: 0000f000-00000fff
>> Memory behind bridge: fff00000-000fffff
>> Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
>> Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
>> <TAbort- <MAbort+ <SERR- <PERR-
>> BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>> Capabilities: [40] Express (v2) Root Port (Slot-), MSI 00
>> DevCap: MaxPayload 128 bytes, PhantFunc 0
>> ExtTag- RBE+
>> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>> RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>> MaxPayload 128 bytes, MaxReadReq 128 bytes
>> DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
>> LnkCap: Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0=
s
>> <1us, L1 <4us
>> ClockPM- Surprise- LLActRep+ BwNot+
>> LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk-
>> ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>> LnkSta: Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive-
>> BWMgmt- ABWMgmt-
>> RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisib=
le-
>> RootCap: CRSVisible-
>> RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>> DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Via
>> WAKE# ARIFwd-
>> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF
>> Disabled ARIFwd-
>> LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
>> Transmit Margin: Normal Operating Range, EnterModifiedCompliance- Co=
mplianceSOS-
>> Compliance De-emphasis: -6dB
>> LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
>> EqualizationPhase1-
>> EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
>> Capabilities: [80] MSI: Enable- Count=3D1/1 Maskable- 64bit-
>> Address: 00000000  Data: 0000
>> Capabilities: [90] Subsystem: Fujitsu Limited. Device 17d3
>> Capabilities: [a0] Power Management version 3
>> Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,=
D3cold+)
>> Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
>> Kernel driver in use: pcieport
>>
>> 00:1c.3 PCI bridge: Intel Corporation 8 Series/C220 Series Chipset
>> Family PCI Express Root Port #4 (rev d4) (prog-if 00 [Normal decode]=
)
>> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>> Stepping- SERR- FastB2B- DisINTx-
>> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>> Latency: 0, Cache Line Size: 64 bytes
>> Bus: primary=3D00, secondary=3D02, subordinate=3D02, sec-latency=3D0
>> I/O behind bridge: 00003000-00003fff
>> Memory behind bridge: f0700000-f07fffff
>> Prefetchable memory behind bridge: 00000000f0400000-00000000f04fffff
>> Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
>> <TAbort- <MAbort+ <SERR- <PERR-
>> BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>> Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
>> DevCap: MaxPayload 128 bytes, PhantFunc 0
>> ExtTag- RBE+
>> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>> RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>> MaxPayload 128 bytes, MaxReadReq 128 bytes
>> DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
>> LnkCap: Port #4, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0=
s
>> <512ns, L1 <16us
>> ClockPM- Surprise- LLActRep+ BwNot+
>> LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
>> ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>> LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+
>> BWMgmt+ ABWMgmt-
>> SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
>> Slot #3, PowerLimit 10.000W; Interlock- NoCompl+
>> SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkC=
hg-
>> Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>> SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
>> Changed: MRL- PresDet- LinkState+
>> RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisib=
le-
>> RootCap: CRSVisible-
>> RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>> DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Not
>> Supported ARIFwd-
>> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF
>> Disabled ARIFwd-
>> LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
>> Transmit Margin: Normal Operating Range, EnterModifiedCompliance- Co=
mplianceSOS-
>> Compliance De-emphasis: -6dB
>> LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
>> EqualizationPhase1-
>> EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
>> Capabilities: [80] MSI: Enable- Count=3D1/1 Maskable- 64bit-
>> Address: 00000000  Data: 0000
>> Capabilities: [90] Subsystem: Fujitsu Limited. Device 17d3
>> Capabilities: [a0] Power Management version 3
>> Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,=
D3cold+)
>> Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
>> Kernel driver in use: pcieport
>>
>> 00:1c.5 PCI bridge: Intel Corporation 8 Series/C220 Series Chipset
>> Family PCI Express Root Port #6 (rev d4) (prog-if 00 [Normal decode]=
)
>> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>> Stepping- SERR- FastB2B- DisINTx-
>> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>> Latency: 0, Cache Line Size: 64 bytes
>> Bus: primary=3D00, secondary=3D03, subordinate=3D03, sec-latency=3D0
>> I/O behind bridge: 0000f000-00000fff
>> Memory behind bridge: f0600000-f06fffff
>> Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
>> Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
>> <TAbort- <MAbort+ <SERR- <PERR-
>> BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>> Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
>> DevCap: MaxPayload 128 bytes, PhantFunc 0
>> ExtTag- RBE+
>> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>> RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>> MaxPayload 128 bytes, MaxReadReq 128 bytes
>> DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
>> LnkCap: Port #6, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0=
s
>> <512ns, L1 <16us
>> ClockPM- Surprise- LLActRep+ BwNot+
>> LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
>> ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>> LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+
>> BWMgmt+ ABWMgmt-
>> SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
>> Slot #5, PowerLimit 10.000W; Interlock- NoCompl+
>> SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkC=
hg-
>> Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>> SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
>> Changed: MRL- PresDet- LinkState+
>> RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisib=
le-
>> RootCap: CRSVisible-
>> RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>> DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Not
>> Supported ARIFwd-
>> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF
>> Disabled ARIFwd-
>> LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
>> Transmit Margin: Normal Operating Range, EnterModifiedCompliance- Co=
mplianceSOS-
>> Compliance De-emphasis: -6dB
>> LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
>> EqualizationPhase1-
>> EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
>> Capabilities: [80] MSI: Enable- Count=3D1/1 Maskable- 64bit-
>> Address: 00000000  Data: 0000
>> Capabilities: [90] Subsystem: Fujitsu Limited. Device 17d3
>> Capabilities: [a0] Power Management version 3
>> Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,=
D3cold+)
>> Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
>> Kernel driver in use: pcieport
>>
>> 00:1c.7 PCI bridge: Intel Corporation 8 Series/C220 Series Chipset
>> Family PCI Express Root Port #8 (rev d4) (prog-if 00 [Normal decode]=
)
>> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>> Stepping- SERR- FastB2B- DisINTx-
>> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>> Latency: 0, Cache Line Size: 64 bytes
>> Bus: primary=3D00, secondary=3D04, subordinate=3D04, sec-latency=3D0
>> I/O behind bridge: 0000f000-00000fff
>> Memory behind bridge: f0500000-f05fffff
>> Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
>> Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
>> <TAbort- <MAbort+ <SERR- <PERR-
>> BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>> Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
>> DevCap: MaxPayload 128 bytes, PhantFunc 0
>> ExtTag- RBE+
>> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>> RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>> MaxPayload 128 bytes, MaxReadReq 128 bytes
>> DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
>> LnkCap: Port #8, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0=
s
>> <512ns, L1 <16us
>> ClockPM- Surprise- LLActRep+ BwNot+
>> LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
>> ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>> LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+
>> BWMgmt+ ABWMgmt-
>> SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
>> Slot #7, PowerLimit 10.000W; Interlock- NoCompl+
>> SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkC=
hg-
>> Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>> SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
>> Changed: MRL- PresDet- LinkState+
>> RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisib=
le-
>> RootCap: CRSVisible-
>> RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>> DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Not
>> Supported ARIFwd-
>> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF
>> Disabled ARIFwd-
>> LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
>> Transmit Margin: Normal Operating Range, EnterModifiedCompliance- Co=
mplianceSOS-
>> Compliance De-emphasis: -6dB
>> LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
>> EqualizationPhase1-
>> EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
>> Capabilities: [80] MSI: Enable- Count=3D1/1 Maskable- 64bit-
>> Address: 00000000  Data: 0000
>> Capabilities: [90] Subsystem: Fujitsu Limited. Device 17d3
>> Capabilities: [a0] Power Management version 3
>> Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,=
D3cold+)
>> Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
>> Kernel driver in use: pcieport
>>
>> 00:1f.0 ISA bridge: Intel Corporation HM86 Express LPC Controller (r=
ev 04)
>> Subsystem: Fujitsu Limited. Device 17c7
>> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>> Stepping- SERR- FastB2B- DisINTx-
>> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>> Latency: 0
>> Capabilities: [e0] Vendor Specific Information: Len=3D0c <?>
>> Kernel driver in use: lpc_ich
>>
>> 00:1f.2 SATA controller: Intel Corporation 8 Series/C220 Series
>> Chipset Family 6-port SATA Controller 1 [AHCI mode] (rev 04) (prog-i=
f
>> 01 [AHCI 1.0])
>> Subsystem: Fujitsu Limited. Device 17c9
>> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>> Stepping- SERR- FastB2B- DisINTx+
>> Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>> Latency: 0
>> Interrupt: pin B routed to IRQ 26
>> Region 0: I/O ports at 4088 [size=3D8]
>> Region 1: I/O ports at 4094 [size=3D4]
>> Region 2: I/O ports at 4080 [size=3D8]
>> Region 3: I/O ports at 4090 [size=3D4]
>> Region 4: I/O ports at 4060 [size=3D32]
>> Region 5: Memory at f081c000 (32-bit, non-prefetchable) [size=3D2K]
>> Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
>> Address: fee0300c  Data: 4191
>> Capabilities: [70] Power Management version 3
>> Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot+,=
D3cold-)
>> Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
>> Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=3D00000004
>> Kernel driver in use: ahci
>>
>> 00:1f.3 SMBus: Intel Corporation 8 Series/C220 Series Chipset Family
>> SMBus Controller (rev 04)
>> Subsystem: Fujitsu Limited. Device 17cf
>> Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
>> Stepping- SERR- FastB2B- DisINTx-
>> Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>> Interrupt: pin C routed to IRQ 7
>> Region 0: Memory at f0818000 (64-bit, non-prefetchable) [size=3D256]
>> Region 4: I/O ports at efa0 [size=3D32]
>>
>> 02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
>> RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 0c)
>> Subsystem: Fujitsu Limited. Device 17a2
>> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>> Stepping- SERR- FastB2B- DisINTx+
>> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>> Latency: 0, Cache Line Size: 64 bytes
>> Interrupt: pin A routed to IRQ 27
>> Region 0: I/O ports at 3000 [size=3D256]
>> Region 2: Memory at f0700000 (64-bit, non-prefetchable) [size=3D4K]
>> Region 4: Memory at f0400000 (64-bit, prefetchable) [size=3D16K]
>> Capabilities: [40] Power Management version 3
>> Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0+,D1+,D2+,D3hot=
+,D3cold+)
>> Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
>> Capabilities: [50] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
>> Address: 00000000fee0f00c  Data: 41a1
>> Capabilities: [70] Express (v2) Endpoint, MSI 01
>> DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 <6=
4us
>> ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
>> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>> RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
>> MaxPayload 128 bytes, MaxReadReq 4096 bytes
>> DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
>> LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency
>> L0s unlimited, L1 <64us
>> ClockPM+ Surprise- LLActRep- BwNot-
>> LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
>> ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
>> LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
>> BWMgmt- ABWMgmt-
>> DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR+, OBFF Via
>> message/WAKE#
>> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF D=
isabled
>> LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
>> Transmit Margin: Normal Operating Range, EnterModifiedCompliance- Co=
mplianceSOS-
>> Compliance De-emphasis: -6dB
>> LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
>> EqualizationPhase1-
>> EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
>> Capabilities: [b0] MSI-X: Enable- Count=3D4 Masked-
>> Vector table: BAR=3D4 offset=3D00000000
>> PBA: BAR=3D4 offset=3D00000800
>> Capabilities: [d0] Vital Product Data
>> Unknown small resource type 00, will not decode more.
>> Capabilities: [100 v1] Advanced Error Reporting
>> UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
>> MalfTLP- ECRC- UnsupReq- ACSViol-
>> UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
>> MalfTLP- ECRC- UnsupReq- ACSViol-
>> UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
>> MalfTLP+ ECRC- UnsupReq- ACSViol-
>> CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>> CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>> AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
>> Capabilities: [140 v1] Virtual Channel
>> Caps: LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
>> Arb: Fixed- WRR32- WRR64- WRR128-
>> Ctrl: ArbSelect=3DFixed
>> Status: InProgress-
>> VC0: Caps: PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
>> Arb: Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
>> Ctrl: Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3Dff
>> Status: NegoPending- InProgress-
>> Capabilities: [160 v1] Device Serial Number 02-4a-11-fe-ff-b2-7f-e4
>> Capabilities: [170 v1] Latency Tolerance Reporting
>> Max snoop latency: 3145728ns
>> Max no snoop latency: 3145728ns
>> Kernel driver in use: r8169
>>
>> 03:00.0 Network controller: Intel Corporation Wireless 7260 (rev 73)
>> Subsystem: Intel Corporation Wireless-N 7260
>> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>> Stepping- SERR- FastB2B- DisINTx+
>> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>> Latency: 0, Cache Line Size: 64 bytes
>> Interrupt: pin A routed to IRQ 32
>> Region 0: Memory at f0600000 (64-bit, non-prefetchable) [size=3D8K]
>> Capabilities: [c8] Power Management version 3
>> Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,=
D3cold+)
>> Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
>> Capabilities: [d0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
>> Address: 00000000fee0100c  Data: 4142
>> Capabilities: [40] Express (v2) Endpoint, MSI 00
>> DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 un=
limited
>> ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
>> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>> RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+ FLReset-
>> MaxPayload 128 bytes, MaxReadReq 128 bytes
>> DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
>> LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency
>> L0s <4us, L1 <32us
>> ClockPM+ Surprise- LLActRep- BwNot-
>> LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
>> ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
>> LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
>> BWMgmt- ABWMgmt-
>> DevCap2: Completion Timeout: Range B, TimeoutDis+, LTR+, OBFF Via WA=
KE#
>> DevCtl2: Completion Timeout: 16ms to 55ms, TimeoutDis-, LTR+, OBFF D=
isabled
>> LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
>> Transmit Margin: Normal Operating Range, EnterModifiedCompliance- Co=
mplianceSOS-
>> Compliance De-emphasis: -6dB
>> LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
>> EqualizationPhase1-
>> EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
>> Capabilities: [100 v1] Advanced Error Reporting
>> UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
>> MalfTLP- ECRC- UnsupReq- ACSViol-
>> UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
>> MalfTLP- ECRC- UnsupReq- ACSViol-
>> UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
>> MalfTLP+ ECRC- UnsupReq- ACSViol-
>> CESta: RxErr- BadTLP+ BadDLLP- Rollover- Timeout- NonFatalErr+
>> CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>> AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
>> Capabilities: [140 v1] Device Serial Number a0-a8-cd-ff-ff-a7-be-3a
>> Capabilities: [14c v1] Latency Tolerance Reporting
>> Max snoop latency: 3145728ns
>> Max no snoop latency: 3145728ns
>> Capabilities: [154 v1] Vendor Specific Information: ID=3Dcafe Rev=3D=
1 Len=3D014 <?>
>> Kernel driver in use: iwlwifi
>>
>> 04:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd.
>> RTS5227 PCI Express Card Reader (rev 01)
>> Subsystem: Fujitsu Limited. Device 187f
>> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>> Stepping- SERR- FastB2B- DisINTx+
>> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>> Latency: 0, Cache Line Size: 64 bytes
>> Interrupt: pin A routed to IRQ 25
>> Region 0: Memory at f0500000 (32-bit, non-prefetchable) [size=3D4K]
>> Capabilities: [40] Power Management version 3
>> Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0-,D1+,D2+,D3hot=
+,D3cold+)
>> Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
>> Capabilities: [50] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
>> Address: 00000000fee0f00c  Data: 4181
>> Capabilities: [70] Express (v2) Endpoint, MSI 00
>> DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1=
 unlimited
>> ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
>> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>> RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
>> MaxPayload 128 bytes, MaxReadReq 512 bytes
>> DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
>> LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency
>> L0s unlimited, L1 <64us
>> ClockPM+ Surprise- LLActRep- BwNot-
>> LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk-
>> ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
>> LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
>> BWMgmt- ABWMgmt-
>> DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR+, OBFF
>> Via message/WAKE#
>> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF D=
isabled
>> LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
>> Transmit Margin: Normal Operating Range, EnterModifiedCompliance- Co=
mplianceSOS-
>> Compliance De-emphasis: -6dB
>> LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
>> EqualizationPhase1-
>> EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
>> Capabilities: [100 v2] Advanced Error Reporting
>> UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
>> MalfTLP- ECRC- UnsupReq- ACSViol-
>> UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
>> MalfTLP- ECRC- UnsupReq- ACSViol-
>> UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
>> MalfTLP+ ECRC- UnsupReq- ACSViol-
>> CESta: RxErr+ BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>> CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>> AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
>> Capabilities: [140 v1] Device Serial Number 00-00-00-01-00-4c-e0-00
>> Capabilities: [150 v1] Latency Tolerance Reporting
>> Max snoop latency: 3145728ns
>> Max no snoop latency: 3145728ns
>> Capabilities: [158 v1] L1 PM Substates
>> L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Subs=
tates+
>>  PortCommonModeRestoreTime=3D60us PortTPowerOnTime=3D60us
>> Kernel driver in use: rtsx_pci
>>
>> --------------------------------------------------
>>
>> cat /proc/scsi/scsi
>> Attached devices:
>> Host: scsi2 Channel: 00 Id: 00 Lun: 00
>>   Vendor: TSSTcorp Model: CDDVDW SU-208CB  Rev: FU01
>>   Type:   CD-ROM                           ANSI  SCSI revision: 05
>> Host: scsi4 Channel: 00 Id: 00 Lun: 00
>>   Vendor: ATA      Model: SAMSUNG MZ7TE256 Rev: 200Q
>>   Type:   Direct-Access                    ANSI  SCSI revision: 05
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-inpu=
t" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
