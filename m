From: VRan Liu <gliuwr@gmail.com>
Subject: Re: [PATCH] HID: hid-logitech-hidpp: driver for m545/m546 mouse
Date: Fri, 9 Oct 2015 10:18:17 +0800
Message-ID: <CAH=QK0DCOBKBQG4YVwd62hNXx6kqKRGrXfG0Qf_=QRMngYSdnA@mail.gmail.com>
References: <1443550815-27247-1-git-send-email-kreijack@libero.it>
 <5616A2EE.6060208@gmail.com> <CAN+gG=HvLw1Y23YrLEX_zssk=Cays=0wptsZgHnFkmzm48YZpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:34001 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756258AbbJICSh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Oct 2015 22:18:37 -0400
Received: by obbda8 with SMTP id da8so52833497obb.1
        for <linux-input@vger.kernel.org>; Thu, 08 Oct 2015 19:18:37 -0700 (PDT)
In-Reply-To: <CAN+gG=HvLw1Y23YrLEX_zssk=Cays=0wptsZgHnFkmzm48YZpQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Goffredo Baroncelli <kreijack@gmail.com>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>

This is duplicated mail in plain text for content policy of mail list.

Hi all,

I use `solaar show` in https://github.com/pwr/Solaar to detect features.
My m546 support 0x1B00(REPROG CONTROLS) and 0x1B03(REPROG CONTROLS V3),
but doesn't have 0x1B04(REPROG CONTROLS V4).

Rgd,
VRan


On Fri, Oct 9, 2015 at 4:57 AM, Benjamin Tissoires
<benjamin.tissoires@gmail.com> wrote:
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
