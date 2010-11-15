From: "Kim, HeungJun" <riverful.kim@samsung.com>
Subject: [PATCH 3/3] input: keyboard: MCS5080: support led blink when it's
 touched.
Date: Mon, 15 Nov 2010 13:33:30 +0900
Message-ID: <4CE0B81A.9030501@samsung.com>
Reply-To: riverful.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:59485 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757500Ab0KOEdc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 14 Nov 2010 23:33:32 -0500
Received: from epmmp2 (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LBW00CNWSNU41D0@mailout1.samsung.com> for
 linux-input@vger.kernel.org; Mon, 15 Nov 2010 13:33:30 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LBW00FAESNV0V@mmp2.samsung.com> for
 linux-input@vger.kernel.org; Mon, 15 Nov 2010 13:33:31 +0900 (KST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, kyungmin.park@samsung.com

This patch supports touchkey led blinking. The touchkey led lights
on as soon as it touched. After LED_TIME, the led lights-off.

Signed-off-by: Heungjun Kim <riverful.kim@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/input/keyboard/mcs_touchkey.c |   39 +++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/drivers/input/keyboard/mcs_touchkey.c b/drivers/input/keyboard/mcs_touchkey.c
index 931b28c..e3fd31f 100644
--- a/drivers/input/keyboard/mcs_touchkey.c
+++ b/drivers/input/keyboard/mcs_touchkey.c
@@ -19,6 +19,7 @@
 #include <linux/input.h>
 #include <linux/irq.h>
 #include <linux/slab.h>
+#include <linux/workqueue.h>

 /* MCS5000 Touchkey */
 #define MCS5000_TOUCHKEY_STATUS                0x04
@@ -32,6 +33,8 @@
 #define MCS5080_TOUCHKEY_FW            0x01
 #define MCS5080_TOUCHKEY_BASE_VAL      0x1

+#define LED_TIME                       500
+
 enum mcs_touchkey_type {
        MCS5000_TOUCHKEY,
        MCS5080_TOUCHKEY,
@@ -46,6 +49,8 @@ struct mcs_touchkey_chip {

 struct mcs_touchkey_data {
        void (*poweron)(int);
+       struct delayed_work work;
+       int suspended;

        struct i2c_client *client;
        struct input_dev *input_dev;
@@ -55,6 +60,30 @@ struct mcs_touchkey_data {
        unsigned short keycodes[];
 };

+static void mcs_touchkey_led(struct mcs_touchkey_data *data, int on)
+{
+       unsigned char buf;
+
+       if (data->suspended)
+               return;
+
+       if (on)
+               buf = 0x1;
+       else
+               buf = 0x2;
+       i2c_master_send(data->client, &buf, 1);
+}
+
+static void mcs_touchkey_work(struct work_struct *work)
+{
+       struct delayed_work *dw = to_delayed_work(work);
+       struct mcs_touchkey_data *data;
+
+       data = container_of(dw, struct mcs_touchkey_data, work);
+
+       mcs_touchkey_led(data, 0);
+}
+
 static irqreturn_t mcs_touchkey_interrupt(int irq, void *dev_id)
 {
        struct mcs_touchkey_data *data = dev_id;
@@ -89,6 +118,14 @@ static irqreturn_t mcs_touchkey_interrupt(int irq, void *dev_id)
        input_report_key(input, data->key_code, pressed);
        input_sync(input);

+       if (pressed) {
+               cancel_work_sync(&data->work.work);
+               mcs_touchkey_led(data, 1);
+       } else {
+               if (!delayed_work_pending(&data->work))
+                       schedule_delayed_work(&data->work, msecs_to_jiffies(LED_TIME));
+       }
+
        dev_dbg(&client->dev, "key %d %d %s\n", data->key_val, data->key_code,
                pressed ? "pressed" : "released");

@@ -173,6 +210,8 @@ static int __devinit mcs_touchkey_probe(struct i2c_client *client,
        if (pdata->poweron)
                data->poweron = pdata->poweron;

+       INIT_DELAYED_WORK(&data->work, mcs_touchkey_work);
+
        error = request_threaded_irq(client->irq, NULL, mcs_touchkey_interrupt,
                        IRQF_TRIGGER_FALLING, client->dev.driver->name, data);
        if (error) {
--
1.7.0.4
