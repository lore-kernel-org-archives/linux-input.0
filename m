From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/4] Input: silead_gsl1680: gpiod_get returning -EBUSY is not an error
Date: Fri,  9 Dec 2016 11:35:20 +0100
Message-ID: <20161209103522.3833-2-hdegoede@redhat.com>
References: <20161209103522.3833-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46144 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932349AbcLIKf1 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 9 Dec 2016 05:35:27 -0500
In-Reply-To: <20161209103522.3833-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Gregor Riepl <onitake@gmail.com>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

ACPI gpios may return -EBUSY this means that the gpio is owned by the
ACPI code, and will be set / cleared as needed by the ACPI code.

Treat gpiod_get returning -EBUSY as not having a gpio, fixing the
driver not loading on tablets where this happens.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/touchscreen/silead.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/touchscreen/silead.c b/drivers/input/touchscreen/silead.c
index f502c84..4387cd8 100644
--- a/drivers/input/touchscreen/silead.c
+++ b/drivers/input/touchscreen/silead.c
@@ -467,6 +467,14 @@ static int silead_ts_probe(struct i2c_client *client,
 
 	/* Power GPIO pin */
 	data->gpio_power = devm_gpiod_get_optional(dev, "power", GPIOD_OUT_LOW);
+#ifdef CONFIG_ACPI
+	/*
+	 * ACPI gpios may return -EBUSY this means that the gpio is owned by
+	 * the ACPI code, and will be set / cleared by the ACPI code.
+	 */
+	if (IS_ERR(data->gpio_power) && PTR_ERR(data->gpio_power) == -EBUSY)
+		data->gpio_power = NULL;
+#endif
 	if (IS_ERR(data->gpio_power)) {
 		if (PTR_ERR(data->gpio_power) != -EPROBE_DEFER)
 			dev_err(dev, "Shutdown GPIO request failed\n");
-- 
2.9.3

