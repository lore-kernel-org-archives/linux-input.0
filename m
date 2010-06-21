From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v5 1/3] ARM: SAMSUNG: Add keypad device support
Date: Mon, 21 Jun 2010 12:16:12 +0100
Message-ID: <20100621111612.GJ7702@n2100.arm.linux.org.uk>
References: <1277101605-2435-1-git-send-email-jy0922.shim@samsung.com> <AANLkTil1aiJ1gu6jRrO4LeB0fYltOq4A3wXJJB1ZOa8q@mail.gmail.com> <20100621091952.GB7702@n2100.arm.linux.org.uk> <AANLkTilU1X1LR33Eed9BVGE2n-dqRuIuUFfbDd3gzEVc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTilU1X1LR33Eed9BVGE2n-dqRuIuUFfbDd3gzEVc@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>, linux-samsung-soc@vger.kernel.org, dmitry.torokhov@gmail.com, kyungmin.park@samsung.com, kgene.kim@samsung.com, ben-linux@fluff.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

On Mon, Jun 21, 2010 at 06:39:10PM +0800, Eric Miao wrote:
> On Mon, Jun 21, 2010 at 5:19 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Mon, Jun 21, 2010 at 05:05:34PM +0800, Eric Miao wrote:
> >> On Mon, Jun 21, 2010 at 2:26 PM, Joonyoung Shim <jy0922.shim@samsu=
ng.com> wrote:
> >> > +void __init samsung_keypad_set_platdata(struct samsung_keypad_p=
latdata *pd)
> >> > +{
> >> > + =A0 =A0 =A0 struct samsung_keypad_platdata *npd;
> >> > +
> >> > + =A0 =A0 =A0 if (!pd) {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "%s: no platform d=
ata\n", __func__);
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> >> > + =A0 =A0 =A0 }
> >> > +
> >> > + =A0 =A0 =A0 npd =3D kmemdup(pd, sizeof(struct samsung_keypad_p=
latdata), GFP_KERNEL);
> >> > + =A0 =A0 =A0 if (!npd)
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "%s: no memory for=
 platform data\n", __func__);
> >>
> >> This part of the code is actually duplicated again and again and a=
gain
> >> for each device, PXA and other legacy platforms are bad references=
 for
> >> this. In arch/arm/mach-mmp/, it might be a bit cleaner, there are =
three
> >> major points:
> >>
> >> =A01. A minimum 'struct pxa_device_desc' for a simple description =
of a
> >> =A0 =A0 device (more than 90% of the devices can be described that=
 way),
> >> =A0 =A0 and avoid using a comparatively heavier weight platform_de=
vice,
> >> =A0 =A0 which can be generated at run-time
> >>
> >> =A02. pxa_register_device() to allocate and register the platform_=
device
> >> =A0 =A0 at run-time, along with the platform data
> >
> > It's a bad idea to make platform data be run-time discardable like =
this:
> >
> >> > +struct samsung_keypad_platdata {
> >> > + =A0 =A0 =A0 const struct matrix_keymap_data *keymap_data;
> >
> > What you end up with is some platform data structures which must be=
 kept
> > (those which have pointers to them from the platform data), and oth=
ers
> > (the platform data itself) which can be discarded at runtime.
> >
> > We know that the __initdata attributations cause lots of problems -
> > they're frequently wrong. =A0Just see the constant hastle with __de=
vinit
> > et.al. =A0The same issue happens with __initdata as well.
> >
> > So why make things more complicated by allowing some platform data
> > structures to be discardable and others not to be? =A0Is their smal=
l
> > size (maybe 6 words for this one) really worth the hastle of gettin=
g
> > __initdata attributations wrong (eg, on the keymap data?)
> >
>=20
> Russell,
>=20
> The benefit I see is when multiple boards are compiled in, those
> data not used can be automatically discarded.

Yes, but only some of the data can be discarded.  Continuing with the
example in hand, while you can discard the six words which represent
samsung_keypad_platdata, but the keymap_data can't be because that won'=
t
be re-allocated, which is probably a much larger data structure.

So, samsung_keypad_platdata can be marked with __initdata, but the keym=
ap
data must not be - and this is where the confusion about what can be
marked with __initdata starts - and eventually leads to the keymap data
also being mistakenly marked __initdata.

Is saving six words (or so) worth the effort to track down stuff
inappropriately marked with __initdata ?  I'm sure there's bigger savin=
gs
to be had in other parts of the kernel (such as shrinking the size of
tcp hash tables, reducing the kernel message ring buffer, etc) if size =
is
really a concern.
