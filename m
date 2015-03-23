From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] input: touchscreen: stmpe: restrict to device tree
 mode
Date: Mon, 23 Mar 2015 08:58:30 -0700
Message-ID: <20150323155830.GA8666@dtor-ws>
References: <1427124541-27509-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:36154 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752869AbbCWP6f (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Mar 2015 11:58:35 -0400
Content-Disposition: inline
In-Reply-To: <1427124541-27509-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Mon, Mar 23, 2015 at 04:29:01PM +0100, Linus Walleij wrote:
> This strips the STMPE touchscreen input driver to only probe
> and acquire its configuration from the device tree. No in-kernel
> platforms use the static platform data so there is no point in
> keeping it around.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Dmitry if you can ACK this I think it is best of it's going in
> through Lee's MFD tree with some other cleanups.

Sure, no problem.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
>  drivers/input/touchscreen/stmpe-ts.c | 86 +++++++++++++++++++++---------------
>  include/linux/mfd/stmpe.h            | 43 ------------------
>  2 files changed, 51 insertions(+), 78 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/stmpe-ts.c b/drivers/input/touchscreen/stmpe-ts.c
> index 2d5ff86b343f..88a4bc0787c9 100644
> --- a/drivers/input/touchscreen/stmpe-ts.c
> +++ b/drivers/input/touchscreen/stmpe-ts.c
> @@ -63,6 +63,38 @@
>  #define STMPE_TS_NAME			"stmpe-ts"
>  #define XY_MASK				0xfff
>  
> +/**
> + * struct stmpe_touch - stmpe811 touch screen controller state
> + * @stmpe: pointer back to STMPE MFD container
> + * @idev: registered input device
> + * @work: a work item used to scan the device
> + * @dev: a pointer back to the MFD cell struct device*
> + * @sample_time: ADC converstion time in number of clock.
> + * (0 -> 36 clocks, 1 -> 44 clocks, 2 -> 56 clocks, 3 -> 64 clocks,
> + * 4 -> 80 clocks, 5 -> 96 clocks, 6 -> 144 clocks),
> + * recommended is 4.
> + * @mod_12b: ADC Bit mode (0 -> 10bit ADC, 1 -> 12bit ADC)
> + * @ref_sel: ADC reference source
> + * (0 -> internal reference, 1 -> external reference)
> + * @adc_freq: ADC Clock speed
> + * (0 -> 1.625 MHz, 1 -> 3.25 MHz, 2 || 3 -> 6.5 MHz)
> + * @ave_ctrl: Sample average control
> + * (0 -> 1 sample, 1 -> 2 samples, 2 -> 4 samples, 3 -> 8 samples)
> + * @touch_det_delay: Touch detect interrupt delay
> + * (0 -> 10 us, 1 -> 50 us, 2 -> 100 us, 3 -> 500 us,
> + * 4-> 1 ms, 5 -> 5 ms, 6 -> 10 ms, 7 -> 50 ms)
> + * recommended is 3
> + * @settling: Panel driver settling time
> + * (0 -> 10 us, 1 -> 100 us, 2 -> 500 us, 3 -> 1 ms,
> + * 4 -> 5 ms, 5 -> 10 ms, 6 for 50 ms, 7 -> 100 ms)
> + * recommended is 2
> + * @fraction_z: Length of the fractional part in z
> + * (fraction_z ([0..7]) = Count of the fractional part)
> + * recommended is 7
> + * @i_drive: current limit value of the touchscreen drivers
> + * (0 -> 20 mA typical 35 mA max, 1 -> 50 mA typical 80 mA max)
> + *
> + */
>  struct stmpe_touch {
>  	struct stmpe *stmpe;
>  	struct input_dev *idev;
> @@ -269,44 +301,28 @@ static void stmpe_ts_get_platform_info(struct platform_device *pdev,
>  {
>  	struct stmpe *stmpe = dev_get_drvdata(pdev->dev.parent);
>  	struct device_node *np = pdev->dev.of_node;
> -	struct stmpe_ts_platform_data *ts_pdata = NULL;
> +	u32 val;
>  
>  	ts->stmpe = stmpe;
>  
> -	if (stmpe->pdata && stmpe->pdata->ts) {
> -		ts_pdata = stmpe->pdata->ts;
> -
> -		ts->sample_time = ts_pdata->sample_time;
> -		ts->mod_12b = ts_pdata->mod_12b;
> -		ts->ref_sel = ts_pdata->ref_sel;
> -		ts->adc_freq = ts_pdata->adc_freq;
> -		ts->ave_ctrl = ts_pdata->ave_ctrl;
> -		ts->touch_det_delay = ts_pdata->touch_det_delay;
> -		ts->settling = ts_pdata->settling;
> -		ts->fraction_z = ts_pdata->fraction_z;
> -		ts->i_drive = ts_pdata->i_drive;
> -	} else if (np) {
> -		u32 val;
> -
> -		if (!of_property_read_u32(np, "st,sample-time", &val))
> -			ts->sample_time = val;
> -		if (!of_property_read_u32(np, "st,mod-12b", &val))
> -			ts->mod_12b = val;
> -		if (!of_property_read_u32(np, "st,ref-sel", &val))
> -			ts->ref_sel = val;
> -		if (!of_property_read_u32(np, "st,adc-freq", &val))
> -			ts->adc_freq = val;
> -		if (!of_property_read_u32(np, "st,ave-ctrl", &val))
> -			ts->ave_ctrl = val;
> -		if (!of_property_read_u32(np, "st,touch-det-delay", &val))
> -			ts->touch_det_delay = val;
> -		if (!of_property_read_u32(np, "st,settling", &val))
> -			ts->settling = val;
> -		if (!of_property_read_u32(np, "st,fraction-z", &val))
> -			ts->fraction_z = val;
> -		if (!of_property_read_u32(np, "st,i-drive", &val))
> -			ts->i_drive = val;
> -	}
> +	if (!of_property_read_u32(np, "st,sample-time", &val))
> +		ts->sample_time = val;
> +	if (!of_property_read_u32(np, "st,mod-12b", &val))
> +		ts->mod_12b = val;
> +	if (!of_property_read_u32(np, "st,ref-sel", &val))
> +		ts->ref_sel = val;
> +	if (!of_property_read_u32(np, "st,adc-freq", &val))
> +		ts->adc_freq = val;
> +	if (!of_property_read_u32(np, "st,ave-ctrl", &val))
> +		ts->ave_ctrl = val;
> +	if (!of_property_read_u32(np, "st,touch-det-delay", &val))
> +		ts->touch_det_delay = val;
> +	if (!of_property_read_u32(np, "st,settling", &val))
> +		ts->settling = val;
> +	if (!of_property_read_u32(np, "st,fraction-z", &val))
> +		ts->fraction_z = val;
> +	if (!of_property_read_u32(np, "st,i-drive", &val))
> +		ts->i_drive = val;
>  }
>  
>  static int stmpe_input_probe(struct platform_device *pdev)
> diff --git a/include/linux/mfd/stmpe.h b/include/linux/mfd/stmpe.h
> index c9d869027300..93e62ae32906 100644
> --- a/include/linux/mfd/stmpe.h
> +++ b/include/linux/mfd/stmpe.h
> @@ -117,46 +117,6 @@ extern int stmpe_disable(struct stmpe *stmpe, unsigned int blocks);
>  
>  #define STMPE_GPIO_NOREQ_811_TOUCH	(0xf0)
>  
> -/**
> - * struct stmpe_ts_platform_data - stmpe811 touch screen controller platform
> - * data
> - * @sample_time: ADC converstion time in number of clock.
> - * (0 -> 36 clocks, 1 -> 44 clocks, 2 -> 56 clocks, 3 -> 64 clocks,
> - * 4 -> 80 clocks, 5 -> 96 clocks, 6 -> 144 clocks),
> - * recommended is 4.
> - * @mod_12b: ADC Bit mode (0 -> 10bit ADC, 1 -> 12bit ADC)
> - * @ref_sel: ADC reference source
> - * (0 -> internal reference, 1 -> external reference)
> - * @adc_freq: ADC Clock speed
> - * (0 -> 1.625 MHz, 1 -> 3.25 MHz, 2 || 3 -> 6.5 MHz)
> - * @ave_ctrl: Sample average control
> - * (0 -> 1 sample, 1 -> 2 samples, 2 -> 4 samples, 3 -> 8 samples)
> - * @touch_det_delay: Touch detect interrupt delay
> - * (0 -> 10 us, 1 -> 50 us, 2 -> 100 us, 3 -> 500 us,
> - * 4-> 1 ms, 5 -> 5 ms, 6 -> 10 ms, 7 -> 50 ms)
> - * recommended is 3
> - * @settling: Panel driver settling time
> - * (0 -> 10 us, 1 -> 100 us, 2 -> 500 us, 3 -> 1 ms,
> - * 4 -> 5 ms, 5 -> 10 ms, 6 for 50 ms, 7 -> 100 ms)
> - * recommended is 2
> - * @fraction_z: Length of the fractional part in z
> - * (fraction_z ([0..7]) = Count of the fractional part)
> - * recommended is 7
> - * @i_drive: current limit value of the touchscreen drivers
> - * (0 -> 20 mA typical 35 mA max, 1 -> 50 mA typical 80 mA max)
> - *
> - * */
> -struct stmpe_ts_platform_data {
> -       u8 sample_time;
> -       u8 mod_12b;
> -       u8 ref_sel;
> -       u8 adc_freq;
> -       u8 ave_ctrl;
> -       u8 touch_det_delay;
> -       u8 settling;
> -       u8 fraction_z;
> -       u8 i_drive;
> -};
>  
>  /**
>   * struct stmpe_platform_data - STMPE platform data
> @@ -168,7 +128,6 @@ struct stmpe_ts_platform_data {
>   * @irq_over_gpio: true if gpio is used to get irq
>   * @irq_gpio: gpio number over which irq will be requested (significant only if
>   *	      irq_over_gpio is true)
> - * @ts: touchscreen-specific platform data
>   */
>  struct stmpe_platform_data {
>  	int id;
> @@ -178,8 +137,6 @@ struct stmpe_platform_data {
>  	bool irq_over_gpio;
>  	int irq_gpio;
>  	int autosleep_timeout;
> -
> -	struct stmpe_ts_platform_data *ts;
>  };
>  
>  #endif
> -- 
> 1.9.3
> 

-- 
Dmitry
