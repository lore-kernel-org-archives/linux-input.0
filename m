From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input: Colibri VF50 - Add missing #include
 <linux/of.h>
Date: Tue, 9 Feb 2016 10:33:24 -0800
Message-ID: <20160209183324.GE40460@dtor-ws>
References: <1454854687-21114-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1454854687-21114-1-git-send-email-geert@linux-m68k.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Bastien Nocera <hadess@hadess.net>, Sanchayan Maity <maitysanchayan@gmail.com>, linux-input@vger.kernel.org, linux-gpio@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, Feb 07, 2016 at 03:18:06PM +0100, Geert Uytterhoeven wrote:
> drivers/input/touchscreen/colibri-vf50-ts.c: In function =E2=80=98vf5=
0_ts_probe=E2=80=99:
> drivers/input/touchscreen/colibri-vf50-ts.c:302: error: implicit decl=
aration of function =E2=80=98of_property_read_u32=E2=80=99
>=20
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Applied, thank you.

> ---
> Seen with "[PATCH 2/2] Input: Allow compile test of Goodix and Colibr=
i
> VF50 if !GPIOLIB" on m68k/allmodconfig
>=20
>  drivers/input/touchscreen/colibri-vf50-ts.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/input/touchscreen/colibri-vf50-ts.c b/drivers/in=
put/touchscreen/colibri-vf50-ts.c
> index 5d4903a402cc6a5f..69828d015d45ffa4 100644
> --- a/drivers/input/touchscreen/colibri-vf50-ts.c
> +++ b/drivers/input/touchscreen/colibri-vf50-ts.c
> @@ -21,6 +21,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> --=20
> 1.9.1
>=20

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
