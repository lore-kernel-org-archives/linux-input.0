From: "Kim, HeungJun" <riverful.kim@samsung.com>
Subject: [PATCH 1/3] input: keyboard: MCS5080: support suspend/resume.
Date: Mon, 15 Nov 2010 13:31:45 +0900
Message-ID: <4CE0B7B1.6060404@samsung.com>
Reply-To: riverful.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:47674 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757342Ab0KOEbr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 14 Nov 2010 23:31:47 -0500
Received: from epmmp2 (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LBW001XJSKX6RA0@mailout2.samsung.com> for
 linux-input@vger.kernel.org; Mon, 15 Nov 2010 13:31:45 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LBW00DD8SKY17@mmp2.samsung.com> for
 linux-input@vger.kernel.org; Mon, 15 Nov 2010 13:31:46 +0900 (KST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: kyungmin.park@samsung.com

This patch supports suspend/resume functions for mcs5080 touchkey
driver.

Signed-off-by: Heungjun Kim <riverful.kim@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/input/keyboard/mcs_touchkey.c |   41 +++++++++++++++++++++++++++++++++
 include/linux/i2c/mcs.h               |    1 +
 2 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/drivers/input/keyboard/mcs_touchkey.c b/drivers/input/keyboard/mcs_touchkey.c
index 63b849d..06385f5 100644
--- a/drivers/input/keyboard/mcs_touchkey.c
+++ b/drivers/input/keyboard/mcs_touchkey.c
@@ -45,6 +45,8 @@ struct mcs_touchkey_chip {
 };

 struct mcs_touchkey_data {
+       void (*poweron)(int);
+
        struct i2c_client *client;
        struct input_dev *input_dev;
        struct mcs_touchkey_chip chip;
@@ -168,6 +170,8 @@ static int __devinit mcs_touchkey_probe(struct i2c_client *client,

        if (pdata->cfg_pin)
                pdata->cfg_pin();
+       if (pdata->poweron)
+               data->poweron = pdata->poweron;

        error = request_threaded_irq(client->irq, NULL, mcs_touchkey_interrupt,
                        IRQF_TRIGGER_FALLING, client->dev.driver->name, data);
@@ -202,6 +206,41 @@ static int __devexit mcs_touchkey_remove(struct i2c_client *client)
        return 0;
 }

+#ifdef CONFIG_PM
+static int mcs_touchkey_suspend(struct i2c_client *client, pm_message_t mesg)
+{
+       struct mcs_touchkey_data *data = i2c_get_clientdata(client);
+
+       /* Disable the work */
+       disable_irq(client->irq);
+
+       /* Don't I2C operation since we don't know I2C bus is dead already */
+
+       /* Finally turn off the power */
+       if (data->poweron)
+               data->poweron(0);
+
+       return 0;
+}
+
+static int mcs_touchkey_resume(struct i2c_client *client)
+{
+       struct mcs_touchkey_data *data = i2c_get_clientdata(client);
+
+       /* Enable the device first */
+       if (data->poweron)
+               data->poweron(1);
+
+       /* Enable irq again */
+       enable_irq(client->irq);
+
+       return 0;
+}
+#else
+#define mcs_touchkey_suspend   NULL
+#define mcs_touchkey_resume    NULL
+#endif
+
 static const struct i2c_device_id mcs_touchkey_id[] = {
        { "mcs5000_touchkey", MCS5000_TOUCHKEY },
        { "mcs5080_touchkey", MCS5080_TOUCHKEY },
@@ -216,6 +255,8 @@ static struct i2c_driver mcs_touchkey_driver = {
        },
        .probe          = mcs_touchkey_probe,
        .remove         = __devexit_p(mcs_touchkey_remove),
+       .suspend        = mcs_touchkey_suspend,
+       .resume         = mcs_touchkey_resume,
        .id_table       = mcs_touchkey_id,
 };

diff --git a/include/linux/i2c/mcs.h b/include/linux/i2c/mcs.h
index 725ae7c..c4a3869 100644
--- a/include/linux/i2c/mcs.h
+++ b/include/linux/i2c/mcs.h
@@ -18,6 +18,7 @@
 #define MCS_KEY_CODE(v)                ((v) & 0xffff)

 struct mcs_platform_data {
+       void (*poweron)(int);
        void (*cfg_pin)(void);

        /* touchscreen */
--
1.7.0.4
