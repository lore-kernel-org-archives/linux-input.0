From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/4] input: Add new sun4i-lradc-keys drivers
Date: Thu, 2 Jan 2014 21:20:22 +0100
Message-ID: <20140102202022.GK3144@lukather>
References: <1388604610-20380-1-git-send-email-hdegoede@redhat.com>
 <20140101205603.GA1141@core.coreip.homeip.net>
 <52C5336B.9010903@redhat.com>
 <1700375.GaI3zFl6RI@phil>
 <52C56D79.1060506@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rOsx1R9haZTS96jr"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBIUWS6LAKGQEI6FNVLY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52C56D79.1060506-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
List-Id: linux-input@vger.kernel.org


--rOsx1R9haZTS96jr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 02, 2014 at 02:45:29PM +0100, Hans de Goede wrote:
> >Also, instead of inventing yet another vendor-specific property, why not=
 re-use
> >a button binding similar to gpio-keys like:
> >
> >        lradc: lradc@01c22800 {
> >                compatible =3D "allwinner,sun4i-lradc-keys";
> >                reg =3D <0x01c22800 0x100>;
> >                interrupts =3D <31>;
> >                allwinner,chan0-step =3D <200>;
> >
> >		#address-cells =3D <1>;
> >		#size-cells =3D <0>;
> >
> >		button@0 {
> >			reg =3D <0>; /* your channel index from above */
> >			linux,code =3D <115>; /* already used as dt-property */
> >		};
> >
> >		button@1 {
> >			reg =3D <1>;
> >			linux,code =3D <114>;
> >		};
>=20
> Ugh no. Having a vendor specific property which is KISS certainly
> beats this, both wrt ease of writing dts files as well as wrt the
> dts parsing code in the driver.

I'd agree with Heiko here. This is pretty much the same construct
that's already in use in other input drivers, like gpio-keys.

This is also something that can really easily be made generic, since
this is something that is rather common.

Speaking of which. I believe this should actually come in two
different drivers:
  - The ADC driver itself, using IIO
  - A generic button handler driver on top of IIO.

The fact that on most board this adc is used for buttons doesn't make
any difference, it's actually a hardware designer choice, we should
support that choice, but we should also be able to use it just as an
ADC.

Carlo Caione already started to work on an IIO driver for the LRADC:
https://github.com/carlocaione/linux/tree/sunxi-lradc
maybe you can take over his work.

I also wonder wether it would be possible in that case to use reg as
the "button" voltage, to get rid of both the chan0-step property, and
those big fat arrays in the driver.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--rOsx1R9haZTS96jr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSxcoGAAoJEBx+YmzsjxAgimgQAJbv8RhLYsInIFdNH8Y189/f
eu4fCHA5gjqnBG+xfAPVluC6IPK8Oo7RGUCi8AUBOcjXrrGIzckIMQYDDH1uOB2P
rU8IckuEt8qg9+RTRebQECsxQZtKO5m0LjE/ZWxIkrEDHJcev2bwHA+jIUfTC3fn
MxT3DcgnQxx7zXX+Z377x0GBz+7tBGYuToZT3AXfkPBY5ycxdRRYXFv50Ltv1Ar9
6KQB/chaQCHrSpdIp+vFju25uXcUkGKz83yiRtm5QN1rQcMDErPToz3dwJ4SLZSl
DW6LdKoRghkP+eHYHyej2jTZ7rszVY8CxPZ8WeChdkgtU691P7Ha8fSoDsj7PLEJ
ogKvJ2fpFWxvdyhM1A/15qTmLAWX92L5Hac6zH9uCwATAXwBScVNYMxsgQQ0W4NN
452wmouxuU3d2RDtnGq+8jhwTc7VkLeesZqXRWVtPeSbG88l5KNDMiF7axpWeGE9
IQAx5XYqXj2QeS9ZS6Cp1oZnAR+0tw+4z7TefdyV2eHsVEKhnp15wZZ+sB2iuh4e
wUA3KwSRAVoTb3nh6IKuMo1GbFDgjS3qSdZhl2/BPGcyhDIA1cd/qNIe6z6FlZdZ
0Iyb1dQpJYhgqsZ7aUwbGzlHzmEnIYlKpK3hTI//NhO3lIQXRR4xcKF0nfMnTSHB
LEHwXKBYdwEon0JW/kub
=8VOk
-----END PGP SIGNATURE-----

--rOsx1R9haZTS96jr--
