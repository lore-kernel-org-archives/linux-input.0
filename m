From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 09/14] iio: inkern: triggers: create helpers for OF
 trigger retrieval
Date: Fri, 29 Dec 2017 17:20:32 +0000
Message-ID: <20171229172032.3f5cb6c1@archlinux>
References: <1513955241-10985-1-git-send-email-eugen.hristev@microchip.com>
        <1513955241-10985-10-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1513955241-10985-10-git-send-email-eugen.hristev-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eugen Hristev <eugen.hristev-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Cc: nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Fri, 22 Dec 2017 17:07:16 +0200
Eugen Hristev <eugen.hristev-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org> wrote:

> Create helper API to get trigger information from OF regarding
> trigger producer/consumer for iio triggers.
> The functions will search for matching trigger by name, similar
> with channel retrieval
> 
> Signed-off-by: Eugen Hristev <eugen.hristev-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>

This makes sense once we make the touchscreen driver truely generic.
If it wasn't generic this could be rolled up as data within that driver.

A few small comments inline.

> ---
>  drivers/iio/inkern.c                 | 91 ++++++++++++++++++++++++++++++++++++
>  include/linux/iio/trigger_consumer.h |  1 +
>  2 files changed, 92 insertions(+)
> 
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index 069defc..58bd18d 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -14,9 +14,13 @@
>  
>  #include <linux/iio/iio.h>
>  #include "iio_core.h"
> +#include "iio_core_trigger.h"
>  #include <linux/iio/machine.h>
>  #include <linux/iio/driver.h>
>  #include <linux/iio/consumer.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +
Don't add white space here.
>  
>  struct iio_map_internal {
>  	struct iio_dev *indio_dev;
> @@ -262,6 +266,39 @@ static struct iio_channel *of_iio_channel_get_all(struct device *dev)
>  	return ERR_PTR(ret);
>  }
>  
> +#ifdef CONFIG_IIO_TRIGGER
Hmm. Generally frowned upon to have ifdef blocks inline within c files.
Perhaps worth pulling these out to inkern-trigger.c and using Kconfig magic
to build if relevant - not worth splitting the header though.

> +
> +static struct iio_trigger *of_iio_trigger_get(struct device_node *np, int index)
> +{
> +	struct device *idev;
> +	struct iio_dev *indio_dev;
> +	int err;
> +	struct of_phandle_args iiospec;
> +	struct iio_trigger *trig;
> +
> +	err = of_parse_phandle_with_args(np, "io-triggers",
> +					 "#io-trigger-cells",
> +					 index, &iiospec);
> +	if (err)
> +		return ERR_PTR(err);
> +
> +	idev = bus_find_device(&iio_bus_type, NULL, iiospec.np,
> +			       iio_dev_node_match);
> +	of_node_put(iiospec.np);
> +	if (!idev)
> +		return ERR_PTR(-EPROBE_DEFER);
> +
> +	indio_dev = dev_to_iio_dev(idev);
> +
> +	trig = iio_trigger_find_from_device(indio_dev, iiospec.args[0]);
> +
> +	if (!trig)
> +		return ERR_PTR(-ENODEV);
> +
> +	return trig;
> +}
> +#endif /* CONFIG_IIO_TRIGGER */
> +
>  #else /* CONFIG_OF */
>  
>  static inline struct iio_channel *
> @@ -275,6 +312,12 @@ static inline struct iio_channel *of_iio_channel_get_all(struct device *dev)
>  	return NULL;
>  }
>  
> +static inline struct iio_trigger *of_iio_trigger_get(struct device_node *np,
> +						     int index)
> +{
> +	return NULL;
> +}
> +
>  #endif /* CONFIG_OF */
>  
>  static struct iio_channel *iio_channel_get_sys(const char *name,
> @@ -927,3 +970,51 @@ ssize_t iio_write_channel_ext_info(struct iio_channel *chan, const char *attr,
>  			       chan->channel, buf, len);
>  }
>  EXPORT_SYMBOL_GPL(iio_write_channel_ext_info);
> +
> +#ifdef CONFIG_IIO_TRIGGER
> +struct iio_trigger *iio_trigger_find(struct device *dev, char *name)
> +{
> +	struct device_node *np = dev->of_node;
> +	struct iio_trigger *trig = NULL;
> +
> +	/* Walk up the tree of devices looking for a matching iio trigger */
> +	while (np) {
> +		int index = 0;
> +
> +		/*
> +		 * For named iio triggers, first look up the name in the
> +		 * "io-trigger-names" property.  If it cannot be found, the
> +		 * index will be an error code, and of_iio_trigger_get()
> +		 * will fail.
> +		 */
> +		if (name)
> +			index = of_property_match_string(np, "io-trigger-names",
> +							 name);
> +		trig = of_iio_trigger_get(np, index);
> +		if (!IS_ERR(trig) || PTR_ERR(trig) == -EPROBE_DEFER) {
> +			break;
> +		} else if (name && index >= 0) {
> +			pr_err("ERROR: could not get IIO trigger %pOF:%s(%i)\n",
> +			       np, name ? name : "", index);
> +			return trig;
> +		}
> +
> +		/*
> +		 * No matching IIO trigger found on this node.
> +		 * If the parent node has a "io-trigger-ranges" property,
> +		 * then we can try one of its channels.
> +		 */
> +		np = np->parent;
> +		if (np && !of_get_property(np, "io-trigger-ranges", NULL))
> +			return trig;
> +	}
> +
> +	if (!trig || (IS_ERR(trig) && PTR_ERR(trig) != -EPROBE_DEFER))
> +		dev_dbg(dev, "error retrieving trigger information\n");
> +	else
> +		dev_dbg(dev, "trigger found: %s\n", name);
> +
> +	return trig;
> +}
> +EXPORT_SYMBOL_GPL(iio_trigger_find);
> +#endif /* CONFIG_IIO_TRIGGER */
> diff --git a/include/linux/iio/trigger_consumer.h b/include/linux/iio/trigger_consumer.h
> index 13be595..b2fc485 100644
> --- a/include/linux/iio/trigger_consumer.h
> +++ b/include/linux/iio/trigger_consumer.h
> @@ -62,6 +62,7 @@ irqreturn_t iio_pollfunc_store_time(int irq, void *p);
>  
>  void iio_trigger_notify_done(struct iio_trigger *trig);
>  
> +struct iio_trigger *iio_trigger_find(struct device *dev, char *name);
>  /*
>   * Two functions for common case where all that happens is a pollfunc
>   * is attached and detached from a trigger

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
