From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] Add generic GPIO-tilt driver
Date: Tue, 29 Nov 2011 10:27:48 -0800
Message-ID: <20111129182748.GG4241@core.coreip.homeip.net>
References: <201111291324.34045.heiko@sntech.de>
 <CAM=Q2cv3rFmxGLUrcEBWdr+kMyoX2mP3Qcr9G41Z0i57uPN=pw@mail.gmail.com>
 <201111291612.41069.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:42226 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755338Ab1K2S1x (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Nov 2011 13:27:53 -0500
Received: by ggnr5 with SMTP id r5so6718493ggn.19
        for <linux-input@vger.kernel.org>; Tue, 29 Nov 2011 10:27:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201111291612.41069.heiko@sntech.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, linux-input@vger.kernel.org

On Tue, Nov 29, 2011 at 04:12:40PM +0100, Heiko St=FCbner wrote:
> Hi Shubhrajyoti,
>=20
> Am Dienstag, 29. November 2011, 15:59:29 schrieb Shubhrajyoti Datta:
> > Hi Heiko,
> >=20
> > On Tue, Nov 29, 2011 at 5:54 PM, Heiko St=FCbner <heiko@sntech.de> =
wrote:
> > > +static void gpio_tilt_polled_poll(struct input_polled_dev *dev)
> > > +{
> > > +       struct gpio_tilt_polled_dev *tdev =3D dev->private;
> > > +       struct gpio_tilt_platform_data *pdata =3D tdev->pdata;
> > > +       struct input_dev *input =3D dev->input;
> > > +       struct gpio_tilt_state *tilt_state =3D NULL;
> > > +       int state, i;
> > > +
> > > +       if (tdev->count < tdev->threshold) {
> >=20
> > Nitpick : the braces are not necessary.
> hmm ... for me it's easier to read if the style of the braces does no=
t change
> between if and else, i.e. both with or without braces.
> And the kernel CodingStyle-file seems also to be in my favor ;-)
> [starting from line 169].

Yep, when one branch requires braces it is preferred to have then on
all branches.

> > > +static int __devinit gpio_tilt_polled_probe(struct platform_devi=
ce
> > > *pdev) +{
> > > +       struct gpio_tilt_platform_data *pdata =3D pdev->dev.platf=
orm_data;
> > > +       struct device *dev =3D &pdev->dev;
> > > +       struct gpio_tilt_polled_dev *tdev;
> > > +       struct input_polled_dev *poll_dev;
> > > +       struct input_dev *input;
> > > +       int error, i;
> > > +
> > > +       if (!pdata || !pdata->poll_interval)
> > > +               return -EINVAL;
> >=20
> > Could we have a default poll interval if passed 0 ?
> > Feel free to ignore if you feel otherwise.
> For me either way is fine but I'm not sure what would be a generic
> enough default value for most cases (500, 1000 ? ).
>=20

I'd rather error out then give default which we can't sanely select.
Then platform integrator will be alerted early and select appropriate
value.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
