From: Colin Johnstone <johnstone.colin@gmail.com>
Subject: PROBLEM: i2c_hid: probe of i2c-ELAN0732:00 failed with error -61
Date: Sat, 3 Sep 2016 14:33:55 -0400
Message-ID: <CABgo8p4OPGzbezWde_s2p467YGtFSemFqxfUY9J6B-3GH4+1iQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f41.google.com ([209.85.213.41]:36534 "EHLO
        mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752852AbcICSmJ (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 3 Sep 2016 14:42:09 -0400
Received: by mail-vk0-f41.google.com with SMTP id w124so49739580vkd.3
        for <linux-input@vger.kernel.org>; Sat, 03 Sep 2016 11:42:08 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

[1.] One line summary of the problem: Touchscreen does not work, dmesg
shows errors "i2c_hid i2c-ELAN0732:00: failed to reset device",
"i2c_hid i2c-ELAN0732:00: can't add hid device: -61", and "i2c_hid:
probe of i2c-ELAN0732:00 failed with error -61" occur during boot.

[2.] Full description of the problem/report: This is on an HP Eny x360
M6-AR004DX laptop with 7th-generation AMD FX CPU. The touchscreen is
not recognized at all; it appears the screen is using GPIO interrupts
as I have to build with AMD GPIO support to receive these errors,
otherwise I see a "failed to get GPIO interrupt" error.

[3.] Keywords (i.e., modules, networking, kernel):

[4.] Kernel version (from /proc/version): Linux version
4.8.0-040800rc4-generic (kernel@gomeisa) (gcc version 6.2.0 20160824
(Ubuntu 6.2.0-1ubuntu12) ) #201608312129 SMP Thu Sep 1 01:31:59 UTC
2016

[5.] Output of Oops.. message (if applicable) with symbolic
information resolved (see Documentation/oops-tracing.txt): Not
applicable

[6.] A small shell script or example program which triggers the
problem (if possible): Not applicable

[7.] Environment: Description: Ubuntu 16.04.1 LTS Release: 16.04

[7.1.] Software (add the output of the ver_linux script here):
Linux Masaq 4.8.0-040800rc4-generic #201608312129 SMP Thu Sep 1
01:31:59 UTC 2016 x86_64 x86_64 x86_64 GNU/Linux

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
Modules Loaded ablk_helper ac acpi_cpufreq aesni_intel aes_x86_64
af_alg ahci algif_skcipher amdgpu amdkfd arc4 autofs4 battery
binfmt_misc bluetooth bnep bridge btbcm btintel btrtl btusb button ccm
cfg80211 crc16 crc32c_intel crc32_pclmul crct10dif_pclmul cryptd ctr
dm_crypt dm_mod drm drm_kms_helper ebtable_filter ebtables efi_pstore
efivarfs efivars ehci_hcd ehci_pci evdev ext4 fam15h_power fat fjes
fscrypto fuse gf128mul ghash_clmulni_intel glue_helper hid
hid_sensor_accel_3d hid_sensor_gyro_3d hid_sensor_hub
hid_sensor_iio_common hid_sensor_incl_3d hid_sensor_magn_3d
hid_sensor_rotation hid_sensor_trigger hp_accel hp_wireless hp_wmi
i2c_algo_bit i2c_designware_core i2c_designware_platform i2c_hid
i2c_piix4 industrialio industrialio_triggered_buffer input_polldev
ip6table_filter ip6_tables ip6_udp_tunnel iptable_filter
iptable_mangle iptable_nat ip_tables ipt_MASQUERADE ipt_REJECT
irqbypass iwlmvm iwlwifi jbd2 joydev k10temp kfifo_buf kvm kvm_amd
l2tp_core l2tp_netlink l2tp_ppp libahci libata lis3lv02d llc lp lrw
mac80211 macvlan macvtap mbcache media memstick mfd_core mmc_core msr
nf_conntrack nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat nf_nat_ipv4
nf_nat_masquerade_ipv4 nf_reject_ipv4 nls_cp437 nls_utf8 nvram parport
parport_pc ppdev ppp_generic pppox psmouse rfcomm rfkill rtsx_pci
rtsx_pci_ms rtsx_pci_sdmmc scsi_mod sd_mod serio_raw sg shpchp slhc
snd snd_hda_codec snd_hda_codec_conexant snd_hda_codec_generic
snd_hda_codec_hdmi snd_hda_core snd_hda_intel snd_hwdep snd_pcm
snd_rawmidi snd_seq snd_seq_device snd_seq_midi snd_seq_midi_event
snd_timer soundcore sparse_keymap stp thermal tpm tpm_crb tpm_tis
tpm_tis_core ttm tun udp_tunnel usb_common usbcore usbhid uvcvideo
vfat vhost vhost_net video videobuf2_core videobuf2_memops
videobuf2_v4l2 videobuf2_vmalloc videodev wmi xhci_hcd xhci_pci
x_tables xt_CHECKSUM xt_conntrack xt_tcpudp

[7.2.] Processor information (from /proc/cpuinfo):
processor : 0
vendor_id : AuthenticAMD
cpu family : 21
model : 101
model name : AMD FX-9800P RADEON R7, 12 COMPUTE CORES 4C+8G
stepping : 1
microcode : 0x6006113
cpu MHz : 1400.000
cache size : 1024 KB
physical id : 0
siblings : 4
core id : 0
cpu cores : 2
apicid : 16
initial apicid : 0
fpu : yes
fpu_exception : yes
cpuid level : 13
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
pdpe1gb rdtscp lm constant_tsc rep_good acc_power nopl nonstop_tsc
extd_apicid aperfmperf eagerfpu pni pclmulqdq monitor ssse3 fma cx16
sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm
cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch
osvw ibs xop skinit wdt lwp fma4 tce nodeid_msr tbm topoext
perfctr_core perfctr_nb bpext ptsc mwaitx cpb hw_pstate vmmcall
fsgsbase bmi1 avx2 smep bmi2 xsaveopt arat npt lbrv svm_lock nrip_save
tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold
avic overflow_recov
bugs : fxsave_leak sysret_ss_attrs null_seg
bogomips : 5390.07
TLB size : 1536 4K pages
clflush size : 64
cache_alignment : 64
address sizes : 48 bits physical, 48 bits virtual
power management: ts ttp tm 100mhzsteps hwpstate cpb eff_freq_ro acc_power [13]


processor : 1
vendor_id : AuthenticAMD
cpu family : 21
model : 101
model name : AMD FX-9800P RADEON R7, 12 COMPUTE CORES 4C+8G
stepping : 1
microcode : 0x6006113
cpu MHz : 1400.000
cache size : 1024 KB
physical id : 0
siblings : 4
core id : 0
cpu cores : 2
apicid : 17
initial apicid : 1
fpu : yes
fpu_exception : yes
cpuid level : 13
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
pdpe1gb rdtscp lm constant_tsc rep_good acc_power nopl nonstop_tsc
extd_apicid aperfmperf eagerfpu pni pclmulqdq monitor ssse3 fma cx16
sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm
cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch
osvw ibs xop skinit wdt lwp fma4 tce nodeid_msr tbm topoext
perfctr_core perfctr_nb bpext ptsc mwaitx cpb hw_pstate vmmcall
fsgsbase bmi1 avx2 smep bmi2 xsaveopt arat npt lbrv svm_lock nrip_save
tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold
avic overflow_recov
bugs : fxsave_leak sysret_ss_attrs null_seg
bogomips : 5378.04
TLB size : 1536 4K pages
clflush size : 64
cache_alignment : 64
address sizes : 48 bits physical, 48 bits virtual
power management: ts ttp tm 100mhzsteps hwpstate cpb eff_freq_ro acc_power [13]


processor : 2
vendor_id : AuthenticAMD
cpu family : 21
model : 101
model name : AMD FX-9800P RADEON R7, 12 COMPUTE CORES 4C+8G
stepping : 1
microcode : 0x6006113
cpu MHz : 1800.000
cache size : 1024 KB
physical id : 0
siblings : 4
core id : 1
cpu cores : 2
apicid : 18
initial apicid : 2
fpu : yes
fpu_exception : yes
cpuid level : 13
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
pdpe1gb rdtscp lm constant_tsc rep_good acc_power nopl nonstop_tsc
extd_apicid aperfmperf eagerfpu pni pclmulqdq monitor ssse3 fma cx16
sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm
cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch
osvw ibs xop skinit wdt lwp fma4 tce nodeid_msr tbm topoext
perfctr_core perfctr_nb bpext ptsc mwaitx cpb hw_pstate vmmcall
fsgsbase bmi1 avx2 smep bmi2 xsaveopt arat npt lbrv svm_lock nrip_save
tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold
avic overflow_recov
bugs : fxsave_leak sysret_ss_attrs null_seg
bogomips : 5378.04
TLB size : 1536 4K pages
clflush size : 64
cache_alignment : 64
address sizes : 48 bits physical, 48 bits virtual
power management: ts ttp tm 100mhzsteps hwpstate cpb eff_freq_ro acc_power [13]


processor : 3
vendor_id : AuthenticAMD
cpu family : 21
model : 101
model name : AMD FX-9800P RADEON R7, 12 COMPUTE CORES 4C+8G
stepping : 1
microcode : 0x6006113
cpu MHz : 1400.000
cache size : 1024 KB
physical id : 0
siblings : 4
core id : 1
cpu cores : 2
apicid : 19
initial apicid : 3
fpu : yes
fpu_exception : yes
cpuid level : 13
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
pdpe1gb rdtscp lm constant_tsc rep_good acc_power nopl nonstop_tsc
extd_apicid aperfmperf eagerfpu pni pclmulqdq monitor ssse3 fma cx16
sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm
cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch
osvw ibs xop skinit wdt lwp fma4 tce nodeid_msr tbm topoext
perfctr_core perfctr_nb bpext ptsc mwaitx cpb hw_pstate vmmcall
fsgsbase bmi1 avx2 smep bmi2 xsaveopt arat npt lbrv svm_lock nrip_save
tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold
avic overflow_recov
bugs : fxsave_leak sysret_ss_attrs null_seg
bogomips : 5378.04
TLB size : 1536 4K pages
clflush size : 64
cache_alignment : 64
address sizes : 48 bits physical, 48 bits virtual
power management: ts ttp tm 100mhzsteps hwpstate cpb eff_freq_ro acc_power [13]

[7.3.] Module information (from /proc/modules):
fuse 98304 2 - Live 0x0000000000000000
rfcomm 77824 2 - Live 0x0000000000000000
xt_CHECKSUM 16384 1 - Live 0x0000000000000000
iptable_mangle 16384 1 - Live 0x0000000000000000
ipt_MASQUERADE 16384 3 - Live 0x0000000000000000
nf_nat_masquerade_ipv4 16384 1 ipt_MASQUERADE, Live 0x0000000000000000
iptable_nat 16384 1 - Live 0x0000000000000000
nf_nat_ipv4 16384 1 iptable_nat, Live 0x0000000000000000
nf_nat 28672 2 nf_nat_masquerade_ipv4,nf_nat_ipv4, Live 0x0000000000000000
nf_conntrack_ipv4 20480 2 - Live 0x0000000000000000
nf_defrag_ipv4 16384 1 nf_conntrack_ipv4, Live 0x0000000000000000
xt_conntrack 16384 1 - Live 0x0000000000000000
nf_conntrack 114688 5
nf_nat_masquerade_ipv4,nf_nat_ipv4,nf_nat,nf_conntrack_ipv4,xt_conntrack,
Live 0x0000000000000000
ipt_REJECT 16384 2 - Live 0x0000000000000000
nf_reject_ipv4 16384 1 ipt_REJECT, Live 0x0000000000000000
xt_tcpudp 16384 6 - Live 0x0000000000000000
bridge 135168 0 - Live 0x0000000000000000
stp 16384 1 bridge, Live 0x0000000000000000
llc 16384 2 bridge,stp, Live 0x0000000000000000
ctr 16384 4 - Live 0x0000000000000000
ccm 20480 2 - Live 0x0000000000000000
ebtable_filter 16384 0 - Live 0x0000000000000000
ebtables 36864 1 ebtable_filter, Live 0x0000000000000000
ip6table_filter 16384 0 - Live 0x0000000000000000
ip6_tables 28672 1 ip6table_filter, Live 0x0000000000000000
iptable_filter 16384 1 - Live 0x0000000000000000
ip_tables 28672 3 iptable_mangle,iptable_nat,iptable_filter, Live
0x0000000000000000
x_tables 36864 11
xt_CHECKSUM,iptable_mangle,ipt_MASQUERADE,xt_conntrack,ipt_REJECT,xt_tcpudp,ebtables,ip6table_filter,ip6_tables,iptable_filter,ip_tables,
Live 0x0000000000000000
l2tp_ppp 24576 0 - Live 0x0000000000000000
l2tp_netlink 20480 1 l2tp_ppp, Live 0x0000000000000000
l2tp_core 32768 2 l2tp_ppp,l2tp_netlink, Live 0x0000000000000000
ip6_udp_tunnel 16384 1 l2tp_core, Live 0x0000000000000000
udp_tunnel 16384 1 l2tp_core, Live 0x0000000000000000
pppox 16384 1 l2tp_ppp, Live 0x0000000000000000
ppp_generic 36864 2 l2tp_ppp,pppox, Live 0x0000000000000000
slhc 16384 1 ppp_generic, Live 0x0000000000000000
bnep 20480 2 - Live 0x0000000000000000
binfmt_misc 20480 1 - Live 0x0000000000000000
nls_utf8 16384 1 - Live 0x0000000000000000
nls_cp437 20480 1 - Live 0x0000000000000000
vfat 20480 1 - Live 0x0000000000000000
fat 69632 1 vfat, Live 0x0000000000000000
hid_sensor_rotation 16384 0 - Live 0x0000000000000000
hid_sensor_incl_3d 16384 0 - Live 0x0000000000000000
hid_sensor_magn_3d 16384 1 - Live 0x0000000000000000
hid_sensor_gyro_3d 16384 0 - Live 0x0000000000000000
hid_sensor_accel_3d 16384 1 - Live 0x0000000000000000
hid_sensor_trigger 16384 10
hid_sensor_rotation,hid_sensor_incl_3d,hid_sensor_magn_3d,hid_sensor_gyro_3d,hid_sensor_accel_3d,
Live 0x0000000000000000
hid_sensor_iio_common 16384 6
hid_sensor_rotation,hid_sensor_incl_3d,hid_sensor_magn_3d,hid_sensor_gyro_3d,hid_sensor_accel_3d,hid_sensor_trigger,
Live 0x0000000000000000
industrialio_triggered_buffer 16384 5
hid_sensor_incl_3d,hid_sensor_rotation,hid_sensor_magn_3d,hid_sensor_gyro_3d,hid_sensor_accel_3d,
Live 0x0000000000000000
kfifo_buf 16384 1 industrialio_triggered_buffer, Live 0x0000000000000000
industrialio 65536 10
hid_sensor_rotation,hid_sensor_incl_3d,hid_sensor_magn_3d,hid_sensor_gyro_3d,hid_sensor_accel_3d,hid_sensor_trigger,industrialio_triggered_buffer,kfifo_buf,
Live 0x0000000000000000
uvcvideo 90112 0 - Live 0x0000000000000000
videobuf2_vmalloc 16384 1 uvcvideo, Live 0x0000000000000000
videobuf2_memops 16384 1 videobuf2_vmalloc, Live 0x0000000000000000
videobuf2_v4l2 24576 1 uvcvideo, Live 0x0000000000000000
videobuf2_core 40960 2 uvcvideo,videobuf2_v4l2, Live 0x0000000000000000
videodev 176128 3 uvcvideo,videobuf2_v4l2,videobuf2_core, Live
0x0000000000000000
media 40960 2 uvcvideo,videodev, Live 0x0000000000000000
hid_sensor_hub 20480 7
hid_sensor_rotation,hid_sensor_incl_3d,hid_sensor_magn_3d,hid_sensor_gyro_3d,hid_sensor_accel_3d,hid_sensor_trigger,hid_sensor_iio_common,
Live 0x0000000000000000
btusb 45056 0 - Live 0x0000000000000000
btrtl 16384 1 btusb, Live 0x0000000000000000
btbcm 16384 1 btusb, Live 0x0000000000000000
btintel 16384 1 btusb, Live 0x0000000000000000
bluetooth 544768 31 rfcomm,bnep,btusb,btrtl,btbcm,btintel, Live
0x0000000000000000
arc4 16384 2 - Live 0x0000000000000000
iwlmvm 241664 0 - Live 0x0000000000000000
mac80211 663552 1 iwlmvm, Live 0x0000000000000000
nvram 16384 0 - Live 0x0000000000000000
iwlwifi 147456 1 iwlmvm, Live 0x0000000000000000
msr 16384 0 - Live 0x0000000000000000
snd_hda_codec_conexant 24576 1 - Live 0x0000000000000000
snd_hda_codec_hdmi 45056 1 - Live 0x0000000000000000
snd_hda_codec_generic 69632 1 snd_hda_codec_conexant, Live 0x0000000000000000
snd_hda_intel 36864 10 - Live 0x0000000000000000
snd_hda_codec 131072 4
snd_hda_codec_conexant,snd_hda_codec_hdmi,snd_hda_codec_generic,snd_hda_intel,
Live 0x0000000000000000
snd_hda_core 81920 5
snd_hda_codec_conexant,snd_hda_codec_hdmi,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,
Live 0x0000000000000000
cfg80211 589824 3 iwlmvm,mac80211,iwlwifi, Live 0x0000000000000000
snd_hwdep 16384 1 snd_hda_codec, Live 0x0000000000000000
hp_wmi 16384 0 - Live 0x0000000000000000
snd_pcm 110592 4
snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec,snd_hda_core, Live
0x0000000000000000
snd_seq_midi 16384 0 - Live 0x0000000000000000
snd_seq_midi_event 16384 1 snd_seq_midi, Live 0x0000000000000000
sparse_keymap 16384 1 hp_wmi, Live 0x0000000000000000
snd_rawmidi 32768 1 snd_seq_midi, Live 0x0000000000000000
rfkill 24576 8 bluetooth,cfg80211,hp_wmi, Live 0x0000000000000000
snd_seq 69632 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
snd_seq_device 16384 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x0000000000000000
snd_timer 32768 2 snd_pcm,snd_seq, Live 0x0000000000000000
snd 86016 31 snd_hda_codec_conexant,snd_hda_codec_hdmi,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_seq_device,snd_timer,
Live 0x0000000000000000
kvm_amd 73728 0 - Live 0x0000000000000000
rtsx_pci_ms 20480 0 - Live 0x0000000000000000
memstick 20480 1 rtsx_pci_ms, Live 0x0000000000000000
hp_accel 28672 0 - Live 0x0000000000000000
lis3lv02d 20480 1 hp_accel, Live 0x0000000000000000
kvm 593920 1 kvm_amd, Live 0x0000000000000000
joydev 20480 0 - Live 0x0000000000000000
input_polldev 16384 1 lis3lv02d, Live 0x0000000000000000
efi_pstore 16384 0 - Live 0x0000000000000000
soundcore 16384 1 snd, Live 0x0000000000000000
serio_raw 16384 0 - Live 0x0000000000000000
sg 32768 0 - Live 0x0000000000000000
efivars 20480 1 efi_pstore, Live 0x0000000000000000
k10temp 16384 0 - Live 0x0000000000000000
fam15h_power 16384 0 - Live 0x0000000000000000
i2c_designware_platform 16384 0 - Live 0x0000000000000000
battery 16384 0 - Live 0x0000000000000000
ac 16384 0 - Live 0x0000000000000000
shpchp 36864 0 - Live 0x0000000000000000
tpm_crb 16384 0 - Live 0x0000000000000000
evdev 24576 31 - Live 0x0000000000000000
irqbypass 16384 1 kvm, Live 0x0000000000000000
i2c_designware_core 20480 1 i2c_designware_platform, Live 0x0000000000000000
i2c_piix4 24576 0 - Live 0x0000000000000000
hp_wireless 16384 0 - Live 0x0000000000000000
acpi_cpufreq 20480 0 - Live 0x0000000000000000
tpm_tis 16384 0 - Live 0x0000000000000000
tpm_tis_core 20480 1 tpm_tis, Live 0x0000000000000000
tpm 45056 3 tpm_crb,tpm_tis,tpm_tis_core, Live 0x0000000000000000
vhost_net 20480 0 - Live 0x0000000000000000
tun 28672 2 vhost_net, Live 0x0000000000000000
vhost 45056 1 vhost_net, Live 0x0000000000000000
macvtap 24576 1 vhost_net, Live 0x0000000000000000
macvlan 24576 1 macvtap, Live 0x0000000000000000
parport_pc 28672 0 - Live 0x0000000000000000
ppdev 20480 0 - Live 0x0000000000000000
lp 20480 0 - Live 0x0000000000000000
parport 49152 3 parport_pc,ppdev,lp, Live 0x0000000000000000
efivarfs 16384 1 - Live 0x0000000000000000
autofs4 40960 2 - Live 0x0000000000000000
ext4 589824 2 - Live 0x0000000000000000
crc16 16384 2 bluetooth,ext4, Live 0x0000000000000000
jbd2 110592 1 ext4, Live 0x0000000000000000
fscrypto 28672 1 ext4, Live 0x0000000000000000
mbcache 16384 3 ext4, Live 0x0000000000000000
algif_skcipher 20480 0 - Live 0x0000000000000000
af_alg 16384 1 algif_skcipher, Live 0x0000000000000000
dm_crypt 24576 1 - Live 0x0000000000000000
dm_mod 114688 9 dm_crypt, Live 0x0000000000000000
sd_mod 45056 4 - Live 0x0000000000000000
usbhid 53248 0 - Live 0x0000000000000000
rtsx_pci_sdmmc 24576 0 - Live 0x0000000000000000
mmc_core 143360 1 rtsx_pci_sdmmc, Live 0x0000000000000000
crct10dif_pclmul 16384 0 - Live 0x0000000000000000
crc32_pclmul 16384 0 - Live 0x0000000000000000
crc32c_intel 24576 0 - Live 0x0000000000000000
ghash_clmulni_intel 16384 0 - Live 0x0000000000000000
aesni_intel 167936 7 - Live 0x0000000000000000
aes_x86_64 20480 1 aesni_intel, Live 0x0000000000000000
lrw 16384 1 aesni_intel, Live 0x0000000000000000
gf128mul 16384 1 lrw, Live 0x0000000000000000
psmouse 131072 0 - Live 0x0000000000000000
glue_helper 16384 1 aesni_intel, Live 0x0000000000000000
ablk_helper 16384 1 aesni_intel, Live 0x0000000000000000
cryptd 24576 4 ghash_clmulni_intel,aesni_intel,ablk_helper, Live
0x0000000000000000
amdkfd 139264 1 - Live 0x0000000000000000
amdgpu 1187840 9 - Live 0x0000000000000000
xhci_pci 16384 0 - Live 0x0000000000000000
rtsx_pci 57344 2 rtsx_pci_ms,rtsx_pci_sdmmc, Live 0x0000000000000000
xhci_hcd 188416 1 xhci_pci, Live 0x0000000000000000
mfd_core 16384 2 hid_sensor_hub,rtsx_pci, Live 0x0000000000000000
ahci 36864 3 - Live 0x0000000000000000
libahci 32768 1 ahci, Live 0x0000000000000000
libata 249856 2 ahci,libahci, Live 0x0000000000000000
i2c_algo_bit 16384 1 amdgpu, Live 0x0000000000000000
ttm 98304 1 amdgpu, Live 0x0000000000000000
ehci_pci 16384 0 - Live 0x0000000000000000
ehci_hcd 81920 1 ehci_pci, Live 0x0000000000000000
drm_kms_helper 155648 1 amdgpu, Live 0x0000000000000000
scsi_mod 225280 3 sg,sd_mod,libata, Live 0x0000000000000000
usbcore 253952 8
uvcvideo,btusb,usbhid,xhci_pci,xhci_hcd,ehci_pci,ehci_hcd, Live
0x0000000000000000
drm 360448 12 amdgpu,ttm,drm_kms_helper, Live 0x0000000000000000
usb_common 16384 1 usbcore, Live 0x0000000000000000
video 40960 0 - Live 0x0000000000000000
thermal 20480 0 - Live 0x0000000000000000
i2c_hid 20480 0 - Live 0x0000000000000000
hid 118784 3 hid_sensor_hub,usbhid,i2c_hid, Live 0x0000000000000000
fjes 28672 0 - Live 0x0000000000000000
wmi 16384 1 hp_wmi, Live 0x0000000000000000
button 16384 0 - Live 0x0000000000000000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem):
0000-0000 : PCI Bus 0000:00
0000-0000 : dma1
0000-0000 : pic1
0000-0000 : timer0
0000-0000 : timer1
0000-0000 : keyboard
0000-0000 : PNP0800:00
0000-0000 : PNP0C09:00
0000-0000 : EC data
0000-0000 : keyboard
0000-0000 : PNP0C09:00
0000-0000 : EC cmd
0000-0000 : PNP0C09:00
0000-0000 : rtc0
0000-0000 : dma page reg
0000-0000 : pic2
0000-0000 : dma2
0000-0000 : fpu
0000-0000 : PNP0C04:00
0000-0000 : pnp 00:02
0000-0000 : ACPI PM1a_EVT_BLK
0000-0000 : ACPI PM1a_CNT_BLK
0000-0000 : ACPI PM_TMR
0000-0000 : ACPI CPU throttle
0000-0000 : ACPI GPE0_BLK
0000-0000 : pnp 00:02
0000-0000 : pnp 00:02
0000-0000 : ACPI PM2_CNT_BLK
0000-0000 : piix4_smbus
0000-0000 : SMB0001:00
0000-0000 : pnp 00:02
0000-0000 : pnp 00:02
0000-0000 : pnp 00:02
0000-0000 : pnp 00:02
0000-0000 : pnp 00:02
0000-0000 : pnp 00:02
0000-0000 : smba_idx
0000-0000 : PCI conf1
0000-0000 : PCI Bus 0000:00
0000-0000 : 0000:00:01.0
0000-0000 : 0000:00:11.0
0000-0000 : ahci
0000-0000 : 0000:00:11.0
0000-0000 : ahci
0000-0000 : 0000:00:11.0
0000-0000 : ahci
0000-0000 : 0000:00:11.0
0000-0000 : ahci
0000-0000 : 0000:00:11.0
0000-0000 : ahci
00000000-00000000 : reserved
00000000-00000000 : System RAM
00000000-00000000 : reserved
00000000-00000000 : System RAM
00000000-00000000 : PCI Bus 0000:00
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
00000000-00000000 : PCI Bus 0000:00
00000000-00000000 : PCI Bus 0000:00
00000000-00000000 : PCI Bus 0000:00
00000000-00000000 : System ROM
00000000-00000000 : System RAM
00000000-00000000 : Kernel code
00000000-00000000 : Kernel data
00000000-00000000 : Kernel bss
00000000-00000000 : reserved
00000000-00000000 : reserved
00000000-00000000 : ACPI Non-volatile Storage
00000000-00000000 : MSFT0101:00
00000000-00000000 : MSFT0101:00
00000000-00000000 : ACPI Tables
00000000-00000000 : System RAM
00000000-00000000 : reserved
00000000-00000000 : PCI Bus 0000:00
00000000-00000000 : 0000:00:01.0
00000000-00000000 : BOOTFB
00000000-00000000 : 0000:00:01.0
00000000-00000000 : reserved
00000000-00000000 : pnp 00:00
00000000-00000000 : 0000:00:08.0
00000000-00000000 : PCI Bus 0000:02
00000000-00000000 : 0000:02:00.0
00000000-00000000 : iwlwifi
00000000-00000000 : PCI Bus 0000:01
00000000-00000000 : 0000:01:00.0
00000000-00000000 : rtsx_pci
00000000-00000000 : 0000:00:01.0
00000000-00000000 : 0000:00:08.0
00000000-00000000 : 0000:00:01.1
00000000-00000000 : ICH HD audio
00000000-00000000 : 0000:00:09.2
00000000-00000000 : ICH HD audio
00000000-00000000 : 0000:00:10.0
00000000-00000000 : xhci-hcd
00000000-00000000 : 0000:00:08.0
00000000-00000000 : 0000:00:11.0
00000000-00000000 : ahci
00000000-00000000 : 0000:00:12.0
00000000-00000000 : ehci_hcd
00000000-00000000 : 0000:00:08.0
00000000-00000000 : PCI MMCONFIG 0000 [bus 00-3f]
00000000-00000000 : reserved
00000000-00000000 : PCI Bus 0000:00
00000000-00000000 : amd_iommu
00000000-00000000 : PNP0C09:00
00000000-00000000 : reserved
00000000-00000000 : IOAPIC 0
00000000-00000000 : IOAPIC 1
00000000-00000000 : reserved
00000000-00000000 : HPET 0
00000000-00000000 : PNP0103:00
00000000-00000000 : reserved
00000000-00000000 : AMD0030:00
00000000-00000000 : AMD0010:00
00000000-00000000 : AMD0010:00
00000000-00000000 : AMD0010:01
00000000-00000000 : AMD0010:01
00000000-00000000 : AMD0020:00
00000000-00000000 : serial
00000000-00000000 : Local APIC
00000000-00000000 : reserved
00000000-00000000 : pnp 00:00
00000000-00000000 : reserved
00000000-00000000 : pnp 00:03
00000000-00000000 : System RAM
00000000-00000000 : reserved

[7.5.] PCI information ('lspci -vvv' as root):
00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1576
Subsystem: Hewlett-Packard Company Device 81aa
Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0


00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Device 1577
Subsystem: Hewlett-Packard Company Device 81aa
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Interrupt: pin A routed to IRQ 24
Capabilities: <access denied>


00:01.0 VGA compatible controller: Advanced Micro Devices, Inc.
[AMD/ATI] Carrizo (rev c8) (prog-if 00 [VGA controller])
DeviceName: ATI EG BROADWAY
Subsystem: Hewlett-Packard Company Carrizo
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 36
Region 0: Memory at e0000000 (64-bit, prefetchable) [size=256M]
Region 2: Memory at f0000000 (64-bit, prefetchable) [size=8M]
Region 4: I/O ports at 2000 [size=256]
Region 5: Memory at f0c00000 (32-bit, non-prefetchable) [size=256K]
Expansion ROM at 000c0000 [disabled] [size=128K]
Capabilities: <access denied>
Kernel driver in use: amdgpu
Kernel modules: amdgpu


00:01.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Kabini
HDMI/DP Audio
Subsystem: Hewlett-Packard Company Kabini HDMI/DP Audio
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin B routed to IRQ 38
Region 0: Memory at f0c60000 (64-bit, non-prefetchable) [size=16K]
Capabilities: <access denied>
Kernel driver in use: snd_hda_intel
Kernel modules: snd_hda_intel


00:02.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 157b
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-


00:02.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 157c
(prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 26
Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
I/O behind bridge: 0000f000-00000fff
Memory behind bridge: f0b00000-f0bfffff
Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: <access denied>
Kernel driver in use: pcieport
Kernel modules: shpchp


00:02.3 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 157c
(prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 27
Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
I/O behind bridge: 0000f000-00000fff
Memory behind bridge: f0a00000-f0afffff
Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: <access denied>
Kernel driver in use: pcieport
Kernel modules: shpchp


00:03.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 157b
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-


00:08.0 Encryption controller: Advanced Micro Devices, Inc. [AMD] Device 1578
Subsystem: Hewlett-Packard Company Device 81aa
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx+
Latency: 0
Interrupt: pin A routed to IRQ 255
Region 0: Memory at f0c40000 (64-bit, prefetchable) [size=128K]
Region 2: Memory at f0900000 (32-bit, non-prefetchable) [size=1M]
Region 3: Memory at f0c6f000 (32-bit, non-prefetchable) [size=4K]
Region 5: Memory at f0c6a000 (32-bit, non-prefetchable) [size=8K]
Capabilities: <access denied>


00:09.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 157d
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-


00:09.2 Audio device: Advanced Micro Devices, Inc. [AMD] Device 157a
Subsystem: Hewlett-Packard Company Device 81aa
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 39
Region 0: Memory at f0c64000 (32-bit, non-prefetchable) [size=16K]
Capabilities: <access denied>
Kernel driver in use: snd_hda_intel
Kernel modules: snd_hda_intel


00:10.0 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB
XHCI Controller (rev 20) (prog-if 30 [XHCI])
Subsystem: Hewlett-Packard Company FCH USB XHCI Controller
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 18
Region 0: Memory at f0c68000 (64-bit, non-prefetchable) [size=8K]
Capabilities: <access denied>
Kernel driver in use: xhci_hcd
Kernel modules: xhci_pci


00:11.0 SATA controller: Advanced Micro Devices, Inc. [AMD] FCH SATA
Controller [AHCI mode] (rev 49) (prog-if 01 [AHCI 1.0])
Subsystem: Hewlett-Packard Company FCH SATA Controller [AHCI mode]
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 64, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 19
Region 0: I/O ports at 2118 [size=8]
Region 1: I/O ports at 2124 [size=4]
Region 2: I/O ports at 2110 [size=8]
Region 3: I/O ports at 2120 [size=4]
Region 4: I/O ports at 2100 [size=16]
Region 5: Memory at f0c6c000 (32-bit, non-prefetchable) [size=1K]
Capabilities: <access denied>
Kernel driver in use: ahci
Kernel modules: ahci


00:12.0 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB
EHCI Controller (rev 49) (prog-if 20 [EHCI])
Subsystem: Hewlett-Packard Company FCH USB EHCI Controller
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 32, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 18
Region 0: Memory at f0c6d000 (32-bit, non-prefetchable) [size=256]
Capabilities: <access denied>
Kernel driver in use: ehci-pci
Kernel modules: ehci_pci


00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller (rev 4a)
Subsystem: Hewlett-Packard Company FCH SMBus Controller
Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Kernel driver in use: piix4_smbus
Kernel modules: i2c_piix4, sp5100_tco


00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge (rev 11)
Subsystem: Hewlett-Packard Company FCH LPC Bridge
Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0


00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1570
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-


00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1571
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-


00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1572
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-


00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1573
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Capabilities: <access denied>
Kernel driver in use: k10temp
Kernel modules: k10temp


00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1574
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Kernel driver in use: fam15h_power
Kernel modules: fam15h_power


00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1575
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-


01:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd.
RTS5229 PCI Express Card Reader (rev 01)
Subsystem: Hewlett-Packard Company RTS5229 PCI Express Card Reader
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 29
Region 0: Memory at f0b00000 (32-bit, non-prefetchable) [size=4K]
Capabilities: <access denied>
Kernel driver in use: rtsx_pci
Kernel modules: rtsx_pci


02:00.0 Network controller: Intel Corporation Wireless 7265 (rev 61)
DeviceName: Intel WLAN Intel 7265NGWG.NVW Stone Peak 2 D0 ac 2x2 + BT
4 LE PCIe+USB NGFF 2230 WW non-vPro
Subsystem: Intel Corporation Dual Band Wireless-AC 7265
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 41
Region 0: Memory at f0a00000 (64-bit, non-prefetchable) [size=8K]
Capabilities: <access denied>
Kernel driver in use: iwlwifi
Kernel modules: iwlwifi

[7.6.] SCSI information (from /proc/scsi/scsi):
No "/proc/scsi"


[7.7.] Other information that might be relevant to the problem (please
look in /proc and include all information that you think to be
relevant):
Output of "ls /proc":
1 1662 24907 25939 33 3607 3838 4040 661 buddyinfo locks
10 1684 2495 26 3313 3609 3842 4043 68 bus meminfo
11 18 2496 26358 3314 3619 3852 4047 695 cgroups misc
12 188 2497 2641 3324 3629 3860 4074 699 cmdline modules
13 19 24981 2667 334 3633 3870 4090 7 consoles mounts
14 1945 24991 2672 335 3637 3879 4094 74 cpuinfo mtrr
14226 2 25 2673 337 3645 3881 41 794 crypto net
15 20 25034 2687 338 3658 3886 4103 795 devices pagetypeinfo
15389 20578 2504 269 339 3663 3892 4113 8 diskstats partitions
15395 20580 2505 2696 34 3673 39 4122 821 dma sched_debug
15396 20720 25057 27 340 3677 3907 4136 823 driver self
15399 21 2506 2731 341 3678 3910 4143 825 execdomains slabinfo
15400 2127 2507 2762 342 3683 3917 42 826 fb softirqs
15403 22 25075 2784 343 3686 3931 4247 827 filesystems stat
15458 2216 2508 28 344 3688 3933 43 830 fs swaps
15468 22697 2509 283 345 3691 3939 4386 840 interrupts sys
15471 22765 25114 2832 346 3694 3945 44 841 iomem sysrq-trigger
15509 2318 2522 2834 347 3764 3964 45 844 ioports sysvipc
15514 23699 2528 285 348 3781 3990 4627 850 irq thread-self
15530 23778 2532 2909 35 3786 3995 4639 896 kallsyms timer_list
15538 24 25446 3 350 3793 3998 48 897 kcore timer_stats
15544 2416 25502 30 3586 3798 40 49 9 keys tty
15574 24414 25565 31 3589 38 4015 5 940 key-users uptime
15672 24433 25585 32 3591 3800 4023 50 942 kmsg version
15698 24729 2572 3238 3594 3805 4024 5033 962 kpagecgroup vmallocinfo
16 24758 2577 3239 3597 3807 4026 5107 969 kpagecount vmstat
16437 24808 2578 325 36 3808 4035 65 acpi kpageflags zoneinfo
16440 24814 2586 3270 3602 3820 4039 66 asound loadavg


[X.] Other notes, patches, fixes, workarounds:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1609601
[1.] One line summary of the problem: Touchscreen does not work, dmesg
shows errors "i2c_hid i2c-ELAN0732:00: failed to reset device",
"i2c_hid i2c-ELAN0732:00: can't add hid device: -61", and "i2c_hid:
probe of i2c-ELAN0732:00 failed with error -61" occur during boot.

[2.] Full description of the problem/report: This is on an HP Eny x360
M6-AR004DX laptop with 7th-generation AMD FX CPU. The touchscreen is
not recognized at all; it appears the screen is using GPIO interrupts
as I have to build with AMD GPIO support to receive these errors,
otherwise I see a "failed to get GPIO interrupt" error.

[3.] Keywords (i.e., modules, networking, kernel):

[4.] Kernel version (from /proc/version): Linux version
4.8.0-040800rc4-generic (kernel@gomeisa) (gcc version 6.2.0 20160824
(Ubuntu 6.2.0-1ubuntu12) ) #201608312129 SMP Thu Sep 1 01:31:59 UTC
2016

[5.] Output of Oops.. message (if applicable) with symbolic
information resolved (see Documentation/oops-tracing.txt): Not
applicable

[6.] A small shell script or example program which triggers the
problem (if possible): Not applicable
[7.] Environment: Description: Ubuntu 16.04.1 LTS Release: 16.04
[7.1.] Software (add the output of the ver_linux script here):
Linux Masaq 4.8.0-040800rc4-generic #201608312129 SMP Thu Sep 1
01:31:59 UTC 2016 x86_64 x86_64 x86_64 GNU/Linux

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
Modules Loaded ablk_helper ac acpi_cpufreq aesni_intel aes_x86_64
af_alg ahci algif_skcipher amdgpu amdkfd arc4 autofs4 battery
binfmt_misc bluetooth bnep bridge btbcm btintel btrtl btusb button ccm
cfg80211 crc16 crc32c_intel crc32_pclmul crct10dif_pclmul cryptd ctr
dm_crypt dm_mod drm drm_kms_helper ebtable_filter ebtables efi_pstore
efivarfs efivars ehci_hcd ehci_pci evdev ext4 fam15h_power fat fjes
fscrypto fuse gf128mul ghash_clmulni_intel glue_helper hid
hid_sensor_accel_3d hid_sensor_gyro_3d hid_sensor_hub
hid_sensor_iio_common hid_sensor_incl_3d hid_sensor_magn_3d
hid_sensor_rotation hid_sensor_trigger hp_accel hp_wireless hp_wmi
i2c_algo_bit i2c_designware_core i2c_designware_platform i2c_hid
i2c_piix4 industrialio industrialio_triggered_buffer input_polldev
ip6table_filter ip6_tables ip6_udp_tunnel iptable_filter
iptable_mangle iptable_nat ip_tables ipt_MASQUERADE ipt_REJECT
irqbypass iwlmvm iwlwifi jbd2 joydev k10temp kfifo_buf kvm kvm_amd
l2tp_core l2tp_netlink l2tp_ppp libahci libata lis3lv02d llc lp lrw
mac80211 macvlan macvtap mbcache media memstick mfd_core mmc_core msr
nf_conntrack nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat nf_nat_ipv4
nf_nat_masquerade_ipv4 nf_reject_ipv4 nls_cp437 nls_utf8 nvram parport
parport_pc ppdev ppp_generic pppox psmouse rfcomm rfkill rtsx_pci
rtsx_pci_ms rtsx_pci_sdmmc scsi_mod sd_mod serio_raw sg shpchp slhc
snd snd_hda_codec snd_hda_codec_conexant snd_hda_codec_generic
snd_hda_codec_hdmi snd_hda_core snd_hda_intel snd_hwdep snd_pcm
snd_rawmidi snd_seq snd_seq_device snd_seq_midi snd_seq_midi_event
snd_timer soundcore sparse_keymap stp thermal tpm tpm_crb tpm_tis
tpm_tis_core ttm tun udp_tunnel usb_common usbcore usbhid uvcvideo
vfat vhost vhost_net video videobuf2_core videobuf2_memops
videobuf2_v4l2 videobuf2_vmalloc videodev wmi xhci_hcd xhci_pci
x_tables xt_CHECKSUM xt_conntrack xt_tcpudp

[7.2.] Processor information (from /proc/cpuinfo):
processor : 0
vendor_id : AuthenticAMD
cpu family : 21
model : 101
model name : AMD FX-9800P RADEON R7, 12 COMPUTE CORES 4C+8G
stepping : 1
microcode : 0x6006113
cpu MHz : 1400.000
cache size : 1024 KB
physical id : 0
siblings : 4
core id : 0
cpu cores : 2
apicid : 16
initial apicid : 0
fpu : yes
fpu_exception : yes
cpuid level : 13
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
pdpe1gb rdtscp lm constant_tsc rep_good acc_power nopl nonstop_tsc
extd_apicid aperfmperf eagerfpu pni pclmulqdq monitor ssse3 fma cx16
sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm
cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch
osvw ibs xop skinit wdt lwp fma4 tce nodeid_msr tbm topoext
perfctr_core perfctr_nb bpext ptsc mwaitx cpb hw_pstate vmmcall
fsgsbase bmi1 avx2 smep bmi2 xsaveopt arat npt lbrv svm_lock nrip_save
tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold
avic overflow_recov
bugs : fxsave_leak sysret_ss_attrs null_seg
bogomips : 5390.07
TLB size : 1536 4K pages
clflush size : 64
cache_alignment : 64
address sizes : 48 bits physical, 48 bits virtual
power management: ts ttp tm 100mhzsteps hwpstate cpb eff_freq_ro acc_power [13]

processor : 1
vendor_id : AuthenticAMD
cpu family : 21
model : 101
model name : AMD FX-9800P RADEON R7, 12 COMPUTE CORES 4C+8G
stepping : 1
microcode : 0x6006113
cpu MHz : 1400.000
cache size : 1024 KB
physical id : 0
siblings : 4
core id : 0
cpu cores : 2
apicid : 17
initial apicid : 1
fpu : yes
fpu_exception : yes
cpuid level : 13
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
pdpe1gb rdtscp lm constant_tsc rep_good acc_power nopl nonstop_tsc
extd_apicid aperfmperf eagerfpu pni pclmulqdq monitor ssse3 fma cx16
sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm
cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch
osvw ibs xop skinit wdt lwp fma4 tce nodeid_msr tbm topoext
perfctr_core perfctr_nb bpext ptsc mwaitx cpb hw_pstate vmmcall
fsgsbase bmi1 avx2 smep bmi2 xsaveopt arat npt lbrv svm_lock nrip_save
tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold
avic overflow_recov
bugs : fxsave_leak sysret_ss_attrs null_seg
bogomips : 5378.04
TLB size : 1536 4K pages
clflush size : 64
cache_alignment : 64
address sizes : 48 bits physical, 48 bits virtual
power management: ts ttp tm 100mhzsteps hwpstate cpb eff_freq_ro acc_power [13]

processor : 2
vendor_id : AuthenticAMD
cpu family : 21
model : 101
model name : AMD FX-9800P RADEON R7, 12 COMPUTE CORES 4C+8G
stepping : 1
microcode : 0x6006113
cpu MHz : 1800.000
cache size : 1024 KB
physical id : 0
siblings : 4
core id : 1
cpu cores : 2
apicid : 18
initial apicid : 2
fpu : yes
fpu_exception : yes
cpuid level : 13
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
pdpe1gb rdtscp lm constant_tsc rep_good acc_power nopl nonstop_tsc
extd_apicid aperfmperf eagerfpu pni pclmulqdq monitor ssse3 fma cx16
sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm
cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch
osvw ibs xop skinit wdt lwp fma4 tce nodeid_msr tbm topoext
perfctr_core perfctr_nb bpext ptsc mwaitx cpb hw_pstate vmmcall
fsgsbase bmi1 avx2 smep bmi2 xsaveopt arat npt lbrv svm_lock nrip_save
tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold
avic overflow_recov
bugs : fxsave_leak sysret_ss_attrs null_seg
bogomips : 5378.04
TLB size : 1536 4K pages
clflush size : 64
cache_alignment : 64
address sizes : 48 bits physical, 48 bits virtual
power management: ts ttp tm 100mhzsteps hwpstate cpb eff_freq_ro acc_power [13]

processor : 3
vendor_id : AuthenticAMD
cpu family : 21
model : 101
model name : AMD FX-9800P RADEON R7, 12 COMPUTE CORES 4C+8G
stepping : 1
microcode : 0x6006113
cpu MHz : 1400.000
cache size : 1024 KB
physical id : 0
siblings : 4
core id : 1
cpu cores : 2
apicid : 19
initial apicid : 3
fpu : yes
fpu_exception : yes
cpuid level : 13
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
pdpe1gb rdtscp lm constant_tsc rep_good acc_power nopl nonstop_tsc
extd_apicid aperfmperf eagerfpu pni pclmulqdq monitor ssse3 fma cx16
sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm
cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch
osvw ibs xop skinit wdt lwp fma4 tce nodeid_msr tbm topoext
perfctr_core perfctr_nb bpext ptsc mwaitx cpb hw_pstate vmmcall
fsgsbase bmi1 avx2 smep bmi2 xsaveopt arat npt lbrv svm_lock nrip_save
tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold
avic overflow_recov
bugs : fxsave_leak sysret_ss_attrs null_seg
bogomips : 5378.04
TLB size : 1536 4K pages
clflush size : 64
cache_alignment : 64
address sizes : 48 bits physical, 48 bits virtual
power management: ts ttp tm 100mhzsteps hwpstate cpb eff_freq_ro acc_power [13]

[7.3.] Module information (from /proc/modules):
fuse 98304 2 - Live 0x0000000000000000
rfcomm 77824 2 - Live 0x0000000000000000
xt_CHECKSUM 16384 1 - Live 0x0000000000000000
iptable_mangle 16384 1 - Live 0x0000000000000000
ipt_MASQUERADE 16384 3 - Live 0x0000000000000000
nf_nat_masquerade_ipv4 16384 1 ipt_MASQUERADE, Live 0x0000000000000000
iptable_nat 16384 1 - Live 0x0000000000000000
nf_nat_ipv4 16384 1 iptable_nat, Live 0x0000000000000000
nf_nat 28672 2 nf_nat_masquerade_ipv4,nf_nat_ipv4, Live 0x0000000000000000
nf_conntrack_ipv4 20480 2 - Live 0x0000000000000000
nf_defrag_ipv4 16384 1 nf_conntrack_ipv4, Live 0x0000000000000000
xt_conntrack 16384 1 - Live 0x0000000000000000
nf_conntrack 114688 5
nf_nat_masquerade_ipv4,nf_nat_ipv4,nf_nat,nf_conntrack_ipv4,xt_conntrack,
Live 0x0000000000000000
ipt_REJECT 16384 2 - Live 0x0000000000000000
nf_reject_ipv4 16384 1 ipt_REJECT, Live 0x0000000000000000
xt_tcpudp 16384 6 - Live 0x0000000000000000
bridge 135168 0 - Live 0x0000000000000000
stp 16384 1 bridge, Live 0x0000000000000000
llc 16384 2 bridge,stp, Live 0x0000000000000000
ctr 16384 4 - Live 0x0000000000000000
ccm 20480 2 - Live 0x0000000000000000
ebtable_filter 16384 0 - Live 0x0000000000000000
ebtables 36864 1 ebtable_filter, Live 0x0000000000000000
ip6table_filter 16384 0 - Live 0x0000000000000000
ip6_tables 28672 1 ip6table_filter, Live 0x0000000000000000
iptable_filter 16384 1 - Live 0x0000000000000000
ip_tables 28672 3 iptable_mangle,iptable_nat,iptable_filter, Live
0x0000000000000000
x_tables 36864 11
xt_CHECKSUM,iptable_mangle,ipt_MASQUERADE,xt_conntrack,ipt_REJECT,xt_tcpudp,ebtables,ip6table_filter,ip6_tables,iptable_filter,ip_tables,
Live 0x0000000000000000
l2tp_ppp 24576 0 - Live 0x0000000000000000
l2tp_netlink 20480 1 l2tp_ppp, Live 0x0000000000000000
l2tp_core 32768 2 l2tp_ppp,l2tp_netlink, Live 0x0000000000000000
ip6_udp_tunnel 16384 1 l2tp_core, Live 0x0000000000000000
udp_tunnel 16384 1 l2tp_core, Live 0x0000000000000000
pppox 16384 1 l2tp_ppp, Live 0x0000000000000000
ppp_generic 36864 2 l2tp_ppp,pppox, Live 0x0000000000000000
slhc 16384 1 ppp_generic, Live 0x0000000000000000
bnep 20480 2 - Live 0x0000000000000000
binfmt_misc 20480 1 - Live 0x0000000000000000
nls_utf8 16384 1 - Live 0x0000000000000000
nls_cp437 20480 1 - Live 0x0000000000000000
vfat 20480 1 - Live 0x0000000000000000
fat 69632 1 vfat, Live 0x0000000000000000
hid_sensor_rotation 16384 0 - Live 0x0000000000000000
hid_sensor_incl_3d 16384 0 - Live 0x0000000000000000
hid_sensor_magn_3d 16384 1 - Live 0x0000000000000000
hid_sensor_gyro_3d 16384 0 - Live 0x0000000000000000
hid_sensor_accel_3d 16384 1 - Live 0x0000000000000000
hid_sensor_trigger 16384 10
hid_sensor_rotation,hid_sensor_incl_3d,hid_sensor_magn_3d,hid_sensor_gyro_3d,hid_sensor_accel_3d,
Live 0x0000000000000000
hid_sensor_iio_common 16384 6
hid_sensor_rotation,hid_sensor_incl_3d,hid_sensor_magn_3d,hid_sensor_gyro_3d,hid_sensor_accel_3d,hid_sensor_trigger,
Live 0x0000000000000000
industrialio_triggered_buffer 16384 5
hid_sensor_incl_3d,hid_sensor_rotation,hid_sensor_magn_3d,hid_sensor_gyro_3d,hid_sensor_accel_3d,
Live 0x0000000000000000
kfifo_buf 16384 1 industrialio_triggered_buffer, Live 0x0000000000000000
industrialio 65536 10
hid_sensor_rotation,hid_sensor_incl_3d,hid_sensor_magn_3d,hid_sensor_gyro_3d,hid_sensor_accel_3d,hid_sensor_trigger,industrialio_triggered_buffer,kfifo_buf,
Live 0x0000000000000000
uvcvideo 90112 0 - Live 0x0000000000000000
videobuf2_vmalloc 16384 1 uvcvideo, Live 0x0000000000000000
videobuf2_memops 16384 1 videobuf2_vmalloc, Live 0x0000000000000000
videobuf2_v4l2 24576 1 uvcvideo, Live 0x0000000000000000
videobuf2_core 40960 2 uvcvideo,videobuf2_v4l2, Live 0x0000000000000000
videodev 176128 3 uvcvideo,videobuf2_v4l2,videobuf2_core, Live
0x0000000000000000
media 40960 2 uvcvideo,videodev, Live 0x0000000000000000
hid_sensor_hub 20480 7
hid_sensor_rotation,hid_sensor_incl_3d,hid_sensor_magn_3d,hid_sensor_gyro_3d,hid_sensor_accel_3d,hid_sensor_trigger,hid_sensor_iio_common,
Live 0x0000000000000000
btusb 45056 0 - Live 0x0000000000000000
btrtl 16384 1 btusb, Live 0x0000000000000000
btbcm 16384 1 btusb, Live 0x0000000000000000
btintel 16384 1 btusb, Live 0x0000000000000000
bluetooth 544768 31 rfcomm,bnep,btusb,btrtl,btbcm,btintel, Live
0x0000000000000000
arc4 16384 2 - Live 0x0000000000000000
iwlmvm 241664 0 - Live 0x0000000000000000
mac80211 663552 1 iwlmvm, Live 0x0000000000000000
nvram 16384 0 - Live 0x0000000000000000
iwlwifi 147456 1 iwlmvm, Live 0x0000000000000000
msr 16384 0 - Live 0x0000000000000000
snd_hda_codec_conexant 24576 1 - Live 0x0000000000000000
snd_hda_codec_hdmi 45056 1 - Live 0x0000000000000000
snd_hda_codec_generic 69632 1 snd_hda_codec_conexant, Live 0x0000000000000000
snd_hda_intel 36864 10 - Live 0x0000000000000000
snd_hda_codec 131072 4
snd_hda_codec_conexant,snd_hda_codec_hdmi,snd_hda_codec_generic,snd_hda_intel,
Live 0x0000000000000000
snd_hda_core 81920 5
snd_hda_codec_conexant,snd_hda_codec_hdmi,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,
Live 0x0000000000000000
cfg80211 589824 3 iwlmvm,mac80211,iwlwifi, Live 0x0000000000000000
snd_hwdep 16384 1 snd_hda_codec, Live 0x0000000000000000
hp_wmi 16384 0 - Live 0x0000000000000000
snd_pcm 110592 4
snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec,snd_hda_core, Live
0x0000000000000000
snd_seq_midi 16384 0 - Live 0x0000000000000000
snd_seq_midi_event 16384 1 snd_seq_midi, Live 0x0000000000000000
sparse_keymap 16384 1 hp_wmi, Live 0x0000000000000000
snd_rawmidi 32768 1 snd_seq_midi, Live 0x0000000000000000
rfkill 24576 8 bluetooth,cfg80211,hp_wmi, Live 0x0000000000000000
snd_seq 69632 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
snd_seq_device 16384 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x0000000000000000
snd_timer 32768 2 snd_pcm,snd_seq, Live 0x0000000000000000
snd 86016 31 snd_hda_codec_conexant,snd_hda_codec_hdmi,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_seq_device,snd_timer,
Live 0x0000000000000000
kvm_amd 73728 0 - Live 0x0000000000000000
rtsx_pci_ms 20480 0 - Live 0x0000000000000000
memstick 20480 1 rtsx_pci_ms, Live 0x0000000000000000
hp_accel 28672 0 - Live 0x0000000000000000
lis3lv02d 20480 1 hp_accel, Live 0x0000000000000000
kvm 593920 1 kvm_amd, Live 0x0000000000000000
joydev 20480 0 - Live 0x0000000000000000
input_polldev 16384 1 lis3lv02d, Live 0x0000000000000000
efi_pstore 16384 0 - Live 0x0000000000000000
soundcore 16384 1 snd, Live 0x0000000000000000
serio_raw 16384 0 - Live 0x0000000000000000
sg 32768 0 - Live 0x0000000000000000
efivars 20480 1 efi_pstore, Live 0x0000000000000000
k10temp 16384 0 - Live 0x0000000000000000
fam15h_power 16384 0 - Live 0x0000000000000000
i2c_designware_platform 16384 0 - Live 0x0000000000000000
battery 16384 0 - Live 0x0000000000000000
ac 16384 0 - Live 0x0000000000000000
shpchp 36864 0 - Live 0x0000000000000000
tpm_crb 16384 0 - Live 0x0000000000000000
evdev 24576 31 - Live 0x0000000000000000
irqbypass 16384 1 kvm, Live 0x0000000000000000
i2c_designware_core 20480 1 i2c_designware_platform, Live 0x0000000000000000
i2c_piix4 24576 0 - Live 0x0000000000000000
hp_wireless 16384 0 - Live 0x0000000000000000
acpi_cpufreq 20480 0 - Live 0x0000000000000000
tpm_tis 16384 0 - Live 0x0000000000000000
tpm_tis_core 20480 1 tpm_tis, Live 0x0000000000000000
tpm 45056 3 tpm_crb,tpm_tis,tpm_tis_core, Live 0x0000000000000000
vhost_net 20480 0 - Live 0x0000000000000000
tun 28672 2 vhost_net, Live 0x0000000000000000
vhost 45056 1 vhost_net, Live 0x0000000000000000
macvtap 24576 1 vhost_net, Live 0x0000000000000000
macvlan 24576 1 macvtap, Live 0x0000000000000000
parport_pc 28672 0 - Live 0x0000000000000000
ppdev 20480 0 - Live 0x0000000000000000
lp 20480 0 - Live 0x0000000000000000
parport 49152 3 parport_pc,ppdev,lp, Live 0x0000000000000000
efivarfs 16384 1 - Live 0x0000000000000000
autofs4 40960 2 - Live 0x0000000000000000
ext4 589824 2 - Live 0x0000000000000000
crc16 16384 2 bluetooth,ext4, Live 0x0000000000000000
jbd2 110592 1 ext4, Live 0x0000000000000000
fscrypto 28672 1 ext4, Live 0x0000000000000000
mbcache 16384 3 ext4, Live 0x0000000000000000
algif_skcipher 20480 0 - Live 0x0000000000000000
af_alg 16384 1 algif_skcipher, Live 0x0000000000000000
dm_crypt 24576 1 - Live 0x0000000000000000
dm_mod 114688 9 dm_crypt, Live 0x0000000000000000
sd_mod 45056 4 - Live 0x0000000000000000
usbhid 53248 0 - Live 0x0000000000000000
rtsx_pci_sdmmc 24576 0 - Live 0x0000000000000000
mmc_core 143360 1 rtsx_pci_sdmmc, Live 0x0000000000000000
crct10dif_pclmul 16384 0 - Live 0x0000000000000000
crc32_pclmul 16384 0 - Live 0x0000000000000000
crc32c_intel 24576 0 - Live 0x0000000000000000
ghash_clmulni_intel 16384 0 - Live 0x0000000000000000
aesni_intel 167936 7 - Live 0x0000000000000000
aes_x86_64 20480 1 aesni_intel, Live 0x0000000000000000
lrw 16384 1 aesni_intel, Live 0x0000000000000000
gf128mul 16384 1 lrw, Live 0x0000000000000000
psmouse 131072 0 - Live 0x0000000000000000
glue_helper 16384 1 aesni_intel, Live 0x0000000000000000
ablk_helper 16384 1 aesni_intel, Live 0x0000000000000000
cryptd 24576 4 ghash_clmulni_intel,aesni_intel,ablk_helper, Live
0x0000000000000000
amdkfd 139264 1 - Live 0x0000000000000000
amdgpu 1187840 9 - Live 0x0000000000000000
xhci_pci 16384 0 - Live 0x0000000000000000
rtsx_pci 57344 2 rtsx_pci_ms,rtsx_pci_sdmmc, Live 0x0000000000000000
xhci_hcd 188416 1 xhci_pci, Live 0x0000000000000000
mfd_core 16384 2 hid_sensor_hub,rtsx_pci, Live 0x0000000000000000
ahci 36864 3 - Live 0x0000000000000000
libahci 32768 1 ahci, Live 0x0000000000000000
libata 249856 2 ahci,libahci, Live 0x0000000000000000
i2c_algo_bit 16384 1 amdgpu, Live 0x0000000000000000
ttm 98304 1 amdgpu, Live 0x0000000000000000
ehci_pci 16384 0 - Live 0x0000000000000000
ehci_hcd 81920 1 ehci_pci, Live 0x0000000000000000
drm_kms_helper 155648 1 amdgpu, Live 0x0000000000000000
scsi_mod 225280 3 sg,sd_mod,libata, Live 0x0000000000000000
usbcore 253952 8
uvcvideo,btusb,usbhid,xhci_pci,xhci_hcd,ehci_pci,ehci_hcd, Live
0x0000000000000000
drm 360448 12 amdgpu,ttm,drm_kms_helper, Live 0x0000000000000000
usb_common 16384 1 usbcore, Live 0x0000000000000000
video 40960 0 - Live 0x0000000000000000
thermal 20480 0 - Live 0x0000000000000000
i2c_hid 20480 0 - Live 0x0000000000000000
hid 118784 3 hid_sensor_hub,usbhid,i2c_hid, Live 0x0000000000000000
fjes 28672 0 - Live 0x0000000000000000
wmi 16384 1 hp_wmi, Live 0x0000000000000000
button 16384 0 - Live 0x0000000000000000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem):
0000-0000 : PCI Bus 0000:00
  0000-0000 : dma1
  0000-0000 : pic1
  0000-0000 : timer0
  0000-0000 : timer1
  0000-0000 : keyboard
  0000-0000 : PNP0800:00
  0000-0000 : PNP0C09:00
    0000-0000 : EC data
  0000-0000 : keyboard
  0000-0000 : PNP0C09:00
    0000-0000 : EC cmd
  0000-0000 : PNP0C09:00
  0000-0000 : rtc0
  0000-0000 : dma page reg
  0000-0000 : pic2
  0000-0000 : dma2
  0000-0000 : fpu
    0000-0000 : PNP0C04:00
  0000-0000 : pnp 00:02
    0000-0000 : ACPI PM1a_EVT_BLK
    0000-0000 : ACPI PM1a_CNT_BLK
    0000-0000 : ACPI PM_TMR
    0000-0000 : ACPI CPU throttle
    0000-0000 : ACPI GPE0_BLK
  0000-0000 : pnp 00:02
  0000-0000 : pnp 00:02
  0000-0000 : ACPI PM2_CNT_BLK
  0000-0000 : piix4_smbus
  0000-0000 : SMB0001:00
  0000-0000 : pnp 00:02
  0000-0000 : pnp 00:02
  0000-0000 : pnp 00:02
  0000-0000 : pnp 00:02
  0000-0000 : pnp 00:02
  0000-0000 : pnp 00:02
    0000-0000 : smba_idx
0000-0000 : PCI conf1
0000-0000 : PCI Bus 0000:00
  0000-0000 : 0000:00:01.0
  0000-0000 : 0000:00:11.0
    0000-0000 : ahci
  0000-0000 : 0000:00:11.0
    0000-0000 : ahci
  0000-0000 : 0000:00:11.0
    0000-0000 : ahci
  0000-0000 : 0000:00:11.0
    0000-0000 : ahci
  0000-0000 : 0000:00:11.0
    0000-0000 : ahci
00000000-00000000 : reserved
00000000-00000000 : System RAM
00000000-00000000 : reserved
00000000-00000000 : System RAM
00000000-00000000 : PCI Bus 0000:00
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
00000000-00000000 : PCI Bus 0000:00
00000000-00000000 : PCI Bus 0000:00
00000000-00000000 : PCI Bus 0000:00
00000000-00000000 : System ROM
00000000-00000000 : System RAM
  00000000-00000000 : Kernel code
  00000000-00000000 : Kernel data
  00000000-00000000 : Kernel bss
00000000-00000000 : reserved
00000000-00000000 : reserved
00000000-00000000 : ACPI Non-volatile Storage
  00000000-00000000 : MSFT0101:00
  00000000-00000000 : MSFT0101:00
00000000-00000000 : ACPI Tables
00000000-00000000 : System RAM
00000000-00000000 : reserved
00000000-00000000 : PCI Bus 0000:00
  00000000-00000000 : 0000:00:01.0
    00000000-00000000 : BOOTFB
  00000000-00000000 : 0000:00:01.0
  00000000-00000000 : reserved
    00000000-00000000 : pnp 00:00
  00000000-00000000 : 0000:00:08.0
  00000000-00000000 : PCI Bus 0000:02
    00000000-00000000 : 0000:02:00.0
      00000000-00000000 : iwlwifi
  00000000-00000000 : PCI Bus 0000:01
    00000000-00000000 : 0000:01:00.0
      00000000-00000000 : rtsx_pci
  00000000-00000000 : 0000:00:01.0
  00000000-00000000 : 0000:00:08.0
  00000000-00000000 : 0000:00:01.1
    00000000-00000000 : ICH HD audio
  00000000-00000000 : 0000:00:09.2
    00000000-00000000 : ICH HD audio
  00000000-00000000 : 0000:00:10.0
    00000000-00000000 : xhci-hcd
  00000000-00000000 : 0000:00:08.0
  00000000-00000000 : 0000:00:11.0
    00000000-00000000 : ahci
  00000000-00000000 : 0000:00:12.0
    00000000-00000000 : ehci_hcd
  00000000-00000000 : 0000:00:08.0
00000000-00000000 : PCI MMCONFIG 0000 [bus 00-3f]
  00000000-00000000 : reserved
00000000-00000000 : PCI Bus 0000:00
  00000000-00000000 : amd_iommu
  00000000-00000000 : PNP0C09:00
  00000000-00000000 : reserved
    00000000-00000000 : IOAPIC 0
  00000000-00000000 : IOAPIC 1
  00000000-00000000 : reserved
  00000000-00000000 : HPET 0
    00000000-00000000 : PNP0103:00
00000000-00000000 : reserved
00000000-00000000 : AMD0030:00
00000000-00000000 : AMD0010:00
  00000000-00000000 : AMD0010:00
00000000-00000000 : AMD0010:01
  00000000-00000000 : AMD0010:01
00000000-00000000 : AMD0020:00
  00000000-00000000 : serial
00000000-00000000 : Local APIC
  00000000-00000000 : reserved
    00000000-00000000 : pnp 00:00
00000000-00000000 : reserved
  00000000-00000000 : pnp 00:03
00000000-00000000 : System RAM
00000000-00000000 : reserved

[7.5.] PCI information ('lspci -vvv' as root):
00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1576
Subsystem: Hewlett-Packard Company Device 81aa
Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0

00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Device 1577
Subsystem: Hewlett-Packard Company Device 81aa
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Interrupt: pin A routed to IRQ 24
Capabilities: <access denied>

00:01.0 VGA compatible controller: Advanced Micro Devices, Inc.
[AMD/ATI] Carrizo (rev c8) (prog-if 00 [VGA controller])
DeviceName: ATI EG BROADWAY
Subsystem: Hewlett-Packard Company Carrizo
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 36
Region 0: Memory at e0000000 (64-bit, prefetchable) [size=256M]
Region 2: Memory at f0000000 (64-bit, prefetchable) [size=8M]
Region 4: I/O ports at 2000 [size=256]
Region 5: Memory at f0c00000 (32-bit, non-prefetchable) [size=256K]
Expansion ROM at 000c0000 [disabled] [size=128K]
Capabilities: <access denied>
Kernel driver in use: amdgpu
Kernel modules: amdgpu

00:01.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Kabini
HDMI/DP Audio
Subsystem: Hewlett-Packard Company Kabini HDMI/DP Audio
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin B routed to IRQ 38
Region 0: Memory at f0c60000 (64-bit, non-prefetchable) [size=16K]
Capabilities: <access denied>
Kernel driver in use: snd_hda_intel
Kernel modules: snd_hda_intel

00:02.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 157b
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:02.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 157c
(prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 26
Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
I/O behind bridge: 0000f000-00000fff
Memory behind bridge: f0b00000-f0bfffff
Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: <access denied>
Kernel driver in use: pcieport
Kernel modules: shpchp

00:02.3 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 157c
(prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 27
Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
I/O behind bridge: 0000f000-00000fff
Memory behind bridge: f0a00000-f0afffff
Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: <access denied>
Kernel driver in use: pcieport
Kernel modules: shpchp

00:03.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 157b
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:08.0 Encryption controller: Advanced Micro Devices, Inc. [AMD] Device 1578
Subsystem: Hewlett-Packard Company Device 81aa
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx+
Latency: 0
Interrupt: pin A routed to IRQ 255
Region 0: Memory at f0c40000 (64-bit, prefetchable) [size=128K]
Region 2: Memory at f0900000 (32-bit, non-prefetchable) [size=1M]
Region 3: Memory at f0c6f000 (32-bit, non-prefetchable) [size=4K]
Region 5: Memory at f0c6a000 (32-bit, non-prefetchable) [size=8K]
Capabilities: <access denied>

00:09.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 157d
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:09.2 Audio device: Advanced Micro Devices, Inc. [AMD] Device 157a
Subsystem: Hewlett-Packard Company Device 81aa
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 39
Region 0: Memory at f0c64000 (32-bit, non-prefetchable) [size=16K]
Capabilities: <access denied>
Kernel driver in use: snd_hda_intel
Kernel modules: snd_hda_intel

00:10.0 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB
XHCI Controller (rev 20) (prog-if 30 [XHCI])
Subsystem: Hewlett-Packard Company FCH USB XHCI Controller
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 18
Region 0: Memory at f0c68000 (64-bit, non-prefetchable) [size=8K]
Capabilities: <access denied>
Kernel driver in use: xhci_hcd
Kernel modules: xhci_pci

00:11.0 SATA controller: Advanced Micro Devices, Inc. [AMD] FCH SATA
Controller [AHCI mode] (rev 49) (prog-if 01 [AHCI 1.0])
Subsystem: Hewlett-Packard Company FCH SATA Controller [AHCI mode]
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 64, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 19
Region 0: I/O ports at 2118 [size=8]
Region 1: I/O ports at 2124 [size=4]
Region 2: I/O ports at 2110 [size=8]
Region 3: I/O ports at 2120 [size=4]
Region 4: I/O ports at 2100 [size=16]
Region 5: Memory at f0c6c000 (32-bit, non-prefetchable) [size=1K]
Capabilities: <access denied>
Kernel driver in use: ahci
Kernel modules: ahci

00:12.0 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB
EHCI Controller (rev 49) (prog-if 20 [EHCI])
Subsystem: Hewlett-Packard Company FCH USB EHCI Controller
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 32, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 18
Region 0: Memory at f0c6d000 (32-bit, non-prefetchable) [size=256]
Capabilities: <access denied>
Kernel driver in use: ehci-pci
Kernel modules: ehci_pci

00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller (rev 4a)
Subsystem: Hewlett-Packard Company FCH SMBus Controller
Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Kernel driver in use: piix4_smbus
Kernel modules: i2c_piix4, sp5100_tco

00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge (rev 11)
Subsystem: Hewlett-Packard Company FCH LPC Bridge
Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0

00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1570
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1571
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1572
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1573
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Capabilities: <access denied>
Kernel driver in use: k10temp
Kernel modules: k10temp

00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1574
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Kernel driver in use: fam15h_power
Kernel modules: fam15h_power

00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1575
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

01:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd.
RTS5229 PCI Express Card Reader (rev 01)
Subsystem: Hewlett-Packard Company RTS5229 PCI Express Card Reader
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 29
Region 0: Memory at f0b00000 (32-bit, non-prefetchable) [size=4K]
Capabilities: <access denied>
Kernel driver in use: rtsx_pci
Kernel modules: rtsx_pci

02:00.0 Network controller: Intel Corporation Wireless 7265 (rev 61)
DeviceName: Intel WLAN Intel 7265NGWG.NVW Stone Peak 2 D0 ac 2x2 + BT
4 LE PCIe+USB NGFF 2230 WW non-vPro
Subsystem: Intel Corporation Dual Band Wireless-AC 7265
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 41
Region 0: Memory at f0a00000 (64-bit, non-prefetchable) [size=8K]
Capabilities: <access denied>
Kernel driver in use: iwlwifi
Kernel modules: iwlwifi

[7.6.] SCSI information (from /proc/scsi/scsi):
No "/proc/scsi"

[7.7.] Other information that might be relevant to the problem (please
look in /proc and include all information that you think to be
relevant):
Output of "ls /proc":
1      1662   24907  25939  33    3607  3838  4040  661     buddyinfo    locks
10     1684   2495   26     3313  3609  3842  4043  68      bus          meminfo
11     18     2496   26358  3314  3619  3852  4047  695     cgroups      misc
12     188    2497   2641   3324  3629  3860  4074  699     cmdline      modules
13     19     24981  2667   334   3633  3870  4090  7       consoles     mounts
14     1945   24991  2672   335   3637  3879  4094  74      cpuinfo      mtrr
14226  2      25     2673   337   3645  3881  41    794     crypto       net
15     20     25034  2687   338   3658  3886  4103  795     devices
  pagetypeinfo
15389  20578  2504   269    339   3663  3892  4113  8       diskstats
  partitions
15395  20580  2505   2696   34    3673  39    4122  821     dma
  sched_debug
15396  20720  25057  27     340   3677  3907  4136  823     driver       self
15399  21     2506   2731   341   3678  3910  4143  825
execdomains  slabinfo
15400  2127   2507   2762   342   3683  3917  42    826     fb
  softirqs
15403  22     25075  2784   343   3686  3931  4247  827     filesystems  stat
15458  2216   2508   28     344   3688  3933  43    830     fs           swaps
15468  22697  2509   283    345   3691  3939  4386  840     interrupts   sys
15471  22765  25114  2832   346   3694  3945  44    841     iomem
  sysrq-trigger
15509  2318   2522   2834   347   3764  3964  45    844     ioports      sysvipc
15514  23699  2528   285    348   3781  3990  4627  850     irq
  thread-self
15530  23778  2532   2909   35    3786  3995  4639  896     kallsyms
  timer_list
15538  24     25446  3      350   3793  3998  48    897     kcore
  timer_stats
15544  2416   25502  30     3586  3798  40    49    9       keys         tty
15574  24414  25565  31     3589  38    4015  5     940     key-users    uptime
15672  24433  25585  32     3591  3800  4023  50    942     kmsg         version
15698  24729  2572   3238   3594  3805  4024  5033  962
kpagecgroup  vmallocinfo
16     24758  2577   3239   3597  3807  4026  5107  969     kpagecount   vmstat
16437  24808  2578   325    36    3808  4035  65    acpi    kpageflags
  zoneinfo
16440  24814  2586   3270   3602  3820  4039  66    asound  loadavg

[X.] Other notes, patches, fixes, workarounds:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1609601
