From: Robert Ian Hawdon <ian.hawdon@gmail.com>
Subject: Left click sticking when hid-ntrig is enabled
Date: Fri, 28 Sep 2012 18:29:04 +0100
Message-ID: <5065DE60.9060200@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig02CC89CF417C62A8C6ED4DE5"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:45759 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758326Ab2I1R3J (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Sep 2012 13:29:09 -0400
Received: by eaac13 with SMTP id c13so1123496eaa.19
        for <linux-input@vger.kernel.org>; Fri, 28 Sep 2012 10:29:07 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: 1047611@bugs.launchpad.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig02CC89CF417C62A8C6ED4DE5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

[1.] Left click sticking when hid-ntrig is enabled

[2.] (A direct quote from the original bug report I filed on Ubuntu's
launchpad:)

I'm sorry but I have no idea where this bug is originating from, but was
introduced in Ubuntu 12.04 LTS.

The problem I'm having is:

When I first log into my machine, everything is fine, but after a while,
and for no apparent reason, some applications start acting stangely.
Nautilus doesn't always react to my clicks when opening files or
folders, once I finally am able to open a folder, an icon in the same
place can be clicked on, whereas others are very un responsive.

Some applications which have selectable texts in them (again, Nautilus's
Help --> About is a good example), when running my mouse over it, will
highlight the text until I click. Then the text is deselected, but will
start highlighting again when the mouse is run over it.

In places where there are "on/off" switches (Ubuntu settings program for
example), moving my mouse over one of these switches will slide the
switch across, (e.g. from off to on), but doesn't actually release, so
no setting is changed.

The hardware I'm using is an HP Touchsmart TX2 notebook, with a
synaptics touchpad and an ntrig duo touch screen. The bug affects all
three inputs (touchpad, touchscreen and pen input). I'm using the Radeon
graphics driver.

IMPORTANT NOTE

This does not seem to affect KDE applications, but only apps running
though GTK3. In GTK2 apps (such as Pidgin), right clicking is unavailable=
=2E

Logging out and logging in fixes the issue temporally, but will later
return. It's almost as if the system thinks the left mouse button is
pressed down, but only on some apps.

The bug is present in 12.04 LTS 12.04.1 and 12.10 Beta 1

Cheers

[3.] Touchscreen, hid, ubuntu, click,

[4.] Linux version 3.6.0-030600rc7-generic (apw@gomeisa) (gcc version
4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201209232235 SMP Mon Sep 24
02:36:02 UTC 2012

[5.] Not Applicable

[6.] Not Applicable

[7.] Description:    Ubuntu 12.04.1 LTS
Release:    12.04

[7.1.] If some fields are empty or look unusual you may have an old versi=
on.
Compare to the current minimal requirements in Documentation/Changes.

Linux ian-HP-TouchSmart-tx2-Notebook-PC 3.6.0-030600rc7-generic
#201209232235 SMP Mon Sep 24 02:36:02 UTC 2012 x86_64 x86_64 x86_64
GNU/Linux

Gnu C                  4.6
Gnu make               3.81
binutils               2.22
util-linux             2.20.1
mount                  support
module-init-tools      3.16
e2fsprogs              1.42
pcmciautils            018
PPP                    2.4.5
Linux C Library        2.15
Dynamic linker (ldd)   2.15
Procps                 3.2.8
Net-tools              1.60
Kbd                    1.15.2
Sh-utils               8.13
wireless-tools         30
Modules Loaded         parport_pc rfcomm ppdev bnep binfmt_misc arc4
snd_hda_codec_si3054 b43 snd_hda_codec_realtek hp_wmi snd_hda_intel
snd_hda_codec joydev sparse_keymap radeon mac80211 kvm_amd snd_hwdep
snd_pcm snd_seq_midi snd_rawmidi kvm snd_seq_midi_event uvcvideo ttm
snd_seq drm_kms_helper btusb videobuf2_core snd_timer hid_ntrig
snd_seq_device drm snd videodev bluetooth cfg80211 psmouse
videobuf2_vmalloc videobuf2_memops microcode k10temp serio_raw soundcore
sp5100_tco wmi video snd_page_alloc i2c_algo_bit i2c_piix4 mac_hid
shpchp acpiphp bcma lp parport usbhid hid ums_realtek uas r8169 ssb
usb_storage

[7.2.] processor    : 0
vendor_id    : AuthenticAMD
cpu family    : 17
model        : 3
model name    : AMD Turion(tm) X2 Dual-Core Mobile RM-77
stepping    : 1
microcode    : 0x2000057
cpu MHz        : 575.000
cache size    : 512 KB
physical id    : 0
siblings    : 2
core id        : 0
cpu cores    : 2
apicid        : 0
initial apicid    : 0
fpu        : yes
fpu_exception    : yes
cpuid level    : 1
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
rdtscp lm 3dnowext 3dnow constant_tsc rep_good nopl nonstop_tsc
extd_apicid pni cx16 lahf_lm cmp_legacy svm extapic cr8_legacy
3dnowprefetch osvw skinit hw_pstate lbrv svm_lock nrip_save
bogomips    : 4600.23
TLB size    : 1024 4K pages
clflush size    : 64
cache_alignment    : 64
address sizes    : 40 bits physical, 48 bits virtual
power management: ts ttp tm stc 100mhzsteps hwpstate

processor    : 1
vendor_id    : AuthenticAMD
cpu family    : 17
model        : 3
model name    : AMD Turion(tm) X2 Dual-Core Mobile RM-77
stepping    : 1
microcode    : 0x2000057
cpu MHz        : 575.000
cache size    : 512 KB
physical id    : 0
siblings    : 2
core id        : 1
cpu cores    : 2
apicid        : 1
initial apicid    : 1
fpu        : yes
fpu_exception    : yes
cpuid level    : 1
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
rdtscp lm 3dnowext 3dnow constant_tsc rep_good nopl nonstop_tsc
extd_apicid pni cx16 lahf_lm cmp_legacy svm extapic cr8_legacy
3dnowprefetch osvw skinit hw_pstate lbrv svm_lock nrip_save
bogomips    : 4600.23
TLB size    : 1024 4K pages
clflush size    : 64
cache_alignment    : 64
address sizes    : 40 bits physical, 48 bits virtual
power management: ts ttp tm stc 100mhzsteps hwpstate

[7.3.] parport_pc 32866 0 - Live 0x0000000000000000
rfcomm 47922 12 - Live 0x0000000000000000
ppdev 17113 0 - Live 0x0000000000000000
bnep 18315 2 - Live 0x0000000000000000
binfmt_misc 17540 1 - Live 0x0000000000000000
arc4 12573 2 - Live 0x0000000000000000
snd_hda_codec_si3054 13008 1 - Live 0x0000000000000000
b43 378820 0 - Live 0x0000000000000000
snd_hda_codec_realtek 79668 1 - Live 0x0000000000000000
hp_wmi 18092 0 - Live 0x0000000000000000
snd_hda_intel 34147 6 - Live 0x0000000000000000
snd_hda_codec 135374 3
snd_hda_codec_si3054,snd_hda_codec_realtek,snd_hda_intel, Live
0x0000000000000000
joydev 17693 0 - Live 0x0000000000000000
sparse_keymap 13890 1 hp_wmi, Live 0x0000000000000000
radeon 917652 3 - Live 0x0000000000000000
mac80211 564631 1 b43, Live 0x0000000000000000
kvm_amd 56135 0 - Live 0x0000000000000000
snd_hwdep 13668 1 snd_hda_codec, Live 0x0000000000000000
snd_pcm 97661 5 snd_hda_codec_si3054,snd_hda_intel,snd_hda_codec, Live
0x0000000000000000
snd_seq_midi 13324 0 - Live 0x0000000000000000
snd_rawmidi 30749 1 snd_seq_midi, Live 0x0000000000000000
kvm 437435 1 kvm_amd, Live 0x0000000000000000
snd_seq_midi_event 14899 1 snd_seq_midi, Live 0x0000000000000000
uvcvideo 82212 0 - Live 0x0000000000000000
ttm 88492 1 radeon, Live 0x0000000000000000
snd_seq 61897 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
drm_kms_helper 46931 1 radeon, Live 0x0000000000000000
btusb 18291 0 - Live 0x0000000000000000
videobuf2_core 36094 1 uvcvideo, Live 0x0000000000000000
snd_timer 29989 2 snd_pcm,snd_seq, Live 0x0000000000000000
hid_ntrig 19011 0 - Live 0x0000000000000000
snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live
0x0000000000000000
drm 277074 5 radeon,ttm,drm_kms_helper, Live 0x0000000000000000
snd 79391 20
snd_hda_codec_si3054,snd_hda_codec_realtek,snd_hda_intel,snd_hda_codec,sn=
d_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_timer,snd_seq_device,
Live 0x0000000000000000
videodev 120715 2 uvcvideo,videobuf2_core, Live 0x0000000000000000
bluetooth 218450 24 rfcomm,bnep,btusb, Live 0x0000000000000000
cfg80211 212917 2 b43,mac80211, Live 0x0000000000000000
psmouse 92362 0 - Live 0x0000000000000000
videobuf2_vmalloc 12860 1 uvcvideo, Live 0x0000000000000000
videobuf2_memops 13368 1 videobuf2_vmalloc, Live 0x0000000000000000
microcode 23040 0 - Live 0x0000000000000000
k10temp 13173 0 - Live 0x0000000000000000
serio_raw 13215 0 - Live 0x0000000000000000
soundcore 15091 1 snd, Live 0x0000000000000000
sp5100_tco 13791 0 - Live 0x0000000000000000
wmi 19256 1 hp_wmi, Live 0x0000000000000000
video 19412 0 - Live 0x0000000000000000
snd_page_alloc 18572 2 snd_hda_intel,snd_pcm, Live 0x0000000000000000
i2c_algo_bit 13564 1 radeon, Live 0x0000000000000000
i2c_piix4 13504 0 - Live 0x0000000000000000
mac_hid 13253 0 - Live 0x0000000000000000
shpchp 37277 0 - Live 0x0000000000000000
acpiphp 24201 0 - Live 0x0000000000000000
bcma 40174 1 b43, Live 0x0000000000000000
lp 17799 0 - Live 0x0000000000000000
parport 46562 3 parport_pc,ppdev,lp, Live 0x0000000000000000
usbhid 47307 1 hid_ntrig, Live 0x0000000000000000
hid 100579 2 hid_ntrig,usbhid, Live 0x0000000000000000
ums_realtek 18256 0 - Live 0x0000000000000000
uas 18274 0 - Live 0x0000000000000000
r8169 68885 0 - Live 0x0000000000000000
ssb 52833 1 b43, Live 0x0000000000000000
usb_storage 49287 1 ums_realtek, Live 0x0000000000000000

[7.4.] ian@ian-HP-TouchSmart-tx2-Notebook-PC:~$ cat /proc/ioports
0000-0cf7 : PCI Bus 0000:00
  0000-001f : dma1
  0020-0021 : pic1
  0040-0043 : timer0
  0050-0053 : timer1
  0060-0060 : keyboard
  0062-0062 : EC data
  0064-0064 : keyboard
  0066-0066 : EC cmd
  0070-0071 : rtc0
  0080-008f : dma page reg
  00a0-00a1 : pic2
  00c0-00df : dma2
  00f0-00ff : fpu
  0170-0177 : 0000:00:14.1
    0170-0177 : pata_acpi
  01f0-01f7 : 0000:00:14.1
    01f0-01f7 : pata_acpi
  0376-0376 : 0000:00:14.1
    0376-0376 : pata_acpi
  03f6-03f6 : 0000:00:14.1
    03f6-03f6 : pata_acpi
  0400-04cf : pnp 00:09
    0400-0403 : ACPI PM1a_EVT_BLK
    0404-0405 : ACPI PM1a_CNT_BLK
    0408-040b : ACPI PM_TMR
    0410-0415 : ACPI CPU throttle
    0420-0427 : ACPI GPE0_BLK
  04d0-04d1 : pnp 00:09
  04d6-04d6 : pnp 00:09
  0680-06ff : pnp 00:09
  077a-077a : pnp 00:09
  0800-0800 : ACPI PM2_CNT_BLK
  0b00-0b07 : piix4_smbus
  0b20-0b27 : piix4_smbus
  0c00-0c01 : pnp 00:09
  0c14-0c14 : pnp 00:09
  0c50-0c52 : pnp 00:09
  0c6c-0c6c : pnp 00:09
  0c6f-0c6f : pnp 00:09
  0cd0-0cdb : pnp 00:09
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
  1000-1fff : PCI Bus 0000:80
  2000-2fff : PCI Bus 0000:09
    2000-20ff : 0000:09:00.0
      2000-20ff : r8169
  3000-4fff : PCI Bus 0000:02
  5000-5fff : PCI Bus 0000:01
    5000-50ff : 0000:01:05.0
  6000-600f : 0000:00:14.1
    6000-600f : pata_acpi
  6010-601f : 0000:00:11.0
    6010-601f : ahci
  6030-6037 : 0000:00:11.0
    6030-6037 : ahci
  6038-603f : 0000:00:11.0
    6038-603f : ahci
  6048-604b : 0000:00:11.0
    6048-604b : ahci
  604c-604f : 0000:00:11.0
    604c-604f : ahci
ian@ian-HP-TouchSmart-tx2-Notebook-PC:~$ cat /proc/iomem
00000000-0000ffff : reserved
00010000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000cedff : Video ROM
  000c0000-000c3fff : PCI Bus 0000:00
  000c4000-000c7fff : PCI Bus 0000:00
  000c8000-000cbfff : PCI Bus 0000:00
000d0000-000d3fff : PCI Bus 0000:00
000d4000-000d7fff : PCI Bus 0000:00
000d8000-000dbfff : PCI Bus 0000:00
000dc000-000dffff : PCI Bus 0000:00
000e0000-000fffff : reserved
  000e0000-000e3fff : PCI Bus 0000:00
  000e4000-000e7fff : PCI Bus 0000:00
  000e8000-000ebfff : PCI Bus 0000:00
  000ec000-000effff : PCI Bus 0000:00
  000f0000-000fffff : System ROM
00100000-afb8efff : System RAM
  01000000-016ab05a : Kernel code
  016ab05b-01ce107f : Kernel data
  01dd7000-01f31fff : Kernel bss
afb8f000-afc3bfff : ACPI Non-volatile Storage
afc3c000-afd6ffff : System RAM
afd70000-afdbefff : reserved
afdbf000-afe56fff : System RAM
afe57000-afebefff : ACPI Non-volatile Storage
afebf000-afee8fff : System RAM
afee9000-afefefff : ACPI Tables
afeff000-afefffff : System RAM
aff00000-afffffff : RAM buffer
c0000000-dfffffff : PCI Bus 0000:00
  c0000000-cfffffff : PCI Bus 0000:01
    c0000000-cfffffff : 0000:01:05.0
  d0000000-d0ffffff : PCI Bus 0000:02
  d1000000-d10fffff : PCI Bus 0000:09
    d1000000-d100ffff : 0000:09:00.0
      d1000000-d100ffff : r8169
    d1010000-d1010fff : 0000:09:00.0
      d1010000-d1010fff : r8169
    d1020000-d102ffff : 0000:09:00.0
  d1100000-d11fffff : PCI Bus 0000:08
    d1100000-d1103fff : 0000:08:00.0
      d1100000-d1103fff : 0000:08:00.0
  d1200000-d21fffff : PCI Bus 0000:02
  d2200000-d23fffff : PCI Bus 0000:01
    d2200000-d22fffff : 0000:01:05.0
    d2300000-d230ffff : 0000:01:05.0
  d2400000-d2403fff : 0000:00:14.2
    d2400000-d2403fff : ICH HD audio
  d2404000-d2404fff : 0000:00:14.5
    d2404000-d2404fff : ohci_hcd
  d2405000-d2405fff : 0000:00:13.1
    d2405000-d2405fff : ohci_hcd
  d2406000-d2406fff : 0000:00:13.0
    d2406000-d2406fff : ohci_hcd
  d2407000-d2407fff : 0000:00:12.1
    d2407000-d2407fff : ohci_hcd
  d2408000-d2408fff : 0000:00:12.0
    d2408000-d2408fff : ohci_hcd
  d2409000-d24093ff : 0000:00:11.0
    d2409000-d24093ff : ahci
  d2409400-d24094ff : 0000:00:13.2
    d2409400-d24094ff : ehci_hcd
  d2409500-d24095ff : 0000:00:12.2
    d2409500-d24095ff : ehci_hcd
  d2500000-d25fffff : PCI Bus 0000:09
e0000000-e3ffffff : PCI MMCONFIG 0000 [bus 00-3f]
  e0000000-e3ffffff : reserved
e4000000-ffffffff : PCI Bus 0000:00
  fec00000-fec00fff : reserved
    fec00000-fec003ff : IOAPIC 0
  fed00000-fed003ff : HPET 0
  fee00000-fee00fff : Local APIC
    fee00000-fee00fff : reserved
      fee00000-fee00fff : pnp 00:01
  fff00000-ffffffff : reserved
    fff00000-ffffffff : pnp 00:0a
100000000-13fffffff : System RAM

[7.5.] 00:00.0 Host bridge: Advanced Micro Devices [AMD] RS780 Host Bridg=
e
    Subsystem: Hewlett-Packard Company Device 3045
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR- INTx-
    Latency: 0
    Capabilities: [c4] HyperTransport: Slave or Primary Interface
        Command: BaseUnitID=3D0 UnitCnt=3D12 MastHost- DefDir- DUL-
        Link Control 0: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO-
<CRCErr=3D0 IsocEn- LSEn- ExtCTL- 64b-
        Link Config 0: MLWI=3D16bit DwFcIn- MLWO=3D16bit DwFcOut- LWI=3D1=
6bit
DwFcInEn- LWO=3D16bit DwFcOutEn-
        Link Control 1: CFlE- CST- CFE- <LkFail+ Init- EOC+ TXO+
<CRCErr=3D0 IsocEn- LSEn- ExtCTL- 64b-
        Link Config 1: MLWI=3D8bit DwFcIn- MLWO=3D8bit DwFcOut- LWI=3D8bi=
t
DwFcInEn- LWO=3D8bit DwFcOutEn-
        Revision ID: 3.00
        Link Frequency 0: [b]
        Link Error 0: <Prot- <Ovfl- <EOC- CTLTm-
        Link Frequency Capability 0: 200MHz+ 300MHz- 400MHz+ 500MHz-
600MHz+ 800MHz+ 1.0GHz+ 1.2GHz- 1.4GHz- 1.6GHz- Vend-
        Feature Capability: IsocFC- LDTSTOP+ CRCTM- ECTLT- 64bA- UIDRD-
        Link Frequency 1: 200MHz
        Link Error 1: <Prot- <Ovfl- <EOC- CTLTm-
        Link Frequency Capability 1: 200MHz- 300MHz- 400MHz- 500MHz-
600MHz- 800MHz- 1.0GHz- 1.2GHz- 1.4GHz- 1.6GHz- Vend-
        Error Handling: PFlE- OFlE- PFE- OFE- EOCFE- RFE- CRCFE- SERRFE-
CF- RE- PNFE- ONFE- EOCNFE- RNFE- CRCNFE- SERRNFE-
        Prefetchable memory behind bridge Upper: 00-00
        Bus Number: 00
    Capabilities: [54] HyperTransport: UnitID Clumping
    Capabilities: [40] HyperTransport: Retry Mode
    Capabilities: [9c] HyperTransport: #1a
    Capabilities: [f8] HyperTransport: #1c

00:01.0 PCI bridge: Advanced Micro Devices [AMD] RS780/RS880 PCI to PCI
bridge (int gfx) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 64
    Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
    I/O behind bridge: 00005000-00005fff
    Memory behind bridge: d2200000-d23fffff
    Prefetchable memory behind bridge: 00000000c0000000-00000000cfffffff
    Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [44] HyperTransport: MSI Mapping Enable+ Fixed+
    Capabilities: [b0] Subsystem: Advanced Micro Devices [AMD]
RS780/RS880 PCI to PCI bridge (int gfx)
    Kernel modules: shpchp

00:04.0 PCI bridge: Advanced Micro Devices [AMD] RS780/RS880 PCI to PCI
bridge (PCIE port 0) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Bus: primary=3D00, secondary=3D02, subordinate=3D07, sec-latency=3D0
    I/O behind bridge: 00003000-00004fff
    Memory behind bridge: d1200000-d21fffff
    Prefetchable memory behind bridge: 00000000d0000000-00000000d0ffffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [50] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
    Capabilities: [58] Express (v2) Root Port (Slot+), MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns,
L1 <1us
            ExtTag+ RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
            RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr-
TransPend-
        LnkCap:    Port #247, Speed 5GT/s, Width x1, ASPM L0s L1,
Latency L0 <64ns, L1 <1us
            ClockPM- Surprise- LLActRep+ BwNot+
        LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk=
-
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed unknown, Width x16, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+
Surprise+
            Slot #4, PowerLimit 25.000W; Interlock- NoCompl+
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
HPIrq- LinkChg-
            Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet-
Interlock-
            Changed: MRL- PresDet- LinkState-
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
CRSVisible-
        RootCap: CRSVisible-
        RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        DevCap2: Completion Timeout: Not Supported, TimeoutDis- ARIFwd-
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-,
Selectable De-emphasis: -6dB
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB
    Capabilities: [a0] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
        Address: fee0300c  Data: 4181
    Capabilities: [b0] Subsystem: Hewlett-Packard Company Device 3045
    Capabilities: [b8] HyperTransport: MSI Mapping Enable+ Fixed+
    Capabilities: [100 v1] Vendor Specific Information: ID=3D0001 Rev=3D1=

Len=3D010 <?>
    Capabilities: [110 v1] Virtual Channel
        Caps:    LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
        Arb:    Fixed- WRR32- WRR64- WRR128-
        Ctrl:    ArbSelect=3DFixed
        Status:    InProgress-
        VC0:    Caps:    PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
            Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
            Ctrl:    Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3Dff
            Status:    NegoPending- InProgress-
    Kernel driver in use: pcieport
    Kernel modules: shpchp

00:05.0 PCI bridge: Advanced Micro Devices [AMD] RS780/RS880 PCI to PCI
bridge (PCIE port 1) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Bus: primary=3D00, secondary=3D08, subordinate=3D08, sec-latency=3D0
    I/O behind bridge: 0000f000-00000fff
    Memory behind bridge: d1100000-d11fffff
    Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [50] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
    Capabilities: [58] Express (v2) Root Port (Slot+), MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns,
L1 <1us
            ExtTag+ RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
            RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr-
TransPend-
        LnkCap:    Port #2, Speed 5GT/s, Width x1, ASPM L0s L1, Latency
L0 <64ns, L1 <1us
            ClockPM- Surprise- LLActRep+ BwNot+
        LnkCtl:    ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain-
CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive+ BWMgmt+ ABWMgmt-
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug-
Surprise-
            Slot #5, PowerLimit 25.000W; Interlock- NoCompl+
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
HPIrq- LinkChg-
            Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+
Interlock-
            Changed: MRL- PresDet+ LinkState+
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
CRSVisible-
        RootCap: CRSVisible-
        RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        DevCap2: Completion Timeout: Not Supported, TimeoutDis- ARIFwd-
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-,
Selectable De-emphasis: -6dB
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB
    Capabilities: [a0] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
        Address: fee0300c  Data: 4191
    Capabilities: [b0] Subsystem: Hewlett-Packard Company Device 3045
    Capabilities: [b8] HyperTransport: MSI Mapping Enable+ Fixed+
    Capabilities: [100 v1] Vendor Specific Information: ID=3D0001 Rev=3D1=

Len=3D010 <?>
    Capabilities: [110 v1] Virtual Channel
        Caps:    LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
        Arb:    Fixed- WRR32- WRR64- WRR128-
        Ctrl:    ArbSelect=3DFixed
        Status:    InProgress-
        VC0:    Caps:    PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
            Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
            Ctrl:    Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3Dff
            Status:    NegoPending- InProgress-
    Kernel driver in use: pcieport
    Kernel modules: shpchp

00:06.0 PCI bridge: Advanced Micro Devices [AMD] RS780 PCI to PCI bridge
(PCIE port 2) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Bus: primary=3D00, secondary=3D09, subordinate=3D09, sec-latency=3D0
    I/O behind bridge: 00002000-00002fff
    Memory behind bridge: d2500000-d25fffff
    Prefetchable memory behind bridge: 00000000d1000000-00000000d10fffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [50] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
    Capabilities: [58] Express (v2) Root Port (Slot+), MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns,
L1 <1us
            ExtTag+ RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
            RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr-
TransPend-
        LnkCap:    Port #3, Speed 5GT/s, Width x1, ASPM L0s L1, Latency
L0 <64ns, L1 <1us
            ClockPM- Surprise- LLActRep+ BwNot+
        LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk=
+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive+ BWMgmt+ ABWMgmt-
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug-
Surprise-
            Slot #6, PowerLimit 25.000W; Interlock- NoCompl+
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
HPIrq- LinkChg-
            Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+
Interlock-
            Changed: MRL- PresDet+ LinkState+
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
CRSVisible-
        RootCap: CRSVisible-
        RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        DevCap2: Completion Timeout: Not Supported, TimeoutDis- ARIFwd-
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-,
Selectable De-emphasis: -6dB
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB
    Capabilities: [a0] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
        Address: fee0300c  Data: 41a1
    Capabilities: [b0] Subsystem: Hewlett-Packard Company Device 3045
    Capabilities: [b8] HyperTransport: MSI Mapping Enable+ Fixed+
    Capabilities: [100 v1] Vendor Specific Information: ID=3D0001 Rev=3D1=

Len=3D010 <?>
    Capabilities: [110 v1] Virtual Channel
        Caps:    LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
        Arb:    Fixed- WRR32- WRR64- WRR128-
        Ctrl:    ArbSelect=3DFixed
        Status:    InProgress-
        VC0:    Caps:    PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
            Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
            Ctrl:    Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3Dff
            Status:    NegoPending- InProgress-
    Kernel driver in use: pcieport
    Kernel modules: shpchp

00:11.0 SATA controller: Advanced Micro Devices [AMD] nee ATI
SB7x0/SB8x0/SB9x0 SATA Controller [AHCI mode] (prog-if 01 [AHCI 1.0])
    Subsystem: Hewlett-Packard Company Device 3045
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 64, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 22
    Region 0: I/O ports at 6038 [size=3D8]
    Region 1: I/O ports at 604c [size=3D4]
    Region 2: I/O ports at 6030 [size=3D8]
    Region 3: I/O ports at 6048 [size=3D4]
    Region 4: I/O ports at 6010 [size=3D16]
    Region 5: Memory at d2409000 (32-bit, non-prefetchable) [size=3D1K]
    Capabilities: [60] Power Management version 2
        Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
    Capabilities: [70] SATA HBA v1.0 InCfgSpace
    Kernel driver in use: ahci

00:12.0 USB controller: Advanced Micro Devices [AMD] nee ATI
SB7x0/SB8x0/SB9x0 USB OHCI0 Controller (prog-if 10 [OHCI])
    Subsystem: Hewlett-Packard Company Device 3045
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 64
    Interrupt: pin A routed to IRQ 16
    Region 0: Memory at d2408000 (32-bit, non-prefetchable) [size=3D4K]
    Kernel driver in use: ohci_hcd

00:12.1 USB controller: Advanced Micro Devices [AMD] nee ATI SB7x0 USB
OHCI1 Controller (prog-if 10 [OHCI])
    Subsystem: Hewlett-Packard Company Device 3045
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 64
    Interrupt: pin A routed to IRQ 16
    Region 0: Memory at d2407000 (32-bit, non-prefetchable) [size=3D4K]
    Kernel driver in use: ohci_hcd

00:12.2 USB controller: Advanced Micro Devices [AMD] nee ATI
SB7x0/SB8x0/SB9x0 USB EHCI Controller (prog-if 20 [EHCI])
    Subsystem: Hewlett-Packard Company Device 3045
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 64, Cache Line Size: 64 bytes
    Interrupt: pin B routed to IRQ 17
    Region 0: Memory at d2409500 (32-bit, non-prefetchable) [size=3D256]
    Capabilities: [c0] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
        Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
        Bridge: PM- B3+
    Capabilities: [e4] Debug port: BAR=3D1 offset=3D00e0
    Kernel driver in use: ehci_hcd

00:13.0 USB controller: Advanced Micro Devices [AMD] nee ATI
SB7x0/SB8x0/SB9x0 USB OHCI0 Controller (prog-if 10 [OHCI])
    Subsystem: Hewlett-Packard Company Device 3045
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 64
    Interrupt: pin A routed to IRQ 18
    Region 0: Memory at d2406000 (32-bit, non-prefetchable) [size=3D4K]
    Kernel driver in use: ohci_hcd

00:13.1 USB controller: Advanced Micro Devices [AMD] nee ATI SB7x0 USB
OHCI1 Controller (prog-if 10 [OHCI])
    Subsystem: Hewlett-Packard Company Device 3045
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 64
    Interrupt: pin A routed to IRQ 18
    Region 0: Memory at d2405000 (32-bit, non-prefetchable) [size=3D4K]
    Kernel driver in use: ohci_hcd

00:13.2 USB controller: Advanced Micro Devices [AMD] nee ATI
SB7x0/SB8x0/SB9x0 USB EHCI Controller (prog-if 20 [EHCI])
    Subsystem: Hewlett-Packard Company Device 3045
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 64, Cache Line Size: 64 bytes
    Interrupt: pin B routed to IRQ 19
    Region 0: Memory at d2409400 (32-bit, non-prefetchable) [size=3D256]
    Capabilities: [c0] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
        Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
        Bridge: PM- B3+
    Capabilities: [e4] Debug port: BAR=3D1 offset=3D00e0
    Kernel driver in use: ehci_hcd

00:14.0 SMBus: Advanced Micro Devices [AMD] nee ATI SBx00 SMBus
Controller (rev 3a)
    Subsystem: Hewlett-Packard Company Device 3045
    Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort+ <MAbort- >SERR+ <PERR+ INTx-
    Capabilities: [b0] HyperTransport: MSI Mapping Enable- Fixed+
    Kernel driver in use: piix4_smbus
    Kernel modules: sp5100_tco, i2c-piix4

00:14.1 IDE interface: Advanced Micro Devices [AMD] nee ATI
SB7x0/SB8x0/SB9x0 IDE Controller (prog-if 80 [Master])
    Subsystem: Hewlett-Packard Company Device 3045
    Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 64
    Interrupt: pin A routed to IRQ 16
    Region 0: I/O ports at 01f0 [size=3D8]
    Region 1: I/O ports at 03f4 [size=3D1]
    Region 2: I/O ports at 0170 [size=3D8]
    Region 3: I/O ports at 0374 [size=3D1]
    Region 4: I/O ports at 6000 [size=3D16]
    Capabilities: [70] MSI: Enable- Count=3D1/1 Maskable- 64bit-
        Address: 00000000  Data: 0000
    Kernel driver in use: pata_acpi
    Kernel modules: pata_atiixp

00:14.2 Audio device: Advanced Micro Devices [AMD] nee ATI SBx00 Azalia
(Intel HDA)
    Subsystem: Hewlett-Packard Company Device 3045
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dslow >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 64
    Interrupt: pin A routed to IRQ 16
    Region 0: Memory at d2400000 (64-bit, non-prefetchable) [size=3D16K]
    Capabilities: [50] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D55mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
    Kernel driver in use: snd_hda_intel
    Kernel modules: snd-hda-intel

00:14.3 ISA bridge: Advanced Micro Devices [AMD] nee ATI
SB7x0/SB8x0/SB9x0 LPC host controller
    Subsystem: Hewlett-Packard Company Device 3045
    Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0

00:14.4 PCI bridge: Advanced Micro Devices [AMD] nee ATI SBx00 PCI to
PCI Bridge (prog-if 01 [Subtractive decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 64
    Bus: primary=3D00, secondary=3D80, subordinate=3D8f, sec-latency=3D64=

    I/O behind bridge: 00001000-00001fff
    Memory behind bridge: fff00000-000fffff
    Prefetchable memory behind bridge: fff00000-000fffff
    Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-

00:14.5 USB controller: Advanced Micro Devices [AMD] nee ATI
SB7x0/SB8x0/SB9x0 USB OHCI2 Controller (prog-if 10 [OHCI])
    Subsystem: Hewlett-Packard Company Device 3045
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 64
    Interrupt: pin C routed to IRQ 18
    Region 0: Memory at d2404000 (32-bit, non-prefetchable) [size=3D4K]
    Kernel driver in use: ohci_hcd

00:18.0 Host bridge: Advanced Micro Devices [AMD] Family 11h Processor
HyperTransport Configuration (rev 40)
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Capabilities: [80] HyperTransport: Host or Secondary Interface
        Command: WarmRst+ DblEnd- DevNum=3D0 ChainSide- HostHide+ Slave-
<EOCErr- DUL-
        Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=3D=
0
IsocEn- LSEn+ ExtCTL- 64b-
        Link Config: MLWI=3D16bit DwFcIn- MLWO=3D16bit DwFcOut- LWI=3D16b=
it
DwFcInEn- LWO=3D16bit DwFcOutEn-
        Revision ID: 3.00
        Link Frequency: [b]
        Link Error: <Prot- <Ovfl- <EOC- CTLTm-
        Link Frequency Capability: 200MHz+ 300MHz- 400MHz+ 500MHz-
600MHz+ 800MHz+ 1.0GHz+ 1.2GHz+ 1.4GHz- 1.6GHz- Vend-
        Feature Capability: IsocFC+ LDTSTOP+ CRCTM- ECTLT- 64bA- UIDRD-
ExtRS- UCnfE-

00:18.1 Host bridge: Advanced Micro Devices [AMD] Family 11h Processor
Address Map
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:18.2 Host bridge: Advanced Micro Devices [AMD] Family 11h Processor
DRAM Controller
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:18.3 Host bridge: Advanced Micro Devices [AMD] Family 11h Processor
Miscellaneous Control
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Capabilities: [f0] Secure device <?>
    Kernel driver in use: k10temp
    Kernel modules: k10temp

00:18.4 Host bridge: Advanced Micro Devices [AMD] Family 11h Processor
Link Control
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

01:05.0 VGA compatible controller: Advanced Micro Devices [AMD] nee ATI
RS780M/RS780MN [Mobility Radeon HD 3200 Graphics] (prog-if 00 [VGA
controller])
    Subsystem: Hewlett-Packard Company Device 3045
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 18
    Region 0: Memory at c0000000 (32-bit, prefetchable) [size=3D256M]
    Region 1: I/O ports at 5000 [size=3D256]
    Region 2: Memory at d2300000 (32-bit, non-prefetchable) [size=3D64K]
    Region 5: Memory at d2200000 (32-bit, non-prefetchable) [size=3D1M]
    Expansion ROM at <unassigned> [disabled]
    Capabilities: [50] Power Management version 3
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
    Capabilities: [a0] MSI: Enable- Count=3D1/1 Maskable- 64bit+
        Address: 0000000000000000  Data: 0000
    Kernel driver in use: radeon
    Kernel modules: radeon

08:00.0 Network controller: Broadcom Corporation BCM4312 802.11b/g
LP-PHY (rev 01)
    Subsystem: Hewlett-Packard Company BCM4312 802.11b/g Wireless LAN
Controller
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 17
    Region 0: Memory at d1100000 (64-bit, non-prefetchable) [size=3D16K]
    Capabilities: [40] Power Management version 3
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D2 PME-
    Capabilities: [58] Vendor Specific Information: Len=3D78 <?>
    Capabilities: [e8] MSI: Enable- Count=3D1/1 Maskable- 64bit+
        Address: 0000000000000000  Data: 0000
    Capabilities: [d0] Express (v1) Endpoint, MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us,
L1 unlimited
            ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr-
TransPend-
        LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Latency L0 <4us, L1 <64us
            ClockPM- Surprise- LLActRep- BwNot-
        LnkCtl:    ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain-
CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
    Capabilities: [100 v1] Advanced Error Reporting
        UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UESvrt:    DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
        CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+=

        CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+=

        AERCap:    First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn=
-
    Capabilities: [13c v1] Virtual Channel
        Caps:    LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
        Arb:    Fixed- WRR32- WRR64- WRR128-
        Ctrl:    ArbSelect=3DFixed
        Status:    InProgress-
        VC0:    Caps:    PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
            Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
            Ctrl:    Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3Dff
            Status:    NegoPending- InProgress-
    Capabilities: [160 v1] Device Serial Number ba-6c-82-ff-ff-30-00-26
    Capabilities: [16c v1] Power Budgeting <?>
    Kernel driver in use: b43-pci-bridge
    Kernel modules: ssb

09:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL8111/8168B PCI Express Gigabit Ethernet controller (rev 02)
    Subsystem: Hewlett-Packard Company Device 3045
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 43
    Region 0: I/O ports at 2000 [size=3D256]
    Region 2: Memory at d1010000 (64-bit, prefetchable) [size=3D4K]
    Region 4: Memory at d1000000 (64-bit, prefetchable) [size=3D64K]
    Expansion ROM at d1020000 [disabled] [size=3D64K]
    Capabilities: [40] Power Management version 3
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
    Capabilities: [50] MSI: Enable+ Count=3D1/2 Maskable- 64bit+
        Address: 00000000fee0300c  Data: 41c1
    Capabilities: [70] Express (v1) Endpoint, MSI 01
        DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s
<512ns, L1 <8us
            ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
            RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 4096 bytes
        DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+
TransPend-
        LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Latency L0 <512ns, L1 <64us
            ClockPM+ Surprise- LLActRep- BwNot-
        LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk=
+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
    Capabilities: [b0] MSI-X: Enable- Count=3D2 Masked-
        Vector table: BAR=3D4 offset=3D00000000
        PBA: BAR=3D4 offset=3D00000800
    Capabilities: [d0] Vital Product Data
        Unknown small resource type 00, will not decode more.
    Capabilities: [100 v1] Advanced Error Reporting
        UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
        CESta:    RxErr+ BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+=

        CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+=

        AERCap:    First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn=
-
    Capabilities: [140 v1] Virtual Channel
        Caps:    LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
        Arb:    Fixed- WRR32- WRR64- WRR128-
        Ctrl:    ArbSelect=3DFixed
        Status:    InProgress-
        VC0:    Caps:    PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
            Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
            Ctrl:    Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3Dff
            Status:    NegoPending- InProgress-
    Capabilities: [160 v1] Device Serial Number 00-00-00-00-00-00-00-00
    Kernel driver in use: r8169
    Kernel modules: r8169

[7.6.] Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST9500420AS      Rev: 0002
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: hp       Model: CDDVDW TS-L633M  Rev: 0301
  Type:   CD-ROM                           ANSI  SCSI revision: 05
Host: scsi4 Channel: 00 Id: 00 Lun: 00
  Vendor: Generic- Model: Multi-Card       Rev: 1.00
  Type:   Direct-Access                    ANSI  SCSI revision: 00

[7.7.] 1     14    2327  2479  3179  3569  4243  951            loadavg
10    1489  2328  248   3181  3572  43    956            locks
1041  15    2341  249   3187  3573  4360  acpi           mdstat
1046  16    2346  25    32    3615  4370  asound         meminfo
1079  17    2348  2504  3229  3621  44    buddyinfo      misc
1087  1768  2357  2513  3231  3638  4426  bus            modules
1088  18    2360  2545  3241  3711  4435  cgroups        mounts
1096  19    2370  2567  3246  3718  4457  cmdline        mtrr
1114  1941  2376  2572  3247  3725  4487  consoles       net
1119  1973  2379  2575  3280  3731  47    cpuinfo        pagetypeinfo
1122  1990  2381  26    3281  3736  48    crypto         partitions
1125  1991  2383  2649  333   3745  49    devices        sched_debug
1126  1992  2386  27    3340  3753  5     diskstats      schedstat
1161  2     2390  2740  3358  3757  52    dma            scsi
12    20    2392  2741  3361  3826  6     dri            self
1220  2001  2394  28    3416  3832  633   driver         slabinfo
1232  203   2396  2889  3436  3856  637   execdomains    softirqs
1241  2045  2399  2895  3462  3871  638   fb             stat
1253  2049  24    29    3464  3892  641   filesystems    swaps
1254  207   2402  2900  3466  391   7     fs             sys
1256  21    2404  3     3468  3916  71    interrupts     sysrq-trigger
1265  2106  2407  30    3470  3931  72    iomem          sysvipc
1284  2111  2410  3033  3472  3966  73    ioports        timer_list
1297  2123  2412  3034  3474  4073  8     irq            timer_stats
1298  22    2417  3041  3539  41    837   kallsyms       tty
1299  2226  2419  3048  3544  4148  882   kcore          uptime
13    2273  2429  3060  3546  4153  885   key-users      version
1300  2284  2431  31    3547  4154  9     kmsg           vmallocinfo
1301  23    2432  3139  3561  4161  919   kpagecount     vmstat
1321  2323  2437  3141  3567  4162  921   kpageflags     zoneinfo
1364  2324  2439  3177  3568  4232  942   latency_stats

--=20
Robert Ian Hawdon

http://robertianhawdon.me.uk/

Most of my emails are signed with a PGP signature. For more information,
please visit http://www.op-ezy.co.uk/~ian/pgp/


--------------enig02CC89CF417C62A8C6ED4DE5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQEcBAEBAgAGBQJQZd5gAAoJEH228BLkUShouB8IAJnFjuG7/LD1Sr1Bde6pkHfN
uGNNFbi1fz4eJljQJH/7xJq12Cc7L36HkobFDtY+muXOQSpEy56ZQDDU8+lf1Bvg
2BSfdCgm4EW4jtQeVa5PDRZ4QRhXorFs6zD1Mxn6YUYq3yaCIt0uEe8+dZ6rQedI
kOXxpz4P5fbVmIRXZMY66bHtAFRWv3bwajlNwYAyZiETjVIrt0NnZw9jYEswgorB
oxDrlAklOLJlD+oO57Tw0XkuJeXM3jlCrmFBsr137xcgvgU3x2zBll4uAvYnUzdI
cE5cfeMF0Qfu8VXgc5LD32oV/qBpFTZhNtPrCUo9L7So2+0l8BiO0l02A1ki59c=
=In6o
-----END PGP SIGNATURE-----

--------------enig02CC89CF417C62A8C6ED4DE5--
