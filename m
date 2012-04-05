From: Simon Budig <simon.budig@kernelconcepts.de>
Subject: Re: [PATCH] Touchscreen driver for FT5x06 based EDT displays
Date: Thu, 05 Apr 2012 14:54:18 +0200
Message-ID: <4F7D95FA.2050800@kernelconcepts.de>
References: <1331050527-4902-1-git-send-email-simon.budig@kernelconcepts.de> <1333564079-23893-1-git-send-email-simon.budig@kernelconcepts.de> <1333564079-23893-2-git-send-email-simon.budig@kernelconcepts.de> <20120404191043.GA11042@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030701010604080206020506"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernelconcepts.de ([212.60.202.196]:57167 "EHLO
	mail.kernelconcepts.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582Ab2DEMyW (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 Apr 2012 08:54:22 -0400
In-Reply-To: <20120404191043.GA11042@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, agust@denx.de, yanok@emcraft.com

This is a multi-part message in MIME format.
--------------030701010604080206020506
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 04/04/2012 09:10 PM, Dmitry Torokhov wrote:
[suggestions for my patch]

Based on your input I have prepared two patches which might be easier to
review than the complete diff.

The first one is IMHO pretty straightforward and implements most of the
small bits.

The second one sits on top of the first one and is an attempt at more
generic attribute handling. I must say that I am not too happy about it,
but maybe I am thinking too convoluted here. It saves about 3 lines of
code and exchanges a lot of easy and straightforward code with stuff
that is harder to follow - especially the lookup of the matching
attribute makes me unhappy. There are bits in it I like and will
probably use. But the lookup...

any suggestions are welcome.

Bye,
        Simon

- -- 
       Simon Budig                        kernel concepts GmbH
       simon.budig@kernelconcepts.de      Sieghuetter Hauptweg 48
       +49-271-771091-17                  D-57072 Siegen

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk99lfoACgkQO2O/RXesiHAE6gCgw2EK5b6MKzfYY7ekEwdNy4FG
GlUAn2db538XupC6i7OZoP06Zb+RFaBI
=UTET
-----END PGP SIGNATURE-----

--------------030701010604080206020506
Content-Type: text/x-patch;
 name="edt-fixes-1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="edt-fixes-1.patch"

commit c4429d03fd6bffd51eb5b47dfb173ecd6c015e10
Author: Simon Budig <simon.budig@kernelconcepts.de>
Date:   Wed Apr 4 23:21:51 2012 +0200

    incorporate a set of fixes from Dmitry Torokhov

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 58e35c3..d96eb8f 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -62,6 +62,7 @@ struct edt_ft5x06_i2c_ts_data {
 	int gain;
 	int offset;
 	int report_rate;
+	char name[24];
 };
 
 static int edt_ft5x06_ts_readwrite(struct i2c_client *client,
@@ -102,7 +103,7 @@ static irqreturn_t edt_ft5x06_ts_isr(int irq, void *dev_id)
 	struct edt_ft5x06_i2c_ts_data *tsdata = dev_id;
 	unsigned char touching = 0;
 	unsigned char rdbuf[26], wrbuf[1];
-	int i, have_abs, type, ret;
+	int i, have_abs, type, x, y, id, ret;
 
 	memset(wrbuf, 0, sizeof(wrbuf));
 	memset(rdbuf, 0, sizeof(rdbuf));
@@ -126,7 +127,7 @@ static irqreturn_t edt_ft5x06_ts_isr(int irq, void *dev_id)
 		        rdbuf[0], rdbuf[1], rdbuf[2]);
 	}
 
-	have_abs = 0;
+	have_abs = false;
 	touching = rdbuf[3];
 	for (i = 0; i < touching; i++) {
 		type = rdbuf[i*4+5] >> 6;
@@ -134,23 +135,20 @@ static irqreturn_t edt_ft5x06_ts_isr(int irq, void *dev_id)
 		if (type == 0x01 || type == 0x03)
 			continue;
 
+		x = ((rdbuf[i*4+5] << 8) | rdbuf[i*4+6]) & 0x0fff;
+		y = ((rdbuf[i*4+7] << 8) | rdbuf[i*4+8]) & 0x0fff;
+		id = (rdbuf[i*4+7] >> 4) & 0x0f;
+
 		if (!have_abs) {
 			input_report_key(tsdata->input, BTN_TOUCH,    1);
 			input_report_abs(tsdata->input, ABS_PRESSURE, 1);
-			input_report_abs(tsdata->input, ABS_X,
-			                 ((rdbuf[i*4+5] << 8) |
-			                  rdbuf[i*4+6]) & 0x0fff);
-			input_report_abs(tsdata->input, ABS_Y,
-			                 ((rdbuf[i*4+7] << 8) |
-			                  rdbuf[i*4+8]) & 0x0fff);
-			have_abs = 1;
+			input_report_abs(tsdata->input, ABS_X,        x);
+			input_report_abs(tsdata->input, ABS_Y,        y);
+			have_abs = true;
 		}
-		input_report_abs(tsdata->input, ABS_MT_POSITION_X,
-		                 ((rdbuf[i*4+5] << 8) | rdbuf[i*4+6]) & 0x0fff);
-		input_report_abs(tsdata->input, ABS_MT_POSITION_Y,
-		                 ((rdbuf[i*4+7] << 8) | rdbuf[i*4+8]) & 0x0fff);
-		input_report_abs(tsdata->input, ABS_MT_TRACKING_ID,
-		                 (rdbuf[i*4+7] >> 4) & 0x0f);
+		input_report_abs(tsdata->input, ABS_MT_POSITION_X, x);
+		input_report_abs(tsdata->input, ABS_MT_POSITION_Y, y);
+		input_report_abs(tsdata->input, ABS_MT_TRACKING_ID, id);
 		input_mt_sync(tsdata->input);
 	}
 	if (!have_abs) {
@@ -378,7 +376,7 @@ static ssize_t edt_ft5x06_i2c_mode_store(struct device *dev,
 			dev_err(dev, "failed to switch to factory mode (%d)\n",
 			        ret);
 		} else {
-			tsdata->factory_mode = 1;
+			tsdata->factory_mode = true;
 			for (i = 0; i < 10; i++) {
 				mdelay(5);
 				/* mode register is 0x01 when in factory mode */
@@ -400,7 +398,7 @@ static ssize_t edt_ft5x06_i2c_mode_store(struct device *dev,
 			dev_err(dev, "failed to switch to work mode (%d)\n",
 			        ret);
 		} else {
-			tsdata->factory_mode = 0;
+			tsdata->factory_mode = false;
 			for (i = 0; i < 10; i++) {
 				mdelay(5);
 				/* mode register is 0x01 when in factory mode */
@@ -515,8 +513,8 @@ static int edt_ft5x06_i2c_ts_probe(struct i2c_client *client,
                                    const struct i2c_device_id *id)
 {
 
+	const struct edt_ft5x06_platform_data *pdata = client->dev.platform_data;
 	struct edt_ft5x06_i2c_ts_data *tsdata;
-	struct edt_ft5x06_platform_data *pdata;
 	struct input_dev *input;
 	int error;
 	u8 rdbuf[23];
@@ -524,7 +522,7 @@ static int edt_ft5x06_i2c_ts_probe(struct i2c_client *client,
 
 	dev_dbg(&client->dev, "probing for EDT FT5x06 I2C\n");
 
-	if (!client->dev.platform_data) {
+	if (!pdata) {
 		dev_err(&client->dev, "no platform data?\n");
 		return -ENODEV;
 	}
@@ -538,7 +536,6 @@ static int edt_ft5x06_i2c_ts_probe(struct i2c_client *client,
 
 	dev_set_drvdata(&client->dev, tsdata);
 	tsdata->client = client;
-	pdata = client->dev.platform_data;
 
 	tsdata->reset_pin = pdata->reset_pin;
 	mutex_init(&tsdata->mutex);
@@ -581,7 +578,7 @@ static int edt_ft5x06_i2c_ts_probe(struct i2c_client *client,
 
 	mutex_lock(&tsdata->mutex);
 
-	tsdata->factory_mode = 0;
+	tsdata->factory_mode = false;
 
 	if (edt_ft5x06_ts_readwrite(client, 1, "\xbb", 22, rdbuf) < 0) {
 		dev_err(&client->dev, "probing failed\n");
@@ -622,6 +619,7 @@ static int edt_ft5x06_i2c_ts_probe(struct i2c_client *client,
 	} else {
 		dev_info(&client->dev, "Product ID \"%s\"\n", model_name);
 	}
+	strncpy (tsdata->name, model_name, sizeof (tsdata->name) - 1);
 
 	input = input_allocate_device();
 	if (!input) {
@@ -643,7 +641,7 @@ static int edt_ft5x06_i2c_ts_probe(struct i2c_client *client,
 	                     0, tsdata->num_y * 64 - 1, 0, 0);
 	input_set_abs_params(input, ABS_MT_TRACKING_ID, 0, 15, 0, 0);
 
-	input->name = kstrdup(model_name, GFP_NOIO);
+	input->name = tsdata->name;
 	input->id.bustype = BUS_I2C;
 	input->dev.parent = &client->dev;
 
@@ -659,7 +657,6 @@ static int edt_ft5x06_i2c_ts_probe(struct i2c_client *client,
 	                         IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 	                         client->name, tsdata)) {
 		dev_err(&client->dev, "Unable to request touchscreen IRQ.\n");
-		input = NULL;
 		error = -ENOMEM;
 		goto err_unregister_device;
 	}
@@ -683,10 +680,8 @@ err_unregister_device:
 	input_unregister_device(input);
 	input = NULL;
 err_free_input_device:
-	if (input) {
-		kfree(input->name);
+	if (input)
 		input_free_device(input);
-	}
 err_free_irq_pin:
 	gpio_free(tsdata->irq_pin);
 err_free_reset_pin:
@@ -704,7 +699,6 @@ static int edt_ft5x06_i2c_ts_remove(struct i2c_client *client)
 	sysfs_remove_group(&client->dev.kobj, &edt_ft5x06_i2c_attr_group);
 
 	free_irq(tsdata->irq, tsdata);
-	kfree(tsdata->input->name);
 	input_unregister_device(tsdata->input);
 	gpio_free(tsdata->irq_pin);
 	if (tsdata->reset_pin >= 0)
@@ -714,6 +708,7 @@ static int edt_ft5x06_i2c_ts_remove(struct i2c_client *client)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
 static int edt_ft5x06_i2c_ts_suspend(struct device *dev)
 {
 	struct edt_ft5x06_i2c_ts_data *tsdata = dev_get_drvdata(dev);
@@ -733,6 +728,7 @@ static int edt_ft5x06_i2c_ts_resume(struct device *dev)
 
 	return 0;
 }
+#endif
 
 static SIMPLE_DEV_PM_OPS(edt_ft5x06_i2c_ts_pm_ops,
                          edt_ft5x06_i2c_ts_suspend, edt_ft5x06_i2c_ts_resume);

--------------030701010604080206020506
Content-Type: text/x-patch;
 name="edt-fixes-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="edt-fixes-2.patch"

commit c79729c84cbdde766517a863ade907d8e9a830d6
Author: Simon Budig <simon.budig@kernelconcepts.de>
Date:   Thu Apr 5 14:43:18 2012 +0200

    rework attribute handling. Not sure if this improves things

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index d96eb8f..9e5900c 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -35,7 +35,7 @@
 
 #include <linux/input/edt-ft5x06.h>
 
-#define DRIVER_VERSION "v0.5"
+#define DRIVER_VERSION "v0.6"
 
 #define WORK_REGISTER_THRESHOLD   0x00
 #define WORK_REGISTER_REPORT_RATE 0x08
@@ -47,6 +47,14 @@
 #define WORK_REGISTER_OPMODE      0x3c
 #define FACTORY_REGISTER_OPMODE   0x01
 
+enum edt_ft5x06_setting {
+	SETTING_THRESHOLD,
+	SETTING_GAIN,
+	SETTING_OFFSET,
+	SETTING_REPORT_RATE,
+	N_SETTINGS,    /* must be last entry */
+};
+
 struct edt_ft5x06_i2c_ts_data {
 	struct i2c_client *client;
 	struct input_dev *input;
@@ -58,13 +66,69 @@ struct edt_ft5x06_i2c_ts_data {
 
 	struct mutex mutex;
 	bool factory_mode;
-	int threshold;
-	int gain;
-	int offset;
-	int report_rate;
+	int settings[N_SETTINGS];
 	char name[24];
 };
 
+struct edt_ft5x06_settings_data_entry {
+	u8 addr;
+	u8 min;
+	u8 max;
+};
+
+static const struct edt_ft5x06_settings_data_entry
+edt_ft5x06_settings_data[N_SETTINGS] = {
+	[SETTING_THRESHOLD]   = { WORK_REGISTER_THRESHOLD,   20, 80 },
+	[SETTING_GAIN]        = { WORK_REGISTER_GAIN,         0, 31 },
+	[SETTING_OFFSET]      = { WORK_REGISTER_OFFSET,       0, 31 },
+	[SETTING_REPORT_RATE] = { WORK_REGISTER_REPORT_RATE,  3, 14 },
+};
+
+
+static ssize_t edt_ft5x06_i2c_setting_show(struct device *dev,
+                                           struct device_attribute *attr,
+                                           char *buf);
+static ssize_t edt_ft5x06_i2c_setting_store(struct device *dev,
+                                            struct device_attribute *attr,
+                                            const char *buf, size_t count);
+static ssize_t edt_ft5x06_i2c_mode_show(struct device *dev,
+                                        struct device_attribute *attr,
+                                        char *buf);
+static ssize_t edt_ft5x06_i2c_mode_store(struct device *dev,
+                                         struct device_attribute *attr,
+                                         const char *buf, size_t count);
+static ssize_t edt_ft5x06_i2c_raw_data_show(struct device *dev,
+                                            struct device_attribute *attr,
+                                            char *buf);
+
+static DEVICE_ATTR(gain,      0664,
+                   edt_ft5x06_i2c_setting_show, edt_ft5x06_i2c_setting_store);
+static DEVICE_ATTR(offset,    0664,
+                   edt_ft5x06_i2c_setting_show, edt_ft5x06_i2c_setting_store);
+static DEVICE_ATTR(threshold, 0664,
+                   edt_ft5x06_i2c_setting_show, edt_ft5x06_i2c_setting_store);
+static DEVICE_ATTR(report_rate, 0664,
+                   edt_ft5x06_i2c_setting_show, edt_ft5x06_i2c_setting_store);
+static DEVICE_ATTR(mode,      0664,
+                   edt_ft5x06_i2c_mode_show, edt_ft5x06_i2c_mode_store);
+static DEVICE_ATTR(raw_data,  0444,
+                   edt_ft5x06_i2c_raw_data_show, NULL);
+
+static struct attribute *edt_ft5x06_i2c_attrs[] = {
+	[SETTING_GAIN]        = &dev_attr_gain.attr,
+	[SETTING_OFFSET]      = &dev_attr_offset.attr,
+	[SETTING_THRESHOLD]   = &dev_attr_threshold.attr,
+	[SETTING_REPORT_RATE] = &dev_attr_report_rate.attr,
+	&dev_attr_mode.attr,
+	&dev_attr_raw_data.attr,
+	NULL
+};
+
+static const struct attribute_group edt_ft5x06_i2c_attr_group = {
+	.attrs = edt_ft5x06_i2c_attrs,
+};
+
+
 static int edt_ft5x06_ts_readwrite(struct i2c_client *client,
                                    u16 wr_len, u8 *wr_buf,
                                    u16 rd_len, u8 *rd_buf)
@@ -217,27 +281,14 @@ static ssize_t edt_ft5x06_i2c_setting_show(struct device *dev,
 	struct edt_ft5x06_i2c_ts_data *tsdata = dev_get_drvdata(dev);
 	struct i2c_client *client = tsdata->client;
 	int ret = 0;
-	int *value;
-	u8 addr;
+	int i;
 
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
+	for (i = 0; i < N_SETTINGS; i++) {
+		if (edt_ft5x06_i2c_attrs[i] == &attr->attr)
+			break;
+	}
+	
+	if (i == N_SETTINGS) {
 		dev_err(&client->dev,
 		        "unknown attribute for edt_ft5x06_i2c_setting_show: %s\n",
 		        attr->attr.name);
@@ -253,20 +304,21 @@ static ssize_t edt_ft5x06_i2c_setting_show(struct device *dev,
 		return -EIO;
 	}
 
-	ret = edt_ft5x06_i2c_register_read(tsdata, addr);
+	ret = edt_ft5x06_i2c_register_read(tsdata,
+	                                   edt_ft5x06_settings_data[i].addr);
 	if (ret < 0) {
 		dev_err(&tsdata->client->dev,
-	                "Unable to write to i2c touchscreen!\n");
+	                "Unable to read from i2c touchscreen!\n");
 		mutex_unlock(&tsdata->mutex);
 		return ret;
 	}
 	mutex_unlock(&tsdata->mutex);
 
-	if (ret != *value) {
+	if (ret != tsdata->settings[i]) {
 		dev_info(&tsdata->client->dev,
 		         "i2c read (%d) and stored value (%d) differ. Huh?\n",
-		         ret, *value);
-		*value = ret;
+		         ret, tsdata->settings[i]);
+		tsdata->settings[i] = ret;
 	}
 
 	return sprintf(buf, "%d\n", ret);
@@ -278,10 +330,21 @@ static ssize_t edt_ft5x06_i2c_setting_store(struct device *dev,
 {
 	struct edt_ft5x06_i2c_ts_data *tsdata = dev_get_drvdata(dev);
 	struct i2c_client *client = tsdata->client;
-	int ret = 0;
-	u8 addr;
+	int i, ret = 0;
 	unsigned int val;
 
+	for (i = 0; i < N_SETTINGS; i++) {
+		if (edt_ft5x06_i2c_attrs[i] == &attr->attr)
+			break;
+	}
+	
+	if (i == N_SETTINGS) {
+		dev_err(&client->dev,
+		        "unknown attribute for edt_ft5x06_i2c_setting_show: %s\n",
+		        attr->attr.name);
+		return -EINVAL;
+	}
+
 	mutex_lock(&tsdata->mutex);
 
 	if (tsdata->factory_mode) {
@@ -298,36 +361,14 @@ static ssize_t edt_ft5x06_i2c_setting_store(struct device *dev,
 		goto out;
 	}
 
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
-		goto out;
-	}
-
-	ret = edt_ft5x06_i2c_register_write(tsdata, addr, val);
+	if (val < edt_ft5x06_settings_data[i].min)
+		val = edt_ft5x06_settings_data[i].min;
+	else if (val > edt_ft5x06_settings_data[i].max)
+		val = edt_ft5x06_settings_data[i].max;
+	tsdata->settings[i] = val;
+	ret = edt_ft5x06_i2c_register_write(tsdata,
+	                                    edt_ft5x06_settings_data[i].addr,
+	                                    val);
 
 	if (ret < 0) {
 		dev_err(&tsdata->client->dev,
@@ -411,18 +452,11 @@ static ssize_t edt_ft5x06_i2c_mode_store(struct device *dev,
 				        i*5);
 
 			/* restore parameters */
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
+			for (i = 0; i < N_SETTINGS; i++) {
+				edt_ft5x06_i2c_register_write(tsdata,
+				                              edt_ft5x06_settings_data[i].addr,
+				                              tsdata->settings[i]);
+			}
 
 			enable_irq(tsdata->irq);
 		}
@@ -482,33 +516,6 @@ static ssize_t edt_ft5x06_i2c_raw_data_show(struct device *dev,
 }
 
 
-static DEVICE_ATTR(gain,      0664,
-                   edt_ft5x06_i2c_setting_show, edt_ft5x06_i2c_setting_store);
-static DEVICE_ATTR(offset,    0664,
-                   edt_ft5x06_i2c_setting_show, edt_ft5x06_i2c_setting_store);
-static DEVICE_ATTR(threshold, 0664,
-                   edt_ft5x06_i2c_setting_show, edt_ft5x06_i2c_setting_store);
-static DEVICE_ATTR(report_rate, 0664,
-                   edt_ft5x06_i2c_setting_show, edt_ft5x06_i2c_setting_store);
-static DEVICE_ATTR(mode,      0664,
-                   edt_ft5x06_i2c_mode_show, edt_ft5x06_i2c_mode_store);
-static DEVICE_ATTR(raw_data,  0444,
-                   edt_ft5x06_i2c_raw_data_show, NULL);
-
-static struct attribute *edt_ft5x06_i2c_attrs[] = {
-	&dev_attr_gain.attr,
-	&dev_attr_offset.attr,
-	&dev_attr_threshold.attr,
-	&dev_attr_report_rate.attr,
-	&dev_attr_mode.attr,
-	&dev_attr_raw_data.attr,
-	NULL
-};
-
-static const struct attribute_group edt_ft5x06_i2c_attr_group = {
-	.attrs = edt_ft5x06_i2c_attrs,
-};
-
 static int edt_ft5x06_i2c_ts_probe(struct i2c_client *client,
                                    const struct i2c_device_id *id)
 {
@@ -516,7 +523,7 @@ static int edt_ft5x06_i2c_ts_probe(struct i2c_client *client,
 	const struct edt_ft5x06_platform_data *pdata = client->dev.platform_data;
 	struct edt_ft5x06_i2c_ts_data *tsdata;
 	struct input_dev *input;
-	int error;
+	int i, error;
 	u8 rdbuf[23];
 	char *model_name, *fw_version;
 
@@ -586,14 +593,10 @@ static int edt_ft5x06_i2c_ts_probe(struct i2c_client *client,
 		goto err_free_irq_pin;
 	}
 
-	tsdata->threshold = edt_ft5x06_i2c_register_read(tsdata,
-	                                                 WORK_REGISTER_THRESHOLD);
-	tsdata->gain      = edt_ft5x06_i2c_register_read(tsdata,
-	                                                 WORK_REGISTER_GAIN);
-	tsdata->offset    = edt_ft5x06_i2c_register_read(tsdata,
-	                                                 WORK_REGISTER_OFFSET);
-	tsdata->report_rate = edt_ft5x06_i2c_register_read(tsdata,
-	                                                 WORK_REGISTER_REPORT_RATE);
+	for (i = 0; i < N_SETTINGS; i++) {
+		tsdata->settings[i] = edt_ft5x06_i2c_register_read(tsdata,
+		                                                   edt_ft5x06_settings_data[i].addr);
+	}
 	tsdata->num_x     = edt_ft5x06_i2c_register_read(tsdata,
 	                                                 WORK_REGISTER_NUM_X);
 	tsdata->num_y     = edt_ft5x06_i2c_register_read(tsdata,

--------------030701010604080206020506--
