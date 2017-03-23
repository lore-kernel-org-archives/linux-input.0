From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv3 1/2] mfd: cpcap: implement irq sense helper
Date: Thu, 23 Mar 2017 14:23:37 +0000
Message-ID: <20170323142337.4c4d6lnhqtugbb2r@dell>
References: <20170321225042.28057-1-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170321225042.28057-1-sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, 21 Mar 2017, Sebastian Reichel wrote:

> CPCAP can sense if IRQ is currently set or not. This
> functionality is required for a few subdevices, such
> as the power button and usb phy modules.
> 
> Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
> Changes since PATCHv2:
>  - Collect Acked-by/Tested-by
>  - Fix typo in EXPORT_SYMBOL_GPL
> ---
>  drivers/mfd/motorola-cpcap.c       | 25 +++++++++++++++++++++++++
>  include/linux/mfd/motorola-cpcap.h |  2 ++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/drivers/mfd/motorola-cpcap.c b/drivers/mfd/motorola-cpcap.c
> index 6aeada7d7ce5..a1e364b42e47 100644
> --- a/drivers/mfd/motorola-cpcap.c
> +++ b/drivers/mfd/motorola-cpcap.c
> @@ -32,6 +32,31 @@ struct cpcap_ddata {
>  	struct regmap *regmap;
>  };
>  
> +static int cpcap_sense_irq(struct regmap *regmap, int irq)
> +{
> +	int reg = CPCAP_REG_INTS1 + (irq / 16) * 4;
> +	int mask = 1 << (irq % 16);

Can you place all this bit-wise hoop jumping in macros please?

Also please use the BIT() macro.

> +	int err, val;
> +
> +	if (irq < 0 || irq > 64)
> +		return -EINVAL;

What's wrong with IRQ 65?

I'm *guessing* there isn't one.

You can make this clearer by defining CPCAP_SENSE_IRQ_MAX.

> +	err = regmap_read(regmap, reg, &val);
> +	if (err)
> +		return err;
> +
> +	return !!(val & mask);
> +}
> +
> +int cpcap_sense_virq(struct regmap *regmap, int virq)
> +{
> +	struct regmap_irq_chip_data *d = irq_get_chip_data(virq);
> +	int base = regmap_irq_chip_get_base(d);
> +
> +	return cpcap_sense_irq(regmap, virq - base);
> +}
> +EXPORT_SYMBOL_GPL(cpcap_sense_virq);
> +
>  static int cpcap_check_revision(struct cpcap_ddata *cpcap)
>  {
>  	u16 vendor, rev;
> diff --git a/include/linux/mfd/motorola-cpcap.h b/include/linux/mfd/motorola-cpcap.h
> index b4031c2b2214..7629e0d24d26 100644
> --- a/include/linux/mfd/motorola-cpcap.h
> +++ b/include/linux/mfd/motorola-cpcap.h
> @@ -290,3 +290,5 @@ static inline int cpcap_get_vendor(struct device *dev,
>  
>  	return 0;
>  }
> +
> +int cpcap_sense_virq(struct regmap *regmap, int virq);

extern?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
