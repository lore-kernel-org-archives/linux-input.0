From: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH v2] Input: enable i8042-level wakeup control
Date: Mon, 11 Jul 2011 14:22:22 +0100
Message-ID: <CAGq3pz5D=qDyfodEB2ikNsP0V94nTKNJ8-jyrb7=irH571bUPA@mail.gmail.com>
References: <20110709211321.5FE139D401C@zog.reactivated.net>
	<201107102300.14064.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f52.google.com ([209.85.161.52]:49533 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756886Ab1GKNWX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Jul 2011 09:22:23 -0400
Received: by fxd18 with SMTP id 18so3987959fxd.11
        for <linux-input@vger.kernel.org>; Mon, 11 Jul 2011 06:22:22 -0700 (PDT)
In-Reply-To: <201107102300.14064.rjw@sisk.pl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: dmitry.torokhov@gmail.com, dtor@mail.ru, linux-input@vger.kernel.org, dilinger@queued.net, linux-pm@lists.linux-foundation.org

Hi Rafael, many thanks for looking at this.

2011/7/10 Rafael J. Wysocki <rjw@sisk.pl>:
>> @@ -1602,6 +1611,15 @@ static int input_dev_resume(struct device *de=
v)
>> =A0{
>> =A0 =A0 =A0 struct input_dev *input_dev =3D to_input_dev(dev);
>>
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* If this device is a child of serio, which is a child =
of i8042, and
>> + =A0 =A0 =A0* i8042 wakeup is enabled (i.e. this input device was n=
ot suspended),
>> + =A0 =A0 =A0* do nothing.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (dev->parent && dev->parent->parent
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && device_may_wakeup(dev->=
parent->parent))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>
> You check exactly the same condition in two places with very similar =
comments.
> I'd put it into a bool function and add a kerneldoc description to it=
 instead.

OK, I agree. I was hoping that you'd be able to point out a better way
of doing this though - I think you'd agree that this code is not very
nice. But maybe explaining it better and hiding it away in its own
function is the best approach we have.

It is a strange case, because the device hierarchy is as follows:

i8042 -> serio -> input

Yet the kernel sees the i8042 and input devices as somewhat
independent devices on different busses, so each one has its own
independent suspend/resume implementation called from the PM layer.
And in this particular case, I need to make the i8042 controller
communicate the fact that its grandchild input device should not be
suspended or reset.

> The fact that you need provide several empty definitions of
> i8042_platform_suspend() is a bit worrisome. =A0Have you considered u=
sing a
> different approach?

This seems quite the norm in i8042-land - those .h files already
include a number of empty functions that were presumably added just
because a small selection of the other supported arches needed to do
something. Nevertheless I'd be happy to convert these drivers to a new
"struct i8042_platform_ops" type system if that helps with the merge
of this patch.

Thanks,
Daniel
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
