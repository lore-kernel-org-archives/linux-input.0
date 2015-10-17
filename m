From: =?UTF-8?Q?Nathana=c3=abl/Thatoo?= <thatoo@leprette.fr>
Subject: FocalTech touchpad stops working after suspend
Date: Sat, 17 Oct 2015 19:08:57 +0330
Message-ID: <56226B91.4070209@leprette.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070306030108020709030503"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 17.mo3.mail-out.ovh.net ([87.98.178.58]:55383 "EHLO
	17.mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652AbbJQSHH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 17 Oct 2015 14:07:07 -0400
Received: from mail92.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo3.mail-out.ovh.net (Postfix) with SMTP id 7D0F3FFA626
	for <linux-input@vger.kernel.org>; Sat, 17 Oct 2015 17:39:07 +0200 (CEST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

This is a multi-part message in MIME format.
--------------070306030108020709030503
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

[1.] FocalTech touchpad stops working after suspend

[2.]

I have an Asus V502LX the persian version of the Asus K501LX.

I have Ubuntu 14.04 installed and the kernel 4.3-rc5 installed.
The touchpad is recognised. whreas under kernel 3.19.30, the touchpad
was recognised as a simple mouse (no two fingers scrolling...).

However, the Focaltech touchpad is not working after suspending the
computer.
After I close the lid of my computer or click on the button to suspend
its activity, after awaking, everything seems to work except the
touchpad. The keyboard works, the wifi reconnect but the touchpad is
blocked. I have to restart to get it working again.

Before suspending the computer, I can deactivate and activate again the
touchpad with the hotkey of my keyboard without problem. However, once
the computer suspended, nothing work to re-activate the touchpad.

[3.]

[4.]
yogo@yogo-ordi:~$  cat /proc/version
Linux version 4.3.0-040300rc5-generic (kernel@tangerine) (gcc version
4.8.4 (Ubuntu 4.8.4-2ubuntu1~14.04) ) #201510111530 SMP Sun Oct 11
19:31:35 UTC 2015
yogo@yogo-ordi:~$

[5.]

[6.]

[7.]
yogo@yogo-ordi:~$ lsb_release -rd
Description:    Ubuntu 14.04.3 LTS
Release:    14.04
yogo@yogo-ordi:~$


[7.1.]
yogo@yogo-ordi:/usr/src/linux-headers-4.3.0-040300rc5/scripts$ sh ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux yogo-ordi 4.3.0-040300rc5-generic #201510111530 SMP Sun Oct 11
19:31:35 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux
 
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
Modules Loaded         drbg ansi_cprng ctr ccm cmac bnep rfcomm
binfmt_misc nls_iso8859_1 arc4 uvcvideo videobuf2_vmalloc
videobuf2_memops rtsx_usb_ms videobuf2_core memstick v4l2_common
rtsx_usb_sdmmc videodev media iwlmvm rtsx_usb mac80211 intel_rapl
x86_pkg_temp_thermal intel_powerclamp snd_hda_codec_hdmi coretemp
snd_hda_codec_realtek snd_hda_codec_generic i915 kvm_intel btusb btrtl
btbcm btintel snd_hda_intel kvm mxm_wmi asus_nb_wmi crct10dif_pclmul
crc32_pclmul ghash_clmulni_intel asus_wmi aesni_intel snd_hda_codec
iwlwifi aes_x86_64 snd_hda_core sparse_keymap lrw snd_hwdep snd_pcm
drm_kms_helper gf128mul glue_helper ablk_helper snd_seq_midi cryptd
snd_seq_midi_event snd_rawmidi joydev input_leds drm snd_seq
snd_seq_device snd_timer cfg80211 i2c_algo_bit parport_pc bluetooth
serio_raw ppdev fb_sys_fops syscopyarea sysfillrect
processor_thermal_device int3400_thermal int3402_thermal mei_me
sysimgblt mei wmi acpi_thermal_rel int340x_thermal_zone
intel_pch_thermal lp snd intel_soc_dts_iosf snd_soc_sst_acpi dw_dmac
iosf_mbi dw_dmac_core soundcore video 8250_dw spi_pxa2xx_platform
i2c_designware_platform i2c_designware_core acpi_pad shpchp mac_hid
lpc_ich parport psmouse ahci r8169 libahci mii sdhci_acpi sdhci fjes
yogo@yogo-ordi:/usr/src/linux-headers-4.3.0-040300rc5/scripts$


[7.2.]
yogo@yogo-ordi:~$  cat /proc/cpuinfo
processor    : 0
vendor_id    : GenuineIntel
cpu family    : 6
model        : 61
model name    : Intel(R) Core(TM) i5-5200U CPU @ 2.20GHz
stepping    : 4
microcode    : 0x19
cpu MHz        : 1112.203
cache size    : 3072 KB
physical id    : 0
siblings    : 4
core id        : 0
cpu cores    : 2
apicid        : 0
initial apicid    : 0
fpu        : yes
fpu_exception    : yes
cpuid level    : 20
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall
nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor
ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2
x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm
abm 3dnowprefetch ida arat epb pln pts dtherm intel_pt tpr_shadow vnmi
flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms
invpcid rdseed adx smap xsaveopt
bugs        :
bogomips    : 4389.80
clflush size    : 64
cache_alignment    : 64
address sizes    : 39 bits physical, 48 bits virtual
power management:

processor    : 1
vendor_id    : GenuineIntel
cpu family    : 6
model        : 61
model name    : Intel(R) Core(TM) i5-5200U CPU @ 2.20GHz
stepping    : 4
microcode    : 0x19
cpu MHz        : 1420.804
cache size    : 3072 KB
physical id    : 0
siblings    : 4
core id        : 1
cpu cores    : 2
apicid        : 2
initial apicid    : 2
fpu        : yes
fpu_exception    : yes
cpuid level    : 20
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall
nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor
ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2
x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm
abm 3dnowprefetch ida arat epb pln pts dtherm intel_pt tpr_shadow vnmi
flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms
invpcid rdseed adx smap xsaveopt
bugs        :
bogomips    : 4389.80
clflush size    : 64
cache_alignment    : 64
address sizes    : 39 bits physical, 48 bits virtual
power management:

processor    : 2
vendor_id    : GenuineIntel
cpu family    : 6
model        : 61
model name    : Intel(R) Core(TM) i5-5200U CPU @ 2.20GHz
stepping    : 4
microcode    : 0x19
cpu MHz        : 799.906
cache size    : 3072 KB
physical id    : 0
siblings    : 4
core id        : 0
cpu cores    : 2
apicid        : 1
initial apicid    : 1
fpu        : yes
fpu_exception    : yes
cpuid level    : 20
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall
nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor
ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2
x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm
abm 3dnowprefetch ida arat epb pln pts dtherm intel_pt tpr_shadow vnmi
flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms
invpcid rdseed adx smap xsaveopt
bugs        :
bogomips    : 4389.80
clflush size    : 64
cache_alignment    : 64
address sizes    : 39 bits physical, 48 bits virtual
power management:

processor    : 3
vendor_id    : GenuineIntel
cpu family    : 6
model        : 61
model name    : Intel(R) Core(TM) i5-5200U CPU @ 2.20GHz
stepping    : 4
microcode    : 0x19
cpu MHz        : 2193.039
cache size    : 3072 KB
physical id    : 0
siblings    : 4
core id        : 1
cpu cores    : 2
apicid        : 3
initial apicid    : 3
fpu        : yes
fpu_exception    : yes
cpuid level    : 20
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall
nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor
ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2
x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm
abm 3dnowprefetch ida arat epb pln pts dtherm intel_pt tpr_shadow vnmi
flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms
invpcid rdseed adx smap xsaveopt
bugs        :
bogomips    : 4389.80
clflush size    : 64
cache_alignment    : 64
address sizes    : 39 bits physical, 48 bits virtual
power management:

yogo@yogo-ordi:~$

[7.3.]
yogo@yogo-ordi:~$ cat /proc/modules
drbg 28672 1 - Live 0x0000000000000000
ansi_cprng 16384 0 - Live 0x0000000000000000
ctr 16384 1 - Live 0x0000000000000000
ccm 20480 1 - Live 0x0000000000000000
cmac 16384 2 - Live 0x0000000000000000
bnep 20480 2 - Live 0x0000000000000000
rfcomm 69632 8 - Live 0x0000000000000000
binfmt_misc 20480 1 - Live 0x0000000000000000
nls_iso8859_1 16384 1 - Live 0x0000000000000000
arc4 16384 2 - Live 0x0000000000000000
uvcvideo 90112 0 - Live 0x0000000000000000
videobuf2_vmalloc 16384 1 uvcvideo, Live 0x0000000000000000
videobuf2_memops 16384 1 videobuf2_vmalloc, Live 0x0000000000000000
rtsx_usb_ms 20480 0 - Live 0x0000000000000000
videobuf2_core 49152 1 uvcvideo, Live 0x0000000000000000
memstick 20480 1 rtsx_usb_ms, Live 0x0000000000000000
v4l2_common 16384 1 videobuf2_core, Live 0x0000000000000000
rtsx_usb_sdmmc 28672 0 - Live 0x0000000000000000
videodev 172032 3 uvcvideo,videobuf2_core,v4l2_common, Live
0x0000000000000000
media 24576 2 uvcvideo,videodev, Live 0x0000000000000000
iwlmvm 307200 0 - Live 0x0000000000000000
rtsx_usb 24576 2 rtsx_usb_ms,rtsx_usb_sdmmc, Live 0x0000000000000000
mac80211 724992 1 iwlmvm, Live 0x0000000000000000
intel_rapl 20480 0 - Live 0x0000000000000000
x86_pkg_temp_thermal 16384 0 - Live 0x0000000000000000
intel_powerclamp 16384 0 - Live 0x0000000000000000
snd_hda_codec_hdmi 49152 1 - Live 0x0000000000000000
coretemp 16384 0 - Live 0x0000000000000000
snd_hda_codec_realtek 81920 1 - Live 0x0000000000000000
snd_hda_codec_generic 73728 1 snd_hda_codec_realtek, Live 0x0000000000000000
i915 1138688 5 - Live 0x0000000000000000
kvm_intel 163840 0 - Live 0x0000000000000000
btusb 45056 0 - Live 0x0000000000000000
btrtl 16384 1 btusb, Live 0x0000000000000000
btbcm 16384 1 btusb, Live 0x0000000000000000
btintel 16384 1 btusb, Live 0x0000000000000000
snd_hda_intel 36864 5 - Live 0x0000000000000000
kvm 507904 1 kvm_intel, Live 0x0000000000000000
mxm_wmi 16384 0 - Live 0x0000000000000000
asus_nb_wmi 24576 0 - Live 0x0000000000000000
crct10dif_pclmul 16384 0 - Live 0x0000000000000000
crc32_pclmul 16384 0 - Live 0x0000000000000000
ghash_clmulni_intel 16384 0 - Live 0x0000000000000000
asus_wmi 28672 1 asus_nb_wmi, Live 0x0000000000000000
aesni_intel 167936 4 - Live 0x0000000000000000
snd_hda_codec 135168 4
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,
Live 0x0000000000000000
iwlwifi 208896 1 iwlmvm, Live 0x0000000000000000
aes_x86_64 20480 1 aesni_intel, Live 0x0000000000000000
snd_hda_core 65536 5
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,
Live 0x0000000000000000
sparse_keymap 16384 1 asus_wmi, Live 0x0000000000000000
lrw 16384 1 aesni_intel, Live 0x0000000000000000
snd_hwdep 16384 1 snd_hda_codec, Live 0x0000000000000000
snd_pcm 102400 4
snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec,snd_hda_core, Live
0x0000000000000000
drm_kms_helper 131072 1 i915, Live 0x0000000000000000
gf128mul 16384 1 lrw, Live 0x0000000000000000
glue_helper 16384 1 aesni_intel, Live 0x0000000000000000
ablk_helper 16384 1 aesni_intel, Live 0x0000000000000000
snd_seq_midi 16384 0 - Live 0x0000000000000000
cryptd 20480 3 ghash_clmulni_intel,aesni_intel,ablk_helper, Live
0x0000000000000000
snd_seq_midi_event 16384 1 snd_seq_midi, Live 0x0000000000000000
snd_rawmidi 32768 1 snd_seq_midi, Live 0x0000000000000000
joydev 20480 0 - Live 0x0000000000000000
input_leds 16384 0 - Live 0x0000000000000000
drm 352256 6 i915,drm_kms_helper, Live 0x0000000000000000
snd_seq 69632 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
snd_seq_device 16384 3 snd_seq_midi,snd_rawmidi,snd_seq, Live
0x0000000000000000
snd_timer 32768 2 snd_pcm,snd_seq, Live 0x0000000000000000
cfg80211 540672 3 iwlmvm,mac80211,iwlwifi, Live 0x0000000000000000
i2c_algo_bit 16384 1 i915, Live 0x0000000000000000
parport_pc 36864 0 - Live 0x0000000000000000
bluetooth 516096 25 bnep,rfcomm,btusb,btrtl,btbcm,btintel, Live
0x0000000000000000
serio_raw 16384 0 - Live 0x0000000000000000
ppdev 20480 0 - Live 0x0000000000000000
fb_sys_fops 16384 1 drm_kms_helper, Live 0x0000000000000000
syscopyarea 16384 1 drm_kms_helper, Live 0x0000000000000000
sysfillrect 16384 1 drm_kms_helper, Live 0x0000000000000000
processor_thermal_device 16384 0 - Live 0x0000000000000000
int3400_thermal 16384 0 - Live 0x0000000000000000
int3402_thermal 16384 0 - Live 0x0000000000000000
mei_me 28672 0 - Live 0x0000000000000000
sysimgblt 16384 1 drm_kms_helper, Live 0x0000000000000000
mei 98304 1 mei_me, Live 0x0000000000000000
wmi 20480 2 mxm_wmi,asus_wmi, Live 0x0000000000000000
acpi_thermal_rel 16384 1 int3400_thermal, Live 0x0000000000000000
int340x_thermal_zone 16384 2 processor_thermal_device,int3402_thermal,
Live 0x0000000000000000
intel_pch_thermal 16384 0 - Live 0x0000000000000000
lp 20480 0 - Live 0x0000000000000000
snd 81920 21
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_seq_device,snd_timer,
Live 0x0000000000000000
intel_soc_dts_iosf 16384 1 processor_thermal_device, Live 0x0000000000000000
snd_soc_sst_acpi 16384 0 - Live 0x0000000000000000
dw_dmac 16384 0 - Live 0x0000000000000000
iosf_mbi 16384 2 intel_rapl,intel_soc_dts_iosf, Live 0x0000000000000000
dw_dmac_core 24576 1 dw_dmac, Live 0x0000000000000000
soundcore 16384 1 snd, Live 0x0000000000000000
video 36864 2 i915,asus_wmi, Live 0x0000000000000000
8250_dw 16384 0 - Live 0x0000000000000000
spi_pxa2xx_platform 24576 0 - Live 0x0000000000000000
i2c_designware_platform 16384 0 - Live 0x0000000000000000
i2c_designware_core 16384 1 i2c_designware_platform, Live 0x0000000000000000
acpi_pad 20480 0 - Live 0x0000000000000000
shpchp 36864 0 - Live 0x0000000000000000
mac_hid 16384 0 - Live 0x0000000000000000
lpc_ich 24576 0 - Live 0x0000000000000000
parport 49152 3 parport_pc,ppdev,lp, Live 0x0000000000000000
psmouse 122880 0 - Live 0x0000000000000000
ahci 36864 4 - Live 0x0000000000000000
r8169 81920 0 - Live 0x0000000000000000
libahci 32768 1 ahci, Live 0x0000000000000000
mii 16384 1 r8169, Live 0x0000000000000000
sdhci_acpi 16384 0 - Live 0x0000000000000000
sdhci 45056 1 sdhci_acpi, Live 0x0000000000000000
fjes 28672 0 - Live 0x0000000000000000
yogo@yogo-ordi:~$


[7.4.]
yogo@yogo-ordi:~$  cat /proc/ioports
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
  0240-0259 : pnp 00:00
  0380-038f : pnp 00:00
  0680-069f : pnp 00:03
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
  164e-164f : pnp 00:03
  1800-1803 : ACPI PM1a_EVT_BLK
  1804-1805 : ACPI PM1a_CNT_BLK
  1808-180b : ACPI PM_TMR
  1810-1815 : ACPI CPU throttle
  1830-1833 : iTCO_wdt.0.auto
  1850-1850 : ACPI PM2_CNT_BLK
  1854-1857 : pnp 00:05
  1860-187f : iTCO_wdt.0.auto
  1880-189f : ACPI GPE0_BLK
  2000-2fff : PCI Bus 0000:01
  3000-3fff : PCI Bus 0000:04
    3000-307f : 0000:04:00.0
  4000-4fff : PCI Bus 0000:02
    4000-40ff : 0000:02:00.0
      4000-40ff : r8169
  5000-503f : 0000:00:02.0
  5040-505f : 0000:00:1f.3
  5060-507f : 0000:00:1f.2
    5060-507f : ahci
  5080-5083 : 0000:00:1f.2
    5080-5083 : ahci
  5090-5097 : 0000:00:1f.2
    5090-5097 : ahci
  50a0-50a3 : 0000:00:1f.2
    50a0-50a3 : ahci
  50b0-50b7 : 0000:00:1f.2
    50b0-50b7 : ahci
  ffff-ffff : pnp 00:03
    ffff-ffff : pnp 00:03
      ffff-ffff : pnp 00:03

yogo@yogo-ordi:~$  cat /proc/iomem
00000000-00000fff : reserved
00001000-00057fff : System RAM
00058000-00058fff : reserved
00059000-0009efff : System RAM
0009f000-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000cfdff : Video ROM
000f0000-000fffff : System ROM
00100000-96e67fff : System RAM
  02000000-027b900b : Kernel code
  027b900c-02d3c4ff : Kernel data
  02eb3000-02ff7fff : Kernel bss
96e68000-971cafff : reserved
971cb000-9aa2bfff : System RAM
9aa2c000-9aa8bfff : reserved
9aa8c000-9af90fff : System RAM
9af91000-9c422fff : ACPI Non-volatile Storage
9c423000-9cee8fff : reserved
9cee9000-9cffefff : reserved
9cfff000-9cffffff : System RAM
9d000000-9d7fffff : RAM buffer
9d800000-9fffffff : reserved
  9e000000-9fffffff : Graphics Stolen Memory
a0000000-feafffff : PCI Bus 0000:00
  a0000000-a000ffff : pnp 00:06
  a0010000-a001ffff : pnp 00:06
  a0100000-a02fffff : PCI Bus 0000:01
  a0300000-a04fffff : PCI Bus 0000:01
  a1000000-a1ffffff : 0000:00:02.0
  a2000000-a30fffff : PCI Bus 0000:04
    a2000000-a2ffffff : 0000:04:00.0
    a3000000-a307ffff : 0000:04:00.0
  a3100000-a31fffff : PCI Bus 0000:03
    a3100000-a3101fff : 0000:03:00.0
      a3100000-a3101fff : iwlwifi
  a3200000-a32fffff : PCI Bus 0000:02
    a3200000-a3203fff : 0000:02:00.0
      a3200000-a3203fff : r8169
    a3204000-a3204fff : 0000:02:00.0
      a3204000-a3204fff : r8169
  a3300000-a330ffff : 0000:00:14.0
    a3300000-a330ffff : xhci-hcd
  a3310000-a3317fff : 0000:00:04.0
  a3318000-a331bfff : 0000:00:1b.0
    a3318000-a331bfff : ICH HD audio
  a331c000-a331ffff : 0000:00:03.0
    a331c000-a331ffff : ICH HD audio
  a3320000-a3320fff : 0000:00:1f.6
    a3320000-a3320fff : Intel PCH thermal driver
  a3321000-a33210ff : 0000:00:1f.3
  a3322000-a33227ff : 0000:00:1f.2
    a3322000-a33227ff : ahci
  a3324000-a332401f : 0000:00:16.0
    a3324000-a332401f : mei_me
  b0000000-bfffffff : 0000:00:02.0
  c0000000-d1ffffff : PCI Bus 0000:04
    c0000000-cfffffff : 0000:04:00.0
    d0000000-d1ffffff : 0000:04:00.0
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
    fed1f410-fed1f414 : iTCO_wdt.0.auto
fed20000-fed3ffff : pnp 00:06
fed45000-fed8ffff : pnp 00:06
fed90000-fed90fff : dmar0
fed91000-fed91fff : dmar1
fee00000-fee00fff : Local APIC
  fee00000-fee00fff : reserved
ff000000-ffffffff : reserved
  ff000000-ffffffff : INT0800:00
    ff000000-ffffffff : pnp 00:06
100000000-25effffff : System RAM
25f000000-25fffffff : RAM buffer
yogo@yogo-ordi:~$


[7.5.]
yogo@yogo-ordi:~$ sudo lspci -vvv
00:00.0 Host bridge: Intel Corporation Broadwell-U Host Bridge -OPI (rev 09)
    Subsystem: ASUSTeK Computer Inc. Device 1acd
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR- INTx-
    Latency: 0
    Capabilities: [e0] Vendor Specific Information: Len=0c <?>
    Kernel driver in use: bdw_uncore

00:02.0 VGA compatible controller: Intel Corporation Broadwell-U
Integrated Graphics (rev 09) (prog-if 00 [VGA controller])
    Subsystem: ASUSTeK Computer Inc. Device 1acd
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 52
    Region 0: Memory at a1000000 (64-bit, non-prefetchable) [size=16M]
    Region 2: Memory at b0000000 (64-bit, prefetchable) [size=256M]
    Region 4: I/O ports at 5000 [size=64]
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

00:03.0 Audio device: Intel Corporation Broadwell-U Audio Controller
(rev 09)
    Subsystem: ASUSTeK Computer Inc. Device 1acd
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 53
    Region 0: Memory at a331c000 (64-bit, non-prefetchable) [size=16K]
    Capabilities: [50] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Address: fee00378  Data: 0000
    Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0
            ExtTag- RBE-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr-
TransPend-
    Kernel driver in use: snd_hda_intel

00:04.0 Signal processing controller: Intel Corporation Broadwell-U
Camarillo Device (rev 09)
    Subsystem: ASUSTeK Computer Inc. Device 1acd
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 16
    Region 0: Memory at a3310000 (64-bit, non-prefetchable) [size=32K]
    Capabilities: [90] MSI: Enable- Count=1/1 Maskable- 64bit-
        Address: 00000000  Data: 0000
    Capabilities: [d0] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [e0] Vendor Specific Information: Len=0c <?>
    Kernel driver in use: proc_thermal

00:14.0 USB controller: Intel Corporation Wildcat Point-LP USB xHCI
Controller (rev 03) (prog-if 30 [XHCI])
    Subsystem: ASUSTeK Computer Inc. Device 201f
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 46
    Region 0: Memory at a3300000 (64-bit, non-prefetchable) [size=64K]
    Capabilities: [70] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
        Address: 00000000fee00298  Data: 0000
    Kernel driver in use: xhci_hcd

00:16.0 Communication controller: Intel Corporation Wildcat Point-LP MEI
Controller #1 (rev 03)
    Subsystem: ASUSTeK Computer Inc. Device 1acd
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 49
    Region 0: Memory at a3324000 (64-bit, non-prefetchable) [size=32]
    Capabilities: [50] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Address: 00000000fee00318  Data: 0000
    Kernel driver in use: mei_me

00:1b.0 Audio device: Intel Corporation Wildcat Point-LP High Definition
Audio Controller (rev 03)
    Subsystem: ASUSTeK Computer Inc. Device 1acd
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 32, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 51
    Region 0: Memory at a3318000 (64-bit, non-prefetchable) [size=16K]
    Capabilities: [50] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Address: 00000000fee00338  Data: 0000
    Kernel driver in use: snd_hda_intel

00:1c.0 PCI bridge: Intel Corporation Wildcat Point-LP PCI Express Root
Port #1 (rev e3) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
    I/O behind bridge: 00002000-00002fff
    Memory behind bridge: a0100000-a02fffff
    Prefetchable memory behind bridge: 00000000a0300000-00000000a04fffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0
            ExtTag- RBE+
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+
TransPend-
        LnkCap:    Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s <1us, L1 <4us
            ClockPM- Surprise- LLActRep+ BwNot+
        LnkCtl:    ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk-
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+
Surprise+
            Slot #0, PowerLimit 0.000W; Interlock- NoCompl+
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt-
HPIrq+ LinkChg+
            Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet-
Interlock-
            Changed: MRL- PresDet- LinkState-
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+
CRSVisible-
        RootCap: CRSVisible-
        RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF
Via WAKE# ARIFwd-
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+,
OBFF Disabled ARIFwd-
        LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-
    Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Address: fee00218  Data: 0000
    Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 1acd
    Capabilities: [a0] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Kernel driver in use: pcieport

00:1c.2 PCI bridge: Intel Corporation Wildcat Point-LP PCI Express Root
Port #3 (rev e3) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
    I/O behind bridge: 00004000-00004fff
    Memory behind bridge: a3200000-a32fffff
    Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0
            ExtTag- RBE+
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+
TransPend-
        LnkCap:    Port #3, Speed 5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s <512ns, L1 <16us
            ClockPM- Surprise- LLActRep+ BwNot+
        LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive+ BWMgmt+ ABWMgmt-
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug-
Surprise-
            Slot #2, PowerLimit 10.000W; Interlock- NoCompl+
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
HPIrq- LinkChg-
            Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+
Interlock-
            Changed: MRL- PresDet+ LinkState+
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+
CRSVisible-
        RootCap: CRSVisible-
        RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF
Not Supported ARIFwd-
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-,
OBFF Disabled ARIFwd-
        LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-
    Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Address: fee00238  Data: 0000
    Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 1acd
    Capabilities: [a0] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [100 v0] #00
    Capabilities: [200 v1] L1 PM Substates
        L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
L1_PM_Substates+
              PortCommonModeRestoreTime=40us PortTPowerOnTime=10us
    Kernel driver in use: pcieport

00:1c.3 PCI bridge: Intel Corporation Wildcat Point-LP PCI Express Root
Port #4 (rev e3) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
    I/O behind bridge: 0000f000-00000fff
    Memory behind bridge: a3100000-a31fffff
    Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0
            ExtTag- RBE+
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+
TransPend-
        LnkCap:    Port #4, Speed 5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s <512ns, L1 <16us
            ClockPM- Surprise- LLActRep+ BwNot+
        LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive+ BWMgmt+ ABWMgmt-
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug-
Surprise-
            Slot #3, PowerLimit 10.000W; Interlock- NoCompl+
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
HPIrq- LinkChg-
            Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+
Interlock-
            Changed: MRL- PresDet- LinkState+
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+
CRSVisible-
        RootCap: CRSVisible-
        RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF
Not Supported ARIFwd-
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+,
OBFF Disabled ARIFwd-
        LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-
    Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Address: fee00258  Data: 0000
    Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 1acd
    Capabilities: [a0] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [100 v0] #00
    Capabilities: [200 v1] L1 PM Substates
        L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
L1_PM_Substates+
              PortCommonModeRestoreTime=40us PortTPowerOnTime=10us
    Kernel driver in use: pcieport

00:1c.4 PCI bridge: Intel Corporation Wildcat Point-LP PCI Express Root
Port #5 (rev e3) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
    I/O behind bridge: 00003000-00003fff
    Memory behind bridge: a2000000-a30fffff
    Prefetchable memory behind bridge: 00000000c0000000-00000000d1ffffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0
            ExtTag- RBE+
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+
TransPend-
        LnkCap:    Port #5, Speed 5GT/s, Width x4, ASPM L0s L1, Exit
Latency L0s <512ns, L1 <16us
            ClockPM- Surprise- LLActRep+ BwNot+
        LnkCtl:    ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 5GT/s, Width x4, TrErr- Train- SlotClk+
DLActive+ BWMgmt+ ABWMgmt-
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug-
Surprise-
            Slot #4, PowerLimit 25.000W; Interlock- NoCompl+
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
HPIrq- LinkChg-
            Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+
Interlock-
            Changed: MRL- PresDet- LinkState+
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+
CRSVisible-
        RootCap: CRSVisible-
        RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF
Not Supported ARIFwd-
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+,
OBFF Disabled ARIFwd-
        LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-
    Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Address: fee00278  Data: 0000
    Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 1acd
    Capabilities: [a0] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [100 v0] #00
    Capabilities: [200 v1] L1 PM Substates
        L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
L1_PM_Substates+
              PortCommonModeRestoreTime=40us PortTPowerOnTime=10us
    Kernel driver in use: pcieport

00:1f.0 ISA bridge: Intel Corporation Wildcat Point-LP LPC Controller
(rev 03)
    Subsystem: ASUSTeK Computer Inc. Device 1acd
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Capabilities: [e0] Vendor Specific Information: Len=0c <?>
    Kernel driver in use: lpc_ich

00:1f.2 SATA controller: Intel Corporation Wildcat Point-LP SATA
Controller [AHCI Mode] (rev 03) (prog-if 01 [AHCI 1.0])
    Subsystem: ASUSTeK Computer Inc. Device 1acd
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin B routed to IRQ 47
    Region 0: I/O ports at 50b0 [size=8]
    Region 1: I/O ports at 50a0 [size=4]
    Region 2: I/O ports at 5090 [size=8]
    Region 3: I/O ports at 5080 [size=4]
    Region 4: I/O ports at 5060 [size=32]
    Region 5: Memory at a3322000 (32-bit, non-prefetchable) [size=2K]
    Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Address: fee002d8  Data: 0000
    Capabilities: [70] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold-)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
    Kernel driver in use: ahci

00:1f.3 SMBus: Intel Corporation Wildcat Point-LP SMBus Controller (rev 03)
    Subsystem: ASUSTeK Computer Inc. Device 1acd
    Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Interrupt: pin C routed to IRQ 5
    Region 0: Memory at a3321000 (64-bit, non-prefetchable) [size=256]
    Region 4: I/O ports at 5040 [size=32]

00:1f.6 Signal processing controller: Intel Corporation Wildcat Point-LP
Thermal Management Controller (rev 03)
    Subsystem: ASUSTeK Computer Inc. Device 1acd
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin C routed to IRQ 22
    Region 0: Memory at a3320000 (64-bit, non-prefetchable) [size=4K]
    Capabilities: [50] Power Management version 3
        Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
        Address: 00000000  Data: 0000
    Kernel driver in use: intel_pch_thermal

02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 10)
    Subsystem: ASUSTeK Computer Inc. Device 205f
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 48
    Region 0: I/O ports at 4000 [size=256]
    Region 2: Memory at a3204000 (64-bit, non-prefetchable) [size=4K]
    Region 4: Memory at a3200000 (64-bit, non-prefetchable) [size=16K]
    Capabilities: [40] Power Management version 3
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Address: 00000000fee002b8  Data: 0000
    Capabilities: [70] Express (v2) Endpoint, MSI 01
        DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s
<512ns, L1 <64us
            ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
            RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 4096 bytes
        DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+
TransPend-
        LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s unlimited, L1 <64us
            ClockPM+ Surprise- LLActRep- BwNot-
        LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
            ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
        DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR+, OBFF
Via message/WAKE#
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+,
OBFF Disabled
        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-
    Capabilities: [b0] MSI-X: Enable- Count=4 Masked-
        Vector table: BAR=4 offset=00000000
        PBA: BAR=4 offset=00000800
    Capabilities: [d0] Vital Product Data
        No end tag found
    Capabilities: [100 v15] #ffff
    Capabilities: [ffc v15] #ffff
    Capabilities: [ffc v15] <chain looped>
    Kernel driver in use: r8169

03:00.0 Network controller: Intel Corporation Wireless 7260 (rev bb)
    Subsystem: Intel Corporation Dual Band Wireless-AC 7260
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 50
    Region 0: Memory at a3100000 (64-bit, non-prefetchable) [size=8K]
    Capabilities: [c8] Power Management version 3
        Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Address: 00000000fee00358  Data: 0000
    Capabilities: [40] Express (v2) Endpoint, MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s
<512ns, L1 unlimited
            ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
            RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+ FLReset-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+
TransPend-
        LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s <4us, L1 <32us
            ClockPM+ Surprise- LLActRep- BwNot-
        LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
            ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
        DevCap2: Completion Timeout: Range B, TimeoutDis+, LTR+, OBFF
Via WAKE#
        DevCtl2: Completion Timeout: 16ms to 55ms, TimeoutDis-, LTR+,
OBFF Disabled
        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-
    Capabilities: [100 v1] Advanced Error Reporting
        UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
        CESta:    RxErr- BadTLP+ BadDLLP- Rollover- Timeout- NonFatalErr+
        CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
        AERCap:    First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
    Capabilities: [140 v1] Device Serial Number ac-fd-ce-ff-ff-5a-33-d1
    Capabilities: [14c v1] Latency Tolerance Reporting
        Max snoop latency: 3145728ns
        Max no snoop latency: 3145728ns
    Capabilities: [154 v1] Vendor Specific Information: ID=cafe Rev=1
Len=014 <?>
    Kernel driver in use: iwlwifi

04:00.0 3D controller: NVIDIA Corporation Device 139a (rev a2)
    Subsystem: ASUSTeK Computer Inc. Device 1acd
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 11
    Region 0: Memory at a2000000 (32-bit, non-prefetchable) [size=16M]
    Region 1: Memory at c0000000 (64-bit, prefetchable) [size=256M]
    Region 3: Memory at d0000000 (64-bit, prefetchable) [size=32M]
    Region 5: I/O ports at 3000 [size=128]
    Expansion ROM at a3000000 [disabled] [size=512K]
    Capabilities: [60] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [68] MSI: Enable- Count=1/1 Maskable- 64bit+
        Address: 0000000000000000  Data: 0000
    Capabilities: [78] Express (v2) Endpoint, MSI 00
        DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s
unlimited, L1 <64us
            ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
            RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
            MaxPayload 128 bytes, MaxReadReq 512 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr-
TransPend-
        LnkCap:    Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit
Latency L0s <512ns, L1 <4us
            ClockPM+ Surprise- LLActRep- BwNot-
        LnkCtl:    ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
            ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 5GT/s, Width x4, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
        DevCap2: Completion Timeout: Range AB, TimeoutDis+, LTR+, OBFF
Via message
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+,
OBFF Disabled
        LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-
    Capabilities: [100 v1] Virtual Channel
        Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
        Arb:    Fixed- WRR32- WRR64- WRR128-
        Ctrl:    ArbSelect=Fixed
        Status:    InProgress-
        VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
            Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
            Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
            Status:    NegoPending- InProgress-
    Capabilities: [250 v1] Latency Tolerance Reporting
        Max snoop latency: 3145728ns
        Max no snoop latency: 3145728ns
    Capabilities: [258 v1] L1 PM Substates
        L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
L1_PM_Substates+
              PortCommonModeRestoreTime=255us PortTPowerOnTime=10us
    Capabilities: [128 v1] Power Budgeting <?>
    Capabilities: [600 v1] Vendor Specific Information: ID=0001 Rev=1
Len=024 <?>
    Capabilities: [900 v1] #19

yogo@yogo-ordi:~$


[7.6.]
yogo@yogo-ordi:~$ cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: HGST HTS541010A7 Rev: A4A0
  Type:   Direct-Access                    ANSI  SCSI revision: 05
yogo@yogo-ordi:~$


[7.7.]

yogo@yogo-ordi:~$  ls /proc
1     1440  2027  2172  2562  398   557  78         cgroups      modules
10    1489  2033  2177  2568  410   561  780        cmdline      mounts
1015  15    2034  22    2579  4173  562  79         consoles     mtrr
1024  1519  2035  2207  26    4176  563  791        cpuinfo      net
1025  156   2038  2220  2671  43    565  8          crypto      
pagetypeinfo
1037  158   2041  2227  27    44    566  80         devices      partitions
104   159   2044  2231  2735  45    574  800        diskstats    sched_debug
1047  16    2046  2235  28    476   575  81         dma          schedstat
1049  160   2048  2237  2832  4816  60   82         driver       scsi
105   161   2050  2238  29    5     61   83         execdomains  self
1077  162   2069  2239  3     5078  614  84         fb           slabinfo
11    163   2073  2245  30    5120  62   844        filesystems  softirqs
1102  164   2082  2252  31    5139  63   845        fs           stat
1157  165   2096  2265  32    5215  64   85         interrupts   swaps
1173  1690  21    2272  329   5216  65   877        iomem        sys
1193  17    2100  2286  33    5249  66   9          ioports     
sysrq-trigger
1199  1700  2101  2290  334   5250  67   91         irq          sysvipc
12    172   2103  2295  34    5347  673  943        kallsyms     thread-self
1209  18    2121  23    35    5349  674  944        kcore        timer_list
1216  182   2123  232   36    5351  68   945        keys         timer_stats
1217  183   2125  2324  3683  5358  69   954        key-users    tty
1218  1892  2127  233   37    537   7    958        kmsg         uptime
1219  1896  2137  2332  3764  5384  70   959        kpagecgroup  version
1220  1967  2154  2374  3774  5385  71   967        kpagecount   vmallocinfo
1253  1978  2158  2399  3776  5386  72   968        kpageflags   vmstat
1270  1984  2159  25    38    5408  73   972        loadavg      zoneinfo
1281  1990  2160  2516  3805  5410  74   acpi       locks
1284  2     2162  2525  3869  5419  75   asound     mdstat
13    20    2169  2553  39    5420  76   buddyinfo  meminfo
1319  2013  2171  2557  397   5432  77   bus        misc
yogo@yogo-ordi:~$


Here is what I could find about the touchpad in /proc/bus/input/devices

I: Bus=0011 Vendor=0002 Product=0012 Version=0000
N: Name="FocalTechPS/2 FocalTech FocalTech Touchpad"
P: Phys=isa0060/serio1/input0
S: Sysfs=/devices/platform/i8042/serio1/input/input5
U: Uniq=
H: Handlers=mouse0 event4
B: PROP=5
B: EV=b
B: KEY=e520 10000 0 0 0 0
B: ABS=260800000000003

[X.]

Here is the link to my Launchpad bug report :
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1504445

I tried a solution given on internet but it doesn't work properly.

I created a file here /etc/pm/sleep.d/0000trackpad
sudo gedit /etc/pm/sleep.d/0000trackpad

and add the following
#!/bin/sh
case "$1" in
    suspend|hibernate)
        modprobe -r psmouse;
    resume|thaw)
        modprobe psmouse;
esac

With this file, the computer refuse to suspend. The touchpad keep
working so it does something but I can't make my computer sleeping...


I hope I filed this form properly,

Best regards,
Thatoo


--------------070306030108020709030503
Content-Type: application/pgp-keys;
 name="0x1BA5F17B.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0x1BA5F17B.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v2.0.22 (GNU/Linux)

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
UJQ68SFhXACni6LP8xeIM6Fc1eIWfyJPgUHrvRIl7LmhvpszTda/9nSl2fBWVquo
KfIJCPUh8o4QZwyXGVD1EfNoI7iSDCadXyjvfzRw04PeWEn9BeXjoaAm/ooXLJDT
OBHk0ljBXEVzLHTdOLqVfAUAahLuFvOdm5KJFWs/0v0P3Fn0w7XLmIakiFFkUXGw
jYN+JmraXpRdqkYU6n4qjxBQdsDVQrD5ThB2+OezWhkmYN2cKI8KFEf2ZHOOsR6e
oI+fjYetvnN8cKBrYDtwGkW7HuadEMNH5zTe3HAeK1YkcEO2u+1wmv63lbSZebH3
KVNDNydipNQPSV/GgVtMnUhovFVa9v2STeD5UNRSnFHpZoSJTUEORojU7UySIZrE
kWZi+BXqPwL+kEalQQSVluxeIS5ZMtsKSv6mWk+t1azFUqE/P4hdNUasOoDRyq3B
7E/QTulTdEoFTymRBToJaNFvfNTkWMI9IAyQp0QLuYuNO29g4hxtgF+MK3tLd0wH
Ojf1Y+D5be7JKvm3bemYswgXPd5yogXI242Q1EkohbgHyPv8mmrv5fVqGT82oH7R
/wAASOf/AABI4gEQAAEBAAAAAAAAAAAAAAAA/9j/4AAQSkZJRgABAQAAAQABAAD/
4QBARXhpZgAATU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAAqACAAQAAAABAAAA
2qADAAQAAAABAAAA2gAAAAD/2wBDAAIBAQIBAQICAQICAgICAwUDAwMDAwYEBAMF
BwYHBwcGBgYHCAsJBwgKCAYGCQ0JCgsLDAwMBwkNDg0MDgsMDAv/2wBDAQICAgMC
AwUDAwULCAYICwsLCwsLCwsLCwsLCwsLCwsLCwsLCwsLCwsLCwsLCwsLCwsLCwsL
CwsLCwsLCwsLCwv/wAARCADaANoDASIAAhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAA
AAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEG
E1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3ODk6Q0RF
RkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKj
pKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP0
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
/Drn8K24l+0W8DSbQWC7SHwd4+Xr7nt71yM+fegskSalbyxSiNtpAYMCCQPvEY9P
attssxJ38nPEh/xqpHbNt82VNrltyspyMNgHPYgHv71MJXUYCKQOM4PNBk3c/kyk
Q7wx4/GoZMk7V4xxk9Mc+leL/EH9rtbeeSD4eWiyDkfabkEg+6p6fWvN9S/aG8Ya
hNvOszw+0KrGP0FcKoSSuzqqY+lDrf0PqsruXLnocgGmXQJYYGTjivkb/hcninfu
/t7Us4x/rjUeo/FfxJq0Pl3+t6i6egmK/wAsUnQctzJ5nC2z/A+qNY1yx0O2Lavd
2tuifeMsoQgevJrz7xf+0F4btIZYrC4mvJBwPJj+U/RmxXz3c3kt5Juu5ZJW9XYk
/rUdOOGitzGeZyfwxseua1+1K7xRJ4f0pI/JjKK08pb8cDH8656X4t6v491u3g1u
ZIbMtuMEA2I5A/i5y34muEqWyuTZ3ccsfVDmnLDwUWorWxOGzGcK9OpUd4qSbXkn
c/SL4NeC4fgp+yHea/LB/wATDUNPbUZmx8534WFPoFZTj1Y1b0W9fSrS2uEJ+4qu
B3HrXQ3fiC0+JH7GIfSpI2ik0y0jyOg2PECP0xiue8Pwi70UJMOFXLHHJr5HHSUH
CPlqfqeBqyxMqtZ7tnb+HtTF0o3HMT4AOev1r2L4N6BFqVv5GmSDzpG4JxkfhXzT
oWrSaPKV3M0WcqfSvWvgj8QxpmpQhJzHKh3LJnG7nP8ASvOrwbi7H0uBqxqvXdH6
W/s4fs06Vr+nRzaskbAKiyoAD5gI569M19WeEP2ONC0oW15oCqIwoLIYxuB9/avg
v4C/tUnwxLarcTKsDhVyrZDeuf8AGvt/4OftHQ69bQ/ZrrzECBXBfPT/APXU5c8N
zOGIjqcGf0sx5FUwM7LqrHq+m/D+38MSFYGIV+VB5VT6j0+lXYLl7/UI7PTU/eSD
BkHRPc/SuD1b41299qUemaC73N/Mf3ccYLbR3Legr1L4caAdF03zr8tJd3Q3yOeQ
PYewr6bCqnObjSXurf8AyPzbMYV8JT9ri3eb2T/P0Pm79pX4beCv2w/HPjb9m79o
O2vF0PxHottqekXcY8q4trqEg/a7OVgQJY5GQ7hkAjawIYg/hR+2j+wr4n/Yk/aP
ufhf8WL6I6xMi3fh/UjCUs/FNkzsonhIyY5FK7ZYjnY2MEqysf6VvilosEmoaN4h
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
3Rh/WcD1g0eeF4Vfa3yyHw==
=d8kM
-----END PGP PUBLIC KEY BLOCK-----

--------------070306030108020709030503--
