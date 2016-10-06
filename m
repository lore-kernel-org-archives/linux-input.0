From: Keerthy <a0393675-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH V1 01/10] mfd: da9061: MFD core support
Date: Thu, 6 Oct 2016 16:07:40 +0530
Message-ID: <1eca0af9-64d5-7476-2847-71ecf9331395@ti.com>
References: <cover.1475743411.git.stwiss.opensource@diasemi.com>
 <c9726b1f01300da7693324b0c1ff7f71dcbc275d.1475743411.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <c9726b1f01300da7693324b0c1ff7f71dcbc275d.1475743411.git.stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, LINUX-KERNEL <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: DEVICETREE <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, LINUX-INPUT <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUX-PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUX-WATCHDOG <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org



On Thursday 06 October 2016 02:13 PM, Steve Twiss wrote:
> From: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
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
> regmap_config which lists the correct readble, writable and volatile

/s/readble/readable

> ranges for this chip.
>
> The probe function uses the device tree compatible string to switch on the
> da9062_compatible_types and configure the correct mfd cells, irq chip and
> regmap config. The regmap is initialised first, before reading the variant
> ID in hardware to decide if there is a conflict between the device tree
> compatible string and the hardware definition. The remainder of the MFD
> is finally configured after that.
>
> Kconfig is updated to reflect support for DA9061 and DA9062 PMICs.
>
> Signed-off-by: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
>
> ---
> This patch applies against linux-next and v4.8
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
>  drivers/mfd/da9062-core.c            | 454 +++++++++++++++++++++++++++++++++--
>  include/linux/mfd/da9062/core.h      |  27 ++-
>  include/linux/mfd/da9062/registers.h |   2 +
>  4 files changed, 463 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 2d1fb64..533798a 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -236,13 +236,14 @@ config MFD_DA9055
>  	  called "da9055"
>
>  config MFD_DA9062
> -	tristate "Dialog Semiconductor DA9062 PMIC Support"
> +	tristate "Dialog Semiconductor DA9062/61 PMIC Support"
>  	select MFD_CORE
>  	select REGMAP_I2C
>  	select REGMAP_IRQ
>  	depends on I2C
>  	help
> -	  Say yes here for support for the Dialog Semiconductor DA9062 PMIC.
> +	  Say yes here for support for the Dialog Semiconductor DA9061 and
> +	  DA9062 PMICs.
>  	  This includes the I2C driver and core APIs.
>  	  Additional drivers must be enabled in order to use the functionality
>  	  of the device.
> diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
> index 8f873866..bfbc065 100644
> --- a/drivers/mfd/da9062-core.c
> +++ b/drivers/mfd/da9062-core.c
> @@ -1,5 +1,5 @@
>  /*
> - * Core, IRQ and I2C device driver for DA9062 PMIC
> + * Core, IRQ and I2C device driver for DA9062 and DA9061 PMICs
>   * Copyright (C) 2015  Dialog Semiconductor Ltd.
>   *
>   * This program is free software; you can redistribute it and/or
> @@ -30,6 +30,70 @@
>  #define	DA9062_REG_EVENT_B_OFFSET	1
>  #define	DA9062_REG_EVENT_C_OFFSET	2
>
> +static struct regmap_irq da9061_irqs[] = {
> +	/* EVENT A */
> +	[DA9061_IRQ_ONKEY] = {
> +		.reg_offset = DA9062_REG_EVENT_A_OFFSET,
> +		.mask = DA9062AA_M_NONKEY_MASK,
> +	},
> +	[DA9061_IRQ_WDG_WARN] = {
> +		.reg_offset = DA9062_REG_EVENT_A_OFFSET,
> +		.mask = DA9062AA_M_WDG_WARN_MASK,
> +	},
> +	[DA9061_IRQ_SEQ_RDY] = {
> +		.reg_offset = DA9062_REG_EVENT_A_OFFSET,
> +		.mask = DA9062AA_M_SEQ_RDY_MASK,
> +	},
> +	/* EVENT B */
> +	[DA9061_IRQ_TEMP] = {
> +		.reg_offset = DA9062_REG_EVENT_B_OFFSET,
> +		.mask = DA9062AA_M_TEMP_MASK,
> +	},
> +	[DA9061_IRQ_LDO_LIM] = {
> +		.reg_offset = DA9062_REG_EVENT_B_OFFSET,
> +		.mask = DA9062AA_M_LDO_LIM_MASK,
> +	},
> +	[DA9061_IRQ_DVC_RDY] = {
> +		.reg_offset = DA9062_REG_EVENT_B_OFFSET,
> +		.mask = DA9062AA_M_DVC_RDY_MASK,
> +	},
> +	[DA9061_IRQ_VDD_WARN] = {
> +		.reg_offset = DA9062_REG_EVENT_B_OFFSET,
> +		.mask = DA9062AA_M_VDD_WARN_MASK,
> +	},
> +	/* EVENT C */
> +	[DA9061_IRQ_GPI0] = {
> +		.reg_offset = DA9062_REG_EVENT_C_OFFSET,
> +		.mask = DA9062AA_M_GPI0_MASK,
> +	},
> +	[DA9061_IRQ_GPI1] = {
> +		.reg_offset = DA9062_REG_EVENT_C_OFFSET,
> +		.mask = DA9062AA_M_GPI1_MASK,
> +	},
> +	[DA9061_IRQ_GPI2] = {
> +		.reg_offset = DA9062_REG_EVENT_C_OFFSET,
> +		.mask = DA9062AA_M_GPI2_MASK,
> +	},
> +	[DA9061_IRQ_GPI3] = {
> +		.reg_offset = DA9062_REG_EVENT_C_OFFSET,
> +		.mask = DA9062AA_M_GPI3_MASK,
> +	},
> +	[DA9061_IRQ_GPI4] = {
> +		.reg_offset = DA9062_REG_EVENT_C_OFFSET,
> +		.mask = DA9062AA_M_GPI4_MASK,
> +	},
> +};
> +
> +static struct regmap_irq_chip da9061_irq_chip = {
> +	.name = "da9061-irq",
> +	.irqs = da9061_irqs,
> +	.num_irqs = DA9061_NUM_IRQ,
> +	.num_regs = 3,
> +	.status_base = DA9062AA_EVENT_A,
> +	.mask_base = DA9062AA_IRQ_MASK_A,
> +	.ack_base = DA9062AA_EVENT_A,
> +};
> +
>  static struct regmap_irq da9062_irqs[] = {
>  	/* EVENT A */
>  	[DA9062_IRQ_ONKEY] = {
> @@ -102,6 +166,57 @@ static struct regmap_irq_chip da9062_irq_chip = {
>  	.ack_base = DA9062AA_EVENT_A,
>  };
>
> +static struct resource da9061_core_resources[] = {
> +	DEFINE_RES_NAMED(DA9061_IRQ_VDD_WARN, 1, "VDD_WARN", IORESOURCE_IRQ),
> +};
> +
> +static struct resource da9061_regulators_resources[] = {
> +	DEFINE_RES_NAMED(DA9061_IRQ_LDO_LIM, 1, "LDO_LIM", IORESOURCE_IRQ),
> +};
> +
> +static struct resource da9061_thermal_resources[] = {
> +	DEFINE_RES_NAMED(DA9061_IRQ_TEMP, 1, "THERMAL", IORESOURCE_IRQ),
> +};
> +
> +static struct resource da9061_wdt_resources[] = {
> +	DEFINE_RES_NAMED(DA9061_IRQ_WDG_WARN, 1, "WD_WARN", IORESOURCE_IRQ),
> +};
> +
> +static struct resource da9061_onkey_resources[] = {
> +	DEFINE_RES_NAMED(DA9061_IRQ_ONKEY, 1, "ONKEY", IORESOURCE_IRQ),
> +};
> +
> +static const struct mfd_cell da9061_devs[] = {
> +	{
> +		.name		= "da9061-core",
> +		.num_resources	= ARRAY_SIZE(da9061_core_resources),
> +		.resources	= da9061_core_resources,
> +	},
> +	{
> +		.name		= "da9062-regulators",
> +		.num_resources	= ARRAY_SIZE(da9061_regulators_resources),
> +		.resources	= da9061_regulators_resources,
> +	},
> +	{
> +		.name		= "da9061-watchdog",
> +		.num_resources	= ARRAY_SIZE(da9061_wdt_resources),
> +		.resources	= da9061_wdt_resources,
> +		.of_compatible  = "dlg,da9061-watchdog",
> +	},
> +	{
> +		.name		= "da9061-thermal",
> +		.num_resources	= ARRAY_SIZE(da9061_thermal_resources),
> +		.resources	= da9061_thermal_resources,
> +		.of_compatible  = "dlg,da9061-thermal",
> +	},
> +	{
> +		.name		= "da9061-onkey",
> +		.num_resources	= ARRAY_SIZE(da9061_onkey_resources),
> +		.resources	= da9061_onkey_resources,
> +		.of_compatible = "dlg,da9061-onkey",
> +	},
> +};
> +
>  static struct resource da9062_core_resources[] = {
>  	DEFINE_RES_NAMED(DA9062_IRQ_VDD_WARN, 1, "VDD_WARN", IORESOURCE_IRQ),
>  };
> @@ -142,7 +257,7 @@ static const struct mfd_cell da9062_devs[] = {
>  		.name		= "da9062-watchdog",
>  		.num_resources	= ARRAY_SIZE(da9062_wdt_resources),
>  		.resources	= da9062_wdt_resources,
> -		.of_compatible  = "dlg,da9062-wdt",
> +		.of_compatible  = "dlg,da9062-watchdog",

Any particular reason why this compatible needs to be changed?

>  	},
>  	{
>  		.name		= "da9062-thermal",
> @@ -198,9 +313,10 @@ static int da9062_clear_fault_log(struct da9062 *chip)
>  	return ret;
>  }
>
> -static int da9062_get_device_type(struct da9062 *chip)
> +static int da9062_get_device_type(struct da9062 *chip, int *vrc)
>  {
> -	int device_id, variant_id, variant_mrc;
> +	int device_id, variant_id, variant_mrc, variant_vrc;
> +	char *type;
>  	int ret;
>
>  	ret = regmap_read(chip->regmap, DA9062AA_DEVICE_ID, &device_id);
> @@ -208,6 +324,7 @@ static int da9062_get_device_type(struct da9062 *chip)
>  		dev_err(chip->dev, "Cannot read chip ID.\n");
>  		return -EIO;
>  	}
> +
>  	if (device_id != DA9062_PMIC_DEVICE_ID) {
>  		dev_err(chip->dev, "Invalid device ID: 0x%02x\n", device_id);
>  		return -ENODEV;
> @@ -219,9 +336,23 @@ static int da9062_get_device_type(struct da9062 *chip)
>  		return -EIO;
>  	}
>
> +	variant_vrc = (variant_id & DA9062AA_VRC_MASK) >> DA9062AA_VRC_SHIFT;
> +
> +	switch (variant_vrc) {
> +	case DA9062_PMIC_VARIANT_VRC_DA9061:
> +		type = "DA9061";
> +		break;
> +	case DA9062_PMIC_VARIANT_VRC_DA9062:
> +		type = "DA9062";
> +		break;
> +	default:
> +		type = "Unknown";
> +		break;
> +	}
> +
>  	dev_info(chip->dev,
> -		 "Device detected (device-ID: 0x%02X, var-ID: 0x%02X)\n",
> -		 device_id, variant_id);
> +		 "Device detected (device-ID: 0x%02X, var-ID: 0x%02X, %s)\n",
> +		 device_id, variant_id, type);
>
>  	variant_mrc = (variant_id & DA9062AA_MRC_MASK) >> DA9062AA_MRC_SHIFT;
>
> @@ -231,9 +362,239 @@ static int da9062_get_device_type(struct da9062 *chip)
>  		return -ENODEV;
>  	}
>
> +	*vrc = variant_vrc;
> +
>  	return ret;
>  }
>
> +static const struct regmap_range da9061_aa_readable_ranges[] = {
> +	{
> +		.range_min = DA9062AA_PAGE_CON,
> +		.range_max = DA9062AA_STATUS_B,
> +	}, {
> +		.range_min = DA9062AA_STATUS_D,
> +		.range_max = DA9062AA_EVENT_C,
> +	}, {
> +		.range_min = DA9062AA_IRQ_MASK_A,
> +		.range_max = DA9062AA_IRQ_MASK_C,
> +	}, {
> +		.range_min = DA9062AA_CONTROL_A,
> +		.range_max = DA9062AA_GPIO_4,
> +	}, {
> +		.range_min = DA9062AA_GPIO_WKUP_MODE,
> +		.range_max = DA9062AA_GPIO_OUT3_4,
> +	}, {
> +		.range_min = DA9062AA_BUCK1_CONT,
> +		.range_max = DA9062AA_BUCK4_CONT,
> +	}, {
> +		.range_min = DA9062AA_BUCK3_CONT,
> +		.range_max = DA9062AA_BUCK3_CONT,
> +	}, {
> +		.range_min = DA9062AA_LDO1_CONT,
> +		.range_max = DA9062AA_LDO4_CONT,
> +	}, {
> +		.range_min = DA9062AA_DVC_1,
> +		.range_max = DA9062AA_DVC_1,
> +	}, {
> +		.range_min = DA9062AA_SEQ,
> +		.range_max = DA9062AA_ID_4_3,
> +	}, {
> +		.range_min = DA9062AA_ID_12_11,
> +		.range_max = DA9062AA_ID_16_15,
> +	}, {
> +		.range_min = DA9062AA_ID_22_21,
> +		.range_max = DA9062AA_ID_32_31,
> +	}, {
> +		.range_min = DA9062AA_SEQ_A,
> +		.range_max = DA9062AA_WAIT,
> +	}, {
> +		.range_min = DA9062AA_RESET,
> +		.range_max = DA9062AA_BUCK_ILIM_C,
> +	}, {
> +		.range_min = DA9062AA_BUCK1_CFG,
> +		.range_max = DA9062AA_BUCK3_CFG,
> +	}, {
> +		.range_min = DA9062AA_VBUCK1_A,
> +		.range_max = DA9062AA_VBUCK4_A,
> +	}, {
> +		.range_min = DA9062AA_VBUCK3_A,
> +		.range_max = DA9062AA_VBUCK3_A,
> +	}, {
> +		.range_min = DA9062AA_VLDO1_A,
> +		.range_max = DA9062AA_VLDO4_A,
> +	}, {
> +		.range_min = DA9062AA_VBUCK1_B,
> +		.range_max = DA9062AA_VBUCK4_B,
> +	}, {
> +		.range_min = DA9062AA_VBUCK3_B,
> +		.range_max = DA9062AA_VBUCK3_B,
> +	}, {
> +		.range_min = DA9062AA_VLDO1_B,
> +		.range_max = DA9062AA_VLDO4_B,
> +	}, {
> +		.range_min = DA9062AA_BBAT_CONT,
> +		.range_max = DA9062AA_BBAT_CONT,
> +	}, {
> +		.range_min = DA9062AA_INTERFACE,
> +		.range_max = DA9062AA_CONFIG_E,
> +	}, {
> +		.range_min = DA9062AA_CONFIG_G,
> +		.range_max = DA9062AA_CONFIG_K,
> +	}, {
> +		.range_min = DA9062AA_CONFIG_M,
> +		.range_max = DA9062AA_CONFIG_M,
> +	}, {
> +		.range_min = DA9062AA_GP_ID_0,
> +		.range_max = DA9062AA_GP_ID_19,
> +	}, {
> +		.range_min = DA9062AA_DEVICE_ID,
> +		.range_max = DA9062AA_CONFIG_ID,
> +	},
> +};
> +
> +static const struct regmap_range da9061_aa_writeable_ranges[] = {
> +	{
> +		.range_min = DA9062AA_PAGE_CON,
> +		.range_max = DA9062AA_PAGE_CON,
> +	}, {
> +		.range_min = DA9062AA_FAULT_LOG,
> +		.range_max = DA9062AA_EVENT_C,
> +	}, {
> +		.range_min = DA9062AA_IRQ_MASK_A,
> +		.range_max = DA9062AA_IRQ_MASK_C,
> +	}, {
> +		.range_min = DA9062AA_CONTROL_A,
> +		.range_max = DA9062AA_GPIO_4,
> +	}, {
> +		.range_min = DA9062AA_GPIO_WKUP_MODE,
> +		.range_max = DA9062AA_GPIO_OUT3_4,
> +	}, {
> +		.range_min = DA9062AA_BUCK1_CONT,
> +		.range_max = DA9062AA_BUCK4_CONT,
> +	}, {
> +		.range_min = DA9062AA_BUCK3_CONT,
> +		.range_max = DA9062AA_BUCK3_CONT,
> +	}, {
> +		.range_min = DA9062AA_LDO1_CONT,
> +		.range_max = DA9062AA_LDO4_CONT,
> +	}, {
> +		.range_min = DA9062AA_DVC_1,
> +		.range_max = DA9062AA_DVC_1,
> +	}, {
> +		.range_min = DA9062AA_SEQ,
> +		.range_max = DA9062AA_ID_4_3,
> +	}, {
> +		.range_min = DA9062AA_ID_12_11,
> +		.range_max = DA9062AA_ID_16_15,
> +	}, {
> +		.range_min = DA9062AA_ID_22_21,
> +		.range_max = DA9062AA_ID_32_31,
> +	}, {
> +		.range_min = DA9062AA_SEQ_A,
> +		.range_max = DA9062AA_WAIT,
> +	}, {
> +		.range_min = DA9062AA_RESET,
> +		.range_max = DA9062AA_BUCK_ILIM_C,
> +	}, {
> +		.range_min = DA9062AA_BUCK1_CFG,
> +		.range_max = DA9062AA_BUCK3_CFG,
> +	}, {
> +		.range_min = DA9062AA_VBUCK1_A,
> +		.range_max = DA9062AA_VBUCK4_A,
> +	}, {
> +		.range_min = DA9062AA_VBUCK3_A,
> +		.range_max = DA9062AA_VBUCK3_A,
> +	}, {
> +		.range_min = DA9062AA_VLDO1_A,
> +		.range_max = DA9062AA_VLDO4_A,
> +	}, {
> +		.range_min = DA9062AA_VBUCK1_B,
> +		.range_max = DA9062AA_VBUCK4_B,
> +	}, {
> +		.range_min = DA9062AA_VBUCK3_B,
> +		.range_max = DA9062AA_VBUCK3_B,
> +	}, {
> +		.range_min = DA9062AA_VLDO1_B,
> +		.range_max = DA9062AA_VLDO4_B,
> +	}, {
> +		.range_min = DA9062AA_BBAT_CONT,
> +		.range_max = DA9062AA_BBAT_CONT,
> +	}, {
> +		.range_min = DA9062AA_GP_ID_0,
> +		.range_max = DA9062AA_GP_ID_19,
> +	},
> +};
> +
> +static const struct regmap_range da9061_aa_volatile_ranges[] = {
> +	{
> +		.range_min = DA9062AA_PAGE_CON,
> +		.range_max = DA9062AA_STATUS_B,
> +	}, {
> +		.range_min = DA9062AA_STATUS_D,
> +		.range_max = DA9062AA_EVENT_C,
> +	}, {
> +		.range_min = DA9062AA_CONTROL_A,
> +		.range_max = DA9062AA_CONTROL_B,
> +	}, {
> +		.range_min = DA9062AA_CONTROL_E,
> +		.range_max = DA9062AA_CONTROL_F,
> +	}, {
> +		.range_min = DA9062AA_BUCK1_CONT,
> +		.range_max = DA9062AA_BUCK4_CONT,
> +	}, {
> +		.range_min = DA9062AA_BUCK3_CONT,
> +		.range_max = DA9062AA_BUCK3_CONT,
> +	}, {
> +		.range_min = DA9062AA_LDO1_CONT,
> +		.range_max = DA9062AA_LDO4_CONT,
> +	}, {
> +		.range_min = DA9062AA_DVC_1,
> +		.range_max = DA9062AA_DVC_1,
> +	}, {
> +		.range_min = DA9062AA_SEQ,
> +		.range_max = DA9062AA_SEQ,
> +	},
> +};
> +
> +static const struct regmap_access_table da9061_aa_readable_table = {
> +	.yes_ranges = da9061_aa_readable_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(da9061_aa_readable_ranges),
> +};
> +
> +static const struct regmap_access_table da9061_aa_writeable_table = {
> +	.yes_ranges = da9061_aa_writeable_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(da9061_aa_writeable_ranges),
> +};
> +
> +static const struct regmap_access_table da9061_aa_volatile_table = {
> +	.yes_ranges = da9061_aa_volatile_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(da9061_aa_volatile_ranges),
> +};
> +
> +static const struct regmap_range_cfg da9061_range_cfg[] = {
> +	{
> +		.range_min = DA9062AA_PAGE_CON,
> +		.range_max = DA9062AA_CONFIG_ID,
> +		.selector_reg = DA9062AA_PAGE_CON,
> +		.selector_mask = 1 << DA9062_I2C_PAGE_SEL_SHIFT,
> +		.selector_shift = DA9062_I2C_PAGE_SEL_SHIFT,
> +		.window_start = 0,
> +		.window_len = 256,
> +	}
> +};
> +
> +static struct regmap_config da9061_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.ranges = da9061_range_cfg,
> +	.num_ranges = ARRAY_SIZE(da9061_range_cfg),
> +	.max_register = DA9062AA_CONFIG_ID,
> +	.cache_type = REGCACHE_RBTREE,
> +	.rd_table = &da9061_aa_readable_table,
> +	.wr_table = &da9061_aa_writeable_table,
> +	.volatile_table = &da9061_aa_volatile_table,
> +};
> +
>  static const struct regmap_range da9062_aa_readable_ranges[] = {
>  	{
>  		.range_min = DA9062AA_PAGE_CON,
> @@ -456,17 +817,39 @@ static struct regmap_config da9062_regmap_config = {
>  	.volatile_table = &da9062_aa_volatile_table,
>  };
>
> +static const struct of_device_id da9062_dt_ids[] = {
> +	{ .compatible = "dlg,da9062", .data = (void *)COMPAT_TYPE_DA9062, },
> +	{ .compatible = "dlg,da9061", .data = (void *)COMPAT_TYPE_DA9061, },

WARNING: DT compatible string "dlg,da9061" appears un-documented -- 
check ./Documentation/devicetree/bindings/
#622: FILE: drivers/mfd/da9062-core.c:822:
+	{ .compatible = "dlg,da9061", .data = (void *)COMPAT_TYPE_DA9061, },

Might want to re-order patches so that you have the compatibles 
documented before usage

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, da9062_dt_ids);
> +
>  static int da9062_i2c_probe(struct i2c_client *i2c,
>  	const struct i2c_device_id *id)
>  {
>  	struct da9062 *chip;
> +	const struct of_device_id *match;
>  	unsigned int irq_base;
> +	const struct mfd_cell *cell;
> +	const struct regmap_irq_chip *irq_chip;
> +	const struct regmap_config *config;
> +	int cell_num;

No need of cell_num.

> +	int variant_vrc;
>  	int ret;
>
>  	chip = devm_kzalloc(&i2c->dev, sizeof(*chip), GFP_KERNEL);
>  	if (!chip)
>  		return -ENOMEM;
>
> +	if (i2c->dev.of_node) {
> +		match = of_match_node(da9062_dt_ids, i2c->dev.of_node);
> +		if (!match)
> +			return -EINVAL;
> +
> +		chip->chip_type = (int)match->data;
> +	} else
> +		chip->chip_type = id->driver_data;
> +
>  	i2c_set_clientdata(i2c, chip);
>  	chip->dev = &i2c->dev;
>
> @@ -475,7 +858,25 @@ static int da9062_i2c_probe(struct i2c_client *i2c,
>  		return -EINVAL;
>  	}
>
> -	chip->regmap = devm_regmap_init_i2c(i2c, &da9062_regmap_config);
> +	switch (chip->chip_type) {
> +	case(COMPAT_TYPE_DA9061):
> +		cell = da9061_devs;
> +		cell_num = ARRAY_SIZE(da9061_devs);

No need of the above assignment

> +		irq_chip = &da9061_irq_chip;
> +		config = &da9061_regmap_config;
> +		break;
> +	case(COMPAT_TYPE_DA9062):
> +		cell = da9062_devs;
> +		cell_num = ARRAY_SIZE(da9062_devs);

No need of the above assignment

> +		irq_chip = &da9062_irq_chip;
> +		config = &da9062_regmap_config;
> +		break;
> +	default:
> +		dev_err(chip->dev, "Unrecognised chip type\n");
> +		return -ENODEV;
> +	};
> +
> +	chip->regmap = devm_regmap_init_i2c(i2c, config);
>  	if (IS_ERR(chip->regmap)) {
>  		ret = PTR_ERR(chip->regmap);
>  		dev_err(chip->dev, "Failed to allocate register map: %d\n",
> @@ -483,17 +884,31 @@ static int da9062_i2c_probe(struct i2c_client *i2c,
>  		return ret;
>  	}
>
> +	ret = da9062_get_device_type(chip, &variant_vrc);
> +	if (ret)
> +		return ret;
> +
> +	if (chip->chip_type == COMPAT_TYPE_DA9061 &&
> +	    variant_vrc != DA9062_PMIC_VARIANT_VRC_DA9061) {
> +		dev_err(chip->dev,
> +			"Expected DA9061 type mismatch with hardware");
> +		return -ENODEV;
> +	}
> +
> +	if (chip->chip_type == COMPAT_TYPE_DA9062 &&
> +	    variant_vrc != DA9062_PMIC_VARIANT_VRC_DA9062) {
> +		dev_err(chip->dev,
> +			"Expected DA9062 type mismatch with hardware");
> +		return -ENODEV;
> +	}
> +
>  	ret = da9062_clear_fault_log(chip);
>  	if (ret < 0)
>  		dev_warn(chip->dev, "Cannot clear fault log\n");
>
> -	ret = da9062_get_device_type(chip);
> -	if (ret)
> -		return ret;
> -
>  	ret = regmap_add_irq_chip(chip->regmap, i2c->irq,
>  			IRQF_TRIGGER_LOW | IRQF_ONESHOT | IRQF_SHARED,
> -			-1, &da9062_irq_chip,
> +			-1, irq_chip,
>  			&chip->regmap_irq);
>  	if (ret) {
>  		dev_err(chip->dev, "Failed to request IRQ %d: %d\n",
> @@ -503,8 +918,8 @@ static int da9062_i2c_probe(struct i2c_client *i2c,
>
>  	irq_base = regmap_irq_chip_get_base(chip->regmap_irq);
>
> -	ret = mfd_add_devices(chip->dev, PLATFORM_DEVID_NONE, da9062_devs,
> -			      ARRAY_SIZE(da9062_devs), NULL, irq_base,
> +	ret = mfd_add_devices(chip->dev, PLATFORM_DEVID_NONE, cell,
> +			      cell_num, NULL, irq_base,

Use ARRAY_SIZE(cell) instead if cell_num

>  			      NULL);
>  	if (ret) {
>  		dev_err(chip->dev, "Cannot register child devices\n");
> @@ -526,17 +941,12 @@ static int da9062_i2c_remove(struct i2c_client *i2c)
>  }
>
>  static const struct i2c_device_id da9062_i2c_id[] = {
> -	{ "da9062", 0 },
> +	{ "da9062", COMPAT_TYPE_DA9062 },
> +	{ "da9061", COMPAT_TYPE_DA9061 },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(i2c, da9062_i2c_id);
>
> -static const struct of_device_id da9062_dt_ids[] = {
> -	{ .compatible = "dlg,da9062", },
> -	{ }
> -};
> -MODULE_DEVICE_TABLE(of, da9062_dt_ids);
> -
>  static struct i2c_driver da9062_i2c_driver = {
>  	.driver = {
>  		.name = "da9062",
> @@ -549,6 +959,6 @@ static struct i2c_driver da9062_i2c_driver = {
>
>  module_i2c_driver(da9062_i2c_driver);
>
> -MODULE_DESCRIPTION("Core device driver for Dialog DA9062");
> +MODULE_DESCRIPTION("Core device driver for Dialog DA9062 and DA9061");
>  MODULE_AUTHOR("Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>");
>  MODULE_LICENSE("GPL");
> diff --git a/include/linux/mfd/da9062/core.h b/include/linux/mfd/da9062/core.h
> index 376ba84..199c524 100644
> --- a/include/linux/mfd/da9062/core.h
> +++ b/include/linux/mfd/da9062/core.h
> @@ -18,7 +18,31 @@
>  #include <linux/interrupt.h>
>  #include <linux/mfd/da9062/registers.h>
>
> -/* Interrupts */
> +enum da9062_compatible_types {
> +	COMPAT_TYPE_DA9061 = 1,
> +	COMPAT_TYPE_DA9062,
> +};
> +
> +enum da9061_irqs {
> +	/* IRQ A */
> +	DA9061_IRQ_ONKEY,
> +	DA9061_IRQ_WDG_WARN,
> +	DA9061_IRQ_SEQ_RDY,
> +	/* IRQ B*/
> +	DA9061_IRQ_TEMP,
> +	DA9061_IRQ_LDO_LIM,
> +	DA9061_IRQ_DVC_RDY,
> +	DA9061_IRQ_VDD_WARN,
> +	/* IRQ C */
> +	DA9061_IRQ_GPI0,
> +	DA9061_IRQ_GPI1,
> +	DA9061_IRQ_GPI2,
> +	DA9061_IRQ_GPI3,
> +	DA9061_IRQ_GPI4,
> +
> +	DA9061_NUM_IRQ,
> +};
> +
>  enum da9062_irqs {
>  	/* IRQ A */
>  	DA9062_IRQ_ONKEY,
> @@ -45,6 +69,7 @@ struct da9062 {
>  	struct device *dev;
>  	struct regmap *regmap;
>  	struct regmap_irq_chip_data *regmap_irq;
> +	enum da9062_compatible_types chip_type;
>  };
>
>  #endif /* __MFD_DA9062_CORE_H__ */
> diff --git a/include/linux/mfd/da9062/registers.h b/include/linux/mfd/da9062/registers.h
> index 97790d1..4457fdc 100644
> --- a/include/linux/mfd/da9062/registers.h
> +++ b/include/linux/mfd/da9062/registers.h
> @@ -18,6 +18,8 @@
>
>  #define DA9062_PMIC_DEVICE_ID		0x62
>  #define DA9062_PMIC_VARIANT_MRC_AA	0x01
> +#define DA9062_PMIC_VARIANT_VRC_DA9061	0x01
> +#define DA9062_PMIC_VARIANT_VRC_DA9062	0x02
>
>  #define DA9062_I2C_PAGE_SEL_SHIFT	1
>
>

Regards,
Keerthy
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
