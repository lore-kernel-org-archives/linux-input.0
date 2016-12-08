From: Vladyslav Shtabovenko <dev@shtabovenko.df-kunde.de>
Subject: Re: [PATCH] HID: usbhid: quirk for MechanicalEagle Z-77 keyboard
Date: Thu, 8 Dec 2016 20:39:01 +0100
Message-ID: <3b47abb2-47cc-ed33-7c36-f79538182954@shtabovenko.df-kunde.de>
References: <823ed7c4-cb1c-a042-4309-4064b9bbfc78@shtabovenko.df-kunde.de>
 <20161201142323.GC1280@mail.corp.redhat.com>
 <1d8aedb6-9045-a93f-9471-b9f8b9227818@shtabovenko.df-kunde.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay03.ispgateway.de ([80.67.31.37]:39208 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752257AbcLHTvT (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 8 Dec 2016 14:51:19 -0500
In-Reply-To: <1d8aedb6-9045-a93f-9471-b9f8b9227818@shtabovenko.df-kunde.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, jikos@kernel.org

By the way, I also did some research on the internet and apparently
many gaming/mechanical keyboards require similar quirks:

https://unix.stackexchange.com/questions/280564/usb-submit-urbctrl-failed-1-corsair-k65-rgb-keyboard/280574#280574

This one concerns the same chip as in my keyboard:

https://askubuntu.com/questions/811162/keyboard-not-working-after-waking-from-suspend-sleep/846019

With usbhid.quirks=0x04D9:0xA0CD:0x20000408 added to GRUB_CMDLINE_LINUX
the keyboard works fine also on unpatched kernels.

Cheers,
Vladyslav




Am 05.12.2016 um 22:56 schrieb Vladyslav Shtabovenko:
> Hi,
>
> sorry for the late reply. I prefer to test things before submitting
> them here and compiling the kernel takes more than one hour on
> my machine...
>
> It sounds very weird, but if I remove the drivers/hid/hid-holtek-kbd.c
> hunk and leave the other quirks, then the keyboard does not work at all:
> It just does not recognized, so I cannot type anything. Does this make
> any sense?
>
> Unless it is some sort of anomaly on Fedora's 4.8.10-100 kernel, it
> seems that for some reason (that I don't understand) one has to declare
> the keyboard in hid-holtek-kbd, although it is then controlled by usbhid.
>
> Cheers,
> Vladyslav
>
>
>
> Am 01.12.2016 um 15:23 schrieb Benjamin Tissoires:
>> On Nov 30 2016 or thereabouts, Vladyslav Shtabovenko wrote:
>>> Hi,
>>>
>>> my MechanicalEagle Z-77 keyboard that identifies itself as
>>>
>>> Bus 003 Device 005: ID 04d9:a0cd Holtek Semiconductor, Inc.
>>>
>>> has troubles getting recognized after standby. My machine is
>>> a Thinkpad X230 in an Ultrabase docking station and everytime
>>> the laptop wakes up from standby, the keyboard is not working
>>> and I have to reconnect it several times until I can type again.
>>>
>>> The problem is identical to the one described here:
>>>
>>> http://lkml.iu.edu/hypermail/linux/kernel/1407.1/04532.html
>>>
>>> I used the same solution as the author, i.e. added quirks for
>>> the specific ID of the keyboard and the issues went away. Tested
>>> this for more than three weeks with no problems or side effects
>>> whatsoever.
>>>
>>> Initially I sent the patch directly to Benjamin Tissoires and Jiri
>>> Kosina.
>>> Benjamin asked me to add the keyboard to hid_have_special_driver in
>>> hid-core.c, to ensure that it is handled by hid-holtek instead of
>>> hid-generic.
>>>
>>> However, after doing so, it turned out that with
>>> hid-holtek I obtain the same buggy behavior as before. The only
>>> difference
>>> was that the keyboard was sometimes recognized and sometimes not, so
>>> it was
>>> a bit like Russian roulette. I also noticed that the "original"
>>> Holtek-patch
>>> by Wangzhao Cai did not contain this addition to
>>> hid_have_special_driver.
>>>
>>> For me, hid-generic + quirks from the attached patch actually work
>>> better
>>> with my Holtek-based keyboard than hid-holtek with the same quirks.
>>>
>>> Please find my patch attached. This is the one without the addition to
>>> hid_have_special_driver, i.e. it fixes the problem with the keyboard
>>> being
>>> unrecognized after standby in 100% of cases.
>>
>> Hi,
>>
>> you probably also need to remove the drivers/hid/hid-holtek-kbd.c hunk
>> if you prefer having hid-generic hanlding your keyboard.
>>
>> Cheers,
>> Benjamin
>>
>>>
>>>
>>> Cheers,
>>> Vladyslav
>>>
>>
>>> From 29dec1f11e53eb87adedad7b2a7c7559ea290e46 Mon Sep 17 00:00:00 2001
>>> From: Vladyslav Shtabovenko <dev@shtabovenko.df-kunde.de>
>>> Date: Sat, 26 Nov 2016 17:01:38 +0100
>>> Subject: [PATCH] HID: usbhid: quirk for MechanicalEagle Z-77 keyboard
>>>
>>> Hello,
>>>
>>> my MechanicalEagle Z-77 keyboard that identifies itself as
>>>
>>> Bus 003 Device 005: ID 04d9:a0cd Holtek Semiconductor, Inc.
>>>
>>> has troubles getting recognized after standby. My machine is
>>> a Thinkpad X230 in an Ultrabase docking station and everytime
>>> the laptop wakes up from standby, the keyboard is not working
>>> and I have to reconnect it several times until I can type again.
>>>
>>> The problem is identical to the one described here:
>>>
>>> http://lkml.iu.edu/hypermail/linux/kernel/1407.1/04532.html
>>>
>>> I used the same solution as the author, i.e. added quirks for
>>> the specific ID of the keyboard and the issues went away. Tested
>>> this for more than three weeks with no problems or side effects
>>> whatsoever.
>>> Please find my patch attached.
>>>
>>>
>>> Cheers,
>>> Vladyslav
>>>
>>>
>>> Signed-off-by: Vladyslav Shtabovenko <dev@shtabovenko.df-kunde.de>
>>> ---
>>>  drivers/hid/hid-holtek-kbd.c    | 4 +++-
>>>  drivers/hid/hid-ids.h           | 1 +
>>>  drivers/hid/usbhid/hid-quirks.c | 2 ++
>>>  3 files changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/hid/hid-holtek-kbd.c b/drivers/hid/hid-holtek-kbd.c
>>> index 6e1a4a4..6b8593b 100644
>>> --- a/drivers/hid/hid-holtek-kbd.c
>>> +++ b/drivers/hid/hid-holtek-kbd.c
>>> @@ -156,7 +156,9 @@ static int holtek_kbd_probe(struct hid_device *hdev,
>>>
>>>  static const struct hid_device_id holtek_kbd_devices[] = {
>>>      { HID_USB_DEVICE(USB_VENDOR_ID_HOLTEK_ALT,
>>> -            USB_DEVICE_ID_HOLTEK_ALT_KEYBOARD) },
>>> +            USB_DEVICE_ID_HOLTEK_ALT_KEYBOARD),
>>> +        HID_USB_DEVICE(USB_VENDOR_ID_HOLTEK_ALT,
>>> +            USB_DEVICE_ID_HOLTEK_ALT_KEYBOARD_A0CD)    },
>>>      { }
>>>  };
>>>  MODULE_DEVICE_TABLE(hid, holtek_kbd_devices);
>>> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
>>> index 575aa65..898e4fe 100644
>>> --- a/drivers/hid/hid-ids.h
>>> +++ b/drivers/hid/hid-ids.h
>>> @@ -527,6 +527,7 @@
>>>  #define USB_DEVICE_ID_HOLTEK_ALT_MOUSE_A081    0xa081
>>>  #define USB_DEVICE_ID_HOLTEK_ALT_MOUSE_A0C2    0xa0c2
>>>  #define USB_DEVICE_ID_HOLTEK_ALT_KEYBOARD_A096    0xa096
>>> +#define USB_DEVICE_ID_HOLTEK_ALT_KEYBOARD_A0CD    0xa0cd
>>>
>>>  #define USB_VENDOR_ID_IMATION        0x0718
>>>  #define USB_DEVICE_ID_DISC_STAKKA    0xd000
>>> diff --git a/drivers/hid/usbhid/hid-quirks.c
>>> b/drivers/hid/usbhid/hid-quirks.c
>>> index e6cfd32..0632939 100644
>>> --- a/drivers/hid/usbhid/hid-quirks.c
>>> +++ b/drivers/hid/usbhid/hid-quirks.c
>>> @@ -159,6 +159,8 @@ static const struct hid_blacklist {
>>>      { USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_QUAD_HD,
>>> HID_QUIRK_NO_INIT_REPORTS },
>>>      { USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_TP_V103,
>>> HID_QUIRK_NO_INIT_REPORTS },
>>>      { USB_VENDOR_ID_HOLTEK_ALT,
>>> USB_DEVICE_ID_HOLTEK_ALT_KEYBOARD_A096,
>>> HID_QUIRK_NO_INIT_INPUT_REPORTS },
>>> +    { USB_VENDOR_ID_HOLTEK_ALT, USB_DEVICE_ID_HOLTEK_ALT_KEYBOARD_A0CD,
>>> +HID_QUIRK_NO_INIT_INPUT_REPORTS },
>>>      { USB_VENDOR_ID_MULTIPLE_1781,
>>> USB_DEVICE_ID_RAPHNET_4NES4SNES_OLD, HID_QUIRK_MULTI_INPUT },
>>>      { USB_VENDOR_ID_DRACAL_RAPHNET, USB_DEVICE_ID_RAPHNET_2NES2SNES,
>>> HID_QUIRK_MULTI_INPUT },
>>>      { USB_VENDOR_ID_DRACAL_RAPHNET, USB_DEVICE_ID_RAPHNET_4NES4SNES,
>>> HID_QUIRK_MULTI_INPUT },
>>> --
>>> 2.5.5
>>>
>>>
>>
