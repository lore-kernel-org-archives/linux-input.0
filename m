From: jcbian <jcbian@pixcir.com.cn>
Subject: [PATCH] input: add driver for pixcir i2c touchscreens
Date: Tue, 22 Feb 2011 11:17:01 +0800
Message-ID: <4D632AAD.8040405@pixcir.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail22.corpease.net ([61.145.121.75]:25702 "EHLO corpease.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751176Ab1BVD3M (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Feb 2011 22:29:12 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: =?GB2312?B?w8+1wsir?= <dqmeng@pixcir.com.cn>, =?GB2312?B?s8LV/cH6?= <zlchen@pixcir.com.cn>

This patch adds a driver for PIXCIR's I2C connected touchscreens.

Signed-off-by: Bee <jcbian@pixcir.com.cn>
---
drivers/input/touchscreen/Kconfig | 9 +
drivers/input/touchscreen/Makefile | 1 +
drivers/input/touchscreen/pixcir_i2c_ts.c | 293
+++++++++++++++++++++++++++++
3 files changed, 303 insertions(+), 0 deletions(-)
create mode 100644 drivers/input/touchscreen/pixcir_i2c_ts.c

diff --git a/drivers/input/touchscreen/Kconfig
b/drivers/input/touchscreen/Kconfig
index 61834ae..f11c1ab 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -693,4 +693,13 @@ config TOUCHSCREEN_TPS6507X
To compile this driver as a module, choose M here: the
module will be called tps6507x_ts.

+config TOUCHSCREEN_PIXCIR
+ tristate "PIXCIR touchscreen panel support"
+ depends on I2C
+ help
+ Say Y here if you have a PIXCIR based touchscreen.
+
+ To compile this driver as a module, choose M here: the
+ module will be called pixcir_i2c_ts.
+
endif
diff --git a/drivers/input/touchscreen/Makefile
b/drivers/input/touchscreen/Makefile
index 718bcc8..4513668 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -57,3 +57,4 @@ obj-$(CONFIG_TOUCHSCREEN_WM97XX_MAINSTONE) +=
mainstone-wm97xx.o
obj-$(CONFIG_TOUCHSCREEN_WM97XX_ZYLONITE) += zylonite-wm97xx.o
obj-$(CONFIG_TOUCHSCREEN_W90X900) += w90p910_ts.o
obj-$(CONFIG_TOUCHSCREEN_TPS6507X) += tps6507x-ts.o
+obj-$(CONFIG_TOUCHSCREEN_PIXCIR) += pixcir_i2c_ts.o
diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c
b/drivers/input/touchscreen/pixcir_i2c_ts.c
new file mode 100644
index 0000000..e3fbeb0
--- /dev/null
+++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
@@ -0,0 +1,293 @@
+/* drivers/input/touchscreen/pixcir_i2c_ts.c
+ *
+ * Copyright (C) 2010-2011 Pixcir, Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/slab.h>
+#include <linux/input.h>
+#include <linux/i2c.h>
+#include <linux/gpio.h>
+
+#define DRIVER_VERSION "v1.0"
+#define DRIVER_AUTHOR
"Bee<jcbian@pixcir.com.cn>,Reed<dqmeng@pixcir.com.cn>"
+#define DRIVER_DESC "Pixcir I2C Touchscreen Driver"
+#define DRIVER_LICENSE "GPL"
+
+/* todo:check specs for resolution of touch screen */
+#define TOUCHSCREEN_MINX 0
+#define TOUCHSCREEN_MAXX 400
+#define TOUCHSCREEN_MINY 0
+#define TOUCHSCREEN_MAXY 600
+
+#define DEBUG 0
+
+static struct workqueue_struct *pixcir_wq;
+
+struct pixcir_i2c_ts_data {
+ struct i2c_client *client;
+ struct input_dev *input;
+ struct delayed_work work;
+ int irq;
+};
+
+static void pixcir_ts_poscheck(struct work_struct *work)
+{
+ struct pixcir_i2c_ts_data *tsdata = container_of(work,
+ struct pixcir_i2c_ts_data,
+ work.work);
+
+ unsigned char touching, oldtouching;
+ int posx1, posy1, posx2, posy2;
+ u_int8_t Rdbuf[10], Wrbuf[1];
+ int ret;
+ int z = 50;
+ int w = 15;
+
+ memset(Wrbuf, 0, sizeof(Wrbuf));
+ memset(Rdbuf, 0, sizeof(Rdbuf));
+
+ Wrbuf[0] = 0;
+ ret = i2c_master_send(tsdata->client, Wrbuf, 1);
+ if (ret != 1) {
+ dev_err(&tsdata->client->dev, "Unable to write to i2c touchscreen!\n");
+ goto out;
+ }
+
+ ret = i2c_master_recv(tsdata->client, Rdbuf, sizeof(Rdbuf));
+ if (ret != sizeof(Rdbuf)) {
+ dev_err(&tsdata->client->dev, "Unable to read i2c page!\n");
+ goto out;
+ }
+
+ touching = Rdbuf[0];
+ oldtouching = Rdbuf[1];
+ posx1 = ((Rdbuf[3] << 8) | Rdbuf[2]);
+ posy1 = ((Rdbuf[5] << 8) | Rdbuf[4]);
+ posx2 = ((Rdbuf[7] << 8) | Rdbuf[6]);
+ posy2 = ((Rdbuf[9] << 8) | Rdbuf[8]);
+
+ input_report_key(tsdata->input, BTN_TOUCH, (touching != 0 ? 1 : 0));
+
+ if (touching == 1) {
+ input_report_abs(tsdata->input, ABS_X, posx1);
+ input_report_abs(tsdata->input, ABS_Y, posy1);
+ }
+
+ if (!(touching)) {
+ z = 0;
+ w = 0;
+ }
+ if (touching == 2) {
+ input_report_abs(tsdata->input, ABS_MT_TOUCH_MAJOR, z);
+ input_report_abs(tsdata->input, ABS_MT_WIDTH_MAJOR, w);
+ input_report_abs(tsdata->input, ABS_MT_POSITION_X, posx1);
+ input_report_abs(tsdata->input, ABS_MT_POSITION_Y, posy1);
+ input_mt_sync(tsdata->input);
+
+ input_report_abs(tsdata->input, ABS_MT_TOUCH_MAJOR, z);
+ input_report_abs(tsdata->input, ABS_MT_WIDTH_MAJOR, w);
+ input_report_abs(tsdata->input, ABS_MT_POSITION_X, posx2);
+ input_report_abs(tsdata->input, ABS_MT_POSITION_Y, posy2);
+ input_mt_sync(tsdata->input);
+ }
+ input_sync(tsdata->input);
+
+out:
+ enable_irq(tsdata->irq);
+}
+
+static irqreturn_t pixcir_ts_isr(int irq, void *dev_id)
+{
+ struct pixcir_i2c_ts_data *tsdata = dev_id;
+ disable_irq_nosync(irq);
+
+ queue_work(pixcir_wq, &tsdata->work.work);
+
+ return IRQ_HANDLED;
+}
+
+static int pixcir_ts_open(struct input_dev *dev)
+{
+ return 0;
+}
+
+static void pixcir_ts_close(struct input_dev *dev)
+{
+
+}
+
+static int pixcir_i2c_ts_probe(struct i2c_client *client,
+ const struct i2c_device_id *id)
+{
+ struct pixcir_i2c_ts_data *tsdata;
+ struct input_dev *input;
+ int error;
+
+ #ifdef DEBUG
+ printk(KERN_EMERG "pixcir_i2c_ts probe!\n");
+ #endif
+
+ tsdata = kzalloc(sizeof(*tsdata), GFP_KERNEL);
+ if (!tsdata) {
+ dev_err(&client->dev, "Failed to allocate driver data!\n");
+ error = -ENOMEM;
+ dev_set_drvdata(&client->dev, NULL);
+ return error;
+ }
+
+ dev_set_drvdata(&client->dev, tsdata);
+
+ input = input_allocate_device();
+ if (!input) {
+ dev_err(&client->dev, "Failed to allocate input device!\n");
+ error = -ENOMEM;
+ input_free_device(input);
+ kfree(tsdata);
+ }
+
+ set_bit(EV_SYN, input->evbit);
+ set_bit(EV_KEY, input->evbit);
+ set_bit(EV_ABS, input->evbit);
+ set_bit(BTN_TOUCH, input->keybit);
+ input_set_abs_params(input, ABS_X,
+ TOUCHSCREEN_MINX, TOUCHSCREEN_MAXX, 0, 0);
+ input_set_abs_params(input, ABS_Y,
+ TOUCHSCREEN_MINY, TOUCHSCREEN_MAXY, 0, 0);
+ input_set_abs_params(input, ABS_MT_POSITION_X,
+ TOUCHSCREEN_MINX, TOUCHSCREEN_MAXX, 0, 0);
+ input_set_abs_params(input, ABS_MT_POSITION_Y,
+ TOUCHSCREEN_MINY, TOUCHSCREEN_MAXY, 0, 0);
+ input_set_abs_params(input, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
+ input_set_abs_params(input, ABS_MT_WIDTH_MAJOR, 0, 25, 0, 0);
+
+ input->name = client->name;
+ input->id.bustype = BUS_I2C;
+ input->dev.parent = &client->dev;
+
+ input->open = pixcir_ts_open;
+ input->close = pixcir_ts_close;
+
+ input_set_drvdata(input, tsdata);
+
+ tsdata->client = client;
+ tsdata->input = input;
+
+ INIT_WORK(&tsdata->work.work, pixcir_ts_poscheck);
+
+ tsdata->irq = client->irq;
+
+ if (input_register_device(input)) {
+ input_free_device(input);
+ kfree(tsdata);
+ }
+
+ if (request_irq(tsdata->irq, pixcir_ts_isr,
+ IRQF_TRIGGER_LOW, client->name, tsdata)) {
+ dev_err(&client->dev, "Unable to request touchscreen IRQ.\n");
+ input_unregister_device(input);
+ input = NULL;
+ }
+
+ device_init_wakeup(&client->dev, 1);
+
+ dev_err(&tsdata->client->dev, "insmod successfully!\n");
+
+ return 0;
+}
+
+static int pixcir_i2c_ts_remove(struct i2c_client *client)
+{
+ struct pixcir_i2c_ts_data *tsdata = dev_get_drvdata(&client->dev);
+ free_irq(tsdata->irq, tsdata);
+ input_unregister_device(tsdata->input);
+ kfree(tsdata);
+ dev_set_drvdata(&client->dev, NULL);
+ return 0;
+}
+
+#ifdef CONFIG_PM
+static int pixcir_i2c_ts_suspend(struct i2c_client *client,
pm_message_t mesg)
+{
+ struct pixcir_i2c_ts_data *tsdata = dev_get_drvdata(&client->dev);
+
+ if (device_may_wakeup(&client->dev))
+ enable_irq_wake(tsdata->irq);
+
+ return 0;
+}
+
+static int pixcir_i2c_ts_resume(struct i2c_client *client)
+{
+ struct pixcir_i2c_ts_data *tsdata = dev_get_drvdata(&client->dev);
+
+ if (device_may_wakeup(&client->dev))
+ disable_irq_wake(tsdata->irq);
+
+ return 0;
+}
+#else
+#define pixcir_i2c_ts_suspend NULL
+#define pixcir_i2c_ts_resume NULL
+#endif
+
+static const struct i2c_device_id pixcir_i2c_ts_id[] = {
+ { "pixcir_ts", 0 },
+ { }
+};
+MODULE_DEVICE_TABLE(i2c, pixcir_i2c_ts_id);
+
+static struct i2c_driver pixcir_i2c_ts_driver = {
+ .driver = {
+ .owner = THIS_MODULE,
+ .name = "pixcir_ts",
+ },
+ .probe = pixcir_i2c_ts_probe,
+ .remove = pixcir_i2c_ts_remove,
+ .suspend = pixcir_i2c_ts_suspend,
+ .resume = pixcir_i2c_ts_resume,
+ .id_table = pixcir_i2c_ts_id,
+};
+
+static int __init pixcir_i2c_ts_init(void)
+{
+ #ifdef DEBUG
+ printk(KERN_EMERG "pixcir_i2c_init\n");
+ #endif
+
+ pixcir_wq = create_singlethread_workqueue("pixcir_wq");
+ if (!pixcir_wq)
+ return -ENOMEM;
+ return i2c_add_driver(&pixcir_i2c_ts_driver);
+}
+
+static void __exit pixcir_i2c_ts_exit(void)
+{
+ #ifdef DEBUG
+ printk(KERN_EMERG "pixcir_i2c_exit\n");
+ #endif
+
+ i2c_del_driver(&pixcir_i2c_ts_driver);
+ if (pixcir_wq)
+ destroy_workqueue(pixcir_wq);
+}
+
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE(DRIVER_LICENSE);
+
+module_init(pixcir_i2c_ts_init);
+module_exit(pixcir_i2c_ts_exit);
-- 
1.7.0.4



