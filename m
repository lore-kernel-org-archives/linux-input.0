From: "Tirdea, Irina" <irina.tirdea@intel.com>
Subject: RE: [PATCH v3] Add generic driver for Silead tochscreens
Date: Fri, 18 Sep 2015 14:08:00 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F2F0D8B05@irsmsx105.ger.corp.intel.com>
References: <1440538347-24056-1-git-send-email-robert.dolca@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:23825 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752518AbbIROIO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Sep 2015 10:08:14 -0400
In-Reply-To: <1440538347-24056-1-git-send-email-robert.dolca@intel.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Gregor Riepl <onitake@gmail.com>, "Dolca, Robert" <robert.dolca@intel.com>



> -----Original Message-----
> From: linux-input-owner@vger.kernel.org [mailto:linux-input-owner@vger.kernel.org] On Behalf Of Robert Dolca
> Sent: 26 August, 2015 0:32
> To: linux-input@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; Dmitry Torokhov; Henrik Rydberg; Gregor Riepl; Dolca, Robert
> Subject: [PATCH v3] Add generic driver for Silead tochscreens
> 
> This driver adds support for Silead touchscreens. It has been tested
> with GSL1680 and GSL3680 touch panels.
> 
> It supports ACPI and device tree enumeration. Screen resolution,
> the maximum number of fingers supported and firmware name are
> configurable using ACPI/DT properties.
> 
> If the device properties are not present it falls back to using defaults:
>  - x 4095
>  - y 4095
>  - max fingers 10
>  - firmware name [HID/name].fw
> 
> If there is no named GPIO for power it falls back to using an indexed GPIO
> and it requests the GPIO pin with index 1. If there isn't one it disables
> PM support.
> 
> All the hardware variants tested report finger id 0 for all fingers so
> the finger tracking is done using the input subsystem's slot assignment.
> 
> Signed-off-by: Robert Dolca <robert.dolca@intel.com>

Hi Robert,

The code looks good, just a couple of comments below.

> ---
> Changes since v2
> - removed device properties requirements
>         - max x and y default to 4095
>         - max fingers default to 10
>         - firmware name uses the HID / device name
>         - power named GPIO optional with fallback to indexed GPIO
>           (without it there is no pm support in the driver)
> - finger tracking in the kernel using slot assignment
> - add device property for x/y inverting and xy swaping
> 
> Changes since v1
> - changed device tree properties names
> - removed cast for `void *id`
> - removed ifdef from suspend and resume and use __maybe_unused
> - remove ifdef from ACPI_PTR
> - renamed ret to error
> - removed input_set_capability for EV_ABS
> - fixed endianess issues
> - added mask for y in order to use only 12 bits
> - using the 4 MSb for touch ID instead of LSb (bug)
> - using the 4 LSB for X instead of MSb (bug)
> 
> 
> 
>  drivers/input/touchscreen/Kconfig  |  12 +
>  drivers/input/touchscreen/Makefile |   1 +
>  drivers/input/touchscreen/silead.c | 635 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 648 insertions(+)
>  create mode 100644 drivers/input/touchscreen/silead.c
> 
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 80f6386..05fda4a 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -1027,4 +1027,16 @@ config TOUCHSCREEN_ZFORCE
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called zforce_ts.
> 
> +config TOUCHSCREEN_SILEAD
> +	tristate "Silead I2C touchscreen"
> +	depends on I2C
> +	help
> +	  Say Y here if you have the Silead touchscreen connected to
> +	  your system.
> +
> +	  If unsure, say N.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called silead.
> +
>  endif
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> index 44deea7..2c6beaa 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -84,3 +84,4 @@ obj-$(CONFIG_TOUCHSCREEN_W90X900)	+= w90p910_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_SX8654)	+= sx8654.o
>  obj-$(CONFIG_TOUCHSCREEN_TPS6507X)	+= tps6507x-ts.o
>  obj-$(CONFIG_TOUCHSCREEN_ZFORCE)	+= zforce_ts.o
> +obj-$(CONFIG_TOUCHSCREEN_SILEAD)	+= silead.o
> diff --git a/drivers/input/touchscreen/silead.c b/drivers/input/touchscreen/silead.c
> new file mode 100644
> index 0000000..5339f93
> --- /dev/null
> +++ b/drivers/input/touchscreen/silead.c
> @@ -0,0 +1,635 @@
> +/* -------------------------------------------------------------------------
> + * Copyright (C) 2014-2015, Intel Corporation
> + *
> + * Derived from:
> + *  gslX68X.c
> + *  Copyright (C) 2010-2015, Shanghai Sileadinc Co.Ltd
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + * ------------------------------------------------------------------------- */
> +
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/acpi.h>
> +#include <linux/interrupt.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/delay.h>
> +#include <linux/firmware.h>
> +#include <linux/input.h>
> +#include <linux/input/mt.h>
> +#include <linux/pm.h>
> +#include <linux/irq.h>
> +
> +#define SILEAD_TS_NAME "silead_ts"
> +
> +#define SILEAD_REG_RESET	0xE0
> +#define SILEAD_REG_DATA		0x80
> +#define SILEAD_REG_TOUCH_NR	0x80
> +#define SILEAD_REG_POWER	0xBC
> +#define SILEAD_REG_CLOCK	0xE4
> +#define SILEAD_REG_STATUS	0xB0
> +#define SILEAD_REG_ID		0xFC
> +#define SILEAD_REG_MEM_CHECK	0xB0
> +
> +#define SILEAD_STATUS_OK	0x5A5A5A5A
> +#define SILEAD_TS_DATA_LEN	44
> +#define SILEAD_CLOCK		0x04
> +
> +#define SILEAD_CMD_RESET	0x88
> +#define SILEAD_CMD_START	0x00
> +
> +#define SILEAD_POINT_DATA_LEN	0x04
> +#define SILEAD_POINT_Y_OFF      0x00
> +#define SILEAD_POINT_Y_MSB_OFF	0x01
> +#define SILEAD_POINT_X_OFF	0x02
> +#define SILEAD_POINT_X_MSB_OFF	0x03
> +#define SILEAD_POINT_HSB_MASK	0x0F
> +#define SILEAD_TOUCH_ID_MASK	0xF0
> +
> +#define SILEAD_DP_X_INVERT	"touchscreen-x-invert"
> +#define SILEAD_DP_Y_INVERT	"touchscreen-y-invert"
> +#define SILEAD_DP_XY_SWAP	"touchscreen-xy-swap"
> +#define SILEAD_DP_X_MAX		"touchscreen-size-x"
> +#define SILEAD_DP_Y_MAX		"touchscreen-size-y"
> +#define SILEAD_DP_MAX_FINGERS	"touchscreen-max-fingers"
> +#define SILEAD_DP_FW_NAME	"touchscreen-fw-name"
> +#define SILEAD_PWR_GPIO_NAME	"power"
> +
> +#define SILEAD_CMD_SLEEP_MIN	10000
> +#define SILEAD_CMD_SLEEP_MAX	20000
> +#define SILEAD_POWER_SLEEP	20
> +#define SILEAD_STARTUP_SLEEP	30
> +
> +#define SILEAD_MAX_FINGERS	10
> +#define SILEAD_MAX_X		4095
> +#define SILEAD_MAX_Y		4095
> +
> +enum silead_ts_power {
> +	SILEAD_POWER_ON  = 1,
> +	SILEAD_POWER_OFF = 0
> +};
> +
> +struct silead_ts_data {
> +	struct i2c_client *client;
> +	struct gpio_desc *gpio_power;
> +	struct input_dev *input;
> +	const char *custom_fw_name;
> +	char fw_name[I2C_NAME_SIZE];
> +	u16 x_max;
> +	u16 y_max;
> +	u8 max_fingers;
> +	bool x_invert;
> +	bool y_invert;
> +	bool xy_swap;
> +	u32 chip_id;
> +	struct input_mt_pos pos[SILEAD_MAX_FINGERS];
> +	int slots[SILEAD_MAX_FINGERS];
> +};
> +
> +struct silead_fw_data {
> +	u32 offset;
> +	u32 val;
> +};
> +
<snip>
> +
> +static int silead_ts_load_fw(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct silead_ts_data *data = i2c_get_clientdata(client);
> +	unsigned int fw_size, i;
> +	const struct firmware *fw;
> +	struct silead_fw_data *fw_data;
> +	int error;
> +
> +	dev_dbg(dev, "Firmware file name: %s", data->fw_name);
> +
> +	if (data->custom_fw_name)
> +		error = request_firmware(&fw, data->custom_fw_name, dev);

Using request_firmware in probe may lead to delays in initialization when the driver
is compiled into the kernel (since the filesystem might not be mounted so the firmware
is not available at that point). You could use request_firmware_wait instead if you
need to write the firmware before finishing probe or export a sysfs interface and let
the user trigger the firmware update.

> +	else
> +		error = request_firmware(&fw, data->fw_name, dev);
> +
> +	if (error) {
> +		dev_err(dev, "Firmware request error %d\n", error);
> +		return error;
> +	}
> +
> +	fw_size = fw->size / sizeof(*fw_data);
> +	fw_data = (struct silead_fw_data *)fw->data;
> +
> +	for (i = 0; i < fw_size; i++) {
> +		error = i2c_smbus_write_i2c_block_data(client,
> +						       fw_data[i].offset,
> +						       4,
> +						       (u8 *)&fw_data[i].val);
> +		if (error) {
> +			dev_err(dev, "Firmware load error %d\n", error);
> +			goto release_fw_err;
> +		}
> +	}
> +
> +	release_firmware(fw);
> +	return 0;
> +
> +release_fw_err:
> +	release_firmware(fw);
> +	return error;
> +}
<snip>
> +
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id silead_ts_acpi_match[];
> +
> +static int silead_ts_set_default_fw_name(struct silead_ts_data *data,
> +					 const struct i2c_device_id *id)
> +{
> +	const struct acpi_device_id *acpi_id;
> +	struct device *dev = &data->client->dev;
> +	int i;
> +
> +	if (ACPI_HANDLE(dev)) {
> +		acpi_id = acpi_match_device(silead_ts_acpi_match, dev);

You could use dev->driver->acpi_match_table instead of silead_ts_acpi_match.

> +		if (!acpi_id)
> +			return -ENODEV;
> +
> +		sprintf(data->fw_name, "%s.fw", acpi_id->id);

Using snprintf would be more safe (here and in the other 2 instances below).

> +
> +		for (i = 0; i < strlen(data->fw_name); i++)
> +			data->fw_name[i] = tolower(data->fw_name[i]);
> +	} else {
> +		sprintf(data->fw_name, "%s.fw", id->name);
> +	}
> +
> +	return 0;
> +}
> +#else
> +static int silead_ts_set_default_fw_name(struct silead_ts_data *data,
> +					 const struct i2c_device_id *id)
> +{
> +	sprintf(data->fw_name, "%s.fw", id->name);
> +	return 0;
> +}
> +#endif
> +
> +static int silead_ts_probe(struct i2c_client *client,
> +			   const struct i2c_device_id *id)
> +{
> +	struct silead_ts_data *data;
> +	struct device *dev = &client->dev;
> +	int error;
> +
> +	if (!i2c_check_functionality(client->adapter,
> +				     I2C_FUNC_I2C |
> +				     I2C_FUNC_SMBUS_READ_I2C_BLOCK |
> +				     I2C_FUNC_SMBUS_WRITE_I2C_BLOCK)) {
> +		dev_err(dev, "I2C functionality check failed\n");
> +		return -ENXIO;
> +	}
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, data);
> +	data->client = client;
> +
> +	error = silead_ts_set_default_fw_name(data, id);
> +	if (error)
> +		return error;
> +
> +	/* If the IRQ is not filled by DT or ACPI subsytem
> +	 * we can't continue without it */
> +	if (client->irq <= 0)
> +		return -ENODEV;
> +
> +	/* Power GPIO pin */
> +	data->gpio_power = devm_gpiod_get_index(dev, SILEAD_PWR_GPIO_NAME,
> +						GPIOD_OUT_LOW, 1);

I guess you reversed the order of idx and flags in the devm_gpiod_get_index call.

Assuming you are using idx=1 in the call above, this could cause some problems
when using device tree. The driver will look for  the second entry (idx 1) in a gpio-power
array. You could add a device tree bindings documentation for this driver or add an
example in the commit message to make it clear how it's supposed to be used for
device tree.

Thanks,
Irina

> +	if (IS_ERR(data->gpio_power)) {
> +		dev_dbg(dev, "Shutdown GPIO request failed\n");
> +		data->gpio_power = NULL;
> +	}
> +
> +	error = silead_ts_read_props(client);
> +	if (error)
> +		return error;
> +
> +	error = silead_ts_setup(client);
> +	if (error)
> +		return error;
> +
> +	error = silead_ts_request_input_dev(data);
> +	if (error)
> +		return error;
> +
> +	error = devm_request_threaded_irq(dev, client->irq, NULL,
> +					silead_ts_threaded_irq_handler,
> +					IRQF_ONESHOT | IRQ_TYPE_EDGE_RISING,
> +					client->name, data);
> +	if (error) {
> +		dev_err(dev, "IRQ request failed %d\n", error);
> +		return error;
> +	}
> +
> +	dev_dbg(dev, "Probing succeded\n");
> +	return 0;
> +}
> +
> +static int __maybe_unused silead_ts_suspend(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +
> +	silead_ts_set_power(client, SILEAD_POWER_OFF);
> +	return 0;
> +}
> +
> +static int __maybe_unused silead_ts_resume(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	int error, status;
> +
> +	silead_ts_set_power(client, SILEAD_POWER_ON);
> +
> +	error = silead_ts_reset(client);
> +	if (error)
> +		return error;
> +
> +	error = silead_ts_startup(client);
> +	if (error)
> +		return error;
> +
> +	status = silead_ts_get_status(client);
> +	if (status != SILEAD_STATUS_OK) {
> +		dev_err(dev, "Resume error, status: 0x%X\n", status);
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(silead_ts_pm, silead_ts_suspend, silead_ts_resume);
> +
> +static const struct i2c_device_id silead_ts_id[] = {
> +	{ "gsl1680", 0 },
> +	{ "gsl1688", 0 },
> +	{ "gsl3670", 0 },
> +	{ "gsl3675", 0 },
> +	{ "gsl3692", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, silead_ts_id);
> +
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id silead_ts_acpi_match[] = {
> +	{ "GSL1680", 0 },
> +	{ "GSL1688", 0 },
> +	{ "GSL3670", 0 },
> +	{ "GSL3675", 0 },
> +	{ "GSL3692", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, silead_ts_acpi_match);
> +#endif
> +
> +static struct i2c_driver silead_ts_driver = {
> +	.probe = silead_ts_probe,
> +	.id_table = silead_ts_id,
> +	.driver = {
> +		.name = SILEAD_TS_NAME,
> +		.owner = THIS_MODULE,
> +		.acpi_match_table = ACPI_PTR(silead_ts_acpi_match),
> +		.pm = &silead_ts_pm,
> +	},
> +};
> +module_i2c_driver(silead_ts_driver);
> +
> +MODULE_AUTHOR("Robert Dolca <robert.dolca@intel.com>");
> +MODULE_DESCRIPTION("Silead I2C touchscreen driver");
> +MODULE_LICENSE("GPL");
> --
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
