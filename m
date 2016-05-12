From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] Input - ntrig_spi: add new driver for the Surface 3
Date: Thu, 12 May 2016 21:51:22 +0200
Message-ID: <20160512195122.GX23234@mail.corp.redhat.com>
References: <1463065674-14775-1-git-send-email-benjamin.tissoires@redhat.com>
 <20160512191613.GB25805@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48311 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753088AbcELTv2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 12 May 2016 15:51:28 -0400
Content-Disposition: inline
In-Reply-To: <20160512191613.GB25805@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On May 12 2016 or thereabouts, Dmitry Torokhov wrote:
> Hi Benjamin,
> 
> On Thu, May 12, 2016 at 05:07:54PM +0200, Benjamin Tissoires wrote:
> > This is a basic driver for the Surface 3. I am not so sure it will work
> > with any firmwares as most values are encoded, but given that I only have
> > access to my current device with its firmware and I don't have the
> > datasheet, it should be OK for now.
> > 
> > The Surface Pen is not supported (if it is supposed to be). I'll work on
> > this when I get one.
> > 
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > ---
> >  drivers/input/touchscreen/Kconfig     |  11 ++
> >  drivers/input/touchscreen/Makefile    |   1 +
> >  drivers/input/touchscreen/ntrig_spi.c | 339 ++++++++++++++++++++++++++++++++++
> >  3 files changed, 351 insertions(+)
> >  create mode 100644 drivers/input/touchscreen/ntrig_spi.c
> > 
> > diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> > index 8ecdc38..22296a4 100644
> > --- a/drivers/input/touchscreen/Kconfig
> > +++ b/drivers/input/touchscreen/Kconfig
> > @@ -561,6 +561,17 @@ config TOUCHSCREEN_MK712
> >  	  To compile this driver as a module, choose M here: the
> >  	  module will be called mk712.
> >  
> > +config TOUCHSCREEN_NTRIG_SPI
> > +	tristate "Ntrig/Microsoft SPI touchscreen"
> > +	help
> > +	  Say Y here if you have the Ntrig/Microsoft SPI touchscreen
> > +	  controller chip as found on the Surface 3 in your system.
> > +
> > +	  If unsure, say N.
> > +
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called ntrig_spi.
> > +
> >  config TOUCHSCREEN_HP600
> >  	tristate "HP Jornada 6xx touchscreen"
> >  	depends on SH_HP6XX && SH_ADC
> > diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> > index f42975e..8e04ad1 100644
> > --- a/drivers/input/touchscreen/Makefile
> > +++ b/drivers/input/touchscreen/Makefile
> > @@ -54,6 +54,7 @@ obj-$(CONFIG_TOUCHSCREEN_MIGOR)		+= migor_ts.o
> >  obj-$(CONFIG_TOUCHSCREEN_MMS114)	+= mms114.o
> >  obj-$(CONFIG_TOUCHSCREEN_MTOUCH)	+= mtouch.o
> >  obj-$(CONFIG_TOUCHSCREEN_MK712)		+= mk712.o
> > +obj-$(CONFIG_TOUCHSCREEN_NTRIG_SPI)	+= ntrig_spi.o
> >  obj-$(CONFIG_TOUCHSCREEN_HP600)		+= hp680_ts_input.o
> >  obj-$(CONFIG_TOUCHSCREEN_HP7XX)		+= jornada720_ts.o
> >  obj-$(CONFIG_TOUCHSCREEN_IPAQ_MICRO)	+= ipaq-micro-ts.o
> > diff --git a/drivers/input/touchscreen/ntrig_spi.c b/drivers/input/touchscreen/ntrig_spi.c
> > new file mode 100644
> > index 0000000..0d61fc0
> > --- /dev/null
> > +++ b/drivers/input/touchscreen/ntrig_spi.c
> > @@ -0,0 +1,339 @@
> > +/*
> > + *  Driver for Ntrig/Microsoft Touchscreens over SPI
> > + *
> > + *  Copyright (c) 2016 Red Hat Inc.
> > + *
> > + */
> > +
> > +/*
> > + * This program is free software; you can redistribute it and/or modify it
> > + * under the terms of the GNU General Public License as published by the Free
> > + * Software Foundation; version 2 of the License.
> > + */
> > +
> > +#include <linux/kernel.h>
> > +
> > +#include <asm/unaligned.h>
> > +#include <linux/delay.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/input.h>
> > +#include <linux/input/mt.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/module.h>
> > +#include <linux/slab.h>
> > +#include <linux/spi/spi.h>
> > +#include <linux/acpi.h>
> > +
> > +#define NTRIG_PACKET_SIZE	264
> > +
> > +struct ntrig {
> > +	struct spi_device *spi;
> > +	struct gpio_desc *gpiod_int;
> > +	struct gpio_desc *gpiod_rst[2];
> > +	struct input_dev *input_dev;
> > +};
> > +
> > +struct ntrig_finger {
> > +	u8 status;
> > +	u16 tracking_id;
> 
> Can we annotate it with __leXX/__beXX as needed to make sure we do not
> accidentally use the structure directly.

good point, will amend.

> 
> > +	u16 x;
> > +	u16 cx;
> > +	u16 y;
> > +	u16 cy;
> > +	u16 width;
> > +	u16 height;
> > +	u32 padding;
> > +} __packed;
> > +
> > +static ssize_t ntrig_spi_read(struct spi_device *spi, char *rxbuf, size_t len)
> > +{
> > +	struct spi_message msg;
> > +	struct spi_transfer xfer;
> > +	u8 rd_buf[NTRIG_PACKET_SIZE];
> > +	int err = 0;
> > +
> > +	if (!spi)
> > +		return 0;
> 
> How?

Yes, you know, in case there is something...
...hum, will remove in v2.

> 
> > +
> > +	memset(&xfer, 0, sizeof(xfer));
> > +	memset(rd_buf, 0, sizeof(rd_buf));
> > +	spi_message_init(&msg);
> > +
> > +	xfer.tx_buf = NULL;
> > +	xfer.len = len;
> > +	xfer.rx_buf = rd_buf;
> 
> SPI (like USB) required buffers to be DMA-able, so they can not be on
> stack. Either allocate with kmalloc or put as __cacheline__aligned in
> ntrig structure.

Yeah, I was not so sure about that. Will fix it.

> 
> > +	spi_message_add_tail(&xfer, &msg);
> > +
> > +	err = spi_sync(spi, &msg);
> > +	memcpy(rxbuf, rd_buf, xfer.len);
> 
> BTW, why exactly we use local buffer? And why not simply use spi_read()?

I first use some snippets from other drivers that need to write before
read (or the other way around). It felt in a working situation and I did
not looked further. 

> 
> > +
> > +	return err;
> > +}
> > +
> > +static void ntrig_spi_report_touch(struct ntrig *ntr,
> > +				   struct ntrig_finger *finger)
> > +{
> > +	int st = finger->status & 0x01;
> > +	int id = get_unaligned_le16(&finger->tracking_id);
> > +	int  x = get_unaligned_le16(&finger->x);
> > +	int  y = get_unaligned_le16(&finger->y);
> > +	int  w = get_unaligned_le16(&finger->width);
> > +	int  h = get_unaligned_le16(&finger->height);
> > +	int slot;
> > +
> > +	slot = input_mt_get_slot_by_key(ntr->input_dev, id);
> > +	if (slot < 0)
> > +		return;
> > +
> > +	input_mt_slot(ntr->input_dev, slot);
> > +	input_mt_report_slot_state(ntr->input_dev, MT_TOOL_FINGER, st);
> > +	if (st) {
> 
> Maybe do the le->cpu conversions only when we have active touch?

Could be :)

> 
> > +		input_report_abs(ntr->input_dev, ABS_MT_POSITION_X, x);
> > +		input_report_abs(ntr->input_dev, ABS_MT_POSITION_Y, y);
> > +		input_report_abs(ntr->input_dev, ABS_MT_TOUCH_MAJOR, w);
> > +		input_report_abs(ntr->input_dev, ABS_MT_WIDTH_MAJOR, w);
> > +		input_report_abs(ntr->input_dev, ABS_MT_TOUCH_MINOR, h);
> > +		input_report_abs(ntr->input_dev, ABS_MT_WIDTH_MINOR, h);
> 
> Do we need to report WIDTH if it is same as TOUCH? BTW, you do not seem
> to declare TOUCH in input devoice capabilities.

I can simply drop the TOUCH_*, yes.

> 
> > +	}
> > +}
> > +
> > +static int ntrig_spi_process(struct ntrig *ntr, const char *data)
> > +{
> > +	const char header[] = {0xff, 0xff, 0xff, 0xff, 0xa5, 0x5a, 0xe7, 0x7e,
> > +			       0x01, 0xd2, 0x00, 0x80, 0x01, 0x03, 0x03};
> > +	u16 timestamp;
> > +	unsigned int i;
> > +
> > +	if (memcmp(header, data, sizeof(header)))
> > +		dev_err(&ntr->spi->dev, "%s header error: %15ph, ignoring... %s:%d\n",
> 
> Use %*ph and then (int)sizeof(header) ?

OK. I had been once requested to not use %*ph when the size was a
constant, but given that we can use "(int)sizeof(header)" it won't be a
"constant" :)

> 
> > +			__func__, data, __FILE__, __LINE__);
> 
> Do we really need FILE/LINE?

Not really, I like it though when debugging. I can drop it in the next
submission.

> 
> > +
> > +	timestamp = get_unaligned_le16(&data[15]);
> > +
> > +	for (i = 0; i < 13; i++) {
> > +		struct ntrig_finger *finger;
> > +
> > +		finger = (struct ntrig_finger *)&data[17 +
> > +					       i * sizeof(struct ntrig_finger)];
> > +
> > +		if (finger->status & 0x10)
> > +			break;
> 
> Comment why we are breaking out?

Yes. I need to re-work on the incoming protocol for that. IIRC, there
was some sort of sentinel value at some point...

> 
> > +
> > +		ntrig_spi_report_touch(ntr, finger);
> > +	}
> > +
> > +	input_mt_sync_frame(ntr->input_dev);
> > +	input_sync(ntr->input_dev);
> > +	return 0;
> > +}
> > +
> > +static irqreturn_t ntrig_spi_irq_handler(int irq, void *dev_id)
> > +{
> > +	struct ntrig *data = dev_id;
> > +	char spiRxbuf[NTRIG_PACKET_SIZE];
> > +
> > +	while (gpiod_get_value(data->gpiod_int)) {
> 
> What if interrupt line is not described as GPIO?

I do not have the spec, but I implied that it might be close to the
official HID over I2C spec. In this spec, they said that the interrupt
line will be kept high until there is no more data.

I can try to work around this, but right now, the driver fails if the
interrupt line is not a GPIO.

Which leads to an other question: do you think we should call it
surface_ts_spi.c instead of ntrig_spi? I am not sure this will work
with any other Ntrig/SPI device...

> 
> > +		memset(spiRxbuf, 0x00, NTRIG_PACKET_SIZE);
> 
> No camel casing (or local buffers either).

Yep, will drop.

> 
> > +		ntrig_spi_read(data->spi, spiRxbuf, NTRIG_PACKET_SIZE);
> 
> Handle failures?

That would be welcome, indeed :)

> 
> > +		dev_dbg(&data->spi->dev, "%s received -> %*ph %s:%d\n",
> > +			__func__, NTRIG_PACKET_SIZE, spiRxbuf,
> > +			__FILE__, __LINE__);
> > +		ntrig_spi_process(data, spiRxbuf);
> > +	}
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static void ntrig_spi_power(struct ntrig *data, unsigned int value)
> 
> "bool on"?

OK

> 
> > +{
> > +	gpiod_set_value(data->gpiod_rst[0], value);
> > +	gpiod_set_value(data->gpiod_rst[1], value);
> 
> Does it require any timing considerations?

I have strictly no idea. In the probe I took the minimum msleep between
the power calls to give the device time, but I just don't know right
now.

> 
> > +}
> > +
> > +/**
> > + * ntrig_spi_get_gpio_config - Get GPIO config from ACPI/DT
> > + *
> > + * @ts: ntrig_spi_ts_data pointer
> > + */
> > +static int ntrig_spi_get_gpio_config(struct ntrig *data)
> > +{
> > +	int error;
> > +	struct device *dev;
> > +	struct gpio_desc *gpiod;
> > +	int i;
> > +
> > +	if (!data->spi)
> > +		return -EINVAL;
> 
> How?

See above :) in case there is a butterfly flapping its wings someplace...

> 
> > +
> > +	dev = &data->spi->dev;
> > +
> > +	/* Get the interrupt GPIO pin number */
> > +	gpiod = devm_gpiod_get_index(dev, NULL, 2, GPIOD_IN);
> > +	if (IS_ERR(gpiod)) {
> > +		error = PTR_ERR(gpiod);
> > +		if (error != -EPROBE_DEFER)
> > +			dev_err(dev, "Failed to get int GPIO: %d\n", error);
> > +		return error;
> > +	}
> 
> Can this made optional?

I can work around an optional INT GPIO. But I don't know if Ntrig will
provide this touchscreen to other devices than just the Surface.

> 
> > +
> > +	data->gpiod_int = gpiod;
> > +
> > +	/* Get the reset lines GPIO pin number */
> > +	for (i = 0; i < 2; i++) {
> > +		gpiod = devm_gpiod_get_index(dev, NULL, i, GPIOD_OUT_LOW);
> > +		if (IS_ERR(gpiod)) {
> > +			error = PTR_ERR(gpiod);
> > +			if (error != -EPROBE_DEFER)
> > +				dev_err(dev,
> > +					"Failed to get power GPIO %d: %d\n",
> > +					i,
> > +					error);
> > +			return error;
> > +		}
> > +
> > +		data->gpiod_rst[i] = gpiod;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int ntrig_spi_create_input(struct ntrig *data)
> > +{
> > +	struct input_dev *input;
> > +	int error;
> > +
> > +	input = devm_input_allocate_device(&data->spi->dev);
> > +	if (IS_ERR(input))
> > +		return PTR_ERR(input);
> 
> devm_input_allocate_device does not return ERR_PTR-encoded pointers.

heh. Silly me

> 
> > +
> > +	data->input_dev = input;
> > +
> > +	input_set_abs_params(input, ABS_MT_POSITION_X, 0, 9600, 0, 0);
> > +	input_abs_set_res(input, ABS_MT_POSITION_X, 40);
> > +	input_set_abs_params(input, ABS_MT_POSITION_Y, 0, 7200, 0, 0);
> > +	input_abs_set_res(input, ABS_MT_POSITION_Y, 48);
> > +	input_set_abs_params(input, ABS_MT_WIDTH_MAJOR, 0, 1024, 0, 0);
> > +	input_set_abs_params(input, ABS_MT_WIDTH_MINOR, 0, 1024, 0, 0);
> > +	input_mt_init_slots(input, 10, INPUT_MT_DIRECT);
> > +
> > +	input->name = "Ntrig Capacitive TouchScreen";
> > +	input->phys = "input/ts";
> > +	input->id.bustype = BUS_SPI;
> > +	input->id.vendor = 0x1b96;
> > +	input->id.product = 0x0000;
> > +	input->id.version = 0x0000;
> > +
> > +	error = input_register_device(input);
> > +	if (error) {
> > +		dev_err(&data->spi->dev,
> > +			"Failed to register input device: %d", error);
> > +		return error;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void ntrig_spi_free_irq(struct ntrig *data)
> > +{
> > +	devm_free_irq(&data->spi->dev, data->spi->irq, data);
> > +}
> > +
> > +static int ntrig_spi_request_irq(struct ntrig *data)
> > +{
> > +	struct spi_device *spi = data->spi;
> > +
> > +	return devm_request_threaded_irq(&spi->dev, spi->irq,
> > +					  NULL, ntrig_spi_irq_handler,
> > +					  IRQ_TYPE_EDGE_RISING | IRQF_ONESHOT,
> > +					  "Ntrig-irq", data);
> > +}
> > +
> > +static int ntrig_spi_probe(struct spi_device *spi)
> > +{
> > +	struct ntrig *data = NULL;
> 
> Why do you initialize this?

More likely a leftover of a previous iteration.

> 
> > +	int error;
> > +
> > +	/* Set up SPI*/
> > +	spi->bits_per_word = 8;
> > +	spi->mode = SPI_MODE_0;
> > +	error = spi_setup(spi);
> > +	if (error)
> > +		return error;
> > +
> > +	data = devm_kzalloc(&spi->dev, sizeof(*data), GFP_KERNEL);
> 
> Error handling?
> 

ouch

> > +
> > +	data->spi = spi;
> > +	spi_set_drvdata(spi, data);
> > +
> > +	error = ntrig_spi_get_gpio_config(data);
> > +	if (error)
> > +		return error;
> > +
> > +	ntrig_spi_power(data, 1);
> > +	msleep(20);
> > +	ntrig_spi_power(data, 0);
> > +	msleep(20);
> > +	ntrig_spi_power(data, 1);
> > +
> > +	error = ntrig_spi_create_input(data);
> > +	if (error)
> > +		return error;
> > +
> > +	error = ntrig_spi_request_irq(data);
> > +	if (error)
> > +		return error;
> > +
> > +	return PTR_ERR_OR_ZERO(data);
> 
> Why on earth???

re-ouch

> 
> > +}
> > +
> > +static int __maybe_unused ntrig_spi_suspend(struct device *dev)
> > +{
> > +	struct spi_device *spi = to_spi_device(dev);
> > +	struct ntrig *data = spi_get_drvdata(spi);
> > +
> > +	ntrig_spi_free_irq(data);
> 
> Why?

To disable the IRQ and be sure we won't wake up the device...
It might just work without though.

> 
> > +
> > +	ntrig_spi_power(data, 0);
> 
> false?
> 
> > +
> > +	return 0;
> > +}
> > +
> > +static int __maybe_unused ntrig_spi_resume(struct device *dev)
> > +{
> > +	struct spi_device *spi = to_spi_device(dev);
> > +	struct ntrig *data = spi_get_drvdata(spi);
> > +	int error;
> > +
> > +	ntrig_spi_power(data, 1);
> 
> true?
> 
> > +
> > +	error = ntrig_spi_request_irq(data);
> > +	if (error)
> > +		return error;
> 
> Again, why?
> 

See above. Setting power might be just enough...

> > +
> > +	return 0;
> > +}
> > +
> > +static SIMPLE_DEV_PM_OPS(ntrig_spi_pm_ops, ntrig_spi_suspend, ntrig_spi_resume);
> > +
> > +#ifdef CONFIG_ACPI
> > +static const struct acpi_device_id ntrig_spi_acpi_match[] = {
> > +	{ "MSHW0037", 0 },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(acpi, ntrig_spi_acpi_match);
> > +#endif
> > +
> > +static struct spi_driver ntrig_spi_driver = {
> > +	.driver = {
> > +		.name	= "Ntrig-spi",
> > +		.acpi_match_table = ACPI_PTR(ntrig_spi_acpi_match),
> > +		.pm = &ntrig_spi_pm_ops,
> > +	},
> > +	.probe = ntrig_spi_probe,
> > +};
> > +
> > +module_spi_driver(ntrig_spi_driver);
> > +
> > +MODULE_AUTHOR("Benjamin Tissoires <benjamin.tissoires@gmail.com>");
> > +MODULE_DESCRIPTION("Ntrig SPI touchscreen driver");
> > +MODULE_LICENSE("GPL v2");
> > -- 
> > 2.5.0
> > 
> 

Thanks for the fast review Dmitry.
I'll send an updated version tomorrow.

Cheers,
Benjamin
