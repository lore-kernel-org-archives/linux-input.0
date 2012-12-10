From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/4] iio: mxs: Implement support for touchscreen
Date: Mon, 10 Dec 2012 21:56:28 +0000
Message-ID: <50C65A8C.7060304@kernel.org>
References: <1354893893-26338-1-git-send-email-marex@denx.de> <1354893893-26338-3-git-send-email-marex@denx.de> <50C312D8.4050405@kernel.org> <201212082218.19338.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201212082218.19338.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 12/08/2012 09:18 PM, Marek Vasut wrote:
> Dear Jonathan Cameron,
> 
>> On 12/07/2012 03:24 PM, Marek Vasut wrote:
>>> This patch implements support for sampling of a touchscreen into
>>> the MXS LRADC driver. The LRADC block allows configuring some of
>>> it's channels into special mode where they either output the drive
>>> voltage or sample it, allowing it to operate a 4-wire or 5-wire
>>> resistive touchscreen.
>>>
>>> In case the touchscreen mode is enabled, the LRADC slot #7 is
>>> reserved for touchscreen only, therefore it is not possible to
>>> sample 8 LRADC channels at time, but only 7 channels.
>>>
>>> The touchscreen controller is configured such that the PENDOWN event
>>> disables touchscreen interrupts and triggers execution of worker
>>> thread, which then polls the touchscreen controller for X, Y and
>>> Pressure values. This reduces the overhead of interrupt-driven
>>> operation. Upon the PENUP event, the worker thread re-enables the
>>> PENDOWN detection interrupt and exits.
>>>
>>> Signed-off-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
>>> Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>>> Cc: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>>> Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>
>> cc added for linux input and Dmitry.
>>
>> I'd like to gather some opinions on the best way to handle these touch
>> screen devices when are sharing some hardware with more generic adc's
>> as here.
>>
>> What we have is effectively a weird mulitplexing of different signals?
>>
>> So could we treat the various axis as separate channels of a normal
>> adc (even if they are infact coming from the same pins)?
> 
> You can not. You also need to control voltage output to various plates to be 
> able to sample it from the other plate. See the comment in my patch close to the 
> big table explaining all this mayhem.
Sure you need to play with the the 'real' channels to put voltages on the
right ones etc.  This is special purpose hardware though so what I was
suggesting was to create 'virtual' channels associated with each axis.
These would then effectively do exactly what you are doing here in that
a 3 numbers would be generated to push on to input.  It'd just be a little
less direct.... I'm not particularly sure it's a good idea, but it could
be done ;)
> 
>> Then we could
>> have a go at having a generic touch screen driver acting as an IIO
>> consumer? (the interrupt driven IIO consumer stuff should be going in in
>> the comming merge window, but the example input driver didn't get cleaned
>> up in time.)
> 
> That'd be very nice indeed. But as I said above, you'd need to add ability to 
> control ADC channels so you can configure them as voltage outputs. That'd be 
> fine, but I need to do such configuration thrice in one TS sampling cycle (I 
> need to configure the TS for sampling X-axis, Y-axis and pressure). Add the 
> overhead of reading the ADC channels via some interface instead of being able to 
> directly trigger them. I'd hate to have laggy touchscreen pointer or my system 
> spending too much time in kernel -- the kthread that samples the touchscreen 
> already does consume some power.
Yes there would indeed be some overhead and clearly you have some very tight
requirements here.  It might be possible to do this with a low enough overhead,
I'm really not sure without trying it!
> 
> Also please consider the device with this LRADC is a 450MHz ARM system, so it 
> has not much processing muscle.
> 
> Besides (inbound rant), I suspect all this would add even more complexity to 
> this already complex IIO stuff.
:)
> 
>> The tricks in here with switching from interrupt triggered to polled is a
>> little nasty but I'll take your word for it that it is necessary!
> 
> Let's bury this topic please, I'm still shedding bloody tears ... I spent two 
> days trying to figure this part out. The hardware is nasty, period.
You have my sympathy.  Sometimes these hardware guys do seem to get carried
away :)
> 
>> As you have it sitting on a different delay channel you'd have to have
>> these 'magic channels' as a separate IIO device anyway.  The scan
>> would then include all the magic channels.
> 
> I got lost here. But anyway, this whole device behaves as a single IIO device so 
> far providing only the ADCs, yes.
Sure.  If you did do the 'virtual' channel for each axis things suggested above,
it would be triggered separately from the adc channels.  As we have only one
trigger (and triggered scan setup) per IIO device, this would require a pair of them.

> 
>> Hmm.  I'm not sure of the best way to handle this so fully
>> open to suggestions!
> 
> I'm all ears as well. On the other hand, I'd love to have some sort of this 
> implementation in 3.8 (is that even possible anymore?).
>
Sadly no chance for 3.8 at this stage.  Couple of weeks too late now.

>> In some ways perhaps it is better to conclude
>> these channels are so touch screen specific (when the hardware is enabled)
>> that it's better to do as you have done here.
> 
> The idea sounds really good, I'm only afraid it's too much work with too little 
> gain. And the overhead of this sollution is a bit worrying as well.
Agreed. The overhead may be a problem particularly if we involve triggers
(which would require interrupt handling etc).  Might be possible to work without
them here, but that would be fiddly.

> 
> NOTE: I'm a lazy bastard <--- does that count as a valid reason for not 
> implementing it this way ? ;-)
It is certainly a reason ;)

I only really brought this suggestion up as it is roughly I'd 'like'
to see touch screens handled.  I have no issue with other solutions but
want to keep options open and if we were to change this over to something
close to what I suggest we would have an interesting issue as suddenly a
whole load more platform data would be needed (to tie the more generic
IIO bit to a touchscreen consumer driver).

Anyhow, curriously enough none of my test boards have a screen let
alone a touch one so I'm hardly experienced in this area and so before
I merge this I would like some comments from the input side of things
(and an ACK from Dmitry).

At least we have plenty of time before 3.9!
> 
>> Dmitry, what do you think is the best way forward?
>>
>> Jonathan
>>
>>> ---
>>>
>>>  .../bindings/staging/iio/adc/mxs-lradc.txt         |    6 +
>>>  drivers/staging/iio/adc/mxs-lradc.c                |  435
>>>  +++++++++++++++++++- 2 files changed, 420 insertions(+), 21
>>>  deletions(-)
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/staging/iio/adc/mxs-lradc.txt
>>> b/Documentation/devicetree/bindings/staging/iio/adc/mxs-lradc.txt index
>>> 801d58c..4688205 100644
>>> --- a/Documentation/devicetree/bindings/staging/iio/adc/mxs-lradc.txt
>>> +++ b/Documentation/devicetree/bindings/staging/iio/adc/mxs-lradc.txt
>>>
>>> @@ -5,6 +5,12 @@ Required properties:
>>>  - reg: Address and length of the register set for the device
>>>  - interrupts: Should contain the LRADC interrupts
>>>
>>> +Optional properties:
>>> +- fsl,lradc-touchscreen-wires: Number of wires used to connect the
>>> touchscreen +                               to LRADC. Valid value is
>>> either 4 or 5. If this +                               property is not
>>> present, then the touchscreen is +                              
>>> disabled.
>>> +
>>>
>>>  Examples:
>>>  	lradc@80050000 {
>>>
>>> diff --git a/drivers/staging/iio/adc/mxs-lradc.c
>>> b/drivers/staging/iio/adc/mxs-lradc.c index 6249957..b2aa999 100644
>>> --- a/drivers/staging/iio/adc/mxs-lradc.c
>>> +++ b/drivers/staging/iio/adc/mxs-lradc.c
>>> @@ -32,6 +32,8 @@
>>>
>>>  #include <linux/stmp_device.h>
>>>  #include <linux/bitops.h>
>>>  #include <linux/completion.h>
>>>
>>> +#include <linux/delay.h>
>>> +#include <linux/input.h>
>>>
>>>  #include <mach/mxs.h>
>>>  #include <mach/common.h>
>>>
>>> @@ -59,6 +61,21 @@
>>>
>>>  #define LRADC_DELAY_TIMER_PER	200
>>>  #define LRADC_DELAY_TIMER_LOOP	5
>>>
>>> +/*
>>> + * Once the pen touches the touchscreen, the touchscreen switches from
>>> + * IRQ-driven mode to polling mode to prevent interrupt storm. The
>>> polling + * is realized by worker thread, which is called every 20 or so
>>> milliseconds. + * This gives the touchscreen enough fluence and does not
>>> strain the system + * too much.
>>> + */
>>> +#define LRADC_TS_SAMPLE_DELAY_MS	5
>>> +
>>> +/*
>>> + * The LRADC reads the following amount of samples from each touchscreen
>>> + * channel and the driver then computes avarage of these.
>>> + */
>>> +#define LRADC_TS_SAMPLE_AMOUNT		4
>>> +
>>>
>>>  static const char * const mxs_lradc_irq_name[] = {
>>>  
>>>  	"mxs-lradc-touchscreen",
>>>  	"mxs-lradc-thresh0",
>>>
>>> @@ -86,21 +103,69 @@ struct mxs_lradc {
>>>
>>>  	struct mutex		lock;
>>>  	
>>>  	struct completion	completion;
>>>
>>> +
>>> +	/*
>>> +	 * Touchscreen LRADC channels receives a private slot in the CTRL4
>>> +	 * register, the slot #7. Therefore only 7 slots instead of 8 in the
>>> +	 * CTRL4 register can be mapped to LRADC channels when using the
>>> +	 * touchscreen.
>>> +	 *
>>> +	 * Furthermore, certain LRADC channels are shared between touchscreen
>>> +	 * and/or touch-buttons and generic LRADC block. Therefore when using
>>> +	 * either of these, these channels are not available for the regular
>>> +	 * sampling. The shared channels are as follows:
>>> +	 *
>>> +	 * CH0 -- Touch button #0
>>> +	 * CH1 -- Touch button #1
>>> +	 * CH2 -- Touch screen XPUL
>>> +	 * CH3 -- Touch screen YPLL
>>> +	 * CH4 -- Touch screen XNUL
>>> +	 * CH5 -- Touch screen YNLR
>>> +	 * CH6 -- Touch screen WIPER (5-wire only)
>>> +	 *
>>> +	 * The bitfields below represents which parts of the LRADC block are
>>> +	 * switched into special mode of operation. These channels can not
>>> +	 * be sampled as regular LRADC channels. The driver will refuse any
>>> +	 * attempt to sample these channels.
>>> +	 */
>>> +#define CHAN_MASK_TOUCHBUTTON		(0x3 << 0)
>>> +#define CHAN_MASK_TOUCHSCREEN_4WIRE	(0xf << 2)
>>> +#define CHAN_MASK_TOUCHSCREEN_5WIRE	(0x1f << 2)
>>> +	int			use_touchbutton:1;
>>> +	int			use_touchscreen_4wire:1;
>>> +	int			use_touchscreen_5wire:1;
>>> +
>>> +	struct input_dev	*ts_input;
>>> +	struct work_struct	ts_work;
>>>
>>>  };
>>>  
>>>  #define	LRADC_CTRL0				0x00
>>>
>>> -#define LRADC_CTRL0_TOUCH_DETECT_ENABLE		(1 << 23)
>>> -#define LRADC_CTRL0_TOUCH_SCREEN_TYPE		(1 << 22)
>>> +#define	LRADC_CTRL0_TOUCH_DETECT_ENABLE		(1 << 23)
>>> +#define	LRADC_CTRL0_TOUCH_SCREEN_TYPE		(1 << 22)
>>> +#define	LRADC_CTRL0_YNNSW	/* YM */	(1 << 21)
>>> +#define	LRADC_CTRL0_YPNSW	/* YP */	(1 << 20)
>>> +#define	LRADC_CTRL0_YPPSW	/* YP */	(1 << 19)
>>> +#define	LRADC_CTRL0_XNNSW	/* XM */	(1 << 18)
>>> +#define	LRADC_CTRL0_XNPSW	/* XM */	(1 << 17)
>>> +#define	LRADC_CTRL0_XPPSW	/* XP */	(1 << 16)
>>> +#define	LRADC_CTRL0_PLATE_MASK			(0x3f << 16)
>>>
>>>  #define	LRADC_CTRL1				0x10
>>>
>>> -#define	LRADC_CTRL1_LRADC_IRQ(n)		(1 << (n))
>>> -#define	LRADC_CTRL1_LRADC_IRQ_MASK		0x1fff
>>> +#define	LRADC_CTRL1_TOUCH_DETECT_IRQ_EN		(1 << 24)
>>>
>>>  #define	LRADC_CTRL1_LRADC_IRQ_EN(n)		(1 << ((n) + 16))
>>>  #define	LRADC_CTRL1_LRADC_IRQ_EN_MASK		(0x1fff << 16)
>>>
>>> +#define	LRADC_CTRL1_LRADC_IRQ_EN_OFFSET		16
>>> +#define	LRADC_CTRL1_TOUCH_DETECT_IRQ		(1 << 8)
>>> +#define	LRADC_CTRL1_LRADC_IRQ(n)		(1 << (n))
>>> +#define	LRADC_CTRL1_LRADC_IRQ_MASK		0x1fff
>>> +#define	LRADC_CTRL1_LRADC_IRQ_OFFSET		0
>>>
>>>  #define	LRADC_CTRL2				0x20
>>>  #define	LRADC_CTRL2_TEMPSENSE_PWD		(1 << 15)
>>>
>>> +#define	LRADC_STATUS				0x40
>>> +#define	LRADC_STATUS_TOUCH_DETECT_RAW		(1 << 0)
>>> +
>>>
>>>  #define	LRADC_CH(n)				(0x50 + (0x10 * (n)))
>>>  #define	LRADC_CH_ACCUMULATE			(1 << 29)
>>>  #define	LRADC_CH_NUM_SAMPLES_MASK		(0x1f << 24)
>>>
>>> @@ -132,6 +197,7 @@ static int mxs_lradc_read_raw(struct iio_dev
>>> *iio_dev,
>>>
>>>  {
>>>  
>>>  	struct mxs_lradc *lradc = iio_priv(iio_dev);
>>>  	int ret;
>>>
>>> +	unsigned long mask;
>>>
>>>  	if (m != IIO_CHAN_INFO_RAW)
>>>  	
>>>  		return -EINVAL;
>>>
>>> @@ -140,6 +206,12 @@ static int mxs_lradc_read_raw(struct iio_dev
>>> *iio_dev,
>>>
>>>  	if (chan->channel > LRADC_MAX_TOTAL_CHANS)
>>>  	
>>>  		return -EINVAL;
>>>
>>> +	/* Validate the channel if it doesn't intersect with reserved chans. */
>>> +	bitmap_set(&mask, chan->channel, 1);
>>> +	ret = iio_validate_scan_mask_onehot(iio_dev, &mask);
>>> +	if (ret)
>>> +		return -EINVAL;
>>> +
>>>
>>>  	/*
>>>  	
>>>  	 * See if there is no buffered operation in progess. If there is,
>>>  	 simply * bail out. This can be improved to support both buffered and
>>>  	 raw IO at
>>>
>>> @@ -161,7 +233,11 @@ static int mxs_lradc_read_raw(struct iio_dev
>>> *iio_dev,
>>>
>>>  		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
>>>  	
>>>  	writel(0xff, lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
>>>
>>> -	writel(chan->channel, lradc->base + LRADC_CTRL4);
>>> +	/* Clean the slot's previous content, then set new one. */
>>> +	writel(LRADC_CTRL4_LRADCSELECT_MASK(0),
>>> +		lradc->base + LRADC_CTRL4 + STMP_OFFSET_REG_CLR);
>>> +	writel(chan->channel, lradc->base + LRADC_CTRL4 + STMP_OFFSET_REG_SET);
>>> +
>>>
>>>  	writel(0, lradc->base + LRADC_CH(0));
>>>  	
>>>  	/* Enable the IRQ and start sampling the channel. */
>>>
>>> @@ -195,6 +271,243 @@ static const struct iio_info mxs_lradc_iio_info = {
>>>
>>>  };
>>>  
>>>  /*
>>>
>>> + * Touchscreen handling
>>> + */
>>> +enum lradc_ts_plate {
>>> +	LRADC_SAMPLE_X,
>>> +	LRADC_SAMPLE_Y,
>>> +	LRADC_SAMPLE_PRESSURE,
>>> +};
>>> +
>>> +static int mxs_lradc_ts_touched(struct mxs_lradc *lradc)
>>> +{
>>> +	uint32_t reg;
>>> +
>>> +	/* Enable touch detection. */
>>> +	writel(LRADC_CTRL0_PLATE_MASK,
>>> +		lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
>>> +	writel(LRADC_CTRL0_TOUCH_DETECT_ENABLE,
>>> +		lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_SET);
>>> +
>>> +	msleep(LRADC_TS_SAMPLE_DELAY_MS);
>>> +
>>> +	reg = readl(lradc->base + LRADC_STATUS);
>>> +
>>> +	return reg & LRADC_STATUS_TOUCH_DETECT_RAW;
>>> +}
>>> +
>>> +static int32_t mxs_lradc_ts_sample(struct mxs_lradc *lradc,
>>> +				enum lradc_ts_plate plate, int change)
>>> +{
>>> +	unsigned long delay, jiff;
>>> +	uint32_t reg, ctrl0 = 0, chan = 0;
>>> +	/* The touchscreen always uses CTRL4 slot #7. */
>>> +	const uint8_t slot = 7;
>>> +	uint32_t val;
>>> +
>>> +	/*
>>> +	 * There are three correct configurations of the controller sampling
>>> +	 * the touchscreen, each of these configuration provides different
>>> +	 * information from the touchscreen.
>>> +	 *
>>> +	 * The following table describes the sampling configurations:
>>> +	 * +-------------+-------+-------+-------+
>>> +	 * | Wire \ Axis |   X   |   Y   |   Z   |
>>> +	 * +---------------------+-------+-------+
>>> +	 * |   X+ (CH2)  |   HI  |   TS  |   TS  |
>>> +	 * +-------------+-------+-------+-------+
>>> +	 * |   X- (CH4)  |   LO  |   SH  |   HI  |
>>> +	 * +-------------+-------+-------+-------+
>>> +	 * |   Y+ (CH3)  |   SH  |   HI  |   HI  |
>>> +	 * +-------------+-------+-------+-------+
>>> +	 * |   Y- (CH5)  |   TS  |   LO  |   SH  |
>>> +	 * +-------------+-------+-------+-------+
>>> +	 *
>>> +	 * HI ... strong '1'  ; LO ... strong '0'
>>> +	 * SH ... sample here ; TS ... tri-state
>>> +	 *
>>> +	 * There are a few other ways of obtaining the Z coordinate
>>> +	 * (aka. pressure), but the one in the table seems to be the
>>> +	 * most reliable one.
>>> +	 */
>>> +	if (plate == LRADC_SAMPLE_X) {
>>> +		ctrl0 = LRADC_CTRL0_XPPSW | LRADC_CTRL0_XNNSW;
>>> +		chan = 3;
>>> +	} else if (plate == LRADC_SAMPLE_Y) {
>>> +		ctrl0 = LRADC_CTRL0_YPPSW | LRADC_CTRL0_YNNSW;
>>> +		chan = 4;
>>> +	} else if (plate == LRADC_SAMPLE_PRESSURE) {
>>> +		ctrl0 = LRADC_CTRL0_YPPSW | LRADC_CTRL0_XNNSW;
>>> +		chan = 5;
>>> +	}
>>> +
>>> +	if (change) {
>>> +		writel(LRADC_CTRL0_PLATE_MASK,
>>> +			lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
>>> +		writel(ctrl0, lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_SET);
>>> +
>>> +		writel(LRADC_CTRL4_LRADCSELECT_MASK(slot),
>>> +			lradc->base + LRADC_CTRL4 + STMP_OFFSET_REG_CLR);
>>> +		writel(chan << LRADC_CTRL4_LRADCSELECT_OFFSET(slot),
>>> +			lradc->base + LRADC_CTRL4 + STMP_OFFSET_REG_SET);
>>> +	}
>>> +
>>> +	writel(0xffffffff, lradc->base + LRADC_CH(slot) + STMP_OFFSET_REG_CLR);
>>> +	writel(1 << slot, lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_SET);
>>> +
>>> +	delay = jiffies + msecs_to_jiffies(LRADC_TS_SAMPLE_DELAY_MS);
>>> +	do {
>>> +		jiff = jiffies;
>>> +		reg = readl_relaxed(lradc->base + LRADC_CTRL1);
>>> +		if (reg & LRADC_CTRL1_LRADC_IRQ(slot))
>>> +			break;
>>> +	} while (time_before(jiff, delay));
>>> +
>>> +	writel(LRADC_CTRL1_LRADC_IRQ(slot),
>>> +		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
>>> +
>>> +	if (time_after_eq(jiff, delay))
>>> +		return -ETIMEDOUT;
>>> +
>>> +	val = readl(lradc->base + LRADC_CH(slot));
>>> +	val &= LRADC_CH_VALUE_MASK;
>>> +
>>> +	return val;
>>> +}
>>> +
>>> +static int32_t mxs_lradc_ts_sample_filter(struct mxs_lradc *lradc,
>>> +				enum lradc_ts_plate plate)
>>> +{
>>> +	int32_t val, tot = 0;
>>> +	int i;
>>> +
>>> +	val = mxs_lradc_ts_sample(lradc, plate, 1);
>>> +
>>> +	/* Delay a bit so the touchscreen is stable. */
>>> +	mdelay(2);
>>> +
>>> +	for (i = 0; i < LRADC_TS_SAMPLE_AMOUNT; i++) {
>>> +		val = mxs_lradc_ts_sample(lradc, plate, 0);
>>> +		tot += val;
>>> +	}
>>> +
>>> +	return tot / LRADC_TS_SAMPLE_AMOUNT;
>>> +}
>>> +static void mxs_lradc_ts_work(struct work_struct *ts_work)
>>> +{
>>> +	struct mxs_lradc *lradc = container_of(ts_work,
>>> +				struct mxs_lradc, ts_work);
>>> +	int val_x, val_y, val_p;
>>> +	bool valid = false;
>>> +
>>> +	while (mxs_lradc_ts_touched(lradc)) {
>>> +		/* Disable touch detector so we can sample the touchscreen. */
>>> +		writel(LRADC_CTRL0_TOUCH_DETECT_ENABLE,
>>> +			lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
>>> +
>>> +		if (likely(valid)) {
>>> +			input_report_abs(lradc->ts_input, ABS_X, val_x);
>>> +			input_report_abs(lradc->ts_input, ABS_Y, val_y);
>>> +			input_report_abs(lradc->ts_input, ABS_PRESSURE, val_p);
>>> +			input_report_key(lradc->ts_input, BTN_TOUCH, 1);
>>> +			input_sync(lradc->ts_input);
>>> +		}
>>> +
>>> +		valid = false;
>>> +
>>> +		val_x = mxs_lradc_ts_sample_filter(lradc, LRADC_SAMPLE_X);
>>> +		if (val_x < 0)
>>> +			continue;
>>> +		val_y = mxs_lradc_ts_sample_filter(lradc, LRADC_SAMPLE_Y);
>>> +		if (val_y < 0)
>>> +			continue;
>>> +		val_p = mxs_lradc_ts_sample_filter(lradc, 
> LRADC_SAMPLE_PRESSURE);
>>> +		if (val_p < 0)
>>> +			continue;
>>> +
>>> +		valid = true;
>>> +	}
>>> +
>>> +	input_report_abs(lradc->ts_input, ABS_PRESSURE, 0);
>>> +	input_report_key(lradc->ts_input, BTN_TOUCH, 0);
>>> +	input_sync(lradc->ts_input);
>>> +
>>> +	/* Restart the touchscreen interrupts. */
>>> +	writel(LRADC_CTRL1_TOUCH_DETECT_IRQ,
>>> +		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
>>> +	writel(LRADC_CTRL1_TOUCH_DETECT_IRQ_EN,
>>> +		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_SET);
>>> +}
>>> +
>>> +static int mxs_lradc_ts_open(struct input_dev *dev)
>>> +{
>>> +	struct mxs_lradc *lradc = input_get_drvdata(dev);
>>> +
>>> +	writel(LRADC_CTRL0_TOUCH_DETECT_ENABLE,
>>> +		lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_SET);
>>> +	writel(LRADC_CTRL1_TOUCH_DETECT_IRQ_EN,
>>> +		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_SET);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static void mxs_lradc_ts_close(struct input_dev *dev)
>>> +{
>>> +	struct mxs_lradc *lradc = input_get_drvdata(dev);
>>> +
>>> +	writel(LRADC_CTRL1_TOUCH_DETECT_IRQ_EN,
>>> +		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
>>> +	writel(LRADC_CTRL0_TOUCH_DETECT_ENABLE,
>>> +		lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
>>> +}
>>> +
>>> +static int mxs_lradc_ts_register(struct mxs_lradc *lradc)
>>> +{
>>> +	struct input_dev *input;
>>> +	struct device *dev = lradc->dev;
>>> +
>>> +	if (!(lradc->use_touchscreen_4wire || lradc->use_touchscreen_5wire))
>>> +		return 0;
>>> +
>>> +	input = input_allocate_device();
>>> +	if (!input) {
>>> +		dev_warn(dev, "Failed to allocate TS device, disabling.\n");
>>> +		lradc->use_touchscreen_4wire = 0;
>>> +		lradc->use_touchscreen_5wire = 0;
>>> +		return 0;
>>> +	}
>>> +
>>> +	input->name = DRIVER_NAME;
>>> +	input->id.bustype = BUS_HOST;
>>> +	input->dev.parent = dev;
>>> +	input->open = mxs_lradc_ts_open;
>>> +	input->close = mxs_lradc_ts_close;
>>> +
>>> +	__set_bit(EV_ABS, input->evbit);
>>> +	__set_bit(EV_KEY, input->evbit);
>>> +	__set_bit(BTN_TOUCH, input->keybit);
>>> +	input_set_abs_params(input, ABS_X, 0, LRADC_CH_VALUE_MASK, 0, 0);
>>> +	input_set_abs_params(input, ABS_Y, 0, LRADC_CH_VALUE_MASK, 0, 0);
>>> +	input_set_abs_params(input, ABS_PRESSURE, 0, LRADC_CH_VALUE_MASK, 0,
>>> 0); +
>>> +	lradc->ts_input = input;
>>> +	input_set_drvdata(input, lradc);
>>> +	return input_register_device(input);
>>> +}
>>> +
>>> +static void mxs_lradc_ts_unregister(struct mxs_lradc *lradc)
>>> +{
>>> +	if (!(lradc->use_touchscreen_4wire || lradc->use_touchscreen_5wire))
>>> +		return;
>>> +
>>> +	if (!lradc->ts_input)
>>> +		return;
>>> +
>>> +	input_unregister_device(lradc->ts_input);
>>> +	input_free_device(lradc->ts_input);
>>> +}
>>> +
>>> +/*
>>>
>>>   * IRQ Handling
>>>   */
>>>  
>>>  static irqreturn_t mxs_lradc_handle_irq(int irq, void *data)
>>>
>>> @@ -202,14 +515,23 @@ static irqreturn_t mxs_lradc_handle_irq(int irq,
>>> void *data)
>>>
>>>  	struct iio_dev *iio = data;
>>>  	struct mxs_lradc *lradc = iio_priv(iio);
>>>  	unsigned long reg = readl(lradc->base + LRADC_CTRL1);
>>>
>>> +	const uint32_t ts_irq_mask =
>>> +		LRADC_CTRL1_TOUCH_DETECT_IRQ_EN |
>>> +		LRADC_CTRL1_TOUCH_DETECT_IRQ;
>>>
>>>  	if (!(reg & LRADC_CTRL1_LRADC_IRQ_MASK))
>>>  	
>>>  		return IRQ_NONE;
>>>  	
>>>  	/*
>>>
>>> -	 * Touchscreen IRQ handling code shall probably have priority
>>> -	 * and therefore shall be placed here.
>>> +	 * Touchscreen IRQ handling code has priority and therefore
>>> +	 * is placed here. In case touchscreen IRQ arrives, disable
>>> +	 * it ASAP
>>>
>>>  	 */
>>>
>>> +	if (reg & LRADC_CTRL1_TOUCH_DETECT_IRQ) {
>>> +		writel(ts_irq_mask,
>>> +			lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
>>> +		schedule_work(&lradc->ts_work);
>>> +	}
>>>
>>>  	if (iio_buffer_enabled(iio))
>>>  	
>>>  		iio_trigger_poll(iio->trig, iio_get_time_ns());
>>>
>>> @@ -306,8 +628,10 @@ static int mxs_lradc_buffer_preenable(struct iio_dev
>>> *iio)
>>>
>>>  {
>>>  
>>>  	struct mxs_lradc *lradc = iio_priv(iio);
>>>  	struct iio_buffer *buffer = iio->buffer;
>>>
>>> -	int ret = 0, chan, ofs = 0, enable = 0;
>>> -	uint32_t ctrl4 = 0;
>>> +	int ret = 0, chan, ofs = 0;
>>> +	unsigned long enable = 0;
>>> +	uint32_t ctrl4_set = 0;
>>> +	uint32_t ctrl4_clr = 0;
>>>
>>>  	uint32_t ctrl1_irq = 0;
>>>  	const uint32_t chan_value = LRADC_CH_ACCUMULATE |
>>>  	
>>>  		((LRADC_DELAY_TIMER_LOOP - 1) << LRADC_CH_NUM_SAMPLES_OFFSET);
>>>
>>> @@ -339,17 +663,20 @@ static int mxs_lradc_buffer_preenable(struct
>>> iio_dev *iio)
>>>
>>>  	writel(0xff, lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
>>>  	
>>>  	for_each_set_bit(chan, buffer->scan_mask, LRADC_MAX_TOTAL_CHANS) {
>>>
>>> -		ctrl4 |= chan << LRADC_CTRL4_LRADCSELECT_OFFSET(ofs);
>>> +		ctrl4_set |= chan << LRADC_CTRL4_LRADCSELECT_OFFSET(ofs);
>>> +		ctrl4_clr |= LRADC_CTRL4_LRADCSELECT_MASK(ofs);
>>>
>>>  		ctrl1_irq |= LRADC_CTRL1_LRADC_IRQ_EN(ofs);
>>>  		writel(chan_value, lradc->base + LRADC_CH(ofs));
>>>
>>> -		enable |= 1 << ofs;
>>> +		bitmap_set(&enable, ofs, 1);
>>>
>>>  		ofs++;
>>>  	
>>>  	};
>>>  	
>>>  	writel(LRADC_DELAY_TRIGGER_LRADCS_MASK | LRADC_DELAY_KICK,
>>>  	
>>>  		lradc->base + LRADC_DELAY(0) + STMP_OFFSET_REG_CLR);
>>>
>>> -	writel(ctrl4, lradc->base + LRADC_CTRL4);
>>> +	writel(ctrl4_clr, lradc->base + LRADC_CTRL4 + STMP_OFFSET_REG_CLR);
>>> +	writel(ctrl4_set, lradc->base + LRADC_CTRL4 + STMP_OFFSET_REG_SET);
>>> +
>>>
>>>  	writel(ctrl1_irq, lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_SET);
>>>  	
>>>  	writel(enable << LRADC_DELAY_TRIGGER_LRADCS_OFFSET,
>>>
>>> @@ -384,9 +711,33 @@ static int mxs_lradc_buffer_postdisable(struct
>>> iio_dev *iio)
>>>
>>>  static bool mxs_lradc_validate_scan_mask(struct iio_dev *iio,
>>>  
>>>  					const unsigned long *mask)
>>>  
>>>  {
>>>
>>> -	const int mw = bitmap_weight(mask, iio->masklength);
>>> -
>>> -	return mw <= LRADC_MAX_MAPPED_CHANS;
>>> +	struct mxs_lradc *lradc = iio_priv(iio);
>>> +	const int len = iio->masklength;
>>> +	const int map_chans = bitmap_weight(mask, len);
>>> +	int rsvd_chans = 0;
>>> +	unsigned long rsvd_mask = 0;
>>> +
>>> +	if (lradc->use_touchbutton)
>>> +		rsvd_mask |= CHAN_MASK_TOUCHBUTTON;
>>> +	if (lradc->use_touchscreen_4wire)
>>> +		rsvd_mask |= CHAN_MASK_TOUCHSCREEN_4WIRE;
>>> +	if (lradc->use_touchscreen_5wire)
>>> +		rsvd_mask |= CHAN_MASK_TOUCHSCREEN_5WIRE;
>>> +
>>> +	if (lradc->use_touchbutton)
>>> +		rsvd_chans++;
>>> +	if (lradc->use_touchscreen_4wire || lradc->use_touchscreen_5wire)
>>> +		rsvd_chans++;
>>> +
>>> +	/* Test for attempts to map channels with special mode of operation. */
>>> +	if (bitmap_intersects(mask, &rsvd_mask, len))
>>> +		return 0;
>>> +
>>> +	/* Test for attempts to map more channels then available slots. */
>>> +	if (map_chans + rsvd_chans > LRADC_MAX_MAPPED_CHANS)
>>> +		return 0;
>>> +
>>> +	return 1;
>>>
>>>  }
>>>  
>>>  static const struct iio_buffer_setup_ops mxs_lradc_buffer_ops = {
>>>
>>> @@ -435,15 +786,29 @@ static const struct iio_chan_spec
>>> mxs_lradc_chan_spec[] = {
>>>
>>>  static void mxs_lradc_hw_init(struct mxs_lradc *lradc)
>>>  {
>>>
>>> -	int i;
>>> -	const uint32_t cfg =
>>> +	/* The ADC always uses DELAY CHANNEL 0. */
>>> +	const uint32_t adc_cfg =
>>> +		(1 << (LRADC_DELAY_TRIGGER_DELAYS_OFFSET + 0)) |
>>>
>>>  		(LRADC_DELAY_TIMER_PER << LRADC_DELAY_DELAY_OFFSET);
>>>  	
>>>  	stmp_reset_block(lradc->base);
>>>
>>> -	for (i = 0; i < LRADC_MAX_DELAY_CHANS; i++)
>>> -		writel(cfg | (1 << (LRADC_DELAY_TRIGGER_DELAYS_OFFSET + i)),
>>> -			lradc->base + LRADC_DELAY(i));
>>> +	/* Configure DELAY CHANNEL 0 for generic ADC sampling. */
>>> +	writel(adc_cfg, lradc->base + LRADC_DELAY(0));
>>> +
>>> +	/* Disable remaining DELAY CHANNELs */
>>> +	writel(0, lradc->base + LRADC_DELAY(1));
>>> +	writel(0, lradc->base + LRADC_DELAY(2));
>>> +	writel(0, lradc->base + LRADC_DELAY(3));
>>> +
>>> +	/* Configure the touchscreen type */
>>> +	if (lradc->use_touchscreen_4wire) {
>>> +		writel(LRADC_CTRL0_TOUCH_SCREEN_TYPE,
>>> +			lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
>>> +	} else if (lradc->use_touchscreen_5wire) {
>>> +		writel(LRADC_CTRL0_TOUCH_SCREEN_TYPE,
>>> +			lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_SET);
>>> +	}
>>>
>>>  	/* Start internal temperature sensing. */
>>>  	writel(0, lradc->base + LRADC_CTRL2);
>>>
>>> @@ -463,9 +828,11 @@ static void mxs_lradc_hw_stop(struct mxs_lradc
>>> *lradc)
>>>
>>>  static int __devinit mxs_lradc_probe(struct platform_device *pdev)
>>>  {
>>>  
>>>  	struct device *dev = &pdev->dev;
>>>
>>> +	struct device_node *node = dev->of_node;
>>>
>>>  	struct mxs_lradc *lradc;
>>>  	struct iio_dev *iio;
>>>  	struct resource *iores;
>>>
>>> +	uint32_t ts_wires = 0;
>>>
>>>  	int ret = 0;
>>>  	int i;
>>>
>>> @@ -487,6 +854,21 @@ static int __devinit mxs_lradc_probe(struct
>>> platform_device *pdev)
>>>
>>>  		goto err_addr;
>>>  	
>>>  	}
>>>
>>> +	INIT_WORK(&lradc->ts_work, mxs_lradc_ts_work);
>>> +
>>> +	/* Check if touchscreen is enabled in DT. */
>>> +	ret = of_property_read_u32(node, "fsl,lradc-touchscreen-wires",
>>> +				&ts_wires);
>>> +	if (ret)
>>> +		dev_info(dev, "Touchscreen not enabled.\n");
>>> +	else if (ts_wires == 4)
>>> +		lradc->use_touchscreen_4wire = 1;
>>> +	else if (ts_wires == 5)
>>> +		lradc->use_touchscreen_5wire = 1;
>>> +	else
>>> +		dev_warn(dev, "Unsupported number of touchscreen wires (%d)\n",
>>> +				ts_wires);
>>> +
>>>
>>>  	/* Grab all IRQ sources */
>>>  	for (i = 0; i < 13; i++) {
>>>  	
>>>  		lradc->irq[i] = platform_get_irq(pdev, i);
>>>
>>> @@ -524,11 +906,16 @@ static int __devinit mxs_lradc_probe(struct
>>> platform_device *pdev)
>>>
>>>  	if (ret)
>>>  	
>>>  		goto err_trig;
>>>
>>> +	/* Register the touchscreen input device. */
>>> +	ret = mxs_lradc_ts_register(lradc);
>>> +	if (ret)
>>> +		goto err_dev;
>>> +
>>>
>>>  	/* Register IIO device. */
>>>  	ret = iio_device_register(iio);
>>>  	if (ret) {
>>>  	
>>>  		dev_err(dev, "Failed to register IIO device\n");
>>>
>>> -		goto err_dev;
>>> +		goto err_ts;
>>>
>>>  	}
>>>  	
>>>  	/* Configure the hardware. */
>>>
>>> @@ -536,6 +923,8 @@ static int __devinit mxs_lradc_probe(struct
>>> platform_device *pdev)
>>>
>>>  	return 0;
>>>
>>> +err_ts:
>>> +	mxs_lradc_ts_unregister(lradc);
>>>
>>>  err_dev:
>>>  	mxs_lradc_trigger_remove(iio);
>>>  
>>>  err_trig:
>>> @@ -550,6 +939,10 @@ static int __devexit mxs_lradc_remove(struct
>>> platform_device *pdev)
>>>
>>>  	struct iio_dev *iio = platform_get_drvdata(pdev);
>>>  	struct mxs_lradc *lradc = iio_priv(iio);
>>>
>>> +	mxs_lradc_ts_unregister(lradc);
>>> +
>>> +	cancel_work_sync(&lradc->ts_work);
>>> +
>>>
>>>  	mxs_lradc_hw_stop(lradc);
>>>  	
>>>  	iio_device_unregister(iio);
> 
> Best regards,
> Marek Vasut
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
