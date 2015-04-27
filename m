From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: PROBLEM: Touchpad works just like a mouse
Date: Mon, 27 Apr 2015 14:25:28 -0400
Message-ID: <CAN+gG=EUXJzCoPzPji0Uv_WMO0rKznHU6qcbTqtcksAOADFTjw@mail.gmail.com>
References: <552C4E6C.4070102@klo.es>
	<552F6AC9.6020005@klo.es>
	<CAN+gG=ENP5Uf06S1cdXKsGNmLDfGKOt3mP9iOeoxyqSzuDMoKA@mail.gmail.com>
	<55320164.5010905@klo.es>
	<553D5E91.2080704@klo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:34516 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964867AbbD0SZ3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Apr 2015 14:25:29 -0400
Received: by qgfi89 with SMTP id i89so53153276qgf.1
        for <linux-input@vger.kernel.org>; Mon, 27 Apr 2015 11:25:28 -0700 (PDT)
In-Reply-To: <553D5E91.2080704@klo.es>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?Q?David_Zafra_G=C3=B3mez?= <dezeta@klo.es>
Cc: linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Duson Lin <dusonlin@emc.com.tw>, Jiri Kosina <jkosina@suse.cz>, Hans de Goede <hdegoede@redhat.com>

Hi David,

On Sun, Apr 26, 2015 at 5:54 PM, David Zafra G=C3=B3mez <dezeta@klo.es>=
 wrote:
> Hi Benjamin and everybody.
>
> I haven't received any notice of you. I'd like to know if there is an=
y
> chance for this issue to be solved. Are you taken it into your
> consideration?

Sorry for the lag. And thanks for the clarification about the USB mouse=
=2E

=46rom what I can read in the dmesg, your touchpad is detected as a
regular mouse and is not using any specific driver (while it should to
be able to use the raw touches).
Given that your laptop is an Asus one, I would still lean toward an
Elan touchpad, but we might need more logs.

Can you boot your laptop with the upstream kernel with the following
parameter appended to the kernel boot line: "i8042.debug" (without the
quotes).

Then, do not type anything on the internal keyboard or your password
will be in the logs.
Touch the touchpad with one finger for less than 2 secs (just making
sure the debug output will not overwrite the beginning of the dmesg
output).
=46inally, log on the laptop through ssh or by plugging an external USB
keyboard, and send us the dmesg output.

We might then be able to understand which driver fails to load and
which should be used.

Cheers,
Benjamin


>> Hi everybody again
>>
>> I've unplugged USB mouse and now I don't find this USB HID mouse whe=
n I
>> run cat /proc/modules. Here is the complete output. I hope it will h=
elp.
>>
>> ctr 16384 2 - Live 0x0000000000000000
>> ccm 20480 2 - Live 0x0000000000000000
>> bnep 24576 2 - Live 0x0000000000000000
>> rfcomm 77824 0 - Live 0x0000000000000000
>> nls_iso8859_1 16384 1 - Live 0x0000000000000000
>> intel_rapl 20480 0 - Live 0x0000000000000000
>> iosf_mbi 16384 1 intel_rapl, Live 0x0000000000000000
>> x86_pkg_temp_thermal 16384 0 - Live 0x0000000000000000
>> intel_powerclamp 20480 0 - Live 0x0000000000000000
>> coretemp 16384 0 - Live 0x0000000000000000
>> kvm_intel 159744 0 - Live 0x0000000000000000
>> kvm 512000 1 kvm_intel, Live 0x0000000000000000
>> crct10dif_pclmul 16384 0 - Live 0x0000000000000000
>> crc32_pclmul 16384 0 - Live 0x0000000000000000
>> asus_nb_wmi 24576 0 - Live 0x0000000000000000
>> ghash_clmulni_intel 16384 0 - Live 0x0000000000000000
>> aesni_intel 172032 4 - Live 0x0000000000000000
>> asus_wmi 28672 1 asus_nb_wmi, Live 0x0000000000000000
>> aes_x86_64 20480 1 aesni_intel, Live 0x0000000000000000
>> lrw 16384 1 aesni_intel, Live 0x0000000000000000
>> gf128mul 16384 1 lrw, Live 0x0000000000000000
>> glue_helper 16384 1 aesni_intel, Live 0x0000000000000000
>> ablk_helper 16384 1 aesni_intel, Live 0x0000000000000000
>> ath3k 16384 0 - Live 0x0000000000000000
>> sparse_keymap 16384 1 asus_wmi, Live 0x0000000000000000
>> arc4 16384 2 - Live 0x0000000000000000
>> cryptd 24576 3 ghash_clmulni_intel,aesni_intel,ablk_helper, Live
>> 0x0000000000000000
>> ath9k 155648 0 - Live 0x0000000000000000
>> ath9k_common 32768 1 ath9k, Live 0x0000000000000000
>> ath9k_hw 487424 2 ath9k,ath9k_common, Live 0x0000000000000000
>> ath 32768 3 ath9k,ath9k_common,ath9k_hw, Live 0x0000000000000000
>> mac80211 774144 1 ath9k, Live 0x0000000000000000
>> snd_hda_codec_hdmi 53248 1 - Live 0x0000000000000000
>> btusb 45056 0 - Live 0x0000000000000000
>> cfg80211 581632 4 ath9k,ath9k_common,ath,mac80211, Live 0x0000000000=
000000
>> i915 1126400 5 - Live 0x0000000000000000
>> dell_smo8800 16384 0 - Live 0x0000000000000000
>> wmi 20480 1 asus_wmi, Live 0x0000000000000000
>> bluetooth 524288 12 bnep,rfcomm,ath3k,btusb, Live 0x0000000000000000
>> dw_dmac 16384 0 - Live 0x0000000000000000
>> dw_dmac_core 28672 1 dw_dmac, Live 0x0000000000000000
>> serio_raw 16384 0 - Live 0x0000000000000000
>> snd_hda_codec_conexant 24576 1 - Live 0x0000000000000000
>> snd_hda_codec_generic 73728 1 snd_hda_codec_conexant, Live
>> 0x0000000000000000
>> snd_hda_intel 32768 5 - Live 0x0000000000000000
>> snd_soc_rt5640 94208 0 - Live 0x0000000000000000
>> 8250_dw 16384 0 - Live 0x0000000000000000
>> snd_soc_rl6231 16384 1 snd_soc_rt5640, Live 0x0000000000000000
>> snd_hda_controller 36864 1 snd_hda_intel, Live 0x0000000000000000
>> snd_hda_codec 147456 5
>> snd_hda_codec_hdmi,snd_hda_codec_conexant,snd_hda_codec_generic,snd_=
hda_intel,snd_hda_controller,
>> Live 0x0000000000000000
>> snd_soc_core 200704 1 snd_soc_rt5640, Live 0x0000000000000000
>> int3402_thermal 16384 0 - Live 0x0000000000000000
>> snd_soc_sst_acpi 16384 0 - Live 0x0000000000000000
>> i2c_hid 20480 0 - Live 0x0000000000000000
>> mei_me 20480 0 - Live 0x0000000000000000
>> video 28672 2 asus_wmi,i915, Live 0x0000000000000000
>> snd_hwdep 16384 1 snd_hda_codec, Live 0x0000000000000000
>> snd_seq_midi 16384 0 - Live 0x0000000000000000
>> snd_seq_midi_event 16384 1 snd_seq_midi, Live 0x0000000000000000
>> snd_rawmidi 32768 1 snd_seq_midi, Live 0x0000000000000000
>> snd_compress 20480 1 snd_soc_core, Live 0x0000000000000000
>> snd_pcm_dmaengine 16384 1 snd_soc_core, Live 0x0000000000000000
>> snd_seq 69632 2 snd_seq_midi,snd_seq_midi_event, Live 0x000000000000=
0000
>> hid 114688 1 i2c_hid, Live 0x0000000000000000
>> spi_pxa2xx_platform 24576 0 - Live 0x0000000000000000
>> snd_pcm 110592 7
>> snd_hda_codec_hdmi,snd_hda_intel,snd_soc_rt5640,snd_hda_controller,s=
nd_hda_codec,snd_soc_core,snd_pcm_dmaengine,
>> Live 0x0000000000000000
>> drm_kms_helper 126976 1 i915, Live 0x0000000000000000
>> drm 352256 6 i915,drm_kms_helper, Live 0x0000000000000000
>> mei 90112 1 mei_me, Live 0x0000000000000000
>> snd_seq_device 16384 3 snd_seq_midi,snd_rawmidi,snd_seq, Live
>> 0x0000000000000000
>> shpchp 40960 0 - Live 0x0000000000000000
>> snd_timer 32768 2 snd_seq,snd_pcm, Live 0x0000000000000000
>> parport_pc 36864 0 - Live 0x0000000000000000
>> ppdev 20480 0 - Live 0x0000000000000000
>> int3400_thermal 16384 0 - Live 0x0000000000000000
>> acpi_thermal_rel 16384 1 int3400_thermal, Live 0x0000000000000000
>> processor_thermal_device 16384 0 - Live 0x0000000000000000
>> int340x_thermal_zone 16384 2 int3402_thermal,processor_thermal_devic=
e,
>> Live 0x0000000000000000
>> mac_hid 16384 0 - Live 0x0000000000000000
>> i2c_designware_platform 16384 0 - Live 0x0000000000000000
>> i2c_algo_bit 16384 1 i915, Live 0x0000000000000000
>> i2c_designware_core 16384 1 i2c_designware_platform, Live
>> 0x0000000000000000
>> lpc_ich 24576 0 - Live 0x0000000000000000
>> lp 20480 0 - Live 0x0000000000000000
>> snd 86016 23
>> snd_hda_codec_hdmi,snd_hda_codec_conexant,snd_hda_codec_generic,snd_=
hda_intel,snd_hda_codec,snd_soc_core,snd_hwdep,snd_rawmidi,snd_compress=
,snd_seq,snd_pcm,snd_seq_device,snd_timer,
>> Live 0x0000000000000000
>> parport 45056 3 parport_pc,ppdev,lp, Live 0x0000000000000000
>> soundcore 16384 2 snd_hda_codec,snd, Live 0x0000000000000000
>> ahci 36864 4 - Live 0x0000000000000000
>> psmouse 126976 0 - Live 0x0000000000000000
>> libahci 32768 1 ahci, Live 0x0000000000000000
>> alx 45056 0 - Live 0x0000000000000000
>> mdio 16384 1 alx, Live 0x0000000000000000
>> sdhci_acpi 16384 0 - Live 0x0000000000000000
>> sdhci 45056 1 sdhci_acpi, Live 0x0000000000000000
>>
>> Cheers,
>>
>> David Zafra
>>
>> El 16/04/15 a las 16:44, Benjamin Tissoires escribi=C3=B3:
>>>
>>> Hi David,
>>>
>>> [Adding relevant people to the thread]
>>>
>>> according to the dmesg, there is a USB HID mouse (with Elan VID:PID
>>> 04F3:0232) connected to your laptop.
>>>
>>> I just want to confirm that you did not plugged any external USB mo=
use
>>> and that this one is your touchpad.
>>>
>>> If that's the case, we will need Duson's help.
>>>
>>> Duson, would it be possible that this USB touchpad can be activate
>>> with the same-ish protocol than the i2c one we found in the Lenovo
>>> Yoga 3?
>>> If so, that would be in our best interest to fix all of that in HID=
=2E
>>>
>>> Cheers,
>>> Benjamin
>>>
>>>
>>> On Thu, Apr 16, 2015 at 3:54 AM, David Zafra G=C3=B3mez <dezeta@klo=
=2Ees> wrote:
>>>>
>>>> [1.] Touchpad works just like a mouse.
>>>>
>>>> [2.] Touchpad features like scrolling, tapping, etc. do not work a=
t all.
>>>> Also, I cannot disable touchpad, even if I try to do it using spec=
ial
>>>> key
>>>> functions (fn) for notebooks. Touchpad multitouch gestures doesn't=
 work.
>>>> It's simple to reproduce. I just boot my Linux system and I try to=
 use
>>>> my
>>>> touchpad. System doesn't recognize it as a touchpad 8 (I cannot en=
able
>>>> touchpad functions).
>>>> My notebook model is ASUSTeK COMPUTER INC. PU551LA.
>>>>
>>>> [3.]
>>>>
>>>> [4.] Linux version 4.0.0-040000-generic (kernel@gomeisa) (gcc vers=
ion
>>>> 4.6.3
>>>> (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201504121935 SMP Sun Apr 12 23:3=
6:33
>>>> UTC
>>>> 2015
>>>>
>>>> [5.]
>>>>
>>>> [6.]
>>>>
>>>> [7.] Description:    Ubuntu 14.04.2 LTS
>>>> Release:    14.04
>>>>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
