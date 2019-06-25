From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH 1/2] Input: edt-ft5x06 - use get_unaligned_be16()
Date: Tue, 25 Jun 2019 08:44:29 +0000
Message-ID: <011d62995b20493f977ead43f4b494a2@AcuMS.aculab.com>
References: <20190623063153.261546-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190623063153.261546-1-dmitry.torokhov@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Marco Felsch <m.felsch@pengutronix.de>, Benoit Parrot <bparrot@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

From: Dmitry Torokhov
> Sent: 23 June 2019 07:32
> 
> Instead of doing conversion by hand, let's use the proper accessors.
> 
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
>  #define WORK_REGISTER_THRESHOLD		0x00
>  #define WORK_REGISTER_REPORT_RATE	0x08
> @@ -239,8 +240,8 @@ static irqreturn_t edt_ft5x06_ts_isr(int irq, void *dev_id)
>  		if (tsdata->version == EDT_M06 && type == TOUCH_EVENT_DOWN)
>  			continue;
> 
> -		x = ((buf[0] << 8) | buf[1]) & 0x0fff;
> -		y = ((buf[2] << 8) | buf[3]) & 0x0fff;
> +		x = get_unaligned_be16(buf) & 0x0fff;
> +		y = get_unaligned_be16(buf + 2) & 0x0fff;

You might as well delete the pointless masking with 0xff.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
