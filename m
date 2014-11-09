From: Adam Chrimes <af.chrimes@gmail.com>
Subject: [Gigabyte M1405] Touchpad not detected
Date: Sun, 9 Nov 2014 11:33:01 +1100
Message-ID: <CAJcw1jb0d0GXHRzgJe68_ek5tPPrzYczXZPx_jCPFWzqAkq9HA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:44269 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752682AbaKIAdD (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 8 Nov 2014 19:33:03 -0500
Received: by mail-ob0-f182.google.com with SMTP id nt9so4625904obb.13
        for <linux-input@vger.kernel.org>; Sat, 08 Nov 2014 16:33:01 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

[1.] One line summary of the problem:
[Gigabyte M1405] Touchpad not detected

[2.] Full description of the problem/report:
The touchpad does not appear in the list when I run "cat
/proc/bus/input/devices". The touchpad and its buttons are
unresponsive. This is a brand new installation of XBMCbuntu.

[3.] Keywords (i.e., modules, networking, kernel):

[4.] Kernel version (from /proc/version):
Linux version 3.18.0-031800rc3-generic (apw@tangerine) (gcc version
4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201411022335 SMP Sun Nov 2
23:36:52 UTC 2014

[5.] Output of Oops.. message (if applicable) with symbolic
information resolved (see Documentation/oops-tracing.txt)
N/A

[6.] A small shell script or example program which triggers the
problem (if possible)
N/A

[7.] Environment
Description:    Ubuntu 14.04.1 LTS
Release:        14.04

[7.1.] Software (add the output of the ver_linux script here)
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux redServer 3.18.0-031800rc3-generic #201411022335 SMP Sun Nov 2
23:36:52 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux

Gnu C                  4.8
Gnu make               3.81
binutils               2.24
util-linux             2.20.1
mount                  support
module-init-tools      15
e2fsprogs              1.42.9
PPP                    2.4.5
Linux C Library        2.19
Dynamic linker (ldd)   2.19
Procps                 3.3.9
Net-tools              1.60
Kbd                    1.15.5
Sh-utils               8.21
wireless-tools         30
Modules Loaded         ctr ccm lirc_dev rc_core autofs4 gpio_ich
sparse_keymap dm_multipath scsi_dh kvm_intel kvm snd_hda_codec_hdmi
snd_hda_codec_realtek snd_hda_codec_generic arc4 snd_hda_intel ath9k
ath9k_common snd_hda_controller ath9k_hw snd_hda_codec ath joydev
snd_hwdep mac80211 snd_pcm snd_seq_midi snd_seq_midi_event cfg80211
snd_rawmidi snd_seq snd_seq_device snd_timer serio_raw snd soundcore
lpc_ich wmi nfsd mac_hid auth_rpcgss nfs_acl nfs lp lockd grace
parport sunrpc coretemp fscache btrfs xor raid6_pq dm_mirror
dm_region_hash dm_log ums_realtek uas usb_storage hid_generic usbhid
hid ahci libahci i915 r8169 mii i2c_algo_bit drm_kms_helper video drm

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 23
model name      : Genuine Intel(R) CPU           U7300  @ 1.30GHz
stepping        : 10
microcode       : 0xa07
cpu MHz         : 1066.000
cache size      : 3072 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 2
apicid          : 0
initial apicid  : 0
fpu             : yes
fpu_exception   : yes
cpuid level     : 13
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx lm constant_tsc arch_perfmon pebs bts rep_good nopl
aperfmperf pni dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm
sse4_1 xsave lahf_lm dtherm tpr_shadow vnmi flexpriority
bugs            :
bogomips        : 3466.60
clflush size    : 64
cache_alignment : 64
address sizes   : 36 bits physical, 48 bits virtual
power management:

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 23
model name      : Genuine Intel(R) CPU           U7300  @ 1.30GHz
stepping        : 10
microcode       : 0xa07
cpu MHz         : 1066.000
cache size      : 3072 KB
physical id     : 0
siblings        : 2
core id         : 1
cpu cores       : 2
apicid          : 1
initial apicid  : 1
fpu             : yes
fpu_exception   : yes
cpuid level     : 13
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx lm constant_tsc arch_perfmon pebs bts rep_good nopl
aperfmperf pni dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm
sse4_1 xsave lahf_lm dtherm tpr_shadow vnmi flexpriority
bugs            :
bogomips        : 3466.60
clflush size    : 64
cache_alignment : 64
address sizes   : 36 bits physical, 48 bits virtual
power management:

[7.3.] Module information (from /proc/modules):
ctr 13193 2 - Live 0x0000000000000000
ccm 17856 2 - Live 0x0000000000000000
lirc_dev 20018 0 - Live 0x0000000000000000
rc_core 27515 1 lirc_dev, Live 0x0000000000000000
autofs4 39306 1 - Live 0x0000000000000000
gpio_ich 13636 0 - Live 0x0000000000000000
sparse_keymap 13890 0 - Live 0x0000000000000000
dm_multipath 23188 0 - Live 0x0000000000000000
scsi_dh 14873 1 dm_multipath, Live 0x0000000000000000
kvm_intel 149984 0 - Live 0x0000000000000000
kvm 475233 1 kvm_intel, Live 0x0000000000000000
snd_hda_codec_hdmi 52670 1 - Live 0x0000000000000000
snd_hda_codec_realtek 76099 1 - Live 0x0000000000000000
snd_hda_codec_generic 69995 1 snd_hda_codec_realtek, Live 0x0000000000000000
arc4 12573 2 - Live 0x0000000000000000
snd_hda_intel 30783 0 - Live 0x0000000000000000
ath9k 162133 0 - Live 0x0000000000000000
ath9k_common 25638 1 ath9k, Live 0x0000000000000000
snd_hda_controller 32234 1 snd_hda_intel, Live 0x0000000000000000
ath9k_hw 460416 2 ath9k,ath9k_common, Live 0x0000000000000000
snd_hda_codec 144641 5
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_controller,
Live 0x0000000000000000
ath 29397 3 ath9k,ath9k_common,ath9k_hw, Live 0x0000000000000000
joydev 17587 0 - Live 0x0000000000000000
snd_hwdep 17709 1 snd_hda_codec, Live 0x0000000000000000
mac80211 697143 1 ath9k, Live 0x0000000000000000
snd_pcm 106273 4
snd_hda_codec_hdmi,snd_hda_intel,snd_hda_controller,snd_hda_codec,
Live 0x0000000000000000
snd_seq_midi 13564 0 - Live 0x0000000000000000
snd_seq_midi_event 14899 1 snd_seq_midi, Live 0x0000000000000000
cfg80211 520257 4 ath9k,ath9k_common,ath,mac80211, Live 0x0000000000000000
snd_rawmidi 31197 1 snd_seq_midi, Live 0x0000000000000000
snd_seq 63540 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x0000000000000000
snd_timer 30118 2 snd_pcm,snd_seq, Live 0x0000000000000000
serio_raw 13483 0 - Live 0x0000000000000000
snd 84025 11 snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_seq_device,snd_timer,
Live 0x0000000000000000
soundcore 15091 2 snd_hda_codec,snd, Live 0x0000000000000000
lpc_ich 21176 0 - Live 0x0000000000000000
wmi 19379 0 - Live 0x0000000000000000
nfsd 302377 2 - Live 0x0000000000000000
mac_hid 13275 0 - Live 0x0000000000000000
auth_rpcgss 60078 1 nfsd, Live 0x0000000000000000
nfs_acl 12883 1 nfsd, Live 0x0000000000000000
nfs 249589 0 - Live 0x0000000000000000
lp 17799 0 - Live 0x0000000000000000
lockd 94786 2 nfsd,nfs, Live 0x0000000000000000
grace 13295 2 nfsd,lockd, Live 0x0000000000000000
parport 42481 1 lp, Live 0x0000000000000000
sunrpc 302693 6 nfsd,auth_rpcgss,nfs_acl,nfs,lockd, Live 0x0000000000000000
coretemp 13638 0 - Live 0x0000000000000000
fscache 64236 1 nfs, Live 0x0000000000000000
btrfs 945983 0 - Live 0x0000000000000000
xor 21411 1 btrfs, Live 0x0000000000000000
raid6_pq 97812 1 btrfs, Live 0x0000000000000000
dm_mirror 22356 0 - Live 0x0000000000000000
dm_region_hash 21010 1 dm_mirror, Live 0x0000000000000000
dm_log 18527 2 dm_mirror,dm_region_hash, Live 0x0000000000000000
ums_realtek 18352 0 - Live 0x0000000000000000
uas 22673 0 - Live 0x0000000000000000
usb_storage 67010 5 ums_realtek,uas, Live 0x0000000000000000
hid_generic 12559 0 - Live 0x0000000000000000
usbhid 53155 0 - Live 0x0000000000000000
hid 110572 2 hid_generic,usbhid, Live 0x0000000000000000
ahci 34220 2 - Live 0x0000000000000000
libahci 32446 1 ahci, Live 0x0000000000000000
i915 1031913 4 - Live 0x0000000000000000
r8169 86907 0 - Live 0x0000000000000000
mii 13981 1 r8169, Live 0x0000000000000000
i2c_algo_bit 13564 1 i915, Live 0x0000000000000000
drm_kms_helper 99802 1 i915, Live 0x0000000000000000
video 20649 1 i915, Live 0x0000000000000000
drm 323675 6 i915,drm_kms_helper, Live 0x0000000000000000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
adam@redServer:/$ cat /proc/ioports
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
  03c0-03df : vesafb
  0400-0403 : ACPI PM1a_EVT_BLK
  0404-0405 : ACPI PM1a_CNT_BLK
  0408-040b : ACPI PM_TMR
  0410-0415 : ACPI CPU throttle
  0420-042f : ACPI GPE0_BLK
  0430-0433 : iTCO_wdt
  0450-0450 : ACPI PM2_CNT_BLK
  0460-047f : iTCO_wdt
  0500-053f : gpio_ich
    0500-053f : pnp 00:00
      0500-052f : gpio_ich
  0600-060f : pnp 00:00
  0610-0610 : pnp 00:00
  0800-080f : pnp 00:00
  0810-0817 : pnp 00:00
  0820-0823 : pnp 00:00
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
  164e-164f : pnp 00:00
  2000-2fff : PCI Bus 0000:07
  3000-3fff : PCI Bus 0000:04
    3000-30ff : 0000:04:00.0
      3000-30ff : r8169
  4000-4fff : PCI Bus 0000:01
  5000-501f : 0000:00:1f.3
  5020-503f : 0000:00:1f.2
    5020-503f : ahci
  5040-505f : 0000:00:1d.3
    5040-505f : uhci_hcd
  5060-507f : 0000:00:1d.2
    5060-507f : uhci_hcd
  5080-509f : 0000:00:1d.1
    5080-509f : uhci_hcd
  50a0-50bf : 0000:00:1d.0
    50a0-50bf : uhci_hcd
  50c0-50df : 0000:00:1a.1
    50c0-50df : uhci_hcd
  50e0-50ff : 0000:00:1a.0
    50e0-50ff : uhci_hcd
  5100-5107 : 0000:00:1f.2
    5100-5107 : ahci
  5108-510f : 0000:00:1f.2
    5108-510f : ahci
  5110-5117 : 0000:00:02.0
  5118-511b : 0000:00:1f.2
    5118-511b : ahci
  511c-511f : 0000:00:1f.2
    511c-511f : ahci

adam@redServer:/$ cat /proc/iomem
00000000-00000fff : reserved
00001000-0009dfff : System RAM
0009e000-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000c7fff : Video ROM
000e0000-000fffff : reserved
  000f0000-000fffff : System ROM
00100000-b9f00fff : System RAM
  01000000-017ae357 : Kernel code
  017ae358-01d1997f : Kernel data
  01e80000-01fc8fff : Kernel bss
b9f01000-b9f3efff : ACPI Non-volatile Storage
b9f3f000-b9f6bfff : System RAM
b9f6c000-b9fbefff : reserved
b9fbf000-b9fe2fff : System RAM
b9fe3000-b9ff6fff : ACPI Tables
b9ff7000-b9ffffff : System RAM
ba000000-bfffffff : reserved
  bc000000-bfffffff : Graphics Stolen Memory
c0000000-febfffff : PCI Bus 0000:00
  c0000000-d1ffffff : PCI Bus 0000:01
  d2000000-d2000fff : Intel Flush Page
  e0000000-efffffff : 0000:00:02.0
  f0000000-f1ffffff : PCI Bus 0000:01
  f2000000-f23fffff : 0000:00:02.0
  f2400000-f33fffff : PCI Bus 0000:04
    f2400000-f2403fff : 0000:04:00.0
      f2400000-f2403fff : r8169
    f2404000-f2404fff : 0000:04:00.0
      f2404000-f2404fff : r8169
  f3400000-f43fffff : PCI Bus 0000:07
  f4400000-f44fffff : 0000:00:02.1
  f4500000-f54fffff : PCI Bus 0000:07
    f4500000-f450ffff : 0000:07:00.0
      f4500000-f450ffff : ath9k
  f5500000-f64fffff : PCI Bus 0000:04
    f5500000-f551ffff : 0000:04:00.0
  f6500000-f6503fff : 0000:00:1b.0
    f6500000-f6503fff : ICH HD audio
  f6504000-f6504fff : 0000:00:1f.6
  f6505000-f65057ff : 0000:00:1f.2
    f6505000-f65057ff : ahci
  f6505800-f6505bff : 0000:00:1d.7
    f6505800-f6505bff : ehci_hcd
  f6505c00-f6505fff : 0000:00:1a.7
    f6505c00-f6505fff : ehci_hcd
  f6506000-f65060ff : 0000:00:1f.3
  f8000000-fbffffff : PCI MMCONFIG 0000 [bus 00-3f]
    f8000000-fbffffff : reserved
fec00000-fec00fff : reserved
  fec00000-fec003ff : IOAPIC 0
fed00000-fed003ff : HPET 0
  fed00000-fed003ff : PNP0103:00
fed10000-fed13fff : reserved
  fed10000-fed13fff : pnp 00:00
fed18000-fed19fff : reserved
  fed18000-fed18fff : pnp 00:00
  fed19000-fed19fff : pnp 00:00
fed1c000-fed1ffff : reserved
  fed1c000-fed1ffff : pnp 00:00
    fed1f410-fed1f414 : iTCO_wdt
fed20000-fed3ffff : pnp 00:00
fed40000-fed44fff : pnp 00:00
fed45000-fed8ffff : pnp 00:00
fee00000-fee00fff : Local APIC
  fee00000-fee00fff : reserved
    fee00000-fee00fff : pnp 00:00
ff800000-ffffffff : INT0800:00
  ffe00000-ffffffff : reserved
100000000-13fffffff : System RAM

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: Intel Corporation Mobile 4 Series Chipset Memory
Controller Hub (rev 07)
        Subsystem: Gigabyte Technology Co., Ltd Device 1405
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR- INTx-
        Latency: 0
        Capabilities: [e0] Vendor Specific Information: Len=0a <?>
        Kernel driver in use: agpgart-intel

00:02.0 VGA compatible controller: Intel Corporation Mobile 4 Series
Chipset Integrated Graphics Controller (rev 07) (prog-if 00 [VGA
controller])
        Subsystem: Gigabyte Technology Co., Ltd Device 1405
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 29
        Region 0: Memory at f2000000 (64-bit, non-prefetchable) [size=4M]
        Region 2: Memory at e0000000 (64-bit, prefetchable) [size=256M]
        Region 4: I/O ports at 5110 [size=8]
        Expansion ROM at <unassigned> [disabled]
        Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
                Address: fee0300c  Data: 41b2
        Capabilities: [d0] Power Management version 3
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: i915

00:02.1 Display controller: Intel Corporation Mobile 4 Series Chipset
Integrated Graphics Controller (rev 07)
        Subsystem: Gigabyte Technology Co., Ltd Device 1405
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Region 0: Memory at f4400000 (64-bit, non-prefetchable) [size=1M]
        Capabilities: [d0] Power Management version 3
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-

00:1a.0 USB controller: Intel Corporation 82801I (ICH9 Family) USB
UHCI Controller #4 (rev 03) (prog-if 00 [UHCI])
        Subsystem: Gigabyte Technology Co., Ltd Device 1405
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 16
        Region 4: I/O ports at 50e0 [size=32]
        Capabilities: [50] PCI Advanced Features
                AFCap: TP+ FLR+
                AFCtrl: FLR-
                AFStatus: TP-
        Kernel driver in use: uhci_hcd

00:1a.1 USB controller: Intel Corporation 82801I (ICH9 Family) USB
UHCI Controller #5 (rev 03) (prog-if 00 [UHCI])
        Subsystem: Gigabyte Technology Co., Ltd Device 1405
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin B routed to IRQ 21
        Region 4: I/O ports at 50c0 [size=32]
        Capabilities: [50] PCI Advanced Features
                AFCap: TP+ FLR+
                AFCtrl: FLR-
                AFStatus: TP-
        Kernel driver in use: uhci_hcd

00:1a.7 USB controller: Intel Corporation 82801I (ICH9 Family) USB2
EHCI Controller #2 (rev 03) (prog-if 20 [EHCI])
        Subsystem: Gigabyte Technology Co., Ltd Device 1405
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin D routed to IRQ 19
        Region 0: Memory at f6505c00 (32-bit, non-prefetchable) [size=1K]
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

00:1b.0 Audio device: Intel Corporation 82801I (ICH9 Family) HD Audio
Controller (rev 03)
        Subsystem: Gigabyte Technology Co., Ltd Device 1405
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 30
        Region 0: Memory at f6500000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
                Address: 00000000fee0300c  Data: 41d2
        Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0
                        ExtTag- RBE-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-
AuxPwr+ TransPend-
        Capabilities: [100 v1] Virtual Channel
                Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                Arb:    Fixed- WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=Fixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=7f
                        Status: NegoPending- InProgress-
                VC1:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable+ ID=1 ArbSelect=Fixed TC/VC=80
                        Status: NegoPending- InProgress-
        Capabilities: [130 v1] Root Complex Link
                Desc:   PortNumber=0f ComponentID=02 EltType=Config
                Link0:  Desc:   TargetPort=00 TargetComponent=02
AssocRCRB- LinkType=MemMapped LinkValid+
                        Addr:   00000000fed1c000
        Kernel driver in use: snd_hda_intel

00:1c.0 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express
Port 1 (rev 03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=00, secondary=01, subordinate=03, sec-latency=0
        I/O behind bridge: 00004000-00004fff
        Memory behind bridge: f0000000-f1ffffff
        Prefetchable memory behind bridge: 00000000c0000000-00000000d1ffffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0
                        ExtTag- RBE+
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-
AuxPwr+ TransPend-
                LnkCap: Port #1, Speed 2.5GT/s, Width x4, ASPM L0s L1,
Exit Latency L0s <1us, L1 <4us
                        ClockPM- Surprise- LLActRep+ BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x0, TrErr- Train-
SlotClk+ DLActive- BWMgmt- ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-
HotPlug+ Surprise+
                        Slot #0, PowerLimit 6.500W; Interlock- NoCompl-
                SltCtl: Enable: AttnBtn+ PwrFlt- MRL- PresDet+
CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown,
Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-
PresDet- Interlock-
                        Changed: MRL- PresDet- LinkState-
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-
PMEIntEna- CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
                Address: fee0300c  Data: 41d1
        Capabilities: [90] Subsystem: Gigabyte Technology Co., Ltd Device 1405
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [100 v1] Virtual Channel
                Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                Arb:    Fixed+ WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=Fixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=01
                        Status: NegoPending- InProgress-
        Capabilities: [180 v1] Root Complex Link
                Desc:   PortNumber=01 ComponentID=02 EltType=Config
                Link0:  Desc:   TargetPort=00 TargetComponent=02
AssocRCRB- LinkType=MemMapped LinkValid+
                        Addr:   00000000fed1c000
        Kernel driver in use: pcieport

00:1c.4 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express
Port 5 (rev 03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=00, secondary=04, subordinate=06, sec-latency=0
        I/O behind bridge: 00003000-00003fff
        Memory behind bridge: f5500000-f64fffff
        Prefetchable memory behind bridge: 00000000f2400000-00000000f33fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0
                        ExtTag- RBE+
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq-
AuxPwr+ TransPend-
                LnkCap: Port #5, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Exit Latency L0s <256ns, L1 <4us
                        ClockPM- Surprise- LLActRep+ BwNot-
                LnkCtl: ASPM L0s Enabled; RCB 64 bytes Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train-
SlotClk+ DLActive+ BWMgmt- ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-
HotPlug+ Surprise+
                        Slot #4, PowerLimit 6.500W; Interlock- NoCompl-
                SltCtl: Enable: AttnBtn+ PwrFlt- MRL- PresDet+
CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown,
Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-
PresDet+ Interlock-
                        Changed: MRL- PresDet- LinkState-
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-
PMEIntEna- CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
                Address: fee0300c  Data: 41e1
        Capabilities: [90] Subsystem: Gigabyte Technology Co., Ltd Device 1405
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [100 v1] Virtual Channel
                Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                Arb:    Fixed+ WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=Fixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=01
                        Status: NegoPending- InProgress-
        Capabilities: [180 v1] Root Complex Link
                Desc:   PortNumber=05 ComponentID=02 EltType=Config
                Link0:  Desc:   TargetPort=00 TargetComponent=02
AssocRCRB- LinkType=MemMapped LinkValid+
                        Addr:   00000000fed1c000
        Kernel driver in use: pcieport

00:1c.5 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express
Port 6 (rev 03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=00, secondary=07, subordinate=07, sec-latency=0
        I/O behind bridge: 00002000-00002fff
        Memory behind bridge: f4500000-f54fffff
        Prefetchable memory behind bridge: 00000000f3400000-00000000f43fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0
                        ExtTag- RBE+
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-
AuxPwr+ TransPend-
                LnkCap: Port #6, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Exit Latency L0s <256ns, L1 <4us
                        ClockPM- Surprise- LLActRep+ BwNot-
                LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train-
SlotClk+ DLActive+ BWMgmt- ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-
HotPlug+ Surprise+
                        Slot #5, PowerLimit 6.500W; Interlock- NoCompl-
                SltCtl: Enable: AttnBtn+ PwrFlt- MRL- PresDet+
CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown,
Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-
PresDet+ Interlock-
                        Changed: MRL- PresDet- LinkState-
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-
PMEIntEna- CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
                Address: fee0300c  Data: 4142
        Capabilities: [90] Subsystem: Gigabyte Technology Co., Ltd Device 1405
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [100 v1] Virtual Channel
                Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                Arb:    Fixed+ WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=Fixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=01
                        Status: NegoPending- InProgress-
        Capabilities: [180 v1] Root Complex Link
                Desc:   PortNumber=06 ComponentID=02 EltType=Config
                Link0:  Desc:   TargetPort=00 TargetComponent=02
AssocRCRB- LinkType=MemMapped LinkValid+
                        Addr:   00000000fed1c000
        Kernel driver in use: pcieport

00:1d.0 USB controller: Intel Corporation 82801I (ICH9 Family) USB
UHCI Controller #1 (rev 03) (prog-if 00 [UHCI])
        Subsystem: Gigabyte Technology Co., Ltd Device 1405
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 23
        Region 4: I/O ports at 50a0 [size=32]
        Capabilities: [50] PCI Advanced Features
                AFCap: TP+ FLR+
                AFCtrl: FLR-
                AFStatus: TP-
        Kernel driver in use: uhci_hcd

00:1d.1 USB controller: Intel Corporation 82801I (ICH9 Family) USB
UHCI Controller #2 (rev 03) (prog-if 00 [UHCI])
        Subsystem: Gigabyte Technology Co., Ltd Device 1405
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin B routed to IRQ 19
        Region 4: I/O ports at 5080 [size=32]
        Capabilities: [50] PCI Advanced Features
                AFCap: TP+ FLR+
                AFCtrl: FLR-
                AFStatus: TP-
        Kernel driver in use: uhci_hcd

00:1d.2 USB controller: Intel Corporation 82801I (ICH9 Family) USB
UHCI Controller #3 (rev 03) (prog-if 00 [UHCI])
        Subsystem: Gigabyte Technology Co., Ltd Device 1405
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin D routed to IRQ 16
        Region 4: I/O ports at 5060 [size=32]
        Capabilities: [50] PCI Advanced Features
                AFCap: TP+ FLR+
                AFCtrl: FLR-
                AFStatus: TP-
        Kernel driver in use: uhci_hcd

00:1d.3 USB controller: Intel Corporation 82801I (ICH9 Family) USB
UHCI Controller #6 (rev 03) (prog-if 00 [UHCI])
        Subsystem: Gigabyte Technology Co., Ltd Device 1405
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin C routed to IRQ 18
        Region 4: I/O ports at 5040 [size=32]
        Capabilities: [50] PCI Advanced Features
                AFCap: TP+ FLR+
                AFCtrl: FLR-
                AFStatus: TP-
        Kernel driver in use: uhci_hcd

00:1d.7 USB controller: Intel Corporation 82801I (ICH9 Family) USB2
EHCI Controller #1 (rev 03) (prog-if 20 [EHCI])
        Subsystem: Gigabyte Technology Co., Ltd Device 1405
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 23
        Region 0: Memory at f6505800 (32-bit, non-prefetchable) [size=1K]
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

00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 93)
(prog-if 01 [Subtractive decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Bus: primary=00, secondary=08, subordinate=08, sec-latency=32
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
        Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [50] Subsystem: Gigabyte Technology Co., Ltd Device 1405

00:1f.0 ISA bridge: Intel Corporation ICH9M-E LPC Interface Controller (rev 03)
        Subsystem: Gigabyte Technology Co., Ltd Device 1405
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Capabilities: [e0] Vendor Specific Information: Len=0c <?>
        Kernel driver in use: lpc_ich

00:1f.2 SATA controller: Intel Corporation 82801IBM/IEM
(ICH9M/ICH9M-E) 4 port SATA Controller [AHCI mode] (rev 03) (prog-if
01 [AHCI 1.0])
        Subsystem: Gigabyte Technology Co., Ltd Device 1405
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin B routed to IRQ 28
        Region 0: I/O ports at 5108 [size=8]
        Region 1: I/O ports at 511c [size=4]
        Region 2: I/O ports at 5100 [size=8]
        Region 3: I/O ports at 5118 [size=4]
        Region 4: I/O ports at 5020 [size=32]
        Region 5: Memory at f6505000 (32-bit, non-prefetchable) [size=2K]
        Capabilities: [80] MSI: Enable+ Count=1/16 Maskable- 64bit-
                Address: fee0300c  Data: 41a2
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

00:1f.3 SMBus: Intel Corporation 82801I (ICH9 Family) SMBus Controller (rev 03)
        Subsystem: Gigabyte Technology Co., Ltd Device 1405
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin C routed to IRQ 11
        Region 0: Memory at f6506000 (64-bit, non-prefetchable) [size=256]
        Region 4: I/O ports at 5000 [size=32]

00:1f.6 Signal processing controller: Intel Corporation 82801I (ICH9
Family) Thermal Subsystem (rev 03)
        Subsystem: Gigabyte Technology Co., Ltd Device 1405
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin C routed to IRQ 11
        Region 0: Memory at f6504000 (64-bit, non-prefetchable) [size=4K]
        Capabilities: [50] Power Management version 3
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-

04:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 03)
        Subsystem: Gigabyte Technology Co., Ltd Device 1458
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 27
        Region 0: I/O ports at 3000 [size=256]
        Region 2: Memory at f2404000 (64-bit, prefetchable) [size=4K]
        Region 4: Memory at f2400000 (64-bit, prefetchable) [size=16K]
        Expansion ROM at f5500000 [disabled] [size=128K]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
                Address: 00000000fee0300c  Data: 4192
        Capabilities: [70] Express (v2) Endpoint, MSI 01
                DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s
<512ns, L1 <64us
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 4096 bytes
                DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+
AuxPwr+ TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Exit Latency L0s <512ns, L1 <64us
                        ClockPM+ Surprise- LLActRep- BwNot-
                LnkCtl: ASPM L0s Enabled; RCB 64 bytes Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train-
SlotClk+ DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Not Supported,
TimeoutDis+, LTR-, OBFF Not Supported
                DevCtl2: Completion Timeout: 50us to 50ms,
TimeoutDis-, LTR-, OBFF Disabled
                LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-
        Capabilities: [ac] MSI-X: Enable- Count=4 Masked-
                Vector table: BAR=4 offset=00000000
                PBA: BAR=4 offset=00000800
        Capabilities: [cc] Vital Product Data
                Unknown small resource type 00, will not decode more.
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr+ BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
        Capabilities: [140 v1] Virtual Channel
                Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                Arb:    Fixed- WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=Fixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=01
                        Status: NegoPending- InProgress-
        Capabilities: [160 v1] Device Serial Number 04-00-00-00-68-4c-e0-00
        Kernel driver in use: r8169

07:00.0 Network controller: Qualcomm Atheros AR9285 Wireless Network
Adapter (PCI-Express) (rev 01)
        Subsystem: AzureWave AW-NE785 / AW-NE785H 802.11bgn Wireless
Full or Half-size Mini PCIe Card
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 17
        Region 0: Memory at f4500000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=375mA
PME(D0+,D1+,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit-
                Address: 00000000  Data: 0000
        Capabilities: [60] Express (v2) Legacy Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
<512ns, L1 <64us
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+
AuxPwr+ TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Exit Latency L0s <512ns, L1 <64us
                        ClockPM- Surprise- LLActRep- BwNot-
                LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train-
SlotClk+ DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Not Supported,
TimeoutDis+, LTR-, OBFF Not Supported
                DevCtl2: Completion Timeout: 50us to 50ms,
TimeoutDis-, LTR-, OBFF Disabled
                LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr+ BadTLP- BadDLLP+ Rollover+ Timeout+ NonFatalErr+
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
        Capabilities: [140 v1] Virtual Channel
                Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                Arb:    Fixed- WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=Fixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=01
                        Status: NegoPending- InProgress-
        Capabilities: [160 v1] Device Serial Number 00-15-17-ff-ff-24-14-12
        Capabilities: [170 v1] Power Budgeting <?>
        Kernel driver in use: ath9k

[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: TOSHIBA MK3265GS Rev: 3A
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi6 Channel: 00 Id: 00 Lun: 00
  Vendor: Generic- Model: Multi-Card       Rev: 1.00
  Type:   Direct-Access                    ANSI  SCSI revision: 00
Host: scsi7 Channel: 00 Id: 00 Lun: 00
  Vendor: Generic  Model: External         Rev: 1.03
  Type:   Direct-Access                    ANSI  SCSI revision: 04
Host: scsi8 Channel: 00 Id: 00 Lun: 00
  Vendor: WDC WD10 Model: EAVS-00D7B1      Rev:
  Type:   Direct-Access                    ANSI  SCSI revision: 02
Host: scsi9 Channel: 00 Id: 00 Lun: 00
  Vendor: SAMSUNG  Model: HM500JI          Rev:
  Type:   Direct-Access                    ANSI  SCSI revision: 02

[7.7.] Other information that might be relevant to the problem (please
look in /proc and include all information that you think to be
relevant):
adam@redServer:/$ ls /proc
1     13    1421  1629  179   1949  262   34   576  845
consoles     kallsyms    net            timer_list
10    131   1424  1640  18    1987  27    38   59   857        cpuinfo
     kcore       pagetypeinfo   timer_stats
1002  1315  1425  165   180   1988  2741  382  591  9          crypto
     keys        partitions     tty
1035  1318  1429  166   181   2     28    39   595  945        devices
     key-users   sched_debug    uptime
1039  133   1438  167   185   20    2847  40   606  960
diskstats    kmsg        schedstat      version
1068  1331  144   17    186   21    29    409  614  987        dma
     kpagecount  scsi           vmallocinfo
11    1341  147   170   187   22    3     5    615  988        driver
     kpageflags  self           vmstat
1104  1345  149   171   1894  23    30    502  645  998
execdomains  loadavg     slabinfo       zoneinfo
1154  135   15    172   1895  24    3072  505  646  999        fb
     locks       softirqs
1156  1354  1503  173   19    2408  31    508  7    acpi
filesystems  mdstat      stat
1182  1357  152   174   1902  25    3113  52   778  asound     fs
     meminfo     swaps
1199  138   153   175   1907  252   32    525  79   buddyinfo
interrupts   misc        sys
12    14    154   176   1911  2573  3299  53   790  bus        iomem
     modules     sysrq-trigger
1213  140   1576  177   193   26    33    558  8    cgroups    ioports
     mounts      sysvipc
1215  141   158   178   194   261   3312  560  80   cmdline    irq
     mtrr        thread-self

adam@redServer:/$ cat /proc/bus/input/devices
I: Bus=0019 Vendor=0000 Product=0001 Version=0000
N: Name="Power Button"
P: Phys=PNP0C0C/button/input0
S: Sysfs=/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
U: Uniq=
H: Handlers=kbd event0
B: PROP=0
B: EV=3
B: KEY=10000000000000 0

I: Bus=0019 Vendor=0000 Product=0003 Version=0000
N: Name="Sleep Button"
P: Phys=PNP0C0E/button/input0
S: Sysfs=/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input1
U: Uniq=
H: Handlers=kbd event1
B: PROP=0
B: EV=3
B: KEY=4000 0 0

I: Bus=0019 Vendor=0000 Product=0005 Version=0000
N: Name="Lid Switch"
P: Phys=PNP0C0D/button/input0
S: Sysfs=/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input2
U: Uniq=
H: Handlers=event2
B: PROP=0
B: EV=21
B: SW=1

I: Bus=0019 Vendor=0000 Product=0001 Version=0000
N: Name="Power Button"
P: Phys=LNXPWRBN/button/input0
S: Sysfs=/devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
U: Uniq=
H: Handlers=kbd event3
B: PROP=0
B: EV=3
B: KEY=10000000000000 0

I: Bus=0011 Vendor=0001 Product=0001 Version=ab41
N: Name="AT Translated Set 2 keyboard"
P: Phys=isa0060/serio0/input0
S: Sysfs=/devices/platform/i8042/serio0/input/input4
U: Uniq=
H: Handlers=sysrq kbd event4
B: PROP=0
B: EV=120013
B: KEY=402000000 3803078f800d001 feffffdfffefffff fffffffffffffffe
B: MSC=10
B: LED=7

I: Bus=0019 Vendor=0000 Product=0006 Version=0000
N: Name="Video Bus"
P: Phys=LNXVIDEO/video/input0
S: Sysfs=/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input5
U: Uniq=
H: Handlers=kbd event5
B: PROP=0
B: EV=3
B: KEY=3e000b00000000 0 0 0

I: Bus=0003 Vendor=04d9 Product=2519 Version=0100
N: Name="Shenzhen LogoTech  2.4GHz receiver "
P: Phys=usb-0000:00:1d.0-1/input0
S: Sysfs=/devices/pci0000:00/0000:00:1d.0/usb5/5-1/5-1:1.0/0003:04D9:2519.0001/input/input6
U: Uniq=
H: Handlers=sysrq kbd event6
B: PROP=0
B: EV=120013
B: KEY=1000000000007 ff9f207ac14057ff febeffdfffefffff fffffffffffffffe
B: MSC=10
B: LED=7

I: Bus=0003 Vendor=04d9 Product=2519 Version=0100
N: Name="Shenzhen LogoTech  2.4GHz receiver "
P: Phys=usb-0000:00:1d.0-1/input1
S: Sysfs=/devices/pci0000:00/0000:00:1d.0/usb5/5-1/5-1:1.1/0003:04D9:2519.0002/input/input7
U: Uniq=
H: Handlers=kbd mouse0 event7
B: PROP=0
B: EV=1f
B: KEY=3f0003007f 0 0 483ffff17aff32d bf54444600000000 1f0001
120f938b17c000 677bfad941dfed 9ed68000004400 10000002
B: REL=143
B: ABS=100000000
B: MSC=10

I: Bus=0000 Vendor=0000 Product=0000 Version=0000
N: Name="HDA Intel Front Mic"
P: Phys=ALSA
S: Sysfs=/devices/pci0000:00/0000:00:1b.0/sound/card0/input8
U: Uniq=
H: Handlers=event8
B: PROP=0
B: EV=21
B: SW=10

I: Bus=0000 Vendor=0000 Product=0000 Version=0000
N: Name="HDA Intel Rear Mic"
P: Phys=ALSA
S: Sysfs=/devices/pci0000:00/0000:00:1b.0/sound/card0/input9
U: Uniq=
H: Handlers=event9
B: PROP=0
B: EV=21
B: SW=10

I: Bus=0000 Vendor=0000 Product=0000 Version=0000
N: Name="HDA Intel Headphone"
P: Phys=ALSA
S: Sysfs=/devices/pci0000:00/0000:00:1b.0/sound/card0/input10
U: Uniq=
H: Handlers=event10
B: PROP=0
B: EV=21
B: SW=4

I: Bus=0000 Vendor=0000 Product=0000 Version=0000
N: Name="HDA Intel Front Headphone"
P: Phys=ALSA
S: Sysfs=/devices/pci0000:00/0000:00:1b.0/sound/card0/input11
U: Uniq=
H: Handlers=event11
B: PROP=0
B: EV=21
B: SW=4

I: Bus=0000 Vendor=0000 Product=0000 Version=0000
N: Name="HDA Intel HDMI/DP,pcm=3"
P: Phys=ALSA
S: Sysfs=/devices/pci0000:00/0000:00:1b.0/sound/card0/input12
U: Uniq=
H: Handlers=event12
B: PROP=0
B: EV=21
B: SW=140

[X.] Other notes, patches, fixes, workarounds:
An external USB mouse works when it is connected (and is visible in
proc/input/devices as the 2.4GHz receiver). The touchpad remains
dead.The touchpad works in windows 7 (dual boot system) so I am sure
it is not a hardware issue.

Please provide a link to your Launchpad bug report.
https://bugs.launchpad.net/bugs/1388335
