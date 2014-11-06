From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: PROBLEM: Lenovo ThinkPad X1 Carbon Wireless switch key doesn't work
Date: Thu, 6 Nov 2014 10:17:14 -0500
Message-ID: <CAN+gG=FsASrEvxgFfddHeMOR0eMWQcBSWA2KebXTVkGUzOcyFA@mail.gmail.com>
References: <CABb-vWFL53HrL8uwJcCEnCN25OuY7URFaK9-nF8Ypf4CcH0j_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:43502 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895AbaKFPRQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Nov 2014 10:17:16 -0500
In-Reply-To: <CABb-vWFL53HrL8uwJcCEnCN25OuY7URFaK9-nF8Ypf4CcH0j_g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sergei Serdyuk <sergei@redleafsoft.com>, platform-driver-x86@vger.kernel.org
Cc: linux-input <linux-input@vger.kernel.org>

Hi,

not that we can not help here on linux-input, but this file is managed
by the platform tree.
Adding them in CC in case somebody already fixed the problem.

Cheers,
Benjamin

On Thu, Nov 6, 2014 at 8:07 AM, Sergei Serdyuk <sergei@redleafsoft.com> wrote:
> [1] [Lenovo ThinkPad X1 Carbon 20A8] Wireless switch key doesn't work
>
> [2] On my X1 Carbon laptop the wireless switch key doesn't work. It
> appears that the code in charge of handling the X1 Carbon adaptive
> keyboard is here and rfkill handling is there:
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/jic23/iio/+/refs/heads/togreg/drivers/platform/x86/thinkpad_acpi.c
>
> Pressing the key generates no events (see below) and thus has no
> effect. So, it's either my stock kernel doesn't have it, or something
> else is broken. Nothing ever fires when I press all extra buttons
> including the wireless one.
>
> This may be not specific to the adaptive keyboard too. While I was
> googling for a solution, I saw similar complaints for other Thinkpad
> models.
>
> ls /dev/input/by-path/platform-thinkpad_acpi-event -lh
> lrwxrwxrwx 1 root root 9 Nov 2 19:45
> /dev/input/by-path/platform-thinkpad_acpi-event -> ../event7
>
> input-events 7
> /dev/input/event7
>    bustype : BUS_HOST
>    vendor : 0x17aa
>    product : 0x5054
>    version : 16641
>    name : "ThinkPad Extra Buttons"
>    phys : "thinkpad_acpi/input0"
>    bits ev : EV_SYN EV_KEY EV_MSC EV_SW
>
> waiting for events
> timeout, quitting
>
> # acpi events fire for all extra buttons except the wireless one!
>
> root@x1:~# acpi_listen -t 100
> ibm/hotkey LEN0068:00 00000080 00001105
> ibm/hotkey LEN0068:00 00000080 00001106
> ibm/hotkey LEN0068:00 00000080 00001108
> ibm/hotkey LEN0068:00 00000080 0000110a
> ibm/hotkey LEN0068:00 00000080 00001101
> ibm/hotkey LEN0068:00 00000080 00001101
> ibm/hotkey LEN0068:00 00000080 00001101
> video/switchmode VMOD 00000080 00000000
> ibm/hotkey LEN0068:00 00000080 0000110e
>
> So, since nothing fires on both channels, it seems I can't manually
> bind the button to rfkill either.
>
> [3]
>
> [4] $cat /proc/version
>
> Linux version 3.18.0-031800rc3-generic (apw@tangerine) (gcc version
> 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201411022335 SMP Sun Nov 2
> 23:36:52 UTC 2014
>
> [5]
>
> [6]
>
> [7] $lsb_release -rd
>
> Description: Ubuntu 14.10
> Release: 14.10
>
> [7.1] $/usr/src/linux-headers-3.18.0-031800rc3/scripts/ver_linux
>
> If some fields are empty or look unusual you may have an old version.
> Compare to the current minimal requirements in Documentation/Changes.
>
> Linux x1 3.18.0-031800rc3-generic #201411022335 SMP Sun Nov 2 23:36:52
> UTC 2014 x86_64 x86_64 x86_64 GNU/Linux
>
> Gnu C                  4.9.1
> Gnu make               4.0
> binutils               2.24.90.20141014
> util-linux             2.25.1
> mount                  debug
> module-init-tools      18
> e2fsprogs              1.42.10
> pcmciautils            018
> PPP                    2.4.5
> Linux C Library        2.19
> Dynamic linker (ldd)   2.19
> Procps                 3.3.9
> Net-tools              1.60
> Kbd                    1.15.5
> Sh-utils               8.23
> wireless-tools         30
> Modules Loaded         ctr ccm acpi_call uvcvideo videobuf2_vmalloc
> videobuf2_memops videobuf2_core v4l2_common videodev media
> hid_multitouch btusb arc4 iwlmvm mac80211 intel_rapl
> x86_pkg_temp_thermal intel_powerclamp coretemp iwlwifi kvm rfcomm
> joydev bnep serio_raw bluetooth cfg80211 snd_hda_codec_hdmi mei_me
> lpc_ich snd_hda_codec_realtek snd_hda_codec_generic mei shpchp
> thinkpad_acpi snd_hda_intel snd_hda_controller i2c_designware_platform
> i2c_designware_core nvram snd_hda_codec snd_hwdep snd_pcm mac_hid
> snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq snd_seq_device
> snd_timer parport_pc snd ppdev soundcore nls_iso8859_1 lp parport
> dm_crypt usbhid hid crct10dif_pclmul crc32_pclmul ghash_clmulni_intel
> i915 aesni_intel aes_x86_64 lrw gf128mul e1000e glue_helper
> i2c_algo_bit ablk_helper ahci cryptd libahci ptp pps_core psmouse
> drm_kms_helper drm wmi video
>
> [7.2] $cat /proc/cpuinfo
>
> processor : 0
> vendor_id : GenuineIntel
> cpu family : 6
> model : 69
> model name : Intel(R) Core(TM) i5-4200U CPU @ 1.60GHz
> stepping : 1
> microcode : 0x1c
> cpu MHz : 1299.949
> cache size : 3072 KB
> physical id : 0
> siblings : 4
> core id : 0
> cpu cores : 2
> apicid : 0
> initial apicid : 0
> fpu : yes
> fpu_exception : yes
> cpuid level : 13
> wp : yes
> flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
> pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
> xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor
> ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 movbe
> popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm ida
> arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase
> tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt
> bugs :
> bogomips : 4589.44
> clflush size : 64
> cache_alignment : 64
> address sizes : 39 bits physical, 48 bits virtual
> power management:
>
> processor : 1
> vendor_id : GenuineIntel
> cpu family : 6
> model : 69
> model name : Intel(R) Core(TM) i5-4200U CPU @ 1.60GHz
> stepping : 1
> microcode : 0x1c
> cpu MHz : 974.625
> cache size : 3072 KB
> physical id : 0
> siblings : 4
> core id : 0
> cpu cores : 2
> apicid : 1
> initial apicid : 1
> fpu : yes
> fpu_exception : yes
> cpuid level : 13
> wp : yes
> flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
> pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
> xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor
> ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 movbe
> popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm ida
> arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase
> tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt
> bugs :
> bogomips : 4589.44
> clflush size : 64
> cache_alignment : 64
> address sizes : 39 bits physical, 48 bits virtual
> power management:
>
> processor : 2
> vendor_id : GenuineIntel
> cpu family : 6
> model : 69
> model name : Intel(R) Core(TM) i5-4200U CPU @ 1.60GHz
> stepping : 1
> microcode : 0x1c
> cpu MHz : 1299.769
> cache size : 3072 KB
> physical id : 0
> siblings : 4
> core id : 1
> cpu cores : 2
> apicid : 2
> initial apicid : 2
> fpu : yes
> fpu_exception : yes
> cpuid level : 13
> wp : yes
> flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
> pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
> xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor
> ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 movbe
> popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm ida
> arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase
> tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt
> bugs :
> bogomips : 4589.44
> clflush size : 64
> cache_alignment : 64
> address sizes : 39 bits physical, 48 bits virtual
> power management:
>
> processor : 3
> vendor_id : GenuineIntel
> cpu family : 6
> model : 69
> model name : Intel(R) Core(TM) i5-4200U CPU @ 1.60GHz
> stepping : 1
> microcode : 0x1c
> cpu MHz : 1359.425
> cache size : 3072 KB
> physical id : 0
> siblings : 4
> core id : 1
> cpu cores : 2
> apicid : 3
> initial apicid : 3
> fpu : yes
> fpu_exception : yes
> cpuid level : 13
> wp : yes
> flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
> pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
> xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor
> ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 movbe
> popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm ida
> arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase
> tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt
> bugs :
> bogomips : 4589.44
> clflush size : 64
> cache_alignment : 64
> address sizes : 39 bits physical, 48 bits virtual
> power management:
>
> [7.3] $cat /proc/modules
>
> ctr 13193 3 - Live 0xffffffffc08b0000
> ccm 17856 3 - Live 0xffffffffc08aa000
> acpi_call 12714 0 - Live 0xffffffffc08a5000 (OE)
> uvcvideo 86723 0 - Live 0xffffffffc0a4c000
> videobuf2_vmalloc 13216 1 uvcvideo, Live 0xffffffffc0885000
> videobuf2_memops 13362 1 videobuf2_vmalloc, Live 0xffffffffc088a000
> videobuf2_core 51547 1 uvcvideo, Live 0xffffffffc0897000
> v4l2_common 15715 1 videobuf2_core, Live 0xffffffffc086a000
> videodev 163831 3 uvcvideo,videobuf2_core,v4l2_common, Live 0xffffffffc09e5000
> media 22008 2 uvcvideo,videodev, Live 0xffffffffc087e000
> hid_multitouch 17657 0 - Live 0xffffffffc0891000
> btusb 32691 0 - Live 0xffffffffc0875000
> arc4 12573 2 - Live 0xffffffffc07d3000
> iwlmvm 254598 0 - Live 0xffffffffc09a5000
> mac80211 697143 1 iwlmvm, Live 0xffffffffc0a84000
> intel_rapl 19196 0 - Live 0xffffffffc086f000
> x86_pkg_temp_thermal 14312 0 - Live 0xffffffffc07db000
> intel_powerclamp 19099 0 - Live 0xffffffffc0864000
> coretemp 13638 0 - Live 0xffffffffc0746000
> iwlwifi 193774 1 iwlmvm, Live 0xffffffffc0a1b000
> kvm 475233 0 - Live 0xffffffffc092f000
> rfcomm 75066 0 - Live 0xffffffffc07bf000
> joydev 17587 0 - Live 0xffffffffc07a9000
> bnep 23980 2 - Live 0xffffffffc074b000
> serio_raw 13483 0 - Live 0xffffffffc0729000
> bluetooth 486890 11 btusb,rfcomm,bnep, Live 0xffffffffc08b7000
> cfg80211 520257 3 iwlmvm,mac80211,iwlwifi, Live 0xffffffffc07e3000
> snd_hda_codec_hdmi 52670 1 - Live 0xffffffffc07b1000
> mei_me 19565 0 - Live 0xffffffffc0776000
> lpc_ich 21176 0 - Live 0xffffffffc06d8000
> snd_hda_codec_realtek 76099 1 - Live 0xffffffffc0791000
> snd_hda_codec_generic 69995 1 snd_hda_codec_realtek, Live 0xffffffffc077e000
> mei 88473 1 mei_me, Live 0xffffffffc075f000
> shpchp 37216 0 - Live 0xffffffffc0754000
> thinkpad_acpi 82101 1 - Live 0xffffffffc0730000
> snd_hda_intel 30783 5 - Live 0xffffffffc0720000
> snd_hda_controller 32234 1 snd_hda_intel, Live 0xffffffffc070f000
> i2c_designware_platform 13025 0 - Live 0xffffffffc070a000
> i2c_designware_core 14990 1 i2c_designware_platform, Live 0xffffffffc071b000
> nvram 14462 1 thinkpad_acpi, Live 0xffffffffc06d3000
> snd_hda_codec 144641 5
> snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_controller,
> Live 0xffffffffc06e5000
> snd_hwdep 17709 1 snd_hda_codec, Live 0xffffffffc06df000
> snd_pcm 106273 4
> snd_hda_codec_hdmi,snd_hda_intel,snd_hda_controller,snd_hda_codec,
> Live 0xffffffffc06b8000
> mac_hid 13275 0 - Live 0xffffffffc05b5000
> snd_seq_midi 13564 0 - Live 0xffffffffc05b0000
> snd_seq_midi_event 14899 1 snd_seq_midi, Live 0xffffffffc059f000
> snd_rawmidi 31197 1 snd_seq_midi, Live 0xffffffffc05a7000
> snd_seq 63540 2 snd_seq_midi,snd_seq_midi_event, Live 0xffffffffc058e000
> snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0xffffffffc048d000
> snd_timer 30118 2 snd_pcm,snd_seq, Live 0xffffffffc057a000
> parport_pc 32909 0 - Live 0xffffffffc0584000
> snd 84025 22 snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,thinkpad_acpi,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_seq_device,snd_timer,
> Live 0xffffffffc0564000
> ppdev 17711 0 - Live 0xffffffffc055e000
> soundcore 15091 2 snd_hda_codec,snd, Live 0xffffffffc0528000
> nls_iso8859_1 12713 1 - Live 0xffffffffc04e8000
> lp 17799 0 - Live 0xffffffffc0522000
> parport 42481 3 parport_pc,ppdev,lp, Live 0xffffffffc054e000
> dm_crypt 23456 1 - Live 0xffffffffc0486000
> usbhid 53155 0 - Live 0xffffffffc04da000
> hid 110572 2 hid_multitouch,usbhid, Live 0xffffffffc0532000
> crct10dif_pclmul 14268 0 - Live 0xffffffffc051d000
> crc32_pclmul 13180 0 - Live 0xffffffffc052d000
> ghash_clmulni_intel 13230 0 - Live 0xffffffffc0433000
> i915 1031913 6 - Live 0xffffffffc05bb000
> aesni_intel 169686 8 - Live 0xffffffffc04ef000
> aes_x86_64 17131 1 aesni_intel, Live 0xffffffffc0497000
> lrw 13323 1 aesni_intel, Live 0xffffffffc042e000
> gf128mul 14951 1 lrw, Live 0xffffffffc0481000
> e1000e 230020 0 - Live 0xffffffffc04a0000
> glue_helper 14095 1 aesni_intel, Live 0xffffffffc03cf000
> i2c_algo_bit 13564 1 i915, Live 0xffffffffc0492000
> ablk_helper 13597 1 aesni_intel, Live 0xffffffffc03b6000
> ahci 34220 3 - Live 0xffffffffc0439000
> cryptd 20531 4 ghash_clmulni_intel,aesni_intel,ablk_helper, Live
> 0xffffffffc03c8000
> libahci 32446 1 ahci, Live 0xffffffffc0425000
> ptp 19534 1 e1000e, Live 0xffffffffc03c2000
> pps_core 19381 1 ptp, Live 0xffffffffc0443000
> psmouse 118117 0 - Live 0xffffffffc0463000
> drm_kms_helper 99802 1 i915, Live 0xffffffffc0449000
> drm 323675 5 i915,drm_kms_helper, Live 0xffffffffc03d4000
> wmi 19379 0 - Live 0xffffffffc03bc000
> video 20649 1 i915, Live 0xffffffffc03af000
>
> [7.4] $cat /proc/ioports
>
>   0000-0cf7 : PCI Bus 0000:00
>   0000-001f : dma1
>   0020-0021 : pic1
>   0040-0043 : timer0
>   0050-0053 : timer1
>   0060-0060 : keyboard
>   0061-0061 : PNP0800:00
>   0062-0062 : PNP0C09:00
>     0062-0062 : EC data
>   0064-0064 : keyboard
>   0066-0066 : PNP0C09:00
>     0066-0066 : EC cmd
>   0070-0071 : rtc0
>   0080-008f : dma page reg
>   00a0-00a1 : pic2
>   00c0-00df : dma2
>   00f0-00ff : fpu
>     00f0-00f0 : PNP0C04:00
>   0800-087f : pnp 00:01
>   0880-08ff : pnp 00:01
>   0900-097f : pnp 00:01
>   0980-09ff : pnp 00:01
>   0a00-0a7f : pnp 00:01
>   0a80-0aff : pnp 00:01
>   0b00-0b7f : pnp 00:01
>   0b80-0bff : pnp 00:01
> 0cf8-0cff : PCI conf1
> 0d00-ffff : PCI Bus 0000:00
>   15e0-15ef : pnp 00:01
>   1600-167f : pnp 00:01
>     1640-165f : pnp 00:01
>   1800-1803 : ACPI PM1a_EVT_BLK
>   1804-1805 : ACPI PM1a_CNT_BLK
>   1808-180b : ACPI PM_TMR
>   1810-1815 : ACPI CPU throttle
>   1830-1833 : iTCO_wdt
>   1850-1850 : ACPI PM2_CNT_BLK
>   1860-187f : iTCO_wdt
>   1880-189f : ACPI GPE0_BLK
>   2000-2fff : PCI Bus 0000:02
>   3000-303f : 0000:00:02.0
>   3060-307f : 0000:00:1f.2
>     3060-307f : ahci
>   3080-309f : 0000:00:19.0
>   30a0-30a7 : 0000:00:1f.2
>     30a0-30a7 : ahci
>   30a8-30af : 0000:00:1f.2
>     30a8-30af : ahci
>   30b0-30b3 : 0000:00:1f.2
>     30b0-30b3 : ahci
>   30b4-30b7 : 0000:00:1f.2
>     30b4-30b7 : ahci
>   efa0-efbf : 0000:00:1f.3
>
> $cat /proc/iomem
>
> 00000000-00000fff : reserved
> 00001000-00057fff : System RAM
> 00058000-00058fff : reserved
> 00059000-0009bfff : System RAM
> 0009c000-0009cfff : reserved
> 0009d000-0009dfff : System RAM
> 0009e000-000bffff : reserved
>   000a0000-000bffff : PCI Bus 0000:00
> 000c0000-000c3fff : PCI Bus 0000:00
> 000c4000-000c7fff : PCI Bus 0000:00
> 000c8000-000cbfff : PCI Bus 0000:00
> 000cc000-000cffff : PCI Bus 0000:00
> 000d0000-000d3fff : PCI Bus 0000:00
> 000d4000-000d7fff : PCI Bus 0000:00
> 000d8000-000dbfff : PCI Bus 0000:00
> 000dc000-000dffff : PCI Bus 0000:00
> 000e0000-000e3fff : PCI Bus 0000:00
> 000e4000-000e7fff : PCI Bus 0000:00
> 000e8000-000ebfff : PCI Bus 0000:00
> 000ec000-000effff : PCI Bus 0000:00
> 000f0000-000fffff : System ROM
> 00100000-b1851fff : System RAM
>   02000000-027ae357 : Kernel code
>   027ae358-02d1997f : Kernel data
>   02e80000-02fc8fff : Kernel bss
> b1852000-b1a53fff : reserved
> b1a54000-bbf6cfff : System RAM
> bbf6d000-bc16cfff : reserved
> bc16d000-bcd3efff : reserved
> bcd3f000-bce7efff : ACPI Non-volatile Storage
> bce7f000-bcefefff : ACPI Tables
> bceff000-bcefffff : System RAM
> bcf00000-febfffff : reserved
>   bda00000-bf9fffff : Graphics Stolen Memory
>   bfa00000-febfffff : PCI Bus 0000:00
>     bfb00000-bfcfffff : PCI Bus 0000:02
>     bfd00000-bfefffff : PCI Bus 0000:02
>     c0000000-dfffffff : 0000:00:02.0
>     e0000000-e03fffff : 0000:00:02.0
>     e0400000-e04fffff : PCI Bus 0000:03
>       e0400000-e0401fff : 0000:03:00.0
>         e0400000-e0401fff : iwlwifi
>     e0500000-e051ffff : 0000:00:19.0
>       e0500000-e051ffff : e1000e
>     e0520000-e052ffff : 0000:00:14.0
>       e0520000-e052ffff : xhci-hcd
>     e0530000-e0533fff : 0000:00:03.0
>       e0530000-e0533fff : ICH HD audio
>     e0534000-e0537fff : 0000:00:1b.0
>       e0534000-e0537fff : ICH HD audio
>     e0538000-e05380ff : 0000:00:1f.3
>     e0539000-e053901f : 0000:00:16.0
>       e0539000-e053901f : mei_me
>     e053c000-e053c7ff : 0000:00:1f.2
>       e053c000-e053c7ff : ahci
>     e053d000-e053d3ff : 0000:00:1d.0
>       e053d000-e053d3ff : ehci_hcd
>     e053e000-e053efff : 0000:00:19.0
>       e053e000-e053efff : e1000e
>     f8000000-fbffffff : PCI MMCONFIG 0000 [bus 00-3f]
>       f80f8000-f80f8fff : reserved
>     fe101000-fe112fff : reserved
>       fe105000-fe105fff : INT33C3:00
>         fe105000-fe105fff : INT33C3:00
> fec00000-fec003ff : IOAPIC 0
> fed00000-fed003ff : HPET 0
>   fed00000-fed003ff : PNP0103:00
> fed10000-fed13fff : pnp 00:01
> fed18000-fed18fff : pnp 00:01
> fed19000-fed19fff : pnp 00:01
> fed1c000-fed1ffff : reserved
>   fed1c000-fed1ffff : pnp 00:01
>     fed1f410-fed1f414 : iTCO_wdt
> fed40000-fed4bfff : PCI Bus 0000:00
>   fed45000-fed4bfff : pnp 00:01
> fed4c000-ffffffff : pnp 00:00
>   fee00000-fee00fff : Local APIC
> 100000000-23f5fffff : System RAM
> 23f600000-23fffffff : RAM buffer
>
> [7.5] $lspci -vvv
>
> 00:00.0 Host bridge: Intel Corporation Haswell-ULT DRAM Controller (rev 09)
> Subsystem: Lenovo Device 2218
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort+ >SERR- <PERR- INTx-
> Latency: 0
> Capabilities: [e0] Vendor Specific Information: Len=0c <?>
>
> 00:02.0 VGA compatible controller: Intel Corporation Haswell-ULT
> Integrated Graphics Controller (rev 09) (prog-if 00 [VGA controller])
> Subsystem: Lenovo Device 2218
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> Interrupt: pin A routed to IRQ 43
> Region 0: Memory at e0000000 (64-bit, non-prefetchable) [size=4M]
> Region 2: Memory at c0000000 (64-bit, prefetchable) [size=512M]
> Region 4: I/O ports at 3000 [size=64]
> Expansion ROM at <unassigned> [disabled]
> Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
> Address: fee0f00c  Data: 4122
> Capabilities: [d0] Power Management version 2
> Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [a4] PCI Advanced Features
> AFCap: TP+ FLR+
> AFCtrl: FLR-
> AFStatus: TP-
> Kernel driver in use: i915
>
> 00:03.0 Audio device: Intel Corporation Haswell-ULT HD Audio Controller (rev 09)
> Subsystem: Lenovo Device 2218
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Interrupt: pin A routed to IRQ 45
> Region 0: Memory at e0530000 (64-bit, non-prefetchable) [size=16K]
> Capabilities: [50] Power Management version 2
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> Status: D3 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit-
> Address: fee0f00c  Data: 4172
> Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
> DevCap: MaxPayload 128 bytes, PhantFunc 0
> ExtTag- RBE-
> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> MaxPayload 128 bytes, MaxReadReq 128 bytes
> DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
> Kernel driver in use: snd_hda_intel
>
> 00:14.0 USB controller: Intel Corporation 8 Series USB xHCI HC (rev
> 04) (prog-if 30 [XHCI])
> Subsystem: Lenovo Device 2218
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> Interrupt: pin A routed to IRQ 40
> Region 0: Memory at e0520000 (64-bit, non-prefetchable) [size=64K]
> Capabilities: [70] Power Management version 2
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
> Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
> Address: 00000000fee0f00c  Data: 4191
> Kernel driver in use: xhci_hcd
>
> 00:16.0 Communication controller: Intel Corporation 8 Series HECI #0 (rev 04)
> Subsystem: Lenovo Device 2218
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> Interrupt: pin A routed to IRQ 46
> Region 0: Memory at e0539000 (64-bit, non-prefetchable) [size=32]
> Capabilities: [50] Power Management version 3
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
> Address: 00000000fee0f00c  Data: 4182
> Kernel driver in use: mei_me
>
> 00:19.0 Ethernet controller: Intel Corporation Ethernet Connection
> I218-V (rev 04)
> Subsystem: Lenovo Device 2214
> Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Interrupt: pin A routed to IRQ 42
> Region 0: Memory at e0500000 (32-bit, non-prefetchable) [disabled] [size=128K]
> Region 1: Memory at e053e000 (32-bit, non-prefetchable) [disabled] [size=4K]
> Region 2: I/O ports at 3080 [disabled] [size=32]
> Capabilities: [c8] Power Management version 2
> Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=1 PME-
> Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
> Address: 00000000fee0f00c  Data: 41b2
> Capabilities: [e0] PCI Advanced Features
> AFCap: TP+ FLR+
> AFCtrl: FLR-
> AFStatus: TP-
> Kernel driver in use: e1000e
>
> 00:1b.0 Audio device: Intel Corporation 8 Series HD Audio Controller (rev 04)
> Subsystem: Lenovo Device 2218
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Interrupt: pin A routed to IRQ 44
> Region 0: Memory at e0534000 (64-bit, non-prefetchable) [size=16K]
> Capabilities: [50] Power Management version 3
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> Status: D3 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
> Address: 00000000fee0f00c  Data: 4162
> Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
> DevCap: MaxPayload 128 bytes, PhantFunc 0
> ExtTag- RBE-
> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> MaxPayload 128 bytes, MaxReadReq 128 bytes
> DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
> Capabilities: [100 v1] Virtual Channel
> Caps: LPEVC=0 RefClk=100ns PATEntryBits=1
> Arb: Fixed- WRR32- WRR64- WRR128-
> Ctrl: ArbSelect=Fixed
> Status: InProgress-
> VC0: Caps: PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
> Arb: Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
> Ctrl: Enable+ ID=0 ArbSelect=Fixed TC/VC=01
> Status: NegoPending- InProgress-
> VC1: Caps: PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
> Arb: Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
> Ctrl: Enable- ID=2 ArbSelect=Fixed TC/VC=04
> Status: NegoPending- InProgress-
> Kernel driver in use: snd_hda_intel
>
> 00:1c.0 PCI bridge: Intel Corporation 8 Series PCI Express Root Port 6
> (rev e4) (prog-if 00 [Normal decode])
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
> I/O behind bridge: 00002000-00002fff
> Memory behind bridge: bfb00000-bfcfffff
> Prefetchable memory behind bridge: 00000000bfd00000-00000000bfefffff
> Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort+ <SERR- <PERR-
> BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
> DevCap: MaxPayload 128 bytes, PhantFunc 0
> ExtTag- RBE+
> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> MaxPayload 128 bytes, MaxReadReq 128 bytes
> DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
> LnkCap: Port #6, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s
> <1us, L1 <4us
> ClockPM- Surprise- LLActRep+ BwNot+
> LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk-
> ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> LnkSta: Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive-
> BWMgmt- ABWMgmt-
> SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
> Slot #0, PowerLimit 0.000W; Interlock- NoCompl+
> SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
> Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
> SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
> Changed: MRL- PresDet- LinkState-
> RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
> RootCap: CRSVisible-
> RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Via
> WAKE# ARIFwd-
> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF
> Disabled ARIFwd-
> LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
> Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
> Compliance De-emphasis: -6dB
> LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
> EqualizationPhase1-
> EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
> Address: 00000000  Data: 0000
> Capabilities: [90] Subsystem: Lenovo Device 2218
> Capabilities: [a0] Power Management version 3
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> Kernel driver in use: pcieport
>
> 00:1c.1 PCI bridge: Intel Corporation 8 Series PCI Express Root Port 3
> (rev e4) (prog-if 00 [Normal decode])
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
> I/O behind bridge: 0000f000-00000fff
> Memory behind bridge: e0400000-e04fffff
> Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
> Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- <SERR- <PERR-
> BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
> DevCap: MaxPayload 128 bytes, PhantFunc 0
> ExtTag- RBE+
> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> MaxPayload 128 bytes, MaxReadReq 128 bytes
> DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
> LnkCap: Port #3, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s
> <512ns, L1 <16us
> ClockPM- Surprise- LLActRep+ BwNot+
> LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
> ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+
> BWMgmt+ ABWMgmt-
> SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
> Slot #2, PowerLimit 10.000W; Interlock- NoCompl+
> SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
> Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
> SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
> Changed: MRL- PresDet- LinkState+
> RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
> RootCap: CRSVisible-
> RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Not
> Supported ARIFwd-
> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF
> Disabled ARIFwd-
> LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
> Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
> Compliance De-emphasis: -6dB
> LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
> EqualizationPhase1-
> EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
> Address: 00000000  Data: 0000
> Capabilities: [90] Subsystem: Lenovo Device 2218
> Capabilities: [a0] Power Management version 3
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [100 v0] #00
> Capabilities: [200 v1] L1 PM Substates
> L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
>  PortCommonModeRestoreTime=40us PortTPowerOnTime=10us
> Kernel driver in use: pcieport
>
> 00:1d.0 USB controller: Intel Corporation 8 Series USB EHCI #1 (rev
> 04) (prog-if 20 [EHCI])
> Subsystem: Lenovo Device 2218
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> Interrupt: pin A routed to IRQ 23
> Region 0: Memory at e053d000 (32-bit, non-prefetchable) [size=1K]
> Capabilities: [50] Power Management version 3
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [58] Debug port: BAR=1 offset=00a0
> Capabilities: [98] PCI Advanced Features
> AFCap: TP+ FLR+
> AFCtrl: FLR-
> AFStatus: TP-
> Kernel driver in use: ehci-pci
>
> 00:1f.0 ISA bridge: Intel Corporation 8 Series LPC Controller (rev 04)
> Subsystem: Lenovo Device 2218
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> Capabilities: [e0] Vendor Specific Information: Len=0c <?>
> Kernel driver in use: lpc_ich
>
> 00:1f.2 SATA controller: Intel Corporation 8 Series SATA Controller 1
> [AHCI mode] (rev 04) (prog-if 01 [AHCI 1.0])
> Subsystem: Lenovo Device 2218
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> Interrupt: pin B routed to IRQ 41
> Region 0: I/O ports at 30a8 [size=8]
> Region 1: I/O ports at 30b4 [size=4]
> Region 2: I/O ports at 30a0 [size=8]
> Region 3: I/O ports at 30b0 [size=4]
> Region 4: I/O ports at 3060 [size=32]
> Region 5: Memory at e053c000 (32-bit, non-prefetchable) [size=2K]
> Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
> Address: fee0c00c  Data: 41c1
> Capabilities: [70] Power Management version 3
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
> Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
> Kernel driver in use: ahci
>
> 00:1f.3 SMBus: Intel Corporation 8 Series SMBus Controller (rev 04)
> Subsystem: Lenovo Device 2218
> Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Interrupt: pin C routed to IRQ 255
> Region 0: Memory at e0538000 (64-bit, non-prefetchable) [size=256]
> Region 4: I/O ports at efa0 [size=32]
>
> 03:00.0 Network controller: Intel Corporation Wireless 7260 (rev 83)
> Subsystem: Intel Corporation Dual Band Wireless-N 7260
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Interrupt: pin A routed to IRQ 47
> Region 0: Memory at e0400000 (64-bit, non-prefetchable) [size=8K]
> Capabilities: [c8] Power Management version 3
> Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
> Address: 00000000fee0100c  Data: 4192
> Capabilities: [40] Express (v2) Endpoint, MSI 00
> DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 unlimited
> ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+ FLReset-
> MaxPayload 128 bytes, MaxReadReq 128 bytes
> DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
> LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency
> L0s <4us, L1 <32us
> ClockPM+ Surprise- LLActRep- BwNot-
> LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
> ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
> LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
> BWMgmt- ABWMgmt-
> DevCap2: Completion Timeout: Range B, TimeoutDis+, LTR+, OBFF Via WAKE#
> DevCtl2: Completion Timeout: 16ms to 55ms, TimeoutDis-, LTR+, OBFF Disabled
> LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
> Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
> Compliance De-emphasis: -6dB
> LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
> EqualizationPhase1-
> EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> Capabilities: [100 v1] Advanced Error Reporting
> UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
> UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
> UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
> MalfTLP+ ECRC- UnsupReq- ACSViol-
> CESta: RxErr- BadTLP+ BadDLLP- Rollover- Timeout- NonFatalErr+
> CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
> AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
> Capabilities: [140 v1] Device Serial Number e8-b1-fc-ff-ff-16-c7-59
> Capabilities: [14c v1] Latency Tolerance Reporting
> Max snoop latency: 3145728ns
> Max no snoop latency: 3145728ns
> Capabilities: [154 v1] Vendor Specific Information: ID=cafe Rev=1 Len=014 <?>
> Kernel driver in use: iwlwifi
>
> [7.6] $cat /proc/scsi/scsi
>
> Attached devices:
> Host: scsi0 Channel: 00 Id: 00 Lun: 00
>   Vendor: ATA      Model: LITEONIT LGT-128 Rev: 201
>   Type:   Direct-Access                    ANSI  SCSI revision: 05
>
> [7.7] $ls /proc
>
> 1     1672  264   282   3039  3423  4096  669        cmdline      modules
> 10    1676  265   2825  3049  3442  41    67         consoles     mounts
> 1020  169   266   2827  3074  3456  4134  68         cpuinfo      mtrr
> 1065  17    267   2830  3089  3457  4135  69         crypto       net
> 1079  1708  2670  2836  3093  3462  42    695        devices      pagetypeinfo
> 11    1793  2672  2843  3099  3468  422   7          diskstats    partitions
> 137   1795  2731  2863  31    3484  4225  701        dma          sched_debug
> 14    18    2741  2864  3103  3499  43    704        driver       schedstat
> 1404  1847  2742  2866  3147  35    4343  715        execdomains  scsi
> 1409  19    2755  2867  3173  3544  4347  716        fb           self
> 1410  1926  2762  2871  3181  3591  438   742        filesystems  slabinfo
> 1416  1931  2763  2873  3182  3599  44    749        fs           softirqs
> 1417  2     2764  2874  3184  36    45    751        interrupts   stat
> 1422  2051  2767  2875  3185  3665  46    752        iomem        swaps
> 1430  21    2769  2889  3189  37    460   756        ioports      sys
> 1458  2170  2775  29    3190  3716  47    8          irq          sysrq-trigger
> 1462  2173  2779  2924  3192  38    479   88         kallsyms     sysvipc
> 15    22    278   2928  32    3830  48    886        kcore        thread-self
> 155   2323  2781  2954  3231  3834  492   89         keys         timer_list
> 158   2362  2789  2971  3242  3835  5     9          key-users    timer_stats
> 159   24    279   2974  3258  3885  50    939        kmsg         tty
> 160   25    28    2989  3285  3886  503   970        kpagecount   uptime
> 1601  2567  2806  2990  3296  39    53    999        kpageflags   version
> 161   2571  281   2992  33    390   54    acpi       loadavg      vmallocinfo
> 1620  2572  2810  2993  3323  3902  55    asound     locks        vmstat
> 163   2573  2813  3     3355  391   597   buddyinfo  mdstat       zoneinfo
> 164   26    2817  302   34    4     643   bus        meminfo
> 1656  263   2819  303   3415  40    650   cgroups    misc
>
> [X.] Launchpad report
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1389268
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
