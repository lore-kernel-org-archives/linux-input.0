From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH 3/5] iio: adc: sunxi-gpadc-iio: enable iio_buffers
Date: Wed, 20 Jul 2016 10:38:40 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1607201034450.18224@pmeerw.net>
References: <1469003351-15263-1-git-send-email-quentin.schulz@free-electrons.com> <1469003351-15263-4-git-send-email-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:44454 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751615AbcGTIin (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Jul 2016 04:38:43 -0400
In-Reply-To: <1469003351-15263-4-git-send-email-quentin.schulz@free-electrons.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, maxime.ripard@free-electrons.com, wens@csie.org, dmitry.torokhov@gmail.com, lee.jones@linaro.org, antoine.tenart@free-electrons.com, thomas.petazzoni@free-electrons.com, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org


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

comments below
 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
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
>  #include <linux/iio/machine.h>
>  #include <linux/mfd/sunxi-gpadc-mfd.h>
>  
> @@ -71,6 +72,7 @@
>  #define SUNXI_GPADC_TP_DATA_XY_CHANGE		BIT(13)
>  #define SUNXI_GPADC_TP_FIFO_TRIG_LEVEL(x)	((x) << 8)  /* 5 bits */
>  #define SUNXI_GPADC_TP_DATA_DRQ_EN		BIT(7)
> +/* Be careful, flushing FIFO spawns SUNXI_GPADC_FIFO_DATA_PENDING interrupts */
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
> +	struct sunxi_gpadc_buffer	buffer;
> +	bool				ts_attached;
> +	bool				buffered;

why add buffered, duplicate state and not query iio_buffer_enabled()?

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

shift not strictly needed

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
>  };
>  
>  static int sunxi_gpadc_adc_read(struct iio_dev *indio_dev, int channel,
>  				int *val)
>  {
>  	struct sunxi_gpadc_dev *info = iio_priv(indio_dev);
> +	bool buffered = info->buffered;
>  	int ret = 0;
> +	unsigned int reg;
>  
>  	mutex_lock(&indio_dev->mlock);
>  
>  	reinit_completion(&info->completion);
> +
> +	reg = SUNXI_GPADC_TP_FIFO_TRIG_LEVEL(1) | SUNXI_GPADC_TP_FIFO_FLUSH;
> +	regmap_update_bits(info->regmap, SUNXI_GPADC_TP_INT_FIFOC, reg, reg);
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

there would be iio_device_claim_direct_mode()

> +
>  		ret = sunxi_gpadc_temp_read(indio_dev, val);
>  		if (ret)
>  			return ret;
>  
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_RAW:
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
> +
> +	info->buffered = true;
> +
> +	enable_irq(info->fifo_data_irq);
> +
> +	return 0;
> +}
> +
> +static int sunxi_gpadc_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct sunxi_gpadc_dev *info = iio_priv(indio_dev);
> +
> +	disable_irq(info->fifo_data_irq);
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

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
