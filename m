From: Wouter van der Graaf <wouter@dynora.nl>
Subject: PROBLEM: XPS 12-9Q33 touchpad not recognized, problem with i2c_hid
 module
Date: Mon, 07 Oct 2013 10:46:10 +0200
Message-ID: <525274D2.8080707@dynora.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail6.webfaction.com ([74.55.86.74]:49130 "EHLO
	smtp.webfaction.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754175Ab3JGIqN (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Oct 2013 04:46:13 -0400
Received: from [192.168.1.19] (095-097-108-050.static.chello.nl [95.97.108.50])
	by smtp.webfaction.com (Postfix) with ESMTP id B76FF222564A
	for <linux-input@vger.kernel.org>; Mon,  7 Oct 2013 08:46:11 +0000 (UTC)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Dear Maintainers,

[1.] One line summary of the problem:

Dell XPS 12-9Q33 touchpad is not recognized, works when i2c_hid (needed=
=20
for touchscreen) is blacklisted


[2.] Full description of the problem/report:

Problem exists in kernels 3.10, 3.11 and 3.12rc3 (latest mainline kerne=
l=20
release as of this writing).

The Dell XPS 12, 2013 Haswell version, comes with both multitouch=20
touchscreen and touchpad, of which only the touchscreen functions=20
correctly. The touchpad is not correctly detected and acts like a=20
generic pointing device without any touchpad (multitouch, scrolling,=20
etc.) features.

Below I've included environment and device information as well as Xorg=20
log, xinput list and dmesg output.

The device named "DLL05E3:01 06CB:2734" is the touchpad.

When i2c_hid module is blacklisted, the touchpad *does* work and is=20
detected by the psmouse module as a Synaptics touchpad. However, the=20
touchscreen needs the i2c_hid module.

With i2c_hid module enabled, both touchpad and touchscreen are detected=
=20
by i2c_hid, but maybe this causes a conflict and the psmouse module is=20
not able to detect the touchpad anymore.


[3.] Keywords (i.e., modules, networking, kernel):


[4.] Kernel version (from /proc/version):

Linux version 3.12.0-031200rc3-generic (apw@gomeisa) (gcc version 4.6.3=
=20
(Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201309291835 SMP Sun Sep 29 22:37:02=20
UTC 2013


[5.] Output of Oops.. message (if applicable) with symbolic information
      resolved (see Documentation/oops-tracing.txt)

N/A


[6.] A small shell script or example program which triggers the
      problem (if possible)

N/A


[7.] Environment

Description:    Ubuntu Saucy Salamander (development branch)
Release:    13.10


[7.1.] Software (add the output of the ver_linux script here)

Linux wouter-xps12 3.12.0-031200rc3-generic #201309291835 SMP Sun Sep 2=
9=20
22:37:02 UTC 2013 x86_64 x86_64 x86_64 GNU/Linux

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
Modules Loaded         dm_crypt x86_pkg_temp_thermal coretemp kvm_intel=
=20
kvm crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel=20
aes_x86_64 lrw gf128mul glue_helper ablk_helper cryptd joydev pn544_mei=
=20
mei_phy pn544 hci snd_hda_codec_realtek nfc snd_hda_codec_hdmi=20
hid_sensor_magn_3d hid_sensor_accel_3d hid_sensor_gyro_3d=20
hid_sensor_trigger industrialio_triggered_buffer kfifo_buf industrialio=
=20
arc4 snd_hda_intel hid_sensor_iio_common snd_hda_codec snd_hwdep=20
hid_multitouch snd_pcm hid_generic dell_wmi sparse_keymap snd_page_allo=
c=20
snd_seq_midi snd_seq_midi_event snd_rawmidi dell_laptop parport_pc=20
dcdbas ppdev snd_seq mei_me uvcvideo hid_sensor_hub iwlmvm microcode=20
videobuf2_vmalloc videobuf2_memops mac80211 videobuf2_core mei videodev=
=20
usb_storage rfcomm bnep psmouse iwlwifi serio_raw snd_seq_device btusb=20
bluetooth cfg80211 snd_timer lpc_ich snd soundcore i2c_hid=20
i2c_designware_platform i2c_designware_core mac_hid intel_smartconnect=20
tpm_tis nls_iso8859_1 lp parport usbhid hid i915 i2c_algo_bit=20
drm_kms_helper ahci drm libahci wmi video


[7.2.] Processor information (from /proc/cpuinfo):

processor    : 0
vendor_id    : GenuineIntel
cpu family    : 6
model        : 69
model name    : Intel(R) Core(TM) i7-4500U CPU @ 1.80GHz
stepping    : 1
microcode    : 0x14
cpu MHz        : 1800.000
cache size    : 4096 KB
physical id    : 0
siblings    : 4
core id        : 0
cpu cores    : 2
apicid        : 0
initial apicid    : 0
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca=
=20
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall=20
nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl=20
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor=20
ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 movbe=20
popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm ida ara=
t=20
epb xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid=20
fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid
bogomips    : 4788.86
clflush size    : 64
cache_alignment    : 64
address sizes    : 39 bits physical, 48 bits virtual
power management:

processor    : 1
vendor_id    : GenuineIntel
cpu family    : 6
model        : 69
model name    : Intel(R) Core(TM) i7-4500U CPU @ 1.80GHz
stepping    : 1
microcode    : 0x14
cpu MHz        : 1800.000
cache size    : 4096 KB
physical id    : 0
siblings    : 4
core id        : 1
cpu cores    : 2
apicid        : 2
initial apicid    : 2
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca=
=20
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall=20
nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl=20
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor=20
ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 movbe=20
popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm ida ara=
t=20
epb xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid=20
fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid
bogomips    : 4788.86
clflush size    : 64
cache_alignment    : 64
address sizes    : 39 bits physical, 48 bits virtual
power management:

processor    : 2
vendor_id    : GenuineIntel
cpu family    : 6
model        : 69
model name    : Intel(R) Core(TM) i7-4500U CPU @ 1.80GHz
stepping    : 1
microcode    : 0x14
cpu MHz        : 1800.000
cache size    : 4096 KB
physical id    : 0
siblings    : 4
core id        : 0
cpu cores    : 2
apicid        : 1
initial apicid    : 1
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca=
=20
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall=20
nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl=20
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor=20
ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 movbe=20
popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm ida ara=
t=20
epb xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid=20
fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid
bogomips    : 4788.86
clflush size    : 64
cache_alignment    : 64
address sizes    : 39 bits physical, 48 bits virtual
power management:

processor    : 3
vendor_id    : GenuineIntel
cpu family    : 6
model        : 69
model name    : Intel(R) Core(TM) i7-4500U CPU @ 1.80GHz
stepping    : 1
microcode    : 0x14
cpu MHz        : 1800.000
cache size    : 4096 KB
physical id    : 0
siblings    : 4
core id        : 1
cpu cores    : 2
apicid        : 3
initial apicid    : 3
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca=
=20
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall=20
nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl=20
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor=20
ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 movbe=20
popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm ida ara=
t=20
epb xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid=20
fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid
bogomips    : 4788.86
clflush size    : 64
cache_alignment    : 64
address sizes    : 39 bits physical, 48 bits virtual
power management:


[7.3.] Module information (from /proc/modules):

dm_crypt 23012 1 - Live 0x0000000000000000
x86_pkg_temp_thermal 14269 0 - Live 0x0000000000000000
coretemp 17728 0 - Live 0x0000000000000000
kvm_intel 144049 0 - Live 0x0000000000000000
kvm 457676 1 kvm_intel, Live 0x0000000000000000
crct10dif_pclmul 14250 0 - Live 0x0000000000000000
crc32_pclmul 13160 0 - Live 0x0000000000000000
ghash_clmulni_intel 13259 0 - Live 0x0000000000000000
aesni_intel 55720 268 - Live 0x0000000000000000
aes_x86_64 17131 1 aesni_intel, Live 0x0000000000000000
lrw 13294 1 aesni_intel, Live 0x0000000000000000
gf128mul 14951 1 lrw, Live 0x0000000000000000
glue_helper 14095 1 aesni_intel, Live 0x0000000000000000
ablk_helper 13597 1 aesni_intel, Live 0x0000000000000000
cryptd 20501 136 ghash_clmulni_intel,aesni_intel,ablk_helper, Live=20
0x0000000000000000
joydev 17575 0 - Live 0x0000000000000000
pn544_mei 12787 0 - Live 0x0000000000000000
mei_phy 13929 1 pn544_mei, Live 0x0000000000000000
pn544 17995 1 pn544_mei, Live 0x0000000000000000
hci 44774 2 mei_phy,pn544, Live 0x0000000000000000
snd_hda_codec_realtek 56695 1 - Live 0x0000000000000000
nfc 99413 2 pn544,hci, Live 0x0000000000000000
snd_hda_codec_hdmi 41684 1 - Live 0x0000000000000000
hid_sensor_magn_3d 13266 0 - Live 0x0000000000000000
hid_sensor_accel_3d 13279 0 - Live 0x0000000000000000
hid_sensor_gyro_3d 13266 0 - Live 0x0000000000000000
hid_sensor_trigger 12916 3=20
hid_sensor_magn_3d,hid_sensor_accel_3d,hid_sensor_gyro_3d, Live=20
0x0000000000000000
industrialio_triggered_buffer 12882 3=20
hid_sensor_magn_3d,hid_sensor_accel_3d,hid_sensor_gyro_3d, Live=20
0x0000000000000000
kfifo_buf 13294 1 industrialio_triggered_buffer, Live 0x000000000000000=
0
industrialio 54016 6=20
hid_sensor_magn_3d,hid_sensor_accel_3d,hid_sensor_gyro_3d,hid_sensor_tr=
igger,industrialio_triggered_buffer,kfifo_buf,=20
Live 0x0000000000000000
arc4 12573 2 - Live 0x0000000000000000
snd_hda_intel 57183 5 - Live 0x0000000000000000
hid_sensor_iio_common 13807 3=20
hid_sensor_magn_3d,hid_sensor_accel_3d,hid_sensor_gyro_3d, Live=20
0x0000000000000000
snd_hda_codec 194881 3=20
snd_hda_codec_realtek,snd_hda_codec_hdmi,snd_hda_intel, Live=20
0x0000000000000000
snd_hwdep 13613 1 snd_hda_codec, Live 0x0000000000000000
hid_multitouch 17645 0 - Live 0x0000000000000000
snd_pcm 107140 3 snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec, Live=20
0x0000000000000000
hid_generic 12548 0 - Live 0x0000000000000000
dell_wmi 12681 0 - Live 0x0000000000000000
sparse_keymap 13890 1 dell_wmi, Live 0x0000000000000000
snd_page_alloc 18798 2 snd_hda_intel,snd_pcm, Live 0x0000000000000000
snd_seq_midi 13324 0 - Live 0x0000000000000000
snd_seq_midi_event 14899 1 snd_seq_midi, Live 0x0000000000000000
snd_rawmidi 30465 1 snd_seq_midi, Live 0x0000000000000000
dell_laptop 17425 0 - Live 0x0000000000000000
parport_pc 32866 0 - Live 0x0000000000000000
dcdbas 14977 1 dell_laptop, Live 0x0000000000000000
ppdev 17711 0 - Live 0x0000000000000000
snd_seq 66061 2 snd_seq_midi,snd_seq_midi_event, Live 0x000000000000000=
0
mei_me 18418 0 - Live 0x0000000000000000
uvcvideo 82247 0 - Live 0x0000000000000000
hid_sensor_hub 19096 5=20
hid_sensor_magn_3d,hid_sensor_accel_3d,hid_sensor_gyro_3d,hid_sensor_tr=
igger,hid_sensor_iio_common,=20
Live 0x0000000000000000
iwlmvm 176559 0 - Live 0x0000000000000000
microcode 23650 0 - Live 0x0000000000000000
videobuf2_vmalloc 13216 1 uvcvideo, Live 0x0000000000000000
videobuf2_memops 13362 1 videobuf2_vmalloc, Live 0x0000000000000000
mac80211 634661 1 iwlmvm, Live 0x0000000000000000
videobuf2_core 40903 1 uvcvideo, Live 0x0000000000000000
mei 78609 3 pn544_mei,mei_phy,mei_me, Live 0x0000000000000000
videodev 139144 2 uvcvideo,videobuf2_core, Live 0x0000000000000000
usb_storage 66714 0 - Live 0x0000000000000000
rfcomm 74658 12 - Live 0x0000000000000000
bnep 23966 2 - Live 0x0000000000000000
psmouse 104113 0 - Live 0x0000000000000000
iwlwifi 171124 1 iwlmvm, Live 0x0000000000000000
serio_raw 13462 0 - Live 0x0000000000000000
snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live=20
0x0000000000000000
btusb 28326 0 - Live 0x0000000000000000
bluetooth 391597 22 rfcomm,bnep,btusb, Live 0x0000000000000000
cfg80211 504229 3 iwlmvm,mac80211,iwlwifi, Live 0x0000000000000000
snd_timer 30038 2 snd_pcm,snd_seq, Live 0x0000000000000000
lpc_ich 21163 0 - Live 0x0000000000000000
snd 73802 21=20
snd_hda_codec_realtek,snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec,sn=
d_hwdep,snd_pcm,snd_seq_midi,snd_rawmidi,snd_seq,snd_seq_device,snd_tim=
er,=20
Live 0x0000000000000000
soundcore 12680 1 snd, Live 0x0000000000000000
i2c_hid 19067 0 - Live 0x0000000000000000
i2c_designware_platform 13006 0 - Live 0x0000000000000000
i2c_designware_core 14990 1 i2c_designware_platform, Live 0x00000000000=
00000
mac_hid 13253 0 - Live 0x0000000000000000
intel_smartconnect 12619 0 - Live 0x0000000000000000
tpm_tis 19116 0 - Live 0x0000000000000000
nls_iso8859_1 12713 1 - Live 0x0000000000000000
lp 17799 0 - Live 0x0000000000000000
parport 42481 3 parport_pc,ppdev,lp, Live 0x0000000000000000
usbhid 53067 0 - Live 0x0000000000000000
hid 106254 5 hid_multitouch,hid_generic,hid_sensor_hub,i2c_hid,usbhid,=20
Live 0x0000000000000000
i915 733800 5 - Live 0x0000000000000000
i2c_algo_bit 13564 1 i915, Live 0x0000000000000000
drm_kms_helper 53165 1 i915, Live 0x0000000000000000
ahci 30063 3 - Live 0x0000000000000000
drm 303133 4 i915,drm_kms_helper, Live 0x0000000000000000
libahci 32088 1 ahci, Live 0x0000000000000000
wmi 19363 1 dell_wmi, Live 0x0000000000000000
video 19574 1 i915, Live 0x0000000000000000


[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iom=
em)

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
   04d0-04d1 : pnp 00:06
   0680-069f : pnp 00:03
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
   164e-164f : pnp 00:03
   1800-1803 : ACPI PM1a_EVT_BLK
   1804-1805 : ACPI PM1a_CNT_BLK
   1808-180b : ACPI PM_TMR
   1810-1815 : ACPI CPU throttle
   1830-1833 : iTCO_wdt
   1850-1850 : ACPI PM2_CNT_BLK
   1854-1857 : pnp 00:05
   1860-187f : iTCO_wdt
   1880-189f : ACPI GPE0_BLK
   1c00-1fff : INT33C7:00
     1c00-1fff : lp-gpio
   2000-2fff : PCI Bus 0000:04
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
   ffff-ffff : pnp 00:03
     ffff-ffff : pnp 00:03
       ffff-ffff : pnp 00:03

00000000-00000fff : reserved
00001000-00057fff : System RAM
00058000-00058fff : reserved
00059000-0009efff : System RAM
0009f000-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000ce9ff : Video ROM
000d0000-000d3fff : PCI Bus 0000:00
000d4000-000d7fff : PCI Bus 0000:00
000d8000-000dbfff : PCI Bus 0000:00
000dc000-000dffff : PCI Bus 0000:00
000f0000-000fffff : System ROM
00100000-c98d3fff : System RAM
   02000000-02762924 : Kernel code
   02762925-02d18c7f : Kernel data
   02e72000-02fe4fff : Kernel bss
c98d4000-c98dafff : ACPI Non-volatile Storage
c98db000-c9d18fff : System RAM
c9d19000-ca2b4fff : reserved
ca2b5000-da96efff : System RAM
da96f000-dae4bfff : reserved
dae4c000-dae65fff : ACPI Tables
dae66000-db764fff : ACPI Non-volatile Storage
db765000-dbffefff : reserved
dbfff000-dbffffff : System RAM
dd000000-df1fffff : reserved
   dd200000-df1fffff : Graphics Stolen Memory
df200000-feafffff : PCI Bus 0000:00
   df200000-df3fffff : PCI Bus 0000:04
   df400000-df5fffff : PCI Bus 0000:04
   e0000000-efffffff : 0000:00:02.0
   f7800000-f7bfffff : 0000:00:02.0
   f7c00000-f7cfffff : PCI Bus 0000:06
     f7c00000-f7c01fff : 0000:06:00.0
       f7c00000-f7c01fff : iwlwifi
   f7d00000-f7d0ffff : 0000:00:14.0
     f7d00000-f7d0ffff : xhci_hcd
   f7d10000-f7d13fff : 0000:00:1b.0
     f7d10000-f7d13fff : ICH HD audio
   f7d14000-f7d17fff : 0000:00:03.0
     f7d14000-f7d17fff : ICH HD audio
   f7d19000-f7d190ff : 0000:00:1f.3
   f7d1a000-f7d1a7ff : 0000:00:1f.2
     f7d1a000-f7d1a7ff : ahci
   f7d1b000-f7d1b3ff : 0000:00:1d.0
     f7d1b000-f7d1b3ff : ehci_hcd
   f7d1d000-f7d1d01f : 0000:00:16.0
     f7d1d000-f7d1d01f : mei_me
   f7fef000-f7feffff : pnp 00:0c
   f7ff0000-f7ff0fff : pnp 00:0c
   f8000000-fbffffff : PCI MMCONFIG 0000 [bus 00-3f]
     f8000000-fbffffff : reserved
       f8000000-fbffffff : pnp 00:0c
   fe102000-fe102fff : pnp 00:09
   fe104000-fe104fff : pnp 00:09
   fe105000-fe105fff : INT33C3:00
     fe105000-fe105fff : INT33C3:00
   fe106000-fe106fff : pnp 00:09
   fe108000-fe108fff : pnp 00:09
   fe10a000-fe10afff : pnp 00:09
   fe10c000-fe10cfff : pnp 00:09
   fe10e000-fe10efff : pnp 00:09
   fe111000-fe111007 : pnp 00:09
   fe111014-fe111fff : pnp 00:09
   fe112000-fe112fff : pnp 00:09
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
fed45000-fed8ffff : pnp 00:0c
fed90000-fed93fff : pnp 00:0c
fee00000-fee00fff : Local APIC
   fee00000-fee00fff : reserved
ff000000-ffffffff : reserved
   ff000000-ffffffff : pnp 00:0c
100000000-21fdfffff : System RAM
21fe00000-21fffffff : RAM buffer


[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corporation Haswell-ULT DRAM Controller (rev=
 09)
     Subsystem: Dell Device 05e3
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr=
-=20
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-=20
<TAbort- <MAbort+ >SERR- <PERR- INTx-
     Latency: 0
     Capabilities: [e0] Vendor Specific Information: Len=3D0c <?>

00:02.0 VGA compatible controller: Intel Corporation Haswell-ULT=20
Integrated Graphics Controller (rev 09) (prog-if 00 [VGA controller])
     Subsystem: Dell Device 05e3
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr=
-=20
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-=20
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 58
     Region 0: Memory at f7800000 (64-bit, non-prefetchable) [size=3D4M=
]
     Region 2: Memory at e0000000 (64-bit, prefetchable) [size=3D256M]
     Region 4: I/O ports at f000 [size=3D64]
     Expansion ROM at <unassigned> [disabled]
     Capabilities: [90] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
         Address: fee0f00c  Data: 41b1
     Capabilities: [d0] Power Management version 2
         Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA=20
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
     Capabilities: [a4] PCI Advanced Features
         AFCap: TP+ FLR+
         AFCtrl: FLR-
         AFStatus: TP-
     Kernel driver in use: i915

00:03.0 Audio device: Intel Corporation Device 0a0c (rev 09)
     Subsystem: Intel Corporation Device 2010
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr=
-=20
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-=20
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 61
     Region 0: Memory at f7d14000 (64-bit, non-prefetchable) [size=3D16=
K]
     Capabilities: [50] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA=20
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D3 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
     Capabilities: [60] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
         Address: fee0f00c  Data: 4142
     Capabilities: [70] Express (v1) Root Complex Integrated Endpoint,=20
MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s=20
unlimited, L1 unlimited
             ExtTag- RBE- FLReset+
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-=20
Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr-=20
TransPend-
         LnkCap:    Port #0, Speed unknown, Width x0, ASPM unknown,=20
Latency L0 <64ns, L1 <1us
             ClockPM- Surprise- LLActRep- BwNot-
         LnkCtl:    ASPM Disabled; Disabled- Retrain- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed unknown, Width x0, TrErr- Train- SlotClk-=20
DLActive- BWMgmt- ABWMgmt-
     Kernel driver in use: snd_hda_intel

00:14.0 USB controller: Intel Corporation Lynx Point-LP USB xHCI HC (re=
v=20
04) (prog-if 30 [XHCI])
     Subsystem: Dell Device 05e3
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr=
-=20
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-=
=20
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 56
     Region 0: Memory at f7d00000 (64-bit, non-prefetchable) [size=3D64=
K]
     Capabilities: [70] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA=20
PME(D0-,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
     Capabilities: [80] MSI: Enable+ Count=3D1/8 Maskable- 64bit+
         Address: 00000000fee0a00c  Data: 4181
     Kernel driver in use: xhci_hcd

00:16.0 Communication controller: Intel Corporation Lynx Point-LP HECI=20
#0 (rev 04)
     Subsystem: Dell Device 05e3
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr=
-=20
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-=20
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 60
     Region 0: Memory at f7d1d000 (64-bit, non-prefetchable) [size=3D32=
]
     Capabilities: [50] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA=20
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
     Capabilities: [8c] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
         Address: 00000000fee0f00c  Data: 4122
     Kernel driver in use: mei_me

00:1b.0 Audio device: Intel Corporation Lynx Point-LP HD Audio=20
Controller (rev 04)
     Subsystem: Dell Device 05e3
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr=
-=20
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-=20
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 62
     Region 0: Memory at f7d10000 (64-bit, non-prefetchable) [size=3D16=
K]
     Capabilities: [50] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D55mA=20
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
     Capabilities: [60] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
         Address: 00000000fee0f00c  Data: 4162
     Capabilities: [70] Express (v1) Root Complex Integrated Endpoint,=20
MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s=20
<64ns, L1 <1us
             ExtTag- RBE- FLReset+
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-=20
Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+=20
TransPend-
         LnkCap:    Port #0, Speed unknown, Width x0, ASPM unknown,=20
Latency L0 <64ns, L1 <1us
             ClockPM- Surprise- LLActRep- BwNot-
         LnkCtl:    ASPM Disabled; Disabled- Retrain- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed unknown, Width x0, TrErr- Train- SlotClk-=20
DLActive- BWMgmt- ABWMgmt-
     Capabilities: [100 v1] Virtual Channel
         Caps:    LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
         Arb:    Fixed- WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=3DFixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans=
-
             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3D01
             Status:    NegoPending- InProgress-
         VC1:    Caps:    PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans=
-
             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable- ID=3D2 ArbSelect=3DFixed TC/VC=3D04
             Status:    NegoPending- InProgress-
     Kernel driver in use: snd_hda_intel

00:1c.0 PCI bridge: Intel Corporation Lynx Point-LP PCI Express Root=20
Port 1 (rev e4) (prog-if 00 [Normal decode])
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr=
-=20
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-=20
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Bus: primary=3D00, secondary=3D04, subordinate=3D05, sec-latency=3D=
0
     I/O behind bridge: 00002000-00002fff
     Memory behind bridge: df200000-df3fffff
     Prefetchable memory behind bridge: 00000000df400000-00000000df5fff=
ff
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-=20
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s=20
<64ns, L1 <1us
             ExtTag- RBE+ FLReset-
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-=20
Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+=20
TransPend-
         LnkCap:    Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Latenc=
y=20
L0 <1us, L1 <4us
             ClockPM- Surprise- LLActRep+ BwNot+
         LnkCtl:    ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain=
-=20
CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+=20
DLActive- BWMgmt- ABWMgmt-
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+=20
Surprise+
             Slot #0, PowerLimit 0.000W; Interlock- NoCompl+
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-=20
HPIrq- LinkChg-
             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock=
-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet-=20
Interlock-
             Changed: MRL- PresDet- LinkState-
         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-=20
CRSVisible-
         RootCap: CRSVisible-
         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
         DevCap2: Completion Timeout: Range ABC, TimeoutDis+ ARIFwd-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
         LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-,=
=20
Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range,=20
EnterModifiedCompliance- ComplianceSOS-
              Compliance De-emphasis: -6dB
         LnkSta2: Current De-emphasis Level: -3.5dB,=20
EqualizationComplete-, EqualizationPhase1-
              EqualizationPhase2-, EqualizationPhase3-,=20
LinkEqualizationRequest-
     Capabilities: [80] MSI: Enable- Count=3D1/1 Maskable- 64bit-
         Address: 00000000  Data: 0000
     Capabilities: [90] Subsystem: Dell Device 05e3
     Capabilities: [a0] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA=20
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
     Kernel driver in use: pcieport

00:1c.2 PCI bridge: Intel Corporation Lynx Point-LP PCI Express Root=20
Port 3 (rev e4) (prog-if 00 [Normal decode])
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr=
-=20
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-=20
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Bus: primary=3D00, secondary=3D06, subordinate=3D06, sec-latency=3D=
0
     I/O behind bridge: 0000f000-00000fff
     Memory behind bridge: f7c00000-f7cfffff
     Prefetchable memory behind bridge: 00000000fff00000-00000000000fff=
ff
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-=20
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s=20
<64ns, L1 <1us
             ExtTag- RBE+ FLReset-
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-=20
Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+=20
TransPend-
         LnkCap:    Port #3, Speed 5GT/s, Width x1, ASPM L0s L1, Latenc=
y=20
L0 <512ns, L1 <16us
             ClockPM- Surprise- LLActRep+ BwNot+
         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- Retrain- Comm=
Clk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+=20
DLActive+ BWMgmt+ ABWMgmt-
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug-=20
Surprise-
             Slot #2, PowerLimit 10.000W; Interlock- NoCompl+
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-=20
HPIrq- LinkChg-
             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock=
-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+=20
Interlock-
             Changed: MRL- PresDet- LinkState-
         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-=20
CRSVisible-
         RootCap: CRSVisible-
         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
         DevCap2: Completion Timeout: Range ABC, TimeoutDis+ ARIFwd-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
         LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-,=
=20
Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range,=20
EnterModifiedCompliance- ComplianceSOS-
              Compliance De-emphasis: -6dB
         LnkSta2: Current De-emphasis Level: -3.5dB,=20
EqualizationComplete-, EqualizationPhase1-
              EqualizationPhase2-, EqualizationPhase3-,=20
LinkEqualizationRequest-
     Capabilities: [80] MSI: Enable- Count=3D1/1 Maskable- 64bit-
         Address: 00000000  Data: 0000
     Capabilities: [90] Subsystem: Dell Device 05e3
     Capabilities: [a0] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA=20
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
     Capabilities: [100 v0] #00
     Capabilities: [200 v1] #1e
     Kernel driver in use: pcieport

00:1d.0 USB controller: Intel Corporation Lynx Point-LP USB EHCI #1 (re=
v=20
04) (prog-if 20 [EHCI])
     Subsystem: Dell Device 05e3
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr=
-=20
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-=
=20
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 23
     Region 0: Memory at f7d1b000 (32-bit, non-prefetchable) [size=3D1K=
]
     Capabilities: [50] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA=20
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
     Capabilities: [58] Debug port: BAR=3D1 offset=3D00a0
     Capabilities: [98] PCI Advanced Features
         AFCap: TP+ FLR+
         AFCtrl: FLR-
         AFStatus: TP-
     Kernel driver in use: ehci-pci

00:1f.0 ISA bridge: Intel Corporation Lynx Point-LP LPC Controller (rev=
 04)
     Subsystem: Dell Device 05e3
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr=
-=20
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-=
=20
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Capabilities: [e0] Vendor Specific Information: Len=3D0c <?>
     Kernel driver in use: lpc_ich

00:1f.2 SATA controller: Intel Corporation Lynx Point-LP SATA Controlle=
r=20
1 [AHCI mode] (rev 04) (prog-if 01 [AHCI 1.0])
     Subsystem: Dell Device 05e3
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr=
-=20
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-=
=20
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin B routed to IRQ 57
     Region 0: I/O ports at f0b0 [size=3D8]
     Region 1: I/O ports at f0a0 [size=3D4]
     Region 2: I/O ports at f090 [size=3D8]
     Region 3: I/O ports at f080 [size=3D4]
     Region 4: I/O ports at f060 [size=3D32]
     Region 5: Memory at f7d1a000 (32-bit, non-prefetchable) [size=3D2K=
]
     Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
         Address: fee0a00c  Data: 41a1
     Capabilities: [70] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA=20
PME(D0-,D1-,D2-,D3hot+,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
     Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=3D00000004
     Kernel driver in use: ahci

00:1f.3 SMBus: Intel Corporation Lynx Point-LP SMBus Controller (rev 04=
)
     Subsystem: Dell Device 05e3
     Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr=
-=20
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-=
=20
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Interrupt: pin C routed to IRQ 3
     Region 0: Memory at f7d19000 (64-bit, non-prefetchable) [size=3D25=
6]
     Region 4: I/O ports at f040 [size=3D32]

06:00.0 Network controller: Intel Corporation Wireless 7260 (rev 6b)
     Subsystem: Intel Corporation Dual Band Wireless-AC 7260
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr=
-=20
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-=20
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 59
     Region 0: Memory at f7c00000 (64-bit, non-prefetchable) [size=3D8K=
]
     Capabilities: [c8] Power Management version 3
         Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA=20
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
     Capabilities: [d0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
         Address: 00000000fee0100c  Data: 41e1
     Capabilities: [40] Express (v2) Endpoint, MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s=20
<512ns, L1 unlimited
             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-=20
Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr+ NoSnoop+ FLReset-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+=20
TransPend-
         LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1,=20
Latency L0 <4us, L1 <32us
             ClockPM+ Surprise- LLActRep- BwNot-
         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- Retrain- Comm=
Clk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+=20
DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range B, TimeoutDis+
         DevCtl2: Completion Timeout: 16ms to 55ms, TimeoutDis-
         LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance-=20
SpeedDis-, Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range,=20
EnterModifiedCompliance- ComplianceSOS-
              Compliance De-emphasis: -6dB
         LnkSta2: Current De-emphasis Level: -3.5dB,=20
EqualizationComplete-, EqualizationPhase1-
              EqualizationPhase2-, EqualizationPhase3-,=20
LinkEqualizationRequest-
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-=20
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-=20
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-=20
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalE=
rr-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalE=
rr+
         AERCap:    First Error Pointer: 00, GenCap- CGenEn- ChkCap- Ch=
kEn-
     Capabilities: [140 v1] Device Serial Number 5c-51-4f-ff-ff-11-a5-9=
e
     Capabilities: [14c v1] Latency Tolerance Reporting
         Max snoop latency: 3145728ns
         Max no snoop latency: 3145728ns
     Capabilities: [154 v1] Vendor Specific Information: ID=3Dcafe Rev=3D=
1=20
Len=3D014 <?>
     Kernel driver in use: iwlwifi


[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: LITEONIT LMT-256 Rev: DM81
   Type:   Direct-Access                    ANSI  SCSI revision: 05


[7.7.] Other information that might be relevant to the problem (please=20
look in /proc and include all information that you think to be relevant=
):

Relevant info from /proc/bus/input/devices

I: Bus=3D0018 Vendor=3D06cb Product=3D2734 Version=3D0100
N: Name=3D"DLL05E3:01 06CB:2734"
P: Phys=3D
S: Sysfs=3D/devices/pci0000:00/INT33C3:00/i2c-8/8-002c/input/input7
U: Uniq=3D
H: Handlers=3Dmouse0 event7
B: PROP=3D0
B: EV=3D17
B: KEY=3D30000 0 0 0 0
B: REL=3D3
B: MSC=3D10

I: Bus=3D0018 Vendor=3D03eb Product=3D842f Version=3D0100
N: Name=3D"ATML1000:00 03EB:842F"
P: Phys=3D
S: Sysfs=3D/devices/pci0000:00/INT33C3:00/i2c-8/8-004b/input/input8
U: Uniq=3D
H: Handlers=3Dmouse1 event8
B: PROP=3D2
B: EV=3Db
B: KEY=3D400 0 0 0 0 0
B: ABS=3D260800000000003


/var/log/Xorg.0.log

[    11.411] X.Org X Server 1.14.2.901 (1.14.3 RC 1) Release Date:=20
2013-07-25
[    11.411] X Protocol Version 11, Revision 0
[    11.411] Build Operating System: Linux 3.2.0-37-generic x86_64 Ubun=
tu
[    11.411] Current Operating System: Linux wouter-xps12=20
3.12.0-031200rc3-generic #201309291835 SMP Sun Sep 29 22:37:02 UTC 2013=
=20
x86_64
[    11.411] Kernel command line:=20
BOOT_IMAGE=3D/boot/vmlinuz-3.12.0-031200rc3-generic=20
root=3DUUID=3D8e4879ce-4777-4c48-b6d7-5b3b4b116ad3 ro quiet splash vt.h=
andoff=3D7
[    11.411] Build Date: 26 September 2013  05:25:08PM
[    11.411] xorg-server 2:1.14.2.901-2ubuntu6 (For technical support=20
please see http://www.ubuntu.com/support)
[    11.411] Current version of pixman: 0.30.2
[    11.411]     Before reporting problems, check http://wiki.x.org to=20
make sure that you have the latest version.
[    11.411] Markers: (--) probed, (**) from config file, (=3D=3D) defa=
ult=20
setting, (++) from command line, (!!) notice, (II) informational, (WW)=20
warning, (EE) error, (NI) not implemented, (??) unknown.
[    11.411] (=3D=3D) Log file: "/var/log/Xorg.0.log", Time: Sun Oct  6=
=20
21:24:45 2013
[    11.412] (=3D=3D) Using config file: "/etc/X11/xorg.conf"
[    11.412] (=3D=3D) Using system config directory "/usr/share/X11/xor=
g.conf.d"
[    11.414] (=3D=3D) No Layout section.  Using the first Screen sectio=
n.
[    11.414] (=3D=3D) No screen section available. Using defaults.
[    11.414] (**) |-->Screen "Default Screen Section" (0)
[    11.414] (**) |   |-->Monitor "<default monitor>"
[    11.414] (=3D=3D) No monitor specified for screen "Default Screen S=
ection".
     Using a default monitor configuration.
[    11.414] (=3D=3D) Automatically adding devices
[    11.414] (=3D=3D) Automatically enabling devices
[    11.414] (=3D=3D) Automatically adding GPU devices
[    11.416] (WW) The directory "/usr/share/fonts/X11/cyrillic" does no=
t=20
exist.
[    11.416]     Entry deleted from font path.
[    11.416] (WW) The directory "/usr/share/fonts/X11/100dpi/" does not=
=20
exist.
[    11.416]     Entry deleted from font path.
[    11.416] (WW) The directory "/usr/share/fonts/X11/75dpi/" does not=20
exist.
[    11.416]     Entry deleted from font path.
[    11.416] (WW) The directory "/usr/share/fonts/X11/100dpi" does not=20
exist.
[    11.416]     Entry deleted from font path.
[    11.416] (WW) The directory "/usr/share/fonts/X11/75dpi" does not e=
xist.
[    11.416]     Entry deleted from font path.
[    11.416] (WW) The directory=20
"/var/lib/defoma/x-ttcidfont-conf.d/dirs/TrueType" does not exist.
[    11.416]     Entry deleted from font path.
[    11.416] (=3D=3D) FontPath set to:
     /usr/share/fonts/X11/misc,
     /usr/share/fonts/X11/Type1,
     built-ins
[    11.416] (=3D=3D) ModulePath set to=20
"/usr/lib/x86_64-linux-gnu/xorg/extra-modules,/usr/lib/xorg/extra-modul=
es,/usr/lib/xorg/modules"
[    11.416] (II) The server relies on udev to provide the list of inpu=
t=20
devices.
     If no devices become available, reconfigure udev or disable=20
AutoAddDevices.
[    11.416] (II) Loader magic: 0x7fe40c4a1d20
[    11.416] (II) Module ABI versions:
[    11.416]     X.Org ANSI C Emulation: 0.4
[    11.416]     X.Org Video Driver: 14.1
[    11.416]     X.Org XInput driver : 19.1
[    11.416]     X.Org Server Extension : 7.0
[    11.417] (II) xfree86: Adding drm device (/dev/dri/card0)
[    11.417] (--) PCI:*(0:0:2:0) 8086:0a16:1028:05e3 rev 9, Mem @=20
0xf7800000/4194304, 0xe0000000/268435456, I/O @ 0x0000f000/64
[    11.417] (II) Open ACPI successful (/var/run/acpid.socket)
[    11.418] Initializing built-in extension Generic Event Extension
[    11.418] Initializing built-in extension SHAPE
[    11.418] Initializing built-in extension MIT-SHM
[    11.418] Initializing built-in extension XInputExtension
[    11.418] Initializing built-in extension XTEST
[    11.418] Initializing built-in extension BIG-REQUESTS
[    11.418] Initializing built-in extension SYNC
[    11.418] Initializing built-in extension XKEYBOARD
[    11.418] Initializing built-in extension XC-MISC
[    11.418] Initializing built-in extension SECURITY
[    11.418] Initializing built-in extension XINERAMA
[    11.418] Initializing built-in extension XFIXES
[    11.418] Initializing built-in extension RENDER
[    11.418] Initializing built-in extension RANDR
[    11.418] Initializing built-in extension COMPOSITE
[    11.418] Initializing built-in extension DAMAGE
[    11.418] Initializing built-in extension MIT-SCREEN-SAVER
[    11.418] Initializing built-in extension DOUBLE-BUFFER
[    11.418] Initializing built-in extension RECORD
[    11.418] Initializing built-in extension DPMS
[    11.418] Initializing built-in extension X-Resource
[    11.418] Initializing built-in extension XVideo
[    11.418] Initializing built-in extension XVideo-MotionCompensation
[    11.418] Initializing built-in extension SELinux
[    11.418] Initializing built-in extension XFree86-VidModeExtension
[    11.418] Initializing built-in extension XFree86-DGA
[    11.418] Initializing built-in extension XFree86-DRI
[    11.418] Initializing built-in extension DRI2
[    11.418] (II) "glx" will be loaded by default.
[    11.418] (WW) "xmir" is not to be loaded by default. Skipping.
[    11.418] (II) LoadModule: "dri2"
[    11.418] (II) Module "dri2" already built-in
[    11.418] (II) LoadModule: "glamoregl"
[    11.419] (II) Loading /usr/lib/xorg/modules/libglamoregl.so
[    11.431] (II) Module glamoregl: vendor=3D"X.Org Foundation"
[    11.431]     compiled for 1.14.2.901, module version =3D 0.5.1
[    11.432]     ABI class: X.Org ANSI C Emulation, version 0.4
[    11.432] (II) LoadModule: "glx"
[    11.432] (II) Loading /usr/lib/xorg/modules/extensions/libglx.so
[    11.434] (II) Module glx: vendor=3D"X.Org Foundation"
[    11.434]     compiled for 1.14.2.901, module version =3D 1.0.0
[    11.434]     ABI class: X.Org Server Extension, version 7.0
[    11.434] (=3D=3D) AIGLX enabled
[    11.434] Loading extension GLX
[    11.434] (=3D=3D) Matched intel as autoconfigured driver 0
[    11.434] (=3D=3D) Matched intel as autoconfigured driver 1
[    11.434] (=3D=3D) Matched vesa as autoconfigured driver 2
[    11.434] (=3D=3D) Matched modesetting as autoconfigured driver 3
[    11.434] (=3D=3D) Matched fbdev as autoconfigured driver 4
[    11.434] (=3D=3D) Assigned the driver to the xf86ConfigLayout
[    11.434] (II) LoadModule: "intel"
[    11.434] (II) Loading /usr/lib/xorg/modules/drivers/intel_drv.so
[    11.437] (II) Module intel: vendor=3D"X.Org Foundation"
[    11.437]     compiled for 1.14.2.901, module version =3D 2.21.14
[    11.437]     Module class: X.Org Video Driver
[    11.437]     ABI class: X.Org Video Driver, version 14.1
[    11.437] (II) LoadModule: "vesa"
[    11.437] (II) Loading /usr/lib/xorg/modules/drivers/vesa_drv.so
[    11.437] (II) Module vesa: vendor=3D"X.Org Foundation"
[    11.437]     compiled for 1.14.1, module version =3D 2.3.2
[    11.438]     Module class: X.Org Video Driver
[    11.438]     ABI class: X.Org Video Driver, version 14.1
[    11.438] (II) LoadModule: "modesetting"
[    11.438] (II) Loading /usr/lib/xorg/modules/drivers/modesetting_drv=
=2Eso
[    11.438] (II) Module modesetting: vendor=3D"X.Org Foundation"
[    11.438]     compiled for 1.14.1, module version =3D 0.8.0
[    11.438]     Module class: X.Org Video Driver
[    11.438]     ABI class: X.Org Video Driver, version 14.1
[    11.438] (II) LoadModule: "fbdev"
[    11.438] (II) Loading /usr/lib/xorg/modules/drivers/fbdev_drv.so
[    11.439] (II) Module fbdev: vendor=3D"X.Org Foundation"
[    11.439]     compiled for 1.14.1, module version =3D 0.4.3
[    11.439]     Module class: X.Org Video Driver
[    11.439]     ABI class: X.Org Video Driver, version 14.1
[    11.439] (II) intel: Driver for Intel(R) Integrated Graphics Chipse=
ts:
     i810, i810-dc100, i810e, i815, i830M, 845G, 854, 852GM/855GM, 865G=
,
     915G, E7221 (i915), 915GM, 945G, 945GM, 945GME, Pineview GM,
     Pineview G, 965G, G35, 965Q, 946GZ, 965GM, 965GME/GLE, G33, Q35, Q=
33,
     GM45, 4 Series, G45/G43, Q45/Q43, G41, B43, HD Graphics,
     HD Graphics 2000, HD Graphics 3000, HD Graphics 2500,
     HD Graphics 4000, HD Graphics P4000, HD Graphics 4600,
     HD Graphics 5000, HD Graphics P4600/P4700, Iris(TM) Graphics 5100,
     HD Graphics 4400, HD Graphics 4200, Iris(TM) Pro Graphics 5200
[    11.439] (II) VESA: driver for VESA chipsets: vesa
[    11.439] (II) modesetting: Driver for Modesetting Kernel Drivers: k=
ms
[    11.439] (II) FBDEV: driver for framebuffer: fbdev
[    11.439] (++) using VT number 7

[    11.440] (II) intel(0): SNA compiled: xserver-xorg-video-intel=20
2:2.21.14-4ubuntu4 (Christopher James Halse Rogers <raof@ubuntu.com>)
[    11.441] (WW) Falling back to old probe method for vesa
[    11.441] (WW) Falling back to old probe method for modesetting
[    11.441] (WW) Falling back to old probe method for fbdev
[    11.441] (II) Loading sub module "fbdevhw"
[    11.441] (II) LoadModule: "fbdevhw"
[    11.442] (II) Loading /usr/lib/xorg/modules/libfbdevhw.so
[    11.442] (II) Module fbdevhw: vendor=3D"X.Org Foundation"
[    11.442]     compiled for 1.14.2.901, module version =3D 0.0.2
[    11.442]     ABI class: X.Org Video Driver, version 14.1
[    11.443] (II) intel(0): Creating default Display subsection in=20
Screen section
     "Default Screen Section" for depth/fbbpp 24/32
[    11.443] (=3D=3D) intel(0): Depth 24, (--) framebuffer bpp 32
[    11.443] (=3D=3D) intel(0): RGB weight 888
[    11.443] (=3D=3D) intel(0): Default visual is TrueColor
[    11.443] (--) intel(0): Integrated Graphics Chipset: Intel(R) HD=20
Graphics 4400
[    11.443] (--) intel(0): CPU: x86-64, sse2, sse3, ssse3, sse4.1,=20
sse4.2, avx, avx2
[    11.443] (**) intel(0): Framebuffer tiled
[    11.443] (**) intel(0): Pixmaps tiled
[    11.443] (**) intel(0): "Tear free" disabled
[    11.443] (**) intel(0): Forcing per-crtc-pixmaps? no
[    11.443] (II) intel(0): Output eDP1 has no monitor section
[    11.443] (--) intel(0): found backlight control interface=20
acpi_video0 (type 'firmware')
[    11.443] (II) intel(0): Output DP1 has no monitor section
[    11.443] (II) intel(0): Output HDMI1 has no monitor section
[    11.443] (--) intel(0): Output eDP1 using initial mode 1920x1080 on=
=20
pipe 0
[    11.443] (=3D=3D) intel(0): DPI set to (96, 96)
[    11.443] (II) Loading sub module "dri2"
[    11.443] (II) LoadModule: "dri2"
[    11.443] (II) Module "dri2" already built-in
[    11.443] (II) UnloadModule: "vesa"
[    11.443] (II) Unloading vesa
[    11.443] (II) UnloadModule: "modesetting"
[    11.443] (II) Unloading modesetting
[    11.443] (II) UnloadModule: "fbdev"
[    11.443] (II) Unloading fbdev
[    11.443] (II) UnloadSubModule: "fbdevhw"
[    11.443] (II) Unloading fbdevhw
[    11.443] (=3D=3D) Depth 24 pixmap format is 32 bpp
[    11.446] (II) intel(0): SNA initialized with Haswell (gen7.5, gt2)=20
backend
[    11.446] (=3D=3D) intel(0): Backing store disabled
[    11.446] (=3D=3D) intel(0): Silken mouse enabled
[    11.446] (II) intel(0): HW Cursor enabled
[    11.446] (II) intel(0): RandR 1.2 enabled, ignore the following=20
RandR disabled message.
[    11.447] (=3D=3D) intel(0): DPMS enabled
[    11.447] (II) intel(0): [DRI2] Setup complete
[    11.447] (II) intel(0): [DRI2]   DRI driver: i965
[    11.447] (II) intel(0): direct rendering: DRI2 Enabled
[    11.447] (=3D=3D) intel(0): hotplug detection: "enabled"
[    11.447] (--) RandR disabled
[    11.452] (II) SELinux: Disabled on system
[    11.467] (II) AIGLX: enabled GLX_MESA_copy_sub_buffer
[    11.467] (II) AIGLX: enabled GLX_INTEL_swap_event
[    11.467] (II) AIGLX: enabled GLX_ARB_create_context
[    11.467] (II) AIGLX: enabled GLX_ARB_create_context_profile
[    11.467] (II) AIGLX: enabled GLX_EXT_create_context_es2_profile
[    11.467] (II) AIGLX: enabled GLX_SGI_swap_control and=20
GLX_MESA_swap_control
[    11.467] (II) AIGLX: GLX_EXT_texture_from_pixmap backed by buffer=20
objects
[    11.467] (II) AIGLX: Loaded and initialized i965
[    11.467] (II) GLX: Initialized DRI2 GL provider for screen 0
[    11.470] (II) intel(0): switch to mode 1920x1080@59.9 on pipe 0=20
using eDP1, position (0, 0), rotation normal
[    11.488] (II) intel(0): Setting screen physical size to 508 x 285
[    11.497] (II) XKB: reuse xkmfile=20
/var/lib/xkb/server-B20D7FC79C7F597315E3E501AEF10E0D866E8E92.xkm
[    11.499] (II) config/udev: Adding input device Power Button=20
(/dev/input/event2)
[    11.499] (**) Power Button: Applying InputClass "evdev keyboard=20
catchall"
[    11.499] (II) LoadModule: "evdev"
[    11.499] (II) Loading /usr/lib/xorg/modules/input/evdev_drv.so
[    11.500] (II) Module evdev: vendor=3D"X.Org Foundation"
[    11.500]     compiled for 1.14.1, module version =3D 2.7.3
[    11.500]     Module class: X.Org XInput Driver
[    11.500]     ABI class: X.Org XInput driver, version 19.1
[    11.500] (II) Using input driver 'evdev' for 'Power Button'
[    11.500] (**) Power Button: always reports core events
[    11.500] (**) evdev: Power Button: Device: "/dev/input/event2"
[    11.500] (--) evdev: Power Button: Vendor 0 Product 0x1
[    11.500] (--) evdev: Power Button: Found keys
[    11.500] (II) evdev: Power Button: Configuring as keyboard
[    11.500] (**) Option "config_info"=20
"udev:/sys/devices/LNXSYSTM:00/LNXPWRBN:00/input/input2/event2"
[    11.500] (II) XINPUT: Adding extended input device "Power Button"=20
(type: KEYBOARD, id 6)
[    11.500] (**) Option "xkb_rules" "evdev"
[    11.500] (**) Option "xkb_model" "pc105"
[    11.500] (**) Option "xkb_layout" "us"
[    11.500] (**) Option "xkb_variant" "intl"
[    11.502] (II) XKB: reuse xkmfile=20
/var/lib/xkb/server-A5431D4A34463C892C9E905E2E421B30A3CC30DD.xkm
[    11.503] (II) config/udev: Adding input device Video Bus=20
(/dev/input/event4)
[    11.503] (**) Video Bus: Applying InputClass "evdev keyboard catcha=
ll"
[    11.503] (II) Using input driver 'evdev' for 'Video Bus'
[    11.503] (**) Video Bus: always reports core events
[    11.503] (**) evdev: Video Bus: Device: "/dev/input/event4"
[    11.503] (--) evdev: Video Bus: Vendor 0 Product 0x6
[    11.503] (--) evdev: Video Bus: Found keys
[    11.503] (II) evdev: Video Bus: Configuring as keyboard
[    11.503] (**) Option "config_info"=20
"udev:/sys/devices/LNXSYSTM:00/device:00/PNP0A08:00/LNXVIDEO:00/input/i=
nput4/event4"
[    11.503] (II) XINPUT: Adding extended input device "Video Bus"=20
(type: KEYBOARD, id 7)
[    11.503] (**) Option "xkb_rules" "evdev"
[    11.503] (**) Option "xkb_model" "pc105"
[    11.503] (**) Option "xkb_layout" "us"
[    11.503] (**) Option "xkb_variant" "intl"
[    11.504] (II) config/udev: Adding input device Power Button=20
(/dev/input/event0)
[    11.504] (**) Power Button: Applying InputClass "evdev keyboard=20
catchall"
[    11.504] (II) Using input driver 'evdev' for 'Power Button'
[    11.504] (**) Power Button: always reports core events
[    11.504] (**) evdev: Power Button: Device: "/dev/input/event0"
[    11.504] (--) evdev: Power Button: Vendor 0 Product 0x1
[    11.504] (--) evdev: Power Button: Found keys
[    11.504] (II) evdev: Power Button: Configuring as keyboard
[    11.504] (**) Option "config_info"=20
"udev:/sys/devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input0/event0=
"
[    11.504] (II) XINPUT: Adding extended input device "Power Button"=20
(type: KEYBOARD, id 8)
[    11.504] (**) Option "xkb_rules" "evdev"
[    11.504] (**) Option "xkb_model" "pc105"
[    11.504] (**) Option "xkb_layout" "us"
[    11.504] (**) Option "xkb_variant" "intl"
[    11.504] (II) config/udev: Adding input device Lid Switch=20
(/dev/input/event1)
[    11.504] (II) No input driver specified, ignoring this device.
[    11.504] (II) This device may have been added with another device f=
ile.
[    11.504] (II) config/udev: Adding drm device (/dev/dri/card0)
[    11.504] (II) config/udev: Ignoring already known drm device=20
(/dev/dri/card0)
[    11.504] (II) config/udev: Adding input device HDA Intel MID=20
HDMI/DP,pcm=3D7 (/dev/input/event10)
[    11.504] (II) No input driver specified, ignoring this device.
[    11.504] (II) This device may have been added with another device f=
ile.
[    11.504] (II) config/udev: Adding input device HDA Intel MID=20
HDMI/DP,pcm=3D3 (/dev/input/event11)
[    11.504] (II) No input driver specified, ignoring this device.
[    11.504] (II) This device may have been added with another device f=
ile.
[    11.505] (II) config/udev: Adding input device HDA Intel MID=20
HDMI/DP,pcm=3D8 (/dev/input/event9)
[    11.505] (II) No input driver specified, ignoring this device.
[    11.505] (II) This device may have been added with another device f=
ile.
[    11.505] (II) config/udev: Adding input device Integrated Webcam=20
(/dev/input/event5)
[    11.505] (**) Integrated Webcam: Applying InputClass "evdev keyboar=
d=20
catchall"
[    11.505] (II) Using input driver 'evdev' for 'Integrated Webcam'
[    11.505] (**) Integrated Webcam: always reports core events
[    11.505] (**) evdev: Integrated Webcam: Device: "/dev/input/event5"
[    11.505] (--) evdev: Integrated Webcam: Vendor 0xbda Product 0x5602
[    11.505] (--) evdev: Integrated Webcam: Found keys
[    11.505] (II) evdev: Integrated Webcam: Configuring as keyboard
[    11.505] (**) Option "config_info"=20
"udev:/sys/devices/pci0000:00/0000:00:14.0/usb2/2-5/2-5:1.0/input/input=
5/event5"
[    11.505] (II) XINPUT: Adding extended input device "Integrated=20
Webcam" (type: KEYBOARD, id 9)
[    11.505] (**) Option "xkb_rules" "evdev"
[    11.505] (**) Option "xkb_model" "pc105"
[    11.505] (**) Option "xkb_layout" "us"
[    11.505] (**) Option "xkb_variant" "intl"
[    11.505] (II) config/udev: Adding input device HDA Intel PCH=20
Headphone (/dev/input/event12)
[    11.505] (II) No input driver specified, ignoring this device.
[    11.505] (II) This device may have been added with another device f=
ile.
[    11.505] (II) config/udev: Adding input device DLL05E3:01 06CB:2734=
=20
(/dev/input/event7)
[    11.505] (**) DLL05E3:01 06CB:2734: Applying InputClass "evdev=20
pointer catchall"
[    11.505] (II) Using input driver 'evdev' for 'DLL05E3:01 06CB:2734'
[    11.505] (**) DLL05E3:01 06CB:2734: always reports core events
[    11.505] (**) evdev: DLL05E3:01 06CB:2734: Device: "/dev/input/even=
t7"
[    11.512] (--) evdev: DLL05E3:01 06CB:2734: Vendor 0x6cb Product 0x2=
734
[    11.512] (--) evdev: DLL05E3:01 06CB:2734: Found 3 mouse buttons
[    11.512] (--) evdev: DLL05E3:01 06CB:2734: Found relative axes
[    11.512] (--) evdev: DLL05E3:01 06CB:2734: Found x and y relative a=
xes
[    11.512] (II) evdev: DLL05E3:01 06CB:2734: Configuring as mouse
[    11.512] (**) evdev: DLL05E3:01 06CB:2734: YAxisMapping: buttons 4 =
and 5
[    11.512] (**) evdev: DLL05E3:01 06CB:2734: EmulateWheelButton: 4,=20
EmulateWheelInertia: 10, EmulateWheelTimeout: 200
[    11.512] (**) Option "config_info"=20
"udev:/sys/devices/pci0000:00/INT33C3:00/i2c-8/8-002c/input/input7/even=
t7"
[    11.512] (II) XINPUT: Adding extended input device "DLL05E3:01=20
06CB:2734" (type: MOUSE, id 10)
[    11.512] (II) evdev: DLL05E3:01 06CB:2734: initialized for relative=
=20
axes.
[    11.513] (**) DLL05E3:01 06CB:2734: (accel) keeping acceleration=20
scheme 1
[    11.513] (**) DLL05E3:01 06CB:2734: (accel) acceleration profile 0
[    11.513] (**) DLL05E3:01 06CB:2734: (accel) acceleration factor: 2.=
000
[    11.513] (**) DLL05E3:01 06CB:2734: (accel) acceleration threshold:=
 4
[    11.513] (II) config/udev: Adding input device DLL05E3:01 06CB:2734=
=20
(/dev/input/mouse0)
[    11.513] (II) No input driver specified, ignoring this device.
[    11.513] (II) This device may have been added with another device f=
ile.
[    11.513] (II) config/udev: Adding input device ATML1000:00 03EB:842=
=46=20
(/dev/input/event8)
[    11.513] (**) ATML1000:00 03EB:842F: Applying InputClass "evdev=20
touchscreen catchall"
[    11.513] (II) Using input driver 'evdev' for 'ATML1000:00 03EB:842F=
'
[    11.513] (**) ATML1000:00 03EB:842F: always reports core events
[    11.513] (**) evdev: ATML1000:00 03EB:842F: Device: "/dev/input/eve=
nt8"
[    11.514] (--) evdev: ATML1000:00 03EB:842F: Vendor 0x3eb Product 0x=
842f
[    11.514] (--) evdev: ATML1000:00 03EB:842F: Found absolute axes
[    11.514] (--) evdev: ATML1000:00 03EB:842F: Found absolute=20
multitouch axes
[    11.514] (--) evdev: ATML1000:00 03EB:842F: Found x and y absolute =
axes
[    11.514] (--) evdev: ATML1000:00 03EB:842F: Found absolute touchscr=
een
[    11.514] (II) evdev: ATML1000:00 03EB:842F: Configuring as touchscr=
een
[    11.514] (**) evdev: ATML1000:00 03EB:842F: YAxisMapping: buttons 4=
=20
and 5
[    11.514] (**) evdev: ATML1000:00 03EB:842F: EmulateWheelButton: 4,=20
EmulateWheelInertia: 10, EmulateWheelTimeout: 200
[    11.514] (**) Option "config_info"=20
"udev:/sys/devices/pci0000:00/INT33C3:00/i2c-8/8-004b/input/input8/even=
t8"
[    11.514] (II) XINPUT: Adding extended input device "ATML1000:00=20
03EB:842F" (type: TOUCHSCREEN, id 11)
[    11.514] (II) evdev: ATML1000:00 03EB:842F: initialized for absolut=
e=20
axes.
[    11.514] (**) ATML1000:00 03EB:842F: (accel) keeping acceleration=20
scheme 1
[    11.514] (**) ATML1000:00 03EB:842F: (accel) acceleration profile 0
[    11.514] (**) ATML1000:00 03EB:842F: (accel) acceleration factor: 2=
=2E000
[    11.514] (**) ATML1000:00 03EB:842F: (accel) acceleration threshold=
: 4
[    11.515] (II) config/udev: Adding input device ATML1000:00 03EB:842=
=46=20
(/dev/input/mouse1)
[    11.515] (II) No input driver specified, ignoring this device.
[    11.515] (II) This device may have been added with another device f=
ile.
[    11.515] (II) config/udev: Adding input device AT Translated Set 2=20
keyboard (/dev/input/event3)
[    11.515] (**) AT Translated Set 2 keyboard: Applying InputClass=20
"evdev keyboard catchall"
[    11.515] (II) Using input driver 'evdev' for 'AT Translated Set 2=20
keyboard'
[    11.515] (**) AT Translated Set 2 keyboard: always reports core eve=
nts
[    11.515] (**) evdev: AT Translated Set 2 keyboard: Device:=20
"/dev/input/event3"
[    11.515] (--) evdev: AT Translated Set 2 keyboard: Vendor 0x1=20
Product 0x1
[    11.515] (--) evdev: AT Translated Set 2 keyboard: Found keys
[    11.515] (II) evdev: AT Translated Set 2 keyboard: Configuring as=20
keyboard
[    11.515] (**) Option "config_info"=20
"udev:/sys/devices/platform/i8042/serio0/input/input3/event3"
[    11.515] (II) XINPUT: Adding extended input device "AT Translated=20
Set 2 keyboard" (type: KEYBOARD, id 12)
[    11.515] (**) Option "xkb_rules" "evdev"
[    11.515] (**) Option "xkb_model" "pc105"
[    11.515] (**) Option "xkb_layout" "us"
[    11.515] (**) Option "xkb_variant" "intl"
[    11.516] (II) config/udev: Adding input device Dell WMI hotkeys=20
(/dev/input/event6)
[    11.516] (**) Dell WMI hotkeys: Applying InputClass "evdev keyboard=
=20
catchall"
[    11.516] (II) Using input driver 'evdev' for 'Dell WMI hotkeys'
[    11.516] (**) Dell WMI hotkeys: always reports core events
[    11.516] (**) evdev: Dell WMI hotkeys: Device: "/dev/input/event6"
[    11.516] (--) evdev: Dell WMI hotkeys: Vendor 0 Product 0
[    11.516] (--) evdev: Dell WMI hotkeys: Found keys
[    11.516] (II) evdev: Dell WMI hotkeys: Configuring as keyboard
[    11.516] (**) Option "config_info"=20
"udev:/sys/devices/virtual/input/input6/event6"
[    11.516] (II) XINPUT: Adding extended input device "Dell WMI=20
hotkeys" (type: KEYBOARD, id 13)
[    11.516] (**) Option "xkb_rules" "evdev"
[    11.516] (**) Option "xkb_model" "pc105"
[    11.516] (**) Option "xkb_layout" "us"
[    11.516] (**) Option "xkb_variant" "intl"
[    11.793] (II) intel(0): EDID vendor "LGD", prod id 1021
[    11.793] (II) intel(0): Printing DDC gathered Modelines:
[    11.793] (II) intel(0): Modeline "1920x1080"x0.0  138.50  1920 1968=
=20
2000 2080  1080 1083 1088 1111 +hsync -vsync (66.6 kHz eP)
[    17.641] (II) XKB: reuse xkmfile=20
/var/lib/xkb/server-8CD2763E246F7107805A70A0C7DBAC594B3523D9.xkm
[    18.165] (II) XKB: reuse xkmfile=20
/var/lib/xkb/server-657D1E36EA86B8E7C9DA9E3D0CE267494DF7D894.xkm
[    18.168] (II) XKB: reuse xkmfile=20
/var/lib/xkb/server-657D1E36EA86B8E7C9DA9E3D0CE267494DF7D894.xkm
[    18.381] (II) XKB: reuse xkmfile=20
/var/lib/xkb/server-280C0FB5E1610579A23BBD0FBA8EB1281D867EEF.xkm
[    18.722] (II) XKB: reuse xkmfile=20
/var/lib/xkb/server-8CD2763E246F7107805A70A0C7DBAC594B3523D9.xkm
[    18.727] (II) XKB: reuse xkmfile=20
/var/lib/xkb/server-657D1E36EA86B8E7C9DA9E3D0CE267494DF7D894.xkm


xinput --list

=E2=8E=A1 Virtual core pointer                        id=3D2    [master=
 pointer  (3)]
=E2=8E=9C   =E2=86=B3 Virtual core XTEST pointer                  id=3D=
4    [slave=20
pointer  (2)]
=E2=8E=9C   =E2=86=B3 DLL05E3:01 06CB:2734                        id=3D=
10    [slave=20
pointer  (2)]
=E2=8E=9C   =E2=86=B3 ATML1000:00 03EB:842F                       id=3D=
11    [slave=20
pointer  (2)]
=E2=8E=A3 Virtual core keyboard                       id=3D3    [master=
 keyboard (2)]
     =E2=86=B3 Virtual core XTEST keyboard                 id=3D5    [s=
lave=20
keyboard (3)]
     =E2=86=B3 Power Button                                id=3D6    [s=
lave=20
keyboard (3)]
     =E2=86=B3 Video Bus                                   id=3D7    [s=
lave=20
keyboard (3)]
     =E2=86=B3 Power Button                                id=3D8    [s=
lave=20
keyboard (3)]
     =E2=86=B3 Integrated Webcam                           id=3D9    [s=
lave=20
keyboard (3)]
     =E2=86=B3 AT Translated Set 2 keyboard                id=3D12    [=
slave=20
keyboard (3)]
     =E2=86=B3 Dell WMI hotkeys                            id=3D13    [=
slave=20
keyboard (3)]


Relevant lines from dmesg

[    0.000000] Linux version 3.12.0-031200rc3-generic (apw@gomeisa) (gc=
c=20
version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201309291835 SMP Sun Se=
p=20
29 22:37:02 UTC 2013
[    0.000000] Command line:=20
BOOT_IMAGE=3D/boot/vmlinuz-3.12.0-031200rc3-generic=20
root=3DUUID=3D8e4879ce-4777-4c48-b6d7-5b3b4b116ad3 ro quiet splash vt.h=
andoff=3D7
[    0.000000] DMI: Dell Inc. XPS 12-9Q33/XPS 12-9Q33, BIOS A02 07/26/2=
013

[    1.145083] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M]=20
at 0x60,0x64 irq 1,12
[    1.169878] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.169882] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.170063] mousedev: PS/2 mouse device common for all mice

[    8.636649] ACPI Warning: 0x0000000000001828-0x000000000000182f=20
SystemIO conflicts with Region \PMIO 1 (20130725/utaddress-251)
[    8.636656] ACPI: If an ACPI driver is available for this device, yo=
u=20
should use it instead of the native driver
[    8.636660] ACPI Warning: 0x0000000000001c30-0x0000000000001c3f=20
SystemIO conflicts with Region \GPRL 1 (20130725/utaddress-251)
[    8.636664] ACPI Warning: 0x0000000000001c30-0x0000000000001c3f=20
SystemIO conflicts with Region \GPR_ 2 (20130725/utaddress-251)
[    8.636667] ACPI: If an ACPI driver is available for this device, yo=
u=20
should use it instead of the native driver
[    8.636669] ACPI Warning: 0x0000000000001c00-0x0000000000001c2f=20
SystemIO conflicts with Region \GPRL 1 (20130725/utaddress-251)
[    8.636672] ACPI Warning: 0x0000000000001c00-0x0000000000001c2f=20
SystemIO conflicts with Region \GPR_ 2 (20130725/utaddress-251)
[    8.636675] ACPI: If an ACPI driver is available for this device, yo=
u=20
should use it instead of the native driver
[    8.636677] lpc_ich: Resource conflict(s) found affecting gpio_ich

[    8.915773] i2c_hid 8-002c: failed to retrieve report from device.
[    8.918200] i2c_hid 8-002c: failed to retrieve report from device.
[    8.918897] i2c_hid 8-002c: failed to retrieve report from device.
[    8.924053] i2c_hid 8-002c: failed to retrieve report from device.
[    8.924118] input: DLL05E3:01 06CB:2734 as=20
/devices/pci0000:00/INT33C3:00/i2c-8/8-002c/input/input7
[    8.924297] hid-generic 0018:06CB:2734.0003: input,hidraw0: <UNKNOWN=
>=20
HID v1.00 Pointer [DLL05E3:01 06CB:2734] on
[    8.928162] i2c_hid 8-004b: error in i2c_hid_init_report size:20 /=20
ret_size:0
[    8.930894] i2c_hid 8-004b: error in i2c_hid_init_report size:20 /=20
ret_size:0
[    8.933598] i2c_hid 8-004b: error in i2c_hid_init_report size:13 /=20
ret_size:0

[    8.946226] input: ATML1000:00 03EB:842F as=20
/devices/pci0000:00/INT33C3:00/i2c-8/8-004b/input/input8
[    8.946815] hid-multitouch 0018:03EB:842F.0002: input,hidraw1:=20
<UNKNOWN> HID v1.00 Device [ATML1000:00 03EB:842F] on


ls /proc

1     1353  1671  1794  1995  23    304  485  56   922          iomem=20
    sched_debug
10    14    1673  18    2     2334  31   490  57   928          ioports=
=20
        schedstat
1005  140   1681  1807  20    24    33   493  579  93           irq    =
scsi
1016  141   1683  1821  2002  2456  330  495  629  acpi         kallsym=
s=20
       self
1027  1413  1686  1844  2005  2480  338  496  637  asound       kcore=20
    slabinfo
1044  142   1690  1851  2011  2486  34   498  69   buddyinfo key-users=20
    softirqs
1058  143   1692  1853  2021  2487  35   499  7    bus          kmsg=20
  stat
1094  15    17    19    2028  25    36   5    718  cgroups kpagecount=20
swaps
11    1522  1701  192   2029  2557  37   507  73   cmdline kpageflags  =
 sys
1142  1566  1720  1920  2034  2562  38   51   765  consoles=20
latency_stats  sysrq-trigger
1155  1568  1738  1922  2044  26    39   510  795  cpuinfo      loadavg=
=20
        sysvipc
1156  16    1748  1924  2048  2668  41   511  8    crypto       locks=20
    timer_list
1157  1617  1760  1925  2052  2683  42   513  800  devices      mdstat=20
      timer_stats
1158  1619  1761  1928  21    2716  43   514  822  diskstats    meminfo=
=20
        tty
1189  1633  1762  193   2186  2738  44   52   832  dma          misc=20
  uptime
12    1639  1763  1931  2194  2765  45   528  834  driver       modules=
=20
        version
1200  1645  1765  194   2201  2767  457  529  9    execdomains  mounts=20
      vmallocinfo
1214  1658  1781  1945  2207  28    46   53   900  fb           mtrr=20
  vmstat
1261  1661  1785  1948  2215  29    467  531  908  filesystems  net=20
zoneinfo
1292  1664  1786  1965  2232  3     47   54   919  fs           pagetyp=
einfo
13    1666  1787  1976  2284  30    483  55   92   interrupts   partiti=
ons


[X.] Other notes, patches, fixes, workarounds:

Downstream Launchpad bug report:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1218973

After blacklisting i2c_hid this is my xinput list:

=E2=8E=A1 Virtual core pointer                        id=3D2    [master=
 pointer  (3)]
=E2=8E=9C   =E2=86=B3 Virtual core XTEST pointer                  id=3D=
4    [slave=20
pointer  (2)]
=E2=8E=9C   =E2=86=B3 SynPS/2 Synaptics TouchPad                  id=3D=
11    [slave=20
pointer  (2)]
=E2=8E=A3 Virtual core keyboard                       id=3D3    [master=
 keyboard (2)]
     =E2=86=B3 Virtual core XTEST keyboard                 id=3D5    [s=
lave=20
keyboard (3)]
     =E2=86=B3 Power Button                                id=3D6    [s=
lave=20
keyboard (3)]
     =E2=86=B3 Video Bus                                   id=3D7    [s=
lave=20
keyboard (3)]
     =E2=86=B3 Power Button                                id=3D8    [s=
lave=20
keyboard (3)]
     =E2=86=B3 Integrated Webcam                           id=3D9    [s=
lave=20
keyboard (3)]
     =E2=86=B3 AT Translated Set 2 keyboard                id=3D10    [=
slave=20
keyboard (3)]
     =E2=86=B3 Dell WMI hotkeys                            id=3D12    [=
slave=20
keyboard (3)]

As you can see, the touchpad is no longer called "DLL05E3:01 06CB:2734"=
=2E=20
However, touchscreen "ATML1000:00 03EB:842F" is missing now.

Thank you for your time.

--
Wouter van der Graaf
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
