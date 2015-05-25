From: VJ Patel <meetthevj@gmail.com>
Subject: BYD trackpad detected as PS/2 mouse
Date: Mon, 25 May 2015 19:31:34 +0100
Message-ID: <CABpttnRpa0JnOzC8R8W+6q9dFQTfCeuiqnGFquUyD_uyFzkDHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:36153 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbbEYSb5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 May 2015 14:31:57 -0400
Received: by lagv1 with SMTP id v1so53563323lag.3
        for <linux-input@vger.kernel.org>; Mon, 25 May 2015 11:31:55 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

[1.] One line summary of the problem:
BYD trackpad detected as PS/2 mouse

[2.] Full description of the problem/report:
Unable to use touchpad with two finger vertical/horizontal scrolling.
Currently only able to use plainly. The exact device is this:
http://bydit.com/doce/products/microelectronics/2474.html

[3.] Keywords (i.e., modules, networking, kernel):

[4.] Kernel version (from /proc/version):
Linux version 4.1.0-040100rc5-generic (kernel@gloin) (gcc version
4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201505250235 SMP Mon May 25
02:37:02 UTC 2015

[7.] Environment
Description:    Ubuntu 15.04
Release:        15.04

[7.1.] Software (add the output of the ver_linux script here)
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux Ubuntudore 4.1.0-040100rc5-generic #201505250235 SMP Mon May 25
02:37:02 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux

Gnu C                  4.9.2
Gnu make               4.0
binutils               2.25
util-linux             2.25.2
mount                  debug
module-init-tools      18
e2fsprogs              1.42.12
pcmciautils            018
PPP                    2.4.6
Linux C Library        2.21
Dynamic linker (ldd)   2.21
Procps                 3.3.9
Net-tools              1.60
Kbd                    1.15.5
Sh-utils               8.23
wireless-tools         30
Modules Loaded         ctr ccm binfmt_misc nls_iso8859_1 arc4
intel_rapl iosf_mbi snd_hda_codec_realtek x86_pkg_temp_thermal
snd_hda_codec_generic intel_powerclamp coretemp kvm_intel
snd_hda_codec_hdmi kvm crct10dif_pclmul iwlmvm uvcvideo crc32_pclmul
snd_hda_intel videobuf2_vmalloc ghash_clmulni_intel videobuf2_memops
snd_hda_controller mac80211 snd_seq_midi snd_hda_codec aesni_intel
snd_hda_core videobuf2_core snd_seq_midi_event snd_hwdep v4l2_common
aes_x86_64 i915 lrw snd_pcm gf128mul videodev glue_helper snd_rawmidi
media iwlwifi ablk_helper snd_seq cryptd serio_raw cfg80211
snd_seq_device drm_kms_helper snd_timer drm snd lpc_ich mei_me shpchp
i2c_algo_bit soundcore mei video intel_smartconnect acpi_pad mac_hid
parport_pc ppdev lp parport autofs4 psmouse r8169 ahci libahci mii

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 61
model name      : Intel(R) Core(TM) i7-5500U CPU @ 2.40GHz
stepping        : 4
microcode       : 0x18
cpu MHz         : 1853.062
cache size      : 4096 KB
physical id     : 0
siblings        : 4
core id         : 0
cpu cores       : 2
apicid          : 0
initial apicid  : 0
fpu             : yes
fpu_exception   : yes
cpuid level     : 20
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts
rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq
dtes64 monitor ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c
rdrand lahf_lm abm 3dnowprefetch ida arat epb pln pts dtherm intel_pt
tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2
smep bmi2 erms invpcid rdseed adx smap xsaveopt
bugs            :
bogomips        : 4788.85
clflush size    : 64
cache_alignment : 64
address sizes   : 39 bits physical, 48 bits virtual
power management:
processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 61
model name      : Intel(R) Core(TM) i7-5500U CPU @ 2.40GHz
stepping        : 4
microcode       : 0x18
cpu MHz         : 2400.093
cache size      : 4096 KB
physical id     : 0
siblings        : 4
core id         : 1
cpu cores       : 2
apicid          : 2
initial apicid  : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 20
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts
rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq
dtes64 monitor ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c
rdrand lahf_lm abm 3dnowprefetch ida arat epb pln pts dtherm intel_pt
tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2
smep bmi2 erms invpcid rdseed adx smap xsaveopt
bugs            :
bogomips        : 4788.85
clflush size    : 64
cache_alignment : 64
address sizes   : 39 bits physical, 48 bits virtual
power management:
processor       : 2
vendor_id       : GenuineIntel
cpu family      : 6
model           : 61
model name      : Intel(R) Core(TM) i7-5500U CPU @ 2.40GHz
stepping        : 4
microcode       : 0x18
cpu MHz         : 2200.031
cache size      : 4096 KB
physical id     : 0
siblings        : 4
core id         : 0
cpu cores       : 2
apicid          : 1
initial apicid  : 1
fpu             : yes
fpu_exception   : yes
cpuid level     : 20
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts
rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq
dtes64 monitor ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c
rdrand lahf_lm abm 3dnowprefetch ida arat epb pln pts dtherm intel_pt
tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2
smep bmi2 erms invpcid rdseed adx smap xsaveopt
bugs            :
bogomips        : 4788.85
clflush size    : 64
cache_alignment : 64
address sizes   : 39 bits physical, 48 bits virtual
power management:

processor       : 3
vendor_id       : GenuineIntel
cpu family      : 6
model           : 61
model name      : Intel(R) Core(TM) i7-5500U CPU @ 2.40GHz
stepping        : 4
microcode       : 0x18
cpu MHz         : 1098.843
cache size      : 4096 KB
physical id     : 0
siblings        : 4
core id         : 1
cpu cores       : 2
apicid          : 3
initial apicid  : 3
fpu             : yes
fpu_exception   : yes
cpuid level     : 20
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts
rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq
dtes64 monitor ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c
rdrand lahf_lm abm 3dnowprefetch ida arat epb pln pts dtherm intel_pt
tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2
smep bmi2 erms invpcid rdseed adx smap xsaveopt
bugs            :
bogomips        : 4788.85
clflush size    : 64
cache_alignment : 64
address sizes   : 39 bits physical, 48 bits virtual
power management:

[7.3.] Module information (from /proc/modules):
ctr 16384 2 - Live 0x0000000000000000
ccm 20480 2 - Live 0x0000000000000000
binfmt_misc 20480 1 - Live 0x0000000000000000
nls_iso8859_1 16384 1 - Live 0x0000000000000000
arc4 16384 2 - Live 0x0000000000000000
intel_rapl 20480 0 - Live 0x0000000000000000
iosf_mbi 16384 1 intel_rapl, Live 0x0000000000000000
snd_hda_codec_realtek 86016 1 - Live 0x0000000000000000
x86_pkg_temp_thermal 16384 0 - Live 0x0000000000000000
snd_hda_codec_generic 77824 1 snd_hda_codec_realtek, Live 0x0000000000000000
intel_powerclamp 16384 0 - Live 0x0000000000000000
coretemp 16384 0 - Live 0x0000000000000000
kvm_intel 159744 0 - Live 0x0000000000000000
snd_hda_codec_hdmi 53248 1 - Live 0x0000000000000000
kvm 507904 1 kvm_intel, Live 0x0000000000000000
crct10dif_pclmul 16384 0 - Live 0x0000000000000000
iwlmvm 307200 0 - Live 0x0000000000000000
uvcvideo 94208 0 - Live 0x0000000000000000
crc32_pclmul 16384 0 - Live 0x0000000000000000
snd_hda_intel 32768 5 - Live 0x0000000000000000
videobuf2_vmalloc 16384 1 uvcvideo, Live 0x0000000000000000
ghash_clmulni_intel 16384 0 - Live 0x0000000000000000
videobuf2_memops 16384 1 videobuf2_vmalloc, Live 0x0000000000000000
snd_hda_controller 36864 1 snd_hda_intel, Live 0x0000000000000000
mac80211 786432 1 iwlmvm, Live 0x0000000000000000
snd_seq_midi 16384 0 - Live 0x0000000000000000
snd_hda_codec 122880 5
snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_codec_hdmi,snd_hda_intel,snd_hda_controller,
Live 0x0000000000000000
aesni_intel 172032 4 - Live 0x0000000000000000
snd_hda_core 36864 5
snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_codec_hdmi,snd_hda_controller,snd_hda_codec,
Live 0x0000000000000000
videobuf2_core 53248 1 uvcvideo, Live 0x0000000000000000
snd_seq_midi_event 16384 1 snd_seq_midi, Live 0x0000000000000000
snd_hwdep 16384 1 snd_hda_codec, Live 0x0000000000000000
v4l2_common 16384 1 videobuf2_core, Live 0x0000000000000000
aes_x86_64 20480 1 aesni_intel, Live 0x0000000000000000
i915 1146880 5 - Live 0x0000000000000000
lrw 16384 1 aesni_intel, Live 0x0000000000000000
snd_pcm 110592 4
snd_hda_codec_hdmi,snd_hda_intel,snd_hda_controller,snd_hda_codec,
Live 0x0000000000000000
gf128mul 16384 1 lrw, Live 0x0000000000000000
videodev 172032 3 uvcvideo,videobuf2_core,v4l2_common, Live 0x0000000000000000
glue_helper 16384 1 aesni_intel, Live 0x0000000000000000
snd_rawmidi 32768 1 snd_seq_midi, Live 0x0000000000000000
media 24576 2 uvcvideo,videodev, Live 0x0000000000000000
iwlwifi 217088 1 iwlmvm, Live 0x0000000000000000
ablk_helper 16384 1 aesni_intel, Live 0x0000000000000000
snd_seq 69632 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
cryptd 24576 3 ghash_clmulni_intel,aesni_intel,ablk_helper, Live
0x0000000000000000
serio_raw 16384 0 - Live 0x0000000000000000
cfg80211 589824 3 iwlmvm,mac80211,iwlwifi, Live 0x0000000000000000
snd_seq_device 16384 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x0000000000000000
drm_kms_helper 126976 1 i915, Live 0x0000000000000000
snd_timer 32768 2 snd_pcm,snd_seq, Live 0x0000000000000000
drm 352256 6 i915,drm_kms_helper, Live 0x0000000000000000
snd 86016 21 snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_seq_device,snd_timer,
Live 0x0000000000000000
lpc_ich 24576 0 - Live 0x0000000000000000
mei_me 24576 0 - Live 0x0000000000000000
shpchp 40960 0 - Live 0x0000000000000000
i2c_algo_bit 16384 1 i915, Live 0x0000000000000000
soundcore 16384 1 snd, Live 0x0000000000000000
mei 94208 1 mei_me, Live 0x0000000000000000
video 28672 1 i915, Live 0x0000000000000000
intel_smartconnect 16384 0 - Live 0x0000000000000000
acpi_pad 20480 0 - Live 0x0000000000000000
mac_hid 16384 0 - Live 0x0000000000000000
parport_pc 36864 0 - Live 0x0000000000000000
ppdev 20480 0 - Live 0x0000000000000000
lp 20480 0 - Live 0x0000000000000000
parport 45056 3 parport_pc,ppdev,lp, Live 0x0000000000000000
autofs4 40960 2 - Live 0x0000000000000000
psmouse 135168 0 - Live 0x0000000000000000
r8169 90112 0 - Live 0x0000000000000000
ahci 36864 3 - Live 0x0000000000000000
libahci 32768 1 ahci, Live 0x0000000000000000
mii 16384 1 r8169, Live 0x0000000000000000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
0000-0cf7 : PCI Bus 0000:00
  0000-001f : dma1
  0020-0021 : pic1
  0040-0043 : timer0
  0050-0053 : timer1
  0060-0060 : keyboard
  0062-0062 : PNP0C09:00
    0062-0062 : EC data
  0064-0064 : keyboard
  0066-0066 : PNP0C09:00
    0066-0066 : EC cmd
  0070-0077 : rtc0
  0080-008f : dma page reg
  00a0-00a1 : pic2
  00c0-00df : dma2
  00f0-00ff : fpu
  0680-069f : pnp 00:02
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
  164e-164f : pnp 00:02
  1800-1803 : ACPI PM1a_EVT_BLK
  1804-1805 : ACPI PM1a_CNT_BLK
  1808-180b : ACPI PM_TMR
  1810-1815 : ACPI CPU throttle
  1830-1833 : iTCO_wdt
  1850-1850 : ACPI PM2_CNT_BLK
  1854-1857 : pnp 00:04
  1860-187f : iTCO_wdt
  1880-189f : ACPI GPE0_BLK
  2000-2fff : PCI Bus 0000:01
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
  ffff-ffff : pnp 00:02
    ffff-ffff : pnp 00:02
      ffff-ffff : pnp 00:02


00000000-00000fff : reserved
00001000-00057fff : System RAM
00058000-00058fff : reserved
00059000-0009dfff : System RAM
0009e000-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000c3fff : PCI Bus 0000:00
000c4000-000c7fff : PCI Bus 0000:00
000c8000-000cbfff : PCI Bus 0000:00
000cc000-000cffff : PCI Bus 0000:00
000d0000-000d3fff : PCI Bus 0000:00
000d4000-000d7fff : PCI Bus 0000:00
000d8000-000dbfff : PCI Bus 0000:00
000dc000-000dffff : PCI Bus 0000:00
000e0000-000e3fff : PCI Bus 0000:00
000e4000-000e7fff : PCI Bus 0000:00
000e8000-000ebfff : PCI Bus 0000:00
000ec000-000effff : PCI Bus 0000:00
000f0000-000fffff : System ROM
00100000-d7ddafff : System RAM
  02000000-02811adc : Kernel code
  02811add-02f34f7f : Kernel data
  030a6000-031e8fff : Kernel bss
d7ddb000-d80b0fff : reserved
d80b1000-dbc05fff : System RAM
dbc06000-dbc64fff : reserved
dbc65000-dc2d1fff : System RAM
dc2d2000-dcd4cfff : ACPI Non-volatile Storage
dcd4d000-dcfacfff : reserved
dcfad000-dcffefff : reserved
dcfff000-dcffffff : System RAM
dd000000-dd7fffff : RAM buffer
dd800000-dfffffff : reserved
  de000000-dfffffff : Graphics Stolen Memory
e0000000-feafffff : PCI Bus 0000:00
  e0000000-efffffff : 0000:00:02.0
  f0000000-f00fffff : PCI Bus 0000:02
    f0000000-f0003fff : 0000:02:00.0
      f0000000-f0003fff : r8169
  f0100000-f02fffff : PCI Bus 0000:01
  f0300000-f04fffff : PCI Bus 0000:01
  f6000000-f6ffffff : 0000:00:02.0
  f7000000-f70fffff : PCI Bus 0000:03
    f7000000-f7001fff : 0000:03:00.0
      f7000000-f7001fff : iwlwifi
  f7100000-f71fffff : PCI Bus 0000:02
    f7100000-f7100fff : 0000:02:00.0
      f7100000-f7100fff : r8169
  f7200000-f720ffff : 0000:00:14.0
    f7200000-f720ffff : xhci-hcd
  f7210000-f7213fff : 0000:00:1b.0
    f7210000-f7213fff : ICH HD audio
  f7214000-f7217fff : 0000:00:03.0
    f7214000-f7217fff : ICH HD audio
  f7218000-f72180ff : 0000:00:1f.3
  f7219000-f72197ff : 0000:00:1f.2
    f7219000-f72197ff : ahci
  f721a000-f721a3ff : 0000:00:1d.0
    f721a000-f721a3ff : ehci_hcd
  f721c000-f721c01f : 0000:00:16.0
    f721c000-f721c01f : mei_me
  f7fe0000-f7feffff : pnp 00:05
  f7ff0000-f7ffffff : pnp 00:05
  f8000000-fbffffff : PCI MMCONFIG 0000 [bus 00-3f]
    f8000000-fbffffff : reserved
      f8000000-fbffffff : pnp 00:05
fec00000-fec00fff : reserved
  fec00000-fec003ff : IOAPIC 0
fed00000-fed03fff : reserved
  fed00000-fed003ff : HPET 0
    fed00000-fed003ff : PNP0103:00
fed10000-fed17fff : pnp 00:05
fed18000-fed18fff : pnp 00:05
fed19000-fed19fff : pnp 00:05
fed1c000-fed1ffff : reserved
  fed1c000-fed1ffff : pnp 00:05
    fed1f410-fed1f414 : iTCO_wdt
fed20000-fed3ffff : pnp 00:05
fed45000-fed8ffff : pnp 00:05
fed90000-fed90fff : dmar0
fed91000-fed91fff : dmar1
fee00000-fee00fff : Local APIC
  fee00000-fee00fff : reserved
ff000000-ffffffff : reserved
  ff000000-ffffffff : INT0800:00
    ff000000-ffffffff : pnp 00:05
100000000-21effffff : System RAM
21f000000-21fffffff : RAM buffer


[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: Intel Corporation Broadwell-U Host Bridge -OPI (rev 09)
        Subsystem: Intel Corporation Broadwell-U Host Bridge -OPI
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR- INTx-
        Latency: 0
        Capabilities: [e0] Vendor Specific Information: Len=0c <?>
00:02.0 VGA compatible controller: Intel Corporation Broadwell-U
Integrated Graphics (rev 09) (prog-if 00 [VGA controller])
        Subsystem: Device 1991:5591
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 50
        Region 0: Memory at f6000000 (64-bit, non-prefetchable) [size=16M]
        Region 2: Memory at e0000000 (64-bit, prefetchable) [size=256M]
        Region 4: I/O ports at f000 [size=64]
        Expansion ROM at <unassigned> [disabled]
        Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
                Address: fee00018  Data: 0000
        Capabilities: [d0] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [a4] PCI Advanced Features
                AFCap: TP+ FLR+
                AFCtrl: FLR-
                AFStatus: TP-
        Kernel driver in use: i915
00:03.0 Audio device: Intel Corporation Broadwell-U Audio Controller (rev 09)
        Subsystem: Intel Corporation Broadwell-U Audio Controller
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 52
        Region 0: Memory at f7214000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit-
                Address: fee00478  Data: 0000
        Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0
                        ExtTag- RBE-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-
AuxPwr- TransPend-
        Kernel driver in use: snd_hda_intel
00:14.0 USB controller: Intel Corporation Wildcat Point-LP USB xHCI
Controller (rev 03) (prog-if 30 [XHCI])
        Subsystem: Intel Corporation Device 7270
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 45
        Region 0: Memory at f7200000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [70] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
                Address: 00000000fee00378  Data: 0000
        Kernel driver in use: xhci_hcd
00:16.0 Communication controller: Intel Corporation Wildcat Point-LP
MEI Controller #1 (rev 03)
        Subsystem: Intel Corporation Device 7270
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 48
        Region 0: Memory at f721c000 (64-bit, non-prefetchable) [size=32]
        Capabilities: [50] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
                Address: 00000000fee003f8  Data: 0000
        Kernel driver in use: mei_me
00:1b.0 Audio device: Intel Corporation Wildcat Point-LP High
Definition Audio Controller (rev 03)
        Subsystem: Intel Corporation Device 7270
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 32, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 51
        Region 0: Memory at f7210000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
                Address: 00000000fee00458  Data: 0000
        Kernel driver in use: snd_hda_intel
00:1c.0 PCI bridge: Intel Corporation Wildcat Point-LP PCI Express
Root Port #1 (rev e3) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00002000-00002fff
        Memory behind bridge: f0100000-f02fffff
        Prefetchable memory behind bridge: 00000000f0300000-00000000f04fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0
                        ExtTag- RBE+
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-
AuxPwr+ TransPend-
                LnkCap: Port #1, Speed 5GT/s, Width x1, ASPM L0s L1,
Exit Latency L0s <1us, L1 <4us
                        ClockPM- Surprise- LLActRep+ BwNot+
                LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x0, TrErr- Train-
SlotClk+ DLActive- BWMgmt- ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-
HotPlug+ Surprise+
                        Slot #0, PowerLimit 0.000W; Interlock- NoCompl+
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet+
CmdCplt- HPIrq+ LinkChg+
                        Control: AttnInd Unknown, PwrInd Unknown,
Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-
PresDet- Interlock-
                        Changed: MRL- PresDet- LinkState-
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-
PMEIntEna+ CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                DevCap2: Completion Timeout: Range ABC, TimeoutDis+,
LTR+, OBFF Via WAKE# ARIFwd-
                DevCtl2: Completion Timeout: 50us to 50ms,
TimeoutDis-, LTR+, OBFF Disabled ARIFwd-
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-
        Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
                Address: fee002b8  Data: 0000
        Capabilities: [90] Subsystem: Intel Corporation Device 7270
        Capabilities: [a0] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: pcieport
00:1c.2 PCI bridge: Intel Corporation Wildcat Point-LP PCI Express
Root Port #3 (rev e3) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        I/O behind bridge: 0000e000-0000efff
        Memory behind bridge: f7100000-f71fffff
        Prefetchable memory behind bridge: 00000000f0000000-00000000f00fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0
                        ExtTag- RBE+
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-
AuxPwr+ TransPend-
                LnkCap: Port #3, Speed 5GT/s, Width x1, ASPM L0s L1,
Exit Latency L0s <512ns, L1 <16us
                        ClockPM- Surprise- LLActRep+ BwNot+
                LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train-
SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-
HotPlug- Surprise-
                        Slot #2, PowerLimit 10.000W; Interlock- NoCompl+
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet-
CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown,
Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-
PresDet+ Interlock-
                        Changed: MRL- PresDet- LinkState+
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-
PMEIntEna+ CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                DevCap2: Completion Timeout: Range ABC, TimeoutDis+,
LTR+, OBFF Not Supported ARIFwd-
                DevCtl2: Completion Timeout: 50us to 50ms,
TimeoutDis-, LTR+, OBFF Disabled ARIFwd-
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-
        Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
                Address: fee002f8  Data: 0000
        Capabilities: [90] Subsystem: Intel Corporation Device 7270
        Capabilities: [a0] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [100 v0] #00
        Capabilities: [200 v1] L1 PM Substates
                L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
ASPM_L1.1+ L1_PM_Substates+
                          PortCommonModeRestoreTime=40us PortTPowerOnTime=10us
        Kernel driver in use: pcieport
00:1c.3 PCI bridge: Intel Corporation Wildcat Point-LP PCI Express
Root Port #4 (rev e3) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: f7000000-f70fffff
        Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0
                        ExtTag- RBE+
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-
AuxPwr+ TransPend-
                LnkCap: Port #4, Speed 5GT/s, Width x1, ASPM L0s L1,
Exit Latency L0s <512ns, L1 <16us
                        ClockPM- Surprise- LLActRep+ BwNot+
                LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train-
SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-
HotPlug- Surprise-
                        Slot #3, PowerLimit 10.000W; Interlock- NoCompl+
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet-
CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown,
Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-
PresDet+ Interlock-
                        Changed: MRL- PresDet- LinkState+
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-
PMEIntEna+ CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                DevCap2: Completion Timeout: Range ABC, TimeoutDis+,
LTR+, OBFF Not Supported ARIFwd-
                DevCtl2: Completion Timeout: 50us to 50ms,
TimeoutDis-, LTR+, OBFF Disabled ARIFwd-
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-
        Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
                Address: fee00338  Data: 0000
        Capabilities: [90] Subsystem: Intel Corporation Device 7270
        Capabilities: [a0] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [100 v0] #00
        Capabilities: [200 v1] L1 PM Substates
                L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
ASPM_L1.1+ L1_PM_Substates+
                          PortCommonModeRestoreTime=40us PortTPowerOnTime=10us
        Kernel driver in use: pcieport
00:1d.0 USB controller: Intel Corporation Wildcat Point-LP USB EHCI
Controller (rev 03) (prog-if 20 [EHCI])
        Subsystem: Intel Corporation Device 7270
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 23
        Region 0: Memory at f721a000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Debug port: BAR=1 offset=00a0
        Capabilities: [98] PCI Advanced Features
                AFCap: TP+ FLR+
                AFCtrl: FLR-
                AFStatus: TP-
        Kernel driver in use: ehci-pci
00:1f.0 ISA bridge: Intel Corporation Wildcat Point-LP LPC Controller (rev 03)
        Subsystem: Intel Corporation Device 7270
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Capabilities: [e0] Vendor Specific Information: Len=0c <?>
        Kernel driver in use: lpc_ich
00:1f.2 SATA controller: Intel Corporation Wildcat Point-LP SATA
Controller [AHCI Mode] (rev 03) (prog-if 01 [AHCI 1.0])
        Subsystem: Intel Corporation Device 7270
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin B routed to IRQ 46
        Region 0: I/O ports at f0b0 [size=8]
        Region 1: I/O ports at f0a0 [size=4]
        Region 2: I/O ports at f090 [size=8]
        Region 3: I/O ports at f080 [size=4]
        Region 4: I/O ports at f060 [size=32]
        Region 5: Memory at f7219000 (32-bit, non-prefetchable) [size=2K]
        Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
                Address: fee003b8  Data: 0000
        Capabilities: [70] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold-)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
        Kernel driver in use: ahci
00:1f.3 SMBus: Intel Corporation Wildcat Point-LP SMBus Controller (rev 03)
        Subsystem: Intel Corporation Device 7270
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin C routed to IRQ 255
        Region 0: Memory at f7218000 (64-bit, non-prefetchable) [size=256]
        Region 4: I/O ports at f040 [size=32]
02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 07)
        Subsystem: Realtek Semiconductor Co., Ltd. Device 0123
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 47
        Region 0: I/O ports at e000 [size=256]
        Region 2: Memory at f7100000 (64-bit, non-prefetchable) [size=4K]
        Region 4: Memory at f0000000 (64-bit, prefetchable) [size=16K]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
                Address: 00000000fee003d8  Data: 0000
        Capabilities: [70] Express (v2) Endpoint, MSI 01
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
<512ns, L1 <64us
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 4096 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-
AuxPwr+ TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Exit Latency L0s unlimited, L1 <64us
                        ClockPM+ Surprise- LLActRep- BwNot-
                LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train-
SlotClk+ DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+,
LTR-, OBFF Not Supported
                DevCtl2: Completion Timeout: 50us to 50ms,
TimeoutDis-, LTR-, OBFF Disabled
                LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-
        Capabilities: [b0] MSI-X: Enable- Count=4 Masked-
                Vector table: BAR=4 offset=00000000
                PBA: BAR=4 offset=00000800
        Capabilities: [d0] Vital Product Data
                No end tag found
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
        Capabilities: [140 v1] Virtual Channel
                Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                Arb:    Fixed- WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=Fixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
                        Status: NegoPending- InProgress-
        Capabilities: [160 v1] Device Serial Number 01-00-00-00-68-4c-e0-00
        Kernel driver in use: r8169

03:00.0 Network controller: Intel Corporation Wireless 7265 (rev 59)
        Subsystem: Intel Corporation Dual Band Wireless-AC 7265
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 49
        Region 0: Memory at f7000000 (64-bit, non-prefetchable) [size=8K]
        Capabilities: [c8] Power Management version 3
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
                Address: 00000000fee00418  Data: 0000
        Capabilities: [40] Express (v2) Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
<512ns, L1 unlimited
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+ FLReset-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-
AuxPwr+ TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L1,
Exit Latency L0s <4us, L1 <32us
                        ClockPM+ Surprise- LLActRep- BwNot-
                LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train-
SlotClk+ DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Range B, TimeoutDis+,
LTR+, OBFF Via WAKE#
                DevCtl2: Completion Timeout: 16ms to 55ms,
TimeoutDis-, LTR+, OBFF Disabled
                LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
        Capabilities: [140 v1] Device Serial Number 60-57-18-ff-ff-62-39-87
        Capabilities: [14c v1] Latency Tolerance Reporting
                Max snoop latency: 3145728ns
                Max no snoop latency: 3145728ns
        Capabilities: [154 v1] L1 PM Substates
                L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
ASPM_L1.1+ L1_PM_Substates+
                          PortCommonModeRestoreTime=30us PortTPowerOnTime=60us
        Kernel driver in use: iwlwifi


[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: Samsung SSD 850  Rev: 1B6Q
  Type:   Direct-Access                    ANSI  SCSI revision: 05


[7.7.] Other information that might be relevant to the problem
1     1189  1238  13    1341  1464  1544  1592  1864  1949  21    2301
 25    2666  274  283  32   37    4093  47   57   69   721  759  873
997        cpuinfo      fs          kmsg        mounts        slabinfo
      timer_stats
10    1196  1242  1327  1345  1465  155   160   1865  1961  212   2304
 2555  267   275  284  33   38    41    48   6    692  73   79   9
999        crypto       interrupts  kpagecount  mtrr          softirqs
      tty
101   1198  1249  1328  1388  1468  1557  1663  1868  1987  2154  2309
 2570  268   276  29   332  382   42    483  643  698  734  791  934
acpi       devices      iomem       kpageflags  net           stat
      uptime
11    12    1251  1329  1393  1484  156   17    1869  1994  22    2316
 2588  269   278  3    34   39    4217  49   644  7    737  8    956
asound     diskstats    ioports     loadavg     pagetypeinfo  swaps
      version
1121  1204  1252  1332  14    15    1561  171   1872  2     2219  2331
 26    27    279  30   344  3914  4250  5    648  70   738  807  973
buddyinfo  dma          irq         locks       partitions    sys
      vmallocinfo
1135  1205  1259  1333  1440  1500  157   172   1892  20    2243  24
 262   270   28   303  35   3924  43    50   650  703  739  811  98
bus        driver       kallsyms    mdstat      sched_debug
sysrq-trigger  vmstat
1147  1212  1262  1334  1456  1521  1572  1797  1898  2005  2249  2417
 2638  271   280  31   350  40    44    53   652  71   740  821  99
cgroups    execdomains  kcore       meminfo     schedstat     sysvipc
      zoneinfo
1173  1219  1267  1335  1460  1529  158   18    19    2019  2290  2423
 2660  272   281  310  351  404   45    55   654  711  75   822  992
cmdline    fb           keys        misc        scsi
thread-self
1186  1232  1293  1337  1463  1534  159   1856  1919  2044  2300  2495
 2663  273   282  311  36   4091  46    56   662  72   750  823  993
consoles   filesystems  key-users   modules     self
timer_list

[X.] Other notes, patches, fixes, workarounds:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1424293
