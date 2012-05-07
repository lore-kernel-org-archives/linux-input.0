From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Touchscreen driver for FT5x06 based EDT displays
Date: Sun, 6 May 2012 23:57:24 -0700
Message-ID: <20120507065724.GA22074@core.coreip.homeip.net>
References: <1331050527-4902-1-git-send-email-simon.budig@kernelconcepts.de>
 <1333564079-23893-1-git-send-email-simon.budig@kernelconcepts.de>
 <1333564079-23893-2-git-send-email-simon.budig@kernelconcepts.de>
 <20120404191043.GA11042@core.coreip.homeip.net>
 <4F7D95FA.2050800@kernelconcepts.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:41859 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753105Ab2EGG5e (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 May 2012 02:57:34 -0400
Received: by dady13 with SMTP id y13so884626dad.19
        for <linux-input@vger.kernel.org>; Sun, 06 May 2012 23:57:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4F7D95FA.2050800@kernelconcepts.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Budig <simon.budig@kernelconcepts.de>
Cc: linux-input@vger.kernel.org, agust@denx.de, yanok@emcraft.com

Hi Simon,

On Thu, Apr 05, 2012 at 02:54:18PM +0200, Simon Budig wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 04/04/2012 09:10 PM, Dmitry Torokhov wrote:
> [suggestions for my patch]
> 
> Based on your input I have prepared two patches which might be easier to
> review than the complete diff.
> 
> The first one is IMHO pretty straightforward and implements most of the
> small bits.
> 
> The second one sits on top of the first one and is an attempt at more
> generic attribute handling. I must say that I am not too happy about it,
> but maybe I am thinking too convoluted here. It saves about 3 lines of
> code and exchanges a lot of easy and straightforward code with stuff
> that is harder to follow - especially the lookup of the matching
> attribute makes me unhappy. There are bits in it I like and will
> probably use. But the lookup...
> 
> any suggestions are welcome.

Sorry for the long delay. I agree that the new version of attribute
handling code is not any better than previous one, and this is not what
I had in mind.

Below is a patch on top of your original one plus the
first patch you send in the last email. It implements the attribute
handling the way I see it and also has some additional changes. Could
you please give it a spin and let me know if the device still works?

Thanks.

-- 
Dmitry


Input: miscellaneous edt fixes

- reworked attribute handling
- remove fake ABS_PRESSURE
- locking - take mutex on sysfs operations; disable interrupts
  when switching mode to factory. Do not take mutex in interrupt;
  rely on I2C code to provide necessary locking.
- do not carry around reset pin gpio.
- use gpio_request_one()
- use IRQ from client structure.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/touchscreen/edt-ft5x06.c |  889 +++++++++++++++++---------------
 1 files changed, 461 insertions(+), 428 deletions(-)


diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index edd7f9f..acd00ba 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -30,29 +30,30 @@
 #include <linux/uaccess.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
-
 #include <linux/gpio.h>
-
 #include <linux/input/edt-ft5x06.h>
 
 #define DRIVER_VERSION "v0.5"
 
-#define WORK_REGISTER_THRESHOLD   0x00
-#define WORK_REGISTER_REPORT_RATE 0x08
-#define WORK_REGISTER_GAIN        0x30
-#define WORK_REGISTER_OFFSET      0x31
-#define WORK_REGISTER_NUM_X       0x33
-#define WORK_REGISTER_NUM_Y       0x34
+#define WORK_REGISTER_THRESHOLD		0x00
+#define WORK_REGISTER_REPORT_RATE	0x08
+#define WORK_REGISTER_GAIN		0x30
+#define WORK_REGISTER_OFFSET		0x31
+#define WORK_REGISTER_NUM_X		0x33
+#define WORK_REGISTER_NUM_Y		0x34
 
-#define WORK_REGISTER_OPMODE      0x3c
-#define FACTORY_REGISTER_OPMODE   0x01
+#define WORK_REGISTER_OPMODE		0x3c
+#define FACTORY_REGISTER_OPMODE		0x01
+
+#define EDT_NAME_LEN			23
+#define EDT_SWITCH_MODE_RETRIES		10
+#define EDT_SWITCH_MODE_DELAY		5 /* msec */
+#define EDT_RAW_DATA_RETRIES		100
+#define EDT_RAW_DATA_DELAY		1 /* msec */
 
 struct edt_ft5x06_i2c_ts_data {
 	struct i2c_client *client;
 	struct input_dev *input;
-	int irq;
-	int irq_pin;
-	int reset_pin;
 	int num_x;
 	int num_y;
 
@@ -62,7 +63,8 @@ struct edt_ft5x06_i2c_ts_data {
 	int gain;
 	int offset;
 	int report_rate;
-	char name[24];
+
+	char name[EDT_NAME_LEN];
 };
 
 static int edt_ft5x06_ts_readwrite(struct i2c_client *client,
@@ -70,7 +72,8 @@ static int edt_ft5x06_ts_readwrite(struct i2c_client *client,
                                    u16 rd_len, u8 *rd_buf)
 {
 	struct i2c_msg wrmsg[2];
-	int i, ret;
+	int i = 0;
+	int ret;
 
 	i = 0;
 	if (wr_len) {
@@ -89,544 +92,594 @@ static int edt_ft5x06_ts_readwrite(struct i2c_client *client,
 	}
 
 	ret = i2c_transfer(client->adapter, wrmsg, i);
-	if (ret < 0) {
-		dev_err(&client->dev, "i2c_transfer failed: %d\n", ret);
+	if (ret < 0)
 		return ret;
-	}
+	if (ret != i)
+		return -EIO;
 
-	return ret;
+	return 0;
 }
 
-
 static irqreturn_t edt_ft5x06_ts_isr(int irq, void *dev_id)
 {
 	struct edt_ft5x06_i2c_ts_data *tsdata = dev_id;
-	unsigned char touching = 0;
-	unsigned char rdbuf[26], wrbuf[1];
-	int i, have_abs, type, x, y, id, ret;
+	u8 num_touching;
+	u8 cmd = 0xf9;
+	u8 rdbuf[26];
+	bool have_abs = false;
+	int i, type, x, y, id;
+	int error;
 
-	memset(wrbuf, 0, sizeof(wrbuf));
 	memset(rdbuf, 0, sizeof(rdbuf));
 
-	wrbuf[0] = 0xf9;
-
-	mutex_lock(&tsdata->mutex);
-	ret = edt_ft5x06_ts_readwrite(tsdata->client,
-	                              1, wrbuf,
-	                              sizeof(rdbuf), rdbuf);
-	mutex_unlock(&tsdata->mutex);
-	if (ret < 0) {
+	error = edt_ft5x06_ts_readwrite(tsdata->client,
+					sizeof(cmd), &cmd,
+					sizeof(rdbuf), rdbuf);
+	if (error) {
 		dev_err(&tsdata->client->dev,
-		        "Unable to write to i2c touchscreen!\n");
+			"Unable to write to fetch data, error: %d\n", error);
 		goto out;
 	}
 
 	if (rdbuf[0] != 0xaa || rdbuf[1] != 0xaa || rdbuf[2] != 26) {
 		dev_err(&tsdata->client->dev,
-		        "Unexpected header: %02x%02x%02x!\n",
-		        rdbuf[0], rdbuf[1], rdbuf[2]);
+			"Unexpected header: %02x%02x%02x!\n",
+			rdbuf[0], rdbuf[1], rdbuf[2]);
+		goto out;
 	}
 
-	have_abs = false;
-	touching = rdbuf[3];
-	for (i = 0; i < touching; i++) {
-		type = rdbuf[i*4+5] >> 6;
+	num_touching = rdbuf[3];
+	for (i = 0; i < num_touching; i++) {
+		u8 *buf = &rdbuf[i * 4];
+
+		type = buf[5] >> 6;
 		/* ignore Touch Down and Reserved events */
 		if (type == 0x01 || type == 0x03)
 			continue;
 
-		x = ((rdbuf[i*4+5] << 8) | rdbuf[i*4+6]) & 0x0fff;
-		y = ((rdbuf[i*4+7] << 8) | rdbuf[i*4+8]) & 0x0fff;
-		id = (rdbuf[i*4+7] >> 4) & 0x0f;
+		x = ((buf[5] << 8) | rdbuf[6]) & 0x0fff;
+		y = ((buf[7] << 8) | rdbuf[8]) & 0x0fff;
+		id = (buf[7] >> 4) & 0x0f;
 
 		if (!have_abs) {
-			input_report_key(tsdata->input, BTN_TOUCH,    1);
-			input_report_abs(tsdata->input, ABS_PRESSURE, 1);
-			input_report_abs(tsdata->input, ABS_X,        x);
-			input_report_abs(tsdata->input, ABS_Y,        y);
+			input_report_key(tsdata->input, BTN_TOUCH, 1);
+			input_report_abs(tsdata->input, ABS_X, x);
+			input_report_abs(tsdata->input, ABS_Y, y);
 			have_abs = true;
 		}
+
 		input_report_abs(tsdata->input, ABS_MT_POSITION_X, x);
 		input_report_abs(tsdata->input, ABS_MT_POSITION_Y, y);
 		input_report_abs(tsdata->input, ABS_MT_TRACKING_ID, id);
 		input_mt_sync(tsdata->input);
 	}
-	if (!have_abs) {
-		input_report_key(tsdata->input, BTN_TOUCH,    0);
-		input_report_abs(tsdata->input, ABS_PRESSURE, 0);
-	}
+
+	if (!have_abs)
+		input_report_key(tsdata->input, BTN_TOUCH, 0);
+
 	input_sync(tsdata->input);
 
 out:
 	return IRQ_HANDLED;
 }
 
-
 static int edt_ft5x06_i2c_register_write(struct edt_ft5x06_i2c_ts_data *tsdata,
-                                         u8 addr, u8 value)
+					 u8 addr, u8 value)
 {
 	u8 wrbuf[4];
-	int ret;
-
-	wrbuf[0]  = tsdata->factory_mode ? 0xf3 : 0xfc;
-	wrbuf[1]  = tsdata->factory_mode ? addr & 0x7f : addr & 0x3f;
-	wrbuf[2]  = value;
-	wrbuf[3]  = wrbuf[0] ^ wrbuf[1] ^ wrbuf[2];
-
-	disable_irq(tsdata->irq);
-
-	ret = edt_ft5x06_ts_readwrite(tsdata->client,
-	                              4, wrbuf,
-	                              0, NULL);
 
-	enable_irq(tsdata->irq);
+	wrbuf[0] = tsdata->factory_mode ? 0xf3 : 0xfc;
+	wrbuf[1] = tsdata->factory_mode ? addr & 0x7f : addr & 0x3f;
+	wrbuf[2] = value;
+	wrbuf[3] = wrbuf[0] ^ wrbuf[1] ^ wrbuf[2];
 
-	return ret;
+	return edt_ft5x06_ts_readwrite(tsdata->client, 4, wrbuf, 0, NULL);
 }
 
 static int edt_ft5x06_i2c_register_read(struct edt_ft5x06_i2c_ts_data *tsdata,
                                         u8 addr)
 {
 	u8 wrbuf[2], rdbuf[2];
-	int ret;
+	int error;
 
-	wrbuf[0]  = tsdata->factory_mode ? 0xf3 : 0xfc;
-	wrbuf[1]  = tsdata->factory_mode ? addr & 0x7f : addr & 0x3f;
+	wrbuf[0] = tsdata->factory_mode ? 0xf3 : 0xfc;
+	wrbuf[1] = tsdata->factory_mode ? addr & 0x7f : addr & 0x3f;
 	wrbuf[1] |= tsdata->factory_mode ? 0x80 : 0x40;
 
-	disable_irq(tsdata->irq);
-
-	ret = edt_ft5x06_ts_readwrite(tsdata->client,
-	                              2, wrbuf,
-	                              2, rdbuf);
-
-	enable_irq(tsdata->irq);
+	error = edt_ft5x06_ts_readwrite(tsdata->client, 2, wrbuf, 2, rdbuf);
+	if (error)
+		return error;
 
-	if ((wrbuf[0] ^ wrbuf[1] ^ rdbuf[0]) != rdbuf[1])
+	if ((wrbuf[0] ^ wrbuf[1] ^ rdbuf[0]) != rdbuf[1]) {
 		dev_err(&tsdata->client->dev,
-		        "crc error: 0x%02x expected, got 0x%02x\n",
-		        (wrbuf[0] ^ wrbuf[1] ^ rdbuf[0]), rdbuf[1]);
+			"crc error: 0x%02x expected, got 0x%02x\n",
+			wrbuf[0] ^ wrbuf[1] ^ rdbuf[0], rdbuf[1]);
+		return -EIO;
+	}
 
-	return ret < 0 ? ret : rdbuf[0];
+	return rdbuf[0];
 }
 
-static ssize_t edt_ft5x06_i2c_setting_show(struct device *dev,
-                                           struct device_attribute *attr,
-                                           char *buf)
-{
-	struct edt_ft5x06_i2c_ts_data *tsdata = dev_get_drvdata(dev);
-	struct i2c_client *client = tsdata->client;
-	int ret = 0;
-	int *value;
+struct edt_ft5x06_attribute {
+	struct device_attribute dattr;
+	size_t field_offset;
+	u8 limit_low;
+	u8 limit_high;
 	u8 addr;
+};
 
-	switch (attr->attr.name[0]) {
-	case 't':    /* threshold */
-		addr = WORK_REGISTER_THRESHOLD;
-		value = &tsdata->threshold;
-		break;
-	case 'g':    /* gain */
-		addr = WORK_REGISTER_GAIN;
-		value = &tsdata->gain;
-		break;
-	case 'o':    /* offset */
-		addr = WORK_REGISTER_OFFSET;
-		value = &tsdata->offset;
-		break;
-	case 'r':    /* report rate */
-		addr = WORK_REGISTER_REPORT_RATE;
-		value = &tsdata->report_rate;
-		break;
-	default:
-		dev_err(&client->dev,
-		        "unknown attribute for edt_ft5x06_i2c_setting_show: %s\n",
-		        attr->attr.name);
-		return -EINVAL;
+#define EDT_ATTR(_field, _mode, _addr, _limit_low, _limit_high)		\
+	struct edt_ft5x06_attribute edt_ft5x06_attr_##_field = {	\
+		.dattr = __ATTR(_field, _mode,				\
+				edt_ft5x06_i2c_setting_show,		\
+				edt_ft5x06_i2c_setting_store),		\
+		.field_offset =						\
+			offsetof(struct edt_ft5x06_i2c_ts_data, _field),\
+		.limit_low = _limit_low,				\
+		.limit_high = _limit_high,				\
+		.addr = _addr,						\
 	}
 
+static ssize_t edt_ft5x06_i2c_setting_show(struct device *dev,
+                                           struct device_attribute *dattr,
+                                           char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct edt_ft5x06_i2c_ts_data *tsdata = i2c_get_clientdata(client);
+	struct edt_ft5x06_attribute *attr =
+			container_of(dattr, struct edt_ft5x06_attribute, dattr);
+	u8 *field = (u8 *)((char *)tsdata + attr->field_offset);
+	int val;
+	size_t count;
+	int error = 0;
+
 	mutex_lock(&tsdata->mutex);
 
 	if (tsdata->factory_mode) {
-		dev_err(dev,
-		        "setting register not available in factory mode\n");
-		mutex_unlock(&tsdata->mutex);
-		return -EIO;
+		error = -EIO;
+		goto out;
 	}
 
-	ret = edt_ft5x06_i2c_register_read(tsdata, addr);
-	if (ret < 0) {
+	val = edt_ft5x06_i2c_register_read(tsdata, attr->addr);
+	if (val < 0) {
+		error = val;
 		dev_err(&tsdata->client->dev,
-		        "Unable to write to i2c touchscreen!\n");
-		mutex_unlock(&tsdata->mutex);
-		return ret;
+			"Failed to fetch attribute %s, error %d\n",
+			dattr->attr.name, error);
+		goto out;
 	}
-	mutex_unlock(&tsdata->mutex);
 
-	if (ret != *value) {
-		dev_info(&tsdata->client->dev,
-		         "i2c read (%d) and stored value (%d) differ. Huh?\n",
-		         ret, *value);
-		*value = ret;
+	if (val != *field) {
+		dev_warn(&tsdata->client->dev,
+			 "%s: read (%d) and stored value (%d) differ\n",
+			 dattr->attr.name, val, *field);
+		*field = val;
 	}
 
-	return sprintf(buf, "%d\n", ret);
+	count = scnprintf(buf, PAGE_SIZE, "%d\n", val);
+out:
+	mutex_unlock(&tsdata->mutex);
+	return error ?: count;
 }
 
 static ssize_t edt_ft5x06_i2c_setting_store(struct device *dev,
-                                            struct device_attribute *attr,
-                                            const char *buf, size_t count)
+					    struct device_attribute *dattr,
+					    const char *buf, size_t count)
 {
-	struct edt_ft5x06_i2c_ts_data *tsdata = dev_get_drvdata(dev);
-	struct i2c_client *client = tsdata->client;
-	int ret = 0;
-	u8 addr;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct edt_ft5x06_i2c_ts_data *tsdata = i2c_get_clientdata(client);
+	struct edt_ft5x06_attribute *attr =
+			container_of(dattr, struct edt_ft5x06_attribute, dattr);
+	u8 *field = (u8 *)((char *)tsdata + attr->field_offset);
 	unsigned int val;
+	int error;
 
 	mutex_lock(&tsdata->mutex);
 
 	if (tsdata->factory_mode) {
-		dev_err(dev,
-		        "setting register not available in factory mode\n");
-		ret = -EIO;
+		error = -EIO;
 		goto out;
 	}
 
-	if (sscanf(buf, "%u", &val) != 1) {
-		dev_err(dev, "Invalid value for attribute %s\n",
-		        attr->attr.name);
-		ret = -EINVAL;
+	error = kstrtouint(buf, 0, &val);
+	if (error)
 		goto out;
-	}
 
-	switch (attr->attr.name[0]) {
-	case 't':    /* threshold */
-		addr = WORK_REGISTER_THRESHOLD;
-		val = val < 20 ? 20 : val > 80 ? 80 : val;
-		tsdata->threshold = val;
-		break;
-	case 'g':    /* gain */
-		addr = WORK_REGISTER_GAIN;
-		val = val < 0 ? 0 : val > 31 ? 31 : val;
-		tsdata->gain = val;
-		break;
-	case 'o':    /* offset */
-		addr = WORK_REGISTER_OFFSET;
-		val = val < 0 ? 0 : val > 31 ? 31 : val;
-		tsdata->offset = val;
-		break;
-	case 'r':    /* report rate */
-		addr = WORK_REGISTER_REPORT_RATE;
-		val = val < 3 ? 3 : val > 14 ? 14 : val;
-		tsdata->report_rate = val;
-		break;
-	default:
-		dev_err(&client->dev,
-		        "unknown attribute for edt_ft5x06_i2c_setting_show: %s\n",
-		        attr->attr.name);
-		ret = -EINVAL;
+	if (val < attr->limit_low || val > attr->limit_high) {
+		error = -ERANGE;
 		goto out;
 	}
 
-	ret = edt_ft5x06_i2c_register_write(tsdata, addr, val);
-
-	if (ret < 0) {
+	error = edt_ft5x06_i2c_register_write(tsdata, attr->addr, val);
+	if (error) {
 		dev_err(&tsdata->client->dev,
-		        "Unable to write to i2c touchscreen!\n");
+			"Failed to update attribute %s, error: %d\n",
+			dattr->attr.name, error);
 		goto out;
 	}
 
+	*field = val;
+
 out:
 	mutex_unlock(&tsdata->mutex);
-	return ret < 0 ? ret : count;
+	return error ?: count;
 }
 
-
 static ssize_t edt_ft5x06_i2c_mode_show(struct device *dev,
-                                        struct device_attribute *attr,
-                                        char *buf)
+					struct device_attribute *attr,
+					char *buf)
 {
-	struct edt_ft5x06_i2c_ts_data *tsdata = dev_get_drvdata(dev);
-	return sprintf(buf, "%d\n", tsdata->factory_mode ? 1 : 0);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct edt_ft5x06_i2c_ts_data *tsdata = i2c_get_clientdata(client);
+
+	return sprintf(buf, "%d\n", tsdata->factory_mode);
+}
+
+static int edt_ft5x06_i2c_factory_mode(struct edt_ft5x06_i2c_ts_data *tsdata)
+{
+	int retries = EDT_SWITCH_MODE_RETRIES;
+	int ret;
+	int error;
+
+	disable_irq(tsdata->client->irq);
+
+	/* mode register is 0x3c when in the work mode */
+	error = edt_ft5x06_i2c_register_write(tsdata,
+					    WORK_REGISTER_OPMODE, 0x03);
+	if (error) {
+		dev_err(&tsdata->client->dev,
+			"failed to switch to factory mode, error %d\n",
+			error);
+	}
+
+	do {
+		mdelay(EDT_SWITCH_MODE_DELAY);
+		/* mode register is 0x01 when in factory mode */
+		ret = edt_ft5x06_i2c_register_read(tsdata,
+						   FACTORY_REGISTER_OPMODE);
+		if (ret == 0x03)
+			break;
+	} while (--retries > 0);
+
+	if (retries == 0) {
+		dev_err(&tsdata->client->dev,
+			"not in factory mode after %dms.\n",
+			EDT_SWITCH_MODE_RETRIES * EDT_SWITCH_MODE_DELAY);
+		error = -EIO;
+		goto err_out;
+	}
+
+	tsdata->factory_mode = true;
+	return 0;
+
+err_out:
+	enable_irq(tsdata->client->irq);
+	return error;
+}
+
+static int edt_ft5x06_i2c_work_mode(struct edt_ft5x06_i2c_ts_data *tsdata)
+{
+	int retries = EDT_SWITCH_MODE_RETRIES;
+	int ret;
+	int error;
+
+	/* mode register is 0x01 when in the factory mode */
+	error = edt_ft5x06_i2c_register_write(tsdata,
+					      FACTORY_REGISTER_OPMODE, 0x01);
+	if (error) {
+		dev_err(&tsdata->client->dev,
+			"failed to switch to work mode, error: %d\n",
+			error);
+		return error;
+	}
+
+	do {
+		mdelay(EDT_SWITCH_MODE_DELAY);
+		/* mode register is 0x01 when in factory mode */
+		ret = edt_ft5x06_i2c_register_read(tsdata,
+						   WORK_REGISTER_OPMODE);
+		if (ret == 0x01)
+			break;
+	} while (--retries > 0);
+
+	if (retries == 0) {
+		dev_err(&tsdata->client->dev,
+			"not in work mode after %dms.\n",
+			EDT_SWITCH_MODE_RETRIES * EDT_SWITCH_MODE_DELAY);
+		return -EIO;
+	}
+
+	/* restore parameters */
+	edt_ft5x06_i2c_register_write(tsdata,
+				      WORK_REGISTER_THRESHOLD,
+				      tsdata->threshold);
+	edt_ft5x06_i2c_register_write(tsdata,
+				      WORK_REGISTER_GAIN,
+				      tsdata->gain);
+	edt_ft5x06_i2c_register_write(tsdata,
+				      WORK_REGISTER_OFFSET,
+				      tsdata->offset);
+	edt_ft5x06_i2c_register_write(tsdata,
+				      WORK_REGISTER_REPORT_RATE,
+				      tsdata->report_rate);
+
+	tsdata->factory_mode = false;
+	enable_irq(tsdata->client->irq);
+
+	return 0;
 }
 
 static ssize_t edt_ft5x06_i2c_mode_store(struct device *dev,
                                          struct device_attribute *attr,
                                          const char *buf, size_t count)
 {
-	struct edt_ft5x06_i2c_ts_data *tsdata = dev_get_drvdata(dev);
-	int i, ret = 0;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct edt_ft5x06_i2c_ts_data *tsdata = i2c_get_clientdata(client);
 	unsigned int mode;
+	int error;
 
-	if (sscanf(buf, "%u", &mode) != 1 || (mode | 1) != 1) {
-		dev_err(dev, "Invalid value for operation mode\n");
-		return -EINVAL;
-	}
+	error = kstrtouint(buf, 0, &mode);
+	if (error)
+		return error;
 
-	/* no change, return without doing anything */
-	if (mode == tsdata->factory_mode)
-		return count;
+	if (mode > 1)
+		return -ERANGE;
 
 	mutex_lock(&tsdata->mutex);
-	if (!tsdata->factory_mode) { /* switch to factory mode */
-		disable_irq(tsdata->irq);
-		/* mode register is 0x3c when in the work mode */
-		ret = edt_ft5x06_i2c_register_write(tsdata,
-		                                    WORK_REGISTER_OPMODE, 0x03);
-		if (ret < 0) {
-			dev_err(dev, "failed to switch to factory mode (%d)\n",
-			        ret);
-		} else {
-			tsdata->factory_mode = true;
-			for (i = 0; i < 10; i++) {
-				mdelay(5);
-				/* mode register is 0x01 when in factory mode */
-				ret = edt_ft5x06_i2c_register_read(tsdata, FACTORY_REGISTER_OPMODE);
-				if (ret == 0x03)
-					break;
-			}
-			if (i == 10)
-				dev_err(dev,
-				        "not in factory mode after %dms.\n",
-				        i*5);
-		}
-	} else {  /* switch to work mode */
-		/* mode register is 0x01 when in the factory mode */
-		ret = edt_ft5x06_i2c_register_write(tsdata,
-		                                    FACTORY_REGISTER_OPMODE,
-		                                    0x01);
-		if (ret < 0) {
-			dev_err(dev, "failed to switch to work mode (%d)\n",
-			        ret);
-		} else {
-			tsdata->factory_mode = false;
-			for (i = 0; i < 10; i++) {
-				mdelay(5);
-				/* mode register is 0x01 when in factory mode */
-				ret = edt_ft5x06_i2c_register_read(tsdata, WORK_REGISTER_OPMODE);
-				if (ret == 0x01)
-					break;
-			}
-			if (i == 10)
-				dev_err(dev, "not in work mode after %dms.\n",
-				        i*5);
-
-			/* restore parameters */
-			edt_ft5x06_i2c_register_write(tsdata,
-			                              WORK_REGISTER_THRESHOLD,
-			                              tsdata->threshold);
-			edt_ft5x06_i2c_register_write(tsdata,
-			                              WORK_REGISTER_GAIN,
-			                              tsdata->gain);
-			edt_ft5x06_i2c_register_write(tsdata,
-			                              WORK_REGISTER_OFFSET,
-			                              tsdata->offset);
-			edt_ft5x06_i2c_register_write(tsdata,
-			                              WORK_REGISTER_REPORT_RATE,
-			                              tsdata->report_rate);
-
-			enable_irq(tsdata->irq);
-		}
+
+	if (mode != tsdata->factory_mode) {
+		error = mode ? edt_ft5x06_i2c_factory_mode(tsdata) :
+			       edt_ft5x06_i2c_work_mode(tsdata);
 	}
 
 	mutex_unlock(&tsdata->mutex);
-	return count;
+	return error ?: count;
 }
 
-
 static ssize_t edt_ft5x06_i2c_raw_data_show(struct device *dev,
                                             struct device_attribute *attr,
                                             char *buf)
 {
-	struct edt_ft5x06_i2c_ts_data *tsdata = dev_get_drvdata(dev);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct edt_ft5x06_i2c_ts_data *tsdata = i2c_get_clientdata(client);
+	int retries  = EDT_RAW_DATA_RETRIES;
+	size_t count = 0;
 	int i, ret;
-	char *ptr, wrbuf[3];
+	int error;
+	char wrbuf[3];
+
+	/* Make sure we have enough space */
+	if (tsdata->num_x * tsdata->num_y * 2 >= PAGE_SIZE)
+		return -ENOBUFS;
+
+	mutex_lock(&tsdata->mutex);
 
 	if (!tsdata->factory_mode) {
-		dev_err(dev, "raw data not available in work mode\n");
-		return -EIO;
+		error = -EIO;
+		goto out;
 	}
 
-	mutex_lock(&tsdata->mutex);
-	ret = edt_ft5x06_i2c_register_write(tsdata, 0x08, 0x01);
-	for (i = 0; i < 100; i++) {
+	error = edt_ft5x06_i2c_register_write(tsdata, 0x08, 0x01);
+	if (error) {
+		dev_dbg(dev, "failed to write 0x08 register, error %d\n",
+			error);
+		goto out;
+	}
+
+	do {
+		msleep(EDT_RAW_DATA_DELAY);
 		ret = edt_ft5x06_i2c_register_read(tsdata, 0x08);
 		if (ret < 1)
 			break;
-		udelay(1000);
+	} while (--retries > 0);
+
+	if (ret < 0) {
+		error = ret;
+		dev_dbg(dev, "failed to read 0x08 register, error %d\n", error);
+		goto out;
 	}
 
-	if (i == 100 || ret < 0) {
-		dev_err(dev, "waiting time exceeded or error: %d\n", ret);
-		mutex_unlock(&tsdata->mutex);
-		return ret < 0 ? ret : -ETIMEDOUT;
+	if (retries == 0) {
+		dev_dbg(dev, "timed out waiting for register to settle\n");
+		error = -ETIMEDOUT;
+		goto out;
 	}
 
-	ptr = buf;
 	wrbuf[0] = 0xf5;
 	wrbuf[1] = 0x0e;
-	for (i = 0; i <= tsdata->num_x; i++) {
+	for (i = 0; i < tsdata->num_x; i++) {
 		wrbuf[2] = i;
-		ret = edt_ft5x06_ts_readwrite(tsdata->client,
-		                               3, wrbuf,
-		                               tsdata->num_y * 2, ptr);
-		if (ret < 0) {
-			mutex_unlock(&tsdata->mutex);
-			return ret;
-		}
-
-		ptr += tsdata->num_y * 2;
+		error = edt_ft5x06_ts_readwrite(tsdata->client,
+						sizeof(wrbuf), wrbuf,
+						tsdata->num_y * 2,
+						&buf[count]);
+		if (error)
+			goto out;
+
+		count += tsdata->num_y * 2;
 	}
 
+out:
 	mutex_unlock(&tsdata->mutex);
-	return ptr - buf;
+	return error ?: count;
 }
 
+static EDT_ATTR(gain, S_IWUSR | S_IRUGO, WORK_REGISTER_GAIN, 0, 31);
+static EDT_ATTR(offset, S_IWUSR | S_IRUGO, WORK_REGISTER_OFFSET, 0, 31);
+static EDT_ATTR(threshold, S_IWUSR | S_IRUGO,
+		WORK_REGISTER_THRESHOLD, 20, 80);
+static EDT_ATTR(report_rate, S_IWUSR | S_IRUGO,
+		WORK_REGISTER_REPORT_RATE, 3, 14);
 
-static DEVICE_ATTR(gain,      0664,
-                   edt_ft5x06_i2c_setting_show, edt_ft5x06_i2c_setting_store);
-static DEVICE_ATTR(offset,    0664,
-                   edt_ft5x06_i2c_setting_show, edt_ft5x06_i2c_setting_store);
-static DEVICE_ATTR(threshold, 0664,
-                   edt_ft5x06_i2c_setting_show, edt_ft5x06_i2c_setting_store);
-static DEVICE_ATTR(report_rate, 0664,
-                   edt_ft5x06_i2c_setting_show, edt_ft5x06_i2c_setting_store);
-static DEVICE_ATTR(mode,      0664,
+static DEVICE_ATTR(mode, S_IWUSR | S_IRUGO,
                    edt_ft5x06_i2c_mode_show, edt_ft5x06_i2c_mode_store);
-static DEVICE_ATTR(raw_data,  0444,
-                   edt_ft5x06_i2c_raw_data_show, NULL);
+static DEVICE_ATTR(raw_data, S_IRUGO, edt_ft5x06_i2c_raw_data_show, NULL);
 
 static struct attribute *edt_ft5x06_i2c_attrs[] = {
-	&dev_attr_gain.attr,
-	&dev_attr_offset.attr,
-	&dev_attr_threshold.attr,
-	&dev_attr_report_rate.attr,
+	&edt_ft5x06_attr_gain.dattr.attr,
+	&edt_ft5x06_attr_offset.dattr.attr,
+	&edt_ft5x06_attr_threshold.dattr.attr,
+	&edt_ft5x06_attr_report_rate.dattr.attr,
 	&dev_attr_mode.attr,
 	&dev_attr_raw_data.attr,
 	NULL
 };
 
+static umode_t edt_ft5x06_i2c_attr_is_visible(struct kobject *kobj,
+					      struct attribute *attr, int n)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct edt_ft5x06_i2c_ts_data *tsdata = i2c_get_clientdata(client);
+	umode_t mode = attr->mode;
+
+	if (attr == &dev_attr_raw_data.attr) {
+		if (!tsdata->factory_mode)
+			mode = 0;
+
+	} else if (attr == &edt_ft5x06_attr_gain.dattr.attr ||
+		   attr == &edt_ft5x06_attr_offset.dattr.attr ||
+		   attr == &edt_ft5x06_attr_threshold.dattr.attr ||
+		   attr == &edt_ft5x06_attr_report_rate.dattr.attr) {
+
+		if (tsdata->factory_mode)
+			mode = 0;
+	}
+
+	return mode;
+}
+
 static const struct attribute_group edt_ft5x06_i2c_attr_group = {
 	.attrs = edt_ft5x06_i2c_attrs,
+	.is_visible = edt_ft5x06_i2c_attr_is_visible,
 };
 
-static int edt_ft5x06_i2c_ts_probe(struct i2c_client *client,
-                                   const struct i2c_device_id *id)
+static int __devinit edt_ft5x06_i2c_ts_reset(struct i2c_client *client,
+					     int reset_pin)
+{
+	int error;
+
+	if (gpio_is_valid(reset_pin)) {
+		/* this pulls reset down, enabling the low active reset */
+		error = gpio_request_one(reset_pin, GPIOF_OUT_INIT_LOW,
+					 "edt-ft5x06 reset");
+		if (error) {
+			dev_err(&client->dev,
+				"Failed to request GPIO %d as reset pin, error %d\n",
+				reset_pin, error);
+			return error;
+		}
+
+		mdelay(50);
+		gpio_set_value(reset_pin, 1);
+		mdelay(100);
+
+		gpio_free(reset_pin);
+	}
+
+	return 0;
+}
+
+static int __devinit edt_ft5x06_i2c_ts_identify(struct i2c_client *client,
+						char *model_name,
+						char *fw_version)
+{
+	u8 rdbuf[EDT_NAME_LEN];
+	char *p;
+	int error;
+
+	error = edt_ft5x06_ts_readwrite(client,
+					1, "\xbb", EDT_NAME_LEN - 1, rdbuf);
+	if (error)
+		return error;
+
+	/* remove last '$' end marker */
+	rdbuf[EDT_NAME_LEN - 1] = '\0';
+	if (rdbuf[EDT_NAME_LEN - 2] == '$')
+		rdbuf[EDT_NAME_LEN - 2] = '\0';
+
+	/* look for Model/Version separator */
+	p = strchr(rdbuf, '*');
+	if (p)
+		*p++ = '\0';
+
+	strlcpy(model_name, rdbuf + 1, EDT_NAME_LEN);
+	strlcpy(fw_version, p ? p : "", EDT_NAME_LEN);
+
+	return 0;
+}
+
+static int __devinit edt_ft5x06_i2c_ts_probe(struct i2c_client *client,
+					     const struct i2c_device_id *id)
 {
 
 	const struct edt_ft5x06_platform_data *pdata = client->dev.platform_data;
 	struct edt_ft5x06_i2c_ts_data *tsdata;
 	struct input_dev *input;
 	int error;
-	u8 rdbuf[23];
-	char *model_name, *fw_version;
+	char fw_version[EDT_NAME_LEN];
 
 	dev_dbg(&client->dev, "probing for EDT FT5x06 I2C\n");
 
 	if (!pdata) {
 		dev_err(&client->dev, "no platform data?\n");
-		return -ENODEV;
-	}
-
-	tsdata = kzalloc(sizeof(*tsdata), GFP_KERNEL);
-	if (!tsdata) {
-		dev_err(&client->dev, "failed to allocate driver data!\n");
-		dev_set_drvdata(&client->dev, NULL);
-		return -ENOMEM;
+		return -EINVAL;
 	}
 
-	dev_set_drvdata(&client->dev, tsdata);
-	tsdata->client = client;
-
-	tsdata->reset_pin = pdata->reset_pin;
-	mutex_init(&tsdata->mutex);
+	error = edt_ft5x06_i2c_ts_reset(client, pdata->reset_pin);
+	if (error)
+		return error;
 
-	if (tsdata->reset_pin >= 0) {
-		error = gpio_request(tsdata->reset_pin, "edt-ft5x06 reset");
-		if (error < 0) {
+	if (gpio_is_valid(pdata->irq_pin)) {
+		error = gpio_request_one(pdata->irq_pin,
+					 GPIOF_IN, "edt-ft5x06 irq");
+		if (error) {
 			dev_err(&client->dev,
-			        "Failed to request GPIO %d as reset pin, error %d\n",
-			         tsdata->reset_pin, error);
-			goto err_free_tsdata;
+				"Failed to request GPIO %d, error %d\n",
+				pdata->irq_pin, error);
+			return error;
 		}
-
-		/* this pulls reset down, enabling the low active reset */
-		if (gpio_direction_output(tsdata->reset_pin, 0) < 0) {
-			dev_info(&client->dev, "switching to output failed\n");
-			goto err_free_reset_pin;
-		}
-	}
-
-	/* request IRQ pin */
-	tsdata->irq_pin = pdata->irq_pin;
-	tsdata->irq = gpio_to_irq(tsdata->irq_pin);
-
-	error = gpio_request(tsdata->irq_pin, "edt-ft5x06 irq");
-	if (error < 0) {
-		dev_err(&client->dev,
-		        "Failed to request GPIO %d for IRQ %d, error %d\n",
-		        tsdata->irq_pin, tsdata->irq, error);
-		goto err_free_reset_pin;
 	}
-	gpio_direction_input(tsdata->irq_pin);
 
-	if (tsdata->reset_pin >= 0) {
-		/* release reset */
-		mdelay(50);
-		gpio_set_value(tsdata->reset_pin, 1);
-		mdelay(100);
+	tsdata = kzalloc(sizeof(*tsdata), GFP_KERNEL);
+	input = input_allocate_device();
+	if (!tsdata || !input) {
+		dev_err(&client->dev, "failed to allocate driver data.\n");
+		error = -ENOMEM;
+		goto err_free_mem;
 	}
 
-	mutex_lock(&tsdata->mutex);
-
+	mutex_init(&tsdata->mutex);
+	tsdata->client = client;
+	tsdata->input = input;
 	tsdata->factory_mode = false;
 
-	if (edt_ft5x06_ts_readwrite(client, 1, "\xbb", 22, rdbuf) < 0) {
-		dev_err(&client->dev, "probing failed\n");
-		error = -ENODEV;
-		goto err_free_irq_pin;
+	error = edt_ft5x06_i2c_ts_identify(client, tsdata->name, fw_version);
+	if (error) {
+		dev_err(&client->dev, "touchscreen probe failed\n");
+		goto err_free_mem;
 	}
 
 	tsdata->threshold = edt_ft5x06_i2c_register_read(tsdata,
-	                                                 WORK_REGISTER_THRESHOLD);
-	tsdata->gain      = edt_ft5x06_i2c_register_read(tsdata,
-	                                                 WORK_REGISTER_GAIN);
-	tsdata->offset    = edt_ft5x06_i2c_register_read(tsdata,
-	                                                 WORK_REGISTER_OFFSET);
+						WORK_REGISTER_THRESHOLD);
+	tsdata->gain = edt_ft5x06_i2c_register_read(tsdata,
+						WORK_REGISTER_GAIN);
+	tsdata->offset = edt_ft5x06_i2c_register_read(tsdata,
+						WORK_REGISTER_OFFSET);
 	tsdata->report_rate = edt_ft5x06_i2c_register_read(tsdata,
-	                                                 WORK_REGISTER_REPORT_RATE);
-	tsdata->num_x     = edt_ft5x06_i2c_register_read(tsdata,
-	                                                 WORK_REGISTER_NUM_X);
-	tsdata->num_y     = edt_ft5x06_i2c_register_read(tsdata,
-	                                                 WORK_REGISTER_NUM_Y);
+						WORK_REGISTER_REPORT_RATE);
+	tsdata->num_x = edt_ft5x06_i2c_register_read(tsdata,
+						WORK_REGISTER_NUM_X);
+	tsdata->num_y = edt_ft5x06_i2c_register_read(tsdata,
+						WORK_REGISTER_NUM_Y);
 
-	mutex_unlock(&tsdata->mutex);
+	dev_dbg(&client->dev,
+		"Model \"%s\", Rev. \"%s\", %dx%d sensors\n",
+		tsdata->name, fw_version, tsdata->num_x, tsdata->num_y);
 
-	/* remove last '$' end marker */
-	rdbuf[22] = '\0';
-	if (rdbuf[21] == '$')
-		rdbuf[21] = '\0';
-
-	model_name = rdbuf + 1;
-	/* look for Model/Version separator */
-	fw_version = strchr(rdbuf, '*');
-
-	if (fw_version) {
-		fw_version[0] = '\0';
-		fw_version++;
-		dev_info(&client->dev,
-		         "Model \"%s\", Rev. \"%s\", %dx%d sensors\n",
-		         model_name, fw_version, tsdata->num_x, tsdata->num_y);
-	} else {
-		dev_info(&client->dev, "Product ID \"%s\"\n", model_name);
-	}
-	strncpy (tsdata->name, model_name, sizeof (tsdata->name) - 1);
-
-	input = input_allocate_device();
-	if (!input) {
-		dev_err(&client->dev, "failed to allocate input device!\n");
-		error = -ENOMEM;
-		goto err_free_irq_pin;
-	}
+	input->name = tsdata->name;
+	input->id.bustype = BUS_I2C;
+	input->dev.parent = &client->dev;
 
 	__set_bit(EV_SYN, input->evbit);
 	__set_bit(EV_KEY, input->evbit);
@@ -634,31 +687,20 @@ static int edt_ft5x06_i2c_ts_probe(struct i2c_client *client,
 	__set_bit(BTN_TOUCH, input->keybit);
 	input_set_abs_params(input, ABS_X, 0, tsdata->num_x * 64 - 1, 0, 0);
 	input_set_abs_params(input, ABS_Y, 0, tsdata->num_y * 64 - 1, 0, 0);
-	input_set_abs_params(input, ABS_PRESSURE, 0, 1, 0, 0);
 	input_set_abs_params(input, ABS_MT_POSITION_X,
 	                     0, tsdata->num_x * 64 - 1, 0, 0);
 	input_set_abs_params(input, ABS_MT_POSITION_Y,
 	                     0, tsdata->num_y * 64 - 1, 0, 0);
 	input_set_abs_params(input, ABS_MT_TRACKING_ID, 0, 15, 0, 0);
 
-	input->name = tsdata->name;
-	input->id.bustype = BUS_I2C;
-	input->dev.parent = &client->dev;
-
 	input_set_drvdata(input, tsdata);
 
-	tsdata->input = input;
-
-	error = input_register_device(input);
-	if (error)
-		goto err_free_input_device;
-
-	if (request_threaded_irq(tsdata->irq, NULL, edt_ft5x06_ts_isr,
-	                         IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-	                         client->name, tsdata)) {
+	error = request_threaded_irq(client->irq, NULL, edt_ft5x06_ts_isr,
+				     IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+				     client->name, tsdata);
+	if (error) {
 		dev_err(&client->dev, "Unable to request touchscreen IRQ.\n");
-		error = -ENOMEM;
-		goto err_unregister_device;
+		goto err_free_mem;
 	}
 
 	error = sysfs_create_group(&client->dev.kobj,
@@ -666,43 +708,44 @@ static int edt_ft5x06_i2c_ts_probe(struct i2c_client *client,
 	if (error)
 		goto err_free_irq;
 
+	error = input_register_device(input);
+	if (error)
+		goto err_remove_attrs;
+
+	i2c_set_clientdata(client, tsdata);
 	device_init_wakeup(&client->dev, 1);
 
 	dev_dbg(&tsdata->client->dev,
-	        "EDT FT5x06 initialized: IRQ pin %d, Reset pin %d.\n",
-	        tsdata->irq_pin, tsdata->reset_pin);
+		"EDT FT5x06 initialized: IRQ pin %d, Reset pin %d.\n",
+		pdata->irq_pin, pdata->reset_pin);
 
 	return 0;
 
+err_remove_attrs:
+	sysfs_remove_group(&client->dev.kobj, &edt_ft5x06_i2c_attr_group);
 err_free_irq:
-	free_irq(tsdata->irq, tsdata);
-err_unregister_device:
-	input_unregister_device(input);
-	input = NULL;
-err_free_input_device:
-	if (input)
-		input_free_device(input);
-err_free_irq_pin:
-	gpio_free(tsdata->irq_pin);
-err_free_reset_pin:
-	if (tsdata->reset_pin >= 0)
-		gpio_free(tsdata->reset_pin);
-err_free_tsdata:
+	free_irq(client->irq, tsdata);
+err_free_mem:
+	input_free_device(input);
 	kfree(tsdata);
+
+	if (gpio_is_valid(pdata->irq_pin))
+		gpio_free(pdata->irq_pin);
+
 	return error;
 }
 
-static int edt_ft5x06_i2c_ts_remove(struct i2c_client *client)
+static int __devexit edt_ft5x06_i2c_ts_remove(struct i2c_client *client)
 {
-	struct edt_ft5x06_i2c_ts_data *tsdata = dev_get_drvdata(&client->dev);
+	const struct edt_ft5x06_platform_data *pdata = client->dev.platform_data;
+	struct edt_ft5x06_i2c_ts_data *tsdata = i2c_get_clientdata(client);
 
 	sysfs_remove_group(&client->dev.kobj, &edt_ft5x06_i2c_attr_group);
 
-	free_irq(tsdata->irq, tsdata);
+	free_irq(client->irq, tsdata);
 	input_unregister_device(tsdata->input);
-	gpio_free(tsdata->irq_pin);
-	if (tsdata->reset_pin >= 0)
-		gpio_free(tsdata->reset_pin);
+	if (gpio_is_valid(pdata->irq_pin))
+		gpio_free(pdata->irq_pin);
 	kfree(tsdata);
 
 	return 0;
@@ -711,20 +754,20 @@ static int edt_ft5x06_i2c_ts_remove(struct i2c_client *client)
 #ifdef CONFIG_PM_SLEEP
 static int edt_ft5x06_i2c_ts_suspend(struct device *dev)
 {
-	struct edt_ft5x06_i2c_ts_data *tsdata = dev_get_drvdata(dev);
+	struct i2c_client *client = to_i2c_client(dev);
 
 	if (device_may_wakeup(dev))
-		enable_irq_wake(tsdata->irq);
+		enable_irq_wake(client->irq);
 
 	return 0;
 }
 
 static int edt_ft5x06_i2c_ts_resume(struct device *dev)
 {
-	struct edt_ft5x06_i2c_ts_data *tsdata = dev_get_drvdata(dev);
+	struct i2c_client *client = to_i2c_client(dev);
 
 	if (device_may_wakeup(dev))
-		disable_irq_wake(tsdata->irq);
+		disable_irq_wake(client->irq);
 
 	return 0;
 }
@@ -747,20 +790,10 @@ static struct i2c_driver edt_ft5x06_i2c_ts_driver = {
 	},
 	.id_table = edt_ft5x06_i2c_ts_id,
 	.probe    = edt_ft5x06_i2c_ts_probe,
-	.remove   = edt_ft5x06_i2c_ts_remove,
+	.remove   = __devexit_p(edt_ft5x06_i2c_ts_remove),
 };
 
-static int __init edt_ft5x06_i2c_ts_init(void)
-{
-	return i2c_add_driver(&edt_ft5x06_i2c_ts_driver);
-}
-module_init(edt_ft5x06_i2c_ts_init);
-
-static void __exit edt_ft5x06_i2c_ts_exit(void)
-{
-	i2c_del_driver(&edt_ft5x06_i2c_ts_driver);
-}
-module_exit(edt_ft5x06_i2c_ts_exit);
+module_i2c_driver(edt_ft5x06_i2c_ts_driver);
 
 MODULE_AUTHOR("Simon Budig <simon.budig@kernelconcepts.de>");
 MODULE_DESCRIPTION("EDT FT5x06 I2C Touchscreen Driver");
