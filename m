From: Clayton Craft <craftyguy@gmail.com>
Subject: PROBLEM: Touchpad reported as: "elantech: unknown hardware version,
 aborting" -- missing multitouch and scrolling
Date: Wed, 2 Oct 2013 19:42:03 -0700
Message-ID: <CAPf8-qF5afwQ97FLD8NJ4Zk12MzUTzdLtwyyvLZ+8FkgNukgAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:61633 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753001Ab3JCCmo (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Oct 2013 22:42:44 -0400
Received: by mail-ie0-f179.google.com with SMTP id e14so4047104iej.38
        for <linux-input@vger.kernel.org>; Wed, 02 Oct 2013 19:42:43 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Clayton Craft <craftyguy@gmail.com>

[1.] One line summary of the problem:

Touchpad is missing multitouch and scrolling

[2.] Full description of the problem/report:

Only basic functionality (right/left click, moving pointer) work.
Expectation is that the device would be detected as a touchpad with
support for multitouch/scrolling/etc. The laptop is an Acer S7 392.
The following  message is printed to the kernel log:
[   12.464107] psmouse serio1: elantech: unknown hardware version, aborting...

The bug was originally files here, and I was instructed to notify the
maintainers: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1232877


[3.] Keywords (i.e., modules, networking, kernel):

elantech, touchpad

[4.] Kernel version (from /proc/version):

clayton@ultrabook:~$ cat /proc/version
Linux version 3.12.0-031200rc3-generic (apw@gomeisa) (gcc version
4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201309291835 SMP Sun Sep 29
22:37:02 UTC 2013

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

n/a

[6.] A small shell script or example program which triggers the
     problem (if possible)

n/a

[7.] Environment

[7.1.] Software (add the output of the ver_linux script here)

clayton@ultrabook:~$ /usr/src/linux-headers-3.12.0-031200rc3/scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux ultrabook 3.12.0-031200rc3-generic #201309291835 SMP Sun Sep 29
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
Modules Loaded         x86_pkg_temp_thermal coretemp kvm_intel kvm
joydev arc4 acer_wmi sparse_keymap dm_multipath scsi_dh iwlmvm
mac80211 parport_pc ppdev microcode psmouse iwlwifi serio_raw
hid_multitouch uvcvideo videobuf2_vmalloc videobuf2_memops
snd_hda_codec_realtek videobuf2_core snd_hda_codec_hdmi videodev bnep
rfcomm btusb cfg80211 snd_hda_intel bluetooth snd_hda_codec snd_hwdep
snd_pcm snd_page_alloc snd_seq_midi snd_seq_midi_event snd_rawmidi
snd_seq snd_seq_device snd_timer i2c_designware_platform
i2c_designware_core snd intel_smartconnect lpc_ich mac_hid tpm_tis
mei_me mei soundcore binfmt_misc nls_iso8859_1 lp parport ext2 usbhid
hid dm_crypt dm_mirror dm_region_hash dm_log crct10dif_pclmul
crc32_pclmul ghash_clmulni_intel aesni_intel aes_x86_64 lrw gf128mul
i915 glue_helper ablk_helper cryptd ahci libahci i2c_algo_bit
drm_kms_helper drm wmi video


[7.2.] Processor information (from /proc/cpuinfo):

clayton@ultrabook:~$ cat /proc/cpuinfo
processor : 0
vendor_id : GenuineIntel
cpu family : 6
model : 69
model name : Intel(R) Core(TM) i5-4200U CPU @ 1.60GHz
stepping : 1
microcode : 0x10
cpu MHz : 2507.000
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
arat epb xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid
fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid
bogomips : 4588.31
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
microcode : 0x10
cpu MHz : 2484.000
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
arat epb xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid
fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid
bogomips : 4588.31
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
microcode : 0x10
cpu MHz : 2530.000
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
arat epb xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid
fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid
bogomips : 4588.31
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
microcode : 0x10
cpu MHz : 2438.000
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
arat epb xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid
fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid
bogomips : 4588.31
clflush size : 64
cache_alignment : 64
address sizes : 39 bits physical, 48 bits virtual
power management:



[7.3.] Module information (from /proc/modules):


clayton@ultrabook:~$ cat /proc/modules
x86_pkg_temp_thermal 14269 0 - Live 0x0000000000000000
coretemp 17728 0 - Live 0x0000000000000000
kvm_intel 144049 0 - Live 0x0000000000000000
kvm 457676 1 kvm_intel, Live 0x0000000000000000
joydev 17575 0 - Live 0x0000000000000000
arc4 12573 2 - Live 0x0000000000000000
acer_wmi 32938 0 - Live 0x0000000000000000
sparse_keymap 13890 1 acer_wmi, Live 0x0000000000000000
dm_multipath 27371 0 - Live 0x0000000000000000
scsi_dh 14873 1 dm_multipath, Live 0x0000000000000000
iwlmvm 176559 0 - Live 0x0000000000000000
mac80211 634661 1 iwlmvm, Live 0x0000000000000000
parport_pc 32866 0 - Live 0x0000000000000000
ppdev 17711 0 - Live 0x0000000000000000
microcode 23650 0 - Live 0x0000000000000000
psmouse 104113 0 - Live 0x0000000000000000
iwlwifi 171124 1 iwlmvm, Live 0x0000000000000000
serio_raw 13462 0 - Live 0x0000000000000000
hid_multitouch 17645 0 - Live 0x0000000000000000
uvcvideo 82247 0 - Live 0x0000000000000000
videobuf2_vmalloc 13216 1 uvcvideo, Live 0x0000000000000000
videobuf2_memops 13362 1 videobuf2_vmalloc, Live 0x0000000000000000
snd_hda_codec_realtek 56695 1 - Live 0x0000000000000000
videobuf2_core 40903 1 uvcvideo, Live 0x0000000000000000
snd_hda_codec_hdmi 41684 1 - Live 0x0000000000000000
videodev 139144 2 uvcvideo,videobuf2_core, Live 0x0000000000000000
bnep 23966 2 - Live 0x0000000000000000
rfcomm 74658 12 - Live 0x0000000000000000
btusb 28326 0 - Live 0x0000000000000000
cfg80211 504229 3 iwlmvm,mac80211,iwlwifi, Live 0x0000000000000000
snd_hda_intel 57183 5 - Live 0x0000000000000000
bluetooth 391597 22 bnep,rfcomm,btusb, Live 0x0000000000000000
snd_hda_codec 194881 3
snd_hda_codec_realtek,snd_hda_codec_hdmi,snd_hda_intel, Live
0x0000000000000000
snd_hwdep 13613 1 snd_hda_codec, Live 0x0000000000000000
snd_pcm 107140 3 snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec, Live
0x0000000000000000
snd_page_alloc 18798 2 snd_hda_intel,snd_pcm, Live 0x0000000000000000
snd_seq_midi 13324 0 - Live 0x0000000000000000
snd_seq_midi_event 14899 1 snd_seq_midi, Live 0x0000000000000000
snd_rawmidi 30465 1 snd_seq_midi, Live 0x0000000000000000
snd_seq 66061 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x0000000000000000
snd_timer 30038 2 snd_pcm,snd_seq, Live 0x0000000000000000
i2c_designware_platform 13006 0 - Live 0x0000000000000000
i2c_designware_core 14990 1 i2c_designware_platform, Live 0x0000000000000000
snd 73802 21 snd_hda_codec_realtek,snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_seq_midi,snd_rawmidi,snd_seq,snd_seq_device,snd_timer,
Live 0x0000000000000000
intel_smartconnect 12619 0 - Live 0x0000000000000000
lpc_ich 21163 0 - Live 0x0000000000000000
mac_hid 13253 0 - Live 0x0000000000000000
tpm_tis 19116 0 - Live 0x0000000000000000
mei_me 18418 0 - Live 0x0000000000000000
mei 78609 1 mei_me, Live 0x0000000000000000
soundcore 12680 1 snd, Live 0x0000000000000000
binfmt_misc 17508 1 - Live 0x0000000000000000
nls_iso8859_1 12713 1 - Live 0x0000000000000000
lp 17799 0 - Live 0x0000000000000000
parport 42481 3 parport_pc,ppdev,lp, Live 0x0000000000000000
ext2 73684 1 - Live 0x0000000000000000
usbhid 53067 0 - Live 0x0000000000000000
hid 106254 2 hid_multitouch,usbhid, Live 0x0000000000000000
dm_crypt 23012 1 - Live 0x0000000000000000
dm_mirror 22326 0 - Live 0x0000000000000000
dm_region_hash 20981 1 dm_mirror, Live 0x0000000000000000
dm_log 18527 2 dm_mirror,dm_region_hash, Live 0x0000000000000000
crct10dif_pclmul 14250 0 - Live 0x0000000000000000
crc32_pclmul 13160 0 - Live 0x0000000000000000
ghash_clmulni_intel 13259 0 - Live 0x0000000000000000
aesni_intel 55720 4 - Live 0x0000000000000000
aes_x86_64 17131 1 aesni_intel, Live 0x0000000000000000
lrw 13294 1 aesni_intel, Live 0x0000000000000000
gf128mul 14951 1 lrw, Live 0x0000000000000000
i915 733800 5 - Live 0x0000000000000000
glue_helper 14095 1 aesni_intel, Live 0x0000000000000000
ablk_helper 13597 1 aesni_intel, Live 0x0000000000000000
cryptd 20501 4 ghash_clmulni_intel,aesni_intel,ablk_helper, Live
0x0000000000000000
ahci 30063 2 - Live 0x0000000000000000
libahci 32088 1 ahci, Live 0x0000000000000000
i2c_algo_bit 13564 1 i915, Live 0x0000000000000000
drm_kms_helper 53165 1 i915, Live 0x0000000000000000
drm 303133 4 i915,drm_kms_helper, Live 0x0000000000000000
wmi 19363 1 acer_wmi, Live 0x0000000000000000
video 19574 2 acer_wmi,i915, Live 0x0000000000000000



[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

clayton@ultrabook:~$ cat /proc/ioports
0000-0cf7 : PCI Bus 0000:00
  0000-001f : dma1
  0020-0021 : pic1
  0040-0043 : timer0
  0050-0053 : timer1
  0060-0060 : keyboard
  0062-0062 : EC data
  0064-0064 : keyboard
  0066-0066 : EC cmd
  0070-0071 : rtc_cmos
    0070-0071 : rtc0
  0080-008f : dma page reg
  00a0-00a1 : pic2
  00c0-00df : dma2
  00f0-00ff : fpu
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
  1800-1803 : ACPI PM1a_EVT_BLK
  1804-1805 : ACPI PM1a_CNT_BLK
  1808-180b : ACPI PM_TMR
  1810-1815 : ACPI CPU throttle
  1830-1833 : iTCO_wdt
  1850-1850 : ACPI PM2_CNT_BLK
  1860-187f : iTCO_wdt
  1880-189f : ACPI GPE0_BLK
  2000-2fff : PCI Bus 0000:01
  3000-303f : 0000:00:02.0
  3040-305f : 0000:00:1f.3
  3060-307f : 0000:00:1f.2
    3060-307f : ahci
  3080-3087 : 0000:00:1f.2
    3080-3087 : ahci
  3088-308f : 0000:00:1f.2
    3088-308f : ahci
  3090-3093 : 0000:00:1f.2
    3090-3093 : ahci
  3094-3097 : 0000:00:1f.2
    3094-3097 : ahci
clayton@ultrabook:~$ cat /proc/iomem
00000000-00000fff : reserved
00001000-0006efff : System RAM
0006f000-0006ffff : reserved
00070000-00087fff : System RAM
00088000-000bffff : reserved
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
00100000-8c6befff : System RAM
  02000000-02762924 : Kernel code
  02762925-02d18c7f : Kernel data
  02e72000-02fe4fff : Kernel bss
  2c000000-33ffffff : Crash kernel
8c6bf000-8cebefff : reserved
8cebf000-8cfbefff : ACPI Non-volatile Storage
8cfbf000-8cffefff : ACPI Tables
8cfff000-8cffffff : System RAM
8d000000-9f9fffff : reserved
  97a00000-9f9fffff : Graphics Stolen Memory
9fa00000-feafffff : PCI Bus 0000:00
  9fa10000-9fa10fff : pnp 00:02
  9fb00000-9fcfffff : PCI Bus 0000:01
  a0000000-afffffff : 0000:00:02.0
  b0000000-b03fffff : 0000:00:02.0
  b0400000-b04fffff : PCI Bus 0000:01
    b0400000-b0401fff : 0000:01:00.0
      b0400000-b0401fff : iwlwifi
  b0500000-b050ffff : 0000:00:14.0
    b0500000-b050ffff : xhci_hcd
  b0510000-b0513fff : 0000:00:03.0
    b0510000-b0513fff : ICH HD audio
  b0514000-b0517fff : 0000:00:1b.0
    b0514000-b0517fff : ICH HD audio
  b0519000-b0519007 : pnp 00:03
  b0519014-b0519fff : pnp 00:03
  b051a000-b051a01f : 0000:00:16.0
    b051a000-b051a01f : mei_me
  b051b000-b051b0ff : 0000:00:1f.3
  b051d000-b051d7ff : 0000:00:1f.2
    b051d000-b051d7ff : ahci
  b051e000-b051e3ff : 0000:00:1d.0
    b051e000-b051e3ff : ehci_hcd
  b051f000-b051ffff : pnp 00:03
  e0000000-efffffff : PCI MMCONFIG 0000 [bus 00-ff]
    e0000000-efffffff : reserved
      e0000000-efffffff : pnp 00:02
  fe101000-fe112fff : reserved
    fe105000-fe105fff : INT33C3:00
      fe105000-fe105fff : INT33C3:00
    fe106000-fe106fff : pnp 00:03
feb00000-feb0ffff : reserved
fec00000-fec00fff : reserved
  fec00000-fec003ff : IOAPIC 0
fed00000-fee00fff : reserved
  fed00000-fed003ff : HPET 0
  fed10000-fed17fff : pnp 00:02
  fed18000-fed18fff : pnp 00:02
  fed19000-fed19fff : pnp 00:02
  fed1c000-fed1ffff : pnp 00:02
    fed1f410-fed1f414 : iTCO_wdt
  fed20000-fed3ffff : pnp 00:02
  fed90000-fed93fff : pnp 00:02
  fee00000-fee00fff : Local APIC
ffc00000-ffffffff : reserved
100000000-25f5fffff : System RAM
25f600000-25fffffff : RAM buffer


[7.5.] PCI information ('lspci -vvv' as root)


00:00.0 Host bridge: Intel Corporation Haswell-ULT DRAM Controller (rev 09)
Subsystem: Acer Incorporated [ALI] Device 0817
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR- INTx-
Latency: 0
Capabilities: <access denied>

00:02.0 VGA compatible controller: Intel Corporation Haswell-ULT
Integrated Graphics Controller (rev 09) (prog-if 00 [VGA controller])
Subsystem: Acer Incorporated [ALI] Device 0817
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 59
Region 0: Memory at b0000000 (64-bit, non-prefetchable) [size=4M]
Region 2: Memory at a0000000 (64-bit, prefetchable) [size=256M]
Region 4: I/O ports at 3000 [size=64]
Expansion ROM at <unassigned> [disabled]
Capabilities: <access denied>
Kernel driver in use: i915

00:03.0 Audio device: Intel Corporation Device 0a0c (rev 09)
Subsystem: Acer Incorporated [ALI] Device 0817
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 60
Region 0: Memory at b0510000 (64-bit, non-prefetchable) [size=16K]
Capabilities: <access denied>
Kernel driver in use: snd_hda_intel

00:14.0 USB controller: Intel Corporation Lynx Point-LP USB xHCI HC
(rev 04) (prog-if 30 [XHCI])
Subsystem: Acer Incorporated [ALI] Device 0817
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 62
Region 0: Memory at b0500000 (64-bit, non-prefetchable) [size=64K]
Capabilities: <access denied>
Kernel driver in use: xhci_hcd

00:16.0 Communication controller: Intel Corporation Lynx Point-LP HECI
#0 (rev 04)
Subsystem: Acer Incorporated [ALI] Device 0817
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 61
Region 0: Memory at b051a000 (64-bit, non-prefetchable) [size=32]
Capabilities: <access denied>
Kernel driver in use: mei_me

00:1b.0 Audio device: Intel Corporation Lynx Point-LP HD Audio
Controller (rev 04)
Subsystem: Acer Incorporated [ALI] Device 0817
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 57
Region 0: Memory at b0514000 (64-bit, non-prefetchable) [size=16K]
Capabilities: <access denied>
Kernel driver in use: snd_hda_intel

00:1c.0 PCI bridge: Intel Corporation Lynx Point-LP PCI Express Root
Port 3 (rev e4) (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
I/O behind bridge: 0000f000-00000fff
Memory behind bridge: b0400000-b04fffff
Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: <access denied>
Kernel driver in use: pcieport

00:1d.0 USB controller: Intel Corporation Lynx Point-LP USB EHCI #1
(rev 04) (prog-if 20 [EHCI])
Subsystem: Acer Incorporated [ALI] Device 0817
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 23
Region 0: Memory at b051e000 (32-bit, non-prefetchable) [size=1K]
Capabilities: <access denied>
Kernel driver in use: ehci-pci

00:1f.0 ISA bridge: Intel Corporation Lynx Point-LP LPC Controller (rev 04)
Subsystem: Acer Incorporated [ALI] Device 0817
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Capabilities: <access denied>
Kernel driver in use: lpc_ich

00:1f.2 RAID bus controller: Intel Corporation 82801 Mobile SATA
Controller [RAID mode] (rev 04)
Subsystem: Acer Incorporated [ALI] Device 0817
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin B routed to IRQ 58
Region 0: I/O ports at 3088 [size=8]
Region 1: I/O ports at 3094 [size=4]
Region 2: I/O ports at 3080 [size=8]
Region 3: I/O ports at 3090 [size=4]
Region 4: I/O ports at 3060 [size=32]
Region 5: Memory at b051d000 (32-bit, non-prefetchable) [size=2K]
Capabilities: <access denied>
Kernel driver in use: ahci

00:1f.3 SMBus: Intel Corporation Lynx Point-LP SMBus Controller (rev 04)
Subsystem: Acer Incorporated [ALI] Device 0817
Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Interrupt: pin C routed to IRQ 0
Region 0: Memory at b051b000 (64-bit, non-prefetchable) [size=256]
Region 4: I/O ports at 3040 [size=32]

01:00.0 Network controller: Intel Corporation Wireless 7260 (rev 6b)
Subsystem: Intel Corporation Dual Band Wireless-N 7260
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 63
Region 0: Memory at b0400000 (64-bit, non-prefetchable) [size=8K]
Capabilities: <access denied>
Kernel driver in use: iwlwifi



[7.6.] SCSI information (from /proc/scsi/scsi)

clayton@ultrabook:~$ cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: KINGSTON SMSR150 Rev: S8FM
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: KINGSTON SMSR150 Rev: S8FM
  Type:   Direct-Access                    ANSI  SCSI revision: 05


[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

clayton@ultrabook:~$ sudo lsusb -vvv -d 04f3:015b
[sudo] password for clayton:

Bus 002 Device 004: ID 04f3:015b Elan Microelectronics Corp.
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x04f3 Elan Microelectronics Corp.
  idProduct          0x015b
  bcdDevice            0.11
  iManufacturer           4 ELAN
  iProduct               14 Touchscreen
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           41
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      0 No Subclass
      bInterfaceProtocol      0 None
      iInterface              0
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.10
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength     925
         Report Descriptors:
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0020  1x 32 bytes
        bInterval              10
Device Status:     0x0001
  Self Powered



[X.] Other notes, patches, fixes, workarounds:
<None>
