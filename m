From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH 1/6] mc13783: add power button support
Date: Fri, 22 Jul 2011 09:39:23 +0800
Message-ID: <20110722013922.GC26837@S2100-06.ap.freescale.net>
References: <1311261006-28048-1-git-send-email-philippe.retornaz@epfl.ch>
 <1311261006-28048-2-git-send-email-philippe.retornaz@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from db3ehsobe006.messaging.microsoft.com ([213.199.154.144]:27685
	"EHLO DB3EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752215Ab1GVBcX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Jul 2011 21:32:23 -0400
Content-Disposition: inline
In-Reply-To: <1311261006-28048-2-git-send-email-philippe.retornaz@epfl.ch>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Philippe =?iso-8859-1?Q?R=E9tornaz?= <philippe.retornaz@epfl.ch>
Cc: s.hauer@pengutronix.de, amit.kucheria@canonical.com, sameo@linux.intel.com, broonie@opensource.wolfsonmicro.com, linux-input@vger.kernel.org, u.kleine-koenig@pengutronix.de, dmitry.torokhov@gmail.com, linux-arm-kernel@lists.infradead.org

On Thu, Jul 21, 2011 at 05:10:01PM +0200, Philippe R=E9tornaz wrote:
> This adds support for the power-on buttons of MC13783 PMIC.
> This is done using a misc input device.
>=20
> Signed-off-by: Philippe R=E9tornaz <philippe.retornaz@epfl.ch>
> ---
>  drivers/input/misc/Kconfig             |   10 +
>  drivers/input/misc/Makefile            |    1 +
>  drivers/input/misc/mc13783-pwrbutton.c |  288 ++++++++++++++++++++++=
++++++++++
>  drivers/mfd/mc13xxx-core.c             |    4 +
>  include/linux/mfd/mc13783.h            |    1 +
>  include/linux/mfd/mc13xxx.h            |   17 ++
>  6 files changed, 321 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/input/misc/mc13783-pwrbutton.c
>=20
[...]
> diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
> index 7e4d44b..573e16b 100644
> --- a/drivers/mfd/mc13xxx-core.c
> +++ b/drivers/mfd/mc13xxx-core.c
> @@ -778,6 +778,10 @@ err_revision:
>  		mc13xxx_add_subdevice_pdata(mc13xxx, "%s-led",
>  				pdata->leds, sizeof(*pdata->leds));
> =20
> +	if (pdata->buttons)
> +		mc13xxx_add_subdevice_pdata(mc13xxx, "%s-pwrbutton",
> +				pdata->buttons, sizeof(*pdata->buttons));
> +

I do not see pdata has been checked for not being a NULL pointer
before using it in this function.  I know it's not you who started
it, but since you have been there, I'm wondering if you can give
it a fix.

--=20
Regards,
Shawn

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
