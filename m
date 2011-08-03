From: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH v4 1/2] Input: enable i8042-level wakeup control
Date: Wed, 3 Aug 2011 09:04:56 +0100
Message-ID: <CAMLZHHTTXvThE5bWfyjJu-UFJbaKAhzORKWV8ay4RZW-ZVifLg@mail.gmail.com>
References: <20110802154916.624619D401C@zog.reactivated.net>
	<20110803065920.GC23399@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:40688 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821Ab1HCIE5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Aug 2011 04:04:57 -0400
Received: by gyh3 with SMTP id 3so317204gyh.19
        for <linux-input@vger.kernel.org>; Wed, 03 Aug 2011 01:04:56 -0700 (PDT)
In-Reply-To: <20110803065920.GC23399@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-pm@lists.linux-foundation.org, rjw@sisk.pl, dilinger@queued.net, pgf@laptop.org

On Wed, Aug 3, 2011 at 7:59 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> I am not sure that we should be marking input devices themselves as
> wakeup capable - they are in no way physical devices. I'd stop at ser=
io
> level...

We need a way to make sure the device state is untouched during
suspend/resume. Would you be happier if an input device looked at the
device_may_wakeup() of its parent?

>>
>> diff --git a/drivers/input/input.c b/drivers/input/input.c
>> index da38d97..639aba7 100644
>> --- a/drivers/input/input.c
>> +++ b/drivers/input/input.c
>> @@ -1588,6 +1588,9 @@ static int input_dev_suspend(struct device *de=
v)
>> =A0{
>> =A0 =A0 =A0 struct input_dev *input_dev =3D to_input_dev(dev);
>>
>> + =A0 =A0 if (device_may_wakeup(dev))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>
> On suspend should we not try to shut off leds and sound?

Thats right. The setup is that the system appears to be running as
normal, our display also remains on during suspend (and wifi, and so
on). Bar the laptop's power LED which goes from always-on to flashing,
the user is unaware that the laptop has suspended.

>> =A0 =A0 =A0 mutex_lock(&input_dev->mutex);
>>
>> =A0 =A0 =A0 if (input_dev->users)
>> @@ -1602,7 +1605,8 @@ static int input_dev_resume(struct device *dev=
)
>> =A0{
>> =A0 =A0 =A0 struct input_dev *input_dev =3D to_input_dev(dev);
>>
>> - =A0 =A0 input_reset_device(input_dev);
>> + =A0 =A0 if (!device_may_wakeup(dev))
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_reset_device(input_dev);
>>
>
> Does the controller wakes up the system on key release or only press?=
 My
> concern is with cases when we suspend with a key pressed and wake up
> with it already released.

It wakes up on key press, but our EC buffers communication, so both
the key press and key release event would be delivered in the above
scenario.

>> @@ -87,6 +87,7 @@ MODULE_PARM_DESC(debug, "Turn i8042 debugging mode=
 on and off");
>> =A0#endif
>>
>> =A0static bool i8042_bypass_aux_irq_test;
>> +static bool i8042_enable_wakeup;
>>
>> =A0#include "i8042.h"
>>
>> @@ -1082,10 +1083,17 @@ static void i8042_dritek_enable(void)
>> =A0 * before suspending.
>> =A0 */
>>
>> -static int i8042_controller_resume(bool force_reset)
>> +static int i8042_controller_resume(bool force_reset, bool soft_resu=
me)
>> =A0{
>> =A0 =A0 =A0 int error;
>>
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* If device is selected as a wakeup source, it was not =
powered down
>> + =A0 =A0 =A0* or reset during suspend, so we have very little to do=
=2E
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (soft_resume)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto soft;
>
> Maybe instead of adding a parameter simply not call the function and
> move i8042_interrupt as well?

OK

>> =A0static int i8042_pm_resume(struct device *dev)
>> =A0{
>> =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0* On resume from S2R we always try to reset the contr=
oller
>> =A0 =A0 =A0 =A0* to bring it in a sane state. (In case of S2D we exp=
ect
>> =A0 =A0 =A0 =A0* BIOS to reset the controller for us.)
>> + =A0 =A0 =A0* This function call will also handle any pending keypr=
ess event
>> + =A0 =A0 =A0* (perhaps the system wakeup reason)
>> + =A0 =A0 =A0*/
>> + =A0 =A0 int r =3D i8042_controller_resume(true, device_may_wakeup(=
dev));
>> +
>> + =A0 =A0 /* If the device was left running during suspend, enable I=
RQs again
>> + =A0 =A0 =A0* now. Must be done last to avoid races with interrupt =
processing
>> + =A0 =A0 =A0* inside i8042_controller_resume.
>> =A0 =A0 =A0 =A0*/
>
> Hmm, we have proper locking so I am not sure how true this statement =
is.

What happens is that the event used to wake up the system is not
delivered as an interrupt (consistent with the fact that the resume
handler already calls i8042_interrupt() manually). However, there is a
race window. If the system was woken up with a key press, and then the
key was released during early resume, the key press event will not be
presented as an interrupt, but the key release event will. That
interrupt can arrive before i8042_controller_resume() reaches
i8042_interrupt(), which would result in those 2 events being
processed in the wrong order. I'll make this clearer in the comment.

Thanks for the fast review comments!
Daniel
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
