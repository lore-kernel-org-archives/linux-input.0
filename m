From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH V3 5/9] mfd: da9061: MFD core support
Date: Wed, 2 Nov 2016 14:28:54 +0000
Message-ID: <20161102142854.GS13127@dell>
References: <cover.1477929725.git.stwiss.opensource@diasemi.com>
 <72145ea5055e95d7b6f05168c641927e4f3830d9.1477929725.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <72145ea5055e95d7b6f05168c641927e4f3830d9.1477929725.git.stwiss.opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: LINUX-KERNEL <linux-kernel@vger.kernel.org>, DEVICETREE <devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eduardo Valentin <edubezval@gmail.com>, Guenter Roeck <linux@roeck-us.net>, LINUX-INPUT <linux-input@vger.kernel.org>, LINUX-PM <linux-pm@vger.kernel.org>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Support Opensource <support.opensource@diasemi.com>, Wim Van Sebroeck <wim@iguana.be>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-input@vger.kernel.org

On Mon, 31 Oct 2016, Steve Twiss wrote:

> From: Steve Twiss <stwiss.opensource@diasemi.com>
> 
> MFD support for DA9061 is provided as part of the DA9062 device driver.
> 
> The registers header file adds two new chip variant IDs defined in DA9061
> and DA9062 hardware. The core header file adds new software enumerations
> for listing the valid DA9061 IRQs and a da9062_compatible_types enumeration
> for distinguishing between DA9061/62 devices in software.
> 
> The core source code adds a new .compatible of_device_id entry. This is
> extended from DA9062 to support both "dlg,da9061" and "dlg,da9062". The
> .data entry now holds a reference to the enumerated device type.
> 
> A new regmap_irq_chip model is added for DA9061 and this supports the new
> list of regmap_irq entries. A new mfd_cell da9061_devs[] array lists the
> new sub system components for DA9061. Support is added for a new DA9061
> regmap_config which lists the correct readable, writable and volatile
> ranges for this chip.
> 
> The probe function uses the device tree compatible string to switch on the
> da9062_compatible_types and configure the correct mfd cells, irq chip and
> regmap config.
>  
> Kconfig is updated to reflect support for DA9061 and DA9062 PMICs.
> 
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
> 
> ---
> This patch applies against linux-next and v4.8
> 
> v2 -> v3
>  - NO CODE CHANGE
>  - Patch renamed from [PATCH V2 05/10] to [PATCH V3 5/9]
> 
> v1 -> v2
>  - Patch renamed from [PATCH V1 01/10] to [PATCH V2 05/10] -- these
>    changes were made to fix checkpatch warnings caused by the patch
>    set dependency order
>  - Fixed typo in the commit message "readble" to "readable"
>  - Removed the explicit cross-check to decide if there is a conflict
>    between the device tree compatible string and the hardware definition.
>    This patch assumes the device tree is correctly written and therefore
>    removes the need for a hardware/DT sanity check.
>  - Removed extra semicolon in drivers/mfd/da9062-core.c:877
>  - Re-write compatible entries into numerical order
> 
> Lee,
> 
> This patch adds support for the DA9061 PMIC. This is done as part of the
> existing DA9062 device driver by extending the of_device_id match table.
> This in turn allows new MFD cells, irq chip and regmap definitions to
> support DA9061.
> 
> Regards,
> Steve Twiss, Dialog Semiconductor Ltd.
> 
> 
>  drivers/mfd/Kconfig                  |   5 +-
>  drivers/mfd/da9062-core.c            | 427 +++++++++++++++++++++++++++++++++--
>  include/linux/mfd/da9062/core.h      |  27 ++-
>  include/linux/mfd/da9062/registers.h |   2 +
>  4 files changed, 441 insertions(+), 20 deletions(-)

[...]

> @@ -475,7 +855,25 @@ static int da9062_i2c_probe(struct i2c_client *i2c,
>  		return -EINVAL;
>  	}
>  
> -	chip->regmap = devm_regmap_init_i2c(i2c, &da9062_regmap_config);
> +	switch (chip->chip_type) {
> +	case(COMPAT_TYPE_DA9061):
> +		cell = da9061_devs;
> +		cell_num = ARRAY_SIZE(da9061_devs);
> +		irq_chip = &da9061_irq_chip;
> +		config = &da9061_regmap_config;
> +		break;
> +	case(COMPAT_TYPE_DA9062):
> +		cell = da9062_devs;
> +		cell_num = ARRAY_SIZE(da9062_devs);
> +		irq_chip = &da9062_irq_chip;
> +		config = &da9062_regmap_config;
> +		break;
> +	default:
> +		dev_err(chip->dev, "Unrecognised chip type\n");
> +		return -ENODEV;
> +	}

I very much dislike when MFD and OF functionality is mixed.

In your case you can use da9062_get_device_type() to dynamically
interrogate the device and register using the correct MFD cells that
way.

> +	chip->regmap = devm_regmap_init_i2c(i2c, config);
>  	if (IS_ERR(chip->regmap)) {
>  		ret = PTR_ERR(chip->regmap);
>  		dev_err(chip->dev, "Failed to allocate register map: %d\n",
> @@ -493,7 +891,7 @@ static int da9062_i2c_probe(struct i2c_client *i2c,
>  
>  	ret = regmap_add_irq_chip(chip->regmap, i2c->irq,
>  			IRQF_TRIGGER_LOW | IRQF_ONESHOT | IRQF_SHARED,
> -			-1, &da9062_irq_chip,
> +			-1, irq_chip,

What is -1?

>  			&chip->regmap_irq);
>  	if (ret) {
>  		dev_err(chip->dev, "Failed to request IRQ %d: %d\n",
> @@ -503,8 +901,8 @@ static int da9062_i2c_probe(struct i2c_client *i2c,
>  
>  	irq_base = regmap_irq_chip_get_base(chip->regmap_irq);
>  
> -	ret = mfd_add_devices(chip->dev, PLATFORM_DEVID_NONE, da9062_devs,
> -			      ARRAY_SIZE(da9062_devs), NULL, irq_base,
> +	ret = mfd_add_devices(chip->dev, PLATFORM_DEVID_NONE, cell,
> +			      cell_num, NULL, irq_base,

[...]

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
