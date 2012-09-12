From: Ed Spittles <ed.spittles@gmail.com>
Subject: Re: Synaptics Touchpad incorrectly detected as PS/2 mouse on clausoft
 MNW737 (aka meenee, aka PX1)
Date: Wed, 12 Sep 2012 21:05:22 +0100
Message-ID: <CAMPG4Y-2CJKHBTVQZPa1mRvHug5pyacr+XJ179wfVxfr0j-sHg@mail.gmail.com>
References: <CAMPG4Y-X9g8FUOYgfo4MBpLjKnnjf631=VriEZ30P+ML9f0Hcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:44027 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751891Ab2ILUFX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Sep 2012 16:05:23 -0400
Received: by obbuo13 with SMTP id uo13so3276303obb.19
        for <linux-input@vger.kernel.org>; Wed, 12 Sep 2012 13:05:22 -0700 (PDT)
In-Reply-To: <CAMPG4Y-X9g8FUOYgfo4MBpLjKnnjf631=VriEZ30P+ML9f0Hcw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: "755518@bugs.launchpad.net" <755518@bugs.launchpad.net>

Hi all,
     (This is a move upstream for a bug reported on Ubuntu's Launchpad
tracker (https://bugs.launchpad.net/ubuntu/+source/linux/+bug/755518),
please bear with me.)

    A laptop sold with Ubuntu linux in 2010 has an misdetected touchpad.

    We're told by the manufacturer that it's a Synaptics controller, and the
Synaptics driver supplied by them for Windows is dated 08/27/2009. The
problem persists with a range of kernel versions, up to and including a
recent 'rc5' 'mainline' kernel built by ubuntu.

    I tried to install Windows to a virtual machine with the aim of
investigating with the Synaptics driver, but failed to complete the
installation.  I'm willing to try modules or patches. There are 6 other
Launchpad users with the same problem, hopefully we can help you to help us.

    Thanks
Ed

    Here's the problem info in the format advised by Ubuntu (which makes
this a long email, but hopefully useful):

[1.] One line summary of the problem:

Synaptics Touchpad incorrectly detected as PS/2 mouse on clausoft MNW737
(aka meenee, aka PX1)

[2.] Full description of the problem/report:

There's no touchpad tab in the system/prefs/mouse control panel.
gconf-editor has a button to disable tap-to-click but it has no effect. Xorg
log does not mention synaptics. /proc/bus/input/devices does not mention
synaptics. The tpconfig tool is unable to adjust zthreshold or disable tap
to click. tpconfig reports this:

# tpconfig -D1 -z0
Probing mouse port [/dev/psaux].
Grabbing mouse port [/dev/psaux].
Trying Synaptics detection.
[query 00 => 0x60 0x3 0xc8]
Found Synaptics Touchpad.
[query 0x3 => 0x60 0x3 0xc8]
Firmware: 8.96 (multiple-byte mode).
Z threshold set as "0".
[query 0x1 => 0x60 0x3 0xc8]
[query 0x1 => 0x60 0x3 0xc8]
Z threshold: 6 of 7.

Strictly, the touchpad is detected as "ImPS/2 Generic Wheel Mouse" according
to /proc/bus/input/devices

I've reported this as linux (kernel) problem according to advice on
https://wiki.ubuntu.com/DebuggingTouchpadDetection

>From that page there's just one similar open known bug, which relates to
ALPS hardware (so is different)

As evidence that this is synaptics hardware the vendor provides a windows
driver with this identifying info
DriverVer=08/27/2009, 14.0.3.0
DriverMfgr="Synaptics"

This netbook is sold as 'meenee'

ApportVersion: 2.4-0ubuntu5
Architecture: i386
AudioDevicesInUse:
 USER PID ACCESS COMMAND
 /dev/snd/controlC0: ubuntu 3286 F.... pulseaudio
CasperVersion: 1.320
DistroRelease: Ubuntu 12.10
LiveMediaBuild: Ubuntu 12.10 "Quantal Quetzal" - Alpha i386 (20120724.2)
MachineType: THD(Thread technology) PX1
Package: linux (not installed)
ProcEnviron:
 TERM=xterm
 PATH=(custom, no user)
 LANG=en_US.UTF-8
 SHELL=/bin/bash
ProcFB: 0 inteldrmfb
ProcKernelCmdLine: initrd=/ubninit file=/cdrom/preseed/username.seed
boot=casper quiet splash -- BOOT_IMAGE=/ubnkern
ProcVersionSignature: Ubuntu 3.5.0-6.6-generic 3.5.0
RelatedPackageVersions:
 linux-restricted-modules-3.5.0-6-generic N/A
 linux-backports-modules-3.5.0-6-generic N/A
 linux-firmware 1.85
RfKill:
 0: phy0: Wireless LAN
  Soft blocked: no
  Hard blocked: no
Tags: quantal running-unity
Uname: Linux 3.5.0-6-generic i686
UpgradeStatus: No upgrade log present (probably fresh install)
UserGroups: adm cdrom dip lpadmin plugdev sambashare sudo
dmi.bios.date: 10/08/2010
dmi.bios.vendor: American Megatrends Inc.
dmi.bios.version: 080016
dmi.board.asset.tag: To Be Filled By O.E.M.
dmi.board.name: PX1
dmi.board.vendor: THD(Thread technology)
dmi.board.version: 01
dmi.chassis.asset.tag: To Be Filled By O.E.M.
dmi.chassis.type: 3
dmi.chassis.vendor: To Be Filled By O.E.M.
dmi.chassis.version: To Be Filled By O.E.M.
dmi.modalias:
dmi:bvnAmericanMegatrendsInc.:bvr080016:bd10/08/2010:svnTHD(Threadtechnology):pnPX1:pvr01:rvnTHD(Threadtechnology):rnPX1:rvr01:cvnToBeFilledByO.E.M.:ct3:cvrToBeFilledByO.E.M.:
dmi.product.name: PX1
dmi.product.version: 01
dmi.sys.vendor: THD(Thread technology)

[3.] Keywords (i.e., modules, networking, kernel):

input, linux-input, kernel, psmouse

Tags: natty oneiric quantal apport-bug apport-collected bot-stop-nagging
i386 kernel-bug-exists-upstream kernel-bug-exists-upstream-v3.6-rc3-quantal
maverick running-unity ubuntu-une Edit Tag help

[4.] Kernel version (from /proc/version):
Linux version 3.6.0-030600rc5-generic (apw@gomeisa) (gcc version 4.6.3
(Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201209082035 SMP Sun Sep 9 00:42:37 UTC
2012

[5.] Output of Oops.. message (if applicable) with symbolic information
resolved (see Documentation/oops-tracing.txt)
Not applicable

[6.] A small shell script or example program which triggers the problem (if
possible)
This does not trigger the problem, but may help to indicate what the
hardware detection is doing:

OLD=/tmp/psmouse_debug1
NEW=/tmp/psmouse_debug2
sudo rmmod psmouse
dmesg > $OLD
echo 1 | sudo tee -a /sys/module/i8042/parameters/debug
sudo modprobe -v psmouse
echo 0 | sudo tee -a /sys/module/i8042/parameters/debug
dmesg > $NEW
diff $OLD $NEW

which in my case (running 3.6.0-030600rc5-generic) gives:
> [ 1105.917456] i8042: [276198] d4 -> i8042 (command)
> [ 1105.917885] i8042: [276198] f2 -> i8042 (parameter)
> [ 1105.931264] i8042: [276201] fa <- i8042 (interrupt, 1, 12)
> [ 1105.931524] i8042: [276201] 03 <- i8042 (interrupt, 1, 12)
> [ 1105.931560] i8042: [276201] d4 -> i8042 (command)
> [ 1105.931985] i8042: [276201] f6 -> i8042 (parameter)


and in the case of Leo Iannacone (l3on) running 3.5.0-14-generic
(quantal)gives:
> [ 9916.288344] i8042: [2478934] 90 -> i8042 (command)
> [ 9916.288614] i8042: [2478934] f2 -> i8042 (parameter)
> [ 9916.289262] i8042: [2478934] MUX error, status is 35, data is fe
> [ 9916.289274] i8042: [2478934] fe <- i8042 (interrupt, 2, 12, timeout)
> [ 9916.289352] i8042: [2478934] 91 -> i8042 (command)
> [ 9916.289566] i8042: [2478934] f2 -> i8042 (parameter)
> [ 9916.300835] i8042: [2478937] fa <- i8042 (interrupt, 3, 12)
> [ 9916.302350] i8042: [2478937] 03 <- i8042 (interrupt, 3, 12)
> [ 9916.302411] i8042: [2478937] 91 -> i8042 (command)
> [ 9916.302628] i8042: [2478937] f6 -> i8042 (parameter)


[7.] Environment
lsb_release -rd
Description:    Ubuntu quantal (development branch)
Release:        12.10

[7.1.] Software (add the output of the ver_linux script here)
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux meeneePX1 3.6.0-030600rc5-generic #201209082035 SMP Sun Sep 9 00:42:37
UTC 2012 i686 i686 i686 GNU/Linux

Gnu C                  4.7
Gnu make               3.81
binutils               2.22.52.20120713
util-linux             2.20.1
mount                  support
module-init-tools      3.16
e2fsprogs              1.42.4
pcmciautils            018
PPP                    2.4.5
Linux C Library        2.15
Dynamic linker (ldd)   2.15
Procps                 3.3.3
Net-tools              1.60
Kbd                    1.15.3
Sh-utils               8.13
wireless-tools         30
Modules Loaded         microcode psmouse serio_raw parport_pc ppdev video lp
parport usb_storage

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 28
model name      : Intel(R) Atom(TM) CPU N455   @ 1.66GHz
stepping        : 10
microcode       : 0x107
cpu MHz         : 1000.000
cache size      : 512 KB
physical id     : 0
siblings        : 1
core id         : 0
cpu cores       : 1
apicid          : 0
initial apicid  : 0
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 10
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm constant_tsc
arch_perfmon pebs bts aperfmperf pni dtes64 monitor ds_cpl est tm2 ssse3
cx16 xtpr pdcm movbe lahf_lm dtherm
bogomips        : 3325.19
clflush size    : 64
cache_alignment : 64
address sizes   : 32 bits physical, 48 bits virtual
power management:

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 28
model name      : Intel(R) Atom(TM) CPU N455   @ 1.66GHz
stepping        : 10
microcode       : 0x107
cpu MHz         : 1000.000
cache size      : 512 KB
physical id     : 0
siblings        : 1
core id         : 0
cpu cores       : 0
apicid          : 1
initial apicid  : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 10
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm constant_tsc
arch_perfmon pebs bts aperfmperf pni dtes64 monitor ds_cpl est tm2 ssse3
cx16 xtpr pdcm movbe lahf_lm dtherm
bogomips        : 3325.19
clflush size    : 64
cache_alignment : 64
address sizes   : 32 bits physical, 48 bits virtual
power management:


[7.3.] Module information (from /proc/modules):
microcode 18406 0 - Live 0x00000000
psmouse 77485 0 - Live 0x00000000
serio_raw 13031 0 - Live 0x00000000
parport_pc 32114 0 - Live 0x00000000
ppdev 12849 0 - Live 0x00000000
video 18908 0 - Live 0x00000000
lp 17455 0 - Live 0x00000000
parport 40930 3 parport_pc,ppdev,lp, Live 0x00000000
usb_storage 39719 0 - Live 0x00000000


[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
Execute the following in a terminal, and paste the results:
cat /proc/ioports
0000-0cf7 : PCI Bus 0000:00
  0000-001f : dma1
  0020-0021 : pic1
  0040-0043 : timer0
  0050-0053 : timer1
  0060-0060 : keyboard
  0062-0062 : EC data
  0064-0064 : keyboard
  0066-0066 : EC cmd
  0070-0071 : rtc0
  0080-008f : dma page reg
  00a0-00a1 : pic2
  00c0-00df : dma2
  00f0-00ff : fpu
  0170-0177 : 0000:00:1f.2
    0170-0177 : ata_piix
  01f0-01f7 : 0000:00:1f.2
    01f0-01f7 : ata_piix
  0376-0376 : 0000:00:1f.2
    0376-0376 : ata_piix
  03c0-03df : vga+
  03f6-03f6 : 0000:00:1f.2
    03f6-03f6 : ata_piix
  0400-041f : 0000:00:1f.3
  0480-04bf : pnp 00:08
  04d0-04d1 : pnp 00:08
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
  1000-107f : pnp 00:08
    1000-1003 : ACPI PM1a_EVT_BLK
    1004-1005 : ACPI PM1a_CNT_BLK
    1008-100b : ACPI PM_TMR
    1010-1015 : ACPI CPU throttle
    1020-1020 : ACPI PM2_CNT_BLK
    1028-102f : ACPI GPE0_BLK
  2000-2fff : PCI Bus 0000:02
  d400-d41f : 0000:00:1d.3
    d400-d41f : uhci_hcd
  d480-d49f : 0000:00:1d.2
    d480-d49f : uhci_hcd
  d800-d81f : 0000:00:1d.1
    d800-d81f : uhci_hcd
  d880-d89f : 0000:00:1d.0
    d880-d89f : uhci_hcd
  dc00-dc07 : 0000:00:02.0
  e000-efff : PCI Bus 0000:01
    e800-e8ff : 0000:01:00.0
  ff90-ff9f : 0000:00:1f.2
    ff90-ff9f : ata_piix


cat /proc/iomem
00000000-0000ffff : reserved
00010000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
  000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000d0000-000dffff : PCI Bus 0000:00
000e0000-000fffff : reserved
  000f0000-000fffff : System ROM
00100000-7f58ffff : System RAM
  01000000-015eb320 : Kernel code
  015eb321-018db6bf : Kernel data
  019a0000-01a78fff : Kernel bss
7f590000-7f59dfff : ACPI Tables
7f59e000-7f5cffff : ACPI Non-volatile Storage
7f5d0000-7f5dffff : reserved
7f5e0000-7f5e7fff : RAM buffer
7f5e8000-dfffffff : reserved
  7f700000-dfffffff : PCI Bus 0000:00
    80000000-801fffff : PCI Bus 0000:02
    80200000-802003ff : 0000:00:1f.2
    80201000-80201fff : Intel Flush Page
    d0000000-dfffffff : 0000:00:02.0
e0000000-efffffff : PCI MMCONFIG 0000 [bus 00-ff]
  e0000000-efffffff : pnp 00:0d
f0000000-fed8ffff : PCI Bus 0000:00
  fdf00000-fdffffff : PCI Bus 0000:01
    fdfef000-fdfeffff : 0000:01:00.0
    fdff0000-fdffffff : 0000:01:00.0
  fe780000-fe7fffff : 0000:00:02.1
  fe877c00-fe877fff : 0000:00:1d.7
    fe877c00-fe877fff : ehci_hcd
  fe878000-fe87bfff : 0000:00:1b.0
  fe880000-fe8fffff : 0000:00:02.0
  fe900000-fe9fffff : 0000:00:02.0
  fea00000-feafffff : PCI Bus 0000:01
    feae0000-feafffff : 0000:01:00.0
  feb00000-febfffff : PCI Bus 0000:02
    febf0000-febfffff : 0000:02:00.0
  fec00000-fec003ff : IOAPIC 0
  fed00000-fed003ff : HPET 0
  fed14000-fed19fff : pnp 00:01
  fed1c000-fed1ffff : pnp 00:08
  fed20000-fed8ffff : pnp 00:08
fed90000-fed93fff : pnp 00:01
fee00000-fee00fff : Local APIC
  fee00000-fee00fff : reserved
    fee00000-fee00fff : pnp 00:0c
ffb00000-ffffffff : reserved
  ffc00000-ffefffff : pnp 00:0b


[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: Intel Corporation Atom Processor D4xx/D5xx/N4xx/N5xx
DMI Bridge
        Subsystem: Intel Corporation Atom Processor D4xx/D5xx/N4xx/N5xx DMI
Bridge
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR- INTx-
        Latency: 0
        Capabilities: [e0] Vendor Specific Information: Len=08 <?>
        Kernel driver in use: agpgart-intel

00:02.0 VGA compatible controller: Intel Corporation Atom Processor
D4xx/D5xx/N4xx/N5xx Integrated Graphics Controller (prog-if 00 [VGA
controller])
        Subsystem: Intel Corporation Atom Processor D4xx/D5xx/N4xx/N5xx
Integrated Graphics Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at fe880000 (32-bit, non-prefetchable) [size=512K]
        Region 1: I/O ports at dc00 [size=8]
        Region 2: Memory at d0000000 (32-bit, prefetchable) [size=256M]
        Region 3: Memory at fe900000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at <unassigned> [disabled]
        Capabilities: [90] MSI: Enable- Count=1/1 Maskable- 64bit-
                Address: 00000000  Data: 0000
        Capabilities: [d0] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-

00:02.1 Display controller: Intel Corporation Atom Processor
D4xx/D5xx/N4xx/N5xx Integrated Graphics Controller
        Subsystem: Intel Corporation Device a011
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Region 0: Memory at fe780000 (32-bit, non-prefetchable) [size=512K]
        Capabilities: [d0] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-

00:1b.0 Audio device: Intel Corporation N10/ICH 7 Family High Definition
Audio Controller (rev 02)
        Subsystem: Device 1991:5634
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at fe878000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [60] MSI: Enable- Count=1/1 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [70] Express (v1) Root Complex Integrated Endpoint,
MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
<64ns, L1 <1us
                        ExtTag- RBE- FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+
TransPend-
                LnkCap: Port #0, Speed unknown, Width x0, ASPM unknown,
Latency L0 <64ns, L1 <1us
                        ClockPM- Surprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; Disabled- Retrain- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed unknown, Width x0, TrErr- Train- SlotClk-
DLActive- BWMgmt- ABWMgmt-
        Capabilities: [100 v1] Virtual Channel
                Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                Arb:    Fixed- WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=Fixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128-
WRR256-
                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=01
                        Status: NegoPending- InProgress-
                VC1:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128-
WRR256-
                        Ctrl:   Enable+ ID=1 ArbSelect=Fixed TC/VC=80
                        Status: NegoPending- InProgress-
        Capabilities: [130 v1] Root Complex Link
                Desc:   PortNumber=0f ComponentID=00 EltType=Config
                Link0:  Desc:   TargetPort=00 TargetComponent=00 AssocRCRB-
LinkType=MemMapped LinkValid+
                        Addr:   00000000fed1c000

00:1c.0 PCI bridge: Intel Corporation N10/ICH 7 Family PCI Express Port 1
(rev 02) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 32 bytes
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000e000-0000efff
        Memory behind bridge: fea00000-feafffff
        Prefetchable memory behind bridge: 00000000fdf00000-00000000fdffffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
unlimited, L1 unlimited
                        ExtTag- RBE- FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+
TransPend-
                LnkCap: Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Latency L0 <256ns, L1 <4us
                        ClockPM- Surprise- LLActRep+ BwNot-
                LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain-
CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive+ BWMgmt- ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+
Surprise+
                        Slot #32, PowerLimit 10.000W; Interlock- NoCompl-
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt+
HPIrq+ LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown, Power-
Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+
Interlock-
                        Changed: MRL- PresDet- LinkState+
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+
CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
                Address: fee0300c  Data: 4191
        Capabilities: [90] Subsystem: Device 1991:1001
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [100 v1] Virtual Channel
                Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                Arb:    Fixed+ WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=Fixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128-
WRR256-
                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=01
                        Status: NegoPending- InProgress-
                VC1:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128-
WRR256-
                        Ctrl:   Enable- ID=0 ArbSelect=Fixed TC/VC=00
                        Status: NegoPending- InProgress-
        Capabilities: [180 v1] Root Complex Link
                Desc:   PortNumber=01 ComponentID=00 EltType=Config
                Link0:  Desc:   TargetPort=00 TargetComponent=00 AssocRCRB-
LinkType=MemMapped LinkValid+
                        Addr:   00000000fed1c001
        Kernel driver in use: pcieport

00:1c.1 PCI bridge: Intel Corporation N10/ICH 7 Family PCI Express Port 2
(rev 02) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 32 bytes
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        I/O behind bridge: 00002000-00002fff
        Memory behind bridge: feb00000-febfffff
        Prefetchable memory behind bridge: 0000000080000000-00000000801fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
unlimited, L1 unlimited
                        ExtTag- RBE- FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+
TransPend-
                LnkCap: Port #2, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Latency L0 <256ns, L1 <4us
                        ClockPM- Surprise- LLActRep+ BwNot-
                LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain-
CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive+ BWMgmt- ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+
Surprise+
                        Slot #33, PowerLimit 10.000W; Interlock- NoCompl-
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt+
HPIrq+ LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown, Power-
Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+
Interlock-
                        Changed: MRL- PresDet- LinkState+
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+
CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
                Address: fee0300c  Data: 41a1
        Capabilities: [90] Subsystem: Device 1991:1001
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [100 v1] Virtual Channel
                Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                Arb:    Fixed+ WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=Fixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128-
WRR256-
                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=01
                        Status: NegoPending- InProgress-
                VC1:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128-
WRR256-
                        Ctrl:   Enable- ID=0 ArbSelect=Fixed TC/VC=00
                        Status: NegoPending- InProgress-
        Capabilities: [180 v1] Root Complex Link
                Desc:   PortNumber=02 ComponentID=00 EltType=Config
                Link0:  Desc:   TargetPort=00 TargetComponent=00 AssocRCRB-
LinkType=MemMapped LinkValid+
                        Addr:   00000000fed1c001
        Kernel driver in use: pcieport

00:1d.0 USB controller: Intel Corporation N10/ICH 7 Family USB UHCI
Controller #1 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Device 1991:1002
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 23
        Region 4: I/O ports at d880 [size=32]
        Kernel driver in use: uhci_hcd

00:1d.1 USB controller: Intel Corporation N10/ICH 7 Family USB UHCI
Controller #2 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Device 1991:1002
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin B routed to IRQ 19
        Region 4: I/O ports at d800 [size=32]
        Kernel driver in use: uhci_hcd

00:1d.2 USB controller: Intel Corporation N10/ICH 7 Family USB UHCI
Controller #3 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Device 1991:1002
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin C routed to IRQ 18
        Region 4: I/O ports at d480 [size=32]
        Kernel driver in use: uhci_hcd

00:1d.3 USB controller: Intel Corporation N10/ICH 7 Family USB UHCI
Controller #4 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Device 1991:1002
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin D routed to IRQ 16
        Region 4: I/O ports at d400 [size=32]
        Kernel driver in use: uhci_hcd

00:1d.7 USB controller: Intel Corporation N10/ICH 7 Family USB2 EHCI
Controller (rev 02) (prog-if 20 [EHCI])
        Subsystem: Allied Telesis, Inc Device 1002
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 23
        Region 0: Memory at fe877c00 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Debug port: BAR=1 offset=00a0
        Kernel driver in use: ehci_hcd

00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev e2)
(prog-if 01 [Subtractive decode])
        Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=32
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
        Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [50] Subsystem: Device 1991:1001

00:1f.0 ISA bridge: Intel Corporation NM10 Family LPC Controller (rev 02)
        Subsystem: Device 1991:1001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Capabilities: [e0] Vendor Specific Information: Len=0c <?>

00:1f.2 IDE interface: Intel Corporation N10/ICH7 Family SATA Controller
[IDE mode] (rev 02) (prog-if 8a [Master SecP PriP])
        Subsystem: Device 1991:1001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin B routed to IRQ 19
        Region 0: I/O ports at 01f0 [size=8]
        Region 1: I/O ports at 03f4 [size=1]
        Region 2: I/O ports at 0170 [size=8]
        Region 3: I/O ports at 0374 [size=1]
        Region 4: I/O ports at ff90 [size=16]
        Region 5: Memory at 80200000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [70] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: ata_piix

00:1f.3 SMBus: Intel Corporation N10/ICH 7 Family SMBus Controller (rev 02)
        Subsystem: Device 1991:1001
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin B routed to IRQ 3
        Region 4: I/O ports at 0400 [size=32]

01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL8101E/RTL8102E PCI Express Fast Ethernet controller (rev 02)
        Subsystem: Realtek Semiconductor Co., Ltd. RTL8101E/RTL8102E PCI
Express Fast Ethernet controller
        Physical Slot: 32
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at e800 [size=256]
        Region 2: Memory at fdfef000 (64-bit, prefetchable) [size=4K]
        Region 4: Memory at fdff0000 (64-bit, prefetchable) [size=64K]
        Expansion ROM at feae0000 [disabled] [size=128K]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [70] Express (v2) Endpoint, MSI 01
                DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s
<512ns, L1 <64us
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+
TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Latency L0 <512ns, L1 <64us
                        ClockPM+ Surprise- LLActRep- BwNot-
                LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain-
CommClk+
                        ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Not Supported, TimeoutDis+
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
                LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance-
SpeedDis-, Selectable De-emphasis: -6dB
                         Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-
        Capabilities: [ac] MSI-X: Enable- Count=2 Masked-
                Vector table: BAR=4 offset=00000000
                PBA: BAR=4 offset=00000800
        Capabilities: [cc] Vital Product Data
                Unknown small resource type 00, will not decode more.
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr+ BadTLP- BadDLLP- Rollover- Timeout-
NonFatalErr+
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
NonFatalErr+
                AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+
ChkEn-
        Capabilities: [140 v1] Virtual Channel
                Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                Arb:    Fixed- WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=Fixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128-
WRR256-
                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=01
                        Status: NegoPending- InProgress-
        Capabilities: [160 v1] Device Serial Number 01-00-00-00-00-00-00-00

02:00.0 Network controller: Atheros Communications Inc. AR9285 Wireless
Network Adapter (PCI-Express) (rev 01)
        Subsystem: AzureWave AW-NB037H 802.11bgn Wireless Half-size Mini
PCIe Card [AR9002WB-1NGCD]
        Physical Slot: 33
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at febf0000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=375mA
PME(D0+,D1+,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit-
                Address: 00000000  Data: 0000
        Capabilities: [60] Express (v2) Legacy Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
<512ns, L1 <64us
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+
TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Latency L0 <512ns, L1 <64us
                        ClockPM- Surprise- LLActRep- BwNot-
                LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain-
CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Not Supported, TimeoutDis+
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
                LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance-
SpeedDis-, Selectable De-emphasis: -6dB
                         Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
NonFatalErr+
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
NonFatalErr+
                AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+
ChkEn-
        Capabilities: [140 v1] Virtual Channel
                Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                Arb:    Fixed- WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=Fixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128-
WRR256-
                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=01
                        Status: NegoPending- InProgress-
        Capabilities: [160 v1] Device Serial Number 00-15-17-ff-ff-24-14-12
        Capabilities: [170 v1] Power Budgeting <?>

[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: CSD T55SX320     Rev: FH11
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: USB2.0   Model: CardReader COMBO Rev: 0100
  Type:   Direct-Access                    ANSI  SCSI revision: 00


[7.7.] Other information that might be relevant to the problem (please look
in /proc and include all information that you think to be relevant):
Execute the following via a terminal, and paste the results:
ls /proc
1     1410  1616  1728  2049  3    70           fb             pagetypeinfo
10    1413  1617  1749  2050  30   71           filesystems    partitions
1009  1414  1618  1762  2060  31   735          fs             sched_debug
1017  1417  1619  1764  2064  314  783          interrupts     schedstat
1035  1421  1621  1767  2065  32   8            iomem          scsi
1036  1424  1636  1769  2093  327  9            ioports        self
1039  1437  1640  1771  21    33   920          irq            slabinfo
1058  1440  1651  18    210   42   942          kallsyms       softirqs
1063  1448  1656  1805  22    45   971          kcore          stat
1068  15    1666  1812  223   46   975          key-users      swaps
1069  1509  1668  1814  224   466  acpi         kmsg           sys
1071  1520  1670  1819  225   469  buddyinfo    kpagecount     sysrq-trigger
11    1584  1675  183   226   47   bus          kpageflags     sysvipc
12    1586  1680  184   23    471  cgroups      latency_stats  timer_list
1213  1590  1684  1840  2309  48   cmdline      loadavg        timer_stats
1238  1595  1686  1853  24    5    consoles     locks          tty
1258  16    1688  1859  2421  512  cpuinfo      mdstat         uptime
1265  1605  1690  1865  244   513  crypto       meminfo        version
1268  1607  1692  1870  25    534  devices      misc           vmallocinfo
1292  1610  1694  19    26    595  diskstats    modules        vmstat
13    1612  1696  1953  27    68   dma          mounts         zoneinfo
1367  1613  17    2     28    69   driver       mtrr
14    1614  1726  20    29    7    execdomains  net


[X.] Other notes, patches, fixes, workarounds:
Seth Forshee has helped with similar difficulties which turn out to be
laptops with ALPS touchpads. This does not seem to be a problem with an ALPS
touchpad.  He recommended a line of investigation which involved installing
Windows and the manufacturer-supplied driver, but I was unable to get the
installation to complete on a VM.
