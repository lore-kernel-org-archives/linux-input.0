From: Benson Leung <bleung@google.com>
Subject: Re: [PATCH 0/3] platform/chrome: mfd: Move cros-ec transport drivers
 to drivers/platform
Date: Mon, 2 Jul 2018 16:13:18 -0700
Message-ID: <20180702231318.GB86110@decatoncale.mtv.corp.google.com>
References: <20180702102201.13461-1-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180702102201.13461-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Russell King <linux@armlinux.org.uk>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>, Olof Johansson <olof@lixom.net>, Gwendal Grignou <gwendal@chromium.org>, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, kernel@collabora.com, Guenter Roeck <groeck@google.com>, linux-arm-kernel@lists.infradead.org, Bjorn Andersson <bjorn.andersson@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Gregory CLEMENT <gregory.clement@bootlin.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Miqu
List-Id: linux-input@vger.kernel.org


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Enric,

On Mon, Jul 02, 2018 at 12:21:58PM +0200, Enric Balletbo i Serra wrote:
> Hi,
>=20
> The cros-ec transport drivers are placed in two subsystems, in MFD and
> in platform/chrome. As far as I know there is no reason for this, so,
> move the I2C and the SPI cros-ec transport driver from the MFD subsystem
> to the platform/chrome. The series also removes the MFD_ prefix for the
> Kconfig symbols, modifies the defconfigs that used these symbols and
> fixes the KEYBOARD_CROS_EC Kconfig help.
>=20

Thanks for putting this together.

I can create an IB with this for the others to pull. What do you all think?

Thanks,
Benson

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAls6sY4ACgkQHwn1ewov
5lhKfw/+NbPs75nFdsTi5TrAwbTlCSmm2IIvVCOTmde47Qo3vxt4ZFn+DmK745Ok
IxzVgFy8k6X8vaHQ69likV0Twk25z9ncZIAEKLQQLjP20Wr9qGOec+r+DsXwQXeO
gE1NI3AzC3HxmjZN0wqaSJrId8+QU+zh78H6uyo8OXl4/OWniZZVVdNnKaosA7iM
W/yEGZP6N5KFwkjl9OKXwE19e9YAUk2KB6WoVgMpAjyWoPrsI1yTyFcAgD6ciUPJ
+XUeNTYrX9kHhqeb2uSXfyJAg7uoApqwqtDp8FcG2fy/eux4Ig6vV73/pCsEU+ps
iE7LlhfEX59a0k6hMbE/Rlul8Qwo10DUQ0GS1Cr1umRqYfFtYYIhKaLorYxBr7Or
Ob5kUDS1kg20JhwVanszE0QI1iD4mNPZasjDNDVHMbiCbvVvaZo7WZ+6mV5CfCzL
0qCqZN4+shfvy//xNYbi6l4BTRpILwou4vMMB9eToVrzT4VODa0wK28X0FaY32vU
UHFGtSPadkj/QmwZUoog+Fm1voLd9EZMLmECpjvZ3vBnqG81LU1begMEEe9t0yJD
6uC7osHWgjtg98caXqvBjoA27KGFwJCcWQBqoI6e0/sDICDK5fgkxsHNlX/02ntx
WEqZCNuEToe5EYYSGUZauCYmcW8vMVnD0EV7NwtYf2SOCm17BOU=
=Bei6
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
