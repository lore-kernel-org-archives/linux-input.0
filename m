From: Josh Wu <josh.wu@atmel.com>
Subject: Re: [PATCH 3/3] iio: at91: introduce touch screen support in iio
 adc driver
Date: Thu, 17 Oct 2013 13:20:52 +0800
Message-ID: <525F73B4.3050305@atmel.com>
References: <1381204136-32322-1-git-send-email-josh.wu@atmel.com>
 <1381204136-32322-4-git-send-email-josh.wu@atmel.com>
 <5255B918.2020705@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5255B918.2020705@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: dmitry.torokhov@gmail.com
Cc: thomas.petazzoni@free-electrons.com, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-iio@vger.kernel.org, nicolas.ferre@atmel.com, b.brezillon@overkiz.com, Jonathan Cameron <jic23@kernel.org>, linux-input@vger.kernel.org, maxime.ripard@free-electrons.com, plagnioj@jcrosoft.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

Hi, Dimitry

Could give some feedback for this v4  patch if you have time? Since It 
has been stuck for a while.
Thanks.

Best Regards,
Josh Wu

On 10/10/2013 4:14 AM, Jonathan Cameron wrote:
> On 10/08/13 04:48, Josh Wu wrote:
>> AT91 ADC hardware integrate touch screen support. So this patch add touch
>> screen support for at91 adc iio driver.
>> To enable touch screen support in adc, you need to add the dt parameters:
>>    1. which type of touch are used? (4 or 5 wires), sample period time.
>>    2. correct pressure detect threshold value.
>>
>> In the meantime, since touch screen will use a interal period trigger of adc,
>> so it is conflict to other hardware triggers. Driver will disable the hardware
>> trigger support if touch screen is enabled.
>>
>> This driver has been tested in AT91SAM9X5-EK and SAMA5D3x-EK.
>>
>> Signed-off-by: Josh Wu <josh.wu@atmel.com>
>> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> CC: devicetree@vger.kernel.org
> Hi Josh.  I am not going to take this for now both because I want to have
> a close read of it when I have more time and because I want input from
> Dmitry on this one.
>
> Thanks,
>
> Jonathan
>> ---
>>   .../devicetree/bindings/arm/atmel-adc.txt          |    7 +
>>   arch/arm/mach-at91/include/mach/at91_adc.h         |   34 ++
>>   drivers/iio/adc/at91_adc.c                         |  388 ++++++++++++++++++--
>>   3 files changed, 405 insertions(+), 24 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/atmel-adc.txt b/Documentation/devicetree/bindings/arm/atmel-adc.txt
>> index 0e65e01..d106146 100644
>> --- a/Documentation/devicetree/bindings/arm/atmel-adc.txt
>> +++ b/Documentation/devicetree/bindings/arm/atmel-adc.txt
>> @@ -23,6 +23,13 @@ Optional properties:
>>   		       resolution will be used.
>>     - atmel,adc-sleep-mode: Boolean to enable sleep mode when no conversion
>>     - atmel,adc-sample-hold-time: Sample and Hold Time in microseconds
>> +  - atmel,adc-ts-wires: Number of touch screen wires. Should be 4 or 5. If this
>> +                        value is set, then adc driver will enable touch screen
>> +                        support.
>> +    NOTE: when adc touch screen enabled, the adc hardware trigger will be
>> +          disabled. Since touch screen will occupied the trigger register.
>> +  - atmel,adc-ts-pressure-threshold: a pressure threshold for touchscreen. It
>> +                                     make touch detect more precision.
>>    
>>   Optional trigger Nodes:
>>     - Required properties:
>> diff --git a/arch/arm/mach-at91/include/mach/at91_adc.h b/arch/arm/mach-at91/include/mach/at91_adc.h
>> index 048a57f..c287307 100644
>> --- a/arch/arm/mach-at91/include/mach/at91_adc.h
>> +++ b/arch/arm/mach-at91/include/mach/at91_adc.h
>> @@ -60,14 +60,48 @@
>>   #define AT91_ADC_IER		0x24		/* Interrupt Enable Register */
>>   #define AT91_ADC_IDR		0x28		/* Interrupt Disable Register */
>>   #define AT91_ADC_IMR		0x2C		/* Interrupt Mask Register */
>> +#define		AT91_ADC_IER_PEN	(1 << 29)
>> +#define		AT91_ADC_IER_NOPEN	(1 << 30)
>> +#define		AT91_ADC_IER_XRDY	(1 << 20)
>> +#define		AT91_ADC_IER_YRDY	(1 << 21)
>> +#define		AT91_ADC_IER_PRDY	(1 << 22)
>> +#define		AT91_ADC_ISR_PENS	(1 << 31)
>>   
>>   #define AT91_ADC_CHR(n)		(0x30 + ((n) * 4))	/* Channel Data Register N */
>>   #define		AT91_ADC_DATA		(0x3ff)
>>   
>>   #define AT91_ADC_CDR0_9X5	(0x50)			/* Channel Data Register 0 for 9X5 */
>>   
>> +#define AT91_ADC_ACR		0x94	/* Analog Control Register */
>> +#define		AT91_ADC_ACR_PENDETSENS	(0x3 << 0)	/* pull-up resistor */
>> +
>> +#define AT91_ADC_TSMR		0xB0
>> +#define		AT91_ADC_TSMR_TSMODE	(3 << 0)	/* Touch Screen Mode */
>> +#define			AT91_ADC_TSMR_TSMODE_NONE		(0 << 0)
>> +#define			AT91_ADC_TSMR_TSMODE_4WIRE_NO_PRESS	(1 << 0)
>> +#define			AT91_ADC_TSMR_TSMODE_4WIRE_PRESS	(2 << 0)
>> +#define			AT91_ADC_TSMR_TSMODE_5WIRE		(3 << 0)
>> +#define		AT91_ADC_TSMR_TSAV	(3 << 4)	/* Averages samples */
>> +#define			AT91_ADC_TSMR_TSAV_(x)		((x) << 4)
>> +#define		AT91_ADC_TSMR_SCTIM	(0x0f << 16)	/* Switch closure time */
>> +#define		AT91_ADC_TSMR_PENDBC	(0x0f << 28)	/* Pen Debounce time */
>> +#define			AT91_ADC_TSMR_PENDBC_(x)	((x) << 28)
>> +#define		AT91_ADC_TSMR_NOTSDMA	(1 << 22)	/* No Touchscreen DMA */
>> +#define		AT91_ADC_TSMR_PENDET_DIS	(0 << 24)	/* Pen contact detection disable */
>> +#define		AT91_ADC_TSMR_PENDET_ENA	(1 << 24)	/* Pen contact detection enable */
>> +
>> +#define AT91_ADC_TSXPOSR	0xB4
>> +#define AT91_ADC_TSYPOSR	0xB8
>> +#define AT91_ADC_TSPRESSR	0xBC
>> +
>>   #define AT91_ADC_TRGR_9260	AT91_ADC_MR
>>   #define AT91_ADC_TRGR_9G45	0x08
>>   #define AT91_ADC_TRGR_9X5	0xC0
>>   
>> +/* Trigger Register bit field */
>> +#define		AT91_ADC_TRGR_TRGPER	(0xffff << 16)
>> +#define			AT91_ADC_TRGR_TRGPER_(x)	((x) << 16)
>> +#define		AT91_ADC_TRGR_TRGMOD	(0x7 << 0)
>> +#define			AT91_ADC_TRGR_MOD_PERIOD_TRIG	(5 << 0)
>> +
>>   #endif
>> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
>> index 22cf61d2..68ddd7f 100644
>> --- a/drivers/iio/adc/at91_adc.c
>> +++ b/drivers/iio/adc/at91_adc.c
>> @@ -11,6 +11,7 @@
>>   #include <linux/clk.h>
>>   #include <linux/err.h>
>>   #include <linux/io.h>
>> +#include <linux/input.h>
>>   #include <linux/interrupt.h>
>>   #include <linux/jiffies.h>
>>   #include <linux/kernel.h>
>> @@ -39,7 +40,23 @@
>>   #define at91_adc_writel(st, reg, val) \
>>   	(writel_relaxed(val, st->reg_base + reg))
>>   
>> +#define DRIVER_NAME		"at91_adc"
>> +#define MAX_POS_BITS		12
>> +
>> +#define TOUCH_SAMPLE_PERIOD_US		2000	/* 2ms */
>> +#define TOUCH_PEN_DETECT_DEBOUNCE_US	200
>> +
>>   struct at91_adc_caps {
>> +	bool	has_ts;		/* Support touch screen */
>> +	bool	has_tsmr;	/* only at91sam9x5, sama5d3 have TSMR reg */
>> +	/*
>> +	 * Numbers of sampling data will be averaged. Can be 0~3.
>> +	 * Hardware can average (2 ^ ts_filter_average) sample data.
>> +	 */
>> +	u8	ts_filter_average;
>> +	/* Pen Detection input pull-up resistor, can be 0~3 */
>> +	u8	ts_pen_detect_sensitivity;
>> +
>>   	/* startup time calculate function */
>>   	u32 (*calc_startup_ticks)(u8 startup_time, u32 adc_clk_khz);
>>   
>> @@ -47,6 +64,12 @@ struct at91_adc_caps {
>>   	struct at91_adc_reg_desc registers;
>>   };
>>   
>> +enum atmel_adc_ts_type {
>> +	ATMEL_ADC_TOUCHSCREEN_NONE = 0,
>> +	ATMEL_ADC_TOUCHSCREEN_4WIRE = 4,
>> +	ATMEL_ADC_TOUCHSCREEN_5WIRE = 5,
>> +};
>> +
>>   struct at91_adc_state {
>>   	struct clk		*adc_clk;
>>   	u16			*buffer;
>> @@ -71,6 +94,26 @@ struct at91_adc_state {
>>   	bool			low_res;	/* the resolution corresponds to the lowest one */
>>   	wait_queue_head_t	wq_data_avail;
>>   	struct at91_adc_caps	*caps;
>> +
>> +	/*
>> +	 * Following ADC channels are shared by touchscreen:
>> +	 *
>> +	 * CH0 -- Touch screen XP/UL
>> +	 * CH1 -- Touch screen XM/UR
>> +	 * CH2 -- Touch screen YP/LL
>> +	 * CH3 -- Touch screen YM/Sense
>> +	 * CH4 -- Touch screen LR(5-wire only)
>> +	 *
>> +	 * The bitfields below represents the reserved channel in the
>> +	 * touchscreen mode.
>> +	 */
>> +#define CHAN_MASK_TOUCHSCREEN_4WIRE	(0xf << 0)
>> +#define CHAN_MASK_TOUCHSCREEN_5WIRE	(0x1f << 0)
>> +	enum atmel_adc_ts_type	touchscreen_type;
>> +	struct input_dev	*ts_input;
>> +
>> +	u16			ts_sample_period_val;
>> +	u32			ts_pressure_threshold;
>>   };
>>   
>>   static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
>> @@ -105,14 +148,10 @@ static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
>>   	return IRQ_HANDLED;
>>   }
>>   
>> -static irqreturn_t at91_adc_eoc_trigger(int irq, void *private)
>> +/* Handler for classic adc channel eoc trigger */
>> +void handle_adc_eoc_trigger(int irq, struct iio_dev *idev)
>>   {
>> -	struct iio_dev *idev = private;
>>   	struct at91_adc_state *st = iio_priv(idev);
>> -	u32 status = at91_adc_readl(st, st->registers->status_register);
>> -
>> -	if (!(status & st->registers->drdy_mask))
>> -		return IRQ_HANDLED;
>>   
>>   	if (iio_buffer_enabled(idev)) {
>>   		disable_irq_nosync(irq);
>> @@ -122,6 +161,115 @@ static irqreturn_t at91_adc_eoc_trigger(int irq, void *private)
>>   		st->done = true;
>>   		wake_up_interruptible(&st->wq_data_avail);
>>   	}
>> +}
>> +
>> +static int at91_ts_sample(struct at91_adc_state *st)
>> +{
>> +	unsigned int xscale, yscale, reg, z1, z2;
>> +	unsigned int x, y, pres, xpos, ypos;
>> +	unsigned int rxp = 1;
>> +	unsigned int factor = 1000;
>> +	struct iio_dev *idev = iio_priv_to_dev(st);
>> +
>> +	unsigned int xyz_mask_bits = st->res;
>> +	unsigned int xyz_mask = (1 << xyz_mask_bits) - 1;
>> +
>> +	/* calculate position */
>> +	/* x position = (x / xscale) * max, max = 2^MAX_POS_BITS - 1 */
>> +	reg = at91_adc_readl(st, AT91_ADC_TSXPOSR);
>> +	xpos = reg & xyz_mask;
>> +	x = (xpos << MAX_POS_BITS) - xpos;
>> +	xscale = (reg >> 16) & xyz_mask;
>> +	if (xscale == 0) {
>> +		dev_err(&idev->dev, "Error: xscale == 0!\n");
>> +		return -1;
>> +	}
>> +	x /= xscale;
>> +
>> +	/* y position = (y / yscale) * max, max = 2^MAX_POS_BITS - 1 */
>> +	reg = at91_adc_readl(st, AT91_ADC_TSYPOSR);
>> +	ypos = reg & xyz_mask;
>> +	y = (ypos << MAX_POS_BITS) - ypos;
>> +	yscale = (reg >> 16) & xyz_mask;
>> +	if (yscale == 0) {
>> +		dev_err(&idev->dev, "Error: yscale == 0!\n");
>> +		return -1;
>> +	}
>> +	y /= yscale;
>> +
>> +	/* calculate the pressure */
>> +	reg = at91_adc_readl(st, AT91_ADC_TSPRESSR);
>> +	z1 = reg & xyz_mask;
>> +	z2 = (reg >> 16) & xyz_mask;
>> +
>> +	if (z1 != 0)
>> +		pres = rxp * (x * factor / 1024) * (z2 * factor / z1 - factor)
>> +			/ factor;
>> +	else
>> +		pres = st->ts_pressure_threshold;	/* no pen contacted */
>> +
>> +	dev_dbg(&idev->dev, "xpos = %d, xscale = %d, ypos = %d, yscale = %d, z1 = %d, z2 = %d, press = %d\n",
>> +				xpos, xscale, ypos, yscale, z1, z2, pres);
>> +
>> +	if (pres < st->ts_pressure_threshold) {
>> +		dev_dbg(&idev->dev, "x = %d, y = %d, pressure = %d\n",
>> +					x, y, pres / factor);
>> +		input_report_abs(st->ts_input, ABS_X, x);
>> +		input_report_abs(st->ts_input, ABS_Y, y);
>> +		input_report_abs(st->ts_input, ABS_PRESSURE, pres);
>> +		input_report_key(st->ts_input, BTN_TOUCH, 1);
>> +		input_sync(st->ts_input);
>> +	} else {
>> +		dev_dbg(&idev->dev, "pressure too low: not reporting\n");
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static irqreturn_t at91_adc_interrupt(int irq, void *private)
>> +{
>> +	struct iio_dev *idev = private;
>> +	struct at91_adc_state *st = iio_priv(idev);
>> +	u32 status = at91_adc_readl(st, st->registers->status_register);
>> +	const uint32_t ts_data_irq_mask =
>> +		AT91_ADC_IER_XRDY |
>> +		AT91_ADC_IER_YRDY |
>> +		AT91_ADC_IER_PRDY;
>> +
>> +	if (status & st->registers->drdy_mask)
>> +		handle_adc_eoc_trigger(irq, idev);
>> +
>> +	if (status & AT91_ADC_IER_PEN) {
>> +		at91_adc_writel(st, AT91_ADC_IDR, AT91_ADC_IER_PEN);
>> +		at91_adc_writel(st, AT91_ADC_IER, AT91_ADC_IER_NOPEN |
>> +			ts_data_irq_mask);
>> +		/* Set up period trigger for sampling */
>> +		at91_adc_writel(st, st->registers->trigger_register,
>> +			AT91_ADC_TRGR_MOD_PERIOD_TRIG |
>> +			AT91_ADC_TRGR_TRGPER_(st->ts_sample_period_val));
>> +	} else if (status & AT91_ADC_IER_NOPEN) {
>> +		at91_adc_writel(st, st->registers->trigger_register, 0);
>> +		at91_adc_writel(st, AT91_ADC_IDR, AT91_ADC_IER_NOPEN |
>> +			ts_data_irq_mask);
>> +		at91_adc_writel(st, AT91_ADC_IER, AT91_ADC_IER_PEN);
>> +
>> +		input_report_key(st->ts_input, BTN_TOUCH, 0);
>> +		input_sync(st->ts_input);
>> +	} else if ((status & ts_data_irq_mask) == ts_data_irq_mask) {
>> +		/* Now all touchscreen data is ready */
>> +
>> +		if (status & AT91_ADC_ISR_PENS) {
>> +			/* validate data by pen contact */
>> +			at91_ts_sample(st);
>> +		} else {
>> +			/* triggered by event that is no pen contact, just read
>> +			 * them to clean the interrupt and discard all.
>> +			 */
>> +			at91_adc_readl(st, AT91_ADC_TSXPOSR);
>> +			at91_adc_readl(st, AT91_ADC_TSYPOSR);
>> +			at91_adc_readl(st, AT91_ADC_TSPRESSR);
>> +		}
>> +	}
>>   
>>   	return IRQ_HANDLED;
>>   }
>> @@ -131,6 +279,16 @@ static int at91_adc_channel_init(struct iio_dev *idev)
>>   	struct at91_adc_state *st = iio_priv(idev);
>>   	struct iio_chan_spec *chan_array, *timestamp;
>>   	int bit, idx = 0;
>> +	unsigned long rsvd_mask = 0;
>> +
>> +	/* If touchscreen is enable, then reserve the adc channels */
>> +	if (st->touchscreen_type == ATMEL_ADC_TOUCHSCREEN_4WIRE)
>> +		rsvd_mask = CHAN_MASK_TOUCHSCREEN_4WIRE;
>> +	else if (st->touchscreen_type == ATMEL_ADC_TOUCHSCREEN_5WIRE)
>> +		rsvd_mask = CHAN_MASK_TOUCHSCREEN_5WIRE;
>> +
>> +	/* set up the channel mask to reserve touchscreen channels */
>> +	st->channels_mask &= ~rsvd_mask;
>>   
>>   	idev->num_channels = bitmap_weight(&st->channels_mask,
>>   					   st->num_channels) + 1;
>> @@ -479,6 +637,39 @@ static u32 calc_startup_ticks_9x5(u8 startup_time, u32 adc_clk_khz)
>>   
>>   static const struct of_device_id at91_adc_dt_ids[];
>>   
>> +static int at91_adc_probe_dt_ts(struct device_node *node,
>> +	struct at91_adc_state *st, struct device *dev)
>> +{
>> +	int ret;
>> +	u32 prop;
>> +
>> +	ret = of_property_read_u32(node, "atmel,adc-ts-wires", &prop);
>> +	if (ret) {
>> +		dev_info(dev, "ADC Touch screen is disabled.\n");
>> +		return 0;
>> +	}
>> +
>> +	switch (prop) {
>> +	case 4:
>> +	case 5:
>> +		st->touchscreen_type = prop;
>> +		break;
>> +	default:
>> +		dev_err(dev, "Unsupported number of touchscreen wires (%d). Should be 4 or 5.\n", prop);
>> +		return -EINVAL;
>> +	}
>> +
>> +	prop = 0;
>> +	of_property_read_u32(node, "atmel,adc-ts-pressure-threshold", &prop);
>> +	st->ts_pressure_threshold = prop;
>> +	if (st->ts_pressure_threshold) {
>> +		return 0;
>> +	} else {
>> +		dev_err(dev, "Invalid pressure threshold for the touchscreen\n");
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>>   static int at91_adc_probe_dt(struct at91_adc_state *st,
>>   			     struct platform_device *pdev)
>>   {
>> @@ -560,6 +751,12 @@ static int at91_adc_probe_dt(struct at91_adc_state *st,
>>   		i++;
>>   	}
>>   
>> +	/* Check if touchscreen is supported. */
>> +	if (st->caps->has_ts)
>> +		return at91_adc_probe_dt_ts(node, st, &idev->dev);
>> +	else
>> +		dev_info(&idev->dev, "not support touchscreen in the adc compatible string.\n");
>> +
>>   	return 0;
>>   
>>   error_ret:
>> @@ -591,6 +788,114 @@ static const struct iio_info at91_adc_info = {
>>   	.read_raw = &at91_adc_read_raw,
>>   };
>>   
>> +/* Touchscreen related functions */
>> +static int atmel_ts_open(struct input_dev *dev)
>> +{
>> +	struct at91_adc_state *st = input_get_drvdata(dev);
>> +
>> +	at91_adc_writel(st, AT91_ADC_IER, AT91_ADC_IER_PEN);
>> +	return 0;
>> +}
>> +
>> +static void atmel_ts_close(struct input_dev *dev)
>> +{
>> +	struct at91_adc_state *st = input_get_drvdata(dev);
>> +
>> +	at91_adc_writel(st, AT91_ADC_IDR, AT91_ADC_IER_PEN);
>> +}
>> +
>> +static int at91_ts_hw_init(struct at91_adc_state *st, u32 adc_clk_khz)
>> +{
>> +	u32 reg = 0, pendbc;
>> +	int i = 0;
>> +
>> +	if (st->touchscreen_type == ATMEL_ADC_TOUCHSCREEN_4WIRE)
>> +		reg = AT91_ADC_TSMR_TSMODE_4WIRE_PRESS;
>> +	else
>> +		reg = AT91_ADC_TSMR_TSMODE_5WIRE;
>> +
>> +	/* a Pen Detect Debounce Time is necessary for the ADC Touch to avoid
>> +	 * pen detect noise.
>> +	 * The formula is : Pen Detect Debounce Time = (2 ^ pendbc) / ADCClock
>> +	 */
>> +	pendbc = round_up(TOUCH_PEN_DETECT_DEBOUNCE_US * adc_clk_khz / 1000, 1);
>> +
>> +	while (pendbc >> ++i)
>> +		;	/* Empty! Find the shift offset */
>> +	if (abs(pendbc - (1 << i)) < abs(pendbc - (1 << (i - 1))))
>> +		pendbc = i;
>> +	else
>> +		pendbc = i - 1;
>> +
>> +	if (st->caps->has_tsmr) {
>> +		reg |= AT91_ADC_TSMR_TSAV_(st->caps->ts_filter_average)
>> +				& AT91_ADC_TSMR_TSAV;
>> +		reg |= AT91_ADC_TSMR_PENDBC_(pendbc) & AT91_ADC_TSMR_PENDBC;
>> +		reg |= AT91_ADC_TSMR_NOTSDMA;
>> +		reg |= AT91_ADC_TSMR_PENDET_ENA;
>> +		reg |= 0x03 << 8;	/* TSFREQ, need bigger than TSAV */
>> +
>> +		at91_adc_writel(st, AT91_ADC_TSMR, reg);
>> +	} else {
>> +		/* TODO: for 9g45 which has no TSMR */
>> +	}
>> +
>> +	/* Change adc internal resistor value for better pen detection,
>> +	 * default value is 100 kOhm.
>> +	 * 0 = 200 kOhm, 1 = 150 kOhm, 2 = 100 kOhm, 3 = 50 kOhm
>> +	 * option only available on ES2 and higher
>> +	 */
>> +	at91_adc_writel(st, AT91_ADC_ACR, st->caps->ts_pen_detect_sensitivity
>> +			& AT91_ADC_ACR_PENDETSENS);
>> +
>> +	/* Sample Peroid Time = (TRGPER + 1) / ADCClock */
>> +	st->ts_sample_period_val = round_up((TOUCH_SAMPLE_PERIOD_US *
>> +			adc_clk_khz / 1000) - 1, 1);
>> +
>> +	return 0;
>> +}
>> +
>> +static int at91_ts_register(struct at91_adc_state *st,
>> +		struct platform_device *pdev)
>> +{
>> +	struct input_dev *input;
>> +	struct iio_dev *idev = iio_priv_to_dev(st);
>> +	int ret;
>> +
>> +	input = input_allocate_device();
>> +	if (!input) {
>> +		dev_err(&idev->dev, "Failed to allocate TS device!\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	input->name = DRIVER_NAME;
>> +	input->id.bustype = BUS_HOST;
>> +	input->dev.parent = &pdev->dev;
>> +	input->open = atmel_ts_open;
>> +	input->close = atmel_ts_close;
>> +
>> +	__set_bit(EV_ABS, input->evbit);
>> +	__set_bit(EV_KEY, input->evbit);
>> +	__set_bit(BTN_TOUCH, input->keybit);
>> +	input_set_abs_params(input, ABS_X, 0, (1 << MAX_POS_BITS) - 1, 0, 0);
>> +	input_set_abs_params(input, ABS_Y, 0, (1 << MAX_POS_BITS) - 1, 0, 0);
>> +	input_set_abs_params(input, ABS_PRESSURE, 0, 0xffffff, 0, 0);
>> +
>> +	st->ts_input = input;
>> +	input_set_drvdata(input, st);
>> +
>> +	ret = input_register_device(input);
>> +	if (ret)
>> +		input_free_device(st->ts_input);
>> +
>> +	return ret;
>> +}
>> +
>> +static void at91_ts_unregister(struct at91_adc_state *st)
>> +{
>> +	input_unregister_device(st->ts_input);
>> +}
>> +
>>   static int at91_adc_probe(struct platform_device *pdev)
>>   {
>>   	unsigned int prsc, mstrclk, ticks, adc_clk, adc_clk_khz, shtim;
>> @@ -642,7 +947,7 @@ static int at91_adc_probe(struct platform_device *pdev)
>>   	at91_adc_writel(st, AT91_ADC_CR, AT91_ADC_SWRST);
>>   	at91_adc_writel(st, AT91_ADC_IDR, 0xFFFFFFFF);
>>   	ret = request_irq(st->irq,
>> -			  at91_adc_eoc_trigger,
>> +			  at91_adc_interrupt,
>>   			  0,
>>   			  pdev->dev.driver->name,
>>   			  idev);
>> @@ -687,6 +992,10 @@ static int at91_adc_probe(struct platform_device *pdev)
>>   	mstrclk = clk_get_rate(st->clk);
>>   	adc_clk = clk_get_rate(st->adc_clk);
>>   	adc_clk_khz = adc_clk / 1000;
>> +
>> +	dev_dbg(&pdev->dev, "Master clock is set as: %d Hz, adc_clk should set as: %d Hz\n",
>> +		mstrclk, adc_clk);
>> +
>>   	prsc = (mstrclk / (2 * adc_clk)) - 1;
>>   
>>   	if (!st->startup_time) {
>> @@ -723,30 +1032,52 @@ static int at91_adc_probe(struct platform_device *pdev)
>>   	init_waitqueue_head(&st->wq_data_avail);
>>   	mutex_init(&st->lock);
>>   
>> -	ret = at91_adc_buffer_init(idev);
>> -	if (ret < 0) {
>> -		dev_err(&pdev->dev, "Couldn't initialize the buffer.\n");
>> -		goto error_disable_adc_clk;
>> -	}
>> +	/*
>> +	 * Since touch screen will set trigger register as period trigger. So
>> +	 * when touch screen is enabled, then we have to disable hardware
>> +	 * trigger for classic adc.
>> +	 */
>> +	if (!st->touchscreen_type) {
>> +		ret = at91_adc_buffer_init(idev);
>> +		if (ret < 0) {
>> +			dev_err(&pdev->dev, "Couldn't initialize the buffer.\n");
>> +			goto error_disable_adc_clk;
>> +		}
>>   
>> -	ret = at91_adc_trigger_init(idev);
>> -	if (ret < 0) {
>> -		dev_err(&pdev->dev, "Couldn't setup the triggers.\n");
>> -		goto error_unregister_buffer;
>> +		ret = at91_adc_trigger_init(idev);
>> +		if (ret < 0) {
>> +			dev_err(&pdev->dev, "Couldn't setup the triggers.\n");
>> +			at91_adc_buffer_remove(idev);
>> +			goto error_disable_adc_clk;
>> +		}
>> +	} else {
>> +		if (!st->caps->has_tsmr) {
>> +			dev_err(&pdev->dev, "We don't support non-TSMR adc\n");
>> +			goto error_disable_adc_clk;
>> +		}
>> +
>> +		ret = at91_ts_register(st, pdev);
>> +		if (ret)
>> +			goto error_disable_adc_clk;
>> +
>> +		at91_ts_hw_init(st, adc_clk_khz);
>>   	}
>>   
>>   	ret = iio_device_register(idev);
>>   	if (ret < 0) {
>>   		dev_err(&pdev->dev, "Couldn't register the device.\n");
>> -		goto error_remove_triggers;
>> +		goto error_iio_device_register;
>>   	}
>>   
>>   	return 0;
>>   
>> -error_remove_triggers:
>> -	at91_adc_trigger_remove(idev);
>> -error_unregister_buffer:
>> -	at91_adc_buffer_remove(idev);
>> +error_iio_device_register:
>> +	if (!st->touchscreen_type) {
>> +		at91_adc_trigger_remove(idev);
>> +		at91_adc_buffer_remove(idev);
>> +	} else {
>> +		at91_ts_unregister(st);
>> +	}
>>   error_disable_adc_clk:
>>   	clk_disable_unprepare(st->adc_clk);
>>   error_disable_clk:
>> @@ -762,8 +1093,12 @@ static int at91_adc_remove(struct platform_device *pdev)
>>   	struct at91_adc_state *st = iio_priv(idev);
>>   
>>   	iio_device_unregister(idev);
>> -	at91_adc_trigger_remove(idev);
>> -	at91_adc_buffer_remove(idev);
>> +	if (!st->touchscreen_type) {
>> +		at91_adc_trigger_remove(idev);
>> +		at91_adc_buffer_remove(idev);
>> +	} else {
>> +		at91_ts_unregister(st);
>> +	}
>>   	clk_disable_unprepare(st->adc_clk);
>>   	clk_disable_unprepare(st->clk);
>>   	free_irq(st->irq, idev);
>> @@ -786,6 +1121,7 @@ static struct at91_adc_caps at91sam9260_caps = {
>>   };
>>   
>>   static struct at91_adc_caps at91sam9g45_caps = {
>> +	.has_ts = true,
>>   	.calc_startup_ticks = calc_startup_ticks_9260,	/* same as 9260 */
>>   	.num_channels = 8,
>>   	.registers = {
>> @@ -799,6 +1135,10 @@ static struct at91_adc_caps at91sam9g45_caps = {
>>   };
>>   
>>   static struct at91_adc_caps at91sam9x5_caps = {
>> +	.has_ts = true,
>> +	.has_tsmr = true,
>> +	.ts_filter_average = 3,
>> +	.ts_pen_detect_sensitivity = 2,
>>   	.calc_startup_ticks = calc_startup_ticks_9x5,
>>   	.num_channels = 12,
>>   	.registers = {
>> @@ -825,7 +1165,7 @@ static struct platform_driver at91_adc_driver = {
>>   	.probe = at91_adc_probe,
>>   	.remove = at91_adc_remove,
>>   	.driver = {
>> -		   .name = "at91_adc",
>> +		   .name = DRIVER_NAME,
>>   		   .of_match_table = of_match_ptr(at91_adc_dt_ids),
>>   	},
>>   };
>>
