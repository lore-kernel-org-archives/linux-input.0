From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH v2] input/misc: PCF8574 I2C keypad
 input device driver
Date: Tue, 9 Mar 2010 20:36:57 -0800
Message-ID: <20100310043656.GA9100@core.coreip.homeip.net>
References: <20100309180906.GA19814@core.coreip.homeip.net>
 <1268168513-7431-1-git-send-email-vapier@gentoo.org>
 <20100309212127.GA29333@core.coreip.homeip.net>
 <8bd0f97a1003091327y5f5596eelb60b3c52694517b1@mail.gmail.com>
 <20100309223038.GB29517@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.211.176]:37117 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756233Ab0CJEhD (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Mar 2010 23:37:03 -0500
Received: by ywh6 with SMTP id 6so3670540ywh.16
        for <linux-input@vger.kernel.org>; Tue, 09 Mar 2010 20:37:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100309223038.GB29517@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, linux-input@vger.kernel.org

On Tue, Mar 09, 2010 at 02:30:39PM -0800, Dmitry Torokhov wrote:
> On Tue, Mar 09, 2010 at 04:27:48PM -0500, Mike Frysinger wrote:
> > On Tue, Mar 9, 2010 at 16:21, Dmitry Torokhov wrote:
> > > On Tue, Mar 09, 2010 at 04:01:53PM -0500, Mike Frysinger wrote:
> > >> From: Bryan Wu <cooloney@kernel.org>
> > >>
> > >> Signed-off-by: Bryan Wu <cooloney@kernel.org>
> > >> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> > >> ---
> > >> v2
> > >> =A0 =A0 =A0 - process all feedback from Dmitry except for thread=
ed irqs; that'll have to be done later
> > >
> > > Could I ask why? As it stands the remove() is racy WRT to a work
> > > running. But if you simply add cancel_work_sync() you'll risk lea=
ving
> > > unbalanced enable_irq()/disable_irq().
> >=20
> > ive never worked with threaded irq handlers before.  i'll have to r=
ead
> > about them before i can do the work.  i'm not suggesting you take t=
he
> > driver now as is ... having it on a list in case someone else wants=
 a
> > mostly-ok driver.
>=20
> It is very simple, take a look at drivers/input/touchscreen/mcs5000_t=
s.c
> Just make sure you request threaded irq with IRQF_ONESHOT.
>=20

Does the following still work by any chance?

--=20
Dmitry

Input: add PCF8574 I2C keypad input device driver

=46rom: Bryan Wu <cooloney@kernel.org>

Signed-off-by: Bryan Wu <cooloney@kernel.org>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/misc/Kconfig          |   10 ++
 drivers/input/misc/Makefile         |    1=20
 drivers/input/misc/pcf8574_keypad.c |  227 +++++++++++++++++++++++++++=
++++++++
 3 files changed, 238 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/misc/pcf8574_keypad.c


diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index b2cd5a1..b8a96ef 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -354,4 +354,14 @@ config INPUT_PCAP
 	  To compile this driver as a module, choose M here: the
 	  module will be called pcap_keys.
=20
+config INPUT_PCF8574
+	tristate "PCF8574 Keypad input device"
+	depends on I2C && EXPERIMENTAL
+	help
+	  Say Y here if you want to support a keypad connetced via I2C
+	  with a PCF8574.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called pcf8574_keypad.
+
 endif
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index f620a09..5e05174 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -6,6 +6,7 @@
=20
 obj-$(CONFIG_INPUT_88PM860X_ONKEY)	+=3D 88pm860x_onkey.o
 obj-$(CONFIG_INPUT_APANEL)		+=3D apanel.o
+obj-$(CONFIG_INPUT_PCF8574)		+=3D pcf8574_keypad.o
 obj-$(CONFIG_INPUT_ATI_REMOTE)		+=3D ati_remote.o
 obj-$(CONFIG_INPUT_ATI_REMOTE2)		+=3D ati_remote2.o
 obj-$(CONFIG_INPUT_ATLAS_BTNS)		+=3D atlas_btns.o
diff --git a/drivers/input/misc/pcf8574_keypad.c b/drivers/input/misc/p=
cf8574_keypad.c
new file mode 100644
index 0000000..91e900b
--- /dev/null
+++ b/drivers/input/misc/pcf8574_keypad.c
@@ -0,0 +1,227 @@
+/*
+ * Driver for a keypad w/16 buttons connected to a PCF8574 I2C I/O exp=
ander
+ *
+ * Copyright 2005-2008 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2 or later.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/i2c.h>
+#include <linux/workqueue.h>
+
+#define DRV_NAME "pcf8574_keypad"
+
+static const unsigned char pcf8574_kp_btncode[] =3D {
+	[0] =3D KEY_RESERVED,
+	[1] =3D KEY_ENTER,
+	[2] =3D KEY_BACKSLASH,
+	[3] =3D KEY_0,
+	[4] =3D KEY_RIGHTBRACE,
+	[5] =3D KEY_C,
+	[6] =3D KEY_9,
+	[7] =3D KEY_8,
+	[8] =3D KEY_7,
+	[9] =3D KEY_B,
+	[10] =3D KEY_6,
+	[11] =3D KEY_5,
+	[12] =3D KEY_4,
+	[13] =3D KEY_A,
+	[14] =3D KEY_3,
+	[15] =3D KEY_2,
+	[16] =3D KEY_1
+};
+
+struct kp_data {
+	unsigned short btncode[ARRAY_SIZE(pcf8574_kp_btncode)];
+	struct input_dev *idev;
+	struct i2c_client *client;
+	char name[64];
+	char phys[32];
+	unsigned char laststate;
+};
+
+static short read_state(struct kp_data *lp)
+{
+	unsigned char x, y, a, b;
+
+	i2c_smbus_write_byte(lp->client, 240);
+	x =3D 0xF & (~(i2c_smbus_read_byte(lp->client) >> 4));
+
+	i2c_smbus_write_byte(lp->client, 15);
+	y =3D 0xF & (~i2c_smbus_read_byte(lp->client));
+
+	for (a =3D 0; x > 0; a++)
+		x =3D x >> 1;
+	for (b =3D 0; y > 0; b++)
+		y =3D y >> 1;
+
+	return ((a - 1) * 4) + b;
+}
+
+static irqreturn_t pcf8574_kp_irq_handler(int irq, void *dev_id)
+{
+	struct kp_data *lp =3D dev_id;
+	unsigned char nextstate =3D read_state(lp);
+
+	if (lp->laststate !=3D nextstate) {
+		int key_down =3D nextstate <=3D ARRAY_SIZE(lp->btncode);
+		unsigned short keycode =3D key_down ?
+			lp->btncode[nextstate] : lp->btncode[lp->laststate];
+
+		input_report_key(lp->idev, keycode, key_down);
+		input_sync(lp->idev);
+
+		lp->laststate =3D nextstate;
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int __devinit pcf8574_kp_probe(struct i2c_client *client, const=
 struct i2c_device_id *id)
+{
+	int i, ret;
+	struct input_dev *idev;
+	struct kp_data *lp;
+
+	if (i2c_smbus_write_byte(client, 240) < 0) {
+		dev_err(&client->dev, "probe: write fail\n");
+		return -ENODEV;
+	}
+
+	lp =3D kzalloc(sizeof(*lp), GFP_KERNEL);
+	if (!lp)
+		return -ENOMEM;
+
+	idev =3D input_allocate_device();
+	if (!idev) {
+		dev_err(&client->dev, "Can't allocate input device\n");
+		ret =3D -ENOMEM;
+		goto fail_allocate;
+	}
+
+	lp->idev =3D idev;
+	lp->client =3D client;
+
+	idev->evbit[0] =3D BIT_MASK(EV_KEY);
+	idev->keycode =3D lp->btncode;
+	idev->keycodesize =3D sizeof(pcf8574_kp_btncode);
+	idev->keycodemax =3D ARRAY_SIZE(pcf8574_kp_btncode);
+
+	for (i =3D 0; i < ARRAY_SIZE(pcf8574_kp_btncode); i++) {
+		lp->btncode[i] =3D pcf8574_kp_btncode[i];
+		__set_bit(lp->btncode[i] & KEY_MAX, idev->keybit);
+	}
+	__clear_bit(KEY_RESERVED, idev->keybit);
+
+	sprintf(lp->name, DRV_NAME);
+	sprintf(lp->phys, "kp_data/input0");
+
+	idev->name =3D lp->name;
+	idev->phys =3D lp->phys;
+	idev->id.bustype =3D BUS_I2C;
+	idev->id.vendor =3D 0x0001;
+	idev->id.product =3D 0x0001;
+	idev->id.version =3D 0x0100;
+
+	input_set_drvdata(idev, lp);
+
+	ret =3D input_register_device(idev);
+	if (ret) {
+		dev_err(&client->dev, "input_register_device() failed\n");
+		goto fail_register;
+	}
+
+	lp->laststate =3D read_state(lp);
+
+	ret =3D request_threaded_irq(client->irq, NULL, pcf8574_kp_irq_handle=
r,
+				   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+				   DRV_NAME, lp);
+	if (ret) {
+		dev_err(&client->dev, "IRQ %d is not free\n", client->irq);
+		goto fail_irq;
+	}
+
+	i2c_set_clientdata(client, lp);
+	return 0;
+
+ fail_irq:
+	input_unregister_device(idev);
+ fail_register:
+	input_set_drvdata(idev, NULL);
+	input_free_device(idev);
+ fail_allocate:
+	kfree(lp);
+
+	return ret;
+}
+
+static int __devexit pcf8574_kp_remove(struct i2c_client *client)
+{
+	struct kp_data *lp =3D i2c_get_clientdata(client);
+
+	free_irq(client->irq, lp);
+
+	input_unregister_device(lp->idev);
+	kfree(lp);
+
+	i2c_set_clientdata(client, NULL);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int pcf8574_kp_resume(struct i2c_client *client)
+{
+	enable_irq(client->irq);
+
+	return 0;
+}
+
+static int pcf8574_kp_suspend(struct i2c_client *client, pm_message_t =
mesg)
+{
+	disable_irq(client->irq);
+
+	return 0;
+}
+#else
+# define pcf8574_kp_resume  NULL
+# define pcf8574_kp_suspend NULL
+#endif
+
+static const struct i2c_device_id pcf8574_kp_id[] =3D {
+	{ DRV_NAME, 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, pcf8574_kp_id);
+
+static struct i2c_driver pcf8574_kp_driver =3D {
+	.driver =3D {
+		.name  =3D DRV_NAME,
+		.owner =3D THIS_MODULE,
+	},
+	.probe    =3D pcf8574_kp_probe,
+	.remove   =3D __devexit_p(pcf8574_kp_remove),
+	.suspend  =3D pcf8574_kp_suspend,
+	.resume   =3D pcf8574_kp_resume,
+	.id_table =3D pcf8574_kp_id,
+};
+
+static int __init pcf8574_kp_init(void)
+{
+	return i2c_add_driver(&pcf8574_kp_driver);
+}
+module_init(pcf8574_kp_init);
+
+static void __exit pcf8574_kp_exit(void)
+{
+	i2c_del_driver(&pcf8574_kp_driver);
+}
+module_exit(pcf8574_kp_exit);
+
+MODULE_AUTHOR("Michael Hennerich");
+MODULE_DESCRIPTION("Keypad input driver for 16 keys connected to PCF85=
74");
+MODULE_LICENSE("GPL");
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
