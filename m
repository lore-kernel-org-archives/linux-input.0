From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH 0/7] A few patches to cyttsp
Date: Wed, 16 Nov 2011 21:17:18 +0100
Message-ID: <CAAwP0s1mgZVjJKTSU8yZXo90QK41a3wv0-Xb1qwKsGg7YZfnUg@mail.gmail.com>
References: <20111114080939.10141.46174.stgit@hammer.corenet.prv>
 <CAAwP0s0eSfxgXWtZXZCm6dY_gtaoyu7QQpEJs7odHTMn2amxTg@mail.gmail.com> <20111116193826.GB26909@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:52293 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831Ab1KPURj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Nov 2011 15:17:39 -0500
Received: by ywt32 with SMTP id 32so118423ywt.19
        for <linux-input@vger.kernel.org>; Wed, 16 Nov 2011 12:17:39 -0800 (PST)
In-Reply-To: <20111116193826.GB26909@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Mohan Pallaka <mpallaka@codeaurora.org>, Kevin McNeely <kev@cypress.com>, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, linux-input@vger.kernel.org

On Wed, Nov 16, 2011 at 8:38 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Wed, Nov 16, 2011 at 08:17:02PM +0100, Javier Martinez Canillas wr=
ote:
>> On Mon, Nov 14, 2011 at 9:15 AM, Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>> > Hi Javier,
>> >
>> > I am sending a few patches that I made while trying to understand =
the
>> > Cypress TTSP driver. I am still not quite happy with the SPI read =
method
>> > and I am also wondering if cyttsp_power_on could be made less mess=
y.
>> >
>>
>> Hi Dmitry,
>>
>> Thank you very much for the review and the patches. One question, wh=
en
>> sending new versions of the patch-set, do you want me to keep the
>> history of your patches or should I merge all of them and submit jus=
t
>> three patches (core, i2c, spi) to make easier future revisions?
>
> You may merge them, I think it will be easier.
>

Ok, thanks.

>>
>> Sure, Kevin will cleanup the SPI read method and I will make
>> cyttsp_power_on more cleaner.
>
> Thanks.
>
>>
>> > Current open/close methods seem to be not very useful: even though=
 we
>> > stop interrupts we do not put the chip into low power mode. Is the=
re a
>> > way to do so?
>> >
>>
>> Yes, the controller can be put to sleep (low power mode). I will add
>> that to the close function for the next version of the patch-set.
>
> Excellent.
>
>>
>> > Regarding PM methods - why do we have conditional 'use sleep' and =
what
>> > exactly wakeup() method is supposed to do? Why is it a platform me=
thod?
>> >
>>
>> It was meant to let each board to decide if it wants to go sleep and
>> to define a specific handler for wakeup.
>
> Why would a board not want to go to sleep? Normally boards want to
> specify whether they want to have device as a wakeup source and such
> devices, instead of shutting down in suspend method, just configure
> their IRQ as a wakeup IRQ and that is it.
>

Yes, you are right. Also, the chip has different low power modes
(light, medium and deep) and use_sleep was also thought so board code
could decide on which low power mode the device has to enter on
suspend.

But, yes. The sleep shouldn't be conditional and we should have a low
power mode by default. Also if the user defines a wakeup() handler,
then the device should enter in a low power mode where interrupts are
still fired (so the board can use this device as a wakeup source).

>> This is for example the board
>> file of the OMAP Encore machine type (B & N Nook's color)
>>
>> static struct cyttsp_platform_data cyttsp_i2c_platform_data =3D {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 .wakeup =3D cyttsp_i2c_wakeup,
>
> OK, so in this particular case what does cyttsp_i2c_wakeup actually
> does?
>

In this case in particular, nothing...

static int cyttsp_i2c_wakeup(void)
{
        return 0;
}

I think is because the resume code returned -ENOSYS if use_sleep was
set and not wakeup handler was defined. So a dummy handler was
defined.

int cyttsp_resume(void *handle)
{
=2E..
		if (ts->platform_data->wakeup)
			retval =3D ts->platform_data->wakeup();
		else
			retval =3D -ENOSYS;
=2E..
}


>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 .init =3D cyttsp_i2c_init,
>> .....
>> }
>>
>> In the same way it exists an init board specific function that gets
>> called from cyttsp_core_init() if the board has defined one:
>>
>> void *cyttsp_core_init(struct cyttsp_bus_ops *bus_ops,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0struct device *dev, int irq)
>> {
>> ....
>> =C2=A0 =C2=A0 =C2=A0 if (ts->platform_data->init) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ts->platform_da=
ta->init()) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 dev_dbg(ts->dev, "%s: Error, platform init failed!\n",
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __func__);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 goto error_init;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 }
>> ....
>> }
>>
>> This is necessary because each board may need to configure different=
ly
>> the connection with the chip. For example, OMAP boards will have to
>> configure the mux pins and so on.
>>
>> Is this correct? or the driver should not have these handlers and
>> trust that the platform specific code did all the set up before?
>
> I think it depends on the kind of set up is happening. Static setup
> (such as registering memory regsions, configuring IRQ type, etc) is
> probably done upfront; if you need to talk to the hardware then custo=
m
> method is fine.
>

Great, I'll keep this init handler then.

> Thanks.
>
> --
> Dmitry
>

Thank you and best regards,

--=20
Javier Mart=C3=ADnez Canillas
(+34) 682 39 81 69
Barcelona, Spain
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
