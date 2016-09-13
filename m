From: Eddie Stanley <eddie@eddiewould.com>
Subject: Logitech Precision Gamepad shows axis activity upon connection
Date: Tue, 13 Sep 2016 20:26:53 +1200
Message-ID: <CAPAjh3dvRNm_U1Ax41NwUA5rM-PYA+SUxZ5HUxu3Da6919YJCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37558 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751967AbcIMI04 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 13 Sep 2016 04:26:56 -0400
Received: by mail-wm0-f50.google.com with SMTP id c131so98844512wmh.0
        for <linux-input@vger.kernel.org>; Tue, 13 Sep 2016 01:26:55 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: gregkh@linuxfoundation.org

SUMMARY:
Logitech Precision Gamepad shows axis activity upon connection

DESCRIPTION:
When I connect my Logitech Precision Gamepad (or the machine starts up
with it connected) it exhibits activity on both axes until I press a
button/press the d-pad.

eddie@codey:~$ cat /proc/version
Linux version 4.8.0-040800rc5-generic (kernel@tangerine) (gcc version
6.2.0 20160830 (Ubuntu 6.2.0-2ubuntu11) ) #201609041832 SMP Sun Sep 4
22:34:01 UTC 2016

Output from jstest i.e. jstest /dev/input/js0

UPON PLUGGING USB CONNECTOR IN:
=================================
Driver version is 2.1.0.
Joystick (Logitech Logitech(R) Precision(TM) Gamepad) has 2 axes (X, Y)
and 10 buttons (Trigger, ThumbBtn, ThumbBtn2, TopBtn, TopBtn2,
PinkieBtn, BaseBtn, BaseBtn2, BaseBtn3, BaseBtn4).
Testing ... (interrupt to exit)
Axes: 0:-32767 1:-32767 Buttons: 0:off 1:off 2:off 3:off 4:off 5:off
6:off 7:off 8:off 9:off

AFTER PRESSING ANY BUTTON OR THE D-PAD:
=======================================
Driver version is 2.1.0.
Joystick (Logitech Logitech(R) Precision(TM) Gamepad) has 2 axes (X, Y)
and 10 buttons (Trigger, ThumbBtn, ThumbBtn2, TopBtn, TopBtn2,
PinkieBtn, BaseBtn, BaseBtn2, BaseBtn3, BaseBtn4).
Testing ... (interrupt to exit)
Axes: 0: 0 1: 0 Buttons: 0:off 1:off 2:off 3:off 4:off 5:off 6:off 7:off
8:off 9:off

EXPECTED BEHAVIOUR:
===================
Both axes (0 & 1) should be "at rest" (i.e. 0, not +/- 32767) when the
gamepad is initially plugged in.

Note - I'm not sure whether the d-pad should be classified as a pair of
axes or a pair of hats - it is a digital d-pad though, *not* analog.

ENVIRONMENT:
============
eddie@codey:~$ lsb_release -rd
Description: Ubuntu 16.04.1 LTS
Release: 16.04

eddie@codey:/usr/src$ cat /proc/cpuinfo
processor : 0
vendor_id : GenuineIntel
cpu family : 6
model : 76
model name : Intel(R) Celeron(R) CPU  N3050  @ 1.60GHz
stepping : 3
microcode : 0x363
cpu MHz : 479.980
cache size : 1024 KB
physical id : 0
siblings : 2
core id : 0
cpu cores : 2
apicid : 0
initial apicid : 0
fpu : yes
fpu_exception : yes
cpuid level : 11
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx
est tm2 ssse3 cx16 xtpr pdcm sse4_1 sse4_2 movbe popcnt
tsc_deadline_timer aes rdrand lahf_lm 3dnowprefetch epb tpr_shadow vnmi
flexpriority ept vpid tsc_adjust smep erms dtherm ida arat
bugs :
bogomips : 3200.00
clflush size : 64
cache_alignment : 64
address sizes : 36 bits physical, 48 bits virtual
power management:

processor : 1
vendor_id : GenuineIntel
cpu family : model : 76
model name : Intel(R) Celeron(R) CPU  N3050  @ 1.60GHz
stepping : 3
microcode : 0x363
cpu MHz : 479.980
cache size : 1024 KB
physical id : 0
siblings : 2
core id : 2
cpu cores : 2
apicid : 4
initial apicid : 4
fpu : yes
fpu_exception : yes
cpuid level : 11
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx
est tm2 ssse3 cx16 xtpr pdcm sse4_1 sse4_2 movbe popcnt
tsc_deadline_timer aes rdrand lahf_lm 3dnowprefetch epb tpr_shadow vnmi
flexpriority ept vpid tsc_adjust smep erms dtherm ida arat
bugs :
bogomips : 3203.34
clflush size : 64
cache_alignment : 64
address sizes : 36 bits physical, 48 bits virtual
power management:

eddie@codey:/usr/src$ cat /proc/modules
hid_generic 16384 0 - Live 0x0000000000000000
rfcomm 77824 0 - Live 0x0000000000000000
ir_xmp_decoder 16384 0 - Live 0x0000000000000000
ir_mce_kbd_decoder 16384 0 - Live 0x0000000000000000
ir_sharp_decoder 16384 0 - Live 0x0000000000000000
ir_sanyo_decoder 16384 0 - Live 0x0000000000000000
ir_sony_decoder 16384 0 - Live 0x0000000000000000
ir_jvc_decoder 16384 0 - Live 0x0000000000000000
ir_nec_decoder 16384 0 - Live 0x0000000000000000
ir_rc5_decoder 16384 0 - Live 0x0000000000000000
bnep 20480 2 - Live 0x0000000000000000
ir_rc6_decoder 16384 0 - Live 0x0000000000000000
intel_rapl 20480 0 - Live 0x0000000000000000
intel_powerclamp 16384 0 - Live 0x0000000000000000
coretemp 16384 0 - Live 0x0000000000000000
kvm_intel 192512 0 - Live 0x0000000000000000
kvm 593920 1 kvm_intel, Live 0x0000000000000000
irqbypass 16384 1 kvm, Live 0x0000000000000000
crct10dif_pclmul 16384 0 - Live 0x0000000000000000
crc32_pclmul 16384 0 - Live 0x0000000000000000
ghash_clmulni_intel 16384 0 - Live 0x0000000000000000
aesni_intel 167936 0 - Live 0x0000000000000000
aes_x86_64 20480 1 aesni_intel, Live 0x0000000000000000
lrw 16384 1 aesni_intel, Live 0x0000000000000000
gf128mul 16384 1 lrw, Live 0x0000000000000000
glue_helper 16384 1 aesni_intel, Live 0x0000000000000000
ablk_helper 16384 1 aesni_intel, Live 0x0000000000000000
cryptd 24576 3 ghash_clmulni_intel,aesni_intel,ablk_helper, Live
0x0000000000000000
intel_cstate 20480 0 - Live 0x0000000000000000
arc4 16384 2 - Live 0x0000000000000000
iwlmvm 241664 0 - Live 0x0000000000000000
serio_raw 16384 0 - Live 0x0000000000000000
mac80211 663552 1 iwlmvm, Live 0x0000000000000000
joydev 20480 0 - Live 0x0000000000000000
iwlwifi 147456 1 iwlmvm, Live 0x0000000000000000
snd_hda_codec_hdmi 45056 1 - Live 0x0000000000000000
btusb 45056 0 - Live 0x0000000000000000
btrtl 16384 1 btusb, Live 0x0000000000000000
lpc_ich 24576 0 - Live 0x0000000000000000
snd_hda_codec_realtek 86016 1 - Live 0x0000000000000000
mfd_core 16384 1 lpc_ich, Live 0x0000000000000000
snd_hda_codec_generic 69632 1 snd_hda_codec_realtek, Live 0x0000000000000000
cfg80211 589824 3 iwlmvm,mac80211,iwlwifi, Live 0x0000000000000000
snd_soc_rt5670 126976 0 - Live 0x0000000000000000
snd_hda_intel 36864 1 - Live 0x0000000000000000
snd_intel_sst_acpi 16384 0 - Live 0x0000000000000000
snd_intel_sst_core 77824 1 snd_intel_sst_acpi, Live 0x0000000000000000
snd_hda_codec 135168 4
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,
Live 0x0000000000000000
sg 32768 0 - Live 0x0000000000000000
snd_soc_rl6231 16384 1 snd_soc_rt5670, Live 0x0000000000000000
snd_soc_sst_mfld_platform 90112 1 snd_intel_sst_core, Live
0x0000000000000000
snd_soc_sst_match 16384 1 snd_intel_sst_acpi, Live 0x0000000000000000
snd_hda_core 81920 5
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,
Live 0x0000000000000000
snd_hwdep 16384 1 snd_hda_codec, Live 0x0000000000000000
shpchp 36864 0 - Live 0x0000000000000000
snd_soc_core 217088 2 snd_soc_rt5670,snd_soc_sst_mfld_platform, Live
0x0000000000000000
snd_compress 20480 1 snd_soc_core, Live 0x0000000000000000
snd_pcm_dmaengine 16384 1 snd_soc_core, Live 0x0000000000000000
snd_pcm 110592 8
snd_hda_codec_hdmi,snd_soc_rt5670,snd_hda_intel,snd_hda_codec,snd_soc_sst_mfld_platform,snd_hda_core,snd_soc_core,snd_pcm_dmaengine,
Live 0x0000000000000000
i2c_designware_pci 16384 0 - Live 0x0000000000000000
snd_seq_midi 16384 0 - Live 0x0000000000000000
snd_seq_midi_event 16384 1 snd_seq_midi, Live 0x0000000000000000
snd_rawmidi 32768 1 snd_seq_midi, Live 0x0000000000000000
ir_lirc_codec 16384 3 - Live 0x0000000000000000
snd_seq 69632 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
battery 16384 0 - Live 0x0000000000000000
lirc_dev 20480 1 ir_lirc_codec, Live 0x0000000000000000
rc_rc6_mce 16384 0 - Live 0x0000000000000000
hci_uart 86016 0 - Live 0x0000000000000000
ite_cir 28672 0 - Live 0x0000000000000000
rc_core 28672 14
ir_xmp_decoder,ir_mce_kbd_decoder,ir_sharp_decoder,ir_sanyo_decoder,ir_sony_decoder,ir_jvc_decoder,ir_nec_decoder,ir_rc5_decoder,ir_rc6_decoder,ir_lirc_codec,lirc_dev,rc_rc6_mce,ite_cir,
Live 0x0000000000000000
snd_seq_device 16384 3 snd_seq_midi,snd_rawmidi,snd_seq, Live
0x0000000000000000
btbcm 16384 2 btusb,hci_uart, Live 0x0000000000000000
btqca 16384 1 hci_uart, Live 0x0000000000000000
snd_timer 32768 2 snd_pcm,snd_seq, Live 0x0000000000000000
btintel 16384 2 btusb,hci_uart, Live 0x0000000000000000
dw_dmac 16384 0 - Live 0x0000000000000000
dw_dmac_core 24576 1 dw_dmac, Live 0x0000000000000000
bluetooth 548864 31
rfcomm,bnep,btusb,btrtl,hci_uart,btbcm,btqca,btintel, Live
0x0000000000000000
snd 86016 16
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,snd_soc_sst_mfld_platform,snd_hwdep,snd_soc_core,snd_compress,snd_pcm,snd_rawmidi,snd_seq,snd_seq_device,snd_timer,
Live 0x0000000000000000
rfkill 24576 4 cfg80211,bluetooth, Live 0x0000000000000000
soundcore 16384 1 snd, Live 0x0000000000000000
i2c_designware_platform 16384 0 - Live 0x0000000000000000
i2c_designware_core 20480 2 i2c_designware_pci,i2c_designware_platform,
Live 0x0000000000000000
evdev 24576 21 - Live 0x0000000000000000
soc_button_array 16384 0 - Live 0x0000000000000000
tpm_tis 16384 0 - Live 0x0000000000000000
tpm_tis_core 20480 1 tpm_tis, Live 0x0000000000000000
tpm 45056 2 tpm_tis,tpm_tis_core, Live 0x0000000000000000
binfmt_misc 20480 1 - Live 0x0000000000000000
autofs4 40960 2 - Live 0x0000000000000000
ext4 589824 1 - Live 0x0000000000000000
crc16 16384 2 bluetooth,ext4, Live 0x0000000000000000
jbd2 110592 1 ext4, Live 0x0000000000000000
fscrypto 28672 1 ext4, Live 0x0000000000000000
mbcache 16384 2 ext4, Live 0x0000000000000000
sd_mod 45056 3 - Live 0x0000000000000000
hid_logitech_hidpp 28672 0 - Live 0x0000000000000000
hid_logitech_dj 20480 0 - Live 0x0000000000000000
usbhid 53248 0 - Live 0x0000000000000000
uas 24576 0 - Live 0x0000000000000000
usb_storage 69632 1 uas, Live 0x0000000000000000
crc32c_intel 24576 0 - Live 0x0000000000000000
psmouse 131072 0 - Live 0x0000000000000000
xhci_pci 16384 0 - Live 0x0000000000000000
xhci_hcd 188416 1 xhci_pci, Live 0x0000000000000000
r8169 81920 0 - Live 0x0000000000000000
mii 16384 1 r8169, Live 0x0000000000000000
usbcore 253952 6 btusb,usbhid,uas,usb_storage,xhci_pci,xhci_hcd, Live
0x0000000000000000
usb_common 16384 1 usbcore, Live 0x0000000000000000
fan 16384 0 - Live 0x0000000000000000
thermal 20480 0 - Live 0x0000000000000000
i915 1294336 4 - Live 0x0000000000000000
video 40960 1 i915, Live 0x0000000000000000
i2c_algo_bit 16384 1 i915, Live 0x0000000000000000
i2c_hid 20480 0 - Live 0x0000000000000000
drm_kms_helper 155648 1 i915, Live 0x0000000000000000
hid 118784 5
hid_generic,hid_logitech_hidpp,hid_logitech_dj,usbhid,i2c_hid, Live
0x0000000000000000
ahci 36864 2 - Live 0x0000000000000000
syscopyarea 16384 1 drm_kms_helper, Live 0x0000000000000000
libahci 32768 1 ahci, Live 0x0000000000000000
sysfillrect 16384 1 drm_kms_helper, Live 0x0000000000000000
sysimgblt 16384 1 drm_kms_helper, Live 0x0000000000000000
libata 249856 2 ahci,libahci, Live 0x0000000000000000
fb_sys_fops 16384 1 drm_kms_helper, Live 0x0000000000000000
drm 360448 5 i915,drm_kms_helper, Live 0x0000000000000000
sdhci_pci 28672 0 - Live 0x0000000000000000
scsi_mod 225280 5 sg,sd_mod,uas,usb_storage,libata, Live 0x0000000000000000
sdhci_acpi 16384 0 - Live 0x0000000000000000
sdhci 40960 2 sdhci_pci,sdhci_acpi, Live 0x0000000000000000
mmc_core 143360 3 sdhci_pci,sdhci_acpi,sdhci, Live 0x0000000000000000
fjes 28672 0 - Live 0x0000000000000000
button 16384 1 i915, Live 0x0000000000000000

eddie@codey:/usr/src$ cat /proc/ioports
0000-0000 : PCI Bus 0000:00
   0000-0000 : dma1
   0000-0000 : pic1
   0000-0000 : timer0
   0000-0000 : timer1
   0000-0000 : keyboard
   0000-0000 : keyboard
0000-0000 : PCI Bus 0000:00
   0000-0000 : rtc_cmos
     0000-0000 : rtc0
0000-0000 : PCI Bus 0000:00
   0000-0000 : dma page reg
   0000-0000 : pic2
   0000-0000 : dma2
   0000-0000 : fpu
   0000-0000 : ite-cir
   0000-0000 : pnp 00:00
     0000-0000 : ACPI PM1a_EVT_BLK
     0000-0000 : ACPI PM1a_CNT_BLK
     0000-0000 : ACPI PM_TMR
     0000-0000 : ACPI GPE0_BLK
     0000-0000 : iTCO_wdt.0.auto
     0000-0000 : ACPI PM2_CNT_BLK
     0000-0000 : iTCO_wdt.0.auto
   0000-0000 : pnp 00:00
   0000-0000 : pnp 00:00
   0000-0000 : pnp 00:01
   0000-0000 : pnp 00:01
   0000-0000 : pnp 00:01
0000-0000 : PCI conf1
0000-0000 : PCI Bus 0000:00
   0000-0000 : PCI Bus 0000:01
   0000-0000 : PCI Bus 0000:03
     0000-0000 : 0000:03:00.0
       0000-0000 : r8169
   0000-0000 : 0000:00:02.0
   0000-0000 : 0000:00:1f.3
   0000-0000 : 0000:00:13.0
     0000-0000 : ahci

eddie@codey:/usr/src$ cat /proc/iomem
00000000-00000000 : reserved
00000000-00000000 : System RAM
00000000-00000000 : reserved
00000000-00000000 : PCI Bus 0000:00
00000000-00000000 : PCI Bus 0000:00
   00000000-00000000 : Video ROM
00000000-00000000 : PCI Bus 0000:00
   00000000-00000000 : reserved
     00000000-00000000 : System ROM
00000000-00000000 : System RAM
   00000000-00000000 : Kernel code
   00000000-00000000 : Kernel data
   00000000-00000000 : Kernel bss
00000000-00000000 : reserved
00000000-00000000 : System RAM
00000000-00000000 : reserved
00000000-00000000 : ACPI Tables
00000000-00000000 : ACPI Non-volatile Storage
00000000-00000000 : reserved
00000000-00000000 : System RAM
00000000-00000000 : reserved
00000000-00000000 : System RAM
00000000-00000000 : reserved
   00000000-00000000 : Graphics Stolen Memory
00000000-00000000 : PCI Bus 0000:00
   00000000-00000000 : 0000:00:02.0
   00000000-00000000 : 0000:00:1a.0
   00000000-00000000 : 0000:00:1a.0
   00000000-00000000 : PCI Bus 0000:03
     00000000-00000000 : 0000:03:00.0
       00000000-00000000 : r8169
     00000000-00000000 : 0000:03:00.0
       00000000-00000000 : r8169
   00000000-00000000 : PCI Bus 0000:02
     00000000-00000000 : 0000:02:00.0
       00000000-00000000 : iwlwifi
   00000000-00000000 : 0000:00:14.0
     00000000-00000000 : xhci-hcd
   00000000-00000000 : 0000:00:1b.0
     00000000-00000000 : ICH HD audio
   00000000-00000000 : 0000:00:18.0
   00000000-00000000 : 0000:00:1f.3
   00000000-00000000 : 0000:00:18.7
     00000000-00000000 : 0000:00:18.7
   00000000-00000000 : 0000:00:18.6
     00000000-00000000 : 0000:00:18.6
   00000000-00000000 : 0000:00:13.0
     00000000-00000000 : ahci
   00000000-00000000 : 0000:00:12.0
     00000000-00000000 : mmc0
   00000000-00000000 : PCI Bus 0000:01
   00000000-00000000 : PCI Bus 0000:01
   00000000-00000000 : 0000:00:02.0
00000000-00000000 : PCI MMCONFIG 0000 [bus 00-ff]
   00000000-00000000 : reserved
     00000000-00000000 : pnp 00:04
00000000-00000000 : reserved
   00000000-00000000 : pnp 00:04
00000000-00000000 : reserved
   00000000-00000000 : IOAPIC 0
00000000-00000000 : reserved
   00000000-00000000 : pnp 00:04
00000000-00000000 : reserved
   00000000-00000000 : pnp 00:04
     00000000-00000000 : iTCO_wdt.0.auto
00000000-00000000 : reserved
   00000000-00000000 : pnp 00:04
00000000-00000000 : reserved
   00000000-00000000 : pnp 00:04
00000000-00000000 : reserved
   00000000-00000000 : pnp 00:04
00000000-00000000 : reserved
   00000000-00000000 : INT33FF:00
     00000000-00000000 : INT33FF:00
   00000000-00000000 : INT33FF:01
     00000000-00000000 : INT33FF:01
   00000000-00000000 : INT33FF:02
     00000000-00000000 : INT33FF:02
   00000000-00000000 : INT33FF:03
     00000000-00000000 : INT33FF:03
00000000-00000000 : Local APIC
   00000000-00000000 : reserved
00000000-00000000 : INT0800:00
   00000000-00000000 : reserved
00000000-00000000 : System RAM

eddie@codey:/usr/src$ sudo lspci -vvv
[sudo] password for eddie:
00:00.0 Host bridge: Intel Corporation Device 2280 (rev 21)
Subsystem: Intel Corporation Device 2060
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
Latency: 0
Kernel driver in use: iosf_mbi_pci

00:02.0 VGA compatible controller: Intel Corporation Device 22b1 (rev
21) (prog-if 00 [VGA controller])
DeviceName:  CPU
Subsystem: Intel Corporation Device 2060
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 310
Region 0: Memory at 80000000 (64-bit, non-prefetchable) [size=16M]
Region 2: Memory at 88000000 (64-bit, prefetchable) [size=128M]
Region 4: I/O ports at f000 [size=64]
[virtual] Expansion ROM at 000c0000 [disabled] [size=128K]
Capabilities: [d0] Power Management version 2
Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
Address: fee0200c  Data: 4122
Capabilities: [b0] Vendor Specific Information: Len=07 <?>
Kernel driver in use: i915
Kernel modules: i915

00:12.0 SD Host controller: Intel Corporation Device 2296 (rev 21)
(prog-if 01)
Subsystem: Intel Corporation Device 2060
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 18
Region 0: Memory at 8141c000 (32-bit, non-prefetchable) [size=4K]
Capabilities: [80] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold-)
Status: D3 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Kernel driver in use: sdhci-pci
Kernel modules: sdhci_pci

00:13.0 SATA controller: Intel Corporation Device 22a3 (rev 21) (prog-if
01 [AHCI 1.0])
Subsystem: Intel Corporation Device 2060
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 309
Region 4: I/O ports at f060 [size=32]
Region 5: Memory at 8141b000 (32-bit, non-prefetchable) [size=2K]
Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
Address: fee0200c  Data: 41d1
Capabilities: [70] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
Kernel driver in use: ahci
Kernel modules: ahci

00:14.0 USB controller: Intel Corporation Device 22b5 (rev 21) (prog-if
30 [XHCI])
Subsystem: Intel Corporation Device 2060
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 312
Region 0: Memory at 81400000 (64-bit, non-prefetchable) [size=64K]
Capabilities: [70] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
Address: 00000000fee0200c  Data: 4162
Kernel driver in use: xhci_hcd
Kernel modules: xhci_pci

00:18.0 DMA controller: Intel Corporation Device 22c0 (rev 21) (prog-if
02 [EISA DMA])
Subsystem: Intel Corporation Device 2060
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 11
Region 0: Memory at 81414000 (32-bit, non-prefetchable) [size=16K]
Capabilities: [80] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-

00:18.6 Serial bus controller [0c80]: Intel Corporation Device 22c6 (rev 21)
Subsystem: Intel Corporation Device 2060
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin D routed to IRQ 18
Region 0: Memory at 8141a000 (32-bit, non-prefetchable) [size=4K]
Capabilities: [80] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D3 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Kernel driver in use: i2c-designware-pci
Kernel modules: i2c_designware_pci

00:18.7 Serial bus controller [0c80]: Intel Corporation Device 22c7 (rev 21)
Subsystem: Intel Corporation Device 2060
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin B routed to IRQ 16
Region 0: Memory at 81419000 (32-bit, non-prefetchable) [size=4K]
Capabilities: [80] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D3 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Kernel driver in use: i2c-designware-pci
Kernel modules: i2c_designware_pci

00:1a.0 Encryption controller: Intel Corporation Device 2298 (rev 21)
Subsystem: Intel Corporation Device 2060
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 5
Region 0: Memory at 81100000 (32-bit, non-prefetchable) [size=1M]
Region 1: Memory at 81000000 (32-bit, non-prefetchable) [size=1M]
Capabilities: [80] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold-)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [a0] MSI: Enable- Count=1/1 Maskable- 64bit-
Address: 00000000  Data: 0000

00:1b.0 Audio device: Intel Corporation Device 2284 (rev 21)
DeviceName:  WIFI
Subsystem: Intel Corporation Device 2060
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 313
Region 0: Memory at 81410000 (64-bit, non-prefetchable) [size=16K]
Capabilities: [50] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
Address: 00000000fee0200c  Data: 4182
Kernel driver in use: snd_hda_intel
Kernel modules: snd_hda_intel

00:1c.0 PCI bridge: Intel Corporation Device 22c8 (rev 21) (prog-if 00
[Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
I/O behind bridge: 00001000-00001fff
Memory behind bridge: 81500000-816fffff
Prefetchable memory behind bridge: 0000000081700000-00000000818fffff
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort+ <SERR- <PERR-
BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0
ExtTag- RBE+
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
LnkCap: Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s
<1us, L1 <4us
ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp-
LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk-
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-
SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
Slot #0, PowerLimit 0.000W; Interlock- NoCompl+
SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
Changed: MRL- PresDet- LinkState-
RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
RootCap: CRSVisible-
RootSta: PME ReqID 0000, PMEStatus- PMEPending-
DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Via
WAKE# ARIFwd-
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF
Disabled ARIFwd-
LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
Address: 00000000  Data: 0000
Capabilities: [90] Subsystem: Intel Corporation Device 2060
Capabilities: [a0] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Kernel driver in use: pcieport
Kernel modules: shpchp

00:1c.1 PCI bridge: Intel Corporation Device 22ca (rev 21) (prog-if 00
[Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin B routed to IRQ 17
Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
I/O behind bridge: 0000f000-00000fff
Memory behind bridge: 81300000-813fffff
Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort+ <SERR- <PERR-
BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0
ExtTag- RBE+
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
LnkCap: Port #2, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency
L0s <512ns, L1 <16us
ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp-
LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+
BWMgmt+ ABWMgmt-
SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
Slot #1, PowerLimit 10.000W; Interlock- NoCompl+
SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
Changed: MRL- PresDet- LinkState+
RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
RootCap: CRSVisible-
RootSta: PME ReqID 0000, PMEStatus- PMEPending-
DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Not
Supported ARIFwd-
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF
Disabled ARIFwd-
LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
Address: 00000000  Data: 0000
Capabilities: [90] Subsystem: Intel Corporation Device 2060
Capabilities: [a0] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [100 v0] #00
Capabilities: [200 v1] L1 PM Substates
L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
 PortCommonModeRestoreTime=40us PortTPowerOnTime=10us
Kernel driver in use: pcieport
Kernel modules: shpchp

00:1c.2 PCI bridge: Intel Corporation Device 22cc (rev 21) (prog-if 00
[Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin C routed to IRQ 18
Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
I/O behind bridge: 0000e000-0000efff
Memory behind bridge: 81200000-812fffff
Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort+ <SERR- <PERR-
BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0
ExtTag- RBE+
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
LnkCap: Port #3, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency
L0s <512ns, L1 <16us
ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp-
LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+
BWMgmt+ ABWMgmt-
SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
Slot #2, PowerLimit 10.000W; Interlock- NoCompl+
SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
Changed: MRL- PresDet- LinkState+
RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
RootCap: CRSVisible-
RootSta: PME ReqID 0000, PMEStatus- PMEPending-
DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Not
Supported ARIFwd-
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF
Disabled ARIFwd-
LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
Address: 00000000  Data: 0000
Capabilities: [90] Subsystem: Intel Corporation Device 2060
Capabilities: [a0] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [100 v0] #00
Capabilities: [200 v1] L1 PM Substates
L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
 PortCommonModeRestoreTime=40us PortTPowerOnTime=10us
Kernel driver in use: pcieport
Kernel modules: shpchp

00:1f.0 ISA bridge: Intel Corporation Device 229c (rev 21)
Subsystem: Intel Corporation Device 2060
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Capabilities: [e0] Vendor Specific Information: Len=0c <?>
Kernel driver in use: lpc_ich
Kernel modules: lpc_ich

00:1f.3 SMBus: Intel Corporation Device 2292 (rev 21)
Subsystem: Intel Corporation Device 2060
Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Interrupt: pin B routed to IRQ 5
Region 0: Memory at 81418000 (32-bit, non-prefetchable) [size=32]
Region 4: I/O ports at f040 [size=32]
Capabilities: [50] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Kernel modules: i2c_i801

02:00.0 Network controller: Intel Corporation Wireless 3165 (rev 81)
Subsystem: Intel Corporation Dual Band Wireless AC 3165
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 314
Region 0: Memory at 81300000 (64-bit, non-prefetchable) [size=8K]
Capabilities: [c8] Power Management version 3
Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
Address: 00000000fee0300c  Data: 4192
Capabilities: [40] Express (v2) Endpoint, MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1
unlimited
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
DevCtl2: Completion Timeout: 16ms to 55ms, TimeoutDis-, LTR+, OBFF
Disabled
LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
ComplianceSOS-
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
Capabilities: [140 v1] Device Serial Number 94-65-9c-ff-ff-e4-01-65
Capabilities: [14c v1] Latency Tolerance Reporting
Max snoop latency: 15360ns
Max no snoop latency: 15360ns
Capabilities: [154 v1] L1 PM Substates
L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
 PortCommonModeRestoreTime=30us PortTPowerOnTime=60us
Kernel driver in use: iwlwifi
Kernel modules: iwlwifi

03:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 15)
Subsystem: Intel Corporation RTL8111/8168/8411 PCI Express Gigabit
Ethernet Controller
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 311
Region 0: I/O ports at e000 [size=256]
Region 2: Memory at 81204000 (64-bit, non-prefetchable) [size=4K]
Region 4: Memory at 81200000 (64-bit, non-prefetchable) [size=16K]
Capabilities: [40] Power Management version 3
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
Address: 00000000fee0200c  Data: 4152
Capabilities: [70] Express (v2) Endpoint, MSI 01
DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 4096 bytes
DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency
L0s unlimited, L1 <64us
ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-
DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR+, OBFF Via
message/WAKE#
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF
Disabled
LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [b0] MSI-X: Enable- Count=4 Masked-
Vector table: BAR=4 offset=00000000
PBA: BAR=4 offset=00000800
Capabilities: [d0] Vital Product Data
pcilib: sysfs_read_vpd: read failed: Input/output error
Not readable
Capabilities: [100 v2] Advanced Error Reporting
UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
Capabilities: [140 v1] Virtual Channel
Caps: LPEVC=0 RefClk=100ns PATEntryBits=1
Arb: Fixed- WRR32- WRR64- WRR128-
Ctrl: ArbSelect=Fixed
Status: InProgress-
VC0: Caps: PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
Arb: Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
Ctrl: Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
Status: NegoPending- InProgress-
Capabilities: [160 v1] Device Serial Number 01-00-00-00-68-4c-e0-00
Capabilities: [170 v1] Latency Tolerance Reporting
Max snoop latency: 15360ns
Max no snoop latency: 15360ns
Capabilities: [178 v1] L1 PM Substates
L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
 PortCommonModeRestoreTime=150us PortTPowerOnTime=150us
Kernel driver in use: r8169
Kernel modules: r8169

eddie@codey:/usr/src$ cat /proc/scsi/scsi
cat: /proc/scsi/scsi: No such file or directory

eddie@codey:/usr/src$ ls /proc
1     1428  1528  18    2202  2483  2536  3     4427  5     750
cmdline      fs           kpagecount    partitions     timer_list
10    1429  153   188   2218  2484  2538  30    4506  51    779
consoles     interrupts   kpageflags    sched_debug    timer_stats
1001  1430  1555  19    2271  2493  254   31    4507  52    785
cpuinfo      iomem        loadavg       self           tty
11    1441  1558  193   23    2505  2568  32    4508  5368  8
crypto       ioports      locks         slabinfo       uptime
12    1497  16    2     24    2508  2569  33    4513  5404  806
devices      irq          meminfo       softirqs       version
1261  1499  1637  20    2435  2509  2584  335   4516  58    9
diskstats    kallsyms     misc          stat           vmallocinfo
13    15    164   2038  2436  251   26    34    4952  603   acpi
dma          kcore        modules       swaps          vmstat
136   1522  169   21    2456  2517  27    35    4954  604   asound
driver       keys         mounts        sys            zoneinfo
139   1523  1699  2161  2469  252   271   3848  4955  640   buddyinfo
execdomains  key-users    mtrr          sysrq-trigger
14    1524  170   2199  2473  2525  28    3980  4981  7     bus
fb           kmsg         net           sysvipc
1427  1526  1792  22    2480  253   29    4425  4982  749   cgroups
filesystems  kpagecgroup  pagetypeinfo  thread-self

Let me know if I need to provide anything else.


Cheers,
Eddie
