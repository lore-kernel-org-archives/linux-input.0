From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input: sun4i-ts: Add support for touchpanel
 controller on A31
Date: Mon, 26 Jan 2015 23:59:21 -0800
Message-ID: <20150127075921.GA11487@dtor-ws>
References: <1422110028-30270-1-git-send-email-wens@csie.org>
 <1422110028-30270-2-git-send-email-wens@csie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:55051 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753188AbbA0H7d (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Jan 2015 02:59:33 -0500
Received: by mail-ie0-f174.google.com with SMTP id vy18so13732763iec.5
        for <linux-input@vger.kernel.org>; Mon, 26 Jan 2015 23:59:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1422110028-30270-2-git-send-email-wens@csie.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Hans de Goede <hdegoede@redhat.com>, Sugar <shuge@allwinnertech.com>, Meng Zhang <kevin@allwinnertech.com>

On Sat, Jan 24, 2015 at 10:33:47PM +0800, Chen-Yu Tsai wrote:
> The Allwinner A31 SoC (sun6i) has the same resistive touchpanel
> controller as on other sunxi platforms. The only difference between
> the variants is the control bits for enabling operations are
> left-shifted by 1 on the A31.
> 
> This patch adds support for this variant.
> 
> Also update the comment for the original temperature sensor with
> information from Allwinner.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thank you.

> ---
>  .../bindings/input/touchscreen/sun4i.txt           |  2 +-
>  drivers/input/touchscreen/sun4i-ts.c               | 46 ++++++++++++++++------
>  2 files changed, 34 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/sun4i.txt b/Documentation/devicetree/bindings/input/touchscreen/sun4i.txt
> index a8405bab6c00..433332d3b2ba 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/sun4i.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/sun4i.txt
> @@ -2,7 +2,7 @@ sun4i resistive touchscreen controller
>  --------------------------------------
>  
>  Required properties:
> - - compatible: "allwinner,sun4i-a10-ts"
> + - compatible: "allwinner,sun4i-a10-ts" or "allwinner,sun6i-a31-ts"
>   - reg: mmio address range of the chip
>   - interrupts: interrupt to which the chip is connected
>   - #thermal-sensor-cells: shall be 0
> diff --git a/drivers/input/touchscreen/sun4i-ts.c b/drivers/input/touchscreen/sun4i-ts.c
> index 9ae53d4289fb..b93a28b955fd 100644
> --- a/drivers/input/touchscreen/sun4i-ts.c
> +++ b/drivers/input/touchscreen/sun4i-ts.c
> @@ -72,6 +72,9 @@
>  #define TP_ADC_SELECT(x)	((x) << 3)
>  #define ADC_CHAN_SELECT(x)	((x) << 0)  /* 3 bits */
>  
> +/* on sun6i, bits 3~6 are left shifted by 1 to 4~7 */
> +#define SUN6I_TP_MODE_EN(x)	((x) << 5)
> +
>  /* TP_CTRL2 bits */
>  #define TP_SENSITIVE_ADJUST(x)	((x) << 28) /* 4 bits */
>  #define TP_MODE_SELECT(x)	((x) << 26) /* 2 bits */
> @@ -113,6 +116,8 @@ struct sun4i_ts_data {
>  	unsigned int irq;
>  	bool ignore_fifo_data;
>  	int temp_data;
> +	int temp_offset;
> +	int temp_step;
>  };
>  
>  static void sun4i_ts_irq_handle_input(struct sun4i_ts_data *ts, u32 reg_val)
> @@ -188,17 +193,7 @@ static int sun4i_get_temp(const struct sun4i_ts_data *ts, long *temp)
>  	if (ts->temp_data == -1)
>  		return -EAGAIN;
>  
> -	/*
> -	 * The user manuals do not contain the formula for calculating
> -	 * the temperature. The formula used here is from the AXP209,
> -	 * which is designed by X-Powers, an affiliate of Allwinner:
> -	 *
> -	 *     temperature = -144.7 + (value * 0.1)
> -	 *
> -	 * This should be replaced with the correct one if such information
> -	 * becomes available.
> -	 */
> -	*temp = (ts->temp_data - 1447) * 100;
> +	*temp = (ts->temp_data - ts->temp_offset) * ts->temp_step;
>  
>  	return 0;
>  }
> @@ -249,6 +244,7 @@ static int sun4i_ts_probe(struct platform_device *pdev)
>  	struct device_node *np = dev->of_node;
>  	struct device *hwmon;
>  	int error;
> +	u32 reg;
>  	bool ts_attached;
>  
>  	ts = devm_kzalloc(dev, sizeof(struct sun4i_ts_data), GFP_KERNEL);
> @@ -258,6 +254,25 @@ static int sun4i_ts_probe(struct platform_device *pdev)
>  	ts->dev = dev;
>  	ts->ignore_fifo_data = true;
>  	ts->temp_data = -1;
> +	if (of_device_is_compatible(np, "allwinner,sun6i-a31-ts")) {
> +		/* Allwinner SDK has temperature = -271 + (value / 6) (C) */
> +		ts->temp_offset = 1626;
> +		ts->temp_step = 167;
> +	} else {
> +		/*
> +		 * The user manuals do not contain the formula for calculating
> +		 * the temperature. The formula used here is from the AXP209,
> +		 * which is designed by X-Powers, an affiliate of Allwinner:
> +		 *
> +		 *     temperature = -144.7 + (value * 0.1)
> +		 *
> +		 * Allwinner does not have any documentation whatsoever for
> +		 * this hardware. Moreover, it is claimed that the sensor
> +		 * is inaccurate and cannot work properly.
> +		 */
> +		ts->temp_offset = 1447;
> +		ts->temp_step = 100;
> +	}
>  
>  	ts_attached = of_property_read_bool(np, "allwinner,ts-attached");
>  	if (ts_attached) {
> @@ -314,8 +329,12 @@ static int sun4i_ts_probe(struct platform_device *pdev)
>  	 * Set stylus up debounce to aprox 10 ms, enable debounce, and
>  	 * finally enable tp mode.
>  	 */
> -	writel(STYLUS_UP_DEBOUN(5) | STYLUS_UP_DEBOUN_EN(1) | TP_MODE_EN(1),
> -	       ts->base + TP_CTRL1);
> +	reg = STYLUS_UP_DEBOUN(5) | STYLUS_UP_DEBOUN_EN(1);
> +	if (of_device_is_compatible(np, "allwinner,sun4i-a10-ts"))
> +		reg |= TP_MODE_EN(1);
> +	else
> +		reg |= SUN6I_TP_MODE_EN(1);
> +	writel(reg, ts->base + TP_CTRL1);
>  
>  	/*
>  	 * The thermal core does not register hwmon devices for DT-based
> @@ -364,6 +383,7 @@ static int sun4i_ts_remove(struct platform_device *pdev)
>  
>  static const struct of_device_id sun4i_ts_of_match[] = {
>  	{ .compatible = "allwinner,sun4i-a10-ts", },
> +	{ .compatible = "allwinner,sun6i-a31-ts", },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, sun4i_ts_of_match);
> -- 
> 2.1.4
> 

-- 
Dmitry
