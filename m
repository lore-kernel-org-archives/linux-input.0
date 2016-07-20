From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] input: misc: Add support for Domintech DMARD06
 accelerometer
Date: Tue, 19 Jul 2016 17:02:30 -0700
Message-ID: <20160720000230.GF19250@dtor-ws>
References: <1468846092-18914-1-git-send-email-mamlinav@gmail.com>
 <1468846092-18914-3-git-send-email-mamlinav@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1468846092-18914-3-git-send-email-mamlinav@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aleksei Mamlin <mamlinav@gmail.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-input@vger.kernel.org

On Mon, Jul 18, 2016 at 03:48:12PM +0300, Aleksei Mamlin wrote:
> This patch add support for Domintech DMARD06 accelerometer.
> 
> Domintech DMARD06 is a low-g tri-axial digital accelerometer with
> special power saving modes suitable for consumer mobile application.

I'd say this belongs to IIO. The input/misc accelerometers are mostly
legacy.

> 
> Signed-off-by: Aleksei Mamlin <mamlinav@gmail.com>
> ---
>  .../devicetree/bindings/input/dmard06.txt          |  24 ++
>  drivers/input/misc/Kconfig                         |  12 +
>  drivers/input/misc/Makefile                        |   1 +
>  drivers/input/misc/dmard06.c                       | 442 +++++++++++++++++++++
>  4 files changed, 479 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/dmard06.txt
>  create mode 100644 drivers/input/misc/dmard06.c
> 
> diff --git a/Documentation/devicetree/bindings/input/dmard06.txt b/Documentation/devicetree/bindings/input/dmard06.txt
> new file mode 100644
> index 0000000..528c318
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/dmard06.txt
> @@ -0,0 +1,24 @@
> +Device tree bindings for Domintech DMARD06 acceletometer
> +
> +Required properties:
> + - compatible		: Should be "domintech,dmard06"
> + - reg			: I2C address of the chip. Should be 0x1c
> +
> +Optional properties:
> + - interrupt-parent	: Interrupt controller to which the chip is connected
> + - interrupts		: Interrupt to which the chip is connected
> +
> +
> +Example:
> +	&i2c1 {
> +		/* ... */
> +
> +		accelerometer@1c {
> +			compatible = "domintech,dmard06";
> +			reg = <0x1c>;
> +			interrupt-parent = <&gpio>;
> +			interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> +		};
> +
> +		/* ... */
> +	};
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index efb0ca8..b95e0e7 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -107,6 +107,18 @@ config INPUT_BMA150
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called bma150.
>  
> +config INPUT_DMARD06
> +	tristate "Domintech DMARD06 Digital Accelerometer support"
> +	depends on OF || COMPILE_TEST
> +	depends on I2C
> +	select INPUT_POLLDEV
> +	help
> +	  Say Y to enable support for the Domintech DMARD06 Low-G Tri-Axial
> +	  digital accelerometer connected via an I2C bus.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called dmard06.
> +
>  config INPUT_E3X0_BUTTON
>  	tristate "NI Ettus Research USRP E3xx Button support."
>  	default n
> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> index 6a1e5e2..d83866f 100644
> --- a/drivers/input/misc/Makefile
> +++ b/drivers/input/misc/Makefile
> @@ -28,6 +28,7 @@ obj-$(CONFIG_INPUT_DA9052_ONKEY)	+= da9052_onkey.o
>  obj-$(CONFIG_INPUT_DA9055_ONKEY)	+= da9055_onkey.o
>  obj-$(CONFIG_INPUT_DA9063_ONKEY)	+= da9063_onkey.o
>  obj-$(CONFIG_INPUT_DM355EVM)		+= dm355evm_keys.o
> +obj-$(CONFIG_INPUT_DMARD06)		+= dmard06.o
>  obj-$(CONFIG_INPUT_E3X0_BUTTON)		+= e3x0-button.o
>  obj-$(CONFIG_INPUT_DRV260X_HAPTICS)	+= drv260x.o
>  obj-$(CONFIG_INPUT_DRV2665_HAPTICS)	+= drv2665.o
> diff --git a/drivers/input/misc/dmard06.c b/drivers/input/misc/dmard06.c
> new file mode 100644
> index 0000000..cc1e5a2
> --- /dev/null
> +++ b/drivers/input/misc/dmard06.c
> @@ -0,0 +1,442 @@
> +/*
> + *  Driver for Domintech DMARD06 accelerometer
> + *
> + *  Copyright (C) 2016 Aleksei Mamlin <mamlinav@gmail.com>
> + *  Copyright (c) 2012 Domintech Technology Co., Ltd
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the Free
> + * Software Foundation; version 2 of the License.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/input.h>
> +#include <linux/input-polldev.h>
> +#include <linux/irq.h>
> +#include <linux/interrupt.h>
> +#include <linux/delay.h>
> +#include <linux/slab.h>
> +#include <linux/of.h>
> +
> +/* Device data registers */
> +#define DMARD06_CHIP_ID_REG		0x0f
> +#define DMARD06_TOUT_REG		0x40
> +#define DMARD06_XOUT_REG		0x41
> +#define DMARD06_YOUT_REG		0x42
> +#define DMARD06_ZOUT_REG		0x43
> +
> +/* Device control registers */
> +#define DMARD06_CTRL_1_REG		0x44
> +#define DMARD06_CTRL_2_REG		0x45
> +#define DMARD06_CTRL_3_REG		0x46
> +#define DMARD06_CTRL_4_REG		0x47
> +#define DMARD06_CTRL_5_REG		0x48
> +#define DMARD06_STATUS_REG		0x49
> +#define DMARD06_INT_CFG_REG		0x4a
> +#define DMARD06_FILTER_RESET_REG	0x52
> +#define DMARD06_CHIP_RESET_REG		0x53
> +
> +/* Device ID value */
> +#define DMARD06_CHIP_ID			0x06
> +
> +/* Device max value */
> +#define DMARD06_MAX_VALUE		0x3f
> +
> +/* Each axis is represented by a 1-byte data word */
> +#define DMARD06_XYZ_DATA_SIZE		3
> +
> +/* Interrupt sources */
> +#define DMARD06_INT_SRC1		0x04
> +#define DMARD06_INT_SRC_BOTH		0x08
> +#define DMARD06_INT_MOV_DETECT		0x40
> +#define DMARD06_INT_POS_DETECT		0xc0
> +
> +/* Device modes */
> +#define DMARD06_MODE_NORMAL		0x27
> +#define DMARD06_MODE_POWERDOWN		0x00
> +
> +/* Input poll interval in milliseconds */
> +#define DMARD06_POLL_INTERVAL		10
> +#define DMARD06_POLL_MAX		100
> +#define DMARD06_POLL_MIN		0
> +
> +struct dmard06_data {
> +	struct i2c_client *client;
> +	struct input_dev *input;
> +	struct input_polled_dev *input_poll;
> +	unsigned long irq_flags;
> +	int range;
> +	u8 chip_id;
> +	u8 mode;
> +};
> +
> +static int dmard06_i2c_read(struct i2c_client *client, u8 reg, u8 *buf)
> +{
> +	int error;
> +
> +	error = i2c_master_send(client, &reg, 1);
> +	if (unlikely(error < 0))
> +		return error;
> +
> +	error = i2c_master_recv(client, buf, 1);
> +	if (unlikely(error < 0))
> +		return error;
> +
> +	return 0;
> +}
> +
> +static int dmard06_i2c_write(struct i2c_client *client, u8 reg, u8 val)
> +{
> +	int error;
> +	u8 buf[2] = {reg, val};
> +
> +	error = i2c_master_send(client, buf, 2);
> +	if (unlikely(error < 0))
> +		return error;
> +
> +	return 0;
> +}
> +
> +static int dmard06_reset(struct i2c_client *client)
> +{
> +	u8 buf;
> +	int error;
> +
> +	error = dmard06_i2c_read(client, DMARD06_CHIP_RESET_REG, &buf);
> +	if (error) {
> +		dev_err(&client->dev, "Failed to reset controller: %d", error);
> +		return error;
> +	}
> +
> +	return 0;
> +}
> +
> +static int dmard06_set_mode(struct dmard06_data *dmard06, u8 mode)
> +{
> +	int error;
> +
> +	error = dmard06_i2c_write(dmard06->client, DMARD06_CTRL_1_REG, mode);
> +	if (error) {
> +		dev_err(&dmard06->client->dev, "Failed to set mode: %d",
> +			error);
> +		return error;
> +	}
> +
> +	dmard06->mode = mode;
> +
> +	return 0;
> +}
> +
> +static int dmard06_init_irq(struct i2c_client *client)
> +{
> +	int error;
> +
> +	error = dmard06_i2c_write(client, DMARD06_CTRL_4_REG,
> +				  DMARD06_INT_SRC1);
> +	if (error) {
> +		dev_err(&client->dev, "Failed to set interrupt source: %d",
> +			error);
> +		return error;
> +	}
> +
> +	error = dmard06_i2c_write(client, DMARD06_INT_CFG_REG,
> +				  DMARD06_INT_POS_DETECT);
> +	if (error) {
> +		dev_err(&client->dev, "Failed to set interrupt event: %d",
> +			error);
> +		return error;
> +	}
> +
> +	return 0;
> +}
> +
> +static int dmard06_open(struct dmard06_data *dmard06)
> +{
> +	int error;
> +
> +	if (dmard06->mode != DMARD06_MODE_NORMAL) {
> +		error = dmard06_set_mode(dmard06, DMARD06_MODE_NORMAL);
> +		if (error)
> +			return error;
> +	}
> +
> +	return 0;
> +}
> +
> +static void dmard06_close(struct dmard06_data *dmard06)
> +{
> +	if (dmard06->mode != DMARD06_MODE_POWERDOWN)
> +		dmard06_set_mode(dmard06, DMARD06_MODE_POWERDOWN);
> +}
> +
> +static int dmard06_irq_open(struct input_dev *input)
> +{
> +	struct dmard06_data *dmard06 = input_get_drvdata(input);
> +
> +	return dmard06_open(dmard06);
> +}
> +
> +static void dmard06_irq_close(struct input_dev *input)
> +{
> +	struct dmard06_data *dmard06 = input_get_drvdata(input);
> +
> +	dmard06_close(dmard06);
> +}
> +
> +static void dmard06_poll_open(struct input_polled_dev *input_poll)
> +{
> +	struct dmard06_data *dmard06 = input_poll->private;
> +
> +	dmard06_open(dmard06);
> +}
> +
> +static void dmard06_poll_close(struct input_polled_dev *input_poll)
> +{
> +	struct dmard06_data *dmard06 = input_poll->private;
> +
> +	dmard06_close(dmard06);
> +}
> +
> +static int dmard06_read_chip_id(struct dmard06_data *dmard06)
> +{
> +	u8 buf;
> +	u8 chip_id;
> +	int error;
> +
> +	error = dmard06_i2c_read(dmard06->client, DMARD06_CHIP_ID_REG, &buf);
> +	if (error) {
> +		dev_err(&dmard06->client->dev, "Failed to read chip id: %d\n",
> +			error);
> +		return error;
> +	}
> +
> +	chip_id = (buf & 0x00ff);
> +	if (chip_id != DMARD06_CHIP_ID) {
> +		dev_err(&dmard06->client->dev, "Unknown chip id: %02x\n",
> +			chip_id);
> +		return -EINVAL;
> +	}
> +
> +	dmard06->chip_id = chip_id;
> +	dev_info(&dmard06->client->dev, "Found DMARD%02x chip\n", chip_id);
> +
> +	return 0;
> +}
> +
> +static void dmard06_report_xyz(struct dmard06_data *dmard06)
> +{
> +	u8 axis[DMARD06_XYZ_DATA_SIZE];
> +	bool reversed;
> +	int xyz[3];
> +	int error;
> +	int i;
> +
> +	error = i2c_smbus_read_i2c_block_data(dmard06->client,
> +					      DMARD06_XOUT_REG,
> +					      DMARD06_XYZ_DATA_SIZE, axis);
> +	if (error != DMARD06_XYZ_DATA_SIZE)
> +		return;
> +
> +	for (i = 0; i < DMARD06_XYZ_DATA_SIZE; i++) {
> +		reversed = (axis[i] >> 7) & 1;
> +		xyz[i] = (int)((axis[i] & 0x7f) >> 1);
> +		if (reversed)
> +			xyz[i] = xyz[i] - dmard06->range;
> +	}
> +
> +	input_report_abs(dmard06->input, ABS_X, xyz[0]);
> +	input_report_abs(dmard06->input, ABS_Y, xyz[1]);
> +	input_report_abs(dmard06->input, ABS_Z, xyz[2]);
> +	input_sync(dmard06->input);
> +}
> +
> +static irqreturn_t dmard06_irq_handler(int irq, void *dev_id)
> +{
> +	struct dmard06_data *dmard06 = dev_id;
> +
> +	dmard06_report_xyz(dmard06);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void dmard06_poll(struct input_polled_dev *input_poll)
> +{
> +	dmard06_report_xyz(input_poll->private);
> +}
> +
> +static void dmard06_init_input_device(struct dmard06_data *dmard06,
> +				      struct input_dev *input)
> +{
> +	int range;
> +
> +	input->name = "dmard06";
> +	input->id.bustype = BUS_I2C;
> +	input->id.version = dmard06->chip_id;
> +	input->dev.parent = &dmard06->client->dev;
> +
> +	set_bit(EV_ABS, input->evbit);
> +
> +	range = DMARD06_MAX_VALUE;
> +	input_set_abs_params(input, ABS_X, -range, range, 0, 0);
> +	input_set_abs_params(input, ABS_Y, -range, range, 0, 0);
> +	input_set_abs_params(input, ABS_Z, -range, range, 0, 0);
> +
> +	dmard06->range = range;
> +}
> +
> +static int dmard06_request_input_device(struct dmard06_data *dmard06)
> +{
> +	struct input_dev *input;
> +	int error;
> +
> +	input = devm_input_allocate_device(&dmard06->client->dev);
> +	if (!input) {
> +		dev_err(&dmard06->client->dev,
> +			"Failed to allocate input device\n");
> +		return -ENOMEM;
> +	}
> +
> +	dmard06_init_input_device(dmard06, input);
> +
> +	input->open = dmard06_irq_open;
> +	input->close = dmard06_irq_close;
> +	input_set_drvdata(input, dmard06);
> +
> +	error = input_register_device(input);
> +	if (error) {
> +		dev_err(&dmard06->client->dev,
> +			"Failed to register input device: %d", error);
> +		return error;
> +	}
> +
> +	dmard06->input = input;
> +
> +	return 0;
> +}
> +
> +static int dmard06_request_polled_device(struct dmard06_data *dmard06)
> +{
> +	struct input_polled_dev *input_poll;
> +	int error;
> +
> +	input_poll = devm_input_allocate_polled_device(&dmard06->client->dev);
> +	if (!input_poll) {
> +		dev_err(&dmard06->client->dev,
> +			"Failed to allocate polled input device\n");
> +		return -ENOMEM;
> +	}
> +
> +	input_poll->private = dmard06;
> +	input_poll->open = dmard06_poll_open;
> +	input_poll->close = dmard06_poll_close;
> +	input_poll->poll = dmard06_poll;
> +	input_poll->poll_interval = DMARD06_POLL_INTERVAL;
> +	input_poll->poll_interval_min = DMARD06_POLL_MIN;
> +	input_poll->poll_interval_max = DMARD06_POLL_MAX;
> +
> +	dmard06_init_input_device(dmard06, input_poll->input);
> +
> +	error = input_register_polled_device(input_poll);
> +	if (error) {
> +		dev_err(&dmard06->client->dev,
> +			"Failed to register polled device: %d", error);
> +		return error;
> +	}
> +
> +	dmard06->input_poll = input_poll;
> +	dmard06->input = input_poll->input;
> +
> +	return 0;
> +}
> +
> +static int dmard06_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
> +	struct dmard06_data *dmard06;
> +	int error;
> +
> +	dev_dbg(&client->dev, "I2C Address: 0x%02x\n", client->addr);
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> +		dev_err(&client->dev, "I2C check functionality failed\n");
> +		return -ENXIO;
> +	}
> +
> +	dmard06 = devm_kzalloc(&client->dev, sizeof(*dmard06), GFP_KERNEL);
> +	if (!dmard06)
> +		return -ENOMEM;
> +
> +	dmard06->client = client;
> +	i2c_set_clientdata(client, dmard06);
> +
> +	error = dmard06_reset(dmard06->client);
> +	if (error)
> +		return error;
> +
> +	error = dmard06_read_chip_id(dmard06);
> +	if (error)
> +		return error;
> +
> +	error = dmard06_set_mode(dmard06, DMARD06_MODE_NORMAL);
> +	if (error)
> +		return error;
> +
> +	if (dmard06->client->irq) {
> +		error = dmard06_init_irq(dmard06->client);
> +		if (error)
> +			return error;
> +
> +		error = dmard06_request_input_device(dmard06);
> +		if (error)
> +			return error;
> +
> +		dmard06->irq_flags = IRQ_TYPE_LEVEL_LOW | IRQF_ONESHOT;
> +		error = devm_request_threaded_irq(&dmard06->client->dev,
> +						  dmard06->client->irq, NULL,
> +						  dmard06_irq_handler,
> +						  dmard06->irq_flags,
> +						  dmard06->client->name,
> +						  dmard06);
> +		if (error) {
> +			dev_err(&dmard06->client->dev,
> +				"Request IRQ failed: %d\n", error);
> +			return error;
> +		}
> +
> +	} else {
> +		error = dmard06_request_polled_device(dmard06);
> +		if (error)
> +			return error;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id dmard06_id[] = {
> +	{ "dmard06", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, dmard06_id);
> +
> +static const struct of_device_id dmard06_of_match[] = {
> +	{ .compatible = "domintech,dmard06" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, dmard06_of_match);
> +
> +static struct i2c_driver dmard06_driver = {
> +	.probe = dmard06_probe,
> +	.class = I2C_CLASS_HWMON,
> +	.id_table = dmard06_id,
> +	.driver = {
> +		.name = "dmard06",
> +		.of_match_table = of_match_ptr(dmard06_of_match),
> +	},
> +};
> +module_i2c_driver(dmard06_driver);
> +
> +MODULE_AUTHOR("Aleksei Mamlin <mamlinav@gmail.com>");
> +MODULE_DESCRIPTION("Domintech DMARD06 accelerometer driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.7.3
> 

-- 
Dmitry
