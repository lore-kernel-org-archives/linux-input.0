From: Jon Vaughan <jsvaughan@gmail.com>
Subject: PROBLEM: [Lenovo Thinkpad t440s] Touchpad periodically stops working
Date: Wed, 29 Jan 2014 22:52:47 +0000
Message-ID: <CAO4C+K5Z3U5Ft12aEPwhFOAxcF_UWP+3Hw9WA8xcjw=k22ZvRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:61659 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbaA2Wws (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jan 2014 17:52:48 -0500
Received: by mail-ig0-f176.google.com with SMTP id j1so16237860iga.3
        for <linux-input@vger.kernel.org>; Wed, 29 Jan 2014 14:52:47 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

[Lenovo Thinkpad t440s] Touchpad periodically stops working

Every 15 minutes or so, the cursor stops reacting to input from the
touchpad or trackpoint.  In Windows on the same machine there is no
problem. In syslog you see:

Jan 12 19:08:43 mv8 kernel: [ 8460.304134] psmouse serio1: TouchPad at
isa0060/serio1/input0 lost sync at byte 1
Jan 12 19:08:43 mv8 kernel: [ 8460.305321] psmouse serio1: TouchPad at
isa0060/serio1/input0 lost sync at byte 1
Jan 12 19:08:43 mv8 kernel: [ 8460.306606] psmouse serio1: TouchPad at
isa0060/serio1/input0 lost sync at byte 1
Jan 12 19:08:43 mv8 kernel: [ 8460.307792] psmouse serio1: TouchPad at
isa0060/serio1/input0 lost sync at byte 1
Jan 12 19:08:43 mv8 kernel: [ 8460.309002] psmouse serio1: TouchPad at
isa0060/serio1/input0 lost sync at byte 1

Occassionally the touchpad will resync, but at other times the cursor
will remain unresponsive and can only be brought back to life with a
sudo rmmod psmouse, sudo modprobe psmouse

The Ubuntu Lauchpad report (where I was requested to make this
submission) is here:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1268365

[4.] Kernel version
jon@mv8:~$ cat /proc/version
Linux version 3.13.1-031301-generic (apw@gomeisa) (gcc version 4.6.3
(Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201401291035 SMP Wed Jan 29 15:37:43
UTC 2014

[7.] Environment
jon@mv8:~$ lsb_release -rd
Description: Ubuntu 13.10
Release: 13.10

[7.1.] Software
sh ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux mv8 3.13.1-031301-generic #201401291035 SMP Wed Jan 29 15:37:43
UTC 2014 x86_64 x86_64 x86_64 GNU/Linux

Gnu C                  4.8
Gnu make               3.81
binutils               2.23.52.20130913
util-linux             2.20.1
mount                  support
module-init-tools      9
e2fsprogs              1.42.8
pcmciautils            018
PPP                    2.4.5
Linux C Library        2.17
Dynamic linker (ldd)   2.17
Procps                 3.3.3
Net-tools              1.60
Kbd                    1.15.5
Sh-utils               8.20
wireless-tools         30
Modules Loaded         ctr ccm pci_stub vboxpci vboxnetadp vboxnetflt
vboxdrv parport_pc ppdev rfcomm bnep snd_hda_codec_hdmi binfmt_misc
intel_rapl x86_pkg_temp_thermal intel_powerclamp coretemp arc4
kvm_intel kvm crct10dif_pclmul crc32_pclmul uvcvideo
ghash_clmulni_intel iwlmvm aesni_intel aes_x86_64 lrw gf128mul
mac80211 videobuf2_vmalloc glue_helper ablk_helper videobuf2_memops
cryptd joydev videobuf2_core videodev cdc_mbim cdc_ncm usbnet mii
cdc_wdm cdc_acm microcode btusb snd_seq_midi bluetooth
snd_seq_midi_event snd_rawmidi thinkpad_acpi nls_iso8859_1 nvram
iwlwifi snd_hda_codec_realtek i915 snd_hda_intel drm_kms_helper
snd_hda_codec psmouse snd_hwdep snd_pcm drm serio_raw rtsx_pci_ms
snd_seq cfg80211 snd_seq_device memstick mei_me i2c_algo_bit
snd_page_alloc mei lpc_ich snd_timer video snd wmi soundcore mac_hid
intel_smartconnect lp parport hid_generic usbhid hid rtsx_pci_sdmmc
ahci e1000e libahci rtsx_pci ptp pps_core

[7.2.] Processor information (from /proc/cpuinfo):
cat /proc/cpuinfo
processor : 0
vendor_id : GenuineIntel
cpu family : 6
model : 69
model name : Intel(R) Core(TM) i7-4600U CPU @ 2.10GHz
stepping : 1
microcode : 0x17
cpu MHz : 2099.988
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
ds_cpl vmx smx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2
x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand
lahf_lm abm ida arat epb xsaveopt pln pts dtherm tpr_shadow vnmi
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms
invpcid rtm
bogomips : 5387.76
clflush size : 64
cache_alignment : 64
address sizes : 39 bits physical, 48 bits virtual
power management:

processor : 1
vendor_id : GenuineIntel
cpu family : 6
model : 69
model name : Intel(R) Core(TM) i7-4600U CPU @ 2.10GHz
stepping : 1
microcode : 0x17
cpu MHz : 2103.785
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
ds_cpl vmx smx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2
x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand
lahf_lm abm ida arat epb xsaveopt pln pts dtherm tpr_shadow vnmi
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms
invpcid rtm
bogomips : 5387.76
clflush size : 64
cache_alignment : 64
address sizes : 39 bits physical, 48 bits virtual
power management:

processor : 2
vendor_id : GenuineIntel
cpu family : 6
model : 69
model name : Intel(R) Core(TM) i7-4600U CPU @ 2.10GHz
stepping : 1
microcode : 0x17
cpu MHz : 2099.988
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
ds_cpl vmx smx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2
x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand
lahf_lm abm ida arat epb xsaveopt pln pts dtherm tpr_shadow vnmi
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms
invpcid rtm
bogomips : 5387.76
clflush size : 64
cache_alignment : 64
address sizes : 39 bits physical, 48 bits virtual
power management:

processor : 3
vendor_id : GenuineIntel
cpu family : 6
model : 69
model name : Intel(R) Core(TM) i7-4600U CPU @ 2.10GHz
stepping : 1
microcode : 0x17
cpu MHz : 2344.148
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
ds_cpl vmx smx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2
x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand
lahf_lm abm ida arat epb xsaveopt pln pts dtherm tpr_shadow vnmi
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms
invpcid rtm
bogomips : 5387.76
clflush size : 64
cache_alignment : 64
address sizes : 39 bits physical, 48 bits virtual
power management:

[7.3.] Module information (from /proc/modules):
cat /proc/modules
ctr 13193 1 - Live 0x0000000000000000
ccm 17856 1 - Live 0x0000000000000000
pci_stub 12622 1 - Live 0x0000000000000000
vboxpci 23194 0 - Live 0x0000000000000000 (OF)
vboxnetadp 25670 0 - Live 0x0000000000000000 (OF)
vboxnetflt 27613 0 - Live 0x0000000000000000 (OF)
vboxdrv 335365 3 vboxpci,vboxnetadp,vboxnetflt, Live 0x0000000000000000 (OF)
parport_pc 36962 0 - Live 0x0000000000000000
ppdev 17711 0 - Live 0x0000000000000000
rfcomm 74748 12 - Live 0x0000000000000000
bnep 19884 2 - Live 0x0000000000000000
snd_hda_codec_hdmi 46898 1 - Live 0x0000000000000000
binfmt_misc 17508 1 - Live 0x0000000000000000
intel_rapl 19228 0 - Live 0x0000000000000000
x86_pkg_temp_thermal 14269 0 - Live 0x0000000000000000
intel_powerclamp 19031 0 - Live 0x0000000000000000
coretemp 17728 0 - Live 0x0000000000000000
arc4 12573 2 - Live 0x0000000000000000
kvm_intel 144426 0 - Live 0x0000000000000000
kvm 468147 1 kvm_intel, Live 0x0000000000000000
crct10dif_pclmul 14250 0 - Live 0x0000000000000000
crc32_pclmul 13160 0 - Live 0x0000000000000000
uvcvideo 82247 0 - Live 0x0000000000000000
ghash_clmulni_intel 13259 0 - Live 0x0000000000000000
iwlmvm 195779 0 - Live 0x0000000000000000
aesni_intel 55720 2 - Live 0x0000000000000000
aes_x86_64 17131 1 aesni_intel, Live 0x0000000000000000
lrw 13323 1 aesni_intel, Live 0x0000000000000000
gf128mul 14951 1 lrw, Live 0x0000000000000000
mac80211 654124 1 iwlmvm, Live 0x0000000000000000
videobuf2_vmalloc 13216 1 uvcvideo, Live 0x0000000000000000
glue_helper 14095 1 aesni_intel, Live 0x0000000000000000
ablk_helper 13597 1 aesni_intel, Live 0x0000000000000000
videobuf2_memops 13362 1 videobuf2_vmalloc, Live 0x0000000000000000
cryptd 20530 3 ghash_clmulni_intel,aesni_intel,ablk_helper, Live
0x0000000000000000
joydev 17575 0 - Live 0x0000000000000000
videobuf2_core 40972 1 uvcvideo, Live 0x0000000000000000
videodev 139761 2 uvcvideo,videobuf2_core, Live 0x0000000000000000
cdc_mbim 13271 0 - Live 0x0000000000000000
cdc_ncm 24632 1 cdc_mbim, Live 0x0000000000000000
usbnet 44005 2 cdc_mbim,cdc_ncm, Live 0x0000000000000000
mii 13981 1 usbnet, Live 0x0000000000000000
cdc_wdm 23105 1 cdc_mbim, Live 0x0000000000000000
cdc_acm 28856 0 - Live 0x0000000000000000
microcode 23788 0 - Live 0x0000000000000000
btusb 28326 0 - Live 0x0000000000000000
snd_seq_midi 13324 0 - Live 0x0000000000000000
bluetooth 411140 22 rfcomm,bnep,btusb, Live 0x0000000000000000
snd_seq_midi_event 14899 1 snd_seq_midi, Live 0x0000000000000000
snd_rawmidi 30465 1 snd_seq_midi, Live 0x0000000000000000
thinkpad_acpi 81925 1 - Live 0x0000000000000000
nls_iso8859_1 12713 1 - Live 0x0000000000000000
nvram 14462 1 thinkpad_acpi, Live 0x0000000000000000
iwlwifi 179720 1 iwlmvm, Live 0x0000000000000000
snd_hda_codec_realtek 61978 1 - Live 0x0000000000000000
i915 816869 5 - Live 0x0000000000000000
snd_hda_intel 57222 5 - Live 0x0000000000000000
drm_kms_helper 53224 1 i915, Live 0x0000000000000000
snd_hda_codec 199156 3
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_intel, Live
0x0000000000000000
psmouse 108513 0 - Live 0x0000000000000000
snd_hwdep 13613 1 snd_hda_codec, Live 0x0000000000000000
snd_pcm 107140 3 snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec, Live
0x0000000000000000
drm 308397 4 i915,drm_kms_helper, Live 0x0000000000000000
serio_raw 13462 0 - Live 0x0000000000000000
rtsx_pci_ms 18320 0 - Live 0x0000000000000000
snd_seq 66061 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
cfg80211 509407 3 iwlmvm,mac80211,iwlwifi, Live 0x0000000000000000
snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x0000000000000000
memstick 16968 1 rtsx_pci_ms, Live 0x0000000000000000
mei_me 18578 0 - Live 0x0000000000000000
i2c_algo_bit 13564 1 i915, Live 0x0000000000000000
snd_page_alloc 18798 2 snd_hda_intel,snd_pcm, Live 0x0000000000000000
mei 82671 1 mei_me, Live 0x0000000000000000
lpc_ich 21163 0 - Live 0x0000000000000000
snd_timer 30038 2 snd_pcm,snd_seq, Live 0x0000000000000000
video 19859 1 i915, Live 0x0000000000000000
snd 73850 22 snd_hda_codec_hdmi,snd_seq_midi,snd_rawmidi,thinkpad_acpi,snd_hda_codec_realtek,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_seq,snd_seq_device,snd_timer,
Live 0x0000000000000000
wmi 19363 0 - Live 0x0000000000000000
soundcore 12680 1 snd, Live 0x0000000000000000
mac_hid 13253 0 - Live 0x0000000000000000
intel_smartconnect 12619 0 - Live 0x0000000000000000
lp 17799 0 - Live 0x0000000000000000
parport 42481 3 parport_pc,ppdev,lp, Live 0x0000000000000000
hid_generic 12548 0 - Live 0x0000000000000000
usbhid 53067 0 - Live 0x0000000000000000
hid 106254 2 hid_generic,usbhid, Live 0x0000000000000000
rtsx_pci_sdmmc 23667 0 - Live 0x0000000000000000
ahci 30063 3 - Live 0x0000000000000000
e1000e 257783 0 - Live 0x0000000000000000
libahci 32277 1 ahci, Live 0x0000000000000000
rtsx_pci 46133 2 rtsx_pci_ms,rtsx_pci_sdmmc, Live 0x0000000000000000
ptp 18980 1 e1000e, Live 0x0000000000000000
pps_core 19381 1 ptp, Live 0x0000000000000000


[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
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
  0800-087f : pnp 00:01
  0880-08ff : pnp 00:01
  0900-097f : pnp 00:01
  0980-09ff : pnp 00:01
  0a00-0a7f : pnp 00:01
  0a80-0aff : pnp 00:01
  0b00-0b7f : pnp 00:01
  0b80-0bff : pnp 00:01
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
  15e0-15ef : pnp 00:01
  1600-167f : pnp 00:01
    1640-165f : pnp 00:01
  1800-1803 : ACPI PM1a_EVT_BLK
  1804-1805 : ACPI PM1a_CNT_BLK
  1808-180b : ACPI PM_TMR
  1810-1815 : ACPI CPU throttle
  1830-1833 : iTCO_wdt
  1850-1850 : ACPI PM2_CNT_BLK
  1860-187f : iTCO_wdt
  1880-189f : ACPI GPE0_BLK
  3000-303f : 0000:00:02.0
  3060-307f : 0000:00:1f.2
    3060-307f : ahci
  3080-309f : 0000:00:19.0
  30a0-30a7 : 0000:00:1f.2
    30a0-30a7 : ahci
  30a8-30af : 0000:00:1f.2
    30a8-30af : ahci
  30b0-30b7 : 0000:00:16.3
    30b0-30b7 : serial
  30b8-30bb : 0000:00:1f.2
    30b8-30bb : ahci
  30bc-30bf : 0000:00:1f.2
    30bc-30bf : ahci
  efa0-efbf : 0000:00:1f.3


cat /proc/iomem
00000000-00000fff : reserved
00001000-00057fff : System RAM
00058000-00058fff : reserved
00059000-0009bfff : System RAM
0009c000-0009cfff : reserved
0009d000-0009dfff : System RAM
0009e000-000bffff : reserved
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
00100000-d0261fff : System RAM
  02000000-0274d25d : Kernel code
  0274d25e-02d1a3bf : Kernel data
  02e74000-02fdafff : Kernel bss
d0262000-d0463fff : reserved
d0464000-da91cfff : System RAM
da91d000-dcd3efff : reserved
dcd3f000-dce7efff : ACPI Non-volatile Storage
dce7f000-dcefefff : ACPI Tables
dceff000-dcefffff : System RAM
dcf00000-df9fffff : reserved
  dda00000-df9fffff : Graphics Stolen Memory
dfa00000-febfffff : PCI Bus 0000:00
  e0000000-efffffff : 0000:00:02.0
    e0000000-e07e8fff : BOOTFB
  f0000000-f03fffff : 0000:00:02.0
  f0400000-f04fffff : PCI Bus 0000:03
    f0400000-f0401fff : 0000:03:00.0
      f0400000-f0401fff : iwlwifi
  f0500000-f05fffff : PCI Bus 0000:02
    f0500000-f0500fff : 0000:02:00.0
      f0500000-f0500fff : rtsx_pci
  f0600000-f061ffff : 0000:00:19.0
    f0600000-f061ffff : e1000e
  f0620000-f062ffff : 0000:00:14.0
    f0620000-f062ffff : xhci_hcd
  f0630000-f0633fff : 0000:00:03.0
    f0630000-f0633fff : ICH HD audio
  f0634000-f0637fff : 0000:00:1b.0
    f0634000-f0637fff : ICH HD audio
  f0638000-f06380ff : 0000:00:1f.3
  f0639000-f063901f : 0000:00:16.0
    f0639000-f063901f : mei_me
  f063c000-f063c7ff : 0000:00:1f.2
    f063c000-f063c7ff : ahci
  f063d000-f063d3ff : 0000:00:1d.0
    f063d000-f063d3ff : ehci_hcd
  f063e000-f063efff : 0000:00:19.0
    f063e000-f063efff : e1000e
  f063f000-f063ffff : 0000:00:16.3
  f8000000-fbffffff : PCI MMCONFIG 0000 [bus 00-3f]
    f80f8000-f80f8fff : reserved
  fe101000-fe112fff : reserved
fec00000-fec003ff : IOAPIC 0
fed00000-fed003ff : HPET 0
fed10000-fed13fff : pnp 00:01
fed18000-fed18fff : pnp 00:01
fed19000-fed19fff : pnp 00:01
fed1c000-fed1ffff : reserved
  fed1c000-fed1ffff : pnp 00:01
    fed1f410-fed1f414 : iTCO_wdt
fed40000-fed4bfff : PCI Bus 0000:00
  fed45000-fed4bfff : pnp 00:01
fed90000-fed90fff : dmar0
fed91000-fed91fff : dmar1
fee00000-fee00fff : Local APIC
100000000-31e5fffff : System RAM
31e600000-31fffffff : RAM buffer

[7.5.] PCI information ('lspci -vvv' as root)
sudo lspci -vvv
[sudo] password for jon:
00:00.0 Host bridge: Intel Corporation Haswell-ULT DRAM Controller (rev 0b)
Subsystem: Lenovo Device 220c
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR- INTx-
Latency: 0
Capabilities: [e0] Vendor Specific Information: Len=0c <?>

00:02.0 VGA compatible controller: Intel Corporation Haswell-ULT
Integrated Graphics Controller (rev 0b) (prog-if 00 [VGA controller])
Subsystem: Lenovo Device 220c
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 65
Region 0: Memory at f0000000 (64-bit, non-prefetchable) [size=4M]
Region 2: Memory at e0000000 (64-bit, prefetchable) [size=256M]
Region 4: I/O ports at 3000 [size=64]
Expansion ROM at <unassigned> [disabled]
Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
Address: fee00018  Data: 0000
Capabilities: [d0] Power Management version 2
Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [a4] PCI Advanced Features
AFCap: TP+ FLR+
AFCtrl: FLR-
AFStatus: TP-
Kernel driver in use: i915

00:03.0 Audio device: Intel Corporation Device 0a0c (rev 0b)
Subsystem: Lenovo Device 220c
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 66
Region 0: Memory at f0630000 (64-bit, non-prefetchable) [size=16K]
Capabilities: [50] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D3 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit-
Address: fee00438  Data: 0000
Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
ExtTag- RBE- FLReset+
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
LnkCap: Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0
<64ns, L1 <1us
ClockPM- Surprise- LLActRep- BwNot-
LnkCtl: ASPM Disabled; Disabled- Retrain- CommClk-
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive-
BWMgmt- ABWMgmt-
Kernel driver in use: snd_hda_intel

00:14.0 USB controller: Intel Corporation Lynx Point-LP USB xHCI HC
(rev 04) (prog-if 30 [XHCI])
Subsystem: Lenovo Device 220c
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 58
Region 0: Memory at f0620000 (64-bit, non-prefetchable) [size=64K]
Capabilities: [70] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
Address: 00000000fee002f8  Data: 0000
Kernel driver in use: xhci_hcd

00:16.0 Communication controller: Intel Corporation Lynx Point-LP HECI
#0 (rev 04)
Subsystem: Lenovo Device 220c
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 62
Region 0: Memory at f0639000 (64-bit, non-prefetchable) [size=32]
Capabilities: [50] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
Address: 00000000fee003b8  Data: 0000
Kernel driver in use: mei_me

00:16.3 Serial controller: Intel Corporation Lynx Point-LP HECI KT
(rev 04) (prog-if 02 [16550])
Subsystem: Lenovo Device 220c
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin D routed to IRQ 17
Region 0: I/O ports at 30b0 [size=8]
Region 1: Memory at f063f000 (32-bit, non-prefetchable) [size=4K]
Capabilities: [c8] Power Management version 3
Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
Address: 0000000000000000  Data: 0000
Kernel driver in use: serial

00:19.0 Ethernet controller: Intel Corporation Ethernet Connection
I218-LM (rev 04)
Subsystem: Lenovo Device 2214
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Interrupt: pin A routed to IRQ 20
Region 0: Memory at f0600000 (32-bit, non-prefetchable) [disabled] [size=128K]
Region 1: Memory at f063e000 (32-bit, non-prefetchable) [disabled] [size=4K]
Region 2: I/O ports at 3080 [disabled] [size=32]
Capabilities: [c8] Power Management version 2
Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=1 PME-
Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
Address: 00000000fee00358  Data: 0000
Capabilities: [e0] PCI Advanced Features
AFCap: TP+ FLR+
AFCtrl: FLR-
AFStatus: TP-
Kernel driver in use: e1000e

00:1b.0 Audio device: Intel Corporation Lynx Point-LP HD Audio
Controller (rev 04)
Subsystem: Lenovo Device 220c
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 63
Region 0: Memory at f0634000 (64-bit, non-prefetchable) [size=16K]
Capabilities: [50] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D3 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
Address: 00000000fee003f8  Data: 0000
Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
ExtTag- RBE- FLReset+
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
LnkCap: Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0
<64ns, L1 <1us
ClockPM- Surprise- LLActRep- BwNot-
LnkCtl: ASPM Disabled; Disabled- Retrain- CommClk-
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive-
BWMgmt- ABWMgmt-
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
Port 6 (rev e4) (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
I/O behind bridge: 0000f000-00000fff
Memory behind bridge: f0500000-f05fffff
Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
ExtTag- RBE+ FLReset-
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
LnkCap: Port #6, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns, L1 <16us
ClockPM- Surprise- LLActRep+ BwNot+
LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+
BWMgmt+ ABWMgmt-
SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
Slot #5, PowerLimit 10.000W; Interlock- NoCompl+
SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
Changed: MRL- PresDet- LinkState+
RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
RootCap: CRSVisible-
RootSta: PME ReqID 0000, PMEStatus- PMEPending-
DevCap2: Completion Timeout: Range ABC, TimeoutDis+ ARIFwd-
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-,
Selectable De-emphasis: -6dB
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
Address: 00000000  Data: 0000
Capabilities: [90] Subsystem: Lenovo Device 220c
Capabilities: [a0] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [100 v0] #00
Capabilities: [200 v1] #1e
Kernel driver in use: pcieport

00:1c.1 PCI bridge: Intel Corporation Lynx Point-LP PCI Express Root
Port 3 (rev e4) (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
I/O behind bridge: 0000f000-00000fff
Memory behind bridge: f0400000-f04fffff
Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
ExtTag- RBE+ FLReset-
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
LnkCap: Port #3, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns, L1 <16us
ClockPM- Surprise- LLActRep+ BwNot+
LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+
BWMgmt+ ABWMgmt-
SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
Slot #2, PowerLimit 10.000W; Interlock- NoCompl+
SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
Changed: MRL- PresDet- LinkState+
RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
RootCap: CRSVisible-
RootSta: PME ReqID 0000, PMEStatus- PMEPending-
DevCap2: Completion Timeout: Range ABC, TimeoutDis+ ARIFwd-
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-,
Selectable De-emphasis: -6dB
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
Address: 00000000  Data: 0000
Capabilities: [90] Subsystem: Lenovo Device 220c
Capabilities: [a0] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [100 v0] #00
Capabilities: [200 v1] #1e
Kernel driver in use: pcieport

00:1d.0 USB controller: Intel Corporation Lynx Point-LP USB EHCI #1
(rev 04) (prog-if 20 [EHCI])
Subsystem: Lenovo Device 220c
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 23
Region 0: Memory at f063d000 (32-bit, non-prefetchable) [size=1K]
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
Subsystem: Lenovo Device 220c
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Capabilities: [e0] Vendor Specific Information: Len=0c <?>
Kernel driver in use: lpc_ich

00:1f.2 SATA controller: Intel Corporation Lynx Point-LP SATA
Controller 1 [AHCI mode] (rev 04) (prog-if 01 [AHCI 1.0])
Subsystem: Lenovo Device 220c
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin B routed to IRQ 61
Region 0: I/O ports at 30a8 [size=8]
Region 1: I/O ports at 30bc [size=4]
Region 2: I/O ports at 30a0 [size=8]
Region 3: I/O ports at 30b8 [size=4]
Region 4: I/O ports at 3060 [size=32]
Region 5: Memory at f063c000 (32-bit, non-prefetchable) [size=2K]
Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
Address: fee00398  Data: 0000
Capabilities: [70] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
Kernel driver in use: ahci

00:1f.3 SMBus: Intel Corporation Lynx Point-LP SMBus Controller (rev 04)
Subsystem: Lenovo Device 220c
Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Interrupt: pin C routed to IRQ 255
Region 0: Memory at f0638000 (64-bit, non-prefetchable) [size=256]
Region 4: I/O ports at efa0 [size=32]

02:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd.
Device 5227 (rev 01)
Subsystem: Lenovo Device 220c
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 59
Region 0: Memory at f0500000 (32-bit, non-prefetchable) [size=4K]
Capabilities: [40] Power Management version 3
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
Address: 00000000fee00318  Data: 0000
Capabilities: [70] Express (v2) Endpoint, MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 512 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0
unlimited, L1 <64us
ClockPM+ Surprise- LLActRep- BwNot-
LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk-
ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-
DevCap2: Completion Timeout: Not Supported, TimeoutDis+
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-,
Selectable De-emphasis: -6dB
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [100 v2] Advanced Error Reporting
UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
Capabilities: [140 v1] Device Serial Number 00-00-00-01-00-4c-e0-00
Capabilities: [150 v1] Latency Tolerance Reporting
Max snoop latency: 3145728ns
Max no snoop latency: 3145728ns
Capabilities: [158 v1] #1e
Kernel driver in use: rtsx_pci

03:00.0 Network controller: Intel Corporation Wireless 7260 (rev 83)
Subsystem: Intel Corporation Dual Band Wireless-AC 7260
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 64
Region 0: Memory at f0400000 (64-bit, non-prefetchable) [size=8K]
Capabilities: [c8] Power Management version 3
Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
Address: 00000000fee00418  Data: 0000
Capabilities: [40] Express (v2) Endpoint, MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 unlimited
ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+ FLReset-
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <4us, L1 <32us
ClockPM+ Surprise- LLActRep- BwNot-
LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-
DevCap2: Completion Timeout: Range B, TimeoutDis+
DevCtl2: Completion Timeout: 16ms to 55ms, TimeoutDis-
LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-,
Selectable De-emphasis: -6dB
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [100 v1] Advanced Error Reporting
UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
Capabilities: [140 v1] Device Serial Number 5c-51-4f-ff-ff-73-5a-37
Capabilities: [14c v1] Latency Tolerance Reporting
Max snoop latency: 3145728ns
Max no snoop latency: 3145728ns
Capabilities: [154 v1] Vendor Specific Information: ID=cafe Rev=1 Len=014 <?>
Kernel driver in use: iwlwifi[7.7.] Other information that might be
relevant to the problem

[7.6.] SCSI information (from /proc/scsi/scsi)
cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: SAMSUNG MZ7TD512 Rev: DXT0
  Type:   Direct-Access                    ANSI  SCSI revision: 05

[7.7.] Other information that might be relevant to the problem
ls /proc
1     1080  1159  14    165   1949  1990  2020  2133  2164  2273  23
 2397  2606  2668  2786  2907  3145  3311  36   418  45   5   58   652
 781  934  98         cpuinfo      filesystems  key-users      meminfo
      sched_debug  sys            vmallocinfo
10    1081  1173  1461  166   1952  1991  2022  2135  22    2275  2327
 2398  2612  2673  2787  2921  3155  3376  37   419  459  50  59   673
 796  937  acpi       crypto       fs           kmsg           misc
      schedstat    sysrq-trigger  vmstat
1009  1098  1187  15    17    1958  2     2028  2136  2207  2276  2333
 24    2619  27    28    2934  3162  3382  38   42   46   51  591  7
 8    941  asound     devices      interrupts   kpagecount     modules
      scsi         sysvipc        zoneinfo
1014  11    12    150   1707  1964  20    2031  2143  2210  2279  2344
 2410  2621  2710  2853  2998  317   3383  386  429  47   52  60   718
 800  942  buddyinfo  diskstats    iomem        kpageflags     mounts
      self         timer_list
1023  1108  13    151   18    1981  2000  2037  2144  2235  2284  2349
 2414  2622  2733  2858  3     3170  34    387  43   473  53  61   733
 853  946  bus        dma          ioports      latency_stats  mtrr
      slabinfo     timer_stats
1026  1121  1316  152   1872  1983  2007  2054  2153  2243  2285  2353
 2464  2628  2738  2864  3014  32    3431  39   44   478  54  62   75
 873  959  cgroups    driver       irq          loadavg        net
      softirqs     tty
1030  1123  1318  153   1874  1985  2015  21    2157  2260  2286  2360
 25    2629  2768  2877  304   3243  35    4    440  48   55  63   76
 882  96   cmdline    execdomains  kallsyms     locks
pagetypeinfo  stat         uptime
1037  1147  1358  16    19    1987  2017  2129  2163  2265  2289  2384
 26    2656  2770  29    31    33    352   41   448  49   57  647  77
 9    97   consoles   fb           kcore        mdstat
partitions    swaps        version

Also see the original launchpad report here:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1268365
