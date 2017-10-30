From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 4/4] Input: soc_button_array - Suppress power button presses during suspend
Date: Mon, 30 Oct 2017 18:40:50 +0100
Message-ID: <20171030174050.30375-4-hdegoede@redhat.com>
References: <20171030174050.30375-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60106 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932723AbdJ3Rk7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 30 Oct 2017 13:40:59 -0400
In-Reply-To: <20171030174050.30375-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org

If the power-button is pressed to wakeup the laptop/tablet from suspend
and we report a KEY_POWER event to userspace when woken up this will cause
userspace to immediately suspend the system again which is undesirable.

This commit sets the new suppress_evdev_events_on_wakeup flag in the
gpio_keys_button struct for the power-button suppressing the undesirable
KEY_POWER input events on wake-up.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v3:
-Adjust for the renaming of the flag to suppress_evdev_events_on_wakeup
-Explicitly init the flag for all members of the soc_button_PNP0C40 array
---
 drivers/input/misc/soc_button_array.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
index 23520df7650f..39f06979961f 100644
--- a/drivers/input/misc/soc_button_array.c
+++ b/drivers/input/misc/soc_button_array.c
@@ -27,6 +27,7 @@ struct soc_button_info {
 	unsigned int event_code;
 	bool autorepeat;
 	bool wakeup;
+	bool suppress_evdev_events_on_wakeup;
 };
 
 /*
@@ -100,6 +101,8 @@ soc_button_device_create(struct platform_device *pdev,
 		gpio_keys[n_buttons].active_low = 1;
 		gpio_keys[n_buttons].desc = info->name;
 		gpio_keys[n_buttons].wakeup = info->wakeup;
+		gpio_keys[n_buttons].suppress_evdev_events_on_wakeup =
+					info->suppress_evdev_events_on_wakeup;
 		/* These devices often use cheap buttons, use 50 ms debounce */
 		gpio_keys[n_buttons].debounce_interval = 50;
 		n_buttons++;
@@ -185,6 +188,7 @@ static int soc_button_parse_btn_desc(struct device *dev,
 		info->name = "power";
 		info->event_code = KEY_POWER;
 		info->wakeup = true;
+		info->suppress_evdev_events_on_wakeup = true;
 	} else if (upage == 0x07 && usage == 0xe3) {
 		info->name = "home";
 		info->event_code = KEY_LEFTMETA;
@@ -369,11 +373,11 @@ static int soc_button_probe(struct platform_device *pdev)
  * Platforms"
  */
 static struct soc_button_info soc_button_PNP0C40[] = {
-	{ "power", 0, EV_KEY, KEY_POWER, false, true },
-	{ "home", 1, EV_KEY, KEY_LEFTMETA, false, true },
-	{ "volume_up", 2, EV_KEY, KEY_VOLUMEUP, true, false },
-	{ "volume_down", 3, EV_KEY, KEY_VOLUMEDOWN, true, false },
-	{ "rotation_lock", 4, EV_SW, SW_ROTATE_LOCK, false, false },
+	{ "power", 0, EV_KEY, KEY_POWER, false, true, true },
+	{ "home", 1, EV_KEY, KEY_LEFTMETA, false, true, false },
+	{ "volume_up", 2, EV_KEY, KEY_VOLUMEUP, true, false, false },
+	{ "volume_down", 3, EV_KEY, KEY_VOLUMEDOWN, true, false, false },
+	{ "rotation_lock", 4, EV_SW, SW_ROTATE_LOCK, false, false, false },
 	{ }
 };
 
-- 
2.14.2

