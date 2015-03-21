From: Tobias Naumann <tobias-naumann@gmx.net>
Subject: Re: PROBLEM: [Acer Aspire V3-371] Sometimes, cursor jumps around
 if touchpad is in use
Date: Sat, 21 Mar 2015 22:34:19 +0200
Message-ID: <550DD5CB.2080206@gmx.net>
References: <55035C3E.3020907@gmx.net>	<CAN+gG=GpMFY5KwQABBnJO0uvGGn5F7V6ctAKgLGfvLRqq2ERhQ@mail.gmail.com>	<5508448F.3030008@gmx.net> <CAN+gG=HbqrMLxGB1phhSSroARq2P0zrNmT45Er8csY_ktwOLzA@mail.gmail.com> <5508C749.2040403@synaptics.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010207070409060308040206"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:63759 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751539AbbCUUee (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 21 Mar 2015 16:34:34 -0400
In-Reply-To: <5508C749.2040403@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

This is a multi-part message in MIME format.
--------------010207070409060308040206
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

in the dmesg, I found

[    3.080594] hid-multitouch 0018:06CB:2991.0001: input,hidraw0: 
<UNKNOWN> HID v1.00 Mouse [SYN1B7F:00 06CB:2991] on

and there was only /dev/hidraw0 so I ran

$ sudo ./rmihidtool/rmihidtool -f /dev/hidraw1

which led to

firmware id: 1626681

The result of

$ sudo ./f54test/f54test -d /dev/hidraw1 > f54.out

is appended to this mail. By the way, this command froze my cursor and I 
could not reactivate it (a restart did it).

Please, keep me informed and if you need further information or 
debbuging work, please let me know.

With best regards
Tobbe

On 18.03.2015 02:31, Andrew Duggan wrote:
> On 03/17/2015 08:27 AM, Benjamin Tissoires wrote:
>> On Tue, Mar 17, 2015 at 11:13 AM, Tobias Naumann
>> <tobias-naumann@gmx.net> wrote:
>>> Hi,
>>>
>>> I have recorded the requested records today but I am very confused by
>>> the
>>> result. I have done the following (evemu):
>>>
>>> 1. I found out the device to record with "cat
>>> /proc/bus/input/devices", N:
>>> Name="SYN1B7F:00 06CB:2991 UNKNOWN"
>>> P: Phys=
>>> S:
>>> Sysfs=/devices/pci0000:00/INT3433:00/i2c-7/i2c-SYN1B7F:00/0018:06CB:2991.0001/input/input12
>>>
>>> Therefore, I assumed /dev/input/event12 is the event to record.
>>> 2. I called sudo evemu-describe /dev/input/event12 > acer.desc
>>> 3. I called sudo evemu-record /dev/input/event12 > acer.events
>>> 4. sudo evemu-device acer.desc
>>> 5. sudo evemu-play /dev/input/event13 < acer.events: In this step,
>>> nothing
>>> happened. The cursor was not jumping around, therefore ...
>> Yep, the evemu-record logs is missing events for it to be usable like
>> that (not your fault, you did it right while recording the events).
>>
>>> 6. sudo evemu-play /dev/input/event12 < acer.events: Now, something
>>> strange
>>> happens. When I do not touch anything, nothing happens but as soon as I
>>> touch the touchpad, the cursor begins to jump around.
>> Yep, again that's normal given your logs. The event12 node had the
>> missing events when it was opened by Xorg, and so xorg interpretes
>> them properly.
>>
>>> As http://bentiss.github.io/hid-replay-docs/ states that hid-replay
>>> may/will
>>> harm my kernel, I rather did not try.
>> In your case, hid-replay would not have harmed your kernel. It was
>> true for hid-multitouch devices before 3.9 or 3.10 :)
>>
>> The hid-recorder logs are *very* interesting. It shows that the device
>> never send a release events and sends garbage events all the time.
>>
>> Andrew, I need you here. From the hid-multitouch point of view, the
>> input are garbage.
>> Not sure if this is something you already saw, but the problem is
>> either in the i2c communication or in the FW itself.
>
> I haven't seen what is being described here before. I can start by
> filing a firmware bug and forwarding this information on, but I will
> need to confirm the firmware build id.
>
> Tobbe, can you download one more tool and run?
>
> $ git clone https://github.com/aduggan/rmi4utils.git
> $ cd rmi4utils
> $ make
> $ sudo ./rmihidtool/rmihidtool -f /dev/hidraw1
>
> Based in the dmesg output your touchpad was hidraw1 so I would start
> there. You can confirm by running
> $ dmesg | grep hid-multitouch
>
> Also, if you see the behavior again you could also try running the
> f54test tool to collect some raw sensor data and send it to me. It would
> be interest to see what the sensor is reporting.
>
> $ sudo ./f54test/f54test -d /dev/hidraw1 > f54.out
>
> Andrew
>
>> Tobbe, one last question: does the device works under windows?
>>
>> Cheers,
>> Benjamin
>>
>>> Thanks for your efforts.
>>>
>>> With best regards
>>> Tobbe
>>>
>>> On 14.03.2015 00:29, Benjamin Tissoires wrote:
>>>> Hi,
>>>>
>>>> well, according to the dmesg attached to the ubuntu bug report, it
>>>> looks like you have a Synaptics Precision Touchpad over i2c
>>>> (SYN1B7F:00 06CB:2991).
>>>>
>>>>   From what I understand, the issue is that after a while, the cursor
>>>> jumps and clicks all by itself. Right?
>>>>
>>>> If so, maybe Andrew already saw this problem (IIRC, there was a thread
>>>> about disabling native features in the Synaptics touchpads, but I
>>>> can't tell where we are now).
>>>>
>>>> Also, ideally, we will need some more logs when the problem appears:
>>>> - evemu-record of the touchpad (package evemu)
>>>> - hid-recorder of the touchpad node
>>>> (http://bentiss.github.io/hid-replay-docs/)
>>>>
>>>> Cheers,
>>>> Benjamin
>>>>
>>>>
>>>> On Fri, Mar 13, 2015 at 5:53 PM, Tobias Naumann
>>>> <tobias-naumann@gmx.net>
>>>> wrote:
>>>>> Hi, I am facing an issue with my touchpad in my Ubuntu and sent a
>>>>> report to the Ubuntu bug-tracking system on Launchpad. There, I was
>>>>> asked to send this report to this mailing list, too. I have tried to
>>>>> follow the advice given on
>>>>> https://www.kernel.org/pub/linux/docs/lkml/reporting-bugs.html. I hope
>>>>> that
>>>>> no important information is missing.
>>>>>
>>>>> [1.] One line summary of the problem:
>>>>> Sometimes, cursor jumps around if touchpad is in use
>>>>>
>>>>> [2.] Full description of the problem/report:
>>>>> If using the touchpad, the cursor jumps around on the screen. It
>>>>> seems to
>>>>> me
>>>>> that there are also some events (like clicks) that get fired.
>>>>>
>>>>> I have experienced that the problem starts to happen after any
>>>>> physical
>>>>> interaction with the input-hardware of my machine (touchpad or
>>>>> keyboard)
>>>>> or even after just touching the case of my laptop close to the
>>>>> touchpad.
>>>>>
>>>>> [3.] Keywords (i.e., modules, networking, kernel):
>>>>>
>>>>> [4.] Kernel version (from /proc/version):
>>>>> Linux version 4.0.0-040000rc3-generic (kernel@gomeisa) (gcc version
>>>>> 4.6.3
>>>>> (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201503082035 SMP Mon Mar 9
>>>>> 00:36:32 UTC
>>>>> 2015
>>>>>
>>>>> [5.] Output of Oops.. message (if applicable) with symbolic
>>>>> information
>>>>>        resolved (see Documentation/oops-tracing.txt)
>>>>>
>>>>> [6.] A small shell script or example program which triggers the
>>>>>        problem (if possible)
>>>>>
>>>>> [7.] Environment
>>>>> Description:    Ubuntu 14.10
>>>>> Release:        14.10
>>>>>
>>>>> [7.1.] Software (add the output of the ver_linux script here)
>>>>> If some fields are empty or look unusual you may have an old version.
>>>>> Compare to the current minimal requirements in Documentation/Changes.
>>>>>
>>>>> Linux tobbe-Aspire-V3-371 4.0.0-040000rc3-generic #201503082035 SMP
>>>>> Mon
>>>>> Mar
>>>>> 9 00:36:32 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux
>>>>>
>>>>> Gnu C                  4.9.1
>>>>> Gnu make               4.0
>>>>> binutils               2.24.90.20141014
>>>>> util-linux             2.25.1
>>>>> mount                  debug
>>>>> module-init-tools      18
>>>>> e2fsprogs              1.42.10
>>>>> pcmciautils            018
>>>>> PPP                    2.4.5
>>>>> Linux C Library        2.19
>>>>> Dynamic linker (ldd)   2.19
>>>>> Procps                 3.3.9
>>>>> Net-tools              1.60
>>>>> Kbd                    1.15.5
>>>>> Sh-utils               8.23
>>>>> wireless-tools         30
>>>>> Modules Loaded         ctr ccm rtsx_usb_ms memstick dm_crypt joydev
>>>>> hid_multitouch acer_wmi sparse_keymap intel_rapl arc4 iosf_mbi
>>>>> x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm
>>>>> crct10dif_pclmul crc32_pclmul ghash_clmulni_intel iwlmvm mac80211
>>>>> uvcvideo
>>>>> aesni_intel aes_x86_64 videobuf2_vmalloc lrw videobuf2_memops gf128mul
>>>>> videobuf2_core glue_helper ablk_helper cryptd v4l2_common iwlwifi
>>>>> videodev
>>>>> media cfg80211 serio_raw btusb lpc_ich mei_me mei shpchp
>>>>> snd_hda_codec_hdmi
>>>>> snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel
>>>>> snd_hda_controller
>>>>> rfcomm snd_hda_codec snd_hwdep bnep snd_seq_midi bluetooth
>>>>> snd_seq_midi_event snd_rawmidi snd_soc_rt5640 snd_soc_rl6231 dw_dmac
>>>>> dw_dmac_core snd_soc_core snd_seq snd_compress snd_soc_sst_acpi
>>>>> snd_pcm_dmaengine i2c_hid snd_pcm hid spi_pxa2xx_platform
>>>>> i2c_designware_platform snd_seq_device snd_timer i2c_designware_core
>>>>> 8250_dw
>>>>> snd soundcore acpi_pad mac_hid soc_button_array parport_pc ppdev
>>>>> nls_iso8859_1 lp parport rtsx_usb_sdmmc rtsx_usb i915 i2c_algo_bit
>>>>> drm_kms_helper ahci libahci drm r8169 mii wmi sdhci_acpi sdhci video
>>>>>
>>>>> [7.2.] Processor information (from /proc/cpuinfo):
>>>>> processor       : 0
>>>>> vendor_id       : GenuineIntel
>>>>> cpu family      : 6
>>>>> model           : 61
>>>>> model name      : Intel(R) Core(TM) i5-5200U CPU @ 2.20GHz
>>>>> stepping        : 4
>>>>> microcode       : 0x13
>>>>> cpu MHz         : 2200.085
>>>>> cache size      : 3072 KB
>>>>> physical id     : 0
>>>>> siblings        : 4
>>>>> core id         : 0
>>>>> cpu cores       : 2
>>>>> apicid          : 0
>>>>> initial apicid  : 0
>>>>> fpu             : yes
>>>>> fpu_exception   : yes
>>>>> cpuid level     : 20
>>>>> wp              : yes
>>>>> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
>>>>> mca
>>>>> cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
>>>>> syscall nx
>>>>> pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
>>>>> xtopology
>>>>> nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl
>>>>> vmx
>>>>> est
>>>>> tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt
>>>>> tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch
>>>>> ida
>>>>> arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase
>>>>> tsc_adjust bmi1 avx2 smep bmi2 erms invpcid rdseed adx smap xsaveopt
>>>>> bugs            :
>>>>> bogomips        : 4389.84
>>>>> clflush size    : 64
>>>>> cache_alignment : 64
>>>>> address sizes   : 39 bits physical, 48 bits virtual
>>>>> power management:
>>>>>
>>>>> processor       : 1
>>>>> vendor_id       : GenuineIntel
>>>>> cpu family      : 6
>>>>> model           : 61
>>>>> model name      : Intel(R) Core(TM) i5-5200U CPU @ 2.20GHz
>>>>> stepping        : 4
>>>>> microcode       : 0x13
>>>>> cpu MHz         : 2255.515
>>>>> cache size      : 3072 KB
>>>>> physical id     : 0
>>>>> siblings        : 4
>>>>> core id         : 1
>>>>> cpu cores       : 2
>>>>> apicid          : 2
>>>>> initial apicid  : 2
>>>>> fpu             : yes
>>>>> fpu_exception   : yes
>>>>> cpuid level     : 20
>>>>> wp              : yes
>>>>> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
>>>>> mca
>>>>> cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
>>>>> syscall nx
>>>>> pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
>>>>> xtopology
>>>>> nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl
>>>>> vmx
>>>>> est
>>>>> tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt
>>>>> tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch
>>>>> ida
>>>>> arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase
>>>>> tsc_adjust bmi1 avx2 smep bmi2 erms invpcid rdseed adx smap xsaveopt
>>>>> bugs            :
>>>>> bogomips        : 4389.84
>>>>> clflush size    : 64
>>>>> cache_alignment : 64
>>>>> address sizes   : 39 bits physical, 48 bits virtual
>>>>> power management:
>>>>>
>>>>> processor       : 2
>>>>> vendor_id       : GenuineIntel
>>>>> cpu family      : 6
>>>>> model           : 61
>>>>> model name      : Intel(R) Core(TM) i5-5200U CPU @ 2.20GHz
>>>>> stepping        : 4
>>>>> microcode       : 0x13
>>>>> cpu MHz         : 872.781
>>>>> cache size      : 3072 KB
>>>>> physical id     : 0
>>>>> siblings        : 4
>>>>> core id         : 0
>>>>> cpu cores       : 2
>>>>> apicid          : 1
>>>>> initial apicid  : 1
>>>>> fpu             : yes
>>>>> fpu_exception   : yes
>>>>> cpuid level     : 20
>>>>> wp              : yes
>>>>> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
>>>>> mca
>>>>> cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
>>>>> syscall nx
>>>>> pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
>>>>> xtopology
>>>>> nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl
>>>>> vmx
>>>>> est
>>>>> tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt
>>>>> tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch
>>>>> ida
>>>>> arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase
>>>>> tsc_adjust bmi1 avx2 smep bmi2 erms invpcid rdseed adx smap xsaveopt
>>>>> bugs            :
>>>>> bogomips        : 4389.84
>>>>> clflush size    : 64
>>>>> cache_alignment : 64
>>>>> address sizes   : 39 bits physical, 48 bits virtual
>>>>> power management:
>>>>>
>>>>> processor       : 3
>>>>> vendor_id       : GenuineIntel
>>>>> cpu family      : 6
>>>>> model           : 61
>>>>> model name      : Intel(R) Core(TM) i5-5200U CPU @ 2.20GHz
>>>>> stepping        : 4
>>>>> microcode       : 0x13
>>>>> cpu MHz         : 2188.742
>>>>> cache size      : 3072 KB
>>>>> physical id     : 0
>>>>> siblings        : 4
>>>>> core id         : 1
>>>>> cpu cores       : 2
>>>>> apicid          : 3
>>>>> initial apicid  : 3
>>>>> fpu             : yes
>>>>> fpu_exception   : yes
>>>>> cpuid level     : 20
>>>>> wp              : yes
>>>>> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
>>>>> mca
>>>>> cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
>>>>> syscall nx
>>>>> pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
>>>>> xtopology
>>>>> nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl
>>>>> vmx
>>>>> est
>>>>> tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt
>>>>> tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch
>>>>> ida
>>>>> arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase
>>>>> tsc_adjust bmi1 avx2 smep bmi2 erms invpcid rdseed adx smap xsaveopt
>>>>> bugs            :
>>>>> bogomips        : 4389.84
>>>>> clflush size    : 64
>>>>> cache_alignment : 64
>>>>> address sizes   : 39 bits physical, 48 bits virtual
>>>>> power management:
>>>>>
>>>>> [7.3.] Module information (from /proc/modules):
>>>>> ctr 16384 1 - Live 0x0000000000000000
>>>>> ccm 20480 1 - Live 0x0000000000000000
>>>>> rtsx_usb_ms 20480 0 - Live 0x0000000000000000
>>>>> memstick 20480 1 rtsx_usb_ms, Live 0x0000000000000000
>>>>> dm_crypt 28672 0 - Live 0x0000000000000000
>>>>> joydev 20480 0 - Live 0x0000000000000000
>>>>> hid_multitouch 20480 0 - Live 0x0000000000000000
>>>>> acer_wmi 20480 0 - Live 0x0000000000000000
>>>>> sparse_keymap 16384 1 acer_wmi, Live 0x0000000000000000
>>>>> intel_rapl 20480 0 - Live 0x0000000000000000
>>>>> arc4 16384 2 - Live 0x0000000000000000
>>>>> iosf_mbi 16384 1 intel_rapl, Live 0x0000000000000000
>>>>> x86_pkg_temp_thermal 16384 0 - Live 0x0000000000000000
>>>>> intel_powerclamp 20480 0 - Live 0x0000000000000000
>>>>> coretemp 16384 0 - Live 0x0000000000000000
>>>>> kvm_intel 159744 0 - Live 0x0000000000000000
>>>>> kvm 512000 1 kvm_intel, Live 0x0000000000000000
>>>>> crct10dif_pclmul 16384 0 - Live 0x0000000000000000
>>>>> crc32_pclmul 16384 0 - Live 0x0000000000000000
>>>>> ghash_clmulni_intel 16384 0 - Live 0x0000000000000000
>>>>> iwlmvm 299008 0 - Live 0x0000000000000000
>>>>> mac80211 774144 1 iwlmvm, Live 0x0000000000000000
>>>>> uvcvideo 94208 0 - Live 0x0000000000000000
>>>>> aesni_intel 172032 796 - Live 0x0000000000000000
>>>>> aes_x86_64 20480 1 aesni_intel, Live 0x0000000000000000
>>>>> videobuf2_vmalloc 16384 1 uvcvideo, Live 0x0000000000000000
>>>>> lrw 16384 1 aesni_intel, Live 0x0000000000000000
>>>>> videobuf2_memops 16384 1 videobuf2_vmalloc, Live 0x0000000000000000
>>>>> gf128mul 16384 1 lrw, Live 0x0000000000000000
>>>>> videobuf2_core 53248 1 uvcvideo, Live 0x0000000000000000
>>>>> glue_helper 16384 1 aesni_intel, Live 0x0000000000000000
>>>>> ablk_helper 16384 1 aesni_intel, Live 0x0000000000000000
>>>>> cryptd 24576 399 ghash_clmulni_intel,aesni_intel,ablk_helper, Live
>>>>> 0x0000000000000000
>>>>> v4l2_common 16384 1 videobuf2_core, Live 0x0000000000000000
>>>>> iwlwifi 208896 1 iwlmvm, Live 0x0000000000000000
>>>>> videodev 163840 3 uvcvideo,videobuf2_core,v4l2_common, Live
>>>>> 0x0000000000000000
>>>>> media 24576 2 uvcvideo,videodev, Live 0x0000000000000000
>>>>> cfg80211 581632 3 iwlmvm,mac80211,iwlwifi, Live 0x0000000000000000
>>>>> serio_raw 16384 0 - Live 0x0000000000000000
>>>>> btusb 45056 0 - Live 0x0000000000000000
>>>>> lpc_ich 24576 0 - Live 0x0000000000000000
>>>>> mei_me 20480 0 - Live 0x0000000000000000
>>>>> mei 90112 1 mei_me, Live 0x0000000000000000
>>>>> shpchp 40960 0 - Live 0x0000000000000000
>>>>> snd_hda_codec_hdmi 53248 1 - Live 0x0000000000000000
>>>>> snd_hda_codec_realtek 81920 1 - Live 0x0000000000000000
>>>>> snd_hda_codec_generic 73728 1 snd_hda_codec_realtek, Live
>>>>> 0x0000000000000000
>>>>> snd_hda_intel 32768 5 - Live 0x0000000000000000
>>>>> snd_hda_controller 36864 1 snd_hda_intel, Live 0x0000000000000000
>>>>> rfcomm 77824 8 - Live 0x0000000000000000
>>>>> snd_hda_codec 147456 5
>>>>>
>>>>> snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_controller,
>>>>>
>>>>> Live 0x0000000000000000
>>>>> snd_hwdep 16384 1 snd_hda_codec, Live 0x0000000000000000
>>>>> bnep 24576 2 - Live 0x0000000000000000
>>>>> snd_seq_midi 16384 0 - Live 0x0000000000000000
>>>>> bluetooth 524288 22 btusb,rfcomm,bnep, Live 0x0000000000000000
>>>>> snd_seq_midi_event 16384 1 snd_seq_midi, Live 0x0000000000000000
>>>>> snd_rawmidi 32768 1 snd_seq_midi, Live 0x0000000000000000
>>>>> snd_soc_rt5640 94208 0 - Live 0x0000000000000000
>>>>> snd_soc_rl6231 16384 1 snd_soc_rt5640, Live 0x0000000000000000
>>>>> dw_dmac 16384 0 - Live 0x0000000000000000
>>>>> dw_dmac_core 28672 1 dw_dmac, Live 0x0000000000000000
>>>>> snd_soc_core 200704 1 snd_soc_rt5640, Live 0x0000000000000000
>>>>> snd_seq 69632 2 snd_seq_midi,snd_seq_midi_event, Live
>>>>> 0x0000000000000000
>>>>> snd_compress 20480 1 snd_soc_core, Live 0x0000000000000000
>>>>> snd_soc_sst_acpi 16384 0 - Live 0x0000000000000000
>>>>> snd_pcm_dmaengine 16384 1 snd_soc_core, Live 0x0000000000000000
>>>>> i2c_hid 20480 0 - Live 0x0000000000000000
>>>>> snd_pcm 110592 7
>>>>>
>>>>> snd_hda_codec_hdmi,snd_hda_intel,snd_hda_controller,snd_hda_codec,snd_soc_rt5640,snd_soc_core,snd_pcm_dmaengine,
>>>>>
>>>>> Live 0x0000000000000000
>>>>> hid 114688 2 hid_multitouch,i2c_hid, Live 0x0000000000000000
>>>>> spi_pxa2xx_platform 24576 0 - Live 0x0000000000000000
>>>>> i2c_designware_platform 16384 0 - Live 0x0000000000000000
>>>>> snd_seq_device 16384 3 snd_seq_midi,snd_rawmidi,snd_seq, Live
>>>>> 0x0000000000000000
>>>>> snd_timer 32768 2 snd_seq,snd_pcm, Live 0x0000000000000000
>>>>> i2c_designware_core 16384 1 i2c_designware_platform, Live
>>>>> 0x0000000000000000
>>>>> 8250_dw 16384 0 - Live 0x0000000000000000
>>>>> snd 86016 23
>>>>>
>>>>> snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_rawmidi,snd_soc_core,snd_seq,snd_compress,snd_pcm,snd_seq_device,snd_timer,
>>>>>
>>>>> Live 0x0000000000000000
>>>>> soundcore 16384 2 snd_hda_codec,snd, Live 0x0000000000000000
>>>>> acpi_pad 20480 0 - Live 0x0000000000000000
>>>>> mac_hid 16384 0 - Live 0x0000000000000000
>>>>> soc_button_array 16384 0 - Live 0x0000000000000000
>>>>> parport_pc 36864 0 - Live 0x0000000000000000
>>>>> ppdev 20480 0 - Live 0x0000000000000000
>>>>> nls_iso8859_1 16384 1 - Live 0x0000000000000000
>>>>> lp 20480 0 - Live 0x0000000000000000
>>>>> parport 45056 3 parport_pc,ppdev,lp, Live 0x0000000000000000
>>>>> rtsx_usb_sdmmc 28672 0 - Live 0x0000000000000000
>>>>> rtsx_usb 24576 2 rtsx_usb_ms,rtsx_usb_sdmmc, Live 0x0000000000000000
>>>>> i915 1122304 3 - Live 0x0000000000000000
>>>>> i2c_algo_bit 16384 1 i915, Live 0x0000000000000000
>>>>> drm_kms_helper 126976 1 i915, Live 0x0000000000000000
>>>>> ahci 36864 2 - Live 0x0000000000000000
>>>>> libahci 32768 1 ahci, Live 0x0000000000000000
>>>>> drm 352256 4 i915,drm_kms_helper, Live 0x0000000000000000
>>>>> r8169 90112 0 - Live 0x0000000000000000
>>>>> mii 16384 1 r8169, Live 0x0000000000000000
>>>>> wmi 20480 1 acer_wmi, Live 0x0000000000000000
>>>>> sdhci_acpi 16384 0 - Live 0x0000000000000000
>>>>> sdhci 45056 1 sdhci_acpi, Live 0x0000000000000000
>>>>> video 28672 2 acer_wmi,i915, Live 0x0000000000000000
>>>>>
>>>>>
>>>>> [7.4.] Loaded driver and hardware information (/proc/ioports,
>>>>> /proc/iomem)
>>>>> 0000-0cf7 : PCI Bus 0000:00
>>>>>     0000-001f : dma1
>>>>>     0020-0021 : pic1
>>>>>     0040-0043 : timer0
>>>>>     0050-0053 : timer1
>>>>>     0060-0060 : keyboard
>>>>>     0062-0062 : PNP0C09:00
>>>>>       0062-0062 : EC data
>>>>>     0064-0064 : keyboard
>>>>>     0066-0066 : PNP0C09:00
>>>>>       0066-0066 : EC cmd
>>>>>     0070-0077 : rtc0
>>>>>     0080-008f : dma page reg
>>>>>     00a0-00a1 : pic2
>>>>>     00c0-00df : dma2
>>>>>     00f0-00ff : fpu
>>>>> 0cf8-0cff : PCI conf1
>>>>> 0d00-ffff : PCI Bus 0000:00
>>>>>     1800-1803 : ACPI PM1a_EVT_BLK
>>>>>     1804-1805 : ACPI PM1a_CNT_BLK
>>>>>     1808-180b : ACPI PM_TMR
>>>>>     1810-1815 : ACPI CPU throttle
>>>>>     1830-1833 : iTCO_wdt
>>>>>     1850-1850 : ACPI PM2_CNT_BLK
>>>>>     1854-1857 : pnp 00:02
>>>>>     1860-187f : iTCO_wdt
>>>>>     1880-189f : ACPI GPE0_BLK
>>>>>     3000-3fff : PCI Bus 0000:01
>>>>>       3000-30ff : 0000:01:00.0
>>>>>         3000-30ff : r8169
>>>>>     4000-403f : 0000:00:02.0
>>>>>     4040-405f : 0000:00:1f.3
>>>>>     4060-407f : 0000:00:1f.2
>>>>>       4060-407f : ahci
>>>>>     4080-4087 : 0000:00:1f.2
>>>>>       4080-4087 : ahci
>>>>>     4088-408f : 0000:00:1f.2
>>>>>       4088-408f : ahci
>>>>>     4090-4093 : 0000:00:1f.2
>>>>>       4090-4093 : ahci
>>>>>     4094-4097 : 0000:00:1f.2
>>>>>       4094-4097 : ahci
>>>>>     ffff-ffff : pnp 00:00
>>>>>       ffff-ffff : pnp 00:00
>>>>>         ffff-ffff : pnp 00:00
>>>>>
>>>>> 00000000-00000fff : reserved
>>>>> 00001000-00057fff : System RAM
>>>>> 00058000-00058fff : reserved
>>>>> 00059000-00085fff : System RAM
>>>>> 00086000-0009ffff : reserved
>>>>> 000a0000-000bffff : PCI Bus 0000:00
>>>>> 000c0000-000c3fff : PCI Bus 0000:00
>>>>> 000c4000-000c7fff : PCI Bus 0000:00
>>>>> 000c8000-000cbfff : PCI Bus 0000:00
>>>>> 000cc000-000cffff : PCI Bus 0000:00
>>>>> 000d0000-000d3fff : PCI Bus 0000:00
>>>>> 000d4000-000d7fff : PCI Bus 0000:00
>>>>> 000d8000-000dbfff : PCI Bus 0000:00
>>>>> 000dc000-000dffff : PCI Bus 0000:00
>>>>> 000e0000-000e3fff : PCI Bus 0000:00
>>>>> 000e4000-000e7fff : PCI Bus 0000:00
>>>>> 000e8000-000ebfff : PCI Bus 0000:00
>>>>> 000ec000-000effff : PCI Bus 0000:00
>>>>> 000f0000-000fffff : PCI Bus 0000:00
>>>>>     000f0000-000fffff : System ROM
>>>>> 00100000-033ce06f : System RAM
>>>>>     02000000-027f15e3 : Kernel code
>>>>>     027f15e4-02d1c23f : Kernel data
>>>>>     02e89000-02fcbfff : Kernel bss
>>>>> 033ce070-033ce080 : System RAM
>>>>> 033ce081-969b9fff : System RAM
>>>>> 969ba000-972b9fff : reserved
>>>>> 972ba000-9c4cefff : System RAM
>>>>> 9c4cf000-9c6cefff : reserved
>>>>> 9c6cf000-9cebefff : reserved
>>>>> 9cebf000-9cfbefff : ACPI Non-volatile Storage
>>>>> 9cfbf000-9cffefff : ACPI Tables
>>>>> 9cfff000-9cffffff : System RAM
>>>>> 9d000000-9dffffff : RAM buffer
>>>>> 9e000000-9fffffff : reserved
>>>>>     9e000000-9fffffff : Graphics Stolen Memory
>>>>> a0000000-feafffff : PCI Bus 0000:00
>>>>>     a0000000-a000ffff : pnp 00:05
>>>>>     a0010000-a001ffff : pnp 00:05
>>>>>     b0000000-bfffffff : 0000:00:02.0
>>>>>     c0000000-c0ffffff : 0000:00:02.0
>>>>>     c1000000-c10fffff : PCI Bus 0000:01
>>>>>       c1000000-c1003fff : 0000:01:00.0
>>>>>         c1000000-c1003fff : r8169
>>>>>     c1100000-c11fffff : PCI Bus 0000:02
>>>>>       c1100000-c1101fff : 0000:02:00.0
>>>>>         c1100000-c1101fff : iwlwifi
>>>>>     c1200000-c12fffff : PCI Bus 0000:01
>>>>>       c1200000-c1200fff : 0000:01:00.0
>>>>>         c1200000-c1200fff : r8169
>>>>>     c1300000-c130ffff : 0000:00:14.0
>>>>>       c1300000-c130ffff : xhci-hcd
>>>>>     c1310000-c1313fff : 0000:00:03.0
>>>>>       c1310000-c1313fff : ICH HD audio
>>>>>     c1314000-c1317fff : 0000:00:1b.0
>>>>>       c1314000-c1317fff : ICH HD audio
>>>>>     c1318000-c13180ff : 0000:00:1f.3
>>>>>     c1319000-c131901f : 0000:00:16.0
>>>>>       c1319000-c131901f : mei_me
>>>>>     c131b000-c131bfff : 0000:00:1f.6
>>>>>     c131c000-c131c7ff : 0000:00:1f.2
>>>>>       c131c000-c131c7ff : ahci
>>>>>     c131d000-c131d3ff : 0000:00:1d.0
>>>>>       c131d000-c131d3ff : ehci_hcd
>>>>>     e0000000-efffffff : PCI MMCONFIG 0000 [bus 00-ff]
>>>>>       e0000000-efffffff : reserved
>>>>>         e0000000-efffffff : pnp 00:05
>>>>>     fe105000-fe105fff : INT3433:00
>>>>>       fe105000-fe105fff : INT3433:00
>>>>>     fe106000-fe106fff : pnp 00:04
>>>>>     fe800000-fe80ffff : pnp 00:00
>>>>> feb00000-feb03fff : reserved
>>>>> fec00000-fec00fff : reserved
>>>>>     fec00000-fec003ff : IOAPIC 0
>>>>> fed00000-fed003ff : HPET 0
>>>>>     fed00000-fed003ff : PNP0103:00
>>>>> fed10000-fed19fff : reserved
>>>>>     fed10000-fed17fff : pnp 00:05
>>>>>     fed18000-fed18fff : pnp 00:05
>>>>>     fed19000-fed19fff : pnp 00:05
>>>>> fed1c000-fed1ffff : reserved
>>>>>     fed1c000-fed1ffff : pnp 00:05
>>>>>       fed1f410-fed1f414 : iTCO_wdt
>>>>> fed20000-fed3ffff : pnp 00:05
>>>>> fed45000-fed8ffff : pnp 00:05
>>>>> fed90000-fed90fff : dmar0
>>>>> fed91000-fed91fff : dmar1
>>>>> fee00000-fee00fff : Local APIC
>>>>>     fee00000-fee00fff : reserved
>>>>> ff000000-ffffffff : INT0800:00
>>>>>     ffa00000-ffffffff : reserved
>>>>> 100000000-25effffff : System RAM
>>>>> 25f000000-25fffffff : RAM buffer
>>>>>
>>>>> [7.5.] PCI information ('lspci -vvv' as root)
>>>>> 00:00.0 Host bridge: Intel Corporation Broadwell-U Host Bridge -OPI
>>>>> (rev
>>>>> 09)
>>>>>           Subsystem: Acer Incorporated [ALI] Device 0919
>>>>>           Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
>>>>> ParErr-
>>>>> Stepping- SERR- FastB2B- DisINTx-
>>>>>           Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast
>>>>> >TAbort-
>>>>> <TAbort- <MAbort+ >SERR- <PERR- INTx-
>>>>>           Latency: 0
>>>>>           Capabilities: [e0] Vendor Specific Information: Len=0c <?>
>>>>>
>>>>> 00:02.0 VGA compatible controller: Intel Corporation Broadwell-U
>>>>> Integrated
>>>>> Graphics (rev 09) (prog-if 00 [VGA controller])
>>>>>           Subsystem: Acer Incorporated [ALI] Device 0919
>>>>>           Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
>>>>> ParErr-
>>>>> Stepping- SERR- FastB2B- DisINTx+
>>>>>           Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast
>>>>> >TAbort-
>>>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>>>           Latency: 0
>>>>>           Interrupt: pin A routed to IRQ 47
>>>>>           Region 0: Memory at c0000000 (64-bit, non-prefetchable)
>>>>> [size=16M]
>>>>>           Region 2: Memory at b0000000 (64-bit, prefetchable)
>>>>> [size=256M]
>>>>>           Region 4: I/O ports at 4000 [size=64]
>>>>>           Expansion ROM at <unassigned> [disabled]
>>>>>           Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
>>>>>                   Address: fee00018  Data: 0000
>>>>>           Capabilities: [d0] Power Management version 2
>>>>>                   Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
>>>>> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>>>>>                   Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0
>>>>> PME-
>>>>>           Capabilities: [a4] PCI Advanced Features
>>>>>                   AFCap: TP+ FLR+
>>>>>                   AFCtrl: FLR-
>>>>>                   AFStatus: TP-
>>>>>           Kernel driver in use: i915
>>>>>
>>>>> 00:03.0 Audio device: Intel Corporation Broadwell-U Audio
>>>>> Controller (rev
>>>>> 09)
>>>>>           Subsystem: Acer Incorporated [ALI] Device 0919
>>>>>           Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
>>>>> ParErr-
>>>>> Stepping- SERR- FastB2B- DisINTx+
>>>>>           Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast
>>>>> >TAbort-
>>>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>>>           Latency: 0, Cache Line Size: 64 bytes
>>>>>           Interrupt: pin A routed to IRQ 49
>>>>>           Region 0: Memory at c1310000 (64-bit, non-prefetchable)
>>>>> [size=16K]
>>>>>           Capabilities: [50] Power Management version 2
>>>>>                   Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
>>>>> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>>>>>                   Status: D3 NoSoftRst- PME-Enable- DSel=0 DScale=0
>>>>> PME-
>>>>>           Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit-
>>>>>                   Address: fee00418  Data: 0000
>>>>>           Capabilities: [70] Express (v1) Root Complex Integrated
>>>>> Endpoint,
>>>>> MSI 00
>>>>>                   DevCap: MaxPayload 128 bytes, PhantFunc 0
>>>>>                           ExtTag- RBE-
>>>>>                   DevCtl: Report errors: Correctable- Non-Fatal-
>>>>> Fatal-
>>>>> Unsupported-
>>>>>                           RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>>>>>                           MaxPayload 128 bytes, MaxReadReq 128 bytes
>>>>>                   DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-
>>>>> AuxPwr-
>>>>> TransPend-
>>>>>           Kernel driver in use: snd_hda_intel
>>>>>
>>>>> 00:14.0 USB controller: Intel Corporation Wildcat Point-LP USB xHCI
>>>>> Controller (rev 03) (prog-if 30 [XHCI])
>>>>>           Subsystem: Acer Incorporated [ALI] Device 0919
>>>>>           Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
>>>>> ParErr-
>>>>> Stepping- SERR- FastB2B- DisINTx+
>>>>>           Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>>>>> >TAbort-
>>>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>>>           Latency: 0
>>>>>           Interrupt: pin A routed to IRQ 44
>>>>>           Region 0: Memory at c1300000 (64-bit, non-prefetchable)
>>>>> [size=64K]
>>>>>           Capabilities: [70] Power Management version 2
>>>>>                   Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
>>>>> PME(D0-,D1-,D2-,D3hot+,D3cold+)
>>>>>                   Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0
>>>>> PME-
>>>>>           Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
>>>>>                   Address: 00000000fee00338  Data: 0000
>>>>>           Kernel driver in use: xhci_hcd
>>>>>
>>>>> 00:16.0 Communication controller: Intel Corporation Wildcat
>>>>> Point-LP MEI
>>>>> Controller #1 (rev 03)
>>>>>           Subsystem: Acer Incorporated [ALI] Device 0919
>>>>>           Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
>>>>> ParErr-
>>>>> Stepping- SERR- FastB2B- DisINTx+
>>>>>           Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast
>>>>> >TAbort-
>>>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>>>           Latency: 0
>>>>>           Interrupt: pin A routed to IRQ 50
>>>>>           Region 0: Memory at c1319000 (64-bit, non-prefetchable)
>>>>> [size=32]
>>>>>           Capabilities: [50] Power Management version 3
>>>>>                   Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
>>>>> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>>>>>                   Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0
>>>>> PME-
>>>>>           Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
>>>>>                   Address: 00000000fee00438  Data: 0000
>>>>>           Kernel driver in use: mei_me
>>>>>
>>>>> 00:1b.0 Audio device: Intel Corporation Wildcat Point-LP High
>>>>> Definition
>>>>> Audio Controller (rev 03)
>>>>>           Subsystem: Acer Incorporated [ALI] Device 0919
>>>>>           Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
>>>>> ParErr-
>>>>> Stepping- SERR- FastB2B- DisINTx+
>>>>>           Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast
>>>>> >TAbort-
>>>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>>>           Latency: 64, Cache Line Size: 64 bytes
>>>>>           Interrupt: pin A routed to IRQ 48
>>>>>           Region 0: Memory at c1314000 (64-bit, non-prefetchable)
>>>>> [size=16K]
>>>>>           Capabilities: [50] Power Management version 3
>>>>>                   Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
>>>>> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>>>>>                   Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=0
>>>>> PME-
>>>>>           Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
>>>>>                   Address: 00000000fee003f8  Data: 0000
>>>>>           Kernel driver in use: snd_hda_intel
>>>>>
>>>>> 00:1c.0 PCI bridge: Intel Corporation Wildcat Point-LP PCI Express
>>>>> Root
>>>>> Port
>>>>> #3 (rev e3) (prog-if 00 [Normal decode])
>>>>>           Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
>>>>> ParErr-
>>>>> Stepping- SERR- FastB2B- DisINTx+
>>>>>           Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast
>>>>> >TAbort-
>>>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>>>           Latency: 0, Cache Line Size: 64 bytes
>>>>>           Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>>>>>           I/O behind bridge: 00003000-00003fff
>>>>>           Memory behind bridge: c1200000-c12fffff
>>>>>           Prefetchable memory behind bridge:
>>>>> 00000000c1000000-00000000c10fffff
>>>>>           Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast
>>>>> >TAbort-
>>>>> <TAbort- <MAbort- <SERR- <PERR-
>>>>>           BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset-
>>>>> FastB2B-
>>>>>                   PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>>>>>           Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
>>>>>                   DevCap: MaxPayload 128 bytes, PhantFunc 0
>>>>>                           ExtTag- RBE+
>>>>>                   DevCtl: Report errors: Correctable- Non-Fatal-
>>>>> Fatal-
>>>>> Unsupported-
>>>>>                           RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>>>>>                           MaxPayload 128 bytes, MaxReadReq 128 bytes
>>>>>                   DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-
>>>>> AuxPwr+
>>>>> TransPend-
>>>>>                   LnkCap: Port #3, Speed 5GT/s, Width x1, ASPM L0s L1,
>>>>> Exit
>>>>> Latency L0s <512ns, L1 <16us
>>>>>                           ClockPM- Surprise- LLActRep+ BwNot+
>>>>>                   LnkCtl: ASPM Disabled; RCB 64 bytes Disabled-
>>>>> CommClk+
>>>>>                           ExtSynch- ClockPM- AutWidDis- BWInt-
>>>>> AutBWInt-
>>>>>                   LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train-
>>>>> SlotClk+
>>>>> DLActive+ BWMgmt+ ABWMgmt-
>>>>>                   SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-
>>>>> HotPlug-
>>>>> Surprise-
>>>>>                           Slot #2, PowerLimit 10.000W; Interlock-
>>>>> NoCompl+
>>>>>                   SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet-
>>>>> CmdCplt-
>>>>> HPIrq- LinkChg-
>>>>>                           Control: AttnInd Unknown, PwrInd Unknown,
>>>>> Power-
>>>>> Interlock-
>>>>>                   SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-
>>>>> PresDet+
>>>>> Interlock-
>>>>>                           Changed: MRL- PresDet- LinkState+
>>>>>                   RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-
>>>>> PMEIntEna+
>>>>> CRSVisible-
>>>>>                   RootCap: CRSVisible-
>>>>>                   RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>>>>>                   DevCap2: Completion Timeout: Range ABC, TimeoutDis+,
>>>>> LTR+,
>>>>> OBFF Not Supported ARIFwd-
>>>>>                   DevCtl2: Completion Timeout: 50us to 50ms,
>>>>> TimeoutDis-,
>>>>> LTR+, OBFF Disabled ARIFwd-
>>>>>                   LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance-
>>>>> SpeedDis-
>>>>>                            Transmit Margin: Normal Operating Range,
>>>>> EnterModifiedCompliance- ComplianceSOS-
>>>>>                            Compliance De-emphasis: -6dB
>>>>>                   LnkSta2: Current De-emphasis Level: -3.5dB,
>>>>> EqualizationComplete-, EqualizationPhase1-
>>>>>                            EqualizationPhase2-, EqualizationPhase3-,
>>>>> LinkEqualizationRequest-
>>>>>           Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
>>>>>                   Address: fee002d8  Data: 0000
>>>>>           Capabilities: [90] Subsystem: Acer Incorporated [ALI] Device
>>>>> 0919
>>>>>           Capabilities: [a0] Power Management version 3
>>>>>                   Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
>>>>> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>>>>>                   Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0
>>>>> PME-
>>>>>           Capabilities: [100 v0] #00
>>>>>           Capabilities: [200 v1] L1 PM Substates
>>>>>                   L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
>>>>> ASPM_L1.1+
>>>>> L1_PM_Substates+
>>>>>                             PortCommonModeRestoreTime=40us
>>>>> PortTPowerOnTime=10us
>>>>>           Kernel driver in use: pcieport
>>>>>
>>>>> 00:1c.3 PCI bridge: Intel Corporation Wildcat Point-LP PCI Express
>>>>> Root
>>>>> Port
>>>>> #4 (rev e3) (prog-if 00 [Normal decode])
>>>>>           Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
>>>>> ParErr-
>>>>> Stepping- SERR- FastB2B- DisINTx+
>>>>>           Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast
>>>>> >TAbort-
>>>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>>>           Latency: 0, Cache Line Size: 64 bytes
>>>>>           Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
>>>>>           I/O behind bridge: 0000f000-00000fff
>>>>>           Memory behind bridge: c1100000-c11fffff
>>>>>           Prefetchable memory behind bridge:
>>>>> 00000000fff00000-00000000000fffff
>>>>>           Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast
>>>>> >TAbort-
>>>>> <TAbort- <MAbort- <SERR- <PERR-
>>>>>           BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset-
>>>>> FastB2B-
>>>>>                   PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>>>>>           Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
>>>>>                   DevCap: MaxPayload 128 bytes, PhantFunc 0
>>>>>                           ExtTag- RBE+
>>>>>                   DevCtl: Report errors: Correctable- Non-Fatal-
>>>>> Fatal-
>>>>> Unsupported-
>>>>>                           RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>>>>>                           MaxPayload 128 bytes, MaxReadReq 128 bytes
>>>>>                   DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-
>>>>> AuxPwr+
>>>>> TransPend-
>>>>>                   LnkCap: Port #4, Speed 5GT/s, Width x1, ASPM L0s L1,
>>>>> Exit
>>>>> Latency L0s <512ns, L1 <16us
>>>>>                           ClockPM- Surprise- LLActRep+ BwNot+
>>>>>                   LnkCtl: ASPM Disabled; RCB 64 bytes Disabled-
>>>>> CommClk+
>>>>>                           ExtSynch- ClockPM- AutWidDis- BWInt-
>>>>> AutBWInt-
>>>>>                   LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train-
>>>>> SlotClk+
>>>>> DLActive+ BWMgmt+ ABWMgmt-
>>>>>                   SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-
>>>>> HotPlug-
>>>>> Surprise-
>>>>>                           Slot #3, PowerLimit 10.000W; Interlock-
>>>>> NoCompl+
>>>>>                   SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet-
>>>>> CmdCplt-
>>>>> HPIrq- LinkChg-
>>>>>                           Control: AttnInd Unknown, PwrInd Unknown,
>>>>> Power-
>>>>> Interlock-
>>>>>                   SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-
>>>>> PresDet+
>>>>> Interlock-
>>>>>                           Changed: MRL- PresDet- LinkState+
>>>>>                   RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-
>>>>> PMEIntEna+
>>>>> CRSVisible-
>>>>>                   RootCap: CRSVisible-
>>>>>                   RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>>>>>                   DevCap2: Completion Timeout: Range ABC, TimeoutDis+,
>>>>> LTR+,
>>>>> OBFF Not Supported ARIFwd-
>>>>>                   DevCtl2: Completion Timeout: 50us to 50ms,
>>>>> TimeoutDis-,
>>>>> LTR+, OBFF Disabled ARIFwd-
>>>>>                   LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance-
>>>>> SpeedDis-
>>>>>                            Transmit Margin: Normal Operating Range,
>>>>> EnterModifiedCompliance- ComplianceSOS-
>>>>>                            Compliance De-emphasis: -6dB
>>>>>                   LnkSta2: Current De-emphasis Level: -3.5dB,
>>>>> EqualizationComplete-, EqualizationPhase1-
>>>>>                            EqualizationPhase2-, EqualizationPhase3-,
>>>>> LinkEqualizationRequest-
>>>>>           Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
>>>>>                   Address: fee00318  Data: 0000
>>>>>           Capabilities: [90] Subsystem: Acer Incorporated [ALI] Device
>>>>> 0919
>>>>>           Capabilities: [a0] Power Management version 3
>>>>>                   Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
>>>>> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>>>>>                   Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0
>>>>> PME-
>>>>>           Capabilities: [100 v0] #00
>>>>>           Capabilities: [200 v1] L1 PM Substates
>>>>>                   L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
>>>>> ASPM_L1.1+
>>>>> L1_PM_Substates+
>>>>>                             PortCommonModeRestoreTime=40us
>>>>> PortTPowerOnTime=10us
>>>>>           Kernel driver in use: pcieport
>>>>>
>>>>> 00:1d.0 USB controller: Intel Corporation Wildcat Point-LP USB EHCI
>>>>> Controller (rev 03) (prog-if 20 [EHCI])
>>>>>           Subsystem: Acer Incorporated [ALI] Device 0919
>>>>>           Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
>>>>> ParErr-
>>>>> Stepping- SERR- FastB2B- DisINTx-
>>>>>           Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>>>>> >TAbort-
>>>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>>>           Latency: 0
>>>>>           Interrupt: pin A routed to IRQ 23
>>>>>           Region 0: Memory at c131d000 (32-bit, non-prefetchable)
>>>>> [size=1K]
>>>>>           Capabilities: [50] Power Management version 3
>>>>>                   Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
>>>>> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>>>>>                   Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0
>>>>> PME-
>>>>>           Capabilities: [58] Debug port: BAR=1 offset=00a0
>>>>>           Capabilities: [98] PCI Advanced Features
>>>>>                   AFCap: TP+ FLR+
>>>>>                   AFCtrl: FLR-
>>>>>                   AFStatus: TP-
>>>>>           Kernel driver in use: ehci-pci
>>>>>
>>>>> 00:1f.0 ISA bridge: Intel Corporation Wildcat Point-LP LPC Controller
>>>>> (rev
>>>>> 03)
>>>>>           Subsystem: Acer Incorporated [ALI] Device 0919
>>>>>           Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
>>>>> ParErr-
>>>>> Stepping- SERR- FastB2B- DisINTx-
>>>>>           Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium
>>>>> >TAbort-
>>>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>>>           Latency: 0
>>>>>           Capabilities: [e0] Vendor Specific Information: Len=0c <?>
>>>>>           Kernel driver in use: lpc_ich
>>>>>
>>>>> 00:1f.2 SATA controller: Intel Corporation Wildcat Point-LP SATA
>>>>> Controller
>>>>> [AHCI Mode] (rev 03) (prog-if 01 [AHCI 1.0])
>>>>>           Subsystem: Acer Incorporated [ALI] Device 0919
>>>>>           Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
>>>>> ParErr-
>>>>> Stepping- SERR- FastB2B- DisINTx+
>>>>>           Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>>>>> >TAbort-
>>>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>>>           Latency: 0
>>>>>           Interrupt: pin B routed to IRQ 45
>>>>>           Region 0: I/O ports at 4088 [size=8]
>>>>>           Region 1: I/O ports at 4094 [size=4]
>>>>>           Region 2: I/O ports at 4080 [size=8]
>>>>>           Region 3: I/O ports at 4090 [size=4]
>>>>>           Region 4: I/O ports at 4060 [size=32]
>>>>>           Region 5: Memory at c131c000 (32-bit, non-prefetchable)
>>>>> [size=2K]
>>>>>           Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
>>>>>                   Address: fee00358  Data: 0000
>>>>>           Capabilities: [70] Power Management version 3
>>>>>                   Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
>>>>> PME(D0-,D1-,D2-,D3hot+,D3cold-)
>>>>>                   Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0
>>>>> PME-
>>>>>           Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
>>>>>           Kernel driver in use: ahci
>>>>>
>>>>> 00:1f.3 SMBus: Intel Corporation Wildcat Point-LP SMBus Controller
>>>>> (rev
>>>>> 03)
>>>>>           Subsystem: Acer Incorporated [ALI] Device 0919
>>>>>           Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
>>>>> ParErr-
>>>>> Stepping- SERR- FastB2B- DisINTx-
>>>>>           Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>>>>> >TAbort-
>>>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>>>           Interrupt: pin C routed to IRQ 255
>>>>>           Region 0: Memory at c1318000 (64-bit, non-prefetchable)
>>>>> [size=256]
>>>>>           Region 4: I/O ports at 4040 [size=32]
>>>>>
>>>>> 00:1f.6 Signal processing controller: Intel Corporation Wildcat
>>>>> Point-LP
>>>>> Thermal Management Controller (rev 03)
>>>>>           Subsystem: Acer Incorporated [ALI] Device 0919
>>>>>           Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
>>>>> ParErr-
>>>>> Stepping- SERR- FastB2B- DisINTx-
>>>>>           Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast
>>>>> >TAbort-
>>>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>>>           Latency: 0
>>>>>           Interrupt: pin C routed to IRQ 255
>>>>>           Region 0: Memory at c131b000 (64-bit, non-prefetchable)
>>>>> [size=4K]
>>>>>           Capabilities: [50] Power Management version 3
>>>>>                   Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
>>>>> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>>>>>                   Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0
>>>>> PME-
>>>>>           Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
>>>>>                   Address: 00000000  Data: 0000
>>>>>
>>>>> 01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
>>>>> RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 0c)
>>>>>           Subsystem: Acer Incorporated [ALI] Device 0918
>>>>>           Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
>>>>> ParErr-
>>>>> Stepping- SERR- FastB2B- DisINTx+
>>>>>           Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast
>>>>> >TAbort-
>>>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>>>           Latency: 0, Cache Line Size: 64 bytes
>>>>>           Interrupt: pin A routed to IRQ 46
>>>>>           Region 0: I/O ports at 3000 [size=256]
>>>>>           Region 2: Memory at c1200000 (64-bit, non-prefetchable)
>>>>> [size=4K]
>>>>>           Region 4: Memory at c1000000 (64-bit, prefetchable)
>>>>> [size=16K]
>>>>>           Capabilities: [40] Power Management version 3
>>>>>                   Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
>>>>> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>>>>>                   Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0
>>>>> PME-
>>>>>           Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
>>>>>                   Address: 00000000fee00378  Data: 0000
>>>>>           Capabilities: [70] Express (v2) Endpoint, MSI 01
>>>>>                   DevCap: MaxPayload 128 bytes, PhantFunc 0,
>>>>> Latency L0s
>>>>> <512ns, L1 <64us
>>>>>                           ExtTag- AttnBtn- AttnInd- PwrInd- RBE+
>>>>> FLReset-
>>>>>                   DevCtl: Report errors: Correctable- Non-Fatal-
>>>>> Fatal-
>>>>> Unsupported-
>>>>>                           RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
>>>>>                           MaxPayload 128 bytes, MaxReadReq 4096 bytes
>>>>>                   DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-
>>>>> AuxPwr+
>>>>> TransPend-
>>>>>                   LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM
>>>>> L0s L1,
>>>>> Exit
>>>>> Latency L0s unlimited, L1 <64us
>>>>>                           ClockPM+ Surprise- LLActRep- BwNot-
>>>>>                   LnkCtl: ASPM Disabled; RCB 64 bytes Disabled-
>>>>> CommClk+
>>>>>                           ExtSynch- ClockPM- AutWidDis- BWInt-
>>>>> AutBWInt-
>>>>>                   LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train-
>>>>> SlotClk+
>>>>> DLActive- BWMgmt- ABWMgmt-
>>>>>                   DevCap2: Completion Timeout: Range ABCD,
>>>>> TimeoutDis+,
>>>>> LTR+,
>>>>> OBFF Via message/WAKE#
>>>>>                   DevCtl2: Completion Timeout: 50us to 50ms,
>>>>> TimeoutDis-,
>>>>> LTR+, OBFF Disabled
>>>>>                   LnkCtl2: Target Link Speed: 2.5GT/s,
>>>>> EnterCompliance-
>>>>> SpeedDis-
>>>>>                            Transmit Margin: Normal Operating Range,
>>>>> EnterModifiedCompliance- ComplianceSOS-
>>>>>                            Compliance De-emphasis: -6dB
>>>>>                   LnkSta2: Current De-emphasis Level: -6dB,
>>>>> EqualizationComplete-, EqualizationPhase1-
>>>>>                            EqualizationPhase2-, EqualizationPhase3-,
>>>>> LinkEqualizationRequest-
>>>>>           Capabilities: [b0] MSI-X: Enable- Count=4 Masked-
>>>>>                   Vector table: BAR=4 offset=00000000
>>>>>                   PBA: BAR=4 offset=00000800
>>>>>           Capabilities: [d0] Vital Product Data
>>>>>                   Unknown small resource type 00, will not decode
>>>>> more.
>>>>>           Capabilities: [100 v1] Advanced Error Reporting
>>>>>                   UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
>>>>> UnxCmplt-
>>>>> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>>>>>                   UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
>>>>> UnxCmplt-
>>>>> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>>>>>                   UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
>>>>> UnxCmplt-
>>>>> RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>>>>>                   CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
>>>>> NonFatalErr-
>>>>>                   CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
>>>>> NonFatalErr+
>>>>>                   AERCap: First Error Pointer: 00, GenCap+ CGenEn-
>>>>> ChkCap+
>>>>> ChkEn-
>>>>>           Capabilities: [140 v1] Virtual Channel
>>>>>                   Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
>>>>>                   Arb:    Fixed- WRR32- WRR64- WRR128-
>>>>>                   Ctrl:   ArbSelect=Fixed
>>>>>                   Status: InProgress-
>>>>>                   VC0:    Caps:   PATOffset=00 MaxTimeSlots=1
>>>>> RejSnoopTrans-
>>>>>                           Arb:    Fixed- WRR32- WRR64- WRR128-
>>>>> TWRR128-
>>>>> WRR256-
>>>>>                           Ctrl:   Enable+ ID=0 ArbSelect=Fixed
>>>>> TC/VC=ff
>>>>>                           Status: NegoPending- InProgress-
>>>>>           Capabilities: [160 v1] Device Serial Number
>>>>> 01-00-00-00-68-4c-e0-00
>>>>>           Capabilities: [170 v1] Latency Tolerance Reporting
>>>>>                   Max snoop latency: 3145728ns
>>>>>                   Max no snoop latency: 3145728ns
>>>>>           Kernel driver in use: r8169
>>>>>
>>>>> 02:00.0 Network controller: Intel Corporation Wireless 7265 (rev 48)
>>>>>           Subsystem: Intel Corporation Dual Band Wireless-AC 7265
>>>>>           Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
>>>>> ParErr-
>>>>> Stepping- SERR- FastB2B- DisINTx+
>>>>>           Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast
>>>>> >TAbort-
>>>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>>>           Latency: 0, Cache Line Size: 64 bytes
>>>>>           Interrupt: pin A routed to IRQ 51
>>>>>           Region 0: Memory at c1100000 (64-bit, non-prefetchable)
>>>>> [size=8K]
>>>>>           Capabilities: [c8] Power Management version 3
>>>>>                   Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
>>>>> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>>>>>                   Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0
>>>>> PME-
>>>>>           Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
>>>>>                   Address: 00000000fee00458  Data: 0000
>>>>>           Capabilities: [40] Express (v2) Endpoint, MSI 00
>>>>>                   DevCap: MaxPayload 128 bytes, PhantFunc 0,
>>>>> Latency L0s
>>>>> <512ns, L1 unlimited
>>>>>                           ExtTag- AttnBtn- AttnInd- PwrInd- RBE+
>>>>> FLReset+
>>>>>                   DevCtl: Report errors: Correctable- Non-Fatal-
>>>>> Fatal-
>>>>> Unsupported-
>>>>>                           RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+
>>>>> FLReset-
>>>>>                           MaxPayload 128 bytes, MaxReadReq 128 bytes
>>>>>                   DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-
>>>>> AuxPwr+
>>>>> TransPend-
>>>>>                   LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM
>>>>> L1, Exit
>>>>> Latency L0s <4us, L1 <32us
>>>>>                           ClockPM+ Surprise- LLActRep- BwNot-
>>>>>                   LnkCtl: ASPM Disabled; RCB 64 bytes Disabled-
>>>>> CommClk+
>>>>>                           ExtSynch- ClockPM- AutWidDis- BWInt-
>>>>> AutBWInt-
>>>>>                   LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train-
>>>>> SlotClk+
>>>>> DLActive- BWMgmt- ABWMgmt-
>>>>>                   DevCap2: Completion Timeout: Range B,
>>>>> TimeoutDis+, LTR+,
>>>>> OBFF Via WAKE#
>>>>>                   DevCtl2: Completion Timeout: 16ms to 55ms,
>>>>> TimeoutDis-,
>>>>> LTR+, OBFF Disabled
>>>>>                   LnkCtl2: Target Link Speed: 2.5GT/s,
>>>>> EnterCompliance-
>>>>> SpeedDis-
>>>>>                            Transmit Margin: Normal Operating Range,
>>>>> EnterModifiedCompliance- ComplianceSOS-
>>>>>                            Compliance De-emphasis: -6dB
>>>>>                   LnkSta2: Current De-emphasis Level: -3.5dB,
>>>>> EqualizationComplete-, EqualizationPhase1-
>>>>>                            EqualizationPhase2-, EqualizationPhase3-,
>>>>> LinkEqualizationRequest-
>>>>>           Capabilities: [100 v1] Advanced Error Reporting
>>>>>                   UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
>>>>> UnxCmplt-
>>>>> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>>>>>                   UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
>>>>> UnxCmplt-
>>>>> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>>>>>                   UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
>>>>> UnxCmplt-
>>>>> RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>>>>>                   CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
>>>>> NonFatalErr-
>>>>>                   CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
>>>>> NonFatalErr+
>>>>>                   AERCap: First Error Pointer: 00, GenCap- CGenEn-
>>>>> ChkCap-
>>>>> ChkEn-
>>>>>           Capabilities: [140 v1] Device Serial Number
>>>>> 60-57-18-ff-ff-1d-45-e8
>>>>>           Capabilities: [14c v1] Latency Tolerance Reporting
>>>>>                   Max snoop latency: 3145728ns
>>>>>                   Max no snoop latency: 3145728ns
>>>>>           Capabilities: [154 v1] L1 PM Substates
>>>>>                   L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
>>>>> ASPM_L1.1+
>>>>> L1_PM_Substates+
>>>>>                             PortCommonModeRestoreTime=30us
>>>>> PortTPowerOnTime=60us
>>>>>           Kernel driver in use: iwlwifi
>>>>>
>>>>>
>>>>> [7.6.] SCSI information (from /proc/scsi/scsi)
>>>>> Attached devices:
>>>>> Host: scsi0 Channel: 00 Id: 00 Lun: 00
>>>>>     Vendor: ATA      Model: KINGSTON RBU-SC1 Rev: 07.7
>>>>>     Type:   Direct-Access                    ANSI  SCSI revision: 05
>>>>>
>>>>>
>>>>> [7.7.] Other information that might be relevant to the problem
>>>>>          (please look in /proc and include all information that you
>>>>>          think to be relevant):
>>>>>
>>>>>
>>>>> [X.] Other notes, patches, fixes, workarounds:
>>>>> This problem can temporarily solved by disabling and re-enabling
>>>>> the touchpad which is pressing Fn+F7 twice.
>>>>>
>>>>> Link to the Ubuntu Launchpad bug report
>>>>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1429933
>>>>>
>>>>> I am not a professional but I am not afraid of further testing or
>>>>> debugging
>>>>> and sincerely want to offer my further help to investigate this
>>>>> problem.
>>>>> Please, do not hesitate to ask for any help I could offer.
>>>>>
>>>>> Thank you very much for your efforts.
>>>>>
>>>>> With best regards.
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>> linux-input" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--------------010207070409060308040206
Content-Type: text/plain; charset=UTF-8;
 name="f54.out"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="f54.out"

dHggPSAxNgpyeCA9IDI4CjEgICAgMiAgICAxICAgIDIgICAgMiAgICAyICAgIDEgICAgMSAg
ICAyICAgIDEgICAgMSAgICAxICAgIDEgICAgMSAgICAyICAgIDEgICAgMiAgICAzICAgIDMg
ICAgMyAgICA0ICAgIDUgICAgMSAgICAxICAgIDEgICAgMiAgICAyICAgIDIgICAKOCAgICA3
ICAgIDYgICAgOSAgICA4ICAgIDggICAgNyAgICA3ICAgIDcgICAgNyAgICA2ICAgIDUgICAg
NiAgICA1ICAgIDYgICAgNyAgICA5ICAgIDEwICAgMTAgICA5ICAgIDEwICAgMTAgICA1ICAg
IDYgICAgNyAgICA4ICAgIDEwICAgOSAgIAo4ICAgIDggICAgOCAgICA5ICAgIDkgICAgOSAg
ICA4ICAgIDcgICAgNyAgICA3ICAgIDcgICAgNyAgICA2ICAgIDcgICAgOCAgICA4ICAgIDkg
ICAgMTAgICA5ICAgIDEwICAgMTAgICAxMCAgIDYgICAgNyAgICA3ICAgIDkgICAgMTAgICAx
MCAgCjggICAgOCAgICA3ICAgIDkgICAgOSAgICA5ICAgIDggICAgNyAgICA4ICAgIDcgICAg
OCAgICA3ICAgIDUgICAgNiAgICA3ICAgIDggICAgMTAgICAxMCAgIDkgICAgMTAgICAxMCAg
IDkgICAgNiAgICA2ICAgIDggICAgOSAgICA5ICAgIDEwICAKNiAgICA1ICAgIDUgICAgOCAg
ICA3ICAgIDcgICAgNyAgICA2ICAgIDYgICAgNiAgICA2ICAgIDUgICAgNCAgICA1ICAgIDYg
ICAgNiAgICA4ICAgIDEwICAgMTAgICA5ICAgIDEwICAgOSAgICA0ICAgIDUgICAgNiAgICA3
ICAgIDkgICAgNyAgIAo2ICAgIDYgICAgNSAgICA4ICAgIDcgICAgNyAgICA1ICAgIDYgICAg
NSAgICA2ICAgIDUgICAgNSAgICA0ICAgIDYgICAgNyAgICA3ICAgIDkgICAgMTAgICA5ICAg
IDEwICAgMTAgICA5ICAgIDQgICAgNSAgICA2ICAgIDggICAgOCAgICA3ICAgCjUgICAgNCAg
ICA0ICAgIDYgICAgNiAgICA1ICAgIDQgICAgNCAgICA0ICAgIDQgICAgNSAgICA1ICAgIDMg
ICAgNCAgICA1ICAgIDUgICAgNiAgICA3ICAgIDkgICAgOSAgICA5ICAgIDEwICAgMyAgICA1
ICAgIDUgICAgNSAgICA2ICAgIDYgICAKNCAgICA0ICAgIDMgICAgNiAgICA1ICAgIDUgICAg
NCAgICA0ICAgIDQgICAgNCAgICAzICAgIDMgICAgMiAgICA0ICAgIDMgICAgNCAgICA1ICAg
IDcgICAgNyAgICA3ICAgIDcgICAgOCAgICAzICAgIDMgICAgNCAgICA1ICAgIDYgICAgNSAg
IAo0ICAgIDMgICAgMyAgICA0ICAgIDUgICAgNCAgICAzICAgIDQgICAgNCAgICAzICAgIDMg
ICAgMyAgICAzICAgIDMgICAgMyAgICAzICAgIDUgICAgNiAgICA3ICAgIDcgICAgNyAgICA3
ICAgIDIgICAgMyAgICAzICAgIDQgICAgNSAgICA1ICAgCjUgICAgMyAgICA0ICAgIDYgICAg
NSAgICA1ICAgIDQgICAgNCAgICA0ICAgIDQgICAgMyAgICAzICAgIDMgICAgMyAgICAzICAg
IDQgICAgNSAgICA3ICAgIDcgICAgNyAgICA5ICAgIDggICAgMyAgICA0ICAgIDUgICAgNCAg
ICA2ICAgIDUgICAKMyAgICAzICAgIDMgICAgNSAgICA1ICAgIDMgICAgMiAgICAzICAgIDMg
ICAgMyAgICAyICAgIDMgICAgMiAgICAzICAgIDMgICAgMiAgICA1ICAgIDYgICAgOCAgICA3
ICAgIDggICAgOCAgICAyICAgIDMgICAgNCAgICA0ICAgIDUgICAgNSAgIAozICAgIDQgICAg
MyAgICA1ICAgIDUgICAgNCAgICA0ICAgIDQgICAgNCAgICAzICAgIDMgICAgMyAgICAzICAg
IDMgICAgNCAgICA0ICAgIDUgICAgNiAgICA3ICAgIDcgICAgOCAgICA4ICAgIDEgICAgMyAg
ICA0ICAgIDUgICAgNSAgICA1ICAgCjUgICAgNiAgICA1ICAgIDcgICAgNyAgICA1ICAgIDUg
ICAgNSAgICA2ICAgIDQgICAgNSAgICA1ICAgIDUgICAgNCAgICA1ICAgIDUgICAgNyAgICAx
MCAgIDEwICAgMTAgICAxMSAgIDExICAgNCAgICA1ICAgIDYgICAgNiAgICA3ICAgIDcgICAK
NyAgICA3ICAgIDcgICAgOSAgICA5ICAgIDggICAgNyAgICA3ICAgIDggICAgNyAgICA3ICAg
IDcgICAgNSAgICA2ICAgIDcgICAgNyAgICAxMCAgIDEwICAgMTEgICAxMSAgIDEyICAgMTEg
ICA1ICAgIDcgICAgOCAgICA5ICAgIDEwICAgMTAgIAoxMCAgIDkgICAgOSAgICAxMCAgIDEw
ICAgMTAgICA5ICAgIDkgICAgOSAgICAxMCAgIDggICAgOCAgICA4ICAgIDkgICAgMTAgICAx
MCAgIDExICAgMTAgICAxMCAgIDExICAgMTAgICAxMCAgIDcgICAgOSAgICAxMCAgIDExICAg
MTAgICA5ICAgCjggICAgOCAgICA3ICAgIDEwICAgOSAgICA5ICAgIDggICAgOCAgICA5ICAg
IDggICAgOSAgICA4ICAgIDcgICAgNyAgICA5ICAgIDggICAgMTAgICAxMCAgIDEwICAgMTAg
ICAxMCAgIDEwICAgNSAgICA3ICAgIDkgICAgMTAgICAxMCAgIDkgICAKClJlc2V0dGluZy4u
LgpSZXNldCBjb21wbGV0ZWQuCg==
--------------010207070409060308040206--
