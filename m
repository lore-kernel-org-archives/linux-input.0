From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC_v2 3/4] HID: hid-sony: Add IIO trigger support for SixAxis
 Controller
Date: Sun, 05 Jul 2015 14:58:36 +0100
Message-ID: <5599380C.7000506@kernel.org>
References: <1435105830-2297-1-git-send-email-simon@mungewell.org> <1435105830-2297-4-git-send-email-simon@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1435105830-2297-4-git-send-email-simon-wM4F9T/ekXmXDw4h08c5KA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Simon Wood <simon-wM4F9T/ekXmXDw4h08c5KA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Frank Praznik <frank.praznik-oKii7tqusJgAvxtiuMwx3w@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 24/06/15 01:30, Simon Wood wrote:
Description here please and sign-off etc (though as this is an RFC
perhaps you don't consider it ready to be signed off on?)

Main issue I've spotted in here is in the ordering in remove...

J
> ---
>  drivers/hid/hid-sony.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 69 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index b7a7f0d..ce0526d 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -39,9 +39,11 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/buffer.h>
> +#include <linux/iio/trigger.h>
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
>  #include <linux/interrupt.h>
> +#include <linux/irq_work.h>
>  
>  #include "hid-ids.h"
>  
> @@ -855,9 +857,14 @@ enum sony_iio_axis {
>  	AXIS_ACC_Z,
>  };
>  
> +static void sony_iio_trigger_work(struct irq_work *work);
> +
>  struct sony_iio {
>  	struct sony_sc *sc;
> +	struct iio_trigger *trig;
> +
>  	u8 buff[16];		/* 3x 16-bit + padding + timestamp */
> +	struct irq_work work;
>  #endif
>  };
>  
> @@ -1076,6 +1083,13 @@ static int sony_raw_event(struct hid_device *hdev, struct hid_report *report,
>  		sc->last_data[AXIS_ACC_X] = (rd[42] << 8) + rd[41];
>  		sc->last_data[AXIS_ACC_Y] = (rd[44] << 8) + rd[43];
>  		sc->last_data[AXIS_ACC_Z] = (rd[46] << 8) + rd[45];
> +
> +		if (sc->indio_dev) {
> +			struct sony_iio *data;
> +
> +			data = iio_priv(sc->indio_dev);
> +			sony_iio_trigger_work(&data->work);
> +		}
>  #endif
>  		sixaxis_parse_report(sc, rd, size);
>  	} else if (((sc->quirks & DUALSHOCK4_CONTROLLER_USB) && rd[0] == 0x01 &&
> @@ -1869,6 +1883,28 @@ static const struct iio_info sony_iio_info = {
>  	.driver_module = THIS_MODULE,
>  };
>  
> +static void sony_iio_trigger_work(struct irq_work *work)
> +{
> +	struct sony_iio *data = container_of(work, struct sony_iio, work);
> +
> +	iio_trigger_poll(data->trig);
> +}
> +
> +static ssize_t sony_iio_trigger_poll(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct iio_trigger *trig = to_iio_trigger(dev);
> +	struct sony_iio *data = iio_trigger_get_drvdata(trig);
> +
> +	irq_work_queue(&data->work);
> +
> +	return count;
> +}
> +
> +static const struct iio_trigger_ops sony_iio_trigger_ops = {
> +	.owner = THIS_MODULE,
> +};
> +
>  static irqreturn_t sony_iio_trigger_handler(int irq, void *p)
>  {
>  	struct iio_poll_func *pf = p;
> @@ -1910,11 +1946,29 @@ static int sony_iio_probe(struct sony_sc *sc)
>  	indio_dev->channels = sony_sixaxis_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(sony_sixaxis_channels);
>  
> +	data->trig = iio_trigger_alloc("%s-dev%d", indio_dev->name,
> +		indio_dev->id);
> +	if (!data->trig) {
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +
> +	data->trig->dev.parent = &hdev->dev;
> +	data->trig->ops = &sony_iio_trigger_ops;
> +	iio_trigger_set_drvdata(data->trig, indio_dev);
> +	indio_dev->trig = iio_trigger_get(data->trig);
> +
> +	init_irq_work(&data->work, sony_iio_trigger_work);
> +
> +	ret = iio_trigger_register(data->trig);
> +	if (ret)
> +		goto err_trigger_free;
> +
>  	ret = iio_triggered_buffer_setup(indio_dev, NULL,
>  			sony_iio_trigger_handler, NULL);
>  	if (ret < 0) {
>  		dev_err(&hdev->dev, "unable to setup iio triggered buffer\n");
> -		goto err;
> +		goto err_trigger_unregister;
>  	}
>  
>  	ret = iio_device_register(indio_dev);
> @@ -1926,6 +1980,11 @@ static int sony_iio_probe(struct sony_sc *sc)
>  
>  err_buffer_cleanup:
>  	iio_triggered_buffer_cleanup(indio_dev);
> +err_trigger_unregister:
> +	if (data->trig)
> +		iio_trigger_unregister(data->trig);
> +err_trigger_free:
> +	iio_trigger_free(data->trig);
>  err:
>  	kfree(indio_dev);
>  	sc->indio_dev = NULL;
> @@ -1934,11 +1993,19 @@ err:
>  
>  static void sony_iio_remove(struct sony_sc *sc)
>  {
> +	struct sony_iio *data;
> +
>  	if (!sc->indio_dev)
>  		return;
>  
> -	iio_device_unregister(sc->indio_dev);
> +	data = iio_priv(sc->indio_dev);
> +
>  	iio_triggered_buffer_cleanup(sc->indio_dev);
> +	if (data->trig)
> +		iio_trigger_unregister(data->trig);
> +	iio_trigger_free(data->trig);
> +	iio_device_unregister(sc->indio_dev);
Nope. Device still wants to be unregistered first.  That removes
the userspace interfaces and at least reduces the chance of a race
condition.
> +
>  	kfree(sc->indio_dev);
>  	sc->indio_dev = NULL;
>  }
> 
