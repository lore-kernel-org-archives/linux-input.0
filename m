From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: [RFC 2.6.27 3/5] Add support for Wacom W8001 penabled serial touchscreen
Date: Tue,  4 Nov 2008 08:55:11 +0800
Message-ID: <12257601373276-git-send-email-jayakumar.lkml@gmail.com>
References: <12257601131298-git-send-email-jayakumar.lkml@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.238]:54998 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754025AbYKDAzo (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Nov 2008 19:55:44 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2922566rvb.1
        for <linux-input@vger.kernel.org>; Mon, 03 Nov 2008 16:55:44 -0800 (PST)
In-Reply-To: <12257601131298-git-send-email-jayakumar.lkml@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-input@vger.kernel.org, Jaya Kumar <jayakumar.lkml@gmail.com>

The Wacom W8001 sensor is a sensor device (uses electromagnetic resonance)
and it is interfaced via its serial microcontroller to the host.

Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>
---
 drivers/input/touchscreen/Kconfig       |   13 ++
 drivers/input/touchscreen/Makefile      |    1 +
 drivers/input/touchscreen/wacom_w8001.c |  325 +++++++++++++++++++++++++++++++
 include/linux/serio.h                   |    1 +
 4 files changed, 340 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/touchscreen/wacom_w8001.c

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 6e1e8c6..239c4f6 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -91,6 +91,19 @@ config TOUCHSCREEN_ELO
 	  To compile this driver as a module, choose M here: the
 	  module will be called elo.
 
+config TOUCHSCREEN_WACOM_W8001
+	tristate "Wacom W8001 penabled serial touchscreen"
+	select SERIO
+	help
+	  Say Y here if you have an Wacom W8001 penabled serial touchscreen
+	  connected to your system.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called wacom_w8001.
+
+
 config TOUCHSCREEN_MTOUCH
 	tristate "MicroTouch serial touchscreens"
 	select SERIO
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 15cf290..3dc84d3 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_TOUCHSCREEN_TOUCHIT213)	+= touchit213.o
 obj-$(CONFIG_TOUCHSCREEN_TOUCHRIGHT)	+= touchright.o
 obj-$(CONFIG_TOUCHSCREEN_TOUCHWIN)	+= touchwin.o
 obj-$(CONFIG_TOUCHSCREEN_UCB1400)	+= ucb1400_ts.o
+obj-$(CONFIG_TOUCHSCREEN_WACOM_W8001)	+= wacom_w8001.o
 obj-$(CONFIG_TOUCHSCREEN_WM97XX)	+= wm97xx-ts.o
 wm97xx-ts-$(CONFIG_TOUCHSCREEN_WM9705)	+= wm9705.o
 wm97xx-ts-$(CONFIG_TOUCHSCREEN_WM9712)	+= wm9712.o
diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touchscreen/wacom_w8001.c
new file mode 100644
index 0000000..2f33a01
--- /dev/null
+++ b/drivers/input/touchscreen/wacom_w8001.c
@@ -0,0 +1,325 @@
+/*
+ * Wacom W8001 penabled serial touchscreen driver
+ *
+ * Copyright (c) 2008 Jaya Kumar
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License. See the file COPYING in the main directory of this archive for
+ * more details.
+ *
+ * Layout based on Elo serial touchscreen driver by Vojtech Pavlik
+ */
+
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/input.h>
+#include <linux/serio.h>
+#include <linux/init.h>
+#include <linux/ctype.h>
+
+#define DRIVER_DESC	"Wacom W8001 serial touchscreen driver"
+
+MODULE_AUTHOR("Jaya Kumar <jayakumar.lkml@gmail.com>");
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
+
+/*
+ * Definitions & global arrays.
+ */
+
+#define W8001_MAX_LENGTH	11
+#define W8001_PACKET_LEN	11
+#define W8001_LEAD_MASK 0x80
+#define W8001_LEAD_BYTE 0x80
+#define W8001_TAB_MASK 0x40
+#define W8001_TAB_BYTE 0x40
+
+#define W8001_QUERY_PACKET 0x20
+
+struct w8001_coord {
+	u8 rdy;
+	u8 tsw;
+	u8 f1;
+	u8 f2;
+	u16 x;
+	u16 y;
+	u16 pen_pressure;
+	u8 tilt_x;
+	u8 tilt_y;
+};
+
+/*
+ * Per-touchscreen data.
+ */
+
+struct w8001 {
+	struct input_dev *dev;
+	struct serio *serio;
+	struct mutex cmd_mutex;
+	struct completion cmd_done;
+	int id;
+	int idx;
+	unsigned char expected_packet;
+	unsigned char data[W8001_MAX_LENGTH];
+	unsigned char response[W8001_PACKET_LEN];
+	char phys[32];
+};
+
+static int parse_data(u8 *data, struct w8001_coord *coord)
+{
+	coord->rdy = data[0] & 0x20;
+	coord->tsw = data[0] & 0x01;
+	coord->f1 = data[0] & 0x02;
+	coord->f2 = data[0] & 0x04;
+
+	coord->x = (data[1] & 0x7F) << 9;
+	coord->x |= (data[2] & 0x7F) << 2;
+	coord->x |= (data[6] & 0x60) >> 5;
+
+	coord->y = (data[3] & 0x7F) << 9;
+	coord->y |= (data[4] & 0x7F) << 2;
+	coord->y |= (data[6] & 0x18) >> 3;
+
+	coord->pen_pressure = data[5] & 0x7F;
+	coord->pen_pressure |= (data[6] & 0x07) << 7 ;
+
+	coord->tilt_x = data[7] & 0x7F;
+	coord->tilt_y = data[8] & 0x7F;
+
+	return 0;
+}
+
+static void w8001_process_data(struct w8001 *w8001, unsigned char data)
+{
+	struct input_dev *dev = w8001->dev;
+	u8 tmp;
+	struct w8001_coord coord;
+
+	w8001->data[w8001->idx] = data;
+	switch (w8001->idx++) {
+	case 0:
+		if ((data & W8001_LEAD_MASK) != W8001_LEAD_BYTE) {
+			pr_debug("w8001: unsynchronized data: 0x%02x\n", data);
+			w8001->idx = 0;
+		}
+		break;
+	case 8:
+		tmp = w8001->data[0] & W8001_TAB_MASK;
+		if (unlikely(tmp == W8001_TAB_BYTE))
+			break;
+		w8001->idx = 0;
+		memset(&coord, 0, sizeof(coord));
+		parse_data(w8001->data, &coord);
+		input_report_abs(dev, ABS_X, coord.x);
+		input_report_abs(dev, ABS_Y, coord.y);
+		input_report_abs(dev, ABS_PRESSURE, coord.pen_pressure);
+		input_report_key(dev, BTN_TOUCH, coord.tsw);
+		input_sync(dev);
+		break;
+	case 10:
+		w8001->idx = 0;
+		memcpy(w8001->response, &w8001->data, W8001_PACKET_LEN);
+		w8001->expected_packet = W8001_QUERY_PACKET;
+		complete(&w8001->cmd_done);
+		break;
+	}
+}
+
+
+static irqreturn_t w8001_interrupt(struct serio *serio,
+		unsigned char data, unsigned int flags)
+{
+	struct w8001 *w8001 = serio_get_drvdata(serio);
+
+	w8001_process_data(w8001, data);
+
+	return IRQ_HANDLED;
+}
+
+static int w8001_async_command(struct w8001 *w8001, unsigned char *packet,
+					int len)
+{
+	int rc = -1;
+	int i;
+
+	mutex_lock(&w8001->cmd_mutex);
+
+	for (i = 0; i < len; i++) {
+		if (serio_write(w8001->serio, packet[i]))
+			goto out;
+	}
+	rc = 0;
+
+out:
+	mutex_unlock(&w8001->cmd_mutex);
+	return rc;
+}
+
+static int w8001_command(struct w8001 *w8001, unsigned char *packet, int len)
+{
+	int rc = -1;
+	int i;
+
+	mutex_lock(&w8001->cmd_mutex);
+
+	serio_pause_rx(w8001->serio);
+	init_completion(&w8001->cmd_done);
+	serio_continue_rx(w8001->serio);
+
+	for (i = 0; i < len; i++) {
+		if (serio_write(w8001->serio, packet[i]))
+			goto out;
+	}
+
+	wait_for_completion_timeout(&w8001->cmd_done, HZ);
+
+	if (w8001->expected_packet == W8001_QUERY_PACKET) {
+		/* We are back in reporting mode, the query was ACKed */
+		memcpy(packet, w8001->response, W8001_PACKET_LEN);
+		rc = 0;
+	}
+
+out:
+	mutex_unlock(&w8001->cmd_mutex);
+	return rc;
+}
+
+static int w8001_setup(struct w8001 *w8001)
+{
+	struct w8001_coord coord;
+	struct input_dev *dev = w8001->dev;
+	unsigned char start[1] = { '1' };
+	unsigned char query[11] = { '*' };
+
+	if (w8001_command(w8001, query, 1))
+		return -1;
+
+	memset(&coord, 0, sizeof(coord));
+	parse_data(query, &coord);
+
+	input_set_abs_params(dev, ABS_X, 0, coord.x, 0, 0);
+	input_set_abs_params(dev, ABS_Y, 0, coord.y, 0, 0);
+	input_set_abs_params(dev, ABS_PRESSURE, 0, coord.pen_pressure, 0, 0);
+	input_set_abs_params(dev, ABS_TILT_X, 0, coord.tilt_x, 0, 0);
+	input_set_abs_params(dev, ABS_TILT_Y, 0, coord.tilt_y, 0, 0);
+
+	if (w8001_async_command(w8001, start, 1))
+		return -1;
+
+	return 0;
+}
+
+/*
+ * w8001_disconnect() is the opposite of w8001_connect()
+ */
+
+static void w8001_disconnect(struct serio *serio)
+{
+	struct w8001 *w8001 = serio_get_drvdata(serio);
+
+	input_get_device(w8001->dev);
+	input_unregister_device(w8001->dev);
+	serio_close(serio);
+	serio_set_drvdata(serio, NULL);
+	input_put_device(w8001->dev);
+	kfree(w8001);
+}
+
+/*
+ * w8001_connect() is the routine that is called when someone adds a
+ * new serio device that supports the w8001 protocol and registers it as
+ * an input device.
+ */
+
+static int w8001_connect(struct serio *serio, struct serio_driver *drv)
+{
+	struct w8001 *w8001;
+	struct input_dev *input_dev;
+	int err;
+
+	w8001 = kzalloc(sizeof(struct w8001), GFP_KERNEL);
+	input_dev = input_allocate_device();
+	if (!w8001 || !input_dev) {
+		err = -ENOMEM;
+		goto fail1;
+	}
+
+	w8001->serio = serio;
+	w8001->id = serio->id.id;
+	w8001->dev = input_dev;
+	mutex_init(&w8001->cmd_mutex);
+	init_completion(&w8001->cmd_done);
+	snprintf(w8001->phys, sizeof(w8001->phys), "%s/input0", serio->phys);
+
+	input_dev->name = "Wacom W8001 Penabled Serial TouchScreen";
+	input_dev->phys = w8001->phys;
+	input_dev->id.bustype = BUS_RS232;
+	input_dev->id.vendor = SERIO_W8001;
+	input_dev->id.product = w8001->id;
+	input_dev->id.version = 0x0100;
+	input_dev->dev.parent = &serio->dev;
+
+	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
+	input_dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
+
+	serio_set_drvdata(serio, w8001);
+	err = serio_open(serio, drv);
+	if (err)
+		goto fail2;
+
+	if (w8001_setup(w8001))
+		goto fail3;
+
+	err = input_register_device(w8001->dev);
+	if (err)
+		goto fail3;
+
+	return 0;
+
+fail3:
+	serio_close(serio);
+fail2:
+	serio_set_drvdata(serio, NULL);
+fail1:
+	input_free_device(input_dev);
+	kfree(w8001);
+	return err;
+}
+
+static struct serio_device_id w8001_serio_ids[] = {
+	{
+		.type	= SERIO_RS232,
+		.proto	= SERIO_W8001,
+		.id	= SERIO_ANY,
+		.extra	= SERIO_ANY,
+	},
+	{ 0 }
+};
+
+MODULE_DEVICE_TABLE(serio, w8001_serio_ids);
+
+static struct serio_driver w8001_drv = {
+	.driver		= {
+		.name	= "w8001",
+	},
+	.description	= DRIVER_DESC,
+	.id_table	= w8001_serio_ids,
+	.interrupt	= w8001_interrupt,
+	.connect	= w8001_connect,
+	.disconnect	= w8001_disconnect,
+};
+
+static int __init w8001_init(void)
+{
+	return serio_register_driver(&w8001_drv);
+}
+
+static void __exit w8001_exit(void)
+{
+	serio_unregister_driver(&w8001_drv);
+}
+
+module_init(w8001_init);
+module_exit(w8001_exit);
diff --git a/include/linux/serio.h b/include/linux/serio.h
index 25641d9..1bcb357 100644
--- a/include/linux/serio.h
+++ b/include/linux/serio.h
@@ -213,5 +213,6 @@ static inline void serio_unpin_driver(struct serio *serio)
 #define SERIO_ZHENHUA	0x36
 #define SERIO_INEXIO	0x37
 #define SERIO_TOUCHIT213	0x37
+#define SERIO_W8001	0x39
 
 #endif
-- 
1.5.2.3

