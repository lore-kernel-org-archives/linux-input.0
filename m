From: Pascal =?ISO-8859-1?Q?F=FCrst?= <pascalfuerst@postmail.ch>
Subject: PROBLEM: [HP Stream Notebook - 14-z010nz] Synaptics clickpad
 incorrectly detected as PS/2 mouse
Date: Mon, 10 Nov 2014 20:59:00 +0100
Message-ID: <1415649540.3107.1.camel@postmail.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-BRtUZDmVl2A1Ip5vkJx1"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from david.daybyday.de ([213.191.85.50]:43671 "EHLO
	david.daybyday.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751452AbaKJUJv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Nov 2014 15:09:51 -0500
Received: from PASCAL-LAPTOP2 (14-230.192-178.cust.bluewin.ch [178.192.230.14])
	(Authenticated sender: pascalfuerst@postmail.ch)
	by david.daybyday.de (Postfix) with ESMTPSA id A27AC1D030C
	for <linux-input@vger.kernel.org>; Mon, 10 Nov 2014 21:00:46 +0100 (CET)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org


--=-BRtUZDmVl2A1Ip5vkJx1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[1.] One line summary of the problem:
[HP Stream Notebook - 14-z010nz] Synaptics Clickpad incorrectly detected
as PS/2 mouse=20

[2.] Full description of the problem/report:
The clickpad acts like and is detected as a standard mouse.

Single-tap to click works, as does the clickpad functionality
(right-click and left-click) and the basic pointing function of a mouse.

Two-finger-scroll, two-finger-tap etc. don't work. The device is not
configurable via the synclient tool. The 'Touchpad' tab in System ->
Preferences -> Mouse is missing.

The clickpad should preferably be recognized as a Synaptics touchpad and
the associated module should be loaded instead of the evdev one. This
would allow to use the features of the synaptics module (especially palm
detection)

Thank you for reading this and for your help


[3.] Keywords (i.e., modules, networking, kernel):

[4.] Kernel version (from /proc/version):
Linux version 3.18.0-031800rc4-generic (apw@gomeisa) (gcc version 4.6.3
(Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201411091835 SMP Sun Nov 9 23:36:36
UTC 2014

[5.] Output of Oops.. message (if applicable) with symbolic information
resolved (see Documentation/oops-tracing.txt)

[6.] A small shell script or example program which triggers the problem
(if possible)

[7.] Environment
Description:	Ubuntu 14.10
Release:	14.10

[7.1.] Software (add the output of the ver_linux script here)
Linux LAPTOP2 3.18.0-031800rc4-generic #201411091835 SMP Sun Nov 9
23:36:36 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux
=20
Gnu C                  4.9.1
Gnu make               4.0
binutils               2.24.90.20141014
util-linux             2.25.1
mount                  debug
module-init-tools      18
e2fsprogs              1.42.10
pcmciautils            018
PPP                    2.4.5
Linux C Library        2.19
Dynamic linker (ldd)   2.19
Procps                 3.3.9
Net-tools              1.60
Kbd                    1.15.5
Sh-utils               8.23
wireless-tools         30
Modules Loaded         dm_crypt rfcomm bnep kvm crct10dif_pclmul
crc32_pclmul uvcvideo ghash_clmulni_intel hp_wmi aesni_intel
videobuf2_vmalloc sparse_keymap videobuf2_memops aes_x86_64 lrw
videobuf2_core gf128mul btusb glue_helper v4l2_common ablk_helper cryptd
videodev bluetooth snd_hda_codec_realtek snd_hda_codec_generic
snd_hda_codec_hdmi media snd_hda_intel serio_raw snd_hda_controller
edac_core snd_hda_codec binfmt_misc snd_hwdep k10temp edac_mce_amd
fam15h_power snd_seq_midi snd_seq_midi_event snd_pcm ccp snd_rawmidi
shpchp i2c_piix4 snd_seq snd_seq_device snd_timer hp_wireless
nls_iso8859_1 snd soundcore mac_hid parport_pc ppdev lp parport video
radeon i2c_algo_bit ttm psmouse drm_kms_helper ahci wmi sdhci_pci sdhci
drm libahci

[7.2.] Processor information (from /proc/cpuinfo):
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 22
model		: 48
model name	: AMD A4 Micro-6400T APU + AMD Radeon R3 Graphics
stepping	: 1
microcode	: 0x7030105
cpu MHz		: 1000.000
cache size	: 2048 KB
physical id	: 0
siblings	: 4
core id		: 0
cpu cores	: 4
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc extd_apicid
aperfmperf eagerfpu pni pclmulqdq monitor ssse3 cx16 sse4_1 sse4_2 movbe
popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic
cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt
topoext perfctr_nb perfctr_l2 arat cpb hw_pstate npt lbrv svm_lock
nrip_save tsc_scale flushbyasid decodeassists pausefilter pfthreshold
vmmcall bmi1 xsaveopt
bugs		: fxsave_leak
bogomips	: 1996.23
TLB size	: 1024 4K pages
clflush size	: 64
cache_alignment	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management: ts ttp tm 100mhzsteps hwpstate cpb [12] [13]

processor	: 1
vendor_id	: AuthenticAMD
cpu family	: 22
model		: 48
model name	: AMD A4 Micro-6400T APU + AMD Radeon R3 Graphics
stepping	: 1
microcode	: 0x7030105
cpu MHz		: 800.000
cache size	: 2048 KB
physical id	: 0
siblings	: 4
core id		: 1
cpu cores	: 4
apicid		: 1
initial apicid	: 1
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc extd_apicid
aperfmperf eagerfpu pni pclmulqdq monitor ssse3 cx16 sse4_1 sse4_2 movbe
popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic
cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt
topoext perfctr_nb perfctr_l2 arat cpb hw_pstate npt lbrv svm_lock
nrip_save tsc_scale flushbyasid decodeassists pausefilter pfthreshold
vmmcall bmi1 xsaveopt
bugs		: fxsave_leak
bogomips	: 1996.23
TLB size	: 1024 4K pages
clflush size	: 64
cache_alignment	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management: ts ttp tm 100mhzsteps hwpstate cpb [12] [13]

processor	: 2
vendor_id	: AuthenticAMD
cpu family	: 22
model		: 48
model name	: AMD A4 Micro-6400T APU + AMD Radeon R3 Graphics
stepping	: 1
microcode	: 0x7030105
cpu MHz		: 800.000
cache size	: 2048 KB
physical id	: 0
siblings	: 4
core id		: 2
cpu cores	: 4
apicid		: 2
initial apicid	: 2
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc extd_apicid
aperfmperf eagerfpu pni pclmulqdq monitor ssse3 cx16 sse4_1 sse4_2 movbe
popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic
cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt
topoext perfctr_nb perfctr_l2 arat cpb hw_pstate npt lbrv svm_lock
nrip_save tsc_scale flushbyasid decodeassists pausefilter pfthreshold
vmmcall bmi1 xsaveopt
bugs		: fxsave_leak
bogomips	: 1996.23
TLB size	: 1024 4K pages
clflush size	: 64
cache_alignment	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management: ts ttp tm 100mhzsteps hwpstate cpb [12] [13]

processor	: 3
vendor_id	: AuthenticAMD
cpu family	: 22
model		: 48
model name	: AMD A4 Micro-6400T APU + AMD Radeon R3 Graphics
stepping	: 1
microcode	: 0x7030105
cpu MHz		: 800.000
cache size	: 2048 KB
physical id	: 0
siblings	: 4
core id		: 3
cpu cores	: 4
apicid		: 3
initial apicid	: 3
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc extd_apicid
aperfmperf eagerfpu pni pclmulqdq monitor ssse3 cx16 sse4_1 sse4_2 movbe
popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic
cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt
topoext perfctr_nb perfctr_l2 arat cpb hw_pstate npt lbrv svm_lock
nrip_save tsc_scale flushbyasid decodeassists pausefilter pfthreshold
vmmcall bmi1 xsaveopt
bugs		: fxsave_leak
bogomips	: 1996.23
TLB size	: 1024 4K pages
clflush size	: 64
cache_alignment	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management: ts ttp tm 100mhzsteps hwpstate cpb [12] [13]


[7.3.] Module information (from /proc/modules):
dm_crypt 23456 0 - Live 0x0000000000000000
rfcomm 75066 8 - Live 0x0000000000000000
bnep 23980 2 - Live 0x0000000000000000
kvm 475233 0 - Live 0x0000000000000000
crct10dif_pclmul 14268 0 - Live 0x0000000000000000
crc32_pclmul 13180 0 - Live 0x0000000000000000
uvcvideo 86723 0 - Live 0x0000000000000000
ghash_clmulni_intel 13230 0 - Live 0x0000000000000000
hp_wmi 14017 0 - Live 0x0000000000000000
aesni_intel 169686 534 - Live 0x0000000000000000
videobuf2_vmalloc 13216 1 uvcvideo, Live 0x0000000000000000
sparse_keymap 13890 1 hp_wmi, Live 0x0000000000000000
videobuf2_memops 13362 1 videobuf2_vmalloc, Live 0x0000000000000000
aes_x86_64 17131 1 aesni_intel, Live 0x0000000000000000
lrw 13323 1 aesni_intel, Live 0x0000000000000000
videobuf2_core 51547 1 uvcvideo, Live 0x0000000000000000
gf128mul 14951 1 lrw, Live 0x0000000000000000
btusb 32691 0 - Live 0x0000000000000000
glue_helper 14095 1 aesni_intel, Live 0x0000000000000000
v4l2_common 15715 1 videobuf2_core, Live 0x0000000000000000
ablk_helper 13597 1 aesni_intel, Live 0x0000000000000000
cryptd 20531 269 ghash_clmulni_intel,aesni_intel,ablk_helper, Live
0x0000000000000000
videodev 163831 3 uvcvideo,videobuf2_core,v4l2_common, Live
0x0000000000000000
bluetooth 486890 22 rfcomm,bnep,btusb, Live 0x0000000000000000
snd_hda_codec_realtek 80418 1 - Live 0x0000000000000000
snd_hda_codec_generic 69995 1 snd_hda_codec_realtek, Live
0x0000000000000000
snd_hda_codec_hdmi 52670 1 - Live 0x0000000000000000
media 22008 2 uvcvideo,videodev, Live 0x0000000000000000
snd_hda_intel 30783 5 - Live 0x0000000000000000
serio_raw 13483 0 - Live 0x0000000000000000
snd_hda_controller 32234 1 snd_hda_intel, Live 0x0000000000000000
edac_core 52405 0 - Live 0x0000000000000000
snd_hda_codec 144641 5
snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_codec_hdmi,snd_hda_inte=
l,snd_hda_controller, Live 0x0000000000000000
binfmt_misc 17501 1 - Live 0x0000000000000000
snd_hwdep 17709 1 snd_hda_codec, Live 0x0000000000000000
k10temp 13279 0 - Live 0x0000000000000000
edac_mce_amd 22800 0 - Live 0x0000000000000000
fam15h_power 13160 0 - Live 0x0000000000000000
snd_seq_midi 13564 0 - Live 0x0000000000000000
snd_seq_midi_event 14899 1 snd_seq_midi, Live 0x0000000000000000
snd_pcm 106273 4
snd_hda_codec_hdmi,snd_hda_intel,snd_hda_controller,snd_hda_codec, Live
0x0000000000000000
ccp 32275 0 - Live 0x0000000000000000
snd_rawmidi 31197 1 snd_seq_midi, Live 0x0000000000000000
shpchp 37216 0 - Live 0x0000000000000000
i2c_piix4 22311 0 - Live 0x0000000000000000
snd_seq 63540 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live
0x0000000000000000
snd_timer 30118 2 snd_pcm,snd_seq, Live 0x0000000000000000
hp_wireless 12637 0 - Live 0x0000000000000000
nls_iso8859_1 12713 1 - Live 0x0000000000000000
snd 84025 21
snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_codec_hdmi,snd_hda_inte=
l,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_seq_device,snd_ti=
mer, Live 0x0000000000000000
soundcore 15091 2 snd_hda_codec,snd, Live 0x0000000000000000
mac_hid 13275 0 - Live 0x0000000000000000
parport_pc 32909 0 - Live 0x0000000000000000
ppdev 17711 0 - Live 0x0000000000000000
lp 17799 0 - Live 0x0000000000000000
parport 42481 3 parport_pc,ppdev,lp, Live 0x0000000000000000
video 20649 0 - Live 0x0000000000000000
radeon 1570939 3 - Live 0x0000000000000000
i2c_algo_bit 13564 1 radeon, Live 0x0000000000000000
ttm 90228 1 radeon, Live 0x0000000000000000
psmouse 118117 0 - Live 0x0000000000000000
drm_kms_helper 99802 1 radeon, Live 0x0000000000000000
ahci 34220 2 - Live 0x0000000000000000
wmi 19379 1 hp_wmi, Live 0x0000000000000000
sdhci_pci 23434 0 - Live 0x0000000000000000
sdhci 43929 1 sdhci_pci, Live 0x0000000000000000
drm 323675 6 radeon,ttm,drm_kms_helper, Live 0x0000000000000000
libahci 32446 1 ahci, Live 0x0000000000000000

[7.4.] Loaded driver and hardware information
(/proc/ioports, /proc/iomem)
cat /proc/ioports
0000-03af : PCI Bus 0000:00
  0000-001f : dma1
  0020-0021 : pic1
  0040-0043 : timer0
  0050-0053 : timer1
  0060-0060 : keyboard
  0061-0061 : PNP0800:00
  0062-0062 : PNP0C09:00
    0062-0062 : EC data
  0064-0064 : keyboard
  0066-0066 : PNP0C09:00
    0066-0066 : EC cmd
  0070-0071 : rtc0
  0080-008f : dma page reg
  00a0-00a1 : pic2
  00c0-00df : dma2
  00f0-00ff : PNP0C04:00
    00f0-00ff : fpu
03b0-03df : PCI Bus 0000:00
03e0-0cf7 : PCI Bus 0000:00
  040b-040b : pnp 00:07
  04d0-04d1 : pnp 00:04
    04d0-04d1 : pnp 00:07
  04d6-04d6 : pnp 00:07
  0800-0803 : ACPI PM1a_EVT_BLK
  0804-0805 : ACPI PM1a_CNT_BLK
  0808-080b : ACPI PM_TMR
  0810-0815 : ACPI CPU throttle
  0820-0827 : ACPI GPE0_BLK
  0900-090f : pnp 00:07
  0910-091f : pnp 00:07
  0b00-0b07 : piix4_smbus
  0b20-0b3f : pnp 00:07
    0b20-0b27 : piix4_smbus
  0c00-0c01 : pnp 00:07
  0c14-0c14 : pnp 00:07
  0c50-0c51 : pnp 00:07
  0c52-0c52 : pnp 00:07
  0c6c-0c6c : pnp 00:07
  0c6f-0c6f : pnp 00:07
  0cd0-0cd1 : pnp 00:07
  0cd2-0cd3 : pnp 00:07
  0cd4-0cd5 : pnp 00:07
  0cd6-0cd7 : pnp 00:07
  0cd8-0cdf : pnp 00:07
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
  f000-f0ff : 0000:00:01.0
  f100-f10f : 0000:00:11.0
    f100-f10f : ahci
  f110-f113 : 0000:00:11.0
    f110-f113 : ahci
  f120-f127 : 0000:00:11.0
    f120-f127 : ahci
  f130-f133 : 0000:00:11.0
    f130-f133 : ahci
  f140-f147 : 0000:00:11.0
    f140-f147 : ahci
  fe00-fefe : pnp 00:07

cat /proc/iomem
00000000-00000fff : reserved
00001000-0009ffff : System RAM
000a0000-000bffff : PCI Bus 0000:00
000c0000-000dffff : PCI Bus 0000:00
000f0000-000fffff : System ROM
00100000-6cedffff : System RAM
  01000000-017b1c17 : Kernel code
  017b1c18-01d19c7f : Kernel data
  01e80000-01fc8fff : Kernel bss
6cee0000-6cf7bfff : reserved
6cf7c000-6cfb5fff : ACPI Tables
6cfb6000-6d0bcfff : ACPI Non-volatile Storage
6d0bd000-6d793fff : reserved
6d794000-6d7defff : reserved
6d7df000-6d7dffff : System RAM
6d7e0000-6d7e7fff : ACPI Non-volatile Storage
6d7e8000-6dc73fff : System RAM
6dc74000-6dff0fff : reserved
6dff1000-6dffffff : System RAM
6e000000-6fffffff : RAM buffer
7f000000-ffffffff : PCI Bus 0000:00
  c0000000-cfffffff : 0000:00:01.0
  d0000000-d07fffff : 0000:00:01.0
  d0800000-d081ffff : 0000:00:08.0
    d0800000-d081ffff : ccp
  e0000000-efffffff : PCI MMCONFIG 0000 [bus 00-ff]
    e0000000-efffffff : pnp 00:00
  fe800000-fe8fffff : 0000:00:08.0
    fe800000-fe8fffff : ccp
  fe900000-fe9fffff : PCI Bus 0000:01
    fe900000-fe907fff : 0000:01:00.0
  fea00000-fea3ffff : 0000:00:01.0
  fea40000-fea5ffff : 0000:00:01.0
  fea60000-fea63fff : 0000:00:14.2
    fea60000-fea63fff : ICH HD audio
  fea64000-fea67fff : 0000:00:01.1
    fea64000-fea67fff : ICH HD audio
  fea68000-fea69fff : 0000:00:10.0
    fea68000-fea69fff : xhci-hcd
  fea6a000-fea6bfff : 0000:00:08.0
    fea6a000-fea6bfff : ccp
  fea6c000-fea6c0ff : 0000:00:14.7
    fea6c000-fea6c0ff : mmc0
  fea6d000-fea6d0ff : 0000:00:13.0
    fea6d000-fea6d0ff : ehci_hcd
  fea6e000-fea6e0ff : 0000:00:12.0
    fea6e000-fea6e0ff : ehci_hcd
  fea6f000-fea6f3ff : 0000:00:11.0
    fea6f000-fea6f3ff : ahci
  fea70000-fea70fff : 0000:00:08.0
    fea70000-fea70fff : ccp
  feb00000-feb00fff : reserved
  fec00000-fec01fff : reserved
    fec00000-fec003ff : IOAPIC 0
    fec01000-fec013ff : IOAPIC 1
  fec10000-fec10fff : reserved
    fec10000-fec10fff : pnp 00:07
  fed00000-fed00fff : reserved
    fed00000-fed003ff : HPET 0
      fed00000-fed003ff : PNP0103:00
  fed40000-fed44fff : reserved
  fed61000-fed70fff : pnp 00:07
  fed80000-fed8ffff : reserved
    fed80000-fed8ffff : pnp 00:07
  fee00000-fee00fff : Local APIC
    fee00000-fee00fff : pnp 00:07
  ff000000-ffffffff : reserved
    ff000000-ffffffff : pnp 00:07

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1566
	Subsystem: Hewlett-Packard Company Device 22ea
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0

00:01.0 VGA compatible controller: Advanced Micro Devices, Inc.
[AMD/ATI] Mullins [Radeon R3E Graphics] (rev 02) (prog-if 00 [VGA
controller])
	Subsystem: Hewlett-Packard Company Device 22ea
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 32
	Region 0: Memory at c0000000 (64-bit, prefetchable) [size=3D256M]
	Region 2: Memory at d0000000 (64-bit, prefetchable) [size=3D8M]
	Region 4: I/O ports at f000 [size=3D256]
	Region 5: Memory at fea00000 (32-bit, non-prefetchable) [size=3D256K]
	Expansion ROM at fea40000 [disabled] [size=3D128K]
	Capabilities: [48] Vendor Specific Information: Len=3D08 <?>
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1+,D2+,D3hot
+,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [58] Express (v2) Root Complex Integrated Endpoint, MSI
00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0
			ExtTag+ RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF
Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF
Disabled
	Capabilities: [a0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
		Address: 00000000fee0f00c  Data: 4162
	Capabilities: [100 v1] Vendor Specific Information: ID=3D0001 Rev=3D1
Len=3D010 <?>
	Capabilities: [270 v1] #19
	Capabilities: [2b0 v1] Address Translation Service (ATS)
		ATSCap:	Invalidate Queue Depth: 00
		ATSCtl:	Enable-, Smallest Translation Unit: 00
	Capabilities: [2c0 v1] #13
	Capabilities: [2d0 v1] #1b
	Kernel driver in use: radeon

00:01.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Kabini
HDMI/DP Audio
	Subsystem: Hewlett-Packard Company Device 22ea
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 36
	Region 0: Memory at fea64000 (64-bit, non-prefetchable) [size=3D16K]
	Capabilities: [48] Vendor Specific Information: Len=3D08 <?>
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [58] Express (v2) Root Complex Integrated Endpoint, MSI
00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0
			ExtTag+ RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF
Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF
Disabled
	Capabilities: [a0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
		Address: 00000000fee0f00c  Data: 41a2
	Capabilities: [100 v1] Vendor Specific Information: ID=3D0001 Rev=3D1
Len=3D010 <?>
	Kernel driver in use: snd_hda_intel

00:02.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 156b
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-

00:02.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Family 16h
Processor Functions 5:1 (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fe900000-fe9fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot
+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [58] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0
			ExtTag+ RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency
L0s <512ns, L1 <64us
			ClockPM- Surprise- LLActRep+ BwNot+
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+
BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #0, PowerLimit 0.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible
+
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not
Supported ARIFwd-
		DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis-, LTR-, OBFF
Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis+
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [a0] MSI: Enable- Count=3D1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [b0] Subsystem: Hewlett-Packard Company Device 22ea
	Capabilities: [b8] HyperTransport: MSI Mapping Enable+ Fixed+
	Capabilities: [100 v1] Vendor Specific Information: ID=3D0001 Rev=3D1
Len=3D010 <?>
	Kernel driver in use: pcieport

00:08.0 Encryption controller: Advanced Micro Devices, Inc. [AMD] Device
1537
	Subsystem: Hewlett-Packard Company Device 22ea
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Region 0: Memory at d0800000 (64-bit, prefetchable) [size=3D128K]
	Region 2: Memory at fe800000 (32-bit, non-prefetchable) [size=3D1M]
	Region 3: Memory at fea70000 (32-bit, non-prefetchable) [size=3D4K]
	Region 5: Memory at fea6a000 (32-bit, non-prefetchable) [size=3D8K]
	Capabilities: [50] MSI-X: Enable+ Count=3D2 Masked-
		Vector table: BAR=3D5 offset=3D00000000
		PBA: BAR=3D5 offset=3D00001000
	Capabilities: [5c] HyperTransport: MSI Mapping Enable+ Fixed+
	Capabilities: [60] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Kernel driver in use: AMD Cryptographic Coprocessor

00:10.0 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB XHCI
Controller (rev 11) (prog-if 30 [XHCI])
	Subsystem: Hewlett-Packard Company Device 22ea
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at fea68000 (64-bit, non-prefetchable) [size=3D8K]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot
+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [70] MSI: Enable- Count=3D1/8 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [90] MSI-X: Enable+ Count=3D8 Masked-
		Vector table: BAR=3D0 offset=3D00001000
		PBA: BAR=3D0 offset=3D00001080
	Capabilities: [a0] Express (v2) Root Complex Integrated Endpoint, MSI
00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR+, OBFF
Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF
Disabled
	Capabilities: [100 v1] Latency Tolerance Reporting
		Max snoop latency: 0ns
		Max no snoop latency: 0ns
	Kernel driver in use: xhci_hcd

00:11.0 SATA controller: Advanced Micro Devices, Inc. [AMD] FCH SATA
Controller [AHCI mode] (rev 40) (prog-if 01 [AHCI 1.0])
	Subsystem: Hewlett-Packard Company Device 22ea
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32
	Interrupt: pin A routed to IRQ 30
	Region 0: I/O ports at f140 [size=3D8]
	Region 1: I/O ports at f130 [size=3D4]
	Region 2: I/O ports at f120 [size=3D8]
	Region 3: I/O ports at f110 [size=3D4]
	Region 4: I/O ports at f100 [size=3D16]
	Region 5: Memory at fea6f000 (32-bit, non-prefetchable) [size=3D1K]
	Capabilities: [60] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot
+,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [70] SATA HBA v1.0 InCfgSpace
	Capabilities: [50] MSI: Enable+ Count=3D1/8 Maskable- 64bit+
		Address: 00000000fee0f00c  Data: 4142
	Kernel driver in use: ahci

00:12.0 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB EHCI
Controller (rev 39) (prog-if 20 [EHCI])
	Subsystem: Hewlett-Packard Company Device 22ea
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at fea6e000 (32-bit, non-prefetchable) [size=3D256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot
+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
		Bridge: PM- B3+
	Capabilities: [e4] Debug port: BAR=3D1 offset=3D00e0
	Kernel driver in use: ehci-pci

00:13.0 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB EHCI
Controller (rev 39) (prog-if 20 [EHCI])
	Subsystem: Hewlett-Packard Company Device 22ea
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at fea6d000 (32-bit, non-prefetchable) [size=3D256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot
+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
		Bridge: PM- B3+
	Capabilities: [e4] Debug port: BAR=3D1 offset=3D00e0
	Kernel driver in use: ehci-pci

00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller
(rev 42)
	Subsystem: Hewlett-Packard Company Device 22ea
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Kernel driver in use: piix4_smbus

00:14.2 Audio device: Advanced Micro Devices, Inc. [AMD] FCH Azalia
Controller (rev 02)
	Subsystem: Hewlett-Packard Company Device 22ea
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dslow >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	Latency: 32, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at fea60000 (64-bit, non-prefetchable) [size=3D16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D55mA PME(D0+,D1-,D2-,D3hot
+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Kernel driver in use: snd_hda_intel

00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge
(rev 11)
	Subsystem: Hewlett-Packard Company Device 22ea
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0

00:14.7 SD Host controller: Advanced Micro Devices, Inc. [AMD] FCH SD
Flash Controller (rev 01) (prog-if 01)
	Subsystem: Hewlett-Packard Company Device 22ea
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 39, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at fea6c000 (64-bit, non-prefetchable) [size=3D256]
	Capabilities: [80] MSI: Enable- Count=3D1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [90] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Kernel driver in use: sdhci-pci

00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1580
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-

00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1581
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-

00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1582
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-

00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1583
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	Capabilities: [f0] Secure device <?>
	Kernel driver in use: fam15h_power

00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1584
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-

00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1585
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-

01:00.0 Network controller: Broadcom Corporation BCM43142 802.11b/g/n
(rev 01)
	Subsystem: Hewlett-Packard Company Device 2232
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 255
	Region 0: Memory at fe900000 (64-bit, non-prefetchable) [disabled]
[size=3D32K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot
+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D2 PME-
	Capabilities: [58] Vendor Specific Information: Len=3D78 <?>
	Capabilities: [48] MSI: Enable- Count=3D1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [d0] Express (v1) Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, L1
unlimited
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency
L0s <4us, L1 <64us
			ClockPM+ Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [13c v1] Virtual Channel
		Caps:	LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=3DFixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3D01
			Status:	NegoPending- InProgress-
	Capabilities: [160 v1] Device Serial Number 00-00-41-ff-ff-f1-b0-10
	Capabilities: [16c v1] Power Budgeting <?>


[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: BHT WR202A1064G  Rev: 00 =20
  Type:   Direct-Access                    ANSI  SCSI revision: 05

[7.7.] Other information that might be relevant to the problem (please
look in /proc and include all information that you think to be
relevant):
1
10
11
12
1200
1205
1206
1212
1213
1218
1226
1265
1291
13
1365
139
14
140
141
1412
142
1437
144
1459
146
147
148
1494
1497
15
151
153
1532
1557
16
1641
1677
17
18
1828
1866
1877
19
1954
1964
198
1988
1989
199
1999
2
20
2011
2027
2040
2043
2045
2046
2051
2060
2062
2070
2086
21
2115
2144
2170
2178
22
2257
2263
2271
2281
2287
2297
23
2300
2309
2315
2319
2323
2328
2329
2332
2335
2363
2364
2370
2376
24
2404
2457
247
2478
2494
25
2501
2507
2516
2526
2533
2534
2586
26
2689
27
2701
2711
2736
2791
2798
2799
28
2801
2805
2808
29
3
3017
3052
31
310
32
33
3305
3323
34
343
35
352
36
37
38
39
40
41
42
43
44
45
46
461
463
464
465
47
48
494
5
50
51
527
53
530
55
56
567
568
57
571
589
6
600
637
642
653
654
667
673
69
7
70
71
72
73
8
817
850
871
9
907
92
926
93
934
937
940
945
968
acpi
asound
buddyinfo
bus
cgroups
cmdline
consoles
cpuinfo
crypto
devices
diskstats
dma
driver
execdomains
fb
filesystems
fs
interrupts
iomem
ioports
irq
kallsyms
kcore
keys
key-users
kmsg
kpagecount
kpageflags
loadavg
locks
mdstat
meminfo
misc
modules
mounts
mtrr
net
pagetypeinfo
partitions
sched_debug
schedstat
scsi
self
slabinfo
softirqs
stat
swaps
sys
sysrq-trigger
sysvipc
thread-self
timer_list
timer_stats
tty
uptime
version
vmallocinfo
vmstat
zoneinfo

[X.] Other notes, patches, fixes, workarounds:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1390915

sudo tpconfig
Found Synaptics Touchpad.
Firmware: 8.96 (multiple-byte mode).

xinput --list:
=E2=8E=A1 Virtual core pointer id=3D2 [master pointer (3)]
=E2=8E=9C =E2=86=B3 Virtual core XTEST pointer id=3D4 [slave pointer (2)]
=E2=8E=9C =E2=86=B3 PS/2 Generic Mouse id=3D11 [slave pointer (2)]
=E2=8E=A3 Virtual core keyboard id=3D3 [master keyboard (2)]
    =E2=86=B3 Virtual core XTEST keyboard id=3D5 [slave keyboard (3)]
    =E2=86=B3 Power Button id=3D6 [slave keyboard (3)]
    =E2=86=B3 Video Bus id=3D7 [slave keyboard (3)]
    =E2=86=B3 Power Button id=3D8 [slave keyboard (3)]
    =E2=86=B3 HP Truevision HD id=3D9 [slave keyboard (3)]
    =E2=86=B3 AT Translated Set 2 keyboard id=3D10 [slave keyboard (3)]
    =E2=86=B3 HP WMI hotkeys id=3D12 [slave keyboard (3)]
    =E2=86=B3 HP Wireless hotkeys id=3D13 [slave keyboard (3)]

--=-BRtUZDmVl2A1Ip5vkJx1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAABAgAGBQJUYRkEAAoJEF9ThwoETc3gOy0H/RXgHPd1tbulx2Sj0FuLm1Iz
cQszSuExzJ05pjo8VqLEK3EchWtKznLjz9riiYNMXuVslug5KkMswzLnWpbJl7Cm
u/l98KQSZQVJdhDj1tblKBrNwZx/R8mOVtLJ64JqctNLiIxeKVpt/a67b1W28zYF
VkgXaOiGuHcx1V8GhhOljHwOjczqxGyw55TTLEBlshA17+zBOrCPTjWIhZk/BuF1
pUge5TikbbB8vAZ+hlZyNTEyG1aIIoWVstWwPuBxoyb2CmGnfffwcbP+i9g+NYJR
dkyGuVWtzCSDNIGDDrBzPlKCTzKvn4o4mJMd59sCnx1FRoWyyqh+J1fRLYgHj7g=
=GQvy
-----END PGP SIGNATURE-----

--=-BRtUZDmVl2A1Ip5vkJx1--

