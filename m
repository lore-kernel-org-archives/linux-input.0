From: Martyn_Berry <martyn_berry@blueyonder.co.uk>
Subject: Re: Dell E7440 touchpad jumps position
Date: Mon, 7 Dec 2015 17:24:25 +0000
Message-ID: <5665C0C9.1090602@blueyonder.co.uk>
References: <56463A63.2030506@blueyonder.co.uk>
 <564EFE2F.9010307@blueyonder.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from know-smtprelay-omc-7.server.virginmedia.net ([80.0.253.71]:50942
	"EHLO know-smtprelay-omc-7.server.virginmedia.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932136AbbLGRYa (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 7 Dec 2015 12:24:30 -0500
In-Reply-To: <564EFE2F.9010307@blueyonder.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Following Launchpad bug 1513914 status being changed to Triaged; as 
requested I have prepared the Kernel.org format information which is 
listed below.
Martyn Berry (new to Linux, hope this information is being sent to the 
correct persons)


[1.]
Dell E7440 touchpad jumps position.

[2.]
Dell E7440 touchpad works correctly when freshly started each time; but 
after some time running, the mouse pointer starts to randomly jump 
position when I try to use the touchpad.  (the problem seems to only 
happen in a vertical direction, I have not seen the same effect in 
horizontal movement via touchpad control)

When problem is happening, and I try to move the pointer to a new 
position, the pointer initially moves towards the target position OK , 
but as I slow down the movement in final approach to the target 
position, the pointer jumps quite a distance away from the target position.


If I shut down Linux and re-start after about 10-20 seconds, the problem 
is temporarily resolved.
Both the USB Mouse and keyboard blue joy-button continue to work 
correctly while having "jumpy" touchpad problem.
When I boot to Windows 7 Pro 64 bit on same PC, the touchpad always 
works correctly.

[3.]

[4.]

$ cat /proc/version
Linux version 4.4.0-040400rc3-generic (kernel@gloin) (gcc version 5.2.1 
20151010 (Ubuntu 5.2.1-22ubuntu2) ) #201511300321 SMP Mon Nov 30 
03:23:36 UTC 2015

[5.]
[6.]

[7.]

$ lsb_release -rd
Description:	Ubuntu 15.10
Release:	15.10

[7.1]
martyn@martyn-Latitude-E7440:/usr/src/linux-headers-4.4.0-040400rc3-generic/scripts$ 
sh ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
  Linux martyn-Latitude-E7440 4.4.0-040400rc3-generic #201511300321 SMP 
Mon Nov 30 03:23:36 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux
  GNU C			5.2.1
GNU Make		4.0
Binutils		2.25.1
Util-linux		2.26.2
Mount			2.26.2
Module-init-tools	21
E2fsprogs		1.42.12
Pcmciautils		018
PPP			2.4.6
Linux C Library		2.21
Dynamic linker (ldd)	2.21
Linux C++ Library	6.0.21
Procps			3.3.9
Net-tools		1.60
Kbd			1.15.5
Console-tools		1.15.5
Sh-utils		8.23
Udev			225
Wireless-tools		30
Modules Loaded		8250_dw 8250_fintek ablk_helper ac97_bus aesni_intel 
aes_x86_64 ahci ansi_cprng arc4 autofs4 binfmt_misc bluetooth bnep btbcm 
btintel btrtl btusb ccm cfg80211 coretemp crc32_pclmul crct10dif_pclmul 
cryptd ctr dcdbas dell_laptop dell_rbtn dell_smm_hwmon dell_smo8800 
dell_wmi drbg drm drm_kms_helper dw_dmac dw_dmac_core e1000e elan_i2c 
fb_sys_fops fjes gf128mul glue_helper hci hid i2c_algo_bit 
i2c_designware_core i2c_designware_platform i2c_hid i915 input_leds 
intel_powerclamp intel_rapl iosf_mbi irqbypass iwlmvm iwlwifi joydev kvm 
kvm_intel libahci lp lpc_ich lrw mac80211 mac_hid media mei mei_me 
mei_phy nfc parport parport_pc pn544 pn544_mei ppdev pps_core psmouse 
ptp sdhci sdhci_acpi sdhci_pci serio_raw shpchp snd snd_compress 
snd_hda_codec snd_hda_codec_generic snd_hda_codec_hdmi 
snd_hda_codec_realtek snd_hda_core snd_hda_intel snd_hwdep snd_pcm 
snd_pcm_dmaengine snd_rawmidi snd_seq snd_seq_device snd_seq_midi 
snd_seq_midi_event snd_soc_core snd_soc_rl6231 snd_soc_
rt5640 snd_soc_sst_acpi snd_timer soundcore sparse_keymap 
spi_pxa2xx_platform syscopyarea sysfillrect sysimgblt uvcvideo 
v4l2_common video videobuf2_core videobuf2_memops videobuf2_v4l2 
videobuf2_vmalloc videodev wmi x86_pkg_temp_thermal


[7.2]

martyn@martyn-Latitude-E7440:~$ cat /proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 69
model name	: Intel(R) Core(TM) i5-4300U CPU @ 1.90GHz
stepping	: 1
microcode	: 0x1c
cpu MHz		: 2500.000
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
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 
x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm 
abm ida arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid 
fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt
bugs		:
bogomips	: 4988.38
clflush size	: 64
cache_alignment	: 64
address sizes	: 39 bits physical, 48 bits virtual
power management:

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 69
model name	: Intel(R) Core(TM) i5-4300U CPU @ 1.90GHz
stepping	: 1
microcode	: 0x1c
cpu MHz		: 1400.097
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
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 
x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm 
abm ida arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid 
fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt
bugs		:
bogomips	: 4988.38
clflush size	: 64
cache_alignment	: 64
address sizes	: 39 bits physical, 48 bits virtual
power management:

processor	: 2
vendor_id	: GenuineIntel
cpu family	: 6
model		: 69
model name	: Intel(R) Core(TM) i5-4300U CPU @ 1.90GHz
stepping	: 1
microcode	: 0x1c
cpu MHz		: 2450.488
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
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 
x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm 
abm ida arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid 
fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt
bugs		:
bogomips	: 4988.38
clflush size	: 64
cache_alignment	: 64
address sizes	: 39 bits physical, 48 bits virtual
power management:

processor	: 3
vendor_id	: GenuineIntel
cpu family	: 6
model		: 69
model name	: Intel(R) Core(TM) i5-4300U CPU @ 1.90GHz
stepping	: 1
microcode	: 0x1c
cpu MHz		: 2400.097
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
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 
x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm 
abm ida arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid 
fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt
bugs		:
bogomips	: 4988.38
clflush size	: 64
cache_alignment	: 64
address sizes	: 39 bits physical, 48 bits virtual
power management:

[7.3]

martyn@martyn-Latitude-E7440:~$ cat /proc/modules
drbg 32768 1 - Live 0x0000000000000000
ansi_cprng 16384 0 - Live 0x0000000000000000
ctr 16384 3 - Live 0x0000000000000000
ccm 20480 3 - Live 0x0000000000000000
binfmt_misc 20480 1 - Live 0x0000000000000000
bnep 20480 2 - Live 0x0000000000000000
arc4 16384 2 - Live 0x0000000000000000
pn544_mei 16384 0 - Live 0x0000000000000000
mei_phy 16384 1 pn544_mei, Live 0x0000000000000000
pn544 20480 1 pn544_mei, Live 0x0000000000000000
hci 45056 2 mei_phy,pn544, Live 0x0000000000000000
nfc 102400 2 pn544,hci, Live 0x0000000000000000
intel_rapl 20480 0 - Live 0x0000000000000000
iosf_mbi 16384 1 intel_rapl, Live 0x0000000000000000
x86_pkg_temp_thermal 16384 0 - Live 0x0000000000000000
dell_wmi 16384 0 - Live 0x0000000000000000
intel_powerclamp 16384 0 - Live 0x0000000000000000
sparse_keymap 16384 1 dell_wmi, Live 0x0000000000000000
coretemp 16384 0 - Live 0x0000000000000000
kvm_intel 167936 0 - Live 0x0000000000000000
kvm 532480 1 kvm_intel, Live 0x0000000000000000
dell_laptop 20480 0 - Live 0x0000000000000000
irqbypass 16384 1 kvm, Live 0x0000000000000000
dcdbas 16384 1 dell_laptop, Live 0x0000000000000000
dell_smm_hwmon 16384 0 - Live 0x0000000000000000
crct10dif_pclmul 16384 0 - Live 0x0000000000000000
crc32_pclmul 16384 0 - Live 0x0000000000000000
aesni_intel 167936 6 - Live 0x0000000000000000
aes_x86_64 20480 1 aesni_intel, Live 0x0000000000000000
iwlmvm 311296 0 - Live 0x0000000000000000
lrw 16384 1 aesni_intel, Live 0x0000000000000000
gf128mul 16384 1 lrw, Live 0x0000000000000000
glue_helper 16384 1 aesni_intel, Live 0x0000000000000000
ablk_helper 16384 1 aesni_intel, Live 0x0000000000000000
cryptd 20480 2 aesni_intel,ablk_helper, Live 0x0000000000000000
mac80211 724992 1 iwlmvm, Live 0x0000000000000000
uvcvideo 90112 0 - Live 0x0000000000000000
videobuf2_vmalloc 16384 1 uvcvideo, Live 0x0000000000000000
snd_hda_codec_realtek 81920 1 - Live 0x0000000000000000
snd_hda_codec_generic 77824 1 snd_hda_codec_realtek, Live 0x0000000000000000
btusb 45056 0 - Live 0x0000000000000000
videobuf2_memops 16384 1 videobuf2_vmalloc, Live 0x0000000000000000
snd_soc_rt5640 114688 0 - Live 0x0000000000000000
btrtl 16384 1 btusb, Live 0x0000000000000000
videobuf2_v4l2 28672 1 uvcvideo, Live 0x0000000000000000
iwlwifi 196608 1 iwlmvm, Live 0x0000000000000000
snd_hda_codec_hdmi 53248 1 - Live 0x0000000000000000
btbcm 16384 1 btusb, Live 0x0000000000000000
videobuf2_core 36864 2 uvcvideo,videobuf2_v4l2, Live 0x0000000000000000
snd_soc_rl6231 16384 1 snd_soc_rt5640, Live 0x0000000000000000
v4l2_common 16384 1 videobuf2_v4l2, Live 0x0000000000000000
btintel 16384 1 btusb, Live 0x0000000000000000
snd_soc_core 212992 1 snd_soc_rt5640, Live 0x0000000000000000
cfg80211 557056 3 iwlmvm,mac80211,iwlwifi, Live 0x0000000000000000
snd_hda_intel 36864 5 - Live 0x0000000000000000
joydev 20480 0 - Live 0x0000000000000000
videodev 176128 4 uvcvideo,videobuf2_v4l2,videobuf2_core,v4l2_common, 
Live 0x0000000000000000
snd_compress 20480 1 snd_soc_core, Live 0x0000000000000000
bluetooth 520192 9 bnep,btusb,btrtl,btbcm,btintel, Live 0x0000000000000000
ac97_bus 16384 1 snd_soc_core, Live 0x0000000000000000
input_leds 16384 0 - Live 0x0000000000000000
snd_hda_codec 135168 4 
snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_codec_hdmi,snd_hda_intel, 
Live 0x0000000000000000
snd_pcm_dmaengine 16384 1 snd_soc_core, Live 0x0000000000000000
media 24576 2 uvcvideo,videodev, Live 0x0000000000000000
lpc_ich 24576 0 - Live 0x0000000000000000
snd_hda_core 65536 5 
snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec, 
Live 0x0000000000000000
serio_raw 16384 0 - Live 0x0000000000000000
snd_seq_midi 16384 0 - Live 0x0000000000000000
snd_seq_midi_event 16384 1 snd_seq_midi, Live 0x0000000000000000
mei_me 32768 0 - Live 0x0000000000000000
snd_rawmidi 32768 1 snd_seq_midi, Live 0x0000000000000000
snd_hwdep 16384 1 snd_hda_codec, Live 0x0000000000000000
mei 98304 4 pn544_mei,mei_phy,mei_me, Live 0x0000000000000000
shpchp 36864 0 - Live 0x0000000000000000
snd_pcm 102400 7 
snd_soc_rt5640,snd_hda_codec_hdmi,snd_soc_core,snd_hda_intel,snd_hda_codec,snd_pcm_dmaengine,snd_hda_core, 
Live 0x0000000000000000
snd_seq 69632 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
snd_seq_device 16384 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 
0x0000000000000000
snd_timer 32768 2 snd_pcm,snd_seq, Live 0x0000000000000000
8250_fintek 16384 0 - Live 0x0000000000000000
snd 81920 23 
snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_codec_hdmi,snd_soc_core,snd_hda_intel,snd_compress,snd_hda_codec,snd_rawmidi,snd_hwdep,snd_pcm,snd_seq,snd_seq_device,snd_timer, 
Live 0x0000000000000000
dell_smo8800 16384 0 - Live 0x0000000000000000
dw_dmac 16384 0 - Live 0x0000000000000000
elan_i2c 36864 0 - Live 0x0000000000000000
dw_dmac_core 24576 1 dw_dmac, Live 0x0000000000000000
dell_rbtn 16384 1 - Live 0x0000000000000000
snd_soc_sst_acpi 16384 0 - Live 0x0000000000000000
soundcore 16384 1 snd, Live 0x0000000000000000
mac_hid 16384 0 - Live 0x0000000000000000
i2c_designware_platform 16384 0 - Live 0x0000000000000000
8250_dw 16384 0 - Live 0x0000000000000000
spi_pxa2xx_platform 24576 0 - Live 0x0000000000000000
i2c_designware_core 20480 1 i2c_designware_platform, Live 0x0000000000000000
parport_pc 32768 0 - Live 0x0000000000000000
ppdev 20480 0 - Live 0x0000000000000000
lp 20480 0 - Live 0x0000000000000000
parport 49152 3 parport_pc,ppdev,lp, Live 0x0000000000000000
autofs4 40960 2 - Live 0x0000000000000000
i915 1204224 6 - Live 0x0000000000000000
psmouse 126976 0 - Live 0x0000000000000000
i2c_algo_bit 16384 1 i915, Live 0x0000000000000000
drm_kms_helper 135168 1 i915, Live 0x0000000000000000
syscopyarea 16384 1 drm_kms_helper, Live 0x0000000000000000
e1000e 237568 0 - Live 0x0000000000000000
ahci 36864 2 - Live 0x0000000000000000
sysfillrect 16384 1 drm_kms_helper, Live 0x0000000000000000
sysimgblt 16384 1 drm_kms_helper, Live 0x0000000000000000
libahci 32768 1 ahci, Live 0x0000000000000000
fb_sys_fops 16384 1 drm_kms_helper, Live 0x0000000000000000
ptp 20480 1 e1000e, Live 0x0000000000000000
drm 360448 7 i915,drm_kms_helper, Live 0x0000000000000000
sdhci_pci 28672 0 - Live 0x0000000000000000
pps_core 20480 1 ptp, Live 0x0000000000000000
wmi 20480 1 dell_wmi, Live 0x0000000000000000
video 40960 3 dell_wmi,dell_laptop,i915, Live 0x0000000000000000
sdhci_acpi 16384 0 - Live 0x0000000000000000
sdhci 45056 2 sdhci_pci,sdhci_acpi, Live 0x0000000000000000
i2c_hid 20480 0 - Live 0x0000000000000000
hid 118784 1 i2c_hid, Live 0x0000000000000000
fjes 28672 0 - Live 0x0000000000000000


[7.4]

martyn@martyn-Latitude-E7440:~$ cat /proc/ioports
0000-0cf7 : PCI Bus 0000:00
   0000-001f : dma1
   0020-0021 : pic1
   0040-0043 : timer0
   0050-0053 : timer1
   0060-0060 : keyboard
   0064-0064 : keyboard
   0070-0077 : rtc0
   0080-008f : dma page reg
   00a0-00a1 : pic2
   00c0-00df : dma2
   00f0-00ff : fpu
   03c0-03df : vesafb
   04d0-04d1 : pnp 00:04
   0680-069f : pnp 00:01
   0930-0930 : PNP0C09:00
     0930-0930 : EC data
   0934-0934 : PNP0C09:00
     0934-0934 : EC cmd
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
   164e-164f : pnp 00:01
   1800-1803 : ACPI PM1a_EVT_BLK
   1804-1805 : ACPI PM1a_CNT_BLK
   1808-180b : ACPI PM_TMR
   1810-1815 : ACPI CPU throttle
   1830-1833 : iTCO_wdt.0.auto
   1850-1850 : ACPI PM2_CNT_BLK
   1854-1857 : pnp 00:03
   1860-187f : iTCO_wdt.0.auto
   1880-189f : ACPI GPE0_BLK
   1c00-1cfe : pnp 00:01
   1d00-1dfe : pnp 00:01
   1e00-1efe : pnp 00:01
   1f00-1ffe : pnp 00:01
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
   ffff-ffff : pnp 00:01
     ffff-ffff : pnp 00:01
       ffff-ffff : pnp 00:01

martyn@martyn-Latitude-E7440:~$ cat /proc/iomem
00000000-00000fff : reserved
00001000-000913ff : System RAM
00091400-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000cebff : Video ROM
000cf000-000d8dff : Adapter ROM
000d9000-000d9fff : Adapter ROM
000dc000-000dffff : PCI Bus 0000:00
000e0000-000fffff : reserved
   000e0000-000e3fff : PCI Bus 0000:00
   000e4000-000e7fff : PCI Bus 0000:00
   000f0000-000fffff : System ROM
00100000-d0133fff : System RAM
   01000000-018006bf : Kernel code
   018006c0-01f3b9ff : Kernel data
   020b2000-021f4fff : Kernel bss
d0134000-d013afff : ACPI Non-volatile Storage
d013b000-d0b23fff : System RAM
d0b24000-d1008fff : reserved
d1009000-d7db2fff : System RAM
d7db3000-d7ffffff : reserved
d8000000-d8757fff : System RAM
d8758000-d87fffff : reserved
d8800000-d8fa9fff : System RAM
d8faa000-d8ffffff : ACPI Tables
d9000000-da71bfff : System RAM
da71c000-da7fffff : ACPI Non-volatile Storage
da800000-dbceafff : System RAM
dbceb000-dbffffff : reserved
dd000000-df1fffff : reserved
   dd200000-df1fffff : Graphics Stolen Memory
df200000-feafffff : PCI Bus 0000:00
   e0000000-efffffff : 0000:00:02.0
   f7800000-f7bfffff : 0000:00:02.0
   f7c00000-f7cfffff : PCI Bus 0000:03
     f7c00000-f7c007ff : 0000:03:00.0
     f7c01000-f7c01fff : 0000:03:00.0
       f7c01000-f7c01fff : mmc0
   f7d00000-f7dfffff : PCI Bus 0000:02
     f7d00000-f7d01fff : 0000:02:00.0
       f7d00000-f7d01fff : iwlwifi
   f7e00000-f7e1ffff : 0000:00:19.0
     f7e00000-f7e1ffff : e1000e
   f7e20000-f7e2ffff : 0000:00:14.0
     f7e20000-f7e2ffff : xhci-hcd
   f7e30000-f7e33fff : 0000:00:1b.0
     f7e30000-f7e33fff : ICH HD audio
   f7e34000-f7e37fff : 0000:00:03.0
     f7e34000-f7e37fff : ICH HD audio
   f7e39000-f7e390ff : 0000:00:1f.3
   f7e3a000-f7e3a7ff : 0000:00:1f.2
     f7e3a000-f7e3a7ff : ahci
   f7e3b000-f7e3b3ff : 0000:00:1d.0
     f7e3b000-f7e3b3ff : ehci_hcd
   f7e3c000-f7e3cfff : 0000:00:19.0
     f7e3c000-f7e3cfff : e1000e
   f7e3f000-f7e3f01f : 0000:00:16.0
     f7e3f000-f7e3f01f : mei_me
   f7fdf000-f7fdffff : pnp 00:09
   f7fe0000-f7feffff : pnp 00:09
   f8000000-fbffffff : PCI MMCONFIG 0000 [bus 00-3f]
     f8000000-fbffffff : reserved
       f8000000-fbffffff : pnp 00:09
fec00000-fec00fff : reserved
   fec00000-fec003ff : IOAPIC 0
fed00000-fed03fff : reserved
   fed00000-fed003ff : HPET 0
     fed00000-fed003ff : PNP0103:00
fed10000-fed17fff : pnp 00:09
fed18000-fed18fff : pnp 00:09
fed19000-fed19fff : pnp 00:09
fed1c000-fed1ffff : reserved
   fed1c000-fed1ffff : pnp 00:09
     fed1f410-fed1f414 : iTCO_wdt.0.auto
fed20000-fed3ffff : pnp 00:09
fed40000-fed44fff : pnp 00:00
fed45000-fed8ffff : pnp 00:09
fed90000-fed90fff : dmar0
fed91000-fed91fff : dmar1
fee00000-fee00fff : Local APIC
   fee00000-fee00fff : reserved
ff000000-ffffffff : reserved
   ff000000-ffffffff : INT0800:00
     ff000000-ffffffff : pnp 00:09
100000000-21edfffff : System RAM
21ee00000-21fffffff : RAM buffer


[7.5]

martyn@martyn-Latitude-E7440:~$ sudo lspci -vvv
[sudo] password for martyn: 00:00.0 Host bridge: Intel Corporation 
Haswell-ULT DRAM Controller (rev 0b)
	Subsystem: Dell Device 05cb
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort+ >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information: Len=0c <?>
	Kernel driver in use: hsw_uncore

00:02.0 VGA compatible controller: Intel Corporation Haswell-ULT 
Integrated Graphics Controller (rev 0b) (prog-if 00 [VGA controller])
	DeviceName:  Onboard IGD
	Subsystem: Dell Device 05cb
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 45
	Region 0: Memory at f7800000 (64-bit, non-prefetchable) [size=4M]
	Region 2: Memory at e0000000 (64-bit, prefetchable) [size=256M]
	Region 4: I/O ports at f000 [size=64]
	Expansion ROM at <unassigned> [disabled]
	Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee00018  Data: 0000
	Capabilities: [d0] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [a4] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: i915

00:03.0 Audio device: Intel Corporation Haswell-ULT HD Audio Controller 
(rev 0b)
	Subsystem: Dell Device 05cb
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 48
	Region 0: Memory at f7e34000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee002f8  Data: 0000
	Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
	Kernel driver in use: snd_hda_intel

00:14.0 USB controller: Intel Corporation 8 Series USB xHCI HC (rev 04) 
(prog-if 30 [XHCI])
	Subsystem: Dell Device 05cb
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 42
	Region 0: Memory at f7e20000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [70] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
		Address: 00000000fee00278  Data: 0000
	Kernel driver in use: xhci_hcd

00:16.0 Communication controller: Intel Corporation 8 Series HECI #0 
(rev 04)
	Subsystem: Dell Device 05cb
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 46
	Region 0: Memory at f7e3f000 (64-bit, non-prefetchable) [size=32]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee002d8  Data: 0000
	Kernel driver in use: mei_me

00:19.0 Ethernet controller: Intel Corporation Ethernet Connection 
I218-LM (rev 04)
	DeviceName:  Onboard LAN
	Subsystem: Dell Device 05cb
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 43
	Region 0: Memory at f7e00000 (32-bit, non-prefetchable) [size=128K]
	Region 1: Memory at f7e3c000 (32-bit, non-prefetchable) [size=4K]
	Region 2: I/O ports at f080 [size=32]
	Capabilities: [c8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee002b8  Data: 0000
	Capabilities: [e0] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: e1000e

00:1b.0 Audio device: Intel Corporation 8 Series HD Audio Controller 
(rev 04)
	Subsystem: Dell Device 05cb
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 47
	Region 0: Memory at f7e30000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee00318  Data: 0000
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
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
			Status:	NegoPending- InProgress-
		VC1:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable- ID=2 ArbSelect=Fixed TC/VC=04
			Status:	NegoPending- InProgress-
	Kernel driver in use: snd_hda_intel

00:1c.0 PCI bridge: Intel Corporation 8 Series PCI Express Root Port 1 
(rev e4) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 16
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot-), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s 
<1us, L1 <4us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp-
		LnkCtl:	ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- 
BWMgmt- ABWMgmt-
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
	Capabilities: [90] Subsystem: Dell Device 05cb
	Capabilities: [a0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: pcieport

00:1c.3 PCI bridge: Intel Corporation 8 Series PCI Express Root Port 4 
(rev e4) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin D routed to IRQ 19
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: f7d00000-f7dfffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #4, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s 
<512ns, L1 <16us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp-
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ 
BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #3, PowerLimit 10.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Not 
Supported ARIFwd-
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
	Capabilities: [90] Subsystem: Dell Device 05cb
	Capabilities: [a0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v0] #00
	Capabilities: [200 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
			  PortCommonModeRestoreTime=40us PortTPowerOnTime=10us
	Kernel driver in use: pcieport

00:1c.4 PCI bridge: Intel Corporation 8 Series PCI Express Root Port 5 
(rev e4) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 16
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: f7c00000-f7cfffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #5, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s 
<1us, L1 <16us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp-
		LnkCtl:	ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ 
BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #4, PowerLimit 10.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Not 
Supported ARIFwd-
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
	Capabilities: [90] Subsystem: Dell Device 05cb
	Capabilities: [a0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v0] #00
	Capabilities: [200 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
			  PortCommonModeRestoreTime=40us PortTPowerOnTime=10us
	Kernel driver in use: pcieport

00:1d.0 USB controller: Intel Corporation 8 Series USB EHCI #1 (rev 04) 
(prog-if 20 [EHCI])
	Subsystem: Dell Device 05cb
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 21
	Region 0: Memory at f7e3b000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Debug port: BAR=1 offset=00a0
	Capabilities: [98] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: ehci-pci

00:1f.0 ISA bridge: Intel Corporation 8 Series LPC Controller (rev 04)
	Subsystem: Dell Device 05cb
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information: Len=0c <?>
	Kernel driver in use: lpc_ich

00:1f.2 RAID bus controller: Intel Corporation 82801 Mobile SATA 
Controller [RAID mode] (rev 04)
	Subsystem: Dell Device 05cb
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 44
	Region 0: I/O ports at f0d0 [size=8]
	Region 1: I/O ports at f0c0 [size=4]
	Region 2: I/O ports at f0b0 [size=8]
	Region 3: I/O ports at f0a0 [size=4]
	Region 4: I/O ports at f060 [size=32]
	Region 5: Memory at f7e3a000 (32-bit, non-prefetchable) [size=2K]
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee00298  Data: 0000
	Capabilities: [70] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
	Kernel driver in use: ahci

00:1f.3 SMBus: Intel Corporation 8 Series SMBus Controller (rev 04)
	Subsystem: Dell Device 05cb
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin C routed to IRQ 10
	Region 0: Memory at f7e39000 (64-bit, non-prefetchable) [size=256]
	Region 4: I/O ports at f040 [size=32]

02:00.0 Network controller: Intel Corporation Wireless 7260 (rev 73)
	Subsystem: Intel Corporation Dual Band Wireless-AC 7260
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 49
	Region 0: Memory at f7d00000 (64-bit, non-prefetchable) [size=8K]
	Capabilities: [c8] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee00338  Data: 0000
	Capabilities: [40] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 
unlimited
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr+ NoSnoop+ FLReset-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency 
L0s <4us, L1 <32us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- 
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
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- 
MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- 
MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ 
MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [140 v1] Device Serial Number 0c-8b-fd-ff-ff-ee-5b-15
	Capabilities: [14c v1] Latency Tolerance Reporting
		Max snoop latency: 3145728ns
		Max no snoop latency: 3145728ns
	Capabilities: [154 v1] Vendor Specific Information: ID=cafe Rev=1 
Len=014 <?>
	Kernel driver in use: iwlwifi

03:00.0 SD Host controller: O2 Micro, Inc. SD/MMC Card Reader Controller 
(rev 01) (prog-if 01)
	Subsystem: Dell Device 05cb
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 19
	Region 0: Memory at f7c01000 (32-bit, non-prefetchable) [size=4K]
	Region 1: Memory at f7c00000 (32-bit, non-prefetchable) [size=2K]
	Capabilities: [6c] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] MSI: Enable- Count=1/1 Maskable+ 64bit+
		Address: 0000000000000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [80] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr+ NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency 
L0s <512ns, L1 unlimited
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
		LnkCtl:	ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk-
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk- DLActive- 
BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR+, OBFF 
Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF 
Disabled
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- 
ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, 
EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
			Status:	NegoPending- InProgress-
	Capabilities: [200 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- 
MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- 
MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ 
MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [230 v1] Latency Tolerance Reporting
		Max snoop latency: 3145728ns
		Max no snoop latency: 3145728ns
	Capabilities: [240 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
			  PortCommonModeRestoreTime=120us PortTPowerOnTime=10us
	Kernel driver in use: sdhci-pci

[7.6]

martyn@martyn-Latitude-E7440:~$ cat /proc/scsi/scsi
Attached devices:
Host: scsi3 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Samsung SSD 850  Rev: 1B6Q
   Type:   Direct-Access                    ANSI  SCSI revision: 05


[7.7]

martyn@martyn-Latitude-E7440:~$ ls /proc
1     1191  1386  1782  2554  37   698  82         cmdline      meminfo
10    1192  1388  18    2559  38   7    83         consoles     misc
1008  1194  1403  1876  2579  39   70   84         cpuinfo      modules
1020  1196  1410  1882  2596  405  706  85         crypto       mounts
1047  1198  1436  1889  26    425  71   86         devices      mtrr
1064  12    1440  198   2613  44   72   860        diskstats    net
1066  1200  1446  199   2614  45   73   87         dma          pagetypeinfo
1069  1202  15    2     2679  450  731  880        driver       partitions
107   1204  1507  20    27    453  733  881        execdomains  sched_debug
1071  1214  151   201   2709  46   74   882        fb           schedstat
1073  1218  1517  202   2712  492  748  883        filesystems  scsi
108   1266  152   2080  274   498  75   884        fs           self
1084  1272  155   21    2754  5    76   885        i8k          slabinfo
1086  1274  157   2101  2761  503  765  890        interrupts   softirqs
1089  1292  158   2127  2762  61   77   895        iomem        stat
1092  13    159   22    2772  63   78   899        ioports      swaps
1094  1301  16    2276  28    64   79   9          irq          sys
11    1310  160   23    282   65   792  905        kallsyms 
sysrq-trigger
1100  1312  161   239   29    66   793  907        kcore        sysvipc
1101  1313  162   2442  3     661  795  910        keys         thread-self
1102  1314  1626  2443  30    67   799  93         key-users    timer_list
1108  1335  1628  2454  31    679  8    94         kmsg         timer_stats
1110  1340  163   2459  32    68   80   999        kpagecgroup  tty
1112  1349  164   2499  321   681  802  acpi       kpagecount   uptime
1117  1355  17    25    33    683  804  asound     kpageflags   version
1129  1360  170   2505  34    69   805  buddyinfo  loadavg      vmallocinfo
1165  1366  1769  2518  35    692  807  bus        locks        vmstat
1174  1376  1773  2520  36    696  81   cgroups    mdstat       zoneinfo


[X]

URL of Launchpad Bug:   https://bugs.launchpad.net/bugs/1513914

The problem never occurs immediately after start-up, but begins 
happening after 1-4 hours of use, (mainly light use, emails & internet 
browsing)
If I shut down when problem occurs and re-start about 20 seconds later, 
the problem does not happen again for another 1-4 hours.

The problem does not occur when booting Windows 7 Pro 64 bit.






