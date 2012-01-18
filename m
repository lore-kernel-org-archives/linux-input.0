From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v9 1/3] Input: cyttsp - Cypress TTSP capacitive
 multi-touch screen support
Date: Wed, 18 Jan 2012 09:47:23 -0800
Message-ID: <20120118174722.GA9022@core.coreip.homeip.net>
References: <1326508373-23444-1-git-send-email-javier@dowhile0.org>
 <20120118091253.GC32285@core.coreip.homeip.net>
 <CAAwP0s2=WtBS53o7nYTF512nCHJrtZZJQ88nLUsmDrRVuZ6-Qw@mail.gmail.com>
 <CAAwP0s1VGAe0q5cZ=DVRABP46RpfuJ=+Z-EQaNVZe0xnhDXqLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:54472 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932200Ab2ARRre (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Jan 2012 12:47:34 -0500
Received: by ggnb1 with SMTP id b1so362330ggn.19
        for <linux-input@vger.kernel.org>; Wed, 18 Jan 2012 09:47:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAAwP0s1VGAe0q5cZ=DVRABP46RpfuJ=+Z-EQaNVZe0xnhDXqLw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Javier Martinez Canillas <javier@dowhile0.org>, Henrik Rydberg <rydberg@euromail.se>, Mohan Pallaka <mpallaka@codeaurora.org>, Kevin McNeely <kev@cypress.com>, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, linux-input@vger.kernel.org

On Wed, Jan 18, 2012 at 11:35:28AM +0100, Javier Martinez Canillas wrot=
e:
> On Wed, Jan 18, 2012 at 10:20 AM, Javier Martinez Canillas
> <martinez.javier@gmail.com> wrote:
> > On Wed, Jan 18, 2012 at 10:12 AM, Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> >> Hi Javier,
> >>
> >> On Sat, Jan 14, 2012 at 03:32:51AM +0100, Javier Martinez Canillas=
 wrote:
> >>> +
> >>> +static int __cyttsp_disable(struct cyttsp *ts)
> >>> +{
> >>> + =A0 =A0 u8 sleep_mode =3D 0;
> >>> + =A0 =A0 int retval =3D 0;
> >>> +
> >>> + =A0 =A0 if (ts->pdata->use_sleep && ts->power_state =3D=3D CY_A=
CTIVE_STATE) {
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 sleep_mode =3D ts->pdata->use_sleep;
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 retval =3D ttsp_write_block_data(ts, CY=
_REG_BASE,
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0sizeof(sleep_mode), &sleep_mode);
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 if (retval >=3D 0) {
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ts->power_state =3D CY_=
SLEEP_STATE;
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 disable_irq(ts->irq);
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 }
> >>
> >> I thought we agreed that we should put the device to sleep
> >> unconditionally and not have use_sleep option?
> >
> > Yes, we did. Sorry, I've missed that. I'll change it and resend.
> >
> >>
> >> Thanks.
> >>
> >> --
> >> Dmitry
> >> --
>=20
> Thanks Dmitry for the review.
>=20
> Any more issues you have found? So I can fix all of them for the next
> version of the patch.

I am still not quite happy with the flow of power_on function. Maybe yo=
u
should fold cyttsp_bl_app_valid() into it to avoid dealing with negativ=
e,
0 and 1 return codes. If you also pull printing of the status out of it
and into cyttsp_open() you'll be able to do early returns and avoid
=46ortran-style control flow of gotos.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
