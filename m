From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 6/7] Input: cyttsp - use unified structure for ts object
Date: Mon, 14 Nov 2011 00:16:12 -0800
Message-ID: <20111114081612.10141.19141.stgit@hammer.corenet.prv>
References: <20111114080939.10141.46174.stgit@hammer.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34009 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752507Ab1KNIQQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Nov 2011 03:16:16 -0500
Received: by mail-iy0-f174.google.com with SMTP id e36so6951500iag.19
        for <linux-input@vger.kernel.org>; Mon, 14 Nov 2011 00:16:15 -0800 (PST)
In-Reply-To: <20111114080939.10141.46174.stgit@hammer.corenet.prv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Mohan Pallaka <mpallaka@codeaurora.org>, Kevin McNeely <kev@cypress.com>, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, linux-input@vger.kernel.org

Have bus implementation request needed transfer buffer size
and consolidate everything into single touchscreen object.
Make sure that the transfer buffer is cache line aligned as
required by SPI interface.

Also rework the probe routine to request IRQ right away and
ensure that we return properly encoded error codes.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/touchscreen/cyttsp_core.c |  284 ++++++++++---------------------
 drivers/input/touchscreen/cyttsp_core.h |   91 +++++++++-
 drivers/input/touchscreen/cyttsp_i2c.c  |   95 ++++------
 drivers/input/touchscreen/cyttsp_spi.c  |  128 ++++++--------
 4 files changed, 274 insertions(+), 324 deletions(-)

diff --git a/drivers/input/touchscreen/cyttsp_core.c b/drivers/input/touchscreen/cyttsp_core.c
index 764efd6..ccdfa10 100644
--- a/drivers/input/touchscreen/cyttsp_core.c
+++ b/drivers/input/touchscreen/cyttsp_core.c
@@ -72,86 +72,6 @@
 #define CY_MAX_FINGER               4
 #define CY_MAX_ID                   16
 
-struct cyttsp_tch {
-	__be16 x, y;
-	u8 z;
-} __packed;
-
-/* TrueTouch Standard Product Gen3 interface definition */
-struct cyttsp_xydata {
-	u8 hst_mode;
-	u8 tt_mode;
-	u8 tt_stat;
-	struct cyttsp_tch tch1;
-	u8 touch12_id;
-	struct cyttsp_tch tch2;
-	u8 gest_cnt;
-	u8 gest_id;
-	struct cyttsp_tch tch3;
-	u8 touch34_id;
-	struct cyttsp_tch tch4;
-	u8 tt_undef[3];
-	u8 act_dist;
-	u8 tt_reserved;
-} __packed;
-
-/* TTSP System Information interface definition */
-struct cyttsp_sysinfo_data {
-	u8 hst_mode;
-	u8 mfg_cmd;
-	u8 mfg_stat;
-	u8 cid[3];
-	u8 tt_undef1;
-	u8 uid[8];
-	u8 bl_verh;
-	u8 bl_verl;
-	u8 tts_verh;
-	u8 tts_verl;
-	u8 app_idh;
-	u8 app_idl;
-	u8 app_verh;
-	u8 app_verl;
-	u8 tt_undef[5];
-	u8 scn_typ;
-	u8 act_intrvl;
-	u8 tch_tmout;
-	u8 lp_intrvl;
-};
-
-/* TTSP Bootloader Register Map interface definition */
-#define CY_BL_CHKSUM_OK 0x01
-struct cyttsp_bootloader_data {
-	u8 bl_file;
-	u8 bl_status;
-	u8 bl_error;
-	u8 blver_hi;
-	u8 blver_lo;
-	u8 bld_blver_hi;
-	u8 bld_blver_lo;
-	u8 ttspver_hi;
-	u8 ttspver_lo;
-	u8 appid_hi;
-	u8 appid_lo;
-	u8 appver_hi;
-	u8 appver_lo;
-	u8 cid_0;
-	u8 cid_1;
-	u8 cid_2;
-};
-
-struct cyttsp {
-	struct device *dev;
-	int irq;
-	struct input_dev *input;
-	char phys[32];
-	const struct cyttsp_platform_data *platform_data;
-	const struct cyttsp_bus_ops *bus_ops;
-	struct cyttsp_bootloader_data bl_data;
-	struct cyttsp_sysinfo_data sysinfo_data;
-	struct completion bl_ready;
-	enum cyttsp_powerstate power_state;
-};
-
 static const u8 bl_command[] = {
 	0x00,			/* file offset */
 	0xFF,			/* command */
@@ -242,9 +162,9 @@ static int cyttsp_exit_bl_mode(struct cyttsp *ts)
 	u8 bl_cmd[sizeof(bl_command)];
 
 	memcpy(bl_cmd, bl_command, sizeof(bl_command));
-	if (ts->platform_data->bl_keys)
+	if (ts->pdata->bl_keys)
 		memcpy(&bl_cmd[sizeof(bl_command) - CY_NUM_BL_KEYS],
-			ts->platform_data->bl_keys, sizeof(bl_command));
+			ts->pdata->bl_keys, sizeof(bl_command));
 
 	retval = ttsp_write_block_data(ts, CY_REG_BASE,
 		sizeof(bl_cmd), (void *)bl_cmd);
@@ -324,15 +244,15 @@ static int cyttsp_set_sysinfo_regs(struct cyttsp *ts)
 {
 	int retval = 0;
 
-	if (ts->platform_data->act_intrvl != CY_ACT_INTRVL_DFLT ||
-		ts->platform_data->tch_tmout != CY_TCH_TMOUT_DFLT ||
-		ts->platform_data->lp_intrvl != CY_LP_INTRVL_DFLT) {
+	if (ts->pdata->act_intrvl != CY_ACT_INTRVL_DFLT ||
+		ts->pdata->tch_tmout != CY_TCH_TMOUT_DFLT ||
+		ts->pdata->lp_intrvl != CY_LP_INTRVL_DFLT) {
 
 		u8 intrvl_ray[3];
 
-		intrvl_ray[0] = ts->platform_data->act_intrvl;
-		intrvl_ray[1] = ts->platform_data->tch_tmout;
-		intrvl_ray[2] = ts->platform_data->lp_intrvl;
+		intrvl_ray[0] = ts->pdata->act_intrvl;
+		intrvl_ray[1] = ts->pdata->tch_tmout;
+		intrvl_ray[2] = ts->pdata->lp_intrvl;
 
 		/* set intrvl registers */
 		retval = ttsp_write_block_data(ts,
@@ -366,7 +286,7 @@ static int cyttsp_act_dist_setup(struct cyttsp *ts)
 	u8 act_dist_setup;
 
 	/* Init gesture; active distance setup */
-	act_dist_setup = ts->platform_data->act_dist;
+	act_dist_setup = ts->pdata->act_dist;
 	retval = ttsp_write_block_data(ts, CY_REG_ACT_DIST,
 		sizeof(act_dist_setup), &act_dist_setup);
 
@@ -439,7 +359,7 @@ static int cyttsp_handle_tchdata(struct cyttsp *ts)
 		return 0;
 
 	/* provide flow control handshake */
-	if (ts->platform_data->use_hndshk)
+	if (ts->pdata->use_hndshk)
 		if (cyttsp_hndshk(ts, xy_data.hst_mode))
 			return 0;
 
@@ -537,17 +457,8 @@ static int cyttsp_power_on(struct cyttsp *ts)
 {
 	int retval = 0;
 
-	if (!ts)
-		return -ENOMEM;
-
 	ts->power_state = CY_BL_STATE;
-
-	/* enable interrupts */
-	retval = request_threaded_irq(ts->irq, NULL, cyttsp_irq,
-		IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-		ts->platform_data->name, ts);
-	if (retval < 0)
-		goto bypass;
+	enable_irq(ts->irq);
 
 	retval = cyttsp_soft_reset(ts);
 	if (retval == 0)
@@ -593,20 +504,19 @@ bypass:
 }
 
 #ifdef CONFIG_PM_SLEEP
-int cyttsp_resume(void *handle)
+int cyttsp_resume(struct cyttsp *ts)
 {
-	struct cyttsp *ts = handle;
 	int retval = 0;
 	struct cyttsp_xydata xydata;
 
 	if (!ts)
 		return retval;
 
-	if (ts->platform_data->use_sleep && (ts->power_state !=
+	if (ts->pdata->use_sleep && (ts->power_state !=
 					     CY_ACTIVE_STATE)) {
 
-		if (ts->platform_data->wakeup)
-			retval = ts->platform_data->wakeup();
+		if (ts->pdata->wakeup)
+			retval = ts->pdata->wakeup();
 		else
 			retval = -ENOSYS;
 
@@ -624,15 +534,14 @@ int cyttsp_resume(void *handle)
 }
 EXPORT_SYMBOL_GPL(cyttsp_resume);
 
-int cyttsp_suspend(void *handle)
+int cyttsp_suspend(struct cyttsp *ts)
 {
-	struct cyttsp *ts = handle;
 	u8 sleep_mode = 0;
 	int retval = 0;
 
-	if (ts->platform_data->use_sleep &&
+	if (ts->pdata->use_sleep &&
 		(ts->power_state == CY_ACTIVE_STATE)) {
-		sleep_mode = ts->platform_data->use_sleep;
+		sleep_mode = ts->pdata->use_sleep;
 		retval = ttsp_write_block_data(ts,
 			CY_REG_BASE, sizeof(sleep_mode), &sleep_mode);
 		if (retval >= 0)
@@ -651,115 +560,112 @@ static int cyttsp_open(struct input_dev *dev)
 	return cyttsp_power_on(ts);
 }
 
-void cyttsp_core_release(void *handle)
-{
-	struct cyttsp *ts = handle;
-
-	if (ts) {
-		free_irq(ts->irq, ts);
-		input_unregister_device(ts->input);
-		if (ts->platform_data->exit)
-			ts->platform_data->exit();
-		kfree(ts);
-	}
-}
-EXPORT_SYMBOL_GPL(cyttsp_core_release);
-
 static void cyttsp_close(struct input_dev *dev)
 {
 	struct cyttsp *ts = input_get_drvdata(dev);
 
-	free_irq(ts->irq, ts);
+	disable_irq(ts->irq);
 }
 
-void *cyttsp_core_init(const struct cyttsp_bus_ops *bus_ops,
-		       struct device *dev, int irq)
+struct cyttsp *cyttsp_probe(const struct cyttsp_bus_ops *bus_ops,
+			    struct device *dev, int irq, size_t xfer_buf_size)
 {
-	struct input_dev *input_device;
-	int ret;
-
-	struct cyttsp *ts = kzalloc(sizeof(*ts), GFP_KERNEL);
-
-	if (!ts) {
-		pr_err("%s: Error, kzalloc\n", __func__);
-		goto error_alloc_data;
+	const struct cyttsp_platform_data *pdata = dev->platform_data;
+	struct cyttsp *ts;
+	struct input_dev *input_dev;
+	int error;
+
+	if (!dev || !bus_ops || !pdata || !pdata->name || irq <= 0) {
+		error = -EINVAL;
+		goto err_out;
 	}
 
-	if (dev == NULL || bus_ops == NULL) {
-		kfree(ts);
-		goto error_alloc_data;
+	ts = kzalloc(sizeof(*ts) + xfer_buf_size, GFP_KERNEL);
+	input_dev = input_allocate_device();
+	if (!ts || !input_dev) {
+		error = -ENOMEM;
+		goto err_free_mem;
 	}
 
 	ts->dev = dev;
-	ts->platform_data = dev->platform_data;
+	ts->input = input_dev;
+	ts->pdata = pdata;
 	ts->bus_ops = bus_ops;
+	ts->irq = irq;
+
 	init_completion(&ts->bl_ready);
+	snprintf(ts->phys, sizeof(ts->phys), "%s/input0", dev_name(dev));
 
-	if (ts->platform_data->init) {
-		if (ts->platform_data->init()) {
-			dev_dbg(ts->dev, "%s: Error, platform init failed!\n",
-				__func__);
-			goto error_init;
+	if (pdata->init) {
+		error = pdata->init();
+		if (error) {
+			dev_err(ts->dev, "platform init failed, err: %d\n",
+				error);
+			goto err_free_mem;
 		}
 	}
 
-	ts->irq = irq;
-	if (ts->irq <= 0) {
-		dev_dbg(ts->dev, "%s: Error, failed to allocate irq\n",
-			__func__);
-			goto error_init;
-	}
+	input_dev->name = pdata->name;
+	input_dev->phys = ts->phys;
+	input_dev->id.bustype = bus_ops->bustype;
+	input_dev->dev.parent = ts->dev;
 
-	/* Create the input device and register it. */
-	input_device = input_allocate_device();
-	if (!input_device) {
-		dev_dbg(ts->dev, "%s: Error, failed to allocate input device\n",
-			__func__);
-		goto error_input_allocate_device;
-	}
+	input_dev->open = cyttsp_open;
+	input_dev->close = cyttsp_close;
 
-	ts->input = input_device;
-	snprintf(ts->phys, sizeof(ts->phys), "%s/input0", dev_name(dev));
+	input_set_drvdata(input_dev, ts);
 
-	input_device->name = ts->platform_data->name;
-	input_device->phys = ts->phys;
-	input_device->id.bustype = bus_ops->bustype;
-	input_device->dev.parent = ts->dev;
-	input_device->open = cyttsp_open;
-	input_device->close = cyttsp_close;
-	input_set_drvdata(input_device, ts);
-
-	__set_bit(EV_ABS, input_device->evbit);
-	input_set_abs_params(input_device, ABS_MT_POSITION_X,
-			     0, ts->platform_data->maxx, 0, 0);
-	input_set_abs_params(input_device, ABS_MT_POSITION_Y,
-			     0, ts->platform_data->maxy, 0, 0);
-	input_set_abs_params(input_device, ABS_MT_TOUCH_MAJOR,
+	__set_bit(EV_ABS, input_dev->evbit);
+	input_set_abs_params(input_dev, ABS_MT_POSITION_X,
+			     0, pdata->maxx, 0, 0);
+	input_set_abs_params(input_dev, ABS_MT_POSITION_Y,
+			     0, pdata->maxy, 0, 0);
+	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR,
 			     0, CY_MAXZ, 0, 0);
 
-	input_mt_init_slots(input_device, CY_MAX_ID);
+	input_mt_init_slots(input_dev, CY_MAX_ID);
 
-	ret = input_register_device(input_device);
-	if (ret) {
-		dev_err(ts->dev, "%s: Error, failed to register input device: %d\n",
-			__func__, ret);
-		goto error_input_register_device;
+	error = request_threaded_irq(ts->irq, NULL, cyttsp_irq,
+				     IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+				     pdata->name, ts);
+	if (error) {
+		dev_err(ts->dev, "failed to request IRQ %d, err: %d\n",
+			ts->irq, error);
+		goto err_platform_exit;
 	}
+	disable_irq(ts->irq);
 
-	goto no_error;
+	error = input_register_device(input_dev);
+	if (error) {
+		dev_err(ts->dev, "failed to register input device: %d\n",
+			error);
+		goto err_free_irq;
+	}
 
-error_input_register_device:
-	input_free_device(input_device);
-error_input_allocate_device:
-	if (ts->platform_data->exit)
-		ts->platform_data->exit();
-error_init:
-	kfree(ts);
-error_alloc_data:
-no_error:
 	return ts;
+
+err_free_irq:
+	free_irq(ts->irq, ts);
+err_platform_exit:
+	if (pdata->exit)
+		pdata->exit();
+err_free_mem:
+	input_free_device(input_dev);
+	kfree(ts);
+err_out:
+	return ERR_PTR(error);
+}
+EXPORT_SYMBOL_GPL(cyttsp_probe);
+
+void cyttsp_remove(struct cyttsp *ts)
+{
+	free_irq(ts->irq, ts);
+	input_unregister_device(ts->input);
+	if (ts->pdata->exit)
+		ts->pdata->exit();
+	kfree(ts);
 }
-EXPORT_SYMBOL_GPL(cyttsp_core_init);
+EXPORT_SYMBOL_GPL(cyttsp_remove);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Cypress TrueTouch(R) Standard touchscreen driver core");
diff --git a/drivers/input/touchscreen/cyttsp_core.h b/drivers/input/touchscreen/cyttsp_core.h
index 979a2f1..1d9f185 100644
--- a/drivers/input/touchscreen/cyttsp_core.h
+++ b/drivers/input/touchscreen/cyttsp_core.h
@@ -41,6 +41,73 @@
 
 #define CY_NUM_RETRY                4 /* max number of retries for read ops */
 
+struct cyttsp_tch {
+	__be16 x, y;
+	u8 z;
+} __packed;
+
+/* TrueTouch Standard Product Gen3 interface definition */
+struct cyttsp_xydata {
+	u8 hst_mode;
+	u8 tt_mode;
+	u8 tt_stat;
+	struct cyttsp_tch tch1;
+	u8 touch12_id;
+	struct cyttsp_tch tch2;
+	u8 gest_cnt;
+	u8 gest_id;
+	struct cyttsp_tch tch3;
+	u8 touch34_id;
+	struct cyttsp_tch tch4;
+	u8 tt_undef[3];
+	u8 act_dist;
+	u8 tt_reserved;
+} __packed;
+
+
+/* TTSP System Information interface definition */
+struct cyttsp_sysinfo_data {
+	u8 hst_mode;
+	u8 mfg_cmd;
+	u8 mfg_stat;
+	u8 cid[3];
+	u8 tt_undef1;
+	u8 uid[8];
+	u8 bl_verh;
+	u8 bl_verl;
+	u8 tts_verh;
+	u8 tts_verl;
+	u8 app_idh;
+	u8 app_idl;
+	u8 app_verh;
+	u8 app_verl;
+	u8 tt_undef[5];
+	u8 scn_typ;
+	u8 act_intrvl;
+	u8 tch_tmout;
+	u8 lp_intrvl;
+};
+
+/* TTSP Bootloader Register Map interface definition */
+#define CY_BL_CHKSUM_OK 0x01
+struct cyttsp_bootloader_data {
+	u8 bl_file;
+	u8 bl_status;
+	u8 bl_error;
+	u8 blver_hi;
+	u8 blver_lo;
+	u8 bld_blver_hi;
+	u8 bld_blver_lo;
+	u8 ttspver_hi;
+	u8 ttspver_lo;
+	u8 appid_hi;
+	u8 appid_lo;
+	u8 appver_hi;
+	u8 appver_lo;
+	u8 cid_0;
+	u8 cid_1;
+	u8 cid_2;
+};
 
 struct cyttsp_bus_ops {
 	u16 bustype;
@@ -49,13 +116,27 @@ struct cyttsp_bus_ops {
 	int (*read)(struct device *dev, u8 addr, u8 length, void *values);
 };
 
-void *cyttsp_core_init(const struct cyttsp_bus_ops *bus_ops,
-		       struct device *dev, int irq);
+struct cyttsp {
+	struct device *dev;
+	int irq;
+	struct input_dev *input;
+	char phys[32];
+	const struct cyttsp_platform_data *pdata;
+	const struct cyttsp_bus_ops *bus_ops;
+	struct cyttsp_bootloader_data bl_data;
+	struct cyttsp_sysinfo_data sysinfo_data;
+	struct completion bl_ready;
+	enum cyttsp_powerstate power_state;
+
+	u8 xfer_buf[] ____cacheline_aligned;
+};
 
-void cyttsp_core_release(void *handle);
+struct cyttsp *cyttsp_probe(const struct cyttsp_bus_ops *bus_ops,
+			    struct device *dev, int irq, size_t xfer_buf_size);
+void cyttsp_remove(struct cyttsp *ts);
 #ifdef CONFIG_PM_SLEEP
-int cyttsp_resume(void *handle);
-int cyttsp_suspend(void *handle);
+int cyttsp_resume(struct cyttsp *ts);
+int cyttsp_suspend(struct cyttsp *ts);
 #endif
 
 #endif /* __CYTTSP_CORE_H__ */
diff --git a/drivers/input/touchscreen/cyttsp_i2c.c b/drivers/input/touchscreen/cyttsp_i2c.c
index 3c2dd9d..b476441 100644
--- a/drivers/input/touchscreen/cyttsp_i2c.c
+++ b/drivers/input/touchscreen/cyttsp_i2c.c
@@ -33,28 +33,20 @@
 
 #include <linux/i2c.h>
 #include <linux/input.h>
-#include <linux/slab.h>
 
 #define CY_I2C_DATA_SIZE  128
 
-struct cyttsp_i2c {
-	struct i2c_client *client;
-	void *ttsp_client;
-	u8 wr_buf[CY_I2C_DATA_SIZE];
-};
-
-static int ttsp_i2c_read_block_data(struct device *dev,
-				    u8 addr, u8 length, void *values)
+static int cyttsp_i2c_read_block_data(struct device *dev,
+				      u8 addr, u8 length, void *values)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	struct cyttsp_i2c *ts = i2c_get_clientdata(client);
-	int retval = 0;
+	int retval;
 
-	retval = i2c_master_send(ts->client, &addr, 1);
+	retval = i2c_master_send(client, &addr, 1);
 	if (retval < 0)
 		return retval;
 
-	retval = i2c_master_recv(ts->client, values, length);
+	retval = i2c_master_recv(client, values, length);
 
 	if (retval != length)
 		return -EIO;
@@ -62,67 +54,55 @@ static int ttsp_i2c_read_block_data(struct device *dev,
 	return (retval < 0) ? retval : 0;
 }
 
-static int ttsp_i2c_write_block_data(struct device *dev,
-				     u8 addr, u8 length, const void *values)
+static int cyttsp_i2c_write_block_data(struct device *dev,
+				       u8 addr, u8 length, const void *values)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	struct cyttsp_i2c *ts = i2c_get_clientdata(client);
+	struct cyttsp *ts = i2c_get_clientdata(client);
 	int retval;
 
-	ts->wr_buf[0] = addr;
-	memcpy(&ts->wr_buf[1], values, length);
+	ts->xfer_buf[0] = addr;
+	memcpy(&ts->xfer_buf[1], values, length);
 
-	retval = i2c_master_send(ts->client, ts->wr_buf, length+1);
+	retval = i2c_master_send(client, ts->xfer_buf, length + 1);
+	if (retval < 0)
+		return retval;
 
 	if (retval != length)
 		return -EIO;
 
-	return (retval < 0) ? retval : 0;
+	return 0;
 }
 
 static const struct cyttsp_bus_ops cyttsp_i2c_bus_ops = {
 	.bustype	= BUS_I2C,
-	.write		= ttsp_i2c_write_block_data,
-	.read		= ttsp_i2c_read_block_data,
+	.write		= cyttsp_i2c_write_block_data,
+	.read		= cyttsp_i2c_read_block_data,
 };
 
 static int __devinit cyttsp_i2c_probe(struct i2c_client *client,
 				      const struct i2c_device_id *id)
 {
-	struct cyttsp_i2c *ts;
+	struct cyttsp *ts;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
 		return -EIO;
 
-	/* allocate and clear memory */
-	ts = kzalloc(sizeof(*ts), GFP_KERNEL);
-	if (!ts) {
-		dev_dbg(&client->dev, "%s: Error, kzalloc.\n", __func__);
-		return -ENOMEM;
-	}
+	ts = cyttsp_probe(&cyttsp_i2c_bus_ops, &client->dev, client->irq,
+			  CY_I2C_DATA_SIZE);
+	if (IS_ERR(ts))
+		return PTR_ERR(ts);
 
-	/* register driver_data */
-	ts->client = client;
 	i2c_set_clientdata(client, ts);
 
-	ts->ttsp_client = cyttsp_core_init(&cyttsp_i2c_bus_ops, &client->dev, client->irq);
-	if (IS_ERR(ts->ttsp_client)) {
-		int retval = PTR_ERR(ts->ttsp_client);
-		kfree(ts);
-		return retval;
-	}
-
 	return 0;
 }
 
-
-/* registered in driver struct */
 static int __devexit cyttsp_i2c_remove(struct i2c_client *client)
 {
-	struct cyttsp_i2c *ts = i2c_get_clientdata(client);
+	struct cyttsp *ts = i2c_get_clientdata(client);
 
-	cyttsp_core_release(ts->ttsp_client);
-	kfree(ts);
+	cyttsp_remove(ts);
 
 	return 0;
 }
@@ -131,52 +111,51 @@ static int __devexit cyttsp_i2c_remove(struct i2c_client *client)
 static int cyttsp_i2c_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	struct cyttsp_i2c *ts = i2c_get_clientdata(client);
+	struct cyttsp *ts = i2c_get_clientdata(client);
 
-	return cyttsp_suspend(ts->ttsp_client);
+	return cyttsp_suspend(ts);
 }
 
 static int cyttsp_i2c_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	struct cyttsp_i2c *ts = i2c_get_clientdata(client);
+	struct cyttsp *ts = i2c_get_clientdata(client);
 
-	return cyttsp_resume(ts->ttsp_client);
+	return cyttsp_resume(ts);
 }
 #endif
 
 static SIMPLE_DEV_PM_OPS(cyttsp_i2c_pm, cyttsp_i2c_suspend, cyttsp_i2c_resume);
 
 static const struct i2c_device_id cyttsp_i2c_id[] = {
-	{ CY_I2C_NAME, 0 },  { }
+	{ CY_I2C_NAME, 0 },
+	{ }
 };
+MODULE_DEVICE_TABLE(i2c, cyttsp_i2c_id);
 
 static struct i2c_driver cyttsp_i2c_driver = {
 	.driver = {
-		.name = CY_I2C_NAME,
-		.owner = THIS_MODULE,
-		.pm = &cyttsp_i2c_pm,
+		.name	= CY_I2C_NAME,
+		.owner	= THIS_MODULE,
+		.pm	= &cyttsp_i2c_pm,
 	},
-	.probe = cyttsp_i2c_probe,
-	.remove = __devexit_p(cyttsp_i2c_remove),
-	.id_table = cyttsp_i2c_id,
+	.probe		= cyttsp_i2c_probe,
+	.remove		= __devexit_p(cyttsp_i2c_remove),
+	.id_table	= cyttsp_i2c_id,
 };
 
 static int __init cyttsp_i2c_init(void)
 {
 	return i2c_add_driver(&cyttsp_i2c_driver);
 }
+module_init(cyttsp_i2c_init);
 
 static void __exit cyttsp_i2c_exit(void)
 {
 	return i2c_del_driver(&cyttsp_i2c_driver);
 }
-
-module_init(cyttsp_i2c_init);
 module_exit(cyttsp_i2c_exit);
 
-MODULE_ALIAS("i2c:cyttsp");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Cypress TrueTouch(R) Standard Product (TTSP) I2C driver");
 MODULE_AUTHOR("Cypress");
-MODULE_DEVICE_TABLE(i2c, cyttsp_i2c_id);
diff --git a/drivers/input/touchscreen/cyttsp_spi.c b/drivers/input/touchscreen/cyttsp_spi.c
index 4c689c7..eafa357 100644
--- a/drivers/input/touchscreen/cyttsp_spi.c
+++ b/drivers/input/touchscreen/cyttsp_spi.c
@@ -45,25 +45,18 @@
 #define CY_SPI_DATA_BUF_SIZE (CY_SPI_CMD_BYTES + CY_SPI_DATA_SIZE)
 #define CY_SPI_BITS_PER_WORD 8
 
-struct cyttsp_spi {
-	struct spi_device *spi;
-	void *ttsp_client;
-	u8 wr_buf[CY_SPI_DATA_BUF_SIZE];
-	u8 rd_buf[CY_SPI_DATA_BUF_SIZE];
-};
-
-static int cyttsp_spi_xfer(u8 op, struct cyttsp_spi *ts,
+static int cyttsp_spi_xfer(u8 op, struct spi_device *spi,
 			   u8 reg, u8 *buf, int length)
 {
+	struct cyttsp *ts = spi_get_drvdata(spi);
 	struct spi_message msg;
 	struct spi_transfer xfer[2];
-	u8 *wr_buf = ts->wr_buf;
-	u8 *rd_buf = ts->rd_buf;
+	u8 *wr_buf = &ts->xfer_buf[0];
+	u8 *rd_buf = &ts->xfer_buf[CY_SPI_DATA_BUF_SIZE];
 	int retval;
 
 	if (length > CY_SPI_DATA_SIZE) {
-		dev_dbg(&ts->spi->dev,
-			"%s: length %d is too big.\n",
+		dev_dbg(&spi->dev, "%s: length %d is too big.\n",
 			__func__, length);
 		return -EINVAL;
 	}
@@ -78,7 +71,7 @@ static int cyttsp_spi_xfer(u8 op, struct cyttsp_spi *ts,
 	if (op == CY_SPI_WR_OP)
 		memcpy(wr_buf + CY_SPI_CMD_BYTES, buf, length);
 
-	memset((void *)xfer, 0, sizeof(xfer));
+	memset(xfer, 0, sizeof(xfer));
 	spi_message_init(&msg);
 
 	/*
@@ -87,21 +80,28 @@ static int cyttsp_spi_xfer(u8 op, struct cyttsp_spi *ts,
 	*/
 	xfer[0].tx_buf = wr_buf;
 	xfer[0].rx_buf = rd_buf;
-	if (op == CY_SPI_WR_OP) {
+	switch (op) {
+	case CY_SPI_WR_OP:
 		xfer[0].len = length + CY_SPI_CMD_BYTES;
 		spi_message_add_tail(&xfer[0], &msg);
-	} else if (op == CY_SPI_RD_OP) {
+		break;
+
+	case CY_SPI_RD_OP:
 		xfer[0].len = CY_SPI_CMD_BYTES;
 		spi_message_add_tail(&xfer[0], &msg);
 
 		xfer[1].rx_buf = buf;
 		xfer[1].len = length;
 		spi_message_add_tail(&xfer[1], &msg);
+		break;
+
+	default:
+		BUG();
 	}
 
-	retval = spi_sync(ts->spi, &msg);
+	retval = spi_sync(spi, &msg);
 	if (retval < 0) {
-		dev_dbg(&ts->spi->dev,
+		dev_dbg(&spi->dev,
 			"%s: spi_sync() error %d, len=%d, op=%d\n",
 			__func__, retval, xfer[1].len, op);
 
@@ -112,17 +112,15 @@ static int cyttsp_spi_xfer(u8 op, struct cyttsp_spi *ts,
 		 */
 	}
 
-	if ((rd_buf[CY_SPI_SYNC_BYTE] == CY_SPI_SYNC_ACK1) &&
-	    (rd_buf[CY_SPI_SYNC_BYTE+1] == CY_SPI_SYNC_ACK2))
-		retval = 0;
-	else {
+	if (rd_buf[CY_SPI_SYNC_BYTE] != CY_SPI_SYNC_ACK1 &&
+	    rd_buf[CY_SPI_SYNC_BYTE + 1] != CY_SPI_SYNC_ACK2) {
 		int i;
-		for (i = 0; i < (CY_SPI_CMD_BYTES); i++)
-			dev_dbg(&ts->spi->dev,
+		for (i = 0; i < CY_SPI_CMD_BYTES; i++)
+			dev_dbg(&spi->dev,
 				"%s: test rd_buf[%d]:0x%02x\n",
 				__func__, i, rd_buf[i]);
-		for (i = 0; i < (length); i++)
-			dev_dbg(&ts->spi->dev,
+		for (i = 0; i < length; i++)
+			dev_dbg(&spi->dev,
 				"%s: test buf[%d]:0x%02x\n",
 				__func__, i, buf[i]);
 
@@ -130,20 +128,19 @@ static int cyttsp_spi_xfer(u8 op, struct cyttsp_spi *ts,
 		retval = 1;
 	}
 
-	return retval;
+	return 0;
 }
 
-static int ttsp_spi_read_block_data(struct device *dev,
-				    u8 addr, u8 length, void *data)
+static int cyttsp_spi_read_block_data(struct device *dev,
+				      u8 addr, u8 length, void *data)
 {
 	struct spi_device *spi = to_spi_device(dev);
-	struct cyttsp_spi *ts = spi_get_drvdata(spi);
 	int retval;
 
-	retval = cyttsp_spi_xfer(CY_SPI_RD_OP, ts, addr, data, length);
+	retval = cyttsp_spi_xfer(CY_SPI_RD_OP, spi, addr, data, length);
 	if (retval < 0)
-		pr_err("%s: ttsp_spi_read_block_data failed\n",
-		       __func__);
+		dev_err(dev, "cyttsp_spi_read_block_data failed, err: %d\n",
+		        retval);
 
 	/*
 	 * Do not print the above error if the data sync bytes were not found.
@@ -156,17 +153,16 @@ static int ttsp_spi_read_block_data(struct device *dev,
 	return retval;
 }
 
-static int ttsp_spi_write_block_data(struct device *dev,
-				     u8 addr, u8 length, const void *data)
+static int cyttsp_spi_write_block_data(struct device *dev,
+				       u8 addr, u8 length, const void *data)
 {
 	struct spi_device *spi = to_spi_device(dev);
-	struct cyttsp_spi *ts = spi_get_drvdata(spi);
 	int retval;
 
-	retval = cyttsp_spi_xfer(CY_SPI_WR_OP, ts, addr, (void *)data, length);
+	retval = cyttsp_spi_xfer(CY_SPI_WR_OP, spi, addr, (void *)data, length);
 	if (retval < 0)
-		pr_err("%s: ttsp_spi_write_block_data failed\n",
-		       __func__);
+		dev_err(dev, "ttsp_spi_write_block_data failed, err: %d\n",
+		        retval);
 
 	/*
 	 * Do not print the above error if the data sync bytes were not found.
@@ -181,52 +177,40 @@ static int ttsp_spi_write_block_data(struct device *dev,
 
 static const struct cyttsp_bus_ops cyttsp_spi_bus_ops = {
 	.bustype	= BUS_SPI,
-	.write		= ttsp_spi_write_block_data,
-	.read		= ttsp_spi_read_block_data,
+	.write		= cyttsp_spi_write_block_data,
+	.read		= cyttsp_spi_read_block_data,
 };
 
 static int __devinit cyttsp_spi_probe(struct spi_device *spi)
 {
-	struct cyttsp_spi *ts;
-	int retval;
+	struct cyttsp *ts;
+	int error;
 
 	/* Set up SPI*/
 	spi->bits_per_word = CY_SPI_BITS_PER_WORD;
 	spi->mode = SPI_MODE_0;
-	retval = spi_setup(spi);
-	if (retval < 0) {
+	error = spi_setup(spi);
+	if (error < 0) {
 		dev_dbg(&spi->dev, "%s: SPI setup error %d\n",
-			__func__, retval);
-		return retval;
+			__func__, error);
+		return error;
 	}
 
-	ts = kzalloc(sizeof(*ts), GFP_KERNEL);
-	if (!ts) {
-		dev_dbg(&spi->dev, "%s: Error, kzalloc\n", __func__);
-		return -ENOMEM;
-	}
+	ts = cyttsp_probe(&cyttsp_spi_bus_ops, &spi->dev, spi->irq,
+			  CY_SPI_DATA_BUF_SIZE * 2);
+	if (IS_ERR(ts))
+		return PTR_ERR(ts);
 
-	ts->spi = spi;
 	spi_set_drvdata(spi, ts);
 
-	ts->ttsp_client = cyttsp_core_init(&cyttsp_spi_bus_ops, &spi->dev, spi->irq);
-	if (IS_ERR(ts->ttsp_client)) {
-		int retval = PTR_ERR(ts->ttsp_client);
-		kfree(ts);
-		return retval;
-	}
-
-	dev_dbg(&ts->spi->dev, "%s: Registration complete\n", __func__);
-
 	return 0;
 }
 
 static int __devexit cyttsp_spi_remove(struct spi_device *spi)
 {
-	struct cyttsp_spi *ts = spi_get_drvdata(spi);
+	struct cyttsp *ts = spi_get_drvdata(spi);
 
-	cyttsp_core_release(ts->ttsp_client);
-	kfree(ts);
+	cyttsp_remove(ts);
 
 	return 0;
 }
@@ -234,16 +218,16 @@ static int __devexit cyttsp_spi_remove(struct spi_device *spi)
 #ifdef CONFIG_PM_SLEEP
 static int cyttsp_spi_suspend(struct device *dev)
 {
-	struct cyttsp_spi *ts = dev_get_drvdata(dev);
+	struct cyttsp *ts = dev_get_drvdata(dev);
 
-	return cyttsp_suspend(ts->ttsp_client);
+	return cyttsp_suspend(ts);
 }
 
 static int cyttsp_spi_resume(struct device *dev)
 {
-	struct cyttsp_spi *ts = dev_get_drvdata(dev);
+	struct cyttsp *ts = dev_get_drvdata(dev);
 
-	return cyttsp_resume(ts->ttsp_client);
+	return cyttsp_resume(ts);
 }
 #endif
 
@@ -251,11 +235,11 @@ static SIMPLE_DEV_PM_OPS(cyttsp_spi_pm, cyttsp_spi_suspend, cyttsp_spi_resume);
 
 static struct spi_driver cyttsp_spi_driver = {
 	.driver = {
-		.name = CY_SPI_NAME,
-		.owner = THIS_MODULE,
-		.pm = &cyttsp_spi_pm,
+		.name	= CY_SPI_NAME,
+		.owner	= THIS_MODULE,
+		.pm	= &cyttsp_spi_pm,
 	},
-	.probe = cyttsp_spi_probe,
+	.probe	= cyttsp_spi_probe,
 	.remove = __devexit_p(cyttsp_spi_remove),
 };
 

