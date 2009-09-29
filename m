From: Jernej Turnsek <jernej.turnsek@gmail.com>
Subject: [PATCH] Touchscreen driver for the DTS413
Date: Tue, 29 Sep 2009 14:14:25 +0200
Message-ID: <a57e67db0909290514r3097a97dtbb82e28a5176ac64@mail.gmail.com>
References: <a57e67db0909280023q7d352f22ge5b5343dc0c79c65@mail.gmail.com>
	 <4AC1DAA4.4090508@simtec.co.uk>
	 <a57e67db0909290500k52bcd1faj28903a22cd2c91a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:62645 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752235AbZI2MOX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Sep 2009 08:14:23 -0400
Received: by ey-out-2122.google.com with SMTP id 4so261930eyf.19
        for <linux-input@vger.kernel.org>; Tue, 29 Sep 2009 05:14:25 -0700 (PDT)
In-Reply-To: <a57e67db0909290500k52bcd1faj28903a22cd2c91a5@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

---------- Forwarded message ----------
=46rom: Jernej Turnsek <jernej.turnsek@gmail.com>
Date: Tue, Sep 29, 2009 at 2:00 PM
Subject: Re: [PATCH] Touchscreen driver for the DTS413
To: Ben Dooks <ben@simtec.co.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-input@atrey.karlin.mff.=
cuni.cz


Hi,

corrected version of the DT413 driver doesn't include bit fields
anymore, instead it is using shifting method. Also some comments are
added in kernel doc format.
I would like to thank to Ben Dooks for making some suggestions.

DTS413 is capable of so much more than this driver is supporting, thus
one can feel free to make upgrades.


Simple DTS413 Touchscreen driver.

Signed-off-by: Jernej Turnsek <jernej.turnsek@gmail.com>

diff --git a/drivers/input/touchscreen/Kconfig
b/drivers/input/touchscreen/Kconfig
index ab02d72..b2403f5 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -510,6 +510,17 @@ config TOUCHSCREEN_W90X900
=A0 =A0 =A0 =A0 =A0To compile this driver as a module, choose M here: t=
he
=A0 =A0 =A0 =A0 =A0module will be called w90p910_ts.

+config TOUCHSCREEN_DTS413
+ =A0 =A0 =A0 tristate "DTS413 based touchscreens"
+ =A0 =A0 =A0 depends on I2C
+ =A0 =A0 =A0 help
+ =A0 =A0 =A0 =A0 Say Y here if you have a DTS413 based touchscreen.
+
+ =A0 =A0 =A0 =A0 If unsure, say N.
+
+ =A0 =A0 =A0 =A0 To compile this driver as a module, choose M here: th=
e
+ =A0 =A0 =A0 =A0 module will be called dts413.
+
=A0config TOUCHSCREEN_PCAP
=A0 =A0 =A0 =A0tristate "Motorola PCAP touchscreen"
=A0 =A0 =A0 =A0depends on EZX_PCAP
diff --git a/drivers/input/touchscreen/Makefile
b/drivers/input/touchscreen/Makefile
index 4599bf7..be7315b 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -40,4 +40,6 @@ obj-$(CONFIG_TOUCHSCREEN_WM97XX_ATMEL) =A0 =A0 =A0 =A0=
+=3D
atmel-wm97xx.o
=A0obj-$(CONFIG_TOUCHSCREEN_WM97XX_MAINSTONE) =A0 =A0 +=3D mainstone-wm=
97xx.o
=A0obj-$(CONFIG_TOUCHSCREEN_WM97XX_ZYLONITE) =A0 =A0 =A0+=3D zylonite-w=
m97xx.o
=A0obj-$(CONFIG_TOUCHSCREEN_W90X900) =A0 =A0 =A0+=3D w90p910_ts.o
+obj-$(CONFIG_TOUCHSCREEN_DTS413) =A0 =A0 =A0 +=3D dts413.o
=A0obj-$(CONFIG_TOUCHSCREEN_PCAP) =A0 =A0 =A0 =A0 +=3D pcap_ts.o
+
diff --git a/drivers/input/touchscreen/dts413.c
b/drivers/input/touchscreen/dts413.c
new file mode 100644
index 0000000..ff3be9b
--- /dev/null
+++ b/drivers/input/touchscreen/dts413.c
@@ -0,0 +1,286 @@
+/*
+ * drivers/input/touchscreen/dts413.c
+ *
+ * Copyright (c) 2009 Iskraemeco d.d.
+ * =A0 =A0 Jernej Turnsek <jernej.turnsek@iskraemeco.si>
+ *
+ * Using code from:
+ * =A0- migor_ts.c
+ * Copyright (c) 2008 Magnus Damm
+ * Copyright (c) 2007 Ujjwal Pande <ujjwal@kenati.com>,
+ * =A0Kenati Technologies Pvt Ltd.
+ *
+ * =A0This program is free software; you can redistribute it and/or mo=
dify
+ * =A0it under the terms of the GNU General Public License version 2 a=
s
+ * =A0published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/i2c.h>
+#include <linux/timer.h>
+#include <linux/workqueue.h>
+
+
+#define =A0 =A0 =A0 =A0MAX_11BIT =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((1 << 11=
) - 1)
+
+#define EVENT_PENDOWN =A01
+#define EVENT_PENUP =A0 =A0 =A0 =A0 =A0 =A00
+
+/**
+ * struct dts413 - device structure
+ * @client: the i2c client,
+ * @input: the input device,
+ * @work: workqueue,
+ * @irq: irq number.
+ *
+ * Structure for holding the internal context of a driver.
+ */
+struct dts413 {
+ =A0 =A0 =A0 struct i2c_client *client;
+ =A0 =A0 =A0 struct input_dev *input;
+ =A0 =A0 =A0 struct work_struct work;
+ =A0 =A0 =A0 int irq;
+};
+
+/**
+ * dts413_poscheck() - function for position checking
+ * @work: workqueue.
+ *
+ * DTS413 report packet:
+ * =A0 =A0 =A0 =A0MSB =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
LSB
+ * BYTE1:| 1 | R | R | R | R | R | R | S |
+ * BYTE2:| 0 | 0 | 0 | 0 |A10| A9| A8| A7|
+ * BYTE3:| 0 | A6| A5| A4| A3| A2| A1| A0|
+ * BYTE4:| 0 | 0 | 0 | 0 |B10| B9| B8| B7|
+ * BYTE5:| 0 | B6| B5| B4| B3| B2| B1| B0|
+ * BYTE6:| 0 | P6| P5| P4| P3| P2| P1| P0|
+ *
+ * S - status
+ * A10-A0 - 11 bits of 1st direction raw data
+ * B10-B0 - 11 bits of 2st direction raw data
+ * P6-P0 - 7 bits of finger pressure
+ * Please be aware that A nad B just represent 2 resolution directions
+ * of the touch panel. The reported coordinates are (0~2047,0-2047),
+ * the bottom left is (0,0).
+ */
+static void dts413_poscheck(struct work_struct *work)
+{
+ =A0 =A0 =A0 struct dts413 *priv =3D container_of(work,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 struct dts413,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 work);
+ =A0 =A0 =A0 unsigned short xpos, ypos;
+ =A0 =A0 =A0 u_int8_t event, speed;
+ =A0 =A0 =A0 u_int8_t buf[6];
+
+ =A0 =A0 =A0 memset(buf, 0, sizeof(buf));
+
+ =A0 =A0 =A0 /* now do page read */
+ =A0 =A0 =A0 if (i2c_master_recv(priv->client, buf, sizeof(buf)) !=3D =
sizeof(buf)) {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&priv->client->dev, "Unable to re=
ad i2c page\n");
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
+ =A0 =A0 =A0 }
+
+ =A0 =A0 =A0 event =3D (buf[0] & 0x01) ? 1 : 0;
+ =A0 =A0 =A0 xpos =3D (unsigned short)(buf[2] & 0x7f) |
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((unsigned short)(buf[1] =
& 0x0f) << 7);
+ =A0 =A0 =A0 ypos =3D (unsigned short)(buf[4] & 0x7f) |
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((unsigned short)(buf[3] =
& 0x0f) << 7);
+ =A0 =A0 =A0 speed =3D (buf[5] & 0x7f);
+
+ =A0 =A0 =A0 if (event =3D=3D EVENT_PENDOWN) {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(priv->input, BTN_TOUCH, =
1);
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(priv->input, ABS_X, xpos=
);
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(priv->input, ABS_Y, 2048=
 - ypos);
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(priv->input, ABS_PRESSUR=
E, 1);
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_sync(priv->input);
+ =A0 =A0 =A0 } else if (event =3D=3D EVENT_PENUP) {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(priv->input, BTN_TOUCH, =
0);
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(priv->input, ABS_PRESSUR=
E, 0);
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_sync(priv->input);
+ =A0 =A0 =A0 }
+ out:
+ =A0 =A0 =A0 enable_irq(priv->irq);
+}
+
+/**
+ * dts413_isr() - interrupt service routine
+ * @irg: irq number.
+ * @dev_id: dts413 device.
+ *
+ * The touch screen controller chip is hooked up to the cpu
+ * using i2c and a single interrupt line. The interrupt line
+ * is pulled low whenever someone taps the screen. To deassert
+ * the interrupt line we need to acknowledge the interrupt by
+ * communicating with the controller over the slow i2c bus.
+ *
+ * We can't acknowledge from interrupt context since the i2c
+ * bus controller may sleep, so we just disable the interrupt
+ * here and handle the acknowledge using delayed work.
+ */
+static irqreturn_t dts413_isr(int irq, void *dev_id)
+{
+ =A0 =A0 =A0 struct dts413 *priv =3D dev_id;
+
+ =A0 =A0 =A0 disable_irq_nosync(irq);
+ =A0 =A0 =A0 schedule_work(&priv->work);
+
+ =A0 =A0 =A0 return IRQ_HANDLED;
+}
+
+static int dts413_open(struct input_dev *dev)
+{
+ =A0 =A0 =A0 return 0;
+}
+
+static void dts413_close(struct input_dev *dev)
+{
+ =A0 =A0 =A0 struct dts413 *priv =3D input_get_drvdata(dev);
+
+ =A0 =A0 =A0 disable_irq(priv->irq);
+
+ =A0 =A0 =A0 cancel_work_sync(&priv->work);
+
+ =A0 =A0 =A0 enable_irq(priv->irq);
+}
+
+static int dts413_probe(struct i2c_client *client,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const struct i2c_device_i=
d *idp)
+{
+ =A0 =A0 =A0 struct dts413 *priv;
+ =A0 =A0 =A0 struct input_dev *input;
+ =A0 =A0 =A0 int error;
+
+ =A0 =A0 =A0 priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
+ =A0 =A0 =A0 if (!priv) {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "failed to allocate=
 driver data\n");
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D -ENOMEM;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err0;
+ =A0 =A0 =A0 }
+
+ =A0 =A0 =A0 dev_set_drvdata(&client->dev, priv);
+
+ =A0 =A0 =A0 input =3D input_allocate_device();
+ =A0 =A0 =A0 if (!input) {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "Failed to allocate=
 input device.\n");
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D -ENOMEM;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err1;
+ =A0 =A0 =A0 }
+
+ =A0 =A0 =A0 input->evbit[0] =3D BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
+ =A0 =A0 =A0 input->keybit[BIT_WORD(BTN_TOUCH)] =3D BIT_MASK(BTN_TOUCH=
);
+
+ =A0 =A0 =A0 input_set_abs_params(input, ABS_X, 0, MAX_11BIT, 0, 0);
+ =A0 =A0 =A0 input_set_abs_params(input, ABS_Y, 0, MAX_11BIT, 0, 0);
+ =A0 =A0 =A0 input_set_abs_params(input, ABS_PRESSURE, 0, 0, 0, 0);
+
+ =A0 =A0 =A0 input->name =3D client->name;
+ =A0 =A0 =A0 input->id.bustype =3D BUS_I2C;
+ =A0 =A0 =A0 input->dev.parent =3D &client->dev;
+
+ =A0 =A0 =A0 input->open =3D dts413_open;
+ =A0 =A0 =A0 input->close =3D dts413_close;
+
+ =A0 =A0 =A0 input_set_drvdata(input, priv);
+
+ =A0 =A0 =A0 priv->client =3D client;
+ =A0 =A0 =A0 priv->input =3D input;
+ =A0 =A0 =A0 INIT_WORK(&priv->work, dts413_poscheck);
+ =A0 =A0 =A0 priv->irq =3D client->irq;
+
+ =A0 =A0 =A0 error =3D input_register_device(input);
+ =A0 =A0 =A0 if (error)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err1;
+
+ =A0 =A0 =A0 error =3D request_irq(priv->irq, dts413_isr,
IRQF_TRIGGER_FALLING/*IRQF_TRIGGER_LOW*/,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 client->name, pri=
v);
+ =A0 =A0 =A0 if (error) {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "Unable to request =
touchscreen IRQ.\n");
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err2;
+ =A0 =A0 =A0 }
+
+ =A0 =A0 =A0 device_init_wakeup(&client->dev, 1);
+ =A0 =A0 =A0 return 0;
+
+ err2:
+ =A0 =A0 =A0 input_unregister_device(input);
+ =A0 =A0 =A0 input =3D NULL; /* so we dont try to free it below */
+ err1:
+ =A0 =A0 =A0 input_free_device(input);
+ =A0 =A0 =A0 kfree(priv);
+ err0:
+ =A0 =A0 =A0 dev_set_drvdata(&client->dev, NULL);
+ =A0 =A0 =A0 return error;
+}
+
+static int dts413_remove(struct i2c_client *client)
+{
+ =A0 =A0 =A0 struct dts413 *priv =3D dev_get_drvdata(&client->dev);
+
+ =A0 =A0 =A0 free_irq(priv->irq, priv);
+ =A0 =A0 =A0 input_unregister_device(priv->input);
+ =A0 =A0 =A0 kfree(priv);
+
+ =A0 =A0 =A0 dev_set_drvdata(&client->dev, NULL);
+
+ =A0 =A0 =A0 return 0;
+}
+
+static int dts413_suspend(struct i2c_client *client, pm_message_t mesg=
)
+{
+ =A0 =A0 =A0 struct dts413 *priv =3D dev_get_drvdata(&client->dev);
+
+ =A0 =A0 =A0 if (device_may_wakeup(&client->dev))
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 enable_irq_wake(priv->irq);
+
+ =A0 =A0 =A0 return 0;
+}
+
+static int dts413_resume(struct i2c_client *client)
+{
+ =A0 =A0 =A0 struct dts413 *priv =3D dev_get_drvdata(&client->dev);
+
+ =A0 =A0 =A0 if (device_may_wakeup(&client->dev))
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 disable_irq_wake(priv->irq);
+
+ =A0 =A0 =A0 return 0;
+}
+
+static struct i2c_device_id dts413_idtable[] =3D {
+ =A0 =A0 =A0 { "dts413", 0 },
+ =A0 =A0 =A0 { }
+};
+
+MODULE_DEVICE_TABLE(i2c, dts413_idtable);
+
+static struct i2c_driver dts413_driver =3D {
+ =A0 =A0 =A0 .driver =3D {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "dts413"
+ =A0 =A0 =A0 },
+ =A0 =A0 =A0 .id_table =A0 =A0 =A0 =3D dts413_idtable,
+ =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D dts413_probe,
+ =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __devexit_p(dts413_remove),
+ =A0 =A0 =A0 .suspend =3D dts413_suspend,
+ =A0 =A0 =A0 .resume =3D dts413_resume,
+};
+
+static int __init dts413_init(void)
+{
+ =A0 =A0 =A0 return i2c_add_driver(&dts413_driver);
+}
+
+static void __exit dts413_exit(void)
+{
+ =A0 =A0 =A0 i2c_del_driver(&dts413_driver);
+}
+
+module_init(dts413_init);
+module_exit(dts413_exit);
+
+MODULE_AUTHOR("Jernej Turnsek <jernej.turnsek@iskraemeco.si>");
+MODULE_DESCRIPTION("DTS413 Touch Screen Controller driver");
+MODULE_LICENSE("GPL");
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
