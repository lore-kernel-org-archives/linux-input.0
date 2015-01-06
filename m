From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 04/17] ARM: dts: sunxi: Add dtsi for AXP209 PMIC
Date: Tue, 6 Jan 2015 16:58:38 +0100
Message-ID: <20150106155838.GS7853@lukather>
References: <1420511727-8242-1-git-send-email-wens@csie.org>
 <1420511727-8242-5-git-send-email-wens@csie.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gXx2FYK2AghGE4Yq"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1420511727-8242-5-git-send-email-wens@csie.org>
Sender: linux-pm-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--gXx2FYK2AghGE4Yq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 06, 2015 at 10:35:14AM +0800, Chen-Yu Tsai wrote:
> The AXP209 PMIC is used with some Allwinner SoCs. This patch adds
> a dtsi file listing all the regulator nodes. The regulators are
> initialized based on their device node names.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/boot/dts/axp209.dtsi | 87 +++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 87 insertions(+)
>  create mode 100644 arch/arm/boot/dts/axp209.dtsi
>=20
> diff --git a/arch/arm/boot/dts/axp209.dtsi b/arch/arm/boot/dts/axp209.dtsi
> new file mode 100644
> index 000000000000..3c38cbafe285
> --- /dev/null
> +++ b/arch/arm/boot/dts/axp209.dtsi
> @@ -0,0 +1,87 @@
> +/*
> + * Copyright 2015 Chen-Yu Tsai
> + *
> + * Chen-Yu Tsai <wens@csie.org>
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This file is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This file is distributed in the hope that it will be useful,
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + *     You should have received a copy of the GNU General Public
> + *     License along with this file; if not, write to the Free
> + *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
> + *     MA 02110-1301 USA
> + *
> + * Or, alternatively,
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use,
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +/*
> + * AXP202/209 Integrated Power Management Chip
> + * http://www.x-powers.com/product/AXP20X.php
> + * http://dl.linux-sunxi.org/AXP/AXP209%20Datasheet%20v1.0_cn.pdf
> + */
> +
> +&axp209 {
> +	regulators {
> +		/* Default work frequency for buck regulators */
> +		x-powers,dcdc-freq =3D <1500>;
> +
> +		/* This section lists all the regulators */

I don't think this comment is necessary.

> +		reg_dcdc2: dcdc2 {
> +		};
> +
> +		reg_dcdc3: dcdc3 {
> +		};
> +
> +		reg_ldo1: ldo1 {
> +			/* LDO1 is a fixed output regulator */
> +			regulator-always-on;
> +			regulator-min-microvolt =3D <1300000>;
> +			regulator-max-microvolt =3D <1300000>;
> +		};
> +
> +		reg_ldo2: ldo2 {
> +		};
> +
> +		reg_ldo3: ldo3 {
> +		};
> +
> +		reg_ldo4: ldo4 {
> +		};
> +
> +		reg_ldo5: ldo5 {
> +		};

Some default names for the regulator would be great!

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--gXx2FYK2AghGE4Yq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUrAYuAAoJEBx+YmzsjxAgUxwP/3qekdf0BHTiPZOmmEi/bLBR
gqulYFuMVXhg7+UIBFh02KPjSrs3iGpUVQrwOnRtO97f0wk6M/YJaVBzFupFkbkL
b27gOrYcmCxd25skzk0EZ6XHToVF4KZUznR+UxQOG2K846qGtV13/p1E7vSdsJQo
/3qoiYWDEtw7lq+o22HeUH4VfN2qk/tG4QXa9p4XFrg8aJFB+SeefatwiuiMD1gm
JpVu5/MzzN0mlF41/RB911bgBAivU7jDNNDHwJ/XYVTrQDkmCg1idfFd9yvD0fjp
tEPyhCiK4kv7CuF3JYDRP/BraEExGDtmOrhV79OjFc43GuXPFw5yMnH0F/f97URs
fwY5qi4bm/hf2mGl/mTW51YLaEQK6jm8nvo8w0tBhddyWM0sYd4JJvO29dhqPd5h
XhoOyzA5VR0cPAsQjLkeK3dJ4dPRt6uOFkVBR7fRqVn3DTY+Gt3yBeq6km87kvqL
knKYtQLBNGR+JIaAXnJ9LblsBgre1R+8aozJmW4LN6F/0NCD0Wiem0CjSem1WXCg
fHl03fe3FsdlrwVW13q5NW8Gy4AOSVkhJQmCUXZ7zkhkO4c9sWq5K3nCh4y5TBNH
n+/7y6ojhgfRed0IlDDOI6eU14Gb0O8f19jqar2ZMe5V0VHuQczvPPZbXFWcIQvZ
BG+Ci8eNjkF6zJCnPxbx
=Z3la
-----END PGP SIGNATURE-----

--gXx2FYK2AghGE4Yq--
