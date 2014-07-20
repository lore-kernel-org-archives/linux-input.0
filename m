From: Daniel Heckenberg <daniel@bogusfront.org>
Subject: [Problem] Samsung 700T1C Elan USB Touchpad not detected as touchpad
Date: Sun, 20 Jul 2014 17:14:27 +1000
Message-ID: <CA+uZGHrv5BWjNOe5HZHg_i_8_-bnsLVMHd9w0ovwDkHO=RYZBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169]:48540 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952AbaGTHO2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Jul 2014 03:14:28 -0400
Received: by mail-qc0-f169.google.com with SMTP id m20so4765124qcx.28
        for <linux-input@vger.kernel.org>; Sun, 20 Jul 2014 00:14:27 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello,

I'm experiencing the following issue which I'd like to help resolve.
Please let me know if there's any other information or action that I
can provide.

I'll send additional information in subsequent mails to avoid the
majordomo length block.

Many thanks,
Daniel

[1] Summary:
Samsung 700T1C Elan USB Touchpad not detected as touchpad

[2] Full description:
The Elan USB Touchpad (part of a USB keyboard / touchpad combo device)
used in the keboard dock for the Samsung 700T1C Ativ Tab Pro hybrid
laptop / tablet is not identified as a touchpad, but instead functions
only as a mouse.

This is clearly evident in X, where the input class driver matching
process fails to assign the "synaptics" driver as the
"matchIsTouchpad" predicate fails.  Even if the "synaptics" driver is
directly assigned to the input device (/dev/input/event13 in this
case) with Option "protocol" "event", the synaptics driver fails to
communicate with the touchpad (see Xorg.0.log excerpt below).

[3] Keywords:

[4] Kernel version:
Linux version 3.16.0-031600rc5-generic (apw@gomeisa) (gcc version
4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201407131735 SMP Sun Jul 13
21:36:15 UTC 2014

[5] Oops

[6] Repro
Boot.  Start X.

[7] Environment
Description:    Ubuntu 14.04 LTS
Release:    14.04

[7.1] sh ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux carbon-u 3.16.0-031600rc5-generic #201407131735 SMP Sun Jul 13
21:36:15 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux

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
Modules Loaded         ctr ccm uas usb_storage wacom
snd_hda_codec_hdmi rfcomm bnep snd_hda_codec_realtek
snd_hda_codec_generic uvcvideo videobuf2_vmalloc videobuf2_memops
videobuf2_core v4l2_common videodev media btusb bluetooth 6lowpan_iphc
joydev hid_sensor_magn_3d hid_sensor_gyro_3d hid_sensor_incl_3d
hid_sensor_rotation hid_sensor_accel_3d hid_multitouch
hid_sensor_trigger industrialio_triggered_buffer kfifo_buf
industrialio hid_sensor_iio_common hid_generic hid_sensor_hub usbhid
hid snd_hda_intel snd_hda_controller snd_hda_codec snd_hwdep snd_pcm
snd_seq_midi snd_seq_midi_event intel_rapl x86_pkg_temp_thermal
intel_powerclamp snd_rawmidi coretemp kvm_intel kvm binfmt_misc
crct10dif_pclmul crc32_pclmul ghash_clmulni_intel arc4 aesni_intel
aes_x86_64 lrw gf128mul glue_helper ablk_helper iwldvm cryptd
microcode snd_seq mac80211 serio_raw snd_seq_device nls_iso8859_1
snd_timer iwlwifi i915 cfg80211 drm_kms_helper wmi mac_hid video
tpm_infineon drm snd i2c_algo_bit soundcore mei_me lpc_ich mei
parport_pc ppdev lp parport ahci libahci

[7.2] cat /proc/cpuinfo
processor    : 0
vendor_id    : GenuineIntel
cpu family    : 6
model        : 58
model name    : Intel(R) Core(TM) i5-3337U CPU @ 1.80GHz
stepping    : 9
microcode    : 0x19
cpu MHz        : 2498.132
cache size    : 3072 KB
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
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor
ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic
popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm ida arat
epb xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid
fsgsbase smep erms
bogomips    : 3591.70
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 1
vendor_id    : GenuineIntel
cpu family    : 6
model        : 58
model name    : Intel(R) Core(TM) i5-3337U CPU @ 1.80GHz
stepping    : 9
microcode    : 0x19
cpu MHz        : 2442.585
cache size    : 3072 KB
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
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor
ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic
popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm ida arat
epb xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid
fsgsbase smep erms
bogomips    : 3591.70
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 2
vendor_id    : GenuineIntel
cpu family    : 6
model        : 58
model name    : Intel(R) Core(TM) i5-3337U CPU @ 1.80GHz
stepping    : 9
microcode    : 0x19
cpu MHz        : 2012.484
cache size    : 3072 KB
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
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor
ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic
popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm ida arat
epb xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid
fsgsbase smep erms
bogomips    : 3591.70
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 3
vendor_id    : GenuineIntel
cpu family    : 6
model        : 58
model name    : Intel(R) Core(TM) i5-3337U CPU @ 1.80GHz
stepping    : 9
microcode    : 0x19
cpu MHz        : 2454.468
cache size    : 3072 KB
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
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor
ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic
popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm ida arat
epb xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid
fsgsbase smep erms
bogomips    : 3591.70
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

[7.3] cat /proc/modules
ctr 13193 3 - Live 0x0000000000000000
ccm 17856 3 - Live 0x0000000000000000
uas 27672 0 - Live 0x0000000000000000
usb_storage 67010 2 uas, Live 0x0000000000000000
wacom 68276 0 - Live 0x0000000000000000
snd_hda_codec_hdmi 48243 1 - Live 0x0000000000000000
rfcomm 75114 8 - Live 0x0000000000000000
bnep 19884 2 - Live 0x0000000000000000
snd_hda_codec_realtek 73695 1 - Live 0x0000000000000000
snd_hda_codec_generic 70087 1 snd_hda_codec_realtek, Live 0x0000000000000000
uvcvideo 86628 0 - Live 0x0000000000000000
videobuf2_vmalloc 13216 1 uvcvideo, Live 0x0000000000000000
videobuf2_memops 13362 1 videobuf2_vmalloc, Live 0x0000000000000000
videobuf2_core 59635 1 uvcvideo, Live 0x0000000000000000
v4l2_common 15715 1 videobuf2_core, Live 0x0000000000000000
videodev 154834 3 uvcvideo,videobuf2_core,v4l2_common, Live 0x0000000000000000
media 22008 2 uvcvideo,videodev, Live 0x0000000000000000
btusb 32605 0 - Live 0x0000000000000000
bluetooth 467228 22 rfcomm,bnep,btusb, Live 0x0000000000000000
6lowpan_iphc 18968 1 bluetooth, Live 0x0000000000000000
joydev 17587 0 - Live 0x0000000000000000
hid_sensor_magn_3d 13324 0 - Live 0x0000000000000000
hid_sensor_gyro_3d 13324 0 - Live 0x0000000000000000
hid_sensor_incl_3d 13324 0 - Live 0x0000000000000000
hid_sensor_rotation 13444 0 - Live 0x0000000000000000
hid_sensor_accel_3d 13338 0 - Live 0x0000000000000000
hid_multitouch 17657 0 - Live 0x0000000000000000
hid_sensor_trigger 13134 5
hid_sensor_magn_3d,hid_sensor_gyro_3d,hid_sensor_incl_3d,hid_sensor_rotation,hid_sensor_accel_3d,
Live 0x0000000000000000
industrialio_triggered_buffer 12882 5
hid_sensor_magn_3d,hid_sensor_gyro_3d,hid_sensor_incl_3d,hid_sensor_rotation,hid_sensor_accel_3d,
Live 0x0000000000000000
kfifo_buf 13432 1 industrialio_triggered_buffer, Live 0x0000000000000000
industrialio 55460 8
hid_sensor_magn_3d,hid_sensor_gyro_3d,hid_sensor_incl_3d,hid_sensor_rotation,hid_sensor_accel_3d,hid_sensor_trigger,industrialio_triggered_buffer,kfifo_buf,
Live 0x0000000000000000
hid_sensor_iio_common 14407 5
hid_sensor_magn_3d,hid_sensor_gyro_3d,hid_sensor_incl_3d,hid_sensor_rotation,hid_sensor_accel_3d,
Live 0x0000000000000000
hid_generic 12559 0 - Live 0x0000000000000000
hid_sensor_hub 19877 7
hid_sensor_magn_3d,hid_sensor_gyro_3d,hid_sensor_incl_3d,hid_sensor_rotation,hid_sensor_accel_3d,hid_sensor_trigger,hid_sensor_iio_common,
Live 0x0000000000000000
usbhid 53122 0 - Live 0x0000000000000000
hid 110572 4 hid_multitouch,hid_generic,hid_sensor_hub,usbhid, Live
0x0000000000000000
snd_hda_intel 30683 3 - Live 0x0000000000000000
snd_hda_controller 35518 1 snd_hda_intel, Live 0x0000000000000000
snd_hda_codec 144889 5
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_controller,
Live 0x0000000000000000
snd_hwdep 17709 1 snd_hda_codec, Live 0x0000000000000000
snd_pcm 105052 4
snd_hda_codec_hdmi,snd_hda_intel,snd_hda_controller,snd_hda_codec,
Live 0x0000000000000000
snd_seq_midi 13564 0 - Live 0x0000000000000000
snd_seq_midi_event 14899 1 snd_seq_midi, Live 0x0000000000000000
intel_rapl 19196 0 - Live 0x0000000000000000
x86_pkg_temp_thermal 14312 0 - Live 0x0000000000000000
intel_powerclamp 19099 0 - Live 0x0000000000000000
snd_rawmidi 31197 1 snd_seq_midi, Live 0x0000000000000000
coretemp 13638 0 - Live 0x0000000000000000
kvm_intel 149086 0 - Live 0x0000000000000000
kvm 464279 1 kvm_intel, Live 0x0000000000000000
binfmt_misc 17508 1 - Live 0x0000000000000000
crct10dif_pclmul 14268 0 - Live 0x0000000000000000
crc32_pclmul 13180 0 - Live 0x0000000000000000
ghash_clmulni_intel 13230 0 - Live 0x0000000000000000
arc4 12573 2 - Live 0x0000000000000000
aesni_intel 152648 7 - Live 0x0000000000000000
aes_x86_64 17131 1 aesni_intel, Live 0x0000000000000000
lrw 13323 1 aesni_intel, Live 0x0000000000000000
gf128mul 14951 1 lrw, Live 0x0000000000000000
glue_helper 14095 1 aesni_intel, Live 0x0000000000000000
ablk_helper 13597 1 aesni_intel, Live 0x0000000000000000
iwldvm 243680 0 - Live 0x0000000000000000
cryptd 20531 3 ghash_clmulni_intel,aesni_intel,ablk_helper, Live
0x0000000000000000
microcode 24525 0 - Live 0x0000000000000000
snd_seq 63540 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
mac80211 687067 1 iwldvm, Live 0x0000000000000000
serio_raw 13483 0 - Live 0x0000000000000000
snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x0000000000000000
nls_iso8859_1 12713 1 - Live 0x0000000000000000
snd_timer 30118 2 snd_pcm,snd_seq, Live 0x0000000000000000
iwlwifi 190534 1 iwldvm, Live 0x0000000000000000
i915 945853 3 - Live 0x0000000000000000
cfg80211 521225 3 iwldvm,mac80211,iwlwifi, Live 0x0000000000000000
drm_kms_helper 62042 1 i915, Live 0x0000000000000000
wmi 19379 0 - Live 0x0000000000000000
mac_hid 13275 0 - Live 0x0000000000000000
video 20521 1 i915, Live 0x0000000000000000
tpm_infineon 17169 0 - Live 0x0000000000000000
drm 316819 5 i915,drm_kms_helper, Live 0x0000000000000000
snd 84025 17 snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_seq_device,snd_timer,
Live 0x0000000000000000
i2c_algo_bit 13564 1 i915, Live 0x0000000000000000
soundcore 15091 2 snd_hda_codec,snd, Live 0x0000000000000000
mei_me 19565 0 - Live 0x0000000000000000
lpc_ich 21176 0 - Live 0x0000000000000000
mei 88632 1 mei_me, Live 0x0000000000000000
parport_pc 32906 0 - Live 0x0000000000000000
ppdev 17711 0 - Live 0x0000000000000000
lp 17799 0 - Live 0x0000000000000000
parport 42481 3 parport_pc,ppdev,lp, Live 0x0000000000000000
ahci 30167 3 - Live 0x0000000000000000
libahci 32533 1 ahci, Live 0x0000000000000000

[7.4] cat /proc/ioports; cat /proc/iomem
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
  00f0-00ff : PNP0C04:00
    00f0-00ff : fpu
  0400-0403 : ACPI PM1a_EVT_BLK
  0404-0405 : ACPI PM1a_CNT_BLK
  0408-040b : ACPI PM_TMR
  0410-0415 : ACPI CPU throttle
  0420-042f : ACPI GPE0_BLK
  0430-0433 : iTCO_wdt
  0450-0450 : ACPI PM2_CNT_BLK
  0454-0457 : pnp 00:03
  0458-047f : pnp 00:01
    0460-047f : iTCO_wdt
  04d0-04d1 : pnp 00:05
  0500-057f : pnp 00:01
  0680-069f : pnp 00:01
  0a00-0a07 : pnp 00:01
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
  1000-100f : pnp 00:01
  164e-164f : pnp 00:01
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

00000000-00000fff : reserved
00001000-0009dfff : System RAM
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
000f0000-000fffff : PCI Bus 0000:00
  000f0000-000fffff : System ROM
00100000-1fffffff : System RAM
  01000000-01794ed8 : Kernel code
  01794ed9-01d1713f : Kernel data
  01e76000-01fb8fff : Kernel bss
20000000-201fffff : reserved
  20000000-201fffff : pnp 00:07
20200000-40003fff : System RAM
40004000-40004fff : reserved
  40004000-40004fff : pnp 00:07
40005000-d95a3fff : System RAM
d95a4000-d9a23fff : reserved
d9a24000-d9a33fff : ACPI Tables
d9a34000-da052fff : ACPI Non-volatile Storage
da053000-da667fff : reserved
da668000-da886fff : reserved
da887000-da887fff : System RAM
da888000-da8cafff : ACPI Non-volatile Storage
da8cb000-dacebfff : System RAM
dacec000-daff3fff : reserved
daff4000-daffffff : System RAM
db000000-df9fffff : reserved
  dba00000-df9fffff : Graphics Stolen Memory
dfa00000-feafffff : PCI Bus 0000:00
  dfa00000-dfa00fff : pnp 00:06
  e0000000-efffffff : 0000:00:02.0
  f7800000-f7bfffff : 0000:00:02.0
  f7c00000-f7cfffff : PCI Bus 0000:01
    f7c00000-f7c01fff : 0000:01:00.0
      f7c00000-f7c01fff : iwlwifi
  f7d00000-f7d0ffff : 0000:00:14.0
    f7d00000-f7d0ffff : xhci_hcd
  f7d10000-f7d13fff : 0000:00:1b.0
    f7d10000-f7d13fff : ICH HD audio
  f7d15000-f7d150ff : 0000:00:1f.3
  f7d16000-f7d167ff : 0000:00:1f.2
    f7d16000-f7d167ff : ahci
  f7d17000-f7d173ff : 0000:00:1d.0
    f7d17000-f7d173ff : ehci_hcd
  f7d18000-f7d183ff : 0000:00:1a.0
    f7d18000-f7d183ff : ehci_hcd
  f7d1a000-f7d1a00f : 0000:00:16.0
    f7d1a000-f7d1a00f : mei_me
  f8000000-fbffffff : PCI MMCONFIG 0000 [bus 00-3f]
    f8000000-fbffffff : reserved
      f8000000-fbffffff : pnp 00:06
fec00000-fec00fff : reserved
  fec00000-fec003ff : IOAPIC 0
fed00000-fed03fff : reserved
  fed00000-fed003ff : HPET 0
    fed00000-fed003ff : PNP0103:00
fed10000-fed17fff : pnp 00:06
fed18000-fed18fff : pnp 00:06
fed19000-fed19fff : pnp 00:06
fed1c000-fed1ffff : reserved
  fed1c000-fed1ffff : pnp 00:06
    fed1f410-fed1f414 : iTCO_wdt
fed20000-fed3ffff : pnp 00:06
fed40000-fed44fff : pnp 00:00
fed45000-fed8ffff : pnp 00:06
fed90000-fed90fff : dmar0
fed91000-fed91fff : dmar1
fee00000-fee00fff : Local APIC
  fee00000-fee00fff : reserved
ff000000-ffffffff : reserved
  ff000000-ffffffff : INT0800:00
    ff000000-ffffffff : pnp 00:06
100000000-11f5fffff : System RAM
11f600000-11fffffff : RAM buffer

[7.5] sudo lscpi -vvv
00:00.0 Host bridge: Intel Corporation 3rd Gen Core processor DRAM
Controller (rev 09)
    Subsystem: Samsung Electronics Co Ltd Device c0e1
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR- INTx-
    Latency: 0
    Capabilities: [e0] Vendor Specific Information: Len=0c <?>
    Kernel driver in use: ivb_uncore

00:02.0 VGA compatible controller: Intel Corporation 3rd Gen Core
processor Graphics Controller (rev 09) (prog-if 00 [VGA controller])
    Subsystem: Samsung Electronics Co Ltd Device c0e1
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 46
    Region 0: Memory at f7800000 (64-bit, non-prefetchable) [size=4M]
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

00:14.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset
Family USB xHCI Host Controller (rev 04) (prog-if 30 [XHCI])
    Subsystem: Samsung Electronics Co Ltd Device c0e1
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 42
    Region 0: Memory at f7d00000 (64-bit, non-prefetchable) [size=64K]
    Capabilities: [70] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
        Address: 00000000fee00298  Data: 0000
    Kernel driver in use: xhci_hcd

00:16.0 Communication controller: Intel Corporation 7 Series/C210
Series Chipset Family MEI Controller #1 (rev 04)
    Subsystem: Samsung Electronics Co Ltd Device c0e1
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 44
    Region 0: Memory at f7d1a000 (64-bit, non-prefetchable) [size=16]
    Capabilities: [50] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Address: 00000000fee002f8  Data: 0000
    Kernel driver in use: mei_me

00:1a.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset
Family USB Enhanced Host Controller #2 (rev 04) (prog-if 20 [EHCI])
    Subsystem: Samsung Electronics Co Ltd Device c0e1
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 16
    Region 0: Memory at f7d18000 (32-bit, non-prefetchable) [size=1K]
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

00:1b.0 Audio device: Intel Corporation 7 Series/C210 Series Chipset
Family High Definition Audio Controller (rev 04)
    Subsystem: Samsung Electronics Co Ltd Device c0e1
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 57
    Region 0: Memory at f7d10000 (64-bit, non-prefetchable) [size=16K]
    Capabilities: [50] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Address: 00000000fee00358  Data: 0000
    Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0
            ExtTag- RBE-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
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

00:1c.0 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset
Family PCI Express Root Port 1 (rev c4) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
    I/O behind bridge: 0000f000-00000fff
    Memory behind bridge: f7c00000-f7cfffff
    Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0
            ExtTag- RBE+
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
        LnkCap:    Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s <512ns, L1 <16us
            ClockPM- Surprise- LLActRep+ BwNot-
        LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk+
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
        DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF
Not Supported ARIFwd-
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-,
OBFF Disabled ARIFwd-
        LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
    Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
        Address: 00000000  Data: 0000
    Capabilities: [90] Subsystem: Samsung Electronics Co Ltd Device c0e1
    Capabilities: [a0] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Kernel driver in use: pcieport

00:1d.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset
Family USB Enhanced Host Controller #1 (rev 04) (prog-if 20 [EHCI])
    Subsystem: Samsung Electronics Co Ltd Device c0e1
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 23
    Region 0: Memory at f7d17000 (32-bit, non-prefetchable) [size=1K]
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

00:1f.0 ISA bridge: Intel Corporation HM76 Express Chipset LPC
Controller (rev 04)
    Subsystem: Samsung Electronics Co Ltd Device c0e1
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Capabilities: [e0] Vendor Specific Information: Len=0c <?>
    Kernel driver in use: lpc_ich

00:1f.2 SATA controller: Intel Corporation 7 Series Chipset Family
6-port SATA Controller [AHCI mode] (rev 04) (prog-if 01 [AHCI 1.0])
    Subsystem: Samsung Electronics Co Ltd Device c0e1
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin B routed to IRQ 43
    Region 0: I/O ports at f0b0 [size=8]
    Region 1: I/O ports at f0a0 [size=4]
    Region 2: I/O ports at f090 [size=8]
    Region 3: I/O ports at f080 [size=4]
    Region 4: I/O ports at f060 [size=32]
    Region 5: Memory at f7d16000 (32-bit, non-prefetchable) [size=2K]
    Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Address: fee002d8  Data: 0000
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

00:1f.3 SMBus: Intel Corporation 7 Series/C210 Series Chipset Family
SMBus Controller (rev 04)
    Subsystem: Samsung Electronics Co Ltd Device c0e1
    Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Interrupt: pin C routed to IRQ 255
    Region 0: Memory at f7d15000 (64-bit, non-prefetchable) [size=256]
    Region 4: I/O ports at f040 [size=32]

01:00.0 Network controller: Intel Corporation Centrino Advanced-N 6235 (rev 24)
    Subsystem: Intel Corporation Centrino Advanced-N 6235 AGN
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 45
    Region 0: Memory at f7c00000 (64-bit, non-prefetchable) [size=8K]
    Capabilities: [c8] Power Management version 3
        Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Address: 00000000fee00318  Data: 0000
    Capabilities: [e0] Express (v1) Endpoint, MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s
<512ns, L1 unlimited
            ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
        LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s <4us, L1 <32us
            ClockPM+ Surprise- LLActRep- BwNot-
        LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
    Capabilities: [100 v1] Advanced Error Reporting
        UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UESvrt:    DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
        CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
        CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
        AERCap:    First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
    Capabilities: [140 v1] Device Serial Number c8-f7-33-ff-ff-f5-6f-4f
    Kernel driver in use: iwlwifi

[7.6] cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: SAMSUNG MZMTD128 Rev: 1K0Q
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi6 Channel: 00 Id: 00 Lun: 00
  Vendor: Generic  Model: STORAGE DEVICE   Rev: 0208
  Type:   Direct-Access                    ANSI  SCSI revision: 00

[7.7] ls /proc
1     145   1711  1891  2110  2317  2626  373  535  723  958
iomem         schedstat
10    146   1735  1896  2118  2324  27    38   54   724  991
ioports       scsi
1001  147   18    1897  2124  2325  28    39   541  725  997
irq           self
1003  148   1802  19    2127  2333  2806  390  542  766  acpi
kallsyms      slabinfo
1012  149   1807  1977  2131  2362  2820  40   543  767  asound
kcore         softirqs
1054  15    1815  1979  2134  2370  2842  41   550  768  buddyinfo
key-users     stat
11    150   1823  1981  2145  2371  2853  410  587  771  bus
kmsg          swaps
1101  151   1831  1983  2166  24    286   42   593  795  cgroups
kpagecount    sys
1104  152   1834  1988  2174  2419  289   429  594  8    cmdline
kpageflags    sysrq-trigger
1106  1522  1836  1993  2214  2431  29    43   609  825  consoles
loadavg       sysvipc
1117  153   1838  1996  2217  2442  290   44   619  843  cpuinfo
locks         timer_list
1120  154   1840  1997  2233  2453  3     45   646  89   crypto
mdstat        timer_stats
1145  1547  1845  2     2240  25    30    455  652  895  devices
meminfo       tty
1194  155   1847  20    2249  2548  31    46   654  898  diskstats
misc          uptime
12    1550  1855  2019  2251  2566  311   47   66   9    dma
modules       version
1222  156   1866  2025  2259  2568  322   48   67   90   driver
mounts        vmallocinfo
1285  157   1869  2034  2263  2580  33    5    68   92   execdomains
mtrr          vmstat
13    16    1876  2039  2292  2599  34    50   69   944  fb
net           zoneinfo
14    169   1878  21    23    26    35    515  7    948  filesystems
pagetypeinfo
143   17    1883  2102  2304  2612  36    52   721  954  fs           partitions
144   170   1886  2104  2306  2614  37    53   722  955  interrupts
sched_debug


[X.] Other

Ubuntu Launchpad bug report #134935
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1343935
