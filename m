From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 12/22] iio/ti_tscadc: Update with IIO map interface
Date: Sat, 08 Jun 2013 10:18:37 +0100
Message-ID: <51B2F6ED.6030702@kernel.org>
References: <1370449495-29981-1-git-send-email-bigeasy@linutronix.de> <1370449495-29981-13-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1370449495-29981-13-git-send-email-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 06/05/2013 05:24 PM, Sebastian Andrzej Siewior wrote:
> From: Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
>
> Add an IIO map interface that consumers can use.
>
Nicely done and much cleaner.  Thanks,

> Signed-off-by: Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
> Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> [bigeasy: use static AIN[0-8] names, plugged a mem leak, use kcalloc()]
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Acked-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
>  drivers/iio/adc/ti_am335x_adc.c |   57 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 51 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
> index 502e929..c6695a8 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -24,12 +24,15 @@
>  #include <linux/iio/iio.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/iio/machine.h>
> +#include <linux/iio/driver.h>
>
>  #include <linux/mfd/ti_am335x_tscadc.h>
>
>  struct tiadc_device {
>  	struct ti_tscadc_dev *mfd_tscadc;
>  	int channels;
> +	struct iio_map *map;
>  };
>
>  static unsigned int tiadc_readl(struct tiadc_device *adc, unsigned int reg)
> @@ -84,34 +87,76 @@ static void tiadc_step_config(struct tiadc_device *adc_dev)
>  	am335x_tsc_se_set(adc_dev->mfd_tscadc, step_en);
>  }
>
> +static const char * const chan_name_ain[] = {
> +	"AIN0",
> +	"AIN1",
> +	"AIN2",
> +	"AIN3",
> +	"AIN4",
> +	"AIN5",
> +	"AIN6",
> +	"AIN7",
> +};
> +
>  static int tiadc_channel_init(struct iio_dev *indio_dev, int channels)
>  {
> +	struct tiadc_device *adc_dev = iio_priv(indio_dev);
>  	struct iio_chan_spec *chan_array;
> -	int i;
> +	struct iio_chan_spec *chan;
> +	int i, ret;
>
>  	indio_dev->num_channels = channels;
> -	chan_array = kcalloc(indio_dev->num_channels,
> +	chan_array = kcalloc(channels,
>  			sizeof(struct iio_chan_spec), GFP_KERNEL);
> -
>  	if (chan_array == NULL)
>  		return -ENOMEM;
>
> -	for (i = 0; i < (indio_dev->num_channels); i++) {
> -		struct iio_chan_spec *chan = chan_array + i;
> +	chan = chan_array;
> +	for (i = 0; i < channels; i++, chan++) {
> +
>  		chan->type = IIO_VOLTAGE;
>  		chan->indexed = 1;
>  		chan->channel = i;
>  		chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
> +		chan->datasheet_name = chan_name_ain[i];
> +		chan->scan_type.sign = 'u';
> +		chan->scan_type.realbits = 12;
> +		chan->scan_type.storagebits = 32;
> +		chan->scan_type.shift = 0;
>  	}
>
>  	indio_dev->channels = chan_array;
>
> -	return indio_dev->num_channels;
> +	adc_dev->map = kcalloc(channels + 1, sizeof(struct iio_map),
> +			GFP_KERNEL);
> +	if (adc_dev->map == NULL)
> +		goto err_free_chan;
> +
> +	for (i = 0; i < channels; i++) {
> +		adc_dev->map[i].adc_channel_label =
> +			chan_array[i].datasheet_name;
> +		adc_dev->map[i].consumer_dev_name = "any";
> +		adc_dev->map[i].consumer_channel = chan_array[i].datasheet_name;
> +	}
> +
> +	ret = iio_map_array_register(indio_dev, adc_dev->map);
> +	if (ret)
> +		goto err_map;
> +
> +	return 0;
> +err_map:
> +	kfree(adc_dev->map);
> +err_free_chan:
> +	kfree(chan_array);
> +	return -ENOMEM;
>  }
>
>  static void tiadc_channels_remove(struct iio_dev *indio_dev)
>  {
> +	struct tiadc_device *adc_dev = iio_priv(indio_dev);
> +
>  	kfree(indio_dev->channels);
> +	kfree(adc_dev->map);
>  }
>
>  static int tiadc_read_raw(struct iio_dev *indio_dev,
>
