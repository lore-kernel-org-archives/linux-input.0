From: Kmarty <gkmarty@gmail.com>
Subject: [PATCH 1/2] driver for Zhen Hua PCM-4CH RC transmitter
Date: Wed, 13 Feb 2008 16:23:26 +0100
Message-ID: <5fecb1300802130723n77c940f5r895c060c944e7bb2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:57905 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753135AbYBMPXa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Feb 2008 10:23:30 -0500
Received: by ug-out-1314.google.com with SMTP id z38so768061ugc.16
        for <linux-input@vger.kernel.org>; Wed, 13 Feb 2008 07:23:28 -0800 (PST)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dtor@mail.ru
Cc: linux-input@vger.kernel.org

Hi,
this is a driver for Zhen Hua PCM-4CH RC transmitter (commonly used in
cheap Ready To Fly RC helicopters) which using "Zhen Hua 5-byte
protocol" for using them as a four axis joystick via serial port.

Transmitter connected to serial port (19200 8N1) sending periodically
5 bytes where first byte is for synchronization and next four bytes
are values of axis.

Signed-off-by: Martin Kebert <gkmarty@gmail.com>
---
 drivers/input/joystick/Kconfig   |   12 +
 drivers/input/joystick/Makefile  |    1
 drivers/input/joystick/zhenhua.c |  243 +++++++++++++++++++++++++++++++++++++++
 include/linux/serio.h            |    1
 4 files changed, 257 insertions(+)

diff -uprN -X linux-2.6.24-vanilla/Documentation/dontdiff
linux-2.6.24-vanilla/drivers/input/joystick/Kconfig
linux-2.6.24-zhenhua/drivers/input/joystick/Kconfig
--- linux-2.6.24-vanilla/drivers/input/joystick/Kconfig 2008-01-24
23:58:37.000000000 +0100
+++ linux-2.6.24-zhenhua/drivers/input/joystick/Kconfig 2008-02-08
22:48:34.000000000 +0100
@@ -193,6 +193,18 @@ config JOYSTICK_TWIDJOY
          To compile this driver as a module, choose M here: the
          module will be called twidjoy.

+config JOYSTICK_ZHENHUA
+       tristate "5-byte Zhenhua RC transmitter"
+       select SERIO
+       help
+         Say Y here if you have a Zhen Hua PCM-4CH transmitter which is
+         supplied with a ready to fly micro electric indoor helicopters
+         such as EasyCopter, Lama, MiniCopter, DragonFly or Jabo and want
+         to use it via serial cable as a joystick.
+
+         To compile this driver as a module, choose M here: the
+         module will be called zhenhua.
+
 config JOYSTICK_DB9
        tristate "Multisystem, Sega Genesis, Saturn joysticks and gamepads"
        depends on PARPORT
diff -uprN -X linux-2.6.24-vanilla/Documentation/dontdiff
linux-2.6.24-vanilla/drivers/input/joystick/Makefile
linux-2.6.24-zhenhua/drivers/input/joystick/Makefile
--- linux-2.6.24-vanilla/drivers/input/joystick/Makefile
2008-01-24 23:58:37.000000000 +0100
+++ linux-2.6.24-zhenhua/drivers/input/joystick/Makefile
2008-02-08 19:45:36.000000000 +0100
@@ -27,5 +27,6 @@ obj-$(CONFIG_JOYSTICK_TURBOGRAFX)     += tur
 obj-$(CONFIG_JOYSTICK_TWIDJOY)         += twidjoy.o
 obj-$(CONFIG_JOYSTICK_WARRIOR)         += warrior.o
 obj-$(CONFIG_JOYSTICK_XPAD)            += xpad.o
+obj-$(CONFIG_JOYSTICK_ZHENHUA)         += zhenhua.o

 obj-$(CONFIG_JOYSTICK_IFORCE)          += iforce/
diff -uprN -X linux-2.6.24-vanilla/Documentation/dontdiff
linux-2.6.24-vanilla/drivers/input/joystick/zhenhua.c
linux-2.6.24-zhenhua/drivers/input/joystick/zhenhua.c
--- linux-2.6.24-vanilla/drivers/input/joystick/zhenhua.c
1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.24-zhenhua/drivers/input/joystick/zhenhua.c
2008-02-08 19:27:40.000000000 +0100
@@ -0,0 +1,243 @@
+/*
+ *  derived from "twidjoy.c"
+ *
+ *  Copyright (c) 2008 Martin Kebert
+ *  Copyright (c) 2001 Arndt Schoenewald
+ *  Copyright (c) 2000-2001 Vojtech Pavlik
+ *  Copyright (c) 2000 Mark Fletcher
+ *
+ */
+
+/*
+ * Driver to use 4CH RC transmitter using Zhen Hua 5-byte protocol
(Walkera Lama,
+ * EasyCopter etc.) as a joystick under Linux.
+ *
+ * RC transmitters using Zhen Hua 5-byte protocol are cheap four channels
+ * transmitters for control a RC planes or RC helicopters with possibility to
+ * connect on a serial port.
+ * Data coming from transmitter is in this order:
+ * 1. byte = synchronisation byte
+ * 2. byte = X axis
+ * 3. byte = Y axis
+ * 4. byte = RZ axis
+ * 5. byte = Z axis
+ * (and this is repeated)
+ *
+ * For questions or feedback regarding this driver module please contact:
+ * Martin Kebert <gkmarty@gmail.com> - but I am not a C-programmer nor kernel
+ * coder :-(
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/input.h>
+#include <linux/serio.h>
+#include <linux/init.h>
+
+#define DRIVER_DESC    "RC transmitter with 5-byte Zhen Hua protocol
joystick driver"
+
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
+
+/*
+ * Constants.
+ */
+
+#define ZHENHUA_MAX_LENGTH 5
+
+/*
+ * Zhen Hua data.
+ */
+
+struct zhenhua {
+       struct input_dev *dev;
+       int idx;
+       unsigned char data[ZHENHUA_MAX_LENGTH];
+       char phys[32];
+};
+
+
+/* bits in all incoming bytes needs to be "reversed" */
+static int zhenhua_bitreverse(int x)
+{
+       x = ((x & 0xaa) >> 1) | ((x & 0x55) << 1);
+       x = ((x & 0xcc) >> 2) | ((x & 0x33) << 2);
+       x = ((x & 0xf0) >> 4) | ((x & 0x0f) << 4);
+       return x;
+}
+
+/*
+ * zhenhua_process_packet() decodes packets the driver receives from the
+ * RC transmitter. It updates the data accordingly.
+ */
+
+static void zhenhua_process_packet(struct zhenhua *zhenhua)
+{
+       struct input_dev *dev = zhenhua->dev;
+       unsigned char *data = zhenhua->data;
+
+       input_report_abs(dev, ABS_Y, data[1]);
+       input_report_abs(dev, ABS_X, data[2]);
+       input_report_abs(dev, ABS_RZ, data[3]);
+       input_report_abs(dev, ABS_Z, data[4]);
+
+       input_sync(dev);
+}
+
+/*
+ * zhenhua_interrupt() is called by the low level driver when characters
+ * are ready for us. We then buffer them for further processing, or call the
+ * packet processing routine.
+ */
+
+static irqreturn_t zhenhua_interrupt(struct serio *serio, unsigned
char data, unsigned int flags)
+{
+       struct zhenhua *zhenhua = serio_get_drvdata(serio);
+
+       /* All Zhen Hua packets are 5 bytes. The fact that the first byte
+        * is allways 0xf7 and all others are in range 0x32 - 0xc8 (50-200)
+        * can be used to check and regain sync. */
+
+       if (data == 0xef)
+               zhenhua->idx = 0;       /* this byte starts a new packet */
+       else if (zhenhua->idx == 0)
+               return IRQ_HANDLED;     /* wrong MSB -- ignore this byte */
+
+       if (zhenhua->idx < ZHENHUA_MAX_LENGTH)
+               zhenhua->data[zhenhua->idx++] = zhenhua_bitreverse(data);
+
+       if (zhenhua->idx == ZHENHUA_MAX_LENGTH) {
+               zhenhua_process_packet(zhenhua);
+               zhenhua->idx = 0;
+       }
+
+       return IRQ_HANDLED;
+}
+
+/*
+ * zhenhua_disconnect() is the opposite of zhenhua_connect()
+ */
+
+static void zhenhua_disconnect(struct serio *serio)
+{
+       struct zhenhua *zhenhua = serio_get_drvdata(serio);
+
+       serio_close(serio);
+       serio_set_drvdata(serio, NULL);
+       input_unregister_device(zhenhua->dev);
+       kfree(zhenhua);
+}
+
+/*
+ * zhenhua_connect() is the routine that is called when someone adds a
+ * new serio device. It looks for the Twiddler, and if found, registers
+ * it as an input device.
+ */
+
+static int zhenhua_connect(struct serio *serio, struct serio_driver *drv)
+{
+       struct zhenhua *zhenhua;
+       struct input_dev *input_dev;
+       int err = -ENOMEM;
+
+       zhenhua = kzalloc(sizeof(struct zhenhua), GFP_KERNEL);
+       input_dev = input_allocate_device();
+       if (!zhenhua || !input_dev)
+               goto fail1;
+
+       zhenhua->dev = input_dev;
+       snprintf(zhenhua->phys, sizeof(zhenhua->phys), "%s/input0",
serio->phys);
+
+       input_dev->name = "Zhen Hua 5-byte device";
+       input_dev->phys = zhenhua->phys;
+       input_dev->id.bustype = BUS_RS232;
+       input_dev->id.vendor = SERIO_ZHENHUA;
+       input_dev->id.product = 0x0001;
+       input_dev->id.version = 0x0100;
+       input_dev->dev.parent = &serio->dev;
+
+       input_dev->evbit[0] = BIT(EV_ABS);
+       input_set_abs_params(input_dev, ABS_X, 50, 200, 0, 0);
+       input_set_abs_params(input_dev, ABS_Y, 50, 200, 0, 0);
+       input_set_abs_params(input_dev, ABS_Z, 50, 200, 0, 0);
+       input_set_abs_params(input_dev, ABS_RZ, 50, 200, 0, 0);
+
+       serio_set_drvdata(serio, zhenhua);
+
+       err = serio_open(serio, drv);
+       if (err)
+               goto fail2;
+
+       err = input_register_device(zhenhua->dev);
+       if (err)
+               goto fail3;
+
+       return 0;
+
+ fail3:        serio_close(serio);
+ fail2:        serio_set_drvdata(serio, NULL);
+ fail1:        input_free_device(input_dev);
+       kfree(zhenhua);
+       return err;
+}
+
+/*
+ * The serio driver structure.
+ */
+
+static struct serio_device_id zhenhua_serio_ids[] = {
+       {
+               .type   = SERIO_RS232,
+               .proto  = SERIO_ZHENHUA,
+               .id     = SERIO_ANY,
+               .extra  = SERIO_ANY,
+       },
+       { 0 }
+};
+
+MODULE_DEVICE_TABLE(serio, zhenhua_serio_ids);
+
+static struct serio_driver zhenhua_drv = {
+       .driver         = {
+               .name   = "zhenhua",
+       },
+       .description    = DRIVER_DESC,
+       .id_table       = zhenhua_serio_ids,
+       .interrupt      = zhenhua_interrupt,
+       .connect        = zhenhua_connect,
+       .disconnect     = zhenhua_disconnect,
+};
+
+/*
+ * The functions for inserting/removing us as a module.
+ */
+
+static int __init zhenhua_init(void)
+{
+       return serio_register_driver(&zhenhua_drv);
+}
+
+static void __exit zhenhua_exit(void)
+{
+       serio_unregister_driver(&zhenhua_drv);
+}
+
+module_init(zhenhua_init);
+module_exit(zhenhua_exit);
diff -uprN -X linux-2.6.24-vanilla/Documentation/dontdiff
linux-2.6.24-vanilla/include/linux/serio.h
linux-2.6.24-zhenhua/include/linux/serio.h
--- linux-2.6.24-vanilla/include/linux/serio.h  2008-01-24
23:58:37.000000000 +0100
+++ linux-2.6.24-zhenhua/include/linux/serio.h  2008-02-08
19:49:27.000000000 +0100
@@ -211,5 +211,6 @@ static inline void serio_unpin_driver(st
 #define SERIO_TOUCHWIN 0x33
 #define SERIO_TAOSEVM  0x34
 #define SERIO_FUJITSU  0x35
+#define SERIO_ZHENHUA  0x36

 #endif
