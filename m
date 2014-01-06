From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/4] input: Add new sun4i-lradc-keys drivers
Date: Mon, 6 Jan 2014 11:13:51 +0100
Message-ID: <20140106101351.GO3144@lukather>
References: <1388604610-20380-1-git-send-email-hdegoede@redhat.com>
 <20140101205603.GA1141@core.coreip.homeip.net>
 <52C5336B.9010903@redhat.com>
 <1700375.GaI3zFl6RI@phil>
 <52C56D79.1060506@redhat.com>
 <20140102202022.GK3144@lukather>
 <52C5E9F1.9010700@redhat.com>
 <20140103173605.GN3144@lukather>
 <20140103182349.GA13489@core.coreip.homeip.net>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E4UgsyMmvHjpIg3x"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBJUEVKLAKGQEY5CGGHY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140103182349.GA13489-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Heiko =?iso-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
List-Id: linux-input@vger.kernel.org


--E4UgsyMmvHjpIg3x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 03, 2014 at 10:23:50AM -0800, Dmitry Torokhov wrote:
> On Fri, Jan 03, 2014 at 06:36:05PM +0100, Maxime Ripard wrote:
> > On Thu, Jan 02, 2014 at 11:36:33PM +0100, Hans de Goede wrote:
> > > Hi,
> > >=20
> > > On 01/02/2014 09:20 PM, Maxime Ripard wrote:
> > > >On Thu, Jan 02, 2014 at 02:45:29PM +0100, Hans de Goede wrote:
> > > >>>Also, instead of inventing yet another vendor-specific property, w=
hy not re-use
> > > >>>a button binding similar to gpio-keys like:
> > > >>>
> > > >>>        lradc: lradc@01c22800 {
> > > >>>                compatible =3D "allwinner,sun4i-lradc-keys";
> > > >>>                reg =3D <0x01c22800 0x100>;
> > > >>>                interrupts =3D <31>;
> > > >>>                allwinner,chan0-step =3D <200>;
> > > >>>
> > > >>>		#address-cells =3D <1>;
> > > >>>		#size-cells =3D <0>;
> > > >>>
> > > >>>		button@0 {
> > > >>>			reg =3D <0>; /* your channel index from above */
> > > >>>			linux,code =3D <115>; /* already used as dt-property */
> > > >>>		};
> > > >>>
> > > >>>		button@1 {
> > > >>>			reg =3D <1>;
> > > >>>			linux,code =3D <114>;
> > > >>>		};
> > > >>
> > > >>Ugh no. Having a vendor specific property which is KISS certainly
> > > >>beats this, both wrt ease of writing dts files as well as wrt the
> > > >>dts parsing code in the driver.
> > > >
> > > >I'd agree with Heiko here. This is pretty much the same construct
> > > >that's already in use in other input drivers, like gpio-keys.
> > >=20
> > > In the gpio case there is a 1 on 1 relation between a single hw
> > > entity (the gpio-pin) and a single keycode. Here there is 1 hw entity
> > > which maps to an array of key-codes, certainly using an array rather
> > > then a much more complicated construct is the correct data-structure
> > > to represent this.
> >=20
> > You can build an array in your driver out of this very easily, it's 10
> > lines in your probe. And you gain from this something that is more
> > generic, can be shared by other similar drivers and is consistent with
> > what is already in use.
>=20
> How will it be shared? Surely not code-wise, but basically in spirit
> only. It seems to me that the originally proposed binding is simple and
> concise and works well for the driver.

See Heiko's answer, but I do believe the code can be shared as well if
needs be.

> > > >This is also something that can really easily be made generic,
> > > >since this is something that is rather common.
> > > >
> > > >Speaking of which. I believe this should actually come in two
> > > >different drivers:
> > > >   - The ADC driver itself, using IIO
> > > >   - A generic button handler driver on top of IIO.
> > > >
> > > > The fact that on most board this adc is used for buttons doesn't ma=
ke
> > > > any difference, it's actually a hardware designer choice, we should
> > > > support that choice, but we should also be able to use it just as an
> > > > ADC.
> > >=20
> > > No, this is not a generic adc, as mentioned in the commit msg, this
> > > adc is specifically designed to be used this way.
> > >=20
> > > The adc won't start sampling data, and won't generate any interrupts
> > > until a button is pressed. That is until the input voltage drops below
> > > 2/3 of Vref, this is checked through a built-in analog comparator, wh=
ich
> > > hooks into the control logic.
> > >=20
> > > It has button down and button up interrupts, and can detect long
> > > presses (unused) and generate a second type of down interrupt for tho=
se.
> > >=20
> > > This really is an input device, which happens to use an adc.
> >=20
> > Hmm, yes, ok.
> >=20
> > > >Carlo Caione already started to work on an IIO driver for the LRADC:
> > > >https://github.com/carlocaione/linux/tree/sunxi-lradc
> > > >maybe you can take over his work.
> > >=20
> > > That won't work because the adc won't sample if the input gets above
> > > 2/3 of Vref. There may be some other mode which does not do that, but
> > > that is not clearly documented.
> > >=20
> > > Even if an IIO driver turns out to be doable, I strongly believe that
> > > having a separate input driver for this is best, since this device
> > > was designed to be used as such. Building input on top of IIO would
> > > mean polling the adc, while with my driver it actually generates
> > > button down / up interrupts without any polling being involved.
> >=20
> > Not really. iio_channel_read calls the read_raw function (in that
> > case) of your driver. If the read_raw function in your driver wants to
> > poll the device, fine, but most of the time, it will just block
> > waiting for an interrupt to come and return the data to the caller,
> > which is obviously the saner behaviour, and you don't actually end up
> > polling the device. Which is pretty much the architecture you're using
> > already, just with an intermediate layer in between.
>=20
> What is the benefit of the IIO layer if device can't really be used as
> IIO? I am all for moving as many generic devices as we can to IIO but we
> should recognize that sometimes the device is not an IIO device.

Yes, I've agreed to that. I was just clarifying Hans' statement.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--E4UgsyMmvHjpIg3x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSyoHfAAoJEBx+YmzsjxAgs3sP/3XnK6yoLeKdiAM7ZznUB/sR
NNv/ZlvTzSZgpWP4OLdgcZW0UAHwEn48kehd/ALqnfsCftT4TSpxwqr26sdYPCko
tTz3+Sgg//vM7xhlols/XgotcgpzXEdAygXYKXR67zbb+t8nIOcbQY8ym/A1qvrP
8ZF+5MUXlHtzna9KXxntZKZMA9c89QUA5ca9nx80z1NHUO0GTgezRVlqSIvhHKaj
d2HJmvEnPhhXa8Lo2QRngH+Jpjqipar5CBeGU2j1Fln8L8mKgHH3IbPufdYyfGsr
1WGU/GHKHUbK5LxXpfqnyRXEfBMu/8fr3Zj8aQNJjq8a8QXdwYKpo80lw5GgTwXU
6yjVUN8EXTEjof72lP2AV9/V5rcOOI1T3DLDthXhOTumGJPaAHdpyZu6YK3AI5Pz
aE1JBxoeqmQEJcUA3nH3mONnwoAlLiE+dwC9sUvV2BMwC7O31FhpRd6LPyT7K6u9
z7MQzzxeQ47eepkCUmy/76ldGDNwgtekGp0heVuo3l1EDIhjzZuEwNyWZYmQpL++
WnT225XhPLjK5wZ/Z5ZXpBAVO8uWZkyKtNLdE8IwKpwULXUcSgu08+mC2m9/2smP
JwUrJadeSxrl4y7BbABIlvGu4RCgT94SrGo5HJP1acw10xeGhZIaA62KGTHeL2Yy
Un8hPFdiwRz9LOz13X3k
=cQzq
-----END PGP SIGNATURE-----

--E4UgsyMmvHjpIg3x--
