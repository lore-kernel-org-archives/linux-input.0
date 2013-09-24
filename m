From: Ari Fogel <arifogel@ucla.edu>
Subject: 045e:0745 [HP TouchSmart tm2t-2200] No scancode for several keys
 of Microsoft Comfort Desktop 5000
Date: Tue, 24 Sep 2013 11:43:14 -0700
Message-ID: <5241DD42.6040802@ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:55035 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732Ab3IXSnS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Sep 2013 14:43:18 -0400
Received: by mail-pa0-f54.google.com with SMTP id kx10so5410308pab.27
        for <linux-input@vger.kernel.org>; Tue, 24 Sep 2013 11:43:18 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org


[1]. Summary:
045e:0745 [HP TouchSmart tm2t-2200] No scancode for several keys of
Microsoft Comfort Desktop 5000

[2]. Link to original bug report in launchpad:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1168224

[2]. Bug description:
I wanted to map the keys labeled '1', '2', '3', '4', and '5' above the
F-keys between the camera key and the star key, and directly to the
right of the right ALT key but I discovered that these raise no events
whatsoever via dmesg, xev, nor showkey.

ProblemType: Bug
DistroRelease: Ubuntu 12.04
Package: linux-image-3.2.0-40-generic 3.2.0-40.64
ProcVersionSignature: Ubuntu 3.2.0-40.64-generic 3.2.40
Uname: Linux 3.2.0-40-generic x86_64
AlsaVersion: Advanced Linux Sound Architecture Driver Version 1.0.24.
ApportVersion: 2.0.1-0ubuntu17.1
Architecture: amd64
ArecordDevices:
 **** List of CAPTURE Hardware Devices ****
 card 0: Intel [HDA Intel], device 0: STAC92xx Analog [STAC92xx Analog]
   Subdevices: 1/1
   Subdevice #0: subdevice #0
AudioDevicesInUse:
 USER PID ACCESS COMMAND
 /dev/snd/controlC1: arifogel 1861 F.... pulseaudio
 /dev/snd/controlC0: arifogel 1861 F.... pulseaudio
Card0.Amixer.info:
 Card hw:0 'Intel'/'HDA Intel at 0xc4500000 irq 45'
   Mixer name : 'IDT 92HD81B1X5'
   Components : 'HDA:111d7605,103c1486,00100402'
   Controls : 16
   Simple ctrls : 9
Card1.Amixer.info:
 Card hw:1 'Generic'/'HD-Audio Generic at 0xc4420000 irq 47'
   Mixer name : 'ATI R6xx HDMI'
   Components : 'HDA:1002aa01,00aa0100,00100200'
   Controls : 6
   Simple ctrls : 1
Card1.Amixer.values:
 Simple mixer control 'IEC958',0
   Capabilities: pswitch pswitch-joined penum
   Playback channels: Mono
   Mono: Playback [on]
Date: Thu Apr 11 20:50:37 2013
HibernationDevice: RESUME=UUID=e46d0966-e5ee-4f6e-9e3f-1f21a65ac784
MachineType: Hewlett-Packard HP TouchSmart tm2 Notebook PC
MarkForUpload: True
ProcFB:
 0 inteldrmfb
 1 radeondrmfb
ProcKernelCmdLine: BOOT_IMAGE=/vmlinuz-3.2.0-40-generic
root=UUID=3be4864c-c530-4049-8cbf-dc74129749b5 ro loop.max_part=63
acpi_osi=Linux acpi_backlight=vendor
RelatedPackageVersions:
 linux-restricted-modules-3.2.0-40-generic N/A
 linux-backports-modules-3.2.0-40-generic N/A
 linux-firmware 1.79.1
SourcePackage: linux
StagingDrivers: mei
UpgradeStatus: No upgrade log present (probably fresh install)
dmi.bios.date: 02/18/2011
dmi.bios.vendor: Insyde
dmi.bios.version: F.25
dmi.board.asset.tag: Base Board Asset Tag
dmi.board.name: 1486
dmi.board.vendor: Hewlett-Packard
dmi.board.version: 83.20
dmi.chassis.asset.tag: CNU1120G9K
dmi.chassis.type: 10
dmi.chassis.vendor: Hewlett-Packard
dmi.chassis.version: Chassis Version
dmi.modalias:
dmi:bvnInsyde:bvrF.25:bd02/18/2011:svnHewlett-Packard:pnHPTouchSmarttm2NotebookPC:pvr0587220000242A20000220100:rvnHewlett-Packard:rn1486:rvr83.20:cvnHewlett-Packard:ct10:cvrChassisVersion:
dmi.product.name: HP TouchSmart tm2 Notebook PC
dmi.product.version: 0587220000242A20000220100
dmi.sys.vendor: Hewlett-Packard
[3]. Keywords (couldn't find authoritative list):
kernel

[4]. Kernel version (/proc/version)
Linux version 3.11.0-031100rc4-generic (apw@gomeisa) (gcc version 4.6.3
(Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201308041735 SMP Sun Aug 4 21:36:46
UTC 2013

[5]. N/A

[6]. N/A

[7]. Environment
Description:    Ubuntu 12.04.2 LTS
Release:    12.04

[7.1]. output of ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux vademecum 3.11.0-031100rc4-generic #201308041735 SMP Sun Aug 4
21:36:46 UTC 2013 x86_64 x86_64 x86_64 GNU/Linux

Gnu C                  4.6
Gnu make               3.81
binutils               2.22
util-linux             2.20.1
mount                  support
module-init-tools      3.16
e2fsprogs              1.42
pcmciautils            018
PPP                    2.4.5
Linux C Library        2.15
Dynamic linker (ldd)   2.15
Procps                 3.2.8
Net-tools              1.60
Kbd                    1.15.2
Sh-utils               8.13
wireless-tools         30
Modules Loaded         bnep rfcomm parport_pc ppdev ext2
snd_hda_codec_hdmi arc4 uvcvideo snd_hda_codec_idt videobuf2_core
rt2800pci rt2x00mmio videodev rt2800lib usbhid crc_ccitt
videobuf2_vmalloc snd_hda_intel hid rt2x00pci wacom snd_hda_codec
rt2x00lib videobuf2_memops btusb bluetooth mac80211 radeon i915
snd_hwdep snd_pcm snd_seq_midi snd_rawmidi cfg80211 ttm psmouse
snd_seq_midi_event snd_seq mei_me snd_timer snd_seq_device
drm_kms_helper snd drm joydev mei soundcore intel_ips hp_accel hp_wmi
sparse_keymap i2c_algo_bit wmi lpc_ich serio_raw eeprom_93cx6
snd_page_alloc lis3lv02d video mac_hid input_polldev lp parport ahci
libahci r8169 mii

[7.2]. processor information from /proc/cpuinfo
processor    : 0
vendor_id    : GenuineIntel
cpu family    : 6
model        : 37
model name    : Intel(R) Core(TM) i5 CPU       U 470  @ 1.33GHz
stepping    : 5
microcode    : 0x2
cpu MHz        : 666.000
cache size    : 3072 KB
physical id    : 0
siblings    : 4
core id        : 0
cpu cores    : 2
apicid        : 0
initial apicid    : 0
fpu        : yes
fpu_exception    : yes
cpuid level    : 11
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall
nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
nonstop_tsc aperfmperf pni dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16
xtpr pdcm pcid sse4_1 sse4_2 popcnt lahf_lm ida arat dtherm tpr_shadow
vnmi flexpriority ept vpid
bogomips    : 2660.02
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 1
vendor_id    : GenuineIntel
cpu family    : 6
model        : 37
model name    : Intel(R) Core(TM) i5 CPU       U 470  @ 1.33GHz
stepping    : 5
microcode    : 0x2
cpu MHz        : 666.000
cache size    : 3072 KB
physical id    : 0
siblings    : 4
core id        : 0
cpu cores    : 2
apicid        : 1
initial apicid    : 1
fpu        : yes
fpu_exception    : yes
cpuid level    : 11
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall
nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
nonstop_tsc aperfmperf pni dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16
xtpr pdcm pcid sse4_1 sse4_2 popcnt lahf_lm ida arat dtherm tpr_shadow
vnmi flexpriority ept vpid
bogomips    : 2660.02
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 2
vendor_id    : GenuineIntel
cpu family    : 6
model        : 37
model name    : Intel(R) Core(TM) i5 CPU       U 470  @ 1.33GHz
stepping    : 5
microcode    : 0x2
cpu MHz        : 666.000
cache size    : 3072 KB
physical id    : 0
siblings    : 4
core id        : 2
cpu cores    : 2
apicid        : 4
initial apicid    : 4
fpu        : yes
fpu_exception    : yes
cpuid level    : 11
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall
nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
nonstop_tsc aperfmperf pni dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16
xtpr pdcm pcid sse4_1 sse4_2 popcnt lahf_lm ida arat dtherm tpr_shadow
vnmi flexpriority ept vpid
bogomips    : 2660.02
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 3
vendor_id    : GenuineIntel
cpu family    : 6
model        : 37
model name    : Intel(R) Core(TM) i5 CPU       U 470  @ 1.33GHz
stepping    : 5
microcode    : 0x2
cpu MHz        : 666.000
cache size    : 3072 KB
physical id    : 0
siblings    : 4
core id        : 2
cpu cores    : 2
apicid        : 5
initial apicid    : 5
fpu        : yes
fpu_exception    : yes
cpuid level    : 11
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall
nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
nonstop_tsc aperfmperf pni dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16
xtpr pdcm pcid sse4_1 sse4_2 popcnt lahf_lm ida arat dtherm tpr_shadow
vnmi flexpriority ept vpid
bogomips    : 2660.02
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

[7.3]. Moduel information from /proc/modules
hid_generic 12548 0 - Live 0x0000000000000000
bnep 23966 2 - Live 0x0000000000000000
rfcomm 74589 12 - Live 0x0000000000000000
parport_pc 32866 0 - Live 0x0000000000000000
ppdev 17711 0 - Live 0x0000000000000000
ext2 73792 1 - Live 0x0000000000000000
snd_hda_codec_hdmi 41688 1 - Live 0x0000000000000000
arc4 12573 2 - Live 0x0000000000000000
uvcvideo 82247 0 - Live 0x0000000000000000
snd_hda_codec_idt 55053 1 - Live 0x0000000000000000
videobuf2_core 40785 1 uvcvideo, Live 0x0000000000000000
rt2800pci 18966 0 - Live 0x0000000000000000
rt2x00mmio 13661 1 rt2800pci, Live 0x0000000000000000
videodev 138443 2 uvcvideo,videobuf2_core, Live 0x0000000000000000
rt2800lib 81942 1 rt2800pci, Live 0x0000000000000000
usbhid 53329 0 - Live 0x0000000000000000
crc_ccitt 12707 1 rt2800lib, Live 0x0000000000000000
videobuf2_vmalloc 13216 1 uvcvideo, Live 0x0000000000000000
snd_hda_intel 48717 5 - Live 0x0000000000000000
hid 105557 2 hid_generic,usbhid, Live 0x0000000000000000
rt2x00pci 13287 1 rt2800pci, Live 0x0000000000000000
wacom 63248 0 - Live 0x0000000000000000
snd_hda_codec 194727 3
snd_hda_codec_hdmi,snd_hda_codec_idt,snd_hda_intel, Live 0x0000000000000000
rt2x00lib 56109 4 rt2800pci,rt2x00mmio,rt2800lib,rt2x00pci, Live
0x0000000000000000
videobuf2_memops 13362 1 videobuf2_vmalloc, Live 0x0000000000000000
btusb 28277 0 - Live 0x0000000000000000
bluetooth 391564 24 bnep,rfcomm,btusb, Live 0x0000000000000000
mac80211 619047 3 rt2800lib,rt2x00pci,rt2x00lib, Live 0x0000000000000000
radeon 1437836 0 - Live 0x0000000000000000
i915 678682 8 - Live 0x0000000000000000
snd_hwdep 13613 1 snd_hda_codec, Live 0x0000000000000000
snd_pcm 107140 3 snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec, Live
0x0000000000000000
snd_seq_midi 13324 0 - Live 0x0000000000000000
snd_rawmidi 30416 1 snd_seq_midi, Live 0x0000000000000000
cfg80211 494624 2 rt2x00lib,mac80211, Live 0x0000000000000000
ttm 84705 1 radeon, Live 0x0000000000000000
psmouse 104015 0 - Live 0x0000000000000000
snd_seq_midi_event 14899 1 snd_seq_midi, Live 0x0000000000000000
snd_seq 66061 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
mei_me 18539 0 - Live 0x0000000000000000
snd_timer 29989 2 snd_pcm,snd_seq, Live 0x0000000000000000
snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live
0x0000000000000000
drm_kms_helper 53178 2 radeon,i915, Live 0x0000000000000000
snd 69657 21
snd_hda_codec_hdmi,snd_hda_codec_idt,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_seq_midi,snd_rawmidi,snd_seq,snd_timer,snd_seq_device,
Live 0x0000000000000000
drm 298236 6 radeon,i915,ttm,drm_kms_helper, Live 0x0000000000000000
joydev 17613 0 - Live 0x0000000000000000
mei 78448 1 mei_me, Live 0x0000000000000000
soundcore 12680 1 snd, Live 0x0000000000000000
intel_ips 18520 0 - Live 0x0000000000000000
hp_accel 26012 0 - Live 0x0000000000000000
hp_wmi 18202 0 - Live 0x0000000000000000
sparse_keymap 13890 1 hp_wmi, Live 0x0000000000000000
i2c_algo_bit 13564 2 radeon,i915, Live 0x0000000000000000
wmi 19256 1 hp_wmi, Live 0x0000000000000000
lpc_ich 21163 0 - Live 0x0000000000000000
serio_raw 13413 0 - Live 0x0000000000000000
eeprom_93cx6 13344 1 rt2800pci, Live 0x0000000000000000
snd_page_alloc 18798 2 snd_hda_intel,snd_pcm, Live 0x0000000000000000
lis3lv02d 20280 1 hp_accel, Live 0x0000000000000000
video 19574 1 i915, Live 0x0000000000000000
mac_hid 13253 0 - Live 0x0000000000000000
input_polldev 13896 1 lis3lv02d, Live 0x0000000000000000
lp 17799 0 - Live 0x0000000000000000
parport 42466 3 parport_pc,ppdev,lp, Live 0x0000000000000000
ahci 30063 4 - Live 0x0000000000000000
libahci 32088 1 ahci, Live 0x0000000000000000
r8169 73111 0 - Live 0x0000000000000000
mii 13981 1 r8169, Live 0x0000000000000000

[7.4]. driver and hardware from /proc/ioports and /proc/iomem
/proc/ioports
0000-0cf7 : PCI Bus 0000:00
  0000-001f : dma1
  0020-0021 : pic1
  0040-0043 : timer0
  0050-0053 : timer1
  0060-0060 : keyboard
  0062-0062 : EC data
  0064-0064 : keyboard
  0066-0066 : EC cmd
  0070-0077 : rtc0
  0080-008f : dma page reg
  00a0-00a1 : pic2
  00c0-00df : dma2
  00f0-00ff : fpu
  0400-0403 : ACPI PM1a_EVT_BLK
  0404-0405 : ACPI PM1a_CNT_BLK
  0408-040b : ACPI PM_TMR
  0410-0415 : ACPI CPU throttle
  0420-042f : ACPI GPE0_BLK
  0430-0433 : iTCO_wdt
  0450-0450 : ACPI PM2_CNT_BLK
  0460-047f : iTCO_wdt
  0500-0501 : pnp 00:04
  0680-069f : pnp 00:04
  0700-077f : pnp 00:04
  0800-080f : pnp 00:04
  0810-0813 : pnp 00:04
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
  1000-1fff : PCI Bus 0000:03
  2000-2fff : PCI Bus 0000:02
    2000-20ff : 0000:02:00.0
      2000-20ff : r8169
  3000-3fff : PCI Bus 0000:01
    3000-30ff : 0000:01:00.0
  4000-401f : 0000:00:1f.3
  4020-403f : 0000:00:1f.2
    4020-403f : ahci
  4040-4047 : 0000:00:1f.2
    4040-4047 : ahci
  4048-404f : 0000:00:1f.2
    4048-404f : ahci
  4050-4057 : 0000:00:02.0
  4058-405b : 0000:00:1f.2
    4058-405b : ahci
  405c-405f : 0000:00:1f.2
    405c-405f : ahci
  ffff-ffff : pnp 00:04

/proc/iomem
00000000-00000fff : reserved
00001000-0009cfff : System RAM
0009d000-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000cefff : Video ROM
000e0000-000fffff : reserved
  000f0000-000fffff : System ROM
00100000-9b63efff : System RAM
  01000000-01737753 : Kernel code
  01737754-01d0eabf : Kernel data
  01e70000-01fe2fff : Kernel bss
9b63f000-9b6befff : reserved
9b6bf000-9b7befff : ACPI Non-volatile Storage
9b7bf000-9b7fefff : ACPI Tables
9b7ff000-9b7fffff : System RAM
9b800000-9fffffff : reserved
a0000000-feafffff : PCI Bus 0000:00
  a0000000-afffffff : PCI Bus 0000:01
    a0000000-afffffff : 0000:01:00.0
  b0000000-bfffffff : 0000:00:02.0
  c0000000-c03fffff : 0000:00:02.0
  c0400000-c13fffff : PCI Bus 0000:02
    c0400000-c0403fff : 0000:02:00.0
      c0400000-c0403fff : r8169
    c0404000-c0404fff : 0000:02:00.0
      c0404000-c0404fff : r8169
  c1400000-c23fffff : PCI Bus 0000:03
  c2400000-c33fffff : PCI Bus 0000:03
    c2400000-c240ffff : 0000:03:00.0
      c2400000-c240ffff : 0000:03:00.0
  c3400000-c43fffff : PCI Bus 0000:02
  c4400000-c44fffff : PCI Bus 0000:01
    c4400000-c441ffff : 0000:01:00.0
    c4420000-c4423fff : 0000:01:00.1
      c4420000-c4423fff : ICH HD audio
    c4440000-c445ffff : 0000:01:00.0
  c4500000-c4503fff : 0000:00:1b.0
    c4500000-c4503fff : ICH HD audio
  c4504000-c4504fff : 0000:00:1f.6
    c4504000-c4504fff : ips thermal sensor
  c4505000-c45057ff : 0000:00:1f.2
    c4505000-c45057ff : ahci
  c4505800-c4505bff : 0000:00:1d.0
    c4505800-c4505bff : ehci_hcd
  c4505c00-c4505fff : 0000:00:1a.0
    c4505c00-c4505fff : ehci_hcd
  c4506000-c45060ff : 0000:00:1f.3
  c4506100-c450610f : 0000:00:16.0
    c4506100-c450610f : mei_me
  c4507000-c4507fff : Intel Flush Page
  c4600000-c4600fff : pnp 00:09
  e0000000-efffffff : PCI MMCONFIG 0000 [bus 00-ff]
    e0000000-efffffff : reserved
      e0000000-efffffff : pnp 00:09
feb00000-feb03fff : reserved
fec00000-fec00fff : reserved
  fec00000-fec003ff : IOAPIC 0
fed00000-fed003ff : HPET 0
fed10000-fed13fff : reserved
  fed10000-fed13fff : pnp 00:09
fed18000-fed19fff : reserved
  fed18000-fed18fff : pnp 00:09
  fed19000-fed19fff : pnp 00:09
fed1c000-fed1ffff : reserved
  fed1c000-fed1ffff : pnp 00:09
    fed1f410-fed1f414 : iTCO_wdt
fed20000-fed3ffff : pnp 00:09
fed45000-fed8ffff : pnp 00:09
fee00000-fee00fff : Local APIC
  fee00000-fee00fff : reserved
ffe00000-ffffffff : reserved
100000000-157ffffff : System RAM

[7.5]. PCI information
00:00.0 Host bridge: Intel Corporation Core Processor DRAM Controller
(rev 02)
    Subsystem: Hewlett-Packard Company Device 1486
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR- INTx-
    Latency: 0
    Capabilities: [e0] Vendor Specific Information: Len=0c <?>
    Kernel driver in use: agpgart-intel

00:01.0 PCI bridge: Intel Corporation Core Processor PCI Express x16
Root Port (rev 02) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
    I/O behind bridge: 00003000-00003fff
    Memory behind bridge: c4400000-c44fffff
    Prefetchable memory behind bridge: 00000000a0000000-00000000afffffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [88] Subsystem: Hewlett-Packard Company Device 1486
    Capabilities: [80] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Address: fee0f00c  Data: 4181
    Capabilities: [a0] Express (v2) Root Port (Slot+), MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns,
L1 <1us
            ExtTag- RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr-
TransPend-
        LnkCap:    Port #2, Speed 2.5GT/s, Width x16, ASPM L0s L1,
Latency L0 <256ns, L1 <4us
            ClockPM- Surprise- LLActRep- BwNot+
        LnkCtl:    ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain-
CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x16, TrErr- Train- SlotClk+
DLActive- BWMgmt+ ABWMgmt-
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug-
Surprise-
            Slot #17, PowerLimit 75.000W; Interlock- NoCompl+
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
HPIrq- LinkChg-
            Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+
Interlock-
            Changed: MRL- PresDet+ LinkState-
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
CRSVisible-
        RootCap: CRSVisible-
        RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        DevCap2: Completion Timeout: Not Supported, TimeoutDis- ARIFwd-
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-,
Selectable De-emphasis: -6dB
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB
    Capabilities: [100 v1] Virtual Channel
        Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
        Arb:    Fixed- WRR32- WRR64- WRR128-
        Ctrl:    ArbSelect=Fixed
        Status:    InProgress-
        VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
            Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
            Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=01
            Status:    NegoPending- InProgress-
    Kernel driver in use: pcieport
    Kernel modules: shpchp

00:02.0 VGA compatible controller: Intel Corporation Core Processor
Integrated Graphics Controller (rev 02) (prog-if 00 [VGA controller])
    Subsystem: Hewlett-Packard Company Device 1486
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 44
    Region 0: Memory at c0000000 (64-bit, non-prefetchable) [size=4M]
    Region 2: Memory at b0000000 (64-bit, prefetchable) [size=256M]
    Region 4: I/O ports at 4050 [size=8]
    Expansion ROM at <unassigned> [disabled]
    Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Address: fee0300c  Data: 41e1
    Capabilities: [d0] Power Management version 2
        Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [a4] PCI Advanced Features
        AFCap: TP+ FLR+
        AFCtrl: FLR-
        AFStatus: TP-
    Kernel driver in use: i915
    Kernel modules: i915

00:16.0 Communication controller: Intel Corporation 5 Series/3400 Series
Chipset HECI Controller (rev 06)
    Subsystem: Hewlett-Packard Company Device 1486
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 43
    Region 0: Memory at c4506100 (64-bit, non-prefetchable) [size=16]
    Capabilities: [50] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Address: 00000000fee0f00c  Data: 41d1
    Kernel driver in use: mei_me
    Kernel modules: mei-me

00:1a.0 USB controller: Intel Corporation 5 Series/3400 Series Chipset
USB2 Enhanced Host Controller (rev 05) (prog-if 20 [EHCI])
    Subsystem: Hewlett-Packard Company Device 1486
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 16
    Region 0: Memory at c4505c00 (32-bit, non-prefetchable) [size=1K]
    Capabilities: [50] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME+
    Capabilities: [58] Debug port: BAR=1 offset=00a0
    Capabilities: [98] PCI Advanced Features
        AFCap: TP+ FLR+
        AFCtrl: FLR-
        AFStatus: TP-
    Kernel driver in use: ehci-pci

00:1b.0 Audio device: Intel Corporation 5 Series/3400 Series Chipset
High Definition Audio (rev 05)
    Subsystem: Hewlett-Packard Company Device 1486
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 45
    Region 0: Memory at c4500000 (64-bit, non-prefetchable) [size=16K]
    Capabilities: [50] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Address: 00000000fee0c00c  Data: 4142
    Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns,
L1 <1us
            ExtTag- RBE- FLReset+
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+
TransPend-
        LnkCap:    Port #0, Speed unknown, Width x0, ASPM unknown,
Latency L0 <64ns, L1 <1us
            ClockPM- Surprise- LLActRep- BwNot-
        LnkCtl:    ASPM Disabled; Disabled- Retrain- CommClk-
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed unknown, Width x0, TrErr- Train- SlotClk-
DLActive- BWMgmt- ABWMgmt-
    Capabilities: [100 v1] Virtual Channel
        Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
        Arb:    Fixed- WRR32- WRR64- WRR128-
        Ctrl:    ArbSelect=Fixed
        Status:    InProgress-
        VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
            Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
            Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=01
            Status:    NegoPending- InProgress-
        VC1:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
            Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
            Ctrl:    Enable+ ID=1 ArbSelect=Fixed TC/VC=02
            Status:    NegoPending- InProgress-
    Capabilities: [130 v1] Root Complex Link
        Desc:    PortNumber=0f ComponentID=00 EltType=Config
        Link0:    Desc:    TargetPort=00 TargetComponent=00 AssocRCRB-
LinkType=MemMapped LinkValid+
            Addr:    00000000fed1c000
    Kernel driver in use: snd_hda_intel
    Kernel modules: snd-hda-intel

00:1c.0 PCI bridge: Intel Corporation 5 Series/3400 Series Chipset PCI
Express Root Port 1 (rev 05) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
    I/O behind bridge: 00002000-00002fff
    Memory behind bridge: c3400000-c43fffff
    Prefetchable memory behind bridge: 00000000c0400000-00000000c13fffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns,
L1 <1us
            ExtTag- RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+
TransPend-
        LnkCap:    Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Latency L0 <256ns, L1 <4us
            ClockPM- Surprise- LLActRep+ BwNot-
        LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive+ BWMgmt- ABWMgmt-
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+
Surprise+
            Slot #0, PowerLimit 10.000W; Interlock- NoCompl+
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
HPIrq- LinkChg-
            Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+
Interlock-
            Changed: MRL- PresDet- LinkState-
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
CRSVisible-
        RootCap: CRSVisible-
        RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        DevCap2: Completion Timeout: Range BC, TimeoutDis+ ARIFwd-
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis+ ARIFwd-
        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-,
Selectable De-emphasis: -6dB
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB
    Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
        Address: 00000000  Data: 0000
    Capabilities: [90] Subsystem: Hewlett-Packard Company Device 1486
    Capabilities: [a0] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Kernel driver in use: pcieport
    Kernel modules: shpchp

00:1c.1 PCI bridge: Intel Corporation 5 Series/3400 Series Chipset PCI
Express Root Port 2 (rev 05) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
    I/O behind bridge: 00001000-00001fff
    Memory behind bridge: c2400000-c33fffff
    Prefetchable memory behind bridge: 00000000c1400000-00000000c23fffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns,
L1 <1us
            ExtTag- RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+
TransPend-
        LnkCap:    Port #2, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Latency L0 <256ns, L1 <4us
            ClockPM- Surprise- LLActRep+ BwNot-
        LnkCtl:    ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain-
CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive+ BWMgmt- ABWMgmt-
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+
Surprise+
            Slot #1, PowerLimit 10.000W; Interlock- NoCompl+
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
HPIrq- LinkChg-
            Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+
Interlock-
            Changed: MRL- PresDet+ LinkState+
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
CRSVisible-
        RootCap: CRSVisible-
        RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        DevCap2: Completion Timeout: Range BC, TimeoutDis+ ARIFwd-
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis+ ARIFwd-
        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-,
Selectable De-emphasis: -6dB
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB
    Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
        Address: 00000000  Data: 0000
    Capabilities: [90] Subsystem: Hewlett-Packard Company Device 1486
    Capabilities: [a0] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Kernel driver in use: pcieport
    Kernel modules: shpchp

00:1d.0 USB controller: Intel Corporation 5 Series/3400 Series Chipset
USB2 Enhanced Host Controller (rev 05) (prog-if 20 [EHCI])
    Subsystem: Hewlett-Packard Company Device 1486
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 20
    Region 0: Memory at c4505800 (32-bit, non-prefetchable) [size=1K]
    Capabilities: [50] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [58] Debug port: BAR=1 offset=00a0
    Capabilities: [98] PCI Advanced Features
        AFCap: TP+ FLR+
        AFCtrl: FLR-
        AFStatus: TP-
    Kernel driver in use: ehci-pci

00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev a5)
(prog-if 01 [Subtractive decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Bus: primary=00, secondary=04, subordinate=04, sec-latency=32
    I/O behind bridge: 0000f000-00000fff
    Memory behind bridge: fff00000-000fffff
    Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
    Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [50] Subsystem: Hewlett-Packard Company Device 1486

00:1f.0 ISA bridge: Intel Corporation Mobile 5 Series Chipset LPC
Interface Controller (rev 05)
    Subsystem: Hewlett-Packard Company Device 1486
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Capabilities: [e0] Vendor Specific Information: Len=10 <?>
    Kernel driver in use: lpc_ich
    Kernel modules: lpc_ich

00:1f.2 SATA controller: Intel Corporation 5 Series/3400 Series Chipset
4 port SATA AHCI Controller (rev 05) (prog-if 01 [AHCI 1.0])
    Subsystem: Hewlett-Packard Company Device 1486
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin B routed to IRQ 42
    Region 0: I/O ports at 4048 [size=8]
    Region 1: I/O ports at 405c [size=4]
    Region 2: I/O ports at 4040 [size=8]
    Region 3: I/O ports at 4058 [size=4]
    Region 4: I/O ports at 4020 [size=32]
    Region 5: Memory at c4505000 (32-bit, non-prefetchable) [size=2K]
    Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Address: fee0100c  Data: 41b1
    Capabilities: [70] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold-)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
    Capabilities: [b0] PCI Advanced Features
        AFCap: TP+ FLR+
        AFCtrl: FLR-
        AFStatus: TP-
    Kernel driver in use: ahci
    Kernel modules: ahci

00:1f.3 SMBus: Intel Corporation 5 Series/3400 Series Chipset SMBus
Controller (rev 05)
    Subsystem: Hewlett-Packard Company Device 1486
    Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Interrupt: pin C routed to IRQ 10
    Region 0: Memory at c4506000 (64-bit, non-prefetchable) [size=256]
    Region 4: I/O ports at 4000 [size=32]
    Kernel modules: i2c-i801

00:1f.6 Signal processing controller: Intel Corporation 5 Series/3400
Series Chipset Thermal Subsystem (rev 05)
    Subsystem: Hewlett-Packard Company Device 1486
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 21
    Region 0: Memory at c4504000 (64-bit, non-prefetchable) [size=4K]
    Capabilities: [50] Power Management version 3
        Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
        Address: 00000000  Data: 0000
    Kernel driver in use: intel ips
    Kernel modules: intel_ips

01:00.0 VGA compatible controller: Advanced Micro Devices [AMD] nee ATI
Manhattan [Mobility Radeon HD 5400 Series] (prog-if 00 [VGA controller])
    Subsystem: Hewlett-Packard Company TouchSmart tm2-2050er discrete
GPU (Mobility Radeon HD 5450)
    Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Interrupt: pin A routed to IRQ 16
    Region 0: Memory at a0000000 (64-bit, prefetchable) [size=256M]
    Region 2: Memory at c4400000 (64-bit, non-prefetchable) [size=128K]
    Region 4: I/O ports at 3000 [size=256]
    Expansion ROM at c4440000 [disabled] [size=128K]
    Capabilities: [50] Power Management version 3
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [58] Express (v2) Legacy Endpoint, MSI 00
        DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us,
L1 unlimited
            ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
            RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
            MaxPayload 128 bytes, MaxReadReq 512 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr-
TransPend-
        LnkCap:    Port #0, Speed 2.5GT/s, Width x16, ASPM L0s L1,
Latency L0 <64ns, L1 <1us
            ClockPM- Surprise- LLActRep- BwNot-
        LnkCtl:    ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain-
CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x16, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
        DevCap2: Completion Timeout: Not Supported, TimeoutDis-
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-,
Selectable De-emphasis: -6dB
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB
    Capabilities: [a0] MSI: Enable- Count=1/1 Maskable- 64bit+
        Address: 0000000000000000  Data: 0000
    Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1
Len=010 <?>
    Kernel driver in use: radeon
    Kernel modules: radeon

01:00.1 Audio device: Advanced Micro Devices [AMD] nee ATI Cedar HDMI
Audio [Radeon HD 5400/6300 Series]
    Subsystem: Hewlett-Packard Company Device 1486
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin B routed to IRQ 47
    Region 0: Memory at c4420000 (64-bit, non-prefetchable) [size=16K]
    Capabilities: [50] Power Management version 3
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [58] Express (v2) Legacy Endpoint, MSI 00
        DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us,
L1 unlimited
            ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
            RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
            MaxPayload 128 bytes, MaxReadReq 512 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr-
TransPend-
        LnkCap:    Port #0, Speed 2.5GT/s, Width x16, ASPM L0s L1,
Latency L0 <64ns, L1 <1us
            ClockPM- Surprise- LLActRep- BwNot-
        LnkCtl:    ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain-
CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x16, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
        DevCap2: Completion Timeout: Not Supported, TimeoutDis-
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-,
Selectable De-emphasis: -6dB
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB
    Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Address: 00000000fee0300c  Data: 4162
    Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1
Len=010 <?>
    Kernel driver in use: snd_hda_intel
    Kernel modules: snd-hda-intel

02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL8111/8168B PCI Express Gigabit Ethernet controller (rev 03)
    Subsystem: Hewlett-Packard Company Device 1486
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 41
    Region 0: I/O ports at 2000 [size=256]
    Region 2: Memory at c0404000 (64-bit, prefetchable) [size=4K]
    Region 4: Memory at c0400000 (64-bit, prefetchable) [size=16K]
    Capabilities: [40] Power Management version 3
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Address: 00000000fee0200c  Data: 4191
    Capabilities: [70] Express (v2) Endpoint, MSI 01
        DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s
<512ns, L1 <64us
            ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
            RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 4096 bytes
        DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+
TransPend-
        LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Latency L0 <512ns, L1 <64us
            ClockPM+ Surprise- LLActRep- BwNot-
        LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
        DevCap2: Completion Timeout: Not Supported, TimeoutDis+
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-,
Selectable De-emphasis: -6dB
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB
    Capabilities: [ac] MSI-X: Enable- Count=4 Masked-
        Vector table: BAR=4 offset=00000000
        PBA: BAR=4 offset=00000800
    Capabilities: [cc] Vital Product Data
        Unknown small resource type 00, will not decode more.
    Capabilities: [100 v1] Advanced Error Reporting
        UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
        CESta:    RxErr+ BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
        CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
        AERCap:    First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
    Capabilities: [140 v1] Virtual Channel
        Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
        Arb:    Fixed- WRR32- WRR64- WRR128-
        Ctrl:    ArbSelect=Fixed
        Status:    InProgress-
        VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
            Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
            Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
            Status:    NegoPending- InProgress-
    Capabilities: [160 v1] Device Serial Number 33-00-00-00-68-4c-e0-00
    Kernel driver in use: r8169
    Kernel modules: r8169

03:00.0 Network controller: Ralink corp. RT3090 Wireless 802.11n 1T/1R PCIe
    Subsystem: Hewlett-Packard Company Device 1453
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 46
    Region 0: Memory at c2400000 (32-bit, non-prefetchable) [size=64K]
    Capabilities: [40] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [50] MSI: Enable+ Count=1/32 Maskable- 64bit+
        Address: 00000000fee0f00c  Data: 4152
    Capabilities: [70] Express (v2) Endpoint, MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s
<512ns, L1 unlimited
            ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
            RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 512 bytes
        DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr-
TransPend-
        LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Latency L0 <512ns, L1 <64us
            ClockPM+ Surprise- LLActRep- BwNot-
        LnkCtl:    ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain-
CommClk+
            ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
        DevCap2: Completion Timeout: Not Supported, TimeoutDis+
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis+
        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-,
Selectable De-emphasis: -6dB
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB
    Capabilities: [100 v1] Advanced Error Reporting
        UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
        CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
        CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
        AERCap:    First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
    Capabilities: [140 v1] Device Serial Number 00-00-bd-d0-db-82-2a-e0
    Kernel driver in use: rt2800pci
    Kernel modules: rt2800pci

ff:00.0 Host bridge: Intel Corporation Core Processor QuickPath
Architecture Generic Non-core Registers (rev 05)
    Subsystem: Hewlett-Packard Company Device 1486
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0

ff:00.1 Host bridge: Intel Corporation Core Processor QuickPath
Architecture System Address Decoder (rev 05)
    Subsystem: Hewlett-Packard Company Device 1486
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0

ff:02.0 Host bridge: Intel Corporation Core Processor QPI Link 0 (rev 05)
    Subsystem: Hewlett-Packard Company Device 1486
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0

ff:02.1 Host bridge: Intel Corporation Core Processor QPI Physical 0
(rev 05)
    Subsystem: Hewlett-Packard Company Device 1486
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0

ff:02.2 Host bridge: Intel Corporation Core Processor Reserved (rev 05)
    Subsystem: Hewlett-Packard Company Device 1486
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0

ff:02.3 Host bridge: Intel Corporation Core Processor Reserved (rev 05)
    Subsystem: Hewlett-Packard Company Device 1486
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0

[7.6]. SCSI information
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: WDC WD5000BEKT-6 Rev: 01.0
  Type:   Direct-Access                    ANSI  SCSI revision: 05

[7.7]. Other information
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 1
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 10
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 1016
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 1073
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 1099
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 11
dr-xr-xr-x  9 syslog     syslog                   0 Aug  6 11:26 1136
dr-xr-xr-x  9 messagebus messagebus               0 Aug  6 11:26 1170
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 1177
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 12
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 1207
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 1213
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 1229
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 1232
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 1236
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 1251
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 1252
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 1254
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 1261
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 1264
dr-xr-xr-x  9 daemon     daemon                   0 Aug  6 11:26 1265
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 1267
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 1280
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 1292
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 13
dr-xr-xr-x  9 whoopsie   whoopsie                 0 Aug  6 11:26 1300
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 1315
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 1338
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 1390
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 14
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 1411
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 1491
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 15
dr-xr-xr-x  9 nobody     dip                      0 Aug  6 11:26 1507
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 1581
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 16
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 17
dr-xr-xr-x  9 colord     colord                   0 Aug  6 11:26 1729
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 1743
dr-xr-xr-x  9 rtkit      rtkit                    0 Aug  6 11:26 1784
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 18
dr-xr-xr-x  9 arifogel   arifogel                 0 Aug  6 11:26 1824
dr-xr-xr-x  9 arifogel   arifogel                 0 Aug  6 11:26 1835
dr-xr-xr-x  9 arifogel   arifogel                 0 Aug  6 11:26 1872
dr-xr-xr-x  9 arifogel   arifogel                 0 Aug  6 11:26 1875
dr-xr-xr-x  9 arifogel   arifogel                 0 Aug  6 11:26 1876
dr-xr-xr-x  9 arifogel   arifogel                 0 Aug  6 11:26 1884
dr-xr-xr-x  9 arifogel   arifogel                 0 Aug  6 11:26 1894
dr-xr-xr-x  9 arifogel   arifogel                 0 Aug  6 11:26 1896
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 19
dr-xr-xr-x  9 arifogel   arifogel                 0 Aug  6 11:26 1905
dr-xr-xr-x  9 arifogel   arifogel                 0 Aug  6 11:26 1909
dr-xr-xr-x  9 arifogel   arifogel                 0 Aug  6 11:26 1913
dr-xr-xr-x  9 arifogel   arifogel                 0 Aug  6 11:26 1914
dr-xr-xr-x  9 arifogel   arifogel                 0 Aug  6 11:26 1919
dr-xr-xr-x  9 arifogel   arifogel                 0 Aug  6 11:26 1923
dr-xr-xr-x  9 arifogel   arifogel                 0 Aug  6 11:26 1924
dr-xr-xr-x  9 arifogel   arifogel                 0 Aug  6 11:26 1926
dr-xr-xr-x  9 arifogel   arifogel                 0 Aug  6 11:26 1927
dr-xr-xr-x  9 arifogel   arifogel                 0 Aug  6 11:26 1928
dr-xr-xr-x  9 arifogel   arifogel                 0 Aug  6 11:26 1931
dr-xr-xr-x  9 arifogel   arifogel                 0 Aug  6 11:26 1938
dr-xr-xr-x  9 arifogel   arifogel                 0 Aug  6 11:26 1939
dr-xr-xr-x  9 arifogel   arifogel                 0 Aug  6 11:26 1941
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 1943
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 1944
dr-xr-xr-x  9 arifogel   arifogel                 0 Aug  6 11:26 1961
dr-xr-xr-x  9 arifogel   arifogel                 0 Aug  6 11:26 1967
dr-xr-xr-x  9 arifogel   arifogel                 0 Aug  6 11:26 1969
dr-xr-xr-x  9 arifogel   arifogel                 0 Aug  6 11:26 1971
dr-xr-xr-x  9 arifogel   arifogel                 0 Aug  6 11:26 1972
dr-xr-xr-x  9 arifogel   arifogel                 0 Aug  6 11:26 1973
dr-xr-xr-x  9 arifogel   arifogel                 0 Aug  6 11:26 1974
dr-xr-xr-x  9 arifogel   arifogel                 0 Aug  6 11:26 1975
dr-xr-xr-x  9 arifogel   arifogel                 0 Aug  6 11:26 1977
dr-xr-xr-x  9 arifogel   arifogel                 0 Aug  6 11:26 1993
dr-xr-xr-x  9 arifogel   arifogel                 0 Aug  6 11:26 1994
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 2
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 20
dr-xr-xr-x  9 arifogel   arifogel                 0 Aug  6 11:26 2007
dr-xr-xr-x  9 arifogel   arifogel                 0 Aug  6 11:26 2009
dr-xr-xr-x  9 arifogel   arifogel                 0 Aug  6 11:26 2010
dr-xr-xr-x  9 arifogel   arifogel                 0 Aug  6 11:26 2012
dr-xr-xr-x  9 arifogel   arifogel                 0 Aug  6 11:26 2014
dr-xr-xr-x  9 arifogel   arifogel                 0 Aug  6 11:26 2016
dr-xr-xr-x  9 arifogel   utmp                     0 Aug  6 11:26 2050
dr-xr-xr-x  9 arifogel   arifogel                 0 Aug  6 11:26 2051
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 21
dr-xr-xr-x  9 arifogel   arifogel                 0 Aug  6 11:26 2112
dr-xr-xr-x  9 arifogel   arifogel                 0 Aug  6 11:26 2120
dr-xr-xr-x  9 arifogel   arifogel                 0 Aug  6 11:26 2125
dr-xr-xr-x  9 arifogel   arifogel                 0 Aug  6 11:26 2128
dr-xr-xr-x  9 arifogel   arifogel                 0 Aug  6 11:26 2132
dr-xr-xr-x  9 arifogel   arifogel                 0 Aug  6 11:26 2137
dr-xr-xr-x  9 arifogel   arifogel                 0 Aug  6 11:26 2139
dr-xr-xr-x  9 arifogel   arifogel                 0 Aug  6 11:26 2140
dr-xr-xr-x  9 arifogel   arifogel                 0 Aug  6 11:26 2162
dr-xr-xr-x  9 arifogel   arifogel                 0 Aug  6 11:26 2184
dr-xr-xr-x  9 root       smmsp                    0 Aug  6 11:27 2199
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 22
dr-xr-xr-x  9 root       root                     0 Aug  6 11:33 2291
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 23
dr-xr-xr-x  9 arifogel   arifogel                 0 Aug  6 11:27 2300
dr-xr-xr-x  9 arifogel   arifogel                 0 Aug  6 11:30 2332
dr-xr-xr-x  9 arifogel   arifogel                 0 Aug  6 11:30 2336
dr-xr-xr-x  9 arifogel   arifogel                 0 Aug  6 11:30 2360
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 24
dr-xr-xr-x  9 root       root                     0 Aug  6 11:33 2417
dr-xr-xr-x  9 root       root                     0 Aug  6 11:43 2439
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 25
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 251
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 254
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 255
dr-xr-xr-x  9 root       root                     0 Aug  6 11:43 2573
dr-xr-xr-x  9 root       root                     0 Aug  6 11:43 2576
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 258
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 26
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 260
dr-xr-xr-x  9 root       root                     0 Aug  6 11:43 2602
dr-xr-xr-x  9 arifogel   arifogel                 0 Aug  6 11:43 2617
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 262
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 27
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 28
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 284
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 29
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 3
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 30
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 301
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 302
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 303
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 31
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 33
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 34
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 35
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 36
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 37
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 38
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 39
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 394
dr-xr-xr-x  9 root       root                     0 Aug  6 11:25 396
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 40
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 41
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 42
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 43
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 44
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 45
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 46
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 47
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 48
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 5
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 51
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 52
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 53
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 54
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 55
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 56
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 57
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 68
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 7
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 70
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 73
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 768
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 769
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 8
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 806
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 837
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 838
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 839
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 840
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 860
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 865
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 866
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 9
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 92
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 925
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 926
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 927
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 93
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 94
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 947
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 948
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 985
dr-xr-xr-x  9 root       root                     0 Aug  6 11:26 999
dr-xr-xr-x  3 root       root                     0 Aug  6 11:26 acpi
dr-xr-xr-x  5 root       root                     0 Aug  6 11:43 asound
-r--r--r--  1 root       root                     0 Aug  6 11:43 buddyinfo
dr-xr-xr-x  4 root       root                     0 Aug  6 11:43 bus
-r--r--r--  1 root       root                     0 Aug  6 11:43 cgroups
-r--r--r--  1 root       root                     0 Aug  6 11:43 cmdline
-r--r--r--  1 root       root                     0 Aug  6 11:43 consoles
-r--r--r--  1 root       root                     0 Aug  6 11:43 cpuinfo
-r--r--r--  1 root       root                     0 Aug  6 11:43 crypto
-r--r--r--  1 root       root                     0 Aug  6 11:43 devices
-r--r--r--  1 root       root                     0 Aug  6 11:43 diskstats
-r--r--r--  1 root       root                     0 Aug  6 11:43 dma
dr-xr-xr-x  4 root       root                     0 Aug  6 11:43 dri
dr-xr-xr-x  2 root       root                     0 Aug  6 11:43 driver
-r--r--r--  1 root       root                     0 Aug  6 11:43 execdomains
-r--r--r--  1 root       root                     0 Aug  6 11:43 fb
-r--r--r--  1 root       root                     0 Aug  6 11:43 filesystems
dr-xr-xr-x  5 root       root                     0 Aug  6 11:43 fs
-r--r--r--  1 root       root                     0 Aug  6 11:43 interrupts
-r--r--r--  1 root       root                     0 Aug  6 11:43 iomem
-r--r--r--  1 root       root                     0 Aug  6 11:43 ioports
dr-xr-xr-x 28 root       root                     0 Aug  6 11:43 irq
-r--r--r--  1 root       root                     0 Aug  6 11:43 kallsyms
-r--------  1 root       root       140737486266368 Aug  6 11:43 kcore
-r--r--r--  1 root       root                     0 Aug  6 11:43 key-users
-r--------  1 root       root                     0 Aug  6 11:26 kmsg
-r--------  1 root       root                     0 Aug  6 11:43 kpagecount
-r--------  1 root       root                     0 Aug  6 11:43 kpageflags
-rw-r--r--  1 root       root                     0 Aug  6 11:43
latency_stats
-r--r--r--  1 root       root                     0 Aug  6 11:43 loadavg
-r--r--r--  1 root       root                     0 Aug  6 11:43 locks
-r--r--r--  1 root       root                     0 Aug  6 11:26 mdstat
-r--r--r--  1 root       root                     0 Aug  6 11:43 meminfo
-r--r--r--  1 root       root                     0 Aug  6 11:43 misc
-r--r--r--  1 root       root                     0 Aug  6 11:43 modules
lrwxrwxrwx  1 root       root                    11 Aug  6 11:43 mounts
-> self/mounts
-rw-r--r--  1 root       root                     0 Aug  6 11:26 mtrr
lrwxrwxrwx  1 root       root                     8 Aug  6 11:43 net ->
self/net
-r--r--r--  1 root       root                     0 Aug  6 11:43
pagetypeinfo
-r--r--r--  1 root       root                     0 Aug  6 11:43 partitions
-r--r--r--  1 root       root                     0 Aug  6 11:43 sched_debug
-r--r--r--  1 root       root                     0 Aug  6 11:43 schedstat
dr-xr-xr-x  3 root       root                     0 Aug  6 11:43 scsi
lrwxrwxrwx  1 root       root                     0 Aug  6 04:25 self ->
2617
-r--------  1 root       root                     0 Aug  6 11:43 slabinfo
-r--r--r--  1 root       root                     0 Aug  6 11:43 softirqs
-r--r--r--  1 root       root                     0 Aug  6 11:43 stat
-r--r--r--  1 root       root                     0 Aug  6 11:43 swaps
dr-xr-xr-x  1 root       root                     0 Aug  6 04:25 sys
--w-------  1 root       root                     0 Aug  6 11:43
sysrq-trigger
dr-xr-xr-x  2 root       root                     0 Aug  6 11:43 sysvipc
-r--r--r--  1 root       root                     0 Aug  6 11:43 timer_list
-rw-r--r--  1 root       root                     0 Aug  6 11:43 timer_stats
dr-xr-xr-x  4 root       root                     0 Aug  6 11:43 tty
-r--r--r--  1 root       root                     0 Aug  6 11:43 uptime
-r--r--r--  1 root       root                     0 Aug  6 11:43 version
-r--------  1 root       root                     0 Aug  6 11:43 vmallocinfo
-r--r--r--  1 root       root                     0 Aug  6 11:43 vmstat
-r--r--r--  1 root       root                     0 Aug  6 11:43 zoneinfo

[X].
I don't understand what debugging information is being asked for.
Comments:
In the downstream report linked here, when I was asked to do hotkey
troubleshooting, I did that on a different computer at the time. All
other tests were done on this computer. The results for that particular
test are the same for this computer (the one from which all of the other
information, including that in this email, was produced).
Final meta-summary:
Six keys on the microsoft wireless comfort desktop 5000 keyboard are not
detectable in any way using methods described in the downstream report.
