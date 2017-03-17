From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 1/2] Input: soc_button_array: Get rid of MAX_NBUTTONS
Date: Fri, 17 Mar 2017 15:09:41 +0100
Message-ID: <20170317140942.24368-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38889 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751064AbdCQORr (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 17 Mar 2017 10:17:47 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

Count how much gpio_keys we actually need, this is a preparation patch
for adding support for the new Win10 / ACPI-6.0 "Generic Buttons Device"
support.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/misc/soc_button_array.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
index 0cd2cac..b8769f6 100644
--- a/drivers/input/misc/soc_button_array.c
+++ b/drivers/input/misc/soc_button_array.c
@@ -20,13 +20,6 @@
 #include <linux/gpio.h>
 #include <linux/platform_device.h>
 
-/*
- * Definition of buttons on the tablet. The ACPI index of each button
- * is defined in section 2.8.7.2 of "Windows ACPI Design Guide for SoC
- * Platforms"
- */
-#define MAX_NBUTTONS	5
-
 struct soc_button_info {
 	const char *name;
 	int acpi_index;
@@ -79,14 +72,19 @@ soc_button_device_create(struct platform_device *pdev,
 	int gpio;
 	int error;
 
+	for (info = button_info; info->name; info++)
+		if (info->autorepeat == autorepeat)
+			n_buttons++;
+
 	gpio_keys_pdata = devm_kzalloc(&pdev->dev,
 				       sizeof(*gpio_keys_pdata) +
-					sizeof(*gpio_keys) * MAX_NBUTTONS,
+					sizeof(*gpio_keys) * n_buttons,
 				       GFP_KERNEL);
 	if (!gpio_keys_pdata)
 		return ERR_PTR(-ENOMEM);
 
 	gpio_keys = (void *)(gpio_keys_pdata + 1);
+	n_buttons = 0;
 
 	for (info = button_info; info->name; info++) {
 		if (info->autorepeat != autorepeat)
@@ -200,6 +198,11 @@ static int soc_button_probe(struct platform_device *pdev)
 	return 0;
 }
 
+/*
+ * Definition of buttons on the tablet. The ACPI index of each button
+ * is defined in section 2.8.7.2 of "Windows ACPI Design Guide for SoC
+ * Platforms"
+ */
 static struct soc_button_info soc_button_PNP0C40[] = {
 	{ "power", 0, EV_KEY, KEY_POWER, false, true },
 	{ "home", 1, EV_KEY, KEY_LEFTMETA, false, true },
-- 
2.9.3

