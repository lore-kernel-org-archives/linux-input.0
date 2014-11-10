From: Mathias Gottschlag <mgottschlag@gmail.com>
Subject: Re: PROBLEM: Asus X751LA Touchpad not recognised
Date: Mon, 10 Nov 2014 23:38:27 +0100
Message-ID: <54613E63.2050703@gmail.com>
References: <CA+SCOPd=jQ5VU3gAKKVGWe_ggtyFpG5=gQ0yZF9WAdXZMYkPdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:56688 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299AbaKJWid (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Nov 2014 17:38:33 -0500
Received: by mail-qa0-f42.google.com with SMTP id k15so6122952qaq.29
        for <linux-input@vger.kernel.org>; Mon, 10 Nov 2014 14:38:32 -0800 (PST)
In-Reply-To: <CA+SCOPd=jQ5VU3gAKKVGWe_ggtyFpG5=gQ0yZF9WAdXZMYkPdw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Luca Manunta <manunta@gmail.com>, linux-input@vger.kernel.org


This is very likely the same as:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1372609
https://bugzilla.redhat.com/show_bug.cgi?id=1110011

Maybe you can try the following kernel?
https://github.com/mgottschlag/linux/tree/focaltech2

I didn't have much time the last days and there is one report of suspend
failure in the second bug report above which I'd like to fix, although I
have no idea how.

Regards,
Mathias

Am 10.11.2014 um 23:13 schrieb Luca Manunta:
> [1.] One line summary of the problem:
> [Asus X751LA] Touchpad not recognised
>
> [2.] Full description of the problem/report:
> The touchpad is currently working as a PS/2 mouse, however this
> prevents from using synaptics/syndaemon to suspend touching while
> typing, and double finger scrolling. The only solution is to toggle
> the PS/2 mouse off and use an external mouse.
>
> [3.] Keywords: n/a
>
> [4.] Kernel version (from /proc/version):
> $ cat /proc/version
> Linux version 3.18.0-031800rc4-generic (apw@gomeisa) (gcc version
> 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201411091835 SMP Sun Nov 9
> 23:36:36 UTC 2014
>
> [5.] Output of Oops.. message: n/a
>
> [6.] A small shell script or example program which triggers the
> problem (if possible): n/a
>
> [7.] Environment
> $ lsb_release -rd
> Description:    Ubuntu 14.04.1 LTS
> Release:    14.04
>
> [7.1.] Software
> $ sh ver_linux
> If some fields are empty or look unusual you may have an old version.
> Compare to the current minimal requirements in Documentation/Changes.
>
> Linux bojanasus 3.18.0-031800rc4-generic #201411091835 SMP Sun Nov 9
> 23:36:36 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux
>
> Gnu C                  4.8
> Gnu make               3.81
> binutils               2.24
> util-linux             2.20.1
> mount                  support
> module-init-tools      15
> e2fsprogs              1.42.9
> pcmciautils            018
> Linux C Library        2.19
> Dynamic linker (ldd)   2.19
> Procps                 3.3.9
> Net-tools              1.60
> Kbd                    1.15.5
> Sh-utils               8.21
> wireless-tools         30
> Modules Loaded         ctr ccm bnep rfcomm binfmt_misc nls_iso8859_1
> intel_rapl x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel
> kvm crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel
> aes_x86_64 lrw gf128mul arc4 glue_helper uvcvideo ablk_helper ath9k
> videobuf2_vmalloc cryptd videobuf2_memops ath9k_common ath9k_hw
> videobuf2_core ath v4l2_common videodev mac80211 cfg80211 asus_nb_wmi
> snd_hda_codec_hdmi asus_wmi media joydev sparse_keymap serio_raw
> pcspkr snd_hda_codec_realtek snd_hda_codec_generic i915 parport_pc
> ppdev snd_hda_intel drm_kms_helper snd_soc_rt5640 lpc_ich btusb
> snd_hda_controller snd_soc_rl6231 i2c_hid snd_soc_core snd_hda_codec
> bluetooth snd_hwdep lp snd_seq_midi int3400_thermal dw_dmac
> snd_compress video dw_dmac_core mei_me snd_pcm_dmaengine snd_pcm
> int3402_thermal acpi_thermal_rel drm mei rtsx_pci_ms wmi memstick
> i2c_algo_bit i2c_designware_platform snd_seq_midi_event
> i2c_designware_core snd_rawmidi snd_seq parport spi_pxa2xx_platform
> mac_hid snd_seq_device snd_timer snd soundcore snd_soc_sst_acpi
> 8250_dw hid_generic usbhid hid rtsx_pci_sdmmc r8169 mii psmouse ahci
> libahci rtsx_pci sdhci_acpi sdhci
>
>
> [7.2.] Processor information
> $ cat /proc/cpuinfo
> processor    : 0
> vendor_id    : GenuineIntel
> cpu family    : 6
> model        : 69
> model name    : Intel(R) Core(TM) i7-4500U CPU @ 1.80GHz
> stepping    : 1
> microcode    : 0x15
> cpu MHz        : 1800.000
> cache size    : 4096 KB
> physical id    : 0
> siblings    : 4
> core id        : 0
> cpu cores    : 2
> apicid        : 0
> initial apicid    : 0
> fpu        : yes
> fpu_exception    : yes
> cpuid level    : 13
> wp        : yes
> flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
> syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts
> rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq
> dtes64 monitor ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1
> sse4_2 movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand
> lahf_lm abm ida arat epb pln pts dtherm tpr_shadow vnmi flexpriority
> ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt
> bugs        :
> bogomips    : 4793.19
> clflush size    : 64
> cache_alignment    : 64
> address sizes    : 39 bits physical, 48 bits virtual
> power management:
>
> processor    : 1
> vendor_id    : GenuineIntel
> cpu family    : 6
> model        : 69
> model name    : Intel(R) Core(TM) i7-4500U CPU @ 1.80GHz
> stepping    : 1
> microcode    : 0x15
> cpu MHz        : 1800.000
> cache size    : 4096 KB
> physical id    : 0
> siblings    : 4
> core id        : 1
> cpu cores    : 2
> apicid        : 2
> initial apicid    : 2
> fpu        : yes
> fpu_exception    : yes
> cpuid level    : 13
> wp        : yes
> flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
> syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts
> rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq
> dtes64 monitor ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1
> sse4_2 movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand
> lahf_lm abm ida arat epb pln pts dtherm tpr_shadow vnmi flexpriority
> ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt
> bugs        :
> bogomips    : 4793.19
> clflush size    : 64
> cache_alignment    : 64
> address sizes    : 39 bits physical, 48 bits virtual
> power management:
>
> processor    : 2
> vendor_id    : GenuineIntel
> cpu family    : 6
> model        : 69
> model name    : Intel(R) Core(TM) i7-4500U CPU @ 1.80GHz
> stepping    : 1
> microcode    : 0x15
> cpu MHz        : 1803.750
> cache size    : 4096 KB
> physical id    : 0
> siblings    : 4
> core id        : 0
> cpu cores    : 2
> apicid        : 1
> initial apicid    : 1
> fpu        : yes
> fpu_exception    : yes
> cpuid level    : 13
> wp        : yes
> flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
> syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts
> rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq
> dtes64 monitor ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1
> sse4_2 movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand
> lahf_lm abm ida arat epb pln pts dtherm tpr_shadow vnmi flexpriority
> ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt
> bugs        :
> bogomips    : 4793.19
> clflush size    : 64
> cache_alignment    : 64
> address sizes    : 39 bits physical, 48 bits virtual
> power management:
>
> processor    : 3
> vendor_id    : GenuineIntel
> cpu family    : 6
> model        : 69
> model name    : Intel(R) Core(TM) i7-4500U CPU @ 1.80GHz
> stepping    : 1
> microcode    : 0x15
> cpu MHz        : 1803.000
> cache size    : 4096 KB
> physical id    : 0
> siblings    : 4
> core id        : 1
> cpu cores    : 2
> apicid        : 3
> initial apicid    : 3
> fpu        : yes
> fpu_exception    : yes
> cpuid level    : 13
> wp        : yes
> flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
> syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts
> rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq
> dtes64 monitor ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1
> sse4_2 movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand
> lahf_lm abm ida arat epb pln pts dtherm tpr_shadow vnmi flexpriority
> ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt
> bugs        :
> bogomips    : 4793.19
> clflush size    : 64
> cache_alignment    : 64
> address sizes    : 39 bits physical, 48 bits virtual
> power management:
>
> [7.3.] Module information
> $ cat /proc/modules
> ctr 13193 1 - Live 0x0000000000000000
> ccm 17856 1 - Live 0x0000000000000000
> bnep 23980 2 - Live 0x0000000000000000
> rfcomm 75066 12 - Live 0x0000000000000000
> binfmt_misc 17501 1 - Live 0x0000000000000000
> nls_iso8859_1 12713 1 - Live 0x0000000000000000
> intel_rapl 19196 0 - Live 0x0000000000000000
> x86_pkg_temp_thermal 14312 0 - Live 0x0000000000000000
> intel_powerclamp 19099 0 - Live 0x0000000000000000
> coretemp 13638 0 - Live 0x0000000000000000
> kvm_intel 149984 0 - Live 0x0000000000000000
> kvm 475233 1 kvm_intel, Live 0x0000000000000000
> crct10dif_pclmul 14268 0 - Live 0x0000000000000000
> crc32_pclmul 13180 0 - Live 0x0000000000000000
> ghash_clmulni_intel 13230 0 - Live 0x0000000000000000
> aesni_intel 169686 2 - Live 0x0000000000000000
> aes_x86_64 17131 1 aesni_intel, Live 0x0000000000000000
> lrw 13323 1 aesni_intel, Live 0x0000000000000000
> gf128mul 14951 1 lrw, Live 0x0000000000000000
> arc4 12573 2 - Live 0x0000000000000000
> glue_helper 14095 1 aesni_intel, Live 0x0000000000000000
> uvcvideo 86723 0 - Live 0x0000000000000000
> ablk_helper 13597 1 aesni_intel, Live 0x0000000000000000
> ath9k 162133 0 - Live 0x0000000000000000
> videobuf2_vmalloc 13216 1 uvcvideo, Live 0x0000000000000000
> cryptd 20531 3 ghash_clmulni_intel,aesni_intel,ablk_helper, Live
> 0x0000000000000000
> videobuf2_memops 13362 1 videobuf2_vmalloc, Live 0x0000000000000000
> ath9k_common 25638 1 ath9k, Live 0x0000000000000000
> ath9k_hw 460416 2 ath9k,ath9k_common, Live 0x0000000000000000
> videobuf2_core 51547 1 uvcvideo, Live 0x0000000000000000
> ath 29397 3 ath9k,ath9k_common,ath9k_hw, Live 0x0000000000000000
> v4l2_common 15715 1 videobuf2_core, Live 0x0000000000000000
> videodev 163831 3 uvcvideo,videobuf2_core,v4l2_common, Live 0x0000000000000000
> mac80211 697143 1 ath9k, Live 0x0000000000000000
> cfg80211 520257 4 ath9k,ath9k_common,ath,mac80211, Live 0x0000000000000000
> asus_nb_wmi 21128 0 - Live 0x0000000000000000
> snd_hda_codec_hdmi 52670 1 - Live 0x0000000000000000
> asus_wmi 24697 1 asus_nb_wmi, Live 0x0000000000000000
> media 22008 2 uvcvideo,videodev, Live 0x0000000000000000
> joydev 17587 0 - Live 0x0000000000000000
> sparse_keymap 13890 1 asus_wmi, Live 0x0000000000000000
> serio_raw 13483 0 - Live 0x0000000000000000
> pcspkr 12718 0 - Live 0x0000000000000000
> snd_hda_codec_realtek 80418 1 - Live 0x0000000000000000
> snd_hda_codec_generic 69995 1 snd_hda_codec_realtek, Live 0x0000000000000000
> i915 1031913 9 - Live 0x0000000000000000
> parport_pc 32909 0 - Live 0x0000000000000000
> ppdev 17711 0 - Live 0x0000000000000000
> snd_hda_intel 30783 17 - Live 0x0000000000000000
> drm_kms_helper 99802 1 i915, Live 0x0000000000000000
> snd_soc_rt5640 93325 0 - Live 0x0000000000000000
> lpc_ich 21176 0 - Live 0x0000000000000000
> btusb 32691 0 - Live 0x0000000000000000
> snd_hda_controller 32234 1 snd_hda_intel, Live 0x0000000000000000
> snd_soc_rl6231 13037 1 snd_soc_rt5640, Live 0x0000000000000000
> i2c_hid 19065 0 - Live 0x0000000000000000
> snd_soc_core 207596 1 snd_soc_rt5640, Live 0x0000000000000000
> snd_hda_codec 144641 5
> snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_controller,
> Live 0x0000000000000000
> bluetooth 486890 22 bnep,rfcomm,btusb, Live 0x0000000000000000
> snd_hwdep 17709 1 snd_hda_codec, Live 0x0000000000000000
> lp 17799 0 - Live 0x0000000000000000
> snd_seq_midi 13564 0 - Live 0x0000000000000000
> int3400_thermal 13040 0 - Live 0x0000000000000000
> dw_dmac 12835 0 - Live 0x0000000000000000
> snd_compress 19395 1 snd_soc_core, Live 0x0000000000000000
> video 20649 2 asus_wmi,i915, Live 0x0000000000000000
> dw_dmac_core 28558 1 dw_dmac, Live 0x0000000000000000
> mei_me 19565 0 - Live 0x0000000000000000
> snd_pcm_dmaengine 15229 1 snd_soc_core, Live 0x0000000000000000
> snd_pcm 106273 8
> snd_hda_codec_hdmi,snd_hda_intel,snd_soc_rt5640,snd_hda_controller,snd_soc_core,snd_hda_codec,snd_pcm_dmaengine,
> Live 0x0000000000000000
> int3402_thermal 13060 0 - Live 0x0000000000000000
> acpi_thermal_rel 13807 1 int3400_thermal, Live 0x0000000000000000
> drm 323675 8 i915,drm_kms_helper, Live 0x0000000000000000
> mei 88473 1 mei_me, Live 0x0000000000000000
> rtsx_pci_ms 18337 0 - Live 0x0000000000000000
> wmi 19379 1 asus_wmi, Live 0x0000000000000000
> memstick 16968 1 rtsx_pci_ms, Live 0x0000000000000000
> i2c_algo_bit 13564 1 i915, Live 0x0000000000000000
> i2c_designware_platform 13025 0 - Live 0x0000000000000000
> snd_seq_midi_event 14899 1 snd_seq_midi, Live 0x0000000000000000
> i2c_designware_core 14990 1 i2c_designware_platform, Live 0x0000000000000000
> snd_rawmidi 31197 1 snd_seq_midi, Live 0x0000000000000000
> snd_seq 63540 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
> parport 42481 3 parport_pc,ppdev,lp, Live 0x0000000000000000
> spi_pxa2xx_platform 23256 0 - Live 0x0000000000000000
> mac_hid 13275 0 - Live 0x0000000000000000
> snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x0000000000000000
> snd_timer 30118 2 snd_pcm,snd_seq, Live 0x0000000000000000
> snd 84025 46 snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_soc_core,snd_hda_codec,snd_hwdep,snd_compress,snd_pcm,snd_rawmidi,snd_seq,snd_seq_device,snd_timer,
> Live 0x0000000000000000
> soundcore 15091 2 snd_hda_codec,snd, Live 0x0000000000000000
> snd_soc_sst_acpi 13007 0 - Live 0x0000000000000000
> 8250_dw 13474 0 - Live 0x0000000000000000
> hid_generic 12559 0 - Live 0x0000000000000000
> usbhid 53155 0 - Live 0x0000000000000000
> hid 110572 4 i2c_hid,hid_generic,usbhid, Live 0x0000000000000000
> rtsx_pci_sdmmc 23718 0 - Live 0x0000000000000000
> r8169 86907 0 - Live 0x0000000000000000
> mii 13981 1 r8169, Live 0x0000000000000000
> psmouse 118117 0 - Live 0x0000000000000000
> ahci 34220 3 - Live 0x0000000000000000
> libahci 32446 1 ahci, Live 0x0000000000000000
> rtsx_pci 51162 2 rtsx_pci_ms,rtsx_pci_sdmmc, Live 0x0000000000000000
> sdhci_acpi 13502 0 - Live 0x0000000000000000
> sdhci 43929 1 sdhci_acpi, Live 0x0000000000000000
>
> [7.4.] Loaded driver and hardware information
>  cat /proc/ioports
> 0000-0cf7 : PCI Bus 0000:00
>   0000-001f : dma1
>   0020-0021 : pic1
>   0040-0043 : timer0
>   0050-0053 : timer1
>   0060-0060 : keyboard
>   0062-0062 : PNP0C09:00
>     0062-0062 : EC data
>   0064-0064 : keyboard
>   0066-0066 : PNP0C09:00
>     0066-0066 : EC cmd
>   0070-0077 : rtc0
>   0080-008f : dma page reg
>   00a0-00a1 : pic2
>   00c0-00df : dma2
>   00f0-00ff : fpu
>   0240-0259 : pnp 00:05
>   04d0-04d1 : pnp 00:04
>   0680-069f : pnp 00:01
> 0cf8-0cff : PCI conf1
> 0d00-ffff : PCI Bus 0000:00
>   164e-164f : pnp 00:01
>   1800-1803 : ACPI PM1a_EVT_BLK
>   1804-1805 : ACPI PM1a_CNT_BLK
>   1808-180b : ACPI PM_TMR
>   1810-1815 : ACPI CPU throttle
>   1830-1833 : iTCO_wdt
>   1850-1850 : ACPI PM2_CNT_BLK
>   1854-1857 : pnp 00:03
>   1860-187f : iTCO_wdt
>   1880-189f : ACPI GPE0_BLK
>   1c00-1cfe : pnp 00:01
>   1d00-1dfe : pnp 00:01
>   1e00-1efe : pnp 00:01
>   1f00-1ffe : pnp 00:01
>   e000-efff : PCI Bus 0000:02
>     e000-e0ff : 0000:02:00.1
>       e000-e0ff : r8169
>   f000-f03f : 0000:00:02.0
>   f040-f05f : 0000:00:1f.3
>   f060-f07f : 0000:00:1f.2
>     f060-f07f : ahci
>   f080-f083 : 0000:00:1f.2
>     f080-f083 : ahci
>   f090-f097 : 0000:00:1f.2
>     f090-f097 : ahci
>   f0a0-f0a3 : 0000:00:1f.2
>     f0a0-f0a3 : ahci
>   f0b0-f0b7 : 0000:00:1f.2
>     f0b0-f0b7 : ahci
>   ffff-ffff : pnp 00:01
>     ffff-ffff : pnp 00:01
>       ffff-ffff : pnp 00:01
>
> $ cat /proc/iomem
> 00000000-00000fff : reserved
> 00001000-00057fff : System RAM
> 00058000-00058fff : reserved
> 00059000-0009efff : System RAM
> 0009f000-0009ffff : reserved
> 000a0000-000bffff : PCI Bus 0000:00
> 000c0000-000cebff : Video ROM
> 000d0000-000d3fff : PCI Bus 0000:00
> 000d4000-000d7fff : PCI Bus 0000:00
> 000d8000-000dbfff : PCI Bus 0000:00
> 000dc000-000dffff : PCI Bus 0000:00
> 000f0000-000fffff : System ROM
> 00100000-c9b27fff : System RAM
>   02000000-027b1c17 : Kernel code
>   027b1c18-02d19c7f : Kernel data
>   02e80000-02fc8fff : Kernel bss
> c9b28000-c9b2efff : ACPI Non-volatile Storage
> c9b2f000-ca365fff : System RAM
> ca366000-ca5cdfff : reserved
> ca5ce000-d993dfff : System RAM
> d993e000-d9b45fff : reserved
> d9b46000-d9e82fff : System RAM
> d9e83000-dab4cfff : ACPI Non-volatile Storage
> dab4d000-daf59fff : reserved
> daf5a000-daffefff : reserved
> dafff000-daffffff : System RAM
> db000000-dbbfffff : RAM buffer
> dbc00000-dfdfffff : reserved
>   dbe00000-dfdfffff : Graphics Stolen Memory
> dfe00000-feafffff : PCI Bus 0000:00
>   e0000000-efffffff : 0000:00:02.0
>   f7800000-f7bfffff : 0000:00:02.0
>   f7c00000-f7cfffff : PCI Bus 0000:03
>     f7c00000-f7c7ffff : 0000:03:00.0
>       f7c00000-f7c7ffff : ath9k
>     f7c80000-f7c8ffff : 0000:03:00.0
>   f7d00000-f7dfffff : PCI Bus 0000:02
>     f7d00000-f7d0ffff : 0000:02:00.0
>     f7d10000-f7d13fff : 0000:02:00.1
>       f7d10000-f7d13fff : r8169
>     f7d14000-f7d14fff : 0000:02:00.1
>       f7d14000-f7d14fff : r8169
>     f7d15000-f7d15fff : 0000:02:00.0
>       f7d15000-f7d15fff : rtsx_pci
>   f7e00000-f7e0ffff : 0000:00:14.0
>     f7e00000-f7e0ffff : xhci-hcd
>   f7e10000-f7e17fff : 0000:00:04.0
>   f7e18000-f7e1bfff : 0000:00:1b.0
>     f7e18000-f7e1bfff : ICH HD audio
>   f7e1c000-f7e1ffff : 0000:00:03.0
>     f7e1c000-f7e1ffff : ICH HD audio
>   f7e20000-f7e20fff : 0000:00:1f.6
>   f7e21000-f7e210ff : 0000:00:1f.3
>   f7e22000-f7e227ff : 0000:00:1f.2
>     f7e22000-f7e227ff : ahci
>   f7e23000-f7e233ff : 0000:00:1d.0
>     f7e23000-f7e233ff : ehci_hcd
>   f7e25000-f7e2501f : 0000:00:16.0
>     f7e25000-f7e2501f : mei_me
>   f7fdf000-f7fdffff : pnp 00:09
>   f7fe0000-f7feffff : pnp 00:09
>   f8000000-fbffffff : PCI MMCONFIG 0000 [bus 00-3f]
>     f8000000-fbffffff : reserved
>       f8000000-fbffffff : pnp 00:09
> fec00000-fec00fff : reserved
>   fec00000-fec003ff : IOAPIC 0
> fed00000-fed03fff : reserved
>   fed00000-fed003ff : HPET 0
>     fed00000-fed003ff : PNP0103:00
> fed10000-fed17fff : pnp 00:09
> fed18000-fed18fff : pnp 00:09
> fed19000-fed19fff : pnp 00:09
> fed1c000-fed1ffff : reserved
>   fed1c000-fed1ffff : pnp 00:09
>     fed1f410-fed1f414 : iTCO_wdt
> fed20000-fed3ffff : pnp 00:09
> fed40000-fed44fff : pnp 00:00
> fed45000-fed8ffff : pnp 00:09
> fed90000-fed93fff : pnp 00:09
> fee00000-fee00fff : Local APIC
>   fee00000-fee00fff : reserved
> ff000000-ffffffff : reserved
>   ff000000-ffffffff : INT0800:00
>     ff000000-ffffffff : pnp 00:09
> 100000000-21f1fffff : System RAM
> 21f200000-21fffffff : RAM buffer
>
> [7.5.] PCI information
> $ sudo lspci -vvv
> [sudo] password for luca:
> 00:00.0 Host bridge: Intel Corporation Haswell-ULT DRAM Controller (rev 09)
>     Subsystem: ASUSTeK Computer Inc. Device 15ad
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort+ >SERR- <PERR- INTx-
>     Latency: 0
>     Capabilities: [e0] Vendor Specific Information: Len=0c <?>
>
> 00:02.0 VGA compatible controller: Intel Corporation Haswell-ULT
> Integrated Graphics Controller (rev 09) (prog-if 00 [VGA controller])
>     Subsystem: ASUSTeK Computer Inc. Device 15ad
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin A routed to IRQ 46
>     Region 0: Memory at f7800000 (64-bit, non-prefetchable) [size=4M]
>     Region 2: Memory at e0000000 (64-bit, prefetchable) [size=256M]
>     Region 4: I/O ports at f000 [size=64]
>     Expansion ROM at <unassigned> [disabled]
>     Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
>         Address: fee0f00c  Data: 4152
>     Capabilities: [d0] Power Management version 2
>         Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [a4] PCI Advanced Features
>         AFCap: TP+ FLR+
>         AFCtrl: FLR-
>         AFStatus: TP-
>     Kernel driver in use: i915
>
> 00:03.0 Audio device: Intel Corporation Haswell-ULT HD Audio Controller (rev 09)
>     Subsystem: ASUSTeK Computer Inc. Device 15ad
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 64 bytes
>     Interrupt: pin A routed to IRQ 47
>     Region 0: Memory at f7e1c000 (64-bit, non-prefetchable) [size=16K]
>     Capabilities: [50] Power Management version 2
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit-
>         Address: fee0f00c  Data: 4162
>     Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0
>             ExtTag- RBE-
>         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 128 bytes
>         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
>     Kernel driver in use: snd_hda_intel
>
> 00:04.0 Signal processing controller: Intel Corporation Device 0a03 (rev 09)
>     Subsystem: Intel Corporation Device 2010
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin A routed to IRQ 11
>     Region 0: Memory at f7e10000 (64-bit, non-prefetchable) [size=32K]
>     Capabilities: [90] MSI: Enable- Count=1/1 Maskable- 64bit-
>         Address: 00000000  Data: 0000
>     Capabilities: [d0] Power Management version 3
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [e0] Vendor Specific Information: Len=0c <?>
>
> 00:14.0 USB controller: Intel Corporation Lynx Point-LP USB xHCI HC
> (rev 04) (prog-if 30 [XHCI])
>     Subsystem: ASUSTeK Computer Inc. Device 201f
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin A routed to IRQ 40
>     Region 0: Memory at f7e00000 (64-bit, non-prefetchable) [size=64K]
>     Capabilities: [70] Power Management version 2
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
> PME(D0-,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
>         Address: 00000000fee0a00c  Data: 4191
>     Kernel driver in use: xhci_hcd
>
> 00:16.0 Communication controller: Intel Corporation Lynx Point-LP HECI
> #0 (rev 04)
>     Subsystem: ASUSTeK Computer Inc. Device 15ad
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin A routed to IRQ 44
>     Region 0: Memory at f7e25000 (64-bit, non-prefetchable) [size=32]
>     Capabilities: [50] Power Management version 3
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
>         Address: 00000000fee0f00c  Data: 41e1
>     Kernel driver in use: mei_me
>
> 00:1b.0 Audio device: Intel Corporation Lynx Point-LP HD Audio
> Controller (rev 04)
>     Subsystem: ASUSTeK Computer Inc. Device 15ad
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 64 bytes
>     Interrupt: pin A routed to IRQ 45
>     Region 0: Memory at f7e18000 (64-bit, non-prefetchable) [size=16K]
>     Capabilities: [50] Power Management version 3
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
>         Address: 00000000fee0f00c  Data: 4142
>     Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0
>             ExtTag- RBE-
>         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 128 bytes
>         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
>     Capabilities: [100 v1] Virtual Channel
>         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
>         Arb:    Fixed- WRR32- WRR64- WRR128-
>         Ctrl:    ArbSelect=Fixed
>         Status:    InProgress-
>         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
>             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=01
>             Status:    NegoPending- InProgress-
>         VC1:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
>             Ctrl:    Enable- ID=2 ArbSelect=Fixed TC/VC=04
>             Status:    NegoPending- InProgress-
>     Kernel driver in use: snd_hda_intel
>
> 00:1c.0 PCI bridge: Intel Corporation Lynx Point-LP PCI Express Root
> Port 1 (rev e4) (prog-if 00 [Normal decode])
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 64 bytes
>     Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>     I/O behind bridge: 0000f000-00000fff
>     Memory behind bridge: fff00000-000fffff
>     Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
>     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort+ <SERR- <PERR-
>     BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>     Capabilities: [40] Express (v2) Root Port (Slot-), MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0
>             ExtTag- RBE+
>         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 128 bytes
>         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
>         LnkCap:    Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Exit
> Latency L0s <1us, L1 <4us
>             ClockPM- Surprise- LLActRep+ BwNot+
>         LnkCtl:    ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk-
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+
> DLActive- BWMgmt- ABWMgmt-
>         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
>         RootCap: CRSVisible-
>         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>         DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+,
> OBFF Via WAKE# ARIFwd-
>         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+,
> OBFF Disabled ARIFwd-
>         LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
>              Transmit Margin: Normal Operating Range,
> EnterModifiedCompliance- ComplianceSOS-
>              Compliance De-emphasis: -6dB
>         LnkSta2: Current De-emphasis Level: -3.5dB,
> EqualizationComplete-, EqualizationPhase1-
>              EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
>     Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
>         Address: 00000000  Data: 0000
>     Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 15ad
>     Capabilities: [a0] Power Management version 3
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Kernel driver in use: pcieport
>
> 00:1c.2 PCI bridge: Intel Corporation Lynx Point-LP PCI Express Root
> Port 3 (rev e4) (prog-if 00 [Normal decode])
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 64 bytes
>     Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
>     I/O behind bridge: 0000e000-0000efff
>     Memory behind bridge: f7d00000-f7dfffff
>     Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
>     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort+ <SERR- <PERR-
>     BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>     Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0
>             ExtTag- RBE+
>         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 128 bytes
>         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
>         LnkCap:    Port #3, Speed 5GT/s, Width x1, ASPM L0s L1, Exit
> Latency L0s <512ns, L1 <16us
>             ClockPM- Surprise- LLActRep+ BwNot+
>         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk+
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
> DLActive+ BWMgmt+ ABWMgmt-
>         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
>             Slot #2, PowerLimit 10.000W; Interlock- NoCompl+
>         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
> HPIrq- LinkChg-
>             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
>             Changed: MRL- PresDet- LinkState-
>         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
>         RootCap: CRSVisible-
>         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>         DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+,
> OBFF Not Supported ARIFwd-
>         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+,
> OBFF Disabled ARIFwd-
>         LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
>              Transmit Margin: Normal Operating Range,
> EnterModifiedCompliance- ComplianceSOS-
>              Compliance De-emphasis: -6dB
>         LnkSta2: Current De-emphasis Level: -3.5dB,
> EqualizationComplete-, EqualizationPhase1-
>              EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
>     Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
>         Address: 00000000  Data: 0000
>     Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 15ad
>     Capabilities: [a0] Power Management version 3
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [100 v0] #00
>     Capabilities: [200 v1] L1 PM Substates
>         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
> L1_PM_Substates+
>               PortCommonModeRestoreTime=40us PortTPowerOnTime=10us
>     Kernel driver in use: pcieport
>
> 00:1c.3 PCI bridge: Intel Corporation Lynx Point-LP PCI Express Root
> Port 4 (rev e4) (prog-if 00 [Normal decode])
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 64 bytes
>     Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
>     I/O behind bridge: 0000f000-00000fff
>     Memory behind bridge: f7c00000-f7cfffff
>     Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
>     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort+ <SERR- <PERR-
>     BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>     Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0
>             ExtTag- RBE+
>         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 128 bytes
>         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
>         LnkCap:    Port #4, Speed 5GT/s, Width x1, ASPM L0s L1, Exit
> Latency L0s <512ns, L1 <16us
>             ClockPM- Surprise- LLActRep+ BwNot+
>         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk+
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
> DLActive+ BWMgmt+ ABWMgmt-
>         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
>             Slot #3, PowerLimit 10.000W; Interlock- NoCompl+
>         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
> HPIrq- LinkChg-
>             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
>             Changed: MRL- PresDet- LinkState-
>         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
>         RootCap: CRSVisible-
>         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>         DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+,
> OBFF Not Supported ARIFwd-
>         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+,
> OBFF Disabled ARIFwd-
>         LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
>              Transmit Margin: Normal Operating Range,
> EnterModifiedCompliance- ComplianceSOS-
>              Compliance De-emphasis: -6dB
>         LnkSta2: Current De-emphasis Level: -3.5dB,
> EqualizationComplete-, EqualizationPhase1-
>              EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
>     Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
>         Address: 00000000  Data: 0000
>     Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 15ad
>     Capabilities: [a0] Power Management version 3
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [100 v0] #00
>     Capabilities: [200 v1] L1 PM Substates
>         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
> L1_PM_Substates+
>               PortCommonModeRestoreTime=40us PortTPowerOnTime=10us
>     Kernel driver in use: pcieport
>
> 00:1d.0 USB controller: Intel Corporation Lynx Point-LP USB EHCI #1
> (rev 04) (prog-if 20 [EHCI])
>     Subsystem: ASUSTeK Computer Inc. Device 201f
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin A routed to IRQ 23
>     Region 0: Memory at f7e23000 (32-bit, non-prefetchable) [size=1K]
>     Capabilities: [50] Power Management version 3
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [58] Debug port: BAR=1 offset=00a0
>     Capabilities: [98] PCI Advanced Features
>         AFCap: TP+ FLR+
>         AFCtrl: FLR-
>         AFStatus: TP-
>     Kernel driver in use: ehci-pci
>
> 00:1f.0 ISA bridge: Intel Corporation Lynx Point-LP LPC Controller (rev 04)
>     Subsystem: ASUSTeK Computer Inc. Device 15ad
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Capabilities: [e0] Vendor Specific Information: Len=0c <?>
>     Kernel driver in use: lpc_ich
>
> 00:1f.2 SATA controller: Intel Corporation Lynx Point-LP SATA
> Controller 1 [AHCI mode] (rev 04) (prog-if 01 [AHCI 1.0])
>     Subsystem: ASUSTeK Computer Inc. Device 15ad
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
>     Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin B routed to IRQ 42
>     Region 0: I/O ports at f0b0 [size=8]
>     Region 1: I/O ports at f0a0 [size=4]
>     Region 2: I/O ports at f090 [size=8]
>     Region 3: I/O ports at f080 [size=4]
>     Region 4: I/O ports at f060 [size=32]
>     Region 5: Memory at f7e22000 (32-bit, non-prefetchable) [size=2K]
>     Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
>         Address: fee0a00c  Data: 41c1
>     Capabilities: [70] Power Management version 3
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot+,D3cold-)
>         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
>     Kernel driver in use: ahci
>
> 00:1f.3 SMBus: Intel Corporation Lynx Point-LP SMBus Controller (rev 04)
>     Subsystem: ASUSTeK Computer Inc. Device 15ad
>     Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Interrupt: pin C routed to IRQ 3
>     Region 0: Memory at f7e21000 (64-bit, non-prefetchable) [size=256]
>     Region 4: I/O ports at f040 [size=32]
>
> 00:1f.6 Signal processing controller: Intel Corporation Lynx Point-LP
> Thermal (rev 04)
>     Subsystem: ASUSTeK Computer Inc. Device 15ad
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin C routed to IRQ 3
>     Region 0: Memory at f7e20000 (64-bit, non-prefetchable) [size=4K]
>     Capabilities: [50] Power Management version 3
>         Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
>         Address: 00000000  Data: 0000
>
> 02:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd.
> Device 5287 (rev 01)
>     Subsystem: ASUSTeK Computer Inc. Device 202f
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 64 bytes
>     Interrupt: pin B routed to IRQ 41
>     Region 0: Memory at f7d15000 (32-bit, non-prefetchable) [size=4K]
>     Expansion ROM at f7d00000 [disabled] [size=64K]
>     Capabilities: [40] Power Management version 3
>         Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
> PME(D0-,D1+,D2+,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
>         Address: 00000000fee0f00c  Data: 41b1
>     Capabilities: [70] Express (v2) Endpoint, MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s
> <512ns, L1 <64us
>             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
>         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 512 bytes
>         DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
>         LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
> Latency L0s unlimited, L1 <64us
>             ClockPM+ Surprise- LLActRep- BwNot-
>         LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk-
>             ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
> DLActive- BWMgmt- ABWMgmt-
>         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR+,
> OBFF Via message/WAKE#
>         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+,
> OBFF Disabled
>         LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
>              Transmit Margin: Normal Operating Range,
> EnterModifiedCompliance- ComplianceSOS-
>              Compliance De-emphasis: -6dB
>         LnkSta2: Current De-emphasis Level: -6dB,
> EqualizationComplete-, EqualizationPhase1-
>              EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
>     Capabilities: [b0] MSI-X: Enable- Count=1 Masked-
>         Vector table: BAR=0 offset=00000000
>         PBA: BAR=0 offset=00000000
>     Capabilities: [d0] Vital Product Data
> pcilib: sysfs_read_vpd: read failed: Connection timed out
>         Not readable
>     Capabilities: [100 v2] Advanced Error Reporting
>         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>         AERCap:    First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
>     Capabilities: [140 v1] Virtual Channel
>         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
>         Arb:    Fixed- WRR32- WRR64- WRR128-
>         Ctrl:    ArbSelect=Fixed
>         Status:    InProgress-
>         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
>             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=01
>             Status:    NegoPending- InProgress-
>     Capabilities: [160 v1] Device Serial Number 00-00-00-00-00-00-00-00
>     Capabilities: [170 v1] Latency Tolerance Reporting
>         Max snoop latency: 3145728ns
>         Max no snoop latency: 3145728ns
>     Capabilities: [178 v1] L1 PM Substates
>         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
> L1_PM_Substates+
>               PortCommonModeRestoreTime=150us PortTPowerOnTime=150us
>     Kernel driver in use: rtsx_pci
>
> 02:00.1 Ethernet controller: Realtek Semiconductor Co., Ltd.
> RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 12)
>     Subsystem: ASUSTeK Computer Inc. Device 200f
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 64 bytes
>     Interrupt: pin A routed to IRQ 43
>     Region 0: I/O ports at e000 [size=256]
>     Region 2: Memory at f7d14000 (64-bit, non-prefetchable) [size=4K]
>     Region 4: Memory at f7d10000 (64-bit, non-prefetchable) [size=16K]
>     Capabilities: [40] Power Management version 3
>         Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
>         Address: 00000000fee0100c  Data: 41d1
>     Capabilities: [70] Express (v2) Endpoint, MSI 01
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s
> <512ns, L1 <64us
>             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
>         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 4096 bytes
>         DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
>         LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
> Latency L0s unlimited, L1 <64us
>             ClockPM+ Surprise- LLActRep- BwNot-
>         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk+
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
> DLActive- BWMgmt- ABWMgmt-
>         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR+,
> OBFF Via message/WAKE#
>         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-,
> OBFF Disabled
>         LnkSta2: Current De-emphasis Level: -6dB,
> EqualizationComplete-, EqualizationPhase1-
>              EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
>     Capabilities: [b0] MSI-X: Enable- Count=4 Masked-
>         Vector table: BAR=4 offset=00000000
>         PBA: BAR=4 offset=00000800
>     Capabilities: [d0] Vital Product Data
>         Unknown small resource type 00, will not decode more.
>     Capabilities: [100 v2] Advanced Error Reporting
>         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>         AERCap:    First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
>     Capabilities: [160 v1] Device Serial Number 09-25-01-13-68-4c-e0-00
>     Capabilities: [170 v1] Latency Tolerance Reporting
>         Max snoop latency: 3145728ns
>         Max no snoop latency: 3145728ns
>     Capabilities: [178 v1] L1 PM Substates
>         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
> L1_PM_Substates+
>               PortCommonModeRestoreTime=150us PortTPowerOnTime=150us
>     Kernel driver in use: r8169
>
> 03:00.0 Network controller: Qualcomm Atheros QCA9565 / AR9565 Wireless
> Network Adapter (rev 01)
>     Subsystem: AzureWave Device 2130
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 64 bytes
>     Interrupt: pin A routed to IRQ 19
>     Region 0: Memory at f7c00000 (64-bit, non-prefetchable) [size=512K]
>     Expansion ROM at f7c80000 [disabled] [size=64K]
>     Capabilities: [40] Power Management version 2
>         Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [50] MSI: Enable- Count=1/4 Maskable+ 64bit+
>         Address: 0000000000000000  Data: 0000
>         Masking: 00000000  Pending: 00000000
>     Capabilities: [70] Express (v2) Endpoint, MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s
> unlimited, L1 <64us
>             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
>         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 512 bytes
>         DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
>         LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
> Latency L0s <4us, L1 <64us
>             ClockPM- Surprise- LLActRep- BwNot-
>         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk+
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
> DLActive- BWMgmt- ABWMgmt-
>         DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR-,
> OBFF Not Supported
>         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-,
> OBFF Disabled
>         LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
>              Transmit Margin: Normal Operating Range,
> EnterModifiedCompliance- ComplianceSOS-
>              Compliance De-emphasis: -6dB
>         LnkSta2: Current De-emphasis Level: -6dB,
> EqualizationComplete-, EqualizationPhase1-
>              EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
>     Capabilities: [100 v1] Advanced Error Reporting
>         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>         AERCap:    First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
>     Capabilities: [140 v1] Virtual Channel
>         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
>         Arb:    Fixed- WRR32- WRR64- WRR128-
>         Ctrl:    ArbSelect=Fixed
>         Status:    InProgress-
>         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
>             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=01
>             Status:    NegoPending- InProgress-
>     Capabilities: [160 v1] Device Serial Number 00-00-00-00-00-00-00-00
>     Kernel driver in use: ath9k
>
> [7.6.] SCSI information
> $ cat /proc/scsi/scsi
> Attached devices:
> Host: scsi0 Channel: 00 Id: 00 Lun: 00
>   Vendor: ATA      Model: ST1000LM024 HN-M Rev: 0001
>   Type:   Direct-Access                    ANSI  SCSI revision: 05
> Host: scsi1 Channel: 00 Id: 00 Lun: 00
>   Vendor: TSSTcorp Model: CDDVDW SU-228FB  Rev: AS00
>   Type:   CD-ROM                           ANSI  SCSI revision: 05
>
> [7.7.] Other information that might be relevant to the problem
> $ ls /proc
> 1     1301  1495  1573  1830  1957  2114  24    3011  31    3288  3582
>  38    43    55    7698  9          devices      kpagecount
> slabinfo
> 10    1311  1499  1574  1832  1958  2119  25    3012  3101  3290  36
>  3888  44    581   771   90         diskstats    kpageflags
> softirqs
> 102   1330  15    1580  1851  1961  2130  26    3018  3155  33    3600
>  389   45    5883  786   922        dma          loadavg       stat
> 1053  1342  150   1583  1854  1962  2151  2622  3022  3160  34    361
>  39    46    5972  8     975        driver       locks         swaps
> 1054  1347  1504  1585  1856  1967  22    2651  3025  3163  35    3615
>  390   4622  611   802   979        execdomains  mdstat        sys
> 1055  1361  151   1587  1858  1978  2200  2655  3031  3166  3500  3654
>  391   4638  6581  803   986        fb           meminfo
> sysrq-trigger
> 1062  14    152   1596  1859  2     2205  27    3036  3169  3501  3662
>  3926  466   665   818   987        filesystems  misc          sysvipc
> 1065  142   1520  1609  1860  20    2227  2731  304   3176  3503  3676
>  3933  468   6663  824   990        fs           modules
> thread-self
> 1084  144   1532  1619  1861  2032  2230  28    3046  3179  3504  3681
>  3934  47    6664  829   acpi       interrupts   mounts
> timer_list
> 1088  145   1537  163   1862  2036  2231  29    3048  3185  3506  3687
>  396   472   67    835   asound     iomem        mtrr
> timer_stats
> 11    146   1539  1683  1864  2046  2232  2936  3050  3187  3507  3693
>  4     473   68    841   buddyinfo  ioports      net           tty
> 1163  147   1540  1685  1897  2050  2242  2939  3058  32    3515  37
>  40    48    69    842   bus        irq          pagetypeinfo  uptime
> 1180  148   1542  17    19    2059  2244  296   3059  3204  3542  3708
>  4065  5     7     864   cgroups    kallsyms     partitions    version
> 12    1483  1564  172   1906  2063  2248  2991  3061  3223  3554  3728
>  41    50    70    870   cmdline    kcore        sched_debug
> vmallocinfo
> 1285  1485  1568  1723  1953  2091  2256  3     3083  3241  3559  375
>  42    51    7244  89    consoles   keys         schedstat     vmstat
> 1288  1486  157   173   1955  2099  2272  3000  3089  3248  3563  3754
>  4288  53    7533  893   cpuinfo    key-users    scsi
> zoneinfo
> 13    149   1571  18    1956  21    2355  3004  3095  3281  3575  3790
>  4289  54    760   897   crypto     kmsg         self
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

