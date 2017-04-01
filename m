From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/6] Input: pm8xxx-vib: handle separate enable register
Date: Sat, 1 Apr 2017 10:06:55 -0700
Message-ID: <20170401170655.GG17130@dtor-ws>
References: <20170331161538.11657-1-damien.riegel@savoirfairelinux.com>
 <20170331161538.11657-4-damien.riegel@savoirfairelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33360 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751791AbdDARG6 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 1 Apr 2017 13:06:58 -0400
Received: by mail-pg0-f68.google.com with SMTP id 79so22674959pgf.0
        for <linux-input@vger.kernel.org>; Sat, 01 Apr 2017 10:06:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170331161538.11657-4-damien.riegel@savoirfairelinux.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Damien Riegel <damien.riegel@savoirfairelinux.com>
Cc: linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, kernel@savoirfairelinux.com

On Fri, Mar 31, 2017 at 12:15:36PM -0400, Damien Riegel wrote:
> Some PMIC vibrator IPs use a separate enable register to turn the
> vibrator on and off. To detect if a vibrator uses this feature, rely on
> the enable_mask being non-zero.
> 
> If they use it, the device tree is queried to retrieve the base address
> of the control and enable registers.
> 
> Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
> ---
>  drivers/input/misc/pm8xxx-vibrator.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/misc/pm8xxx-vibrator.c b/drivers/input/misc/pm8xxx-vibrator.c
> index f1daae08a8c2..803bc75d5531 100644
> --- a/drivers/input/misc/pm8xxx-vibrator.c
> +++ b/drivers/input/misc/pm8xxx-vibrator.c
> @@ -14,6 +14,7 @@
>  #include <linux/input.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
> @@ -26,6 +27,9 @@
>  #define MAX_FF_SPEED		0xff
>  
>  struct pm8xxx_regs {
> +	unsigned int enable_addr;
> +	unsigned int enable_mask;
> +
>  	unsigned int drv_addr;
>  	unsigned int drv_mask;
>  	unsigned int drv_shift;
> @@ -82,7 +86,14 @@ static int pm8xxx_vib_set(struct pm8xxx_vib *vib, bool on)
>  		return rc;
>  
>  	vib->reg_vib_drv = val;
> -	return 0;
> +
> +	if (regs->enable_mask) {
> +		unsigned int val = on ? regs->enable_mask : 0;
> +		rc = regmap_update_bits(vib->regmap, regs->enable_addr,
> +					regs->enable_mask, val);
> +	}
> +
> +	return rc;
>  }
>  
>  /**
> @@ -179,6 +190,22 @@ static int pm8xxx_vib_probe(struct platform_device *pdev)
>  
>  	regs = (struct pm8xxx_regs *)of_device_get_match_data(&pdev->dev);
>  
> +	/*
> +	 * If enable_mask is not zero, that means we're using a vibrator that
> +	 * requires multiple registers to be controlled, the value read in the
> +	 * device tree is the base address of these registers.
> +	 */
> +	if (regs->enable_mask) {
> +		u32 base;
> +
> +		error = of_property_read_u32(pdev->dev.of_node, "reg", &base);
> +		if (error)
> +			return error;

Is it really configurable? Shouldn't it be in chip-spoecific instance of
regs to begin with?

> +
> +		regs->drv_addr += base;
> +		regs->enable_addr += base;

Regs should be const, you should not change it (what happens if there
are 2 devices?).

> +	}
> +
>  	/* operate in manual mode */
>  	error = regmap_read(vib->regmap, regs->drv_addr, &val);
>  	if (error < 0)
> -- 
> 2.12.0
> 

Thanks.

-- 
Dmitry
