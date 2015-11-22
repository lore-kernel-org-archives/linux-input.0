From: Pelle van der Scheer <pelle@postuil.nl>
Subject: PROBLEM: Touchpad not working on Asus Zenbook UX203CA-FC022T
Date: Sun, 22 Nov 2015 08:23:33 +0100
Message-ID: <fef10f8bc6f7c492fd3c0f1943a48c80@postuil.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cadeska.xlshosting.net ([79.170.89.229]:56244 "EHLO
	mail.cadeska.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363AbbKVHf2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 22 Nov 2015 02:35:28 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Good day,

The touchpad on the Asus Zenbook UX203CA-FC022T is not working. I am 
using an usb mouse.

I have tested it on the latest mainline kernel available from the ubuntu 
kernel-ppa (4.3) and the 4.4-rc1 build available at phoronix.com. The 
information below is generated using the latest working mainline kernel 
from the ubuntu kernel-ppa (the 4.4-rc1 build fails there)

$ cat /proc/version
Linux version 4.3.0-040300-generic (kernel@gomeisa) (gcc version 5.2.1 
20151010 (Ubuntu 5.2.1-22ubuntu2) ) #201511020949 SMP Mon Nov 2 14:50:44 
UTC 2015
$ lsb_release -rd
Description: Ubuntu 15.10
Release: 15.10

$ /usr/src/linux-headers-4.2.0-18-generic/scripts/ver_linux

Linux tree 4.3.0-040300-generic #201511020949 SMP Mon Nov 2 14:50:44 UTC 
2015 x86_64 x86_64 x86_64 GNU/Linux

Gnu C 5.2.1
Gnu make 4.0
binutils 2.25.1
util-linux 2.26.2
mount debug
module-init-tools 21
e2fsprogs 1.42.12
pcmciautils 018
PPP 2.4.6
Linux C Library 2.21
Dynamic linker (ldd) 2.21
Procps 3.3.9
Net-tools 1.60
Kbd 1.15.5
Sh-utils 8.23
wireless-tools 30
Modules Loaded rfcomm bnep nls_iso8859_1 asix usbnet mii arc4 
snd_hda_codec_hdmi iwlmvm snd_hda_codec_realtek snd_hda_codec_generic 
mac80211 intel_rapl x86_pkg_temp_thermal intel_powerclamp coretemp 
snd_hda_intel kvm_intel snd_hda_codec snd_hda_core uvcvideo kvm 
snd_hwdep snd_pcm videobuf2_vmalloc videobuf2_memops snd_seq_midi 
videobuf2_core snd_seq_midi_event crct10dif_pclmul iwlwifi v4l2_common 
snd_rawmidi crc32_pclmul i2c_designware_platform asus_nb_wmi videodev 
i2c_designware_core asus_wmi snd_seq sparse_keymap cfg80211 media 
snd_seq_device aesni_intel snd_timer aes_x86_64 lrw snd gf128mul 
glue_helper soundcore ablk_helper processor_thermal_device idma64 cryptd 
mei_me intel_soc_dts_iosf input_leds virt_dma mei shpchp iosf_mbi 
serio_raw btusb hci_uart btrtl btqca btbcm intel_lpss_pci elan_i2c 
btintel bluetooth int3402_thermal intel_lpss_acpi acpi_als 
int3403_thermal int3400_thermal tpm_crb intel_lpss int340x_thermal_zone 
kfifo_buf acpi_thermal_rel industrialio mac_hid acpi_pad parport_pc 
ppdev lp parport autofs4 hid_generic usbhid i915 i2c_algo_bit 
drm_kms_helper syscopyarea sysfillrect sysimgblt ahci fb_sys_fops 
libahci drm wmi i2c_hid hid pinctrl_sunrisepoint video pinctrl_intel 
fjes

$ cat /proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 78
model name	: Intel(R) Core(TM) m3-6Y30 CPU @ 0.90GHz
stepping	: 3
microcode	: 0x33
cpu MHz		: 456.796
cache size	: 4096 KB
physical id	: 0
siblings	: 4
core id		: 0
cpu cores	: 2
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 
x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm 
abm 3dnowprefetch ida arat epb pln pts dtherm hwp hwp_notify 
hwp_act_window hwp_epp intel_pt tpr_shadow vnmi flexpriority ept vpid 
fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid mpx rdseed adx smap 
clflushopt xsaveopt xsavec xgetbv1
bugs		:
bogomips	: 3023.90
clflush size	: 64
cache_alignment	: 64
address sizes	: 39 bits physical, 48 bits virtual
power management:

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 78
model name	: Intel(R) Core(TM) m3-6Y30 CPU @ 0.90GHz
stepping	: 3
microcode	: 0x33
cpu MHz		: 487.382
cache size	: 4096 KB
physical id	: 0
siblings	: 4
core id		: 1
cpu cores	: 2
apicid		: 2
initial apicid	: 2
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 
x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm 
abm 3dnowprefetch ida arat epb pln pts dtherm hwp hwp_notify 
hwp_act_window hwp_epp intel_pt tpr_shadow vnmi flexpriority ept vpid 
fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid mpx rdseed adx smap 
clflushopt xsaveopt xsavec xgetbv1
bugs		:
bogomips	: 3023.90
clflush size	: 64
cache_alignment	: 64
address sizes	: 39 bits physical, 48 bits virtual
power management:

processor	: 2
vendor_id	: GenuineIntel
cpu family	: 6
model		: 78
model name	: Intel(R) Core(TM) m3-6Y30 CPU @ 0.90GHz
stepping	: 3
microcode	: 0x33
cpu MHz		: 500.039
cache size	: 4096 KB
physical id	: 0
siblings	: 4
core id		: 0
cpu cores	: 2
apicid		: 1
initial apicid	: 1
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 
x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm 
abm 3dnowprefetch ida arat epb pln pts dtherm hwp hwp_notify 
hwp_act_window hwp_epp intel_pt tpr_shadow vnmi flexpriority ept vpid 
fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid mpx rdseed adx smap 
clflushopt xsaveopt xsavec xgetbv1
bugs		:
bogomips	: 3023.90
clflush size	: 64
cache_alignment	: 64
address sizes	: 39 bits physical, 48 bits virtual
power management:

processor	: 3
vendor_id	: GenuineIntel
cpu family	: 6
model		: 78
model name	: Intel(R) Core(TM) m3-6Y30 CPU @ 0.90GHz
stepping	: 3
microcode	: 0x33
cpu MHz		: 499.980
cache size	: 4096 KB
physical id	: 0
siblings	: 4
core id		: 1
cpu cores	: 2
apicid		: 3
initial apicid	: 3
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 
x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm 
abm 3dnowprefetch ida arat epb pln pts dtherm hwp hwp_notify 
hwp_act_window hwp_epp intel_pt tpr_shadow vnmi flexpriority ept vpid 
fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid mpx rdseed adx smap 
clflushopt xsaveopt xsavec xgetbv1
bugs		:
bogomips	: 3023.90
clflush size	: 64
cache_alignment	: 64
address sizes	: 39 bits physical, 48 bits virtual
power management:

$ cat /proc/modules
rfcomm 69632 0 - Live 0x0000000000000000
bnep 20480 2 - Live 0x0000000000000000
nls_iso8859_1 16384 1 - Live 0x0000000000000000
asix 40960 0 - Live 0x0000000000000000
usbnet 40960 1 asix, Live 0x0000000000000000
mii 16384 2 asix,usbnet, Live 0x0000000000000000
arc4 16384 2 - Live 0x0000000000000000
snd_hda_codec_hdmi 49152 1 - Live 0x0000000000000000
iwlmvm 307200 0 - Live 0x0000000000000000
snd_hda_codec_realtek 81920 1 - Live 0x0000000000000000
snd_hda_codec_generic 73728 1 snd_hda_codec_realtek, Live 
0x0000000000000000
mac80211 720896 1 iwlmvm, Live 0x0000000000000000
intel_rapl 20480 0 - Live 0x0000000000000000
x86_pkg_temp_thermal 16384 0 - Live 0x0000000000000000
intel_powerclamp 16384 0 - Live 0x0000000000000000
coretemp 16384 0 - Live 0x0000000000000000
snd_hda_intel 36864 3 - Live 0x0000000000000000
kvm_intel 163840 0 - Live 0x0000000000000000
snd_hda_codec 135168 4 
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel, 
Live 0x0000000000000000
snd_hda_core 65536 5 
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec, 
Live 0x0000000000000000
uvcvideo 90112 0 - Live 0x0000000000000000
kvm 507904 1 kvm_intel, Live 0x0000000000000000
snd_hwdep 16384 1 snd_hda_codec, Live 0x0000000000000000
snd_pcm 102400 4 
snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec,snd_hda_core, Live 
0x0000000000000000
videobuf2_vmalloc 16384 1 uvcvideo, Live 0x0000000000000000
videobuf2_memops 16384 1 videobuf2_vmalloc, Live 0x0000000000000000
snd_seq_midi 16384 0 - Live 0x0000000000000000
videobuf2_core 49152 1 uvcvideo, Live 0x0000000000000000
snd_seq_midi_event 16384 1 snd_seq_midi, Live 0x0000000000000000
crct10dif_pclmul 16384 0 - Live 0x0000000000000000
iwlwifi 204800 1 iwlmvm, Live 0x0000000000000000
v4l2_common 16384 1 videobuf2_core, Live 0x0000000000000000
snd_rawmidi 32768 1 snd_seq_midi, Live 0x0000000000000000
crc32_pclmul 16384 0 - Live 0x0000000000000000
i2c_designware_platform 16384 0 - Live 0x0000000000000000
asus_nb_wmi 24576 0 - Live 0x0000000000000000
videodev 172032 3 uvcvideo,videobuf2_core,v4l2_common, Live 
0x0000000000000000
i2c_designware_core 16384 1 i2c_designware_platform, Live 
0x0000000000000000
asus_wmi 28672 1 asus_nb_wmi, Live 0x0000000000000000
snd_seq 69632 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
sparse_keymap 16384 1 asus_wmi, Live 0x0000000000000000
cfg80211 536576 3 iwlmvm,mac80211,iwlwifi, Live 0x0000000000000000
media 24576 2 uvcvideo,videodev, Live 0x0000000000000000
snd_seq_device 16384 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 
0x0000000000000000
aesni_intel 167936 0 - Live 0x0000000000000000
snd_timer 32768 2 snd_pcm,snd_seq, Live 0x0000000000000000
aes_x86_64 20480 1 aesni_intel, Live 0x0000000000000000
lrw 16384 1 aesni_intel, Live 0x0000000000000000
snd 81920 17 
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_seq_device,snd_timer, 
Live 0x0000000000000000
gf128mul 16384 1 lrw, Live 0x0000000000000000
glue_helper 16384 1 aesni_intel, Live 0x0000000000000000
soundcore 16384 1 snd, Live 0x0000000000000000
ablk_helper 16384 1 aesni_intel, Live 0x0000000000000000
processor_thermal_device 16384 0 - Live 0x0000000000000000
idma64 20480 0 - Live 0x0000000000000000
cryptd 20480 2 aesni_intel,ablk_helper, Live 0x0000000000000000
mei_me 28672 0 - Live 0x0000000000000000
intel_soc_dts_iosf 16384 1 processor_thermal_device, Live 
0x0000000000000000
input_leds 16384 0 - Live 0x0000000000000000
virt_dma 16384 1 idma64, Live 0x0000000000000000
mei 98304 1 mei_me, Live 0x0000000000000000
shpchp 36864 0 - Live 0x0000000000000000
iosf_mbi 16384 2 intel_rapl,intel_soc_dts_iosf, Live 0x0000000000000000
serio_raw 16384 0 - Live 0x0000000000000000
btusb 45056 0 - Live 0x0000000000000000
hci_uart 73728 0 - Live 0x0000000000000000
btrtl 16384 1 btusb, Live 0x0000000000000000
btqca 16384 1 hci_uart, Live 0x0000000000000000
btbcm 16384 2 btusb,hci_uart, Live 0x0000000000000000
intel_lpss_pci 16384 0 - Live 0x0000000000000000
elan_i2c 32768 0 - Live 0x0000000000000000
btintel 16384 2 btusb,hci_uart, Live 0x0000000000000000
bluetooth 512000 31 
rfcomm,bnep,btusb,hci_uart,btrtl,btqca,btbcm,btintel, Live 
0x0000000000000000
int3402_thermal 16384 0 - Live 0x0000000000000000
intel_lpss_acpi 16384 0 - Live 0x0000000000000000
acpi_als 16384 0 - Live 0x0000000000000000
int3403_thermal 16384 0 - Live 0x0000000000000000
int3400_thermal 16384 0 - Live 0x0000000000000000
tpm_crb 16384 0 - Live 0x0000000000000000
intel_lpss 16384 2 intel_lpss_pci,intel_lpss_acpi, Live 
0x0000000000000000
int340x_thermal_zone 16384 3 
processor_thermal_device,int3402_thermal,int3403_thermal, Live 
0x0000000000000000
kfifo_buf 16384 1 acpi_als, Live 0x0000000000000000
acpi_thermal_rel 16384 1 int3400_thermal, Live 0x0000000000000000
industrialio 57344 2 acpi_als,kfifo_buf, Live 0x0000000000000000
mac_hid 16384 0 - Live 0x0000000000000000
acpi_pad 20480 0 - Live 0x0000000000000000
parport_pc 32768 0 - Live 0x0000000000000000
ppdev 20480 0 - Live 0x0000000000000000
lp 20480 0 - Live 0x0000000000000000
parport 49152 3 parport_pc,ppdev,lp, Live 0x0000000000000000
autofs4 40960 2 - Live 0x0000000000000000
hid_generic 16384 0 - Live 0x0000000000000000
usbhid 49152 0 - Live 0x0000000000000000
i915 1134592 4 - Live 0x0000000000000000
i2c_algo_bit 16384 1 i915, Live 0x0000000000000000
drm_kms_helper 131072 1 i915, Live 0x0000000000000000
syscopyarea 16384 1 drm_kms_helper, Live 0x0000000000000000
sysfillrect 16384 1 drm_kms_helper, Live 0x0000000000000000
sysimgblt 16384 1 drm_kms_helper, Live 0x0000000000000000
ahci 36864 2 - Live 0x0000000000000000
fb_sys_fops 16384 1 drm_kms_helper, Live 0x0000000000000000
libahci 32768 1 ahci, Live 0x0000000000000000
drm 352256 5 i915,drm_kms_helper, Live 0x0000000000000000
wmi 20480 1 asus_wmi, Live 0x0000000000000000
i2c_hid 20480 0 - Live 0x0000000000000000
hid 118784 3 hid_generic,usbhid,i2c_hid, Live 0x0000000000000000
pinctrl_sunrisepoint 28672 0 - Live 0x0000000000000000
video 36864 2 asus_wmi,i915, Live 0x0000000000000000
pinctrl_intel 20480 1 pinctrl_sunrisepoint, Live 0x0000000000000000
fjes 28672 0 - Live 0x0000000000000000

$  cat /proc/ioports
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
   0240-0259 : pnp 00:03
   0680-069f : pnp 00:00
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
   164e-164f : pnp 00:00
   1800-1803 : ACPI PM1a_EVT_BLK
   1804-1805 : ACPI PM1a_CNT_BLK
   1808-180b : ACPI PM_TMR
   1810-1815 : ACPI CPU throttle
   1850-1850 : ACPI PM2_CNT_BLK
   1854-1857 : pnp 00:02
   1880-189f : ACPI GPE0_BLK
   f000-f03f : 0000:00:02.0
   f040-f05f : 0000:00:1f.4
   f060-f07f : 0000:00:17.0
     f060-f07f : ahci
   f080-f083 : 0000:00:17.0
     f080-f083 : ahci
   f090-f097 : 0000:00:17.0
     f090-f097 : ahci
   ff00-fffe : pnp 00:07
   ffff-ffff : pnp 00:00
     ffff-ffff : pnp 00:00
       ffff-ffff : pnp 00:00

$ cat /proc/iomem
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
000e0000-000e3fff : PCI Bus 0000:00
000e4000-000e7fff : PCI Bus 0000:00
000e8000-000ebfff : PCI Bus 0000:00
000ec000-000effff : PCI Bus 0000:00
000f0000-000fffff : System ROM
00100000-80994fff : System RAM
   02000000-027b83c6 : Kernel code
   027b83c7-02d380bf : Kernel data
   02eac000-02ff0fff : Kernel bss
80995000-80995fff : ACPI Non-volatile Storage
80996000-809bffff : reserved
809c0000-80a10fff : System RAM
80a11000-80e51fff : reserved
80e52000-859c1fff : System RAM
859c2000-8641dfff : reserved
8641e000-86a3ffff : System RAM
86a40000-873a7fff : ACPI Non-volatile Storage
873a8000-87f80fff : reserved
87f81000-87ffdfff : reserved
87ffe000-87ffefff : System RAM
87fff000-87ffffff : RAM buffer
88000000-880fffff : reserved
89000000-8affffff : reserved
   89000000-8affffff : Graphics Stolen Memory
8b000000-dfffffff : PCI Bus 0000:00
   c0000000-cfffffff : 0000:00:02.0
   de000000-deffffff : 0000:00:02.0
   df000000-df0fffff : PCI Bus 0000:01
     df000000-df001fff : 0000:01:00.0
       df000000-df001fff : iwlwifi
   df100000-df10ffff : 0000:00:1f.3
     df100000-df10ffff : ICH HD audio
   df110000-df11ffff : 0000:00:14.0
     df110000-df11ffff : xhci-hcd
   df120000-df127fff : 0000:00:04.0
   df128000-df12bfff : 0000:00:1f.3
     df128000-df12bfff : ICH HD audio
   df12c000-df12ffff : 0000:00:1f.2
   df130000-df131fff : 0000:00:17.0
     df130000-df131fff : ahci
   df132000-df1320ff : 0000:00:1f.4
   df133000-df1337ff : 0000:00:17.0
     df133000-df1337ff : ahci
   df134000-df1340ff : 0000:00:17.0
     df134000-df1340ff : ahci
   df135000-df135fff : 0000:00:16.0
     df135000-df135fff : mei_me
   df136000-df136fff : 0000:00:15.1
     df136000-df1361ff : lpss_dev
       df136000-df1361ff : lpss_dev
     df136200-df1362ff : lpss_priv
     df136800-df136fff : idma64.1
       df136800-df136fff : idma64.1
   df137000-df137fff : 0000:00:15.0
     df137000-df1371ff : lpss_dev
       df137000-df1371ff : lpss_dev
     df137200-df1372ff : lpss_priv
     df137800-df137fff : idma64.0
       df137800-df137fff : idma64.0
   df138000-df138fff : 0000:00:14.2
   dffe0000-dfffffff : pnp 00:05
e0000000-efffffff : PCI MMCONFIG 0000 [bus 00-ff]
   e0000000-efffffff : reserved
     e0000000-efffffff : pnp 00:05
fd000000-fe7fffff : PCI Bus 0000:00
   fd000000-fdabffff : pnp 00:06
   fdac0000-fdacffff : pnp 00:08
   fdad0000-fdadffff : pnp 00:06
   fdae0000-fdaeffff : pnp 00:08
   fdaf0000-fdafffff : pnp 00:08
   fdb00000-fdffffff : pnp 00:06
   fe000000-fe010fff : reserved
   fe036000-fe03bfff : pnp 00:06
   fe03d000-fe3fffff : pnp 00:06
   fe410000-fe7fffff : pnp 00:06
fec00000-fec00fff : reserved
   fec00000-fec003ff : IOAPIC 0
fed00000-fed003ff : HPET 0
   fed00000-fed003ff : PNP0103:00
fed10000-fed17fff : pnp 00:05
fed18000-fed18fff : pnp 00:05
fed19000-fed19fff : pnp 00:05
fed20000-fed3ffff : pnp 00:05
fed40000-fed4087f : MSFT0101:00
fed45000-fed8ffff : pnp 00:05
fed90000-fed90fff : dmar0
fed91000-fed91fff : dmar1
fee00000-fee00fff : Local APIC
   fee00000-fee00fff : reserved
ff000000-ffffffff : reserved
   ff000000-ffffffff : INT0800:00
     ff000000-ffffffff : pnp 00:05
100000000-273ffffff : System RAM

$ sudo lspci -vvv
00:00.0 Host bridge: Intel Corporation Sky Lake Host Bridge/DRAM 
Registers (rev 08)
	Subsystem: ASUSTeK Computer Inc. Device 1cfd
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort+ 
<MAbort+ >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information: Len=10 <?>

00:02.0 VGA compatible controller: Intel Corporation Sky Lake Integrated 
Graphics (rev 07) (prog-if 00 [VGA controller])
	Subsystem: ASUSTeK Computer Inc. Device 1cfd
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 125
	Region 0: Memory at de000000 (64-bit, non-prefetchable) [size=16M]
	Region 2: Memory at c0000000 (64-bit, prefetchable) [size=256M]
	Region 4: I/O ports at f000 [size=64]
	Expansion ROM at <unassigned> [disabled]
	Capabilities: [40] Vendor Specific Information: Len=0c <?>
	Capabilities: [70] Express (v2) Root Complex Integrated Endpoint, MSI 
00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF 
Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF 
Disabled
	Capabilities: [ac] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee00018  Data: 0000
	Capabilities: [d0] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] #1b
	Capabilities: [200 v1] Address Translation Service (ATS)
		ATSCap:	Invalidate Queue Depth: 00
		ATSCtl:	Enable-, Smallest Translation Unit: 00
	Capabilities: [300 v1] #13
	Kernel driver in use: i915

00:04.0 Signal processing controller: Intel Corporation Device 1903 (rev 
08)
	Subsystem: ASUSTeK Computer Inc. Device 1cfd
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at df120000 (64-bit, non-prefetchable) [size=32K]
	Capabilities: [90] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [d0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [e0] Vendor Specific Information: Len=0c <?>
	Kernel driver in use: proc_thermal

00:14.0 USB controller: Intel Corporation Device 9d2f (rev 21) (prog-if 
30 [XHCI])
	Subsystem: ASUSTeK Computer Inc. Device 201f
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 123
	Region 0: Memory at df110000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [70] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
		Address: 00000000fee00238  Data: 0000
	Kernel driver in use: xhci_hcd

00:14.2 Signal processing controller: Intel Corporation Device 9d31 (rev 
21)
	Subsystem: ASUSTeK Computer Inc. Device 1cfd
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin C routed to IRQ 255
	Region 0: Memory at df138000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000

00:15.0 Signal processing controller: Intel Corporation Device 9d60 (rev 
21)
	Subsystem: ASUSTeK Computer Inc. Device 1cfd
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at df137000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D3 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Vendor Specific Information: Len=14 <?>
	Kernel driver in use: intel-lpss

00:15.1 Signal processing controller: Intel Corporation Device 9d61 (rev 
21)
	Subsystem: ASUSTeK Computer Inc. Device 1cfd
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 17
	Region 0: Memory at df136000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D3 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Vendor Specific Information: Len=14 <?>
	Kernel driver in use: intel-lpss

00:16.0 Communication controller: Intel Corporation Device 9d3a (rev 21)
	Subsystem: ASUSTeK Computer Inc. Device 1cfd
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 126
	Region 0: Memory at df135000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee00298  Data: 0000
	Kernel driver in use: mei_me

00:17.0 SATA controller: Intel Corporation Device 9d03 (rev 21) (prog-if 
01 [AHCI 1.0])
	Subsystem: ASUSTeK Computer Inc. Device 1cfd
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 124
	Region 0: Memory at df130000 (32-bit, non-prefetchable) [size=8K]
	Region 1: Memory at df134000 (32-bit, non-prefetchable) [size=256]
	Region 2: I/O ports at f090 [size=8]
	Region 3: I/O ports at f080 [size=4]
	Region 4: I/O ports at f060 [size=32]
	Region 5: Memory at df133000 (32-bit, non-prefetchable) [size=2K]
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee00258  Data: 0000
	Capabilities: [70] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
	Kernel driver in use: ahci

00:1c.0 PCI bridge: Intel Corporation Device 9d13 (rev f1) (prog-if 00 
[Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin D routed to IRQ 122
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: df000000-df0fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #4, Speed 8GT/s, Width x1, ASPM L0s L1, Exit Latency L0s 
<1us, L1 <16us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ 
BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #7, PowerLimit 10.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- 
LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet+ LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ 
CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Not 
Supported ARIFwd+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis+, LTR+, OBFF 
Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- 
ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, 
EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee00218  Data: 0000
	Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 1cfd
	Capabilities: [a0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- 
MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- 
MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ 
MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [140 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd- 
EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- 
EgressCtrl- DirectTrans-
	Capabilities: [200 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ 
L1_PM_Substates+
			  PortCommonModeRestoreTime=40us PortTPowerOnTime=10us
	Capabilities: [220 v1] #19
	Kernel driver in use: pcieport

00:1f.0 ISA bridge: Intel Corporation Device 9d46 (rev 21)
	Subsystem: ASUSTeK Computer Inc. Device 1cfd
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0

00:1f.2 Memory controller: Intel Corporation Device 9d21 (rev 21)
	Subsystem: ASUSTeK Computer Inc. Device 1cfd
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Region 0: Memory at df12c000 (32-bit, non-prefetchable) [size=16K]

00:1f.3 Audio device: Intel Corporation Device 9d70 (rev 21)
	Subsystem: ASUSTeK Computer Inc. Device 1cfd
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 32
	Interrupt: pin A routed to IRQ 128
	Region 0: Memory at df128000 (64-bit, non-prefetchable) [size=16K]
	Region 4: Memory at df100000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee002d8  Data: 0000
	Kernel driver in use: snd_hda_intel

00:1f.4 SMBus: Intel Corporation Device 9d23 (rev 21)
	Subsystem: ASUSTeK Computer Inc. Device 1cfd
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 255
	Region 0: Memory at df132000 (64-bit, non-prefetchable) [size=256]
	Region 4: I/O ports at f040 [size=32]

01:00.0 Network controller: Intel Corporation Wireless 7265 (rev 59)
	Subsystem: Intel Corporation Dual Band Wireless-AC 7265
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 127
	Region 0: Memory at df000000 (64-bit, non-prefetchable) [size=8K]
	Capabilities: [c8] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee002f8  Data: 0000
	Capabilities: [40] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 
unlimited
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr+ NoSnoop+ FLReset-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L1, Exit Latency L0s 
<4us, L1 <32us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- 
BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range B, TimeoutDis+, LTR+, OBFF Via 
WAKE#
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis+, LTR+, OBFF 
Disabled
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- 
ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, 
EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- 
MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- 
MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ 
MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [140 v1] Device Serial Number dc-53-60-ff-ff-da-ae-df
	Capabilities: [14c v1] Latency Tolerance Reporting
		Max snoop latency: 3145728ns
		Max no snoop latency: 3145728ns
	Capabilities: [154 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ 
L1_PM_Substates+
			  PortCommonModeRestoreTime=30us PortTPowerOnTime=60us
	Kernel driver in use: iwlwifi

$  cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Micron_M600_MTFD Rev: MA01
   Type:   Direct-Access                    ANSI  SCSI revision: 05

$  ls /proc
1     1250  1341  1414  1498  1538  1588  1774  19    220  29   33   395 
  596  64   679  70   77   86   945        diskstats    kallsyms     
meminfo       self           tty
10    1262  1342  1420  15    154   1597  1782  1915  23   3    34   4   
  599  642  68   709  78   866  acpi       dma          kcore        misc 
          slabinfo       uptime
106   1293  1348  1422  150   1545  16    1799  1922  239  30   35   43  
  60   644  680  71   79   87   asound     driver       keys         
modules       softirqs       version
107   1294  1351  1425  1501  155   1610  18    1923  242  305  36   44  
  602  646  681  725  8    870  buddyinfo  execdomains  key-users    
mounts        stat           vmallocinfo
11    13    1352  1428  151   1553  1620  1805  2     25   306  37   45  
  607  647  682  73   80   88   bus        fb           kmsg         mtrr 
          swaps          vmstat
1148  1302  1357  1429  152   1559  1623  1812  20    259  307  371  475 
  609  65   683  732  809  89   cgroups    filesystems  kpagecgroup  net  
          sys            zoneinfo
1149  1317  1365  1432  153   157   1642  186   2035  26   31   379  5   
  61   66   684  74   81   9    cmdline    fs           kpagecount   
pagetypeinfo  sysrq-trigger
1155  1318  1366  1433  1531  1572  1669  1868  2041  27   310  38   581 
  622  668  689  741  82   901  consoles   interrupts   kpageflags   
partitions    sysvipc
1157  1321  1370  1438  1532  1575  1689  188   2068  276  32   386  583 
  625  67   69   748  83   905  cpuinfo    iomem        loadavg      
sched_debug   thread-self
12    1327  1374  1440  1535  158   17    189   21    277  320  387  585 
  627  677  693  75   84   93   crypto     ioports      locks        
schedstat     timer_list
1240  1337  14    1445  1537  1581  1739  1896  22    28   329  39   589 
  63   678  7    76   85   931  devices    irq          mdstat       scsi 
          timer_stats

Launchpad bug report: 
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1518570

Kind regards,

Pelle
