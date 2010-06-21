From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v5 1/3] ARM: SAMSUNG: Add keypad device support
Date: Mon, 21 Jun 2010 10:19:52 +0100
Message-ID: <20100621091952.GB7702@n2100.arm.linux.org.uk>
References: <1277101605-2435-1-git-send-email-jy0922.shim@samsung.com> <AANLkTil1aiJ1gu6jRrO4LeB0fYltOq4A3wXJJB1ZOa8q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTil1aiJ1gu6jRrO4LeB0fYltOq4A3wXJJB1ZOa8q@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>, linux-samsung-soc@vger.kernel.org, dmitry.torokhov@gmail.com, kyungmin.park@samsung.com, kgene.kim@samsung.com, ben-linux@fluff.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

On Mon, Jun 21, 2010 at 05:05:34PM +0800, Eric Miao wrote:
> On Mon, Jun 21, 2010 at 2:26 PM, Joonyoung Shim <jy0922.shim@samsung.=
com> wrote:
> > +void __init samsung_keypad_set_platdata(struct samsung_keypad_plat=
data *pd)
> > +{
> > + =A0 =A0 =A0 struct samsung_keypad_platdata *npd;
> > +
> > + =A0 =A0 =A0 if (!pd) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "%s: no platform data=
\n", __func__);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 npd =3D kmemdup(pd, sizeof(struct samsung_keypad_plat=
data), GFP_KERNEL);
> > + =A0 =A0 =A0 if (!npd)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "%s: no memory for pl=
atform data\n", __func__);
>=20
> This part of the code is actually duplicated again and again and agai=
n
> for each device, PXA and other legacy platforms are bad references fo=
r
> this. In arch/arm/mach-mmp/, it might be a bit cleaner, there are thr=
ee
> major points:
>=20
>  1. A minimum 'struct pxa_device_desc' for a simple description of a
>     device (more than 90% of the devices can be described that way),
>     and avoid using a comparatively heavier weight platform_device,
>     which can be generated at run-time
>=20
>  2. pxa_register_device() to allocate and register the platform_devic=
e
>     at run-time, along with the platform data

It's a bad idea to make platform data be run-time discardable like this=
:

> > +struct samsung_keypad_platdata {
> > + =A0 =A0 =A0 const struct matrix_keymap_data *keymap_data;

What you end up with is some platform data structures which must be kep=
t
(those which have pointers to them from the platform data), and others
(the platform data itself) which can be discarded at runtime.

We know that the __initdata attributations cause lots of problems -
they're frequently wrong.  Just see the constant hastle with __devinit
et.al.  The same issue happens with __initdata as well.

So why make things more complicated by allowing some platform data
structures to be discardable and others not to be?  Is their small
size (maybe 6 words for this one) really worth the hastle of getting
__initdata attributations wrong (eg, on the keymap data?)
