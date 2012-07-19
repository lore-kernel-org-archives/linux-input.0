From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v8] Touchscreen driver for FT5x06 based EDT displays
Date: Wed, 18 Jul 2012 21:16:56 -0700
Message-ID: <20120719041656.GA3300@core.coreip.homeip.net>
References: <1341175006-24579-1-git-send-email-simon.budig@kernelconcepts.de>
 <1341763522-14374-1-git-send-email-simon.budig@kernelconcepts.de>
 <1341763522-14374-2-git-send-email-simon.budig@kernelconcepts.de>
 <20120709080640.GA4137@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58341 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728Ab2GSERJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Jul 2012 00:17:09 -0400
Received: by pbbrp8 with SMTP id rp8so3702325pbb.19
        for <linux-input@vger.kernel.org>; Wed, 18 Jul 2012 21:17:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120709080640.GA4137@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>, simon.budig@kernelconcepts.de
Cc: linux-input@vger.kernel.org, olivier@sobrie.be, agust@denx.de, yanok@emcraft.com

Hi Simon, Henrik,

On Mon, Jul 09, 2012 at 10:06:40AM +0200, Henrik Rydberg wrote:
> Hi Simon,
> 
> On Sun, Jul 08, 2012 at 06:05:22PM +0200, simon.budig@kernelconcepts.de wrote:
> > From: Simon Budig <simon.budig@kernelconcepts.de>
> > 
> > This is a driver for the EDT "Polytouch" family of touch controllers
> > based on the FocalTech FT5x06 line of chips.
> > 
> > Signed-off-by: Simon Budig <simon.budig@kernelconcepts.de>
> > ---
> 
> (The area below the '---' can be used for comments, instead of sending
> two mails.)
> 
> It is starting to look pretty good now, thank you. The remove() seems
> to leak memory, and I sprinkled some minor comments on the way.

OK, so the patch below should fix most of Henrik's comments and some of
mine. Compile-tested only though. It would be nice to have it verified
on real hardware so we could get it in in the next merge window.

Thanks.

-- 
Dmitry


Input: edt-ft5x06 - misc fixes

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

 Documentation/input/edt-ft5x06.txt     |    2 
 drivers/input/touchscreen/edt-ft5x06.c |  188 +++++++++++++++++---------------
 2 files changed, 100 insertions(+), 90 deletions(-)


diff --git a/Documentation/input/edt-ft5x06.txt b/Documentation/input/edt-ft5x06.txt
index d2f1444..2032f0b 100644
--- a/Documentation/input/edt-ft5x06.txt
+++ b/Documentation/input/edt-ft5x06.txt
@@ -52,5 +52,3 @@ raw_data:
 Note that reading raw_data gives a I/O error when the device is not in factory
 mode. The same happens when reading/writing to the parameter files when the
 device is not in regular operation mode.
-
-
diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 32d8840..a1c266a 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -36,8 +36,6 @@
 #include <linux/input/mt.h>
 #include <linux/input/edt-ft5x06.h>
 
-#define DRIVER_VERSION "v0.7"
-
 #define MAX_SUPPORT_POINTS		5
 
 #define WORK_REGISTER_THRESHOLD		0x00
@@ -69,7 +67,8 @@ struct edt_ft5x06_ts_data {
 
 #if defined(CONFIG_DEBUG_FS)
 	struct dentry *debug_dir;
-	u8 *raw_buffer;
+	u8 *raw_buffer;
+	size_t raw_bufsize;
 #endif
 
 	struct mutex mutex;
@@ -90,7 +89,6 @@ static int edt_ft5x06_ts_readwrite(struct i2c_client *client,
 	int i = 0;
 	int ret;
 
-	i = 0;
 	if (wr_len) {
 		wrmsg[i].addr  = client->addr;
 		wrmsg[i].flags = 0;
@@ -355,18 +353,20 @@ static const struct attribute_group edt_ft5x06_attr_group = {
 	.attrs = edt_ft5x06_attrs,
 };
 
-#if defined(CONFIG_DEBUG_FS)
+#ifdef CONFIG_DEBUG_FS
 static int edt_ft5x06_factory_mode(struct edt_ft5x06_ts_data *tsdata)
 {
+	struct i2c_client *client = tsdata->client;
 	int retries = EDT_SWITCH_MODE_RETRIES;
 	int ret;
 	int error;
 
-	disable_irq(tsdata->client->irq);
+	disable_irq(client->irq);
 
 	if (!tsdata->raw_buffer) {
-		tsdata->raw_buffer = kzalloc(tsdata->num_x * tsdata->num_x * 2,
-					     GFP_KERNEL);
+		tsdata->raw_bufsize = tsdata->num_x * tsdata->num_y *
+				      sizeof(u16);
+		tsdata->raw_buffer = kzalloc(tsdata->raw_bufsize, GFP_KERNEL);
 		if (!tsdata->raw_buffer) {
 			error = -ENOMEM;
 			goto err_out;
@@ -376,9 +376,8 @@ static int edt_ft5x06_factory_mode(struct edt_ft5x06_ts_data *tsdata)
 	/* mode register is 0x3c when in the work mode */
 	error = edt_ft5x06_register_write(tsdata, WORK_REGISTER_OPMODE, 0x03);
 	if (error) {
-		dev_err(&tsdata->client->dev,
-			"failed to switch to factory mode, error %d\n",
-			error);
+		dev_err(&client->dev,
+			"failed to switch to factory mode, error %d\n", error);
 		goto err_out;
 	}
 
@@ -392,8 +391,7 @@ static int edt_ft5x06_factory_mode(struct edt_ft5x06_ts_data *tsdata)
 	} while (--retries > 0);
 
 	if (retries == 0) {
-		dev_err(&tsdata->client->dev,
-			"not in factory mode after %dms.\n",
+		dev_err(&client->dev, "not in factory mode after %dms.\n",
 			EDT_SWITCH_MODE_RETRIES * EDT_SWITCH_MODE_DELAY);
 		error = -EIO;
 		goto err_out;
@@ -403,13 +401,16 @@ static int edt_ft5x06_factory_mode(struct edt_ft5x06_ts_data *tsdata)
 
 err_out:
 	kfree(tsdata->raw_buffer);
+	tsdata->raw_buffer = NULL;
 	tsdata->factory_mode = false;
-	enable_irq(tsdata->client->irq);
+	enable_irq(client->irq);
+
 	return error;
 }
 
 static int edt_ft5x06_work_mode(struct edt_ft5x06_ts_data *tsdata)
 {
+	struct i2c_client *client = tsdata->client;
 	int retries = EDT_SWITCH_MODE_RETRIES;
 	int ret;
 	int error;
@@ -417,9 +418,8 @@ static int edt_ft5x06_work_mode(struct edt_ft5x06_ts_data *tsdata)
 	/* mode register is 0x01 when in the factory mode */
 	error = edt_ft5x06_register_write(tsdata, FACTORY_REGISTER_OPMODE, 0x1);
 	if (error) {
-		dev_err(&tsdata->client->dev,
-			"failed to switch to work mode, error: %d\n",
-			error);
+		dev_err(&client->dev,
+			"failed to switch to work mode, error: %d\n", error);
 		return error;
 	}
 
@@ -434,8 +434,7 @@ static int edt_ft5x06_work_mode(struct edt_ft5x06_ts_data *tsdata)
 	} while (--retries > 0);
 
 	if (retries == 0) {
-		dev_err(&tsdata->client->dev,
-			"not in work mode after %dms.\n",
+		dev_err(&client->dev, "not in work mode after %dms.\n",
 			EDT_SWITCH_MODE_RETRIES * EDT_SWITCH_MODE_DELAY);
 		tsdata->factory_mode = true;
 		return -EIO;
@@ -454,22 +453,24 @@ static int edt_ft5x06_work_mode(struct edt_ft5x06_ts_data *tsdata)
 	edt_ft5x06_register_write(tsdata, WORK_REGISTER_REPORT_RATE,
 				  tsdata->report_rate);
 
-	enable_irq(tsdata->client->irq);
+	enable_irq(client->irq);
 
 	return 0;
 }
 
-ssize_t edt_ft5x06_debugfs_mode_get(void *data, u64 *mode)
+static int edt_ft5x06_debugfs_mode_get(void *data, u64 *mode)
 {
 	struct edt_ft5x06_ts_data *tsdata = data;
+
 	*mode = tsdata->factory_mode;
+
 	return 0;
 };
 
-ssize_t edt_ft5x06_debugfs_mode_set(void *data, u64 mode)
+static int edt_ft5x06_debugfs_mode_set(void *data, u64 mode)
 {
 	struct edt_ft5x06_ts_data *tsdata = data;
-	int error = 0;
+	int retval = 0;
 
 	if (mode > 1)
 		return -ERANGE;
@@ -477,13 +478,13 @@ ssize_t edt_ft5x06_debugfs_mode_set(void *data, u64 mode)
 	mutex_lock(&tsdata->mutex);
 
 	if (mode != tsdata->factory_mode) {
-		error = mode ? edt_ft5x06_factory_mode(tsdata) :
-			       edt_ft5x06_work_mode(tsdata);
+		retval = mode ? edt_ft5x06_factory_mode(tsdata) :
+			        edt_ft5x06_work_mode(tsdata);
 	}
 
 	mutex_unlock(&tsdata->mutex);
 
-	return error;
+	return retval;
 };
 
 DEFINE_SIMPLE_ATTRIBUTE(debugfs_mode_fops, edt_ft5x06_debugfs_mode_get,
@@ -493,24 +494,23 @@ static int edt_ft5x06_debugfs_raw_data_open(struct inode *inode,
 					    struct file *file)
 {
 	file->private_data = inode->i_private;
+
 	return 0;
 }
 
-ssize_t edt_ft5x06_debugfs_raw_data_read(struct file *file,
-					 char *buf,
-					 size_t count,
-					 loff_t *off)
+static ssize_t edt_ft5x06_debugfs_raw_data_read(struct file *file,
+				char __user *buf, size_t count, loff_t *off)
 {
 	struct edt_ft5x06_ts_data *tsdata = file->private_data;
+	struct i2c_client *client = tsdata->client;
 	int retries  = EDT_RAW_DATA_RETRIES;
-	int ret = 0, i, error;
+	int val, i, error;
+	size_t read;
 	int colbytes;
 	char wrbuf[3];
 	u8 *rdbuf;
 
-	colbytes = tsdata->num_y * 2;
-
-	if (*off < 0 || *off >= tsdata->num_x * colbytes)
+	if (*off < 0 || *off >= tsdata->raw_bufsize)
 		return 0;
 
 	mutex_lock(&tsdata->mutex);
@@ -522,35 +522,34 @@ ssize_t edt_ft5x06_debugfs_raw_data_read(struct file *file,
 
 	error = edt_ft5x06_register_write(tsdata, 0x08, 0x01);
 	if (error) {
-		dev_dbg(&tsdata->client->dev,
-			"failed to write 0x08 register, error %d\n",
-			error);
+		dev_dbg(&client->dev,
+			"failed to write 0x08 register, error %d\n", error);
 		goto out;
 	}
 
 	do {
 		msleep(EDT_RAW_DATA_DELAY);
-		ret = edt_ft5x06_register_read(tsdata, 0x08);
-		if (ret < 1)
+		val = edt_ft5x06_register_read(tsdata, 0x08);
+		if (val < 1)
 			break;
 	} while (--retries > 0);
 
-	if (ret < 0) {
-		error = ret;
-		dev_dbg(&tsdata->client->dev,
-			"failed to read 0x08 register, error %d\n",
-			error);
+	if (val < 0) {
+		error = val;
+		dev_dbg(&client->dev,
+			"failed to read 0x08 register, error %d\n", error);
 		goto out;
 	}
 
 	if (retries == 0) {
-		dev_dbg(&tsdata->client->dev,
+		dev_dbg(&client->dev,
 			"timed out waiting for register to settle\n");
 		error = -ETIMEDOUT;
 		goto out;
 	}
 
 	rdbuf = tsdata->raw_buffer;
+	colbytes = tsdata->num_y * sizeof(u16);
 
 	wrbuf[0] = 0xf5;
 	wrbuf[1] = 0x0e;
@@ -565,16 +564,13 @@ ssize_t edt_ft5x06_debugfs_raw_data_read(struct file *file,
 		rdbuf += colbytes;
 	}
 
-	/* rdbuf now points to the end of the raw_buffer */
-
-	ret = min(count, (size_t) ((rdbuf - tsdata->raw_buffer) - *off));
-
-	error = copy_to_user(buf, tsdata->raw_buffer + *off, ret);
+	read = min_t(size_t, count, tsdata->raw_bufsize - *off);
+	error = copy_to_user(buf, tsdata->raw_buffer + *off, read);
 	if (!error)
-		*off += ret;
+		*off += read;
 out:
 	mutex_unlock(&tsdata->mutex);
-	return error ?: ret;
+	return error ?: read;
 };
 
 
@@ -582,7 +578,47 @@ static const struct file_operations debugfs_raw_data_fops = {
 	.open = edt_ft5x06_debugfs_raw_data_open,
 	.read = edt_ft5x06_debugfs_raw_data_read,
 };
-#endif
+
+static void __devinit
+edt_ft5x06_ts_prepare_debugfs(struct edt_ft5x06_ts_data *tsdata,
+			      const char *debugfs_name)
+{
+	tsdata->debug_dir = debugfs_create_dir(debugfs_name, NULL);
+	if (!tsdata->debug_dir)
+		return;
+
+	debugfs_create_u16("num_x", S_IRUSR, tsdata->debug_dir, &tsdata->num_x);
+	debugfs_create_u16("num_y", S_IRUSR, tsdata->debug_dir, &tsdata->num_y);
+
+	debugfs_create_file("mode", S_IRUSR | S_IWUSR,
+			    tsdata->debug_dir, tsdata, &debugfs_mode_fops);
+	debugfs_create_file("raw_data", S_IRUSR,
+			    tsdata->debug_dir, tsdata, &debugfs_raw_data_fops);
+}
+
+static void __devexit
+edt_ft5x06_ts_teardown_debugfs(struct edt_ft5x06_ts_data *tsdata)
+{
+	if (tsdata->debug_dir)
+		debugfs_remove_recursive(tsdata->debug_dir);
+}
+
+#else
+
+static inline void
+edt_ft5x06_ts_prepare_debugfs(struct edt_ft5x06_ts_data *tsdata,
+			      const char *debugfs_name)
+{
+}
+
+static inline void
+edt_ft5x06_ts_teardown_debugfs(struct edt_ft5x06_ts_data *tsdata)
+{
+}
+
+#endif /* CONFIG_DEBUGFS */
+
+
 
 static int __devinit edt_ft5x06_ts_reset(struct i2c_client *client,
 					 int reset_pin)
@@ -637,8 +673,9 @@ static int __devinit edt_ft5x06_ts_identify(struct i2c_client *client,
 	return 0;
 }
 
-static void edt_ft5x06_ts_get_defaults(struct edt_ft5x06_ts_data *tsdata,
-				const struct edt_ft5x06_platform_data *pdata)
+static void __devinit
+edt_ft5x06_ts_get_defaults(struct edt_ft5x06_ts_data *tsdata,
+			   const struct edt_ft5x06_platform_data *pdata)
 {
 	if (!pdata->use_parameters)
 		return;
@@ -665,7 +702,8 @@ static void edt_ft5x06_ts_get_defaults(struct edt_ft5x06_ts_data *tsdata,
 					  pdata->report_rate);
 }
 
-static void edt_ft5x06_ts_get_parameters(struct edt_ft5x06_ts_data *tsdata)
+static void __devinit
+edt_ft5x06_ts_get_parameters(struct edt_ft5x06_ts_data *tsdata)
 {
 	tsdata->threshold = edt_ft5x06_register_read(tsdata,
 						     WORK_REGISTER_THRESHOLD);
@@ -677,28 +715,6 @@ static void edt_ft5x06_ts_get_parameters(struct edt_ft5x06_ts_data *tsdata)
 	tsdata->num_y = edt_ft5x06_register_read(tsdata, WORK_REGISTER_NUM_Y);
 }
 
-#if defined(CONFIG_DEBUG_FS)
-static void edt_ft5x06_ts_prepare_debugfs(struct edt_ft5x06_ts_data *tsdata,
-					  const char *debugfs_name)
-{
-	tsdata->debug_dir = debugfs_create_dir(debugfs_name, NULL);
-
-	if (!tsdata->debug_dir)
-		return;
-
-	debugfs_create_u16("num_x", S_IRUSR, tsdata->debug_dir, &tsdata->num_x);
-	debugfs_create_u16("num_y", S_IRUSR, tsdata->debug_dir, &tsdata->num_y);
-
-	debugfs_create_file("mode", S_IRUSR | S_IWUSR,
-			    tsdata->debug_dir, tsdata,
-			    &debugfs_mode_fops);
-
-	debugfs_create_file("raw_data", S_IRUSR,
-			    tsdata->debug_dir, tsdata,
-			    &debugfs_raw_data_fops);
-}
-#endif
-
 static int __devinit edt_ft5x06_ts_probe(struct i2c_client *client,
 					 const struct i2c_device_id *id)
 {
@@ -796,13 +812,10 @@ static int __devinit edt_ft5x06_ts_probe(struct i2c_client *client,
 	if (error)
 		goto err_remove_attrs;
 
-#if defined(CONFIG_DEBUG_FS)
 	edt_ft5x06_ts_prepare_debugfs(tsdata, dev_driver_string(&client->dev));
-#endif
-
 	device_init_wakeup(&client->dev, 1);
 
-	dev_dbg(&tsdata->client->dev,
+	dev_dbg(&client->dev,
 		"EDT FT5x06 initialized: IRQ pin %d, Reset pin %d.\n",
 		pdata->irq_pin, pdata->reset_pin);
 
@@ -825,22 +838,21 @@ err_free_mem:
 static int __devexit edt_ft5x06_ts_remove(struct i2c_client *client)
 {
 	const struct edt_ft5x06_platform_data *pdata =
-						client->dev.platform_data;
+						dev_get_platdata(&client->dev);
 	struct edt_ft5x06_ts_data *tsdata = i2c_get_clientdata(client);
 
-#if defined(CONFIG_DEBUG_FS)
-	if (tsdata->debug_dir)
-		debugfs_remove_recursive(tsdata->debug_dir);
-#endif
-
+	edt_ft5x06_ts_teardown_debugfs(tsdata);
 	sysfs_remove_group(&client->dev.kobj, &edt_ft5x06_attr_group);
 
 	free_irq(client->irq, tsdata);
 	input_unregister_device(tsdata->input);
+
 	if (gpio_is_valid(pdata->irq_pin))
 		gpio_free(pdata->irq_pin);
 	if (gpio_is_valid(pdata->reset_pin))
 		gpio_free(pdata->reset_pin);
+
+	kfree(tsdata->raw_buffer);
 	kfree(tsdata);
 
 	return 0;
