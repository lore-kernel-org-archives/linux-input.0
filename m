From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 5/9] Staging/iio/adc/touchscreen/MXS: add i.MX23 support
 to the LRADC touchscreen driver
Date: Tue, 01 Oct 2013 12:02:37 +0100
Message-ID: <524AABCD.9040707@kernel.org>
References: <1379946998-23041-1-git-send-email-jbe@pengutronix.de> <1379946998-23041-6-git-send-email-jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53864 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752983Ab3JAKCK (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Oct 2013 06:02:10 -0400
In-Reply-To: <1379946998-23041-6-git-send-email-jbe@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Juergen Beisert <jbe@pengutronix.de>, linux-iio@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org, marex@denx.de, fabio.estevam@freescale.com, jic23@cam.ac.uk, linux-input@vger.kernel.org

On 09/23/13 15:36, Juergen Beisert wrote:
> Distinguish i.MX23 and i.MX28 at runtime and do the same for both SoC at least
> for the 4 wire touchscreen.
> 
> Note: support for the remaining LRADC channels is not tested on an
> i.MX23 yet.
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
> ---
>  drivers/staging/iio/adc/mxs-lradc.c | 66 ++++++++++++++++++++++++++++++-------
>  1 file changed, 55 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
> index dd47ec2..a92e810 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -191,20 +191,33 @@ struct mxs_lradc {
>  # define LRADC_CTRL0_MX28_XNPSW	/* XM */	(1 << 17)
>  # define LRADC_CTRL0_MX28_XPPSW	/* XP */	(1 << 16)
>  
> +# define LRADC_CTRL0_MX23_TOUCH_DETECT_ENABLE	(1 << 20)
> +# define LRADC_CTRL0_MX23_YM			(1 << 19)
> +# define LRADC_CTRL0_MX23_XM			(1 << 18)
> +# define LRADC_CTRL0_MX23_YP			(1 << 17)
> +# define LRADC_CTRL0_MX23_XP			(1 << 16)
> +
>  # define LRADC_CTRL0_MX28_PLATE_MASK \
>  		(LRADC_CTRL0_MX28_TOUCH_DETECT_ENABLE | \
>  		LRADC_CTRL0_MX28_YNNSW | LRADC_CTRL0_MX28_YPNSW | \
>  		LRADC_CTRL0_MX28_YPPSW | LRADC_CTRL0_MX28_XNNSW | \
>  		LRADC_CTRL0_MX28_XNPSW | LRADC_CTRL0_MX28_XPPSW)
>  
> +# define LRADC_CTRL0_MX23_PLATE_MASK \
> +		(LRADC_CTRL0_MX23_TOUCH_DETECT_ENABLE | \
> +		LRADC_CTRL0_MX23_YM | LRADC_CTRL0_MX23_XM | \
> +		LRADC_CTRL0_MX23_YP | LRADC_CTRL0_MX23_XP)
> +
>  #define	LRADC_CTRL1				0x10
>  #define	LRADC_CTRL1_TOUCH_DETECT_IRQ_EN		(1 << 24)
>  #define	LRADC_CTRL1_LRADC_IRQ_EN(n)		(1 << ((n) + 16))
>  #define	LRADC_CTRL1_MX28_LRADC_IRQ_EN_MASK	(0x1fff << 16)
> +#define	LRADC_CTRL1_MX23_LRADC_IRQ_EN_MASK	(0x01ff << 16)
>  #define	LRADC_CTRL1_LRADC_IRQ_EN_OFFSET		16
>  #define	LRADC_CTRL1_TOUCH_DETECT_IRQ		(1 << 8)
>  #define	LRADC_CTRL1_LRADC_IRQ(n)		(1 << (n))
>  #define	LRADC_CTRL1_MX28_LRADC_IRQ_MASK		0x1fff
> +#define	LRADC_CTRL1_MX23_LRADC_IRQ_MASK		0x01ff
>  #define	LRADC_CTRL1_LRADC_IRQ_OFFSET		0
>  
>  #define	LRADC_CTRL2				0x20
> @@ -255,37 +268,58 @@ static void mxs_lradc_reg_wrt(struct mxs_lradc *lradc, u32 val, u32 reg)
>  
>  static u32 mxs_lradc_plate_mask(struct mxs_lradc *lradc)
>  {
> -	return LRADC_CTRL0_MX28_PLATE_MASK;
> +	if (lradc->soc == IMX23_LRADC)
> +		return LRADC_CTRL0_MX23_PLATE_MASK;
> +	else
> +		return LRADC_CTRL0_MX28_PLATE_MASK;
>  }
>  
>  static u32 mxs_lradc_irq_en_mask(struct mxs_lradc *lradc)
>  {
> -	return LRADC_CTRL1_MX28_LRADC_IRQ_EN_MASK;
> +	if (lradc->soc == IMX23_LRADC)
> +		return LRADC_CTRL1_MX23_LRADC_IRQ_EN_MASK;
> +	else
> +		return LRADC_CTRL1_MX28_LRADC_IRQ_EN_MASK;
>  }
>  
>  static u32 mxs_lradc_irq_mask(struct mxs_lradc *lradc)
>  {
> -	return LRADC_CTRL1_MX28_LRADC_IRQ_MASK;
> +	if (lradc->soc == IMX23_LRADC)
> +		return LRADC_CTRL1_MX23_LRADC_IRQ_MASK;
> +	else
> +		return LRADC_CTRL1_MX28_LRADC_IRQ_MASK;
>  }
>  
>  static u32 mxs_lradc_touch_detect_bit(struct mxs_lradc *lradc)
>  {
> -	return LRADC_CTRL0_MX28_TOUCH_DETECT_ENABLE;
> +	if (lradc->soc == IMX23_LRADC)
> +		return LRADC_CTRL0_MX23_TOUCH_DETECT_ENABLE;
> +	else
> +		return LRADC_CTRL0_MX28_TOUCH_DETECT_ENABLE;
>  }
>  
>  static u32 mxs_lradc_drive_x_plate(struct mxs_lradc *lradc)
>  {
> -	return LRADC_CTRL0_MX28_XPPSW | LRADC_CTRL0_MX28_XNNSW;
> +	if (lradc->soc == IMX23_LRADC)
> +		return LRADC_CTRL0_MX23_XP | LRADC_CTRL0_MX23_XM;
> +	else
> +		return LRADC_CTRL0_MX28_XPPSW | LRADC_CTRL0_MX28_XNNSW;
>  }
>  
>  static u32 mxs_lradc_drive_y_plate(struct mxs_lradc *lradc)
>  {
> -	return LRADC_CTRL0_MX28_YPPSW | LRADC_CTRL0_MX28_YNNSW;
> +	if (lradc->soc == IMX23_LRADC)
> +		return LRADC_CTRL0_MX23_YP | LRADC_CTRL0_MX23_YM;
> +	else
> +		return LRADC_CTRL0_MX28_YPPSW | LRADC_CTRL0_MX28_YNNSW;
>  }
>  
>  static u32 mxs_lradc_drive_pressure(struct mxs_lradc *lradc)
>  {
> -	return LRADC_CTRL0_MX28_YPPSW | LRADC_CTRL0_MX28_XNNSW;
> +	if (lradc->soc == IMX23_LRADC)
> +		return LRADC_CTRL0_MX23_YP | LRADC_CTRL0_MX23_XM;
> +	else
> +		return LRADC_CTRL0_MX28_YPPSW | LRADC_CTRL0_MX28_XNNSW;
>  }
>  
>  /*
> @@ -322,7 +356,8 @@ static int mxs_lradc_read_raw(struct iio_dev *iio_dev,
>  	 * Virtual channel 0 is always used here as the others are always not
>  	 * used if doing raw sampling.
>  	 */
> -	mxs_lradc_reg_clear(lradc, LRADC_CTRL1_MX28_LRADC_IRQ_EN_MASK,
> +	if (lradc->soc == IMX28_LRADC)
> +		mxs_lradc_reg_clear(lradc, LRADC_CTRL1_MX28_LRADC_IRQ_EN_MASK,
>  			LRADC_CTRL1);
>  	mxs_lradc_reg_clear(lradc, 0xff, LRADC_CTRL0);
>  
> @@ -770,7 +805,8 @@ static int mxs_lradc_buffer_preenable(struct iio_dev *iio)
>  	if (ret < 0)
>  		goto err_buf;
>  
> -	mxs_lradc_reg_clear(lradc, LRADC_CTRL1_MX28_LRADC_IRQ_EN_MASK,
> +	if (lradc->soc == IMX28_LRADC)
> +		mxs_lradc_reg_clear(lradc, LRADC_CTRL1_MX28_LRADC_IRQ_EN_MASK,
>  							LRADC_CTRL1);
>  	mxs_lradc_reg_clear(lradc, 0xff, LRADC_CTRL0);
>  
> @@ -808,7 +844,8 @@ static int mxs_lradc_buffer_postdisable(struct iio_dev *iio)
>  					LRADC_DELAY_KICK, LRADC_DELAY(0));
>  
>  	mxs_lradc_reg_clear(lradc, 0xff, LRADC_CTRL0);
> -	mxs_lradc_reg_clear(lradc, LRADC_CTRL1_MX28_LRADC_IRQ_EN_MASK,
> +	if (lradc->soc == IMX28_LRADC)
> +		mxs_lradc_reg_clear(lradc, LRADC_CTRL1_MX28_LRADC_IRQ_EN_MASK,
>  					LRADC_CTRL1);
>  
>  	kfree(lradc->buffer);
> @@ -912,7 +949,8 @@ static int mxs_lradc_hw_init(struct mxs_lradc *lradc)
>  	mxs_lradc_reg_wrt(lradc, 0, LRADC_DELAY(3));
>  
>  	/* Configure the touchscreen type */
> -	mxs_lradc_reg_clear(lradc, LRADC_CTRL0_MX28_TOUCH_SCREEN_TYPE,
> +	if (lradc->soc == IMX28_LRADC) {
> +		mxs_lradc_reg_clear(lradc, LRADC_CTRL0_MX28_TOUCH_SCREEN_TYPE,
>  							LRADC_CTRL0);
>  
>  	if (lradc->use_touchscreen == MXS_LRADC_TOUCHSCREEN_5WIRE)
> @@ -993,6 +1031,12 @@ static int mxs_lradc_probe(struct platform_device *pdev)
>  		dev_warn(dev, "Unsupported number of touchscreen wires (%d)\n",
>  				ts_wires);
>  
> +	if ((lradc->soc == IMX23_LRADC) && (ts_wires == 5)) {
> +		dev_warn(dev, "No support for 5 wire touches on i.MX23\n");
> +		dev_warn(dev, "Falling back to 4 wire\n");
> +		ts_wires = 4;
> +	}
> +
>  	/* Grab all IRQ sources */
>  	for (i = 0; i < of_cfg->irq_count; i++) {
>  		lradc->irq[i] = platform_get_irq(pdev, i);
> 
