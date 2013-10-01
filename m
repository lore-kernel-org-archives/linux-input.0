From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 4/9] Staging/iio/adc/touchscreen/MXS: simplify register
 access
Date: Tue, 01 Oct 2013 12:01:52 +0100
Message-ID: <524AABA0.8040807@kernel.org>
References: <1379946998-23041-1-git-send-email-jbe@pengutronix.de> <1379946998-23041-5-git-send-email-jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53839 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752983Ab3JAKB0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Oct 2013 06:01:26 -0400
In-Reply-To: <1379946998-23041-5-git-send-email-jbe@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Juergen Beisert <jbe@pengutronix.de>, linux-iio@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org, marex@denx.de, fabio.estevam@freescale.com, jic23@cam.ac.uk, linux-input@vger.kernel.org

On 09/23/13 15:36, Juergen Beisert wrote:
> Replace the individual register access by a few shared access function to make the
> code easier to read and in order to add the i.MX23 SoC in the next step.
> 
> Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
> CC: linux-arm-kernel@lists.infradead.org
> CC: linux-input@vger.kernel.org
> CC: devel@driverdev.osuosl.org
> CC: Marek Vasut <marex@denx.de>
> CC: Fabio Estevam <fabio.estevam@freescale.com>
> CC: Jonathan Cameron <jic23@cam.ac.uk>
Applied to the togreg branch of iio.git

Thanks,

Jonathan
> ---
>  drivers/staging/iio/adc/mxs-lradc.c | 204 +++++++++++++++++++++---------------
>  1 file changed, 120 insertions(+), 84 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
> index f2fb10a..dd47ec2 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -238,6 +238,56 @@ struct mxs_lradc {
>  #define LRADC_RESOLUTION			12
>  #define LRADC_SINGLE_SAMPLE_MASK		((1 << LRADC_RESOLUTION) - 1)
>  
> +static void mxs_lradc_reg_set(struct mxs_lradc *lradc, u32 val, u32 reg)
> +{
> +	writel(val, lradc->base + reg + STMP_OFFSET_REG_SET);
> +}
> +
> +static void mxs_lradc_reg_clear(struct mxs_lradc *lradc, u32 val, u32 reg)
> +{
> +	writel(val, lradc->base + reg + STMP_OFFSET_REG_CLR);
> +}
> +
> +static void mxs_lradc_reg_wrt(struct mxs_lradc *lradc, u32 val, u32 reg)
> +{
> +	writel(val, lradc->base + reg);
> +}
> +
> +static u32 mxs_lradc_plate_mask(struct mxs_lradc *lradc)
> +{
> +	return LRADC_CTRL0_MX28_PLATE_MASK;
> +}
> +
> +static u32 mxs_lradc_irq_en_mask(struct mxs_lradc *lradc)
> +{
> +	return LRADC_CTRL1_MX28_LRADC_IRQ_EN_MASK;
> +}
> +
> +static u32 mxs_lradc_irq_mask(struct mxs_lradc *lradc)
> +{
> +	return LRADC_CTRL1_MX28_LRADC_IRQ_MASK;
> +}
> +
> +static u32 mxs_lradc_touch_detect_bit(struct mxs_lradc *lradc)
> +{
> +	return LRADC_CTRL0_MX28_TOUCH_DETECT_ENABLE;
> +}
> +
> +static u32 mxs_lradc_drive_x_plate(struct mxs_lradc *lradc)
> +{
> +	return LRADC_CTRL0_MX28_XPPSW | LRADC_CTRL0_MX28_XNNSW;
> +}
> +
> +static u32 mxs_lradc_drive_y_plate(struct mxs_lradc *lradc)
> +{
> +	return LRADC_CTRL0_MX28_YPPSW | LRADC_CTRL0_MX28_YNNSW;
> +}
> +
> +static u32 mxs_lradc_drive_pressure(struct mxs_lradc *lradc)
> +{
> +	return LRADC_CTRL0_MX28_YPPSW | LRADC_CTRL0_MX28_XNNSW;
> +}
> +
>  /*
>   * Raw I/O operations
>   */
> @@ -272,21 +322,19 @@ static int mxs_lradc_read_raw(struct iio_dev *iio_dev,
>  	 * Virtual channel 0 is always used here as the others are always not
>  	 * used if doing raw sampling.
>  	 */
> -	writel(LRADC_CTRL1_MX28_LRADC_IRQ_EN_MASK,
> -		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
> -	writel(0xff, lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
> +	mxs_lradc_reg_clear(lradc, LRADC_CTRL1_MX28_LRADC_IRQ_EN_MASK,
> +			LRADC_CTRL1);
> +	mxs_lradc_reg_clear(lradc, 0xff, LRADC_CTRL0);
>  
>  	/* Clean the slot's previous content, then set new one. */
> -	writel(LRADC_CTRL4_LRADCSELECT_MASK(0),
> -		lradc->base + LRADC_CTRL4 + STMP_OFFSET_REG_CLR);
> -	writel(chan->channel, lradc->base + LRADC_CTRL4 + STMP_OFFSET_REG_SET);
> +	mxs_lradc_reg_clear(lradc, LRADC_CTRL4_LRADCSELECT_MASK(0), LRADC_CTRL4);
> +	mxs_lradc_reg_set(lradc, chan->channel, LRADC_CTRL4);
>  
> -	writel(0, lradc->base + LRADC_CH(0));
> +	mxs_lradc_reg_wrt(lradc, 0, LRADC_CH(0));
>  
>  	/* Enable the IRQ and start sampling the channel. */
> -	writel(LRADC_CTRL1_LRADC_IRQ_EN(0),
> -		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_SET);
> -	writel(1 << 0, lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_SET);
> +	mxs_lradc_reg_set(lradc, LRADC_CTRL1_LRADC_IRQ_EN(0), LRADC_CTRL1);
> +	mxs_lradc_reg_set(lradc, 1 << 0, LRADC_CTRL0);
>  
>  	/* Wait for completion on the channel, 1 second max. */
>  	ret = wait_for_completion_killable_timeout(&lradc->completion, HZ);
> @@ -300,8 +348,7 @@ static int mxs_lradc_read_raw(struct iio_dev *iio_dev,
>  	ret = IIO_VAL_INT;
>  
>  err:
> -	writel(LRADC_CTRL1_LRADC_IRQ_EN(0),
> -		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
> +	mxs_lradc_reg_clear(lradc, LRADC_CTRL1_LRADC_IRQ_EN(0), LRADC_CTRL1);
>  
>  	mutex_unlock(&lradc->lock);
>  
> @@ -327,10 +374,9 @@ static int mxs_lradc_ts_touched(struct mxs_lradc *lradc)
>  	uint32_t reg;
>  
>  	/* Enable touch detection. */
> -	writel(LRADC_CTRL0_MX28_PLATE_MASK,
> -		lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
> -	writel(LRADC_CTRL0_MX28_TOUCH_DETECT_ENABLE,
> -		lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_SET);
> +	mxs_lradc_reg_clear(lradc, mxs_lradc_plate_mask(lradc), LRADC_CTRL0);
> +	mxs_lradc_reg_set(lradc, mxs_lradc_touch_detect_bit(lradc),
> +								LRADC_CTRL0);
>  
>  	msleep(LRADC_TS_SAMPLE_DELAY_MS);
>  
> @@ -375,32 +421,33 @@ static int32_t mxs_lradc_ts_sample(struct mxs_lradc *lradc,
>  	 */
>  	switch (plate) {
>  	case LRADC_SAMPLE_X:
> -		ctrl0 = LRADC_CTRL0_MX28_XPPSW | LRADC_CTRL0_MX28_XNNSW;
> +		ctrl0 = mxs_lradc_drive_x_plate(lradc);
>  		chan = 3;
>  		break;
>  	case LRADC_SAMPLE_Y:
> -		ctrl0 = LRADC_CTRL0_MX28_YPPSW | LRADC_CTRL0_MX28_YNNSW;
> +		ctrl0 = mxs_lradc_drive_y_plate(lradc);
>  		chan = 4;
>  		break;
>  	case LRADC_SAMPLE_PRESSURE:
> -		ctrl0 = LRADC_CTRL0_MX28_YPPSW | LRADC_CTRL0_MX28_XNNSW;
> +		ctrl0 = mxs_lradc_drive_pressure(lradc);
>  		chan = 5;
>  		break;
>  	}
>  
>  	if (change) {
> -		writel(LRADC_CTRL0_MX28_PLATE_MASK,
> -			lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
> -		writel(ctrl0, lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_SET);
> -
> -		writel(LRADC_CTRL4_LRADCSELECT_MASK(slot),
> -			lradc->base + LRADC_CTRL4 + STMP_OFFSET_REG_CLR);
> -		writel(chan << LRADC_CTRL4_LRADCSELECT_OFFSET(slot),
> -			lradc->base + LRADC_CTRL4 + STMP_OFFSET_REG_SET);
> +		mxs_lradc_reg_clear(lradc, mxs_lradc_plate_mask(lradc),
> +						LRADC_CTRL0);
> +		mxs_lradc_reg_set(lradc, ctrl0, LRADC_CTRL0);
> +
> +		mxs_lradc_reg_clear(lradc, LRADC_CTRL4_LRADCSELECT_MASK(slot),
> +						LRADC_CTRL4);
> +		mxs_lradc_reg_set(lradc,
> +				chan << LRADC_CTRL4_LRADCSELECT_OFFSET(slot),
> +				LRADC_CTRL4);
>  	}
>  
> -	writel(0xffffffff, lradc->base + LRADC_CH(slot) + STMP_OFFSET_REG_CLR);
> -	writel(1 << slot, lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_SET);
> +	mxs_lradc_reg_clear(lradc, 0xffffffff, LRADC_CH(slot));
> +	mxs_lradc_reg_set(lradc, 1 << slot, LRADC_CTRL0);
>  
>  	delay = jiffies + msecs_to_jiffies(LRADC_TS_SAMPLE_DELAY_MS);
>  	do {
> @@ -410,8 +457,7 @@ static int32_t mxs_lradc_ts_sample(struct mxs_lradc *lradc,
>  			break;
>  	} while (time_before(jiff, delay));
>  
> -	writel(LRADC_CTRL1_LRADC_IRQ(slot),
> -		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
> +	mxs_lradc_reg_clear(lradc, LRADC_CTRL1_LRADC_IRQ(slot), LRADC_CTRL1);
>  
>  	if (time_after_eq(jiff, delay))
>  		return -ETIMEDOUT;
> @@ -450,8 +496,8 @@ static void mxs_lradc_ts_work(struct work_struct *ts_work)
>  
>  	while (mxs_lradc_ts_touched(lradc)) {
>  		/* Disable touch detector so we can sample the touchscreen. */
> -		writel(LRADC_CTRL0_MX28_TOUCH_DETECT_ENABLE,
> -			lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
> +		mxs_lradc_reg_clear(lradc, mxs_lradc_touch_detect_bit(lradc),
> +						LRADC_CTRL0);
>  
>  		if (likely(valid)) {
>  			input_report_abs(lradc->ts_input, ABS_X, val_x);
> @@ -485,10 +531,8 @@ static void mxs_lradc_ts_work(struct work_struct *ts_work)
>  		return;
>  
>  	/* Restart the touchscreen interrupts. */
> -	writel(LRADC_CTRL1_TOUCH_DETECT_IRQ,
> -		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
> -	writel(LRADC_CTRL1_TOUCH_DETECT_IRQ_EN,
> -		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_SET);
> +	mxs_lradc_reg_clear(lradc, LRADC_CTRL1_TOUCH_DETECT_IRQ, LRADC_CTRL1);
> +	mxs_lradc_reg_set(lradc, LRADC_CTRL1_TOUCH_DETECT_IRQ_EN, LRADC_CTRL1);
>  }
>  
>  static int mxs_lradc_ts_open(struct input_dev *dev)
> @@ -499,12 +543,11 @@ static int mxs_lradc_ts_open(struct input_dev *dev)
>  	lradc->stop_touchscreen = false;
>  
>  	/* Enable the touch-detect circuitry. */
> -	writel(LRADC_CTRL0_MX28_TOUCH_DETECT_ENABLE,
> -		lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_SET);
> +	mxs_lradc_reg_set(lradc, mxs_lradc_touch_detect_bit(lradc),
> +						LRADC_CTRL0);
>  
>  	/* Enable the touch-detect IRQ. */
> -	writel(LRADC_CTRL1_TOUCH_DETECT_IRQ_EN,
> -		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_SET);
> +	mxs_lradc_reg_set(lradc, LRADC_CTRL1_TOUCH_DETECT_IRQ_EN, LRADC_CTRL1);
>  
>  	return 0;
>  }
> @@ -521,12 +564,11 @@ static void mxs_lradc_ts_close(struct input_dev *dev)
>  	cancel_work_sync(&lradc->ts_work);
>  
>  	/* Disable touchscreen touch-detect IRQ. */
> -	writel(LRADC_CTRL1_TOUCH_DETECT_IRQ_EN,
> -		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
> +	mxs_lradc_reg_clear(lradc, LRADC_CTRL1_TOUCH_DETECT_IRQ_EN,
> +						LRADC_CTRL1);
>  
>  	/* Power-down touchscreen touch-detect circuitry. */
> -	writel(LRADC_CTRL0_MX28_TOUCH_DETECT_ENABLE,
> -		lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
> +	mxs_lradc_reg_clear(lradc, mxs_lradc_touch_detect_bit(lradc), LRADC_CTRL0);
>  }
>  
>  static int mxs_lradc_ts_register(struct mxs_lradc *lradc)
> @@ -589,7 +631,7 @@ static irqreturn_t mxs_lradc_handle_irq(int irq, void *data)
>  		LRADC_CTRL1_TOUCH_DETECT_IRQ_EN |
>  		LRADC_CTRL1_TOUCH_DETECT_IRQ;
>  
> -	if (!(reg & LRADC_CTRL1_MX28_LRADC_IRQ_MASK))
> +	if (!(reg & mxs_lradc_irq_mask(lradc)))
>  		return IRQ_NONE;
>  
>  	/*
> @@ -598,8 +640,7 @@ static irqreturn_t mxs_lradc_handle_irq(int irq, void *data)
>  	 * it ASAP
>  	 */
>  	if (reg & LRADC_CTRL1_TOUCH_DETECT_IRQ) {
> -		writel(ts_irq_mask,
> -			lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
> +		mxs_lradc_reg_clear(lradc, ts_irq_mask, LRADC_CTRL1);
>  		if (!lradc->stop_touchscreen)
>  			schedule_work(&lradc->ts_work);
>  	}
> @@ -609,8 +650,7 @@ static irqreturn_t mxs_lradc_handle_irq(int irq, void *data)
>  	else if (reg & LRADC_CTRL1_LRADC_IRQ(0))
>  		complete(&lradc->completion);
>  
> -	writel(reg & LRADC_CTRL1_MX28_LRADC_IRQ_MASK,
> -		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
> +	mxs_lradc_reg_clear(lradc, reg & mxs_lradc_irq_mask(lradc), LRADC_CTRL1);
>  
>  	return IRQ_HANDLED;
>  }
> @@ -629,7 +669,7 @@ static irqreturn_t mxs_lradc_trigger_handler(int irq, void *p)
>  
>  	for_each_set_bit(i, iio->active_scan_mask, LRADC_MAX_TOTAL_CHANS) {
>  		lradc->buffer[j] = readl(lradc->base + LRADC_CH(j));
> -		writel(chan_value, lradc->base + LRADC_CH(j));
> +		mxs_lradc_reg_wrt(lradc, chan_value, LRADC_CH(j));
>  		lradc->buffer[j] &= LRADC_CH_VALUE_MASK;
>  		lradc->buffer[j] /= LRADC_DELAY_TIMER_LOOP;
>  		j++;
> @@ -654,7 +694,7 @@ static int mxs_lradc_configure_trigger(struct iio_trigger *trig, bool state)
>  	struct mxs_lradc *lradc = iio_priv(iio);
>  	const uint32_t st = state ? STMP_OFFSET_REG_SET : STMP_OFFSET_REG_CLR;
>  
> -	writel(LRADC_DELAY_KICK, lradc->base + LRADC_DELAY(0) + st);
> +	mxs_lradc_reg_wrt(lradc, LRADC_DELAY_KICK, LRADC_DELAY(0) + st);
>  
>  	return 0;
>  }
> @@ -730,29 +770,26 @@ static int mxs_lradc_buffer_preenable(struct iio_dev *iio)
>  	if (ret < 0)
>  		goto err_buf;
>  
> -	writel(LRADC_CTRL1_MX28_LRADC_IRQ_EN_MASK,
> -		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
> -	writel(0xff, lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
> +	mxs_lradc_reg_clear(lradc, LRADC_CTRL1_MX28_LRADC_IRQ_EN_MASK,
> +							LRADC_CTRL1);
> +	mxs_lradc_reg_clear(lradc, 0xff, LRADC_CTRL0);
>  
>  	for_each_set_bit(chan, iio->active_scan_mask, LRADC_MAX_TOTAL_CHANS) {
>  		ctrl4_set |= chan << LRADC_CTRL4_LRADCSELECT_OFFSET(ofs);
>  		ctrl4_clr |= LRADC_CTRL4_LRADCSELECT_MASK(ofs);
>  		ctrl1_irq |= LRADC_CTRL1_LRADC_IRQ_EN(ofs);
> -		writel(chan_value, lradc->base + LRADC_CH(ofs));
> +		mxs_lradc_reg_wrt(lradc, chan_value, LRADC_CH(ofs));
>  		bitmap_set(&enable, ofs, 1);
>  		ofs++;
>  	}
>  
> -	writel(LRADC_DELAY_TRIGGER_LRADCS_MASK | LRADC_DELAY_KICK,
> -		lradc->base + LRADC_DELAY(0) + STMP_OFFSET_REG_CLR);
> -
> -	writel(ctrl4_clr, lradc->base + LRADC_CTRL4 + STMP_OFFSET_REG_CLR);
> -	writel(ctrl4_set, lradc->base + LRADC_CTRL4 + STMP_OFFSET_REG_SET);
> -
> -	writel(ctrl1_irq, lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_SET);
> -
> -	writel(enable << LRADC_DELAY_TRIGGER_LRADCS_OFFSET,
> -		lradc->base + LRADC_DELAY(0) + STMP_OFFSET_REG_SET);
> +	mxs_lradc_reg_clear(lradc, LRADC_DELAY_TRIGGER_LRADCS_MASK |
> +					LRADC_DELAY_KICK, LRADC_DELAY(0));
> +	mxs_lradc_reg_clear(lradc, ctrl4_clr, LRADC_CTRL4);
> +	mxs_lradc_reg_set(lradc, ctrl4_set, LRADC_CTRL4);
> +	mxs_lradc_reg_set(lradc, ctrl1_irq, LRADC_CTRL1);
> +	mxs_lradc_reg_set(lradc, enable << LRADC_DELAY_TRIGGER_LRADCS_OFFSET,
> +					LRADC_DELAY(0));
>  
>  	return 0;
>  
> @@ -767,12 +804,12 @@ static int mxs_lradc_buffer_postdisable(struct iio_dev *iio)
>  {
>  	struct mxs_lradc *lradc = iio_priv(iio);
>  
> -	writel(LRADC_DELAY_TRIGGER_LRADCS_MASK | LRADC_DELAY_KICK,
> -		lradc->base + LRADC_DELAY(0) + STMP_OFFSET_REG_CLR);
> +	mxs_lradc_reg_clear(lradc, LRADC_DELAY_TRIGGER_LRADCS_MASK |
> +					LRADC_DELAY_KICK, LRADC_DELAY(0));
>  
> -	writel(0xff, lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
> -	writel(LRADC_CTRL1_MX28_LRADC_IRQ_EN_MASK,
> -		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
> +	mxs_lradc_reg_clear(lradc, 0xff, LRADC_CTRL0);
> +	mxs_lradc_reg_clear(lradc, LRADC_CTRL1_MX28_LRADC_IRQ_EN_MASK,
> +					LRADC_CTRL1);
>  
>  	kfree(lradc->buffer);
>  	mutex_unlock(&lradc->lock);
> @@ -867,24 +904,24 @@ static int mxs_lradc_hw_init(struct mxs_lradc *lradc)
>  		return ret;
>  
>  	/* Configure DELAY CHANNEL 0 for generic ADC sampling. */
> -	writel(adc_cfg, lradc->base + LRADC_DELAY(0));
> +	mxs_lradc_reg_wrt(lradc, adc_cfg, LRADC_DELAY(0));
>  
>  	/* Disable remaining DELAY CHANNELs */
> -	writel(0, lradc->base + LRADC_DELAY(1));
> -	writel(0, lradc->base + LRADC_DELAY(2));
> -	writel(0, lradc->base + LRADC_DELAY(3));
> +	mxs_lradc_reg_wrt(lradc, 0, LRADC_DELAY(1));
> +	mxs_lradc_reg_wrt(lradc, 0, LRADC_DELAY(2));
> +	mxs_lradc_reg_wrt(lradc, 0, LRADC_DELAY(3));
>  
>  	/* Configure the touchscreen type */
> -	writel(LRADC_CTRL0_MX28_TOUCH_SCREEN_TYPE,
> -		lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
> +	mxs_lradc_reg_clear(lradc, LRADC_CTRL0_MX28_TOUCH_SCREEN_TYPE,
> +							LRADC_CTRL0);
>  
> -	if (lradc->use_touchscreen == MXS_LRADC_TOUCHSCREEN_5WIRE) {
> -		writel(LRADC_CTRL0_MX28_TOUCH_SCREEN_TYPE,
> -			lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_SET);
> +	if (lradc->use_touchscreen == MXS_LRADC_TOUCHSCREEN_5WIRE)
> +		mxs_lradc_reg_set(lradc, LRADC_CTRL0_MX28_TOUCH_SCREEN_TYPE,
> +				LRADC_CTRL0);
>  	}
>  
>  	/* Start internal temperature sensing. */
> -	writel(0, lradc->base + LRADC_CTRL2);
> +	mxs_lradc_reg_wrt(lradc, 0, LRADC_CTRL2);
>  
>  	return 0;
>  }
> @@ -893,11 +930,10 @@ static void mxs_lradc_hw_stop(struct mxs_lradc *lradc)
>  {
>  	int i;
>  
> -	writel(LRADC_CTRL1_MX28_LRADC_IRQ_EN_MASK,
> -		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
> +	mxs_lradc_reg_clear(lradc, mxs_lradc_irq_en_mask(lradc), LRADC_CTRL1);
>  
>  	for (i = 0; i < LRADC_MAX_DELAY_CHANS; i++)
> -		writel(0, lradc->base + LRADC_DELAY(i));
> +		mxs_lradc_reg_wrt(lradc, 0, LRADC_DELAY(i));
>  }
>  
>  static const struct of_device_id mxs_lradc_dt_ids[] = {
> 
