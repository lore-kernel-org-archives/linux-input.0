From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3 1/4] input: Add new sun4i-lradc-keys driver
Date: Wed, 22 Oct 2014 18:01:19 +0200
Message-ID: <20141022160119.GH7893@lukather>
References: <1413976265-12805-1-git-send-email-hdegoede@redhat.com>
 <1413976265-12805-2-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HuscSE0D68UGttcd"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBL5LT6RAKGQEFHWCWQI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1413976265-12805-2-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-input@vger.kernel.org


--HuscSE0D68UGttcd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Hans,

On Wed, Oct 22, 2014 at 01:11:02PM +0200, Hans de Goede wrote:
> Allwinnner sunxi SoCs have a low resolution adc (called lradc) which is
> specifically designed to have various (tablet) keys (ie home, back, searc=
h,
> etc). attached to it using a resistor network. This adds a driver for thi=
s.
>=20
> There are 2 channels, currently this driver only supports chan0 since the=
re
> are no boards known to use chan1.
>=20
> This has been tested on an olimex a10s-olinuxino-micro, a13-olinuxino, and
> a20-olinuxino-micro.
>=20
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--HuscSE0D68UGttcd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUR9TOAAoJEBx+YmzsjxAgObEP/AwfLBAd5NxY6IPKHBnPDoZJ
LvKTcgYGtG7MVNuubru0uOiVtbhd1vN1FGbupEhpd6trulTnhZ2KIAQKu4LVar34
cLtbEnsnuBZCf0D/6E+P7EmDy/F5GnHlodT/leLd1SFTzou7q9hKbM646N+GogGf
DqCpDURyBxGC3u2EUBtWBAcWjwUfA/6Qx7QuNz5MLzQ58OA6iHMRS5aKrWgUXq2R
b97rA5YcIgSwPX4o77IirqVHrEedLynQFtpxBnyhIoHJUc6fhl2XKndjBoqbX6N5
wVXvVF6y+OIPsFyf1311zUWbJcO8+8nEBEDky0rlwORm29BI9YPEEPrgTAc+5CsD
FOAhkYrC48SLgR9RGCbyVrg9lB3WyYLZEu2xPdoie3yxMV1mwKr/ru/EN5+L+Ndm
SWyqLoAwjs+MZayurZGKdOHxMdgm76CfXzPMxjeKOzbCtkRx9oEvaWb8AqO9mVJo
ONs+NgAjbf/4J7PrE++xC3RdWCcWgoV4YxMaxU7cbBfPIS+f0i4wb7yrRKuhCKhS
rrdptXY1726FxAG/nppJxJrE7Xpv2v1TSbMg1RaJ8RRnWTkmrYnF2Zjjc3kaKu3d
bYnYrE7Llc7EDEaDDc0zCHeUlIzbo4f4JxO9hZunlDi1lYLzff2aS3y7gwSWwYEB
sedlJTO7ZaTkkKuvqrF4
=AO07
-----END PGP SIGNATURE-----

--HuscSE0D68UGttcd--
