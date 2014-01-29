From: Geoff Kelsall <apps@geoff.kelsall.name>
Subject: [Novatech N1402 NNB-978] Touchpad does not work at all
Date: Wed, 29 Jan 2014 11:53:16 +0200
Message-ID: <CACwz48G7RQJecigeaYG19GKzMZPBwX61wt19AXR8+rNuJ=wvdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:44057 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925AbaA2Jxh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jan 2014 04:53:37 -0500
Received: by mail-qa0-f49.google.com with SMTP id w8so2058878qac.22
        for <linux-input@vger.kernel.org>; Wed, 29 Jan 2014 01:53:36 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>

[Novatech N1402 NNB-978] Touchpad does not work at all

WORKAROUND: Kernel parameter: i8042.noloop

Linux version 3.13.0-031300-generic (apw@gomeisa) (gcc version 4.6.3
(Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201401192235 SMP Mon Jan 20 03:46:44
UTC 2014

Description:    Ubuntu 12.04.2 LTS
Release:    12.04

geoff@geoff-laptop:/usr/src/linux-headers-3.13.0-031300/scripts$ sh ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux geoff-laptop 3.13.0-031300-generic #201401192235 SMP Mon Jan 20
03:46:44 UTC 2014 i686 i686 i386 GNU/Linux

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
Modules Loaded         ctr ccm uvcvideo videobuf2_core videodev
videobuf2_vmalloc videobuf2_memops promethean joydev
snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_intel psmouse
snd_hda_codec serio_raw snd_hwdep arc4 snd_pcm rt2800pci snd_seq_midi
rt2800mmio snd_rawmidi rt2800lib snd_seq_midi_event crc_ccitt i915
rt2x00mmio rt2x00pci rt2x00lib snd_seq mac80211 snd_timer
snd_seq_device drm_kms_helper drm cfg80211 rfcomm snd bnep mac_hid
lpc_ich i2c_algo_bit mei_me bluetooth parport_pc eeprom_93cx6 ppdev
video mei soundcore snd_page_alloc binfmt_misc lp parport ahci libahci
r8169 mii
geoff@geoff-laptop:/usr/src/linux-headers-3.13.0-031300/scripts$

geoff@geoff-laptop:/usr/src/linux-headers-3.13.0-031300$ sh ver_linux
sh: 0: Can't open ver_linux
geoff@geoff-laptop:/usr/src/linux-headers-3.13.0-031300$ cd scripts/
geoff@geoff-laptop:/usr/src/linux-headers-3.13.0-031300/scripts$ sh ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux geoff-laptop 3.13.0-031300-generic #201401192235 SMP Mon Jan 20
03:46:44 UTC 2014 i686 i686 i386 GNU/Linux

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
Modules Loaded         ctr ccm uvcvideo videobuf2_core videodev
videobuf2_vmalloc videobuf2_memops promethean joydev
snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_intel psmouse
snd_hda_codec serio_raw snd_hwdep arc4 snd_pcm rt2800pci snd_seq_midi
rt2800mmio snd_rawmidi rt2800lib snd_seq_midi_event crc_ccitt i915
rt2x00mmio rt2x00pci rt2x00lib snd_seq mac80211 snd_timer
snd_seq_device drm_kms_helper drm cfg80211 rfcomm snd bnep mac_hid
lpc_ich i2c_algo_bit mei_me bluetooth parport_pc eeprom_93cx6 ppdev
video mei soundcore snd_page_alloc binfmt_misc lp parport ahci libahci
r8169 mii
geoff@geoff-laptop:/usr/src/linux-headers-3.13.0-031300/scripts$ cat
/proc/cpuinfo
processor    : 0
vendor_id    : GenuineIntel
cpu family    : 6
model        : 58
model name    : Intel(R) Core(TM) i5-3317U CPU @ 1.70GHz
stepping    : 9
microcode    : 0x10
cpu MHz        : 2193.664
cache size    : 3072 KB
physical id    : 0
siblings    : 4
core id        : 0
cpu cores    : 2
apicid        : 0
initial apicid    : 0
fdiv_bug    : no
f00f_bug    : no
coma_bug    : no
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx
rdtscp lm constant_tsc arch_perfmon pebs bts xtopology nonstop_tsc
aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2
ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt
tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm ida arat epb
xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase
smep erms
bogomips    : 3392.08
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 1
vendor_id    : GenuineIntel
cpu family    : 6
model        : 58
model name    : Intel(R) Core(TM) i5-3317U CPU @ 1.70GHz
stepping    : 9
microcode    : 0x10
cpu MHz        : 2512.414
cache size    : 3072 KB
physical id    : 0
siblings    : 4
core id        : 1
cpu cores    : 2
apicid        : 2
initial apicid    : 2
fdiv_bug    : no
f00f_bug    : no
coma_bug    : no
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx
rdtscp lm constant_tsc arch_perfmon pebs bts xtopology nonstop_tsc
aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2
ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt
tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm ida arat epb
xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase
smep erms
bogomips    : 3392.08
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 2
vendor_id    : GenuineIntel
cpu family    : 6
model        : 58
model name    : Intel(R) Core(TM) i5-3317U CPU @ 1.70GHz
stepping    : 9
microcode    : 0x10
cpu MHz        : 1779.820
cache size    : 3072 KB
physical id    : 0
siblings    : 4
core id        : 0
cpu cores    : 2
apicid        : 1
initial apicid    : 1
fdiv_bug    : no
f00f_bug    : no
coma_bug    : no
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx
rdtscp lm constant_tsc arch_perfmon pebs bts xtopology nonstop_tsc
aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2
ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt
tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm ida arat epb
xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase
smep erms
bogomips    : 3392.08
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 3
vendor_id    : GenuineIntel
cpu family    : 6
model        : 58
model name    : Intel(R) Core(TM) i5-3317U CPU @ 1.70GHz
stepping    : 9
microcode    : 0x10
cpu MHz        : 1553.175
cache size    : 3072 KB
physical id    : 0
siblings    : 4
core id        : 1
cpu cores    : 2
apicid        : 3
initial apicid    : 3
fdiv_bug    : no
f00f_bug    : no
coma_bug    : no
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx
rdtscp lm constant_tsc arch_perfmon pebs bts xtopology nonstop_tsc
aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2
ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt
tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm ida arat epb
xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase
smep erms
bogomips    : 3392.08
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

geoff@geoff-laptop:/usr/src/linux-headers-3.13.0-031300/scripts$

geoff@geoff-laptop:/usr/src/linux-headers-3.13.0-031300/scripts$ cat
/proc/modules
ctr 13025 1 - Live 0x00000000
ccm 17596 1 - Live 0x00000000
uvcvideo 72275 0 - Live 0x00000000
videobuf2_core 39510 1 uvcvideo, Live 0x00000000
videodev 108952 2 uvcvideo,videobuf2_core, Live 0x00000000
videobuf2_vmalloc 13048 1 uvcvideo, Live 0x00000000
videobuf2_memops 13170 1 videobuf2_vmalloc, Live 0x00000000
promethean 47575 0 - Live 0x00000000 (OF)
joydev 17299 0 - Live 0x00000000
snd_hda_codec_hdmi 45847 1 - Live 0x00000000
snd_hda_codec_realtek 51482 1 - Live 0x00000000
snd_hda_intel 43398 3 - Live 0x00000000
psmouse 97012 0 - Live 0x00000000
snd_hda_codec 169779 3
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_intel, Live
0x00000000
serio_raw 13230 0 - Live 0x00000000
snd_hwdep 13276 1 snd_hda_codec, Live 0x00000000
arc4 12509 2 - Live 0x00000000
snd_pcm 90501 3 snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec, Live 0x00000000
rt2800pci 13410 0 - Live 0x00000000
snd_seq_midi 13132 0 - Live 0x00000000
rt2800mmio 20399 1 rt2800pci, Live 0x00000000
snd_rawmidi 25198 1 snd_seq_midi, Live 0x00000000
rt2800lib 89156 2 rt2800pci,rt2800mmio, Live 0x00000000
snd_seq_midi_event 14475 1 snd_seq_midi, Live 0x00000000
crc_ccitt 12627 1 rt2800lib, Live 0x00000000
i915 732633 3 - Live 0x00000000
rt2x00mmio 13445 2 rt2800pci,rt2800mmio, Live 0x00000000
rt2x00pci 13111 1 rt2800pci, Live 0x00000000
rt2x00lib 49529 5 rt2800pci,rt2800mmio,rt2800lib,rt2x00mmio,rt2x00pci,
Live 0x00000000
snd_seq 55716 2 snd_seq_midi,snd_seq_midi_event, Live 0x00000000
mac80211 560429 3 rt2800lib,rt2x00pci,rt2x00lib, Live 0x00000000
snd_timer 28971 2 snd_pcm,snd_seq, Live 0x00000000
snd_seq_device 14137 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x00000000
drm_kms_helper 47293 1 i915, Live 0x00000000
drm 249196 4 i915,drm_kms_helper, Live 0x00000000
cfg80211 430030 2 rt2x00lib,mac80211, Live 0x00000000
rfcomm 59026 0 - Live 0x00000000
snd 61351 17 snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_seq_midi,snd_rawmidi,snd_seq,snd_timer,snd_seq_device,
Live 0x00000000
bnep 19107 2 - Live 0x00000000
mac_hid 13077 0 - Live 0x00000000
lpc_ich 16987 0 - Live 0x00000000
i2c_algo_bit 13316 1 i915, Live 0x00000000
mei_me 14058 0 - Live 0x00000000
bluetooth 356681 10 rfcomm,bnep, Live 0x00000000
parport_pc 32114 0 - Live 0x00000000
eeprom_93cx6 13168 1 rt2800pci, Live 0x00000000
ppdev 17423 0 - Live 0x00000000
video 19283 1 i915, Live 0x00000000
mei 71172 1 mei_me, Live 0x00000000
soundcore 12600 1 snd, Live 0x00000000
snd_page_alloc 18398 2 snd_hda_intel,snd_pcm, Live 0x00000000
binfmt_misc 13172 1 - Live 0x00000000
lp 13359 0 - Live 0x00000000
parport 40945 3 parport_pc,ppdev,lp, Live 0x00000000
ahci 25703 2 - Live 0x00000000
libahci 30969 1 ahci, Live 0x00000000
r8169 62856 0 - Live 0x00000000
mii 13693 1 r8169, Live 0x00000000
geoff@geoff-laptop:/usr/src/linux-headers-3.13.0-031300/scripts$

geoff@geoff-laptop:/usr/src/linux-headers-3.13.0-031300/scripts$ cat
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
  0200-020f : pnp 00:04
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
  04d0-04d1 : pnp 00:08
  0500-057f : pnp 00:04
  0680-069f : pnp 00:04
    0680-068f : pnp 00:07
  0a00-0a0f : pnp 00:04
  0a10-0a1f : pnp 00:07
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
  164e-164f : pnp 00:04
  e000-efff : PCI Bus 0000:02
    e000-e0ff : 0000:02:00.0
      e000-e0ff : r8169
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
geoff@geoff-laptop:/usr/src/linux-headers-3.13.0-031300/scripts$

geoff@geoff-laptop:/usr/src/linux-headers-3.13.0-031300/scripts$ cat /proc/iomem
00000000-00000fff : reserved
00001000-0009d7ff : System RAM
0009d800-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
  000a0000-000bffff : Video RAM area
000c0000-000cefff : Video ROM
000d0000-000d3fff : PCI Bus 0000:00
000d4000-000d7fff : PCI Bus 0000:00
000d8000-000dbfff : PCI Bus 0000:00
000dc000-000dffff : PCI Bus 0000:00
000e0000-000fffff : reserved
  000e0000-000e3fff : PCI Bus 0000:00
  000e4000-000e7fff : PCI Bus 0000:00
  000f0000-000fffff : System ROM
00100000-1fffffff : System RAM
  01000000-016790b2 : Kernel code
  016790b3-019e56bf : Kernel data
  01ac8000-01badfff : Kernel bss
20000000-201fffff : reserved
  20000000-201fffff : pnp 00:0d
20200000-40003fff : System RAM
40004000-40004fff : reserved
  40004000-40004fff : pnp 00:0d
40005000-d9aeffff : System RAM
d9af0000-da22efff : reserved
da22f000-da22ffff : ACPI Tables
da230000-da344fff : ACPI Non-volatile Storage
da345000-da6fdfff : reserved
da6fe000-da6fefff : System RAM
da6ff000-da741fff : ACPI Non-volatile Storage
da742000-dae02fff : System RAM
dae03000-daff1fff : reserved
daff2000-daffffff : System RAM
db000000-db7fffff : RAM buffer
db800000-df9fffff : reserved
  dba00000-df9fffff : Graphics Stolen Memory
dfa00000-feafffff : PCI Bus 0000:00
  dfa00000-dfa00fff : pnp 00:0c
  e0000000-efffffff : 0000:00:02.0
    e0000000-e0407fff : BOOTFB
  f0000000-f00fffff : PCI Bus 0000:02
    f0000000-f0003fff : 0000:02:00.0
      f0000000-f0003fff : r8169
    f0004000-f0004fff : 0000:02:00.0
      f0004000-f0004fff : r8169
  f7800000-f7bfffff : 0000:00:02.0
  f7c00000-f7dfffff : PCI Bus 0000:01
    f7c00000-f7cfffff : 0000:01:00.1
    f7d00000-f7d0ffff : 0000:01:00.1
    f7d10000-f7d1ffff : 0000:01:00.1
    f7d20000-f7d2ffff : 0000:01:00.1
    f7d30000-f7d3ffff : 0000:01:00.0
      f7d30000-f7d3ffff : 0000:01:00.0
    f7d40000-f7d4ffff : 0000:01:00.0
      f7d40000-f7d4ffff : 0000:01:00.0
  f7e00000-f7e0ffff : 0000:00:14.0
    f7e00000-f7e0ffff : xhci_hcd
  f7e10000-f7e13fff : 0000:00:1b.0
    f7e10000-f7e13fff : ICH HD audio
  f7e15000-f7e150ff : 0000:00:1f.3
  f7e16000-f7e167ff : 0000:00:1f.2
    f7e16000-f7e167ff : ahci
  f7e17000-f7e173ff : 0000:00:1d.0
    f7e17000-f7e173ff : ehci_hcd
  f7e18000-f7e183ff : 0000:00:1a.0
    f7e18000-f7e183ff : ehci_hcd
  f7e1b000-f7e1b00f : 0000:00:16.0
    f7e1b000-f7e1b00f : mei_me
  f8000000-fbffffff : PCI MMCONFIG 0000 [bus 00-3f]
    f8000000-fbffffff : reserved
      f8000000-fbffffff : pnp 00:0c
fec00000-fec00fff : reserved
  fec00000-fec003ff : IOAPIC 0
fed00000-fed03fff : reserved
  fed00000-fed003ff : HPET 0
fed10000-fed17fff : pnp 00:0c
fed18000-fed18fff : pnp 00:0c
fed19000-fed19fff : pnp 00:0c
fed1c000-fed1ffff : reserved
  fed1c000-fed1ffff : pnp 00:0c
    fed1f410-fed1f414 : iTCO_wdt
fed20000-fed3ffff : pnp 00:0c
fed40000-fed44fff : pnp 00:00
fed45000-fed8ffff : pnp 00:0c
fed90000-fed93fff : pnp 00:0c
  fed90000-fed90fff : dmar0
  fed91000-fed91fff : dmar1
fee00000-fee00fff : Local APIC
  fee00000-fee00fff : reserved
ff000000-ffffffff : reserved
  ff000000-ffffffff : pnp 00:0c
100000000-11f5fffff : System RAM
11f600000-11fffffff : RAM buffer
geoff@geoff-laptop:/usr/src/linux-headers-3.13.0-031300/scripts$

geoff@geoff-laptop:/usr/src/linux-headers-3.13.0-031300/scripts$ sudo lspci -vvv
[sudo] password for geoff:
00:00.0 Host bridge: Intel Corporation Ivy Bridge DRAM Controller (rev 09)
    Subsystem: Device 1b50:5717
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR- INTx-
    Latency: 0
    Capabilities: [e0] Vendor Specific Information: Len=0c <?>

00:02.0 VGA compatible controller: Intel Corporation Ivy Bridge
Graphics Controller (rev 09) (prog-if 00 [VGA controller])
    Subsystem: Device 1b50:571c
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 44
    Region 0: Memory at f7800000 (64-bit, non-prefetchable) [size=4M]
    Region 2: Memory at e0000000 (64-bit, prefetchable) [size=256M]
    Region 4: I/O ports at f000 [size=64]
    Expansion ROM at <unassigned> [disabled]
    Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Address: fee0a00c  Data: 41c1
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

00:14.0 USB controller: Intel Corporation Panther Point USB xHCI Host
Controller (rev 04) (prog-if 30 [XHCI])
    Subsystem: Device 1b50:5706
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 40
    Region 0: Memory at f7e00000 (64-bit, non-prefetchable) [size=64K]
    Capabilities: [70] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
        Address: 00000000fee0f00c  Data: 4171
    Kernel driver in use: xhci_hcd

00:16.0 Communication controller: Intel Corporation Panther Point MEI
Controller #1 (rev 04)
    Subsystem: Device 1b50:5701
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 43
    Region 0: Memory at f7e1b000 (64-bit, non-prefetchable) [size=16]
    Capabilities: [50] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Address: 00000000fee0f00c  Data: 41b1
    Kernel driver in use: mei_me
    Kernel modules: mei-me

00:1a.0 USB controller: Intel Corporation Panther Point USB Enhanced
Host Controller #2 (rev 04) (prog-if 20 [EHCI])
    Subsystem: Device 1b50:5707
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 16
    Region 0: Memory at f7e18000 (32-bit, non-prefetchable) [size=1K]
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

00:1b.0 Audio device: Intel Corporation Panther Point High Definition
Audio Controller (rev 04)
    Subsystem: Device 1b50:5608
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 45
    Region 0: Memory at f7e10000 (64-bit, non-prefetchable) [size=16K]
    Capabilities: [50] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Address: 00000000fee0100c  Data: 41e1
    Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
            ExtTag- RBE- FLReset+
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
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
            Ctrl:    Enable+ ID=1 ArbSelect=Fixed TC/VC=22
            Status:    NegoPending- InProgress-
    Capabilities: [130 v1] Root Complex Link
        Desc:    PortNumber=0f ComponentID=00 EltType=Config
        Link0:    Desc:    TargetPort=00 TargetComponent=00 AssocRCRB-
LinkType=MemMapped LinkValid+
            Addr:    00000000fed1c000
    Kernel driver in use: snd_hda_intel
    Kernel modules: snd-hda-intel

00:1c.0 PCI bridge: Intel Corporation Panther Point PCI Express Root
Port 1 (rev c4) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
    I/O behind bridge: 0000f000-00000fff
    Memory behind bridge: f7c00000-f7dfffff
    Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
            ExtTag- RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
        LnkCap:    Port #1, Speed 5GT/s, Width x1, ASPM L0s L1,
Latency L0 <512ns, L1 <16us
            ClockPM- Surprise- LLActRep+ BwNot-
        LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive+ BWMgmt+ ABWMgmt-
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
            Slot #0, PowerLimit 10.000W; Interlock- NoCompl+
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
HPIrq- LinkChg-
            Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
            Changed: MRL- PresDet- LinkState-
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
        RootCap: CRSVisible-
        RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        DevCap2: Completion Timeout: Range BC, TimeoutDis+ ARIFwd-
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
        LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-,
Selectable De-emphasis: -6dB
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -3.5dB
    Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
        Address: 00000000  Data: 0000
    Capabilities: [90] Subsystem: Device 1b50:5708
    Capabilities: [a0] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Kernel driver in use: pcieport
    Kernel modules: shpchp

00:1c.2 PCI bridge: Intel Corporation Panther Point PCI Express Root
Port 3 (rev c4) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
    I/O behind bridge: 0000e000-0000efff
    Memory behind bridge: fff00000-000fffff
    Prefetchable memory behind bridge: 00000000f0000000-00000000f00fffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
            ExtTag- RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
        LnkCap:    Port #3, Speed 5GT/s, Width x1, ASPM L0s L1,
Latency L0 <512ns, L1 <16us
            ClockPM- Surprise- LLActRep+ BwNot-
        LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive+ BWMgmt+ ABWMgmt-
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
            Slot #2, PowerLimit 10.000W; Interlock- NoCompl+
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
HPIrq- LinkChg-
            Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
            Changed: MRL- PresDet- LinkState-
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
        RootCap: CRSVisible-
        RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        DevCap2: Completion Timeout: Range BC, TimeoutDis+ ARIFwd-
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
        LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-,
Selectable De-emphasis: -6dB
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -3.5dB
    Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
        Address: 00000000  Data: 0000
    Capabilities: [90] Subsystem: Device 1b50:570a
    Capabilities: [a0] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Kernel driver in use: pcieport
    Kernel modules: shpchp

00:1d.0 USB controller: Intel Corporation Panther Point USB Enhanced
Host Controller #1 (rev 04) (prog-if 20 [EHCI])
    Subsystem: Device 1b50:5710
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 23
    Region 0: Memory at f7e17000 (32-bit, non-prefetchable) [size=1K]
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

00:1f.0 ISA bridge: Intel Corporation Panther Point LPC Controller (rev 04)
    Subsystem: Device 1b50:5712
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Capabilities: [e0] Vendor Specific Information: Len=0c <?>
    Kernel driver in use: lpc_ich
    Kernel modules: lpc_ich

00:1f.2 SATA controller: Intel Corporation Panther Point 6 port SATA
Controller [AHCI mode] (rev 04) (prog-if 01 [AHCI 1.0])
    Subsystem: Device 1b50:5713
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin B routed to IRQ 42
    Region 0: I/O ports at f0b0 [size=8]
    Region 1: I/O ports at f0a0 [size=4]
    Region 2: I/O ports at f090 [size=8]
    Region 3: I/O ports at f080 [size=4]
    Region 4: I/O ports at f060 [size=32]
    Region 5: Memory at f7e16000 (32-bit, non-prefetchable) [size=2K]
    Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Address: fee0100c  Data: 41a1
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

00:1f.3 SMBus: Intel Corporation Panther Point SMBus Controller (rev 04)
    Subsystem: Device 1b50:5714
    Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Interrupt: pin C routed to IRQ 3
    Region 0: Memory at f7e15000 (64-bit, non-prefetchable) [size=256]
    Region 4: I/O ports at f040 [size=32]
    Kernel modules: i2c-i801

01:00.0 Network controller: Ralink corp. Device 3290
    Subsystem: AzureWave Device 2b87
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 16
    Region 0: Memory at f7d40000 (32-bit, non-prefetchable) [size=64K]
    Region 1: Memory at f7d30000 (32-bit, non-prefetchable) [size=64K]
    Capabilities: [40] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [50] MSI: Enable- Count=1/32 Maskable- 64bit+
        Address: 0000000000000000  Data: 0000
    Capabilities: [70] Express (v2) Endpoint, MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s
<128ns, L1 <2us
            ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 512 bytes
        DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
        LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Latency L0 <512ns, L1 <64us
            ClockPM+ Surprise- LLActRep- BwNot-
        LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
        DevCap2: Completion Timeout: Not Supported, TimeoutDis+
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance-
SpeedDis-, Selectable De-emphasis: -6dB
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
    Capabilities: [140 v1] Device Serial Number 00-00-73-50-df-c9-db-94
    Kernel driver in use: rt2800pci
    Kernel modules: rt2800pci

01:00.1 Bluetooth: Ralink corp. Device 3298
    Subsystem: AzureWave Device 2787
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 11
    Region 0: Memory at f7d20000 (32-bit, non-prefetchable) [size=64K]
    Region 1: Memory at f7d10000 (32-bit, non-prefetchable) [size=64K]
    Region 2: Memory at f7c00000 (32-bit, non-prefetchable) [size=1M]
    Expansion ROM at f7d00000 [disabled] [size=64K]
    Capabilities: [40] Power Management version 3
        Flags: PMEClk- DSI- D1+ D2- AuxCurrent=375mA
PME(D0+,D1+,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [50] MSI: Enable- Count=1/32 Maskable- 64bit+
        Address: 0000000000000000  Data: 0000
    Capabilities: [70] Express (v2) Endpoint, MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s
<128ns, L1 <2us
            ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 512 bytes
        DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
        LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Latency L0 <512ns, L1 <64us
            ClockPM+ Surprise- LLActRep- BwNot-
        LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
        DevCap2: Completion Timeout: Not Supported, TimeoutDis+
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance-
SpeedDis-, Selectable De-emphasis: -6dB
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
    Capabilities: [140 v1] Device Serial Number 00-00-74-50-df-c9-db-94

02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL8111/8168B PCI Express Gigabit Ethernet controller (rev 06)
    Subsystem: Device 1b50:4606
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 41
    Region 0: I/O ports at e000 [size=256]
    Region 2: Memory at f0004000 (64-bit, prefetchable) [size=4K]
    Region 4: Memory at f0000000 (64-bit, prefetchable) [size=16K]
    Capabilities: [40] Power Management version 3
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Address: 00000000fee0f00c  Data: 4181
    Capabilities: [70] Express (v2) Endpoint, MSI 01
        DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s
<512ns, L1 <64us
            ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 4096 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
        LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Latency L0 unlimited, L1 <64us
            ClockPM+ Surprise- LLActRep- BwNot-
        LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
        DevCap2: Completion Timeout: Range ABCD, TimeoutDis+
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance-
SpeedDis-, Selectable De-emphasis: -6dB
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB
    Capabilities: [b0] MSI-X: Enable- Count=4 Masked-
        Vector table: BAR=4 offset=00000000
        PBA: BAR=4 offset=00000800
    Capabilities: [d0] Vital Product Data
        No end tag found
    Capabilities: [100 v1] Advanced Error Reporting
        UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
        CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
        CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
        AERCap:    First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
    Capabilities: [140 v1] Virtual Channel
        Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
        Arb:    Fixed- WRR32- WRR64- WRR128-
        Ctrl:    ArbSelect=Fixed
        Status:    InProgress-
        VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
            Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
            Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=01
            Status:    NegoPending- InProgress-
    Capabilities: [160 v1] Device Serial Number 05-00-00-00-68-4c-e0-00
    Kernel driver in use: r8169
    Kernel modules: r8169

geoff@geoff-laptop:/usr/src/linux-headers-3.13.0-031300/scripts$

geoff@geoff-laptop:/usr/src/linux-headers-3.13.0-031300/scripts$ cat
/proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: M4-CT128M4SSD1   Rev: 000F
  Type:   Direct-Access                    ANSI  SCSI revision: 05
geoff@geoff-laptop:/usr/src/linux-headers-3.13.0-031300/scripts$

geoff@geoff-laptop:/usr/src/linux-headers-3.13.0-031300/scripts$ ls /proc
1     1084  1578  1799  1842  1974  2107  2237  2448  280  37   58
777   asound       filesystems    locks         slabinfo
zoneinfo
10    1093  1595  18    1847  1980  2111  2267  2454  283  4    61   8
    buddyinfo    fs             mdstat        softirqs
1007  1097  16    1801  1851  1984  2113  23    2489  29   40   62
800   bus          interrupts     meminfo       stat
1013  1098  1617  1809  1853  1985  2115  2303  25    3    41   643
81    cgroups      iomem          misc          swaps
1022  11    1623  1812  1856  1991  2116  2314  26    30   42   668
82    cmdline      ioports        modules       sys
1024  1136  163   1815  1861  1992  2154  2318  2600  31   426  672
84    consoles     irq            mounts        sysrq-trigger
1028  12    1695  1821  1865  2     2157  2323  2607  311  43   691  9
    cpuinfo      kallsyms       mtrr          sysvipc
1037  1250  17    1822  1883  20    2165  2359  27    312  434  692
902   crypto       kcore          net           timer_list
1042  1260  1731  1823  1912  2012  2167  2368  275   32   44   7
911   devices      key-users      pagetypeinfo  timer_stats
1043  1279  1742  1824  1923  2031  2170  2382  276   33   45   708
920   diskstats    kmsg           partitions    tty
1044  13    1777  1827  1924  2067  2176  2387  277   34   46   716
934   dma          kpagecount     sched_debug   uptime
1064  1393  1780  1837  1930  2071  22    2388  278   35   5    717
958   driver       kpageflags     schedstat     version
1065  15    1781  1839  1950  2092  2211  2446  279   36   512  723
979   execdomains  latency_stats  scsi          vmallocinfo
1066  1535  1790  1840  1952  21    2223  2447  28    368  550  739
acpi  fb           loadavg        self          vmstat
geoff@geoff-laptop:/usr/src/linux-headers-3.13.0-031300/scripts$

WORKAROUND: Kernel parameter: i8042.noloop

Launchpad bug 1244643

Regards


Geoff Kelsall
