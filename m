From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v2 5/8] regulator: AXP20x: Add support for regulators
 subsystem
Date: Mon, 17 Mar 2014 09:19:42 +0100
Message-ID: <1395044382.6350.4.camel@AMDC1943>
References: <1394898225-28452-1-git-send-email-carlo@caione.org>
 <1394898225-28452-6-git-send-email-carlo@caione.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:22144 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932251AbaCQITr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Mar 2014 04:19:47 -0400
In-reply-to: <1394898225-28452-6-git-send-email-carlo@caione.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Carlo Caione <carlo@caione.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com, maxime.ripard@free-electrons.com, hdegoede@redhat.com, emilio@elopez.com.ar, wens@csie.org, sameo@linux.intel.com, lee.jones@linaro.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org


> 
> AXP202 and AXP209 come with two synchronous step-down DC-DCs and five
> LDOs. This patch introduces basic support for those regulators.
> 
> Signed-off-by: Carlo Caione <carlo@caione.org>
> ---
>  drivers/regulator/Kconfig            |   7 +
>  drivers/regulator/Makefile           |   1 +
>  drivers/regulator/axp20x-regulator.c | 293 +++++++++++++++++++++++++++++++++++
>  3 files changed, 301 insertions(+)
>  create mode 100644 drivers/regulator/axp20x-regulator.c
> 
> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> index 6a79328..9f3bc48 100644
> --- a/drivers/regulator/Kconfig
> +++ b/drivers/regulator/Kconfig
> @@ -139,6 +139,13 @@ config REGULATOR_AS3722
>  	  AS3722 PMIC. This will enable support for all the software
>  	  controllable DCDC/LDO regulators.
>  
> +config REGULATOR_AXP20X
> +	tristate "X-POWERS AXP20X PMIC Regulators"
> +	depends on MFD_AXP20X
> +	help
> +	  This driver provides support for the voltage regulators on the
> +	  AXP20X PMIC.
> +
>  config REGULATOR_DA903X
>  	tristate "Dialog Semiconductor DA9030/DA9034 regulators"
>  	depends on PMIC_DA903X
> diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
> index 979f9dd..1dd084a 100644
> --- a/drivers/regulator/Makefile
> +++ b/drivers/regulator/Makefile
> @@ -20,6 +20,7 @@ obj-$(CONFIG_REGULATOR_ANATOP) += anatop-regulator.o
>  obj-$(CONFIG_REGULATOR_ARIZONA) += arizona-micsupp.o arizona-ldo1.o
>  obj-$(CONFIG_REGULATOR_AS3711) += as3711-regulator.o
>  obj-$(CONFIG_REGULATOR_AS3722) += as3722-regulator.o
> +obj-$(CONFIG_REGULATOR_AXP20X) += axp20x-regulator.o
>  obj-$(CONFIG_REGULATOR_DA903X)	+= da903x.o
>  obj-$(CONFIG_REGULATOR_DA9052)	+= da9052-regulator.o
>  obj-$(CONFIG_REGULATOR_DA9055)	+= da9055-regulator.o
> diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
> new file mode 100644
> index 0000000..f09fe35
> --- /dev/null
> +++ b/drivers/regulator/axp20x-regulator.c
> @@ -0,0 +1,293 @@
> +/*
> + * AXP20x regulators driver.
> + *
> + * Copyright (C) 2013 Carlo Caione <carlo@caione.org>
> + *
> + * This file is subject to the terms and conditions of the GNU General
> + * Public License. See the file "COPYING" in the main directory of this
> + * archive for more details.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/axp20x.h>
> +#include <linux/regulator/driver.h>
> +#include <linux/regulator/of_regulator.h>
> +
> +#define AXP20X_IO_ENABLED		(0x03)
> +#define AXP20X_IO_DISABLED		(0x07)
> +
> +#define AXP20X_WORKMODE_DCDC2_MASK	BIT(2)
> +#define AXP20X_WORKMODE_DCDC3_MASK	BIT(1)
> +
> +#define AXP20X_FREQ_DCDC_MASK		(0x0f)
> +
> +struct axp20x_regulators {
> +	struct regulator_desc	rdesc[AXP20X_REG_ID_MAX];
> +	struct regulator_dev	*rdev[AXP20X_REG_ID_MAX];

Hi,

You can get rid of 'rdev' field completely now since you are using
devm_regulator_register(). It isn't used outside of probe().

The 'rdesc' field is also not essential. After removing it you can
remove completely the state container (struct axp20x_regulators).


> +	struct axp20x_dev	*axp20x;
> +};
> +
> +#define AXP20X_DESC_IO(_id, _min, _max, _step, _vreg, _vmask, _ereg, _emask, 	\
> +		       _enable_val, _disable_val)				\
> +	[AXP20X_##_id] = {							\
> +		.name		= #_id,						\
> +		.type		= REGULATOR_VOLTAGE,				\
> +		.id		= AXP20X_##_id,					\
> +		.n_voltages	= (((_max) - (_min)) / (_step) + 1),		\
> +		.owner		= THIS_MODULE,					\
> +		.min_uV		= (_min) * 1000,				\
> +		.uV_step	= (_step) * 1000,				\
> +		.vsel_reg	= (_vreg),					\
> +		.vsel_mask	= (_vmask),					\
> +		.enable_reg	= (_ereg),					\
> +		.enable_mask	= (_emask),					\
> +		.enable_val	= (_enable_val),				\
> +		.disable_val	= (_disable_val),				\
> +		.ops		= &axp20x_ops,					\
> +	}
> +
> +#define AXP20X_DESC(_id, _min, _max, _step, _vreg, _vmask, _ereg, _emask) 	\
> +	AXP20X_DESC_IO(_id, _min, _max, _step, _vreg, _vmask, _ereg, _emask,	\
> +		       0, 0)
> +
> +#define AXP20X_DESC_FIXED(_id, _volt)						\
> +	[AXP20X_##_id] = {							\
> +		.name		= #_id,						\
> +		.type		= REGULATOR_VOLTAGE,				\
> +		.id		= AXP20X_##_id,					\
> +		.n_voltages	= 1,						\
> +		.owner		= THIS_MODULE,					\
> +		.min_uV		= (_volt) * 1000,				\
> +		.ops		= &axp20x_ops,					\
> +	}
> +
> +#define AXP20X_DESC_TABLE(_id, _table, _vreg, _vmask, _ereg, _emask)		\
> +	[AXP20X_##_id] = {							\
> +		.name		= #_id,						\
> +		.type		= REGULATOR_VOLTAGE,				\
> +		.id		= AXP20X_##_id,					\
> +		.n_voltages	= ARRAY_SIZE(_table),				\
> +		.owner		= THIS_MODULE,					\
> +		.vsel_reg	= (_vreg),					\
> +		.vsel_mask	= (_vmask),					\
> +		.enable_reg	= (_ereg),					\
> +		.enable_mask	= (_emask),					\
> +		.volt_table	= (_table),					\
> +		.ops		= &axp20x_ops_table,				\
> +	}
> +
> +static int axp20x_ldo4_data[] = { 1250000, 1300000, 1400000, 1500000, 1600000, 1700000,
> +				  1800000, 1900000, 2000000, 2500000, 2700000, 2800000,
> +				  3000000, 3100000, 3200000, 3300000 };
> +
> +static int axp20x_set_suspend_voltage(struct regulator_dev *rdev, int uV)
> +{
> +	int sel = regulator_map_voltage_iterate(rdev, uV, uV);
> +
> +	if (sel < 0)
> +		return sel;
> +
> +	return regulator_set_voltage_sel_regmap(rdev, sel);
> +}
> +
> +static struct regulator_ops axp20x_ops_table = {
> +	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
> +	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
> +	.list_voltage		= regulator_list_voltage_table,
> +	.enable			= regulator_enable_regmap,
> +	.disable		= regulator_disable_regmap,
> +	.is_enabled		= regulator_is_enabled_regmap,
> +	.set_suspend_enable	= regulator_enable_regmap,
> +	.set_suspend_disable	= regulator_disable_regmap,
> +	.set_suspend_voltage	= axp20x_set_suspend_voltage,
> +};
> +
> +
> +static struct regulator_ops axp20x_ops = {
> +	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
> +	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
> +	.list_voltage		= regulator_list_voltage_linear,
> +	.enable			= regulator_enable_regmap,
> +	.disable		= regulator_disable_regmap,
> +	.is_enabled		= regulator_is_enabled_regmap,
> +	.set_suspend_enable	= regulator_enable_regmap,
> +	.set_suspend_disable	= regulator_disable_regmap,
> +	.set_suspend_voltage	= axp20x_set_suspend_voltage,
> +};
> +
> +static struct regulator_desc axp20x_regulators[] = {

I think this should be 'static const'.

Best regards,
Krzysztof


