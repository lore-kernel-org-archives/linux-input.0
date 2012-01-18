From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH v9 1/3] Input: cyttsp - Cypress TTSP capacitive
 multi-touch screen support
Date: Wed, 18 Jan 2012 10:20:38 +0100
Message-ID: <CAAwP0s2=WtBS53o7nYTF512nCHJrtZZJQ88nLUsmDrRVuZ6-Qw@mail.gmail.com>
References: <1326508373-23444-1-git-send-email-javier@dowhile0.org> <20120118091253.GC32285@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:62420 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757207Ab2ARJU7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Jan 2012 04:20:59 -0500
Received: by ghbg16 with SMTP id g16so2815850ghb.19
        for <linux-input@vger.kernel.org>; Wed, 18 Jan 2012 01:20:59 -0800 (PST)
In-Reply-To: <20120118091253.GC32285@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Javier Martinez Canillas <javier@dowhile0.org>, Henrik Rydberg <rydberg@euromail.se>, Mohan Pallaka <mpallaka@codeaurora.org>, Kevin McNeely <kev@cypress.com>, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, linux-input@vger.kernel.org

On Wed, Jan 18, 2012 at 10:12 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Javier,
>
> On Sat, Jan 14, 2012 at 03:32:51AM +0100, Javier Martinez Canillas wr=
ote:
>> +
>> +static int __cyttsp_disable(struct cyttsp *ts)
>> +{
>> + =C2=A0 =C2=A0 u8 sleep_mode =3D 0;
>> + =C2=A0 =C2=A0 int retval =3D 0;
>> +
>> + =C2=A0 =C2=A0 if (ts->pdata->use_sleep && ts->power_state =3D=3D C=
Y_ACTIVE_STATE) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sleep_mode =3D ts->pdata=
->use_sleep;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retval =3D ttsp_write_bl=
ock_data(ts, CY_REG_BASE,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0sizeof(sleep_mode), &sleep_mode);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (retval >=3D 0) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ts->power_state =3D CY_SLEEP_STATE;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 disable_irq(ts->irq);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>
> I thought we agreed that we should put the device to sleep
> unconditionally and not have use_sleep option?

Yes, we did. Sorry for that, I've missed that. I'll change it and resen=
d.

>
> Thanks.
>
> --
> Dmitry
> --

Thanks Dmitry for your patience.

Best regards,

--=20
Javier Mart=C3=ADnez Canillas
(+34) 682 39 81 69
Barcelona, Spain
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
