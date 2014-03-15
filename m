From: Tom Beckmann <tomjonabc@gmail.com>
Subject: Bug: Three finger tap on Magic Trackpad blocks the device
Date: Sat, 15 Mar 2014 17:26:15 +0100
Message-ID: <CAMfZt3H-n7N4=v7bNGjQps1K+BZ+s_E9Pu9KrPPjBvXmt8Ch4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:51201 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756309AbaCOQ0S (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 15 Mar 2014 12:26:18 -0400
Received: by mail-lb0-f174.google.com with SMTP id u14so2579696lbd.19
        for <linux-input@vger.kernel.org>; Sat, 15 Mar 2014 09:26:16 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

[1.] One line summary of the problem:
Apple Magic Trackpad: Three Finger Tap gets sent repeatedly

[2.] Full description of the problem/report:
When using my Magic Trackpad with up to two fingers all works fine,
like scrolling and right clicking. As soon as I barely touch the pad
with three fingers, it becomes unresponsive for around 20 seconds.
Checking evtest, the same event is sent all the time, blocking all
others.

evtest output after touching with three fingers:

Event: time 1393156544.500256, -------------- SYN_REPORT ------------
Event: time 1393156546.784405, type 3 (EV_ABS), code 47 (ABS_MT_SLOT), value 8
Event: time 1393156546.784405, type 3 (EV_ABS), code 57
(ABS_MT_TRACKING_ID), value 16
Event: time 1393156546.784405, type 3 (EV_ABS), code 48
(ABS_MT_TOUCH_MAJOR), value 108
Event: time 1393156546.784405, type 3 (EV_ABS), code 49
(ABS_MT_TOUCH_MINOR), value 120
Event: time 1393156546.784405, type 3 (EV_ABS), code 53
(ABS_MT_POSITION_X), value 2004
Event: time 1393156546.784405, type 3 (EV_ABS), code 54
(ABS_MT_POSITION_Y), value -460
Event: time 1393156546.784405, type 3 (EV_ABS), code 47 (ABS_MT_SLOT), value 9
Event: time 1393156546.784405, type 3 (EV_ABS), code 57
(ABS_MT_TRACKING_ID), value 17
Event: time 1393156546.784405, type 3 (EV_ABS), code 48
(ABS_MT_TOUCH_MAJOR), value 56
Event: time 1393156546.784405, type 3 (EV_ABS), code 49
(ABS_MT_TOUCH_MINOR), value 84
Event: time 1393156546.784405, type 3 (EV_ABS), code 53
(ABS_MT_POSITION_X), value -430
Event: time 1393156546.784405, type 3 (EV_ABS), code 54
(ABS_MT_POSITION_Y), value -785
Event: time 1393156546.784405, type 3 (EV_ABS), code 47 (ABS_MT_SLOT), value 10
Event: time 1393156546.784405, type 3 (EV_ABS), code 57
(ABS_MT_TRACKING_ID), value 18
Event: time 1393156546.784405, type 3 (EV_ABS), code 48
(ABS_MT_TOUCH_MAJOR), value 184
Event: time 1393156546.784405, type 3 (EV_ABS), code 49
(ABS_MT_TOUCH_MINOR), value 124
Event: time 1393156546.784405, type 3 (EV_ABS), code 53
(ABS_MT_POSITION_X), value 1040
Event: time 1393156546.784405, type 3 (EV_ABS), code 54
(ABS_MT_POSITION_Y), value -1008
Event: time 1393156546.784405, type 1 (EV_KEY), code 330 (BTN_TOUCH), value 1
Event: time 1393156546.784405, type 1 (EV_KEY), code 334
(BTN_TOOL_TRIPLETAP), value 1
Event: time 1393156546.784405, type 3 (EV_ABS), code 0 (ABS_X), value 2004
Event: time 1393156546.784405, type 3 (EV_ABS), code 1 (ABS_Y), value -460
Event: time 1393156546.784405, -------------- SYN_REPORT ------------
Event: time 1393156547.032985, type 1 (EV_KEY), code 334
(BTN_TOOL_TRIPLETAP), value 2
Event: time 1393156547.032985, -------------- SYN_REPORT ------------
Event: time 1393156547.068988, type 1 (EV_KEY), code 334
(BTN_TOOL_TRIPLETAP), value 2
Event: time 1393156547.068988, -------------- SYN_REPORT ------------
Event: time 1393156547.104987, type 1 (EV_KEY), code 334
(BTN_TOOL_TRIPLETAP), value 2
[...]

The last two rows are repeated until it eventually becomes responsive again.

[3.] Keywords:
input, multitouch, magic trackpad, hid, bluetooth

[4.] Kernel version (from /proc/version):
Linux version 3.14.0-1-mainline (tom@tomlaeptop) (gcc version 4.8.2
20140206 (prerelease) (GCC) ) #3 SMP PREEMPT Sat Mar 15 17:22:55 CET
2014 (which is 3.14-rc6)

[5.] Output of Oops.. message
none

[6.] A small shell script or example program which triggers the
     problem
Just tapping it with three fingers worked for me on different machines.

[7.] Environment
[7.1.] Software:
% sh scripts/ver_linux
Linux tomlaeptop 3.14.0-1-mainline #3 SMP PREEMPT Sat Mar 15 17:22:55
CET 2014 x86_64 GNU/Linux

Gnu C                  4.8.2
Gnu make               4.0
binutils               2.24
util-linux             2.24.1
mount                  assert
module-init-tools      16
e2fsprogs              1.42.9
jfsutils               1.1.15
reiserfsprogs          3.6.24
xfsprogs               3.1.11
pcmciautils            018
PPP                    2.4.6
Linux C Library        2.19
Dynamic linker (ldd)   2.19
Linux C++ Library      6.0.19
Procps                 3.3.9
Kbd                    2.0.1
Sh-utils               8.22
Modules Loaded         hid_magicmouse hidp ctr ccm fuse bnep arc4
snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic ath9k
joydev uvcvideo ath9k_common nouveau videobuf2_vmalloc
videobuf2_memops videobuf2_core ath9k_hw mousedev btusb ttm intel_rapl
x86_pkg_temp_thermal ath videodev mac80211 bluetooth 6lowpan_iphc
snd_hda_intel snd_hda_codec cfg80211 intel_powerclamp media mxm_wmi
i915 atl1c asus_nb_wmi coretemp asus_wmi snd_hwdep drm_kms_helper
kvm_intel sparse_keymap iTCO_wdt snd_pcm rfkill iTCO_vendor_support
snd_timer snd soundcore psmouse drm kvm intel_gtt i2c_algo_bit lpc_ich
shpchp mei_me mei crct10dif_pclmul crc32_pclmul i2c_i801 i2c_core
crc32c_intel evdev thermal ghash_clmulni_intel serio_raw cryptd button
wmi video battery processor pcspkr microcode ac hid_logitech_dj usbhid
hid ext4 crc16 mbcache jbd2 sd_mod sr_mod crc_t10dif cdrom
crct10dif_common atkbd libps2 ahci libahci libata ehci_pci xhci_hcd
ehci_hcd scsi_mod usbcore usb_common i8042 serio

[7.2.] Processor information (from /proc/cpuinfo):
 % cat /proc/cpuinfo
processor : 0
vendor_id : GenuineIntel
cpu family : 6
model : 42
model name : Intel(R) Core(TM) i7-2630QM CPU @ 2.00GHz
stepping : 7
microcode : 0x14
cpu MHz : 801.250
cache size : 6144 KB
physical id : 0
siblings : 8
core id : 0
cpu cores : 4
apicid : 0
initial apicid : 0
fpu : yes
fpu_exception : yes
cpuid level : 13
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl
vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt
tsc_deadline_timer xsave avx lahf_lm ida arat epb xsaveopt pln pts
dtherm tpr_shadow vnmi flexpriority ept vpid
bogomips : 3992.11
clflush size : 64
cache_alignment : 64
address sizes : 36 bits physical, 48 bits virtual
power management:

processor : 1
vendor_id : GenuineIntel
cpu family : 6
model : 42
model name : Intel(R) Core(TM) i7-2630QM CPU @ 2.00GHz
stepping : 7
microcode : 0x14
cpu MHz : 801.250
cache size : 6144 KB
physical id : 0
siblings : 8
core id : 1
cpu cores : 4
apicid : 2
initial apicid : 2
fpu : yes
fpu_exception : yes
cpuid level : 13
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl
vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt
tsc_deadline_timer xsave avx lahf_lm ida arat epb xsaveopt pln pts
dtherm tpr_shadow vnmi flexpriority ept vpid
bogomips : 3992.11
clflush size : 64
cache_alignment : 64
address sizes : 36 bits physical, 48 bits virtual
power management:

processor : 2
vendor_id : GenuineIntel
cpu family : 6
model : 42
model name : Intel(R) Core(TM) i7-2630QM CPU @ 2.00GHz
stepping : 7
microcode : 0x14
cpu MHz : 801.250
cache size : 6144 KB
physical id : 0
siblings : 8
core id : 2
cpu cores : 4
apicid : 4
initial apicid : 4
fpu : yes
fpu_exception : yes
cpuid level : 13
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl
vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt
tsc_deadline_timer xsave avx lahf_lm ida arat epb xsaveopt pln pts
dtherm tpr_shadow vnmi flexpriority ept vpid
bogomips : 3992.11
clflush size : 64
cache_alignment : 64
address sizes : 36 bits physical, 48 bits virtual
power management:

processor : 3
vendor_id : GenuineIntel
cpu family : 6
model : 42
model name : Intel(R) Core(TM) i7-2630QM CPU @ 2.00GHz
stepping : 7
microcode : 0x14
cpu MHz : 801.250
cache size : 6144 KB
physical id : 0
siblings : 8
core id : 3
cpu cores : 4
apicid : 6
initial apicid : 6
fpu : yes
fpu_exception : yes
cpuid level : 13
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl
vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt
tsc_deadline_timer xsave avx lahf_lm ida arat epb xsaveopt pln pts
dtherm tpr_shadow vnmi flexpriority ept vpid
bogomips : 3992.11
clflush size : 64
cache_alignment : 64
address sizes : 36 bits physical, 48 bits virtual
power management:

processor : 4
vendor_id : GenuineIntel
cpu family : 6
model : 42
model name : Intel(R) Core(TM) i7-2630QM CPU @ 2.00GHz
stepping : 7
microcode : 0x14
cpu MHz : 801.250
cache size : 6144 KB
physical id : 0
siblings : 8
core id : 0
cpu cores : 4
apicid : 1
initial apicid : 1
fpu : yes
fpu_exception : yes
cpuid level : 13
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl
vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt
tsc_deadline_timer xsave avx lahf_lm ida arat epb xsaveopt pln pts
dtherm tpr_shadow vnmi flexpriority ept vpid
bogomips : 3992.11
clflush size : 64
cache_alignment : 64
address sizes : 36 bits physical, 48 bits virtual
power management:

processor : 5
vendor_id : GenuineIntel
cpu family : 6
model : 42
model name : Intel(R) Core(TM) i7-2630QM CPU @ 2.00GHz
stepping : 7
microcode : 0x14
cpu MHz : 801.250
cache size : 6144 KB
physical id : 0
siblings : 8
core id : 1
cpu cores : 4
apicid : 3
initial apicid : 3
fpu : yes
fpu_exception : yes
cpuid level : 13
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl
vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt
tsc_deadline_timer xsave avx lahf_lm ida arat epb xsaveopt pln pts
dtherm tpr_shadow vnmi flexpriority ept vpid
bogomips : 3992.11
clflush size : 64
cache_alignment : 64
address sizes : 36 bits physical, 48 bits virtual
power management:

processor : 6
vendor_id : GenuineIntel
cpu family : 6
model : 42
model name : Intel(R) Core(TM) i7-2630QM CPU @ 2.00GHz
stepping : 7
microcode : 0x14
cpu MHz : 801.250
cache size : 6144 KB
physical id : 0
siblings : 8
core id : 2
cpu cores : 4
apicid : 5
initial apicid : 5
fpu : yes
fpu_exception : yes
cpuid level : 13
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl
vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt
tsc_deadline_timer xsave avx lahf_lm ida arat epb xsaveopt pln pts
dtherm tpr_shadow vnmi flexpriority ept vpid
bogomips : 3992.11
clflush size : 64
cache_alignment : 64
address sizes : 36 bits physical, 48 bits virtual
power management:

processor : 7
vendor_id : GenuineIntel
cpu family : 6
model : 42
model name : Intel(R) Core(TM) i7-2630QM CPU @ 2.00GHz
stepping : 7
microcode : 0x14
cpu MHz : 801.250
cache size : 6144 KB
physical id : 0
siblings : 8
core id : 3
cpu cores : 4
apicid : 7
initial apicid : 7
fpu : yes
fpu_exception : yes
cpuid level : 13
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl
vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt
tsc_deadline_timer xsave avx lahf_lm ida arat epb xsaveopt pln pts
dtherm tpr_shadow vnmi flexpriority ept vpid
bogomips : 3992.11
clflush size : 64
cache_alignment : 64
address sizes : 36 bits physical, 48 bits virtual
power management:

[7.3.] Module information (from /proc/modules):
hid_magicmouse 3737 0 - Live 0xffffffffa006a000
hidp 17190 1 - Live 0xffffffffa0060000
ctr 3831 1 - Live 0xffffffffa0012000
ccm 7830 1 - Live 0xffffffffa0004000
fuse 77100 3 - Live 0xffffffffa004a000
bnep 12957 2 - Live 0xffffffffa04a8000
arc4 2000 2 - Live 0xffffffffa0366000
snd_hda_codec_hdmi 36172 1 - Live 0xffffffffa0580000
snd_hda_codec_realtek 46356 1 - Live 0xffffffffa0504000
snd_hda_codec_generic 52731 1 snd_hda_codec_realtek, Live 0xffffffffa04e2000
ath9k 91269 0 - Live 0xffffffffa0517000
joydev 9631 0 - Live 0xffffffffa04a1000
uvcvideo 72580 0 - Live 0xffffffffa04c0000
ath9k_common 1874 1 ath9k, Live 0xffffffffa0220000
nouveau 1081560 0 - Live 0xffffffffa078a000
videobuf2_vmalloc 3304 1 uvcvideo, Live 0xffffffffa01d1000
videobuf2_memops 2335 1 videobuf2_vmalloc, Live 0xffffffffa001a000
videobuf2_core 29255 1 uvcvideo, Live 0xffffffffa0488000
ath9k_hw 388208 2 ath9k,ath9k_common, Live 0xffffffffa072a000
mousedev 10247 0 - Live 0xffffffffa03c9000
btusb 20104 0 - Live 0xffffffffa0449000
ttm 65416 1 nouveau, Live 0xffffffffa037f000
intel_rapl 11712 0 - Live 0xffffffffa035c000
x86_pkg_temp_thermal 6991 0 - Live 0xffffffffa0114000
ath 19259 3 ath9k,ath9k_common,ath9k_hw, Live 0xffffffffa0168000
videodev 122731 2 uvcvideo,videobuf2_core, Live 0xffffffffa02ec000
mac80211 489393 1 ath9k, Live 0xffffffffa06b1000
bluetooth 341041 28 hidp,bnep,btusb, Live 0xffffffffa0607000
6lowpan_iphc 11204 1 bluetooth, Live 0xffffffffa010a000
snd_hda_intel 37640 3 - Live 0xffffffffa00d6000
snd_hda_codec 99359 4
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,
Live 0xffffffffa00ac000
cfg80211 430526 3 ath9k,ath,mac80211, Live 0xffffffffa03d8000
intel_powerclamp 9122 0 - Live 0xffffffffa0014000
media 12071 2 uvcvideo,videodev, Live 0xffffffffa000c000
mxm_wmi 1467 1 nouveau, Live 0xffffffffa0d88000
i915 736554 4 - Live 0xffffffffa0cad000
atl1c 36834 0 - Live 0xffffffffa0c9f000
asus_nb_wmi 7368 0 - Live 0xffffffffa0c9a000
coretemp 6390 0 - Live 0xffffffffa0c70000
asus_wmi 15869 1 asus_nb_wmi, Live 0xffffffffa0c62000
snd_hwdep 6204 1 snd_hda_codec, Live 0xffffffffa0c5c000
drm_kms_helper 35540 2 nouveau,i915, Live 0xffffffffa0c4c000
kvm_intel 132876 0 - Live 0xffffffffa0b48000
sparse_keymap 3146 1 asus_wmi, Live 0xffffffffa0b00000
iTCO_wdt 5407 0 - Live 0xffffffffa0afb000
snd_pcm 80987 3 snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec, Live
0xffffffffa0adc000
rfkill 15651 7 bluetooth,cfg80211,asus_wmi, Live 0xffffffffa0ad3000
iTCO_vendor_support 1929 1 iTCO_wdt, Live 0xffffffffa0acf000
snd_timer 18654 1 snd_pcm, Live 0xffffffffa0ac5000
snd 58742 14 snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_timer,
Live 0xffffffffa0aac000
soundcore 5386 1 snd, Live 0xffffffffa0aa6000
psmouse 88646 0 - Live 0xffffffffa0a2a000
drm 237627 7 nouveau,ttm,i915,drm_kms_helper, Live 0xffffffffa094d000
kvm 404108 1 kvm_intel, Live 0xffffffffa05a3000
intel_gtt 12536 1 i915, Live 0xffffffffa059b000
i2c_algo_bit 5391 2 nouveau,i915, Live 0xffffffffa0596000
lpc_ich 13368 0 - Live 0xffffffffa058d000
shpchp 25393 0 - Live 0xffffffffa0551000
mei_me 9456 0 - Live 0xffffffffa054a000
mei 64454 1 mei_me, Live 0xffffffffa0532000
crct10dif_pclmul 4682 0 - Live 0xffffffffa0514000
crc32_pclmul 2923 0 - Live 0xffffffffa04fc000
i2c_i801 11173 0 - Live 0xffffffffa04f5000
i2c_core 24248 7
nouveau,videodev,i915,drm_kms_helper,drm,i2c_algo_bit,i2c_i801, Live
0xffffffffa04db000
crc32c_intel 14185 0 - Live 0xffffffffa04bb000
evdev 10949 16 - Live 0xffffffffa04b4000
thermal 8556 0 - Live 0xffffffffa04ad000
ghash_clmulni_intel 4405 0 - Live 0xffffffffa049e000
serio_raw 5009 0 - Live 0xffffffffa0499000
cryptd 8377 1 ghash_clmulni_intel, Live 0xffffffffa0484000
button 4477 2 nouveau,i915, Live 0xffffffffa0472000
wmi 8059 3 nouveau,mxm_wmi,asus_wmi, Live 0xffffffffa046c000
video 11713 3 nouveau,i915,asus_wmi, Live 0xffffffffa0463000
battery 7565 0 - Live 0xffffffffa045d000
processor 24321 0 - Live 0xffffffffa03d1000
pcspkr 2027 0 - Live 0xffffffffa03cd000
microcode 16773 0 - Live 0xffffffffa03b2000
ac 3334 0 - Live 0xffffffffa03ae000
hid_logitech_dj 10567 0 - Live 0xffffffffa039d000
usbhid 40577 0 - Live 0xffffffffa0369000
hid 91062 5 hid_magicmouse,hidp,hid_logitech_dj,usbhid, Live 0xffffffffa030f000
ext4 481870 1 - Live 0xffffffffa0275000
crc16 1359 2 bluetooth,ext4, Live 0xffffffffa0271000
mbcache 6074 1 ext4, Live 0xffffffffa026b000
jbd2 82672 1 ext4, Live 0xffffffffa024a000
sd_mod 36658 2 - Live 0xffffffffa022e000
sr_mod 14450 0 - Live 0xffffffffa0222000
crc_t10dif 1039 1 sd_mod, Live 0xffffffffa021e000
cdrom 33888 1 sr_mod, Live 0xffffffffa0210000
crct10dif_common 1372 2 crct10dif_pclmul,crc_t10dif, Live 0xffffffffa020c000
atkbd 16806 0 - Live 0xffffffffa01e5000
libps2 4187 2 psmouse,atkbd, Live 0xffffffffa01d3000
ahci 23499 1 - Live 0xffffffffa01c7000
libahci 21484 1 ahci, Live 0xffffffffa01bb000
libata 171784 2 ahci,libahci, Live 0xffffffffa017a000
ehci_pci 3928 0 - Live 0xffffffffa0172000
xhci_hcd 145277 0 - Live 0xffffffffa0143000
ehci_hcd 64043 1 ehci_pci, Live 0xffffffffa0117000
scsi_mod 133920 3 sd_mod,sr_mod,libata, Live 0xffffffffa00e2000
usbcore 180947 6 uvcvideo,btusb,usbhid,ehci_pci,xhci_hcd,ehci_hcd,
Live 0xffffffffa001c000
usb_common 1648 1 usbcore, Live 0xffffffffa0018000
i8042 12950 1 libps2, Live 0xffffffffa0007000
serio 10721 9 psmouse,serio_raw,atkbd,i8042, Live 0xffffffffa0000000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
 % cat /proc/ioports
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
  03c0-03df : vga+
  0400-0403 : ACPI PM1a_EVT_BLK
  0404-0405 : ACPI PM1a_CNT_BLK
  0408-040b : ACPI PM_TMR
  0410-0415 : ACPI CPU throttle
  0420-042f : ACPI GPE0_BLK
  0430-0433 : iTCO_wdt
    0430-0433 : iTCO_wdt
  0450-0450 : ACPI PM2_CNT_BLK
  0454-0457 : pnp 00:06
  0458-047f : pnp 00:04
    0460-047f : iTCO_wdt
      0460-047f : iTCO_wdt
  0500-057f : pnp 00:04
  0680-069f : pnp 00:04
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
  1000-100f : pnp 00:04
  164e-164f : pnp 00:04
  9000-9fff : PCI Bus 0000:05
    9000-907f : 0000:05:00.0
      9000-907f : atl1c
  a000-afff : PCI Bus 0000:04
  b000-bfff : PCI Bus 0000:03
  c000-cfff : PCI Bus 0000:02
  d000-dfff : PCI Bus 0000:01
    d000-d07f : 0000:01:00.0
  e000-e03f : 0000:00:02.0
  e040-e05f : 0000:00:1f.3
  e060-e07f : 0000:00:1f.2
    e060-e07f : ahci
  e080-e083 : 0000:00:1f.2
    e080-e083 : ahci
  e090-e097 : 0000:00:1f.2
    e090-e097 : ahci
  e0a0-e0a3 : 0000:00:1f.2
    e0a0-e0a3 : ahci
  e0b0-e0b7 : 0000:00:1f.2
    e0b0-e0b7 : ahci
  ffff-ffff : pnp 00:04
    ffff-ffff : pnp 00:04

 % cat /proc/iomem
00000000-00000fff : reserved
00001000-0009e7ff : System RAM
0009e800-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000cedff : Video ROM
000d0000-000d3fff : PCI Bus 0000:00
000d4000-000d7fff : PCI Bus 0000:00
000d8000-000dbfff : PCI Bus 0000:00
000dc000-000dffff : PCI Bus 0000:00
000e0000-000fffff : reserved
  000e0000-000e3fff : PCI Bus 0000:00
  000e4000-000e7fff : PCI Bus 0000:00
  000f0000-000fffff : System ROM
00100000-1fffffff : System RAM
  01000000-0153b668 : Kernel code
  0153b669-018d33ff : Kernel data
  019f8000-01b41fff : Kernel bss
20000000-201fffff : reserved
  20000000-201fffff : pnp 00:0b
20200000-3fffffff : System RAM
40000000-401fffff : reserved
  40000000-401fffff : pnp 00:0b
40200000-aabd0fff : System RAM
aabd1000-aace3fff : reserved
aace4000-aace5fff : System RAM
aace6000-aacf8fff : reserved
aacf9000-aacf9fff : System RAM
aacfa000-aad8dfff : reserved
aad8e000-aad8efff : System RAM
aad8f000-aadb7fff : reserved
aadb8000-aadc7fff : System RAM
aadc8000-aade7fff : reserved
aade8000-aaf18fff : System RAM
aaf19000-aafe7fff : ACPI Non-volatile Storage
aafe8000-aaffcfff : System RAM
aaffd000-aaffffff : ACPI Tables
ab000000-af9fffff : reserved
  aba00000-af9fffff : Graphics Stolen Memory
afa00000-feafffff : PCI Bus 0000:00
  afa00000-afa00fff : pnp 00:09
    afa00000-afa00fff : pnp 00:0a
  b0000000-bfffffff : 0000:00:02.0
  c0000000-d1ffffff : PCI Bus 0000:01
    c0000000-cfffffff : 0000:01:00.0
    d0000000-d1ffffff : 0000:01:00.0
  d2100000-d2afffff : PCI Bus 0000:05
  d2c00000-d35fffff : PCI Bus 0000:04
  d3700000-d40fffff : PCI Bus 0000:03
  d4200000-d4bfffff : PCI Bus 0000:02
  db000000-dc0fffff : PCI Bus 0000:01
    db000000-dbffffff : 0000:01:00.0
    dc000000-dc07ffff : 0000:01:00.0
  dc400000-dc7fffff : 0000:00:02.0
  dc800000-dd1fffff : PCI Bus 0000:05
    dc800000-dc83ffff : 0000:05:00.0
      dc800000-dc83ffff : atl1c
  dd200000-ddbfffff : PCI Bus 0000:04
    dd200000-dd20ffff : 0000:04:00.0
      dd200000-dd20ffff : xhci_hcd
  ddc00000-de5fffff : PCI Bus 0000:03
    ddc00000-ddc0ffff : 0000:03:00.0
      ddc00000-ddc0ffff : ath9k
  de600000-deffffff : PCI Bus 0000:02
  df000000-df003fff : 0000:00:1b.0
    df000000-df003fff : ICH HD audio
  df005000-df0050ff : 0000:00:1f.3
  df006000-df0067ff : 0000:00:1f.2
    df006000-df0067ff : ahci
  df007000-df0073ff : 0000:00:1d.0
    df007000-df0073ff : ehci_hcd
  df008000-df0083ff : 0000:00:1a.0
    df008000-df0083ff : ehci_hcd
  df00a000-df00a00f : 0000:00:16.0
    df00a000-df00a00f : mei_me
  e0000000-e3ffffff : PCI MMCONFIG 0000 [bus 00-3f]
    e0000000-e3ffffff : reserved
      e0000000-e3ffffff : pnp 00:09
fec00000-fec00fff : reserved
  fec00000-fec003ff : IOAPIC 0
fed00000-fed003ff : HPET 0
fed10000-fed13fff : reserved
fed18000-fed19fff : reserved
  fed18000-fed18fff : pnp 00:09
  fed19000-fed19fff : pnp 00:09
fed1c000-fed1ffff : reserved
  fed1c000-fed1ffff : pnp 00:09
    fed1f410-fed1f414 : iTCO_wdt
      fed1f410-fed1f414 : iTCO_wdt
fed20000-fed3ffff : pnp 00:09
fed40000-fed44fff : PCI Bus 0000:00
fed45000-fed8ffff : pnp 00:09
fed90000-fed93fff : pnp 00:09
fee00000-fee00fff : Local APIC
  fee00000-fee00fff : reserved
ff980000-ffbfffff : reserved
ffd80000-ffffffff : reserved
100000000-34fdfffff : System RAM
34fe00000-34fffffff : RAM buffer

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: Intel Corporation 2nd Generation Core Processor
Family DRAM Controller (rev 09)
Subsystem: ASUSTeK Computer Inc. Device 11d7
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort+ <MAbort+ >SERR- <PERR- INTx-
Latency: 0
Capabilities: [e0] Vendor Specific Information: Len=0c <?>

00:01.0 PCI bridge: Intel Corporation Xeon E3-1200/2nd Generation Core
Processor Family PCI Express Root Port (rev 09) (prog-if 00 [Normal
decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
I/O behind bridge: 0000d000-0000dfff
Memory behind bridge: db000000-dc0fffff
Prefetchable memory behind bridge: 00000000c0000000-00000000d1ffffff
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: [88] Subsystem: ASUSTeK Computer Inc. Device 11d7
Capabilities: [80] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
Address: fee00000  Data: 4071
Capabilities: [a0] Express (v2) Root Port (Slot+), MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0
ExtTag- RBE+
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
LnkCap: Port #2, Speed 5GT/s, Width x16, ASPM L0s L1, Exit Latency L0s
<256ns, L1 <4us
ClockPM- Surprise- LLActRep- BwNot+
LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x16, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-
SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
Slot #1, PowerLimit 75.000W; Interlock- NoCompl+
SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
Changed: MRL- PresDet+ LinkState-
RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
RootCap: CRSVisible-
RootSta: PME ReqID 0000, PMEStatus- PMEPending-
DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR+, OBFF
Not Supported ARIFwd-
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF
Disabled ARIFwd-
LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
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
Arb: Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
Ctrl: Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
Status: NegoPending- InProgress-
Capabilities: [140 v1] Root Complex Link
Desc: PortNumber=02 ComponentID=01 EltType=Config
Link0: Desc: TargetPort=00 TargetComponent=01 AssocRCRB-
LinkType=MemMapped LinkValid+
Addr: 00000000fed19000
Kernel driver in use: pcieport
Kernel modules: shpchp

00:02.0 VGA compatible controller: Intel Corporation 2nd Generation
Core Processor Family Integrated Graphics Controller (rev 09) (prog-if
00 [VGA controller])
Subsystem: ASUSTeK Computer Inc. Device 15e2
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 43
Region 0: Memory at dc400000 (64-bit, non-prefetchable) [size=4M]
Region 2: Memory at b0000000 (64-bit, prefetchable) [size=256M]
Region 4: I/O ports at e000 [size=64]
Expansion ROM at <unassigned> [disabled]
Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
Address: fee00000  Data: 40c1
Capabilities: [d0] Power Management version 2
Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [a4] PCI Advanced Features
AFCap: TP+ FLR+
AFCtrl: FLR-
AFStatus: TP-
Kernel driver in use: i915
Kernel modules: i915

00:16.0 Communication controller: Intel Corporation 6 Series/C200
Series Chipset Family MEI Controller #1 (rev 04)
Subsystem: ASUSTeK Computer Inc. Device 11d7
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 42
Region 0: Memory at df00a000 (64-bit, non-prefetchable) [size=16]
Capabilities: [50] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
Address: 00000000fee00000  Data: 40b1
Kernel driver in use: mei_me
Kernel modules: mei_me

00:1a.0 USB controller: Intel Corporation 6 Series/C200 Series Chipset
Family USB Enhanced Host Controller #2 (rev 05) (prog-if 20 [EHCI])
Subsystem: ASUSTeK Computer Inc. Device 11d7
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 16
Region 0: Memory at df008000 (32-bit, non-prefetchable) [size=1K]
Capabilities: [50] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [58] Debug port: BAR=1 offset=00a0
Capabilities: [98] PCI Advanced Features
AFCap: TP+ FLR+
AFCtrl: FLR-
AFStatus: TP-
Kernel driver in use: ehci-pci
Kernel modules: ehci_pci

00:1b.0 Audio device: Intel Corporation 6 Series/C200 Series Chipset
Family High Definition Audio Controller (rev 05)
Subsystem: ASUSTeK Computer Inc. Device 1a33
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 44
Region 0: Memory at df000000 (64-bit, non-prefetchable) [size=16K]
Capabilities: [50] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
Address: 00000000fee00000  Data: 40e1
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
Ctrl: Enable+ ID=1 ArbSelect=Fixed TC/VC=22
Status: NegoPending- InProgress-
Capabilities: [130 v1] Root Complex Link
Desc: PortNumber=0f ComponentID=00 EltType=Config
Link0: Desc: TargetPort=00 TargetComponent=00 AssocRCRB-
LinkType=MemMapped LinkValid+
Addr: 00000000fed1c000
Kernel driver in use: snd_hda_intel
Kernel modules: snd_hda_intel

00:1c.0 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset
Family PCI Express Root Port 1 (rev b5) (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
I/O behind bridge: 0000c000-0000cfff
Memory behind bridge: de600000-deffffff
Prefetchable memory behind bridge: 00000000d4200000-00000000d4bfffff
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
<1us, L1 <16us
ClockPM- Surprise- LLActRep+ BwNot-
LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-
SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
Slot #0, PowerLimit 10.000W; Interlock- NoCompl+
SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
Changed: MRL- PresDet- LinkState-
RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
RootCap: CRSVisible-
RootSta: PME ReqID 0000, PMEStatus- PMEPending-
DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF Not
Supported ARIFwd-
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF
Disabled ARIFwd-
LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
Address: 00000000  Data: 0000
Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 11d7
Capabilities: [a0] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Kernel driver in use: pcieport
Kernel modules: shpchp

00:1c.1 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset
Family PCI Express Root Port 2 (rev b5) (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
I/O behind bridge: 0000b000-0000bfff
Memory behind bridge: ddc00000-de5fffff
Prefetchable memory behind bridge: 00000000d3700000-00000000d40fffff
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
LnkCap: Port #2, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s
<512ns, L1 <16us
ClockPM- Surprise- LLActRep+ BwNot-
LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+
BWMgmt+ ABWMgmt-
SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
Slot #1, PowerLimit 10.000W; Interlock- NoCompl+
SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
Changed: MRL- PresDet- LinkState+
RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
RootCap: CRSVisible-
RootSta: PME ReqID 0000, PMEStatus- PMEPending-
DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF Not
Supported ARIFwd-
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF
Disabled ARIFwd-
LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
Address: 00000000  Data: 0000
Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 11d7
Capabilities: [a0] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Kernel driver in use: pcieport
Kernel modules: shpchp

00:1c.3 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset
Family PCI Express Root Port 4 (rev b5) (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
I/O behind bridge: 0000a000-0000afff
Memory behind bridge: dd200000-ddbfffff
Prefetchable memory behind bridge: 00000000d2c00000-00000000d35fffff
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
DevSta: CorrErr- UncorrErr+ FatalErr- UnsuppReq- AuxPwr+ TransPend-
LnkCap: Port #4, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s
<512ns, L1 <16us
ClockPM- Surprise- LLActRep+ BwNot-
LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+
BWMgmt+ ABWMgmt-
SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
Slot #3, PowerLimit 10.000W; Interlock- NoCompl+
SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
Changed: MRL- PresDet- LinkState+
RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
RootCap: CRSVisible-
RootSta: PME ReqID 0000, PMEStatus- PMEPending-
DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF Not
Supported ARIFwd-
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF
Disabled ARIFwd-
LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
Address: 00000000  Data: 0000
Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 11d7
Capabilities: [a0] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Kernel driver in use: pcieport
Kernel modules: shpchp

00:1c.5 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset
Family PCI Express Root Port 6 (rev b5) (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
I/O behind bridge: 00009000-00009fff
Memory behind bridge: dc800000-dd1fffff
Prefetchable memory behind bridge: 00000000d2100000-00000000d2afffff
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
LnkCap: Port #6, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s
<512ns, L1 <16us
ClockPM- Surprise- LLActRep+ BwNot-
LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
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
DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF Not
Supported ARIFwd-
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF
Disabled ARIFwd-
LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
Address: 00000000  Data: 0000
Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 11d7
Capabilities: [a0] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Kernel driver in use: pcieport
Kernel modules: shpchp

00:1d.0 USB controller: Intel Corporation 6 Series/C200 Series Chipset
Family USB Enhanced Host Controller #1 (rev 05) (prog-if 20 [EHCI])
Subsystem: ASUSTeK Computer Inc. Device 11d7
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 23
Region 0: Memory at df007000 (32-bit, non-prefetchable) [size=1K]
Capabilities: [50] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [58] Debug port: BAR=1 offset=00a0
Capabilities: [98] PCI Advanced Features
AFCap: TP+ FLR+
AFCtrl: FLR-
AFStatus: TP-
Kernel driver in use: ehci-pci
Kernel modules: ehci_pci

00:1f.0 ISA bridge: Intel Corporation HM65 Express Chipset Family LPC
Controller (rev 05)
Subsystem: ASUSTeK Computer Inc. Device 11d7
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Capabilities: [e0] Vendor Specific Information: Len=0c <?>
Kernel driver in use: lpc_ich
Kernel modules: lpc_ich

00:1f.2 SATA controller: Intel Corporation 6 Series/C200 Series
Chipset Family 6 port SATA AHCI Controller (rev 05) (prog-if 01 [AHCI
1.0])
Subsystem: ASUSTeK Computer Inc. Device 11d7
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin B routed to IRQ 41
Region 0: I/O ports at e0b0 [size=8]
Region 1: I/O ports at e0a0 [size=4]
Region 2: I/O ports at e090 [size=8]
Region 3: I/O ports at e080 [size=4]
Region 4: I/O ports at e060 [size=32]
Region 5: Memory at df006000 (32-bit, non-prefetchable) [size=2K]
Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
Address: fee00000  Data: 4091
Capabilities: [70] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
Capabilities: [b0] PCI Advanced Features
AFCap: TP+ FLR+
AFCtrl: FLR-
AFStatus: TP-
Kernel driver in use: ahci
Kernel modules: ahci

00:1f.3 SMBus: Intel Corporation 6 Series/C200 Series Chipset Family
SMBus Controller (rev 05)
Subsystem: ASUSTeK Computer Inc. Device 11d7
Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Interrupt: pin C routed to IRQ 18
Region 0: Memory at df005000 (64-bit, non-prefetchable) [size=256]
Region 4: I/O ports at e040 [size=32]
Kernel modules: i2c_i801

01:00.0 VGA compatible controller: NVIDIA Corporation GF108M [GeForce
GT 540M] (rev a1) (prog-if 00 [VGA controller])
Subsystem: ASUSTeK Computer Inc. Device 15e2
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 45
Region 0: Memory at db000000 (32-bit, non-prefetchable) [size=16M]
Region 1: Memory at c0000000 (64-bit, prefetchable) [size=256M]
Region 3: Memory at d0000000 (64-bit, prefetchable) [size=32M]
Region 5: I/O ports at d000 [size=128]
Expansion ROM at dc000000 [disabled] [size=512K]
Capabilities: [60] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [68] MSI: Enable+ Count=1/1 Maskable- 64bit+
Address: 00000000fee00000  Data: 4022
Capabilities: [78] Express (v2) Endpoint, MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 <64us
ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 512 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
LnkCap: Port #0, Speed 5GT/s, Width x16, ASPM L0s L1, Exit Latency L0s
<256ns, L1 <4us
ClockPM+ Surprise- LLActRep- BwNot-
LnkCtl: ASPM L1 Enabled; RCB 128 bytes Disabled- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x16, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-
DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR-, OBFF
Not Supported
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [b4] Vendor Specific Information: Len=14 <?>
Capabilities: [100 v1] Virtual Channel
Caps: LPEVC=0 RefClk=100ns PATEntryBits=1
Arb: Fixed- WRR32- WRR64- WRR128-
Ctrl: ArbSelect=Fixed
Status: InProgress-
VC0: Caps: PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
Arb: Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
Ctrl: Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
Status: NegoPending- InProgress-
Capabilities: [128 v1] Power Budgeting <?>
Capabilities: [600 v1] Vendor Specific Information: ID=0001 Rev=1 Len=024 <?>
Kernel driver in use: nouveau
Kernel modules: nouveau

03:00.0 Network controller: Qualcomm Atheros AR9285 Wireless Network
Adapter (PCI-Express) (rev 01)
Subsystem: AzureWave AW-NB037H 802.11bgn Wireless Half-size Mini PCIe
Card [AR9002WB-1NGCD]
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 17
Region 0: Memory at ddc00000 (64-bit, non-prefetchable) [size=64K]
Capabilities: [40] Power Management version 3
Flags: PMEClk- DSI- D1+ D2- AuxCurrent=375mA PME(D0+,D1+,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit-
Address: 00000000  Data: 0000
Capabilities: [60] Express (v2) Legacy Endpoint, MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 512 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency
L0s <512ns, L1 <64us
ClockPM- Surprise- LLActRep- BwNot-
LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-
DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR-, OBFF
Not Supported
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
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
AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
Capabilities: [140 v1] Virtual Channel
Caps: LPEVC=0 RefClk=100ns PATEntryBits=1
Arb: Fixed- WRR32- WRR64- WRR128-
Ctrl: ArbSelect=Fixed
Status: InProgress-
VC0: Caps: PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
Arb: Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
Ctrl: Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
Status: NegoPending- InProgress-
Capabilities: [160 v1] Device Serial Number 00-15-17-ff-ff-24-14-12
Capabilities: [170 v1] Power Budgeting <?>
Kernel driver in use: ath9k
Kernel modules: ath9k

04:00.0 USB controller: Fresco Logic FL1000G USB 3.0 Host Controller
(rev 04) (prog-if 30 [XHCI])
Subsystem: ASUSTeK Computer Inc. Device 1039
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 19
Region 0: Memory at dd200000 (32-bit, non-prefetchable) [size=64K]
Capabilities: [50] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold-)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [68] MSI: Enable- Count=1/1 Maskable- 64bit+
Address: 0000000000000000  Data: 0000
Capabilities: [80] Express (v1) Endpoint, MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <2us, L1 <32us
ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
MaxPayload 128 bytes, MaxReadReq 512 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency
L0s unlimited, L1 unlimited
ClockPM- Surprise- LLActRep- BwNot-
LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-
Kernel driver in use: xhci_hcd
Kernel modules: xhci_hcd

05:00.0 Ethernet controller: Qualcomm Atheros AR8151 v2.0 Gigabit
Ethernet (rev c0)
Subsystem: ASUSTeK Computer Inc. Device 1851
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 46
Region 0: Memory at dc800000 (64-bit, non-prefetchable) [size=256K]
Region 2: I/O ports at 9000 [size=128]
Capabilities: [40] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [48] MSI: Enable+ Count=1/1 Maskable- 64bit+
Address: 00000000fee00000  Data: 4042
Capabilities: [58] Express (v1) Endpoint, MSI 00
DevCap: MaxPayload 4096 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
ExtTag- AttnBtn+ AttnInd+ PwrInd+ RBE+ FLReset-
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 512 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency
L0s unlimited, L1 unlimited
ClockPM+ Surprise- LLActRep- BwNot-
LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-
Capabilities: [6c] Vital Product Data
pcilib: sysfs_read_vpd: read failed: Connection timed out
Not readable
Capabilities: [100 v1] Advanced Error Reporting
UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UESvrt: DLP- SDES+ TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
Capabilities: [180 v1] Device Serial Number ff-f4-1b-99-f4-6d-04-ff
Kernel driver in use: atl1c
Kernel modules: atl1c

[7.6.] SCSI information (from /proc/scsi/scsi)
 % cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST9750420AS      Rev: 0002
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST9750420AS      Rev: 0002
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: Slimtype Model: BD  E  DS4E1S    Rev: EA2B
  Type:   CD-ROM                           ANSI  SCSI revision: 05

[7.7.] Other information that might be relevant to the problem:
% ls /proc
1/      17/    27/   415/  59/   9721/        kallsyms
10/     171/   278/  418/  591/  9726/        kcore
100/    174/   28/   42/   598/  9730/        key-users
10049/  175/   283/  420/  60/   9731/        kmsg
101/    18/    29/   429/  601/  9732/        kpagecount
10159/  185/   292/  43/   604/  9736/        kpageflags
10173/  19/    293/  430/  605/  9737/        loadavg
10198/  193/   295/  44/   611/  9765/        locks
102/    195/   299/  444/  617/  9774/        meminfo
10211/  198/   3/    456/  621/  9781/        misc
10260/  2/     307/  46/   645/  9788/        modules
10261/  205/   309/  463/  647/  9794/        mounts@
10296/  21/    31/   468/  65/   9805/        mtrr
103/    2129/  312/  47/   652/  9892/        net@
10383/  22/    314/  48/   658/  9971/        pagetypeinfo
104/    225/   315/  481/  659/  acpi/        partitions
105/    226/   32/   49/   66/   asound/      sched_debug
106/    23/    33/   490/  69/   buddyinfo    schedstat
107/    233/   34/   5/    7/    bus/         scsi/
108/    234/   35/   50/   709/  cgroups      self@
109/    236/   36/   51/   715/  cmdline      slabinfo
11/     238/   37/   514/  741/  config.gz    softirqs
110/    24/    372/  518/  743/  consoles     stat
111/    247/   38/   52/   744/  cpuinfo      swaps
112/    248/   389/  520/  770/  crypto       sys/
119/    2484/  39/   53/   778/  devices      sysrq-trigger
12/     25/    390/  530/  796/  diskstats    sysvipc/
120/    250/   397/  538/  8/    dma          timer_list
13/     251/   398/  539/  808/  driver/      timer_stats
135/    252/   402/  54/   810/  execdomains  tty/
14/     254/   403/  540/  861/  fb           uptime
145/    255/   406/  546/  891/  filesystems  version
146/    256/   407/  549/  9/    fs/          vmallocinfo
147/    257/   408/  55/   931/  interrupts   vmstat
149/    26/    41/   57/   933/  iomem        zoneinfo
150/    260/   412/  58/   96/   ioports
16/     269/   414/  589/  97/   irq/

[X.] Other notes, patches, fixes, workarounds:
I tried debugging the problem, but I wasn't very succesful. Only thing
I figured out, it is probably unrelated to the magictrackpad driver,
even when making its raw_event function just return it would still get
stuck. I got lost somewhere in between net/bluetooth/hidp/core.c and
drivers/hid/hid-core.c, for some reason my printks in hid-core.c
wouldn't show up. My guess was that somewhere in the hid system, the
thread would get blocked and continuously spam the three finger touch
event blocking all other events.
Similarly hcidump shows that all bluetooth communication to this
device stops after touching it with three fingers.

This is the last output I get from hcidump:

> ACL data: handle 21 flags 0x02 dlen 36
    L2CAP(d): cid 0x0041 len 32 [psm 0]
      A1 28 C4 5A F3 96 03 4E FC 18 27 06 81 32 90 27 FD A7 01 0F
      43 F1 10 9C 7E 18 FC 0B 16 C4 A6 10

"Normal" output would look about like this, that's for a single finger:

> ACL data: handle 21 flags 0x02 dlen 18
    L2CAP(d): cid 0x0041 len 14 [psm 0]
      A1 28 A8 2D 00 5A 7D F0 0F 00 00 C0 81 74
