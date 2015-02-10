From: Roman Volkov <v1ron-oLhuKTjYqW/YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH 1/5] i8042: intel-8042 DT documentation
Date: Wed, 11 Feb 2015 00:01:25 +0300
Message-ID: <20150211000125.5d66bfb5@v1ron-s7>
References: <1422913730-12663-1-git-send-email-v1ron@v1ros.org>
	<20150203113816.GA30866@leverpostej>
	<20150203193202.GB20256@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150203193202.GB20256@dtor-ws>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Roman Volkov <v1ron-JGs/UdohzUI@public.gmane.org>, Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

=D0=92 Tue, 3 Feb 2015 11:32:02 -0800
Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> =D0=BF=D0=B8=D1=88=D0=B5=D1=
=82:

> On Tue, Feb 03, 2015 at 11:38:16AM +0000, Mark Rutland wrote:
> > On Mon, Feb 02, 2015 at 09:48:46PM +0000, Roman Volkov wrote:
> > > Documentation for 'intel,8042' DT compatible node.
> > >=20
> > > Signed-off-by: Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>
> > > Signed-off-by: Roman Volkov <v1ron-oLhuKTjYqW/YtjvyW6yDsg@public.gmane.org>
> > > ---
> > >  .../devicetree/bindings/input/intel-8042.txt       | 29
> > > ++++++++++++++++++++++ 1 file changed, 29 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/input/intel-8042.txt
> > >=20
> > > diff --git
> > > a/Documentation/devicetree/bindings/input/intel-8042.txt
> > > b/Documentation/devicetree/bindings/input/intel-8042.txt new file
> > > mode 100644 index 0000000..2aea7ec --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/input/intel-8042.txt
> > > @@ -0,0 +1,29 @@
> > > +* Intel 8042 Keyboard Controller
> > > +
> > > +Required properties:
> > > +- compatible: should be "intel,8042"
> > > +- regs: memory for keyboard controller
> > > +- interrupts: two interrupts should be specified (keyboard and
> > > aux)
> >=20
> > Is it possible only one of these is wired up?
>=20
> Yes, and we should support this case. The core of i8042 does.
>=20

Do we need to just read these IRQ numbers and leave them negative if
absent? Will it be acceptable? This would look like:

i8042_kbd_irq =3D platform_get_irq_byname(pdev, "kbd");

Testing shows it prints "Invalid argument" error -22 when an IRQ is
absent and we are not using nokbd/noaux module options.

>=20
> >=20
> > It might be worth using interrupt-names.
> >=20
> > > +- command-reg: offset in memory for command register
> > > +- status-reg: offset in memory for status register
> > > +- data-reg: offset in memory for data register
> > > +
> > > +Optional properties:
> > > +- init-reset: Controller should be reset on init and cleanup
> >=20
> > Why is this necessary? Can't we just always reset it?
>=20
> We do not reset by default on x86 because BIOS takes care of this for
> us and quite often firmware that emulates i8042 gets confused if we
> try to reset it too. Non non-x86 we reset by default. I think we
> should do the same for OF case  (reset) and not use this property.
>=20
> >=20
> > > +
> > > +Optional Linux-specific properties:
> > > +- linux,kbd_phys_desc: defaults to i8042/serio0
> > > +- linux,aux_phys_desc: defaults to i8042/serio1
> > > +- linux,mux_phys_desc: defaults to i8042/serio%d
> >=20
> > As a general note, s/_/-/ in property names please.
> >=20
> > That said, I don't follow why we should have these at all. I don't
> > understand what the description is intended to mean.
> >=20
> > In general we want to avoid Linux-specific properties. If a DTB
> > needs to know about the inernals of an OS it's likely to be fragile
> > and broken over time.
>=20
> Right, the desc were carried over from older days to keep dmesg
> familiar. With OF it is new platforms so just settle on a generic
> description and use it instead of allowing to specify through DT.
>=20
> >=20
> > > +
> > > +
> > > +Example:
> > > +	keyboard@d8008800 {
> > > +		compatible =3D "intel,8042";
> > > +		reg =3D <0xd8008800 0x100>;
> > > +		interrupts =3D <23 4>;
> >=20
> > If this is intended to be two interrupts, please bracket them
> > individually, e.g.
> >=20
> > 	interrupts =3D <23>, <4>;
> >=20
> > > +		command-reg =3D <0x04>;
> > > +		status-reg =3D <0x04>;
> >=20
> > Same address?
> >=20
> > > +		data-reg =3D <0x00>;
> > > +		mux-ports =3D <2>;
> >=20
> > This wasn't documented above.
>=20
> I think active MUX is purely x86 concept, I have never heard of it
> being used anywhere else.
>=20
> Thanks.
>=20

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
