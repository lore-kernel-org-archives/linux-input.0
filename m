From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Atmel AT42QT2160 sensor chip input driver
Date: Mon, 14 Sep 2009 21:26:12 -0700
Message-ID: <20090915042612.GB1132@core.coreip.homeip.net>
References: <f20381800908201315s7cd4cfc1g57c8799218415b8d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f171.google.com ([209.85.210.171]:36840 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247AbZIOEb6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Sep 2009 00:31:58 -0400
Received: by yxe1 with SMTP id 1so4836196yxe.21
        for <linux-input@vger.kernel.org>; Mon, 14 Sep 2009 21:32:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <f20381800908201315s7cd4cfc1g57c8799218415b8d@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Raphael Derosso Pereira <raphaelpereira@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Raphael,

On Thu, Aug 20, 2009 at 05:15:52PM -0300, Raphael Derosso Pereira wrote:
> From: Raphael Derosso Pereira <raphaelpereira@gmail.com>
> 
> Initial version of AT42QT2160 Atmel Sensor Chip support. This version only
> supports individual cells (no slide support yet). The code has been tested
> on proprietary development ARM board, but should work fine on other machines.
> 
> Signed-off-by: Raphael Derosso Pereira <raphaelpereira@gmail.com>

This version is much better, thank you very much for making the changes
I requested.

> +
> +#define QT2160_CMD_CHIPID    (00)
> +#define QT2160_CMD_CODEVER   (01)
> +#define QT2160_CMD_GSTAT     (02)
> +#define QT2160_CMD_KEYS3     (03)
> +#define QT2160_CMD_KEYS4     (04)
> +#define QT2160_CMD_SLIDE     (05)
> +#define QT2160_CMD_GPIOS     (06)
> +#define QT2160_CMD_SUBVER    (07)
> +#define QT2160_CMD_CALIBRATE (10)

I am a bit concerned about this chunk. The first 8 commands are written
as octal while the last (calibrate) as decimal. Is this intentional?

I also made a few more changes. Could you please trythe patch below and
if everything is still working I will apply to my tree.

Thanks!

-- 
Dmitry

Input: AT42QT2160 - various fixups

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/keyboard/qt2160.c |  374 ++++++++++++++++++---------------------
 1 files changed, 171 insertions(+), 203 deletions(-)


diff --git a/drivers/input/keyboard/qt2160.c b/drivers/input/keyboard/qt2160.c
index 1f9882b..c1b80da 100644
--- a/drivers/input/keyboard/qt2160.c
+++ b/drivers/input/keyboard/qt2160.c
@@ -1,22 +1,22 @@
 /*
-    qt2160.c - Atmel AT42QT2160 Touch Sense Controller
-
-    Copyright (C) 2009 Raphael Derosso Pereira <raphaelpereira@gmail.com>
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-*/
+ * qt2160.c - Atmel AT42QT2160 Touch Sense Controller
+ *
+ *  Copyright (C) 2009 Raphael Derosso Pereira <raphaelpereira@gmail.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
 
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -27,117 +27,110 @@
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/input.h>
-#include <linux/mutex.h>
 
-#define QT2160_VALID_CHIPID (0x11)
+#define QT2160_VALID_CHIPID	0x11
 
-#define QT2160_CMD_CHIPID    (00)
-#define QT2160_CMD_CODEVER   (01)
-#define QT2160_CMD_GSTAT     (02)
-#define QT2160_CMD_KEYS3     (03)
-#define QT2160_CMD_KEYS4     (04)
-#define QT2160_CMD_SLIDE     (05)
-#define QT2160_CMD_GPIOS     (06)
-#define QT2160_CMD_SUBVER    (07)
-#define QT2160_CMD_CALIBRATE (10)
+#define QT2160_CMD_CHIPID	00
+#define QT2160_CMD_CODEVER	01
+#define QT2160_CMD_GSTAT	02
+#define QT2160_CMD_KEYS3	03
+#define QT2160_CMD_KEYS4	04
+#define QT2160_CMD_SLIDE	05
+#define QT2160_CMD_GPIOS	06
+#define QT2160_CMD_SUBVER	07
+#define QT2160_CMD_CALIBRATE	10
 
 #define QT2160_CYCLE_INTERVAL	(HZ)
 
-static unsigned char qt2160_key2code[] = {
-		KEY_0, KEY_1, KEY_2, KEY_3,
-		KEY_4, KEY_5, KEY_6, KEY_7,
-		KEY_8, KEY_9, KEY_A, KEY_B,
-		KEY_C, KEY_D, KEY_E, KEY_F,
+static const unsigned short qt2160_keycodes[] = {
+	KEY_0, KEY_1, KEY_2, KEY_3,
+	KEY_4, KEY_5, KEY_6, KEY_7,
+	KEY_8, KEY_9, KEY_A, KEY_B,
+	KEY_C, KEY_D, KEY_E, KEY_F,
 };
 
 struct qt2160_data {
-	struct mutex mlock;
 	struct i2c_client *client;
-	struct delayed_work handle_work;
-	struct work_struct handle_irq_work;
 	struct input_dev *input;
-	u8 version_major;
-	u8 version_minor;
-	u8 version_rev;
+	struct delayed_work dwork;
+	spinlock_t lock;	/* Protects canceling/rescheduling of dwork */
+	unsigned short keycodes[ARRAY_SIZE(qt2160_keycodes)];
 	u16 key_matrix;
 };
 
 static int qt2160_read(struct i2c_client *client, u8 reg)
 {
-	int ret;
+	int error;
 
-	ret = i2c_smbus_write_byte(client, reg);
-	if (ret) {
+	error = i2c_smbus_write_byte(client, reg);
+	if (error) {
 		dev_err(&client->dev,
-				"couldn't send request. Returned %d\n", ret);
-		return ret;
+			"couldn't send request. Returned %d\n", error);
+		return error;
 	}
 
-	ret = i2c_smbus_read_byte(client);
-	if (ret < 0) {
+	error = i2c_smbus_read_byte(client);
+	if (error < 0) {
 		dev_err(&client->dev,
-				"couldn't read register. Returned %d\n", ret);
-		return ret;
+			"couldn't read register. Returned %d\n", error);
+		return error;
 	}
 
-	return ret;
+	return 0;
 }
 
 static int qt2160_write(struct i2c_client *client, u8 reg, u8 data)
 {
-	int ret;
+	int error;
 
-	ret = i2c_smbus_write_byte(client, reg);
-	if (ret) {
+	error = i2c_smbus_write_byte(client, reg);
+	if (error) {
 		dev_err(&client->dev,
-				"couldn't send request. Returned %d\n", ret);
-		return ret;
+			"couldn't send request. Returned %d\n", error);
+		return error;
 	}
 
-	ret = i2c_smbus_write_byte(client, data);
-	if (ret) {
+	error = i2c_smbus_write_byte(client, data);
+	if (error) {
 		dev_err(&client->dev,
-				"couldn't write data. Returned %d\n", ret);
-		return ret;
+			"couldn't write data. Returned %d\n", error);
+		return error;
 	}
 
-	return ret;
+	return 0;
 }
 
-static int qt2160_get_key_matrix(struct i2c_client *client)
+static int qt2160_get_key_matrix(struct qt2160_data *qt2160)
 {
-	int ret, i;
-	struct qt2160_data *qt2160;
+	struct i2c_client *client = qt2160->client;
+	struct input_dev *input = qt2160->input;
 	u16 old_matrix;
+	int ret, i;
 
 	dev_dbg(&client->dev, "requesting keys...\n");
-	qt2160 = i2c_get_clientdata(client);
-	mutex_lock(&qt2160->mlock);
 
 	/* Read General Status Register */
 	ret = qt2160_read(client, QT2160_CMD_GSTAT);
 	if (ret < 0) {
 		dev_err(&client->dev,
-				"could not get general status register\n");
-		goto err_unlock;
+			"could not get general status register\n");
+		return ret;
 	}
 
 	old_matrix = qt2160->key_matrix;
 
 	ret = qt2160_read(client, QT2160_CMD_KEYS3);
 	if (ret < 0) {
-		dev_err(&client->dev,
-				"could not get keys from register 3\n");
-		goto err_unlock;
+		dev_err(&client->dev, "could not get keys from register 3\n");
+		return ret;
 	}
 
 	qt2160->key_matrix = ret;
 
 	ret = qt2160_read(client, QT2160_CMD_KEYS4);
 	if (ret < 0) {
-		dev_err(&client->dev,
-				"could not get keys from register 4\n");
-		goto err_unlock;
+		dev_err(&client->dev, "could not get keys from register 4\n");
+		return ret;
 	}
 
 	qt2160->key_matrix |= (ret << 8);
@@ -145,199 +138,183 @@ static int qt2160_get_key_matrix(struct i2c_client *client)
 	/* Read slide and GPIOs to clear CHANGE pin */
 	ret = qt2160_read(client, QT2160_CMD_SLIDE);
 	if (ret < 0) {
-		dev_err(&client->dev,
-				"could not get slide status\n");
-		goto err_unlock;
+		dev_err(&client->dev, "could not get slide status\n");
+		return ret;
 	}
 
 	ret = qt2160_read(client, QT2160_CMD_GPIOS);
 	if (ret < 0) {
 		dev_err(&client->dev, "could not get GPIOs\n");
-		goto err_unlock;
+		return ret;
 	}
 
 	for (i = 0; i < 16; ++i) {
 		int keyval = (qt2160->key_matrix >> i) & 0x01;
 
 		if (((old_matrix >> i) & 0x01) != keyval) {
-			input_report_key(qt2160->input,
-				((unsigned char *)qt2160->input->keycode)[i],
-				keyval);
-			input_sync(qt2160->input);
-
-			if (keyval)
-				dev_dbg(&client->dev, "key %d pressed\n", i);
-			else
-				dev_dbg(&client->dev, "key %d released\n", i);
+			dev_dbg(&client->dev, "key %d %s\n",
+				i, keyval ? "pressed" : "released");
+
+			input_report_key(input, qt2160->keycodes[i], keyval);
+			input_sync(input);
 		}
 	}
 
-	mutex_unlock(&qt2160->mlock);
 	return 0;
-
-err_unlock:
-	mutex_unlock(&qt2160->mlock);
-	return ret;
 }
 
 static irqreturn_t qt2160_irq(int irq, void *_qt2160)
 {
 	struct qt2160_data *qt2160 = _qt2160;
+	unsigned long flags;
 
-	schedule_work(&qt2160->handle_irq_work);
-	return IRQ_HANDLED;
-}
+	spin_lock_irqsave(&qt2160->lock, flags);
 
-static void qt2160_worker(struct work_struct *work)
-{
-	struct qt2160_data *qt2160;
+	__cancel_delayed_work(&qt2160->dwork);
+	schedule_delayed_work(&qt2160->dwork, 0);
 
-	qt2160 = container_of(work, struct qt2160_data,
-			handle_irq_work);
+	spin_unlock_irqrestore(&qt2160->lock, flags);
 
-	dev_dbg(&qt2160->client->dev, "irq worker\n");
-	qt2160_get_key_matrix(qt2160->client);
+	return IRQ_HANDLED;
 }
 
-static void qt2160_cycle_worker(struct work_struct *work)
+static void qt2160_worker(struct work_struct *work)
 {
-	struct qt2160_data *qt2160;
+	struct qt2160_data *qt2160 =
+		container_of(work, struct qt2160_data, dwork.work);
 
-	qt2160 = container_of(work, struct qt2160_data,
-			handle_work.work);
+	dev_dbg(&qt2160->client->dev, "worker\n");
 
-	dev_dbg(&qt2160->client->dev, "cycling worker\n");
-	qt2160_get_key_matrix(qt2160->client);
+	qt2160_get_key_matrix(qt2160);
 
 	/* Avoid lock checking every 500ms */
-	schedule_delayed_work(&qt2160->handle_work, QT2160_CYCLE_INTERVAL);
+	spin_lock_irq(&qt2160->lock);
+	schedule_delayed_work(&qt2160->dwork, QT2160_CYCLE_INTERVAL);
+	spin_unlock_irq(&qt2160->lock);
 }
 
-static int __devinit qt2160_probe(struct i2c_client *client,
-		const struct i2c_device_id *id)
-{
-	int ret, i;
-	struct qt2160_data *qt2160;
 
-	dev_info(&client->dev, "probing device...\n");
+static bool __devinit qt2160_identify(struct i2c_client *client)
+{
+	int id, ver, rev;
 
 	/* Read Chid ID to check if chip is valid */
-	ret = qt2160_read(client, QT2160_CMD_CHIPID);
-	if (ret != QT2160_VALID_CHIPID) {
-		dev_err(&client->dev, "ID %d not supported\n", ret);
-		return ret;
+	id = qt2160_read(client, QT2160_CMD_CHIPID);
+	if (id != QT2160_VALID_CHIPID) {
+		dev_err(&client->dev, "ID %d not supported\n", id);
+		return false;
 	}
 
-	/* Chip is valid and active. Allocate structure */
-	qt2160 = kzalloc(sizeof(struct qt2160_data), GFP_KERNEL);
-	if (!qt2160) {
-		dev_err(&client->dev, "insufficient memory\n");
-		return -ENOMEM;
-	}
-
-	i2c_set_clientdata(client, qt2160);
-	qt2160->client = client;
-
 	/* Read chip firmware version */
-	ret = qt2160_read(client, QT2160_CMD_CODEVER);
-	if (ret < 0) {
+	ver = qt2160_read(client, QT2160_CMD_CODEVER);
+	if (ver < 0) {
 		dev_err(&client->dev, "could not get firmware version\n");
-		goto err_free_qtdata;
+		return false;
 	}
 
-	qt2160->version_major = ret >> 4;
-	qt2160->version_minor = ret & 0xf;
-
 	/* Read chip firmware revision */
-	ret = qt2160_read(client, QT2160_CMD_SUBVER);
-	if (ret < 0) {
+	rev = qt2160_read(client, QT2160_CMD_SUBVER);
+	if (rev < 0) {
 		dev_err(&client->dev, "could not get firmware revision\n");
-		goto err_free_qtdata;
+		return false;
 	}
 
-	qt2160->version_rev = ret;
-
 	dev_info(&client->dev, "AT42QT2160 firmware version %d.%d.%d\n",
-			qt2160->version_major, qt2160->version_minor,
-			qt2160->version_rev);
+		 ver >> 4, ver &0xf, rev);
 
-	/* Calibrate device */
-	ret = qt2160_write(client, QT2160_CMD_CALIBRATE, 1);
-	if (ret) {
-		dev_err(&client->dev,
-			"Failed to calibrate device\n");
-		goto err_free_input;
-	}
+	return true;
+}
 
-	/* Initialize input structure */
-	qt2160->input = input_allocate_device();
-	if (!qt2160->input) {
-		dev_err(&client->dev, "input device: Not enough memory\n");
-		ret = -ENOMEM;
-		goto err_free_qtdata;
-	}
+static int __devinit qt2160_probe(struct i2c_client *client,
+				  const struct i2c_device_id *id)
+{
+	struct qt2160_data *qt2160;
+	struct input_dev *input;
+	int i;
+	int error;
 
-	qt2160->input->name = "AT42QT2160 Touch Sense Keyboard";
-	qt2160->input->id.bustype = BUS_I2C;
-	qt2160->input->keycode = qt2160_key2code;
-	qt2160->input->keycodesize = sizeof(unsigned char);
-	qt2160->input->keycodemax = ARRAY_SIZE(qt2160_key2code);
+	dev_dbg(&client->dev, "probing device...\n");
 
-	__set_bit(EV_KEY, qt2160->input->evbit);
-	__clear_bit(EV_REP, qt2160->input->evbit);
-	for (i = 0; i < ARRAY_SIZE(qt2160_key2code); i++)
-		__set_bit(qt2160_key2code[i], qt2160->input->keybit);
+	if (!qt2160_identify(client))
+		return -ENODEV;
 
-	ret = input_register_device(qt2160->input);
-	if (ret) {
+	/* Calibrate device */
+	error = qt2160_write(client, QT2160_CMD_CALIBRATE, 1);
+	if (error) {
 		dev_err(&client->dev,
-			"input device: Failed to register device\n");
-		goto err_free_input;
+			"Failed to calibrate device\n");
+		return error;
 	}
 
-	/* Initialize IRQ structure */
-	mutex_init(&qt2160->mlock);
+	/* Chip is valid and active. Allocate structures */
+	qt2160 = kzalloc(sizeof(struct qt2160_data), GFP_KERNEL);
+	input = input_allocate_device();
+	if (!qt2160 || !input) {
+		dev_err(&client->dev, "insufficient memory\n");
+		error = -ENOMEM;
+		goto err_free_mem;
+	}
 
-	INIT_DELAYED_WORK(&qt2160->handle_work, qt2160_cycle_worker);
-	INIT_WORK(&qt2160->handle_irq_work, qt2160_worker);
-	schedule_delayed_work(&qt2160->handle_work, QT2160_CYCLE_INTERVAL);
+	qt2160->client = client;
+	qt2160->input = input;
+	INIT_DELAYED_WORK(&qt2160->dwork, qt2160_worker);
+	spin_lock_init(&qt2160->lock);
+
+	input->name = "AT42QT2160 Touch Sense Keyboard";
+	input->id.bustype = BUS_I2C;
+
+	input->keycode = qt2160->keycodes;
+	input->keycodesize = sizeof(qt2160->keycodes[0]);
+	input->keycodemax = ARRAY_SIZE(qt2160->keycodes);
+
+	__set_bit(EV_KEY, input->evbit);
+	__clear_bit(EV_REP, input->evbit);
+	for (i = 0; i < ARRAY_SIZE(qt2160_keycodes); i++) {
+		qt2160->keycodes[i] = qt2160_keycodes[i];
+		__set_bit(qt2160_keycodes[i], input->keybit);
+	}
 
 	if (client->irq) {
-		ret = request_irq(client->irq, qt2160_irq,
-				  (IRQF_TRIGGER_FALLING), "qt2160", qt2160);
+		error = request_irq(client->irq, qt2160_irq,
+				    IRQF_TRIGGER_FALLING, "qt2160", qt2160);
 
-		if (ret) {
+		if (error) {
 			dev_err(&client->dev,
-				"failed to allocate irq %d\n",
-				client->irq);
-			goto err_free_input;
+				"failed to allocate irq %d\n", client->irq);
+			goto err_free_mem;
 		}
 	}
 
-	dev_info(&client->dev, "AT42QT2160 reset completed\n");
+	error = input_register_device(qt2160->input);
+	if (error) {
+		dev_err(&client->dev, "failed to register input device\n");
+		goto err_free_irq;
+	}
+
+	schedule_delayed_work(&qt2160->dwork, QT2160_CYCLE_INTERVAL);
+
+	i2c_set_clientdata(client, qt2160);
 	return 0;
 
-err_free_input:
+err_free_irq:
+	if (client->irq)
+		free_irq(client->irq, qt2160);
+err_free_mem:
 	input_free_device(qt2160->input);
-
-err_free_qtdata:
 	kfree(qt2160);
-	i2c_set_clientdata(client, NULL);
-	return ret;
+	return error;
 }
 
 static int __devexit qt2160_remove(struct i2c_client *client)
 {
-	struct qt2160_data *qt2160;
-
-	qt2160 = i2c_get_clientdata(client);
+	struct qt2160_data *qt2160 = i2c_get_clientdata(client);
 
 	/* Release IRQ so no queue will be scheduled */
-	free_irq(client->irq, qt2160);
+	if (client->irq)
+		free_irq(client->irq, qt2160);
 
-	/* Wait all pending works */
-	cancel_delayed_work_sync(&qt2160->handle_work);
-	cancel_work_sync(&qt2160->handle_irq_work);
+	/* Wait for delayed work to complete */
+	cancel_delayed_work_sync(&qt2160->dwork);
 
 	/* Unregister input device */
 	input_unregister_device(qt2160->input);
@@ -346,7 +323,6 @@ static int __devexit qt2160_remove(struct i2c_client *client)
 	kfree(qt2160);
 	i2c_set_clientdata(client, NULL);
 
-	dev_info(&client->dev, "AT42QT2160 removed.\n");
 	return 0;
 }
 
@@ -365,20 +341,12 @@ static struct i2c_driver qt2160_driver = {
 
 	.id_table	= qt2160_idtable,
 	.probe		= qt2160_probe,
-	.remove		= qt2160_remove,
+	.remove		= __devexit_p(qt2160_remove),
 };
 
 static int __init qt2160_init(void)
 {
-	int res;
-
-	res = i2c_add_driver(&qt2160_driver);
-	if (res) {
-		printk(KERN_ERR "qt2160: Driver registration failed, "
-				"module not inserted.\n");
-		return res;
-	}
-	return 0;
+	return i2c_add_driver(&qt2160_driver);
 }
 
 static void __exit qt2160_cleanup(void)
