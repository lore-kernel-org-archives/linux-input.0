From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 7/9] Staging/iio/adc/touchscreen/MXS: remove old
 touchscreen detection implementation
Date: Tue, 01 Oct 2013 12:13:40 +0100
Message-ID: <524AAE64.4060706@kernel.org>
References: <1379946998-23041-1-git-send-email-jbe@pengutronix.de>
 <1379946998-23041-8-git-send-email-jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <1379946998-23041-8-git-send-email-jbe@pengutronix.de>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Juergen Beisert <jbe@pengutronix.de>, linux-iio@vger.kernel.org
Cc: devel@driverdev.osuosl.org, marex@denx.de, fabio.estevam@freescale.com, jic23@cam.ac.uk, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

On 09/23/13 15:36, Juergen Beisert wrote:
> Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
> CC: linux-arm-kernel@lists.infradead.org
> CC: linux-input@vger.kernel.org
> CC: devel@driverdev.osuosl.org
> CC: Marek Vasut <marex@denx.de>
> CC: Fabio Estevam <fabio.estevam@freescale.com>
> CC: Jonathan Cameron <jic23@cam.ac.uk>
Applied to the togreg branch of iio.git
Thanks,
> ---
>  drivers/staging/iio/adc/mxs-lradc.c | 163 ------------------------------------
>  1 file changed, 163 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
> index 76a900d..aa1f337 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -186,7 +186,6 @@ struct mxs_lradc {
>  	bool			use_touchbutton;
>  
>  	struct input_dev	*ts_input;
> -	struct work_struct	ts_work;
>  
>  	enum mxs_lradc_id	soc;
>  	enum lradc_ts_plate	cur_plate; /* statemachine */
> @@ -830,168 +829,6 @@ static const struct iio_info mxs_lradc_iio_info = {
>  	.read_raw		= mxs_lradc_read_raw,
>  };
>  
> -static int mxs_lradc_ts_touched(struct mxs_lradc *lradc)
> -{
> -	uint32_t reg;
> -
> -	/* Enable touch detection. */
> -	mxs_lradc_reg_clear(lradc, mxs_lradc_plate_mask(lradc), LRADC_CTRL0);
> -	mxs_lradc_reg_set(lradc, mxs_lradc_touch_detect_bit(lradc),
> -								LRADC_CTRL0);
> -
> -	msleep(LRADC_TS_SAMPLE_DELAY_MS);
> -
> -	reg = readl(lradc->base + LRADC_STATUS);
> -
> -	return reg & LRADC_STATUS_TOUCH_DETECT_RAW;
> -}
> -
> -static int32_t mxs_lradc_ts_sample(struct mxs_lradc *lradc,
> -				enum lradc_ts_plate plate, int change)
> -{
> -	unsigned long delay, jiff;
> -	uint32_t reg, ctrl0 = 0, chan = 0;
> -	/* The touchscreen always uses CTRL4 slot #7. */
> -	const uint8_t slot = 7;
> -	uint32_t val;
> -
> -	/*
> -	 * There are three correct configurations of the controller sampling
> -	 * the touchscreen, each of these configuration provides different
> -	 * information from the touchscreen.
> -	 *
> -	 * The following table describes the sampling configurations:
> -	 * +-------------+-------+-------+-------+
> -	 * | Wire \ Axis |   X   |   Y   |   Z   |
> -	 * +---------------------+-------+-------+
> -	 * |   X+ (CH2)  |   HI  |   TS  |   TS  |
> -	 * +-------------+-------+-------+-------+
> -	 * |   X- (CH4)  |   LO  |   SH  |   HI  |
> -	 * +-------------+-------+-------+-------+
> -	 * |   Y+ (CH3)  |   SH  |   HI  |   HI  |
> -	 * +-------------+-------+-------+-------+
> -	 * |   Y- (CH5)  |   TS  |   LO  |   SH  |
> -	 * +-------------+-------+-------+-------+
> -	 *
> -	 * HI ... strong '1'  ; LO ... strong '0'
> -	 * SH ... sample here ; TS ... tri-state
> -	 *
> -	 * There are a few other ways of obtaining the Z coordinate
> -	 * (aka. pressure), but the one in the table seems to be the
> -	 * most reliable one.
> -	 */
> -	switch (plate) {
> -	case LRADC_SAMPLE_X:
> -		ctrl0 = mxs_lradc_drive_x_plate(lradc);
> -		chan = 3;
> -		break;
> -	case LRADC_SAMPLE_Y:
> -		ctrl0 = mxs_lradc_drive_y_plate(lradc);
> -		chan = 4;
> -		break;
> -	case LRADC_SAMPLE_PRESSURE:
> -		ctrl0 = mxs_lradc_drive_pressure(lradc);
> -		chan = 5;
> -		break;
> -	}
> -
> -	if (change) {
> -		mxs_lradc_reg_clear(lradc, mxs_lradc_plate_mask(lradc),
> -						LRADC_CTRL0);
> -		mxs_lradc_reg_set(lradc, ctrl0, LRADC_CTRL0);
> -
> -		mxs_lradc_reg_clear(lradc, LRADC_CTRL4_LRADCSELECT_MASK(slot),
> -						LRADC_CTRL4);
> -		mxs_lradc_reg_set(lradc,
> -				chan << LRADC_CTRL4_LRADCSELECT_OFFSET(slot),
> -				LRADC_CTRL4);
> -	}
> -
> -	mxs_lradc_reg_clear(lradc, 0xffffffff, LRADC_CH(slot));
> -	mxs_lradc_reg_set(lradc, 1 << slot, LRADC_CTRL0);
> -
> -	delay = jiffies + msecs_to_jiffies(LRADC_TS_SAMPLE_DELAY_MS);
> -	do {
> -		jiff = jiffies;
> -		reg = readl_relaxed(lradc->base + LRADC_CTRL1);
> -		if (reg & LRADC_CTRL1_LRADC_IRQ(slot))
> -			break;
> -	} while (time_before(jiff, delay));
> -
> -	mxs_lradc_reg_clear(lradc, LRADC_CTRL1_LRADC_IRQ(slot), LRADC_CTRL1);
> -
> -	if (time_after_eq(jiff, delay))
> -		return -ETIMEDOUT;
> -
> -	val = readl(lradc->base + LRADC_CH(slot));
> -	val &= LRADC_CH_VALUE_MASK;
> -
> -	return val;
> -}
> -
> -static int32_t mxs_lradc_ts_sample_filter(struct mxs_lradc *lradc,
> -				enum lradc_ts_plate plate)
> -{
> -	int32_t val, tot = 0;
> -	int i;
> -
> -	val = mxs_lradc_ts_sample(lradc, plate, 1);
> -
> -	/* Delay a bit so the touchscreen is stable. */
> -	mdelay(2);
> -
> -	for (i = 0; i < LRADC_TS_SAMPLE_AMOUNT; i++) {
> -		val = mxs_lradc_ts_sample(lradc, plate, 0);
> -		tot += val;
> -	}
> -
> -	return tot / LRADC_TS_SAMPLE_AMOUNT;
> -}
> -
> -static void mxs_lradc_ts_work(struct work_struct *ts_work)
> -{
> -	struct mxs_lradc *lradc = container_of(ts_work,
> -				struct mxs_lradc, ts_work);
> -	int val_x, val_y, val_p;
> -	bool valid = false;
> -
> -	while (mxs_lradc_ts_touched(lradc)) {
> -		/* Disable touch detector so we can sample the touchscreen. */
> -		mxs_lradc_reg_clear(lradc, mxs_lradc_touch_detect_bit(lradc),
> -						LRADC_CTRL0);
> -
> -		if (likely(valid)) {
> -			input_report_abs(lradc->ts_input, ABS_X, val_x);
> -			input_report_abs(lradc->ts_input, ABS_Y, val_y);
> -			input_report_abs(lradc->ts_input, ABS_PRESSURE, val_p);
> -			input_report_key(lradc->ts_input, BTN_TOUCH, 1);
> -			input_sync(lradc->ts_input);
> -		}
> -
> -		valid = false;
> -
> -		val_x = mxs_lradc_ts_sample_filter(lradc, LRADC_SAMPLE_X);
> -		if (val_x < 0)
> -			continue;
> -		val_y = mxs_lradc_ts_sample_filter(lradc, LRADC_SAMPLE_Y);
> -		if (val_y < 0)
> -			continue;
> -		val_p = mxs_lradc_ts_sample_filter(lradc, LRADC_SAMPLE_PRESSURE);
> -		if (val_p < 0)
> -			continue;
> -
> -		valid = true;
> -	}
> -
> -	input_report_abs(lradc->ts_input, ABS_PRESSURE, 0);
> -	input_report_key(lradc->ts_input, BTN_TOUCH, 0);
> -	input_sync(lradc->ts_input);
> -
> -	/* Restart the touchscreen interrupts. */
> -	mxs_lradc_reg_clear(lradc, LRADC_CTRL1_TOUCH_DETECT_IRQ, LRADC_CTRL1);
> -	mxs_lradc_reg_set(lradc, LRADC_CTRL1_TOUCH_DETECT_IRQ_EN, LRADC_CTRL1);
> -}
> -
>  static int mxs_lradc_ts_open(struct input_dev *dev)
>  {
>  	struct mxs_lradc *lradc = input_get_drvdata(dev);
> 
