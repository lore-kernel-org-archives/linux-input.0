From: "Phil M." <pme991@cox.net>
Subject: [Dell Inspiron 5547] Cursor jumps to trash or last icon on launch
 bar
Date: Thu, 09 Oct 2014 20:30:50 -0700
Message-ID: <543752EA.6090804@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fed1rmfepo103.cox.net ([68.230.241.145]:35927 "EHLO
	fed1rmfepo103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099AbaJJDgC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Oct 2014 23:36:02 -0400
Received: from fed1rmimpo305 ([68.230.241.173]) by fed1rmfepo101.cox.net
          (InterMail vM.8.01.05.15 201-2260-151-145-20131218) with ESMTP
          id <20141010033058.NYNP29651.fed1rmfepo101.cox.net@fed1rmimpo305>
          for <linux-input@vger.kernel.org>; Thu, 9 Oct 2014 23:30:58 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

[1] One line summary of problem:

    [Dell Inspiron 5547] Cursor jumps to trash or last icon on launch bar

[2.] Full description of the problem/report:

[3.] Keywords:

[4.] Kernel version (from /proc/version):

cat /proc/version
Linux version 3.17.0-031700-generic (apw@gomeisa) (gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201410060605 SMP Mon Oct 6 10:07:09 UTC 2014

[5.] Output of Oops..:

No Oops ouput, no Caps Lock flashing.

[6.] A small shell script or example program which triggers the problem (if possible)

Issue only appears, when using touchpad (HW).  Not sure how to trigger using a shell script, even though I am fluent in shell scripting. Any help would be appreciated.

[7.] Environment

lsb_release -rd
Description:	Ubuntu 14.04.1 LTS
Release:	14.04

[7.1.] Software

./ver_linux

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
  
Linux tcllp-1 3.17.0-031700-generic #201410060605 SMP Mon Oct 6 10:07:09 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux
  
Gnu C                  4.8
Gnu make               3.81
binutils               2.24
util-linux             2.20.1
mount                  support
module-init-tools      15
e2fsprogs              1.42.9
pcmciautils            018
PPP                    2.4.5
Linux C Library        2.19
Dynamic linker (ldd)   2.19
Procps                 3.3.9
Net-tools              1.60
Kbd                    1.15.5
Sh-utils               8.21
wireless-tools         30
Modules Loaded         ctr ccm bnep rfcomm binfmt_misc nls_iso8859_1 arc4 iwlmvm mac80211 snd_hda_codec_hdmi uvcvideo videobuf2_vmalloc intel_rapl videobuf2_memops videobuf2_core v4l2_common videodev media x86_pkg_temp_thermal intel_powerclamp dell_wmi sparse_keymap rtsx_usb_ms coretemp memstick kvm_intel kvm hid_rmi crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel dell_laptop aes_x86_64 lrw gf128mul glue_helper iwlwifi btusb ablk_helper joydev rtc_efi cryptd serio_raw dcdbas cfg80211 bluetooth snd_soc_rt5640 i915 wmi snd_soc_rl6231 snd_hda_codec_realtek dw_dmac dw_dmac_core snd_hda_codec_generic snd_hda_intel snd_soc_core video snd_hda_controller snd_hda_codec i2c_hid snd_compress drm_kms_helper snd_pcm_dmaengine snd_hwdep snd_pcm snd_seq_midi snd_seq_midi_event snd_rawmidi s
 nd_seq drm mei_me mei snd_seq_device hid snd_timer snd soundcore i2c_algo_bit lpc_ich 8250_dw i2c_designware_platform spi_pxa2xx_platform i2c_designware_core soc_button_array mac_hid parport_pc ppdev
  lp parport rtsx_usb_sdmmc rtsx_usb psmouse ahci r8169 libahci mii sdhci_acpi sdhci


[7.2.] Processor information (from /proc/cpuinfo):
cat /proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 69
model name	: Intel(R) Core(TM) i5-4210U CPU @ 1.70GHz
stepping	: 1
microcode	: 0x17
cpu MHz		: 1735.687
cache size	: 3072 KB
physical id	: 0
siblings	: 4
core id		: 0
cpu cores	: 2
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm ida arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt
bugs		:
bogomips	: 4788.99
clflush size	: 64
cache_alignment	: 64
address sizes	: 39 bits physical, 48 bits virtual
power management:

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 69
model name	: Intel(R) Core(TM) i5-4210U CPU @ 1.70GHz
stepping	: 1
microcode	: 0x17
cpu MHz		: 1732.218
cache size	: 3072 KB
physical id	: 0
siblings	: 4
core id		: 0
cpu cores	: 2
apicid		: 1
initial apicid	: 1
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm ida arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt
bugs		:
bogomips	: 4788.99
clflush size	: 64
cache_alignment	: 64
address sizes	: 39 bits physical, 48 bits virtual
power management:

processor	: 2
vendor_id	: GenuineIntel
cpu family	: 6
model		: 69
model name	: Intel(R) Core(TM) i5-4210U CPU @ 1.70GHz
stepping	: 1
microcode	: 0x17
cpu MHz		: 1728.187
cache size	: 3072 KB
physical id	: 0
siblings	: 4
core id		: 1
cpu cores	: 2
apicid		: 2
initial apicid	: 2
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm ida arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt
bugs		:
bogomips	: 4788.99
clflush size	: 64
cache_alignment	: 64
address sizes	: 39 bits physical, 48 bits virtual
power management:

processor	: 3
vendor_id	: GenuineIntel
cpu family	: 6
model		: 69
model name	: Intel(R) Core(TM) i5-4210U CPU @ 1.70GHz
stepping	: 1
microcode	: 0x17
cpu MHz		: 2041.968
cache size	: 3072 KB
physical id	: 0
siblings	: 4
core id		: 1
cpu cores	: 2
apicid		: 3
initial apicid	: 3
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm ida arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt
bugs		:
bogomips	: 4788.99
clflush size	: 64
cache_alignment	: 64
address sizes	: 39 bits physical, 48 bits virtual
power management:

[7.3.] Module information (from /proc/modules):

cat /proc/modules
ctr 13193 2 - Live 0x0000000000000000
ccm 17856 2 - Live 0x0000000000000000
bnep 19884 2 - Live 0x0000000000000000
rfcomm 75114 8 - Live 0x0000000000000000
binfmt_misc 17508 1 - Live 0x0000000000000000
nls_iso8859_1 12713 1 - Live 0x0000000000000000
arc4 12573 2 - Live 0x0000000000000000
iwlmvm 249097 0 - Live 0x0000000000000000
mac80211 696913 1 iwlmvm, Live 0x0000000000000000
snd_hda_codec_hdmi 52620 1 - Live 0x0000000000000000
uvcvideo 86628 0 - Live 0x0000000000000000
videobuf2_vmalloc 13216 1 uvcvideo, Live 0x0000000000000000
intel_rapl 19196 0 - Live 0x0000000000000000
videobuf2_memops 13362 1 videobuf2_vmalloc, Live 0x0000000000000000
videobuf2_core 59907 1 uvcvideo, Live 0x0000000000000000
v4l2_common 15715 1 videobuf2_core, Live 0x0000000000000000
videodev 163831 3 uvcvideo,videobuf2_core,v4l2_common, Live 0x0000000000000000
media 22008 2 uvcvideo,videodev, Live 0x0000000000000000
x86_pkg_temp_thermal 14312 0 - Live 0x0000000000000000
intel_powerclamp 19099 0 - Live 0x0000000000000000
dell_wmi 12681 0 - Live 0x0000000000000000
sparse_keymap 13890 1 dell_wmi, Live 0x0000000000000000
rtsx_usb_ms 19050 0 - Live 0x0000000000000000
coretemp 13638 0 - Live 0x0000000000000000
memstick 16968 1 rtsx_usb_ms, Live 0x0000000000000000
kvm_intel 149257 0 - Live 0x0000000000000000
kvm 468567 1 kvm_intel, Live 0x0000000000000000
hid_rmi 17944 0 - Live 0x0000000000000000
crct10dif_pclmul 14268 0 - Live 0x0000000000000000
crc32_pclmul 13180 0 - Live 0x0000000000000000
ghash_clmulni_intel 13230 0 - Live 0x0000000000000000
aesni_intel 165469 4 - Live 0x0000000000000000
dell_laptop 14147 0 - Live 0x0000000000000000
aes_x86_64 17131 1 aesni_intel, Live 0x0000000000000000
lrw 13323 1 aesni_intel, Live 0x0000000000000000
gf128mul 14951 1 lrw, Live 0x0000000000000000
glue_helper 14095 1 aesni_intel, Live 0x0000000000000000
iwlwifi 190863 1 iwlmvm, Live 0x0000000000000000
btusb 32408 0 - Live 0x0000000000000000
ablk_helper 13597 1 aesni_intel, Live 0x0000000000000000
joydev 17587 0 - Live 0x0000000000000000
rtc_efi 12760 0 - Live 0x0000000000000000
cryptd 20531 3 ghash_clmulni_intel,aesni_intel,ablk_helper, Live 0x0000000000000000
serio_raw 13483 0 - Live 0x0000000000000000
dcdbas 15017 1 dell_laptop, Live 0x0000000000000000
cfg80211 514757 3 iwlmvm,mac80211,iwlwifi, Live 0x0000000000000000
bluetooth 477455 22 bnep,rfcomm,btusb, Live 0x0000000000000000
snd_soc_rt5640 93123 0 - Live 0x0000000000000000
i915 993210 7 - Live 0x0000000000000000
wmi 19379 1 dell_wmi, Live 0x0000000000000000
snd_soc_rl6231 13037 1 snd_soc_rt5640, Live 0x0000000000000000
snd_hda_codec_realtek 78564 1 - Live 0x0000000000000000
dw_dmac 12835 0 - Live 0x0000000000000000
dw_dmac_core 28566 1 dw_dmac, Live 0x0000000000000000
snd_hda_codec_generic 70087 1 snd_hda_codec_realtek, Live 0x0000000000000000
snd_hda_intel 30783 5 - Live 0x0000000000000000
snd_soc_core 207547 1 snd_soc_rt5640, Live 0x0000000000000000
video 20569 1 i915, Live 0x0000000000000000
snd_hda_controller 32234 1 snd_hda_intel, Live 0x0000000000000000
snd_hda_codec 145035 5 snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_controller, Live 0x0000000000000000
i2c_hid 19065 0 - Live 0x0000000000000000
snd_compress 19435 1 snd_soc_core, Live 0x0000000000000000
drm_kms_helper 99872 1 i915, Live 0x0000000000000000
snd_pcm_dmaengine 15229 1 snd_soc_core, Live 0x0000000000000000
snd_hwdep 17709 1 snd_hda_codec, Live 0x0000000000000000
snd_pcm 105052 7 snd_hda_codec_hdmi,snd_soc_rt5640,snd_hda_intel,snd_soc_core,snd_hda_controller,snd_hda_codec,snd_pcm_dmaengine, Live 0x0000000000000000
snd_seq_midi 13564 0 - Live 0x0000000000000000
snd_seq_midi_event 14899 1 snd_seq_midi, Live 0x0000000000000000
snd_rawmidi 31197 1 snd_seq_midi, Live 0x0000000000000000
snd_seq 63540 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
drm 318542 6 i915,drm_kms_helper, Live 0x0000000000000000
mei_me 19524 0 - Live 0x0000000000000000
mei 88810 1 mei_me, Live 0x0000000000000000
snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x0000000000000000
hid 110572 2 hid_rmi,i2c_hid, Live 0x0000000000000000
snd_timer 30118 2 snd_pcm,snd_seq, Live 0x0000000000000000
snd 84025 23 snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_soc_core,snd_hda_codec,snd_compress,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_seq_device,snd_timer, Live 0x0000000000000000
soundcore 15091 2 snd_hda_codec,snd, Live 0x0000000000000000
i2c_algo_bit 13564 1 i915, Live 0x0000000000000000
lpc_ich 21176 0 - Live 0x0000000000000000
8250_dw 13474 0 - Live 0x0000000000000000
i2c_designware_platform 13025 0 - Live 0x0000000000000000
spi_pxa2xx_platform 23302 0 - Live 0x0000000000000000
i2c_designware_core 14990 1 i2c_designware_platform, Live 0x0000000000000000
soc_button_array 12769 0 - Live 0x0000000000000000
mac_hid 13275 0 - Live 0x0000000000000000
parport_pc 32906 0 - Live 0x0000000000000000
ppdev 17711 0 - Live 0x0000000000000000
lp 17799 0 - Live 0x0000000000000000
parport 42481 3 parport_pc,ppdev,lp, Live 0x0000000000000000
rtsx_usb_sdmmc 28381 0 - Live 0x0000000000000000
rtsx_usb 21330 2 rtsx_usb_ms,rtsx_usb_sdmmc, Live 0x0000000000000000
psmouse 118039 0 - Live 0x0000000000000000
ahci 30167 4 - Live 0x0000000000000000
r8169 77680 0 - Live 0x0000000000000000
libahci 32533 1 ahci, Live 0x0000000000000000
mii 13981 1 r8169, Live 0x0000000000000000
sdhci_acpi 13395 0 - Live 0x0000000000000000
sdhci 44159 1 sdhci_acpi, Live 0x0000000000000000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

  cat /proc/ioports
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
   0680-069f : pnp 00:00
   0800-0bff : INT33C7:00
     0800-0bff : lp-gpio
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
   164e-164f : pnp 00:00
   1800-1803 : ACPI PM1a_EVT_BLK
   1804-1805 : ACPI PM1a_CNT_BLK
   1808-180b : ACPI PM_TMR
   1810-1815 : ACPI CPU throttle
   1830-1833 : iTCO_wdt
   1850-1850 : ACPI PM2_CNT_BLK
   1854-1857 : pnp 00:02
   1860-187f : iTCO_wdt
   1880-189f : ACPI GPE0_BLK
   3000-3fff : PCI Bus 0000:01
     3000-30ff : 0000:01:00.0
       3000-30ff : r8169
   4000-403f : 0000:00:02.0
   4040-405f : 0000:00:1f.3
   4060-407f : 0000:00:1f.2
     4060-407f : ahci
   4080-4087 : 0000:00:1f.2
     4080-4087 : ahci
   4088-408f : 0000:00:1f.2
     4088-408f : ahci
   4090-4093 : 0000:00:1f.2
     4090-4093 : ahci
   4094-4097 : 0000:00:1f.2
     4094-4097 : ahci
   fd60-fd63 : pnp 00:00
   ffff-ffff : pnp 00:00
     ffff-ffff : pnp 00:00
       ffff-ffff : pnp 00:00
cat /proc/iomem
00000000-00000fff : reserved
00001000-0006efff : System RAM
0006f000-0006ffff : reserved
00070000-00087fff : System RAM
00088000-000bffff : reserved
   000a0000-000bffff : PCI Bus 0000:00
000c0000-000cebff : Video ROM
000cf000-000cffff : Adapter ROM
000f0000-000fffff : System ROM
00100000-94d5ffff : System RAM
   02000000-027a9ab7 : Kernel code
   027a9ab8-02d1e57f : Kernel data
   02e80000-02fc6fff : Kernel bss
94d60000-95d5ffff : reserved
95d60000-9a36efff : System RAM
9a36f000-9a56efff : reserved
9a56f000-9aebefff : reserved
9aebf000-9afbefff : ACPI Non-volatile Storage
9afbf000-9affefff : ACPI Tables
9afff000-9affffff : System RAM
9b000000-9f9fffff : reserved
   9ba00000-9f9fffff : Graphics Stolen Memory
9fa00000-feafffff : PCI Bus 0000:00
   9fa10000-9fa1ffff : pnp 00:05
   9fa21000-9fa21fff : pnp 00:05
   a0000000-afffffff : 0000:00:02.0
   b0000000-b03fffff : 0000:00:02.0
   b0400000-b04fffff : PCI Bus 0000:01
     b0400000-b0403fff : 0000:01:00.0
       b0400000-b0403fff : r8169
   b0500000-b05fffff : PCI Bus 0000:02
     b0500000-b0501fff : 0000:02:00.0
       b0500000-b0501fff : iwlwifi
   b0600000-b06fffff : PCI Bus 0000:01
     b0600000-b0600fff : 0000:01:00.0
       b0600000-b0600fff : r8169
   b0700000-b070ffff : 0000:00:14.0
     b0700000-b070ffff : xhci_hcd
   b0710000-b0713fff : 0000:00:03.0
     b0710000-b0713fff : ICH HD audio
   b0714000-b0717fff : 0000:00:1b.0
     b0714000-b0717fff : ICH HD audio
   b0718000-b071801f : 0000:00:16.0
     b0718000-b071801f : mei_me
   b0719000-b07190ff : 0000:00:1f.3
   b071b000-b071b7ff : 0000:00:1f.2
     b071b000-b071b7ff : ahci
   b071c000-b071c3ff : 0000:00:1d.0
     b071c000-b071c3ff : ehci_hcd
   b071d000-b071dfff : pnp 00:06
   b071e000-b071efff : INT33C3:00
     b071e000-b071efff : INT33C3:00
   b071f000-b071ffff : pnp 00:06
   e0000000-efffffff : PCI MMCONFIG 0000 [bus 00-ff]
     e0000000-efffffff : reserved
       e0000000-efffffff : pnp 00:05
   fe101000-fe112fff : reserved
feb00000-feb0ffff : reserved
fec00000-fec00fff : reserved
   fec00000-fec003ff : IOAPIC 0
fed00000-fee00fff : reserved
   fed00000-fed003ff : HPET 0
     fed00000-fed003ff : PNP0103:00
   fed10000-fed17fff : pnp 00:05
   fed18000-fed18fff : pnp 00:05
   fed19000-fed19fff : pnp 00:05
   fed1c000-fed1ffff : pnp 00:05
     fed1f410-fed1f414 : iTCO_wdt
   fed20000-fed3ffff : pnp 00:05
   fed90000-fed93fff : pnp 00:05
   fee00000-fee00fff : Local APIC
ff000000-ff000fff : pnp 00:05
ff010000-ffffffff : INT0800:00
   ffc00000-ffffffff : reserved
100000000-1df5fffff : System RAM
1df600000-1dfffffff : RAM buffer

[7.5.] PCI information ('lspci -vvv' as root)

sudo lspci -vvv
[sudo] password for pme991:
00:00.0 Host bridge: Intel Corporation Haswell-ULT DRAM Controller (rev 0b)
	Subsystem: Dell Device 063e
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information: Len=0c <?>

00:02.0 VGA compatible controller: Intel Corporation Haswell-ULT Integrated Graphics Controller (rev 0b) (prog-if 00 [VGA controller])
	Subsystem: Dell Device 063e
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 47
	Region 0: Memory at b0000000 (64-bit, non-prefetchable) [size=4M]
	Region 2: Memory at a0000000 (64-bit, prefetchable) [size=256M]
	Region 4: I/O ports at 4000 [size=64]
	Expansion ROM at <unassigned> [disabled]
	Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee0f00c  Data: 4172
	Capabilities: [d0] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [a4] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: i915

00:03.0 Audio device: Intel Corporation Haswell-ULT HD Audio Controller (rev 0b)
	Subsystem: Dell Device 063e
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 49
	Region 0: Memory at b0710000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee0f00c  Data: 4192
	Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
	Kernel driver in use: snd_hda_intel

00:14.0 USB controller: Intel Corporation Lynx Point-LP USB xHCI HC (rev 04) (prog-if 30 [XHCI])
	Subsystem: Dell Device 063e
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 42
	Region 0: Memory at b0700000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [70] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
		Address: 00000000fee0f00c  Data: 41c1
	Kernel driver in use: xhci_hcd

00:16.0 Communication controller: Intel Corporation Lynx Point-LP HECI #0 (rev 04)
	Subsystem: Dell Device 063e
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 45
	Region 0: Memory at b0718000 (64-bit, non-prefetchable) [size=32]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee0f00c  Data: 4142
	Kernel driver in use: mei_me

00:1b.0 Audio device: Intel Corporation Lynx Point-LP HD Audio Controller (rev 04)
	Subsystem: Dell Device 063e
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 46
	Region 0: Memory at b0714000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee0f00c  Data: 4162
	Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
		VC1:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable- ID=0 ArbSelect=Fixed TC/VC=00
			Status:	NegoPending- InProgress-
	Kernel driver in use: snd_hda_intel

00:1c.0 PCI bridge: Intel Corporation Lynx Point-LP PCI Express Root Port 3 (rev e4) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: b0600000-b06fffff
	Prefetchable memory behind bridge: 00000000b0400000-00000000b04fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #3, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <512ns, L1 <16us
			ClockPM- Surprise- LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #2, PowerLimit 10.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState+
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Not Supported ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee0f00c  Data: 4171
	Capabilities: [90] Subsystem: Dell Device 063e
	Capabilities: [a0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v0] #00
	Capabilities: [200 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
			  PortCommonModeRestoreTime=40us PortTPowerOnTime=10us
	Kernel driver in use: pcieport

00:1c.3 PCI bridge: Intel Corporation Lynx Point-LP PCI Express Root Port 4 (rev e4) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: b0500000-b05fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #4, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <512ns, L1 <16us
			ClockPM- Surprise- LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #3, PowerLimit 10.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState+
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Not Supported ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee0f00c  Data: 4191
	Capabilities: [90] Subsystem: Dell Device 063e
	Capabilities: [a0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v0] #00
	Capabilities: [200 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
			  PortCommonModeRestoreTime=40us PortTPowerOnTime=10us
	Kernel driver in use: pcieport

00:1d.0 USB controller: Intel Corporation Lynx Point-LP USB EHCI #1 (rev 04) (prog-if 20 [EHCI])
	Subsystem: Dell Device 063e
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 23
	Region 0: Memory at b071c000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Debug port: BAR=1 offset=00a0
	Capabilities: [98] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: ehci-pci

00:1f.0 ISA bridge: Intel Corporation Lynx Point-LP LPC Controller (rev 04)
	Subsystem: Dell Device 063e
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information: Len=0c <?>
	Kernel driver in use: lpc_ich

00:1f.2 SATA controller: Intel Corporation Lynx Point-LP SATA Controller 1 [AHCI mode] (rev 04) (prog-if 01 [AHCI 1.0])
	Subsystem: Dell Device 063e
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 44
	Region 0: I/O ports at 4088 [size=8]
	Region 1: I/O ports at 4094 [size=4]
	Region 2: I/O ports at 4080 [size=8]
	Region 3: I/O ports at 4090 [size=4]
	Region 4: I/O ports at 4060 [size=32]
	Region 5: Memory at b071b000 (32-bit, non-prefetchable) [size=2K]
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee0c00c  Data: 41e1
	Capabilities: [70] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
	Kernel driver in use: ahci

00:1f.3 SMBus: Intel Corporation Lynx Point-LP SMBus Controller (rev 04)
	Subsystem: Dell Device 063e
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin C routed to IRQ 11
	Region 0: Memory at b0719000 (64-bit, non-prefetchable) [size=256]
	Region 4: I/O ports at 4040 [size=32]

01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8101E/RTL8102E PCI Express Fast Ethernet controller (rev 07)
	Subsystem: Dell Device 063e
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 43
	Region 0: I/O ports at 3000 [size=256]
	Region 2: Memory at b0600000 (64-bit, non-prefetchable) [size=4K]
	Region 4: Memory at b0400000 (64-bit, prefetchable) [size=16K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee0f00c  Data: 41d1
	Capabilities: [70] Express (v2) Endpoint, MSI 01
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s unlimited, L1 <64us
			ClockPM+ Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR+, OBFF Via message/WAKE#
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Disabled
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [b0] MSI-X: Enable- Count=4 Masked-
		Vector table: BAR=4 offset=00000000
		PBA: BAR=4 offset=00000800
	Capabilities: [d0] Vital Product Data
		No end tag found
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr+ BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [140 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
	Capabilities: [160 v1] Device Serial Number 01-00-00-00-36-4c-e0-00
	Capabilities: [170 v1] Latency Tolerance Reporting
		Max snoop latency: 0ns
		Max no snoop latency: 0ns
	Kernel driver in use: r8169

02:00.0 Network controller: Intel Corporation Wireless 3160 (rev 83)
	Subsystem: Intel Corporation Dual Band Wireless AC 3160
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 48
	Region 0: Memory at b0500000 (64-bit, non-prefetchable) [size=8K]
	Capabilities: [c8] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee0400c  Data: 4182
	Capabilities: [40] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 unlimited
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+ FLReset-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <4us, L1 <32us
			ClockPM+ Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range B, TimeoutDis+, LTR+, OBFF Via WAKE#
		DevCtl2: Completion Timeout: 16ms to 55ms, TimeoutDis-, LTR+, OBFF Disabled
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP+ BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [140 v1] Device Serial Number a0-88-69-ff-ff-4d-2c-c7
	Capabilities: [14c v1] Latency Tolerance Reporting
		Max snoop latency: 0ns
		Max no snoop latency: 0ns
	Capabilities: [154 v1] Vendor Specific Information: ID=cafe Rev=1 Len=014 <?>
	Kernel driver in use: iwlwifi

[7.6.] SCSI information (from /proc/scsi/scsi)

cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: WDC WD10JPVX-75J Rev: 1A01
   Type:   Direct-Access                    ANSI  SCSI revision: 05

[7.7.] Other information that might be relevant to the problem

sudo ls /proc
1     156   2163  2421	2750  38    460   685	asound	     misc
10    157   2166  2428	2755  385   466   7	buddyinfo    modules
100   1584  2172  2429	2756  39    468   704	bus	     mounts
1013  16    2177  2430	2759  396   4692  721	cgroups      mtrr
1056  1621  2193  2435	2779  4     47	  726	cmdline      net
1085  1659  2195  2441	2786  400   4753  739	consoles     pagetypeinfo
11    17    2197  2448	28    4069  48	  74	cpuinfo      partitions
1101  171   22	  2457	29    409   49	  744	crypto	     sched_debug
1106  172   2201  2461	2946  41    4904  749	devices      schedstat
1107  18    2204  2465	3     410   491   75	diskstats    scsi
1139  187   2206  2476	3019  412   4919  762	dma	     self
1151  19    2224  2488	3029  414   4929  765	driver	     slabinfo
1152  1999  2238  25	3047  415   4946  77	execdomains  softirqs
1199  2     2241  2519	3063  42    4949  770	fb	     stat
12    20    2242  2525	31    4200  4956  771	filesystems  swaps
1240  2028  2244  2549	317   423   4957  78	fs	     sys
13    2035  2247  2554	32    424   5	  79	interrupts   sysrq-trigger
1302  2037  2248  2559	323   4246  50	  8	iomem	     sysvipc
1347  2051  2254  2562	33    425   51	  80	ioports      thread-self
1373  2054  2260  2567	3345  43    52	  819	irq	     timer_list
1376  21    2272  2572	3369  4322  53	  866	kallsyms     timer_stats
14    2109  2276  2578	34    433   535   870	kcore	     tty
1468  2114  23	  2594	3451  436   54	  876	keys	     uptime
15    2122  2315  2597	3473  44    55	  877	key-users    version
151   2126  2328  26	3491  4459  56	  881	kmsg	     vmallocinfo
1515  2127  2330  2691	3518  4476  58	  9	kpagecount   vmstat
152   2149  2334  27	3536  45    60	  938	kpageflags   zoneinfo
153   2153  2344  2738	3552  4516  61	  974	loadavg
154   2156  2383  2746	3568  4525  62	  975	locks
155   2157  24	  2747	36    4526  648   99	mdstat
1559  2159  2414  2749	37    46    649   acpi	meminfo

[X.] Other notes, patches, fixes, workarounds:

Link to launchpad bug report.

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1375514  




