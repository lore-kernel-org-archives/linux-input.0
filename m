From: David DIDIER <david.didier1@free.fr>
Subject: [Asus ZenBook UX501VW] Function keys to change keyboard brightness
 don't work
Date: Mon, 19 Sep 2016 16:49:08 +0200
Message-ID: <CA+Q02ePkfC27m+HOKeuAfJW2B6REL17cZ7XLe4Reh80WWx8GFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37608 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751704AbcISOtM (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 19 Sep 2016 10:49:12 -0400
Received: by mail-wm0-f46.google.com with SMTP id b130so66877433wmc.0
        for <linux-input@vger.kernel.org>; Mon, 19 Sep 2016 07:49:11 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <Dmitry.Torokhov@gmail.com>

Hi please find below another new issue I filled on Launchpad. Thank you.

[1.] One line summary of the problem:
 [Asus ZenBook UX501VW] Function keys to change keyboard brightness don't work

[2.] Full description of the problem/report:
On Ubuntu Ubuntu 16.04.1 LTS with all the latest kernels installed
from http://kernel.ubuntu.com/~kernel-ppa/mainline/ : 4.4.19, 4.5.7,
4.6.7, 4.7.3 nor 4.8-rc6.

ProblemType: Bug
DistroRelease: Ubuntu 16.04
Package: xorg 1:7.7+13ubuntu3
Uname: Linux 4.8.0-040800rc6-generic x86_64
NonfreeKernelModules: nvidia_drm nvidia_modeset nvidia
.proc.driver.nvidia.gpus.0000.01.00.0: Error: [Errno 21] est un
dossier: '/proc/driver/nvidia/gpus/0000:01:00.0'
.proc.driver.nvidia.registry: Binary: ""
.proc.driver.nvidia.version:
 NVRM version: NVIDIA UNIX x86_64 Kernel Module 367.44 Wed Aug 17
22:24:07 PDT 2016
 GCC version: gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.2)
.tmp.unity_support_test.0:

ApportVersion: 2.20.1-0ubuntu2.1
Architecture: amd64
BootLog:

CompizPlugins: No value set for
`/apps/compiz-1/general/screen0/options/active_plugins'
CompositorRunning: compiz
CompositorUnredirectDriverBlacklist: '(nouveau|Intel).*Mesa 8.0'
CompositorUnredirectFSW: true
Date: Tue Sep 13 21:44:06 2016
DistUpgraded: Fresh install
DistroCodename: xenial
DistroVariant: ubuntu
ExtraDebuggingInterest: Yes
GraphicsCard:
 Intel Corporation Skylake Integrated Graphics [8086:191b] (rev 06)
(prog-if 00 [VGA controller])
   Subsystem: ASUSTeK Computer Inc. Skylake Integrated Graphics [1043:1080]
   Subsystem: ASUSTeK Computer Inc. GM107M [GeForce GTX 960M] [1043:1080]
InstallationDate: Installed on 2016-06-01 (104 days ago)
InstallationMedia: Ubuntu 16.04 LTS "Xenial Xerus" - Release amd64 (20160420.1)
Lsusb:
 Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
 Bus 001 Device 004: ID 8087:0a2a Intel Corp.
 Bus 001 Device 003: ID 046d:c069 Logitech, Inc. M-U0007 [Corded Mouse M500]
 Bus 001 Device 002: ID 04f2:b3fd Chicony Electronics Co., Ltd
 Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
MachineType: ASUSTeK COMPUTER INC. N501VW
ProcKernelCmdLine: BOOT_IMAGE=/boot/vmlinuz-4.8.0-040800rc6-generic
root=UUID=ad612961-a4ae-4950-9d5a-20dcf8e56681 ro quiet splash
acpi_osi= acpi_backlight=native nouveau.modeset=0 nvidia.nomodeset=0
i915.nomodeset=0 vt.handoff=7
SourcePackage: xorg
UpgradeStatus: No upgrade log present (probably fresh install)
dmi.bios.date: 05/09/2016
dmi.bios.vendor: American Megatrends Inc.
dmi.bios.version: N501VW.300
dmi.board.asset.tag: ATN12345678901234567
dmi.board.name: N501VW
dmi.board.vendor: ASUSTeK COMPUTER INC.
dmi.board.version: 1.0
dmi.chassis.asset.tag: No Asset Tag
dmi.chassis.type: 10
dmi.chassis.vendor: ASUSTeK COMPUTER INC.
dmi.chassis.version: 1.0
dmi.modalias: dmi:bvnAmericanMegatrendsInc.:bvrN501VW.300:bd05/09/2016:svnASUSTeKCOMPUTERINC.:pnN501VW:pvr1.0:rvnASUSTeKCOMPUTERINC.:rnN501VW:rvr1.0:cvnASUSTeKCOMPUTERINC.:ct10:cvr1.0:
dmi.product.name: N501VW
dmi.product.version: 1.0
dmi.sys.vendor: ASUSTeK COMPUTER INC.
version.compiz: compiz 1:0.9.12.2+16.04.20160823-0ubuntu1
version.ia32-libs: ia32-libs N/A
version.libdrm2: libdrm2 2.4.67-1ubuntu0.16.04.2
version.libgl1-mesa-dri: libgl1-mesa-dri 11.2.0-1ubuntu2.2
version.libgl1-mesa-dri-experimental: libgl1-mesa-dri-experimental N/A
version.libgl1-mesa-glx: libgl1-mesa-glx 11.2.0-1ubuntu2.2
version.nvidia-graphics-drivers: nvidia-graphics-drivers-* N/A
version.xserver-xorg-core: xserver-xorg-core 2:1.18.3-1ubuntu2.3
version.xserver-xorg-input-evdev: xserver-xorg-input-evdev 1:2.10.1-1ubuntu2
version.xserver-xorg-video-ati: xserver-xorg-video-ati 1:7.7.0-1
version.xserver-xorg-video-intel: xserver-xorg-video-intel
2:2.99.917+git20160325-1ubuntu1.1
version.xserver-xorg-video-nouveau: xserver-xorg-video-nouveau 1:1.0.12-1build2
xserver.bootTime: Tue Sep 13 21:14:29 2016
xserver.configfile: default
xserver.errors:
 Failed to load module "nvidia" (module does not exist, 0)
 Failed to load module "nvidia" (module does not exist, 0)
 [drm] Failed to open DRM device for (null): -22
xserver.logfile: /var/log/Xorg.0.log
xserver.outputs:
 product id 12876
 vendor SDC
xserver.version: 2:1.18.3-1ubuntu2.3

[3.] Keywords (i.e., modules, networking, kernel): Please do not put
anything here. This is how Kernel.org uses an undocumented keyword
system, which has nothing to do with Ubuntu Tags system.

[4.] Kernel version (from /proc/version):
% cat /proc/version
Linux version 4.8.0-040800rc6-generic (kernel@gloin) (gcc version
6.2.0 20160901 (Ubuntu 6.2.0-3ubuntu11) ) #201609121119 SMP Mon Sep 12
15:21:03 UTC 2016


[5.] Output of Oops.. message (if applicable) with symbolic
information resolved (see Documentation/oops-tracing.txt)
n/a

[6.] A small shell script or example program which triggers the
problem (if possible)
n/a

[7.] Environment
% lsb_release -rd
Description:    Ubuntu 16.04.1 LTS
Release:    16.04

[7.1.] Software (add the output of the ver_linux script here)
% /usr/src/linux-headers-4.8.0-040800rc6/scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux TCoin-2 4.8.0-040800rc6-generic #201609121119 SMP Mon Sep 12
15:21:03 UTC 2016 x86_64 x86_64 x86_64 GNU/Linux

GNU C           5.4.0
GNU Make        4.1
Binutils        2.26.1
Util-linux      2.27.1
Mount           2.27.1
Module-init-tools   22
E2fsprogs       1.42.13
Pcmciautils     018
PPP         2.4.7
Linux C Library     2.23
Dynamic linker (ldd)    2.23
Linux C++ Library   6.0.21
Procps          3.3.10
Net-tools       1.60
Kbd         1.15.5
Console-tools       1.15.5
Sh-utils        8.25
Udev            229
Wireless-tools      30
Modules Loaded      ablk_helper ac acpi_pad acpi_thermal_rel
aesni_intel aes_x86_64 ahci arc4 asus_nb_wmi asus_wireless asus_wmi
autofs4 battery bbswitch binfmt_misc bluetooth bnep bridge
br_netfilter btbcm btintel btqca btrtl btusb button ccm cfg80211
coretemp crc16 crc32c_generic crc32c_intel crc32_pclmul
crct10dif_pclmul cryptd ctr dm_bio_prison dm_bufio dm_mod
dm_persistent_data dm_thin_pool drm drm_kms_helper efi_pstore efivarfs
efivars evdev ext4 fat fb_sys_fops fjes fscrypto fuse gf128mul
ghash_clmulni_intel glue_helper hci_uart hid hid_generic i2c_algo_bit
i2c_designware_core i2c_designware_platform i2c_hid i915 idma64
int3400_thermal int3402_thermal int3403_thermal int3406_thermal
int340x_thermal_zone intel_cstate intel_lpss intel_lpss_acpi
intel_lpss_pci intel_powerclamp intel_rapl intel_rapl_perf
intel_soc_dts_iosf iptable_filter iptable_nat ip_tables ipt_MASQUERADE
irqbypass iwlmvm iwlwifi jbd2 kvm kvm_intel libahci libata libcrc32c
llc loop lp lrw mac80211 mbcache media mei mei_me mfd_core msr mxm_wmi
nf_conntrack nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat nf_nat_ipv4
nf_nat_masquerade_ipv4 nls_cp437 nls_utf8 nvidia nvidia_drm
nvidia_modeset nvme nvme_core parport parport_pc ppdev
processor_thermal_device rfcomm rfkill scsi_mod serio_raw shpchp snd
snd_hda_codec snd_hda_codec_generic snd_hda_codec_hdmi
snd_hda_codec_realtek snd_hda_core snd_hda_intel snd_hwdep snd_pcm
snd_rawmidi snd_seq snd_seq_device snd_seq_midi snd_seq_midi_event
snd_timer soundcore sparse_keymap stp syscopyarea sysfillrect
sysimgblt thermal tpm tpm_crb tpm_tis tpm_tis_core usb_common usbcore
usbhid uvcvideo vfat video videobuf2_core videobuf2_memops
videobuf2_v4l2 videobuf2_vmalloc videodev virt_dma wmi
x86_pkg_temp_thermal xfrm_algo xfrm_user xhci_hcd xhci_pci x_tables
xt_addrtype xt_conntrack

[7.2.] Processor information (from /proc/cpuinfo):
%  cat /proc/cpuinfo
processor   : 0
vendor_id   : GenuineIntel
cpu family  : 6
model       : 94
model name  : Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz
stepping    : 3
microcode   : 0x74
cpu MHz     : 799.963
cache size  : 6144 KB
physical id : 0
siblings    : 8
core id     : 0
cpu cores   : 4
apicid      : 0
initial apicid  : 0
fpu     : yes
fpu_exception   : yes
cpuid level : 22
wp      : yes
flags       : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall
nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good
nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64
monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c
rdrand lahf_lm abm 3dnowprefetch epb intel_pt tpr_shadow vnmi
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms
invpcid rtm mpx rdseed adx smap clflushopt xsaveopt xsavec xgetbv1
xsaves dtherm ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp
bugs        :
bogomips    : 5184.00
clflush size    : 64
cache_alignment : 64
address sizes   : 39 bits physical, 48 bits virtual
power management:

processor   : 1
vendor_id   : GenuineIntel
cpu family  : 6
model       : 94
model name  : Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz
stepping    : 3
microcode   : 0x74
cpu MHz     : 800.122
cache size  : 6144 KB
physical id : 0
siblings    : 8
core id     : 1
cpu cores   : 4
apicid      : 2
initial apicid  : 2
fpu     : yes
fpu_exception   : yes
cpuid level : 22
wp      : yes
flags       : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall
nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good
nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64
monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c
rdrand lahf_lm abm 3dnowprefetch epb intel_pt tpr_shadow vnmi
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms
invpcid rtm mpx rdseed adx smap clflushopt xsaveopt xsavec xgetbv1
xsaves dtherm ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp
bugs        :
bogomips    : 5184.94
clflush size    : 64
cache_alignment : 64
address sizes   : 39 bits physical, 48 bits virtual
power management:

processor   : 2
vendor_id   : GenuineIntel
cpu family  : 6
model       : 94
model name  : Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz
stepping    : 3
microcode   : 0x74
cpu MHz     : 799.963
cache size  : 6144 KB
physical id : 0
siblings    : 8
core id     : 2
cpu cores   : 4
apicid      : 4
initial apicid  : 4
fpu     : yes
fpu_exception   : yes
cpuid level : 22
wp      : yes
flags       : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall
nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good
nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64
monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c
rdrand lahf_lm abm 3dnowprefetch epb intel_pt tpr_shadow vnmi
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms
invpcid rtm mpx rdseed adx smap clflushopt xsaveopt xsavec xgetbv1
xsaves dtherm ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp
bugs        :
bogomips    : 5185.00
clflush size    : 64
cache_alignment : 64
address sizes   : 39 bits physical, 48 bits virtual
power management:

processor   : 3
vendor_id   : GenuineIntel
cpu family  : 6
model       : 94
model name  : Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz
stepping    : 3
microcode   : 0x74
cpu MHz     : 799.963
cache size  : 6144 KB
physical id : 0
siblings    : 8
core id     : 3
cpu cores   : 4
apicid      : 6
initial apicid  : 6
fpu     : yes
fpu_exception   : yes
cpuid level : 22
wp      : yes
flags       : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall
nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good
nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64
monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c
rdrand lahf_lm abm 3dnowprefetch epb intel_pt tpr_shadow vnmi
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms
invpcid rtm mpx rdseed adx smap clflushopt xsaveopt xsavec xgetbv1
xsaves dtherm ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp
bugs        :
bogomips    : 5184.97
clflush size    : 64
cache_alignment : 64
address sizes   : 39 bits physical, 48 bits virtual
power management:

processor   : 4
vendor_id   : GenuineIntel
cpu family  : 6
model       : 94
model name  : Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz
stepping    : 3
microcode   : 0x74
cpu MHz     : 799.963
cache size  : 6144 KB
physical id : 0
siblings    : 8
core id     : 0
cpu cores   : 4
apicid      : 1
initial apicid  : 1
fpu     : yes
fpu_exception   : yes
cpuid level : 22
wp      : yes
flags       : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall
nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good
nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64
monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c
rdrand lahf_lm abm 3dnowprefetch epb intel_pt tpr_shadow vnmi
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms
invpcid rtm mpx rdseed adx smap clflushopt xsaveopt xsavec xgetbv1
xsaves dtherm ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp
bugs        :
bogomips    : 5185.28
clflush size    : 64
cache_alignment : 64
address sizes   : 39 bits physical, 48 bits virtual
power management:

processor   : 5
vendor_id   : GenuineIntel
cpu family  : 6
model       : 94
model name  : Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz
stepping    : 3
microcode   : 0x74
cpu MHz     : 799.963
cache size  : 6144 KB
physical id : 0
siblings    : 8
core id     : 1
cpu cores   : 4
apicid      : 3
initial apicid  : 3
fpu     : yes
fpu_exception   : yes
cpuid level : 22
wp      : yes
flags       : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall
nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good
nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64
monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c
rdrand lahf_lm abm 3dnowprefetch epb intel_pt tpr_shadow vnmi
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms
invpcid rtm mpx rdseed adx smap clflushopt xsaveopt xsavec xgetbv1
xsaves dtherm ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp
bugs        :
bogomips    : 5185.02
clflush size    : 64
cache_alignment : 64
address sizes   : 39 bits physical, 48 bits virtual
power management:

processor   : 6
vendor_id   : GenuineIntel
cpu family  : 6
model       : 94
model name  : Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz
stepping    : 3
microcode   : 0x74
cpu MHz     : 799.963
cache size  : 6144 KB
physical id : 0
siblings    : 8
core id     : 2
cpu cores   : 4
apicid      : 5
initial apicid  : 5
fpu     : yes
fpu_exception   : yes
cpuid level : 22
wp      : yes
flags       : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall
nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good
nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64
monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c
rdrand lahf_lm abm 3dnowprefetch epb intel_pt tpr_shadow vnmi
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms
invpcid rtm mpx rdseed adx smap clflushopt xsaveopt xsavec xgetbv1
xsaves dtherm ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp
bugs        :
bogomips    : 5184.99
clflush size    : 64
cache_alignment : 64
address sizes   : 39 bits physical, 48 bits virtual
power management:

processor   : 7
vendor_id   : GenuineIntel
cpu family  : 6
model       : 94
model name  : Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz
stepping    : 3
microcode   : 0x74
cpu MHz     : 799.963
cache size  : 6144 KB
physical id : 0
siblings    : 8
core id     : 3
cpu cores   : 4
apicid      : 7
initial apicid  : 7
fpu     : yes
fpu_exception   : yes
cpuid level : 22
wp      : yes
flags       : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall
nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good
nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64
monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c
rdrand lahf_lm abm 3dnowprefetch epb intel_pt tpr_shadow vnmi
flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms
invpcid rtm mpx rdseed adx smap clflushopt xsaveopt xsavec xgetbv1
xsaves dtherm ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp
bugs        :
bogomips    : 5184.99
clflush size    : 64
cache_alignment : 64
address sizes   : 39 bits physical, 48 bits virtual
power management:

[7.3.] Module information (from /proc/modules):
% cat /proc/modules
ctr 16384 2 - Live 0xffffffffc1604000
ccm 20480 1 - Live 0xffffffffc177f000
ipt_MASQUERADE 16384 1 - Live 0xffffffffc177a000
nf_nat_masquerade_ipv4 16384 1 ipt_MASQUERADE, Live 0xffffffffc1775000
xfrm_user 36864 1 - Live 0xffffffffc15fa000
xfrm_algo 16384 1 xfrm_user, Live 0xffffffffc16c8000
iptable_nat 16384 1 - Live 0xffffffffc1504000
nf_conntrack_ipv4 20480 2 - Live 0xffffffffc16b3000
nf_defrag_ipv4 16384 1 nf_conntrack_ipv4, Live 0xffffffffc167c000
nf_nat_ipv4 16384 1 iptable_nat, Live 0xffffffffc1643000
xt_addrtype 16384 2 - Live 0xffffffffc1639000
iptable_filter 16384 1 - Live 0xffffffffc152b000
ip_tables 24576 2 iptable_nat,iptable_filter, Live 0xffffffffc176e000
xt_conntrack 16384 1 - Live 0xffffffffc1444000
x_tables 36864 5
ipt_MASQUERADE,xt_addrtype,iptable_filter,ip_tables,xt_conntrack, Live
0xffffffffc16a9000
nf_nat 28672 2 nf_nat_masquerade_ipv4,nf_nat_ipv4, Live 0xffffffffc14fc000
nf_conntrack 114688 5
nf_nat_masquerade_ipv4,nf_conntrack_ipv4,nf_nat_ipv4,xt_conntrack,nf_nat,
Live 0xffffffffc17e3000
br_netfilter 24576 0 - Live 0xffffffffc13ea000
bridge 135168 1 br_netfilter, Live 0xffffffffc174c000
stp 16384 1 bridge, Live 0xffffffffc14f2000
llc 16384 2 bridge,stp, Live 0xffffffffc13f2000
rfcomm 77824 0 - Live 0xffffffffc165e000
fuse 98304 3 - Live 0xffffffffc1733000
dm_thin_pool 65536 1 - Live 0xffffffffc164d000
dm_persistent_data 65536 1 dm_thin_pool, Live 0xffffffffc151a000
dm_bio_prison 16384 1 dm_thin_pool, Live 0xffffffffc149e000
dm_bufio 28672 1 dm_persistent_data, Live 0xffffffffc14dc000
libcrc32c 16384 1 dm_persistent_data, Live 0xffffffffc1480000
crc32c_generic 16384 0 - Live 0xffffffffc1463000
loop 28672 4 - Live 0xffffffffc1491000
dm_mod 114688 5 dm_thin_pool,dm_persistent_data,dm_bufio, Live
0xffffffffc15dd000
bbswitch 16384 0 - Live 0xffffffffc12d2000 (OE)
bnep 20480 2 - Live 0xffffffffc1437000
arc4 16384 2 - Live 0xffffffffc1162000
iwlmvm 241664 0 - Live 0xffffffffc16f7000
mac80211 663552 1 iwlmvm, Live 0xffffffffc18cd000
binfmt_misc 20480 1 - Live 0xffffffffc13be000
nls_utf8 16384 1 - Live 0xffffffffc1173000
nls_cp437 20480 1 - Live 0xffffffffc13b8000
vfat 20480 1 - Live 0xffffffffc13b2000
snd_hda_codec_hdmi 45056 1 - Live 0xffffffffc150e000
snd_hda_codec_realtek 86016 1 - Live 0xffffffffc1681000
snd_hda_codec_generic 69632 1 snd_hda_codec_realtek, Live 0xffffffffc1697000
intel_rapl 20480 0 - Live 0xffffffffc1676000
x86_pkg_temp_thermal 16384 0 - Live 0xffffffffc1648000
intel_powerclamp 16384 0 - Live 0xffffffffc163e000
coretemp 16384 0 - Live 0xffffffffc1402000
uvcvideo 90112 0 - Live 0xffffffffc18af000
videobuf2_vmalloc 16384 1 uvcvideo, Live 0xffffffffc12e1000
videobuf2_memops 16384 1 videobuf2_vmalloc, Live 0xffffffffc1178000
fat 69632 1 vfat, Live 0xffffffffc189d000
videobuf2_v4l2 24576 1 uvcvideo, Live 0xffffffffc1539000
videobuf2_core 40960 2 uvcvideo,videobuf2_v4l2, Live 0xffffffffc16ec000
videodev 176128 3 uvcvideo,videobuf2_v4l2,videobuf2_core, Live
0xffffffffc1861000
media 40960 2 uvcvideo,videodev, Live 0xffffffffc16bd000
btusb 45056 0 - Live 0xffffffffc13a6000
btrtl 16384 1 btusb, Live 0xffffffffc104e000
msr 16384 0 - Live 0xffffffffc0fe0000
asus_nb_wmi 24576 0 - Live 0xffffffffc17dc000
asus_wmi 28672 1 asus_nb_wmi, Live 0xffffffffc17cf000
sparse_keymap 16384 1 asus_wmi, Live 0xffffffffc17ca000
mxm_wmi 16384 0 - Live 0xffffffffc17c2000
i2c_designware_platform 16384 0 - Live 0xffffffffc1546000
i2c_designware_core 20480 1 i2c_designware_platform, Live 0xffffffffc17b0000
snd_hda_intel 36864 3 - Live 0xffffffffc16cd000
snd_hda_codec 135168 4
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,
Live 0xffffffffc1787000
snd_hda_core 81920 5
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,
Live 0xffffffffc16d7000
snd_hwdep 16384 1 snd_hda_codec, Live 0xffffffffc14e8000
snd_pcm 110592 4
snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec,snd_hda_core, Live
0xffffffffc1845000
kvm_intel 192512 0 - Live 0xffffffffc1609000
snd_seq_midi 16384 0 - Live 0xffffffffc14ad000
snd_seq_midi_event 16384 1 snd_seq_midi, Live 0xffffffffc14f7000
kvm 593920 1 kvm_intel, Live 0xffffffffc154b000
irqbypass 16384 1 kvm, Live 0xffffffffc1541000
crct10dif_pclmul 16384 0 - Live 0xffffffffc1509000
crc32_pclmul 16384 0 - Live 0xffffffffc14ed000
snd_rawmidi 32768 1 snd_seq_midi, Live 0xffffffffc1530000
ghash_clmulni_intel 16384 0 - Live 0xffffffffc1499000
aesni_intel 167936 2 - Live 0xffffffffc14b2000
aes_x86_64 20480 1 aesni_intel, Live 0xffffffffc14a4000
lrw 16384 1 aesni_intel, Live 0xffffffffc146f000
snd_seq 65536 2 snd_seq_midi,snd_seq_midi_event, Live 0xffffffffc1452000
gf128mul 16384 1 lrw, Live 0xffffffffc1485000
glue_helper 16384 1 aesni_intel, Live 0xffffffffc1474000
ablk_helper 16384 1 aesni_intel, Live 0xffffffffc146a000
cryptd 24576 3 ghash_clmulni_intel,aesni_intel,ablk_helper, Live
0xffffffffc148a000
intel_cstate 20480 0 - Live 0xffffffffc147a000
snd_seq_device 16384 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0xffffffffc1449000
intel_rapl_perf 16384 0 - Live 0xffffffffc143f000
hci_uart 86016 0 - Live 0xffffffffc1421000
serio_raw 16384 0 - Live 0xffffffffc1419000
btbcm 16384 2 btusb,hci_uart, Live 0xffffffffc1414000
btqca 16384 1 hci_uart, Live 0xffffffffc140f000
efi_pstore 16384 0 - Live 0xffffffffc1407000
snd_timer 32768 2 snd_pcm,snd_seq, Live 0xffffffffc13f9000
btintel 16384 2 btusb,hci_uart, Live 0xffffffffc10db000
iwlwifi 147456 1 iwlmvm, Live 0xffffffffc13c5000
efivars 20480 1 efi_pstore, Live 0xffffffffc103f000
bluetooth 544768 33
rfcomm,bnep,btusb,btrtl,hci_uart,btbcm,btqca,btintel, Live
0xffffffffc1320000
snd 86016 17 snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_seq_device,snd_timer,
Live 0xffffffffc22a3000
cfg80211 589824 3 iwlmvm,mac80211,iwlwifi, Live 0xffffffffc21e4000
soundcore 16384 1 snd, Live 0xffffffffc1eb7000
int3403_thermal 16384 0 - Live 0xffffffffc1e5e000
rfkill 24576 7 asus_wmi,bluetooth,cfg80211, Live 0xffffffffc1e4d000
battery 16384 0 - Live 0xffffffffc1e43000
wmi 16384 2 asus_wmi,mxm_wmi, Live 0xffffffffc1e3a000
ac 16384 0 - Live 0xffffffffc1e32000
int3406_thermal 16384 0 - Live 0xffffffffc1e2a000
tpm_crb 16384 0 - Live 0xffffffffc1e1a000
intel_lpss_acpi 16384 0 - Live 0xffffffffc1e12000
int3402_thermal 16384 0 - Live 0xffffffffc1318000
int3400_thermal 16384 0 - Live 0xffffffffc12dc000
acpi_pad 180224 0 - Live 0xffffffffc12eb000
asus_wireless 16384 0 - Live 0xffffffffc12d7000
acpi_thermal_rel 16384 1 int3400_thermal, Live 0xffffffffc12e6000
mei_me 36864 0 - Live 0xffffffffc12c8000
idma64 20480 0 - Live 0xffffffffc12c2000
virt_dma 16384 1 idma64, Live 0xffffffffc117d000
mei 102400 1 mei_me, Live 0xffffffffc1e84000
shpchp 36864 0 - Live 0xffffffffc1158000
intel_lpss_pci 16384 0 - Live 0xffffffffc113c000
intel_lpss 16384 2 intel_lpss_acpi,intel_lpss_pci, Live 0xffffffffc1153000
mfd_core 16384 1 intel_lpss, Live 0xffffffffc114e000
evdev 24576 27 - Live 0xffffffffc1086000
processor_thermal_device 16384 0 - Live 0xffffffffc116a000
int340x_thermal_zone 16384 3
int3403_thermal,int3402_thermal,processor_thermal_device, Live
0xffffffffc112d000
intel_soc_dts_iosf 16384 1 processor_thermal_device, Live 0xffffffffc110d000
tpm_tis 16384 0 - Live 0xffffffffc0f89000
tpm_tis_core 20480 1 tpm_tis, Live 0xffffffffc1115000
tpm 45056 3 tpm_crb,tpm_tis,tpm_tis_core, Live 0xffffffffc10cb000
parport_pc 28672 0 - Live 0xffffffffc102c000
ppdev 20480 0 - Live 0xffffffffc1026000
lp 20480 0 - Live 0xffffffffc1020000
parport 49152 3 parport_pc,ppdev,lp, Live 0xffffffffc0fd3000
efivarfs 16384 1 - Live 0xffffffffc0f8e000
autofs4 40960 2 - Live 0xffffffffc0eed000
ext4 589824 1 - Live 0xffffffffc0ef8000
crc16 16384 2 bluetooth,ext4, Live 0xffffffffc0ecc000
jbd2 110592 1 ext4, Live 0xffffffffc0ed1000
fscrypto 28672 1 ext4, Live 0xffffffffc0ec4000
mbcache 16384 2 ext4, Live 0xffffffffc0349000
hid_generic 16384 0 - Live 0xffffffffc035e000
usbhid 53248 0 - Live 0xffffffffc033b000
nvidia_drm 45056 0 - Live 0xffffffffc0352000 (POE)
nvidia_modeset 765952 1 nvidia_drm, Live 0xffffffffc1ebd000 (POE)
i915 1294336 4 - Live 0xffffffffc1185000
crc32c_intel 24576 1 - Live 0xffffffffc1143000
ahci 36864 0 - Live 0xffffffffc1132000
libahci 32768 1 ahci, Live 0xffffffffc1124000
i2c_algo_bit 16384 1 i915, Live 0xffffffffc111f000
xhci_pci 16384 0 - Live 0xffffffffc0322000
drm_kms_helper 155648 2 nvidia_drm,i915, Live 0xffffffffc10e2000
libata 249856 2 ahci,libahci, Live 0xffffffffc108d000
xhci_hcd 188416 1 xhci_pci, Live 0xffffffffc1053000
nvme 28672 3 - Live 0xffffffffc1046000
nvme_core 40960 5 nvme, Live 0xffffffffc1034000
syscopyarea 16384 1 drm_kms_helper, Live 0xffffffffc036a000
sysfillrect 16384 1 drm_kms_helper, Live 0xffffffffc0363000
sysimgblt 16384 1 drm_kms_helper, Live 0xffffffffc0330000
scsi_mod 225280 1 libata, Live 0xffffffffc0fe8000
fb_sys_fops 16384 1 drm_kms_helper, Live 0xffffffffc0329000
usbcore 253952 6 uvcvideo,btusb,usbhid,xhci_pci,xhci_hcd, Live
0xffffffffc0f94000
nvidia 11472896 1 nvidia_modeset, Live 0xffffffffc0379000 (POE)
drm 360448 6 nvidia_drm,i915,drm_kms_helper, Live 0xffffffffc0e6b000
usb_common 16384 1 usbcore, Live 0xffffffffc02ff000
thermal 20480 0 - Live 0xffffffffc0335000
i2c_hid 20480 0 - Live 0xffffffffc0373000
hid 118784 3 hid_generic,usbhid,i2c_hid, Live 0xffffffffc0304000
video 40960 3 asus_wmi,int3406_thermal,i915, Live 0xffffffffc02f4000
button 16384 1 i915, Live 0xffffffffc02eb000
fjes 28672 0 - Live 0xffffffffc02df000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
% cat /proc/ioports
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
    00f0-00f0 : PNP0C04:00
  0240-0259 : pnp 00:04
  0680-069f : pnp 00:00
  0800-087f : pnp 00:01
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
  164e-164f : pnp 00:00
  1800-18fe : pnp 00:00
    1800-1803 : ACPI PM1a_EVT_BLK
    1804-1805 : ACPI PM1a_CNT_BLK
    1808-180b : ACPI PM_TMR
    1850-1850 : ACPI PM2_CNT_BLK
    1854-1857 : pnp 00:03
    1880-189f : ACPI GPE0_BLK
  2000-2fff : PCI Bus 0000:04
  d000-dfff : PCI Bus 0000:3d
    d000-d0ff : 0000:3d:00.0
  e000-efff : PCI Bus 0000:01
    e000-e07f : 0000:01:00.0
  f000-f03f : 0000:00:02.0
  f040-f05f : 0000:00:1f.4
  f060-f07f : 0000:00:17.0
    f060-f07f : ahci
  f080-f083 : 0000:00:17.0
    f080-f083 : ahci
  f090-f097 : 0000:00:17.0
    f090-f097 : ahci
  ff00-fffe : pnp 00:08
  ffff-ffff : pnp 00:00
    ffff-ffff : pnp 00:00
      ffff-ffff : pnp 00:00

% cat /proc/iomem
00000000-00000fff : reserved
00001000-00057fff : System RAM
00058000-00058fff : reserved
00059000-0009efff : System RAM
0009f000-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000cf9ff : Video ROM
000f0000-000fffff : System ROM
00100000-31af0fff : System RAM
31af1000-31af1fff : ACPI Non-volatile Storage
31af2000-31b3bfff : reserved
31b3c000-3511ffff : System RAM
35120000-35e44fff : reserved
35e45000-361ddfff : System RAM
361de000-3708afff : ACPI Non-volatile Storage
3708b000-37f01fff : reserved
37f02000-37f7efff : reserved
37f7f000-37ffefff : System RAM
37fff000-37ffffff : RAM buffer
38000000-380fffff : reserved
39000000-3cffffff : reserved
  39000000-3cffffff : Graphics Stolen Memory
3d000000-dfffffff : PCI Bus 0000:00
  70000000-7fffffff : 0000:00:02.0
    70000000-701d4fff : BOOTFB
  80000000-a1ffffff : PCI Bus 0000:04
  b0000000-c1ffffff : PCI Bus 0000:01
    b0000000-bfffffff : 0000:01:00.0
    c0000000-c1ffffff : 0000:01:00.0
  c4000000-da0fffff : PCI Bus 0000:04
  db000000-dbffffff : 0000:00:02.0
  dc000000-dd0fffff : PCI Bus 0000:01
    dc000000-dcffffff : 0000:01:00.0
      dc000000-dcffffff : nvidia
    dd000000-dd07ffff : 0000:01:00.0
  dd100000-dd1fffff : PCI Bus 0000:3d
    dd100000-dd103fff : 0000:3d:00.0
      dd100000-dd103fff : nvme
  dd200000-dd2fffff : PCI Bus 0000:03
    dd200000-dd201fff : 0000:03:00.0
      dd200000-dd201fff : iwlwifi
  dd300000-dd3fffff : PCI Bus 0000:02
    dd300000-dd3000ff : 0000:02:00.0
  dd400000-dd40ffff : 0000:00:1f.3
    dd400000-dd40ffff : ICH HD audio
  dd410000-dd41ffff : 0000:00:14.0
    dd410000-dd41ffff : xhci-hcd
  dd420000-dd427fff : 0000:00:04.0
  dd428000-dd42bfff : 0000:00:1f.3
    dd428000-dd42bfff : ICH HD audio
  dd42c000-dd42ffff : 0000:00:1f.2
  dd430000-dd431fff : 0000:00:17.0
    dd430000-dd431fff : ahci
  dd432000-dd4320ff : 0000:00:1f.4
  dd433000-dd4337ff : 0000:00:17.0
    dd433000-dd4337ff : ahci
  dd434000-dd4340ff : 0000:00:17.0
    dd434000-dd4340ff : ahci
  dd435000-dd435fff : 0000:00:16.0
    dd435000-dd435fff : mei_me
  dd436000-dd436fff : 0000:00:15.1
    dd436000-dd4361ff : lpss_dev
      dd436000-dd4361ff : lpss_dev
    dd436200-dd4362ff : lpss_priv
    dd436800-dd436fff : idma64.1
      dd436800-dd436fff : idma64.1
  dd437000-dd437fff : 0000:00:15.0
    dd437000-dd4371ff : lpss_dev
      dd437000-dd4371ff : lpss_dev
    dd437200-dd4372ff : lpss_priv
    dd437800-dd437fff : idma64.0
      dd437800-dd437fff : idma64.0
  dd438000-dd438fff : 0000:00:14.2
  dffe0000-dfffffff : pnp 00:06
e0000000-efffffff : PCI MMCONFIG 0000 [bus 00-ff]
  e0000000-efffffff : reserved
    e0000000-efffffff : pnp 00:06
fd000000-fe7fffff : PCI Bus 0000:00
  fd000000-fdabffff : pnp 00:07
  fdac0000-fdacffff : pnp 00:09
  fdad0000-fdadffff : pnp 00:07
  fdae0000-fdaeffff : pnp 00:09
  fdaf0000-fdafffff : pnp 00:09
  fdb00000-fdffffff : pnp 00:07
  fe000000-fe010fff : reserved
  fe036000-fe03bfff : pnp 00:07
  fe03d000-fe3fffff : pnp 00:07
  fe410000-fe7fffff : pnp 00:07
fec00000-fec00fff : reserved
  fec00000-fec003ff : IOAPIC 0
fed00000-fed003ff : HPET 0
  fed00000-fed003ff : PNP0103:00
fed10000-fed17fff : pnp 00:06
fed18000-fed18fff : pnp 00:06
fed19000-fed19fff : pnp 00:06
fed20000-fed3ffff : pnp 00:06
fed40000-fed4087f : MSFT0101:00
fed45000-fed8ffff : pnp 00:06
fed90000-fed90fff : dmar0
fed91000-fed91fff : dmar1
fee00000-fee00fff : Local APIC
  fee00000-fee00fff : reserved
ff000000-ffffffff : reserved
  ff000000-ffffffff : INT0800:00
    ff000000-ffffffff : pnp 00:06
100000000-4c1ffffff : System RAM
  24b000000-24b6220db : Kernel code
  24b6220dc-24bd53c7f : Kernel data
  24beda000-24c000fff : Kernel bss
4c2000000-4c3ffffff : RAM buffer

[7.5.] PCI information ('lspci -vvv' as root)
% sudo lspci -vvv
00:00.0 Host bridge: Intel Corporation Sky Lake Host Bridge/DRAM
Registers (rev 07)
    Subsystem: ASUSTeK Computer Inc. Skylake Host Bridge/DRAM Registers
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR- INTx-
    Latency: 0
    Capabilities: [e0] Vendor Specific Information: Len=10 <?>

00:01.0 PCI bridge: Intel Corporation Sky Lake PCIe Controller (x16)
(rev 07) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 122
    Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
    I/O behind bridge: 0000e000-0000efff
    Memory behind bridge: dc000000-dd0fffff
    Prefetchable memory behind bridge: 00000000b0000000-00000000c1ffffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [88] Subsystem: ASUSTeK Computer Inc. Skylake PCIe
Controller (x16)
    Capabilities: [80] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Address: fee00238  Data: 0000
    Capabilities: [a0] Express (v2) Root Port (Slot+), MSI 00
        DevCap: MaxPayload 256 bytes, PhantFunc 0
            ExtTag- RBE+
        DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
        LnkCap: Port #2, Speed 8GT/s, Width x16, ASPM L0s L1, Exit
Latency L0s <256ns, L1 <8us
            ClockPM- Surprise- LLActRep- BwNot+ ASPMOptComp+
        LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta: Speed 8GT/s, Width x8, TrErr- Train- SlotClk+
DLActive- BWMgmt+ ABWMgmt+
        SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
            Slot #1, PowerLimit 75.000W; Interlock- NoCompl+
        SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
            Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
        SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
            Changed: MRL- PresDet+ LinkState-
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
        RootCap: CRSVisible-
        RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR+,
OBFF Via WAKE# ARIFwd-
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+,
OBFF Via WAKE# ARIFwd-
        LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete+, EqualizationPhase1+
             EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest-
    Capabilities: [100 v1] Virtual Channel
        Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
        Arb:    Fixed- WRR32- WRR64- WRR128-
        Ctrl:   ArbSelect=Fixed
        Status: InProgress-
        VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
            Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
            Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
            Status: NegoPending- InProgress-
    Capabilities: [140 v1] Root Complex Link
        Desc:   PortNumber=02 ComponentID=01 EltType=Config
        Link0:  Desc:   TargetPort=00 TargetComponent=01 AssocRCRB-
LinkType=MemMapped LinkValid+
            Addr:   00000000fed19000
    Capabilities: [d94 v1] #19
    Kernel driver in use: pcieport
    Kernel modules: shpchp

00:02.0 VGA compatible controller: Intel Corporation Skylake
Integrated Graphics (rev 06) (prog-if 00 [VGA controller])
    Subsystem: ASUSTeK Computer Inc. Skylake Integrated Graphics
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 126
    Region 0: Memory at db000000 (64-bit, non-prefetchable) [size=16M]
    Region 2: Memory at 70000000 (64-bit, prefetchable) [size=256M]
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
        DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-,
OBFF Not Supported
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-,
OBFF Disabled
    Capabilities: [ac] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Address: fee00018  Data: 0000
    Capabilities: [d0] Power Management version 2
        Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [100 v1] #1b
    Capabilities: [200 v1] Address Translation Service (ATS)
        ATSCap: Invalidate Queue Depth: 00
        ATSCtl: Enable-, Smallest Translation Unit: 00
    Capabilities: [300 v1] #13
    Kernel driver in use: i915
    Kernel modules: i915

00:04.0 Signal processing controller: Intel Corporation Skylake
Processor Thermal Subsystem (rev 07)
    Subsystem: ASUSTeK Computer Inc. Skylake Processor Thermal Subsystem
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 16
    Region 0: Memory at dd420000 (64-bit, non-prefetchable) [size=32K]
    Capabilities: [90] MSI: Enable- Count=1/1 Maskable- 64bit-
        Address: 00000000  Data: 0000
    Capabilities: [d0] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [e0] Vendor Specific Information: Len=0c <?>
    Kernel driver in use: proc_thermal
    Kernel modules: processor_thermal_device

00:14.0 USB controller: Intel Corporation Sunrise Point-H USB 3.0 xHCI
Controller (rev 31) (prog-if 30 [XHCI])
    Subsystem: ASUSTeK Computer Inc. Sunrise Point-H USB 3.0 xHCI Controller
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 124
    Region 0: Memory at dd410000 (64-bit, non-prefetchable) [size=64K]
    Capabilities: [70] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
        Address: 00000000fee002b8  Data: 0000
    Kernel driver in use: xhci_hcd
    Kernel modules: xhci_pci

00:14.2 Signal processing controller: Intel Corporation Sunrise
Point-H Thermal subsystem (rev 31)
    Subsystem: ASUSTeK Computer Inc. Sunrise Point-H Thermal subsystem
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin C routed to IRQ 11
    Region 0: Memory at dd438000 (64-bit, non-prefetchable) [size=4K]
    Capabilities: [50] Power Management version 3
        Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
        Address: 00000000  Data: 0000

00:15.0 Signal processing controller: Intel Corporation Sunrise
Point-H LPSS I2C Controller #0 (rev 31)
    Subsystem: ASUSTeK Computer Inc. Sunrise Point-H Serial IO I2C Controller
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 16
    Region 0: Memory at dd437000 (64-bit, non-prefetchable) [size=4K]
    Capabilities: [80] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [90] Vendor Specific Information: Len=14 <?>
    Kernel driver in use: intel-lpss
    Kernel modules: intel_lpss_pci

00:15.1 Signal processing controller: Intel Corporation Sunrise
Point-H LPSS I2C Controller #1 (rev 31)
    Subsystem: ASUSTeK Computer Inc. Sunrise Point-H Serial IO I2C Controller
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin B routed to IRQ 17
    Region 0: Memory at dd436000 (64-bit, non-prefetchable) [size=4K]
    Capabilities: [80] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [90] Vendor Specific Information: Len=14 <?>
    Kernel driver in use: intel-lpss
    Kernel modules: intel_lpss_pci

00:16.0 Communication controller: Intel Corporation Sunrise Point-H
CSME HECI #1 (rev 31)
    Subsystem: ASUSTeK Computer Inc. Sunrise Point-H CSME HECI
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 134
    Region 0: Memory at dd435000 (64-bit, non-prefetchable) [size=4K]
    Capabilities: [50] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold-)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Address: 00000000fee003d8  Data: 0000
    Kernel driver in use: mei_me
    Kernel modules: mei_me

00:17.0 SATA controller: Intel Corporation Sunrise Point-H SATA
Controller [AHCI mode] (rev 31) (prog-if 01 [AHCI 1.0])
    Subsystem: ASUSTeK Computer Inc. Sunrise Point-H SATA Controller [AHCI mode]
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 125
    Region 0: Memory at dd430000 (32-bit, non-prefetchable) [size=8K]
    Region 1: Memory at dd434000 (32-bit, non-prefetchable) [size=256]
    Region 2: I/O ports at f090 [size=8]
    Region 3: I/O ports at f080 [size=4]
    Region 4: I/O ports at f060 [size=32]
    Region 5: Memory at dd433000 (32-bit, non-prefetchable) [size=2K]
    Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Address: fee002d8  Data: 0000
    Capabilities: [70] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold-)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
    Kernel driver in use: ahci
    Kernel modules: ahci

00:1c.0 PCI bridge: Intel Corporation Sunrise Point-H PCI Express Root
Port #2 (rev f1) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin B routed to IRQ 17
    Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
    I/O behind bridge: 0000f000-00000fff
    Memory behind bridge: dd300000-dd3fffff
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
        DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
        LnkCap: Port #2, Speed 8GT/s, Width x1, ASPM L1, Exit Latency
L0s <1us, L1 <16us
            ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
        LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive+ BWMgmt+ ABWMgmt-
        SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
            Slot #5, PowerLimit 10.000W; Interlock- NoCompl+
        SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
            Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
        SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
            Changed: MRL- PresDet- LinkState+
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
        RootCap: CRSVisible-
        RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+,
OBFF Not Supported ARIFwd+
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+,
OBFF Disabled ARIFwd-
        LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
    Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
        Address: 00000000  Data: 0000
    Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Sunrise
Point-H PCI Express Root Port
    Capabilities: [a0] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=0 PME-
    Capabilities: [100 v1] Advanced Error Reporting
        UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt+
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UESvrt: DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
        CESta:  RxErr+ BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
        CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
        AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
    Capabilities: [140 v1] Access Control Services
        ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd-
EgressCtrl- DirectTrans-
        ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd-
EgressCtrl- DirectTrans-
    Capabilities: [200 v1] L1 PM Substates
        L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
L1_PM_Substates+
              PortCommonModeRestoreTime=40us PortTPowerOnTime=10us
    Capabilities: [220 v1] #19
    Kernel driver in use: pcieport
    Kernel modules: shpchp

00:1c.2 PCI bridge: Intel Corporation Sunrise Point-H PCI Express Root
Port #3 (rev f1) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin C routed to IRQ 18
    Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
    I/O behind bridge: 0000f000-00000fff
    Memory behind bridge: dd200000-dd2fffff
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
        DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
        LnkCap: Port #3, Speed 8GT/s, Width x1, ASPM L1, Exit Latency
L0s <1us, L1 <16us
            ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
        LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive+ BWMgmt+ ABWMgmt-
        SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
            Slot #6, PowerLimit 10.000W; Interlock- NoCompl+
        SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
            Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
        SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
            Changed: MRL- PresDet- LinkState+
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
        RootCap: CRSVisible-
        RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+,
OBFF Not Supported ARIFwd+
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+,
OBFF Disabled ARIFwd-
        LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
    Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
        Address: 00000000  Data: 0000
    Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Sunrise
Point-H PCI Express Root Port
    Capabilities: [a0] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [100 v1] Advanced Error Reporting
        UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt+
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UESvrt: DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
        CESta:  RxErr+ BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
        CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
        AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
    Capabilities: [140 v1] Access Control Services
        ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd-
EgressCtrl- DirectTrans-
        ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd-
EgressCtrl- DirectTrans-
    Capabilities: [200 v1] L1 PM Substates
        L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
L1_PM_Substates+
              PortCommonModeRestoreTime=40us PortTPowerOnTime=10us
    Capabilities: [220 v1] #19
    Kernel driver in use: pcieport
    Kernel modules: shpchp

00:1c.4 PCI bridge: Intel Corporation Sunrise Point-H PCI Express Root
Port #5 (rev f1) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 16
    Bus: primary=00, secondary=04, subordinate=3c, sec-latency=0
    I/O behind bridge: 00002000-00002fff
    Memory behind bridge: c4000000-da0fffff
    Prefetchable memory behind bridge: 0000000080000000-00000000a1ffffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
        DevCap: MaxPayload 128 bytes, PhantFunc 0
            ExtTag- RBE+
        DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
        LnkCap: Port #5, Speed 8GT/s, Width x4, ASPM L1, Exit Latency
L0s unlimited, L1 <16us
            ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
        LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk-
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta: Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
        SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
            Slot #8, PowerLimit 25.000W; Interlock- NoCompl+
        SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq- LinkChg-
            Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
        SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
            Changed: MRL- PresDet- LinkState-
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
        RootCap: CRSVisible-
        RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+,
OBFF Not Supported ARIFwd+
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-,
OBFF Disabled ARIFwd-
        LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
    Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
        Address: 00000000  Data: 0000
    Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Sunrise
Point-H PCI Express Root Port
    Capabilities: [a0] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [100 v1] Advanced Error Reporting
        UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UEMsk:  DLP- SDES- TLP- FCP- CmpltTO+ CmpltAbrt- UnxCmplt+
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UESvrt: DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
        CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
        CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
        AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
    Capabilities: [140 v1] Access Control Services
        ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd-
EgressCtrl- DirectTrans-
        ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd-
EgressCtrl- DirectTrans-
    Capabilities: [200 v1] L1 PM Substates
        L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
L1_PM_Substates+
              PortCommonModeRestoreTime=40us PortTPowerOnTime=10us
    Capabilities: [220 v1] #19
    Kernel driver in use: pcieport
    Kernel modules: shpchp

00:1d.0 PCI bridge: Intel Corporation Sunrise Point-H PCI Express Root
Port #9 (rev f1) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 16
    Bus: primary=00, secondary=3d, subordinate=3d, sec-latency=0
    I/O behind bridge: 0000d000-0000dfff
    Memory behind bridge: dd100000-dd1fffff
    Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
        DevCap: MaxPayload 128 bytes, PhantFunc 0
            ExtTag- RBE+
        DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
        LnkCap: Port #9, Speed 8GT/s, Width x4, ASPM L1, Exit Latency
L0s <1us, L1 <16us
            ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
        LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta: Speed 8GT/s, Width x4, TrErr- Train- SlotClk+
DLActive+ BWMgmt+ ABWMgmt-
        SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
            Slot #12, PowerLimit 25.000W; Interlock- NoCompl+
        SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
            Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
        SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
            Changed: MRL- PresDet+ LinkState+
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
        RootCap: CRSVisible-
        RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+,
OBFF Not Supported ARIFwd+
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+,
OBFF Disabled ARIFwd-
        LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete+, EqualizationPhase1+
             EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest-
    Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
        Address: 00000000  Data: 0000
    Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Sunrise
Point-H PCI Express Root Port
    Capabilities: [a0] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [100 v1] Advanced Error Reporting
        UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt+
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UESvrt: DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
        CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
        CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
        AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
    Capabilities: [140 v1] Access Control Services
        ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd-
EgressCtrl- DirectTrans-
        ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd-
EgressCtrl- DirectTrans-
    Capabilities: [200 v1] L1 PM Substates
        L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
L1_PM_Substates+
              PortCommonModeRestoreTime=40us PortTPowerOnTime=10us
    Capabilities: [220 v1] #19
    Kernel driver in use: pcieport
    Kernel modules: shpchp

00:1f.0 ISA bridge: Intel Corporation Sunrise Point-H LPC Controller (rev 31)
    Subsystem: ASUSTeK Computer Inc. Sunrise Point-H LPC Controller
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0

00:1f.2 Memory controller: Intel Corporation Sunrise Point-H PMC (rev 31)
    Subsystem: ASUSTeK Computer Inc. Sunrise Point-H PMC
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Region 0: Memory at dd42c000 (32-bit, non-prefetchable) [size=16K]

00:1f.3 Audio device: Intel Corporation Sunrise Point-H HD Audio (rev 31)
    Subsystem: ASUSTeK Computer Inc. Sunrise Point-H HD Audio
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 32
    Interrupt: pin A routed to IRQ 136
    Region 0: Memory at dd428000 (64-bit, non-prefetchable) [size=16K]
    Region 4: Memory at dd400000 (64-bit, non-prefetchable) [size=64K]
    Capabilities: [50] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Address: 00000000fee00418  Data: 0000
    Kernel driver in use: snd_hda_intel
    Kernel modules: snd_hda_intel

00:1f.4 SMBus: Intel Corporation Sunrise Point-H SMBus (rev 31)
    Subsystem: ASUSTeK Computer Inc. Sunrise Point-H SMBus
    Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Interrupt: pin A routed to IRQ 11
    Region 0: Memory at dd432000 (64-bit, non-prefetchable) [size=256]
    Region 4: I/O ports at f040 [size=32]
    Kernel modules: i2c_i801

01:00.0 3D controller: NVIDIA Corporation GM107M [GeForce GTX 960M] (rev a2)
    Subsystem: ASUSTeK Computer Inc. GM107M [GeForce GTX 960M]
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 16
    Region 0: Memory at dc000000 (32-bit, non-prefetchable) [size=16M]
    Region 1: Memory at b0000000 (64-bit, prefetchable) [size=256M]
    Region 3: Memory at c0000000 (64-bit, prefetchable) [size=32M]
    Region 5: I/O ports at e000 [size=128]
    Expansion ROM at dd000000 [disabled] [size=512K]
    Capabilities: [60] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [68] MSI: Enable- Count=1/1 Maskable- 64bit+
        Address: 0000000000000000  Data: 0000
    Capabilities: [78] Express (v2) Endpoint, MSI 00
        DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s
unlimited, L1 <64us
            ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
        DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
            MaxPayload 128 bytes, MaxReadReq 512 bytes
        DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
        LnkCap: Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit
Latency L0s <1us, L1 <4us
            ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
        LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta: Speed 8GT/s, Width x8, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
        DevCap2: Completion Timeout: Range AB, TimeoutDis+, LTR+, OBFF
Via message
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+,
OBFF Disabled
        LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete+, EqualizationPhase1+
             EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest-
    Capabilities: [100 v1] Virtual Channel
        Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
        Arb:    Fixed- WRR32- WRR64- WRR128-
        Ctrl:   ArbSelect=Fixed
        Status: InProgress-
        VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
            Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
            Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
            Status: NegoPending- InProgress-
    Capabilities: [250 v1] Latency Tolerance Reporting
        Max snoop latency: 71680ns
        Max no snoop latency: 71680ns
    Capabilities: [258 v1] L1 PM Substates
        L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
L1_PM_Substates+
              PortCommonModeRestoreTime=255us PortTPowerOnTime=10us
    Capabilities: [128 v1] Power Budgeting <?>
    Capabilities: [600 v1] Vendor Specific Information: ID=0001 Rev=1
Len=024 <?>
    Capabilities: [900 v1] #19
    Kernel driver in use: nvidia
    Kernel modules: nvidiafb, nouveau, nvidia_367, nvidia_367_drm

02:00.0 Unassigned class [ff00]: Alcor Micro Device 6621
    Subsystem: Alcor Micro Device 6621
    Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 11
    Region 0: Memory at dd300000 (64-bit, non-prefetchable) [disabled]
[size=256]
    Capabilities: [40] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
        Address: 0000000000000000  Data: 0000
    Capabilities: [80] Express (v2) Endpoint, MSI 00
        DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
unlimited, L1 unlimited
            ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
        DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
            MaxPayload 128 bytes, MaxReadReq 512 bytes
        DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
        LnkCap: Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s <4us, L1 unlimited
            ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
        LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
            ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
        LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
        DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR+,
OBFF Via message/WAKE#
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+,
OBFF Disabled
        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
    Capabilities: [100 v1] Latency Tolerance Reporting
        Max snoop latency: 3145728ns
        Max no snoop latency: 3145728ns

03:00.0 Network controller: Intel Corporation Wireless 7265 (rev 59)
    Subsystem: Intel Corporation Dual Band Wireless-AC 7265
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 135
    Region 0: Memory at dd200000 (64-bit, non-prefetchable) [size=8K]
    Capabilities: [c8] Power Management version 3
        Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Address: 00000000fee003f8  Data: 0000
    Capabilities: [40] Express (v2) Endpoint, MSI 00
        DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns,
L1 unlimited
            ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
        DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+ FLReset-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
        LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L1, Exit
Latency L0s <4us, L1 <32us
            ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
        LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
            ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
        LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
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
        UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
        CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
        CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
        AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
    Capabilities: [140 v1] Device Serial Number 10-02-b5-ff-ff-ac-37-d5
    Capabilities: [14c v1] Latency Tolerance Reporting
        Max snoop latency: 3145728ns
        Max no snoop latency: 3145728ns
    Capabilities: [154 v1] L1 PM Substates
        L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
L1_PM_Substates+
              PortCommonModeRestoreTime=30us PortTPowerOnTime=60us
    Kernel driver in use: iwlwifi
    Kernel modules: iwlwifi

3d:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd
NVMe SSD Controller (rev 01) (prog-if 02 [NVM Express])
    Subsystem: Samsung Electronics Co Ltd NVMe SSD Controller
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 16
    Region 0: Memory at dd100000 (64-bit, non-prefetchable) [size=16K]
    Region 2: I/O ports at d000 [size=256]
    Capabilities: [40] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [50] MSI: Enable- Count=1/8 Maskable- 64bit+
        Address: 0000000000000000  Data: 0000
    Capabilities: [70] Express (v2) Endpoint, MSI 00
        DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
unlimited, L1 unlimited
            ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
        DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
            RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
            MaxPayload 128 bytes, MaxReadReq 512 bytes
        DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
        LnkCap: Port #0, Speed 8GT/s, Width x4, ASPM L1, Exit Latency
L0s <4us, L1 <64us
            ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
        LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
            ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
        LnkSta: Speed 8GT/s, Width x4, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
        DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR+,
OBFF Not Supported
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+,
OBFF Disabled
        LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete+, EqualizationPhase1+
             EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest-
    Capabilities: [b0] MSI-X: Enable+ Count=9 Masked-
        Vector table: BAR=0 offset=00003000
        PBA: BAR=0 offset=00002000
    Capabilities: [100 v2] Advanced Error Reporting
        UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
        CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
        CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
        AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
    Capabilities: [148 v1] Device Serial Number 00-00-00-00-00-00-00-00
    Capabilities: [158 v1] Power Budgeting <?>
    Capabilities: [168 v1] #19
    Capabilities: [188 v1] Latency Tolerance Reporting
        Max snoop latency: 3145728ns
        Max no snoop latency: 3145728ns
    Capabilities: [190 v1] L1 PM Substates
        L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
L1_PM_Substates+
              PortCommonModeRestoreTime=10us PortTPowerOnTime=10us
    Kernel driver in use: nvme
    Kernel modules: nvme


[7.6.] SCSI information (from /proc/scsi/scsi)
% cat /proc/scsi/scsi
cat: /proc/scsi/scsi: Aucun fichier ou dossier de ce type

[7.7.] Other information that might be relevant to the problem (please
look in /proc and include all information that you think to be
relevant):
don't know
n/a

[X.] Other notes, patches, fixes, workarounds:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1623172
