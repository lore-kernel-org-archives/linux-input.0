From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: [PATCH v2 2/3] tps6507x-ts: add DT support
Date: Thu, 9 Mar 2017 16:02:36 +0100
Message-ID: <CAGm1_ks92FRZ2m7zZaupEt+7rh=y-O4o5+=5T8kvJPQtQsd1QA@mail.gmail.com>
References: <1489069869-3849-1-git-send-email-yegorslists@googlemail.com> <1489069869-3849-3-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35474 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932258AbdCIPC7 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 9 Mar 2017 10:02:59 -0500
Received: by mail-wr0-f193.google.com with SMTP id u108so8251986wrb.2
        for <linux-input@vger.kernel.org>; Thu, 09 Mar 2017 07:02:58 -0800 (PST)
In-Reply-To: <1489069869-3849-3-git-send-email-yegorslists@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh@kernel.org>, mark.rutland@arm.com, Andrey Skvortsov <andrej.skvortzov@gmail.com>, "Nori, Sekhar" <nsekhar@ti.com>, Kevin Hilman <khilman@baylibre.com>, Yegor Yefremov <yegorslists@googlemail.com>

Hi Dmitry, Sekhar,

On Thu, Mar 9, 2017 at 3:31 PM,  <yegorslists@googlemail.com> wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
>
> This patch adds support for DT to tps6507x-ts driver.
>
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> ---
>  drivers/input/touchscreen/tps6507x-ts.c | 40 ++++++++++-----------------------
>  1 file changed, 12 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/input/touchscreen/tps6507x-ts.c b/drivers/input/touchscreen/tps6507x-ts.c
> index fbaa2f68..502ed0c 100644
> --- a/drivers/input/touchscreen/tps6507x-ts.c
> +++ b/drivers/input/touchscreen/tps6507x-ts.c
> @@ -22,6 +22,8 @@
>  #include <linux/mfd/tps6507x.h>
>  #include <linux/input/tps6507x-ts.h>
>  #include <linux/delay.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
>
>  #define TSC_DEFAULT_POLL_PERIOD 30 /* ms */
>  #define TPS_DEFAULT_MIN_PRESSURE 0x30
> @@ -202,30 +204,11 @@ static void tps6507x_ts_poll(struct input_polled_dev *poll_dev)
>  static int tps6507x_ts_probe(struct platform_device *pdev)
>  {
>         struct tps6507x_dev *tps6507x_dev = dev_get_drvdata(pdev->dev.parent);
> -       const struct tps6507x_board *tps_board;
> -       const struct touchscreen_init_data *init_data;
>         struct tps6507x_ts *tsc;
>         struct input_polled_dev *poll_dev;
>         struct input_dev *input_dev;
>         int error;
>
> -       /*
> -        * tps_board points to pmic related constants
> -        * coming from the board-evm file.
> -        */
> -       tps_board = dev_get_platdata(tps6507x_dev->dev);
> -       if (!tps_board) {
> -               dev_err(tps6507x_dev->dev,
> -                       "Could not find tps6507x platform data\n");
> -               return -ENODEV;
> -       }
> -
> -       /*
> -        * init_data points to array of regulator_init structures
> -        * coming from the board-evm file.
> -        */
> -       init_data = tps_board->tps6507x_ts_init_data;
> -
>         tsc = devm_kzalloc(&pdev->dev, sizeof(struct tps6507x_ts), GFP_KERNEL);
>         if (!tsc) {
>                 dev_err(tps6507x_dev->dev, "failed to allocate driver data\n");
> @@ -234,8 +217,6 @@ static int tps6507x_ts_probe(struct platform_device *pdev)
>
>         tsc->mfd = tps6507x_dev;
>         tsc->dev = tps6507x_dev->dev;
> -       tsc->min_pressure = init_data ?
> -                       init_data->min_pressure : TPS_DEFAULT_MIN_PRESSURE;
>
>         snprintf(tsc->phys, sizeof(tsc->phys),
>                  "%s/input0", dev_name(tsc->dev));
> @@ -250,8 +231,6 @@ static int tps6507x_ts_probe(struct platform_device *pdev)
>
>         poll_dev->private = tsc;
>         poll_dev->poll = tps6507x_ts_poll;
> -       poll_dev->poll_interval = init_data ?
> -                       init_data->poll_period : TSC_DEFAULT_POLL_PERIOD;
>
>         input_dev = poll_dev->input;
>         input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
> @@ -265,11 +244,16 @@ static int tps6507x_ts_probe(struct platform_device *pdev)
>         input_dev->phys = tsc->phys;
>         input_dev->dev.parent = tsc->dev;
>         input_dev->id.bustype = BUS_I2C;
> -       if (init_data) {
> -               input_dev->id.vendor = init_data->vendor;
> -               input_dev->id.product = init_data->product;
> -               input_dev->id.version = init_data->version;
> -       }
> +       input_dev->id.vendor = 0;
> +       input_dev->id.product = 65070;
> +       input_dev->id.version = 0x100;

I've left the data as is to preserve current behavior until we decide
on what exact IDs to take.

> +       tsc->poll_dev->poll_interval = TSC_DEFAULT_POLL_PERIOD;
> +       tsc->min_pressure = TPS_DEFAULT_MIN_PRESSURE;
> +       device_property_read_u32_array(tsc->dev, "ti,poll-period",
> +                                      &tsc->poll_dev->poll_interval, 1);
> +       device_property_read_u16_array(tsc->dev, "ti,min-pressure",
> +                                      &tsc->min_pressure, 1);

This is working for DT, but I have problems with converting
arch/arm/mach-davinci/board-da850-evm.c

tps is a i2c device. How do I obtain struct device *dev from i2c_board?

Yegor

>         error = tps6507x_adc_standby(tsc);
>         if (error)
> --
> 2.1.4
>
