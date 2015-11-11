From: Jim lovell <jimlovell777@gmail.com>
Subject: Kernel Bug Upstream 0408:3003 Quanta Computer, Inc. Touchscreen
 Controller Detected But Doesn't Work
Date: Tue, 10 Nov 2015 22:21:15 -0600
Message-ID: <CACcJrhR8iv0FKRrH7V2nbefZBLfhmr_Kn9ctg4O4bhzd_3oFnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f194.google.com ([209.85.160.194]:34189 "EHLO
	mail-yk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285AbbKKEVQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Nov 2015 23:21:16 -0500
Received: by ykay124 with SMTP id y124so2954210yka.1
        for <linux-input@vger.kernel.org>; Tue, 10 Nov 2015 20:21:16 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

[1.] 0408:3003 Quanta Computer, Inc. Touchscreen Controller Detected
But Doesn't Work

[2.] Booting my computer using the newest mainline kernel, the
built-in USB 0408:3003 Quanta Computer, Inc. touchscreen controller is
detected but doesn't work. The touchscreen controller is detected but
no touches are acknowleged. Using "xinput [id] test" no output is
generated while single or multi touching the screen.

[3.]

[4.]
cat /proc/version
Linux version 4.3.0-040300-generic (kernel@gomeisa) (gcc version 5.2.1
20151010 (Ubuntu 5.2.1-22ubuntu2) ) #201511020949 SMP Mon Nov 2
14:50:44 UTC 2015

[5.]

[6.]

[7.]
lsb_release -rd
Description: Ubuntu 15.10
Release: 15.10

[7.1.]
sh ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux portal-touch 4.3.0-040300-generic #201511020949 SMP Mon Nov 2
14:50:44 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux

Gnu C                  5.2.1
Gnu make               4.0
binutils               2.25.1
util-linux             2.26.2
mount                  debug
module-init-tools      21
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
Modules Loaded         cfg80211 r8712u snd_hda_codec_realtek
hid_multitouch snd_hda_codec_generic gpio_ich snd_hda_intel
snd_usb_audio snd_hda_codec snd_usbmidi_lib snd_hda_core snd_hwdep
snd_pcm intel_rapl iosf_mbi snd_seq_midi snd_seq_midi_event
x86_pkg_temp_thermal intel_powerclamp snd_rawmidi snd_seq coretemp
uvcvideo videobuf2_vmalloc kvm videobuf2_memops joydev videobuf2_core
v4l2_common snd_seq_device videodev input_leds snd_timer media mei_me
snd crct10dif_pclmul crc32_pclmul mei soundcore lpc_ich cryptd
serio_raw mac_hid parport_pc ppdev lp parport autofs4
hid_logitech_hidpp ums_realtek uas usb_storage hid_logitech_dj usbhid
hid i915 mxm_wmi video i2c_algo_bit drm_kms_helper syscopyarea
sysfillrect psmouse sysimgblt fb_sys_fops drm ahci e1000e libahci ptp
pps_core wmi fjes

[7.2.]
cat /proc/cpuinfo
processor    : 0
vendor_id    : GenuineIntel
cpu family    : 6
model        : 42
model name    : Intel(R) Core(TM) i3-2100 CPU @ 3.10GHz
stepping    : 7
microcode    : 0x29
cpu MHz        : 1599.890
cache size    : 3072 KB
physical id    : 0
siblings    : 4
core id        : 0
cpu cores    : 2
apicid        : 0
initial apicid    : 0
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor
ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 popcnt
tsc_deadline_timer xsave avx lahf_lm arat epb pln pts dtherm
tpr_shadow vnmi flexpriority ept vpid xsaveopt
bugs        :
bogomips    : 6185.89
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 1
vendor_id    : GenuineIntel
cpu family    : 6
model        : 42
model name    : Intel(R) Core(TM) i3-2100 CPU @ 3.10GHz
stepping    : 7
microcode    : 0x29
cpu MHz        : 1599.890
cache size    : 3072 KB
physical id    : 0
siblings    : 4
core id        : 1
cpu cores    : 2
apicid        : 2
initial apicid    : 2
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor
ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 popcnt
tsc_deadline_timer xsave avx lahf_lm arat epb pln pts dtherm
tpr_shadow vnmi flexpriority ept vpid xsaveopt
bugs        :
bogomips    : 6185.89
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 2
vendor_id    : GenuineIntel
cpu family    : 6
model        : 42
model name    : Intel(R) Core(TM) i3-2100 CPU @ 3.10GHz
stepping    : 7
microcode    : 0x29
cpu MHz        : 1643.847
cache size    : 3072 KB
physical id    : 0
siblings    : 4
core id        : 0
cpu cores    : 2
apicid        : 1
initial apicid    : 1
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor
ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 popcnt
tsc_deadline_timer xsave avx lahf_lm arat epb pln pts dtherm
tpr_shadow vnmi flexpriority ept vpid xsaveopt
bugs        :
bogomips    : 6185.89
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 3
vendor_id    : GenuineIntel
cpu family    : 6
model        : 42
model name    : Intel(R) Core(TM) i3-2100 CPU @ 3.10GHz
stepping    : 7
microcode    : 0x29
cpu MHz        : 1599.890
cache size    : 3072 KB
physical id    : 0
siblings    : 4
core id        : 1
cpu cores    : 2
apicid        : 3
initial apicid    : 3
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor
ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 popcnt
tsc_deadline_timer xsave avx lahf_lm arat epb pln pts dtherm
tpr_shadow vnmi flexpriority ept vpid xsaveopt
bugs        :
bogomips    : 6185.89
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

[7.3.]
cat /proc/modules
cfg80211 536576 0 - Live 0xffffffffc05d2000
r8712u 180224 0 - Live 0xffffffffc05a5000 (C)
snd_hda_codec_realtek 81920 1 - Live 0xffffffffc0590000
hid_multitouch 20480 0 - Live 0xffffffffc051d000
snd_hda_codec_generic 73728 1 snd_hda_codec_realtek, Live 0xffffffffc05=
7d000
gpio_ich 16384 0 - Live 0xffffffffc0381000
snd_hda_intel 36864 3 - Live 0xffffffffc04a8000
snd_usb_audio 176128 1 - Live 0xffffffffc0541000
snd_hda_codec 135168 3
snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel, Live
0xffffffffc04ea000
snd_usbmidi_lib 32768 1 snd_usb_audio, Live 0xffffffffc04dc000
snd_hda_core 65536 4
snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec=
,
Live 0xffffffffc0478000
snd_hwdep 16384 2 snd_usb_audio,snd_hda_codec, Live 0xffffffffc0375000
snd_pcm 102400 4
snd_hda_intel,snd_usb_audio,snd_hda_codec,snd_hda_core, Live
0xffffffffc048e000
intel_rapl 20480 0 - Live 0xffffffffc046d000
iosf_mbi 16384 1 intel_rapl, Live 0xffffffffc03ce000
snd_seq_midi 16384 0 - Live 0xffffffffc03b5000
snd_seq_midi_event 16384 1 snd_seq_midi, Live 0xffffffffc0464000
x86_pkg_temp_thermal 16384 0 - Live 0xffffffffc0368000
intel_powerclamp 16384 0 - Live 0xffffffffc04e5000
snd_rawmidi 32768 2 snd_usbmidi_lib,snd_seq_midi, Live 0xffffffffc04c90=
00
snd_seq 69632 2 snd_seq_midi,snd_seq_midi_event, Live 0xffffffffc04b700=
0
coretemp 16384 0 - Live 0xffffffffc0337000
uvcvideo 90112 0 - Live 0xffffffffc052a000
videobuf2_vmalloc 16384 1 uvcvideo, Live 0xffffffffc0363000
kvm 507904 0 - Live 0xffffffffc03e2000
videobuf2_memops 16384 1 videobuf2_vmalloc, Live 0xffffffffc03dd000
joydev 20480 0 - Live 0xffffffffc03d3000
videobuf2_core 49152 1 uvcvideo, Live 0xffffffffc03c1000
v4l2_common 16384 1 videobuf2_core, Live 0xffffffffc0345000
snd_seq_device 16384 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0xfffffff=
fc033c000
videodev 172032 3 uvcvideo,videobuf2_core,v4l2_common, Live 0xffffffffc=
0386000
input_leds 16384 0 - Live 0xffffffffc0079000
snd_timer 32768 2 snd_pcm,snd_seq, Live 0xffffffffc032e000
media 24576 2 uvcvideo,videodev, Live 0xffffffffc037a000
mei_me 28672 0 - Live 0xffffffffc036d000
snd 81920 20 snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,=
snd_usb_audio,snd_hda_codec,snd_usbmidi_lib,snd_hwdep,snd_pcm,snd_rawmi=
di,snd_seq,snd_seq_device,snd_timer,
Live 0xffffffffc034e000
crct10dif_pclmul 16384 0 - Live 0xffffffffc0329000
crc32_pclmul 16384 0 - Live 0xffffffffc0193000
mei 98304 1 mei_me, Live 0xffffffffc0310000
soundcore 16384 1 snd, Live 0xffffffffc0307000
lpc_ich 24576 0 - Live 0xffffffffc0300000
cryptd 20480 0 - Live 0xffffffffc02fa000
serio_raw 16384 0 - Live 0xffffffffc013f000
mac_hid 16384 0 - Live 0xffffffffc0033000
parport_pc 32768 0 - Live 0xffffffffc02f1000
ppdev 20480 0 - Live 0xffffffffc02eb000
lp 20480 0 - Live 0xffffffffc02c5000
parport 49152 3 parport_pc,ppdev,lp, Live 0xffffffffc02de000
autofs4 40960 2 - Live 0xffffffffc02d3000
hid_logitech_hidpp 20480 0 - Live 0xffffffffc0139000
ums_realtek 20480 0 - Live 0xffffffffc008b000
uas 24576 0 - Live 0xffffffffc0072000
usb_storage 69632 2 ums_realtek,uas, Live 0xffffffffc02b3000
hid_logitech_dj 20480 0 - Live 0xffffffffc02cd000
usbhid 49152 0 - Live 0xffffffffc0173000
hid 118784 7 hid_multitouch,hid_logitech_hidpp,hid_logitech_dj,usbhid,
Live 0xffffffffc00e9000
i915 1134592 4 - Live 0xffffffffc019d000
mxm_wmi 16384 0 - Live 0xffffffffc0198000
video 36864 1 i915, Live 0xffffffffc0189000
i2c_algo_bit 16384 1 i915, Live 0xffffffffc0182000
drm_kms_helper 131072 1 i915, Live 0xffffffffc0152000
syscopyarea 16384 1 drm_kms_helper, Live 0xffffffffc014b000
sysfillrect 16384 1 drm_kms_helper, Live 0xffffffffc0144000
psmouse 126976 0 - Live 0xffffffffc0119000
sysimgblt 16384 1 drm_kms_helper, Live 0xffffffffc0112000
fb_sys_fops 16384 1 drm_kms_helper, Live 0xffffffffc010b000
drm 352256 6 i915,drm_kms_helper, Live 0xffffffffc0092000
ahci 36864 2 - Live 0xffffffffc0081000
e1000e 233472 0 - Live 0xffffffffc0038000
libahci 32768 1 ahci, Live 0xffffffffc002a000
ptp 20480 1 e1000e, Live 0xffffffffc0020000
pps_core 20480 1 ptp, Live 0xffffffffc0016000
wmi 20480 1 mxm_wmi, Live 0xffffffffc000c000
fjes 28672 0 - Live 0xffffffffc0000000

[7.4.]
cat /proc/ioports
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
  00f0-00ff : PNP0C04:00
    00f0-00ff : fpu
  03c0-03df : vesafb
  0400-0403 : ACPI PM1a_EVT_BLK
  0404-0405 : ACPI PM1a_CNT_BLK
  0408-040b : ACPI PM_TMR
  0410-0415 : ACPI CPU throttle
  0420-042f : ACPI GPE0_BLK
    0428-042f : gpio_ich.1.auto
  0430-0433 : iTCO_wdt.0.auto
  0450-0450 : ACPI PM2_CNT_BLK
  0454-0457 : pnp 00:05
  0458-047f : pnp 00:04
    0460-047f : iTCO_wdt.0.auto
  04d0-04d1 : pnp 00:03
  0500-057f : gpio_ich.1.auto
    0500-057f : pnp 00:04
      0500-052f : gpio_ich
      0540-054f : gpio_ich
  0a00-0a1f : pnp 00:01
  0a20-0a2f : pnp 00:01
  0a30-0a3f : pnp 00:01
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
  1180-119f : pnp 00:04
  f000-f03f : 0000:00:02.0
  f040-f05f : 0000:00:1f.3
  f060-f07f : 0000:00:1f.2
    f060-f07f : ahci
  f080-f09f : 0000:00:19.0
  f0a0-f0a3 : 0000:00:1f.2
    f0a0-f0a3 : ahci
  f0b0-f0b7 : 0000:00:1f.2
    f0b0-f0b7 : ahci
  f0c0-f0c3 : 0000:00:1f.2
    f0c0-f0c3 : ahci
  f0d0-f0d7 : 0000:00:1f.2
    f0d0-f0d7 : ahci

cat /proc/iomem
00000000-00000fff : reserved
00001000-0009d7ff : System RAM
0009d800-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000cd7ff : Video ROM
000e0000-000fffff : reserved
  000f0000-000fffff : System ROM
00100000-1fffffff : System RAM
  01000000-017b83c6 : Kernel code
  017b83c7-01d380bf : Kernel data
  01eac000-01ff0fff : Kernel bss
20000000-201fffff : reserved
20200000-3fffffff : System RAM
40000000-401fffff : reserved
40200000-bc8ddfff : System RAM
bc8de000-bc92efff : ACPI Non-volatile Storage
bc92f000-bc9abfff : reserved
bc9ac000-bccacfff : ACPI Non-volatile Storage
bccad000-bccc1fff : reserved
bccc2000-bccc2fff : System RAM
bccc3000-bccd2fff : reserved
bccd3000-bcce0fff : ACPI Non-volatile Storage
bcce1000-bcd36fff : reserved
bcd37000-bcd79fff : ACPI Non-volatile Storage
bcd7a000-bcffffff : System RAM
bd000000-bd7fffff : RAM buffer
bd800000-bf9fffff : reserved
  bda00000-bf9fffff : Graphics Stolen Memory
bfa00000-ffffffff : PCI Bus 0000:00
  d0000000-dfffffff : 0000:00:02.0
  e0000000-efffffff : PCI MMCONFIG 0000 [bus 00-ff]
    e0000000-efffffff : pnp 00:00
  fe000000-fe3fffff : 0000:00:02.0
  fe400000-fe41ffff : 0000:00:19.0
    fe400000-fe41ffff : e1000e
  fe420000-fe423fff : 0000:00:1b.0
    fe420000-fe423fff : ICH HD audio
  fe424000-fe4240ff : 0000:00:1f.3
  fe425000-fe4257ff : 0000:00:1f.2
    fe425000-fe4257ff : ahci
  fe426000-fe4263ff : 0000:00:1d.0
    fe426000-fe4263ff : ehci_hcd
  fe427000-fe4273ff : 0000:00:1a.0
    fe427000-fe4273ff : ehci_hcd
  fe428000-fe428fff : 0000:00:19.0
    fe428000-fe428fff : e1000e
  fe429000-fe42900f : 0000:00:16.0
    fe429000-fe42900f : mei_me
  fec00000-fec003ff : IOAPIC 0
  fed00000-fed003ff : HPET 0
    fed00000-fed003ff : PNP0103:00
  fed08000-fed08fff : pnp 00:04
  fed10000-fed19fff : pnp 00:00
  fed1c000-fed1ffff : reserved
    fed1c000-fed1ffff : pnp 00:04
      fed1f410-fed1f414 : iTCO_wdt.0.auto
  fed20000-fed3ffff : pnp 00:00
  fed90000-fed93fff : pnp 00:00
  fee00000-fee0ffff : pnp 00:00
    fee00000-fee00fff : Local APIC
  ff000000-ffffffff : reserved
    ff000000-ffffffff : pnp 00:04
100000000-13fdfffff : System RAM
13fe00000-13fffffff : RAM buffer

[7.5.]
sudo lspci -vvv
00:00.0 Host bridge: Intel Corporation 2nd Generation Core Processor
=46amily DRAM Controller (rev 09)
    Subsystem: Acer Incorporated [ALI] Device 0492
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR- INTx-
    Latency: 0
    Capabilities: [e0] Vendor Specific Information: Len=3D0c <?>
    Kernel driver in use: snb_uncore

00:02.0 VGA compatible controller: Intel Corporation 2nd Generation
Core Processor Family Integrated Graphics Controller (rev 09) (prog-if
00 [VGA controller])
    DeviceName:  Onboard Graphics
    Subsystem: Acer Incorporated [ALI] Device 0492
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 26
    Region 0: Memory at fe000000 (64-bit, non-prefetchable) [size=3D4M]
    Region 2: Memory at d0000000 (64-bit, prefetchable) [size=3D256M]
    Region 4: I/O ports at f000 [size=3D64]
    Expansion ROM at <unassigned> [disabled]
    Capabilities: [90] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
        Address: fee0f00c  Data: 41a1
    Capabilities: [d0] Power Management version 2
        Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
    Capabilities: [a4] PCI Advanced Features
        AFCap: TP+ FLR+
        AFCtrl: FLR-
        AFStatus: TP-
    Kernel driver in use: i915

00:16.0 Communication controller: Intel Corporation 6 Series/C200
Series Chipset Family MEI Controller #1 (rev 04)
    Subsystem: Acer Incorporated [ALI] Device 0492
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 27
    Region 0: Memory at fe429000 (64-bit, non-prefetchable) [size=3D16]
    Capabilities: [50] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
    Capabilities: [8c] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
        Address: 00000000fee0f00c  Data: 41b1
    Kernel driver in use: mei_me

00:19.0 Ethernet controller: Intel Corporation 82579V Gigabit Network
Connection (rev 05)
    DeviceName:  Onboard Intel Ethernet
    Subsystem: Acer Incorporated [ALI] Device 8000
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 24
    Region 0: Memory at fe400000 (32-bit, non-prefetchable) [size=3D128=
K]
    Region 1: Memory at fe428000 (32-bit, non-prefetchable) [size=3D4K]
    Region 2: I/O ports at f080 [size=3D32]
    Capabilities: [c8] Power Management version 2
        Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D1 PME-
    Capabilities: [d0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
        Address: 00000000fee0100c  Data: 4152
    Capabilities: [e0] PCI Advanced Features
        AFCap: TP+ FLR+
        AFCtrl: FLR-
        AFStatus: TP-
    Kernel driver in use: e1000e

00:1a.0 USB controller: Intel Corporation 6 Series/C200 Series Chipset
=46amily USB Enhanced Host Controller #2 (rev 05) (prog-if 20 [EHCI])
    Subsystem: Acer Incorporated [ALI] Device 0492
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 16
    Region 0: Memory at fe427000 (32-bit, non-prefetchable) [size=3D1K]
    Capabilities: [50] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
    Capabilities: [58] Debug port: BAR=3D1 offset=3D00a0
    Capabilities: [98] PCI Advanced Features
        AFCap: TP+ FLR+
        AFCtrl: FLR-
        AFStatus: TP+
    Kernel driver in use: ehci-pci

00:1b.0 Audio device: Intel Corporation 6 Series/C200 Series Chipset
=46amily High Definition Audio Controller (rev 05)
    Subsystem: Acer Incorporated [ALI] Device 0492
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 28
    Region 0: Memory at fe420000 (64-bit, non-prefetchable) [size=3D16K=
]
    Capabilities: [50] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D55mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
    Capabilities: [60] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
        Address: 00000000fee0f00c  Data: 41d1
    Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, M=
SI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0
            ExtTag- RBE-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupp=
orted-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ Tra=
nsPend-
    Capabilities: [100 v1] Virtual Channel
        Caps:    LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
        Arb:    Fixed- WRR32- WRR64- WRR128-
        Ctrl:    ArbSelect=3DFixed
        Status:    InProgress-
        VC0:    Caps:    PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
            Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
            Ctrl:    Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3D01
            Status:    NegoPending- InProgress-
        VC1:    Caps:    PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
            Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
            Ctrl:    Enable+ ID=3D1 ArbSelect=3DFixed TC/VC=3D22
            Status:    NegoPending- InProgress-
    Capabilities: [130 v1] Root Complex Link
        Desc:    PortNumber=3D0f ComponentID=3D00 EltType=3DConfig
        Link0:    Desc:    TargetPort=3D00 TargetComponent=3D00 AssocRC=
RB-
LinkType=3DMemMapped LinkValid+
            Addr:    00000000fed1c000
    Kernel driver in use: snd_hda_intel

00:1d.0 USB controller: Intel Corporation 6 Series/C200 Series Chipset
=46amily USB Enhanced Host Controller #1 (rev 05) (prog-if 20 [EHCI])
    Subsystem: Acer Incorporated [ALI] Device 0492
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 23
    Region 0: Memory at fe426000 (32-bit, non-prefetchable) [size=3D1K]
    Capabilities: [50] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
    Capabilities: [58] Debug port: BAR=3D1 offset=3D00a0
    Capabilities: [98] PCI Advanced Features
        AFCap: TP+ FLR+
        AFCtrl: FLR-
        AFStatus: TP-
    Kernel driver in use: ehci-pci

00:1f.0 ISA bridge: Intel Corporation H67 Express Chipset Family LPC
Controller (rev 05)
    Subsystem: Acer Incorporated [ALI] Device 0492
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Capabilities: [e0] Vendor Specific Information: Len=3D0c <?>
    Kernel driver in use: lpc_ich

00:1f.2 SATA controller: Intel Corporation 6 Series/C200 Series
Chipset Family SATA AHCI Controller (rev 05) (prog-if 01 [AHCI 1.0])
    DeviceName:  Onboard Intel SATA Controller
    Subsystem: Acer Incorporated [ALI] Device 0492
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin B routed to IRQ 25
    Region 0: I/O ports at f0d0 [size=3D8]
    Region 1: I/O ports at f0c0 [size=3D4]
    Region 2: I/O ports at f0b0 [size=3D8]
    Region 3: I/O ports at f0a0 [size=3D4]
    Region 4: I/O ports at f060 [size=3D32]
    Region 5: Memory at fe425000 (32-bit, non-prefetchable) [size=3D2K]
    Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
        Address: fee0500c  Data: 4191
    Capabilities: [70] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot+,D3cold-)
        Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
    Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=3D00000004
    Capabilities: [b0] PCI Advanced Features
        AFCap: TP+ FLR+
        AFCtrl: FLR-
        AFStatus: TP-
    Kernel driver in use: ahci

00:1f.3 SMBus: Intel Corporation 6 Series/C200 Series Chipset Family
SMBus Controller (rev 05)
    Subsystem: Acer Incorporated [ALI] Device 0492
    Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Interrupt: pin C routed to IRQ 11
    Region 0: Memory at fe424000 (64-bit, non-prefetchable) [size=3D256=
]
    Region 4: I/O ports at f040 [size=3D32]

[7.6.]
cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: SSD G3 Series 12 Rev: 2
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: Slimtype Model: DVD A  DS8A5SH   Rev: XA15
  Type:   CD-ROM                           ANSI  SCSI revision: 05

[7.7.]
ls /proc
1     1179  1569  1843  34   603  734  890        diskstats    net
10    1191  157   19    35   605  735  892        dma          pagetype=
info
1003  1193  1575  2     36   62   738  9          driver       partitio=
ns
1007  12    158   2025  37   626  74   913        execdomains  sched_de=
bug
1008  1203  1582  2038  38   63   75   917        fb           schedsta=
t
1012  1206  159   2039  39   64   76   92         filesystems  scsi
1015  1216  160   21    392  65   77   921        fs           self
1018  1238  161   215   40   652  78   927        interrupts   slabinfo
1026  1271  162   217   404  66   79   928        iomem        softirqs
1027  1273  1629  218   42   660  8    932        ioports      stat
1030  1275  163   22    43   669  80   936        irq          swaps
1033  13    164   23    433  67   81   942        kallsyms     sys
105   1300  1647  24    434  678  82   945        kcore        sysrq-tr=
igger
106   1311  17    25    45   68   824  946        keys         sysvipc
1082  1315  1715  258   46   686  83   952        key-users    thread-s=
elf
11    1318  173   26    462  687  831  983        kmsg         timer_li=
st
1100  1341  174   264   47   69   84   992        kpagecgroup  timer_st=
ats
1112  1350  175   27    493  693  843  acpi       kpagecount   tty
1116  149   1763  271   5    7    85   asound     kpageflags   uptime
1129  15    1772  28    594  70   86   buddyinfo  loadavg      version
1135  150   1793  284   595  71   868  bus        locks        vmalloci=
nfo
1138  153   18    29    597  710  87   cgroups    mdstat       vmstat
1148  154   1804  3     598  72   876  cmdline    meminfo      zoneinfo
1158  1541  1811  30    599  722  879  consoles   misc
1164  155   1812  31    600  724  881  cpuinfo    modules
1169  1551  1841  32    601  729  883  crypto     mounts
1173  156   1842  33    602  73   885  devices    mtrr

[X.] Launchpad Bug Report
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1514310
    Workaround that 70% of the time allows single touches to work
until the system is rebooted.
    xinput set-mode [id] RELATIVE
    xinput set-mode [id] ABSOLUTE
    sudo rmmod hid-multitouch
    sudo modprobe hid-multitouch

    xinput --list
        =E2=86=B3 Quanta Computer OpticalTouchScreen id=3D12 [slave poi=
nter (2)]
    lsusb
            Bus 001 Device 005: ID 0408:3003 Quanta Computer, Inc.
    lsmod
        hid 118784 7 hid_multitouch,usbhid,hid_logitech_dj,hid_logitech=
_hidpp
    dmesg (most recent output after many attempts following elmarikon's=
 "fix")
        input: Quanta Computer OpticalTouchScreen as
/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.6/1-1.6:1.0/0003:0408:300=
3.0007/input/input16
        hid-multitouch 0003:0408:3003.0007: input,hiddev0,hidraw4: USB
HID v1.10 Mouse [Quanta Computer OpticalTouchScreen] on
usb-0000:00:1a.0-1.6/input0
        hid-multitouch 0003:0408:3003.0007: usb_submit_urb(ctrl) failed=
: -1
        hid-multitouch 0003:0408:3003.0007: usb_submit_urb(ctrl) failed=
: -1
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
