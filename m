From: voice <voice.shen@atmel.com>
Subject: Add Atmel AT42QT1070 driver, version 2
Date: Mon, 14 Mar 2011 14:04:29 +0800
Message-ID: <1300082669-17772-1-git-send-email-voice.shen@atmel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:47189 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932263Ab1CNGEf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Mar 2011 02:04:35 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: mohan1234@gmail.com, dmitry.torokhov@gmail.com, jm.lin@atmel.com, Bo Shen <voice.shen@atmel.com>

Add driver for Atmel AT42QT1070 QTouch sensor chip.
The AT42QT1070 QTouch sensor support up to 7 keys.
The driver has been tested on Atmel AT91SAM9M10-G45-EK board, it should work fine on other platform.

[v1] Modify the driver according to the suggestion from Mohan

[v2] Modify the driver according to the suggestion from Dmitry

Signed-off-by: Bo Shen <voice.shen@atmel.com>
--- 
 drivers/input/keyboard/Kconfig  |    9 ++
 drivers/input/keyboard/Makefile |    1 +
 drivers/input/keyboard/qt1070.c |  283 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 293 insertions(+), 0 deletions(-)

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 9cc488d..2e7af9f 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -124,6 +124,15 @@ config KEYBOARD_ATKBD_RDI_KEYCODES
 	  right-hand column will be interpreted as the key shown in the
 	  left-hand column.
 
+config KEYBOARD_QT1070
+       tristate "Atmel AT42QT1070 Touch Sensor Chip"
+       depends on I2C
+       help
+         Say Y here if you want to use Atmel AT42QT1070 QTouch
+         Sensor chip as input device.
+         To compile this driver as a module, choose M here:
+         the module will be called qt1070
+
 config KEYBOARD_QT2160
 	tristate "Atmel AT42QT2160 Touch Sensor Chip"
 	depends on I2C && EXPERIMENTAL
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index 504b591..23ecb51 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_KEYBOARD_OMAP)		+= omap-keypad.o
 obj-$(CONFIG_KEYBOARD_OPENCORES)	+= opencores-kbd.o
 obj-$(CONFIG_KEYBOARD_PXA27x)		+= pxa27x_keypad.o
 obj-$(CONFIG_KEYBOARD_PXA930_ROTARY)	+= pxa930_rotary.o
+obj-$(CONFIG_KEYBOARD_QT1070)           += qt1070.o
 obj-$(CONFIG_KEYBOARD_QT2160)		+= qt2160.o
 obj-$(CONFIG_KEYBOARD_SAMSUNG)		+= samsung-keypad.o
 obj-$(CONFIG_KEYBOARD_SH_KEYSC)		+= sh_keysc.o
diff --git a/drivers/input/keyboard/qt1070.c b/drivers/input/keyboard/qt1070.c
new file mode 100644
index 0000000..59f4b5d
--- /dev/null
+++ b/drivers/input/keyboard/qt1070.c
@@ -0,0 +1,283 @@
+/*
+ *  Atmel AT42QT1070 QTouch Sensor Controller
+ *
+ *  Copyright (C) 2011 Atmel
+ *
+ *  Authors: Bo Shen <voice.shen@atmel.com>
+ *
+ *  Base on AT42QT2160 driver by:
+ *  Raphael Derosso Pereira <raphaelpereira@gmail.com>
+ *  Copyright (C) 2009
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
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/input.h>
+#include <linux/slab.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/jiffies.h>
+#include <linux/delay.h>
+
+/* Address for each register */
+#define CHIP_ID            0x00
+#define QT1070_CHIP_ID     0x2E
+
+#define FW_VERSION         0x01
+#define QT1070_FW_VERSION  0x15
+
+#define DET_STATUS         0x02
+
+#define KEY_STATUS         0x03
+
+/* Calibrate */
+#define CALIBRATE_CMD      0x38
+#define QT1070_CAL_TIME    200
+
+/* Reset */
+#define RESET              0x39
+#define QT1070_RESET_TIME  255
+
+/* AT42QT1070 support up to 7 keys */
+static const unsigned short qt1070_key2code[] = {
+	KEY_0, KEY_1, KEY_2, KEY_3,
+	KEY_4, KEY_5, KEY_6,
+};
+
+struct qt1070_data {
+	struct i2c_client *client;
+	struct input_dev *input;
+	unsigned short keycodes[ARRAY_SIZE(qt1070_key2code)];
+	unsigned short key;
+	unsigned int  irq;
+};
+
+static int qt1070_read(struct i2c_client *client, u8 reg)
+{
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(client, reg);
+	if (ret < 0) {
+		dev_err(&client->dev,
+			"can not read register, returned %d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+static int qt1070_write(struct i2c_client *client, u8 reg, u8 data)
+{
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(client, reg, data);
+	if (ret < 0) {
+		dev_err(&client->dev,
+			"can not write register, returned %d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+static bool __devinit qt1070_identify(struct i2c_client *client)
+{
+	int id, ver;
+
+	/* Read Chip ID */
+	id = qt1070_read(client, CHIP_ID);
+	if (id != QT1070_CHIP_ID) {
+		dev_err(&client->dev, "ID %d not supported\n", id);
+		return false;
+	}
+
+	/* Read firmware version */
+	ver = qt1070_read(client, FW_VERSION);
+	if (ver < 0) {
+		dev_err(&client->dev, "could not read the firmware version\n");
+		return false;
+	}
+
+	dev_info(&client->dev, "AT42QT1070 firmware version %x\n", ver);
+
+	return true;
+}
+
+static irqreturn_t qt1070_interrupt(int irq, void *dev_id)
+{
+	struct qt1070_data *data = dev_id;
+	struct i2c_client *client = data->client;
+	struct input_dev *input = data->input;
+	unsigned short new_key, old_key, keyval;
+	int ret, i, mask;
+
+	/* Read the detected status register, using to clear interrupt */
+	ret = qt1070_read(client, DET_STATUS);
+
+	/* Read which key changed */
+	ret = qt1070_read(client, KEY_STATUS);
+	old_key = data->key;
+	data->key = new_key = ret;
+
+	mask = 0x01;
+	for (i = 0; i < ARRAY_SIZE(qt1070_key2code); i++) {
+		keyval = new_key & mask;
+		if ((old_key & mask) != keyval)
+			input_report_key(input, data->keycodes[i], keyval);
+		mask <<= 1;
+	}
+	input_sync(input);
+
+	return IRQ_HANDLED;
+}
+
+static int __devinit qt1070_probe(struct i2c_client *client,
+				const struct i2c_device_id *id)
+{
+	struct qt1070_data *data;
+	struct input_dev *input;
+	int i;
+	int err;
+
+	err = i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE);
+	if (!err) {
+		dev_err(&client->dev, "%s adapter not supported\n",
+			dev_driver_string(&client->adapter->dev));
+		return -ENODEV;
+	}
+
+	/* Identify the qt1070 chip */
+	if (!qt1070_identify(client))
+		return -ENODEV;
+
+	data = kzalloc(sizeof(struct qt1070_data), GFP_KERNEL);
+	input = input_allocate_device();
+	if (!data || !input) {
+		dev_err(&client->dev, "insufficient memory\n");
+		err = -ENOMEM;
+		goto err_free_mem;
+	}
+
+	data->client = client;
+	data->input = input;
+	data->irq = client->irq;
+
+	input->name = "AT42QT1070 QTouch Sensor";
+	input->dev.parent = &client->dev;
+	input->id.bustype = BUS_I2C;
+
+	/* Add the keycode */
+	input->keycode = data->keycodes;
+	input->keycodesize = sizeof(data->keycodes[0]);
+	input->keycodemax = ARRAY_SIZE(qt1070_key2code);
+
+	__set_bit(EV_KEY, input->evbit);
+
+	for (i = 0; i < ARRAY_SIZE(qt1070_key2code); i++) {
+		data->keycodes[i] = qt1070_key2code[i];
+		__set_bit(qt1070_key2code[i], input->keybit);
+	}
+
+	/* Calibrate device */
+	qt1070_write(client, CALIBRATE_CMD, 1);
+	msleep(QT1070_CAL_TIME);
+
+	/* Soft reset */
+	qt1070_write(client, RESET, 1);
+	msleep(QT1070_RESET_TIME);
+
+	/* Apply the interrupt */
+	if (!client->irq) {
+		dev_err(&client->dev, "please assign the irq to this device\n");
+		goto err_free_mem;
+	}
+
+	err = request_threaded_irq(client->irq, NULL, qt1070_interrupt,
+		IRQF_TRIGGER_NONE, client->dev.driver->name, data);
+	if (err) {
+		dev_err(&client->dev, "fail to request irq\n");
+		goto err_free_mem;
+	}
+
+	/* Register the input device */
+	err = input_register_device(data->input);
+	if (err) {
+		dev_err(&client->dev, "Failed to register input device\n");
+		goto err_free_irq;
+	}
+
+	i2c_set_clientdata(client, data);
+
+	/* Read to clear the chang line */
+	qt1070_read(client, DET_STATUS);
+
+	return 0;
+
+err_free_irq:
+	free_irq(client->irq, data);
+err_free_mem:
+	input_free_device(input);
+	kfree(data);
+	return err;
+}
+
+static int __devexit qt1070_remove(struct i2c_client *client)
+{
+	struct qt1070_data *data = i2c_get_clientdata(client);
+
+	/* Release IRQ */
+	free_irq(client->irq, data);
+
+	input_unregister_device(data->input);
+	kfree(data);
+
+	i2c_set_clientdata(client, NULL);
+
+	return 0;
+}
+
+static const struct i2c_device_id qt1070_id[] = {
+	{"qt1070", 0},
+	{ },
+};
+
+static struct i2c_driver qt1070_driver = {
+	.driver = {
+		.name = "qt1070",
+		.owner = THIS_MODULE,
+	},
+	.id_table	= qt1070_id,
+	.probe = qt1070_probe,
+	.remove = __devexit_p(qt1070_remove),
+};
+
+static int __init qt1070_init(void)
+{
+	return i2c_add_driver(&qt1070_driver);
+}
+module_init(qt1070_init);
+
+static void __exit qt1070_exit(void)
+{
+	i2c_del_driver(&qt1070_driver);
+}
+module_exit(qt1070_exit);
+
+MODULE_AUTHOR("Bo Shen <voice.shen@atmel.com>");
+MODULE_DESCRIPTION("Driver for AT42QT1070 QTouch sensor");
+MODULE_LICENSE("GPL");
