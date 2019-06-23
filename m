From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 1/2] Input: edt-ft5x06 - use get_unaligned_be16()
Date: Sun, 23 Jun 2019 11:00:22 +0300
Message-ID: <CAHp75VfJWGiZ2gAwAE-G+AnjrWC1mmS7uYknutNaQKW+CuCwvw@mail.gmail.com>
References: <20190623063153.261546-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190623063153.261546-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Marco Felsch <m.felsch@pengutronix.de>, Benoit Parrot <bparrot@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Sun, Jun 23, 2019 at 9:31 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Instead of doing conversion by hand, let's use the proper accessors.
>

The code looks fine to me,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

I can test it later next week (Wednesday or so).

> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/touchscreen/edt-ft5x06.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
> index c639ebce914c..ec770226e119 100644
> --- a/drivers/input/touchscreen/edt-ft5x06.c
> +++ b/drivers/input/touchscreen/edt-ft5x06.c
> @@ -27,6 +27,7 @@
>  #include <linux/gpio/consumer.h>
>  #include <linux/input/mt.h>
>  #include <linux/input/touchscreen.h>
> +#include <asm/unaligned.h>
>
>  #define WORK_REGISTER_THRESHOLD                0x00
>  #define WORK_REGISTER_REPORT_RATE      0x08
> @@ -239,8 +240,8 @@ static irqreturn_t edt_ft5x06_ts_isr(int irq, void *dev_id)
>                 if (tsdata->version == EDT_M06 && type == TOUCH_EVENT_DOWN)
>                         continue;
>
> -               x = ((buf[0] << 8) | buf[1]) & 0x0fff;
> -               y = ((buf[2] << 8) | buf[3]) & 0x0fff;
> +               x = get_unaligned_be16(buf) & 0x0fff;
> +               y = get_unaligned_be16(buf + 2) & 0x0fff;
>                 /* The FT5x26 send the y coordinate first */
>                 if (tsdata->version == EV_FT)
>                         swap(x, y);
> --
> 2.22.0.410.gd8fdbe21b5-goog
>


-- 
With Best Regards,
Andy Shevchenko
