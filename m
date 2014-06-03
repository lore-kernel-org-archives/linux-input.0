From: =?iso-8859-1?q?Rapha=EBl?= HUCK <raphael.huck@gmail.com>
Subject: [PROBLEM] Asus X450CC touchpad not working
Date: Tue, 3 Jun 2014 14:06:08 +0200
Message-ID: <20140603140608.3435f3ae@satellite>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp22.services.sfr.fr ([93.17.128.11]:37459 "EHLO
	smtp22.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755216AbaFCMGP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Jun 2014 08:06:15 -0400
Received: from filter.sfr.fr (localhost [77.196.17.169])
	by msfrf2208.sfr.fr (SMTP Server) with ESMTP id 553B570000EF
	for <linux-input@vger.kernel.org>; Tue,  3 Jun 2014 14:06:12 +0200 (CEST)
Received: from satellite (169.17.196.77.rev.sfr.net [77.196.17.169])
	by msfrf2208.sfr.fr (SMTP Server) with ESMTP id 83DD670000EC
	for <linux-input@vger.kernel.org>; Tue,  3 Jun 2014 14:06:11 +0200 (CEST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

the touchpad of my Asus X450CC doesn't work at all under a fresh
install of Xubuntu 14.04 with upstream kernel 3.15-rc7. However, it doe=
s
work without problems on Windows 7. I have to use an external mouse
"Logitech G500" to be able to control the mouse pointer.

-Rapha=C3=ABl

$ cat /proc/version
Linux version 3.15.0-031500rc7-generic (apw@gomeisa) (gcc version 4.6.3
(Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201405251935 SMP Sun May 25 23:36:23
UTC 2014

$ lsb_release -rd
Description:    Ubuntu 14.04 LTS
Release:        14.04

$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 58
model name      : Intel(R) Core(TM) i3-3217U CPU @ 1.80GHz
stepping        : 9
microcode       : 0x15
cpu MHz         : 1733.625
cache size      : 3072 KB
physical id     : 0
siblings        : 4
core id         : 0
cpu cores       : 2
apicid          : 0
initial apicid  : 0
fpu             : yes
fpu_exception   : yes
cpuid level     : 13
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr
pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor
ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic
popcnt tsc_deadline_timer xsave avx f16c lahf_lm ida arat epb xsaveopt
pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase smep erms
bogomips        : 3591.90
clflush size    : 64
cache_alignment : 64
address sizes   : 36 bits physical, 48 bits virtual
power management:

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 58
model name      : Intel(R) Core(TM) i3-3217U CPU @ 1.80GHz
stepping        : 9
microcode       : 0x15
cpu MHz         : 1649.250
cache size      : 3072 KB
physical id     : 0
siblings        : 4
core id         : 1
cpu cores       : 2
apicid          : 2
initial apicid  : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 13
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr
pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor
ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic
popcnt tsc_deadline_timer xsave avx f16c lahf_lm ida arat epb xsaveopt
pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase smep erms
bogomips        : 3591.90
clflush size    : 64
cache_alignment : 64
address sizes   : 36 bits physical, 48 bits virtual
power management:

processor       : 2
vendor_id       : GenuineIntel
cpu family      : 6
model           : 58
model name      : Intel(R) Core(TM) i3-3217U CPU @ 1.80GHz
stepping        : 9
microcode       : 0x15
cpu MHz         : 1677.375
cache size      : 3072 KB
physical id     : 0
siblings        : 4
core id         : 0
cpu cores       : 2
apicid          : 1
initial apicid  : 1
fpu             : yes
fpu_exception   : yes
cpuid level     : 13
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr
pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor
ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic
popcnt tsc_deadline_timer xsave avx f16c lahf_lm ida arat epb xsaveopt
pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase smep erms
bogomips        : 3591.90
clflush size    : 64
cache_alignment : 64
address sizes   : 36 bits physical, 48 bits virtual
power management:

processor       : 3
vendor_id       : GenuineIntel
cpu family      : 6
model           : 58
model name      : Intel(R) Core(TM) i3-3217U CPU @ 1.80GHz
stepping        : 9
microcode       : 0x15
cpu MHz         : 1593.000
cache size      : 3072 KB
physical id     : 0
siblings        : 4
core id         : 1
cpu cores       : 2
apicid          : 3
initial apicid  : 3
fpu             : yes
fpu_exception   : yes
cpuid level     : 13
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr
pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor
ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic
popcnt tsc_deadline_timer xsave avx f16c lahf_lm ida arat epb xsaveopt
pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase smep erms
bogomips        : 3591.90
clflush size    : 64
cache_alignment : 64
address sizes   : 36 bits physical, 48 bits virtual
power management:

$ cat /proc/modules
ctr 13193 2 - Live 0x0000000000000000
ccm 17856 2 - Live 0x0000000000000000
bnep 19884 2 - Live 0x0000000000000000
rfcomm 75078 0 - Live 0x0000000000000000
bluetooth 461775 10 bnep,rfcomm, Live 0x0000000000000000
6lowpan_iphc 18968 1 bluetooth, Live 0x0000000000000000
nls_iso8859_1 12713 1 - Live 0x0000000000000000
snd_hda_codec_hdmi 48229 1 - Live 0x0000000000000000
snd_hda_codec_realtek 72529 1 - Live 0x0000000000000000
snd_hda_codec_generic 70087 1 snd_hda_codec_realtek, Live 0x00000000000=
00000
asus_nb_wmi 16990 0 - Live 0x0000000000000000
uvcvideo 82299 0 - Live 0x0000000000000000
asus_wmi 24697 1 asus_nb_wmi, Live 0x0000000000000000
sparse_keymap 13890 1 asus_wmi, Live 0x0000000000000000
videobuf2_vmalloc 13216 1 uvcvideo, Live 0x0000000000000000
videobuf2_memops 13362 1 videobuf2_vmalloc, Live 0x0000000000000000
intel_rapl 19238 0 - Live 0x0000000000000000
videobuf2_core 45435 1 uvcvideo, Live 0x0000000000000000
videodev 149504 2 uvcvideo,videobuf2_core, Live 0x0000000000000000
arc4 12573 2 - Live 0x0000000000000000
x86_pkg_temp_thermal 14312 0 - Live 0x0000000000000000
intel_powerclamp 19099 0 - Live 0x0000000000000000
joydev 17587 0 - Live 0x0000000000000000
rt2800pci 13674 0 - Live 0x0000000000000000
rt2800mmio 21082 1 rt2800pci, Live 0x0000000000000000
rt2800lib 95492 2 rt2800pci,rt2800mmio, Live 0x0000000000000000
nouveau 1212985 1 - Live 0x0000000000000000
coretemp 13638 0 - Live 0x0000000000000000
rt2x00pci 13287 1 rt2800pci, Live 0x0000000000000000
snd_hda_intel 30608 3 - Live 0x0000000000000000
snd_hda_controller 35518 1 snd_hda_intel, Live 0x0000000000000000
rt2x00mmio 13661 2 rt2800pci,rt2800mmio, Live 0x0000000000000000
kvm_intel 148919 0 - Live 0x0000000000000000
mxm_wmi 13021 1 nouveau, Live 0x0000000000000000
kvm 463808 1 kvm_intel, Live 0x0000000000000000
rt2x00lib 56125 5 rt2800pci,rt2800mmio,rt2800lib,rt2x00pci,rt2x00mmio, =
Live 0x0000000000000000
ttm 90341 1 nouveau, Live 0x0000000000000000
snd_hda_codec 144671 5 snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda=
_codec_generic,snd_hda_intel,snd_hda_controller, Live 0x000000000000000=
0
mac80211 663883 3 rt2800lib,rt2x00pci,rt2x00lib, Live 0x000000000000000=
0
snd_hwdep 13613 1 snd_hda_codec, Live 0x0000000000000000
snd_pcm 113863 4 snd_hda_codec_hdmi,snd_hda_intel,snd_hda_controller,sn=
d_hda_codec, Live 0x0000000000000000
crct10dif_pclmul 14268 0 - Live 0x0000000000000000
crc32_pclmul 13180 0 - Live 0x0000000000000000
i915 873516 3 - Live 0x0000000000000000
snd_seq_midi 13564 0 - Live 0x0000000000000000
ghash_clmulni_intel 13230 0 - Live 0x0000000000000000
snd_seq_midi_event 14899 1 snd_seq_midi, Live 0x0000000000000000
snd_rawmidi 30865 1 snd_seq_midi, Live 0x0000000000000000
cryptd 20531 1 ghash_clmulni_intel, Live 0x0000000000000000
cfg80211 515506 2 rt2x00lib,mac80211, Live 0x0000000000000000
drm_kms_helper 59729 2 nouveau,i915, Live 0x0000000000000000
snd_seq 67636 2 snd_seq_midi,snd_seq_midi_event, Live 0x000000000000000=
0
eeprom_93cx6 13344 1 rt2800pci, Live 0x0000000000000000
mei_me 18562 0 - Live 0x0000000000000000
snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x0000000=
000000000
crc_ccitt 12707 1 rt2800lib, Live 0x0000000000000000
snd_timer 30118 2 snd_pcm,snd_seq, Live 0x0000000000000000
drm 310655 8 nouveau,ttm,i915,drm_kms_helper, Live 0x0000000000000000
snd 74195 17 snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_gen=
eric,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,=
snd_seq_device,snd_timer, Live 0x0000000000000000
mei 87522 1 mei_me, Live 0x0000000000000000
i2c_algo_bit 13564 2 nouveau,i915, Live 0x0000000000000000
soundcore 12680 2 snd_hda_codec,snd, Live 0x0000000000000000
microcode 24391 0 - Live 0x0000000000000000
rtsx_pci_ms 18337 0 - Live 0x0000000000000000
lpc_ich 21176 0 - Live 0x0000000000000000
memstick 16968 1 rtsx_pci_ms, Live 0x0000000000000000
mac_hid 13275 0 - Live 0x0000000000000000
video 19932 3 asus_wmi,nouveau,i915, Live 0x0000000000000000
wmi 19379 3 asus_wmi,nouveau,mxm_wmi, Live 0x0000000000000000
serio_raw 13483 0 - Live 0x0000000000000000
parport_pc 32906 0 - Live 0x0000000000000000
ppdev 17711 0 - Live 0x0000000000000000
lp 17799 0 - Live 0x0000000000000000
parport 42481 3 parport_pc,ppdev,lp, Live 0x0000000000000000
hid_generic 12559 0 - Live 0x0000000000000000
usbhid 53121 0 - Live 0x0000000000000000
hid 106436 2 hid_generic,usbhid, Live 0x0000000000000000
rtsx_pci_sdmmc 23482 0 - Live 0x0000000000000000
psmouse 113320 0 - Live 0x0000000000000000
ahci 30167 3 - Live 0x0000000000000000
r8169 73316 0 - Live 0x0000000000000000
rtsx_pci 46393 2 rtsx_pci_ms,rtsx_pci_sdmmc, Live 0x0000000000000000
libahci 32191 1 ahci, Live 0x0000000000000000
mii 13981 1 r8169, Live 0x0000000000000000

$ cat /proc/ioports
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
  0454-0457 : pnp 00:06
  0458-047f : pnp 00:04
    0460-047f : iTCO_wdt
  04d0-04d1 : pnp 00:07
  0500-057f : pnp 00:04
  0680-069f : pnp 00:04
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
  1000-100f : pnp 00:04
  164e-164f : pnp 00:04
  d000-dfff : PCI Bus 0000:04
    d000-d0ff : 0000:04:00.2
      d000-d0ff : r8169
  e000-efff : PCI Bus 0000:01
    e000-e07f : 0000:01:00.0
  f000-f03f : 0000:00:02.0
  f040-f05f : 0000:00:1f.3
  f060-f07f : 0000:00:1f.2
    f060-f07f : ahci
  f080-f083 : 0000:00:1f.2
    f080-f083 : ahci
  f090-f097 : 0000:00:1f.2
    f090-f097 : ahci
  f0a0-f0a3 : 0000:00:1f.2
    f0a0-f0a3 : ahci
  f0b0-f0b7 : 0000:00:1f.2
    f0b0-f0b7 : ahci
  ffff-ffff : pnp 00:04
    ffff-ffff : pnp 00:04

$ cat /proc/iomem
00000000-00000fff : reserved
00001000-0009efff : System RAM
0009f000-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000cefff : Video ROM
000cf000-000cffff : Adapter ROM
000d4000-000d7fff : PCI Bus 0000:00
000d8000-000dbfff : PCI Bus 0000:00
000dc000-000dffff : PCI Bus 0000:00
000f0000-000fffff : System ROM
00100000-1fffffff : System RAM
  01000000-0177cd98 : Kernel code
  0177cd99-01d1ef7f : Kernel data
  01e7b000-01fe0fff : Kernel bss
20000000-201fffff : reserved
  20000000-201fffff : pnp 00:0d
20200000-40003fff : System RAM
40004000-40004fff : reserved
  40004000-40004fff : pnp 00:0d
40005000-c9788fff : System RAM
c9789000-c9d89fff : ACPI Non-volatile Storage
c9d8a000-c9d8cfff : reserved
c9d8d000-c9da3fff : System RAM
c9da4000-c9da9fff : reserved
c9daa000-c9f16fff : System RAM
c9f17000-c9f1afff : reserved
c9f1b000-c9f65fff : System RAM
c9f66000-c9f6cfff : reserved
c9f6d000-c9f79fff : reserved
c9f7a000-c9f8bfff : reserved
c9f8c000-c9f8efff : System RAM
c9f8f000-c9f90fff : reserved
c9f91000-c9fa7fff : System RAM
c9fa8000-c9fadfff : reserved
c9fae000-c9fb5fff : System RAM
c9fb6000-c9fb6fff : reserved
c9fb7000-c9fc5fff : System RAM
c9fc6000-c9fc6fff : reserved
c9fc7000-c9fd1fff : System RAM
c9fd2000-c9fd6fff : reserved
c9fd7000-ca003fff : System RAM
ca004000-ca004fff : reserved
ca005000-ca014fff : System RAM
ca015000-ca03bfff : reserved
ca03c000-ca04efff : System RAM
ca04f000-ca04ffff : reserved
ca050000-ca050fff : System RAM
ca051000-ca052fff : reserved
ca053000-ca053fff : System RAM
ca054000-ca058fff : reserved
ca059000-ca06ffff : System RAM
ca070000-ca0cffff : reserved
ca0d0000-ca0eafff : reserved
ca0eb000-ca614fff : reserved
ca615000-ca894fff : ACPI Non-volatile Storage
ca895000-ca899fff : ACPI Tables
ca89a000-ca89afff : System RAM
ca89b000-ca8ddfff : ACPI Non-volatile Storage
ca8de000-cad01fff : System RAM
cad02000-caff3fff : reserved
caff4000-caffffff : System RAM
cb000000-cbbfffff : RAM buffer
cbc00000-cfdfffff : reserved
  cbe00000-cfdfffff : Graphics Stolen Memory
cfe00000-feafffff : PCI Bus 0000:00
  cfe00000-cfe00fff : pnp 00:0b
    cfe00000-cfe00fff : pnp 00:0c
  d0000000-dfffffff : 0000:00:02.0
  e0000000-f1ffffff : PCI Bus 0000:01
    e0000000-efffffff : 0000:01:00.0
    f0000000-f1ffffff : 0000:01:00.0
  f2100000-f21fffff : PCI Bus 0000:04
    f2100000-f2103fff : 0000:04:00.2
      f2100000-f2103fff : r8169
  f6000000-f70fffff : PCI Bus 0000:01
    f6000000-f6ffffff : 0000:01:00.0
    f7000000-f707ffff : 0000:01:00.0
  f7400000-f77fffff : 0000:00:02.0
  f7800000-f78fffff : PCI Bus 0000:04
    f7800000-f780ffff : 0000:04:00.0
      f7800000-f780ffff : rtsx_pci
    f7810000-f7810fff : 0000:04:00.2
      f7810000-f7810fff : r8169
  f7900000-f79fffff : PCI Bus 0000:03
    f7900000-f790ffff : 0000:03:00.1
    f7910000-f791ffff : 0000:03:00.0
      f7910000-f791ffff : 0000:03:00.0
  f7a00000-f7a0ffff : 0000:00:14.0
    f7a00000-f7a0ffff : xhci_hcd
  f7a10000-f7a13fff : 0000:00:1b.0
    f7a10000-f7a13fff : ICH HD audio
  f7a15000-f7a150ff : 0000:00:1f.3
  f7a16000-f7a167ff : 0000:00:1f.2
    f7a16000-f7a167ff : ahci
  f7a17000-f7a173ff : 0000:00:1d.0
    f7a17000-f7a173ff : ehci_hcd
  f7a18000-f7a183ff : 0000:00:1a.0
    f7a18000-f7a183ff : ehci_hcd
  f7a1a000-f7a1a00f : 0000:00:16.0
    f7a1a000-f7a1a00f : mei_me
  f8000000-fbffffff : PCI MMCONFIG 0000 [bus 00-3f]
    f8000000-fbffffff : reserved
      f8000000-fbffffff : pnp 00:0b
fec00000-fec00fff : reserved
  fec00000-fec003ff : IOAPIC 0
fed00000-fed03fff : reserved
  fed00000-fed003ff : HPET 0
fed10000-fed17fff : pnp 00:0b
fed18000-fed18fff : pnp 00:0b
fed19000-fed19fff : pnp 00:0b
fed1c000-fed1ffff : reserved
  fed1c000-fed1ffff : pnp 00:0b
    fed1f410-fed1f414 : iTCO_wdt
fed20000-fed3ffff : pnp 00:0b
fed40000-fed44fff : pnp 00:00
fed45000-fed8ffff : pnp 00:0b
fed90000-fed93fff : pnp 00:0b
fee00000-fee00fff : Local APIC
  fee00000-fee00fff : reserved
ff000000-ffffffff : reserved
  ff000000-ffffffff : pnp 00:0b
100000000-12f1fffff : System RAM
12f200000-12fffffff : RAM buffer

$ sudo lspci -vvv
00:00.0 Host bridge: Intel Corporation 3rd Gen Core processor DRAM Cont=
roller (rev 09)
        Subsystem: ASUSTeK Computer Inc. Device 126d
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- Par=
Err- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort=
- <TAbort- <MAbort+ >SERR- <PERR- INTx-
        Latency: 0
        Capabilities: [e0] Vendor Specific Information: Len=3D0c <?>
        Kernel driver in use: ivb_uncore

00:01.0 PCI bridge: Intel Corporation Xeon E3-1200 v2/3rd Gen Core proc=
essor PCI Express Root Port (rev 09) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- Par=
Err- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort=
- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latenc=
y=3D0
        I/O behind bridge: 0000e000-0000efff
        Memory behind bridge: f6000000-f70fffff
        Prefetchable memory behind bridge: 00000000e0000000-00000000f1f=
fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort=
- <TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [88] Subsystem: ASUSTeK Computer Inc. Device 126d
        Capabilities: [80] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1=
-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 P=
ME-
        Capabilities: [90] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
                Address: fee0f00c  Data: 4161
        Capabilities: [a0] Express (v2) Root Port (Slot+), MSI 00
                DevCap: MaxPayload 256 bytes, PhantFunc 0
                        ExtTag- RBE+
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- U=
nsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 256 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr=
- TransPend-
                LnkCap: Port #2, Speed 5GT/s, Width x16, ASPM L0s L1, E=
xit Latency L0s <256ns, L1 <8us
                        ClockPM- Surprise- LLActRep- BwNot+
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x8, TrErr- Train- SlotClk+=
 DLActive- BWMgmt+ ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug=
- Surprise-
                        Slot #1, PowerLimit 75.000W; Interlock- NoCompl=
+
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-=
 HPIrq- LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown, Power=
- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDe=
t+ Interlock-
                        Changed: MRL- PresDet+ LinkState-
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEInt=
Ena- CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                DevCap2: Completion Timeout: Not Supported, TimeoutDis-=
, LTR-, OBFF Not Supported ARIFwd-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-,=
 LTR-, OBFF Disabled ARIFwd-
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- Spe=
edDis-
                         Transmit Margin: Normal Operating Range, Enter=
ModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB, EqualizationC=
omplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, Link=
EqualizationRequest-
        Capabilities: [100 v1] Virtual Channel
                Caps:   LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
                Arb:    Fixed- WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=3DFixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=3D00 MaxTimeSlots=3D1 RejSnoo=
pTrans-
                        Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- W=
RR256-
                        Ctrl:   Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3D=
ff
                        Status: NegoPending- InProgress-
        Capabilities: [140 v1] Root Complex Link
                Desc:   PortNumber=3D02 ComponentID=3D01 EltType=3DConf=
ig
                Link0:  Desc:   TargetPort=3D00 TargetComponent=3D01 As=
socRCRB- LinkType=3DMemMapped LinkValid+
                        Addr:   00000000fed19000
        Kernel driver in use: pcieport

00:02.0 VGA compatible controller: Intel Corporation 3rd Gen Core proce=
ssor Graphics Controller (rev 09) (prog-if 00 [VGA controller])
        Subsystem: ASUSTeK Computer Inc. Device 126d
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- Par=
Err- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort=
- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 46
        Region 0: Memory at f7400000 (64-bit, non-prefetchable) [size=3D=
4M]
        Region 2: Memory at d0000000 (64-bit, prefetchable) [size=3D256=
M]
        Region 4: I/O ports at f000 [size=3D64]
        Expansion ROM at <unassigned> [disabled]
        Capabilities: [90] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
                Address: fee0f00c  Data: 41e1
        Capabilities: [d0] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D1=
-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 P=
ME-
        Capabilities: [a4] PCI Advanced Features
                AFCap: TP+ FLR+
                AFCtrl: FLR-
                AFStatus: TP-
        Kernel driver in use: i915

00:14.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset =
=46amily USB xHCI Host Controller (rev 04) (prog-if 30 [XHCI])
        Subsystem: ASUSTeK Computer Inc. Device 126d
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- Par=
Err- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbo=
rt- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 41
        Region 0: Memory at f7a00000 (64-bit, non-prefetchable) [size=3D=
64K]
        Capabilities: [70] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA PME(D0-,=
D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 P=
ME-
        Capabilities: [80] MSI: Enable+ Count=3D1/8 Maskable- 64bit+
                Address: 00000000fee0500c  Data: 4191
        Kernel driver in use: xhci_hcd

00:16.0 Communication controller: Intel Corporation 7 Series/C210 Serie=
s Chipset Family MEI Controller #1 (rev 04)
        Subsystem: ASUSTeK Computer Inc. Device 126d
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- Par=
Err- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort=
- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 45
        Region 0: Memory at f7a1a000 (64-bit, non-prefetchable) [size=3D=
16]
        Capabilities: [50] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1=
-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 P=
ME-
        Capabilities: [8c] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
                Address: 00000000fee0f00c  Data: 41d1
        Kernel driver in use: mei_me

00:1a.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset =
=46amily USB Enhanced Host Controller #2 (rev 04) (prog-if 20 [EHCI])
        Subsystem: ASUSTeK Computer Inc. Device 126d
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- Par=
Err- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbo=
rt- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at f7a18000 (32-bit, non-prefetchable) [size=3D=
1K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA PME(D0+,=
D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 P=
ME-
        Capabilities: [58] Debug port: BAR=3D1 offset=3D00a0
        Capabilities: [98] PCI Advanced Features
                AFCap: TP+ FLR+
                AFCtrl: FLR-
                AFStatus: TP-
        Kernel driver in use: ehci-pci

00:1b.0 Audio device: Intel Corporation 7 Series/C210 Series Chipset Fa=
mily High Definition Audio Controller (rev 04)
        Subsystem: ASUSTeK Computer Inc. Device 116f
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- Par=
Err- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort=
- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 47
        Region 0: Memory at f7a10000 (64-bit, non-prefetchable) [size=3D=
16K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D55mA PME(D0+,D=
1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 P=
ME-
        Capabilities: [60] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
                Address: 00000000fee0f00c  Data: 4142
        Capabilities: [70] Express (v1) Root Complex Integrated Endpoin=
t, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0
                        ExtTag- RBE-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- U=
nsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr=
+ TransPend-
        Capabilities: [100 v1] Virtual Channel
                Caps:   LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
                Arb:    Fixed- WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=3DFixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=3D00 MaxTimeSlots=3D1 RejSnoo=
pTrans-
                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- W=
RR256-
                        Ctrl:   Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3D=
01
                        Status: NegoPending- InProgress-
                VC1:    Caps:   PATOffset=3D00 MaxTimeSlots=3D1 RejSnoo=
pTrans-
                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- W=
RR256-
                        Ctrl:   Enable+ ID=3D1 ArbSelect=3DFixed TC/VC=3D=
22
                        Status: NegoPending- InProgress-
        Capabilities: [130 v1] Root Complex Link
                Desc:   PortNumber=3D0f ComponentID=3D00 EltType=3DConf=
ig
                Link0:  Desc:   TargetPort=3D00 TargetComponent=3D00 As=
socRCRB- LinkType=3DMemMapped LinkValid+
                        Addr:   00000000fed1c000
        Kernel driver in use: snd_hda_intel

00:1c.0 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset Fami=
ly PCI Express Root Port 1 (rev c4) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- Par=
Err- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort=
- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=3D00, secondary=3D02, subordinate=3D02, sec-latenc=
y=3D0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: 00000000fff00000-00000000000=
fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort=
- <TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0
                        ExtTag- RBE+
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- U=
nsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr=
+ TransPend-
                LnkCap: Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Ex=
it Latency L0s <1us, L1 <16us
                        ClockPM- Surprise- LLActRep+ BwNot-
                LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Com=
mClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+=
 DLActive- BWMgmt- ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug=
- Surprise-
                        Slot #0, PowerLimit 10.000W; Interlock- NoCompl=
+
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-=
 HPIrq- LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown, Power=
- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDe=
t- Interlock-
                        Changed: MRL- PresDet- LinkState-
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEInt=
Ena- CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR=
-, OBFF Not Supported ARIFwd-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-,=
 LTR-, OBFF Disabled ARIFwd-
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- Spe=
edDis-
                         Transmit Margin: Normal Operating Range, Enter=
ModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -3.5dB, Equalizatio=
nComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, Link=
EqualizationRequest-
        Capabilities: [80] MSI: Enable- Count=3D1/1 Maskable- 64bit-
                Address: 00000000  Data: 0000
        Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 126d
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1=
-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 P=
ME-
        Kernel driver in use: pcieport

00:1c.1 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset Fami=
ly PCI Express Root Port 2 (rev c4) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- Par=
Err- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort=
- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=3D00, secondary=3D03, subordinate=3D03, sec-latenc=
y=3D0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: f7900000-f79fffff
        Prefetchable memory behind bridge: 00000000fff00000-00000000000=
fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort=
- <TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0
                        ExtTag- RBE+
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- U=
nsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr=
+ TransPend-
                LnkCap: Port #2, Speed 5GT/s, Width x1, ASPM L0s L1, Ex=
it Latency L0s <512ns, L1 <16us
                        ClockPM- Surprise- LLActRep+ BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+=
 DLActive+ BWMgmt+ ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug=
- Surprise-
                        Slot #1, PowerLimit 10.000W; Interlock- NoCompl=
+
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-=
 HPIrq- LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown, Power=
- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDe=
t+ Interlock-
                        Changed: MRL- PresDet- LinkState+
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEInt=
Ena- CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR=
-, OBFF Not Supported ARIFwd-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-,=
 LTR-, OBFF Disabled ARIFwd-
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- Spe=
edDis-
                         Transmit Margin: Normal Operating Range, Enter=
ModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -3.5dB, Equalizatio=
nComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, Link=
EqualizationRequest-
        Capabilities: [80] MSI: Enable- Count=3D1/1 Maskable- 64bit-
                Address: 00000000  Data: 0000
        Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 126d
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1=
-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 P=
ME-
        Kernel driver in use: pcieport

00:1c.3 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset Fami=
ly PCI Express Root Port 4 (rev c4) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- Par=
Err- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort=
- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=3D00, secondary=3D04, subordinate=3D04, sec-latenc=
y=3D0
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: f7800000-f78fffff
        Prefetchable memory behind bridge: 00000000f2100000-00000000f21=
fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort=
- <TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0
                        ExtTag- RBE+
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- U=
nsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr=
+ TransPend-
                LnkCap: Port #4, Speed 5GT/s, Width x1, ASPM L0s L1, Ex=
it Latency L0s <512ns, L1 <16us
                        ClockPM- Surprise- LLActRep+ BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+=
 DLActive+ BWMgmt+ ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug=
- Surprise-
                        Slot #3, PowerLimit 10.000W; Interlock- NoCompl=
+
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-=
 HPIrq- LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown, Power=
- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDe=
t+ Interlock-
                        Changed: MRL- PresDet- LinkState+
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEInt=
Ena- CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR=
-, OBFF Not Supported ARIFwd-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-,=
 LTR-, OBFF Disabled ARIFwd-
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- Spe=
edDis-
                         Transmit Margin: Normal Operating Range, Enter=
ModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -3.5dB, Equalizatio=
nComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, Link=
EqualizationRequest-
        Capabilities: [80] MSI: Enable- Count=3D1/1 Maskable- 64bit-
                Address: 00000000  Data: 0000
        Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 126d
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1=
-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 P=
ME-
        Kernel driver in use: pcieport

00:1d.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset =
=46amily USB Enhanced Host Controller #1 (rev 04) (prog-if 20 [EHCI])
        Subsystem: ASUSTeK Computer Inc. Device 126d
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- Par=
Err- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbo=
rt- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 23
        Region 0: Memory at f7a17000 (32-bit, non-prefetchable) [size=3D=
1K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA PME(D0+,=
D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 P=
ME-
        Capabilities: [58] Debug port: BAR=3D1 offset=3D00a0
        Capabilities: [98] PCI Advanced Features
                AFCap: TP+ FLR+
                AFCtrl: FLR-
                AFStatus: TP-
        Kernel driver in use: ehci-pci

00:1f.0 ISA bridge: Intel Corporation HM76 Express Chipset LPC Controll=
er (rev 04)
        Subsystem: ASUSTeK Computer Inc. Device 126d
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- Par=
Err- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbo=
rt- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Capabilities: [e0] Vendor Specific Information: Len=3D0c <?>
        Kernel driver in use: lpc_ich

00:1f.2 SATA controller: Intel Corporation 7 Series Chipset Family 6-po=
rt SATA Controller [AHCI mode] (rev 04) (prog-if 01 [AHCI 1.0])
        Subsystem: ASUSTeK Computer Inc. Device 126d
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- Par=
Err- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbo=
rt- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin B routed to IRQ 43
        Region 0: I/O ports at f0b0 [size=3D8]
        Region 1: I/O ports at f0a0 [size=3D4]
        Region 2: I/O ports at f090 [size=3D8]
        Region 3: I/O ports at f080 [size=3D4]
        Region 4: I/O ports at f060 [size=3D32]
        Region 5: Memory at f7a16000 (32-bit, non-prefetchable) [size=3D=
2K]
        Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
                Address: fee0500c  Data: 41b1
        Capabilities: [70] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1=
-,D2-,D3hot+,D3cold-)
                Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 P=
ME-
        Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=3D00000004
        Capabilities: [b0] PCI Advanced Features
                AFCap: TP+ FLR+
                AFCtrl: FLR-
                AFStatus: TP-
        Kernel driver in use: ahci

00:1f.3 SMBus: Intel Corporation 7 Series/C210 Series Chipset Family SM=
Bus Controller (rev 04)
        Subsystem: ASUSTeK Computer Inc. Device 126d
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- Par=
Err- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbo=
rt- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin C routed to IRQ 10
        Region 0: Memory at f7a15000 (64-bit, non-prefetchable) [size=3D=
256]
        Region 4: I/O ports at f040 [size=3D32]

01:00.0 3D controller: NVIDIA Corporation GF117M [GeForce 610M/710M/820=
M / GT 620M/625M/630M/720M] (rev a1)
        Subsystem: ASUSTeK Computer Inc. GeForce GT 720M
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- Par=
Err- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort=
- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 48
        Region 0: Memory at f6000000 (32-bit, non-prefetchable) [size=3D=
16M]
        Region 1: Memory at e0000000 (64-bit, prefetchable) [size=3D256=
M]
        Region 3: Memory at f0000000 (64-bit, prefetchable) [size=3D32M=
]
        Region 5: I/O ports at e000 [size=3D128]
        Expansion ROM at f7000000 [disabled] [size=3D512K]
        Capabilities: [60] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1=
-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 P=
ME-
        Capabilities: [68] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
                Address: 00000000fee0f00c  Data: 4152
        Capabilities: [78] Express (v2) Endpoint, MSI 00
                DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s =
unlimited, L1 <64us
                        ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- U=
nsupported-
                        RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 256 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr=
- TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x8, ASPM L0s L1, =
Exit Latency L0s <512ns, L1 <4us
                        ClockPM+ Surprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x8, TrErr- Train- SlotClk+=
 DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Range AB, TimeoutDis+, LTR=
-, OBFF Not Supported
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-,=
 LTR-, OBFF Disabled
                LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- S=
peedDis-
                         Transmit Margin: Normal Operating Range, Enter=
ModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -3.5dB, Equalizatio=
nComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, Link=
EqualizationRequest-
        Capabilities: [b4] Vendor Specific Information: Len=3D14 <?>
        Capabilities: [100 v1] Virtual Channel
                Caps:   LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
                Arb:    Fixed- WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=3DFixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=3D00 MaxTimeSlots=3D1 RejSnoo=
pTrans-
                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- W=
RR256-
                        Ctrl:   Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3D=
ff
                        Status: NegoPending- InProgress-
        Capabilities: [128 v1] Power Budgeting <?>
        Capabilities: [600 v1] Vendor Specific Information: ID=3D0001 R=
ev=3D1 Len=3D024 <?>
        Kernel driver in use: nouveau

03:00.0 Network controller: Ralink corp. RT3290 Wireless 802.11n 1T/1R =
PCIe
        Subsystem: Foxconn International, Inc. Device e055
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- Par=
Err- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort=
- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 17
        Region 0: Memory at f7910000 (32-bit, non-prefetchable) [size=3D=
64K]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA PME(D0+,=
D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 P=
ME-
        Capabilities: [50] MSI: Enable- Count=3D1/32 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [70] Express (v2) Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s =
<128ns, L1 <2us
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- U=
nsupported-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr=
+ TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, =
Exit Latency L0s <512ns, L1 <64us
                        ClockPM+ Surprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+=
 DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Not Supported, TimeoutDis+=
, LTR-, OBFF Not Supported
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-,=
 LTR-, OBFF Disabled
                LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- S=
peedDis-
                         Transmit Margin: Normal Operating Range, Enter=
ModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB, EqualizationC=
omplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, Link=
EqualizationRequest-
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmp=
lt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmp=
lt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmp=
lt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonF=
atalErr+
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonF=
atalErr+
                AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap=
+ ChkEn-
        Capabilities: [140 v1] Device Serial Number 00-00-b3-22-82-30-3=
5-54
        Kernel driver in use: rt2800pci

03:00.1 Bluetooth: Ralink corp. RT3290 Bluetooth
        Subsystem: Foxconn International, Inc. Device e056
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- Par=
Err- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort=
- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 3
        Region 0: Memory at f7900000 (32-bit, non-prefetchable) [size=3D=
64K]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=3D375mA PME(D0+,=
D1+,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 P=
ME-
        Capabilities: [50] MSI: Enable- Count=3D1/32 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [70] Express (v2) Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s =
<128ns, L1 <2us
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- U=
nsupported-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr=
+ TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, =
Exit Latency L0s <512ns, L1 <64us
                        ClockPM+ Surprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+=
 DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Not Supported, TimeoutDis+=
, LTR-, OBFF Not Supported
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-,=
 LTR-, OBFF Disabled
                LnkSta2: Current De-emphasis Level: -6dB, EqualizationC=
omplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, Link=
EqualizationRequest-
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmp=
lt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmp=
lt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmp=
lt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonF=
atalErr+
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonF=
atalErr+
                AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap=
+ ChkEn-
        Capabilities: [140 v1] Device Serial Number 00-00-b4-22-82-30-3=
5-54

04:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. Device=
 5289 (rev 01)
        Subsystem: ASUSTeK Computer Inc. Device 202f
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- Par=
Err- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort=
- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin B routed to IRQ 42
        Region 0: Memory at f7800000 (32-bit, non-prefetchable) [size=3D=
64K]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0-,=
D1+,D2+,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 P=
ME-
        Capabilities: [50] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
                Address: 00000000fee0f00c  Data: 41a1
        Capabilities: [70] Express (v2) Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s =
<512ns, L1 <64us
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- U=
nsupported-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr=
+ TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, =
Exit Latency L0s unlimited, L1 <64us
                        ClockPM+ Surprise- LLActRep- BwNot-
                LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk=
-
                        ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+=
 DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, L=
TR-, OBFF Not Supported
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-,=
 LTR-, OBFF Disabled
                LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- S=
peedDis-
                         Transmit Margin: Normal Operating Range, Enter=
ModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB, EqualizationC=
omplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, Link=
EqualizationRequest-
        Capabilities: [b0] MSI-X: Enable- Count=3D1 Masked-
                Vector table: BAR=3D0 offset=3D00000000
                PBA: BAR=3D0 offset=3D00000000
        Capabilities: [d0] Vital Product Data
                Not readable
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmp=
lt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmp=
lt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmp=
lt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr+ BadTLP- BadDLLP- Rollover- Timeout- NonF=
atalErr+
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonF=
atalErr+
                AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap=
+ ChkEn-
        Capabilities: [140 v1] Virtual Channel
                Caps:   LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
                Arb:    Fixed- WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=3DFixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=3D00 MaxTimeSlots=3D1 RejSnoo=
pTrans-
                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- W=
RR256-
                        Ctrl:   Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3D=
ff
                        Status: NegoPending- InProgress-
        Capabilities: [160 v1] Device Serial Number 00-00-00-00-00-00-0=
0-00
        Kernel driver in use: rtsx_pci

04:00.2 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/81=
68/8411 PCI Express Gigabit Ethernet Controller (rev 0a)
        Subsystem: ASUSTeK Computer Inc. Device 200f
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- Par=
Err- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort=
- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 44
        Region 0: I/O ports at d000 [size=3D256]
        Region 2: Memory at f7810000 (64-bit, non-prefetchable) [size=3D=
4K]
        Region 4: Memory at f2100000 (64-bit, prefetchable) [size=3D16K=
]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0+,=
D1+,D2+,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 P=
ME-
        Capabilities: [50] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
                Address: 00000000fee0f00c  Data: 41c1
        Capabilities: [70] Express (v2) Endpoint, MSI 01
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s =
<512ns, L1 <64us
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- U=
nsupported-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 4096 bytes
                DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr=
+ TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, =
Exit Latency L0s unlimited, L1 <64us
                        ClockPM+ Surprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+=
 DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, L=
TR-, OBFF Not Supported
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-,=
 LTR-, OBFF Disabled
                LnkSta2: Current De-emphasis Level: -6dB, EqualizationC=
omplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, Link=
EqualizationRequest-
        Capabilities: [b0] MSI-X: Enable- Count=3D4 Masked-
                Vector table: BAR=3D4 offset=3D00000000
                PBA: BAR=3D4 offset=3D00000800
        Capabilities: [d0] Vital Product Data
                Unknown small resource type 00, will not decode more.
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmp=
lt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmp=
lt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmp=
lt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr+ BadTLP- BadDLLP- Rollover- Timeout- NonF=
atalErr+
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonF=
atalErr+
                AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap=
+ ChkEn-
        Capabilities: [160 v1] Device Serial Number 01-00-00-00-68-4c-e=
0-00
        Kernel driver in use: r8169

$ cat /proc/bus/input/devices
I: Bus=3D0019 Vendor=3D0000 Product=3D0005 Version=3D0000
N: Name=3D"Lid Switch"
P: Phys=3DPNP0C0D/button/input0
S: Sysfs=3D/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input0
U: Uniq=3D
H: Handlers=3Devent0
B: PROP=3D0
B: EV=3D21
B: SW=3D1

I: Bus=3D0019 Vendor=3D0000 Product=3D0003 Version=3D0000
N: Name=3D"Sleep Button"
P: Phys=3DPNP0C0E/button/input0
S: Sysfs=3D/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input1
U: Uniq=3D
H: Handlers=3Dkbd event1
B: PROP=3D0
B: EV=3D3
B: KEY=3D4000 0 0

I: Bus=3D0019 Vendor=3D0000 Product=3D0001 Version=3D0000
N: Name=3D"Power Button"
P: Phys=3DLNXPWRBN/button/input0
S: Sysfs=3D/devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
U: Uniq=3D
H: Handlers=3Dkbd event2
B: PROP=3D0
B: EV=3D3
B: KEY=3D10000000000000 0

I: Bus=3D0011 Vendor=3D0001 Product=3D0001 Version=3Dab41
N: Name=3D"AT Translated Set 2 keyboard"
P: Phys=3Disa0060/serio0/input0
S: Sysfs=3D/devices/platform/i8042/serio0/input/input3
U: Uniq=3D
H: Handlers=3Dsysrq kbd event3
B: PROP=3D0
B: EV=3D120013
B: KEY=3D402000000 3803078f800d001 feffffdfffefffff fffffffffffffffe
B: MSC=3D10
B: LED=3D7

I: Bus=3D0003 Vendor=3D046d Product=3Dc068 Version=3D0111
N: Name=3D"Logitech G500"
P: Phys=3Dusb-0000:00:14.0-2/input0
S:
Sysfs=3D/devices/pci0000:00/0000:00:14.0/usb3/3-2/3-2:1.0/0003:046D:C06=
8.0001/input/input12
U: Uniq=3D5B1D8872EC0018 H: Handlers=3Dmouse0 event4
B: PROP=3D0
B: EV=3D17
B: KEY=3Dffff0000 0 0 0 0
B: REL=3D143
B: MSC=3D10

I: Bus=3D0003 Vendor=3D046d Product=3Dc068 Version=3D0111
N: Name=3D"Logitech G500"
P: Phys=3Dusb-0000:00:14.0-2/input1
S:
Sysfs=3D/devices/pci0000:00/0000:00:14.0/usb3/3-2/3-2:1.1/0003:046D:C06=
8.0002/input/input13
U: Uniq=3D5B1D8872EC0018 H: Handlers=3Dsysrq kbd event5
B: PROP=3D0
B: EV=3D10001f
B: KEY=3D4837fff17aff32d bf54444600000000 1 30f908b17c007
ffe77bfad9415fff febeffdfffefffff fffffffffffffffe B: REL=3D40
B: ABS=3D100000000
B: MSC=3D10

I: Bus=3D0011 Vendor=3D0002 Product=3D0001 Version=3D0063
N: Name=3D"PS/2 Logitech Wheel Mouse"
P: Phys=3Disa0060/serio4/input0
S: Sysfs=3D/devices/platform/i8042/serio4/input/input11
U: Uniq=3D
H: Handlers=3Dmouse1 event6
B: PROP=3D0
B: EV=3D7
B: KEY=3D70000 0 0 0 0
B: REL=3D3

I: Bus=3D0003 Vendor=3D04f2 Product=3Db40a Version=3D6964
N: Name=3D"USB2.0 HD UVC WebCam"
P: Phys=3Dusb-0000:00:1a.0-1.3/button
S:
Sysfs=3D/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.3/1-1.3:1.0/input=
/input14
U: Uniq=3D H: Handlers=3Dkbd event7
B: PROP=3D0
B: EV=3D3
B: KEY=3D100000 0 0 0

I: Bus=3D0019 Vendor=3D0000 Product=3D0006 Version=3D0000
N: Name=3D"Video Bus"
P: Phys=3DLNXVIDEO/video/input0
S:
Sysfs=3D/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:02/LNXVIDEO:=
00/input/input15
U: Uniq=3D H: Handlers=3Dkbd event8
B: PROP=3D0
B: EV=3D3
B: KEY=3D3e000b00000000 0 0 0

I: Bus=3D0019 Vendor=3D0000 Product=3D0000 Version=3D0000
N: Name=3D"Asus WMI hotkeys"
P: Phys=3Dasus-nb-wmi/input0
S: Sysfs=3D/devices/platform/asus-nb-wmi/input/input16
U: Uniq=3D
H: Handlers=3Drfkill kbd event9
B: PROP=3D0
B: EV=3D100013
B: KEY=3D80000 0 800000000000 0 0 a1606f00900000 8200027800501000
e000000000000 0 B: MSC=3D10

I: Bus=3D0019 Vendor=3D0000 Product=3D0006 Version=3D0000
N: Name=3D"Video Bus"
P: Phys=3DLNXVIDEO/video/input0
S:
Sysfs=3D/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:01/input/i=
nput17
U: Uniq=3D H: Handlers=3Dkbd event10
B: PROP=3D0
B: EV=3D3
B: KEY=3D3e000b00000000 0 0 0

I: Bus=3D0000 Vendor=3D0000 Product=3D0000 Version=3D0000
N: Name=3D"HDA Intel PCH Headphone"
P: Phys=3DALSA
S: Sysfs=3D/devices/pci0000:00/0000:00:1b.0/sound/card0/input18
U: Uniq=3D
H: Handlers=3Devent11
B: PROP=3D0
B: EV=3D21
B: SW=3D4

I: Bus=3D0000 Vendor=3D0000 Product=3D0000 Version=3D0000
N: Name=3D"HDA Intel PCH HDMI/DP,pcm=3D3"
P: Phys=3DALSA
S: Sysfs=3D/devices/pci0000:00/0000:00:1b.0/sound/card0/input19
U: Uniq=3D
H: Handlers=3Devent12
B: PROP=3D0
B: EV=3D21
B: SW=3D140

$ xinput
=E2=8E=A1 Virtual core pointer                          id=3D2    [mast=
er pointer  (3)]
=E2=8E=9C   =E2=86=B3 Virtual core XTEST pointer                id=3D4 =
   [slave  pointer  (2)]
=E2=8E=9C   =E2=86=B3 Logitech G500                             id=3D10=
   [slave  pointer  (2)]
=E2=8E=9C   =E2=86=B3 Logitech G500                             id=3D11=
   [slave  pointer  (2)]
=E2=8E=9C   =E2=86=B3 PS/2 Logitech Wheel Mouse                 id=3D15=
   [slave  pointer  (2)]
=E2=8E=A3 Virtual core keyboard                         id=3D3    [mast=
er keyboard (2)]
    =E2=86=B3 Virtual core XTEST keyboard               id=3D5    [slav=
e  keyboard (3)]
    =E2=86=B3 Power Button                              id=3D6    [slav=
e  keyboard (3)]
    =E2=86=B3 Video Bus                                 id=3D7    [slav=
e  keyboard (3)]
    =E2=86=B3 Video Bus                                 id=3D8    [slav=
e  keyboard (3)]
    =E2=86=B3 Sleep Button                              id=3D9    [slav=
e  keyboard (3)]
    =E2=86=B3 USB2.0 HD UVC WebCam                      id=3D12   [slav=
e  keyboard (3)]
    =E2=86=B3 Asus WMI hotkeys                          id=3D13   [slav=
e  keyboard (3)]
    =E2=86=B3 AT Translated Set 2 keyboard              id=3D14   [slav=
e  keyboard (3)]

$ dmesg | grep PS/2
[    2.198041] i8042: PNP: PS/2 Controller [PNP030b:PS2K,PNP0f03:PS2M] =
at 0x60,0x64 irq 1,12
[    2.207915] mousedev: PS/2 mouse device common for all mice
[    5.391745] input: PS/2 Logitech Wheel Mouse as /devices/platform/i8=
042/serio4/input/input11

$ cat /var/log/Xorg.0.log | grep PS/2
[    30.339] (II) config/udev: Adding input device PS/2 Logitech Wheel =
Mouse (/dev/input/event6)
[    30.339] (**) PS/2 Logitech Wheel Mouse: Applying InputClass "evdev=
 pointer catchall"
[    30.339] (II) Using input driver 'evdev' for 'PS/2 Logitech Wheel M=
ouse'
[    30.339] (**) PS/2 Logitech Wheel Mouse: always reports core events
[    30.339] (**) evdev: PS/2 Logitech Wheel Mouse: Device: "/dev/input=
/event6"
[    30.339] (--) evdev: PS/2 Logitech Wheel Mouse: Vendor 0x2 Product =
0x1
[    30.340] (--) evdev: PS/2 Logitech Wheel Mouse: Found 3 mouse butto=
ns
[    30.340] (--) evdev: PS/2 Logitech Wheel Mouse: Found relative axes
[    30.340] (--) evdev: PS/2 Logitech Wheel Mouse: Found x and y relat=
ive axes
[    30.340] (II) evdev: PS/2 Logitech Wheel Mouse: Configuring as mous=
e
[    30.340] (**) evdev: PS/2 Logitech Wheel Mouse: YAxisMapping: butto=
ns 4 and 5
[    30.340] (**) evdev: PS/2 Logitech Wheel Mouse: EmulateWheelButton:=
 4, EmulateWheelInertia: 10, EmulateWheelTimeout: 200
[    30.340] (II) XINPUT: Adding extended input device "PS/2 Logitech W=
heel Mouse" (type: MOUSE, id 15)
[    30.340] (II) evdev: PS/2 Logitech Wheel Mouse: initialized for rel=
ative axes.
[    30.340] (**) PS/2 Logitech Wheel Mouse: (accel) keeping accelerati=
on scheme 1
[    30.340] (**) PS/2 Logitech Wheel Mouse: (accel) acceleration profi=
le 0
[    30.340] (**) PS/2 Logitech Wheel Mouse: (accel) acceleration facto=
r: 2.000
[    30.340] (**) PS/2 Logitech Wheel Mouse: (accel) acceleration thres=
hold: 4
[    30.340] (II) config/udev: Adding input device PS/2 Logitech Wheel =
Mouse (/dev/input/mouse1)
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
