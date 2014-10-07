From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: driver for the Goodix touchpanel
Date: Tue, 7 Oct 2014 13:58:03 -0700
Message-ID: <20141007205803.GJ16469@dtor-ws>
References: <1411569838.29315.22.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:39011 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753971AbaJGU6J (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Oct 2014 16:58:09 -0400
Received: by mail-pd0-f176.google.com with SMTP id fp1so5594547pdb.7
        for <linux-input@vger.kernel.org>; Tue, 07 Oct 2014 13:58:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1411569838.29315.22.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@gmail.com>

Hi Bastien,

On Wed, Sep 24, 2014 at 04:43:58PM +0200, Bastien Nocera wrote:
> Add a driver for the Goodix touchscreen panel found in Onda v975w
> tablets. The driver is based off the Android driver gt9xx.c found
> in some Android code dumps, but now bears no resemblance to the original
> driver.
> 
> The driver was tested on the aforementioned tablet.

I was looking over the driver once again and I have a few concerns.

> 
> Signed-off-by: Bastien Nocera <hadess@hadess.net>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Tested-by: Bastien Nocera <hadess@hadess.net>
> ---
>  MAINTAINERS                        |   6 +
>  drivers/input/touchscreen/Kconfig  |  13 ++
>  drivers/input/touchscreen/Makefile |   1 +
>  drivers/input/touchscreen/goodix.c | 423 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 443 insertions(+)
>  create mode 100644 drivers/input/touchscreen/goodix.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 670b3dc..7a37464 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4057,6 +4057,12 @@ L:	linux-media@vger.kernel.org
>  S:	Maintained
>  F:	drivers/media/usb/go7007/
>  
> +GOODIX TOUCHSCREEN
> +M:	Bastien Nocera <hadess@hadess.net>
> +L:	linux-input@vger.kernel.org
> +S:	Maintained
> +F:	drivers/input/touchscreen/goodix.c
> +
>  GPIO SUBSYSTEM
>  M:	Linus Walleij <linus.walleij@linaro.org>
>  M:	Alexandre Courbot <gnurou@gmail.com>
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 6bb9a7d..c328df3 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -283,6 +283,19 @@ config TOUCHSCREEN_FUJITSU
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called fujitsu-ts.
>  
> +config TOUCHSCREEN_GOODIX
> +	tristate "Goodix I2C touchscreen"
> +	depends on I2C && ACPI
> +	help
> +	  Say Y here if you have the Goodix touchscreen (such as one
> +	  installed in Onda v975w tablets) connected to your
> +	  system.
> +
> +	  If unsure, say N.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called goodix.
> +
>  config TOUCHSCREEN_ILI210X
>  	tristate "Ilitek ILI210X based touchscreen"
>  	depends on I2C
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> index 4be94fc..55af212 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -33,6 +33,7 @@ obj-$(CONFIG_TOUCHSCREEN_EETI)		+= eeti_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_ELO)		+= elo.o
>  obj-$(CONFIG_TOUCHSCREEN_EGALAX)	+= egalax_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_FUJITSU)	+= fujitsu_ts.o
> +obj-$(CONFIG_TOUCHSCREEN_GOODIX)	+= goodix.o
>  obj-$(CONFIG_TOUCHSCREEN_ILI210X)	+= ili210x.o
>  obj-$(CONFIG_TOUCHSCREEN_INEXIO)	+= inexio.o
>  obj-$(CONFIG_TOUCHSCREEN_INTEL_MID)	+= intel-mid-touch.o
> diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
> new file mode 100644
> index 0000000..fd02b5e
> --- /dev/null
> +++ b/drivers/input/touchscreen/goodix.c
> @@ -0,0 +1,423 @@
> +/*
> + *  driver for Goodix Touchscreens
> + *
> + *  Copyright (c) 2014 Red Hat Inc.
> + *
> + *  This code is based on gt9xx.c authored by andrew@goodix.com:
> + *
> + *  2010 - 2012 Goodix Technology.
> + */
> +
> +/*
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the Free
> + * Software Foundation; version 2 of the License.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/i2c.h>
> +#include <linux/input.h>
> +#include <linux/input/mt.h>
> +#include <linux/module.h>
> +#include <linux/delay.h>
> +#include <linux/irq.h>
> +#include <linux/interrupt.h>
> +#include <linux/slab.h>
> +#include <asm/unaligned.h>
> +
> +struct goodix_ts_data {
> +	struct i2c_client *client;
> +	struct input_dev *input_dev;
> +	int abs_x_max;
> +	int abs_y_max;
> +	unsigned int max_touch_num;
> +	unsigned int int_trigger_type;
> +};
> +
> +#define GOODIX_MAX_HEIGHT		4096
> +#define GOODIX_MAX_WIDTH		4096
> +#define GOODIX_INT_TRIGGER		1
> +#define GOODIX_MAX_TOUCH		10
> +
> +#define GOODIX_CONFIG_MAX_LENGTH	240
> +
> +/* Register defineS */
> +#define GOODIX_READ_COOR_ADDR		0x814E
> +#define GOODIX_REG_CONFIG_DATA		0x8047
> +#define GOODIX_REG_VERSION		0x8140
> +
> +#define RESOLUTION_LOC		1
> +#define TRIGGER_LOC		6
> +
> +static const char *goodix_ts_name = "Goodix Capacitive TouchScreen";
> +static const unsigned long goodix_irq_flags[] = {
> +	IRQ_TYPE_EDGE_RISING,
> +	IRQ_TYPE_EDGE_FALLING,
> +	IRQ_TYPE_LEVEL_LOW,
> +	IRQ_TYPE_LEVEL_HIGH,
> +};
> +
> +/**
> + * goodix_i2c_read - read data from a register of the i2c slave device.
> + *
> + * @client: i2c device.
> + * @reg: the register to read from.
> + * @buf: raw write data buffer.
> + * @len: length of the buffer to write
> + */
> +static int goodix_i2c_read(struct i2c_client *client,
> +				u16 reg, u8 *buf, int len)
> +{
> +	struct i2c_msg msgs[2];
> +	u16 wbuf = cpu_to_be16(reg);
> +	int ret;
> +
> +	msgs[0].flags = 0;
> +	msgs[0].addr  = client->addr;
> +	msgs[0].len   = 2;
> +	msgs[0].buf   = (u8 *) &wbuf;
> +
> +	msgs[1].flags = I2C_M_RD;
> +	msgs[1].addr  = client->addr;
> +	msgs[1].len   = len;
> +	msgs[1].buf   = buf;
> +
> +	ret = i2c_transfer(client->adapter, msgs, 2);
> +	return ret < 0 ? ret : (ret != ARRAY_SIZE(msgs) ? -EIO : 0);
> +}
> +
> +/**
> + * goodix_i2c_write - write data to the i2c slave device.
> + *
> + * @client: i2c device.
> + * @reg: the register to read to.
> + * @buf: raw write data buffer.
> + * @len: length of the buffer to write
> + */
> +static int goodix_i2c_write(struct i2c_client *client,
> +				u16 reg, u8 *buf, int len)
> +{
> +	struct i2c_msg msg;
> +	int ret;
> +	u8 *wbuf;
> +	u16 *addr;
> +
> +	wbuf = kzalloc(len + 2, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	addr = ((u16 *) &wbuf[0]);
> +	*addr = cpu_to_be16(reg);
> +	memcpy(&wbuf[2], buf, len);
> +
> +	msg.flags = 0;
> +	msg.addr  = client->addr;
> +	msg.len   = len + 2;
> +	msg.buf   = wbuf;
> +
> +	ret = i2c_transfer(client->adapter, &msg, 1);
> +	kfree(wbuf);
> +	return ret < 0 ? ret : (ret != 1 ? -EIO : 0);
> +}
> +
> +static int goodix_ts_read_input_report(struct goodix_ts_data *ts, u8 *data)
> +{
> +	int touch_num;
> +	int ret;
> +
> +	ret = goodix_i2c_read(ts->client, GOODIX_READ_COOR_ADDR, data, 10);
> +	if (ret < 0) {
> +		dev_err(&ts->client->dev, "I2C transfer error (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	touch_num = data[0] & 0x0f;
> +	if (touch_num > GOODIX_MAX_TOUCH)
> +		return -EPROTO;
> +
> +	if (touch_num > 1) {
> +		ret = goodix_i2c_read(ts->client, GOODIX_READ_COOR_ADDR + 10,
> +				   &data[10], 8 * (touch_num - 1));
> +		if (ret < 0)
> +			return ret;
> +	}

I am a bit confused about this function. It looks like contact packet
size is 8 bytes, and they preceded by a byte with total number of
contacts reported, so why instead of 9 bytes we are reading 10?

> +
> +	return touch_num;
> +}
> +
> +static void goodix_ts_parse_touch(struct goodix_ts_data *ts, u8 *coor_data)
> +{
> +	int id = coor_data[0] & 0x0F;
> +	int input_x = get_unaligned_le16(&coor_data[1]);
> +	int input_y = get_unaligned_le16(&coor_data[3]);
> +	int input_w = get_unaligned_le16(&coor_data[5]);
> +
> +	input_mt_slot(ts->input_dev, id);
> +	input_mt_report_slot_state(ts->input_dev, MT_TOOL_FINGER, true);
> +	input_report_abs(ts->input_dev, ABS_MT_POSITION_X, input_x);
> +	input_report_abs(ts->input_dev, ABS_MT_POSITION_Y, input_y);
> +	input_report_abs(ts->input_dev, ABS_MT_TOUCH_MAJOR, input_w);
> +	input_report_abs(ts->input_dev, ABS_MT_WIDTH_MAJOR, input_w);
> +}
> +
> +/**
> + * goodix_process_events - Process incoming events
> + *
> + * @ts: our goodix_ts_data pointer
> + *
> + * Called when the IRQ is triggered. Read the current device state, and push
> + * the input events to the user space.
> + */
> +static void goodix_process_events(struct goodix_ts_data *ts)
> +{
> +	u8  point_data[1 + 8 * GOODIX_MAX_TOUCH + 1];

Here again, why do we need extra byte?

> +	int touch_num;
> +	int i;
> +
> +	touch_num = goodix_ts_read_input_report(ts, point_data);
> +	if (touch_num < 0)
> +		return;
> +
> +	for (i = 0; i < touch_num; i++)
> +		goodix_ts_parse_touch(ts, &point_data[1 + 8 * i]);
> +
> +	input_mt_sync_frame(ts->input_dev);
> +	input_sync(ts->input_dev);
> +}
> +
> +/**
> + * goodix_ts_irq_handler - The IRQ handler
> + *
> + * @irq: interrupt number.
> + * @dev_id: private data pointer.
> + */
> +static irqreturn_t goodix_ts_irq_handler(int irq, void *dev_id)
> +{
> +	struct goodix_ts_data *ts = dev_id;
> +	u8  end_cmd[1] = {0};
> +
> +	goodix_process_events(ts);
> +
> +	if (goodix_i2c_write(ts->client,
> +				GOODIX_READ_COOR_ADDR, end_cmd, 1) < 0)
> +		dev_err(&ts->client->dev, "I2C write end_cmd error");

I am not happy that we need to allocate/deallocate memory for each
interrupt. We only write one command to the driver, we could simply use
i2c_master_send() with a constant buffer.

BTW, you need terminate kernel messages with \n.

Also, below is a patch with a few assorted changes that I'd like you to
try if you have time.

Thanks!

-- 
Dmitry


Input: goodix - random changes

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/goodix.c |  208 ++++++++++++++++--------------------
 1 file changed, 91 insertions(+), 117 deletions(-)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index fd02b5e..1c2131c 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -37,11 +37,12 @@ struct goodix_ts_data {
 #define GOODIX_MAX_HEIGHT		4096
 #define GOODIX_MAX_WIDTH		4096
 #define GOODIX_INT_TRIGGER		1
-#define GOODIX_MAX_TOUCH		10
+#define GOODIX_CONTACT_SIZE		8
+#define GOODIX_MAX_CONTACTS		10
 
 #define GOODIX_CONFIG_MAX_LENGTH	240
 
-/* Register defineS */
+/* Register defines */
 #define GOODIX_READ_COOR_ADDR		0x814E
 #define GOODIX_REG_CONFIG_DATA		0x8047
 #define GOODIX_REG_VERSION		0x8140
@@ -49,7 +50,6 @@ struct goodix_ts_data {
 #define RESOLUTION_LOC		1
 #define TRIGGER_LOC		6
 
-static const char *goodix_ts_name = "Goodix Capacitive TouchScreen";
 static const unsigned long goodix_irq_flags[] = {
 	IRQ_TYPE_EDGE_RISING,
 	IRQ_TYPE_EDGE_FALLING,
@@ -86,66 +86,38 @@ static int goodix_i2c_read(struct i2c_client *client,
 	return ret < 0 ? ret : (ret != ARRAY_SIZE(msgs) ? -EIO : 0);
 }
 
-/**
- * goodix_i2c_write - write data to the i2c slave device.
- *
- * @client: i2c device.
- * @reg: the register to read to.
- * @buf: raw write data buffer.
- * @len: length of the buffer to write
- */
-static int goodix_i2c_write(struct i2c_client *client,
-				u16 reg, u8 *buf, int len)
-{
-	struct i2c_msg msg;
-	int ret;
-	u8 *wbuf;
-	u16 *addr;
-
-	wbuf = kzalloc(len + 2, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	addr = ((u16 *) &wbuf[0]);
-	*addr = cpu_to_be16(reg);
-	memcpy(&wbuf[2], buf, len);
-
-	msg.flags = 0;
-	msg.addr  = client->addr;
-	msg.len   = len + 2;
-	msg.buf   = wbuf;
-
-	ret = i2c_transfer(client->adapter, &msg, 1);
-	kfree(wbuf);
-	return ret < 0 ? ret : (ret != 1 ? -EIO : 0);
-}
-
 static int goodix_ts_read_input_report(struct goodix_ts_data *ts, u8 *data)
 {
 	int touch_num;
-	int ret;
+	int error;
 
-	ret = goodix_i2c_read(ts->client, GOODIX_READ_COOR_ADDR, data, 10);
-	if (ret < 0) {
-		dev_err(&ts->client->dev, "I2C transfer error (%d)\n", ret);
-		return ret;
+	/* XXX should we read GOODIX_CONTACT_SIZE + 1 (i.e. 9) instead of 10? */
+	error = goodix_i2c_read(ts->client, GOODIX_READ_COOR_ADDR, data, 10);
+	if (error) {
+		dev_err(&ts->client->dev, "I2C transfer error: %d\n", error);
+		return error;
 	}
 
 	touch_num = data[0] & 0x0f;
-	if (touch_num > GOODIX_MAX_TOUCH)
+	if (touch_num > GOODIX_MAX_CONTACTS)
 		return -EPROTO;
 
 	if (touch_num > 1) {
-		ret = goodix_i2c_read(ts->client, GOODIX_READ_COOR_ADDR + 10,
-				   &data[10], 8 * (touch_num - 1));
-		if (ret < 0)
-			return ret;
+		data += 10;
+		// data += GOODIX_CONTACT_SIZE + 1
+		error = goodix_i2c_read(ts->client,
+					GOODIX_READ_COOR_ADDR + 10,
+					// GOODIX_READ_COOR_ADDR + 1 + GOODIX_CONTACT_SIZE ???
+					data,
+					GOODIX_CONTACT_SIZE * (touch_num - 1));
+		if (error)
+			return error;
 	}
 
 	return touch_num;
 }
 
-static void goodix_ts_parse_touch(struct goodix_ts_data *ts, u8 *coor_data)
+static void goodix_ts_report_touch(struct goodix_ts_data *ts, u8 *coor_data)
 {
 	int id = coor_data[0] & 0x0F;
 	int input_x = get_unaligned_le16(&coor_data[1]);
@@ -170,7 +142,8 @@ static void goodix_ts_parse_touch(struct goodix_ts_data *ts, u8 *coor_data)
  */
 static void goodix_process_events(struct goodix_ts_data *ts)
 {
-	u8  point_data[1 + 8 * GOODIX_MAX_TOUCH + 1];
+	// XXX why extra +1 ?
+	u8  point_data[1 + GOODIX_CONTACT_SIZE * GOODIX_MAX_CONTACTS + 1];
 	int touch_num;
 	int i;
 
@@ -179,7 +152,8 @@ static void goodix_process_events(struct goodix_ts_data *ts)
 		return;
 
 	for (i = 0; i < touch_num; i++)
-		goodix_ts_parse_touch(ts, &point_data[1 + 8 * i]);
+		goodix_ts_report_touch(ts,
+				&point_data[1 + GOODIX_CONTACT_SIZE * i]);
 
 	input_mt_sync_frame(ts->input_dev);
 	input_sync(ts->input_dev);
@@ -193,13 +167,16 @@ static void goodix_process_events(struct goodix_ts_data *ts)
  */
 static irqreturn_t goodix_ts_irq_handler(int irq, void *dev_id)
 {
+	static const u8 end_cmd[] = {
+		GOODIX_READ_COOR_ADDR & 0xff,
+		GOODIX_READ_COOR_ADDR >> 8,
+		0
+	};
 	struct goodix_ts_data *ts = dev_id;
-	u8  end_cmd[1] = {0};
 
 	goodix_process_events(ts);
 
-	if (goodix_i2c_write(ts->client,
-				GOODIX_READ_COOR_ADDR, end_cmd, 1) < 0)
+	if (i2c_master_send(ts->client, end_cmd, sizeof(end_cmd)) < 0)
 		dev_err(&ts->client->dev, "I2C write end_cmd error");
 
 	return IRQ_HANDLED;
@@ -214,14 +191,16 @@ static irqreturn_t goodix_ts_irq_handler(int irq, void *dev_id)
  */
 static void goodix_read_config(struct goodix_ts_data *ts)
 {
-	int ret;
 	u8 config[GOODIX_CONFIG_MAX_LENGTH];
+	int error;
 
-	ret = goodix_i2c_read(ts->client, GOODIX_REG_CONFIG_DATA, config,
+	error = goodix_i2c_read(ts->client, GOODIX_REG_CONFIG_DATA,
+			      config,
 			   GOODIX_CONFIG_MAX_LENGTH);
-	if (ret < 0) {
-		dev_err(&ts->client->dev,
-			"Error reading config, use default value!");
+	if (error) {
+		dev_warn(&ts->client->dev,
+			 "Error reading config (%d), using defaults\n",
+			 error);
 		ts->abs_x_max = GOODIX_MAX_WIDTH;
 		ts->abs_y_max = GOODIX_MAX_HEIGHT;
 		ts->int_trigger_type = GOODIX_INT_TRIGGER;
@@ -231,9 +210,9 @@ static void goodix_read_config(struct goodix_ts_data *ts)
 	ts->abs_x_max = get_unaligned_le16(&config[RESOLUTION_LOC]);
 	ts->abs_y_max = get_unaligned_le16(&config[RESOLUTION_LOC + 2]);
 	ts->int_trigger_type = (config[TRIGGER_LOC]) & 0x03;
-	if ((!ts->abs_x_max) || (!ts->abs_y_max)) {
+	if (!ts->abs_x_max || !ts->abs_y_max) {
 		dev_err(&ts->client->dev,
-			"Invalid config, use default value!");
+			"Invalid config, using defaults\n");
 		ts->abs_x_max = GOODIX_MAX_WIDTH;
 		ts->abs_y_max = GOODIX_MAX_HEIGHT;
 	}
@@ -248,13 +227,13 @@ static void goodix_read_config(struct goodix_ts_data *ts)
  */
 static int goodix_read_version(struct i2c_client *client, u16 *version)
 {
-	int ret;
+	int error;
 	u8 buf[6];
 
-	ret = goodix_i2c_read(client, GOODIX_REG_VERSION, buf, sizeof(buf));
-	if (ret < 0) {
-		dev_err(&client->dev, "read version failed");
-		return ret;
+	error = goodix_i2c_read(client, GOODIX_REG_VERSION, buf, sizeof(buf));
+	if (error) {
+		dev_err(&client->dev, "read version failed: %d\n", error);
+		return error;
 	}
 
 	if (version)
@@ -262,7 +241,7 @@ static int goodix_read_version(struct i2c_client *client, u16 *version)
 
 	dev_info(&client->dev, "IC VERSION: %6ph", buf);
 
-	return ret;
+	return 0;
 }
 
 /**
@@ -272,20 +251,22 @@ static int goodix_read_version(struct i2c_client *client, u16 *version)
  */
 static int goodix_i2c_test(struct i2c_client *client)
 {
-	u8 test;
-	int ret;
 	int retry = 0;
+	int error;
+	u8 test;
 
 	while (retry++ < 2) {
-		ret = goodix_i2c_read(client, GOODIX_REG_CONFIG_DATA,
-				      &test, 1);
-		if (ret >= 0)
-			return ret;
+		error = goodix_i2c_read(client, GOODIX_REG_CONFIG_DATA,
+					&test, 1);
+		if (!error)
+			return 0;
 
-		dev_err(&client->dev, "i2c test failed time %d.", retry);
+		dev_err(&client->dev, "i2c test failed attempt %d: %d\n",
+			retry, error);
 		msleep(20);
 	}
-	return ret;
+
+	return error;
 }
 
 /**
@@ -297,7 +278,7 @@ static int goodix_i2c_test(struct i2c_client *client)
  */
 static int goodix_request_input_dev(struct goodix_ts_data *ts)
 {
-	int ret;
+	int error;
 
 	ts->input_dev = devm_input_allocate_device(&ts->client->dev);
 	if (!ts->input_dev) {
@@ -316,79 +297,73 @@ static int goodix_request_input_dev(struct goodix_ts_data *ts)
 	input_set_abs_params(ts->input_dev, ABS_MT_WIDTH_MAJOR, 0, 255, 0, 0);
 	input_set_abs_params(ts->input_dev, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
 
-	input_mt_init_slots(ts->input_dev, GOODIX_MAX_TOUCH,
+	input_mt_init_slots(ts->input_dev, GOODIX_MAX_CONTACTS,
 			    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
 
-	ts->input_dev->name = goodix_ts_name;
+	ts->input_dev->name = "Goodix Capacitive TouchScreen";
 	ts->input_dev->phys = "input/ts";
 	ts->input_dev->id.bustype = BUS_I2C;
 	ts->input_dev->id.vendor = 0x0416;
 	ts->input_dev->id.product = 0x1001;
 	ts->input_dev->id.version = 10427;
 
-	ret = input_register_device(ts->input_dev);
-	if (ret) {
-		dev_err(&ts->client->dev, "Failed to register %s input device",
-			  ts->input_dev->name);
-		return ret;
+	error = input_register_device(ts->input_dev);
+	if (error) {
+		dev_err(&ts->client->dev,
+			"Failed to register input device: %d", error);
+		return error;
 	}
 
 	return 0;
 }
 
 static int goodix_ts_probe(struct i2c_client *client,
-		const struct i2c_device_id *id)
+			   const struct i2c_device_id *id)
 {
-	int ret;
 	struct goodix_ts_data *ts;
+	unsigned long irq_flags;
+	int error;
 	u16 version_info;
 
-	dev_info(&client->dev, "I2C Address: 0x%02x", client->addr);
+	dev_dbg(&client->dev, "I2C Address: 0x%02x", client->addr);
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
-		dev_err(&client->dev, "I2C check functionality failed.");
-		return -ENODEV;
+		dev_err(&client->dev, "I2C check functionality failed.\n");
+		return -ENXIO;
 	}
+
 	ts = devm_kzalloc(&client->dev, sizeof(*ts), GFP_KERNEL);
-	if (!ts) {
-		dev_err(&client->dev, "Alloc GFP_KERNEL memory failed.");
+	if (!ts)
 		return -ENOMEM;
-	}
 
 	ts->client = client;
 	i2c_set_clientdata(client, ts);
 
-	ret = goodix_i2c_test(client);
-	if (ret < 0) {
-		dev_err(&client->dev, "I2C communication ERROR!");
-		return ret;
+	error = goodix_i2c_test(client);
+	if (error) {
+		dev_err(&client->dev, "I2C communication failure: %d\n", error);
+		return error;
 	}
 
-	goodix_read_config(ts);
-
-	ret = goodix_request_input_dev(ts);
-	if (ret < 0) {
-		dev_err(&client->dev, "request input dev failed");
-		return ret;
+	error = goodix_read_version(client, &version_info);
+	if (error) {
+		dev_err(&client->dev, "Read version failed.");
+		return error;
 	}
 
-	ret = devm_request_threaded_irq(&ts->client->dev,
-					ts->client->irq, NULL,
-					goodix_ts_irq_handler,
-					goodix_irq_flags[ts->int_trigger_type]
-						| IRQF_ONESHOT,
-					ts->client->name,
-					ts);
-	if (ret < 0) {
-		dev_err(&ts->client->dev,
-			"Request IRQ failed! ERRNO: %d.", ret);
-		return ret;
-	}
+	goodix_read_config(ts);
 
-	ret = goodix_read_version(client, &version_info);
-	if (ret < 0) {
-		dev_err(&client->dev, "Read version failed.");
-		return ret;
+	error = goodix_request_input_dev(ts);
+	if (error)
+		return error;
+
+	irq_flags = goodix_irq_flags[ts->int_trigger_type] | IRQF_ONESHOT;
+	error = devm_request_threaded_irq(&ts->client->dev, client->irq,
+					  NULL, goodix_ts_irq_handler,
+					  irq_flags, client->name, ts);
+	if (error) {
+		dev_err(&client->dev, "request IRQ failed: %d.", error);
+		return error;
 	}
 
 	return 0;
@@ -414,7 +389,6 @@ static struct i2c_driver goodix_ts_driver = {
 		.acpi_match_table = goodix_acpi_match,
 	},
 };
-
 module_i2c_driver(goodix_ts_driver);
 
 MODULE_AUTHOR("Benjamin Tissoires <benjamin.tissoires@gmail.com>");
