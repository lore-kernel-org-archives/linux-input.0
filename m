From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input - surface3_spi: add new driver for the Surface 3
Date: Mon, 16 May 2016 12:51:18 -0700
Message-ID: <20160516195118.GG12752@dtor-ws>
References: <1463153826-10283-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36636 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754492AbcEPTva (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 May 2016 15:51:30 -0400
Content-Disposition: inline
In-Reply-To: <1463153826-10283-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, May 13, 2016 at 05:37:06PM +0200, Benjamin Tissoires wrote:
> This is a basic driver for the Surface 3. I am not so sure it will work
> with any firmwares as most values are encoded, but given that I only have
> access to my current device with its firmware and I don't have the
> datasheet, it should be OK for now.
> 
> The Surface Pen is not supported (if it is supposed to be). I'll work on
> this when I get one.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
> 
> Changes in v2:
> 
> - module renamed from ntrig_spi to surface3_spi
> - took into account Dmitry's remarks
> - kept the retrieval of the GPIO as mandatory as otherwise the device fails to work
> 
>  drivers/input/touchscreen/Kconfig        |  11 ++
>  drivers/input/touchscreen/Makefile       |   1 +
>  drivers/input/touchscreen/surface3_spi.c | 320 +++++++++++++++++++++++++++++++
>  3 files changed, 332 insertions(+)
>  create mode 100644 drivers/input/touchscreen/surface3_spi.c
> 
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 8ecdc38..30ffc38 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -1094,6 +1094,17 @@ config TOUCHSCREEN_SUR40
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called sur40.
>  
> +config TOUCHSCREEN_SURFACE3_SPI
> +	tristate "Ntrig/Microsoft Surface 3 SPI touchscreen"
> +	help
> +	  Say Y here if you have the Ntrig/Microsoft SPI touchscreen
> +	  controller chip as found on the Surface 3 in your system.
> +
> +	  If unsure, say N.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called surface3_spi.
> +
>  config TOUCHSCREEN_SX8654
>  	tristate "Semtech SX8654 touchscreen"
>  	depends on I2C
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> index f42975e..3f8ee86 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -67,6 +67,7 @@ obj-$(CONFIG_TOUCHSCREEN_ST1232)	+= st1232.o
>  obj-$(CONFIG_TOUCHSCREEN_STMPE)		+= stmpe-ts.o
>  obj-$(CONFIG_TOUCHSCREEN_SUN4I)		+= sun4i-ts.o
>  obj-$(CONFIG_TOUCHSCREEN_SUR40)		+= sur40.o
> +obj-$(CONFIG_TOUCHSCREEN_SURFACE3_SPI)	+= surface3_spi.o
>  obj-$(CONFIG_TOUCHSCREEN_TI_AM335X_TSC)	+= ti_am335x_tsc.o
>  obj-$(CONFIG_TOUCHSCREEN_TOUCHIT213)	+= touchit213.o
>  obj-$(CONFIG_TOUCHSCREEN_TOUCHRIGHT)	+= touchright.o
> diff --git a/drivers/input/touchscreen/surface3_spi.c b/drivers/input/touchscreen/surface3_spi.c
> new file mode 100644
> index 0000000..06679ff
> --- /dev/null
> +++ b/drivers/input/touchscreen/surface3_spi.c
> @@ -0,0 +1,320 @@
> +/*
> + *  Driver for Ntrig/Microsoft Touchscreens over SPI
> + *
> + *  Copyright (c) 2016 Red Hat Inc.
> + *
> + */
> +
> +/*
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the Free
> + * Software Foundation; version 2 of the License.
> + */
> +
> +#include <linux/kernel.h>
> +
> +#include <asm/unaligned.h>

asm goes after linux.

> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/input.h>
> +#include <linux/input/mt.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/spi/spi.h>
> +#include <linux/acpi.h>
> +
> +#define SURFACE3_PACKET_SIZE	264
> +
> +struct surface3_ts_data {
> +	struct spi_device *spi;
> +	struct gpio_desc *gpiod_int;
> +	struct gpio_desc *gpiod_rst[2];
> +	struct input_dev *input_dev;
> +
> +	u8 rd_buf[SURFACE3_PACKET_SIZE]		____cacheline_aligned;
> +};
> +
> +struct surface3_ts_data_finger {
> +	u8 status;
> +	u16 __le_tracking_id;

I meant

	__le16 tracking_id;

so that sparse will warn us.

> +	u16 __le_x;
> +	u16 __le_cx;
> +	u16 __le_y;
> +	u16 __le_cy;
> +	u16 __le_width;
> +	u16 __le_height;
> +	u32 padding;
> +} __packed;
> +
> +static int surface3_spi_read(struct surface3_ts_data *ts_data)
> +{
> +	struct spi_device *spi = ts_data->spi;
> +
> +	memset(ts_data->rd_buf, 0, sizeof(ts_data->rd_buf));
> +	return spi_read(spi, ts_data->rd_buf, sizeof(ts_data->rd_buf));
> +}
> +
> +static void surface3_spi_report_touch(struct surface3_ts_data *ts_data,
> +				   struct surface3_ts_data_finger *finger)
> +{
> +	int st = finger->status & 0x01;
> +	int id = get_unaligned_le16(&finger->__le_tracking_id);
> +	int slot, x, y, w, h;
> +
> +	slot = input_mt_get_slot_by_key(ts_data->input_dev, id);
> +	if (slot < 0)
> +		return;
> +
> +	input_mt_slot(ts_data->input_dev, slot);
> +	input_mt_report_slot_state(ts_data->input_dev, MT_TOOL_FINGER, st);
> +	if (st) {
> +		x = get_unaligned_le16(&finger->__le_x);
> +		y = get_unaligned_le16(&finger->__le_y);
> +		w = get_unaligned_le16(&finger->__le_width);
> +		h = get_unaligned_le16(&finger->__le_height);
> +
> +		input_report_abs(ts_data->input_dev, ABS_MT_POSITION_X, x);
> +		input_report_abs(ts_data->input_dev, ABS_MT_POSITION_Y, y);
> +		input_report_abs(ts_data->input_dev, ABS_MT_WIDTH_MAJOR, w);
> +		input_report_abs(ts_data->input_dev, ABS_MT_WIDTH_MINOR, h);

Could do conversions inline and drop temps.

> +	}
> +}
> +
> +static void surface3_spi_process(struct surface3_ts_data *ts_data)
> +{
> +	const char header[] = {0xff, 0xff, 0xff, 0xff, 0xa5, 0x5a, 0xe7, 0x7e,
> +			       0x01, 0xd2, 0x00, 0x80, 0x01, 0x03, 0x03};
> +	u8 *data = ts_data->rd_buf;
> +	u16 timestamp;
> +	unsigned int i;
> +
> +	if (memcmp(header, data, sizeof(header)))
> +		dev_err(&ts_data->spi->dev,
> +			"%s header error: %*ph, ignoring...\n",
> +			__func__, (int)sizeof(header), data);
> +
> +	timestamp = get_unaligned_le16(&data[15]);
> +
> +	for (i = 0; i < 13; i++) {
> +		struct surface3_ts_data_finger *finger;
> +
> +		finger = (struct surface3_ts_data_finger *)&data[17 +
> +				i * sizeof(struct surface3_ts_data_finger)];
> +
> +		/*
> +		 * When bit 5 of status is 1, it marks the end of the report:
> +		 * - touch present: 0xe7
> +		 * - touch released: 0xe4
> +		 * - nothing valuable: 0xff
> +		 */
> +		if (finger->status & 0x10)
> +			break;
> +
> +		surface3_spi_report_touch(ts_data, finger);
> +	}
> +
> +	input_mt_sync_frame(ts_data->input_dev);
> +	input_sync(ts_data->input_dev);
> +}
> +
> +static irqreturn_t surface3_spi_irq_handler(int irq, void *dev_id)
> +{
> +	struct surface3_ts_data *data = dev_id;
> +
> +	if (surface3_spi_read(data))
> +		return IRQ_HANDLED;
> +
> +	dev_dbg(&data->spi->dev, "%s received -> %*ph\n",
> +		__func__, SURFACE3_PACKET_SIZE, data->rd_buf);
> +	surface3_spi_process(data);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void surface3_spi_power(struct surface3_ts_data *data, bool on)
> +{
> +	gpiod_set_value(data->gpiod_rst[0], on);
> +	gpiod_set_value(data->gpiod_rst[1], on);
> +	/* let the device settle a little */
> +	msleep(20);
> +}
> +
> +/**
> + * surface3_spi_get_gpio_config - Get GPIO config from ACPI/DT
> + *
> + * @ts: surface3_spi_ts_data pointer
> + */
> +static int surface3_spi_get_gpio_config(struct surface3_ts_data *data)
> +{
> +	int error;
> +	struct device *dev;
> +	struct gpio_desc *gpiod;
> +	int i;
> +
> +	dev = &data->spi->dev;
> +
> +	/* Get the interrupt GPIO pin number */
> +	gpiod = devm_gpiod_get_index(dev, NULL, 2, GPIOD_IN);
> +	if (IS_ERR(gpiod)) {
> +		error = PTR_ERR(gpiod);
> +		if (error != -EPROBE_DEFER)
> +			dev_err(dev, "Failed to get int GPIO: %d\n", error);
> +		return error;
> +	}
> +
> +	data->gpiod_int = gpiod;
> +
> +	/* Get the reset lines GPIO pin number */
> +	for (i = 0; i < 2; i++) {
> +		gpiod = devm_gpiod_get_index(dev, NULL, i, GPIOD_OUT_LOW);
> +		if (IS_ERR(gpiod)) {
> +			error = PTR_ERR(gpiod);
> +			if (error != -EPROBE_DEFER)
> +				dev_err(dev,
> +					"Failed to get power GPIO %d: %d\n",
> +					i,
> +					error);
> +			return error;
> +		}
> +
> +		data->gpiod_rst[i] = gpiod;
> +	}
> +
> +	return 0;
> +}
> +
> +static int surface3_spi_create_input(struct surface3_ts_data *data)
> +{
> +	struct input_dev *input;
> +	int error;
> +
> +	input = devm_input_allocate_device(&data->spi->dev);
> +	if (!input)
> +		return -ENOMEM;
> +
> +	data->input_dev = input;
> +
> +	input_set_abs_params(input, ABS_MT_POSITION_X, 0, 9600, 0, 0);
> +	input_abs_set_res(input, ABS_MT_POSITION_X, 40);
> +	input_set_abs_params(input, ABS_MT_POSITION_Y, 0, 7200, 0, 0);
> +	input_abs_set_res(input, ABS_MT_POSITION_Y, 48);
> +	input_set_abs_params(input, ABS_MT_WIDTH_MAJOR, 0, 1024, 0, 0);
> +	input_set_abs_params(input, ABS_MT_WIDTH_MINOR, 0, 1024, 0, 0);
> +	input_mt_init_slots(input, 10, INPUT_MT_DIRECT);
> +
> +	input->name = "Surface3 SPI Capacitive TouchScreen";
> +	input->phys = "input/ts";
> +	input->id.bustype = BUS_SPI;
> +	input->id.vendor = 0x045e;	/* Microsoft */
> +	input->id.product = 0x0000;
> +	input->id.version = 0x0000;
> +
> +	error = input_register_device(input);
> +	if (error) {
> +		dev_err(&data->spi->dev,
> +			"Failed to register input device: %d", error);
> +		return error;
> +	}
> +
> +	return 0;
> +}
> +
> +static int surface3_spi_request_irq(struct surface3_ts_data *data)
> +{
> +	struct spi_device *spi = data->spi;
> +
> +	return devm_request_threaded_irq(&spi->dev, spi->irq,
> +					  NULL, surface3_spi_irq_handler,
> +					  IRQ_TYPE_EDGE_RISING | IRQF_ONESHOT,
> +					  "Surface3-irq", data);
> +}

Please just call devm_request_threaded_irq directly in probe.

Do you really need to specify IRQ_TYPE_EDGE_RISING? Does not ACPI has
proper trigger specifier for the IRQ?

> +
> +static int surface3_spi_probe(struct spi_device *spi)
> +{
> +	struct surface3_ts_data *data;
> +	int error;
> +
> +	/* Set up SPI*/
> +	spi->bits_per_word = 8;
> +	spi->mode = SPI_MODE_0;
> +	error = spi_setup(spi);
> +	if (error)
> +		return error;
> +
> +	data = devm_kzalloc(&spi->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->spi = spi;
> +	spi_set_drvdata(spi, data);
> +
> +	error = surface3_spi_get_gpio_config(data);
> +	if (error)
> +		return error;
> +
> +	surface3_spi_power(data, true);
> +	surface3_spi_power(data, false);
> +	surface3_spi_power(data, true);
> +
> +	error = surface3_spi_create_input(data);
> +	if (error)
> +		return error;
> +
> +	error = surface3_spi_request_irq(data);
> +	if (error)
> +		return error;
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused surface3_spi_suspend(struct device *dev)
> +{
> +	struct spi_device *spi = to_spi_device(dev);
> +	struct surface3_ts_data *data = spi_get_drvdata(spi);
> +
> +	disable_irq(data->spi->irq);
> +
> +	surface3_spi_power(data, false);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused surface3_spi_resume(struct device *dev)
> +{
> +	struct spi_device *spi = to_spi_device(dev);
> +	struct surface3_ts_data *data = spi_get_drvdata(spi);
> +
> +	surface3_spi_power(data, true);
> +
> +	enable_irq(data->spi->irq);
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(surface3_spi_pm_ops,
> +			 surface3_spi_suspend,
> +			 surface3_spi_resume);
> +
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id surface3_spi_acpi_match[] = {
> +	{ "MSHW0037", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, surface3_spi_acpi_match);
> +#endif
> +
> +static struct spi_driver surface3_spi_driver = {
> +	.driver = {
> +		.name	= "Surface3-spi",
> +		.acpi_match_table = ACPI_PTR(surface3_spi_acpi_match),
> +		.pm = &surface3_spi_pm_ops,
> +	},
> +	.probe = surface3_spi_probe,
> +};
> +
> +module_spi_driver(surface3_spi_driver);
> +
> +MODULE_AUTHOR("Benjamin Tissoires <benjamin.tissoires@gmail.com>");
> +MODULE_DESCRIPTION("Surface 3 SPI touchscreen driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.5.0
> 

-- 
Dmitry
