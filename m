From: "mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v9 2/9] Input: goodix - reset device at init
Date: Mon, 2 Nov 2015 12:17:33 +0200
Message-ID: <20151102101733.GB1509@lahna.fi.intel.com>
References: <1F3AC3675D538145B1661F571FE1805F2F0FE432@irsmsx105.ger.corp.intel.com>
 <20151013070824.GA22304@dtor-ws>
 <1F3AC3675D538145B1661F571FE1805F2F0FE683@irsmsx105.ger.corp.intel.com>
 <20151013100724.GG1492@lahna.fi.intel.com>
 <20151014062303.GC20406@dtor-ws>
 <20151014111820.GV1492@lahna.fi.intel.com>
 <20151014134403.GA25691@lahna.fi.intel.com>
 <1F3AC3675D538145B1661F571FE1805F2F101AC0@irsmsx105.ger.corp.intel.com>
 <20151019145239.GA1526@lahna.fi.intel.com>
 <20151030163328.GA17589@dtor-pixel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151030163328.GA17589@dtor-pixel>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Tirdea, Irina" <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, Aleksei Mamlin <mamlinav-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Karsten Merker <merker-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "Purdila, Octavian" <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Dolca, Robert" <robert.dolca-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Fri, Oct 30, 2015 at 09:33:28AM -0700, Dmitry Torokhov wrote:
> cpi_dev_add_driver_gpios() does not really help with generic drivers
> (unless we keep adding more and more board specific data to them). How
> about we keep track of names used and only allow conversion for the
> first name used, like in the patch below?

That works but it misses one case: When you have optional GPIOs and not
all of them are provided. Currently it ends up the same situation
returning the same GPIO.

I've commented below how we could handle that case as well.

> -- 
> Dmitry
> 
> gpiolib: tighten up ACPI legacy gpio lookups
> 
> From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> We should not fall back to the legacy unnamed gpio lookup style if the
> driver requests gpios with different names, because we'll give out the same
> gpio twice. Let's keep track of the names that were used for the device and
> only do the fallback for the first name used.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/gpio/gpiolib.c |   42 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 5db3445..4ae5447 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -1738,6 +1738,45 @@ static struct gpio_desc *of_find_gpio(struct device *dev, const char *con_id,
>  	return desc;
>  }
>  
> +struct acpi_gpio_lookup {
> +	struct list_head node;
> +	struct device *dev;
> +	const char *con_id;
> +};
> +
> +static DEFINE_MUTEX(acpi_gpio_lookup_lock);
> +static LIST_HEAD(acpi_gpio_lookup_list);
> +
> +static bool acpi_can_fallback_crs(struct device *dev, const char *con_id)
> +{
> +	struct acpi_gpio_lookup *l, *lookup = NULL;

I'm thinking if we here do

	struct acpi_device *adev = ACPI_COMPANION(dev);

	/* Never fallback if the device has properties */
	if (adev->data.properties || adev->driver_gpios)
		return false;

> +
> +	mutex_lock(&acpi_gpio_lookup_lock);
> +
> +	list_for_each_entry(l, &acpi_gpio_lookup_list, node) {
> +		if (l->dev == dev) {
> +			lookup = l;
> +			break;
> +		}
> +	}
> +
> +	if (!lookup) {
> +		lookup = kmalloc(sizeof(*lookup), GFP_KERNEL);
> +		if (lookup) {
> +			lookup->dev = dev;
> +			lookup->con_id = con_id;
> +			list_add_tail(&lookup->node, &acpi_gpio_lookup_list);
> +		}
> +	}
> +
> +	mutex_lock(&acpi_gpio_lookup_lock);
> +
> +	return lookup &&
> +		((!lookup->con_id && !con_id) ||
> +		 (lookup->con_id && con_id &&
> +		  strcmp(lookup->con_id, con_id) == 0));
> +}
> +
>  static struct gpio_desc *acpi_find_gpio(struct device *dev, const char *con_id,
>  					unsigned int idx,
>  					enum gpio_lookup_flags *flags)
> @@ -1765,7 +1804,8 @@ static struct gpio_desc *acpi_find_gpio(struct device *dev, const char *con_id,
>  
>  	/* Then from plain _CRS GPIOs */
>  	if (IS_ERR(desc)) {
> -		desc = acpi_get_gpiod_by_index(adev, NULL, idx, &info);
> +		if (acpi_can_fallback_crs(dev, con_id))
> +			desc = acpi_get_gpiod_by_index(adev, NULL, idx, &info);

and here we could do

		if (!acpi_can_fallback_crs(dev, con_id))
			return ERR_PTR(-ENOENT);
		desc = acpi_get_gpiod_by_index(adev, NULL, idx, &info);

So instead return -ENOENT so that gpiod_get_index_optional() handles the
missing optional GPIO properly.

>  		if (IS_ERR(desc))
>  			return desc;
>  	}
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
