From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/6] Input: pm8xxx-vib: parametrize the driver
Date: Sat, 1 Apr 2017 10:04:34 -0700
Message-ID: <20170401170434.GF17130@dtor-ws>
References: <20170331161538.11657-1-damien.riegel@savoirfairelinux.com>
 <20170331161538.11657-3-damien.riegel@savoirfairelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33654 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751752AbdDAREh (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 1 Apr 2017 13:04:37 -0400
Received: by mail-pg0-f66.google.com with SMTP id 79so22670794pgf.0
        for <linux-input@vger.kernel.org>; Sat, 01 Apr 2017 10:04:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170331161538.11657-3-damien.riegel@savoirfairelinux.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Damien Riegel <damien.riegel@savoirfairelinux.com>
Cc: linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, kernel@savoirfairelinux.com

On Fri, Mar 31, 2017 at 12:15:35PM -0400, Damien Riegel wrote:
> In order to prepare this driver to support other vibrators of the same
> kind, move some hardcoded values to a structure holding register
> parameters (address, mask, shit of the control register).
> 
> Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
> ---
>  drivers/input/misc/pm8xxx-vibrator.c | 49 ++++++++++++++++++++++++------------
>  1 file changed, 33 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/input/misc/pm8xxx-vibrator.c b/drivers/input/misc/pm8xxx-vibrator.c
> index 580448170342..f1daae08a8c2 100644
> --- a/drivers/input/misc/pm8xxx-vibrator.c
> +++ b/drivers/input/misc/pm8xxx-vibrator.c
> @@ -14,36 +14,47 @@
>  #include <linux/input.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
>  
> -#define VIB_DRV			0x4A
> -
> -#define VIB_DRV_SEL_MASK	0xf8
> -#define VIB_DRV_SEL_SHIFT	0x03
> -#define VIB_DRV_EN_MANUAL_MASK	0xfc
> -
>  #define VIB_MAX_LEVEL_mV	(3100)
>  #define VIB_MIN_LEVEL_mV	(1200)
>  #define VIB_MAX_LEVELS		(VIB_MAX_LEVEL_mV - VIB_MIN_LEVEL_mV)
>  
>  #define MAX_FF_SPEED		0xff
>  
> +struct pm8xxx_regs {
> +	unsigned int drv_addr;
> +	unsigned int drv_mask;
> +	unsigned int drv_shift;
> +	unsigned int drv_en_manual_mask;
> +};
> +
> +static struct pm8xxx_regs pm8058_regs = {
> +	.drv_addr = 0x4A,
> +	.drv_mask = 0xf8,
> +	.drv_shift = 3,
> +	.drv_en_manual_mask = 0xfc,
> +};
> +
>  /**
>   * struct pm8xxx_vib - structure to hold vibrator data
>   * @vib_input_dev: input device supporting force feedback
>   * @work: work structure to set the vibration parameters
>   * @regmap: regmap for register read/write
> + * @regs: registers' info
>   * @speed: speed of vibration set from userland
>   * @active: state of vibrator
>   * @level: level of vibration to set in the chip
> - * @reg_vib_drv: VIB_DRV register value
> + * @reg_vib_drv: regs->drv_addr register value
>   */
>  struct pm8xxx_vib {
>  	struct input_dev *vib_input_dev;
>  	struct work_struct work;
>  	struct regmap *regmap;
> +	struct pm8xxx_regs *regs;

const struct

>  	int speed;
>  	int level;
>  	bool active;
> @@ -59,13 +70,14 @@ static int pm8xxx_vib_set(struct pm8xxx_vib *vib, bool on)
>  {
>  	int rc;
>  	unsigned int val = vib->reg_vib_drv;
> +	struct pm8xxx_regs *regs = vib->regs;

const struct

>  
>  	if (on)
> -		val |= ((vib->level << VIB_DRV_SEL_SHIFT) & VIB_DRV_SEL_MASK);
> +		val |= ((vib->level << regs->drv_shift) & regs->drv_mask);
>  	else
> -		val &= ~VIB_DRV_SEL_MASK;
> +		val &= ~(regs->drv_mask);

No need for parenthesis.

>  
> -	rc = regmap_write(vib->regmap, VIB_DRV, val);
> +	rc = regmap_write(vib->regmap, regs->drv_addr, val);
>  	if (rc < 0)
>  		return rc;
>  
> @@ -80,10 +92,11 @@ static int pm8xxx_vib_set(struct pm8xxx_vib *vib, bool on)
>  static void pm8xxx_work_handler(struct work_struct *work)
>  {
>  	struct pm8xxx_vib *vib = container_of(work, struct pm8xxx_vib, work);
> +	struct pm8xxx_regs *regs = vib->regs;
>  	int rc;
>  	unsigned int val;
>  
> -	rc = regmap_read(vib->regmap, VIB_DRV, &val);
> +	rc = regmap_read(vib->regmap, regs->drv_addr, &val);
>  	if (rc < 0)
>  		return;
>  
> @@ -147,6 +160,7 @@ static int pm8xxx_vib_probe(struct platform_device *pdev)
>  	struct input_dev *input_dev;
>  	int error;
>  	unsigned int val;
> +	struct pm8xxx_regs *regs;

const struct.

>  
>  	vib = devm_kzalloc(&pdev->dev, sizeof(*vib), GFP_KERNEL);
>  	if (!vib)
> @@ -163,16 +177,19 @@ static int pm8xxx_vib_probe(struct platform_device *pdev)
>  	INIT_WORK(&vib->work, pm8xxx_work_handler);
>  	vib->vib_input_dev = input_dev;
>  
> +	regs = (struct pm8xxx_regs *)of_device_get_match_data(&pdev->dev);

With const reg pointer you would not need to cast.

> +
>  	/* operate in manual mode */
> -	error = regmap_read(vib->regmap, VIB_DRV, &val);
> +	error = regmap_read(vib->regmap, regs->drv_addr, &val);
>  	if (error < 0)
>  		return error;
>  
> -	val &= ~VIB_DRV_EN_MANUAL_MASK;
> -	error = regmap_write(vib->regmap, VIB_DRV, val);
> +	val &= ~(regs->drv_en_manual_mask);

Please drop parenthesis.

> +	error = regmap_write(vib->regmap, regs->drv_addr, val);
>  	if (error < 0)
>  		return error;
>  
> +	vib->regs = regs;
>  	vib->reg_vib_drv = val;
>  
>  	input_dev->name = "pm8xxx_vib_ffmemless";
> @@ -212,8 +229,8 @@ static int __maybe_unused pm8xxx_vib_suspend(struct device *dev)
>  static SIMPLE_DEV_PM_OPS(pm8xxx_vib_pm_ops, pm8xxx_vib_suspend, NULL);
>  
>  static const struct of_device_id pm8xxx_vib_id_table[] = {
> -	{ .compatible = "qcom,pm8058-vib" },
> -	{ .compatible = "qcom,pm8921-vib" },
> +	{ .compatible = "qcom,pm8058-vib", .data = &pm8058_regs },
> +	{ .compatible = "qcom,pm8921-vib", .data = &pm8058_regs },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, pm8xxx_vib_id_table);
> -- 
> 2.12.0
> 

Thanks.


-- 
Dmitry
