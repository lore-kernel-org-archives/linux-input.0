From: Carlo Abelli <carlo.abelli@gmail.com>
Subject: (unknown)
Date: Mon, 1 Jun 2015 20:03:47 -0400
Message-ID: <CA+d0YZJ12Ypb7gAx+bvQtdG4-ZOF1GsBSP2SLNHZz1Nmzg97nQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:38228 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754295AbbFBAEJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 1 Jun 2015 20:04:09 -0400
Received: by igbjd9 with SMTP id jd9so74749491igb.1
        for <linux-input@vger.kernel.org>; Mon, 01 Jun 2015 17:04:08 -0700 (PDT)
Subject: 
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

[1.] One line summary of the problem:
[ASUS UX305FA] Some Fn+ Keys Not Working

[2.] Full description of the problem/report:
Brightness control keys and Airplane mode key on Asus UX305F laptop
not being recognized (including no output from acpi_listen). Other
function keys do work and are recognized e.g. volume

[3.] Keywords (i.e., modules, networking, kernel):

[4.] Kernel version (from /proc/version):
Linux version 4.1.0-040100rc6-generic (kernel@gloin) (gcc version
4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201506010235 SMP Mon Jun 1
02:36:59 UTC 2015

[5.] Output of Oops.. message (if applicable) with symbolic
information resolved (see Documentation/oops-tracing.txt):

[6.] A small shell script or example program which triggers the
problem (if possible):

[7.] Environment:
Description:    Ubuntu 15.04
Release:    15.04

[7.1.] Software (add the output of the ver_linux script here):
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux carloabelli-UX305FA 4.1.0-040100rc6-generic #201506010235 SMP
Mon Jun 1 02:36:59 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux

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
Modules Loaded         ctr ccm rfcomm bnep nls_iso8859_1
snd_hda_codec_hdmi uvcvideo videobuf2_vmalloc videobuf2_memops
videobuf2_core arc4 v4l2_common videodev media asus_nb_wmi asus_wmi
joydev sparse_keymap intel_rapl iosf_mbi x86_pkg_temp_thermal
intel_powerclamp coretemp iwlmvm kvm_intel mac80211 kvm snd_soc_rt5640
snd_soc_rl6231 crct10dif_pclmul snd_soc_core crc32_pclmul i915
ghash_clmulni_intel aesni_intel aes_x86_64 snd_hda_codec_conexant lrw
snd_hda_codec_generic snd_compress gf128mul snd_pcm_dmaengine
glue_helper iwlwifi btusb ablk_helper cryptd btbcm snd_hda_intel
snd_seq_midi btintel snd_hda_controller snd_seq_midi_event
drm_kms_helper snd_hda_codec bluetooth snd_hda_core serio_raw
snd_hwdep snd_rawmidi cfg80211 drm mei_me snd_pcm mei shpchp
i2c_algo_bit lpc_ich processor_thermal_device wmi snd_seq
snd_seq_device snd_timer snd int3403_thermal soundcore i2c_hid dw_dmac
hid dw_dmac_core i2c_designware_platform 8250_dw i2c_designware_core
snd_soc_sst_acpi video spi_pxa2xx_platform int3402_thermal
int3400_thermal tpm_crb acpi_pad int340x_thermal_zone acpi_thermal_rel
mac_hid parport_pc ppdev lp parport autofs4 psmouse ahci libahci
sdhci_acpi sdhci

[7.2.] Processor information (from /proc/cpuinfo):
processor    : 0
vendor_id    : GenuineIntel
cpu family    : 6
model        : 61
model name    : Intel(R) Core(TM) M-5Y10c CPU @ 0.80GHz
stepping    : 4
microcode    : 0x1d
cpu MHz        : 812.421
cache size    : 4096 KB
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
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts
rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq
dtes64 monitor ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c
rdrand lahf_lm abm 3dnowprefetch ida arat epb pln pts dtherm intel_pt
tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2
smep bmi2 erms invpcid rdseed adx smap xsaveopt
bugs        :
bogomips    : 1995.42
clflush size    : 64
cache_alignment    : 64
address sizes    : 39 bits physical, 48 bits virtual
power management:

processor    : 1
vendor_id    : GenuineIntel
cpu family    : 6
model        : 61
model name    : Intel(R) Core(TM) M-5Y10c CPU @ 0.80GHz
stepping    : 4
microcode    : 0x1d
cpu MHz        : 800.039
cache size    : 4096 KB
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
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts
rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq
dtes64 monitor ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c
rdrand lahf_lm abm 3dnowprefetch ida arat epb pln pts dtherm intel_pt
tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2
smep bmi2 erms invpcid rdseed adx smap xsaveopt
bugs        :
bogomips    : 1995.42
clflush size    : 64
cache_alignment    : 64
address sizes    : 39 bits physical, 48 bits virtual
power management:

processor    : 2
vendor_id    : GenuineIntel
cpu family    : 6
model        : 61
model name    : Intel(R) Core(TM) M-5Y10c CPU @ 0.80GHz
stepping    : 4
microcode    : 0x1d
cpu MHz        : 821.093
cache size    : 4096 KB
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
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts
rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq
dtes64 monitor ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c
rdrand lahf_lm abm 3dnowprefetch ida arat epb pln pts dtherm intel_pt
tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2
smep bmi2 erms invpcid rdseed adx smap xsaveopt
bugs        :
bogomips    : 1995.42
clflush size    : 64
cache_alignment    : 64
address sizes    : 39 bits physical, 48 bits virtual
power management:

processor    : 3
vendor_id    : GenuineIntel
cpu family    : 6
model        : 61
model name    : Intel(R) Core(TM) M-5Y10c CPU @ 0.80GHz
stepping    : 4
microcode    : 0x1d
cpu MHz        : 1561.718
cache size    : 4096 KB
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
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts
rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq
dtes64 monitor ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c
rdrand lahf_lm abm 3dnowprefetch ida arat epb pln pts dtherm intel_pt
tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2
smep bmi2 erms invpcid rdseed adx smap xsaveopt
bugs        :
bogomips    : 1995.42
clflush size    : 64
cache_alignment    : 64
address sizes    : 39 bits physical, 48 bits virtual
power management:

[7.3.] Module information (from /proc/modules):
ctr 16384 2 - Live 0x0000000000000000
ccm 20480 2 - Live 0x0000000000000000
rfcomm 77824 8 - Live 0x0000000000000000
bnep 24576 2 - Live 0x0000000000000000
nls_iso8859_1 16384 1 - Live 0x0000000000000000
snd_hda_codec_hdmi 53248 1 - Live 0x0000000000000000
uvcvideo 94208 0 - Live 0x0000000000000000
videobuf2_vmalloc 16384 1 uvcvideo, Live 0x0000000000000000
videobuf2_memops 16384 1 videobuf2_vmalloc, Live 0x0000000000000000
videobuf2_core 53248 1 uvcvideo, Live 0x0000000000000000
arc4 16384 2 - Live 0x0000000000000000
v4l2_common 16384 1 videobuf2_core, Live 0x0000000000000000
videodev 172032 3 uvcvideo,videobuf2_core,v4l2_common, Live 0x0000000000000000
media 24576 2 uvcvideo,videodev, Live 0x0000000000000000
asus_nb_wmi 24576 0 - Live 0x0000000000000000
asus_wmi 28672 1 asus_nb_wmi, Live 0x0000000000000000
joydev 20480 0 - Live 0x0000000000000000
sparse_keymap 16384 1 asus_wmi, Live 0x0000000000000000
intel_rapl 20480 0 - Live 0x0000000000000000
iosf_mbi 16384 1 intel_rapl, Live 0x0000000000000000
x86_pkg_temp_thermal 16384 0 - Live 0x0000000000000000
intel_powerclamp 16384 0 - Live 0x0000000000000000
coretemp 16384 0 - Live 0x0000000000000000
iwlmvm 307200 0 - Live 0x0000000000000000
kvm_intel 159744 0 - Live 0x0000000000000000
mac80211 786432 1 iwlmvm, Live 0x0000000000000000
kvm 507904 1 kvm_intel, Live 0x0000000000000000
snd_soc_rt5640 94208 0 - Live 0x0000000000000000
snd_soc_rl6231 16384 1 snd_soc_rt5640, Live 0x0000000000000000
crct10dif_pclmul 16384 0 - Live 0x0000000000000000
snd_soc_core 204800 1 snd_soc_rt5640, Live 0x0000000000000000
crc32_pclmul 16384 0 - Live 0x0000000000000000
i915 1146880 4 - Live 0x0000000000000000
ghash_clmulni_intel 16384 0 - Live 0x0000000000000000
aesni_intel 172032 4 - Live 0x0000000000000000
aes_x86_64 20480 1 aesni_intel, Live 0x0000000000000000
snd_hda_codec_conexant 24576 1 - Live 0x0000000000000000
lrw 16384 1 aesni_intel, Live 0x0000000000000000
snd_hda_codec_generic 77824 1 snd_hda_codec_conexant, Live 0x0000000000000000
snd_compress 20480 1 snd_soc_core, Live 0x0000000000000000
gf128mul 16384 1 lrw, Live 0x0000000000000000
snd_pcm_dmaengine 16384 1 snd_soc_core, Live 0x0000000000000000
glue_helper 16384 1 aesni_intel, Live 0x0000000000000000
iwlwifi 217088 1 iwlmvm, Live 0x0000000000000000
btusb 49152 0 - Live 0x0000000000000000
ablk_helper 16384 1 aesni_intel, Live 0x0000000000000000
cryptd 24576 3 ghash_clmulni_intel,aesni_intel,ablk_helper, Live
0x0000000000000000
btbcm 16384 1 btusb, Live 0x0000000000000000
snd_hda_intel 32768 5 - Live 0x0000000000000000
snd_seq_midi 16384 0 - Live 0x0000000000000000
btintel 16384 1 btusb, Live 0x0000000000000000
snd_hda_controller 36864 1 snd_hda_intel, Live 0x0000000000000000
snd_seq_midi_event 16384 1 snd_seq_midi, Live 0x0000000000000000
drm_kms_helper 126976 1 i915, Live 0x0000000000000000
snd_hda_codec 122880 5
snd_hda_codec_hdmi,snd_hda_codec_conexant,snd_hda_codec_generic,snd_hda_intel,snd_hda_controller,
Live 0x0000000000000000
bluetooth 540672 24 rfcomm,bnep,btusb,btbcm,btintel, Live 0x0000000000000000
snd_hda_core 36864 5
snd_hda_codec_hdmi,snd_hda_codec_conexant,snd_hda_codec_generic,snd_hda_controller,snd_hda_codec,
Live 0x0000000000000000
serio_raw 16384 0 - Live 0x0000000000000000
snd_hwdep 16384 1 snd_hda_codec, Live 0x0000000000000000
snd_rawmidi 32768 1 snd_seq_midi, Live 0x0000000000000000
cfg80211 589824 3 iwlmvm,mac80211,iwlwifi, Live 0x0000000000000000
drm 352256 5 i915,drm_kms_helper, Live 0x0000000000000000
mei_me 24576 0 - Live 0x0000000000000000
snd_pcm 110592 7
snd_hda_codec_hdmi,snd_soc_rt5640,snd_soc_core,snd_pcm_dmaengine,snd_hda_intel,snd_hda_controller,snd_hda_codec,
Live 0x0000000000000000
mei 94208 1 mei_me, Live 0x0000000000000000
shpchp 40960 0 - Live 0x0000000000000000
i2c_algo_bit 16384 1 i915, Live 0x0000000000000000
lpc_ich 24576 0 - Live 0x0000000000000000
processor_thermal_device 16384 0 - Live 0x0000000000000000
wmi 20480 1 asus_wmi, Live 0x0000000000000000
snd_seq 69632 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
snd_seq_device 16384 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x0000000000000000
snd_timer 32768 2 snd_pcm,snd_seq, Live 0x0000000000000000
snd 86016 23 snd_hda_codec_hdmi,snd_soc_core,snd_hda_codec_conexant,snd_hda_codec_generic,snd_compress,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_rawmidi,snd_pcm,snd_seq,snd_seq_device,snd_timer,
Live 0x0000000000000000
int3403_thermal 16384 0 - Live 0x0000000000000000
soundcore 16384 1 snd, Live 0x0000000000000000
i2c_hid 20480 0 - Live 0x0000000000000000
dw_dmac 16384 0 - Live 0x0000000000000000
hid 122880 1 i2c_hid, Live 0x0000000000000000
dw_dmac_core 32768 1 dw_dmac, Live 0x0000000000000000
i2c_designware_platform 16384 0 - Live 0x0000000000000000
8250_dw 16384 0 - Live 0x0000000000000000
i2c_designware_core 16384 1 i2c_designware_platform, Live 0x0000000000000000
snd_soc_sst_acpi 16384 0 - Live 0x0000000000000000
video 28672 2 asus_wmi,i915, Live 0x0000000000000000
spi_pxa2xx_platform 24576 0 - Live 0x0000000000000000
int3402_thermal 16384 0 - Live 0x0000000000000000
int3400_thermal 16384 0 - Live 0x0000000000000000
tpm_crb 16384 0 - Live 0x0000000000000000
acpi_pad 20480 0 - Live 0x0000000000000000
int340x_thermal_zone 16384 3
processor_thermal_device,int3403_thermal,int3402_thermal, Live
0x0000000000000000
acpi_thermal_rel 16384 1 int3400_thermal, Live 0x0000000000000000
mac_hid 16384 0 - Live 0x0000000000000000
parport_pc 36864 0 - Live 0x0000000000000000
ppdev 20480 0 - Live 0x0000000000000000
lp 20480 0 - Live 0x0000000000000000
parport 45056 3 parport_pc,ppdev,lp, Live 0x0000000000000000
autofs4 40960 2 - Live 0x0000000000000000
psmouse 135168 0 - Live 0x0000000000000000
ahci 36864 3 - Live 0x0000000000000000
libahci 32768 1 ahci, Live 0x0000000000000000
sdhci_acpi 16384 0 - Live 0x0000000000000000
sdhci 45056 1 sdhci_acpi, Live 0x0000000000000000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem):
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
00100000-d4d03fff : System RAM
  02000000-02811e5c : Kernel code
  02811e5d-02f34fbf : Kernel data
  030a6000-031e8fff : Kernel bss
d4d04000-d5067fff : reserved
d5068000-daa56fff : System RAM
daa57000-daab5fff : reserved
daab6000-db2d0fff : System RAM
db2d1000-dc413fff : ACPI Non-volatile Storage
dc414000-dcee3fff : reserved
dcee4000-dcffdfff : reserved
dcffe000-dcffefff : System RAM
dcfff000-dcffffff : MSFT0101:00
dd000000-dd7fffff : RAM buffer
dd800000-dfffffff : reserved
  de000000-dfffffff : Graphics Stolen Memory
e0000000-feafffff : PCI Bus 0000:00
  e0000000-efffffff : 0000:00:02.0
  f6000000-f6ffffff : 0000:00:02.0
  f7000000-f70fffff : PCI Bus 0000:02
    f7000000-f7001fff : 0000:02:00.0
      f7000000-f7001fff : iwlwifi
  f7100000-f710ffff : 0000:00:14.0
    f7100000-f710ffff : xhci-hcd
  f7110000-f7117fff : 0000:00:04.0
  f7118000-f711bfff : 0000:00:1b.0
    f7118000-f711bfff : ICH HD audio
  f711c000-f711ffff : 0000:00:03.0
    f711c000-f711ffff : ICH HD audio
  f7120000-f71200ff : 0000:00:1f.3
  f7121000-f71217ff : 0000:00:1f.2
    f7121000-f71217ff : ahci
  f7123000-f712301f : 0000:00:16.0
    f7123000-f712301f : mei_me
  f7fe0000-f7feffff : pnp 00:06
  f7ff0000-f7ffffff : pnp 00:06
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
fed70000-fed70fff : MSFT0101:00
fed90000-fed90fff : dmar0
fed91000-fed91fff : dmar1
fee00000-fee00fff : Local APIC
  fee00000-fee00fff : reserved
ff000000-ffffffff : reserved
  ff000000-ffffffff : INT0800:00
    ff000000-ffffffff : pnp 00:06
100000000-21effffff : System RAM
21f000000-21fffffff : RAM buffer

[7.5.] PCI information ('lspci -vvv' as root):
00:00.0 Host bridge: Intel Corporation Broadwell-U Host Bridge -OPI (rev 09)
    Subsystem: ASUSTeK Computer Inc. Device 181d
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR- INTx-
    Latency: 0
    Capabilities: [e0] Vendor Specific Information: Len=0c <?>

00:02.0 VGA compatible controller: Intel Corporation Broadwell-U
Integrated Graphics (rev 09) (prog-if 00 [VGA controller])
    Subsystem: ASUSTeK Computer Inc. Device 181d
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 49
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
    Subsystem: ASUSTeK Computer Inc. Device 181d
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 50
    Region 0: Memory at f711c000 (64-bit, non-prefetchable) [size=16K]
    Capabilities: [50] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Address: fee003d8  Data: 0000
    Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0
            ExtTag- RBE-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
    Kernel driver in use: snd_hda_intel

00:04.0 Signal processing controller: Intel Corporation Broadwell-U
Camarillo Device (rev 09)
    Subsystem: ASUSTeK Computer Inc. Device 181d
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 16
    Region 0: Memory at f7110000 (64-bit, non-prefetchable) [size=32K]
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
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 44
    Region 0: Memory at f7100000 (64-bit, non-prefetchable) [size=64K]
    Capabilities: [70] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
        Address: 00000000fee00318  Data: 0000
    Kernel driver in use: xhci_hcd

00:16.0 Communication controller: Intel Corporation Wildcat Point-LP
MEI Controller #1 (rev 03)
    Subsystem: ASUSTeK Computer Inc. Device 181d
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 46
    Region 0: Memory at f7123000 (64-bit, non-prefetchable) [size=32]
    Capabilities: [50] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Address: 00000000fee00358  Data: 0000
    Kernel driver in use: mei_me

00:1b.0 Audio device: Intel Corporation Wildcat Point-LP High
Definition Audio Controller (rev 03)
    Subsystem: ASUSTeK Computer Inc. Device 181d
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 32, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 47
    Region 0: Memory at f7118000 (64-bit, non-prefetchable) [size=16K]
    Capabilities: [50] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Address: 00000000fee00398  Data: 0000
    Kernel driver in use: snd_hda_intel

00:1c.0 PCI bridge: Intel Corporation Wildcat Point-LP PCI Express
Root Port #1 (rev e3) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
    I/O behind bridge: 0000f000-00000fff
    Memory behind bridge: fff00000-000fffff
    Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [40] Express (v2) Root Port (Slot-), MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0
            ExtTag- RBE+
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
        LnkCap:    Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s <1us, L1 <4us
            ClockPM- Surprise- LLActRep+ BwNot+
        LnkCtl:    ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk-
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
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
             EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
    Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Address: fee002b8  Data: 0000
    Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 181d
    Capabilities: [a0] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Kernel driver in use: pcieport

00:1c.3 PCI bridge: Intel Corporation Wildcat Point-LP PCI Express
Root Port #4 (rev e3) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
    I/O behind bridge: 0000f000-00000fff
    Memory behind bridge: f7000000-f70fffff
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
        DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
        LnkCap:    Port #4, Speed 5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s <512ns, L1 <16us
            ClockPM- Surprise- LLActRep+ BwNot+
        LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive+ BWMgmt+ ABWMgmt-
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
            Slot #3, PowerLimit 10.000W; Interlock- NoCompl+
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
HPIrq- LinkChg-
            Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
            Changed: MRL- PresDet- LinkState+
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
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
             EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
    Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Address: fee002f8  Data: 0000
    Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 181d
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

00:1f.0 ISA bridge: Intel Corporation Wildcat Point-LP LPC Controller (rev 03)
    Subsystem: ASUSTeK Computer Inc. Device 181d
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Capabilities: [e0] Vendor Specific Information: Len=0c <?>
    Kernel driver in use: lpc_ich

00:1f.2 SATA controller: Intel Corporation Wildcat Point-LP SATA
Controller [AHCI Mode] (rev 03) (prog-if 01 [AHCI 1.0])
    Subsystem: ASUSTeK Computer Inc. Device 181d
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin B routed to IRQ 45
    Region 0: I/O ports at f0b0 [size=8]
    Region 1: I/O ports at f0a0 [size=4]
    Region 2: I/O ports at f090 [size=8]
    Region 3: I/O ports at f080 [size=4]
    Region 4: I/O ports at f060 [size=32]
    Region 5: Memory at f7121000 (32-bit, non-prefetchable) [size=2K]
    Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Address: fee00338  Data: 0000
    Capabilities: [70] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold-)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
    Kernel driver in use: ahci

00:1f.3 SMBus: Intel Corporation Wildcat Point-LP SMBus Controller (rev 03)
    Subsystem: ASUSTeK Computer Inc. Device 181d
    Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Interrupt: pin C routed to IRQ 255
    Region 0: Memory at f7120000 (64-bit, non-prefetchable) [size=256]
    Region 4: I/O ports at f040 [size=32]

02:00.0 Network controller: Intel Corporation Wireless 7265 (rev 59)
    Subsystem: Intel Corporation Dual Band Wireless-AC 7265
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 48
    Region 0: Memory at f7000000 (64-bit, non-prefetchable) [size=8K]
    Capabilities: [c8] Power Management version 3
        Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Address: 00000000fee003b8  Data: 0000
    Capabilities: [40] Express (v2) Endpoint, MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s
<512ns, L1 unlimited
            ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+ FLReset-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
        LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L1, Exit
Latency L0s <4us, L1 <32us
            ClockPM+ Surprise- LLActRep- BwNot-
        LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
            ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
        DevCap2: Completion Timeout: Range B, TimeoutDis+, LTR+, OBFF Via WAKE#
        DevCtl2: Completion Timeout: 16ms to 55ms, TimeoutDis-, LTR+,
OBFF Disabled
        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
    Capabilities: [100 v1] Advanced Error Reporting
        UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
        CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
        CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
        AERCap:    First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
    Capabilities: [140 v1] Device Serial Number 34-02-86-ff-ff-5d-d3-ce
    Capabilities: [14c v1] Latency Tolerance Reporting
        Max snoop latency: 3145728ns
        Max no snoop latency: 3145728ns
    Capabilities: [154 v1] L1 PM Substates
        L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
L1_PM_Substates+
              PortCommonModeRestoreTime=30us PortTPowerOnTime=60us
    Kernel driver in use: iwlwifi

[7.6.] SCSI information (from /proc/scsi/scsi):
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: SanDisk SD7SN3Q2 Rev: 0002
  Type:   Direct-Access                    ANSI  SCSI revision: 05

[7.7.] Other information that might be relevant to the problem (please
look in /proc and include all information that you think to be
relevant):
1     1391  1530  1847    25   371  653  782      execdomains    sched_debug
10    1394  1531  1848    253  38   654  787      fb        schedstat
1001  1397  1587  1857    257  39   67   8      filesystems    scsi
1005  1399  1591  1862    26   40   676  800      fs        self
1069  14    1592  1868    27   41   678  806      interrupts    slabinfo
11    1408  1594  1877    28   42   68   814      iomem        softirqs
1199  1415  1600  1893    29   43   680  820      ioports    stat
12    142   1608  19    3    44   681  871      irq        swaps
1200  1425  1613  1903    301  45   69   9      kallsyms    sys
1205  1434  1620  1905    302  458  691  929      kcore        sysrq-trigger
1207  1452  1624  1985    304  46   698  942      keys        sysvipc
1286  1473  1650  199    31   47   7    95      key-users    thread-self
1294  1474  1659  2    310  48   70   96      kmsg        timer_list
13    1475  166   20    315  49   708  acpi      kpagecount    timer_stats
1306  1476  1666  2019    316  5      71   asound      kpageflags    tty
1333  1477  167   21    319  50   724  buddyinfo  loadavg    uptime
1335  148   1671  2119    32   51   736  bus      locks        version
1340  1480  1684  2120    321  53   738  cgroups      mdstat    vmallocinfo
1344  1482  17      2122    33   54   739  cmdline      meminfo    vmstat
1347  1484  1718  2126    34   55   75   consoles   misc        zoneinfo
1349  149   1736  2139    35   6      76   cpuinfo      modules
1350  1491  1761  2140    355  630  777  crypto      mounts
1363  15    18      2145    356  633  778  devices      mtrr
1375  150   1811  22    359  638  779  diskstats  net
1376  1502  1819  24    36   640  780  dma      pagetypeinfo
1390  151   1838  248    37   644  781  driver      partitions

[X.] Other notes, patches, fixes, workarounds:
https://bugs.launchpad.net/bugs/1458351
