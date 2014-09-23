From: Nikola Nikolov <nikolov.tmw@gmail.com>
Subject: PROBLEM: [Asus X750LN] Touchpad not recognized
Date: Tue, 23 Sep 2014 14:30:22 +0300
Message-ID: <CAOwx47d=vnxu=a2nE8d3s4LJ=2RNpPzCyuhJi-gicdA5FaBL6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:43590 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754432AbaIWLaY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Sep 2014 07:30:24 -0400
Received: by mail-wg0-f46.google.com with SMTP id a1so4147959wgh.5
        for <linux-input@vger.kernel.org>; Tue, 23 Sep 2014 04:30:22 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

[1.] One line summary of the problem:
[Asus X750LN] Touchpad not recognized

[2.] Full description of the problem/report:
Running the latest mainline kernel, the touchpad on my laptop is not
recognized at all - it's not listed as an input device and nothing
happens whenever I try using it.

[3.] Keywords:

[4.] Kernel version (from /proc/version):
Linux version 3.17.0-031700rc6-generic (apw@gomeisa) (gcc version
4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201409211935 SMP Sun Sep 21
23:37:11 UTC 2014

[5.] Output of Oops.. message (if applicable) with symbolic
information resolved (see Documentation/oops-tracing.txt):
N/A

[6.] A small shell script or example program which triggers the
problem (if possible):
N/A

[7.] Environment:
Description: Ubuntu 14.04.1 LTS
Release: 14.04

[7.1.] Software (add the output of the ver_linux script here):
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux moonwatch-laptop 3.17.0-031700rc6-generic #201409211935 SMP Sun
Sep 21 23:37:11 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux

Gnu C                  4.8
Gnu make               3.81
binutils               2.24
util-linux             2.20.1
mount                  support
module-init-tools      15
e2fsprogs              1.42.9
pcmciautils            018
PPP                    2.4.5
Linux C Library        2.19
Dynamic linker (ldd)   2.19
Procps                 3.3.9
Net-tools              1.60
Kbd                    1.15.5
Sh-utils               8.21
wireless-tools         30
Modules Loaded         snd_hda_codec_realtek snd_hda_codec_hdmi
snd_hda_codec_generic bnep rfcomm bluetooth joydev hid_generic
asus_nb_wmi asus_wmi sparse_keymap intel_rapl x86_pkg_temp_thermal
intel_powerclamp coretemp kvm_intel kvm crct10dif_pclmul crc32_pclmul
ghash_clmulni_intel aesni_intel aes_x86_64 lrw gf128mul glue_helper
ablk_helper cryptd uvcvideo videobuf2_vmalloc serio_raw
videobuf2_memops videobuf2_core uas v4l2_common nouveau usb_storage
videodev media usbhid lpc_ich mxm_wmi ttm mei_me mei snd_soc_rt5640
snd_soc_rl6231 snd_soc_core i2c_hid dw_dmac snd_soc_sst_acpi hid
snd_compress dw_dmac_core snd_pcm_dmaengine 8250_dw
i2c_designware_platform mac_hid i2c_designware_core
spi_pxa2xx_platform wmi snd_hda_intel snd_hda_controller snd_hda_codec
snd_hwdep snd_pcm i915 snd_seq_midi snd_seq_midi_event snd_rawmidi
snd_seq video snd_seq_device snd_timer drm_kms_helper drm snd
soundcore i2c_algo_bit parport_pc ppdev lp parport ahci r8169 libahci
mii sdhci_acpi sdhci

[7.2.] Processor information (from /proc/cpuinfo):
processor : 0
vendor_id : GenuineIntel
cpu family : 6
model : 69
model name : Intel(R) Core(TM) i7-4510U CPU @ 2.00GHz
stepping : 1
microcode : 0x17
cpu MHz : 2003.015
cache size : 4096 KB
physical id : 0
siblings : 4
core id : 0
cpu cores : 2
apicid : 0
initial apicid : 0
fpu : yes
fpu_exception : yes
cpuid level : 13
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor
ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 movbe
popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm ida
arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase
tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt
bugs :
bogomips : 5188.24
clflush size : 64
cache_alignment : 64
address sizes : 39 bits physical, 48 bits virtual
power management:

processor : 1
vendor_id : GenuineIntel
cpu family : 6
model : 69
model name : Intel(R) Core(TM) i7-4510U CPU @ 2.00GHz
stepping : 1
microcode : 0x17
cpu MHz : 1999.968
cache size : 4096 KB
physical id : 0
siblings : 4
core id : 1
cpu cores : 2
apicid : 2
initial apicid : 2
fpu : yes
fpu_exception : yes
cpuid level : 13
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor
ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 movbe
popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm ida
arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase
tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt
bugs :
bogomips : 5188.24
clflush size : 64
cache_alignment : 64
address sizes : 39 bits physical, 48 bits virtual
power management:

processor : 2
vendor_id : GenuineIntel
cpu family : 6
model : 69
model name : Intel(R) Core(TM) i7-4510U CPU @ 2.00GHz
stepping : 1
microcode : 0x17
cpu MHz : 2000.070
cache size : 4096 KB
physical id : 0
siblings : 4
core id : 0
cpu cores : 2
apicid : 1
initial apicid : 1
fpu : yes
fpu_exception : yes
cpuid level : 13
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor
ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 movbe
popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm ida
arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase
tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt
bugs :
bogomips : 5188.24
clflush size : 64
cache_alignment : 64
address sizes : 39 bits physical, 48 bits virtual
power management:

processor : 3
vendor_id : GenuineIntel
cpu family : 6
model : 69
model name : Intel(R) Core(TM) i7-4510U CPU @ 2.00GHz
stepping : 1
microcode : 0x17
cpu MHz : 2844.156
cache size : 4096 KB
physical id : 0
siblings : 4
core id : 1
cpu cores : 2
apicid : 3
initial apicid : 3
fpu : yes
fpu_exception : yes
cpuid level : 13
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor
ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 movbe
popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm ida
arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase
tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt
bugs :
bogomips : 5188.24
clflush size : 64
cache_alignment : 64
address sizes : 39 bits physical, 48 bits virtual
power management:

[7.3.] Module information (from /proc/modules):
snd_hda_codec_realtek 78564 1 - Live 0x0000000000000000
snd_hda_codec_hdmi 52620 1 - Live 0x0000000000000000
snd_hda_codec_generic 70087 1 snd_hda_codec_realtek, Live 0x0000000000000000
bnep 19884 2 - Live 0x0000000000000000
rfcomm 75114 0 - Live 0x0000000000000000
bluetooth 477455 10 bnep,rfcomm, Live 0x0000000000000000
joydev 17587 0 - Live 0x0000000000000000
hid_generic 12559 0 - Live 0x0000000000000000
asus_nb_wmi 21128 0 - Live 0x0000000000000000
asus_wmi 24697 1 asus_nb_wmi, Live 0x0000000000000000
sparse_keymap 13890 1 asus_wmi, Live 0x0000000000000000
intel_rapl 19196 0 - Live 0x0000000000000000
x86_pkg_temp_thermal 14312 0 - Live 0x0000000000000000
intel_powerclamp 19099 0 - Live 0x0000000000000000
coretemp 13638 0 - Live 0x0000000000000000
kvm_intel 149257 0 - Live 0x0000000000000000
kvm 468567 1 kvm_intel, Live 0x0000000000000000
crct10dif_pclmul 14268 0 - Live 0x0000000000000000
crc32_pclmul 13180 0 - Live 0x0000000000000000
ghash_clmulni_intel 13230 0 - Live 0x0000000000000000
aesni_intel 165515 0 - Live 0x0000000000000000
aes_x86_64 17131 1 aesni_intel, Live 0x0000000000000000
lrw 13323 1 aesni_intel, Live 0x0000000000000000
gf128mul 14951 1 lrw, Live 0x0000000000000000
glue_helper 14095 1 aesni_intel, Live 0x0000000000000000
ablk_helper 13597 1 aesni_intel, Live 0x0000000000000000
cryptd 20531 3 ghash_clmulni_intel,aesni_intel,ablk_helper, Live
0x0000000000000000
uvcvideo 86628 0 - Live 0x0000000000000000
videobuf2_vmalloc 13216 1 uvcvideo, Live 0x0000000000000000
serio_raw 13483 0 - Live 0x0000000000000000
videobuf2_memops 13362 1 videobuf2_vmalloc, Live 0x0000000000000000
videobuf2_core 59907 1 uvcvideo, Live 0x0000000000000000
uas 27623 0 - Live 0x0000000000000000
v4l2_common 15715 1 videobuf2_core, Live 0x0000000000000000
nouveau 1321757 0 - Live 0x0000000000000000
usb_storage 67010 1 uas, Live 0x0000000000000000
videodev 163831 3 uvcvideo,videobuf2_core,v4l2_common, Live 0x0000000000000000
media 22008 2 uvcvideo,videodev, Live 0x0000000000000000
usbhid 53122 0 - Live 0x0000000000000000
lpc_ich 21176 0 - Live 0x0000000000000000
mxm_wmi 13021 1 nouveau, Live 0x0000000000000000
ttm 90376 1 nouveau, Live 0x0000000000000000
mei_me 19524 0 - Live 0x0000000000000000
mei 88810 1 mei_me, Live 0x0000000000000000
snd_soc_rt5640 93123 0 - Live 0x0000000000000000
snd_soc_rl6231 13037 1 snd_soc_rt5640, Live 0x0000000000000000
snd_soc_core 207547 1 snd_soc_rt5640, Live 0x0000000000000000
i2c_hid 19065 0 - Live 0x0000000000000000
dw_dmac 12835 0 - Live 0x0000000000000000
snd_soc_sst_acpi 13007 0 - Live 0x0000000000000000
hid 110572 3 hid_generic,usbhid,i2c_hid, Live 0x0000000000000000
snd_compress 19435 1 snd_soc_core, Live 0x0000000000000000
dw_dmac_core 28566 1 dw_dmac, Live 0x0000000000000000
snd_pcm_dmaengine 15229 1 snd_soc_core, Live 0x0000000000000000
8250_dw 13474 0 - Live 0x0000000000000000
i2c_designware_platform 13025 0 - Live 0x0000000000000000
mac_hid 13275 0 - Live 0x0000000000000000
i2c_designware_core 14990 1 i2c_designware_platform, Live 0x0000000000000000
spi_pxa2xx_platform 23302 0 - Live 0x0000000000000000
wmi 19379 3 asus_wmi,nouveau,mxm_wmi, Live 0x0000000000000000
snd_hda_intel 30783 5 - Live 0x0000000000000000
snd_hda_controller 32234 1 snd_hda_intel, Live 0x0000000000000000
snd_hda_codec 145035 5
snd_hda_codec_realtek,snd_hda_codec_hdmi,snd_hda_codec_generic,snd_hda_intel,snd_hda_controller,
Live 0x0000000000000000
snd_hwdep 17709 1 snd_hda_codec, Live 0x0000000000000000
snd_pcm 105052 7
snd_hda_codec_hdmi,snd_soc_rt5640,snd_soc_core,snd_pcm_dmaengine,snd_hda_intel,snd_hda_controller,snd_hda_codec,
Live 0x0000000000000000
i915 993210 7 - Live 0x0000000000000000
snd_seq_midi 13564 0 - Live 0x0000000000000000
snd_seq_midi_event 14899 1 snd_seq_midi, Live 0x0000000000000000
snd_rawmidi 31197 1 snd_seq_midi, Live 0x0000000000000000
snd_seq 63540 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
video 20569 3 asus_wmi,nouveau,i915, Live 0x0000000000000000
snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x0000000000000000
snd_timer 30118 2 snd_pcm,snd_seq, Live 0x0000000000000000
drm_kms_helper 99872 2 nouveau,i915, Live 0x0000000000000000
drm 318542 8 nouveau,ttm,i915,drm_kms_helper, Live 0x0000000000000000
snd 84025 23 snd_hda_codec_realtek,snd_hda_codec_hdmi,snd_hda_codec_generic,snd_soc_core,snd_compress,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_seq_device,snd_timer,
Live 0x0000000000000000
soundcore 15091 2 snd_hda_codec,snd, Live 0x0000000000000000
i2c_algo_bit 13564 2 nouveau,i915, Live 0x0000000000000000
parport_pc 32906 0 - Live 0x0000000000000000
ppdev 17711 0 - Live 0x0000000000000000
lp 17799 0 - Live 0x0000000000000000
parport 42481 3 parport_pc,ppdev,lp, Live 0x0000000000000000
ahci 30167 3 - Live 0x0000000000000000
r8169 77680 0 - Live 0x0000000000000000
libahci 32533 1 ahci, Live 0x0000000000000000
mii 13981 1 r8169, Live 0x0000000000000000
sdhci_acpi 13395 0 - Live 0x0000000000000000
sdhci 44159 1 sdhci_acpi, Live 0x0000000000000000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
cat /proc/ioports:
0000-0cf7 : PCI Bus 0000:00
  0000-001f : dma1
  0020-0021 : pic1
  0040-0043 : timer0
  0050-0053 : timer1
  0060-0060 : keyboard
  0064-0064 : keyboard
  0070-0077 : rtc0
  0080-008f : dma page reg
  00a0-00a1 : pic2
  00c0-00df : dma2
  00f0-00ff : fpu
  03c0-03df : vesafb
  04d0-04d1 : pnp 00:04
  0680-069f : pnp 00:01
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
  164e-164f : pnp 00:01
  1800-1803 : ACPI PM1a_EVT_BLK
  1804-1805 : ACPI PM1a_CNT_BLK
  1808-180b : ACPI PM_TMR
  1810-1815 : ACPI CPU throttle
  1830-1833 : iTCO_wdt
  1850-1850 : ACPI PM2_CNT_BLK
  1854-1857 : pnp 00:03
  1860-187f : iTCO_wdt
  1880-189f : ACPI GPE0_BLK
  1c00-1cfe : pnp 00:01
  1d00-1dfe : pnp 00:01
  1e00-1efe : pnp 00:01
  1f00-1ffe : pnp 00:01
  2000-2fff : PCI Bus 0000:01
  d000-dfff : PCI Bus 0000:04
    d000-d07f : 0000:04:00.0
  e000-efff : PCI Bus 0000:03
    e000-e0ff : 0000:03:00.0
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
  ffff-ffff : pnp 00:01
    ffff-ffff : pnp 00:01
      ffff-ffff : pnp 00:01

cat /proc/iomem:
00000000-00000fff : reserved
00001000-0009d7ff : System RAM
0009d800-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000cebff : Video ROM
000d0000-000d3fff : PCI Bus 0000:00
000d4000-000d7fff : PCI Bus 0000:00
000d8000-000dbfff : PCI Bus 0000:00
000dc000-000dffff : PCI Bus 0000:00
000e0000-000fffff : reserved
  000e0000-000e3fff : PCI Bus 0000:00
  000e4000-000e7fff : PCI Bus 0000:00
  000f0000-000fffff : System ROM
00100000-b8a8cfff : System RAM
  01000000-017a9977 : Kernel code
  017a9978-01d1e4ff : Kernel data
  01e80000-01fc6fff : Kernel bss
b8a8d000-b8a93fff : ACPI Non-volatile Storage
b8a94000-b8ecbfff : System RAM
b8ecc000-b943cfff : reserved
b943d000-c8c15fff : System RAM
c8c16000-c8c9ffff : reserved
c8ca0000-c8e7bfff : System RAM
c8e7c000-c9615fff : ACPI Non-volatile Storage
c9616000-c9ffdfff : reserved
c9ffe000-c9ffefff : System RAM
c9fff000-caffffff : RAM buffer
cb000000-cf1fffff : reserved
  cb200000-cf1fffff : Graphics Stolen Memory
cf200000-feafffff : PCI Bus 0000:00
  cf200000-cf3fffff : PCI Bus 0000:01
  cf400000-cf5fffff : PCI Bus 0000:01
  d0000000-dfffffff : 0000:00:02.0
  e0000000-f1ffffff : PCI Bus 0000:04
    e0000000-efffffff : 0000:04:00.0
    f0000000-f1ffffff : 0000:04:00.0
  f2100000-f21fffff : PCI Bus 0000:03
    f2100000-f2103fff : 0000:03:00.0
      f2100000-f2103fff : r8169
  f6000000-f70fffff : PCI Bus 0000:04
    f6000000-f6ffffff : 0000:04:00.0
    f7000000-f707ffff : 0000:04:00.0
  f7400000-f77fffff : 0000:00:02.0
  f7800000-f78fffff : PCI Bus 0000:03
    f7800000-f7800fff : 0000:03:00.0
      f7800000-f7800fff : r8169
  f7900000-f79fffff : PCI Bus 0000:02
    f7900000-f7907fff : 0000:02:00.0
  f7a00000-f7a0ffff : 0000:00:14.0
    f7a00000-f7a0ffff : xhci_hcd
  f7a10000-f7a13fff : 0000:00:1b.0
    f7a10000-f7a13fff : ICH HD audio
  f7a14000-f7a17fff : 0000:00:03.0
    f7a14000-f7a17fff : ICH HD audio
  f7a19000-f7a190ff : 0000:00:1f.3
  f7a1a000-f7a1a7ff : 0000:00:1f.2
    f7a1a000-f7a1a7ff : ahci
  f7a1b000-f7a1b3ff : 0000:00:1d.0
    f7a1b000-f7a1b3ff : ehci_hcd
  f7a1d000-f7a1d01f : 0000:00:16.0
    f7a1d000-f7a1d01f : mei_me
  f7fdf000-f7fdffff : pnp 00:08
  f7fe0000-f7feffff : pnp 00:08
  f8000000-fbffffff : PCI MMCONFIG 0000 [bus 00-3f]
    f8000000-fbffffff : reserved
      f8000000-fbffffff : pnp 00:08
  fe104000-fe104fff : pnp 00:07
  fe106000-fe106fff : pnp 00:07
  fe10e000-fe10efff : pnp 00:07
  fe111000-fe111007 : pnp 00:07
  fe111014-fe111fff : pnp 00:07
  fe112000-fe112fff : pnp 00:07
fec00000-fec00fff : reserved
  fec00000-fec003ff : IOAPIC 0
fed00000-fed03fff : reserved
  fed00000-fed003ff : HPET 0
    fed00000-fed003ff : PNP0103:00
fed10000-fed17fff : pnp 00:08
fed18000-fed18fff : pnp 00:08
fed19000-fed19fff : pnp 00:08
fed1c000-fed1ffff : reserved
  fed1c000-fed1ffff : pnp 00:08
    fed1f410-fed1f414 : iTCO_wdt
fed20000-fed3ffff : pnp 00:08
fed40000-fed44fff : pnp 00:00
fed45000-fed8ffff : pnp 00:08
fed90000-fed93fff : pnp 00:08
fee00000-fee00fff : Local APIC
  fee00000-fee00fff : reserved
ff000000-ffffffff : reserved
  ff000000-ffffffff : INT0800:00
    ff000000-ffffffff : pnp 00:08
100000000-22fdfffff : System RAM
22fe00000-22fffffff : RAM buffer

[7.5.] PCI information ('lspci -vvv' as root):
00:00.0 Host bridge: Intel Corporation Haswell-ULT DRAM Controller (rev 0b)
Subsystem: ASUSTeK Computer Inc. Device 14fd
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR- INTx-
Latency: 0
Capabilities: [e0] Vendor Specific Information: Len=0c <?>

00:02.0 VGA compatible controller: Intel Corporation Haswell-ULT
Integrated Graphics Controller (rev 0b) (prog-if 00 [VGA controller])
Subsystem: ASUSTeK Computer Inc. Device 14fd
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 47
Region 0: Memory at f7400000 (64-bit, non-prefetchable) [size=4M]
Region 2: Memory at d0000000 (64-bit, prefetchable) [size=256M]
Region 4: I/O ports at f000 [size=64]
Expansion ROM at <unassigned> [disabled]
Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
Address: fee0f00c  Data: 4152
Capabilities: [d0] Power Management version 2
Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [a4] PCI Advanced Features
AFCap: TP+ FLR+
AFCtrl: FLR-
AFStatus: TP-
Kernel driver in use: i915

00:03.0 Audio device: Intel Corporation Haswell-ULT HD Audio Controller (rev 0b)
Subsystem: ASUSTeK Computer Inc. Device 14fd
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 50
Region 0: Memory at f7a14000 (64-bit, non-prefetchable) [size=16K]
Capabilities: [50] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit-
Address: fee0f00c  Data: 4192
Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0
ExtTag- RBE-
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
Kernel driver in use: snd_hda_intel

00:14.0 USB controller: Intel Corporation Lynx Point-LP USB xHCI HC
(rev 04) (prog-if 30 [XHCI])
Subsystem: ASUSTeK Computer Inc. Device 201f
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 44
Region 0: Memory at f7a00000 (64-bit, non-prefetchable) [size=64K]
Capabilities: [70] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
Address: 00000000fee0500c  Data: 41e1
Kernel driver in use: xhci_hcd

00:16.0 Communication controller: Intel Corporation Lynx Point-LP HECI
#0 (rev 04)
Subsystem: ASUSTeK Computer Inc. Device 14fd
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 48
Region 0: Memory at f7a1d000 (64-bit, non-prefetchable) [size=32]
Capabilities: [50] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
Address: 00000000fee0f00c  Data: 4172
Kernel driver in use: mei_me

00:1b.0 Audio device: Intel Corporation Lynx Point-LP HD Audio
Controller (rev 04)
Subsystem: ASUSTeK Computer Inc. Device 14fd
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 49
Region 0: Memory at f7a10000 (64-bit, non-prefetchable) [size=16K]
Capabilities: [50] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
Address: 00000000fee0f00c  Data: 4182
Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0
ExtTag- RBE-
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
Capabilities: [100 v1] Virtual Channel
Caps: LPEVC=0 RefClk=100ns PATEntryBits=1
Arb: Fixed- WRR32- WRR64- WRR128-
Ctrl: ArbSelect=Fixed
Status: InProgress-
VC0: Caps: PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
Arb: Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
Ctrl: Enable+ ID=0 ArbSelect=Fixed TC/VC=01
Status: NegoPending- InProgress-
VC1: Caps: PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
Arb: Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
Ctrl: Enable- ID=2 ArbSelect=Fixed TC/VC=04
Status: NegoPending- InProgress-
Kernel driver in use: snd_hda_intel

00:1c.0 PCI bridge: Intel Corporation Lynx Point-LP PCI Express Root
Port 1 (rev e4) (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
I/O behind bridge: 00002000-00002fff
Memory behind bridge: cf200000-cf3fffff
Prefetchable memory behind bridge: 00000000cf400000-00000000cf5fffff
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0
ExtTag- RBE+
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
LnkCap: Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s
<1us, L1 <4us
ClockPM- Surprise- LLActRep+ BwNot+
LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-
SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
Slot #0, PowerLimit 0.000W; Interlock- NoCompl+
SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq+ LinkChg+
Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
Changed: MRL- PresDet- LinkState-
RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
RootCap: CRSVisible-
RootSta: PME ReqID 0000, PMEStatus- PMEPending-
DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Via
WAKE# ARIFwd-
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF
Disabled ARIFwd-
LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
Address: fee0f00c  Data: 4171
Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 14fd
Capabilities: [a0] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Kernel driver in use: pcieport

00:1c.2 PCI bridge: Intel Corporation Lynx Point-LP PCI Express Root
Port 3 (rev e4) (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
I/O behind bridge: 0000f000-00000fff
Memory behind bridge: f7900000-f79fffff
Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0
ExtTag- RBE+
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
LnkCap: Port #3, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s
<512ns, L1 <16us
ClockPM- Surprise- LLActRep+ BwNot+
LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+
BWMgmt+ ABWMgmt-
SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
Slot #2, PowerLimit 10.000W; Interlock- NoCompl+
SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
Changed: MRL- PresDet- LinkState-
RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
RootCap: CRSVisible-
RootSta: PME ReqID 0000, PMEStatus- PMEPending-
DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Not
Supported ARIFwd-
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF
Disabled ARIFwd-
LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
Address: fee0f00c  Data: 4191
Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 14fd
Capabilities: [a0] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [100 v0] #00
Capabilities: [200 v1] L1 PM Substates
L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
 PortCommonModeRestoreTime=40us PortTPowerOnTime=10us
Kernel driver in use: pcieport

00:1c.3 PCI bridge: Intel Corporation Lynx Point-LP PCI Express Root
Port 4 (rev e4) (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
I/O behind bridge: 0000e000-0000efff
Memory behind bridge: f7800000-f78fffff
Prefetchable memory behind bridge: 00000000f2100000-00000000f21fffff
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0
ExtTag- RBE+
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
LnkCap: Port #4, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s
<512ns, L1 <16us
ClockPM- Surprise- LLActRep+ BwNot+
LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+
BWMgmt+ ABWMgmt-
SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
Slot #3, PowerLimit 10.000W; Interlock- NoCompl+
SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
Changed: MRL- PresDet- LinkState-
RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
RootCap: CRSVisible-
RootSta: PME ReqID 0000, PMEStatus- PMEPending-
DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Not
Supported ARIFwd-
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF
Disabled ARIFwd-
LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
Address: fee0f00c  Data: 41b1
Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 14fd
Capabilities: [a0] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [100 v0] #00
Capabilities: [200 v1] L1 PM Substates
L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
 PortCommonModeRestoreTime=40us PortTPowerOnTime=10us
Kernel driver in use: pcieport

00:1c.4 PCI bridge: Intel Corporation Lynx Point-LP PCI Express Root
Port 5 (rev e4) (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
I/O behind bridge: 0000d000-0000dfff
Memory behind bridge: f6000000-f70fffff
Prefetchable memory behind bridge: 00000000e0000000-00000000f1ffffff
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0
ExtTag- RBE+
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
LnkCap: Port #5, Speed 5GT/s, Width x4, ASPM L0s L1, Exit Latency L0s
<512ns, L1 <16us
ClockPM- Surprise- LLActRep+ BwNot+
LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 5GT/s, Width x4, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
Slot #4, PowerLimit 25.000W; Interlock- NoCompl+
SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
Changed: MRL- PresDet- LinkState-
RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
RootCap: CRSVisible-
RootSta: PME ReqID 0000, PMEStatus- PMEPending-
DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Not
Supported ARIFwd-
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF
Disabled ARIFwd-
LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
Address: fee0f00c  Data: 41c1
Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 14fd
Capabilities: [a0] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [100 v0] #00
Capabilities: [200 v1] L1 PM Substates
L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
 PortCommonModeRestoreTime=40us PortTPowerOnTime=10us
Kernel driver in use: pcieport

00:1d.0 USB controller: Intel Corporation Lynx Point-LP USB EHCI #1
(rev 04) (prog-if 20 [EHCI])
Subsystem: ASUSTeK Computer Inc. Device 14fd
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 23
Region 0: Memory at f7a1b000 (32-bit, non-prefetchable) [size=1K]
Capabilities: [50] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [58] Debug port: BAR=1 offset=00a0
Capabilities: [98] PCI Advanced Features
AFCap: TP+ FLR+
AFCtrl: FLR-
AFStatus: TP-
Kernel driver in use: ehci-pci

00:1f.0 ISA bridge: Intel Corporation Lynx Point-LP LPC Controller (rev 04)
Subsystem: ASUSTeK Computer Inc. Device 14fd
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Capabilities: [e0] Vendor Specific Information: Len=0c <?>
Kernel driver in use: lpc_ich

00:1f.2 SATA controller: Intel Corporation Lynx Point-LP SATA
Controller 1 [AHCI mode] (rev 04) (prog-if 01 [AHCI 1.0])
Subsystem: ASUSTeK Computer Inc. Device 14fd
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin B routed to IRQ 45
Region 0: I/O ports at f0b0 [size=8]
Region 1: I/O ports at f0a0 [size=4]
Region 2: I/O ports at f090 [size=8]
Region 3: I/O ports at f080 [size=4]
Region 4: I/O ports at f060 [size=32]
Region 5: Memory at f7a1a000 (32-bit, non-prefetchable) [size=2K]
Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
Address: fee0500c  Data: 4122
Capabilities: [70] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
Kernel driver in use: ahci

00:1f.3 SMBus: Intel Corporation Lynx Point-LP SMBus Controller (rev 04)
Subsystem: ASUSTeK Computer Inc. Device 14fd
Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Interrupt: pin C routed to IRQ 3
Region 0: Memory at f7a19000 (64-bit, non-prefetchable) [size=256]
Region 4: I/O ports at f040 [size=32]

02:00.0 Network controller: Broadcom Corporation BCM43142 802.11b/g/n (rev 01)
Subsystem: Lite-On Communications Inc Device 6605
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 3
Region 0: Memory at f7900000 (64-bit, non-prefetchable) [size=32K]
Capabilities: [40] Power Management version 3
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=2 PME-
Capabilities: [58] Vendor Specific Information: Len=78 <?>
Capabilities: [48] MSI: Enable- Count=1/1 Maskable- 64bit+
Address: 0000000000000000  Data: 0000
Capabilities: [d0] Express (v1) Endpoint, MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 512 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency
L0s <4us, L1 <64us
ClockPM+ Surprise- LLActRep- BwNot-
LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-
Capabilities: [100 v1] Advanced Error Reporting
UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
CESta: RxErr+ BadTLP+ BadDLLP- Rollover- Timeout- NonFatalErr-
CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
Capabilities: [13c v1] Virtual Channel
Caps: LPEVC=0 RefClk=100ns PATEntryBits=1
Arb: Fixed- WRR32- WRR64- WRR128-
Ctrl: ArbSelect=Fixed
Status: InProgress-
VC0: Caps: PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
Arb: Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
Ctrl: Enable+ ID=0 ArbSelect=Fixed TC/VC=01
Status: NegoPending- InProgress-
Capabilities: [160 v1] Device Serial Number 00-00-5e-ff-ff-82-18-cf
Capabilities: [16c v1] Power Budgeting <?>

03:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 0c)
Subsystem: ASUSTeK Computer Inc. Device 200f
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 46
Region 0: I/O ports at e000 [size=256]
Region 2: Memory at f7800000 (64-bit, non-prefetchable) [size=4K]
Region 4: Memory at f2100000 (64-bit, prefetchable) [size=16K]
Capabilities: [40] Power Management version 3
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
Address: 00000000fee0200c  Data: 4142
Capabilities: [70] Express (v2) Endpoint, MSI 01
DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 4096 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency
L0s unlimited, L1 <64us
ClockPM+ Surprise- LLActRep- BwNot-
LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-
DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR+, OBFF Via
message/WAKE#
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Disabled
LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [b0] MSI-X: Enable- Count=4 Masked-
Vector table: BAR=4 offset=00000000
PBA: BAR=4 offset=00000800
Capabilities: [d0] Vital Product Data
Unknown small resource type 00, will not decode more.
Capabilities: [100 v1] Advanced Error Reporting
UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
Capabilities: [140 v1] Virtual Channel
Caps: LPEVC=0 RefClk=100ns PATEntryBits=1
Arb: Fixed- WRR32- WRR64- WRR128-
Ctrl: ArbSelect=Fixed
Status: InProgress-
VC0: Caps: PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
Arb: Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
Ctrl: Enable+ ID=0 ArbSelect=Fixed TC/VC=01
Status: NegoPending- InProgress-
Capabilities: [160 v1] Device Serial Number 01-00-00-00-68-4c-e0-00
Capabilities: [170 v1] Latency Tolerance Reporting
Max snoop latency: 3145728ns
Max no snoop latency: 3145728ns
Kernel driver in use: r8169

04:00.0 3D controller: NVIDIA Corporation GM108M [GeForce 840M] (rev a2)
Subsystem: ASUSTeK Computer Inc. Device 14fd
Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Interrupt: pin A routed to IRQ 16
Region 0: Memory at f6000000 (32-bit, non-prefetchable) [size=16M]
Region 1: Memory at e0000000 (64-bit, prefetchable) [size=256M]
Region 3: Memory at f0000000 (64-bit, prefetchable) [size=32M]
Region 5: I/O ports at d000 [size=128]
Expansion ROM at f7000000 [disabled] [size=512K]
Capabilities: [60] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [68] MSI: Enable- Count=1/1 Maskable- 64bit+
Address: 0000000000000000  Data: 0000
Capabilities: [78] Express (v2) Endpoint, MSI 00
DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s unlimited, L1 <64us
ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
MaxPayload 128 bytes, MaxReadReq 512 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
LnkCap: Port #0, Speed 8GT/s, Width x4, ASPM L0s L1, Exit Latency L0s
<512ns, L1 <4us
ClockPM+ Surprise- LLActRep- BwNot-
LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 5GT/s, Width x4, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
DevCap2: Completion Timeout: Range AB, TimeoutDis+, LTR+, OBFF Via message
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Disabled
LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [100 v1] Virtual Channel
Caps: LPEVC=0 RefClk=100ns PATEntryBits=1
Arb: Fixed- WRR32- WRR64- WRR128-
Ctrl: ArbSelect=Fixed
Status: InProgress-
VC0: Caps: PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
Arb: Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
Ctrl: Enable+ ID=0 ArbSelect=Fixed TC/VC=01
Status: NegoPending- InProgress-
Capabilities: [250 v1] Latency Tolerance Reporting
Max snoop latency: 3145728ns
Max no snoop latency: 3145728ns
Capabilities: [258 v1] L1 PM Substates
L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
 PortCommonModeRestoreTime=255us PortTPowerOnTime=10us
Capabilities: [128 v1] Power Budgeting <?>
Capabilities: [600 v1] Vendor Specific Information: ID=0001 Rev=1 Len=024 <?>
Capabilities: [900 v1] #19

[7.6.] SCSI information (from /proc/scsi/scsi):
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST1000LM024 HN-M Rev: 0001
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: CORSAIR FORCE LX Rev: 7A
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: HL-DT-ST Model: DVDRAM GUA0N     Rev: AS00
  Type:   CD-ROM                           ANSI  SCSI revision: 05
Host: scsi3 Channel: 00 Id: 00 Lun: 00
  Vendor: Multiple Model: Card  Reader     Rev: 1.00
  Type:   Direct-Access                    ANSI  SCSI revision: 04

[7.7.] Other information that might be relevant to the problem (please
look in /proc and include all information that you think to be
relevant):
Downstream report may be found at
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1371914 .

No results executing at a terminal:
cat /proc/bus/input/devices | grep Touch
