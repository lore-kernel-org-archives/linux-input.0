From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 3/5] iio: adc: sunxi-gpadc-iio: enable iio_buffers
Date: Sun, 24 Jul 2016 12:03:35 +0100
Message-ID: <ff7515ec-a064-95df-1118-93c7062c2237@kernel.org>
References: <1469003351-15263-1-git-send-email-quentin.schulz@free-electrons.com>
 <1469003351-15263-4-git-send-email-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1469003351-15263-4-git-send-email-quentin.schulz@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, maxime.ripard@free-electrons.com, wens@csie.org, dmitry.torokhov@gmail.com, lee.jones@linaro.org
Cc: antoine.tenart@free-electrons.com, thomas.petazzoni@free-electrons.com, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 20/07/16 09:29, Quentin Schulz wrote:
> This enables the use of buffers on ADC channels of sunxi-gpadc-iio driver.
> It also prepares the code which will be used by the touchscreen driver
> named sunxi-gpadc-ts.
> 
> The GPADC on Allwinner SoCs (A10, A13 and A31) has a 12 bits register for
> conversion's data. The GPADC uses the same ADC channels for the ADC and the
> touchscreen therefore exposes these channels to the sunxi-gpadc-ts iio
> consumer which will be in charge of reading data from these channels for
> the input framework.
> 
> The temperature can only be read when in touchscreen mode. This means if
> the buffers are being used for the ADC, the temperature sensor cannot be
> read.
That may be the bizarest hardware restriction I've heard of in a while! :)
> 
> When a FIFO_DATA_PENDING irq occurs, its handler will read the entire FIFO
> and fill a buffer before sending it to the consumers which registered in
> IIO for the ADC channels.
> 
> When a consumer starts buffering ADC channels,
> sunxi_gpadc_buffer_postenable is called and will enable FIFO_DATA_PENDING
> irq and select the mode in which the GPADC should run (ADC or touchscreen)
> depending on a property of the DT ("allwinner,ts-attached").
> When the consumer stops buffering, it disables the same irq.
Hmm. Might be possible to distinguish which consumer caused the start.
Thus, if the touchscreen is there we would know purely based on the
driver being the requester that we need to be in touchscreen mode.

> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
You are moving fast on this - I'd have been tempted to do a mega
series with the updated version of the basic support and this on top
rather than a new unconnected series.

(I'd forgotten that was still under review so got confused when I
went to look something up in the files you are modifying!).
> ---
>  drivers/iio/adc/Kconfig           |   1 +
>  drivers/iio/adc/sunxi-gpadc-iio.c | 153 ++++++++++++++++++++++++++++++++++----
>  2 files changed, 138 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 184856f..15e3b08 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -342,6 +342,7 @@ config SUNXI_ADC
>  	tristate "ADC driver for sunxi platforms"
>  	depends on IIO
>  	depends on MFD_SUNXI_ADC
> +	depends on IIO_BUFFER_CB
>  	help
>  	  Say yes here to build support for Allwinner (A10, A13 and A31) SoCs
>  	  ADC. This ADC provides 4 channels which can be used as an ADC or as a
> diff --git a/drivers/iio/adc/sunxi-gpadc-iio.c b/drivers/iio/adc/sunxi-gpadc-iio.c
> index 87cc913..2e44ca7 100644
> --- a/drivers/iio/adc/sunxi-gpadc-iio.c
> +++ b/drivers/iio/adc/sunxi-gpadc-iio.c
> @@ -16,8 +16,9 @@
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  
> -#include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
>  #include <linux/iio/driver.h>
> +#include <linux/iio/iio.h>
Can't say I'm a particular fan of reordering headers to be in alphabetical
order, but I suppose it doesn't really matter if you want to do it.
(to my mind there is a tree structure implicit in these headers with iio.h
at the top for generic support, then the various sub elements below).

>  #include <linux/iio/machine.h>
>  #include <linux/mfd/sunxi-gpadc-mfd.h>
>  
> @@ -71,6 +72,7 @@
>  #define SUNXI_GPADC_TP_DATA_XY_CHANGE		BIT(13)
>  #define SUNXI_GPADC_TP_FIFO_TRIG_LEVEL(x)	((x) << 8)  /* 5 bits */
>  #define SUNXI_GPADC_TP_DATA_DRQ_EN		BIT(7)
> +/* Be careful, flushing FIFO spawns SUNXI_GPADC_FIFO_DATA_PENDING interrupts */
Sounds like you learned that one the hard way ;)
>  #define SUNXI_GPADC_TP_FIFO_FLUSH		BIT(4)
>  #define SUNXI_GPADC_TP_UP_IRQ_EN		BIT(1)
>  #define SUNXI_GPADC_TP_DOWN_IRQ_EN		BIT(0)
> @@ -79,6 +81,7 @@
>  #define SUNXI_GPADC_TEMP_DATA_PENDING		BIT(18)
>  #define SUNXI_GPADC_FIFO_OVERRUN_PENDING	BIT(17)
>  #define SUNXI_GPADC_FIFO_DATA_PENDING		BIT(16)
> +#define SUNXI_GPADC_RXA_CNT			GENMASK(12, 8)
>  #define SUNXI_GPADC_TP_IDLE_FLG			BIT(2)
>  #define SUNXI_GPADC_TP_UP_PENDING		BIT(1)
>  #define SUNXI_GPADC_TP_DOWN_PENDING		BIT(0)
> @@ -101,19 +104,43 @@ struct sunxi_gpadc_dev {
>  	unsigned int			fifo_data_irq;
>  	unsigned int			temp_data_irq;
>  	unsigned int			flags;
> +	struct iio_dev			*indio_dev;
I was suprised to see this as normally it is cleaner to structure
the whole code to go in one direction through the structures (which is
why we don't provide a generic iio_device_from_priv bit of pointer magic).

Anyhow, don't htink you are actually using it ;)

> +	struct sunxi_gpadc_buffer	buffer;
> +	bool				ts_attached;
> +	bool				buffered;
>  };
>  
> -#define SUNXI_GPADC_ADC_CHANNEL(_channel, _name) {		\
> +#define SUNXI_GPADC_ADC_CHANNEL(_channel, _name, _index) {	\
>  	.type = IIO_VOLTAGE,					\
>  	.indexed = 1,						\
>  	.channel = _channel,					\
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
>  	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
>  	.datasheet_name = _name,				\
> +	.scan_index = _index,					\
> +	.scan_type = {						\
> +		.sign = 'u',					\
> +		.realbits = 12,					\
> +		.storagebits = 16,				\
> +		.shift = 0,					\
No need to specify shift.  C(99?) guarantees that any non set elements
are 0 initialized and 0 is the obvious default here.
> +		.endianness = IIO_LE,				\
> +	},							\
>  }
>  
>  static struct iio_map sunxi_gpadc_hwmon_maps[] = {
>  	{
> +		.adc_channel_label = "adc_chan0",
> +		.consumer_dev_name = "sunxi-gpadc-ts.0",
> +	}, {
> +		.adc_channel_label = "adc_chan1",
> +		.consumer_dev_name = "sunxi-gpadc-ts.0",
> +	}, {
> +		.adc_channel_label = "adc_chan2",
> +		.consumer_dev_name = "sunxi-gpadc-ts.0",
> +	}, {
> +		.adc_channel_label = "adc_chan3",
> +		.consumer_dev_name = "sunxi-gpadc-ts.0",
> +	}, {
>  		.adc_channel_label = "temp_adc",
>  		.consumer_dev_name = "iio_hwmon.0",
>  	},
> @@ -121,28 +148,33 @@ static struct iio_map sunxi_gpadc_hwmon_maps[] = {
>  };
>  
>  static const struct iio_chan_spec sunxi_gpadc_channels[] = {
> -	SUNXI_GPADC_ADC_CHANNEL(0, "adc_chan0"),
> -	SUNXI_GPADC_ADC_CHANNEL(1, "adc_chan1"),
> -	SUNXI_GPADC_ADC_CHANNEL(2, "adc_chan2"),
> -	SUNXI_GPADC_ADC_CHANNEL(3, "adc_chan3"),
Why not index from 0? The scan indexes have to be monotonic, but 0 is just
fine.
> +	SUNXI_GPADC_ADC_CHANNEL(0, "adc_chan0", 1),
> +	SUNXI_GPADC_ADC_CHANNEL(1, "adc_chan1", 2),
> +	SUNXI_GPADC_ADC_CHANNEL(2, "adc_chan2", 3),
> +	SUNXI_GPADC_ADC_CHANNEL(3, "adc_chan3", 4),
>  	{
>  		.type = IIO_TEMP,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
>  		.datasheet_name = "temp_adc",
>  		.extend_name = "SoC temperature",
>  	},
> -	{ /* sentinel */ },
This should never have been there - explicit size is used, not a null
element.  Fix that in the prior patches please.
>  };
>  
>  static int sunxi_gpadc_adc_read(struct iio_dev *indio_dev, int channel,
>  				int *val)
>  {
>  	struct sunxi_gpadc_dev *info = iio_priv(indio_dev);
> +	bool buffered = info->buffered;
Not worth the local version...
>  	int ret = 0;
> +	unsigned int reg;
>  
>  	mutex_lock(&indio_dev->mlock);
>  
>  	reinit_completion(&info->completion);
> +
> +	reg = SUNXI_GPADC_TP_FIFO_TRIG_LEVEL(1) | SUNXI_GPADC_TP_FIFO_FLUSH;
> +	regmap_update_bits(info->regmap, SUNXI_GPADC_TP_INT_FIFOC, reg, reg);
I'd put it in directly rahter than having a reg local variable.  To mind
mind that would be slightly easier to understand.
> +
>  	if (info->flags & SUNXI_GPADC_ARCH_SUN6I)
>  		regmap_write(info->regmap, SUNXI_GPADC_TP_CTRL1,
>  			     SUNXI_GPADC_SUN6I_TP_MODE_EN |
> @@ -153,9 +185,9 @@ static int sunxi_gpadc_adc_read(struct iio_dev *indio_dev, int channel,
>  			     SUNXI_GPADC_TP_MODE_EN |
>  			     SUNXI_GPADC_TP_ADC_SELECT |
>  			     SUNXI_GPADC_ADC_CHAN_SELECT(channel));
> -	regmap_write(info->regmap, SUNXI_GPADC_TP_INT_FIFOC,
> -		     SUNXI_GPADC_TP_FIFO_TRIG_LEVEL(1) |
> -		     SUNXI_GPADC_TP_FIFO_FLUSH);
Whole load of infrastructure in place to lock buffered mode out and
revent transitions when we can't have them.

iio_claim_direct_mode etc.  I think you can just use that here?
If you need to do extra checks on it being enabled that should be
fine too.

As a general rule, it makes sense to simply disable polled reads
if in buffered mode.  Leads to much simpler code and generally
the data is already known to userspace anyway.

I have been meaning to do it a bit better when we have multiple
in kernel consumers, some expecting polled readings and some
pushed.  There some core caching magic will make sense to
keep the polled channels as available as possible when running
the  buffers.

A bit fiddly to implement + might have some slightly suprising
results on delays on channels when say a sysfs trigger is
being used... (not a problem here as you have a fifo and hence
aren't using triggers).

Anyhow, not really relevant here :)

> +
> +	info->buffered = false;
> +
>  	enable_irq(info->fifo_data_irq);
>  
>  	if (!wait_for_completion_timeout(&info->completion,
> @@ -169,6 +201,7 @@ static int sunxi_gpadc_adc_read(struct iio_dev *indio_dev, int channel,
>  out:
>  	disable_irq(info->fifo_data_irq);
>  	mutex_unlock(&indio_dev->mlock);
> +	info->buffered = buffered;
>  
>  	return ret;
>  }
> @@ -177,20 +210,22 @@ static int sunxi_gpadc_temp_read(struct iio_dev *indio_dev, int *val)
>  {
>  	struct sunxi_gpadc_dev *info = iio_priv(indio_dev);
>  	int ret = 0;
> +	unsigned int reg;
>  
>  	mutex_lock(&indio_dev->mlock);
>  
>  	reinit_completion(&info->completion);
>  
> -	regmap_write(info->regmap, SUNXI_GPADC_TP_INT_FIFOC,
> -		     SUNXI_GPADC_TP_FIFO_TRIG_LEVEL(1) |
> -		     SUNXI_GPADC_TP_FIFO_FLUSH);
> +	reg = SUNXI_GPADC_TP_FIFO_TRIG_LEVEL(1) | SUNXI_GPADC_TP_FIFO_FLUSH;
> +	regmap_update_bits(info->regmap, SUNXI_GPADC_TP_INT_FIFOC, reg, reg);
> +
Again, I'd drop the local variable reg and put it directly in the update_bits
call.
>  	if (info->flags & SUNXI_GPADC_ARCH_SUN6I)
>  		regmap_write(info->regmap, SUNXI_GPADC_TP_CTRL1,
>  			     SUNXI_GPADC_SUN6I_TP_MODE_EN);
>  	else
>  		regmap_write(info->regmap, SUNXI_GPADC_TP_CTRL1,
>  			     SUNXI_GPADC_TP_MODE_EN);
> +
>  	enable_irq(info->temp_data_irq);
>  
>  	if (!wait_for_completion_timeout(&info->completion,
> @@ -211,7 +246,6 @@ out:
>  	mutex_unlock(&indio_dev->mlock);
>  
>  	return ret;
> -
>  }
>  
>  static int sunxi_gpadc_read_raw(struct iio_dev *indio_dev,
> @@ -219,15 +253,22 @@ static int sunxi_gpadc_read_raw(struct iio_dev *indio_dev,
>  				int *val, int *val2, long mask)
>  {
>  	int ret;
> +	struct sunxi_gpadc_dev *info = iio_priv(indio_dev);
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_PROCESSED:
> +		if (info->buffered && !info->ts_attached)
> +			return -EBUSY;
> +
>  		ret = sunxi_gpadc_temp_read(indio_dev, val);
>  		if (ret)
>  			return ret;
>  
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_RAW:
Definitely use the iio_claim_direct_mode stuff here to avoid possible races
with the buffer being enabled whilst this read is in flight.
> +		if (info->buffered)
> +			return -EBUSY;
> +
>  		ret = sunxi_gpadc_adc_read(indio_dev, chan->channel, val);
>  		if (ret)
>  			return ret;
> @@ -261,7 +302,29 @@ static irqreturn_t sunxi_gpadc_temp_data_irq_handler(int irq, void *dev_id)
>  static irqreturn_t sunxi_gpadc_fifo_data_irq_handler(int irq, void *dev_id)
>  {
>  	struct sunxi_gpadc_dev *info = dev_id;
> -	int ret;
> +	int ret, reg, i, fifo_count;
> +
> +	if (info->buffered) {
> +		if (regmap_read(info->regmap, SUNXI_GPADC_TP_INT_FIFOS, &reg))
> +			return IRQ_HANDLED;
> +
> +		fifo_count = (reg & SUNXI_GPADC_RXA_CNT) >> 8;
> +		/* Sometimes, the interrupt occurs when the FIFO is empty. */
> +		if (!fifo_count)
> +			return IRQ_HANDLED;
> +
> +		for (i = 0; i < fifo_count; i++) {
> +			if (regmap_read(info->regmap, SUNXI_GPADC_TP_DATA,
> +					&info->buffer.buffer[i]))
> +				return IRQ_HANDLED;
> +		}
> +
> +		info->buffer.buff_size = i;
> +
> +		iio_push_to_buffers(info->indio_dev, &info->buffer);
This is expecting a single 'scan' - e.g. set of channels read at one
time.  Here I think we could have repeated sets of channels?
(at least that would be what is normally meant by a fifo in such
a device).

If so you need to read 'whole' scans and push them one at a time.
We don't yet have a bulk iio_push_to_buffers, though we can add
one if it makes sense.  Care will be needed though as we'd need
handle the case of different consumers either supporting or
not supporting this new functionality.  Not particularly hard though
if it is worth doing.
> +
> +		return IRQ_HANDLED;
> +	}
>  
>  	ret = regmap_read(info->regmap, SUNXI_GPADC_TP_DATA, &info->adc_data);
>  	if (ret == 0)
> @@ -270,6 +333,58 @@ static irqreturn_t sunxi_gpadc_fifo_data_irq_handler(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> +static int sunxi_gpadc_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct sunxi_gpadc_dev *info = iio_priv(indio_dev);
> +	unsigned int reg;
> +	int ret;
> +
> +	reg = SUNXI_GPADC_TP_FIFO_TRIG_LEVEL(1) | SUNXI_GPADC_TP_FIFO_FLUSH;
> +	regmap_update_bits(info->regmap, SUNXI_GPADC_TP_INT_FIFOC, reg, reg);
Check for errors and return them...
> +
> +	if (info->ts_attached) {
> +		reg = SUNXI_GPADC_STYLUS_UP_DEBOUNCE(5) |
> +		      SUNXI_GPADC_STYLUS_UP_DEBOUNCE_EN;
> +
> +		if (info->flags & SUNXI_GPADC_ARCH_SUN6I)
> +			reg |= SUNXI_GPADC_SUN6I_TP_MODE_EN;
> +		else
> +			reg |= SUNXI_GPADC_TP_MODE_EN;
> +	} else {
> +		if (info->flags & SUNXI_GPADC_ARCH_SUN6I)
> +			reg = SUNXI_GPADC_SUN6I_TP_MODE_EN |
> +			      SUNXI_GPADC_SUN6I_TP_ADC_SELECT;
> +		else
> +			reg = SUNXI_GPADC_TP_MODE_EN |
> +			      SUNXI_GPADC_TP_ADC_SELECT;
> +	}
> +
> +	if (regmap_write(info->regmap, SUNXI_GPADC_TP_CTRL1, reg))
> +		return ret;
ret hasn't been initialized and anwyay it should be the return of
regmap_write.
> +
> +	info->buffered = true;
> +
> +	enable_irq(info->fifo_data_irq);
Needs a comment to explain why this is needed.  Until the above enables
IRQs I'd normally expect them to simply not occur.  Hence it's
unusual to have to explicitly mask them in such a driver as this.
> +
> +	return 0;
> +}
> +
> +static int sunxi_gpadc_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct sunxi_gpadc_dev *info = iio_priv(indio_dev);
> +
> +	disable_irq(info->fifo_data_irq);
I would undo the various enables above to get back to the state
prior to postenable above.
> +
> +	info->buffered = false;
> +
> +	return 0;
> +}
> +
> +static const struct iio_buffer_setup_ops sunxi_gpadc_buffer_setup_ops = {
> +	.postenable = sunxi_gpadc_buffer_postenable,
> +	.predisable = sunxi_gpadc_buffer_predisable,
> +};
> +
>  static int sunxi_gpadc_probe(struct platform_device *pdev)
>  {
>  	struct sunxi_gpadc_dev *info;
> @@ -286,16 +401,20 @@ static int sunxi_gpadc_probe(struct platform_device *pdev)
>  	info = iio_priv(indio_dev);
>  
>  	info->regmap = sunxi_gpadc_mfd_dev->regmap;
> +	info->indio_dev = indio_dev;
Not used as far as I can see.
>  	init_completion(&info->completion);
>  	indio_dev->name = dev_name(&pdev->dev);
>  	indio_dev->dev.parent = &pdev->dev;
>  	indio_dev->dev.of_node = pdev->dev.of_node;
>  	indio_dev->info = &sunxi_gpadc_iio_info;
> -	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
>  	indio_dev->num_channels = ARRAY_SIZE(sunxi_gpadc_channels);
>  	indio_dev->channels = sunxi_gpadc_channels;
> +	indio_dev->setup_ops = &sunxi_gpadc_buffer_setup_ops;
>  
>  	info->flags = platform_get_device_id(pdev)->driver_data;
> +	info->ts_attached = of_property_read_bool(pdev->dev.parent->of_node,
> +						  "allwinner,ts-attached");
>  
>  	regmap_write(info->regmap, SUNXI_GPADC_TP_CTRL0, SUNXI_GPADC_FS_DIV(7) |
>  		     SUNXI_GPADC_ADC_CLK_DIVIDER(2) | SUNXI_GPADC_T_ACQ(63));
> @@ -305,6 +424,8 @@ static int sunxi_gpadc_probe(struct platform_device *pdev)
>  	else
>  		regmap_write(info->regmap, SUNXI_GPADC_TP_CTRL1,
>  			     SUNXI_GPADC_TP_MODE_EN);
> +	regmap_write(info->regmap, SUNXI_GPADC_TP_CTRL2,
> +		     SUNXI_GPADC_TP_SENSITIVE_ADJUST(15));
>  	regmap_write(info->regmap, SUNXI_GPADC_TP_CTRL3, SUNXI_GPADC_FILTER_EN |
>  		     SUNXI_GPADC_FILTER_TYPE(1));
>  	regmap_write(info->regmap, SUNXI_GPADC_TP_TPR,
> 
