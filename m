From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 2/2] mfd: twl4030: add twl4030-pwrbutton as our child
Date: Sat, 28 Feb 2009 00:09:23 +0200
Message-ID: <20090227220923.GN16801@frodo>
References: <1235762883-20870-1-git-send-email-me@felipebalbi.com> <1235762883-20870-2-git-send-email-me@felipebalbi.com> <20090227123649.d2d6408c.akpm@linux-foundation.org> <200902271358.46863.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:33629 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758216AbZB0WJe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Feb 2009 17:09:34 -0500
Content-Disposition: inline
In-Reply-To: <200902271358.46863.david-b@pacbell.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, Felipe Balbi <me@felipebalbi.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, felipe.balbi@nokia.com, sameo@openedhand.com

On Fri, Feb 27, 2009 at 01:58:46PM -0800, David Brownell wrote:
> On Friday 27 February 2009, Andrew Morton wrote:
> > > --- a/drivers/mfd/twl4030-core.c
> > > +++ b/drivers/mfd/twl4030-core.c
> > > @@ -101,6 +101,12 @@
> > > =A0#define twl_has_usb()=A0=A0=A0=A0=A0=A0=A0=A0false
> > > =A0#endif
> > > =A0
> > > +#if defined(CONFIG_INPUT_TWL4030_PWRBUTTON) \
> > > +=A0=A0=A0=A0=A0|| defined(CONFIG_INPUT_TWL4030_PWBUTTON_MODULE)
> >=20
> > OK, this is "wrong". =A0The core shouldn't need to know about speci=
fic
> > clients.
>=20
> This is a pretty standard idiom:  only create the device
> nodes a system actually uses.  Applied comprehensively,
> the kernel footprint shrinks ... supporting a device can
> require a lot of ancillary infrastructure, which may not
> need to be compiled in.
>=20
>=20
> > > +#define twl_has_pwrbutton()=A0=A0true
> > > +#else
> > > +#define twl_has_pwrbutton()=A0=A0false
> > > +#endif
> > > =A0
> > > =A0/* Triton Core internal information (BEGIN) */
> > > =A0
> > > @@ -526,6 +532,13 @@ add_children(struct twl4030_platform_data *p=
data, unsigned long features)
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0usb_transceiver =3D chi=
ld;
> > > =A0=A0=A0=A0=A0=A0}
> > > =A0
> > > +=A0=A0=A0=A0=A0if (twl_has_pwrbutton()) {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0child =3D add_child(1, "t=
wl4030_pwrbutton",
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0NULL, 0, true, pdata->irq_base + 8 + 0, 0);
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (IS_ERR(child))
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0r=
eturn PTR_ERR(child);
> > > +=A0=A0=A0=A0=A0}
> > > +
> > > =A0=A0=A0=A0=A0=A0if (twl_has_regulator()) {
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/*
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0child =3D add_regulator=
(TWL4030_REG_VPLL1, pdata->vpll1);
> >=20
> > The client module should register itself with the core, rather than=
 the core
> > registering the client.
> >=20
> > What has gone wrong here?
>=20
> Not much I can see.  It's registering a platform_device,
> but only if it could be used on this system.  Quite a lot
> of OMAP3 boards don't hook up this power button.
>=20
> Maybe it should also verify that *this* board supports
> a power button.  A boolean flag in the twl4030 platform
> data would suffice, for multi-board kernels.

something like the following should be enough then:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D cut here =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff --git a/drivers/mfd/twl4030-core.c b/drivers/mfd/twl4030-core.c
index c86bc3b..714073f 100644
--- a/drivers/mfd/twl4030-core.c
+++ b/drivers/mfd/twl4030-core.c
@@ -532,7 +532,7 @@ add_children(struct twl4030_platform_data *pdata, u=
nsigned long features)
                usb_transceiver =3D child;
        }
=20
-       if (twl_has_pwrbutton()) {
+       if (twl_has_pwrbutton() && pdata->pwrbutton) {
                child =3D add_child(1, "twl4030_pwrbutton",
                                NULL, 0, true, pdata->irq_base + 8 + 0,=
 0);
                if (IS_ERR(child))
diff --git a/include/linux/i2c/twl4030.h b/include/linux/i2c/twl4030.h
index 8137f66..277451e 100644
--- a/include/linux/i2c/twl4030.h
+++ b/include/linux/i2c/twl4030.h
@@ -293,6 +293,8 @@ struct twl4030_platform_data {
        struct regulator_init_data              *vaux3;
        struct regulator_init_data              *vaux4;
=20
+       bool                                    pwrbutton;
+
        /* REVISIT more to come ... _nothing_ should be hard-wired */
 };
=20

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
