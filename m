From: =?UTF-8?B?RGF2aWQgWmFmcmEgR8OzbWV6?= <dezeta@klo.es>
Subject: Re: PROBLEM: Touchpad works just like a mouse
Date: Sun, 26 Apr 2015 23:54:25 +0200
Message-ID: <553D5E91.2080704@klo.es>
References: <552C4E6C.4070102@klo.es>	<552F6AC9.6020005@klo.es> <CAN+gG=ENP5Uf06S1cdXKsGNmLDfGKOt3mP9iOeoxyqSzuDMoKA@mail.gmail.com> <55320164.5010905@klo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from llsa731-a03.servidoresdns.net ([82.223.190.25]:56061 "EHLO
	llsa731-a03.servidoresdns.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751008AbbDZVyh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 26 Apr 2015 17:54:37 -0400
In-Reply-To: <55320164.5010905@klo.es>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Duson Lin <dusonlin@emc.com.tw>, Jiri Kosina <jkosina@suse.cz>

Hi Benjamin and everybody.

I haven't received any notice of you. I'd like to know if there is any=20
chance for this issue to be solved. Are you taken it into your=20
consideration?

Thanks for your attention.

Cheers,

David Zafra

El 18/04/15 a las 09:01, David Zafra G=C3=B3mez escribi=C3=B3:
> Hi everybody again
>
> I've unplugged USB mouse and now I don't find this USB HID mouse when=
=20
> I run cat /proc/modules. Here is the complete output. I hope it will=20
> help.
>
> ctr 16384 2 - Live 0x0000000000000000
> ccm 20480 2 - Live 0x0000000000000000
> bnep 24576 2 - Live 0x0000000000000000
> rfcomm 77824 0 - Live 0x0000000000000000
> nls_iso8859_1 16384 1 - Live 0x0000000000000000
> intel_rapl 20480 0 - Live 0x0000000000000000
> iosf_mbi 16384 1 intel_rapl, Live 0x0000000000000000
> x86_pkg_temp_thermal 16384 0 - Live 0x0000000000000000
> intel_powerclamp 20480 0 - Live 0x0000000000000000
> coretemp 16384 0 - Live 0x0000000000000000
> kvm_intel 159744 0 - Live 0x0000000000000000
> kvm 512000 1 kvm_intel, Live 0x0000000000000000
> crct10dif_pclmul 16384 0 - Live 0x0000000000000000
> crc32_pclmul 16384 0 - Live 0x0000000000000000
> asus_nb_wmi 24576 0 - Live 0x0000000000000000
> ghash_clmulni_intel 16384 0 - Live 0x0000000000000000
> aesni_intel 172032 4 - Live 0x0000000000000000
> asus_wmi 28672 1 asus_nb_wmi, Live 0x0000000000000000
> aes_x86_64 20480 1 aesni_intel, Live 0x0000000000000000
> lrw 16384 1 aesni_intel, Live 0x0000000000000000
> gf128mul 16384 1 lrw, Live 0x0000000000000000
> glue_helper 16384 1 aesni_intel, Live 0x0000000000000000
> ablk_helper 16384 1 aesni_intel, Live 0x0000000000000000
> ath3k 16384 0 - Live 0x0000000000000000
> sparse_keymap 16384 1 asus_wmi, Live 0x0000000000000000
> arc4 16384 2 - Live 0x0000000000000000
> cryptd 24576 3 ghash_clmulni_intel,aesni_intel,ablk_helper, Live=20
> 0x0000000000000000
> ath9k 155648 0 - Live 0x0000000000000000
> ath9k_common 32768 1 ath9k, Live 0x0000000000000000
> ath9k_hw 487424 2 ath9k,ath9k_common, Live 0x0000000000000000
> ath 32768 3 ath9k,ath9k_common,ath9k_hw, Live 0x0000000000000000
> mac80211 774144 1 ath9k, Live 0x0000000000000000
> snd_hda_codec_hdmi 53248 1 - Live 0x0000000000000000
> btusb 45056 0 - Live 0x0000000000000000
> cfg80211 581632 4 ath9k,ath9k_common,ath,mac80211, Live=20
> 0x0000000000000000
> i915 1126400 5 - Live 0x0000000000000000
> dell_smo8800 16384 0 - Live 0x0000000000000000
> wmi 20480 1 asus_wmi, Live 0x0000000000000000
> bluetooth 524288 12 bnep,rfcomm,ath3k,btusb, Live 0x0000000000000000
> dw_dmac 16384 0 - Live 0x0000000000000000
> dw_dmac_core 28672 1 dw_dmac, Live 0x0000000000000000
> serio_raw 16384 0 - Live 0x0000000000000000
> snd_hda_codec_conexant 24576 1 - Live 0x0000000000000000
> snd_hda_codec_generic 73728 1 snd_hda_codec_conexant, Live=20
> 0x0000000000000000
> snd_hda_intel 32768 5 - Live 0x0000000000000000
> snd_soc_rt5640 94208 0 - Live 0x0000000000000000
> 8250_dw 16384 0 - Live 0x0000000000000000
> snd_soc_rl6231 16384 1 snd_soc_rt5640, Live 0x0000000000000000
> snd_hda_controller 36864 1 snd_hda_intel, Live 0x0000000000000000
> snd_hda_codec 147456 5=20
> snd_hda_codec_hdmi,snd_hda_codec_conexant,snd_hda_codec_generic,snd_h=
da_intel,snd_hda_controller,=20
> Live 0x0000000000000000
> snd_soc_core 200704 1 snd_soc_rt5640, Live 0x0000000000000000
> int3402_thermal 16384 0 - Live 0x0000000000000000
> snd_soc_sst_acpi 16384 0 - Live 0x0000000000000000
> i2c_hid 20480 0 - Live 0x0000000000000000
> mei_me 20480 0 - Live 0x0000000000000000
> video 28672 2 asus_wmi,i915, Live 0x0000000000000000
> snd_hwdep 16384 1 snd_hda_codec, Live 0x0000000000000000
> snd_seq_midi 16384 0 - Live 0x0000000000000000
> snd_seq_midi_event 16384 1 snd_seq_midi, Live 0x0000000000000000
> snd_rawmidi 32768 1 snd_seq_midi, Live 0x0000000000000000
> snd_compress 20480 1 snd_soc_core, Live 0x0000000000000000
> snd_pcm_dmaengine 16384 1 snd_soc_core, Live 0x0000000000000000
> snd_seq 69632 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000=
000
> hid 114688 1 i2c_hid, Live 0x0000000000000000
> spi_pxa2xx_platform 24576 0 - Live 0x0000000000000000
> snd_pcm 110592 7=20
> snd_hda_codec_hdmi,snd_hda_intel,snd_soc_rt5640,snd_hda_controller,sn=
d_hda_codec,snd_soc_core,snd_pcm_dmaengine,=20
> Live 0x0000000000000000
> drm_kms_helper 126976 1 i915, Live 0x0000000000000000
> drm 352256 6 i915,drm_kms_helper, Live 0x0000000000000000
> mei 90112 1 mei_me, Live 0x0000000000000000
> snd_seq_device 16384 3 snd_seq_midi,snd_rawmidi,snd_seq, Live=20
> 0x0000000000000000
> shpchp 40960 0 - Live 0x0000000000000000
> snd_timer 32768 2 snd_seq,snd_pcm, Live 0x0000000000000000
> parport_pc 36864 0 - Live 0x0000000000000000
> ppdev 20480 0 - Live 0x0000000000000000
> int3400_thermal 16384 0 - Live 0x0000000000000000
> acpi_thermal_rel 16384 1 int3400_thermal, Live 0x0000000000000000
> processor_thermal_device 16384 0 - Live 0x0000000000000000
> int340x_thermal_zone 16384 2 int3402_thermal,processor_thermal_device=
,=20
> Live 0x0000000000000000
> mac_hid 16384 0 - Live 0x0000000000000000
> i2c_designware_platform 16384 0 - Live 0x0000000000000000
> i2c_algo_bit 16384 1 i915, Live 0x0000000000000000
> i2c_designware_core 16384 1 i2c_designware_platform, Live=20
> 0x0000000000000000
> lpc_ich 24576 0 - Live 0x0000000000000000
> lp 20480 0 - Live 0x0000000000000000
> snd 86016 23=20
> snd_hda_codec_hdmi,snd_hda_codec_conexant,snd_hda_codec_generic,snd_h=
da_intel,snd_hda_codec,snd_soc_core,snd_hwdep,snd_rawmidi,snd_compress,=
snd_seq,snd_pcm,snd_seq_device,snd_timer,=20
> Live 0x0000000000000000
> parport 45056 3 parport_pc,ppdev,lp, Live 0x0000000000000000
> soundcore 16384 2 snd_hda_codec,snd, Live 0x0000000000000000
> ahci 36864 4 - Live 0x0000000000000000
> psmouse 126976 0 - Live 0x0000000000000000
> libahci 32768 1 ahci, Live 0x0000000000000000
> alx 45056 0 - Live 0x0000000000000000
> mdio 16384 1 alx, Live 0x0000000000000000
> sdhci_acpi 16384 0 - Live 0x0000000000000000
> sdhci 45056 1 sdhci_acpi, Live 0x0000000000000000
>
> Cheers,
>
> David Zafra
>
> El 16/04/15 a las 16:44, Benjamin Tissoires escribi=C3=B3:
>> Hi David,
>>
>> [Adding relevant people to the thread]
>>
>> according to the dmesg, there is a USB HID mouse (with Elan VID:PID
>> 04F3:0232) connected to your laptop.
>>
>> I just want to confirm that you did not plugged any external USB mou=
se
>> and that this one is your touchpad.
>>
>> If that's the case, we will need Duson's help.
>>
>> Duson, would it be possible that this USB touchpad can be activate
>> with the same-ish protocol than the i2c one we found in the Lenovo
>> Yoga 3?
>> If so, that would be in our best interest to fix all of that in HID.
>>
>> Cheers,
>> Benjamin
>>
>>
>> On Thu, Apr 16, 2015 at 3:54 AM, David Zafra G=C3=B3mez <dezeta@klo.=
es>=20
>> wrote:
>>> [1.] Touchpad works just like a mouse.
>>>
>>> [2.] Touchpad features like scrolling, tapping, etc. do not work at=
=20
>>> all.
>>> Also, I cannot disable touchpad, even if I try to do it using=20
>>> special key
>>> functions (fn) for notebooks. Touchpad multitouch gestures doesn't=20
>>> work.
>>> It's simple to reproduce. I just boot my Linux system and I try to=20
>>> use my
>>> touchpad. System doesn't recognize it as a touchpad 8 (I cannot ena=
ble
>>> touchpad functions).
>>> My notebook model is ASUSTeK COMPUTER INC. PU551LA.
>>>
>>> [3.]
>>>
>>> [4.] Linux version 4.0.0-040000-generic (kernel@gomeisa) (gcc=20
>>> version 4.6.3
>>> (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201504121935 SMP Sun Apr 12=20
>>> 23:36:33 UTC
>>> 2015
>>>
>>> [5.]
>>>
>>> [6.]
>>>
>>> [7.] Description:    Ubuntu 14.04.2 LTS
>>> Release:    14.04
>>>
>>> [7.1.]
>>> Linux tago 4.0.0-040000-generic #201504121935 SMP Sun Apr 12=20
>>> 23:36:33 UTC
>>> 2015 x86_64 x86_64 x86_64 GNU/Linux
>>>
>>> Gnu C                  4.8
>>> Gnu make               3.81
>>> binutils               2.24
>>> util-linux             2.20.1
>>> mount                  support
>>> module-init-tools      15
>>> e2fsprogs              1.42.9
>>> pcmciautils            018
>>> PPP                    2.4.5
>>> Linux C Library        2.19
>>> Dynamic linker (ldd)   2.19
>>> Procps                 3.3.9
>>> Net-tools              1.60
>>> Kbd                    1.15.5
>>> Sh-utils               8.21
>>> wireless-tools         30
>>> Modules Loaded         rfcomm bnep nls_iso8859_1 intel_rapl iosf_mb=
i
>>> x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm
>>> crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel=20
>>> aes_x86_64 lrw
>>> gf128mul glue_helper ablk_helper snd_soc_rt5640 snd_hda_codec_hdmi
>>> snd_hda_codec_conexant snd_hda_codec_generic asus_nb_wmi asus_wmi
>>> snd_hda_intel sparse_keymap snd_hda_controller snd_soc_rl6231=20
>>> snd_soc_core
>>> snd_hda_codec cryptd snd_hwdep arc4 snd_compress snd_pcm_dmaengine=20
>>> ath9k
>>> ath9k_common ath9k_hw ath mac80211 cfg80211 snd_pcm dw_dmac=20
>>> snd_seq_midi
>>> ath3k i915 btusb dell_smo8800 wmi snd_seq_midi_event dw_dmac_core=20
>>> serio_raw
>>> snd_rawmidi drm_kms_helper bluetooth drm snd_seq shpchp parport_pc
>>> snd_soc_sst_acpi snd_seq_device ppdev 8250_dw video int3400_thermal
>>> int3402_thermal lp i2c_algo_bit i2c_hid snd_timer mei_me parport me=
i
>>> spi_pxa2xx_platform snd lpc_ich processor_thermal_device=20
>>> acpi_thermal_rel
>>> int340x_thermal_zone i2c_designware_platform soundcore=20
>>> i2c_designware_core
>>> mac_hid hid_generic usbhid hid ahci psmouse alx libahci mdio sdhci_=
acpi
>>> sdhci
>>>
>>> [7.2]
>>> processor    : 0
>>> vendor_id    : GenuineIntel
>>> cpu family    : 6
>>> model        : 69
>>> model name    : Intel(R) Core(TM) i5-4200U CPU @ 1.60GHz
>>> stepping    : 1
>>> microcode    : 0x17
>>> cpu MHz        : 806.527
>>> cache size    : 3072 KB
>>> physical id    : 0
>>> siblings    : 4
>>> core id        : 0
>>> cpu cores    : 2
>>> apicid        : 0
>>> initial apicid    : 0
>>> fpu        : yes
>>> fpu_exception    : yes
>>> cpuid level    : 13
>>> wp        : yes
>>> flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge=
=20
>>> mca cmov
>>> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall n=
x=20
>>> pdpe1gb
>>> rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopolog=
y
>>> nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl=
=20
>>> vmx est
>>> tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 movbe popcnt
>>> tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm ida arat=20
>>> epb pln
>>> pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjus=
t=20
>>> bmi1
>>> avx2 smep bmi2 erms invpcid xsaveopt
>>> bugs        :
>>> bogomips    : 4589.39
>>> clflush size    : 64
>>> cache_alignment    : 64
>>> address sizes    : 39 bits physical, 48 bits virtual
>>> power management:
>>>
>>> processor    : 1
>>> vendor_id    : GenuineIntel
>>> cpu family    : 6
>>> model        : 69
>>> model name    : Intel(R) Core(TM) i5-4200U CPU @ 1.60GHz
>>> stepping    : 1
>>> microcode    : 0x17
>>> cpu MHz        : 799.968
>>> cache size    : 3072 KB
>>> physical id    : 0
>>> siblings    : 4
>>> core id        : 1
>>> cpu cores    : 2
>>> apicid        : 2
>>> initial apicid    : 2
>>> fpu        : yes
>>> fpu_exception    : yes
>>> cpuid level    : 13
>>> wp        : yes
>>> flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge=
=20
>>> mca cmov
>>> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall n=
x=20
>>> pdpe1gb
>>> rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopolog=
y
>>> nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl=
=20
>>> vmx est
>>> tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 movbe popcnt
>>> tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm ida arat=20
>>> epb pln
>>> pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjus=
t=20
>>> bmi1
>>> avx2 smep bmi2 erms invpcid xsaveopt
>>> bugs        :
>>> bogomips    : 4589.39
>>> clflush size    : 64
>>> cache_alignment    : 64
>>> address sizes    : 39 bits physical, 48 bits virtual
>>> power management:
>>>
>>> processor    : 2
>>> vendor_id    : GenuineIntel
>>> cpu family    : 6
>>> model        : 69
>>> model name    : Intel(R) Core(TM) i5-4200U CPU @ 1.60GHz
>>> stepping    : 1
>>> microcode    : 0x17
>>> cpu MHz        : 869.957
>>> cache size    : 3072 KB
>>> physical id    : 0
>>> siblings    : 4
>>> core id        : 0
>>> cpu cores    : 2
>>> apicid        : 1
>>> initial apicid    : 1
>>> fpu        : yes
>>> fpu_exception    : yes
>>> cpuid level    : 13
>>> wp        : yes
>>> flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge=
=20
>>> mca cmov
>>> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall n=
x=20
>>> pdpe1gb
>>> rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopolog=
y
>>> nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl=
=20
>>> vmx est
>>> tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 movbe popcnt
>>> tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm ida arat=20
>>> epb pln
>>> pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjus=
t=20
>>> bmi1
>>> avx2 smep bmi2 erms invpcid xsaveopt
>>> bugs        :
>>> bogomips    : 4589.39
>>> clflush size    : 64
>>> cache_alignment    : 64
>>> address sizes    : 39 bits physical, 48 bits virtual
>>> power management:
>>>
>>> processor    : 3
>>> vendor_id    : GenuineIntel
>>> cpu family    : 6
>>> model        : 69
>>> model name    : Intel(R) Core(TM) i5-4200U CPU @ 1.60GHz
>>> stepping    : 1
>>> microcode    : 0x17
>>> cpu MHz        : 884.062
>>> cache size    : 3072 KB
>>> physical id    : 0
>>> siblings    : 4
>>> core id        : 1
>>> cpu cores    : 2
>>> apicid        : 3
>>> initial apicid    : 3
>>> fpu        : yes
>>> fpu_exception    : yes
>>> cpuid level    : 13
>>> wp        : yes
>>> flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge=
=20
>>> mca cmov
>>> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall n=
x=20
>>> pdpe1gb
>>> rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopolog=
y
>>> nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl=
=20
>>> vmx est
>>> tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 movbe popcnt
>>> tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm ida arat=20
>>> epb pln
>>> pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjus=
t=20
>>> bmi1
>>> avx2 smep bmi2 erms invpcid xsaveopt
>>> bugs        :
>>> bogomips    : 4589.39
>>> clflush size    : 64
>>> cache_alignment    : 64
>>> address sizes    : 39 bits physical, 48 bits virtual
>>> power management:
>>>
>>> [7.3.]
>>> rfcomm 77824 0 - Live 0x0000000000000000
>>> bnep 24576 2 - Live 0x0000000000000000
>>> nls_iso8859_1 16384 1 - Live 0x0000000000000000
>>> intel_rapl 20480 0 - Live 0x0000000000000000
>>> iosf_mbi 16384 1 intel_rapl, Live 0x0000000000000000
>>> x86_pkg_temp_thermal 16384 0 - Live 0x0000000000000000
>>> intel_powerclamp 20480 0 - Live 0x0000000000000000
>>> coretemp 16384 0 - Live 0x0000000000000000
>>> kvm_intel 159744 0 - Live 0x0000000000000000
>>> kvm 512000 1 kvm_intel, Live 0x0000000000000000
>>> crct10dif_pclmul 16384 0 - Live 0x0000000000000000
>>> crc32_pclmul 16384 0 - Live 0x0000000000000000
>>> ghash_clmulni_intel 16384 0 - Live 0x0000000000000000
>>> aesni_intel 172032 0 - Live 0x0000000000000000
>>> aes_x86_64 20480 1 aesni_intel, Live 0x0000000000000000
>>> lrw 16384 1 aesni_intel, Live 0x0000000000000000
>>> gf128mul 16384 1 lrw, Live 0x0000000000000000
>>> glue_helper 16384 1 aesni_intel, Live 0x0000000000000000
>>> ablk_helper 16384 1 aesni_intel, Live 0x0000000000000000
>>> snd_soc_rt5640 94208 0 - Live 0x0000000000000000
>>> snd_hda_codec_hdmi 53248 1 - Live 0x0000000000000000
>>> snd_hda_codec_conexant 24576 1 - Live 0x0000000000000000
>>> snd_hda_codec_generic 73728 1 snd_hda_codec_conexant, Live
>>> 0x0000000000000000
>>> asus_nb_wmi 24576 0 - Live 0x0000000000000000
>>> asus_wmi 28672 1 asus_nb_wmi, Live 0x0000000000000000
>>> snd_hda_intel 32768 5 - Live 0x0000000000000000
>>> sparse_keymap 16384 1 asus_wmi, Live 0x0000000000000000
>>> snd_hda_controller 36864 1 snd_hda_intel, Live 0x0000000000000000
>>> snd_soc_rl6231 16384 1 snd_soc_rt5640, Live 0x0000000000000000
>>> snd_soc_core 200704 1 snd_soc_rt5640, Live 0x0000000000000000
>>> snd_hda_codec 147456 5
>>> snd_hda_codec_hdmi,snd_hda_codec_conexant,snd_hda_codec_generic,snd=
_hda_intel,snd_hda_controller,=20
>>>
>>> Live 0x0000000000000000
>>> cryptd 24576 3 ghash_clmulni_intel,aesni_intel,ablk_helper, Live
>>> 0x0000000000000000
>>> snd_hwdep 16384 1 snd_hda_codec, Live 0x0000000000000000
>>> arc4 16384 2 - Live 0x0000000000000000
>>> snd_compress 20480 1 snd_soc_core, Live 0x0000000000000000
>>> snd_pcm_dmaengine 16384 1 snd_soc_core, Live 0x0000000000000000
>>> ath9k 155648 0 - Live 0x0000000000000000
>>> ath9k_common 32768 1 ath9k, Live 0x0000000000000000
>>> ath9k_hw 487424 2 ath9k,ath9k_common, Live 0x0000000000000000
>>> ath 32768 3 ath9k,ath9k_common,ath9k_hw, Live 0x0000000000000000
>>> mac80211 774144 1 ath9k, Live 0x0000000000000000
>>> cfg80211 581632 4 ath9k,ath9k_common,ath,mac80211, Live=20
>>> 0x0000000000000000
>>> snd_pcm 110592 7
>>> snd_soc_rt5640,snd_hda_codec_hdmi,snd_hda_intel,snd_hda_controller,=
snd_soc_core,snd_hda_codec,snd_pcm_dmaengine,=20
>>>
>>> Live 0x0000000000000000
>>> dw_dmac 16384 0 - Live 0x0000000000000000
>>> snd_seq_midi 16384 0 - Live 0x0000000000000000
>>> ath3k 16384 0 - Live 0x0000000000000000
>>> i915 1126400 5 - Live 0x0000000000000000
>>> btusb 45056 0 - Live 0x0000000000000000
>>> dell_smo8800 16384 0 - Live 0x0000000000000000
>>> wmi 20480 1 asus_wmi, Live 0x0000000000000000
>>> snd_seq_midi_event 16384 1 snd_seq_midi, Live 0x0000000000000000
>>> dw_dmac_core 28672 1 dw_dmac, Live 0x0000000000000000
>>> serio_raw 16384 0 - Live 0x0000000000000000
>>> snd_rawmidi 32768 1 snd_seq_midi, Live 0x0000000000000000
>>> drm_kms_helper 126976 1 i915, Live 0x0000000000000000
>>> bluetooth 524288 12 rfcomm,bnep,ath3k,btusb, Live 0x000000000000000=
0
>>> drm 352256 6 i915,drm_kms_helper, Live 0x0000000000000000
>>> snd_seq 69632 2 snd_seq_midi,snd_seq_midi_event, Live=20
>>> 0x0000000000000000
>>> shpchp 40960 0 - Live 0x0000000000000000
>>> parport_pc 36864 0 - Live 0x0000000000000000
>>> snd_soc_sst_acpi 16384 0 - Live 0x0000000000000000
>>> snd_seq_device 16384 3 snd_seq_midi,snd_rawmidi,snd_seq, Live
>>> 0x0000000000000000
>>> ppdev 20480 0 - Live 0x0000000000000000
>>> 8250_dw 16384 0 - Live 0x0000000000000000
>>> video 28672 2 asus_wmi,i915, Live 0x0000000000000000
>>> int3400_thermal 16384 0 - Live 0x0000000000000000
>>> int3402_thermal 16384 0 - Live 0x0000000000000000
>>> lp 20480 0 - Live 0x0000000000000000
>>> i2c_algo_bit 16384 1 i915, Live 0x0000000000000000
>>> i2c_hid 20480 0 - Live 0x0000000000000000
>>> snd_timer 32768 2 snd_pcm,snd_seq, Live 0x0000000000000000
>>> mei_me 20480 0 - Live 0x0000000000000000
>>> parport 45056 3 parport_pc,ppdev,lp, Live 0x0000000000000000
>>> mei 90112 1 mei_me, Live 0x0000000000000000
>>> spi_pxa2xx_platform 24576 0 - Live 0x0000000000000000
>>> snd 86016 23
>>> snd_hda_codec_hdmi,snd_hda_codec_conexant,snd_hda_codec_generic,snd=
_hda_intel,snd_soc_core,snd_hda_codec,snd_hwdep,snd_compress,snd_pcm,sn=
d_rawmidi,snd_seq,snd_seq_device,snd_timer,=20
>>>
>>> Live 0x0000000000000000
>>> lpc_ich 24576 0 - Live 0x0000000000000000
>>> processor_thermal_device 16384 0 - Live 0x0000000000000000
>>> acpi_thermal_rel 16384 1 int3400_thermal, Live 0x0000000000000000
>>> int340x_thermal_zone 16384 2=20
>>> int3402_thermal,processor_thermal_device, Live
>>> 0x0000000000000000
>>> i2c_designware_platform 16384 0 - Live 0x0000000000000000
>>> soundcore 16384 2 snd_hda_codec,snd, Live 0x0000000000000000
>>> i2c_designware_core 16384 1 i2c_designware_platform, Live=20
>>> 0x0000000000000000
>>> mac_hid 16384 0 - Live 0x0000000000000000
>>> hid_generic 16384 0 - Live 0x0000000000000000
>>> usbhid 53248 0 - Live 0x0000000000000000
>>> hid 114688 3 i2c_hid,hid_generic,usbhid, Live 0x0000000000000000
>>> ahci 36864 4 - Live 0x0000000000000000
>>> psmouse 126976 0 - Live 0x0000000000000000
>>> alx 45056 0 - Live 0x0000000000000000
>>> libahci 32768 1 ahci, Live 0x0000000000000000
>>> mdio 16384 1 alx, Live 0x0000000000000000
>>> sdhci_acpi 16384 0 - Live 0x0000000000000000
>>> sdhci 45056 1 sdhci_acpi, Live 0x0000000000000000
>>>
>>> [7.4.]
>>> 0000-0cf7 : PCI Bus 0000:00
>>>    0000-001f : dma1
>>>    0020-0021 : pic1
>>>    0040-0043 : timer0
>>>    0050-0053 : timer1
>>>    0060-0060 : keyboard
>>>    0062-0062 : PNP0C09:00
>>>      0062-0062 : EC data
>>>    0064-0064 : keyboard
>>>    0066-0066 : PNP0C09:00
>>>      0066-0066 : EC cmd
>>>    0070-0077 : rtc0
>>>    0080-008f : dma page reg
>>>    00a0-00a1 : pic2
>>>    00c0-00df : dma2
>>>    00f0-00ff : fpu
>>>    0240-0259 : pnp 00:05
>>>    04d0-04d1 : pnp 00:04
>>>    0680-069f : pnp 00:01
>>> 0cf8-0cff : PCI conf1
>>> 0d00-ffff : PCI Bus 0000:00
>>>    164e-164f : pnp 00:01
>>>    1800-1803 : ACPI PM1a_EVT_BLK
>>>    1804-1805 : ACPI PM1a_CNT_BLK
>>>    1808-180b : ACPI PM_TMR
>>>    1810-1815 : ACPI CPU throttle
>>>    1830-1833 : iTCO_wdt
>>>    1850-1850 : ACPI PM2_CNT_BLK
>>>    1854-1857 : pnp 00:03
>>>    1860-187f : iTCO_wdt
>>>    1880-189f : ACPI GPE0_BLK
>>>    1c00-1cfe : pnp 00:01
>>>    1d00-1dfe : pnp 00:01
>>>    1e00-1efe : pnp 00:01
>>>    1f00-1ffe : pnp 00:01
>>>    2000-2fff : PCI Bus 0000:02
>>>    e000-efff : PCI Bus 0000:03
>>>      e000-e07f : 0000:03:00.0
>>>    f000-f03f : 0000:00:02.0
>>>    f040-f05f : 0000:00:1f.3
>>>    f060-f07f : 0000:00:1f.2
>>>      f060-f07f : ahci
>>>    f080-f083 : 0000:00:1f.2
>>>      f080-f083 : ahci
>>>    f090-f097 : 0000:00:1f.2
>>>      f090-f097 : ahci
>>>    f0a0-f0a3 : 0000:00:1f.2
>>>      f0a0-f0a3 : ahci
>>>    f0b0-f0b7 : 0000:00:1f.2
>>>      f0b0-f0b7 : ahci
>>>    ffff-ffff : pnp 00:01
>>>      ffff-ffff : pnp 00:01
>>>        ffff-ffff : pnp 00:01
>>>
>>> 00000000-00000fff : reserved
>>> 00001000-00057fff : System RAM
>>> 00058000-00058fff : reserved
>>> 00059000-0009efff : System RAM
>>> 0009f000-0009ffff : reserved
>>> 000a0000-000bffff : PCI Bus 0000:00
>>> 000c0000-000cebff : Video ROM
>>> 000d0000-000d3fff : PCI Bus 0000:00
>>> 000d4000-000d7fff : PCI Bus 0000:00
>>> 000d8000-000dbfff : PCI Bus 0000:00
>>> 000dc000-000dffff : PCI Bus 0000:00
>>> 000f0000-000fffff : System ROM
>>> 00100000-c8904fff : System RAM
>>>    02000000-027f524d : Kernel code
>>>    027f524e-02d1c63f : Kernel data
>>>    02e89000-02fcbfff : Kernel bss
>>> c8905000-c890bfff : ACPI Non-volatile Storage
>>> c890c000-c91d4fff : System RAM
>>> c91d5000-c947bfff : reserved
>>> c947c000-d9727fff : System RAM
>>> d9728000-d9987fff : reserved
>>> d9988000-d9cadfff : System RAM
>>> d9cae000-da9b9fff : ACPI Non-volatile Storage
>>> da9ba000-daf59fff : reserved
>>> daf5a000-daffefff : reserved
>>> dafff000-daffffff : System RAM
>>> db000000-dbbfffff : RAM buffer
>>> dbc00000-dfdfffff : reserved
>>>    dbe00000-dfdfffff : Graphics Stolen Memory
>>> dfe00000-feafffff : PCI Bus 0000:00
>>>    dfe00000-dfffffff : PCI Bus 0000:02
>>>    e0000000-efffffff : 0000:00:02.0
>>>    f7800000-f7bfffff : 0000:00:02.0
>>>    f7c00000-f7cfffff : PCI Bus 0000:04
>>>      f7c00000-f7c7ffff : 0000:04:00.0
>>>        f7c00000-f7c7ffff : ath9k
>>>      f7c80000-f7c8ffff : 0000:04:00.0
>>>    f7d00000-f7dfffff : PCI Bus 0000:03
>>>      f7d00000-f7d3ffff : 0000:03:00.0
>>>        f7d00000-f7d3ffff : alx
>>>    f7e00000-f7efffff : PCI Bus 0000:02
>>>      f7e00000-f7e000ff : 0000:02:00.0
>>>    f7f00000-f7f0ffff : 0000:00:14.0
>>>      f7f00000-f7f0ffff : xhci-hcd
>>>    f7f10000-f7f17fff : 0000:00:04.0
>>>    f7f18000-f7f1bfff : 0000:00:1b.0
>>>      f7f18000-f7f1bfff : ICH HD audio
>>>    f7f1c000-f7f1ffff : 0000:00:03.0
>>>      f7f1c000-f7f1ffff : ICH HD audio
>>>    f7f20000-f7f20fff : 0000:00:1f.6
>>>    f7f21000-f7f210ff : 0000:00:1f.3
>>>    f7f22000-f7f227ff : 0000:00:1f.2
>>>      f7f22000-f7f227ff : ahci
>>>    f7f23000-f7f233ff : 0000:00:1d.0
>>>      f7f23000-f7f233ff : ehci_hcd
>>>    f7f26000-f7f2601f : 0000:00:16.0
>>>      f7f26000-f7f2601f : mei_me
>>>    f7fdf000-f7fdffff : pnp 00:09
>>>    f7fe0000-f7feffff : pnp 00:09
>>>    f8000000-fbffffff : PCI MMCONFIG 0000 [bus 00-3f]
>>>      f8000000-fbffffff : reserved
>>>        f8000000-fbffffff : pnp 00:09
>>> fec00000-fec00fff : reserved
>>>    fec00000-fec003ff : IOAPIC 0
>>> fed00000-fed03fff : reserved
>>>    fed00000-fed003ff : HPET 0
>>>      fed00000-fed003ff : PNP0103:00
>>> fed10000-fed17fff : pnp 00:09
>>> fed18000-fed18fff : pnp 00:09
>>> fed19000-fed19fff : pnp 00:09
>>> fed1c000-fed1ffff : reserved
>>>    fed1c000-fed1ffff : pnp 00:09
>>>      fed1f410-fed1f414 : iTCO_wdt
>>> fed20000-fed3ffff : pnp 00:09
>>> fed40000-fed44fff : pnp 00:00
>>> fed45000-fed8ffff : pnp 00:09
>>> fed90000-fed93fff : pnp 00:09
>>> fee00000-fee00fff : Local APIC
>>>    fee00000-fee00fff : reserved
>>> ff000000-ffffffff : reserved
>>>    ff000000-ffffffff : INT0800:00
>>>      ff000000-ffffffff : pnp 00:09
>>> 100000000-11e1fffff : System RAM
>>> 11e200000-11fffffff : RAM buffer
>>>
>>> [7.5.]
>>> 00:00.0 Host bridge: Intel Corporation Haswell-ULT DRAM Controller=20
>>> (rev 09)
>>>      Subsystem: ASUSTeK Computer Inc. Device 163d
>>>      Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
>>> ParErr-
>>> Stepping- SERR- FastB2B- DisINTx-
>>>      Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbor=
t-=20
>>> <TAbort-
>>> <MAbort+ >SERR- <PERR- INTx-
>>>      Latency: 0
>>>      Capabilities: [e0] Vendor Specific Information: Len=3D0c <?>
>>>
>>> 00:02.0 VGA compatible controller: Intel Corporation Haswell-ULT=20
>>> Integrated
>>> Graphics Controller (rev 09) (prog-if 00 [VGA controller])
>>>      Subsystem: ASUSTeK Computer Inc. Device 163d
>>>      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
>>> ParErr-
>>> Stepping- SERR- FastB2B- DisINTx+
>>>      Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbor=
t-=20
>>> <TAbort-
>>> <MAbort- >SERR- <PERR- INTx-
>>>      Latency: 0
>>>      Interrupt: pin A routed to IRQ 47
>>>      Region 0: Memory at f7800000 (64-bit, non-prefetchable) [size=3D=
4M]
>>>      Region 2: Memory at e0000000 (64-bit, prefetchable) [size=3D25=
6M]
>>>      Region 4: I/O ports at f000 [size=3D64]
>>>      Expansion ROM at <unassigned> [disabled]
>>>      Capabilities: [90] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
>>>          Address: fee0f00c  Data: 4172
>>>      Capabilities: [d0] Power Management version 2
>>>          Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA
>>> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>>>          Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
>>>      Capabilities: [a4] PCI Advanced Features
>>>          AFCap: TP+ FLR+
>>>          AFCtrl: FLR-
>>>          AFStatus: TP-
>>>      Kernel driver in use: i915
>>>
>>> 00:03.0 Audio device: Intel Corporation Haswell-ULT HD Audio=20
>>> Controller (rev
>>> 09)
>>>      Subsystem: Intel Corporation Device 2010
>>>      Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
>>> ParErr-
>>> Stepping- SERR- FastB2B- DisINTx+
>>>      Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbor=
t-=20
>>> <TAbort-
>>> <MAbort- >SERR- <PERR- INTx-
>>>      Latency: 0, Cache Line Size: 64 bytes
>>>      Interrupt: pin A routed to IRQ 49
>>>      Region 0: Memory at f7f1c000 (64-bit, non-prefetchable) [size=3D=
16K]
>>>      Capabilities: [50] Power Management version 2
>>>          Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
>>> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>>>          Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
>>>      Capabilities: [60] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
>>>          Address: fee0f00c  Data: 41a2
>>>      Capabilities: [70] Express (v1) Root Complex Integrated=20
>>> Endpoint, MSI 00
>>>          DevCap:    MaxPayload 128 bytes, PhantFunc 0
>>>              ExtTag- RBE-
>>>          DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
>>> Unsupported-
>>>              RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>>>              MaxPayload 128 bytes, MaxReadReq 128 bytes
>>>          DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr=
-
>>> TransPend-
>>>      Kernel driver in use: snd_hda_intel
>>>
>>> 00:04.0 Signal processing controller: Intel Corporation Device 0a03=
=20
>>> (rev 09)
>>>      Subsystem: Intel Corporation Device 2010
>>>      Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
>>> ParErr-
>>> Stepping- SERR- FastB2B- DisINTx-
>>>      Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbor=
t-=20
>>> <TAbort-
>>> <MAbort- >SERR- <PERR- INTx-
>>>      Latency: 0
>>>      Interrupt: pin A routed to IRQ 16
>>>      Region 0: Memory at f7f10000 (64-bit, non-prefetchable) [size=3D=
32K]
>>>      Capabilities: [90] MSI: Enable- Count=3D1/1 Maskable- 64bit-
>>>          Address: 00000000  Data: 0000
>>>      Capabilities: [d0] Power Management version 3
>>>          Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
>>> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>>>          Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
>>>      Capabilities: [e0] Vendor Specific Information: Len=3D0c <?>
>>>      Kernel driver in use: proc_thermal
>>>
>>> 00:14.0 USB controller: Intel Corporation Lynx Point-LP USB xHCI HC=
=20
>>> (rev 04)
>>> (prog-if 30 [XHCI])
>>>      Subsystem: ASUSTeK Computer Inc. Device 201f
>>>      Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
>>> ParErr-
>>> Stepping- SERR- FastB2B- DisINTx+
>>>      Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAb=
ort-
>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>      Latency: 0
>>>      Interrupt: pin A routed to IRQ 44
>>>      Region 0: Memory at f7f00000 (64-bit, non-prefetchable) [size=3D=
64K]
>>>      Capabilities: [70] Power Management version 2
>>>          Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA
>>> PME(D0-,D1-,D2-,D3hot+,D3cold+)
>>>          Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
>>>      Capabilities: [80] MSI: Enable+ Count=3D1/8 Maskable- 64bit+
>>>          Address: 00000000fee0f00c  Data: 4122
>>>      Kernel driver in use: xhci_hcd
>>>
>>> 00:16.0 Communication controller: Intel Corporation Lynx Point-LP=20
>>> HECI #0
>>> (rev 04)
>>>      Subsystem: ASUSTeK Computer Inc. Device 163d
>>>      Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
>>> ParErr-
>>> Stepping- SERR- FastB2B- DisINTx+
>>>      Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbor=
t-=20
>>> <TAbort-
>>> <MAbort- >SERR- <PERR- INTx-
>>>      Latency: 0
>>>      Interrupt: pin A routed to IRQ 46
>>>      Region 0: Memory at f7f26000 (64-bit, non-prefetchable) [size=3D=
32]
>>>      Capabilities: [50] Power Management version 3
>>>          Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
>>> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>>>          Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
>>>      Capabilities: [8c] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
>>>          Address: 00000000fee0f00c  Data: 4162
>>>      Kernel driver in use: mei_me
>>>
>>> 00:1b.0 Audio device: Intel Corporation Lynx Point-LP HD Audio=20
>>> Controller
>>> (rev 04)
>>>      Subsystem: ASUSTeK Computer Inc. Device 163d
>>>      Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
>>> ParErr-
>>> Stepping- SERR- FastB2B- DisINTx+
>>>      Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbor=
t-=20
>>> <TAbort-
>>> <MAbort- >SERR- <PERR- INTx-
>>>      Latency: 0, Cache Line Size: 64 bytes
>>>      Interrupt: pin A routed to IRQ 48
>>>      Region 0: Memory at f7f18000 (64-bit, non-prefetchable) [size=3D=
16K]
>>>      Capabilities: [50] Power Management version 3
>>>          Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D55mA
>>> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>>>          Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
>>>      Capabilities: [60] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
>>>          Address: 00000000fee0f00c  Data: 4192
>>>      Capabilities: [70] Express (v1) Root Complex Integrated=20
>>> Endpoint, MSI 00
>>>          DevCap:    MaxPayload 128 bytes, PhantFunc 0
>>>              ExtTag- RBE-
>>>          DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
>>> Unsupported-
>>>              RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>>>              MaxPayload 128 bytes, MaxReadReq 128 bytes
>>>          DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr=
+
>>> TransPend-
>>>      Capabilities: [100 v1] Virtual Channel
>>>          Caps:    LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
>>>          Arb:    Fixed- WRR32- WRR64- WRR128-
>>>          Ctrl:    ArbSelect=3DFixed
>>>          Status:    InProgress-
>>>          VC0:    Caps:    PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopT=
rans-
>>>              Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
>>>              Ctrl:    Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3D01
>>>              Status:    NegoPending- InProgress-
>>>          VC1:    Caps:    PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopT=
rans-
>>>              Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
>>>              Ctrl:    Enable- ID=3D2 ArbSelect=3DFixed TC/VC=3D04
>>>              Status:    NegoPending- InProgress-
>>>      Kernel driver in use: snd_hda_intel
>>>
>>> 00:1c.0 PCI bridge: Intel Corporation Lynx Point-LP PCI Express Roo=
t=20
>>> Port 1
>>> (rev e4) (prog-if 00 [Normal decode])
>>>      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
>>> ParErr-
>>> Stepping- SERR- FastB2B- DisINTx+
>>>      Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbor=
t-=20
>>> <TAbort-
>>> <MAbort- >SERR- <PERR- INTx-
>>>      Latency: 0, Cache Line Size: 64 bytes
>>>      Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-laten=
cy=3D0
>>>      I/O behind bridge: 0000f000-00000fff
>>>      Memory behind bridge: fff00000-000fffff
>>>      Prefetchable memory behind bridge:=20
>>> 00000000fff00000-00000000000fffff
>>>      Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbor=
t-=20
>>> <TAbort-
>>> <MAbort+ <SERR- <PERR-
>>>      BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>>>          PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>>>      Capabilities: [40] Express (v2) Root Port (Slot-), MSI 00
>>>          DevCap:    MaxPayload 128 bytes, PhantFunc 0
>>>              ExtTag- RBE+
>>>          DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
>>> Unsupported-
>>>              RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>>>              MaxPayload 128 bytes, MaxReadReq 128 bytes
>>>          DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr=
+
>>> TransPend-
>>>          LnkCap:    Port #1, Speed 5GT/s, Width x1, ASPM L0s L1,=20
>>> Exit Latency
>>> L0s <1us, L1 <4us
>>>              ClockPM- Surprise- LLActRep+ BwNot+
>>>          LnkCtl:    ASPM L0s L1 Enabled; RCB 64 bytes Disabled-=20
>>> CommClk-
>>>              ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>>>          LnkSta:    Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+=
=20
>>> DLActive-
>>> BWMgmt- ABWMgmt-
>>>          RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna=
+
>>> CRSVisible-
>>>          RootCap: CRSVisible-
>>>          RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>>>          DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+,=
=20
>>> OBFF Via
>>> WAKE# ARIFwd-
>>>          DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-,=20
>>> LTR+, OBFF
>>> Disabled ARIFwd-
>>>          LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedD=
is-
>>>               Transmit Margin: Normal Operating Range,
>>> EnterModifiedCompliance- ComplianceSOS-
>>>               Compliance De-emphasis: -6dB
>>>          LnkSta2: Current De-emphasis Level: -3.5dB,=20
>>> EqualizationComplete-,
>>> EqualizationPhase1-
>>>               EqualizationPhase2-, EqualizationPhase3-,
>>> LinkEqualizationRequest-
>>>      Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
>>>          Address: fee0f00c  Data: 4181
>>>      Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 163=
d
>>>      Capabilities: [a0] Power Management version 3
>>>          Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
>>> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>>>          Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
>>>      Kernel driver in use: pcieport
>>>
>>> 00:1c.1 PCI bridge: Intel Corporation Lynx Point-LP PCI Express Roo=
t=20
>>> Port 2
>>> (rev e4) (prog-if 00 [Normal decode])
>>>      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
>>> ParErr-
>>> Stepping- SERR- FastB2B- DisINTx+
>>>      Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbor=
t-=20
>>> <TAbort-
>>> <MAbort- >SERR- <PERR- INTx-
>>>      Latency: 0, Cache Line Size: 64 bytes
>>>      Bus: primary=3D00, secondary=3D02, subordinate=3D02, sec-laten=
cy=3D0
>>>      I/O behind bridge: 00002000-00002fff
>>>      Memory behind bridge: f7e00000-f7efffff
>>>      Prefetchable memory behind bridge:=20
>>> 00000000dfe00000-00000000dfffffff
>>>      Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbor=
t-=20
>>> <TAbort-
>>> <MAbort+ <SERR- <PERR-
>>>      BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>>>          PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>>>      Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
>>>          DevCap:    MaxPayload 128 bytes, PhantFunc 0
>>>              ExtTag- RBE+
>>>          DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
>>> Unsupported-
>>>              RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>>>              MaxPayload 128 bytes, MaxReadReq 128 bytes
>>>          DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr=
+
>>> TransPend-
>>>          LnkCap:    Port #2, Speed 5GT/s, Width x1, ASPM L0s L1,=20
>>> Exit Latency
>>> L0s <512ns, L1 <16us
>>>              ClockPM- Surprise- LLActRep+ BwNot+
>>>          LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk+
>>>              ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>>>          LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+=
=20
>>> DLActive+
>>> BWMgmt+ ABWMgmt-
>>>          SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug=
+
>>> Surprise+
>>>              Slot #1, PowerLimit 10.000W; Interlock- NoCompl+
>>>          SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt-=
=20
>>> HPIrq+
>>> LinkChg+
>>>              Control: AttnInd Unknown, PwrInd Unknown, Power-=20
>>> Interlock-
>>>          SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDe=
t+
>>> Interlock-
>>>              Changed: MRL- PresDet- LinkState-
>>>          RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna=
+
>>> CRSVisible-
>>>          RootCap: CRSVisible-
>>>          RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>>>          DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+,=
=20
>>> OBFF Not
>>> Supported ARIFwd-
>>>          DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-,=20
>>> LTR+, OBFF
>>> Disabled ARIFwd-
>>>          LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedD=
is-
>>>               Transmit Margin: Normal Operating Range,
>>> EnterModifiedCompliance- ComplianceSOS-
>>>               Compliance De-emphasis: -6dB
>>>          LnkSta2: Current De-emphasis Level: -3.5dB,=20
>>> EqualizationComplete-,
>>> EqualizationPhase1-
>>>               EqualizationPhase2-, EqualizationPhase3-,
>>> LinkEqualizationRequest-
>>>      Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
>>>          Address: fee0f00c  Data: 41a1
>>>      Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 163=
d
>>>      Capabilities: [a0] Power Management version 3
>>>          Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
>>> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>>>          Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
>>>      Capabilities: [100 v0] #00
>>>      Capabilities: [200 v1] L1 PM Substates
>>>          L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
>>> L1_PM_Substates+
>>>                PortCommonModeRestoreTime=3D40us PortTPowerOnTime=3D=
10us
>>>      Kernel driver in use: pcieport
>>>
>>> 00:1c.2 PCI bridge: Intel Corporation Lynx Point-LP PCI Express Roo=
t=20
>>> Port 3
>>> (rev e4) (prog-if 00 [Normal decode])
>>>      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
>>> ParErr-
>>> Stepping- SERR- FastB2B- DisINTx+
>>>      Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbor=
t-=20
>>> <TAbort-
>>> <MAbort- >SERR- <PERR- INTx-
>>>      Latency: 0, Cache Line Size: 64 bytes
>>>      Bus: primary=3D00, secondary=3D03, subordinate=3D03, sec-laten=
cy=3D0
>>>      I/O behind bridge: 0000e000-0000efff
>>>      Memory behind bridge: f7d00000-f7dfffff
>>>      Prefetchable memory behind bridge:=20
>>> 00000000fff00000-00000000000fffff
>>>      Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbor=
t-=20
>>> <TAbort-
>>> <MAbort+ <SERR- <PERR-
>>>      BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>>>          PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>>>      Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
>>>          DevCap:    MaxPayload 128 bytes, PhantFunc 0
>>>              ExtTag- RBE+
>>>          DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
>>> Unsupported-
>>>              RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>>>              MaxPayload 128 bytes, MaxReadReq 128 bytes
>>>          DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr=
+
>>> TransPend-
>>>          LnkCap:    Port #3, Speed 5GT/s, Width x1, ASPM L0s L1,=20
>>> Exit Latency
>>> L0s <512ns, L1 <16us
>>>              ClockPM- Surprise- LLActRep+ BwNot+
>>>          LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk+
>>>              ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>>>          LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+=
=20
>>> DLActive+
>>> BWMgmt+ ABWMgmt-
>>>          SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug=
-
>>> Surprise-
>>>              Slot #2, PowerLimit 10.000W; Interlock- NoCompl+
>>>          SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-=
=20
>>> HPIrq-
>>> LinkChg-
>>>              Control: AttnInd Unknown, PwrInd Unknown, Power-=20
>>> Interlock-
>>>          SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDe=
t+
>>> Interlock-
>>>              Changed: MRL- PresDet- LinkState-
>>>          RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna=
+
>>> CRSVisible-
>>>          RootCap: CRSVisible-
>>>          RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>>>          DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+,=
=20
>>> OBFF Not
>>> Supported ARIFwd-
>>>          DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-,=20
>>> LTR+, OBFF
>>> Disabled ARIFwd-
>>>          LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedD=
is-
>>>               Transmit Margin: Normal Operating Range,
>>> EnterModifiedCompliance- ComplianceSOS-
>>>               Compliance De-emphasis: -6dB
>>>          LnkSta2: Current De-emphasis Level: -3.5dB,=20
>>> EqualizationComplete-,
>>> EqualizationPhase1-
>>>               EqualizationPhase2-, EqualizationPhase3-,
>>> LinkEqualizationRequest-
>>>      Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
>>>          Address: fee0f00c  Data: 41c1
>>>      Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 163=
d
>>>      Capabilities: [a0] Power Management version 3
>>>          Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
>>> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>>>          Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
>>>      Capabilities: [100 v0] #00
>>>      Capabilities: [200 v1] L1 PM Substates
>>>          L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
>>> L1_PM_Substates+
>>>                PortCommonModeRestoreTime=3D40us PortTPowerOnTime=3D=
10us
>>>      Kernel driver in use: pcieport
>>>
>>> 00:1c.3 PCI bridge: Intel Corporation Lynx Point-LP PCI Express Roo=
t=20
>>> Port 4
>>> (rev e4) (prog-if 00 [Normal decode])
>>>      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
>>> ParErr-
>>> Stepping- SERR- FastB2B- DisINTx+
>>>      Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbor=
t-=20
>>> <TAbort-
>>> <MAbort- >SERR- <PERR- INTx-
>>>      Latency: 0, Cache Line Size: 64 bytes
>>>      Bus: primary=3D00, secondary=3D04, subordinate=3D04, sec-laten=
cy=3D0
>>>      I/O behind bridge: 0000f000-00000fff
>>>      Memory behind bridge: f7c00000-f7cfffff
>>>      Prefetchable memory behind bridge:=20
>>> 00000000fff00000-00000000000fffff
>>>      Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbor=
t-=20
>>> <TAbort-
>>> <MAbort+ <SERR- <PERR-
>>>      BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>>>          PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>>>      Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
>>>          DevCap:    MaxPayload 128 bytes, PhantFunc 0
>>>              ExtTag- RBE+
>>>          DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
>>> Unsupported-
>>>              RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>>>              MaxPayload 128 bytes, MaxReadReq 128 bytes
>>>          DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr=
+
>>> TransPend-
>>>          LnkCap:    Port #4, Speed 5GT/s, Width x1, ASPM L0s L1,=20
>>> Exit Latency
>>> L0s <512ns, L1 <16us
>>>              ClockPM- Surprise- LLActRep+ BwNot+
>>>          LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk+
>>>              ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>>>          LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+=
=20
>>> DLActive+
>>> BWMgmt+ ABWMgmt-
>>>          SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug=
-
>>> Surprise-
>>>              Slot #3, PowerLimit 10.000W; Interlock- NoCompl+
>>>          SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-=
=20
>>> HPIrq-
>>> LinkChg-
>>>              Control: AttnInd Unknown, PwrInd Unknown, Power-=20
>>> Interlock-
>>>          SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDe=
t+
>>> Interlock-
>>>              Changed: MRL- PresDet- LinkState-
>>>          RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna=
+
>>> CRSVisible-
>>>          RootCap: CRSVisible-
>>>          RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>>>          DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+,=
=20
>>> OBFF Not
>>> Supported ARIFwd-
>>>          DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-,=20
>>> LTR+, OBFF
>>> Disabled ARIFwd-
>>>          LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedD=
is-
>>>               Transmit Margin: Normal Operating Range,
>>> EnterModifiedCompliance- ComplianceSOS-
>>>               Compliance De-emphasis: -6dB
>>>          LnkSta2: Current De-emphasis Level: -3.5dB,=20
>>> EqualizationComplete-,
>>> EqualizationPhase1-
>>>               EqualizationPhase2-, EqualizationPhase3-,
>>> LinkEqualizationRequest-
>>>      Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
>>>          Address: fee0f00c  Data: 41e1
>>>      Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 163=
d
>>>      Capabilities: [a0] Power Management version 3
>>>          Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
>>> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>>>          Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
>>>      Capabilities: [100 v0] #00
>>>      Capabilities: [200 v1] L1 PM Substates
>>>          L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
>>> L1_PM_Substates+
>>>                PortCommonModeRestoreTime=3D40us PortTPowerOnTime=3D=
10us
>>>      Kernel driver in use: pcieport
>>>
>>> 00:1d.0 USB controller: Intel Corporation Lynx Point-LP USB EHCI #1=
=20
>>> (rev 04)
>>> (prog-if 20 [EHCI])
>>>      Subsystem: ASUSTeK Computer Inc. Device 201f
>>>      Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
>>> ParErr-
>>> Stepping- SERR- FastB2B- DisINTx-
>>>      Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAb=
ort-
>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>      Latency: 0
>>>      Interrupt: pin A routed to IRQ 23
>>>      Region 0: Memory at f7f23000 (32-bit, non-prefetchable) [size=3D=
1K]
>>>      Capabilities: [50] Power Management version 3
>>>          Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA
>>> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>>>          Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
>>>      Capabilities: [58] Debug port: BAR=3D1 offset=3D00a0
>>>      Capabilities: [98] PCI Advanced Features
>>>          AFCap: TP+ FLR+
>>>          AFCtrl: FLR-
>>>          AFStatus: TP-
>>>      Kernel driver in use: ehci-pci
>>>
>>> 00:1f.0 ISA bridge: Intel Corporation Lynx Point-LP LPC Controller=20
>>> (rev 04)
>>>      Subsystem: ASUSTeK Computer Inc. Device 163d
>>>      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
>>> ParErr-
>>> Stepping- SERR- FastB2B- DisINTx-
>>>      Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAb=
ort-
>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>      Latency: 0
>>>      Capabilities: [e0] Vendor Specific Information: Len=3D0c <?>
>>>      Kernel driver in use: lpc_ich
>>>
>>> 00:1f.2 SATA controller: Intel Corporation Lynx Point-LP SATA=20
>>> Controller 1
>>> [AHCI mode] (rev 04) (prog-if 01 [AHCI 1.0])
>>>      Subsystem: ASUSTeK Computer Inc. Device 163d
>>>      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
>>> ParErr-
>>> Stepping- SERR- FastB2B- DisINTx+
>>>      Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAb=
ort-
>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>      Latency: 0
>>>      Interrupt: pin B routed to IRQ 45
>>>      Region 0: I/O ports at f0b0 [size=3D8]
>>>      Region 1: I/O ports at f0a0 [size=3D4]
>>>      Region 2: I/O ports at f090 [size=3D8]
>>>      Region 3: I/O ports at f080 [size=3D4]
>>>      Region 4: I/O ports at f060 [size=3D32]
>>>      Region 5: Memory at f7f22000 (32-bit, non-prefetchable) [size=3D=
2K]
>>>      Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
>>>          Address: fee0a00c  Data: 4152
>>>      Capabilities: [70] Power Management version 3
>>>          Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
>>> PME(D0-,D1-,D2-,D3hot+,D3cold-)
>>>          Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
>>>      Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=3D00000004
>>>      Kernel driver in use: ahci
>>>
>>> 00:1f.3 SMBus: Intel Corporation Lynx Point-LP SMBus Controller (re=
v=20
>>> 04)
>>>      Subsystem: ASUSTeK Computer Inc. Device 163d
>>>      Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-=20
>>> ParErr-
>>> Stepping- SERR- FastB2B- DisINTx-
>>>      Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAb=
ort-
>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>      Interrupt: pin C routed to IRQ 4
>>>      Region 0: Memory at f7f21000 (64-bit, non-prefetchable) [size=3D=
256]
>>>      Region 4: I/O ports at f040 [size=3D32]
>>>
>>> 00:1f.6 Signal processing controller: Intel Corporation Lynx Point-=
LP
>>> Thermal (rev 04)
>>>      Subsystem: ASUSTeK Computer Inc. Device 163d
>>>      Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
>>> ParErr-
>>> Stepping- SERR- FastB2B- DisINTx-
>>>      Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbor=
t-=20
>>> <TAbort-
>>> <MAbort- >SERR- <PERR- INTx-
>>>      Latency: 0
>>>      Interrupt: pin C routed to IRQ 4
>>>      Region 0: Memory at f7f20000 (64-bit, non-prefetchable) [size=3D=
4K]
>>>      Capabilities: [50] Power Management version 3
>>>          Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA
>>> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>>>          Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
>>>      Capabilities: [80] MSI: Enable- Count=3D1/1 Maskable- 64bit-
>>>          Address: 00000000  Data: 0000
>>>
>>> 02:00.0 Unassigned class [ff00]: Device 1aea:6601
>>>      Subsystem: Device 0001:0001
>>>      Physical Slot: 1-1
>>>      Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
>>> ParErr-
>>> Stepping- SERR- FastB2B- DisINTx-
>>>      Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbor=
t-=20
>>> <TAbort-
>>> <MAbort- >SERR- <PERR- INTx-
>>>      Latency: 0, Cache Line Size: 64 bytes
>>>      Interrupt: pin A routed to IRQ 3
>>>      Region 0: Memory at f7e00000 (64-bit, non-prefetchable) [disab=
led]
>>> [size=3D256]
>>>      Capabilities: [80] Power Management version 3
>>>          Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
>>> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>>>          Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
>>>      Capabilities: [88] MSI: Enable- Count=3D1/1 Maskable- 64bit+
>>>          Address: 0000000000000000  Data: 0000
>>>      Capabilities: [98] Express (v1) Endpoint, MSI 00
>>>          DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s=20
>>> unlimited,
>>> L1 unlimited
>>>              ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
>>>          DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
>>> Unsupported-
>>>              RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
>>>              MaxPayload 128 bytes, MaxReadReq 512 bytes
>>>          DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr=
-
>>> TransPend-
>>>          LnkCap:    Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, =
Exit
>>> Latency L0s <4us, L1 unlimited
>>>              ClockPM- Surprise- LLActRep- BwNot-
>>>          LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk+
>>>              ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>>>          LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+=
=20
>>> DLActive-
>>> BWMgmt- ABWMgmt-
>>>
>>> 03:00.0 Ethernet controller: Qualcomm Atheros QCA8171 Gigabit=20
>>> Ethernet (rev
>>> 10)
>>>      Subsystem: ASUSTeK Computer Inc. Device 205f
>>>      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
>>> ParErr-
>>> Stepping- SERR- FastB2B- DisINTx-
>>>      Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbor=
t-=20
>>> <TAbort-
>>> <MAbort- >SERR- <PERR- INTx-
>>>      Latency: 0, Cache Line Size: 64 bytes
>>>      Interrupt: pin A routed to IRQ 50
>>>      Region 0: Memory at f7d00000 (64-bit, non-prefetchable)=20
>>> [size=3D256K]
>>>      Region 2: I/O ports at e000 [size=3D128]
>>>      Capabilities: [40] Power Management version 3
>>>          Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA
>>> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>>>          Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
>>>      Capabilities: [58] Express (v1) Endpoint, MSI 00
>>>          DevCap:    MaxPayload 4096 bytes, PhantFunc 0, Latency L0s
>>> unlimited, L1 unlimited
>>>              ExtTag- AttnBtn+ AttnInd+ PwrInd+ RBE+ FLReset-
>>>          DevCtl:    Report errors: Correctable+ Non-Fatal+ Fatal+
>>> Unsupported+
>>>              RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>>>              MaxPayload 128 bytes, MaxReadReq 512 bytes
>>>          DevSta:    CorrErr+ UncorrErr+ FatalErr- UnsuppReq+ AuxPwr=
+
>>> TransPend-
>>>          LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, =
Exit
>>> Latency L0s unlimited, L1 unlimited
>>>              ClockPM+ Surprise- LLActRep- BwNot-
>>>          LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk+
>>>              ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>>>          LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+=
=20
>>> DLActive-
>>> BWMgmt- ABWMgmt-
>>>      Capabilities: [c0] MSI: Enable+ Count=3D1/16 Maskable+ 64bit+
>>>          Address: 00000000fee0f00c  Data: 41b2
>>>          Masking: 0000fffe  Pending: 00000000
>>>      Capabilities: [d8] MSI-X: Enable- Count=3D16 Masked-
>>>          Vector table: BAR=3D0 offset=3D00002000
>>>          PBA: BAR=3D0 offset=3D00003000
>>>      Capabilities: [100 v1] Advanced Error Reporting
>>>          UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-=20
>>> UnxCmplt- RxOF-
>>> MalfTLP- ECRC- UnsupReq+ ACSViol-
>>>          UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-=20
>>> UnxCmplt- RxOF-
>>> MalfTLP- ECRC- UnsupReq- ACSViol-
>>>          UESvrt:    DLP- SDES+ TLP- FCP- CmpltTO- CmpltAbrt-=20
>>> UnxCmplt- RxOF+
>>> MalfTLP+ ECRC- UnsupReq- ACSViol-
>>>          CESta:    RxErr- BadTLP- BadDLLP+ Rollover- Timeout-=20
>>> NonFatalErr-
>>>          CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout-=20
>>> NonFatalErr+
>>>          AERCap:    First Error Pointer: 14, GenCap+ CGenEn- ChkCap=
+=20
>>> ChkEn-
>>>      Capabilities: [180 v1] Device Serial Number=20
>>> ff-da-2e-1f-10-c3-7b-ff
>>>      Kernel driver in use: alx
>>>
>>> 04:00.0 Network controller: Qualcomm Atheros QCA9565 / AR9565 Wirel=
ess
>>> Network Adapter (rev 01)
>>>      Subsystem: AzureWave Device 2130
>>>      Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
>>> ParErr-
>>> Stepping- SERR- FastB2B- DisINTx-
>>>      Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbor=
t-=20
>>> <TAbort-
>>> <MAbort- >SERR- <PERR- INTx-
>>>      Latency: 0, Cache Line Size: 64 bytes
>>>      Interrupt: pin A routed to IRQ 19
>>>      Region 0: Memory at f7c00000 (64-bit, non-prefetchable)=20
>>> [size=3D512K]
>>>      Expansion ROM at f7c80000 [disabled] [size=3D64K]
>>>      Capabilities: [40] Power Management version 2
>>>          Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA
>>> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>>>          Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
>>>      Capabilities: [50] MSI: Enable- Count=3D1/4 Maskable+ 64bit+
>>>          Address: 0000000000000000  Data: 0000
>>>          Masking: 00000000  Pending: 00000000
>>>      Capabilities: [70] Express (v2) Endpoint, MSI 00
>>>          DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s=20
>>> unlimited,
>>> L1 <64us
>>>              ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
>>>          DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
>>> Unsupported-
>>>              RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>>>              MaxPayload 128 bytes, MaxReadReq 512 bytes
>>>          DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr=
+
>>> TransPend-
>>>          LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, =
Exit
>>> Latency L0s <4us, L1 <64us
>>>              ClockPM- Surprise- LLActRep- BwNot-
>>>          LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk+
>>>              ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>>>          LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+=
=20
>>> DLActive-
>>> BWMgmt- ABWMgmt-
>>>          DevCap2: Completion Timeout: Not Supported, TimeoutDis+,=20
>>> LTR-, OBFF
>>> Not Supported
>>>          DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-,=20
>>> LTR-, OBFF
>>> Disabled
>>>          LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance-=20
>>> SpeedDis-
>>>               Transmit Margin: Normal Operating Range,
>>> EnterModifiedCompliance- ComplianceSOS-
>>>               Compliance De-emphasis: -6dB
>>>          LnkSta2: Current De-emphasis Level: -6dB,=20
>>> EqualizationComplete-,
>>> EqualizationPhase1-
>>>               EqualizationPhase2-, EqualizationPhase3-,
>>> LinkEqualizationRequest-
>>>      Capabilities: [100 v1] Advanced Error Reporting
>>>          UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-=20
>>> UnxCmplt- RxOF-
>>> MalfTLP- ECRC- UnsupReq- ACSViol-
>>>          UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-=20
>>> UnxCmplt- RxOF-
>>> MalfTLP- ECRC- UnsupReq- ACSViol-
>>>          UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-=20
>>> UnxCmplt- RxOF+
>>> MalfTLP+ ECRC- UnsupReq- ACSViol-
>>>          CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout-=20
>>> NonFatalErr+
>>>          CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout-=20
>>> NonFatalErr+
>>>          AERCap:    First Error Pointer: 00, GenCap- CGenEn- ChkCap=
-=20
>>> ChkEn-
>>>      Capabilities: [140 v1] Virtual Channel
>>>          Caps:    LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
>>>          Arb:    Fixed- WRR32- WRR64- WRR128-
>>>          Ctrl:    ArbSelect=3DFixed
>>>          Status:    InProgress-
>>>          VC0:    Caps:    PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopT=
rans-
>>>              Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
>>>              Ctrl:    Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3D01
>>>              Status:    NegoPending- InProgress-
>>>      Capabilities: [160 v1] Device Serial Number=20
>>> 00-00-00-00-00-00-00-00
>>>      Kernel driver in use: ath9k
>>>
>>> [7.6.]
>>> Attached devices:
>>> Host: scsi0 Channel: 00 Id: 00 Lun: 00
>>>    Vendor: ATA      Model: TOSHIBA MQ01ABF0 Rev: 1J
>>>    Type:   Direct-Access ANSI  SCSI revision: 05
>>> Host: scsi1 Channel: 00 Id: 00 Lun: 00
>>>    Vendor: HL-DT-ST Model: DVDRAM GUA0N Rev: AS00
>>>    Type:   CD-ROM ANSI  SCSI revision: 05
>>>
>>> [7.7.]
>>> 1
>>> 10
>>> 1014
>>> 1027
>>> 1031
>>> 1040
>>> 1043
>>> 11
>>> 1102
>>> 1146
>>> 1161
>>> 12
>>> 1241
>>> 1275
>>> 1284
>>> 1296
>>> 13
>>> 1304
>>> 1307
>>> 1316
>>> 1397
>>> 14
>>> 1408
>>> 1415
>>> 1416
>>> 1440
>>> 1441
>>> 1444
>>> 1446
>>> 1461
>>> 1465
>>> 1468
>>> 1469
>>> 1474
>>> 1476
>>> 1479
>>> 1484
>>> 149
>>> 1497
>>> 1498
>>> 15
>>> 150
>>> 1500
>>> 1506
>>> 151
>>> 1518
>>> 152
>>> 153
>>> 154
>>> 1549
>>> 155
>>> 1553
>>> 1555
>>> 156
>>> 157
>>> 1633
>>> 17
>>> 1728
>>> 1736
>>> 175
>>> 1753
>>> 176
>>> 1763
>>> 1764
>>> 1765
>>> 1767
>>> 1771
>>> 1774
>>> 1775
>>> 1781
>>> 18
>>> 1823
>>> 1866
>>> 1867
>>> 1870
>>> 1872
>>> 1880
>>> 1886
>>> 1896
>>> 19
>>> 1910
>>> 1912
>>> 1916
>>> 1921
>>> 1928
>>> 1940
>>> 1942
>>> 1947
>>> 1956
>>> 1964
>>> 1969
>>> 1973
>>> 1974
>>> 2
>>> 20
>>> 2014
>>> 2020
>>> 2022
>>> 2038
>>> 2055
>>> 2065
>>> 21
>>> 2142
>>> 2172
>>> 2181
>>> 2182
>>> 2185
>>> 2190
>>> 2191
>>> 2194
>>> 2195
>>> 22
>>> 2203
>>> 2230
>>> 2232
>>> 2248
>>> 2264
>>> 2283
>>> 2303
>>> 2307
>>> 2347
>>> 2355
>>> 2362
>>> 2369
>>> 24
>>> 2476
>>> 25
>>> 2522
>>> 2584
>>> 26
>>> 2615
>>> 2662
>>> 27
>>> 2761
>>> 2790
>>> 2799
>>> 28
>>> 2800
>>> 2861
>>> 29
>>> 3
>>> 3044
>>> 3059
>>> 31
>>> 317
>>> 32
>>> 323
>>> 33
>>> 3320
>>> 34
>>> 35
>>> 3521
>>> 3527
>>> 3568
>>> 36
>>> 367
>>> 37
>>> 3770
>>> 3796
>>> 38
>>> 3821
>>> 3822
>>> 3829
>>> 3867
>>> 3871
>>> 3872
>>> 3895
>>> 39
>>> 390
>>> 391
>>> 3947
>>> 3998
>>> 40
>>> 407
>>> 41
>>> 42
>>> 43
>>> 432
>>> 44
>>> 45
>>> 458
>>> 46
>>> 463
>>> 467
>>> 47
>>> 48
>>> 5
>>> 51
>>> 53
>>> 54
>>> 55
>>> 606
>>> 621
>>> 636
>>> 67
>>> 673
>>> 68
>>> 7
>>> 70
>>> 71
>>> 766
>>> 77
>>> 789
>>> 8
>>> 829
>>> 833
>>> 834
>>> 869
>>> 872
>>> 875
>>> 879
>>> 887
>>> 890
>>> 896
>>> 9
>>> 904
>>> 907
>>> 911
>>> 920
>>> 922
>>> 969
>>> 97
>>> 973
>>> 979
>>> 98
>>> 980
>>> 983
>>> acpi
>>> asound
>>> buddyinfo
>>> bus
>>> cgroups
>>> cmdline
>>> consoles
>>> cpuinfo
>>> crypto
>>> devices
>>> diskstats
>>> dma
>>> driver
>>> execdomains
>>> fb
>>> filesystems
>>> fs
>>> interrupts
>>> iomem
>>> ioports
>>> irq
>>> kallsyms
>>> kcore
>>> keys
>>> key-users
>>> kmsg
>>> kpagecount
>>> kpageflags
>>> loadavg
>>> locks
>>> mdstat
>>> meminfo
>>> misc
>>> modules
>>> mounts
>>> mtrr
>>> net
>>> pagetypeinfo
>>> partitions
>>> sched_debug
>>> schedstat
>>> scsi
>>> self
>>> slabinfo
>>> softirqs
>>> stat
>>> swaps
>>> sys
>>> sysrq-trigger
>>> sysvipc
>>> thread-self
>>> timer_list
>>> timer_stats
>>> tty
>>> uptime
>>> version
>>> vmallocinfo
>>> vmstat
>>> zoneinfo
>>>
>>> [X.] Link to my Launchpad bug report:
>>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1437755
>>>
>>>
>>>
>>> --=20
>>> To unsubscribe from this list: send the line "unsubscribe=20
>>> linux-input" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>
>> -----
>> No se encontraron virus en este mensaje.
>> Comprobado por AVG - www.avg.com
>> Versi=C3=B3n: 2015.0.5863 / Base de datos de virus: 4331/9550 - Fech=
a de=20
>> publicaci=C3=B3n: 04/16/15
>>
>>
>>
>

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
