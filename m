From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH V3 1/4] mfd: da9062: DA9062 MFD core driver
Date: Tue, 26 May 2015 17:10:24 +0100
Message-ID: <20150526161024.GQ11677@x1>
References: <cover.1432041031.git.stwiss.opensource@diasemi.com>
 <ecf72b79429e6758111a908fd1ded29c0b96da15.1432041031.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:36640 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755173AbbEZQKc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 May 2015 12:10:32 -0400
Received: by wgbgq6 with SMTP id gq6so101766965wgb.3
        for <linux-input@vger.kernel.org>; Tue, 26 May 2015 09:10:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <ecf72b79429e6758111a908fd1ded29c0b96da15.1432041031.git.stwiss.opensource@diasemi.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: S Twiss <stwiss.opensource@diasemi.com>
Cc: LINUXKERNEL <linux-kernel@vger.kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Alessandro Zummo <a.zummo@towertech.it>, DEVICETREE <devicetree@vger.kernel.org>, David Dajun Chen <david.chen@diasemi.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, LINUXINPUT <linux-input@vger.kernel.org>, LINUXWATCHDOG <linux-watchdog@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, RTCLINUX <rtc-linux@googlegroups.com>, Rob Herring <robh+dt@kernel.org>, Support Opensource <support.opensource@diasemi.com>, Wim Van Sebroeck <wim@iguana.be>

On Tue, 19 May 2015, S Twiss wrote:

> From: S Twiss <stwiss.opensource@diasemi.com>
>=20
> Add MFD core driver support for DA9062
>=20
>=20
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
>=20
> ---
> Changes in V3:
>  - Removed references to the RTC and OnKey in the mfd_cell definition=
=2E
>=20
> Changes in V2:
>  - Copyright headers GPL v2 (and later) match correct 'GPL' in MODULE=
_LICENSE
>  - Ensure DA9062 core is tristate in Kconfig so it can be built as a =
module
>  - Move VDD_WARN code and resource into the core instead of regulator=
 driver
>=20
> This patch applies against linux-next and v4.1-rc3=20
>=20
>=20
>=20
>  drivers/mfd/Kconfig                  |   12 +
>  drivers/mfd/Makefile                 |    3 +-
>  drivers/mfd/da9062-core.c            |  611 +++++++++++++++++++
>  include/linux/mfd/da9062/core.h      |   62 ++
>  include/linux/mfd/da9062/registers.h | 1108 ++++++++++++++++++++++++=
++++++++++
>  5 files changed, 1795 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/mfd/da9062-core.c
>  create mode 100644 include/linux/mfd/da9062/core.h
>  create mode 100644 include/linux/mfd/da9062/registers.h
>=20
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index d5ad04d..44fb2b9 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -183,6 +183,18 @@ config MFD_DA9055
>  	  This driver can be built as a module. If built as a module it wil=
l be
>  	  called "da9055"
> =20
> +config MFD_DA9062
> +	tristate "Dialog Semiconductor DA9062 PMIC Support"
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	select REGMAP_IRQ
> +	depends on I2C=3Dy
> +	help
> +	  Say yes here for support for the Dialog Semiconductor DA9062 PMIC=
=2E
> +	  This includes the I2C driver and core APIs.
> +	  Additional drivers must be enabled in order to use the functional=
ity
> +	  of the device.
> +
>  config MFD_DA9063
>  	bool "Dialog Semiconductor DA9063 PMIC Support"
>  	select MFD_CORE
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 0e5cfeb..d94e562 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -110,10 +110,11 @@ obj-$(CONFIG_MFD_LP8788)	+=3D lp8788.o lp8788-i=
rq.o
> =20
>  da9055-objs			:=3D da9055-core.o da9055-i2c.o
>  obj-$(CONFIG_MFD_DA9055)	+=3D da9055.o
> -
> +obj-$(CONFIG_MFD_DA9062)	+=3D da9062-core.o
>  da9063-objs			:=3D da9063-core.o da9063-irq.o da9063-i2c.o
>  obj-$(CONFIG_MFD_DA9063)	+=3D da9063.o
>  obj-$(CONFIG_MFD_DA9150)	+=3D da9150-core.o
> +
>  obj-$(CONFIG_MFD_MAX14577)	+=3D max14577.o
>  obj-$(CONFIG_MFD_MAX77686)	+=3D max77686.o
>  obj-$(CONFIG_MFD_MAX77693)	+=3D max77693.o
> diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
> new file mode 100644
> index 0000000..5aea082
> --- /dev/null
> +++ b/drivers/mfd/da9062-core.c
> @@ -0,0 +1,611 @@
> +/*
> + * da9062-core.c - CORE device driver for DA9062

Remove the filename.  They have a habit of becoming incorrect.

s/CORE/Core/

Can you also mention what the DA9062 actually is?

> + * Copyright (C) 2015  Dialog Semiconductor Ltd.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/device.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>
> +

Why the '\n'?

> +#include <linux/irq.h>
> +#include <linux/mfd/core.h>
> +#include <linux/i2c.h>
> +#include <linux/err.h>
> +

Same here?

> +#include <linux/mfd/da9062/core.h>
> +#include <linux/mfd/da9062/registers.h>
> +#include <linux/of.h>
> +#include <linux/regulator/of_regulator.h>
> +
> +#include <linux/proc_fs.h>
> +#include <linux/kthread.h>
> +#include <linux/uaccess.h>

I'm a bit concerned by the number of includes here, are you sure
they're all required?

> +/* IRQ device driver for DA9062 */

Not sure what this means?

> +#define	DA9062_REG_EVENT_A_OFFSET	0
> +#define	DA9062_REG_EVENT_B_OFFSET	1
> +#define	DA9062_REG_EVENT_C_OFFSET	2
> +
> +static struct regmap_irq da9062_irqs[] =3D {
> +	/* EVENT A */
> +	[DA9062_IRQ_ONKEY] =3D {
> +		.reg_offset =3D DA9062_REG_EVENT_A_OFFSET,
> +		.mask =3D DA9062AA_M_NONKEY_MASK,
> +	},
> +	[DA9062_IRQ_ALARM] =3D {
> +		.reg_offset =3D DA9062_REG_EVENT_A_OFFSET,
> +		.mask =3D DA9062AA_M_ALARM_MASK,
> +	},
> +	[DA9062_IRQ_TICK] =3D {
> +		.reg_offset =3D DA9062_REG_EVENT_A_OFFSET,
> +		.mask =3D DA9062AA_M_TICK_MASK,
> +	},
> +	[DA9062_IRQ_WDG_WARN] =3D {
> +		.reg_offset =3D DA9062_REG_EVENT_A_OFFSET,
> +		.mask =3D DA9062AA_M_WDG_WARN_MASK,
> +	},
> +	[DA9062_IRQ_SEQ_RDY] =3D {
> +		.reg_offset =3D DA9062_REG_EVENT_A_OFFSET,
> +		.mask =3D DA9062AA_M_SEQ_RDY_MASK,
> +	},
> +	/* EVENT B */
> +	[DA9062_IRQ_TEMP] =3D {
> +		.reg_offset =3D DA9062_REG_EVENT_B_OFFSET,
> +		.mask =3D DA9062AA_M_TEMP_MASK,
> +	},
> +	[DA9062_IRQ_LDO_LIM] =3D {
> +		.reg_offset =3D DA9062_REG_EVENT_B_OFFSET,
> +		.mask =3D DA9062AA_M_LDO_LIM_MASK,
> +	},
> +	[DA9062_IRQ_DVC_RDY] =3D {
> +		.reg_offset =3D DA9062_REG_EVENT_B_OFFSET,
> +		.mask =3D DA9062AA_M_DVC_RDY_MASK,
> +	},
> +	[DA9062_IRQ_VDD_WARN] =3D {
> +		.reg_offset =3D DA9062_REG_EVENT_B_OFFSET,
> +		.mask =3D DA9062AA_M_VDD_WARN_MASK,
> +	},
> +	/* EVENT C */
> +	[DA9062_IRQ_GPI0] =3D {
> +		.reg_offset =3D DA9062_REG_EVENT_C_OFFSET,
> +		.mask =3D DA9062AA_M_GPI0_MASK,
> +	},
> +	[DA9062_IRQ_GPI1] =3D {
> +		.reg_offset =3D DA9062_REG_EVENT_C_OFFSET,
> +		.mask =3D DA9062AA_M_GPI1_MASK,
> +	},
> +	[DA9062_IRQ_GPI2] =3D {
> +		.reg_offset =3D DA9062_REG_EVENT_C_OFFSET,
> +		.mask =3D DA9062AA_M_GPI2_MASK,
> +	},
> +	[DA9062_IRQ_GPI3] =3D {
> +		.reg_offset =3D DA9062_REG_EVENT_C_OFFSET,
> +		.mask =3D DA9062AA_M_GPI3_MASK,
> +	},
> +	[DA9062_IRQ_GPI4] =3D {
> +		.reg_offset =3D DA9062_REG_EVENT_C_OFFSET,
> +		.mask =3D DA9062AA_M_GPI4_MASK,
> +	},
> +};
> +
> +static struct regmap_irq_chip da9062_irq_chip =3D {
> +	/* IRQ */

Not required I think.

> +	.name =3D "da9062-irq",
> +	.irqs =3D da9062_irqs,
> +	.num_irqs =3D DA9062_NUM_IRQ,
> +	/* STATUS and EVENT */

This is a standard struct, no need for additional comments.

> +	.num_regs =3D 3,
> +	.status_base =3D DA9062AA_EVENT_A,
> +	.mask_base =3D DA9062AA_IRQ_MASK_A,
> +	.ack_base =3D DA9062AA_EVENT_A,
> +};
> +
> +int da9062_irq_init(struct da9062 *chip)
> +{
> +	int ret;
> +
> +	if (!chip->chip_irq) {

Check this once, in probe(), then rid this check.

> +		dev_err(chip->dev, "No IRQ configured\n");
> +		return -EINVAL;
> +	}
> +
> +	ret =3D regmap_add_irq_chip(chip->regmap, chip->chip_irq,
> +			IRQF_TRIGGER_LOW | IRQF_ONESHOT | IRQF_SHARED,
> +			chip->irq_base, &da9062_irq_chip,
> +			&chip->regmap_irq);

This is just one call.  Just place that call into
da9062_device_init() and rid this function.

> +	if (ret) {
> +		dev_err(chip->dev, "Failed to request IRQ %d: %d\n",
> +			chip->chip_irq, ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +void da9062_irq_exit(struct da9062 *chip)
> +{
> +	regmap_del_irq_chip(chip->chip_irq, chip->regmap_irq);

Again, this is abstraction for the sake of abstraction.

> +}
> +
> +/* CORE device driver for DA9062 */

Doesn't add anything.  This whole driver is the core driver.

> +static struct resource da9062_core_resources[] =3D {

const?

> +	{
> +		.name	=3D "VDD_WARN",
> +		.start	=3D DA9062_IRQ_VDD_WARN,
> +		.end	=3D DA9062_IRQ_VDD_WARN,
> +		.flags	=3D IORESOURCE_IRQ,
> +	},
> +};
> +
> +static struct resource da9062_regulators_resources[] =3D {
> +	{
> +		.name	=3D "LDO_LIM",
> +		.start	=3D DA9062_IRQ_LDO_LIM,
> +		.end	=3D DA9062_IRQ_LDO_LIM,
> +		.flags	=3D IORESOURCE_IRQ,
> +	},
> +};
> +
> +static struct resource da9062_thermal_resources[] =3D {
> +	{
> +		.name	=3D "THERMAL",
> +		.start	=3D DA9062_IRQ_TEMP,
> +		.end	=3D DA9062_IRQ_TEMP,
> +		.flags	=3D IORESOURCE_IRQ,
> +	},
> +};
> +
> +static struct resource da9062_wdt_resources[] =3D {
> +	{
> +		.name	=3D "WDG_WARN",
> +		.start	=3D DA9062_IRQ_WDG_WARN,
> +		.end	=3D DA9062_IRQ_WDG_WARN,
> +		.flags	=3D IORESOURCE_IRQ,
> +	},
> +};

Convert all of these to oneliners using DEFINE_RES_* macros.

> +static const struct mfd_cell da9062_devs[] =3D {
> +	{
> +		.name		=3D "da9062-core",
> +		.num_resources	=3D ARRAY_SIZE(da9062_core_resources),
> +		.resources	=3D da9062_core_resources,
> +	},
> +	{
> +		.name		=3D "da9062-regulators",
> +		.num_resources	=3D ARRAY_SIZE(da9062_regulators_resources),
> +		.resources	=3D da9062_regulators_resources,
> +	},
> +	{
> +		.name		=3D "da9062-watchdog",
> +		.num_resources	=3D ARRAY_SIZE(da9062_wdt_resources),
> +		.resources	=3D da9062_wdt_resources,
> +		.of_compatible  =3D "dlg,da9062-wdt",
> +	},
> +	{
> +		.name		=3D "da9062-thermal",
> +		.num_resources	=3D ARRAY_SIZE(da9062_thermal_resources),
> +		.resources	=3D da9062_thermal_resources,
> +		.of_compatible  =3D "dlg,da9062-thermal",
> +	},
> +};
> +
> +static irqreturn_t da9062_vdd_warn_event(int irq, void *data)
> +{
> +	struct da9062 *hw =3D data;
> +
> +	dev_err(hw->dev, "VDD warning indicator\n");

Is it an error?  Doesn't look like it.

> +	return IRQ_HANDLED;
> +}
> +
> +static int da9062_clear_fault_log(struct da9062 *chip)
> +{
> +	int ret =3D 0;

No need to pre-initialise.

> +	int fault_log =3D 0;

As above.

> +	ret =3D regmap_read(chip->regmap, DA9062AA_FAULT_LOG, &fault_log);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "Cannot read FAULT_LOG.\n");
> +		ret =3D -EIO;

Just return and rid the else.

> +	} else {
> +		if (fault_log) {
> +			if (fault_log & DA9062AA_TWD_ERROR_MASK)
> +				dev_dbg(chip->dev, "Fault log entry detected: TWD_ERROR\n");
> +			if (fault_log & DA9062AA_POR_MASK)
> +				dev_dbg(chip->dev, "Fault log entry detected: POR\n");
> +			if (fault_log & DA9062AA_VDD_FAULT_MASK)
> +				dev_dbg(chip->dev, "Fault log entry detected: VDD_FAULT\n");
> +			if (fault_log & DA9062AA_VDD_START_MASK)
> +				dev_dbg(chip->dev, "Fault log entry detected: VDD_START\n");
> +			if (fault_log & DA9062AA_TEMP_CRIT_MASK)
> +				dev_dbg(chip->dev, "Fault log entry detected: TEMP_CRIT\n");
> +			if (fault_log & DA9062AA_KEY_RESET_MASK)
> +				dev_dbg(chip->dev, "Fault log entry detected: KEY_RESET\n");
> +			if (fault_log & DA9062AA_NSHUTDOWN_MASK)
> +				dev_dbg(chip->dev, "Fault log entry detected: NSHUTDOWN\n");
> +			if (fault_log & DA9062AA_WAIT_SHUT_MASK)
> +				dev_dbg(chip->dev, "Fault log entry detected: WAIT_SHUT\n");
> +		}
> +
> +		ret =3D regmap_write(chip->regmap, DA9062AA_FAULT_LOG,
> +				   fault_log);
> +		if (ret < 0)
> +			dev_err(chip->dev,
> +				"Cannot reset FAULT_LOG values %d\n", ret);
> +	}
> +
> +	return ret;
> +}
> +
> +int da9062_device_init(struct da9062 *chip, unsigned int irq)

No need to pass irq, as it's part of chip.

> +{
> +	int device_id, variant_id, variant_mrc;
> +	int irq_vdd_warn, ret;

Put ret on its own line.

> +	ret =3D da9062_clear_fault_log(chip);
> +	if (ret < 0)
> +		dev_err(chip->dev, "Cannot clear fault log\n");

If this is an error, you must return.  If it's just a warning then use
dev_warn().

> +	chip->irq_base =3D -1;

Why are you pre-initialising?

> +	chip->chip_irq =3D irq;

You already assigned irq to chip_irq.

> +	ret =3D regmap_read(chip->regmap, DA9062AA_DEVICE_ID, &device_id);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "Cannot read chip ID.\n");
> +		return -EIO;
> +	}
> +	if (device_id !=3D DA9062_PMIC_DEVICE_ID) {
> +		dev_err(chip->dev, "Invalid device ID: 0x%02x\n", device_id);
> +		return -ENODEV;
> +	}
> +
> +	ret =3D regmap_read(chip->regmap, DA9062AA_VARIANT_ID, &variant_id)=
;
> +	if (ret < 0) {
> +		dev_err(chip->dev, "Cannot read chip variant id.\n");
> +		return -EIO;
> +	}
> +
> +	dev_info(chip->dev,
> +		 "Device detected (device-ID: 0x%02X, var-ID: 0x%02X)\n",
> +		 device_id, variant_id);

Probably best to put this at the end.

> +	variant_mrc =3D (variant_id & DA9062AA_MRC_MASK) >> DA9062AA_MRC_SH=
IFT;
> +
> +	if (variant_mrc < DA9062_PMIC_VARIANT_MRC_AA) {
> +		dev_err(chip->dev,
> +			"Cannot support variant MRC: 0x%02X\n", variant_mrc);
> +		return -ENODEV;
> +	}
> +
> +	chip->device_id =3D device_id;
> +	chip->variant_mrc =3D variant_mrc;

I'd put all of the device/variant stuff it its own function, then move
everything else into probe() and remove da9062_device_init().

> +	ret =3D da9062_irq_init(chip);
> +	if (ret) {
> +		dev_err(chip->dev, "Cannot initialize interrupts.\n");
> +		return ret;
> +	}

Remove this function and call regmap_add_irq_chip() from here.

> +	chip->irq_base =3D regmap_irq_chip_get_base(chip->regmap_irq);
> +
> +	ret =3D mfd_add_devices(chip->dev, -1, da9062_devs,

Use PLATFORM_DEVID_NONE instead.

> +			      ARRAY_SIZE(da9062_devs), NULL, chip->irq_base,
> +			      NULL);

Usually child devices are probed at the end i.e. the last thing in
probe().

> +	if (ret) {
> +		dev_err(chip->dev, "Cannot add MFD cells\n");

"Cannot register child devices".

> +		da9062_irq_exit(chip);
> +		return ret;
> +	}
> +
> +	/* VDD WARN event support */
> +	irq_vdd_warn =3D regmap_irq_get_virq(chip->regmap_irq,
> +					   DA9062_IRQ_VDD_WARN);
> +	if (irq_vdd_warn < 0) {
> +		dev_err(chip->dev, "Failed to get IRQ.\n");
> +		return irq_vdd_warn;
> +	}
> +	chip->irq_vdd_warn =3D irq_vdd_warn;
> +
> +	ret =3D devm_request_threaded_irq(chip->dev, irq_vdd_warn,
> +					NULL, da9062_vdd_warn_event,
> +					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> +					"VDD_WARN", chip);
> +	if (ret) {
> +		dev_warn(chip->dev,
> +			 "Failed to request VDD_WARN IRQ.\n");
> +		chip->irq_vdd_warn =3D -ENXIO;
> +	}

This looks like a lot of code, which doesn't really do anything.  What
is a VDD warning indicator anyway?

> +	return ret;
> +}
> +
> +void da9062_device_exit(struct da9062 *chip)
> +{
> +	mfd_remove_devices(chip->dev);
> +	da9062_irq_exit(chip);
> +}

Another seemingly pointless abstraction.  Why don't you do this in
remove()?

> +/* I2C device driver for DA9062 */

Remove these.

> +static const struct regmap_range da9062_aa_readable_ranges[] =3D {
> +	{
> +		.range_min =3D DA9062AA_PAGE_CON,
> +		.range_max =3D DA9062AA_STATUS_B,
> +	}, {
> +		.range_min =3D DA9062AA_STATUS_D,
> +		.range_max =3D DA9062AA_EVENT_C,
> +	}, {
> +		.range_min =3D DA9062AA_IRQ_MASK_A,
> +		.range_max =3D DA9062AA_IRQ_MASK_C,
> +	}, {
> +		.range_min =3D DA9062AA_CONTROL_A,
> +		.range_max =3D DA9062AA_GPIO_4,
> +	}, {
> +		.range_min =3D DA9062AA_GPIO_WKUP_MODE,
> +		.range_max =3D DA9062AA_BUCK4_CONT,
> +	}, {
> +		.range_min =3D DA9062AA_BUCK3_CONT,
> +		.range_max =3D DA9062AA_BUCK3_CONT,
> +	}, {
> +		.range_min =3D DA9062AA_LDO1_CONT,
> +		.range_max =3D DA9062AA_LDO4_CONT,
> +	}, {
> +		.range_min =3D DA9062AA_DVC_1,
> +		.range_max =3D DA9062AA_DVC_1,
> +	}, {
> +		.range_min =3D DA9062AA_COUNT_S,
> +		.range_max =3D DA9062AA_SECOND_D,
> +	}, {
> +		.range_min =3D DA9062AA_SEQ,
> +		.range_max =3D DA9062AA_ID_4_3,
> +	}, {
> +		.range_min =3D DA9062AA_ID_12_11,
> +		.range_max =3D DA9062AA_ID_16_15,
> +	}, {
> +		.range_min =3D DA9062AA_ID_22_21,
> +		.range_max =3D DA9062AA_ID_32_31,
> +	}, {
> +		.range_min =3D DA9062AA_SEQ_A,
> +		.range_max =3D DA9062AA_BUCK3_CFG,
> +	}, {
> +		.range_min =3D DA9062AA_VBUCK2_A,
> +		.range_max =3D DA9062AA_VBUCK4_A,
> +	}, {
> +		.range_min =3D DA9062AA_VBUCK3_A,
> +		.range_max =3D DA9062AA_VBUCK3_A,
> +	}, {
> +		.range_min =3D DA9062AA_VLDO1_A,
> +		.range_max =3D DA9062AA_VLDO4_A,
> +	}, {
> +		.range_min =3D DA9062AA_VBUCK2_B,
> +		.range_max =3D DA9062AA_VBUCK4_B,
> +	}, {
> +		.range_min =3D DA9062AA_VBUCK3_B,
> +		.range_max =3D DA9062AA_VBUCK3_B,
> +	}, {
> +		.range_min =3D DA9062AA_VLDO1_B,
> +		.range_max =3D DA9062AA_VLDO4_B,
> +	}, {
> +		.range_min =3D DA9062AA_BBAT_CONT,
> +		.range_max =3D DA9062AA_BBAT_CONT,
> +	}, {
> +		.range_min =3D DA9062AA_INTERFACE,
> +		.range_max =3D DA9062AA_CONFIG_E,
> +	}, {
> +		.range_min =3D DA9062AA_CONFIG_G,
> +		.range_max =3D DA9062AA_CONFIG_K,
> +	}, {
> +		.range_min =3D DA9062AA_CONFIG_M,
> +		.range_max =3D DA9062AA_CONFIG_M,
> +	}, {
> +		.range_min =3D DA9062AA_TRIM_CLDR,
> +		.range_max =3D DA9062AA_GP_ID_19,
> +	}, {
> +		.range_min =3D DA9062AA_DEVICE_ID,
> +		.range_max =3D DA9062AA_CONFIG_ID,
> +	},
> +};
> +
> +static const struct regmap_range da9062_aa_writeable_ranges[] =3D {
> +	{
> +		.range_min =3D DA9062AA_PAGE_CON,
> +		.range_max =3D DA9062AA_PAGE_CON,
> +	}, {
> +		.range_min =3D DA9062AA_FAULT_LOG,
> +		.range_max =3D DA9062AA_EVENT_C,
> +	}, {
> +		.range_min =3D DA9062AA_IRQ_MASK_A,
> +		.range_max =3D DA9062AA_IRQ_MASK_C,
> +	}, {
> +		.range_min =3D DA9062AA_CONTROL_A,
> +		.range_max =3D DA9062AA_GPIO_4,
> +	}, {
> +		.range_min =3D DA9062AA_GPIO_WKUP_MODE,
> +		.range_max =3D DA9062AA_BUCK4_CONT,
> +	}, {
> +		.range_min =3D DA9062AA_BUCK3_CONT,
> +		.range_max =3D DA9062AA_BUCK3_CONT,
> +	}, {
> +		.range_min =3D DA9062AA_LDO1_CONT,
> +		.range_max =3D DA9062AA_LDO4_CONT,
> +	}, {
> +		.range_min =3D DA9062AA_DVC_1,
> +		.range_max =3D DA9062AA_DVC_1,
> +	}, {
> +		.range_min =3D DA9062AA_COUNT_S,
> +		.range_max =3D DA9062AA_ALARM_Y,
> +	}, {
> +		.range_min =3D DA9062AA_SEQ,
> +		.range_max =3D DA9062AA_ID_4_3,
> +	}, {
> +		.range_min =3D DA9062AA_ID_12_11,
> +		.range_max =3D DA9062AA_ID_16_15,
> +	}, {
> +		.range_min =3D DA9062AA_ID_22_21,
> +		.range_max =3D DA9062AA_ID_32_31,
> +	}, {
> +		.range_min =3D DA9062AA_SEQ_A,
> +		.range_max =3D DA9062AA_BUCK3_CFG,
> +	}, {
> +		.range_min =3D DA9062AA_VBUCK2_A,
> +		.range_max =3D DA9062AA_VBUCK4_A,
> +	}, {
> +		.range_min =3D DA9062AA_VBUCK3_A,
> +		.range_max =3D DA9062AA_VBUCK3_A,
> +	}, {
> +		.range_min =3D DA9062AA_VLDO1_A,
> +		.range_max =3D DA9062AA_VLDO4_A,
> +	}, {
> +		.range_min =3D DA9062AA_VBUCK2_B,
> +		.range_max =3D DA9062AA_VBUCK4_B,
> +	}, {
> +		.range_min =3D DA9062AA_VBUCK3_B,
> +		.range_max =3D DA9062AA_VBUCK3_B,
> +	}, {
> +		.range_min =3D DA9062AA_VLDO1_B,
> +		.range_max =3D DA9062AA_VLDO4_B,
> +	}, {
> +		.range_min =3D DA9062AA_BBAT_CONT,
> +		.range_max =3D DA9062AA_BBAT_CONT,
> +	}, {
> +		.range_min =3D DA9062AA_GP_ID_0,
> +		.range_max =3D DA9062AA_GP_ID_19,
> +	},
> +};
> +
> +static const struct regmap_range da9062_aa_volatile_ranges[] =3D {
> +	{
> +		.range_min =3D DA9062AA_PAGE_CON,
> +		.range_max =3D DA9062AA_STATUS_B,
> +	}, {
> +		.range_min =3D DA9062AA_STATUS_D,
> +		.range_max =3D DA9062AA_EVENT_C,
> +	}, {
> +		.range_min =3D DA9062AA_CONTROL_F,
> +		.range_max =3D DA9062AA_CONTROL_F,
> +	}, {
> +		.range_min =3D DA9062AA_COUNT_S,
> +		.range_max =3D DA9062AA_SECOND_D,
> +	},
> +};
> +
> +static const struct regmap_access_table da9062_aa_readable_table =3D=
 {
> +	.yes_ranges =3D da9062_aa_readable_ranges,
> +	.n_yes_ranges =3D ARRAY_SIZE(da9062_aa_readable_ranges),
> +};
> +
> +static const struct regmap_access_table da9062_aa_writeable_table =3D=
 {
> +	.yes_ranges =3D da9062_aa_writeable_ranges,
> +	.n_yes_ranges =3D ARRAY_SIZE(da9062_aa_writeable_ranges),
> +};
> +
> +static const struct regmap_access_table da9062_aa_volatile_table =3D=
 {
> +	.yes_ranges =3D da9062_aa_volatile_ranges,
> +	.n_yes_ranges =3D ARRAY_SIZE(da9062_aa_volatile_ranges),
> +};
> +
> +static const struct regmap_range_cfg da9062_range_cfg[] =3D {
> +	{
> +		.range_min =3D DA9062AA_PAGE_CON,
> +		.range_max =3D DA9062AA_CONFIG_ID,
> +		.selector_reg =3D DA9062AA_PAGE_CON,
> +		.selector_mask =3D 1 << DA9062_I2C_PAGE_SEL_SHIFT,
> +		.selector_shift =3D DA9062_I2C_PAGE_SEL_SHIFT,
> +		.window_start =3D 0,
> +		.window_len =3D 256,
> +	}
> +};
> +
> +static struct regmap_config da9062_regmap_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +	.ranges =3D da9062_range_cfg,
> +	.num_ranges =3D ARRAY_SIZE(da9062_range_cfg),
> +	.max_register =3D DA9062AA_CONFIG_ID,
> +	.cache_type =3D REGCACHE_RBTREE,
> +};
> +
> +static const struct of_device_id da9062_dt_ids[] =3D {
> +	{ .compatible =3D "dlg,da9062", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, da9062_dt_ids);

Move this just above where it's to be used i.e. down to the bottom.

> +static int da9062_i2c_probe(struct i2c_client *i2c,
> +	const struct i2c_device_id *id)
> +{
> +	struct da9062 *chip;
> +	int ret;
> +
> +	chip =3D devm_kzalloc(&i2c->dev, sizeof(struct da9062), GFP_KERNEL)=
;

sizeof(*chip)

> +	if (chip =3D=3D NULL)

if (!chip)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(i2c, chip);
> +	chip->dev =3D &i2c->dev;
> +	chip->chip_irq =3D i2c->irq;

Check this once here, then you don't have to worry about it again.

s/chip_irq/irq/

> +	da9062_regmap_config.rd_table =3D &da9062_aa_readable_table;
> +	da9062_regmap_config.wr_table =3D &da9062_aa_writeable_table;
> +	da9062_regmap_config.volatile_table =3D &da9062_aa_volatile_table;

Why are you doing this here instead of inside
'struct regmap_config da9062_regmap_config' above?

> +	chip->regmap =3D devm_regmap_init_i2c(i2c, &da9062_regmap_config);
> +	if (IS_ERR(chip->regmap)) {
> +		ret =3D PTR_ERR(chip->regmap);
> +		dev_err(chip->dev, "Failed to allocate register map: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	return da9062_device_init(chip, i2c->irq);
> +}
> +
> +static int da9062_i2c_remove(struct i2c_client *i2c)
> +{
> +	struct da9062 *chip =3D i2c_get_clientdata(i2c);
> +
> +	da9062_device_exit(chip);

Remove this.

> +	return 0;
> +}
> +
> +static const struct i2c_device_id da9062_i2c_id[] =3D {
> +	{"da9062", 0},

White space discipline.

> +	{},
> +};
> +MODULE_DEVICE_TABLE(i2c, da9062_i2c_id);
> +
> +static struct i2c_driver da9062_i2c_driver =3D {
> +	.driver =3D {
> +		.name =3D "da9062",
> +		.of_match_table =3D of_match_ptr(da9062_dt_ids),
> +	},
> +	.probe    =3D da9062_i2c_probe,
> +	.remove   =3D da9062_i2c_remove,
> +	.id_table =3D da9062_i2c_id,
> +};
> +
> +module_i2c_driver(da9062_i2c_driver);
> +
> +

Superfluous '\n'.

> +MODULE_DESCRIPTION("CORE device driver for Dialog DA9062");

s/CORE/Core/

> +MODULE_AUTHOR("S Twiss <stwiss.opensource@diasemi.com>");

=46ull names please.

> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/mfd/da9062/core.h b/include/linux/mfd/da90=
62/core.h
> new file mode 100644
> index 0000000..0b17891
> --- /dev/null
> +++ b/include/linux/mfd/da9062/core.h
> @@ -0,0 +1,62 @@
> +/*
> + * core.h - CORE H for DA9062

What does this add?

> + * Copyright (C) 2015  Dialog Semiconductor Ltd.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef __MFD_DA9062_CORE_H__
> +#define __MFD_DA9062_CORE_H__
> +
> +#include <linux/interrupt.h>
> +#include <linux/mfd/da9062/registers.h>
> +
> +/* Interrupts */
> +enum da9062_irqs {
> +	/* IRQ A */
> +	DA9062_IRQ_ONKEY,
> +	DA9062_IRQ_ALARM,
> +	DA9062_IRQ_TICK,
> +	DA9062_IRQ_WDG_WARN,
> +	DA9062_IRQ_SEQ_RDY,
> +	/* IRQ B*/
> +	DA9062_IRQ_TEMP,
> +	DA9062_IRQ_LDO_LIM,
> +	DA9062_IRQ_DVC_RDY,
> +	DA9062_IRQ_VDD_WARN,
> +	/* IRQ C */
> +	DA9062_IRQ_GPI0,
> +	DA9062_IRQ_GPI1,
> +	DA9062_IRQ_GPI2,
> +	DA9062_IRQ_GPI3,
> +	DA9062_IRQ_GPI4,
> +
> +	DA9062_NUM_IRQ,
> +};
> +
> +struct da9062 {
> +	struct device *dev;
> +	unsigned char device_id;
> +	unsigned char variant_mrc;
> +	struct regmap *regmap;
> +	int chip_irq;
> +	unsigned int irq_base;
> +	struct regmap_irq_chip_data *regmap_irq;
> +	int irq_vdd_warn;
> +};

Are all of these used by child devices?

> +int da9062_device_init(struct da9062 *, unsigned int);
> +int da9062_irq_init(struct da9062 *);
> +
> +void da9062_device_exit(struct da9062 *);
> +void da9062_irq_exit(struct da9062 *);

Why are these required?

> +#endif /* __MFD_DA9062_CORE_H__ */
> diff --git a/include/linux/mfd/da9062/registers.h b/include/linux/mfd=
/da9062/registers.h
> new file mode 100644
> index 0000000..d07c2bc
> --- /dev/null
> +++ b/include/linux/mfd/da9062/registers.h
> @@ -0,0 +1,1108 @@
> +/*
> + * registers.h - REGISTERS H for DA9062
> + * Copyright (C) 2015  Dialog Semiconductor Ltd.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef __DA9062_H__
> +#define __DA9062_H__
> +
> +#define DA9062_PMIC_DEVICE_ID		0x62
> +#define DA9062_PMIC_VARIANT_MRC_AA	0x01
> +
> +#define DA9062_I2C_PAGE_SEL_SHIFT	1
> +
> +/*
> + * Registers
> + */

Really? ;)

> +#define DA9062AA_PAGE_CON		0x000
> +#define DA9062AA_STATUS_A		0x001
> +#define DA9062AA_STATUS_B		0x002
> +#define DA9062AA_STATUS_D		0x004
> +#define DA9062AA_FAULT_LOG		0x005
> +#define DA9062AA_EVENT_A		0x006
> +#define DA9062AA_EVENT_B		0x007
> +#define DA9062AA_EVENT_C		0x008
> +#define DA9062AA_IRQ_MASK_A		0x00A
> +#define DA9062AA_IRQ_MASK_B		0x00B
> +#define DA9062AA_IRQ_MASK_C		0x00C
> +#define DA9062AA_CONTROL_A		0x00E
> +#define DA9062AA_CONTROL_B		0x00F
> +#define DA9062AA_CONTROL_C		0x010
> +#define DA9062AA_CONTROL_D		0x011
> +#define DA9062AA_CONTROL_E		0x012
> +#define DA9062AA_CONTROL_F		0x013
> +#define DA9062AA_PD_DIS			0x014
> +#define DA9062AA_GPIO_0_1		0x015
> +#define DA9062AA_GPIO_2_3		0x016
> +#define DA9062AA_GPIO_4			0x017
> +#define DA9062AA_GPIO_WKUP_MODE		0x01C
> +#define DA9062AA_GPIO_MODE0_4		0x01D
> +#define DA9062AA_GPIO_OUT0_2		0x01E
> +#define DA9062AA_GPIO_OUT3_4		0x01F
> +#define DA9062AA_BUCK2_CONT		0x020
> +#define DA9062AA_BUCK1_CONT		0x021
> +#define DA9062AA_BUCK4_CONT		0x022
> +#define DA9062AA_BUCK3_CONT		0x024
> +#define DA9062AA_LDO1_CONT		0x026
> +#define DA9062AA_LDO2_CONT		0x027
> +#define DA9062AA_LDO3_CONT		0x028
> +#define DA9062AA_LDO4_CONT		0x029
> +#define DA9062AA_DVC_1			0x032
> +#define DA9062AA_COUNT_S		0x040
> +#define DA9062AA_COUNT_MI		0x041
> +#define DA9062AA_COUNT_H		0x042
> +#define DA9062AA_COUNT_D		0x043
> +#define DA9062AA_COUNT_MO		0x044
> +#define DA9062AA_COUNT_Y		0x045
> +#define DA9062AA_ALARM_S		0x046
> +#define DA9062AA_ALARM_MI		0x047
> +#define DA9062AA_ALARM_H		0x048
> +#define DA9062AA_ALARM_D		0x049
> +#define DA9062AA_ALARM_MO		0x04A
> +#define DA9062AA_ALARM_Y		0x04B
> +#define DA9062AA_SECOND_A		0x04C
> +#define DA9062AA_SECOND_B		0x04D
> +#define DA9062AA_SECOND_C		0x04E
> +#define DA9062AA_SECOND_D		0x04F
> +#define DA9062AA_SEQ			0x081
> +#define DA9062AA_SEQ_TIMER		0x082
> +#define DA9062AA_ID_2_1			0x083
> +#define DA9062AA_ID_4_3			0x084
> +#define DA9062AA_ID_12_11		0x088
> +#define DA9062AA_ID_14_13		0x089
> +#define DA9062AA_ID_16_15		0x08A
> +#define DA9062AA_ID_22_21		0x08D
> +#define DA9062AA_ID_24_23		0x08E
> +#define DA9062AA_ID_26_25		0x08F
> +#define DA9062AA_ID_28_27		0x090
> +#define DA9062AA_ID_30_29		0x091
> +#define DA9062AA_ID_32_31		0x092
> +#define DA9062AA_SEQ_A			0x095
> +#define DA9062AA_SEQ_B			0x096
> +#define DA9062AA_WAIT			0x097
> +#define DA9062AA_EN_32K			0x098
> +#define DA9062AA_RESET			0x099
> +#define DA9062AA_BUCK_ILIM_A		0x09A
> +#define DA9062AA_BUCK_ILIM_B		0x09B
> +#define DA9062AA_BUCK_ILIM_C		0x09C
> +#define DA9062AA_BUCK2_CFG		0x09D
> +#define DA9062AA_BUCK1_CFG		0x09E
> +#define DA9062AA_BUCK4_CFG		0x09F
> +#define DA9062AA_BUCK3_CFG		0x0A0
> +#define DA9062AA_VBUCK2_A		0x0A3
> +#define DA9062AA_VBUCK1_A		0x0A4
> +#define DA9062AA_VBUCK4_A		0x0A5
> +#define DA9062AA_VBUCK3_A		0x0A7
> +#define DA9062AA_VLDO1_A		0x0A9
> +#define DA9062AA_VLDO2_A		0x0AA
> +#define DA9062AA_VLDO3_A		0x0AB
> +#define DA9062AA_VLDO4_A		0x0AC
> +#define DA9062AA_VBUCK2_B		0x0B4
> +#define DA9062AA_VBUCK1_B		0x0B5
> +#define DA9062AA_VBUCK4_B		0x0B6
> +#define DA9062AA_VBUCK3_B		0x0B8
> +#define DA9062AA_VLDO1_B		0x0BA
> +#define DA9062AA_VLDO2_B		0x0BB
> +#define DA9062AA_VLDO3_B		0x0BC
> +#define DA9062AA_VLDO4_B		0x0BD
> +#define DA9062AA_BBAT_CONT		0x0C5
> +#define DA9062AA_INTERFACE		0x105
> +#define DA9062AA_CONFIG_A		0x106
> +#define DA9062AA_CONFIG_B		0x107
> +#define DA9062AA_CONFIG_C		0x108
> +#define DA9062AA_CONFIG_D		0x109
> +#define DA9062AA_CONFIG_E		0x10A
> +#define DA9062AA_CONFIG_G		0x10C
> +#define DA9062AA_CONFIG_H		0x10D
> +#define DA9062AA_CONFIG_I		0x10E
> +#define DA9062AA_CONFIG_J		0x10F
> +#define DA9062AA_CONFIG_K		0x110
> +#define DA9062AA_CONFIG_M		0x112
> +#define DA9062AA_TRIM_CLDR		0x120
> +#define DA9062AA_GP_ID_0		0x121
> +#define DA9062AA_GP_ID_1		0x122
> +#define DA9062AA_GP_ID_2		0x123
> +#define DA9062AA_GP_ID_3		0x124
> +#define DA9062AA_GP_ID_4		0x125
> +#define DA9062AA_GP_ID_5		0x126
> +#define DA9062AA_GP_ID_6		0x127
> +#define DA9062AA_GP_ID_7		0x128
> +#define DA9062AA_GP_ID_8		0x129
> +#define DA9062AA_GP_ID_9		0x12A
> +#define DA9062AA_GP_ID_10		0x12B
> +#define DA9062AA_GP_ID_11		0x12C
> +#define DA9062AA_GP_ID_12		0x12D
> +#define DA9062AA_GP_ID_13		0x12E
> +#define DA9062AA_GP_ID_14		0x12F
> +#define DA9062AA_GP_ID_15		0x130
> +#define DA9062AA_GP_ID_16		0x131
> +#define DA9062AA_GP_ID_17		0x132
> +#define DA9062AA_GP_ID_18		0x133
> +#define DA9062AA_GP_ID_19		0x134
> +#define DA9062AA_DEVICE_ID		0x181
> +#define DA9062AA_VARIANT_ID		0x182
> +#define DA9062AA_CUSTOMER_ID		0x183
> +#define DA9062AA_CONFIG_ID		0x184
> +
> +/*
> + * Bit fields
> + */
> +
> +/* DA9062AA_PAGE_CON =3D 0x000 */
> +#define DA9062AA_PAGE_SHIFT		0
> +#define DA9062AA_PAGE_MASK		(0x3f << 0)
> +#define DA9062AA_WRITE_MODE_SHIFT	6
> +#define DA9062AA_WRITE_MODE_MASK	(0x01 << 6)

=46or 1 << X, you should use BIT(X).

> +#define DA9062AA_REVERT_SHIFT		7
> +#define DA9062AA_REVERT_MASK		(0x01 << 7)
> +
> +/* DA9062AA_STATUS_A =3D 0x001 */
> +#define DA9062AA_NONKEY_SHIFT		0
> +#define DA9062AA_NONKEY_MASK		(0x01 << 0)
> +#define DA9062AA_DVC_BUSY_SHIFT		2
> +#define DA9062AA_DVC_BUSY_MASK		(0x01 << 2)
> +
> +/* DA9062AA_STATUS_B =3D 0x002 */
> +#define DA9062AA_GPI0_SHIFT		0
> +#define DA9062AA_GPI0_MASK		(0x01 << 0)
> +#define DA9062AA_GPI1_SHIFT		1
> +#define DA9062AA_GPI1_MASK		(0x01 << 1)
> +#define DA9062AA_GPI2_SHIFT		2
> +#define DA9062AA_GPI2_MASK		(0x01 << 2)
> +#define DA9062AA_GPI3_SHIFT		3
> +#define DA9062AA_GPI3_MASK		(0x01 << 3)
> +#define DA9062AA_GPI4_SHIFT		4
> +#define DA9062AA_GPI4_MASK		(0x01 << 4)
> +
> +/* DA9062AA_STATUS_D =3D 0x004 */
> +#define DA9062AA_LDO1_ILIM_SHIFT	0
> +#define DA9062AA_LDO1_ILIM_MASK		(0x01 << 0)
> +#define DA9062AA_LDO2_ILIM_SHIFT	1
> +#define DA9062AA_LDO2_ILIM_MASK		(0x01 << 1)
> +#define DA9062AA_LDO3_ILIM_SHIFT	2
> +#define DA9062AA_LDO3_ILIM_MASK		(0x01 << 2)
> +#define DA9062AA_LDO4_ILIM_SHIFT	3
> +#define DA9062AA_LDO4_ILIM_MASK		(0x01 << 3)
> +
> +/* DA9062AA_FAULT_LOG =3D 0x005 */
> +#define DA9062AA_TWD_ERROR_SHIFT	0
> +#define DA9062AA_TWD_ERROR_MASK		(0x01 << 0)
> +#define DA9062AA_POR_SHIFT		1
> +#define DA9062AA_POR_MASK		(0x01 << 1)
> +#define DA9062AA_VDD_FAULT_SHIFT	2
> +#define DA9062AA_VDD_FAULT_MASK		(0x01 << 2)
> +#define DA9062AA_VDD_START_SHIFT	3
> +#define DA9062AA_VDD_START_MASK		(0x01 << 3)
> +#define DA9062AA_TEMP_CRIT_SHIFT	4
> +#define DA9062AA_TEMP_CRIT_MASK		(0x01 << 4)
> +#define DA9062AA_KEY_RESET_SHIFT	5
> +#define DA9062AA_KEY_RESET_MASK		(0x01 << 5)
> +#define DA9062AA_NSHUTDOWN_SHIFT	6
> +#define DA9062AA_NSHUTDOWN_MASK		(0x01 << 6)
> +#define DA9062AA_WAIT_SHUT_SHIFT	7
> +#define DA9062AA_WAIT_SHUT_MASK		(0x01 << 7)
> +
> +/* DA9062AA_EVENT_A =3D 0x006 */
> +#define DA9062AA_E_NONKEY_SHIFT		0
> +#define DA9062AA_E_NONKEY_MASK		(0x01 << 0)
> +#define DA9062AA_E_ALARM_SHIFT		1
> +#define DA9062AA_E_ALARM_MASK		(0x01 << 1)
> +#define DA9062AA_E_TICK_SHIFT		2
> +#define DA9062AA_E_TICK_MASK		(0x01 << 2)
> +#define DA9062AA_E_WDG_WARN_SHIFT	3
> +#define DA9062AA_E_WDG_WARN_MASK	(0x01 << 3)
> +#define DA9062AA_E_SEQ_RDY_SHIFT	4
> +#define DA9062AA_E_SEQ_RDY_MASK		(0x01 << 4)
> +#define DA9062AA_EVENTS_B_SHIFT		5
> +#define DA9062AA_EVENTS_B_MASK		(0x01 << 5)
> +#define DA9062AA_EVENTS_C_SHIFT		6
> +#define DA9062AA_EVENTS_C_MASK		(0x01 << 6)
> +
> +/* DA9062AA_EVENT_B =3D 0x007 */
> +#define DA9062AA_E_TEMP_SHIFT		1
> +#define DA9062AA_E_TEMP_MASK		(0x01 << 1)
> +#define DA9062AA_E_LDO_LIM_SHIFT	3
> +#define DA9062AA_E_LDO_LIM_MASK		(0x01 << 3)
> +#define DA9062AA_E_DVC_RDY_SHIFT	5
> +#define DA9062AA_E_DVC_RDY_MASK		(0x01 << 5)
> +#define DA9062AA_E_VDD_WARN_SHIFT	7
> +#define DA9062AA_E_VDD_WARN_MASK	(0x01 << 7)
> +
> +/* DA9062AA_EVENT_C =3D 0x008 */
> +#define DA9062AA_E_GPI0_SHIFT		0
> +#define DA9062AA_E_GPI0_MASK		(0x01 << 0)
> +#define DA9062AA_E_GPI1_SHIFT		1
> +#define DA9062AA_E_GPI1_MASK		(0x01 << 1)
> +#define DA9062AA_E_GPI2_SHIFT		2
> +#define DA9062AA_E_GPI2_MASK		(0x01 << 2)
> +#define DA9062AA_E_GPI3_SHIFT		3
> +#define DA9062AA_E_GPI3_MASK		(0x01 << 3)
> +#define DA9062AA_E_GPI4_SHIFT		4
> +#define DA9062AA_E_GPI4_MASK		(0x01 << 4)
> +
> +/* DA9062AA_IRQ_MASK_A =3D 0x00A */
> +#define DA9062AA_M_NONKEY_SHIFT		0
> +#define DA9062AA_M_NONKEY_MASK		(0x01 << 0)
> +#define DA9062AA_M_ALARM_SHIFT		1
> +#define DA9062AA_M_ALARM_MASK		(0x01 << 1)
> +#define DA9062AA_M_TICK_SHIFT		2
> +#define DA9062AA_M_TICK_MASK		(0x01 << 2)
> +#define DA9062AA_M_WDG_WARN_SHIFT	3
> +#define DA9062AA_M_WDG_WARN_MASK	(0x01 << 3)
> +#define DA9062AA_M_SEQ_RDY_SHIFT	4
> +#define DA9062AA_M_SEQ_RDY_MASK		(0x01 << 4)
> +
> +/* DA9062AA_IRQ_MASK_B =3D 0x00B */
> +#define DA9062AA_M_TEMP_SHIFT		1
> +#define DA9062AA_M_TEMP_MASK		(0x01 << 1)
> +#define DA9062AA_M_LDO_LIM_SHIFT	3
> +#define DA9062AA_M_LDO_LIM_MASK		(0x01 << 3)
> +#define DA9062AA_M_DVC_RDY_SHIFT	5
> +#define DA9062AA_M_DVC_RDY_MASK		(0x01 << 5)
> +#define DA9062AA_M_VDD_WARN_SHIFT	7
> +#define DA9062AA_M_VDD_WARN_MASK	(0x01 << 7)
> +
> +/* DA9062AA_IRQ_MASK_C =3D 0x00C */
> +#define DA9062AA_M_GPI0_SHIFT		0
> +#define DA9062AA_M_GPI0_MASK		(0x01 << 0)
> +#define DA9062AA_M_GPI1_SHIFT		1
> +#define DA9062AA_M_GPI1_MASK		(0x01 << 1)
> +#define DA9062AA_M_GPI2_SHIFT		2
> +#define DA9062AA_M_GPI2_MASK		(0x01 << 2)
> +#define DA9062AA_M_GPI3_SHIFT		3
> +#define DA9062AA_M_GPI3_MASK		(0x01 << 3)
> +#define DA9062AA_M_GPI4_SHIFT		4
> +#define DA9062AA_M_GPI4_MASK		(0x01 << 4)
> +
> +/* DA9062AA_CONTROL_A =3D 0x00E */
> +#define DA9062AA_SYSTEM_EN_SHIFT	0
> +#define DA9062AA_SYSTEM_EN_MASK		(0x01 << 0)
> +#define DA9062AA_POWER_EN_SHIFT		1
> +#define DA9062AA_POWER_EN_MASK		(0x01 << 1)
> +#define DA9062AA_POWER1_EN_SHIFT	2
> +#define DA9062AA_POWER1_EN_MASK		(0x01 << 2)
> +#define DA9062AA_STANDBY_SHIFT		3
> +#define DA9062AA_STANDBY_MASK		(0x01 << 3)
> +#define DA9062AA_M_SYSTEM_EN_SHIFT	4
> +#define DA9062AA_M_SYSTEM_EN_MASK	(0x01 << 4)
> +#define DA9062AA_M_POWER_EN_SHIFT	5
> +#define DA9062AA_M_POWER_EN_MASK	(0x01 << 5)
> +#define DA9062AA_M_POWER1_EN_SHIFT	6
> +#define DA9062AA_M_POWER1_EN_MASK	(0x01 << 6)
> +
> +/* DA9062AA_CONTROL_B =3D 0x00F */
> +#define DA9062AA_WATCHDOG_PD_SHIFT	1
> +#define DA9062AA_WATCHDOG_PD_MASK	(0x01 << 1)
> +#define DA9062AA_FREEZE_EN_SHIFT	2
> +#define DA9062AA_FREEZE_EN_MASK		(0x01 << 2)
> +#define DA9062AA_NRES_MODE_SHIFT	3
> +#define DA9062AA_NRES_MODE_MASK		(0x01 << 3)
> +#define DA9062AA_NONKEY_LOCK_SHIFT	4
> +#define DA9062AA_NONKEY_LOCK_MASK	(0x01 << 4)
> +#define DA9062AA_NFREEZE_SHIFT		5
> +#define DA9062AA_NFREEZE_MASK		(0x03 << 5)
> +#define DA9062AA_BUCK_SLOWSTART_SHIFT	7
> +#define DA9062AA_BUCK_SLOWSTART_MASK	(0x01 << 7)
> +
> +/* DA9062AA_CONTROL_C =3D 0x010 */
> +#define DA9062AA_DEBOUNCING_SHIFT	0
> +#define DA9062AA_DEBOUNCING_MASK	(0x07 << 0)
> +#define DA9062AA_AUTO_BOOT_SHIFT	3
> +#define DA9062AA_AUTO_BOOT_MASK		(0x01 << 3)
> +#define DA9062AA_OTPREAD_EN_SHIFT	4
> +#define DA9062AA_OTPREAD_EN_MASK	(0x01 << 4)
> +#define DA9062AA_SLEW_RATE_SHIFT	5
> +#define DA9062AA_SLEW_RATE_MASK		(0x03 << 5)
> +#define DA9062AA_DEF_SUPPLY_SHIFT	7
> +#define DA9062AA_DEF_SUPPLY_MASK	(0x01 << 7)
> +
> +/* DA9062AA_CONTROL_D =3D 0x011 */
> +#define DA9062AA_TWDSCALE_SHIFT		0
> +#define DA9062AA_TWDSCALE_MASK		(0x07 << 0)
> +
> +/* DA9062AA_CONTROL_E =3D 0x012 */
> +#define DA9062AA_RTC_MODE_PD_SHIFT	0
> +#define DA9062AA_RTC_MODE_PD_MASK	(0x01 << 0)
> +#define DA9062AA_RTC_MODE_SD_SHIFT	1
> +#define DA9062AA_RTC_MODE_SD_MASK	(0x01 << 1)
> +#define DA9062AA_RTC_EN_SHIFT		2
> +#define DA9062AA_RTC_EN_MASK		(0x01 << 2)
> +#define DA9062AA_V_LOCK_SHIFT		7
> +#define DA9062AA_V_LOCK_MASK		(0x01 << 7)
> +
> +/* DA9062AA_CONTROL_F =3D 0x013 */
> +#define DA9062AA_WATCHDOG_SHIFT		0
> +#define DA9062AA_WATCHDOG_MASK		(0x01 << 0)
> +#define DA9062AA_SHUTDOWN_SHIFT		1
> +#define DA9062AA_SHUTDOWN_MASK		(0x01 << 1)
> +#define DA9062AA_WAKE_UP_SHIFT		2
> +#define DA9062AA_WAKE_UP_MASK		(0x01 << 2)
> +
> +/* DA9062AA_PD_DIS =3D 0x014 */
> +#define DA9062AA_GPI_DIS_SHIFT		0
> +#define DA9062AA_GPI_DIS_MASK		(0x01 << 0)
> +#define DA9062AA_PMIF_DIS_SHIFT		2
> +#define DA9062AA_PMIF_DIS_MASK		(0x01 << 2)
> +#define DA9062AA_CLDR_PAUSE_SHIFT	4
> +#define DA9062AA_CLDR_PAUSE_MASK	(0x01 << 4)
> +#define DA9062AA_BBAT_DIS_SHIFT		5
> +#define DA9062AA_BBAT_DIS_MASK		(0x01 << 5)
> +#define DA9062AA_OUT32K_PAUSE_SHIFT	6
> +#define DA9062AA_OUT32K_PAUSE_MASK	(0x01 << 6)
> +#define DA9062AA_PMCONT_DIS_SHIFT	7
> +#define DA9062AA_PMCONT_DIS_MASK	(0x01 << 7)
> +
> +/* DA9062AA_GPIO_0_1 =3D 0x015 */
> +#define DA9062AA_GPIO0_PIN_SHIFT	0
> +#define DA9062AA_GPIO0_PIN_MASK		(0x03 << 0)
> +#define DA9062AA_GPIO0_TYPE_SHIFT	2
> +#define DA9062AA_GPIO0_TYPE_MASK	(0x01 << 2)
> +#define DA9062AA_GPIO0_WEN_SHIFT	3
> +#define DA9062AA_GPIO0_WEN_MASK		(0x01 << 3)
> +#define DA9062AA_GPIO1_PIN_SHIFT	4
> +#define DA9062AA_GPIO1_PIN_MASK		(0x03 << 4)
> +#define DA9062AA_GPIO1_TYPE_SHIFT	6
> +#define DA9062AA_GPIO1_TYPE_MASK	(0x01 << 6)
> +#define DA9062AA_GPIO1_WEN_SHIFT	7
> +#define DA9062AA_GPIO1_WEN_MASK		(0x01 << 7)
> +
> +/* DA9062AA_GPIO_2_3 =3D 0x016 */
> +#define DA9062AA_GPIO2_PIN_SHIFT	0
> +#define DA9062AA_GPIO2_PIN_MASK		(0x03 << 0)
> +#define DA9062AA_GPIO2_TYPE_SHIFT	2
> +#define DA9062AA_GPIO2_TYPE_MASK	(0x01 << 2)
> +#define DA9062AA_GPIO2_WEN_SHIFT	3
> +#define DA9062AA_GPIO2_WEN_MASK		(0x01 << 3)
> +#define DA9062AA_GPIO3_PIN_SHIFT	4
> +#define DA9062AA_GPIO3_PIN_MASK		(0x03 << 4)
> +#define DA9062AA_GPIO3_TYPE_SHIFT	6
> +#define DA9062AA_GPIO3_TYPE_MASK	(0x01 << 6)
> +#define DA9062AA_GPIO3_WEN_SHIFT	7
> +#define DA9062AA_GPIO3_WEN_MASK		(0x01 << 7)
> +
> +/* DA9062AA_GPIO_4 =3D 0x017 */
> +#define DA9062AA_GPIO4_PIN_SHIFT	0
> +#define DA9062AA_GPIO4_PIN_MASK		(0x03 << 0)
> +#define DA9062AA_GPIO4_TYPE_SHIFT	2
> +#define DA9062AA_GPIO4_TYPE_MASK	(0x01 << 2)
> +#define DA9062AA_GPIO4_WEN_SHIFT	3
> +#define DA9062AA_GPIO4_WEN_MASK		(0x01 << 3)
> +
> +/* DA9062AA_GPIO_WKUP_MODE =3D 0x01C */
> +#define DA9062AA_GPIO0_WKUP_MODE_SHIFT	0
> +#define DA9062AA_GPIO0_WKUP_MODE_MASK	(0x01 << 0)
> +#define DA9062AA_GPIO1_WKUP_MODE_SHIFT	1
> +#define DA9062AA_GPIO1_WKUP_MODE_MASK	(0x01 << 1)
> +#define DA9062AA_GPIO2_WKUP_MODE_SHIFT	2
> +#define DA9062AA_GPIO2_WKUP_MODE_MASK	(0x01 << 2)
> +#define DA9062AA_GPIO3_WKUP_MODE_SHIFT	3
> +#define DA9062AA_GPIO3_WKUP_MODE_MASK	(0x01 << 3)
> +#define DA9062AA_GPIO4_WKUP_MODE_SHIFT	4
> +#define DA9062AA_GPIO4_WKUP_MODE_MASK	(0x01 << 4)
> +
> +/* DA9062AA_GPIO_MODE0_4 =3D 0x01D */
> +#define DA9062AA_GPIO0_MODE_SHIFT	0
> +#define DA9062AA_GPIO0_MODE_MASK	(0x01 << 0)
> +#define DA9062AA_GPIO1_MODE_SHIFT	1
> +#define DA9062AA_GPIO1_MODE_MASK	(0x01 << 1)
> +#define DA9062AA_GPIO2_MODE_SHIFT	2
> +#define DA9062AA_GPIO2_MODE_MASK	(0x01 << 2)
> +#define DA9062AA_GPIO3_MODE_SHIFT	3
> +#define DA9062AA_GPIO3_MODE_MASK	(0x01 << 3)
> +#define DA9062AA_GPIO4_MODE_SHIFT	4
> +#define DA9062AA_GPIO4_MODE_MASK	(0x01 << 4)
> +
> +/* DA9062AA_GPIO_OUT0_2 =3D 0x01E */
> +#define DA9062AA_GPIO0_OUT_SHIFT	0
> +#define DA9062AA_GPIO0_OUT_MASK		(0x07 << 0)
> +#define DA9062AA_GPIO1_OUT_SHIFT	3
> +#define DA9062AA_GPIO1_OUT_MASK		(0x07 << 3)
> +#define DA9062AA_GPIO2_OUT_SHIFT	6
> +#define DA9062AA_GPIO2_OUT_MASK		(0x03 << 6)
> +
> +/* DA9062AA_GPIO_OUT3_4 =3D 0x01F */
> +#define DA9062AA_GPIO3_OUT_SHIFT	0
> +#define DA9062AA_GPIO3_OUT_MASK		(0x07 << 0)
> +#define DA9062AA_GPIO4_OUT_SHIFT	3
> +#define DA9062AA_GPIO4_OUT_MASK		(0x03 << 3)
> +
> +/* DA9062AA_BUCK2_CONT =3D 0x020 */
> +#define DA9062AA_BUCK2_EN_SHIFT		0
> +#define DA9062AA_BUCK2_EN_MASK		(0x01 << 0)
> +#define DA9062AA_BUCK2_GPI_SHIFT	1
> +#define DA9062AA_BUCK2_GPI_MASK		(0x03 << 1)
> +#define DA9062AA_BUCK2_CONF_SHIFT	3
> +#define DA9062AA_BUCK2_CONF_MASK	(0x01 << 3)
> +#define DA9062AA_VBUCK2_GPI_SHIFT	5
> +#define DA9062AA_VBUCK2_GPI_MASK	(0x03 << 5)
> +
> +/* DA9062AA_BUCK1_CONT =3D 0x021 */
> +#define DA9062AA_BUCK1_EN_SHIFT		0
> +#define DA9062AA_BUCK1_EN_MASK		(0x01 << 0)
> +#define DA9062AA_BUCK1_GPI_SHIFT	1
> +#define DA9062AA_BUCK1_GPI_MASK		(0x03 << 1)
> +#define DA9062AA_BUCK1_CONF_SHIFT	3
> +#define DA9062AA_BUCK1_CONF_MASK	(0x01 << 3)
> +#define DA9062AA_VBUCK1_GPI_SHIFT	5
> +#define DA9062AA_VBUCK1_GPI_MASK	(0x03 << 5)
> +
> +/* DA9062AA_BUCK4_CONT =3D 0x022 */
> +#define DA9062AA_BUCK4_EN_SHIFT		0
> +#define DA9062AA_BUCK4_EN_MASK		(0x01 << 0)
> +#define DA9062AA_BUCK4_GPI_SHIFT	1
> +#define DA9062AA_BUCK4_GPI_MASK		(0x03 << 1)
> +#define DA9062AA_BUCK4_CONF_SHIFT	3
> +#define DA9062AA_BUCK4_CONF_MASK	(0x01 << 3)
> +#define DA9062AA_VBUCK4_GPI_SHIFT	5
> +#define DA9062AA_VBUCK4_GPI_MASK	(0x03 << 5)
> +
> +/* DA9062AA_BUCK3_CONT =3D 0x024 */
> +#define DA9062AA_BUCK3_EN_SHIFT		0
> +#define DA9062AA_BUCK3_EN_MASK		(0x01 << 0)
> +#define DA9062AA_BUCK3_GPI_SHIFT	1
> +#define DA9062AA_BUCK3_GPI_MASK		(0x03 << 1)
> +#define DA9062AA_BUCK3_CONF_SHIFT	3
> +#define DA9062AA_BUCK3_CONF_MASK	(0x01 << 3)
> +#define DA9062AA_VBUCK3_GPI_SHIFT	5
> +#define DA9062AA_VBUCK3_GPI_MASK	(0x03 << 5)
> +
> +/* DA9062AA_LDO1_CONT =3D 0x026 */
> +#define DA9062AA_LDO1_EN_SHIFT		0
> +#define DA9062AA_LDO1_EN_MASK		(0x01 << 0)
> +#define DA9062AA_LDO1_GPI_SHIFT		1
> +#define DA9062AA_LDO1_GPI_MASK		(0x03 << 1)
> +#define DA9062AA_LDO1_PD_DIS_SHIFT	3
> +#define DA9062AA_LDO1_PD_DIS_MASK	(0x01 << 3)
> +#define DA9062AA_VLDO1_GPI_SHIFT	5
> +#define DA9062AA_VLDO1_GPI_MASK		(0x03 << 5)
> +#define DA9062AA_LDO1_CONF_SHIFT	7
> +#define DA9062AA_LDO1_CONF_MASK		(0x01 << 7)
> +
> +/* DA9062AA_LDO2_CONT =3D 0x027 */
> +#define DA9062AA_LDO2_EN_SHIFT		0
> +#define DA9062AA_LDO2_EN_MASK		(0x01 << 0)
> +#define DA9062AA_LDO2_GPI_SHIFT		1
> +#define DA9062AA_LDO2_GPI_MASK		(0x03 << 1)
> +#define DA9062AA_LDO2_PD_DIS_SHIFT	3
> +#define DA9062AA_LDO2_PD_DIS_MASK	(0x01 << 3)
> +#define DA9062AA_VLDO2_GPI_SHIFT	5
> +#define DA9062AA_VLDO2_GPI_MASK		(0x03 << 5)
> +#define DA9062AA_LDO2_CONF_SHIFT	7
> +#define DA9062AA_LDO2_CONF_MASK		(0x01 << 7)
> +
> +/* DA9062AA_LDO3_CONT =3D 0x028 */
> +#define DA9062AA_LDO3_EN_SHIFT		0
> +#define DA9062AA_LDO3_EN_MASK		(0x01 << 0)
> +#define DA9062AA_LDO3_GPI_SHIFT		1
> +#define DA9062AA_LDO3_GPI_MASK		(0x03 << 1)
> +#define DA9062AA_LDO3_PD_DIS_SHIFT	3
> +#define DA9062AA_LDO3_PD_DIS_MASK	(0x01 << 3)
> +#define DA9062AA_VLDO3_GPI_SHIFT	5
> +#define DA9062AA_VLDO3_GPI_MASK		(0x03 << 5)
> +#define DA9062AA_LDO3_CONF_SHIFT	7
> +#define DA9062AA_LDO3_CONF_MASK		(0x01 << 7)
> +
> +/* DA9062AA_LDO4_CONT =3D 0x029 */
> +#define DA9062AA_LDO4_EN_SHIFT		0
> +#define DA9062AA_LDO4_EN_MASK		(0x01 << 0)
> +#define DA9062AA_LDO4_GPI_SHIFT		1
> +#define DA9062AA_LDO4_GPI_MASK		(0x03 << 1)
> +#define DA9062AA_LDO4_PD_DIS_SHIFT	3
> +#define DA9062AA_LDO4_PD_DIS_MASK	(0x01 << 3)
> +#define DA9062AA_VLDO4_GPI_SHIFT	5
> +#define DA9062AA_VLDO4_GPI_MASK		(0x03 << 5)
> +#define DA9062AA_LDO4_CONF_SHIFT	7
> +#define DA9062AA_LDO4_CONF_MASK		(0x01 << 7)
> +
> +/* DA9062AA_DVC_1 =3D 0x032 */
> +#define DA9062AA_VBUCK1_SEL_SHIFT	0
> +#define DA9062AA_VBUCK1_SEL_MASK	(0x01 << 0)
> +#define DA9062AA_VBUCK2_SEL_SHIFT	1
> +#define DA9062AA_VBUCK2_SEL_MASK	(0x01 << 1)
> +#define DA9062AA_VBUCK4_SEL_SHIFT	2
> +#define DA9062AA_VBUCK4_SEL_MASK	(0x01 << 2)
> +#define DA9062AA_VBUCK3_SEL_SHIFT	3
> +#define DA9062AA_VBUCK3_SEL_MASK	(0x01 << 3)
> +#define DA9062AA_VLDO1_SEL_SHIFT	4
> +#define DA9062AA_VLDO1_SEL_MASK		(0x01 << 4)
> +#define DA9062AA_VLDO2_SEL_SHIFT	5
> +#define DA9062AA_VLDO2_SEL_MASK		(0x01 << 5)
> +#define DA9062AA_VLDO3_SEL_SHIFT	6
> +#define DA9062AA_VLDO3_SEL_MASK		(0x01 << 6)
> +#define DA9062AA_VLDO4_SEL_SHIFT	7
> +#define DA9062AA_VLDO4_SEL_MASK		(0x01 << 7)
> +
> +/* DA9062AA_COUNT_S =3D 0x040 */
> +#define DA9062AA_COUNT_SEC_SHIFT	0
> +#define DA9062AA_COUNT_SEC_MASK		(0x3f << 0)
> +#define DA9062AA_RTC_READ_SHIFT		7
> +#define DA9062AA_RTC_READ_MASK		(0x01 << 7)
> +
> +/* DA9062AA_COUNT_MI =3D 0x041 */
> +#define DA9062AA_COUNT_MIN_SHIFT	0
> +#define DA9062AA_COUNT_MIN_MASK		(0x3f << 0)
> +
> +/* DA9062AA_COUNT_H =3D 0x042 */
> +#define DA9062AA_COUNT_HOUR_SHIFT	0
> +#define DA9062AA_COUNT_HOUR_MASK	(0x1f << 0)
> +
> +/* DA9062AA_COUNT_D =3D 0x043 */
> +#define DA9062AA_COUNT_DAY_SHIFT	0
> +#define DA9062AA_COUNT_DAY_MASK		(0x1f << 0)
> +
> +/* DA9062AA_COUNT_MO =3D 0x044 */
> +#define DA9062AA_COUNT_MONTH_SHIFT	0
> +#define DA9062AA_COUNT_MONTH_MASK	(0x0f << 0)
> +
> +/* DA9062AA_COUNT_Y =3D 0x045 */
> +#define DA9062AA_COUNT_YEAR_SHIFT	0
> +#define DA9062AA_COUNT_YEAR_MASK	(0x3f << 0)
> +#define DA9062AA_MONITOR_SHIFT		6
> +#define DA9062AA_MONITOR_MASK		(0x01 << 6)
> +
> +/* DA9062AA_ALARM_S =3D 0x046 */
> +#define DA9062AA_ALARM_SEC_SHIFT	0
> +#define DA9062AA_ALARM_SEC_MASK		(0x3f << 0)
> +#define DA9062AA_ALARM_STATUS_SHIFT	6
> +#define DA9062AA_ALARM_STATUS_MASK	(0x03 << 6)
> +
> +/* DA9062AA_ALARM_MI =3D 0x047 */
> +#define DA9062AA_ALARM_MIN_SHIFT	0
> +#define DA9062AA_ALARM_MIN_MASK		(0x3f << 0)
> +
> +/* DA9062AA_ALARM_H =3D 0x048 */
> +#define DA9062AA_ALARM_HOUR_SHIFT	0
> +#define DA9062AA_ALARM_HOUR_MASK	(0x1f << 0)
> +
> +/* DA9062AA_ALARM_D =3D 0x049 */
> +#define DA9062AA_ALARM_DAY_SHIFT	0
> +#define DA9062AA_ALARM_DAY_MASK		(0x1f << 0)
> +
> +/* DA9062AA_ALARM_MO =3D 0x04A */
> +#define DA9062AA_ALARM_MONTH_SHIFT	0
> +#define DA9062AA_ALARM_MONTH_MASK	(0x0f << 0)
> +#define DA9062AA_TICK_TYPE_SHIFT	4
> +#define DA9062AA_TICK_TYPE_MASK		(0x01 << 4)
> +#define DA9062AA_TICK_WAKE_SHIFT	5
> +#define DA9062AA_TICK_WAKE_MASK		(0x01 << 5)
> +
> +/* DA9062AA_ALARM_Y =3D 0x04B */
> +#define DA9062AA_ALARM_YEAR_SHIFT	0
> +#define DA9062AA_ALARM_YEAR_MASK	(0x3f << 0)
> +#define DA9062AA_ALARM_ON_SHIFT		6
> +#define DA9062AA_ALARM_ON_MASK		(0x01 << 6)
> +#define DA9062AA_TICK_ON_SHIFT		7
> +#define DA9062AA_TICK_ON_MASK		(0x01 << 7)
> +
> +/* DA9062AA_SECOND_A =3D 0x04C */
> +#define DA9062AA_SECONDS_A_SHIFT	0
> +#define DA9062AA_SECONDS_A_MASK		(0xff << 0)
> +
> +/* DA9062AA_SECOND_B =3D 0x04D */
> +#define DA9062AA_SECONDS_B_SHIFT	0
> +#define DA9062AA_SECONDS_B_MASK		(0xff << 0)
> +
> +/* DA9062AA_SECOND_C =3D 0x04E */
> +#define DA9062AA_SECONDS_C_SHIFT	0
> +#define DA9062AA_SECONDS_C_MASK		(0xff << 0)
> +
> +/* DA9062AA_SECOND_D =3D 0x04F */
> +#define DA9062AA_SECONDS_D_SHIFT	0
> +#define DA9062AA_SECONDS_D_MASK		(0xff << 0)
> +
> +/* DA9062AA_SEQ =3D 0x081 */
> +#define DA9062AA_SEQ_POINTER_SHIFT	0
> +#define DA9062AA_SEQ_POINTER_MASK	(0x0f << 0)
> +#define DA9062AA_NXT_SEQ_START_SHIFT	4
> +#define DA9062AA_NXT_SEQ_START_MASK	(0x0f << 4)
> +
> +/* DA9062AA_SEQ_TIMER =3D 0x082 */
> +#define DA9062AA_SEQ_TIME_SHIFT		0
> +#define DA9062AA_SEQ_TIME_MASK		(0x0f << 0)
> +#define DA9062AA_SEQ_DUMMY_SHIFT	4
> +#define DA9062AA_SEQ_DUMMY_MASK		(0x0f << 4)
> +
> +/* DA9062AA_ID_2_1 =3D 0x083 */
> +#define DA9062AA_LDO1_STEP_SHIFT	0
> +#define DA9062AA_LDO1_STEP_MASK		(0x0f << 0)
> +#define DA9062AA_LDO2_STEP_SHIFT	4
> +#define DA9062AA_LDO2_STEP_MASK		(0x0f << 4)
> +
> +/* DA9062AA_ID_4_3 =3D 0x084 */
> +#define DA9062AA_LDO3_STEP_SHIFT	0
> +#define DA9062AA_LDO3_STEP_MASK		(0x0f << 0)
> +#define DA9062AA_LDO4_STEP_SHIFT	4
> +#define DA9062AA_LDO4_STEP_MASK		(0x0f << 4)
> +
> +/* DA9062AA_ID_12_11 =3D 0x088 */
> +#define DA9062AA_PD_DIS_STEP_SHIFT	4
> +#define DA9062AA_PD_DIS_STEP_MASK	(0x0f << 4)
> +
> +/* DA9062AA_ID_14_13 =3D 0x089 */
> +#define DA9062AA_BUCK1_STEP_SHIFT	0
> +#define DA9062AA_BUCK1_STEP_MASK	(0x0f << 0)
> +#define DA9062AA_BUCK2_STEP_SHIFT	4
> +#define DA9062AA_BUCK2_STEP_MASK	(0x0f << 4)
> +
> +/* DA9062AA_ID_16_15 =3D 0x08A */
> +#define DA9062AA_BUCK4_STEP_SHIFT	0
> +#define DA9062AA_BUCK4_STEP_MASK	(0x0f << 0)
> +#define DA9062AA_BUCK3_STEP_SHIFT	4
> +#define DA9062AA_BUCK3_STEP_MASK	(0x0f << 4)
> +
> +/* DA9062AA_ID_22_21 =3D 0x08D */
> +#define DA9062AA_GP_RISE1_STEP_SHIFT	0
> +#define DA9062AA_GP_RISE1_STEP_MASK	(0x0f << 0)
> +#define DA9062AA_GP_FALL1_STEP_SHIFT	4
> +#define DA9062AA_GP_FALL1_STEP_MASK	(0x0f << 4)
> +
> +/* DA9062AA_ID_24_23 =3D 0x08E */
> +#define DA9062AA_GP_RISE2_STEP_SHIFT	0
> +#define DA9062AA_GP_RISE2_STEP_MASK	(0x0f << 0)
> +#define DA9062AA_GP_FALL2_STEP_SHIFT	4
> +#define DA9062AA_GP_FALL2_STEP_MASK	(0x0f << 4)
> +
> +/* DA9062AA_ID_26_25 =3D 0x08F */
> +#define DA9062AA_GP_RISE3_STEP_SHIFT	0
> +#define DA9062AA_GP_RISE3_STEP_MASK	(0x0f << 0)
> +#define DA9062AA_GP_FALL3_STEP_SHIFT	4
> +#define DA9062AA_GP_FALL3_STEP_MASK	(0x0f << 4)
> +
> +/* DA9062AA_ID_28_27 =3D 0x090 */
> +#define DA9062AA_GP_RISE4_STEP_SHIFT	0
> +#define DA9062AA_GP_RISE4_STEP_MASK	(0x0f << 0)
> +#define DA9062AA_GP_FALL4_STEP_SHIFT	4
> +#define DA9062AA_GP_FALL4_STEP_MASK	(0x0f << 4)
> +
> +/* DA9062AA_ID_30_29 =3D 0x091 */
> +#define DA9062AA_GP_RISE5_STEP_SHIFT	0
> +#define DA9062AA_GP_RISE5_STEP_MASK	(0x0f << 0)
> +#define DA9062AA_GP_FALL5_STEP_SHIFT	4
> +#define DA9062AA_GP_FALL5_STEP_MASK	(0x0f << 4)
> +
> +/* DA9062AA_ID_32_31 =3D 0x092 */
> +#define DA9062AA_WAIT_STEP_SHIFT	0
> +#define DA9062AA_WAIT_STEP_MASK		(0x0f << 0)
> +#define DA9062AA_EN32K_STEP_SHIFT	4
> +#define DA9062AA_EN32K_STEP_MASK	(0x0f << 4)
> +
> +/* DA9062AA_SEQ_A =3D 0x095 */
> +#define DA9062AA_SYSTEM_END_SHIFT	0
> +#define DA9062AA_SYSTEM_END_MASK	(0x0f << 0)
> +#define DA9062AA_POWER_END_SHIFT	4
> +#define DA9062AA_POWER_END_MASK		(0x0f << 4)
> +
> +/* DA9062AA_SEQ_B =3D 0x096 */
> +#define DA9062AA_MAX_COUNT_SHIFT	0
> +#define DA9062AA_MAX_COUNT_MASK		(0x0f << 0)
> +#define DA9062AA_PART_DOWN_SHIFT	4
> +#define DA9062AA_PART_DOWN_MASK		(0x0f << 4)
> +
> +/* DA9062AA_WAIT =3D 0x097 */
> +#define DA9062AA_WAIT_TIME_SHIFT	0
> +#define DA9062AA_WAIT_TIME_MASK		(0x0f << 0)
> +#define DA9062AA_WAIT_MODE_SHIFT	4
> +#define DA9062AA_WAIT_MODE_MASK		(0x01 << 4)
> +#define DA9062AA_TIME_OUT_SHIFT		5
> +#define DA9062AA_TIME_OUT_MASK		(0x01 << 5)
> +#define DA9062AA_WAIT_DIR_SHIFT		6
> +#define DA9062AA_WAIT_DIR_MASK		(0x03 << 6)
> +
> +/* DA9062AA_EN_32K =3D 0x098 */
> +#define DA9062AA_STABILISATION_TIME_SHIFT	0
> +#define DA9062AA_STABILISATION_TIME_MASK	(0x07 << 0)
> +#define DA9062AA_CRYSTAL_SHIFT			3
> +#define DA9062AA_CRYSTAL_MASK			(0x01 << 3)
> +#define DA9062AA_DELAY_MODE_SHIFT		4
> +#define DA9062AA_DELAY_MODE_MASK		(0x01 << 4)
> +#define DA9062AA_OUT_CLOCK_SHIFT		5
> +#define DA9062AA_OUT_CLOCK_MASK			(0x01 << 5)
> +#define DA9062AA_RTC_CLOCK_SHIFT		6
> +#define DA9062AA_RTC_CLOCK_MASK			(0x01 << 6)
> +#define DA9062AA_EN_32KOUT_SHIFT		7
> +#define DA9062AA_EN_32KOUT_MASK			(0x01 << 7)
> +
> +/* DA9062AA_RESET =3D 0x099 */
> +#define DA9062AA_RESET_TIMER_SHIFT	0
> +#define DA9062AA_RESET_TIMER_MASK	(0x3f << 0)
> +#define DA9062AA_RESET_EVENT_SHIFT	6
> +#define DA9062AA_RESET_EVENT_MASK	(0x03 << 6)
> +
> +/* DA9062AA_BUCK_ILIM_A =3D 0x09A */
> +#define DA9062AA_BUCK3_ILIM_SHIFT	0
> +#define DA9062AA_BUCK3_ILIM_MASK	(0x0f << 0)
> +
> +/* DA9062AA_BUCK_ILIM_B =3D 0x09B */
> +#define DA9062AA_BUCK4_ILIM_SHIFT	0
> +#define DA9062AA_BUCK4_ILIM_MASK	(0x0f << 0)
> +
> +/* DA9062AA_BUCK_ILIM_C =3D 0x09C */
> +#define DA9062AA_BUCK1_ILIM_SHIFT	0
> +#define DA9062AA_BUCK1_ILIM_MASK	(0x0f << 0)
> +#define DA9062AA_BUCK2_ILIM_SHIFT	4
> +#define DA9062AA_BUCK2_ILIM_MASK	(0x0f << 4)
> +
> +/* DA9062AA_BUCK2_CFG =3D 0x09D */
> +#define DA9062AA_BUCK2_PD_DIS_SHIFT	5
> +#define DA9062AA_BUCK2_PD_DIS_MASK	(0x01 << 5)
> +#define DA9062AA_BUCK2_MODE_SHIFT	6
> +#define DA9062AA_BUCK2_MODE_MASK	(0x03 << 6)
> +
> +/* DA9062AA_BUCK1_CFG =3D 0x09E */
> +#define DA9062AA_BUCK1_PD_DIS_SHIFT	5
> +#define DA9062AA_BUCK1_PD_DIS_MASK	(0x01 << 5)
> +#define DA9062AA_BUCK1_MODE_SHIFT	6
> +#define DA9062AA_BUCK1_MODE_MASK	(0x03 << 6)
> +
> +/* DA9062AA_BUCK4_CFG =3D 0x09F */
> +#define DA9062AA_BUCK4_VTTR_EN_SHIFT	3
> +#define DA9062AA_BUCK4_VTTR_EN_MASK	(0x01 << 3)
> +#define DA9062AA_BUCK4_VTT_EN_SHIFT	4
> +#define DA9062AA_BUCK4_VTT_EN_MASK	(0x01 << 4)
> +#define DA9062AA_BUCK4_PD_DIS_SHIFT	5
> +#define DA9062AA_BUCK4_PD_DIS_MASK	(0x01 << 5)
> +#define DA9062AA_BUCK4_MODE_SHIFT	6
> +#define DA9062AA_BUCK4_MODE_MASK	(0x03 << 6)
> +
> +/* DA9062AA_BUCK3_CFG =3D 0x0A0 */
> +#define DA9062AA_BUCK3_PD_DIS_SHIFT	5
> +#define DA9062AA_BUCK3_PD_DIS_MASK	(0x01 << 5)
> +#define DA9062AA_BUCK3_MODE_SHIFT	6
> +#define DA9062AA_BUCK3_MODE_MASK	(0x03 << 6)
> +
> +/* DA9062AA_VBUCK2_A =3D 0x0A3 */
> +#define DA9062AA_VBUCK2_A_SHIFT		0
> +#define DA9062AA_VBUCK2_A_MASK		(0x7f << 0)
> +#define DA9062AA_BUCK2_SL_A_SHIFT	7
> +#define DA9062AA_BUCK2_SL_A_MASK	(0x01 << 7)
> +
> +/* DA9062AA_VBUCK1_A =3D 0x0A4 */
> +#define DA9062AA_VBUCK1_A_SHIFT		0
> +#define DA9062AA_VBUCK1_A_MASK		(0x7f << 0)
> +#define DA9062AA_BUCK1_SL_A_SHIFT	7
> +#define DA9062AA_BUCK1_SL_A_MASK	(0x01 << 7)
> +
> +/* DA9062AA_VBUCK4_A =3D 0x0A5 */
> +#define DA9062AA_VBUCK4_A_SHIFT		0
> +#define DA9062AA_VBUCK4_A_MASK		(0x7f << 0)
> +#define DA9062AA_BUCK4_SL_A_SHIFT	7
> +#define DA9062AA_BUCK4_SL_A_MASK	(0x01 << 7)
> +
> +/* DA9062AA_VBUCK3_A =3D 0x0A7 */
> +#define DA9062AA_VBUCK3_A_SHIFT		0
> +#define DA9062AA_VBUCK3_A_MASK		(0x7f << 0)
> +#define DA9062AA_BUCK3_SL_A_SHIFT	7
> +#define DA9062AA_BUCK3_SL_A_MASK	(0x01 << 7)
> +
> +/* DA9062AA_VLDO1_A =3D 0x0A9 */
> +#define DA9062AA_VLDO1_A_SHIFT		0
> +#define DA9062AA_VLDO1_A_MASK		(0x3f << 0)
> +#define DA9062AA_LDO1_SL_A_SHIFT	7
> +#define DA9062AA_LDO1_SL_A_MASK		(0x01 << 7)
> +
> +/* DA9062AA_VLDO2_A =3D 0x0AA */
> +#define DA9062AA_VLDO2_A_SHIFT		0
> +#define DA9062AA_VLDO2_A_MASK		(0x3f << 0)
> +#define DA9062AA_LDO2_SL_A_SHIFT	7
> +#define DA9062AA_LDO2_SL_A_MASK		(0x01 << 7)
> +
> +/* DA9062AA_VLDO3_A =3D 0x0AB */
> +#define DA9062AA_VLDO3_A_SHIFT		0
> +#define DA9062AA_VLDO3_A_MASK		(0x3f << 0)
> +#define DA9062AA_LDO3_SL_A_SHIFT	7
> +#define DA9062AA_LDO3_SL_A_MASK		(0x01 << 7)
> +
> +/* DA9062AA_VLDO4_A =3D 0x0AC */
> +#define DA9062AA_VLDO4_A_SHIFT		0
> +#define DA9062AA_VLDO4_A_MASK		(0x3f << 0)
> +#define DA9062AA_LDO4_SL_A_SHIFT	7
> +#define DA9062AA_LDO4_SL_A_MASK		(0x01 << 7)
> +
> +/* DA9062AA_VBUCK2_B =3D 0x0B4 */
> +#define DA9062AA_VBUCK2_B_SHIFT		0
> +#define DA9062AA_VBUCK2_B_MASK		(0x7f << 0)
> +#define DA9062AA_BUCK2_SL_B_SHIFT	7
> +#define DA9062AA_BUCK2_SL_B_MASK	(0x01 << 7)
> +
> +/* DA9062AA_VBUCK1_B =3D 0x0B5 */
> +#define DA9062AA_VBUCK1_B_SHIFT		0
> +#define DA9062AA_VBUCK1_B_MASK		(0x7f << 0)
> +#define DA9062AA_BUCK1_SL_B_SHIFT	7
> +#define DA9062AA_BUCK1_SL_B_MASK	(0x01 << 7)
> +
> +/* DA9062AA_VBUCK4_B =3D 0x0B6 */
> +#define DA9062AA_VBUCK4_B_SHIFT		0
> +#define DA9062AA_VBUCK4_B_MASK		(0x7f << 0)
> +#define DA9062AA_BUCK4_SL_B_SHIFT	7
> +#define DA9062AA_BUCK4_SL_B_MASK	(0x01 << 7)
> +
> +/* DA9062AA_VBUCK3_B =3D 0x0B8 */
> +#define DA9062AA_VBUCK3_B_SHIFT		0
> +#define DA9062AA_VBUCK3_B_MASK		(0x7f << 0)
> +#define DA9062AA_BUCK3_SL_B_SHIFT	7
> +#define DA9062AA_BUCK3_SL_B_MASK	(0x01 << 7)
> +
> +/* DA9062AA_VLDO1_B =3D 0x0BA */
> +#define DA9062AA_VLDO1_B_SHIFT		0
> +#define DA9062AA_VLDO1_B_MASK		(0x3f << 0)
> +#define DA9062AA_LDO1_SL_B_SHIFT	7
> +#define DA9062AA_LDO1_SL_B_MASK		(0x01 << 7)
> +
> +/* DA9062AA_VLDO2_B =3D 0x0BB */
> +#define DA9062AA_VLDO2_B_SHIFT		0
> +#define DA9062AA_VLDO2_B_MASK		(0x3f << 0)
> +#define DA9062AA_LDO2_SL_B_SHIFT	7
> +#define DA9062AA_LDO2_SL_B_MASK		(0x01 << 7)
> +
> +/* DA9062AA_VLDO3_B =3D 0x0BC */
> +#define DA9062AA_VLDO3_B_SHIFT		0
> +#define DA9062AA_VLDO3_B_MASK		(0x3f << 0)
> +#define DA9062AA_LDO3_SL_B_SHIFT	7
> +#define DA9062AA_LDO3_SL_B_MASK		(0x01 << 7)
> +
> +/* DA9062AA_VLDO4_B =3D 0x0BD */
> +#define DA9062AA_VLDO4_B_SHIFT		0
> +#define DA9062AA_VLDO4_B_MASK		(0x3f << 0)
> +#define DA9062AA_LDO4_SL_B_SHIFT	7
> +#define DA9062AA_LDO4_SL_B_MASK		(0x01 << 7)
> +
> +/* DA9062AA_BBAT_CONT =3D 0x0C5 */
> +#define DA9062AA_BCHG_VSET_SHIFT	0
> +#define DA9062AA_BCHG_VSET_MASK		(0x0f << 0)
> +#define DA9062AA_BCHG_ISET_SHIFT	4
> +#define DA9062AA_BCHG_ISET_MASK		(0x0f << 4)
> +
> +/* DA9062AA_INTERFACE =3D 0x105 */
> +#define DA9062AA_IF_BASE_ADDR_SHIFT	4
> +#define DA9062AA_IF_BASE_ADDR_MASK	(0x0f << 4)
> +
> +/* DA9062AA_CONFIG_A =3D 0x106 */
> +#define DA9062AA_PM_I_V_SHIFT		0
> +#define DA9062AA_PM_I_V_MASK		(0x01 << 0)
> +#define DA9062AA_PM_O_TYPE_SHIFT	2
> +#define DA9062AA_PM_O_TYPE_MASK		(0x01 << 2)
> +#define DA9062AA_IRQ_TYPE_SHIFT		3
> +#define DA9062AA_IRQ_TYPE_MASK		(0x01 << 3)
> +#define DA9062AA_PM_IF_V_SHIFT		4
> +#define DA9062AA_PM_IF_V_MASK		(0x01 << 4)
> +#define DA9062AA_PM_IF_FMP_SHIFT	5
> +#define DA9062AA_PM_IF_FMP_MASK		(0x01 << 5)
> +#define DA9062AA_PM_IF_HSM_SHIFT	6
> +#define DA9062AA_PM_IF_HSM_MASK		(0x01 << 6)
> +
> +/* DA9062AA_CONFIG_B =3D 0x107 */
> +#define DA9062AA_VDD_FAULT_ADJ_SHIFT	0
> +#define DA9062AA_VDD_FAULT_ADJ_MASK	(0x0f << 0)
> +#define DA9062AA_VDD_HYST_ADJ_SHIFT	4
> +#define DA9062AA_VDD_HYST_ADJ_MASK	(0x07 << 4)
> +
> +/* DA9062AA_CONFIG_C =3D 0x108 */
> +#define DA9062AA_BUCK_ACTV_DISCHRG_SHIFT	2
> +#define DA9062AA_BUCK_ACTV_DISCHRG_MASK		(0x01 << 2)
> +#define DA9062AA_BUCK1_CLK_INV_SHIFT		3
> +#define DA9062AA_BUCK1_CLK_INV_MASK		(0x01 << 3)
> +#define DA9062AA_BUCK4_CLK_INV_SHIFT		4
> +#define DA9062AA_BUCK4_CLK_INV_MASK		(0x01 << 4)
> +#define DA9062AA_BUCK3_CLK_INV_SHIFT		6
> +#define DA9062AA_BUCK3_CLK_INV_MASK		(0x01 << 6)
> +
> +/* DA9062AA_CONFIG_D =3D 0x109 */
> +#define DA9062AA_GPI_V_SHIFT		0
> +#define DA9062AA_GPI_V_MASK		(0x01 << 0)
> +#define DA9062AA_NIRQ_MODE_SHIFT	1
> +#define DA9062AA_NIRQ_MODE_MASK		(0x01 << 1)
> +#define DA9062AA_SYSTEM_EN_RD_SHIFT	2
> +#define DA9062AA_SYSTEM_EN_RD_MASK	(0x01 << 2)
> +#define DA9062AA_FORCE_RESET_SHIFT	5
> +#define DA9062AA_FORCE_RESET_MASK	(0x01 << 5)
> +
> +/* DA9062AA_CONFIG_E =3D 0x10A */
> +#define DA9062AA_BUCK1_AUTO_SHIFT	0
> +#define DA9062AA_BUCK1_AUTO_MASK	(0x01 << 0)
> +#define DA9062AA_BUCK2_AUTO_SHIFT	1
> +#define DA9062AA_BUCK2_AUTO_MASK	(0x01 << 1)
> +#define DA9062AA_BUCK4_AUTO_SHIFT	2
> +#define DA9062AA_BUCK4_AUTO_MASK	(0x01 << 2)
> +#define DA9062AA_BUCK3_AUTO_SHIFT	4
> +#define DA9062AA_BUCK3_AUTO_MASK	(0x01 << 4)
> +
> +/* DA9062AA_CONFIG_G =3D 0x10C */
> +#define DA9062AA_LDO1_AUTO_SHIFT	0
> +#define DA9062AA_LDO1_AUTO_MASK		(0x01 << 0)
> +#define DA9062AA_LDO2_AUTO_SHIFT	1
> +#define DA9062AA_LDO2_AUTO_MASK		(0x01 << 1)
> +#define DA9062AA_LDO3_AUTO_SHIFT	2
> +#define DA9062AA_LDO3_AUTO_MASK		(0x01 << 2)
> +#define DA9062AA_LDO4_AUTO_SHIFT	3
> +#define DA9062AA_LDO4_AUTO_MASK		(0x01 << 3)
> +
> +/* DA9062AA_CONFIG_H =3D 0x10D */
> +#define DA9062AA_BUCK1_2_MERGE_SHIFT	3
> +#define DA9062AA_BUCK1_2_MERGE_MASK	(0x01 << 3)
> +#define DA9062AA_BUCK2_OD_SHIFT		5
> +#define DA9062AA_BUCK2_OD_MASK		(0x01 << 5)
> +#define DA9062AA_BUCK1_OD_SHIFT		6
> +#define DA9062AA_BUCK1_OD_MASK		(0x01 << 6)
> +
> +/* DA9062AA_CONFIG_I =3D 0x10E */
> +#define DA9062AA_NONKEY_PIN_SHIFT	0
> +#define DA9062AA_NONKEY_PIN_MASK	(0x03 << 0)
> +#define DA9062AA_nONKEY_SD_SHIFT	2
> +#define DA9062AA_nONKEY_SD_MASK		(0x01 << 2)
> +#define DA9062AA_WATCHDOG_SD_SHIFT	3
> +#define DA9062AA_WATCHDOG_SD_MASK	(0x01 << 3)
> +#define DA9062AA_KEY_SD_MODE_SHIFT	4
> +#define DA9062AA_KEY_SD_MODE_MASK	(0x01 << 4)
> +#define DA9062AA_HOST_SD_MODE_SHIFT	5
> +#define DA9062AA_HOST_SD_MODE_MASK	(0x01 << 5)
> +#define DA9062AA_INT_SD_MODE_SHIFT	6
> +#define DA9062AA_INT_SD_MODE_MASK	(0x01 << 6)
> +#define DA9062AA_LDO_SD_SHIFT		7
> +#define DA9062AA_LDO_SD_MASK		(0x01 << 7)
> +
> +/* DA9062AA_CONFIG_J =3D 0x10F */
> +#define DA9062AA_KEY_DELAY_SHIFT	0
> +#define DA9062AA_KEY_DELAY_MASK		(0x03 << 0)
> +#define DA9062AA_SHUT_DELAY_SHIFT	2
> +#define DA9062AA_SHUT_DELAY_MASK	(0x03 << 2)
> +#define DA9062AA_RESET_DURATION_SHIFT	4
> +#define DA9062AA_RESET_DURATION_MASK	(0x03 << 4)
> +#define DA9062AA_TWOWIRE_TO_SHIFT	6
> +#define DA9062AA_TWOWIRE_TO_MASK	(0x01 << 6)
> +#define DA9062AA_IF_RESET_SHIFT		7
> +#define DA9062AA_IF_RESET_MASK		(0x01 << 7)
> +
> +/* DA9062AA_CONFIG_K =3D 0x110 */
> +#define DA9062AA_GPIO0_PUPD_SHIFT	0
> +#define DA9062AA_GPIO0_PUPD_MASK	(0x01 << 0)
> +#define DA9062AA_GPIO1_PUPD_SHIFT	1
> +#define DA9062AA_GPIO1_PUPD_MASK	(0x01 << 1)
> +#define DA9062AA_GPIO2_PUPD_SHIFT	2
> +#define DA9062AA_GPIO2_PUPD_MASK	(0x01 << 2)
> +#define DA9062AA_GPIO3_PUPD_SHIFT	3
> +#define DA9062AA_GPIO3_PUPD_MASK	(0x01 << 3)
> +#define DA9062AA_GPIO4_PUPD_SHIFT	4
> +#define DA9062AA_GPIO4_PUPD_MASK	(0x01 << 4)
> +
> +/* DA9062AA_CONFIG_M =3D 0x112 */
> +#define DA9062AA_NSHUTDOWN_PU_SHIFT	1
> +#define DA9062AA_NSHUTDOWN_PU_MASK	(0x01 << 1)
> +#define DA9062AA_WDG_MODE_SHIFT		3
> +#define DA9062AA_WDG_MODE_MASK		(0x01 << 3)
> +#define DA9062AA_OSC_FRQ_SHIFT		4
> +#define DA9062AA_OSC_FRQ_MASK		(0x0f << 4)
> +
> +/* DA9062AA_TRIM_CLDR =3D 0x120 */
> +#define DA9062AA_TRIM_CLDR_SHIFT	0
> +#define DA9062AA_TRIM_CLDR_MASK		(0xff << 0)
> +
> +/* DA9062AA_GP_ID_0 =3D 0x121 */
> +#define DA9062AA_GP_0_SHIFT		0
> +#define DA9062AA_GP_0_MASK		(0xff << 0)
> +
> +/* DA9062AA_GP_ID_1 =3D 0x122 */
> +#define DA9062AA_GP_1_SHIFT		0
> +#define DA9062AA_GP_1_MASK		(0xff << 0)
> +
> +/* DA9062AA_GP_ID_2 =3D 0x123 */
> +#define DA9062AA_GP_2_SHIFT		0
> +#define DA9062AA_GP_2_MASK		(0xff << 0)
> +
> +/* DA9062AA_GP_ID_3 =3D 0x124 */
> +#define DA9062AA_GP_3_SHIFT		0
> +#define DA9062AA_GP_3_MASK		(0xff << 0)
> +
> +/* DA9062AA_GP_ID_4 =3D 0x125 */
> +#define DA9062AA_GP_4_SHIFT		0
> +#define DA9062AA_GP_4_MASK		(0xff << 0)
> +
> +/* DA9062AA_GP_ID_5 =3D 0x126 */
> +#define DA9062AA_GP_5_SHIFT		0
> +#define DA9062AA_GP_5_MASK		(0xff << 0)
> +
> +/* DA9062AA_GP_ID_6 =3D 0x127 */
> +#define DA9062AA_GP_6_SHIFT		0
> +#define DA9062AA_GP_6_MASK		(0xff << 0)
> +
> +/* DA9062AA_GP_ID_7 =3D 0x128 */
> +#define DA9062AA_GP_7_SHIFT		0
> +#define DA9062AA_GP_7_MASK		(0xff << 0)
> +
> +/* DA9062AA_GP_ID_8 =3D 0x129 */
> +#define DA9062AA_GP_8_SHIFT		0
> +#define DA9062AA_GP_8_MASK		(0xff << 0)
> +
> +/* DA9062AA_GP_ID_9 =3D 0x12A */
> +#define DA9062AA_GP_9_SHIFT		0
> +#define DA9062AA_GP_9_MASK		(0xff << 0)
> +
> +/* DA9062AA_GP_ID_10 =3D 0x12B */
> +#define DA9062AA_GP_10_SHIFT		0
> +#define DA9062AA_GP_10_MASK		(0xff << 0)
> +
> +/* DA9062AA_GP_ID_11 =3D 0x12C */
> +#define DA9062AA_GP_11_SHIFT		0
> +#define DA9062AA_GP_11_MASK		(0xff << 0)
> +
> +/* DA9062AA_GP_ID_12 =3D 0x12D */
> +#define DA9062AA_GP_12_SHIFT		0
> +#define DA9062AA_GP_12_MASK		(0xff << 0)
> +
> +/* DA9062AA_GP_ID_13 =3D 0x12E */
> +#define DA9062AA_GP_13_SHIFT		0
> +#define DA9062AA_GP_13_MASK		(0xff << 0)
> +
> +/* DA9062AA_GP_ID_14 =3D 0x12F */
> +#define DA9062AA_GP_14_SHIFT		0
> +#define DA9062AA_GP_14_MASK		(0xff << 0)
> +
> +/* DA9062AA_GP_ID_15 =3D 0x130 */
> +#define DA9062AA_GP_15_SHIFT		0
> +#define DA9062AA_GP_15_MASK		(0xff << 0)
> +
> +/* DA9062AA_GP_ID_16 =3D 0x131 */
> +#define DA9062AA_GP_16_SHIFT		0
> +#define DA9062AA_GP_16_MASK		(0xff << 0)
> +
> +/* DA9062AA_GP_ID_17 =3D 0x132 */
> +#define DA9062AA_GP_17_SHIFT		0
> +#define DA9062AA_GP_17_MASK		(0xff << 0)
> +
> +/* DA9062AA_GP_ID_18 =3D 0x133 */
> +#define DA9062AA_GP_18_SHIFT		0
> +#define DA9062AA_GP_18_MASK		(0xff << 0)
> +
> +/* DA9062AA_GP_ID_19 =3D 0x134 */
> +#define DA9062AA_GP_19_SHIFT		0
> +#define DA9062AA_GP_19_MASK		(0xff << 0)
> +
> +/* DA9062AA_DEVICE_ID =3D 0x181 */
> +#define DA9062AA_DEV_ID_SHIFT		0
> +#define DA9062AA_DEV_ID_MASK		(0xff << 0)
> +
> +/* DA9062AA_VARIANT_ID =3D 0x182 */
> +#define DA9062AA_VRC_SHIFT		0
> +#define DA9062AA_VRC_MASK		(0x0f << 0)
> +#define DA9062AA_MRC_SHIFT		4
> +#define DA9062AA_MRC_MASK		(0x0f << 4)
> +
> +/* DA9062AA_CUSTOMER_ID =3D 0x183 */
> +#define DA9062AA_CUST_ID_SHIFT		0
> +#define DA9062AA_CUST_ID_MASK		(0xff << 0)
> +
> +/* DA9062AA_CONFIG_ID =3D 0x184 */
> +#define DA9062AA_CONFIG_REV_SHIFT	0
> +#define DA9062AA_CONFIG_REV_MASK	(0xff << 0)
> +
> +#endif /* __DA9062_H__ */

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
