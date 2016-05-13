From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 4/6] Input - soc_button_array: allow to specify active_low
Date: Fri, 13 May 2016 18:05:52 +0200
Message-ID: <1463155554-11747-5-git-send-email-benjamin.tissoires@redhat.com>
References: <1463155554-11747-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39607 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753290AbcEMQGF (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 13 May 2016 12:06:05 -0400
In-Reply-To: <1463155554-11747-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Bastien Nocera <hadess@hadess.net>, Lejun Zhu <lejun.zhu@linux.intel.com>, Fabio Estevam <festevam@gmail.com>

The Surface 3 has the "Windows" key active high, and not low. We need
a way to specify it in the description.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
new in v2

 drivers/input/misc/soc_button_array.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
index cb5cce3..077e06e4 100644
--- a/drivers/input/misc/soc_button_array.c
+++ b/drivers/input/misc/soc_button_array.c
@@ -34,6 +34,7 @@ struct soc_button_info {
 	unsigned int event_code;
 	bool autorepeat;
 	bool wakeup;
+	bool active_low;
 };
 
 /*
@@ -106,7 +107,7 @@ soc_button_device_create(struct platform_device *pdev,
 		gpio_keys[n_buttons].type = info->event_type;
 		gpio_keys[n_buttons].code = info->event_code;
 		gpio_keys[n_buttons].gpio = gpio;
-		gpio_keys[n_buttons].active_low = 1;
+		gpio_keys[n_buttons].active_low = info->active_low;
 		gpio_keys[n_buttons].desc = info->name;
 		gpio_keys[n_buttons].wakeup = info->wakeup;
 		n_buttons++;
@@ -206,11 +207,11 @@ static int soc_button_probe(struct platform_device *pdev)
 }
 
 static struct soc_button_info soc_button_PNP0C40[] = {
-	{ "power", 0, EV_KEY, KEY_POWER, false, true },
-	{ "home", 1, EV_KEY, KEY_LEFTMETA, false, true },
-	{ "volume_up", 2, EV_KEY, KEY_VOLUMEUP, true, false },
-	{ "volume_down", 3, EV_KEY, KEY_VOLUMEDOWN, true, false },
-	{ "rotation_lock", 4, EV_SW, SW_ROTATE_LOCK, false, false },
+	{ "power", 0, EV_KEY, KEY_POWER, false, true, true },
+	{ "home", 1, EV_KEY, KEY_LEFTMETA, false, true, true },
+	{ "volume_up", 2, EV_KEY, KEY_VOLUMEUP, true, false, true },
+	{ "volume_down", 3, EV_KEY, KEY_VOLUMEDOWN, true, false, true },
+	{ "rotation_lock", 4, EV_SW, SW_ROTATE_LOCK, false, false, true },
 	{ }
 };
 
-- 
2.5.0

