From: Tudor Holton <tudor@tudorholton.com>
Subject: [Dell Venue 11 Pro 7140] Power button not working
Date: Tue, 28 Jul 2015 20:31:28 +1000
Message-ID: <55B75A00.9090101@tudorholton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ns1.tudorholton.com ([70.85.129.169]:55224 "EHLO
	server1.tudorejo.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S932094AbbG1LWD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Jul 2015 07:22:03 -0400
Received: from 252.85.96.58.static.exetel.com.au ([58.96.85.252]:58796 helo=[192.168.1.109])
	by server1.tudorejo.org with esmtpsa (TLSv1.2:DHE-RSA-AES128-SHA:128)
	(Exim 4.85)
	(envelope-from <tudor@tudorholton.com>)
	id 1ZK2AV-0003hB-4m
	for linux-input@vger.kernel.org; Tue, 28 Jul 2015 10:31:32 +0000
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

[1.] One line summary of the problem:
When pressing the power button on the Dell Venue 11 Pro 7140 there is no 
reaction and nothing appears to be triggered.  The ff_pwr_btn interrupt 
appears to be invalid.


[2.] Full description of the problem/report:

Power button appears to be detected, but not signal is registered by 
evtest, showkeys, or dmesg.

$sudo evtest /dev/input/event1
Input driver version is 1.0.1
Input device ID: bus 0x19 vendor 0x0 product 0x1 version 0x0
Input device name: "Power Button"
Supported events:
   Event type 0 (EV_SYN)
   Event type 1 (EV_KEY)
     Event code 116 (KEY_POWER)
Properties:
Testing ... (interrupt to exit)
[Pressing button gives no output]

$cat /sys/firmware/acpi/interrupts/ff_pwr_btn
        0 invalid

[3.] Keywords

[4.] Kernel version (from /proc/version):
Linux version 4.2.0-040200rc4-generic (kernel@gomeisa) (gcc version 
4.8.4 (Ubuntu 4.8.4-2ubuntu1~14.04) ) #201507271733 SMP Mon Jul 27 
21:35:06 UTC 2015


[5.] Output of Oops.. message
N/A

[6.] A small shell script or example program which triggers the problem 
(if possible)


[7.] Environment
Description:    Ubuntu 15.04
Release:    15.04


[7.1.] Software

$ sh ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux kneetm 4.2.0-040200rc4-generic #201507271733 SMP Mon Jul 27 
21:35:06 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux

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
Modules Loaded         drbg ansi_cprng ctr ccm nls_iso8859_1 cmac rfcomm 
bnep snd_hda_codec_hdmi snd_soc_sst_broadwell uvcvideo videobuf2_vmalloc 
joydev hid_generic videobuf2_memops btusb hid_multitouch videobuf2_core 
btrtl btbcm v4l2_common btintel videodev bluetooth usbhid media 
snd_soc_sst_haswell_pcm dell_wmi snd_soc_sst_ipc sparse_keymap 
snd_soc_sst_dsp intel_rapl x86_pkg_temp_thermal intel_powerclamp 
coretemp kvm_intel kvm arc4 dell_laptop dcdbas crct10dif_pclmul 
crc32_pclmul ghash_clmulni_intel aesni_intel aes_x86_64 lrw gf128mul 
glue_helper ablk_helper cryptd input_leds serio_raw iwlmvm mac80211 
iwlwifi cfg80211 i915 snd_soc_rt286 snd_soc_rl6347a snd_soc_core shpchp 
lpc_ich snd_compress ac97_bus snd_hda_intel drm_kms_helper 
snd_pcm_dmaengine snd_hda_codec snd_seq_midi drm snd_seq_midi_event 
snd_hda_core snd_rawmidi snd_hwdep snd_seq mei_me snd_pcm i2c_algo_bit 
mei snd_seq_device snd_timer wmi snd mac_hid soundcore i2c_hid hid 
soc_button_array snd_soc_sst_acpi dw_dmac processor_thermal_device 
i2c_designware_platform 8250_fintek intel_soc_dts_iosf int3403_thermal 
dw_dmac_core int3400_thermal video tpm_crb i2c_designware_core dell_rbtn 
iosf_mbi 8250_dw spi_pxa2xx_platform acpi_als int3402_thermal acpi_pad 
acpi_thermal_rel int340x_thermal_zone kfifo_buf industrialio parport_pc 
ppdev lp parport autofs4 mmc_block ahci libahci sdhci_pci sdhci_acpi sdhci

[7.2.] Processor information (from /proc/cpuinfo):

$ cat /proc/cpuinfo
processor    : 0
vendor_id    : GenuineIntel
cpu family    : 6
model        : 61
model name    : Intel(R) Core(TM) M-5Y71 CPU @ 1.20GHz
stepping    : 4
microcode    : 0x18
cpu MHz        : 1371.015
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
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall 
nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 
x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm 
abm 3dnowprefetch ida arat epb pln pts dtherm intel_pt tpr_shadow vnmi 
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms 
invpcid rtm rdseed adx smap xsaveopt
bugs        :
bogomips    : 2793.30
clflush size    : 64
cache_alignment    : 64
address sizes    : 39 bits physical, 48 bits virtual
power management:

processor    : 1
vendor_id    : GenuineIntel
cpu family    : 6
model        : 61
model name    : Intel(R) Core(TM) M-5Y71 CPU @ 1.20GHz
stepping    : 4
microcode    : 0x18
cpu MHz        : 1385.070
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
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall 
nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 
x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm 
abm 3dnowprefetch ida arat epb pln pts dtherm intel_pt tpr_shadow vnmi 
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms 
invpcid rtm rdseed adx smap xsaveopt
bugs        :
bogomips    : 2793.30
clflush size    : 64
cache_alignment    : 64
address sizes    : 39 bits physical, 48 bits virtual
power management:

processor    : 2
vendor_id    : GenuineIntel
cpu family    : 6
model        : 61
model name    : Intel(R) Core(TM) M-5Y71 CPU @ 1.20GHz
stepping    : 4
microcode    : 0x18
cpu MHz        : 813.093
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
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall 
nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 
x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm 
abm 3dnowprefetch ida arat epb pln pts dtherm intel_pt tpr_shadow vnmi 
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms 
invpcid rtm rdseed adx smap xsaveopt
bugs        :
bogomips    : 2793.30
clflush size    : 64
cache_alignment    : 64
address sizes    : 39 bits physical, 48 bits virtual
power management:

processor    : 3
vendor_id    : GenuineIntel
cpu family    : 6
model        : 61
model name    : Intel(R) Core(TM) M-5Y71 CPU @ 1.20GHz
stepping    : 4
microcode    : 0x18
cpu MHz        : 1095.390
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
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall 
nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 
x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm 
abm 3dnowprefetch ida arat epb pln pts dtherm intel_pt tpr_shadow vnmi 
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms 
invpcid rtm rdseed adx smap xsaveopt
bugs        :
bogomips    : 2793.30
clflush size    : 64
cache_alignment    : 64
address sizes    : 39 bits physical, 48 bits virtual
power management:

[7.3.] Module information (from /proc/modules):
$ cat /proc/modules
drbg 28672 1 - Live 0x0000000000000000
ansi_cprng 16384 0 - Live 0x0000000000000000
ctr 16384 2 - Live 0x0000000000000000
ccm 20480 2 - Live 0x0000000000000000
nls_iso8859_1 16384 1 - Live 0x0000000000000000
cmac 16384 2 - Live 0x0000000000000000
rfcomm 69632 8 - Live 0x0000000000000000
bnep 20480 2 - Live 0x0000000000000000
snd_hda_codec_hdmi 49152 1 - Live 0x0000000000000000
snd_soc_sst_broadwell 16384 0 - Live 0x0000000000000000
uvcvideo 90112 0 - Live 0x0000000000000000
videobuf2_vmalloc 16384 1 uvcvideo, Live 0x0000000000000000
joydev 20480 0 - Live 0x0000000000000000
hid_generic 16384 0 - Live 0x0000000000000000
videobuf2_memops 16384 1 videobuf2_vmalloc, Live 0x0000000000000000
btusb 45056 0 - Live 0x0000000000000000
hid_multitouch 20480 0 - Live 0x0000000000000000
videobuf2_core 49152 1 uvcvideo, Live 0x0000000000000000
btrtl 16384 1 btusb, Live 0x0000000000000000
btbcm 16384 1 btusb, Live 0x0000000000000000
v4l2_common 16384 1 videobuf2_core, Live 0x0000000000000000
btintel 16384 1 btusb, Live 0x0000000000000000
videodev 172032 3 uvcvideo,videobuf2_core,v4l2_common, Live 
0x0000000000000000
bluetooth 507904 25 rfcomm,bnep,btusb,btrtl,btbcm,btintel, Live 
0x0000000000000000
usbhid 49152 0 - Live 0x0000000000000000
media 24576 2 uvcvideo,videodev, Live 0x0000000000000000
snd_soc_sst_haswell_pcm 90112 1 snd_soc_sst_broadwell, Live 
0x0000000000000000
dell_wmi 16384 0 - Live 0x0000000000000000
snd_soc_sst_ipc 16384 1 snd_soc_sst_haswell_pcm, Live 0x0000000000000000
sparse_keymap 16384 1 dell_wmi, Live 0x0000000000000000
snd_soc_sst_dsp 53248 1 snd_soc_sst_haswell_pcm, Live 0x0000000000000000
intel_rapl 20480 0 - Live 0x0000000000000000
x86_pkg_temp_thermal 16384 0 - Live 0x0000000000000000
intel_powerclamp 16384 0 - Live 0x0000000000000000
coretemp 16384 0 - Live 0x0000000000000000
kvm_intel 163840 0 - Live 0x0000000000000000
kvm 503808 1 kvm_intel, Live 0x0000000000000000
arc4 16384 2 - Live 0x0000000000000000
dell_laptop 20480 0 - Live 0x0000000000000000
dcdbas 16384 1 dell_laptop, Live 0x0000000000000000
crct10dif_pclmul 16384 0 - Live 0x0000000000000000
crc32_pclmul 16384 0 - Live 0x0000000000000000
ghash_clmulni_intel 16384 0 - Live 0x0000000000000000
aesni_intel 167936 6 - Live 0x0000000000000000
aes_x86_64 20480 1 aesni_intel, Live 0x0000000000000000
lrw 16384 1 aesni_intel, Live 0x0000000000000000
gf128mul 16384 1 lrw, Live 0x0000000000000000
glue_helper 16384 1 aesni_intel, Live 0x0000000000000000
ablk_helper 16384 1 aesni_intel, Live 0x0000000000000000
cryptd 20480 3 ghash_clmulni_intel,aesni_intel,ablk_helper, Live 
0x0000000000000000
input_leds 16384 0 - Live 0x0000000000000000
serio_raw 16384 0 - Live 0x0000000000000000
iwlmvm 290816 0 - Live 0x0000000000000000
mac80211 729088 1 iwlmvm, Live 0x0000000000000000
iwlwifi 204800 1 iwlmvm, Live 0x0000000000000000
cfg80211 536576 3 iwlmvm,mac80211,iwlwifi, Live 0x0000000000000000
i915 1114112 5 - Live 0x0000000000000000
snd_soc_rt286 40960 1 snd_soc_sst_broadwell, Live 0x0000000000000000
snd_soc_rl6347a 16384 1 snd_soc_rt286, Live 0x0000000000000000
snd_soc_core 217088 3 
snd_soc_sst_broadwell,snd_soc_sst_haswell_pcm,snd_soc_rt286, Live 
0x0000000000000000
shpchp 36864 0 - Live 0x0000000000000000
lpc_ich 24576 0 - Live 0x0000000000000000
snd_compress 20480 1 snd_soc_core, Live 0x0000000000000000
ac97_bus 16384 1 snd_soc_core, Live 0x0000000000000000
snd_hda_intel 36864 2 - Live 0x0000000000000000
drm_kms_helper 126976 1 i915, Live 0x0000000000000000
snd_pcm_dmaengine 16384 1 snd_soc_core, Live 0x0000000000000000
snd_hda_codec 135168 2 snd_hda_codec_hdmi,snd_hda_intel, Live 
0x0000000000000000
snd_seq_midi 16384 0 - Live 0x0000000000000000
drm 356352 6 i915,drm_kms_helper, Live 0x0000000000000000
snd_seq_midi_event 16384 1 snd_seq_midi, Live 0x0000000000000000
snd_hda_core 65536 3 snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec, 
Live 0x0000000000000000
snd_rawmidi 32768 1 snd_seq_midi, Live 0x0000000000000000
snd_hwdep 16384 1 snd_hda_codec, Live 0x0000000000000000
snd_seq 69632 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
mei_me 24576 0 - Live 0x0000000000000000
snd_pcm 102400 8 
snd_hda_codec_hdmi,snd_soc_sst_haswell_pcm,snd_soc_rt286,snd_soc_core,snd_hda_intel,snd_pcm_dmaengine,snd_hda_codec,snd_hda_core, 
Live 0x0000000000000000
i2c_algo_bit 16384 1 i915, Live 0x0000000000000000
mei 90112 1 mei_me, Live 0x0000000000000000
snd_seq_device 16384 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 
0x0000000000000000
snd_timer 32768 2 snd_seq,snd_pcm, Live 0x0000000000000000
wmi 20480 1 dell_wmi, Live 0x0000000000000000
snd 81920 16 
snd_hda_codec_hdmi,snd_soc_sst_haswell_pcm,snd_soc_core,snd_compress,snd_hda_intel,snd_hda_codec,snd_rawmidi,snd_hwdep,snd_seq,snd_pcm,snd_seq_device,snd_timer, 
Live 0x0000000000000000
mac_hid 16384 0 - Live 0x0000000000000000
soundcore 16384 1 snd, Live 0x0000000000000000
i2c_hid 20480 0 - Live 0x0000000000000000
hid 118784 4 hid_generic,hid_multitouch,usbhid,i2c_hid, Live 
0x0000000000000000
soc_button_array 16384 0 - Live 0x0000000000000000
snd_soc_sst_acpi 16384 0 - Live 0x0000000000000000
dw_dmac 16384 0 - Live 0x0000000000000000
processor_thermal_device 16384 0 - Live 0x0000000000000000
i2c_designware_platform 16384 0 - Live 0x0000000000000000
8250_fintek 16384 0 - Live 0x0000000000000000
intel_soc_dts_iosf 16384 1 processor_thermal_device, Live 0x0000000000000000
int3403_thermal 16384 0 - Live 0x0000000000000000
dw_dmac_core 24576 2 snd_soc_sst_dsp,dw_dmac, Live 0x0000000000000000
int3400_thermal 16384 0 - Live 0x0000000000000000
video 36864 3 dell_wmi,dell_laptop,i915, Live 0x0000000000000000
tpm_crb 16384 0 - Live 0x0000000000000000
i2c_designware_core 16384 1 i2c_designware_platform, Live 0x0000000000000000
dell_rbtn 16384 0 - Live 0x0000000000000000
iosf_mbi 16384 2 intel_rapl,intel_soc_dts_iosf, Live 0x0000000000000000
8250_dw 16384 0 - Live 0x0000000000000000
spi_pxa2xx_platform 24576 0 - Live 0x0000000000000000
acpi_als 16384 0 - Live 0x0000000000000000
int3402_thermal 16384 0 - Live 0x0000000000000000
acpi_pad 20480 0 - Live 0x0000000000000000
acpi_thermal_rel 16384 1 int3400_thermal, Live 0x0000000000000000
int340x_thermal_zone 16384 3 
processor_thermal_device,int3403_thermal,int3402_thermal, Live 
0x0000000000000000
kfifo_buf 16384 1 acpi_als, Live 0x0000000000000000
industrialio 57344 2 acpi_als,kfifo_buf, Live 0x0000000000000000
parport_pc 32768 0 - Live 0x0000000000000000
ppdev 20480 0 - Live 0x0000000000000000
lp 20480 0 - Live 0x0000000000000000
parport 49152 3 parport_pc,ppdev,lp, Live 0x0000000000000000
autofs4 40960 2 - Live 0x0000000000000000
mmc_block 36864 2 - Live 0x0000000000000000
ahci 36864 2 - Live 0x0000000000000000
libahci 32768 1 ahci, Live 0x0000000000000000
sdhci_pci 24576 0 - Live 0x0000000000000000
sdhci_acpi 16384 0 - Live 0x0000000000000000
sdhci 45056 2 sdhci_pci,sdhci_acpi, Live 0x0000000000000000

[7.4.] Loaded driver and hardware information
$ cat /proc/ioports
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
   0680-069f : pnp 00:00
   0930-0930 : PNP0C09:00
     0930-0930 : EC data
   0934-0934 : PNP0C09:00
     0934-0934 : EC cmd
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
   164e-164f : pnp 00:00
   1800-1803 : ACPI PM1a_EVT_BLK
   1804-1805 : ACPI PM1a_CNT_BLK
   1808-180b : ACPI PM_TMR
   1810-1815 : ACPI CPU throttle
   1830-1833 : iTCO_wdt.0.auto
   1850-1850 : ACPI PM2_CNT_BLK
   1854-1857 : pnp 00:02
   1860-187f : iTCO_wdt.0.auto
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
   ffff-ffff : pnp 00:00
     ffff-ffff : pnp 00:00
       ffff-ffff : pnp 00:00

$ cat /proc/iomem
00000000-00000fff : reserved
00001000-0009d3ff : System RAM
0009d400-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000cfdff : Video ROM
000e0000-000fffff : reserved
   000f0000-000fffff : System ROM
00100000-c7a1afff : System RAM
   01000000-017ac3bb : Kernel code
   017ac3bc-01d344ff : Kernel data
   01eaa000-01fecfff : Kernel bss
c7a1b000-c7eb7fff : reserved
c7eb8000-da801fff : System RAM
da802000-da8c2fff : reserved
da8c3000-da8ebfff : ACPI Tables
da8ec000-db237fff : ACPI Non-volatile Storage
db238000-db5fdfff : reserved
db5fe000-db5fefff : System RAM
db5ff000-db5fffff : MSFT0101:00
db600000-dbffffff : RAM buffer
dd000000-df7fffff : reserved
   dd800000-df7fffff : Graphics Stolen Memory
df800000-feafffff : PCI Bus 0000:00
   e0000000-efffffff : 0000:00:02.0
   f6000000-f6ffffff : 0000:00:02.0
   f7000000-f70fffff : PCI Bus 0000:02
     f7000000-f70007ff : 0000:02:00.0
     f7001000-f7001fff : 0000:02:00.0
       f7001000-f7001fff : mmc0
   f7100000-f71fffff : PCI Bus 0000:01
     f7100000-f7101fff : 0000:01:00.0
       f7100000-f7101fff : iwlwifi
   f7200000-f720ffff : 0000:00:14.0
     f7200000-f720ffff : xhci-hcd
   f7210000-f7217fff : 0000:00:04.0
   f7218000-f721bfff : 0000:00:03.0
     f7218000-f721bfff : ICH HD audio
   f721c000-f721c0ff : 0000:00:1f.3
   f721d000-f721d7ff : 0000:00:1f.2
     f721d000-f721d7ff : ahci
   f7220000-f722001f : 0000:00:16.0
     f7220000-f722001f : mei_me
   f7fe0000-f7feffff : pnp 00:04
   f7ff0000-f7ffffff : pnp 00:04
   f8000000-fbffffff : PCI MMCONFIG 0000 [bus 00-3f]
     f8000000-fbffffff : reserved
       f8000000-fbffffff : pnp 00:04
   fe000000-fe0fffff : INT3438:00
     fe0fe000-fe0fe3fe : INT3438:00
   fe100000-fe100fff : INT3438:00
   fe102000-fe102fff : pnp 00:05
   fe104000-fe104fff : pnp 00:05
   fe105000-fe105fff : INT3433:00
     fe105000-fe105fff : INT3433:00
   fe106000-fe106fff : pnp 00:05
fec00000-fec00fff : reserved
   fec00000-fec003ff : IOAPIC 0
fed00000-fed03fff : reserved
   fed00000-fed003ff : HPET 0
     fed00000-fed003ff : PNP0103:00
fed10000-fed17fff : pnp 00:04
fed18000-fed18fff : pnp 00:04
fed19000-fed19fff : pnp 00:04
fed1c000-fed1ffff : reserved
   fed1c000-fed1ffff : pnp 00:04
     fed1f410-fed1f414 : iTCO_wdt.0.auto
fed20000-fed3ffff : pnp 00:04
fed70000-fed70fff : MSFT0101:00
fed90000-fed90fff : dmar0
fed91000-fed91fff : dmar1
fee00000-fee00fff : Local APIC
   fee00000-fee00fff : reserved
ff000000-ffffffff : reserved
   ff000000-ffffffff : INT0800:00
     ff000000-ffffffff : pnp 00:04
100000000-11e7fffff : System RAM
11e800000-11fffffff : RAM buffer

[7.5.] PCI information

$ sudo lspci -vvv
00:00.0 Host bridge: Intel Corporation Broadwell-U Host Bridge -OPI (rev 09)
     Subsystem: Dell Device 066b
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR- INTx-
     Latency: 0
     Capabilities: [e0] Vendor Specific Information: Len=0c <?>
     Kernel driver in use: bdw_uncore

00:02.0 VGA compatible controller: Intel Corporation Broadwell-U 
Integrated Graphics (rev 09) (prog-if 00 [VGA controller])
     Subsystem: Dell Device 066b
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 45
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

00:03.0 Audio device: Intel Corporation Broadwell-U Audio Controller 
(rev 09)
     Subsystem: Dell Device 066b
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 47
     Region 0: Memory at f7218000 (64-bit, non-prefetchable) [size=16K]
     Capabilities: [50] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit-
         Address: fee00318  Data: 0000
     Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, 
MSI 00
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
     Subsystem: Dell Device 066b
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 16
     Region 0: Memory at f7210000 (64-bit, non-prefetchable) [size=32K]
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
     Subsystem: Dell Device 066b
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 42
     Region 0: Memory at f7200000 (64-bit, non-prefetchable) [size=64K]
     Capabilities: [70] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
         Address: 00000000fee00258  Data: 0000
     Kernel driver in use: xhci_hcd

00:16.0 Communication controller: Intel Corporation Wildcat Point-LP MEI 
Controller #1 (rev 03)
     Subsystem: Dell Device 066b
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 44
     Region 0: Memory at f7220000 (64-bit, non-prefetchable) [size=32]
     Capabilities: [50] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
         Address: 00000000fee002d8  Data: 0000
     Kernel driver in use: mei_me

00:1c.0 PCI bridge: Intel Corporation Wildcat Point-LP PCI Express Root 
Port #3 (rev e3) (prog-if 00 [Normal decode])
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
     I/O behind bridge: 0000f000-00000fff
     Memory behind bridge: f7100000-f71fffff
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
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
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
             Changed: MRL- PresDet- LinkState+
         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
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
     Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
         Address: 00000000  Data: 0000
     Capabilities: [90] Subsystem: Dell Device 066b
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
Stepping- SERR- FastB2B- DisINTx-
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
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
TransPend-
         LnkCap:    Port #4, Speed 5GT/s, Width x1, ASPM L0s L1, Exit 
Latency L0s <1us, L1 <16us
             ClockPM- Surprise- LLActRep+ BwNot+
         LnkCtl:    ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk-
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
         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
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
     Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
         Address: 00000000  Data: 0000
     Capabilities: [90] Subsystem: Dell Device 066b
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
     Subsystem: Dell Device 066b
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Capabilities: [e0] Vendor Specific Information: Len=0c <?>
     Kernel driver in use: lpc_ich

00:1f.2 SATA controller: Intel Corporation Wildcat Point-LP SATA 
Controller [AHCI Mode] (rev 03) (prog-if 01 [AHCI 1.0])
     Subsystem: Dell Device 066b
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin B routed to IRQ 43
     Region 0: I/O ports at f0b0 [size=8]
     Region 1: I/O ports at f0a0 [size=4]
     Region 2: I/O ports at f090 [size=8]
     Region 3: I/O ports at f080 [size=4]
     Region 4: I/O ports at f060 [size=32]
     Region 5: Memory at f721d000 (32-bit, non-prefetchable) [size=2K]
     Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
         Address: fee00278  Data: 0000
     Capabilities: [70] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
     Kernel driver in use: ahci

00:1f.3 SMBus: Intel Corporation Wildcat Point-LP SMBus Controller (rev 03)
     Subsystem: Dell Device 066b
     Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Interrupt: pin C routed to IRQ 255
     Region 0: Memory at f721c000 (64-bit, non-prefetchable) [size=256]
     Region 4: I/O ports at f040 [size=32]

01:00.0 Network controller: Intel Corporation Wireless 7265 (rev 3b)
     Subsystem: Intel Corporation Device 5510
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 46
     Region 0: Memory at f7100000 (64-bit, non-prefetchable) [size=8K]
     Capabilities: [c8] Power Management version 3
         Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
         Address: 00000000fee002f8  Data: 0000
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
         LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L1, Exit 
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
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
         AERCap:    First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
     Capabilities: [140 v1] Device Serial Number 60-57-18-ff-ff-12-74-a1
     Capabilities: [14c v1] Latency Tolerance Reporting
         Max snoop latency: 3145728ns
         Max no snoop latency: 3145728ns
     Capabilities: [154 v1] L1 PM Substates
         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ 
L1_PM_Substates+
               PortCommonModeRestoreTime=30us PortTPowerOnTime=60us
     Kernel driver in use: iwlwifi

02:00.0 SD Host controller: O2 Micro, Inc. Device 8621 (rev 01) (prog-if 01)
     Subsystem: Dell Device 066b
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 19
     Region 0: Memory at f7001000 (32-bit, non-prefetchable) [size=4K]
     Region 1: Memory at f7000000 (32-bit, non-prefetchable) [size=2K]
     Capabilities: [6c] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable- Count=1/1 Maskable+ 64bit+
         Address: 0000000000000000  Data: 0000
         Masking: 00000000  Pending: 00000000
     Capabilities: [80] Express (v2) Endpoint, MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, 
L1 unlimited
             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit 
Latency L0s <512ns, L1 unlimited
             ClockPM+ Surprise- LLActRep- BwNot-
         LnkCtl:    ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk-
             ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk- 
DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR+, 
OBFF Not Supported
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, 
OBFF Disabled
         LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance De-emphasis: -6dB
         LnkSta2: Current De-emphasis Level: -6dB, 
EqualizationComplete-, EqualizationPhase1-
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
     Capabilities: [200 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
         AERCap:    First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
     Capabilities: [230 v1] Latency Tolerance Reporting
         Max snoop latency: 3145728ns
         Max no snoop latency: 3145728ns
     Capabilities: [240 v1] L1 PM Substates
         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ 
L1_PM_Substates+
               PortCommonModeRestoreTime=120us PortTPowerOnTime=10us
     Kernel driver in use: sdhci-pci

[7.6.] SCSI information

$ cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: SanDisk X110 M.2 Rev: 112
   Type:   Direct-Access                    ANSI  SCSI revision: 05

[7.7.] Other information that might be relevant to the problem

$ ls /proc
1     14    150   1568  17    1786  1879  2220  250   2646  2971 35   
44   668  753  849        crypto       keys partitions     tty
10    1401  1505  157   1700  1795  1893  2221  2521  2679  2995 36   
440  67   755  859        devices      key-users sched_debug    uptime
1085  1409  1509  158   1701  18    19    2222  2547  2686  3 37   45   
671  757  9          diskstats    kmsg schedstat      version
11    1410  151   1582  1706  1808  1941  2224  2557  27    3000 372  
46   674  758  93         dma          kpagecount scsi           vmallocinfo
1133  1414  1514  1584  1708  1809  1944  2225  2558  270   3001 38   
47   675  759  94         driver       kpageflags self           vmstat
12    1417  152   1589  1710  1810  1949  225   2569  2730  3002 39   
48   680  761  956        execdomains  loadavg slabinfo       zoneinfo
1247  1431  1520  1590  1711  1812  1968  2323  2577  2740  305 4    
5    681  762  975        fb           locks         softirqs
1273  1433  1524  1595  1714  1815  2     2332  2578  275   31 40   51   
684  763  acpi       filesystems  mdstat        stat
1274  1470  1529  1596  173   1816  20    2368  2583  28    319 41   
510  7    764  asound     fs           meminfo       swaps
1279  1473  153   16    174   1821  2046  2373  2584  2822  32 42   53   
705  779  buddyinfo  interrupts   misc          sys
1280  1486  1533  1624  1747  1828  209   2379  2587  29    320 43   
54   706  781  bus        iomem        modules sysrq-trigger
13    1488  154   164   1754  1842  21    2395  26    2960  33 432  55   
738  782  cgroups    ioports      mounts        sysvipc
1309  149   1541  1653  1768  1849  214   24    2606  2962  336 433  
66   74   784  cmdline    irq          mtrr thread-self
1385  1494  155   1696  1770  1855  2199  2430  261   2963  337 434  
662  748  8    consoles   kallsyms     net           timer_list
1392  15    156   1698  1784  1858  22    25    2613  2966  34 435  664  
752  811  cpuinfo    kcore        pagetypeinfo timer_stats

[X.] Other notes, patches, fixes, workarounds:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1472478

