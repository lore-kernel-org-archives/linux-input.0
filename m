From: Ari Fogel <arifogel@ucla.edu>
Subject: 045e:0745 [HP TouchSmart tm2t-2200] No scancode for several keys
 of Microsoft Comfort Desktop 5000
Date: Wed, 01 Oct 2014 13:36:39 -0700
Message-ID: <542C65D7.30701@ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:38051 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005AbaJAUgm (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 1 Oct 2014 16:36:42 -0400
Received: by mail-pa0-f43.google.com with SMTP id lf10so927883pab.2
        for <linux-input@vger.kernel.org>; Wed, 01 Oct 2014 13:36:41 -0700 (PDT)
Received: from [192.168.9.2] (cpe-23-243-174-158.socal.res.rr.com. [23.243.174.158])
        by mx.google.com with ESMTPSA id az8sm1812614pac.12.2014.10.01.13.36.39
        for <linux-input@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Oct 2014 13:36:40 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

[1.] One line summary of the problem:
045e:0745 [HP TouchSmart tm2t-2200] No scancode for several keys of
Microsoft Comfort Desktop 5000

[2.] Full description of the problem/report:
I wanted to map the keys labeled '1', '2', '3', '4', and '5' above the
F-keys between the camera key and the star key, but I discovered that
these raise no events whatsoever via dmesg, xev, nor showkey.

[3.] Keywords (i.e., modules, networking, kernel):

[4.] Kernel version (from /proc/version):
Linux version 3.17.0-031700rc7-generic (apw@gomeisa) (gcc version 4.6.3
(Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201409281835 SMP Sun Sep 28 22:36:30
UTC 2014

[5.] Output of Oops.. message (if applicable) with symbolic information
resolved (see Documentation/oops-tracing.txt)

[6.] A small shell script or example program which triggers the problem
(if possible)

[7.] Environment
Description:    Ubuntu 14.04.1 LTS
Release:    14.04

[7.1.] Software (add the output of the ver_linux script here)
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux cosmos 3.17.0-031700rc7-generic #201409281835 SMP Sun Sep 28
22:36:30 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux
 
Gnu C                  4.8
Gnu make               3.81
binutils               2.24
util-linux             2.20.1
mount                  support
module-init-tools      15
e2fsprogs              1.42.9
xfsprogs               3.1.9
pcmciautils            018
PPP                    2.4.5
Linux C Library        2.19
Dynamic linker (ldd)   2.19
Procps                 3.3.9
Net-tools              1.60
Kbd                    1.15.5
Sh-utils               8.21
wireless-tools         30
Modules Loaded         pci_stub vboxpci vboxnetadp vboxnetflt
xt_CHECKSUM iptable_mangle ipt_MASQUERADE iptable_nat nf_conntrack_ipv4
nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack xt_tcpudp vboxdrv bridge
stp llc iptable_filter ip_tables x_tables rfcomm bnep binfmt_misc
snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel
snd_hda_controller snd_usb_audio snd_hda_codec snd_usbmidi_lib snd_hwdep
snd_seq_midi snd_seq_midi_event snd_rawmidi uvcvideo videobuf2_vmalloc
snd_seq snd_pcm videobuf2_memops snd_seq_device videobuf2_core
v4l2_common gpio_ich videodev snd_timer mxm_wmi media coretemp snd
joydev kvm_intel kvm btusb bluetooth soundcore i7core_edac edac_core
nuvoton_cir serio_raw lpc_ich rc_core wmi mac_hid parport_pc ppdev lp
parport hid_generic usbhid hid pata_acpi pata_marvell e1000e psmouse
firewire_ohci ahci firewire_core ptp libahci crc_itu_t pps_core

[7.2.] Processor information (from /proc/cpuinfo):
processor    : 0
vendor_id    : GenuineIntel
cpu family    : 6
model        : 30
model name    : Intel(R) Core(TM) i7 CPU         860  @ 2.80GHz
stepping    : 5
microcode    : 0x4
cpu MHz        : 1199.000
cache size    : 8192 KB
physical id    : 0
siblings    : 8
core id        : 0
cpu cores    : 4
apicid        : 0
initial apicid    : 0
fpu        : yes
fpu_exception    : yes
cpuid level    : 11
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall
nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
nonstop_tsc aperfmperf pni dtes64 monitor ds_cpl vmx smx est tm2 ssse3
cx16 xtpr pdcm sse4_1 sse4_2 popcnt lahf_lm ida dtherm tpr_shadow vnmi
flexpriority ept vpid
bugs        :
bogomips    : 5600.53
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 1
vendor_id    : GenuineIntel
cpu family    : 6
model        : 30
model name    : Intel(R) Core(TM) i7 CPU         860  @ 2.80GHz
stepping    : 5
microcode    : 0x4
cpu MHz        : 1199.000
cache size    : 8192 KB
physical id    : 0
siblings    : 8
core id        : 0
cpu cores    : 4
apicid        : 1
initial apicid    : 1
fpu        : yes
fpu_exception    : yes
cpuid level    : 11
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall
nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
nonstop_tsc aperfmperf pni dtes64 monitor ds_cpl vmx smx est tm2 ssse3
cx16 xtpr pdcm sse4_1 sse4_2 popcnt lahf_lm ida dtherm tpr_shadow vnmi
flexpriority ept vpid
bugs        :
bogomips    : 5600.53
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 2
vendor_id    : GenuineIntel
cpu family    : 6
model        : 30
model name    : Intel(R) Core(TM) i7 CPU         860  @ 2.80GHz
stepping    : 5
microcode    : 0x4
cpu MHz        : 1199.000
cache size    : 8192 KB
physical id    : 0
siblings    : 8
core id        : 1
cpu cores    : 4
apicid        : 2
initial apicid    : 2
fpu        : yes
fpu_exception    : yes
cpuid level    : 11
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall
nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
nonstop_tsc aperfmperf pni dtes64 monitor ds_cpl vmx smx est tm2 ssse3
cx16 xtpr pdcm sse4_1 sse4_2 popcnt lahf_lm ida dtherm tpr_shadow vnmi
flexpriority ept vpid
bugs        :
bogomips    : 5600.53
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 3
vendor_id    : GenuineIntel
cpu family    : 6
model        : 30
model name    : Intel(R) Core(TM) i7 CPU         860  @ 2.80GHz
stepping    : 5
microcode    : 0x4
cpu MHz        : 1199.000
cache size    : 8192 KB
physical id    : 0
siblings    : 8
core id        : 1
cpu cores    : 4
apicid        : 3
initial apicid    : 3
fpu        : yes
fpu_exception    : yes
cpuid level    : 11
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall
nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
nonstop_tsc aperfmperf pni dtes64 monitor ds_cpl vmx smx est tm2 ssse3
cx16 xtpr pdcm sse4_1 sse4_2 popcnt lahf_lm ida dtherm tpr_shadow vnmi
flexpriority ept vpid
bugs        :
bogomips    : 5600.53
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 4
vendor_id    : GenuineIntel
cpu family    : 6
model        : 30
model name    : Intel(R) Core(TM) i7 CPU         860  @ 2.80GHz
stepping    : 5
microcode    : 0x4
cpu MHz        : 1199.000
cache size    : 8192 KB
physical id    : 0
siblings    : 8
core id        : 2
cpu cores    : 4
apicid        : 4
initial apicid    : 4
fpu        : yes
fpu_exception    : yes
cpuid level    : 11
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall
nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
nonstop_tsc aperfmperf pni dtes64 monitor ds_cpl vmx smx est tm2 ssse3
cx16 xtpr pdcm sse4_1 sse4_2 popcnt lahf_lm ida dtherm tpr_shadow vnmi
flexpriority ept vpid
bugs        :
bogomips    : 5600.53
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 5
vendor_id    : GenuineIntel
cpu family    : 6
model        : 30
model name    : Intel(R) Core(TM) i7 CPU         860  @ 2.80GHz
stepping    : 5
microcode    : 0x4
cpu MHz        : 1199.000
cache size    : 8192 KB
physical id    : 0
siblings    : 8
core id        : 2
cpu cores    : 4
apicid        : 5
initial apicid    : 5
fpu        : yes
fpu_exception    : yes
cpuid level    : 11
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall
nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
nonstop_tsc aperfmperf pni dtes64 monitor ds_cpl vmx smx est tm2 ssse3
cx16 xtpr pdcm sse4_1 sse4_2 popcnt lahf_lm ida dtherm tpr_shadow vnmi
flexpriority ept vpid
bugs        :
bogomips    : 5600.53
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 6
vendor_id    : GenuineIntel
cpu family    : 6
model        : 30
model name    : Intel(R) Core(TM) i7 CPU         860  @ 2.80GHz
stepping    : 5
microcode    : 0x4
cpu MHz        : 1199.000
cache size    : 8192 KB
physical id    : 0
siblings    : 8
core id        : 3
cpu cores    : 4
apicid        : 6
initial apicid    : 6
fpu        : yes
fpu_exception    : yes
cpuid level    : 11
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall
nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
nonstop_tsc aperfmperf pni dtes64 monitor ds_cpl vmx smx est tm2 ssse3
cx16 xtpr pdcm sse4_1 sse4_2 popcnt lahf_lm ida dtherm tpr_shadow vnmi
flexpriority ept vpid
bugs        :
bogomips    : 5600.53
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 7
vendor_id    : GenuineIntel
cpu family    : 6
model        : 30
model name    : Intel(R) Core(TM) i7 CPU         860  @ 2.80GHz
stepping    : 5
microcode    : 0x4
cpu MHz        : 1199.000
cache size    : 8192 KB
physical id    : 0
siblings    : 8
core id        : 3
cpu cores    : 4
apicid        : 7
initial apicid    : 7
fpu        : yes
fpu_exception    : yes
cpuid level    : 11
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall
nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
nonstop_tsc aperfmperf pni dtes64 monitor ds_cpl vmx smx est tm2 ssse3
cx16 xtpr pdcm sse4_1 sse4_2 popcnt lahf_lm ida dtherm tpr_shadow vnmi
flexpriority ept vpid
bugs        :
bogomips    : 5600.53
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:


[7.3.] Module information (from /proc/modules):
pci_stub 12622 1 - Live 0x0000000000000000
vboxpci 23194 0 - Live 0x0000000000000000 (OE)
vboxnetadp 25670 0 - Live 0x0000000000000000 (OE)
vboxnetflt 27613 0 - Live 0x0000000000000000 (OE)
xt_CHECKSUM 12549 1 - Live 0x0000000000000000
iptable_mangle 12734 1 - Live 0x0000000000000000
ipt_MASQUERADE 12880 1 - Live 0x0000000000000000
iptable_nat 13110 1 - Live 0x0000000000000000
nf_conntrack_ipv4 14857 1 - Live 0x0000000000000000
nf_defrag_ipv4 12758 1 nf_conntrack_ipv4, Live 0x0000000000000000
nf_nat_ipv4 13316 1 iptable_nat, Live 0x0000000000000000
nf_nat 26308 3 ipt_MASQUERADE,iptable_nat,nf_nat_ipv4, Live
0x0000000000000000
nf_conntrack 105636 5
ipt_MASQUERADE,iptable_nat,nf_conntrack_ipv4,nf_nat_ipv4,nf_nat, Live
0x0000000000000000
xt_tcpudp 12924 5 - Live 0x0000000000000000
vboxdrv 409815 3 vboxpci,vboxnetadp,vboxnetflt, Live 0x0000000000000000 (OE)
bridge 122058 0 - Live 0x0000000000000000
stp 12976 1 bridge, Live 0x0000000000000000
llc 14441 2 bridge,stp, Live 0x0000000000000000
iptable_filter 12810 1 - Live 0x0000000000000000
ip_tables 27718 3 iptable_mangle,iptable_nat,iptable_filter, Live
0x0000000000000000
x_tables 34102 6
xt_CHECKSUM,iptable_mangle,ipt_MASQUERADE,xt_tcpudp,iptable_filter,ip_tables,
Live 0x0000000000000000
rfcomm 75114 8 - Live 0x0000000000000000
bnep 19884 2 - Live 0x0000000000000000
binfmt_misc 17508 1 - Live 0x0000000000000000
snd_hda_codec_realtek 78564 1 - Live 0x0000000000000000
snd_hda_codec_generic 70087 1 snd_hda_codec_realtek, Live 0x0000000000000000
snd_hda_intel 30783 0 - Live 0x0000000000000000
snd_hda_controller 32234 1 snd_hda_intel, Live 0x0000000000000000
snd_usb_audio 164122 0 - Live 0x0000000000000000
snd_hda_codec 145035 4
snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_controller,
Live 0x0000000000000000
snd_usbmidi_lib 30597 1 snd_usb_audio, Live 0x0000000000000000
snd_hwdep 17709 2 snd_usb_audio,snd_hda_codec, Live 0x0000000000000000
snd_seq_midi 13564 0 - Live 0x0000000000000000
snd_seq_midi_event 14899 1 snd_seq_midi, Live 0x0000000000000000
snd_rawmidi 31197 2 snd_usbmidi_lib,snd_seq_midi, Live 0x0000000000000000
uvcvideo 86628 0 - Live 0x0000000000000000
videobuf2_vmalloc 13216 1 uvcvideo, Live 0x0000000000000000
snd_seq 63540 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
snd_pcm 105052 4
snd_hda_intel,snd_hda_controller,snd_usb_audio,snd_hda_codec, Live
0x0000000000000000
videobuf2_memops 13362 1 videobuf2_vmalloc, Live 0x0000000000000000
snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live
0x0000000000000000
videobuf2_core 59907 1 uvcvideo, Live 0x0000000000000000
v4l2_common 15715 1 videobuf2_core, Live 0x0000000000000000
gpio_ich 13636 0 - Live 0x0000000000000000
videodev 163831 3 uvcvideo,videobuf2_core,v4l2_common, Live
0x0000000000000000
snd_timer 30118 2 snd_seq,snd_pcm, Live 0x0000000000000000
mxm_wmi 13021 0 - Live 0x0000000000000000
media 22008 2 uvcvideo,videodev, Live 0x0000000000000000
coretemp 13638 0 - Live 0x0000000000000000
snd 84025 12
snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_usb_audio,snd_hda_codec,snd_usbmidi_lib,snd_hwdep,snd_rawmidi,snd_seq,snd_pcm,snd_seq_device,snd_timer,
Live 0x0000000000000000
joydev 17587 0 - Live 0x0000000000000000
kvm_intel 149257 0 - Live 0x0000000000000000
kvm 468567 1 kvm_intel, Live 0x0000000000000000
btusb 32408 0 - Live 0x0000000000000000
bluetooth 477455 22 rfcomm,bnep,btusb, Live 0x0000000000000000
soundcore 15091 2 snd_hda_codec,snd, Live 0x0000000000000000
i7core_edac 24582 0 - Live 0x0000000000000000
edac_core 52405 2 i7core_edac, Live 0x0000000000000000
nuvoton_cir 17920 0 - Live 0x0000000000000000
serio_raw 13483 0 - Live 0x0000000000000000
lpc_ich 21176 0 - Live 0x0000000000000000
rc_core 27515 1 nuvoton_cir, Live 0x0000000000000000
wmi 19379 1 mxm_wmi, Live 0x0000000000000000
mac_hid 13275 0 - Live 0x0000000000000000
parport_pc 32906 0 - Live 0x0000000000000000
ppdev 17711 0 - Live 0x0000000000000000
lp 17799 0 - Live 0x0000000000000000
parport 42481 3 parport_pc,ppdev,lp, Live 0x0000000000000000
hid_generic 12559 0 - Live 0x0000000000000000
usbhid 53122 0 - Live 0x0000000000000000
hid 110572 2 hid_generic,usbhid, Live 0x0000000000000000
pata_acpi 13053 0 - Live 0x0000000000000000
pata_marvell 12940 0 - Live 0x0000000000000000
e1000e 230063 0 - Live 0x0000000000000000
psmouse 118039 0 - Live 0x0000000000000000
firewire_ohci 45300 0 - Live 0x0000000000000000
ahci 30167 4 - Live 0x0000000000000000
firewire_core 69403 1 firewire_ohci, Live 0x0000000000000000
ptp 19534 1 e1000e, Live 0x0000000000000000
libahci 32533 1 ahci, Live 0x0000000000000000
crc_itu_t 12707 1 firewire_core, Live 0x0000000000000000
pps_core 19381 1 ptp, Live 0x0000000000000000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
0000-0cf7 : PCI Bus 0000:00
  0000-001f : dma1
  0020-0021 : pic1
  0040-0043 : timer0
  0050-0053 : timer1
  0060-0060 : keyboard
  0061-0061 : PNP0800:00
  0064-0064 : keyboard
  0070-0071 : rtc0
  0080-008f : dma page reg
  00a0-00a1 : pic2
  00c0-00df : dma2
  00f0-00ff : fpu
    00f0-00f0 : PNP0C04:00
  03c0-03df : vga+
  0400-0403 : ACPI PM1a_EVT_BLK
  0404-0405 : ACPI PM1a_CNT_BLK
  0408-040b : ACPI PM_TMR
  0410-0415 : ACPI CPU throttle
  0420-042f : ACPI GPE0_BLK
    0428-042f : gpio_ich
  0430-0433 : iTCO_wdt
  0450-0450 : ACPI PM2_CNT_BLK
  0460-047f : iTCO_wdt
  0500-057f : gpio_ich
    0500-057f : pnp 00:02
      0530-053f : gpio_ich
      0540-054f : gpio_ich
  0680-06ff : pnp 00:02
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
  1000-1fff : PCI Bus 0000:06
    1000-100f : 0000:06:00.0
      1000-100f : pata_marvell
    1010-1017 : 0000:06:00.0
      1010-1017 : pata_marvell
    1018-101f : 0000:06:00.0
      1018-101f : pata_marvell
    1020-1023 : 0000:06:00.0
      1020-1023 : pata_marvell
    1024-1027 : 0000:06:00.0
      1024-1027 : pata_marvell
  2000-3fff : PCI Bus 0000:01
    2000-3fff : PCI Bus 0000:02
      2000-2fff : PCI Bus 0000:04
        2000-207f : 0000:04:00.0
      3000-3fff : PCI Bus 0000:03
        3000-307f : 0000:03:00.0
  4000-401f : 0000:00:1f.3
  4020-403f : 0000:00:1f.2
    4020-403f : ahci
  4040-405f : 0000:00:19.0
  4060-4067 : 0000:00:1f.2
    4060-4067 : ahci
  4068-406f : 0000:00:1f.2
    4068-406f : ahci
  4070-4073 : 0000:00:1f.2
    4070-4073 : ahci
  4074-4077 : 0000:00:1f.2
    4074-4077 : ahci
  5000-5fff : PCI Bus 0000:05
00000000-00000fff : reserved
00001000-0008efff : System RAM
0008f000-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000cddff : Video ROM
000e0000-000fffff : reserved
  000f0000-000fffff : System ROM
00100000-cf52bfff : System RAM
  01000000-017a9a77 : Kernel code
  017a9a78-01d1e57f : Kernel data
  01e80000-01fc6fff : Kernel bss
cf52c000-cf533fff : reserved
cf534000-cf56efff : System RAM
cf56f000-cf5befff : reserved
cf5bf000-cf6cffff : System RAM
cf6d0000-cf7befff : ACPI Non-volatile Storage
cf7bf000-cf7e4fff : System RAM
cf7e5000-cf7eefff : ACPI Tables
cf7ef000-cf7effff : System RAM
cf7f0000-cf7fefff : ACPI Tables
cf7ff000-cf7fffff : System RAM
cf800000-cfffffff : reserved
d0000000-f7ffffff : PCI Bus 0000:00
  d0000000-efffffff : PCI Bus 0000:01
    d0000000-efffffff : PCI Bus 0000:02
      d0000000-dfffffff : PCI Bus 0000:04
        d0000000-dfffffff : 0000:04:00.0
      e0000000-efffffff : PCI Bus 0000:03
        e0000000-efffffff : 0000:03:00.0
  f0000000-f6ffffff : PCI Bus 0000:01
    f0000000-f6ffffff : PCI Bus 0000:02
      f0000000-f2ffffff : PCI Bus 0000:04
        f0000000-f1ffffff : 0000:04:00.0
        f2000000-f2ffffff : 0000:04:00.0
      f4000000-f6ffffff : PCI Bus 0000:03
        f4000000-f5ffffff : 0000:03:00.0
        f6000000-f6ffffff : 0000:03:00.0
  f7000000-f70fffff : PCI Bus 0000:07
    f7000000-f7003fff : 0000:07:03.0
    f7004000-f70047ff : 0000:07:03.0
      f7004000-f70047ff : firewire_ohci
  f7100000-f71fffff : PCI Bus 0000:06
    f7100000-f71003ff : 0000:06:00.0
    f7140000-f717ffff : 0000:06:00.0
  f7200000-f721ffff : 0000:00:19.0
    f7200000-f721ffff : e1000e
  f7220000-f7223fff : 0000:00:1b.0
    f7220000-f7223fff : ICH HD audio
  f7224000-f7224fff : 0000:00:19.0
    f7224000-f7224fff : e1000e
  f7225000-f72257ff : 0000:00:1f.2
    f7225000-f72257ff : ahci
  f7226000-f72260ff : 0000:00:1f.3
  f7302000-f73023ff : 0000:00:1a.0
    f7302000-f73023ff : ehci_hcd
  f7303000-f73033ff : 0000:00:1d.0
    f7303000-f73033ff : ehci_hcd
  f7400000-f75fffff : PCI Bus 0000:05
  f7600000-f77fffff : PCI Bus 0000:05
f8000000-ffffffff : reserved
  f8000000-fbffffff : PCI MMCONFIG 0000 [bus 00-3f]
  fec00000-fec003ff : IOAPIC 0
    fec00000-fec000ff : PNP0003:00
  fed00000-fed03fff : PNP0103:00
    fed00000-fed003ff : HPET 0
  fed1f410-fed1f414 : iTCO_wdt
  fee00000-fee00fff : Local APIC
100000000-42fffffff : System RAM

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: Intel Corporation Core Processor DMI (rev 11)
    Subsystem: Intel Corporation Device 0000
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Capabilities: [40] #00 [0000]

00:03.0 PCI bridge: Intel Corporation Core Processor PCI Express Root
Port 1 (rev 11) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Bus: primary=00, secondary=01, subordinate=04, sec-latency=0
    I/O behind bridge: 00002000-00003fff
    Memory behind bridge: f0000000-f6ffffff
    Prefetchable memory behind bridge: 00000000d0000000-00000000efffffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [40] Subsystem: Intel Corporation Device 0000
    Capabilities: [60] MSI: Enable+ Count=1/2 Maskable+ 64bit-
        Address: feeff00c  Data: 41c1
        Masking: 00000002  Pending: 00000000
    Capabilities: [90] Express (v2) Root Port (Slot+), MSI 00
        DevCap:    MaxPayload 256 bytes, PhantFunc 0
            ExtTag+ RBE+
        DevCtl:    Report errors: Correctable+ Non-Fatal+ Fatal+
Unsupported+
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr-
TransPend-
        LnkCap:    Port #3, Speed 5GT/s, Width x16, ASPM not supported,
Exit Latency L0s <512ns, L1 <4us
            ClockPM- Surprise+ LLActRep+ BwNot+
        LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 5GT/s, Width x2, TrErr- Train- SlotClk+
DLActive+ BWMgmt+ ABWMgmt-
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug-
Surprise-
            Slot #3, PowerLimit 0.000W; Interlock- NoCompl-
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
HPIrq- LinkChg-
            Control: AttnInd Off, PwrInd Off, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet-
Interlock-
            Changed: MRL- PresDet- LinkState-
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
CRSVisible-
        RootCap: CRSVisible-
        RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        DevCap2: Completion Timeout: Range BCD, TimeoutDis+, LTR-, OBFF
Not Supported ARIFwd+
        DevCtl2: Completion Timeout: 260ms to 900ms, TimeoutDis-, LTR-,
OBFF Disabled ARIFwd-
        LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-
    Capabilities: [e0] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [100 v1] Advanced Error Reporting
        UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UESvrt:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
        CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
        AERCap:    First Error Pointer: 0e, GenCap- CGenEn- ChkCap- ChkEn-
    Capabilities: [150 v1] Access Control Services
        ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+
UpstreamFwd+ EgressCtrl- DirectTrans-
        ACSCtl:    SrcValid- TransBlk- ReqRedir- CmpltRedir-
UpstreamFwd- EgressCtrl- DirectTrans-
    Capabilities: [160 v0] Vendor Specific Information: ID=0002 Rev=0
Len=00c <?>
    Kernel driver in use: pcieport

00:08.0 System peripheral: Intel Corporation Core Processor System
Management Registers (rev 11)
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0
            ExtTag- RBE+
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr-
TransPend-
        DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-,
OBFF Not Supported
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-,
OBFF Disabled
    Capabilities: [100 v0] Vendor Specific Information: ID=0000 Rev=0
Len=000 <?>

00:08.1 System peripheral: Intel Corporation Core Processor Semaphore
and Scratchpad Registers (rev 11)
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0
            ExtTag- RBE+
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr-
TransPend-
        DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-,
OBFF Not Supported
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-,
OBFF Disabled
    Capabilities: [100 v0] Vendor Specific Information: ID=0000 Rev=0
Len=000 <?>

00:08.2 System peripheral: Intel Corporation Core Processor System
Control and Status Registers (rev 11)
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0
            ExtTag- RBE+
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr-
TransPend-
        DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-,
OBFF Not Supported
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-,
OBFF Disabled
    Capabilities: [100 v0] Vendor Specific Information: ID=0000 Rev=0
Len=000 <?>

00:08.3 System peripheral: Intel Corporation Core Processor
Miscellaneous Registers (rev 11)
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:10.0 System peripheral: Intel Corporation Core Processor QPI Link
(rev 11)
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:10.1 System peripheral: Intel Corporation Core Processor QPI Routing
and Protocol Registers (rev 11)
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:19.0 Ethernet controller: Intel Corporation 82578DC Gigabit Network
Connection (rev 05)
    Subsystem: Intel Corporation Device 0000
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 32
    Region 0: Memory at f7200000 (32-bit, non-prefetchable) [size=128K]
    Region 1: Memory at f7224000 (32-bit, non-prefetchable) [size=4K]
    Region 2: I/O ports at 4040 [size=32]
    Capabilities: [c8] Power Management version 2
        Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
    Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Address: 00000000fee1000c  Data: 41b2
    Capabilities: [e0] PCI Advanced Features
        AFCap: TP+ FLR+
        AFCtrl: FLR-
        AFStatus: TP-
    Kernel driver in use: e1000e

00:1a.0 USB controller: Intel Corporation 5 Series/3400 Series Chipset
USB2 Enhanced Host Controller (rev 05) (prog-if 20 [EHCI])
    Subsystem: Intel Corporation Device 424b
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 16
    Region 0: Memory at f7302000 (32-bit, non-prefetchable) [size=1K]
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

00:1b.0 Audio device: Intel Corporation 5 Series/3400 Series Chipset
High Definition Audio (rev 05)
    Subsystem: Intel Corporation Device 0031
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 33
    Region 0: Memory at f7220000 (64-bit, non-prefetchable) [size=16K]
    Capabilities: [50] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Address: 00000000feeff00c  Data: 4192
    Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0
            ExtTag- RBE-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+
TransPend-
    Capabilities: [100 v1] Virtual Channel
        Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
        Arb:    Fixed- WRR32- WRR64- WRR128-
        Ctrl:    ArbSelect=Fixed
        Status:    InProgress-
        VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
            Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
            Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=01
            Status:    NegoPending- InProgress-
        VC1:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
            Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
            Ctrl:    Enable+ ID=2 ArbSelect=Fixed TC/VC=04
            Status:    NegoPending- InProgress-
    Capabilities: [130 v1] Root Complex Link
        Desc:    PortNumber=0f ComponentID=00 EltType=Config
        Link0:    Desc:    TargetPort=00 TargetComponent=00 AssocRCRB-
LinkType=MemMapped LinkValid+
            Addr:    00000000fed1c000
    Kernel driver in use: snd_hda_intel

00:1c.0 PCI bridge: Intel Corporation 5 Series/3400 Series Chipset PCI
Express Root Port 1 (rev 05) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
    I/O behind bridge: 00005000-00005fff
    Memory behind bridge: f7400000-f75fffff
    Prefetchable memory behind bridge: 00000000f7600000-00000000f77fffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
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
        LnkCap:    Port #1, Speed 2.5GT/s, Width x4, ASPM L0s L1, Exit
Latency L0s <1us, L1 <4us
            ClockPM- Surprise- LLActRep+ BwNot-
        LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk-
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+
Surprise+
            Slot #0, PowerLimit 25.000W; Interlock- NoCompl+
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt-
HPIrq+ LinkChg+
            Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet-
Interlock-
            Changed: MRL- PresDet- LinkState-
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
CRSVisible-
        RootCap: CRSVisible-
        RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF
Not Supported ARIFwd-
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-,
OBFF Disabled ARIFwd-
        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-
    Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Address: feeff00c  Data: 41e1
    Capabilities: [90] Subsystem: Intel Corporation Device 424b
    Capabilities: [a0] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Kernel driver in use: pcieport

00:1c.7 PCI bridge: Intel Corporation 5 Series/3400 Series Chipset PCI
Express Root Port 8 (rev 05) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Bus: primary=00, secondary=06, subordinate=06, sec-latency=0
    I/O behind bridge: 00001000-00001fff
    Memory behind bridge: f7100000-f71fffff
    Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [40] Express (v2) Root Port (Slot-), MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0
            ExtTag- RBE+
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+
TransPend-
        LnkCap:    Port #8, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s <256ns, L1 <4us
            ClockPM- Surprise- LLActRep+ BwNot-
        LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive+ BWMgmt- ABWMgmt-
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
CRSVisible-
        RootCap: CRSVisible-
        RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF
Not Supported ARIFwd-
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-,
OBFF Disabled ARIFwd-
        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-
    Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
        Address: 00000000  Data: 0000
    Capabilities: [90] Subsystem: Intel Corporation Device 424b
    Capabilities: [a0] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Kernel driver in use: pcieport

00:1d.0 USB controller: Intel Corporation 5 Series/3400 Series Chipset
USB2 Enhanced Host Controller (rev 05) (prog-if 20 [EHCI])
    Subsystem: Intel Corporation Device 424b
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 23
    Region 0: Memory at f7303000 (32-bit, non-prefetchable) [size=1K]
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

00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev a5) (prog-if
01 [Subtractive decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Bus: primary=00, secondary=07, subordinate=07, sec-latency=32
    I/O behind bridge: 0000f000-00000fff
    Memory behind bridge: f7000000-f70fffff
    Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
    Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [50] Subsystem: Intel Corporation Device 424b

00:1f.0 ISA bridge: Intel Corporation 5 Series Chipset LPC Interface
Controller (rev 05)
    Subsystem: Intel Corporation Device 424b
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Capabilities: [e0] Vendor Specific Information: Len=10 <?>
    Kernel driver in use: lpc_ich

00:1f.2 SATA controller: Intel Corporation 5 Series/3400 Series Chipset
6 port SATA AHCI Controller (rev 05) (prog-if 01 [AHCI 1.0])
    Subsystem: Intel Corporation Device 424b
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin B routed to IRQ 31
    Region 0: I/O ports at 4068 [size=8]
    Region 1: I/O ports at 4074 [size=4]
    Region 2: I/O ports at 4060 [size=8]
    Region 3: I/O ports at 4070 [size=4]
    Region 4: I/O ports at 4020 [size=32]
    Region 5: Memory at f7225000 (32-bit, non-prefetchable) [size=2K]
    Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Address: feec000c  Data: 4152
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

00:1f.3 SMBus: Intel Corporation 5 Series/3400 Series Chipset SMBus
Controller (rev 05)
    Subsystem: Intel Corporation Device 424b
    Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Interrupt: pin C routed to IRQ 11
    Region 0: Memory at f7226000 (64-bit, non-prefetchable) [size=256]
    Region 4: I/O ports at 4000 [size=32]

01:00.0 PCI bridge: NVIDIA Corporation NF200 PCIe 2.0 switch for GTX 295
(rev a3) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Bus: primary=01, secondary=02, subordinate=04, sec-latency=0
    I/O behind bridge: 00002000-00003fff
    Memory behind bridge: f0000000-f6ffffff
    Prefetchable memory behind bridge: 00000000d0000000-00000000efffffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [40] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [60] Express (v2) Upstream Port, MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0
            ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ SlotPowerLimit 0.000W
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr-
TransPend-
        LnkCap:    Port #0, Speed 5GT/s, Width x16, ASPM L0s, Exit
Latency L0s <512ns, L1 <4us
            ClockPM- Surprise- LLActRep- BwNot-
        LnkCtl:    ASPM Disabled; Disabled- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 5GT/s, Width x2, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
        DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-,
OBFF Not Supported
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-,
OBFF Disabled
        LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-
    Capabilities: [a0] Subsystem: NVIDIA Corporation Device 064e
    Kernel driver in use: pcieport

02:00.0 PCI bridge: NVIDIA Corporation NF200 PCIe 2.0 switch for GTX 295
(rev a3) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Bus: primary=02, secondary=03, subordinate=03, sec-latency=0
    I/O behind bridge: 00003000-00003fff
    Memory behind bridge: f4000000-f6ffffff
    Prefetchable memory behind bridge: 00000000e0000000-00000000efffffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [40] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [60] Express (v2) Downstream Port (Slot+), MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0
            ExtTag+ RBE+
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr-
TransPend-
        LnkCap:    Port #0, Speed 5GT/s, Width x16, ASPM L0s, Exit
Latency L0s <512ns, L1 <4us
            ClockPM- Surprise- LLActRep+ BwNot+
        LnkCtl:    ASPM Disabled; Disabled- CommClk-
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x16, TrErr- Train- SlotClk+
DLActive+ BWMgmt+ ABWMgmt-
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug-
Surprise-
            Slot #1, PowerLimit 0.000W; Interlock- NoCompl-
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
HPIrq- LinkChg-
            Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+
Interlock-
            Changed: MRL- PresDet- LinkState-
        DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-,
OBFF Not Supported ARIFwd-
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-,
OBFF Disabled ARIFwd-
        LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-,
Selectable De-emphasis: -3.5dB
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-
    Kernel driver in use: pcieport

02:02.0 PCI bridge: NVIDIA Corporation NF200 PCIe 2.0 switch for GTX 295
(rev a3) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Bus: primary=02, secondary=04, subordinate=04, sec-latency=0
    I/O behind bridge: 00002000-00002fff
    Memory behind bridge: f0000000-f2ffffff
    Prefetchable memory behind bridge: 00000000d0000000-00000000dfffffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [40] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [60] Express (v2) Downstream Port (Slot+), MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0
            ExtTag+ RBE+
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr-
TransPend-
        LnkCap:    Port #2, Speed 5GT/s, Width x16, ASPM L0s, Exit
Latency L0s <512ns, L1 <4us
            ClockPM- Surprise- LLActRep+ BwNot+
        LnkCtl:    ASPM Disabled; Disabled- CommClk-
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x16, TrErr- Train- SlotClk+
DLActive+ BWMgmt+ ABWMgmt-
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug-
Surprise-
            Slot #3, PowerLimit 0.000W; Interlock- NoCompl-
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
HPIrq- LinkChg-
            Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+
Interlock-
            Changed: MRL- PresDet- LinkState-
        DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-,
OBFF Not Supported ARIFwd-
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-,
OBFF Disabled ARIFwd-
        LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-,
Selectable De-emphasis: -3.5dB
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-
    Kernel driver in use: pcieport

03:00.0 3D controller: NVIDIA Corporation GT200 [GeForce GTX 295] (rev a1)
    Subsystem: NVIDIA Corporation Device 0705
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 9
    Region 0: Memory at f6000000 (32-bit, non-prefetchable) [size=16M]
    Region 1: Memory at e0000000 (64-bit, prefetchable) [size=256M]
    Region 3: Memory at f4000000 (64-bit, non-prefetchable) [size=32M]
    Region 5: I/O ports at 3000 [size=128]
    Expansion ROM at <ignored> [disabled]
    Capabilities: [60] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [68] MSI: Enable- Count=1/1 Maskable- 64bit+
        Address: 0000000000000000  Data: 0000
    Capabilities: [78] Express (v1) Endpoint, MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <1us,
L1 <4us
            ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
            RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
            MaxPayload 128 bytes, MaxReadReq 256 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr-
TransPend-
        LnkCap:    Port #0, Speed 2.5GT/s, Width x16, ASPM L0s L1, Exit
Latency L0s <1us, L1 <1us
            ClockPM- Surprise- LLActRep- BwNot-
        LnkCtl:    ASPM Disabled; RCB 128 bytes Disabled- CommClk-
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x16, TrErr- Train- SlotClk-
DLActive- BWMgmt- ABWMgmt-
    Capabilities: [100 v1] Virtual Channel
        Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
        Arb:    Fixed- WRR32- WRR64- WRR128-
        Ctrl:    ArbSelect=Fixed
        Status:    InProgress-
        VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
            Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
            Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
            Status:    NegoPending- InProgress-
    Capabilities: [128 v1] Power Budgeting <?>
    Capabilities: [600 v1] Vendor Specific Information: ID=0001 Rev=1
Len=024 <?>

04:00.0 VGA compatible controller: NVIDIA Corporation GT200 [GeForce GTX
295] (rev a1) (prog-if 00 [VGA controller])
    Subsystem: NVIDIA Corporation Device 0705
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 11
    Region 0: Memory at f2000000 (32-bit, non-prefetchable) [size=16M]
    Region 1: Memory at d0000000 (64-bit, prefetchable) [size=256M]
    Region 3: Memory at f0000000 (64-bit, non-prefetchable) [size=32M]
    Region 5: I/O ports at 2000 [size=128]
    Expansion ROM at <ignored> [disabled]
    Capabilities: [60] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [68] MSI: Enable- Count=1/1 Maskable- 64bit+
        Address: 0000000000000000  Data: 0000
    Capabilities: [78] Express (v1) Endpoint, MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <1us,
L1 <4us
            ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
            RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
            MaxPayload 128 bytes, MaxReadReq 256 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr-
TransPend-
        LnkCap:    Port #2, Speed 2.5GT/s, Width x16, ASPM L0s L1, Exit
Latency L0s <1us, L1 <1us
            ClockPM- Surprise- LLActRep- BwNot-
        LnkCtl:    ASPM Disabled; RCB 128 bytes Disabled- CommClk-
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x16, TrErr- Train- SlotClk-
DLActive- BWMgmt- ABWMgmt-
    Capabilities: [100 v1] Virtual Channel
        Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
        Arb:    Fixed- WRR32- WRR64- WRR128-
        Ctrl:    ArbSelect=Fixed
        Status:    InProgress-
        VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
            Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
            Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
            Status:    NegoPending- InProgress-
    Capabilities: [128 v1] Power Budgeting <?>
    Capabilities: [600 v1] Vendor Specific Information: ID=0001 Rev=1
Len=024 <?>

06:00.0 IDE interface: Marvell Technology Group Ltd. 88SE6145 SATA II
PCI-E controller (rev a1) (prog-if 8f [Master SecP SecO PriP PriO])
    Subsystem: Intel Corporation Device 424b
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0 (2000ns min), Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 19
    Region 0: I/O ports at 1018 [size=8]
    Region 1: I/O ports at 1024 [size=4]
    Region 2: I/O ports at 1010 [size=8]
    Region 3: I/O ports at 1020 [size=4]
    Region 4: I/O ports at 1000 [size=16]
    Region 5: Memory at f7100000 (32-bit, non-prefetchable) [size=1K]
    Expansion ROM at f7140000 [disabled] [size=256K]
    Capabilities: [48] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0+,D1+,D2-,D3hot+,D3cold-)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
    Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit-
        Address: 00000000  Data: 0000
    Capabilities: [e0] Express (v1) Legacy Endpoint, MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s
unlimited, L1 unlimited
            ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr+ NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 512 bytes
        DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr-
TransPend-
        LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Exit
Latency L0s <256ns, L1 unlimited
            ClockPM- Surprise- LLActRep- BwNot-
        LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
    Capabilities: [100 v1] Advanced Error Reporting
        UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UESvrt:    DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP+ ECRC- UnsupReq- ACSViol-
        CESta:    RxErr+ BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
        CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
        AERCap:    First Error Pointer: 1f, GenCap- CGenEn- ChkCap- ChkEn-
    Kernel driver in use: pata_marvell

07:03.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22A
IEEE-1394a-2000 Controller (PHY/Link) [iOHCI-Lynx] (prog-if 10 [OHCI])
    Subsystem: Intel Corporation Device 424b
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 32 (500ns min, 1000ns max), Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 19
    Region 0: Memory at f7004000 (32-bit, non-prefetchable) [size=2K]
    Region 1: Memory at f7000000 (32-bit, non-prefetchable) [size=16K]
    Capabilities: [44] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME+
    Kernel driver in use: firewire_ohci

3f:00.0 Host bridge: Intel Corporation Core Processor QuickPath
Architecture Generic Non-Core Registers (rev 04)
    Subsystem: Intel Corporation Device 8086
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0

3f:00.1 Host bridge: Intel Corporation Core Processor QuickPath
Architecture System Address Decoder (rev 04)
    Subsystem: Intel Corporation Device 8086
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0

3f:02.0 Host bridge: Intel Corporation Core Processor QPI Link 0 (rev 04)
    Subsystem: Intel Corporation Device 8086
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Kernel driver in use: i7core_edac

3f:02.1 Host bridge: Intel Corporation Core Processor QPI Physical 0
(rev 04)
    Subsystem: Intel Corporation Device 8086
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0

3f:03.0 Host bridge: Intel Corporation Core Processor Integrated Memory
Controller (rev 04)
    Subsystem: Intel Corporation Device 8086
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0

3f:03.1 Host bridge: Intel Corporation Core Processor Integrated Memory
Controller Target Address Decoder (rev 04)
    Subsystem: Intel Corporation Device 8086
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0

3f:03.4 Host bridge: Intel Corporation Core Processor Integrated Memory
Controller Test Registers (rev 04)
    Subsystem: Intel Corporation Device 8086
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0

3f:04.0 Host bridge: Intel Corporation Core Processor Integrated Memory
Controller Channel 0 Control Registers (rev 04)
    Subsystem: Intel Corporation Device 8086
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0

3f:04.1 Host bridge: Intel Corporation Core Processor Integrated Memory
Controller Channel 0 Address Registers (rev 04)
    Subsystem: Intel Corporation Device 8086
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0

3f:04.2 Host bridge: Intel Corporation Core Processor Integrated Memory
Controller Channel 0 Rank Registers (rev 04)
    Subsystem: Intel Corporation Device 8086
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0

3f:04.3 Host bridge: Intel Corporation Core Processor Integrated Memory
Controller Channel 0 Thermal Control Registers (rev 04)
    Subsystem: Intel Corporation Device 8086
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0

3f:05.0 Host bridge: Intel Corporation Core Processor Integrated Memory
Controller Channel 1 Control Registers (rev 04)
    Subsystem: Intel Corporation Device 8086
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0

3f:05.1 Host bridge: Intel Corporation Core Processor Integrated Memory
Controller Channel 1 Address Registers (rev 04)
    Subsystem: Intel Corporation Device 8086
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0

3f:05.2 Host bridge: Intel Corporation Core Processor Integrated Memory
Controller Channel 1 Rank Registers (rev 04)
    Subsystem: Intel Corporation Device 8086
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0

3f:05.3 Host bridge: Intel Corporation Core Processor Integrated Memory
Controller Channel 1 Thermal Control Registers (rev 04)
    Subsystem: Intel Corporation Device 8086
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0

[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices:
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: Corsair Force 3  Rev: 3   
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi3 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: WDC WD2003FZEX-0 Rev: 1A01
  Type:   Direct-Access                    ANSI  SCSI revision: 05
 
[7.7.] Other information that might be relevant to the problem (please
look in /proc and include all information that you think to be relevant):
total 0
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 1
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 10
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 101
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 102
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 103
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 104
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 11
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 1121
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 1125
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 1131
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 1133
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 1136
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 1186
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 1193
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 1195
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 12
dr-xr-xr-x  9 kernoops    adm                      0 Oct  1 13:03 1212
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 123
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 124
dr-xr-xr-x  9 whoopsie    whoopsie                 0 Oct  1 13:03 1250
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 1257
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 1258
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 1259
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 1260
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 1261
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 1262
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 1298
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 13
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 1311
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 1322
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 1325
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 1331
dr-xr-xr-x  9 lxc-dnsmasq dip                      0 Oct  1 13:03 1360
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 14
dr-xr-xr-x  9 root        arifogel                 0 Oct  1 13:04 1461
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 1466
dr-xr-xr-x  9 nobody      dip                      0 Oct  1 13:03 1474
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 15
dr-xr-xr-x  9 root        root                     0 Oct  1 13:14 1593
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 16
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 1645
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 17
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 1715
dr-xr-xr-x  9 rtkit       rtkit                    0 Oct  1 13:03 1722
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 177
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 178
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 179
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 18
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 180
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 181
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 182
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 183
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 184
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 185
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 186
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 187
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 188
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 189
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 19
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 190
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 191
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 196
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 197
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 198
dr-xr-xr-x  9 root        root                     0 Oct  1 13:14 1985
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 199
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 2
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 20
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 200
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 201
dr-xr-xr-x  9 arifogel    arifogel                 0 Oct  1 13:03 2056
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 21
dr-xr-xr-x  9 arifogel    arifogel                 0 Oct  1 13:14 2100
dr-xr-xr-x  9 arifogel    arifogel                 0 Oct  1 13:03 2103
dr-xr-xr-x  9 arifogel    arifogel                 0 Oct  1 13:14 2104
dr-xr-xr-x  9 arifogel    arifogel                 0 Oct  1 13:03 2108
dr-xr-xr-x  9 arifogel    arifogel                 0 Oct  1 13:03 2114
dr-xr-xr-x  9 arifogel    arifogel                 0 Oct  1 13:03 2119
dr-xr-xr-x  9 arifogel    arifogel                 0 Oct  1 13:03 2123
dr-xr-xr-x  9 arifogel    arifogel                 0 Oct  1 13:03 2125
dr-xr-xr-x  9 arifogel    arifogel                 0 Oct  1 13:03 2130
dr-xr-xr-x  9 arifogel    arifogel                 0 Oct  1 13:03 2150
dr-xr-xr-x  9 root        root                     0 Oct  1 13:14 2165
dr-xr-xr-x  9 root        root                     0 Oct  1 13:14 2166
dr-xr-xr-x  9 root        root                     0 Oct  1 13:14 2167
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 22
dr-xr-xr-x  9 root        root                     0 Oct  1 13:04 2203
dr-xr-xr-x  9 arifogel    arifogel                 0 Oct  1 13:14 2274
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 23
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 24
dr-xr-xr-x  9 root        root                     0 Oct  1 13:14 2406
dr-xr-xr-x  9 arifogel    arifogel                 0 Oct  1 13:14 2419
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 25
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 251
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 252
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 26
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 27
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 28
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 29
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 3
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 30
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 31
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 32
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 33
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 34
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 36
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 365
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 37
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 38
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 385
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 39
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 393
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 41
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 42
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 43
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 44
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 45
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 46
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 469
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 47
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 470
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 477
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 48
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 49
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 499
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 5
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 50
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 51
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 511
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 515
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 516
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 52
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 529
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 53
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 533
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 54
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 56
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 57
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 579
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 58
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 580
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 59
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 60
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 609
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 61
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 618
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 62
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 63
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 64
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 65
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 651
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 66
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 661
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 67
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 68
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 69
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 7
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 70
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 71
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 72
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 73
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 74
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 75
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 76
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 77
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 78
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 79
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 8
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 80
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 807
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 81
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 815
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 819
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 82
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 820
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 83
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 84
dr-xr-xr-x  9 messagebus  messagebus               0 Oct  1 13:03 855
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 87
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 88
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 880
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 881
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 89
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 9
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 926
dr-xr-xr-x  9 syslog      syslog                   0 Oct  1 13:03 931
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 945
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 963
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 967
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 974
dr-xr-xr-x  9 root        root                     0 Oct  1 13:03 979
dr-xr-xr-x  9 colord      colord                   0 Oct  1 13:03 983
dr-xr-xr-x  9 lp          lp                       0 Oct  1 13:03 987
dr-xr-xr-x  2 root        root                     0 Oct  1 13:14 acpi
dr-xr-xr-x  6 root        root                     0 Oct  1 13:14 asound
-r--r--r--  1 root        root                     0 Oct  1 13:14 buddyinfo
dr-xr-xr-x  4 root        root                     0 Oct  1 13:14 bus
-r--r--r--  1 root        root                     0 Oct  1 13:14 cgroups
-r--r--r--  1 root        root                     0 Oct  1 13:14 cmdline
-r--r--r--  1 root        root                     0 Oct  1 13:14 consoles
-r--r--r--  1 root        root                     0 Oct  1 13:14 cpuinfo
-r--r--r--  1 root        root                     0 Oct  1 13:14 crypto
-r--r--r--  1 root        root                     0 Oct  1 13:14 devices
-r--r--r--  1 root        root                     0 Oct  1 13:14 diskstats
-r--r--r--  1 root        root                     0 Oct  1 13:14 dma
dr-xr-xr-x  2 root        root                     0 Oct  1 13:14 driver
-r--r--r--  1 root        root                     0 Oct  1 13:14
execdomains
-r--r--r--  1 root        root                     0 Oct  1 13:14 fb
-r--r--r--  1 root        root                     0 Oct  1 13:14
filesystems
dr-xr-xr-x  5 root        root                     0 Oct  1 13:14 fs
-r--r--r--  1 root        root                     0 Oct  1 13:14 interrupts
-r--r--r--  1 root        root                     0 Oct  1 13:14 iomem
-r--r--r--  1 root        root                     0 Oct  1 13:14 ioports
dr-xr-xr-x 31 root        root                     0 Oct  1 13:14 irq
-r--r--r--  1 root        root                     0 Oct  1 13:14 kallsyms
-r--------  1 root        root       140737477881856 Oct  1 13:14 kcore
-r--r--r--  1 root        root                     0 Oct  1 13:14 keys
-r--r--r--  1 root        root                     0 Oct  1 13:14 key-users
-r--------  1 root        root                     0 Oct  1 13:03 kmsg
-r--------  1 root        root                     0 Oct  1 13:14 kpagecount
-r--------  1 root        root                     0 Oct  1 13:14 kpageflags
-r--r--r--  1 root        root                     0 Oct  1 13:14 loadavg
-r--r--r--  1 root        root                     0 Oct  1 13:14 locks
-r--r--r--  1 root        root                     0 Oct  1 13:14 mdstat
-r--r--r--  1 root        root                     0 Oct  1 13:14 meminfo
-r--r--r--  1 root        root                     0 Oct  1 13:14 misc
-r--r--r--  1 root        root                     0 Oct  1 13:14 modules
lrwxrwxrwx  1 root        root                    11 Oct  1 13:14 mounts
-> self/mounts
-rw-r--r--  1 root        root                     0 Oct  1 13:03 mtrr
lrwxrwxrwx  1 root        root                     8 Oct  1 13:14 net ->
self/net
-r--r--r--  1 root        root                     0 Oct  1 13:14
pagetypeinfo
-r--r--r--  1 root        root                     0 Oct  1 13:14 partitions
-r--r--r--  1 root        root                     0 Oct  1 13:14
sched_debug
-r--r--r--  1 root        root                     0 Oct  1 13:14 schedstat
dr-xr-xr-x  3 root        root                     0 Oct  1 13:14 scsi
lrwxrwxrwx  1 root        root                     0 Oct  1 06:03 self
-> 2419
-r--------  1 root        root                     0 Oct  1 13:14 slabinfo
-r--r--r--  1 root        root                     0 Oct  1 13:14 softirqs
-r--r--r--  1 root        root                     0 Oct  1 13:14 stat
-r--r--r--  1 root        root                     0 Oct  1 13:14 swaps
dr-xr-xr-x  1 root        root                     0 Oct  1 06:03 sys
--w-------  1 root        root                     0 Oct  1 13:14
sysrq-trigger
dr-xr-xr-x  2 root        root                     0 Oct  1 13:14 sysvipc
lrwxrwxrwx  1 root        root                     0 Oct  1 06:03
thread-self -> 2419/task/2419
-r--r--r--  1 root        root                     0 Oct  1 13:14 timer_list
-rw-r--r--  1 root        root                     0 Oct  1 13:14
timer_stats
dr-xr-xr-x  4 root        root                     0 Oct  1 13:14 tty
-r--r--r--  1 root        root                     0 Oct  1 13:14 uptime
-r--r--r--  1 root        root                     0 Oct  1 13:14 version
-r--------  1 root        root                     0 Oct  1 13:14
vmallocinfo
-r--r--r--  1 root        root                     0 Oct  1 13:14 vmstat
-r--r--r--  1 root        root                     0 Oct  1 13:14 zoneinfo

[X.] Other notes, patches, fixes, workarounds:
Launchpad Bug Report:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1168224
