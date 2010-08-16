From: Ryan Mallon <ryan@bluewatersys.com>
Subject: Re: [PATCH] input/touch: Introduce the LPC32xx touchscreen controller
	driver (v2)
Date: Tue, 17 Aug 2010 10:09:12 +1200
Message-ID: <4C69B708.3020008@bluewatersys.com>
References: <1281993661-21097-1-git-send-email-wellsk40@gmail.com>
	<1281993661-21097-2-git-send-email-wellsk40@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1281993661-21097-2-git-send-email-wellsk40@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: wellsk40@gmail.com
Cc: linux-arm-kernel@lists.infradead.org, Durgesh Pattamatta <durgesh.pattamatta@nxp.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 08/17/2010 09:21 AM, wellsk40@gmail.com wrote:
> From: Kevin Wells <wellsk40@gmail.com>
> 
> This patch set introduces support for the LPC32xx touchscreen
> controller driver. The LPC32xx touchscreen controller supports
> automated event detection and X/Y data conversion for resistive
> touchscreens.

Hi Kevin,

A few comments below.

> +
> +#define LPC32XX_TSC_ADCCON_IRQ_TO_FIFO_4	(0x1 << 11)
> +#define LPC32XX_TSC_ADCCON_X_SAMPLE_SIZE(s)	((10 - (s)) << 7)
> +#define LPC32XX_TSC_ADCCON_Y_SAMPLE_SIZE(s)	((10 - (s)) << 4)
> +#define LPC32XX_TSC_ADCCON_POWER_UP		(1 << 2)
> +#define LPC32XX_TSC_ADCCON_AUTO_EN		(1 << 0)
> +
> +#define LPC32XX_TSC_FIFO_TS_P_LEVEL		(1 << 31)
> +#define LPC32XX_TSC_FIFO_NORMALIZE_X_VAL(x)	(((x) & 0x03FF0000) >> 16)
> +#define LPC32XX_TSC_FIFO_NORMALIZE_Y_VAL(y)	((y) & 0x000003FF)

Some of these names are really long which causes lots of line breaks in
the code. Can you shorten some of the names to make it more readable.

> +#define LPC32XX_TSC_ADCDAT_VALUE_MASK		0x000003FF
> +
> +#define LPC32XX_TSC_MIN_XY_VAL			0x0
> +#define LPC32XX_TSC_MAX_XY_VAL			0x3FF
> +
> +#define MOD_NAME "ts-lpc32xx"
> +
> +#define tsc_readl(dev, reg) \
> +	__raw_readl((dev)->tsc_base + (reg))
> +#define tsc_writel(dev, reg, val) \
> +	__raw_writel((val), (dev)->tsc_base + (reg))

inline functions are better for this sort of thing.

> +
> +struct lpc32xx_tsc {
> +	struct input_dev *dev;
> +	void __iomem *tsc_base;
> +	int irq;
> +	struct clk *clk;
> +};

(Nitpicky) Tab delimit this to make it a bit more readable.

> +static void lpc32xx_fifo_clear(struct lpc32xx_tsc *tsc)
> +{
> +	while (!(tsc_readl(tsc, LPC32XX_TSC_STAT) &
> +			   LPC32XX_TSC_STAT_FIFO_EMPTY))
> +		tsc_readl(tsc, LPC32XX_TSC_FIFO);
> +}

The FIFO_EMTPY bit gets used a couple of times, so maybe:

	static inline tsc_fifo_empty(struct lpc32xx_tsc *tsc)
	{
		return tsc_readl(tsc, LPC32XX_TSC_STAT) &
			         LPC32XX_TSC_STAT_FIFO_EMPTY;
	}

Also, is it worth having a timeout on that while loop so that if the i2c
bus dies or something that you don't get stuck there forever?

> +static irqreturn_t lpc32xx_ts_interrupt(int irq, void *dev_id)
> +{
> +	u32 tmp, rv[4], xs[4], ys[4];
> +	int idx;
> +	struct lpc32xx_tsc *tsc = dev_id;
> +	struct input_dev *input = tsc->dev;
> +
> +	tmp = tsc_readl(tsc, LPC32XX_TSC_STAT);
> +
> +	if (tmp & LPC32XX_TSC_STAT_FIFO_OVRRN) {
> +		/* FIFO overflow - throw away samples */

Should there be a dev_err/warn here to let the user know?

> +		lpc32xx_fifo_clear(tsc);
> +		return IRQ_HANDLED;
> +	}
> +
> +	/*
> +	 * Gather and normalize 4 samples. Pen-up events may have less
> +	 * than 4 samples, but its ok to pop 4 and let the last sample
> +	 * pen status check drop the samples.
> +	 */
> +	idx = 0;
> +	while ((idx < 4) &&
> +		(!(tsc_readl(tsc, LPC32XX_TSC_STAT) &
> +			     LPC32XX_TSC_STAT_FIFO_EMPTY))) {

	for (idx = 0; idx < 4 && !tsc_fifo_empty(); idx++) {
		...

Is a bit more readable.

> +		tmp = tsc_readl(tsc, LPC32XX_TSC_FIFO);
> +		xs[idx] = LPC32XX_TSC_ADCDAT_VALUE_MASK -
> +			LPC32XX_TSC_FIFO_NORMALIZE_X_VAL(tmp);
> +		ys[idx] = LPC32XX_TSC_ADCDAT_VALUE_MASK -
> +			LPC32XX_TSC_FIFO_NORMALIZE_Y_VAL(tmp);
> +		rv[idx] = tmp;
> +		idx++;
> +	}
> +
> +	/* Data is only valid if pen is still down in last sample */
> +	if ((!(rv[3] & LPC32XX_TSC_FIFO_TS_P_LEVEL)) && (idx == 4)) {
> +		/* Use average of 2nd and 3rd sample for position */
> +		input_report_abs(input, ABS_X, ((xs[1] + xs[2]) / 2));
> +		input_report_abs(input, ABS_Y, ((ys[1] + ys[2]) / 2));
> +		input_report_key(input, BTN_TOUCH, 1);
> +	} else {
> +		input_report_key(input, BTN_TOUCH, 0);
> +	}
> +
> +	input_sync(input);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void lpc32xx_stop_tsc(struct lpc32xx_tsc *tsc)
> +{
> +	/* Disable auto mode */
> +	tsc_writel(tsc, LPC32XX_TSC_CON,
> +		   tsc_readl(tsc, LPC32XX_TSC_CON) &
> +			     ~LPC32XX_TSC_ADCCON_AUTO_EN);
> +
> +	clk_disable(tsc->clk);
> +}
> +
> +static void lpc32xx_setup_tsc(struct lpc32xx_tsc *tsc)
> +{
> +	u32 tmp;
> +
> +	clk_enable(tsc->clk);
> +
> +	tmp = tsc_readl(tsc, LPC32XX_TSC_CON) & ~LPC32XX_TSC_ADCCON_POWER_UP;
> +
> +	/* Set the TSC FIFO depth to 4 samples @ 10-bits per sample (max) */
> +	tmp = (LPC32XX_TSC_ADCCON_IRQ_TO_FIFO_4 |
> +		LPC32XX_TSC_ADCCON_X_SAMPLE_SIZE(10) |
> +		LPC32XX_TSC_ADCCON_Y_SAMPLE_SIZE(10));
> +	tsc_writel(tsc, LPC32XX_TSC_CON, tmp);
> +
> +	/* These values are all preset */
> +	tsc_writel(tsc, LPC32XX_TSC_SEL, LPC32XX_TSC_SEL_DEFVAL);
> +	tsc_writel(tsc, LPC32XX_TSC_MIN_X, LPC32XX_TSC_MIN_XY_VAL);
> +	tsc_writel(tsc, LPC32XX_TSC_MAX_X, LPC32XX_TSC_MAX_XY_VAL);
> +	tsc_writel(tsc, LPC32XX_TSC_MIN_Y, LPC32XX_TSC_MIN_XY_VAL);
> +	tsc_writel(tsc, LPC32XX_TSC_MAX_Y, LPC32XX_TSC_MAX_XY_VAL);
> +
> +	/* Aux support is not used */
> +	tsc_writel(tsc, LPC32XX_TSC_AUX_UTR, 0);
> +	tsc_writel(tsc, LPC32XX_TSC_AUX_MIN, 0);
> +	tsc_writel(tsc, LPC32XX_TSC_AUX_MAX, 0);
> +
> +	/*
> +	 * Set sample rate to about 240Hz per X/Y pair. A single measurement
> +	 * consists of 4 pairs which gives about a 60Hz sample rate based on
> +	 * a stable 32768Hz clock source. Values are in clocks.
> +	 * Rate is (32768 / (RTR + XCONV + RTR + YCONV + DXP + TTR + UTR) / 4
> +	 */

Is the clock source internal, or at least always 32.768kHz? If not,
should the timing be controlled via some platform data so that this
driver is compatible with other board setups?

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan@bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
