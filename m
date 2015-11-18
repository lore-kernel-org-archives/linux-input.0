From: Rich K <rgkirch@gmail.com>
Subject: https://bugs.launchpad.net/bugs/1513297
Date: Wed, 18 Nov 2015 11:54:29 -0500
Message-ID: <CAMerc7ZuLertS-WYW3HLkpa4WSHUDKBEzyLahJwSePdGEF1D+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:36541 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752805AbbKRQzJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Nov 2015 11:55:09 -0500
Received: by igcph11 with SMTP id ph11so105821196igc.1
        for <linux-input@vger.kernel.org>; Wed, 18 Nov 2015 08:55:08 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

XE500C12-K01US Samsung Chromebook 2 Ubuntu 14.04 touchpad not responsive
The chromebook is new and the touchpad worked great with chromiumos
but not at all with Ubuntu.
I used John Lewis's script to flash seabios to the chromebook and then
installed Ubuntu like normal from a USB drive.
I filed a bug report for it on launchpad and Christopher M. Penalver
responded asking me to try Ubuntu 16.04 with the latest version of the
kernel. I used the kernel from
http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.3-wily/ and the
problem persisted.
Before filing this report, I noticed a new folder for
http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.4-rc1-wily/ with only
linux-headers-4.4.0-040400rc1_4.4.0-040400rc1.201511152030_all.deb so
I ran
$ sudo dpkg -i linux-headers-4.4.0-040400rc1_4.4.0-040400rc1.201511152030_all.deb
and rebooted before getting the information for this report. I still
only saw the 4.3 entry in grub. I'm guessing that's because this was
just the headers file and not the image file.

Link to bug report on launchpad.
https://bugs.launchpad.net/bugs/1513297

I'm following the format found on.
https://wiki.ubuntu.com/Bugs/Upstream/kernel

$ cat /proc/version
Linux version 4.3.0-040300-generic (kernel@gomeisa) (gcc version 5.2.1
20151010 (Ubuntu 5.2.1-22ubuntu2) ) #201511020949 SMP Mon Nov 2
14:50:44 UTC 2015

$ lsb_release -rd
Description:    Ubuntu Xenial Xerus (development branch)
Release:    16.04

$ /usr/src/linux-headers-4.4.0-040400rc1/scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux winky 4.3.0-040300-generic #201511020949 SMP Mon Nov 2 14:50:44
UTC 2015 x86_64 x86_64 x86_64 GNU/Linux

GNU C            5.2.1
GNU Make        4.0
Binutils        2.25.51.20151106
Util-linux        2.27.1
Mount            2.27.1
Module-init-tools    21
E2fsprogs        1.42.13
Pcmciautils        018
PPP            2.4.6
Linux C Library        2.21
Dynamic linker (ldd)    2.21
Linux C++ Library    6.0.21
Procps            3.3.9
Net-tools        1.60
Kbd            1.15.5
Console-tools        1.15.5
Sh-utils        8.23
Udev            227
Wireless-tools        30
Modules Loaded        8250_dw ac97_bus acpi_thermal_rel ansi_cprng
arc4 atmel_mxt_ts autofs4 binfmt_misc bluetooth bnep btbcm btintel
btrtl btusb ccm cfg80211 coretemp crc32_pclmul crct10dif_pclmul cryptd
ctr drbg drm drm_kms_helper dw_dmac dw_dmac_core fb_sys_fops fjes hid
hid_logitech_dj hid_logitech_hidpp i2c_algo_bit i2c_designware_core
i2c_designware_platform i915 input_leds int3400_thermal
int3403_thermal int340x_thermal_zone intel_powerclamp intel_rapl
intel_soc_dts_iosf iosf_mbi iwlmvm iwlwifi joydev kvm kvm_intel lp
lpc_ich mac80211 mac_hid media mei mei_txe mmc_block parport
parport_pc ppdev processor_thermal_device punit_atom_debug pwm_lpss
pwm_lpss_platform rfcomm sdhci sdhci_acpi serio_raw shpchp snd
snd_compress snd_hda_codec snd_hda_codec_hdmi snd_hda_core
snd_hda_intel snd_hwdep snd_intel_sst_acpi snd_intel_sst_core snd_pcm
snd_pcm_dmaengine snd_rawmidi snd_seq snd_seq_device snd_seq_midi
snd_seq_midi_event snd_soc_core snd_soc_max98090 snd_soc_sst_acpi
snd_soc_sst_baytrail_pcm snd_soc_sst_byt_max98090_mach snd_soc_sst_dsp
snd_soc_sst_ipc snd_soc_sst_mfld_platform snd_timer soundcore
spi_pxa2xx_platform syscopyarea sysfillrect sysimgblt tpm_infineon
usbhid uvcvideo v4l2_common video videobuf2_core videobuf2_memops
videobuf2_vmalloc videodev

$ /proc/cpuinfo
processor    : 0
vendor_id    : GenuineIntel
cpu family    : 6
model        : 55
model name    : Intel(R) Celeron(R) CPU  N2840  @ 2.16GHz
stepping    : 8
microcode    : 0x829
cpu MHz        : 1482.642
cache size    : 1024 KB
physical id    : 0
siblings    : 2
core id        : 0
cpu cores    : 2
apicid        : 0
initial apicid    : 0
fpu        : yes
fpu_exception    : yes
cpuid level    : 11
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl
vmx est tm2 ssse3 cx16 xtpr pdcm sse4_1 sse4_2 movbe popcnt
tsc_deadline_timer rdrand lahf_lm 3dnowprefetch ida arat epb dtherm
tpr_shadow vnmi flexpriority ept vpid tsc_adjust smep erms
bugs        :
bogomips    : 4326.40
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 1
vendor_id    : GenuineIntel
cpu family    : 6
model        : 55
model name    : Intel(R) Celeron(R) CPU  N2840  @ 2.16GHz
stepping    : 8
microcode    : 0x829
cpu MHz        : 1462.422
cache size    : 1024 KB
physical id    : 0
siblings    : 2
core id        : 1
cpu cores    : 2
apicid        : 2
initial apicid    : 2
fpu        : yes
fpu_exception    : yes
cpuid level    : 11
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl
vmx est tm2 ssse3 cx16 xtpr pdcm sse4_1 sse4_2 movbe popcnt
tsc_deadline_timer rdrand lahf_lm 3dnowprefetch ida arat epb dtherm
tpr_shadow vnmi flexpriority ept vpid tsc_adjust smep erms
bugs        :
bogomips    : 4326.40
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:


$ /proc/modules
joydev 20480 0 - Live 0x0000000000000000
drbg 32768 1 - Live 0x0000000000000000
ansi_cprng 16384 0 - Live 0x0000000000000000
ctr 16384 2 - Live 0x0000000000000000
ccm 20480 2 - Live 0x0000000000000000
rfcomm 69632 0 - Live 0x0000000000000000
snd_hda_codec_hdmi 49152 1 - Live 0x0000000000000000
binfmt_misc 20480 1 - Live 0x0000000000000000
bnep 20480 2 - Live 0x0000000000000000
intel_rapl 20480 0 - Live 0x0000000000000000
intel_powerclamp 16384 0 - Live 0x0000000000000000
coretemp 16384 0 - Live 0x0000000000000000
kvm_intel 163840 0 - Live 0x0000000000000000
kvm 507904 1 kvm_intel, Live 0x0000000000000000
snd_soc_sst_baytrail_pcm 28672 2 - Live 0x0000000000000000
punit_atom_debug 16384 0 - Live 0x0000000000000000
snd_soc_sst_byt_max98090_mach 16384 0 - Live 0x0000000000000000
snd_soc_sst_ipc 16384 1 snd_soc_sst_baytrail_pcm, Live 0x0000000000000000
snd_soc_sst_dsp 53248 1 snd_soc_sst_baytrail_pcm, Live 0x0000000000000000
crct10dif_pclmul 16384 0 - Live 0x0000000000000000
crc32_pclmul 16384 0 - Live 0x0000000000000000
arc4 16384 2 - Live 0x0000000000000000
cryptd 20480 0 - Live 0x0000000000000000
uvcvideo 90112 0 - Live 0x0000000000000000
videobuf2_vmalloc 16384 1 uvcvideo, Live 0x0000000000000000
videobuf2_memops 16384 1 videobuf2_vmalloc, Live 0x0000000000000000
input_leds 16384 0 - Live 0x0000000000000000
serio_raw 16384 0 - Live 0x0000000000000000
videobuf2_core 49152 1 uvcvideo, Live 0x0000000000000000
v4l2_common 16384 1 videobuf2_core, Live 0x0000000000000000
videodev 172032 3 uvcvideo,videobuf2_core,v4l2_common, Live 0x0000000000000000
media 24576 2 uvcvideo,videodev, Live 0x0000000000000000
btusb 45056 0 - Live 0x0000000000000000
btrtl 16384 1 btusb, Live 0x0000000000000000
iwlmvm 307200 0 - Live 0x0000000000000000
btbcm 16384 1 btusb, Live 0x0000000000000000
btintel 16384 1 btusb, Live 0x0000000000000000
bluetooth 512000 27 rfcomm,bnep,btusb,btrtl,btbcm,btintel, Live
0x0000000000000000
mac80211 720896 1 iwlmvm, Live 0x0000000000000000
snd_soc_max98090 98304 1 - Live 0x0000000000000000
snd_intel_sst_acpi 16384 0 - Live 0x0000000000000000
snd_intel_sst_core 73728 1 snd_intel_sst_acpi, Live 0x0000000000000000
snd_seq_midi 16384 0 - Live 0x0000000000000000
snd_soc_sst_mfld_platform 86016 1 snd_intel_sst_core, Live 0x0000000000000000
snd_seq_midi_event 16384 1 snd_seq_midi, Live 0x0000000000000000
iwlwifi 204800 1 iwlmvm, Live 0x0000000000000000
snd_soc_core 192512 4
snd_soc_sst_baytrail_pcm,snd_soc_sst_byt_max98090_mach,snd_soc_max98090,snd_soc_sst_mfld_platform,
Live 0x0000000000000000
snd_rawmidi 32768 1 snd_seq_midi, Live 0x0000000000000000
snd_hda_intel 36864 0 - Live 0x0000000000000000
snd_hda_codec 135168 2 snd_hda_codec_hdmi,snd_hda_intel, Live 0x0000000000000000
snd_compress 20480 1 snd_soc_core, Live 0x0000000000000000
ac97_bus 16384 1 snd_soc_core, Live 0x0000000000000000
snd_hda_core 65536 3 snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec,
Live 0x0000000000000000
snd_pcm_dmaengine 16384 1 snd_soc_core, Live 0x0000000000000000
snd_hwdep 16384 1 snd_hda_codec, Live 0x0000000000000000
cfg80211 536576 3 iwlmvm,mac80211,iwlwifi, Live 0x0000000000000000
snd_pcm 102400 9
snd_hda_codec_hdmi,snd_soc_sst_baytrail_pcm,snd_soc_max98090,snd_soc_sst_mfld_platform,snd_soc_core,snd_hda_intel,snd_hda_codec,snd_hda_core,snd_pcm_dmaengine,
Live 0x0000000000000000
snd_seq 69632 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
lpc_ich 24576 0 - Live 0x0000000000000000
processor_thermal_device 16384 0 - Live 0x0000000000000000
intel_soc_dts_iosf 16384 1 processor_thermal_device, Live 0x0000000000000000
shpchp 36864 0 - Live 0x0000000000000000
mei_txe 20480 0 - Live 0x0000000000000000
snd_seq_device 16384 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x0000000000000000
iosf_mbi 16384 3 intel_rapl,punit_atom_debug,intel_soc_dts_iosf, Live
0x0000000000000000
mei 98304 1 mei_txe, Live 0x0000000000000000
snd_timer 32768 2 snd_pcm,snd_seq, Live 0x0000000000000000
int3403_thermal 16384 0 - Live 0x0000000000000000
snd 81920 12 snd_hda_codec_hdmi,snd_soc_sst_mfld_platform,snd_soc_core,snd_rawmidi,snd_hda_intel,snd_hda_codec,snd_compress,snd_hwdep,snd_pcm,snd_seq,snd_seq_device,snd_timer,
Live 0x0000000000000000
int340x_thermal_zone 16384 2 processor_thermal_device,int3403_thermal,
Live 0x0000000000000000
tpm_infineon 20480 0 - Live 0x0000000000000000
dw_dmac 16384 0 - Live 0x0000000000000000
int3400_thermal 16384 0 - Live 0x0000000000000000
soundcore 16384 1 snd, Live 0x0000000000000000
dw_dmac_core 24576 2 snd_soc_sst_dsp,dw_dmac, Live 0x0000000000000000
atmel_mxt_ts 32768 0 - Live 0x0000000000000000
acpi_thermal_rel 16384 1 int3400_thermal, Live 0x0000000000000000
spi_pxa2xx_platform 24576 0 - Live 0x0000000000000000
i2c_designware_platform 16384 0 - Live 0x0000000000000000
8250_dw 16384 0 - Live 0x0000000000000000
snd_soc_sst_acpi 16384 0 - Live 0x0000000000000000
i2c_designware_core 16384 1 i2c_designware_platform, Live 0x0000000000000000
pwm_lpss_platform 16384 0 - Live 0x0000000000000000
mac_hid 16384 0 - Live 0x0000000000000000
pwm_lpss 16384 1 pwm_lpss_platform, Live 0x0000000000000000
parport_pc 32768 0 - Live 0x0000000000000000
ppdev 20480 0 - Live 0x0000000000000000
lp 20480 0 - Live 0x0000000000000000
parport 49152 3 parport_pc,ppdev,lp, Live 0x0000000000000000
autofs4 40960 2 - Live 0x0000000000000000
hid_logitech_hidpp 20480 0 - Live 0x0000000000000000
hid_logitech_dj 20480 0 - Live 0x0000000000000000
usbhid 49152 0 - Live 0x0000000000000000
hid 118784 4 hid_logitech_hidpp,hid_logitech_dj,usbhid, Live 0x0000000000000000
mmc_block 36864 5 - Live 0x0000000000000000
i915 1134592 3 - Live 0x0000000000000000
video 36864 1 i915, Live 0x0000000000000000
i2c_algo_bit 16384 1 i915, Live 0x0000000000000000
drm_kms_helper 131072 1 i915, Live 0x0000000000000000
syscopyarea 16384 1 drm_kms_helper, Live 0x0000000000000000
sysfillrect 16384 1 drm_kms_helper, Live 0x0000000000000000
sysimgblt 16384 1 drm_kms_helper, Live 0x0000000000000000
fb_sys_fops 16384 1 drm_kms_helper, Live 0x0000000000000000
drm 352256 4 i915,drm_kms_helper, Live 0x0000000000000000
sdhci_acpi 16384 0 - Live 0x0000000000000000
fjes 28672 0 - Live 0x0000000000000000
sdhci 45056 1 sdhci_acpi, Live 0x0000000000000000

$ /proc/ioports
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
  0200-0200 : pnp 00:05
  0204-0204 : pnp 00:05
  03f8-03ff : serial
  0400-0405 : ACPI CPU throttle
  0408-040b : ACPI PM_TMR
  0420-042f : ACPI GPE0_BLK
  0430-0433 : iTCO_wdt.0.auto
  0450-0450 : ACPI PM2_CNT_BLK
  0460-047f : iTCO_wdt.0.auto
  0800-087f : pnp 00:05
  0880-08ff : pnp 00:05
  0900-09fe : pnp 00:04
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
  1000-1007 : 0000:00:02.0

$ /proc/iomem
00000000-feafffff : PCI Bus 0000:00
  00000000-00000fff : reserved
  00001000-0009fbff : System RAM
  0009fc00-0009ffff : reserved
  000c0000-000c7fff : Video ROM
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
    000f0000-000fffff : reserved
      000f0000-000fffff : System ROM
  00100000-1fffffff : System RAM
    01000000-017b83c6 : Kernel code
    017b83c7-01d380bf : Kernel data
    01eac000-01ff0fff : Kernel bss
  20000000-200fffff : reserved
    20000000-200fffff : 80860F28:00
  20100000-7ae5bfff : System RAM
  7ae5c000-7fffffff : reserved
    7ae77000-7af76fff : GOOG9999:00
    7c000000-7fffffff : Graphics Stolen Memory
  c0000000-cfffffff : 0000:00:02.0
  d0000000-d03fffff : 0000:00:02.0
  d0400000-d05fffff : 80860F28:00
  d0600000-d06fffff : 0000:00:1a.0
  d0700000-d07fffff : 0000:00:1a.0
  d0800000-d08fffff : PCI Bus 0000:01
    d0800000-d0801fff : 0000:01:00.0
      d0800000-d0801fff : iwlwifi
  d0900000-d090ffff : 0000:00:14.0
    d0900000-d090ffff : xhci-hcd
  d0910000-d0910fff : INTL9C60:00
    d0910000-d0910fff : INTL9C60:00
  d0914000-d0917fff : 0000:00:1b.0
    d0914000-d0917fff : ICH HD audio
  d0918000-d0918fff : INTL9C60:01
    d0918000-d0918fff : INTL9C60:01
  d091c000-d091cfff : 80860F16:00
    d091c000-d091cfff : 80860F16:00
  d091e000-d091efff : 80860F28:00
  d091f000-d091ffff : 80860F14:00
    d091f000-d091ffff : 80860F14:00
  d0922000-d0922fff : 80860F41:00
    d0922000-d0922fff : 80860F41:00
  d0924000-d0924fff : 80860F41:01
    d0924000-d0924fff : 80860F41:01
  e0000000-efffffff : PCI MMCONFIG 0000 [bus 00-ff]
    e0000000-efffffff : reserved
      e00000d0-e00000db : INT33BD:00
feb00000-febfffff : reserved
  feb00000-febfffff : pnp 00:00
fec00000-fec003ff : IOAPIC 0
fed00000-fed003ff : HPET 0
  fed00000-fed003ff : pnp 00:01
fed01000-fed01fff : reserved
  fed01000-fed013ff : pnp 00:00
fed03000-fed03fff : reserved
  fed03000-fed033ff : pnp 00:00
    fed03008-fed0300c : iTCO_wdt.0.auto
fed05000-fed05fff : reserved
  fed05000-fed057ff : pnp 00:00
fed08000-fed08fff : reserved
  fed08000-fed083ff : pnp 00:00
fed0c000-fed0ffff : reserved
  fed0c000-fed0cfff : INT33FC:00
    fed0c000-fed0cfff : INT33FC:00
  fed0d000-fed0dfff : INT33FC:01
    fed0d000-fed0dfff : INT33FC:01
  fed0e000-fed0efff : INT33FC:02
    fed0e000-fed0efff : INT33FC:02
fed1c000-fed1cfff : reserved
  fed1c000-fed1c3ff : pnp 00:00
fed40000-fed44fff : PCI Bus 0000:00
fee00000-fee00fff : Local APIC
fef00000-feffffff : reserved
  fef00000-feffffff : pnp 00:00
ff000000-ffffffff : INT0800:00

$ sudo lspci -vvv
00:00.0 Host bridge: Intel Corporation Atom Processor Z36xxx/Z37xxx
Series SoC Transaction Register (rev 0e)
    Subsystem: Intel Corporation Device 0f31
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Kernel driver in use: iosf_mbi_pci

00:02.0 VGA compatible controller: Intel Corporation Atom Processor
Z36xxx/Z37xxx Series Graphics & Display (rev 0e) (prog-if 00 [VGA
controller])
    Subsystem: Intel Corporation Atom Processor Z36xxx/Z37xxx Series
Graphics & Display
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 263
    Region 0: Memory at d0000000 (32-bit, non-prefetchable) [size=4M]
    Region 2: Memory at c0000000 (32-bit, prefetchable) [size=256M]
    Region 4: I/O ports at 1000 [size=8]
    Expansion ROM at <unassigned> [disabled]
    Capabilities: [d0] Power Management version 2
        Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Address: fee0200c  Data: 41d2
    Capabilities: [b0] Vendor Specific Information: Len=07 <?>
    Kernel driver in use: i915

00:14.0 USB controller: Intel Corporation Atom Processor Z36xxx/Z37xxx
Series USB xHCI (rev 0e) (prog-if 30 [XHCI])
    Subsystem: Intel Corporation Atom Processor Z36xxx/Z37xxx Series USB xHCI
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 262
    Region 0: Memory at d0900000 (64-bit, non-prefetchable) [size=64K]
    Capabilities: [70] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
        Address: 00000000fee0300c  Data: 41b2
    Kernel driver in use: xhci_hcd

00:1a.0 Encryption controller: Intel Corporation Atom Processor
Z36xxx/Z37xxx Series Trusted Execution Engine (rev 0e)
    Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Interrupt: pin A routed to IRQ 0
    Region 0: Memory at d0600000 (32-bit, non-prefetchable) [size=1M]
    Region 1: Memory at d0700000 (32-bit, non-prefetchable) [size=1M]
    Capabilities: [80] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold-)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [a0] MSI: Enable- Count=1/1 Maskable- 64bit-
        Address: 00000000  Data: 0000

00:1b.0 Audio device: Intel Corporation Atom Processor Z36xxx/Z37xxx
Series High Definition Audio Controller (rev 0e)
    Subsystem: Intel Corporation Atom Processor Z36xxx/Z37xxx Series
High Definition Audio Controller
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 264
    Region 0: Memory at d0914000 (64-bit, non-prefetchable) [size=16K]
    Capabilities: [50] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Address: 00000000fee0300c  Data: 41a3
    Kernel driver in use: snd_hda_intel

00:1c.0 PCI bridge: Intel Corporation Atom Processor E3800 Series PCI
Express Root Port 1 (rev 0e) (prog-if 00 [Normal decode])
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 261
    Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
    I/O behind bridge: 0000f000-00000fff
    Memory behind bridge: d0800000-d08fffff
    Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
    BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0
            ExtTag- RBE+
        DevCtl:    Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
        LnkCap:    Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s <512ns, L1 <1us
            ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp-
        LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive+ BWMgmt+ ABWMgmt-
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
            Slot #0, PowerLimit 10.000W; Interlock- NoCompl+
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
HPIrq- LinkChg-
            Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
            Changed: MRL- PresDet- LinkState+
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
        RootCap: CRSVisible-
        RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF
Not Supported ARIFwd-
        DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis-, LTR-,
OBFF Disabled ARIFwd-
        LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
    Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Address: fee0300c  Data: 4192
    Capabilities: [90] Subsystem: Intel Corporation Atom Processor
E3800 Series PCI Express Root Port 1
    Capabilities: [a0] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [100 v1] Advanced Error Reporting
        UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UESvrt:    DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
        CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
        CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
        AERCap:    First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
    Kernel driver in use: pcieport

00:1f.0 ISA bridge: Intel Corporation Atom Processor Z36xxx/Z37xxx
Series Power Control Unit (rev 0e)
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Capabilities: [e0] Vendor Specific Information: Len=0c <?>
    Kernel driver in use: lpc_ich

01:00.0 Network controller: Intel Corporation Wireless 7260 (rev 93)
    Subsystem: Intel Corporation Dual Band Wireless-AC 7260
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 265
    Region 0: Memory at d0800000 (64-bit, non-prefetchable) [size=8K]
    Capabilities: [c8] Power Management version 3
        Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Address: 00000000fee0100c  Data: 4173
    Capabilities: [40] Express (v2) Endpoint, MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s
<512ns, L1 unlimited
            ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+ FLReset-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
        LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s <4us, L1 <32us
            ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
        LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
        DevCap2: Completion Timeout: Range B, TimeoutDis+, LTR+, OBFF Via WAKE#
        DevCtl2: Completion Timeout: 16ms to 55ms, TimeoutDis-, LTR-,
OBFF Disabled
        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
    Capabilities: [100 v1] Advanced Error Reporting
        UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
        CESta:    RxErr+ BadTLP+ BadDLLP+ Rollover- Timeout- NonFatalErr+
        CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
        AERCap:    First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
    Capabilities: [140 v1] Device Serial Number 6c-29-95-ff-ff-5c-34-65
    Capabilities: [14c v1] Latency Tolerance Reporting
        Max snoop latency: 0ns
        Max no snoop latency: 0ns
    Capabilities: [154 v1] Vendor Specific Information: ID=cafe Rev=1
Len=014 <?>
    Kernel driver in use: iwlwifi


$ cat /proc/scsi/scsi
#(nothing, the file is actually empty)

$ cat /proc/devices
Character devices:
  1 mem
  4 /dev/vc/0
  4 tty
  4 ttyS
  5 /dev/tty
  5 /dev/console
  5 /dev/ptmx
  5 ttyprintk
  6 lp
  7 vcs
 10 misc
 13 input
 21 sg
 29 fb
 81 video4linux
 89 i2c
 99 ppdev
108 ppp
116 alsa
128 ptm
136 pts
180 usb
189 usb_device
216 rfcomm
226 drm
246 media
247 mei
248 hidraw
249 bsg
250 watchdog
251 rtc
252 dimmctl
253 ndctl
254 tpm

Block devices:
  1 ramdisk
259 blkext
  7 loop
  8 sd
  9 md
 11 sr
 65 sd
 66 sd
 67 sd
 68 sd
 69 sd
 70 sd
 71 sd
128 sd
129 sd
130 sd
131 sd
132 sd
133 sd
134 sd
135 sd
179 mmc
252 device-mapper
253 virtblk
254 mdp

$ sudo lshw
winky
    description: Computer
    width: 64 bits
    capabilities: smbios-2.7 vsyscall32
  *-core
       description: Motherboard
       physical id: 0
     *-memory
          description: System memory
          physical id: 0
          size: 1918MiB
     *-cpu
          product: Intel(R) Celeron(R) CPU  N2840  @ 2.16GHz
          vendor: Intel Corp.
          physical id: 1
          bus info: cpu@0
          size: 2582MHz
          capacity: 2582MHz
          width: 64 bits
          capabilities: fpu fpu_exception wp vme de pse tsc msr pae
mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr
sse sse2 ss ht tm pbe syscall nx rdtscp x86-64 constant_tsc
arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf
pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm
sse4_1 sse4_2 movbe popcnt tsc_deadline_timer rdrand lahf_lm
3dnowprefetch ida arat epb dtherm tpr_shadow vnmi flexpriority ept
vpid tsc_adjust smep erms cpufreq
     *-pci
          description: Host bridge
          product: Atom Processor Z36xxx/Z37xxx Series SoC Transaction Register
          vendor: Intel Corporation
          physical id: 100
          bus info: pci@0000:00:00.0
          version: 0e
          width: 32 bits
          clock: 33MHz
          configuration: driver=iosf_mbi_pci
          resources: irq:0
        *-display
             description: VGA compatible controller
             product: Atom Processor Z36xxx/Z37xxx Series Graphics & Display
             vendor: Intel Corporation
             physical id: 2
             bus info: pci@0000:00:02.0
             version: 0e
             width: 32 bits
             clock: 33MHz
             capabilities: pm msi vga_controller bus_master cap_list rom
             configuration: driver=i915 latency=0
             resources: irq:263 memory:d0000000-d03fffff
memory:c0000000-cfffffff ioport:1000(size=8)
        *-usb
             description: USB controller
             product: Atom Processor Z36xxx/Z37xxx Series USB xHCI
             vendor: Intel Corporation
             physical id: 14
             bus info: pci@0000:00:14.0
             version: 0e
             width: 64 bits
             clock: 33MHz
             capabilities: pm msi xhci bus_master cap_list
             configuration: driver=xhci_hcd latency=0
             resources: irq:262 memory:d0900000-d090ffff
           *-usbhost:0
                product: xHCI Host Controller
                vendor: Linux 4.3.0-040300-generic xhci-hcd
                physical id: 0
                bus info: usb@2
                logical name: usb2
                version: 4.03
                capabilities: usb-3.00
                configuration: driver=hub slots=1 speed=5000Mbit/s
           *-usbhost:1
                product: xHCI Host Controller
                vendor: Linux 4.3.0-040300-generic xhci-hcd
                physical id: 1
                bus info: usb@1
                logical name: usb1
                version: 4.03
                capabilities: usb-2.00
                configuration: driver=hub slots=6 speed=480Mbit/s
              *-usb:0
                   description: Keyboard
                   product: USB Receiver
                   vendor: Logitech
                   physical id: 1
                   bus info: usb@1:1
                   version: 24.00
                   capabilities: usb-2.00
                   configuration: driver=usbhid maxpower=98mA speed=12Mbit/s
              *-usb:1
                   description: Video
                   product: Real HD WebCam
                   vendor: Generic
                   physical id: 3
                   bus info: usb@1:3
                   version: 50.72
                   serial: 200901010001
                   capabilities: usb-2.00
                   configuration: driver=uvcvideo maxpower=500mA speed=480Mbit/s
              *-usb:2
                   description: Bluetooth wireless interface
                   vendor: Intel Corp.
                   physical id: 4
                   bus info: usb@1:4
                   version: 0.01
                   capabilities: bluetooth usb-2.00
                   configuration: driver=btusb maxpower=100mA speed=12Mbit/s
        *-generic UNCLAIMED
             description: Encryption controller
             product: Atom Processor Z36xxx/Z37xxx Series Trusted
Execution Engine
             vendor: Intel Corporation
             physical id: 1a
             bus info: pci@0000:00:1a.0
             version: 0e
             width: 32 bits
             clock: 33MHz
             capabilities: pm msi cap_list
             configuration: latency=0
             resources: memory:d0600000-d06fffff memory:d0700000-d07fffff
        *-multimedia
             description: Audio device
             product: Atom Processor Z36xxx/Z37xxx Series High
Definition Audio Controller
             vendor: Intel Corporation
             physical id: 1b
             bus info: pci@0000:00:1b.0
             version: 0e
             width: 64 bits
             clock: 33MHz
             capabilities: pm msi bus_master cap_list
             configuration: driver=snd_hda_intel latency=0
             resources: irq:264 memory:d0914000-d0917fff
        *-pci
             description: PCI bridge
             product: Atom Processor E3800 Series PCI Express Root Port 1
             vendor: Intel Corporation
             physical id: 1c
             bus info: pci@0000:00:1c.0
             version: 0e
             width: 32 bits
             clock: 33MHz
             capabilities: pci pciexpress msi pm normal_decode
bus_master cap_list
             configuration: driver=pcieport
             resources: irq:261 memory:d0800000-d08fffff
           *-network
                description: Wireless interface
                product: Wireless 7260
                vendor: Intel Corporation
                physical id: 0
                bus info: pci@0000:01:00.0
                logical name: wlp1s0
                version: 93
                serial: 6c:29:95:5c:34:65
                width: 64 bits
                clock: 33MHz
                capabilities: pm msi pciexpress bus_master cap_list
ethernet physical wireless
                configuration: broadcast=yes driver=iwlwifi
driverversion=4.3.0-040300-generic firmware=25.30.13.0 ip=10.226.3.119
latency=0 link=yes multicast=yes wireless=IEEE 802.11abgn
                resources: irq:265 memory:d0800000-d0801fff
        *-isa
             description: ISA bridge
             product: Atom Processor Z36xxx/Z37xxx Series Power Control Unit
             vendor: Intel Corporation
             physical id: 1f
             bus info: pci@0000:00:1f.0
             version: 0e
             width: 32 bits
             clock: 33MHz
             capabilities: isa bus_master cap_list
             configuration: driver=lpc_ich latency=0
             resources: irq:0
