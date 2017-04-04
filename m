From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH V7 4/7] mfd: da9061: MFD core support
Date: Tue, 4 Apr 2017 09:39:02 +0100
Message-ID: <20170404083902.ywo3pdxptgfcqvga@dell>
References: <cover.1491230802.git.stwiss.opensource@diasemi.com>
 <b39c8c3f42a01a00f93292c569e8d30ce69ff3ab.1491230802.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f182.google.com ([209.85.128.182]:33753 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752953AbdDDIjG (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 4 Apr 2017 04:39:06 -0400
Received: by mail-wr0-f182.google.com with SMTP id w43so203548369wrb.0
        for <linux-input@vger.kernel.org>; Tue, 04 Apr 2017 01:39:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <b39c8c3f42a01a00f93292c569e8d30ce69ff3ab.1491230802.git.stwiss.opensource@diasemi.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: LINUX-KERNEL <linux-kernel@vger.kernel.org>, DEVICETREE <devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eduardo Valentin <edubezval@gmail.com>, Guenter Roeck <linux@roeck-us.net>, LINUX-INPUT <linux-input@vger.kernel.org>, LINUX-PM <linux-pm@vger.kernel.org>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Support Opensource <support.opensource@diasemi.com>, Wim Van Sebroeck <wim@iguana.be>, Zhang Rui <rui.zhang@intel.com>

On Mon, 03 Apr 2017, Steve Twiss wrote:

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

Ah, here it is.

Applied, thanks.

> ---
> Acked-for-mfd-by: Lee Jones <lee.jones@linaro.org>
> 
> Hi Lee, that Ack was from your earlier posting:
> https://lkml.org/lkml/2017/1/4/328 this was
> Regards, Steve.
> 
> This patch applies against linux-next and v4.11-rc3
> 
> v6 -> v7 + update
>  - Removed brackets surrounding case statements for
>     case COMPAT_TYPE_DA9061:
>     case COMPAT_TYPE_DA9062:
> 
> v6 -> v7
>  - Remove compilation warning when casting a void * to an integer on
>    ARCH=x86_64 using -Wpointer-to-int-cast.
>  - Recommendation uintptr_t cast: https://lkml.org/lkml/2017/3/28/292
>  - Compile tested ARCH=x86_64
> 
> v5 -> v6
>  - Rebased from v4.9 to v4.11-rc3
>  - Modify Copyright to match Dialog latest legal statement
>  - Fixed "braces {} should be used on all arms" checkpatch warning
> 
> v4 -> v5
>  - NO CODE CHANGE
>  - Rebased from v4.8 to v4.9
> 
> v3 -> v4
>  - Patch renamed from [PATCH V3 5/9] to [PATCH V4 4/8]
>  - Removed DEFINE_RES_NAMED() macros for DA9061 resources and replaced
>    them with DEFINE_RES_IRQ_NAMED().
>  - Removed whitespace
>  - Reverted change for badly defined mfd_cell da9062_devs of_compatible
>    string from "dlg,da9062-watchdog" back to "dlg,da9062-wdt"
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
> Changes as described in the version history above.
> 
> As previously:
> This patch adds support for the DA9061 PMIC. This is done as part of the
> existing DA9062 device driver by extending the of_device_id match table.
> This in turn allows new MFD cells, irq chip and regmap definitions to
> support DA9061.
> 
> Regards,
> Steve Twiss, Dialog Semiconductor
> 
> 
>  drivers/mfd/Kconfig                  |   5 +-
>  drivers/mfd/da9062-core.c            | 427 +++++++++++++++++++++++++++++++++--
>  include/linux/mfd/da9062/core.h      |  29 ++-
>  include/linux/mfd/da9062/registers.h |   5 +-
>  4 files changed, 443 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 55ecdfb..29cc11a 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -263,13 +263,14 @@ config MFD_DA9055
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
> index 8f873866..1803f58 100644
> --- a/drivers/mfd/da9062-core.c
> +++ b/drivers/mfd/da9062-core.c
> @@ -1,6 +1,6 @@
>  /*
> - * Core, IRQ and I2C device driver for DA9062 PMIC
> - * Copyright (C) 2015  Dialog Semiconductor Ltd.
> + * Core, IRQ and I2C device driver for DA9061 and DA9062 PMICs
> + * Copyright (C) 2015-2017  Dialog Semiconductor
>   *
>   * This program is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU General Public License
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
> @@ -102,6 +166,57 @@
>  	.ack_base = DA9062AA_EVENT_A,
>  };
>  
> +static struct resource da9061_core_resources[] = {
> +	DEFINE_RES_IRQ_NAMED(DA9061_IRQ_VDD_WARN, "VDD_WARN"),
> +};
> +
> +static struct resource da9061_regulators_resources[] = {
> +	DEFINE_RES_IRQ_NAMED(DA9061_IRQ_LDO_LIM, "LDO_LIM"),
> +};
> +
> +static struct resource da9061_thermal_resources[] = {
> +	DEFINE_RES_IRQ_NAMED(DA9061_IRQ_TEMP, "THERMAL"),
> +};
> +
> +static struct resource da9061_wdt_resources[] = {
> +	DEFINE_RES_IRQ_NAMED(DA9061_IRQ_WDG_WARN, "WD_WARN"),
> +};
> +
> +static struct resource da9061_onkey_resources[] = {
> +	DEFINE_RES_IRQ_NAMED(DA9061_IRQ_ONKEY, "ONKEY"),
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
> @@ -200,7 +315,8 @@ static int da9062_clear_fault_log(struct da9062 *chip)
>  
>  static int da9062_get_device_type(struct da9062 *chip)
>  {
> -	int device_id, variant_id, variant_mrc;
> +	int device_id, variant_id, variant_mrc, variant_vrc;
> +	char *type;
>  	int ret;
>  
>  	ret = regmap_read(chip->regmap, DA9062AA_DEVICE_ID, &device_id);
> @@ -219,9 +335,23 @@ static int da9062_get_device_type(struct da9062 *chip)
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
> @@ -234,6 +364,234 @@ static int da9062_get_device_type(struct da9062 *chip)
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
> @@ -456,17 +814,39 @@ static int da9062_get_device_type(struct da9062 *chip)
>  	.volatile_table = &da9062_aa_volatile_table,
>  };
>  
> +static const struct of_device_id da9062_dt_ids[] = {
> +	{ .compatible = "dlg,da9061", .data = (void *)COMPAT_TYPE_DA9061, },
> +	{ .compatible = "dlg,da9062", .data = (void *)COMPAT_TYPE_DA9062, },
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
> +		chip->chip_type = (uintptr_t)match->data;
> +	} else {
> +		chip->chip_type = id->driver_data;
> +	}
> +
>  	i2c_set_clientdata(i2c, chip);
>  	chip->dev = &i2c->dev;
>  
> @@ -475,7 +855,25 @@ static int da9062_i2c_probe(struct i2c_client *i2c,
>  		return -EINVAL;
>  	}
>  
> -	chip->regmap = devm_regmap_init_i2c(i2c, &da9062_regmap_config);
> +	switch (chip->chip_type) {
> +	case COMPAT_TYPE_DA9061:
> +		cell = da9061_devs;
> +		cell_num = ARRAY_SIZE(da9061_devs);
> +		irq_chip = &da9061_irq_chip;
> +		config = &da9061_regmap_config;
> +		break;
> +	case COMPAT_TYPE_DA9062:
> +		cell = da9062_devs;
> +		cell_num = ARRAY_SIZE(da9062_devs);
> +		irq_chip = &da9062_irq_chip;
> +		config = &da9062_regmap_config;
> +		break;
> +	default:
> +		dev_err(chip->dev, "Unrecognised chip type\n");
> +		return -ENODEV;
> +	}
> +
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
>  			      NULL);
>  	if (ret) {
>  		dev_err(chip->dev, "Cannot register child devices\n");
> @@ -526,17 +924,12 @@ static int da9062_i2c_remove(struct i2c_client *i2c)
>  }
>  
>  static const struct i2c_device_id da9062_i2c_id[] = {
> -	{ "da9062", 0 },
> +	{ "da9061", COMPAT_TYPE_DA9061 },
> +	{ "da9062", COMPAT_TYPE_DA9062 },
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
> @@ -549,6 +942,6 @@ static int da9062_i2c_remove(struct i2c_client *i2c)
>  
>  module_i2c_driver(da9062_i2c_driver);
>  
> -MODULE_DESCRIPTION("Core device driver for Dialog DA9062");
> +MODULE_DESCRIPTION("Core device driver for Dialog DA9061 and DA9062");
>  MODULE_AUTHOR("Steve Twiss <stwiss.opensource@diasemi.com>");
>  MODULE_LICENSE("GPL");
> diff --git a/include/linux/mfd/da9062/core.h b/include/linux/mfd/da9062/core.h
> index 376ba84..74d33a0 100644
> --- a/include/linux/mfd/da9062/core.h
> +++ b/include/linux/mfd/da9062/core.h
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2015  Dialog Semiconductor Ltd.
> + * Copyright (C) 2015-2017  Dialog Semiconductor
>   *
>   * This program is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU General Public License
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
> index 97790d1..18d576a 100644
> --- a/include/linux/mfd/da9062/registers.h
> +++ b/include/linux/mfd/da9062/registers.h
> @@ -1,6 +1,5 @@
>  /*
> - * registers.h - REGISTERS H for DA9062
> - * Copyright (C) 2015  Dialog Semiconductor Ltd.
> + * Copyright (C) 2015-2017  Dialog Semiconductor
>   *
>   * This program is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU General Public License
> @@ -18,6 +17,8 @@
>  
>  #define DA9062_PMIC_DEVICE_ID		0x62
>  #define DA9062_PMIC_VARIANT_MRC_AA	0x01
> +#define DA9062_PMIC_VARIANT_VRC_DA9061	0x01
> +#define DA9062_PMIC_VARIANT_VRC_DA9062	0x02
>  
>  #define DA9062_I2C_PAGE_SEL_SHIFT	1
>  

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
