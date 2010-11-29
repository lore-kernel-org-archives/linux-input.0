From: Duncan Laurie <dlaurie@chromium.org>
Subject: Re: [PATCH] Input: serio - clear serio event queue after sysfs driver rebind
Date: Mon, 29 Nov 2010 13:37:35 -0800
Message-ID: <AANLkTik1TE9zgKaiLQZ=1uFgMyZt43xp8VJBWfxdVyMY@mail.gmail.com>
References: <1290467390-25302-1-git-send-email-dlaurie@chromium.org> <20101127084153.GC28745@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:54716 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222Ab0K2Vhw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Nov 2010 16:37:52 -0500
Received: from wpaz21.hot.corp.google.com (wpaz21.hot.corp.google.com [172.24.198.85])
	by smtp-out.google.com with ESMTP id oATLbpWd026290
	for <linux-input@vger.kernel.org>; Mon, 29 Nov 2010 13:37:51 -0800
Received: from qyk36 (qyk36.prod.google.com [10.241.83.164])
	by wpaz21.hot.corp.google.com with ESMTP id oATLaKsU029724
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Mon, 29 Nov 2010 13:37:50 -0800
Received: by qyk36 with SMTP id 36so1899713qyk.13
        for <linux-input@vger.kernel.org>; Mon, 29 Nov 2010 13:37:50 -0800 (PST)
In-Reply-To: <20101127084153.GC28745@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Nov 27, 2010 at 12:41 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Duncan,
>
> On Mon, Nov 22, 2010 at 03:09:50PM -0800, Duncan Laurie wrote:
>> When rebinding a serio driver via sysfs drvctl interface it is possi=
ble for
>> an interrupt to trigger after the disconnect of the existing driver =
and
>> before the binding of the new driver. =A0This will cause the serio i=
nterrupt
>> handler to queue a rescan event which will disconnect the new driver
>> immediately after it is attached.
>>
>> This change clears the serio event queue after processing the drvctl
>> request but before releasing the serio mutex, which will clear any q=
ueued
>> rescans before they can get processed.
>>
>> Reproduction involves issuing a rebind of device port from psmouse d=
river
>> to serio_raw driver while generating input to trigger interrupts. =A0=
Then
>> checking to see if the corresponding i8042/serio4/driver is correctl=
y
>> attached to the serio_raw driver instead of psmouse.
>>
>> Signed-off-by: Duncan Laurie <dlaurie@chromium.org>
>> ---
>> =A0drivers/input/serio/serio.c | =A0 =A01 +
>> =A01 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio=
=2Ec
>> index 405bf21..a66307e 100644
>> --- a/drivers/input/serio/serio.c
>> +++ b/drivers/input/serio/serio.c
>> @@ -454,6 +454,7 @@ static ssize_t serio_rebind_driver(struct device=
 *dev, struct device_attribute *
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 serio_disconnect_port(serio);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D serio_bind_driver(serio, to_se=
rio_driver(drv));
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 put_driver(drv);
>> + =A0 =A0 =A0 =A0 =A0 =A0 serio_remove_pending_events(serio);
>
> Hmm, makes sense, although should we limit events being removed to
> rescan events only?
>


That seems reasonable.  It would mean adding a new function or a
parameter to the existing serio_remove_pending_events function, do you
have a preference?

Thanks,
-duncan
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
