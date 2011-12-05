From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH] Input: zylonite-wm97xx - replace IRQ_GPIO() with gpio_to_irq()
Date: Mon, 5 Dec 2011 19:30:54 +0800
Message-ID: <CAN1soZyrtbheNDJU=vbHFY8fu2O3Q_g2dGoO1hjSaSErL1ObnQ@mail.gmail.com>
References: <1323083592.6763.5.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:45068 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755912Ab1LELaz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 5 Dec 2011 06:30:55 -0500
In-Reply-To: <1323083592.6763.5.camel@phoenix>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Mon, Dec 5, 2011 at 7:13 PM, Axel Lin <axel.lin@gmail.com> wrote:
> Since commit 6384fd "ARM: pxa: rename IRQ_GPIO to PXA_GPIO_TO_IRQ",
> I got below buid errors due to implicit declaration of function 'IRQ_=
GPIO'.
>
> Use common gpio_to_irq() to replace machine dependant macro IRQ_GPIO(=
).
>
> =A0CC =A0 =A0 =A0drivers/input/touchscreen/zylonite-wm97xx.o
> drivers/input/touchscreen/zylonite-wm97xx.c: In function 'zylonite_wm=
97xx_probe':
> drivers/input/touchscreen/zylonite-wm97xx.c:195: error: implicit decl=
aration of function 'IRQ_GPIO'
> make[3]: *** [drivers/input/touchscreen/zylonite-wm97xx.o] Error 1
> make[2]: *** [drivers/input/touchscreen] Error 2
> make[1]: *** [drivers/input] Error 2
> make: *** [drivers] Error 2
>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Haojian Zhuang <haojian.zhuang@marvell.com>
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
> I got the build error in linux-next tree,
> thus this patch is against linux-next (20111205).
>
> Axel
> =A0drivers/input/touchscreen/zylonite-wm97xx.c | =A0 =A05 +++--
> =A01 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/touchscreen/zylonite-wm97xx.c b/drivers/in=
put/touchscreen/zylonite-wm97xx.c
> index add6e3b..bf0869a7 100644
> --- a/drivers/input/touchscreen/zylonite-wm97xx.c
> +++ b/drivers/input/touchscreen/zylonite-wm97xx.c
> @@ -22,6 +22,7 @@
> =A0#include <linux/kernel.h>
> =A0#include <linux/init.h>
> =A0#include <linux/delay.h>
> +#include <linux/gpio.h>
> =A0#include <linux/irq.h>
> =A0#include <linux/interrupt.h>
> =A0#include <linux/io.h>
> @@ -192,8 +193,8 @@ static int zylonite_wm97xx_probe(struct platform_=
device *pdev)
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpio_touch_irq =3D mfp_to_gpio(MFP_PIN=
_GPIO26);
>
> - =A0 =A0 =A0 wm->pen_irq =3D IRQ_GPIO(gpio_touch_irq);
> - =A0 =A0 =A0 irq_set_irq_type(IRQ_GPIO(gpio_touch_irq), IRQ_TYPE_EDG=
E_BOTH);
> + =A0 =A0 =A0 wm->pen_irq =3D gpio_to_irq(gpio_touch_irq);
> + =A0 =A0 =A0 irq_set_irq_type(wm->pen_irq, IRQ_TYPE_EDGE_BOTH);
>
> =A0 =A0 =A0 =A0wm97xx_config_gpio(wm, WM97XX_GPIO_13, WM97XX_GPIO_IN,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 WM97XX_GPIO_POL_H=
IGH,
> --

Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
