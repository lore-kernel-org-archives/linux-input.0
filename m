From: Goffredo Baroncelli <kreijack@gmail.com>
Subject: Re: [PATCH] HID: hid-logitech-hidpp: driver for m545/m546 mouse
Date: Fri, 9 Oct 2015 22:10:06 +0200
Message-ID: <56181F1E.9080708@gmail.com>
References: <1443550815-27247-1-git-send-email-kreijack@libero.it>
 <5616A2EE.6060208@gmail.com>
 <CAN+gG=HvLw1Y23YrLEX_zssk=Cays=0wptsZgHnFkmzm48YZpQ@mail.gmail.com>
Reply-To: kreijack@inwind.it
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:34977 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752094AbbJIUKK (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Oct 2015 16:10:10 -0400
Received: by wicge5 with SMTP id ge5so82870132wic.0
        for <linux-input@vger.kernel.org>; Fri, 09 Oct 2015 13:10:08 -0700 (PDT)
In-Reply-To: <CAN+gG=HvLw1Y23YrLEX_zssk=Cays=0wptsZgHnFkmzm48YZpQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input@vger.kernel.org, VRan Liu <gliuwr@gmail.com>

On 2015-10-08 22:57, Benjamin Tissoires wrote:
> Hi Goffredo,
> 
> On Thu, Oct 8, 2015 at 1:07 PM, Goffredo Baroncelli <kreijack@gmail.com> wrote:
>> Ping,
>>
>>
>> Benjamin, Nestor,
>>
>> do you have any comments ?
> 
> Sorry for not going back to you earlier. I do not see any obvious
> problems in the patch (few comments though), but I think we can do
> better (and for the M560 too).
> 
> I have now a much better understanding of the MX Master, and this
> mouse also sends some Windows 8 gestures. We can disable them in a
> similar way the M560 does, but we have the per button release
> information. Also, I think with my latest hidpp patches, we should be
> able to drop the manual parsing of the mouse report.
> 
> Could you please download libratbag from
> https://github.com/libratbag/libratbag, add your device id in
> src/driver-hidpp20.c, make and run:
> $ sudo ./tools/ratbag-command --verbose=raw list
> 
> This should dump the list of supported features your mouse has, and if
> the feature 0x1b04 ("programmable keys/buttons") shows up, then we
> will be able to clean up the code and have it working for these 3
> mice.

Hi Benjamin,

for the m545, VRan already replyied. For the M560 to me it seems that my M560 doesn't support the feature 0x1b04 ("programmable keys/buttons")

$ sudo sudo ./tools/ratbag-command --verbose=raw list 2>&1 | grep 1b04
$

However it reports something about a "HIDPP_PAGE_KBD_REPROGRAMMABLE_KEYS (0x1b00)". Below the full output

$ sudo sudo ./tools/ratbag-command --verbose=raw list 
ratbag debug: trying driver 'Roccat Kone XTD'
ratbag debug: trying driver 'Logitech HID++1.0'
ratbag debug: trying driver 'Logitech HID++2.0'
ratbag debug: trying driver 'EtekCity'
ratbag debug: trying driver 'Roccat Kone XTD'
ratbag debug: trying driver 'Logitech HID++1.0'
ratbag debug: trying driver 'Logitech HID++2.0'
ratbag debug: trying driver 'EtekCity'
ratbag debug: trying driver 'Roccat Kone XTD'
ratbag debug: trying driver 'Logitech HID++1.0'
ratbag debug: trying driver 'Logitech HID++2.0'
ratbag debug: trying driver 'EtekCity'
ratbag debug: trying driver 'Roccat Kone XTD'
ratbag debug: trying driver 'Logitech HID++1.0'
ratbag debug: trying driver 'Logitech HID++2.0'
ratbag debug: trying driver 'EtekCity'
ratbag debug: trying driver 'Roccat Kone XTD'
ratbag debug: trying driver 'Logitech HID++1.0'
ratbag debug: trying driver 'Logitech HID++2.0'
ratbag debug: trying driver 'EtekCity'
ratbag debug: trying driver 'Roccat Kone XTD'
ratbag debug: trying driver 'Logitech HID++1.0'
ratbag debug: trying driver 'Logitech HID++2.0'
ratbag debug: trying driver 'EtekCity'
ratbag debug: trying driver 'Roccat Kone XTD'
ratbag debug: trying driver 'Logitech HID++1.0'
ratbag debug: trying driver 'Logitech HID++2.0'
ratbag debug: Logitech Wireless Mouse M560 is device '/dev/hidraw1'.
ratbag debug: report ID 01
ratbag debug: report ID 0e
ratbag debug: report ID 02
ratbag debug: report ID 10
ratbag debug: report ID 11
ratbag debug: report ID 20
ratbag debug: report ID 21
ratbag raw: output report: 11 ff 00 18 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: input report:  11 01 04 02 46 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: input report:  11 01 00 18 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag debug: 'Logitech Wireless Mouse M560' is using protocol v2.0
ratbag raw: output report: 11 ff 00 08 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: input report:  11 01 00 08 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: feature 0x0001 is at 0x01
ratbag raw: output report: 11 ff 01 08 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: input report:  11 01 01 08 15 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: output report: 11 ff 01 18 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: input report:  11 01 01 18 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: output report: 11 ff 01 18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: input report:  11 01 01 18 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: output report: 11 ff 01 18 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: input report:  11 01 01 18 00 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: output report: 11 ff 01 18 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: input report:  11 01 01 18 00 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: output report: 11 ff 01 18 04 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: input report:  11 01 01 18 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: output report: 11 ff 01 18 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: input report:  11 01 01 18 18 30 60 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: output report: 11 ff 01 18 06 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: input report:  11 01 01 18 18 50 60 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: output report: 11 ff 01 18 07 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: input report:  11 01 01 18 18 60 60 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: output report: 11 ff 01 18 08 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: input report:  11 01 01 18 18 90 60 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: output report: 11 ff 01 18 09 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: input report:  11 01 01 18 18 a0 60 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: output report: 11 ff 01 18 0a 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: input report:  11 01 01 18 1b 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: output report: 11 ff 01 18 0b 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: input report:  11 01 01 18 1d 4b 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: output report: 11 ff 01 18 0c 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: input report:  11 01 01 18 1d f3 60 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: output report: 11 ff 01 18 0d 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: input report:  11 01 01 18 1b 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: output report: 11 ff 01 18 0e 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: input report:  11 01 01 18 1d f0 40 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: output report: 11 ff 01 18 0f 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: input report:  11 01 01 18 1e 00 40 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: output report: 11 ff 01 18 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: input report:  11 01 01 18 18 b0 60 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: output report: 11 ff 01 18 11 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: input report:  11 01 01 18 1e 90 60 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: output report: 11 ff 01 18 12 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: input report:  11 01 01 18 1f 03 60 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: output report: 11 ff 01 18 13 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: input report:  11 01 01 18 21 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: output report: 11 ff 01 18 14 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: input report:  11 01 01 18 21 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: 'Logitech Wireless Mouse M560' has 21 features
ratbag raw: Init feature HIDPP_PAGE_ROOT (0x0000) 
ratbag raw: Init feature HIDPP_PAGE_FEATURE_SET (0x0001) 
ratbag raw: Init feature  0x3 (0x0003) 
ratbag raw: unknown feature 0x0003
ratbag raw: Init feature  0x5 (0x0005) 
ratbag raw: unknown feature 0x0005
ratbag raw: Init feature HIDPP_PAGE_BATTERY_LEVEL_STATUS (0x1000) 
ratbag raw: output report: 11 ff 00 08 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: input report:  11 01 00 08 04 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: feature 0x1000 is at 0x04
ratbag raw: output report: 11 ff 04 08 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: input report:  11 01 04 08 46 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag debug: device battery level is 70% (next 5%), status 0 
ratbag raw: Init feature 0x1830 (0x1830) 
ratbag raw: unknown feature 0x1830
ratbag raw: Init feature 0x1850 (0x1850) 
ratbag raw: unknown feature 0x1850
ratbag raw: Init feature 0x1860 (0x1860) 
ratbag raw: unknown feature 0x1860
ratbag raw: Init feature 0x1890 (0x1890) 
ratbag raw: unknown feature 0x1890
ratbag raw: Init feature 0x18a0 (0x18a0) 
ratbag raw: unknown feature 0x18a0
ratbag raw: Init feature 0x1b03 (0x1b03) 
ratbag raw: unknown feature 0x1b03
ratbag raw: Init feature 0x1d4b (0x1d4b) 
ratbag raw: unknown feature 0x1d4b
ratbag raw: Init feature 0x1df3 (0x1df3) 
ratbag raw: unknown feature 0x1df3
ratbag raw: Init feature HIDPP_PAGE_KBD_REPROGRAMMABLE_KEYS (0x1b00) 
ratbag debug: device has programmable keys/buttons
ratbag raw: output report: 11 ff 00 08 1b 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: input report:  11 01 00 08 0d 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: feature 0x1b00 is at 0x0d
ratbag raw: output report: 11 ff 0d 08 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: input report:  11 01 0d 08 07 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: output report: 11 ff 0d 18 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: input report:  11 01 0d 18 00 50 00 38 11 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: control 0: cid: 'Left' (80) tid: 'Left Click' (56) flags: 0x11
ratbag raw: output report: 11 ff 0d 18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: input report:  11 01 0d 18 00 51 00 39 11 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: control 1: cid: 'Right' (81) tid: 'Right Click' (57) flags: 0x11
ratbag raw: output report: 11 ff 0d 18 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: input report:  11 01 0d 18 00 53 00 8b 11 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: control 2: cid: 'Back' (83) tid: 'UNKNOWN' (139) flags: 0x11
ratbag raw: output report: 11 ff 0d 18 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: input report:  11 01 0d 18 00 56 00 8c 11 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: control 3: cid: 'Forward' (86) tid: 'UNKNOWN' (140) flags: 0x11
ratbag raw: output report: 11 ff 0d 18 04 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: input report:  11 01 0d 18 00 b0 00 8d 11 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: control 4: cid: 'UNKNOWN' (176) tid: 'UNKNOWN' (141) flags: 0x11
ratbag raw: output report: 11 ff 0d 18 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: input report:  11 01 0d 18 00 ae 00 8e 11 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: control 5: cid: 'UNKNOWN' (174) tid: 'UNKNOWN' (142) flags: 0x11
ratbag raw: output report: 11 ff 0d 18 06 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: input report:  11 01 0d 18 00 af 00 86 31 00 00 00 00 00 00 00 00 00 00 00
ratbag raw: control 6: cid: 'UNKNOWN' (175) tid: 'UNKNOWN' (134) flags: 0x31
ratbag raw: Init feature 0x1df0 (0x1df0) 
ratbag raw: unknown feature 0x1df0
ratbag raw: Init feature 0x1e00 (0x1e00) 
ratbag raw: unknown feature 0x1e00
ratbag raw: Init feature 0x18b0 (0x18b0) 
ratbag raw: unknown feature 0x18b0
ratbag raw: Init feature 0x1e90 (0x1e90) 
ratbag raw: unknown feature 0x1e90
ratbag raw: Init feature 0x1f03 (0x1f03) 
ratbag raw: unknown feature 0x1f03
ratbag raw: Init feature 0x2100 (0x2100) 
ratbag raw: unknown feature 0x2100
ratbag raw: Init feature 0x2120 (0x2120) 
ratbag raw: unknown feature 0x2120
ratbag debug: driver match found
/dev/input/event14:	Logitech Wireless Mouse M560
ratbag debug: trying driver 'Roccat Kone XTD'
ratbag debug: trying driver 'Logitech HID++1.0'
ratbag debug: trying driver 'Logitech HID++2.0'
ratbag debug: trying driver 'EtekCity'
ratbag debug: trying driver 'Roccat Kone XTD'
ratbag debug: trying driver 'Logitech HID++1.0'
ratbag debug: trying driver 'Logitech HID++2.0'
ratbag debug: trying driver 'EtekCity'
ratbag debug: trying driver 'Roccat Kone XTD'
ratbag debug: trying driver 'Logitech HID++1.0'
ratbag debug: trying driver 'Logitech HID++2.0'
ratbag debug: trying driver 'EtekCity'
ratbag debug: trying driver 'Roccat Kone XTD'
ratbag debug: trying driver 'Logitech HID++1.0'
ratbag debug: trying driver 'Logitech HID++2.0'
ratbag debug: trying driver 'EtekCity'
ratbag debug: trying driver 'Roccat Kone XTD'
ratbag debug: trying driver 'Logitech HID++1.0'
ratbag debug: trying driver 'Logitech HID++2.0'
ratbag debug: trying driver 'EtekCity'
ratbag debug: trying driver 'Roccat Kone XTD'
ratbag debug: trying driver 'Logitech HID++1.0'
ratbag debug: trying driver 'Logitech HID++2.0'
ratbag debug: trying driver 'EtekCity'
ratbag debug: trying driver 'Roccat Kone XTD'
ratbag debug: trying driver 'Logitech HID++1.0'
ratbag debug: trying driver 'Logitech HID++2.0'
ratbag debug: trying driver 'EtekCity'
ratbag debug: trying driver 'Roccat Kone XTD'
ratbag debug: trying driver 'Logitech HID++1.0'
ratbag debug: trying driver 'Logitech HID++2.0'
ratbag debug: trying driver 'EtekCity'

> 
> Few remarks inlined:
> 
>>
>> BR
>> G.Baroncelli
>> On 2015-09-29 20:20, Goffredo Baroncelli wrote:
>>> From: Goffredo Baroncelli <kreijack@inwind.it>
>>>
>>> Add support for the Logitech m545/m546 mouse. This mouse is designed
>>> for windows 8. So when the side buttons are pressed, it sends some
>>> keyboard keys instead of mouse buttons.
>>>
>>> Original-author: VRan Liu <gliuwr@gmail.com>
>>> Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
>>> ---
>>>
>>> In the comments of the code there is a brief description of the protocol.
>>>
>>> I developed a similar solution for the Logitech m560 mouse, which was included
>>> in the kernel v4.2.1. Then I was contacted by VRan Liu; he adapted my patch
>>> for this mouse and he asked me to send its patch to the mailing list.
>>>
>>>
>>>  drivers/hid/hid-logitech-hidpp.c | 143 ++++++++++++++++++++++++++++++++++++++-
>>>  1 file changed, 142 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
>>> index 4841964..6de57c0 100644
>>> --- a/drivers/hid/hid-logitech-hidpp.c
>>> +++ b/drivers/hid/hid-logitech-hidpp.c
>>> @@ -41,8 +41,9 @@ MODULE_PARM_DESC(disable_raw_mode,
>>>
>>>  #define HIDPP_QUIRK_CLASS_WTP                        BIT(0)
>>>  #define HIDPP_QUIRK_CLASS_M560                       BIT(1)
>>> +#define HIDPP_QUIRK_CLASS_M545                       BIT(2)
>>>
>>> -/* bits 2..20 are reserved for classes */
>>> +/* bits 3..20 are reserved for classes */
>>>  #define HIDPP_QUIRK_DELAYED_INIT             BIT(21)
>>>  #define HIDPP_QUIRK_WTP_PHYSICAL_BUTTONS     BIT(22)
>>>
>>> @@ -1132,6 +1133,131 @@ static int m560_input_mapping(struct hid_device *hdev, struct hid_input *hi,
>>>       return -1;
>>>  }
>>>
>>> +/* ------------------------------------------------------------------------- */
>>> +/* Logitech M545/M546 devices                                                */
>>> +/* ------------------------------------------------------------------------- */
>>> +
>>> +/*
>>> + * Logitech M545 protocol overview
>>> + *
>>> + * The Logitech M545 mouse, is designed for windows 8. When the sides buttons
>>> + * are pressed, it sends some keyboard keys events instead of buttons ones.
>>> + *
>>> + * forward button -> Super_R
>>> + * backward button -> Super_L+'d' (press only)
>>> + * NB: press-only means that when the button is pressed, the
>>> + * KeyPress/ButtonPress and KeyRelease/ButtonRelease events are generated
>>> + * together sequentially; instead when the button is released, no event is
>>> + * generated !
>>> + *
>>> + * for the sides button it sends:
>>> + *   side 1 button (forward)     press   11<xx>15 0000a900...
>>> + *                                                   (then keyboard events)
>>> + *   side 2 button (backward)    press   11<xx>15 0000ae00...
>>> + *                                                   (then keyboard events)
>>> + */
>>> +
>>> +
>>> +struct m545_private_data {
>>> +     struct input_dev *input;
>>> +};
>>> +
>>> +#define M545_SUB_ID                  0x15
>>> +
>>> +static int m545_allocate(struct hid_device *hdev)
>>> +{
>>> +     struct hidpp_device *hidpp = hid_get_drvdata(hdev);
>>> +     struct m545_private_data *d;
>>> +
>>> +     d = devm_kzalloc(&hdev->dev, sizeof(struct m545_private_data),
>>> +                     GFP_KERNEL);
>>> +     if (!d)
>>> +             return -ENOMEM;
>>> +
>>> +     hidpp->private_data = d;
>>> +
>>> +     return 0;
>>> +};
>>> +
>>> +static int m545_raw_event(struct hid_device *hdev, u8 *data, int size)
>>> +{
>>> +     struct hidpp_device *hidpp = hid_get_drvdata(hdev);
>>> +     struct m545_private_data *mydata = hidpp->private_data;
>>> +
>>> +     /* sanity check */
>>> +     if (!mydata || !mydata->input) {
>>> +             hid_err(hdev, "error in parameter\n");
>>> +             return -EINVAL;
>>> +     }
>>> +
>>> +     if (size < 7) {
>>> +             hid_err(hdev, "error in report\n");
>>> +             return 0;
>>> +     }
>>> +
>>> +     if (data[0] == REPORT_ID_HIDPP_LONG &&
>>> +         data[2] == M545_SUB_ID && data[6] == 0x00) {
>>> +             /*
>>> +              * m545 mouse report for middle, forward and backward button
>>> +              *
>>> +              * data[0] = 0x11
>>> +              * data[1] = device-id
>>> +              * data[2] = 0x15
>>> +              * data[5] = 0xa9 -> forward
>>> +              *           0xae -> backward
>>> +              *           0x00 -> release all
>>> +              * data[6] = 0x00
>>> +              */
>>> +
>>> +             switch (data[5]) {
>>> +             case 0xa9:
>>> +                     input_report_key(mydata->input, BTN_FORWARD, 1);
>>> +                     break;
>>> +             case 0xae:
>>> +                     input_report_key(mydata->input, BTN_BACK, 1);
>>> +                     break;
>>> +             case 0x00:
>>> +                     input_report_key(mydata->input, BTN_BACK, 0);
>>> +                     input_report_key(mydata->input, BTN_FORWARD, 0);
>>> +                     break;
>>> +             default:
>>> +                     hid_err(hdev, "error in report\n");
>>> +                     return 0;
>>> +             }
>>> +             input_sync(mydata->input);
>>> +     }
>>> +
>>> +     return 1;
>>> +}
>>> +
>>> +static void m545_populate_input(struct hidpp_device *hidpp,
>>> +             struct input_dev *input_dev, bool origin_is_hid_core)
>>> +{
>>> +     struct m545_private_data *mydata = hidpp->private_data;
>>> +
>>> +     mydata->input = input_dev;
>>> +
>>> +     __set_bit(EV_KEY, mydata->input->evbit);
>>> +     __set_bit(BTN_MIDDLE, mydata->input->keybit);
>>> +     __set_bit(BTN_RIGHT, mydata->input->keybit);
>>> +     __set_bit(BTN_LEFT, mydata->input->keybit);
>>> +     __set_bit(BTN_BACK, mydata->input->keybit);
>>> +     __set_bit(BTN_FORWARD, mydata->input->keybit);
>>> +
>>> +     __set_bit(EV_REL, mydata->input->evbit);
>>> +     __set_bit(REL_X, mydata->input->relbit);
>>> +     __set_bit(REL_Y, mydata->input->relbit);
>>> +     __set_bit(REL_WHEEL, mydata->input->relbit);
>>> +     __set_bit(REL_HWHEEL, mydata->input->relbit);
> 
> Not a big fan of this, given that the default one should already have this.
> 
>>> +}
>>> +
>>> +static int m545_input_mapping(struct hid_device *hdev, struct hid_input *hi,
>>> +             struct hid_field *field, struct hid_usage *usage,
>>> +             unsigned long **bit, int *max)
>>> +{
>>> +     return -1;
> 
> If we just ignore the keyboard mapping, the mouse should be populated
> properly (hopefully).
> 
> Again, I will need to push the MX Master code I have somewhere to
> check if this will also work for your mice.
> 
> Cheers,
> Benjamin
> 
>>> +}
>>> +
>>>  /* -------------------------------------------------------------------------- */
>>>  /* Generic HID++ devices                                                      */
>>>  /* -------------------------------------------------------------------------- */
>>> @@ -1147,6 +1273,9 @@ static int hidpp_input_mapping(struct hid_device *hdev, struct hid_input *hi,
>>>       else if (hidpp->quirks & HIDPP_QUIRK_CLASS_M560 &&
>>>                       field->application != HID_GD_MOUSE)
>>>               return m560_input_mapping(hdev, hi, field, usage, bit, max);
>>> +     else if (hidpp->quirks & HIDPP_QUIRK_CLASS_M545 &&
>>> +                     field->application != HID_GD_MOUSE)
>>> +             return m545_input_mapping(hdev, hi, field, usage, bit, max);
>>>
>>>       return 0;
>>>  }
>>> @@ -1158,6 +1287,8 @@ static void hidpp_populate_input(struct hidpp_device *hidpp,
>>>               wtp_populate_input(hidpp, input, origin_is_hid_core);
>>>       else if (hidpp->quirks & HIDPP_QUIRK_CLASS_M560)
>>>               m560_populate_input(hidpp, input, origin_is_hid_core);
>>> +     else if (hidpp->quirks & HIDPP_QUIRK_CLASS_M545)
>>> +             m545_populate_input(hidpp, input, origin_is_hid_core);
>>>  }
>>>
>>>  static void hidpp_input_configured(struct hid_device *hdev,
>>> @@ -1247,6 +1378,8 @@ static int hidpp_raw_event(struct hid_device *hdev, struct hid_report *report,
>>>               return wtp_raw_event(hdev, data, size);
>>>       else if (hidpp->quirks & HIDPP_QUIRK_CLASS_M560)
>>>               return m560_raw_event(hdev, data, size);
>>> +     else if (hidpp->quirks & HIDPP_QUIRK_CLASS_M545)
>>> +             return m545_raw_event(hdev, data, size);
>>>
>>>       return 0;
>>>  }
>>> @@ -1408,6 +1541,10 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
>>>               ret = m560_allocate(hdev);
>>>               if (ret)
>>>                       goto allocate_fail;
>>> +     } else if (hidpp->quirks & HIDPP_QUIRK_CLASS_M545) {
>>> +             ret = m545_allocate(hdev);
>>> +             if (ret)
>>> +                     goto allocate_fail;
>>>       }
>>>
>>>       INIT_WORK(&hidpp->work, delayed_work_cb);
>>> @@ -1502,6 +1639,10 @@ static const struct hid_device_id hidpp_devices[] = {
>>>         HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
>>>               USB_VENDOR_ID_LOGITECH, 0x402d),
>>>         .driver_data = HIDPP_QUIRK_DELAYED_INIT | HIDPP_QUIRK_CLASS_M560 },
>>> +     { /* Mouse logitech M545/M546 */
>>> +       HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
>>> +             USB_VENDOR_ID_LOGITECH, 0x4028),
>>> +       .driver_data = HIDPP_QUIRK_CLASS_M545 },
>>>
>>>       { HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
>>>               USB_VENDOR_ID_LOGITECH, HID_ANY_ID)},
>>>
>>
>>
>> --
>> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
>> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
> .
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
