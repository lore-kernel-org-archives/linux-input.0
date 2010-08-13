From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input/touch: Introduce the LPC32xx touchscreen
 controller driver
Date: Fri, 13 Aug 2010 12:24:53 -0700
Message-ID: <20100813192453.GA8387@core.coreip.homeip.net>
References: <1281568142-12892-1-git-send-email-wellsk40@gmail.com>
 <1281568142-12892-2-git-send-email-wellsk40@gmail.com>
 <20100813083311.GA7824@core.coreip.homeip.net>
 <AANLkTik0voaTUHoJuaVGvmhqpUh_tfbk3VUNXyWMh1av@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:33018 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755485Ab0HMTY7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 13 Aug 2010 15:24:59 -0400
Received: by pvg2 with SMTP id 2so917780pvg.19
        for <linux-input@vger.kernel.org>; Fri, 13 Aug 2010 12:24:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTik0voaTUHoJuaVGvmhqpUh_tfbk3VUNXyWMh1av@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kevin Wells <wellsk40@gmail.com>
Cc: linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Durgesh Pattamatta <durgesh.pattamatta@nxp.com>

On Fri, Aug 13, 2010 at 12:00:33PM -0700, Kevin Wells wrote:
> >>
> >> This patch set introduces support for the LPC32xx touchscreen
> >> controller driver. The LPC32xx touchscreen controller supports
> >> automated event detection and X/Y data conversion for resistive
> >> touchscreens.
> >>
> >
> > Overall looks very nice, a few comments below.
> >
>=20
> Thanks for helping review this driver. I'll update and repost once
> the fixes and changes are finalized.
>=20
> >> +
> >> + =A0 =A0 if (input_register_device(tsc->dev)) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed registering =
input device\n");
> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_stop_clk;
> >
> > retval is garbage here, you need to do:
> >
> > =A0 =A0 =A0 =A0error =3D input_register_device();
> > =A0 =A0 =A0 =A0if (error) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0...
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_stop_clk;
> > =A0 =A0 =A0 =A0}
> >
> > I must say that I do not like mixing devm_* with the standard error=
 path
> > unwinding, if we can rely on devm_xxx() calls to take care of every=
thing
> > we should revert to standard error unsinding practice for everythng=
=2E
> >
>=20
> Would it be preferable to just use standard resource functions and er=
ror
> path unwinding (with fixes in _remove too) similar to the other drive=
rs in
> ./drivers/input?

Yes, that what I was trying to say. If only I didn't make so many
typos...

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
