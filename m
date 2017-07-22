From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 2/2] Input: soc_button_array - Suppress power button presses during suspend
Date: Sat, 22 Jul 2017 20:46:41 +0200
Message-ID: <20170722184641.12468-2-hdegoede@redhat.com>
References: <20170722184641.12468-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36792 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752265AbdGVSqo (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 22 Jul 2017 14:46:44 -0400
In-Reply-To: <20170722184641.12468-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org

If the power-button is pressed to wakeup the laptop/tablet from suspend
and we report a KEY_POWER event to userspace when woken up this will cause
userspace to immediately suspend the system again which is undesirable.

This commit sets the new no_wakeup_events flag in the gpio_keys_button
struct for the power-button suppressing the undesirable KEY_POWER input
events on wake-up.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-New patch in v2 of this patch-set
---
 drivers/input/misc/soc_button_array.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
index f600f3a7a3c6..27b99831cb97 100644
--- a/drivers/input/misc/soc_button_array.c
+++ b/drivers/input/misc/soc_button_array.c
@@ -27,6 +27,7 @@ struct soc_button_info {
 	unsigned int event_code;
 	bool autorepeat;
 	bool wakeup;
+	bool no_wakeup_events;
 };
 
 /*
@@ -100,6 +101,7 @@ soc_button_device_create(struct platform_device *pdev,
 		gpio_keys[n_buttons].active_low = 1;
 		gpio_keys[n_buttons].desc = info->name;
 		gpio_keys[n_buttons].wakeup = info->wakeup;
+		gpio_keys[n_buttons].no_wakeup_events = info->no_wakeup_events;
 		/* These devices often use cheap buttons, use 50 ms debounce */
 		gpio_keys[n_buttons].debounce_interval = 50;
 		n_buttons++;
@@ -185,6 +187,7 @@ static int soc_button_parse_btn_desc(struct device *dev,
 		info->name = "power";
 		info->event_code = KEY_POWER;
 		info->wakeup = true;
+		info->no_wakeup_events = true;
 	} else if (upage == 0x07 && usage == 0xe3) {
 		info->name = "home";
 		info->event_code = KEY_LEFTMETA;
@@ -369,7 +372,7 @@ static int soc_button_probe(struct platform_device *pdev)
  * Platforms"
  */
 static struct soc_button_info soc_button_PNP0C40[] = {
-	{ "power", 0, EV_KEY, KEY_POWER, false, true },
+	{ "power", 0, EV_KEY, KEY_POWER, false, true, true },
 	{ "home", 1, EV_KEY, KEY_LEFTMETA, false, true },
 	{ "volume_up", 2, EV_KEY, KEY_VOLUMEUP, true, false },
 	{ "volume_down", 3, EV_KEY, KEY_VOLUMEDOWN, true, false },
-- 
2.13.0

