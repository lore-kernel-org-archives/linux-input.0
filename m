From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] Input: add touchscreen driver for MELFAS MCS-5000
	controller
Date: Mon, 13 Jul 2009 23:04:22 -0700
Message-ID: <20090714060403.GE2822@dtor-d630.eng.vmware.com>
References: <4A56A304.3050009@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.237]:34095 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753540AbZGNGE3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Jul 2009 02:04:29 -0400
Received: by rv-out-0506.google.com with SMTP id f6so781388rvb.1
        for <linux-input@vger.kernel.org>; Mon, 13 Jul 2009 23:04:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4A56A304.3050009@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: linux-input@vger.kernel.org, kyungmin.park@samsung.com, m.szyprowski@samsung.com, t.fujak@samsung.com

Hi Joonyoung,

On Fri, Jul 10, 2009 at 11:10:12AM +0900, Joonyoung Shim wrote:
> The MELPAS MCS-5000 is the touchscreen controller. The overview of this
> controller can see at the following website:
> 
> http://www.melfas.com/product/product01.asp?k_r=eng_
> 
> This driver is tested on s3c6410 NCP board and supports only the i2c
> interface.
> 
> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> ---
> Dear Dmitry,
> 
> I sent the patch v2, but couldn't get any response.
> This patch v3 is updated a little bit from v2.
> 

While I was sittign on the patch mainline acquired threaded IRQ support
which fits the bill here and simplifies logic quite a bit, could you
please try the patch below and tell me if the touchscreen still works?

> I have one question. The MCS-5000 controller don't support PRESSURE, so
> i removed a fake PRESSURE report on driver, but tslib v1.0
> (http://tslib.berlios.de) require the PRESSURE report from driver. I
> wonder whether it is make sense to report a fake PRESSURE for tslib.
> 

I believe the adjustments to use BTN_TOUCH in absebse of ABS_PRESSURE
has been applied to tslib, you need to talk to the maintainers about
releasing updated version instead of adding fake events to the kernel.

Thanks.

-- 
Dmitry


Input: mcs5000_ts - use threaded IRQs

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Threaded IRQs are exactly what this driver needs since it communicates
with the device over I2C bus, which requires sleeping.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/touchscreen/mcs5000_ts.c |  162 +++++++++++---------------------
 1 files changed, 57 insertions(+), 105 deletions(-)


diff --git a/drivers/input/touchscreen/mcs5000_ts.c b/drivers/input/touchscreen/mcs5000_ts.c
index d6c1a94..ff54ea9 100644
--- a/drivers/input/touchscreen/mcs5000_ts.c
+++ b/drivers/input/touchscreen/mcs5000_ts.c
@@ -20,7 +20,6 @@
 #include <linux/interrupt.h>
 #include <linux/input.h>
 #include <linux/irq.h>
-#include <linux/workqueue.h>
 
 /* Registers */
 #define MCS5000_TS_STATUS		0x00
@@ -105,17 +104,12 @@ enum mcs5000_ts_read_offset {
 struct mcs5000_ts_data {
 	struct i2c_client *client;
 	struct input_dev *input_dev;
-	struct work_struct ts_event_work;
-	struct mcs5000_ts_platform_data *platform_data;
-
-	unsigned int irq;
-	atomic_t irq_disable;
+	const struct mcs5000_ts_platform_data *platform_data;
 };
 
-static struct i2c_driver mcs5000_ts_driver;
-
-static void mcs5000_ts_input_read(struct mcs5000_ts_data *data)
+static irqreturn_t mcs5000_ts_interrupt(int irq, void *dev_id)
 {
+	struct mcs5000_ts_data *data = dev_id;
 	struct i2c_client *client = data->client;
 	u8 buffer[READ_BLOCK_SIZE];
 	int err;
@@ -126,7 +120,7 @@ static void mcs5000_ts_input_read(struct mcs5000_ts_data *data)
 			READ_BLOCK_SIZE, buffer);
 	if (err < 0) {
 		dev_err(&client->dev, "%s, err[%d]\n", __func__, err);
-		return;
+		goto out;
 	}
 
 	switch (buffer[READ_INPUT_INFO]) {
@@ -134,6 +128,7 @@ static void mcs5000_ts_input_read(struct mcs5000_ts_data *data)
 		input_report_key(data->input_dev, BTN_TOUCH, 0);
 		input_sync(data->input_dev);
 		break;
+
 	case INPUT_TYPE_SINGLE:
 		x = (buffer[READ_X_POS_UPPER] << 8) | buffer[READ_X_POS_LOWER];
 		y = (buffer[READ_Y_POS_UPPER] << 8) | buffer[READ_Y_POS_LOWER];
@@ -143,98 +138,40 @@ static void mcs5000_ts_input_read(struct mcs5000_ts_data *data)
 		input_report_abs(data->input_dev, ABS_Y, y);
 		input_sync(data->input_dev);
 		break;
+
 	case INPUT_TYPE_DUAL:
 		/* TODO */
 		break;
+
 	case INPUT_TYPE_PALM:
 		/* TODO */
 		break;
+
 	case INPUT_TYPE_PROXIMITY:
 		/* TODO */
 		break;
+
 	default:
 		dev_err(&client->dev, "Unknown ts input type %d\n",
 				buffer[READ_INPUT_INFO]);
 		break;
 	}
-}
-
-static void mcs5000_ts_irq_worker(struct work_struct *work)
-{
-	struct mcs5000_ts_data *data = container_of(work,
-			struct mcs5000_ts_data, ts_event_work);
-
-	mcs5000_ts_input_read(data);
-
-	atomic_dec(&data->irq_disable);
-	enable_irq(data->irq);
-}
-
-static irqreturn_t mcs5000_ts_interrupt(int irq, void *dev_id)
-{
-	struct mcs5000_ts_data *data = dev_id;
-
-	if (!work_pending(&data->ts_event_work)) {
-		disable_irq_nosync(data->irq);
-		atomic_inc(&data->irq_disable);
-		schedule_work(&data->ts_event_work);
-	}
 
+ out:
+	enable_irq(irq);
 	return IRQ_HANDLED;
 }
 
-static int mcs5000_ts_input_init(struct mcs5000_ts_data *data)
+static irqreturn_t mcs5000_ts_hardirq(int irq, void *dev_id)
 {
-	struct input_dev *input_dev;
-	int ret = 0;
-
-	INIT_WORK(&data->ts_event_work, mcs5000_ts_irq_worker);
-
-	data->input_dev = input_allocate_device();
-	if (data->input_dev == NULL) {
-		ret = -ENOMEM;
-		goto err_input;
-	}
-
-	input_dev = data->input_dev;
-	input_dev->name = "MELPAS MCS-5000 Touchscreen";
-	input_dev->id.bustype = BUS_I2C;
-	input_dev->dev.parent = &data->client->dev;
-	set_bit(EV_ABS, input_dev->evbit);
-	set_bit(ABS_X, input_dev->absbit);
-	set_bit(ABS_Y, input_dev->absbit);
-	set_bit(EV_KEY, input_dev->evbit);
-	set_bit(BTN_TOUCH, input_dev->keybit);
-	input_set_abs_params(input_dev, ABS_X, 0, MCS5000_MAX_XC, 0, 0);
-	input_set_abs_params(input_dev, ABS_Y, 0, MCS5000_MAX_YC, 0, 0);
-
-	ret = input_register_device(data->input_dev);
-	if (ret < 0)
-		goto err_register;
-
-	ret = request_irq(data->irq, mcs5000_ts_interrupt, IRQF_TRIGGER_LOW,
-			"mcs5000_ts_input", data);
-	if (ret < 0) {
-		dev_err(&data->client->dev, "Failed to register interrupt\n");
-		goto err_irq;
-	}
-
-	input_set_drvdata(input_dev, data);
-
-	return 0;
-err_irq:
-	input_unregister_device(data->input_dev);
-	data->input_dev = NULL;
-err_register:
-	input_free_device(data->input_dev);
-err_input:
-	return ret;
+	disable_irq_nosync(irq);
+	return IRQ_WAKE_THREAD;
 }
 
 static void mcs5000_ts_phys_init(struct mcs5000_ts_data *data)
 {
+	const struct mcs5000_ts_platform_data *platform_data = data->platform_data;
 	struct i2c_client *client = data->client;
-	struct mcs5000_ts_platform_data *platform_data = data->platform_data;
 
 	/* Touch reset & sleep mode */
 	i2c_smbus_write_byte_data(client, MCS5000_TS_OP_MODE,
@@ -259,53 +196,69 @@ static int __devinit mcs5000_ts_probe(struct i2c_client *client,
 		const struct i2c_device_id *idp)
 {
 	struct mcs5000_ts_data *data;
-	int ret;
+	struct input_dev *input_dev;
+	int error;
+
+	if (!client->dev.platform_data)
+		return -EINVAL;
 
 	data = kzalloc(sizeof(struct mcs5000_ts_data), GFP_KERNEL);
-	if (!data) {
-		dev_err(&client->dev, "Failed to allocate driver data\n");
-		ret = -ENOMEM;
-		goto exit;
+	input_dev = input_allocate_device();
+	if (!data || !input_dev) {
+		dev_err(&client->dev, "Failed to allocate memory\n");
+		error = -ENOMEM;
+		goto err_free_mem;
 	}
 
 	data->client = client;
+	data->input_dev = input_dev;
 	data->platform_data = client->dev.platform_data;
-	data->irq = client->irq;
-	atomic_set(&data->irq_disable, 0);
 
-	i2c_set_clientdata(client, data);
+	input_dev->name = "MELPAS MCS-5000 Touchscreen";
+	input_dev->id.bustype = BUS_I2C;
+	input_dev->dev.parent = &data->client->dev;
+
+	__set_bit(EV_ABS, input_dev->evbit);
+	__set_bit(EV_KEY, input_dev->evbit);
+	__set_bit(BTN_TOUCH, input_dev->keybit);
+	input_set_abs_params(input_dev, ABS_X, 0, MCS5000_MAX_XC, 0, 0);
+	input_set_abs_params(input_dev, ABS_Y, 0, MCS5000_MAX_YC, 0, 0);
 
-	if (data->platform_data && data->platform_data->set_pin)
+	input_set_drvdata(input_dev, data);
+
+	if (data->platform_data->set_pin)
 		data->platform_data->set_pin();
 
-	ret = mcs5000_ts_input_init(data);
-	if (ret)
-		goto exit_free;
+	error = request_threaded_irq(client->irq,
+				mcs5000_ts_hardirq, mcs5000_ts_interrupt,
+				IRQF_TRIGGER_LOW, "mcs5000_ts_input", data);
+	if (error < 0) {
+		dev_err(&data->client->dev, "Failed to register interrupt\n");
+		goto err_free_mem;
+	}
+
+	error = input_register_device(data->input_dev);
+	if (error < 0)
+		goto err_free_irq;
 
 	mcs5000_ts_phys_init(data);
+	i2c_set_clientdata(client, data);
 
 	return 0;
 
-exit_free:
+err_free_irq:
+	free_irq(client->irq, data);
+err_free_mem:
+	input_free_device(input_dev);
 	kfree(data);
-	i2c_set_clientdata(client, NULL);
-exit:
-	return ret;
+	return error;
 }
 
 static int __devexit mcs5000_ts_remove(struct i2c_client *client)
 {
 	struct mcs5000_ts_data *data = i2c_get_clientdata(client);
 
-	free_irq(data->irq, data);
-	cancel_work_sync(&data->ts_event_work);
-
-	/*
-	 * If work indeed has been cancelled, disable_irq() will have been left
-	 * unbalanced from mcs5000_ts_interrupt().
-	 */
-	while (atomic_dec_return(&data->irq_disable) >= 0)
-		enable_irq(data->irq);
+	free_irq(client->irq, data);
 
 	input_unregister_device(data->input_dev);
 	kfree(data);
@@ -326,9 +279,8 @@ static int mcs5000_ts_suspend(struct i2c_client *client, pm_message_t mesg)
 
 static int mcs5000_ts_resume(struct i2c_client *client)
 {
-	struct mcs5000_ts_data *data;
+	struct mcs5000_ts_data *data = i2c_get_clientdata(client);
 
-	data = i2c_get_clientdata(client);
 	mcs5000_ts_phys_init(data);
 
 	return 0;
