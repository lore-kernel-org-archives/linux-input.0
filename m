From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 1/4] Input: icn8318 - Make wake gpio optional
Date: Thu,  6 Jul 2017 22:49:27 +0200
Message-ID: <20170706204930.4241-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45702 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752776AbdGFUtf (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 6 Jul 2017 16:49:35 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

On ACPI platforms the wake GPIO is unused, make it optional to avoid
probe failure on those platforms.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-No Changes
Changes in v3:
-Make wake_gpio optional instead of completely disabling gpio support for
 ACPI based platforms
---
 drivers/input/touchscreen/chipone_icn8318.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/chipone_icn8318.c b/drivers/input/touchscreen/chipone_icn8318.c
index 0bf14067c167..27df6ca3a8a3 100644
--- a/drivers/input/touchscreen/chipone_icn8318.c
+++ b/drivers/input/touchscreen/chipone_icn8318.c
@@ -137,7 +137,8 @@ static int icn8318_start(struct input_dev *dev)
 	struct icn8318_data *data = input_get_drvdata(dev);
 
 	enable_irq(data->client->irq);
-	gpiod_set_value_cansleep(data->wake_gpio, 1);
+	if (data->wake_gpio)
+		gpiod_set_value_cansleep(data->wake_gpio, 1);
 
 	return 0;
 }
@@ -149,7 +150,8 @@ static void icn8318_stop(struct input_dev *dev)
 	disable_irq(data->client->irq);
 	i2c_smbus_write_byte_data(data->client, ICN8318_REG_POWER,
 				  ICN8318_POWER_HIBERNATE);
-	gpiod_set_value_cansleep(data->wake_gpio, 0);
+	if (data->wake_gpio)
+		gpiod_set_value_cansleep(data->wake_gpio, 0);
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -197,7 +199,7 @@ static int icn8318_probe(struct i2c_client *client,
 	if (!data)
 		return -ENOMEM;
 
-	data->wake_gpio = devm_gpiod_get(dev, "wake", GPIOD_OUT_LOW);
+	data->wake_gpio = devm_gpiod_get_optional(dev, "wake", GPIOD_OUT_LOW);
 	if (IS_ERR(data->wake_gpio)) {
 		error = PTR_ERR(data->wake_gpio);
 		if (error != -EPROBE_DEFER)
-- 
2.13.0

