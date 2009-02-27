From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] mfd: twl4030: add twl4030-pwrbutton as our child
Date: Fri, 27 Feb 2009 13:58:46 -0800
Message-ID: <200902271358.46863.david-b@pacbell.net>
References: <1235762883-20870-1-git-send-email-me@felipebalbi.com> <1235762883-20870-2-git-send-email-me@felipebalbi.com> <20090227123649.d2d6408c.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759411AbZB0V7D@vger.kernel.org>
In-Reply-To: <20090227123649.d2d6408c.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Felipe Balbi <me@felipebalbi.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, felipe.balbi@nokia.com, sameo@openedhand.com
List-Id: linux-input@vger.kernel.org

On Friday 27 February 2009, Andrew Morton wrote:
> > --- a/drivers/mfd/twl4030-core.c
> > +++ b/drivers/mfd/twl4030-core.c
> > @@ -101,6 +101,12 @@
> > =A0#define twl_has_usb()=A0=A0=A0=A0=A0=A0=A0=A0false
> > =A0#endif
> > =A0
> > +#if defined(CONFIG_INPUT_TWL4030_PWRBUTTON) \
> > +=A0=A0=A0=A0=A0|| defined(CONFIG_INPUT_TWL4030_PWBUTTON_MODULE)
>=20
> OK, this is "wrong". =A0The core shouldn't need to know about specifi=
c
> clients.

This is a pretty standard idiom:  only create the device
nodes a system actually uses.  Applied comprehensively,
the kernel footprint shrinks ... supporting a device can
require a lot of ancillary infrastructure, which may not
need to be compiled in.


> > +#define twl_has_pwrbutton()=A0=A0true
> > +#else
> > +#define twl_has_pwrbutton()=A0=A0false
> > +#endif
> > =A0
> > =A0/* Triton Core internal information (BEGIN) */
> > =A0
> > @@ -526,6 +532,13 @@ add_children(struct twl4030_platform_data *pda=
ta, unsigned long features)
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0usb_transceiver =3D child=
;
> > =A0=A0=A0=A0=A0=A0}
> > =A0
> > +=A0=A0=A0=A0=A0if (twl_has_pwrbutton()) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0child =3D add_child(1, "twl=
4030_pwrbutton",
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0NULL, 0, true, pdata->irq_base + 8 + 0, 0);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (IS_ERR(child))
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ret=
urn PTR_ERR(child);
> > +=A0=A0=A0=A0=A0}
> > +
> > =A0=A0=A0=A0=A0=A0if (twl_has_regulator()) {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/*
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0child =3D add_regulator(T=
WL4030_REG_VPLL1, pdata->vpll1);
>=20
> The client module should register itself with the core, rather than t=
he core
> registering the client.
>=20
> What has gone wrong here?

Not much I can see.  It's registering a platform_device,
but only if it could be used on this system.  Quite a lot
of OMAP3 boards don't hook up this power button.

Maybe it should also verify that *this* board supports
a power button.  A boolean flag in the twl4030 platform
data would suffice, for multi-board kernels.

- Dave
=20
