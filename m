From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/3] tps6507x-ts: add DT support
Date: Sat, 25 Feb 2017 11:08:27 -0800
Message-ID: <20170225190827.GC31929@dtor-ws>
References: <1487950946-18590-1-git-send-email-yegorslists@googlemail.com>
 <1487950946-18590-3-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:32771 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751434AbdBYTIb (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 25 Feb 2017 14:08:31 -0500
Received: by mail-pg0-f66.google.com with SMTP id 5so7446810pgj.0
        for <linux-input@vger.kernel.org>; Sat, 25 Feb 2017 11:08:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1487950946-18590-3-git-send-email-yegorslists@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: yegorslists@googlemail.com
Cc: linux-input@vger.kernel.org, lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, andrej.skvortzov@gmail.com

Hi Yegor,

On Fri, Feb 24, 2017 at 04:42:25PM +0100, yegorslists@googlemail.com wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
> 
> This patch adds support for DT to tps6507x-ts driver.
> 
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> ---
>  drivers/input/touchscreen/tps6507x-ts.c | 70 ++++++++++++++++++++-------------
>  1 file changed, 42 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/tps6507x-ts.c b/drivers/input/touchscreen/tps6507x-ts.c
> index 5bf1ec6..2d61220 100644
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
> @@ -199,33 +201,52 @@ static void tps6507x_ts_poll(struct input_polled_dev *poll_dev)
>  	tps6507x_adc_standby(tsc);
>  }
>  
> +static void tsc_init_data(struct tps6507x_ts *tsc,
> +		struct input_dev *input_dev)
> +{
> +	struct device_node *node = tsc->dev->of_node;
> +	const struct tps6507x_board *tps_board =
> +			dev_get_platdata(tsc->dev);
> +	const struct touchscreen_init_data *init_data = NULL;
> +
> +	if (tps_board)
> +		/*
> +		 * init_data points to array of touchscreen_init structure
> +		 * coming from the board-evm file.
> +		 */
> +		init_data = tps_board->tps6507x_ts_init_data;
> +
> +	if (node == NULL && init_data == NULL) {
> +		tsc->poll_dev->poll_interval = TSC_DEFAULT_POLL_PERIOD;
> +		tsc->min_pressure = TPS_DEFAULT_MIN_PRESSURE;

I think you want to always init with defaults, then override with
property data.

> +	} else if (init_data) {
> +		tsc->poll_dev->poll_interval = init_data->poll_period;
> +		tsc->min_pressure = init_data->min_pressure;
> +		input_dev->id.vendor = init_data->vendor;
> +		input_dev->id.product = init_data->product;
> +		input_dev->id.version = init_data->version;
> +	} else if (node) {
> +		of_property_read_u32(node, "ti,poll-period",
> +				&tsc->poll_dev->poll_interval);
> +		of_property_read_u16(node, "ti,min-pressure",
> +				&tsc->min_pressure);

Anything but u32 is better avoided in DT as it requires special
annotation which is easily forgotten.

I also would prefer if we switched to generic device properties and
retired the static init data.


> +		of_property_read_u16(node, "ti,vendor",
> +				&input_dev->id.vendor);
> +		of_property_read_u16(node, "ti,product",
> +				&input_dev->id.product);

Would we not know vendor and product from the compatible string?

> +		of_property_read_u16(node, "ti,version",
> +				&input_dev->id.version);

I wonder if anyone cares about this.

> +	}
> +}
> +
>  static int tps6507x_ts_probe(struct platform_device *pdev)
>  {
>  	struct tps6507x_dev *tps6507x_dev = dev_get_drvdata(pdev->dev.parent);
> -	const struct tps6507x_board *tps_board;
> -	const struct touchscreen_init_data *init_data;
>  	struct tps6507x_ts *tsc;
>  	struct input_polled_dev *poll_dev;
>  	struct input_dev *input_dev;
>  	int error;
>  
> -	/*
> -	 * tps_board points to pmic related constants
> -	 * coming from the board-evm file.
> -	 */
> -	tps_board = dev_get_platdata(tps6507x_dev->dev);
> -	if (!tps_board) {
> -		dev_err(tps6507x_dev->dev,
> -			"Could not find tps6507x platform data\n");
> -		return -ENODEV;
> -	}
> -
> -	/*
> -	 * init_data points to array of regulator_init structures
> -	 * coming from the board-evm file.
> -	 */
> -	init_data = tps_board->tps6507x_ts_init_data;
> -
>  	tsc = devm_kzalloc(&pdev->dev, sizeof(struct tps6507x_ts), GFP_KERNEL);
>  	if (!tsc) {
>  		dev_err(tps6507x_dev->dev, "failed to allocate driver data\n");
> @@ -234,8 +255,6 @@ static int tps6507x_ts_probe(struct platform_device *pdev)
>  
>  	tsc->mfd = tps6507x_dev;
>  	tsc->dev = tps6507x_dev->dev;
> -	tsc->min_pressure = init_data ?
> -			init_data->min_pressure : TPS_DEFAULT_MIN_PRESSURE;
>  
>  	snprintf(tsc->phys, sizeof(tsc->phys),
>  		 "%s/input0", dev_name(tsc->dev));
> @@ -251,8 +270,6 @@ static int tps6507x_ts_probe(struct platform_device *pdev)
>  
>  	poll_dev->private = tsc;
>  	poll_dev->poll = tps6507x_ts_poll;
> -	poll_dev->poll_interval = init_data ?
> -			init_data->poll_period : TSC_DEFAULT_POLL_PERIOD;
>  
>  	input_dev = poll_dev->input;
>  	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
> @@ -266,11 +283,8 @@ static int tps6507x_ts_probe(struct platform_device *pdev)
>  	input_dev->phys = tsc->phys;
>  	input_dev->dev.parent = tsc->dev;
>  	input_dev->id.bustype = BUS_I2C;
> -	if (init_data) {
> -		input_dev->id.vendor = init_data->vendor;
> -		input_dev->id.product = init_data->product;
> -		input_dev->id.version = init_data->version;
> -	}
> +
> +	tsc_init_data(tsc, input_dev);
>  
>  	error = tps6507x_adc_standby(tsc);
>  	if (error)
> -- 
> 2.1.4
> 

Thanks.

-- 
Dmitry
