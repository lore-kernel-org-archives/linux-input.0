From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: ASUS N550JK Touchpad recognized wrongly as PS/2 mouse
Date: Mon, 20 Oct 2014 11:38:23 -0400
Message-ID: <CAN+gG=E6c9eK51RxMQU_1tkxk08WtXfpSt7eyiz4fZqOd258OQ@mail.gmail.com>
References: <CAJ_4JbZWLXVRGwwuYnzoVvTOM-fUE4vb9jeZLQJ2LUD+fOhs-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52]:40363 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751273AbaJTPiZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Oct 2014 11:38:25 -0400
Received: by mail-qg0-f52.google.com with SMTP id q108so3704602qgd.11
        for <linux-input@vger.kernel.org>; Mon, 20 Oct 2014 08:38:24 -0700 (PDT)
In-Reply-To: <CAJ_4JbZWLXVRGwwuYnzoVvTOM-fUE4vb9jeZLQJ2LUD+fOhs-Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Carla Rosenfield <c.rosenfield@gmail.com>, Hans de Goede <hdegoede@redhat.com>
Cc: linux-input <linux-input@vger.kernel.org>

Hi Carla,

just FYI, I have the same laptop model than you, and can reproduce
your bug report in the same way. I'll work on that to make it working
properly.

Hans, (unfortunately,) this laptop has a ETD0105 touchpad from Elan.
That means that we do not have the X550 touchpad in house, but also
means that we should be able to get in working faster than the X550
one :)

Cheers,
Benjamin


On Tue, Oct 7, 2014 at 10:52 PM, Carla Rosenfield
<c.rosenfield@gmail.com> wrote:
> [1]
> [ASUS N550JK] Touchpad recognized wrongly as PS/2 mouse
>
> [2]
> The touchpad on my ASUS N550JK laptop is being recognized as a PS/2
> Logitech Wheel mouse, rather than as a touchpad. As such, I have not
> been able to turn on edge-scrolling or two-finger-scrolling. The
> touchpad does function as a simple mouse for moving the cursor and
> right- and left-clicking. Simply booting and logging into the GUI (I'm
> using XFCE) in the current upstream 3.17.0 generic amd64 kernel is
> sufficient to reproduce this bug.
>
> [3]
>
> [4]
> Linux version 3.17.0-031700-generic (apw@gomeisa) (gcc version 4.6.3
> (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201410060605 SMP Mon Oct 6 10:07:09
> UTC 2014
>
> [5]
>
> [6]
>
> [7]
> Description: Ubuntu 14.04.1 LTS
> Release: 14.04
>
>
> [7.1]
> Linux viror 3.17.0-031700-generic #201410060605 SMP Mon Oct 6 10:07:09
> UTC 2014 x86_64 x86_64 x86_64 GNU/Linux
>
> Gnu C                  4.8
> Gnu make               3.81
> binutils               2.24
> util-linux             2.20.1
> mount                  support
> module-init-tools      15
> e2fsprogs              1.42.9
> pcmciautils            018
> PPP                    2.4.5
> Linux C Library        2.19
> Dynamic linker (ldd)   2.19
> Procps                 3.3.9
> Net-tools              1.60
> Kbd                    1.15.5
> Sh-utils               8.21
> wireless-tools         30
> Modules Loaded         ctr ccm bbswitch arc4 dm_crypt iwlmvm mac80211
> rtsx_usb_ms memstick asus_nb_wmi asus_wmi intel_rapl sparse_keymap
> mxm_wmi x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm
> rfcomm bnep crct10dif_pclmul crc32_pclmul uvcvideo videobuf2_vmalloc
> videobuf2_memops videobuf2_core ghash_clmulni_intel v4l2_common
> aesni_intel videodev media hid_multitouch aes_x86_64 lrw joydev
> iwlwifi gf128mul btusb glue_helper ablk_helper serio_raw cryptd
> bluetooth rtc_efi cfg80211 lpc_ich wmi mac_hid binfmt_misc mei_me mei
> snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic
> snd_hda_intel snd_hda_controller snd_hda_codec snd_hwdep snd_pcm
> snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq snd_seq_device
> snd_timer snd ie31200_edac soundcore edac_core parport_pc ppdev lp
> parport nls_iso8859_1 rtsx_usb_sdmmc rtsx_usb hid_generic usbhid hid
> i915 i2c_algo_bit drm_kms_helper psmouse r8169 ahci drm libahci mii
> video
>
> [7.2]  processor : 0
> vendor_id : GenuineIntel
> cpu family : 6
> model : 60
> model name : Intel(R) Core(TM) i7-4710HQ CPU @ 2.50GHz
> stepping : 3
> microcode : 0x17
> cpu MHz : 2403.417
> cache size : 6144 KB
> physical id : 0
> siblings : 8
> core id : 0
> cpu cores : 4
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
> ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic
> movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm
> ida arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid
> fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt
> bugs :
> bogomips : 4988.73
> clflush size : 64
> cache_alignment : 64
> address sizes : 39 bits physical, 48 bits virtual
> power management:
>
> processor : 1
> vendor_id : GenuineIntel
> cpu family : 6
> model : 60
> model name : Intel(R) Core(TM) i7-4710HQ CPU @ 2.50GHz
> stepping : 3
> microcode : 0x17
> cpu MHz : 3058.496
> cache size : 6144 KB
> physical id : 0
> siblings : 8
> core id : 1
> cpu cores : 4
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
> ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic
> movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm
> ida arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid
> fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt
> bugs :
> bogomips : 4988.73
> clflush size : 64
> cache_alignment : 64
> address sizes : 39 bits physical, 48 bits virtual
> power management:
>
> processor : 2
> vendor_id : GenuineIntel
> cpu family : 6
> model : 60
> model name : Intel(R) Core(TM) i7-4710HQ CPU @ 2.50GHz
> stepping : 3
> microcode : 0x17
> cpu MHz : 3310.742
> cache size : 6144 KB
> physical id : 0
> siblings : 8
> core id : 2
> cpu cores : 4
> apicid : 4
> initial apicid : 4
> fpu : yes
> fpu_exception : yes
> cpuid level : 13
> wp : yes
> flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
> pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
> xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor
> ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic
> movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm
> ida arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid
> fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt
> bugs :
> bogomips : 4988.73
> clflush size : 64
> cache_alignment : 64
> address sizes : 39 bits physical, 48 bits virtual
> power management:
>
> processor : 3
> vendor_id : GenuineIntel
> cpu family : 6
> model : 60
> model name : Intel(R) Core(TM) i7-4710HQ CPU @ 2.50GHz
> stepping : 3
> microcode : 0x17
> cpu MHz : 3116.406
> cache size : 6144 KB
> physical id : 0
> siblings : 8
> core id : 3
> cpu cores : 4
> apicid : 6
> initial apicid : 6
> fpu : yes
> fpu_exception : yes
> cpuid level : 13
> wp : yes
> flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
> pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
> xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor
> ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic
> movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm
> ida arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid
> fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt
> bugs :
> bogomips : 4988.73
> clflush size : 64
> cache_alignment : 64
> address sizes : 39 bits physical, 48 bits virtual
> power management:
>
> processor : 4
> vendor_id : GenuineIntel
> cpu family : 6
> model : 60
> model name : Intel(R) Core(TM) i7-4710HQ CPU @ 2.50GHz
> stepping : 3
> microcode : 0x17
> cpu MHz : 3385.449
> cache size : 6144 KB
> physical id : 0
> siblings : 8
> core id : 0
> cpu cores : 4
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
> ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic
> movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm
> ida arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid
> fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt
> bugs :
> bogomips : 4988.73
> clflush size : 64
> cache_alignment : 64
> address sizes : 39 bits physical, 48 bits virtual
> power management:
>
> processor : 5
> vendor_id : GenuineIntel
> cpu family : 6
> model : 60
> model name : Intel(R) Core(TM) i7-4710HQ CPU @ 2.50GHz
> stepping : 3
> microcode : 0x17
> cpu MHz : 3310.839
> cache size : 6144 KB
> physical id : 0
> siblings : 8
> core id : 1
> cpu cores : 4
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
> ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic
> movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm
> ida arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid
> fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt
> bugs :
> bogomips : 4988.73
> clflush size : 64
> cache_alignment : 64
> address sizes : 39 bits physical, 48 bits virtual
> power management:
>
> processor : 6
> vendor_id : GenuineIntel
> cpu family : 6
> model : 60
> model name : Intel(R) Core(TM) i7-4710HQ CPU @ 2.50GHz
> stepping : 3
> microcode : 0x17
> cpu MHz : 3445.312
> cache size : 6144 KB
> physical id : 0
> siblings : 8
> core id : 2
> cpu cores : 4
> apicid : 5
> initial apicid : 5
> fpu : yes
> fpu_exception : yes
> cpuid level : 13
> wp : yes
> flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
> pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
> xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor
> ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic
> movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm
> ida arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid
> fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt
> bugs :
> bogomips : 4988.73
> clflush size : 64
> cache_alignment : 64
> address sizes : 39 bits physical, 48 bits virtual
> power management:
>
> processor : 7
> vendor_id : GenuineIntel
> cpu family : 6
> model : 60
> model name : Intel(R) Core(TM) i7-4710HQ CPU @ 2.50GHz
> stepping : 3
> microcode : 0x17
> cpu MHz : 3349.121
> cache size : 6144 KB
> physical id : 0
> siblings : 8
> core id : 3
> cpu cores : 4
> apicid : 7
> initial apicid : 7
> fpu : yes
> fpu_exception : yes
> cpuid level : 13
> wp : yes
> flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
> pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
> xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor
> ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic
> movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm
> ida arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid
> fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt
> bugs :
> bogomips : 4988.73
> clflush size : 64
> cache_alignment : 64
> address sizes : 39 bits physical, 48 bits virtual
> power management:
>
>
> [7.3]
> ctr 13193 3 - Live 0x0000000000000000
> ccm 17856 3 - Live 0x0000000000000000
> bbswitch 13943 0 - Live 0x0000000000000000 (OE)
> arc4 12573 2 - Live 0x0000000000000000
> dm_crypt 23456 0 - Live 0x0000000000000000
> iwlmvm 249097 0 - Live 0x0000000000000000
> mac80211 696913 1 iwlmvm, Live 0x0000000000000000
> rtsx_usb_ms 19050 0 - Live 0x0000000000000000
> memstick 16968 1 rtsx_usb_ms, Live 0x0000000000000000
> asus_nb_wmi 21128 0 - Live 0x0000000000000000
> asus_wmi 24697 1 asus_nb_wmi, Live 0x0000000000000000
> intel_rapl 19196 0 - Live 0x0000000000000000
> sparse_keymap 13890 1 asus_wmi, Live 0x0000000000000000
> mxm_wmi 13021 0 - Live 0x0000000000000000
> x86_pkg_temp_thermal 14312 0 - Live 0x0000000000000000
> intel_powerclamp 19099 0 - Live 0x0000000000000000
> coretemp 13638 0 - Live 0x0000000000000000
> kvm_intel 149257 0 - Live 0x0000000000000000
> kvm 468567 1 kvm_intel, Live 0x0000000000000000
> rfcomm 75114 12 - Live 0x0000000000000000
> bnep 19884 2 - Live 0x0000000000000000
> crct10dif_pclmul 14268 0 - Live 0x0000000000000000
> crc32_pclmul 13180 0 - Live 0x0000000000000000
> uvcvideo 86628 0 - Live 0x0000000000000000
> videobuf2_vmalloc 13216 1 uvcvideo, Live 0x0000000000000000
> videobuf2_memops 13362 1 videobuf2_vmalloc, Live 0x0000000000000000
> videobuf2_core 59907 1 uvcvideo, Live 0x0000000000000000
> ghash_clmulni_intel 13230 0 - Live 0x0000000000000000
> v4l2_common 15715 1 videobuf2_core, Live 0x0000000000000000
> aesni_intel 165469 96958 - Live 0x0000000000000000
> videodev 163831 3 uvcvideo,videobuf2_core,v4l2_common, Live 0x0000000000000000
> media 22008 2 uvcvideo,videodev, Live 0x0000000000000000
> hid_multitouch 17657 0 - Live 0x0000000000000000
> aes_x86_64 17131 1 aesni_intel, Live 0x0000000000000000
> lrw 13323 1 aesni_intel, Live 0x0000000000000000
> joydev 17587 0 - Live 0x0000000000000000
> iwlwifi 190863 1 iwlmvm, Live 0x0000000000000000
> gf128mul 14951 1 lrw, Live 0x0000000000000000
> btusb 32408 0 - Live 0x0000000000000000
> glue_helper 14095 1 aesni_intel, Live 0x0000000000000000
> ablk_helper 13597 1 aesni_intel, Live 0x0000000000000000
> serio_raw 13483 0 - Live 0x0000000000000000
> cryptd 20531 48478 ghash_clmulni_intel,aesni_intel,ablk_helper, Live
> 0x0000000000000000
> bluetooth 477455 22 rfcomm,bnep,btusb, Live 0x0000000000000000
> rtc_efi 12760 0 - Live 0x0000000000000000
> cfg80211 514757 3 iwlmvm,mac80211,iwlwifi, Live 0x0000000000000000
> lpc_ich 21176 0 - Live 0x0000000000000000
> wmi 19379 2 asus_wmi,mxm_wmi, Live 0x0000000000000000
> mac_hid 13275 0 - Live 0x0000000000000000
> binfmt_misc 17508 1 - Live 0x0000000000000000
> mei_me 19524 0 - Live 0x0000000000000000
> mei 88810 1 mei_me, Live 0x0000000000000000
> snd_hda_codec_hdmi 52620 1 - Live 0x0000000000000000
> snd_hda_codec_realtek 78564 1 - Live 0x0000000000000000
> snd_hda_codec_generic 70087 1 snd_hda_codec_realtek, Live 0x0000000000000000
> snd_hda_intel 30783 10 - Live 0x0000000000000000
> snd_hda_controller 32234 1 snd_hda_intel, Live 0x0000000000000000
> snd_hda_codec 145035 5
> snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_controller,
> Live 0x0000000000000000
> snd_hwdep 17709 1 snd_hda_codec, Live 0x0000000000000000
> snd_pcm 105052 4
> snd_hda_codec_hdmi,snd_hda_intel,snd_hda_controller,snd_hda_codec,
> Live 0x0000000000000000
> snd_seq_midi 13564 0 - Live 0x0000000000000000
> snd_seq_midi_event 14899 1 snd_seq_midi, Live 0x0000000000000000
> snd_rawmidi 31197 1 snd_seq_midi, Live 0x0000000000000000
> snd_seq 63540 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
> snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x0000000000000000
> snd_timer 30118 2 snd_pcm,snd_seq, Live 0x0000000000000000
> snd 84025 31 snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_seq_device,snd_timer,
> Live 0x0000000000000000
> ie31200_edac 12938 0 - Live 0x0000000000000000
> soundcore 15091 2 snd_hda_codec,snd, Live 0x0000000000000000
> edac_core 52405 1 ie31200_edac, Live 0x0000000000000000
> parport_pc 32906 0 - Live 0x0000000000000000
> ppdev 17711 0 - Live 0x0000000000000000
> lp 17799 0 - Live 0x0000000000000000
> parport 42481 3 parport_pc,ppdev,lp, Live 0x0000000000000000
> nls_iso8859_1 12713 1 - Live 0x0000000000000000
> rtsx_usb_sdmmc 28381 0 - Live 0x0000000000000000
> rtsx_usb 21330 2 rtsx_usb_ms,rtsx_usb_sdmmc, Live 0x0000000000000000
> hid_generic 12559 0 - Live 0x0000000000000000
> usbhid 53122 0 - Live 0x0000000000000000
> hid 110572 4 hid_multitouch,hid_generic,usbhid, Live 0x0000000000000000
> i915 993210 8 - Live 0x0000000000000000
> i2c_algo_bit 13564 1 i915, Live 0x0000000000000000
> drm_kms_helper 99872 1 i915, Live 0x0000000000000000
> psmouse 118039 0 - Live 0x0000000000000000
> r8169 77680 0 - Live 0x0000000000000000
> ahci 30167 3 - Live 0x0000000000000000
> drm 318542 7 i915,drm_kms_helper, Live 0x0000000000000000
> libahci 32533 1 ahci, Live 0x0000000000000000
> mii 13981 1 r8169, Live 0x0000000000000000
> video 20569 2 asus_wmi,i915, Live 0x0000000000000000
>
>
> [7.4]ctr 13193 3 - Live 0x0000000000000000
> ccm 17856 3 - Live 0x0000000000000000
> bbswitch 13943 0 - Live 0x0000000000000000 (OE)
> arc4 12573 2 - Live 0x0000000000000000
> dm_crypt 23456 0 - Live 0x0000000000000000
> iwlmvm 249097 0 - Live 0x0000000000000000
> mac80211 696913 1 iwlmvm, Live 0x0000000000000000
> rtsx_usb_ms 19050 0 - Live 0x0000000000000000
> memstick 16968 1 rtsx_usb_ms, Live 0x0000000000000000
> asus_nb_wmi 21128 0 - Live 0x0000000000000000
> asus_wmi 24697 1 asus_nb_wmi, Live 0x0000000000000000
> intel_rapl 19196 0 - Live 0x0000000000000000
> sparse_keymap 13890 1 asus_wmi, Live 0x0000000000000000
> mxm_wmi 13021 0 - Live 0x0000000000000000
> x86_pkg_temp_thermal 14312 0 - Live 0x0000000000000000
> intel_powerclamp 19099 0 - Live 0x0000000000000000
> coretemp 13638 0 - Live 0x0000000000000000
> kvm_intel 149257 0 - Live 0x0000000000000000
> kvm 468567 1 kvm_intel, Live 0x0000000000000000
> rfcomm 75114 12 - Live 0x0000000000000000
> bnep 19884 2 - Live 0x0000000000000000
> crct10dif_pclmul 14268 0 - Live 0x0000000000000000
> crc32_pclmul 13180 0 - Live 0x0000000000000000
> uvcvideo 86628 0 - Live 0x0000000000000000
> videobuf2_vmalloc 13216 1 uvcvideo, Live 0x0000000000000000
> videobuf2_memops 13362 1 videobuf2_vmalloc, Live 0x0000000000000000
> videobuf2_core 59907 1 uvcvideo, Live 0x0000000000000000
> ghash_clmulni_intel 13230 0 - Live 0x0000000000000000
> v4l2_common 15715 1 videobuf2_core, Live 0x0000000000000000
> aesni_intel 165469 96958 - Live 0x0000000000000000
> videodev 163831 3 uvcvideo,videobuf2_core,v4l2_common, Live 0x0000000000000000
> media 22008 2 uvcvideo,videodev, Live 0x0000000000000000
> hid_multitouch 17657 0 - Live 0x0000000000000000
> aes_x86_64 17131 1 aesni_intel, Live 0x0000000000000000
> lrw 13323 1 aesni_intel, Live 0x0000000000000000
> joydev 17587 0 - Live 0x0000000000000000
> iwlwifi 190863 1 iwlmvm, Live 0x0000000000000000
> gf128mul 14951 1 lrw, Live 0x0000000000000000
> btusb 32408 0 - Live 0x0000000000000000
> glue_helper 14095 1 aesni_intel, Live 0x0000000000000000
> ablk_helper 13597 1 aesni_intel, Live 0x0000000000000000
> serio_raw 13483 0 - Live 0x0000000000000000
> cryptd 20531 48478 ghash_clmulni_intel,aesni_intel,ablk_helper, Live
> 0x0000000000000000
> bluetooth 477455 22 rfcomm,bnep,btusb, Live 0x0000000000000000
> rtc_efi 12760 0 - Live 0x0000000000000000
> cfg80211 514757 3 iwlmvm,mac80211,iwlwifi, Live 0x0000000000000000
> lpc_ich 21176 0 - Live 0x0000000000000000
> wmi 19379 2 asus_wmi,mxm_wmi, Live 0x0000000000000000
> mac_hid 13275 0 - Live 0x0000000000000000
> binfmt_misc 17508 1 - Live 0x0000000000000000
> mei_me 19524 0 - Live 0x0000000000000000
> mei 88810 1 mei_me, Live 0x0000000000000000
> snd_hda_codec_hdmi 52620 1 - Live 0x0000000000000000
> snd_hda_codec_realtek 78564 1 - Live 0x0000000000000000
> snd_hda_codec_generic 70087 1 snd_hda_codec_realtek, Live 0x0000000000000000
> snd_hda_intel 30783 10 - Live 0x0000000000000000
> snd_hda_controller 32234 1 snd_hda_intel, Live 0x0000000000000000
> snd_hda_codec 145035 5
> snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_controller,
> Live 0x0000000000000000
> snd_hwdep 17709 1 snd_hda_codec, Live 0x0000000000000000
> snd_pcm 105052 4
> snd_hda_codec_hdmi,snd_hda_intel,snd_hda_controller,snd_hda_codec,
> Live 0x0000000000000000
> snd_seq_midi 13564 0 - Live 0x0000000000000000
> snd_seq_midi_event 14899 1 snd_seq_midi, Live 0x0000000000000000
> snd_rawmidi 31197 1 snd_seq_midi, Live 0x0000000000000000
> snd_seq 63540 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
> snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x0000000000000000
> snd_timer 30118 2 snd_pcm,snd_seq, Live 0x0000000000000000
> snd 84025 31 snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_seq_device,snd_timer,
> Live 0x0000000000000000
> ie31200_edac 12938 0 - Live 0x0000000000000000
> soundcore 15091 2 snd_hda_codec,snd, Live 0x0000000000000000
> edac_core 52405 1 ie31200_edac, Live 0x0000000000000000
> parport_pc 32906 0 - Live 0x0000000000000000
> ppdev 17711 0 - Live 0x0000000000000000
> lp 17799 0 - Live 0x0000000000000000
> parport 42481 3 parport_pc,ppdev,lp, Live 0x0000000000000000
> nls_iso8859_1 12713 1 - Live 0x0000000000000000
> rtsx_usb_sdmmc 28381 0 - Live 0x0000000000000000
> rtsx_usb 21330 2 rtsx_usb_ms,rtsx_usb_sdmmc, Live 0x0000000000000000
> hid_generic 12559 0 - Live 0x0000000000000000
> usbhid 53122 0 - Live 0x0000000000000000
> hid 110572 4 hid_multitouch,hid_generic,usbhid, Live 0x0000000000000000
> i915 993210 8 - Live 0x0000000000000000
> i2c_algo_bit 13564 1 i915, Live 0x0000000000000000
> drm_kms_helper 99872 1 i915, Live 0x0000000000000000
> psmouse 118039 0 - Live 0x0000000000000000
> r8169 77680 0 - Live 0x0000000000000000
> ahci 30167 3 - Live 0x0000000000000000
> drm 318542 7 i915,drm_kms_helper, Live 0x0000000000000000
> libahci 32533 1 ahci, Live 0x0000000000000000
> mii 13981 1 r8169, Live 0x0000000000000000
> video 20569 2 asus_wmi,i915, Live 0x0000000000000000
>
> carla@viror:~$ cat /proc/iomem
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
> 00100000-b9875fff : System RAM
>   02000000-027a9ab7 : Kernel code
>   027a9ab8-02d1e57f : Kernel data
>   02e80000-02fc6fff : Kernel bss
> b9876000-b987cfff : ACPI Non-volatile Storage
> b987d000-ba0e7fff : System RAM
> ba0e8000-ba373fff : reserved
> ba374000-c98dffff : System RAM
> c98e0000-c9af6fff : reserved
> c9af7000-c9e1bfff : System RAM
> c9e1c000-cab1efff : ACPI Non-volatile Storage
> cab1f000-caf58fff : reserved
> caf59000-caffefff : reserved
> cafff000-caffffff : System RAM
> cb000000-cbbfffff : RAM buffer
> cbc00000-cfdfffff : reserved
>   cbe00000-cfdfffff : Graphics Stolen Memory
> cfe00000-feafffff : PCI Bus 0000:00
>   cfe00000-cfffffff : PCI Bus 0000:03
>   d0000000-dfffffff : 0000:00:02.0
>   e0000000-f1ffffff : PCI Bus 0000:01
>     e0000000-efffffff : 0000:01:00.0
>     f0000000-f1ffffff : 0000:01:00.0
>   f2100000-f21fffff : PCI Bus 0000:05
>     f2100000-f2103fff : 0000:05:00.0
>       f2100000-f2103fff : r8169
>   f2200000-f23fffff : PCI Bus 0000:03
>   f2400000-f25fffff : PCI Bus 0000:02
>   f2600000-f27fffff : PCI Bus 0000:02
>   f2800000-f29fffff : PCI Bus 0000:04
>   f6000000-f70fffff : PCI Bus 0000:01
>     f6000000-f6ffffff : 0000:01:00.0
>     f7000000-f707ffff : 0000:01:00.0
>   f7400000-f77fffff : 0000:00:02.0
>   f7800000-f78fffff : PCI Bus 0000:05
>     f7800000-f7800fff : 0000:05:00.0
>       f7800000-f7800fff : r8169
>   f7900000-f79fffff : PCI Bus 0000:04
>     f7900000-f7901fff : 0000:04:00.0
>       f7900000-f7901fff : iwlwifi
>   f7a00000-f7a0ffff : 0000:00:14.0
>     f7a00000-f7a0ffff : xhci_hcd
>   f7a10000-f7a13fff : 0000:00:1b.0
>     f7a10000-f7a13fff : ICH HD audio
>   f7a14000-f7a17fff : 0000:00:03.0
>     f7a14000-f7a17fff : ICH HD audio
>   f7a19000-f7a190ff : 0000:00:1f.3
>   f7a1a000-f7a1a7ff : 0000:00:1f.2
>     f7a1a000-f7a1a7ff : ahci
>   f7a1b000-f7a1b3ff : 0000:00:1d.0
>     f7a1b000-f7a1b3ff : ehci_hcd
>   f7a1c000-f7a1c3ff : 0000:00:1a.0
>     f7a1c000-f7a1c3ff : ehci_hcd
>   f7a1e000-f7a1e00f : 0000:00:16.0
>     f7a1e000-f7a1e00f : mei_me
>   f7fdf000-f7fdffff : pnp 00:08
>   f7fe0000-f7feffff : pnp 00:08
>   f8000000-fbffffff : PCI MMCONFIG 0000 [bus 00-3f]
>     f8000000-fbffffff : reserved
>       f8000000-fbffffff : pnp 00:08
> fec00000-fec00fff : reserved
>   fec00000-fec003ff : IOAPIC 0
> fed00000-fed03fff : reserved
>   fed00000-fed003ff : HPET 0
>     fed00000-fed003ff : PNP0103:00
> fed10000-fed17fff : pnp 00:08
> fed18000-fed18fff : pnp 00:08
> fed19000-fed19fff : pnp 00:08
> fed1c000-fed1ffff : reserved
>   fed1c000-fed1ffff : pnp 00:08
>     fed1f410-fed1f414 : iTCO_wdt
> fed20000-fed3ffff : pnp 00:08
> fed40000-fed44fff : pnp 00:00
> fed45000-fed8ffff : pnp 00:08
> fed90000-fed90fff : dmar0
> fed91000-fed91fff : dmar1
> fee00000-fee00fff : Local APIC
>   fee00000-fee00fff : reserved
> ff000000-ffffffff : reserved
>   ff000000-ffffffff : INT0800:00
>     ff000000-ffffffff : pnp 00:08
> 100000000-42f1fffff : System RAM
> 42f200000-42fffffff : RAM buffer
>
>
> [7.5]
> 00:00.0 Host bridge: Intel Corporation Xeon E3-1200 v3/4th Gen Core
> Processor DRAM Controller (rev 06)
> Subsystem: ASUSTeK Computer Inc. Device 11cd
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort+ >SERR- <PERR- INTx-
> Latency: 0
> Capabilities: [e0] Vendor Specific Information: Len=0c <?>
>
> 00:01.0 PCI bridge: Intel Corporation Xeon E3-1200 v3/4th Gen Core
> Processor PCI Express x16 Controller (rev 06) (prog-if 00 [Normal
> decode])
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
> I/O behind bridge: 0000e000-0000efff
> Memory behind bridge: f6000000-f70fffff
> Prefetchable memory behind bridge: 00000000e0000000-00000000f1ffffff
> Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- <SERR- <PERR-
> BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> Capabilities: [88] Subsystem: ASUSTeK Computer Inc. Device 11cd
> Capabilities: [80] Power Management version 3
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
> Address: fee002d8  Data: 0000
> Capabilities: [a0] Express (v2) Root Port (Slot+), MSI 00
> DevCap: MaxPayload 256 bytes, PhantFunc 0
> ExtTag- RBE+
> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> MaxPayload 256 bytes, MaxReadReq 128 bytes
> DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
> LnkCap: Port #2, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s
> <256ns, L1 <8us
> ClockPM- Surprise- LLActRep- BwNot+
> LnkCtl: ASPM Disabled; RCB 64 bytes Disabled+ CommClk+
> ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> LnkSta: Speed 8GT/s, Width x16, TrErr- Train- SlotClk+ DLActive-
> BWMgmt+ ABWMgmt+
> SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
> Slot #1, PowerLimit 75.000W; Interlock- NoCompl+
> SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
> Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
> SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
> Changed: MRL- PresDet+ LinkState-
> RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
> RootCap: CRSVisible-
> RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR+, OBFF
> Via WAKE# ARIFwd-
> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Via
> WAKE# ARIFwd-
> LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
> Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
> Compliance De-emphasis: -6dB
> LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+,
> EqualizationPhase1+
> EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest-
> Capabilities: [100 v1] Virtual Channel
> Caps: LPEVC=0 RefClk=100ns PATEntryBits=1
> Arb: Fixed- WRR32- WRR64- WRR128-
> Ctrl: ArbSelect=Fixed
> Status: InProgress-
> VC0: Caps: PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
> Arb: Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
> Ctrl: Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
> Status: NegoPending+ InProgress-
> Capabilities: [140 v1] Root Complex Link
> Desc: PortNumber=02 ComponentID=01 EltType=Config
> Link0: Desc: TargetPort=00 TargetComponent=01 AssocRCRB-
> LinkType=MemMapped LinkValid+
> Addr: 00000000fed19000
> Capabilities: [d94 v1] #19
> Kernel driver in use: pcieport
>
> 00:02.0 VGA compatible controller: Intel Corporation 4th Gen Core
> Processor Integrated Graphics Controller (rev 06) (prog-if 00 [VGA
> controller])
> Subsystem: ASUSTeK Computer Inc. Device 11cd
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> Interrupt: pin A routed to IRQ 34
> Region 0: Memory at f7400000 (64-bit, non-prefetchable) [size=4M]
> Region 2: Memory at d0000000 (64-bit, prefetchable) [size=256M]
> Region 4: I/O ports at f000 [size=64]
> Expansion ROM at <unassigned> [disabled]
> Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
> Address: fee00018  Data: 0000
> Capabilities: [d0] Power Management version 2
> Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [a4] PCI Advanced Features
> AFCap: TP+ FLR+
> AFCtrl: FLR-
> AFStatus: TP-
> Kernel driver in use: i915
>
> 00:03.0 Audio device: Intel Corporation Xeon E3-1200 v3/4th Gen Core
> Processor HD Audio Controller (rev 06)
> Subsystem: Intel Corporation Device 2010
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Interrupt: pin A routed to IRQ 36
> Region 0: Memory at f7a14000 (64-bit, non-prefetchable) [size=16K]
> Capabilities: [50] Power Management version 2
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit-
> Address: fee00498  Data: 0000
> Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
> DevCap: MaxPayload 128 bytes, PhantFunc 0
> ExtTag- RBE-
> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> MaxPayload 128 bytes, MaxReadReq 128 bytes
> DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
> Kernel driver in use: snd_hda_intel
>
> 00:14.0 USB controller: Intel Corporation 8 Series/C220 Series Chipset
> Family USB xHCI (rev 05) (prog-if 30 [XHCI])
> Subsystem: ASUSTeK Computer Inc. Device 11cd
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> Interrupt: pin A routed to IRQ 31
> Region 0: Memory at f7a00000 (64-bit, non-prefetchable) [size=64K]
> Capabilities: [70] Power Management version 2
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
> Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
> Address: 00000000fee003f8  Data: 0000
> Kernel driver in use: xhci_hcd
>
> 00:16.0 Communication controller: Intel Corporation 8 Series/C220
> Series Chipset Family MEI Controller #1 (rev 04)
> Subsystem: ASUSTeK Computer Inc. Device 11cd
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> Interrupt: pin A routed to IRQ 35
> Region 0: Memory at f7a1e000 (64-bit, non-prefetchable) [size=16]
> Capabilities: [50] Power Management version 3
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
> Address: 00000000fee00478  Data: 0000
> Kernel driver in use: mei_me
>
> 00:1a.0 USB controller: Intel Corporation 8 Series/C220 Series Chipset
> Family USB EHCI #2 (rev 05) (prog-if 20 [EHCI])
> Subsystem: ASUSTeK Computer Inc. Device 11cd
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> Interrupt: pin A routed to IRQ 16
> Region 0: Memory at f7a1c000 (32-bit, non-prefetchable) [size=1K]
> Capabilities: [50] Power Management version 2
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [58] Debug port: BAR=1 offset=00a0
> Capabilities: [98] PCI Advanced Features
> AFCap: TP+ FLR+
> AFCtrl: FLR-
> AFStatus: TP-
> Kernel driver in use: ehci-pci
>
> 00:1b.0 Audio device: Intel Corporation 8 Series/C220 Series Chipset
> High Definition Audio Controller (rev 05)
> Subsystem: ASUSTeK Computer Inc. Device 11cd
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Interrupt: pin A routed to IRQ 37
> Region 0: Memory at f7a10000 (64-bit, non-prefetchable) [size=16K]
> Capabilities: [50] Power Management version 2
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
> Address: 00000000fee004b8  Data: 0000
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
> Ctrl: Enable+ ID=2 ArbSelect=Fixed TC/VC=04
> Status: NegoPending- InProgress-
> Kernel driver in use: snd_hda_intel
>
> 00:1c.0 PCI bridge: Intel Corporation 8 Series/C220 Series Chipset
> Family PCI Express Root Port #1 (rev d5) (prog-if 00 [Normal decode])
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
> I/O behind bridge: 0000f000-00000fff
> Memory behind bridge: fff00000-000fffff
> Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
> Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- <SERR- <PERR-
> BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> Capabilities: [40] Express (v2) Root Port (Slot-), MSI 00
> DevCap: MaxPayload 128 bytes, PhantFunc 0
> ExtTag- RBE+
> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> MaxPayload 128 bytes, MaxReadReq 128 bytes
> DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
> LnkCap: Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s
> <1us, L1 <4us
> ClockPM- Surprise- LLActRep+ BwNot+
> LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk-
> ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> LnkSta: Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive-
> BWMgmt- ABWMgmt-
> RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
> RootCap: CRSVisible-
> RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Via
> WAKE# ARIFwd-
> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF
> Disabled ARIFwd-
> LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
> Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
> Compliance De-emphasis: -6dB
> LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
> EqualizationPhase1-
> EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
> Address: fee002f8  Data: 0000
> Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 11cd
> Capabilities: [a0] Power Management version 3
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> Kernel driver in use: pcieport
>
> 00:1c.1 PCI bridge: Intel Corporation 8 Series/C220 Series Chipset
> Family PCI Express Root Port #2 (rev d5) (prog-if 00 [Normal decode])
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
> I/O behind bridge: 00002000-00002fff
> Memory behind bridge: cfe00000-cfffffff
> Prefetchable memory behind bridge: 00000000f2200000-00000000f23fffff
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
> LnkCap: Port #2, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s
> <1us, L1 <16us
> ClockPM- Surprise- LLActRep+ BwNot+
> LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk-
> ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> LnkSta: Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive-
> BWMgmt- ABWMgmt-
> SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
> Slot #1, PowerLimit 10.000W; Interlock- NoCompl+
> SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq+ LinkChg+
> Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
> SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
> Changed: MRL- PresDet- LinkState-
> RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
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
> Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
> Address: fee00338  Data: 0000
> Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 11cd
> Capabilities: [a0] Power Management version 3
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> Kernel driver in use: pcieport
>
> 00:1c.2 PCI bridge: Intel Corporation 8 Series/C220 Series Chipset
> Family PCI Express Root Port #3 (rev d5) (prog-if 00 [Normal decode])
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
> I/O behind bridge: 0000f000-00000fff
> Memory behind bridge: f7900000-f79fffff
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
> LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
> ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+
> BWMgmt+ ABWMgmt-
> SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
> Slot #2, PowerLimit 10.000W; Interlock- NoCompl+
> SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
> Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
> SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
> Changed: MRL- PresDet- LinkState+
> RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
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
> Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
> Address: fee00378  Data: 0000
> Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 11cd
> Capabilities: [a0] Power Management version 3
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> Kernel driver in use: pcieport
>
> 00:1c.3 PCI bridge: Intel Corporation 8 Series/C220 Series Chipset
> Family PCI Express Root Port #4 (rev d5) (prog-if 00 [Normal decode])
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
> I/O behind bridge: 0000d000-0000dfff
> Memory behind bridge: f7800000-f78fffff
> Prefetchable memory behind bridge: 00000000f2100000-00000000f21fffff
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
> LnkCap: Port #4, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s
> <512ns, L1 <16us
> ClockPM- Surprise- LLActRep+ BwNot+
> LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
> ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+
> BWMgmt+ ABWMgmt-
> SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
> Slot #3, PowerLimit 10.000W; Interlock- NoCompl+
> SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
> Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
> SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
> Changed: MRL- PresDet- LinkState+
> RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
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
> Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
> Address: fee003b8  Data: 0000
> Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 11cd
> Capabilities: [a0] Power Management version 3
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> Kernel driver in use: pcieport
>
> 00:1d.0 USB controller: Intel Corporation 8 Series/C220 Series Chipset
> Family USB EHCI #1 (rev 05) (prog-if 20 [EHCI])
> Subsystem: ASUSTeK Computer Inc. Device 11cd
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> Interrupt: pin A routed to IRQ 23
> Region 0: Memory at f7a1b000 (32-bit, non-prefetchable) [size=1K]
> Capabilities: [50] Power Management version 2
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [58] Debug port: BAR=1 offset=00a0
> Capabilities: [98] PCI Advanced Features
> AFCap: TP+ FLR+
> AFCtrl: FLR-
> AFStatus: TP-
> Kernel driver in use: ehci-pci
>
> 00:1f.0 ISA bridge: Intel Corporation HM86 Express LPC Controller (rev 05)
> Subsystem: ASUSTeK Computer Inc. Device 11cd
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> Capabilities: [e0] Vendor Specific Information: Len=0c <?>
> Kernel driver in use: lpc_ich
>
> 00:1f.2 SATA controller: Intel Corporation 8 Series/C220 Series
> Chipset Family 6-port SATA Controller 1 [AHCI mode] (rev 05) (prog-if
> 01 [AHCI 1.0])
> Subsystem: ASUSTeK Computer Inc. Device 11cd
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> Interrupt: pin B routed to IRQ 32
> Region 0: I/O ports at f0b0 [size=8]
> Region 1: I/O ports at f0a0 [size=4]
> Region 2: I/O ports at f090 [size=8]
> Region 3: I/O ports at f080 [size=4]
> Region 4: I/O ports at f060 [size=32]
> Region 5: Memory at f7a1a000 (32-bit, non-prefetchable) [size=2K]
> Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
> Address: fee00418  Data: 0000
> Capabilities: [70] Power Management version 3
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
> Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
> Kernel driver in use: ahci
>
> 00:1f.3 SMBus: Intel Corporation 8 Series/C220 Series Chipset Family
> SMBus Controller (rev 05)
> Subsystem: ASUSTeK Computer Inc. Device 11cd
> Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Interrupt: pin C routed to IRQ 255
> Region 0: Memory at f7a19000 (64-bit, non-prefetchable) [size=256]
> Region 4: I/O ports at f040 [size=32]
>
> 01:00.0 3D controller: NVIDIA Corporation GM107M [GeForce GTX 850M]
> (rev ff) (prog-if ff)
> !!! Unknown header type 7f
>
> 04:00.0 Network controller: Intel Corporation Wireless 7260 (rev 6b)
> Subsystem: Intel Corporation Dual Band Wireless-AC 7260
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Interrupt: pin A routed to IRQ 38
> Region 0: Memory at f7900000 (64-bit, non-prefetchable) [size=8K]
> Capabilities: [c8] Power Management version 3
> Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
> Address: 00000000fee004d8  Data: 0000
> Capabilities: [40] Express (v2) Endpoint, MSI 00
> DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 unlimited
> ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> RlxdOrd- ExtTag- PhantFunc- AuxPwr+ NoSnoop+ FLReset-
> MaxPayload 128 bytes, MaxReadReq 128 bytes
> DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
> LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency
> L0s <4us, L1 <32us
> ClockPM+ Surprise- LLActRep- BwNot-
> LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
> ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
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
> CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
> AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
> Capabilities: [140 v1] Device Serial Number f8-16-54-ff-ff-64-71-d4
> Capabilities: [14c v1] Latency Tolerance Reporting
> Max snoop latency: 71680ns
> Max no snoop latency: 71680ns
> Capabilities: [154 v1] Vendor Specific Information: ID=cafe Rev=1 Len=014 <?>
> Kernel driver in use: iwlwifi
>
> 05:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
> RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 0c)
> Subsystem: ASUSTeK Computer Inc. Device 200f
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Interrupt: pin A routed to IRQ 33
> Region 0: I/O ports at d000 [size=256]
> Region 2: Memory at f7800000 (64-bit, non-prefetchable) [size=4K]
> Region 4: Memory at f2100000 (64-bit, prefetchable) [size=16K]
> Capabilities: [40] Power Management version 3
> Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
> Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
> Address: 00000000fee00438  Data: 0000
> Capabilities: [70] Express (v2) Endpoint, MSI 01
> DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
> ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> MaxPayload 128 bytes, MaxReadReq 4096 bytes
> DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
> LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency
> L0s unlimited, L1 <64us
> ClockPM+ Surprise- LLActRep- BwNot-
> LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
> ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
> BWMgmt- ABWMgmt-
> DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR+, OBFF Via
> message/WAKE#
> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Disabled
> LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
> Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
> Compliance De-emphasis: -6dB
> LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
> EqualizationPhase1-
> EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> Capabilities: [b0] MSI-X: Enable- Count=4 Masked-
> Vector table: BAR=4 offset=00000000
> PBA: BAR=4 offset=00000800
> Capabilities: [d0] Vital Product Data
> Unknown small resource type 00, will not decode more.
> Capabilities: [100 v1] Advanced Error Reporting
> UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
> UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
> UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
> MalfTLP+ ECRC- UnsupReq- ACSViol-
> CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
> CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
> AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
> Capabilities: [140 v1] Virtual Channel
> Caps: LPEVC=0 RefClk=100ns PATEntryBits=1
> Arb: Fixed- WRR32- WRR64- WRR128-
> Ctrl: ArbSelect=Fixed
> Status: InProgress-
> VC0: Caps: PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
> Arb: Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
> Ctrl: Enable+ ID=0 ArbSelect=Fixed TC/VC=01
> Status: NegoPending- InProgress-
> Capabilities: [160 v1] Device Serial Number 14-17-43-36-68-4c-e0-00
> Capabilities: [170 v1] Latency Tolerance Reporting
> Max snoop latency: 71680ns
> Max no snoop latency: 71680ns
> Kernel driver in use: r8169
>
>
>
> [7.6]
> Attached devices:
> Host: scsi2 Channel: 00 Id: 00 Lun: 00
>   Vendor: MATSHITA Model: DVD-RAM UJ8E2 S  Rev: 1.00
>   Type:   CD-ROM                           ANSI  SCSI revision: 05
> Host: scsi4 Channel: 00 Id: 00 Lun: 00
>   Vendor: ATA      Model: SanDisk SD6SB1M2 Rev: 600
>   Type:   Direct-Access                    ANSI  SCSI revision: 05
>
>
> [7.7]
> 1     1681  1952  2096  3327  4345  4950  69   acpi         modules
> 10    17    1954  21    3328  4346  4984  7    asound       mounts
> 100   175   1958  2107  3329  4350  5     70   buddyinfo    mtrr
> 1024  176   196   2190  3330  4351  51    702  bus          net
> 1028  178   1963  22    34    4353  511   705  cgroups      pagetypeinfo
> 1034  179   1966  2207  3468  4372  514   708  cmdline      partitions
> 1035  1797  197   23    3476  4384  52    71   consoles     sched_debug
> 1038  18    1973  2339  36    4390  53    72   cpuinfo      schedstat
> 1072  180   1978  24    37    4394  530   724  crypto       scsi
> 1088  1802  1979  241   370   4398  531   725  devices      self
> 11    1808  1981  243   3773  44    54    73   diskstats    slabinfo
> 1111  181   1988  244   38    4402  55    74   dma          softirqs
> 1116  182   1990  245   3808  4406  56    75   driver       stat
> 119   183   1994  2482  384   4422  57    76   execdomains  swaps
> 12    1830  2     2491  3845  4452  579   771  fb           sys
> 120   1832  20    2493  3846  4498  58    78   filesystems  sysrq-trigger
> 1223  1834  2001  25    3847  4511  581   8    fs           sysvipc
> 1245  184   2011  2588  3849  46    585   80   interrupts   thread-self
> 1261  185   2012  2592  386   460   59    81   iomem        timer_list
> 1272  1855  2013  26    387   4605  60    815  ioports      timer_stats
> 1275  186   2026  27    388   461   606   82   irq          tty
> 1289  1865  2030  28    39    4612  61    846  kallsyms     uptime
> 13    1868  2034  280   41    4619  62    882  kcore        version
> 1303  1893  2035  29    4127  4631  63    889  keys         vmallocinfo
> 1319  1897  2037  3     4162  4632  632   9    key-users    vmstat
> 14    19    2038  31    4173  4676  64    927  kmsg         zoneinfo
> 1436  191   2039  3197  42    4690  65    935  kpagecount
> 1438  192   2042  32    422   47    655   94   kpageflags
> 1472  1924  2057  3206  4273  48    66    95   loadavg
> 15    1935  2067  3207  43    4848  67    954  locks
> 16    1938  2071  33    4335  49    672   959  mdstat
> 1632  1946  2077  3323  4342  4945  68    98   meminfo
> 1667  1950  2085  3326  4343  4949  681   99   misc
>
>
> [X.]
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1378547
>
> Hope I did that right and submitted to the right list. First time
> reporting a bug in an upstream kernel. Thanks for all your fantastic
> work making Linux usable for the moderately technical like me!
>
> Bug originator: Carla Rosenfield
> mailto: c.rosenfield@gmail.com
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
