From: =?UTF-8?B?VGhvciBIw7hnw6Vz?= <thor@roht.no>
Subject: Elantech touchpad only registering input/in-sync while middle-clicking
Date: Mon, 29 Sep 2014 15:52:46 +0200
Message-ID: <CAKHY8t8E4rGi-AKG0DTmBaepoygVESup4Gq+bdJ3LhgUWtgH4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:36991 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752956AbaI2Nws convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Sep 2014 09:52:48 -0400
Received: by mail-wi0-f175.google.com with SMTP id d1so1066965wiv.8
        for <linux-input@vger.kernel.org>; Mon, 29 Sep 2014 06:52:46 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com

#### One line summary of the problem:
Elantech touchpad [Fujitsu H730] doesn't register any input unless
middle-click is constantly pressed

#### Full description of the problem/report:
I've discovered that the Elantech touchpad does not work unless
middle-click is constantly pressed.
However, as long as it is, multitouch, left-click, right-click etc,
all appear to work perfectly fine.

This is occuring on a Fujitsu Celsius H730, with the latest BIOS
update available.

Specifically, in /var/log/syslog I get the following message upon
middle-clicking:
Sep 29 15:37:50 thor-lincoln-library kernel: [   76.360932] psmouse
serio4: Touchpad at isa0060/serio4/input0 - driver resynced.

Then, upon letting go:
Sep 29 15:37:50 thor-lincoln-library kernel: [   77.230129] psmouse
serio4: Touchpad at isa0060/serio4/input0 lost sync at byte 6

Attempting to use the touchpad without holding down the middle-click
button yields these:
Sep 29 15:39:10 thor-lincoln-library kernel: [  156.932059] psmouse
serio4: Touchpad at isa0060/serio4/input0 lost sync at byte 6
=2E..
Sep 29 15:39:10 thor-lincoln-library kernel: [  156.932063] psmouse
serio4: issuing reconnect request


#### Keywords (i.e., modules, networking, kernel):
input psmouse

#### Kernel version (from /proc/version):
$ cat /proc/version
Linux version 3.17.0-031700rc7-generic (apw@gomeisa) (gcc version
4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201409281835 SMP Sun Sep 28
22:36:30 UTC 2014


#### Environment:
Description:    Ubuntu 14.04.1 LTS
Release:    14.04

#### Software (from ver_linux):
$ sh ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux thor-lincoln-library 3.17.0-031700rc7-generic #201409281835 SMP
Sun Sep 28 22:36:30 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux

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
Modules Loaded         ctr ccm hid_generic usbhid hid nvram pci_stub
vboxpci vboxnetadp vboxnetflt vboxdrv rfcomm uvcvideo bnep
videobuf2_vmalloc videobuf2_memops videobuf2_core v4l2_common videodev
media btusb snd_hda_codec_hdmi bluetooth arc4 intel_rapl
x86_pkg_temp_thermal intel_powerclamp iwlmvm coretemp kvm_intel
mac80211 kvm crct10dif_pclmul crc32_pclmul ghash_clmulni_intel
aesni_intel aes_x86_64 iwlwifi lrw gf128mul glue_helper ablk_helper
cryptd cfg80211 joydev serio_raw rtsx_pci_ms memstick i915
snd_hda_codec_realtek lpc_ich mac_hid snd_hda_codec_generic
snd_hda_intel snd_seq_midi snd_seq_midi_event snd_hda_controller
snd_rawmidi snd_hda_codec mei_me snd_hwdep mei video snd_seq
fujitsu_laptop drm_kms_helper snd_pcm snd_seq_device drm snd_timer snd
soundcore i2c_algo_bit ie31200_edac edac_core parport_pc ppdev lp
parport rtsx_pci_sdmmc e1000e ahci psmouse ptp libahci rtsx_pci
pps_core


#### Processor information (from /proc/cpuinfo):
$ cat /proc/cpuinfo
processor    : 0
vendor_id    : GenuineIntel
cpu family    : 6
model        : 60
model name    : Intel(R) Core(TM) i7-4810MQ CPU @ 2.80GHz
stepping    : 3
microcode    : 0x17
cpu MHz        : 2800.000
cache size    : 6144 KB
physical id    : 0
siblings    : 8
core id        : 0
cpu cores    : 4
apicid        : 0
initial apicid    : 0
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts
rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq
dtes64 monitor ds_cpl vmx smx est tm2 ssse3 fma cx16 xtpr pdcm pcid
sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx
f16c rdrand lahf_lm abm ida arat epb pln pts dtherm tpr_shadow vnmi
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms
invpcid rtm xsaveopt
bugs        :
bogomips    : 5586.87
clflush size    : 64
cache_alignment    : 64
address sizes    : 39 bits physical, 48 bits virtual
power management:

processor    : 1
vendor_id    : GenuineIntel
cpu family    : 6
model        : 60
model name    : Intel(R) Core(TM) i7-4810MQ CPU @ 2.80GHz
stepping    : 3
microcode    : 0x17
cpu MHz        : 2800.218
cache size    : 6144 KB
physical id    : 0
siblings    : 8
core id        : 0
cpu cores    : 4
apicid        : 1
initial apicid    : 1
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts
rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq
dtes64 monitor ds_cpl vmx smx est tm2 ssse3 fma cx16 xtpr pdcm pcid
sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx
f16c rdrand lahf_lm abm ida arat epb pln pts dtherm tpr_shadow vnmi
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms
invpcid rtm xsaveopt
bugs        :
bogomips    : 5586.87
clflush size    : 64
cache_alignment    : 64
address sizes    : 39 bits physical, 48 bits virtual
power management:

processor    : 2
vendor_id    : GenuineIntel
cpu family    : 6
model        : 60
model name    : Intel(R) Core(TM) i7-4810MQ CPU @ 2.80GHz
stepping    : 3
microcode    : 0x17
cpu MHz        : 2800.000
cache size    : 6144 KB
physical id    : 0
siblings    : 8
core id        : 1
cpu cores    : 4
apicid        : 2
initial apicid    : 2
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts
rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq
dtes64 monitor ds_cpl vmx smx est tm2 ssse3 fma cx16 xtpr pdcm pcid
sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx
f16c rdrand lahf_lm abm ida arat epb pln pts dtherm tpr_shadow vnmi
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms
invpcid rtm xsaveopt
bugs        :
bogomips    : 5586.87
clflush size    : 64
cache_alignment    : 64
address sizes    : 39 bits physical, 48 bits virtual
power management:

processor    : 3
vendor_id    : GenuineIntel
cpu family    : 6
model        : 60
model name    : Intel(R) Core(TM) i7-4810MQ CPU @ 2.80GHz
stepping    : 3
microcode    : 0x17
cpu MHz        : 2800.109
cache size    : 6144 KB
physical id    : 0
siblings    : 8
core id        : 1
cpu cores    : 4
apicid        : 3
initial apicid    : 3
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts
rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq
dtes64 monitor ds_cpl vmx smx est tm2 ssse3 fma cx16 xtpr pdcm pcid
sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx
f16c rdrand lahf_lm abm ida arat epb pln pts dtherm tpr_shadow vnmi
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms
invpcid rtm xsaveopt
bugs        :
bogomips    : 5586.87
clflush size    : 64
cache_alignment    : 64
address sizes    : 39 bits physical, 48 bits virtual
power management:

processor    : 4
vendor_id    : GenuineIntel
cpu family    : 6
model        : 60
model name    : Intel(R) Core(TM) i7-4810MQ CPU @ 2.80GHz
stepping    : 3
microcode    : 0x17
cpu MHz        : 2800.000
cache size    : 6144 KB
physical id    : 0
siblings    : 8
core id        : 2
cpu cores    : 4
apicid        : 4
initial apicid    : 4
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts
rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq
dtes64 monitor ds_cpl vmx smx est tm2 ssse3 fma cx16 xtpr pdcm pcid
sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx
f16c rdrand lahf_lm abm ida arat epb pln pts dtherm tpr_shadow vnmi
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms
invpcid rtm xsaveopt
bugs        :
bogomips    : 5586.87
clflush size    : 64
cache_alignment    : 64
address sizes    : 39 bits physical, 48 bits virtual
power management:

processor    : 5
vendor_id    : GenuineIntel
cpu family    : 6
model        : 60
model name    : Intel(R) Core(TM) i7-4810MQ CPU @ 2.80GHz
stepping    : 3
microcode    : 0x17
cpu MHz        : 2790.812
cache size    : 6144 KB
physical id    : 0
siblings    : 8
core id        : 2
cpu cores    : 4
apicid        : 5
initial apicid    : 5
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts
rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq
dtes64 monitor ds_cpl vmx smx est tm2 ssse3 fma cx16 xtpr pdcm pcid
sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx
f16c rdrand lahf_lm abm ida arat epb pln pts dtherm tpr_shadow vnmi
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms
invpcid rtm xsaveopt
bugs        :
bogomips    : 5586.87
clflush size    : 64
cache_alignment    : 64
address sizes    : 39 bits physical, 48 bits virtual
power management:

processor    : 6
vendor_id    : GenuineIntel
cpu family    : 6
model        : 60
model name    : Intel(R) Core(TM) i7-4810MQ CPU @ 2.80GHz
stepping    : 3
microcode    : 0x17
cpu MHz        : 2800.000
cache size    : 6144 KB
physical id    : 0
siblings    : 8
core id        : 3
cpu cores    : 4
apicid        : 6
initial apicid    : 6
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts
rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq
dtes64 monitor ds_cpl vmx smx est tm2 ssse3 fma cx16 xtpr pdcm pcid
sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx
f16c rdrand lahf_lm abm ida arat epb pln pts dtherm tpr_shadow vnmi
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms
invpcid rtm xsaveopt
bugs        :
bogomips    : 5586.87
clflush size    : 64
cache_alignment    : 64
address sizes    : 39 bits physical, 48 bits virtual
power management:

processor    : 7
vendor_id    : GenuineIntel
cpu family    : 6
model        : 60
model name    : Intel(R) Core(TM) i7-4810MQ CPU @ 2.80GHz
stepping    : 3
microcode    : 0x17
cpu MHz        : 2800.109
cache size    : 6144 KB
physical id    : 0
siblings    : 8
core id        : 3
cpu cores    : 4
apicid        : 7
initial apicid    : 7
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts
rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq
dtes64 monitor ds_cpl vmx smx est tm2 ssse3 fma cx16 xtpr pdcm pcid
sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx
f16c rdrand lahf_lm abm ida arat epb pln pts dtherm tpr_shadow vnmi
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms
invpcid rtm xsaveopt
bugs        :
bogomips    : 5586.87
clflush size    : 64
cache_alignment    : 64
address sizes    : 39 bits physical, 48 bits virtual
power management:


#### Module information (from /proc/modules):
$ cat /proc/modules
ctr 13193 1 - Live 0x0000000000000000
ccm 17856 1 - Live 0x0000000000000000
nvram 14462 0 - Live 0x0000000000000000
pci_stub 12622 1 - Live 0x0000000000000000
vboxpci 23194 0 - Live 0x0000000000000000 (OE)
vboxnetadp 25670 0 - Live 0x0000000000000000 (OE)
vboxnetflt 27613 0 - Live 0x0000000000000000 (OE)
vboxdrv 409815 3 vboxpci,vboxnetadp,vboxnetflt, Live 0x0000000000000000=
 (OE)
snd_hda_codec_hdmi 52620 1 - Live 0x0000000000000000
snd_hda_codec_realtek 78564 1 - Live 0x0000000000000000
snd_hda_codec_generic 70087 1 snd_hda_codec_realtek, Live 0x00000000000=
00000
uvcvideo 86628 0 - Live 0x0000000000000000
videobuf2_vmalloc 13216 1 uvcvideo, Live 0x0000000000000000
videobuf2_memops 13362 1 videobuf2_vmalloc, Live 0x0000000000000000
videobuf2_core 59907 1 uvcvideo, Live 0x0000000000000000
v4l2_common 15715 1 videobuf2_core, Live 0x0000000000000000
videodev 163831 3 uvcvideo,videobuf2_core,v4l2_common, Live 0x000000000=
0000000
media 22008 2 uvcvideo,videodev, Live 0x0000000000000000
btusb 32408 0 - Live 0x0000000000000000
arc4 12573 2 - Live 0x0000000000000000
bnep 19884 2 - Live 0x0000000000000000
rfcomm 75114 8 - Live 0x0000000000000000
bluetooth 477455 22 btusb,bnep,rfcomm, Live 0x0000000000000000
iwlmvm 249097 0 - Live 0x0000000000000000
snd_hda_intel 30783 5 - Live 0x0000000000000000
mac80211 696913 1 iwlmvm, Live 0x0000000000000000
snd_hda_controller 32234 1 snd_hda_intel, Live 0x0000000000000000
snd_hda_codec 145035 5
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_=
intel,snd_hda_controller,
Live 0x0000000000000000
snd_hwdep 17709 1 snd_hda_codec, Live 0x0000000000000000
intel_rapl 19196 0 - Live 0x0000000000000000
x86_pkg_temp_thermal 14312 0 - Live 0x0000000000000000
intel_powerclamp 19099 0 - Live 0x0000000000000000
snd_pcm 105052 4
snd_hda_codec_hdmi,snd_hda_intel,snd_hda_controller,snd_hda_codec,
Live 0x0000000000000000
coretemp 13638 0 - Live 0x0000000000000000
kvm_intel 149257 0 - Live 0x0000000000000000
kvm 468567 1 kvm_intel, Live 0x0000000000000000
crct10dif_pclmul 14268 0 - Live 0x0000000000000000
crc32_pclmul 13180 0 - Live 0x0000000000000000
i915 993210 6 - Live 0x0000000000000000
snd_seq_midi 13564 0 - Live 0x0000000000000000
ghash_clmulni_intel 13230 0 - Live 0x0000000000000000
snd_seq_midi_event 14899 1 snd_seq_midi, Live 0x0000000000000000
snd_rawmidi 31197 1 snd_seq_midi, Live 0x0000000000000000
aesni_intel 165469 3 - Live 0x0000000000000000
snd_seq 63540 2 snd_seq_midi,snd_seq_midi_event, Live 0x000000000000000=
0
aes_x86_64 17131 1 aesni_intel, Live 0x0000000000000000
lrw 13323 1 aesni_intel, Live 0x0000000000000000
gf128mul 14951 1 lrw, Live 0x0000000000000000
drm_kms_helper 99872 1 i915, Live 0x0000000000000000
joydev 17587 0 - Live 0x0000000000000000
drm 318542 5 i915,drm_kms_helper, Live 0x0000000000000000
glue_helper 14095 1 aesni_intel, Live 0x0000000000000000
ablk_helper 13597 1 aesni_intel, Live 0x0000000000000000
iwlwifi 190863 1 iwlmvm, Live 0x0000000000000000
snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x0000000=
000000000
cryptd 20531 3 ghash_clmulni_intel,aesni_intel,ablk_helper, Live
0x0000000000000000
snd_timer 30118 2 snd_pcm,snd_seq, Live 0x0000000000000000
rtsx_pci_ms 18337 0 - Live 0x0000000000000000
i2c_algo_bit 13564 1 i915, Live 0x0000000000000000
mei_me 19524 0 - Live 0x0000000000000000
serio_raw 13483 0 - Live 0x0000000000000000
cfg80211 514757 3 iwlmvm,mac80211,iwlwifi, Live 0x0000000000000000
memstick 16968 1 rtsx_pci_ms, Live 0x0000000000000000
snd 84025 21 snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_gen=
eric,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,=
snd_seq_device,snd_timer,
Live 0x0000000000000000
mei 88810 1 mei_me, Live 0x0000000000000000
ie31200_edac 12938 0 - Live 0x0000000000000000
lpc_ich 21176 0 - Live 0x0000000000000000
soundcore 15091 2 snd_hda_codec,snd, Live 0x0000000000000000
edac_core 52405 1 ie31200_edac, Live 0x0000000000000000
mac_hid 13275 0 - Live 0x0000000000000000
video 20569 1 i915, Live 0x0000000000000000
fujitsu_laptop 18779 0 - Live 0x0000000000000000
parport_pc 32906 0 - Live 0x0000000000000000
ppdev 17711 0 - Live 0x0000000000000000
lp 17799 0 - Live 0x0000000000000000
parport 42481 3 parport_pc,ppdev,lp, Live 0x0000000000000000
rtsx_pci_sdmmc 23718 0 - Live 0x0000000000000000
ahci 30167 2 - Live 0x0000000000000000
e1000e 230063 0 - Live 0x0000000000000000
psmouse 118039 0 - Live 0x0000000000000000
libahci 32533 1 ahci, Live 0x0000000000000000
ptp 19534 1 e1000e, Live 0x0000000000000000
rtsx_pci 51162 2 rtsx_pci_ms,rtsx_pci_sdmmc, Live 0x0000000000000000
pps_core 19381 1 ptp, Live 0x0000000000000000



#### Loaded driver and hardware information (/proc/ioports, /proc/iomem=
):
$ cat /proc/ioports
0000-0cf7 : PCI Bus 0000:00
  0000-001f : dma1
  0020-0021 : pic1
  0040-0043 : timer0
  0050-0053 : timer1
  0060-0060 : keyboard
  0061-0061 : PNP0800:00
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
    00f0-00f0 : PNP0C04:00
  03c0-03df : vga+
  0410-0415 : ACPI CPU throttle
  04d0-04d1 : pnp 00:01
  0600-0603 : pnp 00:01
  0604-0607 : pnp 00:01
  0800-087f : pnp 00:01
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
  1640-164f : pnp 00:01
  1800-187f : pnp 00:01
    1800-1803 : ACPI PM1a_EVT_BLK
    1804-1805 : ACPI PM1a_CNT_BLK
    1808-180b : ACPI PM_TMR
    1820-182f : ACPI GPE0_BLK
    1830-1833 : iTCO_wdt
    1850-1850 : ACPI PM2_CNT_BLK
    1860-187f : iTCO_wdt
  1880-18ff : pnp 00:01
  2000-2003 : pnp 00:01
  2100-217f : pnp 00:01
  2180-21ff : pnp 00:01
  3000-3fff : PCI Bus 0000:01
    3000-307f : 0000:01:00.0
  4000-403f : 0000:00:02.0
  4060-407f : 0000:00:1f.2
    4060-407f : ahci
  4080-409f : 0000:00:19.0
  40a0-40a7 : 0000:00:1f.2
    40a0-40a7 : ahci
  40a8-40af : 0000:00:1f.2
    40a8-40af : ahci
  40b0-40b7 : 0000:00:16.3
    40b0-40b7 : serial
  40b8-40bb : 0000:00:1f.2
    40b8-40bb : ahci
  40bc-40bf : 0000:00:1f.2
    40bc-40bf : ahci
  efa0-efbf : 0000:00:1f.3
  f800-f87f : pnp 00:01
  f880-f8ff : pnp 00:01
  fc00-fc7f : pnp 00:01
  fc80-fcff : pnp 00:01
  fd00-fd7f : pnp 00:01

$ cat /proc/iomem
00000000-00000fff : reserved
00001000-0009cfff : System RAM
0009d000-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000cebff : Video ROM
000e0000-000fffff : reserved
  000f0000-000fffff : System ROM
00100000-a402bfff : System RAM
  01000000-017a9a77 : Kernel code
  017a9a78-01d1e57f : Kernel data
  01e80000-01fc6fff : Kernel bss
a402c000-a422dfff : reserved
a422e000-ba64efff : System RAM
ba64f000-bce3efff : reserved
bce3f000-bcf9efff : ACPI Non-volatile Storage
bcf9f000-bcffefff : ACPI Tables
bcfff000-bcffffff : System RAM
bd000000-bf9fffff : reserved
  bda00000-bf9fffff : Graphics Stolen Memory
bfa00000-feafffff : PCI Bus 0000:00
  bfa10000-bfa1ffff : pnp 00:00
  c0000000-d1ffffff : PCI Bus 0000:01
    c0000000-cfffffff : 0000:01:00.0
    d0000000-d1ffffff : 0000:01:00.0
  e0000000-efffffff : 0000:00:02.0
  f0000000-f0ffffff : PCI Bus 0000:01
    f0000000-f0ffffff : 0000:01:00.0
  f1000000-f13fffff : 0000:00:02.0
  f1400000-f14fffff : PCI Bus 0000:04
    f1400000-f1400fff : 0000:04:00.0
      f1400000-f1400fff : rtsx_pci
  f1500000-f15fffff : PCI Bus 0000:03
    f1500000-f1501fff : 0000:03:00.0
      f1500000-f1501fff : iwlwifi
  f1600000-f161ffff : 0000:00:19.0
    f1600000-f161ffff : e1000e
  f1620000-f162ffff : 0000:00:14.0
    f1620000-f162ffff : xhci_hcd
  f1630000-f1633fff : 0000:00:03.0
    f1630000-f1633fff : ICH HD audio
  f1634000-f1637fff : 0000:00:1b.0
    f1634000-f1637fff : ICH HD audio
  f1638000-f16380ff : 0000:00:1f.3
  f1639000-f163900f : 0000:00:16.0
    f1639000-f163900f : mei_me
  f163c000-f163c7ff : 0000:00:1f.2
    f163c000-f163c7ff : ahci
  f163f000-f163ffff : 0000:00:19.0
    f163f000-f163ffff : e1000e
  f1640000-f1640fff : 0000:00:16.3
  f8000000-fbffffff : PCI MMCONFIG 0000 [bus 00-3f]
    f8000000-fbffffff : reserved
      f8000000-fbffffff : pnp 00:00
fec00000-fec00fff : reserved
  fec00000-fec003ff : IOAPIC 0
fed00000-fed003ff : HPET 0
  fed00000-fed003ff : pnp 00:05
fed08000-fed08fff : reserved
  fed08000-fed08fff : pnp 00:00
fed10000-fed19fff : reserved
  fed10000-fed17fff : pnp 00:00
  fed18000-fed18fff : pnp 00:00
  fed19000-fed19fff : pnp 00:00
fed1c000-fed1ffff : reserved
  fed1c000-fed1ffff : pnp 00:00
    fed1f410-fed1f414 : iTCO_wdt
fed20000-fed3ffff : pnp 00:00
fed40000-fed44fff : pnp 00:00
fed45000-fed8ffff : pnp 00:00
fed90000-fed90fff : dmar0
fed91000-fed91fff : dmar1
fee00000-fee00fff : Local APIC
  fee00000-fee00fff : reserved
fef00000-feffffff : pnp 00:00
ffc80000-ffffffff : reserved
100000000-83e5fffff : System RAM
83e600000-83fffffff : RAM buffer


#### PCI information ('lspci -vvv' as root):
$ sudo lspci -vvv
00:00.0 Host bridge: Intel Corporation Xeon E3-1200 v3/4th Gen Core
Processor DRAM Controller (rev 06)
    Subsystem: Fujitsu Limited. Device 17a6
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR- INTx-
    Latency: 0
    Capabilities: [e0] Vendor Specific Information: Len=3D0c <?>

00:01.0 PCI bridge: Intel Corporation Xeon E3-1200 v3/4th Gen Core
Processor PCI Express x16 Controller (rev 06) (prog-if 00 [Normal
decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D=
0
    I/O behind bridge: 00003000-00003fff
    Memory behind bridge: f0000000-f0ffffff
    Prefetchable memory behind bridge: 00000000c0000000-00000000d1fffff=
f
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [88] Subsystem: Fujitsu Limited. Device 17a7
    Capabilities: [80] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
    Capabilities: [90] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
        Address: fee002d8  Data: 0000
    Capabilities: [a0] Express (v2) Root Port (Slot+), MSI 00
        DevCap:    MaxPayload 256 bytes, PhantFunc 0
            ExtTag- RBE+
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupp=
orted-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 256 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- Tra=
nsPend-
        LnkCap:    Port #2, Speed 8GT/s, Width x16, ASPM L0s L1, Exit
Latency L0s <256ns, L1 <8us
            ClockPM- Surprise- LLActRep- BwNot+
        LnkCtl:    ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 8GT/s, Width x16, TrErr- Train- SlotClk+
DLActive- BWMgmt+ ABWMgmt+
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Sur=
prise-
            Slot #1, PowerLimit 75.000W; Interlock- NoCompl+
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
HPIrq- LinkChg-
            Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ In=
terlock-
            Changed: MRL- PresDet+ LinkState-
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRS=
Visible-
        RootCap: CRSVisible-
        RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR+,
OBFF Via WAKE# ARIFwd-
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+,
OBFF Via WAKE# ARIFwd-
        LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete+, EqualizationPhase1+
             EqualizationPhase2+, EqualizationPhase3+, LinkEqualization=
Request-
    Capabilities: [100 v1] Virtual Channel
        Caps:    LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
        Arb:    Fixed- WRR32- WRR64- WRR128-
        Ctrl:    ArbSelect=3DFixed
        Status:    InProgress-
        VC0:    Caps:    PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
            Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
            Ctrl:    Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3Dff
            Status:    NegoPending- InProgress-
    Capabilities: [140 v1] Root Complex Link
        Desc:    PortNumber=3D02 ComponentID=3D01 EltType=3DConfig
        Link0:    Desc:    TargetPort=3D00 TargetComponent=3D01 AssocRC=
RB-
LinkType=3DMemMapped LinkValid+
            Addr:    00000000fed19000
    Capabilities: [d94 v1] #19
    Kernel driver in use: pcieport

00:02.0 VGA compatible controller: Intel Corporation 4th Gen Core
Processor Integrated Graphics Controller (rev 06) (prog-if 00 [VGA
controller])
    Subsystem: Fujitsu Limited. Device 17ac
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 33
    Region 0: Memory at f1000000 (64-bit, non-prefetchable) [size=3D4M]
    Region 2: Memory at e0000000 (64-bit, prefetchable) [size=3D256M]
    Region 4: I/O ports at 4000 [size=3D64]
    Expansion ROM at <unassigned> [disabled]
    Capabilities: [90] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
        Address: fee00018  Data: 0000
    Capabilities: [d0] Power Management version 2
        Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
    Capabilities: [a4] PCI Advanced Features
        AFCap: TP+ FLR+
        AFCtrl: FLR-
        AFStatus: TP-
    Kernel driver in use: i915

00:03.0 Audio device: Intel Corporation Xeon E3-1200 v3/4th Gen Core
Processor HD Audio Controller (rev 06)
    Subsystem: Fujitsu Limited. Device 17c6
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 35
    Region 0: Memory at f1630000 (64-bit, non-prefetchable) [size=3D16K=
]
    Capabilities: [50] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D3 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
    Capabilities: [60] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
        Address: fee00458  Data: 0000
    Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, M=
SI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0
            ExtTag- RBE-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupp=
orted-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- Tra=
nsPend-
    Kernel driver in use: snd_hda_intel

00:14.0 USB controller: Intel Corporation 8 Series/C220 Series Chipset
=46amily USB xHCI (rev 04) (prog-if 30 [XHCI])
    Subsystem: Fujitsu Limited. Device 17e1
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 27
    Region 0: Memory at f1620000 (64-bit, non-prefetchable) [size=3D64K=
]
    Capabilities: [70] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
    Capabilities: [80] MSI: Enable+ Count=3D1/8 Maskable- 64bit+
        Address: 00000000fee00338  Data: 0000
    Kernel driver in use: xhci_hcd

00:16.0 Communication controller: Intel Corporation 8 Series/C220
Series Chipset Family MEI Controller #1 (rev 04)
    Subsystem: Fujitsu Limited. Device 17dd
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 31
    Region 0: Memory at f1639000 (64-bit, non-prefetchable) [size=3D16]
    Capabilities: [50] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
    Capabilities: [8c] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
        Address: 00000000fee003d8  Data: 0000
    Kernel driver in use: mei_me

00:16.3 Serial controller: Intel Corporation 8 Series/C220 Series
Chipset Family KT Controller (rev 04) (prog-if 02 [16550])
    Subsystem: Fujitsu Limited. Device 17e0
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin D routed to IRQ 19
    Region 0: I/O ports at 40b0 [size=3D8]
    Region 1: Memory at f1640000 (32-bit, non-prefetchable) [size=3D4K]
    Capabilities: [c8] Power Management version 3
        Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
    Capabilities: [d0] MSI: Enable- Count=3D1/1 Maskable- 64bit+
        Address: 0000000000000000  Data: 0000
    Kernel driver in use: serial

00:19.0 Ethernet controller: Intel Corporation Ethernet Connection
I217-LM (rev 04)
    Subsystem: Fujitsu Limited. Device 17e7
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Interrupt: pin A routed to IRQ 29
    Region 0: Memory at f1600000 (32-bit, non-prefetchable) [disabled]
[size=3D128K]
    Region 1: Memory at f163f000 (32-bit, non-prefetchable) [disabled] =
[size=3D4K]
    Region 2: I/O ports at 4080 [disabled] [size=3D32]
    Capabilities: [c8] Power Management version 2
        Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D3 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D1 PME-
    Capabilities: [d0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
        Address: 00000000fee00398  Data: 0000
    Capabilities: [e0] PCI Advanced Features
        AFCap: TP+ FLR+
        AFCtrl: FLR-
        AFStatus: TP-
    Kernel driver in use: e1000e

00:1b.0 Audio device: Intel Corporation 8 Series/C220 Series Chipset
High Definition Audio Controller (rev 04)
    Subsystem: Fujitsu Limited. Device 17ff
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 34
    Region 0: Memory at f1634000 (64-bit, non-prefetchable) [size=3D16K=
]
    Capabilities: [50] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D55mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D3 NoSoftRst- PME-Enable+ DSel=3D0 DScale=3D0 PME-
    Capabilities: [60] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
        Address: 00000000fee00438  Data: 0000
    Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, M=
SI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0
            ExtTag- RBE-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupp=
orted-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ Tra=
nsPend-
    Capabilities: [100 v1] Virtual Channel
        Caps:    LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
        Arb:    Fixed- WRR32- WRR64- WRR128-
        Ctrl:    ArbSelect=3DFixed
        Status:    InProgress-
        VC0:    Caps:    PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
            Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
            Ctrl:    Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3D01
            Status:    NegoPending- InProgress-
        VC1:    Caps:    PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
            Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
            Ctrl:    Enable+ ID=3D2 ArbSelect=3DFixed TC/VC=3D04
            Status:    NegoPending- InProgress-
    Kernel driver in use: snd_hda_intel

00:1c.0 PCI bridge: Intel Corporation 8 Series/C220 Series Chipset
=46amily PCI Express Root Port #1 (rev d4) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Bus: primary=3D00, secondary=3D02, subordinate=3D02, sec-latency=3D=
0
    I/O behind bridge: 0000f000-00000fff
    Memory behind bridge: fff00000-000fffff
    Prefetchable memory behind bridge: 00000000fff00000-00000000000ffff=
f
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [40] Express (v2) Root Port (Slot-), MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0
            ExtTag- RBE+
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupp=
orted-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ Tra=
nsPend-
        LnkCap:    Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s <1us, L1 <4us
            ClockPM- Surprise- LLActRep+ BwNot+
        LnkCtl:    ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk-
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRS=
Visible-
        RootCap: CRSVisible-
        RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+,
OBFF Via WAKE# ARIFwd-
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+,
OBFF Disabled ARIFwd-
        LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-, LinkEqualization=
Request-
    Capabilities: [80] MSI: Enable- Count=3D1/1 Maskable- 64bit-
        Address: 00000000  Data: 0000
    Capabilities: [90] Subsystem: Fujitsu Limited. Device 17d3
    Capabilities: [a0] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
    Kernel driver in use: pcieport

00:1c.5 PCI bridge: Intel Corporation 8 Series/C220 Series Chipset
=46amily PCI Express Root Port #6 (rev d4) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Bus: primary=3D00, secondary=3D03, subordinate=3D03, sec-latency=3D=
0
    I/O behind bridge: 0000f000-00000fff
    Memory behind bridge: f1500000-f15fffff
    Prefetchable memory behind bridge: 00000000fff00000-00000000000ffff=
f
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0
            ExtTag- RBE+
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupp=
orted-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ Tra=
nsPend-
        LnkCap:    Port #6, Speed 5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s <512ns, L1 <16us
            ClockPM- Surprise- LLActRep+ BwNot+
        LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive+ BWMgmt+ ABWMgmt-
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Sur=
prise-
            Slot #5, PowerLimit 10.000W; Interlock- NoCompl+
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
HPIrq- LinkChg-
            Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ In=
terlock-
            Changed: MRL- PresDet- LinkState+
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRS=
Visible-
        RootCap: CRSVisible-
        RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+,
OBFF Not Supported ARIFwd-
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+,
OBFF Disabled ARIFwd-
        LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-, LinkEqualization=
Request-
    Capabilities: [80] MSI: Enable- Count=3D1/1 Maskable- 64bit-
        Address: 00000000  Data: 0000
    Capabilities: [90] Subsystem: Fujitsu Limited. Device 17d3
    Capabilities: [a0] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
    Kernel driver in use: pcieport

00:1c.7 PCI bridge: Intel Corporation 8 Series/C220 Series Chipset
=46amily PCI Express Root Port #8 (rev d4) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Bus: primary=3D00, secondary=3D04, subordinate=3D04, sec-latency=3D=
0
    I/O behind bridge: 0000f000-00000fff
    Memory behind bridge: f1400000-f14fffff
    Prefetchable memory behind bridge: 00000000fff00000-00000000000ffff=
f
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0
            ExtTag- RBE+
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupp=
orted-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ Tra=
nsPend-
        LnkCap:    Port #8, Speed 5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s <512ns, L1 <16us
            ClockPM- Surprise- LLActRep+ BwNot+
        LnkCtl:    ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive+ BWMgmt+ ABWMgmt-
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Sur=
prise-
            Slot #7, PowerLimit 10.000W; Interlock- NoCompl+
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
HPIrq- LinkChg-
            Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ In=
terlock-
            Changed: MRL- PresDet- LinkState+
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRS=
Visible-
        RootCap: CRSVisible-
        RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+,
OBFF Not Supported ARIFwd-
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+,
OBFF Disabled ARIFwd-
        LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-, LinkEqualization=
Request-
    Capabilities: [80] MSI: Enable- Count=3D1/1 Maskable- 64bit-
        Address: 00000000  Data: 0000
    Capabilities: [90] Subsystem: Fujitsu Limited. Device 17d3
    Capabilities: [a0] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
    Kernel driver in use: pcieport

00:1f.0 ISA bridge: Intel Corporation QM87 Express LPC Controller (rev =
04)
    Subsystem: Fujitsu Limited. Device 17c7
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Capabilities: [e0] Vendor Specific Information: Len=3D0c <?>
    Kernel driver in use: lpc_ich

00:1f.2 SATA controller: Intel Corporation 8 Series/C220 Series
Chipset Family 6-port SATA Controller 1 [AHCI mode] (rev 04) (prog-if
01 [AHCI 1.0])
    Subsystem: Fujitsu Limited. Device 17c9
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin B routed to IRQ 30
    Region 0: I/O ports at 40a8 [size=3D8]
    Region 1: I/O ports at 40bc [size=3D4]
    Region 2: I/O ports at 40a0 [size=3D8]
    Region 3: I/O ports at 40b8 [size=3D4]
    Region 4: I/O ports at 4060 [size=3D32]
    Region 5: Memory at f163c000 (32-bit, non-prefetchable) [size=3D2K]
    Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
        Address: fee003b8  Data: 0000
    Capabilities: [70] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot+,D3cold-)
        Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
    Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=3D00000004
    Kernel driver in use: ahci

00:1f.3 SMBus: Intel Corporation 8 Series/C220 Series Chipset Family
SMBus Controller (rev 04)
    Subsystem: Fujitsu Limited. Device 17cf
    Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Interrupt: pin C routed to IRQ 11
    Region 0: Memory at f1638000 (64-bit, non-prefetchable) [size=3D256=
]
    Region 4: I/O ports at efa0 [size=3D32]

01:00.0 3D controller: NVIDIA Corporation GK107GLM [Quadro K1100M] (rev=
 a1)
    Subsystem: Fujitsu Limited. Device 17ee
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 11
    Region 0: Memory at f0000000 (32-bit, non-prefetchable) [size=3D16M=
]
    Region 1: Memory at c0000000 (64-bit, prefetchable) [size=3D256M]
    Region 3: Memory at d0000000 (64-bit, prefetchable) [size=3D32M]
    Region 5: I/O ports at 3000 [size=3D128]
    Expansion ROM at <ignored> [disabled]
    Capabilities: [60] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
    Capabilities: [68] MSI: Enable- Count=3D1/1 Maskable- 64bit+
        Address: 0000000000000000  Data: 0000
    Capabilities: [78] Express (v2) Endpoint, MSI 00
        DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s
unlimited, L1 <64us
            ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupp=
orted-
            RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
            MaxPayload 256 bytes, MaxReadReq 512 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- Tra=
nsPend-
        LnkCap:    Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit
Latency L0s <512ns, L1 <4us
            ClockPM+ Surprise- LLActRep- BwNot-
        LnkCtl:    ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 8GT/s, Width x16, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
        DevCap2: Completion Timeout: Range AB, TimeoutDis+, LTR-, OBFF
Not Supported
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-,
OBFF Disabled
        LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete+, EqualizationPhase1+
             EqualizationPhase2+, EqualizationPhase3+, LinkEqualization=
Request+
    Capabilities: [b4] Vendor Specific Information: Len=3D14 <?>
    Capabilities: [100 v1] Virtual Channel
        Caps:    LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
        Arb:    Fixed- WRR32- WRR64- WRR128-
        Ctrl:    ArbSelect=3DFixed
        Status:    InProgress-
        VC0:    Caps:    PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
            Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
            Ctrl:    Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3Dff
            Status:    NegoPending- InProgress-
    Capabilities: [128 v1] Power Budgeting <?>
    Capabilities: [600 v1] Vendor Specific Information: ID=3D0001 Rev=3D=
1
Len=3D024 <?>
    Capabilities: [900 v1] #19

03:00.0 Network controller: Intel Corporation Wireless 7260 (rev 73)
    Subsystem: Intel Corporation Dual Band Wireless-N 7260
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 32
    Region 0: Memory at f1500000 (64-bit, non-prefetchable) [size=3D8K]
    Capabilities: [c8] Power Management version 3
        Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
    Capabilities: [d0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
        Address: 00000000fee003f8  Data: 0000
    Capabilities: [40] Express (v2) Endpoint, MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s
<512ns, L1 unlimited
            ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupp=
orted-
            RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+ FLReset-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ Tra=
nsPend-
        LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s <4us, L1 <32us
            ClockPM+ Surprise- LLActRep- BwNot-
        LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
            ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
        DevCap2: Completion Timeout: Range B, TimeoutDis+, LTR+, OBFF V=
ia WAKE#
        DevCtl2: Completion Timeout: 16ms to 55ms, TimeoutDis-, LTR+,
OBFF Disabled
        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-, LinkEqualization=
Request-
    Capabilities: [100 v1] Advanced Error Reporting
        UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
        CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalEr=
r+
        CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalEr=
r+
        AERCap:    First Error Pointer: 00, GenCap- CGenEn- ChkCap- Chk=
En-
    Capabilities: [140 v1] Device Serial Number f8-16-54-ff-ff-47-f9-0f
    Capabilities: [14c v1] Latency Tolerance Reporting
        Max snoop latency: 3145728ns
        Max no snoop latency: 3145728ns
    Capabilities: [154 v1] Vendor Specific Information: ID=3Dcafe Rev=3D=
1
Len=3D014 <?>
    Kernel driver in use: iwlwifi

04:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd.
RTS5227 PCI Express Card Reader (rev 01)
    Subsystem: Fujitsu Limited. Device 187f
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 28
    Region 0: Memory at f1400000 (32-bit, non-prefetchable) [size=3D4K]
    Capabilities: [40] Power Management version 3
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
    Capabilities: [50] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
        Address: 00000000fee00358  Data: 0000
    Capabilities: [70] Express (v2) Endpoint, MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s
unlimited, L1 unlimited
            ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupp=
orted-
            RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 512 bytes
        DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ Tra=
nsPend-
        LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s unlimited, L1 <64us
            ClockPM+ Surprise- LLActRep- BwNot-
        LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk-
            ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
        DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR+,
OBFF Via message/WAKE#
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+,
OBFF Disabled
        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-, LinkEqualization=
Request-
    Capabilities: [100 v2] Advanced Error Reporting
        UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
        CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalEr=
r+
        CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalEr=
r+
        AERCap:    First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ Chk=
En-
    Capabilities: [140 v1] Device Serial Number 00-00-00-01-00-4c-e0-00
    Capabilities: [150 v1] Latency Tolerance Reporting
        Max snoop latency: 3145728ns
        Max no snoop latency: 3145728ns
    Capabilities: [158 v1] L1 PM Substates
        L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
L1_PM_Substates+
              PortCommonModeRestoreTime=3D60us PortTPowerOnTime=3D60us
    Kernel driver in use: rtsx_pci




#### SCSI information (from /proc/scsi/scsi):
$ cat /proc/scsi/scsi
Attached devices:
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: TSSTcorp Model: CDDVDW SU-208CB  Rev: FU01
  Type:   CD-ROM                           ANSI  SCSI revision: 05
Host: scsi4 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: SAMSUNG MZ7TE256 Rev: 200Q
  Type:   Direct-Access                    ANSI  SCSI revision: 05


#### Other information that might be relevant to the problem:
$ ls /proc
1
10
1045
1049
1055
1056
1059
11
1104
1114
1116
1129
1145
118
119
12
1226
1231
1244
1255
1258
1262
128
13
1375
1379
14
1437
1477
15
1535
1551
16
1683
17
1748
1750
179
18
180
182
1822
183
1833
184
1841
1846
185
1859
186
1861
1865
1867
1869
187
188
1886
189
1890
1894
1898
19
190
1900
1909
191
1910
192
1921
1923
1926
193
1930
1937
194
1955
196
1961
1962
1965
1967
1969
197
1980
1992
1993
1997
1999
2
20
200
201
2010
2011
2027
205
2070
2075
2084
2085
21
2105
2109
2111
2112
2116
213
214
215
216
217
2178
2182
2192
2199
22
2204
2208
2214
2220
2224
2261
2263
23
2302
2309
24
2462
2468
2474
2476
2496
25
2503
2528
2550
2565
2613
2671
2673
2680
2681
2752
2785
28
2828
2829
2830
29
3
30
31
33
34
35
354
36
360
38
39
4
40
41
417
43
44
445
449
46
48
489
49
496
497
5
50
507
51
512
53
54
55
56
578
58
59
60
609
61
614
62
63
639
64
640
65
650
66
661
663
67
672
673
68
69
7
70
71
72
721
723
724
726
727
73
74
75
76
77
78
8
80
81
82
839
840
841
848
849
863
889
890
891
899
9
901
910
94
95
96
97
98
99
996
998
acpi
asound
buddyinfo
bus
cgroups
cmdline
consoles
cpuinfo
crypto
devices
diskstats
dma
driver
execdomains
fb
filesystems
fs
interrupts
iomem
ioports
irq
kallsyms
kcore
keys
key-users
kmsg
kpagecount
kpageflags
loadavg
locks
mdstat
meminfo
misc
modules
mounts
mtrr
net
pagetypeinfo
partitions
sched_debug
schedstat
scsi
self
slabinfo
softirqs
stat
swaps
sys
sysrq-trigger
sysvipc
thread-self
timer_list
timer_stats
tty
uptime
version
vmallocinfo
vmstat
zoneinfo

#### Other notes, patches, fixes, workarounds:
This bug was initially reported to Launchpad, with the following URL:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1371786

With some minor searching, it seems that bug #77391 (Kernel.org
bugzilla) seems relevant, although I'm not qualified to say to what
degree.

A workaround to get the touchpad to work has been to 'rmmod psmouse'
and then 'modprobe psmouse proto=3Dexps' (or bare, if you'd like).
However, this makes the the trackpoint disappear from xinput.

Normally xinput looks like this:
=E2=8E=A1 Virtual core pointer                        id=3D2    [master=
 pointer  (3)]
=E2=8E=9C   =E2=86=B3 Virtual core XTEST pointer                  id=3D=
4    [slave  pointer  (2)]
=E2=8E=9C   =E2=86=B3 ETPS/2 Elantech Touchpad                    id=3D=
14    [slave  pointer  (2)]
=E2=8E=9C   =E2=86=B3 Elantech PS/2 TrackPoint                    id=3D=
15    [slave  pointer  (2)]
=E2=8E=A3 Virtual core keyboard                       id=3D3    [master=
 keyboard (2)]
    =E2=86=B3 Virtual core XTEST keyboard                 id=3D5    [sl=
ave  keyboard (3)]
    =E2=86=B3 Fujitsu FUJ02E3                             id=3D6    [sl=
ave  keyboard (3)]
    =E2=86=B3 Video Bus                                   id=3D7    [sl=
ave  keyboard (3)]
    =E2=86=B3 Video Bus                                   id=3D8    [sl=
ave  keyboard (3)]
    =E2=86=B3 Fujitsu FUJ02B1                             id=3D9    [sl=
ave  keyboard (3)]
    =E2=86=B3 Power Button                                id=3D10    [s=
lave  keyboard (3)]
    =E2=86=B3 Sleep Button                                id=3D11    [s=
lave  keyboard (3)]
    =E2=86=B3 FJ Camera                                   id=3D12    [s=
lave  keyboard (3)]
    =E2=86=B3 AT Translated Set 2 keyboard                id=3D13    [s=
lave  keyboard (3)]

$ xinput list-props 14
Device 'ETPS/2 Elantech Touchpad':
    Device Enabled (138):    1
    Coordinate Transformation Matrix (140):    1.000000, 0.000000,
0.000000, 0.000000, 1.000000, 0.000000, 0.000000, 0.000000, 1.000000
    Device Accel Profile (264):    1
    Device Accel Constant Deceleration (265):    2.500000
    Device Accel Adaptive Deceleration (266):    1.000000
    Device Accel Velocity Scaling (267):    12.500000
    Synaptics Edges (268):    118, 2846, 92, 1624
    Synaptics Finger (269):    1, 1, 0
    Synaptics Tap Time (270):    180
    Synaptics Tap Move (271):    150
    Synaptics Tap Durations (272):    180, 180, 100
    Synaptics ClickPad (273):    0
    Synaptics Middle Button Timeout (274):    75
    Synaptics Two-Finger Pressure (275):    282
    Synaptics Two-Finger Width (276):    7
    Synaptics Scrolling Distance (277):    -68, -68
    Synaptics Edge Scrolling (278):    0, 0, 0
    Synaptics Two-Finger Scrolling (279):    1, 0
    Synaptics Move Speed (280):    1.000000, 1.750000, 0.058411, 0.0000=
00
    Synaptics Off (281):    2
    Synaptics Locked Drags (282):    0
    Synaptics Locked Drags Timeout (283):    5000
    Synaptics Tap Action (284):    2, 3, 0, 0, 1, 3, 0
    Synaptics Click Action (285):    1, 1, 0
    Synaptics Circular Scrolling (286):    0
    Synaptics Circular Scrolling Distance (287):    0.100000
    Synaptics Circular Scrolling Trigger (288):    0
    Synaptics Circular Pad (289):    0
    Synaptics Palm Detection (290):    0
    Synaptics Palm Dimensions (291):    10, 200
    Synaptics Coasting Speed (292):    20.000000, 50.000000
    Synaptics Pressure Motion (293):    30, 160
    Synaptics Pressure Motion Factor (294):    1.000000, 1.000000
    Synaptics Resolution Detect (295):    1
    Synaptics Grab Event Device (296):    1
    Synaptics Gestures (297):    1
    Synaptics Capabilities (298):    1, 0, 1, 1, 1, 1, 1
    Synaptics Pad Resolution (299):    33, 33
    Synaptics Area (300):    0, 0, 0, 0
    Synaptics Noise Cancellation (301):    17, 17
    Device Product ID (257):    2, 14
    Device Node (258):    "/dev/input/event5"

Please do not hesitate to let me know how I can provide further
details, I'll be glad to provide any and all.

Regards,
Thor K. H.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
