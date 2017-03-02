From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 1/2] mfd: cpcap: implement irq sense helper
Date: Thu, 2 Mar 2017 08:09:12 -0800
Message-ID: <20170302160912.GO20572@atomide.com>
References: <20170224085909.30559-1-sre@kernel.org>
 <20170302002242.21819-1-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170302002242.21819-1-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

* Sebastian Reichel <sre@kernel.org> [170301 16:24]:
> CPCAP can sense if IRQ is currently set or not. This
> functionality is required for a few subdevices, such
> as the power button and usb phy modules.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
> Changes since PATCHv1:
>  - Newly introduced patch
> ---
>  drivers/mfd/motorola-cpcap.c       | 25 +++++++++++++++++++++++++
>  include/linux/mfd/motorola-cpcap.h |  2 ++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/drivers/mfd/motorola-cpcap.c b/drivers/mfd/motorola-cpcap.c
> index 6aeada7d7ce5..b2a53750d579 100644
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
> +	int err, val;
> +
> +	if (irq < 0 || irq > 64)
> +		return -EINVAL;
> +
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
> +EXPORT_SYMBOL_GPL(cpcap_sense_irq);

You have a typo here, should be cpcap_sense_virq for the exported one :)

Other than that my ack is still valid.

Regards,

Tony
