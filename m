From: Evan Green <evgreen@chromium.org>
Subject: [PATCH] Input: atmel_mxt_ts - Disable IRQ across suspend
Date: Mon, 23 Sep 2019 09:50:04 -0700
Message-ID: <20190923165004.161846-1-evgreen@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Dyer <nick@shmanahar.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jongpil Jung <jongpil19.jung@samsung.com>, Furquan Shaikh <furquan@chromium.org>, Rajat Jain <rajatja@chromium.org>, Evan Green <evgreen@chromium.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Across suspend and resume, we are seeing error messages like the following:

atmel_mxt_ts i2c-PRP0001:00: __mxt_read_reg: i2c transfer failed (-121)
atmel_mxt_ts i2c-PRP0001:00: Failed to read T44 and T5 (-121)

This occurs because the driver leaves its IRQ enabled. Upon resume, there
is an IRQ pending, but the interrupt is serviced before both the driver and
the underlying I2C bus have been resumed. This causes EREMOTEIO errors.

Disable the IRQ in suspend, and re-enable it if it was previously enabled
in resume.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

 drivers/input/touchscreen/atmel_mxt_ts.c | 33 +++++++++++++++++++-----
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 24c4b691b1c9..19cbcd9767e2 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -291,6 +291,7 @@ struct mxt_data {
 	u8 xsize;
 	u8 ysize;
 	bool in_bootloader;
+	bool irq_enabled;
 	u16 mem_size;
 	u8 t100_aux_ampl;
 	u8 t100_aux_area;
@@ -1185,11 +1186,23 @@ static int mxt_t6_command(struct mxt_data *data, u16 cmd_offset,
 	return 0;
 }
 
+static void mxt_enable_irq(struct mxt_data *data)
+{
+	enable_irq(data->irq);
+	data->irq_enabled = true;
+}
+
+static void mxt_disable_irq(struct mxt_data *data)
+{
+	disable_irq(data->irq);
+	data->irq_enabled = false;
+}
+
 static int mxt_acquire_irq(struct mxt_data *data)
 {
 	int error;
 
-	enable_irq(data->irq);
+	mxt_enable_irq(data);
 
 	error = mxt_process_messages_until_invalid(data);
 	if (error)
@@ -1205,7 +1218,7 @@ static int mxt_soft_reset(struct mxt_data *data)
 
 	dev_info(dev, "Resetting device\n");
 
-	disable_irq(data->irq);
+	mxt_disable_irq(data);
 
 	reinit_completion(&data->reset_completion);
 
@@ -2807,7 +2820,7 @@ static int mxt_load_fw(struct device *dev, const char *fn)
 		mxt_free_input_device(data);
 		mxt_free_object_table(data);
 	} else {
-		enable_irq(data->irq);
+		mxt_enable_irq(data);
 	}
 
 	reinit_completion(&data->bl_completion);
@@ -2882,7 +2895,7 @@ static int mxt_load_fw(struct device *dev, const char *fn)
 	data->in_bootloader = false;
 
 disable_irq:
-	disable_irq(data->irq);
+	mxt_disable_irq(data);
 release_firmware:
 	release_firmware(fw);
 	return ret;
@@ -3101,7 +3114,7 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		return error;
 	}
 
-	disable_irq(client->irq);
+	mxt_disable_irq(data);
 
 	if (data->reset_gpio) {
 		msleep(MXT_RESET_GPIO_TIME);
@@ -3132,7 +3145,7 @@ static int mxt_remove(struct i2c_client *client)
 {
 	struct mxt_data *data = i2c_get_clientdata(client);
 
-	disable_irq(data->irq);
+	mxt_disable_irq(data);
 	sysfs_remove_group(&client->dev.kobj, &mxt_attr_group);
 	mxt_free_input_device(data);
 	mxt_free_object_table(data);
@@ -3156,6 +3169,11 @@ static int __maybe_unused mxt_suspend(struct device *dev)
 
 	mutex_unlock(&input_dev->mutex);
 
+	/*
+	 * Disable the IRQ directly since the boolean will be used to restore
+	 * the IRQ state on resume.
+	 */
+	disable_irq(data->irq);
 	return 0;
 }
 
@@ -3168,6 +3186,9 @@ static int __maybe_unused mxt_resume(struct device *dev)
 	if (!input_dev)
 		return 0;
 
+	if (data->irq_enabled)
+		enable_irq(data->irq);
+
 	mutex_lock(&input_dev->mutex);
 
 	if (input_dev->users)
-- 
2.21.0
