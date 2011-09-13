From: Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: [PATCH 1/3] input: Add a driver TSC40 (serial)
Date: Tue, 13 Sep 2011 10:18:24 +0200
Message-ID: <CAH9NwWcYWPPShEC4tyH_VQJaNmcmaWHiApkxnKr=0HCnaqZuMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:54077 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753963Ab1IMISp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Sep 2011 04:18:45 -0400
Received: by yie30 with SMTP id 30so234550yie.19
        for <linux-input@vger.kernel.org>; Tue, 13 Sep 2011 01:18:44 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: bigeasy@linutronix.de

>From c6543087978bb24ccf04d98988f1cc5b39f8a253 Mon Sep 17 00:00:00 2001
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Wed, 7 Sep 2011 12:22:43 +0200
Subject: [PATCH 1/3] input: Add a driver TSC40 (serial)

This patch adds the TSC-40 serial touchscreen driver.
It should be compatible with TSC-10 and TSC-25.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Tested-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 drivers/input/touchscreen/Kconfig  |    7 +
 drivers/input/touchscreen/Makefile |    1 +
 drivers/input/touchscreen/tsc40.c  |  407 ++++++++++++++++++++++++++++++++++++
 include/linux/serio.h              |    1 +
 4 files changed, 416 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/touchscreen/tsc40.c

diff --git a/drivers/input/touchscreen/Kconfig
b/drivers/input/touchscreen/Kconfig
index cabd9e5..c1b6ed9 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -651,6 +651,13 @@ config TOUCHSCREEN_TOUCHIT213
         To compile this driver as a module, choose M here: the
         module will be called touchit213.

+config TOUCHSCREEN_TSC_SERIO
+       tristate "TSC-10/25/40 serial touchscreen"
+       select SERIO
+       help
+         Say Y here if you have a TSC10, 25 or 40 serial touchscreen connected
+         to your system.
+
 config TOUCHSCREEN_TSC2005
        tristate "TSC2005 based touchscreens"
        depends on SPI_MASTER && GENERIC_HARDIRQS
diff --git a/drivers/input/touchscreen/Makefile
b/drivers/input/touchscreen/Makefile
index 282d6f7..f957676 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -46,6 +46,7 @@ obj-$(CONFIG_TOUCHSCREEN_TNETV107X)   += tnetv107x-ts.o
 obj-$(CONFIG_TOUCHSCREEN_TOUCHIT213)   += touchit213.o
 obj-$(CONFIG_TOUCHSCREEN_TOUCHRIGHT)   += touchright.o
 obj-$(CONFIG_TOUCHSCREEN_TOUCHWIN)     += touchwin.o
+obj-$(CONFIG_TOUCHSCREEN_TSC_SERIO)    += tsc40.o
 obj-$(CONFIG_TOUCHSCREEN_TSC2005)      += tsc2005.o
 obj-$(CONFIG_TOUCHSCREEN_TSC2007)      += tsc2007.o
 obj-$(CONFIG_TOUCHSCREEN_UCB1400)      += ucb1400_ts.o
diff --git a/drivers/input/touchscreen/tsc40.c
b/drivers/input/touchscreen/tsc40.c
new file mode 100644
index 0000000..c9a86cd
--- /dev/null
+++ b/drivers/input/touchscreen/tsc40.c
@@ -0,0 +1,407 @@
+/*
+ * TSC-40 serial touchscreen driver. It should be compatiible with
TSC10 and 25.
+ * Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
+ * License: GPLv2 as published by the FSF.
+ */
+
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/input.h>
+#include <linux/serio.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+
+enum tsc_state {
+       STATE_GET_ID,
+       STATE_RESET_GET_ID,
+       STATE_INIT_MODE,
+       STATE_READ,
+};
+
+#define PACKET_LENGTH  5
+struct tsc_ser {
+       struct input_dev *dev;
+       struct serio *serio;
+       u32 idx;
+       enum tsc_state state;
+       struct completion cmd_done;
+       unsigned char data[PACKET_LENGTH];
+       char phys[32];
+       unsigned int eeprom;
+       ktime_t last_read;
+};
+
+#define TSC10_CMD_DATA1         0x01
+
+#define TSC10_CMD_RATE          0x05
+#define TSC10_RATE_POINT        0x50
+#define TSC10_RATE_30           0x40
+#define TSC10_RATE_50           0x41
+#define TSC10_RATE_80           0x42
+#define TSC10_RATE_100          0x43
+#define TSC10_RATE_130          0x44
+#define TSC10_RATE_150          0x45
+
+#define TSC10_CMD_ID           0x15
+#define TSC10_CMD_RESET         0x55
+
+#define RESPONSE_ACK   0x06
+#define RESPONSE_NAK   0x15
+#define NACK_DETAIL_NT (1 << 3)
+
+#define ID_EPROM_UNUSED        (1 << 7)
+
+static void handle_get_id(struct serio *serio, unsigned char data)
+{
+       struct tsc_ser *ptsc = serio_get_drvdata(serio);
+
+       ptsc->data[ptsc->idx] = data;
+       ptsc->idx++;
+
+       if (ptsc->idx < 2)
+               return;
+       if (ptsc->idx > 2) {
+               printk(KERN_ERR "too many bytes, got %x\n", data);
+               return;
+       }
+
+       if (!(ptsc->data[1] & ID_EPROM_UNUSED))
+               ptsc->eeprom = 1;
+       else
+               ptsc->eeprom = 0;
+       complete(&ptsc->cmd_done);
+}
+
+static void state_after_reset(struct tsc_ser *ptsc, int good)
+{
+       if (ptsc->state == STATE_RESET_GET_ID) {
+               ptsc->state = STATE_GET_ID;
+               return;
+       }
+
+       if (ptsc->state == STATE_INIT_MODE) {
+               if (good)
+                       ptsc->state = STATE_READ;
+               complete(&ptsc->cmd_done);
+               return;
+       }
+       printk(KERN_ERR "In state %d and got lost..\n", ptsc->state);
+}
+
+static void handle_reset(struct serio *serio, unsigned char data)
+{
+       struct tsc_ser *ptsc = serio_get_drvdata(serio);
+
+       /* NAK + EEPROM available */
+       if (ptsc->idx == 1) {
+               if (!(data & NACK_DETAIL_NT)) {
+                       state_after_reset(ptsc, 0);
+                       return;
+               }
+               state_after_reset(ptsc, 0);
+               return;
+       }
+
+       if (data == RESPONSE_ACK) {
+               state_after_reset(ptsc, 1);
+               return;
+       }
+
+       if (data == RESPONSE_NAK) {
+               if (ptsc->eeprom) {
+                       ptsc->idx = 1;
+                       /* wait fot the reason */
+                       return;
+               }
+       } else {
+               dev_err(&serio->dev, "Unknown response: 0x%x\n", data);
+       }
+       state_after_reset(ptsc, 0);
+}
+
+static void tsc_process_data(struct tsc_ser *ptsc)
+{
+       struct input_dev *dev = ptsc->dev;
+       u8 *data = ptsc->data;
+       u32 x;
+       u32 y;
+       u32 touch;
+
+       x = ((data[1] & 0x03) << 8) | data[2];
+       y = ((data[3] & 0x03) << 8) | data[4];
+       touch = data[0] & 0x01;
+
+       input_report_abs(dev, ABS_X, x);
+       input_report_abs(dev, ABS_Y, y);
+       input_report_abs(dev, ABS_PRESSURE, touch << 7);
+       input_report_key(dev, BTN_TOUCH, touch);
+
+       input_sync(dev);
+
+       ptsc->idx = 0;
+}
+
+static int pen_is_up(u8 data)
+{
+       /* SW[01] are unknown */
+       u8 val = data & 0x3f;
+       u8 up_val = 1 << 4;
+
+       return val == up_val;
+}
+
+static void handle_read(struct serio *serio, unsigned char data)
+{
+       struct tsc_ser *ptsc = serio_get_drvdata(serio);
+       struct input_dev *dev = ptsc->dev;
+
+       if (!ptsc->idx && pen_is_up(data)) {
+               input_report_key(dev, BTN_TOUCH, 0);
+               input_report_abs(dev, ABS_PRESSURE, 0);
+               input_sync(dev);
+               return;
+       }
+
+       ptsc->data[ptsc->idx] = data;
+       ptsc->idx++;
+
+       if (ptsc->idx < PACKET_LENGTH)
+               return;
+
+       tsc_process_data(ptsc);
+}
+
+static irqreturn_t tsc_interrupt(struct serio *serio,
+               unsigned char data, unsigned int flags)
+{
+       struct tsc_ser *ptsc = serio_get_drvdata(serio);
+
+       switch(ptsc->state) {
+       case STATE_GET_ID:
+               handle_get_id(serio, data);
+               break;
+
+       case STATE_RESET_GET_ID:
+       case STATE_INIT_MODE:
+               handle_reset(serio, data);
+               break;
+
+       case STATE_READ:
+               handle_read(serio, data);
+               break;
+       };
+
+       return IRQ_HANDLED;
+}
+
+static int tsc_get_id(struct serio *serio, enum tsc_state new_state)
+{
+       struct tsc_ser *ptsc = serio_get_drvdata(serio);
+       int ret;
+
+       init_completion(&ptsc->cmd_done);
+
+       ptsc->state = new_state;
+       ptsc->idx = 0;
+       ret = serio_write(serio, TSC10_CMD_ID);
+       if (ret)
+               return ret;
+
+       ret = wait_for_completion_timeout(&ptsc->cmd_done, HZ);
+       if (ret <= 0)
+               return -EINVAL;
+       return 0;
+}
+
+static int tsc_connect(struct serio *serio, struct serio_driver *drv)
+{
+       struct tsc_ser *ptsc;
+       struct input_dev *input_dev;
+       u32 mode;
+       int ret;
+
+       ptsc = kzalloc(sizeof(struct tsc_ser), GFP_KERNEL);
+       input_dev = input_allocate_device();
+       if (!ptsc || !input_dev) {
+               ret = -ENOMEM;
+               goto fail1;
+       }
+
+       ptsc->serio = serio;
+       ptsc->dev = input_dev;
+       snprintf(ptsc->phys, sizeof(ptsc->phys),
+                "%s/input0", serio->phys);
+
+       input_dev->name = "TSC-10/25/40 Serial TouchScreen";
+       input_dev->phys = ptsc->phys;
+       input_dev->id.bustype = BUS_RS232;
+       input_dev->id.vendor = SERIO_TSC40;
+       input_dev->id.product = 40;
+       input_dev->id.version = 0x0001;
+       input_dev->dev.parent = &serio->dev;
+       input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
+       input_dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
+       input_set_abs_params(ptsc->dev, ABS_X,
+                            0, 0x3ff, 0, 0);
+       input_set_abs_params(ptsc->dev, ABS_Y,
+                            0, 0x3ff, 0, 0);
+       input_set_abs_params(ptsc->dev, ABS_PRESSURE, 0, 0, 0, 0);
+       serio_set_drvdata(serio, ptsc);
+       ptsc->state = STATE_GET_ID;
+
+       ret = serio_open(serio, drv);
+       if (ret)
+               goto fail2;
+
+       ret = tsc_get_id(serio, STATE_GET_ID);
+       if (ret) {
+
+               /*
+                * So it did not repsond. Nasty litle thingy. A reset followed
+                * by ID seems to wake it up again. It responds with an ack
+                * followed by the ID.
+                */
+               ret = serio_write(serio, TSC10_CMD_RESET);
+               if (ret)
+                       goto fail3;
+
+               msleep(15);
+               ret = tsc_get_id(serio, STATE_GET_ID);
+               if (ret)
+                       goto fail3;
+
+               ret = serio_write(serio, TSC10_CMD_RESET);
+               if (ret)
+                       goto fail3;
+
+               msleep(15);
+
+               ret = tsc_get_id(serio, STATE_RESET_GET_ID);
+               if (ret)
+                       goto fail3;
+       }
+
+       mode = ptsc->data[0];
+       switch (mode) {
+               case 0x00:
+                       ptsc->state = STATE_INIT_MODE;
+                       break;
+
+               case 0x05:
+               case 0x01:
+               case 0x21:
+               case 0x31:
+               case 0x02:
+               case 0x0a:
+               case 0x2a:
+               case 0x3a:
+                       ret = serio_write(serio, TSC10_CMD_RESET);
+                       if (ret)
+                               goto fail3;
+                       msleep(16);
+                       ret = tsc_get_id(serio, STATE_GET_ID);
+                       if (ret)
+                               goto fail3;
+                       if (ptsc->data[0] == 0) {
+                               ptsc->state = STATE_INIT_MODE;
+                               break;
+                       }
+                       dev_err(&serio->dev, "Can't get into init mode
in %x\n", ptsc->data[0]);
+                       goto fail3;
+               default:
+                       dev_err(&serio->dev, "Unexpected mode: %02x\n", mode);
+                       goto fail3;
+       }
+
+       ptsc->idx = 0;
+       init_completion(&ptsc->cmd_done);
+       ret = serio_write(serio, TSC10_CMD_RATE);
+       if (ret)
+               goto fail3;
+       ret = serio_write(serio, TSC10_RATE_150);
+       if (ret)
+               goto fail3;
+
+       ret = wait_for_completion_timeout(&ptsc->cmd_done, HZ);
+       if (ret <= 0) {
+               dev_err(&serio->dev, "Mode transition failed %d\n", ret);
+               goto fail3;
+       }
+
+       ptsc->idx = 0;
+       if (ptsc->state != STATE_READ) {
+               dev_err(&serio->dev, "Touchscreen probably not attached.\n");
+               goto fail3;
+       }
+       ret = serio_write(serio, TSC10_CMD_DATA1);
+       if (ret)
+               goto fail3;
+
+       ret = input_register_device(ptsc->dev);
+       if (ret)
+               goto fail3;
+
+       return 0;
+ fail3:
+       serio_close(serio);
+ fail2:
+       serio_set_drvdata(serio, NULL);
+ fail1:
+       input_free_device(input_dev);
+       kfree(ptsc);
+       return ret;
+}
+
+static void tsc_disconnect(struct serio *serio)
+{
+       struct tsc_ser *ptsc = serio_get_drvdata(serio);
+
+       input_get_device(ptsc->dev);
+       input_unregister_device(ptsc->dev);
+       serio_close(serio);
+       serio_set_drvdata(serio, NULL);
+       input_put_device(ptsc->dev);
+       kfree(ptsc);
+}
+
+static struct serio_device_id tsc_serio_ids[] = {
+       {
+               .type   = SERIO_RS232,
+               .proto  = SERIO_TSC40,
+               .id     = SERIO_ANY,
+               .extra  = SERIO_ANY,
+       },
+       { 0 }
+};
+MODULE_DEVICE_TABLE(serio, tsc_serio_ids);
+
+#define DRIVER_DESC    "TSC-10/25/40 serial touchscreen driver"
+
+static struct serio_driver tsc_drv = {
+       .driver         = {
+               .name   = "tsc40",
+       },
+       .description    = DRIVER_DESC,
+       .id_table       = tsc_serio_ids,
+       .interrupt      = tsc_interrupt,
+       .connect        = tsc_connect,
+       .disconnect     = tsc_disconnect,
+};
+
+static int __init tsc_ser_init(void)
+{
+       return serio_register_driver(&tsc_drv);
+}
+module_init(tsc_ser_init);
+
+static void __exit tsc_exit(void)
+{
+       serio_unregister_driver(&tsc_drv);
+}
+module_exit(tsc_exit);
+
+MODULE_AUTHOR("Sebastian Andrzej Siewior <bigeasy@linutronix.de>");
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPLv2");
diff --git a/include/linux/serio.h b/include/linux/serio.h
index e26f478..be7dfb0 100644
--- a/include/linux/serio.h
+++ b/include/linux/serio.h
@@ -199,5 +199,6 @@ static inline void serio_continue_rx(struct serio *serio)
 #define SERIO_DYNAPRO  0x3a
 #define SERIO_HAMPSHIRE        0x3b
 #define SERIO_PS2MULT  0x3c
+#define SERIO_TSC40    0x3d

 #endif
--
1.7.4.1
