From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/2] Input: soc_button_array - Set input device name
Date: Mon,  9 Jan 2017 18:57:06 +0100
Message-ID: <20170109175707.12854-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49034 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1422779AbdAIR5K (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 9 Jan 2017 12:57:10 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Gregor Riepl <onitake@gmail.com>, linux-input@vger.kernel.org

On some tablets using the soc_button_array driver the buttons do not
follow the standard home, power, volume_up, volume_down, rotation_lock
button order as published by Microsoft.

We can use the existing udev hwdb mechanism to fix this up, but then
the created devices must have a unique name, therefor this commit adds
a unique name for the 2 created gpio-keys input devices.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/misc/soc_button_array.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
index 9bc1b20..d2e5186 100644
--- a/drivers/input/misc/soc_button_array.c
+++ b/drivers/input/misc/soc_button_array.c
@@ -113,6 +113,11 @@ soc_button_device_create(struct platform_device *pdev,
 	gpio_keys_pdata->nbuttons = n_buttons;
 	gpio_keys_pdata->rep = autorepeat;
 
+	if (autorepeat)
+		gpio_keys_pdata->name = "SoC Button Array (autorepeat buttons)";
+	else
+		gpio_keys_pdata->name = "SoC Button Array";
+
 	pd = platform_device_alloc("gpio-keys", PLATFORM_DEVID_AUTO);
 	if (!pd) {
 		error = -ENOMEM;
-- 
2.9.3

