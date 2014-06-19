From: Jessica Groben <jaadw@gmx.de>
Subject: [Asus X550LD] Touchpad not working/properly detected
Date: Thu, 19 Jun 2014 10:10:25 +0200
Message-ID: <53A29AF1.2020608@gmx.de>
References: <53A19B5F.3020604@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:54585 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750975AbaFSIKa (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Jun 2014 04:10:30 -0400
Received: from [192.168.23.55] ([62.158.86.189]) by mail.gmx.com (mrgmx101)
 with ESMTPSA (Nemesis) id 0M97Nh-1WsLQE0Avt-00CPU9 for
 <linux-input@vger.kernel.org>; Thu, 19 Jun 2014 10:10:27 +0200
In-Reply-To: <53A19B5F.3020604@gmx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org



[1.] Summary:

[Asus X550LD] Touchpad not working/detected

[2.] Description:

Touchpad is detected as "PS/2 Logitech Wheel Mouse". The pointer is
moving itself every three seconds a cm to the left side of the screen.
Can't make anything with it. No moving of cursor, no clicking.

The newest kernel (v3.16-rc1-utopic) isn't even able to start. Getting a
neverending error:
"psmouse serio4 : Failed to enable mouse on isa0060/serio4"


[3.] Keywords:


[4.] Kernel version:

Linux version 3.15.1-031501-generic (apw@gomeisa) (gcc version 4.6.3
(Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201406161841 SMP Mon Jun 16 22:42:50
UTC 2014


[5.] Output of Oops..

none


[6.] A small shell script...

none


[7.] Environment

Description: Ubuntu 14.04 LTS

Release: 14.04


[7.1.] Software (add the output of the ver_linux script here)


Linux jibba-X550LD 3.15.1-031501-generic #201406161841 SMP Mon Jun 16
22:42:50 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux

Gnu C 4.8

Gnu make 3.81

binutils 2.24

util-linux 2.20.1

mount support

module-init-tools 15

e2fsprogs 1.42.9

pcmciautils 018

PPP 2.4.5

Linux C Library 2.19

Dynamic linker (ldd) 2.19

Procps 3.3.9

Net-tools 1.60

Kbd 1.15.5

Sh-utils 8.21

wireless-tools 30

Modules Loaded ctr ccm nvram rfcomm bnep bluetooth 6lowpan_iphc
binfmt_misc nls_iso8859_1 snd_hda_codec_realtek snd_hda_codec_hdmi
snd_hda_codec_generic uvcvideo intel_rapl x86_pkg_temp_thermal
intel_powerclamp coretemp kvm_intel videobuf2_vmalloc videobuf2_memops
arc4 videobuf2_core kvm ath9k videodev snd_hda_intel snd_soc_rt5640
crct10dif_pclmul crc32_pclmul ghash_clmulni_intel snd_hda_controller
aesni_intel snd_soc_core snd_hda_codec aes_x86_64 lrw gf128mul
ath9k_common snd_compress snd_hwdep snd_pcm ath9k_hw glue_helper
ablk_helper snd_seq_midi cryptd asus_nb_wmi ath snd_seq_midi_event
snd_rawmidi mac80211 nouveau snd_seq i915 asus_wmi sparse_keymap
parport_pc snd_seq_device ppdev snd_timer serio_raw lp mei_me mxm_wmi
cfg80211 ttm drm_kms_helper mei snd drm parport snd_soc_sst_acpi
soundcore video wmi dw_dmac dw_dmac_core i2c_hid 8250_dw i2c_algo_bit
i2c_designware_platform rtsx_pci_ms i2c_designware_core memstick lpc_ich
spi_pxa2xx_platform mac_hid hid_generic usbhid hid rtsx_pci_sdmmc ahci
libahci psmouse r8169 rtsx_pci mii sdhci_acpi sdhci


[7.2.] Processor information (from /proc/cpuinfo):


processor : 0

vendor_id : GenuineIntel

cpu family : 6

model : 69

model name : Intel(R) Core(TM) i3-4010U CPU @ 1.70GHz

stepping : 1

microcode : 0x17

cpu MHz : 1700.000

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
ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic
movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm
arat epb xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid
fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid

bogomips : 3392.28

clflush size : 64

cache_alignment : 64

address sizes : 39 bits physical, 48 bits virtual

power management:

processor : 1

vendor_id : GenuineIntel

cpu family : 6

model : 69

model name : Intel(R) Core(TM) i3-4010U CPU @ 1.70GHz

stepping : 1

microcode : 0x17

cpu MHz : 1700.132

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
ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic
movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm
arat epb xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid
fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid

bogomips : 3392.28

clflush size : 64

cache_alignment : 64

address sizes : 39 bits physical, 48 bits virtual

power management:

processor : 2

vendor_id : GenuineIntel

cpu family : 6

model : 69

model name : Intel(R) Core(TM) i3-4010U CPU @ 1.70GHz

stepping : 1

microcode : 0x17

cpu MHz : 1700.000

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
ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic
movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm
arat epb xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid
fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid

bogomips : 3392.28

clflush size : 64

cache_alignment : 64

address sizes : 39 bits physical, 48 bits virtual

power management:

processor : 3

vendor_id : GenuineIntel

cpu family : 6

model : 69

model name : Intel(R) Core(TM) i3-4010U CPU @ 1.70GHz

stepping : 1

microcode : 0x17

cpu MHz : 1700.132

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
ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic
movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm
arat epb xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid
fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid

bogomips : 3392.28

clflush size : 64

cache_alignment : 64

address sizes : 39 bits physical, 48 bits virtual

power management:

[7.3.] Module information (from /proc/modules):


ctr 13193 1 - Live 0x0000000000000000

ccm 17856 1 - Live 0x0000000000000000

nvram 14462 0 - Live 0x0000000000000000

rfcomm 75078 0 - Live 0x0000000000000000

bnep 19884 2 - Live 0x0000000000000000

bluetooth 461775 10 rfcomm,bnep, Live 0x0000000000000000

6lowpan_iphc 18968 1 bluetooth, Live 0x0000000000000000

binfmt_misc 17508 1 - Live 0x0000000000000000

nls_iso8859_1 12713 1 - Live 0x0000000000000000

snd_hda_codec_realtek 72529 1 - Live 0x0000000000000000

snd_hda_codec_hdmi 48229 1 - Live 0x0000000000000000

snd_hda_codec_generic 70087 1 snd_hda_codec_realtek, Live
0x0000000000000000

uvcvideo 82299 0 - Live 0x0000000000000000

intel_rapl 19238 0 - Live 0x0000000000000000

x86_pkg_temp_thermal 14312 0 - Live 0x0000000000000000

intel_powerclamp 19099 0 - Live 0x0000000000000000

coretemp 13638 0 - Live 0x0000000000000000

kvm_intel 148919 0 - Live 0x0000000000000000

videobuf2_vmalloc 13216 1 uvcvideo, Live 0x0000000000000000

videobuf2_memops 13362 1 videobuf2_vmalloc, Live 0x0000000000000000

arc4 12573 2 - Live 0x0000000000000000

videobuf2_core 45435 1 uvcvideo, Live 0x0000000000000000

kvm 463855 1 kvm_intel, Live 0x0000000000000000

ath9k 147545 0 - Live 0x0000000000000000

videodev 149504 2 uvcvideo,videobuf2_core, Live 0x0000000000000000

snd_hda_intel 30608 5 - Live 0x0000000000000000

snd_soc_rt5640 88063 0 - Live 0x0000000000000000

crct10dif_pclmul 14268 0 - Live 0x0000000000000000

crc32_pclmul 13180 0 - Live 0x0000000000000000

ghash_clmulni_intel 13230 0 - Live 0x0000000000000000

snd_hda_controller 35518 1 snd_hda_intel, Live 0x0000000000000000

aesni_intel 152648 2 - Live 0x0000000000000000

snd_soc_core 201495 1 snd_soc_rt5640, Live 0x0000000000000000

snd_hda_codec 144671 5
snd_hda_codec_realtek,snd_hda_codec_hdmi,snd_hda_codec_generic,snd_hda_intel,snd_hda_controller,
Live 0x0000000000000000

aes_x86_64 17131 1 aesni_intel, Live 0x0000000000000000

lrw 13323 1 aesni_intel, Live 0x0000000000000000

gf128mul 14951 1 lrw, Live 0x0000000000000000

ath9k_common 15984 1 ath9k, Live 0x0000000000000000

snd_compress 19435 1 snd_soc_core, Live 0x0000000000000000

snd_hwdep 13613 1 snd_hda_codec, Live 0x0000000000000000

snd_pcm 113863 5
snd_hda_codec_hdmi,snd_hda_intel,snd_hda_controller,snd_soc_core,snd_hda_codec,
Live 0x0000000000000000

ath9k_hw 459576 2 ath9k,ath9k_common, Live 0x0000000000000000

glue_helper 14095 1 aesni_intel, Live 0x0000000000000000

ablk_helper 13597 1 aesni_intel, Live 0x0000000000000000

snd_seq_midi 13564 0 - Live 0x0000000000000000

cryptd 20531 3 ghash_clmulni_intel,aesni_intel,ablk_helper, Live
0x0000000000000000

asus_nb_wmi 16990 0 - Live 0x0000000000000000

ath 29397 3 ath9k,ath9k_common,ath9k_hw, Live 0x0000000000000000

snd_seq_midi_event 14899 1 snd_seq_midi, Live 0x0000000000000000

snd_rawmidi 30865 1 snd_seq_midi, Live 0x0000000000000000

mac80211 663788 1 ath9k, Live 0x0000000000000000

nouveau 1212985 0 - Live 0x0000000000000000

snd_seq 67636 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000

i915 873414 5 - Live 0x0000000000000000

asus_wmi 24697 1 asus_nb_wmi, Live 0x0000000000000000

sparse_keymap 13890 1 asus_wmi, Live 0x0000000000000000

parport_pc 32906 0 - Live 0x0000000000000000

snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live
0x0000000000000000

ppdev 17711 0 - Live 0x0000000000000000

snd_timer 30118 2 snd_pcm,snd_seq, Live 0x0000000000000000

serio_raw 13483 0 - Live 0x0000000000000000

lp 17799 0 - Live 0x0000000000000000

mei_me 18562 0 - Live 0x0000000000000000

mxm_wmi 13021 1 nouveau, Live 0x0000000000000000

cfg80211 514187 4 ath9k,ath9k_common,ath,mac80211, Live 0x0000000000000000

ttm 90341 1 nouveau, Live 0x0000000000000000

drm_kms_helper 59729 2 nouveau,i915, Live 0x0000000000000000

mei 87522 1 mei_me, Live 0x0000000000000000

snd 74195 23
snd_hda_codec_realtek,snd_hda_codec_hdmi,snd_hda_codec_generic,snd_hda_intel,snd_soc_core,snd_hda_codec,snd_compress,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_seq_device,snd_timer,
Live 0x0000000000000000

drm 310655 7 nouveau,i915,ttm,drm_kms_helper, Live 0x0000000000000000

parport 42481 3 parport_pc,ppdev,lp, Live 0x0000000000000000

snd_soc_sst_acpi 13007 0 - Live 0x0000000000000000

soundcore 12680 2 snd_hda_codec,snd, Live 0x0000000000000000

video 19932 3 nouveau,i915,asus_wmi, Live 0x0000000000000000

wmi 19379 3 nouveau,asus_wmi,mxm_wmi, Live 0x0000000000000000

dw_dmac 12836 0 - Live 0x0000000000000000

dw_dmac_core 28517 1 dw_dmac, Live 0x0000000000000000

i2c_hid 19233 0 - Live 0x0000000000000000

8250_dw 13431 0 - Live 0x0000000000000000

i2c_algo_bit 13564 2 nouveau,i915, Live 0x0000000000000000

i2c_designware_platform 13025 0 - Live 0x0000000000000000

rtsx_pci_ms 18337 0 - Live 0x0000000000000000

i2c_designware_core 14990 1 i2c_designware_platform, Live
0x0000000000000000

memstick 16968 1 rtsx_pci_ms, Live 0x0000000000000000

lpc_ich 21176 0 - Live 0x0000000000000000

spi_pxa2xx_platform 23302 0 - Live 0x0000000000000000

mac_hid 13275 0 - Live 0x0000000000000000

hid_generic 12559 0 - Live 0x0000000000000000

usbhid 53121 0 - Live 0x0000000000000000

hid 106436 3 i2c_hid,hid_generic,usbhid, Live 0x0000000000000000

rtsx_pci_sdmmc 23482 0 - Live 0x0000000000000000

ahci 30167 4 - Live 0x0000000000000000

libahci 32191 1 ahci, Live 0x0000000000000000

psmouse 97592 0 - Live 0x0000000000000000 (OE)

r8169 73316 0 - Live 0x0000000000000000

rtsx_pci 46393 2 rtsx_pci_ms,rtsx_pci_sdmmc, Live 0x0000000000000000

mii 13981 1 r8169, Live 0x0000000000000000

sdhci_acpi 13395 0 - Live 0x0000000000000000

sdhci 43409 1 sdhci_acpi, Live 0x0000000000000000


[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

While booted into the newest upstream mainline kernel only, execute the
following in a terminal, and paste the results:

cat /proc/ioports


0000-0cf7 : PCI Bus 0000:00

0000-001f : dma1

0020-0021 : pic1

0040-0043 : timer0

0050-0053 : timer1

0060-0060 : keyboard

0062-0062 : EC data

0064-0064 : keyboard

0066-0066 : EC cmd

0070-0077 : rtc0

0080-008f : dma page reg

00a0-00a1 : pic2

00c0-00df : dma2

00f0-00ff : fpu

0240-0259 : pnp 00:08

04d0-04d1 : pnp 00:07

0680-069f : pnp 00:04

0cf8-0cff : PCI conf1

0d00-ffff : PCI Bus 0000:00

164e-164f : pnp 00:04

1800-1803 : ACPI PM1a_EVT_BLK

1804-1805 : ACPI PM1a_CNT_BLK

1808-180b : ACPI PM_TMR

1810-1815 : ACPI CPU throttle

1830-1833 : iTCO_wdt

1850-1850 : ACPI PM2_CNT_BLK

1854-1857 : pnp 00:06

1860-187f : iTCO_wdt

1880-189f : ACPI GPE0_BLK

1c00-1cfe : pnp 00:04

1d00-1dfe : pnp 00:04

1e00-1efe : pnp 00:04

1f00-1ffe : pnp 00:04

d000-dfff : PCI Bus 0000:04

d000-d07f : 0000:04:00.0

e000-efff : PCI Bus 0000:02

e000-e0ff : 0000:02:00.1

e000-e0ff : r8169

f000-f03f : 0000:00:02.0

f040-f05f : 0000:00:1f.3

f060-f07f : 0000:00:1f.2

f060-f07f : ahci

f080-f083 : 0000:00:1f.2

f080-f083 : ahci

f090-f097 : 0000:00:1f.2

f090-f097 : ahci

f0a0-f0a3 : 0000:00:1f.2

f0a0-f0a3 : ahci

f0b0-f0b7 : 0000:00:1f.2

f0b0-f0b7 : ahci

ffff-ffff : pnp 00:04

ffff-ffff : pnp 00:04

ffff-ffff : pnp 00:04


cat /proc/iomem


00000000-00000fff : reserved

00001000-00057fff : System RAM

00058000-00058fff : reserved

00059000-0009efff : System RAM

0009f000-0009ffff : reserved

000a0000-000bffff : PCI Bus 0000:00

000c0000-000cebff : Video ROM

000d0000-000d3fff : PCI Bus 0000:00

000d4000-000d7fff : PCI Bus 0000:00

000d8000-000dbfff : PCI Bus 0000:00

000dc000-000dffff : PCI Bus 0000:00

000f0000-000fffff : System ROM

00100000-b9a63fff : System RAM

02000000-02788e58 : Kernel code

02788e59-02d265bf : Kernel data

02e84000-02febfff : Kernel bss

b9a64000-b9a6afff : ACPI Non-volatile Storage

b9a6b000-ba2a1fff : System RAM

ba2a2000-ba507fff : reserved

ba508000-c9910fff : System RAM

c9911000-c9b18fff : reserved

c9b19000-c9e40fff : System RAM

c9e41000-cab4cfff : ACPI Non-volatile Storage

cab4d000-caf57fff : reserved

caf58000-caffefff : reserved

cafff000-caffffff : System RAM

cb000000-cbbfffff : RAM buffer

cbc00000-cfdfffff : reserved

cbe00000-cfdfffff : Graphics Stolen Memory

cfe00000-feafffff : PCI Bus 0000:00

d0000000-dfffffff : 0000:00:02.0

e0000000-f1ffffff : PCI Bus 0000:04

e0000000-efffffff : 0000:04:00.0

f0000000-f1ffffff : 0000:04:00.0

f6000000-f70fffff : PCI Bus 0000:04

f6000000-f6ffffff : 0000:04:00.0

f7000000-f707ffff : 0000:04:00.0

f7400000-f77fffff : 0000:00:02.0

f7800000-f78fffff : PCI Bus 0000:03

f7800000-f787ffff : 0000:03:00.0

f7800000-f787ffff : ath9k

f7880000-f788ffff : 0000:03:00.0

f7900000-f79fffff : PCI Bus 0000:02

f7900000-f790ffff : 0000:02:00.0

f7910000-f7913fff : 0000:02:00.1

f7910000-f7913fff : r8169

f7914000-f7914fff : 0000:02:00.1

f7914000-f7914fff : r8169

f7915000-f7915fff : 0000:02:00.0

f7915000-f7915fff : rtsx_pci

f7a00000-f7a0ffff : 0000:00:14.0

f7a00000-f7a0ffff : xhci_hcd

f7a10000-f7a17fff : 0000:00:04.0

f7a18000-f7a1bfff : 0000:00:1b.0

f7a18000-f7a1bfff : ICH HD audio

f7a1c000-f7a1ffff : 0000:00:03.0

f7a1c000-f7a1ffff : ICH HD audio

f7a20000-f7a20fff : 0000:00:1f.6

f7a21000-f7a210ff : 0000:00:1f.3

f7a22000-f7a227ff : 0000:00:1f.2

f7a22000-f7a227ff : ahci

f7a23000-f7a233ff : 0000:00:1d.0

f7a23000-f7a233ff : ehci_hcd

f7a25000-f7a2501f : 0000:00:16.0

f7a25000-f7a2501f : mei_me

f7fdf000-f7fdffff : pnp 00:0c

f7fe0000-f7feffff : pnp 00:0c

f8000000-fbffffff : PCI MMCONFIG 0000 [bus 00-3f]

f8000000-fbffffff : reserved

f8000000-fbffffff : pnp 00:0c

fec00000-fec00fff : reserved

fec00000-fec003ff : IOAPIC 0

fed00000-fed03fff : reserved

fed00000-fed003ff : HPET 0

fed10000-fed17fff : pnp 00:0c

fed18000-fed18fff : pnp 00:0c

fed19000-fed19fff : pnp 00:0c

fed1c000-fed1ffff : reserved

fed1c000-fed1ffff : pnp 00:0c

fed1f410-fed1f414 : iTCO_wdt

fed20000-fed3ffff : pnp 00:0c

fed40000-fed44fff : pnp 00:00

fed45000-fed8ffff : pnp 00:0c

fed90000-fed90fff : dmar0

fed91000-fed91fff : dmar1

fee00000-fee00fff : Local APIC

fee00000-fee00fff : reserved

ff000000-ffffffff : reserved

ff000000-ffffffff : pnp 00:0c

100000000-12f1fffff : System RAM

12f200000-12fffffff : RAM buffer


[7.5.] PCI information ('lspci -vvv' as root)


L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+

PortCommonModeRestoreTime=40us PortTPowerOnTime=10us

Kernel driver in use: pcieport

00:1c.3 PCI bridge: Intel Corporation Lynx Point-LP PCI Express Root
Port 4 (rev e4) (prog-if 00 [Normal decode])

Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+

Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-

Latency: 0, Cache Line Size: 64 bytes

Bus: primary=00, secondary=03, subordinate=03, sec-latency=0

I/O behind bridge: 0000f000-00000fff

Memory behind bridge: f7800000-f78fffff

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

LnkCap: Port #4, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s
<512ns, L1 <16us

ClockPM- Surprise- LLActRep+ BwNot+

LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+

ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-

LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+
BWMgmt+ ABWMgmt-

SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-

Slot #3, PowerLimit 10.000W; Interlock- NoCompl+

SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-

Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-

SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-

Changed: MRL- PresDet- LinkState-

RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-

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

Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-

Address: fee00318 Data: 0000

Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 131d

Capabilities: [a0] Power Management version 3

Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)

Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-

Capabilities: [100 v0] #00

Capabilities: [200 v1] L1 PM Substates

L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+

PortCommonModeRestoreTime=40us PortTPowerOnTime=10us

Kernel driver in use: pcieport

00:1c.4 PCI bridge: Intel Corporation Lynx Point-LP PCI Express Root
Port 5 (rev e4) (prog-if 00 [Normal decode])

Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+

Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-

Latency: 0, Cache Line Size: 64 bytes

Bus: primary=00, secondary=04, subordinate=04, sec-latency=0

I/O behind bridge: 0000d000-0000dfff

Memory behind bridge: f6000000-f70fffff

Prefetchable memory behind bridge: 00000000e0000000-00000000f1ffffff

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

LnkCap: Port #5, Speed 5GT/s, Width x4, ASPM L0s L1, Exit Latency L0s
<512ns, L1 <16us

ClockPM- Surprise- LLActRep+ BwNot+

LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+

ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-

LnkSta: Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+ DLActive+
BWMgmt- ABWMgmt-

SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-

Slot #4, PowerLimit 25.000W; Interlock- NoCompl+

SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-

Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-

SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-

Changed: MRL- PresDet+ LinkState+

RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-

RootCap: CRSVisible-

RootSta: PME ReqID 0000, PMEStatus- PMEPending-

DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Not
Supported ARIFwd-

DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF
Disabled ARIFwd-

LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-

Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
ComplianceSOS-

Compliance De-emphasis: -6dB

LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
EqualizationPhase1-

EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-

Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-

Address: fee00338 Data: 0000

Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 131d

Capabilities: [a0] Power Management version 3

Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)

Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-

Capabilities: [100 v0] #00

Capabilities: [200 v1] L1 PM Substates

L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+

PortCommonModeRestoreTime=40us PortTPowerOnTime=10us

Kernel driver in use: pcieport

00:1d.0 USB controller: Intel Corporation Lynx Point-LP USB EHCI #1 (rev
04) (prog-if 20 [EHCI])

Subsystem: ASUSTeK Computer Inc. Device 201f

Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-

Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

Latency: 0

Interrupt: pin A routed to IRQ 23

Region 0: Memory at f7a23000 (32-bit, non-prefetchable) [size=1K]

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

00:1f.0 ISA bridge: Intel Corporation Lynx Point-LP LPC Controller (rev 04)

Subsystem: ASUSTeK Computer Inc. Device 131d

Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-

Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

Latency: 0

Capabilities: [e0] Vendor Specific Information: Len=0c <?>

Kernel driver in use: lpc_ich

00:1f.2 SATA controller: Intel Corporation Lynx Point-LP SATA Controller
1 [AHCI mode] (rev 04) (prog-if 01 [AHCI 1.0])

Subsystem: ASUSTeK Computer Inc. Device 131d

Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+

Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

Latency: 0

Interrupt: pin B routed to IRQ 64

Region 0: I/O ports at f0b0 [size=8]

Region 1: I/O ports at f0a0 [size=4]

Region 2: I/O ports at f090 [size=8]

Region 3: I/O ports at f080 [size=4]

Region 4: I/O ports at f060 [size=32]

Region 5: Memory at f7a22000 (32-bit, non-prefetchable) [size=2K]

Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-

Address: fee00398 Data: 0000

Capabilities: [70] Power Management version 3

Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)

Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-

Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004

Kernel driver in use: ahci

00:1f.3 SMBus: Intel Corporation Lynx Point-LP SMBus Controller (rev 04)

Subsystem: ASUSTeK Computer Inc. Device 131d

Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-

Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

Interrupt: pin C routed to IRQ 3

Region 0: Memory at f7a21000 (64-bit, non-prefetchable) [size=256]

Region 4: I/O ports at f040 [size=32]

00:1f.6 Signal processing controller: Intel Corporation Lynx Point-LP
Thermal (rev 04)

Subsystem: ASUSTeK Computer Inc. Device 131d

Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-

Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-

Latency: 0

Interrupt: pin C routed to IRQ 3

Region 0: Memory at f7a20000 (64-bit, non-prefetchable) [size=4K]

Capabilities: [50] Power Management version 3

Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)

Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-

Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-

Address: 00000000 Data: 0000

02:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. Device
5287 (rev 01)

Subsystem: ASUSTeK Computer Inc. Device 202f

Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+

Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-

Latency: 0, Cache Line Size: 64 bytes

Interrupt: pin B routed to IRQ 63

Region 0: Memory at f7915000 (32-bit, non-prefetchable) [size=4K]

Expansion ROM at f7900000 [disabled] [size=64K]

Capabilities: [40] Power Management version 3

Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)

Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-

Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+

Address: 00000000fee00378 Data: 0000

Capabilities: [70] Express (v2) Endpoint, MSI 00

DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us

ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-

DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-

RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-

MaxPayload 128 bytes, MaxReadReq 512 bytes

DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-

LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s
unlimited, L1 <64us

ClockPM+ Surprise- LLActRep- BwNot-

LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk-

ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-

LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-

DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR+, OBFF Via
message/WAKE#

DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Disabled

LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-

Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
ComplianceSOS-

Compliance De-emphasis: -6dB

LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
EqualizationPhase1-

EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-

Capabilities: [b0] MSI-X: Enable- Count=1 Masked-

Vector table: BAR=0 offset=00000000

PBA: BAR=0 offset=00000000

Capabilities: [d0] Vital Product Data

pcilib: sysfs_read_vpd: read failed: Connection timed out

Not readable

Capabilities: [100 v2] Advanced Error Reporting

UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
ECRC- UnsupReq- ACSViol-

UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
ECRC- UnsupReq- ACSViol-

UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-

CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+

CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+

AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-

Capabilities: [140 v1] Virtual Channel

Caps: LPEVC=0 RefClk=100ns PATEntryBits=1

Arb: Fixed- WRR32- WRR64- WRR128-

Ctrl: ArbSelect=Fixed

Status: InProgress-

VC0: Caps: PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-

Arb: Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-

Ctrl: Enable+ ID=0 ArbSelect=Fixed TC/VC=01

Status: NegoPending- InProgress-

Capabilities: [160 v1] Device Serial Number 00-00-00-00-00-00-00-00

Capabilities: [170 v1] Latency Tolerance Reporting

Max snoop latency: 3145728ns

Max no snoop latency: 3145728ns

Capabilities: [178 v1] L1 PM Substates

L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+

PortCommonModeRestoreTime=150us PortTPowerOnTime=150us

Kernel driver in use: rtsx_pci

02:00.1 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 12)

Subsystem: ASUSTeK Computer Inc. Device 200f

Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+

Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-

Latency: 0, Cache Line Size: 64 bytes

Interrupt: pin A routed to IRQ 65

Region 0: I/O ports at e000 [size=256]

Region 2: Memory at f7914000 (64-bit, non-prefetchable) [size=4K]

Region 4: Memory at f7910000 (64-bit, non-prefetchable) [size=16K]

Capabilities: [40] Power Management version 3

Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)

Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-

Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+

Address: 00000000fee003b8 Data: 0000

Capabilities: [70] Express (v2) Endpoint, MSI 01

DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us

ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-

DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-

RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-

MaxPayload 128 bytes, MaxReadReq 4096 bytes

DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-

LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s
unlimited, L1 <64us

ClockPM+ Surprise- LLActRep- BwNot-

LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+

ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-

LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-

DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR+, OBFF Via
message/WAKE#

DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled

LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
EqualizationPhase1-

EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-

Capabilities: [b0] MSI-X: Enable- Count=4 Masked-

Vector table: BAR=4 offset=00000000

PBA: BAR=4 offset=00000800

Capabilities: [d0] Vital Product Data

Unknown small resource type 00, will not decode more.

Capabilities: [100 v2] Advanced Error Reporting

UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
ECRC- UnsupReq- ACSViol-

UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
ECRC- UnsupReq- ACSViol-

UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-

CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+

CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+

AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-

Capabilities: [160 v1] Device Serial Number 17-31-71-11-68-4c-e0-00

Capabilities: [170 v1] Latency Tolerance Reporting

Max snoop latency: 3145728ns

Max no snoop latency: 3145728ns

Capabilities: [178 v1] L1 PM Substates

L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+

PortCommonModeRestoreTime=150us PortTPowerOnTime=150us

Kernel driver in use: r8169

03:00.0 Network controller: Qualcomm Atheros AR9485 Wireless Network
Adapter (rev 01)

Subsystem: AzureWave Device 1186

Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-

Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-

Latency: 0, Cache Line Size: 64 bytes

Interrupt: pin A routed to IRQ 19

Region 0: Memory at f7800000 (64-bit, non-prefetchable) [size=512K]

Expansion ROM at f7880000 [disabled] [size=64K]

Capabilities: [40] Power Management version 2

Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)

Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-

Capabilities: [50] MSI: Enable- Count=1/4 Maskable+ 64bit+

Address: 0000000000000000 Data: 0000

Masking: 00000000 Pending: 00000000

Capabilities: [70] Express (v2) Endpoint, MSI 00

DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 <64us

ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-

DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-

RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-

MaxPayload 128 bytes, MaxReadReq 512 bytes

DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-

LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s
<4us, L1 <64us

ClockPM- Surprise- LLActRep- BwNot-

LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+

ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-

LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-

DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR-, OBFF Not
Supported

DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled

LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-

Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
ComplianceSOS-

Compliance De-emphasis: -6dB

LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
EqualizationPhase1-

EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-

Capabilities: [100 v1] Advanced Error Reporting

UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
ECRC- UnsupReq- ACSViol-

UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
ECRC- UnsupReq- ACSViol-

UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-

CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+

CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+

AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-

Capabilities: [140 v1] Virtual Channel

Caps: LPEVC=0 RefClk=100ns PATEntryBits=1

Arb: Fixed- WRR32- WRR64- WRR128-

Ctrl: ArbSelect=Fixed

Status: InProgress-

VC0: Caps: PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-

Arb: Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-

Ctrl: Enable+ ID=0 ArbSelect=Fixed TC/VC=01

Status: NegoPending- InProgress-

Capabilities: [160 v1] Device Serial Number 00-00-00-00-00-00-00-00

Kernel driver in use: ath9k

04:00.0 3D controller: NVIDIA Corporation GF117M [GeForce 610M/710M/820M
/ GT 620M/625M/630M/720M] (rev a1)

Subsystem: ASUSTeK Computer Inc. GeForce 820M

Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+

Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-

Latency: 0, Cache Line Size: 64 bytes

Interrupt: pin A routed to IRQ 70

Region 0: Memory at f6000000 (32-bit, non-prefetchable) [size=16M]

Region 1: Memory at e0000000 (64-bit, prefetchable) [size=256M]

Region 3: Memory at f0000000 (64-bit, prefetchable) [size=32M]

Region 5: I/O ports at d000 [size=128]

Expansion ROM at f7000000 [disabled] [size=512K]

Capabilities: [60] Power Management version 3

Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)

Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-

Capabilities: [68] MSI: Enable+ Count=1/1 Maskable- 64bit+

Address: 00000000fee00458 Data: 0000

Capabilities: [78] Express (v2) Endpoint, MSI 00

DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s unlimited, L1 <64us

ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-

DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-

RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+

MaxPayload 128 bytes, MaxReadReq 512 bytes

DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-

LnkCap: Port #0, Speed 2.5GT/s, Width x8, ASPM L0s L1, Exit Latency L0s
<512ns, L1 <4us

ClockPM+ Surprise- LLActRep- BwNot-

LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+

ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-

LnkSta: Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-

DevCap2: Completion Timeout: Range AB, TimeoutDis+, LTR-, OBFF Not
Supported

DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled

LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-

Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
ComplianceSOS-

Compliance De-emphasis: -6dB

LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
EqualizationPhase1-

EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-

Capabilities: [b4] Vendor Specific Information: Len=14 <?>

Capabilities: [100 v1] Virtual Channel

Caps: LPEVC=0 RefClk=100ns PATEntryBits=1

Arb: Fixed- WRR32- WRR64- WRR128-

Ctrl: ArbSelect=Fixed

Status: InProgress-

VC0: Caps: PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-

Arb: Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-

Ctrl: Enable+ ID=0 ArbSelect=Fixed TC/VC=01

Status: NegoPending- InProgress-

Capabilities: [128 v1] Power Budgeting <?>

Capabilities: [600 v1] Vendor Specific Information: ID=0001 Rev=1
Len=024 <?>

Kernel driver in use: nouveau


[7.6.] SCSI information (from /proc/scsi/scsi)


Attached devices:

Host: scsi0 Channel: 00 Id: 00 Lun: 00

Vendor: ATA Model: TOSHIBA MQ01ABF0 Rev: AM0B

Type: Direct-Access ANSI SCSI revision: 05

Host: scsi1 Channel: 00 Id: 00 Lun: 00

Vendor: MATSHITA Model: DVD-RAM UJ8E2 S Rev: 1.00

Type: CD-ROM ANSI SCSI revision: 05


[7.7.] Other information that might be relevant to the problem (please
look in /proc and include all information that you think to be relevant):

1 15 1646 1936 2573 4 750 crypto net

10 150 1648 1946 2575 40 764 devices pagetypeinfo

1035 1501 1675 1967 26 400 765 diskstats partitions

1037 1507 168 1975 2631 401 785 dma sched_debug

1058 151 1683 2 2645 41 788 driver schedstat

1060 1513 1685 20 2794 42 789 execdomains scsi

1065 1515 1686 2018 28 43 794 fb self

11 1519 1688 2070 2840 44 8 filesystems slabinfo

1141 152 1689 2074 2884 45 803 fs softirqs

1143 1521 169 2085 2885 46 808 interrupts stat

1146 153 1691 21 294 47 871 iomem swaps

12 1535 1694 2176 2940 48 877 ioports sys

1234 1539 1695 2179 2943 49 884 ipmi sysrq-trigger

1245 1542 1696 2184 2945 5 9 irq sysvipc

1249 1543 17 2187 2948 51 91 kallsyms timer_list

1252 1545 1736 2188 2951 519 92 kcore timer_stats

13 1549 1743 2193 3 53 963 key-users tty

1397 1553 1821 2214 30 54 967 kmsg uptime

14 156 1840 2299 31 542 973 kpagecount version

1402 1563 1850 23 313 55 974 kpageflags vmallocinfo

1419 1566 1857 2329 33 601 977 latency_stats vmstat

143 1567 1859 2340 34 618 acpi loadavg zoneinfo

145 1569 1861 2391 35 623 asound locks

146 1586 1864 2407 355 67 buddyinfo mdstat

147 16 1890 2426 36 68 bus meminfo

148 160 1907 25 366 7 cgroups misc

1487 1604 1911 2544 37 70 cmdline modules

149 1623 1927 2555 38 71 consoles mounts

1493 1632 1932 2560 39 722 cpuinfo mtrr


[X.] Other notes, patches, fixes, workarounds:


link to Launchpad bug report:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1325881




