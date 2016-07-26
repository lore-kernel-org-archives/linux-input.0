From: Cameron Gutman <aicommander@gmail.com>
Subject: Re: [PATCH] Input: xpad - fix wireless 360 controller breaking after
 suspend
Date: Mon, 25 Jul 2016 22:05:50 -0700
Message-ID: <c5977c90-a340-8aae-6937-6a8eac2d2f22@gmail.com>
References: <0635c1d0-7572-bac9-99cc-7a0db54c9013@gmail.com>
 <CA+b0ujckSVMOVK4+Kc4gMrg3hVZ5mEwkPY=a5DwhHm+Qi-yiEg@mail.gmail.com>
 <CA+b0ujemf2succq3Yc2vWy788EvYGRutPQeYH54aZf_kiS9FcA@mail.gmail.com>
 <cae811ad-b6ab-6e0c-b324-10c81ea8effa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:36478 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753640AbcGZFFx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Jul 2016 01:05:53 -0400
Received: by mail-pa0-f66.google.com with SMTP id ez1so12581284pab.3
        for <linux-input@vger.kernel.org>; Mon, 25 Jul 2016 22:05:53 -0700 (PDT)
In-Reply-To: <cae811ad-b6ab-6e0c-b324-10c81ea8effa@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Rojtberg <rojtberg@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On 07/23/2016 09:49 AM, Cameron Gutman wrote:
> On 07/23/2016 03:42 AM, Pavel Rojtberg wrote:
>> resume still works here
>>
>> 2016-07-23 12:15 GMT+02:00 Pavel Rojtberg <rojtberg@gmail.com>:
>>> If you blame the line, you will see that it was introduced to fix the
>>> exact problem you are describing.
>>> Maybe the used USB controller is relevant or something changed in USB
>>> core meanwhile.
>>> I will test whether resume works for me without that line as well and
>>> report back.
>>>
> 
> Yes, I saw the original commit. I included you on the email
> directly so you would see the change.
> 
> I think whether the issue appears depends on USB power settings
> in the system firmware. My desktop never reproduces the bug,
> but my laptop almost always does.
> 
> On the machine where it never reproduced, the wireless adapter
> _always_ reconnected on resume. Apparently, the HC lost enough
> state that the devices were always re-enumerated.
> 
> On my laptop where it reproduced often, the wireless adapter
> wouldn't reconnect on resume. When resuming, the reset_resume
> path is always used, since we use USB_QUIRK_RESET_RESUME.
> 
> When the bug reproduces, the output URB gets stuck forever
> and only completes when explicitly killed. I think this is the
> type of behavior that the quirk is designed to work around.
> 
> By re-enumerating instead of resuming, we get correct behavior
> on both LED lights (since they are correctly assigned again in
> probe) and no URB hang anymore. We could probably write a
> reset_resume callback that did the right thing in all cases,
> but relying on USB core to do it for us is much less complexity.
> 
>>> Cameron Gutman <aicommander@gmail.com> schrieb am Sa., 23. Juli 2016
>>> um 10:27 Uhr:
>>>>
>>>> Suspending and resuming the system can sometimes cause the out
>>>> URB to get hung after a reset_resume. This causes LED setting
>>>> and force feedback to break on resume. To avoid this, just drop
>>>> the reset_resume callback so the USB core rebinds xpad to the
>>>> wireless pads on resume if a reset happened.
>>>>
>>>> A nice side effect of this change is the LED ring on wireless
>>>> controllers is now set correctly on system resume.
>>>>
>>>> Signed-off-by: Cameron Gutman <aicommander@gmail.com>
>>>> Cc: stable@vger.kernel.org
>>>> ---
>>>>  drivers/input/joystick/xpad.c | 1 -
>>>>  1 file changed, 1 deletion(-)
>>>>
>>>> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
>>>> index a529a45..843054a 100644
>>>> --- a/drivers/input/joystick/xpad.c
>>>> +++ b/drivers/input/joystick/xpad.c
>>>> @@ -1626,7 +1626,6 @@ static struct usb_driver xpad_driver = {
>>>>         .disconnect     = xpad_disconnect,
>>>>         .suspend        = xpad_suspend,
>>>>         .resume         = xpad_resume,
>>>> -       .reset_resume   = xpad_resume,
>>>>         .id_table       = xpad_table,
>>>>  };
>>>>
>>>> --
>>>> 2.7.4

Let's put this patch on hold. I would like to better understand the cause
of the hangs and differing behavior between machines. I'll see how it
behaves on a few other machines of mine. I would like to confirm whether
it's a bug in xpad or just a general USB issue on my laptop hardware.


Cameron
