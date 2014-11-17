From: Ben Lansdell <ben.lansdell@gmail.com>
Subject: [ASUS X550LA] The trackpad is not recognized
Date: Sun, 16 Nov 2014 22:37:02 -0800
Message-ID: <CAE-8=5gU5NuhKTEMUBayLQ6Gewyavzg1GRiCCh5f=WsoDRQKUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:41127 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbaKQGhD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Nov 2014 01:37:03 -0500
Received: by mail-pa0-f50.google.com with SMTP id bj1so1400363pad.37
        for <linux-input@vger.kernel.org>; Sun, 16 Nov 2014 22:37:02 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

[1.] [ASUS X550LA] The trackpad is not recognized

[2.] Touchpad is detected as a mouse. It works but with no multi-touch
or scrolling functionality.

xinput --list
=E2=8E=A1 Virtual core pointer                          id=3D2    [mast=
er pointer  (3)]
=E2=8E=9C   =E2=86=B3 Virtual core XTEST pointer                id=3D4 =
   [slave  pointer  (2)]
=E2=8E=9C   =E2=86=B3 PS/2 FocalTech FocalTech Touchpad in mouse emulat=
ion mode id=3D13
 [slave  pointer  (2)]

This bug exists on kernel 3.18-rc4

[3.]

[4.] Linux version 3.18.0-031800rc4-generic (apw@gomeisa) (gcc version
4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201411091835 SMP Sun Nov 9
23:36:36 UTC 2014

[5.] n/a

[6.] n/a

[7.] lsb_release -rd
Description: Ubuntu 14.04.1 LTS
Release: 14.04

[7.1.] sh ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux juneau 3.18.0-031800rc4-generic #201411091835 SMP Sun Nov 9
23:36:36 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux

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
Modules Loaded         ctr ccm rfcomm bnep bluetooth binfmt_misc
nls_iso8859_1 snd_hda_codec_realtek snd_hda_codec_hdmi
snd_hda_codec_generic snd_soc_rt5640 snd_soc_rl6231 snd_hda_intel
intel_rapl snd_soc_core snd_hda_controller arc4 snd_hda_codec
snd_compress snd_pcm_dmaengine snd_hwdep snd_pcm snd_seq_midi
snd_seq_midi_event rt2800pci x86_pkg_temp_thermal rt2800mmio
snd_rawmidi intel_powerclamp rt2800lib coretemp rt2x00pci rt2x00mmio
kvm_intel rt2x00lib kvm asus_nb_wmi crct10dif_pclmul asus_wmi mac80211
i915 snd_seq crc32_pclmul cfg80211 ghash_clmulni_intel aesni_intel
uvcvideo aes_x86_64 sparse_keymap lrw videobuf2_vmalloc snd_seq_device
snd_timer videobuf2_memops gf128mul eeprom_93cx6 videobuf2_core
i2c_hid v4l2_common crc_ccitt drm_kms_helper snd drm videodev
glue_helper ablk_helper i2c_designware_platform serio_raw cryptd media
i2c_designware_core parport_pc soundcore ppdev wmi i2c_algo_bit
dm_multipath rtsx_pci_ms snd_soc_sst_acpi lp dw_dmac mei_me
dw_dmac_core memstick mei parport lpc_ich 8250_dw video
int3400_thermal int3402_thermal acpi_thermal_rel scsi_dh
spi_pxa2xx_platform mac_hid hid_logitech_dj usbhid hid rtsx_pci_sdmmc
psmouse ahci r8169 rtsx_pci libahci mii sdhci_acpi sdhci

[7.2.] cat /proc/cpuinfo
processor : 0
vendor_id : GenuineIntel
cpu family : 6
model : 69
model name : Intel(R) Core(TM) i5-4200U CPU @ 1.60GHz
stepping : 1
microcode : 0x17
cpu MHz : 1499.941
cache size : 3072 KB
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
bogomips : 4588.97
clflush size : 64
cache_alignment : 64
address sizes : 39 bits physical, 48 bits virtual
power management:

processor : 1
vendor_id : GenuineIntel
cpu family : 6
model : 69
model name : Intel(R) Core(TM) i5-4200U CPU @ 1.60GHz
stepping : 1
microcode : 0x17
cpu MHz : 1500.031
cache size : 3072 KB
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
bogomips : 4588.97
clflush size : 64
cache_alignment : 64
address sizes : 39 bits physical, 48 bits virtual
power management:

processor : 2
vendor_id : GenuineIntel
cpu family : 6
model : 69
model name : Intel(R) Core(TM) i5-4200U CPU @ 1.60GHz
stepping : 1
microcode : 0x17
cpu MHz : 1500.121
cache size : 3072 KB
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
bogomips : 4588.97
clflush size : 64
cache_alignment : 64
address sizes : 39 bits physical, 48 bits virtual
power management:

processor : 3
vendor_id : GenuineIntel
cpu family : 6
model : 69
model name : Intel(R) Core(TM) i5-4200U CPU @ 1.60GHz
stepping : 1
microcode : 0x17
cpu MHz : 1500.121
cache size : 3072 KB
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
bogomips : 4588.97
clflush size : 64
cache_alignment : 64
address sizes : 39 bits physical, 48 bits virtual
power management:

[7.3.] cat /proc/modules
ctr 13193 1 - Live 0x0000000000000000
ccm 17856 1 - Live 0x0000000000000000
rfcomm 75066 0 - Live 0x0000000000000000
bnep 23980 2 - Live 0x0000000000000000
bluetooth 486890 10 rfcomm,bnep, Live 0x0000000000000000
binfmt_misc 17501 1 - Live 0x0000000000000000
nls_iso8859_1 12713 1 - Live 0x0000000000000000
snd_hda_codec_realtek 80418 1 - Live 0x0000000000000000
snd_hda_codec_hdmi 52670 1 - Live 0x0000000000000000
snd_hda_codec_generic 69995 1 snd_hda_codec_realtek, Live 0x00000000000=
00000
snd_soc_rt5640 93325 0 - Live 0x0000000000000000
snd_soc_rl6231 13037 1 snd_soc_rt5640, Live 0x0000000000000000
snd_hda_intel 30783 5 - Live 0x0000000000000000
intel_rapl 19196 0 - Live 0x0000000000000000
snd_soc_core 207596 1 snd_soc_rt5640, Live 0x0000000000000000
snd_hda_controller 32234 1 snd_hda_intel, Live 0x0000000000000000
arc4 12573 2 - Live 0x0000000000000000
snd_hda_codec 144641 5
snd_hda_codec_realtek,snd_hda_codec_hdmi,snd_hda_codec_generic,snd_hda_=
intel,snd_hda_controller,
Live 0x0000000000000000
snd_compress 19395 1 snd_soc_core, Live 0x0000000000000000
snd_pcm_dmaengine 15229 1 snd_soc_core, Live 0x0000000000000000
snd_hwdep 17709 1 snd_hda_codec, Live 0x0000000000000000
snd_pcm 106273 7
snd_hda_codec_hdmi,snd_soc_rt5640,snd_hda_intel,snd_soc_core,snd_hda_co=
ntroller,snd_hda_codec,snd_pcm_dmaengine,
Live 0x0000000000000000
snd_seq_midi 13564 0 - Live 0x0000000000000000
snd_seq_midi_event 14899 1 snd_seq_midi, Live 0x0000000000000000
rt2800pci 13674 0 - Live 0x0000000000000000
x86_pkg_temp_thermal 14312 0 - Live 0x0000000000000000
rt2800mmio 21082 1 rt2800pci, Live 0x0000000000000000
snd_rawmidi 31197 1 snd_seq_midi, Live 0x0000000000000000
intel_powerclamp 19099 0 - Live 0x0000000000000000
rt2800lib 95583 2 rt2800pci,rt2800mmio, Live 0x0000000000000000
coretemp 13638 0 - Live 0x0000000000000000
rt2x00pci 13287 1 rt2800pci, Live 0x0000000000000000
rt2x00mmio 13661 2 rt2800pci,rt2800mmio, Live 0x0000000000000000
kvm_intel 149984 0 - Live 0x0000000000000000
rt2x00lib 56113 5 rt2800pci,rt2800mmio,rt2800lib,rt2x00pci,rt2x00mmio,
Live 0x0000000000000000
kvm 475233 1 kvm_intel, Live 0x0000000000000000
asus_nb_wmi 21128 0 - Live 0x0000000000000000
crct10dif_pclmul 14268 0 - Live 0x0000000000000000
asus_wmi 24697 1 asus_nb_wmi, Live 0x0000000000000000
mac80211 697143 3 rt2800lib,rt2x00pci,rt2x00lib, Live 0x000000000000000=
0
i915 1031913 7 - Live 0x0000000000000000
snd_seq 63540 2 snd_seq_midi,snd_seq_midi_event, Live 0x000000000000000=
0
crc32_pclmul 13180 0 - Live 0x0000000000000000
cfg80211 520257 2 rt2x00lib,mac80211, Live 0x0000000000000000
ghash_clmulni_intel 13230 0 - Live 0x0000000000000000
aesni_intel 169686 2 - Live 0x0000000000000000
uvcvideo 86723 0 - Live 0x0000000000000000
aes_x86_64 17131 1 aesni_intel, Live 0x0000000000000000
sparse_keymap 13890 1 asus_wmi, Live 0x0000000000000000
lrw 13323 1 aesni_intel, Live 0x0000000000000000
videobuf2_vmalloc 13216 1 uvcvideo, Live 0x0000000000000000
snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x0000000=
000000000
snd_timer 30118 2 snd_pcm,snd_seq, Live 0x0000000000000000
videobuf2_memops 13362 1 videobuf2_vmalloc, Live 0x0000000000000000
gf128mul 14951 1 lrw, Live 0x0000000000000000
eeprom_93cx6 13344 1 rt2800pci, Live 0x0000000000000000
videobuf2_core 51547 1 uvcvideo, Live 0x0000000000000000
i2c_hid 19065 0 - Live 0x0000000000000000
v4l2_common 15715 1 videobuf2_core, Live 0x0000000000000000
crc_ccitt 12707 1 rt2800lib, Live 0x0000000000000000
drm_kms_helper 99802 1 i915, Live 0x0000000000000000
snd 84025 23 snd_hda_codec_realtek,snd_hda_codec_hdmi,snd_hda_codec_gen=
eric,snd_hda_intel,snd_soc_core,snd_hda_codec,snd_compress,snd_hwdep,sn=
d_pcm,snd_rawmidi,snd_seq,snd_seq_device,snd_timer,
Live 0x0000000000000000
drm 323675 6 i915,drm_kms_helper, Live 0x0000000000000000
videodev 163831 3 uvcvideo,videobuf2_core,v4l2_common, Live 0x000000000=
0000000
glue_helper 14095 1 aesni_intel, Live 0x0000000000000000
ablk_helper 13597 1 aesni_intel, Live 0x0000000000000000
i2c_designware_platform 13025 0 - Live 0x0000000000000000
serio_raw 13483 0 - Live 0x0000000000000000
cryptd 20531 3 ghash_clmulni_intel,aesni_intel,ablk_helper, Live
0x0000000000000000
media 22008 2 uvcvideo,videodev, Live 0x0000000000000000
i2c_designware_core 14990 1 i2c_designware_platform, Live 0x00000000000=
00000
parport_pc 32909 0 - Live 0x0000000000000000
soundcore 15091 2 snd_hda_codec,snd, Live 0x0000000000000000
ppdev 17711 0 - Live 0x0000000000000000
wmi 19379 1 asus_wmi, Live 0x0000000000000000
i2c_algo_bit 13564 1 i915, Live 0x0000000000000000
dm_multipath 23188 0 - Live 0x0000000000000000
rtsx_pci_ms 18337 0 - Live 0x0000000000000000
snd_soc_sst_acpi 13007 0 - Live 0x0000000000000000
lp 17799 0 - Live 0x0000000000000000
dw_dmac 12835 0 - Live 0x0000000000000000
mei_me 19565 0 - Live 0x0000000000000000
dw_dmac_core 28558 1 dw_dmac, Live 0x0000000000000000
memstick 16968 1 rtsx_pci_ms, Live 0x0000000000000000
mei 88473 1 mei_me, Live 0x0000000000000000
parport 42481 3 parport_pc,ppdev,lp, Live 0x0000000000000000
lpc_ich 21176 0 - Live 0x0000000000000000
8250_dw 13474 0 - Live 0x0000000000000000
video 20649 2 asus_wmi,i915, Live 0x0000000000000000
int3400_thermal 13040 0 - Live 0x0000000000000000
int3402_thermal 13060 0 - Live 0x0000000000000000
acpi_thermal_rel 13807 1 int3400_thermal, Live 0x0000000000000000
scsi_dh 14873 1 dm_multipath, Live 0x0000000000000000
spi_pxa2xx_platform 23256 0 - Live 0x0000000000000000
mac_hid 13275 0 - Live 0x0000000000000000
hid_logitech_dj 18569 0 - Live 0x0000000000000000
usbhid 53155 0 - Live 0x0000000000000000
hid 110572 4 i2c_hid,hid_logitech_dj,usbhid, Live 0x0000000000000000
rtsx_pci_sdmmc 23718 0 - Live 0x0000000000000000
psmouse 118117 0 - Live 0x0000000000000000
ahci 34220 3 - Live 0x0000000000000000
r8169 86907 0 - Live 0x0000000000000000
rtsx_pci 51162 2 rtsx_pci_ms,rtsx_pci_sdmmc, Live 0x0000000000000000
libahci 32446 1 ahci, Live 0x0000000000000000
mii 13981 1 r8169, Live 0x0000000000000000
sdhci_acpi 13502 0 - Live 0x0000000000000000
sdhci 43929 1 sdhci_acpi, Live 0x0000000000000000

[7.4.] cat /proc/ioports
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
  0240-0259 : pnp 00:05
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
  3000-3fff : PCI Bus 0000:03
  e000-efff : PCI Bus 0000:02
    e000-e0ff : 0000:02:00.1
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

cat /proc/iomem
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
000f0000-000fffff : System ROM
00100000-d5be1fff : System RAM
  02000000-027b1c17 : Kernel code
  027b1c18-02d19c7f : Kernel data
  02e80000-02fc8fff : Kernel bss
d5be2000-d5be8fff : ACPI Non-volatile Storage
d5be9000-d63f6fff : System RAM
d63f7000-d664ffff : reserved
d6650000-d9961fff : System RAM
d9962000-d9b56fff : reserved
d9b57000-d9e94fff : System RAM
d9e95000-dab5dfff : ACPI Non-volatile Storage
dab5e000-daf59fff : reserved
daf5a000-daffefff : reserved
dafff000-daffffff : System RAM
db000000-dbbfffff : RAM buffer
dbc00000-dfdfffff : reserved
  dbe00000-dfdfffff : Graphics Stolen Memory
dfe00000-feafffff : PCI Bus 0000:00
  dfe00000-dfffffff : PCI Bus 0000:01
  e0000000-efffffff : 0000:00:02.0
  f0000000-f01fffff : PCI Bus 0000:01
  f0200000-f03fffff : PCI Bus 0000:02
  f0400000-f05fffff : PCI Bus 0000:03
  f7800000-f7bfffff : 0000:00:02.0
  f7c00000-f7cfffff : PCI Bus 0000:03
    f7c00000-f7c0ffff : 0000:03:00.1
    f7c10000-f7c1ffff : 0000:03:00.0
      f7c10000-f7c1ffff : 0000:03:00.0
  f7d00000-f7dfffff : PCI Bus 0000:02
    f7d00000-f7d0ffff : 0000:02:00.0
    f7d10000-f7d13fff : 0000:02:00.1
      f7d10000-f7d13fff : r8169
    f7d14000-f7d14fff : 0000:02:00.1
      f7d14000-f7d14fff : r8169
    f7d15000-f7d15fff : 0000:02:00.0
      f7d15000-f7d15fff : rtsx_pci
  f7e00000-f7e0ffff : 0000:00:14.0
    f7e00000-f7e0ffff : xhci-hcd
  f7e10000-f7e17fff : 0000:00:04.0
  f7e18000-f7e1bfff : 0000:00:1b.0
    f7e18000-f7e1bfff : ICH HD audio
  f7e1c000-f7e1ffff : 0000:00:03.0
    f7e1c000-f7e1ffff : ICH HD audio
  f7e20000-f7e20fff : 0000:00:1f.6
  f7e21000-f7e210ff : 0000:00:1f.3
  f7e22000-f7e227ff : 0000:00:1f.2
    f7e22000-f7e227ff : ahci
  f7e23000-f7e233ff : 0000:00:1d.0
    f7e23000-f7e233ff : ehci_hcd
  f7e25000-f7e2501f : 0000:00:16.0
    f7e25000-f7e2501f : mei_me
  f7fdf000-f7fdffff : pnp 00:09
  f7fe0000-f7feffff : pnp 00:09
  f8000000-fbffffff : PCI MMCONFIG 0000 [bus 00-3f]
    f8000000-fbffffff : reserved
      f8000000-fbffffff : pnp 00:09
fec00000-fec00fff : reserved
  fec00000-fec003ff : IOAPIC 0
fed00000-fed03fff : reserved
  fed00000-fed003ff : HPET 0
    fed00000-fed003ff : PNP0103:00
fed10000-fed17fff : pnp 00:09
fed18000-fed18fff : pnp 00:09
fed19000-fed19fff : pnp 00:09
fed1c000-fed1ffff : reserved
  fed1c000-fed1ffff : pnp 00:09
    fed1f410-fed1f414 : iTCO_wdt
fed20000-fed3ffff : pnp 00:09
fed40000-fed44fff : pnp 00:00
fed45000-fed8ffff : pnp 00:09
fed90000-fed93fff : pnp 00:09
fee00000-fee00fff : Local APIC
  fee00000-fee00fff : reserved
ff000000-ffffffff : reserved
  ff000000-ffffffff : INT0800:00
    ff000000-ffffffff : pnp 00:09
100000000-21f1fffff : System RAM
21f200000-21fffffff : RAM buffer

[7.5.] sudo lspci -vvv
00:02.0 VGA compatible controller: Intel Corporation Haswell-ULT
Integrated Graphics Controller (rev 09) (prog-if 00 [VGA controller])
Subsystem: ASUSTeK Computer Inc. Device 131d
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 45
Region 0: Memory at f7800000 (64-bit, non-prefetchable) [size=3D4M]
Region 2: Memory at e0000000 (64-bit, prefetchable) [size=3D256M]
Region 4: I/O ports at f000 [size=3D64]
Expansion ROM at <unassigned> [disabled]
Capabilities: [90] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
Address: fee0100c  Data: 4122
Capabilities: [d0] Power Management version 2
=46lags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D=
3cold-)
Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
Capabilities: [a4] PCI Advanced Features
AFCap: TP+ FLR+
AFCtrl: FLR-
AFStatus: TP-
Kernel driver in use: i915

00:03.0 Audio device: Intel Corporation Haswell-ULT HD Audio Controller=
 (rev 09)
Subsystem: ASUSTeK Computer Inc. Device 131d
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 47
Region 0: Memory at f7e1c000 (64-bit, non-prefetchable) [size=3D16K]
Capabilities: [50] Power Management version 2
=46lags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D=
3cold-)
Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
Capabilities: [60] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
Address: fee0f00c  Data: 41c3
Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 0=
0
DevCap: MaxPayload 128 bytes, PhantFunc 0
ExtTag- RBE-
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
Kernel driver in use: snd_hda_intel

00:04.0 Signal processing controller: Intel Corporation Device 0a03 (re=
v 09)
Subsystem: ASUSTeK Computer Inc. Device 131d
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 255
Region 0: Memory at f7e10000 (64-bit, non-prefetchable) [size=3D32K]
Capabilities: [90] MSI: Enable- Count=3D1/1 Maskable- 64bit-
Address: 00000000  Data: 0000
Capabilities: [d0] Power Management version 3
=46lags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D=
3cold-)
Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
Capabilities: [e0] Vendor Specific Information: Len=3D0c <?>

00:14.0 USB controller: Intel Corporation Lynx Point-LP USB xHCI HC
(rev 04) (prog-if 30 [XHCI])
Subsystem: ASUSTeK Computer Inc. Device 201f
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 40
Region 0: Memory at f7e00000 (64-bit, non-prefetchable) [size=3D64K]
Capabilities: [70] Power Management version 2
=46lags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA PME(D0-,D1-,D2-,D3hot+=
,D3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
Capabilities: [80] MSI: Enable+ Count=3D1/8 Maskable- 64bit+
Address: 00000000fee0f00c  Data: 41d3
Kernel driver in use: xhci_hcd

00:16.0 Communication controller: Intel Corporation Lynx Point-LP HECI
#0 (rev 04)
Subsystem: ASUSTeK Computer Inc. Device 131d
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 44
Region 0: Memory at f7e25000 (64-bit, non-prefetchable) [size=3D32]
Capabilities: [50] Power Management version 3
=46lags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
Capabilities: [8c] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
Address: 00000000fee0f00c  Data: 41a3
Kernel driver in use: mei_me

00:1b.0 Audio device: Intel Corporation Lynx Point-LP HD Audio
Controller (rev 04)
Subsystem: ASUSTeK Computer Inc. Device 11af
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 46
Region 0: Memory at f7e18000 (64-bit, non-prefetchable) [size=3D16K]
Capabilities: [50] Power Management version 3
=46lags: PMEClk- DSI- D1- D2- AuxCurrent=3D55mA PME(D0+,D1-,D2-,D3hot+,=
D3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
Capabilities: [60] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
Address: 00000000fee0f00c  Data: 41b3
Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 0=
0
DevCap: MaxPayload 128 bytes, PhantFunc 0
ExtTag- RBE-
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
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
Ctrl: Enable- ID=3D2 ArbSelect=3DFixed TC/VC=3D04
Status: NegoPending- InProgress-
Kernel driver in use: snd_hda_intel

00:1c.0 PCI bridge: Intel Corporation Lynx Point-LP PCI Express Root
Port 1 (rev e4) (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
I/O behind bridge: 0000f000-00000fff
Memory behind bridge: fff00000-000fffff
Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: [40] Express (v2) Root Port (Slot-), MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0
ExtTag- RBE+
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
LnkCap: Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s
<1us, L1 <4us
ClockPM- Surprise- LLActRep+ BwNot+
LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk-
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-
RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
RootCap: CRSVisible-
RootSta: PME ReqID 0000, PMEStatus- PMEPending-
DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Via
WAKE# ARIFwd-
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF
Disabled ARIFwd-
LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
 Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
ComplianceSOS-
 Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
EqualizationPhase1-
 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [80] MSI: Enable- Count=3D1/1 Maskable- 64bit-
Address: 00000000  Data: 0000
Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 131d
Capabilities: [a0] Power Management version 3
=46lags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
Kernel driver in use: pcieport

00:1c.2 PCI bridge: Intel Corporation Lynx Point-LP PCI Express Root
Port 3 (rev e4) (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Bus: primary=3D00, secondary=3D02, subordinate=3D02, sec-latency=3D0
I/O behind bridge: 0000e000-0000efff
Memory behind bridge: f7d00000-f7dfffff
Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
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
LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
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
DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Not
Supported ARIFwd-
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF
Disabled ARIFwd-
LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
 Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
ComplianceSOS-
 Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
EqualizationPhase1-
 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [80] MSI: Enable- Count=3D1/1 Maskable- 64bit-
Address: 00000000  Data: 0000
Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 131d
Capabilities: [a0] Power Management version 3
=46lags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
Capabilities: [100 v0] #00
Capabilities: [200 v1] L1 PM Substates
L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substat=
es+
  PortCommonModeRestoreTime=3D40us PortTPowerOnTime=3D10us
Kernel driver in use: pcieport

00:1c.3 PCI bridge: Intel Corporation Lynx Point-LP PCI Express Root
Port 4 (rev e4) (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Bus: primary=3D00, secondary=3D03, subordinate=3D03, sec-latency=3D0
I/O behind bridge: 0000f000-00000fff
Memory behind bridge: f7c00000-f7cfffff
Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
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
Changed: MRL- PresDet- LinkState+
RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
RootCap: CRSVisible-
RootSta: PME ReqID 0000, PMEStatus- PMEPending-
DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Not
Supported ARIFwd-
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF
Disabled ARIFwd-
LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
 Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
ComplianceSOS-
 Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
EqualizationPhase1-
 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [80] MSI: Enable- Count=3D1/1 Maskable- 64bit-
Address: 00000000  Data: 0000
Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 131d
Capabilities: [a0] Power Management version 3
=46lags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
Capabilities: [100 v0] #00
Capabilities: [200 v1] L1 PM Substates
L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substat=
es+
  PortCommonModeRestoreTime=3D40us PortTPowerOnTime=3D10us
Kernel driver in use: pcieport

00:1d.0 USB controller: Intel Corporation Lynx Point-LP USB EHCI #1
(rev 04) (prog-if 20 [EHCI])
Subsystem: ASUSTeK Computer Inc. Device 201f
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 23
Region 0: Memory at f7e23000 (32-bit, non-prefetchable) [size=3D1K]
Capabilities: [50] Power Management version 3
=46lags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA PME(D0+,D1-,D2-,D3hot+=
,D3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
Capabilities: [58] Debug port: BAR=3D1 offset=3D00a0
Capabilities: [98] PCI Advanced Features
AFCap: TP+ FLR+
AFCtrl: FLR-
AFStatus: TP-
Kernel driver in use: ehci-pci

00:1f.0 ISA bridge: Intel Corporation Lynx Point-LP LPC Controller (rev=
 04)
Subsystem: ASUSTeK Computer Inc. Device 131d
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Capabilities: [e0] Vendor Specific Information: Len=3D0c <?>
Kernel driver in use: lpc_ich

00:1f.2 SATA controller: Intel Corporation Lynx Point-LP SATA
Controller 1 [AHCI mode] (rev 04) (prog-if 01 [AHCI 1.0])
Subsystem: ASUSTeK Computer Inc. Device 131d
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin B routed to IRQ 42
Region 0: I/O ports at f0b0 [size=3D8]
Region 1: I/O ports at f0a0 [size=3D4]
Region 2: I/O ports at f090 [size=3D8]
Region 3: I/O ports at f080 [size=3D4]
Region 4: I/O ports at f060 [size=3D32]
Region 5: Memory at f7e22000 (32-bit, non-prefetchable) [size=3D2K]
Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
Address: fee0500c  Data: 41c1
Capabilities: [70] Power Management version 3
=46lags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot+,D=
3cold-)
Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=3D00000004
Kernel driver in use: ahci

00:1f.3 SMBus: Intel Corporation Lynx Point-LP SMBus Controller (rev 04=
)
Subsystem: ASUSTeK Computer Inc. Device 131d
Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Interrupt: pin C routed to IRQ 255
Region 0: Memory at f7e21000 (64-bit, non-prefetchable) [size=3D256]
Region 4: I/O ports at f040 [size=3D32]

00:1f.6 Signal processing controller: Intel Corporation Lynx Point-LP
Thermal (rev 04)
Subsystem: ASUSTeK Computer Inc. Device 131d
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin C routed to IRQ 255
Region 0: Memory at f7e20000 (64-bit, non-prefetchable) [size=3D4K]
Capabilities: [50] Power Management version 3
=46lags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D=
3cold-)
Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
Capabilities: [80] MSI: Enable- Count=3D1/1 Maskable- 64bit-
Address: 00000000  Data: 0000

02:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd.
Device 5287 (rev 01)
Subsystem: ASUSTeK Computer Inc. Device 202f
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin B routed to IRQ 41
Region 0: Memory at f7d15000 (32-bit, non-prefetchable) [size=3D4K]
Expansion ROM at f7d00000 [disabled] [size=3D64K]
Capabilities: [40] Power Management version 3
=46lags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0-,D1+,D2+,D3hot+=
,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
Capabilities: [50] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
Address: 00000000fee0100c  Data: 41b1
Capabilities: [70] Express (v2) Endpoint, MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 512 bytes
DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency
L0s unlimited, L1 <64us
ClockPM+ Surprise- LLActRep- BwNot-
LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk-
ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-
DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR+, OBFF Via
message/WAKE#
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Disa=
bled
LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
 Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
ComplianceSOS-
 Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
EqualizationPhase1-
 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [b0] MSI-X: Enable- Count=3D1 Masked-
Vector table: BAR=3D0 offset=3D00000000
PBA: BAR=3D0 offset=3D00000000
Capabilities: [d0] Vital Product Data
Not readable
Capabilities: [100 v2] Advanced Error Reporting
UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
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
Ctrl: Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3D01
Status: NegoPending- InProgress-
Capabilities: [160 v1] Device Serial Number 00-00-00-00-00-00-00-00
Capabilities: [170 v1] Latency Tolerance Reporting
Max snoop latency: 3145728ns
Max no snoop latency: 3145728ns
Capabilities: [178 v1] L1 PM Substates
L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substat=
es+
  PortCommonModeRestoreTime=3D150us PortTPowerOnTime=3D150us
Kernel driver in use: rtsx_pci

02:00.1 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 12)
Subsystem: ASUSTeK Computer Inc. Device 200f
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 43
Region 0: I/O ports at e000 [size=3D256]
Region 2: Memory at f7d14000 (64-bit, non-prefetchable) [size=3D4K]
Region 4: Memory at f7d10000 (64-bit, non-prefetchable) [size=3D16K]
Capabilities: [40] Power Management version 3
=46lags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0+,D1+,D2+,D3hot+=
,D3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
Capabilities: [50] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
Address: 00000000fee0f00c  Data: 41d1
Capabilities: [70] Express (v2) Endpoint, MSI 01
DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 4096 bytes
DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency
L0s unlimited, L1 <64us
ClockPM+ Surprise- LLActRep- BwNot-
LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-
DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR+, OBFF Via
message/WAKE#
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disa=
bled
LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
EqualizationPhase1-
 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [b0] MSI-X: Enable- Count=3D4 Masked-
Vector table: BAR=3D4 offset=3D00000000
PBA: BAR=3D4 offset=3D00000800
Capabilities: [d0] Vital Product Data
Unknown small resource type 00, will not decode more.
Capabilities: [100 v2] Advanced Error Reporting
UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
Capabilities: [160 v1] Device Serial Number 18-72-72-11-68-4c-e0-00
Capabilities: [170 v1] Latency Tolerance Reporting
Max snoop latency: 3145728ns
Max no snoop latency: 3145728ns
Capabilities: [178 v1] L1 PM Substates
L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substat=
es+
  PortCommonModeRestoreTime=3D150us PortTPowerOnTime=3D150us
Kernel driver in use: r8169

03:00.0 Network controller: Ralink corp. RT3290 Wireless 802.11n 1T/1R =
PCIe
Subsystem: Foxconn International, Inc. Device e055
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 19
Region 0: Memory at f7c10000 (32-bit, non-prefetchable) [size=3D64K]
Capabilities: [40] Power Management version 3
=46lags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA PME(D0+,D1-,D2-,D3hot+=
,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
Capabilities: [50] MSI: Enable- Count=3D1/32 Maskable- 64bit+
Address: 0000000000000000  Data: 0000
Capabilities: [70] Express (v2) Endpoint, MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <128ns, L1 <2us
ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 512 bytes
DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency
L0s <512ns, L1 <64us
ClockPM+ Surprise- LLActRep- BwNot-
LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-
DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR-, OBFF
Not Supported
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disa=
bled
LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
 Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
ComplianceSOS-
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
CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
Capabilities: [140 v1] Device Serial Number 00-00-d5-be-57-30-35-54
Kernel driver in use: rt2800pci

03:00.1 Bluetooth: Ralink corp. RT3290 Bluetooth
Subsystem: Foxconn International, Inc. Device e056
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 255
Region 0: Memory at f7c00000 (32-bit, non-prefetchable) [size=3D64K]
Capabilities: [40] Power Management version 3
=46lags: PMEClk- DSI- D1+ D2- AuxCurrent=3D375mA PME(D0+,D1+,D2-,D3hot+=
,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
Capabilities: [50] MSI: Enable- Count=3D1/32 Maskable- 64bit+
Address: 0000000000000000  Data: 0000
Capabilities: [70] Express (v2) Endpoint, MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <128ns, L1 <2us
ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 512 bytes
DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency
L0s <512ns, L1 <64us
ClockPM+ Surprise- LLActRep- BwNot-
LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-
DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR-, OBFF
Not Supported
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disa=
bled
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
CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
Capabilities: [140 v1] Device Serial Number 00-00-d6-be-57-30-35-54
[7.6.] cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST1000LM024 HN-M Rev: 0001
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: Slimtype Model: DVD A  DA8A5SH-L Rev: RAA1
  Type:   CD-ROM                           ANSI  SCSI revision: 05
[7.7.] ls /proc
1      11698  13077  1453  1777  1928  2048  2221  25    2819  2940
41    5393  8    acpi         interrupts  mounts         timer_list
10     11816  13121  1459  1779  1936  2051  2229  2527  2821  298
414   54    818  asound       iomem       mtrr           timer_stats
1018   11821  13395  146   18    1940  2055  2231  2546  2822  3
415   5417  837  buddyinfo    ioports     net            tty
1022   12     13653  1467  1847  1964  2060  2234  2548  2826  304
4189  55    844  bus          irq         pagetypeinfo   uptime
1029   1229   13727  147   1856  1965  2091  2244  2570  2827  3072
42    595   871  cgroups      kallsyms    partitions     version
1030   1272   13729  148   1864  1967  2097  2245  2578  2829  31
43    596   872  cmdline      kcore       sched_debug    vmallocinfo
1033   12749  1386   149   1883  1976  21    2249  26    2849  3180
4391  642   897  consoles     keys        schedstat      vmstat
1095   1275   13929  15    1897  1994  2101  2254  2605  2853  32
44    645   9    cpuinfo      key-users   scsi           zoneinfo
1096   12766  14     150   1898  2     2114  2259  2610  2866  33
45    6544  902  crypto       kmsg        self
11     12780  14175  151   19    20    2177  2265  2616  2885  34
46    6590  903  devices      kpagecount  slabinfo
1106   12817  142    1513  1903  2017  2179  2277  2633  2890  35
47    67    909  diskstats    kpageflags  softirqs
1108   1295   14214  1545  1910  2024  2181  2283  27    29    36
48    688   91   dma          loadavg     stat
1111   1297   143    156   1914  2028  2193  2292  2738  2921  37    5
    69    919  driver       locks       swaps
1119   13     14337  163   1917  2036  2196  2397  2781  2925  38
50    7     92   execdomains  mdstat      sys
1136   13019  144    17    1918  2038  22    2398  28    2928  39
509   7031  926  fb           meminfo     sysrq-trigger
11446  13028  14477  172   1923  2039  2200  24    2809  2933  40
53    71    986  filesystems  misc        sysvipc
1167   13029  145    173   1924  2041  2212  2402  2818  2936  407
530   749   990  fs           modules     thread-self

[X.]
Launchpad bug report:

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1391023

With previous kernels experienced similar issues, but not identical.
=46or instance, 3.16.0, the trackpad was not recognized at all. A
workaround in this case was to boot the kernel with the option
psmouse.proto=3Dbare, which would give basic touchpad functionality, an=
d
again no multitouch or scrolling.

I have not tested all kernels between 3.16 and 3.18-rc4 to determine
when the change in behaviour occurred... the psmouse.proto=3Dbare
workaround is not required with 3.18-rc4 to have a basic touchpad.

Let me know if you need any more information.

Regards,
Ben
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
