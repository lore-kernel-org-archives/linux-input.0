From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 4/4] ARM: dts: sun7i: Add lradc node
Date: Wed, 22 Oct 2014 10:38:02 +0200
Message-ID: <20141022083802.GE7893@lukather>
References: <1413879890-7254-1-git-send-email-hdegoede@redhat.com>
 <1413879890-7254-5-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hwvH6HDNit2nSK4j"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBY62TWRAKGQEJYXDO4Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1413879890-7254-5-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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


--hwvH6HDNit2nSK4j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Hans,

On Tue, Oct 21, 2014 at 10:24:50AM +0200, Hans de Goede wrote:
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 48 +++++++++++++++++++=
++++++
>  arch/arm/boot/dts/sun7i-a20.dtsi                |  7 ++++
>  2 files changed, 55 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/b=
oot/dts/sun7i-a20-olinuxino-micro.dts
> index 9d669cdf..85e7194 100644
> --- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
> @@ -14,6 +14,7 @@
>  /dts-v1/;
>  /include/ "sun7i-a20.dtsi"
>  /include/ "sunxi-common-regulators.dtsi"
> +#include <dt-bindings/input/input.h>

I'm just wondering... Weren't we supposed to switch all includes to
the preprocessor syntax in such a case?

Maybe to handle the case were the DTSIs would have to use some
preprocessors macros that wouldn't be expanded in this case?

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--hwvH6HDNit2nSK4j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUR2zqAAoJEBx+YmzsjxAg6MQQAL5J6VX6CET33r18DnJnz/l4
/VJrzMo9tfduSMFA09/vuFphh7j3faAJhIqURjqGULUh17wAXsh1VCnLqSvg0SUz
gBpjRBrk5XnTbBUKQCij+wOTZO/e0ymNV1HODZ83bCwchUrQsmmkZDhw0+ibFL/E
xHIBBPvNrQnCDz/8WJUzq4Io8JfNTrQrnklEuKv6ICK+UvKIY1klPEffcq2cWmdx
WpvufCb9YISpWLuuYVdQmfoBdzj/Sk2Z0F6aRnNHXDlxu5INVTs0bKShV52bzhfA
fsVv8zFgFIZXkXcyu8vRHLjJhWXn5NwhjzWSGJ3/toqv6yr0wUGDGxzJFUwLWDJQ
PFexWYc2JRGEKeRL892NjwPdwUG6J5pLqS0XP4NChSacpFyEWHO4Mo5j3dFMPcGe
TR0PW7x1S9HySwopcnFQlAu5h9QhuKZjwQCH6yZ3BRY4BEsDSHfI05vPwfal91BP
26QEYko/dZfDkV10aWL9S7MeTZGT0KaE16c/TXu9+d11vmV0dRdz89X2dfJypjuM
eakFIuk8x+IPjr0lxXUaDP0dNtR5tESs7mpKVTb3oWYwfzr6wGAdbAOcJqETWFgq
tyFLy6Fqp3zKWWAvJZBelGRGKTPWjpiOifFsel1DphVHNyi93SmaAh9lQhtqq7lX
qjXmhd6nNzUzGo3nHMVM
=13t+
-----END PGP SIGNATURE-----

--hwvH6HDNit2nSK4j--
