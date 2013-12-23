From: Robert van Geerenstein <info@r15n.nl>
Subject: [Dell Inspiron 17R SE 7720] Synaptics touchpad recognized as PS/2
 Generic Mouse
Date: Mon, 23 Dec 2013 19:20:16 +0100
Message-ID: <52B87EE0.5030104@r15n.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailer01.deralte.nl ([213.154.229.52]:33515 "EHLO
	mailer01.deralte.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753085Ab3LWSZb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Dec 2013 13:25:31 -0500
Received: from localhost (localhost [127.0.0.1])
	by mailer01.deralte.nl (Postfix) with ESMTP id 7029540D0F
	for <linux-input@vger.kernel.org>; Mon, 23 Dec 2013 19:19:57 +0100 (CET)
Received: from mailer01.deralte.nl ([127.0.0.1])
	by localhost (mailer01.deralte.nl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ol2lADVhDISH for <linux-input@vger.kernel.org>;
	Mon, 23 Dec 2013 19:19:53 +0100 (CET)
Received: from [192.168.1.103] (5357A89F.cm-6-8c.dynamic.ziggo.nl [83.87.168.159])
	(Authenticated sender: info@r15n.nl)
	by mailer01.deralte.nl (Postfix) with ESMTPSA id ECD024087F
	for <linux-input@vger.kernel.org>; Mon, 23 Dec 2013 19:19:52 +0100 (CET)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

My touchpad is detected as a PS/2 Generic Mouse on my Dell Inspiron 772=
0=20
(17R SE).
It only has the functionality of a generic mouse (movement, left clik,=20
right click) and no scrolling or multitouch.

Launchpad bugreport:=20
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1144000


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
There was a duplicate bugreport in this mailinglist posted by Jason O.=20
back in August (http://www.spinics.net/lists/linux-input/msg27046.html)=
,=20
but this was incomplete.

Bug reports by Jason O.
Launchpad
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1093237
kernel.org
https://bugzilla.kernel.org/show_bug.cgi?id=3D60739
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D


Info:

# cat /proc/version
Linux version 3.13.0-031300rc5-generic (apw@gomeisa) (gcc version 4.6.3=
=20
(Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201312221635 SMP Sun Dec 22 21:37:23=20
UTC 2013

# lsb_release -rd
Description: Ubuntu 13.10
Release: 13.10

# sh /usr/src/linux-headers-3.13.0-031300rc5/scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux lapmans 3.13.0-031300rc5-generic #201312221635 SMP Sun Dec 22=20
21:37:23 UTC 2013 x86_64 x86_64 x86_64 GNU/Linux

Gnu C 4.8
Gnu make 3.81
binutils 2.23.52.20130913
util-linux 2.20.1
mount support
module-init-tools 9
e2fsprogs 1.42.8
pcmciautils 018
PPP 2.4.5
Linux C Library 2.17
Dynamic linker (ldd) 2.17
Procps 3.3.3
Net-tools 1.60
Kbd 1.15.5
Sh-utils 8.20
wireless-tools 30
Modules Loaded ctr ccm snd_hda_codec_hdmi snd_hda_codec_idt parport_pc=20
ppdev x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm=20
crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel aes_x86_6=
4=20
lrw gf128mul glue_helper ablk_helper cryptd dell_laptop dcdbas microcod=
e=20
psmouse serio_raw rfcomm bnep snd_hda_intel snd_hda_codec snd_hwdep=20
snd_pcm dm_multipath binfmt_misc arc4 scsi_dh snd_page_alloc iwldvm=20
snd_seq_midi snd_seq_midi_event mac80211 i915 uvcvideo snd_rawmidi=20
snd_seq videobuf2_vmalloc videobuf2_memops snd_seq_device videobuf2_cor=
e=20
snd_timer rts5139 videodev iwlwifi ext2 snd btusb drm_kms_helper=20
bluetooth drm dell_wmi cfg80211 sparse_keymap soundcore mei_me mei=20
i2c_algo_bit lpc_ich wmi lp mac_hid video parport raid10 raid456=20
async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq=
=20
raid1 raid0 multipath linear ahci r8169 libahci mii

# cat /proc/cpuinfo
processor : 0
vendor_id : GenuineIntel
cpu family : 6
model : 58
model name : Intel(R) Core(TM) i7-3630QM CPU @ 2.40GHz
stepping : 9
microcode : 0x15
cpu MHz : 1751.906
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
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov=20
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx=20
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology=20
nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx=
=20
est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt=20
tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm ida arat epb=20
xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase=20
smep erms
bogomips : 4788.86
clflush size : 64
cache_alignment : 64
address sizes : 36 bits physical, 48 bits virtual
power management:

processor : 1
vendor_id : GenuineIntel
cpu family : 6
model : 58
model name : Intel(R) Core(TM) i7-3630QM CPU @ 2.40GHz
stepping : 9
microcode : 0x15
cpu MHz : 1908.000
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
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov=20
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx=20
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology=20
nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx=
=20
est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt=20
tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm ida arat epb=20
xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase=20
smep erms
bogomips : 4788.86
clflush size : 64
cache_alignment : 64
address sizes : 36 bits physical, 48 bits virtual
power management:

processor : 2
vendor_id : GenuineIntel
cpu family : 6
model : 58
model name : Intel(R) Core(TM) i7-3630QM CPU @ 2.40GHz
stepping : 9
microcode : 0x15
cpu MHz : 1737.281
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
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov=20
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx=20
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology=20
nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx=
=20
est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt=20
tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm ida arat epb=20
xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase=20
smep erms
bogomips : 4788.86
clflush size : 64
cache_alignment : 64
address sizes : 36 bits physical, 48 bits virtual
power management:

processor : 3
vendor_id : GenuineIntel
cpu family : 6
model : 58
model name : Intel(R) Core(TM) i7-3630QM CPU @ 2.40GHz
stepping : 9
microcode : 0x15
cpu MHz : 1979.812
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
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov=20
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx=20
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology=20
nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx=
=20
est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt=20
tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm ida arat epb=20
xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase=20
smep erms
bogomips : 4788.86
clflush size : 64
cache_alignment : 64
address sizes : 36 bits physical, 48 bits virtual
power management:

processor : 4
vendor_id : GenuineIntel
cpu family : 6
model : 58
model name : Intel(R) Core(TM) i7-3630QM CPU @ 2.40GHz
stepping : 9
microcode : 0x15
cpu MHz : 1488.093
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
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov=20
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx=20
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology=20
nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx=
=20
est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt=20
tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm ida arat epb=20
xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase=20
smep erms
bogomips : 4788.86
clflush size : 64
cache_alignment : 64
address sizes : 36 bits physical, 48 bits virtual
power management:

processor : 5
vendor_id : GenuineIntel
cpu family : 6
model : 58
model name : Intel(R) Core(TM) i7-3630QM CPU @ 2.40GHz
stepping : 9
microcode : 0x15
cpu MHz : 1960.781
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
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov=20
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx=20
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology=20
nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx=
=20
est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt=20
tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm ida arat epb=20
xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase=20
smep erms
bogomips : 4788.86
clflush size : 64
cache_alignment : 64
address sizes : 36 bits physical, 48 bits virtual
power management:

processor : 6
vendor_id : GenuineIntel
cpu family : 6
model : 58
model name : Intel(R) Core(TM) i7-3630QM CPU @ 2.40GHz
stepping : 9
microcode : 0x15
cpu MHz : 1885.312
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
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov=20
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx=20
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology=20
nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx=
=20
est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt=20
tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm ida arat epb=20
xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase=20
smep erms
bogomips : 4788.86
clflush size : 64
cache_alignment : 64
address sizes : 36 bits physical, 48 bits virtual
power management:

processor : 7
vendor_id : GenuineIntel
cpu family : 6
model : 58
model name : Intel(R) Core(TM) i7-3630QM CPU @ 2.40GHz
stepping : 9
microcode : 0x15
cpu MHz : 1815.843
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
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov=20
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx=20
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology=20
nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx=
=20
est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt=20
tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm ida arat epb=20
xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase=20
smep erms
bogomips : 4788.86
clflush size : 64
cache_alignment : 64
address sizes : 36 bits physical, 48 bits virtual
power management:

# cat /proc/modules
ctr 13193 1 - Live 0xffffffffa0484000
ccm 17856 1 - Live 0xffffffffa047e000
snd_hda_codec_hdmi 46898 1 - Live 0xffffffffa0471000
snd_hda_codec_idt 59236 1 - Live 0xffffffffa072b000
parport_pc 36962 0 - Live 0xffffffffa0720000
ppdev 17711 0 - Live 0xffffffffa0747000
x86_pkg_temp_thermal 14269 0 - Live 0xffffffffa0685000
intel_powerclamp 19031 0 - Live 0xffffffffa064e000
coretemp 17728 0 - Live 0xffffffffa0673000
kvm_intel 144426 0 - Live 0xffffffffa0b64000
kvm 468147 1 kvm_intel, Live 0xffffffffa06ac000
crct10dif_pclmul 14250 0 - Live 0xffffffffa067a000
crc32_pclmul 13160 0 - Live 0xffffffffa0666000
ghash_clmulni_intel 13259 0 - Live 0xffffffffa05ea000
aesni_intel 55720 2 - Live 0xffffffffa069d000
aes_x86_64 17131 1 aesni_intel, Live 0xffffffffa0648000
lrw 13323 1 aesni_intel, Live 0xffffffffa0661000
gf128mul 14951 1 lrw, Live 0xffffffffa065c000
glue_helper 14095 1 aesni_intel, Live 0xffffffffa0657000
ablk_helper 13597 1 aesni_intel, Live 0xffffffffa0680000
cryptd 20530 3 ghash_clmulni_intel,aesni_intel,ablk_helper, Live=20
0xffffffffa0696000
dell_laptop 18315 0 - Live 0xffffffffa0690000
dcdbas 15017 1 dell_laptop, Live 0xffffffffa057e000
microcode 23788 0 - Live 0xffffffffa0637000
psmouse 108513 0 - Live 0xffffffffa061b000
serio_raw 13462 0 - Live 0xffffffffa01bc000
rfcomm 74748 12 - Live 0xffffffffa0607000
bnep 19884 2 - Live 0xffffffffa05e4000
snd_hda_intel 57222 3 - Live 0xffffffffa05f8000
snd_hda_codec 199156 3=20
snd_hda_codec_hdmi,snd_hda_codec_idt,snd_hda_intel, Live 0xffffffffa05b=
2000
snd_hwdep 13613 1 snd_hda_codec, Live 0xffffffffa0386000
snd_pcm 107140 3 snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec, Live=20
0xffffffffa0596000
dm_multipath 27401 0 - Live 0xffffffffa058e000
binfmt_misc 17508 1 - Live 0xffffffffa03a1000
arc4 12573 2 - Live 0xffffffffa0589000
scsi_dh 14873 1 dm_multipath, Live 0xffffffffa02f3000
snd_page_alloc 18798 2 snd_hda_intel,snd_pcm, Live 0xffffffffa0583000
iwldvm 243417 0 - Live 0xffffffffa053a000
snd_seq_midi 13324 0 - Live 0xffffffffa02a1000
snd_seq_midi_event 14899 1 snd_seq_midi, Live 0xffffffffa029c000
mac80211 654078 1 iwldvm, Live 0xffffffffa0499000
i915 816826 3 - Live 0xffffffffa03a8000
uvcvideo 82247 0 - Live 0xffffffffa038b000
snd_rawmidi 30465 1 snd_seq_midi, Live 0xffffffffa037d000
snd_seq 66061 2 snd_seq_midi,snd_seq_midi_event, Live 0xffffffffa036b00=
0
videobuf2_vmalloc 13216 1 uvcvideo, Live 0xffffffffa01a9000
videobuf2_memops 13362 1 videobuf2_vmalloc, Live 0xffffffffa022e000
snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live=20
0xffffffffa01a4000
videobuf2_core 40972 1 uvcvideo, Live 0xffffffffa02e7000
snd_timer 30038 2 snd_pcm,snd_seq, Live 0xffffffffa019b000
rts5139 318332 0 - Live 0xffffffffa031c000 (C)
videodev 139761 2 uvcvideo,videobuf2_core, Live 0xffffffffa02f8000
iwlwifi 179720 1 iwldvm, Live 0xffffffffa02ba000
ext2 73828 1 - Live 0xffffffffa02a6000
snd 73850 17=20
snd_hda_codec_hdmi,snd_hda_codec_idt,snd_hda_intel,snd_hda_codec,snd_hw=
dep,snd_pcm,snd_seq_midi,snd_rawmidi,snd_seq,snd_seq_device,snd_timer,=20
Live 0xffffffffa021a000
btusb 28326 0 - Live 0xffffffffa0193000
drm_kms_helper 53224 1 i915, Live 0xffffffffa01ae000
bluetooth 411140 22 rfcomm,bnep,btusb, Live 0xffffffffa0236000
drm 308397 4 i915,drm_kms_helper, Live 0xffffffffa01cd000
dell_wmi 12681 0 - Live 0xffffffffa01c4000
cfg80211 509407 3 iwldvm,mac80211,iwlwifi, Live 0xffffffffa0115000
sparse_keymap 13890 1 dell_wmi, Live 0xffffffffa0110000
soundcore 12680 1 snd, Live 0xffffffffa00fe000
mei_me 18578 0 - Live 0xffffffffa0106000
mei 82671 1 mei_me, Live 0xffffffffa00e8000
i2c_algo_bit 13564 1 i915, Live 0xffffffffa00e3000
lpc_ich 21163 0 - Live 0xffffffffa00dc000
wmi 19363 1 dell_wmi, Live 0xffffffffa00cd000
lp 17799 0 - Live 0xffffffffa00a9000
mac_hid 13253 0 - Live 0xffffffffa00d3000
video 19859 1 i915, Live 0xffffffffa0038000
parport 42481 3 parport_pc,ppdev,lp, Live 0xffffffffa00bd000
raid10 48667 0 - Live 0xffffffffa00b0000
raid456 87551 0 - Live 0xffffffffa0092000
async_raid6_recov 12984 1 raid456, Live 0xffffffffa008d000
async_memcpy 12689 1 raid456, Live 0xffffffffa0088000
async_pq 13456 1 raid456, Live 0xffffffffa0080000
async_xor 13233 2 raid456,async_pq, Live 0xffffffffa003e000
async_tx 13509 5=20
raid456,async_raid6_recov,async_memcpy,async_pq,async_xor, Live=20
0xffffffffa007b000
xor 21411 1 async_xor, Live 0xffffffffa0074000
raid6_pq 97812 2 async_raid6_recov,async_pq, Live 0xffffffffa0057000
raid1 35921 0 - Live 0xffffffffa004d000
raid0 17969 0 - Live 0xffffffffa0044000
multipath 13145 0 - Live 0xffffffffa0028000
linear 12894 0 - Live 0xffffffffa0010000
ahci 30063 2 - Live 0xffffffffa002f000
r8169 73299 0 - Live 0xffffffffa0015000
libahci 32277 1 ahci, Live 0xffffffffa0007000
mii 13981 1 r8169, Live 0xffffffffa0000000


# cat /proc/ioports
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
0454-0457 : pnp 00:05
0458-047f : pnp 00:03
0460-047f : iTCO_wdt
0500-057f : pnp 00:03
0680-069f : pnp 00:03
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
1000-1003 : pnp 00:03
1004-1013 : pnp 00:03
164e-164f : pnp 00:03
2000-2fff : PCI Bus 0000:03
2000-20ff : 0000:03:00.0
2000-20ff : r8169
3000-3fff : PCI Bus 0000:01
3000-307f : 0000:01:00.0
4000-403f : 0000:00:02.0
4060-407f : 0000:00:1f.2
4060-407f : ahci
4090-4097 : 0000:00:1f.2
4090-4097 : ahci
4098-409f : 0000:00:1f.2
4098-409f : ahci
40b8-40bb : 0000:00:1f.2
40b8-40bb : ahci
40bc-40bf : 0000:00:1f.2
40bc-40bf : ahci
efa0-efbf : 0000:00:1f.3
ffff-ffff : pnp 00:03

# cat /proc/iomem
00000000-00000fff : reserved
00001000-0009d7ff : System RAM
0009d800-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000cedff : Video ROM
000e0000-000fffff : reserved
000f0000-000fffff : System ROM
00100000-1fffffff : System RAM
01000000-01770d1d : Kernel code
01770d1e-01d1bf3f : Kernel data
01e78000-01fdcfff : Kernel bss
20000000-201fffff : reserved
20200000-40003fff : System RAM
40004000-40004fff : reserved
40005000-a7268fff : System RAM
a7269000-a746afff : reserved
a746b000-b7f54fff : System RAM
b7f55000-baeeefff : reserved
baeef000-baf9efff : ACPI Non-volatile Storage
baf9f000-baffefff : ACPI Tables
bafff000-baffffff : System RAM
bb000000-bf9fffff : reserved
bba00000-bf9fffff : Graphics Stolen Memory
bfa00000-feafffff : PCI Bus 0000:00
c0000000-d1ffffff : PCI Bus 0000:01
c0000000-cfffffff : 0000:01:00.0
d0000000-d1ffffff : 0000:01:00.0
e0000000-efffffff : 0000:00:02.0
e0000000-e07e8fff : BOOTFB
f0000000-f0ffffff : PCI Bus 0000:01
f0000000-f0ffffff : 0000:01:00.0
f1000000-f13fffff : 0000:00:02.0
f1400000-f14fffff : PCI Bus 0000:03
f1400000-f1403fff : 0000:03:00.0
f1400000-f1403fff : r8169
f1404000-f1404fff : 0000:03:00.0
f1404000-f1404fff : r8169
f1500000-f15fffff : PCI Bus 0000:02
f1500000-f1501fff : 0000:02:00.0
f1500000-f1501fff : iwlwifi
f1600000-f160ffff : 0000:00:14.0
f1600000-f160ffff : xhci_hcd
f1610000-f1613fff : 0000:00:1b.0
f1610000-f1613fff : ICH HD audio
f1614000-f16140ff : 0000:00:1f.3
f1615000-f161500f : 0000:00:16.0
f1615000-f161500f : mei_me
f1618000-f16187ff : 0000:00:1f.2
f1618000-f16187ff : ahci
f1619000-f16193ff : 0000:00:1d.0
f1619000-f16193ff : ehci_hcd
f161a000-f161a3ff : 0000:00:1a.0
f161a000-f161a3ff : ehci_hcd
f8000000-fbffffff : PCI MMCONFIG 0000 [bus 00-3f]
f8000000-fbffffff : reserved
f8000000-fbffffff : pnp 00:08
fec00000-fec00fff : reserved
fec00000-fec003ff : IOAPIC 0
fed00000-fed003ff : HPET 0
fed08000-fed08fff : reserved
fed10000-fed19fff : reserved
fed10000-fed17fff : pnp 00:08
fed18000-fed18fff : pnp 00:08
fed19000-fed19fff : pnp 00:08
fed1c000-fed1ffff : reserved
fed1c000-fed1ffff : pnp 00:08
fed1f410-fed1f414 : iTCO_wdt
fed20000-fed3ffff : pnp 00:08
fed45000-fed8ffff : pnp 00:08
fed90000-fed93fff : pnp 00:08
fee00000-fee00fff : Local APIC
fee00000-fee00fff : reserved
ff980000-ffffffff : reserved
100000000-23f5fffff : System RAM
23f600000-23fffffff : RAM buffer

# lspci -vvv
00:00.0 Host bridge: Intel Corporation 3rd Gen Core processor DRAM=20
Controller (rev 09)
Subsystem: Dell Device 0578
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=20
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t-=20
<MAbort+ >SERR- <PERR- INTx-
Latency: 0
Capabilities: [e0] Vendor Specific Information: Len=3D0c <?>

00:01.0 PCI bridge: Intel Corporation Xeon E3-1200 v2/3rd Gen Core=20
processor PCI Express Root Port (rev 09) (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=20
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t-=20
<MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
I/O behind bridge: 00003000-00003fff
Memory behind bridge: f0000000-f0ffffff
Prefetchable memory behind bridge: 00000000c0000000-00000000d1ffffff
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t-=20
<MAbort- <SERR- <PERR-
BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: [88] Subsystem: Dell Device 0578
Capabilities: [80] Power Management version 3
=46lags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
Capabilities: [90] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
Address: feeff00c Data: 4171
Capabilities: [a0] Express (v2) Root Port (Slot+), MSI 00
DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
ExtTag- RBE+ FLReset-
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 256 bytes, MaxReadReq 128 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
LnkCap: Port #2, Speed 8GT/s, Width x16, ASPM L0s L1, Latency L0 <256ns=
,=20
L1 <8us
ClockPM- Surprise- LLActRep- BwNot+
LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 8GT/s, Width x16, TrErr- Train- SlotClk+ DLActive- BWMgmt=
+=20
ABWMgmt+
SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
Slot #1, PowerLimit 75.000W; Interlock- NoCompl+
SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
Changed: MRL- PresDet+ LinkState-
RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
RootCap: CRSVisible-
RootSta: PME ReqID 0000, PMEStatus- PMEPending-
DevCap2: Completion Timeout: Not Supported, TimeoutDis- ARIFwd-
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-,=20
Selectable De-emphasis: -3.5dB
Transmit Margin: Normal Operating Range, EnterModifiedCompliance-=20
ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+,=20
EqualizationPhase1+
EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest-
Capabilities: [100 v1] Virtual Channel
Caps: LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
Arb: Fixed- WRR32- WRR64- WRR128-
Ctrl: ArbSelect=3DFixed
Status: InProgress-
VC0: Caps: PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
Arb: Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
Ctrl: Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3Dff
Status: NegoPending- InProgress-
Capabilities: [140 v1] Root Complex Link
Desc: PortNumber=3D02 ComponentID=3D01 EltType=3DConfig
Link0: Desc: TargetPort=3D00 TargetComponent=3D01 AssocRCRB-=20
LinkType=3DMemMapped LinkValid+
Addr: 00000000fed19000
Capabilities: [d94 v1] #19
Kernel driver in use: pcieport

00:02.0 VGA compatible controller: Intel Corporation 3rd Gen Core=20
processor Graphics Controller (rev 09) (prog-if 00 [VGA controller])
Subsystem: Dell Device 0578
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=20
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t-=20
<MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 46
Region 0: Memory at f1000000 (64-bit, non-prefetchable) [size=3D4M]
Region 2: Memory at e0000000 (64-bit, prefetchable) [size=3D256M]
Region 4: I/O ports at 4000 [size=3D64]
Expansion ROM at <unassigned> [disabled]
Capabilities: [90] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
Address: feeff00c Data: 41e1
Capabilities: [d0] Power Management version 2
=46lags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D=
3cold-)
Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
Capabilities: [a4] PCI Advanced Features
AFCap: TP+ FLR+
AFCtrl: FLR-
AFStatus: TP-
Kernel driver in use: i915

00:14.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset=20
=46amily USB xHCI Host Controller (rev 04) (prog-if 30 [XHCI])
Subsystem: Dell Device 0578
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=20
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-=20
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 41
Region 0: Memory at f1600000 (64-bit, non-prefetchable) [size=3D64K]
Capabilities: [70] Power Management version 2
=46lags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA PME(D0-,D1-,D2-,D3hot+=
,D3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
Capabilities: [80] MSI: Enable+ Count=3D1/8 Maskable- 64bit+
Address: 00000000feeff00c Data: 4181
Kernel driver in use: xhci_hcd

00:16.0 Communication controller: Intel Corporation 7 Series/C210 Serie=
s=20
Chipset Family MEI Controller #1 (rev 04)
Subsystem: Dell Device 0578
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=20
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t-=20
<MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 44
Region 0: Memory at f1615000 (64-bit, non-prefetchable) [size=3D16]
Capabilities: [50] Power Management version 3
=46lags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
Capabilities: [8c] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
Address: 00000000feeff00c Data: 41c1
Kernel driver in use: mei_me

00:1a.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset=20
=46amily USB Enhanced Host Controller #2 (rev 04) (prog-if 20 [EHCI])
Subsystem: Dell Device 0578
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=20
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-=20
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 16
Region 0: Memory at f161a000 (32-bit, non-prefetchable) [size=3D1K]
Capabilities: [50] Power Management version 2
=46lags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA PME(D0+,D1-,D2-,D3hot+=
,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
Capabilities: [58] Debug port: BAR=3D1 offset=3D00a0
Capabilities: [98] PCI Advanced Features
AFCap: TP+ FLR+
AFCtrl: FLR-
AFStatus: TP-
Kernel driver in use: ehci-pci

00:1b.0 Audio device: Intel Corporation 7 Series/C210 Series Chipset=20
=46amily High Definition Audio Controller (rev 04)
Subsystem: Dell Device 0578
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=20
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t-=20
<MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 47
Region 0: Memory at f1610000 (64-bit, non-prefetchable) [size=3D16K]
Capabilities: [50] Power Management version 2
=46lags: PMEClk- DSI- D1- D2- AuxCurrent=3D55mA PME(D0+,D1-,D2-,D3hot+,=
D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
Capabilities: [60] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
Address: 00000000feeff00c Data: 4142
Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 0=
0
DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
ExtTag- RBE- FLReset+
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
LnkCap: Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0=20
<64ns, L1 <1us
ClockPM- Surprise- LLActRep- BwNot-
LnkCtl: ASPM Disabled; Disabled- Retrain- CommClk-
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive-=20
BWMgmt- ABWMgmt-
Capabilities: [100 v1] Virtual Channel
Caps: LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
Arb: Fixed- WRR32- WRR64- WRR128-
Ctrl: ArbSelect=3DFixed
Status: InProgress-
VC0: Caps: PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
Arb: Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
Ctrl: Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3D01
Status: NegoPending- InProgress-
VC1: Caps: PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
Arb: Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
Ctrl: Enable+ ID=3D1 ArbSelect=3DFixed TC/VC=3D22
Status: NegoPending- InProgress-
Capabilities: [130 v1] Root Complex Link
Desc: PortNumber=3D0f ComponentID=3D00 EltType=3DConfig
Link0: Desc: TargetPort=3D00 TargetComponent=3D00 AssocRCRB-=20
LinkType=3DMemMapped LinkValid+
Addr: 00000000fed1c000
Kernel driver in use: snd_hda_intel

00:1c.0 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset=20
=46amily PCI Express Root Port 1 (rev c4) (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=20
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t-=20
<MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Bus: primary=3D00, secondary=3D02, subordinate=3D02, sec-latency=3D0
I/O behind bridge: 0000f000-00000fff
Memory behind bridge: f1500000-f15fffff
Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t-=20
<MAbort+ <SERR- <PERR-
BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
ExtTag- RBE+ FLReset-
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
LnkCap: Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns,=
=20
L1 <16us
ClockPM- Surprise- LLActRep+ BwNot-
LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+=20
BWMgmt+ ABWMgmt-
SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
Slot #0, PowerLimit 10.000W; Interlock- NoCompl+
SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
Changed: MRL- PresDet- LinkState+
RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
RootCap: CRSVisible-
RootSta: PME ReqID 0000, PMEStatus- PMEPending-
DevCap2: Completion Timeout: Range BC, TimeoutDis+ ARIFwd-
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-,=20
Selectable De-emphasis: -6dB
Transmit Margin: Normal Operating Range, EnterModifiedCompliance-=20
ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,=20
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [80] MSI: Enable- Count=3D1/1 Maskable- 64bit-
Address: 00000000 Data: 0000
Capabilities: [90] Subsystem: Dell Device 0578
Capabilities: [a0] Power Management version 2
=46lags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
Kernel driver in use: pcieport

00:1c.4 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset=20
=46amily PCI Express Root Port 5 (rev c4) (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=20
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t-=20
<MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Bus: primary=3D00, secondary=3D03, subordinate=3D03, sec-latency=3D0
I/O behind bridge: 00002000-00002fff
Memory behind bridge: fff00000-000fffff
Prefetchable memory behind bridge: 00000000f1400000-00000000f14fffff
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t-=20
<MAbort- <SERR- <PERR-
BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
ExtTag- RBE+ FLReset-
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
LnkCap: Port #5, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns,=
=20
L1 <16us
ClockPM- Surprise- LLActRep+ BwNot-
LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+=20
BWMgmt+ ABWMgmt-
SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
Slot #4, PowerLimit 10.000W; Interlock- NoCompl+
SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
Changed: MRL- PresDet- LinkState+
RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
RootCap: CRSVisible-
RootSta: PME ReqID 0000, PMEStatus- PMEPending-
DevCap2: Completion Timeout: Range BC, TimeoutDis+ ARIFwd-
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-,=20
Selectable De-emphasis: -6dB
Transmit Margin: Normal Operating Range, EnterModifiedCompliance-=20
ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,=20
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [80] MSI: Enable- Count=3D1/1 Maskable- 64bit-
Address: 00000000 Data: 0000
Capabilities: [90] Subsystem: Dell Device 0578
Capabilities: [a0] Power Management version 2
=46lags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
Kernel driver in use: pcieport

00:1d.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset=20
=46amily USB Enhanced Host Controller #1 (rev 04) (prog-if 20 [EHCI])
Subsystem: Dell Device 0578
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=20
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-=20
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 23
Region 0: Memory at f1619000 (32-bit, non-prefetchable) [size=3D1K]
Capabilities: [50] Power Management version 2
=46lags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA PME(D0+,D1-,D2-,D3hot+=
,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
Capabilities: [58] Debug port: BAR=3D1 offset=3D00a0
Capabilities: [98] PCI Advanced Features
AFCap: TP+ FLR+
AFCtrl: FLR-
AFStatus: TP-
Kernel driver in use: ehci-pci

00:1f.0 ISA bridge: Intel Corporation HM77 Express Chipset LPC=20
Controller (rev 04)
Subsystem: Dell Device 0578
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=20
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-=20
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Capabilities: [e0] Vendor Specific Information: Len=3D0c <?>
Kernel driver in use: lpc_ich

00:1f.2 SATA controller: Intel Corporation 7 Series Chipset Family=20
6-port SATA Controller [AHCI mode] (rev 04) (prog-if 01 [AHCI 1.0])
Subsystem: Dell Device 0578
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=20
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-=20
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin B routed to IRQ 43
Region 0: I/O ports at 4098 [size=3D8]
Region 1: I/O ports at 40bc [size=3D4]
Region 2: I/O ports at 4090 [size=3D8]
Region 3: I/O ports at 40b8 [size=3D4]
Region 4: I/O ports at 4060 [size=3D32]
Region 5: Memory at f1618000 (32-bit, non-prefetchable) [size=3D2K]
Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
Address: fee3000c Data: 41b1
Capabilities: [70] Power Management version 3
=46lags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot+,D=
3cold-)
Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=3D00000004
Capabilities: [b0] PCI Advanced Features
AFCap: TP+ FLR+
AFCtrl: FLR-
AFStatus: TP-
Kernel driver in use: ahci

00:1f.3 SMBus: Intel Corporation 7 Series/C210 Series Chipset Family=20
SMBus Controller (rev 04)
Subsystem: Dell Device 0578
Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-=20
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-=20
<TAbort- <MAbort- >SERR- <PERR- INTx-
Interrupt: pin C routed to IRQ 10
Region 0: Memory at f1614000 (64-bit, non-prefetchable) [size=3D256]
Region 4: I/O ports at efa0 [size=3D32]

01:00.0 VGA compatible controller: NVIDIA Corporation GK107M [GeForce G=
T=20
650M] (rev a1) (prog-if 00 [VGA controller])
Subsystem: Dell Device 0578
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=20
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t-=20
<MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 11
Region 0: Memory at f0000000 (32-bit, non-prefetchable) [size=3D16M]
Region 1: Memory at c0000000 (64-bit, prefetchable) [size=3D256M]
Region 3: Memory at d0000000 (64-bit, prefetchable) [size=3D32M]
Region 5: I/O ports at 3000 [disabled] [size=3D128]
Expansion ROM at <ignored> [disabled]
Capabilities: [60] Power Management version 3
=46lags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D=
3cold-)
Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
Capabilities: [68] MSI: Enable- Count=3D1/1 Maskable- 64bit+
Address: 0000000000000000 Data: 0000
Capabilities: [78] Express (v2) Endpoint, MSI 00
DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s unlimited, L1 <6=
4us
ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
MaxPayload 256 bytes, MaxReadReq 512 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
LnkCap: Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Latency L0 <512ns=
,=20
L1 <4us
ClockPM+ Surprise- LLActRep- BwNot-
LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 8GT/s, Width x16, TrErr- Train- SlotClk+ DLActive- BWMgmt=
-=20
ABWMgmt-
DevCap2: Completion Timeout: Range AB, TimeoutDis+
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-,=20
Selectable De-emphasis: -6dB
Transmit Margin: Normal Operating Range, EnterModifiedCompliance-=20
ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+,=20
EqualizationPhase1+
EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest+
Capabilities: [b4] Vendor Specific Information: Len=3D14 <?>
Capabilities: [100 v1] Virtual Channel
Caps: LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
Arb: Fixed- WRR32- WRR64- WRR128-
Ctrl: ArbSelect=3DFixed
Status: InProgress-
VC0: Caps: PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
Arb: Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
Ctrl: Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3Dff
Status: NegoPending- InProgress-
Capabilities: [128 v1] Power Budgeting <?>
Capabilities: [600 v1] Vendor Specific Information: ID=3D0001 Rev=3D1=20
Len=3D024 <?>
Capabilities: [900 v1] #19

02:00.0 Network controller: Intel Corporation Centrino Wireless-N 2230=20
(rev c4)
Subsystem: Intel Corporation Centrino Wireless-N 2230 BGN
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=20
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t-=20
<MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 45
Region 0: Memory at f1500000 (64-bit, non-prefetchable) [size=3D8K]
Capabilities: [c8] Power Management version 3
=46lags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
Capabilities: [d0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
Address: 00000000fee1000c Data: 41d1
Capabilities: [e0] Express (v1) Endpoint, MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 unlim=
ited
ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <4us,=
=20
L1 <32us
ClockPM+ Surprise- LLActRep- BwNot-
LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-=20
BWMgmt- ABWMgmt-
Capabilities: [100 v1] Advanced Error Reporting
UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP=
-=20
ECRC- UnsupReq- ACSViol-
UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP=
-=20
ECRC- UnsupReq- ACSViol-
UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+=20
MalfTLP+ ECRC- UnsupReq- ACSViol-
CESta: RxErr- BadTLP+ BadDLLP- Rollover- Timeout- NonFatalErr+
CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
Capabilities: [140 v1] Device Serial Number 60-36-dd-ff-ff-bc-5e-30
Kernel driver in use: iwlwifi

03:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.=20
RTL8101E/RTL8102E PCI Express Fast Ethernet controller (rev 05)
Subsystem: Dell Device 0578
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=20
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t-=20
<MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 42
Region 0: I/O ports at 2000 [size=3D256]
Region 2: Memory at f1404000 (64-bit, prefetchable) [size=3D4K]
Region 4: Memory at f1400000 (64-bit, prefetchable) [size=3D16K]
Capabilities: [40] Power Management version 3
=46lags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0+,D1+,D2+,D3hot+=
,D3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
Capabilities: [50] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
Address: 00000000feeff00c Data: 4191
Capabilities: [70] Express (v2) Endpoint, MSI 01
DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 512 bytes
DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0=20
unlimited, L1 <64us
ClockPM+ Surprise- LLActRep- BwNot-
LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-=20
BWMgmt- ABWMgmt-
DevCap2: Completion Timeout: Not Supported, TimeoutDis+
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-,=20
Selectable De-emphasis: -6dB
Transmit Margin: Normal Operating Range, EnterModifiedCompliance-=20
ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,=20
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [b0] MSI-X: Enable- Count=3D4 Masked-
Vector table: BAR=3D4 offset=3D00000000
PBA: BAR=3D4 offset=3D00000800
Capabilities: [d0] Vital Product Data
Unknown small resource type 00, will not decode more.
Capabilities: [100 v1] Advanced Error Reporting
UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP=
-=20
ECRC- UnsupReq- ACSViol-
UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP=
-=20
ECRC- UnsupReq- ACSViol-
UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+=20
MalfTLP+ ECRC- UnsupReq- ACSViol-
CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
Capabilities: [140 v1] Virtual Channel
Caps: LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
Arb: Fixed- WRR32- WRR64- WRR128-
Ctrl: ArbSelect=3DFixed
Status: InProgress-
VC0: Caps: PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
Arb: Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
Ctrl: Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3Dff
Status: NegoPending- InProgress-
Capabilities: [160 v1] Device Serial Number 7c-03-00-00-36-4c-e0-00
Kernel driver in use: r8169

# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
Vendor: ATA Model: Samsung SSD 840 Rev: DXM0
Type: Direct-Access ANSI SCSI revision: 05
Host: scsi1 Channel: 00 Id: 00 Lun: 00
Vendor: ATA Model: WDC WD10JPVT-75A Rev: 01.0
Type: Direct-Access ANSI SCSI revision: 05
Host: scsi3 Channel: 00 Id: 00 Lun: 00
Vendor: PLDS Model: DVDRWBD DS-6E2SH Rev: CD13
Type: CD-ROM ANSI SCSI revision: 05
Host: scsi6 Channel: 00 Id: 00 Lun: 00
Vendor: Generic- Model: xD/SD/M.S. Rev: 1.00
Type: Direct-Access ANSI SCSI revision: 02


# xinput --list
=E2=8E=A1 Virtual core pointer id=3D2 [master pointer (3)]
=E2=8E=9C =E2=86=B3 Virtual core XTEST pointer id=3D4 [slave pointer (2=
)]
=E2=8E=9C =E2=86=B3 PS/2 Generic Mouse id=3D13 [slave pointer (2)]
=E2=8E=A3 Virtual core keyboard id=3D3 [master keyboard (2)]
=E2=86=B3 Virtual core XTEST keyboard id=3D5 [slave keyboard (3)]
=E2=86=B3 Power Button id=3D6 [slave keyboard (3)]
=E2=86=B3 Video Bus id=3D7 [slave keyboard (3)]
=E2=86=B3 Video Bus id=3D8 [slave keyboard (3)]
=E2=86=B3 Power Button id=3D9 [slave keyboard (3)]
=E2=86=B3 Sleep Button id=3D10 [slave keyboard (3)]
=E2=86=B3 Laptop_Integrated_Webcam_HD id=3D11 [slave keyboard (3)]
=E2=86=B3 AT Translated Set 2 keyboard id=3D12 [slave keyboard (3)]
=E2=86=B3 Dell WMI hotkeys id=3D14 [slave keyboard (3)]




--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
