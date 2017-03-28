From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCHv4] mfd: cpcap: implement irq sense helper
Date: Tue, 28 Mar 2017 11:27:16 +0100
Message-ID: <20170328102716.gz7agm7kx3gz56jt@dell>
References: <20170323142337.4c4d6lnhqtugbb2r@dell>
 <20170324084240.23251-1-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f170.google.com ([209.85.128.170]:34060 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754337AbdC1K1V (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 28 Mar 2017 06:27:21 -0400
Received: by mail-wr0-f170.google.com with SMTP id l43so97199780wre.1
        for <linux-input@vger.kernel.org>; Tue, 28 Mar 2017 03:27:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170324084240.23251-1-sre@kernel.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 24 Mar 2017, Sebastian Reichel wrote:

> CPCAP can sense if IRQ is currently set or not. This
> functionality is required for a few subdevices, such
> as the power button and usb phy modules.
> 
> Acked-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> 
> ---
> Hi Lee,
> 
> I hope this is fine with you. I tried to come up
> with a sensible macro for reg, but everything I
> came up with actually reduced readability.
> 
> -- Sebastian
> 
> Changes since PATCHv3:
>  - add explicit extern to function definition
>  - use BIT macro for mask variable
>  - avoid magic numbers
> ---
>  drivers/mfd/motorola-cpcap.c       | 28 ++++++++++++++++++++++++++++
>  include/linux/mfd/motorola-cpcap.h |  2 ++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/drivers/mfd/motorola-cpcap.c b/drivers/mfd/motorola-cpcap.c
> index 6aeada7d7ce5..c80997a377a1 100644
> --- a/drivers/mfd/motorola-cpcap.c
> +++ b/drivers/mfd/motorola-cpcap.c
> @@ -23,6 +23,8 @@
>  
>  #define CPCAP_NR_IRQ_REG_BANKS	6
>  #define CPCAP_NR_IRQ_CHIPS	3
> +#define CPCAP_REGISTER_SIZE 4
> +#define CPCAP_REGISTER_BITS 16
>  
>  struct cpcap_ddata {
>  	struct spi_device *spi;
> @@ -32,6 +34,32 @@ struct cpcap_ddata {
>  	struct regmap *regmap;
>  };
>  
> +static int cpcap_sense_irq(struct regmap *regmap, int irq)
> +{
> +	int regnum = irq / CPCAP_REGISTER_BITS;
> +	int mask = BIT(irq % CPCAP_REGISTER_BITS);
> +	int reg = CPCAP_REG_INTS1 + (regnum * CPCAP_REGISTER_SIZE);
> +	int err, val;
> +
> +	if (reg < CPCAP_REG_INTS1 || reg > CPCAP_REG_INTS4)
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

What base is this?  Could it be used to avoid some calculations in
cpcap_sense_irq()?

> +	return cpcap_sense_irq(regmap, virq - base);
> +}
> +EXPORT_SYMBOL_GPL(cpcap_sense_virq);
> +
>  static int cpcap_check_revision(struct cpcap_ddata *cpcap)
>  {
>  	u16 vendor, rev;
> diff --git a/include/linux/mfd/motorola-cpcap.h b/include/linux/mfd/motorola-cpcap.h
> index b4031c2b2214..793aa695faa0 100644
> --- a/include/linux/mfd/motorola-cpcap.h
> +++ b/include/linux/mfd/motorola-cpcap.h
> @@ -290,3 +290,5 @@ static inline int cpcap_get_vendor(struct device *dev,
>  
>  	return 0;
>  }
> +
> +extern int cpcap_sense_virq(struct regmap *regmap, int virq);

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
