From: =?UTF-8?Q?St=C3=A9phane_RIVIERE?= <greenskol@gmail.com>
Subject: [HP Pavilion x2 - 12-b003nf] Synaptics touchpad not configured by HID RMI
Date: Tue, 6 Sep 2016 22:10:25 +0200
Message-ID: <CAFR8dhoR2U7QPEvSzho-NNMFnhvRaWVjzf0EF24B8JCsdbyAcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:34801 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753288AbcIFUK1 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 6 Sep 2016 16:10:27 -0400
Received: by mail-oi0-f49.google.com with SMTP id m11so184010945oif.1
        for <linux-input@vger.kernel.org>; Tue, 06 Sep 2016 13:10:26 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org

Hello,

I'm reporting this bug on a Synaptics touchpad not being configured
properly on a HP 2-in-1.
Bug was initially open on Launchpad for Ubuntu kernel, but it's also
present on the latest mainline kernel (4.8.0rc5) so I was asked to
open it here.
I've did my best to follow instructions on how to open kernel bugs,
but it's my 1st kernel bug report so I hope I haven't forgotten
important information you may need:


[1.] One line summary of the problem:

Synaptics touchpad fail to be configured by HID RMI on a HP Pavilion
x2 (12-b003nf)

[2.] Full description of the problem/report:

Touchpad on the HP Pavilion X2 is totally unresponsive after boot.
Logs (dmesg) show that initialization/configuration of the device by
the hid-rmi module failed:

[    6.032160] hid-rmi 0003:06CB:7D29.0001: No 2D sensor found, giving up.
[    6.032273] hid-rmi 0003:06CB:7D29.0001: Error while initializing F11 (-19).
[    6.044758] hid-rmi 0003:06CB:7D29.0001: hiddev0,hidraw1: USB HID
v1.11 Mouse [SYNAPTICS Synaptics HIDUSB TouchPad V03] on
usb-0000:00:14.0-2.1/input0
[    6.044761] hid-rmi 0003:06CB:7D29.0001: Device failed to be
properly configured

BIOS has been updated to the latest version but problem is still there.

$ sudo dmidecode -s bios-version && sudo dmidecode -s bios-release-date
F.14
06/24/2016


[3.] Keywords (i.e., modules, networking, kernel):

[4.] Kernel version (from /proc/version):

Linux version 4.8.0-040800rc5-generic (kernel@tangerine) (gcc version
6.2.0 20160830 (Ubuntu 6.2.0-2ubuntu11) ) #201609041832 SMP Sun Sep 4
22:34:01 UTC 2016

[5.] Output of Oops.. message (if applicable) with symbolic
information resolved (see Documentation/oops-tracing.txt)

Not applicable

[6.] A small shell script or example program which triggers the
problem (if possible)

Problem is immediately noticeable as of login screen, no need for
script/example program.


[7.] Environment

$ lsb_release -rd
Description: Ubuntu 16.04.1 LTS
Release: 16.04

[7.1.] Software (add the output of the ver_linux script here)

$ sh ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux X2 4.8.0-040800rc5-generic #201609041832 SMP Sun Sep 4 22:34:01
UTC 2016 x86_64 x86_64 x86_64 GNU/Linux

GNU C 5.4.0
GNU Make 4.1
Binutils 2.26.1
Util-linux 2.27.1
Mount 2.27.1
Module-init-tools 22
E2fsprogs 1.42.13
Pcmciautils 018
PPP 2.4.7
Linux C Library 2.23
Dynamic linker (ldd) 2.23
Linux C++ Library 6.0.21
Procps 3.3.10
Net-tools 1.60
Kbd 1.15.5
Console-tools 1.15.5
Sh-utils 8.25
Udev 229
Wireless-tools 30
Modules Loaded ablk_helper ac acpi_als acpi_pad acpi_thermal_rel
aesni_intel aes_x86_64 ahci arc4 autofs4 battery bluetooth bnep btbcm
btintel btqca btrtl btusb button ccm cfg80211 coretemp crc16
crc32c_intel crc32_pclmul crct10dif_pclmul cryptd ctr drm
drm_kms_helper efi_pstore efivarfs efivars evdev ext4 fat fb_sys_fops
fjes fscrypto fuse gf128mul ghash_clmulni_intel glue_helper hci_uart
hid hid_generic hid_multitouch hid_rmi hp_accel hp_wmi i2c_algo_bit
i2c_designware_core i2c_designware_platform i2c_hid i915 idma64
industrialio input_polldev int3400_thermal int3403_thermal
int340x_thermal_zone intel_cstate intel_lpss intel_lpss_acpi
intel_lpss_pci intel_pch_thermal intel_powerclamp intel_rapl
intel_rapl_perf intel_soc_dts_iosf intel_vbtn irqbypass iwlmvm iwlwifi
jbd2 joydev kfifo_buf kvm libahci libata lis3lv02d lp lrw mac80211
mbcache media mei mei_me mfd_core mmc_core nls_cp437 nls_utf8 parport
parport_pc ppdev processor_thermal_device rfcomm rfkill scsi_mod sdhci
sdhci_pci sd_mod serio_raw sg shpchp snd snd_compress snd_hda_codec
snd_hda_codec_generic snd_hda_codec_hdmi snd_hda_codec_realtek
snd_hda_core snd_hda_ext_core snd_hda_intel snd_hwdep snd_pcm
snd_pcm_dmaengine snd_rawmidi snd_seq snd_seq_device snd_seq_midi
snd_seq_midi_event snd_soc_core snd_soc_skl snd_soc_skl_ipc
snd_soc_sst_dsp snd_soc_sst_ipc snd_soc_sst_match snd_timer soundcore
sparse_keymap sunrpc syscopyarea sysfillrect sysimgblt thermal tpm
tpm_crb tpm_tis tpm_tis_core usb_common usbcore usbhid uvcvideo vfat
video videobuf2_core videobuf2_memops videobuf2_v4l2 videobuf2_vmalloc
videodev virt_dma wmi x86_pkg_temp_thermal xhci_hcd xhci_pci


[7.2.] Processor information (from /proc/cpuinfo):

$ cat /proc/cpuinfo
processor : 0
vendor_id : GenuineIntel
cpu family : 6
model : 78
model name : Intel(R) Core(TM) m3-6Y30 CPU @ 0.90GHz
stepping : 3
microcode : 0x82
cpu MHz : 499.969
cache size : 4096 KB
physical id : 0
siblings : 4
core id : 0
cpu cores : 2
apicid : 0
initial apicid : 0
fpu : yes
fpu_exception : yes
cpuid level : 22
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor
ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2
x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand
lahf_lm abm 3dnowprefetch epb intel_pt tpr_shadow vnmi flexpriority
ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid mpx
rdseed adx smap clflushopt xsaveopt xsavec xgetbv1 xsaves dtherm ida
arat pln pts hwp hwp_notify hwp_act_window hwp_epp
bugs :
bogomips : 3024.00
clflush size : 64
cache_alignment : 64
address sizes : 39 bits physical, 48 bits virtual
power management:

processor : 1
vendor_id : GenuineIntel
cpu family : 6
model : 78
model name : Intel(R) Core(TM) m3-6Y30 CPU @ 0.90GHz
stepping : 3
microcode : 0x82
cpu MHz : 499.969
cache size : 4096 KB
physical id : 0
siblings : 4
core id : 1
cpu cores : 2
apicid : 2
initial apicid : 2
fpu : yes
fpu_exception : yes
cpuid level : 22
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor
ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2
x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand
lahf_lm abm 3dnowprefetch epb intel_pt tpr_shadow vnmi flexpriority
ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid mpx
rdseed adx smap clflushopt xsaveopt xsavec xgetbv1 xsaves dtherm ida
arat pln pts hwp hwp_notify hwp_act_window hwp_epp
bugs :
bogomips : 3025.56
clflush size : 64
cache_alignment : 64
address sizes : 39 bits physical, 48 bits virtual
power management:

processor : 2
vendor_id : GenuineIntel
cpu family : 6
model : 78
model name : Intel(R) Core(TM) m3-6Y30 CPU @ 0.90GHz
stepping : 3
microcode : 0x82
cpu MHz : 499.969
cache size : 4096 KB
physical id : 0
siblings : 4
core id : 0
cpu cores : 2
apicid : 1
initial apicid : 1
fpu : yes
fpu_exception : yes
cpuid level : 22
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor
ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2
x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand
lahf_lm abm 3dnowprefetch epb intel_pt tpr_shadow vnmi flexpriority
ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid mpx
rdseed adx smap clflushopt xsaveopt xsavec xgetbv1 xsaves dtherm ida
arat pln pts hwp hwp_notify hwp_act_window hwp_epp
bugs :
bogomips : 3024.95
clflush size : 64
cache_alignment : 64
address sizes : 39 bits physical, 48 bits virtual
power management:

processor : 3
vendor_id : GenuineIntel
cpu family : 6
model : 78
model name : Intel(R) Core(TM) m3-6Y30 CPU @ 0.90GHz
stepping : 3
microcode : 0x82
cpu MHz : 499.969
cache size : 4096 KB
physical id : 0
siblings : 4
core id : 1
cpu cores : 2
apicid : 3
initial apicid : 3
fpu : yes
fpu_exception : yes
cpuid level : 22
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor
ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2
x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand
lahf_lm abm 3dnowprefetch epb intel_pt tpr_shadow vnmi flexpriority
ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid mpx
rdseed adx smap clflushopt xsaveopt xsavec xgetbv1 xsaves dtherm ida
arat pln pts hwp hwp_notify hwp_act_window hwp_epp
bugs :
bogomips : 3024.91
clflush size : 64
cache_alignment : 64
address sizes : 39 bits physical, 48 bits virtual
power management:



[7.3.] Module information (from /proc/modules):

$ cat /proc/modules
rfcomm 77824 2 - Live 0x0000000000000000
ctr 16384 4 - Live 0x0000000000000000
ccm 20480 2 - Live 0x0000000000000000
fuse 98304 2 - Live 0x0000000000000000
bnep 20480 2 - Live 0x0000000000000000
hid_multitouch 20480 0 - Live 0x0000000000000000
i2c_designware_platform 16384 0 - Live 0x0000000000000000
i2c_designware_core 20480 1 i2c_designware_platform, Live 0x0000000000000000
snd_soc_skl 65536 0 - Live 0x0000000000000000
hp_wmi 16384 0 - Live 0x0000000000000000
snd_soc_skl_ipc 40960 1 snd_soc_skl, Live 0x0000000000000000
snd_soc_sst_ipc 16384 1 snd_soc_skl_ipc, Live 0x0000000000000000
snd_hda_codec_hdmi 45056 1 - Live 0x0000000000000000
snd_soc_sst_dsp 28672 1 snd_soc_skl_ipc, Live 0x0000000000000000
snd_hda_ext_core 28672 1 snd_soc_skl, Live 0x0000000000000000
snd_soc_sst_match 16384 1 snd_soc_skl, Live 0x0000000000000000
snd_soc_core 217088 1 snd_soc_skl, Live 0x0000000000000000
snd_hda_codec_realtek 86016 1 - Live 0x0000000000000000
nls_utf8 16384 1 - Live 0x0000000000000000
snd_hda_codec_generic 69632 1 snd_hda_codec_realtek, Live 0x0000000000000000
nls_cp437 20480 1 - Live 0x0000000000000000
snd_compress 20480 1 snd_soc_core, Live 0x0000000000000000
vfat 20480 1 - Live 0x0000000000000000
snd_pcm_dmaengine 16384 1 snd_soc_core, Live 0x0000000000000000
snd_hda_intel 36864 3 - Live 0x0000000000000000
intel_rapl 20480 0 - Live 0x0000000000000000
fat 69632 1 vfat, Live 0x0000000000000000
x86_pkg_temp_thermal 16384 0 - Live 0x0000000000000000
snd_hda_codec 135168 4
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,
Live 0x0000000000000000
intel_powerclamp 16384 0 - Live 0x0000000000000000
coretemp 16384 0 - Live 0x0000000000000000
snd_hda_core 81920 7
snd_soc_skl,snd_hda_codec_hdmi,snd_hda_ext_core,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,
Live 0x0000000000000000
snd_hwdep 16384 1 snd_hda_codec, Live 0x0000000000000000
uvcvideo 90112 0 - Live 0x0000000000000000
snd_pcm 110592 8
snd_soc_skl,snd_hda_codec_hdmi,snd_hda_ext_core,snd_soc_core,snd_pcm_dmaengine,snd_hda_intel,snd_hda_codec,snd_hda_core,
Live 0x0000000000000000
kvm 593920 0 - Live 0x0000000000000000
snd_seq_midi 16384 0 - Live 0x0000000000000000
irqbypass 16384 1 kvm, Live 0x0000000000000000
videobuf2_vmalloc 16384 1 uvcvideo, Live 0x0000000000000000
crct10dif_pclmul 16384 0 - Live 0x0000000000000000
snd_seq_midi_event 16384 1 snd_seq_midi, Live 0x0000000000000000
crc32_pclmul 16384 0 - Live 0x0000000000000000
arc4 16384 2 - Live 0x0000000000000000
videobuf2_memops 16384 1 videobuf2_vmalloc, Live 0x0000000000000000
ghash_clmulni_intel 16384 0 - Live 0x0000000000000000
snd_rawmidi 32768 1 snd_seq_midi, Live 0x0000000000000000
videobuf2_v4l2 24576 1 uvcvideo, Live 0x0000000000000000
joydev 20480 0 - Live 0x0000000000000000
videobuf2_core 40960 2 uvcvideo,videobuf2_v4l2, Live 0x0000000000000000
aesni_intel 167936 4 - Live 0x0000000000000000
videodev 176128 3 uvcvideo,videobuf2_v4l2,videobuf2_core, Live
0x0000000000000000
aes_x86_64 20480 1 aesni_intel, Live 0x0000000000000000
lrw 16384 1 aesni_intel, Live 0x0000000000000000
snd_seq 69632 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
gf128mul 16384 1 lrw, Live 0x0000000000000000
glue_helper 16384 1 aesni_intel, Live 0x0000000000000000
ablk_helper 16384 1 aesni_intel, Live 0x0000000000000000
hid_rmi 24576 0 - Live 0x0000000000000000
cryptd 24576 3 ghash_clmulni_intel,aesni_intel,ablk_helper, Live
0x0000000000000000
media 40960 2 uvcvideo,videodev, Live 0x0000000000000000
snd_seq_device 16384 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x0000000000000000
snd_timer 32768 2 snd_pcm,snd_seq, Live 0x0000000000000000
iwlmvm 241664 0 - Live 0x0000000000000000
intel_cstate 20480 0 - Live 0x0000000000000000
intel_rapl_perf 16384 0 - Live 0x0000000000000000
mac80211 663552 1 iwlmvm, Live 0x0000000000000000
serio_raw 16384 0 - Live 0x0000000000000000
efi_pstore 16384 0 - Live 0x0000000000000000
iwlwifi 147456 1 iwlmvm, Live 0x0000000000000000
snd 86016 19 snd_hda_codec_hdmi,snd_soc_core,snd_hda_codec_realtek,snd_hda_codec_generic,snd_compress,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_seq_device,snd_timer,
Live 0x0000000000000000
efivars 20480 1 efi_pstore, Live 0x0000000000000000
soundcore 16384 1 snd, Live 0x0000000000000000
sg 32768 0 - Live 0x0000000000000000
cfg80211 589824 3 iwlmvm,mac80211,iwlwifi, Live 0x0000000000000000
btusb 45056 0 - Live 0x0000000000000000
btrtl 16384 1 btusb, Live 0x0000000000000000
hci_uart 86016 0 - Live 0x0000000000000000
mei_me 36864 0 - Live 0x0000000000000000
idma64 20480 0 - Live 0x0000000000000000
btbcm 16384 2 btusb,hci_uart, Live 0x0000000000000000
virt_dma 16384 1 idma64, Live 0x0000000000000000
mei 102400 1 mei_me, Live 0x0000000000000000
btqca 16384 1 hci_uart, Live 0x0000000000000000
intel_pch_thermal 16384 0 - Live 0x0000000000000000
processor_thermal_device 16384 0 - Live 0x0000000000000000
shpchp 36864 0 - Live 0x0000000000000000
intel_soc_dts_iosf 16384 1 processor_thermal_device, Live 0x0000000000000000
intel_lpss_pci 16384 0 - Live 0x0000000000000000
btintel 16384 2 btusb,hci_uart, Live 0x0000000000000000
bluetooth 548864 33
rfcomm,bnep,btusb,btrtl,hci_uart,btbcm,btqca,btintel, Live
0x0000000000000000
rfkill 24576 8 hp_wmi,cfg80211,bluetooth, Live 0x0000000000000000
battery 16384 0 - Live 0x0000000000000000
hp_accel 28672 0 - Live 0x0000000000000000
lis3lv02d 20480 1 hp_accel, Live 0x0000000000000000
intel_lpss_acpi 16384 0 - Live 0x0000000000000000
intel_vbtn 16384 0 - Live 0x0000000000000000
int3400_thermal 16384 0 - Live 0x0000000000000000
int3403_thermal 16384 0 - Live 0x0000000000000000
intel_lpss 16384 2 intel_lpss_pci,intel_lpss_acpi, Live 0x0000000000000000
sparse_keymap 16384 2 hp_wmi,intel_vbtn, Live 0x0000000000000000
input_polldev 16384 1 lis3lv02d, Live 0x0000000000000000
tpm_crb 16384 0 - Live 0x0000000000000000
acpi_pad 180224 0 - Live 0x0000000000000000
int340x_thermal_zone 16384 2 processor_thermal_device,int3403_thermal,
Live 0x0000000000000000
mfd_core 16384 1 intel_lpss, Live 0x0000000000000000
acpi_thermal_rel 16384 1 int3400_thermal, Live 0x0000000000000000
ac 16384 0 - Live 0x0000000000000000
acpi_als 16384 0 - Live 0x0000000000000000
kfifo_buf 16384 1 acpi_als, Live 0x0000000000000000
evdev 24576 19 - Live 0x0000000000000000
industrialio 65536 2 acpi_als,kfifo_buf, Live 0x0000000000000000
tpm_tis 16384 0 - Live 0x0000000000000000
tpm_tis_core 20480 1 tpm_tis, Live 0x0000000000000000
tpm 45056 3 tpm_crb,tpm_tis,tpm_tis_core, Live 0x0000000000000000
sunrpc 339968 1 - Live 0x0000000000000000
parport_pc 28672 0 - Live 0x0000000000000000
ppdev 20480 0 - Live 0x0000000000000000
lp 20480 0 - Live 0x0000000000000000
parport 49152 3 parport_pc,ppdev,lp, Live 0x0000000000000000
efivarfs 16384 1 - Live 0x0000000000000000
autofs4 40960 3 - Live 0x0000000000000000
ext4 589824 1 - Live 0x0000000000000000
crc16 16384 2 bluetooth,ext4, Live 0x0000000000000000
jbd2 110592 1 ext4, Live 0x0000000000000000
fscrypto 28672 1 ext4, Live 0x0000000000000000
mbcache 16384 2 ext4, Live 0x0000000000000000
sd_mod 45056 4 - Live 0x0000000000000000
hid_generic 16384 0 - Live 0x0000000000000000
usbhid 53248 0 - Live 0x0000000000000000
crc32c_intel 24576 0 - Live 0x0000000000000000
i915 1294336 4 - Live 0x0000000000000000
ahci 36864 3 - Live 0x0000000000000000
libahci 32768 1 ahci, Live 0x0000000000000000
libata 249856 2 ahci,libahci, Live 0x0000000000000000
i2c_algo_bit 16384 1 i915, Live 0x0000000000000000
xhci_pci 16384 0 - Live 0x0000000000000000
drm_kms_helper 155648 1 i915, Live 0x0000000000000000
scsi_mod 225280 3 sg,sd_mod,libata, Live 0x0000000000000000
syscopyarea 16384 1 drm_kms_helper, Live 0x0000000000000000
thermal 20480 0 - Live 0x0000000000000000
sysfillrect 16384 1 drm_kms_helper, Live 0x0000000000000000
xhci_hcd 188416 1 xhci_pci, Live 0x0000000000000000
sysimgblt 16384 1 drm_kms_helper, Live 0x0000000000000000
fb_sys_fops 16384 1 drm_kms_helper, Live 0x0000000000000000
sdhci_pci 28672 0 - Live 0x0000000000000000
drm 360448 5 i915,drm_kms_helper, Live 0x0000000000000000
sdhci 40960 1 sdhci_pci, Live 0x0000000000000000
usbcore 253952 5 uvcvideo,btusb,usbhid,xhci_pci,xhci_hcd, Live
0x0000000000000000
mmc_core 143360 2 sdhci_pci,sdhci, Live 0x0000000000000000
usb_common 16384 1 usbcore, Live 0x0000000000000000
wmi 16384 1 hp_wmi, Live 0x0000000000000000
i2c_hid 20480 0 - Live 0x0000000000000000
hid 118784 5 hid_multitouch,hid_rmi,hid_generic,usbhid,i2c_hid, Live
0x0000000000000000
video 40960 1 i915, Live 0x0000000000000000
fjes 28672 0 - Live 0x0000000000000000
button 16384 1 i915, Live 0x0000000000000000


[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

$ cat /proc/ioports
0000-0000 : PCI Bus 0000:00
  0000-0000 : dma1
  0000-0000 : pic1
  0000-0000 : timer0
  0000-0000 : timer1
  0000-0000 : keyboard
  0000-0000 : PNP0C09:00
    0000-0000 : EC data
  0000-0000 : keyboard
  0000-0000 : PNP0C09:00
    0000-0000 : EC cmd
  0000-0000 : rtc0
  0000-0000 : dma page reg
  0000-0000 : pic2
  0000-0000 : dma2
  0000-0000 : fpu
  0000-0000 : pnp 00:00
0000-0000 : PCI conf1
0000-0000 : PCI Bus 0000:00
  0000-0000 : pnp 00:00
  0000-0000 : pnp 00:00
    0000-0000 : ACPI PM1a_EVT_BLK
    0000-0000 : ACPI PM1a_CNT_BLK
    0000-0000 : ACPI PM_TMR
    0000-0000 : ACPI CPU throttle
    0000-0000 : ACPI PM2_CNT_BLK
    0000-0000 : pnp 00:02
    0000-0000 : ACPI GPE0_BLK
  0000-0000 : 0000:00:02.0
  0000-0000 : 0000:00:1f.4
  0000-0000 : 0000:00:17.0
    0000-0000 : ahci
  0000-0000 : 0000:00:17.0
    0000-0000 : ahci
  0000-0000 : 0000:00:17.0
    0000-0000 : ahci
  0000-0000 : pnp 00:00
    0000-0000 : pnp 00:00
      0000-0000 : pnp 00:00

$ cat /proc/iomem
00000000-00000000 : reserved
00000000-00000000 : System RAM
00000000-00000000 : reserved
00000000-00000000 : System RAM
00000000-00000000 : reserved
00000000-00000000 : PCI Bus 0000:00
00000000-00000000 : PCI Bus 0000:00
00000000-00000000 : PCI Bus 0000:00
00000000-00000000 : PCI Bus 0000:00
00000000-00000000 : PCI Bus 0000:00
00000000-00000000 : PCI Bus 0000:00
00000000-00000000 : PCI Bus 0000:00
00000000-00000000 : PCI Bus 0000:00
00000000-00000000 : PCI Bus 0000:00
00000000-00000000 : System ROM
00000000-00000000 : System RAM
  00000000-00000000 : Kernel code
  00000000-00000000 : Kernel data
  00000000-00000000 : Kernel bss
00000000-00000000 : ACPI Non-volatile Storage
00000000-00000000 : reserved
00000000-00000000 : System RAM
00000000-00000000 : reserved
00000000-00000000 : System RAM
00000000-00000000 : reserved
00000000-00000000 : ACPI Tables
00000000-00000000 : ACPI Non-volatile Storage
00000000-00000000 : reserved
00000000-00000000 : reserved
00000000-00000000 : System RAM
00000000-00000000 : RAM buffer
00000000-00000000 : reserved
00000000-00000000 : reserved
  00000000-00000000 : Graphics Stolen Memory
00000000-00000000 : PCI Bus 0000:00
  00000000-00000000 : 0000:00:02.0
    00000000-00000000 : BOOTFB
  00000000-00000000 : 0000:00:02.0
  00000000-00000000 : PCI Bus 0000:01
    00000000-00000000 : 0000:01:00.0
      00000000-00000000 : iwlwifi
  00000000-00000000 : 0000:00:1f.3
    00000000-00000000 : ICH HD audio
  00000000-00000000 : 0000:00:14.0
    00000000-00000000 : xhci-hcd
  00000000-00000000 : 0000:00:04.0
  00000000-00000000 : 0000:00:1f.3
    00000000-00000000 : ICH HD audio
  00000000-00000000 : 0000:00:1f.2
  00000000-00000000 : 0000:00:17.0
    00000000-00000000 : ahci
  00000000-00000000 : 0000:00:1f.4
  00000000-00000000 : 0000:00:1e.6
    00000000-00000000 : mmc0
  00000000-00000000 : 0000:00:1e.0
    00000000-00000000 : lpss_dev
      00000000-00000000 : serial
    00000000-00000000 : lpss_priv
    00000000-00000000 : idma64.2
      00000000-00000000 : idma64.2
  00000000-00000000 : 0000:00:17.0
    00000000-00000000 : ahci
  00000000-00000000 : 0000:00:17.0
    00000000-00000000 : ahci
  00000000-00000000 : 0000:00:16.0
    00000000-00000000 : mei_me
  00000000-00000000 : 0000:00:15.1
    00000000-00000000 : lpss_dev
      00000000-00000000 : lpss_dev
    00000000-00000000 : lpss_priv
    00000000-00000000 : idma64.1
      00000000-00000000 : idma64.1
  00000000-00000000 : 0000:00:15.0
    00000000-00000000 : lpss_dev
      00000000-00000000 : lpss_dev
    00000000-00000000 : lpss_priv
    00000000-00000000 : idma64.0
      00000000-00000000 : idma64.0
  00000000-00000000 : 0000:00:14.2
    00000000-00000000 : Intel PCH thermal driver
  00000000-00000000 : 0000:00:13.0
  00000000-00000000 : pnp 00:04
00000000-00000000 : PCI MMCONFIG 0000 [bus 00-ff]
  00000000-00000000 : reserved
    00000000-00000000 : pnp 00:04
00000000-00000000 : PCI Bus 0000:00
  00000000-00000000 : pnp 00:05
  00000000-00000000 : INT344B:00
    00000000-00000000 : INT344B:00
  00000000-00000000 : pnp 00:05
  00000000-00000000 : INT344B:00
    00000000-00000000 : INT344B:00
  00000000-00000000 : INT344B:00
    00000000-00000000 : INT344B:00
  00000000-00000000 : pnp 00:05
  00000000-00000000 : reserved
  00000000-00000000 : pnp 00:06
  00000000-00000000 : pnp 00:06
  00000000-00000000 : pnp 00:05
  00000000-00000000 : pnp 00:05
  00000000-00000000 : pnp 00:05
00000000-00000000 : reserved
  00000000-00000000 : IOAPIC 0
00000000-00000000 : HPET 0
  00000000-00000000 : PNP0103:00
00000000-00000000 : pnp 00:04
00000000-00000000 : pnp 00:04
00000000-00000000 : pnp 00:04
00000000-00000000 : pnp 00:04
00000000-00000000 : MSFT0101:00
00000000-00000000 : pnp 00:04
00000000-00000000 : dmar0
00000000-00000000 : dmar1
00000000-00000000 : Local APIC
  00000000-00000000 : reserved
00000000-00000000 : reserved
  00000000-00000000 : INT0800:00
    00000000-00000000 : pnp 00:04
00000000-00000000 : System RAM

[7.5.] PCI information ('lspci -vvv' as root)

$ sudo lspci -vvv
00:00.0 Host bridge: Intel Corporation Sky Lake Host Bridge/DRAM
Registers (rev 08)
Subsystem: Hewlett-Packard Company Skylake Host Bridge/DRAM Registers
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR- INTx-
Latency: 0
Capabilities: [e0] Vendor Specific Information: Len=10 <?>
Kernel driver in use: skl_uncore

00:02.0 VGA compatible controller: Intel Corporation Sky Lake
Integrated Graphics (rev 07) (prog-if 00 [VGA controller])
DeviceName:  Onboard IGD
Subsystem: Hewlett-Packard Company Skylake Integrated Graphics
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 277
Region 0: Memory at de000000 (64-bit, non-prefetchable) [size=16M]
Region 2: Memory at c0000000 (64-bit, prefetchable) [size=256M]
Region 4: I/O ports at f000 [size=64]
[virtual] Expansion ROM at 000c0000 [disabled] [size=128K]
Capabilities: [40] Vendor Specific Information: Len=0c <?>
Capabilities: [70] Express (v2) Root Complex Integrated Endpoint, MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0
ExtTag- RBE+
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF
Not Supported
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
Capabilities: [ac] MSI: Enable+ Count=1/1 Maskable- 64bit-
Address: fee00018  Data: 0000
Capabilities: [d0] Power Management version 2
Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [100 v1] #1b
Capabilities: [200 v1] Address Translation Service (ATS)
ATSCap: Invalidate Queue Depth: 00
ATSCtl: Enable-, Smallest Translation Unit: 00
Capabilities: [300 v1] #13
Kernel driver in use: i915
Kernel modules: i915

00:04.0 Signal processing controller: Intel Corporation Skylake
Processor Thermal Subsystem (rev 08)
Subsystem: Hewlett-Packard Company Skylake Processor Thermal Subsystem
Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Interrupt: pin A routed to IRQ 16
Region 0: Memory at df120000 (64-bit, non-prefetchable) [size=32K]
Capabilities: [90] MSI: Enable- Count=1/1 Maskable- 64bit-
Address: 00000000  Data: 0000
Capabilities: [d0] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [e0] Vendor Specific Information: Len=0c <?>
Kernel modules: processor_thermal_device

00:13.0 Non-VGA unclassified device: Intel Corporation Device 9d35 (rev 21)
Subsystem: Hewlett-Packard Company Device 8181
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Interrupt: pin A routed to IRQ 255
Region 0: Memory at df13b000 (64-bit, non-prefetchable) [disabled] [size=4K]
Capabilities: [80] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-

00:14.0 USB controller: Intel Corporation Sunrise Point-LP USB 3.0
xHCI Controller (rev 21) (prog-if 30 [XHCI])
Subsystem: Hewlett-Packard Company Sunrise Point-LP USB 3.0 xHCI Controller
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 275
Region 0: Memory at df110000 (64-bit, non-prefetchable) [size=64K]
Capabilities: [70] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
Address: 00000000fee00278  Data: 0000
Kernel driver in use: xhci_hcd
Kernel modules: xhci_pci

00:14.2 Signal processing controller: Intel Corporation Sunrise
Point-LP Thermal subsystem (rev 21)
Subsystem: Hewlett-Packard Company Sunrise Point-LP Thermal subsystem
Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Interrupt: pin C routed to IRQ 18
Region 0: Memory at df13a000 (64-bit, non-prefetchable) [size=4K]
Capabilities: [50] Power Management version 3
Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
Address: 00000000  Data: 0000
Kernel driver in use: intel_pch_thermal
Kernel modules: intel_pch_thermal

00:15.0 Signal processing controller: Intel Corporation Sunrise
Point-LP Serial IO I2C Controller (rev 21)
Subsystem: Hewlett-Packard Company Sunrise Point-LP Serial IO I2C Controller
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 16
Region 0: Memory at df139000 (64-bit, non-prefetchable) [size=4K]
Capabilities: [80] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [90] Vendor Specific Information: Len=14 <?>
Kernel driver in use: intel-lpss
Kernel modules: intel_lpss_pci

00:15.1 Signal processing controller: Intel Corporation Sunrise
Point-LP Serial IO I2C Controller (rev 21)
Subsystem: Hewlett-Packard Company Sunrise Point-LP Serial IO I2C Controller
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin B routed to IRQ 17
Region 0: Memory at df138000 (64-bit, non-prefetchable) [size=4K]
Capabilities: [80] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [90] Vendor Specific Information: Len=14 <?>
Kernel driver in use: intel-lpss
Kernel modules: intel_lpss_pci

00:16.0 Communication controller: Intel Corporation Sunrise Point-LP
CSME HECI (rev 21)
Subsystem: Hewlett-Packard Company Sunrise Point-LP CSME HECI
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 278
Region 0: Memory at df137000 (64-bit, non-prefetchable) [size=4K]
Capabilities: [50] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
Address: 00000000fee00318  Data: 0000
Kernel driver in use: mei_me
Kernel modules: mei_me

00:17.0 SATA controller: Intel Corporation Sunrise Point-LP SATA
Controller [AHCI mode] (rev 21) (prog-if 01 [AHCI 1.0])
Subsystem: Hewlett-Packard Company Sunrise Point-LP SATA Controller [AHCI mode]
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 276
Region 0: Memory at df130000 (32-bit, non-prefetchable) [size=8K]
Region 1: Memory at df136000 (32-bit, non-prefetchable) [size=256]
Region 2: I/O ports at f090 [size=8]
Region 3: I/O ports at f080 [size=4]
Region 4: I/O ports at f060 [size=32]
Region 5: Memory at df135000 (32-bit, non-prefetchable) [size=2K]
Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
Address: fee00298  Data: 0000
Capabilities: [70] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
Kernel driver in use: ahci
Kernel modules: ahci

00:1d.0 PCI bridge: Intel Corporation Device 9d18 (rev f1) (prog-if 00
[Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 274
Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
I/O behind bridge: 0000f000-00000fff
Memory behind bridge: df000000-df0fffff
Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
DevCap: MaxPayload 256 bytes, PhantFunc 0
ExtTag- RBE+
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
LnkCap: Port #9, Speed 8GT/s, Width x1, ASPM L1, Exit Latency L0s <1us, L1 <16us
ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+
BWMgmt+ ABWMgmt-
SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
Slot #12, PowerLimit 10.000W; Interlock- NoCompl+
SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
Changed: MRL- PresDet+ LinkState+
RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
RootCap: CRSVisible-
RootSta: PME ReqID 0000, PMEStatus- PMEPending-
DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Not
Supported ARIFwd+
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF
Disabled ARIFwd-
LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
Address: fee00238  Data: 0000
Capabilities: [90] Subsystem: Hewlett-Packard Company Device 8181
Capabilities: [a0] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [100 v0] #00
Capabilities: [140 v1] Access Control Services
ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd-
EgressCtrl- DirectTrans-
ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd-
EgressCtrl- DirectTrans-
Capabilities: [200 v1] L1 PM Substates
L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
 PortCommonModeRestoreTime=40us PortTPowerOnTime=10us
Capabilities: [220 v1] #19
Kernel driver in use: pcieport
Kernel modules: shpchp

00:1e.0 Signal processing controller: Intel Corporation Sunrise
Point-LP Serial IO UART Controller (rev 21)
Subsystem: Hewlett-Packard Company Sunrise Point-LP Serial IO UART Controller
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 20
Region 0: Memory at df134000 (64-bit, non-prefetchable) [size=4K]
Capabilities: [80] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [90] Vendor Specific Information: Len=14 <?>
Kernel driver in use: intel-lpss
Kernel modules: intel_lpss_pci

00:1e.6 SD Host controller: Intel Corporation Sunrise Point-LP Secure
Digital IO Controller (rev 21) (prog-if 01)
Subsystem: Hewlett-Packard Company Sunrise Point-LP Secure Digital IO Controller
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin D routed to IRQ 23
Region 0: Memory at df133000 (64-bit, non-prefetchable) [size=4K]
Capabilities: [80] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [90] Vendor Specific Information: Len=14 <?>
Kernel driver in use: sdhci-pci
Kernel modules: sdhci_pci

00:1f.0 ISA bridge: Intel Corporation Device 9d46 (rev 21)
Subsystem: Hewlett-Packard Company Device 8181
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0

00:1f.2 Memory controller: Intel Corporation Sunrise Point-LP PMC (rev 21)
Subsystem: Hewlett-Packard Company Sunrise Point-LP PMC
Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Region 0: Memory at df12c000 (32-bit, non-prefetchable) [size=16K]
Kernel driver in use: intel_pmc_core

00:1f.3 Audio device: Intel Corporation Sunrise Point-LP HD Audio (rev 21)
Subsystem: Hewlett-Packard Company Sunrise Point-LP HD Audio
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 32
Interrupt: pin A routed to IRQ 280
Region 0: Memory at df128000 (64-bit, non-prefetchable) [size=16K]
Region 4: Memory at df100000 (64-bit, non-prefetchable) [size=64K]
Capabilities: [50] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
Address: 00000000fee00358  Data: 0000
Kernel driver in use: snd_hda_intel
Kernel modules: snd_hda_intel, snd_soc_skl

00:1f.4 SMBus: Intel Corporation Sunrise Point-LP SMBus (rev 21)
Subsystem: Hewlett-Packard Company Sunrise Point-LP SMBus
Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Interrupt: pin A routed to IRQ 255
Region 0: Memory at df132000 (64-bit, non-prefetchable) [size=256]
Region 4: I/O ports at f040 [size=32]
Kernel modules: i2c_i801

01:00.0 Network controller: Intel Corporation Wireless 3165 (rev 81)
DeviceName: Intel Stone Peak 1
Subsystem: Intel Corporation Dual Band Wireless AC 3165
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 279
Region 0: Memory at df000000 (64-bit, non-prefetchable) [size=8K]
Capabilities: [c8] Power Management version 3
Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
Address: 00000000fee00338  Data: 0000
Capabilities: [40] Express (v2) Endpoint, MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 unlimited
ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+ FLReset-
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L1, Exit Latency L0s
<4us, L1 <32us
ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-
DevCap2: Completion Timeout: Range B, TimeoutDis+, LTR+, OBFF Via WAKE#
DevCtl2: Completion Timeout: 16ms to 55ms, TimeoutDis-, LTR+, OBFF Disabled
LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
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
AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
Capabilities: [140 v1] Device Serial Number 08-d4-0c-ff-ff-2c-7c-07
Capabilities: [14c v1] Latency Tolerance Reporting
Max snoop latency: 3145728ns
Max no snoop latency: 3145728ns
Capabilities: [154 v1] L1 PM Substates
L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
 PortCommonModeRestoreTime=30us PortTPowerOnTime=60us
Kernel driver in use: iwlwifi
Kernel modules: iwlwifi



[7.6.] SCSI information (from /proc/scsi/scsi)

No /proc/scsi/scsi

[7.7.] Other information that might be relevant to the problem (please
look in /proc and include all information that you think to be
relevant):


[X.] Other notes, patches, fixes, workarounds:

Bug initially reported on Launchpad:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1611081
