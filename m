From: Dmitry Tunin <hanipouspilot@gmail.com>
Subject: Re: [PATCH] Input: psmouse - cleanup Focaltech code
Date: Mon, 17 Oct 2016 20:33:22 +0300
Message-ID: <CANoib0F5029H6h__SbRZ50VjxDqiSUZ+eiNuuMFxs3kDwG7cyQ@mail.gmail.com>
References: <1475923136-6046-1-git-send-email-hanipouspilot@gmail.com> <f574d1ad-ad49-30d1-53ff-3722fda56b35@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33385 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934859AbcJQRdY (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 17 Oct 2016 13:33:24 -0400
In-Reply-To: <f574d1ad-ad49-30d1-53ff-3722fda56b35@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mathias Gottschlag <mgottschlag@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

Other drivers, like Synaptics use the same as I suggested. They even
shorten in psmouse-base.c psmouse_protocol.name to SynPS/2.
You used FocaltechPS/2. I think it is OK.

I do not think it is a big problem of changing the naming. It happens a lot.

I still have the hardware and I am still thankful to you that you
wrote that driver.

Now I am trying to write my own for a new i2c touchpad that is used in
new Asus laptops ;-)

2016-10-17 20:27 GMT+03:00 Mathias Gottschlag <mgottschlag@gmail.com>:
> The changes look good to me. However, what wording do other drivers use?
> I've seen "TouchPad" with a capital P before. If this patch breaks
> scripts searching for that string anyways, that's an opportunity to
> unify the capitalization there. It probably doesn't matter, though... I
> don't see a problem with this patch.
>
> I can't test it because I no longer have the hardware.
>
> Am 08.10.2016 um 12:38 schrieb Dmitry Tunin:
>> psmouse->name "Focaltech Touchpad" is an overkill. In xinput it is too long as
>> "FocaltechPS/2 Focaltech Focaltech Touchpad"
>>
>> In focaltech_report_state() pointer to psmouse->dev is already stored as *dev
>>
>> Signed-off-by: Dmitry Tunin <hanipouspilot@gmail.com>
>> ---
>>  drivers/input/mouse/focaltech.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/input/mouse/focaltech.c b/drivers/input/mouse/focaltech.c
>> index c8c6a8c..49a56f655 100644
>> --- a/drivers/input/mouse/focaltech.c
>> +++ b/drivers/input/mouse/focaltech.c
>> @@ -43,7 +43,7 @@ int focaltech_detect(struct psmouse *psmouse, bool set_properties)
>>
>>       if (set_properties) {
>>               psmouse->vendor = "FocalTech";
>> -             psmouse->name = "FocalTech Touchpad";
>> +             psmouse->name = "Touchpad";
>>       }
>>
>>       return 0;
>> @@ -146,8 +146,8 @@ static void focaltech_report_state(struct psmouse *psmouse)
>>       }
>>       input_mt_report_pointer_emulation(dev, true);
>>
>> -     input_report_key(psmouse->dev, BTN_LEFT, state->pressed);
>> -     input_sync(psmouse->dev);
>> +     input_report_key(dev, BTN_LEFT, state->pressed);
>> +     input_sync(dev);
>>  }
>>
>>  static void focaltech_process_touch_packet(struct psmouse *psmouse,
>
>
