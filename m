From: Raphael Derosso Pereira <raphaelpereira@gmail.com>
Subject: [PATCH] Atmel AT42QT2160 sensor chip input driver
Date: Thu, 20 Aug 2009 17:15:52 -0300
Message-ID: <f20381800908201315s7cd4cfc1g57c8799218415b8d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f175.google.com ([209.85.210.175]:58352 "EHLO
	mail-yx0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755289AbZHTUPv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Aug 2009 16:15:51 -0400
Received: by yxe5 with SMTP id 5so186357yxe.33
        for <linux-input@vger.kernel.org>; Thu, 20 Aug 2009 13:15:52 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

=46rom: Raphael Derosso Pereira <raphaelpereira@gmail.com>

Initial version of AT42QT2160 Atmel Sensor Chip support. This version o=
nly
supports individual cells (no slide support yet). The code has been tes=
ted
on proprietary development ARM board, but should work fine on other mac=
hines.

Signed-off-by: Raphael Derosso Pereira <raphaelpereira@gmail.com>
---
This is my first patch to linux, so please comment.

diff -uprN -X linux-2.6.26/Documentation/dontdiff
original_kernel/linux-2.6.26/drivers/input/keyboard/Kconfig
linux-2.6.26/drivers/input/keyboard/Kconfig
--- original_kernel/linux-2.6.26/drivers/input/keyboard/Kconfig	2008-07=
-13
18:51:29.000000000 -0300
+++ linux-2.6.26/drivers/input/keyboard/Kconfig	2009-08-18
17:25:20.476740835 -0300
@@ -268,6 +268,17 @@ config KEYBOARD_PXA27x
 	  To compile this driver as a module, choose M here: the
 	  module will be called pxa27x_keypad.

+config QT2160
+	tristate "Atmel AT42QT2160 Touch Sensor Chip"
+	depends on EXPERIMENTAL
+	select I2C
+	help
+	  If you say yes here you get support for Atmel AT42QT2160 Touch
+	  Sensor chip as a keyboard input.
+=09
+	  This driver can also be built as a module. If so, the module
+	  will be called qt2160.
+=09
 config KEYBOARD_AAED2000
 	tristate "AAED-2000 keyboard"
 	depends on MACH_AAED2000
diff -uprN -X linux-2.6.26/Documentation/dontdiff
original_kernel/linux-2.6.26/drivers/input/keyboard/Makefile
linux-2.6.26/drivers/input/keyboard/Makefile
--- original_kernel/linux-2.6.26/drivers/input/keyboard/Makefile	2008-0=
7-13
18:51:29.000000000 -0300
+++ linux-2.6.26/drivers/input/keyboard/Makefile	2009-08-18
17:25:51.313058161 -0300
@@ -20,6 +20,7 @@ obj-$(CONFIG_KEYBOARD_HIL)		+=3D hil_kbd.o
 obj-$(CONFIG_KEYBOARD_HIL_OLD)		+=3D hilkbd.o
 obj-$(CONFIG_KEYBOARD_OMAP)		+=3D omap-keypad.o
 obj-$(CONFIG_KEYBOARD_PXA27x)		+=3D pxa27x_keypad.o
+obj-$(CONFIG_QT2160)		+=3D qt2160.o
 obj-$(CONFIG_KEYBOARD_AAED2000)		+=3D aaed2000_kbd.o
 obj-$(CONFIG_KEYBOARD_GPIO)		+=3D gpio_keys.o
 obj-$(CONFIG_KEYBOARD_HP6XX)		+=3D jornada680_kbd.o
diff -uprN -X linux-2.6.26/Documentation/dontdiff
original_kernel/linux-2.6.26/drivers/input/keyboard/qt2160.c
linux-2.6.26/drivers/input/keyboard/qt2160.c
--- original_kernel/linux-2.6.26/drivers/input/keyboard/qt2160.c	1969-1=
2-31
21:00:00.000000000 -0300
+++ linux-2.6.26/drivers/input/keyboard/qt2160.c	2009-08-20
17:06:35.400982962 -0300
@@ -0,0 +1,394 @@
+/*
+    qt2160.c - Atmel AT42QT2160 Touch Sense Controller
+
+    Copyright (C) 2009 Raphael Derosso Pereira <raphaelpereira@gmail.c=
om>
+
+    This program is free software; you can redistribute it and/or modi=
fy
+    it under the terms of the GNU General Public License as published =
by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+*/
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/jiffies.h>
+#include <linux/i2c.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/input.h>
+#include <linux/mutex.h>
+
+#define QT2160_VALID_CHIPID (0x11)
+
+#define QT2160_CMD_CHIPID    (00)
+#define QT2160_CMD_CODEVER   (01)
+#define QT2160_CMD_GSTAT     (02)
+#define QT2160_CMD_KEYS3     (03)
+#define QT2160_CMD_KEYS4     (04)
+#define QT2160_CMD_SLIDE     (05)
+#define QT2160_CMD_GPIOS     (06)
+#define QT2160_CMD_SUBVER    (07)
+#define QT2160_CMD_CALIBRATE (10)
+
+#define QT2160_CYCLE_INTERVAL	(HZ)
+
+static unsigned char qt2160_key2code[] =3D {
+		KEY_0, KEY_1, KEY_2, KEY_3,
+		KEY_4, KEY_5, KEY_6, KEY_7,
+		KEY_8, KEY_9, KEY_A, KEY_B,
+		KEY_C, KEY_D, KEY_E, KEY_F,
+};
+
+struct qt2160_data {
+	struct mutex mlock;
+	struct i2c_client *client;
+	struct delayed_work handle_work;
+	struct work_struct handle_irq_work;
+	struct input_dev *input;
+	u8 version_major;
+	u8 version_minor;
+	u8 version_rev;
+	u16 key_matrix;
+};
+
+static int qt2160_read(struct i2c_client *client, u8 reg)
+{
+	int ret;
+
+	ret =3D i2c_smbus_write_byte(client, reg);
+	if (ret) {
+		dev_err(&client->dev,
+				"couldn't send request. Returned %d\n", ret);
+		return ret;
+	}
+
+	ret =3D i2c_smbus_read_byte(client);
+	if (ret < 0) {
+		dev_err(&client->dev,
+				"couldn't read register. Returned %d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+static int qt2160_write(struct i2c_client *client, u8 reg, u8 data)
+{
+	int ret;
+
+	ret =3D i2c_smbus_write_byte(client, reg);
+	if (ret) {
+		dev_err(&client->dev,
+				"couldn't send request. Returned %d\n", ret);
+		return ret;
+	}
+
+	ret =3D i2c_smbus_write_byte(client, data);
+	if (ret) {
+		dev_err(&client->dev,
+				"couldn't write data. Returned %d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+static int qt2160_get_key_matrix(struct i2c_client *client)
+{
+	int ret, i;
+	struct qt2160_data *qt2160;
+	u16 old_matrix;
+
+	dev_dbg(&client->dev, "requesting keys...\n");
+	qt2160 =3D i2c_get_clientdata(client);
+	mutex_lock(&qt2160->mlock);
+
+	/* Read General Status Register */
+	ret =3D qt2160_read(client, QT2160_CMD_GSTAT);
+	if (ret < 0) {
+		dev_err(&client->dev,
+				"could not get general status register\n");
+		goto err_unlock;
+	}
+
+	old_matrix =3D qt2160->key_matrix;
+
+	ret =3D qt2160_read(client, QT2160_CMD_KEYS3);
+	if (ret < 0) {
+		dev_err(&client->dev,
+				"could not get keys from register 3\n");
+		goto err_unlock;
+	}
+
+	qt2160->key_matrix =3D ret;
+
+	ret =3D qt2160_read(client, QT2160_CMD_KEYS4);
+	if (ret < 0) {
+		dev_err(&client->dev,
+				"could not get keys from register 4\n");
+		goto err_unlock;
+	}
+
+	qt2160->key_matrix |=3D (ret << 8);
+
+	/* Read slide and GPIOs to clear CHANGE pin */
+	ret =3D qt2160_read(client, QT2160_CMD_SLIDE);
+	if (ret < 0) {
+		dev_err(&client->dev,
+				"could not get slide status\n");
+		goto err_unlock;
+	}
+
+	ret =3D qt2160_read(client, QT2160_CMD_GPIOS);
+	if (ret < 0) {
+		dev_err(&client->dev, "could not get GPIOs\n");
+		goto err_unlock;
+	}
+
+	for (i =3D 0; i < 16; ++i) {
+		int keyval =3D (qt2160->key_matrix >> i) & 0x01;
+
+		if (((old_matrix >> i) & 0x01) !=3D keyval) {
+			input_report_key(qt2160->input,
+				((unsigned char *)qt2160->input->keycode)[i],
+				keyval);
+			input_sync(qt2160->input);
+
+			if (keyval)
+				dev_dbg(&client->dev, "key %d pressed\n", i);
+			else
+				dev_dbg(&client->dev, "key %d released\n", i);
+		}
+	}
+
+	mutex_unlock(&qt2160->mlock);
+	return 0;
+
+err_unlock:
+	mutex_unlock(&qt2160->mlock);
+	return ret;
+}
+
+static irqreturn_t qt2160_irq(int irq, void *_qt2160)
+{
+	struct qt2160_data *qt2160 =3D _qt2160;
+
+	schedule_work(&qt2160->handle_irq_work);
+	return IRQ_HANDLED;
+}
+
+static void qt2160_worker(struct work_struct *work)
+{
+	struct qt2160_data *qt2160;
+
+	qt2160 =3D container_of(work, struct qt2160_data,
+			handle_irq_work);
+
+	dev_dbg(&qt2160->client->dev, "irq worker\n");
+	qt2160_get_key_matrix(qt2160->client);
+}
+
+static void qt2160_cycle_worker(struct work_struct *work)
+{
+	struct qt2160_data *qt2160;
+
+	qt2160 =3D container_of(work, struct qt2160_data,
+			handle_work.work);
+
+	dev_dbg(&qt2160->client->dev, "cycling worker\n");
+	qt2160_get_key_matrix(qt2160->client);
+
+	/* Avoid lock checking every 500ms */
+	schedule_delayed_work(&qt2160->handle_work, QT2160_CYCLE_INTERVAL);
+}
+
+static int __devinit qt2160_probe(struct i2c_client *client,
+		const struct i2c_device_id *id)
+{
+	int ret, i;
+	struct qt2160_data *qt2160;
+
+	dev_info(&client->dev, "probing device...\n");
+
+	/* Read Chid ID to check if chip is valid */
+	ret =3D qt2160_read(client, QT2160_CMD_CHIPID);
+	if (ret !=3D QT2160_VALID_CHIPID) {
+		dev_err(&client->dev, "ID %d not supported\n", ret);
+		return ret;
+	}
+
+	/* Chip is valid and active. Allocate structure */
+	qt2160 =3D kzalloc(sizeof(struct qt2160_data), GFP_KERNEL);
+	if (!qt2160) {
+		dev_err(&client->dev, "insufficient memory\n");
+		return -ENOMEM;
+	}
+
+	i2c_set_clientdata(client, qt2160);
+	qt2160->client =3D client;
+
+	/* Read chip firmware version */
+	ret =3D qt2160_read(client, QT2160_CMD_CODEVER);
+	if (ret < 0) {
+		dev_err(&client->dev, "could not get firmware version\n");
+		goto err_free_qtdata;
+	}
+
+	qt2160->version_major =3D ret >> 4;
+	qt2160->version_minor =3D ret & 0xf;
+
+	/* Read chip firmware revision */
+	ret =3D qt2160_read(client, QT2160_CMD_SUBVER);
+	if (ret < 0) {
+		dev_err(&client->dev, "could not get firmware revision\n");
+		goto err_free_qtdata;
+	}
+
+	qt2160->version_rev =3D ret;
+
+	dev_info(&client->dev, "AT42QT2160 firmware version %d.%d.%d\n",
+			qt2160->version_major, qt2160->version_minor,
+			qt2160->version_rev);
+
+	/* Calibrate device */
+	ret =3D qt2160_write(client, QT2160_CMD_CALIBRATE, 1);
+	if (ret) {
+		dev_err(&client->dev,
+			"Failed to calibrate device\n");
+		goto err_free_input;
+	}
+
+	/* Initialize input structure */
+	qt2160->input =3D input_allocate_device();
+	if (!qt2160->input) {
+		dev_err(&client->dev, "input device: Not enough memory\n");
+		ret =3D -ENOMEM;
+		goto err_free_qtdata;
+	}
+
+	qt2160->input->name =3D "AT42QT2160 Touch Sense Keyboard";
+	qt2160->input->id.bustype =3D BUS_I2C;
+	qt2160->input->keycode =3D qt2160_key2code;
+	qt2160->input->keycodesize =3D sizeof(unsigned char);
+	qt2160->input->keycodemax =3D ARRAY_SIZE(qt2160_key2code);
+
+	__set_bit(EV_KEY, qt2160->input->evbit);
+	__clear_bit(EV_REP, qt2160->input->evbit);
+	for (i =3D 0; i < ARRAY_SIZE(qt2160_key2code); i++)
+		__set_bit(qt2160_key2code[i], qt2160->input->keybit);
+
+	ret =3D input_register_device(qt2160->input);
+	if (ret) {
+		dev_err(&client->dev,
+			"input device: Failed to register device\n");
+		goto err_free_input;
+	}
+
+	/* Initialize IRQ structure */
+	mutex_init(&qt2160->mlock);
+
+	INIT_DELAYED_WORK(&qt2160->handle_work, qt2160_cycle_worker);
+	INIT_WORK(&qt2160->handle_irq_work, qt2160_worker);
+	schedule_delayed_work(&qt2160->handle_work, QT2160_CYCLE_INTERVAL);
+
+	if (client->irq) {
+		ret =3D request_irq(client->irq, qt2160_irq,
+				  (IRQF_TRIGGER_FALLING), "qt2160", qt2160);
+
+		if (ret) {
+			dev_err(&client->dev,
+				"failed to allocate irq %d\n",
+				client->irq);
+			goto err_free_input;
+		}
+	}
+
+	dev_info(&client->dev, "AT42QT2160 reset completed\n");
+	return 0;
+
+err_free_input:
+	input_free_device(qt2160->input);
+
+err_free_qtdata:
+	kfree(qt2160);
+	i2c_set_clientdata(client, NULL);
+	return ret;
+}
+
+static int __devexit qt2160_remove(struct i2c_client *client)
+{
+	struct qt2160_data *qt2160;
+
+	qt2160 =3D i2c_get_clientdata(client);
+
+	/* Release IRQ so no queue will be scheduled */
+	free_irq(client->irq, qt2160);
+
+	/* Wait all pending works */
+	cancel_delayed_work_sync(&qt2160->handle_work);
+	cancel_work_sync(&qt2160->handle_irq_work);
+
+	/* Unregister input device */
+	input_unregister_device(qt2160->input);
+
+	/* Free client data */
+	kfree(qt2160);
+	i2c_set_clientdata(client, NULL);
+
+	dev_info(&client->dev, "AT42QT2160 removed.\n");
+	return 0;
+}
+
+static struct i2c_device_id qt2160_idtable[] =3D {
+	{ "qt2160", 0, },
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, qt2160_idtable);
+
+static struct i2c_driver qt2160_driver =3D {
+	.driver =3D {
+		.name	=3D "qt2160",
+		.owner  =3D THIS_MODULE,
+	},
+
+	.id_table	=3D qt2160_idtable,
+	.probe		=3D qt2160_probe,
+	.remove		=3D qt2160_remove,
+};
+
+static int __init qt2160_init(void)
+{
+	int res;
+
+	res =3D i2c_add_driver(&qt2160_driver);
+	if (res) {
+		printk(KERN_ERR "qt2160: Driver registration failed, "
+				"module not inserted.\n");
+		return res;
+	}
+	return 0;
+}
+
+static void __exit qt2160_cleanup(void)
+{
+	i2c_del_driver(&qt2160_driver);
+}
+
+MODULE_AUTHOR("Raphael Derosso Pereira <raphaelpereira@gmail.com>");
+MODULE_DESCRIPTION("Driver for AT42QT2160 Touch Sensor");
+MODULE_LICENSE("GPL");
+
+module_init(qt2160_init);
+module_exit(qt2160_cleanup);


--=20
Raphael Derosso Pereira
Engenheiro de Computa=E7=E3o
msn: rderossopereira@hotmail.com
Skype: rderossopereira
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
