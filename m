From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: Aorus X3+ touchpad not working
Date: Wed, 5 Nov 2014 10:47:25 -0500
Message-ID: <CAN+gG=F7d+37kKF=s-_jLVd+=oqCjaNNQW084eKnYBREEZF14w@mail.gmail.com>
References: <CAJdy7pJpbyYHuOg3AWnDJap=T9z0bUCZkM+DRuuTLUFj129H_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:54185 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755005AbaKEPr0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Nov 2014 10:47:26 -0500
Received: by mail-qc0-f175.google.com with SMTP id b13so829779qcw.34
        for <linux-input@vger.kernel.org>; Wed, 05 Nov 2014 07:47:25 -0800 (PST)
In-Reply-To: <CAJdy7pJpbyYHuOg3AWnDJap=T9z0bUCZkM+DRuuTLUFj129H_w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Maximilien Levesque <maximilien.levesque@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>

Hi Maximilien,

[Adding Hans in CC, I am pretty sure he might be helpful]

[side note: I hate those bug reports when there is all the information
but the one we need] <-- Maximilien, do not take this personally, I
know you have been asked to report it that way.

So, I think we need to have a look at your dmesg with the v3.18-rc3
kernel booted.

Hans, do you think this could be related to the nomux/mux dance in the
input tree?

Cheers,
Benjamin

On Wed, Nov 5, 2014 at 4:37 AM, Maximilien Levesque
<maximilien.levesque@gmail.com> wrote:
> Dear Maintainers,
>
> This is my first report. Please bear with me...
> (and let me take the opportunity to thank all of you for your amazing work).
> I've been asked to give a direct link to my e-mail so here it is:
> maximilien.levesque@gmail.com
>
> [1.] One line summary of the problem:
> Aorus X3+ touchpad not working
>
> [2.] Full description of the problem/report:
> On a laptop Aorus X3+, the touchpad is not working. The mouse pointer
> is invisible and touchpad clicks are not possible. It feels like there
> is no touchpad at all.
>
> [3.] Keywords (i.e., modules, networking, kernel):
>
> [4.] Kernel version (from /proc/version):
> Linux version 3.18.0-031800rc3-generic (apw@tangerine) (gcc version
> 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201411022335 SMP Sun Nov 2
> 23:36:52 UTC 2014
>
> [5.] Output of Oops..
> not relevant
>
> [6.] A small shell script or example program which triggers the
> problem (if possible)
> I am not able to provide one.
>
> [7.] Environment
> Description:    Ubuntu 14.10
> Release:    14.10
>
> [7.1.] Software (add the output of the ver_linux script here)
> Linux portmax2 3.18.0-031800rc3-generic #201411022335 SMP Sun Nov 2
> 23:36:52 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux
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
> Modules Loaded         pci_stub vboxpci vboxnetadp vboxnetflt vboxdrv
> ctr ccm arc4 iwlmvm mac80211 btusb sparse_keymap x86_pkg_temp_thermal
> intel_powerclamp coretemp kvm_intel kvm snd_hda_codec_hdmi
> crct10dif_pclmul crc32_pclmul ghash_clmulni_intel uvcvideo
> videobuf2_vmalloc videobuf2_memops aesni_intel aes_x86_64 lrw
> videobuf2_core gf128mul glue_helper nouveau ablk_helper iwlwifi cryptd
> v4l2_common videodev serio_raw media joydev snd_hda_codec_realtek
> snd_hda_codec_generic i915 mxm_wmi snd_soc_rt5640 rtsx_pci_ms
> snd_soc_rl6231 cfg80211 ttm snd_hda_intel memstick snd_soc_core
> snd_hda_controller drm_kms_helper snd_compress snd_hda_codec
> snd_pcm_dmaengine lpc_ich snd_hwdep drm mei_me snd_pcm mei shpchp
> i2c_algo_bit snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq
> snd_seq_device snd_timer tpm_infineon snd soundcore i2c_hid wmi
> snd_soc_sst_acpi dw_dmac video dw_dmac_core 8250_dw
> i2c_designware_platform i2c_designware_core bnep rfcomm bluetooth
> spi_pxa2xx_platform mac_hid binfmt_misc parport_pc ppdev lp parport
> nls_iso8859_1 hid_generic usbhid hid rtsx_pci_sdmmc ahci psmouse alx
> rtsx_pci libahci mdio sdhci_acpi sdhci
>
>
> [7.2.] Processor information (from /proc/cpuinfo):
> processor    : 0
> vendor_id    : GenuineIntel
> cpu family    : 6
> model        : 70
> model name    : Intel(R) Core(TM) i7-4860HQ CPU @ 2.40GHz
> stepping    : 1
> microcode    : 0xf
> cpu MHz        : 832.781
> cache size    : 6144 KB
> physical id    : 0
> siblings    : 8
> core id        : 0
> cpu cores    : 4
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
> dtes64 monitor ds_cpl vmx smx est tm2 ssse3 fma cx16 xtpr pdcm pcid
> sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx
> f16c rdrand lahf_lm abm ida arat epb pln pts dtherm tpr_shadow vnmi
> flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms
> invpcid rtm xsaveopt
> bugs        :
> bogomips    : 4789.06
> clflush size    : 64
> cache_alignment    : 64
> address sizes    : 39 bits physical, 48 bits virtual
> power management:
>
> processor    : 1
> vendor_id    : GenuineIntel
> cpu family    : 6
> model        : 70
> model name    : Intel(R) Core(TM) i7-4860HQ CPU @ 2.40GHz
> stepping    : 1
> microcode    : 0xf
> cpu MHz        : 931.406
> cache size    : 6144 KB
> physical id    : 0
> siblings    : 8
> core id        : 1
> cpu cores    : 4
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
> dtes64 monitor ds_cpl vmx smx est tm2 ssse3 fma cx16 xtpr pdcm pcid
> sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx
> f16c rdrand lahf_lm abm ida arat epb pln pts dtherm tpr_shadow vnmi
> flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms
> invpcid rtm xsaveopt
> bugs        :
> bogomips    : 4789.06
> clflush size    : 64
> cache_alignment    : 64
> address sizes    : 39 bits physical, 48 bits virtual
> power management:
>
> processor    : 2
> vendor_id    : GenuineIntel
> cpu family    : 6
> model        : 70
> model name    : Intel(R) Core(TM) i7-4860HQ CPU @ 2.40GHz
> stepping    : 1
> microcode    : 0xf
> cpu MHz        : 899.437
> cache size    : 6144 KB
> physical id    : 0
> siblings    : 8
> core id        : 2
> cpu cores    : 4
> apicid        : 4
> initial apicid    : 4
> fpu        : yes
> fpu_exception    : yes
> cpuid level    : 13
> wp        : yes
> flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
> syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts
> rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq
> dtes64 monitor ds_cpl vmx smx est tm2 ssse3 fma cx16 xtpr pdcm pcid
> sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx
> f16c rdrand lahf_lm abm ida arat epb pln pts dtherm tpr_shadow vnmi
> flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms
> invpcid rtm xsaveopt
> bugs        :
> bogomips    : 4789.06
> clflush size    : 64
> cache_alignment    : 64
> address sizes    : 39 bits physical, 48 bits virtual
> power management:
>
> processor    : 3
> vendor_id    : GenuineIntel
> cpu family    : 6
> model        : 70
> model name    : Intel(R) Core(TM) i7-4860HQ CPU @ 2.40GHz
> stepping    : 1
> microcode    : 0xf
> cpu MHz        : 829.218
> cache size    : 6144 KB
> physical id    : 0
> siblings    : 8
> core id        : 3
> cpu cores    : 4
> apicid        : 6
> initial apicid    : 6
> fpu        : yes
> fpu_exception    : yes
> cpuid level    : 13
> wp        : yes
> flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
> syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts
> rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq
> dtes64 monitor ds_cpl vmx smx est tm2 ssse3 fma cx16 xtpr pdcm pcid
> sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx
> f16c rdrand lahf_lm abm ida arat epb pln pts dtherm tpr_shadow vnmi
> flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms
> invpcid rtm xsaveopt
> bugs        :
> bogomips    : 4789.06
> clflush size    : 64
> cache_alignment    : 64
> address sizes    : 39 bits physical, 48 bits virtual
> power management:
>
> processor    : 4
> vendor_id    : GenuineIntel
> cpu family    : 6
> model        : 70
> model name    : Intel(R) Core(TM) i7-4860HQ CPU @ 2.40GHz
> stepping    : 1
> microcode    : 0xf
> cpu MHz        : 799.968
> cache size    : 6144 KB
> physical id    : 0
> siblings    : 8
> core id        : 0
> cpu cores    : 4
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
> dtes64 monitor ds_cpl vmx smx est tm2 ssse3 fma cx16 xtpr pdcm pcid
> sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx
> f16c rdrand lahf_lm abm ida arat epb pln pts dtherm tpr_shadow vnmi
> flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms
> invpcid rtm xsaveopt
> bugs        :
> bogomips    : 4789.06
> clflush size    : 64
> cache_alignment    : 64
> address sizes    : 39 bits physical, 48 bits virtual
> power management:
>
> processor    : 5
> vendor_id    : GenuineIntel
> cpu family    : 6
> model        : 70
> model name    : Intel(R) Core(TM) i7-4860HQ CPU @ 2.40GHz
> stepping    : 1
> microcode    : 0xf
> cpu MHz        : 1000.500
> cache size    : 6144 KB
> physical id    : 0
> siblings    : 8
> core id        : 1
> cpu cores    : 4
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
> dtes64 monitor ds_cpl vmx smx est tm2 ssse3 fma cx16 xtpr pdcm pcid
> sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx
> f16c rdrand lahf_lm abm ida arat epb pln pts dtherm tpr_shadow vnmi
> flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms
> invpcid rtm xsaveopt
> bugs        :
> bogomips    : 4789.06
> clflush size    : 64
> cache_alignment    : 64
> address sizes    : 39 bits physical, 48 bits virtual
> power management:
>
> processor    : 6
> vendor_id    : GenuineIntel
> cpu family    : 6
> model        : 70
> model name    : Intel(R) Core(TM) i7-4860HQ CPU @ 2.40GHz
> stepping    : 1
> microcode    : 0xf
> cpu MHz        : 899.531
> cache size    : 6144 KB
> physical id    : 0
> siblings    : 8
> core id        : 2
> cpu cores    : 4
> apicid        : 5
> initial apicid    : 5
> fpu        : yes
> fpu_exception    : yes
> cpuid level    : 13
> wp        : yes
> flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
> syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts
> rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq
> dtes64 monitor ds_cpl vmx smx est tm2 ssse3 fma cx16 xtpr pdcm pcid
> sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx
> f16c rdrand lahf_lm abm ida arat epb pln pts dtherm tpr_shadow vnmi
> flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms
> invpcid rtm xsaveopt
> bugs        :
> bogomips    : 4789.06
> clflush size    : 64
> cache_alignment    : 64
> address sizes    : 39 bits physical, 48 bits virtual
> power management:
>
> processor    : 7
> vendor_id    : GenuineIntel
> cpu family    : 6
> model        : 70
> model name    : Intel(R) Core(TM) i7-4860HQ CPU @ 2.40GHz
> stepping    : 1
> microcode    : 0xf
> cpu MHz        : 1019.625
> cache size    : 6144 KB
> physical id    : 0
> siblings    : 8
> core id        : 3
> cpu cores    : 4
> apicid        : 7
> initial apicid    : 7
> fpu        : yes
> fpu_exception    : yes
> cpuid level    : 13
> wp        : yes
> flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
> syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts
> rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq
> dtes64 monitor ds_cpl vmx smx est tm2 ssse3 fma cx16 xtpr pdcm pcid
> sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx
> f16c rdrand lahf_lm abm ida arat epb pln pts dtherm tpr_shadow vnmi
> flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms
> invpcid rtm xsaveopt
> bugs        :
> bogomips    : 4789.06
> clflush size    : 64
> cache_alignment    : 64
> address sizes    : 39 bits physical, 48 bits virtual
> power management:
>
>
>
> [7.3.] Module information (from /proc/modules):
> pci_stub 12622 1 - Live 0x0000000000000000
> vboxpci 23256 0 - Live 0x0000000000000000 (OE)
> vboxnetadp 25670 0 - Live 0x0000000000000000 (OE)
> vboxnetflt 27605 0 - Live 0x0000000000000000 (OE)
> vboxdrv 418013 3 vboxpci,vboxnetadp,vboxnetflt, Live 0x0000000000000000 (OE)
> ctr 13193 0 - Live 0x0000000000000000
> ccm 17856 0 - Live 0x0000000000000000
> arc4 12573 2 - Live 0x0000000000000000
> iwlmvm 254598 0 - Live 0x0000000000000000
> mac80211 697143 1 iwlmvm, Live 0x0000000000000000
> btusb 32691 0 - Live 0x0000000000000000
> sparse_keymap 13890 0 - Live 0x0000000000000000
> x86_pkg_temp_thermal 14312 0 - Live 0x0000000000000000
> intel_powerclamp 19099 0 - Live 0x0000000000000000
> coretemp 13638 0 - Live 0x0000000000000000
> kvm_intel 149984 0 - Live 0x0000000000000000
> kvm 475233 1 kvm_intel, Live 0x0000000000000000
> snd_hda_codec_hdmi 52670 1 - Live 0x0000000000000000
> crct10dif_pclmul 14268 0 - Live 0x0000000000000000
> crc32_pclmul 13180 0 - Live 0x0000000000000000
> ghash_clmulni_intel 13230 0 - Live 0x0000000000000000
> uvcvideo 86723 0 - Live 0x0000000000000000
> videobuf2_vmalloc 13216 1 uvcvideo, Live 0x0000000000000000
> videobuf2_memops 13362 1 videobuf2_vmalloc, Live 0x0000000000000000
> aesni_intel 169686 1 - Live 0x0000000000000000
> aes_x86_64 17131 1 aesni_intel, Live 0x0000000000000000
> lrw 13323 1 aesni_intel, Live 0x0000000000000000
> videobuf2_core 51547 1 uvcvideo, Live 0x0000000000000000
> gf128mul 14951 1 lrw, Live 0x0000000000000000
> glue_helper 14095 1 aesni_intel, Live 0x0000000000000000
> nouveau 1365930 1 - Live 0x0000000000000000
> ablk_helper 13597 1 aesni_intel, Live 0x0000000000000000
> iwlwifi 193774 1 iwlmvm, Live 0x0000000000000000
> cryptd 20531 3 ghash_clmulni_intel,aesni_intel,ablk_helper, Live
> 0x0000000000000000
> v4l2_common 15715 1 videobuf2_core, Live 0x0000000000000000
> videodev 163831 3 uvcvideo,videobuf2_core,v4l2_common, Live 0x0000000000000000
> serio_raw 13483 0 - Live 0x0000000000000000
> media 22008 2 uvcvideo,videodev, Live 0x0000000000000000
> joydev 17587 0 - Live 0x0000000000000000
> snd_hda_codec_realtek 76099 1 - Live 0x0000000000000000
> snd_hda_codec_generic 69995 1 snd_hda_codec_realtek, Live 0x0000000000000000
> i915 1031913 7 - Live 0x0000000000000000
> mxm_wmi 13021 1 nouveau, Live 0x0000000000000000
> snd_soc_rt5640 93325 0 - Live 0x0000000000000000
> rtsx_pci_ms 18337 0 - Live 0x0000000000000000
> snd_soc_rl6231 13037 1 snd_soc_rt5640, Live 0x0000000000000000
> cfg80211 520257 3 iwlmvm,mac80211,iwlwifi, Live 0x0000000000000000
> ttm 90228 1 nouveau, Live 0x0000000000000000
> snd_hda_intel 30783 5 - Live 0x0000000000000000
> memstick 16968 1 rtsx_pci_ms, Live 0x0000000000000000
> snd_soc_core 207596 1 snd_soc_rt5640, Live 0x0000000000000000
> snd_hda_controller 32234 1 snd_hda_intel, Live 0x0000000000000000
> drm_kms_helper 99802 2 nouveau,i915, Live 0x0000000000000000
> snd_compress 19395 1 snd_soc_core, Live 0x0000000000000000
> snd_hda_codec 144641 5
> snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_controller,
> Live 0x0000000000000000
> snd_pcm_dmaengine 15229 1 snd_soc_core, Live 0x0000000000000000
> lpc_ich 21176 0 - Live 0x0000000000000000
> snd_hwdep 17709 1 snd_hda_codec, Live 0x0000000000000000
> drm 323675 9 nouveau,i915,ttm,drm_kms_helper, Live 0x0000000000000000
> mei_me 19565 0 - Live 0x0000000000000000
> snd_pcm 106273 7
> snd_hda_codec_hdmi,snd_soc_rt5640,snd_hda_intel,snd_soc_core,snd_hda_controller,snd_hda_codec,snd_pcm_dmaengine,
> Live 0x0000000000000000
> mei 88473 1 mei_me, Live 0x0000000000000000
> shpchp 37216 0 - Live 0x0000000000000000
> i2c_algo_bit 13564 2 nouveau,i915, Live 0x0000000000000000
> snd_seq_midi 13564 0 - Live 0x0000000000000000
> snd_seq_midi_event 14899 1 snd_seq_midi, Live 0x0000000000000000
> snd_rawmidi 31197 1 snd_seq_midi, Live 0x0000000000000000
> snd_seq 63540 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
> snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x0000000000000000
> snd_timer 30118 2 snd_pcm,snd_seq, Live 0x0000000000000000
> tpm_infineon 17169 0 - Live 0x0000000000000000
> snd 84025 23 snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_soc_core,snd_compress,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_seq_device,snd_timer,
> Live 0x0000000000000000
> soundcore 15091 2 snd_hda_codec,snd, Live 0x0000000000000000
> i2c_hid 19065 0 - Live 0x0000000000000000
> wmi 19379 2 nouveau,mxm_wmi, Live 0x0000000000000000
> snd_soc_sst_acpi 13007 0 - Live 0x0000000000000000
> dw_dmac 12835 0 - Live 0x0000000000000000
> video 20649 2 nouveau,i915, Live 0x0000000000000000
> dw_dmac_core 28558 1 dw_dmac, Live 0x0000000000000000
> 8250_dw 13474 0 - Live 0x0000000000000000
> i2c_designware_platform 13025 0 - Live 0x0000000000000000
> i2c_designware_core 14990 1 i2c_designware_platform, Live 0x0000000000000000
> bnep 23980 2 - Live 0x0000000000000000
> rfcomm 75066 8 - Live 0x0000000000000000
> bluetooth 486890 22 btusb,bnep,rfcomm, Live 0x0000000000000000
> spi_pxa2xx_platform 23256 0 - Live 0x0000000000000000
> mac_hid 13275 0 - Live 0x0000000000000000
> binfmt_misc 17501 1 - Live 0x0000000000000000
> parport_pc 32909 0 - Live 0x0000000000000000
> ppdev 17711 0 - Live 0x0000000000000000
> lp 17799 0 - Live 0x0000000000000000
> parport 42481 3 parport_pc,ppdev,lp, Live 0x0000000000000000
> nls_iso8859_1 12713 1 - Live 0x0000000000000000
> hid_generic 12559 0 - Live 0x0000000000000000
> usbhid 53155 0 - Live 0x0000000000000000
> hid 110572 3 i2c_hid,hid_generic,usbhid, Live 0x0000000000000000
> rtsx_pci_sdmmc 23718 0 - Live 0x0000000000000000
> ahci 34220 3 - Live 0x0000000000000000
> psmouse 118117 0 - Live 0x0000000000000000
> alx 41397 0 - Live 0x0000000000000000
> rtsx_pci 51162 2 rtsx_pci_ms,rtsx_pci_sdmmc, Live 0x0000000000000000
> libahci 32446 1 ahci, Live 0x0000000000000000
> mdio 13561 1 alx, Live 0x0000000000000000
> sdhci_acpi 13502 0 - Live 0x0000000000000000
> sdhci 43929 1 sdhci_acpi, Live 0x0000000000000000
>
> [7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
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
>     00f0-00f0 : PNP0C04:00
>   04d0-04d1 : pnp 00:04
>   0680-069f : pnp 00:01
> 0cf8-0cff : PCI conf1
> 0d00-ffff : PCI Bus 0000:00
>   164e-164f : pnp 00:01
>   1800-1803 : ACPI PM1a_EVT_BLK
>   1804-1805 : ACPI PM1a_CNT_BLK
>   1808-180b : ACPI PM_TMR
>   1810-1815 : ACPI CPU throttle
>   1820-182f : ACPI GPE0_BLK
>   1830-1833 : iTCO_wdt
>   1850-1850 : ACPI PM2_CNT_BLK
>   1854-1857 : pnp 00:03
>   1860-187f : iTCO_wdt
>   1c00-1cfe : pnp 00:01
>   1d00-1dfe : pnp 00:01
>   1e00-1efe : pnp 00:01
>   1f00-1ffe : pnp 00:01
>   2000-2fff : PCI Bus 0000:02
>   d000-dfff : PCI Bus 0000:04
>     d000-d07f : 0000:04:00.0
>   e000-efff : PCI Bus 0000:01
>     e000-e07f : 0000:01:00.0
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
> 00000000-00000fff : reserved
> 00001000-00057fff : System RAM
> 00058000-00058fff : reserved
> 00059000-0009dfff : System RAM
> 0009e000-0009ffff : reserved
> 000a0000-000bffff : PCI Bus 0000:00
> 000c0000-000c3fff : PCI Bus 0000:00
> 000c4000-000c7fff : PCI Bus 0000:00
> 000c8000-000cbfff : PCI Bus 0000:00
> 000cc000-000cffff : PCI Bus 0000:00
> 000d0000-000d3fff : PCI Bus 0000:00
> 000d4000-000d7fff : PCI Bus 0000:00
> 000d8000-000dbfff : PCI Bus 0000:00
> 000dc000-000dffff : PCI Bus 0000:00
> 000f0000-000fffff : System ROM
> 00100000-b9511fff : System RAM
>   02000000-027ae357 : Kernel code
>   027ae358-02d1997f : Kernel data
>   02e80000-02fc8fff : Kernel bss
> b9512000-b9518fff : ACPI Non-volatile Storage
> b9519000-b9d6cfff : System RAM
> b9d6d000-ba024fff : reserved
> ba025000-cb226fff : System RAM
> cb227000-cb2c2fff : reserved
> cb2c3000-cb2e1fff : ACPI Tables
> cb2e2000-cb987fff : ACPI Non-volatile Storage
> cb988000-cbf77fff : reserved
> cbf78000-cbffefff : reserved
> cbfff000-cbffffff : System RAM
> cd000000-cf1fffff : reserved
>   cd200000-cf1fffff : Graphics Stolen Memory
> cf200000-feafffff : PCI Bus 0000:00
>   cf200000-cf3fffff : PCI Bus 0000:02
>   cf400000-cf5fffff : PCI Bus 0000:02
>   d0000000-dfffffff : 0000:00:02.0
>   e0000000-f1ffffff : PCI Bus 0000:01
>     e0000000-efffffff : 0000:01:00.0
>     f0000000-f1ffffff : 0000:01:00.0
>   f6000000-f70fffff : PCI Bus 0000:01
>     f6000000-f6ffffff : 0000:01:00.0
>     f7000000-f707ffff : 0000:01:00.0
>   f7400000-f77fffff : 0000:00:02.0
>   f7800000-f78fffff : PCI Bus 0000:05
>     f7800000-f7800fff : 0000:05:00.0
>       f7800000-f7800fff : rtsx_pci
>   f7900000-f79fffff : PCI Bus 0000:04
>     f7900000-f793ffff : 0000:04:00.0
>       f7900000-f793ffff : alx
>   f7a00000-f7afffff : PCI Bus 0000:03
>     f7a00000-f7a01fff : 0000:03:00.0
>       f7a00000-f7a01fff : iwlwifi
>   f7b00000-f7b0ffff : 0000:00:14.0
>     f7b00000-f7b0ffff : xhci-hcd
>   f7b10000-f7b13fff : 0000:00:1b.0
>     f7b10000-f7b13fff : ICH HD audio
>   f7b14000-f7b17fff : 0000:00:03.0
>     f7b14000-f7b17fff : ICH HD audio
>   f7b18000-f7b18fff : 0000:00:1f.6
>   f7b19000-f7b190ff : 0000:00:1f.3
>   f7b1a000-f7b1a7ff : 0000:00:1f.2
>     f7b1a000-f7b1a7ff : ahci
>   f7b1b000-f7b1b3ff : 0000:00:1d.0
>     f7b1b000-f7b1b3ff : ehci_hcd
>   f7b1c000-f7b1c3ff : 0000:00:1a.0
>     f7b1c000-f7b1c3ff : ehci_hcd
>   f7b1e000-f7b1e00f : 0000:00:16.0
>     f7b1e000-f7b1e00f : mei_me
>   f7fdf000-f7fdffff : pnp 00:07
>   f7fe0000-f7feffff : pnp 00:07
>   f8000000-fbffffff : PCI MMCONFIG 0000 [bus 00-3f]
>     f8000000-fbffffff : reserved
>       f8000000-fbffffff : pnp 00:07
> fec00000-fec00fff : reserved
>   fec00000-fec003ff : IOAPIC 0
> fed00000-fed03fff : reserved
>   fed00000-fed003ff : HPET 0
>     fed00000-fed003ff : PNP0103:00
> fed10000-fed17fff : pnp 00:07
> fed18000-fed18fff : pnp 00:07
> fed19000-fed19fff : pnp 00:07
> fed1c000-fed1ffff : reserved
>   fed1c000-fed1ffff : pnp 00:07
>     fed1f410-fed1f414 : iTCO_wdt
> fed20000-fed3ffff : pnp 00:07
> fed40000-fed44fff : pnp 00:00
> fed45000-fed8ffff : pnp 00:07
> fed90000-fed90fff : dmar0
> fed91000-fed91fff : dmar1
> fee00000-fee00fff : Local APIC
>   fee00000-fee00fff : reserved
> ff000000-ffffffff : reserved
>   ff000000-ffffffff : INT0800:00
>     ff000000-ffffffff : pnp 00:07
> 100000000-42fdfffff : System RAM
> 42fe00000-42fffffff : RAM buffer
>
>
> [7.5.] PCI information ('lspci -vvv' as root)
> 00:00.0 Host bridge: Intel Corporation Crystal Well DRAM Controller (rev 08)
>     Subsystem: Gigabyte Technology Co., Ltd Device 1456
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort+ >SERR- <PERR- INTx-
>     Latency: 0
>     Capabilities: [e0] Vendor Specific Information: Len=0c <?>
>
> 00:01.0 PCI bridge: Intel Corporation Crystal Well PCI Express x16
> Controller (rev 08) (prog-if 00 [Normal decode])
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 64 bytes
>     Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>     I/O behind bridge: 0000e000-0000efff
>     Memory behind bridge: f6000000-f70fffff
>     Prefetchable memory behind bridge: 00000000e0000000-00000000f1ffffff
>     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort+ <SERR- <PERR-
>     BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>     Capabilities: [88] Subsystem: Gigabyte Technology Co., Ltd Device 1456
>     Capabilities: [80] Power Management version 3
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
>         Address: fee002d8  Data: 0000
>     Capabilities: [a0] Express (v2) Root Port (Slot+), MSI 00
>         DevCap:    MaxPayload 256 bytes, PhantFunc 0
>             ExtTag- RBE+
>         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 256 bytes, MaxReadReq 128 bytes
>         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
>         LnkCap:    Port #2, Speed 8GT/s, Width x16, ASPM L0s L1, Exit
> Latency L0s <256ns, L1 <8us
>             ClockPM- Surprise- LLActRep- BwNot+
>         LnkCtl:    ASPM L0s L1 Enabled; RCB 64 bytes Disabled+ CommClk+
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 2.5GT/s, Width x16, TrErr- Train- SlotClk+
> DLActive- BWMgmt- ABWMgmt-
>         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
>             Slot #1, PowerLimit 75.000W; Interlock- NoCompl+
>         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
> HPIrq- LinkChg-
>             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
>             Changed: MRL- PresDet+ LinkState-
>         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
>         RootCap: CRSVisible-
>         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>         DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR+,
> OBFF Via WAKE# ARIFwd-
>         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-,
> OBFF Via WAKE# ARIFwd-
>         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
>              Transmit Margin: Normal Operating Range,
> EnterModifiedCompliance- ComplianceSOS-
>              Compliance De-emphasis: -6dB
>         LnkSta2: Current De-emphasis Level: -6dB,
> EqualizationComplete+, EqualizationPhase1+
>              EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest-
>     Capabilities: [100 v1] Virtual Channel
>         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
>         Arb:    Fixed- WRR32- WRR64- WRR128-
>         Ctrl:    ArbSelect=Fixed
>         Status:    InProgress-
>         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
>             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
>             Status:    NegoPending+ InProgress-
>     Capabilities: [140 v1] Root Complex Link
>         Desc:    PortNumber=02 ComponentID=01 EltType=Config
>         Link0:    Desc:    TargetPort=00 TargetComponent=01 AssocRCRB-
> LinkType=MemMapped LinkValid+
>             Addr:    00000000fed19000
>     Capabilities: [d94 v1] #19
>     Kernel driver in use: pcieport
>
> 00:02.0 VGA compatible controller: Intel Corporation Crystal Well
> Integrated Graphics Controller (rev 08) (prog-if 00 [VGA controller])
>     Subsystem: Gigabyte Technology Co., Ltd Device 1456
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin A routed to IRQ 37
>     Region 0: Memory at f7400000 (64-bit, non-prefetchable) [size=4M]
>     Region 2: Memory at d0000000 (64-bit, prefetchable) [size=256M]
>     Region 4: I/O ports at f000 [size=64]
>     Expansion ROM at <unassigned> [disabled]
>     Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
>         Address: fee00018  Data: 0000
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
> 00:03.0 Audio device: Intel Corporation Crystal Well HD Audio
> Controller (rev 08)
>     Subsystem: Intel Corporation Device 2010
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 64 bytes
>     Interrupt: pin A routed to IRQ 38
>     Region 0: Memory at f7b14000 (64-bit, non-prefetchable) [size=16K]
>     Capabilities: [50] Power Management version 2
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>         Status: D3 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit-
>         Address: fee004d8  Data: 0000
>     Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0
>             ExtTag- RBE-
>         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 128 bytes
>         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
>     Kernel driver in use: snd_hda_intel
>
> 00:14.0 USB controller: Intel Corporation 8 Series/C220 Series Chipset
> Family USB xHCI (rev 05) (prog-if 30 [XHCI])
>     Subsystem: Gigabyte Technology Co., Ltd Device 1456
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin A routed to IRQ 31
>     Region 0: Memory at f7b00000 (64-bit, non-prefetchable) [size=64K]
>     Capabilities: [70] Power Management version 2
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
> PME(D0-,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
>         Address: 00000000fee003d8  Data: 0000
>     Kernel driver in use: xhci_hcd
>
> 00:16.0 Communication controller: Intel Corporation 8 Series/C220
> Series Chipset Family MEI Controller #1 (rev 04)
>     Subsystem: Gigabyte Technology Co., Ltd Device 1456
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin A routed to IRQ 34
>     Region 0: Memory at f7b1e000 (64-bit, non-prefetchable) [size=16]
>     Capabilities: [50] Power Management version 3
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
>         Address: 00000000fee00458  Data: 0000
>     Kernel driver in use: mei_me
>
> 00:1a.0 USB controller: Intel Corporation 8 Series/C220 Series Chipset
> Family USB EHCI #2 (rev 05) (prog-if 20 [EHCI])
>     Subsystem: Gigabyte Technology Co., Ltd Device 1456
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin A routed to IRQ 16
>     Region 0: Memory at f7b1c000 (32-bit, non-prefetchable) [size=1K]
>     Capabilities: [50] Power Management version 2
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [58] Debug port: BAR=1 offset=00a0
>     Capabilities: [98] PCI Advanced Features
>         AFCap: TP+ FLR+
>         AFCtrl: FLR-
>         AFStatus: TP-
>     Kernel driver in use: ehci-pci
>
> 00:1b.0 Audio device: Intel Corporation 8 Series/C220 Series Chipset
> High Definition Audio Controller (rev 05)
>     Subsystem: Gigabyte Technology Co., Ltd Device 1456
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 64 bytes
>     Interrupt: pin A routed to IRQ 35
>     Region 0: Memory at f7b10000 (64-bit, non-prefetchable) [size=16K]
>     Capabilities: [50] Power Management version 2
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=0 PME-
>     Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
>         Address: 00000000fee00498  Data: 0000
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
>             Ctrl:    Enable+ ID=2 ArbSelect=Fixed TC/VC=04
>             Status:    NegoPending- InProgress-
>     Kernel driver in use: snd_hda_intel
>
> 00:1c.0 PCI bridge: Intel Corporation 8 Series/C220 Series Chipset
> Family PCI Express Root Port #1 (rev d5) (prog-if 00 [Normal decode])
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 64 bytes
>     Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
>     I/O behind bridge: 00002000-00002fff
>     Memory behind bridge: cf200000-cf3fffff
>     Prefetchable memory behind bridge: 00000000cf400000-00000000cf5fffff
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
>         LnkCap:    Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Exit
> Latency L0s <1us, L1 <4us
>             ClockPM- Surprise- LLActRep+ BwNot+
>         LnkCtl:    ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk-
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+
> DLActive- BWMgmt- ABWMgmt-
>         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
>             Slot #0, PowerLimit 0.000W; Interlock- NoCompl+
>         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt-
> HPIrq+ LinkChg+
>             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
>             Changed: MRL- PresDet- LinkState-
>         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
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
>     Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
>         Address: fee002f8  Data: 0000
>     Capabilities: [90] Subsystem: Gigabyte Technology Co., Ltd Device 1456
>     Capabilities: [a0] Power Management version 3
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Kernel driver in use: pcieport
>
> 00:1c.1 PCI bridge: Intel Corporation 8 Series/C220 Series Chipset
> Family PCI Express Root Port #2 (rev d5) (prog-if 00 [Normal decode])
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 64 bytes
>     Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
>     I/O behind bridge: 0000f000-00000fff
>     Memory behind bridge: f7a00000-f7afffff
>     Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
>     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- <SERR- <PERR-
>     BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>     Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0
>             ExtTag- RBE+
>         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 128 bytes
>         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
>         LnkCap:    Port #2, Speed 5GT/s, Width x1, ASPM L0s L1, Exit
> Latency L0s <512ns, L1 <16us
>             ClockPM- Surprise- LLActRep+ BwNot+
>         LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
> DLActive+ BWMgmt+ ABWMgmt-
>         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
>             Slot #1, PowerLimit 10.000W; Interlock- NoCompl+
>         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
> HPIrq- LinkChg-
>             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
>             Changed: MRL- PresDet- LinkState-
>         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
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
>     Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
>         Address: fee00338  Data: 0000
>     Capabilities: [90] Subsystem: Gigabyte Technology Co., Ltd Device 1456
>     Capabilities: [a0] Power Management version 3
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Kernel driver in use: pcieport
>
> 00:1c.2 PCI bridge: Intel Corporation 8 Series/C220 Series Chipset
> Family PCI Express Root Port #3 (rev d5) (prog-if 00 [Normal decode])
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 64 bytes
>     Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
>     I/O behind bridge: 0000d000-0000dfff
>     Memory behind bridge: f7900000-f79fffff
>     Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
>     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- <SERR- <PERR-
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
>         LnkCtl:    ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
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
>         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
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
>     Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
>         Address: fee00378  Data: 0000
>     Capabilities: [90] Subsystem: Gigabyte Technology Co., Ltd Device 1456
>     Capabilities: [a0] Power Management version 3
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Kernel driver in use: pcieport
>
> 00:1c.3 PCI bridge: Intel Corporation 8 Series/C220 Series Chipset
> Family PCI Express Root Port #4 (rev d5) (prog-if 00 [Normal decode])
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 64 bytes
>     Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
>     I/O behind bridge: 0000f000-00000fff
>     Memory behind bridge: f7800000-f78fffff
>     Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
>     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- <SERR- <PERR-
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
>         LnkCtl:    ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
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
>         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
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
>     Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
>         Address: fee003b8  Data: 0000
>     Capabilities: [90] Subsystem: Gigabyte Technology Co., Ltd Device 1456
>     Capabilities: [a0] Power Management version 3
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Kernel driver in use: pcieport
>
> 00:1d.0 USB controller: Intel Corporation 8 Series/C220 Series Chipset
> Family USB EHCI #1 (rev 05) (prog-if 20 [EHCI])
>     Subsystem: Gigabyte Technology Co., Ltd Device 1456
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin A routed to IRQ 23
>     Region 0: Memory at f7b1b000 (32-bit, non-prefetchable) [size=1K]
>     Capabilities: [50] Power Management version 2
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [58] Debug port: BAR=1 offset=00a0
>     Capabilities: [98] PCI Advanced Features
>         AFCap: TP+ FLR+
>         AFCtrl: FLR-
>         AFStatus: TP-
>     Kernel driver in use: ehci-pci
>
> 00:1f.0 ISA bridge: Intel Corporation HM87 Express LPC Controller (rev 05)
>     Subsystem: Gigabyte Technology Co., Ltd Device 1456
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Capabilities: [e0] Vendor Specific Information: Len=0c <?>
>     Kernel driver in use: lpc_ich
>
> 00:1f.2 SATA controller: Intel Corporation 8 Series/C220 Series
> Chipset Family 6-port SATA Controller 1 [AHCI mode] (rev 05) (prog-if
> 01 [AHCI 1.0])
>     Subsystem: Gigabyte Technology Co., Ltd Device 1456
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
>     Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin B routed to IRQ 33
>     Region 0: I/O ports at f0b0 [size=8]
>     Region 1: I/O ports at f0a0 [size=4]
>     Region 2: I/O ports at f090 [size=8]
>     Region 3: I/O ports at f080 [size=4]
>     Region 4: I/O ports at f060 [size=32]
>     Region 5: Memory at f7b1a000 (32-bit, non-prefetchable) [size=2K]
>     Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
>         Address: fee00438  Data: 0000
>     Capabilities: [70] Power Management version 3
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot+,D3cold-)
>         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
>     Kernel driver in use: ahci
>
> 00:1f.3 SMBus: Intel Corporation 8 Series/C220 Series Chipset Family
> SMBus Controller (rev 05)
>     Subsystem: Gigabyte Technology Co., Ltd Device 1456
>     Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Interrupt: pin C routed to IRQ 255
>     Region 0: Memory at f7b19000 (64-bit, non-prefetchable) [size=256]
>     Region 4: I/O ports at f040 [size=32]
>
> 00:1f.6 Signal processing controller: Intel Corporation 8 Series
> Chipset Family Thermal Management Controller (rev 05)
>     Subsystem: Gigabyte Technology Co., Ltd Device 1456
>     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Interrupt: pin C routed to IRQ 255
>     Region 0: Memory at f7b18000 (64-bit, non-prefetchable) [disabled] [size=4K]
>     Capabilities: [50] Power Management version 3
>         Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
>         Address: 00000000  Data: 0000
>
> 01:00.0 3D controller: NVIDIA Corporation GK104M [GeForce GTX 870M]
> (rev ff) (prog-if ff)
>     !!! Unknown header type 7f
>     Kernel driver in use: nouveau
>
> 03:00.0 Network controller: Intel Corporation Wireless 7260 (rev bb)
>     Subsystem: Intel Corporation Dual Band Wireless-AC 7260
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 64 bytes
>     Interrupt: pin A routed to IRQ 36
>     Region 0: Memory at f7a00000 (64-bit, non-prefetchable) [size=8K]
>     Capabilities: [c8] Power Management version 3
>         Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
>         Address: 00000000fee004b8  Data: 0000
>     Capabilities: [40] Express (v2) Endpoint, MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s
> <512ns, L1 unlimited
>             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
>         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr+ NoSnoop+ FLReset-
>             MaxPayload 128 bytes, MaxReadReq 128 bytes
>         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
>         LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
> Latency L0s <4us, L1 <32us
>             ClockPM+ Surprise- LLActRep- BwNot-
>         LnkCtl:    ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
>             ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
> DLActive- BWMgmt- ABWMgmt-
>         DevCap2: Completion Timeout: Range B, TimeoutDis+, LTR+, OBFF Via WAKE#
>         DevCtl2: Completion Timeout: 16ms to 55ms, TimeoutDis-, LTR+,
> OBFF Disabled
>         LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
>              Transmit Margin: Normal Operating Range,
> EnterModifiedCompliance- ComplianceSOS-
>              Compliance De-emphasis: -6dB
>         LnkSta2: Current De-emphasis Level: -3.5dB,
> EqualizationComplete-, EqualizationPhase1-
>              EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
>     Capabilities: [100 v1] Advanced Error Reporting
>         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
>         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>         AERCap:    First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
>     Capabilities: [140 v1] Device Serial Number f8-16-54-ff-ff-7d-7e-6d
>     Capabilities: [14c v1] Latency Tolerance Reporting
>         Max snoop latency: 71680ns
>         Max no snoop latency: 71680ns
>     Capabilities: [154 v1] Vendor Specific Information: ID=cafe Rev=1
> Len=014 <?>
>     Kernel driver in use: iwlwifi
>
> 04:00.0 Ethernet controller: Qualcomm Atheros Killer E220x Gigabit
> Ethernet Controller (rev 10)
>     Subsystem: Gigabyte Technology Co., Ltd Device 1456
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 64 bytes
>     Interrupt: pin A routed to IRQ 40
>     Region 0: Memory at f7900000 (64-bit, non-prefetchable) [size=256K]
>     Region 2: I/O ports at d000 [disabled] [size=128]
>     Capabilities: [40] Power Management version 3
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [58] Express (v1) Endpoint, MSI 00
>         DevCap:    MaxPayload 4096 bytes, PhantFunc 0, Latency L0s
> unlimited, L1 unlimited
>             ExtTag- AttnBtn+ AttnInd+ PwrInd+ RBE+ FLReset-
>         DevCtl:    Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 512 bytes
>         DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
>         LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
> Latency L0s unlimited, L1 unlimited
>             ClockPM+ Surprise- LLActRep- BwNot-
>         LnkCtl:    ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
>             ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
> DLActive- BWMgmt- ABWMgmt-
>     Capabilities: [c0] MSI: Enable+ Count=1/16 Maskable+ 64bit+
>         Address: 00000000fee00518  Data: 0000
>         Masking: 0000fffe  Pending: 00000000
>     Capabilities: [d8] MSI-X: Enable- Count=16 Masked-
>         Vector table: BAR=0 offset=00002000
>         PBA: BAR=0 offset=00003000
>     Capabilities: [100 v1] Advanced Error Reporting
>         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>         UESvrt:    DLP- SDES+ TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>         CESta:    RxErr- BadTLP+ BadDLLP+ Rollover+ Timeout+ NonFatalErr-
>         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>         AERCap:    First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
>     Capabilities: [180 v1] Device Serial Number ff-9b-c9-fc-f0-de-f1-ff
>     Kernel driver in use: alx
>
> 05:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd.
> RTS5227 PCI Express Card Reader (rev 01)
>     Subsystem: Realtek Semiconductor Co., Ltd. RTS5227 PCI Express Card Reader
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 64 bytes
>     Interrupt: pin A routed to IRQ 32
>     Region 0: Memory at f7800000 (32-bit, non-prefetchable) [size=4K]
>     Capabilities: [40] Power Management version 3
>         Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
> PME(D0-,D1+,D2+,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
>         Address: 00000000fee00418  Data: 0000
>     Capabilities: [70] Express (v2) Endpoint, MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s
> unlimited, L1 unlimited
>             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
>         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 512 bytes
>         DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
>         LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
> Latency L0s unlimited, L1 <64us
>             ClockPM+ Surprise- LLActRep- BwNot-
>         LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk-
>             ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
> DLActive- BWMgmt- ABWMgmt-
>         DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR+,
> OBFF Via message/WAKE#
>         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+,
> OBFF Disabled
>         LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
>              Transmit Margin: Normal Operating Range,
> EnterModifiedCompliance- ComplianceSOS-
>              Compliance De-emphasis: -6dB
>         LnkSta2: Current De-emphasis Level: -3.5dB,
> EqualizationComplete-, EqualizationPhase1-
>              EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
>     Capabilities: [100 v2] Advanced Error Reporting
>         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>         CESta:    RxErr+ BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
>         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>         AERCap:    First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
>     Capabilities: [140 v1] Device Serial Number 00-00-00-01-00-4c-e0-00
>     Capabilities: [150 v1] Latency Tolerance Reporting
>         Max snoop latency: 71680ns
>         Max no snoop latency: 71680ns
>     Capabilities: [158 v1] L1 PM Substates
>         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
> L1_PM_Substates+
>               PortCommonModeRestoreTime=60us PortTPowerOnTime=60us
>     Kernel driver in use: rtsx_pci
>
>
>
> [7.6.] SCSI information (from /proc/scsi/scsi)
> Attached devices:
> Host: scsi0 Channel: 00 Id: 00 Lun: 00
>   Vendor: ATA      Model: LITEONIT LGT-256 Rev: 001
>   Type:   Direct-Access                    ANSI  SCSI revision: 05
> Host: scsi1 Channel: 00 Id: 00 Lun: 00
>   Vendor: ATA      Model: LITEONIT LGT-256 Rev: 001
>   Type:   Direct-Access                    ANSI  SCSI revision: 05
>
>
> [7.7.] Other information that might be relevant to the problem (please
> look in /proc and include all information that you think to be
> relevant):
> ls /proc
> 1     1114  14    1549  185   19    20    2180  2437  2601  2672  2725
>  28    2920  3002  3153  3345  3452  38   45   53   59   67   72   777
>  845   asound     dma          kallsyms    meminfo       scsi
>  timer_list
> 10    1127  1488  1598  1856  190   200   219   2468  2607  2673  2744
>  2805  2921  3027  3198  3350  3477  39   46   54   60   676  73   778
>  846   buddyinfo  driver       kcore       misc          self
>  timer_stats
> 1011  1128  1493  1676  186   191   2017  22    2470  2612  2678  2783
>  2850  2928  3035  32    3356  3486  4    47   546  61   68   74   78
>  847   bus        execdomains  keys        modules       slabinfo
>  tty
> 102   1150  1494  1698  1869  192   202   220   25    2614  2680  2784
>  2856  2930  3037  3236  3381  3487  40   48   55   62   687  740  784
>  848   cgroups    fb           key-users   mounts        softirqs
>  uptime
> 103   1151  15    17    187   1921  203   221   2542  2619  2688  2785
>  2862  2944  3040  3239  3385  35    407  49   56   620  69   75   8
>  85    cmdline    filesystems  kmsg        mtrr          stat
>  version
> 1036  1156  1500  1758  1877  193   204   222   2544  2628  2689  2787
>  2882  2949  3042  3270  34    3542  41   5    560  63   691  751  81
>  86    consoles   fs           kpagecount  net           swaps
>  vmallocinfo
> 1069  12    1501  18    188   194   207   223   2558  2633  2692  2790
>  2897  2955  3055  3282  3402  36    42   50   561  639  7    76   814
>  9     cpuinfo    interrupts   kpageflags  pagetypeinfo  sys
>  vmstat
> 11    122   1506  182   1883  1942  21    2234  2568  2637  27    2791
>  2898  2981  31    33    342   3687  421  51   562  64   70   77   82
>  98    crypto     iomem        loadavg     partitions    sysrq-trigger
>  zoneinfo
> 1109  123   1516  183   1885  195   217   2285  2569  2646  2701  2792
>  29    2983  3103  3321  3421  3697  43   52   57   65   71   775  84
>  99    devices    ioports      locks       sched_debug   sysvipc
> 1111  13    1542  184   189   2     218   24    26    2648  2711  2793
>  2911  3     3130  3330  3422  37    44   524  572  66   716  776  844
>  acpi  diskstats  irq          mdstat      schedstat     thread-self
>
>
> [X.] Other notes, patches, fixes, workarounds:
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1387865
>
>
>
> With all due respect,
> Max
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
