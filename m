From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH 1/2] power: reset: reboot-mode: Make include file global
Date: Thu, 8 Jun 2017 18:24:07 +0200
Message-ID: <20170608162407.fk3xzqgdgeypy4g7@earth>
References: <20170527065130.3456-1-bjorn.andersson@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mfvapl7oifxlaiwu"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170527065130.3456-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-pm@vger.kernel.org, Rob Herring <robh@kernel.org>, John Stultz <john.stultz@linaro.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--mfvapl7oifxlaiwu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 26, 2017 at 11:51:29PM -0700, Bjorn Andersson wrote:
> Move the reboot-mode.h include file into include/linux to allow drivers
> outside drivers/power/reset to implement reboot-mode.
>=20
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Thanks, queued. I also created an immutable branch:

git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git ib=
-psy-reboot-mode-4.13

-- Sebastian

> ---
>  drivers/power/reset/reboot-mode.c                    | 2 +-
>  drivers/power/reset/syscon-reboot-mode.c             | 2 +-
>  {drivers/power/reset =3D> include/linux}/reboot-mode.h | 0
>  3 files changed, 2 insertions(+), 2 deletions(-)
>  rename {drivers/power/reset =3D> include/linux}/reboot-mode.h (100%)
>=20
> diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/rebo=
ot-mode.c
> index fb512183ace3..8f975ca0a8c4 100644
> --- a/drivers/power/reset/reboot-mode.c
> +++ b/drivers/power/reset/reboot-mode.c
> @@ -13,7 +13,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/reboot.h>
> -#include "reboot-mode.h"
> +#include <linux/reboot-mode.h>
> =20
>  #define PREFIX "mode-"
> =20
> diff --git a/drivers/power/reset/syscon-reboot-mode.c b/drivers/power/res=
et/syscon-reboot-mode.c
> index c8c371b285b1..563a97d7f73e 100644
> --- a/drivers/power/reset/syscon-reboot-mode.c
> +++ b/drivers/power/reset/syscon-reboot-mode.c
> @@ -15,7 +15,7 @@
>  #include <linux/reboot.h>
>  #include <linux/regmap.h>
>  #include <linux/mfd/syscon.h>
> -#include "reboot-mode.h"
> +#include <linux/reboot-mode.h>
> =20
>  struct syscon_reboot_mode {
>  	struct regmap *map;
> diff --git a/drivers/power/reset/reboot-mode.h b/include/linux/reboot-mod=
e.h
> similarity index 100%
> rename from drivers/power/reset/reboot-mode.h
> rename to include/linux/reboot-mode.h
> --=20
> 2.12.0
>=20

--mfvapl7oifxlaiwu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlk5eicACgkQ2O7X88g7
+pqQLBAAiJlqCbmXZRPlOasFJcmzzfdDoXo2y2uEWNcTEvJSFmwU00mIIn7fIR5w
wQCAyfGpnBqESCcdhv1oaSYOj4f4BAIvtEFELgot92RMNYq+43/d/A7FzckSUEWt
6FtYBVnLICoY9pIcPlGn2wgWAeCHUr0litJ1BHCQhZnmXFoMwvXvROkMXaBuHHdy
8C8R7qhHQdNxl22cn5Ol5XBdRNsYslz1YlsNS33gFZ4Oz3tK6C3dUijq1oZrs+X1
0SASX6DYwEVBXnXOuFdqb0g7rxs1LJahPJIzaQrQ1EyvNDAnUjhN2c4MPHolH1K/
GaRYlhQ20TqgsTtDCZOZ/gO45Tb+guntWgqaYbK9xD7cjNSXvez++OvepIy/NYb2
3qS9UP6PfWLfDnekXdKp0wXTMeRhwttkx3Ys36RS7M+jypq1oZ4Mio5Yi8VkbWz2
zFNxFKPGqSDXc+603LrZhyoO9tx60PotZKSULl2AnfgIvvNmNHzuWUzpNXeJVBH/
StGE0G2MWrmALYNrXo2IbO30cmVkXeFLdFrE76I5hMXVZ2WGIPtbugt0GZbbE34Q
PKWxGLaiFC0IJo0/vSUul56QeS7CH4oiaSiHiFZhdCN3tHiwN0yu2/pvyQCeqBxh
EpkwhaUJjzlTTnjvbjO/mPx0FIaXh/rn7KZlIMNSyrRyraMnJ+Q=
=Raod
-----END PGP SIGNATURE-----

--mfvapl7oifxlaiwu--
