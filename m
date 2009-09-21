From: Raphael Derosso Pereira <raphaelpereira@gmail.com>
Subject: Re: [PATCH] Atmel AT42QT2160 sensor chip input driver
Date: Mon, 21 Sep 2009 12:35:21 -0300
Message-ID: <f20381800909210835h66d695f2i10d95c3ed040efe7@mail.gmail.com>
References: <f20381800908201315s7cd4cfc1g57c8799218415b8d@mail.gmail.com>
	 <20090915042612.GB1132@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.249]:12519 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813AbZIUPfS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Sep 2009 11:35:18 -0400
Received: by an-out-0708.google.com with SMTP id d40so4189493and.1
        for <linux-input@vger.kernel.org>; Mon, 21 Sep 2009 08:35:21 -0700 (PDT)
In-Reply-To: <20090915042612.GB1132@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hello Dimitry,

2009/9/15 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
>
> This version is much better, thank you very much for making the chang=
es
> I requested.

You're very welcomed, let's see this version I'm sending now!

>
>> +
>> +#define QT2160_CMD_CHIPID =A0 =A0(00)
>> +#define QT2160_CMD_CODEVER =A0 (01)
>> +#define QT2160_CMD_GSTAT =A0 =A0 (02)
>> +#define QT2160_CMD_KEYS3 =A0 =A0 (03)
>> +#define QT2160_CMD_KEYS4 =A0 =A0 (04)
>> +#define QT2160_CMD_SLIDE =A0 =A0 (05)
>> +#define QT2160_CMD_GPIOS =A0 =A0 (06)
>> +#define QT2160_CMD_SUBVER =A0 =A0(07)
>> +#define QT2160_CMD_CALIBRATE (10)
>
> I am a bit concerned about this chunk. The first 8 commands are writt=
en
> as octal while the last (calibrate) as decimal. Is this intentional?

You are right. There's no need to declare them as octal.

>
> I also made a few more changes. Could you please trythe patch below a=
nd
> if everything is still working I will apply to my tree.

As I had already made other modifications, I added your changes into
my code, correct a bug you inserted (qt2160_read must return the
variable value and not 0 at the end), and I'm sending a patch against
2.6.31. Hope you don't mind.

--

=46rom: Raphael Derosso Pereira <raphaelpereira@gmail.com>

Input: AT42QT2160

Inclusion of input->open and input->close plus Dmitry fixups plus other=
 cleanups
needed after checking code.

Signed-off-by: Raphael Derosso Pereira <raphaelpereira@gmail.com>
--
diff -pruN linux-2.6.31_orig/drivers/input/keyboard/Kconfig
linux-2.6.31_rp/drivers/input/keyboard/Kconfig
--- linux-2.6.31_orig/drivers/input/keyboard/Kconfig	2009-09-09
19:13:59.000000000 -0300
+++ linux-2.6.31_rp/drivers/input/keyboard/Kconfig	2009-09-21
12:09:49.000000000 -0300
@@ -361,4 +361,22 @@ config KEYBOARD_XTKBD
 	  To compile this driver as a module, choose M here: the
 	  module will be called xtkbd.

+config QT2160
+	tristate "Atmel AT42QT2160 Touch Sensor Chip"
+	depends on EXPERIMENTAL
+	select I2C
+	help
+	  If you say yes here you get support for Atmel AT42QT2160 Touch
+	  Sensor chip as a keyboard input.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called qt2160.
+
+config QT2160_DEBUG
+	bool "AT42QT2160 Debug Messages"
+	depends on QT2160
+	help
+	  Generates lots of debug from driver to help show what is going
+	  on under the hoods.
+
 endif
diff -pruN linux-2.6.31_orig/drivers/input/keyboard/Makefile
linux-2.6.31_rp/drivers/input/keyboard/Makefile
--- linux-2.6.31_orig/drivers/input/keyboard/Makefile	2009-09-09
19:13:59.000000000 -0300
+++ linux-2.6.31_rp/drivers/input/keyboard/Makefile	2009-09-21
10:19:23.000000000 -0300
@@ -31,3 +31,4 @@ obj-$(CONFIG_KEYBOARD_STOWAWAY)		+=3D stow
 obj-$(CONFIG_KEYBOARD_SUNKBD)		+=3D sunkbd.o
 obj-$(CONFIG_KEYBOARD_TOSA)		+=3D tosakbd.o
 obj-$(CONFIG_KEYBOARD_XTKBD)		+=3D xtkbd.o
+obj-$(CONFIG_QT2160)		+=3D qt2160.o
diff -pruN linux-2.6.31_orig/drivers/input/keyboard/qt2160.c
linux-2.6.31_rp/drivers/input/keyboard/qt2160.c
--- linux-2.6.31_orig/drivers/input/keyboard/qt2160.c	1969-12-31
21:00:00.000000000 -0300
+++ linux-2.6.31_rp/drivers/input/keyboard/qt2160.c	2009-09-21
12:13:43.000000000 -0300
@@ -0,0 +1,432 @@
+/*
+ *  qt2160.c - Atmel AT42QT2160 Touch Sense Controller
+ *
+ *  Copyright (C) 2009 Raphael Derosso Pereira <raphaelpereira@gmail.c=
om>
+ *
+ *  This program is free software; you can redistribute it and/or modi=
fy
+ *  it under the terms of the GNU General Public License as published =
by
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
+
+#include <linux/autoconf.h>
+#ifdef CONFIG_QT2160_DEBUG
+#define DEBUG
+#endif
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
+
+#define QT2160_VALID_CHIPID  0x11
+
+#define QT2160_CMD_CHIPID     0
+#define QT2160_CMD_CODEVER    1
+#define QT2160_CMD_GSTAT      2
+#define QT2160_CMD_KEYS3      3
+#define QT2160_CMD_KEYS4      4
+#define QT2160_CMD_SLIDE      5
+#define QT2160_CMD_GPIOS      6
+#define QT2160_CMD_SUBVER     7
+#define QT2160_CMD_CALIBRATE  10
+
+#define QT2160_CYCLE_INTERVAL	(2*HZ)
+
+static unsigned char qt2160_key2code[] =3D {
+	KEY_0, KEY_1, KEY_2, KEY_3,
+	KEY_4, KEY_5, KEY_6, KEY_7,
+	KEY_8, KEY_9, KEY_A, KEY_B,
+	KEY_C, KEY_D, KEY_E, KEY_F,
+};
+
+struct qt2160_data {
+	struct i2c_client *client;
+	struct delayed_work dwork;
+	struct input_dev *input;
+	spinlock_t lock;        /* Protects canceling/rescheduling of dwork *=
/
+	unsigned short keycodes[ARRAY_SIZE(qt2160_key2code)];
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
+			"couldn't send request. Returned %d\n", ret);
+		return ret;
+	}
+
+	ret =3D i2c_smbus_read_byte(client);
+	if (ret < 0) {
+		dev_err(&client->dev,
+			"couldn't read register. Returned %d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+static int qt2160_read_block(struct i2c_client *client, u8 inireg, u8 =
*buffer,
+	unsigned int count)
+{
+	int error, idx =3D 0;
+
+	/*
+	 * Can't use SMBus block data read. Check for I2C functionality to sp=
eed
+	 * things up whenever possible. Otherwise we will be forced to read
+	 * sequentially.
+	 */
+	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C))	{
+
+		error =3D i2c_smbus_write_byte(client, inireg + idx);
+		if (error) {
+			dev_err(&client->dev,
+				"couldn't send request. Returned %d\n", error);
+			return error;
+		}
+
+		error =3D i2c_master_recv(client, buffer, count);
+		if (error !=3D count) {
+			dev_err(&client->dev,
+				"couldn't read registers. Returned %d bytes\n", error);
+			return error;
+		}
+	} else {
+
+		while (count--) {
+			int data;
+
+			error =3D i2c_smbus_write_byte(client, inireg + idx);
+			if (error) {
+				dev_err(&client->dev,
+					"couldn't send request. Returned %d\n", error);
+				return error;
+			}
+
+			data =3D i2c_smbus_read_byte(client);
+			if (data < 0) {
+				dev_err(&client->dev,
+					"couldn't read register. Returned %d\n", data);
+				return data;
+			}
+
+			buffer[idx++] =3D data;
+		}
+	}
+
+	return 0;
+}
+
+static int qt2160_write(struct i2c_client *client, u8 reg, u8 data)
+{
+	int error;
+
+	error =3D i2c_smbus_write_byte(client, reg);
+	if (error) {
+		dev_err(&client->dev,
+			"couldn't send request. Returned %d\n", error);
+		return error;
+	}
+
+	error =3D i2c_smbus_write_byte(client, data);
+	if (error) {
+		dev_err(&client->dev,
+			"couldn't write data. Returned %d\n", error);
+		return error;
+	}
+
+	return error;
+}
+
+static int qt2160_get_key_matrix(struct qt2160_data *qt2160)
+{
+	struct i2c_client *client =3D qt2160->client;
+	struct input_dev *input =3D qt2160->input;
+	u8 regs[6];
+	u16 old_matrix, new_matrix;
+	int ret, i, mask;
+
+	dev_dbg(&client->dev, "requesting keys...\n");
+
+	/* Read all registers from General Status Register
+	 * to GPIOs register
+	 */
+	ret =3D qt2160_read_block(client, QT2160_CMD_GSTAT, regs, 6);
+	if (ret) {
+		dev_err(&client->dev,
+			"could not perform chip read.\n");
+		return ret;
+	}
+
+	old_matrix =3D qt2160->key_matrix;
+	qt2160->key_matrix =3D new_matrix =3D (regs[2] << 8) | regs[1];
+
+	mask =3D 0x01;
+	for (i =3D 0; i < 16; ++i, mask <<=3D 1) {
+		int keyval =3D new_matrix & mask;
+
+		if ((old_matrix & mask) !=3D keyval) {
+
+			dev_dbg(&client->dev, "key %d %s\n",
+				i, keyval ? "pressed" : "released");
+
+			input_report_key(input, qt2160->keycodes[i], keyval);
+
+			input_sync(input);
+		}
+	}
+
+	return 0;
+}
+
+static irqreturn_t qt2160_irq(int irq, void *_qt2160)
+{
+	struct qt2160_data *qt2160 =3D _qt2160;
+	unsigned long flags;
+
+	spin_lock_irqsave(&qt2160->lock, flags);
+
+	__cancel_delayed_work(&qt2160->dwork);
+	schedule_delayed_work(&qt2160->dwork, 0);
+
+	spin_unlock_irqrestore(&qt2160->lock, flags);
+
+	return IRQ_HANDLED;
+}
+
+static void qt2160_worker(struct work_struct *work)
+{
+	struct qt2160_data *qt2160 =3D
+		container_of(work, struct qt2160_data, dwork.work);
+
+	dev_dbg(&qt2160->client->dev, "worker\n");
+
+	qt2160_get_key_matrix(qt2160);
+
+	/* Avoid lock, checking every QT2160_CYCLE_INTERVAL */
+	spin_lock_irq(&qt2160->lock);
+	schedule_delayed_work(&qt2160->dwork, QT2160_CYCLE_INTERVAL);
+	spin_unlock_irq(&qt2160->lock);
+}
+
+
+static int qt2160_open(struct input_dev *dev)
+{
+	int error;
+	struct qt2160_data *qt2160;
+	struct i2c_client *client;
+
+	qt2160 =3D input_get_drvdata(dev);
+	client =3D qt2160->client;
+
+	/* Calibrate device */
+	error =3D qt2160_write(client, QT2160_CMD_CALIBRATE, 1);
+	if (error) {
+		dev_err(&client->dev,
+			"failed to calibrate device\n");
+		return error;
+	}
+
+	/* Initialize IRQ structure */
+	schedule_delayed_work(&qt2160->dwork, QT2160_CYCLE_INTERVAL);
+
+	if (client->irq) {
+		error =3D request_irq(client->irq, qt2160_irq,
+			(IRQF_TRIGGER_FALLING), "qt2160", qt2160);
+
+		if (error) {
+			dev_err(&client->dev,
+				"failed to allocate irq %d\n", client->irq);
+			return error;
+		}
+	}
+
+	return 0;
+}
+
+void qt2160_close(struct input_dev *dev)
+{
+	struct qt2160_data *qt2160;
+
+	qt2160 =3D input_get_drvdata(dev);
+
+	/* Release IRQ so no queue will be scheduled */
+	if (qt2160->client->irq)
+		free_irq(qt2160->client->irq, qt2160);
+
+	/* Wait all pending works */
+	cancel_delayed_work_sync(&qt2160->dwork);
+}
+
+static bool __devinit qt2160_identify(struct i2c_client *client)
+{
+	int id, ver, rev;
+
+	/* Read Chid ID to check if chip is valid */
+	id =3D qt2160_read(client, QT2160_CMD_CHIPID);
+	if (id !=3D QT2160_VALID_CHIPID) {
+		dev_err(&client->dev, "ID %d not supported\n", id);
+		return false;
+	}
+
+	/* Read chip firmware version */
+	ver =3D qt2160_read(client, QT2160_CMD_CODEVER);
+	if (ver < 0) {
+		dev_err(&client->dev, "could not get firmware version\n");
+		return false;
+	}
+
+	/* Read chip firmware revision */
+	rev =3D qt2160_read(client, QT2160_CMD_SUBVER);
+	if (rev < 0) {
+		dev_err(&client->dev, "could not get firmware revision\n");
+		return false;
+	}
+
+	dev_info(&client->dev, "AT42QT2160 firmware version %d.%d.%d\n",
+			ver >> 4, ver & 0xf, rev);
+
+	return true;
+}
+
+static int __devinit
+	qt2160_probe(struct i2c_client *client, const struct i2c_device_id *i=
d)
+{
+	struct qt2160_data *qt2160 =3D NULL;
+	struct input_dev *input =3D NULL;
+	int i;
+	int error;
+
+	/* Check functionality */
+	error =3D i2c_check_functionality(client->adapter,
+			I2C_FUNC_SMBUS_BYTE);
+	if (!error) {
+		dev_err(&client->dev, "%s adapter not supported\n",
+				dev_driver_string(&client->adapter->dev));
+		return -ENODEV;
+	}
+
+	dev_info(&client->dev, "probing device...\n");
+
+	if (!qt2160_identify(client))
+		return -ENODEV;
+
+	/* Chip is valid and active. Allocate structure */
+	qt2160 =3D kzalloc(sizeof(struct qt2160_data), GFP_KERNEL);
+	input =3D input_allocate_device();
+	if (!qt2160 || !input) {
+		dev_err(&client->dev, "insufficient memory\n");
+		error =3D -ENOMEM;
+		goto err_free_mem;
+	}
+
+	qt2160->client =3D client;
+	qt2160->input =3D input;
+	INIT_DELAYED_WORK(&qt2160->dwork, qt2160_worker);
+	spin_lock_init(&qt2160->lock);
+
+	qt2160->input->name =3D "AT42QT2160 Touch Sense Keyboard";
+	qt2160->input->id.bustype =3D BUS_I2C;
+
+	qt2160->input->keycode =3D qt2160->keycodes;
+	qt2160->input->keycodesize =3D sizeof(unsigned char);
+	qt2160->input->keycodemax =3D ARRAY_SIZE(qt2160_key2code);
+
+	qt2160->input->open  =3D qt2160_open;
+	qt2160->input->close =3D qt2160_close;
+
+	__set_bit(EV_KEY, qt2160->input->evbit);
+	__clear_bit(EV_REP, qt2160->input->evbit);
+	for (i =3D 0; i < ARRAY_SIZE(qt2160_key2code); i++) {
+		qt2160->keycodes[i] =3D qt2160_key2code[i];
+		__set_bit(qt2160_key2code[i], qt2160->input->keybit);
+	}
+
+	/* Must define drvdata to be used by qt2160_open */
+	i2c_set_clientdata(client, qt2160);
+	input_set_drvdata(input, qt2160);
+
+	error =3D input_register_device(qt2160->input);
+	if (error) {
+		dev_err(&client->dev,
+			"input device: Failed to register device\n");
+		goto err_free_drvdata;
+	}
+
+	dev_info(&client->dev, "AT42QT2160 activated\n");
+	return 0;
+
+err_free_drvdata:
+	i2c_set_clientdata(client, NULL);
+
+err_free_mem:
+	input_free_device(qt2160->input);
+	kfree(qt2160);
+	return error;
+}
+
+static int __devexit qt2160_remove(struct i2c_client *client)
+{
+	struct qt2160_data *qt2160 =3D i2c_get_clientdata(client);
+
+	/* Unregister input device */
+	input_unregister_device(qt2160->input);
+
+	/* Free client data */
+	kfree(qt2160);
+	i2c_set_clientdata(client, NULL);
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
+	.remove		=3D __devexit_p(qt2160_remove),
+};
+
+static int __init qt2160_init(void)
+{
+	return i2c_add_driver(&qt2160_driver);
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
