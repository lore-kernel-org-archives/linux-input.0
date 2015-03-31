From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Using gpio_keys with regmapped gpio?
Date: Tue, 31 Mar 2015 21:04:03 +0100
Message-ID: <20150331200403.GW2869@sirena.org.uk>
References: <551AFC2F.3060300@opensource.altera.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cUQyP71RyCFJ5E3t"
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <551AFC2F.3060300-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Cc: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org


--cUQyP71RyCFJ5E3t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 31, 2015 at 02:57:35PM -0500, Thor Thayer wrote:

> Which brings up my next question. Can the gpio_keys framework be used with a
> regmapped gpio? I haven't been able to find any examples of gpio_keys with
> an external gpio expander and maybe this isn't valid usage.

Why would there be any problem doing that?  I suspect a lack of examples
is more to do with it being rare to build hardware like that (usually on
SoC GPIOs are fairly abundant and much more performant) than anything
else.

--cUQyP71RyCFJ5E3t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVGv2zAAoJECTWi3JdVIfQKGsH/1HmZnD1JvWno3f+3vEHl8Ag
NIDI5wBhmtUF/W98TMgEjv/FjDJGLJNWae9vRJDySkHOiCRITyczHtFL6vlpt2cY
8a/DKbFAvjVYahMiFAc6mdoPeXhmuDpo8N5wSVJHRiSetTqXqo+2BbBb2IcjcVZA
RNGaMGuy68EgmXND81XsdYJM94A6vd75IBBRdnABHOCeoZqG7vaEfOokrQb1U8n4
ArBOlvvaHjBLsqITKSCTJO8uImo5P+hHbg4n0fFXjHrpZtS8w5nmkCThbzB9vrRK
TVWtBwsIb4br9F8XWKROQcU94U+QIgtUOg8I0+p3UYnWy0xJBWEKUAix693vnZA=
=N+rn
-----END PGP SIGNATURE-----

--cUQyP71RyCFJ5E3t--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
