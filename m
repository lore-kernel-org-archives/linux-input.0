From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: Add support for MMA7455L/MMA7456L 3-Axis
 Accelerometer
Date: Tue, 26 Nov 2013 11:16:19 -0800
Message-ID: <20131126191618.GC22242@core.coreip.homeip.net>
References: <1385135615-8771-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:37760 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751539Ab3KZTQX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Nov 2013 14:16:23 -0500
Content-Disposition: inline
In-Reply-To: <1385135615-8771-1-git-send-email-shc_work@mail.ru>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Grant Likely <grant.likely@linaro.org>

Hi Alexander,

On Fri, Nov 22, 2013 at 07:53:35PM +0400, Alexander Shiyan wrote:
> This patch adds support for Freescale MMA7455L/MMA7456L 3-Axis
> Accelerometer connected to I2C bus. Driver can be loaded ether
> with or without DT support. The basic parameters of the driver
> can be changed through sysfs.

The driver looks sane but I am hesitant with the sysfs interface. For a
while I asked accelerometer guys to standardize on sysfs attributes
applicable to all input-related 3-axis accelerometers, but I have not
seen a concrete proposal thus far.

If you remove sysfs portions I can merge it as pure input driver now.

> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  .../devicetree/bindings/input/fsl-mma745xl.txt     |  16 +
>  drivers/input/misc/Kconfig                         |   8 +
>  drivers/input/misc/Makefile                        |   1 +
>  drivers/input/misc/mma745xl.c                      | 490 +++++++++++++++++++++
>  4 files changed, 515 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/fsl-mma745xl.txt
>  create mode 100644 drivers/input/misc/mma745xl.c
> 
> diff --git a/Documentation/devicetree/bindings/input/fsl-mma745xl.txt b/Documentation/devicetree/bindings/input/fsl-mma745xl.txt
> new file mode 100644
> index 0000000..68feeb7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/fsl-mma745xl.txt
> @@ -0,0 +1,16 @@
> +* Freescale MMA7455L/MMA7456L Three Axis Accelerometer
> +
> +Required properties:
> +- compatible: Should contain "fsl,mma7455l".
> +- reg: The I2C address of device.
> +- interrupt-parent: Defines the parent interrupt controller.
> +- interrupts: Should contain the IRQ specifiers for INT1 and INT2 pins.
> +
> +Example:
> +	accelerometer: mma7455l@1d {
> +		compatible = "fsl,mma7455l";
> +		reg = <0x1d>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <7 GPIO_ACTIVE_HIGH>,
> +			     <6 GPIO_ACTIVE_HIGH>;
> +	};
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index 5f4967d..ecd3a50 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -176,6 +176,14 @@ config INPUT_MC13783_PWRBUTTON
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called mc13783-pwrbutton.
>  
> +config INPUT_MMA745XL
> +	tristate "MMA745xL - Freescale's 3-Axis, Digital Acceleration Sensor"
> +	depends on I2C

Since driver will not bid without OF data don't you want to add 'depends
on OF' here as well?

> +	select REGMAP_I2C

I think you need more selects here as I am pretty sure you need regmap
core.

> +	help
> +	  Say Y here if you want to support Freescale's MMA7455L/MMA7456L
> +	  Three Axis Accelerometer through I2C interface.
> +

	  To compile this driver as a module...

>  config INPUT_MMA8450
>  	tristate "MMA8450 - Freescale's 3-Axis, 8/12-bit Digital Accelerometer"
>  	depends on I2C
> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> index 0ebfb6d..10b2c12 100644
> --- a/drivers/input/misc/Makefile
> +++ b/drivers/input/misc/Makefile
> @@ -37,6 +37,7 @@ obj-$(CONFIG_INPUT_M68K_BEEP)		+= m68kspkr.o
>  obj-$(CONFIG_INPUT_MAX8925_ONKEY)	+= max8925_onkey.o
>  obj-$(CONFIG_INPUT_MAX8997_HAPTIC)	+= max8997_haptic.o
>  obj-$(CONFIG_INPUT_MC13783_PWRBUTTON)	+= mc13783-pwrbutton.o
> +obj-$(CONFIG_INPUT_MMA745XL)		+= mma745xl.o
>  obj-$(CONFIG_INPUT_MMA8450)		+= mma8450.o
>  obj-$(CONFIG_INPUT_MPU3050)		+= mpu3050.o
>  obj-$(CONFIG_INPUT_PCAP)		+= pcap_keys.o
> diff --git a/drivers/input/misc/mma745xl.c b/drivers/input/misc/mma745xl.c
> new file mode 100644
> index 0000000..4e4e847
> --- /dev/null
> +++ b/drivers/input/misc/mma745xl.c
> @@ -0,0 +1,490 @@
> +/*
> + *  Driver for Freescale's 3-Axis Acceleration Sensor MMA7455L/MMA7456L
> + *
> + *  Copyright (C) 2013 Alexander Shiyan <shc_work@mail.ru>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of_irq.h>
> +#include <linux/regmap.h>
> +#include <linux/sysfs.h>
> +
> +#define MMA745XL_REG_XOUTL	0x00
> +#define MMA745XL_REG_XOUTH	0x01
> +#define MMA745XL_REG_YOUTL	0x02
> +#define MMA745XL_REG_YOUTH	0x03
> +#define MMA745XL_REG_ZOUTL	0x04
> +#define MMA745XL_REG_ZOUTH	0x05
> +#define MMA745XL_REG_XOUT8	0x06
> +#define MMA745XL_REG_YOUT8	0x07
> +#define MMA745XL_REG_ZOUT8	0x08
> +#define MMA745XL_REG_STATUS	0x09
> +# define STATUS_DRDY		(1 << 0)
> +# define STATUS_DOVR		(1 << 1)
> +# define STATUS_PERR		(1 << 2)
> +#define MMA745XL_REG_DETSRC	0x0a
> +# define DETSRC_PDZ		(1 << 2)
> +# define DETSRC_PDY		(1 << 3)
> +# define DETSRC_PDX		(1 << 4)
> +# define DETSRC_LDZ		(1 << 5)
> +# define DETSRC_LDY		(1 << 6)
> +# define DETSRC_LDX		(1 << 7)
> +#define MMA745XL_REG_TOUT	0x0b
> +#define MMA745XL_REG_I2CAD	0x0d
> +#define MMA745XL_REG_USRINF	0x0e
> +#define MMA745XL_REG_WHOAMI	0x0f
> +# define WHOAMI_MMA745XL	0x55
> +#define MMA745XL_REG_XOFFL	0x10
> +#define MMA745XL_REG_XOFFH	0x11
> +#define MMA745XL_REG_YOFFL	0x12
> +#define MMA745XL_REG_YOFFH	0x13
> +#define MMA745XL_REG_ZOFFL	0x14
> +#define MMA745XL_REG_ZOFFH	0x15
> +#define MMA745XL_REG_MCTL	0x16
> +# define MCTL_MODE_STANDBY	(0 << 0)
> +# define MCTL_MODE_MEASUREMENT	(1 << 0)
> +# define MCTL_MODE_LEVELDET	(2 << 0)
> +# define MCTL_MODE_PULSEDET	(3 << 0)
> +# define MCTL_MODE_MASK		(3 << 0)
> +# define MCTL_GLVL_8		(0 << 2)
> +# define MCTL_GLVL_2		(1 << 2)
> +# define MCTL_GLVL_4		(2 << 2)
> +# define MCTL_GLVL_MASK		(3 << 2)
> +# define MCTL_STON		(1 << 4)
> +# define MCTL_SPI3W		(1 << 5)
> +# define MCTL_DRPD		(1 << 6)
> +#define MMA745XL_REG_INTRST	0x17
> +# define INTRST_CLR_INT1	(1 << 0)
> +# define INTRST_CLR_INT2	(1 << 1)
> +#define MMA745XL_REG_CTL1	0x18
> +# define CTL1_DFBW		(1 << 7)
> +#define MMA745XL_REG_CTL2	0x19
> +#define MMA745XL_REG_LDTH	0x1a
> +#define MMA745XL_REG_PDTH	0x1b
> +#define MMA745XL_REG_PW		0x1c
> +#define MMA745XL_REG_LT		0x1d
> +#define MMA745XL_REG_TW		0x1e
> +
> +#define MMA745XL_MODE_DEF	MCTL_MODE_LEVELDET
> +#define MMA745XL_MEASURE_TIME	20
> +#define MMA745XL_THRESHOLD_DEF	24
> +#define MMA745XL_PULSEW_DEF	6
> +
> +#define MMA745XL_X		(1 << 0)
> +#define MMA745XL_Y		(1 << 1)
> +#define MMA745XL_Z		(1 << 2)
> +
> +struct mma745xl {
> +	struct regmap		*regmap;
> +	struct regmap_config	regcfg;
> +	unsigned int		mode;
> +};
> +
> +static int mma745xl_measure_axis(struct mma745xl *priv, unsigned int reg,
> +				 int *val)
> +{
> +	unsigned int tmpl = 0, tmph = 0;
> +	int ret;
> +
> +	ret = regmap_read(priv->regmap, reg, &tmpl);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(priv->regmap, reg + 1, &tmph);
> +	if (!ret) {
> +		*val = ((tmph & 0x03) << 8) | (tmpl & 0xff);
> +		/* Make signed variable */
> +		if (*val & 0x200)
> +			*val -= 0x400;
> +	}
> +
> +	return ret;
> +}
> +
> +static void mma745xl_measure(struct input_dev *input, unsigned int mask)
> +{
> +	struct mma745xl *priv = input_get_drvdata(input);
> +	int x, y, z;
> +
> +	if (mask & MMA745XL_X)
> +		if (!mma745xl_measure_axis(priv, MMA745XL_REG_XOUTL, &x))
> +			input_report_abs(input, ABS_X, x);
> +	if (mask & MMA745XL_Y)
> +		if (!mma745xl_measure_axis(priv, MMA745XL_REG_YOUTL, &y))
> +			input_report_abs(input, ABS_Y, y);
> +	if (mask & MMA745XL_Z)
> +		if (!mma745xl_measure_axis(priv, MMA745XL_REG_ZOUTL, &z))
> +			input_report_abs(input, ABS_Z, z);
> +
> +	input_sync(input);
> +}
> +
> +static irqreturn_t mma745xl_interrupt(int irq, void *dev_id)
> +{
> +	struct input_dev *input = dev_id;
> +	struct mma745xl *priv = input_get_drvdata(input);
> +	unsigned int val;
> +
> +	if (!regmap_read(priv->regmap, MMA745XL_REG_DETSRC, &val)) {
> +		unsigned int mask;
> +
> +		mask = (val & (DETSRC_LDX | DETSRC_PDX)) ? MMA745XL_X : 0;
> +		mask |= (val & (DETSRC_LDY | DETSRC_PDY)) ? MMA745XL_Y : 0;
> +		mask |= (val & (DETSRC_LDZ | DETSRC_PDZ)) ? MMA745XL_Z : 0;
> +		mma745xl_measure(input, mask);
> +	}
> +
> +	/* Clear interrupt flags */
> +	regmap_write(priv->regmap, MMA745XL_REG_INTRST,
> +		     INTRST_CLR_INT1 | INTRST_CLR_INT2);
> +	/* Enable pins to trigger */
> +	regmap_write(priv->regmap, MMA745XL_REG_INTRST, 0);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int mma745xl_open(struct input_dev *input)
> +{
> +	struct mma745xl *priv = input_get_drvdata(input);
> +	unsigned long tmp;
> +	unsigned int val;
> +	int ret;
> +
> +	/* Get initial values */
> +	ret = regmap_update_bits(priv->regmap, MMA745XL_REG_MCTL,
> +				 MCTL_MODE_MASK, MCTL_MODE_MEASUREMENT);
> +	if (ret)
> +		return ret;
> +
> +	tmp = jiffies + msecs_to_jiffies(MMA745XL_MEASURE_TIME);
> +	for (;;) {
> +		ret = regmap_read(priv->regmap, MMA745XL_REG_STATUS, &val);
> +		if (ret)
> +			return ret;
> +		if (val == STATUS_DRDY)
> +			break;
> +		if (val & (STATUS_DOVR | STATUS_PERR)) {
> +			/* Clear status */
> +			ret = regmap_read(priv->regmap,
> +					  MMA745XL_REG_XOUTL, &val);
> +			if (ret)
> +				return ret;
> +			/* Restart measuring */
> +			tmp = jiffies + msecs_to_jiffies(MMA745XL_MEASURE_TIME);
> +		}
> +		if (time_after(jiffies, tmp)) {
> +			dev_err(&input->dev, "Measure timeout\n");
> +			return -ETIMEDOUT;
> +		}
> +	}
> +
> +	mma745xl_measure(input, MMA745XL_X | MMA745XL_Y | MMA745XL_Z);
> +
> +	/* Go to desired mode */
> +	return regmap_update_bits(priv->regmap, MMA745XL_REG_MCTL,
> +				  MCTL_MODE_MASK, priv->mode);
> +}
> +
> +static void mma745xl_close(struct input_dev *input)
> +{
> +	struct mma745xl *priv = input_get_drvdata(input);
> +
> +	regmap_update_bits(priv->regmap, MMA745XL_REG_MCTL, MCTL_MODE_MASK, 0);
> +}
> +
> +static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
> +			 char *buf)
> +{
> +	struct input_dev *input = dev_get_drvdata(dev);
> +	struct mma745xl *priv = input_get_drvdata(input);
> +
> +	switch (priv->mode) {
> +	case MCTL_MODE_LEVELDET:
> +		return sprintf(buf, "level\n");
> +	case MCTL_MODE_PULSEDET:
> +		return sprintf(buf, "pulse\n");
> +	default:
> +		break;
> +	}
> +
> +	return sprintf(buf, "unknown\n");
> +}
> +
> +static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
> +			  const char *buf, size_t count)
> +{
> +	struct input_dev *input = dev_get_drvdata(dev);
> +	struct mma745xl *priv = input_get_drvdata(input);
> +
> +	if (!strncmp(buf, "level", count))
> +		priv->mode = MCTL_MODE_LEVELDET;
> +	else if (!strncmp(buf, "pulse", count))
> +		priv->mode = MCTL_MODE_PULSEDET;
> +	else
> +		return -EINVAL;
> +
> +	return count;
> +}
> +
> +static ssize_t level_show(struct device *dev, struct device_attribute *attr,
> +			  char *buf)
> +{
> +	struct input_dev *input = dev_get_drvdata(dev);
> +	struct mma745xl *priv = input_get_drvdata(input);
> +	unsigned int val;
> +	int ret;
> +
> +	ret = regmap_read(priv->regmap, MMA745XL_REG_MCTL, &val);
> +	if (ret)
> +		return ret;
> +
> +	switch (val & MCTL_GLVL_MASK) {
> +	case MCTL_GLVL_2:
> +		return sprintf(buf, "2\n");
> +	case MCTL_GLVL_4:
> +		return sprintf(buf, "4\n");
> +	case MCTL_GLVL_8:
> +		return sprintf(buf, "8\n");
> +	default:
> +		break;
> +	}
> +
> +	return sprintf(buf, "unknown\n");
> +}
> +
> +static ssize_t level_store(struct device *dev, struct device_attribute *attr,
> +			   const char *buf, size_t count)
> +{
> +	struct input_dev *input = dev_get_drvdata(dev);
> +	struct mma745xl *priv = input_get_drvdata(input);
> +	unsigned long tmp;
> +	unsigned int val;
> +	int ret;
> +
> +	ret = kstrtoul(buf, 10, &tmp);
> +	if (ret)
> +		return ret;
> +
> +	switch (tmp) {
> +	case 2:
> +		val = MCTL_GLVL_2;
> +		break;
> +	case 4:
> +		val = MCTL_GLVL_4;
> +		break;
> +	case 8:
> +		val = MCTL_GLVL_8;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = regmap_update_bits(priv->regmap, MMA745XL_REG_MCTL,
> +				 MCTL_GLVL_MASK, val);
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +
> +static ssize_t threshold_show(struct device *dev, struct device_attribute *attr,
> +			      char *buf)
> +{
> +	struct input_dev *input = dev_get_drvdata(dev);
> +	struct mma745xl *priv = input_get_drvdata(input);
> +	unsigned int val;
> +	int ret;
> +
> +	ret = regmap_read(priv->regmap, MMA745XL_REG_LDTH, &val);
> +	if (ret)
> +		return ret;
> +
> +	return sprintf(buf, "%d\n", val & 0x7f);
> +}
> +
> +static ssize_t threshold_store(struct device *dev,
> +			       struct device_attribute *attr,
> +			       const char *buf, size_t count)
> +{
> +	struct input_dev *input = dev_get_drvdata(dev);
> +	struct mma745xl *priv = input_get_drvdata(input);
> +	unsigned long tmp;
> +	int ret;
> +
> +	ret = kstrtoul(buf, 10, &tmp);
> +	if (ret)
> +		return ret;
> +	if (tmp > 0x7f)
> +		return -ERANGE;
> +
> +	ret = regmap_write(priv->regmap, MMA745XL_REG_LDTH, tmp);
> +	if (ret)
> +		return ret;
> +	ret = regmap_write(priv->regmap, MMA745XL_REG_PDTH, tmp);
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR_RW(mode);
> +static DEVICE_ATTR_RW(level);
> +static DEVICE_ATTR_RW(threshold);
> +
> +static struct attribute *mma745xl_sysfs_attrs[] = {
> +	&dev_attr_mode.attr,
> +	&dev_attr_level.attr,
> +	&dev_attr_threshold.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group mma745xl_sysfs_group = {
> +	.attrs	= mma745xl_sysfs_attrs,
> +};
> +
> +static int mma745xl_probe(struct i2c_client *client,
> +			  const struct i2c_device_id *id)
> +{
> +	struct input_dev *input;
> +	unsigned int i, irq, val = 0;
> +	struct mma745xl *priv;
> +	int ret;
> +
> +	if (!client->dev.of_node)
> +		return -ENOTSUPP;
> +
> +	priv = devm_kzalloc(&client->dev, sizeof(*priv), GFP_KERNEL);
> +	input = devm_input_allocate_device(&client->dev);
> +	if (!priv || !input)
> +		return -ENOMEM;
> +
> +	priv->regcfg.reg_bits		= 8;
> +	priv->regcfg.val_bits		= 8;
> +	priv->regcfg.cache_type		= REGCACHE_NONE;
> +	priv->regcfg.max_register	= MMA745XL_REG_TW;
> +	priv->regmap = devm_regmap_init_i2c(client, &priv->regcfg);
> +	if (IS_ERR(priv->regmap))
> +		return PTR_ERR(priv->regmap);
> +
> +	/* Check functionality */
> +	ret = regmap_read(priv->regmap, MMA745XL_REG_WHOAMI, &val);

regmap_read() returns errors or 0, so can we please call this variable
"err" or "error"?

> +	if (ret || (val != WHOAMI_MMA745XL)) {
> +		dev_err(&client->dev, "Probe failed (ID=0x%02x)\n", val);
> +		return ret ? : -ENODEV;
> +	}
> +
> +	input->name		= client->name;
> +	input->id.bustype	= BUS_I2C;
> +	input->id.vendor	= 0x0001;
> +	input->id.product	= 0x0001;
> +	input->id.version	= 0x0100;
> +	input->open		= mma745xl_open;
> +	input->close		= mma745xl_close;
> +
> +	for (i = ABS_X; i <= ABS_Z; i++) {
> +		input_set_capability(input, EV_ABS, i);
> +		input_set_abs_params(input, i, -512, 511, 0, 0);
> +	}
> +
> +	input_set_drvdata(input, priv);
> +	dev_set_drvdata(&client->dev, input);

	i2c_set_clientdata()

> +
> +	/* Put into standby mode, Data ready status not routed to INT1 */
> +	ret = regmap_write(priv->regmap, MMA745XL_REG_MCTL, MCTL_DRPD);
> +	if (ret)
> +		return ret;
> +	/* Set bandwidth to 125 kHz */
> +	ret = regmap_write(priv->regmap, MMA745XL_REG_CTL1, CTL1_DFBW);
> +	if (ret)
> +		return ret;
> +	/* Set detecting condition to "OR" */
> +	ret = regmap_write(priv->regmap, MMA745XL_REG_CTL2, 0);
> +	if (ret)
> +		return ret;
> +	/* Set level detection threshold limit */
> +	ret = regmap_write(priv->regmap, MMA745XL_REG_LDTH,
> +			   MMA745XL_THRESHOLD_DEF);
> +	if (ret)
> +		return ret;
> +	/* Set pulse detection threshold limit */
> +	ret = regmap_write(priv->regmap, MMA745XL_REG_PDTH,
> +			   MMA745XL_THRESHOLD_DEF);
> +	if (ret)
> +		return ret;
> +	/* Set pulse duration value */
> +	ret = regmap_write(priv->regmap, MMA745XL_REG_PW,
> +			   MMA745XL_PULSEW_DEF);
> +	if (ret)
> +		return ret;
> +
> +	priv->mode = MMA745XL_MODE_DEF;
> +
> +	irq = irq_of_parse_and_map(client->dev.of_node, 0);
> +	if (!irq)
> +		return -EINVAL;
> +	ret = devm_request_threaded_irq(&client->dev, irq, NULL,
> +					mma745xl_interrupt, IRQF_ONESHOT,
> +					dev_name(&client->dev), input);
> +	if (ret)
> +		return ret;
> +
> +	irq = irq_of_parse_and_map(client->dev.of_node, 1);
> +	if (!irq)
> +		return -EINVAL;
> +	ret = devm_request_threaded_irq(&client->dev, irq, NULL,
> +					mma745xl_interrupt, IRQF_ONESHOT,
> +					dev_name(&client->dev), input);
> +	if (ret)
> +		return ret;
> +
> +	ret = input_register_device(input);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_create_group(&client->dev.kobj, &mma745xl_sysfs_group);
> +}
> +
> +static int mma745xl_remove(struct i2c_client *client)
> +{
> +	sysfs_remove_group(&client->dev.kobj, &mma745xl_sysfs_group);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id __maybe_unused mma745xl_dt_ids[] = {
> +	{ .compatible = "fsl,mma7455l", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, mma745xl_dt_ids);
> +
> +static const struct i2c_device_id mma745xl_ids[] = {
> +	{ .name = "mma7455l", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, mma745xl_ids);
> +
> +static struct i2c_driver mma745xl_driver = {
> +	.driver		= {
> +		.name		= "mma745xl",
> +		.owner		= THIS_MODULE,
> +		.of_match_table	= of_match_ptr(mma745xl_dt_ids),
> +	},
> +	.id_table	= mma745xl_ids,
> +	.probe		= mma745xl_probe,
> +	.remove		= mma745xl_remove,
> +};
> +module_i2c_driver(mma745xl_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Alexander Shiyan <shc_work@mail.ru>");
> +MODULE_DESCRIPTION("MMA745xL 3-Axis Acceleration Sensor");
> -- 
> 1.8.3.2
> 

Thanks.

-- 
Dmitry
