From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH TRIVIAL 1/5] Input: keyboard: use macro
 module_platform_driver()
Date: Tue, 10 Jan 2012 14:22:31 -0800
Message-ID: <20120110222231.GA16702@core.coreip.homeip.net>
References: <1321952446-7591-1-git-send-email-jj_ding@emc.com.tw>
 <1321952446-7591-2-git-send-email-jj_ding@emc.com.tw>
 <CAMuHMdWVedppkaO5sF4WH78e8rdVJKXJknFVEZQo+VD2Rxmk=A@mail.gmail.com>
 <CAMuHMdU1fv-Qx1dRstFjBkqcKswWCu34Hkeusk1vW3ReXB7CDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:51232 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755920Ab2AJWWl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Jan 2012 17:22:41 -0500
Content-Disposition: inline
In-Reply-To: <CAMuHMdU1fv-Qx1dRstFjBkqcKswWCu34Hkeusk1vW3ReXB7CDA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: JJ Ding <jj_ding@emc.com.tw>, Greg Kroah-Hartman <gregkh@suse.de>, Grant Likely <grant.likely@secretlab.ca>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, JJ Ding <dgdunix@gmail.com>

On Tue, Jan 10, 2012 at 09:57:08PM +0100, Geert Uytterhoeven wrote:
> On Tue, Jan 10, 2012 at 21:47, Geert Uytterhoeven <geert@linux-m68k.o=
rg> wrote:
> > On Tue, Nov 22, 2011 at 10:00, JJ Ding <jj_ding@emc.com.tw> wrote:
> >> From: JJ Ding <dgdunix@gmail.com>
> >>
> >> Commit 940ab88962bc1aff3273a8356d64577a6e386736 introduced a new m=
acro to
> >> save some platform_driver boilerplate code. Use it.
> >
> >> diff --git a/drivers/input/keyboard/amikbd.c b/drivers/input/keybo=
ard/amikbd.c
> >> index 79172af..6df5f6a 100644
> >> --- a/drivers/input/keyboard/amikbd.c
> >> +++ b/drivers/input/keyboard/amikbd.c
> >> @@ -259,19 +259,6 @@ static struct platform_driver amikbd_driver =3D=
 {
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.owner =A0=3D THIS_MODULE,
> >> =A0 =A0 =A0 =A0},
> >> =A0};
> >> -
> >> -static int __init amikbd_init(void)
> >> -{
> >> - =A0 =A0 =A0 return platform_driver_probe(&amikbd_driver, amikbd_=
probe);
> >> -}
> >> -
> >> -module_init(amikbd_init);
> >> -
> >> -static void __exit amikbd_exit(void)
> >> -{
> >> - =A0 =A0 =A0 platform_driver_unregister(&amikbd_driver);
> >> -}
> >> -
> >> -module_exit(amikbd_exit);
> >> +module_platform_driver(amikbd_driver);
> >>
> >> =A0MODULE_ALIAS("platform:amiga-keyboard");
> >
> > Sorry for not noticing before, but this is not correct.
> > Drivers using platform_driver_probe() typically don't fill in the
> > platform_driver.probe
> > method, as it's passed explicitly to platform_driver_probe() instea=
d.
> > Hence amikbd_probe() is now referenced nowhere, and thus never call=
ed
> > (doesn't the compiler warn about amikbd_probe() being defined but u=
nused?).
> >
> >> diff --git a/drivers/input/keyboard/davinci_keyscan.c b/drivers/in=
put/keyboard/davinci_keyscan.c
> >> index 9d82b3a..4698252 100644
> >> --- a/drivers/input/keyboard/davinci_keyscan.c
> >> +++ b/drivers/input/keyboard/davinci_keyscan.c
> >> @@ -328,18 +328,7 @@ static struct platform_driver davinci_ks_driv=
er =3D {
> >> =A0 =A0 =A0 =A0},
> >> =A0 =A0 =A0 =A0.remove =3D __devexit_p(davinci_ks_remove),
> >> =A0};
> >> -
> >> -static int __init davinci_ks_init(void)
> >> -{
> >> - =A0 =A0 =A0 return platform_driver_probe(&davinci_ks_driver, dav=
inci_ks_probe);
> >> -}
> >> -module_init(davinci_ks_init);
> >> -
> >> -static void __exit davinci_ks_exit(void)
> >> -{
> >> - =A0 =A0 =A0 platform_driver_unregister(&davinci_ks_driver);
> >> -}
> >> -module_exit(davinci_ks_exit);
> >> +module_platform_driver(davinci_ks_driver);
> >>
> >> =A0MODULE_AUTHOR("Miguel Aguilar");
> >> =A0MODULE_DESCRIPTION("Texas Instruments DaVinci Key Scan Driver")=
;
> >
> > Same here, I think.
>=20
> And looking for platform_driver_probe() in recent changesets, I found
> a few more:
>=20
> drivers/input/touchscreen/atmel-wm97xx.c atmel_wm97xx_probe
> drivers/input/touchscreen/mc13783_ts.c mc13783_ts_probe
> drivers/input/serio/at32psif.c psif_probe
> drivers/input/mouse/amimouse.c amimouse_probe
>=20
> Interestingly, in drivers/input/misc/twl4030-pwrbutton.c you did make
> platform_driver.probe point to twl4030_pwrbutton_probe().
> But that one is also broken, as twl4030_pwrbutton_probe() is marked _=
_init,
> which is no longer correct.
>=20
> Still, setting up platform_driver.probe and removing __init from all =
probe
> functions is not the right thing to do, as this make (non-__init) ker=
nel code
> size bigger, while none of these devices are hotpluggable and thus ca=
nnot
> appear after bootup. That's why we have platform_driver_probe() in th=
e
> first place. So I think all of this should be reverted for non-hotplu=
ggable
> drivers.

Crap, I didn't notice we messed up platform_driver_probe() users; I'll
revert changes to these drivers.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
