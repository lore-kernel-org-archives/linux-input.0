From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH v9 1/3] Input: cyttsp - Cypress TTSP capacitive
 multi-touch screen support
Date: Wed, 18 Jan 2012 22:35:48 +0100
Message-ID: <CAAwP0s1Zu5cswyjCeZjm8PRHCVF9j551J=JzNrUgWAjw6xYqOg@mail.gmail.com>
References: <1326508373-23444-1-git-send-email-javier@dowhile0.org>
 <20120118091253.GC32285@core.coreip.homeip.net> <CAAwP0s2=WtBS53o7nYTF512nCHJrtZZJQ88nLUsmDrRVuZ6-Qw@mail.gmail.com>
 <CAAwP0s1VGAe0q5cZ=DVRABP46RpfuJ=+Z-EQaNVZe0xnhDXqLw@mail.gmail.com> <20120118174722.GA9022@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:62983 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433Ab2ARVgJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Jan 2012 16:36:09 -0500
Received: by yenm6 with SMTP id m6so1082797yen.19
        for <linux-input@vger.kernel.org>; Wed, 18 Jan 2012 13:36:09 -0800 (PST)
In-Reply-To: <20120118174722.GA9022@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Mohan Pallaka <mpallaka@codeaurora.org>, Kevin McNeely <kev@cypress.com>, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, linux-input@vger.kernel.org

On Wed, Jan 18, 2012 at 6:47 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Wed, Jan 18, 2012 at 11:35:28AM +0100, Javier Martinez Canillas wr=
ote:
>> On Wed, Jan 18, 2012 at 10:20 AM, Javier Martinez Canillas
>> <martinez.javier@gmail.com> wrote:
>> > On Wed, Jan 18, 2012 at 10:12 AM, Dmitry Torokhov
>> > <dmitry.torokhov@gmail.com> wrote:
>> >> Hi Javier,
>> >>
>> >> On Sat, Jan 14, 2012 at 03:32:51AM +0100, Javier Martinez Canilla=
s wrote:
>> >>> +
>> >>> +static int __cyttsp_disable(struct cyttsp *ts)
>> >>> +{
>> >>> + =C2=A0 =C2=A0 u8 sleep_mode =3D 0;
>> >>> + =C2=A0 =C2=A0 int retval =3D 0;
>> >>> +
>> >>> + =C2=A0 =C2=A0 if (ts->pdata->use_sleep && ts->power_state =3D=3D=
 CY_ACTIVE_STATE) {
>> >>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sleep_mode =3D ts->p=
data->use_sleep;
>> >>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retval =3D ttsp_writ=
e_block_data(ts, CY_REG_BASE,
>> >>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0sizeof(sleep_mode), &sleep_mode);
>> >>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (retval >=3D 0) {
>> >>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ts->power_state =3D CY_SLEEP_STATE;
>> >>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 disable_irq(ts->irq);
>> >>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> >>
>> >> I thought we agreed that we should put the device to sleep
>> >> unconditionally and not have use_sleep option?
>> >
>> > Yes, we did. Sorry, I've missed that. I'll change it and resend.
>> >
>> >>
>> >> Thanks.
>> >>
>> >> --
>> >> Dmitry
>> >> --
>>
>> Thanks Dmitry for the review.
>>
>> Any more issues you have found? So I can fix all of them for the nex=
t
>> version of the patch.
>
> I am still not quite happy with the flow of power_on function. Maybe =
you
> should fold cyttsp_bl_app_valid() into it to avoid dealing with negat=
ive,
> 0 and 1 return codes. If you also pull printing of the status out of =
it
> and into cyttsp_open() you'll be able to do early returns and avoid
> Fortran-style control flow of gotos.
>
> Thanks.
>
> --
> Dmitry

Ok, I'll change those functions as you suggest besides removing the
use_sleep to unconditionally put in low mode the device and resend a
new version.

Thanks and best regards,
Javier
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
