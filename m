From: Amordea Whiteoak <amordea@gmail.com>
Subject: Re: PROBLEM: [HP Stream Notebook - 11-d010nr] clickpad malfunctions
 after performing a hardware click
Date: Mon, 8 Dec 2014 14:33:25 -0500
Message-ID: <CALmnu0Yg1vd4FOD5vtW39cbbcsRYiPuiiMD0A+obLyrkvKO+jA@mail.gmail.com>
References: <CALmnu0aD9ys4+QZ+gtdNe61q23A3e6MPq+DSD-Q+NcJoWksWkQ@mail.gmail.com>
	<CAN+gG=EXmDcuNvifZKqLLTxew9ji2FW3jx7i8ThqozE1cg_e6A@mail.gmail.com>
	<CALmnu0Y+n0qGs4jgC=YGKRbBSyVB5B4s_Oafsmvbk6M=67okuw@mail.gmail.com>
	<CAN+gG=E+8277zg3LLW-eFWZb8bNyU_Umf9M2w6+t7Y3sSkkSFg@mail.gmail.com>
	<CALmnu0bPLi4skqUxvjd9DWrZJysvqX-+nxNHdx5APGsoNZsnKA@mail.gmail.com>
	<CAN+gG=Emz8r=17OpUETpVQyjCMDMX=aNEFFHZo3ivGS=xTZHXA@mail.gmail.com>
	<CALmnu0agW-mN9RON1FT9DCxE9POiwS2Jhj7hXZaW+6escc7OGw@mail.gmail.com>
	<CALmnu0aMX8RuDJFozCwP6GmP11Uep=R6bc0EqPYzBknwpHBmpA@mail.gmail.com>
	<CAN+gG=E=3kG9t9XTNe0X1kFumdkQ3CfM-ViXnOBGThmyJDNJ4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:54568 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbaLHTd1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Dec 2014 14:33:27 -0500
Received: by mail-pd0-f169.google.com with SMTP id z10so5743508pdj.28
        for <linux-input@vger.kernel.org>; Mon, 08 Dec 2014 11:33:26 -0800 (PST)
In-Reply-To: <CAN+gG=E=3kG9t9XTNe0X1kFumdkQ3CfM-ViXnOBGThmyJDNJ4g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>, Andrew Duggan <aduggan@synaptics.com>

> My guess would be:
> try open the settings panel, go into mouse (or touchpad, or whatever
> it is called), look for an option which should allow you to change
> this setting. If there are none, complain to the Ubuntu team by
> opening a new bug on their launchpad.

Aye, I will be opening a new report on Launchpad it seems. Thank you
for all your help!

> I hope Andrew will be able to fix your touchpad soonish. Thanks for
> the followup BTW Andrew.

And yes, thank you Andrew!!


On Mon, Dec 8, 2014 at 2:26 PM, Benjamin Tissoires
<benjamin.tissoires@gmail.com> wrote:
> On Mon, Dec 8, 2014 at 2:16 PM, Amordea Whiteoak <amordea@gmail.com> wrote:
>> While I have the ears of the touchpad gods, there is one more tiny
>> issue I'd like to report. This may be simply a configuration issue,
>> but I would not know how to fix it.
>>
>> The window for double-tapping (tapping the touchpad twice to simulate
>> a double-click) is remarkably brief. Let me be clear, double-tapping
>> on the touchpad does work, however if you do not get the second tap
>> within about a 200ms window after the first, it seems to fail to
>> register as a double-click, counting it as two unrelated single
>> clicks--this is an uncomfortably short window of opportunity. A
>> temporary workaround seems to be triple-tapping which for whatever
>> reason allow for a broader window (much closer to a full second) and
>> registers as a double-tap, but that just seems to be a happy accident
>> and is certainly not an expected feature. Is there any way to broaden
>> that window?
>
> This is usually an Xorg configuration problem (definitively not a
> kernel one). However, you are using ubuntu 14.10 and I don't know if
> they decided to switch to MIR yet. If so, I have no clues on what is
> driving the touchpad, so I won't be of any help.
>
> My guess would be:
> try open the settings panel, go into mouse (or touchpad, or whatever
> it is called), look for an option which should allow you to change
> this setting. If there are none, complain to the Ubuntu team by
> opening a new bug on their launchpad.
>
>>
>> I did not have this problem on my previous laptop with Lubuntu
>> installed (though it had 14.04 not 14.10--it's no longer operational
>> after suffering an unfortunate accident so I can't do comparison
>> testing with it any longer).
>
> ouch :/
>
>>
>> I promise this is my last remaining issue with the touchpad. :)
>
> No problem. We prefer having responsive users who tries to solve their
> problems than frustrated users :)
>
> I hope Andrew will be able to fix your touchpad soonish. Thanks for
> the followup BTW Andrew.
>
> Cheers,
> Benjamin
>
>>
>> On Mon, Dec 8, 2014 at 1:39 PM, Amordea Whiteoak <amordea@gmail.com> wrote:
>>> My Linux newbieness is showing. :)
>>>
>>> I attempted to edit and boot the grub configuration, but I don't think
>>> I did it right. I went with the seemingly more sure-fire way to get
>>> your data and followed the second set of instructions.
>>>
>>> Enclosed is all the dmesg output once I got that working.
>>>
>>> On Mon, Dec 8, 2014 at 12:59 PM, Benjamin Tissoires
>>> <benjamin.tissoires@gmail.com> wrote:
>>>> On Mon, Dec 8, 2014 at 12:14 PM, Amordea Whiteoak <amordea@gmail.com> wrote:
>>>>> There may be a thing I am failing to understand about dmesg here, but
>>>>> a grep through both dmesg and /var/log/dmesg yielded no hits on
>>>>> "i2c_hid.debug=1". I did find plenty of hits on just "i2c_hid", which
>>>>> yielded several repetitive lines of what appears to be various
>>>>> modules. Please let me know if there is something I am failing to
>>>>> understand here, but I could not find the requested phrase in my
>>>>> dmesg.
>>>>
>>>> I meant that when you reboot the laptop, in grub, append
>>>> "i2c_hid.debug=1" to the kernel command line.
>>>>
>>>> This should be seen in one of the first few lines of dmesg (the one
>>>> starting by "[    0.000000] Command line:
>>>> BOOT_IMAGE=/boot/vmlinuz-3.18.0-031800rc7-generic "), and a lot of raw
>>>> events should be dumped in the dmesg.
>>>>
>>>>>
>>>>> I do have the hid-recorder output though, which I am attaching here.
>>>>> This time I used a non-conductive pen to only generate clicks without
>>>>> all the positioning data piling in on top. This is a recording of two
>>>>> left clicks.
>>>>>
>>>>
>>>> Ok, so at least, the device sends a sane behavior (one event per
>>>> click/release, with one bit changed). Unfortunately, I think the
>>>> problem lies in the configuration of your device by hid-rmi. So the
>>>> dmesg output while i2c_hid.debug=1 is set should help to figure out
>>>> the problem.
>>>>
>>>> If for whatever reasons you do not manage to get the parameter
>>>> appended to your command line, the following commands should suffice
>>>> (as root):
>>>> #> rmmod hid-rmi
>>>> #> echo 1 > /sys/module/i2c_hid/parameters/debug
>>>> #> modprobe hid-rmi
>>>>
>>>> do a few events on the touchpad (with clicks)
>>>>
>>>> #> echo 0 > /sys/module/i2c_hid/parameters/debug
>>>>
>>>> and send out the dmesg.
>>>>
>>>> Cheers,
>>>> Benjamin
>>>>
>>>>> If there is anything else I can provide, please let me know.
>>>>>
>>>>> Thank you for helping with this bug. :)
>>>>>
>>>>> On Mon, Dec 8, 2014 at 11:44 AM, Benjamin Tissoires
>>>>> <benjamin.tissoires@gmail.com> wrote:
>>>>>> Hi Amordea,
>>>>>>
>>>>>> On Mon, Dec 8, 2014 at 11:20 AM, Amordea Whiteoak <amordea@gmail.com> wrote:
>>>>>>> My apologies if my bug report was inadequate. It is the first upstream
>>>>>>> report I've ever filed, though I did attempt to give all the
>>>>>>> information they requested to the best of my ability.
>>>>>>
>>>>>> Oh, no, I was not complaining about your way of reporting the bug. I
>>>>>> know that it can be difficult for users to report _and_ provide all
>>>>>> the necessary information unless you already know a little bit about
>>>>>> the communities, how they work and what tool they use.
>>>>>> My complain was more that the way it was triaged: try an upstream
>>>>>> kernel; oh, does not work; send it upstream because it's a "poor
>>>>>> driver implementation". Whereas here, there may be any part of the
>>>>>> stack involved unless we look at the evemu-record (which is the output
>>>>>> of the kernel BTW). And saying that the driver is badly designed
>>>>>> really does not help...
>>>>>> Last, the "meta bug" they have is either a problem in the kernel
>>>>>> drivers they ship, or a not up to date Xorg stack. FWIW, I don't think
>>>>>> we have this on Fedora.
>>>>>>
>>>>>> Anyway, thanks for the explanations that you give in the next
>>>>>> paragraph, it gives a more comprehensive bug report :)
>>>>>>
>>>>>>>
>>>>>>> If it helps: to be clear about the design of this clickpad, it is one
>>>>>>> where the entire pad is touch-sensitive, even the area over the
>>>>>>> hardware click buttons which are on the bottom. The entire pad is one
>>>>>>> piece, so the pad itself shifts when you click a button. The
>>>>>>> malfunction occurs whenever any of these buttons are clicked, but the
>>>>>>> simulated clicks (tapping on the pad) behave adequately and do not
>>>>>>> cause any mouse input lock-ups. The malfunction itself causes ALL
>>>>>>> subsequent mouse clicks from any source (including a USB mouse) to
>>>>>>> only act in the spot where the first hardware click from the clickpad
>>>>>>> was performed and cannot be adjusted until the clickpad has been
>>>>>>> disabled (xinput disable <id>). The hardware buttons on the clickpad
>>>>>>> itself do not register as clicks at all, they only cause all mouse
>>>>>>> input to malfunction as previously described.
>>>>>>>
>>>>>>> I am enclosing the requested evemu-record data. This is a recording of
>>>>>>> my clicking the left hardware click button three times in rapid
>>>>>>> succession, but failure generally occurs after the first click.
>>>>>>
>>>>>> Many thanks for the logs. So here, I can see that when you click on
>>>>>> the touchpad, both BTN_LEFT and BTN_RIGHT are emitted, but they are
>>>>>> never released :) I do not see either the 2 other clicks.
>>>>>> So yes, here the driver is at fault and misses to release the clicks.
>>>>>> This infers the cross-device problem in X BTW.
>>>>>>
>>>>>>>
>>>>>>> A curious behavior I noticed in the process of getting this recording
>>>>>>> is that on the first click, I received a pasted text line in my
>>>>>>> terminal. I could not reproduce this behavior by doing an
>>>>>>> enable/disable cycle on the trackpad, but to confirm I rebooted a few
>>>>>>> times to test and sure enough, the very first click each boot triggers
>>>>>>> a clipboard paste event.
>>>>>>
>>>>>> You must have the middle button emulation enabled in Xorg (hitting
>>>>>> both left and right button will trigger a middle button). So when we
>>>>>> will be able to fix this bug, the spurious middle click should
>>>>>> disappear.
>>>>>>
>>>>>>>
>>>>>>> If there is any more information I can provide, please let me know.
>>>>>>
>>>>>> Ideally, I'd like to punt this one to Andrew, but I think we would be
>>>>>> grateful if you could also provide 2 more things:
>>>>>> - the dmesg when "i2c_hid.debug=1" is appended to the kernel boot line
>>>>>> (without the quotes)
>>>>>> - the hid-recorder output when you trigger the bug
>>>>>>
>>>>>> hid-recorder should be installed from sources in Ubuntu I guess:
>>>>>> http://bentiss.github.io/hid-replay-docs/
>>>>>>
>>>>>> The hid-recorder output might not be absolutely needed, so as long as
>>>>>> we have the dmesg with i2c_hid.debug=1, we should be fine.
>>>>>>
>>>>>> Cheers,
>>>>>> Benjamin
>>>>>>
>>>>>>>
>>>>>>> Thank you!
>>>>>>>
>>>>>>> On Mon, Dec 8, 2014 at 10:01 AM, Benjamin Tissoires
>>>>>>> <benjamin.tissoires@gmail.com> wrote:
>>>>>>>> Hi Amordea,
>>>>>>>>
>>>>>>>> I must say, the bug triaging is worse and worse with ubuntu :(
>>>>>>>>
>>>>>>>> From the bug description, I can not tell if the problem lies in the
>>>>>>>> kernel, or if it is the synaptics input driver or the xserver which is
>>>>>>>> in fault. I would be tempted to say that the problem lies in the upper
>>>>>>>> layers given the cross-devices problem.
>>>>>>>>
>>>>>>>> Anyway, to be able to understand the problem, we will need to get an
>>>>>>>> evemu-record output of your device when you are reproducing the bug.
>>>>>>>> You can find evemu in your distribution channels, or here:
>>>>>>>> http://www.freedesktop.org/wiki/Evemu/
>>>>>>>>
>>>>>>>> Given that you have an hid-rmi/i2c device, I am adding Andrew in CC,
>>>>>>>> and Peter for the upper layers if there is anything wrong there.
>>>>>>>>
>>>>>>>> Cheers,
>>>>>>>> Benjamin
>>>>>>>>
>>>>>>>> On Sun, Dec 7, 2014 at 5:50 PM, Amordea Whiteoak <amordea@gmail.com> wrote:
>>>>>>>>> Original Bug Report:
>>>>>>>>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1398533
>>>>>>>>>
>>>>>>>>> Bug Description: After clicking once at the bottom of my clickpad on
>>>>>>>>> either button, if I move my cursor elsewhere on the screen, and then
>>>>>>>>> subsequently click again (with either clickpad or external mouse this
>>>>>>>>> time) it registers a click at the location where my cursor icon was
>>>>>>>>> originally. I can continue to move my cursor anywhere on the screen,
>>>>>>>>> and it still registers the click in the original location.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> cat /proc/version
>>>>>>>>> Linux version 3.18.0-031800rc7-generic (apw@gomeisa) (gcc version
>>>>>>>>> 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201411302035 SMP Mon Dec 1
>>>>>>>>> 01:36:38 UTC 2014
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> lsb_release -rd
>>>>>>>>> Description: Ubuntu 14.10
>>>>>>>>> Release: 14.10
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> sh /usr/src/linux-headers-3.18.0-031800rc7/scripts/ver_linux
>>>>>>>>> If some fields are empty or look unusual you may have an old version.
>>>>>>>>> Compare to the current minimal requirements in Documentation/Changes.
>>>>>>>>>
>>>>>>>>> Linux woprjr 3.18.0-031800rc7-generic #201411302035 SMP Mon Dec 1
>>>>>>>>> 01:36:38 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux
>>>>>>>>>
>>>>>>>>> Gnu C
>>>>>>>>> /usr/src/linux-headers-3.18.0-031800rc7/scripts/ver_linux:
>>>>>>>>> /usr/src/linux-headers-3.18.0-031800rc7/scripts/ver_linux: 20:
>>>>>>>>> /usr/src/linux-headers-3.18.0-031800rc7/scripts/ver_linux: ld: not
>>>>>>>>> found
>>>>>>>>> binutils
>>>>>>>>> util-linux             2.25.1
>>>>>>>>> mount                  debug
>>>>>>>>> module-init-tools      18
>>>>>>>>> e2fsprogs              1.42.10
>>>>>>>>> PPP                    2.4.5
>>>>>>>>> Linux C Library        2.19
>>>>>>>>> Dynamic linker (ldd)   2.19
>>>>>>>>> Procps                 3.3.9
>>>>>>>>> Net-tools              1.60
>>>>>>>>> Kbd                    1.15.5
>>>>>>>>> Sh-utils               8.23
>>>>>>>>> wireless-tools         30
>>>>>>>>> Modules Loaded         snd_hda_codec_hdmi snd_hda_codec_realtek
>>>>>>>>> snd_hda_codec_generic ctr ccm joydev hp_wmi hid_rmi sparse_keymap
>>>>>>>>> rfcomm bnep arc4 rtl8723be btcoexist rtl8723_common intel_rapl
>>>>>>>>> uvcvideo rtl_pci intel_soc_dts_thermal intel_powerclamp
>>>>>>>>> videobuf2_vmalloc videobuf2_memops coretemp rtlwifi videobuf2_core
>>>>>>>>> v4l2_common videodev mac80211 media kvm cfg80211 btusb
>>>>>>>>> crct10dif_pclmul crc32_pclmul bluetooth ghash_clmulni_intel serio_raw
>>>>>>>>> cryptd wmi snd_hda_intel snd_hda_controller snd_hda_codec snd_hwdep
>>>>>>>>> snd_seq_midi snd_seq_midi_event snd_rawmidi snd_soc_rt5640
>>>>>>>>> snd_soc_rl6231 snd_soc_core snd_compress dw_dmac i915
>>>>>>>>> snd_pcm_dmaengine dw_dmac_core snd_seq int3400_thermal int3403_thermal
>>>>>>>>> acpi_thermal_rel nls_iso8859_1 snd_pcm i2c_hid video
>>>>>>>>> intel_smartconnect drm_kms_helper hid drm rfkill_gpio snd_seq_device
>>>>>>>>> i2c_designware_platform i2c_algo_bit snd_soc_sst_acpi 8250_dw
>>>>>>>>> snd_timer i2c_designware_core hp_wireless shpchp spi_pxa2xx_platform
>>>>>>>>> snd pwm_lpss_platform lpc_ich mac_hid mei_txe pwm_lpss iosf_mbi mei
>>>>>>>>> soundcore parport_pc ppdev lp parport uas usb_storage mmc_block
>>>>>>>>> sdhci_acpi sdhci
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> cat /proc/cpuinfo
>>>>>>>>> processor : 0
>>>>>>>>> vendor_id : GenuineIntel
>>>>>>>>> cpu family : 6
>>>>>>>>> model : 55
>>>>>>>>> model name : Intel(R) Celeron(R) CPU  N2840  @ 2.16GHz
>>>>>>>>> stepping : 8
>>>>>>>>> microcode : 0x829
>>>>>>>>> cpu MHz : 499.741
>>>>>>>>> cache size : 1024 KB
>>>>>>>>> physical id : 0
>>>>>>>>> siblings : 2
>>>>>>>>> core id : 0
>>>>>>>>> cpu cores : 2
>>>>>>>>> apicid : 0
>>>>>>>>> initial apicid : 0
>>>>>>>>> fpu : yes
>>>>>>>>> fpu_exception : yes
>>>>>>>>> cpuid level : 11
>>>>>>>>> wp : yes
>>>>>>>>> flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
>>>>>>>>> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
>>>>>>>>> rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
>>>>>>>>> nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2
>>>>>>>>> ssse3 cx16 xtpr pdcm sse4_1 sse4_2 movbe popcnt tsc_deadline_timer
>>>>>>>>> rdrand lahf_lm 3dnowprefetch ida arat epb dtherm tpr_shadow vnmi
>>>>>>>>> flexpriority ept vpid tsc_adjust smep erms
>>>>>>>>> bugs :
>>>>>>>>> bogomips : 4326.40
>>>>>>>>> clflush size : 64
>>>>>>>>> cache_alignment : 64
>>>>>>>>> address sizes : 36 bits physical, 48 bits virtual
>>>>>>>>> power management:
>>>>>>>>>
>>>>>>>>> processor : 1
>>>>>>>>> vendor_id : GenuineIntel
>>>>>>>>> cpu family : 6
>>>>>>>>> model : 55
>>>>>>>>> model name : Intel(R) Celeron(R) CPU  N2840  @ 2.16GHz
>>>>>>>>> stepping : 8
>>>>>>>>> microcode : 0x829
>>>>>>>>> cpu MHz : 499.741
>>>>>>>>> cache size : 1024 KB
>>>>>>>>> physical id : 0
>>>>>>>>> siblings : 2
>>>>>>>>> core id : 1
>>>>>>>>> cpu cores : 2
>>>>>>>>> apicid : 2
>>>>>>>>> initial apicid : 2
>>>>>>>>> fpu : yes
>>>>>>>>> fpu_exception : yes
>>>>>>>>> cpuid level : 11
>>>>>>>>> wp : yes
>>>>>>>>> flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
>>>>>>>>> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
>>>>>>>>> rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
>>>>>>>>> nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2
>>>>>>>>> ssse3 cx16 xtpr pdcm sse4_1 sse4_2 movbe popcnt tsc_deadline_timer
>>>>>>>>> rdrand lahf_lm 3dnowprefetch ida arat epb dtherm tpr_shadow vnmi
>>>>>>>>> flexpriority ept vpid tsc_adjust smep erms
>>>>>>>>> bugs :
>>>>>>>>> bogomips : 4326.40
>>>>>>>>> clflush size : 64
>>>>>>>>> cache_alignment : 64
>>>>>>>>> address sizes : 36 bits physical, 48 bits virtual
>>>>>>>>> power management:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> cat /proc/modules
>>>>>>>>> snd_hda_codec_hdmi 52670 1 - Live 0x0000000000000000
>>>>>>>>> snd_hda_codec_realtek 80420 1 - Live 0x0000000000000000
>>>>>>>>> snd_hda_codec_generic 69995 1 snd_hda_codec_realtek, Live 0x0000000000000000
>>>>>>>>> ctr 13193 1 - Live 0x0000000000000000
>>>>>>>>> ccm 17856 1 - Live 0x0000000000000000
>>>>>>>>> joydev 17587 0 - Live 0x0000000000000000
>>>>>>>>> hp_wmi 14017 0 - Live 0x0000000000000000
>>>>>>>>> hid_rmi 18060 0 - Live 0x0000000000000000
>>>>>>>>> sparse_keymap 13890 1 hp_wmi, Live 0x0000000000000000
>>>>>>>>> rfcomm 75066 8 - Live 0x0000000000000000
>>>>>>>>> bnep 23980 2 - Live 0x0000000000000000
>>>>>>>>> arc4 12573 2 - Live 0x0000000000000000
>>>>>>>>> rtl8723be 96097 0 - Live 0x0000000000000000
>>>>>>>>> btcoexist 51822 1 rtl8723be, Live 0x0000000000000000
>>>>>>>>> rtl8723_common 23662 1 rtl8723be, Live 0x0000000000000000
>>>>>>>>> intel_rapl 19196 0 - Live 0x0000000000000000
>>>>>>>>> uvcvideo 86723 0 - Live 0x0000000000000000
>>>>>>>>> rtl_pci 27417 1 rtl8723be, Live 0x0000000000000000
>>>>>>>>> intel_soc_dts_thermal 13523 0 - Live 0x0000000000000000
>>>>>>>>> intel_powerclamp 19099 0 - Live 0x0000000000000000
>>>>>>>>> videobuf2_vmalloc 13216 1 uvcvideo, Live 0x0000000000000000
>>>>>>>>> videobuf2_memops 13362 1 videobuf2_vmalloc, Live 0x0000000000000000
>>>>>>>>> coretemp 13638 0 - Live 0x0000000000000000
>>>>>>>>> rtlwifi 74744 2 rtl8723be,rtl_pci, Live 0x0000000000000000
>>>>>>>>> videobuf2_core 51547 1 uvcvideo, Live 0x0000000000000000
>>>>>>>>> v4l2_common 15715 1 videobuf2_core, Live 0x0000000000000000
>>>>>>>>> videodev 163831 3 uvcvideo,videobuf2_core,v4l2_common, Live 0x0000000000000000
>>>>>>>>> mac80211 697159 3 rtl8723be,rtl_pci,rtlwifi, Live 0x0000000000000000
>>>>>>>>> media 22008 2 uvcvideo,videodev, Live 0x0000000000000000
>>>>>>>>> kvm 475237 0 - Live 0x0000000000000000
>>>>>>>>> cfg80211 520257 2 rtlwifi,mac80211, Live 0x0000000000000000
>>>>>>>>> btusb 32691 0 - Live 0x0000000000000000
>>>>>>>>> crct10dif_pclmul 14268 0 - Live 0x0000000000000000
>>>>>>>>> crc32_pclmul 13180 0 - Live 0x0000000000000000
>>>>>>>>> bluetooth 486890 22 rfcomm,bnep,btusb, Live 0x0000000000000000
>>>>>>>>> ghash_clmulni_intel 13230 0 - Live 0x0000000000000000
>>>>>>>>> serio_raw 13483 0 - Live 0x0000000000000000
>>>>>>>>> cryptd 20531 1 ghash_clmulni_intel, Live 0x0000000000000000
>>>>>>>>> wmi 19379 1 hp_wmi, Live 0x0000000000000000
>>>>>>>>> snd_hda_intel 30824 1 - Live 0x0000000000000000
>>>>>>>>> snd_hda_controller 32234 1 snd_hda_intel, Live 0x0000000000000000
>>>>>>>>> snd_hda_codec 144641 5
>>>>>>>>> snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_controller,
>>>>>>>>> Live 0x0000000000000000
>>>>>>>>> snd_hwdep 17709 1 snd_hda_codec, Live 0x0000000000000000
>>>>>>>>> snd_seq_midi 13564 0 - Live 0x0000000000000000
>>>>>>>>> snd_seq_midi_event 14899 1 snd_seq_midi, Live 0x0000000000000000
>>>>>>>>> snd_rawmidi 31197 1 snd_seq_midi, Live 0x0000000000000000
>>>>>>>>> snd_soc_rt5640 93325 0 - Live 0x0000000000000000
>>>>>>>>> snd_soc_rl6231 13037 1 snd_soc_rt5640, Live 0x0000000000000000
>>>>>>>>> snd_soc_core 207780 1 snd_soc_rt5640, Live 0x0000000000000000
>>>>>>>>> snd_compress 19395 1 snd_soc_core, Live 0x0000000000000000
>>>>>>>>> dw_dmac 12835 0 - Live 0x0000000000000000
>>>>>>>>> i915 1031996 2 - Live 0x0000000000000000
>>>>>>>>> snd_pcm_dmaengine 15229 1 snd_soc_core, Live 0x0000000000000000
>>>>>>>>> dw_dmac_core 28558 1 dw_dmac, Live 0x0000000000000000
>>>>>>>>> snd_seq 63540 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
>>>>>>>>> int3400_thermal 13040 0 - Live 0x0000000000000000
>>>>>>>>> int3403_thermal 13255 0 - Live 0x0000000000000000
>>>>>>>>> acpi_thermal_rel 13807 1 int3400_thermal, Live 0x0000000000000000
>>>>>>>>> nls_iso8859_1 12713 2 - Live 0x0000000000000000
>>>>>>>>> snd_pcm 106273 7
>>>>>>>>> snd_hda_codec_hdmi,snd_hda_intel,snd_hda_controller,snd_hda_codec,snd_soc_rt5640,snd_soc_core,snd_pcm_dmaengine,
>>>>>>>>> Live 0x0000000000000000
>>>>>>>>> i2c_hid 19065 0 - Live 0x0000000000000000
>>>>>>>>> video 20649 1 i915, Live 0x0000000000000000
>>>>>>>>> intel_smartconnect 12637 0 - Live 0x0000000000000000
>>>>>>>>> drm_kms_helper 99802 1 i915, Live 0x0000000000000000
>>>>>>>>> hid 110572 2 hid_rmi,i2c_hid, Live 0x0000000000000000
>>>>>>>>> drm 323675 4 i915,drm_kms_helper, Live 0x0000000000000000
>>>>>>>>> rfkill_gpio 12761 0 - Live 0x0000000000000000
>>>>>>>>> snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x0000000000000000
>>>>>>>>> i2c_designware_platform 13025 0 - Live 0x0000000000000000
>>>>>>>>> i2c_algo_bit 13564 1 i915, Live 0x0000000000000000
>>>>>>>>> snd_soc_sst_acpi 13007 0 - Live 0x0000000000000000
>>>>>>>>> 8250_dw 13474 0 - Live 0x0000000000000000
>>>>>>>>> snd_timer 30118 2 snd_seq,snd_pcm, Live 0x0000000000000000
>>>>>>>>> i2c_designware_core 14990 1 i2c_designware_platform, Live 0x0000000000000000
>>>>>>>>> hp_wireless 12637 0 - Live 0x0000000000000000
>>>>>>>>> shpchp 37216 0 - Live 0x0000000000000000
>>>>>>>>> spi_pxa2xx_platform 23256 0 - Live 0x0000000000000000
>>>>>>>>> snd 84025 15 snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_rawmidi,snd_soc_core,snd_compress,snd_seq,snd_pcm,snd_seq_device,snd_timer,
>>>>>>>>> Live 0x0000000000000000
>>>>>>>>> pwm_lpss_platform 12703 0 - Live 0x0000000000000000
>>>>>>>>> lpc_ich 21176 0 - Live 0x0000000000000000
>>>>>>>>> mac_hid 13275 0 - Live 0x0000000000000000
>>>>>>>>> mei_txe 19808 0 - Live 0x0000000000000000
>>>>>>>>> pwm_lpss 13281 1 pwm_lpss_platform, Live 0x0000000000000000
>>>>>>>>> iosf_mbi 13865 1 intel_soc_dts_thermal, Live 0x0000000000000000
>>>>>>>>> mei 88473 1 mei_txe, Live 0x0000000000000000
>>>>>>>>> soundcore 15091 2 snd_hda_codec,snd, Live 0x0000000000000000
>>>>>>>>> parport_pc 32909 0 - Live 0x0000000000000000
>>>>>>>>> ppdev 17711 0 - Live 0x0000000000000000
>>>>>>>>> lp 17799 0 - Live 0x0000000000000000
>>>>>>>>> parport 42481 3 parport_pc,ppdev,lp, Live 0x0000000000000000
>>>>>>>>> uas 22673 0 - Live 0x0000000000000000
>>>>>>>>> usb_storage 67010 2 uas, Live 0x0000000000000000
>>>>>>>>> mmc_block 36596 4 - Live 0x0000000000000000
>>>>>>>>> sdhci_acpi 13502 0 - Live 0x0000000000000000
>>>>>>>>> sdhci 43929 1 sdhci_acpi, Live 0x0000000000000000
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> /proc/ioports
>>>>>>>>> 0000-006f : PCI Bus 0000:00
>>>>>>>>>   0000-001f : dma1
>>>>>>>>>   0020-0021 : pic1
>>>>>>>>>   0040-0043 : timer0
>>>>>>>>>   0050-0053 : timer1
>>>>>>>>>   0060-0060 : keyboard
>>>>>>>>>   0062-0062 : PNP0C09:00
>>>>>>>>>     0062-0062 : EC data
>>>>>>>>>   0064-0064 : keyboard
>>>>>>>>>   0066-0066 : PNP0C09:00
>>>>>>>>>     0066-0066 : EC cmd
>>>>>>>>> 0070-0077 : rtc0
>>>>>>>>> 0078-0cf7 : PCI Bus 0000:00
>>>>>>>>>   0080-008f : dma page reg
>>>>>>>>>   00a0-00a1 : pic2
>>>>>>>>>   00c0-00df : dma2
>>>>>>>>>   00f0-00ff : fpu
>>>>>>>>>   03f8-03ff : serial
>>>>>>>>>   0400-047f : pnp 00:01
>>>>>>>>>     0400-0403 : ACPI PM1a_EVT_BLK
>>>>>>>>>     0404-0405 : ACPI PM1a_CNT_BLK
>>>>>>>>>     0408-040b : ACPI PM_TMR
>>>>>>>>>     0420-042f : ACPI GPE0_BLK
>>>>>>>>>     0430-0433 : iTCO_wdt
>>>>>>>>>     0450-0450 : ACPI PM2_CNT_BLK
>>>>>>>>>     0460-047f : iTCO_wdt
>>>>>>>>>   0500-05fe : pnp 00:01
>>>>>>>>>   0600-061f : pnp 00:01
>>>>>>>>>   0680-069f : pnp 00:01
>>>>>>>>> 0cf8-0cff : PCI conf1
>>>>>>>>> 0d00-ffff : PCI Bus 0000:00
>>>>>>>>>   1000-1fff : PCI Bus 0000:01
>>>>>>>>>     1000-10ff : 0000:01:00.0
>>>>>>>>>       1000-10ff : rtl_pci
>>>>>>>>>   2000-201f : 0000:00:1f.3
>>>>>>>>>   2050-2057 : 0000:00:02.0
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> cat /proc/iomem
>>>>>>>>> 00000000-00000fff : reserved
>>>>>>>>> 00001000-0006efff : System RAM
>>>>>>>>> 0006f000-0006ffff : ACPI Non-volatile Storage
>>>>>>>>> 00070000-00084fff : System RAM
>>>>>>>>> 00085000-00086fff : reserved
>>>>>>>>> 00087000-00087fff : System RAM
>>>>>>>>> 00088000-0009ffff : reserved
>>>>>>>>> 000a0000-000bffff : PCI Bus 0000:00
>>>>>>>>> 000c0000-000dffff : PCI Bus 0000:00
>>>>>>>>> 000e0000-000fffff : PCI Bus 0000:00
>>>>>>>>>   000f0000-000fffff : System ROM
>>>>>>>>> 00100000-1effffff : System RAM
>>>>>>>>>   02000000-027b8537 : Kernel code
>>>>>>>>>   027b8538-02d2123f : Kernel data
>>>>>>>>>   02e87000-02fcffff : Kernel bss
>>>>>>>>> 1f000000-1f0fffff : reserved
>>>>>>>>> 1f100000-1fffffff : System RAM
>>>>>>>>> 20000000-200fffff : reserved
>>>>>>>>> 20100000-75867fff : System RAM
>>>>>>>>> 75868000-75892fff : reserved
>>>>>>>>> 75893000-78892fff : System RAM
>>>>>>>>> 78893000-78922fff : reserved
>>>>>>>>> 78923000-791a3fff : reserved
>>>>>>>>> 791a4000-792a2fff : ACPI Non-volatile Storage
>>>>>>>>> 792a3000-792e2fff : ACPI Tables
>>>>>>>>> 792e3000-79ffffff : System RAM
>>>>>>>>> 7a000000-7affffff : RAM buffer
>>>>>>>>> 7b000000-7effffff : reserved
>>>>>>>>>   7b000000-7effffff : Graphics Stolen Memory
>>>>>>>>> 80000000-907ffffe : PCI Bus 0000:00
>>>>>>>>>   80000000-8fffffff : 0000:00:02.0
>>>>>>>>>   90000000-903fffff : 0000:00:02.0
>>>>>>>>>   90400000-904fffff : PCI Bus 0000:01
>>>>>>>>>     90400000-90403fff : 0000:01:00.0
>>>>>>>>>       90400000-90403fff : rtl_pci
>>>>>>>>>   90500000-905fffff : 0000:00:1a.0
>>>>>>>>>     90500000-905fffff : mei_txe
>>>>>>>>>   90600000-906fffff : 0000:00:1a.0
>>>>>>>>>     90600000-906fffff : mei_txe
>>>>>>>>>   90700000-9070ffff : 0000:00:14.0
>>>>>>>>>     90700000-9070ffff : xhci-hcd
>>>>>>>>>   90710000-90713fff : 0000:00:1b.0
>>>>>>>>>     90710000-90713fff : ICH HD audio
>>>>>>>>>   90718000-9071801f : 0000:00:1f.3
>>>>>>>>> 90800000-90800fff : 80860F14:01
>>>>>>>>>   90800000-90800fff : 80860F14:01
>>>>>>>>> 90803000-90803fff : 80860F41:00
>>>>>>>>>   90803000-90803fff : 80860F41:00
>>>>>>>>> 90804000-90807fff : INTL9C60:01
>>>>>>>>>   90804000-90807fff : INTL9C60:01
>>>>>>>>> 90c00000-90ffffff : PCI Bus 0000:00
>>>>>>>>> e0000000-e3ffffff : PCI MMCONFIG 0000 [bus 00-3f]
>>>>>>>>>   e00000d0-e00000db : INT33BD:00
>>>>>>>>>   e00f8000-e00f8fff : reserved
>>>>>>>>> fec00000-fec003ff : IOAPIC 0
>>>>>>>>> fed00000-fed003ff : HPET 0
>>>>>>>>>   fed00000-fed003ff : PNP0103:00
>>>>>>>>> fed01000-fed01fff : reserved
>>>>>>>>>   fed01000-fed01fff : pnp 00:03
>>>>>>>>> fed03000-fed03fff : pnp 00:03
>>>>>>>>>   fed03008-fed0300c : iTCO_wdt
>>>>>>>>> fed04000-fed04fff : pnp 00:03
>>>>>>>>> fed05000-fed057ff : INT3401:00
>>>>>>>>> fed08000-fed08fff : pnp 00:03
>>>>>>>>> fed0c000-fed0cfff : INT33FC:00
>>>>>>>>>   fed0c000-fed0cfff : INT33FC:00
>>>>>>>>> fed0d000-fed0dfff : INT33FC:01
>>>>>>>>>   fed0d000-fed0dfff : INT33FC:01
>>>>>>>>> fed0e000-fed0efff : INT33FC:02
>>>>>>>>>   fed0e000-fed0efff : INT33FC:02
>>>>>>>>> fed1c000-fed1cfff : pnp 00:03
>>>>>>>>> fed40000-fed44fff : pnp 00:01
>>>>>>>>> fee00000-feefffff : pnp 00:03
>>>>>>>>>   fee00000-fee00fff : Local APIC
>>>>>>>>> fef00000-feffffff : pnp 00:03
>>>>>>>>> ff000000-ffffffff : INT0800:00
>>>>>>>>>   ffb80000-ffffffff : reserved
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> sudo lspci -vvv
>>>>>>>>> 00:00.0 Host bridge: Intel Corporation Atom Processor Z36xxx/Z37xxx
>>>>>>>>> Series SoC Transaction Register (rev 0e)
>>>>>>>>> Subsystem: Hewlett-Packard Company Device 8023
>>>>>>>>> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>>>>>>>>> Stepping- SERR- FastB2B- DisINTx-
>>>>>>>>> Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
>>>>>>>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>>>>>>> Latency: 0
>>>>>>>>> Kernel driver in use: iosf_mbi_pci
>>>>>>>>>
>>>>>>>>> 00:02.0 VGA compatible controller: Intel Corporation Atom Processor
>>>>>>>>> Z36xxx/Z37xxx Series Graphics & Display (rev 0e) (prog-if 00 [VGA
>>>>>>>>> controller])
>>>>>>>>> Subsystem: Hewlett-Packard Company Device 8023
>>>>>>>>> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>>>>>>>>> Stepping- SERR- FastB2B- DisINTx+
>>>>>>>>> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
>>>>>>>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>>>>>>> Latency: 0
>>>>>>>>> Interrupt: pin A routed to IRQ 263
>>>>>>>>> Region 0: Memory at 90000000 (32-bit, non-prefetchable) [size=4M]
>>>>>>>>> Region 2: Memory at 80000000 (32-bit, prefetchable) [size=256M]
>>>>>>>>> Region 4: I/O ports at 2050 [size=8]
>>>>>>>>> Expansion ROM at <unassigned> [disabled]
>>>>>>>>> Capabilities: [d0] Power Management version 2
>>>>>>>>> Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>>>>>>>>> Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>>>>>>>>> Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
>>>>>>>>> Address: fee0300c  Data: 4162
>>>>>>>>> Capabilities: [b0] Vendor Specific Information: Len=07 <?>
>>>>>>>>> Kernel driver in use: i915
>>>>>>>>>
>>>>>>>>> 00:14.0 USB controller: Intel Corporation Atom Processor Z36xxx/Z37xxx
>>>>>>>>> Series USB xHCI (rev 0e) (prog-if 30 [XHCI])
>>>>>>>>> Subsystem: Hewlett-Packard Company Device 8023
>>>>>>>>> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>>>>>>>>> Stepping- SERR- FastB2B- DisINTx+
>>>>>>>>> Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
>>>>>>>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>>>>>>> Latency: 0
>>>>>>>>> Interrupt: pin A routed to IRQ 261
>>>>>>>>> Region 0: Memory at 90700000 (64-bit, non-prefetchable) [size=64K]
>>>>>>>>> Capabilities: [70] Power Management version 2
>>>>>>>>> Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
>>>>>>>>> Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>>>>>>>>> Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
>>>>>>>>> Address: 00000000fee0300c  Data: 41d1
>>>>>>>>> Kernel driver in use: xhci_hcd
>>>>>>>>>
>>>>>>>>> 00:1a.0 Encryption controller: Intel Corporation Atom Processor
>>>>>>>>> Z36xxx/Z37xxx Series Trusted Execution Engine (rev 0e)
>>>>>>>>> Subsystem: Hewlett-Packard Company Device 8023
>>>>>>>>> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>>>>>>>>> Stepping- SERR+ FastB2B- DisINTx+
>>>>>>>>> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
>>>>>>>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>>>>>>> Latency: 0, Cache Line Size: 64 bytes
>>>>>>>>> Interrupt: pin A routed to IRQ 262
>>>>>>>>> Region 0: Memory at 90600000 (32-bit, non-prefetchable) [size=1M]
>>>>>>>>> Region 1: Memory at 90500000 (32-bit, non-prefetchable) [size=1M]
>>>>>>>>> Capabilities: [80] Power Management version 3
>>>>>>>>> Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold-)
>>>>>>>>> Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>>>>>>>>> Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit-
>>>>>>>>> Address: fee0300c  Data: 4122
>>>>>>>>> Kernel driver in use: mei_txe
>>>>>>>>>
>>>>>>>>> 00:1b.0 Audio device: Intel Corporation Atom Processor Z36xxx/Z37xxx
>>>>>>>>> Series High Definition Audio Controller (rev 0e)
>>>>>>>>> Subsystem: Hewlett-Packard Company Device 8023
>>>>>>>>> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>>>>>>>>> Stepping- SERR- FastB2B- DisINTx+
>>>>>>>>> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
>>>>>>>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>>>>>>> Latency: 0, Cache Line Size: 64 bytes
>>>>>>>>> Interrupt: pin A routed to IRQ 264
>>>>>>>>> Region 0: Memory at 90710000 (64-bit, non-prefetchable) [size=16K]
>>>>>>>>> Capabilities: [50] Power Management version 2
>>>>>>>>> Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
>>>>>>>>> Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>>>>>>>>> Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
>>>>>>>>> Address: 00000000fee0300c  Data: 4182
>>>>>>>>> Kernel driver in use: snd_hda_intel
>>>>>>>>>
>>>>>>>>> 00:1c.0 PCI bridge: Intel Corporation Device 0f48 (rev 0e) (prog-if 00
>>>>>>>>> [Normal decode])
>>>>>>>>> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>>>>>>>>> Stepping- SERR- FastB2B- DisINTx-
>>>>>>>>> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
>>>>>>>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>>>>>>> Latency: 0, Cache Line Size: 64 bytes
>>>>>>>>> Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>>>>>>>>> I/O behind bridge: 00001000-00001fff
>>>>>>>>> Memory behind bridge: 90400000-904fffff
>>>>>>>>> Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
>>>>>>>>> Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
>>>>>>>>> <TAbort- <MAbort+ <SERR- <PERR-
>>>>>>>>> BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>>>>>>>>> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>>>>>>>>> Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
>>>>>>>>> DevCap: MaxPayload 128 bytes, PhantFunc 0
>>>>>>>>> ExtTag- RBE+
>>>>>>>>> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>>>>>>>>> RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>>>>>>>>> MaxPayload 128 bytes, MaxReadReq 128 bytes
>>>>>>>>> DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
>>>>>>>>> LnkCap: Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s
>>>>>>>>> <512ns, L1 <4us
>>>>>>>>> ClockPM- Surprise- LLActRep+ BwNot+
>>>>>>>>> LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
>>>>>>>>> ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>>>>>>>>> LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+
>>>>>>>>> BWMgmt+ ABWMgmt-
>>>>>>>>> SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
>>>>>>>>> Slot #0, PowerLimit 10.000W; Interlock- NoCompl+
>>>>>>>>> SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
>>>>>>>>> Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>>>>>>>>> SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
>>>>>>>>> Changed: MRL- PresDet- LinkState+
>>>>>>>>> RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
>>>>>>>>> RootCap: CRSVisible-
>>>>>>>>> RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>>>>>>>>> DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF Not
>>>>>>>>> Supported ARIFwd-
>>>>>>>>> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF
>>>>>>>>> Disabled ARIFwd-
>>>>>>>>> LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
>>>>>>>>>  Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
>>>>>>>>> ComplianceSOS-
>>>>>>>>>  Compliance De-emphasis: -6dB
>>>>>>>>> LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
>>>>>>>>> EqualizationPhase1-
>>>>>>>>>  EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
>>>>>>>>> Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
>>>>>>>>> Address: 00000000  Data: 0000
>>>>>>>>> Capabilities: [90] Subsystem: Hewlett-Packard Company Device 8023
>>>>>>>>> Capabilities: [a0] Power Management version 3
>>>>>>>>> Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
>>>>>>>>> Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>>>>>>>>> Kernel driver in use: pcieport
>>>>>>>>>
>>>>>>>>> 00:1f.0 ISA bridge: Intel Corporation Atom Processor Z36xxx/Z37xxx
>>>>>>>>> Series Power Control Unit (rev 0e)
>>>>>>>>> Subsystem: Hewlett-Packard Company Device 8023
>>>>>>>>> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>>>>>>>>> Stepping- SERR+ FastB2B- DisINTx-
>>>>>>>>> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
>>>>>>>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>>>>>>> Latency: 0
>>>>>>>>> Capabilities: [e0] Vendor Specific Information: Len=0c <?>
>>>>>>>>> Kernel driver in use: lpc_ich
>>>>>>>>>
>>>>>>>>> 00:1f.3 SMBus: Intel Corporation Device 0f12 (rev 0e)
>>>>>>>>> Subsystem: Hewlett-Packard Company Device 8023
>>>>>>>>> Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
>>>>>>>>> Stepping- SERR- FastB2B- DisINTx-
>>>>>>>>> Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
>>>>>>>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>>>>>>> Interrupt: pin B routed to IRQ 255
>>>>>>>>> Region 0: Memory at 90718000 (32-bit, non-prefetchable) [size=32]
>>>>>>>>> Region 4: I/O ports at 2000 [size=32]
>>>>>>>>> Capabilities: [50] Power Management version 3
>>>>>>>>> Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>>>>>>>>> Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>>>>>>>>>
>>>>>>>>> 01:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8723BE
>>>>>>>>> PCIe Wireless Network Adapter
>>>>>>>>> Subsystem: Hewlett-Packard Company Device 2231
>>>>>>>>> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>>>>>>>>> Stepping- SERR- FastB2B- DisINTx-
>>>>>>>>> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
>>>>>>>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>>>>>>> Latency: 0, Cache Line Size: 64 bytes
>>>>>>>>> Interrupt: pin A routed to IRQ 16
>>>>>>>>> Region 0: I/O ports at 1000 [size=256]
>>>>>>>>> Region 2: Memory at 90400000 (64-bit, non-prefetchable) [size=16K]
>>>>>>>>> Capabilities: [40] Power Management version 3
>>>>>>>>> Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
>>>>>>>>> Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>>>>>>>>> Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
>>>>>>>>> Address: 0000000000000000  Data: 0000
>>>>>>>>> Capabilities: [70] Express (v2) Endpoint, MSI 00
>>>>>>>>> DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, L1 <64us
>>>>>>>>> ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
>>>>>>>>> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>>>>>>>>> RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
>>>>>>>>> MaxPayload 128 bytes, MaxReadReq 512 bytes
>>>>>>>>> DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
>>>>>>>>> LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency
>>>>>>>>> L0s <512ns, L1 <64us
>>>>>>>>> ClockPM+ Surprise- LLActRep- BwNot-
>>>>>>>>> LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
>>>>>>>>> ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
>>>>>>>>> LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
>>>>>>>>> BWMgmt- ABWMgmt-
>>>>>>>>> DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR+, OBFF
>>>>>>>>> Via message/WAKE#
>>>>>>>>> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis+, LTR+, OBFF Disabled
>>>>>>>>> LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
>>>>>>>>>  Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
>>>>>>>>> ComplianceSOS-
>>>>>>>>>  Compliance De-emphasis: -6dB
>>>>>>>>> LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
>>>>>>>>> EqualizationPhase1-
>>>>>>>>>  EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
>>>>>>>>> Capabilities: [100 v2] Advanced Error Reporting
>>>>>>>>> UESta: DLP- SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
>>>>>>>>> MalfTLP- ECRC- UnsupReq- ACSViol-
>>>>>>>>> UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
>>>>>>>>> MalfTLP- ECRC- UnsupReq- ACSViol-
>>>>>>>>> UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
>>>>>>>>> MalfTLP+ ECRC- UnsupReq- ACSViol-
>>>>>>>>> CESta: RxErr+ BadTLP- BadDLLP+ Rollover- Timeout- NonFatalErr-
>>>>>>>>> CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>>>>>>>>> AERCap: First Error Pointer: 0d, GenCap+ CGenEn- ChkCap+ ChkEn-
>>>>>>>>> Capabilities: [140 v1] Device Serial Number 00-23-b7-fe-ff-4c-e0-00
>>>>>>>>> Capabilities: [150 v1] Latency Tolerance Reporting
>>>>>>>>> Max snoop latency: 71680ns
>>>>>>>>> Max no snoop latency: 71680ns
>>>>>>>>> Capabilities: [158 v1] L1 PM Substates
>>>>>>>>> L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
>>>>>>>>>   PortCommonModeRestoreTime=150us PortTPowerOnTime=150us
>>>>>>>>> Kernel driver in use: rtl8723be
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> cat /proc/scsi/scsi
>>>>>>>>> Attached devices:
>>>>>>>>> Host: scsi0 Channel: 00 Id: 00 Lun: 00
>>>>>>>>>   Vendor: Generic- Model: SD/MMC/MS PRO    Rev: 1.00
>>>>>>>>>   Type:   Direct-Access                    ANSI  SCSI revision: 04
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> ls /proc
>>>>>>>>> 1     12    14    1667  1745  18    1963  2345  292   35    470   55
>>>>>>>>> 7201  asound     execdomains  kmsg        pagetypeinfo   sysvipc
>>>>>>>>> 10    1218  1410  1685  1761  1804  2     2388  296   3573  471   554
>>>>>>>>> 728   buddyinfo  fb           kpagecount  partitions     thread-self
>>>>>>>>> 1020  125   142   1687  1764  1805  20    24    3     359   473   56
>>>>>>>>> 755   bus        filesystems  kpageflags  sched_debug    timer_list
>>>>>>>>> 1025  126   1420  1690  1767  1818  21    25    30    3623  474   57
>>>>>>>>> 76    cgroups    fs           loadavg     schedstat      timer_stats
>>>>>>>>> 1032  127   1423  17    1769  1828  2169  2528  31    378   485   585
>>>>>>>>> 77    cmdline    interrupts   locks       scsi           tty
>>>>>>>>> 1033  128   143   1701  1771  1853  2187  254   3181  3822  5     606
>>>>>>>>> 7886  consoles   iomem        mdstat      self           uptime
>>>>>>>>> 1038  129   1444  1710  1772  1876  2197  26    33    39    509   654
>>>>>>>>> 8     cpuinfo    ioports      meminfo     slabinfo       version
>>>>>>>>> 1042  13    1485  1718  1781  1883  2198  2670  3309  3932  516   655
>>>>>>>>> 8743  crypto     irq          misc        softirqs       vmallocinfo
>>>>>>>>> 1069  130   15    1722  1787  1893  22    2672  34    40    53    695
>>>>>>>>> 9     devices    kallsyms     modules     stat           vmstat
>>>>>>>>> 1070  131   1568  1725  1789  1896  2202  27    3419  41    539   7
>>>>>>>>> 9040  diskstats  kcore        mounts      swaps          zoneinfo
>>>>>>>>> 11    132   1645  1727  1792  19    2248  28    3433  468   542   709
>>>>>>>>> 9056  dma        keys         mtrr        sys
>>>>>>>>> 1144  1331  1655  1732  1796  1905  23    29    3437  469   5421  715
>>>>>>>>> acpi  driver     key-users    net         sysrq-trigger
>>>>>>>>> --
>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe linux-input" in
>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
